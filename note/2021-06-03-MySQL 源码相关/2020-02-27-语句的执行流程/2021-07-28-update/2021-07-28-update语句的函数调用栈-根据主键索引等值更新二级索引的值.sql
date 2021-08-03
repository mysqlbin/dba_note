
1. 根据主键索引等值更新二级索引的值
	1.1 原地更新
	1.2 非原地更新-先delete再insert


	
1. 根据主键索引等值更新二级索引的值
	
1.1 原地更新

	mysql> desc update hero set name='a曹操' where number=8;
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------------+
	|  1 | UPDATE      | hero  | NULL       | range | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | Using where |
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------------+
	1 row in set (0.00 sec)
	

	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fd2e4266700 (LWP 4308)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd2f3a46b60, heap_no=12, index=0x7fd2fc014230, thr=0x527b2d8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd2f3a46b60, heap_no=12, index=0x7fd2fc014230, thr=0x527b2d8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- gap_mode=1024：#define LOCK_REC_NOT_GAP  1024 。行锁。
	-- mode=LOCK_X，再锁主键索引的记录
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a46b60, rec=0x7fd2f4bf01e2 "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262880, mode=LOCK_X, gap_mode=1024, thr=0x527b2d8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x527ad58, rec=0x7fd2f4bf01e2 "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262880, mode=3, type=1024, thr=0x527b2d8, mtr=0x7fd2e4262ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x527a020 "\377", mode=PAGE_CUR_GE, prebuilt=0x527ab40, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x5bdefc0, buf=0x527a020 "\377", key_ptr=0x5bf35b0 "\b", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x5bdefc0, buf=0x527a020 "\377", key=0x5bf35b0 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x5bdefc0, buf=0x527a020 "\377", key=0x5bf35b0 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x5bdefc0, start_key=0x5bdf0a8, end_key=0x5bdf0c8, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x5bdefc0, range_info=0x7fd2e4263c30) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5bdf220, range_info=0x7fd2e4263c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5bdefc0, range_info=0x7fd2e4263c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x52639a0) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7fd2e4263dd0) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000015e7b84 in mysql_update (thd=0x5295660, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd2e4264428, updated_return=0x7fd2e4264420) at /usr/local/mysql/sql/sql_update.cc:812
	#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x526e328, thd=0x5295660, switch_to_multitable=0x7fd2e42644cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x526e328, thd=0x5295660) at /usr/local/mysql/sql/sql_update.cc:3018
	#16 0x00000000015351f1 in mysql_execute_command (thd=0x5295660, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#17 0x000000000153a849 in mysql_parse (thd=0x5295660, parser_state=0x7fd2e4265690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x5295660, com_data=0x7fd2e4265df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x5295660) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x4f93910) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4305a40) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

		
	Breakpoint 2, lock_rec_lock (impl=true, mode=1027, block=0x7fd2f3a3c740, heap_no=4, index=0x7fd2fc014dd0, thr=0x527b6d8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=true, mode=1027, block=0x7fd2f3a3c740, heap_no=4, index=0x7fd2fc014dd0, thr=0x527b6d8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- 对二级索引的记录加锁，用于update语句更新的时候有更新二级索引的数据
	-- 检查二级索引记录上的锁（lock_sec_rec_modify_check_and_lock），如果存在和LOCK_X | LOCK_REC_NOT_GAP冲突的锁对象，则创建锁对象并返回等待错误码；否则无需创建锁对象；
	#1  0x000000000194d35a in lock_sec_rec_modify_check_and_lock (flags=0, block=0x7fd2f3a3c740, rec=0x7fd2f4b200a6 "l曹操\200", index=0x7fd2fc014dd0, thr=0x527b6d8, mtr=0x7fd2e4262fc0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6239
	#2  0x0000000001b258bf in btr_cur_del_mark_set_sec_rec (flags=0, cursor=0x7fd2e4262ec0, val=1, thr=0x527b6d8, mtr=0x7fd2e4262fc0) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:4967
	#3  0x0000000001a72450 in row_upd_sec_index_entry (node=0x527b3a0, thr=0x527b6d8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2298
	#4  0x0000000001a7273f in row_upd_sec_step (node=0x527b3a0, thr=0x527b6d8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2366
	#5  0x0000000001a74388 in row_upd (node=0x527b3a0, thr=0x527b6d8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3075
	#6  0x0000000001a746e1 in row_upd_step (thr=0x527b6d8) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#7  0x0000000001a13464 in row_update_for_mysql_using_upd_graph (mysql_rec=0x527a350 "\374\b", prebuilt=0x527ab40) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2574
	#8  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x527a350 "\374\b", prebuilt=0x527ab40) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
	#9  0x00000000018c07e6 in ha_innobase::update_row (this=0x5bdefc0, old_row=0x527a350 "\374\b", new_row=0x527a020 "\374\b") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8243
	#10 0x0000000000f36c43 in handler::ha_update_row (this=0x5bdefc0, old_data=0x527a350 "\374\b", new_data=0x527a020 "\374\b") at /usr/local/mysql/sql/handler.cc:8103
	#11 0x00000000015e7de5 in mysql_update (thd=0x5295660, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd2e4264428, updated_return=0x7fd2e4264420) at /usr/local/mysql/sql/sql_update.cc:888
	#12 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x526e328, thd=0x5295660, switch_to_multitable=0x7fd2e42644cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#13 0x00000000015ee453 in Sql_cmd_update::execute (this=0x526e328, thd=0x5295660) at /usr/local/mysql/sql/sql_update.cc:3018
	#14 0x00000000015351f1 in mysql_execute_command (thd=0x5295660, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#15 0x000000000153a849 in mysql_parse (thd=0x5295660, parser_state=0x7fd2e4265690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x5295660, com_data=0x7fd2e4265df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x5295660) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x4f93910) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4305a40) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6



	主键索引
		row_search_mvcc
			->sel_set_rec_lock
				->lock_clust_rec_read_check_and_lock
					->lock_rec_lock
				
	二级索引		
		ha_innobase::update_row
			->row_update_for_mysql
				->row_update_for_mysql_using_upd_graph
					->row_upd_step
						->row_upd
							->row_upd_sec_step
								->row_upd_sec_index_entry
									->btr_cur_del_mark_set_sec_rec
										->lock_sec_rec_modify_check_and_lock
											->lock_rec_lock
					
	row_upd_sec_step： 如果在行更新中更改了二级索引记录，则更新二级索引记录或如果这是删除，则删除它。
	

1.2 非原地更新-先delete再insert


	update hero set name='a曹操bb' where number=8;

	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fd2e4266700 (LWP 4308)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd2f3a46b60, heap_no=12, index=0x7fd2fc014230, thr=0x5bef248) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd2f3a46b60, heap_no=12, index=0x7fd2fc014230, thr=0x5bef248) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a46b60, rec=0x7fd2f4bf01e2 "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262880, mode=LOCK_X, gap_mode=1024, thr=0x5bef248) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x5beecc8, rec=0x7fd2f4bf01e2 "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262880, mode=3, type=1024, thr=0x5bef248, mtr=0x7fd2e4262ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x5bedf90 "\377", mode=PAGE_CUR_GE, prebuilt=0x5beeab0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x5bedb80, buf=0x5bedf90 "\377", key_ptr=0x5bfd550 "\b", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x5bedb80, buf=0x5bedf90 "\377", key=0x5bfd550 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x5bedb80, buf=0x5bedf90 "\377", key=0x5bfd550 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x5bedb80, start_key=0x5bedc68, end_key=0x5bedc88, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x5bedb80, range_info=0x7fd2e4263c30) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5bedde0, range_info=0x7fd2e4263c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5bedb80, range_info=0x7fd2e4263c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x51febc0) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7fd2e4263dd0) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000015e7b84 in mysql_update (thd=0x5295660, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd2e4264428, updated_return=0x7fd2e4264420) at /usr/local/mysql/sql/sql_update.cc:812
	#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x526e330, thd=0x5295660, switch_to_multitable=0x7fd2e42644cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x526e330, thd=0x5295660) at /usr/local/mysql/sql/sql_update.cc:3018
	#16 0x00000000015351f1 in mysql_execute_command (thd=0x5295660, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#17 0x000000000153a849 in mysql_parse (thd=0x5295660, parser_state=0x7fd2e4265690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x5295660, com_data=0x7fd2e4265df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x5295660) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x4f93910) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4305a40) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=true, mode=1027, block=0x7fd2f3a3c740, heap_no=8, index=0x7fd2fc014dd0, thr=0x5bef648) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=true, mode=1027, block=0x7fd2f3a3c740, heap_no=8, index=0x7fd2fc014dd0, thr=0x5bef648) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194d35a in lock_sec_rec_modify_check_and_lock (flags=0, block=0x7fd2f3a3c740, rec=0x7fd2f4b200ed "a曹操\200", index=0x7fd2fc014dd0, thr=0x5bef648, mtr=0x7fd2e4262fc0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6239
	#2  0x0000000001b258bf in btr_cur_del_mark_set_sec_rec (flags=0, cursor=0x7fd2e4262ec0, val=1, thr=0x5bef648, mtr=0x7fd2e4262fc0) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:4967
	#3  0x0000000001a72450 in row_upd_sec_index_entry (node=0x5bef310, thr=0x5bef648) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2298
	#4  0x0000000001a7273f in row_upd_sec_step (node=0x5bef310, thr=0x5bef648) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2366
	#5  0x0000000001a74388 in row_upd (node=0x5bef310, thr=0x5bef648) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3075
	#6  0x0000000001a746e1 in row_upd_step (thr=0x5bef648) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#7  0x0000000001a13464 in row_update_for_mysql_using_upd_graph (mysql_rec=0x5bee2c0 "\374\b", prebuilt=0x5beeab0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2574
	#8  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x5bee2c0 "\374\b", prebuilt=0x5beeab0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
	#9  0x00000000018c07e6 in ha_innobase::update_row (this=0x5bedb80, old_row=0x5bee2c0 "\374\b", new_row=0x5bedf90 "\374\b") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8243
	#10 0x0000000000f36c43 in handler::ha_update_row (this=0x5bedb80, old_data=0x5bee2c0 "\374\b", new_data=0x5bedf90 "\374\b") at /usr/local/mysql/sql/handler.cc:8103
	#11 0x00000000015e7de5 in mysql_update (thd=0x5295660, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd2e4264428, updated_return=0x7fd2e4264420) at /usr/local/mysql/sql/sql_update.cc:888
	#12 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x526e330, thd=0x5295660, switch_to_multitable=0x7fd2e42644cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#13 0x00000000015ee453 in Sql_cmd_update::execute (this=0x526e330, thd=0x5295660) at /usr/local/mysql/sql/sql_update.cc:3018
	#14 0x00000000015351f1 in mysql_execute_command (thd=0x5295660, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#15 0x000000000153a849 in mysql_parse (thd=0x5295660, parser_state=0x7fd2e4265690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x5295660, com_data=0x7fd2e4265df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x5295660) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x4f93910) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4305a40) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6

	

	主键索引
		row_search_mvcc
			->sel_set_rec_lock
				->lock_clust_rec_read_check_and_lock
					->lock_rec_lock
				
	二级索引		
		ha_innobase::update_row
			->row_update_for_mysql
				->row_update_for_mysql_using_upd_graph
					->row_upd_step
						->row_upd
							->row_upd_sec_step
								->row_upd_sec_index_entry
									->btr_cur_del_mark_set_sec_rec
										->lock_sec_rec_modify_check_and_lock
											->lock_rec_lock

		-- 二级索引先delete再insert, 其中delete也是打删除标记。
		

		
参考：《2021-07-05-加锁过程的函数调用栈-根据主键索引等值更新二级索引的值.sql》
	