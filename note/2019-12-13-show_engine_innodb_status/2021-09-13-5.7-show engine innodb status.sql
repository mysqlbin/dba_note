mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2020-01-17 16:54:23 0x7f20ae36d700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 26 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 18673734 srv_active, 0 srv_shutdown, 4367731 srv_idle
srv_master_thread log flush and writes: 23041417
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 17026148
OS WAIT ARRAY INFO: signal count 69577780
RW-shared spins 0, rounds 84868351, OS waits 8676864
RW-excl spins 0, rounds 376040614, OS waits 5044017
RW-sx spins 21154761, rounds 133338028, OS waits 1469828
Spin rounds per wait: 84868351.00 RW-shared, 376040614.00 RW-excl, 6.30 RW-sx
------------------------
LATEST DETECTED DEADLOCK
------------------------

..................................

------------
TRANSACTIONS
------------
Trx id counter 737860423
Purge done for trx's n:o < 737860422 undo n:o < 0 state: running but idle
History list length 4
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421264941532832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941390560, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941531920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941531008, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941530096, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941529184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941528272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941527360, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941526448, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941525536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941524624, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941523712, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941522800, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941521888, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941520976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941520064, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941519152, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941518240, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941517328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941516416, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941515504, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941514592, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941513680, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941512768, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941511856, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941510944, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941510032, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941509120, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941508208, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941507296, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941506384, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941505472, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941504560, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941503648, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941502736, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941501824, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941500912, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941500000, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941499088, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941498176, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941497264, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941496352, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941495440, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941494528, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941493616, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941492704, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941491792, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941490880, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941489968, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941487232, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941486320, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941485408, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941484496, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941483584, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941482672, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941481760, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941480848, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941479936, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941479024, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941478112, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941477200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941476288, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941475376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941474464, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941473552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941472640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941471728, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941470816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941469904, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941468992, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941468080, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941467168, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941466256, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941465344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941464432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941463520, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941462608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941461696, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941460784, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941459872, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941458960, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941458048, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941457136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941456224, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941455312, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941454400, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941453488, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941452576, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941451664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941450752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941449840, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941448928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941448016, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941447104, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941446192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941445280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941444368, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941443456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941442544, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941441632, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941440720, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941439808, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941438896, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941437984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941437072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941436160, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941435248, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941434336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941433424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941432512, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941431600, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941430688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941429776, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941428864, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941427952, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941427040, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941426128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941425216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941424304, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941423392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941422480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941421568, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941420656, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941419744, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941418832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941417920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941417008, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941416096, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941415184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941414272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941413360, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941412448, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941411536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941410624, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941409712, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941408800, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941407888, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941406976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941406064, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941405152, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941404240, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941403328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941402416, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941401504, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941400592, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941399680, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941398768, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941397856, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941396944, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941396032, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941395120, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941394208, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941393296, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941392384, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941391472, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941389648, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941489056, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421264941488144, not started
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
I/O thread 6 state: waiting for completed aio requests (write thread)
I/O thread 7 state: waiting for completed aio requests (write thread)
I/O thread 8 state: waiting for completed aio requests (write thread)
I/O thread 9 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 0
36915986 OS file reads, 789886700 OS file writes, 415809109 OS fsyncs
0.12 reads/s, 16384 avg bytes/read, 22.19 writes/s, 22.19 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 4023, seg size 4025, 2783745 merges
merged operations:
 insert 6009379, delete mark 80799722, delete 3778668
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2656321, node heap has 2927 buffer(s)
Hash table size 2656321, node heap has 11220 buffer(s)
Hash table size 2656321, node heap has 27516 buffer(s)
Hash table size 2656321, node heap has 1099 buffer(s)
Hash table size 2656321, node heap has 109 buffer(s)
Hash table size 2656321, node heap has 337 buffer(s)
Hash table size 2656321, node heap has 10986 buffer(s)
Hash table size 2656321, node heap has 640 buffer(s)
118.73 hash searches/s, 101.19 non-hash searches/s
---
LOG
---
Log sequence number 675387082288
Log flushed up to   675387082270
Pages flushed up to 675340291094
Last checkpoint at  675340291094
0 pending log flushes, 0 pending chkp writes
283708928 log i/o's done, 21.73 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 10994319360
Dictionary memory allocated 3261207
Buffer pool size   655353
Free buffers       2047
Database pages     598472
Old database pages 220879
Modified db pages  17319
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 22577308, not young 953341618
2.35 youngs/s, 0.00 non-youngs/s
Pages read 36887629, created 13439746, written 465184424
0.12 reads/s, 0.62 creates/s, 0.23 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 3 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 598472, unzip_LRU len: 0
I/O sum[114]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   327673
Free buffers       1023
Database pages     299188
Old database pages 110422
Modified db pages  8992
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 11626809, not young 465487645
1.38 youngs/s, 0.00 non-youngs/s
Pages read 18169095, created 6730092, written 226111820
0.08 reads/s, 0.58 creates/s, 0.12 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 3 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 299188, unzip_LRU len: 0
I/O sum[57]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   327680
Free buffers       1024
Database pages     299284
Old database pages 110457
Modified db pages  8327
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 10950499, not young 487853973
0.96 youngs/s, 0.00 non-youngs/s
Pages read 18718534, created 6709654, written 239072604
0.04 reads/s, 0.04 creates/s, 0.12 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 3 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 299284, unzip_LRU len: 0
I/O sum[57]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=1492, Main thread ID=139778483975936, state: sleeping
Number of rows inserted 562631877, updated 95324329, deleted 187986390, read 61295235445
21.50 inserts/s, 4.12 updates/s, 0.00 deletes/s, 53.27 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.14 sec)

ERROR: 
No query specified
