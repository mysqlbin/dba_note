

1. 模拟环境
2. perf top
3. show slave status 和 information_schema.innodb_trx
4. sql_thread卡在哪里
5. 解决办法，添加索引
6. 重要步骤


1. 模拟环境
	
	root@localhost [(none)]>show global variables like '%slave_rows_search_algorithms%';
	+------------------------------+-----------------------+
	| Variable_name                | Value                 |
	+------------------------------+-----------------------+
	| slave_rows_search_algorithms | TABLE_SCAN,INDEX_SCAN |
	+------------------------------+-----------------------+
	1 row in set (0.00 sec)
		
	
	alter table sbtest1 drop column id;
	
	root@localhost [(none)]>show processlist;
	+----+------+---------------------+--------+------------------+------+---------------------------------------------------------------+------------------------------------+
	| Id | User | Host                | db     | Command          | Time | State                                                         | Info                               |
	+----+------+---------------------+--------+------------------+------+---------------------------------------------------------------+------------------------------------+
	| 19 | repl | 192.168.1.29:55692  | NULL   | Binlog Dump GTID | 3002 | Master has sent all binlog to slave; waiting for more updates | NULL                               |
	| 39 | lujb | 192.168.1.100:63704 | sbtest | Sleep            |    2 |                                                               | NULL                               |
	| 40 | root | localhost           | sbtest | Query            |   62 | copy to tmp table                                             | alter table sbtest1 drop column id |
	| 42 | root | localhost           | NULL   | Query            |    0 | starting                                                      | show processlist                   |
	+----+------+---------------------+--------+------------------+------+---------------------------------------------------------------+------------------------------------+
	4 rows in set (0.00 sec)
	
	State=copy to tmp table： 表示需要拷贝原表的数据到临时表中。
	
	mysql>select count(*) from sbtest1;
	+----------+
	| count(*) |
	+----------+
	|  1000000 |
	+----------+
	1 row in set (3.37 sec)

	mysql>show create table sbtest1\G;
	*************************** 1. row ***************************
		   Table: sbtest1
	Create Table: CREATE TABLE `sbtest1` (
	  `k` int(10) unsigned NOT NULL DEFAULT '0',
	  `c` char(120) NOT NULL DEFAULT '',
	  `pad` char(60) NOT NULL DEFAULT ''
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 MAX_ROWS=1000000
	1 row in set (0.00 sec)

	ERROR: 
	No query specified
	

	mysql>select count(*) as counts, k from sbtest1 group by k having counts > 95 order by counts desc;
	+--------+--------+
	| counts | k      |
	+--------+--------+
	|    113 | 250404 |
	|    107 | 252182 |
	|    106 | 250332 |
	|    106 | 250593 |
	|    105 | 250816 |
	|    105 | 248673 |
	|    103 | 251794 |
	|    103 | 250760 |
	|    102 | 250951 |
	|    101 | 248858 |
	|    101 | 249436 |
	|    101 | 251406 |
	|    101 | 251135 |
	|    101 | 249535 |
	|    101 | 248498 |
	|    101 | 250018 |
	|    101 | 251908 |
	|    101 | 249252 |
	|    100 | 248633 |

	
	主库执行大事务
		update sbtest1 set k=4 where k between 166794 and 400000;
		
		mysql>update sbtest1 set k=4 where k between 166794 and 400000;
		Query OK, 26368 rows affected (21.16 sec)
		Rows matched: 26368  Changed: 26368  Warnings: 0


		
2. perf top
	-- https://mytecdb.com/blogDetail.php?id=181 MySQL Bug 并发更新，在函数 row_search_mvcc 中 Crash

	amples: 49K of event 'cpu-clock', Event count (approx.): 5123469243                                                                                                                                              
	Overhead  Shared Object        Symbol                                                                                                                                                                             
	  10.50%  mysqld               [.] row_search_mvcc
	   6.26%  libc-2.17.so         [.] __memmove_ssse3
	   5.41%  mysqld               [.] PolicyMutex<TTASEventMutex<GenericPolicy> >::enter
	   4.83%  mysqld               [.] record_compare
	   4.53%  mysqld               [.] PolicyMutex<TTASEventMutex<GenericPolicy> >::exit
	   4.00%  mysqld               [.] rec_get_offsets_func
	   3.62%  mysqld               [.] mtr_t::Command::release_all
	   3.13%  mysqld               [.] rw_lock_s_lock_low
	   3.07%  mysqld               [.] buf_page_optimistic_get
	   2.84%  mysqld               [.] row_sel_store_mysql_field_func

	Samples: 72K of event 'cpu-clock', Event count (approx.): 19865624                                                                                                                                                
	Overhead  Shared Object       Symbol                                                                                                                                                                              
	  33.46%  [kernel]            [k] __do_softirq
	  19.61%  [kernel]            [k] finish_task_switch
	   6.00%  [kernel]            [k] _raw_spin_unlock_irqrestore
	   2.86%  [kernel]            [k] scsi_request_fn
	   2.85%  libc-2.17.so        [.] __memset_sse2
	   2.33%  [kernel]            [k] linear_merge
	   2.17%  mysqld              [.] LinuxAIOHandler::collect
	   1.81%  mysqld              [.] ut_crc32_hw
	   1.79%  [kernel]            [k] xfs_iunlock
	   1.26%  mysqld              [.] LinuxAIOHandler::poll
	   1.10%  [kernel]            [k] system_call_after_swapgs
	   
   
3. show slave status 和 information_schema.innodb_trx
	root@localhost [(none)]>show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.27
					  Master_User: repl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000017
			  Read_Master_Log_Pos: 60252527
				   Relay_Log_File: relay-bin.000042
					Relay_Log_Pos: 50398400
			Relay_Master_Log_File: mysql-bin.000017
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
				  Replicate_Do_DB: 
			  Replicate_Ignore_DB: 
			   Replicate_Do_Table: 
		   Replicate_Ignore_Table: 
		  Replicate_Wild_Do_Table: 
	  Replicate_Wild_Ignore_Table: 
					   Last_Errno: 0
					   Last_Error: 
					 Skip_Counter: 0
			  Exec_Master_Log_Pos: 50398187
				  Relay_Log_Space: 60253529
				  Until_Condition: None
				   Until_Log_File: 
					Until_Log_Pos: 0
			   Master_SSL_Allowed: No
			   Master_SSL_CA_File: 
			   Master_SSL_CA_Path: 
				  Master_SSL_Cert: 
				Master_SSL_Cipher: 
				   Master_SSL_Key: 
			Seconds_Behind_Master: 267
	Master_SSL_Verify_Server_Cert: No
					Last_IO_Errno: 0
					Last_IO_Error: 
				   Last_SQL_Errno: 0
				   Last_SQL_Error: 
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 273306
					  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
				 Master_Info_File: /data/mysql/mysql3306/data/master.info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Reading event from the relay log
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:110689-160522
				Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-160521
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)
	
	
	 root@localhost [(none)]>select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5887537
					 trx_state: RUNNING
				   trx_started: 2020-03-22 05:03:08
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3285
		   trx_mysql_thread_id: 25
					 trx_query: NULL
		   trx_operation_state: fetching rows
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 1138
		 trx_lock_memory_bytes: 123088
			   trx_rows_locked: 81825
			 trx_rows_modified: 2147
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	1 row in set (0.00 sec)
		
	
4. sql_thread卡在哪里
	
	1. 根据 Master_Log_File: mysql-bin.000017,  Exec_Master_Log_Pos/end_log_pos 50398187  ; 这个去主库上去解析binlog
		[root@env27 logs]# mysqlbinlog -vv --base64-output=decode-rows --stop-position=50398187 mysql-bin.000017 > 1.sql


	2. 根据 Relay_Log_File: relay-bin.000042  Relay_Log_Pos:50398400 去从库上找：

		[root@env29 data]# mysqlbinlog -vv --base64-output=decode-rows --start-position=50398400 relay-bin.000042 > 2.sq

	3. select * from information_schema.innodb_trx\G; --查看正在执行中的事务。
	
	4. 查看主库的慢日志
	
	
5. 解决办法，添加索引

	主库
		mysql>set sql_log_bin=0;
		Query OK, 0 rows affected (0.00 sec)

		mysql>alter table sbtest1 add index idx_k(`k`);
		Query OK, 0 rows affected (9.70 sec)
		Records: 0  Duplicates: 0  Warnings: 0


	从库
		
		stop slave;
		
		
		mysql>set sql_log_bin=0;
		Query OK, 0 rows affected (0.00 sec)

		mysql>alter table sbtest1 add index idx_k(`k`);
		Query OK, 0 rows affected (9.21 sec)
		Records: 0  Duplicates: 0  Warnings: 0
		
		start slave;
			
		mysql>desc update sbtest1 set k=4 where k between 166794 and 400000;
		+----+-------------+---------+------------+-------+---------------+-------+---------+-------+-------+----------+------------------------------+
		| id | select_type | table   | partitions | type  | possible_keys | key   | key_len | ref   | rows  | filtered | Extra                        |
		+----+-------------+---------+------------+-------+---------------+-------+---------+-------+-------+----------+------------------------------+
		|  1 | UPDATE      | sbtest1 | NULL       | range | idx_k         | idx_k | 4       | const | 44464 |   100.00 | Using where; Using temporary |
		+----+-------------+---------+------------+-------+---------------+-------+---------+-------+-------+----------+------------------------------+
		1 row in set (0.00 sec)
			
			
6. 重要步骤
	1. select * from information_schema.innodb_trx\G;
		
		查看长事务的执行情况，重要关注 trx_started 和 trx_weight 这2个字段的值
		可以考虑 kill掉这个连接。
		
	1. stop slave; 停止不下来		
		通过 select * from information_schema.innodb_trx\G; 命令查看回滚的状态。
		
	2. pstack and perf top
		LWP 
		pstack $(pgrep -xn mysqld) > 1.sql
		perf top -p $(pgrep -xn mysqld)
		
	3. 从库数据查找和参数slave_rows_search_algorithms
		查看binlog大事务大小的工具
		从库查找参数是即时生效的吗
		SET GLOBAL slave_rows_search_algorithms = 'INDEX_SCAN,HASH_SCAN';  
		不是的。
		
	4. 系统里去 kill -9 pidof mysqld
		不需要，stop slave可以停下来的，如果回滚的数据量大，耗时比较长而已。
		
	5. 如何避免这类的问题
		巡检脚本项中加入判断没有主键的表
		
	6. kill -9 和 shutdown 区别 

