
begin;
select * from t1 where c>=10 and c<=11 for update;


1. 初始化表结构和数据
2. b lock_rec_lock
3. 二级索引等值更新加锁
	3.1 RC隔离级别
	3.2 RR隔离级别
4. 小结




1. 初始化表结构和数据

	CREATE TABLE `t3` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;
	insert into t3 values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);

	mysql> select * from t3;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  0 |    0 |    0 |
	|  5 |    5 |    5 |
	| 10 |   10 |   10 |
	| 15 |   15 |   15 |
	| 20 |   20 |   20 |
	| 25 |   25 |   25 |
	+----+------+------+
	6 rows in set (0.00 sec)


2. b lock_rec_lock
	你可以通过GDB，断点函数 lock_rec_lock 来查看某条SQL如何执行加锁操作。


3. 二级索引等值更新加锁


3.2 RR隔离级别	

	mysql> show global variables like 'tx_isolation';
	+---------------+-----------------+
	| Variable_name | Value           |
	+---------------+-----------------+
	| tx_isolation  | REPEATABLE-READ |
	+---------------+-----------------+
	1 row in set (0.03 sec)
	
	
	begin;
	select * from t3 where c>=10 and c<11 for update;

	mysql> desc select * from t3 where c>=10 and c<11 for update;
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | t3    | NULL       | range | c             | c    | 5       | NULL |    1 |   100.00 | Using index condition |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)



	(gdb) b lock_rec_lock_fast
	Breakpoint 2 at 0x1942d51: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 1871.
	(gdb) b lock_rec_lock_slow
	Breakpoint 3 at 0x1943191: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 1952.
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f4e0eff5700 (LWP 4876)]

	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=3, block=0x7f4e3fa471b0, heap_no=4, index=0x7f4e2c94fa10, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=3, block=0x7f4e3fa471b0, heap_no=4, index=0x7f4e2c94fa10, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=3, block=0x7f4e3fa471b0, heap_no=4, index=0x7f4e2c94fa10, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	-- 锁二级索引的记录
	#2  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7f4e3fa471b0, rec=0x7f4e40bf809a "\200", index=0x7f4e2c94fa10, offsets=0x7f4e0eff1d60, mode=LOCK_X, gap_mode=0, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#3  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7f4e2c95a0a0, rec=0x7f4e40bf809a "\200", index=0x7f4e2c94fa10, offsets=0x7f4e0eff1d60, mode=3, type=0, thr=0x7f4e2c95a620, mtr=0x7f4e0eff2080) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x7f4e2c9598e0 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f4e2c959e80, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\377", key_ptr=0x7f4e2c95dec0 "", key_len=5, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\377", key=0x7f4e2c95dec0 "", keypart_map=1, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\377", key=0x7f4e2c95dec0 "", keypart_map=1, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x0000000000f34e8f in handler::read_range_first (this=0x7f4e2c9595f0, start_key=0x7f4e2c9596d8, end_key=0x7f4e2c9596f8, eq_range_arg=false, sorted=false) at /usr/local/mysql/sql/handler.cc:7383
	#9  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f4e2c9595f0, range_info=0x7f4e0eff3110) at /usr/local/mysql/sql/handler.cc:6450
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f4e2c959850, range_info=0x7f4e0eff3110) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f4e2c9595f0, range_info=0x7f4e0eff3110) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f4e2c958400) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x7f4e2c95be40) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000014f0090 in join_init_read_record (tab=0x7f4e2c95bdf0) at /usr/local/mysql/sql/sql_executor.cc:2497
	#15 0x00000000014ed267 in sub_select (join=0x7f4e2c95b220, qep_tab=0x7f4e2c95bdf0, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#16 0x00000000014ecbfa in do_select (join=0x7f4e2c95b220) at /usr/local/mysql/sql/sql_executor.cc:950
	#17 0x00000000014eab61 in JOIN::exec (this=0x7f4e2c95b220) at /usr/local/mysql/sql/sql_executor.cc:199
	#18 0x0000000001583b64 in handle_query (thd=0x7f4e2c01c2e0, lex=0x7f4e2c01e600, result=0x7f4e2c00c558, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#19 0x000000000153996f in execute_sqlcom_select (thd=0x7f4e2c01c2e0, all_tables=0x7f4e2c00b990) at /usr/local/mysql/sql/sql_parse.cc:5144
	#20 0x000000000153339d in mysql_execute_command (thd=0x7f4e2c01c2e0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#21 0x000000000153a849 in mysql_parse (thd=0x7f4e2c01c2e0, parser_state=0x7f4e0eff4690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#22 0x00000000015302d8 in dispatch_command (thd=0x7f4e2c01c2e0, com_data=0x7f4e0eff4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#23 0x000000000152f20c in do_command (thd=0x7f4e2c01c2e0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#24 0x000000000165f7c8 in handle_connection (arg=0x45a0c10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#25 0x0000000001ce7612 in pfs_spawn_thread (arg=0x49acd60) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#26 0x00007f4e5878eea5 in start_thread () from /lib64/libpthread.so.0
	#27 0x00007f4e576549fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.
		
		函数调用栈：
			ha_innobase::index_read
				->row_search_mvcc
					->sel_set_rec_lock
						->lock_sec_rec_read_check_and_lock
							->lock_rec_lock
								->lock_rec_lock_fast
		
	
	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=1027, block=0x7f4e3fa46e88, heap_no=4, index=0x7f4e2c94ec30, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=1027, block=0x7f4e3fa46e88, heap_no=4, index=0x7f4e2c94ec30, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1027, block=0x7f4e3fa46e88, heap_no=4, index=0x7f4e2c94ec30, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- gap_mode=1024：#define LOCK_REC_NOT_GAP  1024 。行锁。
	-- 锁主键索引的记录
	#2  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f4e3fa46e88, rec=0x7f4e40bf40bc "\200", index=0x7f4e2c94ec30, offsets=0x7f4e0eff1d60, mode=LOCK_X, gap_mode=1024, thr=0x7f4e2c95a620)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#3  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7f4e2c959e80, sec_index=0x7f4e2c94fa10, rec=0x7f4e40bf809a "\200", thr=0x7f4e2c95a620, out_rec=0x7f4e0eff25f0, offsets=0x7f4e0eff25c8, offset_heap=0x7f4e0eff25d0, vrow=0x0, mtr=0x7f4e0eff2080)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#4  0x0000000001a4f94a in row_search_mvcc (buf=0x7f4e2c9598e0 "\375\n", mode=PAGE_CUR_GE, prebuilt=0x7f4e2c959e80, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\375\n", key_ptr=0x7f4e2c95dec0 "", key_len=5, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\375\n", key=0x7f4e2c95dec0 "", keypart_map=1, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\375\n", key=0x7f4e2c95dec0 "", keypart_map=1, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x0000000000f34e8f in handler::read_range_first (this=0x7f4e2c9595f0, start_key=0x7f4e2c9596d8, end_key=0x7f4e2c9596f8, eq_range_arg=false, sorted=false) at /usr/local/mysql/sql/handler.cc:7383
	#9  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f4e2c9595f0, range_info=0x7f4e0eff3110) at /usr/local/mysql/sql/handler.cc:6450
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f4e2c959850, range_info=0x7f4e0eff3110) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f4e2c9595f0, range_info=0x7f4e0eff3110) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f4e2c958400) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x7f4e2c95be40) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000014f0090 in join_init_read_record (tab=0x7f4e2c95bdf0) at /usr/local/mysql/sql/sql_executor.cc:2497
	#15 0x00000000014ed267 in sub_select (join=0x7f4e2c95b220, qep_tab=0x7f4e2c95bdf0, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#16 0x00000000014ecbfa in do_select (join=0x7f4e2c95b220) at /usr/local/mysql/sql/sql_executor.cc:950
	#17 0x00000000014eab61 in JOIN::exec (this=0x7f4e2c95b220) at /usr/local/mysql/sql/sql_executor.cc:199
	#18 0x0000000001583b64 in handle_query (thd=0x7f4e2c01c2e0, lex=0x7f4e2c01e600, result=0x7f4e2c00c558, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#19 0x000000000153996f in execute_sqlcom_select (thd=0x7f4e2c01c2e0, all_tables=0x7f4e2c00b990) at /usr/local/mysql/sql/sql_parse.cc:5144
	#20 0x000000000153339d in mysql_execute_command (thd=0x7f4e2c01c2e0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#21 0x000000000153a849 in mysql_parse (thd=0x7f4e2c01c2e0, parser_state=0x7f4e0eff4690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#22 0x00000000015302d8 in dispatch_command (thd=0x7f4e2c01c2e0, com_data=0x7f4e0eff4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#23 0x000000000152f20c in do_command (thd=0x7f4e2c01c2e0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#24 0x000000000165f7c8 in handle_connection (arg=0x45a0c10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#25 0x0000000001ce7612 in pfs_spawn_thread (arg=0x49acd60) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#26 0x00007f4e5878eea5 in start_thread () from /lib64/libpthread.so.0
	#27 0x00007f4e576549fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

		函数调用栈：
			ha_innobase::index_read
				->row_search_mvcc
					->row_sel_get_clust_rec_for_mysql
						->lock_clust_rec_read_check_and_lock
							->lock_rec_lock
								->lock_rec_lock_fast
	
	
	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=3, block=0x7f4e3fa471b0, heap_no=5, index=0x7f4e2c94fa10, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=3, block=0x7f4e3fa471b0, heap_no=5, index=0x7f4e2c94fa10, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=3, block=0x7f4e3fa471b0, heap_no=5, index=0x7f4e2c94fa10, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	-- 锁二级索引的记录
	#2  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7f4e3fa471b0, rec=0x7f4e40bf80a8 "\200", index=0x7f4e2c94fa10, offsets=0x7f4e0eff1e10, mode=LOCK_X, gap_mode=0, thr=0x7f4e2c95a620) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#3  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7f4e2c95a0a0, rec=0x7f4e40bf80a8 "\200", index=0x7f4e2c94fa10, offsets=0x7f4e0eff1e10, mode=3, type=0, thr=0x7f4e2c95a620, mtr=0x7f4e0eff2130) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x7f4e2c9598e0 "\371\n", mode=PAGE_CUR_GE, prebuilt=0x7f4e2c959e80, match_mode=0, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#5  0x00000000018c249a in ha_innobase::general_fetch (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\371\n", direction=1, match_mode=0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
	#6  0x00000000018c26c3 in ha_innobase::index_next (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\371\n") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9109
	#7  0x0000000000f2bec4 in handler::ha_index_next (this=0x7f4e2c9595f0, buf=0x7f4e2c9598e0 "\371\n") at /usr/local/mysql/sql/handler.cc:3125
	#8  0x0000000000f34fc7 in handler::read_range_next (this=0x7f4e2c9595f0) at /usr/local/mysql/sql/handler.cc:7430
	#9  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7f4e2c9595f0, range_info=0x7f4e0eff3140) at /usr/local/mysql/sql/handler.cc:6429
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f4e2c959850, range_info=0x7f4e0eff3140) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f4e2c9595f0, range_info=0x7f4e0eff3140) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f4e2c958400) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x7f4e2c95be40) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000014ed27d in sub_select (join=0x7f4e2c95b220, qep_tab=0x7f4e2c95bdf0, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1280
	#15 0x00000000014ecbfa in do_select (join=0x7f4e2c95b220) at /usr/local/mysql/sql/sql_executor.cc:950
	#16 0x00000000014eab61 in JOIN::exec (this=0x7f4e2c95b220) at /usr/local/mysql/sql/sql_executor.cc:199
	#17 0x0000000001583b64 in handle_query (thd=0x7f4e2c01c2e0, lex=0x7f4e2c01e600, result=0x7f4e2c00c558, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#18 0x000000000153996f in execute_sqlcom_select (thd=0x7f4e2c01c2e0, all_tables=0x7f4e2c00b990) at /usr/local/mysql/sql/sql_parse.cc:5144
	#19 0x000000000153339d in mysql_execute_command (thd=0x7f4e2c01c2e0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#20 0x000000000153a849 in mysql_parse (thd=0x7f4e2c01c2e0, parser_state=0x7f4e0eff4690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#21 0x00000000015302d8 in dispatch_command (thd=0x7f4e2c01c2e0, com_data=0x7f4e0eff4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#22 0x000000000152f20c in do_command (thd=0x7f4e2c01c2e0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#23 0x000000000165f7c8 in handle_connection (arg=0x45a0c10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#24 0x0000000001ce7612 in pfs_spawn_thread (arg=0x49acd60) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#25 0x00007f4e5878eea5 in start_thread () from /lib64/libpthread.so.0
	#26 0x00007f4e576549fd in clone () from /lib64/libc.so.6


		
		函数调用栈：
			ha_innobase::index_next
				->ha_innobase::general_fetch
					->row_search_mvcc
						->sel_set_rec_lock
							->lock_sec_rec_read_check_and_lock
								->lock_rec_lock
									->lock_rec_lock_fast
	
	
4. 小结


	1. 函数调用栈：

		二级索引：
			ha_innobase::index_read
				->row_search_mvcc
					->sel_set_rec_lock
						->lock_sec_rec_read_check_and_lock
							->lock_rec_lock
								->lock_rec_lock_fast
		主键索引:
		
			ha_innobase::index_read
				->row_search_mvcc
					->row_sel_get_clust_rec_for_mysql
						->lock_clust_rec_read_check_and_lock
							->lock_rec_lock
								->lock_rec_lock_fast


		
		二级索引：
		
			ha_innobase::index_next
			->ha_innobase::general_fetch
				->row_search_mvcc
					->sel_set_rec_lock
						->lock_sec_rec_read_check_and_lock
							->lock_rec_lock
								->lock_rec_lock_fast	
	2. 语句的加锁范围

		c: next-key lock: (5, 10]
		primary: record lock: [10]
		c: next-key lock: (10, 15]