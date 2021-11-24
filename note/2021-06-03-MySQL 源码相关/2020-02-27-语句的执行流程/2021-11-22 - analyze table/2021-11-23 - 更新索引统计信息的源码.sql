
dict_stats_thread后台线程
row_update_for_mysql_using_upd_graph
row_update_statistics_if_needed
dict_stats_recalc_pool_add
DECLARE_THREAD
dict_stats_process_entry_from_recalc_pool
dict_stats_update


dict_stats_thread后台线程

	mysql> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	........................................................................
	|     32 |        19576 | innodb/dict_stats_thread        | BACKGROUND |
	........................................................................
	+--------+--------------+---------------------------------+------------+
	118 rows in set (0.90 sec)
	
	
	Thread 40 (Thread 0x7f0091be7700 (LWP 13309)):
	#0  0x00007f02e5d39de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7f0091be6dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
	#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x1017b838, time_in_usec=<optimized out>, reset_sig_count=537) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
	#3  0x0000000001246297 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/dict/dict0stats_bg.cc:428
	#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
		



	-- 用户线程发起

	#10 0x0000000001a13464 in row_update_for_mysql_using_upd_graph (mysql_rec=0x5e9d470 "\374\b", prebuilt=0x5ec4500) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2574
	#11 0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x5e9d470 "\374\b", prebuilt=0x5ec4500) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665





row_update_for_mysql_using_upd_graph


	/** Does an update or delete of a row for MySQL.
	@param[in]	mysql_rec	row in the MySQL format
	@param[in,out]	prebuilt	prebuilt struct in MySQL handle
	@return error code or DB_SUCCESS */
	static
	dberr_t
	row_update_for_mysql_using_upd_graph(


		/* We update table statistics only if it is a DELETE or UPDATE
		that changes indexed columns, UPDATEs that change only non-indexed
		columns would not affect statistics. */
		
		/*
			修改表的统计信息 statistics 的2个条件，只要满足其中1个条件就会统计到修改表的行数中：
				1. 只会在DELETE或者UPDATE有更改到索引列，如果只更新到非索引列，那就不会影响统计信息。
				2. delete肯定会影响到所有列，所以直接进入 row_update_statistics_if_needed 函数
		*/
		
		if (node->is_delete || !(node->cmpl_info & UPD_NODE_NO_ORD_CHANGE)) {
			row_update_statistics_if_needed(prebuilt->table);
		}
		
	

row_update_statistics_if_needed

	/*********************************************************************//**
	Updates the table modification counter and calculates new estimates
	for table and index statistics if necessary. */

	/*
		调用函数row_update_statistics_if_needed判断是否需要更新统计信息
	*/

	UNIV_INLINE
	void
	row_update_statistics_if_needed(
	/*============================*/
		dict_table_t*	table)	/*!< in: table */
	{
		ib_uint64_t	counter;
		ib_uint64_t	n_rows;

		if (!table->stat_initialized) {
			DBUG_EXECUTE_IF(
				"test_upd_stats_if_needed_not_inited",
				fprintf(stderr, "test_upd_stats_if_needed_not_inited"
					" was executed\n");
			);
			return;
		}
		
		-- stat_modified_counter记录该表修改的行数，不包括 insert
		counter = table->stat_modified_counter++;
		
		-- 获取表的总行数，应该是从information_schmea.tables获取
		n_rows = dict_table_get_n_rows(table);
		
		 -- 判断表是否启用持久统计信息，默认值都是true；
		if (dict_stats_is_persistent_enabled(table)) {
			
			--  如果修改表的行数超过10%，并且启用自动重新计算统计信息（默认true），
			if (counter > n_rows / 10 /* 10% */ && dict_stats_auto_recalc_is_enabled(table)) {
				-- 把表的ID放进 recalc_pool ，发送dict_stats_event事件， 设置 stat_modified_counter 为0
				dict_stats_recalc_pool_add(table);
				table->stat_modified_counter = 0;
			}
			-- 以上条件不满足，直接return，不进行下面的判断
			return;
		}

		/* Calculate new statistics if 1 / 16 of table has been modified
		since the last time a statistics batch was run.
		We calculate statistics at most every 16th round, since we may have
		a counter table which is very small and updated very often. */
		
		-- 没有启用持久化统计信息
		-- 当发现修改的记录超过6.25%(1/16)时，更新统计信息 dict_stats_update(table, DICT_STATS_RECALC_TRANSIENT)->dict_stats_update_transient
		if (counter > 16 + n_rows / 16 /* 6.25% */) {

			ut_ad(!mutex_own(&dict_sys->mutex));
			/* this will reset table->stat_modified_counter to 0 */
			dict_stats_update(table, DICT_STATS_RECALC_TRANSIENT);
		}
	}


获取表中大约估计的行数。？从哪里获取
E:\github\mysql-5.7.26\storage\innobase\include\dict0dict.ic
/********************************************************************//**
Gets the approximately estimated number of rows in the table.
@return estimated number of rows */
UNIV_INLINE
ib_uint64_t
dict_table_get_n_rows(
/*==================*/
	const dict_table_t*	table)	/*!< in: table */
{
	ut_ad(table->stat_initialized);

	return(table->stat_n_rows);
}

dict_stats_recalc_pool_add

	/*****************************************************************//**
	Add a table to the recalc pool, which is processed by the
	background stats gathering thread. Only the table id is added to the
	list, so the table can be closed after being enqueued and it will be
	opened when needed. If the table does not exist later (has been DROPped),
	then it will be removed from the pool and skipped. */
	void
	dict_stats_recalc_pool_add(
	/*=======================*/
		const dict_table_t*	table)	/*!< in: table to add */
	{
		ut_ad(!srv_read_only_mode);

		mutex_enter(&recalc_pool_mutex);

		/* quit if already in the list */
		for (recalc_pool_iterator_t iter = recalc_pool->begin();
			 iter != recalc_pool->end();
			 ++iter) {

			if (*iter == table->id) {
				mutex_exit(&recalc_pool_mutex);
				return;
			}
		}
		
		--  该表的id加入到 recalc_pool 中，后面直接跳转到线程处理中 DECLARE_THREAD
		recalc_pool->push_back(table->id);

		mutex_exit(&recalc_pool_mutex);
		
		-- 发送dict_stats_event事件
		os_event_set(dict_stats_event);
	}



DECLARE_THREAD  声明线程

	/*
		这是后台统计数据收集的线程， 不断去拉取 recalc_pool 的第一个值，然后进行计算 
		它弹出表格，从自动重新计算列表并处理它们，最终重新计算它们统计数据
	*/
	/*****************************************************************//**
	This is the thread for background stats gathering. It pops tables, from
	the auto recalc list and proceeds them, eventually recalculating their
	statistics.
	@return this function does not return, it calls os_thread_exit() */
	extern "C"
	os_thread_ret_t
	DECLARE_THREAD(dict_stats_thread)(
	/*==============================*/
		void*	arg MY_ATTRIBUTE((unused)))	/*!< in: a dummy parameter
							required by os_thread_create */
	{
		ut_a(!srv_read_only_mode);

		my_thread_init();

	#ifdef UNIV_PFS_THREAD
		pfs_register_thread(dict_stats_thread_key);
	#endif /* UNIV_PFS_THREAD */

		srv_dict_stats_thread_active = TRUE;

		while (!dict_stats_start_shutdown) {

			/* Wake up periodically even if not signaled. This is
			because we may lose an event - if the below call to
			dict_stats_process_entry_from_recalc_pool() puts the entry back
			in the list, the os_event_set() will be lost by the subsequent
			os_event_reset(). */
			
			/*
				即使没有发出信号，也会定期唤醒。
				这是因为我们可能会丢失一个事件 - 如果下面调用
				dict_stats_process_entry_from_recalc_pool() 将条目放回列表中，os_event_set() 将被后续的 os_event_reset 丢失
			*/
			
			os_event_wait_time(
				dict_stats_event, MIN_RECALC_INTERVAL * 1000000);

	#ifdef UNIV_DEBUG
			while (innodb_dict_stats_disabled_debug) {
				os_event_set(dict_stats_disabled_event);
				if (dict_stats_start_shutdown) {
					break;
				}
				os_event_wait_time(
					dict_stats_event, 100000);
			}
	#endif /* UNIV_DEBUG */

			if (dict_stats_start_shutdown) {
				break;
			}

			dict_stats_process_entry_from_recalc_pool();

			os_event_reset(dict_stats_event);
		}

		srv_dict_stats_thread_active = FALSE;

		os_event_set(dict_stats_shutdown_event);
		my_thread_end();

		/* We count the number of threads in os_thread_exit(). A created
		thread should always use that to exit instead of return(). */
		os_thread_exit();

		OS_THREAD_DUMMY_RETURN;
	}
	
	
dict_stats_process_entry_from_recalc_pool
		
	/*****************************************************************//**
	Get the first table that has been added for auto recalc and eventually
	update its stats. */
	-- 获取为自动重新计算并最终添加的第一个表更新其统计数据

	static
	void
	dict_stats_process_entry_from_recalc_pool()
	/*=======================================*/
	{
		table_id_t	table_id;

		ut_ad(!srv_read_only_mode);

		/* pop the first table from the auto recalc pool */
		if (!dict_stats_recalc_pool_get(&table_id)) {
			/* no tables for auto recalc */
			return;
		}

		dict_table_t*	table;

		mutex_enter(&dict_sys->mutex);

		table = dict_table_open_on_id(table_id, TRUE, DICT_TABLE_OP_NORMAL);

		if (table == NULL) {
			/* table does not exist, must have been DROPped
			after its id was enqueued */
			mutex_exit(&dict_sys->mutex);
			return;
		}

		if (fil_space_is_being_truncated(table->space)) {
			dict_table_close(table, TRUE, FALSE);
			mutex_exit(&dict_sys->mutex);
			return;
		}

		/* Check whether table is corrupted */
		if (table->corrupted) {
			dict_table_close(table, TRUE, FALSE);
			mutex_exit(&dict_sys->mutex);
			return;
		}

		table->stats_bg_flag = BG_STAT_IN_PROGRESS;

		mutex_exit(&dict_sys->mutex);

		/* ut_time() could be expensive, the current function
		is called once every time a table has been changed more than 10% and
		on a system with lots of small tables, this could become hot. If we
		find out that this is a problem, then the check below could eventually
		be replaced with something else, though a time interval is the natural
		approach. */
		
		/*
		
		如果该表在10秒内 已经计算过一次，那么就把该表重新放到 recalc_pool 尾部，不做任何处理(等待下一次统计)。
		否则： 否则真正进入 dict_stats_update 修改统计值
		实际上 DICT_STATS_RECALC_PERSISTENT 类型的状态信息更新，也会由 ANALYZE TABLE 发起

		*/
		if (ut_difftime(ut_time(), table->stats_last_recalc)
			< MIN_RECALC_INTERVAL) {

			/* Stats were (re)calculated not long ago. To avoid
			too frequent stats updates we put back the table on
			the auto recalc list and do nothing. */

			dict_stats_recalc_pool_add(table);

		} else {

			dict_stats_update(table, DICT_STATS_RECALC_PERSISTENT);
		}

		mutex_enter(&dict_sys->mutex);

		table->stats_bg_flag = BG_STAT_NONE;

		dict_table_close(table, TRUE, FALSE);

		mutex_exit(&dict_sys->mutex);
	}



dict_stats_update 

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
	
	
	-> dict_stats_update_persistent

	-> dict_stats_save

	

		
		

	