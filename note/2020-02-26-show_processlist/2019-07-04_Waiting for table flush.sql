


LOCK TABLES `t3` WRITE;

root@mysqldb 05:41:  [(none)]> show processlist;
+----+-----------------+--------------------+----------+---------+------+-------------------------+------------------------+
| Id | User            | Host               | db       | Command | Time | State                   | Info                   |
+----+-----------------+--------------------+----------+---------+------+-------------------------+------------------------+
|  1 | event_scheduler | localhost          | NULL     | Daemon  |  944 | Waiting on empty queue  | NULL                   |
|  4 | root            | localhost          | NULL     | Sleep   |  615 |                         | NULL                   |
| 15 | root            | localhost          | archery6 | Sleep   |    0 |                         | NULL                   |
| 18 | root            | localhost          | NULL     | Query   |    0 | starting                | show processlist       |
| 20 | root            | 192.168.0.71:16354 | archery6 | Query   |   72 | Waiting for table flush | SHOW CREATE TABLE `t3` |
| 22 | root            | 192.168.0.71:16637 | NULL     | Sleep   |   18 |                         | NULL                   |
| 23 | root            | 192.168.0.71:16639 | archery6 | Query   |   13 | Waiting for table flush | SHOW CREATE TABLE `t3` |
| 24 | root            | 192.168.0.71:16643 | archery6 | Sleep   |   13 |                         | NULL                   |
+----+-----------------+--------------------+----------+---------+------+-------------------------+------------------------+
8 rows in set (0.11 sec)




mysql> use sbtest;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

mysql> show processlist;
+----+-----------------+---------------------+--------+-------------+-------+---------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host                | db     | Command     | Time  | State                                                         | Info                                                                                                 |
+----+-----------------+---------------------+--------+-------------+-------+---------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost           | NULL   | Daemon      | 80897 | Waiting on empty queue                                        | NULL                                                                                                 |
|  3 | repl_user       | 22.222.22.22:36376  | NULL   | Binlog Dump | 80847 | Master has sent all binlog to slave; waiting for more updates | NULL                                                                                                 |
| 74 | root            | 111.11.111.11:31124 | NULL   | Sleep       |   892 |                                                               | NULL                                                                                                 |
| 75 | root            | 111.11.111.11:31139 | NULL   | Sleep       |   890 |                                                               | NULL                                                                                                 |
| 78 | root            | 111.11.111.11:33504 | NULL   | Sleep       |   385 |                                                               | NULL                                                                                                 |
| 79 | root            | 111.11.111.11:33679 | NULL   | Sleep       |   600 |                                                               | NULL                                                                                                 |
| 80 | root            | 111.11.111.11:33682 | NULL   | Sleep       |   599 |                                                               | NULL                                                                                                 |
| 81 | root            | localhost           | sbtest | Query       |     0 | update                                                        | INSERT INTO `sbtest10` VALUES (6995560,5020265,'35227773258-68964720274-48953887884-93475084582-5624 |
| 83 | root            | 11.111.11.11:21340  | sbtest | Field List  |    40 | Waiting for table flush                                       |                                                                                                      |
| 84 | root            | 111.11.111.11:31295 | NULL   | Sleep       |    35 |                                                               | NULL                                                                                                 |
| 85 | root            | 111.11.111.11:31348 | NULL   | Sleep       |    30 |                                                               | NULL                                                                                                 |
| 86 | root            | 11.111.11.11:21354  | NULL   | Query       |     0 | starting                                                      | show processlist                                                                                     |
+----+-----------------+---------------------+--------+-------------+-------+---------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
12 rows in set (0.01 sec)


表现如下：

    use db不能进入数据库
    schema.processlist来看有大量的 Waiting for table flush
	
说明了执行 use DB; 命令 需要关闭这个库下的所有表;


参考:
	https://mp.weixin.qq.com/s/Te4VngFwPvUHvGzbaTAobA   USE DB导致MySQL大堵塞故障？
	
	

