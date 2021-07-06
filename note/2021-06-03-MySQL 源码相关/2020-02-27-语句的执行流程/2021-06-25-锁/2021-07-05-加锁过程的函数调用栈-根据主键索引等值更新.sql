
1. 初始化表结构和数据
2. b lock_rec_lock
3. 根据主键索引等值更新二级索引的值
	3.2 RR隔离级别	
	3.2.1 原地更新
	3.2.2 非原地更新
	3.2.3 小结

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
	|      8 | c曹操      | 中      |
	|     15 | x荀彧      | 魏      |
	|     20 | s孙权      | 吴      |
	+--------+------------+---------+
	5 rows in set (0.00 sec)


	mysql> select * from hero order by name;
	+--------+------------+---------+
	| number | name       | country |
	+--------+------------+---------+
	|      8 | c曹操      | 中      |
	|      1 | l刘备      | 蜀      |
	|     20 | s孙权      | 吴      |
	|     15 | x荀彧      | 魏      |
	|      3 | z诸葛亮    | 蜀      |
	+--------+------------+---------+
	5 rows in set (0.00 sec)


2. b lock_rec_lock
	你可以通过GDB，断点函数 lock_rec_lock 来查看某条SQL如何执行加锁操作。


3. 根据主键索引等值更新二级索引的值


3.2 RR隔离级别	

	mysql> show global variables like 'tx_isolation';
	+---------------+-----------------+
	| Variable_name | Value           |
	+---------------+-----------------+
	| tx_isolation  | REPEATABLE-READ |
	+---------------+-----------------+
	1 row in set (0.03 sec)
	
3.2.1 原地更新

	update hero set country='老' where number=8;
	
	mysql> desc update hero set country='老' where number=8;
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------------+
	|  1 | UPDATE      | hero  | NULL       | range | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | Using where |
	+----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------------+
	1 row in set (0.00 sec)
	


	b lock_rec_lock

	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fd2e4266700 (LWP 4308)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd2f3a46b60, heap_no=13, index=0x7fd2fc014230, thr=0x5bf4c88) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd2f3a46b60, heap_no=13, index=0x7fd2fc014230, thr=0x5bf4c88) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a46b60, rec=0x7fd2f4bf0209 "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262880, mode=LOCK_X, gap_mode=1024, thr=0x5bf4c88) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x5bf4708, rec=0x7fd2f4bf0209 "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262880, mode=3, type=1024, thr=0x5bf4c88, mtr=0x7fd2e4262ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x5bf39d0 "\377", mode=PAGE_CUR_GE, prebuilt=0x5bf44f0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x5bf35c0, buf=0x5bf39d0 "\377", key_ptr=0x5c105d0 "\b", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x5bf35c0, buf=0x5bf39d0 "\377", key=0x5c105d0 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x5bf35c0, buf=0x5bf39d0 "\377", key=0x5c105d0 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x5bf35c0, start_key=0x5bf36a8, end_key=0x5bf36c8, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x5bf35c0, range_info=0x7fd2e4263c30) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5bf3820, range_info=0x7fd2e4263c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5bf35c0, range_info=0x7fd2e4263c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
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


3.2.2 非原地更新
	
	update hero set country='老国' where number=8;
	
	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fd2e4266700 (LWP 4308)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd2f3a46b60, heap_no=13, index=0x7fd2fc014230, thr=0x5bff438) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd2f3a46b60, heap_no=13, index=0x7fd2fc014230, thr=0x5bff438) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a46b60, rec=0x7fd2f4bf0209 "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262880, mode=LOCK_X, gap_mode=1024, thr=0x5bff438) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x5bfeeb8, rec=0x7fd2f4bf0209 "\200", index=0x7fd2fc014230, offsets=0x7fd2e4262880, mode=3, type=1024, thr=0x5bff438, mtr=0x7fd2e4262ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x5bfe180 "\377", mode=PAGE_CUR_GE, prebuilt=0x5bfeca0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x5bfdd70, buf=0x5bfe180 "\377", key_ptr=0x5c1a570 "\b", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x5bfdd70, buf=0x5bfe180 "\377", key=0x5c1a570 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x5bfdd70, buf=0x5bfe180 "\377", key=0x5c1a570 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x5bfdd70, start_key=0x5bfde58, end_key=0x5bfde78, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x5bfdd70, range_info=0x7fd2e4263c30) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5bfdfd0, range_info=0x7fd2e4263c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5bfdd70, range_info=0x7fd2e4263c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x51febc0) at /usr/local/mysql/sql/opt_range.cc:11233
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

