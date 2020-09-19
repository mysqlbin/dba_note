

0. 环境
1. 初始化表结构和数据
2. 事务执行流程
3. 查看锁的信息
4. 语句的加锁范围
5. 本案例下RR隔离级别的锁详情


0. 环境
	MySQL 5.7.22 版本
	RC隔离级别
	
1. 初始化表结构和数据

	drop table if exists t1 ;
	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `t1` int(10) NOT NULL COMMENT '',
	  `t2` int(10) NOT NULL COMMENT '',
	  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
	  `status` int(10) NOT NULL COMMENT '',
	  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_order_no` (`order_no`),
	  KEY `idx_status` (`status`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';

		
	INSERT INTO `t1` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-23 17:28:45');
	

2. 事务执行流程
	session A                  					session B

	begin; 
	select * from t1 where order_no='123456' for update; 

												begin;
												UPDATE t1 SET status = 5 WHERE status=0;
												(Blocked)

												
3. 查看锁的信息

	select * from information_schema.innodb_trx\G;
	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	
	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5244528
					 trx_state: LOCK WAIT
				   trx_started: 2020-09-18 16:00:20
		 trx_requested_lock_id: 5244528:2070:3:2
			  trx_wait_started: 2020-09-18 16:00:20
					trx_weight: 3
		   trx_mysql_thread_id: 34031
					 trx_query: UPDATE t1 SET status = 5 WHERE status=0
		   trx_operation_state: starting index read
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 2
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	*************************** 2. row ***************************
						trx_id: 5244524
					 trx_state: RUNNING
				   trx_started: 2020-09-18 15:43:29
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 34030
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 2
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	2 rows in set (0.00 sec)

	ERROR: 
	No query specified

	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 5244528:2070:3:2
	lock_trx_id: 5244528
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `base_db`.`t1`
	 lock_index: PRIMARY
	 lock_space: 2070
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1   --请求加锁的 row data ， ID = 1 这行记录
	*************************** 2. row ***************************
		lock_id: 5244524:2070:3:2
	lock_trx_id: 5244524
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `base_db`.`t1`
	 lock_index: PRIMARY
	 lock_space: 2070
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1  --被加锁的 row data ， ID = 1 这行记录
	2 rows in set, 1 warning (0.00 sec)

	ERROR: 
	No query specified

	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 5244528
	requested_lock_id: 5244528:2070:3:2
	  blocking_trx_id: 5244524
	 blocking_lock_id: 5244524:2070:3:2
	1 row in set, 1 warning (0.00 sec)

	ERROR: 
	No query specified

	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                           | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-----------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | UPDATE t1 SET status = 5 WHERE status=0 | X                 | X                  |
	+--------------+-------------+-----------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.01 sec)


4. 语句的加锁范围
	
	session A "select * from t1 where order_no='123456' for update; " 语句的加锁范围：
	 
		idx_order_no: record lock: ['123456', 1] + primary: record lock: [1]
		
		
		不需要持有普通索引 idx_status 的锁。
		
	----------------------------------------------------------------------
	
	session B "UPDATE t1 SET status = 5 WHERE status=0; " 语句的加锁范围：
	
		idx_status: record lock: [0, 1] -- 加锁成功
		primary: record lock: [1]       -- 被锁住了。
		
		
	
5. 本案例下RR隔离级别的锁详情

	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5244530
					 trx_state: LOCK WAIT
				   trx_started: 2020-09-18 16:22:45
		 trx_requested_lock_id: 5244530:2070:3:2
			  trx_wait_started: 2020-09-18 16:22:45
					trx_weight: 3
		   trx_mysql_thread_id: 34045
					 trx_query: UPDATE t1 SET status = 5 WHERE status=0
		   trx_operation_state: starting index read
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 2
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: REPEATABLE READ
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	*************************** 2. row ***************************
						trx_id: 5244529
					 trx_state: RUNNING
				   trx_started: 2020-09-18 16:22:33
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 34046
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 3
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: REPEATABLE READ
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	2 rows in set (0.00 sec)

	ERROR: 
	No query specified

	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 5244530:2070:3:2
	lock_trx_id: 5244530
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `base_db`.`t1`
	 lock_index: PRIMARY
	 lock_space: 2070
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	*************************** 2. row ***************************
		lock_id: 5244529:2070:3:2
	lock_trx_id: 5244529
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `base_db`.`t1`
	 lock_index: PRIMARY
	 lock_space: 2070
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	2 rows in set, 1 warning (0.00 sec)



	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 5244530
	requested_lock_id: 5244530:2070:3:2
	  blocking_trx_id: 5244529
	 blocking_lock_id: 5244529:2070:3:2
	1 row in set, 1 warning (0.00 sec)



	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                           | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-----------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | UPDATE t1 SET status = 5 WHERE status=0 | X                 | X                  |
	+--------------+-------------+-----------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.00 sec)



	session A "select * from t1 where order_no='123456' for update; " 语句的加锁范围：
	 
		idx_order_no: next-key lock: 
			record lock: (order_no = '123456', id=1) + gap lock: ('123456', supremum pseudo-record]
			
		primary: record lock: [1]
		
	
		不需要持有普通索引 idx_status 的锁。
	
	----------------------------------------------------------------------
	
	session B "UPDATE t1 SET status = 5 WHERE status=0; " 语句的加锁范围：
	
		idx_status: record lock: [0, 1] -- 加锁成功
		primary: record lock: [1]       -- 被锁住了。
		
		
6. 小结
	InnoDB的行锁是加在索引上，并且只对必要的索引加锁。
				
		