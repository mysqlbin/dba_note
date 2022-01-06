
text
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
	
	text 单个字段最多可以存储 65536 byte的数据
	REPEAT('a',100000) = 100000 byte > 65536  byte了。
	
	
	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',50000),REPEAT('b',50000),REPEAT('c',50000),REPEAT('d',50000);
	Query OK, 1 row affected (0.09 sec)
	Records: 1  Duplicates: 0  Warnings: 0

	
	65536
	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',65536),REPEAT('b',65536),REPEAT('c',65536),REPEAT('d',65536);	
	ERROR 1406 (22001): Data too long for column 'a' at row 1
	
	65535
	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',65535),REPEAT('b',65535),REPEAT('c',65535),REPEAT('d',65535);	
	Query OK, 1 row affected (0.11 sec)
	Records: 1  Duplicates: 0  Warnings: 0
	
blob
	
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
	
	blob 单个字段最多可以存储 65536 byte的数据
	70000 byte > 65536 byte了。
	
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
	
	
	65536
	INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',65536),REPEAT('b',65536),REPEAT('c',65536),REPEAT('d',65536);	
	ERROR 1406 (22001): Data too long for column 'a' at row 1
	
	
	65535
	mysql> INSERT INTO table_20201115(a,b,c,d) SELECT REPEAT('a',65535),REPEAT('b',65535),REPEAT('c',65535),REPEAT('d',65535);
	Query OK, 1 row affected (0.28 sec)
	Records: 1  Duplicates: 0  Warnings: 0
	
	
	
	

