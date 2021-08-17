


1. 初始化表结构和数据
2. Barracuda->Dynamic 修改为 Antelope->Compact
3. 小结


1. 初始化表结构和数据

	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	insert into t1(age, tEndTime) values(28, now());

	

2. Barracuda->Dynamic 修改为 Antelope->Compact


	ls -lht t1.* 查看ibd文件的修改时间

	[root@localhost niuniuh5_db]# ls -lht t1.*
	-rw-r----- 1 mysql mysql 112K 8月  17 11:16 t1.ibd
	-rw-r----- 1 mysql mysql 8.5K 8月  17 11:15 t1.frm

	
	mysql> show global variables like '%file_format%';         
	+--------------------------+-----------+
	| Variable_name            | Value     |
	+--------------------------+-----------+
	| innodb_file_format       | Barracuda |
	| innodb_file_format_check | ON        |
	| innodb_file_format_max   | Barracuda |
	+--------------------------+-----------+
	3 rows in set (0.00 sec)


	select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name = 't1';
	select * from mysql.innodb_index_stats  where database_name='niuniuh5_db' and table_name = 't1';

	select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='niuniuh5_db' and  TABLE_NAME='t1';

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name = 't1';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| niuniuh5_db   | t1         | 2021-08-17 11:15:59 |      0 |                    1 |                        1 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='niuniuh5_db' and table_name = 't1';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| niuniuh5_db   | t1         | PRIMARY    | 2021-08-17 11:15:59 | n_diff_pfx01 |          0 |           1 | ID                                |
	| niuniuh5_db   | t1         | PRIMARY    | 2021-08-17 11:15:59 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | t1         | PRIMARY    | 2021-08-17 11:15:59 | size         |          1 |        NULL | Number of pages in the index      |
	| niuniuh5_db   | t1         | idx_age    | 2021-08-17 11:15:59 | n_diff_pfx01 |          0 |           1 | age                               |
	| niuniuh5_db   | t1         | idx_age    | 2021-08-17 11:15:59 | n_diff_pfx02 |          0 |           1 | age,ID                            |
	| niuniuh5_db   | t1         | idx_age    | 2021-08-17 11:15:59 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | t1         | idx_age    | 2021-08-17 11:15:59 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.01 sec)


	mysql> select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='niuniuh5_db' and  TABLE_NAME='t1';
	+------------+
	| ROW_FORMAT |
	+------------+
	| Dynamic    |
	+------------+
	1 row in set (0.00 sec)

	------------------------------------------------------------------------------------

	set global innodb_file_format=Antelope;

	ALTER TABLE t1 ROW_FORMAT=Compact;
	Query OK, 0 rows affected (0.60 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	shell> ls -lht t1.*
	-rw-r----- 1 mysql mysql 112K 8月  17 11:46 t1.ibd
	-rw-r----- 1 mysql mysql 8.5K 8月  17 11:46 t1.frm


	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name = 't1';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| niuniuh5_db   | t1         | 2021-08-17 11:46:45 |      1 |                    1 |                        1 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='niuniuh5_db' and table_name = 't1';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| niuniuh5_db   | t1         | PRIMARY    | 2021-08-17 11:46:45 | n_diff_pfx01 |          1 |           1 | ID                                |
	| niuniuh5_db   | t1         | PRIMARY    | 2021-08-17 11:46:45 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | t1         | PRIMARY    | 2021-08-17 11:46:45 | size         |          1 |        NULL | Number of pages in the index      |
	| niuniuh5_db   | t1         | idx_age    | 2021-08-17 11:46:45 | n_diff_pfx01 |          1 |           1 | age                               |
	| niuniuh5_db   | t1         | idx_age    | 2021-08-17 11:46:45 | n_diff_pfx02 |          1 |           1 | age,ID                            |
	| niuniuh5_db   | t1         | idx_age    | 2021-08-17 11:46:45 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | t1         | idx_age    | 2021-08-17 11:46:45 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)

	
	mysql> select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='niuniuh5_db' and  TABLE_NAME='t1';
	+------------+
	| ROW_FORMAT |
	+------------+
	| Compact    |
	+------------+
	1 row in set (0.01 sec)


3. 小结
	修改行格式需要重建表。
	
	