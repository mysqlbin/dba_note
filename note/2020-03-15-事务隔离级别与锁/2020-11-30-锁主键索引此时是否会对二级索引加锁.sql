
select * from information_schema.innodb_trx\G;
SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

在MySQL 8.0版本下做验证。


1. 初始表结构、数据、环境
2. 事务的执行次序
3. 根据主键查询更新二级索引字段的值


1. 初始表结构、数据、环境
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

	mysql> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.01 sec)


	
2. 事务的执行次序

	时间点	session A          session B

			begin;		
			update t1 set t2=3 where id=1;
			-- 看看这里是否会锁住 idx_status 的记录
	T1
								begin;
								select * from t1 where order_no='123456' for update;
								(Blocked)
								主键索引被锁住
	T2							
							
							


	T1
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 4635
						 trx_state: RUNNING
					   trx_started: 2020-11-30 07:19:51
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 8
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
				 trx_rows_modified: 1
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		1 row in set (0.05 sec)


		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
		Empty set (0.55 sec)


		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139773755734024:1085:139773670936328   |                  4635 |        59 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139773755734024:28:4:2:139773670933288 |                  4635 |        59 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		2 rows in set (0.00 sec)



	T2
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 4637
						 trx_state: LOCK WAIT
					   trx_started: 2020-11-30 07:20:44
			 trx_requested_lock_id: 139773755735768:28:4:2:139773670945840
				  trx_wait_started: 2020-11-30 07:20:44
						trx_weight: 3
			   trx_mysql_thread_id: 13
						 trx_query: select * from t1 where order_no='123456' for update
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
							trx_id: 4635
						 trx_state: RUNNING
					   trx_started: 2020-11-30 07:19:51
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 8
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
				 trx_rows_modified: 1
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

		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
		*************************** 1. row ***************************
			  locked_index: PRIMARY
			   locked_type: RECORD
			 waiting_query: select * from t1 where order_no='123456' for update
		 waiting_lock_mode: X,REC_NOT_GAP
		blocking_lock_mode: X,REC_NOT_GAP
		1 row in set (0.04 sec)



		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+-------------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME   | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA   |
		+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+-------------+
		| 139773755735768:1085:139773670948488   |                  4637 |        64 | t1          | NULL         | TABLE     | IX            | GRANTED     | NULL        |
		| 139773755735768:28:5:2:139773670945496 |                  4637 |        64 | t1          | idx_order_no | RECORD    | X             | GRANTED     | '123456', 1 |
		| 139773755735768:28:4:2:139773670945840 |                  4637 |        64 | t1          | PRIMARY      | RECORD    | X,REC_NOT_GAP | WAITING     | 1           |
		
		| 139773755734024:1085:139773670936328   |                  4635 |        59 | t1          | NULL         | TABLE     | IX            | GRANTED     | NULL        |
		| 139773755734024:28:4:2:139773670933288 |                  4635 |        59 | t1          | PRIMARY      | RECORD    | X,REC_NOT_GAP | GRANTED     | 1           |
		+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+-------------+
		5 rows in set (0.00 sec)
	
------------------------------------------------------------
	
3. 根据主键查询更新二级索引字段的值

	时间点	session A          session B

			begin;		
			update t1 set status=1 where id=1;
			-- 看看这里是否会锁住 idx_status 的记录？ 会的。
	T1
								select * from t1 where status=0 for update;						

	T2

	T1
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 4639
						 trx_state: RUNNING
					   trx_started: 2020-11-30 07:31:08
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 15
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
				 trx_rows_modified: 1
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		1 row in set (0.00 sec)

		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
		Empty set (0.01 sec)



		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139773755730536:1085:139773670912440   |                  4639 |        66 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139773755730536:28:4:2:139773670909400 |                  4639 |        66 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		2 rows in set (0.00 sec)


	T2
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 4644
						 trx_state: LOCK WAIT
					   trx_started: 2020-11-30 07:33:05
			 trx_requested_lock_id: 139773755733152:28:6:2:139773670927336
				  trx_wait_started: 2020-11-30 07:33:05
						trx_weight: 2
			   trx_mysql_thread_id: 18
						 trx_query: select * from t1 where status=0 for update
			   trx_operation_state: starting index read
				 trx_tables_in_use: 1
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
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
							trx_id: 4639
						 trx_state: RUNNING
					   trx_started: 2020-11-30 07:31:08
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 4
			   trx_mysql_thread_id: 15
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 3
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 2
				 trx_rows_modified: 1
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



		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
		*************************** 1. row ***************************
			  locked_index: idx_status
			   locked_type: RECORD
			 waiting_query: select * from t1 where status=0 for update
		 waiting_lock_mode: X
		blocking_lock_mode: X,REC_NOT_GAP
		1 row in set (0.01 sec)



		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139773755733152:1085:139773670930376   |                  4644 |        69 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139773755733152:28:6:2:139773670927336 |                  4644 |        69 | t1          | idx_status | RECORD    | X             | WAITING     | 0, 1      |
		| 139773755730536:1085:139773670912440   |                  4639 |        66 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		
		| 139773755730536:28:4:2:139773670909400 |                  4639 |        66 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
		| 139773755730536:28:6:2:139773670909744 |                  4639 |        69 | t1          | idx_status | RECORD    | X,REC_NOT_GAP | GRANTED     | 0, 1      |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		5 rows in set (0.00 sec)