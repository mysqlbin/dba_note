
1. explicit_defaults_for_timestamp=OFF and timestamp NOT NULL
2. explicit_defaults_for_timestamp=OFF and timestamp NULL DEFAULT NULL
3. explicit_defaults_for_timestamp=ON and timestamp NULL DEFAULT NULL
4. explicit_defaults_for_timestamp=OFF and timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
5. 小结
6. 相关参考



1. explicit_defaults_for_timestamp=OFF and timestamp NOT NULL

	mysql> show global variables like '%explicit_defaults_for_timestamp%'; 
	+---------------------------------+-------+
	| Variable_name                   | Value |
	+---------------------------------+-------+
	| explicit_defaults_for_timestamp | OFF   |
	+---------------------------------+-------+
	1 row in set (0.00 sec)


	CREATE TABLE `table_abcdgoods` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `aaaaaaaaa` int(12) NOT NULL COMMENT '',
	  `bbbbbbb` int(12) NOT NULL COMMENT '',
	  `cccccccc` int(12) NOT NULL COMMENT '',
	  `num` int(12) NOT NULL COMMENT '',
	  `lastOpTime` timestamp NOT NULL COMMENT '最后操作时间',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	mysql> show create table table_abcdgoods;
	+-----------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Table           | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
	+-----------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| table_abcdgoods | CREATE TABLE `table_abcdgoods` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `aaaaaaaaa` int(12) NOT NULL COMMENT '',
	  `bbbbbbb` int(12) NOT NULL COMMENT '',
	  `cccccccc` int(12) NOT NULL COMMENT '',
	  `num` int(12) NOT NULL COMMENT '',
	  `lastOpTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后操作时间',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4                  |
	+-----------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)

	--可以看到，表的timestamp字段的属性发生了改变, 会导致行记录有发生修改，timestamp的值也会修改为当前时间。
	


2. explicit_defaults_for_timestamp=OFF and timestamp NULL DEFAULT NULL

	mysql> show global variables like '%explicit_defaults_for_timestamp%'; 
	+---------------------------------+-------+
	| Variable_name                   | Value |
	+---------------------------------+-------+
	| explicit_defaults_for_timestamp | OFF   |
	+---------------------------------+-------+
	1 row in set (0.00 sec)
	
	drop table  if exists table_abcdgoods;
	CREATE TABLE `table_abcdgoods` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `aaaaaaaaa` int(12) NOT NULL COMMENT '',
	  `bbbbbbb` int(12) NOT NULL COMMENT '',
	  `cccccccc` int(12) NOT NULL COMMENT '',
	  `num` int(12) NOT NULL COMMENT '',
	  `lastOpTime` timestamp NULL DEFAULT NULL COMMENT '最后操作时间',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	
	mysql> show create table table_abcdgoods\G;
	*************************** 1. row ***************************
		   Table: table_abcdgoods
	Create Table: CREATE TABLE `table_abcdgoods` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `aaaaaaaaa` int(12) NOT NULL,
	  `bbbbbbb` int(12) NOT NULL,
	  `cccccccc` int(12) NOT NULL,
	  `num` int(12) NOT NULL,
	  `lastOpTime` timestamp NULL DEFAULT NULL COMMENT '最后操作时间',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)


	INSERT INTO `table_abcdgoods` (`ID`, `aaaaaaaaa`, `bbbbbbb`, `cccccccc`, `num`, `lastOpTime`) VALUES ('1', '120002', '10420', '1', '70', '2020-10-14 16:26:24');

	root@mysqldb 17:21:  [test_db]> select * from table_abcdgoods;
	+----+-----------+---------+----------+-----+---------------------+
	| ID | aaaaaaaaa | bbbbbbb | cccccccc | num | lastOpTime          |
	+----+-----------+---------+----------+-----+---------------------+
	|  1 |    120002 |   10420 |        1 |  70 | 2020-10-14 16:26:24 |
	+----+-----------+---------+----------+-----+---------------------+
	1 row in set (0.00 sec)


	mysql> update table_abcdgoods set num=80 where aaaaaaaaa=120002;
	Query OK, 1 row affected (0.08 sec)
	Rows matched: 1  Changed: 1  Warnings: 0
	
	
	mysql> select * from table_abcdgoods;
	+----+-----------+---------+----------+-----+---------------------+
	| ID | aaaaaaaaa | bbbbbbb | cccccccc | num | lastOpTime          |
	+----+-----------+---------+----------+-----+---------------------+
	|  1 |    120002 |   10420 |        1 |  80 | 2020-10-14 16:26:24 |
	+----+-----------+---------+----------+-----+---------------------+
	1 row in set (0.00 sec)


	explicit_defaults_for_timestamp=OFF and timestamp NULL DEFAULT NULL: 不会改变表结构。
	
	
3. explicit_defaults_for_timestamp=ON and timestamp NULL DEFAULT NULL

	mysql> show global variables like '%explicit_defaults_for_timestamp%'; 
	+---------------------------------+-------+
	| Variable_name                   | Value |
	+---------------------------------+-------+
	| explicit_defaults_for_timestamp | ON    |
	+---------------------------------+-------+
	1 row in set (0.00 sec)

	drop table  if exists table_abcdgoods;
	CREATE TABLE `table_abcdgoods` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `aaaaaaaaa` int(12) NOT NULL COMMENT '',
	  `bbbbbbb` int(12) NOT NULL COMMENT '',
	  `cccccccc` int(12) NOT NULL COMMENT '',
	  `num` int(12) NOT NULL COMMENT '',
	  `lastOpTime` timestamp NULL DEFAULT NULL COMMENT '最后操作时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_aaaaaaaaa_bbbbbbb` (`aaaaaaaaa`,`bbbbbbb`),
	  KEY `idx_cccccccc` (`cccccccc`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


	INSERT INTO `table_abcdgoods` (`ID`, `aaaaaaaaa`, `bbbbbbb`, `cccccccc`, `num`, `lastOpTime`) VALUES ('1', '120002', '10420', '1', '70', '2020-10-14 16:26:24');

	
	root@mysqldb 17:42:  [test_db]> select * from table_abcdgoods;
	+----+-----------+---------+----------+-----+---------------------+
	| ID | aaaaaaaaa | bbbbbbb | cccccccc | num | lastOpTime          |
	+----+-----------+---------+----------+-----+---------------------+
	|  1 |    120002 |   10420 |        1 |  70 | 2020-10-14 16:26:24 |
	+----+-----------+---------+----------+-----+---------------------+
	1 row in set (0.00 sec)

	root@mysqldb 17:42:  [test_db]> select * from table_abcdgoods;
	+----+-----------+---------+----------+-----+---------------------+
	| ID | aaaaaaaaa | bbbbbbb | cccccccc | num | lastOpTime          |
	+----+-----------+---------+----------+-----+---------------------+
	|  1 |    120002 |   10420 |        1 |  70 | 2020-10-14 16:26:24 |
	+----+-----------+---------+----------+-----+---------------------+
	1 row in set (0.00 sec)

	root@mysqldb 17:43:  [test_db]> update table_abcdgoods set num=80 where aaaaaaaaa=120002;
	Query OK, 1 row affected (0.06 sec)
	Rows matched: 1  Changed: 1  Warnings: 0

	root@mysqldb 17:43:  [test_db]> select * from table_abcdgoods;
	+----+-----------+---------+----------+-----+---------------------+
	| ID | aaaaaaaaa | bbbbbbb | cccccccc | num | lastOpTime          |
	+----+-----------+---------+----------+-----+---------------------+
	|  1 |    120002 |   10420 |        1 |  80 | 2020-10-14 16:26:24 |
	+----+-----------+---------+----------+-----+---------------------+
	1 row in set (0.00 sec)
	
	explicit_defaults_for_timestamp=ON and timestamp NULL DEFAULT NULL： 不会改变表结构。


4. explicit_defaults_for_timestamp=OFF and timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP

	mysql> show global variables like '%explicit_defaults_for_timestamp%'; 
	+---------------------------------+-------+
	| Variable_name                   | Value |
	+---------------------------------+-------+
	| explicit_defaults_for_timestamp | OFF   |
	+---------------------------------+-------+
	1 row in set (0.08 sec)


	CREATE TABLE `table_abcdgoods` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `aaaaaaaaa` int(12) NOT NULL COMMENT '',
	  `bbbbbbb` int(12) NOT NULL COMMENT '',
	  `cccccccc` int(12) NOT NULL COMMENT '',
	  `num` int(12) NOT NULL COMMENT '',
	  `lastOpTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后操作时间',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	

	mysql> show create table table_abcdgoods\G;
	*************************** 1. row ***************************
		   Table: table_abcdgoods
	Create Table: CREATE TABLE `table_abcdgoods` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `aaaaaaaaa` int(12) NOT NULL,
	  `bbbbbbb` int(12) NOT NULL,
	  `cccccccc` int(12) NOT NULL,
	  `num` int(12) NOT NULL,
	  `lastOpTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后操作时间',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)

	
5. 小结
	
	MySQL的参数 explicit_defaults_for_timestamp  默认是OFF.
	explicit_defaults_for_timestamp 变量会直接影响表结构，也就是说 explicit_defaults_for_timestamp 的作用时间  --遇到了。
	
	explicit defaults for timestamp: 定义时间戳的显式默认值
	
	explicit_defaults_for_timestamp=OFF and timestamp NOT NULL：会改变表结构。
	
	explicit_defaults_for_timestamp=OFF and timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP：不会改变表结构。
	
	explicit_defaults_for_timestamp=OFF and timestamp NULL DEFAULT NULL: 不会改变表结构。
	
	explicit_defaults_for_timestamp=ON and timestamp NULL DEFAULT NULL： 不会改变表结构。
	
	
	

6. 相关参考

	https://www.cnblogs.com/JiangLe/p/6956865.html  mysql explicit_defaults_for_timestamp 变量的作用
	https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp
		Default Value	OFF
		
	https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp
		Default Value	ON

	https://mp.weixin.qq.com/s/vNOolZAvY_QkQ88bb7Cb5w		技术分享 | MySQL 的 TIMESTAMP 类型字段非空和默认值属性的影响
	https://mp.weixin.qq.com/s/nFO6xOuzfh8kOYDj99xE0g  		故障分析 | MySQL 迁移后 timestamp 列 cannot be null
	
	
	