

root@mysqldb 19:58:  [performance_schema]> use `performance_schema`;
Database changed
root@mysqldb 19:58:  [performance_schema]> select VARIABLE_VALUE into @a from global_status where VARIABLE_NAME = 'Innodb_buffer_pool_pages_dirty';   # InnoDB buffer pool 页
Query OK, 1 row affected (0.00 sec)

root@mysqldb 19:58:  [performance_schema]> select VARIABLE_VALUE into @b from global_status where VARIABLE_NAME = 'Innodb_buffer_pool_pages_total';   # InnoDB buffer pool 
Query OK, 1 row affected (0.00 sec)

root@mysqldb 19:58:  [performance_schema]> select @a/@b;
+--------------------+
| @a/@b              |
+--------------------+
| 0.6503550211588541 |
+--------------------+
1 row in set (0.00 sec)

root@mysqldb 19:58:  [performance_schema]> 
root@mysqldb 19:58:  [performance_schema]> show global status like '%buffer_pool%';
+---------------------------------------+--------------------------------------------------+
| Variable_name                         | Value                                            |
+---------------------------------------+--------------------------------------------------+
| Innodb_buffer_pool_dump_status        | Dumping of buffer pool not started               |
| Innodb_buffer_pool_load_status        | Buffer pool(s) load completed at 200302 10:34:28 |
| Innodb_buffer_pool_resize_status      |                                                  |
| Innodb_buffer_pool_pages_data         | 173918                                           |
| Innodb_buffer_pool_bytes_data         | 2849472512                                       |
| Innodb_buffer_pool_pages_dirty        | 128020                                           |
| Innodb_buffer_pool_bytes_dirty        | 2097479680                                       |
| Innodb_buffer_pool_pages_flushed      | 460412                                           |
| Innodb_buffer_pool_pages_free         | 8000                                             |
| Innodb_buffer_pool_pages_misc         | 14690                                            |
| Innodb_buffer_pool_pages_total        | 196608                                           |
| Innodb_buffer_pool_read_ahead_rnd     | 0                                                |
| Innodb_buffer_pool_read_ahead         | 0                                                |
| Innodb_buffer_pool_read_ahead_evicted | 0                                                |
| Innodb_buffer_pool_read_requests      | 185186643                                        |
| Innodb_buffer_pool_reads              | 541                                              |
| Innodb_buffer_pool_wait_free          | 0                                                |     
| Innodb_buffer_pool_write_requests     | 81763725                                         |
+---------------------------------------+--------------------------------------------------+
18 rows in set (0.00 sec)



root@mysqldb 19:59:  [performance_schema]> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2020-03-11 19:59:30 0x7fe6c49a9700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 2 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 7181 srv_active, 0 srv_shutdown, 804108 srv_idle
srv_master_thread log flush and writes: 811225
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 31670
OS WAIT ARRAY INFO: signal count 34492
RW-shared spins 0, rounds 46209, OS waits 13930
RW-excl spins 0, rounds 205525, OS waits 2367
RW-sx spins 2058, rounds 59352, OS waits 132
Spin rounds per wait: 46209.00 RW-shared, 205525.00 RW-excl, 28.84 RW-sx
------------------------
LATEST DETECTED DEADLOCK
------------------------
2020-03-11 19:59:18 0x7fe65efdf700
*** (1) TRANSACTION:
TRANSACTION 823244, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 2
MySQL thread id 766, OS thread handle 140627412379392, query id 8144947 39.108.193.40 root updating
DELETE FROM sbtest8 WHERE id=760192
*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 252 page no 10446 n bits 144 index PRIMARY of table `sbtest`.`sbtest8` trx id 823244 lock_mode X locks rec but not gap waiting
Record lock, heap no 8 PHYSICAL RECORD: n_fields 6; compact format; info bits 32
 0: len 4; hex 000b9980; asc     ;;
 1: len 6; hex 0000000c8fd1; asc       ;;
 2: len 7; hex 63000001580eab; asc c   X  ;;
 3: len 4; hex 0007afbf; asc     ;;
 4: len 30; hex 33363135373138323236322d32373832303738383731382d393337353338; asc 36157182262-27820788718-937538; (total 120 bytes);
 5: len 30; hex 36323435363539383036372d31383936313436353136332d353032323938; asc 62456598067-18961465163-502298; (total 60 bytes);

*** (2) TRANSACTION:
TRANSACTION 823249, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 4 row lock(s), undo log entries 3
MySQL thread id 763, OS thread handle 140627412907776, query id 8144957 39.108.193.40 root update
INSERT INTO sbtest8 (id, k, c, pad) VALUES (760192, 324726, '36244914809-24981576636-35397913302-50220135386-08400498445-13215607383-89888850705-31760327559-48285306661-97544430187', '69625132461-42533625137-82210051311-09791423709-27614044705')
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 252 page no 10446 n bits 144 index PRIMARY of table `sbtest`.`sbtest8` trx id 823249 lock_mode X locks rec but not gap
Record lock, heap no 8 PHYSICAL RECORD: n_fields 6; compact format; info bits 32
 0: len 4; hex 000b9980; asc     ;;
 1: len 6; hex 0000000c8fd1; asc       ;;
 2: len 7; hex 63000001580eab; asc c   X  ;;
 3: len 4; hex 0007afbf; asc     ;;
 4: len 30; hex 33363135373138323236322d32373832303738383731382d393337353338; asc 36157182262-27820788718-937538; (total 120 bytes);
 5: len 30; hex 36323435363539383036372d31383936313436353136332d353032323938; asc 62456598067-18961465163-502298; (total 60 bytes);

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 252 page no 10446 n bits 144 index PRIMARY of table `sbtest`.`sbtest8` trx id 823249 lock mode S waiting
Record lock, heap no 8 PHYSICAL RECORD: n_fields 6; compact format; info bits 32
 0: len 4; hex 000b9980; asc     ;;
 1: len 6; hex 0000000c8fd1; asc       ;;
 2: len 7; hex 63000001580eab; asc c   X  ;;
 3: len 4; hex 0007afbf; asc     ;;
 4: len 30; hex 33363135373138323236322d32373832303738383731382d393337353338; asc 36157182262-27820788718-937538; (total 120 bytes);
 5: len 30; hex 36323435363539383036372d31383936313436353136332d353032323938; asc 62456598067-18961465163-502298; (total 60 bytes);

*** WE ROLL BACK TRANSACTION (1)
------------
TRANSACTIONS
------------
Trx id counter 844531
Purge done for trx's n:o < 844510 undo n:o < 0 state: running
History list length 346
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 422108191557056, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191547024, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191546112, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191545200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191544288, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191543376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191542464, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191541552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191540640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191539728, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191538816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191537904, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191536992, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191536080, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191535168, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191534256, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191533344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191532432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191531520, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191530608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191529696, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191528784, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422108191549760, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
--------
FILE I/O
--------
I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
I/O thread 1 state: waiting for completed aio requests (log thread)
I/O thread 2 state: waiting for completed aio requests (read thread)
I/O thread 3 state: waiting for completed aio requests (read thread)
I/O thread 4 state: waiting for completed aio requests (read thread)
I/O thread 5 state: waiting for completed aio requests (read thread)
I/O thread 6 state: waiting for completed aio requests (read thread)
I/O thread 7 state: waiting for completed aio requests (read thread)
I/O thread 8 state: waiting for completed aio requests (read thread)
I/O thread 9 state: waiting for completed aio requests (read thread)
I/O thread 10 state: waiting for completed aio requests (write thread)
I/O thread 11 state: waiting for completed aio requests (write thread)
I/O thread 12 state: waiting for completed aio requests (write thread)
I/O thread 13 state: waiting for completed aio requests (write thread)
I/O thread 14 state: waiting for completed aio requests (write thread)
I/O thread 15 state: waiting for completed aio requests (write thread)
I/O thread 16 state: waiting for completed aio requests (write thread)
I/O thread 17 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 0, 0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 0
1023 OS file reads, 975567 OS file writes, 105951 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1147.43 writes/s, 50.47 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 0, seg size 2, 0 merges
merged operations:
 insert 0, delete mark 0, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 796967, node heap has 1474 buffer(s)
Hash table size 796967, node heap has 1474 buffer(s)
Hash table size 796967, node heap has 1474 buffer(s)
Hash table size 796967, node heap has 1500 buffer(s)
Hash table size 796967, node heap has 1474 buffer(s)
Hash table size 796967, node heap has 1474 buffer(s)
Hash table size 796967, node heap has 2883 buffer(s)
Hash table size 796967, node heap has 2937 buffer(s)
15105.95 hash searches/s, 11298.35 non-hash searches/s
---
LOG
---
Log sequence number 5655352616
Log flushed up to   5654950701
Pages flushed up to 5196216722
Last checkpoint at  5193625880
0 pending log flushes, 0 pending chkp writes
450619 log i/o's done, 760.00 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 3298295808
Dictionary memory allocated 1095269
Buffer pool size   196608
Free buffers       8000
Database pages     173918
Old database pages 64159
Modified db pages  129089
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 1678956, not young 46854
3056.97 youngs/s, 0.00 non-youngs/s
Pages read 540, created 247784, written 489042
0.00 reads/s, 0.50 creates/s, 379.81 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 24 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 173918, unzip_LRU len: 0
I/O sum[38288]:cur[770], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   98304
Free buffers       4000
Database pages     86954
Old database pages 32078
Modified db pages  64591
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 841720, not young 44256
1508.25 youngs/s, 0.00 non-youngs/s
Pages read 267, created 123929, written 247207
0.00 reads/s, 0.00 creates/s, 187.41 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 24 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 86954, unzip_LRU len: 0
I/O sum[19144]:cur[385], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   98304
Free buffers       4000
Database pages     86964
Old database pages 32081
Modified db pages  64498
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 837236, not young 2598
1548.73 youngs/s, 0.00 non-youngs/s
Pages read 273, created 123855, written 241835
0.00 reads/s, 0.50 creates/s, 192.40 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 25 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 86964, unzip_LRU len: 0
I/O sum[19144]:cur[385], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
9 read views open inside InnoDB
Process ID=19542, Main thread ID=140629764863744, state: sleeping
Number of rows inserted 23265819, updated 827743, deleted 414499, read 196510483
764.62 inserts/s, 1529.24 updates/s, 764.62 deletes/s, 318244.88 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.00 sec)

ERROR: 
No query specified





