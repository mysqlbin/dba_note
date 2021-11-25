
1. 当前表只有一个索引 
2. 需要执行的语句
3. 默认的信息	
4. 删除表的索引
5. analyze table 
6. 小结

1. 当前表只有一个索引 

	CREATE TABLE `table_abcgamebbbbbbabtail_history` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	  ............................................
	  PRIMARY KEY (`ID`),
	  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=94336090 DEFAULT CHARSET=utf8mb4 COMMENT='';


2. 需要执行的语句

	select now();

	SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
	information_schema.tables  where table_schema = 'lialia_db' and table_name='table_abcgamebbbbbbabtail_history';

	select * from information_schema.statistics where TABLE_SCHEMA='lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	select * from mysql.innodb_table_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
	select * from mysql.innodb_index_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
		
3. 默认的信息	

	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
		-> information_schema.tables  where table_schema = 'lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	 = 'table_abcgamebbbbbbabtail_history';
	select * from mysql.innodb_index_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
		| table_schema | table_name                        | data_mb        | index_mb       | all_mb         | table_rows |
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	| lialia_db    | table_abcgamebbbbbbabtail_history | 2.206039428711 | 0.188232421875 | 2.394271850586 |    9947227 |
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	1 row in set (0.00 sec)

	mysql> select * from information_schema.statistics where TABLE_SCHEMA='lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	+---------------+--------------+-----------------------------------+------------+--------------+------------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME                        | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME             | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+-----------------------------------+------------+--------------+------------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | lialia_db    | table_abcgamebbbbbbabtail_history |          0 | lialia_db    | PRIMARY                |            1 | ID          | A         |     9947227 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | lialia_db    | table_abcgamebbbbbbabtail_history |          1 | lialia_db    | idx_nGameType_tEndTime |            1 | nGameType   | A         |          30 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | lialia_db    | table_abcgamebbbbbbabtail_history |          1 | lialia_db    | idx_nGameType_tEndTime |            2 | tEndTime    | A         |     8572025 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+-----------------------------------+------------+--------------+------------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	3 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name                        | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	| lialia_db     | table_abcgamebbbbbbabtail_history | 2020-07-24 16:55:16 | 9947227 |               144575 |                    12336 |
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
	+---------------+-----------------------------------+------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name                        | index_name             | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+-----------------------------------+------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY                | 2020-07-24 16:55:16 | n_diff_pfx01 |    9947227 |          20 | ID                                |
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY                | 2020-07-24 16:55:16 | n_leaf_pages |     126314 |        NULL | Number of leaf pages in the index |
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY                | 2020-07-24 16:55:16 | size         |     144575 |        NULL | Number of pages in the index      |
	| lialia_db     | table_abcgamebbbbbbabtail_history | idx_nGameType_tEndTime | 2020-07-24 16:55:16 | n_diff_pfx01 |         30 |          20 | nGameType                         |
	| lialia_db     | table_abcgamebbbbbbabtail_history | idx_nGameType_tEndTime | 2020-07-24 16:55:16 | n_diff_pfx02 |    8572025 |          20 | nGameType,tEndTime                |
	| lialia_db     | table_abcgamebbbbbbabtail_history | idx_nGameType_tEndTime | 2020-07-24 16:55:16 | n_diff_pfx03 |    9990279 |          20 | nGameType,tEndTime,ID             |
	| lialia_db     | table_abcgamebbbbbbabtail_history | idx_nGameType_tEndTime | 2020-07-24 16:55:16 | n_leaf_pages |      10777 |        NULL | Number of leaf pages in the index |
	| lialia_db     | table_abcgamebbbbbbabtail_history | idx_nGameType_tEndTime | 2020-07-24 16:55:16 | size         |      12336 |        NULL | Number of pages in the index      |
	+---------------+-----------------------------------+------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	8 rows in set (0.00 sec)

4. 删除表的索引

	alter table table_abcgamebbbbbbabtail_history drop index `idx_nGameType_tEndTime`;


	mysql> alter table table_abcgamebbbbbbabtail_history drop index `idx_nGameType_tEndTime`;
	Query OK, 0 rows affected (0.01 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	mysql> select now();
	+---------------------+
	| now()               |
	+---------------------+
	| 2020-07-24 17:35:38 |
	+---------------------+
	1 row in set (0.00 sec)
	
	--------------------------------------
	
	
	+---------------------+
	| now()               |
	+---------------------+
	| 2020-07-24 17:36:59 |
	+---------------------+
	1 row in set (0.00 sec)

	mysql> 
	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
		-> information_schema.tables  where table_schema = 'lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	| table_schema | table_name                        | data_mb        | index_mb       | all_mb         | table_rows |
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	| lialia_db    | table_abcgamebbbbbbabtail_history | 2.206039428711 | 0.188232421875 | 2.394271850586 |    9947227 |
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	1 row in set (0.00 sec)

	mysql> 
	mysql> select * from information_schema.statistics where TABLE_SCHEMA='lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	+---------------+--------------+-----------------------------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME                        | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+-----------------------------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | lialia_db    | table_abcgamebbbbbbabtail_history |          0 | lialia_db    | PRIMARY    |            1 | ID          | A         |     9947227 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+-----------------------------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name                        | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	| lialia_db     | table_abcgamebbbbbbabtail_history | 2020-07-24 16:55:16 | 9947227 |               144575 |                    12336 |
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
	+---------------+-----------------------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name                        | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+-----------------------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY    | 2020-07-24 16:55:16 | n_diff_pfx01 |    9947227 |          20 | ID                                |
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY    | 2020-07-24 16:55:16 | n_leaf_pages |     126314 |        NULL | Number of leaf pages in the index |
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY    | 2020-07-24 16:55:16 | size         |     144575 |        NULL | Number of pages in the index      |
	+---------------+-----------------------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	3 rows in set (0.00 sec)


	
5. analyze table 

	select now();
	analyze table table_abcgamebbbbbbabtail_history;
	SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
	information_schema.tables  where table_schema = 'lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	select * from information_schema.statistics where TABLE_SCHEMA='lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	select * from mysql.innodb_table_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
	select * from mysql.innodb_index_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';

	
	mysql> select now();
	+---------------------+
	| now()               |
	+---------------------+
	| 2020-07-24 17:38:57 |
	+---------------------+
	1 row in set (0.00 sec)

	mysql> analyze table table_abcgamebbbbbbabtail_history;
	+---------------------------------------------+---------+----------+----------+
	| Table                                       | Op      | Msg_type | Msg_text |
	+---------------------------------------------+---------+----------+----------+
	| lialia_db.table_abcgamebbbbbbabtail_history | analyze | status   | OK       |
	+---------------------------------------------+---------+----------+----------+
	1 row in set (0.01 sec)

	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
		-> information_schema.tables  where table_schema = 'lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	| table_schema | table_name                        | data_mb        | index_mb       | all_mb         | table_rows |
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	| lialia_db    | table_abcgamebbbbbbabtail_history | 2.206039428711 | 0.000000000000 | 2.206039428711 |    9896701 |
	+--------------+-----------------------------------+----------------+----------------+----------------+------------+
	1 row in set (0.00 sec)

	mysql> select * from information_schema.statistics where TABLE_SCHEMA='lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
	+---------------+--------------+-----------------------------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME                        | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+-----------------------------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | lialia_db    | table_abcgamebbbbbbabtail_history |          0 | lialia_db    | PRIMARY    |            1 | ID          | A         |     9896701 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+-----------------------------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name                        | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	| lialia_db     | table_abcgamebbbbbbabtail_history | 2020-07-24 17:38:57 | 9896701 |               144575 |                        0 |
	+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
	+---------------+-----------------------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name                        | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+-----------------------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY    | 2020-07-24 17:38:57 | n_diff_pfx01 |    9896701 |          20 | ID                                |
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY    | 2020-07-24 17:38:57 | n_leaf_pages |     126314 |        NULL | Number of leaf pages in the index |
	| lialia_db     | table_abcgamebbbbbbabtail_history | PRIMARY    | 2020-07-24 17:38:57 | size         |     144575 |        NULL | Number of pages in the index      |
	+---------------+-----------------------------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	3 rows in set (0.00 sec)


6. 小结
	
	删除索引不会重建表，也不会修改索引的统计信息。

	analyze table 会更新 information_schema.tables 中的 index_length 字段值。
		
	analyze table 命令是立即生效的。
	
	
	