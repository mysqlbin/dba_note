
1. 初始化表结构和事务的执行次序
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	INSERT INTO `t` (`id`, `c`) VALUES ('1', '1');
	mysql>select @@tx_isolation;
	+-----------------+
	| @@tx_isolation  |
	+-----------------+
	| REPEATABLE-READ |
	+-----------------+
	1 row in set (0.01 sec)


	时间点
			begin;
			select * from t where id=1;
			+----+------+
			| id | c    |
			+----+------+
			|  1 |    1 |
			+----+------+
			1 row in set (0.01 sec)
	T1
			update t set  c=2 where id=1;
			Query OK, 1 row affected (0.00 sec)
			Rows matched: 1  Changed: 1  Warnings: 0
	T2
			select * from t where id=1;
			+----+------+
			| id | c    |
			+----+------+
			|  1 |    2 |
			+----+------+
			1 row in set (0.00 sec)
	T3
		
	T1 时刻创建 read view，此时没有活跃的事务ID;
		假设此时 id=1 的 trx_id=5900803
	
	T2 时刻，此时id=1 的 trx_id=5900804
	
	T3 时刻创建 read view，creator_trx_id = 5900804，活跃的事务ID列表为[5900804]; 
		这个trx_id=5900804是由自己所在的事务创建的
		被访问版本的 row trx_id 值与 read view 中的 creator_trx_id 值相同, 可见。
		
	-- 准确的说就是基于数据的 row trx_id 跟一致性视图中的同一行记录的活跃事务ID的对比结果得到。
	
	可以看到，T1时刻和T3时刻都会创建read view，跟之前理解的可重复读隔离级别下的read view复用也就是在可重复读隔离级别下， 只需要在事务开始的时候创建一致性视图， 之后事务里面的其他查询都共用这个一致性视图，有区别。
		这是因为判断可见性还有一个优化级规则，自己的更新对自己的查询可见。

	
2. T1、T2、T3时刻事务ID的分配情况	
	T1 
		mysql>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 421734398846800
						 trx_state: RUNNING
					   trx_started: 2020-09-16 03:30:28
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 0
			   trx_mysql_thread_id: 4
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
		mysql>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 5900804
						 trx_state: RUNNING
					   trx_started: 2020-09-16 03:30:28
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 4
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

	T3 
		mysql>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 5900804
						 trx_state: RUNNING
					   trx_started: 2020-09-16 03:30:28
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 4
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
