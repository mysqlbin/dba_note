
#查看索引持久化统计信息：
mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 'table_testtestsllog';
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name    | index_name  | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| test_db   | table_testtestsllog | PRIMARY     | 2019-07-12 17:17:24 | n_diff_pfx01 |    1395333 |          20 | ID                                |
| test_db   | table_testtestsllog | PRIMARY     | 2019-07-12 17:17:24 | n_leaf_pages |     253697 |        NULL | Number of leaf pages in the index |
| test_db   | table_testtestsllog | PRIMARY     | 2019-07-12 17:17:24 | size         |     258560 |        NULL | Number of pages in the index      |
| test_db   | table_testtestsllog | idx_szToken | 2019-07-12 17:17:24 | n_diff_pfx01 |    1298745 |          20 | szToken                           |
| test_db   | table_testtestsllog | idx_szToken | 2019-07-12 17:17:24 | n_diff_pfx02 |    1412981 |          20 | szToken,ID                        |
| test_db   | table_testtestsllog | idx_szToken | 2019-07-12 17:17:24 | n_leaf_pages |       5301 |        NULL | Number of leaf pages in the index |
| test_db   | table_testtestsllog | idx_szToken | 2019-07-12 17:17:24 | size         |       6134 |        NULL | Number of pages in the index      |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.00 sec)

#数据表的大小
mysql> select concat(round(sum(data_length + index_length) / 1024 / 1024, 2),'M') as total_mb from information_schema.tables where TABLE_SCHEMA='test_db' and table_name='table_testtestsllog';
+----------+
| total_mb |
+----------+
| 2202.84M |
+----------+
1 row in set (0.01 sec)


#执行 ANALYZE TABLE 统计索引分布信息，并将结果持久化存储；
mysql> ANALYZE TABLE table_testtestsllog;
+-------------------------------+---------+----------+----------+
| Table                         | Op      | Msg_type | Msg_text |
+-------------------------------+---------+----------+----------+
| test_db.table_testtestsllog | analyze | status   | OK       |
+-------------------------------+---------+----------+----------+
1 row in set (0.01 sec)

#数据表的大小
mysql> select concat(round(sum(data_length + index_length) / 1024 / 1024, 2),'M') as total_mb from information_schema.tables where TABLE_SCHEMA='test_db' and table_name='table_testtestsllog';
+----------+
| total_mb |
+----------+
| 4405.84M |
+----------+
1 row in set (0.01 sec)

#查看索引持久化统计信息：
mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 'table_testtestsllog';
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name    | index_name  | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
| test_db   | table_testtestsllog | PRIMARY     | 2019-07-22 10:15:46 | n_diff_pfx01 |    1351660 |          20 | ID                                |
| test_db   | table_testtestsllog | PRIMARY     | 2019-07-22 10:15:46 | n_leaf_pages |     270332 |        NULL | Number of leaf pages in the index |
| test_db   | table_testtestsllog | PRIMARY     | 2019-07-22 10:15:46 | size         |     275584 |        NULL | Number of pages in the index      |
| test_db   | table_testtestsllog | idx_szToken | 2019-07-22 10:15:46 | n_diff_pfx01 |    1419212 |          20 | szToken                           |
| test_db   | table_testtestsllog | idx_szToken | 2019-07-22 10:15:46 | n_diff_pfx02 |    1539267 |          20 | szToken,ID                        |
| test_db   | table_testtestsllog | idx_szToken | 2019-07-22 10:15:46 | n_leaf_pages |       5571 |        NULL | Number of leaf pages in the index |
| test_db   | table_testtestsllog | idx_szToken | 2019-07-22 10:15:46 | size         |       6390 |        NULL | Number of pages in the index      |
+---------------+-------------------+-------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.00 sec)

#查看数据表持久化统计信息：
mysql> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 'table_testtestsllog';
+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
| database_name | table_name        | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
| test_db     | table_testtestsllog | 2019-07-22 10:15:47 | 1270560 |               275584 |                     6390 |
+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
1 row in set (0.00 sec)


# 执行analyze table 对表的索引信息做重新统计， mysql.innodb_table_stats和data_size数据大小也会变。




本案例的索引统计信息落后了10天。




