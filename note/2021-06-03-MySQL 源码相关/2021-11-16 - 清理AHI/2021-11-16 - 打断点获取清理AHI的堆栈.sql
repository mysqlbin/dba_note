

1. 初始化表结构和数据
2. b btr_free_if_exists
3. ha_remove_all_nodes_to_page
4. 从别人的文章获取的清理AHI的堆栈


1. 初始化表结构和数据

	DROP TABLE IF EXISTS  t1;

	CREATE TABLE `t1` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

	insert into t1(`c`,`d`) values(1,1);
	insert into t1(`c`,`d`) values(3,3);
	insert into t1(`c`,`d`) values(5,5);

	SELECT * FROM t1;



2. b btr_free_if_exists
	

	session A                           session B 
	b btr_free_if_exists
										drop table t1;

	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	(gdb) b btr_free_if_exists
	Breakpoint 2 at 0x1b0683b: file /usr/local/mysql/storage/innobase/btr/btr0btr.cc, line 1194.
	(gdb) bt
	#0  0x00007f8c25ba5ccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x47a3530) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x39dd410) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x2ede948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffdfb6954e8) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f8bdd531700 (LWP 7001)]

	Breakpoint 2, btr_free_if_exists (page_id=..., page_size=..., index_id=48595, mtr=0x7f8bdd52c7b0) at /usr/local/mysql/storage/innobase/btr/btr0btr.cc:1194
	1194			page_id, page_size, index_id, mtr);


	(gdb) bt
	#0  btr_free_if_exists (page_id=..., page_size=..., index_id=48596, mtr=0x7f8bdd52c7b0) at /usr/local/mysql/storage/innobase/btr/btr0btr.cc:1194
	#1  0x0000000001b8a229 in dict_drop_index_tree (rec=0x7f8c0f1255df "", pcur=0x58927c0, mtr=0x7f8bdd52c7b0) at /usr/local/mysql/storage/innobase/dict/dict0crea.cc:1160
	#2  0x0000000001a73b0e in row_upd_clust_step (node=0x58920c0, thr=0x5895a60) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2886
	#3  0x0000000001a74202 in row_upd (node=0x58920c0, thr=0x5895a60) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#4  0x0000000001a746e1 in row_upd_step (thr=0x5895a60) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#5  0x00000000019bd8ef in que_thr_step (thr=0x5895a60) at /usr/local/mysql/storage/innobase/que/que0que.cc:1031
	#6  0x00000000019bdbcb in que_run_threads_low (thr=0x5895a60) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#7  0x00000000019bdd81 in que_run_threads (thr=0x5895a60) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#8  0x00000000019be037 in que_eval_sql (info=0x52fb180, 
		sql=0x532bf60 "PROCEDURE DROP_TABLE_PROC () IS\nsys_foreign_id CHAR;\ntable_id CHAR;\nindex_id CHAR;\nforeign_id CHAR;\nspace_id INT;\nfound INT;\nDECLARE CURSOR cur_fk IS\nSELECT ID FROM SYS_FOREIGN\nWHERE FOR_NAME = :table"..., reserve_dict_mutex=0, 
		trx=0x7f8c1c8e7150) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#9  0x0000000001a17b80 in row_drop_table_for_mysql (name=0x7f8bdd52da20 "test_db/t1", trx=0x7f8c1c8e7150, drop_db=false, nonatomic=true, handler=0x0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:4734
	#10 0x00000000018c80c8 in ha_innobase::delete_table (this=0x49948c8, name=0x7f8bdd52f140 "./test_db/t1") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:12583
	#11 0x0000000000f2ffe6 in handler::ha_delete_table (this=0x49948c8, name=0x7f8bdd52f140 "./test_db/t1") at /usr/local/mysql/sql/handler.cc:4941
	#12 0x0000000000f29b1d in ha_delete_table (thd=0x4990040, table_type=0x2edfff0, path=0x7f8bdd52f140 "./test_db/t1", db=0x49946d0 "test_db", alias=0x4994110 "t1", generate_warning=true) at /usr/local/mysql/sql/handler.cc:2594
	#13 0x00000000015b9381 in mysql_rm_table_no_locks (thd=0x4990040, tables=0x4994148, if_exists=false, drop_temporary=false, drop_view=false, dont_log_query=false) at /usr/local/mysql/sql/sql_table.cc:2546
	#14 0x00000000015b862e in mysql_rm_table (thd=0x4990040, tables=0x4994148, if_exists=0 '\000', drop_temporary=0 '\000') at /usr/local/mysql/sql/sql_table.cc:2196
	#15 0x00000000015352a5 in mysql_execute_command (thd=0x4990040, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3619
	#16 0x000000000153a849 in mysql_parse (thd=0x4990040, parser_state=0x7f8bdd530690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#17 0x00000000015302d8 in dispatch_command (thd=0x4990040, com_data=0x7f8bdd530df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#18 0x000000000152f20c in do_command (thd=0x4990040) at /usr/local/mysql/sql/sql_parse.cc:1025
	#19 0x000000000165f7c8 in handle_connection (arg=0x46ab820) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#20 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3b82400) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#21 0x00007f8c26ceaea5 in start_thread () from /lib64/libpthread.so.0
	#22 0x00007f8c25bb09fd in clone () from /lib64/libc.so.6
	(gdb) c



3. ha_remove_all_nodes_to_page
	
	先执行 "select * from t1 where c=1;" 语句1000次，填充AHI。
	
	
	session A                           session B 
	b ha_remove_all_nodes_to_page
										drop table t1;


	(gdb) b ha_remove_all_nodes_to_page
	Breakpoint 2 at 0x1c02186: file /usr/local/mysql/storage/innobase/ha/ha0ha.cc, line 414.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep n   0x0000000001c02186 in ha_remove_all_nodes_to_page(hash_table_t*, unsigned long, unsigned char const*) at /usr/local/mysql/storage/innobase/ha/ha0ha.cc:414
	(gdb) bt
	#0  0x00007f114ecf2ccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x4a8d0e0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x47e2830) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x3be2948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffc17e39158) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f11281bf700 (LWP 7424)]

	Breakpoint 2, ha_remove_all_nodes_to_page (table=0x4651228, fold=13224724825510121053, page=0x7f1138f64000 "\023$\202\377") at /usr/local/mysql/storage/innobase/ha/ha0ha.cc:414
	414		ut_ad(table);
	(gdb) bt
	#0  ha_remove_all_nodes_to_page (table=0x4651228, fold=13224724825510121053, page=0x7f1138f64000 "\023$\202\377") at /usr/local/mysql/storage/innobase/ha/ha0ha.cc:414
	#1  0x0000000001b385ee in btr_search_drop_page_hash_index (block=0x7f11379033e8) at /usr/local/mysql/storage/innobase/btr/btr0sea.cc:1326
	#2  0x0000000001b05d33 in btr_free_root (block=0x7f11379033e8, mtr=0x7f11281ba7b0) at /usr/local/mysql/storage/innobase/btr/btr0btr.cc:874
	#3  0x0000000001b068ac in btr_free_if_exists (page_id=..., page_size=..., index_id=48599, mtr=0x7f11281ba7b0) at /usr/local/mysql/storage/innobase/btr/btr0btr.cc:1202
	#4  0x0000000001b8a229 in dict_drop_index_tree (rec=0x7f11389d5626 "", pcur=0x7f1140ef42a0, mtr=0x7f11281ba7b0) at /usr/local/mysql/storage/innobase/dict/dict0crea.cc:1160
	#5  0x0000000001a73b0e in row_upd_clust_step (node=0x7f1140ef3ba0, thr=0x7f1140ef7540) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2886
	#6  0x0000000001a74202 in row_upd (node=0x7f1140ef3ba0, thr=0x7f1140ef7540) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#7  0x0000000001a746e1 in row_upd_step (thr=0x7f1140ef7540) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#8  0x00000000019bd8ef in que_thr_step (thr=0x7f1140ef7540) at /usr/local/mysql/storage/innobase/que/que0que.cc:1031
	#9  0x00000000019bdbcb in que_run_threads_low (thr=0x7f1140ef7540) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#10 0x00000000019bdd81 in que_run_threads (thr=0x7f1140ef7540) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#11 0x00000000019be037 in que_eval_sql (info=0x7f114094b0a0, 
		sql=0x7f1140ee8ef0 "PROCEDURE DROP_TABLE_PROC () IS\nsys_foreign_id CHAR;\ntable_id CHAR;\nindex_id CHAR;\nforeign_id CHAR;\nspace_id INT;\nfound INT;\nDECLARE CURSOR cur_fk IS\nSELECT ID FROM SYS_FOREIGN\nWHERE FOR_NAME = :table"..., reserve_dict_mutex=0, 
		trx=0x7f1144009150) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#12 0x0000000001a17b80 in row_drop_table_for_mysql (name=0x7f11281bba20 "test_db/t1", trx=0x7f1144009150, drop_db=false, nonatomic=true, handler=0x0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:4734
	#13 0x00000000018c80c8 in ha_innobase::delete_table (this=0x7f1140971bd8, name=0x7f11281bd140 "./test_db/t1") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:12583
	#14 0x0000000000f2ffe6 in handler::ha_delete_table (this=0x7f1140971bd8, name=0x7f11281bd140 "./test_db/t1") at /usr/local/mysql/sql/handler.cc:4941
	#15 0x0000000000f29b1d in ha_delete_table (thd=0x7f114001e120, table_type=0x3be3ff0, path=0x7f11281bd140 "./test_db/t1", db=0x7f11409719e0 "test_db", alias=0x7f1140971420 "t1", generate_warning=true) at /usr/local/mysql/sql/handler.cc:2594
	#16 0x00000000015b9381 in mysql_rm_table_no_locks (thd=0x7f114001e120, tables=0x7f1140971458, if_exists=false, drop_temporary=false, drop_view=false, dont_log_query=false) at /usr/local/mysql/sql/sql_table.cc:2546
	#17 0x00000000015b862e in mysql_rm_table (thd=0x7f114001e120, tables=0x7f1140971458, if_exists=0 '\000', drop_temporary=0 '\000') at /usr/local/mysql/sql/sql_table.cc:2196
	#18 0x00000000015352a5 in mysql_execute_command (thd=0x7f114001e120, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3619
	#19 0x000000000153a849 in mysql_parse (thd=0x7f114001e120, parser_state=0x7f11281be690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#20 0x00000000015302d8 in dispatch_command (thd=0x7f114001e120, com_data=0x7f11281bedf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#21 0x000000000152f20c in do_command (thd=0x7f114001e120) at /usr/local/mysql/sql/sql_parse.cc:1025
	#22 0x000000000165f7c8 in handle_connection (arg=0x46d8f50) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#23 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4703170) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#24 0x00007f114fe37ea5 in start_thread () from /lib64/libpthread.so.0
	#25 0x00007f114ecfd9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, ha_remove_all_nodes_to_page (table=0x4651228, fold=13224724825510317662, page=0x7f1138f64000 "\023$\202\377") at /usr/local/mysql/storage/innobase/ha/ha0ha.cc:414
	414		ut_ad(table);
	
	
	mysql_rm_table
		-> mysql_rm_table_no_locks	
			-> ha_delete_table	
				-> handler::ha_delete_table	
					-> ha_innobase::delete_table	
						-> row_drop_table_for_mysql	
							-> que_eval_sql	
								-> que_run_threads	
									-> que_run_threads_low	
										-> que_thr_step	
											 -> row_upd_step	
												-> row_upd	
													-> row_upd_clust_step	
														-> dict_drop_index_tree	
															-> btr_free_if_exists	
																-> btr_free_root	
																	-> btr_search_drop_page_hash_index	
																		-> ha_remove_all_nodes_to_page	
		
4. 从别人的文章获取的清理AHI的堆栈

	Thread 32 (Thread 0x7f5d002b2700 (LWP 8156)):

	#0 ha_remove_all_nodes_to_page

	#1 btr_search_drop_page_hash_index

	#2 btr_search_drop_page_hash_when_freed

	#3 fseg_free_extent

	#4 fseg_free_step

	#5 btr_free_but_not_root

	#6 btr_free_if_exists

	#7 dict_drop_index_tree

	#8 row_upd_clust_step

	#9 row_upd

	#10 row_upd_step

	#11 que_thr_step

	#12 que_run_threads_low

	#13 que_run_threads

	#14 que_eval_sql

	#15 row_drop_table_for_mysql

	#16 ha_innobase::delete_table

	#17 ha_delete_table

	#18 mysql_rm_table_no_locks

	#19 mysql_rm_table

	#20 mysql_execute_command

	#21 mysql_parse

	#22 dispatch_command

	#23 do_command

	#24 handle_connection

	#25 pfs_spawn_thread

	#26 start_thread ()


