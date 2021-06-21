

0. 初始化表结构和数据
1. 函数接口 buf_LRU_flush_or_remove_pages 
2. drop table语句的栈帧


0. 初始化表结构和数据
	
	
	CREATE TABLE `t` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`),
		  KEY `t_modified`(`t_modified`)
		) ENGINE=InnoDB; 
	insert into t values(5,1,'2018-11-13');
	
	
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
	trunacte为： BUF_REMOVE_ALL_NO_WRITE ，  需要维护flush list和lru list，不回写数据

	作者：重庆八怪
	链接：https://www.jianshu.com/p/a956a3e30eb6
	来源：简书
	著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



2. drop table语句的栈帧


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



