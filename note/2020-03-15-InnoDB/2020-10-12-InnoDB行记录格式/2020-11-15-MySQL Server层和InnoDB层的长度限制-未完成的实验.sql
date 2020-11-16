
https://dev.mysql.com/doc/refman/5.7/en/column-count-limit.html
https://mp.weixin.qq.com/s/w3ij101jzDlbu93i5J7uQg               故障分析 | MySQL TEXT 字段的限制
https://mp.weixin.qq.com/s/_aAZ2jTlw6ymCQ092qYkww        技术分享 | MySQL 字段长度限制的计算方法

https://mp.weixin.qq.com/s/_Emepy6IUgS6NbQcUC60rg     MySQL的一个表最多可以有多少个字段


	
768个字节 = 0.75KB
16KB = 16384

MySQL 大字段溢出导致数据回写失败
	Row size too large (> 8126). Changing some ... ... 。
	这个怎么复现
	估计是 innodb_strict_mode=OFF 的场景下才会出现
	

select 8089/27;
root@localhost [(none)]>select 8089/27;
+----------+
| 8089/27  |
+----------+
| 299.5926 |
+----------+
1 row in set (0.00 sec)



innodb_strict_mode

1. MySQL Server 的长度限制	
	1.1 Compact、utf8mb4
	1.2 Compact、utf8
	1.3 Compact、latin1
	
	1.1 Compact、utf8mb4
		
		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(20000) DEFAULT NULL COMMENT '牌型详情',
		  `b` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `c` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `d` varchar(20000) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
		ERROR 1074 (42000): Column length too big for column 'a' (max = 16383); use BLOB or TEXT instead
	
		-- utf8mb4下，ID为bigint unsigned类型，varchar字段的字符数不能大于 16383

		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(16382) DEFAULT NULL COMMENT '牌型详情',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
		ERROR 1074 (42000): Column length too big for column 'a' (max = 16383); use BLOB or TEXT instead
		-- utf8mb4下，ID为bigint unsigned类型，varchar字段的字符数不能大于等于 16382
		
		CREATE TABLE `table_20201115` (
			`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
			`a` varchar(16381) DEFAULT NULL COMMENT '牌型详情',
			PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
		Query OK, 0 rows affected (0.07 sec)
			
		-- utf8mb4下，ID为bigint unsigned类型，varchar字段的字符数可以小于等于 16381
		
	1.2 Compact、utf8

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

		-- utf8字符集下，ID为bigint unsigned类型，varchar字段的字符数可以小于等于 21841
		
		
	1.3 Compact、latin1

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
		
		-- latin1字符集下，ID为bigint unsigned类型，varchar字段的字符数可以小于等于 65524



2. InnoDB层的长度限制

2.1 COMPACT、latin1
	[SQL]CREATE TABLE t4 (
		   c1 CHAR(255),c2 CHAR(255),c3 CHAR(255),
		   c4 CHAR(255),c5 CHAR(255),c6 CHAR(255),
		   c7 CHAR(255),c8 CHAR(255),c9 CHAR(255),
		   c10 CHAR(255),c11 CHAR(255),c12 CHAR(255),
		   c13 CHAR(255),c14 CHAR(255),c15 CHAR(255),
		   c16 CHAR(255),c17 CHAR(255),c18 CHAR(255),
		   c19 CHAR(255),c20 CHAR(255),c21 CHAR(255),
		   c22 CHAR(255),c23 CHAR(255),c24 CHAR(255),
		   c25 CHAR(255),c26 CHAR(255),c27 CHAR(255),
		   c28 CHAR(255),c29 CHAR(255),c30 CHAR(255),
		   c31 CHAR(255),c32 CHAR(255),c33 CHAR(255)
		   ) ENGINE=InnoDB ROW_FORMAT=COMPACT DEFAULT CHARSET latin1;
	[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.
	
	
	单行定义的长度：SELECT 255*33=8415 字符(字节), 因为这里的字符集为 latin1，所以1个字符=1个字节
	
	-- char(255)，定义类型，
	
	VARCHAR
		CREATE TABLE t5 (
		   c1 VARCHAR(255),c2 VARCHAR(255),c3 VARCHAR(255),
		   c4 VARCHAR(255),c5 VARCHAR(255),c6 VARCHAR(255),
		   c7 VARCHAR(255),c8 VARCHAR(255),c9 VARCHAR(255),
		   c10 VARCHAR(255),c11 VARCHAR(255),c12 VARCHAR(255),
		   c13 VARCHAR(255),c14 VARCHAR(255),c15 VARCHAR(255),
		   c16 VARCHAR(255),c17 VARCHAR(255),c18 VARCHAR(255),
		   c19 VARCHAR(255),c20 VARCHAR(255),c21 VARCHAR(255),
		   c22 VARCHAR(255),c23 VARCHAR(255),c24 VARCHAR(255),
		   c25 VARCHAR(255),c26 VARCHAR(255),c27 VARCHAR(255),
		   c28 VARCHAR(255),c29 VARCHAR(255),c30 VARCHAR(255),
		   c31 VARCHAR(255),c32 VARCHAR(255),c33 VARCHAR(255)
		   ) ENGINE=InnoDB ROW_FORMAT=COMPACT DEFAULT CHARSET latin1;
		Query OK, 0 rows affected (0.02 sec)

	
	CHAR
		CREATE TABLE t4 (
		   c1 CHAR(255),c2 CHAR(255),c3 CHAR(255),
		   c4 CHAR(255),c5 CHAR(255),c6 CHAR(255),
		   c7 CHAR(255),c8 CHAR(255),c9 CHAR(255),
		   c10 CHAR(255),c11 CHAR(255),c12 CHAR(255),
		   c13 CHAR(255),c14 CHAR(255),c15 CHAR(255),
		   c16 CHAR(255),c17 CHAR(255),c18 CHAR(255),
		   c19 CHAR(255),c20 CHAR(255),c21 CHAR(255),
		   c22 CHAR(255),c23 CHAR(255),c24 CHAR(255),
		   c25 CHAR(255),c26 CHAR(255),c27 CHAR(255),
		   c28 CHAR(255),c29 CHAR(255),c30 CHAR(255)
		   ) ENGINE=InnoDB ROW_FORMAT=COMPACT DEFAULT CHARSET latin1;
		Query OK, 0 rows affected (0.02 sec)

	varchar(2000)
		drop table if exists table_20201115;
		CREATE TABLE `table_20201115` (
			`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
			`a` varchar(2000) DEFAULT NULL COMMENT '牌型详情',
			`b` varchar(2000) DEFAULT NULL COMMENT '牌型详情',
			`c` varchar(2000) DEFAULT NULL COMMENT '牌型详情',
			`d` varchar(2000) DEFAULT NULL COMMENT '牌型详情',
			`e` varchar(2000) DEFAULT NULL COMMENT '牌型详情',
			`f` varchar(2000) DEFAULT NULL COMMENT '牌型详情',
			`g` varchar(2000) DEFAULT NULL COMMENT '牌型详情',
			PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
		Query OK, 0 rows affected (0.20 sec)
		
		-- 这里 select 2000*8=16000, 明显大于 8126， 为什么没有提示 Row size too large (> 8126) 
		-- 这里还不理解

3. InnoDB表最多可以建立多少个字段	
	
3.1 验证行格式为Compact在不同的字符集下分别可以建立多个字段

	制造相关数据
		CREATE TABLE `table_20201116` (
		  `id` int(10) unsigned NOT NULL,
		  PRIMARY KEY (`id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;


		DROP PROCEDURE IF EXISTS insertbatch_20201116;
		CREATE PROCEDURE insertbatch_20201116()
		BEGIN
		DECLARE i INT;
		  SET i=1;
			start transaction;
		  WHILE(i<=2000) DO
			INSERT INTO table_20201116(id)VALUES(i);
			SET i=i+1; 
		  END WHILE;
			commit;
		END;


		call insertbatch_20201116();

		select concat("field_", i, "VARCHAR(20) NOT NULL,") table_20201116 from limit 242;


	utf8mb4、Compact
		197个 varchar(20) 字段
		
	utf8、Compact
		197个 varchar(20) 字段
		
	latin1、Compact
		385个 varchar(20) 字段

		
3.2 验证行格式为Dynamic在不同的字符集下分别可以建立多个字段

	utf8mb4、Dynamic
		197个 varchar(20) 字段
		
	utf8、Dynamic
		197个 varchar(20) 字段
		
	latin1、Compact
		385个 varchar(20) 字段
		
		
3.3 TEXT
	同时我们也进行了测试，的确可以创建有且仅含有 196 个 TEXT 字段的表。
	
3.4 blob


	
小结	
	先在Server层判断表结构定义的字符长度是否大于 65535 字节，不超过，则执行到InnoDB存储引擎层，
	接着判断长度是否大于 8126 字节，小于则建表成功;
	

行溢出
	CREATE TABLE `table_20201115` (
		`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		`a` varchar(16381) DEFAULT NULL COMMENT '牌型详情',
		PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
	Query OK, 0 rows affected (0.07 sec)
		
	-- utf8mb4下，ID为bigint unsigned类型，varchar字段的字符数可以小于等于 16381
	
	`a` varchar(16381)，16381个字符全部填满，占65524字节(64KB)，明显行溢出了
	
	mysql> select 16381*4;
	+---------+
	| 16381*4 |
	+---------+
	|   65524 |
	+---------+
	1 row in set (0.00 sec)

	
	mysql> select 16381/8;
	+-----------+
	| 16381/8   |
	+-----------+
	| 2047.6250 |
	+-----------+
	1 row in set (0.00 sec)
		


------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
	
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

text

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


blob
	
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


