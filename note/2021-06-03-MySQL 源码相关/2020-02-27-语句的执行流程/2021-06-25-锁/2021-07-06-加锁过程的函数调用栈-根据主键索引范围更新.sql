



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
	
	
	mysql> SELECT * FROM hero;
	+--------+------------+---------+
	| number | name       | country |
	+--------+------------+---------+
	|      1 | l刘备      | 蜀      |
	|      3 | z诸葛亮    | 蜀      |
	|      8 | a曹操bb    | 老国    |
	|     15 | x荀彧      | 魏      |
	|     20 | s孙权      | 吴      |
	+--------+------------+---------+
	5 rows in set (0.00 sec)

	
	mysql> select version();
	+------------------+
	| version()        |
	+------------------+
	| 5.7.26-debug-log |
	+------------------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'tx_isolation';
	+---------------+-----------------+
	| Variable_name | Value           |
	+---------------+-----------------+
	| tx_isolation  | REPEATABLE-READ |
	+---------------+-----------------+
	1 row in set (0.00 sec)




2. 执行的语句
	
	mysql> desc select * from hero where number>3 and number<=8 for update;
	+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	|  1 | SIMPLE      | hero  | NULL       | range | PRIMARY       | PRIMARY | 4       | NULL |    1 |   100.00 | Using where |
	+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)


	begin;
	select * from hero where number>3 and number<=8 for update;


3. 打断点

	b lock_rec_lock_fast
	b lock_rec_lock_slow

	(gdb) b lock_rec_lock_fast
	Breakpoint 2 at 0x1942d51: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 1871.
	(gdb) b lock_rec_lock_slow
	Breakpoint 3 at 0x1943191: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 1952.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep n   0x0000000001942d51 in lock_rec_lock_fast(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	3       breakpoint     keep n   0x0000000001943191 in lock_rec_lock_slow(ulint, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1952
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=3, block=0x7fd2f3a46b60, heap_no=14, index=0x7fd2fc014230, thr=0x5c1a7e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=3, block=0x7fd2f3a46b60, heap_no=14, index=0x7fd2fc014230, thr=0x5c1a7e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=3, block=0x7fd2f3a46b60, heap_no=14, index=0x7fd2fc014230, thr=0x5c1a7e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	#2  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a46b60, rec=0x7fd2f4bf022e "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262d60, mode=LOCK_X, gap_mode=0, thr=0x5c1a7e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#3  0x0000000001a4651c in sel_set_rec_lock (pcur=0x5c1a268, rec=0x7fd2f4bf022e "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262d60, mode=3, type=0, thr=0x5c1a7e8, mtr=0x7fd2e4263080) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x5c2db80 "\377", mode=PAGE_CUR_G, prebuilt=0x5c1a050, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x5c2d770, buf=0x5c2db80 "\377", key_ptr=0x5c3ba10 "\003", key_len=4, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x5c2d770, buf=0x5c2db80 "\377", key=0x5c3ba10 "\003", keypart_map=1, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b457 in handler::ha_index_read_map (this=0x5c2d770, buf=0x5c2db80 "\377", key=0x5c3ba10 "\003", keypart_map=1, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x0000000000f34e8f in handler::read_range_first (this=0x5c2d770, start_key=0x5c2d858, end_key=0x5c2d878, eq_range_arg=false, sorted=false) at /usr/local/mysql/sql/handler.cc:7383
	#9  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x5c2d770, range_info=0x7fd2e4264110) at /usr/local/mysql/sql/handler.cc:6450
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5c2d9d0, range_info=0x7fd2e4264110) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5c2d770, range_info=0x7fd2e4264110) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x52639a0) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x5c399a0) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000014f0090 in join_init_read_record (tab=0x5c39950) at /usr/local/mysql/sql/sql_executor.cc:2497
	#15 0x00000000014ed267 in sub_select (join=0x5c38d80, qep_tab=0x5c39950, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#16 0x00000000014ecbfa in do_select (join=0x5c38d80) at /usr/local/mysql/sql/sql_executor.cc:950
	#17 0x00000000014eab61 in JOIN::exec (this=0x5c38d80) at /usr/local/mysql/sql/sql_executor.cc:199
	#18 0x0000000001583b64 in handle_query (thd=0x5295660, lex=0x5297980, result=0x526f298, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#19 0x000000000153996f in execute_sqlcom_select (thd=0x5295660, all_tables=0x526e6d0) at /usr/local/mysql/sql/sql_parse.cc:5144
	#20 0x000000000153339d in mysql_execute_command (thd=0x5295660, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#21 0x000000000153a849 in mysql_parse (thd=0x5295660, parser_state=0x7fd2e4265690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#22 0x00000000015302d8 in dispatch_command (thd=0x5295660, com_data=0x7fd2e4265df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#23 0x000000000152f20c in do_command (thd=0x5295660) at /usr/local/mysql/sql/sql_parse.cc:1025
	#24 0x000000000165f7c8 in handle_connection (arg=0x4f93910) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#25 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4305a40) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#26 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#27 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.
	
	函数调用栈：
		ha_innobase::index_read
			->row_search_mvcc
				->sel_set_rec_lock
					->lock_clust_rec_read_check_and_lock
						->lock_rec_lock
							->lock_rec_lock_fast

	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=3, block=0x7fd2f3a46b60, heap_no=5, index=0x7fd2fc014230, thr=0x5c1a7e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=3, block=0x7fd2f3a46b60, heap_no=5, index=0x7fd2fc014230, thr=0x5c1a7e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=3, block=0x7fd2f3a46b60, heap_no=5, index=0x7fd2fc014230, thr=0x5c1a7e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	#2  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a46b60, rec=0x7fd2f4bf00ec "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262e10, mode=LOCK_X, gap_mode=0, thr=0x5c1a7e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#3  0x0000000001a4651c in sel_set_rec_lock (pcur=0x5c1a268, rec=0x7fd2f4bf00ec "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262e10, mode=3, type=0, thr=0x5c1a7e8, mtr=0x7fd2e4263130) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x5c2db80 "\374\b", mode=PAGE_CUR_G, prebuilt=0x5c1a050, match_mode=0, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#5  0x00000000018c249a in ha_innobase::general_fetch (this=0x5c2d770, buf=0x5c2db80 "\374\b", direction=1, match_mode=0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
	#6  0x00000000018c26c3 in ha_innobase::index_next (this=0x5c2d770, buf=0x5c2db80 "\374\b") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9109
	#7  0x0000000000f2bec4 in handler::ha_index_next (this=0x5c2d770, buf=0x5c2db80 "\374\b") at /usr/local/mysql/sql/handler.cc:3125
	#8  0x0000000000f34fc7 in handler::read_range_next (this=0x5c2d770) at /usr/local/mysql/sql/handler.cc:7430
	#9  0x0000000000f32d19 in handler::multi_range_read_next (this=0x5c2d770, range_info=0x7fd2e4264140) at /usr/local/mysql/sql/handler.cc:6429
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5c2d9d0, range_info=0x7fd2e4264140) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5c2d770, range_info=0x7fd2e4264140) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x52639a0) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x5c399a0) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000014ed27d in sub_select (join=0x5c38d80, qep_tab=0x5c39950, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1280
	#15 0x00000000014ecbfa in do_select (join=0x5c38d80) at /usr/local/mysql/sql/sql_executor.cc:950
	#16 0x00000000014eab61 in JOIN::exec (this=0x5c38d80) at /usr/local/mysql/sql/sql_executor.cc:199
	#17 0x0000000001583b64 in handle_query (thd=0x5295660, lex=0x5297980, result=0x526f298, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#18 0x000000000153996f in execute_sqlcom_select (thd=0x5295660, all_tables=0x526e6d0) at /usr/local/mysql/sql/sql_parse.cc:5144
	#19 0x000000000153339d in mysql_execute_command (thd=0x5295660, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#20 0x000000000153a849 in mysql_parse (thd=0x5295660, parser_state=0x7fd2e4265690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#21 0x00000000015302d8 in dispatch_command (thd=0x5295660, com_data=0x7fd2e4265df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#22 0x000000000152f20c in do_command (thd=0x5295660) at /usr/local/mysql/sql/sql_parse.cc:1025
	#23 0x000000000165f7c8 in handle_connection (arg=0x4f93910) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#24 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4305a40) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#25 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#26 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.



	函数调用栈：
		handler::ha_index_next
			->ha_innobase::index_next
				->ha_innobase::general_fetch
					->row_search_mvcc
						->sel_set_rec_lock
							->lock_clust_rec_read_check_and_lock
								->lock_rec_lock
									->lock_rec_lock_fast
								
							
4. 小结
	
	函数调用栈：
		
		ha_innobase::index_read
			->row_search_mvcc
				->sel_set_rec_lock
					->lock_clust_rec_read_check_and_lock
						->lock_rec_lock
							->lock_rec_lock_fast
							
		-- 根据索引扫描下一行记录
		handler::ha_index_next
				->ha_innobase::index_next
					->ha_innobase::general_fetch
						->row_search_mvcc
							->sel_set_rec_lock
								->lock_clust_rec_read_check_and_lock
									->lock_rec_lock
										->lock_rec_lock_fast
								
	语句的加锁范围：
		select * from hero where number>3 and number<=8 for update;
		primary: next-key lock:(3,8] + next-key lock:(8, 15]
		
		
		
		
	