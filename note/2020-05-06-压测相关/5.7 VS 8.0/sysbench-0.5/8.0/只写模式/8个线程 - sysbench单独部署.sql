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

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench --mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 --table-size=2000000 --threads=16 --time=1800 --report-interval=10 --db-driver=mysql prepare



purge binary logs to 'mysql-bin.000033';  



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


purge binary logs to 'mysql-bin.000044';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench \
--mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 \
--table-size=2000000 --threads=8 --time=600 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_8_11_vesion8.log &


[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_8_11_vesion8.log
[ 10s ] thds: 8 tps: 465.80 qps: 2798.69 (r/w/o: 0.00/1866.29/932.40) lat (ms,95%): 24.83 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 8 tps: 530.32 qps: 3180.33 (r/w/o: 0.00/2119.79/1060.54) lat (ms,95%): 22.28 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 8 tps: 570.39 qps: 3421.67 (r/w/o: 0.00/2281.18/1140.49) lat (ms,95%): 21.11 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 8 tps: 600.01 qps: 3601.94 (r/w/o: 0.00/2401.53/1200.41) lat (ms,95%): 20.37 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 8 tps: 593.50 qps: 3559.29 (r/w/o: 0.00/2372.29/1187.00) lat (ms,95%): 20.00 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 8 tps: 615.10 qps: 3690.39 (r/w/o: 0.00/2460.19/1230.20) lat (ms,95%): 19.65 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 8 tps: 616.90 qps: 3702.12 (r/w/o: 0.00/2468.61/1233.51) lat (ms,95%): 19.65 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 8 tps: 625.10 qps: 3750.59 (r/w/o: 0.00/2500.09/1250.50) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 8 tps: 628.20 qps: 3769.19 (r/w/o: 0.00/2512.79/1256.40) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 8 tps: 639.30 qps: 3834.21 (r/w/o: 0.00/2556.21/1278.00) lat (ms,95%): 18.61 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 8 tps: 634.60 qps: 3809.80 (r/w/o: 0.00/2540.00/1269.80) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 8 tps: 618.70 qps: 3712.92 (r/w/o: 0.00/2475.51/1237.41) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 8 tps: 547.00 qps: 3282.41 (r/w/o: 0.00/2188.41/1094.00) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 8 tps: 543.50 qps: 3260.99 (r/w/o: 0.00/2173.99/1087.00) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 8 tps: 546.30 qps: 3276.59 (r/w/o: 0.00/2184.09/1092.50) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 8 tps: 522.60 qps: 3136.82 (r/w/o: 0.00/2091.51/1045.31) lat (ms,95%): 32.53 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 8 tps: 533.70 qps: 3202.18 (r/w/o: 0.00/2134.79/1067.39) lat (ms,95%): 31.37 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 8 tps: 549.40 qps: 3296.01 (r/w/o: 0.00/2197.21/1098.80) lat (ms,95%): 30.81 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 8 tps: 557.50 qps: 3345.38 (r/w/o: 0.00/2230.39/1114.99) lat (ms,95%): 29.72 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 8 tps: 569.40 qps: 3416.42 (r/w/o: 0.00/2277.62/1138.81) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 8 tps: 559.30 qps: 3355.40 (r/w/o: 0.00/2236.80/1118.60) lat (ms,95%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 8 tps: 569.00 qps: 3414.40 (r/w/o: 0.00/2276.40/1138.00) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 8 tps: 572.39 qps: 3434.36 (r/w/o: 0.00/2289.58/1144.79) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 8 tps: 556.31 qps: 3337.85 (r/w/o: 0.00/2225.23/1112.62) lat (ms,95%): 30.81 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 8 tps: 569.00 qps: 3411.38 (r/w/o: 0.00/2273.39/1137.99) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 8 tps: 580.00 qps: 3482.59 (r/w/o: 0.00/2322.59/1160.00) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 8 tps: 551.50 qps: 3309.02 (r/w/o: 0.00/2206.01/1103.01) lat (ms,95%): 29.72 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 8 tps: 563.70 qps: 3382.18 (r/w/o: 0.00/2254.79/1127.39) lat (ms,95%): 29.72 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 8 tps: 569.80 qps: 3418.42 (r/w/o: 0.00/2278.82/1139.61) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 8 tps: 574.40 qps: 3446.79 (r/w/o: 0.00/2297.99/1148.80) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 8 tps: 586.70 qps: 3517.89 (r/w/o: 0.00/2344.59/1173.30) lat (ms,95%): 25.74 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 8 tps: 581.90 qps: 3493.70 (r/w/o: 0.00/2329.80/1163.90) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 8 tps: 559.30 qps: 3355.80 (r/w/o: 0.00/2237.20/1118.60) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 8 tps: 582.10 qps: 3492.61 (r/w/o: 0.00/2328.40/1164.20) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 8 tps: 583.19 qps: 3496.26 (r/w/o: 0.00/2329.87/1166.39) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 8 tps: 587.41 qps: 3526.04 (r/w/o: 0.00/2351.23/1174.81) lat (ms,95%): 25.28 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 8 tps: 598.20 qps: 3590.32 (r/w/o: 0.00/2393.91/1196.41) lat (ms,95%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 8 tps: 583.80 qps: 3502.28 (r/w/o: 0.00/2334.68/1167.59) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 8 tps: 581.89 qps: 3492.06 (r/w/o: 0.00/2328.27/1163.79) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 8 tps: 590.90 qps: 3542.60 (r/w/o: 0.00/2360.80/1181.80) lat (ms,95%): 26.68 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 8 tps: 582.40 qps: 3496.40 (r/w/o: 0.00/2331.60/1164.80) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 8 tps: 581.91 qps: 3492.25 (r/w/o: 0.00/2328.43/1163.82) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 8 tps: 576.30 qps: 3457.80 (r/w/o: 0.00/2305.20/1152.60) lat (ms,95%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 8 tps: 588.69 qps: 3531.96 (r/w/o: 0.00/2354.47/1177.49) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 8 tps: 573.21 qps: 3438.33 (r/w/o: 0.00/2292.02/1146.31) lat (ms,95%): 24.38 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 8 tps: 577.10 qps: 3463.71 (r/w/o: 0.00/2309.50/1154.20) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 8 tps: 576.40 qps: 3457.89 (r/w/o: 0.00/2305.19/1152.70) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 8 tps: 578.30 qps: 3470.31 (r/w/o: 0.00/2313.60/1156.70) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 8 tps: 567.50 qps: 3405.00 (r/w/o: 0.00/2270.00/1135.00) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 8 tps: 587.20 qps: 3523.01 (r/w/o: 0.00/2348.60/1174.40) lat (ms,95%): 25.28 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 8 tps: 576.29 qps: 3454.95 (r/w/o: 0.00/2302.97/1151.98) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 8 tps: 589.90 qps: 3542.13 (r/w/o: 0.00/2361.72/1180.41) lat (ms,95%): 24.38 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 8 tps: 582.30 qps: 3494.10 (r/w/o: 0.00/2329.50/1164.60) lat (ms,95%): 26.20 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 8 tps: 584.50 qps: 3506.99 (r/w/o: 0.00/2337.99/1169.00) lat (ms,95%): 25.28 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 8 tps: 581.00 qps: 3486.02 (r/w/o: 0.00/2324.02/1162.01) lat (ms,95%): 25.28 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 8 tps: 570.90 qps: 3425.42 (r/w/o: 0.00/2283.61/1141.81) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 8 tps: 560.10 qps: 3360.59 (r/w/o: 0.00/2240.39/1120.20) lat (ms,95%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 8 tps: 576.59 qps: 3459.54 (r/w/o: 0.00/2306.36/1153.18) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 8 tps: 579.21 qps: 3475.26 (r/w/o: 0.00/2316.84/1158.42) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 8 tps: 575.39 qps: 3452.36 (r/w/o: 0.00/2301.57/1150.79) lat (ms,95%): 25.74 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           1382968
        other:                           691484
        total:                           2074452
    transactions:                        345742 (576.23 per sec.)
    queries:                             2074452 (3457.36 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          600.0091s
    total number of events:              345742

Latency (ms):
         min:                                    7.55
         avg:                                   13.88
         max:                                  190.81
         95th percentile:                       25.74
         sum:                              4798785.92

Threads fairness:
    events (avg/stddev):           43217.7500/234.06
    execution time (avg/stddev):   599.8482/0.01



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+----------------------------+------------------+
| Id | User            | Host               | db     | Command | Time | State                      | Info             |
+----+-----------------+--------------------+--------+---------+------+----------------------------+------------------+
|  5 | event_scheduler | localhost          | NULL   | Daemon  | 4598 | Waiting on empty queue     | NULL             |
| 90 | sysbench        | 192.168.1.12:59472 | sbtest | Query   |    0 | init                       | show processlist |
| 91 | sysbench        | 192.168.1.10:54307 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
| 92 | sysbench        | 192.168.1.10:54306 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
| 93 | sysbench        | 192.168.1.10:54310 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
| 94 | sysbench        | 192.168.1.10:54318 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
| 95 | sysbench        | 192.168.1.10:54320 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
| 96 | sysbench        | 192.168.1.10:54316 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
| 97 | sysbench        | 192.168.1.10:54314 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
| 98 | sysbench        | 192.168.1.10:54312 | sbtest | Execute |    0 | waiting for handler commit | COMMIT           |
+----+-----------------+--------------------+--------+---------+------+----------------------------+------------------+
10 rows in set (0.01 sec)



[coding001@voice ~]$ top
top - 12:19:26 up 100 days, 21:17,  4 users,  load average: 4.37, 2.22, 3.34
Tasks: 121 total,   2 running, 119 sleeping,   0 stopped,   0 zombie
%Cpu0  : 24.0 us, 10.0 sy,  0.0 ni, 52.0 id,  8.0 wa,  0.0 hi,  6.0 si,  0.0 st
%Cpu1  : 34.0 us, 11.3 sy,  0.0 ni, 43.4 id, 11.3 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu2  : 22.6 us,  9.4 sy,  0.0 ni, 54.7 id, 13.2 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  : 29.4 us,  5.9 sy,  0.0 ni, 52.9 id, 11.8 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem : 16266300 total,   164068 free, 14902068 used,  1200164 buff/cache
KiB Swap:        0 total,        0 free,        0 used.   263680 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
 7738 mysql     20   0   15.5g  13.6g   4432 S 162.5 88.0  82:53.59 mysqld         
 
 
 [coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/25/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.14    2.35   12.93     0.15     0.50    86.81     0.18   12.10   25.44    9.67   0.53   0.82

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00   41.00 3335.00     2.65    46.61    29.88     4.94    1.50    6.44    1.44   0.28  92.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00   28.00 3386.00     0.44    45.62    27.63     4.22    1.24    1.54    1.23   0.27  91.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00   29.00 3352.00     0.45    44.52    27.24     4.04    1.20    1.17    1.20   0.27  91.00

^C
[coding001@voice ~]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/25/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.75    0.00    0.73    0.24    0.00   98.28

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              15.28       152.84       510.15 1332294502 4446789648

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          22.55    0.00   10.88   15.12    0.00   51.46

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3388.00       464.00     44840.00        464      44840

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          22.87    0.00   10.64   14.63    0.00   51.86

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3447.00       464.00     44236.00        464      44236



mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-25 12:20:04 140510397470464 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 8 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 1962 srv_active, 0 srv_shutdown, 2428 srv_idle
srv_master_thread log flush and writes: 0
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 80927
OS WAIT ARRAY INFO: signal count 1195188
RW-shared spins 0, rounds 0, OS waits 0
RW-excl spins 0, rounds 0, OS waits 0
RW-sx spins 0, rounds 0, OS waits 0
Spin rounds per wait: 0.00 RW-shared, 0.00 RW-excl, 0.00 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 14770007
Purge done for trx's n:o < 14769958 undo n:o < 0 state: running but idle
History list length 158
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421999717555416, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 421999717554608, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 421999717553800, not started flushing log
mysql tables in use 1, locked 1
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 14770005, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 91, OS thread handle 140516633749248, query id 5064491 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 14770003, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 95, OS thread handle 140510399067904, query id 5064482 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 14770002, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 92, OS thread handle 140516500719360, query id 5064480 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 14770001, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 96, OS thread handle 140516502849280, query id 5064488 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 14770000, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 94, OS thread handle 140516504979200, query id 5064479 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 14769999, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 97, OS thread handle 140516502316800, query id 5064481 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 14769993, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 93, OS thread handle 140516506044160, query id 5064464 192.168.1.10 sysbench waiting for handler commit
COMMIT
---TRANSACTION 14769992, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 98, OS thread handle 140516501251840, query id 5064465 192.168.1.10 sysbench waiting for handler commit
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
I/O thread 15 state: waiting for completed aio requests (write thread)
I/O thread 16 state: waiting for completed aio requests (write thread)
I/O thread 17 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 0, 0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 1; buffer pool: 86
61908 OS file reads, 8049273 OS file writes, 1417248 OS fsyncs
0 pending preads, 3 pending pwrites
32.00 reads/s, 16384 avg bytes/read, 3043.87 writes/s, 1173.48 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 0, seg size 2, 13933 merges
merged operations:
 insert 0, delete mark 13935, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 3187567, node heap has 50 buffer(s)
Hash table size 3187567, node heap has 97 buffer(s)
Hash table size 3187567, node heap has 98 buffer(s)
Hash table size 3187567, node heap has 430 buffer(s)
Hash table size 3187567, node heap has 143 buffer(s)
Hash table size 3187567, node heap has 144 buffer(s)
Hash table size 3187567, node heap has 1 buffer(s)
Hash table size 3187567, node heap has 1 buffer(s)
1959.51 hash searches/s, 7032.87 non-hash searches/s
---
LOG
---
Log sequence number          123826606896
Log buffer assigned up to    123826606896
Log buffer completed up to   123826606896
Log written up to            123826606896
Log flushed up to            123826600064
Added dirty pages up to      123826606896
Pages flushed up to          123135830148
Last checkpoint at           123128749738
5361632 log i/o's done, 1984.12 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13155827712
Dictionary memory allocated 617279
Buffer pool size   786360
Free buffers       12000
Database pages     773396
Old database pages 285430
Modified db pages  104109
Pending reads      0
Pending writes: LRU 0, flush list 30, single page 0
Pages made young 520239, not young 232684
0.00 youngs/s, 0.00 non-youngs/s
Pages read 56607, created 1504096, written 2353810
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 2 / 1000 not 2 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 773396, unzip_LRU len: 0
I/O sum[151212]:cur[90], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262122
Free buffers       4000
Database pages     257802
Old database pages 95145
Modified db pages  34669
Pending reads      0
Pending writes: LRU 0, flush list 10, single page 0
Pages made young 172370, not young 92265
0.00 youngs/s, 0.00 non-youngs/s
Pages read 18813, created 501402, written 783765
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 2 / 1000 not 2 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 257802, unzip_LRU len: 0
I/O sum[50404]:cur[30], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262120
Free buffers       4000
Database pages     257796
Old database pages 95142
Modified db pages  34466
Pending reads      0
Pending writes: LRU 0, flush list 10, single page 0
Pages made young 173897, not young 86466
0.00 youngs/s, 0.00 non-youngs/s
Pages read 18880, created 500983, written 785247
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 2 / 1000 not 1 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 257796, unzip_LRU len: 0
I/O sum[50404]:cur[30], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   262118
Free buffers       4000
Database pages     257798
Old database pages 95143
Modified db pages  34974
Pending reads      0
Pending writes: LRU 0, flush list 10, single page 0
Pages made young 173972, not young 53953
0.00 youngs/s, 0.00 non-youngs/s
Pages read 18914, created 501711, written 784798
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 2 / 1000 not 2 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 257798, unzip_LRU len: 0
I/O sum[50404]:cur[30], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=7738, Main thread ID=140510415853312 , state=sleeping
Number of rows inserted 100836068, updated 1674049, deleted 837018, read 2511108
541.93 inserts/s, 1083.49 updates/s, 541.81 deletes/s, 1625.30 reads/s
Number of system rows inserted 15071, updated 1157, deleted 14596, read 22868
9.87 inserts/s, 0.25 updates/s, 12.75 deletes/s, 13.50 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.10 sec)


