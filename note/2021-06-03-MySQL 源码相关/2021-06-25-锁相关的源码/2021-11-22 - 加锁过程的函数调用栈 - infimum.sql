

1. 初始表结构和数据
	
	DROP TABLE IF EXISTS `t`;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');

	mysql>select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (0.00 sec)
	
	
2. 环境 

	mysql> select version();
	+------------------+
	| version()        |
	+------------------+
	| 5.7.26-debug-log |
	+------------------+
	1 row in set (0.00 sec)

	mysql> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
	+--------------------------------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.01 sec)


3. b lock_rec_lock
	
	session A           
	begin;
	select * from t where id<=1 for update;


	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep n   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	(gdb) c
	Continuing.
	[Switching to Thread 0x7efe2c1f7700 (LWP 8778)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=3, block=0x7efe3ba84748, heap_no=2, index=0x7efe44028970, thr=0x7efe44969330) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=3, block=0x7efe3ba84748, heap_no=2, index=0x7efe44028970, thr=0x7efe44969330) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7efe3ba84748, rec=0x7efe3d0d407e "\200", index=0x7efe44028970, offsets=0x7efe2c1f3d80, mode=LOCK_X, gap_mode=0, thr=0x7efe44969330)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7efe44968a58, rec=0x7efe3d0d407e "\200", index=0x7efe44028970, offsets=0x7efe2c1f3d80, mode=3, type=0, thr=0x7efe44969330, mtr=0x7efe2c1f40a0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7efe44028350 "\377", mode=PAGE_CUR_G, prebuilt=0x7efe44968830, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7efe44028060, buf=0x7efe44028350 "\377", key_ptr=0x0, key_len=0, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x00000000018c27ba in ha_innobase::index_first (this=0x7efe44028060, buf=0x7efe44028350 "\377") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9157
	#6  0x0000000000f2c4b3 in handler::ha_index_first (this=0x7efe44028060, buf=0x7efe44028350 "\377") at /usr/local/mysql/sql/handler.cc:3193
	#7  0x0000000000f34e59 in handler::read_range_first (this=0x7efe44028060, start_key=0x0, end_key=0x7efe44028168, eq_range_arg=false, sorted=false) at /usr/local/mysql/sql/handler.cc:7378
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7efe44028060, range_info=0x7efe2c1f5110) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7efe440282c0, range_info=0x7efe2c1f5110) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7efe44028060, range_info=0x7efe2c1f5110) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7efe4496ec00) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7efe4496b3a8) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000014f0090 in join_init_read_record (tab=0x7efe4496b358) at /usr/local/mysql/sql/sql_executor.cc:2497
	#14 0x00000000014ed267 in sub_select (join=0x7efe4496ae40, qep_tab=0x7efe4496b358, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#15 0x00000000014ecbfa in do_select (join=0x7efe4496ae40) at /usr/local/mysql/sql/sql_executor.cc:950
	#16 0x00000000014eab61 in JOIN::exec (this=0x7efe4496ae40) at /usr/local/mysql/sql/sql_executor.cc:199
	#17 0x0000000001583b64 in handle_query (thd=0x7efe4400a730, lex=0x7efe4400ca50, result=0x7efe44010c98, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#18 0x000000000153996f in execute_sqlcom_select (thd=0x7efe4400a730, all_tables=0x7efe44010390) at /usr/local/mysql/sql/sql_parse.cc:5144
	#19 0x000000000153339d in mysql_execute_command (thd=0x7efe4400a730, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#20 0x000000000153a849 in mysql_parse (thd=0x7efe4400a730, parser_state=0x7efe2c1f6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#21 0x00000000015302d8 in dispatch_command (thd=0x7efe4400a730, com_data=0x7efe2c1f6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#22 0x000000000152f20c in do_command (thd=0x7efe4400a730) at /usr/local/mysql/sql/sql_parse.cc:1025
	#23 0x000000000165f7c8 in handle_connection (arg=0x44c7460) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#24 0x0000000001ce7612 in pfs_spawn_thread (arg=0x428eb60) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#25 0x00007efe54279ea5 in start_thread () from /lib64/libpthread.so.0
	#26 0x00007efe5313f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=3, block=0x7efe3ba84748, heap_no=3, index=0x7efe44028970, thr=0x7efe44969330) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=3, block=0x7efe3ba84748, heap_no=3, index=0x7efe44028970, thr=0x7efe44969330) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7efe3ba84748, rec=0x7efe3d0d40a1 "\200", index=0x7efe44028970, offsets=0x7efe2c1f3e10, mode=LOCK_X, gap_mode=0, thr=0x7efe44969330)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7efe44968a58, rec=0x7efe3d0d40a1 "\200", index=0x7efe44028970, offsets=0x7efe2c1f3e10, mode=3, type=0, thr=0x7efe44969330, mtr=0x7efe2c1f4130) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7efe44028350 "\371\001", mode=PAGE_CUR_G, prebuilt=0x7efe44968830, match_mode=0, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7efe44028060, buf=0x7efe44028350 "\371\001", direction=1, match_mode=0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
	#5  0x00000000018c26c3 in ha_innobase::index_next (this=0x7efe44028060, buf=0x7efe44028350 "\371\001") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9109
	#6  0x0000000000f2bec4 in handler::ha_index_next (this=0x7efe44028060, buf=0x7efe44028350 "\371\001") at /usr/local/mysql/sql/handler.cc:3125
	#7  0x0000000000f34fc7 in handler::read_range_next (this=0x7efe44028060) at /usr/local/mysql/sql/handler.cc:7430
	#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7efe44028060, range_info=0x7efe2c1f5140) at /usr/local/mysql/sql/handler.cc:6429
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7efe440282c0, range_info=0x7efe2c1f5140) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7efe44028060, range_info=0x7efe2c1f5140) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7efe4496ec00) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7efe4496b3a8) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000014ed27d in sub_select (join=0x7efe4496ae40, qep_tab=0x7efe4496b358, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1280
	#14 0x00000000014ecbfa in do_select (join=0x7efe4496ae40) at /usr/local/mysql/sql/sql_executor.cc:950
	#15 0x00000000014eab61 in JOIN::exec (this=0x7efe4496ae40) at /usr/local/mysql/sql/sql_executor.cc:199
	#16 0x0000000001583b64 in handle_query (thd=0x7efe4400a730, lex=0x7efe4400ca50, result=0x7efe44010c98, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#17 0x000000000153996f in execute_sqlcom_select (thd=0x7efe4400a730, all_tables=0x7efe44010390) at /usr/local/mysql/sql/sql_parse.cc:5144
	#18 0x000000000153339d in mysql_execute_command (thd=0x7efe4400a730, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#19 0x000000000153a849 in mysql_parse (thd=0x7efe4400a730, parser_state=0x7efe2c1f6690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#20 0x00000000015302d8 in dispatch_command (thd=0x7efe4400a730, com_data=0x7efe2c1f6df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#21 0x000000000152f20c in do_command (thd=0x7efe4400a730) at /usr/local/mysql/sql/sql_parse.cc:1025
	#22 0x000000000165f7c8 in handle_connection (arg=0x44c7460) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#23 0x0000000001ce7612 in pfs_spawn_thread (arg=0x428eb60) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#24 0x00007efe54279ea5 in start_thread () from /lib64/libpthread.so.0
	#25 0x00007efe5313f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.



4. 语句的加锁范围
	primary key: 
		next-key lock：(-∞, 1] + next-key lock：(1, 2]
	
	参考：唯一索引范围 bug

	
	