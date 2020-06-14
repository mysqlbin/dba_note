


https://dev.mysql.com/doc/refman/8.0/en/lock-instance-for-backup.html

root@mysqldb 10:12:  [(none)]> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)


DML
	LOCK INSTANCE FOR BACKUP; 
												INSERT INTO `db3`.`test1` (`id`, `name`, `CreateTime`) VALUES ('2', '2', '2020-02-03 10:11:39');
												(Query OK)

	UNLOCK INSTANCE;


DDL 
	truncate 
		LOCK INSTANCE FOR BACKUP; 
													truncate table test_20191101.t_2103;
													(Blocked)	
													
		UNLOCK INSTANCE;

			root@mysqldb 10:16:  [(none)]> show processlist;
			+-------+-----------------+--------------------+---------------+------------------+---------+---------------------------------------------------------------+-------------------------------------+
			| Id    | User            | Host               | db            | Command          | Time    | State                                                         | Info                                |
			+-------+-----------------+--------------------+---------------+------------------+---------+---------------------------------------------------------------+-------------------------------------+
			|     4 | event_scheduler | localhost          | NULL          | Daemon           | 2354714 | Waiting on empty queue                                        | NULL                                |
			| 29712 | keepalived      | 192.168.0.92:52104 | NULL          | Binlog Dump GTID |    3175 | Master has sent all binlog to slave; waiting for more updates | NULL                                |
			| 29896 | root            | localhost          | db3           | Query            |       5 | Waiting for backup lock                                       | truncate table test_20191101.t_2103 |
			| 29898 | vip_user        | 192.168.0.71:63895 | NULL          | Sleep            |     413 |                                                               | NULL                                |
			| 29899 | root            | 192.168.0.71:63897 | NULL          | Sleep            |     412 |                                                               | NULL                                |
			| 29901 | root            | 192.168.0.71:63898 | db3           | Sleep            |     409 |                                                               | NULL                                |
			| 29902 | root            | 192.168.0.71:63901 | db3           | Sleep            |     404 |                                                               | NULL                                |
			| 29907 | root            | localhost          | NULL          | Sleep            |      11 |                                                               | NULL                                |
			| 29915 | root            | 192.168.0.71:64040 | sbtest        | Sleep            |     238 |                                                               | NULL                                |
			| 29916 | root            | 192.168.0.71:64046 | test_20191101 | Sleep            |      49 |                                                               | NULL                                |
			| 29917 | root            | 192.168.0.71:64048 | test_20191101 | Sleep            |     234 |                                                               | NULL                                |
			| 29919 | root            | 192.168.0.71:64056 | test_20191101 | Sleep            |     224 |                                                               | NULL                                |
			| 29920 | root            | 192.168.0.71:64066 | test_20191101 | Sleep            |     218 |                                                               | NULL                                |
			| 29923 | root            | localhost          | NULL          | Query            |       0 | starting                                                      | show processlist                    |
			| 29935 | root            | 192.168.0.71:64206 | test_20191101 | Sleep            |      49 |                                                               | NULL                                |
			+-------+-----------------+--------------------+---------------+------------------+---------+---------------------------------------------------------------+-------------------------------------+
			15 rows in set (0.00 sec)

	
	添加字段
		LOCK INSTANCE FOR BACKUP; 
													alter table  t_2103 add column c4 int(11) not null default 0;
													
													(Blocked)	
													
		UNLOCK INSTANCE;


			root@mysqldb 10:18:  [(none)]> show processlist;
			+-------+-----------------+--------------------+---------------+------------------+---------+---------------------------------------------------------------+--------------------------------------------------------------+
			| Id    | User            | Host               | db            | Command          | Time    | State                                                         | Info                                                         |
			+-------+-----------------+--------------------+---------------+------------------+---------+---------------------------------------------------------------+--------------------------------------------------------------+
			|     4 | event_scheduler | localhost          | NULL          | Daemon           | 2354819 | Waiting on empty queue                                        | NULL                                                         |
			| 29712 | keepalived      | 192.168.0.92:52104 | NULL          | Binlog Dump GTID |    3280 | Master has sent all binlog to slave; waiting for more updates | NULL                                                         |
			| 29896 | root            | localhost          | db3           | Query            |       5 | Waiting for backup lock                                       | alter table  t_2103 add column c4 int(11) not null default 0 |
			| 29898 | vip_user        | 192.168.0.71:63895 | NULL          | Sleep            |     518 |                                                               | NULL                                                         |
			| 29899 | root            | 192.168.0.71:63897 | NULL          | Sleep            |     517 |                                                               | NULL                                                         |
			| 29901 | root            | 192.168.0.71:63898 | db3           | Sleep            |     514 |                                                               | NULL                                                         |
			| 29902 | root            | 192.168.0.71:63901 | db3           | Sleep            |     509 |                                                               | NULL                                                         |
			| 29907 | root            | localhost          | NULL          | Sleep            |      12 |                                                               | NULL                                                         |
			| 29915 | root            | 192.168.0.71:64040 | sbtest        | Sleep            |     343 |                                                               | NULL                                                         |
			| 29916 | root            | 192.168.0.71:64046 | test_20191101 | Sleep            |      78 |                                                               | NULL                                                         |
			| 29917 | root            | 192.168.0.71:64048 | test_20191101 | Sleep            |     339 |                                                               | NULL                                                         |
			| 29919 | root            | 192.168.0.71:64056 | test_20191101 | Sleep            |     329 |                                                               | NULL                                                         |
			| 29920 | root            | 192.168.0.71:64066 | test_20191101 | Sleep            |     323 |                                                               | NULL                                                         |
			| 29923 | root            | localhost          | NULL          | Query            |       0 | starting                                                      | show processlist                                             |
			| 29935 | root            | 192.168.0.71:64206 | test_20191101 | Sleep            |     154 |                                                               | NULL                                                         |
			+-------+-----------------+--------------------+---------------+------------------+---------+---------------------------------------------------------------+--------------------------------------------------------------+
			15 rows in set (0.00 sec)
