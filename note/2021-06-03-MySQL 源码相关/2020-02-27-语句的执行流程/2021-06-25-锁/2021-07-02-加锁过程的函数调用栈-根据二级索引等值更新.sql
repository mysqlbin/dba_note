	

1. 初始化表结构和数据
2. b lock_rec_lock
3. 二级索引等值更新加锁
	3.1 RC隔离级别
	3.2 RR隔离级别

4. 小结


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


3. 二级索引等值更新加锁

3.1 RC隔离级别

	mysql> show global variables like 'tx_isolation';
	+---------------+----------------+
	| Variable_name | Value          |
	+---------------+----------------+
	| tx_isolation  | READ-COMMITTED |
	+---------------+----------------+
	1 row in set (0.00 sec)
	
	update hero set country='中' where name='c曹操';
	
	mysql> desc update hero set country='中' where name='c曹操';
	+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
	|  1 | UPDATE      | hero  | NULL       | range | idx_name      | idx_name | 403     | const |    1 |   100.00 | Using where |
	+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
	1 row in set (0.02 sec)

	b lock_rec_lock_fast	
	b lock_rec_lock_slow	
		
	(gdb) b lock_rec_lock_fast
	Breakpoint 2 at 0x1942d51: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 1871.
	(gdb) b lock_rec_lock_fast
	Note: breakpoint 2 also set at pc 0x1942d51.
	Breakpoint 3 at 0x1942d51: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 1871.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   0x0000000001942d51 in lock_rec_lock_fast(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	3       breakpoint     keep y   0x0000000001942d51 in lock_rec_lock_fast(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f397815e700 (LWP 3773)]

	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=1027, block=0x7f396ba45870, heap_no=4, index=0x7f39580168d0, thr=0x7f395800ef08) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=1027, block=0x7f396ba45870, heap_no=4, index=0x7f39580168d0, thr=0x7f395800ef08) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1027, block=0x7f396ba45870, heap_no=4, index=0x7f39580168d0, thr=0x7f395800ef08) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- mode=LOCK_X, 排他锁，先锁住二级的记录
	-- gap_mode=1024：#define LOCK_REC_NOT_GAP  1024 。行锁。
	#2  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7f396ba45870, rec=0x7f396cbd80a6 "c曹操\200", index=0x7f39580168d0, offsets=0x7f397815a880, mode=LOCK_X, gap_mode=1024, thr=0x7f395800ef08)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#3  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7f395800e988, rec=0x7f396cbd80a6 "c曹操\200", index=0x7f39580168d0, offsets=0x7f397815a880, mode=3, type=1024, thr=0x7f395800ef08, mtr=0x7f397815aba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x7f3958027240 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f395800e770, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	-- key_len=403：使用的索引长度
	-- find_flag=HA_READ_KEY_EXACT：精确查找
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7f3958026e30, buf=0x7f3958027240 "\377", key_ptr=0x7f3958953650 "", key_len=403, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7f3958026e30, buf=0x7f3958027240 "\377", key=0x7f3958953650 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7f3958026e30, buf=0x7f3958027240 "\377", key=0x7f3958953650 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x0000000000f34e8f in handler::read_range_first (this=0x7f3958026e30, start_key=0x7f3958026f18, end_key=0x7f3958026f38, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#9  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f3958026e30, range_info=0x7f397815bc30) at /usr/local/mysql/sql/handler.cc:6450
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f3958027090, range_info=0x7f397815bc30) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f3958026e30, range_info=0x7f397815bc30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f39580280d0) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x7f397815bdd0) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000015e7b84 in mysql_update (thd=0x7f395801c2e0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f397815c428, updated_return=0x7f397815c420) at /usr/local/mysql/sql/sql_update.cc:812
	#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f395801aa48, thd=0x7f395801c2e0, switch_to_multitable=0x7f397815c4cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f395801aa48, thd=0x7f395801c2e0) at /usr/local/mysql/sql/sql_update.cc:3018
	#17 0x00000000015351f1 in mysql_execute_command (thd=0x7f395801c2e0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#18 0x000000000153a849 in mysql_parse (thd=0x7f395801c2e0, parser_state=0x7f397815d690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#19 0x00000000015302d8 in dispatch_command (thd=0x7f395801c2e0, com_data=0x7f397815ddf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#20 0x000000000152f20c in do_command (thd=0x7f395801c2e0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#21 0x000000000165f7c8 in handle_connection (arg=0x5958610) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x5e84190) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#23 0x00007f3984478ea5 in start_thread () from /lib64/libpthread.so.0
	#24 0x00007f398333e9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=1027, block=0x7f396ba45ec0, heap_no=10, index=0x7f3958015d60, thr=0x7f395800ef08) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=1027, block=0x7f396ba45ec0, heap_no=10, index=0x7f3958015d60, thr=0x7f395800ef08) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1027, block=0x7f396ba45ec0, heap_no=10, index=0x7f3958015d60, thr=0x7f395800ef08) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- mode=LOCK_X，再锁主键索引的记录
	#2  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f396ba45ec0, rec=0x7f396cbe019b "\200", index=0x7f3958015d60, offsets=0x7f397815a880, mode=LOCK_X, gap_mode=1024, thr=0x7f395800ef08)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	-- 根据二级索引的记录回表查找主键索引的记录
	#3  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7f395800e770, sec_index=0x7f39580168d0, rec=0x7f396cbd80a6 "c曹操\200", thr=0x7f395800ef08, out_rec=0x7f397815b110, offsets=0x7f397815b0e8, offset_heap=0x7f397815b0f0, vrow=0x0, mtr=0x7f397815aba0)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#4  0x0000000001a4f94a in row_search_mvcc (buf=0x7f3958027240 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f395800e770, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x7f3958026e30, buf=0x7f3958027240 "\377", key_ptr=0x7f3958953650 "", key_len=403, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x7f3958026e30, buf=0x7f3958027240 "\377", key=0x7f3958953650 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7f3958026e30, buf=0x7f3958027240 "\377", key=0x7f3958953650 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x0000000000f34e8f in handler::read_range_first (this=0x7f3958026e30, start_key=0x7f3958026f18, end_key=0x7f3958026f38, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#9  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f3958026e30, range_info=0x7f397815bc30) at /usr/local/mysql/sql/handler.cc:6450
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f3958027090, range_info=0x7f397815bc30) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f3958026e30, range_info=0x7f397815bc30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f39580280d0) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x7f397815bdd0) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000015e7b84 in mysql_update (thd=0x7f395801c2e0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f397815c428, updated_return=0x7f397815c420) at /usr/local/mysql/sql/sql_update.cc:812
	#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f395801aa48, thd=0x7f395801c2e0, switch_to_multitable=0x7f397815c4cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f395801aa48, thd=0x7f395801c2e0) at /usr/local/mysql/sql/sql_update.cc:3018
	#17 0x00000000015351f1 in mysql_execute_command (thd=0x7f395801c2e0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#18 0x000000000153a849 in mysql_parse (thd=0x7f395801c2e0, parser_state=0x7f397815d690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#19 0x00000000015302d8 in dispatch_command (thd=0x7f395801c2e0, com_data=0x7f397815ddf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#20 0x000000000152f20c in do_command (thd=0x7f395801c2e0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#21 0x000000000165f7c8 in handle_connection (arg=0x5958610) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x5e84190) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#23 0x00007f3984478ea5 in start_thread () from /lib64/libpthread.so.0
	#24 0x00007f398333e9fd in clone () from /lib64/libc.so.6


	1. 首先根据二级索引查找记录，对二级索引记录加锁
	
		ha_innobase::index_read
			->row_search_mvcc
				->sel_set_rec_lock
					->lock_sec_rec_read_check_and_lock
						->lock_rec_lock
							->lock_rec_lock_fast
				
	2. 根据二级索引记录回到主键索引进行加锁
	
		ha_innobase::index_read
			->row_search_mvcc
				->row_sel_get_clust_rec_for_mysql
					->lock_clust_rec_read_check_and_lock
						->lock_rec_lock
							->lock_rec_lock_fast
	
		把1和2合并来看
	
			ha_innobase::index_read
				->row_search_mvcc
					-- 判断是否给主键索引还是二级索引的记录加锁
					->sel_set_rec_lock
						--对二级索引的记录进行加锁
						->lock_sec_rec_read_check_and_lock
							->lock_rec_lock
								->lock_rec_lock_fast
								
						--对主键索引的记录进行加锁			
						->row_sel_get_clust_rec_for_mysql
							->lock_clust_rec_read_check_and_lock
								->lock_rec_lock
									->lock_rec_lock_fast			
	
		获得主键记录后，就可以执行更新了(row_update_for_mysql)
	
	3. 第三次，扫描下一条记录，看看是否满足条件。
		-- RC隔离级别下不走这个流程
	
	
	4. 语句的加锁范围
		idx_name: record key: (name="c曹操",id=8)
		primary key: record key: id=8
		注意：这个语句需要访问到 name="l刘备" 这行记录并加锁，但是这行记录并不满足查询条件，所以会把 name="l刘备" 的行锁释放掉。

3.2 RR隔离级别	

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


	mysql> desc update hero set country='中' where name='c曹操';
	+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
	|  1 | UPDATE      | hero  | NULL       | range | idx_name      | idx_name | 403     | const |    1 |   100.00 | Using where |
	+----+-------------+-------+------------+-------+---------------+----------+---------+-------+------+----------+-------------+
	1 row in set (0.00 sec)


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
	2       breakpoint     keep y   0x0000000001942d51 in lock_rec_lock_fast(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	3       breakpoint     keep y   0x0000000001943191 in lock_rec_lock_slow(ulint, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1952
	(gdb) c
	Continuing.
	[Switching to Thread 0x7f02000e8700 (LWP 4190)]

	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=3, block=0x7f01f201b1e8, heap_no=4, index=0x5572240, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=3, block=0x7f01f201b1e8, heap_no=4, index=0x5572240, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=3, block=0x7f01f201b1e8, heap_no=4, index=0x5572240, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- gap_mode=0：#define LOCK_ORDINARY     0。表示加的是 next-key lock。
	#2  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7f01f201b1e8, rec=0x7f01f31bc0a6 "c曹操\200", index=0x5572240, offsets=0x7f02000e4880, mode=LOCK_X, gap_mode=0, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#3  0x0000000001a465fe in sel_set_rec_lock (pcur=0x552d2b8, rec=0x7f01f31bc0a6 "c曹操\200", index=0x5572240, offsets=0x7f02000e4880, mode=3, type=0, thr=0x552d838, mtr=0x7f02000e4ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#4  0x0000000001a4f23c in row_search_mvcc (buf=0x5522410 "\377", mode=PAGE_CUR_GE, prebuilt=0x552d0a0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x5522000, buf=0x5522410 "\377", key_ptr=0x5e9e660 "", key_len=403, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x5522000, buf=0x5522410 "\377", key=0x5e9e660 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x5522000, buf=0x5522410 "\377", key=0x5e9e660 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x0000000000f34e8f in handler::read_range_first (this=0x5522000, start_key=0x55220e8, end_key=0x5522108, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#9  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x5522000, range_info=0x7f02000e5c30) at /usr/local/mysql/sql/handler.cc:6450
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5522260, range_info=0x7f02000e5c30) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5522000, range_info=0x7f02000e5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5513ee0) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x7f02000e5dd0) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000015e7b84 in mysql_update (thd=0x5545ac0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f02000e6428, updated_return=0x7f02000e6420) at /usr/local/mysql/sql/sql_update.cc:812
	#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x551e4f8, thd=0x5545ac0, switch_to_multitable=0x7f02000e64cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x551e4f8, thd=0x5545ac0) at /usr/local/mysql/sql/sql_update.cc:3018
	#17 0x00000000015351f1 in mysql_execute_command (thd=0x5545ac0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#18 0x000000000153a849 in mysql_parse (thd=0x5545ac0, parser_state=0x7f02000e7690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#19 0x00000000015302d8 in dispatch_command (thd=0x5545ac0, com_data=0x7f02000e7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#20 0x000000000152f20c in do_command (thd=0x5545ac0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#21 0x000000000165f7c8 in handle_connection (arg=0x54ea210) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4715310) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#23 0x00007f020b0c6ea5 in start_thread () from /lib64/libpthread.so.0
	#24 0x00007f0209f8c9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 2, lock_rec_lock_fast (impl=false, mode=1027, block=0x7f01f201ab98, heap_no=11, index=0x55718d0, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	1871		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_fast (impl=false, mode=1027, block=0x7f01f201ab98, heap_no=11, index=0x55718d0, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1871
	#1  0x00000000019437c8 in lock_rec_lock (impl=false, mode=1027, block=0x7f01f201ab98, heap_no=11, index=0x55718d0, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2055
	-- gap_mode=1024：#define LOCK_REC_NOT_GAP  1024 。行锁。
	#2  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f01f201ab98, rec=0x7f01f31b41be "\200", index=0x55718d0, offsets=0x7f02000e4880, mode=LOCK_X, gap_mode=1024, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#3  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x552d0a0, sec_index=0x5572240, rec=0x7f01f31bc0a6 "c曹操\200", thr=0x552d838, out_rec=0x7f02000e5110, offsets=0x7f02000e50e8, offset_heap=0x7f02000e50f0, vrow=0x0, mtr=0x7f02000e4ba0)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#4  0x0000000001a4f94a in row_search_mvcc (buf=0x5522410 "\377", mode=PAGE_CUR_GE, prebuilt=0x552d0a0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#5  0x00000000018c1784 in ha_innobase::index_read (this=0x5522000, buf=0x5522410 "\377", key_ptr=0x5e9e660 "", key_len=403, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#6  0x0000000000f39602 in handler::index_read_map (this=0x5522000, buf=0x5522410 "\377", key=0x5e9e660 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#7  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x5522000, buf=0x5522410 "\377", key=0x5e9e660 "", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#8  0x0000000000f34e8f in handler::read_range_first (this=0x5522000, start_key=0x55220e8, end_key=0x5522108, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#9  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x5522000, range_info=0x7f02000e5c30) at /usr/local/mysql/sql/handler.cc:6450
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5522260, range_info=0x7f02000e5c30) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5522000, range_info=0x7f02000e5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5513ee0) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x7f02000e5dd0) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000015e7b84 in mysql_update (thd=0x5545ac0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f02000e6428, updated_return=0x7f02000e6420) at /usr/local/mysql/sql/sql_update.cc:812
	#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x551e4f8, thd=0x5545ac0, switch_to_multitable=0x7f02000e64cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x551e4f8, thd=0x5545ac0) at /usr/local/mysql/sql/sql_update.cc:3018
	#17 0x00000000015351f1 in mysql_execute_command (thd=0x5545ac0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#18 0x000000000153a849 in mysql_parse (thd=0x5545ac0, parser_state=0x7f02000e7690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#19 0x00000000015302d8 in dispatch_command (thd=0x5545ac0, com_data=0x7f02000e7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#20 0x000000000152f20c in do_command (thd=0x5545ac0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#21 0x000000000165f7c8 in handle_connection (arg=0x54ea210) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4715310) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#23 0x00007f020b0c6ea5 in start_thread () from /lib64/libpthread.so.0
	#24 0x00007f0209f8c9fd in clone () from /lib64/libc.so.6
	(gdb) c
	Continuing.

	Breakpoint 3, lock_rec_lock_slow (impl=0, mode=515, block=0x7f01f201b1e8, heap_no=2, index=0x5572240, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1952
	1952		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock_slow (impl=0, mode=515, block=0x7f01f201b1e8, heap_no=2, index=0x5572240, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:1952
	#1  0x000000000194380c in lock_rec_lock (impl=false, mode=515, block=0x7f01f201b1e8, heap_no=2, index=0x5572240, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2062
	-- #define LOCK_GAP    	  512 ： gap lock。
	#2  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7f01f201b1e8, rec=0x7f01f31bc07f "l刘备\200", index=0x5572240, offsets=0x7f02000e48e0, mode=LOCK_X, gap_mode=512, thr=0x552d838) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
	#3  0x0000000001a465fe in sel_set_rec_lock (pcur=0x552d2b8, rec=0x7f01f31bc07f "l刘备\200", index=0x5572240, offsets=0x7f02000e48e0, mode=3, type=512, thr=0x552d838, mtr=0x7f02000e4c00) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
	#4  0x0000000001a4eedb in row_search_mvcc (buf=0x5522410 "\374\b", mode=PAGE_CUR_GE, prebuilt=0x552d0a0, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5402
	#5  0x00000000018c249a in ha_innobase::general_fetch (this=0x5522000, buf=0x5522410 "\374\b", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
	#6  0x00000000018c270f in ha_innobase::index_next_same (this=0x5522000, buf=0x5522410 "\374\b", key=0x5e9e7f8 "", keylen=403) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
	#7  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x5522000, buf=0x5522410 "\374\b", key=0x5e9e7f8 "", keylen=403) at /usr/local/mysql/sql/handler.cc:3263
	-- 扫描下一条记录，看看是否满足条件。
	-- 下一行记录：name="l刘备"
	#8  0x0000000000f34fa7 in handler::read_range_next (this=0x5522000) at /usr/local/mysql/sql/handler.cc:7426
	#9  0x0000000000f32d19 in handler::multi_range_read_next (this=0x5522000, range_info=0x7f02000e5c30) at /usr/local/mysql/sql/handler.cc:6429
	#10 0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x5522260, range_info=0x7f02000e5c30) at /usr/local/mysql/sql/handler.cc:6837
	#11 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x5522000, range_info=0x7f02000e5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#12 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5513ee0) at /usr/local/mysql/sql/opt_range.cc:11233
	#13 0x0000000001457dba in rr_quick (info=0x7f02000e5dd0) at /usr/local/mysql/sql/records.cc:398
	#14 0x00000000015e7b84 in mysql_update (thd=0x5545ac0, fields=..., values=..., limit=18446744073709551614, handle_duplicates=DUP_ERROR, found_return=0x7f02000e6428, updated_return=0x7f02000e6420) at /usr/local/mysql/sql/sql_update.cc:812
	#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x551e4f8, thd=0x5545ac0, switch_to_multitable=0x7f02000e64cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x551e4f8, thd=0x5545ac0) at /usr/local/mysql/sql/sql_update.cc:3018
	#17 0x00000000015351f1 in mysql_execute_command (thd=0x5545ac0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#18 0x000000000153a849 in mysql_parse (thd=0x5545ac0, parser_state=0x7f02000e7690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#19 0x00000000015302d8 in dispatch_command (thd=0x5545ac0, com_data=0x7f02000e7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#20 0x000000000152f20c in do_command (thd=0x5545ac0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#21 0x000000000165f7c8 in handle_connection (arg=0x54ea210) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4715310) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#23 0x00007f020b0c6ea5 in start_thread () from /lib64/libpthread.so.0
	#24 0x00007f0209f8c9fd in clone () from /lib64/libc.so.6


	1. 首先根据二级索引查找记录，对二级索引记录加锁
	
		ha_innobase::index_read
			->row_search_mvcc
				->sel_set_rec_lock
					->lock_sec_rec_read_check_and_lock
						->lock_rec_lock
							->lock_rec_lock_fast
				
	2. 根据二级索引记录回到主键索引进行加锁
	
		ha_innobase::index_read
			->row_search_mvcc
				->row_sel_get_clust_rec_for_mysql
					->lock_clust_rec_read_check_and_lock
						->lock_rec_lock
							->lock_rec_lock_fast
	
		把1和2合并来看
		
			ha_innobase::index_read
				->row_search_mvcc
					-- 判断是否给主键索引还是二级索引的记录加锁
					->sel_set_rec_lock
						--对二级索引的记录进行加锁
						->lock_sec_rec_read_check_and_lock
							->lock_rec_lock
								->lock_rec_lock_fast
								
						--对主键索引的记录进行加锁			
						->row_sel_get_clust_rec_for_mysql
							->lock_clust_rec_read_check_and_lock
								->lock_rec_lock
									->lock_rec_lock_fast			
		
		获得主键记录后，就可以执行更新了(row_update_for_mysql)
	
	3. 第三次，扫描下一条记录，看看是否满足条件。
		-- 需要访问到不满足的第一行记录为止
		ha_innobase::general_fetch
			->row_search_mvcc
				->sel_set_rec_lock
					->lock_sec_rec_read_check_and_lock
						->lock_rec_lock->lock_rec_lock_slow
						
		-- RC隔离级别下不需要走这个流程	
		
	
	4. 语句的加锁范围
		idx_name: next key lock: (-∞, "c曹操"] + gap lock: ("c曹操", "l刘备")
		primary key: record key: id=8
		
		注意：这个语句需要访问到 name="l刘备" 这行记录并加锁，但是因为是二级索引上的等值查询，所以需要加 gap lock: ("c曹操", "l刘备")，并且会把 name="l刘备" 的行锁释放掉 。


4. 小结
	
	通过函数调用栈，明白SQL语句最终需要加的锁。
	
	update hero set country='中' where name='c曹操' 语句加锁范围：
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
		
		RC隔离级别
			idx_name: record key: (name="c曹操",id=8)
			primary key: record key: id=8	
					
		RR隔离级别
			idx_name: next key lock: (-∞, "c曹操"] + gap lock: ("c曹操", "l刘备")
			primary key: record key: id=8