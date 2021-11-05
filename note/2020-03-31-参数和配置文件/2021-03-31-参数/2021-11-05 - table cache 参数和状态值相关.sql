
1. 参数列表
2. 参数含义
	2.1 table_open_cache 参数
	2.2 table_definition_cache 参数

3. 状态统计值
4. 如何判断 table_open_cache 大小是否够用
5. table_open_cache参数设置太大和太小的影响
6. 相关参考
7. 别人面试问到 table_open_cache 参数怎么优化
8. 生产环境的参数和状态值
9. open_files_limit 参数

	

1. 参数列表
	 
	open_files_limit：
	
		限制mysqld能打开的文件数量
	
	
	innodb_open_files：
	
		限制InnoDB能打开的文件数量
		对于 innodb_open_files 来说不能大于 open_files_limit 的设置
		
		
	table_open_cache：
	
		缓存表的个数，线程级别
		
		
	table_definition_cache：
	
		缓存表的个数，全局级别
	
	
	小结：
		
		所有的缓存设计，都是为了避免直接访问磁盘。
	
2. 参数含义

	2.1 table_open_cache 参数
		
		https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache
		
		含义：
			表示所有线程能缓存表的个数大小
			
			-- 没有毛病
				MySQL 的文档，关于 table_open_cache 的建议值公式：
					建议值 = 最大并发数 * join 语句涉及的表的最大个数。
				
				通过实验我们容易理解：table_cache 是针对于线程的，所以需要最大并发数个缓存。
				另外，一个语句 join 涉及的表，需要同时在缓存中存在。所以最小的缓存大小，等于语句 join 涉及的表的最大个数。
				将这两个数相乘，就得到了 MySQL 的建议值公式。	
				
			
		table_open_cache的作用：

			就是节约从磁盘读取表结构文件的开销。
			第一次打开表，需要从磁盘文件上读取，然后缓存到table cache中，下一次读取，直接从table cache中读取，自然节约了从磁盘读取表文件的开销。
			表结构文件位于磁盘的 .frm 表文件。
			
			在同一个线程内，减少了重复读取表定义的成本，包括读取表定义文件的 IO 成本， 和 构造内存结构的 CPU 成本。(要注意 table cache 是线程级别的)
				table definition cache (之后我们简称为 TDC)，TDC 是全局级别的表定义缓存	


	2.2 table_definition_cache 参数
		
		https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache
		
		该cache用于缓存 .frm 文件，该选项也预示着 .frm 文件同时可打开最大数量。
		
		是全局级别的表定义缓存。
		
		5.6.7 以前默认值400；
		
		5.6.7 之后是自动计算的，且最低为400，自动计算公式：400 + (table_open_cache / 2)。


		对InnoDB而言，该选项只是软性限制，如果超过限制了，则会根据LRU原则，把旧的条目删除，加入新的条目。

		此外，innodb_open_files 也控制着最大可打开的表数量，和 table_definition_cache 都起到限制作用，以其中较大的为准。
		
		如果没配置限制，则通常选择 table_definition_cache 作为上限，因为它的默认值是 200，比较大。

		-- by 叶老师
		
		配置建议
		
			建议始终保持 状态 Opened_table_definitions 小于参数 table_definition_cache , 这样就能保证 TDC 始终命中。
			除非有上万张表，一般建议设置 table_definition_cache 值略大于表数量，使缓存能够容纳所有的表定义
		

			mysql> show global status like '%Opened_table_definitions%';
			+--------------------------+------------+
			| Variable_name            | Value 		|
			+--------------------------+------------+
			| Opened_table_definitions | 2496151    |
			+--------------------------+------------+
			1 row in set (0.01 sec)

			mysql> show global variables like 'table_definition_cache';
			+------------------------+-------+
			| Variable_name          | Value |
			+------------------------+-------+
			| table_definition_cache | 897   |
			+------------------------+-------+
			1 row in set (0.00 sec)



3. 状态统计值
	
	Innodb_num_open_files：
		The number of files InnoDB currently holds open.  
		InnoDB 当前打开的文件数。
		
		
	Open_files：	
		MySQL层当前打开的文件数，来自my_file_opened，close的时候会减去1
		
	
	Opened_files：  
		MySQL总共打开文件的总数，来自my_file_total_opened，累计值，只增不减。
		表示历史上反复打开 table 的总次数
		
	open_tables    : 
		The number of tables that are open. 
		表示当前正被打开的 table 数量

	Opened_tables  : 
		https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html#statvar_Opened_tables
		The number of tables that have been opened. If Opened_tables is big, your table_open_cache value is probably too small.
		表示历史上反复打开的所有表数量，如果 Opened_tables 值特别高，表明 table cache 很可能不够用所致。
		
	Open_table_definitions：
		当前缓存的 .frm 文件的数量。
		
	Opened_table_definitions : 
		https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html#statvar_Opened_table_definitions
		The number of .frm files that have been cached.	
		历史上已缓存的 .frm 文件数。
		
	Table_open_cache_hits
		https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html#statvar_Table_open_cache_hits
		打开表缓存查找的命中数。	
	
	Table_open_cache_misses
		https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html#statvar_Table_open_cache_misses
		打开表缓存查找的未命中数。
			
			
	Table_open_cache_overflows
		https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html#statvar_Table_open_cache_overflows
		
		打开表缓存的溢出次数。
		
		table_open_cache 溢出, 会有相关的状态量来显示 (table_open_cache_overflows)。
		
		
	统计文件总数的时候，应该考虑 Innodb_num_open_files+Open_files，这个总数如果接近进程能够打开的最大文件数(open_files_limit)的话则可能出现报错。
	




4. 如何判断 table_open_cache 大小是否够用
	
	可根据MySQL的3个状态值来分析
		
		Opened_tables  : 
			The number of tables that have been opened. If Opened_tables is big, your table_open_cache value is probably too small.
			表示历史上打开的所有表数量
			如果 Opened_tables 值特别高，表明 table cache 很可能不够用所致。
			
		open_tables    : 
			The number of tables that are open. 
			表示当前正被打开的 table 数量
			
		通过以上两个值来判断 table_open_cache 是否到达瓶颈：
			当缓存中的值 open_tables 临近到了 table_open_cache 值的时候，说明表缓存池快要满了; 但 Opened_tables 还在一直有新的增长 这说明你还有很多未被缓存的表
			这时可以适当增加 table_open_cache 的大小
			-- 这个总结不错。
		
		同时 查看 Table_open_cache_misses 打开表缓存查找的未命中数，是否在持续增加。
		


	
5. table_open_cache参数设置太大和太小的影响


	太小:
		因为table cache不够了，导致要频繁打开、关闭table，导致SQL语句返回慢, 导致table id急剧增长，因而导致主从数据复制失败。
	
	太大：
		不是越大越好 table_open_cache 过大占用大量文件描述符资源而不释放, 用尽了系统文件描述符资源导致无法接入新的连接
		增大该值将增加mysqld所需的文件描述符的数量 。


	
6. 相关参考

	https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache
	
	https://www.jianshu.com/p/8483b321bd65    MySQL 优化之 table_open_cache
	
	https://mp.weixin.qq.com/s/8Ue3m1V315-6mt-8jRRnyw  FAQ系列 | table id问题导致主从复制失败
	
	https://www.jianshu.com/p/c2fccdb4c08e   table_open_cache
	
	https://mp.weixin.qq.com/s/QfTY16wp99X7l4TcjakYYQ	第12问：Table cache 有什么作用？
	
	https://mp.weixin.qq.com/s/2fSW7F8wn-Bt3nd56kFyRw	[缺陷分析] Table cache 导致 MySQL 崩溃
	
	https://mp.weixin.qq.com/s/p1CkgV_Nve63GKGmQ58vWg  	[MySQL FAQ]系列 — 怎么计算打开文件数
	
	https://mp.weixin.qq.com/s/gDLNqwH29FyCsdjBZv6EFA	第47问：Table definition cache 有什么作用
	
	
	https://mp.weixin.qq.com/s/3DuhWoxX9oAlb523beKzxg	设置多大的table_open_cache才合适？
	
	http://blog.itpub.net/7728585/viewspace-2678001/	MySQL：Table_open_cache_hits/Table_open_cache_misses/Table_open_cache_overflows
	
	https://www.cnblogs.com/zengkefu/p/5651338.html		https://www.cnblogs.com/xpchild/p/3780625.html  open_table与opened_table
	
	https://mp.weixin.qq.com/s/ZYBNvvPN-Q-oy3jOtCvFpQ	MySQL:innodb_open_files参数及其周边	
	
	https://mp.weixin.qq.com/s/aqjXPFdD0orPtnZwk8OulQ	MySQL：5.7.11 超过最大打开文件数crash原因和参数open_files_limit
	
	
	https://www.jianshu.com/p/98a43397ea23			MySQL：open_files_limit中的坑

	
	https://www.jianshu.com/p/926169bbd544			MySQL打开文件限制
	
	https://cloud.tencent.com/developer/article/1658045		mysql table_open_cache 到底影响有多深
	
	
	
	
7. 别人面试问到 table_open_cache 参数怎么优化
	
	思路：
	
		查看打开表的状态值
		查看 open_tables 状态的值是否接近于 table_open_cache，同时 opened_tables 状态的值是否在持续增加。
		查看 Table_open_cache_misses 打开表缓存查找的未命中数，是否在持续增加。
	
	
------------------------------------------------------------------------------------------------------------------------------------------------------------

8. 生产环境的参数和状态值
	show global variables like '%open%';
	show global variables like '%table_definition_cache%';
	show global status like '%open%';

	具有分表场景的主库
		mysql> show global variables like '%open%';
		+----------------------------+-------+
		| Variable_name              | Value |
		+----------------------------+-------+
		| have_openssl               | YES   |
		| innodb_open_files          | 995   |
		| open_files_limit           | 5000  |
		| table_open_cache           | 995   |
		| table_open_cache_instances | 16    |
		+----------------------------+-------+
		5 rows in set (0.00 sec)

		mysql> show global variables like '%table_definition_cache%';
		+------------------------+-------+
		| Variable_name          | Value |
		+------------------------+-------+
		| table_definition_cache | 897   |
		+------------------------+-------+
		1 row in set (0.00 sec)

		mysql> show global status like '%open%';
		+----------------------------+------------+
		| Variable_name              | Value      |
		+----------------------------+------------+
		| Com_ha_open                | 0          |
		| Com_show_open_tables       | 0          |
		| Innodb_num_open_files      | 905        |
		| Open_files                 | 40         |
		| Open_streams               | 0          |
		| Open_table_definitions     | 897        |
		| Open_tables                | 992        |
		| Opened_files               | 2536903    |
		| Opened_table_definitions   | 1183624    |
		| Opened_tables              | 1152862    |
		| Slave_open_temp_tables     | 0          |
		| Table_open_cache_hits      | 2275679755 |
		| Table_open_cache_misses    | 576516     |
		| Table_open_cache_overflows | 567281     |
		+----------------------------+------------+
		14 rows in set (0.00 sec)


	具有分表场景的从库
		-- 从库有业务读取
		mysql> show global variables like '%open%';
		+----------------------------+-------+
		| Variable_name              | Value |
		+----------------------------+-------+
		| have_openssl               | YES   |
		| innodb_open_files          | 995   |
		| open_files_limit           | 5000  |
		| table_open_cache           | 995   |
		| table_open_cache_instances | 16    |
		+----------------------------+-------+
		5 rows in set (0.00 sec)

		mysql> show global variables like '%table_definition_cache%';
		+------------------------+-------+
		| Variable_name          | Value |
		+------------------------+-------+
		| table_definition_cache | 897   |
		+------------------------+-------+
		1 row in set (0.00 sec)

		mysql> show global status like '%open%';
		+----------------------------+------------+
		| Variable_name              | Value      |
		+----------------------------+------------+
		| Com_ha_open                | 0          |
		| Com_show_open_tables       | 0          |
		| Innodb_num_open_files      | 995        |
		| Open_files                 | 38         |
		| Open_streams               | 0          |
		| Open_table_definitions     | 897        |
		| Open_tables                | 603        |
		| Opened_files               | 5050798    |
		| Opened_table_definitions   | 2497766    |
		| Opened_tables              | 3811089    |
		| Slave_open_temp_tables     | 0          |
		| Table_open_cache_hits      | 2264943755 |
		| Table_open_cache_misses    | 3140819    |
		| Table_open_cache_overflows | 2373212    |
		+----------------------------+------------+
		14 rows in set (0.00 sec)


	没有分表的主库
		mysql> show global variables like '%open%';
		+----------------------------+----------+
		| Variable_name              | Value    |
		+----------------------------+----------+
		| have_openssl               | DISABLED |
		| innodb_open_files          | 2048     |
		| open_files_limit           | 15000    |
		| table_open_cache           | 2048     |
		| table_open_cache_instances | 1        |
		+----------------------------+----------+
		5 rows in set (0.00 sec)

		mysql> show global variables like '%table_definition_cache%';
		+------------------------+-------+
		| Variable_name          | Value |
		+------------------------+-------+
		| table_definition_cache | 1424  |
		+------------------------+-------+
		1 row in set (0.00 sec)

		mysql> show global status like '%open%';
		+----------------------------+-----------+
		| Variable_name              | Value     |
		+----------------------------+-----------+
		| Com_ha_open                | 0         |
		| Com_show_open_tables       | 0         |
		| Innodb_num_open_files      | 153       |
		| Open_files                 | 34        |
		| Open_streams               | 0         |
		| Open_table_definitions     | 177       |
		| Open_tables                | 276       |
		| Opened_files               | 1942629   |
		| Opened_table_definitions   | 392271    |
		| Opened_tables              | 196331    |
		| Slave_open_temp_tables     | 0         |
		| Table_open_cache_hits      | 149183794 |
		| Table_open_cache_misses    | 285       |
		| Table_open_cache_overflows | 0         |
		+----------------------------+-----------+
		14 rows in set (0.00 sec)



9. open_files_limit 参数

	含义：	
		mysql 进程能打开的文件数量。
				
		[root@soft ~]# ps aux|grep mysql
		root      1704  0.0  0.0 108432  1780 ?        S    Nov01   0:00 /bin/sh /usr/local/mysql/bin/mysqld_safe --datadir=/mydata/mysql/mysql3306/data --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid
		mysql     3194  1.9 43.8 5015152 2639000 ?     Sl   Nov01 105:01 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data 
		--plugin-dir=/usr/local/mysql/lib/plugin 
		--user=mysql --log-error=error.log 
		--open-files-limit=65535 
		--pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid 
		--socket=/mydata/mysql/mysql3306/data/mysql3306.sock --port=3306
		root     14861  0.0  0.0   6564   860 pts/0    S+   11:20   0:00 grep --color=auto mysql


		mysql> show global variables like '%open_files_limit%';
		+------------------+-------+
		| Variable_name    | Value |
		+------------------+-------+
		| open_files_limit | 65535 |
		+------------------+-------+
		1 row in set (0.00 sec)



	5.7中 open_files_limit 设置规则

		参数的设置规则来自4个方面：

			1. 10 + max_connections + (table_open_cache * 2)
			2. max_connections * 5
			3. 操作系统设置的open files
			4. 参数 open_files_limit 的设置，open_files_limit的默认值为5000
			
			对于如上4个值会取其中的最大值

			作者：重庆八怪
			链接：https://www.jianshu.com/p/98a43397ea23
			

	如果参数文件设置了open_files_limit，那么使用 mysqld_safe 启动的时候将会使用 open_files_limit 设置的值，这一点在5.7版本是要注意的。总结一下：

		1. 如果使用mysqld直接启动数据库那么将遵守官方文档规则。
		2. 如果使用mysqld_safe拉取mysqld，如果参数文件设置了 open_files_limit 那么 mysqld_safe 会获取 open_files_limit 的设置并且使用 ulimit -n 进行修改，然后拉起mysqld，不依赖OS的设置，官方文档规则去掉第三条。
		3. 如果使用mysqld_safe拉取mysqld，如果参数文件没有设置 open_files_limit 则遵守官方文档规则。

		作者：重庆八怪
		链接：https://www.jianshu.com/p/98a43397ea23



	ulimit -aS:查看当前软限制

		[root@soft ~]# ulimit -aS
		core file size          (blocks, -c) 0
		data seg size           (kbytes, -d) unlimited
		scheduling priority             (-e) 0
		file size               (blocks, -f) unlimited
		pending signals                 (-i) 22885
		max locked memory       (kbytes, -l) 64
		max memory size         (kbytes, -m) unlimited
		open files                      (-n) 40000
		pipe size            (512 bytes, -p) 8
		POSIX message queues     (bytes, -q) 819200
		real-time priority              (-r) 0
		stack size              (kbytes, -s) 10240
		cpu time               (seconds, -t) unlimited
		max user processes              (-u) 22885
		virtual memory          (kbytes, -v) unlimited
		file locks                      (-x) unlimited

	ulimit -aH:查看当前硬限制

		[root@soft ~]#  ulimit -aH
		core file size          (blocks, -c) unlimited
		data seg size           (kbytes, -d) unlimited
		scheduling priority             (-e) 0
		file size               (blocks, -f) unlimited
		pending signals                 (-i) 22885
		max locked memory       (kbytes, -l) 64
		max memory size         (kbytes, -m) unlimited
		open files                      (-n) 40000
		pipe size            (512 bytes, -p) 8
		POSIX message queues     (bytes, -q) 819200
		real-time priority              (-r) 0
		stack size              (kbytes, -s) unlimited
		cpu time               (seconds, -t) unlimited
		max user processes              (-u) 22885
		virtual memory          (kbytes, -v) unlimited
		file locks                      (-x) unlimited




	2020-10-16T22:36:41.736524-05:00 2 [ERROR] InnoDB: Operating system error number 24 in a file operation.
	2020-10-16T22:36:41.736527-05:00 2 [ERROR] InnoDB: Error number 24 means 'Too many open files'
	2020-10-16T22:36:41.736529-05:00 2 [Note] InnoDB: Some operating system error numbers are described at http://dev.mysql.com/doc/refman/5.7/en/operating-system-error-codes.html
	2020-10-16T22:36:41.736531-05:00 2 [Warning] InnoDB: Cannot open './test/testpar1#P#p20190528.ibd'. Have you deleted .ibd files under a running mysqld server?
	2020-10-16T22:36:41.736534-05:00 2 [ERROR] InnoDB: Trying to do I/O to a tablespace which exists without .ibd data file. I/O type: read, page: [page id: space=74, page number=3], I/O length: 16384 bytes
	2020-10-16T22:36:41.736537-05:00 2 [ERROR] InnoDB: trying to read page [page id: space=74, page number=3] in nonexisting or being-dropped tablespace
	2020-10-16T22:36:41.736541-05:00 2 [ERROR] [FATAL] InnoDB: Unable to read page [page id: space=74, page number=3] into the buffer pool after 100 attempts. The most probable cause of this error may be that the table has been corrupted. Or, the table was compressed with with an algorithm that is not supported by this instance. If it is not a decompress failure, you can try to fix this problem by using innodb_force_recovery. Please see http://dev.mysql.com/doc/refman/5.7/en/ for more details. Aborting...
	2020-10-16 22:36:41 0x7f8b751ab700  InnoDB: Assertion failure in thread 140236941866752 in file ut0ut.cc line 920
	InnoDB: We intentionally generate a memory trap.
	InnoDB: Submit a detailed bug report to http://bugs.mysql.com.
	InnoDB: If you get repeated assertion failures or crashes, even
	InnoDB: immediately after the mysqld startup, there may be
	InnoDB: corruption in the InnoDB tablespace. Please refer to
	InnoDB: http://dev.mysql.com/doc/refman/5.7/en/forcing-innodb-recovery.html
	InnoDB: about forcing recovery.
	02:36:41 UTC - mysqld got signal 6 ;
	This could be because you hit a bug. It is also possible that this binary
	or one of the libraries it was linked against is corrupt, improperly built,
	or misconfigured. This error can also be caused by malfunctioning hardware.
	Attempting to collect some information that could help diagnose the problem.
	As this is a crash and something is definitely wrong, the information
	collection process might fail.

	key_buffer_size=2147483648
	read_buffer_size=131072
	max_used_connections=1
	max_threads=20
	thread_count=1
	connection_count=1
	It is possible that mysqld could use up to 
	key_buffer_size + (read_buffer_size + sort_buffer_size)*max_threads = 2120458 K  bytes of memory
	Hope that's ok; if not, decrease some variables in the equation.

	Thread pointer: 0x7f8b38000ae0
	Attempting backtrace. You can use the following information to find out
	where mysqld died. If you see no messages after this, something went
	terribly wrong...
	stack_bottom = 7f8b751aaea8 thread_stack 0x40000
	/opt/mysql/mysql3320/bin/mysqld(my_print_stacktrace+0x35)[0xf45595]
	/opt/mysql/mysql3320/bin/mysqld(handle_fatal_signal+0x4a4)[0x77fd34]
	/lib64/libpthread.so.0(+0xf630)[0x7f8c7bbea630]
	/lib64/libc.so.6(gsignal+0x37)[0x7f8c7a76a387]
	/lib64/libc.so.6(abort+0x148)[0x7f8c7a76ba78]
	/opt/mysql/mysql3320/bin/mysqld[0x10dd465]
	/opt/mysql/mysql3320/bin/mysqld(_ZN2ib5fatalD1Ev+0xb3)[0x10e2b33]
	/opt/mysql/mysql3320/bin/mysqld(_Z16buf_page_get_genRK9page_id_tRK11page_size_tmP11buf_block_tmPKcmP5mtr_tb+0xf56)[0x11267c6]
	/opt/mysql/mysql3320/bin/mysqld(_Z31btr_cur_open_at_index_side_funcbP12dict_index_tmP9btr_cur_tmPKcmP5mtr_t+0x3a5)[0x1103405]
	/opt/mysql/mysql3320/bin/mysqld[0x1062d7b]
	/opt/mysql/mysql3320/bin/mysqld(_Z15row_search_mvccPh15page_cur_mode_tP14row_prebuilt_tmm+0x1f62)[0x106d4f2]
	/opt/mysql/mysql3320/bin/mysqld(_ZN11ha_innobase10index_readEPhPKhj16ha_rkey_function+0x247)[0xf7c687]
	/opt/mysql/mysql3320/bin/mysqld(_ZN11ha_innobase11index_firstEPh+0x39)[0xf6ccf9]
	/opt/mysql/mysql3320/bin/mysqld(_ZN11ha_innopart19index_first_in_partEjPh+0x2d)[0xf8fa7d]
	/opt/mysql/mysql3320/bin/mysqld(_ZN16Partition_helper36handle_unordered_scan_next_partitionEPh+0x182)[0xc6d6e2]
	/opt/mysql/mysql3320/bin/mysqld(_ZN7handler14ha_index_firstEPh+0x127)[0x7c8787]
	/opt/mysql/mysql3320/bin/mysqld(_Z15join_read_firstP7QEP_TAB+0x6f)[0xce6ddf]
	/opt/mysql/mysql3320/bin/mysqld(_Z10sub_selectP4JOINP7QEP_TABb+0x2ba)[0xce7cca]
	/opt/mysql/mysql3320/bin/mysqld(_ZN4JOIN4execEv+0x28a)[0xce622a]
	/opt/mysql/mysql3320/bin/mysqld(_Z12handle_queryP3THDP3LEXP12Query_resultyy+0x250)[0xd51d00]
	/opt/mysql/mysql3320/bin/mysqld[0xd12973]
	/opt/mysql/mysql3320/bin/mysqld(_Z21mysql_execute_commandP3THDb+0x3325)[0xd16605]
	/opt/mysql/mysql3320/bin/mysqld(_Z11mysql_parseP3THDP12Parser_state+0x3ad)[0xd1851d]
	/opt/mysql/mysql3320/bin/mysqld(_Z16dispatch_commandP3THDPK8COM_DATA19enum_server_command+0x117d)[0xd196fd]
	/opt/mysql/mysql3320/bin/mysqld(_Z10do_commandP3THD+0x194)[0xd1a1f4]
	/opt/mysql/mysql3320/bin/mysqld(handle_connection+0x29c)[0xde605c]
	/opt/mysql/mysql3320/bin/mysqld(pfs_spawn_thread+0x174)[0x1213184]
	/lib64/libpthread.so.0(+0x7ea5)[0x7f8c7bbe2ea5]
	/lib64/libc.so.6(clone+0x6d)[0x7f8c7a8328dd]