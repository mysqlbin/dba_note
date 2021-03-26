

大纲 
	1. 数据表文件的物理大小
	2. 查看主库和从库的索引统计信息/表统计信息/索引基数
	3. 查看表的逻辑大小/碎片大小/行数
	4. 解决办法
	5. 举一反三


1. 数据表文件的物理大小

	[dba2@database-03 aiuaiuh5_modb]$ ls -lht table_ab_loginlo.ibd
	-rw-r----- 1 mysql mysql 912K Mar  1 14:32 table_ab_loginlo.ibd

	
	[dba2@database-04 aiuaiuh5_modb]$ ls -lht table_ab_loginlo.ibd
	-rw-r----- 1 mysql mysql 912K Mar  1 14:32 table_ab_loginlo.ibd



2. 查看主库和从库的索引统计信息/表统计信息/索引基数

	select * from mysql.innodb_table_stats  where database_name='aiuaiuh5_modb' and table_name = 'table_ab_loginlo';
	select * from mysql.innodb_index_stats  where database_name='aiuaiuh5_modb' and table_name = 'table_ab_loginlo';
	show index from table_ab_loginlo;

	主库

		mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh5_modb' and table_name = 'table_ab_loginlo';
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name         | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		| aiuaiuh5_modb   | table_ab_loginlo | 2021-02-27 21:50:57 |   4277 |                   19 |                       33 |
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.00 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh5_modb' and table_name = 'table_ab_loginlo';
		+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name         | index_name                 | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-02-27 21:50:57 | n_diff_pfx01 |       4277 |          18 | Idx                               |
		| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-02-27 21:50:57 | n_leaf_pages |         18 |        NULL | Number of leaf pages in the index |
		| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-02-27 21:50:57 | size         |         19 |        NULL | Number of pages in the index      |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-27 21:50:57 | n_diff_pfx01 |        767 |          15 | loginIp                           |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-27 21:50:57 | n_diff_pfx02 |       3681 |          15 | loginIp,szTime                    |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-27 21:50:57 | n_diff_pfx03 |       4277 |          15 | loginIp,szTime,Idx                |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-27 21:50:57 | n_leaf_pages |         15 |        NULL | Number of leaf pages in the index |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-27 21:50:57 | size         |         16 |        NULL | Number of pages in the index      |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-02-27 21:50:57 | n_diff_pfx01 |        569 |           9 | nPlayerId                         |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-02-27 21:50:57 | n_diff_pfx02 |       4277 |           9 | nPlayerId,Idx                     |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-02-27 21:50:57 | n_leaf_pages |          9 |        NULL | Number of leaf pages in the index |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-02-27 21:50:57 | size         |         10 |        NULL | Number of pages in the index      |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-02-27 21:50:57 | n_diff_pfx01 |       3660 |           6 | szTime                            |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-02-27 21:50:57 | n_diff_pfx02 |       4277 |           6 | szTime,Idx                        |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-02-27 21:50:57 | n_leaf_pages |          6 |        NULL | Number of leaf pages in the index |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-02-27 21:50:57 | size         |          7 |        NULL | Number of pages in the index      |
		+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		16 rows in set (0.00 sec)

		mysql> show index from table_ab_loginlo;
		+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table              | Non_unique | Key_name                   | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| table_ab_loginlo |          0 | PRIMARY                    |            1 | Idx         | A         |        4277 |     NULL | NULL   |      | BTREE      |         |               |
		| table_ab_loginlo |          1 | web_loginlog_idx_nPlayerId |            1 | nPlayerId   | A         |         569 |     NULL | NULL   |      | BTREE      |         |               |
		| table_ab_loginlo |          1 | web_loginlog_idx_szTime    |            1 | szTime      | A         |        3660 |     NULL | NULL   | YES  | BTREE      |         |               |
		| table_ab_loginlo |          1 | idx_loginIp_szTime         |            1 | loginIp     | A         |         767 |     NULL | NULL   | YES  | BTREE      |         |               |
		| table_ab_loginlo |          1 | idx_loginIp_szTime         |            2 | szTime      | A         |        3681 |     NULL | NULL   | YES  | BTREE      |         |               |
		+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		5 rows in set (0.00 sec)



	从库

		mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh5_modb' and table_name = 'table_ab_loginlo';
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name         | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		| aiuaiuh5_modb   | table_ab_loginlo | 2021-02-14 02:15:10 |   2677 |                   13 |                       22 |
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.00 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh5_modb' and table_name = 'table_ab_loginlo';
		+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name         | index_name                 | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-02-14 02:15:10 | n_diff_pfx01 |       2677 |          12 | Idx                               |
		| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-02-14 02:15:10 | n_leaf_pages |         12 |        NULL | Number of leaf pages in the index |
		| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-02-14 02:15:10 | size         |         13 |        NULL | Number of pages in the index      |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-14 02:15:10 | n_diff_pfx01 |        350 |           9 | loginIp                           |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-14 02:15:10 | n_diff_pfx02 |       2351 |           9 | loginIp,szTime                    |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-14 02:15:10 | n_diff_pfx03 |       2677 |           9 | loginIp,szTime,Idx                |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-14 02:15:10 | n_leaf_pages |          9 |        NULL | Number of leaf pages in the index |
		| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-02-14 02:15:10 | size         |         10 |        NULL | Number of pages in the index      |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-02-14 02:15:10 | n_diff_pfx01 |        272 |           6 | nPlayerId                         |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-02-14 02:15:10 | n_diff_pfx02 |       2677 |           6 | nPlayerId,Idx                     |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-02-14 02:15:10 | n_leaf_pages |          6 |        NULL | Number of leaf pages in the index |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-02-14 02:15:10 | size         |          7 |        NULL | Number of pages in the index      |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-02-14 02:15:10 | n_diff_pfx01 |       2334 |           4 | szTime                            |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-02-14 02:15:10 | n_diff_pfx02 |       2677 |           4 | szTime,Idx                        |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-02-14 02:15:10 | n_leaf_pages |          4 |        NULL | Number of leaf pages in the index |
		| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-02-14 02:15:10 | size         |          5 |        NULL | Number of pages in the index      |
		+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		16 rows in set (0.00 sec)

		mysql> show index from table_ab_loginlo;
		+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table              | Non_unique | Key_name                   | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| table_ab_loginlo   |          0 | PRIMARY                    |            1 | Idx         | A         |        2677 |     NULL | NULL   |      | BTREE      |         |               |
		| table_ab_loginlo   |          1 | web_loginlog_idx_nPlayerId |            1 | nPlayerId   | A         |         272 |     NULL | NULL   |      | BTREE      |         |               |
		| table_ab_loginlo   |          1 | web_loginlog_idx_szTime    |            1 | szTime      | A         |        2334 |     NULL | NULL   | YES  | BTREE      |         |               |
		| table_ab_loginlo   |          1 | idx_loginIp_szTime         |            1 | loginIp     | A         |         350 |     NULL | NULL   | YES  | BTREE      |         |               |
		| table_ab_loginlo   |          1 | idx_loginIp_szTime         |            2 | szTime      | A         |        2351 |     NULL | NULL   | YES  | BTREE      |         |               |
		+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		5 rows in set (0.00 sec)




3. 查看表的逻辑大小/碎片大小/行数
	主库
		mysql> SELECT table_schema,table_name,data_length,index_length, DATA_FREE, table_rows  FROM information_schema.tables where table_schema='aiuaiuh5_modb' and TABLE_NAME='table_ab_loginlo';
		+--------------+--------------------+-------------+--------------+-----------+------------+
		| table_schema | table_name         | data_length | index_length | DATA_FREE | table_rows |
		+--------------+--------------------+-------------+--------------+-----------+------------+
		| aiuaiuh5_modb  | table_ab_loginlo |      311296 |       540672 |         0 |       4489 |
		+--------------+--------------------+-------------+--------------+-----------+------------+
		1 row in set (0.00 sec)

	从库
		mysql> SELECT table_schema,table_name,data_length,index_length, DATA_FREE, table_rows  FROM information_schema.tables where table_schema='aiuaiuh5_modb' and TABLE_NAME='table_ab_loginlo';
		+--------------+--------------------+-------------+--------------+-----------+------------+
		| table_schema | table_name         | data_length | index_length | DATA_FREE | table_rows |
		+--------------+--------------------+-------------+--------------+-----------+------------+
		| aiuaiuh5_modb  | table_ab_loginlo |      212992 |       360448 |         0 |       2698 |
		+--------------+--------------------+-------------+--------------+-----------+------------+
		1 row in set (0.00 sec)

	
4. 解决办法
	
	mysql> analyze table table_ab_loginlo;
	+--------------------------------+---------+----------+----------+
	| Table                          | Op      | Msg_type | Msg_text |
	+--------------------------------+---------+----------+----------+
	| aiuaiuh5_modb.table_ab_loginlo | analyze | status   | OK       |
	+--------------------------------+---------+----------+----------+
	1 row in set (0.01 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh5_modb' and table_name = 'table_ab_loginlo';
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name         | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	| aiuaiuh5_modb   | table_ab_loginlo | 2021-03-01 15:12:55 |   4492 |                   20 |                       33 |
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh5_modb' and table_name = 'table_ab_loginlo';
	+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name         | index_name                 | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-03-01 15:12:55 | n_diff_pfx01 |       4492 |          19 | Idx                               |
	| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-03-01 15:12:55 | n_leaf_pages |         19 |        NULL | Number of leaf pages in the index |
	| aiuaiuh5_modb   | table_ab_loginlo | PRIMARY                    | 2021-03-01 15:12:55 | size         |         20 |        NULL | Number of pages in the index      |
	| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-03-01 15:12:55 | n_diff_pfx01 |        810 |          15 | loginIp                           |
	| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-03-01 15:12:55 | n_diff_pfx02 |       3871 |          15 | loginIp,szTime                    |
	| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-03-01 15:12:55 | n_diff_pfx03 |       4492 |          15 | loginIp,szTime,Idx                |
	| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-03-01 15:12:55 | n_leaf_pages |         15 |        NULL | Number of leaf pages in the index |
	| aiuaiuh5_modb   | table_ab_loginlo | idx_loginIp_szTime         | 2021-03-01 15:12:55 | size         |         16 |        NULL | Number of pages in the index      |
	| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-03-01 15:12:55 | n_diff_pfx01 |        598 |           9 | nPlayerId                         |
	| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-03-01 15:12:55 | n_diff_pfx02 |       4492 |           9 | nPlayerId,Idx                     |
	| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-03-01 15:12:55 | n_leaf_pages |          9 |        NULL | Number of leaf pages in the index |
	| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_nPlayerId | 2021-03-01 15:12:55 | size         |         10 |        NULL | Number of pages in the index      |
	| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-03-01 15:12:55 | n_diff_pfx01 |       3849 |           6 | szTime                            |
	| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-03-01 15:12:55 | n_diff_pfx02 |       4492 |           6 | szTime,Idx                        |
	| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-03-01 15:12:55 | n_leaf_pages |          6 |        NULL | Number of leaf pages in the index |
	| aiuaiuh5_modb   | table_ab_loginlo | web_loginlog_idx_szTime    | 2021-03-01 15:12:55 | size         |          7 |        NULL | Number of pages in the index      |
	+---------------+--------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	16 rows in set (0.00 sec)

	mysql> show index from table_ab_loginlo;
	+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table              | Non_unique | Key_name                   | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_ab_loginlo   |          0 | PRIMARY                    |            1 | Idx         | A         |        4492 |     NULL | NULL   |      | BTREE      |         |               |
	| table_ab_loginlo   |          1 | web_loginlog_idx_nPlayerId |            1 | nPlayerId   | A         |         598 |     NULL | NULL   |      | BTREE      |         |               |
	| table_ab_loginlo   |          1 | web_loginlog_idx_szTime    |            1 | szTime      | A         |        3849 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_ab_loginlo   |          1 | idx_loginIp_szTime         |            1 | loginIp     | A         |         810 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_ab_loginlo   |          1 | idx_loginIp_szTime         |            2 | szTime      | A         |        3871 |     NULL | NULL   | YES  | BTREE      |         |               |
	+--------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	5 rows in set (0.00 sec)

	mysql> SELECT table_schema,table_name,data_length,index_length, DATA_FREE, table_rows  FROM information_schema.tables where table_schema='aiuaiuh5_modb' and TABLE_NAME='table_ab_loginlo';
	+--------------+--------------------+-------------+--------------+-----------+------------+
	| table_schema | table_name         | data_length | index_length | DATA_FREE | table_rows |
	+--------------+--------------------+-------------+--------------+-----------+------------+
	| aiuaiuh5_modb  | table_ab_loginlo |      327680 |       540672 |         0 |       4492 |
	+--------------+--------------------+-------------+--------------+-----------+------------+
	1 row in set (0.00 sec)


5. 举一反三
	
	select * from mysql.innodb_table_stats  where database_name='aiuaiuh5_modb' where last_update < DATE_SUB(NOW(), INTERVAL 3 DAY);

	把表统计信息的时间小于当前时间3天的，加入到监控中。
	
	估计是MySQL从库的1个bug，也就是主从复制的bug
	
	
	


			
			
			