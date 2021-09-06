

root@localhost [zst]>select @@tx_isolation;
+-----------------+
| @@tx_isolation  |
+-----------------+
| REPEATABLE-READ |
+-----------------+
1 row in set (0.00 sec)



begin;
select * from product where name='mi8' for update;
update product set amount=amount-1 where name='mi8';
select * from product where name='mi8';


root@localhost [zst]>select * from product where name='mi8' for update;
+----+------+--------+
| id | name | amount |
+----+------+--------+
|  1 | mi8  |      8 |
+----+------+--------+
1 row in set (0.00 sec)

root@localhost [zst]>update product set amount=amount-1 where name='mi8';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

root@localhost [zst]>select * from product where name='mi8';
+----+------+--------+
| id | name | amount |
+----+------+--------+
|  1 | mi8  |      7 |
+----+------+--------+
1 row in set (0.00 sec)


-- 自己的更新对自己可见。

