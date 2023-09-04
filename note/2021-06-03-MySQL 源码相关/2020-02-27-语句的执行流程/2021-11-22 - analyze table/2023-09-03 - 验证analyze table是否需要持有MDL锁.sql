
1. MySQL 版本
2. 初始化表结构、数据
3. 验证
	3.1 先select再analyze
	3.2 先insert再analyze
	3.3 先sleep再analyze
	
4. 小结


1. MySQL 版本
	MySQL [archery]> select version();
	+---------------+
	| version()     |
	+---------------+
	| 5.7.32-35-log |
	+---------------+
	1 row in set (0.00 sec)

2. 初始化表结构、数据
	drop table  if exists t;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	insert into t(c,d) values(1,1);
	insert into t(c,d) values(2,2);
	insert into t(c,d) values(3,3);
	insert into t(c,d) values(4,4);
	insert into t(c,d) values(5,5);
	insert into t(c,d) values(6,6);
	insert into t(c,d) values(7,7);
	insert into t(c,d) values(8,8);
	insert into t(c,d) values(9,9);
	insert into t(c,d) values(10,10);
	insert into t(c,d) values(11,11);
	insert into t(c,d) values(12,12);
	insert into t(c,d) values(13,13);
	insert into t(c,d) values(14,14);
	insert into t(c,d) values(15,15);

3. 验证
	
	3.1 先select再analyze

		事务1                    事务2
		begin; 						
		select * from t; 		 analyze table t; 
								+-----------+---------+----------+----------+
								| Table     | Op      | Msg_type | Msg_text |
								+-----------+---------+----------+----------+
								| archery.t | analyze | status   | OK       |
								+-----------+---------+----------+----------+
								1 row in set (0.00 sec)
								
								

	3.2 先insert再analyze
		事务1                    事务2
		begin; 
		insert into t(c,d) values(16,16);		

								MySQL [archery]> analyze table t; 
								+-----------+---------+----------+----------+
								| Table     | Op      | Msg_type | Msg_text |
								+-----------+---------+----------+----------+
								| archery.t | analyze | status   | OK       |
								+-----------+---------+----------+----------+
								1 row in set (0.00 sec)

	
	3.3 先sleep再analyze
		事务1
		select sleep(1) from t;
	
									MySQL [archery]> analyze table t; 
									+-----------+---------+----------+----------+
									| Table     | Op      | Msg_type | Msg_text |
									+-----------+---------+----------+----------+
									| archery.t | analyze | status   | OK       |
									+-----------+---------+----------+----------+
									1 row in set (0.00 sec)

		+----------+
		| sleep(1) |
		+----------+
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		|        0 |
		+----------+
		15 rows in set (15.00 sec)



4. 小结
	
	不需要持有MDL锁。




https://mp.weixin.qq.com/s/1MsyxhtG6Zk3Q9gIV2QVbA   细说ANALYZE TABLE
