

1. 表结构
CREATE TABLE `course_watch_time_s` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL DEFAULT '0' COMMENT '课程id',
  `sid` int(11) NOT NULL DEFAULT '0' COMMENT '小课sid',
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户uid',
  `watch_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累计的观看（观看直播&回放）时长',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sid` (`sid`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=96501 DEFAULT CHARSET=utf8mb4 COMMENT='学员观看时长（小课）'



2. 根据死锁分析日志
	事务一(TRANSACTION 51049366)的信息：
	
		在等待的锁信息: -- WAITING FOR THIS LOCK TO BE GRANTED 部分
	
			RECORD LOCKS space id 89 page no 249 n bits 704 index sid of table `live_data_report`.`course_watch_time_s` trx id 51049366 lock_mode X locks gap before rec insert intention waiting
				
				index sid of table `live_data_report`.`course_watch_time_s` ：表示这个语句被锁住是因为表 course_watch_time_st 唯一索引sid上的某个锁。
				insert intention ：表示当前线程准备插入一个记录，这是一个插入意向锁, 可以认为它就是这个插入动作本身
				gap before res：  表示这是一个间隙锁，而不是记录锁
				
				说明事务一(TRANSACTION 51049367)的insert语句被表 course_watch_time_st 唯一索引sid上的间隙锁锁住。
			
			 0: len 4; hex 80001451; asc    Q;;                     -- 把1451 从16进制转换为10进制, 得到 5201, 对应 sid 字段
			 1: len 8; hex 800000000000cbc2; asc         ;;         -- 把cbc2 从16进制转换为10进制, 得到 52162, 对应 uid 字段
			 2: len 8; hex 0000000000013fca; asc       ? ;;         -- 把cbc2 从16进制转换为10进制, 得到 81866, 对应 id 字段
			 
			 
		持有的锁：
			--根据事务二(TRANSACTION 51049367)在等待的锁信息分析出来
				
			持有二级唯一索引的锁
			
			
	事务二(TRANSACTION 51049367)的信息：
		持有的锁： -- HOLDS THE LOCK(S)部分
		
		持有的锁信息：
			index sid of table `live_data_report`.`course_watch_time_s` trx id 51049367 lock_mode X locks gap before rec
				index sid of table `live_data_report`.`course_watch_time_s`  -- 持有course_watch_time_s表唯一索引sid上面的锁
				lock_mode X locks gap before rec  							 --持有锁的类型为间隙锁
			

			Record lock, heap no 538 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
			0: len 4; hex 80001451; asc    Q;;                 -- 把1451 从16进制转换为10进制, 得到 5201,  对应 sid 字段
			1: len 8; hex 800000000000cbc2; asc         ;;     -- 把cbc2 从16进制转换为10进制, 得到 52162, 对应 uid 字段
			2: len 8; hex 0000000000013fca; asc       ? ;;     -- 把cbc2 从16进制转换为10进制, 得到 81866，对应 id 字段
			
			
						
		在等待的锁信息:
			RECORD LOCKS space id 89 page no 444 n bits 408 index sid of table `live_data_report`.`course_watch_time_s` trx id 51049367 lock_mode X locks gap before rec insert intention waiting
				index sid of table `live_data_report`.`course_watch_time_s` ：表示这个语句被锁住是因为表 course_watch_time_st 唯一索引sid上的某个锁。
				insert intention ：表示当前线程准备插入一个记录，这是一个插入意向锁, 可以认为它就是这个插入动作本身
				gap before res：  表示这是一个间隙锁，而不是记录锁
				
				说明事务二(TRANSACTION 51049367)的insert语句被表 course_watch_time_st 唯一索引sid上的间隙锁锁住。

			
			Record lock, heap no 108 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
			0: len 4; hex 80000942; asc    B;;                  -- 把942 从16进制转换为10进制, 得到 2370, 对应 sid 字段              
			1: len 8; hex 800000000013fb1b; asc         ;;      -- 把13fb1b 从16进制转换为10进制, 得到 1309467
			2: len 8; hex 0000000000011ad1; asc         ;;      -- 把11ad1 从16进制转换为10进制, 得到 72401     



死锁演示：

	session A                     session B

	start transaction;    
								  start transaction;
											
	INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(1, 2370, 1309467, 162);
								  
								  INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(1, 5201, 52162, 162);
								  
								  INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(1, 2370, 1309467, 162);
								  
								  
	INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(1, 5201, 52162, 162);
	ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
		

	对应的死锁日志
		2021-01-14T06:44:17.979605Z 960 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2021-01-14T06:44:17.979620Z 960 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 2965320, ACTIVE 19 sec inserting
		mysql tables in use 1, locked 1
		LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
		MySQL thread id 249, OS thread handle 139882677090048, query id 8525 localhost root update
		INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(1, 2370, 1309467, 162)
		2021-01-14T06:44:17.979653Z 960 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 173 page no 4 n bits 72 index sid of table `test_db`.`course_watch_time_s` trx id 2965320 lock mode S waiting
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
		 0: len 4; hex 80000942; asc    B;;					-- 80000942 跟你死锁案例中的值一样
		 1: len 8; hex 800000000013fb1b; asc         ;;     -- 800000000013fb1b 跟你死锁案例中的值一样
		 2: len 8; hex 0000000000000001; asc         ;;     -- 对应主键字段的值

		2021-01-14T06:44:17.979789Z 960 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 2965319, ACTIVE 33 sec inserting
		mysql tables in use 1, locked 1
		3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
		MySQL thread id 960, OS thread handle 139882393396992, query id 8526 localhost root update
		INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(1, 5201, 52162, 162)
		2021-01-14T06:44:17.979816Z 960 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		RECORD LOCKS space id 173 page no 4 n bits 72 index sid of table `test_db`.`course_watch_time_s` trx id 2965319 lock_mode X locks rec but not gap
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
		 0: len 4; hex 80000942; asc    B;;                 -- 80000942 跟你死锁案例中的值一样
		 1: len 8; hex 800000000013fb1b; asc         ;;     -- 800000000013fb1b 跟你死锁案例中的值一样
		 2: len 8; hex 0000000000000001; asc         ;;     -- 对应主键字段的值

		2021-01-14T06:44:17.979943Z 960 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 173 page no 4 n bits 72 index sid of table `test_db`.`course_watch_time_s` trx id 2965319 lock mode S waiting
		Record lock, heap no 3 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
		 0: len 4; hex 80001451; asc    Q;;                 -- 80001451 跟你死锁案例中的值一样
		 1: len 8; hex 800000000000cbc2; asc         ;;     -- 800000000000cbc2 跟你死锁案例中的值一样
		 2: len 8; hex 0000000000000002; asc         ;;     -- 对应主键字段的值

		2021-01-14T06:44:17.980070Z 960 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)
		
		-- 你死锁日志中是回滚 TRANSACTION (1)， 我这里是回滚 TRANSACTION (2)，不影响分析，可以理解为我个例子的事务2权重小。
		
	
		
		



	
CREATE TABLE `course_watch_time_s` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL DEFAULT '0' COMMENT '课程id',
  `sid` int(11) NOT NULL DEFAULT '0' COMMENT '小课sid',
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户uid',
  `watch_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累计的观看（观看直播&回放）时长',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sid` (`sid`,`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='学员观看时长（小课）'





