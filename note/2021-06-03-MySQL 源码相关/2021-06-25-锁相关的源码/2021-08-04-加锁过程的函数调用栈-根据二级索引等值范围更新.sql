
1. 初始化表结构和数据
2. b lock_rec_lock
3. 二级索引等值范围更新加锁
	3.1 RC隔离级别
4. 小结



1. 初始化表结构和数据

	
	drop table if exists hero;
	CREATE TABLE hero (
		number INT,
		name VARCHAR(100),
		country varchar(100),
		PRIMARY KEY (number),
		KEY idx_name (name)
	) Engine=InnoDB CHARSET=utf8mb4;

	INSERT INTO hero VALUES (1, 'l刘备', '蜀');
	INSERT INTO hero VALUES (3, 'z诸葛亮', '蜀');
	INSERT INTO hero VALUES (8, 'c曹操', '魏');
	INSERT INTO hero VALUES (15, 'x荀彧', '魏');
	INSERT INTO hero VALUES (20, 's孙权', '吴');

	mysql> select * from hero order by name;
	+--------+------------+---------+
	| number | name       | country |
	+--------+------------+---------+
	|      8 | c曹操      | 魏      |
	|      1 | l刘备      | 蜀      |
	|     20 | s孙权      | 吴      |
	|     15 | x荀彧      | 魏      |
	|      3 | z诸葛亮    | 蜀      |
	+--------+------------+---------+
	5 rows in set (0.00 sec)



2. b lock_rec_lock
	你可以通过GDB，断点函数 lock_rec_lock 来查看某条SQL如何执行加锁操作。


3. 二级索引等值范围更新加锁

	root@mysqldb 10:36:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	| 139835056597608:1062:139834941305512  |                  3664 |        65 | hero        | NULL       | TABLE     | IX            | GRANTED     | NULL         |
	| 139835056597608:5:5:4:139834941302472 |                  3664 |        65 | hero        | idx_name   | RECORD    | X,REC_NOT_GAP | GRANTED     | 'c曹操', 8   |
	| 139835056597608:5:4:4:139834941302816 |                  3664 |        65 | hero        | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 8            |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+--------------+
	3 rows in set (0.00 sec)

	3.1 RC隔离级别	

		mysql> show global variables like 'tx_isolation';
		+---------------+----------------+
		| Variable_name | Value          |
		+---------------+----------------+
		| tx_isolation  | READ-COMMITTED |
		+---------------+----------------+
		1 row in set (0.00 sec)

	
	begin;
	update hero set name = 'c曹操' where name <= 'c曹操';


	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f3a8c15b700 (LWP 5625)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649d70, heap_no=4, index=0x7f3aa800f230, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649d70, heap_no=4, index=0x7f3aa800f230, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7f3a9d649d70, rec=0x7f3a9e8580a6 "c曹操\200", index=0x7f3aa800f230, offsets=0x7f3a8c157880, mode=LOCK_X, gap_mode=1024, thr=0x7f3aa80099b8)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7f3aa8009438, rec=0x7f3a9e8580a6 "c曹操\200", index=0x7f3aa800f230, offsets=0x7f3a8c157880, mode=3, type=1024, thr=0x7f3aa80099b8, mtr=0x7f3a8c157ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f3aa8024b60 "\377", mode=PAGE_CUR_G, prebuilt=0x7f3aa8009220, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", key_ptr=0x7f3aa8969770 "\001", key_len=403, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", key=0x7f3aa8969770 "\001", keypart_map=1, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", key=0x7f3aa8969770 "\001", keypart_map=1, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x7f3aa8952400, start_key=0x7f3aa89524e8, end_key=0x7f3aa8952508, eq_range_arg=false, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f3aa8952400, range_info=0x7f3a8c158c30) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f3aa8952660, range_info=0x7f3a8c158c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f3aa8952400, range_info=0x7f3a8c158c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f3aa80251d0) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7f3a8c158dd0) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000015e7631 in mysql_update (thd=0x7f3aa80128a0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f3a8c159428, updated_return=0x7f3a8c159420) at /usr/local/mysql/sql/sql_update.cc:701
	#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f3aa8001c28, thd=0x7f3aa80128a0, switch_to_multitable=0x7f3a8c1594cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f3aa8001c28, thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_update.cc:3018
	#16 0x00000000015351f1 in mysql_execute_command (thd=0x7f3aa80128a0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#17 0x000000000153a849 in mysql_parse (thd=0x7f3aa80128a0, parser_state=0x7f3a8c15a690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f3aa80128a0, com_data=0x7f3a8c15adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x4cc5000) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4ee0ac0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f3ab5dd9ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f3ab4c9f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649a48, heap_no=4, index=0x7f3aa8956bb0, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649a48, heap_no=4, index=0x7f3aa8956bb0, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f3a9d649a48, rec=0x7f3a9e8540c9 "\200", index=0x7f3aa8956bb0, offsets=0x7f3a8c157880, mode=LOCK_X, gap_mode=1024, thr=0x7f3aa80099b8)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7f3aa8009220, sec_index=0x7f3aa800f230, rec=0x7f3a9e8580a6 "c曹操\200", thr=0x7f3aa80099b8, out_rec=0x7f3a8c158110, offsets=0x7f3a8c1580e8, offset_heap=0x7f3a8c1580f0, vrow=0x0, mtr=0x7f3a8c157ba0)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7f3aa8024b60 "\377", mode=PAGE_CUR_G, prebuilt=0x7f3aa8009220, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", key_ptr=0x7f3aa8969770 "\001", key_len=403, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", key=0x7f3aa8969770 "\001", keypart_map=1, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", key=0x7f3aa8969770 "\001", keypart_map=1, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x7f3aa8952400, start_key=0x7f3aa89524e8, end_key=0x7f3aa8952508, eq_range_arg=false, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f3aa8952400, range_info=0x7f3a8c158c30) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f3aa8952660, range_info=0x7f3a8c158c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f3aa8952400, range_info=0x7f3a8c158c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f3aa80251d0) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7f3a8c158dd0) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000015e7631 in mysql_update (thd=0x7f3aa80128a0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f3a8c159428, updated_return=0x7f3a8c159420) at /usr/local/mysql/sql/sql_update.cc:701
	#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f3aa8001c28, thd=0x7f3aa80128a0, switch_to_multitable=0x7f3a8c1594cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f3aa8001c28, thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_update.cc:3018
	#16 0x00000000015351f1 in mysql_execute_command (thd=0x7f3aa80128a0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#17 0x000000000153a849 in mysql_parse (thd=0x7f3aa80128a0, parser_state=0x7f3a8c15a690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f3aa80128a0, com_data=0x7f3a8c15adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x4cc5000) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4ee0ac0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f3ab5dd9ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f3ab4c9f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649d70, heap_no=2, index=0x7f3aa800f230, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649d70, heap_no=2, index=0x7f3aa800f230, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7f3a9d649d70, rec=0x7f3a9e85807f "l刘备\200", index=0x7f3aa800f230, offsets=0x7f3a8c157900, mode=LOCK_X, gap_mode=1024, thr=0x7f3aa80099b8)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7f3aa8009438, rec=0x7f3a9e85807f "l刘备\200", index=0x7f3aa800f230, offsets=0x7f3a8c157900, mode=3, type=1024, thr=0x7f3aa80099b8, mtr=0x7f3a8c157c20) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f3aa8024b60 "\374\b", mode=PAGE_CUR_G, prebuilt=0x7f3aa8009220, match_mode=0, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\374\b", direction=1, match_mode=0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
	#5  0x00000000018c26c3 in ha_innobase::index_next (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\374\b") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9109
	#6  0x0000000000f2bdbb in handler::ha_index_next (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\374\b") at /usr/local/mysql/sql/handler.cc:3125
	#7  0x0000000000f34fc7 in handler::read_range_next (this=0x7f3aa8952400) at /usr/local/mysql/sql/handler.cc:7430
	#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7f3aa8952400, range_info=0x7f3a8c158c30) at /usr/local/mysql/sql/handler.cc:6429
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f3aa8952660, range_info=0x7f3a8c158c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f3aa8952400, range_info=0x7f3a8c158c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f3aa80251d0) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7f3a8c158dd0) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000015e7631 in mysql_update (thd=0x7f3aa80128a0, fields=..., values=..., limit=18446744073709551614, handle_duplicates=DUP_ERROR, found_return=0x7f3a8c159428, updated_return=0x7f3a8c159420) at /usr/local/mysql/sql/sql_update.cc:701
	#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f3aa8001c28, thd=0x7f3aa80128a0, switch_to_multitable=0x7f3a8c1594cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f3aa8001c28, thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_update.cc:3018
	#16 0x00000000015351f1 in mysql_execute_command (thd=0x7f3aa80128a0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#17 0x000000000153a849 in mysql_parse (thd=0x7f3aa80128a0, parser_state=0x7f3a8c15a690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f3aa80128a0, com_data=0x7f3a8c15adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x4cc5000) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4ee0ac0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f3ab5dd9ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f3ab4c9f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649a48, heap_no=2, index=0x7f3aa8956bb0, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649a48, heap_no=2, index=0x7f3aa8956bb0, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f3a9d649a48, rec=0x7f3a9e854080 "\200", index=0x7f3aa8956bb0, offsets=0x7f3a8c157900, mode=LOCK_X, gap_mode=1024, thr=0x7f3aa80099b8)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7f3aa8009220, sec_index=0x7f3aa800f230, rec=0x7f3a9e85807f "l刘备\200", thr=0x7f3aa80099b8, out_rec=0x7f3a8c158190, offsets=0x7f3a8c158168, offset_heap=0x7f3a8c158170, vrow=0x0, mtr=0x7f3a8c157c20)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7f3aa8024b60 "\374\b", mode=PAGE_CUR_G, prebuilt=0x7f3aa8009220, match_mode=0, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\374\b", direction=1, match_mode=0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
	#5  0x00000000018c26c3 in ha_innobase::index_next (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\374\b") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9109
	#6  0x0000000000f2bdbb in handler::ha_index_next (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\374\b") at /usr/local/mysql/sql/handler.cc:3125
	#7  0x0000000000f34fc7 in handler::read_range_next (this=0x7f3aa8952400) at /usr/local/mysql/sql/handler.cc:7430
	#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7f3aa8952400, range_info=0x7f3a8c158c30) at /usr/local/mysql/sql/handler.cc:6429
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f3aa8952660, range_info=0x7f3a8c158c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f3aa8952400, range_info=0x7f3a8c158c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f3aa80251d0) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7f3a8c158dd0) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000015e7631 in mysql_update (thd=0x7f3aa80128a0, fields=..., values=..., limit=18446744073709551614, handle_duplicates=DUP_ERROR, found_return=0x7f3a8c159428, updated_return=0x7f3a8c159420) at /usr/local/mysql/sql/sql_update.cc:701
	#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f3aa8001c28, thd=0x7f3aa80128a0, switch_to_multitable=0x7f3a8c1594cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f3aa8001c28, thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_update.cc:3018
	#16 0x00000000015351f1 in mysql_execute_command (thd=0x7f3aa80128a0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#17 0x000000000153a849 in mysql_parse (thd=0x7f3aa80128a0, parser_state=0x7f3a8c15a690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f3aa80128a0, com_data=0x7f3a8c15adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x4cc5000) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4ee0ac0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f3ab5dd9ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f3ab4c9f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649a48, heap_no=4, index=0x7f3aa8956bb0, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7f3a9d649a48, heap_no=4, index=0x7f3aa8956bb0, thr=0x7f3aa80099b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f3a9d649a48, rec=0x7f3a9e8540c9 "\200", index=0x7f3aa8956bb0, offsets=0x7f3a8c1579e0, mode=LOCK_X, gap_mode=1024, thr=0x7f3aa80099b8)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f3aa8009438, rec=0x7f3a9e8540c9 "\200", index=0x7f3aa8956bb0, offsets=0x7f3a8c1579e0, mode=3, type=1024, thr=0x7f3aa80099b8, mtr=0x7f3a8c157d00) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f3aa8024b60 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f3aa8009220, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", key_ptr=0x7f3aa8009050 "\b", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x00000000018c2b27 in ha_innobase::rnd_pos (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", pos=0x7f3aa8009050 "\b") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9292
	#6  0x0000000000f2b061 in handler::ha_rnd_pos (this=0x7f3aa8952400, buf=0x7f3aa8024b60 "\377", pos=0x7f3aa8009050 "\b") at /usr/local/mysql/sql/handler.cc:2989
	#7  0x000000000145809b in rr_from_tempfile (info=0x7f3a8c158dd0) at /usr/local/mysql/sql/records.cc:533
	#8  0x00000000015e7b84 in mysql_update (thd=0x7f3aa80128a0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f3a8c159428, updated_return=0x7f3a8c159420) at /usr/local/mysql/sql/sql_update.cc:812
	#9  0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f3aa8001c28, thd=0x7f3aa80128a0, switch_to_multitable=0x7f3a8c1594cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#10 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f3aa8001c28, thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_update.cc:3018
	#11 0x00000000015351f1 in mysql_execute_command (thd=0x7f3aa80128a0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#12 0x000000000153a849 in mysql_parse (thd=0x7f3aa80128a0, parser_state=0x7f3a8c15a690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#13 0x00000000015302d8 in dispatch_command (thd=0x7f3aa80128a0, com_data=0x7f3a8c15adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#14 0x000000000152f20c in do_command (thd=0x7f3aa80128a0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#15 0x000000000165f7c8 in handle_connection (arg=0x4cc5000) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#16 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4ee0ac0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#17 0x00007f3ab5dd9ea5 in start_thread () from /lib64/libpthread.so.0
	#18 0x00007f3ab4c9f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.


	
4. 小结


	1. 函数调用栈：

		
		
		