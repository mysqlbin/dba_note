
0. 使用到的SQL语句列表
1. 基本信息
2. 删除部分数据产生碎片
3. 执行analyze table命令
4. alter table重建表
5. 小结

0. 使用到的SQL语句列表

	SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,data_free,table_rows FROM 
	information_schema.tables  where table_schema = 'aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	select * from information_schema.statistics where TABLE_SCHEMA='aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	select * from mysql.innodb_table_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	select * from mysql.innodb_index_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	show index from table_bbbbcccccorerobotaaaaail;


1. 基本信息

	CREATE TABLE `t1` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	  .................................................
	  `nChairID` int(11) DEFAULT '0' COMMENT '',
	  `szToken` varchar(64) DEFAULT NULL COMMENT '',
	  .................................................
	  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
	  .................................................
	  PRIMARY KEY (`ID`),
	  KEY `idx_szToken_nChairID` (`szToken`(28),`nChairID`),
	  KEY `idx_tEndTime` (`tEndTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=14471002 DEFAULT CHARSET=utf8mb4 COMMENT='';


	索引大小：1.34 GB (1,437,417,472)
	数据大小：2.34 GB (2,514,485,248)

	mysql> select count(*) from t1;
	+----------+
	| count(*) |
	+----------+
	| 14471001 |
	+----------+
	1 row in set (9.01 sec)


	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
		-> information_schema.tables  where table_schema = 'aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+--------------+--------------------------------+----------------+----------------+----------------+------------+
	| table_schema | table_name                     | data_mb        | index_mb       | all_mb         | table_rows |
	+--------------+--------------------------------+----------------+----------------+----------------+------------+
	| aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail | 2.517562866211 | 0.889450073242 | 3.407012939453 |   14285265 |
	+--------------+--------------------------------+----------------+----------------+----------------+------------+
	1 row in set (0.00 sec)

	mysql> select * from information_schema.statistics where TABLE_SCHEMA='aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME                     | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME           | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          0 | aiuaiuh8_db  | PRIMARY              |            1 | ID          | A         |    14285265 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            1 | szToken     | A         |     5534094 |       28 | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            2 | nChairID    | A         |    14285265 |     NULL | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_tEndTime         |            1 | tEndTime    | A         |      477112 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| database_name | table_name                     | last_update         | n_rows   | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | 2020-10-13 12:40:27 | 14285265 |               164991 |                    58291 |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	1 row in set (0.01 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name                     | index_name           | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 12:40:27 | n_diff_pfx01 |   14285265 |          20 | ID                                |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 12:40:27 | n_leaf_pages |     144150 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 12:40:27 | size         |     164991 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | n_diff_pfx01 |    5534094 |          20 | szToken                           |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | n_diff_pfx02 |   14435200 |          20 | szToken,nChairID                  |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | n_diff_pfx03 |   14435200 |          20 | szToken,nChairID,ID               |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | n_leaf_pages |      36088 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | size         |      41407 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 12:40:27 | n_diff_pfx01 |     477112 |          20 | tEndTime                          |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 12:40:27 | n_diff_pfx02 |   14456981 |          20 | tEndTime,ID                       |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 12:40:27 | n_leaf_pages |      14707 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 12:40:27 | size         |      16884 |        NULL | Number of pages in the index      |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.01 sec)


	mysql> show index from table_bbbbcccccorerobotaaaaail;
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table                          | Non_unique | Key_name             | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_bbbbcccccorerobotaaaaail |          0 | PRIMARY              |            1 | ID          | A         |    14285265 |     NULL | NULL   |      | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_szToken_nChairID |            1 | szToken     | A         |     5534094 |       28 | NULL   | YES  | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_szToken_nChairID |            2 | nChairID    | A         |    14285265 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_tEndTime         |            1 | tEndTime    | A         |      477112 |     NULL | NULL   | YES  | BTREE      |         |               |
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)


	shell> ll table_bbbbcccccorerobotaaaaail.ibd
	-rw-r----- 1 mysql mysql 3711959040 2020-10-13 12:40 table_bbbbcccccorerobotaaaaail.ibd
	shell> ls -lht table_bbbbcccccorerobotaaaaail.ibd
	-rw-r----- 1 mysql mysql 3.5G Oct 13 12:40 table_bbbbcccccorerobotaaaaail.ibd

2. 删除部分数据产生碎片

	--遍历40次
	delete from table_bbbbcccccorerobotaaaaail limit 10000; 



	mysql> select count(*) from table_bbbbcccccorerobotaaaaail;
	+----------+
	| count(*) |
	+----------+
	| 13971001 |
	+----------+
	1 row in set (2.28 sec)


	mysql> select 13971001+400000;
	+-----------------+
	| 13971001+400000 |
	+-----------------+
	|        14371001 |
	+-----------------+
	1 row in set (0.00 sec)


	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,data_free,table_rows FROM 
		-> information_schema.tables  where table_schema = 'aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	| table_schema | table_name                     | data_mb        | index_mb       | all_mb         | data_free | table_rows |
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	| aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail | 2.517562866211 | 0.889450073242 | 3.407012939453 | 100663296 |   13785265 |
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	1 row in set (0.00 sec)

	mysql> select * from information_schema.statistics where TABLE_SCHEMA='aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME                     | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME           | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          0 | aiuaiuh8_db  | PRIMARY              |            1 | ID          | A         |    13785265 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            1 | szToken     | A         |     5530082 |       28 | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            2 | nChairID    | A         |    13785265 |     NULL | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_tEndTime         |            1 | tEndTime    | A         |      476766 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| database_name | table_name                     | last_update         | n_rows   | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | 2020-10-13 12:40:27 | 14285265 |               164991 |                    58291 |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name                     | index_name           | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 12:40:27 | n_diff_pfx01 |   14285265 |          20 | ID                                |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 12:40:27 | n_leaf_pages |     144150 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 12:40:27 | size         |     164991 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | n_diff_pfx01 |    5534094 |          20 | szToken                           |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | n_diff_pfx02 |   14435200 |          20 | szToken,nChairID                  |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | n_diff_pfx03 |   14435200 |          20 | szToken,nChairID,ID               |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | n_leaf_pages |      36088 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 12:40:27 | size         |      41407 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 12:40:27 | n_diff_pfx01 |     477112 |          20 | tEndTime                          |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 12:40:27 | n_diff_pfx02 |   14456981 |          20 | tEndTime,ID                       |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 12:40:27 | n_leaf_pages |      14707 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 12:40:27 | size         |      16884 |        NULL | Number of pages in the index      |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)

	mysql> show index from table_bbbbcccccorerobotaaaaail;
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table                          | Non_unique | Key_name             | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_bbbbcccccorerobotaaaaail |          0 | PRIMARY              |            1 | ID          | A         |    13785265 |     NULL | NULL   |      | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_szToken_nChairID |            1 | szToken     | A         |     5530082 |       28 | NULL   | YES  | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_szToken_nChairID |            2 | nChairID    | A         |    13785265 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_tEndTime         |            1 | tEndTime    | A         |      476766 |     NULL | NULL   | YES  | BTREE      |         |               |
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)


	索引大小：910.80 MB (955,039,744)
	数据大小：2.52 GB (2,703,212,544)
	可用空间：96.00 MB (100,663,296)


3. 执行analyze table命令

	mysql> analyze table table_bbbbcccccorerobotaaaaail;
	+--------------------------------------------+---------+----------+----------+
	| Table                                      | Op      | Msg_type | Msg_text |
	+--------------------------------------------+---------+----------+----------+
	| aiuaiuh8_db.table_bbbbcccccorerobotaaaaail | analyze | status   | OK       |
	+--------------------------------------------+---------+----------+----------+
	1 row in set (0.37 sec)



	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,data_free,table_rows FROM 
		-> information_schema.tables  where table_schema = 'aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	| table_schema | table_name                     | data_mb        | index_mb       | all_mb         | data_free | table_rows |
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	| aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail | 2.444747924805 | 0.869216918945 | 3.313964843750 | 100663296 |   13782110 |
	+--------------+--------------------------------+----------------+----------------+----------------+-----------+------------+
	1 row in set (0.00 sec)

	mysql> select * from information_schema.statistics where TABLE_SCHEMA='aiuaiuh8_db' and table_name='table_bbbbcccccorerobotaaaaail';
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME                     | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME           | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          0 | aiuaiuh8_db  | PRIMARY              |            1 | ID          | A         |    13782110 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            1 | szToken     | A         |     5358750 |       28 | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_szToken_nChairID |            2 | nChairID    | A         |    13625243 |     NULL | NULL   | YES      | BTREE      |         |               |
	| def           | aiuaiuh8_db  | table_bbbbcccccorerobotaaaaail |          1 | aiuaiuh8_db  | idx_tEndTime         |            1 | tEndTime    | A         |      408816 |     NULL | NULL   | YES      | BTREE      |         |               |
	+---------------+--------------+--------------------------------+------------+--------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| database_name | table_name                     | last_update         | n_rows   | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | 2020-10-13 14:40:21 | 13782110 |               160219 |                    56965 |
	+---------------+--------------------------------+---------------------+----------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh8_db' and table_name = 'table_bbbbcccccorerobotaaaaail';
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name                     | index_name           | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 14:40:21 | n_diff_pfx01 |   13782110 |          20 | ID                                |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 14:40:21 | n_leaf_pages |     139354 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | PRIMARY              | 2020-10-13 14:40:21 | size         |     160219 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 14:40:21 | n_diff_pfx01 |    5358750 |          20 | szToken                           |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 14:40:21 | n_diff_pfx02 |   13625242 |          20 | szToken,nChairID                  |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 14:40:21 | n_diff_pfx03 |   13942513 |          20 | szToken,nChairID,ID               |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 14:40:21 | n_leaf_pages |      34865 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_szToken_nChairID | 2020-10-13 14:40:21 | size         |      40561 |        NULL | Number of pages in the index      |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 14:40:21 | n_diff_pfx01 |     408816 |          20 | tEndTime                          |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 14:40:21 | n_diff_pfx02 |   13957617 |          20 | tEndTime,ID                       |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 14:40:21 | n_leaf_pages |      14199 |        NULL | Number of leaf pages in the index |
	| aiuaiuh8_db   | table_bbbbcccccorerobotaaaaail | idx_tEndTime         | 2020-10-13 14:40:21 | size         |      16404 |        NULL | Number of pages in the index      |
	+---------------+--------------------------------+----------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	12 rows in set (0.00 sec)

	mysql> show index from table_bbbbcccccorerobotaaaaail;
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table                          | Non_unique | Key_name             | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_bbbbcccccorerobotaaaaail |          0 | PRIMARY              |            1 | ID          | A         |    13782110 |     NULL | NULL   |      | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_szToken_nChairID |            1 | szToken     | A         |     5358750 |       28 | NULL   | YES  | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_szToken_nChairID |            2 | nChairID    | A         |    13625243 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_tEndTime         |            1 | tEndTime    | A         |      408816 |     NULL | NULL   | YES  | BTREE      |         |               |
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)

	shell> ls -lht table_bbbbcccccorerobotaaaaail.ibd
	-rw-r----- 1 mysql mysql 3.5G Oct 13 14:33 table_bbbbcccccorerobotaaaaail.ibd
	shell> ll table_bbbbcccccorerobotaaaaail.ibd
	-rw-r----- 1 mysql mysql 3711959040 2020-10-13 14:33 table_bbbbcccccorerobotaaaaail.ibd

4. alter table重建表
	
	mysql> alter table table_clubgamescorerobotdetail engine=InnoDB;
	Query OK, 0 rows affected (12 min 47.98 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	shell> ls -lht table_clubgamescorerobotdetail.ibd 
	-rw-r----- 1 mysql mysql 3.4G Oct 13 15:21 table_clubgamescorerobotdetail.ibd
	shell> ll  table_clubgamescorerobotdetail.ibd 
	-rw-r----- 1 mysql mysql 3590324224 2020-10-13 15:21 table_clubgamescorerobotdetail.ibd

	
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

	mysql> show index from table_bbbbcccccorerobotaaaaail;
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table                          | Non_unique | Key_name             | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_bbbbcccccorerobotaaaaail |          0 | PRIMARY              |            1 | ID          | A         |    13809981 |     NULL | NULL   |      | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_szToken_nChairID |            1 | szToken     | A         |     5551913 |       28 | NULL   | YES  | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_szToken_nChairID |            2 | nChairID    | A         |    13809981 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_bbbbcccccorerobotaaaaail |          1 | idx_tEndTime         |            1 | tEndTime    | A         |      403166 |     NULL | NULL   | YES  | BTREE      |         |               |
	+--------------------------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	4 rows in set (0.00 sec)

5. 小结

	未执行删除部分数据：
		shell> ll table_bbbbcccccorerobotaaaaail.ibd
		-rw-r----- 1 mysql mysql 3711959040 2020-10-13 12:40 table_bbbbcccccorerobotaaaaail.ibd
		shell> ls -lht table_bbbbcccccorerobotaaaaail.ibd
		-rw-r----- 1 mysql mysql 3.5G Oct 13 12:40 table_bbbbcccccorerobotaaaaail.ibd
		
	删除部分数据后执行analyze table命令：
		shell> ls -lht table_bbbbcccccorerobotaaaaail.ibd
		-rw-r----- 1 mysql mysql 3.5G Oct 13 14:33 table_bbbbcccccorerobotaaaaail.ibd
		shell> ll table_bbbbcccccorerobotaaaaail.ibd
		-rw-r----- 1 mysql mysql 3711959040 2020-10-13 14:33 table_bbbbcccccorerobotaaaaail.ibd
		
	alter table重建表：
		shell> ls -lht table_clubgamescorerobotdetail.ibd 
		-rw-r----- 1 mysql mysql 3.4G Oct 13 15:21 table_clubgamescorerobotdetail.ibd
		shell> ll  table_clubgamescorerobotdetail.ibd 
		-rw-r----- 1 mysql mysql 3590324224 2020-10-13 15:21 table_clubgamescorerobotdetail.ibd

	
	可以看到，执行analyze table命令并不会回收二级索引的碎片。
	
	


