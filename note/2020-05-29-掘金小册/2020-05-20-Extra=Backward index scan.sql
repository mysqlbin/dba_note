

mysql> show create table t\G;
*************************** 1. row ***************************
       Table: t
Create Table: CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)


mysql> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)


root@mysqldb 14:28:  [sbtest]> select * from t;
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



root@mysqldb 14:24:  [sbtest]> desc select * from t where c>9 and c<12 order by c desc lock in share mode;
+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+--------------------------------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                                      |
+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+--------------------------------------------+
|  1 | SIMPLE      | t     | NULL       | range | c             | c    | 5       | NULL |    1 |   100.00 | Using index condition; Backward index scan |
+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+--------------------------------------------+
1 row in set, 1 warning (0.00 sec)

