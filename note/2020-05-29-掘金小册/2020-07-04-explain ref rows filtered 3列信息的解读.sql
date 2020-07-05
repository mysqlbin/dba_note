
1. ref
2. rows
3. filtered

1. ref
	当使用索引列等值查询时，与索引列进行等值匹配的对象信息
	表示上述表的连接匹配条件，即哪些列或常量被用于查找索引列上的值
	当使用索引列等值匹配的条件去执行查询时，也就是在访问方法是 const、eq_ref、ref、ref_or_null、unique_subquery、index_subquery 其中之一时，ref列展示的就是与索引列作等值匹配的东东是个啥
	
	与索引列进行等值匹配的对象信息: const 、function 等
	
	案例1
		CREATE TABLE `t1` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `key1` varchar(100) DEFAULT NULL,
		  `key2` int(11) DEFAULT NULL,
		  `key3` varchar(100) DEFAULT NULL,
		  `common_field` varchar(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_key1` (`key1`)
		) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '1', '1', '1', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', '2', '1', '2', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', '3', '3', '3', '3');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', '4', '4', '4', '4');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', '5', '5', '5', '5');


		root@localhost [db1]>EXPLAIN SELECT * FROM t1 WHERE key1 = '1';
		+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
		| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra |
		+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
		|  1 | SIMPLE      | t1    | NULL       | ref  | idx_key1      | idx_key1 | 403     | const |    1 |   100.00 | NULL  |
		+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
		1 row in set, 1 warning (0.00 sec)
		
		可以看到ref列的值是const，表明在使用idx_key1索引执行查询时，与key1列作等值匹配的对象是一个常数
		
	
	案例2
	
		CREATE TABLE `t1` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `key1` varchar(100) DEFAULT NULL,
		  `key2` int(11) DEFAULT NULL,
		  `key3` varchar(100) DEFAULT NULL,
		  `common_field` varchar(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_key1` (`key1`)
		) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '1', '1', '1', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', '2', '1', '2', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', '3', '3', '3', '3');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', '4', '4', '4', '4');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', '5', '5', '5', '5');
		
		CREATE TABLE `t2` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `key1` varchar(100) DEFAULT NULL,
		  `key2` int(11) DEFAULT NULL,
		  `key3` varchar(100) DEFAULT NULL,
		  `common_field` varchar(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_key1` (`key1`)
		) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '1', '1', '1', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', '3', '3', '3', '1');

		root@localhost [db1]>EXPLAIN SELECT * FROM t1 INNER JOIN t2 ON t1.id = t2.id;
		+----+-------------+-------+------------+--------+---------------+---------+---------+-----------+------+----------+-------+
		| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref       | rows | filtered | Extra |
		+----+-------------+-------+------------+--------+---------------+---------+---------+-----------+------+----------+-------+
		|  1 | SIMPLE      | t1    | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL      |    5 |   100.00 | NULL  |
		|  1 | SIMPLE      | t2    | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | db1.t1.id |    1 |   100.00 | NULL  |
		+----+-------------+-------+------------+--------+---------------+---------+---------+-----------+------+----------+-------+
		2 rows in set, 1 warning (0.00 sec)

		可以看到对被驱动表t2的访问方法是 eq_ref ，而对应的ref列的值是 db1.t1.id，这说明在对被驱动表进行访问时会用到PRIMARY索引，也就是聚簇索引与一个列进行等值匹配的条件，于t2表的id作等值匹配的对象就是 db1.t1.id 列（注意这里把数据库名也写出来了）。
		
	案例3
		有的时候与索引列进行等值匹配的对象是一个函数，比方说下边这个查询：
		CREATE TABLE `t1` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `key1` varchar(100) DEFAULT NULL,
		  `key2` int(11) DEFAULT NULL,
		  `key3` varchar(100) DEFAULT NULL,
		  `common_field` varchar(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_key1` (`key1`)
		) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

		CREATE TABLE `t2` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `key1` varchar(100) DEFAULT NULL,
		  `key2` int(11) DEFAULT NULL,
		  `key3` varchar(100) DEFAULT NULL,
		  `common_field` varchar(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_key1` (`key1`)
		) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;


		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', 'a', '1', '1', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', 'b', '1', '2', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', 'c', '3', '3', '3');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', 'd', '4', '4', '4');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', 'e', '5', '5', '5');

		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', 'a', '1', '1', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', 'b', '3', '3', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', 'c', '1', '1', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', 'd', '3', '3', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', 'e', '3', '3', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('6', 'f', '3', '3', '1');

		root@localhost [db1]>EXPLAIN SELECT * FROM t1 inner join  t2 ON UPPER(t1.key1) = t2.key1 ;
		+----+-------------+-------+------------+------+---------------+----------+---------+------+------+----------+-----------------------+
		| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref  | rows | filtered | Extra                 |
		+----+-------------+-------+------------+------+---------------+----------+---------+------+------+----------+-----------------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | NULL          | NULL     | NULL    | NULL |    5 |   100.00 | NULL                  |
		|  1 | SIMPLE      | t2    | NULL       | ref  | idx_key1      | idx_key1 | 403     | func |    1 |   100.00 | Using index condition |
		+----+-------------+-------+------------+------+---------------+----------+---------+------+------+----------+-----------------------+
		2 rows in set, 1 warning (0.00 sec)
			
		show warnings;
			SELECT
				*
			FROM
				`db1`.`t1`
			JOIN `db1`.`t2`
			WHERE
				(
					upper(`db1`.`t1`.`key1`) = `db1`.`t2`.`key1`
				)
			
		我们看执行计划的第二条记录，可以看到对  t2 表采用type=ref访问方法执行查询，然后在查询计划的ref列里输出的是func，说明与t2表的key1列进行等值匹配的对象是一个函数。
		
2. rows
	预计扫描的行数
	
3. filtered
	filtered : 已过滤
	表示某个表经过搜索条件过滤后剩余记录条数的百分比
	
	对于单表查询来说，这个 filtered 列的值没什么意义，我们更关注在连接查询中驱动表对应的执行计划记录 的filtered 值
	
	分析连接查询的成本时提出过一个condition filtering的概念，就是MySQL在计算驱动表扇出时采用的一个策略：
		1. 如果使用的是全表扫描的方式执行的单表查询，那么计算驱动表扇出时需要估计出满足搜索条件的记录到底有多少条。

		2. 如果使用的是索引执行的单表扫描，那么计算驱动表扇出的时候需要估计出满足除使用到对应索引的搜索条件外的其他搜索条件的记录有多少条。
	
	案例1
		SELECT * FROM s1 WHERE key1 > 'z' AND common_field = 'a';
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+------------------------------------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra                              |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+------------------------------------+
		|  1 | SIMPLE      | s1    | NULL       | range | idx_key1      | idx_key1 | 303     | NULL |  266 |    10.00 | Using index condition; Using where |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+------------------------------------+
		1 row in set, 1 warning (0.00 sec)
		
		
		从执行计划的key列中可以看出来，该查询使用 idx_key1 索引来执行查询，从rows列可以看出满足key1 > 'z'的记录有266条。
		执行计划的filtered列就代表查询优化器预测在这266条记录中，有多少条记录满足其余的搜索条件，也就是common_field = 'a'这个条件的百分比。
		此处filtered列的值是10.00，说明查询优化器预测在266条记录中有10.00%的记录满足common_field = 'a'这个条件。
		
	案例2
		CREATE TABLE `t1` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `key1` int(11) DEFAULT NULL,
		  `key2` int(11) DEFAULT NULL,
		  `key3` varchar(100) DEFAULT NULL,
		  `common_field` varchar(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_key1` (`key1`)
		) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '1', '1', '1', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', '2', '1', '2', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', '3', '3', '3', '3');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', '4', '4', '4', '4');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', '5', '5', '5', '5');
		
		root@localhost [db1]>desc select * from t1 where key1 >3 and key2 = 5;
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+------------------------------------+
		| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra                              |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+------------------------------------+
		|  1 | SIMPLE      | t1    | NULL       | range | idx_key1      | idx_key1 | 5       | NULL |    2 |    20.00 | Using index condition; Using where |
		+----+-------------+-------+------------+-------+---------------+----------+---------+------+------+----------+------------------------------------+
		1 row in set, 1 warning (0.01 sec)
		
		filtered 表示某个表经过搜索条件过滤后剩余记录条数的百分比
		表中一共有5行记录, 满足 key1>3 的记录一共有2行记录, 符合通过索引预计扫描的行数为2即 rows=2
		此处 filtered = 20, 说明 查询经过搜索条件过滤后剩余记录条数的百分比为 20%, (1/5) % 100 = 20%
		说明了经过搜索条件过滤后的剩余的条数为 1 条.
		-- 理解了.
		root@localhost [db1]>select * from t1 where key1 >3;
		+----+------+------+------+--------------+
		| id | key1 | key2 | key3 | common_field |
		+----+------+------+------+--------------+
		|  4 |    4 |    4 | 4    | 4            |
		|  5 |    5 |    5 | 5    | 5            |
		+----+------+------+------+--------------+
		2 rows in set (0.00 sec)
		
		root@localhost [db1]>select * from t1 where key1 >3 and key2=5;
		+----+------+------+------+--------------+
		| id | key1 | key2 | key3 | common_field |
		+----+------+------+------+--------------+
		|  5 |    5 |    5 | 5    | 5            |
		+----+------+------+------+--------------+
		1 row in set (0.00 sec)
	
	案例3
		CREATE TABLE `t1` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `key1` varchar(100) DEFAULT NULL,
		  `key2` int(11) DEFAULT NULL,
		  `key3` varchar(100) DEFAULT NULL,
		  `common_field` varchar(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_key1` (`key1`)
		) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

		CREATE TABLE `t2` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `key1` varchar(100) DEFAULT NULL,
		  `key2` int(11) DEFAULT NULL,
		  `key3` varchar(100) DEFAULT NULL,
		  `common_field` varchar(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_key1` (`key1`)
		) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;


		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', 'a', '1', '1', 'a');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', 'b', '1', '2', '1');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', 'c', '3', '3', '3');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', 'd', '4', '4', '4');
		INSERT INTO `db1`.`t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', 'e', '5', '5', '5');

		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', 'a', '1', '1', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('2', 'b', '3', '3', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('3', 'c', '1', '1', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('4', 'd', '3', '3', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('5', 'e', '3', '3', '1');
		INSERT INTO `db1`.`t2` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('6', 'f', '3', '3', '1');
		
		root@localhost [db1]>EXPLAIN SELECT * FROM t1 inner join t2 ON t1.key1 = t2.key1 WHERE t1.common_field = 'a';
		+----+-------------+-------+------------+------+---------------+----------+---------+-------------+------+----------+-------------+
		| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref         | rows | filtered | Extra       |
		+----+-------------+-------+------------+------+---------------+----------+---------+-------------+------+----------+-------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | idx_key1      | NULL     | NULL    | NULL        |    5 |    20.00 | Using where |
		|  1 | SIMPLE      | t2    | NULL       | ref  | idx_key1      | idx_key1 | 403     | db1.t1.key1 |    1 |   100.00 | NULL        |
		+----+-------------+-------+------------+------+---------------+----------+---------+-------------+------+----------+-------------+
		2 rows in set, 1 warning (0.00 sec)

		root@localhost [db1]>SELECT * FROM t1 inner join t2 ON t1.key1 = t2.key1 WHERE t1.common_field = 'a';
		+----+------+------+------+--------------+----+------+------+------+--------------+
		| id | key1 | key2 | key3 | common_field | id | key1 | key2 | key3 | common_field |
		+----+------+------+------+--------------+----+------+------+------+--------------+
		|  1 | a    |    1 | 1    | a            |  1 | a    |    1 | 1    | 1            |
		+----+------+------+------+--------------+----+------+------+------+--------------+
		1 row in set (0.00 sec)
		
		
		从执行计划中可以看出来，查询优化器打算把t1当作驱动表，t2当作被驱动表。
		我们可以看到驱动表t1表的执行计划的rows列为5， filtered列为20.00，这意味着驱动表t1的扇出值就是5 × 20% = 1，即经过搜索条件过滤后的剩余的条数为1条. 这说明还要对被驱动表执行大约1次查询。
		
		
	
		