

0. 对语句执行的几个时间进行一个说明：

	Query_time:	语句总执行时间

	Lock_time:	语句锁消耗时间

	Exec_time:	语句实际执行时间（评判标准）

	语句实际执行时间=语句总执行时间-语句锁消耗时间
	
	

1. 初始化表结构和数据
	
	DROP TABLE IF EXISTS `t_20210901`;
	CREATE TABLE `t_20210901` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_age` (`age`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;

	
	DROP PROCEDURE IF EXISTS `idata_20210901`;
	DELIMITER ;;
	create procedure idata_20210901()
	begin
	  declare i int;
	  set i=1;
	  while(i<=50000)do
		insert into t_20210901(name, age, ismale) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)));
		set i=i+1;
	  end while;
	end;;
	delimiter ;
		
	call idata_20210901();
	


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------



2. 验证lock_time对慢日志的影响
	
2.1 实验1
	
	mysql> show global variables like '%long_query_time%';
	+-----------------+----------+
	| Variable_name   | Value    |
	+-----------------+----------+
	| long_query_time | 0.500000 |
	+-----------------+----------+
	1 row in set (0.01 sec)

	mysql> show global variables like '%log_queries_not_using_indexes%';
	+-------------------------------+-------+
	| Variable_name                 | Value |
	+-------------------------------+-------+
	| log_queries_not_using_indexes | OFF   |
	+-------------------------------+-------+
	1 row in set (0.01 sec)


	mysql> desc select * from t_20210901 where age=10;
	+----+-------------+------------+------------+------+---------------+---------+---------+-------+------+----------+-------+
	| id | select_type | table      | partitions | type | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
	+----+-------------+------------+------------+------+---------------+---------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t_20210901 | NULL       | ref  | idx_age       | idx_age | 4       | const |    1 |   100.00 | NULL  |
	+----+-------------+------------+------------+------+---------------+---------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)

	mysql> select * from t_20210901 where age=10;
	+----+------------+-----+--------+-------------------------+
	| id | name       | age | ismale | createTime              |
	+----+------------+-----+--------+-------------------------+
	| 10 | b4c7f4c88b |  10 |     98 | 2021-09-01 15:55:21.515 |
	+----+------------+-----+--------+-------------------------+
	1 row in set (0.00 sec)


	session A 					session B


	lock table t_20210901 write;

								select * from t_20210901 where age=10;
								(Blocked)
	unlock tables;							
								+----+------------+-----+--------+-------------------------+
								| id | name       | age | ismale | createTime              |
								+----+------------+-----+--------+-------------------------+
								| 10 | b4c7f4c88b |  10 |     98 | 2021-09-01 15:55:21.515 |
								+----+------------+-----+--------+-------------------------+
								1 row in set (6 min 15.93 sec)


	-- 慢日志没有输出。
	
	处于Blocked 的状态
		mysql> show processlist;
		+----+-----------------+-----------+---------+---------+------+---------------------------------+---------------------------------------+
		| Id | User            | Host      | db      | Command | Time | State                           | Info                                  |
		+----+-----------------+-----------+---------+---------+------+---------------------------------+---------------------------------------+
		|  1 | event_scheduler | localhost | NULL    | Daemon  | 1332 | Waiting on empty queue          | NULL                                  |
		|  7 | root            | localhost | test_db | Sleep   |   28 |                                 | NULL                                  |
		|  8 | root            | localhost | test_db | Query   |   25 | Waiting for table metadata lock | select * from t_20210901 where age=10 |
		| 18 | root            | localhost | NULL    | Query   |    0 | starting                        | show processlist                      |
		+----+-----------------+-----------+---------+---------+------+---------------------------------+---------------------------------------+
		4 rows in set (0.00 sec)

		
---------------------------------------------------------------------------

	
2.2 实验2
	
	mysql> select * from t_20210901 limit 10000;
	10000 rows in set (0.18 sec)

	set global long_query_time=0.1;

	mysql> show global variables like '%long_query_time%';
	+-----------------+----------+
	| Variable_name   | Value    |
	+-----------------+----------+
	| long_query_time | 0.100000 |
	+-----------------+----------+
	1 row in set (0.01 sec)


	mysql> show global variables like '%log_queries_not_using_indexes%';
	+-------------------------------+-------+
	| Variable_name                 | Value |
	+-------------------------------+-------+
	| log_queries_not_using_indexes | OFF   |
	+-------------------------------+-------+
	1 row in set (0.01 sec)
	

	session A 					session B


	lock table t_20210901 write;

								select * from t_20210901 limit 10000;
								(Blocked)
	unlock tables;			
								10000 rows in set (2.83 sec)
	
	-- 慢日志有输出，如下
		# Time: 2021-09-01T16:17:14.751394+08:00
		# User@Host: root[root] @ localhost []  Id:    19
		# Query_time: 2.826413  Lock_time: 2.656548 Rows_sent: 10000  Rows_examined: 10000
		SET timestamp=1630484234;
		select * from t_20210901 limit 10000;

	
2.3 小结
	1. query_time  包含 lock_time
	2. query_time - lock_time 的值大于 long_query_time参数的值，则会记录慢日志。
	3. 所以有时候数据库有些查询慢是锁等待造成的，而这种情况是不会记录在slow log里的。
	
----------------------------------------------------------------------------------------------------------------------------------------

3. 相关参考

	http://blog.itpub.net/7728585/viewspace-2155643/	MySQL慢查询记录原理和内容解析

	https://mp.weixin.qq.com/s/TNX3jHMCybbBAmmjGp-xSQ   MySQL源码解析之slow log实现机制
	
	
	