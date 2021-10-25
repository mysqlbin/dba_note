
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
| innodb_buffer_pool_instances        | 6              |
| innodb_buffer_pool_load_abort       | OFF            |
| innodb_buffer_pool_load_at_startup  | ON             |
| innodb_buffer_pool_load_now         | OFF            |
| innodb_buffer_pool_size             | 12884901888    |
+-------------------------------------+----------------+
10 rows in set (0.00 sec)



innodb_buffer_pool_size=12GB
innodb_buffer_pool_instances=6


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

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 --table-size=2000000 --threads=24 --time=600 --report-interval=10 --db-driver=mysql prepare &



purge binary logs to 'mysql-bin.000322';  



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


purge binary logs to 'mysql-bin.000355';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 \
--table-size=2000000 --threads=24 --time=600 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_24_11_vesion7_notAHI.log &


[coding001@db-a ~]$ tail -f  /home/coding001/log/sysbench_oltpX_24_11_vesion7_notAHI.log
Number of threads: 24
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 24 tps: 1718.56 qps: 10320.15 (r/w/o: 0.00/6880.93/3439.22) lat (ms,95%): 20.37 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 24 tps: 1818.65 qps: 10914.30 (r/w/o: 0.00/7276.70/3637.60) lat (ms,95%): 19.65 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 24 tps: 1840.12 qps: 11033.80 (r/w/o: 0.00/7354.16/3679.63) lat (ms,95%): 20.37 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 24 tps: 1155.80 qps: 6937.60 (r/w/o: 0.00/4625.40/2312.20) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 24 tps: 426.40 qps: 2562.88 (r/w/o: 0.00/1710.09/852.79) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 24 tps: 453.20 qps: 2715.43 (r/w/o: 0.00/1809.02/906.41) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 24 tps: 465.10 qps: 2794.80 (r/w/o: 0.00/1864.60/930.20) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 24 tps: 477.20 qps: 2863.20 (r/w/o: 0.00/1908.80/954.40) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 24 tps: 511.20 qps: 3062.53 (r/w/o: 0.00/2040.12/1022.41) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 24 tps: 773.80 qps: 4642.50 (r/w/o: 0.00/3094.90/1547.60) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 24 tps: 719.19 qps: 4320.16 (r/w/o: 0.00/2881.77/1438.39) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 24 tps: 706.61 qps: 4239.64 (r/w/o: 0.00/2826.43/1413.21) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 24 tps: 750.30 qps: 4501.79 (r/w/o: 0.00/3001.19/1500.60) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 24 tps: 733.50 qps: 4400.31 (r/w/o: 0.00/2933.31/1467.00) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 24 tps: 686.59 qps: 4119.45 (r/w/o: 0.00/2746.27/1373.18) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 24 tps: 722.41 qps: 4332.43 (r/w/o: 0.00/2887.62/1444.81) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 24 tps: 800.70 qps: 4806.51 (r/w/o: 0.00/3205.11/1601.40) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 24 tps: 752.60 qps: 4512.40 (r/w/o: 0.00/3007.30/1505.10) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 24 tps: 744.79 qps: 4472.47 (r/w/o: 0.00/2982.78/1489.69) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 24 tps: 782.60 qps: 4695.62 (r/w/o: 0.00/3130.42/1565.21) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 24 tps: 746.10 qps: 4471.08 (r/w/o: 0.00/2978.89/1492.19) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 24 tps: 784.78 qps: 4710.89 (r/w/o: 0.00/3141.33/1569.56) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 24 tps: 780.72 qps: 4687.54 (r/w/o: 0.00/3126.09/1561.45) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 24 tps: 803.69 qps: 4816.35 (r/w/o: 0.00/3209.57/1606.78) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 24 tps: 814.80 qps: 4894.73 (r/w/o: 0.00/3264.52/1630.21) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 24 tps: 811.99 qps: 4871.54 (r/w/o: 0.00/3247.56/1623.98) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 24 tps: 828.00 qps: 4966.79 (r/w/o: 0.00/3310.79/1656.00) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 24 tps: 786.70 qps: 4721.43 (r/w/o: 0.00/3148.02/1573.41) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 24 tps: 807.00 qps: 4838.72 (r/w/o: 0.00/3224.71/1614.01) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 24 tps: 824.59 qps: 4948.55 (r/w/o: 0.00/3299.47/1649.08) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 24 tps: 837.61 qps: 5028.34 (r/w/o: 0.00/3353.03/1675.31) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 24 tps: 851.90 qps: 5111.40 (r/w/o: 0.00/3407.60/1703.80) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 24 tps: 829.61 qps: 4977.63 (r/w/o: 0.00/3318.42/1659.21) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 24 tps: 863.39 qps: 5180.17 (r/w/o: 0.00/3453.38/1726.79) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 24 tps: 838.20 qps: 5024.69 (r/w/o: 0.00/3348.30/1676.40) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 24 tps: 839.61 qps: 5037.84 (r/w/o: 0.00/3358.63/1679.21) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 24 tps: 854.69 qps: 5129.43 (r/w/o: 0.00/3420.06/1709.38) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 24 tps: 842.41 qps: 5057.63 (r/w/o: 0.00/3372.82/1684.81) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 24 tps: 872.01 qps: 5228.74 (r/w/o: 0.00/3484.73/1744.01) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 24 tps: 890.10 qps: 5343.89 (r/w/o: 0.00/3563.69/1780.20) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 24 tps: 886.00 qps: 5315.48 (r/w/o: 0.00/3543.59/1771.89) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 24 tps: 897.30 qps: 5384.29 (r/w/o: 0.00/3589.59/1794.70) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 24 tps: 884.90 qps: 5309.41 (r/w/o: 0.00/3539.61/1769.80) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 24 tps: 867.30 qps: 5203.42 (r/w/o: 0.00/3468.81/1734.61) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 24 tps: 907.70 qps: 5446.27 (r/w/o: 0.00/3630.88/1815.39) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 24 tps: 889.80 qps: 5336.50 (r/w/o: 0.00/3557.10/1779.40) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 24 tps: 878.60 qps: 5274.22 (r/w/o: 0.00/3516.81/1757.41) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 24 tps: 902.79 qps: 5412.23 (r/w/o: 0.00/3606.65/1805.58) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 24 tps: 917.71 qps: 5510.79 (r/w/o: 0.00/3675.36/1835.43) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 24 tps: 885.28 qps: 5304.19 (r/w/o: 0.00/3533.83/1770.36) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 24 tps: 906.22 qps: 5444.81 (r/w/o: 0.00/3632.17/1812.64) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 24 tps: 862.89 qps: 5177.26 (r/w/o: 0.00/3451.47/1725.79) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 24 tps: 894.90 qps: 5369.52 (r/w/o: 0.00/3579.71/1789.81) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 24 tps: 958.10 qps: 5746.47 (r/w/o: 0.00/3830.28/1916.19) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 24 tps: 902.20 qps: 5415.32 (r/w/o: 0.00/3610.92/1804.41) lat (ms,95%): 73.13 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 24 tps: 954.90 qps: 5727.49 (r/w/o: 0.00/3817.70/1909.80) lat (ms,95%): 70.55 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 24 tps: 934.70 qps: 5610.12 (r/w/o: 0.00/3740.71/1869.41) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 24 tps: 939.89 qps: 5637.86 (r/w/o: 0.00/3758.07/1879.79) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 24 tps: 924.81 qps: 5547.03 (r/w/o: 0.00/3697.42/1849.61) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 24 tps: 919.11 qps: 5517.94 (r/w/o: 0.00/3679.73/1838.21) lat (ms,95%): 73.13 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           2066604
        other:                           1033302
        total:                           3099906
    transactions:                        516651 (861.00 per sec.)
    queries:                             3099906 (5165.98 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          600.0597s
    total number of events:              516651

Latency (ms):
         min:                                    7.34
         avg:                                   27.87
         max:                                  359.72
         95th percentile:                       81.48
         sum:                             14399406.98

Threads fairness:
    events (avg/stddev):           21527.1250/186.62
    execution time (avg/stddev):   599.9753/0.01


mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-25 17:09:46 0x7fd364209700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 1 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 580 srv_active, 0 srv_shutdown, 1643 srv_idle
srv_master_thread log flush and writes: 2223
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 262708
--Thread 140545894143744 has waited at trx0undo.ic line 171 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x7fd406d8bb08 created in file buf0buf.cc line 1460
a writer (thread id 140545690064640) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file trx0undo.ic line 190
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc line 1198
--Thread 140545896306432 has waited at trx0undo.ic line 171 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x7fd406d84520 created in file buf0buf.cc line 1460
a writer (thread id 140545690064640) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file trx0undo.ic line 190
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc line 1198
--Thread 140545897658112 has waited at mtr0mtr.ic line 117 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7fd3943eaf48 created in file buf0buf.cc line 1460
a writer (thread id 140545690064640) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc line 1198
--Thread 140545897928448 has waited at trx0rec.cc line 1969 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x7fd406d86b68 created in file buf0buf.cc line 1460
a writer (thread id 140545690064640) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file trx0undo.ic line 190
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc line 1198
OS WAIT ARRAY INFO: signal count 138863
RW-shared spins 0, rounds 45334, OS waits 17121
RW-excl spins 0, rounds 222982, OS waits 6778
RW-sx spins 24333, rounds 701443, OS waits 16445
Spin rounds per wait: 45334.00 RW-shared, 222982.00 RW-excl, 28.83 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 66626255
Purge done for trx's n:o < 66626251 undo n:o < 0 state: running but idle
History list length 325
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 422034756680416, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422034756681328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 66626254, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 44, OS thread handle 140545899280128, query id 1383632 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626253, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 37, OS thread handle 140545899820800, query id 1383630 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626252, ACTIVE (PREPARED) 0 sec
7 lock struct(s), heap size 1136, 4 row lock(s), undo log entries 4
MySQL thread id 33, OS thread handle 140545895225088, query id 1383631 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626251, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 43, OS thread handle 140545898739456, query id 1383629 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626246, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 30, OS thread handle 140545894954752, query id 1383620 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626245, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 31, OS thread handle 140545894143744, query id 1383586 192.168.1.10 sysbench updating
UPDATE sbtest10 SET k=k+1 WHERE id=1193004
---TRANSACTION 66626244, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 49, OS thread handle 140545895765760, query id 1383617 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626243, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 29, OS thread handle 140545897658112, query id 1383607 192.168.1.10 sysbench update
INSERT INTO sbtest1 (id, k, c, pad) VALUES (1009411, 1009432, '54804254592-30469519687-66972711016-56510066357-17396918482-49387964523-46541425216-81796173179-67392904611-65018428919', '19527067739-93758554089-74249517540-33495605077-61954466236')
---TRANSACTION 66626242, ACTIVE (PREPARED) 0 sec
7 lock struct(s), heap size 1136, 4 row lock(s), undo log entries 4
MySQL thread id 51, OS thread handle 140545893603072, query id 1383619 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626236, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 47, OS thread handle 140545897928448, query id 1383573 192.168.1.10 sysbench updating
UPDATE sbtest10 SET c='48081102894-37619384055-55733040107-47165926982-45890988988-65770797596-29238423283-35668234606-94219686062-11794619673' WHERE id=1009746
---TRANSACTION 66626234, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 52, OS thread handle 140545893332736, query id 1383593 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626230, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 35, OS thread handle 140545895495424, query id 1383595 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626226, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 42, OS thread handle 140545894414080, query id 1383602 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626225, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 39, OS thread handle 140545897387776, query id 1383584 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626224, ACTIVE 0 sec preparing
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 50, OS thread handle 140545896306432, query id 1383564 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626223, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 32, OS thread handle 140545897117440, query id 1383591 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626222, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 36, OS thread handle 140545893873408, query id 1383568 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626221, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 41, OS thread handle 140545896036096, query id 1383588 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626220, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 45, OS thread handle 140545896576768, query id 1383590 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626219, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 46, OS thread handle 140545896847104, query id 1383562 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626217, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 38, OS thread handle 140545899009792, query id 1383554 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626216, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 40, OS thread handle 140545898469120, query id 1383558 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626190, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 48, OS thread handle 140545899550464, query id 1383549 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 66626189, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 34, OS thread handle 140545898198784, query id 1383583 192.168.1.10 sysbench starting
COMMIT
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
Pending flushes (fsync) log: 1; buffer pool: 1
153619 OS file reads, 1040706 OS file writes, 155723 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1280.72 writes/s, 334.67 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 1 merges
merged operations:
 insert 0, delete mark 1, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
0.00 hash searches/s, 11403.60 non-hash searches/s
---
LOG
---
Log sequence number 547643303382
Log flushed up to   547643267408
Pages flushed up to 547226543544
Last checkpoint at  547199534853
1 pending log flushes, 0 pending chkp writes
50964 log i/o's done, 158.00 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13193183232
Dictionary memory allocated 259676
Buffer pool size   786384
Free buffers       32640
Database pages     753744
Old database pages 278114
Modified db pages  78208
Pending reads      0
Pending writes: LRU 0, flush list 121, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 151411, created 602333, written 927402
0.00 reads/s, 1.00 creates/s, 1099.90 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 753744, unzip_LRU len: 0
I/O sum[0]:cur[5370], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   131056
Free buffers       5142
Database pages     125914
Old database pages 46459
Modified db pages  13169
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25273, created 100641, written 154779
0.00 reads/s, 0.00 creates/s, 209.79 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125914, unzip_LRU len: 0
I/O sum[0]:cur[895], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   131072
Free buffers       5639
Database pages     125433
Old database pages 46282
Modified db pages  12754
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25194, created 100239, written 153998
0.00 reads/s, 0.00 creates/s, 202.80 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125433, unzip_LRU len: 0
I/O sum[0]:cur[895], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   131056
Free buffers       5680
Database pages     125376
Old database pages 46261
Modified db pages  12778
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25264, created 100112, written 153559
0.00 reads/s, 0.00 creates/s, 180.82 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125376, unzip_LRU len: 0
I/O sum[0]:cur[895], unzip sum[0]:cur[0]
---BUFFER POOL 3
Buffer pool size   131072
Free buffers       5451
Database pages     125621
Old database pages 46351
Modified db pages  13039
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25272, created 100349, written 155192
0.00 reads/s, 0.00 creates/s, 211.79 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125621, unzip_LRU len: 0
I/O sum[0]:cur[895], unzip sum[0]:cur[0]
---BUFFER POOL 4
Buffer pool size   131056
Free buffers       5371
Database pages     125685
Old database pages 46375
Modified db pages  13325
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25168, created 100517, written 155329
0.00 reads/s, 0.00 creates/s, 188.81 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125685, unzip_LRU len: 0
I/O sum[0]:cur[895], unzip sum[0]:cur[0]
---BUFFER POOL 5
Buffer pool size   131072
Free buffers       5357
Database pages     125715
Old database pages 46386
Modified db pages  13143
Pending reads      0
Pending writes: LRU 0, flush list 121, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25240, created 100475, written 154545
0.00 reads/s, 1.00 creates/s, 105.89 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125715, unzip_LRU len: 0
I/O sum[0]:cur[895], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=3589, Main thread ID=140546061129472, state: sleeping
Number of rows inserted 40227725, updated 455524, deleted 227770, read 2683406
730.27 inserts/s, 1450.55 updates/s, 729.27 deletes/s, 2178.82 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.00 sec)

ERROR: 
No query specified

mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-25 17:13:57 0x7fd364209700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 7 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 829 srv_active, 0 srv_shutdown, 1643 srv_idle
srv_master_thread log flush and writes: 2472
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 337216
--Thread 140546052736768 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3b2f238, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140545896847104 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3b2f238, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140545895225088 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3b2f238, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

OS WAIT ARRAY INFO: signal count 171331
RW-shared spins 0, rounds 76083, OS waits 30005
RW-excl spins 0, rounds 272914, OS waits 8383
RW-sx spins 39774, rounds 1135708, OS waits 26370
Spin rounds per wait: 76083.00 RW-shared, 272914.00 RW-excl, 28.55 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 67062097
Purge done for trx's n:o < 67062093 undo n:o < 0 state: running
History list length 137
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 422034756680416, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422034756681328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 67062096, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 45, OS thread handle 140545896576768, query id 2691131 192.168.1.10 sysbench
---TRANSACTION 67062095, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 33, OS thread handle 140545895225088, query id 2691130 192.168.1.10 sysbench updating
UPDATE sbtest9 SET k=k+1 WHERE id=997428
---TRANSACTION 67062094, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 30, OS thread handle 140545894954752, query id 2691129 192.168.1.10 sysbench
---TRANSACTION 67062090, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 35, OS thread handle 140545895495424, query id 2691125 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062088, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 49, OS thread handle 140545895765760, query id 2691111 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062087, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 44, OS thread handle 140545899280128, query id 2691109 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062086, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 40, OS thread handle 140545898469120, query id 2691107 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062085, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 42, OS thread handle 140545894414080, query id 2691091 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062084, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 32, OS thread handle 140545897117440, query id 2691090 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062081, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 50, OS thread handle 140545896306432, query id 2691113 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062080, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 52, OS thread handle 140545893332736, query id 2691081 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062077, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 43, OS thread handle 140545898739456, query id 2691076 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062076, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 29, OS thread handle 140545897658112, query id 2691120 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062074, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 48, OS thread handle 140545899550464, query id 2691103 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062063, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 34, OS thread handle 140545898198784, query id 2691087 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062056, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 46, OS thread handle 140545896847104, query id 2691114 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (1005929, 1004714, '88361725619-41177029305-48735385470-72118405369-84425540897-52305297182-02297988510-16977014217-42191638374-82974501307', '46883086291-23155046787-84179380623-85157302601-09560755698')
---TRANSACTION 67062044, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 47, OS thread handle 140545897928448, query id 2691104 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062040, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 41, OS thread handle 140545896036096, query id 2691102 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062038, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 31, OS thread handle 140545894143744, query id 2691100 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062032, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 37, OS thread handle 140545899820800, query id 2691098 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062028, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 36, OS thread handle 140545893873408, query id 2691099 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062018, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 38, OS thread handle 140545899009792, query id 2691093 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062017, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 51, OS thread handle 140545893603072, query id 2691094 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67062004, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 39, OS thread handle 140545897387776, query id 2691115 192.168.1.10 sysbench starting
COMMIT
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
153619 OS file reads, 1402769 OS file writes, 252391 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1437.65 writes/s, 387.66 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 1 merges
merged operations:
 insert 0, delete mark 1, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
Hash table size 3187397, node heap has 0 buffer(s)
0.00 hash searches/s, 13289.96 non-hash searches/s
---
LOG
---
Log sequence number 548950928434
Log flushed up to   548950925574
Pages flushed up to 548539173855
Last checkpoint at  548485732954
1 pending log flushes, 0 pending chkp writes
97785 log i/o's done, 189.86 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13193183232
Dictionary memory allocated 259676
Buffer pool size   786384
Free buffers       31602
Database pages     754782
Old database pages 278498
Modified db pages  84844
Pending reads      0
Pending writes: LRU 0, flush list 8, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 151411, created 603371, written 1236071
0.00 reads/s, 3.43 creates/s, 1222.97 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 754782, unzip_LRU len: 0
I/O sum[0]:cur[7017], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   131056
Free buffers       5005
Database pages     126051
Old database pages 46510
Modified db pages  14198
Pending reads      0
Pending writes: LRU 0, flush list 2, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25273, created 100778, written 206468
0.00 reads/s, 0.43 creates/s, 196.69 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 126051, unzip_LRU len: 0
I/O sum[0]:cur[1110], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   131072
Free buffers       5410
Database pages     125662
Old database pages 46366
Modified db pages  14027
Pending reads      0
Pending writes: LRU 0, flush list 2, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25194, created 100468, written 204721
0.00 reads/s, 1.43 creates/s, 154.69 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125662, unzip_LRU len: 0
I/O sum[0]:cur[1110], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   131056
Free buffers       5521
Database pages     125535
Old database pages 46320
Modified db pages  13945
Pending reads      0
Pending writes: LRU 0, flush list 2, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25264, created 100271, written 204331
0.00 reads/s, 0.86 creates/s, 190.69 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125535, unzip_LRU len: 0
I/O sum[0]:cur[1110], unzip sum[0]:cur[0]
---BUFFER POOL 3
Buffer pool size   131072
Free buffers       5262
Database pages     125810
Old database pages 46421
Modified db pages  14203
Pending reads      0
Pending writes: LRU 0, flush list 2, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25272, created 100538, written 207252
0.00 reads/s, 0.43 creates/s, 222.40 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125810, unzip_LRU len: 0
I/O sum[0]:cur[1229], unzip sum[0]:cur[0]
---BUFFER POOL 4
Buffer pool size   131056
Free buffers       5241
Database pages     125815
Old database pages 46423
Modified db pages  14377
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25168, created 100647, written 206959
0.00 reads/s, 0.00 creates/s, 208.40 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125815, unzip_LRU len: 0
I/O sum[0]:cur[1229], unzip sum[0]:cur[0]
---BUFFER POOL 5
Buffer pool size   131072
Free buffers       5163
Database pages     125909
Old database pages 46458
Modified db pages  14094
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 25240, created 100669, written 206340
0.00 reads/s, 0.29 creates/s, 250.11 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 125909, unzip_LRU len: 0
I/O sum[0]:cur[1229], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=3589, Main thread ID=140546061129472, state: sleeping
Number of rows inserted 40445657, updated 891401, deleted 445710, read 3337245
886.16 inserts/s, 1773.75 updates/s, 887.02 deletes/s, 2660.62 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.04 sec)



[coding001@voice ~]$ top
top - 17:14:59 up 101 days,  2:13,  2 users,  load average: 4.63, 4.50, 3.04
Tasks: 114 total,   2 running, 112 sleeping,   0 stopped,   0 zombie
%Cpu0  : 40.0 us, 20.0 sy,  0.0 ni, 31.1 id,  4.4 wa,  0.0 hi,  4.4 si,  0.0 st
%Cpu1  : 36.4 us, 20.5 sy,  0.0 ni, 27.3 id, 11.4 wa,  0.0 hi,  4.5 si,  0.0 st
%Cpu2  : 34.1 us, 13.6 sy,  0.0 ni, 27.3 id, 25.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  : 40.9 us, 13.6 sy,  0.0 ni, 34.1 id,  9.1 wa,  0.0 hi,  2.3 si,  0.0 st
KiB Mem : 16266300 total,   169904 free, 14217504 used,  1878892 buff/cache
KiB Swap:        0 total,        0 free,        0 used.   937220 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
 3589 mysql     20   0   15.7g  13.0g   4036 S 219.6 83.8  34:18.00 mysqld                 
 
 
 
 
