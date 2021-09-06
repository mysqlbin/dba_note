
1. 表结构
2. 根据死锁分析日志
3. 形成死锁的加锁次序如下
4. 优化/避免本案例死锁的方案
5. 业务场景



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
			 2: len 8; hex 0000000000013fca; asc       ? ;;         -- 把13fca 从16进制转换为10进制, 得到 81866, 对应 id 字段
			 
			 
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
			2: len 8; hex 0000000000013fca; asc       ? ;;     -- 把13fca 从16进制转换为10进制, 得到 81866, 对应 id 字段
			
			
						
		在等待的锁信息:
			RECORD LOCKS space id 89 page no 444 n bits 408 index sid of table `live_data_report`.`course_watch_time_s` trx id 51049367 lock_mode X locks gap before rec insert intention waiting
				index sid of table `live_data_report`.`course_watch_time_s` ：表示这个语句被锁住是因为表 course_watch_time_st 唯一索引sid上的某个锁。
				insert intention ：表示当前线程准备插入一个记录，这是一个插入意向锁, 可以认为它就是这个插入动作本身
				gap before res：  表示这是一个间隙锁，而不是记录锁
				
				说明事务二(TRANSACTION 51049367)的insert语句被表 course_watch_time_st 唯一索引sid上的间隙锁锁住。

			
			Record lock, heap no 108 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
			0: len 4; hex 80000942; asc    B;;                  -- 把942 从16进制转换为10进制, 得到 2370, 对应 sid 字段              
			1: len 8; hex 800000000013fb1b; asc         ;;      -- 把13fb1b 从16进制转换为10进制, 得到 1309467, 对应 uid 字段
			2: len 8; hex 0000000000011ad1; asc         ;;      -- 把11ad1 从16进制转换为10进制, 得到 72401, 对应 id 字段    


3. 形成死锁的加锁次序如下

	时间点   事务一(TRANSACTION 51049366)       							事务二(TRANSACTION 51049367)
	
	T1		持有的锁： 持有course_watch_time_s表唯一索引sid上面的锁:  其中 sid=2370, uid=1309467
	
	T2                                                                      持有的锁： 持有course_watch_time_s表唯一索引sid上面的锁:  其中 sid=5201, uid=52162

	T3 		在等待事务二的锁：course_watch_time_s表唯一索引sid上面的锁

	T4                                                                      在等待事务一的锁：course_watch_time_s表唯一索引sid上面的锁
	
	
	
	T3被T2阻塞，T4被T1阻塞，因此锁资源请求形成了环路，进而触发死锁检测, 因此导致了死锁。
	
	
4. 优化/避免本案例死锁的方案
	
	事务一(TRANSACTION 51049366)持有的行锁：
		LOCK WAIT 93 lock struct(s), heap size 24784, 6646 row lock(s), undo log entries 3620
		-- 持有6646个行锁
		
	事务二(TRANSACTION 51049367)持有的行锁：
		206 lock struct(s), heap size 41168, 17608 row lock(s), undo log entries 9775
		-- 持有17608个行锁
	
	一个SQL语句不要插入太多行记录。
	
	
5. 业务场景

	a901-姜浩-北京  15:31:00
	用sqoop往MySQL里倒入的

	a901-姜浩-北京  15:31:09
	导入前先truncate

	

	Bin  15:32:17
	哦哦， 这个我不是很熟悉，有1个方案可以完成避免死锁，串行执行倒入的语句

	Bin  15:33:10
	根据你说的场景，主要是倒入数据的时候，是并发导入的，导致数据串行，从而引发死锁

