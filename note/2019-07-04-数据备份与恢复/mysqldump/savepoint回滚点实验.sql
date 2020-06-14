

savepoint 'identified' 语句, 为事务设置一个 保存点, 该字符串为事务保存点的标识符;

rollback to savepoint 'identified'语句的使用:
  1. 将事务回滚到指定的保存点的位置, 而不是终止事务;
  2. 可以释放在设置保存点之后事务持有的MDL锁;
 
mysqldump 使用 savepoint的使用就是, 当一个显示开启的事务回滚到保存点时, 可以释放保存点之后select语句持有的MDL锁, 使得其它会话的DDL语句可以正常执行;
当 select语句执行完成之后就代表着该表的数据已经备份完成, 无需再继续持有MDL锁, 使用 rollback to savepoint语句就实现了在 select语句执行完成之后释放MDL读锁.



一. 不使用WITH CONSITENT SNAPSHOT子句, 不使用 SAVEPOINT, SESSION A显示开启一个事后先执行查询,   SESSION B使用DDL语句添加一个字段
二. 不使用WITH CONSITENT SNAPSHOT子句, 使用 SAVEPOINT,   SESSION A显示开启一个事后先执行查询,   SESSION B使用DDL语句添加一个字段

三. 使用WITH CONSISTENT SNAPSHOT子句,  使用 SAVEPOINT,   SESSION A显示开启一个事后先不执行查询, SESSION B使用DDL语句添加一个字段
四. 使用WITH CONSITENT SNAPSHOT子句,   使用 SAVEPOINT,   SESSION A显示开启一个事后先执行查询,   SESSION B使用DDL语句删除一个字段


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



一. 不使用WITH CONSITENT SNAPSHOT子句, 不使用 SAVEPOINT, SESSION A显示开启一个事后先执行查询, SESSION B使用DDL语句添加一个字段

SESSION A					 		SESSION B
mysql> start transaction;
															
mysql> select * from product;
+----+------+--------+
| id | name | amount |
+----+------+--------+
|  1 | mi8  |      6 |
+----+------+--------+
1 row in set (0.00 sec)
									mysql> alter table product add column test_01 varchar(10);
									(Blocked)
									
mysql> show processlist;
+-----+-----------+--------------------+---------+-------------+-------+---------------------------------------------------------------+----------------------------------------------------+
| Id  | User      | Host               | db      | Command     | Time  | State                                                         | Info                                               |
+-----+-----------+--------------------+---------+-------------+-------+---------------------------------------------------------------+----------------------------------------------------+
| 152 | repl_test | 192.168.0.55:59522 | NULL    | Binlog Dump | 57330 | Master has sent all binlog to slave; waiting for more updates | NULL                                               |
| 177 | root      | 192.168.0.54:43694 | test_db | Query       |    11 | Waiting for table metadata lock                               | alter table product add column test_01 varchar(10) |
| 178 | root      | 192.168.0.54:43696 | test_db | Sleep       |    28 |                                                               | NULL                                               |
| 179 | root      | localhost          | NULL    | Query       |     0 | starting                                                      | show processlist                                   |
+-----+-----------+--------------------+---------+-------------+-------+---------------------------------------------------------------+----------------------------------------------------+
4 rows in set (0.00 sec)
								
								

二. 不使用WITH CONSITENT SNAPSHOT子句, 使用 SAVEPOINT, SESSION A显示开启一个事后先执行查询, SESSION B使用DDL语句添加一个字段

SESSION A					 		SESSION B
mysql> start transaction;

mysql> savepoint sp;

mysql> select * from product;
+----+------+--------+
| id | name | amount |
+----+------+--------+
|  1 | mi8  |      6 |
+----+------+--------+
1 row in set (0.00 sec)

									mysql> alter table product add column test_01 varchar(10);
											(Blocked)
											
mysql> show processlist;
+-----+-----------+--------------------+---------+-------------+-------+---------------------------------------------------------------+----------------------------------------------------+
| Id  | User      | Host               | db      | Command     | Time  | State                                                         | Info                                               |
+-----+-----------+--------------------+---------+-------------+-------+---------------------------------------------------------------+----------------------------------------------------+
| 152 | repl_test | 192.168.0.55:59522 | NULL    | Binlog Dump | 57330 | Master has sent all binlog to slave; waiting for more updates | NULL                                               |
| 177 | root      | 192.168.0.54:43694 | test_db | Query       |    11 | Waiting for table metadata lock                               | alter table product add column test_01 varchar(10) |
| 178 | root      | 192.168.0.54:43696 | test_db | Sleep       |    28 |                                                               | NULL                                               |
| 179 | root      | localhost          | NULL    | Query       |     0 | starting                                                      | show processlist                                   |
+-----+-----------+--------------------+---------+-------------+-------+---------------------------------------------------------------+----------------------------------------------------+
4 rows in set (0.00 sec)
						

除非是SESSION A执行 COMMIT或者ROLLBACK, SESSION B才能往下执行;
但是mysqldump备份过程是一个大事务, 所有的支持事务的表都是在这个事务中进行读取数据的, 
如果一旦回滚或者提交事务, 那么备份将无法保证一致性, 这时候, 保存点的作用就来了. 

#回滚到保存点sp的位置:
mysql> rollback to savepoint sp;

									SESSION B的DDL语句在 SESSION A中的事务回滚到保存点sp的位置之后,
									立即获取MDL写锁并执行成功;
									mysql> alter table product add column test_01 varchar(10);
										(Query OK)

									
									
# 但是, 这时候再次查询表, 发现 test_01字段已经加上了:
mysql> select * from product;
+----+------+--------+---------+
| id | name | amount | test_01 |
+----+------+--------+---------+
|  1 | mi8  |      6 | NULL    |
+----+------+--------+---------+
1 row in set (0.00 sec)

mysql> rollback;


三. 使用WITH CONSISTENT SNAPSHOT子句, 使用 SAVEPOINT, SESSION A显示开启一个事后先不执行查询, SESSION B使用DDL语句添加一个字段

SESSION A					 						SESSION B

mysql> start transaction with consistent snapshot;

mysql> savepoint sp;

													mysql> alter table product add column test_01 varchar(10);
													(Query OK)

#执行查询, 发现表定义已经改变, 无法执行;													
mysql> select * from product;
ERROR 1412 (HY000): Table definition has changed, please retry transaction

#提交事务, 发现字段已经添加上了:
mysql> commit;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from product;
+----+------+--------+---------+
| id | name | amount | test_01 |
+----+------+--------+---------+
|  1 | mi8  |      6 | NULL    |
+----+------+--------+---------+
1 row in set (0.00 sec)



四. 使用WITH CONSITENT SNAPSHOT子句,   使用 SAVEPOINT,   SESSION A显示开启一个事后先执行查询,   SESSION B使用DDL语句删除一个字段


SESSION A					 						SESSION B

mysql> start transaction with consistent snapshot;

mysql> savepoint sp;

mysql> select * from product;
													mysql> alter table product drop column test_01;
													(Blocked)		
mysql> show processlist;
+----+-----------+--------------------+---------+-------------+------+---------------------------------------------------------------+-----------------------------------------+
| Id | User      | Host               | db      | Command     | Time | State                                                         | Info                                    |
+----+-----------+--------------------+---------+-------------+------+---------------------------------------------------------------+-----------------------------------------+
|  5 | repl_test | 192.168.0.55:59526 | NULL    | Binlog Dump | 7802 | Master has sent all binlog to slave; waiting for more updates | NULL                                    |
| 13 | root      | 192.168.0.54:43708 | test_db | Query       |    0 | starting                                                      | show processlist                        |
| 14 | root      | 192.168.0.54:43710 | test_db | Query       |    6 | Waiting for table metadata lock                               | alter table product drop column test_01 |
| 15 | app_user  | 192.168.0.71:37782 | test_db | Sleep       |  450 |                                                               | NULL                                    |
+----+-----------+--------------------+---------+-------------+------+---------------------------------------------------------------+-----------------------------------------+
4 rows in set (0.00 sec)
	
#回滚到保存点sp的位置:
mysql> rollback to savepoint sp;	
												SESSION B的DDL语句在 SESSION A中的事务回滚到保存点sp的位置之后,
												立即获取MDL写锁并执行成功;
												mysql> alter table product drop column test_01;
													(Query OK)	
													
#执行查询, 发现表定义已经改变, 无法执行;																										
mysql> select * from product;
ERROR 1412 (HY000): Table definition has changed, please retry transaction


mysql> commit;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from product;
+----+------+--------+
| id | name | amount |
+----+------+--------+
|  1 | mi8  |      6 |
+----+------+--------+
1 row in set (0.00 sec)



