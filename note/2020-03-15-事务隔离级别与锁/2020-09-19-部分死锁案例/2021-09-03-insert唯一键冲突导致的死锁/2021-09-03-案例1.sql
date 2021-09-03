
大纲
	1. 环境、初始化表结构和数据
	2. insert 唯一键冲突导致的死锁
	3. insert 语句默认不加锁
	4. 发生唯一键冲突之后对记录加共享锁类型的next-key lock	



1. 环境、初始化表结构和数据
	
	mysql> select version();
	+------------------+
	| version()        |
	+------------------+
	| 5.7.26-debug-log |
	+------------------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%iso%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	| tx_isolation          | REPEATABLE-READ |
	+-----------------------+-----------------+
	2 rows in set (0.01 sec)


	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;



	insert into t values(null, 1,1);
	insert into t values(null, 2,2);
	insert into t values(null, 3,3);
	insert into t values(null, 4,4);
	
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	+----+------+------+
	4 rows in set (0.06 sec)


2. insert 唯一键冲突导致的死锁

	
	时间点	session A                      	session B                  					session C
			begin;
			insert into t values(null, 5, 5);
	T1 
			
	
											insert into t values(null, 5, 5);	
											(Blocked)	
	T2
							
																						 insert into t values(null, 5, 5);

			rollback;
											Query OK, 1 row affected (27.78 sec)

																						 ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
	
	T2:
		在8.0版本中查看锁等待信息
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140640974727784:1071:140640851653288   |                 53550 |        59 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140640974727784:14:5:6:140640851650248 |                 53550 |        59 | t           | c          | RECORD    | S             | WAITING     | 5, 5      |
		-- 
		| 140640974728656:1071:140640851659240   |                 53549 |        58 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140640974728656:14:5:6:140640851656312 |                 53549 |        59 | t           | c          | RECORD    | X,REC_NOT_GAP | GRANTED     | 5, 5      |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)



	死锁日志:
	
		2021-04-30T10:17:30.276895+08:00 4 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2021-04-30T10:17:30.276925+08:00 4 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 9499679, ACTIVE 28 sec inserting
		mysql tables in use 1, locked 1
		LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
		MySQL thread id 2, OS thread handle 140670100358912, query id 62 localhost root update
		insert into t values(null, 5, 5)
		2021-04-30T10:17:30.277315+08:00 4 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 27403 page no 4 n bits 72 index c of table `420_db`.`t` trx id 9499679 lock_mode X insert intention waiting
		Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
		 0: len 8; hex 73757072656d756d; asc supremum;;

		2021-04-30T10:17:30.277744+08:00 4 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 9499680, ACTIVE 14 sec inserting
		mysql tables in use 1, locked 1
		4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
		MySQL thread id 4, OS thread handle 140670099293952, query id 64 localhost root update
		insert into t values(null, 5, 5)
		2021-04-30T10:17:30.277891+08:00 4 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		RECORD LOCKS space id 27403 page no 4 n bits 72 index c of table `420_db`.`t` trx id 9499680 lock mode S
		Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
		 0: len 8; hex 73757072656d756d; asc supremum;;

		2021-04-30T10:17:30.278148+08:00 4 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 27403 page no 4 n bits 72 index c of table `420_db`.`t` trx id 9499680 lock_mode X insert intention waiting
		Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
		 0: len 8; hex 73757072656d756d; asc supremum;;

		2021-04-30T10:17:30.278529+08:00 4 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)
				

	根据死锁日志分析加锁规则
	
		session A(TRANSACTION ID = 9499679)        		session B(TRANSACTION ID = 9499680)  
		
		对应语句：
			insert into t values(null, 5, 5)
														对应语句：
															insert into t values(null, 5, 5)
															
		持有的锁：
			unique key: c=5 的共享锁
														持有的锁：
															unique key: c=5 的共享锁
		在等待的锁：
			想要申请unique key: c=5 的写锁，但是被阻塞
																												
														在等待的锁：
															想要申请unique key: c=5 的写锁，但是被阻塞
															


3. insert 语句默认不加锁
	-- 有唯一索引也是如此
	
	session A                 	session B
	b lock_rec_lock
	
								mysql> begin;
								Query OK, 0 rows affected (0.00 sec)

								mysql> insert into t values(null, 5, 5);
								Query OK, 1 row affected (0.00 sec)
									

4. 发生唯一键冲突之后对记录加共享锁类型的next-key lock			
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	+----+------+------+
	4 rows in set (0.06 sec)

	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
		
	
	sessoin A                    session B                                        
	insert into t values(10, 10, 10);
	select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	| 10 |   10 |   10 |
	+----+------+------+
	5 rows in set (0.00 sec)

								begin;
								mysql> insert into t values(11, 10, 10);
								ERROR 1062 (23000): Duplicate entry '10' for key 'c'
								
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA              |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	| 140640974727784:1071:140640851653288   |                 53558 |        59 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL                   |
	| 140640974727784:14:5:6:140640851650248 |                 53558 |        59 | t           | c          | RECORD    | S         | GRANTED     | 10, 10                 |
	| 140640974727784:14:4:1:140640851650936 |                 53558 |        59 | t           | PRIMARY    | RECORD    | X         | GRANTED     | supremum pseudo-record |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	3 rows in set (0.00 sec)

	-- 唯一性约束检查发生冲突时，会对冲突的记录加 S next-key lock，带 gap 属性，会锁住记录以及与前1条记录之前的间隙；
	
	
如果表有唯一索引：
	RR隔离级别：加 next-key lock
	RC隔离级别：加 record lock
	