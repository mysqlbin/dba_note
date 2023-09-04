Sql_cmd_analyze_table::execute 
	-> mysql_admin_table
		--  lock_type=TL_READ_NO_INSERT
		-> handler::ha_analyze
			-> ha_innobase::analyze
				-> ha_innobase::info_low
					-> dict_stats_update
						-> dict_stats_update_persistent
							-> dict_stats_analyze_index
						-> dict_stats_save
							-> dict_stats_snapshot_create
								-> dict_table_stats_lock
						


dict_stats_update()函数，在传参为DICT_STATS_RECALC_PERSISTENT时，做三件事：

	(1) 检查dict_stats_persistent_storage_check() 检查相关系统表是否存在，不存在报错
	
	(2)dict_stats_update_persistent(table) 更新表的统计信息
		先更新聚集索引，再更新二级索引，均调用函数 dict_stats_analyze_index.
		
	(3)dict_stats_save(table) 将统计信息更新到持久化存储系统表中
	
	下面我们主要讨论的是第(2)步，也就是如何去计算索引的统计信息
					
		
Sql_cmd_analyze_table

	bool Sql_cmd_analyze_table::execute(THD *thd)
	{
	  TABLE_LIST *first_table= thd->lex->select_lex->get_table_list();
	  bool res= TRUE;
	  thr_lock_type lock_type = TL_READ_NO_INSERT;
	  DBUG_ENTER("Sql_cmd_analyze_table::execute");

	  if (check_table_access(thd, SELECT_ACL | INSERT_ACL, first_table,
							 FALSE, UINT_MAX, FALSE))
		goto error;
	  thd->enable_slow_log= opt_log_slow_admin_statements;
	  res= mysql_admin_table(thd, first_table, &thd->lex->check_opt,
							 "analyze", lock_type, 1, 0, 0, 0,
							 &handler::ha_analyze, 0);
	  /* ! we write after unlocking the table */
	  if (!res && !thd->lex->no_write_to_binlog)
	  {
		/*
		  Presumably, ANALYZE and binlog writing doesn't require synchronization
		*/
		-- 写binlog
		res= write_bin_log(thd, true, thd->query().str, thd->query().length);
	  }
	  thd->lex->select_lex->table_list.first= first_table;
	  thd->lex->query_tables= first_table;

	error:
	  DBUG_RETURN(res);
	}



mysql_admin_table
	
	OPTIMIZE/ANALYZE/REPAIR/CHECK TABLE 这些都统一调用 mysql_admin_table 函数进行管理操作
	
	http://mysql.taobao.org/monthly/2014/11/01/
	

	/*
	  RETURN VALUES
		FALSE Message sent to net (admin operation went ok)
		TRUE  Message should be sent by caller 
			  (admin operation or network communication failed)
	*/
	static bool mysql_admin_table(THD* thd, TABLE_LIST* tables,
								  HA_CHECK_OPT* check_opt,
								  const char *operator_name,
								  thr_lock_type lock_type,
								  bool open_for_modify,
								  bool repair_table_use_frm,
								  uint extra_open_options,
								  int (*prepare_func)(THD *, TABLE_LIST *,
													  HA_CHECK_OPT *),
								  int (handler::*operator_func)(THD *,
																HA_CHECK_OPT *),
								  int (view_operator_func)(THD *, TABLE_LIST*))
	{
	  TABLE_LIST *table;
	  SELECT_LEX *select= thd->lex->select_lex;
	  List<Item> field_list;
	  Item *item;
	  Protocol *protocol= thd->get_protocol();
	  LEX *lex= thd->lex;
	  int result_code;
	  bool gtid_rollback_must_be_skipped=
		((thd->variables.gtid_next.type == GTID_GROUP ||
		  thd->variables.gtid_next.type == ANONYMOUS_GROUP) &&
		(!thd->skip_gtid_rollback));
	  DBUG_ENTER("mysql_admin_table");

	  field_list.push_back(item = new Item_empty_string("Table", NAME_CHAR_LEN*2));
	  item->maybe_null = 1;
	  field_list.push_back(item = new Item_empty_string("Op", 10));
	  item->maybe_null = 1;
	  field_list.push_back(item = new Item_empty_string("Msg_type", 10));
	  item->maybe_null = 1;
	  field_list.push_back(item = new Item_empty_string("Msg_text",
														SQL_ADMIN_MSG_TEXT_SIZE));
	  item->maybe_null = 1;
	  if (thd->send_result_metadata(&field_list,
									Protocol::SEND_NUM_ROWS | Protocol::SEND_EOF))
		DBUG_RETURN(TRUE);

	  /*
		Close all temporary tables which were pre-open to simplify
		privilege checking. Clear all references to closed tables.
	  */
	  close_thread_tables(thd);
	  for (table= tables; table; table= table->next_local)
		table->table= NULL;

	  /*
		This statement will be written to the binary log even if it fails.
		But a failing statement calls trans_rollback_stmt which calls
		gtid_state->update_on_rollback, which releases GTID ownership.
		And GTID ownership must be held when the statement is being
		written to the binary log.  Therefore, we set this flag before
		executing the statement. The flag tells
		gtid_state->update_on_rollback to skip releasing ownership.
	  */
	  if (gtid_rollback_must_be_skipped)
		thd->skip_gtid_rollback= true;

	  for (table= tables; table; table= table->next_local)
	  {
		char table_name[NAME_LEN*2+2];
		const char* db = table->db;
		bool fatal_error=0;
		bool open_error;
		bool issue_deprecation_warning= false;

		DBUG_PRINT("admin", ("table: '%s'.'%s'", table->db, table->table_name));
		DBUG_PRINT("admin", ("extra_open_options: %u", extra_open_options));
		strxmov(table_name, db, ".", table->table_name, NullS);
		thd->open_options|= extra_open_options;
		table->lock_type= lock_type;
		/*
		  To make code safe for re-execution we need to reset type of MDL
		  request as code below may change it.
		  To allow concurrent execution of read-only operations we acquire
		  weak metadata lock for them.
		*/
		table->mdl_request.set_type((lock_type >= TL_WRITE_ALLOW_WRITE) ?
									MDL_SHARED_NO_READ_WRITE : MDL_SHARED_READ);
		/* open only one table from local list of command */
		{
		  TABLE_LIST *save_next_global, *save_next_local;
		  save_next_global= table->next_global;
		  table->next_global= 0;
		  save_next_local= table->next_local;
		  table->next_local= 0;
		  select->table_list.first= table;	
	
dict_stats_update 


	/*********************************************************************//**
	Calculates new estimates for table and index statistics. The statistics
	are used in query optimization.
	@return DB_SUCCESS or error code */
	dberr_t
	dict_stats_update(
	/*==============*/
		dict_table_t*		table,	/*!< in/out: table */
		dict_stats_upd_option_t	stats_upd_option)
						/*!< in: whether to (re) calc
						the stats or to fetch them from
						the persistent statistics
						storage */
	{


		/* Persistent recalculation requested, called from
		1) ANALYZE TABLE, or
		2) the auto recalculation background thread, or
		3) open table if stats do not exist on disk and auto recalc
		   is enabled 
		请求重新计算统计值的方式：
			1. 当手动执行ANALYZE TABLE
			2. 进入到自动重新计算后台线程，
			3. 打开的表的stats不存在
		 */
		/* InnoDB internal tables (e.g. SYS_TABLES) cannot have
		persistent stats enabled */
		ut_a(strchr(table->name.m_name, '/') != NULL);

		/* check if the persistent statistics storage exists
		before calling the potentially slow function
		dict_stats_update_persistent(); that is a
		prerequisite for dict_stats_save() succeeding */
		
		-- 1. 检查dict_stats_persistent_storage_check() 检查相关系统表是否存在，不存在报错
		if (dict_stats_persistent_storage_check(false)) {

			dberr_t	err;
			
			-- 2. dict_stats_update_persistent(table) 更新表的统计信息
			/*
				先更新聚集索引，再更新二级索引，均调用函数 dict_stats_analyze_index.
				/* analyze the clustered index first */
				/* analyze other indexes from the table, if any */
			*/
			
			err = dict_stats_update_persistent(table);

			if (err != DB_SUCCESS) {
				return(err);
			}
			
			-- 3. dict_stats_save(table) 将统计信息更新到持久化存储系统表中
			err = dict_stats_save(table, NULL);

			return(err);
		}
		



dict_stats_update_persistent
	
	重新收集的入口函数是 dict_stats_update_persistent()
	
	计算表和索引统计信息的新估计值。
	这个函数相对较慢，用于计算持久的统计数据将保存在磁盘上。

	/*********************************************************************//**
	Calculates new estimates for table and index statistics. This function
	is relatively slow and is used to calculate persistent statistics that
	will be saved on disk.
	@return DB_SUCCESS or error code */
	static
	dberr_t
	dict_stats_update_persistent(
	/*=========================*/
		dict_table_t*	table)		/*!< in/out: table */
	{
		dict_index_t*	index;

		DEBUG_PRINTF("%s(table=%s)\n", __func__, table->name);
		
		-- 持有索引上的s锁
		dict_table_analyze_index_lock(table);

		DEBUG_SYNC_C("innodb_dict_stats_update_persistent");
		
		-- 先更新聚集索引
		/* analyze the clustered index first */

		index = dict_table_get_first_index(table);

		if (index == NULL
			|| dict_index_is_corrupted(index)
			|| (index->type | DICT_UNIQUE) != (DICT_CLUSTERED | DICT_UNIQUE)) {

			/* Table definition is corrupt */
			dict_stats_empty_table(table);
			dict_table_analyze_index_unlock(table);

			return(DB_CORRUPTION);
		}

		ut_ad(!dict_index_is_ibuf(index));

		dict_stats_analyze_index(index);

		ulint	n_unique = dict_index_get_n_unique(index);

		ib_uint64_t stat_n_rows_tmp = index->stat_n_diff_key_vals[n_unique - 1];

		ib_uint64_t stat_clustered_index_size_tmp = index->stat_index_size;

		/* analyze other indexes from the table, if any */

		ib_uint64_t stat_sum_of_other_index_sizes_tmp = 0;

		for (index = dict_table_get_next_index(index);
			 index != NULL;
			 index = dict_table_get_next_index(index)) {

			ut_ad(!dict_index_is_ibuf(index));

			if (index->type & DICT_FTS || dict_index_is_spatial(index)) {
				continue;
			}

			dict_stats_empty_index(index);

			if (dict_stats_should_ignore_index(index)) {
				continue;
			}

			if (!(table->stats_bg_flag & BG_STAT_SHOULD_QUIT)) {
				dict_stats_analyze_index(index);
			}

			stat_sum_of_other_index_sizes_tmp
				+= index->stat_index_size;
		}

		dict_table_stats_lock(table, RW_X_LATCH);

		table->stat_n_rows = stat_n_rows_tmp;

		table->stat_clustered_index_size = stat_clustered_index_size_tmp;

		table->stat_sum_of_other_index_sizes = stat_sum_of_other_index_sizes_tmp;

		table->stats_last_recalc = ut_time_monotonic();

		table->stat_modified_counter = 0;

		table->stat_initialized = TRUE;

		dict_stats_assert_initialized(table);

		dict_table_stats_unlock(table, RW_X_LATCH);

		dict_table_analyze_index_unlock(table);

		return(DB_SUCCESS);
	}


dict_stats_analyze_index
	/*********************************************************************//**
	Calculates new statistics for a given index and saves them to the index
	members stat_n_diff_key_vals[], stat_n_sample_sizes[], stat_index_size and
	stat_n_leaf_pages. This function could be slow. */
	static
	void
	dict_stats_analyze_index(
	/*=====================*/
		dict_index_t*	index)	/*!< in/out: index to analyze */
	{
		ulint		root_level;
		ulint		level;
		bool		level_is_analyzed;
		ulint		n_uniq;
		ulint		n_prefix;
		ib_uint64_t	total_recs;
		ib_uint64_t	total_pages;
		mtr_t		mtr;
		ulint		size;
		DBUG_ENTER("dict_stats_analyze_index");
		
	

dict_table_analyze_index_lock
	
	/** Acquire the analyze index lock.
	@param[in]	table table whose analyze_index latch to lock */
	void
	dict_table_analyze_index_lock(
		dict_table_t*	table)
	{
		os_once::do_or_wait_for_done(
			&table->analyze_index_mutex_created,
			dict_table_analyze_index_alloc, table);

		mutex_enter(table->analyze_index_mutex);
	}



dict_stats_save
	
	/** Save the table's statistics into the persistent statistics storage.
	@param[in]	table_orig	table whose stats to save
	@param[in]	only_for_index	if this is non-NULL, then stats for indexes
	that are not equal to it will not be saved, if NULL, then all indexes' stats
	are saved
	@return DB_SUCCESS or error code */
	static
	dberr_t
	dict_stats_save(
		dict_table_t*		table_orig,
		const index_id_t*	only_for_index)
	{
		pars_info_t*	pinfo;
		lint		now;
		dberr_t		ret;
		dict_table_t*	table;
		char		db_utf8[MAX_DB_UTF8_LEN];
		char		table_utf8[MAX_TABLE_UTF8_LEN];

		table = dict_stats_snapshot_create(table_orig);

		dict_fs2utf8(table->name.m_name, db_utf8, sizeof(db_utf8),
				 table_utf8, sizeof(table_utf8));
		
		-- 锁数据字典？
		rw_lock_x_lock(dict_operation_lock);
		mutex_enter(&dict_sys->mutex);

		/* MySQL's timestamp is 4 byte, so we use
		pars_info_add_int4_literal() which takes a lint arg, so "now" is
		lint */
		now = (lint) ut_time();

		pinfo = pars_info_create();

		pars_info_add_str_literal(pinfo, "database_name", db_utf8);
		pars_info_add_str_literal(pinfo, "table_name", table_utf8);
		pars_info_add_int4_literal(pinfo, "last_update", now);
		pars_info_add_ull_literal(pinfo, "n_rows", table->stat_n_rows);
		pars_info_add_ull_literal(pinfo, "clustered_index_size",
			table->stat_clustered_index_size);
		pars_info_add_ull_literal(pinfo, "sum_of_other_index_sizes",
			table->stat_sum_of_other_index_sizes);
		
		
		ret = dict_stats_exec_sql(
			pinfo,
			"PROCEDURE TABLE_STATS_SAVE () IS\n"
			"BEGIN\n"

			"DELETE FROM \"" TABLE_STATS_NAME "\"\n"
			"WHERE\n"
			"database_name = :database_name AND\n"
			"table_name = :table_name;\n"

			"INSERT INTO \"" TABLE_STATS_NAME "\"\n"
			"VALUES\n"
			"(\n"
			":database_name,\n"
			":table_name,\n"
			":last_update,\n"
			":n_rows,\n"
			":clustered_index_size,\n"
			":sum_of_other_index_sizes\n"
			");\n"
			"END;", NULL);

		if (ret != DB_SUCCESS) {
			ib::error() << "Cannot save table statistics for table "
				<< table->name << ": " << ut_strerr(ret);

			mutex_exit(&dict_sys->mutex);
			rw_lock_x_unlock(dict_operation_lock);

			dict_stats_snapshot_free(table);

			return(ret);
		}

		trx_t*	trx = trx_allocate_for_background();

		if (srv_read_only_mode) {
			trx_start_internal_read_only(trx);
		} else {
			trx_start_internal(trx);
		}

		dict_index_t*	index;
		index_map_t	indexes(
			(ut_strcmp_functor()),
			index_map_t_allocator(mem_key_dict_stats_index_map_t));

		/* Below we do all the modifications in innodb_index_stats in a single
		transaction for performance reasons. Modifying more than one row in a
		single transaction may deadlock with other transactions if they
		lock the rows in different order. Other transaction could be for
		example when we DROP a table and do
		DELETE FROM innodb_index_stats WHERE database_name = '...'
		AND table_name = '...'; which will affect more than one row. To
		prevent deadlocks we always lock the rows in the same order - the
		order of the PK, which is (database_name, table_name, index_name,
		stat_name). This is why below we sort the indexes by name and then
		for each index, do the mods ordered by stat_name. */

		for (index = dict_table_get_first_index(table);
			 index != NULL;
			 index = dict_table_get_next_index(index)) {

			indexes[index->name] = index;
		}

		index_map_t::const_iterator	it;

		for (it = indexes.begin(); it != indexes.end(); ++it) {

			index = it->second;

			if (only_for_index != NULL && index->id != *only_for_index) {
				continue;
			}

			if (dict_stats_should_ignore_index(index)) {
				continue;
			}

			ut_ad(!dict_index_is_ibuf(index));

			for (ulint i = 0; i < index->n_uniq; i++) {

				char	stat_name[16];
				char	stat_description[1024];
				ulint	j;

				ut_snprintf(stat_name, sizeof(stat_name),
						"n_diff_pfx%02lu", i + 1);

				/* craft a string that contains the column names */
				ut_snprintf(stat_description,
						sizeof(stat_description),
						"%s", index->fields[0].name());
				for (j = 1; j <= i; j++) {
					size_t	len;

					len = strlen(stat_description);

					ut_snprintf(stat_description + len,
							sizeof(stat_description) - len,
							",%s", index->fields[j].name());
				}

				ret = dict_stats_save_index_stat(
					index, now, stat_name,
					index->stat_n_diff_key_vals[i],
					&index->stat_n_sample_sizes[i],
					stat_description, trx);

				if (ret != DB_SUCCESS) {
					goto end;
				}
			}

			ret = dict_stats_save_index_stat(index, now, "n_leaf_pages",
							 index->stat_n_leaf_pages,
							 NULL,
							 "Number of leaf pages "
							 "in the index", trx);
			if (ret != DB_SUCCESS) {
				goto end;
			}

			ret = dict_stats_save_index_stat(index, now, "size",
							 index->stat_index_size,
							 NULL,
							 "Number of pages "
							 "in the index", trx);
			if (ret != DB_SUCCESS) {
				goto end;
			}
		}
		
		-- 事务提交
		trx_commit_for_mysql(trx);

	end:
		trx_free_for_background(trx);

		mutex_exit(&dict_sys->mutex);
		rw_lock_x_unlock(dict_operation_lock);

		dict_stats_snapshot_free(table);

		return(ret);
	}



/* 释放数据字典的排他锁。 */
row_mysql_unlock_data_dictionary(trx);




/** Duplicate the stats of a table and its indexes.
This function creates a dummy dict_table_t object and copies the input
table's stats into it. The returned table object is not in the dictionary
cache and cannot be accessed by any other threads. In addition to the
members copied in dict_stats_table_clone_create() this function initializes
the following:
dict_table_t::stat_initialized
dict_table_t::stat_persistent
dict_table_t::stat_n_rows
dict_table_t::stat_clustered_index_size
dict_table_t::stat_sum_of_other_index_sizes
dict_table_t::stat_modified_counter
dict_index_t::stat_n_diff_key_vals[]
dict_index_t::stat_n_sample_sizes[]
dict_index_t::stat_n_non_null_key_vals[]
dict_index_t::stat_index_size
dict_index_t::stat_n_leaf_pages
The returned object should be freed with dict_stats_snapshot_free()
when no longer needed.
@param[in]	table	table whose stats to copy
@return incomplete table object */
static
dict_table_t*
dict_stats_snapshot_create(
	dict_table_t*	table)
{
	mutex_enter(&dict_sys->mutex);

	dict_table_stats_lock(table, RW_S_LATCH);

	dict_stats_assert_initialized(table);

	dict_table_t*	t;

	t = dict_stats_table_clone_create(table);

	dict_stats_copy(t, table);

	t->stat_persistent = table->stat_persistent;
	t->stats_auto_recalc = table->stats_auto_recalc;
	t->stats_sample_pages = table->stats_sample_pages;
	t->stats_bg_flag = table->stats_bg_flag;

	dict_table_stats_unlock(table, RW_S_LATCH);

	mutex_exit(&dict_sys->mutex);

	return(t);
}

/*********************************************************************//**
Free the resources occupied by an object returned by
dict_stats_snapshot_create(). */
static
void
dict_stats_snapshot_free(
/*=====================*/
	dict_table_t*	t)	/*!< in: dummy table object to free */
{
	dict_stats_table_clone_free(t);
}

