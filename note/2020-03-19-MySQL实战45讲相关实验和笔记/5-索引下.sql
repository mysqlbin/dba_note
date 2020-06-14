



CREATE TABLE `geek` (
  `a` int(11) NOT NULL,
  `b` int(11) NOT NULL,
  `c` int(11) NOT NULL,
  `d` int(11) NOT NULL,
  PRIMARY KEY (`a`,`b`),
  KEY `c` (`c`),
  KEY `ca` (`c`,`a`),
  KEY `cb` (`c`,`b`)
) ENGINE=InnoDB;


公司的同事告诉他说，由于历史原因，这个表需要 a、b 做联合主键，这个小吕理解了。
既然主键包含了 a、b 这两个字段，那意味着单独在字段 c 上创建一个索引，就已经包含了三个字段了呀，为什么要创建“ca”“cb”这两个索引？
同事告诉他，是因为他们的业务里面有这样的两种语句：
select * from geek where c=N order by a limit 1;
select * from geek where c=N order by b limit 1;

我给你的问题是，这位同事的解释对吗，为了这两个查询模式，这两个索引是否都是必须的？为什么呢？

丁奇老师的分析:
	表记录
		--a--|--b--|--c--
		  1    2     3
		  1    3     2
		  1    4     3
		  2    1     3
		  2    2     2
		  2    3     4
	主键 a,b:
		主键 a，b 的聚簇索引组织顺序相当于 order by a,b ,即先按 a 排序，再按 b 排序，c 无序。
	
	索引 ca:
		索引 ca 的组织顺序相当于 order by c,a ,即先按 c 排序，再按 a 排序，同时记录主键
		
		–c--|–a--|–主键部分b-- （注意，这里不是 ab, 而是只有 b), 验证如下:
		CREATE TABLE `geek_index_structure` (
		  `a` int(11) NOT NULL,
		  `b` int(11) NOT NULL,
		  `c` int(11) NOT NULL,
		  `d` int(11) NOT NULL,
		  PRIMARY KEY (`a`,`b`),
		  KEY `ca` (`c`,`a`)
		) ENGINE=InnoDB;

		mysql> select * from mysql.innodb_index_stats where table_name='geek_index_structure';
		+---------------+----------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name           | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+----------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| test_db       | geek_index_structure | PRIMARY    | 2019-10-14 00:39:26 | n_diff_pfx01 |          0 |           1 | a                                 |
		| test_db       | geek_index_structure | PRIMARY    | 2019-10-14 00:39:26 | n_diff_pfx02 |          0 |           1 | a,b                               |
		| test_db       | geek_index_structure | PRIMARY    | 2019-10-14 00:39:26 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | geek_index_structure | PRIMARY    | 2019-10-14 00:39:26 | size         |          1 |        NULL | Number of pages in the index      |
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:39:26 | n_diff_pfx01 |          0 |           1 | c                                 |
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:39:26 | n_diff_pfx02 |          0 |           1 | c,a                               |
		
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:39:26 | n_diff_pfx03 |          0 |           1 | c,a,b                             |
		
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:39:26 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:39:26 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+----------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		9 rows in set (0.01 sec)
		
		–c--|–a--|–主键部分b-- （注意，这里不是 ab, 而是只有 b), 
		 2    1     3    
		 2    2     2 
		 3    1     2 
		 3    1     4
		 3    2     1
		 4    2     3
			
		这个跟索引c的数据是一模一样的。

	索引 cb:
		索引 cb 的组织顺序相当于 order by c,b ,即先按 c 排序，再按 b 排序，同时记录主键
		
		–c--|–b--|–主键部分a-- （注意，这里不是 ab, 而是只有 a), 验证如下:
		
		CREATE TABLE `geek_index_structure` (
		  `a` int(11) NOT NULL,
		  `b` int(11) NOT NULL,
		  `c` int(11) NOT NULL,
		  `d` int(11) NOT NULL,
		  PRIMARY KEY (`a`,`b`),
		  KEY `ca` (`c`,`b`)
		) ENGINE=InnoDB;
		
		mysql> select * from mysql.innodb_index_stats where table_name='geek_index_structure';
		+---------------+----------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name           | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+----------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| test_db       | geek_index_structure | PRIMARY    | 2019-10-14 00:57:36 | n_diff_pfx01 |          0 |           1 | a                                 |
		| test_db       | geek_index_structure | PRIMARY    | 2019-10-14 00:57:36 | n_diff_pfx02 |          0 |           1 | a,b                               |
		| test_db       | geek_index_structure | PRIMARY    | 2019-10-14 00:57:36 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | geek_index_structure | PRIMARY    | 2019-10-14 00:57:36 | size         |          1 |        NULL | Number of pages in the index      |
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:57:36 | n_diff_pfx01 |          0 |           1 | c                                 |
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:57:36 | n_diff_pfx02 |          0 |           1 | c,b                               |
		
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:57:36 | n_diff_pfx03 |          0 |           1 | c,b,a                             |
		
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:57:36 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | geek_index_structure | ca         | 2019-10-14 00:57:36 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+----------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		9 rows in set (0.00 sec)


		–c--|–b--|–主键部分a-- （注意，这里不是 ab, 而是只有 a)
		2     2      2
		2     3      1 
		3     1      2
		3     2      1
		3     4      1
		4     3      2
		
	所以， 结论是 ca 可以去掉， cb 需要保留。	
	
	
我的分析	
	1. 答：不对；
	2. 分析如下：
		辅助索引后面存储的是主键索引, 因此，这三个辅助索引的索引结构如下所示 

		KEY `c` (`c`)      的索引结构为 c,a,b
		KEY `ca` (`c`,`a`) 的索引结构为 c,a,主键部分b （注意，这里不是 ab，而是只有 b）
		KEY `cb` (`c`,`b`) 的索引结构为 c,b,主键部分a （注意，这里不是 ab，而是只有 a）
		
		c=N order by a  可以用 c,a,b 这个索引， 因此索引 ca 是不需要了；
		c=N order by b  可以用 c,b,a 这个索引， 因此索引 cb 是需要的。 
		
		
		
	
知道二级索引结构是 列名1+列明2+主键  那么按照列名1列名2排序之后 主键还是有顺序的么?
	【群主】叶金荣(4700963) 2020/1/16 17:24:24
	A994-王刚-北京  
	知道二级索引结构是 列名1+列明2+主键  那么按照列名1列名2排序之后 主键还是有顺序的么
	
	【群主】叶金荣(4700963) 2020/1/16 17:24:29
	必须要有啊

	【群主】叶金荣(4700963) 2020/1/16 17:24:29
	要不怎么保证索引有序呢

	【群主】叶金荣(4700963) 2020/1/16 17:25:05
	上课有说过的哟

		
	这里要实际验证下.
	
	
	CREATE TABLE `t20200116` (
	  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	  `a` int(11) NOT NULL DEFAULT '0',
	  `b` int(11) NOT NULL DEFAULT '0',
	  PRIMARY KEY (`id`),
	  KEY `idx_a_b` (`a`,`b`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	root@mysqldb 07:26:  [db1]> select * from t20200116;
	+----+---+---+
	| id | a | b |
	+----+---+---+
	|  1 | 1 | 3 |
	|  2 | 1 | 4 |
	|  3 | 2 | 1 |
	+----+---+---+
	3 rows in set (0.00 sec)

	root@mysqldb 07:27:  [db1]> desc select * from t20200116 order by a,b,id;
	+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	| id | select_type | table     | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
	+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	|  1 | SIMPLE      | t20200116 | NULL       | index | NULL          | idx_a_b | 8       | NULL |    3 |   100.00 | Using index |
	+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)


	验证了, 主键还是有序的.
	
	