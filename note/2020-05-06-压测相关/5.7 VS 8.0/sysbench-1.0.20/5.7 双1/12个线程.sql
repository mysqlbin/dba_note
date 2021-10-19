


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
 
mysql -uroot -p'' sbtest < sbtest.sql &




/etc/init.d/mysql restart 

set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;

sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='' \
--mysql-db=sbtest \
--num-threads=12 \
--oltp-table-size=5000000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=1800 \
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_12_.log &

mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 1265 | Waiting on empty queue | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |    0 | starting               | show processlist                                                                                     |
|  4 | sysbench        | 192.168.1.12:42944 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest10 WHERE id=1626451                                                              |
|  5 | sysbench        | 192.168.1.12:42942 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest3 WHERE id BETWEEN 1770999 AND 1771098 ORDER BY c                                |
|  6 | sysbench        | 192.168.1.12:42943 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest8 WHERE id=3322695                                                               |
|  7 | sysbench        | 192.168.1.12:42950 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest1 WHERE id=659698                                                                |
|  8 | sysbench        | 192.168.1.12:42954 | sbtest | Query   |    0 | statistics             | SELECT DISTINCT c FROM sbtest4 WHERE id BETWEEN 4796820 AND 4796919 ORDER BY c                       |
|  9 | sysbench        | 192.168.1.12:42956 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest7 WHERE id BETWEEN 1992451 AND 1992550 ORDER BY c                                |
| 10 | sysbench        | 192.168.1.12:42952 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest9 WHERE id BETWEEN 1400952 AND 1401051 ORDER BY c                                |
| 11 | sysbench        | 192.168.1.12:42958 | sbtest | Query   |    0 | updating               | UPDATE sbtest9 SET c='5389647982-57657447763-68129954054-08874011664-95899960720-78331852966-408422' |
| 12 | sysbench        | 192.168.1.12:42960 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest7 WHERE id=4633542                                                               |
| 13 | sysbench        | 192.168.1.12:42964 | sbtest | Query   |    0 | updating               | UPDATE sbtest7 SET k=k+1 WHERE id=598382                                                             |
| 14 | sysbench        | 192.168.1.12:42966 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest3 WHERE id BETWEEN 4801537 AND 4801636 ORDER BY c                                |
| 15 | sysbench        | 192.168.1.12:42962 | sbtest | Query   |    0 | updating               | DELETE FROM sbtest1 WHERE id=4099039                                                                 |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
14 rows in set (0.00 sec)


[coding001@voice ~]$ iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.39    0.00    0.63    0.07    0.00   98.92

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               3.37        51.19        78.86  414866886  639165388

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          17.30    0.00    9.92   68.45    0.00    4.33

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1509.00     49092.00     11276.00      49092      11276

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.65    0.00    9.85   73.23    0.00    2.27

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1468.00     49196.00      8132.00      49196       8132

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.07    0.00    9.72   75.45    0.00    0.77

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1105.94     48728.71      5132.67      49216       5184

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          15.23    0.00    9.90   72.08    0.00    2.79

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1228.00     49144.00      5364.00      49144       5364





[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    0.74    2.63     0.05     0.08    77.26     0.03    7.83   25.57    2.85   0.60   0.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  689.00  381.00    48.05     5.08   101.70    32.32   29.01   44.57    0.88   0.94 100.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  762.00  585.00    48.06     5.04    80.74    25.44   19.66   34.10    0.86   0.74 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  822.00  839.00    47.78    11.15    72.66    22.14   11.90   23.26    0.78   0.60  99.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  732.00  462.00    48.19     5.92    92.81    27.82   23.58   37.95    0.81   0.84  99.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  858.00  572.00    47.91     8.29    80.50    25.21   17.41   28.44    0.85   0.70 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  737.00  544.00    48.05     7.13    88.21    23.95   20.31   34.68    0.85   0.78 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  731.00  409.00    47.86     5.18    95.29    29.38   24.41   37.56    0.91   0.87  99.60


[coding001@voice ~]$ top
top - 10:20:46 up 93 days, 19:19,  4 users,  load average: 13.66, 13.30, 9.91
Tasks: 120 total,   1 running, 119 sleeping,   0 stopped,   0 zombie
%Cpu0  : 14.5 us,  7.2 sy,  0.0 ni,  2.4 id, 73.8 wa,  0.0 hi,  2.1 si,  0.0 st
%Cpu1  : 13.8 us,  7.1 sy,  0.0 ni,  0.0 id, 77.8 wa,  0.0 hi,  1.3 si,  0.0 st
%Cpu2  : 13.8 us,  6.7 sy,  0.0 ni,  3.0 id, 75.8 wa,  0.0 hi,  0.7 si,  0.0 st
%Cpu3  : 13.0 us,  7.0 sy,  0.0 ni,  5.7 id, 73.3 wa,  0.0 hi,  1.0 si,  0.0 st
KiB Mem : 16266300 total,   173656 free,  9836584 used,  6256060 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5381660 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
28483 mysql     20   0   11.3g   8.8g   4552 S  76.1 56.9  18:12.51 mysqld                                                                                                                                                                    
28617 coding0+  20   0  891892   6628   1372 S  13.0  0.0   2:49.41 sysbench    




---
LOG
---
Log sequence number 142002092261
Log flushed up to   142002092261
Pages flushed up to 141698237250
Last checkpoint at  141698097215
0 pending log flushes, 0 pending chkp writes
142140 log i/o's done, 78.85 log i/o's/second

select 142002092261-141698097215 = 303995046 byte = 290MB
select 142002092261-141698237250 = 303855011 byte = 290MB



[coding001@voice ~]$ tail -f sysbench_oltpX_12_.log
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 12 tps: 128.25 qps: 2579.16 (r/w/o: 1807.74/513.71/257.71) lat (ms,99%): 580.02 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 12 tps: 45.30 qps: 906.63 (r/w/o: 635.52/180.51/90.60) lat (ms,99%): 634.66 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 12 tps: 40.50 qps: 808.87 (r/w/o: 565.48/162.39/81.00) lat (ms,99%): 733.00 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 12 tps: 36.50 qps: 728.32 (r/w/o: 509.72/145.60/73.00) lat (ms,99%): 802.05 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 12 tps: 42.19 qps: 844.20 (r/w/o: 590.83/168.98/84.39) lat (ms,99%): 802.05 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 12 tps: 43.61 qps: 868.51 (r/w/o: 607.08/174.22/87.21) lat (ms,99%): 733.00 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 12 tps: 40.60 qps: 820.39 (r/w/o: 575.49/163.70/81.20) lat (ms,99%): 846.57 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 12 tps: 53.60 qps: 1066.53 (r/w/o: 746.25/213.09/107.19) lat (ms,99%): 682.06 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 12 tps: 52.50 qps: 1049.78 (r/w/o: 734.66/210.12/105.01) lat (ms,99%): 694.45 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 12 tps: 59.60 qps: 1194.81 (r/w/o: 837.01/238.60/119.20) lat (ms,99%): 612.21 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 12 tps: 55.49 qps: 1107.29 (r/w/o: 774.42/221.88/110.99) lat (ms,99%): 646.19 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 12 tps: 63.91 qps: 1279.61 (r/w/o: 896.08/255.72/127.81) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 12 tps: 66.10 qps: 1320.50 (r/w/o: 924.00/264.30/132.20) lat (ms,99%): 559.50 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 12 tps: 78.90 qps: 1580.80 (r/w/o: 1107.00/316.00/157.80) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 12 tps: 78.20 qps: 1560.69 (r/w/o: 1091.89/312.40/156.40) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 12 tps: 87.60 qps: 1751.10 (r/w/o: 1225.40/350.50/175.20) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 12 tps: 90.90 qps: 1819.46 (r/w/o: 1273.47/364.19/181.80) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 12 tps: 81.70 qps: 1633.31 (r/w/o: 1144.01/325.90/163.40) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 12 tps: 76.60 qps: 1532.34 (r/w/o: 1072.53/306.61/153.20) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 12 tps: 75.70 qps: 1512.90 (r/w/o: 1058.70/302.80/151.40) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 12 tps: 75.90 qps: 1519.30 (r/w/o: 1063.70/303.80/151.80) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 12 tps: 62.30 qps: 1247.31 (r/w/o: 873.70/249.00/124.60) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 12 tps: 58.50 qps: 1168.24 (r/w/o: 817.46/233.79/116.99) lat (ms,99%): 623.33 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 12 tps: 57.40 qps: 1149.84 (r/w/o: 805.23/229.81/114.80) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 12 tps: 59.40 qps: 1189.53 (r/w/o: 832.65/238.09/118.79) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 12 tps: 74.81 qps: 1494.31 (r/w/o: 1045.97/298.72/149.61) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 12 tps: 78.50 qps: 1566.87 (r/w/o: 1096.08/313.79/157.00) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 12 tps: 71.10 qps: 1425.81 (r/w/o: 998.51/285.10/142.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 12 tps: 77.50 qps: 1547.41 (r/w/o: 1082.70/309.70/155.00) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 12 tps: 94.20 qps: 1885.99 (r/w/o: 1320.39/377.20/188.40) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 12 tps: 103.20 qps: 2061.99 (r/w/o: 1442.89/412.70/206.40) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 12 tps: 108.90 qps: 2179.67 (r/w/o: 1526.88/434.99/217.80) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 12 tps: 115.90 qps: 2319.23 (r/w/o: 1623.42/464.01/231.80) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 12 tps: 101.60 qps: 2035.94 (r/w/o: 1425.33/407.41/203.20) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 12 tps: 110.30 qps: 2199.28 (r/w/o: 1538.89/439.80/220.60) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 12 tps: 116.20 qps: 2326.30 (r/w/o: 1628.60/465.30/232.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 12 tps: 109.80 qps: 2195.76 (r/w/o: 1537.37/438.79/219.60) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 12 tps: 120.80 qps: 2411.56 (r/w/o: 1686.84/483.11/241.61) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 12 tps: 119.80 qps: 2403.86 (r/w/o: 1683.67/480.59/239.60) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 12 tps: 122.40 qps: 2445.32 (r/w/o: 1712.32/488.20/244.80) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 12 tps: 121.40 qps: 2427.38 (r/w/o: 1697.88/486.70/242.80) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 12 tps: 132.40 qps: 2647.28 (r/w/o: 1853.79/528.70/264.80) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 12 tps: 128.30 qps: 2564.78 (r/w/o: 1795.09/513.10/256.60) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 12 tps: 132.20 qps: 2649.12 (r/w/o: 1853.72/531.00/264.40) lat (ms,99%): 240.02 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 12 tps: 125.40 qps: 2507.93 (r/w/o: 1756.72/500.41/250.80) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 12 tps: 126.50 qps: 2530.88 (r/w/o: 1771.49/506.40/253.00) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 12 tps: 135.50 qps: 2705.82 (r/w/o: 1894.41/540.40/271.00) lat (ms,99%): 231.53 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 12 tps: 120.79 qps: 2413.12 (r/w/o: 1688.37/483.16/241.58) lat (ms,99%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 12 tps: 108.30 qps: 2168.78 (r/w/o: 1518.58/433.60/216.60) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 12 tps: 114.41 qps: 2285.31 (r/w/o: 1599.15/457.34/228.82) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 12 tps: 109.90 qps: 2199.64 (r/w/o: 1540.26/439.69/219.69) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 12 tps: 115.50 qps: 2309.64 (r/w/o: 1616.53/462.01/231.10) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 12 tps: 118.60 qps: 2368.34 (r/w/o: 1656.83/474.31/237.20) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 12 tps: 112.70 qps: 2258.86 (r/w/o: 1582.77/450.69/225.40) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 12 tps: 114.20 qps: 2285.01 (r/w/o: 1599.61/457.00/228.40) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 12 tps: 107.90 qps: 2156.59 (r/w/o: 1509.20/431.60/215.80) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 12 tps: 112.60 qps: 2249.31 (r/w/o: 1573.71/450.40/225.20) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 12 tps: 116.40 qps: 2330.81 (r/w/o: 1632.41/465.60/232.80) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 12 tps: 121.19 qps: 2422.79 (r/w/o: 1695.65/484.76/242.38) lat (ms,99%): 253.35 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 12 tps: 116.11 qps: 2322.77 (r/w/o: 1626.32/464.23/232.22) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 12 tps: 112.90 qps: 2256.81 (r/w/o: 1579.31/451.80/225.70) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 12 tps: 102.10 qps: 2042.62 (r/w/o: 1430.12/408.20/204.30) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 12 tps: 108.90 qps: 2179.96 (r/w/o: 1526.07/436.09/217.80) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 12 tps: 112.80 qps: 2255.04 (r/w/o: 1578.33/451.11/225.60) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 12 tps: 108.60 qps: 2175.01 (r/w/o: 1523.01/434.80/217.20) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 12 tps: 100.20 qps: 1999.99 (r/w/o: 1399.39/400.20/200.40) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 12 tps: 105.40 qps: 2106.38 (r/w/o: 1474.09/421.50/210.80) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 12 tps: 103.70 qps: 2075.90 (r/w/o: 1453.50/415.00/207.40) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 12 tps: 104.50 qps: 2091.62 (r/w/o: 1464.91/417.70/209.00) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 12 tps: 101.59 qps: 2030.66 (r/w/o: 1420.50/406.97/203.19) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 12 tps: 103.01 qps: 2062.52 (r/w/o: 1444.08/412.42/206.01) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 12 tps: 98.50 qps: 1965.72 (r/w/o: 1375.71/393.00/197.00) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 12 tps: 91.40 qps: 1829.40 (r/w/o: 1280.90/365.70/182.80) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 12 tps: 108.10 qps: 2163.14 (r/w/o: 1514.56/432.39/216.19) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 12 tps: 96.20 qps: 1920.53 (r/w/o: 1343.42/384.71/192.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 12 tps: 103.90 qps: 2080.53 (r/w/o: 1456.72/416.01/207.80) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 12 tps: 99.60 qps: 1991.81 (r/w/o: 1393.71/398.90/199.20) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 12 tps: 113.90 qps: 2276.77 (r/w/o: 1594.28/454.69/227.80) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 12 tps: 98.90 qps: 1975.82 (r/w/o: 1382.41/395.60/197.80) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 12 tps: 104.30 qps: 2090.98 (r/w/o: 1465.19/417.20/208.60) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 12 tps: 105.50 qps: 2108.59 (r/w/o: 1474.49/423.30/210.80) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 12 tps: 104.00 qps: 2080.33 (r/w/o: 1457.42/414.71/208.20) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 12 tps: 91.00 qps: 1820.29 (r/w/o: 1274.29/364.00/182.00) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 12 tps: 104.00 qps: 2082.88 (r/w/o: 1457.09/417.80/208.00) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 12 tps: 106.50 qps: 2128.39 (r/w/o: 1490.29/425.10/213.00) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 12 tps: 100.70 qps: 2014.33 (r/w/o: 1410.62/402.31/201.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 12 tps: 96.20 qps: 1925.18 (r/w/o: 1347.49/385.30/192.40) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 12 tps: 91.10 qps: 1822.19 (r/w/o: 1275.19/364.80/182.20) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 12 tps: 98.50 qps: 1965.64 (r/w/o: 1375.93/392.71/197.00) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 12 tps: 91.00 qps: 1821.09 (r/w/o: 1274.89/364.20/182.00) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 12 tps: 91.60 qps: 1832.41 (r/w/o: 1281.81/367.40/183.20) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 12 tps: 91.80 qps: 1835.49 (r/w/o: 1285.30/366.60/183.60) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 12 tps: 89.80 qps: 1795.70 (r/w/o: 1257.20/358.90/179.60) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 12 tps: 89.80 qps: 1796.50 (r/w/o: 1257.80/359.10/179.60) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 12 tps: 92.80 qps: 1856.40 (r/w/o: 1299.50/371.30/185.60) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 12 tps: 88.20 qps: 1765.00 (r/w/o: 1235.90/352.70/176.40) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 12 tps: 89.99 qps: 1797.17 (r/w/o: 1257.21/359.97/179.99) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 12 tps: 92.90 qps: 1857.29 (r/w/o: 1299.66/371.82/185.81) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 12 tps: 93.50 qps: 1875.61 (r/w/o: 1313.71/374.90/187.00) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 12 tps: 94.60 qps: 1887.34 (r/w/o: 1320.73/377.41/189.20) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 12 tps: 91.40 qps: 1827.68 (r/w/o: 1279.49/365.40/182.80) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 12 tps: 99.10 qps: 1984.92 (r/w/o: 1390.32/396.40/198.20) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 12 tps: 94.10 qps: 1880.78 (r/w/o: 1316.29/376.30/188.20) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 12 tps: 85.90 qps: 1718.07 (r/w/o: 1202.58/343.69/171.80) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 12 tps: 88.20 qps: 1760.44 (r/w/o: 1231.23/352.81/176.40) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 12 tps: 88.00 qps: 1764.70 (r/w/o: 1236.40/352.30/176.00) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 12 tps: 95.30 qps: 1903.16 (r/w/o: 1331.77/380.79/190.60) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 12 tps: 99.60 qps: 1993.94 (r/w/o: 1395.93/398.81/199.20) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 12 tps: 98.50 qps: 1968.21 (r/w/o: 1377.61/393.60/197.00) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 12 tps: 92.10 qps: 1840.95 (r/w/o: 1288.27/368.49/184.20) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 12 tps: 88.60 qps: 1773.63 (r/w/o: 1242.12/354.31/177.20) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 12 tps: 91.50 qps: 1830.31 (r/w/o: 1280.91/366.40/183.00) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 12 tps: 89.20 qps: 1782.88 (r/w/o: 1248.09/356.40/178.40) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 12 tps: 87.40 qps: 1752.42 (r/w/o: 1226.02/351.60/174.80) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 12 tps: 93.40 qps: 1863.20 (r/w/o: 1304.70/371.70/186.80) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 12 tps: 87.90 qps: 1758.58 (r/w/o: 1231.28/351.50/175.80) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 12 tps: 88.20 qps: 1770.44 (r/w/o: 1239.92/354.11/176.40) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 12 tps: 93.70 qps: 1866.29 (r/w/o: 1305.39/373.50/187.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 12 tps: 87.20 qps: 1744.70 (r/w/o: 1221.00/349.30/174.40) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 12 tps: 88.20 qps: 1766.39 (r/w/o: 1237.39/352.60/176.40) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 12 tps: 92.50 qps: 1849.01 (r/w/o: 1294.31/369.70/185.00) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 12 tps: 85.90 qps: 1721.56 (r/w/o: 1204.17/345.59/171.80) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 12 tps: 97.70 qps: 1953.41 (r/w/o: 1368.71/389.30/195.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 12 tps: 85.70 qps: 1709.82 (r/w/o: 1196.12/342.30/171.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 12 tps: 84.30 qps: 1687.10 (r/w/o: 1181.10/337.40/168.60) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 12 tps: 83.20 qps: 1663.19 (r/w/o: 1163.99/332.80/166.40) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 12 tps: 89.00 qps: 1782.97 (r/w/o: 1248.88/356.09/178.00) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 12 tps: 89.60 qps: 1793.41 (r/w/o: 1254.10/360.10/179.20) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 12 tps: 87.10 qps: 1740.32 (r/w/o: 1218.91/347.20/174.20) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 12 tps: 88.90 qps: 1775.27 (r/w/o: 1242.58/354.89/177.80) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 12 tps: 81.10 qps: 1620.25 (r/w/o: 1133.63/324.41/162.20) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 12 tps: 85.80 qps: 1718.08 (r/w/o: 1203.19/343.30/171.60) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 12 tps: 96.30 qps: 1925.62 (r/w/o: 1347.81/385.20/192.60) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 12 tps: 94.00 qps: 1876.70 (r/w/o: 1312.70/376.00/188.00) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 12 tps: 85.60 qps: 1716.99 (r/w/o: 1203.39/342.40/171.20) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 12 tps: 86.90 qps: 1737.70 (r/w/o: 1216.30/347.60/173.80) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 12 tps: 83.50 qps: 1669.70 (r/w/o: 1168.60/334.10/167.00) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 12 tps: 82.70 qps: 1651.58 (r/w/o: 1155.49/330.70/165.40) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 12 tps: 86.60 qps: 1735.61 (r/w/o: 1215.81/346.60/173.20) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 12 tps: 93.30 qps: 1865.90 (r/w/o: 1306.00/373.30/186.60) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 12 tps: 82.30 qps: 1643.58 (r/w/o: 1150.29/328.70/164.60) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 12 tps: 85.10 qps: 1704.37 (r/w/o: 1193.08/341.09/170.20) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 12 tps: 95.70 qps: 1915.94 (r/w/o: 1341.73/382.81/191.40) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 12 tps: 87.30 qps: 1744.11 (r/w/o: 1220.81/348.70/174.60) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 12 tps: 90.60 qps: 1811.12 (r/w/o: 1267.51/362.40/181.20) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 12 tps: 87.70 qps: 1754.49 (r/w/o: 1228.30/350.80/175.40) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 12 tps: 97.80 qps: 1956.11 (r/w/o: 1368.70/391.80/195.60) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 12 tps: 86.40 qps: 1729.65 (r/w/o: 1211.77/345.09/172.80) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 12 tps: 93.80 qps: 1876.40 (r/w/o: 1313.60/375.20/187.60) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 12 tps: 88.59 qps: 1766.75 (r/w/o: 1235.30/354.27/177.18) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 12 tps: 81.81 qps: 1637.98 (r/w/o: 1147.23/327.14/163.62) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 12 tps: 82.80 qps: 1658.39 (r/w/o: 1161.39/331.40/165.60) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 12 tps: 83.00 qps: 1657.38 (r/w/o: 1159.69/331.70/166.00) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 12 tps: 89.30 qps: 1786.30 (r/w/o: 1249.40/358.30/178.60) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 12 tps: 86.30 qps: 1727.11 (r/w/o: 1209.91/344.60/172.60) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 12 tps: 92.90 qps: 1858.92 (r/w/o: 1301.02/372.10/185.80) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 12 tps: 87.70 qps: 1750.80 (r/w/o: 1225.50/349.90/175.40) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 12 tps: 89.30 qps: 1788.29 (r/w/o: 1252.50/357.20/178.60) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 12 tps: 85.10 qps: 1700.85 (r/w/o: 1189.77/340.89/170.20) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 12 tps: 87.90 qps: 1760.35 (r/w/o: 1233.23/351.31/175.80) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 12 tps: 82.29 qps: 1648.55 (r/w/o: 1153.10/330.87/164.59) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 12 tps: 88.61 qps: 1766.66 (r/w/o: 1236.61/352.83/177.22) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 12 tps: 88.00 qps: 1758.48 (r/w/o: 1230.79/351.70/176.00) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 12 tps: 90.80 qps: 1817.63 (r/w/o: 1272.82/363.21/181.60) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 12 tps: 79.50 qps: 1589.67 (r/w/o: 1112.78/317.89/159.00) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 12 tps: 85.40 qps: 1710.93 (r/w/o: 1198.42/341.71/170.80) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 12 tps: 81.90 qps: 1637.97 (r/w/o: 1145.48/328.69/163.80) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 12 tps: 88.60 qps: 1770.82 (r/w/o: 1240.01/353.60/177.20) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 12 tps: 90.20 qps: 1803.30 (r/w/o: 1262.50/360.40/180.40) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 12 tps: 91.60 qps: 1830.20 (r/w/o: 1280.40/366.60/183.20) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 12 tps: 83.49 qps: 1670.08 (r/w/o: 1169.21/333.88/166.99) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 12 tps: 85.41 qps: 1709.12 (r/w/o: 1196.59/341.72/170.81) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 12 tps: 88.60 qps: 1774.01 (r/w/o: 1242.61/354.20/177.20) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 12 tps: 88.60 qps: 1771.40 (r/w/o: 1239.50/354.70/177.20) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 12 tps: 92.19 qps: 1845.36 (r/w/o: 1292.10/368.87/184.39) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 12 tps: 86.31 qps: 1722.23 (r/w/o: 1204.69/344.93/172.61) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 12 tps: 86.70 qps: 1736.70 (r/w/o: 1216.10/347.20/173.40) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 12 tps: 85.60 qps: 1713.19 (r/w/o: 1199.59/342.40/171.20) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 12 tps: 82.40 qps: 1644.98 (r/w/o: 1151.09/329.10/164.80) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 12 tps: 92.30 qps: 1846.23 (r/w/o: 1292.32/369.31/184.60) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2323566
        write:                           663876
        other:                           331938
        total:                           3319380
    transactions:                        165969 (92.18 per sec.)
    queries:                             3319380 (1843.55 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.5364s
    total number of events:              165969

Latency (ms):
         min:                                    7.17
         avg:                                  130.16
         max:                                 1115.85
         99th percentile:                      434.83
         sum:                             21602860.11

Threads fairness:
    events (avg/stddev):           13830.7500/48.85
    execution time (avg/stddev):   1800.2383/0.15







