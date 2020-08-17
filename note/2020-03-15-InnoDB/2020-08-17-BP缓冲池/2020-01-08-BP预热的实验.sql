
sysbench : 先插入数据, 再创建索引; 如果单个表有多列索引的情况下, 这样操作效率确实会提高不少.
	Creating table 'sbtest9'...
	Inserting 1500000 records into 'sbtest9'
	Creating secondary indexes on 'sbtest9'...

0. 背景
1. 预热基础知识
2. 预热的作用
3. 不导出导入热点数据的数据库重启
4. 手动执行导出ib_buffer_pool
5. 手动执行导入ib_buffer_pool
6. 自动执行导出ib_buffer_pool
7. 自动执行导入ib_buffer_pool
8. dump过程和load过程
9. 预热应用场景
10. 总结


0. 背景
	sysbench造数20个150W行记录的表，占用磁盘空间7G

	服务器配置 
	虚拟机
	内存：8G 
	数据库版本：5.7.24

	数据库参数：innodb_buffer_pool_size=6G

	测试目的：测试在 innodb_buffer_pool_size 设置的buffer poo size占满时，导出导入ib_buffer_pool文件需要多长时间
	

1. 预热基础知识:

	如果一台高负荷的机器重启后，buffer pool中的热数据被丢失，此时就需要重新从磁盘加载到Buffer_Pool缓冲池里，这样当高峰期间，性能就会变得很差，连接数就会很高，应用的性能也受到影响。               
	MySQL5.6里，一个新特性避免这种问题的出现，在配置文件里添加：

	innodb_buffer_pool_dump_at_shutdown = 1   # 在关闭时把热数据dump到本地磁盘    #5.7.7默认开启
	innodb_buffer_pool_load_at_startup = 1    # 在启动时把热数据从磁盘加载到内存   #5.7.7默认开启
	innodb_buffer_pool_dump_now = 1           # 采用手工方式把热数据dump到本地磁盘
	innodb_buffer_pool_load_now = 1           # 采用手工方式把热数据加载到内存
	innodb_buffer_pool_dump_pct               # 
			表示控制 dump buffer pool 的百分比，5.7中支持。5.6默认dump所有的Buffer pool。
			指定每个缓冲池要读取和转储的最近使用页面的百分比。 范围是1到100。默认值是25。
			innodb_buffer_pool_dump_pct = 100:  当触发转储的时候 会全量dump innodb buffer pool中的pages。
			例如，如果有4个缓冲池，每个缓冲池有100个页面，并且innodb_buffer_pool_dump_pct设置为25，则将转储每个缓冲池中最近使用的25个页面。

	掌握这5个参数 含义和运用..
	
2. 预热的作用:
			
	引入看BP的自动预热解决了数据库维护重启的时候导致性能变差的问题。
	实际上遇到过在 MySQL 5.7 中, 数据库进行正常的关闭/启动后, innodb_buffer_pool_dump_pct = 25 的场景下, 在 ib_buffer_pool loading 完成之后 ,
		BP缓冲池的查询命中率会下降到 95%.
		


3. 不导出导入热点数据的数据库重启:
	
	sysbench 10 线程oltp持续加压
	
	set global sync_binlog=100000;
	set global innodb_flush_log_at_trx_commit=2;
	
	create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

	./sysbench --mysql-host=192.168.0.54 --mysql-port=3306 --mysql-user=root --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=20 --oltp-table-size=1500000 --rand-init=on prepare

./sysbench --mysql-host=192.168.0.54 --mysql-port=3306 --mysql-user=root \
--mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=20 \
--oltp-table-size=1500000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=3600 \
 --max-requests=0 --percentile=99 run >> /data/sysbench_oltpX_12_2020-01-10-10.log
			
	
	为了对比后续有热点数据和没有热点数据导入导出的差别，先执行一次不导出导入热点数据的数据库重启，
	并记录关闭和启动mysqld的时间，先在innodb_buffer_pool_dump_at_shutdown=off的情况下，关闭MySQL，看看关闭时间需要多久。
	
		
	mysql> show global variables like  '%innodb_buffer_pool%';
	+-------------------------------------+----------------+
	| Variable_name                       | Value          |
	+-------------------------------------+----------------+
	| innodb_buffer_pool_chunk_size       | 134217728      |
	| innodb_buffer_pool_dump_at_shutdown | OFF            |
	| innodb_buffer_pool_dump_now         | OFF            |
	| innodb_buffer_pool_dump_pct         | 100            |
	| innodb_buffer_pool_filename         | ib_buffer_pool |
	| innodb_buffer_pool_instances        | 4              |
	| innodb_buffer_pool_load_abort       | OFF            |
	| innodb_buffer_pool_load_at_startup  | OFF            |
	| innodb_buffer_pool_load_now         | OFF            |
	| innodb_buffer_pool_size             | 6442450944     |
	+-------------------------------------+----------------+
	10 rows in set (0.01 sec)
	
	
	mysql> show global status like  '%innodb_buffer_pool_page%';
	+----------------------------------+--------+
	| Variable_name                    | Value  |
	+----------------------------------+--------+
	| Innodb_buffer_pool_pages_data    | 376804 |
	| Innodb_buffer_pool_pages_dirty   | 46801  |
	| Innodb_buffer_pool_pages_flushed | 453151 |
	| Innodb_buffer_pool_pages_free    | 15864  |
	| Innodb_buffer_pool_pages_misc    | 500    |
	| Innodb_buffer_pool_pages_total   | 393168 |
	+----------------------------------+--------+
	6 rows in set (0.00 sec)



	# 执行关闭mysqld，并记录time命令打印的执行时间

	
	shell> time mysqladmin --defaults-file=/etc/my.cnf -uroot -p'123456abc' -h192.168.0.54 -P3306 shutdown
	mysqladmin: [Warning] Using a password on the command line interface can be insecure.

	real	0m0.008s
	user	0m0.001s
	sys	0m0.001s

	cat error.log
		
		2020-01-09T23:53:52.524447+08:00 0 [Note] InnoDB: FTS optimize thread exiting.
		2020-01-09T23:53:52.524561+08:00 0 [Note] InnoDB: Starting shutdown...
		2020-01-09T23:54:53.057677+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
	
	脏页大小:
		select 46801 * 16/1024/1024 = 0.7GB
	
	cat error.log
		2020-01-09T23:54:53.057677+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
		2020-01-09T23:55:53.266162+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
		2020-01-09T23:56:53.485895+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
		2020-01-09T23:57:53.715406+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
		
	cat error.log
		2020-01-09T23:53:52.524447+08:00 0 [Note] InnoDB: FTS optimize thread exiting.
		2020-01-09T23:53:52.524561+08:00 0 [Note] InnoDB: Starting shutdown...
		2020-01-09T23:54:53.057677+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
		2020-01-09T23:55:53.266162+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
		2020-01-09T23:56:53.485895+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
		2020-01-09T23:57:53.715406+08:00 0 [Note] InnoDB: Waiting for page_cleaner to finish flushing of buffer pool
		2020-01-09T23:58:04.299659+08:00 0 [Note] InnoDB: Shutdown completed; log sequence number 71890985353
		2020-01-09T23:58:04.299737+08:00 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
		2020-01-09T23:58:04.299747+08:00 0 [Note] Shutting down plugin 'sha256_password'
		2020-01-09T23:58:04.299750+08:00 0 [Note] Shutting down plugin 'mysql_native_password'
		2020-01-09T23:58:04.299859+08:00 0 [Note] Shutting down plugin 'binlog'
		2020-01-09T23:58:04.314817+08:00 0 [Note] /usr/local/mysql/bin/mysqld: Shutdown complete
		
	验证了 当大量的脏页没有及时刷盘, 重启数据库会很耗时.
	

	shell> iostat -dmx 1
		Linux 3.10.0-693.el7.x86_64 (mgr9) 	01/09/2020 	_x86_64_	(1 CPU)

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     7.76   13.97   38.64     0.25     2.51   107.32     0.77   14.73    4.87   18.29   1.25   6.56
		dm-0              0.00     0.00    0.22    0.17     0.01     0.00    63.10     0.02   40.49   18.98   67.52   3.38   0.13
		dm-1              0.00     0.00    0.00    0.00     0.00     0.00    47.40     0.00    7.13    7.13    0.00   3.82   0.00
		dm-2              0.00     0.00   13.74   43.55     0.24     2.51    98.11     1.13   19.71    4.66   24.46   1.14   6.50


		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    2.02  296.97     0.02     7.59    52.14     1.04    3.49   11.00    3.44   3.36 100.51
		dm-0              0.00     0.00    2.02    0.00     0.02     0.00    24.00     0.02   11.00   11.00    0.00  11.00   2.22
		dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-2              0.00     0.00    0.00  292.93     0.00     7.59    53.06     1.02    3.48    0.00    3.48   3.43 100.51

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    0.00  291.00     0.00     7.51    52.84     1.01    3.49    0.00    3.49   3.42  99.60
		dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-2              0.00     0.00    0.00  288.00     0.00     7.51    53.43     1.01    3.53    0.00    3.53   3.46  99.60
		
		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    0.00  295.96     0.00     7.59    52.52     1.04    2.63    0.00    2.63   3.39 100.30
		dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-2              0.00     0.00    0.00  291.92     0.00     7.59    53.24     1.04    2.67    0.00    2.67   3.44 100.30

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    0.00  294.95     0.00     7.59    52.69     1.03    3.63    0.00    3.63   3.39 100.10
		dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		dm-2              0.00     0.00    0.00  290.91     0.00     7.59    53.43     1.03    3.69    0.00    3.69   3.44 100.10
	
	
	执行启动mysqld，启动mysqld之前，先在my.cnf中配置参数innodb_buffer_pool_load_at_startup=OFF，再启动，看看需要多长时间，
	由于是挂后台，无法使用time命令查看，可以通过错误日志中的输出来大致判断启动时间需要多长
	
	innodb_buffer_pool_load_at_startup=OFF
	
	/usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf &    
	
	
	cat error.log
		2020-01-10T00:01:34.461693+08:00 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.22-log) starting as process 4492 ...
		
		...............................................................................................
		
		2020-01-10T00:01:38.061804+08:00 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
		Version: '5.7.22-log'  socket: '/tmp/mysql3306.sock'  port: 3306  MySQL Community Server (GPL)

		
	# 这里需要重新做实验
	从以上错误日志的输出信息中可以看到:
		
		Starting mysqld 到打印socket地址时间的日志时间判断，在没有加载ib_buffer_pool时的启动耗时约 3 秒.
	
		
4. 手动执行导出ib_buffer_pool
	
	sysbench 10 线程oltp持续加压
		
		set global sync_binlog=100000;
		set global innodb_flush_log_at_trx_commit=2;
		
		create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

		./sysbench --mysql-host=192.168.0.54 --mysql-port=3306 --mysql-user=root --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=20 --oltp-table-size=1500000 --rand-init=on prepare

./sysbench --mysql-host=192.168.0.54 --mysql-port=3306 --mysql-user=root \
--mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=20 \
--oltp-table-size=1500000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=3600 \
 --max-requests=0 --percentile=99 run >> /data/sysbench_oltpX_12_2020-01-09-1.log
		
	

	root@mysqldb 09:35:  [(none)]> show global variables like  '%innodb_buffer_pool%';
	+-------------------------------------+----------------+
	| Variable_name                       | Value          |
	+-------------------------------------+----------------+
	| innodb_buffer_pool_chunk_size       | 134217728      |
	| innodb_buffer_pool_dump_at_shutdown | OFF            |
	| innodb_buffer_pool_dump_now         | OFF            |
	| innodb_buffer_pool_dump_pct         | 100            |
	| innodb_buffer_pool_filename         | ib_buffer_pool |
	| innodb_buffer_pool_instances        | 4              |
	| innodb_buffer_pool_load_abort       | OFF            |
	| innodb_buffer_pool_load_at_startup  | OFF            |
	| innodb_buffer_pool_load_now         | OFF            |
	| innodb_buffer_pool_size             | 6442450944     |
	+-------------------------------------+----------------+
	10 rows in set (0.11 sec)


	root@mysqldb 09:33:  [(none)]>  show global status like  '%innodb_buffer_pool_page%';
	+----------------------------------+--------+
	| Variable_name                    | Value  |
	+----------------------------------+--------+
	| Innodb_buffer_pool_pages_data    | 377138 |
	| Innodb_buffer_pool_pages_dirty   | 15070  |
	| Innodb_buffer_pool_pages_flushed | 442936 |
	| Innodb_buffer_pool_pages_free    | 15984  |
	| Innodb_buffer_pool_pages_misc    | 46     |
	| Innodb_buffer_pool_pages_total   | 393168 |
	+----------------------------------+--------+
	6 rows in set (0.00 sec)



	# 设置innodb_buffer_pool_dump_now=on，表示立即导出热点数据页到ib_buffer_pool文件中

	root@mysqldb 09:35:  [(none)]> set global innodb_buffer_pool_dump_now=on;
	Query OK, 0 rows affected (0.03 sec)
	
	root@mysqldb 09:34:  [(none)]> show status like 'Innodb_buffer_pool_dump_status';
	+--------------------------------+--------------------------------------------------+
	| Variable_name                  | Value                                            |
	+--------------------------------+--------------------------------------------------+
	| Innodb_buffer_pool_dump_status | Buffer pool(s) dump completed at 200109  9:35:43 |
	+--------------------------------+--------------------------------------------------+
	1 row in set (0.10 sec)

	
	
	现在，查看ib_buffer_pool文件。
	
		[root@mgr9 data]# ls -lht ib_buffer_pool 
		-rw-r----- 1 mysql mysql 3.8M Jan  9 09:35 ib_buffer_pool
		
		
		[root@mgr9 data]# stat ib_buffer_pool 

		  File: ‘ib_buffer_pool’
		  Size: 3955036   	Blocks: 7728       IO Block: 4096   regular file
		Device: fd02h/64770d	Inode: 39531319    Links: 1
		Access: (0640/-rw-r-----)  Uid: ( 1001/   mysql)   Gid: ( 1001/   mysql)
		Access: 2020-01-09 09:35:43.574328839 +0800
		Modify: 2020-01-09 09:35:43.672328839 +0800
		Change: 2020-01-09 09:35:43.672328839 +0800
		 Birth: -
		 
	查错误日志:	 
		2020-01-09T09:35:43.575270+08:00 0 [Note] InnoDB: Dumping buffer pool(s) to /data/mysql/mysql3306/data/ib_buffer_pool
		2020-01-09T09:35:43.672689+08:00 0 [Note] InnoDB: Buffer pool(s) dump completed at 200109  9:35:43	
		
	
	计算前面几个步骤获取的时间：
		通过数据库中的show status like 'Innodb_buffer_pool_dump_status';查询结果，完成时间是9:35:43
		通过 stat 命令查询到这个文件最后修改时间是 09:35:43 ，时间一致，文件access时间与Modify时间相差不到1秒
		表示ib_buffer_pool文件在文件系统层不到1秒就完成了dump操作（从数据库层到文件系统层的写入），
		而对于数据库层，执行set global innodb_buffer_pool_dump_now=on;时是立即返回，说明该语句对于数据库语句执行来说，没有阻塞操作。
	
	

5. 手动执行导入ib_buffer_pool

	在shell命令行中启动MySQL（注意这里配置文件中配置参数innodb_buffer_pool_load_at_startup设置为OFF，让mysqld启动时并不自动加载ib_buffer_pool文件）
	
	root@mysqldb 09:42:  [(none)]> show global variables like  '%innodb_buffer_pool%';
	+-------------------------------------+----------------+
	| Variable_name                       | Value          |
	+-------------------------------------+----------------+
	| innodb_buffer_pool_chunk_size       | 134217728      |
	| innodb_buffer_pool_dump_at_shutdown | OFF            |
	| innodb_buffer_pool_dump_now         | OFF            |
	| innodb_buffer_pool_dump_pct         | 100            |
	| innodb_buffer_pool_filename         | ib_buffer_pool |
	| innodb_buffer_pool_instances        | 4              |
	| innodb_buffer_pool_load_abort       | OFF            |
	| innodb_buffer_pool_load_at_startup  | OFF            |
	| innodb_buffer_pool_load_now         | OFF            |
	| innodb_buffer_pool_size             | 6442450944     |
	+-------------------------------------+----------------+
	10 rows in set (0.00 sec)
	
	
	root@mysqldb 09:33:  [(none)]>  show global status like  '%innodb_buffer_pool_page%';
	+----------------------------------+--------+
	| Variable_name                    | Value  |
	+----------------------------------+--------+
	| Innodb_buffer_pool_pages_data    | 377138 |
	| Innodb_buffer_pool_pages_dirty   | 15070  |
	| Innodb_buffer_pool_pages_flushed | 442936 |
	| Innodb_buffer_pool_pages_free    | 15984  |
	| Innodb_buffer_pool_pages_misc    | 46     |
	| Innodb_buffer_pool_pages_total   | 393168 |
	+----------------------------------+--------+
	6 rows in set (0.00 sec)


	重启数据库:
		[root@mgr9 sysbench]# /etc/init.d/mysql restart
		Shutting down MySQL..... SUCCESS! 
		Starting MySQL.... SUCCESS
		
		

		mysql> set global innodb_buffer_pool_load_now = 1;
		
		查看错误日志:
		
			2020-01-09T09:46:49.022199+08:00 0 [Note] InnoDB: Loading buffer pool(s) from /data/mysql/mysql3306/data/ib_buffer_pool’
		
		
		[root@mgr9 data]# stat ib_buffer_pool 
		  File: ‘ib_buffer_pool’
		  Size: 3955036   	Blocks: 7728       IO Block: 4096   regular file
		Device: fd02h/64770d	Inode: 39531319    Links: 1
		Access: (0640/-rw-r-----)  Uid: ( 1001/   mysql)   Gid: ( 1001/   mysql)
		Access: 2020-01-09 09:46:49.021328839 +0800
		Modify: 2020-01-09 09:35:43.672328839 +0800
		Change: 2020-01-09 09:35:43.672328839 +0800
		 Birth: -
		 
		 
		状态信息:
		mysql>  show global status like  '%innodb_buffer_pool_page%';
		+----------------------------------+--------+
		| Variable_name                    | Value  |
		+----------------------------------+--------+
		| Innodb_buffer_pool_pages_data    | 377161 |
		| Innodb_buffer_pool_pages_dirty   | 0      |
		| Innodb_buffer_pool_pages_flushed | 60     |
		| Innodb_buffer_pool_pages_free    | 16007  |
		| Innodb_buffer_pool_pages_misc    | 0      |
		| Innodb_buffer_pool_pages_total   | 393168 |
		+----------------------------------+--------+
		6 rows in set (0.00 sec)
		
		
		root@mysqldb 09:46:  [(none)]> show engine innodb status\G;

			LRU len: 377161, unzip_LRU len: 0
			

6. 自动执行导出ib_buffer_pool

		sysbench 10 线程oltp持续加压
		
		set global sync_binlog=100000;
		set global innodb_flush_log_at_trx_commit=2;
		
		./sysbench --mysql-host=192.168.0.54 --mysql-port=3306 --mysql-user=root --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=20 --oltp-table-size=1500000 --rand-init=on prepare

./sysbench --mysql-host=192.168.0.54 --mysql-port=3306 --mysql-user=root \
--mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=20 \
--oltp-table-size=1500000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=3600 \
 --max-requests=0 --percentile=99 run >> /data/sysbench_oltpX_12_2020-01-09-17.log
		
		
		
	
		登录MySQL数据库中使用修改变量：
		
			set global  innodb_buffer_pool_dump_pct = 100;
			set global innodb_buffer_pool_dump_at_shutdown=on;  
					
			修改 innodb_buffer_pool_dump_at_shutdown=on之后，mysqld在关闭时会自动导出热点数据页到ib_buffer_pool文件中
			
			
			root@mysqldb 07:03:  [(none)]> show global variables like  '%innodb_buffer_pool%';
			+-------------------------------------+----------------+
			| Variable_name                       | Value          |
			+-------------------------------------+----------------+
			| innodb_buffer_pool_chunk_size       | 134217728      |
			| innodb_buffer_pool_dump_at_shutdown | ON             |
			| innodb_buffer_pool_dump_now         | OFF            |
			| innodb_buffer_pool_dump_pct         | 100            |
			| innodb_buffer_pool_filename         | ib_buffer_pool |
			| innodb_buffer_pool_instances        | 4              |
			| innodb_buffer_pool_load_abort       | OFF            |
			| innodb_buffer_pool_load_at_startup  | ON             |
			| innodb_buffer_pool_load_now         | OFF            |
			| innodb_buffer_pool_size             | 6442450944     |
			+-------------------------------------+----------------+
			10 rows in set (0.00 sec)

			
			
			root@mysqldb 08:36:  [(none)]>  show global status like  '%innodb_buffer_pool_page%';
			+----------------------------------+--------+
			| Variable_name                    | Value  |
			+----------------------------------+--------+
			| Innodb_buffer_pool_pages_data    | 386909 |
			| Innodb_buffer_pool_pages_dirty   | 30505  |
			| Innodb_buffer_pool_pages_flushed | 411005 |
			| Innodb_buffer_pool_pages_free    | 6284   |
			| Innodb_buffer_pool_pages_misc    | 23     |
			| Innodb_buffer_pool_pages_total   | 393216 |
			+----------------------------------+--------+
			6 rows in set (0.00 sec)


			
		
		在shell命令行中停止MySQL，留意停止时间需要多长。
		
			time mysqladmin --defaults-file=/etc/my.cnf -uroot -p'123456abc' -h192.168.0.54 -P3306 shutdown	
			
		查看错误日志，可以发现 Dump ib_buffer_pool 文件中的相关日志输出，开始时间到结束时间对比，耗时0.1S。
			
			2020-01-09T08:37:12.442255+08:00 0 [Note] InnoDB: Dumping buffer pool(s) to /data/mysql/mysql3306/data/ib_buffer_pool
			2020-01-09T08:37:12.530154+08:00 0 [Note] InnoDB: Buffer pool(s) dump completed at 200109  8:37:12

				
		使用stat命令查看ib_buffer_pool文件的创建，修改时间，这里也可以看到，access和modify时间相差不到1S，说明buffer pool在1S内完成了dump。
		
		[root@mgr9 data]# stat ib_buffer_pool 
		  File: ‘ib_buffer_pool’
		  Size: 3955691   	Blocks: 7728       IO Block: 4096   regular file
		Device: fd02h/64770d	Inode: 39531316    Links: 1
		Access: (0640/-rw-r-----)  Uid: ( 1001/   mysql)   Gid: ( 1001/   mysql)
		Access: 2020-01-09 08:37:12.441328839 +0800
		Modify: 2020-01-09 08:37:12.529328839 +0800
		Change: 2020-01-09 08:37:12.529328839 +0800
		 Birth: -

		 [root@mgr9 data]# ls -lht ib_buffer_pool 
		 -rw-r----- 1 mysql mysql 3.8M Jan  9 08:37 ib_buffer_pool
			
		[root@mgr9 data]# cat ib_buffer_pool |more
		4722,21938
		4706,20903
		4714,21413
		............................
		
			
7. 自动执行导入ib_buffer_pool
	
	/usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf & 
	
	查看错误日志: 
		2020-01-09T08:40:22.581928+08:00 0 [Warning] 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
		.............................................................................
		2020-01-09T08:40:24.445418+08:00 0 [Note] InnoDB: Loading buffer pool(s) from /data/mysql/mysql3306/data/ib_buffer_pool
		.............................................................................
	
		2020-01-09T08:40:27.570552+08:00 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
		Version: '5.7.22-log'  socket: '/tmp/mysql3306.sock'  port: 3306  MySQL Community Server (GPL)
		2020-01-09T08:41:44.849674+08:00 0 [Note] InnoDB: Buffer pool(s) load completed at 200109  8:41:44

		其中:
			2020-01-09T08:40:24.445418+08:00 0 [Note] InnoDB: Loading buffer pool(s) from /data/mysql/mysql3306/data/ib_buffer_pool	
			2020-01-09T08:41:44.849674+08:00 0 [Note] InnoDB: Buffer pool(s) load completed at 200109  8:41:44	
	
		root@mysqldb 08:45:  [(none)]> show status like '%Innodb_buffer_pool_load_status';
		+--------------------------------+--------------------------------------------------+
		| Variable_name                  | Value                                            |
		+--------------------------------+--------------------------------------------------+
		| Innodb_buffer_pool_load_status | Buffer pool(s) load completed at 200109  8:41:44 |
		+--------------------------------+--------------------------------------------------+
		1 row in set (0.00 sec)
	
		从上面的结果中可以看到，Load开始时间是 08:40:24，结束时间是08:41:44，耗时近1分20秒。
	
	查看 ib_buffer_pool	 的创建时间和修改时间:
	
		[root@mgr9 data]# stat ib_buffer_pool
		  File: ‘ib_buffer_pool’
		  Size: 3955691   	Blocks: 7728       IO Block: 4096   regular file
		Device: fd02h/64770d	Inode: 39531316    Links: 1
		Access: (0640/-rw-r-----)  Uid: ( 1001/   mysql)   Gid: ( 1001/   mysql)
		Access: 2020-01-09 08:39:44.852328839 +0800
		Modify: 2020-01-09 08:37:12.529328839 +0800
		Change: 2020-01-09 08:37:12.529328839 +0800
		 Birth: -
	
		
	

	查看此时的 磁盘利用率:
		iostat -dmx 1	
			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00 6180.56    0.00    96.57     0.00    32.00     1.18    0.19    0.19    0.00   0.19 118.33
			dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-2              0.00     0.00 6180.56    0.00    96.57     0.00    32.00     1.18    0.19    0.19    0.00   0.19 118.33

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00 4825.97    0.00    75.41     0.00    32.00     1.15    0.24    0.24    0.00   0.24 115.32
			dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-2              0.00     0.00 4827.27    0.00    75.43     0.00    32.00     1.15    0.24    0.24    0.00   0.24 115.32

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00 4374.03    0.00    68.38     0.00    32.02     1.16    0.26    0.26    0.00   0.26 115.84
			dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-2              0.00     0.00 4374.03    0.00    68.38     0.00    32.02     1.16    0.26    0.26    0.00   0.27 115.97

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00 6995.83    0.00   109.31     0.00    32.00     1.18    0.17    0.17    0.00   0.17 118.19
			dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-2              0.00     0.00 6995.83    0.00   109.31     0.00    32.00     1.18    0.17    0.17    0.00   0.17 118.47

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00 7391.30    0.00   115.49     0.00    32.00     1.25    0.17    0.17    0.00   0.17 124.78
			dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			dm-2              0.00     0.00 7389.86    0.00   115.47     0.00    32.00     1.25    0.17    0.17    0.00   0.17 124.78
	
	
8. dump过程和load过程：

	dump过程： 锁buf_pool 遍历LRU链表，将(space, pageno) 先收集到数组 释放锁 再将数据写入innodb_buffer_pool_filename定有的文件中

	load过程： 从文件读入数组 按（space,pageno)排序数据 依次同步读取页到buffer pool中
	
9. 预热应用场景：
	1. 如果用户修改buffer pool大小，同时涉及跨机迁移，那么buffer pool 预热功能就排上用场了
	2. 重启
	
10. 总结：
	
	从以上测试结果可以看到:
		没有加载ib_buffer_pool:
			关闭耗时: 
			启动耗时: 不到2秒
			
		ib_buffer_pool的Dump时间7G左右的数据量，3W8左右的数据页，需要不到0.5秒的时间，在Load的时候，耗时约1分20秒，
		但是在Load ib_buffer_pool文件的时候并不会阻塞对数据库的访问，
		
	所以理论上在MySQL的起停中开启ib_buffer_pool的自动Dump和Load对数据库前台的操作影响极小，建议在配置文件中设置如下参数以实现该功能。
	
		innodb_buffer_pool_dump_at_shutdown=ON
		innodb_buffer_pool_load_at_startup=ON
		innodb_fast_shutdown=1
		innodb_buffer_pool_dump_pct=80
	
	虽然在Load ib_buffer_pool文件时不会阻塞前台的操作，而是在后台执行，但是从测试结果中可以看到，Load操作会占用大量磁盘的读IO，所以对于MySQL的起停操作，需要避开业务高峰期进行。
	
	ib_buffer_pool的Dump时间160G左右的数据量，1000W左右的数据页，只需要几秒时间，在Load的时候，需要大约40分钟
	
	在没有加载ib_buffer_pool时的启动时间为20S


