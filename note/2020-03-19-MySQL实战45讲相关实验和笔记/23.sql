
[root@localhost logs]# ll
总用量 12
-rw-r--r-- 1 root  root  1595 10月 21 18:32 36_binlog.sql
-rw-r----- 1 mysql mysql  154 2月  22 12:17 mysql-bin.000055
-rw-r----- 1 mysql mysql   44 2月  22 12:17 mysql-bin.index


root@mysqldb 12:20:  [niuniuh5_db]> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 0     |
+---------------+-------+
1 row in set (0.01 sec)

root@mysqldb 12:20:  [niuniuh5_db]> 
root@mysqldb 12:20:  [niuniuh5_db]> 
root@mysqldb 12:20:  [niuniuh5_db]> show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000055 |       154 |
+------------------+-----------+
1 row in set (0.00 sec)

root@mysqldb 12:20:  [niuniuh5_db]> 
root@mysqldb 12:20:  [niuniuh5_db]> 
root@mysqldb 12:20:  [niuniuh5_db]> delete from admin_user where UserId=1;
Query OK, 1 row affected (0.03 sec)

root@mysqldb 12:20:  [niuniuh5_db]> show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000055 |       541 |
+------------------+-----------+
1 row in set (0.00 sec)



[root@localhost logs]# ll
总用量 12
-rw-r--r-- 1 root  root  1595 10月 21 18:32 36_binlog.sql
-rw-r----- 1 mysql mysql  541 2月  22 12:20 mysql-bin.000055
-rw-r----- 1 mysql mysql   44 2月  22 12:17 mysql-bin.index




此时操作系统宕机会怎么样？ 



