






CREATE TABLE `t1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `filed_02` int(10) NOT NULL DEFAULT '0' COMMENT 'filed_02',
  PRIMARY KEY (`ID`),
  KEY `idx_age` (`age`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

root@mysqldb 11:11:  [test_db]> select * from t1;
+----+-----+---------------------+----------+
| ID | age | tEndTime            | filed_02 |
+----+-----+---------------------+----------+
|  2 |   2 | 2020-07-13 14:23:57 |        0 |
|  3 |   3 | 2020-07-13 14:24:00 |        0 |
|  4 |   4 | 2020-07-13 14:24:03 |        0 |
|  5 |   5 | 2020-07-13 14:24:05 |        0 |
|  6 |   6 | 2020-07-13 14:24:08 |        0 |
|  7 |   7 | 2020-07-13 14:24:11 |        0 |
|  8 |   1 | 2020-07-13 14:41:43 |        0 |
| 10 |   1 | 2020-07-13 14:41:43 |        0 |
+----+-----+---------------------+----------+
8 rows in set (0.00 sec)


[root@localhost test_db]# ls -lht t1.*
-rw-r----- 1 mysql mysql 112K 3月   1 10:27 t1.ibd
-rw-r----- 1 mysql mysql 8.5K 3月   1 10:27 t1.frm
[root@localhost test_db]# 
[root@localhost test_db]# 
[root@localhost test_db]# 
[root@localhost test_db]# date
2021年 04月 01日 星期四 11:12:44 CST



select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't1';
select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't1';

root@mysqldb 11:14:  [(none)]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't1';
+---------------+------------+---------------------+--------+----------------------+--------------------------+
| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
+---------------+------------+---------------------+--------+----------------------+--------------------------+
| test_db       | t1         | 2021-03-01 10:27:53 |      8 |                    1 |                        1 |
+---------------+------------+---------------------+--------+----------------------+--------------------------+
1 row in set (0.00 sec)

root@mysqldb 11:14:  [(none)]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't1';
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
| test_db       | t1         | PRIMARY    | 2021-03-01 10:27:53 | n_diff_pfx01 |          8 |           1 | ID                                |
| test_db       | t1         | PRIMARY    | 2021-03-01 10:27:53 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
| test_db       | t1         | PRIMARY    | 2021-03-01 10:27:53 | size         |          1 |        NULL | Number of pages in the index      |
| test_db       | t1         | idx_age    | 2021-03-01 10:27:53 | n_diff_pfx01 |          7 |           1 | age                               |
| test_db       | t1         | idx_age    | 2021-03-01 10:27:53 | n_diff_pfx02 |          8 |           1 | age,ID                            |
| test_db       | t1         | idx_age    | 2021-03-01 10:27:53 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
| test_db       | t1         | idx_age    | 2021-03-01 10:27:53 | size         |          1 |        NULL | Number of pages in the index      |
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.00 sec)


-----------------------------------------------------------------------------------------------------------------------------------------------


root@mysqldb 11:11:  [test_db]> alter table t1 change filed_02 filed_02 int(10) DEFAULT "3" COMMENT 'filed_02';
Query OK, 0 rows affected (0.58 sec)
Records: 0  Duplicates: 0  Warnings: 0

root@mysqldb 11:16:  [test_db]> show create table t1\G;
*************************** 1. row ***************************
       Table: t1
Create Table: CREATE TABLE `t1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `filed_02` int(10) DEFAULT '3' COMMENT 'filed_02',
  PRIMARY KEY (`ID`),
  KEY `idx_age` (`age`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4
1 row in set (0.01 sec)

[root@localhost test_db]# ls -lht t1.*
-rw-r----- 1 mysql mysql 112K 4月   1 11:16 t1.ibd
-rw-r----- 1 mysql mysql 8.5K 4月   1 11:16 t1.frm
您在 /var/spool/mail/root 中有新邮件


root@mysqldb 11:16:  [test_db]> select * from t1;
+----+-----+---------------------+----------+
| ID | age | tEndTime            | filed_02 |
+----+-----+---------------------+----------+
|  2 |   2 | 2020-07-13 14:23:57 |        0 |
|  3 |   3 | 2020-07-13 14:24:00 |        0 |
|  4 |   4 | 2020-07-13 14:24:03 |        0 |
|  5 |   5 | 2020-07-13 14:24:05 |        0 |
|  6 |   6 | 2020-07-13 14:24:08 |        0 |
|  7 |   7 | 2020-07-13 14:24:11 |        0 |
|  8 |   1 | 2020-07-13 14:41:43 |        0 |
| 10 |   1 | 2020-07-13 14:41:43 |        0 |
+----+-----+---------------------+----------+
8 rows in set (0.00 sec)

root@mysqldb 11:17:  [test_db]> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't1';
+---------------+------------+---------------------+--------+----------------------+--------------------------+
| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
+---------------+------------+---------------------+--------+----------------------+--------------------------+
| test_db       | t1         | 2021-04-01 11:16:20 |      8 |                    1 |                        1 |
+---------------+------------+---------------------+--------+----------------------+--------------------------+
1 row in set (0.00 sec)

root@mysqldb 11:17:  [test_db]> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't1';
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
| test_db       | t1         | PRIMARY    | 2021-04-01 11:16:20 | n_diff_pfx01 |          8 |           1 | ID                                |
| test_db       | t1         | PRIMARY    | 2021-04-01 11:16:20 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
| test_db       | t1         | PRIMARY    | 2021-04-01 11:16:20 | size         |          1 |        NULL | Number of pages in the index      |
| test_db       | t1         | idx_age    | 2021-04-01 11:16:20 | n_diff_pfx01 |          7 |           1 | age                               |
| test_db       | t1         | idx_age    | 2021-04-01 11:16:20 | n_diff_pfx02 |          8 |           1 | age,ID                            |
| test_db       | t1         | idx_age    | 2021-04-01 11:16:20 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
| test_db       | t1         | idx_age    | 2021-04-01 11:16:20 | size         |          1 |        NULL | Number of pages in the index      |
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.00 sec)



