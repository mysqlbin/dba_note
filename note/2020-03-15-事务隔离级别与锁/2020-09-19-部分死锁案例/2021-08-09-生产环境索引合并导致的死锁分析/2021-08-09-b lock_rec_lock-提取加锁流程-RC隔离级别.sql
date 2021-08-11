

(gdb) b lock_rec_lock
Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
(gdb) c
Continuing.
[Switching to Thread 0x7fd1d81af700 (LWP 9475)]

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7113a38, heap_no=242, index=0x684d230, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7113a38, heap_no=242, index=0x684d230, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
-- 锁二级索引 idx_nPlayerID 的记录
-- rec=0x7fd1e8f18cad
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fd1e7113a38, rec=0x7fd1e8f18cad "\200\001\346\032", index=0x684d230, offsets=0x7fd1d81ab800, mode=LOCK_X, gap_mode=1024, thr=0x6856098)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x6855848, rec=0x7fd1e8f18cad "\200\001\346\032", index=0x684d230, offsets=0x7fd1d81ab800, mode=3, type=1024, thr=0x6856098, mtr=0x7fd1d81abb20) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6846b70 "\377", mode=PAGE_CUR_GE, prebuilt=0x6855620, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
-- key_len=4
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6851f20, buf=0x6846b70 "\377", key_ptr=0x6851ea0 "\032\346\001", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740

(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115050, heap_no=95, index=0x684b920, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
-- 锁二级索引 idx_nPlayerID 对应的 主键索引的记录
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115050, heap_no=95, index=0x684b920, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
-- 主键索引的记录: rec=0x7fd1e8f35f91
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd1e7115050, rec=0x7fd1e8f35f91 "", index=0x684b920, offsets=0x7fd1d81ab800, mode=LOCK_X, gap_mode=1024, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414

-- sec_index=0x684d230 对应 二级索引 idx_nPlayerID
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x6855620, sec_index=0x684d230, rec=0x7fd1e8f18cad "\200\001\346\032", thr=0x6856098, out_rec=0x7fd1d81ac090, offsets=0x7fd1d81ac068, offset_heap=0x7fd1d81ac070, vrow=0x0, mtr=0x7fd1d81abb20)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x6846b70 "\377", mode=PAGE_CUR_GE, prebuilt=0x6855620, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6851f20, buf=0x6846b70 "\377", key_ptr=0x6851ea0 "\032\346\001", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740

(gdb) c
Continuing.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e71146d8, heap_no=46, index=0x684dba0, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e71146d8, heap_no=46, index=0x684dba0, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

-- 锁二级索引 idx_nClubID 的记录
-- rec=0x7fd1e8f28369 = 666138
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fd1e71146d8, rec=0x7fd1e8f28369 "\200", index=0x684dba0, offsets=0x7fd1d81ab800, mode=LOCK_X, gap_mode=1024, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x6856fa8, rec=0x7fd1e8f28369 "\200", index=0x684dba0, offsets=0x7fd1d81ab800, mode=3, type=1024, thr=0x68577f8, mtr=0x7fd1d81abb20) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6846b70 "\371+\036", mode=PAGE_CUR_GE, prebuilt=0x6856d80, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
-- key_len=8
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6852220, buf=0x6846b70 "\371+\036", key_ptr=0x6851ef0 "\032*\n", key_len=8, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740

(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
-- 锁二级索引 idx_nClubID 对应的 主键索引的记录
-- rec=0x7fd1e8f3b595 = 7961 
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd1e7115378, rec=0x7fd1e8f3b595 "", index=0x684b920, offsets=0x7fd1d81ab800, mode=LOCK_X, gap_mode=1024, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x6856d80, sec_index=0x684dba0, rec=0x7fd1e8f28369 "\200", thr=0x68577f8, out_rec=0x7fd1d81ac090, offsets=0x7fd1d81ac068, offset_heap=0x7fd1d81ac070, vrow=0x0, mtr=0x7fd1d81abb20)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x6846b70 "\371+\036", mode=PAGE_CUR_GE, prebuilt=0x6856d80, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6852220, buf=0x6846b70 "\371+\036", key_ptr=0x6851ef0 "\032*\n", key_len=8, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740

(gdb) c
Continuing.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7113a38, heap_no=403, index=0x684d230, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7113a38, heap_no=403, index=0x684d230, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

-- 锁二级索引 idx_nPlayerID 的记录
-- rec=0x7fd1e8f194da
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fd1e7113a38, rec=0x7fd1e8f194da "\200\001\346\032", index=0x684d230, offsets=0x7fd1d81ab860, mode=LOCK_X, gap_mode=1024, thr=0x6856098)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x6855848, rec=0x7fd1e8f194da "\200\001\346\032", index=0x684d230, offsets=0x7fd1d81ab860, mode=3, type=1024, thr=0x6856098, mtr=0x7fd1d81abb80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6846b70 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x6855620, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x6851f20, buf=0x6846b70 "\371\031\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
-- keylen=4
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x6851f20, buf=0x6846b70 "\371\031\037", key=0x6851ea8 "\032\346\001", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x6851f20, buf=0x6846b70 "\371\031\037", key=0x6851ea8 "\032\346\001", keylen=4) at /usr/local/mysql/sql/handler.cc:3263

(gdb) c
Continuing.

-- 锁主键索引的记录
Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

-- 锁二级索引 idx_nPlayerID 对应 主键索引的记录
-- 主键索引的记录：rec=0x7fd1e8f3b595 = 7961
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd1e7115378, rec=0x7fd1e8f3b595 "", index=0x684b920, offsets=0x7fd1d81ab860, mode=LOCK_X, gap_mode=1024, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
-- 二级索引 idx_nPlayerID 的记录： rec=0x7fd1e8f194da
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x6855620, sec_index=0x684d230, rec=0x7fd1e8f194da "\200\001\346\032", thr=0x6856098, out_rec=0x7fd1d81ac0f0, offsets=0x7fd1d81ac0c8, offset_heap=0x7fd1d81ac0d0, vrow=0x0, mtr=0x7fd1d81abb80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x6846b70 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x6855620, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
-- 从给定的索引位置获取下一条或上一条记录。
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x6851f20, buf=0x6846b70 "\371\031\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x6851f20, buf=0x6846b70 "\371\031\037", key=0x6851ea8 "\032\346\001", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x6851f20, buf=0x6846b70 "\371\031\037", key=0x6851ea8 "\032\346\001", keylen=4) at /usr/local/mysql/sql/handler.cc:3263

(gdb) c
Continuing.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 锁主键索引的记录
Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x6850908) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x6850908) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
-- 0x7fd1e8f3b595 = 7961 
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd1e7115378, rec=0x7fd1e8f3b595 "", index=0x684b920, offsets=0x7fd1d81ab960, mode=LOCK_X, gap_mode=1024, thr=0x6850908) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x68500b8, rec=0x7fd1e8f3b595 "", index=0x684b920, offsets=0x7fd1d81ab960, mode=3, type=1024, thr=0x6850908, mtr=0x7fd1d81abc80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6846b70 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x684fe90, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6846760, buf=0x6846b70 "\371\031\037", key_ptr=0x68545a0 "\031\037", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740

(gdb) c
Continuing.
