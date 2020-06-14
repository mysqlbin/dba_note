

1. 初始化表结构和数据
2. RC隔离级别
	2.1 insert ... select ...
	2.2 insert ... select ... lock in share mode
3. RR隔离级别
	3.1 insert ... select ...
4. 小结

	
1. 初始化表结构和数据
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

	CREATE TABLE `_t_new` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  `CreateTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`) USING BTREE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');

	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (0.00 sec)
	
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

2. RC隔离级别
	
	mysql> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| READ-COMMITTED        |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	mysql>  select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+
	1 row in set, 1 warning (0.00 sec)

2.1 insert ... select ...
	事务的执行次序	
	session A             session B            
	begin;
	insert into _t_new(id,c,d) select id,c,d from t;
	
						  begin;
						  delete from t where id=1;
						  (Query OK)
					  
					  
2.2 insert ... select ... lock in share mode
	事务的执行次序	
	session A           session B  
	begin;
	insert into _t_new(id,c,d) select id,c,d from t lock in share mode;
	
						begin;
						delete from t where id=1;
						(Blocked)
					  
	锁的信息如下
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 166083525
						 trx_state: LOCK WAIT
					   trx_started: 2020-05-21 15:41:57
			 trx_requested_lock_id: 166083525:308:3:2
				  trx_wait_started: 2020-05-21 15:41:57
						trx_weight: 2
			   trx_mysql_thread_id: 102
						 trx_query: delete from t where id=1
			   trx_operation_state: starting index read
				 trx_tables_in_use: 1
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
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
							trx_id: 166083520
						 trx_state: RUNNING
					   trx_started: 2020-05-21 15:41:48
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 8
			   trx_mysql_thread_id: 90
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 2
				  trx_lock_structs: 3
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 5
				 trx_rows_modified: 5
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

		mysql> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
			lock_id: 166083525:308:3:2
		lock_trx_id: 166083525
		  lock_mode: X
		  lock_type: RECORD
		 lock_table: `test_db`.`t`
		 lock_index: PRIMARY
		 lock_space: 308
		  lock_page: 3
		   lock_rec: 2
		  lock_data: 1
		*************************** 2. row ***************************
			lock_id: 166083520:308:3:2
		lock_trx_id: 166083520
		  lock_mode: S
		  lock_type: RECORD
		 lock_table: `test_db`.`t`
		 lock_index: PRIMARY
		 lock_space: 308
		  lock_page: 3
		   lock_rec: 2
		  lock_data: 1
		2 rows in set, 1 warning (0.00 sec)


		mysql> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 166083525
		requested_lock_id: 166083525:308:3:2
		  blocking_trx_id: 166083520
		 blocking_lock_id: 166083520:308:3:2
		1 row in set, 1 warning (0.00 sec)


		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+--------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query            | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+--------------------------+-------------------+--------------------+
		| PRIMARY      | RECORD      | delete from t where id=1 | X                 | S                  |
		+--------------+-------------+--------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.07 sec)
					  

					  
3. RR隔离级别
	
	mysql> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| REPEATABLE-READ       |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	mysql> select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| REPEATABLE-READ        |
	+------------------------+
	1 row in set, 1 warning (0.00 sec)

				  
3.1 insert ... select ...	
	事务的执行次序
	session A             session B            
	begin;
	insert into _t_new(id,c,d) select id,c,d from t;
	
						  begin;
						  delete from t where id=1;					  
						  (Blocked)
					  
	锁的信息如下					  
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 166083540
						 trx_state: LOCK WAIT
					   trx_started: 2020-05-21 16:08:54
			 trx_requested_lock_id: 166083540:308:3:2
				  trx_wait_started: 2020-05-21 16:08:54
						trx_weight: 2
			   trx_mysql_thread_id: 107
						 trx_query: delete from t where id=1
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
							trx_id: 166083531
						 trx_state: RUNNING
					   trx_started: 2020-05-21 16:08:24
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 8
			   trx_mysql_thread_id: 108
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 2
				  trx_lock_structs: 3
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 6
				 trx_rows_modified: 5
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

		mysql> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
			lock_id: 166083540:308:3:2
		lock_trx_id: 166083540
		  lock_mode: X
		  lock_type: RECORD
		 lock_table: `test_db`.`t`
		 lock_index: PRIMARY
		 lock_space: 308
		  lock_page: 3
		   lock_rec: 2
		  lock_data: 1
		*************************** 2. row ***************************
			lock_id: 166083531:308:3:2
		lock_trx_id: 166083531
		  lock_mode: S
		  lock_type: RECORD
		 lock_table: `test_db`.`t`
		 lock_index: PRIMARY
		 lock_space: 308
		  lock_page: 3
		   lock_rec: 2
		  lock_data: 1
		2 rows in set, 1 warning (0.00 sec)

		mysql> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 166083540
		requested_lock_id: 166083540:308:3:2
		  blocking_trx_id: 166083531
		 blocking_lock_id: 166083531:308:3:2
		1 row in set, 1 warning (0.00 sec)


		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+--------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query            | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+--------------------------+-------------------+--------------------+
		| PRIMARY      | RECORD      | delete from t where id=1 | X                 | S                  |
		+--------------+-------------+--------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.01 sec)

4. 小结
	RC隔离级别的 insert ... select ... t 语句,默认对 t表的数据不加锁
	RR隔离级别的 insert ... select ... t 语句,默认对 t表的数据加共享锁.
	
	

