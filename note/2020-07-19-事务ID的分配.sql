
0. 学习的目的
	了解MySQL如何分配事务ID
1. 初始化表结构和数据
2. 测试事务1
3. 测试事务2
4. 测试事务3
5. 小结


1. 初始化表结构和数据

	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	 INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');


	root@localhost [(none)]>select @@tx_isolation;
	+-----------------+
	| @@tx_isolation  |
	+-----------------+
	| REPEATABLE-READ |
	+-----------------+
	1 row in set (0.00 sec)



2. 测试事务1
	begin;
	select * from t where id=1;
	root@localhost [(none)]>select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 421620588104416
					 trx_state: RUNNING
				   trx_started: 2020-05-18 17:39:50
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 0
		   trx_mysql_thread_id: 41
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 0
			  trx_lock_structs: 0
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 0
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
	1 row in set (0.00 sec)

	
	--普通select是一个只读事务，生成的事务ID非常大
	
3. 测试事务1

	时间点
			begin;
			select * from t where id=1;
	T1
			update t set  c=2 where id=1;
	T2
		
	T1	
		root@localhost [(none)]>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 421620588104416
						 trx_state: RUNNING
					   trx_started: 2020-05-18 17:46:38
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 0
			   trx_mysql_thread_id: 41
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 0
				  trx_lock_structs: 0
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 0
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
		1 row in set (0.00 sec)

	T2		
		root@localhost [(none)]>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 5894285
						 trx_state: RUNNING
					   trx_started: 2020-05-18 17:46:38
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 41
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
	
	
	select * from t where id=1;    --分配只读事务ID
	update t set  c=2 where id=1;    --分配更新的事务ID
	

	
4. 测试事务3

	时间点
			begin;
			update t set  c=2 where id=1;
	T1	 
			update t set  c=3 where id=1;
	T2
			update t set  c=4 where id=1;
	T3

	 

	T1
		root@localhost [(none)]>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 5894279
						 trx_state: RUNNING
					   trx_started: 2020-05-18 17:42:32
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 41
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
	 
	T2
		root@localhost [(none)]>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 5894279
						 trx_state: RUNNING
					   trx_started: 2020-05-18 17:42:32
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 4
			   trx_mysql_thread_id: 41
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
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
		1 row in set (0.00 sec)
		
		
	T3
		root@localhost [(none)]>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 5894279
						 trx_state: RUNNING
					   trx_started: 2020-05-18 17:42:32
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 5
			   trx_mysql_thread_id: 41
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
				 trx_rows_modified: 3
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

	--共用同一个事务ID
	
	
5. 小结
	1. 事务ID的分配：
		所有的更新语句共同一个事务ID，普通select会生成一个很大的只读事务ID，执行到第一个操作InnoDB表的语句，事务才真正启动，即这时候才分配事务ID；
	
	2. 同时验证了 begin; 或者 start transaction 并不是一个事务的起点，只是声明事务的语句；
		在执行到它们之后的第一个操作 InnoDB 表的语句，事务才真正启动，即这时候才分配事务ID； --理解正确。
	
	