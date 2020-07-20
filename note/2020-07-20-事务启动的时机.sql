
root@mysqldb 14:33:  [base_db]> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.03 sec)


1. RR隔离级别
	1.1 案例1
	1.2 案例2
2. RC隔离级别
	2.1 案例1
	2.2 案例2
	2.3 案例3

1. RR隔离级别
1.1 案例1
	start transaction with consistent snapshot; 
	
	session A                       session B
	
	mysql> start transaction with consistent snapshot; 
	Query OK, 0 rows affected (0.00 sec)

									mysql> select * from information_schema.innodb_trx\G;
									*************************** 1. row ***************************
														trx_id: 421597988102064
													 trx_state: RUNNING
												   trx_started: 2020-07-20 12:23:34
										 trx_requested_lock_id: NULL
											  trx_wait_started: NULL
													trx_weight: 0
										   trx_mysql_thread_id: 233189
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
									1 row in set (0.04 sec)



1.2 案例2

	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	 INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	
	

	时间点
				start transaction with consistent snapshot; 
		T1
				update t set  c=2 where id=1;
		T2

		T1	
			mysql> select * from information_schema.innodb_trx\G;
			*************************** 1. row ***************************
								trx_id: 421125770847632
							 trx_state: RUNNING
						   trx_started: 2020-07-20 14:25:17
				 trx_requested_lock_id: NULL
					  trx_wait_started: NULL
							trx_weight: 0
				   trx_mysql_thread_id: 101002
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
			1 row in set (0.09 sec)


		T2
			mysql> select * from information_schema.innodb_trx\G;
			*************************** 1. row ***************************
								trx_id: 5065041
							 trx_state: RUNNING
						   trx_started: 2020-07-20 14:25:17
				 trx_requested_lock_id: NULL
					  trx_wait_started: NULL
							trx_weight: 3
				   trx_mysql_thread_id: 101002
							 trx_query: NULL
				   trx_operation_state: NULL
					 trx_tables_in_use: 0
					 trx_tables_locked: 1
				 trx_lock_memory_bytes: 1136
					   trx_rows_locked: 1
					 trx_rows_modified: 1
			   trx_concurrency_tickets: 0
				   trx_isolation_level: REPEATABLE READ
					 trx_unique_checks: 1
				trx_foreign_key_checks: 1
			trx_last_foreign_key_error: NULL
					  trx_lock_structs: 2
			 trx_adaptive_hash_latched: 0
			 trx_adaptive_hash_timeout: 0
					  trx_is_read_only: 0
			trx_autocommit_non_locking: 0
			1 row in set (0.00 sec)



2. RC隔离级别
	
	mysql> select @@tx_isolation;
	+----------------+
	| @@tx_isolation |
	+----------------+
	| READ-COMMITTED |
	+----------------+
	1 row in set, 1 warning (0.00 sec)

	start transaction with consistent snapshot; 
	
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	 INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	 
2. 1 案例1		
	session A                    session B
	
	mysql> start transaction with consistent snapshot; 
	Query OK, 0 rows affected (0.00 sec)
								
								mysql> select * from information_schema.innodb_trx\G;
								*************************** 1. row ***************************
													trx_id: 421125770847632
												 trx_state: RUNNING
											   trx_started: 2020-07-20 14:33:49
									 trx_requested_lock_id: NULL
										  trx_wait_started: NULL
												trx_weight: 0
									   trx_mysql_thread_id: 101020
												 trx_query: NULL
									   trx_operation_state: NULL
										 trx_tables_in_use: 0
										 trx_tables_locked: 0
										  trx_lock_structs: 0
									 trx_lock_memory_bytes: 1136
										   trx_rows_locked: 0
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
								1 row in set (0.00 sec)

2.2 案例2	

	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	 INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	
	时间点
				start transaction with consistent snapshot; 
		T1
				update t set  c=2 where id=1;
		T2
	
	
	T1
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 421125770847632
						 trx_state: RUNNING
					   trx_started: 2020-07-20 14:44:46
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 0
			   trx_mysql_thread_id: 101020
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 0
				  trx_lock_structs: 0
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 0
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
		1 row in set (0.00 sec)

	T2
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 5065109
						 trx_state: RUNNING
					   trx_started: 2020-07-20 14:44:46
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 101020
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
				 trx_rows_modified: 1
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

2.3 案例3

		时间点
				start transaction with consistent snapshot; 
		T1
				select * from t where id=1;

		T2

		T1
			mysql> select * from information_schema.innodb_trx\G;
			*************************** 1. row ***************************
								trx_id: 421125770847632
							 trx_state: RUNNING
						   trx_started: 2020-07-20 18:38:04
				 trx_requested_lock_id: NULL
					  trx_wait_started: NULL
							trx_weight: 0
				   trx_mysql_thread_id: 101020
							 trx_query: NULL
				   trx_operation_state: NULL
					 trx_tables_in_use: 0
					 trx_tables_locked: 0
					  trx_lock_structs: 0
				 trx_lock_memory_bytes: 1136
					   trx_rows_locked: 0
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
			1 row in set (0.00 sec)

		T2
			mysql> select * from information_schema.innodb_trx\G;
			*************************** 1. row ***************************
								trx_id: 421125770847632
							 trx_state: RUNNING
						   trx_started: 2020-07-20 18:38:04
				 trx_requested_lock_id: NULL
					  trx_wait_started: NULL
							trx_weight: 0
				   trx_mysql_thread_id: 101020
							 trx_query: NULL
				   trx_operation_state: NULL
					 trx_tables_in_use: 0
					 trx_tables_locked: 0
					  trx_lock_structs: 0
				 trx_lock_memory_bytes: 1136
					   trx_rows_locked: 0
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
			1 row in set (0.01 sec)



