
1. type列的含义
	1.1 system
	1.2 const
	1.3 eq_ref	
	1.4. ref
	1.5 fulltext	
	1.6 ref_or_null
	1.7 index_merge
	1.8 unique_subquery
	1.9 index_subquery
	1.10 range
	1.11 index
	1.12 all 
2. 小结


1. type列的含义

	即访问类型, MySQL 决定如何查找表中的行.
	
	执行计划的一条记录就代表着MySQL对某个表的执行查询时的访问方法，其中的type列就表明了这个访问方法是个啥
	
	
	
1.1 system
	当表中只有一条记录并且该表使用的存储引擎的统计数据是精确的，比如MyISAM、Memory，那么该表的访问方法就是 system.
	
	------------------------- MyISAM ------------------------------------
	CREATE TABLE t(i int) Engine=MyISAM;
	INSERT INTO t VALUES(1);
	root@localhost [db1]>EXPLAIN SELECT * FROM t;
	+----+-------------+-------+------------+--------+---------------+------+---------+------+------+----------+-------+
	| id | select_type | table | partitions | type   | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
	+----+-------------+-------+------------+--------+---------------+------+---------+------+------+----------+-------+
	|  1 | SIMPLE      | t     | NULL       | system | NULL          | NULL | NULL    | NULL |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+--------+---------------+------+---------+------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)

		
	------------------------- InnoDB ------------------------------------
	root@localhost [db1]>alter table t Engine=InnoDB;
	Query OK, 1 row affected (0.02 sec)
	Records: 1  Duplicates: 0  Warnings: 0

	root@localhost [db1]>EXPLAIN SELECT * FROM t;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
	|  1 | SIMPLE      | t     | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)
	
1.2 const
	根据主键或者唯一二级索引列与常数进行等值匹配时，对应的单表访问方法就是 const
	基于主键或唯一索引唯一值查询，最多返回一条结果，比eq_ref略好
	-- 针对单表的情况
	CREATE TABLE `t_const` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  unique KEY `idx_key2` (`key2`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	
	INSERT INTO `db1`.`t_const` (`id`, `key1`, `key2`) VALUES ('1', '1', '1');
	INSERT INTO `db1`.`t_const` (`id`, `key1`, `key2`) VALUES ('2', '2', '2');
		
	root@localhost [db1]>EXPLAIN SELECT * FROM t_const WHERE id = 1;
	+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
	+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t_const | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
	+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)

	
	root@localhost [db1]>EXPLAIN SELECT * FROM t_const WHERE key2 = 1;
	+----+-------------+---------+------------+-------+---------------+----------+---------+-------+------+----------+-------+
	| id | select_type | table   | partitions | type  | possible_keys | key      | key_len | ref   | rows | filtered | Extra |
	+----+-------------+---------+------------+-------+---------------+----------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t_const | NULL       | const | idx_key2      | idx_key2 | 5       | const |    1 |   100.00 | NULL  |
	+----+-------------+---------+------------+-------+---------------+----------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)	
	
1.3 eq_ref	

	表连接时基于主键或非NULL的唯一索引完成扫描， 比ref略好
	在连接查询时，如果被驱动表是通过主键或者唯一二级索引列等值匹配的方式进行访问的（如果该主键或者唯一二级索引是联合索引的话，所有的索引列都必须进行等值比较），则对该被驱动表的访问方法就是eq_ref
	-- 针对表连接的情况
	
	mysql> EXPLAIN SELECT * FROM s1 INNER JOIN s2 ON s1.id = s2.id;
	+----+-------------+-------+------------+--------+---------------+---------+---------+-----------------+------+----------+-------+
	| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref             | rows | filtered | Extra |
	+----+-------------+-------+------------+--------+---------------+---------+---------+-----------------+------+----------+-------+
	|  1 | SIMPLE      | s1    | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL            | 9688 |   100.00 | NULL  |
	|  1 | SIMPLE      | s2    | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | xiaohaizi.s1.id |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+--------+---------------+---------+---------+-----------------+------+----------+-------+
	2 rows in set, 1 warning (0.01 sec)	

	从执行计划的结果中可以看出，MySQL打算将s1作为驱动表，s2作为被驱动表，重点关注s2的访问方法是eq_ref，表明在访问s2表的时候可以通过主键的等值匹配来进行访问。
	
	root@localhost [db1]>EXPLAIN SELECT * FROM t1 INNER JOIN t2 ON t1.id = t2.id;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                                              |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
	|  1 | SIMPLE      | t1    | NULL       | ALL  | PRIMARY       | NULL | NULL    | NULL |    2 |   100.00 | NULL                                               |
	|  1 | SIMPLE      | t2    | NULL       | ALL  | PRIMARY       | NULL | NULL    | NULL |    2 |    50.00 | Using where; Using join buffer (Block Nested Loop) |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
	2 rows in set, 1 warning (0.01 sec)
	
	show warnings;
		SELECT
			`db1`.`t1`.`id` AS `id`,
			`db1`.`t1`.`key1` AS `key1`,
			`db1`.`t1`.`key2` AS `key2`,
			`db1`.`t1`.`key3` AS `key3`,
			`db1`.`t1`.`common_field` AS `common_field`,
			`db1`.`t2`.`id` AS `id`,
			`db1`.`t2`.`key1` AS `key1`,
			`db1`.`t2`.`key2` AS `key2`,
			`db1`.`t2`.`key3` AS `key3`,
			`db1`.`t2`.`common_field` AS `common_field`
		FROM
			`db1`.`t1`
		JOIN `db1`.`t2`
		WHERE
			(
				`db1`.`t2`.`id` = `db1`.`t1`.`id`
			) 
			
1.4. ref

	当通过普通的二级索引列与常量进行等值匹配时来查询某个表，那么对该表的访问方法就可能是ref
	
	CREATE TABLE `t_ref` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_key2` (`key2`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('1', '1', '1');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('2', '2', '2');
	
	root@localhost [db1]>EXPLAIN SELECT * FROM t_ref where key2 = 2;
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
	| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t_ref | NULL       | ref  | idx_key2      | idx_key2 | 5       | const |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)
	
1.5 fulltext	
	全文索引
	
1.6 ref_or_null

	表连接类型是 ref， 但进行扫描的索引列中可能包含NULL值
	当对普通二级索引进行等值匹配查询，该索引列的值也可以是NULL值时，那么对该表的访问方法就可能是ref_or_null，比如说：
	
	CREATE TABLE `t_ref` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_key2` (`key2`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('1', '1', '1');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('2', '2', '2');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('3', '3', '3');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('4', '4', '4');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('5', '5', '5');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('6', '6', '6');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('7', '5', '5');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('8', '5', '5');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('9', '5', '5');
	INSERT INTO `db1`.`t_ref` (`id`, `key1`, `key2`) VALUES ('10', '5', '5');


	root@localhost [db1]>EXPLAIN SELECT * FROM t_ref WHERE key2=2 OR key2 IS NULL;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
	|  1 | SIMPLE      | t_ref | NULL       | ALL  | idx_key2      | NULL | NULL    | NULL |    2 |   100.00 | Using where |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
	1 row in set, 1 warning (0.01 sec)
	
	show warnings;
		SELECT
			`db1`.`t_ref`.`id` AS `id`,
			`db1`.`t_ref`.`key1` AS `key1`,
			`db1`.`t_ref`.`key2` AS `key2`
		FROM
			`db1`.`t_ref`
		WHERE
			(
				(`db1`.`t_ref`.`key2` = 2)
				OR isnull(`db1`.`t_ref`.`key2`)
			) 

1.7 index_merge
	
	可以利用 index merge（索引合并）特性用到多个索引，提高查询效率

	
	CREATE TABLE `t_index_merge` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  `key3` varchar(100) DEFAULT NULL,
	  `common_field` varchar(100) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_key1` (`key1`),
	  KEY `idx_key3` (`key3`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '1', '1', '1', '1');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', '2', '1', '2', '1');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', '3', '3', '3', '3');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', '4', '4', '4', '4');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('6', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('7', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('8', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('9', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('10', '5', '5', '5', '5');

	root@localhost [db1]>desc SELECT * FROM t_index_merge WHERE key1 = '1' OR key3 = '1';
	+----+-------------+---------------+------------+-------------+-------------------+-------------------+---------+------+------+----------+---------------------------------------------+
	| id | select_type | table         | partitions | type        | possible_keys     | key               | key_len | ref  | rows | filtered | Extra                                       |
	+----+-------------+---------------+------------+-------------+-------------------+-------------------+---------+------+------+----------+---------------------------------------------+
	|  1 | SIMPLE      | t_index_merge | NULL       | index_merge | idx_key1,idx_key3 | idx_key1,idx_key3 | 403,403 | NULL |    2 |   100.00 | Using union(idx_key1,idx_key3); Using where |
	+----+-------------+---------------+------------+-------------+-------------------+-------------------+---------+------+------+----------+---------------------------------------------+
	1 row in set, 1 warning (0.00 sec)
	
	show warnings;
		SELECT
		`db1`.`t_index_merge`.`id` AS `id`,
		`db1`.`t_index_merge`.`key1` AS `key1`,
		`db1`.`t_index_merge`.`key2` AS `key2`,
		`db1`.`t_index_merge`.`key3` AS `key3`,
		`db1`.`t_index_merge`.`common_field` AS `common_field`
		FROM
			`db1`.`t_index_merge`
		WHERE
			(
				(
					`db1`.`t_index_merge`.`key1` = '1'
				)
				OR (
					`db1`.`t_index_merge`.`key3` = '1'
				)
			)
			
1.8 unique_subquery
	
	unique subquery : 唯一索引子查询
	类似于两表连接中被驱动表的 eq_ref 访问方法
	unique_subquery是针对在一些包含IN子查询的查询语句中，如果查询优化器决定将IN子查询转换为EXISTS子查询，而且子查询可以使用到主键进行等值匹配的话，那么该子查询执行计划的type列的值就是unique_subquery，比如下边的这个查询语句：
		root@localhost [db1]> EXPLAIN SELECT * FROM t1 WHERE key1 IN (SELECT id FROM t2 WHERE t1.key2 = t2.key2) OR key3 = '3';
		+----+--------------------+-------+------------+-----------------+---------------+---------+---------+------+------+----------+-------------+
		| id | select_type        | table | partitions | type            | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
		+----+--------------------+-------+------------+-----------------+---------------+---------+---------+------+------+----------+-------------+
		|  1 | PRIMARY            | t1    | NULL       | ALL             | NULL          | NULL    | NULL    | NULL |    5 |   100.00 | Using where |
		|  2 | DEPENDENT SUBQUERY | t2    | NULL       | unique_subquery | PRIMARY       | PRIMARY | 4       | func |    1 |    50.00 | Using where |
		+----+--------------------+-------+------------+-----------------+---------------+---------+---------+------+------+----------+-------------+
		2 rows in set, 2 warnings (0.00 sec)
		
		可以看到执行计划的第二条记录的type值就是unique_subquery，说明在执行子查询时会使用到id列的索引。
		
		show warnings;
			SELECT
				`db1`.`t1`.`id` AS `id`,
				`db1`.`t1`.`key1` AS `key1`,
				`db1`.`t1`.`key2` AS `key2`,
				`db1`.`t1`.`key3` AS `key3`,
				`db1`.`t1`.`common_field` AS `common_field`
			FROM
				`db1`.`t1`
			WHERE
				(
					< in_optimizer > (
						`db1`.`t1`.`key1` ,< EXISTS > (
							< primary_index_lookup > (
								< CACHE > (`db1`.`t1`.`key1`) IN t2 ON PRIMARY
								WHERE
									(
										(
											`db1`.`t1`.`key2` = `db1`.`t2`.`key2`
										)
										AND (
											< CACHE > (`db1`.`t1`.`key1`) = `db1`.`t2`.`id`
										)
									)
							)
						)
					)
					OR (`db1`.`t1`.`key3` = '3')
				)

1.9 index_subquery
	index_subquery ： 普通索引子查询
	index_subquery与unique_subquery类似，只不过访问子查询中的表时使用的是普通的索引，比如这样：
	
		EXPLAIN SELECT * FROM t1 WHERE common_field IN (SELECT key3 FROM t2 where t1.key1 = t2.key1) OR key3 = 'a';
		
1.10 range
	基于索引的范围查询
	CREATE TABLE `t_range` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  `key3` varchar(100) DEFAULT NULL,
	  `common_field` varchar(100) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_key1` (`key1`),
	  KEY `idx_key3` (`key3`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '1', '1', '1', '1');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', '2', '1', '2', '1');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', '3', '3', '3', '3');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', '4', '4', '4', '4');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('6', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('7', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('8', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('9', '5', '5', '5', '5');
	INSERT INTO `db1`.`t_index_merge` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('10', '5', '5', '5', '5');
		
	root@localhost [db1]>desc select * from t_range where id between 1 and 3;
	+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
	+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	|  1 | SIMPLE      | t_range | NULL       | range | PRIMARY       | PRIMARY | 4       | NULL |    3 |   100.00 | Using where |
	+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

	root@localhost [db1]>desc select * from t_range where key1 between 1 and 2;
	+----+-------------+---------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
	| id | select_type | table   | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+---------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | t_range | NULL       | range | idx_key1      | idx_key1 | 5       | NULL |    2 |   100.00 | Using index condition |
	+----+-------------+---------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)

1.11 index
	执行 full index scan(全索引扫描)， 并且可以通过索引完成结果扫描，直接从索引中取得想要的结果数据， 也就是可以避免回表， 比 ALL略好
	
	当我们可以使用索引覆盖，但需要扫描全部的索引记录时，该表的访问方法就是index，比如这样：
		KEY idx_key_part(key_part1, key_part2, key_part3)
		
		mysql> EXPLAIN SELECT key_part2 FROM s1 WHERE key_part3 = 'a';
		+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
		| id | select_type | table | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra                    |
		+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
		|  1 | SIMPLE      | s1    | NULL       | index | NULL          | idx_key_part | 909     | NULL | 9688 |    10.00 | Using where; Using index |
		+----+-------------+-------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
		1 row in set, 1 warning (0.00 sec)
	
	type=index and Extra=index 表示基于覆盖索引的全索引扫描.
	
	上述查询中的搜索列表中只有key_part2一个列，而且搜索条件中也只有key_part3一个列，这两个列又恰好包含在idx_key_part这个索引中，可是搜索条件key_part3不能直接使用该索引进行ref或者range方式的访问，只能扫描整个idx_key_part索引的记录，所以查询计划的type列的值就是index。
	
	
1.12 all 
	全表扫描

2. 小结
	
	一般来说，这些访问方法按照我们介绍它们的顺序性能依次变差。
	其中除了All这个访问方法外，其余的访问方法都能用到索引，除了index_merge访问方法外，其余的访问方法都最多只能用到一个索引。

	对于使用InnoDB存储引擎的表来说，二级索引的记录只包含索引列和主键列的值，而聚簇索引中包含用户定义的全部列以及一些隐藏列，所以扫描二级索引的代价一般比直接全表扫描，也就是扫描聚簇索引的代价更低一些。



	