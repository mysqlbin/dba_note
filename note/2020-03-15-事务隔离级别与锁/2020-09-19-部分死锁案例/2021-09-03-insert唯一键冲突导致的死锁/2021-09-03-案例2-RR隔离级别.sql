
大纲
	
	1. 死锁日志
	2. 根据死锁日志分析加锁规则
	3. 死锁模拟
	4. 解决/优化办法


1. 死锁日志
	
	20XX-08-28 15:16:20 7ef6422cc700
	*** (1) TRANSACTION:
	TRANSACTION 83006107154, ACTIVE 0 sec inserting
	mysql tables in use 1, locked 1
	LOCK WAIT 6 lock struct(s), heap size 1184, 1 row lock(s), undo log entries 5
	MySQL thread id 9641573, OS thread handle 0x7ef643492700, query id 18898913347 172.16.XXX.XXX transcore1 update
	insert into tcs_user_XXX_XXX
			(
			  user_id, product_id, melon_type, due_proc_mode
			  , buy_flag, buy_latest_time, is_attention, custom_sort, attention_time, remark
			  , create_time, modify_time)
		  values
			(
			  '51770202008281XXXX', 8101XXXX
			  , '1', null
			  , null, now(), null, null, now()
			  , null
			  , now(), now()
			)
	*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
	RECORD LOCKS space id 5351 page no 10159 n bits 288 index `idx_uk_tcs_user_fund_XXX` of table `transcore`.`tcs_user_XXX_XXX` trx id 83006107154 lock mode S waiting
	Record lock, heap no 198 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
	 0: len 24; hex 353137373032303230303832383135313630373634373639; asc 517702020082815160764769;; 
	 1: len 6; hex 800806052398; asc     # ;;
	 2: len 8; hex 80000000000914f0; asc         ;;


	*** (2) TRANSACTION:
	TRANSACTION 83006103347, ACTIVE 1 sec inserting
	mysql tables in use 1, locked 1
	7 lock struct(s), heap size 1184, 2 row lock(s), undo log entries 55
	MySQL thread id 9641663, OS thread handle 0x7ef6422cc700, query id 18898932092 172.16.XXX.XXX transcore1 update
	insert into tcs_user_XXX_XXX
			(
			  user_id, product_id, melon_type, due_proc_mode
			  , buy_flag, buy_latest_time, is_attention, custom_sort, attention_time, remark
			  , create_time, modify_time)
		  values
			(
			  '51770202008281516076XXXX', 60XXXX
			  , '0', null
			  , null, now(), null, null, now()
			  , null
			  , now(), now()
			)
	*** (2) HOLDS THE LOCK(S):
	RECORD LOCKS space id 5351 page no 10159 n bits 288 index `idx_uk_tcs_user_fund_XXX` of table `transcore`.`tcs_user_XXX_XXX` trx id 83006103347 lock_mode X locks rec but not gap
	Record lock, heap no 198 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
	 0: len 24; hex 353137373032303230303832383135313630373634373639; asc 517702020082815160764769;;
	 1: len 6; hex 800806052398; asc     # ;;                -- 34460738456
	 2: len 8; hex 80000000000914f0; asc         ;;			 -- 主键ID 595184

	*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
	RECORD LOCKS space id 5351 page no 10159 n bits 320 index `idx_uk_tcs_user_fund_XXX` of table `transcore`.`tcs_user_XXX_XXX` trx id 83006103347 lock_mode X locks gap before rec insert intention waiting
	Record lock, heap no 198 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
	 0: len 24; hex 353137373032303230303832383135313630373634373639; asc 517702020082815160764769;;
	 1: len 6; hex 800806052398; asc     # ;;
	 2: len 8; hex 80000000000914f0; asc         ;;			-- 主键ID 595184	

	*** WE ROLL BACK TRANSACTION (1)


	-- 并发操作二级唯一索引 idx_uk_tcs_user_fund_XXX  导致的死锁
	-- 事务隔离级别为RR



2. 根据死锁日志分析加锁规则
	
	-- session B 还有1个SQL语句，需要解析binlog来看是哪个SQL语句
	
	session A(83006107154)      session B(83006103347)


	insert into tcs_user_XXX_XXX
	(
	  user_id, product_id, melon_type, due_proc_mode
	  , buy_flag, buy_latest_time, is_attention, custom_sort, attention_time, remark
	  , create_time, modify_time)
	values
	(
	  '51770202008281XXXX', 8101XXXX
	  , '1', null
	  , null, now(), null, null, now()
	  , null
	  , now(), now()
	)

		 
							  insert into tcs_user_XXX_XXX
								(
								  user_id, product_id, melon_type, due_proc_mode
								  , buy_flag, buy_latest_time, is_attention, custom_sort, attention_time, remark
								  , create_time, modify_time)
							  values
								(
								  '51770202008281516076XXXX', 60XXXX
								  , '0', null
								  , null, now(), null, null, now()
								  , null
								  , now(), now()
								)
								
							
							持有的锁：
								unique key lock: idx_uk_tcs_user_fund_XXX: (a='517702020082815160764769', b=34460738456) 的X锁
								-- 正确

	持有的锁			
		unique key lock: idx_uk_tcs_user_fund_XXX: (a='517702020082815160764769', b=34460738456) 的 gap lock 
		-- 正确	
			
							在等待的锁：
								想要申请 unique key lock: idx_uk_tcs_user_fund_XXX: (a='517702020082815160764769', b=34460738456) 的意向插入锁
								但是被阻塞
								(意向插入锁被gap lock阻塞)
								-- 正确	
	在等待的锁：
		
		想要申请 unique key lock: idx_uk_tcs_user_fund_XXX: (a='517702020082815160764769', b=34460738456) 的共享锁
		但是被阻塞
		-- 正确					
							
	
	next-key lock：分两阶段加锁，先加 gap lock，再加 record lock.	


3. 死锁模拟
	-- 我是在 8.0.18版本下做的验证
	
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
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME                   | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+---------------+-------------+--------------+
		| 140640974727784:1072:140640851653288   |                 53581 |        63 | deadlock    | NULL                         | TABLE     | IX            | GRANTED     | NULL         |
		| 140640974727784:15:5:5:140640851650248 |                 53581 |        63 | deadlock    | idx_uk_tcs_user_fund_info_up | RECORD    | S             | WAITING     | 'a', '4', 39 |
		-- 被 (col1='a', col2=4) 的共享锁阻塞
		| 140640974728656:1072:140640851659240   |                 53580 |        62 | deadlock    | NULL                         | TABLE     | IX            | GRANTED     | NULL         |
		| 140640974728656:15:5:5:140640851656312 |                 53580 |        63 | deadlock    | idx_uk_tcs_user_fund_info_up | RECORD    | X,REC_NOT_GAP | GRANTED     | 'a', '4', 39 |
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+---------------+-------------+--------------+
		4 rows in set (0.00 sec)

	T2
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+------------------------+-------------+--------------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME                   | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA    |
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+------------------------+-------------+--------------+
		| 140640974728656:1072:140640851659240   |                 53580 |        62 | deadlock    | NULL                         | TABLE     | IX                     | GRANTED     | NULL         |
		| 140640974728656:15:5:5:140640851656312 |                 53580 |        63 | deadlock    | idx_uk_tcs_user_fund_info_up | RECORD    | X,REC_NOT_GAP          | GRANTED     | 'a', '4', 39 |
		| 140640974728656:15:5:5:140640851656656 |                 53580 |        62 | deadlock    | idx_uk_tcs_user_fund_info_up | RECORD    | X,GAP,INSERT_INTENTION | GRANTED     | 'a', '4', 39 |
		+----------------------------------------+-----------------------+-----------+-------------+------------------------------+-----------+------------------------+-------------+--------------+
		3 rows in set (0.00 sec)


	------------------------
	LATEST DETECTED DEADLOCK
	------------------------
	2021-09-03 16:30:57 0x7fe8e6775700
	*** (1) TRANSACTION:
	TRANSACTION 53581, ACTIVE 11 sec inserting
	mysql tables in use 1, locked 1
	LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
	MySQL thread id 13, OS thread handle 140638167922432, query id 47 localhost root update
	insert into deadlock (col1,col2) values ('a','4')

	*** (1) HOLDS THE LOCK(S):
	RECORD LOCKS space id 15 page no 5 n bits 72 index idx_uk_tcs_user_fund_info_up of table `sbtest`.`deadlock` trx id 53581 lock mode S waiting
	Record lock, heap no 5 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
	 0: len 1; hex 61; asc a;;
	 1: len 1; hex 34; asc 4;;
	 2: len 8; hex 8000000000000027; asc        ;;


	*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
	RECORD LOCKS space id 15 page no 5 n bits 72 index idx_uk_tcs_user_fund_info_up of table `sbtest`.`deadlock` trx id 53581 lock mode S waiting
	Record lock, heap no 5 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
	 0: len 1; hex 61; asc a;;
	 1: len 1; hex 34; asc 4;;
	 2: len 8; hex 8000000000000027; asc        ;;


	*** (2) TRANSACTION:
	TRANSACTION 53580, ACTIVE 16 sec inserting
	mysql tables in use 1, locked 1
	LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
	MySQL thread id 12, OS thread handle 140637821183744, query id 49 localhost root update
	insert into deadlock (col1,col2) values ('a','3')

	*** (2) HOLDS THE LOCK(S):
	RECORD LOCKS space id 15 page no 5 n bits 72 index idx_uk_tcs_user_fund_info_up of table `sbtest`.`deadlock` trx id 53580 lock_mode X locks rec but not gap
	Record lock, heap no 5 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
	 0: len 1; hex 61; asc a;;
	 1: len 1; hex 34; asc 4;;
	 2: len 8; hex 8000000000000027; asc        ;;


	*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
	RECORD LOCKS space id 15 page no 5 n bits 72 index idx_uk_tcs_user_fund_info_up of table `sbtest`.`deadlock` trx id 53580 lock_mode X locks gap before rec insert intention waiting
	Record lock, heap no 5 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
	 0: len 1; hex 61; asc a;;
	 1: len 1; hex 34; asc 4;;
	 2: len 8; hex 8000000000000027; asc        ;;

	*** WE ROLL BACK TRANSACTION (1)


4. 解决/优化办法
		
	此类insert，需要通过去除并发或者去除唯一索引去解决，核心思想就是不要触发唯一约束冲突。
	
	
	
