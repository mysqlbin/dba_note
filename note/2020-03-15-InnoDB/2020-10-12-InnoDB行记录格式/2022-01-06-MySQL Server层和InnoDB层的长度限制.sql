
1. MySQL Server 的长度限制	
	1.1 Compact、utf8mb4
	1.2 Compact、utf8
	1.3 Compact、utf8mb4 VS Compact、utf8
	1.4 Compact、latin1
	1.5 小结
	
2. InnoDB层的长度限制
	2.1 COMPACT、latin1	
	2.2 COMPACT、utf8mb4
	2.3 InnoDB层的长度限制的计算方式


3. InnoDB表最多可以建立多少个字段	
	3.1 验证行格式为Compact在不同的字符集下分别可以建立多个字段
	3.2 验证行格式为Dynamic在不同的字符集下分别可以建立多个字段
	3.3 utf8、Compact、TEXT
	3.4 utf8、Compact、blob
	3.5 utf8、Compact、longtext
			
4. 行溢出
5. 相关参考
6. 在线修改行记录格式为Compact
7. 三种报错
	7.1 错误1 创建表报maximum row size > 65535    -- Server层
	7.2 错误2 创建表报Row size too large (> 8126) -- InnoDB层
	7.3 错误3 表创建成功但是插入报 Row size too large (> 8126)  -- 数据插入

8. 总结
	

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
			-- 创建表的记录的最大长度限制不包括BLOB等字段。
			
			之所以将BLOB和TEXT排除在外，是因为它的内容超过长度限制后会单独存储在其它页中。但即便如此，存储BLOB和TEXT的指针信息也需要9 ~ 12个字节，具体来说：
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
	
	1.3 Compact、utf8mb4 VS Compact、utf8
	
		mysql>select 21841-16381;
		+-------------+
		| 21841-16381 |
		+-------------+
		|        5460 |
		+-------------+
		1 row in set (0.00 sec)
	
		utf8 比 utf8mb4 可以多存储 大约 5460个字符。
		
		
	1.4 Compact、latin1

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

	1.5 小结
		
		utf8mb4字符集下，ID为bigint unsigned类型，varchar字段的字符数不能大于等于 16382
		utf8字符集下，   ID为bigint unsigned类型，varchar字段的字符数不能大于等于 21842
		latin1字符集下， ID为bigint unsigned类型，varchar字段的字符数不能大于等于 65525

	
2. InnoDB层的长度限制

2.1 COMPACT、latin1
	
	字符集为 latin1，所以1个字符=1个字节
	
	CHAR(255) 33个
	
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
		   c31 CHAR(255),c32 CHAR(255),c33 CHAR(255)
		   ) ENGINE=InnoDB ROW_FORMAT=COMPACT DEFAULT CHARSET latin1;
		[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.
		-- InnoDB层的报错。
		
		原因：
			在创建表的时候，MySQL在计算字段长度的时候并不是按照字段的全部长度来记的。
			列字段小于40个字节的都会按实际字节计算，如果大于20 * 2=40 字节就只会按40字节。
			对应到MySQL代码中 storage/innobase/dict/dict0dict.cc 的 dict_index_too_big_for_tree() 中;
			-- 上面的计算公式，不包括 char 定长列。
			
			如果用上面的计算公式，这个 t4 表是可以创建成功的。
			CHAR(255) 大于 40，按40个byte来算: select 40*33=1320;  总长度 1320 < 8126, 创建表成功;
		
		
		根本原因：
			单行定义的长度：SELECT 255*33=8415 字符(字节), 因为这里的字符集为 latin1，所以1个字符=1个字节
		
		
	CHAR(255) 31个 和 32个
		drop table if exists t4;
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
		
		----------------------------------------------------------------------------------------------------------
		
		drop table if exists t4;
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
		   c31 CHAR(255),c32 CHAR(255)
		   ) ENGINE=InnoDB ROW_FORMAT=COMPACT DEFAULT CHARSET latin1;
		ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.

		----------------------------------------------------------------------------------------------------------	
		select 255*31=7905; 总长度 7905 < 8126, 创建表成功;
		
		select 255*32=8160; 总长度 8160 > 8126, 创建表失败;
		
	----------------------------------------------------------------------------
	
	VARCHAR(255) 33个
	
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
		
		在创建表的时候，MySQL在计算字段长度的时候并不是按照字段的全部长度来记的。
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
		
		
		原因：
			在创建表的时候，MySQL在计算字段长度的时候并不是按照字段的全部长度来记的。
			列字段小于40个字节的都会按实际字节计算，如果大于20 * 2=40 字节就只会按40字节。
			对应到MySQL代码中 storage/innobase/dict/dict0dict.cc 的 dict_index_too_big_for_tree() 中;
			
			varchar(2000) 大于 40，按40个byte来算: select 40*7=280;  总长度 280 < 8126, 创建表成功;
				
			-- 这里可以对应上
			-- 理解了。**************
			
			https://mp.weixin.qq.com/s/_Emepy6IUgS6NbQcUC60rg     MySQL的一个表最多可以有多少个字段
			-- 这篇文章写得真好; 
			
			
2.3 InnoDB层的长度限制的计算方式
	
	跟字符集有关系，跟定长或者变长类型也有关系
	
	
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
	
	-- Dynamic和Compact行记录格式，在 varchar(20) 定长字段中，两者可以建立字段的个数没差别;	
	-- 参考 varchar(20) 这个文件
	
	
	
3.3 utf8、Compact、TEXT

	的确可以创建有且仅含有 196 个 TEXT 字段的表。
	
	
3.4 utf8、Compact、blob

	的确可以创建有且仅含有 196 个 blob 字段的表。
	
3.5 utf8、Compact、longtext
	
	的确可以创建有且仅含有 196 个 longtext 字段的表。

3.6 dynamic 呢



4. 行溢出

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
	-- 没毛病。
	
------------------------------------------------------------------------------------

	


5. 相关参考

	https://dev.mysql.com/doc/refman/5.7/en/column-count-limit.html
	https://mp.weixin.qq.com/s/w3ij101jzDlbu93i5J7uQg           故障分析 | MySQL TEXT 字段的限制
	https://mp.weixin.qq.com/s/_aAZ2jTlw6ymCQ092qYkww        	技术分享 | MySQL 字段长度限制的计算方法

	https://mp.weixin.qq.com/s/_Emepy6IUgS6NbQcUC60rg     MySQL的一个表最多可以有多少个字段
		-- 读懂了这篇文章，就可以解决我的疑问; 好文
		-- https://mp.weixin.qq.com/s/tNA_-_MoYt1fJT0icyKbMg       MVCC原理探究及MySQL源码实现分析   这篇文章也是他的
		-- 花了这么多时间，就要弄清楚来; 
    https://mp.weixin.qq.com/s/uCiizaoeu5qKF7mt25SDAg   说说 VARCHAR 背后的那些事
	
	   
6. 在线修改行记录格式为Compact

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
	


7. 三种报错
	
	7.1 错误1 创建表报 maximum row size > 65535
		ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535
			-- 即记录的最大长度限制不包括BLOB等字段。

	7.2 错误2 创建表报Row size too large (> 8126)
		[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. 
			In current row format, BLOB prefix of 768 bytes is stored inline.

	
	7.3 错误3 表创建成功但是插入报 Row size too large (> 8126)
		
		row_format=dynamic:
			[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB may help. In current row format, BLOB prefix of 0 bytes is stored inline.
		
		row_format=compact:
			[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. 
				In current row format, BLOB prefix of 768 bytes is stored inline.

	
8. 总结

	1. MySQL Server最多只允许4096个字段
	
	2. InnoDB 最多只能有1000个字段
	
	3. 字段长度(不包括 text、blob字段)加起来如果超过65535，MySQL server层就会拒绝创建表

	4. 字段长度加起来（根据溢出页指针来计算字段长度，大于40的，溢出，只算40个字节）如果超过8126，InnoDB拒绝创建表
			在创建表的时候，InnoDB 在计算字段长度的时候并不是按照字段的全部长度来记的。
			列字段小于40个字节的都会按实际字节计算，如果大于 20 * 2=40 字节就只会按40字节。
			对应到MySQL代码中 storage/innobase/dict/dict0dict.cc 的 dict_index_too_big_for_tree() 中;	
			
			
	5. 表结构中根据Innodb的ROW_FORMAT的存储格式确定行内保留的字节数（20 VS 768），最终确定一行数据是否小于8126，如果大于8126，则会导致数据插入报错。
		-- 实际存储的行记录长度 > 8126，报错。
		-- 不包括溢出到大对象页单独存储的部分，实际存储到行记录中的长度，大于8KB，就会报插入数据错误。
		
	6. 行溢出
		行记录长度的字节数加起来大于8098个字节才会有行溢出。
		-- 没毛病。
	
	7. 8098 和 8126 
		行记录数的总长度大于8098，则会溢出。 行内保留的记录数的长度大于8126，则会报错。	
	
	------------------------------------------------------------------------------------------------------------------------------	

	1. 先在Server层判断表结构定义的字段长度加起来是否大于 65535 字节，不超过，则执行到InnoDB存储引擎层，
        接着判断字段长度加起来是否大于 8126 字节，小于则建表成功;
        
    2. 数据插入的时候，存储到数据页内的单行记录的实际长度（行内保留的字节数）小于8126字节，则插入成功; 
        否则，插入失败;

	3. 建表的时候分别在Server层和InnoDB层做长度限制，数据的插入也有限制
		65535、8126、8126、8098

	