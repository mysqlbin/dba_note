
1. 初始化表结构和数据
2. b dict_drop_index_tree
3. b srv_is_tablespace_truncated
4. b btr_free_if_exists   -- btr_free_if_exists 函数是释放索引树的入口函数
5. b btr_cur_del_mark_set_sec_rec

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


2. b dict_drop_index_tree

	session A                           session B 
	b dict_drop_index_tree
										alter table t1 drop index idx_c;
										
										
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x0000000001b89fcd in dict_drop_index_tree(unsigned char*, btr_pcur_t*, mtr_t*) at /usr/local/mysql/storage/innobase/dict/dict0crea.cc:1110
	(gdb) bt
	#0  0x00007f27f72d5ccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x4718940) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4047a10) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x2e67948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffc5727b9a8) at /usr/local/mysql/sql/main.cc:25
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f27db828700 (LWP 4805)]

	Breakpoint 2, dict_drop_index_tree (rec=0x7f27e0b35427 "", pcur=0x7f27bc0324c8, mtr=0x7f27db822ba0) at /usr/local/mysql/storage/innobase/dict/dict0crea.cc:1110
	1110		ut_ad(mutex_own(&dict_sys->mutex));
	(gdb) bt
	#0  dict_drop_index_tree (rec=0x7f27e0b35427 "", pcur=0x7f27bc0324c8, mtr=0x7f27db822ba0) at /usr/local/mysql/storage/innobase/dict/dict0crea.cc:1110
	#1  0x0000000001a73b0e in row_upd_clust_step (node=0x7f27bc033c70, thr=0x7f27bc034118) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2886
	#2  0x0000000001a74202 in row_upd (node=0x7f27bc033c70, thr=0x7f27bc034118) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#3  0x0000000001a746e1 in row_upd_step (thr=0x7f27bc034118) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#4  0x00000000019bd8ef in que_thr_step (thr=0x7f27bc034118) at /usr/local/mysql/storage/innobase/que/que0que.cc:1031
	#5  0x00000000019bdbcb in que_run_threads_low (thr=0x7f27bc034118) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#6  0x00000000019bdd81 in que_run_threads (thr=0x7f27bc034118) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#7  0x00000000019be037 in que_eval_sql (info=0x7f27bc036a10, 
		sql=0x2237fa0 <row_merge_drop_indexes_dict(trx_t*, unsigned long)::sql> "PROCEDURE DROP_INDEXES_PROC () IS\nixid CHAR;\nfound INT;\nDECLARE CURSOR index_cur IS\n SELECT ID FROM SYS_INDEXES\n WHERE TABLE_ID=:tableid AND\n SUBSTR(NAME,0,1)='\377'\nFOR UPDATE;\nBEGIN\nfound := 1;\nOPEN in"..., reserve_dict_mutex=0, trx=0x7f27ec5ebd08)
		at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#8  0x0000000001a02609 in row_merge_drop_indexes_dict (trx=0x7f27ec5ebd08, table_id=7695) at /usr/local/mysql/storage/innobase/row/row0merge.cc:3458
	#9  0x000000000190ffa8 in commit_cache_norebuild (ctx=0x7f27bc02d378, table=0x7f27bc01cef0, trx=0x7f27ec5ebd08) at /usr/local/mysql/storage/innobase/handler/handler0alter.cc:8043
	#10 0x000000000190b2fa in ha_innobase::commit_inplace_alter_table (this=0x7f27bc01d8b0, altered_table=0x7f27bc02f210, ha_alter_info=0x7f27db824b90, commit=true)
		at /usr/local/mysql/storage/innobase/handler/handler0alter.cc:8699
	#11 0x0000000000f2fcfb in handler::ha_commit_inplace_alter_table (this=0x7f27bc01d8b0, altered_table=0x7f27bc02f210, ha_alter_info=0x7f27db824b90, commit=true)
		at /usr/local/mysql/sql/handler.cc:4832
	#12 0x00000000015c549e in mysql_inplace_alter_table (thd=0x7f27bc000fb0, table_list=0x7f27bc006688, table=0x7f27bc01cef0, altered_table=0x7f27bc02f210, 
		ha_alter_info=0x7f27db824b90, inplace_supported=HA_ALTER_INPLACE_NO_LOCK_AFTER_PREPARE, target_mdl_request=0x7f27db8245d0, alter_ctx=0x7f27db825120)
		at /usr/local/mysql/sql/sql_table.cc:7626
	#13 0x00000000015ca43a in mysql_alter_table (thd=0x7f27bc000fb0, new_db=0x7f27bc006c10 "test_db", new_name=0x0, create_info=0x7f27db825dc0, table_list=0x7f27bc006688, 
		alter_info=0x7f27db825d10) at /usr/local/mysql/sql/sql_table.cc:9798
	#14 0x0000000001743165 in Sql_cmd_alter_table::execute (this=0x7f27bc006c48, thd=0x7f27bc000fb0) at /usr/local/mysql/sql/sql_alter.cc:327
	#15 0x0000000001538aa0 in mysql_execute_command (thd=0x7f27bc000fb0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4835
	#16 0x000000000153a849 in mysql_parse (thd=0x7f27bc000fb0, parser_state=0x7f27db827690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#17 0x00000000015302d8 in dispatch_command (thd=0x7f27bc000fb0, com_data=0x7f27db827df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#18 0x000000000152f20c in do_command (thd=0x7f27bc000fb0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#19 0x000000000165f7c8 in handle_connection (arg=0x584be90) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#20 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3988990) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#21 0x00007f27f841aea5 in start_thread () from /lib64/libpthread.so.0
	#22 0x00007f27f72e09fd in clone () from /lib64/libc.so.6
	(gdb) 


	Sql_cmd_alter_table::execute
		-> mysql_alter_table
			-> mysql_inplace_alter_table
				-> handler::ha_commit_inplace_alter_table 
					-> ha_innobase::commit_inplace_alter_table
						-> commit_cache_norebuild
							-> row_merge_drop_indexes_dict
								-> que_eval_sql
									-> que_run_threads
										-> que_run_threads_low
											-> que_thr_step
												-> row_upd_step
													-> row_upd
														-> row_upd_clust_step
															-> dict_drop_index_tree
															
												
																								
3. b srv_is_tablespace_truncated

	session A                           session B 
	b srv_is_tablespace_truncated
										alter table t1 drop index idx_c;	

								
	(gdb) bt
	#0  srv_is_tablespace_truncated (space_id=7775) at /usr/local/mysql/storage/innobase/srv/srv0srv.cc:2946
	#1  0x0000000001b8a1de in dict_drop_index_tree (rec=0x7f2564b39551 "", pcur=0x7f256cedc4b8, mtr=0x7f255408dba0) at /usr/local/mysql/storage/innobase/dict/dict0crea.cc:1155
	#2  0x0000000001a73b0e in row_upd_clust_step (node=0x7f256ceddc60, thr=0x7f256cede108) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2886
	#3  0x0000000001a74202 in row_upd (node=0x7f256ceddc60, thr=0x7f256cede108) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#4  0x0000000001a746e1 in row_upd_step (thr=0x7f256cede108) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#5  0x00000000019bd8ef in que_thr_step (thr=0x7f256cede108) at /usr/local/mysql/storage/innobase/que/que0que.cc:1031
	#6  0x00000000019bdbcb in que_run_threads_low (thr=0x7f256cede108) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#7  0x00000000019bdd81 in que_run_threads (thr=0x7f256cede108) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#8  0x00000000019be037 in que_eval_sql (info=0x7f256c9431a0, 
		sql=0x2237fa0 <row_merge_drop_indexes_dict(trx_t*, unsigned long)::sql> "PROCEDURE DROP_INDEXES_PROC () IS\nixid CHAR;\nfound INT;\nDECLARE CURSOR index_cur IS\n SELECT ID FROM SYS_INDEXES\n WHERE TABLE_ID=:tableid AND\n SUBSTR(NAME,0,1)='\377'\nFOR UPDATE;\nBEGIN\nfound := 1;\nOPEN in"..., reserve_dict_mutex=0, trx=0x7f25705a6150) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#9  0x0000000001a02609 in row_merge_drop_indexes_dict (trx=0x7f25705a6150, table_id=7713) at /usr/local/mysql/storage/innobase/row/row0merge.cc:3458
	#10 0x000000000190ffa8 in commit_cache_norebuild (ctx=0x7f256c0109e0, table=0x7f256c9412f0, trx=0x7f25705a6150) at /usr/local/mysql/storage/innobase/handler/handler0alter.cc:8043
	#11 0x000000000190b2fa in ha_innobase::commit_inplace_alter_table (this=0x7f256c94a280, altered_table=0x7f256c9733c0, ha_alter_info=0x7f255408fb90, commit=true) at /usr/local/mysql/storage/innobase/handler/handler0alter.cc:8699
	#12 0x0000000000f2fcfb in handler::ha_commit_inplace_alter_table (this=0x7f256c94a280, altered_table=0x7f256c9733c0, ha_alter_info=0x7f255408fb90, commit=true) at /usr/local/mysql/sql/handler.cc:4832
	#13 0x00000000015c549e in mysql_inplace_alter_table (thd=0x7f256c00a440, table_list=0x7f256c00f8a8, table=0x7f256c9412f0, altered_table=0x7f256c9733c0, ha_alter_info=0x7f255408fb90, inplace_supported=HA_ALTER_INPLACE_NO_LOCK_AFTER_PREPARE, 
		target_mdl_request=0x7f255408f5d0, alter_ctx=0x7f2554090120) at /usr/local/mysql/sql/sql_table.cc:7626
	#14 0x00000000015ca43a in mysql_alter_table (thd=0x7f256c00a440, new_db=0x7f256c00fe30 "test_db", new_name=0x0, create_info=0x7f2554090dc0, table_list=0x7f256c00f8a8, alter_info=0x7f2554090d10) at /usr/local/mysql/sql/sql_table.cc:9798
	#15 0x0000000001743165 in Sql_cmd_alter_table::execute (this=0x7f256c00fe60, thd=0x7f256c00a440) at /usr/local/mysql/sql/sql_alter.cc:327
	#16 0x0000000001538aa0 in mysql_execute_command (thd=0x7f256c00a440, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4835
	#17 0x000000000153a849 in mysql_parse (thd=0x7f256c00a440, parser_state=0x7f2554092690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f256c00a440, com_data=0x7f2554092df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f256c00a440) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x486b940) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3bd8700) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f257c3d4ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f257b29a9fd in clone () from /lib64/libc.so.6


4. b btr_free_if_exists

	session A                           session B 
	b btr_free_if_exists
										alter table t1 drop index idx_c;	

	(gdb) bt
	#0  btr_free_if_exists (page_id=..., page_size=..., index_id=48592, mtr=0x7f475811eba0) at /usr/local/mysql/storage/innobase/btr/btr0btr.cc:1194
	#1  0x0000000001b8a229 in dict_drop_index_tree (rec=0x7f476a74d598 "", pcur=0x7f47741c8d48, mtr=0x7f475811eba0) at /usr/local/mysql/storage/innobase/dict/dict0crea.cc:1160
	#2  0x0000000001a73b0e in row_upd_clust_step (node=0x7f47741ca4f0, thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2886
	#3  0x0000000001a74202 in row_upd (node=0x7f47741ca4f0, thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#4  0x0000000001a746e1 in row_upd_step (thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#5  0x00000000019bd8ef in que_thr_step (thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/que/que0que.cc:1031
	#6  0x00000000019bdbcb in que_run_threads_low (thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#7  0x00000000019bdd81 in que_run_threads (thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#8  0x00000000019be037 in que_eval_sql (info=0x7f4774061200, 
		sql=0x2237fa0 <row_merge_drop_indexes_dict(trx_t*, unsigned long)::sql> "PROCEDURE DROP_INDEXES_PROC () IS\nixid CHAR;\nfound INT;\nDECLARE CURSOR index_cur IS\n SELECT ID FROM SYS_INDEXES\n WHERE TABLE_ID=:tableid AND\n SUBSTR(NAME,0,1)='\377'\nFOR UPDATE;\nBEGIN\nfound := 1;\nOPEN in"..., reserve_dict_mutex=0, trx=0x7f4771bfed08) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#9  0x0000000001a02609 in row_merge_drop_indexes_dict (trx=0x7f4771bfed08, table_id=7714) at /usr/local/mysql/storage/innobase/row/row0merge.cc:3458
	#10 0x000000000190ffa8 in commit_cache_norebuild (ctx=0x7f4774011d50, table=0x7f47740347c0, trx=0x7f4771bfed08) at /usr/local/mysql/storage/innobase/handler/handler0alter.cc:8043
	#11 0x000000000190b2fa in ha_innobase::commit_inplace_alter_table (this=0x7f4774030070, altered_table=0x7f477405f2b0, ha_alter_info=0x7f4758120b90, commit=true) at /usr/local/mysql/storage/innobase/handler/handler0alter.cc:8699
	#12 0x0000000000f2fcfb in handler::ha_commit_inplace_alter_table (this=0x7f4774030070, altered_table=0x7f477405f2b0, ha_alter_info=0x7f4758120b90, commit=true) at /usr/local/mysql/sql/handler.cc:4832
	#13 0x00000000015c549e in mysql_inplace_alter_table (thd=0x7f477400caf0, table_list=0x7f4774010c18, table=0x7f47740347c0, altered_table=0x7f477405f2b0, ha_alter_info=0x7f4758120b90, inplace_supported=HA_ALTER_INPLACE_NO_LOCK_AFTER_PREPARE, 
		target_mdl_request=0x7f47581205d0, alter_ctx=0x7f4758121120) at /usr/local/mysql/sql/sql_table.cc:7626
	#14 0x00000000015ca43a in mysql_alter_table (thd=0x7f477400caf0, new_db=0x7f47740111a0 "test_db", new_name=0x0, create_info=0x7f4758121dc0, table_list=0x7f4774010c18, alter_info=0x7f4758121d10) at /usr/local/mysql/sql/sql_table.cc:9798
	#15 0x0000000001743165 in Sql_cmd_alter_table::execute (this=0x7f47740111d0, thd=0x7f477400caf0) at /usr/local/mysql/sql/sql_alter.cc:327
	#16 0x0000000001538aa0 in mysql_execute_command (thd=0x7f477400caf0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4835
	#17 0x000000000153a849 in mysql_parse (thd=0x7f477400caf0, parser_state=0x7f4758123690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f477400caf0, com_data=0x7f4758123df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f477400caf0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x411de40) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x42eea50) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f4781c76ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f4780b3c9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.
	
	Sql_cmd_alter_table::execute
	-> mysql_alter_table
		-> mysql_inplace_alter_table
			-> handler::ha_commit_inplace_alter_table 
				-> ha_innobase::commit_inplace_alter_table
					-> commit_cache_norebuild
						-> row_merge_drop_indexes_dict
							-> que_eval_sql
								-> que_run_threads
									-> que_run_threads_low
										-> que_thr_step
											-> row_upd_step
												-> row_upd
													-> row_upd_clust_step
														-> dict_drop_index_tree
															-> btr_free_if_exists
															
5. b btr_cur_del_mark_set_sec_rec

	在 设置record的delete标志位 的入口函数打断点
	
	session A                           session B 
	b btr_cur_del_mark_set_sec_rec
										alter table t1 drop index idx_c;
										(Query OK)
										
