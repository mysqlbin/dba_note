
1. 初始化表结构和数据
2. 单列索引
3. 联合索引
4. 小结


1. 初始化表结构和数据

	drop table if exists t1;
	CREATE TABLE `t1` (
	  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	  `a` int(11) DEFAULT NULL,
	  `b` int(11) DEFAULT NULL,
	  `c` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_a` (`a`),
	  KEY `idx_c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	drop table if exists t2;

	CREATE TABLE `t2` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `a` int(11) DEFAULT NULL,
	  `b` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_a` (`a`),
	  KEY `idx_d` (`d`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


	drop procedure if exists idata ;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  while(i<=50)do
		insert into t1(a,b,c) values(i, i, i);
		insert into t2(a,b,d) values(i, i, i);
		set i=i+1;
	  end while;
	end;;
	delimiter ;
	call idata();
	call idata();
	call idata();
	call idata();
	call idata();
	call idata();
	call idata();
	call idata();
	call idata();
	call idata();


	mysql> select count(*) from t1;
	+----------+
	| count(*) |
	+----------+
	|      500 |
	+----------+
	1 row in set (0.00 sec)

	mysql> select count(*) from t2;
	+----------+
	| count(*) |
	+----------+
	|      500 |
	+----------+
	1 row in set (0.00 sec)






2. 单列索引


	t2表的 t2.a和t2.d是两个独立的索引，即被驱动表的连接列和where条件列都是单列索引
	
	在join查询中，当t2是被驱动表，t2.a是被驱动表列，t2.d是被驱动表的关联列， 只能用到t2.a这个索引。

	t1 
	  KEY `idx_a` (`a`),
	  KEY `idx_c` (`c`)
	 
	t2 
	  KEY `idx_a` (`a`),
	  KEY `idx_d` (`d`)


	mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;
	+----+-------------+-------+------------+------+---------------+-------+---------+-------------+------+----------+-------------+
	| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref         | rows | filtered | Extra       |
	+----+-------------+-------+------------+------+---------------+-------+---------+-------------+------+----------+-------------+
	|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c | 5       | const       |   10 |   100.00 | Using where |
	|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a,idx_d   | idx_a | 5       | sbtest.t1.a |    1 |     5.00 | Using where |
	+----+-------------+-------+------------+------+---------------+-------+---------+-------------+------+----------+-------------+
	2 rows in set, 1 warning (0.06 sec)


	mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10 group by t2.d;
	+----+-------------+-------+------------+------+---------------+-------+---------+-------------+------+----------+-------------+
	| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref         | rows | filtered | Extra       |
	+----+-------------+-------+------------+------+---------------+-------+---------+-------------+------+----------+-------------+
	|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c | 5       | const       |   10 |   100.00 | Using where |
	|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a,idx_d   | idx_a | 5       | sbtest.t1.a |    1 |     5.00 | Using where |
	+----+-------------+-------+------------+------+---------------+-------+---------+-------------+------+----------+-------------+
	2 rows in set, 1 warning (0.00 sec)



3. 联合索引
	
	
	1. 联合索引1

		根据被驱动列和被驱动表where条件组成的联合索引： t2.a和t2.d组成的联合索引

		t2

			alter table t2  add index idx_a_d(`a`,`d`);

			KEY `idx_a_d` (`a`,`d`),
			KEY `idx_a` (`a`),
			KEY `idx_d` (`d`)

			mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;
			+----+-------------+-------+------------+------+---------------------+---------+---------+-------------------+------+----------+-------------+
			| id | select_type | table | partitions | type | possible_keys       | key     | key_len | ref               | rows | filtered | Extra       |
			+----+-------------+-------+------------+------+---------------------+---------+---------+-------------------+------+----------+-------------+
			|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c         | idx_c   | 5       | const             |   10 |   100.00 | Using where |
			|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a_d,idx_a,idx_d | idx_a_d | 10      | sbtest.t1.a,const |   10 |   100.00 | NULL        |
			+----+-------------+-------+------------+------+---------------------+---------+---------+-------------------+------+----------+-------------+
			2 rows in set, 1 warning (0.00 sec)

	2. 联合索引2
		
		根据被驱动表where条件和被驱动列组成的联合索引:  t2.d和t2.a组成的联合索引

		  alter table t2 drop index idx_a_d, add index idx_d_a(`d`,`a`);
		  KEY `idx_a` (`a`),
		  KEY `idx_d` (`d`),
		  KEY `idx_d_a` (`d`,`a`)
		  
		mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;
		+----+-------------+-------+------------+------+---------------------+-------+---------+-------------+------+----------+-------------+
		| id | select_type | table | partitions | type | possible_keys       | key   | key_len | ref         | rows | filtered | Extra       |
		+----+-------------+-------+------------+------+---------------------+-------+---------+-------------+------+----------+-------------+
		|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c         | idx_c | 5       | const       |   10 |   100.00 | Using where |
		|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a,idx_d,idx_d_a | idx_a | 5       | sbtest.t1.a |   10 |     2.00 | Using where |
		+----+-------------+-------+------------+------+---------------------+-------+---------+-------------+------+----------+-------------+
		2 rows in set, 1 warning (0.00 sec)

		  




4. 小结

	NLJ算法
		被驱动表如果有where条件列，最好可以根据被驱动表的连接列和where条件列建立组合索引。
	
	BNL算法
		
		被驱动表的where 条件有索引，是可以使用到的
		驱动表的符合where条件的数据先放入到join buffer，再根据where条件扫描被驱动表的数据，然后到 join buffer 中匹配数据。
		
	HASH JOIN算法
		被驱动表的where 条件有索引，是可以使用到的
		驱动表的符合where条件的数据先放入到join buffer的hash table中，再根据where条件扫描被驱动表的数据，然后到 hash table 中匹配数据。
		
		
		