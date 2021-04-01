
参数
	table_open_cache ： 
		表示所有线程能打开表的数量
		table_open_cache指定表高速缓存的大小。每当MySQL访问一个表时，如果在表缓冲区中还有空间，该表就被打开并放入其中，这样可以更快地访问表内容。
		
		能缓存表的个数大小
		
		
状态值
	Open_tables:
		表示当前正被打开的 table 数量

	Opened_tables:
		表示历史上反复打开 table 的总次数

如何判断 table_open_cache 大小是否够用？
	可根据MySQL的两个状态值来分析

		Opened_tables  : 打开的所有表数量
		open_tables    : 打开后在缓存中的表数量
		
		通过以上两个值来判断 table_open_cache 是否到达瓶颈
		当缓存中的值 open_tables 临近到了 table_open_cache 值的时候
		说明表缓存池快要满了 但 Opened_tables 还在一直有新的增长 这说明你还有很多未被缓存的表
		这时可以适当增加 table_open_cache 的大小


设置太大和太小的影响


	太小:
		因为table cache不够了，导致要频繁打开、关闭table，导致SQL语句返回慢, 导致table id急剧增长，因而导致主从数据复制失败。
		
		
	不是越大越好 table_open_cache 过大占用大量文件描述符资源而不释放, 用尽了系统文件描述符资源导致无法接入新的连接
		
	https://www.cnblogs.com/wangdong/p/9242983.html MySQL Can't create a new thread报错分析

	
show global variables like '%table_open_cache%';		
show global status like '%tables%';

	mysql> show global variables like '%table_open_cache%';
	+----------------------------+-------+
	| Variable_name              | Value |
	+----------------------------+-------+
	| table_open_cache           | 1024  |
	| table_open_cache_instances | 64    |
	+----------------------------+-------+
	2 rows in set (0.00 sec)
	
	mysql> show global status like '%tables%';
	+-------------------------+-------+
	| Variable_name           | Value |
	+-------------------------+-------+
	| Com_alter_tablespace    | 0     |
	| Com_lock_tables         | 0     |
	| Com_show_open_tables    | 0     |
	| Com_show_tables         | 149   |
	| Com_unlock_tables       | 4     |
	| Created_tmp_disk_tables | 2436  |
	| Created_tmp_tables      | 5339  |
	| Open_tables             | 797   |
	| Opened_tables           | 9176  |
	| Slave_open_temp_tables  | 0     |
	+-------------------------+-------+
	10 rows in set (0.00 sec)

相关参考
	https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache
	https://www.jianshu.com/p/8483b321bd65    MySQL 优化之 table_open_cache
	https://mp.weixin.qq.com/s/8Ue3m1V315-6mt-8jRRnyw  FAQ系列 | table id问题导致主从复制失败
	https://www.jianshu.com/p/c2fccdb4c08e   table_open_cache
	
	