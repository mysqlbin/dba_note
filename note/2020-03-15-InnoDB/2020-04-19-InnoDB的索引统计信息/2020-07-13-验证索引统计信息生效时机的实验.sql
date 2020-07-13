
0. MySQL获取索引基数的方式
1. 需要运行的SQL语句列表和表的DDL和初始化数据
2. 添加记录之前
3. 添加记录之后
4. 执行 analyze table 之后
5. 对本案例mysql.innodb_index_stats 的解读	
6. 小结


0. MySQL获取索引基数的方式
	1. 采用采样统计的方法； 通过采样统计得到索引的基数。
	2. 采样统计的时候，InnoDB 默认会选择 N 个数据页，统计这些页面上的不同值，得到一个平均值，然后乘以这个索引的页面数，就得到了这个索引的基数。
	
	默认对20个数据页进行采用，采样的过程如下：
		1. 取得 B+ 树索引叶子节点的数量，记为 A
		2. 随机取得 B+ 树索引中的 20个叶子节点即叶子节点的20个数据页， 统计每个页不同记录的个数，即为 P1, P2, .... P20
		3. 根据采样信息给出 Cardinality 的预估值： Cardinality = (P1+P2+......+P20)/20 * A
		
	要更新 Cardinality 值，请运行 ANALYZE TABLE 或（对于MyISAM表）运行myisamchk -a。	

1. 需要运行的SQL语句列表和表的DDL和初始化数据
	select * from t1;
	select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t1';
	select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't1';
	select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't1';
	show index from t1;
	
	drop table t1;
	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL COMMENT '',
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';
	
	
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`) VALUES ('1', '1', '2020-07-13 14:23:49');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`) VALUES ('2', '2', '2020-07-13 14:23:57');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`) VALUES ('3', '3', '2020-07-13 14:24:00');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`) VALUES ('4', '4', '2020-07-13 14:24:03');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`) VALUES ('5', '5', '2020-07-13 14:24:05');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`) VALUES ('6', '6', '2020-07-13 14:24:08');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`) VALUES ('7', '7', '2020-07-13 14:24:11');

2. 添加记录之前
	root@mysqldb 14:25:  [test_db]> select * from t1;
	+----+-----+---------------------+
	| ID | age | tEndTime            |
	+----+-----+---------------------+
	|  1 |   1 | 2020-07-13 14:23:49 |
	|  2 |   2 | 2020-07-13 14:23:57 |
	|  3 |   3 | 2020-07-13 14:24:00 |
	|  4 |   4 | 2020-07-13 14:24:03 |
	|  5 |   5 | 2020-07-13 14:24:05 |
	|  6 |   6 | 2020-07-13 14:24:08 |
	|  7 |   7 | 2020-07-13 14:24:11 |
	+----+-----+---------------------+
	7 rows in set (0.00 sec)


	root@mysqldb 14:25:  [test_db]> select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t1';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | test_db      | t1         |          0 | test_db      | PRIMARY    |            1 | ID          | A         |           7 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t1         |          1 | test_db      | idx_age    |            1 | age         | A         |           7 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	root@mysqldb 14:26:  [test_db]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't1';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| test_db       | t1         | 2020-07-13 14:24:13 |      7 |                    1 |                        1 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 14:26:  [test_db]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't1';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:24:13 | n_diff_pfx01 |          7 |           1 | ID                                |
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:24:13 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:24:13 | size         |          1 |        NULL | Number of pages in the index      |
	| test_db       | t1         | idx_age    | 2020-07-13 14:24:13 | n_diff_pfx01 |          7 |           1 | age                               |
	| test_db       | t1         | idx_age    | 2020-07-13 14:24:13 | n_diff_pfx02 |          7 |           1 | age,ID                            |
	| test_db       | t1         | idx_age    | 2020-07-13 14:24:13 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t1         | idx_age    | 2020-07-13 14:24:13 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.03 sec)

	root@mysqldb 14:26:  [test_db]> show index from t1;
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t1    |          0 | PRIMARY  |            1 | ID          | A         |           7 |     NULL | NULL   |      | BTREE      |         |               |
	| t1    |          1 | idx_age  |            1 | age         | A         |           7 |     NULL | NULL   |      | BTREE      |         |               |
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)


3. 添加记录之后

	root@mysqldb 14:26:  [test_db]> INSERT INTO `test_db`.`t1` (`age`, `tEndTime`) VALUES ('1', now());
	Query OK, 1 row affected (0.00 sec)


	root@mysqldb 14:42:  [test_db]> select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t1';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | test_db      | t1         |          0 | test_db      | PRIMARY    |            1 | ID          | A         |           8 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t1         |          1 | test_db      | idx_age    |            1 | age         | A         |           8 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	root@mysqldb 14:42:  [test_db]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't1';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| test_db       | t1         | 2020-07-13 14:24:13 |      7 |                    1 |                        1 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 14:42:  [test_db]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't1';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:24:13 | n_diff_pfx01 |          7 |           1 | ID                                |
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:24:13 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:24:13 | size         |          1 |        NULL | Number of pages in the index      |
	| test_db       | t1         | idx_age    | 2020-07-13 14:24:13 | n_diff_pfx01 |          7 |           1 | age                               |
	| test_db       | t1         | idx_age    | 2020-07-13 14:24:13 | n_diff_pfx02 |          7 |           1 | age,ID                            |
	| test_db       | t1         | idx_age    | 2020-07-13 14:24:13 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t1         | idx_age    | 2020-07-13 14:24:13 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)

	root@mysqldb 14:42:  [test_db]> show index from t1;
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t1    |          0 | PRIMARY  |            1 | ID          | A         |           8 |     NULL | NULL   |      | BTREE      |         |               |
	| t1    |          1 | idx_age  |            1 | age         | A         |           8 |     NULL | NULL   |      | BTREE      |         |               |
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	-- 这里是立即生效了, 但是索引的统计信息不准确。
	
4. 执行 analyze table 之后
	
	root@mysqldb 14:42:  [test_db]> analyze table test_db.t1;
	+------------+---------+----------+----------+
	| Table      | Op      | Msg_type | Msg_text |
	+------------+---------+----------+----------+
	| test_db.t1 | analyze | status   | OK       |
	+------------+---------+----------+----------+
	1 row in set (0.01 sec)


	root@mysqldb 14:43:  [test_db]> select * from t1;
	+----+-----+---------------------+
	| ID | age | tEndTime            |
	+----+-----+---------------------+
	|  1 |   1 | 2020-07-13 14:23:49 |
	|  2 |   2 | 2020-07-13 14:23:57 |
	|  3 |   3 | 2020-07-13 14:24:00 |
	|  4 |   4 | 2020-07-13 14:24:03 |
	|  5 |   5 | 2020-07-13 14:24:05 |
	|  6 |   6 | 2020-07-13 14:24:08 |
	|  7 |   7 | 2020-07-13 14:24:11 |
	|  8 |   1 | 2020-07-13 14:41:43 |
	+----+-----+---------------------+
	8 rows in set (0.00 sec)
	
	
	root@mysqldb 14:43:  [test_db]> select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t1';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | test_db      | t1         |          0 | test_db      | PRIMARY    |            1 | ID          | A         |           8 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | test_db      | t1         |          1 | test_db      | idx_age    |            1 | age         | A         |           7 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	root@mysqldb 14:43:  [test_db]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't1';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| test_db       | t1         | 2020-07-13 14:43:22 |      8 |                    1 |                        1 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 14:43:  [test_db]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't1';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:43:22 | n_diff_pfx01 |          8 |           1 | ID                                |
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:43:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t1         | PRIMARY    | 2020-07-13 14:43:22 | size         |          1 |        NULL | Number of pages in the index      |
	
	| test_db       | t1         | idx_age    | 2020-07-13 14:43:22 | n_diff_pfx01 |          7 |           1 | age                               |
	| test_db       | t1         | idx_age    | 2020-07-13 14:43:22 | n_diff_pfx02 |          8 |           1 | age,ID                            |
	| test_db       | t1         | idx_age    | 2020-07-13 14:43:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| test_db       | t1         | idx_age    | 2020-07-13 14:43:22 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)

	root@mysqldb 14:43:  [test_db]> show index from t1;
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t1    |          0 | PRIMARY  |            1 | ID          | A         |           8 |     NULL | NULL   |      | BTREE      |         |               |
	| t1    |          1 | idx_age  |            1 | age         | A         |           7 |     NULL | NULL   |      | BTREE      |         |               |
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)


	说明了 执行 analyze table 命令之后索引的统计信息会立即生效。
	索引的统计信息准确了。
	
	
	
5. 对本案例mysql.innodb_index_stats 的解读	
	stat_name=size ：        stat_value 表示 索引的页的数量（Number of pages in the index）
	stat_name=n_leaf_pages ：stat_value 表示 叶子节点的数量（Number of leaf pages in the index）
	stat_name=n_diff_pfxNN ：stat_value 表示 索引字段上唯一值的数量
	
	具体说明：
	1. n_diff_pfx01 表示索引第一列 distinct 之后的数量
		如PRIMARY的ID列，index_name='PRIMARY' and stat_name='n_diff_pfx01'时，stat_value=8
			

	2. n_diff_pfx02 表示辅助索引列+主键索引列 distinct 之后的数量
		如 idx_age 的 age,ID 列 有 8 个值
		所以index_name='idx_age' and stat_name='n_diff_pfx02'时，stat_value=8

	
6. 小结
	了解了 stat_name 和 stat_value 的具体含义，就可以协助我们排查SQL执行时为什么没有使用合适的索引:
	例如某个索引 n_diff_pfxNN 的 stat_value 远小于实际值，查询优化器认为该索引选择度较差，就有可能导致使用错误的索引。
	通过 innodb_index_stats表信息获取联合索引的distinct之后的数量, 跟主键的distinct之后的数量做对比, 获取判断这个联合索引的区分度
		
	同时验证了show index from中的基数从information_schema.statistics中获得。	

	
		


