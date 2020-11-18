
1. MySQL Server 的长度限制	
	1.1 Compact、utf8mb4
	1.2 Compact、utf8
	1.3 Compact、latin1
	
2. InnoDB层的长度限制
	2.1 COMPACT、latin1	

3. InnoDB表最多可以建立多少个字段	
	3.1 验证行格式为Compact在不同的字符集下分别可以建立多个字段
	3.2 验证行格式为Dynamic在不同的字符集下分别可以建立多个字段
	3.3 utf8、Compact、TEXT
	3.4 utf8、Compact、blob
	3.5 utf8、Compact、longtext
	
4. 小结			
5. 行溢出
6. text和blog字段的其它测试
	6.1 text
	6.2 blob
7. 问题
8. 相关参考
	

1. MySQL Server 的长度限制	

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
	-- select 33*40=1320;
	
	原因：
		MySQL在计算字段长度的时候并不是按照字段的全部长度来记的。
		列字段小于40个字节的都会按实际字节计算，如果大于20 * 2=40 字节就只会按40字节。
		对应到MySQL代码中 storage/innobase/dict/dict0dict.cc 的 dict_index_too_big_for_tree() 中;
		
		CHAR(255) 大于 40，按40个byte来算: select 40*33=1320;  总长度 1320 < 8126, 创建表成功;
		
		-- 这里又不对应不上了;
		-- CHAR 定长类型不是这么算的。
		
	CHAR(255) 31个
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
		   c28 CHAR(255),c29 CHAR(255),c30 CHAR(255),
		   c31 CHAR(255)
		   ) ENGINE=InnoDB ROW_FORMAT=COMPACT DEFAULT CHARSET latin1;
		Query OK, 0 rows affected (0.02 sec)
		
		select 255*31=7905; 总长度 7905 < 8126, 创建表成功;
		select 255*32=8160; 总长度 8160 < 8126, 创建表失败;
		
	----------------------------------------------------------------------------
	
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
		
		MySQL在计算字段长度的时候并不是按照字段的全部长度来记的。
		列字段小于40个字节的都会按实际字节计算，如果大于20 * 2=40 字节就只会按40字节。
		对应到MySQL代码中 storage/innobase/dict/dict0dict.cc 的 dict_index_too_big_for_tree() 中;
		
		VARCHAR(255) 大于 40，按40个byte来算: select 40*33=1320;  总长度 1320 < 8126, 创建表成功;
		-- 这里可以对应上.


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
		
		-- 这里 select 2000*7=14000, 明显大于 8126， 为什么没有提示 Row size too large (> 8126) 
		-- 这里还不理解
		
		原因：
			MySQL在计算字段长度的时候并不是按照字段的全部长度来记的。
			列字段小于40个字节的都会按实际字节计算，如果大于20 * 2=40 字节就只会按40字节。
			对应到MySQL代码中 storage/innobase/dict/dict0dict.cc 的 dict_index_too_big_for_tree() 中;
			
			varchar(2000) 大于 40，按40个byte来算: select 40*7=28;  总长度 28 < 8126, 创建表成功;
				
			-- 这里可以对应上
			-- 理解了。**************
			
			https://mp.weixin.qq.com/s/_Emepy6IUgS6NbQcUC60rg     MySQL的一个表最多可以有多少个字段
			这篇文章写得真好; 
			
			
	-- InnoDB层的长度限制的计算方式：跟字符集有关系，跟定长或者变长类型也有关系
	
	
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

		select concat("field_", id, "VARCHAR(20) NOT NULL,")  from table_20201116 limit 242;
		select concat("field_", ID, " ", "text,")  from table_20201116 limit 198;
		
		select concat("field_", id, "VARCHAR(8) NOT NULL,")  from table_20201116 limit 242;



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
	
	-- Dynamic和Compact行记录格式，两者可以建立字段的个数没差别;	
		
3.3 utf8、Compact、TEXT
	的确可以创建有且仅含有 196 个 TEXT 字段的表。
	
3.4 utf8、Compact、blob
	的确可以创建有且仅含有 196 个 blob 字段的表。
	
3.5 utf8、Compact、longtext
	的确可以创建有且仅含有 196 个 longtext 字段的表。


4. 小结	
	1. 先在Server层判断表结构定义的字符长度是否大于 65535 字节，不超过，则执行到InnoDB存储引擎层，
		接着判断字段长度是否大于 8126 字节，小于则建表成功;
		
	2. 数据插入的时候，没有行溢出的场景下，单记录的长度小于8098字节，则插入成功; 
		否则，插入失败;
		
	3. other

		MySQL对于一行记录的单个字段的数据长度和整行的数据长度的处理方式是不一样的
		单个字段的数据长度大于8098个字节才会行溢出; 
		数据插入的时候，没有行溢出的场景下，单记录的长度小于8098字节，则插入成功; 
		
	-- 可以做为案例来讲解...
	
	
5. 行溢出
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

	-- 单个字段的数据长度大于8198个字节才会行溢出; 
	
	
------------------------------------------------------------------------------------
	
6. text和blog字段的其它测试
6.1 text
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


6.2 blob
	
	drop table if exists table_20201115;
	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `a` blob COMMENT '牌型详情',
	  `b` blob COMMENT '牌型详情',
	  `c` blob COMMENT '牌型详情',
	  `d` blob COMMENT '牌型详情',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;	
	
	mysql>show create table table_20201115\G;
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


Dynamic和Compact行记录格式的区别：
	大字段列的溢出，Compact行记录格式存储大列字段列的前768个字节和20个字节的指针，指针的作用：用于指向溢出的数据页中;
	大字段列的溢出，Dynamin行记录格式只存储20个字节的指针，指针的作用：用于指向溢出的数据页中;  --完成溢出的方式。


	
7. 问题
	
	1. 2个字段溢出，2个字段都有对应的 20字节的指针保留在行记录中吗
		1. 首先，要明白，有这种可能吗
			可以验证下
			答：是的。
			参考笔记：《2020-11-18-行溢出的进阶.sql》
			
	2. MySQL 大字段溢出导致数据回写失败
		Row size too large (> 8126). Changing some ... ... 。
		这个怎么复现
		估计是 innodb_strict_mode=OFF 的场景下才会出现
		-- 复现了，参考笔记：《2020-11-18-insert出现8126的错误-latin1 varchar(100) Compact.sql》和 《2020-11-18-insert出现8126的错误-latin1 varchar(100) dynamic.sql》
	
	3. 参数innodb_strict_mode
		参考笔记：《2020-11-18-innodb_strict_mode.sql》
		
	4. text、blob、longtext 各自可以存储多少字节的数据
		参考笔记：《2020-11-17-text文本型》
		
	5. 
	
		https://blog.opskumu.com/mysql-blob.html
			修改参数：
				innodb_file_format=BARRACUDA
				row_format=dynamic
				
				-- 参考笔记：《2020-11-18-insert出现8126的错误-latin1 varchar(100) dynamic.sql》
				
		按照这种算法，查询之前某个出问题的用户 Blob 字段占用为 7602 「表中有 48 个 blob 字段」，加上其它的占用超过 8kB 就导致 了 Row size too large (> 8126). Changing some ... ... 。
		-- 这里理解了。
		-- 没有行溢出，但是单行的长度大于8126，Compact和Dynamic都一样报错
		-- Compact的行溢出：Compact行记录格式的多个字段行溢出，每个字段存储 767+20 字节在数据页中，超过一定数量(10字段都溢出)，报错....
			mysql> select 8098/(767+20);
			+---------------+
			| 8098/(767+20) |
			+---------------+
			|       10.2897 |
			+---------------+
			1 row in set (0.00 sec)
		
		--这种场景下，行记录格式改为  dynamic， 10个字段都溢出，每个字段存储 20 字节的指针在数据页中，不会报错。
		
		
		
		
8. 相关参考
	https://dev.mysql.com/doc/refman/5.7/en/column-count-limit.html
	https://mp.weixin.qq.com/s/w3ij101jzDlbu93i5J7uQg           故障分析 | MySQL TEXT 字段的限制
	https://mp.weixin.qq.com/s/_aAZ2jTlw6ymCQ092qYkww        	技术分享 | MySQL 字段长度限制的计算方法

	https://mp.weixin.qq.com/s/_Emepy6IUgS6NbQcUC60rg     MySQL的一个表最多可以有多少个字段
		-- 读懂了这篇文章，就可以解决我的疑问; 好文
		-- https://mp.weixin.qq.com/s/tNA_-_MoYt1fJT0icyKbMg       MVCC原理探究及MySQL源码实现分析   这篇文章也是他的
		-- 花了这么多时间，就要弄清楚来; 




利用空闲时间，一个知识点花了4天的时间，可以，
把一个知识点搞懂，比用4天时间看不同的内容强太多; 


