

root@mysqldb 18:25:  [(none)]> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 10000 |
+---------------+-------+
1 row in set (0.00 sec)

set global sync_binlog=1;



[root@soft logs]# mysqlbinlog -vv --base64-output='decode-rows'  mysql-bin.000224 > 2020-07-23.sql
ERROR: Error in Log_event::read_log_event(): 'Sanity check failed', data_len: 31, event_type: 35
ERROR: Could not read entry at offset 123: Error in log format or read error.
[root@soft logs]# mysqlbinlog -vv --base64-output='decode-rows'  mysql-bin.000224 > 2020-07-23.sql

