

show global variables like 'innodb_log_buffer_size';
show global variables like 'innodb_log_file_size';
show global variables like 'innodb_log_files_in_group';
show global variables like 'innodb_flush_log_at_trx_commit';
show global variables like 'innodb_log_files_in_group';
show global variables like 'innodb_log_files_in_group';
show global variables like 'innocb_buffer_pool_size';
show global variables like 'innodb_buffer_pool_instances';
show global variables like 'innodb_max_dirty_pages_pct';
show global variables like 'innodb_flush_neighbors';
show global variables like 'innodb_flush_method';
show global variables like 'innodb_data_file_path';



mysql> show global variables like 'innodb_log_buffer_size';
+------------------------+---------+
| Variable_name          | Value   |
+------------------------+---------+
| innodb_log_buffer_size | 8388608 |
+------------------------+---------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_log_file_size';
+----------------------+----------+
| Variable_name        | Value    |
+----------------------+----------+
| innodb_log_file_size | 33554432 |
+----------------------+----------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_log_files_in_group';
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| innodb_log_files_in_group | 2     |
+---------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_flush_log_at_trx_commit';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_trx_commit | 1     |
+--------------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_log_files_in_group';
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| innodb_log_files_in_group | 2     |
+---------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_log_files_in_group';
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| innodb_log_files_in_group | 2     |
+---------------------------+-------+
1 row in set (0.01 sec)

mysql> show global variables like 'innodb_buffer_pool_size';
+-------------------------+------------+
| Variable_name           | Value      |
+-------------------------+------------+
| innodb_buffer_pool_size | 8589934592 |
+-------------------------+------------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_buffer_pool_instances';
+------------------------------+-------+
| Variable_name                | Value |
+------------------------------+-------+
| innodb_buffer_pool_instances | 8     |
+------------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_max_dirty_pages_pct';
+----------------------------+-------+
| Variable_name              | Value |
+----------------------------+-------+
| innodb_max_dirty_pages_pct | 75    |
+----------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_flush_neighbors';
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| innodb_flush_neighbors | 1     |
+------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_flush_method';
+---------------------+-------+
| Variable_name       | Value |
+---------------------+-------+
| innodb_flush_method |       |
+---------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like 'innodb_data_file_path';
+-----------------------+------------------------+
| Variable_name         | Value                  |
+-----------------------+------------------------+
| innodb_data_file_path | ibdata1:10M:autoextend |
+-----------------------+------------------------+
1 row in set (0.00 sec)

