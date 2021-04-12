
参数 innodb_force_recovery 影响了整个InnoDB存储引擎恢复的状况.

InnoDB 恢复级别：可选0-6，从最小开始尝试起
如何强制恢复MySQL


mysql> root@mysqldb 12:06:  [test_Db]> show global variables like '%innodb_force_recovery%';
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| innodb_force_recovery | 0     |
+-----------------------+-------+
1 row in set (0.00 sec)





参考笔记：《2021-04-12-启动、关闭与恢复》
