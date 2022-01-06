
1. 查看行记录格式

2. Compact行记录
	2.1 Compact行记录格式
	2.2 非行溢出实例
	2.3 Compact行记录格式小结
	
3. Redundant行记录
	3.1 Redundant行记录格式
	3.2 非溢出实例



1. 查看行记录格式	
	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

	mysql> show variables like "innodb_default_row_format";
	+---------------------------+---------+
	| Variable_name             | Value   |
	+---------------------------+---------+
	| innodb_default_row_format | dynamic |
	+---------------------------+---------+
	1 row in set (0.00 sec)

	
	mysql> SHOW VARIABLES LIKE '%innodb_file_format%';
	Empty set (0.00 sec)

	
	MySQL 8.0 下没有 innodb_file_format 参数.
	
		
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)
	
	mysql> show variables like "innodb_default_row_format";
	+---------------------------+---------+
	| Variable_name             | Value   |
	+---------------------------+---------+
	| innodb_default_row_format | dynamic |
	+---------------------------+---------+
	1 row in set (0.10 sec)

	mysql> SHOW VARIABLES LIKE '%innodb_file_format%';
	+--------------------------+-----------+
	| Variable_name            | Value     |
	+--------------------------+-----------+
	| innodb_file_format       | Barracuda |
	| innodb_file_format_check | ON        |
	| innodb_file_format_max   | Barracuda |
	+--------------------------+-----------+
	3 rows in set (0.00 sec)
		
	
2. Compact行记录

  2.1 Compact行记录格式
	1. 变长字段长度列表
		首部是一个非NULL变长字段长度列表，并且是按照列的顺序逆序放置的，长度为：
			1. 列的长度小于255字节，用1字节表示；
			2. 列的长度大于255字节，用2字节表示。
		
		
	2. NULL标志位
		指示了该行数据中是否有 NULL 值，如果有 NULL 值则用1表示； 说明了该部分所占的字节应该为1字节；
		字段值为 NULL 不占列数据任何空间，即 NULL 除了占有 NULL 标志位，实际存储不占有任何空间。
	
	3. 记录头信息
		固定占 5 bytes, 包含下一条记录的位置，该行记录总长度，记录类型，是否被删除，对应的 slot 信息等
		
		名称			大小（bit）	描述
		()				1			未知
		()				1			未知
		deleted_flag	1			该行是否已被删除, 假设被删除, 会打一个删除标记, 即 deleted_flag = 1
		min_rec_flag	1			如果该行记录是预定义为最小的记录，为1
		n_owned			4			该记录拥有的记录数，用于Slot, 即一个槽拥有的记录数
		heap_no			13			索引堆中该条记录的索引号
		record_type		3			记录类型，000（普通），001（B+Tree节点指针），010（Infimum），011（Supremum）
		next_record		16			页中下一条记录的相对位置
		Total			40       	nothing   
		
	
	4. 事务ID  
		6个字节大小
	
	5. 回滚指针
		7个字节大小
		
	6. 列1数据、列2数据、列N数据
		
		
  2.2 非行溢出实例
	制造数据
		CREATE TABLE mytest(
		t1 varchar(10),
		t2 varchar(10),
		t3 char(10),
		t4 varchar(10)
		) engine = innodb charset=latin1 row_format=compact;


		insert into mytest VALUES('a','bb','bb','ccc');
		insert into mytest VALUES('d','ee','ee','fff');
		insert into mytest VALUES('d',NULL,NULL,'fff');


	查看16制信息
		hexdump -C -v mytest.ibd > mytest.txt
		
		/*
		a
		bb
		bb
		ccc
		a bb bb ccc
		  Offset: 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 	
		00000000: 61 0D 0A 62 62 0D 0A 62 62 0D 0A 63 63 63 0D 0A    a..bb..bb..ccc..
		00000010: 61 20 62 62 20 62 62 20 63 63 63                   a.bb.bb.ccc
		
		a 	61
		bb 	62 62
		ccc 63 63 63 
		*/		
		 
		0000c070  73 75 70 72 65 6d 75 6d  03 02 01 00 00 00 10 00  |supremum........|
		0000c080  2c 00 00 00 00 02 00 00  00 00 57 37 49 a6 00 00  |,.........W7I...|
		0000c090  01 1c 01 10 61 62 62 62  62 20 20 20 20 20 20 20  |....abbbb       |
		0000c0a0  20 63 63 63 03 02 01 00  00 00 18 00 2b 00 00 00  | ccc........+...|
		0000c0b0  00 02 01 00 00 00 57 37  4a a7 00 00 20 0a 01 10  |......W7J... ...|
		0000c0c0  64 65 65 65 65 20 20 20  20 20 20 20 20 66 66 66  |deeee        fff| # insert into mytest VALUES('d','ee','ee','fff');
		0000c0d0  03 01 06 00 00 20 ff 98  00 00 00 00 02 02 00 00  |..... ..........|
		0000c0e0  00 57 37 4f aa 00 00 01  21 01 10 64 66 66 66 00  |.W7O....!..dfff.| # insert into mytest VALUES('d',NULL,NULL,'fff');


		第一行记录（0xc078即 0000c070 到 0000c080）
			03 02 01 					# 变长字段长度列表，倒序存放，分别对应 'ccc', 'bb', 'a' 这三个值
			00							# NULL标志位，表示第一行没有NULL值
			00 00 10 00 2c				# 记录头信息，固定 5 byte
			00 00 00 00 02 00			# 我们建的表没有主键，因此会有内部 RowID, 占用 6 byte
			00 00 00 57 37 49			# 事务ID, 占用 6 byte
			a6 00 00 01 1c 01 10		# 回滚指针, 占用 7 byte
			61							# 列1数据'a', 字符a, VARCHAR(10), 1个字符只占用了1Byte
			62 62						# 列2数据'bb' 字符bb, VARCHAR(10), 2个字符只占用了2Byte
			62 62 20 20 20 20 20 20 20 20  # 列3数据'bb'，字符22，CHAR(10)，2个字符依旧占用了 10Byte; 固定长度 CHAR 字段在未能完全占用其长度空间时，会用 0X20 来进行填充。  

			63 63 63	 				# 列4数据'ccc', 字符ccc，VARCHAR(10)，3个字符只占用了3Byte
		

		第三行记录 （0000c0e0）
			03 01						# 变长字段长度列表有两列，倒序存放，分别对应 'fff', 'd' 这两个值
			06							# NULL标志位，第三行有NULL值，因此 NULL标志位不再是00而是06，转换成二进制为 00000110 ，为1的值代表第2列和第3列的数据为NULL。
			00 00 20 ff 98				# 记录头信息，固定 5 byte
			00 00 00 00 02 02			# RowID, 占用 6 byte
			00 00 00 57 37 4f			# 事务ID, 占用 6 byte
			aa 00 00 01 21 01 10 		# 回滚指针, 占用 7 byte
			64							# 列1数据'd', 字符1，VARCHAR(10)，1个字符只占用了1Byte
			66 66 66		    		# 列4数据'fff', 字符1，VARCHAR(10)，3个字符只占用了3Byte
										# 列2数据 VARCHAR(10)为 NULL 时，不占用空间
										# 列3数据 CHAR(10)   为 NULL 时，不占用空间

									
  2.3 Compact行记录格式小结:
	通过分析, 知道了不管是 CHAR类型还是VARCHAR类型，在 compact 格式下 NULL 值都不占用任何存储空间。  # 理解了。
	
	
3. Redundant行记录

  3.1 Redundant行记录格式
	
	1. 字段长度偏移列表
		按照列的顺序逆序放置
		列的长度小于255字节，用1字节表示；
		列的长度大于255字节，用2字节表示；
		
	2. 记录头信息
		占用 6 bytes, 区别于 Compact行记录格式的记录头信息占用 5 bytes
			
		名称			大小（bit）	描述
		()				1			未知
		()				1			未知
		deleted_flag	1			该行是否已被删除
		min_rec_flag	1			如果该行记录是预定义为最小的记录，为1
		n_owned			4			该记录拥有的记录数，用于Slot
		heap_no			13			索引堆中该条记录的索引号
		n_fields        10          记录中列的数量
		byte_offs_flasg 1           偏移列表是1字节还是2字节
		next_record		16			页中下一条记录的相对位置
		Total			48       	nothing  
	
	3. 事务ID  
		6个字节大小
	
	4. 回滚指针
		7个字节大小
		
	5. 列1数据、列2数据、列N数据
	
	
  3.2 非溢出实例
  
   制造数据
	 CREATE TABLE mytest01(
	 t1 varchar(10),
	 t2 varchar(10),
	 t3 char(10),
	 t4 varchar(10)
	 ) engine = innodb charset=latin1 row_format=redundant;


	 insert into mytest01 VALUES('a','bb','bb','ccc');
	 insert into mytest01 VALUES('d','ee','ee','fff');
	 insert into mytest01 VALUES('d',NULL,NULL,'fff');

	查看16制信息
		hexdump -C -v mytest.ibd > mytest.txt
		
		0000c070  08 03 00 00 73 75 70 72  65 6d 75 6d 00 23 20 16  |....supremum.# .|
		0000c080  14 13 0c 06 00 00 10 0f  00 ba 00 00 00 00 02 03  |................|
		0000c090  00 00 00 57 37 54 af 00  00 01 28 01 10 61 62 62  |...W7T....(..abb|
		0000c0a0  62 62 20 20 20 20 20 20  20 20 63 63 63 23 20 16  |bb        ccc# .|
		0000c0b0  14 13 0c 06 00 00 18 0f  00 ea 00 00 00 00 02 04  |................|
		0000c0c0  00 00 00 57 37 55 b0 00  00 01 2a 01 10 64 65 65  |...W7U....*..dee|
		0000c0d0  65 65 20 20 20 20 20 20  20 20 66 66 66 21 9e 94  |ee        fff!..|
		0000c0e0  14 13 0c 06 00 00 20 0f  00 74 00 00 00 00 02 05  |...... ..t......|
		0000c0f0  00 00 00 57 37 5a b3 00  00 01 32 01 10 64 00 00  |...W7Z....2..d..|
		0000c100  00 00 00 00 00 00 00 00  66 66 66 00 00 00 00 00  |........fff.....|	
		
		第一行记录
			23 20 16 14 13 0c 06     # 长度偏移列表, 逆序
			00 00 10 0f 00 ba        # Record  Header, 固定 6 bytes
			00 00 00 00 02 03        # ROWID, 6 bytes 
			00 00 00 57 37 54        # 事务ID, 6 bytes
			af 00 00 01 28 01 10     # 回滚指针, 7 bytes
			61					     # 列1数据 'a'
			62 62					 # 列2数据 'bb'
			62 62 20 20 20 20 20 20  # 列3数据 'bb', CHAR 类型,  固定长度 CHAR 字段在未能完全占用其长度空间时，会用 0X20 来进行填充。  
			63 63 63				 # 列4数据  'ccc'
			
			
		第三行记录
			21 9e 94 14 13 0c 06     # 长度偏移列表, 逆序
			00 00 20 0f 00 74        # Record  Header, 固定 6 byte
			00 00 00 00 02 05        # ROWID, 6 bytes
			00 00 00 57 37 5a        # 事务ID, 6 bytes
			b3 00 00 01 32 01 10     # 回滚指针, 7 bytes
			64						 # 列1数据 'd'
			00 00 00 00 00 00 00 00 00 00  	# 列3数据 NULL, CHAR(10)为NULL时，依旧占用10Byte
			66 66 66                 # 列4数据 'fff'
			
			逆序后得到 06 0c 13 14 94 9e 21:
				第5个NULL变为了 94
				第6个CHAR类型的 NULL 值 为 9e(94+10=0x9e), 之后的 21 代表 (14+3=0x21)
				可以看到 Redundant 行格式同样不占用任何存储空间,而 CHAR 类型的 NULL 值需要占用空间.
		

	3.3 Redundant行记录格式小结:
		表的字符集为 Latin1, 每个字符最多只占用1字节,  compact行记录的NULL不占用存储空间, Redundant行记录格式的 CHAR 类型的 NULL 值需要占用空间.							
		理解了.

	
	
