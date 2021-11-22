
1. 初始化表结构和数据
2. 用 lock in share mode 锁二级索引的记录--不需要回表
3. 用 lock in share mode 锁二级索引的记录--需要回表
4. 用 for update 锁二级索引的记录--需要回表

1. 初始化表结构和数据

	CREATE TABLE `t_20210802` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;
	insert into t_20210802 values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);
		
	begin;
	select id from t_20210802 where c=5 lock in share mode;
	 
	mysql> show global variables like 'tx_isolation';
	+---------------+----------------+
	| Variable_name | Value          |
	+---------------+----------------+
	| tx_isolation  | READ-COMMITTED |
	+---------------+----------------+
	1 row in set (0.01 sec)


2. 用 lock in share mode 锁二级索引的记录--不需要回表

	b lock_rec_lock


	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fc0700e7700 (LWP 4257)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509b16f0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509b16f0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fc063a3e6d0, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=LOCK_S, gap_mode=1024, thr=0x7fc0509b16f0)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fc0509b1170, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=2, type=1024, thr=0x7fc0509b16f0, mtr=0x7fc0700e4200) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fc0509b09b0 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509b0f50, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc0509b06c0, buf=0x7fc0509b09b0 <incomplete sequence \375>, key_ptr=0x7fc05001e298 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7fc0509b06c0, buf=0x7fc0509b09b0 <incomplete sequence \375>, key=0x7fc05001e298 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc0509b06c0, buf=0x7fc0509b09b0 <incomplete sequence \375>, key=0x7fc05001e298 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509b2ef0) at /usr/local/mysql/sql/sql_executor.cc:2275
	#8  0x00000000014ed267 in sub_select (join=0x7fc05001de28, qep_tab=0x7fc0509b2ef0, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#9  0x00000000014ecbfa in do_select (join=0x7fc05001de28) at /usr/local/mysql/sql/sql_executor.cc:950
	#10 0x00000000014eab61 in JOIN::exec (this=0x7fc05001de28) at /usr/local/mysql/sql/sql_executor.cc:199
	#11 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001dd08, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#12 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d400) at /usr/local/mysql/sql/sql_parse.cc:5144
	#13 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#14 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#15 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#16 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#17 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#18 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#19 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#20 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509b16f0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509b16f0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509b16f0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	#2  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fc063a3e6d0, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=LOCK_S, gap_mode=1024, thr=0x7fc0509b16f0)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#3  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fc0509b1170, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=2, type=1024, thr=0x7fc0509b16f0, mtr=0x7fc0700e4200) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x7fc0509b09b0 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509b0f50, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc0509b06c0, buf=0x7fc0509b09b0 <incomplete sequence \375>, key_ptr=0x7fc05001e298 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7fc0509b06c0, buf=0x7fc0509b09b0 <incomplete sequence \375>, key=0x7fc05001e298 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc0509b06c0, buf=0x7fc0509b09b0 <incomplete sequence \375>, key=0x7fc05001e298 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509b2ef0) at /usr/local/mysql/sql/sql_executor.cc:2275
	#9  0x00000000014ed267 in sub_select (join=0x7fc05001de28, qep_tab=0x7fc0509b2ef0, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#10 0x00000000014ecbfa in do_select (join=0x7fc05001de28) at /usr/local/mysql/sql/sql_executor.cc:950
	#11 0x00000000014eab61 in JOIN::exec (this=0x7fc05001de28) at /usr/local/mysql/sql/sql_executor.cc:199
	#12 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001dd08, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#13 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d400) at /usr/local/mysql/sql/sql_parse.cc:5144
	#14 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#15 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.


-----------------------------------------------------------------------------------------------------------------------

3. 用 lock in share mode 锁二级索引的记录--需要回表

	begin;
	select * from t_20210802 where c=5 lock in share mode;


	b lock_rec_lock	


	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fc0700e7700 (LWP 4257)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509a0e30) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509a0e30) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- 锁二级索引的记录
	#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fc063a3e6d0, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=LOCK_S, gap_mode=1024, thr=0x7fc0509a0e30)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fc0509a08b0, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=2, type=1024, thr=0x7fc0509a0e30, mtr=0x7fc0700e4200) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fc0509a00f0 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509a0690, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key_ptr=0x7fc05001e2f0 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key=0x7fc05001e2f0 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key=0x7fc05001e2f0 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509a2888) at /usr/local/mysql/sql/sql_executor.cc:2275
	#8  0x00000000014ed267 in sub_select (join=0x7fc0509a16a0, qep_tab=0x7fc0509a2888, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#9  0x00000000014ecbfa in do_select (join=0x7fc0509a16a0) at /usr/local/mysql/sql/sql_executor.cc:950
	#10 0x00000000014eab61 in JOIN::exec (this=0x7fc0509a16a0) at /usr/local/mysql/sql/sql_executor.cc:199
	#11 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001db88, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#12 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d280) at /usr/local/mysql/sql/sql_parse.cc:5144
	#13 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#14 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#15 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#16 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#17 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#18 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#19 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#20 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509a0e30) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509a0e30) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1026, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509a0e30) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	#2  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fc063a3e6d0, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=LOCK_S, gap_mode=1024, thr=0x7fc0509a0e30)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#3  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fc0509a08b0, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=2, type=1024, thr=0x7fc0509a0e30, mtr=0x7fc0700e4200) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x7fc0509a00f0 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509a0690, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key_ptr=0x7fc05001e2f0 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key=0x7fc05001e2f0 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key=0x7fc05001e2f0 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509a2888) at /usr/local/mysql/sql/sql_executor.cc:2275
	#9  0x00000000014ed267 in sub_select (join=0x7fc0509a16a0, qep_tab=0x7fc0509a2888, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#10 0x00000000014ecbfa in do_select (join=0x7fc0509a16a0) at /usr/local/mysql/sql/sql_executor.cc:950
	#11 0x00000000014eab61 in JOIN::exec (this=0x7fc0509a16a0) at /usr/local/mysql/sql/sql_executor.cc:199
	#12 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001db88, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#13 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d280) at /usr/local/mysql/sql/sql_parse.cc:5144
	#14 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#15 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1026, block=0x7fc063a3e3a8, heap_no=3, index=0x7fc050958cb0, thr=0x7fc0509a0e30) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1026, block=0x7fc063a3e3a8, heap_no=3, index=0x7fc050958cb0, thr=0x7fc0509a0e30) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1026, block=0x7fc063a3e3a8, heap_no=3, index=0x7fc050958cb0, thr=0x7fc0509a0e30) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- 锁主键索引的记录
	#2  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fc063a3e3a8, rec=0x7fc064b4409d "\200", index=0x7fc050958cb0, offsets=0x7fc0700e3ee0, mode=LOCK_S, gap_mode=1024, thr=0x7fc0509a0e30)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	-- 回表函数
	#3  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fc0509a0690, sec_index=0x7fc0509598e0, rec=0x7fc064b4808c "\200", thr=0x7fc0509a0e30, out_rec=0x7fc0700e4770, offsets=0x7fc0700e4748, offset_heap=0x7fc0700e4750, vrow=0x0, mtr=0x7fc0700e4200)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#4  0x0000000001a4f94a in row_search_mvcc (buf=0x7fc0509a00f0 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509a0690, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key_ptr=0x7fc05001e2f0 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key=0x7fc05001e2f0 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc05099fe00, buf=0x7fc0509a00f0 <incomplete sequence \375>, key=0x7fc05001e2f0 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509a2888) at /usr/local/mysql/sql/sql_executor.cc:2275
	#9  0x00000000014ed267 in sub_select (join=0x7fc0509a16a0, qep_tab=0x7fc0509a2888, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#10 0x00000000014ecbfa in do_select (join=0x7fc0509a16a0) at /usr/local/mysql/sql/sql_executor.cc:950
	#11 0x00000000014eab61 in JOIN::exec (this=0x7fc0509a16a0) at /usr/local/mysql/sql/sql_executor.cc:199
	#12 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001db88, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#13 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d280) at /usr/local/mysql/sql/sql_parse.cc:5144
	#14 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#15 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

4. 用 for update 锁二级索引的记录--需要回表

	begin;
	select id from t_20210802 where c=5 for update;


	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep n   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fc0700e7700 (LWP 4257)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- 锁二级索引的记录
	#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fc063a3e6d0, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=LOCK_X, gap_mode=1024, thr=0x7fc0509c1fb0)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fc0509c1a30, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=3, type=1024, thr=0x7fc0509c1fb0, mtr=0x7fc0700e4200) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fc0509c1270 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509c1810, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key_ptr=0x7fc0509c3670 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key=0x7fc0509c3670 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key=0x7fc0509c3670 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509c3770) at /usr/local/mysql/sql/sql_executor.cc:2275
	#8  0x00000000014ed267 in sub_select (join=0x7fc05001de18, qep_tab=0x7fc0509c3770, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#9  0x00000000014ecbfa in do_select (join=0x7fc05001de18) at /usr/local/mysql/sql/sql_executor.cc:950
	#10 0x00000000014eab61 in JOIN::exec (this=0x7fc05001de18) at /usr/local/mysql/sql/sql_executor.cc:199
	#11 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001dcf8, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#12 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d3f0) at /usr/local/mysql/sql/sql_parse.cc:5144
	#13 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#14 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#15 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#16 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#17 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#18 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#19 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#20 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1027, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1027, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1027, block=0x7fc063a3e6d0, heap_no=3, index=0x7fc0509598e0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	#2  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fc063a3e6d0, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=LOCK_X, gap_mode=1024, thr=0x7fc0509c1fb0)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#3  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fc0509c1a30, rec=0x7fc064b4808c "\200", index=0x7fc0509598e0, offsets=0x7fc0700e3ee0, mode=3, type=1024, thr=0x7fc0509c1fb0, mtr=0x7fc0700e4200) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x7fc0509c1270 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509c1810, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key_ptr=0x7fc0509c3670 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key=0x7fc0509c3670 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key=0x7fc0509c3670 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509c3770) at /usr/local/mysql/sql/sql_executor.cc:2275
	#9  0x00000000014ed267 in sub_select (join=0x7fc05001de18, qep_tab=0x7fc0509c3770, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#10 0x00000000014ecbfa in do_select (join=0x7fc05001de18) at /usr/local/mysql/sql/sql_executor.cc:950
	#11 0x00000000014eab61 in JOIN::exec (this=0x7fc05001de18) at /usr/local/mysql/sql/sql_executor.cc:199
	#12 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001dcf8, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#13 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d3f0) at /usr/local/mysql/sql/sql_parse.cc:5144
	#14 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#15 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fc063a3e3a8, heap_no=3, index=0x7fc050958cb0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7fc063a3e3a8, heap_no=3, index=0x7fc050958cb0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- 锁主键索引的记录
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fc063a3e3a8, rec=0x7fc064b4409d "\200", index=0x7fc050958cb0, offsets=0x7fc0700e3ee0, mode=LOCK_X, gap_mode=1024, thr=0x7fc0509c1fb0)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fc0509c1810, sec_index=0x7fc0509598e0, rec=0x7fc064b4808c "\200", thr=0x7fc0509c1fb0, out_rec=0x7fc0700e4770, offsets=0x7fc0700e4748, offset_heap=0x7fc0700e4750, vrow=0x0, mtr=0x7fc0700e4200)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fc0509c1270 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509c1810, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key_ptr=0x7fc0509c3670 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key=0x7fc0509c3670 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key=0x7fc0509c3670 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509c3770) at /usr/local/mysql/sql/sql_executor.cc:2275
	#8  0x00000000014ed267 in sub_select (join=0x7fc05001de18, qep_tab=0x7fc0509c3770, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#9  0x00000000014ecbfa in do_select (join=0x7fc05001de18) at /usr/local/mysql/sql/sql_executor.cc:950
	#10 0x00000000014eab61 in JOIN::exec (this=0x7fc05001de18) at /usr/local/mysql/sql/sql_executor.cc:199
	#11 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001dcf8, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#12 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d3f0) at /usr/local/mysql/sql/sql_parse.cc:5144
	#13 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#14 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#15 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#16 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#17 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#18 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#19 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#20 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1027, block=0x7fc063a3e3a8, heap_no=3, index=0x7fc050958cb0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  0x0000000001942d52 in lock_rec_lock_fast (impl=false, mode=1027, block=0x7fc063a3e3a8, heap_no=3, index=0x7fc050958cb0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1027, block=0x7fc063a3e3a8, heap_no=3, index=0x7fc050958cb0, thr=0x7fc0509c1fb0) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	#2  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fc063a3e3a8, rec=0x7fc064b4409d "\200", index=0x7fc050958cb0, offsets=0x7fc0700e3ee0, mode=LOCK_X, gap_mode=1024, thr=0x7fc0509c1fb0)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#3  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fc0509c1810, sec_index=0x7fc0509598e0, rec=0x7fc064b4808c "\200", thr=0x7fc0509c1fb0, out_rec=0x7fc0700e4770, offsets=0x7fc0700e4748, offset_heap=0x7fc0700e4750, vrow=0x0, mtr=0x7fc0700e4200)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#4  0x0000000001a4f94a in row_search_mvcc (buf=0x7fc0509c1270 <incomplete sequence \375>, mode=PAGE_CUR_GE, prebuilt=0x7fc0509c1810, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key_ptr=0x7fc0509c3670 "", key_len=5, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key=0x7fc0509c3670 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7fc0509c0f80, buf=0x7fc0509c1270 <incomplete sequence \375>, key=0x7fc0509c3670 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x00000000014ef7af in join_read_always_key (tab=0x7fc0509c3770) at /usr/local/mysql/sql/sql_executor.cc:2275
	#9  0x00000000014ed267 in sub_select (join=0x7fc05001de18, qep_tab=0x7fc0509c3770, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#10 0x00000000014ecbfa in do_select (join=0x7fc05001de18) at /usr/local/mysql/sql/sql_executor.cc:950
	#11 0x00000000014eab61 in JOIN::exec (this=0x7fc05001de18) at /usr/local/mysql/sql/sql_executor.cc:199
	#12 0x0000000001583b64 in handle_query (thd=0x7fc050029df0, lex=0x7fc05002c110, result=0x7fc05001dcf8, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#13 0x000000000153996f in execute_sqlcom_select (thd=0x7fc050029df0, all_tables=0x7fc05001d3f0) at /usr/local/mysql/sql/sql_parse.cc:5144
	#14 0x000000000153339d in mysql_execute_command (thd=0x7fc050029df0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#15 0x000000000153a849 in mysql_parse (thd=0x7fc050029df0, parser_state=0x7fc0700e6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x7fc050029df0, com_data=0x7fc0700e6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x7fc050029df0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x5e44c20) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x61f79b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007fc07c8ebea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007fc07b7b19fd in clone () from /lib64/libc.so.6
