
root@localhost [zst]>select version();
+------------+
| version()  |
+------------+
| 5.7.19-log |
+------------+
1 row in set (0.00 sec)

session A            session b
lock tables t1 write;

					 rename table `t1` to `_t1_del`;
					 (Blocked)
					 
show processlist;	
				 
rename table `t1` to `_t1_del`;
ERROR 1192 (HY000): Can t execute the given command because you have active locked tables or an active transaction

					 
root@localhost [(none)]>show processlist;
+----+------+--------------------+------+---------+------+---------------------------------+--------------------------------+
| Id | User | Host               | db   | Command | Time | State                           | Info                           |
+----+------+--------------------+------+---------+------+---------------------------------+--------------------------------+
| 11 | root | localhost          | zst  | Sleep   |   22 |                                 | NULL                           |
| 12 | root | localhost          | zst  | Query   |    7 | Waiting for table metadata lock | rename table `t1` to `_t1_del` |
| 13 | lujb | 192.168.1.100:3973 | NULL | Sleep   |  102 |                                 | NULL                           |
| 14 | lujb | 192.168.1.100:3980 | zst  | Sleep   |   96 |                                 | NULL                           |
| 15 | lujb | 192.168.1.100:3984 | zst  | Sleep   |   96 |                                 | NULL                           |
| 16 | root | localhost          | NULL | Query   |    0 | starting                        | show processlist               |
+----+------+--------------------+------+---------+------+---------------------------------+--------------------------------+
6 rows in set (0.00 sec)