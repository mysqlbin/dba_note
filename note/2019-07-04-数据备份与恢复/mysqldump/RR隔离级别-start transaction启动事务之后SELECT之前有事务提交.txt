

mysql> select @@tx_isolation;
+-----------------+
| @@tx_isolation  |
+-----------------+
| REPEATABLE-READ |
+-----------------+
1 row in set, 1 warning (0.00 sec)


mysql> show create table product\G;
*************************** 1. row ***************************
       Table: product
Create Table: CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)




mysql> select * from product;
+----+------+--------+
| id | name | amount |
+----+------+--------+
|  1 | mi8  |      7 |
+----+------+--------+
1 row in set (0.00 sec)


SESSION A					 	SESSION B
start transaction;
								mysql> update product set amount=amount-1 where id=1;
								
mysql> select * from product;
+----+------+--------+
| id | name | amount |
+----+------+--------+
|  1 | mi8  |      6 |
+----+------+--------+
1 row in set (0.00 sec)