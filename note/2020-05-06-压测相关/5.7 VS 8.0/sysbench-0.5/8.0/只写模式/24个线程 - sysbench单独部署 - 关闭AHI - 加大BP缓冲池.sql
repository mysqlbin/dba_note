
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

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench --mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 --table-size=2000000 --threads=24 --time=600 --report-interval=10 --db-driver=mysql prepare &



purge binary logs to 'mysql-bin.000324';  



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


purge binary logs to 'mysql-bin.000069';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench \
--mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 \
--table-size=2000000 --threads=24 --time=600 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_24_11_vesion8_notAHI.log &


[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_24_11_vesion8_notAHI.log
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 24 tps: 1278.39 qps: 7679.93 (r/w/o: 0.00/5120.85/2559.08) lat (ms,95%): 33.12 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 24 tps: 1350.37 qps: 8098.63 (r/w/o: 0.00/5398.79/2699.84) lat (ms,95%): 32.53 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 24 tps: 1389.89 qps: 8338.15 (r/w/o: 0.00/5558.47/2779.68) lat (ms,95%): 31.37 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 24 tps: 1375.62 qps: 8259.00 (r/w/o: 0.00/5506.67/2752.33) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 24 tps: 1386.19 qps: 8317.53 (r/w/o: 0.00/5545.25/2772.28) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 24 tps: 1411.12 qps: 8466.94 (r/w/o: 0.00/5644.59/2822.35) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 24 tps: 1430.49 qps: 8582.27 (r/w/o: 0.00/5721.48/2860.79) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 24 tps: 1437.19 qps: 8624.64 (r/w/o: 0.00/5750.06/2874.58) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 24 tps: 1461.90 qps: 8767.50 (r/w/o: 0.00/5844.30/2923.20) lat (ms,95%): 26.68 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 24 tps: 1451.11 qps: 8709.25 (r/w/o: 0.00/5806.53/2902.72) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 24 tps: 1274.30 qps: 7647.63 (r/w/o: 0.00/5098.92/2548.71) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 24 tps: 736.89 qps: 4419.47 (r/w/o: 0.00/2945.68/1473.79) lat (ms,95%): 51.94 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 24 tps: 779.30 qps: 4677.73 (r/w/o: 0.00/3119.12/1558.61) lat (ms,95%): 51.94 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 24 tps: 780.90 qps: 4683.67 (r/w/o: 0.00/3121.88/1561.79) lat (ms,95%): 54.83 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 24 tps: 883.91 qps: 5298.65 (r/w/o: 0.00/3531.43/1767.22) lat (ms,95%): 51.02 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 24 tps: 1057.09 qps: 6345.46 (r/w/o: 0.00/4230.68/2114.79) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 24 tps: 1293.01 qps: 7758.44 (r/w/o: 0.00/5172.43/2586.01) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 24 tps: 1349.49 qps: 8098.27 (r/w/o: 0.00/5399.28/2698.99) lat (ms,95%): 35.59 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 24 tps: 1397.69 qps: 8384.15 (r/w/o: 0.00/5588.77/2795.38) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 24 tps: 1413.00 qps: 8476.09 (r/w/o: 0.00/5650.69/2825.40) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 24 tps: 1256.41 qps: 7539.54 (r/w/o: 0.00/5026.13/2513.41) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 24 tps: 1077.61 qps: 6467.46 (r/w/o: 0.00/4312.24/2155.22) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 24 tps: 967.39 qps: 5802.12 (r/w/o: 0.00/3867.84/1934.27) lat (ms,95%): 49.21 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 24 tps: 897.10 qps: 5386.13 (r/w/o: 0.00/3591.42/1794.71) lat (ms,95%): 49.21 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 24 tps: 996.00 qps: 5975.90 (r/w/o: 0.00/3983.90/1992.00) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 24 tps: 1161.90 qps: 6968.31 (r/w/o: 0.00/4645.20/2323.10) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 24 tps: 1283.69 qps: 7704.87 (r/w/o: 0.00/5136.98/2567.89) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 24 tps: 1406.28 qps: 8434.61 (r/w/o: 0.00/5622.74/2811.87) lat (ms,95%): 30.81 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 24 tps: 1478.92 qps: 8874.64 (r/w/o: 0.00/5916.39/2958.25) lat (ms,95%): 26.20 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 24 tps: 1469.11 qps: 8814.65 (r/w/o: 0.00/5876.04/2938.62) lat (ms,95%): 26.68 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 24 tps: 1406.69 qps: 8443.14 (r/w/o: 0.00/5629.66/2813.48) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 24 tps: 1254.80 qps: 7526.27 (r/w/o: 0.00/5016.68/2509.59) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 24 tps: 1007.50 qps: 6041.09 (r/w/o: 0.00/4026.89/2014.20) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 24 tps: 1063.21 qps: 6385.16 (r/w/o: 0.00/4257.94/2127.22) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 24 tps: 988.70 qps: 5928.58 (r/w/o: 0.00/3951.89/1976.69) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 24 tps: 1144.70 qps: 6869.19 (r/w/o: 0.00/4579.39/2289.80) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 24 tps: 1261.71 qps: 7572.86 (r/w/o: 0.00/5049.14/2523.72) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 24 tps: 1357.38 qps: 8142.07 (r/w/o: 0.00/5427.52/2714.56) lat (ms,95%): 35.59 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 24 tps: 1413.70 qps: 8483.83 (r/w/o: 0.00/5656.22/2827.61) lat (ms,95%): 30.81 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 24 tps: 1473.51 qps: 8840.34 (r/w/o: 0.00/5893.33/2947.01) lat (ms,95%): 26.68 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 24 tps: 1439.81 qps: 8637.55 (r/w/o: 0.00/5757.93/2879.62) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 24 tps: 1377.01 qps: 8266.25 (r/w/o: 0.00/5512.24/2754.02) lat (ms,95%): 33.12 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 24 tps: 1343.79 qps: 8058.55 (r/w/o: 0.00/5371.47/2687.08) lat (ms,95%): 33.12 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 24 tps: 1143.20 qps: 6862.58 (r/w/o: 0.00/4575.68/2286.89) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 24 tps: 1068.69 qps: 6409.87 (r/w/o: 0.00/4272.58/2137.29) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 24 tps: 1059.91 qps: 6361.96 (r/w/o: 0.00/4242.04/2119.92) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 24 tps: 1147.59 qps: 6885.97 (r/w/o: 0.00/4590.78/2295.19) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 24 tps: 1233.80 qps: 7400.71 (r/w/o: 0.00/4933.11/2467.60) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 24 tps: 1361.58 qps: 8166.18 (r/w/o: 0.00/5443.42/2722.76) lat (ms,95%): 36.89 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 24 tps: 1384.52 qps: 8310.74 (r/w/o: 0.00/5541.39/2769.35) lat (ms,95%): 34.33 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 24 tps: 1451.30 qps: 8706.58 (r/w/o: 0.00/5803.89/2902.69) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 24 tps: 1463.12 qps: 8779.59 (r/w/o: 0.00/5853.76/2925.83) lat (ms,95%): 26.68 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 24 tps: 1417.40 qps: 8501.31 (r/w/o: 0.00/5666.90/2834.40) lat (ms,95%): 31.37 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 24 tps: 1408.07 qps: 8449.89 (r/w/o: 0.00/5632.96/2816.93) lat (ms,95%): 31.37 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 24 tps: 1360.00 qps: 8159.62 (r/w/o: 0.00/5439.61/2720.01) lat (ms,95%): 36.24 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 24 tps: 1194.92 qps: 7168.02 (r/w/o: 0.00/4778.78/2389.24) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 24 tps: 1080.89 qps: 6489.26 (r/w/o: 0.00/4326.87/2162.39) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 24 tps: 1172.31 qps: 7034.45 (r/w/o: 0.00/4689.83/2344.62) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 24 tps: 1199.48 qps: 7195.90 (r/w/o: 0.00/4797.03/2398.87) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 24 tps: 1273.60 qps: 7642.00 (r/w/o: 0.00/5094.70/2547.30) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           2995512
        other:                           1497756
        total:                           4493268
    transactions:                        748878 (1248.08 per sec.)
    queries:                             4493268 (7488.47 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          600.0232s
    total number of events:              748878

Latency (ms):
         min:                                    8.45
         avg:                                   19.23
         max:                                   99.95
         95th percentile:                       41.10
         sum:                             14397544.26

Threads fairness:
    events (avg/stddev):           31203.2500/666.09
    execution time (avg/stddev):   599.8977/0.01


[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/25/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.14    2.34   12.67     0.15     0.49    87.04     0.18   12.08   25.52    9.60   0.53   0.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    1.00 3382.00     0.01    49.72    30.10     5.22    1.54    0.00    1.55   0.26  88.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 3272.00     0.00    47.61    29.80     5.33    1.63    0.00    1.63   0.28  91.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    1.00 3272.00     0.02    47.70    29.86     4.74    1.45    1.00    1.45   0.27  88.30

^C
[coding001@voice ~]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/25/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.74    0.00    0.73    0.24    0.00   98.29

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              15.01       152.43       500.72 1328141994 4362969252

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          42.37    0.00   17.37   10.53    0.00   29.74

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3287.00         0.00     49188.00          0      49188

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          41.64    0.00   18.57   11.67    0.00   28.12

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3289.00         0.00     49172.00          0      49172


[coding001@voice ~]$ top
top - 11:24:39 up 100 days, 20:22,  4 users,  load average: 6.88, 7.18, 7.00
Tasks: 122 total,   2 running, 120 sleeping,   0 stopped,   0 zombie
%Cpu0  : 45.7 us, 14.2 sy,  0.0 ni, 23.3 id,  7.3 wa,  0.0 hi,  9.5 si,  0.0 st
%Cpu1  : 45.4 us, 13.5 sy,  0.0 ni, 26.6 id, 11.4 wa,  0.0 hi,  3.1 si,  0.0 st
%Cpu2  : 48.7 us, 12.0 sy,  0.0 ni, 24.4 id, 10.3 wa,  0.0 hi,  4.7 si,  0.0 st
%Cpu3  : 43.2 us, 13.1 sy,  0.0 ni, 30.1 id, 11.0 wa,  0.0 hi,  2.5 si,  0.0 st
KiB Mem : 16266300 total,   161076 free, 12140008 used,  3965216 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  2984260 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
 7738 mysql     20   0   15.5g  11.0g   7088 S 256.8 71.0  46:33.33 mysqld              

mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+----------------------------+------------------+
| Id | User            | Host               | db     | Command | Time | State                      | Info             |
+----+-----------------+--------------------+--------+---------+------+----------------------------+------------------+
|  5 | event_scheduler | localhost          | NULL   | Daemon  |  899 | Waiting on empty queue     | NULL             |
|  8 | sysbench        | 192.168.1.12:59066 | sbtest | Query   |    0 | init                       | show processlist |
| 33 | sysbench        | 192.168.1.10:53866 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 34 | sysbench        | 192.168.1.10:53868 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 35 | sysbench        | 192.168.1.10:53870 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 36 | sysbench        | 192.168.1.10:53872 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 37 | sysbench        | 192.168.1.10:53874 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 38 | sysbench        | 192.168.1.10:53876 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 39 | sysbench        | 192.168.1.10:53878 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 40 | sysbench        | 192.168.1.10:53880 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 41 | sysbench        | 192.168.1.10:53884 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 42 | sysbench        | 192.168.1.10:53886 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 43 | sysbench        | 192.168.1.10:53882 | sbtest | Sleep   |    1 |                            | NULL             |
| 44 | sysbench        | 192.168.1.10:53888 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 45 | sysbench        | 192.168.1.10:53890 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 46 | sysbench        | 192.168.1.10:53892 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 47 | sysbench        | 192.168.1.10:53894 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 48 | sysbench        | 192.168.1.10:53896 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 49 | sysbench        | 192.168.1.10:53900 | sbtest | Sleep   |    1 |                            | NULL             |
| 50 | sysbench        | 192.168.1.10:53898 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 51 | sysbench        | 192.168.1.10:53904 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 52 | sysbench        | 192.168.1.10:53902 | sbtest | Sleep   |    0 |                            | NULL             |
| 53 | sysbench        | 192.168.1.10:53908 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 54 | sysbench        | 192.168.1.10:53906 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 55 | sysbench        | 192.168.1.10:53910 | sbtest | Execute |    1 | waiting for handler commit | COMMIT           |
| 56 | sysbench        | 192.168.1.10:53912 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
+----+-----------------+--------------------+--------+---------+------+----------------------------+------------------+
26 rows in set (0.00 sec)

mysql> show engine innodb mutex;
+--------+------------------------------+------------+
| Type   | Name                         | Status     |
+--------+------------------------------+------------+
| InnoDB | rwlock: dict0dict.cc:2512    | waits=9    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=8    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=10   |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=5    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=12   |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=7    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=12   |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=7    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=4    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=8    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=5    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=8    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=4    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=6    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=7    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=17   |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=6    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=11   |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=4    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=8    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=1    |
| InnoDB | rwlock: fil0fil.cc:3333      | waits=1    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=1    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=4    |
| InnoDB | rwlock: dict0dict.cc:2512    | waits=1    |
| InnoDB | rwlock: fil0fil.cc:3333      | waits=1    |
| InnoDB | rwlock: fil0fil.cc:3333      | waits=2928 |
| InnoDB | rwlock: fil0fil.cc:3333      | waits=2915 |
| InnoDB | rwlock: dict0dict.cc:1033    | waits=54   |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=2    |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=1    |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=1    |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=1    |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=1    |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=1    |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=1    |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=1    |
| InnoDB | rwlock: sync0sharded_rw.h:80 | waits=1    |
| InnoDB | rwlock: btr0sea.cc:202       | waits=380  |
| InnoDB | rwlock: btr0sea.cc:202       | waits=686  |
| InnoDB | rwlock: btr0sea.cc:202       | waits=59   |
| InnoDB | rwlock: btr0sea.cc:202       | waits=1099 |
| InnoDB | rwlock: btr0sea.cc:202       | waits=2    |
| InnoDB | rwlock: hash0hash.cc:162     | waits=17   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=23   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=22   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=20   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=11   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=14   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=5    |
| InnoDB | rwlock: hash0hash.cc:162     | waits=30   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=15   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=21   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=21   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=20   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=26   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=32   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=14   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=20   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=21   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=27   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=11   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=17   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=20   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=7    |
| InnoDB | rwlock: hash0hash.cc:162     | waits=16   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=18   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=23   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=35   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=38   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=24   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=44   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=13   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=23   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=11   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=16   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=20   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=10   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=9    |
| InnoDB | rwlock: hash0hash.cc:162     | waits=19   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=11   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=31   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=25   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=21   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=19   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=25   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=13   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=11   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=12   |
| InnoDB | rwlock: hash0hash.cc:162     | waits=4    |
| InnoDB | rwlock: hash0hash.cc:162     | waits=17   |
| InnoDB | sum rwlock: buf0buf.cc:788   | waits=1018 |
+--------+------------------------------+------------+
92 rows in set (0.08 sec)


mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-25 11:19:04 140516634281728 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 1 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 631 srv_active, 0 srv_shutdown, 255 srv_idle
srv_master_thread log flush and writes: 0
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 23904
OS WAIT ARRAY INFO: signal count 391880
RW-shared spins 0, rounds 0, OS waits 0
RW-excl spins 0, rounds 0, OS waits 0
RW-sx spins 0, rounds 0, OS waits 0
Spin rounds per wait: 0.00 RW-shared, 0.00 RW-excl, 0.00 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 13625431
Purge done for trx's n:o < 13625333 undo n:o < 0 state: running but idle
History list length 49
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421999717555416, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 421999717554608, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 421999717553800, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 13625430, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 40, OS thread handle 140516502849280, query id 1771867 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625428, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 48, OS thread handle 140516501251840, query id 1771861 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625426, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 53, OS thread handle 140510398535424, query id 1771850 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625425, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 52, OS thread handle 140516506576640, query id 1771848 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625424, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 43, OS thread handle 140516500186880, query id 1771849 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625423, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 55, OS thread handle 140516501784320, query id 1771846 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625422, ACTIVE (PREPARED) 0 sec
7 lock struct(s), heap size 1128, 4 row lock(s), undo log entries 4
MySQL thread id 56, OS thread handle 140516504979200, query id 1771842 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625421, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 35, OS thread handle 140510396405504, query id 1771851 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625420, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 46, OS thread handle 140510398002944, query id 1771847 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625419, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 51, OS thread handle 140516504446720, query id 1771838 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625418, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 54, OS thread handle 140516503381760, query id 1771833 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625417, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 37, OS thread handle 140516502316800, query id 1771829 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625416, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 34, OS thread handle 140510397470464, query id 1771821 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625415, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 47, OS thread handle 140516503914240, query id 1771825 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625414, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 39, OS thread handle 140516506044160, query id 1771814 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625413, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 50, OS thread handle 140516499654400, query id 1771815 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625412, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 49, OS thread handle 140510399067904, query id 1771841 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625411, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 41, OS thread handle 140516500719360, query id 1771809 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625410, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 36, OS thread handle 140510394808064, query id 1771789 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625409, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 42, OS thread handle 140516505511680, query id 1771786 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625408, ACTIVE (PREPARED) 0 sec
7 lock struct(s), heap size 1128, 4 row lock(s), undo log entries 4
MySQL thread id 33, OS thread handle 140510396937984, query id 1771783 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625407, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 44, OS thread handle 140510395873024, query id 1771769 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625406, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 38, OS thread handle 140516633749248, query id 1771792 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 13625374, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 45, OS thread handle 140510395340544, query id 1771858 192.168.1.10 sysbench waiting for handler commit
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
I/O thread 6 state: waiting for completed aio requests (read thread)
I/O thread 7 state: waiting for completed aio requests (read thread)
I/O thread 8 state: waiting for completed aio requests (read thread)
I/O thread 9 state: waiting for completed aio requests (read thread)
I/O thread 10 state: waiting for completed aio requests (write thread)
I/O thread 11 state: waiting for completed aio requests (write thread)
I/O thread 12 state: waiting for completed aio requests (write thread)
I/O thread 13 state: waiting for completed aio requests (write thread)
I/O thread 14 state: waiting for completed aio requests (write thread)
I/O thread 15 state: complete io for buf page (write thread)
I/O thread 16 state: waiting for completed aio requests (write thread)
I/O thread 17 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [1, 1, 1, 1, 1, 3, 1, 1] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 1; buffer pool: 12
3280 OS file reads, 2718023 OS file writes, 386515 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1634.37 writes/s, 563.44 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 0, seg size 2, 0 merges
merged operations:
 insert 0, delete mark 0, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 3187567, node heap has 195 buffer(s)
Hash table size 3187567, node heap has 193 buffer(s)
Hash table size 3187567, node heap has 1162 buffer(s)
Hash table size 3187567, node heap has 2 buffer(s)
Hash table size 3187567, node heap has 387 buffer(s)
Hash table size 3187567, node heap has 198 buffer(s)
Hash table size 3187567, node heap has 965 buffer(s)
Hash table size 3187567, node heap has 768 buffer(s)
2466.53 hash searches/s, 6533.47 non-hash searches/s
---
LOG
---
Log sequence number          104438540685
Log buffer assigned up to    104438540685
Log buffer completed up to   104438540685
Log written up to            104438540685
Log flushed up to            104438535268
Added dirty pages up to      104438540685
Pages flushed up to          103698522404
Last checkpoint at           103697100343
1799303 log i/o's done, 1007.00 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13155827712
Dictionary memory allocated 612605
Buffer pool size   786360
Free buffers       178280
Database pages     604210
Old database pages 222978
Modified db pages  106379
Pending reads      0
Pending writes: LRU 0, flush list 40, single page 0
Pages made young 2, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 1097, created 603113, written 837982
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 604210, unzip_LRU len: 0
I/O sum[0]:cur[456], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262122
Free buffers       59308
Database pages     201525
Old database pages 74371
Modified db pages  35552
Pending reads      0
Pending writes: LRU 0, flush list 18, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 374, created 201151, written 278937
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 201525, unzip_LRU len: 0
I/O sum[0]:cur[152], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262120
Free buffers       59605
Database pages     201225
Old database pages 74260
Modified db pages  35344
Pending reads      0
Pending writes: LRU 0, flush list 11, single page 0
Pages made young 0, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 373, created 200852, written 279519
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 201225, unzip_LRU len: 0
I/O sum[0]:cur[152], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   262118
Free buffers       59367
Database pages     201460
Old database pages 74347
Modified db pages  35483
Pending reads      0
Pending writes: LRU 0, flush list 11, single page 0
Pages made young 2, not young 0
0.00 youngs/s, 0.00 non-youngs/s
Pages read 350, created 201110, written 279526
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 201460, unzip_LRU len: 0
I/O sum[0]:cur[152], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=7738, Main thread ID=140510415853312 , state=sleeping
Number of rows inserted 40292023, updated 584923, deleted 292458, read 877395
587.41 inserts/s, 1172.83 updates/s, 586.41 deletes/s, 1759.24 reads/s
Number of system rows inserted 5480, updated 692, deleted 5031, read 11382
4.00 inserts/s, 0.00 updates/s, 0.00 deletes/s, 0.00 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.00 sec)

