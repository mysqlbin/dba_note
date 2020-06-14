

CREATE TABLE `t1718` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into  t1718 values(1,1);
insert into  t1718 values(2,2);

session A                       session B             session C

flush table with read lock;

								mysql> select * from t1718;
								+----+------+
								| id | c    |
								+----+------+
								|  1 |    1 |
								|  2 |    2 |
								+----+------+
								2 rows in set (0.00 sec)
													  delete from t1718 where id=1;
													  (blocked)						
													 								
unlock tables;
														
													  Query OK, 1 row affected (1 min 15.27 sec)
mysql> select * from t1718;
+----+------+
| id | c    |
+----+------+
|  2 |    2 |
+----+------+
1 row in set (0.00 sec)


session C 被 blocked 后的 show processlist;
root@mysqldb 08:15:  [(none)]> show processlist;
+-----+----------+--------------------+------+---------+------+------------------------------+------------------------------+
| Id  | User     | Host               | db   | Command | Time | State                        | Info                         |
+-----+----------+--------------------+------+---------+------+------------------------------+------------------------------+
| 126 | root     | localhost          | db1  | Sleep   |   63 |                              | NULL                         |
| 127 | root     | localhost          | db1  | Query   |    5 | Waiting for global read lock | delete from t1718 where id=1 |
| 128 | root     | localhost          | db1  | Sleep   |   46 |                              | NULL                         |
| 129 | root     | localhost          | NULL | Query   |    0 | starting                     | show processlist             |
| 130 | app_user | 192.168.0.71:30848 | NULL | Sleep   | 1670 |                              | NULL                         |
| 131 | app_user | 192.168.0.71:30850 | db1  | Sleep   |  413 |                              | NULL                         |
| 132 | app_user | 192.168.0.71:30854 | db1  | Sleep   | 1665 |                              | NULL                         |
| 133 | app_user | 192.168.0.71:30855 | db1  | Sleep   | 1663 |                              | NULL                         |
| 134 | app_user | 192.168.0.71:31735 | db1  | Sleep   |  407 |                              | NULL                         |
| 135 | app_user | 192.168.0.71:31744 | db1  | Sleep   |  236 |                              | NULL                         |
| 136 | app_user | 192.168.0.71:32127 | db1  | Sleep   |   75 |                              | NULL                         |
| 137 | app_user | 192.168.0.71:32129 | db1  | Sleep   |   74 |                              | NULL                         |
+-----+----------+--------------------+------+---------+------+------------------------------+------------------------------+
12 rows in set (0.00 sec)



