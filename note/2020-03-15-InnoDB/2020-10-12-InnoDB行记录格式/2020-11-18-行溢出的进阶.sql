

本实验目的：
	2个字段的数据长度都溢出，那么2个字段都有对应的20字节的指针保留在行记录中吗
	
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

