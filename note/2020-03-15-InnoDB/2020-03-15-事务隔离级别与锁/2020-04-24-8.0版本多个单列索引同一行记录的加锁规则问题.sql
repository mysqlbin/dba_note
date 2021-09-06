
select * from information_schema.innodb_trx\G;
SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

0. 环境
1. 初始化表结构和数据
2. 事务执行流程
3. 查看锁的信息
4. 语句的加锁范围
5. 本案例下的死锁
6. 本案例下RR隔离级别的锁详情
7. 小结

0. 环境
	MySQL 8.0.19 版本
	RC隔离级别

	mysql> show global variables like '%isolation%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	+-----------------------+----------------+
	1 row in set (0.01 sec)


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

	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 3386
					 trx_state: LOCK WAIT
				   trx_started: 2020-09-17 23:54:23
		 trx_requested_lock_id: 140217799488064:19:4:2:140217730304832
			  trx_wait_started: 2020-09-17 23:54:23
					trx_weight: 3
		   trx_mysql_thread_id: 33
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
						trx_id: 3384
					 trx_state: RUNNING
				   trx_started: 2020-09-17 23:53:58
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 27
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


	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	*************************** 1. row ***************************
		  locked_index: PRIMARY
		   locked_type: RECORD
		 waiting_query: UPDATE t1 SET status = 5 WHERE status=0
	 waiting_lock_mode: X,REC_NOT_GAP
	blocking_lock_mode: X,REC_NOT_GAP
	1 row in set (0.26 sec)


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+-------------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME   | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA   |
	+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+-------------+
	| 140217799488064:1076:140217730307528   |                  3386 |        84 | t1          | NULL         | TABLE     | IX            | GRANTED     | NULL        |
	| 140217799488064:19:6:2:140217730304488 |                  3386 |        84 | t1          | idx_status   | RECORD    | X,REC_NOT_GAP | GRANTED     | 0, 1        |
	| 140217799488064:19:4:2:140217730304832 |                  3386 |        84 | t1          | PRIMARY      | RECORD    | X,REC_NOT_GAP | WAITING     | 1           |

	| 140217799487192:1076:140217730301576   |                  3384 |        78 | t1          | NULL         | TABLE     | IX            | GRANTED     | NULL        |
	| 140217799487192:19:5:2:140217730298584 |                  3384 |        78 | t1          | idx_order_no | RECORD    | X,REC_NOT_GAP | GRANTED     | '123456', 1 |
	| 140217799487192:19:4:2:140217730298928 |                  3384 |        78 | t1          | PRIMARY      | RECORD    | X,REC_NOT_GAP | GRANTED     | 1           |
	+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+-------------+
	6 rows in set (0.00 sec)

4. 语句的加锁范围
	
	session A "select * from t1 where order_no='123456' for update; " 语句的加锁范围：
	 
		idx_order_no: record lock: ['123456', 1] + primary: record lock: [1]
		
		
		不需要持有普通索引 idx_status 的锁。
		
	----------------------------------------------------------------------
	
	session B "UPDATE t1 SET status = 5 WHERE status=0; " 语句的加锁范围：
	
		idx_status: record lock: [0, 1] -- 加锁成功
		primary: record lock: [1]       -- 被锁住了。
		
		
5. 本案例下的死锁
	session A                  					session B

	begin; 
	select * from t1 where order_no='123456' for update; 

												begin;
												UPDATE t1 SET status = 5 WHERE status=0;
												(Blocked)
												
	update t1 set status=1 where order_no='123456';
	
												ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
	
	
	此时的错误日志
		TRANSACTION 3394, ACTIVE 10 sec starting index read
		mysql tables in use 1, locked 1
		LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
		MySQL thread id 42, OS thread handle 140214628493056, query id 318 localhost root Searching rows for update
		UPDATE t1 SET status = 5 WHERE status=0
		RECORD LOCKS space id 19 page no 6 n bits 72 index idx_status of table `zst`.`t1` trx id 3394 lock_mode X locks rec but not gap
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
		 0: len 4; hex 80000000; asc     ;;
		 1: len 4; hex 00000001; asc     ;;

		RECORD LOCKS space id 19 page no 4 n bits 72 index PRIMARY of table `zst`.`t1` trx id 3394 lock_mode X locks rec but not gap waiting
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
		 0: len 4; hex 00000001; asc     ;;
		 1: len 6; hex 000000000d41; asc      A;;
		 2: len 7; hex 0200000120027c; asc       |;;
		 3: len 4; hex 80000001; asc     ;;
		 4: len 4; hex 80000001; asc     ;;
		 5: len 6; hex 313233343536; asc 123456;;
		 6: len 4; hex 80000001; asc     ;;
		 7: len 4; hex 5ea15fcd; asc ^ _ ;;

		TRANSACTION 3393, ACTIVE 18 sec updating or deleting
		mysql tables in use 1, locked 1
		LOCK WAIT 4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 1
		MySQL thread id 40, OS thread handle 140214631118592, query id 319 localhost root updating
		update t1 set status=1 where order_no='123456'
		RECORD LOCKS space id 19 page no 4 n bits 72 index PRIMARY of table `zst`.`t1` trx id 3393 lock_mode X locks rec but not gap
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
		 0: len 4; hex 00000001; asc     ;;
		 1: len 6; hex 000000000d41; asc      A;;
		 2: len 7; hex 0200000120027c; asc       |;;
		 3: len 4; hex 80000001; asc     ;;
		 4: len 4; hex 80000001; asc     ;;
		 5: len 6; hex 313233343536; asc 123456;;
		 6: len 4; hex 80000001; asc     ;;
		 7: len 4; hex 5ea15fcd; asc ^ _ ;;

		RECORD LOCKS space id 19 page no 6 n bits 72 index idx_status of table `zst`.`t1` trx id 3393 lock_mode X locks rec but not gap waiting
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
		 0: len 4; hex 80000000; asc     ;;
		 1: len 4; hex 00000001; asc     ;;
		 
	根据死锁信息分析出的两个事务的加锁规则和死锁成因

		session A         					session B 
		TRANSACTION 3393   					TRANSACTION 3394
		
		持有主键索引 ID=1 的记录锁, 锁的模式为排他锁
		
											持有 idx_status: record lock: (status=0, id=1)  的锁  
											
		 在等 idx_status: record lock: (status=0, id=1)  的锁   
											
											在等主键索引 ID=1 的记录锁
											
											
		死锁类型： 同一行记录，不同索引的锁冲突。
		 
----------------------------------------------------------------------	
	
6. 本案例下RR隔离级别的锁详情
	
	mysql> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.00 sec)
		
	session A                  					session B

	begin; 
	select * from t1 where order_no='123456' for update; 

												begin;
												UPDATE t1 SET status = 5 WHERE status=0;
												
	select * from information_schema.innodb_trx\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;



	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 3389
					 trx_state: LOCK WAIT
				   trx_started: 2020-09-18 00:23:27
		 trx_requested_lock_id: 140217799483704:19:4:2:140217730274928
			  trx_wait_started: 2020-09-18 00:23:27
					trx_weight: 3
		   trx_mysql_thread_id: 37
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
						trx_id: 3388
					 trx_state: RUNNING
				   trx_started: 2020-09-18 00:23:01
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 36
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

	
	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	*************************** 1. row ***************************
		  locked_index: PRIMARY
		   locked_type: RECORD
		 waiting_query: UPDATE t1 SET status = 5 WHERE status=0
	 waiting_lock_mode: X,REC_NOT_GAP
	blocking_lock_mode: X,REC_NOT_GAP
	1 row in set (0.01 sec)


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+------------------------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME   | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA              |
	+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+------------------------+
	| 140217799483704:1076:140217730277464   |                  3389 |        88 | t1          | NULL         | TABLE     | IX            | GRANTED     | NULL                   |
	| 140217799483704:19:6:2:140217730274584 |                  3389 |        88 | t1          | idx_status   | RECORD    | X             | GRANTED     | 0, 1                   |
	| 140217799483704:19:4:2:140217730274928 |                  3389 |        88 | t1          | PRIMARY      | RECORD    | X,REC_NOT_GAP | WAITING     | 1                      |


	| 140217799482832:1076:140217730271480   |                  3388 |        87 | t1          | NULL         | TABLE     | IX            | GRANTED     | NULL                   |
	| 140217799482832:19:5:1:140217730268552 |                  3388 |        87 | t1          | idx_order_no | RECORD    | X             | GRANTED     | supremum pseudo-record |
	| 140217799482832:19:5:2:140217730268552 |                  3388 |        87 | t1          | idx_order_no | RECORD    | X             | GRANTED     | '123456', 1            |
	| 140217799482832:19:4:2:140217730268896 |                  3388 |        87 | t1          | PRIMARY      | RECORD    | X,REC_NOT_GAP | GRANTED     | 1                      |
	+----------------------------------------+-----------------------+-----------+-------------+--------------+-----------+---------------+-------------+------------------------+
	7 rows in set (0.00 sec)	


	session A "select * from t1 where order_no='123456' for update; " 语句的加锁范围：
	 
		idx_order_no: next-key lock: 
			record lock: (order_no = '123456', id=1) + gap lock: ('123456', supremum pseudo-record]
			
		primary: record lock: [1]
		
	
		不需要持有普通索引 idx_status 的锁。
		
	----------------------------------------------------------------------
	
	session B "UPDATE t1 SET status = 5 WHERE status=0; " 语句的加锁范围：
	
		idx_status: record lock: [0, 1] -- 加锁成功
		primary: record lock: [1]       -- 被锁住了。
			
7. 小结
	
	InnoDB的行锁是加在索引上，并且只对必要的索引加锁。
	
	8.0版本记录了更详情的死锁日志，把死锁的事务持有的锁和在等待的锁的详情都记录下来了；
	不再需要根据死锁日志中的锁等待的记录信息推导出另一个事务持有的锁信息，分析死锁会更加轻松。
	
	
	行级锁：
		开销大，加锁慢；
		会出现死锁；
		锁定粒度最小，发生锁冲突的概率最低，并发度也最高。
		行锁总是逐步获得的，因此会出现死锁。

	

