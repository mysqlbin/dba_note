


前言:
	这个表是日志表, 没有delete和udpate语句, 业务场景都是insert和select; 
	主从复制的状态是正常的; 
	主库和从库的 innodb_page_size都是16KB.

现象:
	主库单表的大小比从库的大一倍；
	

	
主库:	
mysql> SELECT table_schema,table_name,data_length,index_length, DATA_FREE, table_rows  FROM \
    -> information_schema.tables where table_schema='aiuaiuh5_modb' and TABLE_NAME='table_abcdgameabc';
+--------------+-------------------+-------------+--------------+-----------+------------+
| table_schema | table_name        | data_length | index_length | DATA_FREE | table_rows |
+--------------+-------------------+-------------+--------------+-----------+------------+
| aiuaiuh5_modb  | table_abcdgameabc |  3105882112 |     78381056 |   7340032 |    1030118 |
+--------------+-------------------+-------------+--------------+-----------+------------+
1 row in set (0.00 sec)




从库:
mysql> SELECT table_schema,table_name,data_length,index_length, DATA_FREE, table_rows  FROM \
    -> information_schema.tables where table_schema='aiuaiuh5_modb' and TABLE_NAME='table_abcdgameabc';
+--------------+-------------------+-------------+--------------+-----------+------------+
| table_schema | table_name        | data_length | index_length | DATA_FREE | table_rows |
+--------------+-------------------+-------------+--------------+-----------+------------+
| aiuaiuh5_modb  | table_abcdgameabc |  1605369856 |     38420480 |   5242880 |     517971 |
+--------------+-------------------+-------------+--------------+-----------+------------+
1 row in set (0.00 sec)


主从服务器上，同一个表的表空间文件大小相差特别大，可能的原因如下:
1、MySQL表默认是InnoDB引擎且目前索引只支持B+树索引，在数据的增删改过程中，会导致表产生碎片，主从服务器上同张表的碎片率不同也会导致表空间相差很大
2、主库整理过碎片，从库是从原先的未整理的物理备份中恢复出来的
3、主从表结构不一致，如从库可能比主库多索引
4、主从表的行格式不一致，如主库为dynamic，从库为compressed
5、个别云数据库在从库上可能采用特殊的并行复制技术，导致在从库上有更高的碎片率（有个极端的案例，同一个表在主库只有6G，从库上则有将近150G）
6、表或者索引统计信息不准确/索引统计信息不够新

	
	
分析: 主库和从库版本为 5.7.26
mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.26-log |
+------------+
1 row in set (0.00 sec)

	
初步结论:
	从 information_schema.tables的信息中可以看到:
		主库和从库的碎片大小分别为 7MB和5MB,  排除了 1.碎片不同会导致表空间相关很大.
		主库的table_rows 比从库的table_rows大了一倍, 根据以往的经验, 初步估计是 表或者索引统计信息不准确/索引统计信息不够新 造成此案例中的现象.


分析过程如下: 
创建数据表 table_abcdgameabc 的DDL语句:

主库:
mysql> show create table table_abcdgameabc\G;
*************************** 1. row ***************************
       Table: table_abcdgameabc
Create Table: CREATE TABLE `table_abcdgameabc` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `szToken` varchar(64) NOT NULL COMMENT 'clubid-roomid-time-round',
  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
  `tEndTime` timestamp(3) NULL DEFAULT NULL COMMENT '结束时间',
  `nGameType` int(10) NOT NULL COMMENT '1-牛牛,2-三公',
  `nServerID` int(10) NOT NULL COMMENT '新手场: 初,中,高等',
  `LogData` text COMMENT '日志步骤json串',
  `CardData` text COMMENT '日志步骤json串',
  PRIMARY KEY (`ID`),
  KEY `idx_szToken` (`szToken`(26))
) ENGINE=InnoDB AUTO_INCREMENT=1156051 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部牌局日志表'
1 row in set (0.00 sec)


从库: 
mysql>  show create table table_abcdgameabc\G;
*************************** 1. row ***************************
       Table: table_abcdgameabc
Create Table: CREATE TABLE `table_abcdgameabc` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `szToken` varchar(64) NOT NULL COMMENT 'clubid-roomid-time-round',
  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
  `tEndTime` timestamp(3) NULL DEFAULT NULL COMMENT '结束时间',
  `nGameType` int(10) NOT NULL COMMENT '1-牛牛,2-三公',
  `nServerID` int(10) NOT NULL COMMENT '新手场: 初,中,高等',
  `LogData` text COMMENT '日志步骤json串',
  `CardData` text COMMENT '日志步骤json串',
  PRIMARY KEY (`ID`),
  KEY `idx_szToken` (`szToken`(26))
) ENGINE=InnoDB AUTO_INCREMENT=1156007 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部牌局日志表'
1 row in set (0.00 sec)


主从表结构一致, 排除了 3.主从表结构不一致，如从库可能比主库多索引;


查看表的状态信息:
主库:
mysql> show table status like "table_abcdgameabc"\G;
*************************** 1. row ***************************
           Name: table_abcdgameabc
         Engine: InnoDB
        Version: 10
     Row_format: Dynamic
           Rows: 1030689
 Avg_row_length: 3013
    Data_length: 3105882112
Max_data_length: 0
   Index_length: 78381056
      Data_free: 6291456
 Auto_increment: 1156478
    Create_time: 2019-05-09 11:37:12
    Update_time: 2019-07-01 11:51:44
     Check_time: NULL
      Collation: utf8mb4_general_ci
       Checksum: NULL
 Create_options: 
        Comment: 俱乐部牌局日志表
1 row in set (0.00 sec)


从库:
mysql> show table status like "table_abcdgameabc"\G;
*************************** 1. row ***************************
           Name: table_abcdgameabc
         Engine: InnoDB
        Version: 10
     Row_format: Dynamic
           Rows: 518498
 Avg_row_length: 3096
    Data_length: 1605369856
Max_data_length: 0
   Index_length: 38420480
      Data_free: 7340032
 Auto_increment: 1156452
    Create_time: 2019-05-09 11:37:13
    Update_time: 2019-07-01 11:51:14
     Check_time: NULL
      Collation: utf8mb4_general_ci
       Checksum: NULL
 Create_options: 
        Comment: 俱乐部牌局日志表
1 row in set (0.00 sec)



主从表的行记录格式都是Dynamic, 排除了 4、主从表的行格式不一致，如主库为dynamic，从库为compressed;



查看索引的状态信息:
	
主库:
mysql> show index from table_abcdgameabc;
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table             | Non_unique | Key_name    | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| table_abcdgameabc |          0 | PRIMARY     |            1 | ID          | A         |     1022515 |     NULL | NULL   |      | BTREE      |         |               |
| table_abcdgameabc |          1 | idx_szToken |            1 | szToken     | A         |      953938 |       26 | NULL   |      | BTREE      |         |               |
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
2 rows in set (0.00 sec)

从库: 
mysql>  show index from table_abcdgameabc;
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table             | Non_unique | Key_name    | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| table_abcdgameabc |          0 | PRIMARY     |            1 | ID          | A         |      514855 |     NULL | NULL   |      | BTREE      |         |               |
| table_abcdgameabc |          1 | idx_szToken |            1 | szToken     | A         |      510925 |       26 | NULL   |      | BTREE      |         |               |
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
2 rows in set (0.00 sec)



统计数据表的总行数:
主库:
mysql> select count(*) from  table_abcdgameabc;
+----------+
| count(*) |
+----------+
|  1156750 |
+----------+
1 row in set (0.20 sec)


从库:
mysql> select count(*) from  table_abcdgameabc;
+----------+
| count(*) |
+----------+
|  1156761 |
+----------+
1 row in set (0.22 sec)

统计数据表总行数的SQL先在主库执行, 时间大概相隔一秒之后在从库执行, 根据主从复制的原理, 这里看到的从库的记录数比主库的记录数多, 是属于正常现在的; 
可以看到, 数据表在主库和从库的总行数是不会造成本案例的现象的, 更加验证了 初步结论中的 表或者索引统计信息不准确.



查看表的统计信息:
主库:
mysql> select * from mysql.innodb_table_stats  where table_name = 'table_abcdgameabc';
+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
| database_name | table_name        | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
| aiuaiuh5_modb   | table_abcdgameabc | 2019-07-01 02:03:22 | 1022131 |               189568 |                     4784 |
+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
1 row in set (0.00 sec)

clustered_index_size:
	聚集索引的数据页的数量
	对应 stat_name=n_leaf_pages时：stat_value 的值
	
sum_of_other_index_sizes:
	表示为叶子节点和非叶子节点分配的数据页的数量的 4784个Page; 
	对应 stat_name=size时：stat_value 的值.
	
	
	
从库:
mysql> select * from mysql.innodb_table_stats  where table_name = 'table_abcdgameabc';
+---------------+-------------------+---------------------+--------+----------------------+--------------------------+
| database_name | table_name        | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
+---------------+-------------------+---------------------+--------+----------------------+--------------------------+
| aiuaiuh5_modb   | table_abcdgameabc | 2019-06-10 04:02:34 | 512709 |                97984 |                     2345 |
+---------------+-------------------+---------------------+--------+----------------------+--------------------------+
1 row in set (0.00 sec)

-- 

查看索引的统计信息:
主库:
mysql> select * from mysql.innodb_index_stats  where table_name = 'table_abcdgameabc';
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name        | index_name  | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-07-01 02:03:22 | n_diff_pfx01 |    1022131 |          20 | ID                                |
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-07-01 02:03:22 | n_leaf_pages |     187547 |        NULL | Number of leaf pages in the index |
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-07-01 02:03:22 | size         |     189568 |        NULL | Number of pages in the index      |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-07-01 02:03:22 | n_diff_pfx01 |     953580 |          20 | szToken                           |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-07-01 02:03:22 | n_diff_pfx02 |    1244814 |          20 | szToken,ID                        |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-07-01 02:03:22 | n_leaf_pages |       4148 |        NULL | Number of leaf pages in the index |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-07-01 02:03:22 | size         |       4784 |        NULL | Number of pages in the index      |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.01 sec)

主键索引:
	stat_name=n_leaf_pages时：stat_value 表示叶子节点使用的数据页的数量为 187547个Page; 
	stat_name=size时：        stat_value 表示为叶子节点和非叶子节点分配的数据页的数量的 189568个Page; 

辅助索引:
	stat_name=n_leaf_pages时：stat_value 表示叶子节点使用的数据页的数量为 4148个Page; 
	stat_name=size时：        stat_value 表示为叶子节点和非叶子节点分配的数据页的数量的 4784个Page; 
	

从库:
mysql> select * from mysql.innodb_index_stats  where table_name = 'table_abcdgameabc';
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name        | index_name  | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-06-10 04:02:34 | n_diff_pfx01 |     512709 |          20 | ID                                |
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-06-10 04:02:34 | n_leaf_pages |      97659 |        NULL | Number of leaf pages in the index |
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-06-10 04:02:34 | size         |      97984 |        NULL | Number of pages in the index      |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-06-10 04:02:34 | n_diff_pfx01 |     508796 |          20 | szToken                           |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-06-10 04:02:34 | n_diff_pfx02 |     535483 |          20 | szToken,ID                        |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-06-10 04:02:34 | n_leaf_pages |       2045 |        NULL | Number of leaf pages in the index |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-06-10 04:02:34 | size         |       2345 |        NULL | Number of pages in the index      |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.01 sec)
	
通过 表和索引的统计信息, 可以看到 从库的 统计信息最后一次更新时间是在 2019-06-10 04:02:34; 


----- 从库的索引统计信息比主库落后了20天。

相关统计参数:
	show global variables like 'innodb_stats_persistent';
	show global variables like 'innodb_stats_auto_recalc';
	
主库:
mysql> show global variables like 'innodb_stats_persistent';
+-------------------------+-------+
| Variable_name           | Value |
+-------------------------+-------+
| innodb_stats_persistent | ON    |
+-------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_stats_auto_recalc';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| innodb_stats_auto_recalc | ON    |
+--------------------------+-------+
1 row in set (0.00 sec)
	
从库:	
mysql> show global variables like 'innodb_stats_persistent';
+-------------------------+-------+
| Variable_name           | Value |
+-------------------------+-------+
| innodb_stats_persistent | ON    |
+-------------------------+-------+
1 row in set (0.01 sec)

mysql> show global variables like 'innodb_stats_auto_recalc';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| innodb_stats_auto_recalc | ON    |
+--------------------------+-------+
1 row in set (0.01 sec)


alter+analyze+optimize：
    1. alter table table_name engine=InnoDB; (recreate) 表示重建表；
            清除表空间碎片， 用 alter table；
    2. analyze table 不是重建表， 只是对表的索引信息做重新统计， 没有修改数据， 这个过程中加了 MDL读锁；
            索引统计信息不准确， 用 analyze table; 
    3. optimize table 等于 alter(recreate) + analyze；
    4. truncate = drop+create。
	

从库上重建表: 
shell> sudo  pt-online-schema-change  --charset=utf8mb4 --execute --alter "engine=InnoDB" --user=root --password=  D=aiuaiuh5_modb,t=table_abcdgameabc
No slaves found.  See --recursion-method if host db-b has slaves.
Not checking slave lag because no slaves were found and --check-slave-lag was not specified.
Operation, tries, wait:
  analyze_table, 10, 1
  copy_rows, 10, 0.25
  create_triggers, 10, 1
  drop_triggers, 10, 1
  swap_tables, 10, 1
  update_foreign_keys, 10, 1
Altering `aiuaiuh5_modb`.`table_abcdgameabc`...
Creating new table...
Created new table aiuaiuh5_modb._table_abcdgameabc_new OK.
Altering new table...
Altered `aiuaiuh5_modb`.`_table_abcdgameabc_new` OK.
2019-07-01T17:44:29 Creating triggers...
2019-07-01T17:44:29 Created triggers OK.
2019-07-01T17:44:29 Copying approximately 512709 rows...
Copying `aiuaiuh5_modb`.`table_abcdgameabc`:  52% 00:26 remain
Copying `aiuaiuh5_modb`.`table_abcdgameabc`:  69% 00:26 remain
Copying `aiuaiuh5_modb`.`table_abcdgameabc`:  92% 00:07 remain
2019-07-01T17:49:12 Copied rows OK.
2019-07-01T17:49:12 Analyzing new table...
2019-07-01T17:49:12 Swapping tables...
2019-07-01T17:49:13 Swapped original and new tables OK.
2019-07-01T17:49:13 Dropping old table...
2019-07-01T17:49:13 Dropped old table `aiuaiuh5_modb`.`_table_abcdgameabc_old` OK.
2019-07-01T17:49:13 Dropping triggers...
2019-07-01T17:49:19 Dropped triggers OK.
Successfully altered `aiuaiuh5_modb`.`table_abcdgameabc`.


mysql> show index from table_abcdgameabc;
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table             | Non_unique | Key_name    | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| table_abcdgameabc |          0 | PRIMARY     |            1 | ID          | A         |      974814 |     NULL | NULL   |      | BTREE      |         |               |
| table_abcdgameabc |          1 | idx_szToken |            1 | szToken     | A         |      974897 |       26 | NULL   |      | BTREE      |         |               |
+-------------------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
2 rows in set (0.00 sec)



mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh5_modb' table_name = 'table_abcdgameabc';
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name        | index_name  | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-07-01 17:49:12 | n_diff_pfx01 |     974814 |          20 | ID                                |
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-07-01 17:49:12 | n_leaf_pages |     191140 |        NULL | Number of leaf pages in the index |
| aiuaiuh5_modb   | table_abcdgameabc | PRIMARY     | 2019-07-01 17:49:12 | size         |     193216 |        NULL | Number of pages in the index      |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-07-01 17:49:12 | n_diff_pfx01 |    1073189 |          20 | szToken                           |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-07-01 17:49:12 | n_diff_pfx02 |    1273997 |          20 | szToken,ID                        |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-07-01 17:49:12 | n_leaf_pages |       4031 |        NULL | Number of leaf pages in the index |
| aiuaiuh5_modb   | table_abcdgameabc | idx_szToken | 2019-07-01 17:49:12 | size         |       4655 |        NULL | Number of pages in the index      |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.00 sec)


mysql> SELECT table_schema,table_name,data_length,index_length, DATA_FREE, table_rows  FROM  information_schema.tables where table_schema='aiuaiuh5_modb' and TABLE_NAME='table_abcdgameabc';
+--------------+-------------------+-------------+--------------+-----------+------------+
| table_schema | table_name        | data_length | index_length | DATA_FREE | table_rows |
+--------------+-------------------+-------------+--------------+-----------+------------+
| aiuaiuh5_modb  | table_abcdgameabc |  3165650944 |     76267520 |   5242880 |     974923 |
+--------------+-------------------+-------------+--------------+-----------+------------+
1 row in set (0.00 sec)
