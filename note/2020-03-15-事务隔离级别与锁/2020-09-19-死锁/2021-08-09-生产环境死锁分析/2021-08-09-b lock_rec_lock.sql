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
[Switching to Thread 0x7fac3814b700 (LWP 7231)]

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac4709fa90, heap_no=242, index=0x7fac50964c80, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac4709fa90, heap_no=242, index=0x7fac50964c80, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac4709fa90, rec=0x7fac48d70cad "\200\001\346\032", index=0x7fac50964c80, offsets=0x7fac38147800, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af1810)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af0fc0, rec=0x7fac48d70cad "\200\001\346\032", index=0x7fac50964c80, offsets=0x7fac38147800, mode=3, type=1024, thr=0x7fac50af1810, mtr=0x7fac38147b20) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\377", mode=PAGE_CUR_GE, prebuilt=0x7fac50af0da0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\377", key_ptr=0x7fac50aed620 "\032\346\001", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\377", key=0x7fac50aed620 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\377", key=0x7fac50aed620 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7fac50aed690, start_key=0x7fac50aed778, end_key=0x7fac50aed798, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7fac50aed690, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aed8f0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed690, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50967e10) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717af1 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10841
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0408, heap_no=95, index=0x7fac509671e0, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0408, heap_no=95, index=0x7fac509671e0, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0408, rec=0x7fac48d7de1d "", index=0x7fac509671e0, offsets=0x7fac38147800, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af0da0, sec_index=0x7fac50964c80, rec=0x7fac48d70cad "\200\001\346\032", thr=0x7fac50af1810, out_rec=0x7fac38148090, offsets=0x7fac38148068, offset_heap=0x7fac38148070, vrow=0x0, 
    mtr=0x7fac38147b20) at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\377", mode=PAGE_CUR_GE, prebuilt=0x7fac50af0da0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\377", key_ptr=0x7fac50aed620 "\032\346\001", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\377", key=0x7fac50aed620 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\377", key=0x7fac50aed620 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7fac50aed690, start_key=0x7fac50aed778, end_key=0x7fac50aed798, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7fac50aed690, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aed8f0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed690, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50967e10) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717af1 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10841
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=550, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=550, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9c51 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147800, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9c51 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147800, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b20) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371+\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371+\036", key_ptr=0x7fac50aed670 "\032*\n", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371+\036", key=0x7fac50aed670 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371+\036", key=0x7fac50aed670 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7fac50aed990, start_key=0x7fac50aeda78, end_key=0x7fac50aeda98, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=92, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=92, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d81c42 "", index=0x7fac509671e0, offsets=0x7fac38147800, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9c51 "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac38148090, offsets=0x7fac38148068, offset_heap=0x7fac38148070, vrow=0x0, mtr=0x7fac38147b20)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371+\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371+\036", key_ptr=0x7fac50aed670 "\032*\n", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371+\036", key=0x7fac50aed670 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371+\036", key=0x7fac50aed670 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7fac50aed990, start_key=0x7fac50aeda78, end_key=0x7fac50aeda98, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac4709fa90, heap_no=413, index=0x7fac50964c80, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac4709fa90, heap_no=413, index=0x7fac50964c80, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac4709fa90, rec=0x7fac48d7155c "\200\001\346\032", index=0x7fac50964c80, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af1810)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af0fc0, rec=0x7fac48d7155c "\200\001\346\032", index=0x7fac50964c80, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af1810, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\344\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af0da0, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\371\344\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\371\344\036", key=0x7fac50aed628 "\032\346\001", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\371\344\036", key=0x7fac50aed628 "\032\346\001", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed690) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed690, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aed8f0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed690, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50967e10) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=145, index=0x7fac509671e0, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=145, index=0x7fac509671e0, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d8338f "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af1810) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af0da0, sec_index=0x7fac50964c80, rec=0x7fac48d7155c "\200\001\346\032", thr=0x7fac50af1810, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, 
    mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\344\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af0da0, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\371\344\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\371\344\036", key=0x7fac50aed628 "\032\346\001", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed690, buf=0x7fac50ae9ec0 "\371\344\036", key=0x7fac50aed628 "\032\346\001", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed690) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed690, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aed8f0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed690, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50967e10) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=551, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=551, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9c5e "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9c5e "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\031\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\031\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\031\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=94, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=94, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d81cdd "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9c5e "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\031\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\031\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\031\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=552, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=552, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9c6b "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9c6b "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\346\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\346\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\346\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\346\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=106, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=106, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d82277 "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9c6b "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\346\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\346\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\346\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\346\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=553, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=553, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9c78 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9c78 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\362\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\362\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\362\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\362\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=111, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=111, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d823fd "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9c78 "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\362\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\362\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\362\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\362\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=554, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=554, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9c85 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9c85 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\367\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\367\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\367\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\367\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=112, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=112, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d82444 "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9c85 "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\367\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\367\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\367\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\367\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=555, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=555, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9c92 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9c92 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\370\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\370\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\370\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\370\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=122, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=122, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d828c6 "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9c92 "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\370\036", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\370\036", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\370\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\370\036", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=556, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=556, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9c9f "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9c9f "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\002\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\002\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\002\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\002\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=125, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=125, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d829b4 "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9c9f "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\002\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\002\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\002\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\002\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=557, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=557, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9cac "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9cac "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\005\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\005\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\005\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\005\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=128, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=128, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d82ab2 "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9cac "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\005\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\005\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\005\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\005\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=558, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=558, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9cb9 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9cb9 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\b\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\b\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\b\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\b\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=143, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=143, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d832eb "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9cb9 "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\b\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\b\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\b\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\b\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=559, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=559, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9cc6 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9cc6 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\027\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\027\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\027\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\027\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=144, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=144, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d8333d "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9cc6 "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\027\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\027\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\027\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\027\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=560, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a26c0, heap_no=560, index=0x7fac50969790, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fac470a26c0, rec=0x7fac48da9cd3 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x7fac50af2720, rec=0x7fac48da9cd3 "\200\n*\032", index=0x7fac50969790, offsets=0x7fac38147860, mode=3, type=1024, thr=0x7fac50af2f70, mtr=0x7fac38147b80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\030\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\030\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\030\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\030\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=145, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=145, index=0x7fac509671e0, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d8338f "", index=0x7fac509671e0, offsets=0x7fac38147860, mode=LOCK_X, gap_mode=1024, thr=0x7fac50af2f70) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7fac50af2500, sec_index=0x7fac50969790, rec=0x7fac48da9cd3 "\200\n*\032", thr=0x7fac50af2f70, out_rec=0x7fac381480f0, offsets=0x7fac381480c8, offset_heap=0x7fac381480d0, vrow=0x0, mtr=0x7fac38147b80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\030\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50af2500, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\030\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\030\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x7fac50aed990, buf=0x7fac50ae9ec0 "\371\030\037", key=0x7fac50aed678 "\032*\n", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x7fac50aed990) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7fac50aedbf0, range_info=0x7fac38148bb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7fac50aed990, range_info=0x7fac38148bb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7fac50961080) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=145, index=0x7fac509671e0, thr=0x7fac50aec080) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fac470a0730, heap_no=145, index=0x7fac509671e0, thr=0x7fac50aec080) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fac470a0730, rec=0x7fac48d8338f "", index=0x7fac509671e0, offsets=0x7fac38147960, mode=LOCK_X, gap_mode=1024, thr=0x7fac50aec080) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7fac50aeb830, rec=0x7fac48d8338f "", index=0x7fac509671e0, offsets=0x7fac38147960, mode=3, type=1024, thr=0x7fac50aec080, mtr=0x7fac38147c80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7fac50ae9ec0 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x7fac50aeb610, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7fac50ae9ab0, buf=0x7fac50ae9ec0 "\371\031\037", key_ptr=0x7fac50aefd20 "\031\037", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x00000000018c2b27 in ha_innobase::rnd_pos (this=0x7fac50ae9ab0, buf=0x7fac50ae9ec0 "\371\031\037", pos=0x7fac50aefd20 "\031\037") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9292
#6  0x0000000000f2b061 in handler::ha_rnd_pos (this=0x7fac50ae9ab0, buf=0x7fac50ae9ec0 "\371\031\037", pos=0x7fac50aefd20 "\031\037") at /usr/local/mysql/sql/handler.cc:2989
#7  0x0000000001717f26 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x7fac50970060) at /usr/local/mysql/sql/opt_range.cc:10919
#8  0x0000000001457dba in rr_quick (info=0x7fac38148dd0) at /usr/local/mysql/sql/records.cc:398
#9  0x00000000015e7b84 in mysql_update (thd=0x7fac5001c0f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fac38149428, updated_return=0x7fac38149420) at /usr/local/mysql/sql/sql_update.cc:812
#10 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fac500136b8, thd=0x7fac5001c0f0, switch_to_multitable=0x7fac381494cf) at /usr/local/mysql/sql/sql_update.cc:2891
#11 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fac500136b8, thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_update.cc:3018
#12 0x00000000015351f1 in mysql_execute_command (thd=0x7fac5001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#13 0x000000000153a849 in mysql_parse (thd=0x7fac5001c0f0, parser_state=0x7fac3814a690) at /usr/local/mysql/sql/sql_parse.cc:5570
#14 0x00000000015302d8 in dispatch_command (thd=0x7fac5001c0f0, com_data=0x7fac3814adf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#15 0x000000000152f20c in do_command (thd=0x7fac5001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#16 0x000000000165f7c8 in handle_connection (arg=0x6069040) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000001ce7612 in pfs_spawn_thread (arg=0x60b2aa0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#18 0x00007fac5f5ccea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007fac5e4929fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.
bt
