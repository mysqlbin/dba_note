
1. 初始化表结构和数据

2. 打断点：dict_stats_save函数 然后执行DML操作

3. 打断点--dict_stats_save函数 然后再analyze

4. 打断点：row_update_statistics_if_needed函数 然后执行DML操作



1. 初始化表结构和数据

	drop table  if exists t;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	insert into t(c,d) values(1,1);
	insert into t(c,d) values(2,2);
	insert into t(c,d) values(3,3);
	insert into t(c,d) values(4,4);
	insert into t(c,d) values(5,5);
	insert into t(c,d) values(6,6);
	insert into t(c,d) values(7,7);
	insert into t(c,d) values(8,8);
	insert into t(c,d) values(9,9);
	insert into t(c,d) values(10,10);
	insert into t(c,d) values(11,11);
	insert into t(c,d) values(12,12);
	insert into t(c,d) values(13,13);
	insert into t(c,d) values(14,14);
	insert into t(c,d) values(15,15);

	mysql> SELECT * FROM t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	|  6 |    6 |    6 |
	|  7 |    7 |    7 |
	|  8 |    8 |    8 |
	|  9 |    9 |    9 |
	| 10 |   10 |   10 |
	| 11 |   11 |   11 |
	| 12 |   12 |   12 |
	| 13 |   13 |   13 |
	| 14 |   14 |   14 |
	| 15 |   15 |   15 |
	+----+------+------+
	15 rows in set (0.01 sec)

------------------------------------------------------------------------------


2. 打断点：dict_stats_save函数 然后执行DML操作
	
	session A              session B      

	b dict_stats_save		
						  delete from t;
						  
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fe8737f6700 (LWP 9526)]

	Breakpoint 2, dict_stats_save (table_orig=0x7fe8ac3577f0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	2371		table = dict_stats_snapshot_create(table_orig);
	(gdb) bt
	#0  dict_stats_save (table_orig=0x7fe8ac3577f0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fe8ac3577f0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#4  0x00007fe8bacbdea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fe8b9b839fd in clone () from /lib64/libc.so.6



	------------------------------------------------------------------------------

	session A              session B      

	b dict_stats_save		
						  insert into t select * from t;
						  (Query Ok)
						  
	------------------------------------------------------------------------------					  
						  
	session A              session B      

	b dict_stats_save		
						  update t set c=100 where id between 1 and 5;
						  (Blocked)
						  
	(gdb) b dict_stats_save
	Breakpoint 2 at 0x1bc2178: file /usr/local/mysql/storage/innobase/dict/dict0stats.cc, line 2371.
	(gdb) bt
	#0  0x00007fc207578ccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x64ad8b0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x64dc4e0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x4bed948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffe68c81558) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fc1c0ff9700 (LWP 9577)]

	Breakpoint 2, dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	2371		table = dict_stats_snapshot_create(table_orig);
	(gdb) bt
	#0  dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#4  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fc2075839fd in clone () from /lib64/libc.so.6
	(gdb) bt
	#0  dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#4  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fc2075839fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Program received signal SIGSEGV, Segmentation fault.
	0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
	355		ut_ad(table->magic_n == DICT_TABLE_MAGIC_N);
	(gdb) bt
	#0  0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
	#1  0x0000000001bbf555 in dict_stats_snapshot_create (table=0xf8947dc0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:769
	#2  0x0000000001bc2187 in dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	#3  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#4  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#5  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#6  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
	#7  0x00007fc2075839fd in clone () from /lib64/libc.so.6
	(gdb) bt
	#0  0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
	#1  0x0000000001bbf555 in dict_stats_snapshot_create (table=0xf8947dc0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:769
	#2  0x0000000001bc2187 in dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	#3  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#4  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#5  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#6  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
	#7  0x00007fc2075839fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.
	[Thread 0x7fc1ff563700 (LWP 9546) exited]
	[Thread 0x7fc1eb851700 (LWP 9547) exited]
	[Thread 0x7fc1eb050700 (LWP 9548) exited]
	[Thread 0x7fc1ea84f700 (LWP 9549) exited]
	[Thread 0x7fc1ea04e700 (LWP 9550) exited]
	[Thread 0x7fc1e984d700 (LWP 9551) exited]
	[Thread 0x7fc1e904c700 (LWP 9552) exited]
	[Thread 0x7fc1e884b700 (LWP 9553) exited]
	[Thread 0x7fc1e804a700 (LWP 9554) exited]
	[Thread 0x7fc1e7849700 (LWP 9555) exited]
	[Thread 0x7fc1e7048700 (LWP 9556) exited]
	[Thread 0x7fc1e6847700 (LWP 9557) exited]
	[Thread 0x7fc1e6046700 (LWP 9558) exited]
	[Thread 0x7fc1e5845700 (LWP 9559) exited]
	[Thread 0x7fc1e5044700 (LWP 9560) exited]
	[Thread 0x7fc1e4843700 (LWP 9561) exited]
	[Thread 0x7fc1e4042700 (LWP 9562) exited]
	[Thread 0x7fc1e3841700 (LWP 9563) exited]
	[Thread 0x7fc1e3040700 (LWP 9564) exited]
	[Thread 0x7fc1e283f700 (LWP 9565) exited]
	[Thread 0x7fc1e1e39700 (LWP 9568) exited]
	[Thread 0x7fc1e1638700 (LWP 9569) exited]
	[Thread 0x7fc1e0e37700 (LWP 9570) exited]
	[Thread 0x7fc1c17fa700 (LWP 9576) exited]
	[Thread 0x7fc1c0ff9700 (LWP 9577) exited]
	[Thread 0x7fc1c07f8700 (LWP 9578) exited]
	[Thread 0x7fc1bfff7700 (LWP 9579) exited]
	[Thread 0x7fc1fc1e6700 (LWP 9580) exited]
	[Thread 0x7fc1fc164700 (LWP 9581) exited]
	[Thread 0x7fc1bf535700 (LWP 9582) exited]
	[Thread 0x7fc208ae4740 (LWP 9545) exited]
	[Thread 0x7fc1c3fff700 (LWP 9571) exited]
	[Thread 0x7fc1e0235700 (LWP 9583) exited]
	[Thread 0x7fc1c27fc700 (LWP 9574) exited]
	[Thread 0x7fc1c2ffd700 (LWP 9573) exited]
	[Thread 0x7fc1c37fe700 (LWP 9572) exited]
	[Inferior 1 (process 9545) exited with code 02]
	-- mysqld crash 



 
	session A              session B      

	b dict_stats_save		
						  update t set d=100 where id between 1 and 5;
						  (Query Ok)

	------------------------------------------------------------------------------					  

	session A              session B      

	b dict_stats_save		
						  delete from t where id=1;
						  (Query Ok)
						  
		

	------------------------------------------------------------------------------	
						  
	session A              session B      

	b dict_stats_save		
						  delete from t where id between 1 and 5;		
						  (Blocked)
						  
	(gdb) b dict_stats_save
	Breakpoint 2 at 0x1bc2178: file /usr/local/mysql/storage/innobase/dict/dict0stats.cc, line 2371.
	(gdb) c
	Continuing.
	[Switching to Thread 0x7efc94ff9700 (LWP 9737)]

	Breakpoint 2, dict_stats_save (table_orig=0x5e74910, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	2371		table = dict_stats_snapshot_create(table_orig);
	(gdb) bt
	#0  dict_stats_save (table_orig=0x5e74910, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	#1  0x0000000001bc3bc5 in dict_stats_update (table=0x5e74910, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#4  0x00007efcdc101ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007efcdafc79fd in clone () from /lib64/libc.so.6





	------------------------------------------------------------------------------

	session A              session B      

	b dict_stats_update_persistent
							
						   update t set d=100 where c between 1 and 5;	
						  (Query Ok)








	------------------------------------------------------------------------------
	
3. 打断点--dict_stats_save函数 然后再analyze

------------------------------------------------------------------------------

	session A              session B      

	b dict_stats_save		
						  analyze table t;
						  
						  


	(gdb) b dict_stats_save
	Breakpoint 2 at 0x1bc2178: file /usr/local/mysql/storage/innobase/dict/dict0stats.cc, line 2371.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x0000000001bc2178 in dict_stats_save(dict_table_t*, index_id_t const*) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f59101b9700 (LWP 11748)]

	Breakpoint 2, dict_stats_save (table_orig=0x7f58f096ce40, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	2371		table = dict_stats_snapshot_create(table_orig);
	(gdb) bt
	#0  dict_stats_save (table_orig=0x7f58f096ce40, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
	#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7f58f096ce40, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#2  0x00000000018ca6ae in ha_innobase::info_low (this=0x7f58f0945040, flag=28, is_analyze=true) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:14028
	#3  0x00000000018cb3c1 in ha_innobase::analyze (this=0x7f58f0945040, thd=0x7f58f000a8c0, check_opt=0x7f58f000d0d8) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:14487
	#4  0x0000000000f2f9c7 in handler::ha_analyze (this=0x7f58f0945040, thd=0x7f58f000a8c0, check_opt=0x7f58f000d0d8) at /usr/local/mysql/sql/handler.cc:4733

	lock_type=TL_READ_NO_INSERT：表示加 read only 锁，阻塞DML请求。
		-- 什么时候释放？
	
	#5  0x000000000173fc7c in mysql_admin_table(THD *, TABLE_LIST *, HA_CHECK_OPT *, const char *, thr_lock_type, bool, bool, uint, int (*)(THD *, TABLE_LIST *, HA_CHECK_OPT *), struct {...}, int (*)(THD *, TABLE_LIST *)) (thd=0x7f58f000a8c0, tables=0x7f58f000ff68, 
		check_opt=0x7f58f000d0d8, operator_name=0x219bb4f "analyze", lock_type=TL_READ_NO_INSERT, open_for_modify=true, repair_table_use_frm=false, extra_open_options=0, prepare_func=0x0, operator_func=
		(int (handler::*)(handler * const, THD *, HA_CHECK_OPT *)) 0xf2f946 <handler::ha_analyze(THD*, st_ha_check_opt*)>, view_operator_func=0x0) at /usr/local/mysql/sql/sql_admin.cc:708
	#6  0x00000000017416ea in Sql_cmd_analyze_table::execute (this=0x7f58f00104f8, thd=0x7f58f000a8c0) at /usr/local/mysql/sql/sql_admin.cc:1214
	#7  0x0000000001538aa0 in mysql_execute_command (thd=0x7f58f000a8c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4835
	#8  0x000000000153a849 in mysql_parse (thd=0x7f58f000a8c0, parser_state=0x7f59101b8690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#9  0x00000000015302d8 in dispatch_command (thd=0x7f58f000a8c0, com_data=0x7f59101b8df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#10 0x000000000152f20c in do_command (thd=0x7f58f000a8c0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#11 0x000000000165f7c8 in handle_connection (arg=0x6089170) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#12 0x0000000001ce7612 in pfs_spawn_thread (arg=0x64db6d0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#13 0x00007f591b197ea5 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f591a05d9fd in clone () from /lib64/libc.so.6

	
	Sql_cmd_analyze_table::execute 
		-> mysql_admin_table
			-> handler::ha_analyze
				-> ha_innobase::analyze
					-> ha_innobase::info_low
						-> dict_stats_update
							-> dict_stats_save
	
4. 打断点：row_update_statistics_if_needed函数 然后执行DML操作

	------------------------------------------------------------------------------------------------------------------------------------

	session A              session B      

	b dict_stats_recalc_pool_add		
						  
						  delete from t where id=1;
						  (Query Ok)
						  
	------------------------------------------------------------------------------------------------------------------------------------




	session A              session B      

	b row_update_statistics_if_needed		
						  
						  delete from t where id=1;
						  (Blocked)
						  
	(gdb) b row_update_statistics_if_needed
	Breakpoint 2 at 0x1a1007f: file /usr/local/mysql/storage/innobase/row/row0mysql.cc, line 1193.
	(gdb) bt
	#0  0x00007f565ae1bccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x556ec20) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x549bd40) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x4141948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffcaf3b27f8) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f56127f4700 (LWP 10784)]

	Breakpoint 2, row_update_statistics_if_needed (table=0x7f564c050ac0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
	1193		if (!table->stat_initialized) {
	(gdb) bt
	#0  row_update_statistics_if_needed (table=0x7f564c050ac0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
	#1  0x0000000001a1367f in row_update_for_mysql_using_upd_graph (mysql_rec=0x7f564c0273b0 "\371\001", prebuilt=0x7f564c05c930) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2637
	#2  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x7f564c0273b0 "\371\001", prebuilt=0x7f564c05c930) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
	#3  0x00000000018c0c12 in ha_innobase::delete_row (this=0x7f564c0270c0, record=0x7f564c0273b0 "\371\001") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8356
	#4  0x0000000000f37031 in handler::ha_delete_row (this=0x7f564c0270c0, buf=0x7f564c0273b0 "\371\001") at /usr/local/mysql/sql/handler.cc:8136
	#5  0x000000000174ce24 in Sql_cmd_delete::mysql_delete (this=0x7f564c011728, thd=0x7f564c00ca70, limit=18446744073709551615) at /usr/local/mysql/sql/sql_delete.cc:479
	#6  0x000000000174fb9c in Sql_cmd_delete::execute (this=0x7f564c011728, thd=0x7f564c00ca70) at /usr/local/mysql/sql/sql_delete.cc:1392
	#7  0x00000000015351f1 in mysql_execute_command (thd=0x7f564c00ca70, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#8  0x000000000153a849 in mysql_parse (thd=0x7f564c00ca70, parser_state=0x7f56127f3690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#9  0x00000000015302d8 in dispatch_command (thd=0x7f564c00ca70, com_data=0x7f56127f3df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#10 0x000000000152f20c in do_command (thd=0x7f564c00ca70) at /usr/local/mysql/sql/sql_parse.cc:1025
	#11 0x000000000165f7c8 in handle_connection (arg=0x4c05020) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#12 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4d08690) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#13 0x00007f565bf60ea5 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f565ae269fd in clone () from /lib64/libc.so.6
						  
				
	------------------------------------------------------------------------------------------------------------------------------------



	select * from t where id=1;
	session A              session B      

	b row_update_statistics_if_needed		
						  
						  update t set d=1 where id=1;
						  (Query Ok)	



	------------------------------------------------------------------------------------------------------------------------------------


	session A              session B      

	b row_update_statistics_if_needed		
						  
						  update t set c=1 where id=1;
						   Query OK, 0 rows affected (2.68 sec)	
						   
	(gdb) b row_update_statistics_if_needed
	Breakpoint 2 at 0x1a1007f: file /usr/local/mysql/storage/innobase/row/row0mysql.cc, line 1193.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x0000000001a1007f in row_update_statistics_if_needed(dict_table_t*) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
	(gdb) bt
	#0  0x00007f0f98fa0ccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x45d3340) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4f3c5a0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x3651948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7fffb36001a8) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.

	------------------------------------------------------------------------------------------------------------------------------------


	session A              session B      

	b row_update_statistics_if_needed		
						  
						  update t set c=10 where id=1;
						  (Blocked)


	(gdb) b row_update_statistics_if_needed
	Breakpoint 2 at 0x1a1007f: file /usr/local/mysql/storage/innobase/row/row0mysql.cc, line 1193.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x0000000001a1007f in row_update_statistics_if_needed(dict_table_t*) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
	(gdb) bt
	#0  0x00007feb36274ccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x422a580) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4e4b850) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x35bf948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7fffbee2dab8) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.
	[Switching to Thread 0x7feaedbf2700 (LWP 10948)]

	Breakpoint 2, row_update_statistics_if_needed (table=0x7feb2896ca80) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
	1193		if (!table->stat_initialized) {
	(gdb) bt
	#0  row_update_statistics_if_needed (table=0x7feb2896ca80) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
	#1  0x0000000001a1367f in row_update_for_mysql_using_upd_graph (mysql_rec=0x7feb2801b288 "\371\001", prebuilt=0x7feb28972e80) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2637
	#2  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x7feb2801b288 "\371\001", prebuilt=0x7feb28972e80) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
	#3  0x00000000018c07e6 in ha_innobase::update_row (this=0x7feb2801af80, old_row=0x7feb2801b288 "\371\001", new_row=0x7feb2801b270 "\371\001") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8243
	#4  0x0000000000f36c43 in handler::ha_update_row (this=0x7feb2801af80, old_data=0x7feb2801b288 "\371\001", new_data=0x7feb2801b270 "\371\001") at /usr/local/mysql/sql/handler.cc:8103
	#5  0x00000000015e7de5 in mysql_update (thd=0x7feb2800a440, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7feaedbf0428, updated_return=0x7feaedbf0420) at /usr/local/mysql/sql/sql_update.cc:888
	#6  0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7feb2800faf8, thd=0x7feb2800a440, switch_to_multitable=0x7feaedbf04cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#7  0x00000000015ee453 in Sql_cmd_update::execute (this=0x7feb2800faf8, thd=0x7feb2800a440) at /usr/local/mysql/sql/sql_update.cc:3018
	#8  0x00000000015351f1 in mysql_execute_command (thd=0x7feb2800a440, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#9  0x000000000153a849 in mysql_parse (thd=0x7feb2800a440, parser_state=0x7feaedbf1690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#10 0x00000000015302d8 in dispatch_command (thd=0x7feb2800a440, com_data=0x7feaedbf1df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#11 0x000000000152f20c in do_command (thd=0x7feb2800a440) at /usr/local/mysql/sql/sql_parse.cc:1025
	#12 0x000000000165f7c8 in handle_connection (arg=0x408b080) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#13 0x0000000001ce7612 in pfs_spawn_thread (arg=0x40e62d0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#14 0x00007feb373b9ea5 in start_thread () from /lib64/libpthread.so.0
	#15 0x00007feb3627f9fd in clone () from /lib64/libc.so.6



