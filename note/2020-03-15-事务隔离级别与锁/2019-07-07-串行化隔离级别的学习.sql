
1. 案例1-读写冲突
2. 案例2-读读不冲突

1. 案例1-读写冲突
	
	set global transaction isolation level SERIALIZABLE;

	root@localhost [(none)]>select @@tx_isolation;
	+----------------+
	| @@tx_isolation |
	+----------------+
	| SERIALIZABLE   |
	+----------------+
	1 row in set (0.00 sec)


	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

	root@localhost [db1]>select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	+----+------+------+
	2 rows in set (0.00 sec)

	begin;
	update t set d=3 where c=1;
						
						begin;
						mysql>select * from t where c=2;
						+----+------+------+
						| id | c    | d    |
						+----+------+------+
						|  2 |    2 |    2 |
						+----+------+------+
						1 row in set (0.00 sec)
						
						select * from t where c=1;
						(Blocked)
						
	可以看到，在 SERIALIZABLE串行化隔离级别下，事务是串行的；数据一致性很高，但是没有并发的能力；会影响其它事务的正常读取操作。
	意味着对于同一行记录，“写”会加“写锁”，“读”会加“读锁”。当出现读写锁冲突的时候，后访问的事务必须等前一个事务执行完成，才能继续执行。
	 
	 
	select * from information_schema.innodb_trx\G;
	select * from information_schema.innodb_locks\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;

	root@localhost [(none)]>select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5894268
					 trx_state: RUNNING
				   trx_started: 2020-05-18 07:30:30
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 5
		   trx_mysql_thread_id: 32
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 4
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 3
			 trx_rows_modified: 1
	   trx_concurrency_tickets: 0
		   trx_isolation_level: SERIALIZABLE
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	*************************** 2. row ***************************
						trx_id: 421620588106240
					 trx_state: LOCK WAIT
				   trx_started: 2020-05-18 07:32:47
		 trx_requested_lock_id: 421620588106240:245:4:2
			  trx_wait_started: 2020-05-18 07:32:47
					trx_weight: 2
		   trx_mysql_thread_id: 37
					 trx_query: select * from t where c=1
		   trx_operation_state: starting index read
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 2
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 1
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: SERIALIZABLE
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	2 rows in set (0.04 sec)

	ERROR: 
	No query specified

	root@localhost [(none)]>select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 421620588106240:245:4:2
	lock_trx_id: 421620588106240
	  lock_mode: S
	  lock_type: RECORD
	 lock_table: `db1`.`t`
	 lock_index: c
	 lock_space: 245
	  lock_page: 4
	   lock_rec: 2
	  lock_data: 1, 1
	*************************** 2. row ***************************
		lock_id: 5894268:245:4:2
	lock_trx_id: 5894268
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `db1`.`t`
	 lock_index: c
	 lock_space: 245
	  lock_page: 4
	   lock_rec: 2
	  lock_data: 1, 1
	2 rows in set, 1 warning (0.00 sec)

	ERROR: 
	No query specified

	root@localhost [(none)]>SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+---------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query             | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+---------------------------+-------------------+--------------------+
	| c            | RECORD      | select * from t where c=1 | S                 | X                  |
	+--------------+-------------+---------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.08 sec)



2. 案例2-读读不冲突
	
	set global transaction isolation level SERIALIZABLE;

	root@localhost [(none)]>select @@tx_isolation;
	+----------------+
	| @@tx_isolation |
	+----------------+
	| SERIALIZABLE   |
	+----------------+
	1 row in set (0.00 sec)


	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

	root@localhost [db1]>select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	+----+------+------+
	2 rows in set (0.00 sec)


	SESSION A						SESSION B

	begin;								
	mysql>select * from t where c=1;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	+----+------+------+
	1 row in set (0.00 sec)	

									begin;								
									mysql>select * from t where c=1;
									+----+------+------+
									| id | c    | d    |
									+----+------+------+
									|  1 |    1 |    1 |
									+----+------+------+
									1 row in set (0.00 sec)	
	