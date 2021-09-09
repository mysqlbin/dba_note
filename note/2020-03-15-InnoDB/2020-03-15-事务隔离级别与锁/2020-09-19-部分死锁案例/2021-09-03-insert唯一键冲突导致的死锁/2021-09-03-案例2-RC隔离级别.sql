
大纲
	0. 环境
	1. 死锁现象
	2. 小结
		
0. 环境
	
	mysql> show global variables like '%iso%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	+-----------------------+----------------+
	1 row in set (0.01 sec)

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

1. 死锁现象

	CREATE TABLE `deadlock` (
	  `id` bigint(12) NOT NULL AUTO_INCREMENT,
	  `col1` varchar(24) NOT NULL,
	  `col2` varchar(24) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `idx_uk_tcs_user_fund_info_up` (`col1`,`col2`)
	) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8; 
		
	insert into deadlock(col1,col2) values ('a',1),('a',5),('a',9);

	mysql> select * from deadlock;
	+----+------+------+
	| id | col1 | col2 |
	+----+------+------+
	| 36 | a    | 1    |
	| 37 | a    | 5    |
	| 38 | a    | 9    |
	+----+------+------+
	3 rows in set (0.00 sec)

		
		session A      		session B
		BEGIN;				BEGIN;

							insert into deadlock (col1,col2) values ('a','4');
		insert into deadlock(col1,col2) values ('a','4');
		(Blocked)
	T1

							insert into deadlock (col1,col2) values ('a','3');
							
		ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction		

	T2
			
	T1
		root@mysqldb 17:39:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME                   | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+---------------+-------------+--------------+
		| 140133593923024:1072:140133508647400   |                 54538 |        58 | deadlock    | NULL                         | TABLE     | IX            | GRANTED     | NULL         |
		| 140133593923024:15:5:5:140133508644472 |                 54538 |        58 | deadlock    | idx_uk_tcs_user_fund_info_up | RECORD    | S             | WAITING     | 'a', '4', 42 |
		| 140133593922152:1072:140133508641448   |                 54537 |        59 | deadlock    | NULL                         | TABLE     | IX            | GRANTED     | NULL         |
		| 140133593922152:15:5:5:140133508638408 |                 54537 |        58 | deadlock    | idx_uk_tcs_user_fund_info_up | RECORD    | X,REC_NOT_GAP | GRANTED     | 'a', '4', 42 |
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+---------------+-------------+--------------+
		4 rows in set (0.01 sec)

	T2
		root@mysqldb 17:40:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+------------------------+-------------+--------------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME                   | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA    |
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+------------------------+-------------+--------------+
		| 140133593922152:1072:140133508641448   |                 54537 |        59 | deadlock    | NULL                         | TABLE     | IX                     | GRANTED     | NULL         |
		| 140133593922152:15:5:5:140133508638408 |                 54537 |        58 | deadlock    | idx_uk_tcs_user_fund_info_up | RECORD    | X,REC_NOT_GAP          | GRANTED     | 'a', '4', 42 |
		| 140133593922152:15:5:5:140133508638752 |                 54537 |        59 | deadlock    | idx_uk_tcs_user_fund_info_up | RECORD    | X,GAP,INSERT_INTENTION | GRANTED     | 'a', '4', 42 |
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+------------------------+-------------+--------------+
		3 rows in set (0.00 sec)



		------------------------
		LATEST DETECTED DEADLOCK
		------------------------
		2021-09-03 17:40:22 0x7f72c43a9700
		*** (1) TRANSACTION:
		TRANSACTION 54538, ACTIVE 35 sec inserting
		mysql tables in use 1, locked 1
		LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
		MySQL thread id 8, OS thread handle 140130829338368, query id 10 localhost root update
		insert into deadlock (col1,col2) values ('a','4')

		*** (1) HOLDS THE LOCK(S):
		RECORD LOCKS space id 15 page no 5 n bits 72 index idx_uk_tcs_user_fund_info_up of table `sbtest`.`deadlock` trx id 54538 lock mode S waiting
		Record lock, heap no 5 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
		 0: len 1; hex 61; asc a;;
		 1: len 1; hex 34; asc 4;;
		 2: len 8; hex 800000000000002a; asc        *;;


		*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
		RECORD LOCKS space id 15 page no 5 n bits 72 index idx_uk_tcs_user_fund_info_up of table `sbtest`.`deadlock` trx id 54538 lock mode S waiting
		Record lock, heap no 5 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
		 0: len 1; hex 61; asc a;;
		 1: len 1; hex 34; asc 4;;
		 2: len 8; hex 800000000000002a; asc        *;;


		*** (2) TRANSACTION:
		TRANSACTION 54537, ACTIVE 38 sec inserting
		mysql tables in use 1, locked 1
		LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
		MySQL thread id 9, OS thread handle 140130827757312, query id 12 localhost root update
		insert into deadlock (col1,col2) values ('a','3')

		*** (2) HOLDS THE LOCK(S):
		RECORD LOCKS space id 15 page no 5 n bits 72 index idx_uk_tcs_user_fund_info_up of table `sbtest`.`deadlock` trx id 54537 lock_mode X locks rec but not gap
		Record lock, heap no 5 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
		 0: len 1; hex 61; asc a;;
		 1: len 1; hex 34; asc 4;;
		 2: len 8; hex 800000000000002a; asc        *;;


		*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
		RECORD LOCKS space id 15 page no 5 n bits 72 index idx_uk_tcs_user_fund_info_up of table `sbtest`.`deadlock` trx id 54537 lock_mode X locks gap before rec insert intention waiting
		Record lock, heap no 5 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
		 0: len 1; hex 61; asc a;;
		 1: len 1; hex 34; asc 4;;
		 2: len 8; hex 800000000000002a; asc        *;;

		*** WE ROLL BACK TRANSACTION (1)


2. 小结
	本案例在RC隔离级别下也会发生死锁。
	因为 在 READ-COMMITTED 隔离级别，也会存在 gap lock ，只发生在：
		唯一约束检查到有唯一冲突的时候，会加 S Next-key Lock，即对记录以及与和上一条记录之间的间隙加共享锁。

	




