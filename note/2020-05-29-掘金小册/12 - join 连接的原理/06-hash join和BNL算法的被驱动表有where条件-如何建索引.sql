
1. 初始化表结构和数据
2. hash join 
3. BNL 


1. 初始化表结构和数据

	use sbtest;
	drop table if exists  t1;
	drop table if exists t2;
	drop procedure  if exists idata;
	create table t1(id int primary key, a int, b int, c int, index(b));
	create table t2 like t1;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  start transaction;
	  while(i<=100000)do
		insert into t1 values(i, 10001-i, i, i);
		set i=i+1;
	  end while;
	  commit;
	  set i=1;
	  start transaction;
	  while(i<=500000)do
		insert into t2 values(i, i, i, i);
		set i=i+1;
	  end while;
	  commit;
	  
	end;;
	delimiter ;
	call idata();
	alter table t2 drop index b;
	alter table t2 add idx_a(a);

	mysql> show create table t2;
	+-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Table | Create Table                                                                                                                                                                                                                                  |
	+-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| t2    | CREATE TABLE `t2` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `b` int(11) DEFAULT NULL,
	  `c` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_a` (`a`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
	+-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)


2. hash join 
	
	explain FORMAT=TREE
		explain FORMAT=TREE select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.a>=1 and t2.a<=2000);
		mysql> explain FORMAT=TREE select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.a>=1 and t2.a<=2000);
		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| EXPLAIN                                                                                                                                                                                                                                                                                                                              |
		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| -> Inner hash join (t2.b = t1.b)  (cost=4503550.26 rows=1000000)
			-> Index range scan on t2 using idx_a, with index condition: ((t2.a >= 1) and (t2.a <= 2000))  (cost=700.26 rows=2000)
			-> Hash
				-> Index range scan on t1 using b, with index condition: ((t1.b >= 1) and (t1.b <= 5000))  (cost=2250.26 rows=5000)
		 |
		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)


		通过 explain format=tree 能够看到hash join是否被使用，这是新加的功能，而传统的explain仍然会显示nested loop，这种情况容易产生误解。



	
	EXPLAIN ANALYZE

		EXPLAIN ANALYZE select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.a>=1 and t2.a<=2000);
		mysql> EXPLAIN ANALYZE select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.a>=1 and t2.a<=2000);

		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| EXPLAIN                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| -> Inner hash join (t2.b = t1.b)  (cost=4503550.26 rows=1000000) (actual time=12.963..34.632 rows=2000 loops=1)
			-> Index range scan on t2 using idx_a, with index condition: ((t2.a >= 1) and (t2.a <= 2000))  (cost=700.26 rows=2000) (actual time=0.248..20.265 rows=2000 loops=1)
			-> Hash
				-> Index range scan on t1 using b, with index condition: ((t1.b >= 1) and (t1.b <= 5000))  (cost=2250.26 rows=5000) (actual time=0.149..9.879 rows=5000 loops=1)
		 |
		+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.03 sec)


3. BNL 
	
	explain  select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.a>=1 and t2.a<=2000);
	mysql> explain  select * from t1 straight_join t2 on (t1.b=t2.b) where (t1.b>=1 and t1.b<=5000) and  (t2.a>=1 and t2.a<=2000);
	+----+-------------+-------+------------+-------+---------------+-------+---------+------+------+----------+---------------------------------------------------------------------------+
	| id | select_type | table | partitions | type  | possible_keys | key   | key_len | ref  | rows | filtered | Extra                                                                     |
	+----+-------------+-------+------------+-------+---------------+-------+---------+------+------+----------+---------------------------------------------------------------------------+
	|  1 | SIMPLE      | t1    | NULL       | range | b             | b     | 5       | NULL | 5000 |   100.00 | Using index condition                                                     |
	|  1 | SIMPLE      | t2    | NULL       | range | idx_a         | idx_a | 5       | NULL | 2000 |    10.00 | Using index condition; Using where; Using join buffer (Block Nested Loop) |
	+----+-------------+-------+------------+-------+---------------+-------+---------+------+------+----------+---------------------------------------------------------------------------+
	2 rows in set, 1 warning (0.00 sec)


