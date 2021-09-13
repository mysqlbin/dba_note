mysql show engine innodb statusG;
 1. row 
  Type InnoDB
  Name 
Status 
=====================================
2021-09-13 110248 7f01b760b700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 47 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops 237849 srv_active, 0 srv_shutdown, 117668 srv_idle
srv_master_thread log flush and writes 355516
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO reservation count 178108
OS WAIT ARRAY INFO signal count 564472
Mutex spin waits 911330, rounds 3907648, OS waits 54561
RW-shared spins 193169, rounds 2664873, OS waits 82823
RW-excl spins 177162, rounds 2150374, OS waits 35991
Spin rounds per wait 4.29 mutex, 13.80 RW-shared, 12.14 RW-excl
------------
TRANSACTIONS
------------
Trx id counter 3954155015 (40亿的事务ID 这个trx_id是累积值？是的。同时可以体现出这个数据库实例的压力。)

Purge done for trx s no  3954154986 undo no  0 state running but idle
History list length 3178

(尚未被清理update undo的事务数即代表了有多少 undo日志 还没有被清理掉，如果没有超过5000+，那么不用关注)



LIST OF TRANSACTIONS FOR EACH SESSION
---TRANSACTION 0, not started
MySQL thread id 28212, OS thread handle 0x7f01b760b700, query id 33294590 localhost root init
show engine innodb status
---TRANSACTION 3954153962, not started
MySQL thread id 28124, OS thread handle 0x7f01bc276700, query id 33291477 10.30.210.161 app_user
---TRANSACTION 3954154557, not started
MySQL thread id 28122, OS thread handle 0x7f01b7793700, query id 33293290 10.30.210.161 app_user
---TRANSACTION 3954153940, not started
MySQL thread id 28120, OS thread handle 0x7f01bc2d8700, query id 33291435 10.30.210.161 app_user
---TRANSACTION 3954154563, not started
MySQL thread id 28080, OS thread handle 0x7f01c414c700, query id 33293302 10.30.210.161 app_user
---TRANSACTION 3954153949, not started
MySQL thread id 28077, OS thread handle 0x7f01bc524700, query id 33291393 10.30.210.161 app_user
---TRANSACTION 3954052391, not started
MySQL thread id 27679, OS thread handle 0x7f01b7700700, query id 32994590 10.25.211.71 readonly
---TRANSACTION 3954154459, not started
MySQL thread id 27607, OS thread handle 0x7f01bc4c2700, query id 33294133 10.29.64.46 app_user
---TRANSACTION 3954154817, not started
MySQL thread id 27606, OS thread handle 0x7f01c411b700, query id 33294009 10.29.64.46 app_user
---TRANSACTION 3954154719, not started
MySQL thread id 27533, OS thread handle 0x7f01bc460700, query id 33293777 10.29.64.46 app_user
---TRANSACTION 3954155011, not started
MySQL thread id 27530, OS thread handle 0x7f01c4088700, query id 33294581 10.29.64.46 app_user
---TRANSACTION 3954155010, not started
MySQL thread id 27528, OS thread handle 0x7f01c40b9700, query id 33294571 10.29.64.46 app_user
---TRANSACTION 3954154718, not started
MySQL thread id 27529, OS thread handle 0x7f01b763c700, query id 33293771 10.29.64.46 app_user
---TRANSACTION 3954154537, not started
MySQL thread id 27524, OS thread handle 0x7f01b76cf700, query id 33294580 10.29.64.46 app_user
---TRANSACTION 3954155009, not started
MySQL thread id 27523, OS thread handle 0x7f01c40ea700, query id 33294579 10.29.64.46 app_user
---TRANSACTION 3954154863, not started
MySQL thread id 27522, OS thread handle 0x7f01c4057700, query id 33294134 10.29.64.46 app_user
---TRANSACTION 3954154862, not started
MySQL thread id 27521, OS thread handle 0x7f01b77f5700, query id 33294129 10.29.64.46 app_user
---TRANSACTION 3954154595, not started
MySQL thread id 229, OS thread handle 0x7f01b791b700, query id 33293347 10.29.58.72 app_user
---TRANSACTION 3954154473, not started
MySQL thread id 230, OS thread handle 0x7f01b7826700, query id 33292952 10.29.58.72 app_user
---TRANSACTION 3954154470, not started
MySQL thread id 228, OS thread handle 0x7f01b794c700, query id 33292945 10.29.58.72 app_user
---TRANSACTION 3954154476, not started
MySQL thread id 226, OS thread handle 0x7f01b7857700, query id 33292959 10.29.58.72 app_user
---TRANSACTION 3954154479, not started
MySQL thread id 227, OS thread handle 0x7f01b78ea700, query id 33292966 10.29.58.72 app_user
---TRANSACTION 3954154467, not started
MySQL thread id 225, OS thread handle 0x7f01b78b9700, query id 33292938 10.29.58.72 app_user
---TRANSACTION 3954154453, not started
MySQL thread id 224, OS thread handle 0x7f01b7888700, query id 33292898 10.29.58.72 app_user
---TRANSACTION 3954154664, not started
MySQL thread id 223, OS thread handle 0x7f01b797d700, query id 33293612 10.29.58.72 app_user
---TRANSACTION 3954154758, not started
MySQL thread id 222, OS thread handle 0x7f01b7d20700, query id 33293869 10.29.57.36 app_user
---TRANSACTION 3954154680, not started
MySQL thread id 221, OS thread handle 0x7f01b7bc9700, query id 33293662 10.29.57.36 app_user
---TRANSACTION 3954154966, not started
MySQL thread id 220, OS thread handle 0x7f01b7cbe700, query id 33294456 10.29.57.36 app_user
---TRANSACTION 3954154683, not started
MySQL thread id 217, OS thread handle 0x7f01b7a10700, query id 33293670 10.29.57.36 app_user
---TRANSACTION 3954154657, not started
MySQL thread id 218, OS thread handle 0x7f01b7b67700, query id 33293586 10.29.57.36 app_user
---TRANSACTION 3954154679, not started
MySQL thread id 215, OS thread handle 0x7f01b7bfa700, query id 33293661 10.29.57.36 app_user
---TRANSACTION 3954154689, not started
MySQL thread id 219, OS thread handle 0x7f01b7aa3700, query id 33293688 10.29.57.36 app_user
---TRANSACTION 3954154795, not started
MySQL thread id 216, OS thread handle 0x7f01b7cef700, query id 33293954 10.29.57.36 app_user
---TRANSACTION 3954155014, not started
MySQL thread id 214, OS thread handle 0x7f01b7a72700, query id 33294588 10.29.57.36 app_user
---TRANSACTION 3954154662, not started
MySQL thread id 213, OS thread handle 0x7f01b7c8d700, query id 33293602 10.29.57.36 app_user
---TRANSACTION 3954154821, not started
MySQL thread id 212, OS thread handle 0x7f01b7c2b700, query id 33294018 10.29.57.36 app_user
---TRANSACTION 3954154654, not started
MySQL thread id 211, OS thread handle 0x7f01b7c5c700, query id 33293579 10.29.57.36 app_user
---TRANSACTION 3954154686, not started
MySQL thread id 210, OS thread handle 0x7f01b7b36700, query id 33293681 10.29.57.36 app_user
---TRANSACTION 3954154938, not started
MySQL thread id 209, OS thread handle 0x7f01b7b98700, query id 33294388 10.29.57.36 app_user
---TRANSACTION 3954154828, not started
MySQL thread id 208, OS thread handle 0x7f01b7b05700, query id 33294038 10.29.57.36 app_user
---TRANSACTION 3954154783, not started
MySQL thread id 207, OS thread handle 0x7f01b7ad4700, query id 33293926 10.29.57.36 app_user
---TRANSACTION 3954154834, not started
MySQL thread id 204, OS thread handle 0x7f01b7a41700, query id 33294051 10.29.57.36 app_user
---TRANSACTION 3954154223, not started
MySQL thread id 206, OS thread handle 0x7f01b7d82700, query id 33292192 10.29.57.36 app_user
---TRANSACTION 3954154214, not started
MySQL thread id 205, OS thread handle 0x7f01b7d51700, query id 33292173 10.29.57.36 app_user
---TRANSACTION 3954154773, not started
MySQL thread id 203, OS thread handle 0x7f01bc245700, query id 33293904 10.29.253.186 app_user
---TRANSACTION 3954154980, not started
MySQL thread id 201, OS thread handle 0x7f01bc181700, query id 33294490 10.29.253.186 app_user
---TRANSACTION 3954154770, not started
MySQL thread id 202, OS thread handle 0x7f01bc150700, query id 33293895 10.29.253.186 app_user
---TRANSACTION 3954154750, not started
MySQL thread id 199, OS thread handle 0x7f01bc05b700, query id 33293852 10.29.253.186 app_user
---TRANSACTION 3954154764, not started
MySQL thread id 200, OS thread handle 0x7f01bc1b2700, query id 33293883 10.29.253.186 app_user
---TRANSACTION 3954154776, not started
MySQL thread id 198, OS thread handle 0x7f01bc214700, query id 33293911 10.29.253.186 app_user
---TRANSACTION 3954154975, not started
MySQL thread id 197, OS thread handle 0x7f01bc11f700, query id 33294477 10.29.253.186 app_user
---TRANSACTION 3954154769, not started
MySQL thread id 196, OS thread handle 0x7f01b7e77700, query id 33293896 10.29.253.186 app_user
---TRANSACTION 3954154798, not started
MySQL thread id 195, OS thread handle 0x7f01bc36b700, query id 33293961 10.29.253.186 app_user
---TRANSACTION 3954154810, not started
MySQL thread id 194, OS thread handle 0x7f01bc08c700, query id 33293987 10.29.253.186 app_user
---TRANSACTION 3954154761, not started
MySQL thread id 193, OS thread handle 0x7f01bc1e3700, query id 33293876 10.29.253.186 app_user
---TRANSACTION 3954154972, not started
MySQL thread id 192, OS thread handle 0x7f01bc33a700, query id 33294470 10.29.253.186 app_user
---TRANSACTION 3954154752, not started
MySQL thread id 191, OS thread handle 0x7f01bc0bd700, query id 33293855 10.29.253.186 app_user
---TRANSACTION 3954154950, not started
MySQL thread id 190, OS thread handle 0x7f01b7fff700, query id 33294416 10.29.253.186 app_user
---TRANSACTION 3954154755, not started
MySQL thread id 189, OS thread handle 0x7f01bc0ee700, query id 33293862 10.29.253.186 app_user
---TRANSACTION 3954154815, not started
MySQL thread id 188, OS thread handle 0x7f01b7fce700, query id 33294003 10.29.253.186 app_user
---TRANSACTION 3954154807, not started
MySQL thread id 187, OS thread handle 0x7f01b7f9d700, query id 33293980 10.29.253.186 app_user
---TRANSACTION 3954154883, not started
MySQL thread id 186, OS thread handle 0x7f01b7ed9700, query id 33294219 10.29.253.186 app_user
---TRANSACTION 3954154949, not started
MySQL thread id 185, OS thread handle 0x7f01b7f3b700, query id 33294414 10.29.253.186 app_user
---TRANSACTION 3954154981, not started
MySQL thread id 184, OS thread handle 0x7f01b7f0a700, query id 33294489 10.29.253.186 app_user
---TRANSACTION 3954154737, not started
MySQL thread id 183, OS thread handle 0x7f01b7f6c700, query id 33293820 10.29.253.186 app_user
---TRANSACTION 3954154792, not started
MySQL thread id 181, OS thread handle 0x7f01b7de4700, query id 33293947 10.29.253.186 app_user
---TRANSACTION 3954154746, not started
MySQL thread id 182, OS thread handle 0x7f01b7e46700, query id 33293840 10.29.253.186 app_user
---TRANSACTION 3954154969, not started
MySQL thread id 180, OS thread handle 0x7f01b7ea8700, query id 33294463 10.29.253.186 app_user
---TRANSACTION 3954154943, not started
MySQL thread id 179, OS thread handle 0x7f01b7db3700, query id 33294399 10.29.253.186 app_user
---TRANSACTION 3954154789, not started
MySQL thread id 178, OS thread handle 0x7f01b7e15700, query id 33293940 10.29.253.186 app_user
---TRANSACTION 3954154731, not started
MySQL thread id 177, OS thread handle 0x7f01bc2a7700, query id 33293806 10.29.253.186 app_user
---TRANSACTION 3954154745, not started
MySQL thread id 176, OS thread handle 0x7f01bc309700, query id 33293839 10.29.253.186 app_user
---TRANSACTION 3954154902, not started
MySQL thread id 175, OS thread handle 0x7f01bc3cd700, query id 33294263 10.29.253.186 app_user
---TRANSACTION 3954155008, not started
MySQL thread id 174, OS thread handle 0x7f01bc42f700, query id 33294528 10.29.253.186 app_user
---TRANSACTION 3954154944, not started
MySQL thread id 173, OS thread handle 0x7f01bc39c700, query id 33294400 10.29.253.186 app_user
---TRANSACTION 3954154728, not started
MySQL thread id 172, OS thread handle 0x7f01bc3fe700, query id 33293799 10.29.253.186 app_user
---TRANSACTION 3954154786, not started
MySQL thread id 171, OS thread handle 0x7f01b75a9700, query id 33293933 10.29.253.186 app_user
---TRANSACTION 3954154722, not started
MySQL thread id 170, OS thread handle 0x7f01b75da700, query id 33293785 10.29.253.186 app_user
--------
FILE IO
--------
IO thread 0 state waiting for completed aio requests (insert buffer thread)
IO thread 1 state waiting for completed aio requests (log thread)
IO thread 2 state waiting for completed aio requests (read thread)
IO thread 3 state waiting for completed aio requests (read thread)
IO thread 4 state waiting for completed aio requests (read thread)
IO thread 5 state waiting for completed aio requests (read thread)
IO thread 6 state waiting for completed aio requests (read thread)
IO thread 7 state waiting for completed aio requests (read thread)
IO thread 8 state waiting for completed aio requests (read thread)
IO thread 9 state waiting for completed aio requests (read thread)
IO thread 10 state waiting for completed aio requests (read thread)
IO thread 11 state waiting for completed aio requests (read thread)
IO thread 12 state waiting for completed aio requests (read thread)
IO thread 13 state waiting for completed aio requests (read thread)
IO thread 14 state waiting for completed aio requests (read thread)
IO thread 15 state waiting for completed aio requests (read thread)
IO thread 16 state waiting for completed aio requests (read thread)
IO thread 17 state waiting for completed aio requests (read thread)
IO thread 18 state waiting for completed aio requests (write thread)
IO thread 19 state waiting for completed aio requests (write thread)
IO thread 20 state waiting for completed aio requests (write thread)
IO thread 21 state waiting for completed aio requests (write thread)
IO thread 22 state waiting for completed aio requests (write thread)
IO thread 23 state waiting for completed aio requests (write thread)
IO thread 24 state waiting for completed aio requests (write thread)
IO thread 25 state waiting for completed aio requests (write thread)
IO thread 26 state waiting for completed aio requests (write thread)
IO thread 27 state waiting for completed aio requests (write thread)
IO thread 28 state waiting for completed aio requests (write thread)
IO thread 29 state waiting for completed aio requests (write thread)
IO thread 30 state waiting for completed aio requests (write thread)
IO thread 31 state waiting for completed aio requests (write thread)
IO thread 32 state waiting for completed aio requests (write thread)
IO thread 33 state waiting for completed aio requests (write thread)
IO thread 34 state waiting for completed aio requests (write thread)
IO thread 35 state waiting for completed aio requests (write thread)
IO thread 36 state waiting for completed aio requests (write thread)
IO thread 37 state waiting for completed aio requests (write thread)
IO thread 38 state waiting for completed aio requests (write thread)
IO thread 39 state waiting for completed aio requests (write thread)
IO thread 40 state waiting for completed aio requests (write thread)
IO thread 41 state waiting for completed aio requests (write thread)
IO thread 42 state waiting for completed aio requests (write thread)
IO thread 43 state waiting for completed aio requests (write thread)
IO thread 44 state waiting for completed aio requests (write thread)
IO thread 45 state waiting for completed aio requests (write thread)
IO thread 46 state waiting for completed aio requests (write thread)
IO thread 47 state waiting for completed aio requests (write thread)
IO thread 48 state waiting for completed aio requests (write thread)
IO thread 49 state waiting for completed aio requests (write thread)
Pending normal aio reads 0 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] , aio writes 0 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
 ibuf aio reads 0, log io's 0, sync io's 0
Pending flushes (fsync) log 0; buffer pool 0
289028 OS file reads, 12686645 OS file writes, 5916222 OS fsyncs
0.00 readss, 0 avg bytesread, 9.64 writess, 5.66 fsyncss
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf size 1, free list len 663, seg size 665, 11480 merges
merged operations
 insert 10887, delete mark 457669, delete 1228
discarded operations
 insert 0, delete mark 0, delete 0
Hash table size 42499381, node heap has 4316 buffer(s)
19.66 hash searchess, 9.26 non-hash searchess
---
LOG
---
Log sequence number 1248800284959
Log flushed up to   1248800284959
Pages flushed up to 1248800284959
Last checkpoint at  1248800284959
0 pending log writes, 0 pending chkp writes
3254081 log io's done, 2.45 log io'ssecond
----------------------
BUFFER POOL AND MEMORY
----------------------
Total memory allocated 21978152960; in additional pool allocated 0
Dictionary memory allocated 831090
Buffer pool size   1310712
Free buffers       925197
Database pages     381199
Old database pages 140554
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 1980, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 288908, created 92291, written 7286448
0.00 readss, 0.00 createss, 4.87 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 381199, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   163839
Free buffers       115532
Database pages     47756
Old database pages 17608
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 263, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 36272, created 11484, written 1522374
0.00 readss, 0.00 createss, 1.17 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 47756, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
---BUFFER POOL 1
Buffer pool size   163839
Free buffers       115301
Database pages     47994
Old database pages 17696
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 175, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 36254, created 11740, written 603703
0.00 readss, 0.00 createss, 0.40 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 47994, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
---BUFFER POOL 2
Buffer pool size   163839
Free buffers       114374
Database pages     48931
Old database pages 18043
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 354, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 37515, created 11416, written 535537
0.00 readss, 0.00 createss, 0.21 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 48931, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
---BUFFER POOL 3
Buffer pool size   163839
Free buffers       116576
Database pages     46731
Old database pages 17230
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 320, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 35359, created 11372, written 996824
0.00 readss, 0.00 createss, 0.72 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 46731, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
---BUFFER POOL 4
Buffer pool size   163839
Free buffers       115696
Database pages     47592
Old database pages 17548
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 140, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 36142, created 11450, written 853302
0.00 readss, 0.00 createss, 0.60 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 47592, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
---BUFFER POOL 5
Buffer pool size   163839
Free buffers       115674
Database pages     47630
Old database pages 17562
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 266, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 35450, created 12180, written 902265
0.00 readss, 0.00 createss, 0.64 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 47630, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
---BUFFER POOL 6
Buffer pool size   163839
Free buffers       115922
Database pages     47381
Old database pages 17470
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 201, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 36105, created 11276, written 651088
0.00 readss, 0.00 createss, 0.68 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 47381, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
---BUFFER POOL 7
Buffer pool size   163839
Free buffers       116122
Database pages     47184
Old database pages 17397
Modified db pages  0
Pending reads 0
Pending writes LRU 0, flush list 0, single page 0
Pages made young 261, not young 0
0.00 youngss, 0.00 non-youngss
Pages read 35811, created 11373, written 1221355
0.00 readss, 0.00 createss, 0.45 writess
Buffer pool hit rate 1000  1000, young-making rate 0  1000 not 0  1000
Pages read ahead 0.00s, evicted without access 0.00s, Random read ahead 0.00s
LRU len 47184, unzip_LRU len 0
IO sum[0]cur[0], unzip sum[0]cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Main thread process no. 3995, id 139645595858688, state sleeping
Number of rows inserted 2703807, updated 1131469, deleted 2696896, read 3149708197
1.15 insertss, 0.79 updatess, 0.00 deletess, 192.57 readss
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.00 sec)

ERROR 
No query specified

