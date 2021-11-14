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
@return	whether freeing the B-tree was attempted */
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
		/* 如果二级索引根节点的编号为NULL(每个索引页都有编号即page_no。), 树已经被释放 */
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
	if (srv_is_tablespace_truncated(space)) {
		return(false);
	}

	btr_free_if_exists(page_id_t(space, root_page_no), page_size,
			   mach_read_from_8(ptr), mtr);

	return(true);
}