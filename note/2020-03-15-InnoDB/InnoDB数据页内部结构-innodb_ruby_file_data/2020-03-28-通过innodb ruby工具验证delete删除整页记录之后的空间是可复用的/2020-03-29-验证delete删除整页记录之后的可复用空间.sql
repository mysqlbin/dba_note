
1. 加上查看脏的验证。
2. 不用这么多数据来做演示

1. 背景
	生产环境上通过pt-archiver工具归档了日志表的部分数据之后，发现新插入该表的数据不占用数据文件(.ibd)的大小
	本文主要是通过innodb ruby工具验证delete删除整页记录之后的空间是可复用的
	
2. 实验步骤
	2.0 本次的实验环境
	2.1 制造数据
	2.2 通过 space-indexes 查看索引信息
	2.3 通过 index-recurse 查看主键的递归索引
	2.4 查看数据表的.ibd 文件的大小
	2.5 删除一个数据页(page no = 5)的所有记录
	2.6 插入10行记录

3. 小结


2. 实验步骤

2.0 本次的实验环境

	root@localhost [zst]>select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.19-log |
	+------------+
	1 row in set (0.00 sec)
	
	root@localhost [zst]>show global variables like 'innodb_page_size';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| innodb_page_size | 16384 |
	+------------------+-------+
	1 row in set (0.01 sec)
	
	
2.1 制造数据

	-- 表的DDL
	CREATE TABLE `t_20200329` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `name` varchar(32) NOT NULL default '',
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	-- 创建存储过程
	DROP PROCEDURE IF EXISTS insertbatch;
	CREATE PROCEDURE insertbatch()
	BEGIN
	DECLARE i INT;
	  SET i=1;
	  WHILE(i<=9953) DO
		INSERT INTO zst.t_20200329(name)VALUES('lujb');
		SET i=i+1; 
	  END WHILE;
	END;

	-- 调用存储过程, 一共插入9953行记录
	call insertbatch();



2.2 通过 space-indexes 查看索引信息

	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200329 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	270         PRIMARY                         3           internal    1           1           100.00%     
	270         PRIMARY                         3           leaf        19          19          100.00%     
	271         idx_name                        4           internal    1           1           100.00%     
	271         idx_name                        4           leaf        10          10          100.00% %    
	
	name：表示索引名称
	fseg：为leaf表示属于叶子页的segment
	used: 表示索引树使用了多少个page
	
	
	重建表空间，让索引更加紧凑	
		alter table t_20200329 engine=InnoDB;
		root@localhost [zst]>alter table t_20200329 engine=InnoDB;
		Query OK, 0 rows affected (0.75 sec)
		Records: 0  Duplicates: 0  Warnings: 0
	
	再次通过  space-indexes 查看索引信息 
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200329 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	272         PRIMARY                         3           internal    1           1           100.00%     
	272         PRIMARY                         3           leaf        18          18          100.00%     
	273         idx_name                        4           internal    1           1           100.00%     
	273         idx_name                        4           leaf        9           9           100.00%   
	
	
2.3 通过 index-recurse 查看主键的递归索引
	[root@env27 data]#innodb_space -s ibdata1 -T zst/t_20200329 -I PRIMARY index-recurse  > 1.sql
	
	查看 1.sql 的内容：
		ROOT NODE #3: 18 records, 234 bytes
		  NODE POINTER RECORD ≥ (id=1) → #5
		  LEAF NODE #5: 553 records, 14931 bytes
			RECORD: (id=1) → (name="lujb")
			RECORD: (id=2) → (name="lujb")
			...............................
			RECORD: (id=552) → (name="lujb")
			RECORD: (id=553) → (name="lujb")
		  NODE POINTER RECORD ≥ (id=554) → #6	
	
	可以看到，page no = 5 的数据页有554行记录
	
	
2.4 查看数据表的.ibd 文件的大小
	
	.ibd 文件的大小
		[root@env27 data]# ll zst/t_20200329.ibd
		-rw-r----- 1 mysql mysql 557056 Mar 29 15:57 zst/t_20200329.ibd
		
		可以看到， .ibd 数据文件的大小为 557056 字节

2.5 删除一个数据页(page no = 5)的所有记录
			
	root@localhost [zst]>delete from zst.t_20200329 where id <=553;
	Query OK, 553 rows affected (0.00 sec)
	
	查看 .ibd 文件物理数据大小	
		[root@env27 data]# ll zst/t_20200329.ibd
		-rw-r----- 1 mysql mysql 557056 Mar 29 16:03 zst/t_20200329.ibd
		
		可以看到， .ibd 数据文件的大小为 557056 字节， 删除一个数据页(page no = 5)的所有记录，磁盘文件的大小并不会缩小。
	
	
	通过  space-indexes 查看索引信息 
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200329 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	272         PRIMARY                         3           internal    1           1           100.00%     
	272         PRIMARY                         3           leaf        17          17          100.00%     
	273         idx_name                        4           internal    1           1           100.00%     
	273         idx_name                        4           leaf        9           9           100.00% 
				
		主键leaf叶子节点一共使用了17个数据页，较前面少了一个数据页			
	
2.6 插入10行记录

	本案例需要再插入1行记录才能填满最后一个数据页， 这里插入10行记录，意味着有9行记录需要申请新的数据页。
	
	root@localhost [zst]>INSERT INTO t_20200329(name)VALUES('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb');
	Query OK, 10 rows affected (0.00 sec)
	Records: 10  Duplicates: 0  Warnings: 0

	通过 index-recurse 查看主键的递归索引
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200329 -I PRIMARY index-recurse  > 2.sql
	[root@env27 data]# tail -13 2.sql 
		RECORD: (id=9953) → (name="lujb")
		RECORD: (id=9954) → (name="lujb")
	  NODE POINTER RECORD ≥ (id=9955) → #25
	  LEAF NODE #25: 9 records, 243 bytes
		RECORD: (id=9955) → (name="lujb")
		RECORD: (id=9956) → (name="lujb")
		RECORD: (id=9957) → (name="lujb")
		RECORD: (id=9958) → (name="lujb")
		RECORD: (id=9959) → (name="lujb")
		RECORD: (id=9960) → (name="lujb")
		RECORD: (id=9961) → (name="lujb")
		RECORD: (id=9962) → (name="lujb")
		RECORD: (id=9963) → (name="lujb")
	
		可以看到，一共有9行记录(id between 9955 and 9963)需要申请新的数据页(page no=25)。
	
	
		
	通过  space-indexes 查看索引信息 
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200329 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	272         PRIMARY                         3           internal    1           1           100.00%     
	272         PRIMARY                         3           leaf        18          18          100.00%     
	273         idx_name                        4           internal    1           1           100.00%     
	273         idx_name                        4           leaf        9           9           100.00%  
	
		当前主键leaf叶子节点一共使用了18个数据页，在删除一个数据页的所有记录之后，主键leaf叶子节点一共使用了17个数据页
	
	
	[root@env27 data]# ll zst/t_20200329.ibd
	-rw-r----- 1 mysql mysql 557056 Mar 29 16:05 zst/t_20200329.ibd
	
		可以看到， .ibd 数据文件的大小为 557056 字节。

3. 小结
	1. 从实验中可以看到，删除一个页的所有记录，会把该页移除，但是该页是可以复用的
	2. 当插入的记录需要申请新的数据页的时候，已经删除的数据页是可以被复用的，同时对应的 .ibd 数据文件并不会增大，本案例 .ibd 数据文件的大小为 557056 字节。
	3. delete命令删除记录是不能回收表空间的。
	
	
	
		
	
	
	
	