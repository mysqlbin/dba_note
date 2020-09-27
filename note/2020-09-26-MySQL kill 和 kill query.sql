
验证  kill query 和 kill connect 的效果

1. 初始化表结构和数据
2. 长事务和对应的状态
3. kill query
4. kill connect


1. 初始化表结构和数据

	CREATE TABLE `t` (
	  `id` bigint NOT NULL AUTO_INCREMENT,
	  `c` int DEFAULT NULL,
	  `d` int DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `zst`.`t` (`id`, `c`, `d`) VALUES ('5', '5', '5');



2. 长事务和对应的状态

	session A  
	
	begin;
	delete from t where id=1;
	
	show processlist;
	select * from information_schema.innodb_trx\G;
	select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

	mysql> show processlist;
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	| Id | User            | Host      | db   | Command | Time  | State                  | Info             |
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	|  4 | event_scheduler | localhost | NULL | Daemon  | 24496 | Waiting on empty queue | NULL             |
	| 18 | root            | localhost | zst  | Sleep   |    80 |                        | NULL             |
	| 19 | root            | localhost | NULL | Query   |     0 | starting               | show processlist |
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	3 rows in set (0.04 sec)

	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 4189
					 trx_state: RUNNING
				   trx_started: 2020-09-26 22:36:03
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 18
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


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140089599729104:1083:140089485232376   |                  4189 |        69 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140089599729104:26:4:2:140089485229448 |                  4189 |        69 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	2 rows in set (0.10 sec)

3. kill query

	mysql> kill query 18;
	Query OK, 0 rows affected (0.00 sec)


	mysql> show processlist;
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	| Id | User            | Host      | db   | Command | Time  | State                  | Info             |
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	|  4 | event_scheduler | localhost | NULL | Daemon  | 24549 | Waiting on empty queue | NULL             |
	| 18 | root            | localhost | zst  | Sleep   |   133 |                        | NULL             |
	| 19 | root            | localhost | NULL | Query   |     0 | starting               | show processlist |
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	3 rows in set (0.00 sec)

	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 4189
					 trx_state: RUNNING
				   trx_started: 2020-09-26 22:36:03
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 18
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

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140089599729104:1083:140089485232376   |                  4189 |        69 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140089599729104:26:4:2:140089485229448 |                  4189 |        69 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	2 rows in set (0.00 sec)

	-- 可以发现并没有把18号线程的这个长事务kill掉。

4. kill connect

	mysql> kill 18;
	Query OK, 0 rows affected (0.05 sec)

	mysql> kill 18;
	Query OK, 0 rows affected (0.05 sec)

	root@mysqldb 22:38:  [(none)]> show processlist;
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	| Id | User            | Host      | db   | Command | Time  | State                  | Info             |
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	|  4 | event_scheduler | localhost | NULL | Daemon  | 24584 | Waiting on empty queue | NULL             |
	| 19 | root            | localhost | NULL | Query   |     0 | starting               | show processlist |
	+----+-----------------+-----------+------+---------+-------+------------------------+------------------+
	2 rows in set (0.00 sec)
		
	mysql> select * from information_schema.innodb_trx\G;
	Empty set (0.00 sec)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	Empty set (0.00 sec)
	
	-- 可以看到，18号线程的长事务已经被kill掉。
	
5. 小结
	thread id 都是对应show processlist这个命令结果里的第一列


