

MySQL获取索引基数：
	1. 采用采样统计的方法； 通过采样统计得到索引的基数。
	2. 采样统计的时候，InnoDB 默认会选择 N 个数据页，统计这些页面上的不同值，得到一个平均值，然后乘以这个索引的页面数，就得到了这个索引的基数。
	
	默认对20个数据页进行采用，采样的过程如下：
		1. 取得 B+ 树索引叶子节点的数量，记为 A
		2. 随机取得 B+ 树索引中的 20个叶子节点即20个数据页， 统计每个页不同记录的个数，即为 P1, P2, .... P20
		3. 根据采样信息给出 Cardinality 的预估值： Cardinality = (P1+P2+......+P20)/20 * A
		
	要更新 Cardinality 值，请运行 ANALYZE TABLE 或（对于MyISAM表）运行myisamchk -a。
	
验证 show index from 中的 Cardinality 是否是从 innodb_index_stats 中取得		
	添加记录之前
		root@mysqldb 20:12:  [db1]> select * from test1;
		+----+------+---------------------+
		| id | name | CreateTime          |
		+----+------+---------------------+
		|  1 | 1    | 2020-04-05 19:38:00 |
		|  2 | 1    | 2020-04-05 19:38:00 |
		|  3 | 3    | 2020-04-15 18:55:57 |
		|  4 | 4    | 2020-04-15 18:57:51 |
		|  5 | 5    | 2020-04-15 18:57:51 |
		+----+------+---------------------+
		5 rows in set (0.00 sec)

		
		root@mysqldb 20:12:  [db1]> select * from information_schema.statistics where TABLE_SCHEMA='db1' and table_name='test1';
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		| def           | db1          | test1      |          0 | db1          | PRIMARY    |            1 | id          | A         |           5 |     NULL | NULL   |          | BTREE      |         |               |
		| def           | db1          | test1      |          1 | db1          | idx_name   |            1 | name        | A         |           4 |     NULL | NULL   |          | BTREE      |         |               |
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		2 rows in set (0.00 sec)

		root@mysqldb 20:12:  [db1]> select * from mysql.innodb_index_stats  where table_name = 'test1' and index_name = 'idx_name';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| db1           | test1      | idx_name   | 2020-04-15 19:58:40 | n_diff_pfx01 |          4 |           1 | name                              |
		| db1           | test1      | idx_name   | 2020-04-15 19:58:40 | n_diff_pfx02 |          5 |           1 | name,id                           |
		| db1           | test1      | idx_name   | 2020-04-15 19:58:40 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| db1           | test1      | idx_name   | 2020-04-15 19:58:40 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		4 rows in set (0.00 sec)
						
			

		root@mysqldb 20:13:  [db1]> show index from test1;
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| test1 |          0 | PRIMARY  |            1 | id          | A         |           5 |     NULL | NULL   |      | BTREE      |         |               |
		| test1 |          1 | idx_name |            1 | name        | A         |           4 |     NULL | NULL   |      | BTREE      |         |               |
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		2 rows in set (0.00 sec)


	
	添加记录之后
		root@mysqldb 20:13:  [db1]> INSERT INTO `db1`.`test1` (`name`, `CreateTime`) VALUES ('6', '2020-04-15 18:57:51');
		Query OK, 1 row affected (0.01 sec)

		root@mysqldb 20:13:  [db1]> select * from test1;
		+----+------+---------------------+
		| id | name | CreateTime          |
		+----+------+---------------------+
		|  1 | 1    | 2020-04-05 19:38:00 |
		|  2 | 1    | 2020-04-05 19:38:00 |
		|  3 | 3    | 2020-04-15 18:55:57 |
		|  4 | 4    | 2020-04-15 18:57:51 |
		|  5 | 5    | 2020-04-15 18:57:51 |
		|  6 | 6    | 2020-04-15 18:57:51 |
		+----+------+---------------------+
		6 rows in set (0.00 sec)


		root@mysqldb 20:13:  [db1]> select * from information_schema.statistics where TABLE_SCHEMA='db1' and table_name='test1';
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		| def           | db1          | test1      |          0 | db1          | PRIMARY    |            1 | id          | A         |           6 |     NULL | NULL   |          | BTREE      |         |               |
		| def           | db1          | test1      |          1 | db1          | idx_name   |            1 | name        | A         |           5 |     NULL | NULL   |          | BTREE      |         |               |
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		2 rows in set (0.00 sec)

		root@mysqldb 20:14:  [db1]> select * from mysql.innodb_index_stats  where table_name = 'test1' and index_name = 'idx_name';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| db1           | test1      | idx_name   | 2020-04-15 19:58:40 | n_diff_pfx01 |          4 |           1 | name                              |
		| db1           | test1      | idx_name   | 2020-04-15 19:58:40 | n_diff_pfx02 |          5 |           1 | name,id                           |
		| db1           | test1      | idx_name   | 2020-04-15 19:58:40 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| db1           | test1      | idx_name   | 2020-04-15 19:58:40 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		4 rows in set (0.00 sec)

		root@mysqldb 20:14:  [db1]> show index from test1;
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| test1 |          0 | PRIMARY  |            1 | id          | A         |           6 |     NULL | NULL   |      | BTREE      |         |               |
		| test1 |          1 | idx_name |            1 | name        | A         |           5 |     NULL | NULL   |      | BTREE      |         |               |
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		2 rows in set (0.00 sec)
		
		
		+---------------+------------+------------+----+------+----------+
		| database_name | table_name | index_name | SK | PK   | stat_pct |
		+---------------+------------+------------+----+------+----------+
		| db1           | t          | c          |  2 |    2 |   100.00 |
		| db1           | test1      | idx_name   |  5 |    5 |   100.00 |
		+---------------+------------+------------+----+------+----------+
		2 rows in set (0.00 sec)

		
		
	执行analyze table之后
		root@mysqldb 19:49:  [db1]>  analyze table db1.test1;
		+-----------+---------+----------+----------+
		| Table     | Op      | Msg_type | Msg_text |
		+-----------+---------+----------+----------+
		| db1.test1 | analyze | status   | OK       |
		+-----------+---------+----------+----------+
		1 row in set (0.04 sec)

		root@mysqldb 20:16:  [db1]> select * from information_schema.statistics where TABLE_SCHEMA='db1' and table_name='test1';
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		| def           | db1          | test1      |          0 | db1          | PRIMARY    |            1 | id          | A         |           6 |     NULL | NULL   |          | BTREE      |         |               |
		| def           | db1          | test1      |          1 | db1          | idx_name   |            1 | name        | A         |           5 |     NULL | NULL   |          | BTREE      |         |               |
		+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
		2 rows in set (0.00 sec)
		
		root@mysqldb 20:16:  [db1]> select * from mysql.innodb_index_stats  where table_name = 'test1' and index_name = 'idx_name';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| db1           | test1      | idx_name   | 2020-04-15 20:16:22 | n_diff_pfx01 |          5 |           1 | name                              |
		| db1           | test1      | idx_name   | 2020-04-15 20:16:22 | n_diff_pfx02 |          6 |           1 | name,id                           |
		| db1           | test1      | idx_name   | 2020-04-15 20:16:22 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| db1           | test1      | idx_name   | 2020-04-15 20:16:22 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		4 rows in set (0.00 sec)


		root@mysqldb 20:16:  [db1]>  show index from test1;
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| test1 |          0 | PRIMARY  |            1 | id          | A         |           6 |     NULL | NULL   |      | BTREE      |         |               |
		| test1 |          1 | idx_name |            1 | name        | A         |           5 |     NULL | NULL   |      | BTREE      |         |               |
		+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		2 rows in set (0.00 sec)
	
		
		+---------------+------------+------------+----+------+----------+
		| database_name | table_name | index_name | SK | PK   | stat_pct |
		+---------------+------------+------------+----+------+----------+
		| db1           | t          | c          |  2 |    2 |   100.00 |
		| db1           | test1      | idx_name   |  6 |    6 |   100.00 |
		+---------------+------------+------------+----+------+----------+
		2 rows in set (0.01 sec)

小结			
	
	验证了 show index from 中的 Cardinality 并不是从 innodb_index_stats 中获得， 而是从   information_schema.statistics 获得。

	innodb_index_stats 和 show index from 中的 Cardinality  并不是实时同步的。
	
	据说 innodb_index_stats 的字段统计值会有几秒的延迟。
	
		
https://dev.mysql.com/doc/refman/8.0/en/show-index.html