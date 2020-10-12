


1. 背景
	生产环境上通过pt-archiver工具归档了日志表的部分数据之后，发现新插入该表的数据不占用数据文件(.ibd)的大小
	本文主要是验证通过innodb ruby工具验证delete删除整页记录之后的空间是可复用的
2. 实验步骤
	2.1 制造数据
	2.2 通过 space-indexes 查看索引信息
	2.3 通过 index-recurse 查看主键的递归索引
	2.4 查看表对应的 information_schema.TABLE、mysql.innodb_table_stats、mysql.innodb_index_stats 和 .ibd 文件的大小
	2.5 删除一个数据页(page no = 5)的所有记录
	2.6 插入10行记录

3. 小结


2. 实验步骤
2.1 制造数据
		
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

		-- 调用存储过程
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
	
	
	重建表空间，使用索引更加紧凑	
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
	
	ROOT NODE #3: 18 records, 234 bytes
	  NODE POINTER RECORD ≥ (id=1) → #5
	  LEAF NODE #5: 553 records, 14931 bytes
		RECORD: (id=1) → (name="lujb")
		RECORD: (id=2) → (name="lujb")
		...............................
		RECORD: (id=552) → (name="lujb")
		RECORD: (id=553) → (name="lujb")
	  NODE POINTER RECORD ≥ (id=554) → #6	
	
	可以看到，page no = 5 的数据页有553行记录
	
2.4 查看表对应的 information_schema.TABLE、mysql.innodb_table_stats、mysql.innodb_index_stats 和 .ibd 文件的大小
	information_schema.TABLES
		root@localhost [zst]>select table_schema,table_name,DATA_FREE,CREATE_TIME, UPDATE_TIME from  information_schema.TABLES where table_schema='zst' and table_name='t_20200329';
		+--------------+------------+-----------+---------------------+-------------+
		| table_schema | table_name | DATA_FREE | CREATE_TIME         | UPDATE_TIME |
		+--------------+------------+-----------+---------------------+-------------+
		| zst          | t_20200329 |         0 | 2020-03-29 15:57:39 | NULL        |
		+--------------+------------+-----------+---------------------+-------------+
		1 row in set (0.00 sec)
	
	mysql.innodb_table_stats
		root@localhost [zst]>select * from mysql.innodb_table_stats  where table_name = 't_20200329';
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| zst           | t_20200329 | 2020-03-29 15:57:39 |   9953 |                   19 |                       10 |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.00 sec)
		
	mysql.innodb_index_stats
		root@localhost [zst]>select * from mysql.innodb_index_stats  where table_name = 't_20200329';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | n_diff_pfx01 |       9953 |          18 | id                                |
		| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | n_leaf_pages |         18 |        NULL | Number of leaf pages in the index |
		| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | size         |         19 |        NULL | Number of pages in the index      |
		| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_diff_pfx01 |          1 |           9 | name                              |
		| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_diff_pfx02 |       9953 |           9 | name,id                           |
		| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_leaf_pages |          9 |        NULL | Number of leaf pages in the index |
		| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | size         |         10 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		7 rows in set (0.00 sec)
		
	.ibd 文件的大小
		[root@env27 data]# ll zst/t_20200329.ibd
		-rw-r----- 1 mysql mysql 557056 Mar 29 15:57 zst/t_20200329.ibd


2.5 删除一个数据页(page no = 5)的所有记录
			
	root@localhost [zst]>delete from zst.t_20200329 where id <=553;
	Query OK, 553 rows affected (0.00 sec)
	
	查看 .ibd 文件物理数据大小	
		[root@env27 data]# ll zst/t_20200329.ibd
		-rw-r----- 1 mysql mysql 557056 Mar 29 16:03 zst/t_20200329.ibd
		
	可以看到，删除一个数据页(page no = 5)的所有记录，磁盘文件的大小并不会缩小。
	
	root@localhost [zst]>select table_schema,table_name,DATA_FREE,CREATE_TIME, UPDATE_TIME from  information_schema.TABLES where table_schema='zst' and table_name='t_20200329';
	+--------------+------------+-----------+---------------------+---------------------+
	| table_schema | table_name | DATA_FREE | CREATE_TIME         | UPDATE_TIME         |
	+--------------+------------+-----------+---------------------+---------------------+
	| zst          | t_20200329 |         0 | 2020-03-29 15:57:39 | 2020-03-29 16:03:36 |
	+--------------+------------+-----------+---------------------+---------------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>select * from mysql.innodb_table_stats  where table_name = 't_20200329';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| zst           | t_20200329 | 2020-03-29 15:57:39 |   9953 |                   19 |                       10 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>select * from mysql.innodb_index_stats  where table_name = 't_20200329';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | n_diff_pfx01 |       9953 |          18 | id                                |
	| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | n_leaf_pages |         18 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | size         |         19 |        NULL | Number of pages in the index      |
	| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_diff_pfx01 |          1 |           9 | name                              |
	| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_diff_pfx02 |       9953 |           9 | name,id                           |
	| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_leaf_pages |          9 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | size         |         10 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)

	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200329 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	272         PRIMARY                         3           internal    1           1           100.00%     
	272         PRIMARY                         3           leaf        17          17          100.00%     
	273         idx_name                        4           internal    1           1           100.00%     
	273         idx_name                        4           leaf        9           9           100.00% 
				
	
2.6 插入10行记录

	本案例需要插入1行记录才能填满最后一个数据页， 这里插入10行记录，意味着有9行记录需要申请新的数据页。
	
	root@localhost [zst]>INSERT INTO zst.t_20200329(name)VALUES('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb'), ('lujb');
	Query OK, 10 rows affected (0.00 sec)
	Records: 10  Duplicates: 0  Warnings: 0

	
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200329 -I PRIMARY index-recurse  > 2.sql

	[root@env27 data]# tail -12 2.sql 
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
		
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200329 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	272         PRIMARY                         3           internal    1           1           100.00%     
	272         PRIMARY                         3           leaf        18          18          100.00%     
	273         idx_name                        4           internal    1           1           100.00%     
	273         idx_name                        4           leaf        9           9           100.00%  

	[root@env27 data]# ll zst/t_20200329.ibd
	-rw-r----- 1 mysql mysql 557056 Mar 29 16:05 zst/t_20200329.ibd
	   

	root@localhost [zst]>select table_schema,table_name,DATA_FREE,CREATE_TIME, UPDATE_TIME from  information_schema.TABLES where table_schema='zst' and table_name='t_20200329';
	+--------------+------------+-----------+---------------------+---------------------+
	| table_schema | table_name | DATA_FREE | CREATE_TIME         | UPDATE_TIME         |
	+--------------+------------+-----------+---------------------+---------------------+
	| zst          | t_20200329 |         0 | 2020-03-29 15:57:39 | 2020-03-29 16:05:27 |
	+--------------+------------+-----------+---------------------+---------------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>select * from mysql.innodb_table_stats  where table_name = 't_20200329';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| zst           | t_20200329 | 2020-03-29 15:57:39 |   9953 |                   19 |                       10 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>select * from mysql.innodb_index_stats  where table_name = 't_20200329';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | n_diff_pfx01 |       9953 |          18 | id                                |
	| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | n_leaf_pages |         18 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200329 | PRIMARY    | 2020-03-29 15:57:39 | size         |         19 |        NULL | Number of pages in the index      |
	| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_diff_pfx01 |          1 |           9 | name                              |
	| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_diff_pfx02 |       9953 |           9 | name,id                           |
	| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | n_leaf_pages |          9 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200329 | idx_name   | 2020-03-29 15:57:39 | size         |         10 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)




3. 小结
	1. 从实验中可以看到，删除一个页的所有记录，会把该页移除，但是该页是可以复用的
	2. 当插入的记录需要申请新的数据页的时候，会插入到可复用的数据页中，同时对应的 .ibd 数据文件并不会增大。
		
	最好一个数据页有多少行记录，需要插入多少行才能填满
	
	LEAF NODE #23: 553 records, 14931 bytes 
	需要插入1行记录才能填满最好一个数据页， 这里插入10行记录，意味着有9行记录需要申请新的数据页。
	
	
	
	
	