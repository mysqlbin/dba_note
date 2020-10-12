
1. 加上查看脏的验证。
2. 不用这么多数据来做演示

1. 背景
	生产环境上通过pt-archiver工具归档了日志表的部分数据之后，发现新插入该表的数据不占用数据文件(.ibd)的大小（碎片减少了）
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
	innodb_file_per_table  = ON;
	innodb_page_size       = 16384;
	select version()       = 5.7.19;
	
	
2.1 制造数据

	-- 表的DDL
	CREATE TABLE `t_20200403` (
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
	  WHILE(i<=1105) DO
		INSERT INTO zst.t_20200403(name)VALUES('lujb');
		SET i=i+1; 
	  END WHILE;
	END;

	-- 调用存储过程, 一共插入9953行记录
	call insertbatch();

	root@localhost [zst]>select count(*) from t_20200403;
	+----------+
	| count(*) |
	+----------+
	|     1105 |
	+----------+
	1 row in set (0.00 sec)
	
2.2 通过 space-indexes 查看索引信息

	
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200403 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	281         PRIMARY                         3           internal    1           1           100.00%     
	281         PRIMARY                         3           leaf        3           3           100.00%     
	282         idx_name                        4           internal    1           1           100.00%     
	282         idx_name                        4           leaf        0           0           0.00%  
	
	name：表示索引名称
	fseg：为leaf表示属于叶子页的segment
	used: 表示索引树使用了多少个page
	
	
2.3 通过 index-recurse 查看主键的递归索引
	[root@env27 data]#innodb_space -s ibdata1 -T zst/t_20200403 -I PRIMARY index-recurse  > index-recurse-01.sql
	
	[root@env27 data]# grep "LEAF" index-recurse-01.sql 
	  LEAF NODE #5: 276 records, 7452 bytes
	  LEAF NODE #6: 553 records, 14931 bytes
	  LEAF NODE #7: 276 records, 7452 bytes
		
	 
	查看 index-recurse-01.sql 的内容：
		ROOT NODE #3: 3 records, 39 bytes
		  NODE POINTER RECORD ≥ (id=1) → #5
		  LEAF NODE #5: 276 records, 7452 bytes
			RECORD: (id=1) → (name="lujb")
			RECORD: (id=2) → (name="lujb")
			............................,,
			RECORD: (id=276) → (name="lujb")
		  NODE POINTER RECORD ≥ (id=277) → #6
		  LEAF NODE #6: 553 records, 14931 byte
					  
		一共有 page no = 5 page no = 6 page no = 7 这三个page.
		可以看到，page no = 5 的数据页有 276 行记录
	

	
2.4 查看数据表的.ibd 文件的大小
	
	查看脏页是否刷盘完成：
		root@localhost [zst]>show status like 'Innodb_buffer_pool_pages_dirty';
		+--------------------------------+-------+
		| Variable_name                  | Value |
		+--------------------------------+-------+
		| Innodb_buffer_pool_pages_dirty | 0     |
		+--------------------------------+-------+
		1 row in set (0.00 sec)
		
	
	.ibd 文件的大小
		[root@env27 data]# ll zst/t_20200403.ibd
		-rw-r----- 1 mysql mysql 147456 Mar 30 00:56 zst/t_20200403.ibd
			
		可以看到， .ibd 数据文件的大小为 147456 字节



  
重建表空间，使用索引更加紧凑	
	
	root@localhost [zst]>alter table t_20200403 engine=InnoDB;
	Query OK, 0 rows affected (0.06 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200403 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	285         PRIMARY                         3           internal    1           1           100.00%     
	285         PRIMARY                         3           leaf        2           2           100.00%     
	286         idx_name                        4           internal    1           1           100.00%     
	286         idx_name                        4           leaf        0           0           0.00% 
	
	
	innodb_space -s ibdata1 -T zst/t_20200403 -I PRIMARY index-recurse  > index-recurse-02.sql
	
	[root@env27 data]# grep "LEAF" index-recurse-02.sql 
	  LEAF NODE #5: 553 records, 14931 bytes
	  LEAF NODE #6: 552 records, 14904 bytes
	
	ROOT NODE #3: 2 records, 26 bytes
	  NODE POINTER RECORD ≥ (id=1) → #5
	  LEAF NODE #5: 553 records, 14931 bytes
		RECORD: (id=1) → (name="lujb")
		RECORD: (id=2) → (name="lujb")
		RECORD: (id=3) → (name="lujb")
	
	    RECORD: (id=553) → (name="lujb")
	  NODE POINTER RECORD ≥ (id=554) → #6
	  LEAF NODE #6: 552 records, 14904 bytes
	
	
	root@localhost [zst]>show status like 'Innodb_buffer_pool_pages_dirty';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| Innodb_buffer_pool_pages_dirty | 0     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)


	[root@env27 data]# ll zst/t_20200403.ibd
	-rw-r----- 1 mysql mysql 147456 Mar 30 01:05 zst/t_20200403.ibd

		
	
	
		
2.5 删除一个数据页(page no = 5)的所有记录
	root@localhost [zst]>select table_schema,table_name,DATA_FREE,CREATE_TIME, UPDATE_TIME from  information_schema.TABLES where table_schema='zst' and table_name='t_20200403';
	+--------------+------------+-----------+---------------------+-------------+
	| table_schema | table_name | DATA_FREE | CREATE_TIME         | UPDATE_TIME |
	+--------------+------------+-----------+---------------------+-------------+
	| zst          | t_20200403 |         0 | 2020-03-30 01:05:34 | NULL        |
	+--------------+------------+-----------+---------------------+-------------+
	1 row in set (0.00 sec)
	
	root@localhost [zst]>delete from zst.t_20200403 where id <=553;
	Query OK, 553 rows affected (0.04 sec)

	
	查看 .ibd 文件物理数据大小	
		[root@env27 data]# ll zst/t_20200403.ibd
		-rw-r----- 1 mysql mysql 147456 Mar 30 01:10 zst/t_20200403.ibd
		
		可以看到， .ibd 数据文件的大小为 147456 字节， 删除一个数据页(page no = 5)的所有记录，磁盘文件的大小并不会缩小。
	
	
	通过  space-indexes 查看索引信息 
		[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200403 space-indexes
		id          name                            root        fseg        used        allocated   fill_factor 
		285         PRIMARY                         3           internal    1           1           100.00%     
		285         PRIMARY                         3           leaf        0           0           0.00%       
		286         idx_name                        4           internal    1           1           100.00%     
		286         idx_name                        4           leaf        0           0           0.00% 
				
		主键leaf叶子节点一共使用了17个数据页，较前面少了一个数据页			
	
	
2.6 插入10行记录

	本案例需要再插入1行记录才能填满最后一个数据页， 这里插入10行记录，意味着有9行记录需要申请新的数据页。
	
	root@localhost [zst]>INSERT INTO t_20200403(name)VALUES('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb');
	Query OK, 10 rows affected (0.00 sec)
	Records: 10  Duplicates: 0  Warnings: 0

	通过 index-recurse 查看主键的递归索引
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200403 -I PRIMARY index-recurse  > 2.sql
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
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200403 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	272         PRIMARY                         3           internal    1           1           100.00%     
	272         PRIMARY                         3           leaf        18          18          100.00%     
	273         idx_name                        4           internal    1           1           100.00%     
	273         idx_name                        4           leaf        9           9           100.00%  
	
		当前主键leaf叶子节点一共使用了18个数据页，在删除一个数据页的所有记录之后，主键leaf叶子节点一共使用了17个数据页
	
	
	[root@env27 data]# ll zst/t_20200403.ibd
	-rw-r----- 1 mysql mysql 557056 Mar 29 16:05 zst/t_20200403.ibd
	
		可以看到， .ibd 数据文件的大小为 557056 字节。

3. 小结
	1. 从实验中可以看到，删除一个页的所有记录，会把该页移除，但是该页是可以复用的
	2. 当插入的记录需要申请新的数据页的时候，已经删除的数据页是可以被复用的，同时对应的 .ibd 数据文件并不会增大，本案例 .ibd 数据文件的大小为 557056 字节。
	3. delete命令删除记录是不能回收表空间的。
	
	
	
		
	
	
	
	