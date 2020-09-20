
select * from information_schema.innodb_trx\G;
SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	

1. 初始化表结构和数据
2. RC隔离级别
	2.1 insert ... select ...
	2.2 insert ... select ... lock in share mode
3. RR隔离级别
	3.1 insert ... select ...
4. 小结


	
1. 初始化表结构和数据
	
	drop table if exists t;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
	
	drop table if exists _t_new;
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
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)

2. RC隔离级别
	
	mysql> show global variables like '%isolation%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	+-----------------------+----------------+
	1 row in set (0.29 sec)

2.1 insert ... select ...

	事务的执行次序	
	session A             session B            
	begin;
	insert into _t_new(id,c,d) select id,c,d from t;
	
						  begin;
						  delete from t where id=1;
						  (Query OK)
					  
	----------------------------------------------
	
	事务的执行次序	
	session A             session B            
	begin;
	delete from t where id=1;
						 	
						  begin;
						  insert into _t_new(id,c,d) select id,c,d from t;
						  (Query OK)
	commit;
						  commit; 
						  
	mysql> select * from _t_new;
	+----+------+------+-------------------------+
	| id | c    | d    | CreateTime              |
	+----+------+------+-------------------------+
	|  1 |    1 |    1 | 2020-09-18 11:04:47.351 |
	|  2 |    2 |    2 | 2020-09-18 11:04:47.351 |
	|  3 |    3 |    3 | 2020-09-18 11:04:47.351 |
	|  4 |    4 |    4 | 2020-09-18 11:04:47.351 |
	|  5 |    5 |    5 | 2020-09-18 11:04:47.351 |
	+----+------+------+-------------------------+
	5 rows in set (0.00 sec)


	
	

	
2.2 insert ... select ... lock in share mode


	事务的执行次序	
	session A           session B  
	begin;
	insert into _t_new(id,c,d) select id,c,d from t lock in share mode;
	
	T1 
						begin;
						delete from t where id=1;
						(Blocked)
	T2 				 
	T1 

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140217799486320:1079:140217730295560   |                  3542 |        96 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140217799486320:22:4:2:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140217799486320:22:4:3:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140217799486320:22:4:4:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140217799486320:22:4:5:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140217799486320:22:4:6:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 140217799486320:1080:140217730295648   |                  3542 |        96 | _t_new      | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.06 sec)



	T2
	mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
						trx_id: 3551
					 trx_state: LOCK WAIT
				   trx_started: 2020-09-18 11:08:13
		 trx_requested_lock_id: 140217799488064:22:4:2:140217730304488
			  trx_wait_started: 2020-09-18 11:08:13
					trx_weight: 2
		   trx_mysql_thread_id: 50
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
						trx_id: 3542
					 trx_state: RUNNING
				   trx_started: 2020-09-18 11:07:20
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 8
		   trx_mysql_thread_id: 45
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

	ERROR: 
	No query specified

	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	*************************** 1. row ***************************
		  locked_index: PRIMARY
		   locked_type: RECORD
		 waiting_query: delete from t where id=1
	 waiting_lock_mode: X,REC_NOT_GAP
	blocking_lock_mode: S,REC_NOT_GAP
	1 row in set (0.04 sec)


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140217799488064:1079:140217730307528   |                  3551 |       101 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140217799488064:22:4:2:140217730304488 |                  3551 |       101 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1         |
		
	| 140217799486320:1079:140217730295560   |                  3542 |        96 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140217799486320:22:4:2:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140217799486320:22:4:3:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140217799486320:22:4:4:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140217799486320:22:4:5:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140217799486320:22:4:6:140217730292616 |                  3542 |        96 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 140217799486320:1080:140217730295648   |                  3542 |        96 | _t_new      | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
					 
3. RR隔离级别
		
	mysql> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.00 sec)
				  
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
							trx_id: 3623
						 trx_state: LOCK WAIT
					   trx_started: 2020-09-18 11:12:29
			 trx_requested_lock_id: 140217799484576:24:4:2:140217730280424
				  trx_wait_started: 2020-09-18 11:12:29
						trx_weight: 2
			   trx_mysql_thread_id: 54
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
							trx_id: 3618
						 trx_state: RUNNING
					   trx_started: 2020-09-18 11:12:12
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 8
			   trx_mysql_thread_id: 53
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
		2 rows in set (0.01 sec)


		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
		*************************** 1. row ***************************
			  locked_index: PRIMARY
			   locked_type: RECORD
			 waiting_query: delete from t where id=1
		 waiting_lock_mode: X,REC_NOT_GAP
		blocking_lock_mode: S
		1 row in set (0.01 sec)

		
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA              |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
		| 140217799484576:1081:140217730283464   |                  3623 |       105 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL                   |
		| 140217799484576:24:4:2:140217730280424 |                  3623 |       105 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1                      |
		| 140217799482832:1081:140217730271480   |                  3618 |       104 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL                   |
		| 140217799482832:24:4:1:140217730268552 |                  3618 |       104 | t           | PRIMARY    | RECORD    | S             | GRANTED     | supremum pseudo-record |
		| 140217799482832:24:4:2:140217730268552 |                  3618 |       104 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 1                      |
		| 140217799482832:24:4:3:140217730268552 |                  3618 |       104 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 2                      |
		| 140217799482832:24:4:4:140217730268552 |                  3618 |       104 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 3                      |
		| 140217799482832:24:4:5:140217730268552 |                  3618 |       104 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4                      |
		| 140217799482832:24:4:6:140217730268552 |                  3618 |       104 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 5                      |
		| 140217799482832:1082:140217730271568   |                  3618 |       104 | _t_new      | NULL       | TABLE     | IX            | GRANTED     | NULL                   |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
		10 rows in set (0.00 sec)

4. 小结
	RC隔离级别的 insert ... select ... t 语句,默认对 t表的数据不加锁
	RR隔离级别的 insert ... select ... t 语句,默认对 t表的数据加共享锁.
	
	

