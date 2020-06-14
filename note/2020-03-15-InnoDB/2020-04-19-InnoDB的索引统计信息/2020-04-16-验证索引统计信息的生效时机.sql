

需要运行的SQL语句列表
	select * from test1;
	select * from information_schema.statistics where TABLE_SCHEMA='db1' and table_name='test1';
	select * from mysql.innodb_index_stats  where table_name = 'test1' and index_name = 'idx_name';
	show index from test1;

1. 添加记录之前
	root@mysqldb 14:39:  [db1]> select * from test1;
	+----+------+---------------------+
	| id | name | CreateTime          |
	+----+------+---------------------+
	|  1 | 1    | 2020-04-05 19:38:00 |
	|  2 | 1    | 2020-04-05 19:38:00 |
	|  3 | 3    | 2020-04-15 18:55:57 |
	|  4 | 4    | 2020-04-15 18:57:51 |
	|  5 | 5    | 2020-04-15 18:57:51 |
	|  6 | 6    | 2020-04-15 18:57:51 |
	|  7 | 7    | 2020-04-15 18:57:51 |
	+----+------+---------------------+
	7 rows in set (0.00 sec)

	root@mysqldb 14:40:  [db1]> select * from information_schema.statistics where TABLE_SCHEMA='db1' and table_name='test1';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | db1          | test1      |          0 | db1          | PRIMARY    |            1 | id          | A         |           7 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | db1          | test1      |          1 | db1          | idx_name   |            1 | name        | A         |           6 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	root@mysqldb 14:40:  [db1]> select * from mysql.innodb_index_stats  where table_name = 'test1' and index_name = 'idx_name';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| db1           | test1      | idx_name   | 2020-04-16 14:20:53 | n_diff_pfx01 |          5 |           1 | name                              |
	| db1           | test1      | idx_name   | 2020-04-16 14:20:53 | n_diff_pfx02 |          6 |           1 | name,id                           |
	| db1           | test1      | idx_name   | 2020-04-16 14:20:53 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| db1           | test1      | idx_name   | 2020-04-16 14:20:53 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	4 rows in set (0.00 sec)

	root@mysqldb 14:40:  [db1]> show index from test1;
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| test1 |          0 | PRIMARY  |            1 | id          | A         |           7 |     NULL | NULL   |      | BTREE      |         |               |
	| test1 |          1 | idx_name |            1 | name        | A         |           6 |     NULL | NULL   |      | BTREE      |         |               |
	+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)


	

2. 添加记录之后

	root@mysqldb 14:40:  [db1]> INSERT INTO `db1`.`test1` (`name`, `CreateTime`) VALUES ('8', now());
	Query OK, 1 row affected (0.02 sec)

	root@mysqldb 14:40:  [db1]> select * from test1;
	+----+------+---------------------+
	| id | name | CreateTime          |
	+----+------+---------------------+
	|  1 | 1    | 2020-04-05 19:38:00 |
	|  2 | 1    | 2020-04-05 19:38:00 |
	|  3 | 3    | 2020-04-15 18:55:57 |
	|  4 | 4    | 2020-04-15 18:57:51 |
	|  5 | 5    | 2020-04-15 18:57:51 |
	|  6 | 6    | 2020-04-15 18:57:51 |
	|  7 | 7    | 2020-04-15 18:57:51 |
	|  8 | 8    | 2020-04-16 14:40:31 |
	+----+------+---------------------+
	8 rows in set (0.00 sec)
	
	
	root@mysqldb 14:41:  [db1]> select * from information_schema.statistics where TABLE_SCHEMA='db1' and table_name='test1';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | db1          | test1      |          0 | db1          | PRIMARY    |            1 | id          | A         |           8 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | db1          | test1      |          1 | db1          | idx_name   |            1 | name        | A         |           7 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	root@mysqldb 14:48:  [db1]> select * from mysql.innodb_index_stats  where table_name = 'test1' and index_name = 'idx_name';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| db1           | test1      | idx_name   | 2020-04-16 14:40:31 | n_diff_pfx01 |          7 |           1 | name                              |
	| db1           | test1      | idx_name   | 2020-04-16 14:40:31 | n_diff_pfx02 |          8 |           1 | name,id                           |
	| db1           | test1      | idx_name   | 2020-04-16 14:40:31 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| db1           | test1      | idx_name   | 2020-04-16 14:40:31 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	4 rows in set (0.00 sec)

	
	这里是立即生效了。
	
3. 执行analyze table之后
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

		


