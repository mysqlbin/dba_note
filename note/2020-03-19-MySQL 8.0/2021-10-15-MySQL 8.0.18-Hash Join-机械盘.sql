
0. 环境
1. 5.7 版本
	1.1 被驱动表没有索引-使用的是BNL算法
	1.2 被驱动表有索引-使用的是NLJ算法
	
2. MySQL 8.0.18
	2.1 被驱动表没有索引-使用的是Hash join算法
	2.2 被驱动表有索引-使用的是NLJ算法

3. 执行耗时对比
4. 思考 
5. 相关参考
6. 小结


0. 环境
	
	在虚拟机中自建MySQL做测试

1. 5.7 版本

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)
	
	
	
1.1 被驱动表没有索引-使用的是BNL算法

	初始化表结构和数据
			
		create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

		use sbtest;

		create table t1(id int primary key, a int, b int, index(a));
		create table t2 like t1;
		delimiter ;;
		create procedure idata()
		begin
		  declare i int;
		  set i=1;
		  while(i<=1000)do
			insert into t1 values(i, 1001-i, i);
			set i=i+1;
		  end while;
		  
		  set i=1;
		  while(i<=1000000)do
			insert into t2 values(i, i, i);
			set i=i+1;
		  end while;

		end;;
		delimiter ;
		call idata();
		


	
	查看SQL的执行计划

		mysql> explain  select * from t1 join t2 on (t1.b=t2.b) where t2.b>=1 and t2.b<=2000;
		+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+----------------------------------------------------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows   | filtered | Extra                                              |
		+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+----------------------------------------------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   1000 |   100.00 | Using where                                        |
		|  1 | SIMPLE      | t2    | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 998222 |     1.11 | Using where; Using join buffer (Block Nested Loop) |
		+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+----------------------------------------------------+
		2 rows in set, 1 warning (0.01 sec)

		
	SQL的执行时间：
		
		
		1000 rows in set (4 min 24.49 sec)
	



1.2 被驱动表有索引-使用的是NLJ算法
	
	初始化表结构和数据

		create  database sbtest_02 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

		use sbtest_02;

		create table t1(id int primary key, a int, b int, index(a));
		create table t2 like t1;
		delimiter ;;
		create procedure idata()
		begin
		  declare i int;
		  set i=1;
		  while(i<=1000)do
			insert into t1 values(i, 1001-i, i);
			set i=i+1;
		  end while;
		  
		  set i=1;
		  while(i<=1000000)do
			insert into t2 values(i, i, i);
			set i=i+1;
		  end while;

		end;;
		delimiter ;
		call idata();

		alter table t2 add index idx_b(`b`);
				
		
	查看SQL的执行计划

		mysql> explain  select * from t1 join t2 on (t1.b=t2.b) where t2.b>=1 and t2.b<=2000;
		+----+-------------+-------+------------+------+---------------+-------+---------+----------------+------+----------+-------------+
		| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref            | rows | filtered | Extra       |
		+----+-------------+-------+------------+------+---------------+-------+---------+----------------+------+----------+-------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL  | NULL    | NULL           | 1000 |   100.00 | Using where |
		|  1 | SIMPLE      | t2    | NULL       | ref  | idx_b         | idx_b | 5       | sbtest_02.t1.b |    1 |   100.00 | NULL        |
		+----+-------------+-------+------------+------+---------------+-------+---------+----------------+------+----------+-------------+
		2 rows in set, 1 warning (0.01 sec)


	SQL的执行时间：

		1000 rows in set (0.58 sec)


2. MySQL 8.0.18
	
	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)
	

2.1 被驱动表没有索引-使用的是Hash join算法



	初始化表结构和数据

		create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

		use sbtest;

		create table t1(id int primary key, a int, b int, index(a));
		create table t2 like t1;
		delimiter ;;
		create procedure idata()
		begin
		  declare i int;
		  set i=1;
		  while(i<=1000)do
			insert into t1 values(i, 1001-i, i);
			set i=i+1;
		  end while;
		  
		  set i=1;
		  while(i<=1000000)do
			insert into t2 values(i, i, i);
			set i=i+1;
		  end while;

		end;;
		delimiter ;
		call idata();
			
	

	查看SQL的执行计划
		
		root@mysqldb 18:24:  [sbtest]> EXPLAIN FORMAT=TREE select * from t1 join t2 on (t1.b=t2.b) where t2.b>=1 and t2.b<=2000;
		+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| EXPLAIN                                                                                                                                                                                                                                                                 |
		+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| -> Inner hash join (t2.b = t1.b)  (cost=99954469.69 rows=11093870)
			-> Table scan on t2  (cost=90.68 rows=998648)
			-> Hash
				-> Filter: ((t1.b >= 1) and (t1.b <= 2000))  (cost=101.00 rows=1000)
					-> Table scan on t1  (cost=101.00 rows=1000)
		 |
		+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.45 sec)


	EXPLAIN ANALYZE

		使用它可以估算成本、查看实际执行的统计数据，包括第一条记录的返回时间，全部记录返回时间，返回记录的数量以及循环数量。
		此外，EXPLAIN还将可以使用新的输出格式，树状输出。
			
		root@mysqldb 18:25:  [sbtest]> EXPLAIN ANALYZE select * from t1 join t2 on (t1.b=t2.b) where t2.b>=1 and t2.b<=2000;
		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| EXPLAIN                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| -> Inner hash join (t2.b = t1.b)  (cost=99954469.69 rows=11093870) (actual time=1.721..850.610 rows=1000 loops=1)
			-> Table scan on t2  (cost=90.68 rows=998648) (actual time=0.027..493.649 rows=1000000 loops=1)
			-> Hash
				-> Filter: ((t1.b >= 1) and (t1.b <= 2000))  (cost=101.00 rows=1000) (actual time=0.066..1.194 rows=1000 loops=1)
					-> Table scan on t1  (cost=101.00 rows=1000) (actual time=0.063..0.524 rows=1000 loops=1)
		 |
		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.85 sec)

	
	
	SQL的执行时间
		
		1000 rows in set (0.42 sec)




2.2 被驱动表有索引-使用的是NLJ算法

	初始化表结构和数据

		create  database sbtest_02 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

		use sbtest_02;

		create table t1(id int primary key, a int, b int, index(a));
		create table t2 like t1;
		delimiter ;;
		create procedure idata()
		begin
		  declare i int;
		  set i=1;
		  while(i<=1000)do
			insert into t1 values(i, 1001-i, i);
			set i=i+1;
		  end while;
		  
		  set i=1;
		  while(i<=1000000)do
			insert into t2 values(i, i, i);
			set i=i+1;
		  end while;

		end;;
		delimiter ;
		call idata();

		alter table t2 add index idx_b(`b`);


	查看SQL的执行计划

		EXPLAIN  select * from t1 join t2 on (t1.b=t2.b) where t2.b>=1 and t2.b<=2000;
			
		root@mysqldb 18:29:  [sbtest_02]> EXPLAIN  select * from t1 join t2 on (t1.b=t2.b) where t2.b>=1 and t2.b<=2000;
		+----+-------------+-------+------------+------+---------------+-------+---------+----------------+------+----------+-------------+
		| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref            | rows | filtered | Extra       |
		+----+-------------+-------+------------+------+---------------+-------+---------+----------------+------+----------+-------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL  | NULL    | NULL           | 1000 |   100.00 | Using where |
		|  1 | SIMPLE      | t2    | NULL       | ref  | idx_b         | idx_b | 5       | sbtest_02.t1.b |    1 |   100.00 | NULL        |
		+----+-------------+-------+------------+------+---------------+-------+---------+----------------+------+----------+-------------+
		2 rows in set, 1 warning (0.02 sec)


	SQL的执行时间


		1000 rows in set (0.16 sec)



3. 执行耗时对比


				有索引			无索引
	MySQL5.7	0.58s			4 min 24.49 sec
	MySQL8.0	0.16s           0.42s

	

4. 思考
	
	1. 有了Hash Join, 是否还需要NLJ算法
	  答: 需要的. 通过对比可以发现NLJ算法的执行速度比Hash Join的执行速度更快.
		  如果被驱动表是一个大表并且没有索引，那么会造成全表扫描，对磁盘I/O影响很大。
		  

	  
 
5. 相关参考
	
	https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_10054537612828754509%22%7D&n_type=1&p_from=3 深入理解MySQL 8.0 hash join
	
		MySQL 8.0.18 版本增加了一个新的特性hash join，关于hash join，通常其执行过程如下：
			首先基于join操作的一个表，在内存中创建一个对应的hash表，然后再一行一行的读另外一张表，通过计算哈希值，查找内存中的哈希表。
	
	https://mp.weixin.qq.com/s/wnYeAtmFQtR_AsA7gnrGHw   MySQL8的 Hash Join
	 
	https://mp.weixin.qq.com/s/WDHqiJuhZVW6cSYSsUPlFA   MySQL8.0.18 试用Hash Join
	
	https://mp.weixin.qq.com/s/_0ImdUFMVZGTq-NoO9tHpw   MySQL8 的 Hash join 算法
	
	https://mp.weixin.qq.com/s/cS_1JgLm4UKlwWp4cXoc1A   MySQL 8.0之hash join
	
	https://mysqlserverteam.com/hash-join-in-mysql-8/
	
	
	https://mp.weixin.qq.com/s/tbMfRTjTWAHWOJvYYnZ1oA  MySQL 8.0 新特性之Hash Join

	https://dev.mysql.com/doc/refman/8.0/en/hash-joins.html  官方文档
	
	
	

6. 小结

	NLJ算法，不需要全表扫描，查询性能在大多数场景下还是会比Hash join算法快的。
	8.0 的查询性能，对5.7的要牛逼。
	

	
	
	

