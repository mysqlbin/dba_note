

1. UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `ID` = 7961;
2. UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nPlayerID` = 124442;
3. UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `ID` = 7967;
4. UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nClubID` = 666138;



1. UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `ID` = 7961;

begin;
UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `ID` = 7961;
Query OK, 1 row affected (4.11 sec)


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
[Switching to Thread 0x7ff7d40d8700 (LWP 9779)]

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36faff8, heap_no=154, index=0x7ff7ecd7a100, thr=0x7ff7ec977958) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36faff8, heap_no=154, index=0x7ff7ecd7a100, thr=0x7ff7ec977958) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7ff7e36faff8, rec=0x7ff7e564f8cd "", index=0x7ff7ecd7a100, offsets=0x7ff7d40d4880, mode=LOCK_X, gap_mode=1024, thr=0x7ff7ec977958) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7ff7ec977108, rec=0x7ff7e564f8cd "", index=0x7ff7ecd7a100, offsets=0x7ff7d40d4880, mode=3, type=1024, thr=0x7ff7ec977958, mtr=0x7ff7d40d4ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7ff7ec975780 "\377", mode=PAGE_CUR_GE, prebuilt=0x7ff7ec976ee0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7ff7ec973990, buf=0x7ff7ec975780 "\377", key_ptr=0x7ff7ec979610 "\031\037", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7ff7ec973990, buf=0x7ff7ec975780 "\377", key=0x7ff7ec979610 "\031\037", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7ff7ec973990, buf=0x7ff7ec975780 "\377", key=0x7ff7ec979610 "\031\037", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7ff7ec973990, start_key=0x7ff7ec973a78, end_key=0x7ff7ec973a98, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7ff7ec973990, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7ff7ec973bf0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7ff7ec973990, range_info=0x7ff7d40d5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7ff7ec0221a0) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7ff7d40d5dd0) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000015e7b84 in mysql_update (thd=0x7ff7ecd7dc20, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7ff7d40d6428, updated_return=0x7ff7d40d6420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7ff7ec01f2e0, thd=0x7ff7ecd7dc20, switch_to_multitable=0x7ff7d40d64cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7ff7ec01f2e0, thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x7ff7ecd7dc20, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x7ff7ecd7dc20, parser_state=0x7ff7d40d7690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x7ff7ecd7dc20, com_data=0x7ff7d40d7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x495cb10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3c29f90) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007ff7fbd59ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007ff7fac1f9fd in clone () from /lib64/libc.so.6


第二次执行
	
	(gdb) b lock_rec_lock
	Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
	(gdb) c
	Continuing.
	[Switching to Thread 0x7ff7d40d8700 (LWP 9779)]

	Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36faff8, heap_no=154, index=0x7ff7ecd7a100, thr=0x7ff7ec98f8f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	2040		ut_ad(lock_mutex_own());
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36faff8, heap_no=154, index=0x7ff7ecd7a100, thr=0x7ff7ec98f8f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7ff7e36faff8, rec=0x7ff7e564f8cd "", index=0x7ff7ecd7a100, offsets=0x7ff7d40d4880, mode=LOCK_X, gap_mode=1024, thr=0x7ff7ec98f8f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7ff7ec98f0a8, rec=0x7ff7e564f8cd "", index=0x7ff7ecd7a100, offsets=0x7ff7d40d4880, mode=3, type=1024, thr=0x7ff7ec98f8f8, mtr=0x7ff7d40d4ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7ff7ec98d720 "\377", mode=PAGE_CUR_GE, prebuilt=0x7ff7ec98ee80, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7ff7ec98d310, buf=0x7ff7ec98d720 "\377", key_ptr=0x7ff7ec9915b0 "\031\037", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7ff7ec98d310, buf=0x7ff7ec98d720 "\377", key=0x7ff7ec9915b0 "\031\037", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7ff7ec98d310, buf=0x7ff7ec98d720 "\377", key=0x7ff7ec9915b0 "\031\037", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x7ff7ec98d310, start_key=0x7ff7ec98d3f8, end_key=0x7ff7ec98d418, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7ff7ec98d310, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7ff7ec98d570, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7ff7ec98d310, range_info=0x7ff7d40d5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7ff7ecd78210) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7ff7d40d5dd0) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000015e7b84 in mysql_update (thd=0x7ff7ecd7dc20, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7ff7d40d6428, updated_return=0x7ff7d40d6420) at /usr/local/mysql/sql/sql_update.cc:812
	#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7ff7ec01f2e0, thd=0x7ff7ecd7dc20, switch_to_multitable=0x7ff7d40d64cf) at /usr/local/mysql/sql/sql_update.cc:2891
	#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7ff7ec01f2e0, thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_update.cc:3018
	#16 0x00000000015351f1 in mysql_execute_command (thd=0x7ff7ecd7dc20, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
	#17 0x000000000153a849 in mysql_parse (thd=0x7ff7ecd7dc20, parser_state=0x7ff7d40d7690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7ff7ecd7dc20, com_data=0x7ff7d40d7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x495cb10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3c29f90) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007ff7fbd59ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007ff7fac1f9fd in clone () from /lib64/libc.so.6


---------------------------------------------------------------
2. UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nPlayerID` = 124442;


select id,nPlayerID,nClubID from table_league_club_member WHERE `nPlayerID` = 124442;

mysql> select id,nPlayerID,nClubID from table_league_club_member WHERE `nPlayerID` = 124442;
+------+-----------+---------+
| id   | nPlayerID | nClubID |
+------+-----------+---------+
| 7723 |    124442 |  666000 |
| 7961 |    124442 |  666138 |
+------+-----------+---------+
2 rows in set (0.00 sec)

begin;

UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nPlayerID` = 124442;


(gdb) b lock_rec_lock
Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep n   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
(gdb) c
Continuing.
[Switching to Thread 0x7ff7d40d8700 (LWP 9779)]

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36f99e0, heap_no=242, index=0x7ff7ecd7baf0, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36f99e0, heap_no=242, index=0x7ff7ecd7baf0, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7ff7e36f99e0, rec=0x7ff7e5630cad "\200\001\346\032", index=0x7ff7ecd7baf0, offsets=0x7ff7d40d4880, mode=LOCK_X, gap_mode=1024, thr=0x7ff7ec9a83b8)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7ff7ec9a7b68, rec=0x7ff7e5630cad "\200\001\346\032", index=0x7ff7ecd7baf0, offsets=0x7ff7d40d4880, mode=3, type=1024, thr=0x7ff7ec9a83b8, mtr=0x7ff7d40d4ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7ff7ec9a61e0 "\377", mode=PAGE_CUR_GE, prebuilt=0x7ff7ec9a7940, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\377", key_ptr=0x7ff7ec9aa070 "\032\346\001", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\377", key=0x7ff7ec9aa070 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\377", key=0x7ff7ec9aa070 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7ff7ec9a5dd0, start_key=0x7ff7ec9a5eb8, end_key=0x7ff7ec9a5ed8, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7ff7ec9a5dd0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7ff7ec9a6030, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7ff7ec9a5dd0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7ff7ecd7c470) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7ff7d40d5dd0) at /usr/local/mysql/sql/records.cc:398
c#13 0x00000000015e7b84 in mysql_update (thd=0x7ff7ecd7dc20, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7ff7d40d6428, updated_return=0x7ff7d40d6420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7ff7ec01f2f8, thd=0x7ff7ecd7dc20, switch_to_multitable=0x7ff7d40d64cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7ff7ec01f2f8, thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x7ff7ecd7dc20, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x7ff7ecd7dc20, parser_state=0x7ff7d40d7690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x7ff7ecd7dc20, com_data=0x7ff7d40d7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x495cb10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3c29f90) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007ff7fbd59ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007ff7fac1f9fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36facd0, heap_no=95, index=0x7ff7ecd7a100, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36facd0, heap_no=95, index=0x7ff7ecd7a100, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7ff7e36facd0, rec=0x7ff7e5649f91 "", index=0x7ff7ecd7a100, offsets=0x7ff7d40d4880, mode=LOCK_X, gap_mode=1024, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7ff7ec9a7940, sec_index=0x7ff7ecd7baf0, rec=0x7ff7e5630cad "\200\001\346\032", thr=0x7ff7ec9a83b8, out_rec=0x7ff7d40d5110, offsets=0x7ff7d40d50e8, offset_heap=0x7ff7d40d50f0, vrow=0x0, 
    mtr=0x7ff7d40d4ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7ff7ec9a61e0 "\377", mode=PAGE_CUR_GE, prebuilt=0x7ff7ec9a7940, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\377", key_ptr=0x7ff7ec9aa070 "\032\346\001", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\377", key=0x7ff7ec9aa070 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\377", key=0x7ff7ec9aa070 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7ff7ec9a5dd0, start_key=0x7ff7ec9a5eb8, end_key=0x7ff7ec9a5ed8, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7ff7ec9a5dd0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7ff7ec9a6030, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7ff7ec9a5dd0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7ff7ecd7c470) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7ff7d40d5dd0) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000015e7b84 in mysql_update (thd=0x7ff7ecd7dc20, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7ff7d40d6428, updated_return=0x7ff7d40d6420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7ff7ec01f2f8, thd=0x7ff7ecd7dc20, switch_to_multitable=0x7ff7d40d64cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7ff7ec01f2f8, thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x7ff7ecd7dc20, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x7ff7ecd7dc20, parser_state=0x7ff7d40d7690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x7ff7ecd7dc20, com_data=0x7ff7d40d7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x495cb10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3c29f90) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007ff7fbd59ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007ff7fac1f9fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36f99e0, heap_no=413, index=0x7ff7ecd7baf0, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36f99e0, heap_no=413, index=0x7ff7ecd7baf0, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7ff7e36f99e0, rec=0x7ff7e563155c "\200\001\346\032", index=0x7ff7ecd7baf0, offsets=0x7ff7d40d48e0, mode=LOCK_X, gap_mode=1024, thr=0x7ff7ec9a83b8)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7ff7ec9a7b68, rec=0x7ff7e563155c "\200\001\346\032", index=0x7ff7ecd7baf0, offsets=0x7ff7d40d48e0, mode=3, type=1024, thr=0x7ff7ec9a83b8, mtr=0x7ff7d40d4c00) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7ff7ec9a61e0 "\371+\036", mode=PAGE_CUR_GE, prebuilt=0x7ff7ec9a7940, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\371+\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\371+\036", key=0x7ff7ec9aa078 "\032\346\001", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\371+\036", key=0x7ff7ec9aa078 "\032\346\001", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7ff7ec9a5dd0) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7ff7ec9a5dd0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7ff7ec9a6030, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7ff7ec9a5dd0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7ff7ecd7c470) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7ff7d40d5dd0) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000015e7b84 in mysql_update (thd=0x7ff7ecd7dc20, fields=..., values=..., limit=18446744073709551614, handle_duplicates=DUP_ERROR, found_return=0x7ff7d40d6428, updated_return=0x7ff7d40d6420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7ff7ec01f2f8, thd=0x7ff7ecd7dc20, switch_to_multitable=0x7ff7d40d64cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7ff7ec01f2f8, thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x7ff7ecd7dc20, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x7ff7ecd7dc20, parser_state=0x7ff7d40d7690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x7ff7ecd7dc20, com_data=0x7ff7d40d7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x495cb10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3c29f90) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007ff7fbd59ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007ff7fac1f9fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36faff8, heap_no=154, index=0x7ff7ecd7a100, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36faff8, heap_no=154, index=0x7ff7ecd7a100, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7ff7e36faff8, rec=0x7ff7e564f8cd "", index=0x7ff7ecd7a100, offsets=0x7ff7d40d48e0, mode=LOCK_X, gap_mode=1024, thr=0x7ff7ec9a83b8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7ff7ec9a7940, sec_index=0x7ff7ecd7baf0, rec=0x7ff7e563155c "\200\001\346\032", thr=0x7ff7ec9a83b8, out_rec=0x7ff7d40d5170, offsets=0x7ff7d40d5148, offset_heap=0x7ff7d40d5150, vrow=0x0, 
    mtr=0x7ff7d40d4c00) at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7ff7ec9a61e0 "\371+\036", mode=PAGE_CUR_GE, prebuilt=0x7ff7ec9a7940, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\371+\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\371+\036", key=0x7ff7ec9aa078 "\032\346\001", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7ff7ec9a5dd0, buf=0x7ff7ec9a61e0 "\371+\036", key=0x7ff7ec9aa078 "\032\346\001", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7ff7ec9a5dd0) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7ff7ec9a5dd0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7ff7ec9a6030, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7ff7ec9a5dd0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7ff7ecd7c470) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7ff7d40d5dd0) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000015e7b84 in mysql_update (thd=0x7ff7ecd7dc20, fields=..., values=..., limit=18446744073709551614, handle_duplicates=DUP_ERROR, found_return=0x7ff7d40d6428, updated_return=0x7ff7d40d6420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7ff7ec01f2f8, thd=0x7ff7ecd7dc20, switch_to_multitable=0x7ff7d40d64cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7ff7ec01f2f8, thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x7ff7ecd7dc20, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x7ff7ecd7dc20, parser_state=0x7ff7d40d7690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x7ff7ecd7dc20, com_data=0x7ff7d40d7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x495cb10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3c29f90) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007ff7fbd59ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007ff7fac1f9fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

3. UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `ID` = 7967;

begin;
UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `ID` = 7967;



(gdb) b lock_rec_lock
Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep n   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
(gdb) c
Continuing.
[Switching to Thread 0x7ff7d40d8700 (LWP 9779)]

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36faff8, heap_no=160, index=0x7ff7ecd7a100, thr=0x7ff7ec9bf398) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7ff7e36faff8, heap_no=160, index=0x7ff7ecd7a100, thr=0x7ff7ec9bf398) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7ff7e36faff8, rec=0x7ff7e564fab8 "", index=0x7ff7ecd7a100, offsets=0x7ff7d40d4880, mode=LOCK_X, gap_mode=1024, thr=0x7ff7ec9bf398) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7ff7ec9beb48, rec=0x7ff7e564fab8 "", index=0x7ff7ecd7a100, offsets=0x7ff7d40d4880, mode=3, type=1024, thr=0x7ff7ec9bf398, mtr=0x7ff7d40d4ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7ff7ec9bd1c0 "\377", mode=PAGE_CUR_GE, prebuilt=0x7ff7ec9be920, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7ff7ec9bcdb0, buf=0x7ff7ec9bd1c0 "\377", key_ptr=0x7ff7ec9c1050 "\037\037", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7ff7ec9bcdb0, buf=0x7ff7ec9bd1c0 "\377", key=0x7ff7ec9c1050 "\037\037", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7ff7ec9bcdb0, buf=0x7ff7ec9bd1c0 "\377", key=0x7ff7ec9c1050 "\037\037", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7ff7ec9bcdb0, start_key=0x7ff7ec9bce98, end_key=0x7ff7ec9bceb8, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7ff7ec9bcdb0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7ff7ec9bd010, range_info=0x7ff7d40d5c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7ff7ec9bcdb0, range_info=0x7ff7d40d5c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7ff7ec96ffc0) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7ff7d40d5dd0) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000015e7b84 in mysql_update (thd=0x7ff7ecd7dc20, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7ff7d40d6428, updated_return=0x7ff7d40d6420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7ff7ec01f2e0, thd=0x7ff7ecd7dc20, switch_to_multitable=0x7ff7d40d64cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7ff7ec01f2e0, thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x7ff7ecd7dc20, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x7ff7ecd7dc20, parser_state=0x7ff7d40d7690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x7ff7ecd7dc20, com_data=0x7ff7d40d7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x7ff7ecd7dc20) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x495cb10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3c29f90) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007ff7fbd59ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007ff7fac1f9fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

4. UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nClubID` = 666138;


begin;
UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nClubID` = 666138;


mysql> desc UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nClubID` = 666138;
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
| id | select_type | table                    | partitions | type  | possible_keys | key         | key_len | ref   | rows | filtered | Extra       |
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
|  1 | UPDATE      | table_league_club_member | NULL       | range | idx_nClubID   | idx_nClubID | 8       | const |   17 |   100.00 | Using where |
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
1 row in set (0.00 sec)

mysql> desc UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nClubID` = 666138 limit 1;
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
| id | select_type | table                    | partitions | type  | possible_keys | key         | key_len | ref   | rows | filtered | Extra       |
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
|  1 | UPDATE      | table_league_club_member | NULL       | range | idx_nClubID   | idx_nClubID | 8       | const |   17 |   100.00 | Using where |
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
1 row in set (0.01 sec)


mysql> delete from  `table_league_club_member`  WHERE  `nClubID` = 666138 limit 16;
Query OK, 16 rows affected (0.09 sec)


mysql> desc UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nClubID` = 666138;
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
| id | select_type | table                    | partitions | type  | possible_keys | key         | key_len | ref   | rows | filtered | Extra       |
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
|  1 | UPDATE      | table_league_club_member | NULL       | range | idx_nClubID   | idx_nClubID | 8       | const |    1 |   100.00 | Using where |
+----+-------------+--------------------------+------------+-------+---------------+-------------+---------+-------+------+----------+-------------+
1 row in set (0.02 sec)


mysql> select id,nPlayerID,nClubID from table_league_club_member where `nClubID` = 666138;
+------+-----------+---------+
| id   | nPlayerID | nClubID |
+------+-----------+---------+
| 8958 |    124894 |  666138 |
+------+-----------+---------+
1 row in set (0.00 sec)


UPDATE `table_league_club_member` SET `ID` = 7961 WHERE  `nClubID` = 666138;
mysql> select id,nPlayerID,nClubID from table_league_club_member where `nClubID` = 666138;
+------+-----------+---------+
| id   | nPlayerID | nClubID |
+------+-----------+---------+
| 7961 |    124894 |  666138 |
+------+-----------+---------+
1 row in set (0.00 sec)


begin;
UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE  `nClubID` = 666138;

(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
(gdb) b lock_rec_lock
Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep n   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
(gdb) c
Continuing.
[Switching to Thread 0x7f06640b5700 (LWP 9917)]

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f0675b06a40, heap_no=24, index=0x6f64ad0, thr=0x6f8d3e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7f0675b06a40, heap_no=24, index=0x6f64ad0, thr=0x6f8d3e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7f0675b06a40, rec=0x7f06776dc1f3 "\200", index=0x6f64ad0, offsets=0x7f06640b1880, mode=LOCK_X, gap_mode=1024, thr=0x6f8d3e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x6f8cb98, rec=0x7f06776dc1f3 "\200", index=0x6f64ad0, offsets=0x7f06640b1880, mode=3, type=1024, thr=0x6f8d3e8, mtr=0x7f06640b1ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6f8b210 "\377", mode=PAGE_CUR_GE, prebuilt=0x6f8c970, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6f8ae00, buf=0x6f8b210 "\377", key_ptr=0x6f8f0a0 "\032*\n", key_len=8, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x6f8ae00, buf=0x6f8b210 "\377", key=0x6f8f0a0 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x6f8ae00, buf=0x6f8b210 "\377", key=0x6f8f0a0 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x6f8ae00, start_key=0x6f8aee8, end_key=0x6f8af08, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x6f8ae00, range_info=0x7f06640b2c30) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x6f8b060, range_info=0x7f06640b2c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x6f8ae00, range_info=0x7f06640b2c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x65b1e30) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7f06640b2dd0) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000015e7b84 in mysql_update (thd=0x65f2f90, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f06640b3428, updated_return=0x7f06640b3420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x6f66cb0, thd=0x65f2f90, switch_to_multitable=0x7f06640b34cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x6f66cb0, thd=0x65f2f90) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x65f2f90, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x65f2f90, parser_state=0x7f06640b4690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x65f2f90, com_data=0x7f06640b4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x65f2f90) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x65e1320) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x562f160) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007f068dffbea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007f068cec19fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f0675b06d68, heap_no=162, index=0x6f58810, thr=0x6f8d3e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7f0675b06d68, heap_no=162, index=0x6f58810, thr=0x6f8d3e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f0675b06d68, rec=0x7f06776e3b62 "", index=0x6f58810, offsets=0x7f06640b1880, mode=LOCK_X, gap_mode=1024, thr=0x6f8d3e8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x6f8c970, sec_index=0x6f64ad0, rec=0x7f06776dc1f3 "\200", thr=0x6f8d3e8, out_rec=0x7f06640b2110, offsets=0x7f06640b20e8, offset_heap=0x7f06640b20f0, vrow=0x0, mtr=0x7f06640b1ba0)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x6f8b210 "\377", mode=PAGE_CUR_GE, prebuilt=0x6f8c970, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6f8ae00, buf=0x6f8b210 "\377", key_ptr=0x6f8f0a0 "\032*\n", key_len=8, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x6f8ae00, buf=0x6f8b210 "\377", key=0x6f8f0a0 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x6f8ae00, buf=0x6f8b210 "\377", key=0x6f8f0a0 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x6f8ae00, start_key=0x6f8aee8, end_key=0x6f8af08, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x6f8ae00, range_info=0x7f06640b2c30) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x6f8b060, range_info=0x7f06640b2c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x6f8ae00, range_info=0x7f06640b2c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x65b1e30) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7f06640b2dd0) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000015e7b84 in mysql_update (thd=0x65f2f90, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f06640b3428, updated_return=0x7f06640b3420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x6f66cb0, thd=0x65f2f90, switch_to_multitable=0x7f06640b34cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x6f66cb0, thd=0x65f2f90) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x65f2f90, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x65f2f90, parser_state=0x7f06640b4690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x65f2f90, com_data=0x7f06640b4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x65f2f90) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x65e1320) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x562f160) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007f068dffbea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007f068cec19fd in clone () from /lib64/libc.so.6
(gdb) c


