

表的个数：
	mysql> SELECT count(*) TABLES, table_schema FROM information_schema.TABLES where table_schema = 'sbtest' GROUP BY table_schema; 
	+--------+--------------+
	| TABLES | table_schema |
	+--------+--------------+
	|  10347 | sbtest       |
	+--------+--------------+
	1 row in set (0.04 sec)



show processlist语句查看SQL语句处于什么状态
	root@mysqldb 10:08:  [(none)]> show processlist;
	+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------+
	| Id | User | Host                | db          | Command | Time | State          | Info                                                 |
	+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------+
	| 16 | root | localhost           | NULL        | Query   | 1161 | System lock    | drop database sbtest                                 |
	| 18 | root | localhost           | niuniuh5_db | Query   |    0 | Opening tables | LOCK TABLES `table_third_score_detail20210303` WRITE |
	| 21 | root | 192.168.0.220:50181 | NULL        | Sleep   |  523 |                | NULL                                                 |
	| 22 | root | 192.168.0.220:50183 | niuniuh5_db | Sleep   |  522 |                | NULL                                                 |
	| 23 | root | localhost           | NULL        | Query   |    0 | starting       | show processlist                                     |
	+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------+
	5 rows in set (0.00 sec)

	root@mysqldb 10:08:  [(none)]> kill 16;
	Query OK, 0 rows affected (0.00 sec)

	root@mysqldb 10:11:  [(none)]> show processlist;
	+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------------------------------------------------------+
	| Id | User | Host                | db          | Command | Time | State          | Info                                                                                                 |
	+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------------------------------------------------------+
	| 18 | root | localhost           | niuniuh5_db | Query   |    1 | query end      | CREATE TABLE `table_web_redemptionlog` (
	  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 嫠  |
	| 21 | root | 192.168.0.220:50181 | NULL        | Sleep   |  783 |                | NULL                                                                                                 |
	| 22 | root | 192.168.0.220:50183 | niuniuh5_db | Sleep   |  782 |                | NULL                                                                                                 |
	| 23 | root | localhost           | NULL        | Query   |    0 | starting       | show processlist                                                                                     |
	| 25 | root | 192.168.0.220:58031 | sbtest      | Query   |   49 | Opening tables | SHOW TABLE STATUS                                                                                    |
	| 26 | root | localhost           | sbtest      | Sleep   |   24 |                | NULL                                                                                                 |
	+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------------------------------------------------------+
	6 rows in set (0.00 sec)


生成mysql进程10秒内资源消耗采样报告

	注意：下面命令在生产上执行时有较低概率会导致服务器hang死

	#生成mysql进程10秒内资源消耗采样报告

	sudo perf record -p `pidof mysqld` -g -o /tmp/perf.data sleep 10

	#查看报告
	perf report -i /tmp/perf.data

	Samples: 4K of event 'cycles:ppp', Event count (approx.): 2959117280                                                                                                                                                                                                          
	  Children      Self  Command  Shared Object        Symbol                                                                                                                                                                                                                    
	+   99.76%     0.00%  mysqld   libpthread-2.17.so   [.] start_thread
	+   86.82%     0.00%  mysqld   mysqld               [.] srv_purge_coordinator_thread
	+   69.90%     0.00%  mysqld   libc-2.17.so         [.] __sched_yield
	+   40.26%     0.34%  mysqld   [kernel.kallsyms]    [k] system_call_fastpath
	+   36.11%     2.09%  mysqld   [kernel.kallsyms]    [k] sys_sched_yield
	+   33.13%     9.00%  mysqld   [kernel.kallsyms]    [k] __schedule
	+   15.05%     1.90%  mysqld   mysqld               [.] trx_purge
	+   10.75%     3.64%  mysqld   mysqld               [.] srv_get_task_queue_length
	+   10.52%     4.76%  mysqld   [kernel.kallsyms]    [k] put_prev_task_fair
	+   10.21%     0.58%  mysqld   [kernel.kallsyms]    [k] sysret_audit
	+    9.63%     6.70%  mysqld   [kernel.kallsyms]    [k] __audit_syscall_exit
	+    9.25%     1.87%  mysqld   [kernel.kallsyms]    [k] auditsys
	+    8.50%     5.94%  mysqld   mysqld               [.] PolicyMutex<TTASEventMutex<GenericPolicy> >::enter
	+    7.74%     0.00%  mysqld   mysqld               [.] que_run_threads
	+    7.55%     6.81%  mysqld   [kernel.kallsyms]    [k] __audit_syscall_entry
	+    7.54%     0.00%  mysqld   mysqld               [.] pfs_spawn_thread
	+    7.54%     0.00%  mysqld   mysqld               [.] handle_connection
	+    7.54%     0.01%  mysqld   mysqld               [.] do_command
	+    7.52%     0.02%  mysqld   mysqld               [.] dispatch_command
	+    7.38%     0.00%  mysqld   mysqld               [.] mysql_parse
	+    7.04%     0.00%  mysqld   mysqld               [.] mysql_execute_command
	+    5.93%     0.00%  mysqld   mysqld               [.] row_purge_step
	+    5.88%     2.67%  mysqld   [kernel.kallsyms]    [k] pick_next_task_fair
	+    5.64%     5.64%  mysqld   mysqld               [.] ut_delay
	+    4.86%     4.86%  mysqld   [kernel.kallsyms]    [k] system_call_after_swapgs
	+    4.66%     1.05%  mysqld   [kernel.kallsyms]    [k] update_rq_clock.part.78
	+    4.61%     3.22%  mysqld   [kernel.kallsyms]    [k] update_curr
	+    4.13%     0.02%  mysqld   mysqld               [.] mysql_rm_table_no_locks
	+    4.11%     0.00%  mysqld   mysqld               [.] mysql_rm_db
	+    4.08%     0.00%  mysqld   mysqld               [.] ha_delete_table
	+    4.07%     0.00%  mysqld   mysqld               [.] ha_innobase::delete_table
	+    4.05%     0.00%  mysqld   mysqld               [.] row_drop_table_for_mysql
	+    3.95%     0.00%  mysqld   mysqld               [.] srv_worker_thread
	+    3.74%     0.96%  mysqld   [kernel.kallsyms]    [k] sched_clock_cpu
	+    3.47%     0.03%  mysqld   mysqld               [.] rw_lock_s_lock_spin
	+    2.93%     2.93%  mysqld   [unknown]            [k] 0x00007fbccd9d4775
	+    2.83%     1.83%  mysqld   [kernel.kallsyms]    [k] set_next_entity
	+    2.72%     0.41%  mysqld   [kernel.kallsyms]    [k] sched_clock
	+    2.70%     2.70%  mysqld   [kernel.kallsyms]    [k] native_sched_clock
	+    2.18%     2.18%  mysqld   mysqld               [.] pfs_start_mutex_wait_v1
	+    1.87%     0.00%  mysqld   mysqld               [.] fil_delete_tablespace
	+    1.86%     0.05%  mysqld   mysqld               [.] row_purge_remove_clust_if_poss_low
	+    1.78%     0.00%  mysqld   mysqld               [.] que_eval_sql
	+    1.67%     0.00%  mysqld   mysqld               [.] buf_LRU_flush_or_remove_pages
	+    1.65%     1.65%  mysqld   mysqld               [.] buf_flush_or_remove_pages
	+    1.60%     1.60%  mysqld   [kernel.kallsyms]    [k] sysret_check
	+    1.51%     0.04%  mysqld   mysqld               [.] btr_cur_search_to_nth_level
	+    1.45%     0.00%  mysqld   mysqld               [.] mysql_create_table
	+    1.43%     1.21%  mysqld   [kernel.kallsyms]    [k] __enqueue_entity
	+    1.42%     0.00%  mysqld   mysqld               [.] mysql_create_table_no_lock
	+    1.42%     0.00%  mysqld   mysqld               [.] create_table_impl
	+    1.42%     0.00%  mysqld   mysqld               [.] rea_create_table
	+    1.38%     1.38%  mysqld   [kernel.kallsyms]    [k] unroll_tree_refs
