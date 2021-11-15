alter_stats_norebuild  D:\mysqlbin\mysql_source_code\mysql-5.7.26\storage\innobase\handler\handler0alter.cc
	-> dict_stats_drop_index  D:\mysqlbin\mysql_source_code\mysql-5.7.26\storage\innobase\dict\dict0stats.cc
	  
	
dict_stats_drop_index	
	-- 从系统表mysql/innodb_index_stats中删除索引的统计信息
	ret = dict_stats_exec_sql(
		pinfo,
		"PROCEDURE DROP_INDEX_STATS () IS\n"
		"BEGIN\n"
		"DELETE FROM \"" INDEX_STATS_NAME "\" WHERE\n"
		"database_name = :database_name AND\n"
		"table_name = :table_name AND\n"
		"index_name = :index_name;\n"
		"END;\n", NULL);
		
		
/** Allows InnoDB to update internal structures with concurrent
writes blocked (provided that check_if_supported_inplace_alter()
did not return HA_ALTER_INPLACE_NO_LOCK).
This will be invoked before inplace_alter_table().

@param altered_table TABLE object for new version of table.
@param ha_alter_info Structure describing changes to be done
by ALTER TABLE and holding data used during in-place alter.

@retval true Failure
@retval false Success
*/


我估计是先对二级索引打删除标记(类似隐藏索引)，然后再对二级索引的记录打删除标记，最后purge二级索引的记录


D:\mysqlbin\mysql_source_code\mysql-5.7.26\storage\innobase\handler\handler0alter.cc

bool
ha_innobase::prepare_inplace_alter_table(

check_if_can_drop_indexes:
		/* Check if the indexes can be dropped. */
		/* 检查是否可以删除索引。 */
		
		/* Prevent a race condition between DROP INDEX and
		CREATE TABLE adding FOREIGN KEY constraints. */
		row_mysql_lock_data_dictionary(m_prebuilt->trx);

		if (!n_drop_index) {
			drop_index = NULL;
		} else {
			/* Flag all indexes that are to be dropped. */
			/* 标记所有要删除的索引 */
			for (ulint i = 0; i < n_drop_index; i++) {
				ut_ad(!drop_index[i]->to_be_dropped);
				drop_index[i]->to_be_dropped = 1;
			}
		}
		
		row_mysql_unlock_data_dictionary(m_prebuilt->trx);
	} else {
		drop_index = NULL;
	}

	n_rename_index = ha_alter_info->index_rename_count;
	rename_index = NULL
	
---------------------------------------------------------------------------------------------


ha_innobase::commit_inplace_alter_table
/** TRUE if the table is to be dropped, but not yet actually dropped
	(could in the background drop list). It is turned on at the beginning
	of row_drop_table_for_mysql() and turned off just before we start to
	update system tables for the drop. It is protected by
	dict_operation_lock. */
	unsigned				to_be_dropped:1;

	
ha_innobase::commit_inplace_alter_table
	-> commit_try_norebuild

		/* Drop any indexes that were requested to be dropped.
		Flag them in the data dictionary first. */
		
		/* 删除所有请求删除的索引。首先在数据字典中标记它们 */
		for (ulint i = 0; i < ctx->num_to_drop_index; i++) {
			dict_index_t*	index = ctx->drop_index[i];
			DBUG_ASSERT(index->is_committed());
			DBUG_ASSERT(index->table == ctx->new_table);
			DBUG_ASSERT(index->to_be_dropped);

			error = row_merge_rename_index_to_drop(
				trx, index->table->id, index->id);
			if (error != DB_SUCCESS) {
				sql_print_error(
					"InnoDB: rename index to drop: %lu\n",
					(ulong) error);
				DBUG_ASSERT(0);
				my_error(ER_INTERNAL_ERROR, MYF(0),
					 "rename index to drop");
				DBUG_RETURN(true);
			}
		}
		
/** Index name prefix in fast index creation, as a string constant */
#define TEMP_INDEX_PREFIX_STR	"\377"

	
ha_innobase::commit_inplace_alter_table
	-> commit_try_norebuild  /* 删除所有请求删除的索引。首先在数据字典中标记它们 */
		-> row_merge_rename_index_to_drop
			
			
			-- 重命名字典中要删除的索引。 数据字典必须被调用者独占锁定，因为事务还不会被提交
			
			/*********************************************************************//**
			Rename an index in the dictionary that is to be dropped. The data
			dictionary must have been locked exclusively by the caller, because
			the transaction will not be committed.
			@return DB_SUCCESS if all OK */
			dberr_t
			row_merge_rename_index_to_drop(
			/*===========================*/
				trx_t*		trx,		/*!< in/out: transaction */
				table_id_t	table_id,	/*!< in: table identifier */
				index_id_t	index_id)	/*!< in: index identifier */
			{
				dberr_t		err;
				pars_info_t*	info = pars_info_create();

				ut_ad(!srv_read_only_mode);

				/* We use the private SQL parser of Innobase to generate the
				query graphs needed in renaming indexes. */
				
				-- 将需要drop的index 在数据词典(information_schema.INNODB_SYS_INDEXES)里rename成 TEMP_INDEX_PREFIX 前缀+index名
				
				static const char rename_index[] =
					"PROCEDURE RENAME_INDEX_PROC () IS\n"
					"BEGIN\n"
					"UPDATE SYS_INDEXES SET NAME=CONCAT('"
					TEMP_INDEX_PREFIX_STR "',NAME)\n"
					"WHERE TABLE_ID = :tableid AND ID = :indexid;\n"
					"END;\n";

				ut_ad(trx);
				ut_a(trx->dict_operation_lock_mode == RW_X_LATCH);
				ut_ad(trx_get_dict_operation(trx) == TRX_DICT_OP_INDEX);

				trx->op_info = "renaming index to drop";

				pars_info_add_ull_literal(info, "tableid", table_id);
				pars_info_add_ull_literal(info, "indexid", index_id);

				err = que_eval_sql(info, rename_index, FALSE, trx);

				if (err != DB_SUCCESS) {
					/* Even though we ensure that DDL transactions are WAIT
					and DEADLOCK free, we could encounter other errors e.g.,
					DB_TOO_MANY_CONCURRENT_TRXS. */
					trx->error_state = DB_SUCCESS;

					ib::error() << "row_merge_rename_index_to_drop failed with"
						" error " << err;
				}

				trx->op_info = "";

				return(err);
			}			
			
			
commit_cache_norebuild   // index->page = FIL_NULL
	-> row_merge_drop_indexes_dict
	-> dict_index_remove_from_cache
		
	
	
	
	if (ctx->num_to_drop_index) {
		/* Really drop the indexes that were dropped.
		The transaction had to be committed first
		(after renaming the indexes), so that in the
		event of a crash, crash recovery will drop the
		indexes, because it drops all indexes whose
		names start with TEMP_INDEX_PREFIX. Once we
		have started dropping an index tree, there is
		no way to roll it back. */
	
		真正删除被删除的索引。
		事务必须首先提交（在重命名索引之后），以便在发生崩溃时，崩溃恢复将删除索引，因为它删除名称以 TEMP_INDEX_PREFIX 开头的所有索引。
		一旦我们开始删除索引树，就无法回滚它
		
		for (ulint i = 0; i < ctx->num_to_drop_index; i++) {
			dict_index_t*	index = ctx->drop_index[i];
			DBUG_ASSERT(index->is_committed());
			DBUG_ASSERT(index->table == ctx->new_table);
			DBUG_ASSERT(index->to_be_dropped);

			
			/* Mark the index dropped in the data dictionary cache. */
			rw_lock_x_lock(dict_index_get_lock(index));
			-- 设置索引页为 FIL_NULL
			index->page = FIL_NULL;
			rw_lock_x_unlock(dict_index_get_lock(index));
		}
		
		
		row_merge_drop_indexes_dict(trx, ctx->new_table->id);
		
		
		-- 从 dictionary cache 中删除索引
		for (ulint i = 0; i < ctx->num_to_drop_index; i++) {
			dict_index_t*	index = ctx->drop_index[i];
			DBUG_ASSERT(index->is_committed());
			DBUG_ASSERT(index->table == ctx->new_table);

			if (index->type & DICT_FTS) {
				DBUG_ASSERT(index->type == DICT_FTS
					    || (index->type
						& DICT_CORRUPT));
				DBUG_ASSERT(index->table->fts);
				fts_drop_index(index->table, index, trx);
			}

			dict_index_remove_from_cache(index->table, index);
		}
		
		trx_commit_for_mysql(trx);
		
		-------------------------------------------------------------------------
		
		删除在发生错误之前创建的索引。
		数据字典必须被调用者独占锁定，因为事务不会被提交。
		
		select * from information_schema.INNODB_SYS_FIELDS;
		select * from information_schema.INNODB_SYS_INDEXES;
		
		/*********************************************************************//**
		Drop indexes that were created before an error occurred.
		The data dictionary must have been locked exclusively by the caller,
		because the transaction will not be committed. */
		void
		row_merge_drop_indexes_dict(
		/*========================*/
			trx_t*		trx,	/*!< in/out: dictionary transaction */
			table_id_t	table_id)/*!< in: table identifier */
		{
			static const char sql[] =
				"PROCEDURE DROP_INDEXES_PROC () IS\n"
				"ixid CHAR;\n"
				"found INT;\n"

				"DECLARE CURSOR index_cur IS\n"
				" SELECT ID FROM SYS_INDEXES\n"
				" WHERE TABLE_ID=:tableid AND\n"
				" SUBSTR(NAME,0,1)='" TEMP_INDEX_PREFIX_STR "'\n"
				"FOR UPDATE;\n"

				"BEGIN\n"
				"found := 1;\n"
				"OPEN index_cur;\n"
				"WHILE found = 1 LOOP\n"
				"  FETCH index_cur INTO ixid;\n"
				"  IF (SQL % NOTFOUND) THEN\n"
				"    found := 0;\n"
				"  ELSE\n"
				"    DELETE FROM SYS_FIELDS WHERE INDEX_ID=ixid;\n"
				"    DELETE FROM SYS_INDEXES WHERE CURRENT OF index_cur;\n"
				"  END IF;\n"
				"END LOOP;\n"
				"CLOSE index_cur;\n"

				"END;\n";
			dberr_t		error;
			pars_info_t*	info;

			ut_ad(!srv_read_only_mode);
			ut_ad(mutex_own(&dict_sys->mutex));
			ut_ad(trx->dict_operation_lock_mode == RW_X_LATCH);
			ut_ad(trx_get_dict_operation(trx) == TRX_DICT_OP_INDEX);
			ut_ad(rw_lock_own(dict_operation_lock, RW_LOCK_X));

			/* It is possible that table->n_ref_count > 1 when
			locked=TRUE. In this case, all code that should have an open
			handle to the table be waiting for the next statement to execute,
			or waiting for a meta-data lock.

			A concurrent purge will be prevented by dict_operation_lock. */

			info = pars_info_create();
			pars_info_add_ull_literal(info, "tableid", table_id);
			trx->op_info = "dropping indexes";
			error = que_eval_sql(info, sql, FALSE, trx);

			switch (error) {
			case DB_SUCCESS:
				break;
			default:
				/* Even though we ensure that DDL transactions are WAIT
				and DEADLOCK free, we could encounter other errors e.g.,
				DB_TOO_MANY_CONCURRENT_TRXS. */
				ib::error() << "row_merge_drop_indexes_dict failed with error "
					<< error;
				/* fall through */
			case DB_TOO_MANY_CONCURRENT_TRXS:
				trx->error_state = DB_SUCCESS;
			}

			trx->op_info = "";
		}



/*********************************************************************//**
Evaluate the given SQL.
@return error code or DB_SUCCESS */
dberr_t
que_eval_sql(


que_run_threads


/**********************************************************************//**
Run a query thread until it finishes or encounters e.g. a lock wait. */
static
void
que_run_threads_low(



/** Drop the index tree associated with a row in SYS_INDEXES table.
@param[in,out]	rec	SYS_INDEXES record
@param[in,out]	pcur	persistent cursor on rec
@param[in,out]	mtr	mini-transaction
@return	whether freeing the B-tree was attempted */
bool
dict_drop_index_tree(




//row_merge_drop_indexes_dict：从数据词典SYS_INDEXES,SYS_FIELDS,中删除索引项相关记录。
row_merge_drop_indexes_dict
	—> que_eval_sql
		—> que_run_threads
			—> que_run_threads_low
				—> row_upd_step
					—> row_upd
						—> row_upd_clust_step
							—> dict_drop_index_tree   从系统表中删除记录，会触发释放索引树

-- 删除与 SYS_INDEXES 表中的行关联的索引树
/** Drop the index tree associated with a row in SYS_INDEXES table.
@param[in,out]	rec	SYS_INDEXES record
@param[in,out]	pcur	persistent cursor on rec
@param[in,out]	mtr	mini-transaction
@return	whether freeing the B-tree was attempted */   -- 是否尝试释放 B 树
bool
dict_drop_index_tree(
	rec_t*		rec,
	btr_pcur_t*	pcur,
	mtr_t*		mtr)
{
	const byte*	ptr;
	ulint		len;
	ulint		space;
	ulint		root_page_no;

	ut_ad(mutex_own(&dict_sys->mutex));
	ut_a(!dict_table_is_comp(dict_sys->sys_indexes));

	ptr = rec_get_nth_field_old(rec, DICT_FLD__SYS_INDEXES__PAGE_NO, &len);

	ut_ad(len == 4);

	btr_pcur_store_position(pcur, mtr);

	root_page_no = mtr_read_ulint(ptr, MLOG_4BYTES, mtr);

	if (root_page_no == FIL_NULL) {
		/* 如果索引根节点的数据页编号为NULL(每个索引页都有编号即page_no。), 树已经被释放 */
		-- 1颗B+树的根节点只有一个数据页。
		/* The tree has already been freed */

		return(false);
	}

	mlog_write_ulint(const_cast<byte*>(ptr), FIL_NULL, MLOG_4BYTES, mtr);

	ptr = rec_get_nth_field_old(
		rec, DICT_FLD__SYS_INDEXES__SPACE, &len);

	ut_ad(len == 4);

	space = mtr_read_ulint(ptr, MLOG_4BYTES, mtr);

	ptr = rec_get_nth_field_old(
		rec, DICT_FLD__SYS_INDEXES__ID, &len);

	ut_ad(len == 8);

	bool			found;
	const page_size_t	page_size(fil_space_get_page_size(space,
								  &found));

	if (!found) {
		/* It is a single table tablespace and the .ibd file is
		missing: do nothing */

		return(false);
	}

	/* If tablespace is scheduled for truncate, do not try to drop
	the indexes in that tablespace. There is a truncate fixup action
	which will take care of it. */
	
	-- 如果表空间被安排为截断，请不要尝试删除该表空间中的索引。 有一个 truncate fixup 操作会处理它。
	if (srv_is_tablespace_truncated(space)) {
		return(false);
	}
	
	-- 释放索引树
	btr_free_if_exists(page_id_t(space, root_page_no), page_size,
			   mach_read_from_8(ptr), mtr);

	return(true);
}



/** Check if tablespace is being truncated.
(Ignore system-tablespace as we don't re-create the tablespace
and so some of the action that are suppressed by this function
for independent tablespace are not applicable to system-tablespace).
@param	space_id	space_id to check for truncate action
@return true		if being truncated, false if not being
			truncated or tablespace is system-tablespace. */
bool
srv_is_tablespace_truncated(ulint space_id)
{
	if (is_system_tablespace(space_id)) {
		return(false);
	}

	return(truncate_t::is_tablespace_truncated(space_id)
	       || undo::Truncate::is_tablespace_truncated(space_id));

}











/**********************************************************************//**
Removes an index from the dictionary cache. */
void
dict_index_remove_from_cache(
/*=========================*/
	dict_table_t*	table,	/*!< in/out: table */
	dict_index_t*	index)	/*!< in, own: index */
{
	dict_index_remove_from_cache_low(table, index, FALSE);
}








/**********************************************************************//**
Removes an index from the dictionary cache. */
static
void
dict_index_remove_from_cache_low(
/*=============================*/
	dict_table_t*	table,		/*!< in/out: table */
	dict_index_t*	index,		/*!< in, own: index */
	ibool		lru_evict)	/*!< in: TRUE if index being evicted
					to make room in the table LRU list */
{
	lint		size;
	ulint		retries = 0;
	btr_search_t*	info;

	ut_ad(table && index);
	ut_ad(table->magic_n == DICT_TABLE_MAGIC_N);
	ut_ad(index->magic_n == DICT_INDEX_MAGIC_N);
	ut_ad(mutex_own(&dict_sys->mutex));

	/* No need to acquire the dict_index_t::lock here because
	there can't be any active operations on this index (or table). */

	if (index->online_log) {
		ut_ad(index->online_status == ONLINE_INDEX_CREATION);
		row_log_free(index->online_log);
	}

	/* We always create search info whether or not adaptive
	hash index is enabled or not. */
	info = btr_search_get_info(index);
	ut_ad(info);

	/* We are not allowed to free the in-memory index struct
	dict_index_t until all entries in the adaptive hash index
	that point to any of the page belonging to his b-tree index
	are dropped. This is so because dropping of these entries
	require access to dict_index_t struct. To avoid such scenario
	We keep a count of number of such pages in the search_info and
	only free the dict_index_t struct when this count drops to
	zero. See also: dict_table_can_be_evicted() */

	do {
		ulint ref_count = btr_search_info_get_ref_count(info, index);

		if (ref_count == 0) {
			break;
		}

		/* Sleep for 10ms before trying again. */
		os_thread_sleep(10000);
		++retries;

		if (retries % 500 == 0) {
			/* No luck after 5 seconds of wait. */
			ib::error() << "Waited for " << retries / 100
				<< " secs for hash index"
				" ref_count (" << ref_count << ") to drop to 0."
				" index: " << index->name
				<< " table: " << table->name;
		}

		/* To avoid a hang here we commit suicide if the
		ref_count doesn't drop to zero in 600 seconds. */
		if (retries >= 60000) {
			ut_error;
		}
	} while (srv_shutdown_state == SRV_SHUTDOWN_NONE || !lru_evict);

	rw_lock_free(&index->lock);

	/* The index is being dropped, remove any compression stats for it. */
	if (!lru_evict && DICT_TF_GET_ZIP_SSIZE(index->table->flags)) {
		mutex_enter(&page_zip_stat_per_index_mutex);
		page_zip_stat_per_index.erase(index->id);
		mutex_exit(&page_zip_stat_per_index_mutex);
	}

	/* Remove the index from the list of indexes of the table */
	UT_LIST_REMOVE(table->indexes, index);

	/* Remove the index from affected virtual column index list */
	if (dict_index_has_virtual(index)) {
		const dict_col_t*	col;
		const dict_v_col_t*	vcol;

		for (ulint i = 0; i < dict_index_get_n_fields(index); i++) {
			col =  dict_index_get_nth_col(index, i);
			if (dict_col_is_virtual(col)) {
				vcol = reinterpret_cast<const dict_v_col_t*>(
					col);

				/* This could be NULL, when we do add virtual
				column, add index together. We do not need to
				track this virtual column's index */
				if (vcol->v_indexes == NULL) {
					continue;
				}

				dict_v_idx_list::iterator	it;

				for (it = vcol->v_indexes->begin();
				     it != vcol->v_indexes->end(); ++it) {
					dict_v_idx_t	v_index = *it;
					if (v_index.index == index) {
						vcol->v_indexes->erase(it);
						break;
					}
				}
			}

		}
	}

	size = mem_heap_get_size(index->heap);

	ut_ad(!dict_table_is_intrinsic(table));
	ut_ad(dict_sys->size >= size);

	dict_sys->size -= size;

	dict_mem_index_free(index);
}



-- 提交事务
/**********************************************************************//**
Does the transaction commit for MySQL.
@return DB_SUCCESS or error number */
dberr_t
trx_commit_for_mysql(
/*=================*/
	trx_t*	trx)	/*!< in/out: transaction */
{
	TrxInInnoDB	trx_in_innodb(trx, true);

	if (trx_in_innodb.is_aborted()
	    && trx->killed_by != os_thread_get_curr_id()) {

		return(DB_FORCED_ABORT);
	}

	/* Because we do not do the commit by sending an Innobase
	sig to the transaction, we must here make sure that trx has been
	started. */

	switch (trx->state) {
	case TRX_STATE_NOT_STARTED:
	case TRX_STATE_FORCED_ROLLBACK:

		ut_d(trx->start_file = __FILE__);
		ut_d(trx->start_line = __LINE__);

		trx_start_low(trx, true);
		/* fall through */
	case TRX_STATE_ACTIVE:
	case TRX_STATE_PREPARED:

		trx->op_info = "committing";

		if (trx->id != 0) {
			trx_update_mod_tables_timestamp(trx);
		}

		trx_commit(trx);

		MONITOR_DEC(MONITOR_TRX_ACTIVE);
		trx->op_info = "";
		return(DB_SUCCESS);
	case TRX_STATE_COMMITTED_IN_MEMORY:
		break;
	}
	ut_error;
	return(DB_CORRUPTION);
}
	
	


/*********************************************************************//**
Evaluate the given SQL.
@return error code or DB_SUCCESS */
dberr_t
que_eval_sql(
/*=========*/
	pars_info_t*	info,	/*!< in: info struct, or NULL */
	const char*	sql,	/*!< in: SQL string */
	ibool		reserve_dict_mutex,
				/*!< in: if TRUE, acquire/release
				dict_sys->mutex around call to pars_sql. */
	trx_t*		trx)	/*!< in: trx */
{
	que_thr_t*	thr;
	que_t*		graph;

	DBUG_ENTER("que_eval_sql");
	DBUG_PRINT("que_eval_sql", ("query: %s", sql));

	ut_a(trx->error_state == DB_SUCCESS);

	if (reserve_dict_mutex) {
		mutex_enter(&dict_sys->mutex);
	}

	graph = pars_sql(info, sql);

	if (reserve_dict_mutex) {
		mutex_exit(&dict_sys->mutex);
	}

	graph->trx = trx;
	trx->graph = NULL;

	graph->fork_type = QUE_FORK_MYSQL_INTERFACE;

	ut_a(thr = que_fork_start_command(graph));

	que_run_threads(thr);

	if (reserve_dict_mutex) {
		mutex_enter(&dict_sys->mutex);
	}

	que_graph_free(graph);

	if (reserve_dict_mutex) {
		mutex_exit(&dict_sys->mutex);
	}

	ut_a(trx->error_state != 0);

	DBUG_RETURN(trx->error_state);
}





/***********************************************************//**
Updates the clustered index record.
@return DB_SUCCESS if operation successfully completed, DB_LOCK_WAIT
in case of a lock wait, else error code */
static MY_ATTRIBUTE((warn_unused_result))
dberr_t
row_upd_clust_step(
/*===============*/
	upd_node_t*	node,	/*!< in: row update node */
	que_thr_t*	thr)	/*!< in: query thread */
{
	dict_index_t*	index;
	btr_pcur_t*	pcur;
	ibool		success;
	dberr_t		err;
	mtr_t		mtr;
	rec_t*		rec;
	mem_heap_t*	heap	= NULL;
	ulint		offsets_[REC_OFFS_NORMAL_SIZE];
	ulint*		offsets;
	ibool		referenced;
	ulint		flags	= 0;
	trx_t*		trx = thr_get_trx(thr);
	rec_offs_init(offsets_);

	index = dict_table_get_first_index(node->table);

	referenced = row_upd_index_is_referenced(index, trx);

	pcur = node->pcur;

	/* We have to restore the cursor to its position */

	mtr_start(&mtr);
	mtr.set_named_space(index->space);

	/* Disable REDO logging as lifetime of temp-tables is limited to
	server or connection lifetime and so REDO information is not needed
	on restart for recovery.
	Disable locking as temp-tables are not shared across connection. */
	if (dict_table_is_temporary(index->table)) {
		flags |= BTR_NO_LOCKING_FLAG;
		mtr.set_log_mode(MTR_LOG_NO_REDO);

		if (dict_table_is_intrinsic(index->table)) {
			flags |= BTR_NO_UNDO_LOG_FLAG;
		}
	}

	/* If the restoration does not succeed, then the same
	transaction has deleted the record on which the cursor was,
	and that is an SQL error. If the restoration succeeds, it may
	still be that the same transaction has successively deleted
	and inserted a record with the same ordering fields, but in
	that case we know that the transaction has at least an
	implicit x-lock on the record. */

	ut_a(pcur->rel_pos == BTR_PCUR_ON);

	ulint	mode;

	DEBUG_SYNC_C_IF_THD(
		thr_get_trx(thr)->mysql_thd,
		"innodb_row_upd_clust_step_enter");

	if (dict_index_is_online_ddl(index)) {
		ut_ad(node->table->id != DICT_INDEXES_ID);
		mode = BTR_MODIFY_LEAF | BTR_ALREADY_S_LATCHED;
		mtr_s_lock(dict_index_get_lock(index), &mtr);
	} else {
		mode = BTR_MODIFY_LEAF;
	}

	success = btr_pcur_restore_position(mode, pcur, &mtr);

	if (!success) {
		err = DB_RECORD_NOT_FOUND;

		mtr_commit(&mtr);

		return(err);
	}

	/* If this is a row in SYS_INDEXES table of the data dictionary,
	then we have to free the file segments of the index tree associated
	with the index */
	
	-- 如果这是数据字典的SYS_INDEXES表中的一行，那么我们必须释放与索引关联的索引树的文件段
	
	if (node->is_delete && node->table->id == DICT_INDEXES_ID) {

		ut_ad(!dict_index_is_online_ddl(index));

		dict_drop_index_tree(
			btr_pcur_get_rec(pcur), pcur, &mtr);

		mtr_commit(&mtr);

		mtr_start(&mtr);
		mtr.set_named_space(index->space);

		success = btr_pcur_restore_position(BTR_MODIFY_LEAF, pcur,
						    &mtr);
		if (!success) {
			err = DB_ERROR;

			mtr_commit(&mtr);

			return(err);
		}
	}

	rec = btr_pcur_get_rec(pcur);
	offsets = rec_get_offsets(rec, index, offsets_,
				  ULINT_UNDEFINED, &heap);

	if (!node->has_clust_rec_x_lock) {
		err = lock_clust_rec_modify_check_and_lock(
			flags, btr_pcur_get_block(pcur),
			rec, index, offsets, thr);
		if (err != DB_SUCCESS) {
			mtr_commit(&mtr);
			goto exit_func;
		}
	}

	ut_ad(lock_trx_has_rec_x_lock(thr_get_trx(thr), index->table,
				      btr_pcur_get_block(pcur),
				      page_rec_get_heap_no(rec)));

	/* NOTE: the following function calls will also commit mtr */

	if (node->is_delete) {
		err = row_upd_del_mark_clust_rec(
			flags, node, index, offsets, thr, referenced, &mtr);

		if (err == DB_SUCCESS) {
			node->state = UPD_NODE_UPDATE_ALL_SEC;
			node->index = dict_table_get_next_index(index);
		}

		goto exit_func;
	}

	/* If the update is made for MySQL, we already have the update vector
	ready, else we have to do some evaluation: */

	if (UNIV_UNLIKELY(!node->in_mysql_interface)) {
		/* Copy the necessary columns from clust_rec and calculate the
		new values to set */
		row_upd_copy_columns(rec, offsets,
				     UT_LIST_GET_FIRST(node->columns));
		row_upd_eval_new_vals(node->update);
	}

	if (node->cmpl_info & UPD_NODE_NO_ORD_CHANGE) {

		err = row_upd_clust_rec(
			flags, node, index, offsets, &heap, thr, &mtr);
		goto exit_func;
	}

	row_upd_store_row(node, trx->mysql_thd,
			  thr->prebuilt ? thr->prebuilt->m_mysql_table : NULL);

	if (row_upd_changes_ord_field_binary(index, node->update, thr,
					     node->row, node->ext)) {

		/* Update causes an ordering field (ordering fields within
		the B-tree) of the clustered index record to change: perform
		the update by delete marking and inserting.

		TODO! What to do to the 'Halloween problem', where an update
		moves the record forward in index so that it is again
		updated when the cursor arrives there? Solution: the
		read operation must check the undo record undo number when
		choosing records to update. MySQL solves now the problem
		externally! */

		err = row_upd_clust_rec_by_insert(
			flags, node, index, thr, referenced, &mtr);

		if (err != DB_SUCCESS) {

			goto exit_func;
		}

		node->state = UPD_NODE_UPDATE_ALL_SEC;
	} else {
		err = row_upd_clust_rec(
			flags, node, index, offsets, &heap, thr, &mtr);

		if (err != DB_SUCCESS) {

			goto exit_func;
		}

		node->state = UPD_NODE_UPDATE_SOME_SEC;
	}

	node->index = dict_table_get_next_index(index);

exit_func:
	if (heap) {
		mem_heap_free(heap);
	}
	return(err);
}


