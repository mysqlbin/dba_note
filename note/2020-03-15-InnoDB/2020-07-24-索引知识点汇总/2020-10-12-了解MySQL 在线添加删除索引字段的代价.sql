
			
1. 环境	
2. 添加索引	
3. 删除索引
4. 添加字段
5. 删除字段
6. 验证添加列之后是否会修改索引的统计信息
7. 验证 analyze table 命令是否会修改.ibd文件
8. 小结
	
1. 环境	
	CREATE TABLE `sbtest2` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `k` int(10) unsigned NOT NULL DEFAULT '0',
	  `c` char(120) NOT NULL DEFAULT '',
	  `pad` char(60) NOT NULL DEFAULT '',
	  PRIMARY KEY (`id`),
	  KEY `k_2` (`k`)
	) ENGINE=InnoDB AUTO_INCREMENT=500001 DEFAULT CHARSET=utf8mb4 MAX_ROWS=1000000;
	
	mysql>select count(*) from sbtest2;
	+----------+
	| count(*) |
	+----------+
	|   500000 |
	+----------+
	1 row in set (0.10 sec)


	索引长度：7.52 MB (7,880,704)
	数据长度：122.63 MB (128,581,632)


2. 添加索引	
	
	mysql>select * from information_schema.statistics where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | sbtest       | sbtest2    |          0 | sbtest       | PRIMARY    |            1 | id          | A         |      493010 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | sbtest       | sbtest2    |          1 | sbtest       | k_2        |            1 | k           | A         |       79518 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	mysql>select * from mysql.innodb_table_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| sbtest        | sbtest2    | 2020-09-12 21:40:51 | 493010 |                 8104 |                      481 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.01 sec)

	mysql>select * from mysql.innodb_index_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_diff_pfx01 |     493010 |          20 | id                                |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_leaf_pages |       7043 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | size         |       8104 |        NULL | Number of pages in the index      |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx01 |      79518 |          20 | k                                 |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx02 |     500032 |          20 | k,id                              |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_leaf_pages |        416 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | size         |        481 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)

	mysql>show index from sbtest2;
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table   | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| sbtest2 |          0 | PRIMARY  |            1 | id          | A         |      493010 |     NULL | NULL   |      | BTREE      |         |               |
	| sbtest2 |          1 | k_2      |            1 | k           | A         |       79518 |     NULL | NULL   |      | BTREE      |         |               |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)
		

	-- 添加索引
	mysql>alter table sbtest2 add index idx_c(`c`);
	Query OK, 0 rows affected (26.17 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	期间的运行状态
		shell> ll
		total 204840
		-rw-r----- 1 mysql mysql        67 Mar 30 10:15 db.opt
		-rw-r----- 1 mysql mysql      8606 Mar 30 19:53 sbtest1.frm
		-rw-r----- 1 mysql mysql  62914560 Mar 30 19:54 sbtest1.ibd
		-rw-r----- 1 mysql mysql      8632 Sep 12 19:13 sbtest2.frm
		-rw-r----- 1 mysql mysql 146800640 Sep 12 19:17 sbtest2.ibd
		-rw-r----- 1 mysql mysql      8632 Sep 12 19:17 #sql-9e3_24.frm

		shell> iostat -dmx 1
		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00   321.28    0.00  426.60     0.00    17.68    84.86     2.07    4.79    0.00    4.79   2.42 103.19
		dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-2              0.00     0.00    0.00  692.55     0.00    17.67    52.27    24.81   35.79    0.00   35.79   1.49 103.19

		.........................................................................................................................

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00   390.53    0.00  382.11     0.00    22.81   122.26     1.86    5.37    0.00    5.37   2.69 102.84
		dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-2              0.00     0.00    0.00  744.21     0.00    22.58    62.14    12.07   18.13    0.00   18.13   1.38 102.84

		.........................................................................................................................

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    0.00   20.20     0.00     0.21    21.25     0.03    1.45    0.00    1.45   1.35   2.73
		dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-2              0.00     0.00    0.00   15.15     0.00     0.21    28.33     0.03    1.93    0.00    1.93   1.80   2.73

	
	mysql>select * from information_schema.statistics where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | sbtest       | sbtest2    |          0 | sbtest       | PRIMARY    |            1 | id          | A         |      493010 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | sbtest       | sbtest2    |          1 | sbtest       | k_2        |            1 | k           | A         |       79518 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | sbtest       | sbtest2    |          1 | sbtest       | idx_c      |            1 | c           | A         |      493010 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	3 rows in set (0.00 sec)

	mysql>select * from mysql.innodb_table_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| sbtest        | sbtest2    | 2020-09-12 21:47:41 | 493010 |                 8104 |                      481 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql>select * from mysql.innodb_index_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_diff_pfx01 |     493010 |          20 | id                                |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_leaf_pages |       7043 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | size         |       8104 |        NULL | Number of pages in the index      |
	| sbtest        | sbtest2    | idx_c      | 2020-09-12 21:47:41 | n_diff_pfx01 |     496059 |          20 | c                                 |
	| sbtest        | sbtest2    | idx_c      | 2020-09-12 21:47:41 | n_diff_pfx02 |     496059 |          20 | c,id                              |
	| sbtest        | sbtest2    | idx_c      | 2020-09-12 21:47:41 | n_leaf_pages |       4033 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | idx_c      | 2020-09-12 21:47:41 | size         |       4735 |        NULL | Number of pages in the index      |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx01 |      79518 |          20 | k                                 |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx02 |     500032 |          20 | k,id                              |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_leaf_pages |        416 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | size         |        481 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	11 rows in set (0.01 sec)

	mysql>show index from sbtest2;
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table   | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| sbtest2 |          0 | PRIMARY  |            1 | id          | A         |      493010 |     NULL | NULL   |      | BTREE      |         |               |
	| sbtest2 |          1 | k_2      |            1 | k           | A         |       79518 |     NULL | NULL   |      | BTREE      |         |               |
	| sbtest2 |          1 | idx_c    |            1 | c           | A         |      493010 |     NULL | NULL   |      | BTREE      |         |               |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	3 rows in set (0.00 sec)

	MySQL建立二级索引的工作机制：扫描主键索引，根据 (c,id) 的值生成一棵B+树。
	
	
	
3. 删除索引

	mysql>select * from information_schema.statistics where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | sbtest       | sbtest2    |          0 | sbtest       | PRIMARY    |            1 | id          | A         |      493010 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | sbtest       | sbtest2    |          1 | sbtest       | k_2        |            1 | k           | A         |       79518 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | sbtest       | sbtest2    |          1 | sbtest       | idx_c      |            1 | c           | A         |      493010 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	3 rows in set (0.00 sec)

	mysql>select * from mysql.innodb_table_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| sbtest        | sbtest2    | 2020-09-12 21:47:41 | 493010 |                 8104 |                      481 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql>select * from mysql.innodb_index_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_diff_pfx01 |     493010 |          20 | id                                |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_leaf_pages |       7043 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | size         |       8104 |        NULL | Number of pages in the index      |
	| sbtest        | sbtest2    | idx_c      | 2020-09-12 21:47:41 | n_diff_pfx01 |     496059 |          20 | c                                 |
	| sbtest        | sbtest2    | idx_c      | 2020-09-12 21:47:41 | n_diff_pfx02 |     496059 |          20 | c,id                              |
	| sbtest        | sbtest2    | idx_c      | 2020-09-12 21:47:41 | n_leaf_pages |       4033 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | idx_c      | 2020-09-12 21:47:41 | size         |       4735 |        NULL | Number of pages in the index      |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx01 |      79518 |          20 | k                                 |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx02 |     500032 |          20 | k,id                              |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_leaf_pages |        416 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | size         |        481 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	11 rows in set (0.01 sec)

	mysql>show index from sbtest2;
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table   | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| sbtest2 |          0 | PRIMARY  |            1 | id          | A         |      493010 |     NULL | NULL   |      | BTREE      |         |               |
	| sbtest2 |          1 | k_2      |            1 | k           | A         |       79518 |     NULL | NULL   |      | BTREE      |         |               |
	| sbtest2 |          1 | idx_c    |            1 | c           | A         |      493010 |     NULL | NULL   |      | BTREE      |         |               |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	3 rows in set (0.00 sec)
	
	
	mysql> alter table sbtest2 drop index idx_c;
	Query OK, 0 rows affected (0.12 sec)
	Records: 0  Duplicates: 0  Warnings: 0
	
	思考：为什么删除索引耗时很短？
		基本上都是秒删。
		
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
		
		mysql> alter table t1 drop index idx_tEndTime;
		Query OK, 0 rows affected (0.28 sec)
		Records: 0  Duplicates: 0  Warnings: 0
		
			索引大小：1.34 GB (1,437,417,472)
			mysql> analyze table t1;
			+--------------------------------------------+---------+----------+----------+
			| Table                                      | Op      | Msg_type | Msg_text |
			+--------------------------------------------+---------+----------+----------+
			| niuniuh5_db.t1							 | analyze | status   | OK       |
			+--------------------------------------------+---------+----------+----------+
			1 row in set (1.14 sec)
				索引大小：1.07 GB (1,150,287,872)
				
		shell> iostat -dmx 1
			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00    16.00    3.00   15.00     0.05     0.12    19.11     0.08    4.67   11.00    3.40   4.61   8.30

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00    28.00   16.00    5.00     0.21     0.13    33.52     0.28   13.33   13.94   11.40  11.67  24.50

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     5.00    0.00   59.00     0.00     1.12    38.92     0.44    7.46    0.00    7.46   7.15  42.20

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     2.00    0.00    9.00     0.00     0.04     9.78     0.09   10.33    0.00   10.33  10.22   9.20

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     3.00    0.00   12.00     0.00     0.06    10.00     0.11    9.00    0.00    9.00   9.00  10.80

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     9.00    0.00   25.00     0.00     0.25    20.80     0.20    8.12    0.00    8.12   7.56  18.90

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    8.00     0.00     0.03     8.00     0.06    7.38    0.00    7.38   7.25   5.80

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     8.00    0.00   13.00     0.00     0.08    12.92     0.08    6.46    0.00    6.46   6.46   8.40

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     6.00    0.00    5.00     0.00     0.04    17.60     0.13   26.60    0.00   26.60  26.60  13.30

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     2.00    0.00   28.00     0.00     0.21    15.43     0.19    6.89    0.00    6.89   6.79  19.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    8.00     0.00     0.03     8.00     0.05    6.25    0.00    6.25   6.25   5.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
					
	mysql>select * from information_schema.statistics where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | sbtest       | sbtest2    |          0 | sbtest       | PRIMARY    |            1 | id          | A         |      493010 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | sbtest       | sbtest2    |          1 | sbtest       | k_2        |            1 | k           | A         |       79518 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	mysql>select * from mysql.innodb_table_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| sbtest        | sbtest2    | 2020-09-12 21:47:41 | 493010 |                 8104 |                      481 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql>select * from mysql.innodb_index_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_diff_pfx01 |     493010 |          20 | id                                |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_leaf_pages |       7043 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | size         |       8104 |        NULL | Number of pages in the index      |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx01 |      79518 |          20 | k                                 |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx02 |     500032 |          20 | k,id                              |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_leaf_pages |        416 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | size         |        481 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)

	mysql>show index from sbtest2;
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table   | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| sbtest2 |          0 | PRIMARY  |            1 | id          | A         |      493010 |     NULL | NULL   |      | BTREE      |         |               |
	| sbtest2 |          1 | k_2      |            1 | k           | A         |       79518 |     NULL | NULL   |      | BTREE      |         |               |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)


	

4. 添加字段

	mysql> alter table sbtest2  add column d int(10) not null;
	Query OK, 0 rows affected (23.36 sec)
	Records: 0  Duplicates: 0  Warnings: 0
	
	期间的运行状态
		shell> ll
		total 339992
		-rw-r----- 1 mysql mysql        67 Mar 30 10:15 db.opt
		-rw-r----- 1 mysql mysql      8606 Mar 30 19:53 sbtest1.frm
		-rw-r----- 1 mysql mysql  62914560 Mar 30 19:54 sbtest1.ibd
		-rw-r----- 1 mysql mysql      8632 Sep 12 19:19 sbtest2.frm
		-rw-r----- 1 mysql mysql 222298112 Sep 12 19:19 sbtest2.ibd
		-rw-r----- 1 mysql mysql      8656 Sep 12 19:20 #sql-9e3_24.frm
		-rw-r----- 1 mysql mysql  62914560 Sep 12 19:20 #sql-ib305-654917964.ibd

	-- 添加字段会重建表，修改的是主键索引，因为主键索引的叶子存储的是整行记录。
	

5. 删除字段

	mysql> alter table sbtest2  drop column d;
	Query OK, 0 rows affected (22.09 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	期间的运行状态
		shell> ll
		total 239656
		-rw-r----- 1 mysql mysql        67 Mar 30 10:15 db.opt
		-rw-r----- 1 mysql mysql      8606 Mar 30 19:53 sbtest1.frm
		-rw-r----- 1 mysql mysql  62914560 Mar 30 19:54 sbtest1.ibd
		-rw-r----- 1 mysql mysql      8656 Sep 12 21:34 sbtest2.frm
		-rw-r----- 1 mysql mysql 150994944 Sep 12 21:34 sbtest2.ibd
		-rw-r----- 1 mysql mysql      8632 Sep 12 21:35 #sql-9e3_24.frm
		-rw-r----- 1 mysql mysql  31457280 Sep 12 21:35 #sql-ib308-654917970.ibd
	-- 添加字段也会重建表，修改的是主键索引，因为主键索引的叶子存储的是整行记录。

	
6. 验证添加列之后是否会修改索引的统计信息

	估计是会的。
	select * from information_schema.statistics where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	select * from mysql.innodb_table_stats  where database_name='sbtest' and table_name = 'sbtest2';
	select * from mysql.innodb_index_stats  where database_name='sbtest' and table_name = 'sbtest2';
	show index from sbtest2;
	
	mysql>select * from information_schema.statistics where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | sbtest       | sbtest2    |          0 | sbtest       | PRIMARY    |            1 | id          | A         |      493200 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | sbtest       | sbtest2    |          1 | sbtest       | k_2        |            1 | k           | A         |       89086 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	mysql>select * from mysql.innodb_table_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| sbtest        | sbtest2    | 2020-09-12 21:35:27 | 493200 |                 7848 |                      481 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.06 sec)

	mysql>select * from mysql.innodb_index_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:35:27 | n_diff_pfx01 |     493200 |          20 | id                                |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:35:27 | n_leaf_pages |       6850 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:35:27 | size         |       7848 |        NULL | Number of pages in the index      |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:35:27 | n_diff_pfx01 |      89086 |          20 | k                                 |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:35:27 | n_diff_pfx02 |     500032 |          20 | k,id                              |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:35:27 | n_leaf_pages |        416 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:35:27 | size         |        481 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.02 sec)

	mysql>show index from sbtest2;
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table   | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| sbtest2 |          0 | PRIMARY  |            1 | id          | A         |      493200 |     NULL | NULL   |      | BTREE      |         |               |
	| sbtest2 |          1 | k_2      |            1 | k           | A         |       89086 |     NULL | NULL   |      | BTREE      |         |               |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)
	

	
	--添加字段
	mysql>alter table sbtest2  add column d int(10) not null;
	Query OK, 0 rows affected (24.29 sec)
	Records: 0  Duplicates: 0  Warnings: 0
	
	mysql>select * from information_schema.statistics where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	| def           | sbtest       | sbtest2    |          0 | sbtest       | PRIMARY    |            1 | id          | A         |      493010 |     NULL | NULL   |          | BTREE      |         |               |
	| def           | sbtest       | sbtest2    |          1 | sbtest       | k_2        |            1 | k           | A         |       79518 |     NULL | NULL   |          | BTREE      |         |               |
	+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
	2 rows in set (0.00 sec)

	mysql>select * from mysql.innodb_table_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| sbtest        | sbtest2    | 2020-09-12 21:40:51 | 493010 |                 8104 |                      481 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	mysql>select * from mysql.innodb_index_stats  where database_name='sbtest' and table_name = 'sbtest2';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_diff_pfx01 |     493010 |          20 | id                                |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | n_leaf_pages |       7043 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | PRIMARY    | 2020-09-12 21:40:51 | size         |       8104 |        NULL | Number of pages in the index      |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx01 |      79518 |          20 | k                                 |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_diff_pfx02 |     500032 |          20 | k,id                              |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | n_leaf_pages |        416 |        NULL | Number of leaf pages in the index |
	| sbtest        | sbtest2    | k_2        | 2020-09-12 21:40:51 | size         |        481 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)

	mysql>show index from sbtest2;
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table   | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| sbtest2 |          0 | PRIMARY  |            1 | id          | A         |      493010 |     NULL | NULL   |      | BTREE      |         |               |
	| sbtest2 |          1 | k_2      |            1 | k           | A         |       79518 |     NULL | NULL   |      | BTREE      |         |               |
	+---------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)	
		
	
	
7. 验证 analyze table 命令是否会修改.ibd文件
	[root@env27 sbtest]# ll
	total 204828
	-rw-r----- 1 mysql mysql        67 Mar 30 10:15 db.opt
	-rw-r----- 1 mysql mysql      8606 Mar 30 19:53 sbtest1.frm
	-rw-r----- 1 mysql mysql  62914560 Mar 30 19:54 sbtest1.ibd
	-rw-r----- 1 mysql mysql      8632 Sep 12 19:29 sbtest2.frm
	-rw-r----- 1 mysql mysql 146800640 Sep 12 19:29 sbtest2.ibd


	mysql>analyze table sbtest2;
	+----------------+---------+----------+----------+
	| Table          | Op      | Msg_type | Msg_text |
	+----------------+---------+----------+----------+
	| sbtest.sbtest2 | analyze | status   | OK       |
	+----------------+---------+----------+----------+

	[root@env27 sbtest]# ll
	total 204828
	-rw-r----- 1 mysql mysql        67 Mar 30 10:15 db.opt
	-rw-r----- 1 mysql mysql      8606 Mar 30 19:53 sbtest1.frm
	-rw-r----- 1 mysql mysql  62914560 Mar 30 19:54 sbtest1.ibd
	-rw-r----- 1 mysql mysql      8632 Sep 12 19:29 sbtest2.frm
	-rw-r----- 1 mysql mysql 146800640 Sep 12 19:29 sbtest2.ibd

	analyze table 命令并不会修改 .ibd文件。


8. 小结

	添加/删除索引不会重建表，也不会修改索引的统计信息，添加索引会在 innodb_index_stats中产生新增索引的信息。
	analyze table 命令并不会修改 .ibd文件，只是更新了索引的统计信息，所以执行速度很快。
	
	
	
---------------------------------------------------------------------------------------



https://dev.mysql.com/doc/refman/5.7/en/create-index.html

https://dev.mysql.com/doc/refman/5.7/en/innodb-online-ddl.html

https://dev.mysql.com/doc/refman/5.7/en/innodb-online-ddl-operations.html

https://www.cnblogs.com/YangJiaXin/p/10828244.html


虽然pt-osc和gh-ost比 online DDL 慢一倍左右，但是对于主从延迟很小。

慢的原因：pt-osc和gh-ost需要写binlog和redo。



ALTER TABLE tbl_name ADD PRIMARY KEY (column), ALGORITHM=INPLACE, LOCK=NONE;


思考：
	在线操作索引，不需要重建表，工作原理是怎么样的？
	
	
	
The LOCK clause is useful for fine-tuning the degree of concurrent access to the table. The ALGORITHM clause is primarily intended for performance comparisons and as a fallback to the older table-copying behavior in case you encounter any issues. For example:
	LOCK子句可用于微调对表的并发访问程度。 ALGORITHM子句主要用于性能比较，并在遇到任何问题时作为对较早的表复制行为的后备。 例如：
		
	1. To avoid accidentally making the table unavailable for reads, writes, or both, specify a clause on the ALTER TABLE statement such as LOCK=NONE (permit reads and writes) or LOCK=SHARED (permit reads). The operation halts immediately if the requested level of concurrency is not available.
		为避免意外使表不可用于读取和/或写入，请在ALTER TABLE语句上指定一个子句，例如LOCK = NONE（允许读写）或LOCK = SHARED（允许读取）。 如果请求的并发级别不可用，该操作将立即停止。
		
		
	2. To compare performance between algorithms, run a statement with ALGORITHM=INPLACE and ALGORITHM=COPY. Alternatively, run a statement with the old_alter_table configuration option disabled and enabled.
		要比较算法之间的性能，请使用ALGORITHM = INPLACE和ALGORITHM = COPY运行一条语句。 或者，在禁用和启用old_alter_table配置选项的情况下运行语句。


	3. To avoid tying up the server with an ALTER TABLE operation that copies the table, include ALGORITHM=INPLACE. The statement halts immediately if it cannot use the in-place mechanism.
		为避免使用复制表的ALTER TABLE操作捆绑服务器，请包含ALGORITHM = INPLACE。 如果无法使用就地机制，该语句将立即暂停。
		




【潜水】B133-张路-北京 2020-05-06 10:08:48
各位大佬，请教个问题。MySQL不管是聚簇索引还是普通二级索引，根节点只能有一个16KB的数据页吗？还是有多个？（我的认知是：B+树是一个矮胖矮胖的梯形，根节点不是只有一个数据页的）

根据innodb ruby工具解析索引页，可以发现根节点只有一个Page, 并且这个Page是在内存中。



