


假设表 t 中现在有 10000 条记录，我们设计了三个用户并行的会话。
会话 A 先启动事务并查询一次表的总行数；
会话 B 启动事务，插入一行后记录后，查询表的总行数；
会话 C 先启动一个单独的语句，插入一行记录后，查询表的总行数。
我们假设从上到下是按照时间顺序执行的，同一行语句是在同时刻执行的


table t engine = InnoDB 
	支持事务
	session A                   session B           	 	session C  

	begin;
	select count(*) from t;
															insert into t (插入一行);
								begin; 
								insert into t (插入一行);
	select count(*) from t;		select count(*) from t;  	select count(*) from t; 
	(返回10000)					(返回10002)			        (返回10001)	  



table t engine = MyISAM 
	不支持事务
	session A                   session B           	 	session C  

	select count(*) from t;
															insert into t (插入一行);
								
								insert into t (插入一行);
	select count(*) from t;		select count(*) from t;  	select count(*) from t; 
	(返回10002)					(返回10002)			        (返回10002)	  



小结：
	MyISAM表维护有1个计数器
	InnoDB表没有维护计数器
	原因：这是由于InnoDB表支持事务、支持MVCC决定的，需要根据MVCC判断行记录的可见性，再把可见性的记录做统计。
	刚开始看的不理解，这个不要紧，花点时间去理解就行。
	

计数的办法：
	
	需求：
		有1个页面要显示操作记录的总数，同时还要显示最近操作的 100 条记录。那么，这个页面的逻辑就需要先到 Redis 里面取出计数，再到数据表里面取数据记录。


	1. 用redis保存计数
		新增一行记录redis计数就加1，删除一行记录redis计数就减1
		
		redis计数存在的问题：
			涉及到了MySQL和redis两种数据库，保证不了数据的一致性
			
			
		
			session A          	 	   session B 
															
			insert into t (插入一行);
									   读redis 计数;
									   查询最近的100条记录;
			redis 计数加1;             
							
			查到的 100 行结果里面有最新插入记录，而 Redis 的计数里还没加 1；	
				
			---------------------------------------------------------------
			
			session A          	 	   session B 
															
			redis 计数加1;
									   读redis 计数;
									   查询最近的100条记录;
			insert into t (插入一行);
			
			查到的 100 行结果里面没有最新插入记录，而 Redis 的计数里已经加 1；	
				
	
	2. 用MySQL保存计数
		把计数和插入表记录、删除表记录的操作放在1个事务中;
		
				
		session A          	 	   session B 
		
		begin;
		redis 计数加1;   
									begin;
								   读MySQL 计数;
								   查询最近的100条记录;
		insert into t (插入一行);  
	
		session A 没有提交，对session B不可见，可以保证 查计数和查最近的100条记录保证逻辑上的一致。
		
		
		
不同的 count 用法	
	drop table if exists t_20210423;
	CREATE TABLE `t_20210423` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `name` varchar(10) default null COMMENT 'filed_02',
	  `filed_05` int(10) DEFAULT '5' COMMENT 'filed_05',
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`),
	  KEY `idx_filed_05` (`filed_05`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('2', '2', '2020-07-13 14:23:57', null, '5');
	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('3', '3', '2020-07-13 14:24:00', 'lujianbin', '5');
	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('4', '4', '2020-07-13 14:24:03', 'lujianbin', '5');
	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('5', '5', '2020-07-13 14:24:05', 'lujianbin', '5');
	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('6', '6', '2020-07-13 14:24:08', 'lujianbin', '5');
	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('7', '7', '2020-07-13 14:24:11', 'lujianbin', '5');
	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('8', '1', '2020-07-13 14:41:43', 'lujianbin', '5');
	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('10', '1', '2020-07-13 14:41:43','lujianbin', '5');
	
	
	
	root@mysqldb 12:15:  [test_db]> select * from t_20210423;
	+----+-----+---------------------+-----------+----------+
	| ID | age | tEndTime            | name      | filed_05 |
	+----+-----+---------------------+-----------+----------+
	|  2 |   2 | 2020-07-13 14:23:57 | NULL      |        5 |
	|  3 |   3 | 2020-07-13 14:24:00 | lujianbin |        5 |
	|  4 |   4 | 2020-07-13 14:24:03 | lujianbin |        5 |
	|  5 |   5 | 2020-07-13 14:24:05 | lujianbin |        5 |
	|  6 |   6 | 2020-07-13 14:24:08 | lujianbin |        5 |
	|  7 |   7 | 2020-07-13 14:24:11 | lujianbin |        5 |
	|  8 |   1 | 2020-07-13 14:41:43 | lujianbin |        5 |
	| 10 |   1 | 2020-07-13 14:41:43 | lujianbin |        5 |
	+----+-----+---------------------+-----------+----------+
	8 rows in set (0.00 sec)

	root@mysqldb 12:15:  [test_db]> select count(name) from t_20210423;
	+-------------+
	| count(name) |
	+-------------+
	|           7 |
	+-------------+
	1 row in set (0.00 sec)

	root@mysqldb 12:15:  [test_db]> select count(*) from t_20210423;
	+----------+
	| count(*) |
	+----------+
	|        8 |
	+----------+
	1 row in set (0.00 sec)

	root@mysqldb 12:15:  [test_db]> select count(1) from t_20210423;
	+----------+
	| count(1) |
	+----------+
	|        8 |
	+----------+
	1 row in set (0.00 sec)

	root@mysqldb 12:16:  [test_db]> select count(id) from t_20210423;
	+-----------+
	| count(id) |
	+-----------+
	|         8 |
	+-----------+
	1 row in set (0.00 sec)


插入一行name=''的记录

	---------------------------------------------------------------------------------------
	
	INSERT INTO `test_db`.`t_20210423` (`ID`, `age`, `tEndTime`, `name`, `filed_05`) VALUES ('11', '1', '2020-07-13 14:41:43','', '5');
	
		
	root@mysqldb 14:16:  [test_db]> select count(name) from t_20210423;
	+-------------+
	| count(name) |
	+-------------+
	|           8 |
	+-------------+
	1 row in set (0.00 sec)

	root@mysqldb 14:18:  [test_db]> select count(*) from t_20210423;
	+----------+
	| count(*) |
	+----------+
	|        9 |
	+----------+
	1 row in set (0.00 sec)

	root@mysqldb 14:18:  [test_db]> select count(1) from t_20210423;
	+----------+
	| count(1) |
	+----------+
	|        9 |
	+----------+
	1 row in set (0.00 sec)

	root@mysqldb 14:18:  [test_db]> select count(id) from t_20210423;
	+-----------+
	| count(id) |
	+-----------+
	|         9 |
	+-----------+
	1 row in set (0.00 sec)
