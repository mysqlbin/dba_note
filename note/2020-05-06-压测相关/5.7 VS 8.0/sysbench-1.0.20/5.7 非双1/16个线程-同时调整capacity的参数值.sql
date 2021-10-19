


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
		
set global sync_binlog=0;
set global innodb_flush_log_at_trx_commit=0;
 
mysql -uroot -p'zP1ExFNsugs%' sbtest < sbtest.sql &

sudo /etc/init.d/mysql restart 

set global sync_binlog=1000;
set global innodb_flush_log_at_trx_commit=2;


set global innodb_io_capacity=5000;
set global innodb_io_capacity_max=20000;


show global variables like '%sync_binlog%';
show global variables like '%innodb_flush_log_at_trx_commit%';

show global variables like '%innodb_io_capacity%';

mysql> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 1000  |
+---------------+-------+
1 row in set (0.01 sec)

mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_trx_commit | 2     |
+--------------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like '%innodb_io_capacity%';
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| innodb_io_capacity     | 5000  |
| innodb_io_capacity_max | 20000 |
+------------------------+-------+
2 rows in set (0.01 sec)


sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='' \
--mysql-db=sbtest \
--num-threads=16 \
--oltp-table-size=5000000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=1800 \
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_16_not16_.log &

[coding001@voice data_volume]$ top
1
top - 18:05:52 up 94 days,  3:04,  4 users,  load average: 18.56, 13.78, 8.45
Tasks: 121 total,   1 running, 120 sleeping,   0 stopped,   0 zombie
%Cpu0  : 19.7 us,  9.4 sy,  0.0 ni,  0.0 id, 68.6 wa,  0.0 hi,  2.3 si,  0.0 st
%Cpu1  : 16.3 us,  7.3 sy,  0.0 ni,  1.7 id, 73.7 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu2  : 18.1 us, 10.5 sy,  0.0 ni,  0.7 id, 69.1 wa,  0.0 hi,  1.6 si,  0.0 st
%Cpu3  : 15.1 us,  6.4 sy,  0.0 ni,  0.0 id, 77.2 wa,  0.0 hi,  1.3 si,  0.0 st
KiB Mem : 16266300 total,   159676 free,  9854812 used,  6251812 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5352896 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   8.8g   8808 S  93.7 57.0   5:13.68 mysqld                                                                                                                                                                    
 6570 coding0+  20   0 1156100   8328   1768 S  15.8  0.1   0:43.11 sysbench                                                                                                                                                                  
12433 coding0+  20   0  174352  26916    600 S   2.6  0.2 210:15.00 skynet  





压力太大，IO抗不住，需要升级IO能力。

2021-10-18T10:06:51.797484Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 7691ms. The settings might not be optimal. (flushed=102 and evicted=839, during the time.)
2021-10-18T10:07:06.466885Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5820ms. The settings might not be optimal. (flushed=86 and evicted=747, during the time.)
2021-10-18T10:07:14.980116Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5243ms. The settings might not be optimal. (flushed=67 and evicted=725, during the time.)
2021-10-18T10:07:29.428352Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5271ms. The settings might not be optimal. (flushed=69 and evicted=730, during the time.)
2021-10-18T10:07:56.146500Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5538ms. The settings might not be optimal. (flushed=52 and evicted=666, during the time.)
2021-10-18T10:08:04.410622Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4652ms. The settings might not be optimal. (flushed=47 and evicted=563, during the time.)
2021-10-18T10:08:21.607165Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 7092ms. The settings might not be optimal. (flushed=55 and evicted=693, during the time.)
2021-10-18T10:08:48.867269Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 6508ms. The settings might not be optimal. (flushed=48 and evicted=723, during the time.)
2021-10-18T10:09:34.251544Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4560ms. The settings might not be optimal. (flushed=52 and evicted=636, during the time.)
2021-10-18T10:11:15.030569Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5483ms. The settings might not be optimal. (flushed=54 and evicted=592, during the time.)
2021-10-18T10:13:44.446121Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5851ms. The settings might not be optimal. (flushed=34 and evicted=421, during the time.)
2021-10-18T10:14:01.886430Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 6427ms. The settings might not be optimal. (flushed=34 and evicted=516, during the time.)
2021-10-18T10:14:31.082506Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 6338ms. The settings might not be optimal. (flushed=37 and evicted=740, during the time.)
2021-10-18T10:15:32.611907Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 6264ms. The settings might not be optimal. (flushed=34 and evicted=631, during the time.)
2021-10-18T10:17:29.461793Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 7489ms. The settings might not be optimal. (flushed=32 and evicted=707, during the time.)
2021-10-18T10:21:24.449531Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 7076ms. The settings might not be optimal. (flushed=26 and evicted=691, during the time.)




[coding001@voice data_volume]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    1.79    3.25     0.12     0.13   100.83     0.05   10.42   24.36    2.76   0.67   0.34

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  813.00  209.00    47.98     6.33   108.83    33.38   33.06   41.02    2.08   0.98 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  986.00  381.00    48.01    11.80    89.61    26.98   19.24   25.66    2.63   0.73 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  993.00   60.00    48.13     3.67   100.76    28.81   27.93   29.55    1.17   0.95 100.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  918.00  288.00    47.89     9.66    97.72    34.58   28.68   36.98    2.23   0.83 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  943.00  324.00    48.19    11.79    96.95    33.60   26.12   34.51    1.72   0.79  99.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  859.00   58.00    47.76     2.24   111.67    33.67   36.96   39.41    0.76   1.09 100.00



[coding001@voice data_volume]$ iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.43    0.00    0.64    0.15    0.00   98.78

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               5.04       121.66       132.45  989456658 1077162424

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          18.59    0.00    9.80   71.11    0.00    0.50

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1094.00     49244.00      6944.00      49244       6944

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          18.23    0.00    9.62   70.13    0.00    2.03

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1204.00     49080.00     11156.00      49080      11156

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          18.73    0.00   10.13   70.63    0.00    0.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1256.00     49180.00     11576.00      49180      11576

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          19.95    0.00   10.10   69.19    0.00    0.76

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1185.00     49152.00      7128.00      49152       7128

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          23.41    0.00   11.96   64.12    0.00    0.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1159.00     49124.00      5848.00      49124       5848

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.84    0.00    8.93   72.45    0.00    1.79

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1030.00     49212.00      5620.00      49212       5620

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          18.09    0.00   10.30   70.35    0.00    1.26

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1024.00     49120.00      3852.00      49120       3852

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          19.64    0.00    9.44   69.90    0.00    1.02

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1089.00     49136.00      4452.00      49136       4452








[coding001@voice ~]$ tail -f sysbench_oltpX_16_not16_.log


Initializing worker threads...

Threads started!

[ 10s ] thds: 16 tps: 131.17 qps: 2639.98 (r/w/o: 1850.86/525.18/263.94) lat (ms,99%): 802.05 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 16 tps: 41.70 qps: 830.39 (r/w/o: 580.69/166.30/83.40) lat (ms,99%): 977.74 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 16 tps: 35.60 qps: 716.01 (r/w/o: 502.21/142.60/71.20) lat (ms,99%): 1032.01 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 16 tps: 35.90 qps: 718.80 (r/w/o: 503.40/143.60/71.80) lat (ms,99%): 1149.76 err/s: 0.00 reconn/s: 0.00




[ 50s ] thds: 16 tps: 35.80 qps: 715.58 (r/w/o: 500.99/143.00/71.60) lat (ms,99%): 1401.61 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 16 tps: 44.40 qps: 884.83 (r/w/o: 618.22/177.81/88.80) lat (ms,99%): 1032.01 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 16 tps: 41.20 qps: 825.59 (r/w/o: 578.30/164.90/82.40) lat (ms,99%): 1013.60 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 16 tps: 46.80 qps: 936.60 (r/w/o: 655.70/187.30/93.60) lat (ms,99%): 977.74 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 16 tps: 52.40 qps: 1049.09 (r/w/o: 735.00/209.30/104.80) lat (ms,99%): 926.33 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 16 tps: 53.50 qps: 1066.81 (r/w/o: 745.81/214.00/107.00) lat (ms,99%): 909.80 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 16 tps: 56.70 qps: 1136.79 (r/w/o: 796.59/226.80/113.40) lat (ms,99%): 787.74 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 16 tps: 57.30 qps: 1147.21 (r/w/o: 803.10/229.50/114.60) lat (ms,99%): 831.46 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 16 tps: 72.59 qps: 1450.80 (r/w/o: 1015.43/290.18/145.19) lat (ms,99%): 657.93 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 16 tps: 76.71 qps: 1532.42 (r/w/o: 1072.08/307.02/153.31) lat (ms,99%): 612.21 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 16 tps: 78.50 qps: 1569.50 (r/w/o: 1098.60/313.80/157.10) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 16 tps: 88.20 qps: 1760.00 (r/w/o: 1231.00/352.60/176.40) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 16 tps: 84.40 qps: 1691.19 (r/w/o: 1184.69/337.70/168.80) lat (ms,99%): 623.33 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 16 tps: 74.50 qps: 1487.10 (r/w/o: 1040.10/298.00/149.00) lat (ms,99%): 733.00 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 16 tps: 74.90 qps: 1503.49 (r/w/o: 1053.89/299.80/149.80) lat (ms,99%): 646.19 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 16 tps: 74.30 qps: 1484.31 (r/w/o: 1038.61/297.10/148.60) lat (ms,99%): 646.19 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 16 tps: 66.70 qps: 1331.29 (r/w/o: 931.19/266.70/133.40) lat (ms,99%): 646.19 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 16 tps: 60.20 qps: 1208.71 (r/w/o: 847.30/241.00/120.40) lat (ms,99%): 773.68 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 16 tps: 61.30 qps: 1226.60 (r/w/o: 859.00/245.00/122.60) lat (ms,99%): 669.89 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 16 tps: 60.70 qps: 1212.61 (r/w/o: 848.24/242.98/121.39) lat (ms,99%): 694.45 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 16 tps: 62.00 qps: 1238.38 (r/w/o: 866.46/247.92/124.01) lat (ms,99%): 719.92 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 16 tps: 69.60 qps: 1393.60 (r/w/o: 975.70/278.70/139.20) lat (ms,99%): 634.66 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 16 tps: 65.40 qps: 1307.88 (r/w/o: 915.98/261.10/130.80) lat (ms,99%): 646.19 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 16 tps: 80.20 qps: 1601.74 (r/w/o: 1120.33/321.01/160.40) lat (ms,99%): 657.93 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 16 tps: 90.90 qps: 1822.29 (r/w/o: 1276.79/363.70/181.80) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 16 tps: 84.90 qps: 1694.49 (r/w/o: 1184.99/339.70/169.80) lat (ms,99%): 646.19 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 16 tps: 102.40 qps: 2051.00 (r/w/o: 1436.30/409.90/204.80) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 16 tps: 101.30 qps: 2024.00 (r/w/o: 1416.90/404.50/202.60) lat (ms,99%): 580.02 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 16 tps: 102.60 qps: 2050.91 (r/w/o: 1435.11/410.60/205.20) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 16 tps: 106.20 qps: 2128.09 (r/w/o: 1490.60/425.10/212.40) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 16 tps: 102.99 qps: 2055.60 (r/w/o: 1438.09/411.54/205.97) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 16 tps: 99.31 qps: 1991.27 (r/w/o: 1395.39/397.25/198.63) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 16 tps: 111.20 qps: 2222.70 (r/w/o: 1555.00/445.30/222.40) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 16 tps: 97.20 qps: 1941.61 (r/w/o: 1358.71/388.50/194.40) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 16 tps: 120.20 qps: 2400.71 (r/w/o: 1679.51/480.80/240.40) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 16 tps: 122.40 qps: 2448.89 (r/w/o: 1714.59/489.50/244.80) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 16 tps: 114.90 qps: 2298.89 (r/w/o: 1609.39/459.70/229.80) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 16 tps: 120.40 qps: 2409.61 (r/w/o: 1687.51/481.30/240.80) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 16 tps: 119.30 qps: 2385.21 (r/w/o: 1669.31/477.30/238.60) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 16 tps: 123.00 qps: 2463.18 (r/w/o: 1725.08/492.10/246.00) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 16 tps: 113.29 qps: 2263.94 (r/w/o: 1584.02/453.35/226.57) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 16 tps: 126.32 qps: 2524.83 (r/w/o: 1767.13/505.07/252.63) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 16 tps: 109.60 qps: 2193.38 (r/w/o: 1535.78/438.40/219.20) lat (ms,99%): 590.56 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 16 tps: 112.90 qps: 2254.91 (r/w/o: 1577.51/451.60/225.80) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 16 tps: 107.80 qps: 2158.91 (r/w/o: 1512.21/431.10/215.60) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 16 tps: 108.00 qps: 2160.79 (r/w/o: 1512.79/432.00/216.00) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 16 tps: 102.40 qps: 2049.21 (r/w/o: 1434.83/409.58/204.79) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 16 tps: 118.41 qps: 2364.62 (r/w/o: 1653.89/473.92/236.81) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 16 tps: 98.30 qps: 1968.44 (r/w/o: 1378.95/392.89/196.59) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 16 tps: 104.50 qps: 2089.26 (r/w/o: 1461.95/418.31/209.01) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 16 tps: 108.70 qps: 2174.21 (r/w/o: 1522.40/434.40/217.40) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 16 tps: 101.80 qps: 2035.09 (r/w/o: 1424.10/407.40/203.60) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 16 tps: 100.40 qps: 2007.31 (r/w/o: 1404.90/401.60/200.80) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 16 tps: 109.40 qps: 2190.19 (r/w/o: 1533.80/437.60/218.80) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 16 tps: 106.80 qps: 2135.18 (r/w/o: 1494.39/427.20/213.60) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 16 tps: 114.50 qps: 2292.62 (r/w/o: 1605.22/458.40/229.00) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 16 tps: 110.70 qps: 2208.45 (r/w/o: 1544.87/442.29/221.30) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 16 tps: 102.10 qps: 2043.14 (r/w/o: 1430.32/408.51/204.30) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 16 tps: 95.60 qps: 1912.00 (r/w/o: 1338.60/382.20/191.20) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 16 tps: 89.10 qps: 1785.31 (r/w/o: 1250.31/356.80/178.20) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 16 tps: 89.70 qps: 1792.29 (r/w/o: 1254.19/358.70/179.40) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 16 tps: 104.50 qps: 2087.41 (r/w/o: 1460.70/417.70/209.00) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 16 tps: 101.90 qps: 2039.38 (r/w/o: 1427.79/407.80/203.80) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 16 tps: 93.60 qps: 1873.82 (r/w/o: 1312.41/374.20/187.20) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 16 tps: 101.30 qps: 2023.50 (r/w/o: 1415.50/405.40/202.60) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 16 tps: 100.19 qps: 2005.63 (r/w/o: 1404.28/400.97/200.38) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 16 tps: 104.31 qps: 2086.17 (r/w/o: 1460.42/417.13/208.62) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 16 tps: 97.30 qps: 1944.29 (r/w/o: 1360.80/388.90/194.60) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 16 tps: 103.00 qps: 2061.42 (r/w/o: 1442.71/412.70/206.00) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 16 tps: 100.60 qps: 2011.28 (r/w/o: 1408.09/402.00/201.20) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 16 tps: 90.30 qps: 1806.00 (r/w/o: 1264.30/361.10/180.60) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 16 tps: 95.60 qps: 1912.11 (r/w/o: 1338.31/382.60/191.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 16 tps: 94.30 qps: 1886.21 (r/w/o: 1320.14/377.48/188.59) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 16 tps: 99.00 qps: 1979.29 (r/w/o: 1385.76/395.52/198.01) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 16 tps: 103.70 qps: 2076.91 (r/w/o: 1454.61/414.90/207.40) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 16 tps: 94.40 qps: 1889.49 (r/w/o: 1322.89/377.80/188.80) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 16 tps: 102.00 qps: 2031.41 (r/w/o: 1419.70/407.70/204.00) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 16 tps: 90.50 qps: 1817.59 (r/w/o: 1274.39/362.20/181.00) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 16 tps: 88.10 qps: 1757.70 (r/w/o: 1229.30/352.20/176.20) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 16 tps: 90.90 qps: 1820.28 (r/w/o: 1274.69/363.80/181.80) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 16 tps: 99.40 qps: 1985.82 (r/w/o: 1389.51/397.50/198.80) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 16 tps: 88.60 qps: 1774.11 (r/w/o: 1242.41/354.50/177.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 16 tps: 90.29 qps: 1801.26 (r/w/o: 1259.90/360.77/180.59) lat (ms,99%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 16 tps: 89.01 qps: 1787.53 (r/w/o: 1252.99/356.53/178.01) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 16 tps: 86.80 qps: 1731.29 (r/w/o: 1211.00/346.70/173.60) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 16 tps: 85.30 qps: 1708.80 (r/w/o: 1196.80/341.40/170.60) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 16 tps: 84.50 qps: 1694.00 (r/w/o: 1186.60/338.40/169.00) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 16 tps: 85.50 qps: 1704.90 (r/w/o: 1192.20/341.70/171.00) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 16 tps: 85.60 qps: 1711.79 (r/w/o: 1198.09/342.50/171.20) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 16 tps: 89.50 qps: 1790.50 (r/w/o: 1253.60/357.90/179.00) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 16 tps: 86.20 qps: 1720.42 (r/w/o: 1203.51/344.50/172.40) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 16 tps: 86.10 qps: 1725.69 (r/w/o: 1209.00/344.50/172.20) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 16 tps: 86.90 qps: 1738.00 (r/w/o: 1216.40/347.80/173.80) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 16 tps: 81.80 qps: 1634.70 (r/w/o: 1144.20/326.90/163.60) lat (ms,99%): 559.50 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 16 tps: 87.70 qps: 1753.90 (r/w/o: 1227.30/351.20/175.40) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 16 tps: 92.30 qps: 1842.90 (r/w/o: 1289.30/369.00/184.60) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 16 tps: 78.10 qps: 1565.51 (r/w/o: 1096.61/312.70/156.20) lat (ms,99%): 601.29 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 16 tps: 88.70 qps: 1769.78 (r/w/o: 1238.09/354.30/177.40) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 16 tps: 82.70 qps: 1658.31 (r/w/o: 1162.01/330.90/165.40) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 16 tps: 81.80 qps: 1637.20 (r/w/o: 1146.00/327.70/163.50) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 16 tps: 93.10 qps: 1860.49 (r/w/o: 1302.10/372.10/186.30) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 16 tps: 82.30 qps: 1648.39 (r/w/o: 1154.60/329.20/164.60) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 16 tps: 76.40 qps: 1526.81 (r/w/o: 1068.50/305.50/152.80) lat (ms,99%): 719.92 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 16 tps: 87.50 qps: 1750.27 (r/w/o: 1224.98/350.29/175.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 16 tps: 78.70 qps: 1573.02 (r/w/o: 1101.12/314.50/157.40) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 16 tps: 86.60 qps: 1731.69 (r/w/o: 1212.10/346.40/173.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 16 tps: 81.20 qps: 1629.10 (r/w/o: 1141.70/325.00/162.40) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 16 tps: 87.00 qps: 1734.50 (r/w/o: 1212.60/347.90/174.00) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 16 tps: 91.70 qps: 1838.40 (r/w/o: 1287.90/367.10/183.40) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 16 tps: 81.60 qps: 1627.71 (r/w/o: 1138.40/326.10/163.20) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 16 tps: 81.20 qps: 1625.20 (r/w/o: 1138.30/324.50/162.40) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 16 tps: 81.60 qps: 1630.60 (r/w/o: 1140.90/326.50/163.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 16 tps: 80.50 qps: 1612.90 (r/w/o: 1129.20/322.70/161.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 16 tps: 79.80 qps: 1592.01 (r/w/o: 1113.81/318.60/159.60) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 16 tps: 79.00 qps: 1579.99 (r/w/o: 1106.19/315.80/158.00) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 16 tps: 84.70 qps: 1693.61 (r/w/o: 1185.41/338.80/169.40) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 16 tps: 92.90 qps: 1860.98 (r/w/o: 1303.59/371.60/185.80) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 16 tps: 86.10 qps: 1722.61 (r/w/o: 1205.91/344.60/172.10) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 16 tps: 77.30 qps: 1543.69 (r/w/o: 1079.69/309.30/154.70) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 16 tps: 77.00 qps: 1540.10 (r/w/o: 1078.30/307.80/154.00) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 16 tps: 77.50 qps: 1554.00 (r/w/o: 1088.90/310.10/155.00) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 16 tps: 81.40 qps: 1622.20 (r/w/o: 1134.00/325.40/162.80) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 16 tps: 78.40 qps: 1570.80 (r/w/o: 1100.00/314.00/156.80) lat (ms,99%): 590.56 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 16 tps: 83.00 qps: 1660.30 (r/w/o: 1162.50/331.80/166.00) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 16 tps: 83.00 qps: 1658.60 (r/w/o: 1160.60/332.00/166.00) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 16 tps: 86.20 qps: 1724.16 (r/w/o: 1206.87/344.89/172.40) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 16 tps: 79.00 qps: 1580.03 (r/w/o: 1106.32/315.71/158.00) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 16 tps: 82.30 qps: 1647.97 (r/w/o: 1154.18/329.19/164.60) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 16 tps: 79.30 qps: 1582.72 (r/w/o: 1106.91/317.20/158.60) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 16 tps: 81.10 qps: 1624.70 (r/w/o: 1137.60/324.90/162.20) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 16 tps: 81.20 qps: 1625.30 (r/w/o: 1138.33/324.58/162.39) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 16 tps: 80.70 qps: 1612.60 (r/w/o: 1128.30/322.90/161.40) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 16 tps: 83.51 qps: 1668.22 (r/w/o: 1167.39/333.82/167.01) lat (ms,99%): 669.89 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 16 tps: 79.00 qps: 1575.79 (r/w/o: 1101.99/315.80/158.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 16 tps: 77.50 qps: 1555.10 (r/w/o: 1090.00/310.10/155.00) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 16 tps: 79.40 qps: 1589.61 (r/w/o: 1113.31/317.50/158.80) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 16 tps: 79.80 qps: 1595.59 (r/w/o: 1116.49/319.50/159.60) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 16 tps: 75.20 qps: 1506.97 (r/w/o: 1055.28/301.29/150.40) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 16 tps: 81.90 qps: 1633.63 (r/w/o: 1142.72/327.11/163.80) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 16 tps: 75.60 qps: 1510.71 (r/w/o: 1057.41/302.10/151.20) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 16 tps: 76.60 qps: 1537.31 (r/w/o: 1077.70/306.40/153.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 16 tps: 83.50 qps: 1666.49 (r/w/o: 1165.20/334.30/167.00) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 16 tps: 84.30 qps: 1687.30 (r/w/o: 1180.90/337.80/168.60) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 16 tps: 78.20 qps: 1562.80 (r/w/o: 1094.30/312.10/156.40) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 16 tps: 84.20 qps: 1681.79 (r/w/o: 1176.59/336.80/168.40) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 16 tps: 84.10 qps: 1687.20 (r/w/o: 1182.40/336.60/168.20) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 16 tps: 81.10 qps: 1618.71 (r/w/o: 1132.21/324.30/162.20) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 16 tps: 79.60 qps: 1591.59 (r/w/o: 1113.70/318.70/159.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 16 tps: 73.40 qps: 1471.59 (r/w/o: 1031.20/293.60/146.80) lat (ms,99%): 601.29 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 16 tps: 77.70 qps: 1555.21 (r/w/o: 1088.64/311.18/155.39) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 16 tps: 82.71 qps: 1650.30 (r/w/o: 1154.87/330.02/165.41) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 16 tps: 78.00 qps: 1558.01 (r/w/o: 1090.11/311.90/156.00) lat (ms,99%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 16 tps: 81.70 qps: 1635.38 (r/w/o: 1145.18/326.80/163.40) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 16 tps: 80.09 qps: 1600.85 (r/w/o: 1120.40/320.27/160.19) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 16 tps: 75.81 qps: 1516.46 (r/w/o: 1061.41/303.43/151.62) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 16 tps: 80.10 qps: 1604.91 (r/w/o: 1124.30/320.40/160.20) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 16 tps: 83.10 qps: 1654.89 (r/w/o: 1156.49/332.20/166.20) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 16 tps: 87.80 qps: 1762.61 (r/w/o: 1235.30/351.70/175.60) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 16 tps: 81.19 qps: 1624.38 (r/w/o: 1137.42/324.58/162.39) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 16 tps: 80.21 qps: 1605.21 (r/w/o: 1123.67/321.12/160.41) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 16 tps: 83.30 qps: 1663.91 (r/w/o: 1164.50/332.80/166.60) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 16 tps: 81.30 qps: 1623.60 (r/w/o: 1136.00/325.00/162.60) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 16 tps: 79.30 qps: 1586.79 (r/w/o: 1110.89/317.30/158.60) lat (ms,99%): 580.02 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 16 tps: 71.80 qps: 1433.92 (r/w/o: 1003.22/287.10/143.60) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 16 tps: 77.70 qps: 1556.68 (r/w/o: 1090.49/310.80/155.40) lat (ms,99%): 657.93 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 16 tps: 77.10 qps: 1542.42 (r/w/o: 1079.75/308.48/154.19) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 16 tps: 79.30 qps: 1589.09 (r/w/o: 1112.76/317.72/158.61) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 16 tps: 84.30 qps: 1682.61 (r/w/o: 1177.40/336.60/168.60) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 16 tps: 84.90 qps: 1702.22 (r/w/o: 1192.45/339.98/169.79) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 16 tps: 81.30 qps: 1620.46 (r/w/o: 1132.94/324.91/162.61) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 16 tps: 82.50 qps: 1651.20 (r/w/o: 1156.10/330.10/165.00) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 16 tps: 74.80 qps: 1496.70 (r/w/o: 1047.40/299.70/149.60) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 16 tps: 81.90 qps: 1638.49 (r/w/o: 1147.09/327.60/163.80) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 16 tps: 88.90 qps: 1775.71 (r/w/o: 1243.01/354.90/177.80) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 16 tps: 83.50 qps: 1668.95 (r/w/o: 1167.87/334.09/167.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 16 tps: 77.90 qps: 1560.96 (r/w/o: 1093.14/312.01/155.81) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2170070
        write:                           620020
        other:                           310010
        total:                           3100100
    transactions:                        155005 (86.09 per sec.)
    queries:                             3100100 (1721.79 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.5087s
    total number of events:              155005

Latency (ms):
         min:                                    3.77
         avg:                                  185.81
         max:                                 1677.13
         99th percentile:                      601.29
         sum:                             28802249.78

Threads fairness:
    events (avg/stddev):           9687.8125/50.05
    execution time (avg/stddev):   1800.1406/0.18



         