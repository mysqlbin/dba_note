

1. 事务隔离级别为 RR可重复读
2. 版本
3. 初始化表结构和数据
4. RR隔离级别下出现脏读
5. 小结


1. 事务隔离级别为 RR可重复读
	root@mysqldb 12:56:  [test_db]> select @@tx_isolation;
	+-----------------+
	| @@tx_isolation  |
	+-----------------+
	| REPEATABLE-READ |
	+-----------------+
	1 row in set, 1 warning (0.00 sec)

	root@mysqldb 12:57:  [test_db]> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| REPEATABLE-READ       |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	root@mysqldb 12:57:  [test_db]> select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| REPEATABLE-READ        |
	+------------------------+
	1 row in set, 1 warning (0.00 sec)

2. 版本
	root@mysqldb 12:57:  [test_db]> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	

3. 初始化表结构和数据
	CREATE TABLE `table_test` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
	  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
	  `nScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
		PRIMARY KEY (`ID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部成员表测试表';
	
	INSERT INTO `table_test` (`ID`, `nClubID`, `nPlayerID`, `nScore`) VALUES ('1', '11', '10', '100');

4. RR隔离级别下出现脏读
	mysql]> select * from table_test;
	+----+---------+-----------+--------+
	| ID | nClubID | nPlayerID | nScore |
	+----+---------+-----------+--------+
	|  1 |      11 |        10 |    100 |
	+----+---------+-----------+--------+
	1 row in set (0.00 sec)


	事务1                                                                           事务2
	start transaction;
	update table_test set nScore=9 where nClubID=11 and nPlayerID=10;
																					mysql> select nScore from table_test where nClubID=11 and nPlayerID=10;
																					+--------+
																					| nScore |
																					+--------+
																					|      9 |
																					+--------+
																					1 row in set (0.00 sec)
																					(这里明显是脏读了.)	
	rollback;
																	
	

																					mysql> select nScore from table_test where nClubID=11 and nPlayerID=10;
																					+--------+
																					| nScore |
																					+--------+
																					|    100 |
																					+--------+
																					1 row in set (0.00 sec)


5. 小结

	确定了是环境的问题, 同样的数据库版本和隔离级别就没有出现脏读的问题.
	
	