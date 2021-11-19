




mysql> show global variables like '%innodb_locks_unsafe_for_binlog%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_locks_unsafe_for_binlog | OFF   |
+--------------------------------+-------+
1 row in set (0.00 sec)

innodb_locks_unsafe_for_binlog默认为off：表示不禁用gap锁(在RR隔离级别+innodb_locks_unsafe_for_binlog=off会开启gap锁)。


如果设置为1（ON），会禁用gap锁，但对于外键冲突检测（foreign-key constraint checking）或者重复键检测（duplicate-key checking）还是会用到gap锁。

启用innodb_locks_unsafe_for_binlog产生的影响等同于将隔离级别设置为RC，不同之处是：

	1. innodb_locks_unsafe_for_binlog是全局参数，影响所有session；但隔离级别可以是全局也可以是会话级别。

	2. innodb_locks_unsafe_for_binlog只能在数据库启动的时候设置；但隔离级别可以随时更改。
	
	基于上述原因，RC相比于innodb_locks_unsafe_for_binlog会更好更灵活。





https://zhuanlan.zhihu.com/p/36682577



RR隔离级别+innodb_locks_unsafe_for_binlog=1：
	
	不存在间隙锁。

	show global variables like '%isolation%';
	show global variables like '%innodb_locks_unsafe_for_binlog%';


	root@mysqldb 16:58:  [test_Db]> show global variables like '%innodb_locks_unsafe_for_binlog%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_locks_unsafe_for_binlog | ON    |
	+--------------------------------+-------+
	1 row in set (0.01 sec)

	root@mysqldb 16:58:  [test_Db]> 
	root@mysqldb 16:58:  [test_Db]> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	| tx_isolation          | REPEATABLE-READ |
	+-----------------------+-----------------+
	2 rows in set (0.00 sec)

	CREATE TABLE `t1` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


	insert into t1 values(0,0,0),(5,5,5),
	(10,10,10),(15,15,15),(20,20,20),(25,25,25);


	SESSION A                       		SESSION B
	begin;									
	select * from t1 where id=7 for update;
											begin;
											select * from t1 where id=7 for update;
											(Query OK)
											insert into t1 values(9,9,9);
											Query OK, 1 row affected (0.00 sec)


									