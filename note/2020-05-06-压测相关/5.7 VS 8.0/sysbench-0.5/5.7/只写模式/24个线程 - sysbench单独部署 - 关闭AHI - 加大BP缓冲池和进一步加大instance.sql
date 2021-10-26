
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
| innodb_buffer_pool_instances        | 12             |
| innodb_buffer_pool_load_abort       | OFF            |
| innodb_buffer_pool_load_at_startup  | ON             |
| innodb_buffer_pool_load_now         | OFF            |
| innodb_buffer_pool_size             | 12884901888    |
+-------------------------------------+----------------+
10 rows in set (0.01 sec)




innodb_buffer_pool_size=12GB
innodb_buffer_pool_instances=12


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


purge binary logs to 'mysql-bin.000368';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 \
--table-size=2000000 --threads=24 --time=600 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_24_11_vesion7_notAHI.log &



[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_24_11_vesion7_notAHI.log
Initializing worker threads...

Threads started!

[ 10s ] thds: 24 tps: 1729.69 qps: 10386.42 (r/w/o: 0.00/6924.65/3461.77) lat (ms,95%): 21.11 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 24 tps: 1807.08 qps: 10842.87 (r/w/o: 0.00/7228.71/3614.16) lat (ms,95%): 19.29 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 24 tps: 1842.71 qps: 11055.67 (r/w/o: 0.00/7370.25/3685.42) lat (ms,95%): 19.65 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 24 tps: 1089.01 qps: 6537.98 (r/w/o: 0.00/4359.96/2178.03) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 24 tps: 457.30 qps: 2738.00 (r/w/o: 0.00/1823.40/914.60) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 24 tps: 513.19 qps: 3075.66 (r/w/o: 0.00/2049.27/1026.39) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 24 tps: 500.90 qps: 3014.73 (r/w/o: 0.00/2012.92/1001.81) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 24 tps: 537.60 qps: 3225.41 (r/w/o: 0.00/2150.20/1075.20) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 24 tps: 533.10 qps: 3198.80 (r/w/o: 0.00/2132.60/1066.20) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 24 tps: 561.90 qps: 3371.40 (r/w/o: 0.00/2247.60/1123.80) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 24 tps: 676.10 qps: 4052.01 (r/w/o: 0.00/2699.81/1352.20) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 24 tps: 691.99 qps: 4153.45 (r/w/o: 0.00/2769.47/1383.98) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 24 tps: 733.90 qps: 4402.32 (r/w/o: 0.00/2934.51/1467.81) lat (ms,95%): 73.13 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 24 tps: 820.90 qps: 4925.43 (r/w/o: 0.00/3283.62/1641.81) lat (ms,95%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 24 tps: 813.10 qps: 4882.81 (r/w/o: 0.00/3256.61/1626.20) lat (ms,95%): 70.55 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 24 tps: 722.30 qps: 4331.60 (r/w/o: 0.00/2887.10/1444.50) lat (ms,95%): 71.83 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 24 tps: 695.70 qps: 4175.20 (r/w/o: 0.00/2783.70/1391.50) lat (ms,95%): 71.83 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 24 tps: 1167.39 qps: 7000.62 (r/w/o: 0.00/4665.95/2334.67) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 24 tps: 1414.58 qps: 8490.00 (r/w/o: 0.00/5660.94/2829.07) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 24 tps: 1250.62 qps: 7501.60 (r/w/o: 0.00/5000.66/2500.93) lat (ms,95%): 53.85 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 24 tps: 1152.51 qps: 6915.85 (r/w/o: 0.00/4610.33/2305.52) lat (ms,95%): 59.99 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 24 tps: 1103.70 qps: 6625.89 (r/w/o: 0.00/4418.49/2207.40) lat (ms,95%): 55.82 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 24 tps: 1016.30 qps: 6093.31 (r/w/o: 0.00/4060.71/2032.60) lat (ms,95%): 63.32 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 24 tps: 957.38 qps: 5740.38 (r/w/o: 0.00/3825.62/1914.76) lat (ms,95%): 64.47 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 24 tps: 902.92 qps: 5421.04 (r/w/o: 0.00/3615.19/1805.85) lat (ms,95%): 66.84 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 24 tps: 939.70 qps: 5643.08 (r/w/o: 0.00/3763.69/1879.39) lat (ms,95%): 65.65 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 24 tps: 931.80 qps: 5590.81 (r/w/o: 0.00/3727.20/1863.60) lat (ms,95%): 65.65 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 24 tps: 1051.38 qps: 6305.20 (r/w/o: 0.00/4202.53/2102.67) lat (ms,95%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 24 tps: 1083.61 qps: 6504.78 (r/w/o: 0.00/4337.45/2167.33) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 24 tps: 1126.00 qps: 6756.01 (r/w/o: 0.00/4504.01/2252.00) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 24 tps: 1126.61 qps: 6759.63 (r/w/o: 0.00/4506.42/2253.21) lat (ms,95%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 24 tps: 1175.39 qps: 7050.52 (r/w/o: 0.00/4699.75/2350.77) lat (ms,95%): 53.85 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 24 tps: 1192.91 qps: 7158.98 (r/w/o: 0.00/4773.16/2385.83) lat (ms,95%): 54.83 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 24 tps: 1148.80 qps: 6893.09 (r/w/o: 0.00/4595.50/2297.60) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 24 tps: 1093.59 qps: 6557.46 (r/w/o: 0.00/4370.27/2187.19) lat (ms,95%): 58.92 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 24 tps: 1120.81 qps: 6724.16 (r/w/o: 0.00/4482.54/2241.62) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 24 tps: 1067.40 qps: 6409.19 (r/w/o: 0.00/4274.39/2134.80) lat (ms,95%): 58.92 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 24 tps: 1160.20 qps: 6961.19 (r/w/o: 0.00/4640.80/2320.40) lat (ms,95%): 55.82 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 24 tps: 1219.40 qps: 7313.00 (r/w/o: 0.00/4874.20/2438.80) lat (ms,95%): 53.85 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 24 tps: 1185.29 qps: 7115.15 (r/w/o: 0.00/4744.57/2370.58) lat (ms,95%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 24 tps: 1185.51 qps: 7110.15 (r/w/o: 0.00/4739.24/2370.92) lat (ms,95%): 55.82 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 24 tps: 1166.20 qps: 7000.12 (r/w/o: 0.00/4667.62/2332.51) lat (ms,95%): 55.82 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 24 tps: 1184.40 qps: 7106.21 (r/w/o: 0.00/4737.41/2368.80) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 24 tps: 1169.19 qps: 7010.11 (r/w/o: 0.00/4672.04/2338.07) lat (ms,95%): 55.82 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 24 tps: 1142.30 qps: 6853.38 (r/w/o: 0.00/4568.49/2284.89) lat (ms,95%): 54.83 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 24 tps: 1119.31 qps: 6721.48 (r/w/o: 0.00/4482.85/2238.63) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 24 tps: 1122.20 qps: 6733.08 (r/w/o: 0.00/4488.69/2244.39) lat (ms,95%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 24 tps: 1101.78 qps: 6610.67 (r/w/o: 0.00/4407.11/2203.56) lat (ms,95%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 24 tps: 1182.02 qps: 7092.22 (r/w/o: 0.00/4728.18/2364.04) lat (ms,95%): 55.82 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 24 tps: 1228.80 qps: 7369.51 (r/w/o: 0.00/4911.91/2457.60) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 24 tps: 1302.29 qps: 7814.75 (r/w/o: 0.00/5210.17/2604.58) lat (ms,95%): 53.85 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 24 tps: 1237.70 qps: 7423.80 (r/w/o: 0.00/4948.40/2475.40) lat (ms,95%): 51.94 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 24 tps: 1203.49 qps: 7222.17 (r/w/o: 0.00/4815.18/2406.99) lat (ms,95%): 53.85 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 24 tps: 1311.02 qps: 7869.14 (r/w/o: 0.00/5247.19/2621.95) lat (ms,95%): 51.02 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 24 tps: 1272.67 qps: 7628.34 (r/w/o: 0.00/5082.90/2545.45) lat (ms,95%): 54.83 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 24 tps: 1199.42 qps: 7202.43 (r/w/o: 0.00/4803.59/2398.84) lat (ms,95%): 53.85 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 24 tps: 1158.40 qps: 6950.39 (r/w/o: 0.00/4633.59/2316.80) lat (ms,95%): 52.89 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 24 tps: 1088.18 qps: 6524.55 (r/w/o: 0.00/4349.50/2175.05) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 24 tps: 1132.90 qps: 6797.13 (r/w/o: 0.00/4530.02/2267.11) lat (ms,95%): 54.83 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 24 tps: 1148.72 qps: 6899.41 (r/w/o: 0.00/4601.98/2297.44) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           2558960
        other:                           1279480
        total:                           3838440
    transactions:                        639740 (1066.17 per sec.)
    queries:                             3838440 (6397.01 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          600.0345s
    total number of events:              639740

Latency (ms):
         min:                                    7.35
         avg:                                   22.51
         max:                                  285.18
         95th percentile:                       62.19
         sum:                             14398337.43

Threads fairness:
    events (avg/stddev):           26655.8333/149.39
    execution time (avg/stddev):   599.9307/0.01



mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-26 15:19:34 0x7fc7939f0700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 10 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 570 srv_active, 0 srv_shutdown, 313 srv_idle
srv_master_thread log flush and writes: 883
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 183572
OS WAIT ARRAY INFO: signal count 87940
RW-shared spins 0, rounds 48793, OS waits 19897
RW-excl spins 0, rounds 168244, OS waits 4992
RW-sx spins 25889, rounds 745965, OS waits 17722
Spin rounds per wait: 48793.00 RW-shared, 168244.00 RW-excl, 28.81 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 67728920
Purge done for trx's n:o < 67728912 undo n:o < 0 state: running but idle
History list length 105
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421984008323136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421984008320400, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421984008316752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 67728919, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 42, OS thread handle 140495148377856, query id 1542264 192.168.1.10 sysbench
---TRANSACTION 67728918, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 51, OS thread handle 140495147837184, query id 1542262 192.168.1.10 sysbench
---TRANSACTION 67728917, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 36, OS thread handle 140495151351552, query id 1542260 192.168.1.10 sysbench
---TRANSACTION 67728916, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 37, OS thread handle 140495150270208, query id 1542258 192.168.1.10 sysbench
---TRANSACTION 67728915, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 33, OS thread handle 140495148918528, query id 1542254 192.168.1.10 sysbench
---TRANSACTION 67728914, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 39, OS thread handle 140495151621888, query id 1542255 192.168.1.10 sysbench
---TRANSACTION 67728913, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 47, OS thread handle 140495150810880, query id 1542263 192.168.1.10 sysbench
---TRANSACTION 67728912, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 50, OS thread handle 140495147026176, query id 1542270 192.168.1.10 sysbench updating
DELETE FROM sbtest13 WHERE id=1006255
---TRANSACTION 67728906, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 46, OS thread handle 140495148107520, query id 1542267 192.168.1.10 sysbench
---TRANSACTION 67728905, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 38, OS thread handle 140495151081216, query id 1542269 192.168.1.10 sysbench
---TRANSACTION 67728904, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 35, OS thread handle 140495145944832, query id 1542261 192.168.1.10 sysbench
---TRANSACTION 67728903, ACTIVE 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 41, OS thread handle 140495149729536, query id 1542265 192.168.1.10 sysbench
---TRANSACTION 67728902, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 32, OS thread handle 140495146215168, query id 1542259 192.168.1.10 sysbench
---TRANSACTION 67728901, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 30, OS thread handle 140495145674496, query id 1542257 192.168.1.10 sysbench
---TRANSACTION 67728900, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 28, OS thread handle 140495148648192, query id 1542266 192.168.1.10 sysbench
---TRANSACTION 67728895, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 44, OS thread handle 140495150540544, query id 1542256 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67728894, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 45, OS thread handle 140495149188864, query id 1542249 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67728893, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 34, OS thread handle 140495145404160, query id 1542253 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67728892, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 40, OS thread handle 140495149459200, query id 1542252 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67728884, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 48, OS thread handle 140495149999872, query id 1542229 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67728879, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 43, OS thread handle 140495146485504, query id 1542201 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67728878, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 29, OS thread handle 140495147296512, query id 1542206 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67728877, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 49, OS thread handle 140495147566848, query id 1542197 192.168.1.10 sysbench starting
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
Pending flushes (fsync) log: 0; buffer pool: 0
191588 OS file reads, 1026952 OS file writes, 160974 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1365.76 writes/s, 407.96 fsyncs/s
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
0.00 hash searches/s, 13849.82 non-hash searches/s
---
LOG
---
Log sequence number 561725486882
Log flushed up to   561725470332
Pages flushed up to 561045527636
Last checkpoint at  561045527636
0 pending log flushes, 0 pending chkp writes
55596 log i/o's done, 187.50 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13193183232
Dictionary memory allocated 259676
Buffer pool size   786336
Free buffers       12282
Database pages     774054
Old database pages 285493
Modified db pages  94436
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 392, not young 10332
0.20 youngs/s, 0.00 non-youngs/s
Pages read 189380, created 602663, written 912407
0.00 reads/s, 6.60 creates/s, 1148.39 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 774054, unzip_LRU len: 0
I/O sum[708960]:cur[9420], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   65528
Free buffers       1023
Database pages     64505
Old database pages 23791
Modified db pages  7844
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 31, not young 52
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15873, created 50186, written 76196
0.00 reads/s, 1.40 creates/s, 84.49 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64505, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7836
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 14, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15902, created 50214, written 75643
0.00 reads/s, 0.00 creates/s, 90.89 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   65528
Free buffers       1021
Database pages     64507
Old database pages 23792
Modified db pages  7837
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 14, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15808, created 50215, written 75834
0.00 reads/s, 1.00 creates/s, 87.69 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64507, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 3
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7775
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 102, not young 2563
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15837, created 50142, written 76648
0.00 reads/s, 0.30 creates/s, 87.09 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 4
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7775
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 54, not young 1437
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15779, created 50208, written 75946
0.00 reads/s, 0.00 creates/s, 102.89 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 5
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7908
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 15, not young 15
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15815, created 50202, written 76017
0.00 reads/s, 0.00 creates/s, 96.69 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 6
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7893
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 43, not young 3126
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15784, created 50235, written 76782
0.00 reads/s, 0.00 creates/s, 104.89 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 7
Buffer pool size   65528
Free buffers       1023
Database pages     64505
Old database pages 23791
Modified db pages  7951
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 33, not young 15
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15576, created 50350, written 76435
0.00 reads/s, 0.70 creates/s, 91.09 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64505, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 8
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7848
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 11, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15620, created 50107, written 75426
0.00 reads/s, 1.70 creates/s, 99.19 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 9
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7769
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 12, not young 0
0.20 youngs/s, 0.00 non-youngs/s
Pages read 15799, created 50240, written 75796
0.00 reads/s, 0.10 creates/s, 117.79 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 10
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7984
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 12, not young 920
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15809, created 50270, written 75739
0.00 reads/s, 0.70 creates/s, 93.89 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
---BUFFER POOL 11
Buffer pool size   65528
Free buffers       1023
Database pages     64505
Old database pages 23791
Modified db pages  8016
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 51, not young 2204
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15778, created 50294, written 75945
0.00 reads/s, 0.70 creates/s, 91.79 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64505, unzip_LRU len: 0
I/O sum[59080]:cur[785], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=17732, Main thread ID=140495312717568, state: sleeping
Number of rows inserted 40254181, updated 508408, deleted 254206, read 762726
906.61 inserts/s, 1813.52 updates/s, 906.41 deletes/s, 2719.43 reads/s
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
2021-10-26 15:19:35 0x7fc7939f0700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 1 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 571 srv_active, 0 srv_shutdown, 313 srv_idle
srv_master_thread log flush and writes: 884
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 184024
--Thread 140495149459200 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140495216961280 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140495147566848 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140495148107520 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140495145404160 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140495151621888 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140495146485504 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140495150540544 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140495208568576 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x2cd9078, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

OS WAIT ARRAY INFO: signal count 88141
RW-shared spins 0, rounds 48989, OS waits 19980
RW-excl spins 0, rounds 168315, OS waits 4994
RW-sx spins 26007, rounds 749332, OS waits 17797
Spin rounds per wait: 48989.00 RW-shared, 168315.00 RW-excl, 28.81 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 67731337
Purge done for trx's n:o < 67731314 undo n:o < 0 state: running
History list length 191
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421984008320400, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421984008316752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 67731336, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 37, OS thread handle 140495150270208, query id 1549520 192.168.1.10 sysbench
---TRANSACTION 67731335, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 29, OS thread handle 140495147296512, query id 1549517 192.168.1.10 sysbench
---TRANSACTION 67731334, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 31, OS thread handle 140495146755840, query id 1549521 192.168.1.10 sysbench
---TRANSACTION 67731333, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 28, OS thread handle 140495148648192, query id 1549522 192.168.1.10 sysbench
---TRANSACTION 67731332, ACTIVE 0 sec preparing
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 38, OS thread handle 140495151081216, query id 1549524 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67731331, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 32, OS thread handle 140495146215168, query id 1549508 192.168.1.10 sysbench updating
DELETE FROM sbtest11 WHERE id=853511
---TRANSACTION 67731330, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 39, OS thread handle 140495151621888, query id 1549460 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=690904
---TRANSACTION 67731329, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 47, OS thread handle 140495150810880, query id 1549507 192.168.1.10 sysbench update
INSERT INTO sbtest12 (id, k, c, pad) VALUES (1003897, 995248, '92727332052-48873141308-81280163946-12616227369-93026833060-50062434809-88321594864-55309992712-18357233370-94083897125', '78910745747-53340487931-15214194367-41708268770-89934048574')
---TRANSACTION 67731328, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 35, OS thread handle 140495145944832, query id 1549516 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67731327, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 34, OS thread handle 140495145404160, query id 1549451 192.168.1.10 sysbench updating
UPDATE sbtest6 SET k=k+1 WHERE id=1289275
---TRANSACTION 67731326, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 42, OS thread handle 140495148377856, query id 1549514 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67731325, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 48, OS thread handle 140495149999872, query id 1549501 192.168.1.10 sysbench update
INSERT INTO sbtest8 (id, k, c, pad) VALUES (1006511, 1005308, '71511102606-86734003494-18031544189-56500513898-22311470031-01470252384-44323150865-52408390130-04047436005-26963119280', '79246607870-23234691644-32961408930-54809929137-61219804843')
---TRANSACTION 67731324, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 51, OS thread handle 140495147837184, query id 1549519 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67731323, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 33, OS thread handle 140495148918528, query id 1549495 192.168.1.10 sysbench update
INSERT INTO sbtest5 (id, k, c, pad) VALUES (996343, 987090, '14887069334-97994368220-71962782786-66610689247-09818661353-92345826004-47736503758-00001287126-38156694432-36397080489', '36814158063-61623368625-54088613225-04313547802-41606011477')
---TRANSACTION 67731322, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 40, OS thread handle 140495149459200, query id 1549498 192.168.1.10 sysbench update
INSERT INTO sbtest3 (id, k, c, pad) VALUES (1004483, 1000806, '36549314244-01258348528-00815959982-08071181926-56454150612-84497237005-85546699913-44616484807-17323531776-57715593834', '05708344167-92880806341-21872754813-48612278331-98331957942')
---TRANSACTION 67731321, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 30, OS thread handle 140495145674496, query id 1549487 192.168.1.10 sysbench update
INSERT INTO sbtest12 (id, k, c, pad) VALUES (998641, 1006443, '08955671133-56938566941-43740830438-55681110555-10222463684-72146177295-41825285559-85753925550-56781582909-00949141766', '70716656946-70950524018-99159214652-35814365020-79845901171')
---TRANSACTION 67731320, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 45, OS thread handle 140495149188864, query id 1549505 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67731319, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 44, OS thread handle 140495150540544, query id 1549486 192.168.1.10 sysbench update
INSERT INTO sbtest5 (id, k, c, pad) VALUES (1007801, 654700, '16149794264-30595880847-93868904712-66230182315-21165147231-97399655300-37879502117-26140103030-97893156919-60209793889', '59198264820-78173216324-51758835308-06576586400-29618417644')
---TRANSACTION 67731318, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 43, OS thread handle 140495146485504, query id 1549435 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=998782
---TRANSACTION 67731317, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 50, OS thread handle 140495147026176, query id 1549496 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67731316, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 46, OS thread handle 140495148107520, query id 1549492 192.168.1.10 sysbench update
INSERT INTO sbtest11 (id, k, c, pad) VALUES (1008527, 1005013, '97933334084-91534622962-87026067571-07631554124-62842500838-34724619444-54448687136-29807386899-49860685776-73384140409', '28955601175-60445115045-02229040620-21777449832-09208789951')
---TRANSACTION 67731315, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 36, OS thread handle 140495151351552, query id 1549493 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 67731314, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 49, OS thread handle 140495147566848, query id 1549478 192.168.1.10 sysbench update
INSERT INTO sbtest7 (id, k, c, pad) VALUES (998355, 1000639, '17276479144-10444184850-63612986605-72098751157-62448523565-76929209979-76016471453-72863750102-64231295950-83501013770', '91710436393-64675690712-83319385207-15484519226-81020690119')
---TRANSACTION 67731291, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 41, OS thread handle 140495149729536, query id 1549523 192.168.1.10 sysbench update
INSERT INTO sbtest8 (id, k, c, pad) VALUES (999274, 1005576, '05525912929-12099880574-64738939536-62312248409-84982379166-46958369770-31541236708-58085377304-09886519347-87929732234', '70294539261-55123779351-53263153029-59422588185-96624363023')
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
I/O thread 9 state: complete io for buf page (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 1; buffer pool: 1
191588 OS file reads, 1028987 OS file writes, 161559 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 2032.97 writes/s, 584.42 fsyncs/s
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
0.00 hash searches/s, 18327.67 non-hash searches/s
---
LOG
---
Log sequence number 561733489769
Log flushed up to   561733480816
Pages flushed up to 561048203355
Last checkpoint at  561045527636
1 pending log flushes, 0 pending chkp writes
55862 log i/o's done, 266.00 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13193183232
Dictionary memory allocated 259676
Buffer pool size   786336
Free buffers       12287
Database pages     774049
Old database pages 285492
Modified db pages  94155
Pending reads      0
Pending writes: LRU 0, flush list 75, single page 0
Pages made young 392, not young 10332
0.00 youngs/s, 0.00 non-youngs/s
Pages read 189380, created 602670, written 914132
0.00 reads/s, 6.99 creates/s, 1723.28 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 774049, unzip_LRU len: 0
I/O sum[709656]:cur[1962], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7756
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 31, not young 52
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15873, created 50186, written 76412
0.00 reads/s, 0.00 creates/s, 215.78 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[127], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7806
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 14, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15902, created 50214, written 75819
0.00 reads/s, 0.00 creates/s, 175.82 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[127], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7764
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 14, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15808, created 50219, written 76023
0.00 reads/s, 4.00 creates/s, 188.81 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[127], unzip sum[0]:cur[0]
---BUFFER POOL 3
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7684
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 102, not young 2563
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15837, created 50142, written 76821
0.00 reads/s, 0.00 creates/s, 172.83 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[127], unzip sum[0]:cur[0]
---BUFFER POOL 4
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7687
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 54, not young 1437
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15779, created 50208, written 76152
0.00 reads/s, 0.00 creates/s, 205.79 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[127], unzip sum[0]:cur[0]
---BUFFER POOL 5
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7908
Pending reads      0
Pending writes: LRU 0, flush list 2, single page 0
Pages made young 15, not young 15
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15815, created 50202, written 76111
0.00 reads/s, 0.00 creates/s, 93.91 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[127], unzip sum[0]:cur[0]
---BUFFER POOL 6
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7814
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 43, not young 3126
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15784, created 50235, written 76979
0.00 reads/s, 0.00 creates/s, 196.80 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[200], unzip sum[0]:cur[0]
---BUFFER POOL 7
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  8000
Pending reads      0
Pending writes: LRU 0, flush list 73, single page 0
Pages made young 33, not young 15
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15576, created 50351, written 76515
0.00 reads/s, 1.00 creates/s, 79.92 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[200], unzip sum[0]:cur[0]
---BUFFER POOL 8
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7860
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 11, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15620, created 50108, written 75536
0.00 reads/s, 1.00 creates/s, 109.89 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[200], unzip sum[0]:cur[0]
---BUFFER POOL 9
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  7787
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 12, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15799, created 50240, written 75903
0.00 reads/s, 0.00 creates/s, 106.89 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[200], unzip sum[0]:cur[0]
---BUFFER POOL 10
Buffer pool size   65528
Free buffers       1024
Database pages     64504
Old database pages 23791
Modified db pages  8054
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 12, not young 920
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15809, created 50270, written 75800
0.00 reads/s, 0.00 creates/s, 60.94 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64504, unzip_LRU len: 0
I/O sum[59138]:cur[200], unzip sum[0]:cur[0]
---BUFFER POOL 11
Buffer pool size   65528
Free buffers       1023
Database pages     64505
Old database pages 23791
Modified db pages  8035
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 51, not young 2204
0.00 youngs/s, 0.00 non-youngs/s
Pages read 15778, created 50295, written 76061
0.00 reads/s, 1.00 creates/s, 115.88 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 64505, unzip_LRU len: 0
I/O sum[59138]:cur[200], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=17732, Main thread ID=140495312717568, state: sleeping
Number of rows inserted 40255398, updated 510850, deleted 255427, read 766392
1215.78 inserts/s, 2439.56 updates/s, 1219.78 deletes/s, 3662.34 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.05 sec)
