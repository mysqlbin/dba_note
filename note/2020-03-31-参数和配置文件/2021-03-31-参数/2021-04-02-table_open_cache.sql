MySQL
	 
	open_files_limit
		限制mysqld能打开的文件数量
	innodb_open_files 
	
		限制InnoDB能打开的文件数量
		
	table_open_cache
	
	table_definition_cache
	
	
table_open_cache参数
	表示所有线程能缓存表的个数大小
		
		
table_open_cache的作用
	就是节约从磁盘读取表结构文件的开销。
	第一次打开表，需要从磁盘文件上读取，然后缓存到table cache中，下一次读取，直接从table cache中读取，自然节约了从磁盘读取表文件的开销。
	表结构文件位于磁盘的 .frm 表文件。
	
	
小结
	所有的缓存设计，都是为了避免直接访问磁盘。
	
		
状态值
	Open_tables:
		表示当前正被打开的 table 数量

	Opened_tables:
		表示历史上反复打开 table 的总次数
	

如何判断 table_open_cache 大小是否够用
	
	可根据MySQL的两个状态值来分析
		Opened_tables  : 
			The number of tables that have been opened. If Opened_tables is big, your table_open_cache value is probably too small.
			表示历史上反复打开的所有表数量
			如果 Opened_tables 值特别高，表明 table cache 很可能不够用所致。
			
		open_tables    : 
			The number of tables that are open. 
			表示当前正被打开的 table 数量
			
		通过以上两个值来判断 table_open_cache 是否到达瓶颈
		当缓存中的值 open_tables 临近到了 table_open_cache 值的时候
		说明表缓存池快要满了 但 Opened_tables 还在一直有新的增长 这说明你还有很多未被缓存的表
		这时可以适当增加 table_open_cache 的大小
	
	
	判断是否命中表缓冲
		查看状态Table_open_cache_hits
		root@mysqldb 09:49:  [test_db]> show global status like '%open_cache_hit%';
		+-----------------------+-------+
		| Variable_name         | Value |
		+-----------------------+-------+
		| Table_open_cache_hits | 36347 |
		+-----------------------+-------+
		1 row in set (0.00 sec)
		
	关于 table_open_cache 的建议值公式：
		建议值 = 最大并发数 * join 语句涉及的表的最大个数。

	
设置太大和太小的影响


	太小:
		因为table cache不够了，导致要频繁打开、关闭table，导致SQL语句返回慢, 导致table id急剧增长，因而导致主从数据复制失败。
	
	不是越大越好 table_open_cache 过大占用大量文件描述符资源而不释放, 用尽了系统文件描述符资源导致无法接入新的连接
	增大该值将增加mysqld所需的文件描述符的数量 。
	
	https://www.cnblogs.com/wangdong/p/9242983.html     MySQL Can t create a new thread 报错分析



生产环境的设置和状态
	
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.26-log |
	+------------+
	1 row in set (0.00 sec)
	
	table_open_cache
		Default Value	2000
		Minimum Value	1
		Maximum Value	524288

	show global variables like '%table_open_cache%';		
	show global status like '%tables%';
	show global variables like '%table_definition_cache%';
	
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


	mysql> show global status like '%tables%';
	+-------------------------+---------+
	| Variable_name           | Value   |
	+-------------------------+---------+
	| Com_alter_tablespace    | 0       |
	| Com_lock_tables         | 2       |
	| Com_show_open_tables    | 0       |
	| Com_show_tables         | 29704   |
	| Com_unlock_tables       | 5       |
	| Created_tmp_disk_tables | 65994   |
	| Created_tmp_tables      | 4248444 |
	| Open_tables             | 992     |
	| Opened_tables           | 540650  |
	| Slave_open_temp_tables  | 0       |
	+-------------------------+---------+
	10 rows in set (0.01 sec)



相关参考

	https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache
	https://www.jianshu.com/p/8483b321bd65    MySQL 优化之 table_open_cache
	
	https://mp.weixin.qq.com/s/8Ue3m1V315-6mt-8jRRnyw  FAQ系列 | table id问题导致主从复制失败
	
	https://www.jianshu.com/p/c2fccdb4c08e   table_open_cache
	
	https://mp.weixin.qq.com/s/QfTY16wp99X7l4TcjakYYQ
	
	https://mp.weixin.qq.com/s/2fSW7F8wn-Bt3nd56kFyRw
	
	https://mp.weixin.qq.com/s/p1CkgV_Nve63GKGmQ58vWg  
	
	
别人面试问到：
	table_open_cache 怎么优化
	思路：
		查看打开表的状态值
		查看open_tables状态的值是否接近于 table_open_cache，同时 opened_tables状态的值是否在持续增加。
	
	
	
	


	