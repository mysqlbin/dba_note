 
 
 RR隔离级别	

	mysql> show global variables like 'tx_isolation';
	+---------------+-----------------+
	| Variable_name | Value           |
	+---------------+-----------------+
	| tx_isolation  | REPEATABLE-READ |
	+---------------+-----------------+
	1 row in set (0.03 sec)

	mysql> select * from hero;
	+--------+------------+---------+
	| number | name       | country |
	+--------+------------+---------+
	|      1 | l刘备      | 蜀      |
	|      3 | z诸葛亮    | 蜀      |
	|      8 | c曹操      | 魏      |
	|     15 | x荀彧      | 魏      |
	|     20 | s孙权      | 吴      |
	+--------+------------+---------+
	5 rows in set (0.00 sec)

打断点
	
	        	
	
	update hero set country='中' where name='c曹操';
	update hero set country='魏' where name='c曹操';
	
b trx_undof_page_add_undo_rec_log
	
(gdb) bt
#0  trx_undof_page_add_undo_rec_log (undo_page=0x7f21cc11c000 "Fu\204.", old_free=710, new_free=743, mtr=0x7f21bc2ac2d0) at /usr/local/mysql/storage/innobase/trx/trx0rec.cc:67
#1  0x0000000001ac9360 in trx_undo_page_report_modify (undo_page=0x7f21cc11c000 "Fu\204.", trx=0x7f21d8510d08, index=0x5eebbc0, rec=0x7f21ccde022e "\200", offsets=0x7f21bc2ace30, update=0x5ec4e78, cmpl_info=1, row=0x0, mtr=0x7f21bc2ac2d0)
    at /usr/local/mysql/storage/innobase/trx/trx0rec.cc:1394
#2  0x0000000001aca9b4 in trx_undo_report_row_operation (flags=2, op_type=2, thr=0x5ec5098, index=0x5eebbc0, clust_entry=0x0, update=0x5ec4e78, cmpl_info=1, rec=0x7f21ccde022e "\200", offsets=0x7f21bc2ace30, roll_ptr=0x7f21bc2ac928)
    at /usr/local/mysql/storage/innobase/trx/trx0rec.cc:1990
#3  0x0000000001b21ec2 in btr_cur_upd_lock_and_undo (flags=2, cursor=0x4f122e8, offsets=0x7f21bc2ace30, update=0x5ec4e78, cmpl_info=1, thr=0x5ec5098, mtr=0x7f21bc2ad150, roll_ptr=0x7f21bc2ac928) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3539
-- btr_cur_update_in_place 等值更新的证据
#4  0x0000000001b22a98 in btr_cur_update_in_place (flags=2, cursor=0x4f122e8, offsets=0x7f21bc2ace30, update=0x5ec4e78, cmpl_info=1, thr=0x5ec5098, trx_id=78111, mtr=0x7f21bc2ad150) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3838
#5  0x0000000001b23288 in btr_cur_optimistic_update (flags=2, cursor=0x4f122e8, offsets=0x7f21bc2acd90, heap=0x7f21bc2ad668, update=0x5ec4e78, cmpl_info=1, thr=0x5ec5098, trx_id=78111, mtr=0x7f21bc2ad150) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3998
#6  0x0000000001a732ee in row_upd_clust_rec (flags=0, node=0x5ec4d60, index=0x5eebbc0, offsets=0x7f21bc2ace30, offsets_heap=0x7f21bc2ad668, thr=0x5ec5098, mtr=0x7f21bc2ad150) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2647
#7  0x0000000001a73dcc in row_upd_clust_step (node=0x5ec4d60, thr=0x5ec5098) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2950
#8  0x0000000001a74202 in row_upd (node=0x5ec4d60, thr=0x5ec5098) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
#9  0x0000000001a746e1 in row_upd_step (thr=0x5ec5098) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
#10 0x0000000001a13464 in row_update_for_mysql_using_upd_graph (mysql_rec=0x5e9d470 "\374\b", prebuilt=0x5ec4500) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2574
#11 0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x5e9d470 "\374\b", prebuilt=0x5ec4500) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
#12 0x00000000018c07e6 in ha_innobase::update_row (this=0x5e9cd30, old_row=0x5e9d470 "\374\b", new_row=0x5e9d140 "\374\b") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8243
#13 0x0000000000f36c43 in handler::ha_update_row (this=0x5e9cd30, old_data=0x5e9d470 "\374\b", new_data=0x5e9d140 "\374\b") at /usr/local/mysql/sql/handler.cc:8103
#14 0x00000000015e7de5 in mysql_update (thd=0x681ef00, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f21bc2ae428, updated_return=0x7f21bc2ae420) at /usr/local/mysql/sql/sql_update.cc:888
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x5ec3398, thd=0x681ef00, switch_to_multitable=0x7f21bc2ae4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x5ec3398, thd=0x681ef00) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x681ef00, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x681ef00, parser_state=0x7f21bc2af690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x681ef00, com_data=0x7f21bc2afdf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x681ef00) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x5dd00f0) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f2fdb0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007f21e433fea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007f21e32059fd in clone () from /lib64/libc.so.6
