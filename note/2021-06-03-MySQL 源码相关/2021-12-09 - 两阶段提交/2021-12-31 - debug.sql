MYSQL_BIN_LOG::flush_cache_to_file

	drop table if exists t;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;



	session A                       session B	     
	b MYSQL_BIN_LOG::flush_cache_to_file

									insert into t(`c`, `d`) values(1,1);


	(gdb) b MYSQL_BIN_LOG::flush_cache_to_file
	Breakpoint 2 at 0x17dea1a: file /usr/local/mysql/sql/binlog.cc, line 9190.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x00000000017dea1a in MYSQL_BIN_LOG::flush_cache_to_file(unsigned long long*) at /usr/local/mysql/sql/binlog.cc:9190
	(gdb) bt
	#0  0x00007f148e57cccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x65907b0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x6321650) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x4cd5948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffcf76afc48) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f1468237700 (LWP 2420)]

	Breakpoint 2, MYSQL_BIN_LOG::flush_cache_to_file (this=0x2d246e0 <mysql_bin_log>, end_pos_var=0x7f14682342a0) at /usr/local/mysql/sql/binlog.cc:9190
	9190	  if (flush_io_cache(&log_file))
	(gdb) bt
	#0  MYSQL_BIN_LOG::flush_cache_to_file (this=0x2d246e0 <mysql_bin_log>, end_pos_var=0x7f14682342a0) at /usr/local/mysql/sql/binlog.cc:9190
	#1  0x00000000017df846 in MYSQL_BIN_LOG::ordered_commit (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60, all=false, skip_commit=false) at /usr/local/mysql/sql/binlog.cc:9598
	#2  0x00000000017ddf00 in MYSQL_BIN_LOG::commit (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60, all=false) at /usr/local/mysql/sql/binlog.cc:8851
	#3  0x0000000000f281ef in ha_commit_trans (thd=0x6780f60, all=false, ignore_global_read_lock=false) at /usr/local/mysql/sql/handler.cc:1799
	#4  0x0000000001632f15 in trans_commit_stmt (thd=0x6780f60) at /usr/local/mysql/sql/transaction.cc:458
	#5  0x000000000153920c in mysql_execute_command (thd=0x6780f60, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4985
	#6  0x000000000153a849 in mysql_parse (thd=0x6780f60, parser_state=0x7f1468236690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#7  0x00000000015302d8 in dispatch_command (thd=0x6780f60, com_data=0x7f1468236df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#8  0x000000000152f20c in do_command (thd=0x6780f60) at /usr/local/mysql/sql/sql_parse.cc:1025
	#9  0x000000000165f7c8 in handle_connection (arg=0x66eca40) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#10 0x0000000001ce7612 in pfs_spawn_thread (arg=0x5930170) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#11 0x00007f148f6c1ea5 in start_thread () from /lib64/libpthread.so.0
	#12 0x00007f148e5879fd in clone () from /lib64/libc.so.6


binlog_cache_data::flush

	insert into t(`c`, `d`) values(2,2);
	
	
	(gdb) b binlog_cache_data::flush
	Breakpoint 2 at 0x17cd21e: file /usr/local/mysql/sql/binlog.cc, line 1674.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x00000000017cd21e in binlog_cache_data::flush(THD*, unsigned long long*, bool*) at /usr/local/mysql/sql/binlog.cc:1674
	(gdb) bt
	#0  0x00007f148e57cccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x65907b0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x6321650) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x4cd5948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffcf76afc48) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f1468237700 (LWP 2420)]

	Breakpoint 2, binlog_cache_data::flush (this=0x65ceed0, thd=0x6780f60, bytes_written=0x7f1468234130, wrote_xid=0x7f1468234167) at /usr/local/mysql/sql/binlog.cc:1674
	1674	  DBUG_ENTER("binlog_cache_data::flush");
	(gdb) bt
	#0  binlog_cache_data::flush (this=0x65ceed0, thd=0x6780f60, bytes_written=0x7f1468234130, wrote_xid=0x7f1468234167) at /usr/local/mysql/sql/binlog.cc:1674
	#1  0x00000000017e836b in binlog_cache_mngr::flush (this=0x65ceed0, thd=0x6780f60, bytes_written=0x7f1468234168, wrote_xid=0x7f1468234167) at /usr/local/mysql/sql/binlog.cc:967
	#2  0x00000000017de08b in MYSQL_BIN_LOG::flush_thread_caches (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60) at /usr/local/mysql/sql/binlog.cc:8894
	#3  0x00000000017de2a8 in MYSQL_BIN_LOG::process_flush_stage_queue (this=0x2d246e0 <mysql_bin_log>, total_bytes_var=0x7f14682342b8, rotate_var=0x7f14682342b7, out_queue_var=0x7f14682342a8) at /usr/local/mysql/sql/binlog.cc:8957
	#4  0x00000000017df81e in MYSQL_BIN_LOG::ordered_commit (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60, all=false, skip_commit=false) at /usr/local/mysql/sql/binlog.cc:9595
	#5  0x00000000017ddf00 in MYSQL_BIN_LOG::commit (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60, all=false) at /usr/local/mysql/sql/binlog.cc:8851
	#6  0x0000000000f281ef in ha_commit_trans (thd=0x6780f60, all=false, ignore_global_read_lock=false) at /usr/local/mysql/sql/handler.cc:1799
	#7  0x0000000001632f15 in trans_commit_stmt (thd=0x6780f60) at /usr/local/mysql/sql/transaction.cc:458
	#8  0x000000000153920c in mysql_execute_command (thd=0x6780f60, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4985
	#9  0x000000000153a849 in mysql_parse (thd=0x6780f60, parser_state=0x7f1468236690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#10 0x00000000015302d8 in dispatch_command (thd=0x6780f60, com_data=0x7f1468236df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#11 0x000000000152f20c in do_command (thd=0x6780f60) at /usr/local/mysql/sql/sql_parse.cc:1025
	#12 0x000000000165f7c8 in handle_connection (arg=0x66eca40) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#13 0x0000000001ce7612 in pfs_spawn_thread (arg=0x5930170) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#14 0x00007f148f6c1ea5 in start_thread () from /lib64/libpthread.so.0
	#15 0x00007f148e5879fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, binlog_cache_data::flush (this=0x65cf088, thd=0x6780f60, bytes_written=0x7f1468234128, wrote_xid=0x7f1468234167) at /usr/local/mysql/sql/binlog.cc:1674
	1674	  DBUG_ENTER("binlog_cache_data::flush");
	(gdb) bt
	#0  binlog_cache_data::flush (this=0x65cf088, thd=0x6780f60, bytes_written=0x7f1468234128, wrote_xid=0x7f1468234167) at /usr/local/mysql/sql/binlog.cc:1674
	#1  0x00000000017e83cc in binlog_cache_mngr::flush (this=0x65ceed0, thd=0x6780f60, bytes_written=0x7f1468234168, wrote_xid=0x7f1468234167) at /usr/local/mysql/sql/binlog.cc:971
	#2  0x00000000017de08b in MYSQL_BIN_LOG::flush_thread_caches (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60) at /usr/local/mysql/sql/binlog.cc:8894
	#3  0x00000000017de2a8 in MYSQL_BIN_LOG::process_flush_stage_queue (this=0x2d246e0 <mysql_bin_log>, total_bytes_var=0x7f14682342b8, rotate_var=0x7f14682342b7, out_queue_var=0x7f14682342a8) at /usr/local/mysql/sql/binlog.cc:8957
	#4  0x00000000017df81e in MYSQL_BIN_LOG::ordered_commit (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60, all=false, skip_commit=false) at /usr/local/mysql/sql/binlog.cc:9595
	#5  0x00000000017ddf00 in MYSQL_BIN_LOG::commit (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60, all=false) at /usr/local/mysql/sql/binlog.cc:8851
	#6  0x0000000000f281ef in ha_commit_trans (thd=0x6780f60, all=false, ignore_global_read_lock=false) at /usr/local/mysql/sql/handler.cc:1799
	#7  0x0000000001632f15 in trans_commit_stmt (thd=0x6780f60) at /usr/local/mysql/sql/transaction.cc:458
	#8  0x000000000153920c in mysql_execute_command (thd=0x6780f60, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4985
	#9  0x000000000153a849 in mysql_parse (thd=0x6780f60, parser_state=0x7f1468236690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#10 0x00000000015302d8 in dispatch_command (thd=0x6780f60, com_data=0x7f1468236df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#11 0x000000000152f20c in do_command (thd=0x6780f60) at /usr/local/mysql/sql/sql_parse.cc:1025
	#12 0x000000000165f7c8 in handle_connection (arg=0x66eca40) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#13 0x0000000001ce7612 in pfs_spawn_thread (arg=0x5930170) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#14 0x00007f148f6c1ea5 in start_thread () from /lib64/libpthread.so.0
	#15 0x00007f148e5879fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x00000000017dea1b in MYSQL_BIN_LOG::flush_cache_to_file (this=0x2d246e0 <mysql_bin_log>, end_pos_var=0x7f14682342a0) at /usr/local/mysql/sql/binlog.cc:9190
	9190	  if (flush_io_cache(&log_file))
	(gdb) bt
	#0  0x00000000017dea1b in MYSQL_BIN_LOG::flush_cache_to_file (this=0x2d246e0 <mysql_bin_log>, end_pos_var=0x7f14682342a0) at /usr/local/mysql/sql/binlog.cc:9190
	#1  0x00000000017df846 in MYSQL_BIN_LOG::ordered_commit (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60, all=false, skip_commit=false) at /usr/local/mysql/sql/binlog.cc:9598
	#2  0x00000000017ddf00 in MYSQL_BIN_LOG::commit (this=0x2d246e0 <mysql_bin_log>, thd=0x6780f60, all=false) at /usr/local/mysql/sql/binlog.cc:8851
	#3  0x0000000000f281ef in ha_commit_trans (thd=0x6780f60, all=false, ignore_global_read_lock=false) at /usr/local/mysql/sql/handler.cc:1799
	#4  0x0000000001632f15 in trans_commit_stmt (thd=0x6780f60) at /usr/local/mysql/sql/transaction.cc:458
	#5  0x000000000153920c in mysql_execute_command (thd=0x6780f60, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4985
	#6  0x000000000153a849 in mysql_parse (thd=0x6780f60, parser_state=0x7f1468236690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#7  0x00000000015302d8 in dispatch_command (thd=0x6780f60, com_data=0x7f1468236df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#8  0x000000000152f20c in do_command (thd=0x6780f60) at /usr/local/mysql/sql/sql_parse.cc:1025
	#9  0x000000000165f7c8 in handle_connection (arg=0x66eca40) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#10 0x0000000001ce7612 in pfs_spawn_thread (arg=0x5930170) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#11 0x00007f148f6c1ea5 in start_thread () from /lib64/libpthread.so.0
	#12 0x00007f148e5879fd in clone () from /lib64/libc.so.6
