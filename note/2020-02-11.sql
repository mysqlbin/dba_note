root@mysqldb 22:40:  [db1]> desc select * from t1 STRAIGHT_JOIN t2  on t1.a=t2.a;
+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref      | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ALL  | a             | NULL | NULL    | NULL     | 1000 |   100.00 | Using where |
|  1 | SIMPLE      | t2    | NULL       | ref  | a             | a    | 5       | db1.t1.a |    1 |   100.00 | NULL        |
+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)

root@mysqldb 22:40:  [db1]> flush status;
Query OK, 0 rows affected (0.00 sec)

root@mysqldb 22:40:  [db1]> pager cat >> /dev/null
PAGER set to 'cat >> /dev/null'
root@mysqldb 22:40:  [db1]> select * from t1 STRAIGHT_JOIN t2  on t1.a=t2.a;
1000 rows in set (0.01 sec)

root@mysqldb 22:40:  [db1]> pager;
Default pager wasn't set, using stdout.
root@mysqldb 22:40:  [db1]> show status like 'Handler_read%';
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| Handler_read_first    | 1     |
| Handler_read_key      | 1001  |
| Handler_read_last     | 0     |
| Handler_read_next     | 1000  |
| Handler_read_prev     | 0     |
| Handler_read_rnd      | 0     |
| Handler_read_rnd_next | 1001  |
+-----------------------+-------+
7 rows in set (0.01 sec)


root@mysqldb 22:45:  [db1]> set optimizer_switch='mrr=on,mrr_cost_based=off,batched_key_access=on';
Query OK, 0 rows affected (0.00 sec)

root@mysqldb 22:45:  [db1]> desc select * from t1 STRAIGHT_JOIN t2  on t1.a=t2.a;
+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+----------------------------------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref      | rows | filtered | Extra                                  |
+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+----------------------------------------+
|  1 | SIMPLE      | t1    | NULL       | ALL  | a             | NULL | NULL    | NULL     | 1000 |   100.00 | Using where                            |
|  1 | SIMPLE      | t2    | NULL       | ref  | a             | a    | 5       | db1.t1.a |    1 |   100.00 | Using join buffer (Batched Key Access) |
+----+-------------+-------+------------+------+---------------+------+---------+----------+------+----------+----------------------------------------+
2 rows in set, 1 warning (0.00 sec)

root@mysqldb 22:45:  [db1]> flush status;
Query OK, 0 rows affected (0.00 sec)

root@mysqldb 22:45:  [db1]> pager cat >> /dev/null
PAGER set to 'cat >> /dev/null'
root@mysqldb 22:45:  [db1]> select * from t1 STRAIGHT_JOIN t2  on t1.a=t2.a;
1000 rows in set (0.01 sec)

root@mysqldb 22:45:  [db1]> pager;
Default pager wasn't set, using stdout.
root@mysqldb 22:45:  [db1]> show status like 'Handler_read%';
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| Handler_read_first    | 1     |
| Handler_read_key      | 2001  |
| Handler_read_last     | 0     |
| Handler_read_next     | 1000  |
| Handler_read_prev     | 0     |
| Handler_read_rnd      | 1000  |
| Handler_read_rnd_next | 1001  |
+-----------------------+-------+
7 rows in set (0.00 sec)

	