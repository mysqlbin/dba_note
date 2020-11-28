
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	INSERT INTO `t` (`id`, `c`) VALUES ('1', '1');


时间点
		begin;
		select * from t where id=1;
T1
		update t set  c=2 where id=1;
T2
		select * from t where id=1;
T3
	
	
root@localhost [sbtest]>select @@tx_isolation;
+-----------------+
| @@tx_isolation  |
+-----------------+
| REPEATABLE-READ |
+-----------------+
1 row in set (0.01 sec)

root@localhost [sbtest]>begin;
Query OK, 0 rows affected (0.00 sec)

root@localhost [sbtest]>select * from t where id=1;
+----+------+
| id | c    |
+----+------+
|  1 |    1 |
+----+------+
1 row in set (0.01 sec)

root@localhost [sbtest]>update t set  c=2 where id=1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

root@localhost [sbtest]>select * from t where id=1;
+----+------+
| id | c    |
+----+------+
|  1 |    2 |
+----+------+
1 row in set (0.00 sec)
	
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
