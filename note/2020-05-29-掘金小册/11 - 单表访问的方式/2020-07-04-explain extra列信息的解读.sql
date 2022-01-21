
1.1 No tables used
1.2 Impossible WHERE
1.3 No matching min/max row
1.4 using index
1.5 using index condition
1.6 using where 
1.7 Using join buffer (Block Nested Loop)
1.7 Not exists
1.8 Using intersect(...)、Using union(...)和Using sort_union(...)
1.9 Zero limit
1.10 Using filesort
1.11 Using temporary
1.12 Start temporary, End temporary
1.13 LooseScan
1.14 FirstMatch(tbl_name)
1.15 Select tables optimized away


1.1 No tables used
	当查询语句没有 from 子句时将会提示该额外信息
	root@localhost [db1]>EXPLAIN SELECT 1;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------+
	|  1 | SIMPLE      | NULL  | NULL       | NULL | NULL          | NULL | NULL    | NULL | NULL |     NULL | No tables used |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------+
	1 row in set, 1 warning (0.00 sec)


1.2 Impossible WHERE
	查询语句的 where 子句永远为 FALSE 时将会提示该额外信息
	root@localhost [db1]>EXPLAIN SELECT * FROM t1 WHERE 1 != 1;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra            |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------------+
	|  1 | SIMPLE      | NULL  | NULL       | NULL | NULL          | NULL | NULL    | NULL | NULL |     NULL | Impossible WHERE |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------------+
	1 row in set, 1 warning (0.00 sec)	
	
1.3 No matching min/max row
	当查询列表处有 MIN 或者 MAX函数, 但是并没有符合 WHERE 子句的搜索条件的记录时(查询到的记录为空时), 将会提示该额外信息
	root@localhost [db1]>EXPLAIN SELECT MIN(key1) FROM t1 WHERE key1 = 'abcdefg';
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                   |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------------------+
	|  1 | SIMPLE      | NULL  | NULL       | NULL | NULL          | NULL | NULL    | NULL | NULL |     NULL | No matching min/max row |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------------------+
	1 row in set, 1 warning (0.00 sec)

1.4 using index
	使用覆盖索引完成扫描, 通常做为优化的手段之一
	覆盖索引: 直接扫描二级索引就可以返回数据, 不需要回表.
	
	CREATE TABLE `t1` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  `key3` varchar(100) DEFAULT NULL,
	  `common_field` varchar(100) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_key1` (`key1`)
	) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', 'a', '1', '1', 'a');
	INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', 'b', '1', '2', '1');

	root@localhost [db1]>EXPLAIN SELECT key1 FROM t1 WHERE key1 = 'a';
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | t1    | NULL       | ref  | idx_key1      | idx_key1 | 403     | const |    1 |   100.00 | Using index |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)	
	
	
1.5 using index condition
	CREATE TABLE `t1` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  `key3` varchar(100) DEFAULT NULL,
	  `common_field` varchar(100) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_key1` (`key1`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;


	INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', 'a', '1', '1', 'a');
	INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', 'b', '1', '2', '1');
	INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', 'c', '3', '3', '3');
	INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', 'd', '4', '4', '4');
	INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', 'e', '5', '5', '5');

	root@localhost [db1]>desc SELECT * FROM t1 WHERE key1 > 'd' AND key1 LIKE '%e';
	+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
	| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | t1    | NULL       | range | idx_key1      | idx_key1 | 403     | NULL |    1 |   100.00 | Using index condition |
	+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)
	
	root@localhost [db1]>SELECT * FROM t1 WHERE key1 > 'd' AND key1 LIKE '%e';
	+----+------+------+------+--------------+
	| id | key1 | key2 | key3 | common_field |
	+----+------+------+------+--------------+
	|  5 | e    |    5 | 5    | 5            |
	+----+------+------+------+--------------+
	1 row in set (0.01 sec)
	
	没有索引下推优化的执行过程：
		其中的key1 > 'd' 可以使用到索引，但是key1 LIKE '%e'却无法使用到索引，在以前版本的MySQL中，是按照下边步骤来执行这个查询的：
		1. 先根据 key1 > 'd' 这个条件，从二级索引idx_key1中获取到对应的二级索引记录。
		2. 根据上一步骤得到的二级索引记录中的主键值进行回表，找到完整的用户记录再检测该记录是否符合 key1 LIKE '%e' 这个条件，将符合条件的记录加入到最后的结果集。
		
	使用到索引下推优化（index condition pushdown）的执行过程：
		1. 先根据key1 > 'd'这个条件，定位到二级索引idx_key1中对应的二级索引记录。

		2. 对于指定的二级索引记录，先不着急回表，而是先检测一下该记录是否满足key1 LIKE '%e'这个条件，如果这个条件不满足，则该二级索引记录压根儿就没必要回表。

		3. 对于满足key1 LIKE '%d'这个条件的二级索引记录执行回表操作。
		
	我们说回表操作其实是一个随机IO，比较耗时，所以上述修改虽然只改进了一点点，但是可以省去好多回表操作的成本。
	设计MySQL的大叔们把他们的这个改进称之为索引条件下推（英文名：Index Condition Pushdown）。
	
	
1.6 using where 
	
	Using where： 表示MySQL服务器将存储引擎返回行以后再在Server层应用where过滤条件。 By 高性能MySQL 第三版 第182页
	
	这里的表结构和数据使用的是 using index condition 中的.
	全表扫描
		当我们使用全表扫描来执行对某个表的查询，并且该语句的WHERE子句中有针对该表的搜索条件时，在Extra列中会提示上述额外信息。
		root@localhost [db1]>EXPLAIN SELECT * FROM t1  WHERE common_field = 'a';
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    5 |    20.00 | Using where |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

	索引和非索引扫描同时存在
		当使用索引访问来执行对某个表的查询，并且该语句的WHERE子句中有除了该索引包含的列之外的其他搜索条件时，在Extra列中也会提示上述额外信息。
		比如下边这个查询虽然使用idx_key1索引执行查询，但是搜索条件中除了包含key1的搜索条件key1 = 'a'，还有包含common_field的搜索条件，所以Extra列会显示Using where的提示：
		root@localhost [db1]>EXPLAIN SELECT * FROM t1  WHERE  key1='a' and common_field = 'a';
		+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
		| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
		+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
		|  1 | SIMPLE      | t1    | NULL       | ref  | idx_key1      | idx_key1 | 403     | const |    1 |    20.00 | Using where |
		+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		
1.7 Using join buffer (Block Nested Loop)

	join连接查询中, 被驱动表列没有索引
	
	在连接查询执行过程中，当被驱动表不能有效的利用索引加快访问速度，MySQL一般会为其分配一块名叫join buffer的内存块来加快查询速度，也就是我们所讲的基于块的嵌套循环算法
	
	root@localhost [db1]>EXPLAIN SELECT * FROM t1 INNER JOIN t2 ON t1.common_field = t2.common_field;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                                              |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
	|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    2 |   100.00 | NULL                                               |
	|  1 | SIMPLE      | t2    | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    4 |    25.00 | Using where; Using join buffer (Block Nested Loop) |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
	2 rows in set, 1 warning (0.00 sec)
	
	可以在对t2表的执行计划的Extra列显示了两个提示：
	
		Using join buffer (Block Nested Loop)：这是因为对表t2的访问不能有效利用索引，只好退而求其次，使用join buffer来减少对t2表的访问次数，从而提高性能。
		
		Using where：可以看到查询语句中有一个 t1.common_field = t2.common_field 条件，因为t1是驱动表，t2是被驱动表，所以在访问t2表时，t1.common_field的值已经确定下来了，所以实际上查询t2表的条件就是 "t2.common_field = 一个常数" ，所以提示了Using where额外信息。
		
1.7 Not exists
	当我们使用左（外）连接时，如果WHERE子句中包含要求被驱动表的某个列等于NULL值的搜索条件，而且那个列又是不允许存储NULL值的，那么在该表的执行计划的Extra列就会提示Not exists额外信息
	没有必要到被驱动表中找到全部符合ON子句条件的记录
	
	mysql> EXPLAIN SELECT * FROM s1 LEFT JOIN s2 ON s1.key1 = s2.key1 WHERE s2.id IS NULL;
	+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+-------------------------+
	| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref               | rows | filtered | Extra                   |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+-------------------------+
	|  1 | SIMPLE      | s1    | NULL       | ALL  | NULL          | NULL     | NULL    | NULL              | 9688 |   100.00 | NULL                    |
	|  1 | SIMPLE      | s2    | NULL       | ref  | idx_key1      | idx_key1 | 303     | xiaohaizi.s1.key1 |    1 |    10.00 | Using where; Not exists |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+-------------------------+
	2 rows in set, 1 warning (0.00 sec)
	上述查询中s1表是驱动表，s2表是被驱动表，s2.id列是不允许存储NULL值的，而WHERE子句中又包含s2.id IS NULL的搜索条件，这意味着必定是驱动表的记录在被驱动表中找不到匹配ON子句条件的记录才会把该驱动表的记录加入到最终的结果集，所以对于某条驱动表中的记录来说，如果能在被驱动表中找到1条符合ON子句条件的记录，那么该驱动表的记录就不会被加入到最终的结果集，也就是说我们没有必要到被驱动表中找到全部符合ON子句条件的记录，这样可以稍微节省一点性能。
		
	
1.8 Using intersect(...)、Using union(...)和Using sort_union(...)


	Using intersect
		intersect: 相交/交叉
		如果执行计划的Extra列出现了Using intersect(...)提示，说明准备使用Intersect索引合并的方式执行查询，括号中的...表示需要进行索引合并的索引名称
		mysql> EXPLAIN SELECT * FROM s1 WHERE key1 = 'a' AND key3 = 'a';
		+----+-------------+-------+------------+-------------+-------------------+-------------------+---------+------+------+----------+-------------------------------------------------+
		| id | select_type | table | partitions | type        | possible_keys     | key               | key_len | ref  | rows | filtered | Extra                                           |
		+----+-------------+-------+------------+-------------+-------------------+-------------------+---------+------+------+----------+-------------------------------------------------+
		|  1 | SIMPLE      | s1    | NULL       | index_merge | idx_key1,idx_key3 | idx_key3,idx_key1 | 303,303 | NULL |    1 |   100.00 | Using intersect(idx_key3,idx_key1); Using where |
		+----+-------------+-------+------------+-------------+-------------------+-------------------+---------+------+------+----------+-------------------------------------------------+
		1 row in set, 1 warning (0.01 sec)	
		其中Extra列就显示了Using intersect(idx_key3,idx_key1)，表明MySQL即将使用idx_key3和idx_key1这两个索引进行Intersect索引合并的方式执行查询。
			
	Using union
		如果出现了Using union(...)提示，说明准备使用Union索引合并的方式执行查询；
		
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
		
		root@localhost [db1]>desc SELECT * FROM t_index_merge WHERE key1 = '1' OR key3 = '1';
		+----+-------------+---------------+------------+-------------+-------------------+-------------------+---------+------+------+----------+---------------------------------------------+
		| id | select_type | table         | partitions | type        | possible_keys     | key               | key_len | ref  | rows | filtered | Extra                                       |
		+----+-------------+---------------+------------+-------------+-------------------+-------------------+---------+------+------+----------+---------------------------------------------+
		|  1 | SIMPLE      | t_index_merge | NULL       | index_merge | idx_key1,idx_key3 | idx_key1,idx_key3 | 403,403 | NULL |    2 |   100.00 | Using union(idx_key1,idx_key3); Using where |
		+----+-------------+---------------+------------+-------------+-------------------+-------------------+---------+------+------+----------+---------------------------------------------+
		1 row in set, 1 warning (0.00 sec)
		
		其中Extra列就显示了Using union(idx_key1,idx_key3)，表明MySQL即将使用idx_key1和idx_key3这两个索引进行union索引合并的方式执行查询。
		
		show warnings;
			select `db1`.`t_index_merge`.`id` AS `id`,
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
	Using sort_union
		出现了Using sort_union(...)提示，说明准备使用Sort-Union索引合并的方式执行查询。


1.9 Zero limit
	当我们的LIMIT子句的参数为0时，表示压根儿不打算从表中读出任何记录，将会提示该额外信息

	root@localhost [db1]>EXPLAIN SELECT * FROM t1 LIMIT 0;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra      |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------+
	|  1 | SIMPLE      | NULL  | NULL       | NULL | NULL          | NULL | NULL    | NULL | NULL |     NULL | Zero limit |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------+
	1 row in set, 1 warning (0.00 sec)
	

1.10 Using filesort
	有一些情况下对结果集中的记录进行排序是可以使用到索引的，比如下边这个查询：
		mysql> EXPLAIN SELECT * FROM s1 ORDER BY key1 LIMIT 10;
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-------+
		|  1 | SIMPLE      | s1    | NULL       | index | NULL          | idx_key1 | 303     | NULL |   10 |   100.00 | NULL  |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-------+
		1 row in set, 1 warning (0.03 sec)
		
		这个查询语句可以利用 idx_key1 索引直接取出 key1 列的10行记录, 然后再进行回表就可以得到结果集了.
		
	但是很多情况下排序操作无法使用索引, 只能在内存中(记录较少的时候) 或者 磁盘中(记录较多的时候) 进行排序
	
	把这种在内存中或者磁盘上进行排序的方式统称为文件排序（英文名：filesort）
	
	如果某个查询需要使用文件排序的方式执行查询，就会在执行计划的Extra列中显示Using filesort提示，比如这样：
	
		mysql> EXPLAIN SELECT * FROM s1 ORDER BY common_field LIMIT 10;
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------+
		|  1 | SIMPLE      | s1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 9688 |   100.00 | Using filesort |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+----------------+
		1 row in set, 1 warning (0.00 sec)
		
	如果查询中需要使用filesort的方式进行排序的记录非常多，那么这个过程是很耗费性能的，我们最好想办法将使用文件排序的执行方式改为使用索引进行排序。
	
1.11 Using temporary

	在许多查询的执行过程中，MySQL可能会借助临时表来完成一些功能，比如去重、排序之类的，比如我们在执行许多包含DISTINCT、GROUP BY、UNION等子句的查询过程中，如果不能有效利用索引来完成查询，MySQL需要寻求通过建立内部的临时表来执行查询
	
	root@localhost [db1]>EXPLAIN SELECT DISTINCT common_field FROM t1;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra           |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------+
	|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   13 |   100.00 | Using temporary |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------+
	1 row in set, 1 warning (0.00 sec)	
	
	root@localhost [db1]>EXPLAIN SELECT common_field, COUNT(*) AS amount FROM t1 GROUP BY common_field;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+---------------------------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                           |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+---------------------------------+
	|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   13 |   100.00 | Using temporary; Using filesort |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+---------------------------------+
	1 row in set, 1 warning (0.00 sec)

	
		上述执行计划的Extra列不仅仅包含Using temporary提示，还包含Using filesort提示
		
		这是因为MySQL会在包含GROUP BY子句的查询中默认添加上ORDER BY子句
		
	如果我们并不想为包含GROUP BY子句的查询进行排序，需要我们显式的写上ORDER BY NULL

		root@localhost [db1]>EXPLAIN SELECT common_field, COUNT(*) AS amount FROM t1 GROUP BY common_field order by null;
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra           |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   13 |   100.00 | Using temporary |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------+
		1 row in set, 1 warning (0.00 sec)
		
		这回执行计划中就没有Using filesort的提示了，也就意味着执行查询时可以省去对记录进行文件排序的成本了。
	
	执行计划中出现Using temporary并不是一个好的征兆，因为建立与维护临时表要付出很大成本的，所以我们最好能使用索引来替代掉使用临时表，比方说下边这个包含GROUP BY子句的查询就不需要使用临时表：

		mysql> EXPLAIN SELECT key1, COUNT(*) AS amount FROM s1 GROUP BY key1;
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-------------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra       |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-------------+
		|  1 | SIMPLE      | s1    | NULL       | index | idx_key1      | idx_key1 | 303     | NULL | 9688 |   100.00 | Using index |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

	从Extra的Using index的提示里我们可以看出，上述查询只需要扫描idx_key1索引就可以搞定了，不再需要临时表了。
	
	
1.12 Start temporary, End temporary

	查询优化器会优先尝试将IN子查询转换成semi-join，而semi-join又有好多种执行策略，当执行策略为 DuplicateWeedout 时，也就是通过建立临时表来实现为外层查询中的记录进行去重操作时，驱动表查询执行计划的Extra列将显示 Start temporary 提示，被驱动表查询执行计划的Extra列将显示 End temporary 提示
		
			
	mysql> EXPLAIN SELECT * FROM s1 WHERE key1 IN (SELECT key3 FROM s2 WHERE common_field = 'a');
	+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+------------------------------+
	| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref               | rows | filtered | Extra                        |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+------------------------------+
	|  1 | SIMPLE      | s2    | NULL       | ALL  | idx_key3      | NULL     | NULL    | NULL              | 9954 |    10.00 | Using where; Start temporary |
	|  1 | SIMPLE      | s1    | NULL       | ref  | idx_key1      | idx_key1 | 303     | xiaohaizi.s2.key3 |    1 |   100.00 | End temporary                |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------------------+------+----------+------------------------------+
	2 rows in set, 1 warning (0.00 sec)
	
1.13 LooseScan

	在将In子查询转为semi-join时，如果采用的是LooseScan执行策略，则在驱动表执行计划的Extra列就是显示LooseScan提示，比如这样：

1.14 FirstMatch(tbl_name)

	在将In子查询转为semi-join时，如果采用的是FirstMatch执行策略，则在被驱动表执行计划的Extra列就是显示FirstMatch(tbl_name)提示，比如这样：
	
	
1.15 Select tables optimized away

	Select tables optimized away: 
		选择经过优化的表
		在没有 GROUPBY 子句的情况下，基于索引优化 MIN/MAX 操作或者 对于 MyISAM 存储引擎优化 COUNT(*)操作，不必等到执行阶段再进行计算， 查询执行计划生成的阶段即完成优化
		
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)
	
	CREATE TABLE `table_t120200801` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `userId` int(11) NOT NULL COMMENT '',
	  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_CreateTime` (`CreateTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=1847500000000 DEFAULT CHARSET=utf8mb4 COMMENT='';

	
	mysql> desc select max(ID), min(ID) from table_t120200801;
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------------------------+
	| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                        |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------------------------+
	|  1 | SIMPLE      | NULL  | NULL       | NULL | NULL          | NULL | NULL    | NULL | NULL |     NULL | Select tables optimized away |
	+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+------------------------------+
	1 row in set, 1 warning (0.03 sec)
	
	mysql> select count(*) from table_t120200801;
	+----------+
	| count(*) |
	+----------+
	|   205742 |
	+----------+
	1 row in set (0.09 sec)

	mysql> select max(ID), min(ID) from table_t120200801;
	+---------------+---------------+
	| max(ID)       | min(ID)       |
	+---------------+---------------+
	| 1847500205741 | 1847500000000 |
	+---------------+---------------+
	1 row in set (0.00 sec)
	
	
