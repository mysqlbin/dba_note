
E:\github\mysql-5.7.26\sql\sql_table.cc
	mysql  sql 目录 是什么文件
	MySQL服务器主要代码，这里包含了main函数（main.cc），将会生成mysqld可执行文件；

1. mysql_rm_table
	
	1.1 mysql_rm_table
	1.2 mysql_rm_table->find_table_for_mdl_upgrade
	1.3 mysql_rm_table->mysql_rm_table_no_locks
		-- 获得MDL写锁
	1.4 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table
	1.5 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table->handler::ha_delete_table
	1.6 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table->handler::ha_delete_table->handler::delete_table


2. ha_innobase::delete_table

	2.1 ha_innobase::delete_table
	2.2 ha_innobase::delete_table->row_drop_table_for_mysql
	2.3 ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_lock_data_dictionary
		-- 锁住数据字典（独占锁）
		-- 通过代码我们可以看到drop table调用row_drop_table_for_mysql函数时，在row_mysql_lock_data_dictionary(trx);位置对元数据加了排它锁
	2.4 ha_innobase::delete_table->row_drop_table_for_mysql->trx_start_for_ddl
	
	2.5 clean up data dictionary
		拼接了一个巨大的SQL，用来从系统表中清理信息
	
	2.6 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_table_from_cache
		清缓存
		
	2.7 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace
	2.8 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace
	2.9 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->buf_LRU_flush_or_remove_pages
	2.10 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->os_file_delete
	2.11 ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_unlock_data_dictionary
		释放数据字典的排他锁。
		
		
	
3. DROP TABLE的源代码调用关系大致为

	row_drop_table_for_mysql --> row_mysql_lock_data_dictionary
							 |__ trx_start_for_ddl
							 |__ clean up data dictionary
							 |__ row_drop_table_from_cache
							 |__ row_drop_single_table_tablespace --> fil_delete_tablespace --> buf_LRU_flush_or_remove_pages
							 |                                                              |__ os_file_delete --> unlink
							 |__ row_mysql_unlock_data_dictionary
							 
							 
1. mysql_rm_table
	
	1.1 mysql_rm_table
		drop table删除表操作的入口函数

		/* mysql-5.7.26\sql\sql_table.cc */

		/*
		 delete (drop) tables.

		  SYNOPSIS
		   mysql_rm_table()
		   thd			Thread handle
		   tables		List of tables to delete
		   if_exists		If 1, don't give error if one table doesn't exists

		  NOTES
			Will delete all tables that can be deleted and give a compact error
			messages for tables that could not be deleted.
			If a table is in use, we will wait for all users to free the table
			before dropping it

			Wait if global_read_lock (FLUSH TABLES WITH READ LOCK) is set, but
			not if under LOCK TABLES.

		  RETURN
			FALSE OK.  In this case ok packet is sent to user
			TRUE  Error

		*/

		bool mysql_rm_table(THD *thd,TABLE_LIST *tables, my_bool if_exists,
							my_bool drop_temporary)
		{


	--------------------------------------------------------------------------------------------------------------
	
	1.2 mysql_rm_table->find_table_for_mdl_upgrade
		
		/* mysql-5.7.26\sql\sql_base.cc  */

		
		/**
		   Find instance of TABLE with upgradable or exclusive metadata
		   lock from the list of open tables, emit error if no such table
		   found.

		   @param thd        Thread context
		   @param db         Database name.
		   @param table_name Name of table.
		   @param no_error   Don't emit error if no suitable TABLE
							 instance were found.

		   @note This function checks if the connection holds a global IX
				 metadata lock. If no such lock is found, it is not safe to
				 upgrade the lock and ER_TABLE_NOT_LOCKED_FOR_WRITE will be
				 reported.

		   @return Pointer to TABLE instance with MDL_SHARED_UPGRADABLE
				   MDL_SHARED_NO_WRITE, MDL_SHARED_NO_READ_WRITE, or
				   MDL_EXCLUSIVE metadata lock, NULL otherwise.
		*/

		/*

		此函数检查连接是否持有全局 IX 元数据写锁。

		*/
		TABLE *find_table_for_mdl_upgrade(THD *thd, const char *db,
										  const char *table_name, bool no_error)
		{

	--------------------------------------------------------------------------------------------------------------


	1.3 mysql_rm_table->mysql_rm_table_no_locks

		/**
		  Execute the drop of a normal or temporary table.

		  @param  thd             Thread handler
		  @param  tables          Tables to drop
		  @param  if_exists       If set, don't give an error if table doesn't exists.
								  In this case we give an warning of level 'NOTE'
		  @param  drop_temporary  Only drop temporary tables
		  @param  drop_view       Allow to delete VIEW .frm
		  @param  dont_log_query  Don't write query to log files. This will also not
								  generate warnings if the handler files doesn't exists

		  @retval  0  ok
		  @retval  1  Error
		  @retval -1  Thread was killed
		
		  在这个函数中已经获得MDL写锁
		  @note This function assumes that metadata locks have already been taken.
				It is also assumed that the tables have been removed from TDC.

		  @note This function assumes that temporary tables to be dropped have
				been pre-opened using corresponding table list elements.

		  @todo When logging to the binary log, we should log
				tmp_tables and transactional tables as separate statements if we
				are in a transaction;  This is needed to get these tables into the
				cached binary log that is only written on COMMIT.
				The current code only writes DROP statements that only uses temporary
				tables to the cache binary log.  This should be ok on most cases, but
				not all.
		*/

		int mysql_rm_table_no_locks(THD *thd, TABLE_LIST *tables, bool if_exists,
									bool drop_temporary, bool drop_view,
									bool dont_log_query)
		{



	--------------------------------------------------------------------------------------------------------------

	1.4 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table


		/** @brief
		  This should return ENOENT if the file doesn't exists.
		  The .frm file will be deleted only if we return 0 or ENOENT
		*/
		int ha_delete_table(THD *thd, handlerton *table_type, const char *path,
							const char *db, const char *alias, bool generate_warning)
		{



	--------------------------------------------------------------------------------------------------------------
	1.5 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table->handler::ha_delete_table

		/**
		  Delete table: public interface(公共接口).
		  
		  @sa handler::delete_table()
		*/


		int
		handler::ha_delete_table(const char *name)
		{
		  DBUG_ASSERT(m_lock_type == F_UNLCK);
		  mark_trx_read_write();

		  return delete_table(name);
		}

	--------------------------------------------------------------------------------------------------------------

	1.6 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table->handler::ha_delete_table->handler::delete_table

		/**
		  Delete all files with extension from bas_ext().

		  @param name		Base name of table

		  @note
			We assume that the handler may return more extensions than
			was actually used for the file.

		  @retval
			0   If we successfully deleted at least one file from base_ext and
			didn't get any other errors than ENOENT
		  @retval
			!0  Error
		*/
		int handler::delete_table(const char *name)
		{
		  int saved_error= 0;
		  int error= 0;
		  int enoent_or_zero= ENOENT;                   // Error if no file was deleted
		  char buff[FN_REFLEN];
		  DBUG_ASSERT(m_lock_type == F_UNLCK);

		  for (const char **ext=bas_ext(); *ext ; ext++)
		  {
			fn_format(buff, name, "", *ext, MY_UNPACK_FILENAME|MY_APPEND_EXT);
			if (mysql_file_delete_with_symlink(key_file_misc, buff, MYF(0)))
			{
			  if (my_errno() != ENOENT)
			  {
				/*
				  If error on the first existing file, return the error.
				  Otherwise delete as much as possible.
				*/
				if (enoent_or_zero)
				  return my_errno();
			saved_error= my_errno();
			  }
			}
			else
			  enoent_or_zero= 0;                        // No error for ENOENT
			error= enoent_or_zero;
		  }
		  return saved_error ? saved_error : error;
		}


2. ha_innobase::delete_table

	2.1 ha_innobase::delete_table
		
		进入到 InnoDB层
		
		/* /mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:12583 */
		
		
		/*
			从 InnoDB 数据库中删除表。 
			在调用这个函数之前，MySQL 调用 innobase_commit 来提交当前用户的事务。
			那么当前用户不能在表上设置锁。
			InnoDB 中的删除表操作将删除任何用户在 InnoDB 中的表上的所有锁。
		*//
		/*****************************************************************//**
		Drops a table from an InnoDB database. Before calling this function,
		MySQL calls innobase_commit to commit the transaction of the current user.
		Then the current user cannot have locks set on the table. Drop table
		operation inside InnoDB will remove all locks any user has on the table
		inside InnoDB.
		@return error number */

		int
		ha_innobase::delete_table(
		/*======================*/
			const char*	name)	/*!< in: table name */
		{
			
			TrxInInnoDB	trx_in_innodb(parent_trx);

			/* Remove the to-be-dropped table from the list of modified tables
			by parent_trx. Otherwise we may end up with an orphaned pointer to
			the table object from parent_trx::mod_tables. This could happen in:
			SET AUTOCOMMIT=0;
			CREATE TABLE t (PRIMARY KEY (a)) ENGINE=INNODB SELECT 1 AS a UNION
			ALL SELECT 1 AS a; */
			trx_mod_tables_t::const_iterator	iter;

			for (iter = parent_trx->mod_tables.begin();
				 iter != parent_trx->mod_tables.end();
				 ++iter) {

				dict_table_t*	table_to_drop = *iter;

				if (strcmp(norm_name, table_to_drop->name.m_name) == 0) {
					parent_trx->mod_tables.erase(table_to_drop);
					break;
				}
			}

			trx_t*	trx = innobase_trx_allocate(thd);

			ulint	name_len = strlen(name);

			ut_a(name_len < 1000);

			/* Either the transaction is already flagged as a locking transaction
			or it hasn't been started yet. */

			ut_a(!trx_is_started(trx) || trx->will_lock > 0);

			/* We are doing a DDL operation. */
			++trx->will_lock;

			/* Drop the table in InnoDB */
			
			/* 删除InnoDB中的表 */
			
			err = row_drop_table_for_mysql(
				norm_name, trx, thd_sql_command(thd) == SQLCOM_DROP_DB,
				true, handler);

	2.2 ha_innobase::delete_table->row_drop_table_for_mysql

		/* mysql-5.7.26\storage\innobase\row\row0mysql.cc */
		/*
		从MySQL中删除表
		如果数据字典尚未被事务锁定，则将提交事务。 否则，数据字典将保持锁定状态。
		*/
		
		/** Drop a table for MySQL.
		If the data dictionary was not already locked by the transaction,
		the transaction will be committed.  Otherwise, the data dictionary
		will remain locked.
		@param[in]	name		Table name
		@param[in]	trx		Transaction handle
		@param[in]	drop_db		true=dropping whole database
		@param[in]	nonatomic	Whether it is permitted to release
		and reacquire dict_operation_lock    /* 是否允许释放和重新获取dict_operation_lock */
		@param[in,out]	handler		Table handler
		@return error code or DB_SUCCESS */
		dberr_t
		row_drop_table_for_mysql(
			const char*	name,
			trx_t*		trx,
			bool		drop_db,
			bool		nonatomic,
			dict_table_t*	handler)
		{
			dberr_t		err;
			dict_foreign_t*	foreign;
			dict_table_t*	table			= NULL;
			char*		filepath		= NULL;
			char*		tablename		= NULL;
			bool		locked_dictionary	= false;
			pars_info_t*	info			= NULL;
			mem_heap_t*	heap			= NULL;
			bool		is_intrinsic_temp_table	= false;

			DBUG_ENTER("row_drop_table_for_mysql");
			DBUG_PRINT("row_drop_table_for_mysql", ("table: '%s'", name));

			ut_a(name != NULL);
			
			
			 /* 锁住数据字典（独占锁）*/
			 
			/* Serialize data dictionary operations with dictionary mutex:
			no deadlocks can occur then in these operations */

			trx->op_info = "dropping table";

			if (handler != NULL && dict_table_is_intrinsic(handler)) {
				table = handler;
				is_intrinsic_temp_table = true;
			}

			if (table == NULL) {

				if (trx->dict_operation_lock_mode != RW_X_LATCH) {
					/* Prevent foreign key checks etc. while we are
					dropping the table */
					
					/* 锁住数据字典（独占锁）*/
					row_mysql_lock_data_dictionary(trx);

					locked_dictionary = true;
					nonatomic = true;
				}

				ut_ad(mutex_own(&dict_sys->mutex));
				ut_ad(rw_lock_own(dict_operation_lock, RW_LOCK_X));

				table = dict_table_open_on_name(
					name, TRUE, FALSE,
					static_cast<dict_err_ignore_t>(
						DICT_ERR_IGNORE_INDEX_ROOT
						| DICT_ERR_IGNORE_CORRUPT));
			} else {
				table->acquire();
				ut_ad(dict_table_is_intrinsic(table));
			}

			if (!table) {
				err = DB_TABLE_NOT_FOUND;
				goto funct_exit;
			}

			/* This function is called recursively via fts_drop_tables(). */
			if (!trx_is_started(trx)) {

				if (!dict_table_is_temporary(table)) {
					trx_start_for_ddl(trx, TRX_DICT_OP_TABLE);
				} else {
					trx_set_dict_operation(trx, TRX_DICT_OP_TABLE);
				}
			}

			/* Turn on this drop bit before we could release the dictionary
			latch */
			table->to_be_dropped = true;

			if (nonatomic) {
			
				/*
				此 事务 尚未获取字典表记录上的任何锁。 因此，释放和重新获取数据字典锁存器是安全的。
				*/
				/* This trx did not acquire any locks on dictionary
				table records yet. Thus it is safe to release and
				reacquire the data dictionary latches. */
				if (table->fts) {
					ut_ad(!table->fts->add_wq);
					ut_ad(lock_trx_has_sys_table_locks(trx) == 0);

					for (;;) {
						bool retry = false;
						if (dict_fts_index_syncing(table)) {
							retry = true;
						}
						if (!retry) {
							break;
						}
						DICT_BG_YIELD(trx);
					}
					
					/* 释放数据字典的排他锁。 */
					row_mysql_unlock_data_dictionary(trx);
					
					/*
					从优化器列表中删除表。
					*/
					fts_optimize_remove_table(table);
					
					/* 锁住数据字典（独占锁）*/
					row_mysql_lock_data_dictionary(trx);
				}

				/*
				
				不要费心处理临时表的持久统计数据，因为我们知道临时表不使用持久统计数据
				
				*/
				/* Do not bother to deal with persistent stats for temp
				tables since we know temp tables do not use persistent
				stats. */
				if (!dict_table_is_temporary(table)) {
					dict_stats_wait_bg_to_stop_using_table(
						table, trx);
				}
			}
			
			/*
			
			确保后台统计线程没有数据表在运行
			*/
			/* make sure background stats thread is not running on the table */
			ut_ad(!(table->stats_bg_flag & BG_STAT_IN_PROGRESS));

			/* Delete the link file if used. */
			if (DICT_TF_HAS_DATA_DIR(table->flags)) {
				RemoteDatafile::delete_link_file(name);
			}

			if (!dict_table_is_temporary(table)) {

				dict_stats_recalc_pool_del(table);
				
				/*
					如果该表存在并且其中有该表的统计信息，则从持久存储中删除该表及其所有索引的统计信息。
					此函数创建自己的 trx 并提交它
					
					删除表的统计信息
				*/
				/* Remove stats for this table and all of its indexes from the
				persistent storage if it exists and if there are stats for this
				table in there. This function creates its own trx and commits
				it. */
				if (dict_stats_is_persistent_enabled(table)) {
					char	errstr[1024];
					err = dict_stats_drop_table(name, errstr, sizeof(errstr));
					if (err != DB_SUCCESS) {
						ib::warn() << errstr;
					}
				}
			}

			if (!dict_table_is_intrinsic(table)) {
				dict_table_prevent_eviction(table);
			}

			dict_table_close(table, TRUE, FALSE);
			
			/*
			
			检查表是否被其他表（不是表本身）的外键约束引用
			*/
			
			/* Check if the table is referenced by foreign key constraints from
			some other table (not the table itself) */

			if (!srv_read_only_mode && trx->check_foreigns) {

				for (dict_foreign_set::iterator it
					= table->referenced_set.begin();
					 it != table->referenced_set.end();
					 ++it) {

					foreign = *it;

					const bool	ref_ok = drop_db
						&& dict_tables_have_same_db(
							name,
							foreign->foreign_table_name_lookup);

					if (foreign->foreign_table != table && !ref_ok) {

						FILE*	ef	= dict_foreign_err_file;

						/* We only allow dropping a referenced table
						if FOREIGN_KEY_CHECKS is set to 0 */

						err = DB_CANNOT_DROP_CONSTRAINT;

						mutex_enter(&dict_foreign_err_mutex);
						rewind(ef);
						ut_print_timestamp(ef);

						fputs("  Cannot drop table ", ef);
						ut_print_name(ef, trx, name);
						fputs("\n"
							  "because it is referenced by ", ef);
						ut_print_name(ef, trx,
								  foreign->foreign_table_name);
						putc('\n', ef);
						mutex_exit(&dict_foreign_err_mutex);

						goto funct_exit;
					}
				}
			}


			DBUG_EXECUTE_IF("row_drop_table_add_to_background",
				row_add_table_to_background_drop_list(table->name.m_name);
				err = DB_SUCCESS;
				goto funct_exit;
			);
			
			/* TODO: could we replace the counter n_foreign_key_checks_running
			with lock checks on the table? Acquire here an exclusive lock on the
			table, and rewrite lock0lock.cc and the lock wait in srv0srv.cc so that
			they can cope with the table having been dropped here? Foreign key
			checks take an IS or IX lock on the table. */

			if (table->n_foreign_key_checks_running > 0) {

				const char*	save_tablename = table->name.m_name;
				ibool		added;

				added = row_add_table_to_background_drop_list(save_tablename);

				if (added) {
					ib::info() << "You are trying to drop table "
						<< table->name
						<< " though there is a foreign key check"
						" running on it. Adding the table to the"
						" background drop queue.";

					/* We return DB_SUCCESS to MySQL though the drop will
					happen lazily later */

					err = DB_SUCCESS;
				} else {
					/* The table is already in the background drop list */
					err = DB_ERROR;
				}

				goto funct_exit;
			}

			/* Remove all locks that are on the table or its records, if there
			are no references to the table but it has record locks, we release
			the record locks unconditionally. One use case is:
			删除表或其记录上的所有锁，如果没有对该表的引用但它有记录锁，我们无条件释放记录锁。一个用例是
				CREATE TABLE t2 (PRIMARY KEY (a)) SELECT * FROM t1;

			If after the user transaction has done the SELECT and there is a
			problem in completing the CREATE TABLE operation, MySQL will drop
			the table. InnoDB will create a new background transaction to do the
			actual drop, the trx instance that is passed to this function. To
			preserve existing behaviour we remove the locks but ideally we
			shouldn't have to. There should never be record locks on a table
			that is going to be dropped. */

			if (table->get_ref_count() == 0) {
				/* We don't take lock on intrinsic table so nothing to remove.*/
				if (!dict_table_is_intrinsic(table)) {
					lock_remove_all_on_table(table, TRUE);
				}
				ut_a(table->n_rec_locks == 0);
			} else if (table->get_ref_count() > 0 || table->n_rec_locks > 0) {
				ibool	added;

				ut_ad(!dict_table_is_intrinsic(table));

				added = row_add_table_to_background_drop_list(
					table->name.m_name);

				if (added) {
					ib::info() << "MySQL is trying to drop table "
						<< table->name
						<< " though there are still open handles to"
						" it. Adding the table to the background drop"
						" queue.";

					/* We return DB_SUCCESS to MySQL though the drop will
					happen lazily later */
					err = DB_SUCCESS;
				} else {
					/* The table is already in the background drop list */
					err = DB_ERROR;
				}

				goto funct_exit;
			}

			/* The "to_be_dropped" marks table that is to be dropped, but
			has not been dropped, instead, was put in the background drop
			list due to being used by concurrent DML operations. Clear it
			here since there are no longer any concurrent activities on it,
			and it is free to be dropped */
			table->to_be_dropped = false;

			/* If we get this far then the table to be dropped must not have
			any table or record locks on it. */

			ut_a(dict_table_is_intrinsic(table) || !lock_table_has_locks(table));

			switch (trx_get_dict_operation(trx)) {
			case TRX_DICT_OP_NONE:
				trx_set_dict_operation(trx, TRX_DICT_OP_TABLE);
				trx->table_id = table->id;
			case TRX_DICT_OP_TABLE:
				break;
			case TRX_DICT_OP_INDEX:
				/* If the transaction was previously flagged as
				TRX_DICT_OP_INDEX, we should be dropping auxiliary
				tables for full-text indexes or temp tables. */
				ut_ad(strstr(table->name.m_name, "/FTS_") != NULL
					  || strstr(table->name.m_name, TEMP_FILE_PREFIX_INNODB)
					  != NULL);
			}

			/* Mark all indexes unavailable in the data dictionary cache
			before starting to drop the table. */

			unsigned*	page_no;
			unsigned*	page_nos;
			heap = mem_heap_create(
				200 + UT_LIST_GET_LEN(table->indexes) * sizeof *page_nos);
			tablename = mem_heap_strdup(heap, name);

			page_no = page_nos = static_cast<unsigned*>(
				mem_heap_alloc(
					heap,
					UT_LIST_GET_LEN(table->indexes) * sizeof *page_no));

			for (dict_index_t* index = dict_table_get_first_index(table);
				 index != NULL;
				 index = dict_table_get_next_index(index)) {
				rw_lock_x_lock(dict_index_get_lock(index));
				/* Save the page numbers so that we can restore them
				if the operation fails. */
				*page_no++ = index->page;
				/* Mark the index unusable. */
				index->page = FIL_NULL;
				rw_lock_x_unlock(dict_index_get_lock(index));
			}

			/* As we don't insert entries to SYSTEM TABLES for temp-tables
			we need to avoid running removal of these entries. */
			if (!dict_table_is_temporary(table)) {
				/* We use the private SQL parser of Innobase to generate the
				query graphs needed in deleting the dictionary data from system
				tables in Innobase. Deleting a row from SYS_INDEXES table also
				frees the file segments of the B-tree associated with the
				index. */

				info = pars_info_create();

				pars_info_add_str_literal(info, "table_name", name);

				std::basic_string<char, std::char_traits<char>,
						  ut_allocator<char> > sql;
				sql.reserve(2000);

				sql =	"PROCEDURE DROP_TABLE_PROC () IS\n"
					"sys_foreign_id CHAR;\n"
					"table_id CHAR;\n"
					"index_id CHAR;\n"
					"foreign_id CHAR;\n"
					"space_id INT;\n"
					"found INT;\n";

				sql +=	"DECLARE CURSOR cur_fk IS\n"
					"SELECT ID FROM SYS_FOREIGN\n"
					"WHERE FOR_NAME = :table_name\n"
					"AND TO_BINARY(FOR_NAME)\n"
					"  = TO_BINARY(:table_name)\n"
					"LOCK IN SHARE MODE;\n";

				sql +=	"DECLARE CURSOR cur_idx IS\n"
					"SELECT ID FROM SYS_INDEXES\n"
					"WHERE TABLE_ID = table_id\n"
					"LOCK IN SHARE MODE;\n";

				sql +=	"BEGIN\n";

				sql +=	"SELECT ID INTO table_id\n"
					"FROM SYS_TABLES\n"
					"WHERE NAME = :table_name\n"
					"LOCK IN SHARE MODE;\n"
					"IF (SQL % NOTFOUND) THEN\n"
					"       RETURN;\n"
					"END IF;\n";

				sql +=	"SELECT SPACE INTO space_id\n"
					"FROM SYS_TABLES\n"
					"WHERE NAME = :table_name;\n"
					"IF (SQL % NOTFOUND) THEN\n"
					"       RETURN;\n"
					"END IF;\n";

				sql +=	"found := 1;\n"
					"SELECT ID INTO sys_foreign_id\n"
					"FROM SYS_TABLES\n"
					"WHERE NAME = 'SYS_FOREIGN'\n"
					"LOCK IN SHARE MODE;\n"
					"IF (SQL % NOTFOUND) THEN\n"
					"       found := 0;\n"
					"END IF;\n"
					"IF (:table_name = 'SYS_FOREIGN') THEN\n"
					"       found := 0;\n"
					"END IF;\n"
					"IF (:table_name = 'SYS_FOREIGN_COLS') \n"
					"THEN\n"
					"       found := 0;\n"
					"END IF;\n";

				sql +=	"OPEN cur_fk;\n"
					"WHILE found = 1 LOOP\n"
					"       FETCH cur_fk INTO foreign_id;\n"
					"       IF (SQL % NOTFOUND) THEN\n"
					"               found := 0;\n"
					"       ELSE\n"
					"               DELETE FROM \n"
					"		   SYS_FOREIGN_COLS\n"
					"               WHERE ID = foreign_id;\n"
					"               DELETE FROM SYS_FOREIGN\n"
					"               WHERE ID = foreign_id;\n"
					"       END IF;\n"
					"END LOOP;\n"
					"CLOSE cur_fk;\n";

				sql +=	"found := 1;\n"
					"OPEN cur_idx;\n"
					"WHILE found = 1 LOOP\n"
					"       FETCH cur_idx INTO index_id;\n"
					"       IF (SQL % NOTFOUND) THEN\n"
					"               found := 0;\n"
					"       ELSE\n"
					"               DELETE FROM SYS_FIELDS\n"
					"               WHERE INDEX_ID = index_id;\n"
					"               DELETE FROM SYS_INDEXES\n"
					"               WHERE ID = index_id\n"
					"               AND TABLE_ID = table_id;\n"
					"       END IF;\n"
					"END LOOP;\n"
					"CLOSE cur_idx;\n";

				sql +=	"DELETE FROM SYS_COLUMNS\n"
					"WHERE TABLE_ID = table_id;\n"
					"DELETE FROM SYS_TABLES\n"
					"WHERE NAME = :table_name;\n";

				if (dict_table_is_file_per_table(table)) {
					sql += "DELETE FROM SYS_TABLESPACES\n"
						"WHERE SPACE = space_id;\n"
						"DELETE FROM SYS_DATAFILES\n"
						"WHERE SPACE = space_id;\n";
				}

				sql +=	"DELETE FROM SYS_VIRTUAL\n"
					"WHERE TABLE_ID = table_id;\n";

				sql += "END;\n";

				err = que_eval_sql(info, sql.c_str(), FALSE, trx);
			} else {
				page_no = page_nos;
				for (dict_index_t* index = dict_table_get_first_index(table);
					 index != NULL;
					 index = dict_table_get_next_index(index)) {
					/* remove the index object associated. */
					dict_drop_index_tree_in_mem(index, *page_no++);
				}
				err = DB_SUCCESS;
			}

			switch (err) {
				ulint	space_id;
				bool	is_temp;
				bool	is_encrypted;
				bool	ibd_file_missing;
				bool	is_discarded;
				bool	shared_tablespace;

			case DB_SUCCESS:
				space_id = table->space;
				ibd_file_missing = table->ibd_file_missing;
				is_discarded = dict_table_is_discarded(table);
				is_temp = dict_table_is_temporary(table);
				is_encrypted = dict_table_is_encrypted(table);
				shared_tablespace = DICT_TF_HAS_SHARED_SPACE(table->flags);

				/* If there is a temp path then the temp flag is set.
				However, during recovery, we might have a temp flag but
				not know the temp path */
				ut_a(table->dir_path_of_temp_table == NULL || is_temp);

				/* We do not allow temporary tables with a remote path. */
				ut_a(!(is_temp && DICT_TF_HAS_DATA_DIR(table->flags)));

				/* Make sure the data_dir_path is set if needed. */
				dict_get_and_save_data_dir_path(table, true);

				err = row_drop_ancillary_fts_tables(table, trx);
				if (err != DB_SUCCESS) {
					break;
				}

				/* Determine the tablespace filename before we drop
				dict_table_t.  Free this memory before returning. */
				if (DICT_TF_HAS_DATA_DIR(table->flags)) {
					ut_a(table->data_dir_path);

					filepath = fil_make_filepath(
						table->data_dir_path,
						table->name.m_name, IBD, true);
				} else if (table->dir_path_of_temp_table) {
					filepath = fil_make_filepath(
						table->dir_path_of_temp_table,
						NULL, IBD, false);
				} else if (!shared_tablespace) {
					filepath = fil_make_filepath(
						NULL, table->name.m_name, IBD, false);
				}

				/* Free the dict_table_t object. */
				err = row_drop_table_from_cache(tablename, table, trx);
				if (err != DB_SUCCESS) {
					break;
				}

				/* Do not attempt to drop known-to-be-missing tablespaces,
				nor system or shared general tablespaces. */
				if (is_discarded || ibd_file_missing || shared_tablespace
					|| is_system_tablespace(space_id)) {
					/* For encrypted table, if ibd file can not be decrypt,
					we also set ibd_file_missing. We still need to try to
					remove the ibd file for this. */
					if (is_discarded || !is_encrypted
						|| !ibd_file_missing) {
						break;
					}
				}

				if (is_encrypted) {
					/* Require the mutex to block key rotation. */
					mutex_enter(&master_key_id_mutex);
				}
				/* We can now drop the single-table tablespace. */
				err = row_drop_single_table_tablespace(
					space_id, tablename, filepath,
					is_temp, is_encrypted, trx);

				if (is_encrypted) {
					mutex_exit(&master_key_id_mutex);
				}
				break;

			case DB_OUT_OF_FILE_SPACE:
				err = DB_MUST_GET_MORE_FILE_SPACE;

				row_mysql_handle_errors(&err, trx, NULL, NULL);

				/* raise error */
				ut_error;
				break;

			case DB_TOO_MANY_CONCURRENT_TRXS:
				/* Cannot even find a free slot for the
				the undo log. We can directly exit here
				and return the DB_TOO_MANY_CONCURRENT_TRXS
				error. */

			default:
				/* This is some error we do not expect. Print
				the error number and rollback the transaction */
				ib::error() << "Unknown error code " << err << " while"
					" dropping table: "
					<< ut_get_name(trx, tablename) << ".";

				trx->error_state = DB_SUCCESS;
				trx_rollback_to_savepoint(trx, NULL);
				trx->error_state = DB_SUCCESS;

				/* Mark all indexes available in the data dictionary
				cache again. */

				page_no = page_nos;

				for (dict_index_t* index = dict_table_get_first_index(table);
					 index != NULL;
					 index = dict_table_get_next_index(index)) {
					rw_lock_x_lock(dict_index_get_lock(index));
					ut_a(index->page == FIL_NULL);
					index->page = *page_no++;
					rw_lock_x_unlock(dict_index_get_lock(index));
				}
			}

			if (err != DB_SUCCESS && table != NULL) {
				/* Drop table has failed with error but as drop table is not
				transaction safe we should mark the table as corrupted to avoid
				unwarranted follow-up action on this table that can result
				in more serious issues. */

				table->corrupted = true;
				for (dict_index_t* index = UT_LIST_GET_FIRST(table->indexes);
					 index != NULL;
					 index = UT_LIST_GET_NEXT(indexes, index)) {
					dict_set_corrupted(index, trx, "DROP TABLE");
				}
			}

		funct_exit:
			if (heap) {
				mem_heap_free(heap);
			}

			ut_free(filepath);

			if (locked_dictionary) {

				if (trx_is_started(trx)) {

					trx_commit_for_mysql(trx);
				}
				/* 释放数据字典的排他锁。 */
				row_mysql_unlock_data_dictionary(trx);
			}

			trx->op_info = "";

			/* No need to immediately invoke master thread as there is no work
			generated by intrinsic table operation that needs master thread
			attention. */
			if (!is_intrinsic_temp_table) {
				srv_wake_master_thread();
			}

			DBUG_RETURN(err);
		}
		
	
	
	2.3 ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_lock_data_dictionary
	
		对数据字典加互斥锁，读写锁。
		
		
	2.4 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace
		
		/*
			删除单表表空间作为删除或重命名表的一部分。
			这将删除 fil_space_t（如果找到）和磁盘上的文件。
		*/
		/** Drop a single-table tablespace as part of dropping or renaming a table.
		This deletes the fil_space_t if found and the file on disk.
		@param[in]	space_id	Tablespace ID
		@param[in]	tablename	Table name, same as the tablespace name
		@param[in]	filepath	File path of tablespace to delete
		@param[in]	is_temp		Is this a temporary table/tablespace
		@param[in]	is_encrypted	Is this an encrypted table/tablespace
		@param[in]	trx		Transaction handle
		@return error code or DB_SUCCESS */
		UNIV_INLINE
		dberr_t
		row_drop_single_table_tablespace(
			ulint		space_id,
			const char*	tablename,
			const char*	filepath,
			bool		is_temp,
			bool		is_encrypted,
			trx_t*		trx)
		{
			dberr_t	err = DB_SUCCESS;

			/* This might be a temporary single-table tablespace if the table
			is compressed and temporary. If so, don't spam the log when we
			delete one of these or if we can't find the tablespace. */
			bool	print_msg = !is_temp && !is_encrypted;
			
			/* 如果表空间不在缓存中，只需删除该文件。 */
			/* If the tablespace is not in the cache, just delete the file. */
			if (!fil_space_for_table_exists_in_mem(
					space_id, tablename, print_msg, false, NULL, 0)) {
				
				/* 强制删除任何无用的或临时的文件。 */
				/* Force a delete of any discarded or temporary files. */
				fil_delete_file(filepath);

				if (print_msg) {
					ib::info() << "Removed datafile " << filepath
						<< " for table " << tablename;
				}

			} else if (fil_delete_tablespace(space_id, BUF_REMOVE_FLUSH_NO_WRITE)
				   != DB_SUCCESS) {

				ib::error() << "We removed the InnoDB internal data"
					" dictionary entry of table " << tablename
					<< " but we are not able to delete the tablespace "
					<< space_id << " file " << filepath << "!";

				err = DB_ERROR;
			}

			return(err);
		}
	
	
	2.5 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace
		
		
		/* mysql-5.7.26\storage\innobase\fil\fil0fil.cc */
		/*
		删除 ibd 表空间，无论是在共享表空间还是在独立表空间中。
		表空间必须缓存在内存缓存中。
		这将从 file_system_t 缓存中删除数据文件、fil_space_t 和 fil_node_t 条目。
		*/
		/** Deletes an IBD tablespace, either general or single-table.
		The tablespace must be cached in the memory cache. This will delete the
		datafile, fil_space_t & fil_node_t entries from the file_system_t cache.
		@param[in]	space_id	Tablespace id
		@param[in]	buf_remove	Specify the action to take on the pages
		for this table in the buffer pool.
		@return true if success */
		dberr_t
		fil_delete_tablespace(
			ulint		id,
			buf_remove_t	buf_remove);
			
	
	