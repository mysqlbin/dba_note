

大纲
	0. 初始化表结构、数据和要执行的语句
	1. 在二级索引打删除标记的函数打断点 btr_cur_del_mark_set_sec_rec
	2. 在主键索引打删除标记的函数打断点 row_upd_del_mark_clust_rec
	3. 在btr_rec_set_deleted_flag函数打断点
	4. 表只有主键索引
	5. 表只有二级索引
	6. 删除数据的函数栈
	7. 相关参考
	8. 小结


0. 初始化表结构、数据和要执行的语句

	CREATE TABLE `t` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`),
		  KEY `t_modified`(`t_modified`)
		) ENGINE=InnoDB; 
	insert into t values(5,1,'2018-11-13');
	
	delete from t where id=5;
	
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

1. 在二级索引打删除标记的函数打断点 btr_cur_del_mark_set_sec_rec

	(gdb) b btr_cur_del_mark_set_sec_rec
	Breakpoint 2 at 0x1b25868: file /usr/local/mysql/storage/innobase/btr/btr0cur.cc, line 4962.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x0000000001b25868 in btr_cur_del_mark_set_sec_rec(unsigned long, btr_cur_t*, unsigned long, que_thr_t*, mtr_t*) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:4962
	(gdb) bt
	#0  0x00007f0b871c0ccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x54e1570) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x5283780) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x3bfe948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffe26adfe78) at /usr/local/mysql/sql/main.cc:25

	(gdb) c
	Continuing.
	[Switching to Thread 0x7f0b600f9700 (LWP 5212)]

	Breakpoint 2, btr_cur_del_mark_set_sec_rec (flags=0, cursor=0x7f0b600f61f0, val=1, thr=0x7f0b44011338, mtr=0x7f0b600f62f0) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:4962
	4962		block = btr_cur_get_block(cursor);
	(gdb) bt
	#0  btr_cur_del_mark_set_sec_rec (flags=0, cursor=0x7f0b600f61f0, val=1, thr=0x7f0b44011338, mtr=0x7f0b600f62f0) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:4962
	#1  0x0000000001a72450 in row_upd_sec_index_entry (node=0x7f0b44011000, thr=0x7f0b44011338) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2298
	#2  0x0000000001a7273f in row_upd_sec_step (node=0x7f0b44011000, thr=0x7f0b44011338) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2366
	#3  0x0000000001a74388 in row_upd (node=0x7f0b44011000, thr=0x7f0b44011338) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3075
	#4  0x0000000001a746e1 in row_upd_step (thr=0x7f0b44011338) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#5  0x0000000001a13464 in row_update_for_mysql_using_upd_graph (mysql_rec=0x7f0b440101a0 "\375\005", prebuilt=0x7f0b440107a0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2574
	#6  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x7f0b440101a0 "\375\005", prebuilt=0x7f0b440107a0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
	#7  0x00000000018c0c12 in ha_innobase::delete_row (this=0x7f0b4400feb0, record=0x7f0b440101a0 "\375\005") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8356
	#8  0x0000000000f37031 in handler::ha_delete_row (this=0x7f0b4400feb0, buf=0x7f0b440101a0 "\375\005") at /usr/local/mysql/sql/handler.cc:8136
	#9  0x000000000174ce24 in Sql_cmd_delete::mysql_delete (this=0x7f0b44007468, thd=0x7f0b44001340, limit=18446744073709551615) at /usr/local/mysql/sql/sql_delete.cc:479
	#10 0x000000000174fb9c in Sql_cmd_delete::execute (this=0x7f0b44007468, thd=0x7f0b44001340) at /usr/local/mysql/sql/sql_delete.cc:1392
	#11 0x00000000015351f1 in mysql_execute_command (thd=0x7f0b44001340, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#12 0x000000000153a849 in mysql_parse (thd=0x7f0b44001340, parser_state=0x7f0b600f8690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#13 0x00000000015302d8 in dispatch_command (thd=0x7f0b44001340, com_data=0x7f0b600f8df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#14 0x000000000152f20c in do_command (thd=0x7f0b44001340) at /usr/local/mysql/sql/sql_parse.cc:1025
	#15 0x000000000165f7c8 in handle_connection (arg=0x4fa9420) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#16 0x0000000001ce7612 in pfs_spawn_thread (arg=0x559c750) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#17 0x00007f0b88305ea5 in start_thread () from /lib64/libpthread.so.0
	#18 0x00007f0b871cb9fd in clone () from /lib64/libc.so.6


---------------------------------------------------------------------------------------------------------------------------------------------------------------------

2. 在主键索引打删除标记的函数打断点 row_upd_del_mark_clust_rec


	b row_upd_del_mark_clust_rec


	(gdb) b row_upd_del_mark_clust_rec
	Breakpoint 2 at 0x1a73677: file /usr/local/mysql/storage/innobase/row/row0upd.cc, line 2763.
	(gdb) c
	Continuing.
	bt[Switching to Thread 0x7f0b6027f700 (LWP 5169)]

	Breakpoint 2, row_upd_del_mark_clust_rec (flags=0, node=0x7f0b780067a0, index=0x7f0b78024130, offsets=0x7f0b6027c160, thr=0x7f0b78006ad8, referenced=0, mtr=0x7f0b6027c480) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2763
	2763		ut_ad(node);
	(gdb) bt
	#0  row_upd_del_mark_clust_rec (flags=0, node=0x7f0b780067a0, index=0x7f0b78024130, offsets=0x7f0b6027c160, thr=0x7f0b78006ad8, referenced=0, mtr=0x7f0b6027c480) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2763
	#1  0x0000000001a73cfb in row_upd_clust_step (node=0x7f0b780067a0, thr=0x7f0b78006ad8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2926
	#2  0x0000000001a74202 in row_upd (node=0x7f0b780067a0, thr=0x7f0b78006ad8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#3  0x0000000001a746e1 in row_upd_step (thr=0x7f0b78006ad8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#4  0x0000000001a13464 in row_update_for_mysql_using_upd_graph (mysql_rec=0x7f0b780059a0 "\375\005", prebuilt=0x7f0b78005f40) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2574
	#5  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x7f0b780059a0 "\375\005", prebuilt=0x7f0b78005f40) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
	#6  0x00000000018c0c12 in ha_innobase::delete_row (this=0x7f0b780056b0, record=0x7f0b780059a0 "\375\005") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8356
	#7  0x0000000000f37031 in handler::ha_delete_row (this=0x7f0b780056b0, buf=0x7f0b780059a0 "\375\005") at /usr/local/mysql/sql/handler.cc:8136
	#8  0x000000000174ce24 in Sql_cmd_delete::mysql_delete (this=0x7f0b7801cf58, thd=0x7f0b780128a0, limit=18446744073709551615) at /usr/local/mysql/sql/sql_delete.cc:479
	#9  0x000000000174fb9c in Sql_cmd_delete::execute (this=0x7f0b7801cf58, thd=0x7f0b780128a0) at /usr/local/mysql/sql/sql_delete.cc:1392
	#10 0x00000000015351f1 in mysql_execute_command (thd=0x7f0b780128a0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#11 0x000000000153a849 in mysql_parse (thd=0x7f0b780128a0, parser_state=0x7f0b6027e690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#12 0x00000000015302d8 in dispatch_command (thd=0x7f0b780128a0, com_data=0x7f0b6027edf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#13 0x000000000152f20c in do_command (thd=0x7f0b780128a0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#14 0x000000000165f7c8 in handle_connection (arg=0x5664890) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#15 0x0000000001ce7612 in pfs_spawn_thread (arg=0x559c750) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#16 0x00007f0b88305ea5 in start_thread () from /lib64/libpthread.so.0
	#17 0x00007f0b871cb9fd in clone () from /lib64/libc.so.6
	(gdb) 

	ha_innobase::delete_row -> row_update_for_mysql -> row_update_for_mysql_using_upd_graph -> row_upd_step -> row_upd -> row_upd_clust_step -> row_upd_del_mark_clust_rec


---------------------------------------------------------------------------------------------------------------------------------------------------------------------


3. 在btr_rec_set_deleted_flag函数打断点

	(gdb) b btr_rec_set_deleted_flag
	Breakpoint 2 at 0x1a0c8f0: btr_rec_set_deleted_flag. (3 locations)
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   <MULTIPLE>         
	2.1                         y     0x0000000001a0c8f0 in btr_rec_set_deleted_flag(rec_t*, page_zip_des_t*, ulint) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	2.2                         y     0x0000000001b18a6e in btr_rec_set_deleted_flag(rec_t*, page_zip_des_t*, ulint) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	2.3                         y     0x0000000001c34b78 in btr_rec_set_deleted_flag(rec_t*, page_zip_des_t*, ulint) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f0b6027f700 (LWP 5169)]

	Breakpoint 2, btr_rec_set_deleted_flag (rec=0x7f0b70ba007e "\200", page_zip=0x0, flag=1) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	227		if (page_rec_is_comp(rec)) {
	(gdb) bt
	#0  btr_rec_set_deleted_flag (rec=0x7f0b70ba007e "\200", page_zip=0x0, flag=1) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	#1  0x0000000001b25474 in btr_cur_del_mark_set_clust_rec (flags=0, block=0x7f0b6fa42c40, rec=0x7f0b70ba007e "\200", index=0x7f0b78024130, offsets=0x7f0b6027c160, thr=0x7f0b7801d648, entry=0x7f0b780049e0, mtr=0x7f0b6027c480)
		at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:4836
	#2  0x0000000001a737c8 in row_upd_del_mark_clust_rec (flags=0, node=0x7f0b7801d310, index=0x7f0b78024130, offsets=0x7f0b6027c160, thr=0x7f0b7801d648, referenced=0, mtr=0x7f0b6027c480) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2781
	#3  0x0000000001a73cfb in row_upd_clust_step (node=0x7f0b7801d310, thr=0x7f0b7801d648) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2926
	#4  0x0000000001a74202 in row_upd (node=0x7f0b7801d310, thr=0x7f0b7801d648) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#5  0x0000000001a746e1 in row_upd_step (thr=0x7f0b7801d648) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#6  0x0000000001a13464 in row_update_for_mysql_using_upd_graph (mysql_rec=0x7f0b78023740 "\375\005", prebuilt=0x7f0b7801cab0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2574
	#7  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x7f0b78023740 "\375\005", prebuilt=0x7f0b7801cab0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
	#8  0x00000000018c0c12 in ha_innobase::delete_row (this=0x7f0b78023450, record=0x7f0b78023740 "\375\005") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8356
	#9  0x0000000000f37031 in handler::ha_delete_row (this=0x7f0b78023450, buf=0x7f0b78023740 "\375\005") at /usr/local/mysql/sql/handler.cc:8136
	#10 0x000000000174ce24 in Sql_cmd_delete::mysql_delete (this=0x7f0b78003248, thd=0x7f0b780128a0, limit=18446744073709551615) at /usr/local/mysql/sql/sql_delete.cc:479
	#11 0x000000000174fb9c in Sql_cmd_delete::execute (this=0x7f0b78003248, thd=0x7f0b780128a0) at /usr/local/mysql/sql/sql_delete.cc:1392
	#12 0x00000000015351f1 in mysql_execute_command (thd=0x7f0b780128a0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#13 0x000000000153a849 in mysql_parse (thd=0x7f0b780128a0, parser_state=0x7f0b6027e690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#14 0x00000000015302d8 in dispatch_command (thd=0x7f0b780128a0, com_data=0x7f0b6027edf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#15 0x000000000152f20c in do_command (thd=0x7f0b780128a0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#16 0x000000000165f7c8 in handle_connection (arg=0x5664890) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#17 0x0000000001ce7612 in pfs_spawn_thread (arg=0x559c750) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#18 0x00007f0b88305ea5 in start_thread () from /lib64/libpthread.so.0
	#19 0x00007f0b871cb9fd in clone () from /lib64/libc.so.6


---------------------------------------------------------------------------------------------------------------------------------------------------------------------

4. 表只有主键索引

	CREATE TABLE `t2` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`)
		) ENGINE=InnoDB; 
	insert into t2 values(1,1,'2018-11-13');


	delete from t2 where id=1;

	mysql> select * from t2;
	+----+------+---------------------+
	| id | a    | t_modified          |
	+----+------+---------------------+
	|  1 |    1 | 2018-11-13 00:00:00 |
	+----+------+---------------------+
	1 row in set (0.00 sec)



	b btr_rec_set_deleted_flag

	(gdb) b btr_rec_set_deleted_flag
	Breakpoint 2 at 0x1a0c8f0: btr_rec_set_deleted_flag. (3 locations)
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   <MULTIPLE>         
	2.1                         y     0x0000000001a0c8f0 in btr_rec_set_deleted_flag(rec_t*, page_zip_des_t*, ulint) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	2.2                         y     0x0000000001b18a6e in btr_rec_set_deleted_flag(rec_t*, page_zip_des_t*, ulint) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	2.3                         y     0x0000000001c34b78 in btr_rec_set_deleted_flag(rec_t*, page_zip_des_t*, ulint) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f0b6027f700 (LWP 5169)]

	Breakpoint 2, btr_rec_set_deleted_flag (rec=0x7f0b70be007e "\200", page_zip=0x0, flag=1) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	227		if (page_rec_is_comp(rec)) {
	(gdb) bt
	#0  btr_rec_set_deleted_flag (rec=0x7f0b70be007e "\200", page_zip=0x0, flag=1) at /usr/local/mysql/storage/innobase/include/btr0cur.ic:227
	#1  0x0000000001b25474 in btr_cur_del_mark_set_clust_rec (flags=0, block=0x7f0b6fa45ec0, rec=0x7f0b70be007e "\200", index=0x7f0b7801f780, offsets=0x7f0b6027c160, thr=0x7f0b7893e0f8, entry=0x7f0b7800e500, mtr=0x7f0b6027c480)
		at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:4836
	#2  0x0000000001a737c8 in row_upd_del_mark_clust_rec (flags=0, node=0x7f0b7893ddc0, index=0x7f0b7801f780, offsets=0x7f0b6027c160, thr=0x7f0b7893e0f8, referenced=0, mtr=0x7f0b6027c480) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2781
	#3  0x0000000001a73cfb in row_upd_clust_step (node=0x7f0b7893ddc0, thr=0x7f0b7893e0f8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2926
	#4  0x0000000001a74202 in row_upd (node=0x7f0b7893ddc0, thr=0x7f0b7893e0f8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#5  0x0000000001a746e1 in row_upd_step (thr=0x7f0b7893e0f8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#6  0x0000000001a13464 in row_update_for_mysql_using_upd_graph (mysql_rec=0x7f0b7800b5b0 "\375\001", prebuilt=0x7f0b7893d560) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2574
	#7  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x7f0b7800b5b0 "\375\001", prebuilt=0x7f0b7893d560) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
	#8  0x00000000018c0c12 in ha_innobase::delete_row (this=0x7f0b7800b2c0, record=0x7f0b7800b5b0 "\375\001") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8356
	#9  0x0000000000f37031 in handler::ha_delete_row (this=0x7f0b7800b2c0, buf=0x7f0b7800b5b0 "\375\001") at /usr/local/mysql/sql/handler.cc:8136
	#10 0x000000000174ce24 in Sql_cmd_delete::mysql_delete (this=0x7f0b78002208, thd=0x7f0b780128a0, limit=18446744073709551615) at /usr/local/mysql/sql/sql_delete.cc:479
	#11 0x000000000174fb9c in Sql_cmd_delete::execute (this=0x7f0b78002208, thd=0x7f0b780128a0) at /usr/local/mysql/sql/sql_delete.cc:1392
	#12 0x00000000015351f1 in mysql_execute_command (thd=0x7f0b780128a0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#13 0x000000000153a849 in mysql_parse (thd=0x7f0b780128a0, parser_state=0x7f0b6027e690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#14 0x00000000015302d8 in dispatch_command (thd=0x7f0b780128a0, com_data=0x7f0b6027edf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#15 0x000000000152f20c in do_command (thd=0x7f0b780128a0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#16 0x000000000165f7c8 in handle_connection (arg=0x5664890) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#17 0x0000000001ce7612 in pfs_spawn_thread (arg=0x559c750) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#18 0x00007f0b88305ea5 in start_thread () from /lib64/libpthread.so.0
	#19 0x00007f0b871cb9fd in clone () from /lib64/libc.so.6
	(gdb) 

	ha_innobase::delete_row -> row_update_for_mysql -> row_update_for_mysql_using_upd_graph -> row_upd_step -> row_upd -> row_upd_clust_step -> row_upd_del_mark_clust_rec -> btr_cur_del_mark_set_clust_rec -> btr_rec_set_deleted_flag


---------------------------------------------------------------------------------------------------------------------------------------------------------------------

5. 表只有二级索引

	CREATE TABLE `t3` (
		  `a` int(11) DEFAULT NULL,
		  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`),
		  KEY `t_modified`(`t_modified`)
		) ENGINE=InnoDB; 
	insert into t3 values(1,'2018-11-13');



	delete from t where t_modified='2018-11-13';

	b btr_rec_set_deleted_flag


	mysql> CREATE TABLE `t3` (
		->   `a` int(11) DEFAULT NULL,
		->   `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		->   PRIMARY KEY (`id`),
		->   KEY `t_modified`(`t_modified`)
		-> ) ENGINE=InnoDB; 
	ERROR 1072 (42000): Unknown error 1072


6. 删除数据的函数栈

	主键索引：
		ha_innobase::delete_row -> row_update_for_mysql -> row_update_for_mysql_using_upd_graph -> row_upd_step -> row_upd -> row_upd_clust_step -> row_upd_del_mark_clust_rec -> btr_cur_del_mark_set_clust_rec -> btr_rec_set_deleted_flag

	二级索引：
		ha_innobase::delete_row -> row_update_for_mysql -> row_update_for_mysql_using_upd_graph -> row_upd_step -> row_upd -> row_upd_sec_step -> row_upd_sec_index_entry -> btr_cur_del_mark_set_sec_rec -> btr_rec_set_deleted_flag

	row_upd->row_upd_clust_step
		row_upd_clust_ 操作主键索引的记录

	row_upd->row_upd_sec_step
		row_upd_sec_ 操作二级索引的记录

		需要遍历二级索引，因为二级是有多个
		do {
			/* Skip corrupted index */
			dict_table_skip_corrupt_index(node->index);

			if (!node->index) {
				break;
			}

			if (node->index->type != DICT_FTS) {
				err = row_upd_sec_step(node, thr);

				if (err != DB_SUCCESS) {

					DBUG_RETURN(err);
				}
			}

			node->index = dict_table_get_next_index(node->index);
		} while (node->index != NULL);
	
	先对主键索引的记录打删除标记，再对二级索引的记录打删除标记。
	
	
	示例：
		初始化表结构、数据：
			CREATE TABLE `t` (
				  `id` int(11) NOT NULL,
				  `a` int(11) DEFAULT NULL,
				  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
				  PRIMARY KEY (`id`),
				  KEY `t_modified`(`t_modified`)
				) ENGINE=InnoDB; 
			insert into t values(5,1,'2018-11-13');
			
	
			
		删除语句：
			delete from t where id=5;
			 
		主键索引的记录：(5,1,'2018-11-13')，先对这一行打删除标记
		二级索引的记录：('2018-11-13', 5)，再对这一行删除标记
	
	
	
	
7. 相关参考

	https://developer.aliyun.com/article/40971   [MySQL 学习] Innodb Optimistic Delete 简述

	https://blog.csdn.net/weixin_33714884/article/details/89627823

	https://blog.csdn.net/weixin_39853523/article/details/110713852   insert时调用本身字段_MySQL RC级别下并发insert锁超时问题 - 源码分析

	https://zhuanlan.zhihu.com/p/52098868  MySQL RC级别下并发insert锁超时问题 - 现象分析和解释
	https://zhuanlan.zhihu.com/p/52100378  MySQL RC级别下并发insert锁超时问题 - 源码分析
	https://zhuanlan.zhihu.com/p/52234835  MySQL RC级别下并发insert锁超时问题 - 案例验证

	

8. 小结

	1. 算是掌握如何打断点调试MySQL了。
	
	2. 打断点，追踪下 delete 语句的栈帧

	3. 删除数据的入口函数
		b Sql_cmd_delete::mysql_delete
		
	4. 删除记录只是打了删除标记的原因：加快执行删除语句的速度，加速语句的响应时间。
	
	5. gdb bt 打印的栈帧，要从后面往前面看
	
	6. 先对主键索引的记录打删除标记，再对二级索引的记录打删除标记。
	

后面要看看insert 和 update语句的函数栈。
	
更新数据的栈帧
		
	更新主键索引的情况
		先删除再插入
		ha_innobase::update_row -> row_update_for_mysql -> row_upd_step -> row_upd -> row_upd_clust_step -> row_upd_clust_rec_by_insert -> btr_cur_del_mark_set_clust_rec -> row_ins_index_entry


	更新非主键值，但是影响二级索引的情况
		ha_innobase::update_row -> row_update_for_mysql -> row_upd_step -> row_upd -> row_upd_sec_step -> row_upd_sec_index_entry -> btr_cur_del_mark_set_sec_rec -> row_ins_sec_index_entry
		
		row_upd_sec_step： 如果在行更新中更改了二级索引记录，则更新二级索引记录或如果这是删除，则删除它。
		
		
---------------------------------------------------------------------------------------------------------------------------------------------------------------------	
		
E:\github\mysql-5.7.26\storage\innobase\row\row0upd.cc

/***********************************************************//**
Marks the clustered index record deleted and inserts the updated version
of the record to the index. This function should be used when the ordering
fields of the clustered index record change. This should be quite rare in
database applications.
@return DB_SUCCESS if operation successfully completed, else error
code or DB_LOCK_WAIT */
static MY_ATTRIBUTE((warn_unused_result))
dberr_t
row_upd_clust_rec_by_insert(
/*========================*/
	ulint		flags,  /*!< in: undo logging and locking flags */
	upd_node_t*	node,	/*!< in/out: row update node */
	dict_index_t*	index,	/*!< in: clustered index of the record */
	que_thr_t*	thr,	/*!< in: query thread */
	ibool		referenced,/*!< in: TRUE if index may be referenced in
				a foreign key constraint */
	mtr_t*		mtr)	/*!< in/out: mtr; gets committed here */
{


-----------------------------------

E:\github\mysql-5.7.26\storage\innobase\btr\btr0cur.cc
/***********************************************************//**
Marks a clustered index record deleted. Writes an undo log record to
undo log on this delete marking. Writes in the trx id field the id
of the deleting transaction, and in the roll ptr field pointer to the
undo log record created.
@return DB_SUCCESS, DB_LOCK_WAIT, or error number */
dberr_t
btr_cur_del_mark_set_clust_rec(
/*===========================*/
	ulint		flags,  /*!< in: undo logging and locking flags */
	buf_block_t*	block,	/*!< in/out: buffer block of the record */
	rec_t*		rec,	/*!< in/out: record */
	dict_index_t*	index,	/*!< in: clustered index of the record */
	const ulint*	offsets,/*!< in: rec_get_offsets(rec) */
	que_thr_t*	thr,	/*!< in: query thread */
	const dtuple_t*	entry,	/*!< in: dtuple for the deleting record */
	mtr_t*		mtr)	/*!< in/out: mini-transaction */
	MY_ATTRIBUTE((warn_unused_result));
	
	
-----------------------------------------------------------------------------------

btr_cur_del_mark_set_clust_rec->btr_rec_set_deleted_flag


/* mysql-5.7.26\storage\innobase\include\btr0cur.ic */

/* 以下函数用于设置记录的删除位 */
/******************************************************//**
The following function is used to set the deleted bit of a record. */
UNIV_INLINE
void
btr_rec_set_deleted_flag(
/*=====================*/
	rec_t*		rec,	/*!< in/out: physical record */
	page_zip_des_t*	page_zip,/*!< in/out: compressed page (or NULL) */
	ulint		flag)	/*!< in: nonzero if delete marked */
{
	if (page_rec_is_comp(rec)) {
		rec_set_deleted_flag_new(rec, page_zip, flag);
	} else {
		ut_ad(!page_zip);
		rec_set_deleted_flag_old(rec, flag);
	}
}

#endif /* !UNIV_HOTBACKUP */




/***********************************************************//**
Updates the secondary index record if it is changed in the row update or
deletes it if this is a delete.
@return DB_SUCCESS if operation successfully completed, else error
code or DB_LOCK_WAIT */
static MY_ATTRIBUTE((warn_unused_result))
dberr_t
row_upd_sec_step(
/*=============*/
	upd_node_t*	node,	/*!< in: row update node */
	que_thr_t*	thr)	/*!< in: query thread */
{
	ut_ad((node->state == UPD_NODE_UPDATE_ALL_SEC)
	      || (node->state == UPD_NODE_UPDATE_SOME_SEC));
	ut_ad(!dict_index_is_clust(node->index));

	if (node->state == UPD_NODE_UPDATE_ALL_SEC
	    || row_upd_changes_ord_field_binary(node->index, node->update,
						thr, node->row, node->ext)) {
		return(row_upd_sec_index_entry(node, thr));
	}

	return(DB_SUCCESS);
}





	