MySQL
	 
	open_files_limit
		限制所有文件的打开数量
	innodb_open_files 
		限制InnoDB文件的打开数量
		
	table_open_cache
	
	table_definition_cache
	
	
open_files_limit 参数使用的是默认值 1024，那么就会在访问这个表的时候，由于需要打开所有的文件，导致打开表文件的个数超过了上限而报错。
	.frm 文件 
	.ibd 文件
 	
老师，mysql还有一个参数是innodb_open_files，资料上说作用是限制Innodb能打开的表的数量。它和open_files_limit之间有什么关系吗？
	
	在InnoDB引擎打开文件超过 innodb_open_files这个值的时候，就会关掉一些之前打开的文件。

	其实我们文章中 ，InnoDB分区表使用了本地分区策略以后，即使分区个数大于open_files_limit ，打开InnoDB分区表也不会报“打开文件过多”这个错误，就是 innodb_open_files 这个参数发挥的作用。


table_definition_cache

	该cache用于缓存 .frm 文件，该选项也预示着 .frm 文件同时可打开最大数量。
	5.6.7 以前默认值400；
	5.6.7 之后是自动计算的，且最低为400，自动计算公式：400 + (table_open_cache / 2)。

	对InnoDB而言，该选项只是软性限制，如果超过限制了，则会根据LRU原则，把旧的条目删除，加入新的条目。

	此外，innodb_open_files 也控制着最大可打开的表数量，和 table_definition_cache 都起到限制作用，以其中较大的为准。
	
	如果没配置限制，则通常选择 table_definition_cache 作为上限，因为它的默认值是 200，比较大。

	-- by 叶老师
	
	
------------------------------------

.frm 可以存储在定义高速缓存中 的表定义（来自文件）的数量 。如果使用大量表，则可以创建大表定义缓存以加快表的打开速度。与普通表高速缓存不同，表定义高速缓存占用的空间更少，并且不使用文件描述符。

建议值
	400 + (table_open_cache / 2)
	root@mysqldb 15:09:  [test_db]> select 400 + (1024/2);
	+----------------+
	| 400 + (1024/2) |
	+----------------+
	|       912.0000 |
	+----------------+
	1 row in set (0.00 sec)



配置建议

	除非有上万张表，一般建议设置 table_definition_cache 值略大于表数量，使缓存能够容纳所有的表定义
	
	
https://mp.weixin.qq.com/s/p1CkgV_Nve63GKGmQ58vWg  [MySQL FAQ]系列 — 怎么计算打开文件数

https://mp.weixin.qq.com/s/2fSW7F8wn-Bt3nd56kFyRw  [缺陷分析] Table cache 导致 MySQL 崩溃




mysql> show global variables like '%table_open_cache%';
+----------------------------+-------+
| Variable_name              | Value |
+----------------------------+-------+
| table_open_cache           | 995   |
| table_open_cache_instances | 16    |
+----------------------------+-------+
2 rows in set (0.00 sec)

mysql> show global variables like '%table_definition_cache%';
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| table_definition_cache | 897   |
+------------------------+-------+
1 row in set (0.00 sec)


mysql> show global variables like '%innodb_open_files%';
+-------------------+-------+
| Variable_name     | Value |
+-------------------+-------+
| innodb_open_files | 995   |
+-------------------+-------+
1 row in set (0.00 sec)












