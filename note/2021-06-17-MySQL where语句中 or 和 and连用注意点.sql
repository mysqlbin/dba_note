
root@mysqldb 12:50:  [test_db]> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)


CREATE TABLE `tmp_test` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `price` bigint(20) not null default 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

INSERT INTO `tmp_test` (`ID`, `price`) VALUES ('1', '10');
INSERT INTO `tmp_test` (`ID`, `price`) VALUES ('2', '100');
INSERT INTO `tmp_test` (`ID`, `price`) VALUES ('3', '100');


root@mysqldb 12:50:  [test_db]> select * from tmp_test where id=1 or id=2 and price=100;
+----+-------+
| ID | price |
+----+-------+
|  1 |    10 |
|  2 |   100 |
+----+-------+
2 rows in set (0.01 sec)

root@mysqldb 12:51:  [test_db]> select * from tmp_test where (id=1 or id=2) and price=100;
+----+-------+
| ID | price |
+----+-------+
|  2 |   100 |
+----+-------+
1 row in set (0.00 sec)


相关参考:
	https://www.cnblogs.com/muzixiaodan/p/5632606.html mysql where语句中 or 和 and连用注意点
	
	
总结：
	AND和OR运算符

　　作用：用于基于一个以上的条件对记录进行过滤

　　用法：可在WHERE子句中把两个或多个条件结合在一起。

　　AND：如果第一个条件和第二个条件都成立，才会显示一条记录

　　OR：如果第一个条件和第二个条件中只要有一个成立，则OR运算符就会显示一条记录

　　　　如果两个条件都成立，则显示两条记录

        所以： 不能这样用： where id<10 and id>20;
		
	