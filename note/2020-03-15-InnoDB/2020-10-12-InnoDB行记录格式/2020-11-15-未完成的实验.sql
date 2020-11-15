
MySQL 大字段溢出导致数据回写失败
	Row size too large (> 8126). Changing some ... ... 。
	这个怎么复现
	
1. Compact、utf8mb4
2. Compact、utf8
3. Compact、latin1



1. Compact、utf8mb4
	
	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  `a` varchar(20000) DEFAULT NULL COMMENT '牌型详情',
	  `b` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
	  `c` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
	  `d` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
	ERROR 1074 (42000): Column length too big for column 'a' (max = 16383); use BLOB or TEXT instead
	
	-- utf8mb4下，varchar单个字段的字符数不能大于 16383

	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  `a` varchar(16382) DEFAULT NULL COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
	ERROR 1074 (42000): Column length too big for column 'a' (max = 16383); use BLOB or TEXT instead
	-- utf8mb4下，varchar单个字段的字符数不能大于等于 16382
	
	CREATE TABLE `table_20201115` (
		`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		`a` varchar(16381) DEFAULT NULL COMMENT '牌型详情',
		PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
	Query OK, 0 rows affected (0.07 sec)
		
	-- utf8mb4下，varchar单个字段的字符数可以小于等于 16381
	
2. Compact、utf8

	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  `a` varchar(21845) DEFAULT NULL COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
	ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs


	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  `a` varchar(21844) DEFAULT NULL COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
	ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs
	
	
	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  `a` varchar(21842) DEFAULT NULL COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
	ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs


	CREATE TABLE `table_20201115` (
		`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		`a` varchar(21841) DEFAULT NULL COMMENT '牌型详情',
		PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
	Query OK, 0 rows affected (0.07 sec)

	-- utf8字符集下，varchar单个字段的字符数可以小于等于 21841
	
	
3. Compact、latin1

	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  `a` varchar(20000) DEFAULT NULL COMMENT '牌型详情',
	  `b` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
	  `c` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
	  `d` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs

	
	drop table if exists table_20201115;
	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  `a` varchar(65532) DEFAULT NULL COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs

	drop table if exists table_20201115;
	CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(65525) DEFAULT NULL COMMENT '牌型详情',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs
		
		
	drop table if exists table_20201115;
	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  `a` varchar(65524) DEFAULT NULL COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	Query OK, 0 rows affected (0.06 sec)
	
	-- latin1字符集下，varchar单个字段的字符数可以小于等于 65524

------------------------------------------------------------------------------------
	drop table if exists table_20201115;
	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `a` varchar(5000) DEFAULT NULL COMMENT '牌型详情',
	  `b` varchar(5000) DEFAULT NULL COMMENT '牌型详情',
	  `c` varchar(5000) DEFAULT NULL COMMENT '牌型详情',
	  `d` varchar(5000) DEFAULT NULL COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;	
	
	
	root@localhost [test2_db]>show create table table_20201115\G;
	*************************** 1. row ***************************
		   Table: table_20201115
	Create Table: CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `a` varchar(5000) DEFAULT NULL COMMENT '牌型详情',
	  `b` varchar(5000) DEFAULT NULL COMMENT '牌型详情',
	  `c` varchar(5000) DEFAULT NULL COMMENT '牌型详情',
	  `d` varchar(5000) DEFAULT NULL COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
	1 row in set (0.00 sec)



INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',5000),REPEAT('a',5000),REPEAT('a',5000),REPEAT('a',5000);
Query OK, 1 row affected (0.03 sec)
Records: 1  Duplicates: 0  Warnings: 0


drop table if exists table_20201115;
CREATE TABLE `table_20201115` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` text COMMENT '牌型详情',
  `b` text COMMENT '牌型详情',
  `c` text COMMENT '牌型详情',
  `d` text COMMENT '牌型详情',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;	

	
	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',5000),REPEAT('b',5000),REPEAT('c',5000),REPEAT('d',5000);
	Query OK, 1 row affected (0.03 sec)
	Records: 1  Duplicates: 0  Warnings: 0
		
	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',10000),REPEAT('b',10000),REPEAT('c',10000),REPEAT('d',10000);
	Query OK, 1 row affected (0.05 sec)
	Records: 1  Duplicates: 0  Warnings: 0

	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',100000),REPEAT('b',100000),REPEAT('c',100000),REPEAT('d',100000);
	ERROR 1406 (22001): Data too long for column 'a' at row 1

	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',50000),REPEAT('b',50000),REPEAT('c',50000),REPEAT('d',50000);
	Query OK, 1 row affected (0.09 sec)
	Records: 1  Duplicates: 0  Warnings: 0


	
drop table if exists table_20201115;
CREATE TABLE `table_20201115` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '牌型详情',
  `b` blob COMMENT '牌型详情',
  `c` blob COMMENT '牌型详情',
  `d` blob COMMENT '牌型详情',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;	

root@localhost [test2_db]>show create table table_20201115\G;
*************************** 1. row ***************************
       Table: table_20201115
Create Table: CREATE TABLE `table_20201115` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '牌型详情',
  `b` blob COMMENT '牌型详情',
  `c` blob COMMENT '牌型详情',
  `d` blob COMMENT '牌型详情',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
1 row in set (0.00 sec)

root@localhost [test2_db]>INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',100000),REPEAT('b',100000),REPEAT('c',100000),REPEAT('d',100000);
ERROR 1406 (22001): Data too long for column 'a' at row 1


root@localhost [test2_db]>INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',50000),REPEAT('b',50000),REPEAT('c',50000),REPEAT('d',50000);
Query OK, 1 row affected (0.06 sec)
Records: 1  Duplicates: 0  Warnings: 0
	

INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',70000),REPEAT('b',70000),REPEAT('c',70000),REPEAT('d',70000);
ERROR 1406 (22001): Data too long for column 'a' at row 1
		
INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',60000),REPEAT('b',60000),REPEAT('c',60000),REPEAT('d',60000);		
Query OK, 1 row affected (0.08 sec)
Records: 1  Duplicates: 0  Warnings: 0


root@localhost [test2_db]>select length(a) from table_20201115 limit 1;
+-----------+
| length(a) |
+-----------+
|     50000 |
+-----------+
1 row in set (0.00 sec)



text blog 各自可以存储多少字节的数据


root@localhost [(none)]>SELECT 65532/2;
+------------+
| 65532/2    |
+------------+
| 32766.0000 |
+------------+
1 row in set (0.00 sec)


