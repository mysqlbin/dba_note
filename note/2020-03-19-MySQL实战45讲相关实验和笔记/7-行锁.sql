

1. 初始表结构和数据

	DROP TABLE IF EXISTS `t1`;
	CREATE TABLE `t1` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `k` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	
	INSERT INTO `t1` (`id`, `k`) VALUES ('1', '1');
	INSERT INTO `t1` (`id`, `k`) VALUES ('2', '2');
	
	
2. 环境 
	select version();
	select @@global.transaction_isolation;
	select @@session.transaction_isolation;

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

	mysql> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
	+--------------------------------+
	1 row in set (0.00 sec)

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

3. 事务的执行次序

	session A           session B
	begin;
	update t1 set k=k+1 where id=1;
	update t1 set k=k+1 where id=2;
						begin;
						update t1 set k=k+2 where id=1;
						(Blocked)
	commit;
   	
	session A持有的锁
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139811159245376:1345:139811050591928    |               1004377 |        77 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139811159245376:288:4:2:139811050588888 |               1004377 |        77 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
		| 139811159245376:288:4:3:139811050588888 |               1004377 |        77 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		3 rows in set (0.00 sec)

	session B被阻塞的信息
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 1004379
						 trx_state: LOCK WAIT
					   trx_started: 2020-05-19 10:45:35
			 trx_requested_lock_id: 139811159246248:288:4:2:139811050594840
				  trx_wait_started: 2020-05-19 10:45:35
						trx_weight: 2
			   trx_mysql_thread_id: 26
						 trx_query: update t1 set k=k+2 where id=1
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
							trx_id: 1004377
						 trx_state: RUNNING
					   trx_started: 2020-05-19 10:44:07
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 4
			   trx_mysql_thread_id: 27
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 2
				 trx_rows_modified: 2
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		2 rows in set (0.01 sec)


		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
		*************************** 1. row ***************************
			  locked_index: PRIMARY
			   locked_type: RECORD
			 waiting_query: update t1 set k=k+2 where id=1
		 waiting_lock_mode: X,REC_NOT_GAP
		blocking_lock_mode: X,REC_NOT_GAP
		1 row in set (0.00 sec)

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139811159246248:1345:139811050597880    |               1004379 |        76 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139811159246248:288:4:2:139811050594840 |               1004379 |        76 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1         |
		
		| 139811159245376:1345:139811050591928    |               1004377 |        77 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139811159245376:288:4:2:139811050588888 |               1004377 |        77 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
		| 139811159245376:288:4:3:139811050588888 |               1004377 |        77 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		5 rows in set (0.00 sec)
				
	1. 在上面的操作序列中，假设字段id 是表t 的主键，事务 A 持有的两个记录的行锁，但是没有提交；
    2. 此时事务 B 的 update 语句会被阻塞，直到事务 A 执行 commit 之后，事务 B 才能继续执行；
    3. 因此， 事务A持有的两个行锁，都是在commit提交之后释放的。  
