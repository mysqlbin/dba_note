

0. MySQL获取索引基数的方式
1. 表结构和数据的初始化
2. 数据初始化之后的索引统计信息	
3. 新增记录之后的索引统计信息
4. analyze table 之后的索引统计信息
5. mysql.innodb_index_stats 的解读	
6. 小结



0. MySQL获取索引基数的方式
	1. 采用采样统计的方法； 通过采样统计得到索引的基数。
	2. 采样统计的时候，InnoDB 默认会选择 N 个数据页，统计这些页面上的不同值，得到一个平均值，然后乘以这个索引的页面数，就得到了这个索引的基数。
	
	默认对20个数据页进行采用，采样的过程如下：
		1. 取得 B+ 树索引叶子节点的数量，记为 A
		2. 随机取得 B+ 树索引中的 20个叶子节点即叶子节点的20个数据页， 统计每个页不同值的个数，即为 P1, P2, .... P20
		3. 根据采样信息给出 Cardinality 的预估值： Cardinality = (P1+P2+......+P20)/20 * A
		
	要更新 Cardinality 值，请运行 ANALYZE TABLE 或（对于MyISAM表）运行myisamchk -a。	

1. 表结构和数据的初始化
	drop table t_20200418;
	CREATE TABLE `t_20200418` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `t1` int(11) NOT NULL COMMENT '玩家ID',
	  `t2` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
	  `t3` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_t1_t2` (`t1`,`t2`),
	  KEY `idx_t3` (`t3`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='test表';

	INSERT INTO `zst`.`t_20200418` (`ID`, `t1`, `t2`, `t3`) VALUES ('1', '1', '1', now());
	INSERT INTO `zst`.`t_20200418` (`ID`, `t1`, `t2`, `t3`) VALUES ('4', '1', '4', now());
	INSERT INTO `zst`.`t_20200418` (`ID`, `t1`, `t2`, `t3`) VALUES ('3', '3', '3', now());
	INSERT INTO `zst`.`t_20200418` (`ID`, `t1`, `t2`, `t3`) VALUES ('5', '4', '1', now());
	INSERT INTO `zst`.`t_20200418` (`ID`, `t1`, `t2`, `t3`) VALUES ('6', '5', '5', now());
		
2. 数据初始化之后的索引统计信息	
	select t1,count(*) from t_20200418 group by t1;
	select t1,t2, count(*) from t_20200418 group by t1,t2;
	select t2,count(*) from t_20200418 group by t2;
	select * from t_20200418;
	root@localhost [zst]>select t1,count(*) from t_20200418 group by t1;
	+----+----------+
	| t1 | count(*) |
	+----+----------+
	|  1 |        2 |
	|  3 |        1 |
	|  4 |        1 |
	|  5 |        1 |
	+----+----------+
	4 rows in set (0.00 sec)
		-- t1列不同值的个数: 4
		
	root@localhost [zst]>select t1,t2, count(*) from t_20200418 group by t1,t2;
	+----+------+----------+
	| t1 | t2   | count(*) |
	+----+------+----------+
	|  1 |    1 |        1 |
	|  1 |    4 |        1 |
	|  3 |    3 |        1 |
	|  4 |    1 |        1 |
	|  5 |    5 |        1 |
	+----+------+----------+
	5 rows in set (0.00 sec)
		-- t1和t2列不同值的个数: 5
		
	root@localhost [zst]>select t2,count(*) from t_20200418 group by t2;
	+------+----------+
	| t2   | count(*) |
	+------+----------+
	|    1 |        2 |
	|    3 |        1 |
	|    4 |        1 |
	|    5 |        1 |
	+------+----------+
	4 rows in set (0.00 sec)
		-- t2列不同值的个数: 4

		
	root@localhost [zst]>select * from t_20200418;
	+----+----+------+---------------------+
	| ID | t1 | t2   | t3                  |
	+----+----+------+---------------------+
	|  1 |  1 |    1 | 2020-04-19 09:40:55 |
	|  3 |  3 |    3 | 2020-04-19 09:40:56 |
	|  4 |  1 |    4 | 2020-04-19 09:40:55 |
	|  5 |  4 |    1 | 2020-04-19 09:40:56 |
	|  6 |  5 |    5 | 2020-04-19 09:40:56 |
	+----+----+------+---------------------+
	5 rows in set (0.00 sec)


	root@localhost [zst]>select * from mysql.innodb_index_stats  where database_name='zst' and table_name = 't_20200418';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:41:06 | n_diff_pfx01 |          5 |           1 | ID                                |
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:41:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:41:06 | size         |          1 |        NULL | Number of pages in the index      |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | n_diff_pfx01 |          4 |           1 | t1                                |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | n_diff_pfx02 |          5 |           1 | t1,t2                             |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | n_diff_pfx03 |          5 |           1 | t1,t2,ID                          |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | size         |          1 |        NULL | Number of pages in the index      |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:41:06 | n_diff_pfx01 |          2 |           1 | t3                                |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:41:06 | n_diff_pfx02 |          5 |           1 | t3,ID                             |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:41:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:41:06 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.01 sec)

	root@localhost [zst]>show index from t_20200418;
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table      | Non_unique | Key_name  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t_20200418 |          0 | PRIMARY   |            1 | ID          | A         |           2 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200418 |          1 | idx_t1_t2 |            1 | t1          | A         |           1 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200418 |          1 | idx_t1_t2 |            2 | t2          | A         |           2 |     NULL | NULL   | YES  | BTREE      |         |               |
	| t_20200418 |          1 | idx_t3    |            1 | t3          | A         |           1 |     NULL | NULL   |      | BTREE      |         |               |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	root@localhost [zst]>select * from information_schema.statistics where TABLE_SCHEMA='zst' and table_name='t_20200418';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | zst          | t_20200418 |          0 | zst          | PRIMARY    |            1 | ID          | A         |           2 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t1_t2  |            1 | t1          | A         |           1 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t1_t2  |            2 | t2          | A         |           2 |     NULL | NULL   | YES      | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t3     |            1 | t3          | A         |           1 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	
3. 新增记录之后的索引统计信息
	
	INSERT INTO `zst`.`t_20200418` (`ID`, `t1`, `t2`, `t3`) VALUES ('7', '5', '5', now());
	其中 t1=5 和 t2=5 的这一行记录是存在的。
	
	root@localhost [zst]>select t1,count(*) from t_20200418 group by t1;
	+----+----------+
	| t1 | count(*) |
	+----+----------+
	|  1 |        2 |
	|  3 |        1 |
	|  4 |        1 |
	|  5 |        2 |
	+----+----------+
	4 rows in set (0.00 sec)
	
		-- t1列不同值的个数: 4
	
	root@localhost [zst]>select t1,t2, count(*) from t_20200418 group by t1,t2;
	+----+------+----------+
	| t1 | t2   | count(*) |
	+----+------+----------+
	|  1 |    1 |        1 |
	|  1 |    4 |        1 |
	|  3 |    3 |        1 |
	|  4 |    1 |        1 |
	|  5 |    5 |        2 |
	+----+------+----------+
	5 rows in set (0.00 sec)
	
		-- t1和t2列不同值的个数: 5
	
	root@localhost [zst]>select t2,count(*) from t_20200418 group by t2;
	+------+----------+
	| t2   | count(*) |
	+------+----------+
	|    1 |        2 |
	|    3 |        1 |
	|    4 |        1 |
	|    5 |        2 |
	+------+----------+
	4 rows in set (0.00 sec)
		
		-- t2列不同值的个数: 4
	
	root@localhost [zst]>select * from t_20200418;
	+----+----+------+---------------------+
	| ID | t1 | t2   | t3                  |
	+----+----+------+---------------------+
	|  1 |  1 |    1 | 2020-04-19 09:40:55 |
	|  3 |  3 |    3 | 2020-04-19 09:40:56 |
	|  4 |  1 |    4 | 2020-04-19 09:40:55 |
	|  5 |  4 |    1 | 2020-04-19 09:40:56 |
	|  6 |  5 |    5 | 2020-04-19 09:40:56 |
	|  7 |  5 |    5 | 2020-04-19 09:42:58 |
	+----+----+------+---------------------+
	6 rows in set (0.00 sec)
	
	root@localhost [zst]>select now();
	+---------------------+
	| now()               |
	+---------------------+
	| 2020-04-19 09:44:45 |
	+---------------------+
	1 row in set (0.00 sec)
	
	root@localhost [zst]>select * from mysql.innodb_index_stats  where database_name='zst' and table_name = 't_20200418';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:41:06 | n_diff_pfx01 |          5 |           1 | ID                                |
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:41:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:41:06 | size         |          1 |        NULL | Number of pages in the index      |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | n_diff_pfx01 |          4 |           1 | t1                                |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | n_diff_pfx02 |          5 |           1 | t1,t2                             |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | n_diff_pfx03 |          5 |           1 | t1,t2,ID                          |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:41:06 | size         |          1 |        NULL | Number of pages in the index      |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:41:06 | n_diff_pfx01 |          2 |           1 | t3                                |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:41:06 | n_diff_pfx02 |          5 |           1 | t3,ID                             |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:41:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:41:06 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)
	
	实际数据
		-- t1列不同值的个数: 4
		-- t1和t2列不同值的个数: 5
		-- 可以看到，索引的统计信息并没有发生改变，在从库也经常遇到这样的案例，参考笔记 《2019-07-01-主从架构下同一个表的物理大小相差一倍的分析.sql》
	
	root@localhost [zst]>show index from t_20200418;
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table      | Non_unique | Key_name  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t_20200418 |          0 | PRIMARY   |            1 | ID          | A         |           2 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200418 |          1 | idx_t1_t2 |            1 | t1          | A         |           1 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200418 |          1 | idx_t1_t2 |            2 | t2          | A         |           2 |     NULL | NULL   | YES  | BTREE      |         |               |
	| t_20200418 |          1 | idx_t3    |            1 | t3          | A         |           1 |     NULL | NULL   |      | BTREE      |         |               |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	root@localhost [zst]>select * from information_schema.statistics where TABLE_SCHEMA='zst' and table_name='t_20200418';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | zst          | t_20200418 |          0 | zst          | PRIMARY    |            1 | ID          | A         |           2 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t1_t2  |            1 | t1          | A         |           1 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t1_t2  |            2 | t2          | A         |           2 |     NULL | NULL   | YES      | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t3     |            1 | t3          | A         |           1 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)



4. analyze table 之后的索引统计信息

	select now();
	analyze table t_20200418;

	root@localhost [zst]>select now();
	+---------------------+
	| now()               |
	+---------------------+
	| 2020-04-19 09:45:31 |
	+---------------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>analyze table t_20200418;
	+----------------+---------+----------+----------+
	| Table          | Op      | Msg_type | Msg_text |
	+----------------+---------+----------+----------+
	| zst.t_20200418 | analyze | status   | OK       |
	+----------------+---------+----------+----------+
	1 row in set (0.03 sec)

	root@localhost [zst]>select * from mysql.innodb_index_stats  where database_name='zst' and table_name = 't_20200418';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:45:32 | n_diff_pfx01 |          6 |           1 | ID                                |
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:45:32 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | PRIMARY    | 2020-04-19 09:45:32 | size         |          1 |        NULL | Number of pages in the index      |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:45:32 | n_diff_pfx01 |          4 |           1 | t1                                |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:45:32 | n_diff_pfx02 |          5 |           1 | t1,t2                             |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:45:32 | n_diff_pfx03 |          6 |           1 | t1,t2,ID                          |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:45:32 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | idx_t1_t2  | 2020-04-19 09:45:32 | size         |          1 |        NULL | Number of pages in the index      |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:45:32 | n_diff_pfx01 |          3 |           1 | t3                                |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:45:32 | n_diff_pfx02 |          6 |           1 | t3,ID                             |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:45:32 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200418 | idx_t3     | 2020-04-19 09:45:32 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)
	
	实际数据
		-- t1列不同值的个数: 4
		-- t1和t2列不同值的个数: 5
		-- t1.stat_value=4
		-- t1,t2.stat_value=5
		
		-- 说明索引统计信息已经发生了改变, 并且索引统计信息是准确的。
		
		
	root@localhost [zst]>show index from t_20200418;
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table      | Non_unique | Key_name  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t_20200418 |          0 | PRIMARY   |            1 | ID          | A         |           6 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200418 |          1 | idx_t1_t2 |            1 | t1          | A         |           4 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200418 |          1 | idx_t1_t2 |            2 | t2          | A         |           5 |     NULL | NULL   | YES  | BTREE      |         |               |
	| t_20200418 |          1 | idx_t3    |            1 | t3          | A         |           3 |     NULL | NULL   |      | BTREE      |         |               |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	root@localhost [zst]>select * from information_schema.statistics where TABLE_SCHEMA='zst' and table_name='t_20200418';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | zst          | t_20200418 |          0 | zst          | PRIMARY    |            1 | ID          | A         |           6 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t1_t2  |            1 | t1          | A         |           4 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t1_t2  |            2 | t2          | A         |           5 |     NULL | NULL   | YES      | BTREE      |         |               |
	| def           | zst          | t_20200418 |          1 | zst          | idx_t3     |            1 | t3          | A         |           3 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)
	
	
5. mysql.innodb_index_stats 的解读	
	stat_name=size ：        stat_value 表示 索引的页的数量（Number of pages in the index）
	stat_name=n_leaf_pages ：stat_value 表示 叶子节点的数量（Number of leaf pages in the index）
	stat_name=n_diff_pfxNN ：stat_value 表示 索引字段上唯一值的数量
	
	具体说明：
	1. n_diff_pfx01 表示索引第一列 distinct 之后的数量
		如PRIMARY的ID列，index_name='PRIMARY' and stat_name='n_diff_pfx01'时，stat_value=6
			
	2. n_diff_pfx02 表示索引前两列 distinct 之后的数量
		如 idx_t1_t2 的 t1,t2 列 有 5 个值
		所以index_name='idx_t1_t2' and stat_name='n_diff_pfx02'时，stat_value=5

	3. n_diff_pfx03 表示索引前两个列+主键索引列 distinct 之后的数量
		如 idx_t1_t2 的 t1,t2,ID 列，有 6 个值
		

6. 小结
	了解了 stat_name 和 stat_value 的具体含义，就可以协助我们排查SQL执行时为什么没有使用合适的索引:
	例如某个索引 n_diff_pfxNN 的 stat_value 远小于实际值，查询优化器认为该索引选择度较差，就有可能导致使用错误的索引。
	通过 innodb_index_stats表信息获取联合索引的distinct之后的数量, 跟主键的distinct之后的数量做对比, 获取判断这个联合索引的区分度
	
	新增一行记录之后的20秒内，本案例的统计信息都没有自动更新，说明没有触发索引的统计信息。
	
	
	
	
	