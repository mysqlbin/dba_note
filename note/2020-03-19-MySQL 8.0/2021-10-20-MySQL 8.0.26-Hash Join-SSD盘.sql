
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
	
	
	CPU		物理内存	数据库内存缓冲池大小	数据盘大小	剩余空间大小
	4核		16GB内存	8GB						100GB		70GB
	是否是SSD盘		文件系统	MySQL 版本		部署MySQL所在的设备
	是				ext4		5.7.26			/dev/vdb1

	顺序读IOPS	顺序写IOPS	随机读/写的IOPS
	4800		1000		750/775

	
	mysql> show global variables like '%join_buffer_size%';
	+------------------+---------+
	| Variable_name    | Value   |
	+------------------+---------+
	| join_buffer_size | 4194304 |
	+------------------+---------+
	1 row in set (0.01 sec)

	
	mysql> show global variables like '%tmp_table_siz%';
	+----------------+----------+
	| Variable_name  | Value    |
	+----------------+----------+
	| tmp_table_size | 16777216 |
	+----------------+----------+
	1 row in set (0.00 sec)


1. 5.7 版本

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.26-log |
	+------------+
	1 row in set (0.00 sec)


1.1 被驱动表没有索引-使用的是BNL算法

	初始化表结构和数据
					
		create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

		use sbtest;
		drop table t1;
		drop table t2;
		drop procedure idata;
		create table t1(id int primary key, a int, b int, index(b));
		create table t2 like t1;
		delimiter ;;
		create procedure idata()
		begin
		  declare i int;
		  set i=1;
		  start transaction;
		  while(i<=100000)do
			insert into t1 values(i, 10001-i, i);
			set i=i+1;
		  end while;
		  commit;
		  set i=1;
		  start transaction;
		  while(i<=2000000)do
			insert into t2 values(i, i, i);
			set i=i+1;
		  end while;
		  commit;
		  
		end;;
		delimiter ;
		call idata();
		alter table t2 drop index b;

	
	查看SQL的执行计划
		
		mysql> explain select * from t1 straight_join  t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.b>=1 and t2.b<=5000);
		+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+----------------------------------------------------+
		| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows    | filtered | Extra                                              |
		+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+----------------------------------------------------+
		|  1 | SIMPLE      | t1    | NULL       | range | b             | b    | 5       | NULL |    5000 |   100.00 | Using index condition                              |
		|  1 | SIMPLE      | t2    | NULL       | ALL   | NULL          | NULL | NULL    | NULL | 1996444 |     1.11 | Using where; Using join buffer (Block Nested Loop) |
		+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+----------------------------------------------------+
		2 rows in set, 1 warning (0.00 sec)
		
		select 5000*2000000  = 10000000000 = 100亿次判断
		每1行记录要判断5000次，200万行记录就需要判断 100亿次，这效率肯定低下了。

	SQL的执行时间：
		
		第一次测试
		select * from t1 straight_join  t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.b>=1 and t2.b<=5000);
		5000 rows in set (10 min 22.98 sec)
			
		第二次测试
		select * from t1 straight_join  t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.b>=1 and t2.b<=5000);
		5000 rows in set (10 min 49.18 sec)




1.2 被驱动表有索引-使用的是NLJ算法
	
	初始化表结构和数据

		create  database sbtest_02 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

use sbtest_02;
drop table t1;
drop table t2;
drop procedure idata;
create table t1(id int primary key, a int, b int, index(b));
create table t2 like t1;
delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  start transaction;
  while(i<=100000)do
	insert into t1 values(i, 10001-i, i);
	set i=i+1;
  end while;
  commit;
  set i=1;
  start transaction;
  while(i<=2000000)do
	insert into t2 values(i, i, i);
	set i=i+1;
  end while;
  commit;
  
end;;
delimiter ;
call idata();

	
	查看SQL的执行计划
			
		mysql> explain select * from t1 straight_join  t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.b>=1 and t2.b<=5000);
		+----+-------------+-------+------------+-------+---------------+-------+---------+----------------+------+----------+-----------------------+
		| id | select_type | table | partitions | type  | possible_keys | key   | key_len | ref            | rows | filtered | Extra                 |
		+----+-------------+-------+------------+-------+---------------+-------+---------+----------------+------+----------+-----------------------+
		|  1 | SIMPLE      | t1    | NULL       | range | b             | b     | 5       | NULL           | 5000 |   100.00 | Using index condition |
		|  1 | SIMPLE      | t2    | NULL       | ref   | b,idx_b       | idx_b | 5       | sbtest_02.t1.b |    1 |   100.00 | NULL                  |
		+----+-------------+-------+------------+-------+---------------+-------+---------+----------------+------+----------+-----------------------+
		2 rows in set, 1 warning (0.00 sec)


	SQL的执行时间：
		第一次测试	
		select * from t1 straight_join  t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.b>=1 and t2.b<=5000);
		5000 rows in set (0.09 sec)
		
		第二次测试
		5000 rows in set (0.09 sec)

		第三次测试
		5000 rows in set (0.10 sec)
		
		
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
drop table t1;
drop table t2;
drop procedure idata;
create table t1(id int primary key, a int, b int, index(b));
create table t2 like t1;
delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  start transaction;
  while(i<=100000)do
	insert into t1 values(i, 10001-i, i);
	set i=i+1;
  end while;
  commit;
  set i=1;
  start transaction;
  while(i<=2000000)do
	insert into t2 values(i, i, i);
	set i=i+1;
  end while;
  commit;
  
end;;
delimiter ;
call idata();
alter table t2 drop index b;
			
	

	查看SQL的执行计划
		
		mysql> explain FORMAT=TREE select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.b>=1 and t2.b<=5000);
		+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| EXPLAIN                                                                                                                                                                                                                                                                                             |
		+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| -> Inner hash join (t2.b = t1.b)  (cost=998405532.38 rows=110891376)
			-> Table scan on t2  (cost=36.70 rows=1996444)
			-> Hash
				-> Index range scan on t1 using b, with index condition: ((t1.b >= 1) and (t1.b <= 5000) and (t1.b >= 1) and (t1.b <= 5000))  (cost=2250.26 rows=5000)
		 |
		+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)


	EXPLAIN ANALYZE

		使用它可以估算成本、查看实际执行的统计数据，包括第一条记录的返回时间，全部记录返回时间，返回记录的数量以及循环数量。
		此外，EXPLAIN还将可以使用新的输出格式，树状输出。
			
		mysql> EXPLAIN ANALYZE select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.b>=1 and t2.b<=5000);
		+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| EXPLAIN                                                                                                                                                                                                                                                                                                                                                                                                                                           |
		+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| -> Inner hash join (t2.b = t1.b)  (cost=998405532.38 rows=110891376) (actual time=9.595..629.564 rows=5000 loops=1)
			-> Table scan on t2  (cost=36.70 rows=1996444) (actual time=0.042..432.845 rows=2000000 loops=1)
			-> Hash
				-> Index range scan on t1 using b, with index condition: ((t1.b >= 1) and (t1.b <= 5000) and (t1.b >= 1) and (t1.b <= 5000))  (cost=2250.26 rows=5000) (actual time=0.295..8.515 rows=5000 loops=1)
		 |
		+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.63 sec)


	
	
	SQL的执行时间
		
		5000 rows in set (0.54 sec)





2.2 被驱动表有索引-使用的是NLJ算法

	初始化表结构和数据

		create  database sbtest_02 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

use sbtest_02;
drop table t1;
drop table t2;
drop procedure idata;
create table t1(id int primary key, a int, b int, index(b));
create table t2 like t1;
delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  start transaction;
  while(i<=100000)do
	insert into t1 values(i, 10001-i, i);
	set i=i+1;
  end while;
  commit;
  set i=1;
  start transaction;
  while(i<=2000000)do
	insert into t2 values(i, i, i);
	set i=i+1;
  end while;
  commit;
  
end;;
delimiter ;
call idata();


	查看SQL的执行计划
		
		mysql> EXPLAIN  select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.b>=1 and t2.b<=5000);
		+----+-------------+-------+------------+-------+---------------+------+---------+----------------+------+----------+-----------------------+
		| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref            | rows | filtered | Extra                 |
		+----+-------------+-------+------------+-------+---------------+------+---------+----------------+------+----------+-----------------------+
		|  1 | SIMPLE      | t1    | NULL       | range | b             | b    | 5       | NULL           | 5000 |   100.00 | Using index condition |
		|  1 | SIMPLE      | t2    | NULL       | ref   | b             | b    | 5       | sbtest_02.t1.b |    1 |   100.00 | NULL                  |
		+----+-------------+-------+------------+-------+---------------+------+---------+----------------+------+----------+-----------------------+
		2 rows in set, 1 warning (0.00 sec)



	SQL的执行时间
	
		5000 rows in set (0.04 sec)
		
		5000 rows in set (0.07 sec)
		
		5000 rows in set (0.05 sec)

		select (0.04+0.07+0.05) / 3 = 0.05;

3. 执行耗时对比


					有索引			无索引
	MySQL5.7.26		0.09s			10 min 22.98 sec (BNL算法)
	MySQL8.0.26		0.05s           0.54s (hash join算法)

	

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
	

	
	
	

