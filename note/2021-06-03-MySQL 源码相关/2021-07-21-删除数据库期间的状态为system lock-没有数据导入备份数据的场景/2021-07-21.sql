

表的个数：
	mysql> SELECT count(*) TABLES, table_schema FROM information_schema.TABLES where table_schema = 'sbtest' GROUP BY table_schema; 
	+--------+--------------+
	| TABLES | table_schema |
	+--------+--------------+
	|  10347 | sbtest       |
	+--------+--------------+
	1 row in set (0.04 sec)



show processlist语句查看SQL语句处于什么状态

	root@mysqldb 15:15:  [(none)]> show processlist;
	+-----+----------+-----------------------+-------------+---------+-------+-------------+----------------------+
	| Id  | User     | Host                  | db          | Command | Time  | State       | Info                 |
	+-----+----------+-----------------------+-------------+---------+-------+-------------+----------------------+
	|  27 | root     | localhost             | NULL        | Query   |     0 | starting    | show processlist     |
	|  31 | dpc_user | h_tt_aaa.com.cn:49766 | niuniuh5_db | Sleep   | 17915 |             | NULL                 |
	|  33 | dpc_user | 192.168.0.204:60104   | niuniuh5_db | Sleep   |  2939 |             | NULL                 |
	|  34 | dpc_user | 192.168.0.204:60106   | niuniuh5_db | Sleep   |  2939 |             | NULL                 |
	| 133 | root     | 192.168.0.220:54072   | NULL        | Sleep   |  1195 |             | NULL                 |
	| 134 | root     | 192.168.0.220:54081   | NULL        | Sleep   |  1343 |             | NULL                 |
	| 135 | root     | 192.168.0.220:54083   | NULL        | Sleep   |  1232 |             | NULL                 |
	| 331 | dpc_user | 192.168.0.243:57228   | niuniuh5_db | Sleep   |   334 |             | NULL                 |
	| 333 | root     | localhost             | NULL        | Query   |     5 | System lock | drop database sbtest |
	+-----+----------+-----------------------+-------------+---------+-------+-------------+----------------------+
	106 rows in set (0.00 sec)

	root@mysqldb 15:17:  [(none)]> kill 333;
	Query OK, 0 rows affected (0.00 sec)


	root@mysqldb 15:16:  [(none)]> drop database sbtest;
	ERROR 2013 (HY000): Lost connection to MySQL server during query


mysql的线程处于System lock状态下
	
	这个线程是被 mysql_lock_tables()调用的。这种状态可能是很多种原因造成的。

	例如：
		一个线程想请求或者正在等一个表的内部或者外部的system lock；

		也可能是InnoDB在执行lock tables的时候，等表级锁；

		也可能是请求内部锁，比如访问相同MyISM表没有用多个mysqld服务;

	如果是在show profile的时候遇到这种状态，就说明这个线程正在请求锁（不是等）。

	
	mysql_lock_tables()函数：
		-- mysql-5.7.26\sql\lock.cc
			
		/**
		   Lock tables.

		   @param thd          The current thread.
		   @param tables       An array of pointers to the tables to lock.
		   @param count        The number of tables to lock.
		   @param flags        Options:
						 MYSQL_LOCK_IGNORE_GLOBAL_READ_ONLY Ignore SET GLOBAL READ_ONLY
						 MYSQL_LOCK_IGNORE_TIMEOUT          Use maximum timeout value.

		   @retval  A lock structure pointer on success.
		   @retval  NULL if an error or if wait on a lock was killed.
		*/

		MYSQL_LOCK *mysql_lock_tables(THD *thd, TABLE **tables, size_t count, uint flags)
		{
		  int rc;
		  MYSQL_LOCK *sql_lock;
		  ulong timeout= (flags & MYSQL_LOCK_IGNORE_TIMEOUT) ?
			LONG_TIMEOUT : thd->variables.lock_wait_timeout;

		  DBUG_ENTER("mysql_lock_tables");

		  if (lock_tables_check(thd, tables, count, flags))
			DBUG_RETURN(NULL);

		  if (! (sql_lock= get_lock_data(thd, tables, count, GET_LOCK_STORE_LOCKS)))
			DBUG_RETURN(NULL);

		  THD_STAGE_INFO(thd, stage_system_lock);
		  DBUG_PRINT("info", ("thd->proc_info %s", thd->proc_info));
		  if (sql_lock->table_count && lock_external(thd, sql_lock->table,
													 sql_lock->table_count))
		  {
			/* Clear the lock type of all lock data to avoid reusage. */
			reset_lock_data_and_free(&sql_lock);
			goto end;
		  }

		  /* Copy the lock data array. thr_multi_lock() reorders its contents. */
		  memcpy(sql_lock->locks + sql_lock->lock_count, sql_lock->locks,
				 sql_lock->lock_count * sizeof(*sql_lock->locks));
		  /* Lock on the copied half of the lock data array. */
		  rc= thr_lock_errno_to_mysql[(int) thr_multi_lock(sql_lock->locks +
														   sql_lock->lock_count,
														   sql_lock->lock_count,
														   &thd->lock_info, timeout)];

		  DBUG_EXECUTE_IF("mysql_lock_tables_kill_query",
						  thd->killed= THD::KILL_QUERY;);

		  if (rc)
		  {
			if (sql_lock->table_count)
			  (void) unlock_external(thd, sql_lock->table, sql_lock->table_count);
			reset_lock_data_and_free(&sql_lock);
			if (! thd->killed)
			  my_error(rc, MYF(0));
		  }

		end:
		  if (!(flags & MYSQL_OPEN_IGNORE_KILLED) && thd->killed)
		  {
			thd->send_kill_message();
			if (sql_lock)
			{
			  mysql_unlock_tables(thd, sql_lock);
			  sql_lock= 0;
			}
		  }

		  if (thd->variables.session_track_transaction_info > TX_TRACK_NONE)
			track_table_access(thd, tables, count);

		  thd->set_time_after_lock();
		  DBUG_RETURN(sql_lock);
		}



生成mysql进程10秒内资源消耗采样报告

	注意：下面命令在生产上执行时有较低概率会导致服务器hang死

	#生成mysql进程10秒内资源消耗采样报告

	sudo perf record -p `pidof mysqld` -g -o /tmp/perf.data sleep 10

	#查看报告
	perf report -i /tmp/perf.data
	
	Samples: 1K of event 'cycles:ppp', Event count (approx.): 514150605                                                                                                                                                                                                           
	  Children      Self  Command  Shared Object        Symbol                                                                                                                                                                                                                    
	+   95.39%     0.00%  mysqld   libpthread-2.17.so   [.] start_thread
	+   53.43%     0.32%  mysqld   mysqld               [.] que_run_threads
	+   48.83%    48.57%  mysqld   mysqld               [.] ut_delay
	+   46.84%     0.00%  mysqld   mysqld               [.] pfs_spawn_thread
	+   46.84%     0.00%  mysqld   mysqld               [.] handle_connection
	+   46.84%     0.00%  mysqld   mysqld               [.] do_command
	+   46.56%     0.00%  mysqld   mysqld               [.] dispatch_command
	+   46.44%     0.00%  mysqld   mysqld               [.] mysql_parse
	+   45.46%     0.21%  mysqld   mysqld               [.] mysql_execute_command
	+   44.67%     0.25%  mysqld   mysqld               [.] row_purge_step
	+   34.22%     0.00%  mysqld   mysqld               [.] srv_worker_thread
	+   26.45%     0.19%  mysqld   mysqld               [.] rw_lock_s_lock_spin
	+   23.64%     0.00%  mysqld   mysqld               [.] execute_sqlcom_select
	+   22.00%     0.00%  mysqld   mysqld               [.] open_tables_for_query
	+   22.00%     0.00%  mysqld   mysqld               [.] open_tables
	+   21.14%     0.00%  mysqld   mysqld               [.] mysql_rm_db
	+   21.04%     0.07%  mysqld   mysqld               [.] mysql_rm_table_no_locks
	+   19.17%     0.00%  mysqld   mysqld               [.] ha_delete_table
	+   19.15%     0.00%  mysqld   mysqld               [.] ha_innobase::delete_table
	+   19.09%     0.00%  mysqld   mysqld               [.] handler::ha_open
	+   18.83%     0.00%  mysqld   mysqld               [.] row_drop_table_for_mysql
	+   18.78%     0.17%  mysqld   mysqld               [.] que_eval_sql
	+   18.27%     0.13%  mysqld   mysqld               [.] ha_innobase::open
	+   16.98%     0.13%  mysqld   mysqld               [.] row_purge_remove_clust_if_poss_low
	+   13.86%     0.39%  mysqld   mysqld               [.] btr_cur_search_to_nth_level
	+   13.52%     0.00%  mysqld   mysqld               [.] handle_query
	+   13.23%     0.00%  mysqld   mysqld               [.] JOIN::exec
	+   12.80%     0.00%  mysqld   mysqld               [.] JOIN::prepare_result
	+   12.80%     0.00%  mysqld   mysqld               [.] get_schema_tables_result
	+   12.57%     0.00%  mysqld   mysqld               [.] do_fill_table
	+   12.57%     0.00%  mysqld   mysqld               [.] get_all_tables
	+   12.44%     0.00%  mysqld   mysqld               [.] fill_schema_table_by_open
	+   12.17%     0.98%  mysqld   mysqld               [.] PolicyMutex<TTASEventMutex<GenericPolicy> >::enter
	+   11.89%     0.14%  mysqld   mysqld               [.] open_table
	+   11.83%     0.00%  mysqld   [kernel.kallsyms]    [k] system_call_fastpath
	+   11.08%     0.00%  mysqld   mysqld               [.] open_table_from_share
	+   10.70%     0.00%  mysqld   mysqld               [.] srv_purge_coordinator_thread
	+   10.70%     0.00%  mysqld   mysqld               [.] trx_purge
	+   10.11%     0.00%  mysqld   mysqld               [.] mysql_schema_table
	+   10.11%     0.00%  mysqld   mysqld               [.] create_schema_table
	+    9.82%     0.22%  mysqld   mysqld               [.] create_tmp_table
	+    9.48%     0.00%  mysqld   mysqld               [.] instantiate_tmp_table
	+    9.43%     0.00%  mysqld   mysqld               [.] dict_stats_update
	+    8.35%     0.00%  mysqld   mysqld               [.] open_tmp_table
	+    7.85%     1.62%  mysqld   mysqld               [.] buf_page_get_gen
	+    6.94%     0.00%  mysqld   mysqld               [.] row_search_on_row_ref
	+    5.54%     0.08%  mysqld   mysqld               [.] row_upd_step
	+    5.46%     0.00%  mysqld   mysqld               [.] row_upd
	+    5.40%     0.00%  mysqld   mysqld               [.] dict_stats_drop_table
	+    5.40%     0.00%  mysqld   mysqld               [.] dict_stats_exec_sql
	+    5.30%     0.00%  mysqld   mysqld               [.] btr_pcur_restore_position_func
	+    5.27%     0.00%  mysqld   mysqld               [.] row_upd_clust_step
	+    4.23%     0.21%  mysqld   mysqld               [.] rw_lock_sx_lock_func
