
1. 需要用到的SQL语句
2. 表结构 
3. 数据量大小和索引的统计信息
4. 修改字段名称的耗时和查看是否修改了索引统计信息
5. 小结

1. 需要用到的SQL语句
	SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,data_free,table_rows FROM 
	information_schema.tables  where table_schema = 'aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	select * from information_schema.statistics where TABLE_SCHEMA='aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	select * from mysql.innodb_table_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	select * from mysql.innodb_index_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';


2. 表结构 

	CREATE TABLE `table_bbbbcccccorerobotaaaaail` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	 
	  `nTax_2` int(11) DEFAULT '0' COMMENT '',
	 ......................................................
	  PRIMARY KEY (`ID`),
	  KEY `idx_token_nChairID` (`token`(28),`nChairID`),
	  KEY `idx_tEndTime` (`tEndTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=14471002 DEFAULT CHARSET=utf8mb4 COMMENT='）';




3. 数据量大小和索引的统计信息

	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,data_free,table_rows FROM 
		-> information_schema.tables  where table_schema = 'aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	| table_schema | table_name                     | data_mb        | index_mb       | all_mb         | data_free | table_rows |
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	| aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail | 2.433578491211 | 0.859161376953 | 3.292739868164 |   4194304 |   13809981 |
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	1 row in set (0.00 sec)

	mysql> select * from information_schema.statistics where TABLE_SCHEMA='aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME                     | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME           | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          0 | aiuaiuh8_db  | PRIMARY              |            1 | ID          | A         |    13809981 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            1 | szToken     | A         |     5551913 |       28 | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            2 | nChairID    | A         |    13809981 |     NULL | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_tEndTime         |            1 | tEndTime    | A         |      403166 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| database_name | table_name                     | last_update         | n_rows   | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | 2020-10-13 15:21:49 | 13809981 |               159487 |                    56306 |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name                     | index_name           | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 15:21:49 | n_diff_pfx01 |   13809981 |          20 | ID                                |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 15:21:49 | n_leaf_pages |     139354 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 15:21:49 | size         |     159487 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | n_diff_pfx01 |    5551913 |          20 | szToken                           |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | n_diff_pfx02 |   13936400 |          20 | szToken,nChairID                  |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | n_diff_pfx03 |   13936400 |          20 | szToken,nChairID,ID               |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | n_leaf_pages |      34841 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | size         |      39999 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 15:21:49 | n_diff_pfx01 |     403166 |          20 | tEndTime                          |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 15:21:49 | n_diff_pfx02 |   13957617 |          20 | tEndTime,ID                       |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 15:21:49 | n_leaf_pages |      14199 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 15:21:49 | size         |      16307 |        NULL | Number of pages in the index      |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)




4. 修改字段名称的耗时和查看是否修改了索引统计信息


	查看修改字段名称之前的frm表结构什么时候发生改变
		shell> ls -lht table_bbbbcccccorerobotaaaaail.frm 
		-rw-r----- 1 mysql mysql 9.7K Oct 19 17:47 table_bbbbcccccorerobotaaaaail.frm
	
	
	mysql> alter table table_bbbbcccccorerobotaaaaail change nTax_2 nTax int(11) DEFAULT '0' COMMENT '';
	Query OK, 0 rows affected (0.07 sec)
	Records: 0  Duplicates: 0  Warnings: 0


	shell> date
	Mon Oct 19 18:00:06 CST 2020
	
	shell> ls -lht table_bbbbcccccorerobotaaaaail.frm 
	-rw-r----- 1 mysql mysql 9.7K Oct 19 18:06 table_bbbbcccccorerobotaaaaail.frm


	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,data_free,table_rows FROM 
		-> information_schema.tables  where table_schema = 'aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	| table_schema | table_name                     | data_mb        | index_mb       | all_mb         | data_free | table_rows |
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	| aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail | 2.433578491211 | 0.859161376953 | 3.292739868164 |   4194304 |   13809981 |
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	1 row in set (0.00 sec)

	mysql> select * from information_schema.statistics where TABLE_SCHEMA='aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME                     | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME           | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          0 | aiuaiuh8_db  | PRIMARY              |            1 | ID          | A         |    13809981 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            1 | szToken     | A         |     5551913 |       28 | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            2 | nChairID    | A         |    13809981 |     NULL | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_tEndTime         |            1 | tEndTime    | A         |      403166 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| database_name | table_name                     | last_update         | n_rows   | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | 2020-10-13 15:21:49 | 13809981 |               159487 |                    56306 |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name                     | index_name           | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 15:21:49 | n_diff_pfx01 |   13809981 |          20 | ID                                |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 15:21:49 | n_leaf_pages |     139354 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 15:21:49 | size         |     159487 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | n_diff_pfx01 |    5551913 |          20 | szToken                           |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | n_diff_pfx02 |   13936400 |          20 | szToken,nChairID                  |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | n_diff_pfx03 |   13936400 |          20 | szToken,nChairID,ID               |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | n_leaf_pages |      34841 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 15:21:49 | size         |      39999 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 15:21:49 | n_diff_pfx01 |     403166 |          20 | tEndTime                          |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 15:21:49 | n_diff_pfx02 |   13957617 |          20 | tEndTime,ID                       |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 15:21:49 | n_leaf_pages |      14199 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 15:21:49 | size         |      16307 |        NULL | Number of pages in the index      |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)


5. 小结
	修改表字段名称并不会重建表。
	
	