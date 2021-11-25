

drop table  if exists t;
CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into t(c,d) values(1,1);
insert into t(c,d) values(2,2);
insert into t(c,d) values(3,3);
insert into t(c,d) values(4,4);
insert into t(c,d) values(5,5);
insert into t(c,d) values(6,6);
insert into t(c,d) values(7,7);
insert into t(c,d) values(8,8);
insert into t(c,d) values(9,9);
insert into t(c,d) values(10,10);
insert into t(c,d) values(11,11);
insert into t(c,d) values(12,12);
insert into t(c,d) values(13,13);
insert into t(c,d) values(14,14);
insert into t(c,d) values(15,15);

mysql> SELECT * FROM t;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  1 |    1 |    1 |
|  2 |    2 |    2 |
|  3 |    3 |    3 |
|  4 |    4 |    4 |
|  5 |    5 |    5 |
|  6 |    6 |    6 |
|  7 |    7 |    7 |
|  8 |    8 |    8 |
|  9 |    9 |    9 |
| 10 |   10 |   10 |
| 11 |   11 |   11 |
| 12 |   12 |   12 |
| 13 |   13 |   13 |
| 14 |   14 |   14 |
| 15 |   15 |   15 |
+----+------+------+
15 rows in set (0.01 sec)

------------------------------------------------------------------------------

session A              session B      

b dict_stats_save		
					  delete from t;
					  
(gdb) c
Continuing.
[Switching to Thread 0x7fe8737f6700 (LWP 9526)]

Breakpoint 2, dict_stats_save (table_orig=0x7fe8ac3577f0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
2371		table = dict_stats_snapshot_create(table_orig);
(gdb) bt
#0  dict_stats_save (table_orig=0x7fe8ac3577f0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fe8ac3577f0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#4  0x00007fe8bacbdea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fe8b9b839fd in clone () from /lib64/libc.so.6



------------------------------------------------------------------------------

session A              session B      

b dict_stats_save		
					  insert into t select * from t;
					  (Query Ok)
					  
------------------------------------------------------------------------------					  
					  
session A              session B      

b dict_stats_save		
					  update t set c=100 where id between 1 and 5;
					  (Blocked)
					  
(gdb) b dict_stats_save
Breakpoint 2 at 0x1bc2178: file /usr/local/mysql/storage/innobase/dict/dict0stats.cc, line 2371.
(gdb) bt
#0  0x00007fc207578ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x64ad8b0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x64dc4e0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x4bed948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffe68c81558) at /usr/local/mysql/sql/main.cc:25
(gdb) c
Continuing.
[Switching to Thread 0x7fc1c0ff9700 (LWP 9577)]

Breakpoint 2, dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
2371		table = dict_stats_snapshot_create(table_orig);
(gdb) bt
#0  dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#4  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc2075839fd in clone () from /lib64/libc.so.6
(gdb) bt
#0  dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#4  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc2075839fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
355		ut_ad(table->magic_n == DICT_TABLE_MAGIC_N);
(gdb) bt
#0  0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
#1  0x0000000001bbf555 in dict_stats_snapshot_create (table=0xf8947dc0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:769
#2  0x0000000001bc2187 in dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#3  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#4  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#5  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#6  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fc2075839fd in clone () from /lib64/libc.so.6
(gdb) bt
#0  0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
#1  0x0000000001bbf555 in dict_stats_snapshot_create (table=0xf8947dc0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:769
#2  0x0000000001bc2187 in dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#3  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#4  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#5  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#6  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fc2075839fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.
[Thread 0x7fc1ff563700 (LWP 9546) exited]
[Thread 0x7fc1eb851700 (LWP 9547) exited]
[Thread 0x7fc1eb050700 (LWP 9548) exited]
[Thread 0x7fc1ea84f700 (LWP 9549) exited]
[Thread 0x7fc1ea04e700 (LWP 9550) exited]
[Thread 0x7fc1e984d700 (LWP 9551) exited]
[Thread 0x7fc1e904c700 (LWP 9552) exited]
[Thread 0x7fc1e884b700 (LWP 9553) exited]
[Thread 0x7fc1e804a700 (LWP 9554) exited]
[Thread 0x7fc1e7849700 (LWP 9555) exited]
[Thread 0x7fc1e7048700 (LWP 9556) exited]
[Thread 0x7fc1e6847700 (LWP 9557) exited]
[Thread 0x7fc1e6046700 (LWP 9558) exited]
[Thread 0x7fc1e5845700 (LWP 9559) exited]
[Thread 0x7fc1e5044700 (LWP 9560) exited]
[Thread 0x7fc1e4843700 (LWP 9561) exited]
[Thread 0x7fc1e4042700 (LWP 9562) exited]
[Thread 0x7fc1e3841700 (LWP 9563) exited]
[Thread 0x7fc1e3040700 (LWP 9564) exited]
[Thread 0x7fc1e283f700 (LWP 9565) exited]
[Thread 0x7fc1e1e39700 (LWP 9568) exited]
[Thread 0x7fc1e1638700 (LWP 9569) exited]
[Thread 0x7fc1e0e37700 (LWP 9570) exited]
[Thread 0x7fc1c17fa700 (LWP 9576) exited]
[Thread 0x7fc1c0ff9700 (LWP 9577) exited]
[Thread 0x7fc1c07f8700 (LWP 9578) exited]
[Thread 0x7fc1bfff7700 (LWP 9579) exited]
[Thread 0x7fc1fc1e6700 (LWP 9580) exited]
[Thread 0x7fc1fc164700 (LWP 9581) exited]
[Thread 0x7fc1bf535700 (LWP 9582) exited]
[Thread 0x7fc208ae4740 (LWP 9545) exited]
[Thread 0x7fc1c3fff700 (LWP 9571) exited]
[Thread 0x7fc1e0235700 (LWP 9583) exited]
[Thread 0x7fc1c27fc700 (LWP 9574) exited]
[Thread 0x7fc1c2ffd700 (LWP 9573) exited]
[Thread 0x7fc1c37fe700 (LWP 9572) exited]
[Inferior 1 (process 9545) exited with code 02]
-- mysqld crash 





					  
session A              session B      

b dict_stats_save		
					  update t set d=100 where id between 1 and 5;
					  (Query Ok)

------------------------------------------------------------------------------					  

session A              session B      

b dict_stats_save		
					  delete from t where id=1;
					  (Query Ok)
					  
	

------------------------------------------------------------------------------	
					  
session A              session B      

b dict_stats_save		
					  delete from t where id between 1 and 5;		
					  (Blocked)
					  
(gdb) b dict_stats_save
Breakpoint 2 at 0x1bc2178: file /usr/local/mysql/storage/innobase/dict/dict0stats.cc, line 2371.
(gdb) c
Continuing.
[Switching to Thread 0x7efc94ff9700 (LWP 9737)]

Breakpoint 2, dict_stats_save (table_orig=0x5e74910, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
2371		table = dict_stats_snapshot_create(table_orig);
(gdb) bt
#0  dict_stats_save (table_orig=0x5e74910, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x5e74910, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#4  0x00007efcdc101ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007efcdafc79fd in clone () from /lib64/libc.so.6





------------------------------------------------------------------------------

session A              session B      

b dict_stats_update_persistent
						
					   update t set d=100 where c between 1 and 5;	
					  (Query Ok)








------------------------------------------------------------------------------

