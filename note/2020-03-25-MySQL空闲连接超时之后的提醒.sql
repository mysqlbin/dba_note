

mycat_user@mysqldb 05:07:  [mycat_db]> show global variables like 'interactive_timeout';
ERROR 2013 (HY000): Lost connection to MySQL server during query
mycat_user@mysqldb 06:45:  [mycat_db]> show global variables like 'wait_timeout';
ERROR 2006 (HY000): MySQL server has gone away
No connection. Trying to reconnect...
Connection id:    3
Current database: mycat_db

+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| wait_timeout  | 3600  |
+---------------+-------+
1 row in set (0.01 sec)


