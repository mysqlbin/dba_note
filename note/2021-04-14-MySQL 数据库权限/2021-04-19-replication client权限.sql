



create user 'read_user_0419'@'%' identified by '123456';
grant select on *.* to 'read_user_0419'@'%' with grant option;


mysql> show grants for 'read_user_0419'@'%';
+---------------------------------------------------------------+
| Grants for read_user_0419@%                                   |
+---------------------------------------------------------------+
| GRANT SELECT ON *.* TO 'read_user_0419'@'%' WITH GRANT OPTION |
+---------------------------------------------------------------+
1 row in set (0.00 sec)


show master status\G;
show slave status\G;
show binary logs;


mysql -h192.168.0.242 -uread_user_0419 -p123456

read_user_0419@mysqldb 12:27:  [(none)]> show master status\G;
ERROR 1227 (42000): Access denied; you need (at least one of) the SUPER, REPLICATION CLIENT privilege(s) for this operation
ERROR: 
No query specified

read_user_0419@mysqldb 12:27:  [(none)]> show slave status\G;
ERROR 1227 (42000): Access denied; you need (at least one of) the SUPER, REPLICATION CLIENT privilege(s) for this operation
ERROR: 
No query specified

read_user_0419@mysqldb 12:27:  [(none)]> show binary logs;
ERROR 1227 (42000): Access denied; you need (at least one of) the SUPER, REPLICATION CLIENT privilege(s) for this operation


----------------------------------------------------------------------------------------------------------------------------------------------------

revoke replication slave on *.* from 'read_user_0419'@'%';

grant replication client on *.* to 'read_user_0419'@'%' with grant option;


mysql -h192.168.0.242 -uread_user_0419 -p123456

root@mysqldb 12:28:  [(none)]> show grants for 'read_user_0419'@'%';
+----------------------------------------------------------------------------------+
| Grants for read_user_0419@%                                                      |
+----------------------------------------------------------------------------------+
| GRANT SELECT, REPLICATION SLAVE ON *.* TO 'read_user_0419'@'%' WITH GRANT OPTION |
+----------------------------------------------------------------------------------+
1 row in set (0.00 sec)

read_user_0419@mysqldb 14:18:  [(none)]> show grants for 'read_user_0419'@'%';
+-----------------------------------------------------------------------------------+
| Grants for read_user_0419@%                                                       |
+-----------------------------------------------------------------------------------+
| GRANT SELECT, REPLICATION CLIENT ON *.* TO 'read_user_0419'@'%' WITH GRANT OPTION |
+-----------------------------------------------------------------------------------+
1 row in set (0.00 sec)


read_user_0419@mysqldb 14:18:  [(none)]> show master status\G;
*************************** 1. row ***************************
             File: mysql-bin.000076
         Position: 10130
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1-106304
1 row in set (0.00 sec)

ERROR: 
No query specified

read_user_0419@mysqldb 14:18:  [(none)]> show slave status\G;
Empty set (0.00 sec)

ERROR: 
No query specified

read_user_0419@mysqldb 14:18:  [(none)]> show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000074 |      3228 |
| mysql-bin.000075 |       217 |
| mysql-bin.000076 |     10130 |
+------------------+-----------+
3 rows in set (0.00 sec)




replication client 允许执行 show master status、show slave status、show binary logs命令





