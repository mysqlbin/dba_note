

SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
information_schema.tables  where table_schema = 'lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
select * from information_schema.statistics where TABLE_SCHEMA='lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
select * from mysql.innodb_table_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
select * from mysql.innodb_index_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
show index from table_name;



show index from table_name; 的结果来自于 information_schema.statistics 。

show index from table_name的 Cardinality 列，information_schema.statistics的 Cardinality 列(字段)。


mysql> show index from t_20200713;
+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table      | Non_unique | Key_name  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| t_20200713 |          0 | PRIMARY   |            1 | ID          | A         |           7 |     NULL | NULL   |      | BTREE      |         |               |
| t_20200713 |          1 | idx_t1_t2 |            1 | t1          | A         |           5 |     NULL | NULL   |      | BTREE      |         |               |
| t_20200713 |          1 | idx_t1_t2 |            2 | t2          | A         |           6 |     NULL | NULL   | YES  | BTREE      |         |               |
+------------+------------+-----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
4 rows in set (0.00 sec)


mysql> select * from information_schema.statistics where TABLE_SCHEMA='test_db' and table_name='t_20200713';
+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | NON_UNIQUE | INDEX_SCHEMA | INDEX_NAME | SEQ_IN_INDEX | COLUMN_NAME | COLLATION | CARDINALITY | SUB_PART | PACKED | NULLABLE | INDEX_TYPE | COMMENT | INDEX_COMMENT |
+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
| def           | test_db      | t_20200713 |          0 | test_db      | PRIMARY    |            1 | ID          | A         |           7 |     NULL | NULL   |          | BTREE      |         |               |
| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            1 | t1          | A         |           5 |     NULL | NULL   |          | BTREE      |         |               |
| def           | test_db      | t_20200713 |          1 | test_db      | idx_t1_t2  |            2 | t2          | A         |           6 |     NULL | NULL   | YES      | BTREE      |         |               |
+---------------+--------------+------------+------------+--------------+------------+--------------+-------------+-----------+-------------+----------+--------+----------+------------+---------+---------------+
4 rows in set (0.00 sec)


