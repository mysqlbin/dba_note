1. 官网例子
2. 自己的测试案例
	2.1 案例1
	2.2 案例2
	2.3 案例3
	2.4 案例4
1. 官网例子
	
	环境 
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


	表结构和初始化数据
		
		CREATE TABLE child (id int(11) NOT NULL, PRIMARY KEY(id)) ENGINE=InnoDB;
		INSERT INTO child (id) values (90),(102);
		mysql> select * from child;
		+-----+
		| id  |
		+-----+
		|  90 |
		| 102 |
		+-----+
		2 rows in set (0.00 sec)
		
	事务的执行次序
		客户端A创建一个包含两个索引记录(90和102)的表，然后启动一个事务，该事务在ID大于100的索引记录上放置一个排他锁。排他锁在记录102之前包含一个间隙锁
		session A						session B				
		START TRANSACTION;
		SELECT * FROM child WHERE id > 100 FOR UPDATE;
		+-----+
		| id  |
		+-----+
		| 102 |
		+-----+
		1 row in set (0.00 sec)


		T1
		
										START TRANSACTION;				
										INSERT INTO child (id) VALUES (101);
										(Blocked)
											
		T2							    
										INSERT INTO child (id) VALUES (91); 
										(Query OK)
										思考: 为什么这里可以执行成功
										
		
		T1
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
			| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA              |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
			| 139811159242760:1349:139811050573816    |               1004494 |       106 | child       | NULL       | TABLE     | IX        | GRANTED     | NULL                   |
			| 139811159242760:292:4:1:139811050570776 |               1004494 |       106 | child       | PRIMARY    | RECORD    | X         | GRANTED     | supremum pseudo-record |
			| 139811159242760:292:4:3:139811050570776 |               1004494 |       106 | child       | PRIMARY    | RECORD    | X         | GRANTED     | 102                    |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
			3 rows in set (0.00 sec)
		
		T2
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+------------------------+
			| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA              |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+------------------------+
			| 139811159243632:1349:139811050579960    |               1004496 |       107 | child       | NULL       | TABLE     | IX                     | GRANTED     | NULL                   |
			| 139811159243632:292:4:3:139811050577016 |               1004496 |       107 | child       | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 102                    |
			| 139811159242760:1349:139811050573816    |               1004494 |       106 | child       | NULL       | TABLE     | IX                     | GRANTED     | NULL                   |
			| 139811159242760:292:4:1:139811050570776 |               1004494 |       106 | child       | PRIMARY    | RECORD    | X                      | GRANTED     | supremum pseudo-record |
			| 139811159242760:292:4:3:139811050570776 |               1004494 |       106 | child       | PRIMARY    | RECORD    | X                      | GRANTED     | 102                    |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+------------------------+
			5 rows in set (0.00 sec)	
			
			mysql> select * from information_schema.innodb_trx\G;
				*************************** 1. row ***************************
								trx_id: 1004496
							 trx_state: LOCK WAIT
						   trx_started: 2020-05-20 09:46:53
				 trx_requested_lock_id: 139811159243632:292:4:3:139811050577016
					  trx_wait_started: 2020-05-20 09:46:53
							trx_weight: 2
				   trx_mysql_thread_id: 57
							 trx_query: INSERT INTO child (id) VALUES (101)
				   trx_operation_state: inserting
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
								trx_id: 1004494
							 trx_state: RUNNING
						   trx_started: 2020-05-20 09:45:40
				 trx_requested_lock_id: NULL
					  trx_wait_started: NULL
							trx_weight: 2
				   trx_mysql_thread_id: 56
							 trx_query: NULL
				   trx_operation_state: NULL
					 trx_tables_in_use: 0
					 trx_tables_locked: 1
					  trx_lock_structs: 2
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
			2 rows in set (0.00 sec)
			
			mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
			*************************** 1. row ***************************
				  locked_index: PRIMARY
				   locked_type: RECORD
				 waiting_query: INSERT INTO child (id) VALUES (101)
			 waiting_lock_mode: X,GAP,INSERT_INTENTION
			blocking_lock_mode: X
			1 row in set (0.01 sec)

2. 自己的测试案例

	表结构和初始化数据
		CREATE TABLE `t` (
		  `id` int(11) NOT NULL,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

		mysql> select * from t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  0 |    0 |    0 |
		|  5 |    5 |    5 |
		| 10 |   10 |   10 |
		| 15 |   15 |   15 |
		| 20 |   20 |   20 |
		| 25 |   25 |   25 |
		+----+------+------+
		6 rows in set (0.00 sec)
		
		
	2.1 案例1

		事务的执行次序
			session A                           session B                       
			begin;
			delete from t where c=10; 
												insert into t values(12,12,12);
												(Blocked)
												
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
			| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
			| 139859108159800:1303:139859033399624    |                869679 |      2064 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
			| 139859108159800:246:5:5:139859033396744 |                869679 |      2064 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 15, 15    |
			
			| 139859108158928:1303:139859033393640    |                869674 |      2063 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
			| 139859108158928:246:5:4:139859033390712 |                869674 |      2063 | t           | c          | RECORD    | X                      | GRANTED     | 10, 10    |
			| 139859108158928:246:4:4:139859033391056 |                869674 |      2063 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 10        |
			| 139859108158928:246:5:5:139859033391400 |                869674 |      2063 | t           | c          | RECORD    | X,GAP                  | GRANTED     | 15, 15    |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
			6 rows in set (0.00 sec)
			
			mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
			+--------------+-------------+--------------------------------+------------------------+--------------------+
			| locked_index | locked_type | waiting_query                  | waiting_lock_mode      | blocking_lock_mode |
			+--------------+-------------+--------------------------------+------------------------+--------------------+
			| c            | RECORD      | insert into t values(12,12,12) | X,GAP,INSERT_INTENTION | X,GAP              |
			+--------------+-------------+--------------------------------+------------------------+--------------------+
			1 row in set (0.04 sec)
			
	2.2 案例2
		事务的执行次序
			session B     					    session C                 

			begin;
			insert into t values(12,18,18);
			(Query OK)
			
												begin;
												insert into t values(13,19,19);
												(Query OK)
												commit;
			commit;
					
		select * from t;
			
		mysql> select * from t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  0 |    0 |    0 |
		|  5 |    5 |    5 |
		| 10 |   10 |   10 |
		| 12 |   18 |   18 |
		| 13 |   19 |   19 |
		| 15 |   15 |   15 |
		| 20 |   20 |   20 |
		| 25 |   25 |   25 |
		+----+------+------+
		8 rows in set (0.00 sec)
		
		验证了 多个事务，在同一个索引，同一个范围区间插入记录时，如果插入的位置不冲突，不会阻塞彼此, 提高了插入并发能力.
	

	2.3 案例3
		
		事务的执行次序
			session B     					    session C                 

			begin;
			insert into t values(13,18,18);
			
												begin;
												insert into t values(13,19,19);
												(Blocked)
												
												
		root@mysqldb 17:45:  [sbtest]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139859108160672:1303:139859033405624    |                869769 |      2079 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139859108160672:246:4:9:139859033402584 |                869769 |      2079 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 13        |
		| 139859108159800:1303:139859033399624    |                869766 |      2078 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139859108159800:246:4:9:139859033396744 |                869766 |      2079 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 13        |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)

		root@mysqldb 17:45:  [sbtest]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                  | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		| PRIMARY      | RECORD      | insert into t values(13,19,19) | S,REC_NOT_GAP     | X,REC_NOT_GAP      |
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		1 row in set (0.03 sec)
		
		验证了 多个事务，在同一个索引，同一个范围区间插入记录时，如果插入的位置冲突（session A 和 session B 插入的主键值都是为13），则会阻塞彼此。
		
	2.4 案例4
		mysql> select @@transaction_isolation;
		+-------------------------+
		| @@transaction_isolation |
		+-------------------------+
		| REPEATABLE-READ         |
		+-------------------------+
		1 row in set (0.00 sec)
 
		mysql> show global variables like '%isolation%';
		+-----------------------+-----------------+
		| Variable_name         | Value           |
		+-----------------------+-----------------+
		| transaction_isolation | REPEATABLE-READ |
		+-----------------------+-----------------+
		1 row in set (0.00 sec)

		mysql> select version();
		+-----------+
		| version() |
		+-----------+
		| 8.0.18    |
		+-----------+
		1 row in set (0.00 sec)	

		CREATE TABLE `t` (
		  `id` int NOT NULL AUTO_INCREMENT,
		  `c` int DEFAULT NULL,
		  `d` int DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

		INSERT INTO `t` (`id`, `c`, `d`) VALUES ('0', '0', '0');
		INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');
		INSERT INTO `t` (`id`, `c`, `d`) VALUES ('10', '10', '10');
		INSERT INTO `t` (`id`, `c`, `d`) VALUES ('15', '15', '15');
		INSERT INTO `t` (`id`, `c`, `d`) VALUES ('20', '20', '20');
		INSERT INTO `t` (`id`, `c`, `d`) VALUES ('25', '25', '25');

		
		事务的执行次序
			session B     					    session C                 

			begin;
			insert into t(c,d) values(18,18);
			T1
			
												begin;
												insert into t(c,d) values(18,18);
												(Query OK)
			T2
		T1
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+--------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			| ENGINE_LOCK_ID                       | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
			+--------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			| 140538819528104:1073:140538712009992 |                  2421 |        87 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
			+--------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			1 row in set (0.00 sec)

		T2
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+--------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			| ENGINE_LOCK_ID                       | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
			+--------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			| 140538819522000:1073:140538711967992 |                  2422 |        86 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
			| 140538819528104:1073:140538712009992 |                  2421 |        87 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
			+--------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			2 rows in set (0.00 sec)

		mysql> select c,id from t order by c asc;
		+------+----+
		| c    | id |
		+------+----+
		|    0 |  1 |
		|    5 |  5 |
		|   10 | 10 |
		|   15 | 15 |
		|   18 | 26 |
		|   18 | 27 |
		|   20 | 20 |
		|   25 | 25 |
		+------+----+
		8 rows in set (0.00 sec)