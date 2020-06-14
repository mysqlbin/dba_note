

0. 初始化表结构和数据
1. 函数接口 buf_LRU_flush_or_remove_pages 
2. truncate
3. drop
4. drop具体的过程： http://mysql.taobao.org/monthly/2016/01/07/


0. 初始化表结构和数据
	
1. 函数接口 buf_LRU_flush_or_remove_pages 

	函数接口 buf_LRU_flush_or_remove_pages 用于确认是否维护 LRU list，其中有三种类型：


	/** Algorithm to remove the pages for a tablespace from the buffer pool.
		See buf_LRU_flush_or_remove_pages(). */
		enum buf_remove_t {
			BUF_REMOVE_ALL_NO_WRITE,    /*!< Remove all pages from the buffer
							pool, don't write or sync to disk */  
			BUF_REMOVE_FLUSH_NO_WRITE,  /*!< Remove only, from the flush list,
							don't write or sync to disk */
			BUF_REMOVE_FLUSH_WRITE      /*!< Flush dirty pages to disk only
							don't remove from the buffer pool */
		};

	drop为：     BUF_REMOVE_FLUSH_NO_WRITE ，需要维护flush list，不回写数据
	trunacte为： BUF_REMOVE_ALL_NO_WRITE ，需要维护flush list和lru list，不回写数据

	作者：重庆八怪
	链接：https://www.jianshu.com/p/a956a3e30eb6
	来源：简书
	著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

	CREATE TABLE `t` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`),
		  KEY `t_modified`(`t_modified`)
		) ENGINE=InnoDB; 
	insert into t values(5,1,'2018-11-13');

2. truncate 

	(gdb) b buf_LRU_flush_or_remove_pages
	Breakpoint 1 at 0x1b75804: file /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc, line 930.
	
	(gdb) bt
	#0  0x00007f17791f1bed in poll () at ../sysdeps/unix/syscall-template.S:81
	#1  0x00000000016626a1 in Mysqld_socket_listener::listen_for_connection_event (this=0x1e174160) at /usr/local/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab53c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4d6f850) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2fba in mysqld_main (argc=127, argv=0x4c49d38) at /usr/local/mysql-5.7.26/sql/mysqld.cc:5149
	#4  0x0000000000e9a12d in main (argc=10, argv=0x7fff81a82798) at /usr/local/mysql-5.7.26/sql/main.cc:25
	(gdb) 
	#0  0x00007f17791f1bed in poll () at ../sysdeps/unix/syscall-template.S:81
	#1  0x00000000016626a1 in Mysqld_socket_listener::listen_for_connection_event (this=0x1e174160) at /usr/local/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab53c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4d6f850) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2fba in mysqld_main (argc=127, argv=0x4c49d38) at /usr/local/mysql-5.7.26/sql/mysqld.cc:5149
	#4  0x0000000000e9a12d in main (argc=10, argv=0x7fff81a82798) at /usr/local/mysql-5.7.26/sql/main.cc:25

	(gdb) c
	Continuing.
	[Switching to Thread 0x7f153c53a700 (LWP 7541)]
		
	Breakpoint 1, buf_LRU_flush_or_remove_pages (id=118, buf_remove=BUF_REMOVE_ALL_NO_WRITE, trx=0x0) at /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc:930
	930		for (i = 0; i < srv_buf_pool_instances; i++) {


	(gdb) bt
	#0  buf_LRU_flush_or_remove_pages (id=118, buf_remove=BUF_REMOVE_ALL_NO_WRITE, trx=0x0) at /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc:930
	#1  0x0000000001bd74f9 in fil_reinit_space_header_for_table (table=0x1e147920, size=7, trx=0x7f176a1d4d08) at /usr/local/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:3008
	#2  0x0000000001a5a8d5 in row_truncate_table_for_mysql (table=0x1e147920, trx=0x7f176a1d4d08) at /usr/local/mysql-5.7.26/storage/innobase/row/row0trunc.cc:2077
	#3  0x00000000018c8a11 in ha_innobase::truncate (this=0x7f150c9384d0) at /usr/local/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:12463
	#4  0x0000000000f2f9ad in handler::ha_truncate (this=0x7f150c9384d0) at /usr/local/mysql-5.7.26/sql/handler.cc:4699
	#5  0x0000000001773985 in Sql_cmd_truncate_table::handler_truncate (this=0x7f150c00ff88, thd=0x7f150c00a8a0, table_ref=0x7f150c00f9f8, is_tmp_table=false) at /usr/local/mysql-5.7.26/sql/sql_truncate.cc:244
	#6  0x0000000001774194 in Sql_cmd_truncate_table::truncate_table (this=0x7f150c00ff88, thd=0x7f150c00a8a0, table_ref=0x7f150c00f9f8) at /usr/local/mysql-5.7.26/sql/sql_truncate.cc:502
	#7  0x00000000017742fb in Sql_cmd_truncate_table::execute (this=0x7f150c00ff88, thd=0x7f150c00a8a0) at /usr/local/mysql-5.7.26/sql/sql_truncate.cc:558
	#8  0x00000000015390fc in mysql_execute_command (thd=0x7f150c00a8a0, first_level=true) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:4835
	#9  0x000000000153af3e in mysql_parse (thd=0x7f150c00a8a0, parser_state=0x7f153c539690) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:5570
	#10 0x000000000153084f in dispatch_command (thd=0x7f150c00a8a0, com_data=0x7f153c539df0, command=COM_QUERY) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1484
	#11 0x000000000152f6b8 in do_command (thd=0x7f150c00a8a0) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1025
	#12 0x000000000165fff6 in handle_connection (arg=0x1e2cfb50) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
	#13 0x0000000001ce8640 in pfs_spawn_thread (arg=0x1e234a50) at /usr/local/mysql-5.7.26/storage/perfschema/pfs.cc:2190
	#14 0x00007f177a336e65 in start_thread (arg=0x7f153c53a700) at pthread_create.c:307
	#15 0x00007f17791fc88d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111



	root@mysqldb 02:56:  [lujb_db]> truncate table t;
	阻塞住

3. drop


	(gdb)  b buf_LRU_flush_or_remove_pages
	Breakpoint 1 at 0x1b75804: file /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc, line 930.

	(gdb) bt
	#0  0x00007f17791f1bed in poll () at ../sysdeps/unix/syscall-template.S:81
	#1  0x00000000016626a1 in Mysqld_socket_listener::listen_for_connection_event (this=0x1e174160) at /usr/local/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab53c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4d6f850) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2fba in mysqld_main (argc=127, argv=0x4c49d38) at /usr/local/mysql-5.7.26/sql/mysqld.cc:5149
	#4  0x0000000000e9a12d in main (argc=10, argv=0x7fff81a82798) at /usr/local/mysql-5.7.26/sql/main.cc:25


	(gdb) c
	Continuing.
	[Switching to Thread 0x7f153c53a700 (LWP 7541)]

	Breakpoint 1, buf_LRU_flush_or_remove_pages (id=121, buf_remove=BUF_REMOVE_FLUSH_NO_WRITE, trx=0x0) at /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc:930
	930		for (i = 0; i < srv_buf_pool_instances; i++) {

	(gdb) bt
	#0  buf_LRU_flush_or_remove_pages (id=121, buf_remove=BUF_REMOVE_FLUSH_NO_WRITE, trx=0x0) at /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc:930
	#1  0x0000000001bd6c39 in fil_delete_tablespace (id=121, buf_remove=BUF_REMOVE_FLUSH_NO_WRITE) at /usr/local/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:2802
	#2  0x0000000001a179c9 in row_drop_single_table_tablespace (space_id=121, tablename=0x7f150c01fac0 "lujb_db/t", filepath=0x7f150c01cbf8 "./lujb_db/t.ibd", is_temp=false, is_encrypted=false, trx=0x7f176a1d59e0)
		at /usr/local/mysql-5.7.26/storage/innobase/row/row0mysql.cc:4268
	#3  0x0000000001a18cd2 in row_drop_table_for_mysql (name=0x7f153c536a10 "lujb_db/t", trx=0x7f176a1d59e0, drop_db=false, nonatomic=true, handler=0x0)
		at /usr/local/mysql-5.7.26/storage/innobase/row/row0mysql.cc:4821
	#4  0x00000000018c8e76 in ha_innobase::delete_table (this=0x7f150c010168, name=0x7f153c538130 "./lujb_db/t") at /usr/local/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:12583
	#5  0x0000000000f300d4 in handler::ha_delete_table (this=0x7f150c010168, name=0x7f153c538130 "./lujb_db/t") at /usr/local/mysql-5.7.26/sql/handler.cc:4941
	#6  0x0000000000f29c0b in ha_delete_table (thd=0x7f150c00a8a0, table_type=0x4c4b450, path=0x7f153c538130 "./lujb_db/t", db=0x7f150c00ff70 "lujb_db", alias=0x7f150c00f9b0 "t", generate_warning=true)
		at /usr/local/mysql-5.7.26/sql/handler.cc:2594
	#7  0x00000000015b9b3d in mysql_rm_table_no_locks (thd=0x7f150c00a8a0, tables=0x7f150c00f9e8, if_exists=false, drop_temporary=false, drop_view=false, dont_log_query=false)
		at /usr/local/mysql-5.7.26/sql/sql_table.cc:2546
	#8  0x00000000015b8dea in mysql_rm_table (thd=0x7f150c00a8a0, tables=0x7f150c00f9e8, if_exists=0 '\000', drop_temporary=0 '\000') at /usr/local/mysql-5.7.26/sql/sql_table.cc:2196
	#9  0x0000000001535901 in mysql_execute_command (thd=0x7f150c00a8a0, first_level=true) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:3619
	#10 0x000000000153af3e in mysql_parse (thd=0x7f150c00a8a0, parser_state=0x7f153c539690) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:5570
	#11 0x000000000153084f in dispatch_command (thd=0x7f150c00a8a0, com_data=0x7f153c539df0, command=COM_QUERY) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1484
	#12 0x000000000152f6b8 in do_command (thd=0x7f150c00a8a0) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1025
	#13 0x000000000165fff6 in handle_connection (arg=0x1e2cfb50) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
	#14 0x0000000001ce8640 in pfs_spawn_thread (arg=0x1e234a50) at /usr/local/mysql-5.7.26/storage/perfschema/pfs.cc:2190
	#15 0x00007f177a336e65 in start_thread (arg=0x7f153c53a700) at pthread_create.c:307
	#16 0x00007f17791fc88d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111


	root@mysqldb 03:13:  [lujb_db]> drop table t;
	阻塞住



4. drop具体的过程： http://mysql.taobao.org/monthly/2016/01/07/

	1. 持有buffer pool mutex；
	2. 持有buffer pool中的flush list mutex；
	3. 开始扫描flush list；
		1. 如果dirty page属于drop table，那么就直接从flush list中remove掉；
		2. 如果删除的page个数超过了#define BUF_LRU_DROP_SEARCH_SIZE 1024 这个数目的话，释放buffer pool mutex，flush list mutex，释放cpu资源；
			释放flush list mutex；
			释放buffer pool mutex；
			强制通过pthread_yield进行一次OS context switch，释放剩余的cpu时间片；
		3. 重新持有buffer pool mutex；
		4. 重新持有flush list mutext；
	4. 释放flush list mutex；
	5. 释放buffer pool mutex；

