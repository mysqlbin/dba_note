
1. 初始化表结构和数据
2. COMPACT行格式
	1. 记录的额外信息和记录的真实数据
	2. 变长字段长度列表
	3. NULL值列表
	4. 记录头信息
	
3. 行溢出数据

	3.1 VARCHAR(M)最多能存储的数据 --单个字段的场景
	3.2 记录中的数据太多产生的溢出 -- 2个案例
	3.3 行溢出的临界点
	3.4 行溢出跟非行溢出在存储空间的比较
	3.5 2个字段的数据长度都溢出，那么2个字段都有对应的20字节的指针保留在行记录中吗



1. 初始化表结构和数据
	
	mysql> USE xiaohaizi;
	Database changed

	mysql> CREATE TABLE record_format_demo (
		->     c1 VARCHAR(10),
		->     c2 VARCHAR(10) NOT NULL,
		->     c3 CHAR(10),
		->     c4 VARCHAR(10)
		-> ) CHARSET=ascii ROW_FORMAT=COMPACT;
	Query OK, 0 rows affected (0.03 sec)



	mysql> INSERT INTO record_format_demo(c1, c2, c3, c4) VALUES('aaaa', 'bbb', 'cc', 'd'), ('eeee', 'fff', NULL, NULL);
	Query OK, 2 rows affected (0.02 sec)
	Records: 2  Duplicates: 0  Warnings: 0


	mysql> SELECT * FROM record_format_demo;
	+------+-----+------+------+
	| c1   | c2  | c3   | c4   |
	+------+-----+------+------+
	| aaaa | bbb | cc   | d    |
	| eeee | fff | NULL | NULL |
	+------+-----+------+------+
	2 rows in set (0.00 sec)




2. COMPACT行格式
	
	1. 记录的额外信息和记录的真实数据
		
		记录的额外信息：
            变长字段长度列表
            NULL值列表
            记录头信息
			
        记录的真实数据：
			主键ID
            事务ID
            回滚指针
            各个列的值
			
			
	2. 变长字段长度列表
		
		变长字段的类型
			比如 VARCHAR(M)、VARBINARY(M)、各种TEXT类型，各种BLOB类型
	
	
		这些变长字段占用的存储空间分为两部分：

			真正的数据内容
			占用的字节数(也就是变长字段长度列表)
			
		在Compact行格式中，把所有变长字段的真实数据占用的字节长度都存放在记录的开头部位，从而形成一个变长字段长度列表，各变长字段数据占用的字节数按照列的顺序逆序存放(很重要)
		
		举例：
			record_format_demo表中的第一条记录
				因为record_format_demo表的c1、c2、c4列都是VARCHAR(10)类型的，也就是变长的数据类型，所以这三个列的值的长度都需要保存在记录开头处
				因为record_format_demo表中的各个列都使用的是ascii字符集，所以每个字符只需要1个字节来进行编码，来看一下第一条记录各变长字段内容的长度：
			
					列名	存储内容	内容长度（十进制表示）	内容长度（ 十六进制 表示）
					c1		'aaaa'		4						0x04
					c2		'bbb'		3						0x03
					c4		'd'			1						0x01
			
				
				最后变长字段长度列表的字节串用 十六进制 表示的效果就是（各个字节之间实际上没有空格，用空格隔开只是方便理解）：01 03 04 
		
		
			record_format_demo表中的第二条记录

					列名	存储内容	内容长度（十进制表示）	内容长度（ 十六进制 表示）
					c1		'eeee'		4						0x04
					c2		'fff'		3						0x03
				
		
				最后变长字段长度列表的字节串用 十六进制 表示的效果就是（各个字节之间实际上没有空格，用空格隔开只是方便理解）：03 04 

			
			
		用1个还是2个字节来表示真实数据占用的字节数的公式 
		
			先声明一下W、M和L的意思：

				W: 假设某个字符集中表示一个字符最多需要使用的字节数为W，也就是使用SHOW CHARSET语句的结果中的Maxlen列，比方说utf8字符集中的W就是3，gbk字符集中的W就是2，ascii字符集中的W就是1。
					-- 一个字符最多需要使用的字节数
					
				M: 对于变长类型VARCHAR(M)来说，这种类型表示能存储最多M个字符（注意是字符不是字节），所以这个类型能表示的字符串最多占用的字节数就是M×W。
					-- 字符数
					
				L: 假设它实际存储的字符串占用的字节数是L。
					-- 实际存储的字符串占用的字节数
					
					
			M×W <= 255，那么使用1个字节来表示真正字符串占用的字节数：

				也就是说InnoDB在读记录的变长字段长度列表时先查看表结构，如果某个变长字段允许存储的最大字节数不大于255时，可以认为只使用1个字节来表示真正字符串占用的字节数。
		
				
			M×W > 255，则分为两种情况：
				
				如果L <= 127，则用1个字节来表示真正字符串占用的字节数。

				如果L > 127，则用2个字节来表示真正字符串占用的字节数。

			
			总结：
				如果该可变字段允许存储的最大字节数（M×W）超过255字节并且真实存储的字节数（L）超过127字节，则使用2个字节，否则使用1个字节。
				
				-- 理解了。
		
		
		第1行记录变长字段列表共需要3个字节：
		
			c1列存储的值为'aaaa'，占用的字节数为4
			c2列存储的值为'bbb'，占用的字节数为3
			c4列存储的值为'd'，占用的字节数为1
			
			数字4可以用1个字节表示，3也可以用1个字节表示，3也可以用1个字节表示, 所以整个变长字段长度列表共需3个字节。
			
			
		第2行记录变长字段列表共需要2个字节：
		
			c1列存储的值为'eeee'，占用的字节数为4
			c2列存储的值为'fff'，占用的字节数为3
			数字4可以用1个字节表示，3也可以用1个字节表示，所以整个变长字段长度列表共需2个字节。
			
			
				
	3. NULL值列表
		
		字段值为 NULL 不占列数据任何空间，即 NULL 除了占有 NULL 标志位(bit)，实际存储不占用任何空间。
		1个NULL值占用1个bit
		
		第1行记录没有NULL值，所以实际存储不占用任何空间。
		第2行记录有2个NULL值，占用2个bit。
		
		
		
	4. 记录头信息
	
		用于描述记录的记录头信息，它是由固定的5个字节组成。5个字节也就是40个二进制位，不同的位代表不同的意思
		固定占 5 bytes, 包含下一条记录的位置，该行记录总长度，记录类型，是否被删除，对应的 slot 信息等	
		
			二进制位代表的详细信息如下表：

				名称			大小（单位：bit）	描述
				预留位1			1					没有使用
				预留位2			1					没有使用
				delete_mask		1					标记该记录是否被删除
				min_rec_mask	1					B+树的每层非叶子节点中的最小记录都会添加该标记
				n_owned			4					表示当前记录拥有的记录数
				heap_no			13					表示当前记录在记录堆的位置信息
				record_type		3					表示当前记录的类型，0表示普通记录，1表示B+树非叶子节点记录，2表示最小记录，3表示最大记录
				next_record		16					表示下一条记录的相对位置

					
3. 行溢出数据

	3.1 VARCHAR(M)最多能存储的数据 --单个字段的场景
	
		CHARSET=ascii
		
			VARCHAR(65535) 
				
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(65535)
				) CHARSET=ascii ROW_FORMAT=Compact;
					
					
				mysql> CREATE TABLE varchar_size_demo(
				->    c VARCHAR(65535)
				-> ) CHARSET=ascii ROW_FORMAT=Compact;
				ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs

				原因：
					从报错信息里可以看出：
						MySQL对一条记录占用的最大存储空间是有限制的，除了BLOB或者TEXT类型的列之外，记录的真实数据(不包括隐藏列(row id、事务ID、回滚指针)和记录头信息)占用的字节长度加起来不能超过 65535 个字节。。
						所以MySQL服务器建议我们把存储类型改为TEXT或者BLOB的类型。
					
				这个65535个字节除了列本身的数据之外，还包括一些其他的数据（storage overhead），比如说我们为了存储一个VARCHAR(M)类型的列，其实需要占用3部分存储空间：
				
					1. 真实数据
					2. 真实数据占用字节的长度(变长字段长度列表)
					3. NULL值标识，如果该列有NOT NULL属性则可以没有这部分存储空间
					
				
			VARCHAR(65532)
				
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(65532)
				) CHARSET=ascii ROW_FORMAT=Compact;
						
				mysql> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(65532)
					-> ) CHARSET=ascii ROW_FORMAT=Compact;
				Query OK, 0 rows affected (0.18 sec)

				
				原因：
					VARCHAR类型的列没有NOT NULL属性，那最多只能存储65532个字节的数据，因为真实数据的长度可能占用2个字节，NULL值标识需要占用1个字节
					
			VARCHAR(65533) NOT NULL 
						
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(65533) NOT NULL 
				) CHARSET=ascii ROW_FORMAT=Compact;

				mysql> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(65533) NOT NULL 
					-> ) CHARSET=ascii ROW_FORMAT=Compact;
				Query OK, 0 rows affected (0.15 sec)


				
				原因：
					VARCHAR类型的列有NOT NULL属性，那最多只能存储65533个字节的数据，因为真实数据的长度可能占用2个字节
					
					
		CHARSET=utf8  
		
			VARCHAR(65532) NULL  
			
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(65532)
				) CHARSET=utf8 ROW_FORMAT=Compact;
				
				
				mysql> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(65532)
					-> ) CHARSET=utf8 ROW_FORMAT=Compact;
				ERROR 1074 (42000): Column length too big for column 'c' (max = 21845); use BLOB or TEXT instead


			-----------------------------------------------------------------------------------------------------
			
			VARCHAR(21844) NULL  
			
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(21844)
				) CHARSET=utf8 ROW_FORMAT=Compact;

				mysql> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(21844)
					-> ) CHARSET=utf8 ROW_FORMAT=Compact;
				Query OK, 0 rows affected, 1 warning (0.22 sec)

				
			如果VARCHAR(M)类型的列使用的不是ascii字符集，那M的最大取值取决于该字符集表示一个字符最多需要的字节数
			
			在列的值允许为NULL的情况下，utf8字符集表示一个字符最多需要3个字节，那在该字符集下，M的最大取值就是21844，就是说最多能存储21844（也就是：65532/3）个字符。
			
			-----------------------------------------------------------------------------------------------------
			
			
			VARCHAR(21845) NOT NULL
			
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(21845) NOT NULL 
				) CHARSET=utf8 ROW_FORMAT=Compact;		

				
				mysql> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(21845) NOT NULL 
					-> ) CHARSET=utf8 ROW_FORMAT=Compact;
				ERROR 1118 (42000): Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOB

			-----------------------------------------------------------------------------------------------------
			
			VARCHAR(21844) NOT NULL	
			
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(21844) NOT NULL 
				) CHARSET=utf8 ROW_FORMAT=Compact;	

				mysql> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(21844) NOT NULL 
					-> ) CHARSET=utf8 ROW_FORMAT=Compact;
				Query OK, 0 rows affected, 1 warning (0.11 sec)

			在列的值不允许为NULL的情况下，utf8字符集表示一个字符最多需要3个字节，那在该字符集下，M的最大取值就是21844，就是说最多能存储21844（也就是：65533/3）个字符。
			
			

		CHARSET=gbk 
		
			VARCHAR(65532) NULL  
			
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(65532)
				) CHARSET=gbk ROW_FORMAT=Compact;

				root@mysqldb 15:13:  [sbtest_03]> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(65532)
					-> ) CHARSET=gbk ROW_FORMAT=Compact;
				ERROR 1074 (42000): Column length too big for column 'c' (max = 32767); use BLOB or TEXT instead


			VARCHAR(32766) NULL  
			
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(32766)
				) CHARSET=gbk ROW_FORMAT=Compact;

				root@mysqldb 15:14:  [sbtest_03]> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(32766)
					-> ) CHARSET=gbk ROW_FORMAT=Compact;
				Query OK, 0 rows affected (0.12 sec)


			VARCHAR(32766) NULL  
			
				DROP TABLE if exists varchar_size_demo;		
				CREATE TABLE varchar_size_demo(
				   c VARCHAR(32766) NOT NULL
				) CHARSET=gbk ROW_FORMAT=Compact;

				root@mysqldb 15:15:  [sbtest_03]> CREATE TABLE varchar_size_demo(
					->    c VARCHAR(32766) NOT NULL
					-> ) CHARSET=gbk ROW_FORMAT=Compact;
				Query OK, 0 rows affected (0.10 sec)
				
				
		小结：
		
			上述所言在列的值允许为NULL 或者 不允许为NULL 的情况下，gbk字符集下M的最大取值就是32766，utf8字符集下M的最大取值就是21844，这都是在表中只有一个字段的情况下说的
			一定要记住一个行中的所有列，（不包括隐藏列和记录头信息，不包括 text、blob字段）占用的字节长度加起来不能超过65535个字节！ 
			
			
	3.2 记录中的数据太多产生的溢出  -- 2个案例

	不只是 VARCHAR(M) 类型的列，其他的 TEXT、BLOB 类型的列在存储数据非常多的时候也会发生行溢出。
	
	Compact行记录格式的行溢出的2个案例
	
	案例1
	
		创建一个列 a 长度为 65532 的 VARCHAR 类型表 t, 然后插入了列 a 长度为 65532 的记录
		
		CREATE TABLE t (
		a VARCHAR(65532)
		)ENGINE=INNODB CHARSET=LATIN1 ROW_FORMAT=compact;

		INSERT INTO t SELECT REPEAT('a',65532);
		
		[root@mgr9 innodb_page_info]# python py_innodb_page_info.py -v /data/mysql/mysql3306/data/test_db/t.ibd 
		page offset 00000000, page type <File Space Header>
		page offset 00000001, page type <Insert Buffer Bitmap>
		page offset 00000002, page type <File Segment inode>
		page offset 00000003, page type <B-tree Node>, page level <0000>
		page offset 00000004, page type <Uncompressed BLOB Page>
		page offset 00000005, page type <Uncompressed BLOB Page>
		page offset 00000006, page type <Uncompressed BLOB Page>
		page offset 00000007, page type <Uncompressed BLOB Page>
		Total number of page: 8:
		Insert Buffer Bitmap: 1
		Uncompressed BLOB Page: 4
		File Space Header: 1
		B-tree Node: 1
		File Segment inode: 1

		
		表空间有1个数据页节点 B-tree Node, 另外有4个未压缩的二进制大对象页 Uncompressed BLOB Page, 在这些页中才真正存放了 65532 bytes 的数据
		
		行记录的前 768 bytes 在 page offset=3 的页中，但由于 65532>8098 即大于单行记录最大长度，所以将剩余数据放在了溢出页
		溢出页: page offset=4、page offset=5、page offset=6、page offset=7 的这4个页中
	
		65532 byte = 64KB/16KB = 4，需要4个大对象页来存储溢出的数据。
		
		16进制信息	
			hexdump -C -v t.ibd > t.txt
			0000c000  65 ce 78 7c 00 00 00 03  ff ff ff ff ff ff ff ff  |e.x|............|
			0000c010  00 00 00 09 3d 97 e7 03  45 bf 00 00 00 00 00 00  |....=...E.......|
			0000c020  00 00 00 00 12 36 00 02  03 a7 80 03 00 00 00 00  |.....6..........|
			0000c030  00 80 00 05 00 00 00 01  00 00 00 00 00 00 00 00  |................|
			0000c040  00 00 00 00 00 00 00 00  88 90 00 00 12 36 00 00  |.............6..|
			0000c050  00 02 00 f2 00 00 12 36  00 00 00 02 00 32 01 00  |.......6.....2..|
			0000c060  02 00 1d 69 6e 66 69 6d  75 6d 00 02 00 0b 00 00  |...infimum......|
			0000c070  73 75 70 72 65 6d 75 6d  14 c3 00 00 00 10 ff f0  |supremum........|
			0000c080  00 00 00 00 03 01 00 00  00 10 ce 1e b8 00 00 00  |................|
			0000c090  06 01 10 61 61 61 61 61  61 61 61 61 61 61 61 61  |...aaaaaaaaaaaaa|
			0000c0a0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0b0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0c0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0d0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0e0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0f0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c100  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c110  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c120  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c130  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c140  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c150  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c160  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c170  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c180  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c190  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1a0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1b0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1c0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1d0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1e0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1f0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c200  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c210  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c220  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c230  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c240  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c250  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c260  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c270  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c280  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c290  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2a0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2b0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2c0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2d0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2e0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2f0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c300  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c310  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c320  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c330  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c340  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c350  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c360  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c370  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c380  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c390  61 61 61 00 00 12 36 00  00 00 04 00 00 00 26 00  |aaa...6.......&.|
			
	
	案例2
	
		创建一个列 a 长度为 9000 的 VARCHAR 类型表 t, 行记录格式为 compact,  然后插入了列 a 长度为 9000 的记录
		CREATE TABLE t (
		a VARCHAR(9000)
		) ENGINE=INNODB CHARSET=LATIN1 ROW_FORMAT=compact;
		
		INSERT INTO t SELECT REPEAT('a',9000);
		
		
		shell> python py_innodb_page_info.py -v /data/mysql/mysql3306/data/test_db/t.ibd 
		page offset 00000000, page type <File Space Header>
		page offset 00000001, page type <Insert Buffer Bitmap>
		page offset 00000002, page type <File Segment inode>
		page offset 00000003, page type <B-tree Node>, page level <0000>
		page offset 00000004, page type <Uncompressed BLOB Page>
		page offset 00000000, page type <Freshly Allocated Page>
		Total number of page: 6:
		Insert Buffer Bitmap: 1
		Freshly Allocated Page: 1
		File Segment inode: 1
		B-tree Node: 1
		File Space Header: 1
		Uncompressed BLOB Page: 1
		
		
		表空间有1个数据页节点 B-tree Node, 另外有1个未压缩的二进制大对象页 Uncompressed BLOB Page, 在这些页中才真正存放了 9000 byte 的数据; 
		行记录的前 768 byte 在page offset=3的页中，但由于9000>8098>行记录最大长度，所以将剩余数据放在了溢出页，即page offset=4的页中

		
		16进制信息	
			0000c000  8c 46 46 6c 00 00 00 03  ff ff ff ff ff ff ff ff  |.FFl............|
			0000c010  00 00 00 09 3d 98 25 7d  45 bf 00 00 00 00 00 00  |....=.%}E.......|
			0000c020  00 00 00 00 12 37 00 02  03 a7 80 03 00 00 00 00  |.....7..........|
			0000c030  00 80 00 05 00 00 00 01  00 00 00 00 00 00 00 00  |................|
			0000c040  00 00 00 00 00 00 00 00  88 91 00 00 12 37 00 00  |.............7..|
			0000c050  00 02 00 f2 00 00 12 37  00 00 00 02 00 32 01 00  |.......7.....2..|
			0000c060  02 00 1d 69 6e 66 69 6d  75 6d 00 02 00 0b 00 00  |...infimum......|
			0000c070  73 75 70 72 65 6d 75 6d  14 c3 00 00 00 10 ff f0  |supremum........|
			0000c080  00 00 00 00 03 02 00 00  00 10 ce 29 c0 00 00 00  |...........)....|
			0000c090  05 01 10 61 61 61 61 61  61 61 61 61 61 61 61 61  |...aaaaaaaaaaaaa|
			0000c0a0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0b0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0c0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0d0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0e0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c0f0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c100  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c110  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c120  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c130  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c140  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c150  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c160  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c170  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c180  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c190  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1a0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1b0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1c0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1d0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1e0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c1f0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c200  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c210  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c220  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c230  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c240  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c250  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c260  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c270  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c280  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c290  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2a0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2b0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2c0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2d0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2e0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c2f0  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c300  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c310  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c320  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c330  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c340  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c350  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c360  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c370  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c380  61 61 61 61 61 61 61 61  61 61 61 61 61 61 61 61  |aaaaaaaaaaaaaaaa|
			0000c390  61 61 61 00 00 12 37 00  00 00 04 00 00 00 26 00  |aaa...7.......&.|
		
		
	
3.3 行溢出的临界点

	单个字段：
	
		分析一下页中的空间都是如何利用的：

			1. 132个字节：
				每个页除了存放我们的记录以外，也需要存储一些额外的信息，乱七八糟的额外信息加起来需要132个字节的空间（现在只要知道这个数字就好了），其他的空间都可以被用来存储记录。
			
			2. 27个字节
			
				每个记录需要的额外信息是27字节

				这27个字节包括下边这些部分：

					2个字节用于存储真实数据的长度
					1个字节用于存储列是否是NULL值
					5个字节大小的头信息
					6个字节的row_id列
					6个字节的transaction_id列
					7个字节的roll_pointer列
				

			MySQL规定如果该列不发生溢出的现象，就需要满足下边这个式子：
				132 + 2×(27 + n) < 16384

			当 n < 8099，也就是说如果一个列中存储的数据小于8099个字节，那么该列就不会成为溢出列，否则该列就需要成为溢出列。
			
	多个字段：
		目前可以先以8098来计算。
		一行记录长度的字节数加起来大于8098个字节才会有行溢出
		
		

3.4 行溢出跟非行溢出在存储空间的比较

	通过下面的测试，你会发现，t_long 插入的数据仅仅比 t_short 多了几个字节，但是最终的存储却是2~3倍的差距

	行格式
		mysql> SHOW VARIABLES LIKE 'innodb_file_format';
		+--------------------+-----------+
		| Variable_name      | Value     |
		+--------------------+-----------+
		| innodb_file_format | Barracuda |
		+--------------------+-----------+
		1 row in set (0.00 sec)

		mysql> SHOW VARIABLES LIKE '%row%format%';
		+---------------------------+---------+
		| Variable_name             | Value   |
		+---------------------------+---------+
		| innodb_default_row_format | dynamic |
		+---------------------------+---------+
		1 row in set (0.00 sec)
	
	制造数据
		mysql> show create table t_long;
		+--------+---------------------------------------------------------------------------------------------------------+
		| Table  | Create Table                                                                                            |
		+--------+---------------------------------------------------------------------------------------------------------+
		| t_long | CREATE TABLE `t_long` (
		  `id` int(11) DEFAULT NULL,
		  `col1` text
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
		+--------+---------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)

		mysql> show create table t_short;
		+---------+----------------------------------------------------------------------------------------------------------+
		| Table   | Create Table                                                                                             |
		+---------+----------------------------------------------------------------------------------------------------------+
		| t_short | CREATE TABLE `t_short` (
		  `id` int(11) DEFAULT NULL,
		  `col1` text
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
		+---------+----------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)	
		
		DROP PROCEDURE IF EXISTS long_short;
		CREATE PROCEDURE long_short()
		BEGIN
		DECLARE i INT;
		  SET i=1;
		  start transaction;
		  WHILE(i<=48849) DO
			INSERT INTO test_db.t_short select i, repeat('a', 8090);
			INSERT INTO test_db.t_long select i, repeat('a', 8098);
			SET i=i+1; 
		  END WHILE;
		  commit;
		END;			
			

			
			
	最终的记录数

		mysql> select count(*) from t_short;
		+----------+
		| count(*) |
		+----------+
		|    48849 |
		+----------+
		1 row in set (0.03 sec)

		mysql> select count(*) from t_long;
		+----------+
		| count(*) |
		+----------+
		|    48849 |
		+----------+
		1 row in set (0.02 sec)

		# 查看列的长度
		mysql> select LENGTH(col1) from t_long where id=1;
		+--------------+
		| LENGTH(col1) |
		+--------------+
		|         8098 |
		+--------------+
		1 row in set (0.11 sec)

		mysql]> select LENGTH(col1) from t_short where id=1;
		+--------------+
		| LENGTH(col1) |
		+--------------+
		|         8090 |
		+--------------+
		1 row in set (0.09 sec)

		# 1个英文字节占1个字节，所以 8098个英文字母占8098个字节
		
		
	页类型的比较

		执行存储过程插入数据之前
			# 8090
			[root@mgr9 py_innodb_page_info-master]# python py_innodb_page_info.py /data/mysql/mysql3306/data/test_db/t_short.ibd
			Total number of page: 6:
			Freshly Allocated Page: 2
			Insert Buffer Bitmap: 1
			File Space Header: 1
			B-tree Node: 1
			File Segment inode: 1

			# 8098
			[root@mgr9 py_innodb_page_info-master]# python py_innodb_page_info.py /data/mysql/mysql3306/data/test_db/t_long.ibd
			Total number of page: 6:
			Freshly Allocated Page: 2
			Insert Buffer Bitmap: 1
			File Space Header: 1
			B-tree Node: 1
			File Segment inode: 1



		执行存储过程插入数据之后
			# 8090
			[root@mgr9 py_innodb_page_info-master]# python py_innodb_page_info.py /data/mysql/mysql3306/data/test_db/t_short.ibd
			Total number of page: 25344:
			Freshly Allocated Page: 13384
			Insert Buffer Bitmap: 1
			File Space Header: 1
			B-tree Node: 11957
			File Segment inode: 1

			# 8098
			[root@mgr9 py_innodb_page_info-master]# python py_innodb_page_info.py /data/mysql/mysql3306/data/test_db/t_long.ibd
			Total number of page: 50176:
			Insert Buffer Bitmap: 4
			Freshly Allocated Page: 1150
			File Segment inode: 1
			B-tree Node: 168
			File Space Header: 1
			extend description page: 3
			Uncompressed BLOB Page: 48849

	
		最终大小的对比

			[root@mgr9 test_db]# du -sh * | grep 'long\|short' | grep ibd
			785M	t_long.ibd
			397M	t_short.ibd

		结论

			t_short 的表:
				-- 397M 
				-- 计算方式：select 25344 * 16KB = 405504KB = 396MB
				B-tree Node: 11957
				Uncompressed BLOB Page: NO
				
			t_long 的表：
				
				-- 785M
				-- 计算方式：select 168 * 16 = 2688KB = 2.63MB
				-- 计算方式：select 48849 * 16 = 781584KB = 763MB
				-- 计算方式: select 2.63+763 = 765.63MB 
				-- 1个 Uncompressed BLOB Page 的大小也是 16KB 
				-- 由于独享48849个Uncompressed BLOB Page，严重浪费空间  
				B-tree Node: 168
				Uncompressed BLOB Page: 48849

			一行数据如果实际长度大于8k会溢出, varchar(20000) 没有数据(字段值为"")，行数据也不会溢出。
			t_long 插入的数据仅仅比 t_short 多了几个字节，但是最终的存储却是2倍左右的差距。	
			
				
			
		

3.5 2个字段的数据长度都溢出，那么2个字段都有对应的20字节的指针保留在行记录中吗
	
	本实验目的：
		2个字段的数据长度都溢出，那么2个字段都有对应的20字节的指针保留在行记录中吗
		答：是的。
		
	初始化表结构和数据	
		
		CREATE TABLE t_20201118_15 (
			a VARCHAR(9000),
			b VARCHAR(9000)
		) ENGINE=INNODB CHARSET=LATIN1 ROW_FORMAT=compact;
		
		
		INSERT INTO t_20201118_15 SELECT REPEAT('a',9000), REPEAT('a',9000);

		select length(a), length(b) from t_20201118_15;

		mysql> select length(a), length(b) from t_20201118_15;
		+-----------+-----------+
		| length(a) | length(b) |
		+-----------+-----------+
		|      9000 |      9000 |
		+-----------+-----------+
		1 row in set (0.00 sec)
		

	查看使用了多少个大对象页

		shell> python innodb_page_info/py_innodb_page_info.py -v /home/mysql/3306/data/test_db/t_20201118_15.ibd 
		page offset 00000000, page type <File Space Header>
		page offset 00000001, page type <Insert Buffer Bitmap>
		page offset 00000002, page type <File Segment inode>
		page offset 00000003, page type <B-tree Node>, page level <0000>
		page offset 00000004, page type <Uncompressed BLOB Page>
		page offset 00000005, page type <Uncompressed BLOB Page>
		Total number of page: 6:
		Insert Buffer Bitmap: 1
		Uncompressed BLOB Page: 2
		File Space Header: 1
		B-tree Node: 1
		File Segment inode: 1

		
	mysql> select 768+768;
	+---------+
	| 768+768 |
	+---------+
	|    1536 |
	+---------+
	1 row in set (0.00 sec)

