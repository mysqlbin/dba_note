
set global innodb_adaptive_hash_index=OFF;


mysql> set global innodb_adaptive_hash_index=OFF;

Query OK, 0 rows affected (0.37 sec)

mysql> 
mysql> show global variables like '%innodb_adaptive_hash_index%';
+----------------------------------+-------+
| Variable_name                    | Value |
+----------------------------------+-------+
| innodb_adaptive_hash_index       | OFF   |
| innodb_adaptive_hash_index_parts | 8     |
+----------------------------------+-------+
2 rows in set (0.00 sec)



mysql> show global variables like '%innodb_buffer_pool%';
+-------------------------------------+----------------+
| Variable_name                       | Value          |
+-------------------------------------+----------------+
| innodb_buffer_pool_chunk_size       | 134217728      |
| innodb_buffer_pool_dump_at_shutdown | ON             |
| innodb_buffer_pool_dump_now         | OFF            |
| innodb_buffer_pool_dump_pct         | 25             |
| innodb_buffer_pool_filename         | ib_buffer_pool |
| innodb_buffer_pool_instances        | 3              |
| innodb_buffer_pool_load_abort       | OFF            |
| innodb_buffer_pool_load_at_startup  | ON             |
| innodb_buffer_pool_load_now         | OFF            |
| innodb_buffer_pool_size             | 12884901888    |
+-------------------------------------+----------------+
10 rows in set (0.09 sec)


innodb_buffer_pool_size=12GB
innodb_buffer_pool_instances=3


drop table sbtest1;
drop table sbtest2;
drop table sbtest3;
drop table sbtest4;
drop table sbtest5;
drop table sbtest6;
drop table sbtest7;
drop table sbtest8;
drop table sbtest9;
drop table sbtest10; 
drop table sbtest11; 
drop table sbtest12; 
drop table sbtest13; 
drop table sbtest14; 
drop table sbtest15; 
drop table sbtest16; 
drop table sbtest17; 
drop table sbtest18; 
drop table sbtest19; 
drop table sbtest20; 


set global sync_binlog=0;
set global innodb_flush_log_at_trx_commit=0;

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 --table-size=3000000 --threads=32 --time=1800 --report-interval=10 --db-driver=mysql prepare &



purge binary logs to 'mysql-bin.000306';  



set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;
show global variables like '%sync_binlog%';
show global variables like '%innodb_flush_log_at_trx_commit%';
show global variables like '%innodb_io_capacity%';
show global variables like '%time_zone%';

mysql> set global sync_binlog=1;
Query OK, 0 rows affected (0.00 sec)

mysql> set global innodb_flush_log_at_trx_commit=1;
Query OK, 0 rows affected (0.00 sec)

mysql> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 1     |
+---------------+-------+
1 row in set (0.01 sec)

mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_trx_commit | 1     |
+--------------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like '%innodb_io_capacity%';
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| innodb_io_capacity     | 5000  |
| innodb_io_capacity_max | 20000 |
+------------------------+-------+
2 rows in set (0.00 sec)

mysql> show global variables like '%time_zone%';
+------------------+--------+
| Variable_name    | Value  |
+------------------+--------+
| system_time_zone | CST    |
| time_zone        | SYSTEM |
+------------------+--------+
2 rows in set (0.00 sec)


purge binary logs to 'mysql-bin.000281';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 \
--table-size=3000000 --threads=32 --time=900 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_32_11_vesion7_notAHI.log &

mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-25 10:11:03 0x7f508c080700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 14 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 667 srv_active, 0 srv_shutdown, 698 srv_idle
srv_master_thread log flush and writes: 1365
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 815823
--Thread 139983811454720 has waited at row0row.cc line 1075 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f5182457940 created in file buf0buf.cc line 1460
a writer (thread id 139983805507328) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139983964649216 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983947863808 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983809292032 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983804155648 has waited at fsp0fsp.cc line 3365 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x180a1de8 created in file fil0fil.cc line 1383
a writer (thread id 139983805777664) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: ffffffffe0000000
Last time read locked in file not yet reserved line 0
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fsp/fsp0fsp.cc line 2617
--Thread 139983803614976 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983810373376 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983803344640 has waited at row0row.cc line 1075 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f517a1095f0 created in file buf0buf.cc line 1460
a writer (thread id 139983808481024) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139983806048000 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983810914048 has waited at fsp0fsp.cc line 3365 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x180a1de8 created in file fil0fil.cc line 1383
a writer (thread id 139983805777664) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: ffffffffe0000000
Last time read locked in file not yet reserved line 0
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fsp/fsp0fsp.cc line 2617
--Thread 139983939471104 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983807129344 has waited at row0row.cc line 1075 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f5182457940 created in file buf0buf.cc line 1460
a writer (thread id 139983805507328) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139983811184384 has waited at row0row.cc line 1075 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f517a1095f0 created in file buf0buf.cc line 1460
a writer (thread id 139983808481024) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139983804425984 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983809832704 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983805507328 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983808210688 has waited at row0row.cc line 1075 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f517a1095f0 created in file buf0buf.cc line 1460
a writer (thread id 139983808481024) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139983803885312 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983806588672 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983956256512 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983804696320 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983807670016 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983808481024 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983806318336 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983806859008 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983808751360 has waited at trx0trx.cc line 2768 for 0.00 seconds the semaphore:
Mutex at 0x180e2410, Mutex REDO_RSEG created trx0rseg.cc:211, lock var 1

--Thread 139983805777664 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139983810643712 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

OS WAIT ARRAY INFO: signal count 441290
RW-shared spins 0, rounds 46379, OS waits 12133
RW-excl spins 0, rounds 459281, OS waits 14506
RW-sx spins 17217, rounds 499752, OS waits 10804
Spin rounds per wait: 46379.00 RW-shared, 459281.00 RW-excl, 29.03 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 63293117
Purge done for trx's n:o < 63293084 undo n:o < 0 state: running
History list length 201
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421472668569200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421472668567376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 63293116, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 48, OS thread handle 139983809562368, query id 698485 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293114, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 54, OS thread handle 139983811725056, query id 698479 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293113, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 66, OS thread handle 139983803885312, query id 698439 192.168.1.10 sysbench updating
UPDATE sbtest3 SET k=k+1 WHERE id=1702763
---TRANSACTION 63293112, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 60, OS thread handle 139983810643712, query id 698477 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (1725473, 1401117, '88273775598-68641136472-55347872105-82615256016-49237165750-70544281873-88113604695-43092987768-50238588259-29617174733', '57016191115-70467550517-22398968363-82724942418-69137938871')
---TRANSACTION 63293111, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 50, OS thread handle 139983811184384, query id 698457 192.168.1.10 sysbench updating
DELETE FROM sbtest17 WHERE id=1512688
---TRANSACTION 63293110, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 40, OS thread handle 139983807129344, query id 698426 192.168.1.10 sysbench updating
UPDATE sbtest7 SET k=k+1 WHERE id=1512924
---TRANSACTION 63293109, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 67, OS thread handle 139983803614976, query id 698425 192.168.1.10 sysbench updating
UPDATE sbtest16 SET k=k+1 WHERE id=1462976
---TRANSACTION 63293108, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 51, OS thread handle 139983807399680, query id 698476 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293107, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 59, OS thread handle 139983806318336, query id 698422 192.168.1.10 sysbench updating
UPDATE sbtest14 SET k=k+1 WHERE id=1497155
---TRANSACTION 63293106, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 38, OS thread handle 139983806048000, query id 698421 192.168.1.10 sysbench updating
UPDATE sbtest19 SET k=k+1 WHERE id=984457
---TRANSACTION 63293105, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 56, OS thread handle 139983806588672, query id 698419 192.168.1.10 sysbench updating
UPDATE sbtest4 SET k=k+1 WHERE id=1505971
---TRANSACTION 63293104, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 41, OS thread handle 139983804966656, query id 698475 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293103, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 49, OS thread handle 139983807670016, query id 698416 192.168.1.10 sysbench updating
UPDATE sbtest9 SET k=k+1 WHERE id=1496751
---TRANSACTION 63293102, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 63, OS thread handle 139983807940352, query id 698473 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293101, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 62, OS thread handle 139983809292032, query id 698464 192.168.1.10 sysbench update
INSERT INTO sbtest12 (id, k, c, pad) VALUES (1512903, 1510854, '22398923466-64398782819-17041507109-57269954866-04532246341-55710489033-18146568839-42875946584-02266245447-97569222467', '14868110617-95322272211-33154693293-76188316788-02052114826')
---TRANSACTION 63293100, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 46, OS thread handle 139983810914048, query id 698413 192.168.1.10 sysbench updating
UPDATE sbtest2 SET k=k+1 WHERE id=1507804
---TRANSACTION 63293099, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 44, OS thread handle 139983804696320, query id 698467 192.168.1.10 sysbench update
INSERT INTO sbtest18 (id, k, c, pad) VALUES (1536597, 1585117, '00121497477-72155204945-75623279940-69956823915-61913342827-18393411044-78107728329-06857171971-57273684793-48474471799', '78596821642-07322722969-66599406119-18500504838-60023148386')
---TRANSACTION 63293098, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 43, OS thread handle 139983805236992, query id 698474 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293097, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 68, OS thread handle 139983803344640, query id 698410 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=1256488
---TRANSACTION 63293096, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 58, OS thread handle 139983806859008, query id 698459 192.168.1.10 sysbench update
INSERT INTO sbtest19 (id, k, c, pad) VALUES (1508776, 1510113, '95018252421-44908743018-31597984870-58100718421-22983727454-95414546512-37442642214-26127705064-97330905770-49613904345', '62432114039-31164910021-08717317902-54013457646-29081910331')
---TRANSACTION 63293095, ACTIVE 0 sec preparing
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 47, OS thread handle 139983808751360, query id 698472 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293094, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 65, OS thread handle 139983804155648, query id 698408 192.168.1.10 sysbench updating
UPDATE sbtest18 SET k=k+1 WHERE id=1510458
---TRANSACTION 63293093, ACTIVE (PREPARED) 0 sec
7 lock struct(s), heap size 1136, 4 row lock(s), undo log entries 4
MySQL thread id 61, OS thread handle 139983810103040, query id 698470 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293092, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 55, OS thread handle 139983809021696, query id 698471 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 63293091, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 37, OS thread handle 139983805777664, query id 698403 192.168.1.10 sysbench updating
UPDATE sbtest6 SET k=k+1 WHERE id=1454441
---TRANSACTION 63293090, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 53, OS thread handle 139983808210688, query id 698404 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=1506465
---TRANSACTION 63293089, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 57, OS thread handle 139983810373376, query id 698397 192.168.1.10 sysbench updating
UPDATE sbtest11 SET k=k+1 WHERE id=1346241
---TRANSACTION 63293088, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 45, OS thread handle 139983811454720, query id 698395 192.168.1.10 sysbench updating
UPDATE sbtest7 SET k=k+1 WHERE id=1513946
---TRANSACTION 63293087, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 42, OS thread handle 139983804425984, query id 698438 192.168.1.10 sysbench updating
DELETE FROM sbtest1 WHERE id=1640905
---TRANSACTION 63293086, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 64, OS thread handle 139983809832704, query id 698392 192.168.1.10 sysbench updating
UPDATE sbtest18 SET k=k+1 WHERE id=1497737
---TRANSACTION 63293085, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 39, OS thread handle 139983805507328, query id 698390 192.168.1.10 sysbench updating
UPDATE sbtest7 SET k=k+1 WHERE id=1498935
---TRANSACTION 63293052, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 52, OS thread handle 139983808481024, query id 698400 192.168.1.10 sysbench update
INSERT INTO sbtest17 (id, k, c, pad) VALUES (1513301, 1511275, '20459057479-94758476233-56995513876-48629588681-79650471168-62378468787-05408583162-00508459513-00221313865-94182072674', '96575554088-69147594939-72112009809-56703937948-15686655744')
--------
FILE I/O
--------
I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
I/O thread 1 state: waiting for completed aio requests (log thread)
I/O thread 2 state: waiting for completed aio requests (read thread)
I/O thread 3 state: waiting for completed aio requests (read thread)
I/O thread 4 state: waiting for completed aio requests (read thread)
I/O thread 5 state: waiting for completed aio requests (read thread)
I/O thread 6 state: complete io for buf page (write thread)
I/O thread 7 state: waiting for completed aio requests (write thread)
I/O thread 8 state: waiting for completed aio requests (write thread)
I/O thread 9 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 1; buffer pool: 1
398146 OS file reads, 1156227 OS file writes, 110741 OS fsyncs
0.21 reads/s, 16384 avg bytes/read, 1464.90 writes/s, 231.84 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 1 merges
merged operations:
 insert 0, delete mark 1, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 3187201, node heap has 0 buffer(s)
Hash table size 3187201, node heap has 0 buffer(s)
Hash table size 3187201, node heap has 0 buffer(s)
Hash table size 3187201, node heap has 0 buffer(s)
Hash table size 3187201, node heap has 0 buffer(s)
Hash table size 3187201, node heap has 0 buffer(s)
Hash table size 3187201, node heap has 0 buffer(s)
Hash table size 3187201, node heap has 0 buffer(s)
0.00 hash searches/s, 8028.78 non-hash searches/s
---
LOG
---
Log sequence number 504758850518
Log flushed up to   504758849125
Pages flushed up to 504241875560
Last checkpoint at  504218358171
1 pending log flushes, 0 pending chkp writes
19934 log i/o's done, 68.14 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13193183232
Dictionary memory allocated 259676
Buffer pool size   786336
Free buffers       3065
Database pages     783271
Old database pages 289076
Modified db pages  86408
Pending reads      0
Pending writes: LRU 0, flush list 47, single page 0
Pages made young 423173, not young 319834
144.20 youngs/s, 0.43 non-youngs/s
Pages read 394981, created 900502, written 1056384
0.21 reads/s, 18.71 creates/s, 1371.47 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 3 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 783271, unzip_LRU len: 0
I/O sum[196320]:cur[2282], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1021
Database pages     261091
Old database pages 96359
Modified db pages  29012
Pending reads      0
Pending writes: LRU 0, flush list 2, single page 0
Pages made young 141476, not young 96393
46.78 youngs/s, 0.21 non-youngs/s
Pages read 131375, created 300264, written 352245
0.14 reads/s, 4.43 creates/s, 462.47 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 3 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 261091, unzip_LRU len: 0
I/O sum[65440]:cur[721], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       1023
Database pages     261089
Old database pages 96358
Modified db pages  28506
Pending reads      0
Pending writes: LRU 0, flush list 2, single page 0
Pages made young 140944, not young 98164
46.57 youngs/s, 0.21 non-youngs/s
Pages read 131504, created 299816, written 351516
0.07 reads/s, 4.86 creates/s, 447.18 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 3 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 261089, unzip_LRU len: 0
I/O sum[65440]:cur[721], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   262112
Free buffers       1021
Database pages     261091
Old database pages 96359
Modified db pages  28890
Pending reads      0
Pending writes: LRU 0, flush list 43, single page 0
Pages made young 140753, not young 125277
50.85 youngs/s, 0.00 non-youngs/s
Pages read 132102, created 300422, written 352623
0.00 reads/s, 9.43 creates/s, 461.82 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 3 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 261091, unzip_LRU len: 0
I/O sum[65440]:cur[840], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=31963, Main thread ID=139983973041920, state: sleeping
Number of rows inserted 60112152, updated 224458, deleted 112230, read 336839
494.82 inserts/s, 992.21 updates/s, 495.46 deletes/s, 1487.97 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.06 sec)

