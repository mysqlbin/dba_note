
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


	
	mysql> desc update hero set name='a曹操' where number=8;
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
			


	--下面是更新数据字典的函数调用栈
	(gdb) c
	Continuing.
	[Switching to Thread 0x7fd2c4ff9700 (LWP 4301)]


	Breakpoint 2, lock_rec_lock (impl=false, mode=3, block=0x7fd2f3a461e8, heap_no=100, index=0x7fd2dc010140, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=3, block=0x7fd2f3a461e8, heap_no=100, index=0x7fd2dc010140, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a461e8, rec=0x7fd2f4be5ec7 "test_dbhero", index=0x7fd2dc010140, offsets=0x7fd2c4ff7460, mode=LOCK_X, gap_mode=0, thr=0x7fd2cc009070)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7fd2cc008430, rec=0x7fd2f4be5ec7 "test_dbhero", index=0x7fd2dc010140, offsets=0x7fd2c4ff7460, mode=3, type=0, thr=0x7fd2cc009070, mtr=0x7fd2c4ff7780) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a474e0 in row_sel (node=0x7fd2cc008330, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1860
	#4  0x0000000001a483b4 in row_sel_step (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0sel.cc:2404
	#5  0x00000000019bd8b7 in que_thr_step (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1027
	#6  0x00000000019bdbcb in que_run_threads_low (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#7  0x00000000019bdd81 in que_run_threads (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#8  0x00000000019be037 in que_eval_sql (info=0x7fd2cc002b30, 
		sql=0x2295608 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., reserve_dict_mutex=0, 
		trx=0x7fd3008ab150) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#9  0x0000000001bbe7a1 in dict_stats_exec_sql (pinfo=0x7fd2cc002b30, 
		sql=0x2295608 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., trx=0x7fd3008ab150)
		at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:311
	#10 0x0000000001bc22e0 in dict_stats_save (table_orig=0x7fd2fc012ad0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2415
	#11 0x0000000001bc3bc5 in dict_stats_update (table=0x7fd2fc012ad0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#12 0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#13 0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#14 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#15 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=3, block=0x7fd2f3a461e8, heap_no=97, index=0x7fd2dc010140, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=3, block=0x7fd2f3a461e8, heap_no=97, index=0x7fd2dc010140, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。

	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a461e8, rec=0x7fd2f4be5e1c "test_dbt", index=0x7fd2dc010140, offsets=0x7fd2c4ff7460, mode=LOCK_X, gap_mode=0, thr=0x7fd2cc009070)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7fd2cc008430, rec=0x7fd2f4be5e1c "test_dbt", index=0x7fd2dc010140, offsets=0x7fd2c4ff7460, mode=3, type=0, thr=0x7fd2cc009070, mtr=0x7fd2c4ff7780) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a474e0 in row_sel (node=0x7fd2cc008330, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1860
	#4  0x0000000001a483b4 in row_sel_step (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0sel.cc:2404
	#5  0x00000000019bd8b7 in que_thr_step (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1027
	#6  0x00000000019bdbcb in que_run_threads_low (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#7  0x00000000019bdd81 in que_run_threads (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#8  0x00000000019be037 in que_eval_sql (info=0x7fd2cc002b30, 
		sql=0x2295608 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., reserve_dict_mutex=0, 
		trx=0x7fd3008ab150) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#9  0x0000000001bbe7a1 in dict_stats_exec_sql (pinfo=0x7fd2cc002b30, 
		sql=0x2295608 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., trx=0x7fd3008ab150)
		at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:311
	#10 0x0000000001bc22e0 in dict_stats_save (table_orig=0x7fd2fc012ad0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2415
	#11 0x0000000001bc3bc5 in dict_stats_update (table=0x7fd2fc012ad0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#12 0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#13 0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#14 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#15 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=1026, block=0x7fd2f3a461e8, heap_no=100, index=0x7fd2dc010140, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1026, block=0x7fd2f3a461e8, heap_no=100, index=0x7fd2dc010140, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

	-- gap_mode=1024：#define LOCK_REC_NOT_GAP  1024 。行锁。
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a461e8, rec=0x7fd2f4be5ec7 "test_dbhero", index=0x7fd2dc010140, offsets=0x7fd2c4ff6eb0, mode=LOCK_S, gap_mode=1024, thr=0x7fd2cc009070)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x00000000019ee0fe in row_ins_set_shared_rec_lock (type=1024, block=0x7fd2f3a461e8, rec=0x7fd2f4be5ec7 "test_dbhero", index=0x7fd2dc010140, offsets=0x7fd2c4ff6eb0, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:1484
	#3  0x00000000019ef944 in row_ins_duplicate_error_in_clust (flags=0, cursor=0x7fd2c4ff72a0, entry=0x7fd2cc003aa0, thr=0x7fd2cc009070, mtr=0x7fd2c4ff76c0) at /usr/local/mysql/storage/innobase/row/row0ins.cc:2330
	#4  0x00000000019f017c in row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fd2dc010140, n_uniq=2, entry=0x7fd2cc003aa0, n_ext=0, thr=0x7fd2cc009070, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:2555
	#5  0x00000000019f2281 in row_ins_clust_index_entry (index=0x7fd2dc010140, entry=0x7fd2cc003aa0, thr=0x7fd2cc009070, n_ext=0, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3293
	#6  0x00000000019f2780 in row_ins_index_entry (index=0x7fd2dc010140, entry=0x7fd2cc003aa0, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3429
	#7  0x00000000019f2cc0 in row_ins_index_entry_step (node=0x7fd2cc008db0, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3579
	#8  0x00000000019f3020 in row_ins (node=0x7fd2cc008db0, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3717
	#9  0x00000000019f3484 in row_ins_step (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3853
	#10 0x00000000019bd8d3 in que_thr_step (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1029
	#11 0x00000000019bdbcb in que_run_threads_low (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#12 0x00000000019bdd81 in que_run_threads (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#13 0x00000000019be037 in que_eval_sql (info=0x7fd2cc002b30, 
		sql=0x2295608 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., reserve_dict_mutex=0, 
		trx=0x7fd3008ab150) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#14 0x0000000001bbe7a1 in dict_stats_exec_sql (pinfo=0x7fd2cc002b30, 
		sql=0x2295608 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., trx=0x7fd3008ab150)
		at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:311
	#15 0x0000000001bc22e0 in dict_stats_save (table_orig=0x7fd2fc012ad0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2415
	#16 0x0000000001bc3bc5 in dict_stats_update (table=0x7fd2fc012ad0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#17 0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#18 0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#19 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#20 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=true, mode=1027, block=0x7fd2f3a461e8, heap_no=100, index=0x7fd2dc010140, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) b
	Note: breakpoint 2 also set at pc 0x1943577.
	Breakpoint 3 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) bt
	#0  lock_rec_lock (impl=true, mode=1027, block=0x7fd2f3a461e8, heap_no=100, index=0x7fd2dc010140, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- 调用 lock_clust_rec_modify_check_and_lock 检查记录锁
	#1  0x000000000194cfcc in lock_clust_rec_modify_check_and_lock (flags=0, block=0x7fd2f3a461e8, rec=0x7fd2f4be5ec7 "test_dbhero", index=0x7fd2dc010140, offsets=0x7fd2c4ff73a0, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6178
	#2  0x0000000001b21e6b in btr_cur_upd_lock_and_undo (flags=0, cursor=0x7fd2c4ff72a0, offsets=0x7fd2c4ff73a0, update=0x7fd2cc004280, cmpl_info=0, thr=0x7fd2cc009070, mtr=0x7fd2c4ff76c0, roll_ptr=0x7fd2c4ff6d48) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3528
	-- 原地更新
	#3  0x0000000001b22a98 in btr_cur_update_in_place (flags=0, cursor=0x7fd2c4ff72a0, offsets=0x7fd2c4ff73a0, update=0x7fd2cc004280, cmpl_info=0, thr=0x7fd2cc009070, trx_id=66840, mtr=0x7fd2c4ff76c0) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3838
	#4  0x0000000001b23288 in btr_cur_optimistic_update (flags=0, cursor=0x7fd2c4ff72a0, offsets=0x7fd2c4ff7be0, heap=0x7fd2c4ff7be8, update=0x7fd2cc004280, cmpl_info=0, thr=0x7fd2cc009070, trx_id=66840, mtr=0x7fd2c4ff76c0)
		at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3998
	#5  0x00000000019eb760 in row_ins_clust_index_entry_by_modify (pcur=0x7fd2c4ff72a0, flags=0, mode=2, offsets=0x7fd2c4ff7be0, offsets_heap=0x7fd2c4ff7be8, heap=0x7fd2cc0041f8, entry=0x7fd2cc003aa0, thr=0x7fd2cc009070, mtr=0x7fd2c4ff76c0)
		at /usr/local/mysql/storage/innobase/row/row0ins.cc:380
	#6  0x00000000019f027d in row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fd2dc010140, n_uniq=2, entry=0x7fd2cc003aa0, n_ext=0, thr=0x7fd2cc009070, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:2589
	#7  0x00000000019f2281 in row_ins_clust_index_entry (index=0x7fd2dc010140, entry=0x7fd2cc003aa0, thr=0x7fd2cc009070, n_ext=0, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3293
	#8  0x00000000019f2780 in row_ins_index_entry (index=0x7fd2dc010140, entry=0x7fd2cc003aa0, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3429
	#9  0x00000000019f2cc0 in row_ins_index_entry_step (node=0x7fd2cc008db0, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3579
	#10 0x00000000019f3020 in row_ins (node=0x7fd2cc008db0, thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3717
	#11 0x00000000019f3484 in row_ins_step (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3853
	#12 0x00000000019bd8d3 in que_thr_step (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1029
	#13 0x00000000019bdbcb in que_run_threads_low (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#14 0x00000000019bdd81 in que_run_threads (thr=0x7fd2cc009070) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#15 0x00000000019be037 in que_eval_sql (info=0x7fd2cc002b30, 
		sql=0x2295608 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., reserve_dict_mutex=0, 
		trx=0x7fd3008ab150) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#16 0x0000000001bbe7a1 in dict_stats_exec_sql (pinfo=0x7fd2cc002b30, 
		sql=0x2295608 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., trx=0x7fd3008ab150)
		at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:311
	#17 0x0000000001bc22e0 in dict_stats_save (table_orig=0x7fd2fc012ad0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2415
	#18 0x0000000001bc3bc5 in dict_stats_update (table=0x7fd2fc012ad0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#19 0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#20 0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#21 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#22 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock (impl=false, mode=3, block=0x7fd2f3a46838, heap_no=48, index=0x7fd2d8014440, thr=0x7fd2cc009818) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=3, block=0x7fd2f3a46838, heap_no=48, index=0x7fd2d8014440, thr=0x7fd2cc009818) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd2f3a46838, rec=0x7fd2f4bed327 "test_dbheroPRIMARYn_diff_pfx01", index=0x7fd2d8014440, offsets=0x7fd2c4ff70f0, mode=LOCK_X, gap_mode=0, thr=0x7fd2cc009818)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7fd2cc0089b8, rec=0x7fd2f4bed327 "test_dbheroPRIMARYn_diff_pfx01", index=0x7fd2d8014440, offsets=0x7fd2c4ff70f0, mode=3, type=0, thr=0x7fd2cc009818, mtr=0x7fd2c4ff7410)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a474e0 in row_sel (node=0x7fd2cc0088b8, thr=0x7fd2cc009818) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1860
	#4  0x0000000001a483b4 in row_sel_step (thr=0x7fd2cc009818) at /usr/local/mysql/storage/innobase/row/row0sel.cc:2404
	#5  0x00000000019bd8b7 in que_thr_step (thr=0x7fd2cc009818) at /usr/local/mysql/storage/innobase/que/que0que.cc:1027
	#6  0x00000000019bdbcb in que_run_threads_low (thr=0x7fd2cc009818) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#7  0x00000000019bdd81 in que_run_threads (thr=0x7fd2cc009818) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#8  0x00000000019be037 in que_eval_sql (info=0x7fd2cc000b70, 
		sql=0x2295448 "PROCEDURE INDEX_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_index_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name AND\nindex_name = :index_name AND\nstat_name = :stat_name;"..., reserve_dict_mutex=0, 
		trx=0x7fd3008ab150) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#9  0x0000000001bbe7a1 in dict_stats_exec_sql (pinfo=0x7fd2cc000b70, 
		sql=0x2295448 "PROCEDURE INDEX_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_index_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name AND\nindex_name = :index_name AND\nstat_name = :stat_name;"..., trx=0x7fd3008ab150)
		at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:311
	#10 0x0000000001bc2043 in dict_stats_save_index_stat (index=0x7fd2cc001330, last_update=1625537413, stat_name=0x7fd2c4ff8530 "n_diff_pfx01", stat_value=5, sample_size=0x7fd2cc0015b8, stat_description=0x7fd2c4ff8130 "number", trx=0x7fd3008ab150)
		at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2339
	#11 0x0000000001bc26f1 in dict_stats_save (table_orig=0x7fd2fc012ad0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2504
	#12 0x0000000001bc3bc5 in dict_stats_update (table=0x7fd2fc012ad0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
	#13 0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
	#14 0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
	#15 0x00007fd30c6d9ea5 in start_thread () from /lib64/libpthread.so.0
	#16 0x00007fd30b59f9fd in clone () from /lib64/libc.so.6


3.2.2 非原地更新-先delete再insert


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
											

3.2.3 小结
	
	1. 函数调用栈：
	
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
	2. 语句的加锁范围
		primary key: record key: id=8
		idx_name: record key: (name="c曹操",id=8)
		注意：加锁的基本单位是next key lock, 所以是先加 next key lock: (3, 8]，然后再退化为 id=8 的行锁。
		
	3. 二级索引的更新总是delete+insert方式进行。


