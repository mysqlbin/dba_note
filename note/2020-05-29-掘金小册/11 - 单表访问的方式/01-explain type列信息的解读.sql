
1. type列的含义
	1.1 system
	1.2 const
	1.3 eq_ref	
	1.4 ref
	1.5 fulltext	
	1.6 ref_or_null
	1.7 index_merge 的3种方式
		1. Using intersect	
		2. Using union	
		3. Using sort_union

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
		
	mysql> EXPLAIN SELECT * FROM t_const WHERE id = 1;
	+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
	+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t_const | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
	+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)

	
	mysql>EXPLAIN SELECT * FROM t_const WHERE key2 = 1;
	+----+-------------+---------+------------+-------+---------------+----------+---------+-------+------+----------+-------+
	| id | select_type | table   | partitions | type  | possible_keys | key      | key_len | ref   | rows | filtered | Extra |
	+----+-------------+---------+------------+-------+---------------+----------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t_const | NULL       | const | idx_key2      | idx_key2 | 5       | const |    1 |   100.00 | NULL  |
	+----+-------------+---------+------------+-------+---------------+----------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)	
		
	
1.3 eq_ref	
	
	表连接时基于主键或非NULL的唯一索引完成扫描， 比ref略好
	在连接查询时，如果被驱动表是通过主键或者唯一二级索引列等值匹配的方式进行访问的（如果该主键或者唯一二级索引是联合索引的话，所有的索引列都必须进行等值比较），则对该被驱动表的访问方法就是eq_ref
	-- 针对表连接的情况 /* 重点 */
	
	mysql> EXPLAIN SELECT * FROM s1 INNER JOIN s2 ON s1.id = s2.id;
	+----+-------------+-------+------------+--------+---------------+---------+---------+-----------------+------+----------+-------+
	| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref             | rows | filtered | Extra |
	+----+-------------+-------+------------+--------+---------------+---------+---------+-----------------+------+----------+-------+
	|  1 | SIMPLE      | s1    | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL            | 9688 |   100.00 | NULL  |
	|  1 | SIMPLE      | s2    | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | xiaohaizi.s1.id |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+--------+---------------+---------+---------+-----------------+------+----------+-------+
	2 rows in set, 1 warning (0.01 sec)	

	从执行计划的结果中可以看出，MySQL打算将s1作为驱动表，s2作为被驱动表，重点关注s2的访问方法是eq_ref，表明在访问s2表的时候可以通过主键的等值匹配来进行访问。
	
	mysql> EXPLAIN SELECT * FROM t1 INNER JOIN t2 ON t1.id = t2.id;
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
			
1.4 ref

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
	
	mysql>EXPLAIN SELECT * FROM t_ref where key2 = 2;
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
	| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t_ref | NULL       | ref  | idx_key2      | idx_key2 | 5       | const |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)
	
1.5 fulltext	
	全文索引
	
	
1.6 ref_or_null
	
	
	不仅想找出某个二级索引列的值等于某个常数的记录(此时表连接类型是 ref)，还想把该列的值为NULL的记录也找出来，就像下边这个查询：

		SELECT * FROM single_table WHERE key1 = 'abc' OR key1 IS NULL;

		当使用二级索引而不是全表扫描的方式执行该查询时，这种类型的查询使用的访问方法就称为ref_or_null

	案例：
		-- 表的字段中有NULL值
		
			drop table if exists t_ref;
			CREATE TABLE `t_ref` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `key1` varchar(100) DEFAULT NULL,
			  `key2` int(11) DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  KEY `idx_key2` (`key2`)
			) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('1', 1, NULL);
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('2', '2', '2');
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('3', '3', '3');
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('4', '4', '4');
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('5', '5', '5');
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('6', '6', '6');
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('7', '5', '5');
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('8', '5', '5');
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('9', '5', '5');
			INSERT INTO `t_ref` (`id`, `key1`, `key2`) VALUES ('10', '5', '5');


			mysql>  EXPLAIN SELECT * FROM t_ref WHERE key2=2 OR key2 IS NULL;
			+----+-------------+-------+------------+-------------+---------------+----------+---------+-------+------+----------+-----------------------+
			| id | select_type | table | partitions | type        | possible_keys | key      | key_len | ref   | rows | filtered | Extra                 |
			+----+-------------+-------+------------+-------------+---------------+----------+---------+-------+------+----------+-----------------------+
			|  1 | SIMPLE      | t_ref | NULL       | ref_or_null | idx_key2      | idx_key2 | 5       | const |    2 |   100.00 | Using index condition |
			+----+-------------+-------+------------+-------------+---------------+----------+---------+-------+------+----------+-----------------------+
			1 row in set, 1 warning (0.01 sec)

		-- 表的字段中没有NULL值
			
			drop table if exists t_ref;
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


			mysql> EXPLAIN SELECT * FROM t_ref WHERE key2=2 OR key2 IS NULL;
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



1.7 index_merge 的3种方式
	
	index_merge的概念：
	
		在一个查询中使用到多个二级索引，来完成一次查询的执行方法，提高查询效率。
		
		
		-- 基础不扎实，之前遇到索引合并产生的死锁，还需要查询资料看看索引合并是怎么回事。
	
	
	
	1. Using intersect
		
		概念：
			Intersection翻译过来的意思是交集。这里是说某个查询可以使用多个二级索引，将从多个二级索引中查询到的结果取交集
			先根据条件中各个二级索引查询出主键，再取出主键的交集 做 回表请求。
			
		drop table if exists single_table;
		CREATE TABLE single_table (
			id INT NOT NULL AUTO_INCREMENT,
			key1 VARCHAR(100),
			key2 INT,
			key3 VARCHAR(100),
			key_part1 VARCHAR(100),
			key_part2 VARCHAR(100),
			key_part3 VARCHAR(100),
			common_field VARCHAR(100),
			PRIMARY KEY (id),
			KEY idx_key1 (key1),
			UNIQUE KEY idx_key2 (key2),
			KEY idx_key3 (key3),
			KEY idx_key_part(key_part1, key_part2, key_part3)
		) Engine=InnoDB CHARSET=utf8;

	
		MySQL在某些特定的情况下才可能会使用到 Using intersect 索引合并：
		
			1. 情况1：二级索引列是等值匹配的情况，对于联合索引来说，在联合索引中的每个列都必须等值匹配，不能出现只匹配部分列的情况。
				
				可以使用 Using intersect 索引合并 的SQL语句
				
					SELECT * FROM single_table WHERE key1 = 'a' AND key_part1 = 'a' AND key_part2 = 'b' AND key_part3 = 'c';

				下边这两个查询就不能进行 Using intersect 索引合并：

					SELECT * FROM single_table WHERE key1 > 'a' AND key_part1 = 'a' AND key_part2 = 'b' AND key_part3 = 'c';

					SELECT * FROM single_table WHERE key1 = 'a' AND key_part1 = 'a';
					mysql> desc SELECT * FROM single_table WHERE key1 = 'a' AND key_part1 = 'a';
					+----+-------------+--------------+------------+------+-----------------------+----------+---------+-------+------+----------+-------------+
					| id | select_type | table        | partitions | type | possible_keys         | key      | key_len | ref   | rows | filtered | Extra       |
					+----+-------------+--------------+------------+------+-----------------------+----------+---------+-------+------+----------+-------------+
					|  1 | SIMPLE      | single_table | NULL       | ref  | idx_key1,idx_key_part | idx_key1 | 303     | const |    1 |   100.00 | Using where |
					+----+-------------+--------------+------------+------+-----------------------+----------+---------+-------+------+----------+-------------+
					1 row in set, 1 warning (0.03 sec)


					第一个查询是因为对key1进行了范围匹配
					第二个查询是因为联合索引 idx_key_part 中的 key_part2 和 key_part3 列并没有出现在搜索条件中，所以这两个查询不能进行 Using intersect 索引合并。
						-- 二级联合索引，所有的列都要进行等值匹配，这样才能保证 二级索引列+主键 是有序的。
						


			2. 情况2：主键列可以是范围匹配
				-- 这里还不理解。  
				-- 后来又理解了。
				比方说下边这个查询可能用到主键和idx_key1进行Intersection索引合并的操作：

				SELECT * FROM single_table WHERE id > 100 AND key1 = 'a';			
				
				-- 这里的主键索引是范围查询。
				
			3. 小结：
				
				不仅是多个二级索引之间可以采用Intersection索引合并，索引合并也可以有聚簇索引参加。
		
		
		二级索引列是等值匹配的情况：
			
			之所以二级索引列都是等值匹配的情况下才可能使用Intersection索引合并，是因为只有在这种情况下根据二级索引查询出的结果集是按照主键值排序的。
					-- 这里理解了。熟悉索引的结构就很容易理解了。
					
			Intersection索引合并会把从多个二级索引中查询出的主键值求交集，如果从各个二级索引中查询的到的结果集本身就是已经按照主键排好序的，那么求交集的过程就很easy啦
				
			取主键交集的流程：
			
				假设某个查询使用Intersection索引合并的方式从idx_key1和idx_key2这两个二级索引中获取到的主键值分别是：
				
					从idx_key1中获取到已经排好序的主键值：1、3、5

					从idx_key2中获取到已经排好序的主键值：2、3、4


				那么求交集的过程就是这样：
				
					逐个取出这两个结果集中最小的主键值，如果两个值相等，则加入最后的交集结果中，否则丢弃当前较小的主键值，再取该丢弃的主键值所在结果集的后一个主键值来比较，直到某个结果集中的主键值用完了	
					详情：
						
						先取出这两个结果集中较小的主键值做比较，因为1 < 2，所以把idx_key1的结果集的主键值1丢弃，取出后边的3来比较。

						因为3 > 2，所以把idx_key2的结果集的主键值2丢弃，取出后边的3来比较。

						因为3 = 3，所以把3加入到最后的交集结果中，继续两个结果集后边的主键值来比较。

						后边的主键值也不相等，所以最后的交集结果中只包含主键值3。
			
			
			但是如果从各个二级索引中查询出的结果集并不是按照主键排序的话，那就要先把结果集中的主键值排序完再来做上边的那个过程，就比较耗时了。
				-- 理解了。
				
		
		主键列可以是范围匹配：
		
			都带有主键值的，所以可以在从idx_key1中获取到的主键值上直接运用条件id > 100过滤就行了，通过过滤后得到的主键值再做回表操作，这样多简单，效率也高。
						
			所以涉及主键的搜索条件只不过是为了从别的二级索引得到的结果集中过滤记录罢了，是不是等值匹配不重要。		
			
			-- 理解了。
			
		
		小结：
		
			上边说的情况一和情况二只是发生Intersection索引合并的必要条件，不是充分条件。也就是说即使情况一、情况二成立，也不一定发生Intersection索引合并，这得看优化器的心情。
			优化器只有在单独根据搜索条件从某个二级索引中获取的记录数太多，导致回表开销太大，而通过Intersection索引合并后需要回表的记录数大大减少时才会使用Intersection索引合并。
	
			 Using intersect的作用：
				减少回表操作，减少了随机IO的产生，提高SQL语句的执行速度。
			
			缺点：
				如果delete或者update语句使用了 using intersect 索引合并，意味着需要对使用到的各个索引的记录进行加锁，可能会导致死锁的发生。
					
				参考：《2021-08-09-生产环境索引合并导致的死锁分析》
			
				
		-- Using intersect 理解了。


	2. Using union

		drop table if exists single_table;
		CREATE TABLE single_table (
			id INT NOT NULL AUTO_INCREMENT,
			key1 VARCHAR(100),
			key2 INT,
			key3 VARCHAR(100),
			key_part1 VARCHAR(100),
			key_part2 VARCHAR(100),
			key_part3 VARCHAR(100),
			common_field VARCHAR(100),
			PRIMARY KEY (id),
			KEY idx_key1 (key1),
			UNIQUE KEY idx_key2 (key2),
			KEY idx_key3 (key3),
			KEY idx_key_part(key_part1, key_part2, key_part3)
		) Engine=InnoDB CHARSET=utf8;
		
		
		Intersection是交集的意思，这适用于使用不同索引的搜索条件之间使用AND连接起来的情况；
		Union是并集的意思，适用于使用不同索引的搜索条件之间使用OR连接起来的情况。
		
		MySQL在某些特定的情况下才可能会使用到Union索引合并：

			1. 情况1：二级索引列是等值匹配的情况，对于联合索引来说，在联合索引中的每个列都必须等值匹配，不能出现只出现匹配部分列的情况。

				比方说下边这个查询可能用到idx_key1和idx_key_part这两个二级索引进行Union索引合并的操作：

				SELECT * FROM single_table WHERE key1 = 'a' OR ( key_part1 = 'a' AND key_part2 = 'b' AND key_part3 = 'c');


				而下边这两个查询就不能进行Union索引合并：

					SELECT * FROM single_table WHERE key1 > 'a' OR (key_part1 = 'a' AND key_part2 = 'b' AND key_part3 = 'c');

					SELECT * FROM single_table WHERE key1 = 'a' OR key_part1 = 'a';

					第一个查询是因为对key1进行了范围匹配。
					第二个查询是因为联合索引idx_key_part中的key_part2和key_part3列并没有出现在搜索条件中，所以这两个查询不能进行Union索引合并。

			2. 情况2：主键列可以是范围匹配
			
			
			3. 情况3：使用Intersection索引合并的搜索条件
			
				SELECT * FROM single_table WHERE key_part1 = 'a' AND key_part2 = 'b' AND key_part3 = 'c' OR (key1 = 'a' AND key3 = 'b');

				优化器可能采用这样的方式来执行这个查询：

					1. 先按照搜索条件 (key1 = 'a' AND key3 = 'b') 从索引idx_key1和idx_key3中使用Intersection索引合并的方式得到一个主键集合。

					2. 再按照搜索条件 (key_part1 = 'a' AND key_part2 = 'b' AND key_part3 = 'c') 从联合索引idx_key_part中得到另一个主键集合。

					3. 采用Union索引合并的方式把上述两个主键集合取并集，然后进行回表操作，将结果返回给用户

			
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

			mysql> desc SELECT * FROM t_index_merge WHERE key1 = '1' OR key3 = '1';
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
	
	
	3. Using sort_union
		
		
		sort_union：
			先按照二级索引记录的主键值进行排序，之后按照Union索引合并方式执行的方式称之为Sort-Union索引合并
			这种Sort-Union索引合并比单纯的Union索引合并多了一步对二级索引记录的主键值排序的过程。
			
			
		SELECT * FROM single_table WHERE key1 < 'a' OR key3 > 'z'
		
		这个查询无法使用到Union索引合并，原因：	
			根据key1 < 'a'从idx_key1索引中获取的二级索引记录的主键值不是排好序的，根据key3 > 'z'从idx_key3索引中获取的二级索引记录的主键值也不是排好序的，
			但是key1 < 'a'和key3 > 'z'这两个条件又特别让我们动心，所以我们可以这样：
		
			先根据key1 < 'a'条件从idx_key1二级索引中获取记录，并按照记录的主键值进行排序

			再根据key3 > 'z'条件从idx_key3二级索引中获取记录，并按照记录的主键值进行排序

			因为上述的两个二级索引主键值都是排好序的，剩下的操作和Union索引合并方式就一样了。	
				
	
	
1.8 unique_subquery
	
	unique subquery : 
		唯一索引子查询
		类似于两表连接中被驱动表的 eq_ref 访问方法
		unique_subquery 是针对在一些包含IN子查询的查询语句中，如果查询优化器决定将IN子查询转换为 EXISTS 子查询，而且子查询可以使用到主键进行等值匹配的话，那么该子查询执行计划的type列的值就是 unique_subquery ，比如下边的这个查询语句：
		
		mysql> EXPLAIN SELECT * FROM t1 WHERE key1 IN (SELECT id FROM t2 WHERE t1.key2 = t2.key2) OR key3 = '3';
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

	执行 full index scan(全索引扫描)，并且可以通过索引完成结果扫描，直接从索引中取得想要的结果数据， 也就是可以避免回表， 比 ALL略好
	
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
	
	上述查询中的搜索列表中只有key_part2一个列，而且搜索条件中也只有key_part3一个列，这两个列又恰好包含在idx_key_part这个索引中，
	可是搜索条件key_part3不能直接使用该索引进行ref或者range方式的访问，只能扫描整个idx_key_part索引的记录，所以查询计划的type列的值就是index。
	
	
1.12 all 
	全表扫描

2. 小结
	
	一般来说，这些访问方法按照我们介绍它们的顺序性能依次变差。
	
	其中除了All这个访问方法外，其余的访问方法都能用到索引，除了index_merge访问方法外，其余的访问方法都最多只能用到一个索引。

	对于使用InnoDB存储引擎的表来说，二级索引的记录只包含索引列和主键列的值，而聚簇索引中包含用户定义的全部列以及一些隐藏列，所以扫描二级索引的代价一般比直接全表扫描，也就是扫描聚簇索引的代价更低一些。

	索引合并的原理，如果明白了 B+树数据结构 中的索引有序性，那么就会容易理解许多。




	