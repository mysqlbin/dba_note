
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
			
5. 行溢出
6. text和blog字段的其它测试
	6.1 text
	6.2 blob
	
7. 问题
8. 相关参考
9. 在线修改行记录格式为Compact
10. 三种报错
	10.1 错误1 创建表报maximum row size > 65535
	10.2 错误2 创建表报Row size too large (> 8126)
	10.3 错误3 表创建成功但是插入报 Row size too large (> 8126)

11. 总结
	

1. MySQL Server 的长度限制	

	1.1 Compact、utf8mb4
		
		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(20000) DEFAULT NULL COMMENT '...',
		  `b` varchar(20000) NOT NULL DEFAULT '' COMMENT '...',
		  `c` varchar(20000) NOT NULL DEFAULT '' COMMENT '...',
		  `d` varchar(20000) NOT NULL DEFAULT '' COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
		ERROR 1074 (42000): Column length too big for column 'a' (max = 16383); use BLOB or TEXT instead
		
		-- utf8mb4下，ID为bigint unsigned类型，varchar字段的字符数不能大于 16383

		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(16382) DEFAULT NULL COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
		ERROR 1074 (42000): Column length too big for column 'a' (max = 16383); use BLOB or TEXT instead
		-- utf8mb4下，ID为bigint unsigned类型，varchar字段的字符数不能大于等于 16382
		
		CREATE TABLE `table_20201115` (
			`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
			`a` varchar(16381) DEFAULT NULL COMMENT '...',
			PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
		Query OK, 0 rows affected (0.07 sec)
			
		-- utf8mb4下，ID为bigint unsigned类型，varchar字段的字符数可以小于等于 16381
		
		mysql>select  16381*4;
		+---------+
		| 16381*4 |
		+---------+
		|   65524 |
		+---------+
		1 row in set (0.01 sec)
		
	1.2 Compact、utf8

		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(21845) DEFAULT NULL COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
		ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. 
			This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs
			-- 记录的最大长度限制不包括BLOB等字段。


			之所以将BLOB和TEXT排除在外，是因为它的内容会单独存储在其它页中。但即便如此，存储BLOB和TEXT的指针信息也需要9 ~ 12个字节，具体来说：
			-- 这里需要验证。
				TINYTEXT(TINYBLOB): 9 字节
				TEXT(BLOB): 10 字节
				MEDIUMTEXT(MEDIUMBLOB): 11字节
				LONGTEXT(LONGBLOB): 12字节。
				看下面这个示例，指定了2个列，分别定义为VARCHAR和TEXT。

					mysql> create table t (c1 varchar(65524) not null,c2 text not null) charset latin1;
					ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change somecolumns to TEXT or BLOBs

					mysql> create table t (c1 varchar(65523) not null,c2 text not null) charset latin1;
					Query OK, 0 rows affected (0.13 sec)
					
					因为TEXT占了10个字节，所以 c1 最大可设置为 65535 - 10 - 2 = 65523。

		
		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(21844) DEFAULT NULL COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
		ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs
		
		
		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(21842) DEFAULT NULL COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
		ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs


		CREATE TABLE `table_20201115` (
			`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
			`a` varchar(21841) DEFAULT NULL COMMENT '...',
			PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
		Query OK, 0 rows affected (0.07 sec)

		-- utf8字符集下，ID为bigint unsigned类型，varchar字段的字符数可以小于等于 21841
		mysql> select 21841*3;
		+---------+
		| 21841*3 |
		+---------+
		|   65523 |
		+---------+
		1 row in set (0.00 sec)
		
		mysql>select 21841-16381;
		+-------------+
		| 21841-16381 |
		+-------------+
		|        5460 |
		+-------------+
		1 row in set (0.00 sec)
		
		utf8 比 utf8mb4 可以多存储 大约 5460个字符。
		
	1.3 Compact、latin1

		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(20000) DEFAULT NULL COMMENT '...',
		  `b` varchar(20000) NOT NULL DEFAULT '' COMMENT '...',
		  `c` varchar(20000) NOT NULL DEFAULT '' COMMENT '...',
		  `d` varchar(20000) NOT NULL DEFAULT '' COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
		ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs

		
		drop table if exists table_20201115;
		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(65532) DEFAULT NULL COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
		ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs

		drop table if exists table_20201115;
		CREATE TABLE `table_20201115` (
			  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
			  `a` varchar(65525) DEFAULT NULL COMMENT '...',
			  PRIMARY KEY (`ID`)
			) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
		ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs
			
			
		drop table if exists table_20201115;
		CREATE TABLE `table_20201115` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  `a` varchar(65524) DEFAULT NULL COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
		Query OK, 0 rows affected (0.06 sec)
		
		-- latin1字符集下，ID为bigint unsigned类型，varchar字段的字符数可以小于等于 65524

	1.4 小结
		
		utf8mb4字符集下，ID为bigint unsigned类型，varchar字段的字符数不能大于等于 16382
		utf8字符集下，   ID为bigint unsigned类型，varchar字段的字符数不能大于等于 21842
		latin1字符集下， ID为bigint unsigned类型，varchar字段的字符数不能大于等于 65525

	
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

2.2 COMPACT、utf8mb4

	varchar(2000)
		drop table if exists table_20201115;
		CREATE TABLE `table_20201115` (
			`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
			`a` varchar(2000) DEFAULT NULL COMMENT '...',
			`b` varchar(2000) DEFAULT NULL COMMENT '...',
			`c` varchar(2000) DEFAULT NULL COMMENT '...',
			`d` varchar(2000) DEFAULT NULL COMMENT '...',
			`e` varchar(2000) DEFAULT NULL COMMENT '...',
			`f` varchar(2000) DEFAULT NULL COMMENT '...',
			`g` varchar(2000) DEFAULT NULL COMMENT '...',
			PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;
		Query OK, 0 rows affected (0.20 sec)
		
		-- 这里 select 2000*7=14000, 明显大于 8126， 为什么没有提示 Row size too large (> 8126) 
		-- 这里还不理解
		
		原因：
			MySQL在计算字段长度的时候并不是按照字段的全部长度来记的。
			列字段小于40个字节的都会按实际字节计算，如果大于20 * 2=40 字节就只会按40字节。
			对应到MySQL代码中 storage/innobase/dict/dict0dict.cc 的 dict_index_too_big_for_tree() 中;
			
			varchar(2000) 大于 40，按40个byte来算: select 40*7=280;  总长度 280 < 8126, 创建表成功;
				
			-- 这里可以对应上
			-- 理解了。**************
			
			https://mp.weixin.qq.com/s/_Emepy6IUgS6NbQcUC60rg     MySQL的一个表最多可以有多少个字段
			-- 这篇文章写得真好; 
			
			
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





5. 行溢出

	CREATE TABLE `table_20201115` (
		`ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		`a` varchar(16381) DEFAULT NULL COMMENT '...',
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

	-- 大字段类型下，实际数据长度大于8098个字节才会行溢出; 
	
	
------------------------------------------------------------------------------------
	
6. text和blog字段的其它测试

6.1 text
	drop table if exists table_20201115;
	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `a` text COMMENT '...',
	  `b` text COMMENT '...',
	  `c` text COMMENT '...',
	  `d` text COMMENT '...',
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
	-- Data too long for column 'a' at row 1
	
	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',50000),REPEAT('b',50000),REPEAT('c',50000),REPEAT('d',50000);
	Query OK, 1 row affected (0.09 sec)
	Records: 1  Duplicates: 0  Warnings: 0


6.2 blob
	
	drop table if exists table_20201115;
	CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `a` blob COMMENT '...',
	  `b` blob COMMENT '...',
	  `c` blob COMMENT '...',
	  `d` blob COMMENT '...',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;	
	
	mysql> show create table table_20201115\G;
	*************************** 1. row ***************************
		   Table: table_20201115
	Create Table: CREATE TABLE `table_20201115` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `a` blob COMMENT '...',
	  `b` blob COMMENT '...',
	  `c` blob COMMENT '...',
	  `d` blob COMMENT '...',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
	1 row in set (0.00 sec)

	mysql> INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',100000),REPEAT('b',100000),REPEAT('c',100000),REPEAT('d',100000);
	ERROR 1406 (22001): Data too long for column 'a' at row 1
	-- Data too long for column 'a' at row 1

	mysql> INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',50000),REPEAT('b',50000),REPEAT('c',50000),REPEAT('d',50000);
	Query OK, 1 row affected (0.06 sec)
	Records: 1  Duplicates: 0  Warnings: 0
	
	select 50000*4 = 200000;
	
	mysql> select count(*) from table_20201115;
	+----------+
	| count(*) |
	+----------+
	|        1 |
	+----------+
	1 row in set (0.00 sec)

	[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_20201115.ibd 
	page offset 00000000, page type <File Space Header>
	page offset 00000001, page type <Insert Buffer Bitmap>
	page offset 00000002, page type <File Segment inode>
	page offset 00000003, page type <B-tree Node>, page level <0000>
	page offset 00000004, page type <Uncompressed BLOB Page>
	page offset 00000005, page type <Uncompressed BLOB Page>
	page offset 00000006, page type <Uncompressed BLOB Page>
	page offset 00000007, page type <Uncompressed BLOB Page>
	page offset 00000008, page type <Uncompressed BLOB Page>
	page offset 00000009, page type <Uncompressed BLOB Page>
	page offset 0000000a, page type <Uncompressed BLOB Page>
	page offset 0000000b, page type <Uncompressed BLOB Page>
	page offset 0000000c, page type <Uncompressed BLOB Page>
	page offset 0000000d, page type <Uncompressed BLOB Page>
	page offset 0000000e, page type <Uncompressed BLOB Page>
	page offset 0000000f, page type <Uncompressed BLOB Page>
	page offset 00000010, page type <Uncompressed BLOB Page>
	page offset 00000011, page type <Uncompressed BLOB Page>
	page offset 00000012, page type <Uncompressed BLOB Page>
	page offset 00000013, page type <Uncompressed BLOB Page>
	Total number of page: 20:
	Insert Buffer Bitmap: 1
	Uncompressed BLOB Page: 16
	File Space Header: 1
	B-tree Node: 1
	File Segment inode: 1
	
	--------------------------------------------------------------------------------------------------------------------------------------------

	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',70000),REPEAT('b',70000),REPEAT('c',70000),REPEAT('d',70000);
	ERROR 1406 (22001): Data too long for column 'a' at row 1
	-- Data too long for column 'a' at row 1
	
	
	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',60000),REPEAT('b',60000),REPEAT('c',60000),REPEAT('d',60000);		
	Query OK, 1 row affected (0.08 sec)
	Records: 1  Duplicates: 0  Warnings: 0
	
	mysql> select length(a) from table_20201115 limit 1;
	+-----------+
	| length(a) |
	+-----------+
	|     50000 |
	+-----------+
	1 row in set (0.00 sec)



7. 问题
	
	1. 2个字段溢出，2个字段都有对应的 20字节的指针保留在行记录中吗
		1. 首先，要明白，有这种可能吗
			可以验证下
			答：不会。
			参考笔记：《2020-11-18-行溢出的进阶.sql》
			
	2. MySQL 插入数据的总字节数大于8126导致数据写入失败
		
		Row size too large (> 8126). Changing some ... ... 。
		-- 复现了，参考笔记：《2020-11-18-insert出现8126的错误-latin1 varchar(100) Compact.sql》和 《2020-11-18-insert出现8126的错误-latin1 varchar(100) dynamic.sql》
		
		
	3. 参数innodb_strict_mode
		参考笔记：《2020-11-18-innodb_strict_mode.sql》
		
	4. text、blob、longtext 各自可以存储多少字节的数据
		
		参考笔记：《2020-11-17-196_Compact_utf8_text文本型.sql》
		
	5. 理解某篇文章通过修改row_format=dynamic解决插入数据报错问题
	
		https://blog.opskumu.com/mysql-blob.html
			修改参数：
				innodb_file_format=BARRACUDA
				row_format=dynamic
		-- 可以做为案例来讲解，体现了自己对行记录格式的深入研究。
		
		按照这种算法，查询之前某个出问题的用户 Blob 字段占用为 7602 「表中有 48 个 blob 字段」，加上其它的占用超过 8kB 就导致 了 Row size too large (> 8126). Changing some ... ... 。
		
		-- 有表结构设计不合理的原因。
		-- 这里理解了。
		-- Compact的行溢出：Compact行记录格式的多个字段行溢出，每个字段存储 768+20 字节在数据页中，超过一定数量(10字段都溢出)，报错....
			mysql> select 8098/768;
			+----------+
			| 8098/768 |
			+----------+
			|  10.5443 |
			+----------+
			1 row in set (0.00 sec)
		
		-- 这种场景下，行记录格式改为  dynamic， 10个字段都溢出，每个字段存储 20 字节的指针在数据页中，不会报错。
			
			mysql> select 8098/20;
			+----------+
			| 8098/20  |
			+----------+
			| 404.9000 |
			+----------+
			1 row in set (0.00 sec)

		-- 没有行溢出，但是单行的长度大于8126，Compact和Dynamic都一样报错
			
			-- 参考笔记：《2020-11-18-insert出现8126的错误-latin1 varchar(100) Compact.sql》和 《2020-11-18-insert出现8126的错误-latin1 varchar(100) dynamic.sql》
			
		
	6. 关于参数值的修改

		SET GLOBAL innodb_file_format=BARRACUDA;  --修改之后，ROW_FORMAT=Compact是不是不生效了？不是的。
		ALTER TABLE `t_role_90`  ROW_FORMAT=DYNAMIC;  -- 会重建表吗？ 根据原理，是重建表。
	
8. 相关参考

	https://dev.mysql.com/doc/refman/5.7/en/column-count-limit.html
	https://mp.weixin.qq.com/s/w3ij101jzDlbu93i5J7uQg           故障分析 | MySQL TEXT 字段的限制
	https://mp.weixin.qq.com/s/_aAZ2jTlw6ymCQ092qYkww        	技术分享 | MySQL 字段长度限制的计算方法

	https://mp.weixin.qq.com/s/_Emepy6IUgS6NbQcUC60rg     MySQL的一个表最多可以有多少个字段
		-- 读懂了这篇文章，就可以解决我的疑问; 好文
		-- https://mp.weixin.qq.com/s/tNA_-_MoYt1fJT0icyKbMg       MVCC原理探究及MySQL源码实现分析   这篇文章也是他的
		-- 花了这么多时间，就要弄清楚来; 
    https://mp.weixin.qq.com/s/uCiizaoeu5qKF7mt25SDAg   说说 VARCHAR 背后的那些事
	
	   
9. 在线修改行记录格式为Compact

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%file_format%';  
	+--------------------------+-----------+
	| Variable_name            | Value     |
	+--------------------------+-----------+
	| innodb_file_format       | Barracuda |
	| innodb_file_format_check | ON        |
	| innodb_file_format_max   | Barracuda |
	+--------------------------+-----------+
	3 rows in set (0.00 sec)

	mysql> set global innodb_file_format=Antelope;
	Query OK, 0 rows affected, 1 warning (0.00 sec)

	mysql> show global variables like '%file_format%';                                                                                                                                                                                              
	+--------------------------+-----------+
	| Variable_name            | Value     |
	+--------------------------+-----------+
	| innodb_file_format       | Antelope  |
	| innodb_file_format_check | ON        |
	| innodb_file_format_max   | Barracuda |
	+--------------------------+-----------+
	3 rows in set (0.01 sec)
	
	mysql> show global variables like '%innodb_default_row_format%';     
	+---------------------------+---------+
	| Variable_name             | Value   |
	+---------------------------+---------+
	| innodb_default_row_format | dynamic |
	+---------------------------+---------+
	1 row in set (0.01 sec)

	mysql> select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='test_db' and  TABLE_NAME='t_20201019';
	+------------+
	| ROW_FORMAT |
	+------------+
	| Dynamic    |
	+------------+
	1 row in set (0.00 sec)
	
	mysql> ALTER TABLE t_20201019 ROW_FORMAT=Compact;
	Query OK, 0 rows affected (0.07 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	mysql> select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='test_db' and  TABLE_NAME='t_20201019';
	+------------+
	| ROW_FORMAT |
	+------------+
	| Compact    |
	+------------+
	1 row in set (0.00 sec)

------------------------------------------------------------------------------------------------------------------

	-- 原有表的行记录格式还是Dynamic
		mysql> select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='test_db' and  TABLE_NAME='table_20201116';
		+------------+
		| ROW_FORMAT |
		+------------+
		| Dynamic    |
		+------------+
		1 row in set (0.00 sec)

		mysql> show create table table_20201116;
		+----------------+-----------------------------------------------------------------------------------------------------------------------------+
		| Table          | Create Table                                                                                                                |
		+----------------+-----------------------------------------------------------------------------------------------------------------------------+
		| table_20201116 | CREATE TABLE `table_20201116` (
		  `id` int(10) unsigned NOT NULL,
		  PRIMARY KEY (`id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
		+----------------+-----------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)

		mysql> INSERT INTO `test_db`.`table_20201116` (`id`) VALUES ('2001');
		Query OK, 1 row affected (0.01 sec)
		-- set global innodb_file_format=Barracuda; 那岂不是会影响其它表的行记录格式？
		-- 目前来看，不会。
		
		

	注意，如果要修改现有表的行模式为compressed或dynamic，必须先将文件格式设置成 Barracuda：set global innodb_file_format=Barracuda；
	再用 ALTER TABLE tablename ROW_FORMAT=dynamic；去修改才能生效，否则修改无效却无提示。
	


10. 三种报错
	
	10.1 错误1 创建表报 maximum row size > 65535
		ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535
			-- 即记录的最大长度限制不包括BLOB等字段。

	10.2 错误2 创建表报Row size too large (> 8126)
		[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. 
			In current row format, BLOB prefix of 768 bytes is stored inline.


	10.3 错误3 表创建成功但是插入报 Row size too large (> 8126)
		
		row_format=dynamic:
			[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB may help. In current row format, BLOB prefix of 0 bytes is stored inline.
		
		row_format=compact:
			[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. 
				In current row format, BLOB prefix of 768 bytes is stored inline.

	
11. 总结

	1. MySQL Server最多只允许4096个字段
	2. InnoDB 最多只能有1000个字段
	3. 字段长度加起来如果超过65535，MySQL server层就会拒绝创建表
	4. 字段长度加起来（根据溢出页指针来计算字段长度，大于40的，溢出，只算40个字节）如果超过8126，InnoDB拒绝创建表
	5. 表结构中根据Innodb的ROW_FORMAT的存储格式确定行内保留的字节数（20 VS 768），最终确定一行数据是否小于8126，如果大于8126，报错。
		实际存储的行记录长度 > 8126
	6. 行溢出
		行内保留的字节数加起来大于8098个字节才会有行溢出。
		
	------------------------------------------------------------------------------------------------------------------------------	

	1. 先在Server层判断表结构定义的字段长度加起来是否大于 65535 字节，不超过，则执行到InnoDB存储引擎层，
        接着判断字段长度加起来是否大于 8126 字节，小于则建表成功;
        
    2. 数据插入的时候，存储到数据页内的单行记录的实际长度（行内保留的字节数）小于8126字节，则插入成功; 
        否则，插入失败;
    
    3. other
        MySQL对于一行记录的单个字段的数据长度和整行的数据长度的处理方式是不一样的
        字段长度加起来大于8098个字节才会有行溢出。
        -- 可以做为案例来讲解，体现了自己对行记录格式的深入研究...
	
	4. 建表的时候分别在Server层和InnoDB层做长度限制，数据的插入也有限制
		65535、8126、8126、8098
	