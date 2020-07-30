


1. MySQL 5.7下不支持倒序索引，有额外排序
	1.1 初始化表结构和数据
	1.2 SQL的执行计划
	
	
2. MySQL 8.0下利用倒序索引消除排序
	1.1 初始化表结构和数据
	1.2 SQL的执行计划

3. 相关参考

	
1. MySQL 5.7下不支持倒序索引，有额外排序

	1.1 初始化表结构和数据
		CREATE TABLE `t1` (
		  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
		  `a` int(11) NOT NULL DEFAULT '0',
		  `b` int(11) NOT NULL DEFAULT '0',
		  `c` varchar(20) NOT NULL DEFAULT '',
		  `d` varchar(20) NOT NULL DEFAULT '',
		  PRIMARY KEY (`id`),
		  KEY `idx_a_b` (`a`,`b`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
		
		INSERT INTO `t1` VALUES ('1', '1', '1', 'aa', 'dd');
		INSERT INTO `t1` VALUES ('2', '4', '3', 'bb', 'dd');
		INSERT INTO `t1` VALUES ('3', '2', '3', 'cc', 'dd');
		INSERT INTO `t1` VALUES ('4', '1', '2', 'cc', 'dd');

	1.2 SQL的执行计划
		mysql> desc select * from t1 where a<3 order by a desc, b;
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                       |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | idx_a_b       | NULL | NULL    | NULL |    4 |    75.00 | Using where; Using filesort |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		1 row in set, 1 warning (0.00 sec)

	1.3 SQL语句返回的结果	
		mysql> select * from t1 where a<3 order by a desc, b;
		+----+---+---+----+----+
		| id | a | b | c  | d  |
		+----+---+---+----+----+
		|  3 | 2 | 3 | cc | dd |
		|  1 | 1 | 1 | aa | dd |
		|  4 | 1 | 2 | cc | dd |
		+----+---+---+----+----+
		3 rows in set (0.00 sec)

	1.4 先升序后降序之后SQL的执行计划	
		root@mysqldb 22:51:  [db1]> desc select * from t1 where a<3 order by a, b desc;
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                       |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		|  1 | SIMPLE      | t1    | NULL       | ALL  | idx_a_b       | NULL | NULL    | NULL |    4 |    75.00 | Using where; Using filesort |
		+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
		1 row in set, 1 warning (0.00 sec)
			
	
			
2. MySQL 8.0下支持利用倒序索引消除排序

	2.1 初始化表结构和数据
	
	CREATE TABLE `t3` (
	  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	  `a` int(11) NOT NULL DEFAULT '0',
	  `b` int(11) NOT NULL DEFAULT '0',
	  `c` varchar(20) NOT NULL DEFAULT '',
	  `d` varchar(20) NOT NULL DEFAULT '',
	  PRIMARY KEY (`id`),
	  KEY `idx_a_b` (`a` DESC,`b`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	INSERT INTO `t3` VALUES ('1', '1', '1', 'aa', 'dd');
	INSERT INTO `t3` VALUES ('2', '4', '3', 'bb', 'dd');
	INSERT INTO `t3` VALUES ('3', '2', '3', 'cc', 'dd');
	INSERT INTO `t3` VALUES ('4', '1', '2', 'cc', 'dd');

	2.2 SQL的执行计划
		mysql> desc select * from t3 where a<3 order by a desc, b;
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
		| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                 |
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
		|  1 | SIMPLE      | t3    | NULL       | range | idx_a_b       | idx_a_b | 4       | NULL |    3 |   100.00 | Using index condition |
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
		1 row in set, 1 warning (0.00 sec)
	
	2.3 SQL语句返回的结果
		mysql> select * from t3 where a<3 order by a desc, b;
		+----+---+---+----+----+
		| id | a | b | c  | d  |
		+----+---+---+----+----+
		|  3 | 2 | 3 | cc | dd |
		|  1 | 1 | 1 | aa | dd |
		|  4 | 1 | 2 | cc | dd |
		+----+---+---+----+----+
		3 rows in set (0.00 sec)

	
3. 相关参考
	https://yq.aliyun.com/articles/61287  (MySQL · 8.0新特性· Invisible Index)
	https://mp.weixin.qq.com/s/XQHzTY0q9xZ8B_c8xlComg   (老斯基带你解锁MySQL 8.0索引新姿势)
	https://mp.weixin.qq.com/s/y6RS-7GZE8aUtVJ52Uw81g    (这一刻，MySQL 8终于追赶上了Oracle 8)

