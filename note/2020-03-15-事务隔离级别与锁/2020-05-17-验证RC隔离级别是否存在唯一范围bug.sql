





CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;
insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);

root@localhost [db1]>select * from t;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  0 |    0 |    0 |
|  5 |    5 |    5 |
| 10 |   10 |   10 |
| 15 |   15 |   15 |
| 20 |   20 |   20 |
| 25 |   25 |   25 |
+----+------+------+
6 rows in set (0.00 sec)

root@localhost [db1]>select version();
+------------+
| version()  |
+------------+
| 5.7.19-log |
+------------+
1 row in set (0.00 sec)

root@localhost [db1]>show global variables like '%innodb_autoinc_lock_mode%';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| innodb_autoinc_lock_mode | 1     |
+--------------------------+-------+
1 row in set (0.01 sec)

root@localhost [db1]>show global variables like '%isolation%';

+---------------+----------------+
| Variable_name | Value          |
+---------------+----------------+
| tx_isolation  | READ-COMMITTED |
+---------------+----------------+
1 row in set (0.00 sec)

root@localhost [db1]>select @@session.tx_isolation;
+------------------------+
| @@session.tx_isolation |
+------------------------+
| READ-COMMITTED         |
+------------------------+
1 row in set (0.00 sec)


session A                                        session B                                                                                                                                                                                                            
begin;
select * from t where id>10 and id<=15 for update;
+----+------+------+
| id | c    | d    |
+----+------+------+
| 15 |   15 |   15 |
+----+------+------+
1 row in set (0.00 sec)

												update t set d=d+1 where id=20;
												Query OK, 1 row affected (0.00 sec)
												Rows matched: 1  Changed: 1  Warnings: 0 
																								
答： 不存在 。


										
