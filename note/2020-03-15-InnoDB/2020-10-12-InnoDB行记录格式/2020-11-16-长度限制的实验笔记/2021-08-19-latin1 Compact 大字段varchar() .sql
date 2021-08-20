
0. sql_mode
10个 VARCHAR(1000)
20个 VARCHAR(500)
20个 VARCHAR(501)
16个 VARCHAR(600)
10个 VARCHAR(990)
10个 VARCHAR(900)
10个 VARCHAR(870)
10个 VARCHAR(860)
10个 VARCHAR(850)
12个 VARCHAR(800)
11个 VARCHAR(850)
11个 VARCHAR(800)
小结


sql_mode

	mysql> show global variables like '%sql_mode%';
	+---------------+-----------------------------------------------------------------------------------------------------------------------+
	| Variable_name | Value                                                                                                                 |
	+---------------+-----------------------------------------------------------------------------------------------------------------------+
	| sql_mode      | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION |
	+---------------+-----------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)


10个 VARCHAR(1000)
	
	drop table if exists table_001;
	CREATE TABLE `table_001` (

	field_1 VARCHAR(1000) NOT NULL,
	field_2 VARCHAR(1000) NOT NULL,
	field_3 VARCHAR(1000) NOT NULL,
	field_4 VARCHAR(1000) NOT NULL,
	field_5 VARCHAR(1000) NOT NULL,
	field_6 VARCHAR(1000) NOT NULL,
	field_7 VARCHAR(1000) NOT NULL,
	field_8 VARCHAR(1000) NOT NULL,
	field_9 VARCHAR(1000) NOT NULL,
	field_10 VARCHAR(1000) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_001 values(
	repeat('y',999),
	repeat('y',999),
	repeat('y',999),
	repeat('y',999),
	repeat('y',999),
	repeat('y',999),
	repeat('y',999),
	repeat('y',999),
	repeat('y',999),
	repeat('y',999)
	);
	
	Query OK, 1 row affected (0.37 sec)

	
	select 999*10;

	mysql> select 999*10;
	+--------+
	| 999*10 |
	+--------+
	|   9990 |
	+--------+
	1 row in set (0.00 sec)


	[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_001.ibd 
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
	Total number of page: 14:
	Insert Buffer Bitmap: 1
	Uncompressed BLOB Page: 10
	File Space Header: 1
	B-tree Node: 1
	File Segment inode: 1

	select (768+20) * 10 = 7880
	select (768+20) * 11 = 8668
	
	select 768 * 10 = 7680
	select 768 * 11 = 8448
	
	只要有行溢出，就需要看看每个字段的长度是否有大于 768字节，如果大于，则行内的记录存储 768+20 个字节
	有10个字段的长度大于768个字节，那么行内的记录需要存储 select (768+20) * 10 = 7880 个字节 
	
	
	
20个 VARCHAR(500)

	drop table if exists table_002;
	CREATE TABLE `table_002` (
		field_1 VARCHAR(500) NOT NULL,
		field_2 VARCHAR(500) NOT NULL,
		field_3 VARCHAR(500) NOT NULL,
		field_4 VARCHAR(500) NOT NULL,
		field_5 VARCHAR(500) NOT NULL,
		field_6 VARCHAR(500) NOT NULL,
		field_7 VARCHAR(500) NOT NULL,
		field_8 VARCHAR(500) NOT NULL,
		field_9 VARCHAR(500) NOT NULL,
		field_10 VARCHAR(500) NOT NULL,
		field_11 VARCHAR(500) NOT NULL,
		field_12 VARCHAR(500) NOT NULL,
		field_13 VARCHAR(500) NOT NULL,
		field_14 VARCHAR(500) NOT NULL,
		field_15 VARCHAR(500) NOT NULL,
		field_16 VARCHAR(500) NOT NULL,
		field_17 VARCHAR(500) NOT NULL,
		field_18 VARCHAR(500) NOT NULL,
		field_19 VARCHAR(500) NOT NULL,
		field_20 VARCHAR(500) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_002 values(
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499)
	);
	
	ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.
	
	

20个 VARCHAR(501)

	drop table if exists table_003;
	CREATE TABLE `table_003` (
		field_1 VARCHAR(501) NOT NULL,
		field_2 VARCHAR(501) NOT NULL,
		field_3 VARCHAR(501) NOT NULL,
		field_4 VARCHAR(501) NOT NULL,
		field_5 VARCHAR(501) NOT NULL,
		field_6 VARCHAR(501) NOT NULL,
		field_7 VARCHAR(501) NOT NULL,
		field_8 VARCHAR(501) NOT NULL,
		field_9 VARCHAR(501) NOT NULL,
		field_10 VARCHAR(501) NOT NULL,
		field_11 VARCHAR(501) NOT NULL,
		field_12 VARCHAR(501) NOT NULL,
		field_13 VARCHAR(501) NOT NULL,
		field_14 VARCHAR(501) NOT NULL,
		field_15 VARCHAR(501) NOT NULL,
		field_16 VARCHAR(501) NOT NULL,
		field_17 VARCHAR(501) NOT NULL,
		field_18 VARCHAR(501) NOT NULL,
		field_19 VARCHAR(501) NOT NULL,
		field_20 VARCHAR(501) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	insert into table_003 values(
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499),
	repeat('y',499)
	);
	
	ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.


16个 VARCHAR(600)

	mysql> select 16*600;
	+--------+
	| 16*600 |
	+--------+
	|   9600 |
	+--------+
	1 row in set (0.00 sec)


	drop table if exists table_004;
	CREATE TABLE `table_004` (
		field_1 VARCHAR(600) NOT NULL,
		field_2 VARCHAR(600) NOT NULL,
		field_3 VARCHAR(600) NOT NULL,
		field_4 VARCHAR(600) NOT NULL,
		field_5 VARCHAR(600) NOT NULL,
		field_6 VARCHAR(600) NOT NULL,
		field_7 VARCHAR(600) NOT NULL,
		field_8 VARCHAR(600) NOT NULL,
		field_9 VARCHAR(600) NOT NULL,
		field_10 VARCHAR(600) NOT NULL,
		field_11 VARCHAR(600) NOT NULL,
		field_12 VARCHAR(600) NOT NULL,
		field_13 VARCHAR(600) NOT NULL,
		field_14 VARCHAR(600) NOT NULL,
		field_15 VARCHAR(600) NOT NULL,
		field_16 VARCHAR(600) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	insert into table_004 values(
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600),
	repeat('y',600)
	);
	
	ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.
	
	

10个 VARCHAR(990)

	drop table if exists table_005;
	CREATE TABLE `table_005` (

	field_1 VARCHAR(990) NOT NULL,
	field_2 VARCHAR(990) NOT NULL,
	field_3 VARCHAR(990) NOT NULL,
	field_4 VARCHAR(990) NOT NULL,
	field_5 VARCHAR(990) NOT NULL,
	field_6 VARCHAR(990) NOT NULL,
	field_7 VARCHAR(990) NOT NULL,
	field_8 VARCHAR(990) NOT NULL,
	field_9 VARCHAR(990) NOT NULL,
	field_10 VARCHAR(990) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_005 values(
	repeat('y',990),
	repeat('y',990),
	repeat('y',990),
	repeat('y',990),
	repeat('y',990),
	repeat('y',990),
	repeat('y',990),
	repeat('y',990),
	repeat('y',990),
	repeat('y',990)
	);
	
	[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_005.ibd 
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
	Total number of page: 14:
	Insert Buffer Bitmap: 1
	Uncompressed BLOB Page: 10
	File Space Header: 1
	B-tree Node: 1
	File Segment inode: 1


	mysql> select 990*10;
	+--------+
	| 990*10 |
	+--------+
	|   9900 |
	+--------+
	1 row in set (0.00 sec)
	
	
	
10个 VARCHAR(900)


	drop table if exists table_006;
	CREATE TABLE `table_006` (
	field_1 VARCHAR(900) NOT NULL,
	field_2 VARCHAR(900) NOT NULL,
	field_3 VARCHAR(900) NOT NULL,
	field_4 VARCHAR(900) NOT NULL,
	field_5 VARCHAR(900) NOT NULL,
	field_6 VARCHAR(900) NOT NULL,
	field_7 VARCHAR(900) NOT NULL,
	field_8 VARCHAR(900) NOT NULL,
	field_9 VARCHAR(900) NOT NULL,
	field_10 VARCHAR(900) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_006 values(
	repeat('y',900),
	repeat('y',900),
	repeat('y',900),
	repeat('y',900),
	repeat('y',900),
	repeat('y',900),
	repeat('y',900),
	repeat('y',900),
	repeat('y',900),
	repeat('y',900)
	);
		
	[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_006.ibd 
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
	Total number of page: 13:
	Insert Buffer Bitmap: 1
	Uncompressed BLOB Page: 9
	File Space Header: 1
	B-tree Node: 1
	File Segment inode: 1


	root@mysqldb 11:41:  [niuniuh5_db]> select 900*10;
	+--------+
	| 900*10 |
	+--------+
	|   9000 |
	+--------+
	1 row in set (0.00 sec)
	
	select 40*10 = 400;


	
7. 10 个 VARCHAR(899)

	root@mysqldb 16:56:  [yldbs]> select 899*10;
	+--------+
	| 899*10 |
	+--------+
	|   8990 |
	+--------+
	1 row in set (0.00 sec)
	
	root@mysqldb 16:57:  [yldbs]> select 16384/2;
	+-----------+
	| 16384/2   |
	+-----------+
	| 8192.0000 |
	+-----------+
	1 row in set (0.00 sec)



	drop table if exists table_101;
	CREATE TABLE `table_101` (
	field_1 VARCHAR(899) NOT NULL,
	field_2 VARCHAR(899) NOT NULL,
	field_3 VARCHAR(899) NOT NULL,
	field_4 VARCHAR(899) NOT NULL,
	field_5 VARCHAR(899) NOT NULL,
	field_6 VARCHAR(899) NOT NULL,
	field_7 VARCHAR(899) NOT NULL,
	field_8 VARCHAR(899) NOT NULL,
	field_9 VARCHAR(899) NOT NULL,
	field_10 VARCHAR(899) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_101 values(
	repeat('y',899),
	repeat('y',899),
	repeat('y',899),
	repeat('y',899),
	repeat('y',899),
	repeat('y',899),
	repeat('y',899),
	repeat('y',899),
	repeat('y',899),
	repeat('y',899)
	);
	Query OK, 1 row affected (0.29 sec)
	

	
10个 VARCHAR(870)
	
	root@mysqldb 17:09:  [yldbs]> select 10*870;
	+--------+
	| 10*870 |
	+--------+
	|   8700 |
	+--------+
	1 row in set (0.00 sec)


	drop table if exists table_121;
	CREATE TABLE `table_121` (
	field_1 VARCHAR(870) NOT NULL,
	field_2 VARCHAR(870) NOT NULL,
	field_3 VARCHAR(870) NOT NULL,
	field_4 VARCHAR(870) NOT NULL,
	field_5 VARCHAR(870) NOT NULL,
	field_6 VARCHAR(870) NOT NULL,
	field_7 VARCHAR(870) NOT NULL,
	field_8 VARCHAR(870) NOT NULL,
	field_9 VARCHAR(870) NOT NULL,
	field_10 VARCHAR(870) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_121 values(
	repeat('y',870),
	repeat('y',870),
	repeat('y',870),
	repeat('y',870),
	repeat('y',870),
	repeat('y',870),
	repeat('y',870),
	repeat('y',870),
	repeat('y',870),
	repeat('y',870)
	);
	
	Query OK, 1 row affected (0.29 sec)
	
	
	
10个 VARCHAR(860)


	drop table if exists table_131;
	CREATE TABLE `table_131` (
	field_1 VARCHAR(860) NOT NULL,
	field_2 VARCHAR(860) NOT NULL,
	field_3 VARCHAR(860) NOT NULL,
	field_4 VARCHAR(860) NOT NULL,
	field_5 VARCHAR(860) NOT NULL,
	field_6 VARCHAR(860) NOT NULL,
	field_7 VARCHAR(860) NOT NULL,
	field_8 VARCHAR(860) NOT NULL,
	field_9 VARCHAR(860) NOT NULL,
	field_10 VARCHAR(860) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	insert into table_131 values(
	repeat('y',860),
	repeat('y',860),
	repeat('y',860),
	repeat('y',860),
	repeat('y',860),
	repeat('y',860),
	repeat('y',860),
	repeat('y',860),
	repeat('y',860),
	repeat('y',860)
	);
	Query OK, 1 row affected (0.25 sec)


10个 VARCHAR(850)
	
	drop table if exists table_141;
	CREATE TABLE `table_141` (
	field_1 VARCHAR(850) NOT NULL,
	field_2 VARCHAR(850) NOT NULL,
	field_3 VARCHAR(850) NOT NULL,
	field_4 VARCHAR(850) NOT NULL,
	field_5 VARCHAR(850) NOT NULL,
	field_6 VARCHAR(850) NOT NULL,
	field_7 VARCHAR(850) NOT NULL,
	field_8 VARCHAR(850) NOT NULL,
	field_9 VARCHAR(850) NOT NULL,
	field_10 VARCHAR(850) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_141 values(
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850)
	);
	Query OK, 1 row affected (0.23 sec)
	
	
	
12个 VARCHAR(800)

	root@mysqldb 11:42:  [niuniuh5_db]> select 800*12;
	+--------+
	| 800*12 |
	+--------+
	|   9600 |
	+--------+
	1 row in set (0.00 sec)

	drop table if exists table_007;
	CREATE TABLE `table_007` (

	field_1 VARCHAR(800) NOT NULL,
	field_2 VARCHAR(800) NOT NULL,
	field_3 VARCHAR(800) NOT NULL,
	field_4 VARCHAR(800) NOT NULL,
	field_5 VARCHAR(800) NOT NULL,
	field_6 VARCHAR(800) NOT NULL,
	field_7 VARCHAR(800) NOT NULL,
	field_8 VARCHAR(800) NOT NULL,
	field_9 VARCHAR(800) NOT NULL,
	field_10 VARCHAR(800) NOT NULL,
	field_11 VARCHAR(800) NOT NULL,
	field_12 VARCHAR(800) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_007 values(
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800)
	);
	
	ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.
	

11个 VARCHAR(850)


	drop table if exists table_008;
	CREATE TABLE `table_008` (

	field_1 VARCHAR(850) NOT NULL,
	field_2 VARCHAR(850) NOT NULL,
	field_3 VARCHAR(850) NOT NULL,
	field_4 VARCHAR(850) NOT NULL,
	field_5 VARCHAR(850) NOT NULL,
	field_6 VARCHAR(850) NOT NULL,
	field_7 VARCHAR(850) NOT NULL,
	field_8 VARCHAR(850) NOT NULL,
	field_9 VARCHAR(850) NOT NULL,
	field_10 VARCHAR(850) NOT NULL,
	field_11 VARCHAR(850) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_008 values(
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850),
	repeat('y',850)
	);
	
	
	ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.

		
	mysql> select 850*11;
	+--------+
	| 850*11 |
	+--------+
	|   9350 |
	+--------+
	1 row in set (0.00 sec)



11个 VARCHAR(800)
	drop table if exists table_008;
	CREATE TABLE `table_008` (

	field_1 VARCHAR(800) NOT NULL,
	field_2 VARCHAR(800) NOT NULL,
	field_3 VARCHAR(800) NOT NULL,
	field_4 VARCHAR(800) NOT NULL,
	field_5 VARCHAR(800) NOT NULL,
	field_6 VARCHAR(800) NOT NULL,
	field_7 VARCHAR(800) NOT NULL,
	field_8 VARCHAR(800) NOT NULL,
	field_9 VARCHAR(800) NOT NULL,
	field_10 VARCHAR(800) NOT NULL,
	field_11 VARCHAR(800) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;
	
	
	insert into table_008 values(
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800),
	repeat('y',800)
	);
	
	
	ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.
	


小结	
	
	只要有行溢出，就需要看看每个字段的长度是否有大于 768字节，如果大于，则行内的记录存储 768+20 个字节
	有10个字段的长度大于768个字节，那么行内的记录需要存储 select (768+20) * 10 = 7880 个字节 
	
	理解了行记录格式，就容易理解这个现象。
	
	dynamic 就不存在这个问题。
	
	
	
1. 解决了1个在行记录溢出页之后的插入为什么报错的问题








