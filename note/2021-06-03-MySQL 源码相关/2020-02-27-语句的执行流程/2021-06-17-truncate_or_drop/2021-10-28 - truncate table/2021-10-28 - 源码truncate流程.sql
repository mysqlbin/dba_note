/**
Truncates a table for MySQL.
@param table		table being truncated
@param trx		transaction covering the truncate
@return	error code or DB_SUCCESS */
dberr_t
row_truncate_table_for_mysql(
	dict_table_t* table,
	trx_t* trx)
{
	bool	is_file_per_table = dict_table_is_file_per_table(table);
	dberr_t		err;
#ifdef UNIV_DEBUG
	ulint		old_space = table->space;
#endif /* UNIV_DEBUG */
	TruncateLogger*	logger = NULL;

	/* Understanding the truncate flow.

	Step-1: Perform intiial sanity check to ensure table can be truncated.
	This would include check for tablespace discard status, ibd file
	missing, etc ....

	Step-2: Start transaction (only for non-temp table as temp-table don't
	modify any data on disk doesn't need transaction object).

	Step-3: Validate ownership of needed locks (Exclusive lock).
	Ownership will also ensure there is no active SQL queries, INSERT,
	SELECT, .....

	Step-4: Stop all the background process associated with table.

	Step-5: There are few foreign key related constraint under which
	we can't truncate table (due to referential integrity unless it is
	turned off). Ensure this condition is satisfied.

	Step-6: Truncate operation can be rolled back in case of error
	till some point. Associate rollback segment to record undo log.

	Step-7: Generate new table-id.
	Why we need new table-id ?
	Purge and rollback case: we assign a new table id for the table.
	Since purge and rollback look for the table based on the table id,
	they see the table as 'dropped' and discard their operations.

	Step-8: Log information about tablespace which includes
	table and index information. If there is a crash in the next step
	then during recovery we will attempt to fixup the operation.

	Step-9: Drop all indexes (this include freeing of the pages
	associated with them).

	Step-10: Re-create new indexes.

	Step-11: Update new table-id to in-memory cache (dictionary),
	on-disk (INNODB_SYS_TABLES). INNODB_SYS_INDEXES also needs to
	be updated to reflect updated root-page-no of new index created
	and updated table-id.

	Step-12: Cleanup Stage. Reset auto-inc value to 1.
	Release all the locks.
	Commit the transaction. Update trx operation state.

	Notes:
	- On error, log checkpoint is done followed writing of magic number to
	truncate log file. If servers crashes after truncate, fix-up action
	will not be applied.

	- log checkpoint is done before starting truncate table to ensure
	that previous REDO log entries are not applied if current truncate
	crashes. Consider following use-case:
	 - create table .... insert/load table .... truncate table (crash)
	 - on restart table is restored .... truncate table (crash)
	 - on restart (assuming default log checkpoint is not done) will have
	   2 REDO log entries for same table. (Note 2 REDO log entries
	   for different table is not an issue).
	For system-tablespace we can't truncate the tablespace so we need
	to initiate a local cleanup that involves dropping of indexes and
	re-creating them. If we apply stale entry we might end-up issuing
	drop on wrong indexes.

	- Insert buffer: TRUNCATE TABLE is analogous to DROP TABLE,
	so we do not have to remove insert buffer records, as the
	insert buffer works at a low level. If a freed page is later
	reallocated, the allocator will remove the ibuf entries for
	it. When we prepare to truncate *.ibd files, we remove all entries
	for the table in the insert buffer tree. This is not strictly
	necessary, but we can free up some space in the system tablespace.

	- Linear readahead and random readahead: we use the same
	method as in 3) to discard ongoing operations. (This is only
	relevant for TRUNCATE TABLE by TRUNCATE TABLESPACE.)
	Ensure that the table will be dropped by trx_rollback_active() in
	case of a crash.
	*/

	/*-----------------------------------------------------------------*/
	/* Step-1: Perform intiial sanity check to ensure table can be
	truncated. This would include check for tablespace discard status,
	ibd file missing, etc .... */
	err = row_truncate_sanity_checks(table);
	if (err != DB_SUCCESS) {
		return(err);

	}

	/* Step-2: Start transaction (only for non-temp table as temp-table
	don't modify any data on disk doesn't need transaction object). */
	if (!dict_table_is_temporary(table)) {
		/* Avoid transaction overhead for temporary table DDL. */
		trx_start_for_ddl(trx, TRX_DICT_OP_TABLE);
	}

	/* Step-3: Validate ownership of needed locks (Exclusive lock).
	Ownership will also ensure there is no active SQL queries, INSERT,
	SELECT, .....*/
	trx->op_info = "truncating table";
	ut_a(trx->dict_operation_lock_mode == 0);
	row_mysql_lock_data_dictionary(trx);
	ut_ad(mutex_own(&dict_sys->mutex));
	ut_ad(rw_lock_own(dict_operation_lock, RW_LOCK_X));

	/* Step-4: Stop all the background process associated with table. */
	dict_stats_wait_bg_to_stop_using_table(table, trx);
	if (table->fts) {
		/* Remove from FTS optimize thread. Unlock is needed to allow
		finishing background operations in progress. */
		row_mysql_unlock_data_dictionary(trx);
		fts_optimize_remove_table(table);
		row_mysql_lock_data_dictionary(trx);
	}

	/* Step-5: There are few foreign key related constraint under which
	we can't truncate table (due to referential integrity unless it is
	turned off). Ensure this condition is satisfied. */
	ulint	fsp_flags = ULINT_UNDEFINED;
	err = row_truncate_foreign_key_checks(table, trx);
	if (err != DB_SUCCESS) {
		trx_rollback_to_savepoint(trx, NULL);
		return(row_truncate_complete(
				table, trx, fsp_flags, logger, err));
	}

	/* Check if memcached DML is running on this table. if is, we don't
	allow truncate this table. */
	if (table->memcached_sync_count != 0) {
		ib::error() << "Cannot truncate table "
			<< table->name
			<< " by DROP+CREATE because there are memcached"
			" operations running on it.";
		err = DB_ERROR;
		trx_rollback_to_savepoint(trx, NULL);
		return(row_truncate_complete(
				table, trx, fsp_flags, logger, err));
	} else {
                /* We need to set this counter to -1 for blocking
                memcached operations. */
		table->memcached_sync_count = DICT_TABLE_IN_DDL;
        }

	/* Remove all locks except the table-level X lock. */
	lock_remove_all_on_table(table, FALSE);
	trx->table_id = table->id;
	trx_set_dict_operation(trx, TRX_DICT_OP_TABLE);

	/* Step-6: Truncate operation can be rolled back in case of error
	till some point. Associate rollback segment to record undo log. */
	if (!dict_table_is_temporary(table)) {

		/* Temporary tables don't need undo logging for autocommit stmt.
		On crash (i.e. mysql restart) temporary tables are anyway not
		accessible. */
		mutex_enter(&trx->undo_mutex);

		err = trx_undo_assign_undo(
			trx, &trx->rsegs.m_redo, TRX_UNDO_UPDATE);

		mutex_exit(&trx->undo_mutex);

		DBUG_EXECUTE_IF("ib_err_trunc_assigning_undo_log",
				err = DB_ERROR;);
		if (err != DB_SUCCESS) {
			trx_rollback_to_savepoint(trx, NULL);
			return(row_truncate_complete(
				table, trx, fsp_flags, logger, err));
		}
	}

	/* Step-7: Generate new table-id.
	Why we need new table-id ?
	Purge and rollback: we assign a new table id for the
	table. Since purge and rollback look for the table based on
	the table id, they see the table as 'dropped' and discard
	their operations. */
	table_id_t	new_id;
	dict_hdr_get_new_id(&new_id, NULL, NULL, table, false);

	/* Check if table involves FTS index. */
	bool	has_internal_doc_id =
		dict_table_has_fts_index(table)
		|| DICT_TF2_FLAG_IS_SET(table, DICT_TF2_FTS_HAS_DOC_ID);

	bool	no_redo = is_file_per_table && !has_internal_doc_id;

	/* Step-8: Log information about tablespace which includes
	table and index information. If there is a crash in the next step
	then during recovery we will attempt to fixup the operation. */

	/* Lock all index trees for this table, as we will truncate
	the table/index and possibly change their metadata. All
	DML/DDL are blocked by table level X lock, with a few exceptions
	such as queries into information schema about the table,
	MySQL could try to access index stats for this kind of query,
	we need to use index locks to sync up */
	dict_table_x_lock_indexes(table);

	if (!dict_table_is_temporary(table)) {

		if (is_file_per_table) {

			err = row_truncate_prepare(table, &fsp_flags);

			DBUG_EXECUTE_IF("ib_err_trunc_preparing_for_truncate",
					err = DB_ERROR;);

			if (err != DB_SUCCESS) {
				row_truncate_rollback(
					table, trx, new_id,
					has_internal_doc_id,
					no_redo, false, true);
				return(row_truncate_complete(
					table, trx, fsp_flags, logger, err));
			}
		} else {
			fsp_flags = fil_space_get_flags(table->space);

			DBUG_EXECUTE_IF("ib_err_trunc_preparing_for_truncate",
					fsp_flags = ULINT_UNDEFINED;);

			if (fsp_flags == ULINT_UNDEFINED) {
				row_truncate_rollback(
					table, trx, new_id,
					has_internal_doc_id,
					no_redo, false, true);
				return(row_truncate_complete(
						table, trx, fsp_flags,
						logger, DB_ERROR));
			}
		}

		logger = UT_NEW_NOKEY(TruncateLogger(
				table, fsp_flags, new_id));

		err = logger->init();
		if (err != DB_SUCCESS) {
			row_truncate_rollback(
				table, trx, new_id, has_internal_doc_id,
				no_redo, false, true);
			return(row_truncate_complete(
				table, trx, fsp_flags, logger, DB_ERROR));

		}

		err = SysIndexIterator().for_each(*logger);
		if (err != DB_SUCCESS) {
			row_truncate_rollback(
				table, trx, new_id, has_internal_doc_id,
				no_redo, false, true);
			return(row_truncate_complete(
				table, trx, fsp_flags, logger, DB_ERROR));

		}

		ut_ad(logger->debug());

		err = logger->log();

		if (err != DB_SUCCESS) {
			row_truncate_rollback(
				table, trx, new_id, has_internal_doc_id,
				no_redo, false, true);
			return(row_truncate_complete(
				table, trx, fsp_flags, logger, DB_ERROR));
		}
	}

	DBUG_EXECUTE_IF("ib_trunc_crash_after_redo_log_write_complete",
			log_buffer_flush_to_disk();
			os_thread_sleep(3000000);
			DBUG_SUICIDE(););

	/* Step-9: Drop all indexes (free index pages associated with these
	indexes) */
	if (!dict_table_is_temporary(table)) {

		DropIndex	dropIndex(table, no_redo);

		err = SysIndexIterator().for_each(dropIndex);

		if (err != DB_SUCCESS) {

			row_truncate_rollback(
				table, trx, new_id, has_internal_doc_id,
				no_redo, true, true);

			return(row_truncate_complete(
				table, trx, fsp_flags, logger, err));
		}

	} else {
		/* For temporary tables we don't have entries in SYSTEM TABLES*/
		for (dict_index_t* index = UT_LIST_GET_FIRST(table->indexes);
		     index != NULL;
		     index = UT_LIST_GET_NEXT(indexes, index)) {

			err = dict_truncate_index_tree_in_mem(index);

			if (err != DB_SUCCESS) {
				row_truncate_rollback(
					table, trx, new_id, has_internal_doc_id,
					no_redo, true, true);
				return(row_truncate_complete(
					table, trx, fsp_flags, logger, err));
			}

			DBUG_EXECUTE_IF(
				"ib_trunc_crash_during_drop_index_temp_table",
				log_buffer_flush_to_disk();
				os_thread_sleep(2000000);
				DBUG_SUICIDE(););
		}
	}

	if (is_file_per_table
	    && !dict_table_is_temporary(table)
	    && fsp_flags != ULINT_UNDEFINED) {

		/* A single-table tablespace has initially
		FIL_IBD_FILE_INITIAL_SIZE number of pages allocated and an
		extra page is allocated for each of the indexes present. But in
		the case of clust index 2 pages are allocated and as one is
		covered in the calculation as part of table->indexes.count we
		take care of the other page by adding 1. */
		ulint	space_size = table->indexes.count +
				FIL_IBD_FILE_INITIAL_SIZE + 1;

		if (has_internal_doc_id) {
			/* Since aux tables are created for fts indexes and
			they use seperate tablespaces. */
			space_size -= ib_vector_size(table->fts->indexes);
		}

		fil_reinit_space_header_for_table(table, space_size, trx);
	}

	DBUG_EXECUTE_IF("ib_trunc_crash_with_intermediate_log_checkpoint",
			log_buffer_flush_to_disk();
			os_thread_sleep(2000000);
			log_checkpoint(TRUE, TRUE);
			os_thread_sleep(1000000);
			DBUG_SUICIDE(););

	DBUG_EXECUTE_IF("ib_trunc_crash_drop_reinit_done_create_to_start",
			log_buffer_flush_to_disk();
			os_thread_sleep(2000000);
			DBUG_SUICIDE(););

	/* Step-10: Re-create new indexes. */
	if (!dict_table_is_temporary(table)) {

		CreateIndex	createIndex(table, no_redo);

		err = SysIndexIterator().for_each(createIndex);

		if (err != DB_SUCCESS) {

			row_truncate_rollback(
				table, trx, new_id, has_internal_doc_id,
				no_redo, true, true);

			return(row_truncate_complete(
				table, trx, fsp_flags, logger, err));
		}
	}

	/* Done with index truncation, release index tree locks,
	subsequent work relates to table level metadata change */
	dict_table_x_unlock_indexes(table);

	if (has_internal_doc_id) {

		err = row_truncate_fts(table, new_id, trx);

		if (err != DB_SUCCESS) {

			row_truncate_rollback(
				table, trx, new_id, has_internal_doc_id,
				no_redo, true, false);

			return(row_truncate_complete(
				table, trx, fsp_flags, logger, err));
		}
	}

	/* Step-11: Update new table-id to in-memory cache (dictionary),
	on-disk (INNODB_SYS_TABLES). INNODB_SYS_INDEXES also needs to
	be updated to reflect updated root-page-no of new index created
	and updated table-id. */
	if (dict_table_is_temporary(table)) {

		dict_table_change_id_in_cache(table, new_id);
		err = DB_SUCCESS;

	} else {

		/* If this fails then we are in an inconsistent state and
		the results are undefined. */
		ut_ad(old_space == table->space);

		err = row_truncate_update_system_tables(
			table, new_id, has_internal_doc_id, no_redo, trx);

		if (err != DB_SUCCESS) {
			return(row_truncate_complete(
				table, trx, fsp_flags, logger, err));
		}
	}

	DBUG_EXECUTE_IF("ib_trunc_crash_on_updating_dict_sys_info",
			log_buffer_flush_to_disk();
			os_thread_sleep(2000000);
			DBUG_SUICIDE(););

	/* Step-12: Cleanup Stage. Reset auto-inc value to 1.
	Release all the locks.
	Commit the transaction. Update trx operation state. */
	dict_table_autoinc_lock(table);
	dict_table_autoinc_initialize(table, 1);
	dict_table_autoinc_unlock(table);

	if (trx_is_started(trx)) {

		trx_commit_for_mysql(trx);
	}

	return(row_truncate_complete(table, trx, fsp_flags, logger, err));
}