

root@mysqldb 12:12:  [test_20191101]> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)


create table t3(id int primary key, a int, b int, c int, index(a));
	
delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  while(i<=1000000)do
	insert into t3 values(i, i, i, i);
	set i=i+1;
  end while;
end;;
delimiter ;
call idata();


root@mysqldb 11:58:  [test_20191101]> call idata();
Query OK, 1 row affected (47.63 sec)

root@mysqldb 12:06:  [test_20191101]>  select * from t3 limit 1;
ERROR 1412 (HY000): Table definition has changed, please retry transaction


root@mysqldb 12:09:  [test_20191101]>  select * from t3 limit 1;
ERROR 1412 (HY000): Table definition has changed, please retry transaction

Ctrl +　Ｃ　退出连接

root@mysqldb 12:11:  [test_20191101]> ^DBye
[root@kp04 ~]# mysql -uroot -p123456abc
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 422
Server version: 8.0.18 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

root@mysqldb 12:11:  [(none)]> show processlist;
+-----+-----------------+--------------------+---------------+---------+---------+------------------------+------------------+
| Id  | User            | Host               | db            | Command | Time    | State                  | Info             |
+-----+-----------------+--------------------+---------------+---------+---------+------------------------+------------------+
|   4 | event_scheduler | localhost          | NULL          | Daemon  | 1929525 | Waiting on empty queue | NULL             |
| 336 | root            | localhost          | NULL          | Sleep   |     286 |                        | NULL             |
| 384 | vip_user        | 192.168.0.71:27185 | test_20191101 | Sleep   |     353 |                        | NULL             |
| 386 | vip_user        | 192.168.0.71:27196 | test_20191101 | Sleep   |     335 |                        | NULL             |
| 390 | vip_user        | 192.168.0.71:27220 | test_20191101 | Sleep   |     333 |                        | NULL             |
| 422 | root            | localhost          | NULL          | Query   |       0 | starting               | show processlist |
+-----+-----------------+--------------------+---------------+---------+---------+------------------------+------------------+
6 rows in set (0.00 sec)


root@mysqldb 12:11:  [(none)]> use test_20191101;
Database changed
root@mysqldb 12:12:  [test_20191101]> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)

root@mysqldb 12:16:  [test_20191101]> select * from information_schema.innodb_trx;
Empty set (0.00 sec)

root@mysqldb 12:17:  [test_20191101]>  select * from t3 limit 1;
Empty set (0.00 sec)

root@mysqldb 12:17:  [test_20191101]>  select * from t3 limit 1;
Empty set (0.00 sec)

root@mysqldb 12:17:  [test_20191101]>  select * from t3 limit 1;
Empty set (0.00 sec)

root@mysqldb 12:17:  [test_20191101]>  select * from t3 limit 1;
Empty set (0.01 sec)

root@mysqldb 12:17:  [test_20191101]> 

