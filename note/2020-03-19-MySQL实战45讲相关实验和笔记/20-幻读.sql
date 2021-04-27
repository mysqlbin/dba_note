
1. RC隔离级别下幻读的例子
	1.1 表结构和数据初始化
	1.2 RC隔离级别下的幻读
	1.3 RR可重复读事务隔离级别消耗幻读
	1.4 持有 next-key lock 会阻塞往 gap lock 中写入数据
2. 间隙锁相关的实验
	2.1 表结构和数据初始化
	2.2 间隙锁跟间隙锁互相不会阻塞
	2.3 select * from t where d=5 for update;语句的加锁范围
	2.4 间隙锁导致的死锁案例
	
1. RC隔离级别下幻读的例子
	1.1 表结构和数据初始化
		DROP TABLE IF EXISTS `t518`;
		CREATE TABLE `t518` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB;

		insert into t518 values(1,1,1),(2,3,3),(3,5,5);
			
		root@mysqldb 15:25:  [sbtest]> select * from t518;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		|  2 |    3 |    3 |
		|  3 |    5 |    5 |
		+----+------+------+
		3 rows in set (0.00 sec)

	1.2 RC隔离级别下的幻读
		环境
			select @@global.transaction_isolation;
			select @@session.transaction_isolation;
			select version();
			
			mysql> select @@global.transaction_isolation;
			+--------------------------------+
			| @@global.transaction_isolation |
			+--------------------------------+
			| READ-COMMITTED                 |
			+--------------------------------+
			1 row in set (0.00 sec)

			mysql> select @@session.transaction_isolation;
			+---------------------------------+
			| @@session.transaction_isolation |
			+---------------------------------+
			| READ-COMMITTED                  |
			+---------------------------------+
			1 row in set (0.00 sec)

			mysql> select version();
			+-----------+
			| version() |
			+-----------+
			| 8.0.18    |
			+-----------+
			1 row in set (0.00 sec)
		
		事务的执行次序
			session A                                   session B
			begin;										begin;				
			select * from t518 where c=3 for update;  /*T1时刻*/
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  2 |    3 |    3 |
			+----+------+------+
			1 row in set (0.00 sec)
														
														mysql> select * from t518 where c=3;
														+----+------+------+
														| id | c    | d    |
														+----+------+------+
														|  2 |    3 |    3 |
														+----+------+------+
														1 row in set (0.00 sec)

														mysql> insert into t518(c,d) values(3,3);
														
														mysql> select * from t518 where c=3;
														+----+------+------+
														| id | c    | d    |
														+----+------+------+
														|  2 |    3 |    3 |
														|  4 |    3 |    3 |
														+----+------+------+
														2 rows in set (0.00 sec)

			mysql> select * from t518 where c=3;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  2 |    3 |    3 |
			+----+------+------+
			1 row in set (0.00 sec)
			
			select * from t518 where c=3 for update;   /* T2时刻 */
			(Blocked)
														commit;
			mysql> select * from t518 where c=3;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  2 |    3 |    3 |
			|  4 |    3 |    3 |
			+----+------+------+
			2 rows in set (0.00 sec)

			mysql> select * from t518 where c=3 for update;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  2 |    3 |    3 |
			|  4 |    3 |    3 |
			+----+------+------+
			2 rows in set (0.00 sec)
			
		T1时刻持有的锁	
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
			+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| 140538819524616:1071:140538711985928   |                  2370 |        73 | t518        | NULL       | TABLE     | IX            | GRANTED     | NULL      |
			| 140538819524616:14:5:3:140538711982888 |                  2370 |        73 | t518        | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 2      |
			| 140538819524616:14:4:3:140538711983232 |                  2370 |        73 | t518        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
			+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			3 rows in set (0.00 sec)
			
			索引值 c=3 的加锁范围: c: record lock: [3]
			
			
		T2时刻的行锁阻塞信息
			mysql> select * from information_schema.innodb_trx\G;
			*************************** 1. row ***************************
								trx_id: 1003930
							 trx_state: RUNNING
						   trx_started: 2020-05-18 15:45:31
				 trx_requested_lock_id: NULL
					  trx_wait_started: NULL
							trx_weight: 3
				   trx_mysql_thread_id: 61
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
			*************************** 2. row ***************************
								trx_id: 1003929
							 trx_state: LOCK WAIT
						   trx_started: 2020-05-18 15:45:03
				 trx_requested_lock_id: 140665283602440:287:5:5:140665212192800
					  trx_wait_started: 2020-05-18 15:47:07
							trx_weight: 4
				   trx_mysql_thread_id: 56
							 trx_query: select * from t518 where c=3 for update
				   trx_operation_state: fetching rows
					 trx_tables_in_use: 1
					 trx_tables_locked: 1
					  trx_lock_structs: 4
				 trx_lock_memory_bytes: 1136
					   trx_rows_locked: 4
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
			2 rows in set (0.00 sec)

			
			mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
			
			*************************** 1. row ***************************
				  locked_index: c
				   locked_type: RECORD
				 waiting_query: select * from t518 where c=3 for update
			 waiting_lock_mode: X,REC_NOT_GAP
			blocking_lock_mode: X,REC_NOT_GAP
			1 row in set (0.00 sec)


			root@mysqldb 15:47:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| 140665283603312:1344:140665212200952    |               1003930 |       111 | t518        | NULL       | TABLE     | IX            | GRANTED     | NULL      |
			| 140665283603312:287:5:5:140665212198008 |               1003930 |       106 | t518        | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 4      |
			| 140665283602440:1344:140665212194808    |               1003929 |       106 | t518        | NULL       | TABLE     | IX            | GRANTED     | NULL      |
			| 140665283602440:287:5:3:140665212191768 |               1003929 |       106 | t518        | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 3, 2      |
			| 140665283602440:287:4:3:140665212192112 |               1003929 |       106 | t518        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
			| 140665283602440:287:5:5:140665212192800 |               1003929 |       106 | t518        | c          | RECORD    | X,REC_NOT_GAP | WAITING     | 3, 4      |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			6 rows in set (0.01 sec)
			
	1.3 RR可重复读事务隔离级别消耗幻读
		
		环境 
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

			mysql> select version();
			+-----------+
			| version() |
			+-----------+
			| 8.0.18    |
			+-----------+
			1 row in set (0.00 sec)
		
		mysql> select * from t518;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		|  2 |    3 |    3 |
		|  3 |    5 |    5 |
		+----+------+------+
		3 rows in set (0.00 sec)
		
		事务的执行次序
			session A                                   session B
			begin;										begin;				
			select * from t518 where c=3 for update; 
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  2 |    3 |    3 |
			+----+------+------+
			1 row in set (0.00 sec)
														
														mysql> insert into t518(c,d) values(3,3);			
														(Blocked)
			
			
			session A的索引值 c=3 的加锁范围: c: next-key lock: (1,3] + c: gap lock: (3, 5); 
			session B 需要申请持有的锁 c: gap lock: (3, 5), 因此会被阻塞.
			
			因为要解决幻读问题，所以需要禁止别的事务插入c的值符合c = 3的记录，又因为主键本身就是唯一的，所以我们不用担心在c的值为3的前边有新记录插入，只需要保证不要让新记录插入到c的值为3的后边就好了
			
			
			select * from information_schema.innodb_trx\G;
			SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
			select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

			
			mysql> select * from information_schema.innodb_trx\G;
			*************************** 1. row ***************************
								trx_id: 1004315
							 trx_state: LOCK WAIT
						   trx_started: 2020-05-18 18:40:32
				 trx_requested_lock_id: 139811159242760:287:5:4:139811050570776
					  trx_wait_started: 2020-05-18 18:40:32
							trx_weight: 3
				   trx_mysql_thread_id: 9
							 trx_query: insert into t518(c,d) values(3,3)
				   trx_operation_state: inserting
					 trx_tables_in_use: 1
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
			*************************** 2. row ***************************
								trx_id: 1004314
							 trx_state: RUNNING
						   trx_started: 2020-05-18 18:40:31
				 trx_requested_lock_id: NULL
					  trx_wait_started: NULL
							trx_weight: 4
				   trx_mysql_thread_id: 14
							 trx_query: NULL
				   trx_operation_state: NULL
					 trx_tables_in_use: 0
					 trx_tables_locked: 1
					  trx_lock_structs: 4
				 trx_lock_memory_bytes: 1136
					   trx_rows_locked: 3
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
				  locked_index: c
				   locked_type: RECORD
				 waiting_query: insert into t518(c,d) values(3,3)
			 waiting_lock_mode: X,GAP,INSERT_INTENTION
			blocking_lock_mode: X,GAP
			1 row in set (0.10 sec)

			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
			| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
			| 139811159242760:1344:139811050573816    |               1004315 |        59 | t518        | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
			| 139811159242760:287:5:4:139811050570776 |               1004315 |        59 | t518        | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 5, 3      |
			
			| 139811159241888:1344:139811050567864    |               1004314 |        64 | t518        | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
			| 139811159241888:287:5:3:139811050564824 |               1004314 |        64 | t518        | c          | RECORD    | X                      | GRANTED     | 3, 2      |
			| 139811159241888:287:4:3:139811050565168 |               1004314 |        64 | t518        | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 2         |
			| 139811159241888:287:5:4:139811050565512 |               1004314 |        64 | t518        | c          | RECORD    | X,GAP                  | GRANTED     | 5, 3      |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
			6 rows in set (0.00 sec)
		
		
		1.4 持有 next-key lock 会阻塞往 gap lock 中写入数据
			事务的执行次序
				session A                                   session B
				begin;										begin;				
				select * from t518 where c=3 for update; 
				+----+------+------+
				| id | c    | d    |
				+----+------+------+
				|  2 |    3 |    3 |
				+----+------+------+
				1 row in set (0.00 sec)
																			
															mysql> insert into t518(c,d) values(2,2);
															(Blocked)


				mysql> select * from information_schema.innodb_trx\G;
				*************************** 1. row ***************************
									trx_id: 1004332
								 trx_state: LOCK WAIT
							   trx_started: 2020-05-18 18:57:16
					 trx_requested_lock_id: 139811159240144:287:5:3:139811050552952
						  trx_wait_started: 2020-05-18 18:57:16
								trx_weight: 3
					   trx_mysql_thread_id: 15
								 trx_query: insert into t518(c,d) values(2,2)
					   trx_operation_state: inserting
						 trx_tables_in_use: 1
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
				*************************** 2. row ***************************
									trx_id: 1004331
								 trx_state: RUNNING
							   trx_started: 2020-05-18 18:57:09
					 trx_requested_lock_id: NULL
						  trx_wait_started: NULL
								trx_weight: 4
					   trx_mysql_thread_id: 16
								 trx_query: NULL
					   trx_operation_state: NULL
						 trx_tables_in_use: 0
						 trx_tables_locked: 1
						  trx_lock_structs: 4
					 trx_lock_memory_bytes: 1136
						   trx_rows_locked: 3
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
					  locked_index: c
					   locked_type: RECORD
					 waiting_query: insert into t518(c,d) values(2,2)
				 waiting_lock_mode: X,GAP,INSERT_INTENTION
				blocking_lock_mode: X
				1 row in set (0.01 sec)
				
				root@mysqldb 18:57:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
				+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
				| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
				+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
				| 139811159240144:1344:139811050555880    |               1004332 |        65 | t518        | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
				| 139811159240144:287:5:3:139811050552952 |               1004332 |        65 | t518        | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 3, 2      |

				| 139811159241888:1344:139811050567864    |               1004331 |        66 | t518        | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
				| 139811159241888:287:5:3:139811050564824 |               1004331 |        66 | t518        | c          | RECORD    | X                      | GRANTED     | 3, 2      | # 
				| 139811159241888:287:4:3:139811050565168 |               1004331 |        66 | t518        | PRIMARY    | RECORD    | X,REC_NOT_GAP          | GRANTED     | 2         |
				| 139811159241888:287:5:4:139811050565512 |               1004331 |        66 | t518        | c          | RECORD    | X,GAP                  | GRANTED     | 5, 3      |
				+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
				6 rows in set (0.01 sec)
				
				事务1持有的锁
					INDEX_NAME='c'，LOCK_TYPE'=RECORD'，LOCK_MODE='X', LOCK_STATUS=GRANTED，LOCK_DATA='3, 2': ```c: next lock: (1, 3]```
					为什么 LOCK_MODE 只有 X 这个值
					验证了 performance_schema.data_locks 并不总是能看到全部的锁
				事务2在等待的锁	
					INDEX_NAME='c'，LOCK_TYPE='RECORD'，LOCK_MODE='X,GAP,INSERT_INTENTION', LOCK_STATUS=WAITING，LOCK_DATA='3, 2': ```c: gap lock: (1,3)```

				析加锁规则的时候可以用 next-key lock 来分析；但是要知道，具体执行的时候，是要分成间隙锁和行锁两段来执行的。
					
2. 间隙锁相关的实验
	
	2.1 表结构和数据初始化
		CREATE TABLE `t` (
		  `id` int(11) NOT NULL,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB;

		insert into t values(0,0,0),(5,5,5),
		(10,10,10),(15,15,15),(20,20,20),(25,25,25);

	2. 间隙锁跟间隙锁互相不会阻塞
		
		SESSION A                       		SESSION B
		begin;
		select * from t where id=7 for update;

												begin;
												select * from t where id=7 for update;
												(Query OK)
		这里的 SESSION B并不会被阻塞。
		因为表t里并没有 c=7这个记录；SESSION A加的是间隙锁(5,10), SESSION A加的也是间隙锁(5,10)	。
		SESSION A和SESSION B共同的目标是 保护这个间隙，不允许插入值， 同时它们是互不冲突的。
			
									
	3. select * from t where d=5 for update;语句的加锁范围
										
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

		mysql> select version();
		+-----------+
		| version() |
		+-----------+
		| 8.0.18    |
		+-----------+
		1 row in set (0.00 sec)

		session A                session B
		begin;

		mysql> select * from t where d=5 for update;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  5 |    5 |    5 |
		+----+------+------+
		1 row in set (0.00 sec)
								select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;


		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA              |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
		| 140665283599824:1303:140665212176872    |               1003819 |        92 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL                   |
		| 140665283599824:246:4:1:140665212173944 |               1003819 |        92 | t           | PRIMARY    | RECORD    | X         | GRANTED     | supremum pseudo-record |
		| 140665283599824:246:4:2:140665212173944 |               1003819 |        92 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 0                      |
		| 140665283599824:246:4:3:140665212173944 |               1003819 |        92 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 5                      |
		| 140665283599824:246:4:4:140665212173944 |               1003819 |        92 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 10                     |
		| 140665283599824:246:4:5:140665212173944 |               1003819 |        92 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 15                     |
		| 140665283599824:246:4:6:140665212173944 |               1003819 |        92 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 20                     |
		| 140665283599824:246:4:7:140665212173944 |               1003819 |        92 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 25                     |
		+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
		8 rows in set (0.00 sec)


		间隙锁和行锁合称 next-key lock，每个 next-key lock 是前开后闭区间; 间隙锁记为开区间，把 next-key lock 记为前开后闭区间。
		我们的表 t 初始化以后，如果用 select * from t where d=5 for update 要把整个表所有记录锁起来，就形成了 7 个 next-key lock，分别是:
			(-∞,0]、(0,5]、(5,10]、(10,15]、(15,20]、(20, 25]、(25, +supremum]。
		
			+∞是开区间;
			supremun: InnoDB给每个索引加了一个不存在的最大值 supremun, 这样才符合我们前面说的  "都是前开后闭区间".




RR级别：扫描到的数据都会加行锁和间隙锁 
RC级别：扫描到的数据都会加行锁，但是不满足条件的数据，没有到commit阶段，就会释放，违反了两阶段加锁原则 全表扫描一直指的是扫描主键索引。



