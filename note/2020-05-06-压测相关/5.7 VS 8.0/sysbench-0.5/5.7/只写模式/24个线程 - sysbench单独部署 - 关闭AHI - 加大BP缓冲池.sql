
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


purge binary logs to 'mysql-bin.000281';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 \
--table-size=2000000 --threads=24 --time=600 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_24_11_vesion7_notAHI.log &


[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_24_11_vesion7_notAHI.log
Running the test with following options:
Number of threads: 24
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 24 tps: 413.39 qps: 2485.46 (r/w/o: 0.00/1656.67/828.79) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 24 tps: 406.32 qps: 2439.19 (r/w/o: 0.00/1626.16/813.03) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 24 tps: 607.80 qps: 3645.50 (r/w/o: 0.00/2429.90/1215.60) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 24 tps: 825.39 qps: 4957.24 (r/w/o: 0.00/3306.86/1650.38) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 24 tps: 776.80 qps: 4657.80 (r/w/o: 0.00/3103.80/1554.00) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 24 tps: 793.51 qps: 4766.06 (r/w/o: 0.00/3179.04/1587.02) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 24 tps: 675.50 qps: 4047.29 (r/w/o: 0.00/2696.29/1351.00) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 24 tps: 688.09 qps: 4127.84 (r/w/o: 0.00/2751.76/1376.08) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 24 tps: 618.91 qps: 3719.84 (r/w/o: 0.00/2481.92/1237.91) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 24 tps: 773.10 qps: 4638.22 (r/w/o: 0.00/3092.01/1546.21) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 24 tps: 823.80 qps: 4938.89 (r/w/o: 0.00/3291.30/1647.60) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 24 tps: 743.99 qps: 4463.16 (r/w/o: 0.00/2975.27/1487.89) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 24 tps: 783.90 qps: 4707.91 (r/w/o: 0.00/3140.01/1567.90) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 24 tps: 734.91 qps: 4406.23 (r/w/o: 0.00/2936.62/1469.61) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 24 tps: 725.19 qps: 4354.54 (r/w/o: 0.00/2903.96/1450.58) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 24 tps: 723.51 qps: 4341.35 (r/w/o: 0.00/2894.33/1447.02) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 24 tps: 776.50 qps: 4659.11 (r/w/o: 0.00/3106.10/1553.00) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 24 tps: 846.80 qps: 5080.83 (r/w/o: 0.00/3387.22/1693.61) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 24 tps: 840.90 qps: 5045.40 (r/w/o: 0.00/3363.60/1681.80) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 24 tps: 808.10 qps: 4848.61 (r/w/o: 0.00/3232.41/1616.20) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 24 tps: 822.30 qps: 4933.78 (r/w/o: 0.00/3289.19/1644.59) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 24 tps: 781.10 qps: 4682.48 (r/w/o: 0.00/3120.28/1562.19) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 24 tps: 785.20 qps: 4715.32 (r/w/o: 0.00/3144.91/1570.41) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 24 tps: 802.80 qps: 4816.81 (r/w/o: 0.00/3211.21/1605.60) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 24 tps: 835.19 qps: 5011.15 (r/w/o: 0.00/3340.77/1670.38) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 24 tps: 929.91 qps: 5579.46 (r/w/o: 0.00/3719.64/1859.82) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 24 tps: 878.78 qps: 5270.47 (r/w/o: 0.00/3512.92/1757.56) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 24 tps: 844.11 qps: 5060.99 (r/w/o: 0.00/3372.76/1688.23) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 24 tps: 852.20 qps: 5118.70 (r/w/o: 0.00/3414.30/1704.40) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 24 tps: 805.91 qps: 4835.83 (r/w/o: 0.00/3224.02/1611.81) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 24 tps: 817.49 qps: 4904.97 (r/w/o: 0.00/3269.98/1634.99) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 24 tps: 855.71 qps: 5128.64 (r/w/o: 0.00/3417.23/1711.41) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 24 tps: 869.69 qps: 5223.73 (r/w/o: 0.00/3484.35/1739.38) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 24 tps: 927.99 qps: 5567.94 (r/w/o: 0.00/3711.96/1855.98) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 24 tps: 880.12 qps: 5276.89 (r/w/o: 0.00/3516.66/1760.23) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 24 tps: 881.90 qps: 5294.92 (r/w/o: 0.00/3531.11/1763.81) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 24 tps: 864.88 qps: 5189.37 (r/w/o: 0.00/3459.61/1729.76) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 24 tps: 850.91 qps: 5105.68 (r/w/o: 0.00/3403.86/1701.83) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 24 tps: 859.00 qps: 5152.70 (r/w/o: 0.00/3434.70/1718.00) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 24 tps: 875.71 qps: 5251.65 (r/w/o: 0.00/3500.24/1751.42) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 24 tps: 895.20 qps: 5375.10 (r/w/o: 0.00/3584.70/1790.40) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 24 tps: 974.80 qps: 5848.48 (r/w/o: 0.00/3898.89/1949.59) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 24 tps: 901.20 qps: 5406.10 (r/w/o: 0.00/3603.70/1802.40) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 24 tps: 915.60 qps: 5493.43 (r/w/o: 0.00/3662.22/1831.21) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 24 tps: 904.80 qps: 5428.08 (r/w/o: 0.00/3618.49/1809.59) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 24 tps: 858.99 qps: 5155.96 (r/w/o: 0.00/3437.98/1717.99) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 24 tps: 894.31 qps: 5366.13 (r/w/o: 0.00/3577.52/1788.61) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 24 tps: 916.98 qps: 5497.71 (r/w/o: 0.00/3663.74/1833.97) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 24 tps: 917.51 qps: 5509.27 (r/w/o: 0.00/3674.25/1835.02) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 24 tps: 976.91 qps: 5861.33 (r/w/o: 0.00/3907.52/1953.81) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 24 tps: 960.09 qps: 5760.66 (r/w/o: 0.00/3840.47/1920.19) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 24 tps: 922.78 qps: 5536.68 (r/w/o: 0.00/3691.12/1845.56) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 24 tps: 930.93 qps: 5580.87 (r/w/o: 0.00/3719.01/1861.86) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 24 tps: 885.50 qps: 5317.68 (r/w/o: 0.00/3546.69/1770.99) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 24 tps: 915.88 qps: 5492.98 (r/w/o: 0.00/3661.22/1831.76) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 24 tps: 915.62 qps: 5495.03 (r/w/o: 0.00/3663.78/1831.24) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 24 tps: 932.79 qps: 5594.05 (r/w/o: 0.00/3728.47/1865.58) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 24 tps: 964.20 qps: 5785.19 (r/w/o: 0.00/3856.79/1928.40) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 24 tps: 975.11 qps: 5854.27 (r/w/o: 0.00/3904.05/1950.22) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 24 tps: 964.19 qps: 5785.26 (r/w/o: 0.00/3856.87/1928.39) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           1997328
        other:                           998664
        total:                           2995992
    transactions:                        499332 (832.15 per sec.)
    queries:                             2995992 (4992.92 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          600.0462s
    total number of events:              499332

Latency (ms):
         min:                                    7.25
         avg:                                   28.84
         max:                                  300.04
         95th percentile:                       87.56
         sum:                             14399150.53

Threads fairness:
    events (avg/stddev):           20805.5000/173.14
    execution time (avg/stddev):   599.9646/0.00


[root@voice sbtest]# top
top - 10:52:14 up 100 days, 19:50,  3 users,  load average: 5.17, 4.55, 5.00
Tasks: 118 total,   2 running, 116 sleeping,   0 stopped,   0 zombie
%Cpu0  : 34.7 us, 20.4 sy,  0.0 ni, 29.9 id, 10.2 wa,  0.0 hi,  4.8 si,  0.0 st
%Cpu1  : 28.9 us, 12.1 sy,  0.0 ni, 40.3 id, 15.4 wa,  0.0 hi,  3.4 si,  0.0 st
%Cpu2  : 33.8 us, 13.1 sy,  0.0 ni, 38.6 id, 11.7 wa,  0.0 hi,  2.8 si,  0.0 st
%Cpu3  : 26.8 us, 12.1 sy,  0.0 ni, 34.2 id, 25.5 wa,  0.0 hi,  1.3 si,  0.0 st
KiB Mem : 16266300 total,   181524 free, 14761072 used,  1323704 buff/cache
KiB Swap:        0 total,        0 free,        0 used.   386232 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
31963 mysql     20   0   15.7g  13.5g   2784 S 192.7 87.1  83:06.79 mysqld                 


[root@voice sbtest]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/25/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.14    2.33   12.35     0.15     0.48    87.76     0.18   12.00   25.51    9.45   0.54   0.79

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     5.00    1.00 1646.00     0.01    48.03    59.73     2.81    1.67    1.00    1.67   0.55  90.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1569.00     0.00    48.06    62.74     2.96    1.89    0.00    1.89   0.58  91.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1494.00     0.00    47.82    65.55     2.89    1.97    0.00    1.97   0.61  90.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1479.00     0.00    48.16    66.69     2.90    1.96    0.00    1.96   0.61  89.50

^C
[root@voice sbtest]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/25/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.73    0.00    0.73    0.24    0.00   98.30

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              14.68       152.04       492.18 1324486978 4287618184

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          28.32    0.00   15.05   22.45    0.00   34.18

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1688.00         0.00     49168.00          0      49168

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          26.79    0.00   14.80   20.92    0.00   37.50

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1639.00         0.00     49164.00          0      49164

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          30.15    0.00   16.49   17.27    0.00   36.08

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1575.00         0.00     49172.00          0      49172

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          26.42    0.00   14.51   20.21    0.00   38.86

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1533.00         0.00     49112.00          0      49112


mysql> show engine innodb mutex;
+--------+-----------------------------+-------------+
| Type   | Name                        | Status      |
+--------+-----------------------------+-------------+
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1204  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1182  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1273  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1302  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1213  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1164  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1329  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1364  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1323  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1358  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1302  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1350  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1355  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1193  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1231  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1264  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1201  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1197  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1280  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1316  |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=2     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=2     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=3     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=2     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=2     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=1     |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=10    |
| InnoDB | rwlock: dict0dict.cc:2737   | waits=24    |
| InnoDB | rwlock: dict0dict.cc:1183   | waits=809   |
| InnoDB | rwlock: fil0fil.cc:1383     | waits=24266 |
| InnoDB | rwlock: log0log.cc:838      | waits=570   |
| InnoDB | rwlock: hash0hash.cc:353    | waits=87    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=49    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=37    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=36    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=59    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=37    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=62    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=16    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=59    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=103   |
| InnoDB | rwlock: hash0hash.cc:353    | waits=27    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=30    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=74    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=49    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=52    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=30    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=31    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=24    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=37    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=89    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=32    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=35    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=36    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=45    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=77    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=22    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=25    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=54    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=20    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=42    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=27    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=55    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=46    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=33    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=99    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=17    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=33    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=58    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=73    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=44    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=57    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=41    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=28    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=27    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=42    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=109   |
| InnoDB | rwlock: hash0hash.cc:353    | waits=27    |
| InnoDB | rwlock: hash0hash.cc:353    | waits=49    |
| InnoDB | sum rwlock: buf0buf.cc:1460 | waits=93844 |
+--------+-----------------------------+-------------+
86 rows in set (0.05 sec)

mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-25 10:46:57 0x7f508c080700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 13 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 2047 srv_active, 0 srv_shutdown, 1010 srv_idle
srv_master_thread log flush and writes: 3057
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 3371135
--Thread 139983806048000 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 139983811725056 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 139983804966656 has waited at btr0cur.cc line 976 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7f50380a3820 created in file dict0dict.cc line 2737
a writer (thread id 139983804696320) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file btr0cur.cc line 1008
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
--Thread 139983806859008 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 139983811454720 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 139983805777664 has waited at btr0cur.cc line 976 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7f5000542060 created in file dict0dict.cc line 2737
a writer (thread id 139983806048000) has reserved it in mode  SX
number of readers 1, waiters flag 1, lock_word: fffffff
Last time read locked in file btr0cur.cc line 1008
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
--Thread 139983804696320 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 139983808210688 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 139983809562368 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x3c62d78, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 139983947863808 has waited at btr0cur.cc line 976 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7f50380a3820 created in file dict0dict.cc line 2737
a writer (thread id 139983804696320) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file btr0cur.cc line 1008
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
OS WAIT ARRAY INFO: signal count 1272001
RW-shared spins 0, rounds 212921, OS waits 73352
RW-excl spins 0, rounds 951265, OS waits 31429
RW-sx spins 83061, rounds 2386719, OS waits 54565
Spin rounds per wait: 212921.00 RW-shared, 951265.00 RW-excl, 28.73 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 64634293
Purge done for trx's n:o < 64634222 undo n:o < 0 state: running
History list length 317
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421472668569200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421472668567376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 64634292, ACTIVE (PREPARED) 0 sec
7 lock struct(s), heap size 1136, 4 row lock(s), undo log entries 4
MySQL thread id 132, OS thread handle 139983808751360, query id 4693469 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634290, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 135, OS thread handle 139983808210688, query id 4693438 192.168.1.10 sysbench updating
UPDATE sbtest12 SET k=k+1 WHERE id=1189401
---TRANSACTION 64634288, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 130, OS thread handle 139983810373376, query id 4693457 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634287, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 133, OS thread handle 139983809292032, query id 4693439 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634286, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 137, OS thread handle 139983804696320, query id 4693432 192.168.1.10 sysbench update
INSERT INTO sbtest8 (id, k, c, pad) VALUES (998513, 1002503, '60559602549-87573672895-01308245129-80714065441-85172219533-13269900456-53151193210-80383551825-61196723453-30819996006', '22912687560-07492113111-17794508886-03885585765-27843326516')
---TRANSACTION 64634285, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 138, OS thread handle 139983807399680, query id 4693436 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634284, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 140, OS thread handle 139983811454720, query id 4693403 192.168.1.10 sysbench updating
UPDATE sbtest16 SET k=k+1 WHERE id=1006456
---TRANSACTION 64634283, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 119, OS thread handle 139983806859008, query id 4693431 192.168.1.10 sysbench update
INSERT INTO sbtest14 (id, k, c, pad) VALUES (1007317, 1240323, '78652781698-56731370771-38852880107-03260994595-20214682686-89558937578-61668355955-47714273759-84877086150-79299440792', '97032876165-11649668813-98796444807-19097230759-28430015555')
---TRANSACTION 64634282, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 120, OS thread handle 139983805507328, query id 4693437 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634281, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 117, OS thread handle 139983803614976, query id 4693453 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634280, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 131, OS thread handle 139983810643712, query id 4693450 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634278, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 125, OS thread handle 139983809562368, query id 4693387 192.168.1.10 sysbench updating
UPDATE sbtest8 SET k=k+1 WHERE id=1000781
---TRANSACTION 64634266, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 127, OS thread handle 139983811725056, query id 4693385 192.168.1.10 sysbench updating
UPDATE sbtest5 SET k=k+1 WHERE id=995384
---TRANSACTION 64634263, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 123, OS thread handle 139983806588672, query id 4693465 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634262, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 121, OS thread handle 139983806318336, query id 4693455 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634261, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 139, OS thread handle 139983806048000, query id 4693376 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (998735, 997966, '40929185053-40594568129-82860344660-95698628876-70870860991-62501676449-42111930862-36411067343-80838533549-73884905221', '52590874986-64235867912-03318677928-62688215854-01942710972')
---TRANSACTION 64634260, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 136, OS thread handle 139983805236992, query id 4693454 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634259, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 126, OS thread handle 139983809832704, query id 4693446 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634257, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 134, OS thread handle 139983805777664, query id 4693365 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (995126, 1007443, '28452881761-36445914062-87447337914-79291193844-24961438364-70262752105-49592424006-41754474836-95597547123-98346530405', '73025812048-32792715041-84793371466-23240426170-98722837422')
---TRANSACTION 64634255, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 128, OS thread handle 139983804966656, query id 4693321 192.168.1.10 sysbench updating
UPDATE sbtest8 SET k=k+1 WHERE id=1006930
---TRANSACTION 64634253, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 129, OS thread handle 139983804425984, query id 4693449 192.168.1.10 sysbench updating
DELETE FROM sbtest13 WHERE id=997029
---TRANSACTION 64634248, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 122, OS thread handle 139983809021696, query id 4693463 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634247, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 118, OS thread handle 139983804155648, query id 4693464 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 64634225, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 124, OS thread handle 139983807940352, query id 4693441 192.168.1.10 sysbench starting
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
400445 OS file reads, 3152900 OS file writes, 456399 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1512.88 writes/s, 362.97 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 2 merges
merged operations:
 insert 0, delete mark 2, delete 0
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
0.00 hash searches/s, 12422.35 non-hash searches/s
---
LOG
---
Log sequence number 520152959218
Log flushed up to   520152902030
Pages flushed up to 519740245913
Last checkpoint at  519721048087
1 pending log flushes, 0 pending chkp writes
140835 log i/o's done, 179.77 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 13193183232
Dictionary memory allocated 259676
Buffer pool size   786336
Free buffers       3071
Database pages     783265
Old database pages 289074
Modified db pages  78880
Pending reads      0
Pending writes: LRU 0, flush list 125, single page 0
Pages made young 736063, not young 326217
12.69 youngs/s, 0.00 non-youngs/s
Pages read 395120, created 1507094, written 2854610
0.00 reads/s, 5.77 creates/s, 1308.82 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 783265, unzip_LRU len: 0
I/O sum[184509]:cur[1539], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1023
Database pages     261089
Old database pages 96358
Modified db pages  26298
Pending reads      0
Pending writes: LRU 0, flush list 35, single page 0
Pages made young 245798, not young 97318
4.15 youngs/s, 0.00 non-youngs/s
Pages read 131408, created 502619, written 954008
0.00 reads/s, 2.46 creates/s, 453.81 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 261089, unzip_LRU len: 0
I/O sum[61503]:cur[513], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       1024
Database pages     261088
Old database pages 96358
Modified db pages  26271
Pending reads      0
Pending writes: LRU 0, flush list 17, single page 0
Pages made young 244955, not young 102144
4.54 youngs/s, 0.00 non-youngs/s
Pages read 131570, created 502071, written 948831
0.00 reads/s, 1.69 creates/s, 419.28 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 261088, unzip_LRU len: 0
I/O sum[61503]:cur[513], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   262112
Free buffers       1024
Database pages     261088
Old database pages 96358
Modified db pages  26311
Pending reads      0
Pending writes: LRU 0, flush list 73, single page 0
Pages made young 245310, not young 126755
4.00 youngs/s, 0.00 non-youngs/s
Pages read 132142, created 502404, written 951771
0.00 reads/s, 1.62 creates/s, 435.74 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 261088, unzip_LRU len: 0
I/O sum[61503]:cur[513], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=31963, Main thread ID=139983973041920, state: sleeping
Number of rows inserted 100774615, updated 1549455, deleted 774731, read 2324458
815.24 inserts/s, 1630.64 updates/s, 815.24 deletes/s, 2446.35 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.04 sec)


