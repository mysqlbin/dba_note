	
1. 初始化表结构和数据

	mysql> show create table hero\G;
	*************************** 1. row ***************************
		   Table: hero
	Create Table: CREATE TABLE `hero` (
	  `number` int(11) NOT NULL,
	  `name` varchar(100) DEFAULT NULL,
	  `country` varchar(100) DEFAULT NULL,
	  PRIMARY KEY (`number`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
	1 row in set (0.01 sec)

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




2. b lock_rec_lock
	你可以通过GDB，断点函数 lock_rec_lock 来查看某条SQL如何执行加锁操作。


3. 主键索引范围查询加锁

	SELECT * FROM hero WHERE number <= 8 LOCK IN SHARE MODE;

	session A       																session B                                                           
														  
	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
																					BEGIN;		
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f29841bc700 (LWP 6580)]
																					
																					SELECT * FROM hero WHERE number <= 8 LOCK IN SHARE MODE;

	Breakpoint 2, lock_rec_lock (impl=false, mode=1026, block=0x7f2993520838, heap_no=2, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1026, block=0x7f2993520838, heap_no=2, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8080 "\200", index=0x5a744d0, offsets=0x7f29841b8d80, mode=LOCK_S, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c8080 "\200", index=0x5a744d0, offsets=0x7f29841b8d80, mode=2, type=1024, thr=0x7f296c011568, mtr=0x7f29841b90a0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f296c010250 "\377", mode=PAGE_CUR_G, prebuilt=0x7f296c010dd0, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key_ptr=0x0, key_len=0, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x00000000018c27ba in ha_innobase::index_first (this=0x7f296c00fe40, buf=0x7f296c010250 "\377") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9157
	#6  0x0000000000f2c4b3 in handler::ha_index_first (this=0x7f296c00fe40, buf=0x7f296c010250 "\377") at /usr/local/mysql/sql/handler.cc:3193
	#7  0x0000000000f34e59 in handler::read_range_first (this=0x7f296c00fe40, start_key=0x0, end_key=0x7f296c00ff48, eq_range_arg=false, sorted=false) at /usr/local/mysql/sql/handler.cc:7378
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f296c00fe40, range_info=0x7f29841ba110) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f296c0100a0, range_info=0x7f29841ba110) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f296c00fe40, range_info=0x7f29841ba110) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f296c00ee80) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7f296c01ce58) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000014f0090 in join_init_read_record (tab=0x7f296c01ce08) at /usr/local/mysql/sql/sql_executor.cc:2497
	#14 0x00000000014ed267 in sub_select (join=0x7f296c01c8f0, qep_tab=0x7f296c01ce08, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#15 0x00000000014ecbfa in do_select (join=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_executor.cc:950
	#16 0x00000000014eab61 in JOIN::exec (this=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_executor.cc:199
	#17 0x0000000001583b64 in handle_query (thd=0x7f296c0011c0, lex=0x7f296c0034e0, result=0x7f296c007748, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#18 0x000000000153996f in execute_sqlcom_select (thd=0x7f296c0011c0, all_tables=0x7f296c006e40) at /usr/local/mysql/sql/sql_parse.cc:5144
	#19 0x000000000153339d in mysql_execute_command (thd=0x7f296c0011c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#20 0x000000000153a849 in mysql_parse (thd=0x7f296c0011c0, parser_state=0x7f29841bb690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#21 0x00000000015302d8 in dispatch_command (thd=0x7f296c0011c0, com_data=0x7f29841bbdf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#22 0x000000000152f20c in do_command (thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#23 0x000000000165f7c8 in handle_connection (arg=0x3d33690) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#24 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3d7fae0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#25 0x00007f29abac5ea5 in start_thread () from /lib64/libpthread.so.0
	#26 0x00007f29aa98b9fd in clone () from /lib64/libc.so.6

--------------------------------------------------------------------------------------------------------------------------

4. 主键索引等值查询加锁

	SELECT * FROM hero WHERE number = 15 FOR UPDATE;


	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
																								begin;

	(gdb) c
	Continuing.
	[Switching to Thread 0x7f29841bc700 (LWP 6580)]
																								SELECT * FROM hero WHERE number = 15 FOR UPDATE;
	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=5, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=5, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c80ec "\200", index=0x5a744d0, offsets=0x7f29841b8ad0, mode=LOCK_X, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c80ec "\200", index=0x5a744d0, offsets=0x7f29841b8ad0, mode=3, type=1024, thr=0x7f296c011568, mtr=0x7f29841b8df0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f296c010250 "\374\017", mode=PAGE_CUR_GE, prebuilt=0x7f296c010dd0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f296c00fe40, buf=0x7f296c010250 "\374\017", key_ptr=0x7f296c007e88 "\017", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\374\017", key=0x7f296c007e88 "\017", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f35421 in handler::index_read_idx_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\374\017", index=0, key=0x7f296c007e88 "\017", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:7590
	#7  0x0000000000f2ba86 in handler::ha_index_read_idx_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\374\017", index=0, key=0x7f296c007e88 "\017", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3091
	#8  0x00000000014eedd1 in read_const (table=0x7f296c00f480, ref=0x7f296c01cd98) at /usr/local/mysql/sql/sql_executor.cc:2013
	#9  0x00000000014ee8b4 in join_read_const_table (tab=0x7f296c01ccc8, pos=0x7f296c01ce40) at /usr/local/mysql/sql/sql_executor.cc:1898
	#10 0x000000000151a6ef in JOIN::extract_func_dependent_tables (this=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_optimizer.cc:5594
	#11 0x0000000001519191 in JOIN::make_join_plan (this=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_optimizer.cc:5058
	#12 0x000000000150db30 in JOIN::optimize (this=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_optimizer.cc:368
	#13 0x0000000001585390 in st_select_lex::optimize (this=0x7f296c005f40, thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_select.cc:1009
	#14 0x0000000001583aec in handle_query (thd=0x7f296c0011c0, lex=0x7f296c0034e0, result=0x7f296c007738, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:164
	#15 0x000000000153996f in execute_sqlcom_select (thd=0x7f296c0011c0, all_tables=0x7f296c006e30) at /usr/local/mysql/sql/sql_parse.cc:5144
	#16 0x000000000153339d in mysql_execute_command (thd=0x7f296c0011c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#17 0x000000000153a849 in mysql_parse (thd=0x7f296c0011c0, parser_state=0x7f29841bb690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f296c0011c0, com_data=0x7f29841bbdf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x3d33690) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3d7fae0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f29abac5ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f29aa98b9fd in clone () from /lib64/libc.so.6

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

5. 主键索引等值更新加锁

	UPDATE hero SET name = '曹操' WHERE number = 8;
	
	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
																						begin;
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f29841bc700 (LWP 6580)]
																						UPDATE hero SET name = '曹操' WHERE number = 8;

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=7, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=7, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8132 "\200", index=0x5a744d0, offsets=0x7f29841b8880, mode=LOCK_X, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c8132 "\200", index=0x5a744d0, offsets=0x7f29841b8880, mode=3, type=1024, thr=0x7f296c011568, mtr=0x7f29841b8ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f296c010250 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f296c010dd0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key_ptr=0x7f296c427040 "\b", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key=0x7f296c427040 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key=0x7f296c427040 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x7f296c00fe40, start_key=0x7f296c00ff28, end_key=0x7f296c00ff48, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f296c00fe40, range_info=0x7f29841b9c30) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f296c0100a0, range_info=0x7f29841b9c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f296c00fe40, range_info=0x7f29841b9c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f296c00ee40) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7f29841b9dd0) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000015e7b84 in mysql_update (thd=0x7f296c0011c0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f29841ba428, updated_return=0x7f29841ba420) at /usr/local/mysql/sql/sql_update.cc:812
	#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f296c006e18, thd=0x7f296c0011c0, switch_to_multitable=0x7f29841ba4cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f296c006e18, thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_update.cc:3018
	#16 0x00000000015351f1 in mysql_execute_command (thd=0x7f296c0011c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#17 0x000000000153a849 in mysql_parse (thd=0x7f296c0011c0, parser_state=0x7f29841bb690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f296c0011c0, com_data=0x7f29841bbdf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x3d33690) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3d7fae0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f29abac5ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f29aa98b9fd in clone () from /lib64/libc.so.6


	(gdb) n
	2041		ut_ad(!srv_read_only_mode);
	(gdb) n
	2042		ut_ad((LOCK_MODE_MASK & mode) != LOCK_S
	(gdb) n
	2044		ut_ad((LOCK_MODE_MASK & mode) != LOCK_X
	(gdb) n
	2046		ut_ad((LOCK_MODE_MASK & mode) == LOCK_S
	(gdb) n
	2048		ut_ad(mode - (LOCK_MODE_MASK & mode) == LOCK_GAP
	(gdb) n
	2051		ut_ad(dict_index_is_clust(index) || !dict_index_is_online_ddl(index));
	(gdb) n
	2055		switch (lock_rec_lock_fast(impl, mode, block, heap_no, index, thr)) {      -- 快速加锁
	(gdb) n
	2059			return(DB_SUCCESS_LOCKED_REC);    -- 加锁成功。
	(gdb) n
	2067	}
	(gdb) n
	lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8132 "\200", index=0x5a744d0, offsets=0x7f29841b8880, mode=LOCK_X, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6416
	6416		MONITOR_INC(MONITOR_NUM_RECLOCK_REQ);
	(gdb) n
	6418		lock_mutex_exit();
	(gdb) n
	6420		ut_ad(lock_rec_queue_validate(FALSE, block, rec, index, offsets));
	(gdb) n
	6422		DEBUG_SYNC_C("after_lock_clust_rec_read_check_and_lock");
	(gdb) n
	6424		return(err);
	(gdb) n
	6425	}
	(gdb) n
	sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c8132 "\200", index=0x5a744d0, offsets=0x7f29841b8880, mode=3, type=1024, thr=0x7f296c011568, mtr=0x7f29841b8ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1273
	1273		return(err);
	(gdb) n
	1274	}
	(gdb) n
	row_search_mvcc (buf=0x7f296c010250 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f296c010dd0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5526
	5526			switch (err) {
	(gdb) n
	5529				if (srv_locks_unsafe_for_binlog



6. 二级索引等值查询加锁

	begin;
	SELECT * FROM hero WHERE name = 'c曹操' LOCK IN SHARE MODE;

	
