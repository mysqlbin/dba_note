

0. MySQL获取索引基数的方式
1. 需要运行的SQL语句列表和表的DDL和初始化数据
2. 数据初始化之后的索引统计信息	
3. 新增记录之后的索引统计信息
4. analyze table 之后的索引统计信息
5. 再次新增记录之后的索引统计信息
6. mysql.innodb_index_stats 的解读	
7. 小结



0. MySQL获取索引基数的方式
	1. 采用采样统计的方法； 通过采样统计得到索引的基数。
	2. 采样统计的时候，InnoDB 默认会选择 N 个数据页，统计这些页面上的不同值，得到一个平均值，然后乘以这个索引的页面数，就得到了这个索引的基数。
	
	默认对20个数据页进行采用，采样的过程如下：
		1. 取得 B+ 树索引叶子节点的数量，记为 A
		2. 随机取得 B+ 树索引中的 20个叶子节点即叶子节点的20个数据页， 统计每个页不同值的个数，即为 P1, P2, .... P20
		3. 根据采样信息给出 Cardinality 的预估值： Cardinality = (P1+P2+......+P20)/20 * A
		
	要更新 Cardinality 值，请运行 ANALYZE TABLE 或（对于MyISAM表）运行myisamchk -a。	

1. 需要运行的SQL语句列表和表的DDL和初始化数据
	drop table t_20200713;
	CREATE TABLE `t_20200713` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `t1` int(11) NOT NULL COMMENT '玩家ID',
	  `t2` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
	  `t3` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_t1_t2` (`t1`,`t2`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='test表';

	INSERT INTO `test_db`.`t_20200713` (`ID`, `t1`, `t2`, `t3`) VALUES ('1', '1', '1', now());
	INSERT INTO `test_db`.`t_20200713` (`ID`, `t1`, `t2`, `t3`) VALUES ('4', '1', '4', now());
	INSERT INTO `test_db`.`t_20200713` (`ID`, `t1`, `t2`, `t3`) VALUES ('3', '3', '3', now());
	INSERT INTO `test_db`.`t_20200713` (`ID`, `t1`, `t2`, `t3`) VALUES ('5', '4', '1', now());
	INSERT INTO `test_db`.`t_20200713` (`ID`, `t1`, `t2`, `t3`) VALUES ('6', '5', '5', now());


	select t1,count(*) from t_20200713 group by t1;
	select t1,t2, count(*) from t_20200713 group by t1,t2;
	select t2,count(*) from t_20200713 group by t2;

	select * from t_20200713;
	select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t_20200713';
	select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't_20200713';
	select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't_20200713';
	show index from t_20200713;
		
	
2. 数据初始化之后的索引统计信息	
	
	root@localhost [zst]>select t1,count(*) from t_20200713 group by t1;
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
		
	root@localhost [zst]>select t1,t2, count(*) from t_20200713 group by t1,t2;
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
		
	root@localhost [zst]>select t2,count(*) from t_20200713 group by t2;
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


	root@mysqldb 14:56:  [test_db]> select * from t_20200713;
	+----+----+------+---------------------+
	| ID | t1 | t2   | t3                  |
	+----+----+------+---------------------+
	|  1 |  1 |    1 | 2020-07-13 14:55:41 |
	|  3 |  3 |    3 | 2020-07-13 14:55:41 |
	|  4 |  1 |    4 | 2020-07-13 14:55:41 |
	|  5 |  4 |    1 | 2020-07-13 14:55:41 |
	|  6 |  5 |    5 | 2020-07-13 14:55:41 |
	+----+----+------+---------------------+
	5 rows in set (0.00 sec)

	root@mysqldb 14:56:  [test_db]> select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t_20200713';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | test_db      | t_20200713 |          0 | test_db      | PRIMARY    |            1 | ID          | A         |           5 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            1 | t1          | A         |           4 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            2 | t2          | A         |           5 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	root@mysqldb 14:56:  [test_db]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't_20200713';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| test_db       | t_20200713 | 2020-07-13 14:55:51 |      5 |                    1 |                        2 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.01 sec)

	root@mysqldb 14:56:  [test_db]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't_20200713';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 14:55:51 | n_diff_pfx01 |          5 |           1 | ID                                |
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 14:55:51 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 14:55:51 | size         |          1 |        NULL | Number of pages in the index      |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | n_diff_pfx01 |          4 |           1 | t1                                |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | n_diff_pfx02 |          5 |           1 | t1,t2                             |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | n_diff_pfx03 |          5 |           1 | t1,t2,ID                          |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)

	root@mysqldb 14:56:  [test_db]> show index from t_20200713;
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table      | Non_unique | Key_name  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t_20200713 |          0 | PRIMARY   |            1 | ID          | A         |           5 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200713 |          1 | idx_t1_t2 |            1 | t1          | A         |           4 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200713 |          1 | idx_t1_t2 |            2 | t2          | A         |           5 |     NULL | NULL   | YES  | BTREE      |         |               |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	
3. 新增记录之后的索引统计信息
	
	INSERT INTO `test_db`.`t_20200713` (`t1`, `t2`, `t3`) VALUES ('5', '5', now());
	其中 t1=5 和 t2=5 的这一行记录是存在的。
	
	root@localhost [zst]>select t1,count(*) from t_20200713 group by t1;
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
	
	root@localhost [zst]>select t1,t2, count(*) from t_20200713 group by t1,t2;
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
	
	root@localhost [zst]>select t2,count(*) from t_20200713 group by t2;
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
	
	root@mysqldb 14:58:  [test_db]> select * from t_20200713;
	+----+----+------+---------------------+
	| ID | t1 | t2   | t3                  |
	+----+----+------+---------------------+
	|  1 |  1 |    1 | 2020-07-13 14:55:41 |
	|  3 |  3 |    3 | 2020-07-13 14:55:41 |
	|  4 |  1 |    4 | 2020-07-13 14:55:41 |
	|  5 |  4 |    1 | 2020-07-13 14:55:41 |
	|  6 |  5 |    5 | 2020-07-13 14:55:41 |
	|  7 |  5 |    5 | 2020-07-13 14:58:36 |
	+----+----+------+---------------------+
	6 rows in set (0.00 sec)

	root@mysqldb 14:59:  [test_db]> select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t_20200713';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | test_db      | t_20200713 |          0 | test_db      | PRIMARY    |            1 | ID          | A         |           6 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            1 | t1          | A         |           5 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            2 | t2          | A         |           6 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	root@mysqldb 14:59:  [test_db]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't_20200713';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| test_db       | t_20200713 | 2020-07-13 14:55:51 |      5 |                    1 |                        2 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 14:59:  [test_db]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't_20200713';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 14:55:51 | n_diff_pfx01 |          5 |           1 | ID                                |
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 14:55:51 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 14:55:51 | size         |          1 |        NULL | Number of pages in the index      |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | n_diff_pfx01 |          4 |           1 | t1                                |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | n_diff_pfx02 |          5 |           1 | t1,t2                             |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | n_diff_pfx03 |          5 |           1 | t1,t2,ID                          |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 14:55:51 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)


	实际数据
		
		-- t1列不同值的个数: 4
		-- t1和t2列不同值的个数: 5
		-- t1.stat_value=4
		-- t1,t2.stat_value=5
		-- t1,t2,ID.stat_value=5
		-- last_update = '2020-07-13 14:55:51'
		-- 可以看到，索引的统计信息并没有发生改变，在从库也经常遇到这样的案例，参考笔记 《2019-07-01-主从架构下同一个表的物理大小相差一倍的分析.sql》

	
	root@mysqldb 14:59:  [test_db]> show index from t_20200713;
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table      | Non_unique | Key_name  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t_20200713 |          0 | PRIMARY   |            1 | ID          | A         |           6 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200713 |          1 | idx_t1_t2 |            1 | t1          | A         |           5 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200713 |          1 | idx_t1_t2 |            2 | t2          | A         |           6 |     NULL | NULL   | YES  | BTREE      |         |               |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	
4. analyze table 之后的索引统计信息

	root@mysqldb 15:01:  [test_db]> analyze table t_20200713;
	+--------------------+---------+----------+----------+
	| Table              | Op      | Msg_type | Msg_text |
	+--------------------+---------+----------+----------+
	| test_db.t_20200713 | analyze | status   | OK       |
	+--------------------+---------+----------+----------+
	1 row in set (0.00 sec)

	root@mysqldb 15:01:  [test_db]> select * from t_20200713;
	+----+----+------+---------------------+
	| ID | t1 | t2   | t3                  |
	+----+----+------+---------------------+
	|  1 |  1 |    1 | 2020-07-13 14:55:41 |
	|  3 |  3 |    3 | 2020-07-13 14:55:41 |
	|  4 |  1 |    4 | 2020-07-13 14:55:41 |
	|  5 |  4 |    1 | 2020-07-13 14:55:41 |
	|  6 |  5 |    5 | 2020-07-13 14:55:41 |
	|  7 |  5 |    5 | 2020-07-13 14:58:36 |
	+----+----+------+---------------------+
	6 rows in set (0.00 sec)

	root@mysqldb 15:01:  [test_db]> select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t_20200713';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | test_db      | t_20200713 |          0 | test_db      | PRIMARY    |            1 | ID          | A         |           6 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            1 | t1          | A         |           4 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            2 | t2          | A         |           5 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	root@mysqldb 15:01:  [test_db]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't_20200713';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| test_db       | t_20200713 | 2020-07-13 15:01:19 |      6 |                    1 |                        2 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 15:01:  [test_db]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't_20200713';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 15:01:19 | n_diff_pfx01 |          6 |           1 | ID                                |
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 15:01:19 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 15:01:19 | size         |          1 |        NULL | Number of pages in the index      |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | n_diff_pfx01 |          4 |           1 | t1                                |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | n_diff_pfx02 |          5 |           1 | t1,t2                             |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | n_diff_pfx03 |          6 |           1 | t1,t2,ID                          |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)

	root@mysqldb 15:01:  [test_db]> show index from t_20200713;
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table      | Non_unique | Key_name  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t_20200713 |          0 | PRIMARY   |            1 | ID          | A         |           6 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200713 |          1 | idx_t1_t2 |            1 | t1          | A         |           4 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200713 |          1 | idx_t1_t2 |            2 | t2          | A         |           5 |     NULL | NULL   | YES  | BTREE      |         |               |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)


	实际数据
		-- t1列不同值的个数: 4
		-- t1和t2列不同值的个数: 5
		-- t1.stat_value=4
		-- t1,t2.stat_value=5
		-- t1,t2,ID.stat_value=6
		-- last_update = '2020-07-13 15:01:19'
		-- 说明索引统计信息已经发生了改变, 并且索引统计信息是准确的。
		

5. 再次新增记录之后的索引统计信息
	
	INSERT INTO `test_db`.`t_20200713` (`t1`, `t2`, `t3`) VALUES ('8', '8', now());
	其中 t1=8 和 t2=8 的这一行记录是不存在的。
	
	root@mysqldb 15:44:  [test_db]> INSERT INTO `test_db`.`t_20200713` (`t1`, `t2`, `t3`) VALUES ('8', '8', now());
	Query OK, 1 row affected (0.00 sec)

	root@mysqldb 15:44:  [test_db]> select * from t_20200713;
	+----+----+------+---------------------+
	| ID | t1 | t2   | t3                  |
	+----+----+------+---------------------+
	|  1 |  1 |    1 | 2020-07-13 14:55:41 |
	|  3 |  3 |    3 | 2020-07-13 14:55:41 |
	|  4 |  1 |    4 | 2020-07-13 14:55:41 |
	|  5 |  4 |    1 | 2020-07-13 14:55:41 |
	|  6 |  5 |    5 | 2020-07-13 14:55:41 |
	|  7 |  5 |    5 | 2020-07-13 14:58:36 |
	|  8 |  8 |    8 | 2020-07-13 15:44:50 |
	+----+----+------+---------------------+
	7 rows in set (0.00 sec)

	root@mysqldb 15:45:  [test_db]> select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t_20200713';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | test_db      | t_20200713 |          0 | test_db      | PRIMARY    |            1 | ID          | A         |           7 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            1 | t1          | A         |           5 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            2 | t2          | A         |           6 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	root@mysqldb 15:45:  [test_db]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't_20200713';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| test_db       | t_20200713 | 2020-07-13 15:01:19 |      6 |                    1 |                        2 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 15:45:  [test_db]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't_20200713';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 15:01:19 | n_diff_pfx01 |          6 |           1 | ID                                |
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 15:01:19 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t_20200713 | PRIMARY    | 2020-07-13 15:01:19 | size         |          1 |        NULL | Number of pages in the index      |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | n_diff_pfx01 |          4 |           1 | t1                                |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | n_diff_pfx02 |          5 |           1 | t1,t2                             |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | n_diff_pfx03 |          6 |           1 | t1,t2,ID                          |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t_20200713 | idx_t1_t2  | 2020-07-13 15:01:19 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)

	root@mysqldb 15:45:  [test_db]> show index from t_20200713;
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table      | Non_unique | Key_name  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t_20200713 |          0 | PRIMARY   |            1 | ID          | A         |           7 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200713 |          1 | idx_t1_t2 |            1 | t1          | A         |           5 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200713 |          1 | idx_t1_t2 |            2 | t2          | A         |           6 |     NULL | NULL   | YES  | BTREE      |         |               |
	+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)


6. mysql.innodb_index_stats 的解读	
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
			

7. 小结
	了解了 stat_name 和 stat_value 的具体含义，就可以协助我们排查SQL执行时为什么没有使用合适的索引:
	例如某个索引 n_diff_pfxNN 的 stat_value 远小于实际值，查询优化器认为该索引选择度较差，就有可能导致使用错误的索引。
	通过 innodb_index_stats表信息获取联合索引的distinct之后的数量, 跟主键的distinct之后的数量做对比, 获取判断这个联合索引的区分度
	
	新增一行记录之后的20秒内，本案例的统计信息都没有自动更新，说明没有触发索引的统计信息。
	
	同时验证了show index from中的基数从information_schema.statistics中获得。	

	本案例在新增记录后，并没有触发索引的统计信息，
	
	
	