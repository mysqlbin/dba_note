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

sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='' \
--mysql-db=sbtest \
--num-threads=5 \
--oltp-table-size=5000000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=1800 \
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_5_not05_.log &



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 2123 | Waiting on empty queue | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |    0 | starting               | show processlist                                                                                     |
| 26 | sysbench        | 192.168.1.12:44608 | sbtest | Query   |    0 | statistics             | SELECT SUM(K) FROM sbtest8 WHERE id BETWEEN 213849 AND 213948                                        |
| 27 | sysbench        | 192.168.1.12:44606 | sbtest | Query   |    0 | updating               | DELETE FROM sbtest4 WHERE id=960422                                                                  |
| 28 | sysbench        | 192.168.1.12:44599 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest5 WHERE id=2763134                                                               |
| 29 | sysbench        | 192.168.1.12:44600 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest5 WHERE id=3712763                                                               |
| 30 | sysbench        | 192.168.1.12:44598 | sbtest | Query   |    0 | updating               | UPDATE sbtest2 SET c='2362188739-35869833208-55079547235-14715930661-90708883008-91727386006-045315' |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
7 rows in set (0.00 sec)




[coding001@voice mysql]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    1.22    2.89     0.08     0.11    93.59     0.04    9.21   24.19    2.87   0.64   0.26

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  860.00  196.00    48.15     7.87   108.65    12.86   12.14   14.47    1.89   0.92  97.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  864.00  262.00    48.02    10.62   106.64    12.68   11.22   13.97    2.18   0.87  97.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  778.00  378.00    47.95    14.36   110.39    16.19   14.08   20.10    1.70   0.85  98.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  931.00  264.00    48.12     9.38    98.54    11.39    9.38   11.70    1.20   0.80  95.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  845.00  202.00    47.99     5.97   105.56    12.56   12.16   14.82    1.05   0.92  96.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  928.00  232.00    48.05     7.36    97.81    11.08    9.33   11.39    1.08   0.84  97.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  841.00  180.00    47.98     7.22   110.74    15.83   15.74   18.81    1.42   0.95  97.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  882.00  248.00    48.03     8.28   102.05    15.01   11.22   14.03    1.25   0.84  95.20



[coding001@voice mysql]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.41    0.00    0.63    0.10    0.00   98.85

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               4.11        84.46       108.04  685909154  877407760

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          19.44    0.00   10.10   52.27    0.00   18.18

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1230.00     49248.00      7224.00      49248       7224

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.75    0.00    8.75   57.75    0.00   16.75

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1138.00     49028.00     10388.00      49028      10388

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          17.05    0.00   10.18   54.96    0.00   17.81

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1178.00     49216.00      6484.00      49216       6484

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          17.93    0.00   10.35   57.83    0.00   13.89

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1173.00     49140.00      7440.00      49140       7440

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          19.24    0.00   10.13   56.96    0.00   13.67

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1127.00     49232.00      7300.00      49232       7300

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          13.16    0.00    7.59   61.52    0.00   17.72

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             995.00     49120.00      7444.00      49120       7444



[coding001@voice mysql]$ top
top - 14:51:53 up 93 days, 23:50,  4 users,  load average: 5.63, 4.91, 2.97
Tasks: 122 total,   1 running, 121 sleeping,   0 stopped,   0 zombie
%Cpu0  : 16.6 us,  5.7 sy,  0.0 ni,  7.8 id, 67.9 wa,  0.0 hi,  2.0 si,  0.0 st
%Cpu1  : 13.9 us,  6.4 sy,  0.0 ni, 15.9 id, 63.2 wa,  0.0 hi,  0.7 si,  0.0 st
%Cpu2  : 12.8 us,  5.7 sy,  0.0 ni, 16.8 id, 63.6 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu3  : 12.8 us,  6.4 sy,  0.0 ni, 20.9 id, 58.8 wa,  0.0 hi,  1.0 si,  0.0 st
KiB Mem : 16266300 total,   163460 free,  9840328 used,  6262512 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5371228 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
19543 mysql     20   0   11.0g   8.8g   4384 S  73.4 57.0  23:01.77 mysqld                                                                                                                                                                    
21913 coding0+  20   0  429528   4660   1332 S  13.0  0.0   1:40.95 sysbench                                                                                                                                                                  
12433 coding0+  20   0  174352  27012    696 S   3.0  0.2 204:46.39 skynet    



---
LOG
---
Log sequence number 198831319262
Log flushed up to   198831225468
Pages flushed up to 198577214686
Last checkpoint at  198577214686
0 pending log flushes, 0 pending chkp writes
110058 log i/o's done, 86.80 log i/o's/second



[coding001@voice ~]$ tail -f sysbench_oltpX_5_not05_.log

Initializing worker threads...

Threads started!

[ 10s ] thds: 5 tps: 251.95 qps: 5042.43 (r/w/o: 3530.25/1007.79/504.39) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 5 tps: 83.90 qps: 1680.01 (r/w/o: 1176.61/335.60/167.80) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 5 tps: 87.80 qps: 1754.58 (r/w/o: 1227.69/351.30/175.60) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 5 tps: 112.40 qps: 2247.92 (r/w/o: 1573.62/449.50/224.80) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 5 tps: 123.60 qps: 2473.29 (r/w/o: 1731.49/494.60/247.20) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00




[ 60s ] thds: 5 tps: 133.60 qps: 2672.92 (r/w/o: 1871.51/534.20/267.20) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 5 tps: 119.00 qps: 2379.60 (r/w/o: 1665.30/476.30/238.00) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 5 tps: 126.10 qps: 2520.81 (r/w/o: 1764.51/504.10/252.20) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 5 tps: 115.40 qps: 2305.59 (r/w/o: 1613.19/461.60/230.80) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 5 tps: 108.40 qps: 2171.79 (r/w/o: 1521.39/433.60/216.80) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 5 tps: 98.10 qps: 1960.51 (r/w/o: 1371.80/392.50/196.20) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 5 tps: 102.30 qps: 2047.19 (r/w/o: 1433.49/409.10/204.60) lat (ms,99%): 253.35 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 5 tps: 109.70 qps: 2193.74 (r/w/o: 1535.36/438.99/219.39) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 5 tps: 112.80 qps: 2255.57 (r/w/o: 1578.95/451.01/225.61) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 5 tps: 123.60 qps: 2472.31 (r/w/o: 1730.41/494.70/247.20) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 5 tps: 115.70 qps: 2314.19 (r/w/o: 1620.29/462.50/231.40) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 5 tps: 121.20 qps: 2423.13 (r/w/o: 1695.92/484.81/242.40) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 5 tps: 132.60 qps: 2652.38 (r/w/o: 1856.79/530.40/265.20) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 5 tps: 132.60 qps: 2653.31 (r/w/o: 1857.30/530.80/265.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 5 tps: 129.10 qps: 2578.47 (r/w/o: 1804.38/515.99/258.10) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 5 tps: 141.80 qps: 2836.60 (r/w/o: 1985.70/567.20/283.70) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 5 tps: 145.70 qps: 2913.84 (r/w/o: 2039.63/582.81/291.40) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 5 tps: 154.38 qps: 3089.23 (r/w/o: 2162.67/617.81/308.75) lat (ms,99%): 147.61 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 5 tps: 137.31 qps: 2745.52 (r/w/o: 1921.95/548.94/274.62) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 5 tps: 150.41 qps: 3009.39 (r/w/o: 2106.93/601.64/300.82) lat (ms,99%): 150.29 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 5 tps: 154.89 qps: 3095.28 (r/w/o: 2165.95/619.56/309.78) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 5 tps: 144.81 qps: 2899.42 (r/w/o: 2030.55/579.24/289.62) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 5 tps: 130.40 qps: 2606.80 (r/w/o: 1824.40/521.60/260.80) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 5 tps: 136.20 qps: 2724.49 (r/w/o: 1906.99/545.10/272.40) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 5 tps: 121.90 qps: 2436.71 (r/w/o: 1705.60/487.30/243.80) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 5 tps: 133.10 qps: 2661.91 (r/w/o: 1863.31/532.40/266.20) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 5 tps: 137.40 qps: 2748.76 (r/w/o: 1924.37/549.59/274.80) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 5 tps: 123.10 qps: 2463.25 (r/w/o: 1724.44/492.61/246.21) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 5 tps: 123.80 qps: 2475.49 (r/w/o: 1732.89/495.00/247.60) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 5 tps: 127.80 qps: 2554.58 (r/w/o: 1787.89/511.20/255.50) lat (ms,99%): 153.02 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 5 tps: 129.30 qps: 2586.10 (r/w/o: 1810.20/517.20/258.70) lat (ms,99%): 142.39 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 5 tps: 128.90 qps: 2578.14 (r/w/o: 1804.36/515.99/257.79) lat (ms,99%): 144.97 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 5 tps: 115.20 qps: 2304.36 (r/w/o: 1613.54/460.41/230.41) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 5 tps: 111.40 qps: 2230.49 (r/w/o: 1561.80/445.90/222.80) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 5 tps: 112.00 qps: 2237.01 (r/w/o: 1565.21/447.80/224.00) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 5 tps: 108.40 qps: 2169.52 (r/w/o: 1518.95/433.88/216.69) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 5 tps: 113.10 qps: 2262.58 (r/w/o: 1583.96/452.32/226.31) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 5 tps: 115.00 qps: 2298.29 (r/w/o: 1608.59/459.70/230.00) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 5 tps: 109.00 qps: 2178.80 (r/w/o: 1524.90/436.00/217.90) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 5 tps: 109.30 qps: 2188.01 (r/w/o: 1532.11/437.20/218.70) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 5 tps: 106.20 qps: 2125.16 (r/w/o: 1487.77/424.99/212.40) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 5 tps: 100.00 qps: 1998.62 (r/w/o: 1398.72/399.90/200.00) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 5 tps: 100.30 qps: 2005.80 (r/w/o: 1404.10/401.10/200.60) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 5 tps: 102.50 qps: 2049.69 (r/w/o: 1434.69/410.00/205.00) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 5 tps: 110.00 qps: 2199.91 (r/w/o: 1539.70/440.20/220.00) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 5 tps: 108.80 qps: 2174.89 (r/w/o: 1522.29/435.00/217.60) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 5 tps: 96.00 qps: 1921.21 (r/w/o: 1345.11/384.10/192.00) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 5 tps: 100.20 qps: 2004.81 (r/w/o: 1403.70/400.70/200.40) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 5 tps: 101.89 qps: 2037.19 (r/w/o: 1425.42/407.98/203.79) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 5 tps: 106.30 qps: 2126.40 (r/w/o: 1488.97/424.82/212.61) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 5 tps: 99.79 qps: 1995.87 (r/w/o: 1396.81/399.47/199.59) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 5 tps: 104.71 qps: 2094.45 (r/w/o: 1466.50/418.53/209.41) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 5 tps: 97.20 qps: 1941.88 (r/w/o: 1358.69/388.80/194.40) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 5 tps: 90.80 qps: 1815.80 (r/w/o: 1271.00/363.20/181.60) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 5 tps: 102.10 qps: 2043.11 (r/w/o: 1430.51/408.40/204.20) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 5 tps: 95.80 qps: 1914.81 (r/w/o: 1339.91/383.30/191.60) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 5 tps: 85.00 qps: 1700.60 (r/w/o: 1190.70/339.90/170.00) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 5 tps: 96.80 qps: 1934.70 (r/w/o: 1353.90/387.20/193.60) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 5 tps: 91.60 qps: 1834.00 (r/w/o: 1284.40/366.40/183.20) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 5 tps: 92.80 qps: 1856.07 (r/w/o: 1299.28/371.19/185.60) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 5 tps: 97.60 qps: 1951.82 (r/w/o: 1366.21/390.40/195.20) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 5 tps: 91.30 qps: 1827.71 (r/w/o: 1279.90/365.20/182.60) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 5 tps: 93.80 qps: 1875.90 (r/w/o: 1313.00/375.30/187.60) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 5 tps: 94.60 qps: 1892.00 (r/w/o: 1324.50/378.30/189.20) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 5 tps: 92.70 qps: 1853.20 (r/w/o: 1297.00/370.80/185.40) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 5 tps: 92.40 qps: 1849.51 (r/w/o: 1295.01/369.70/184.80) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 5 tps: 96.40 qps: 1927.48 (r/w/o: 1349.09/385.60/192.80) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 5 tps: 96.40 qps: 1927.59 (r/w/o: 1349.00/385.80/192.80) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 5 tps: 84.60 qps: 1690.00 (r/w/o: 1182.70/338.10/169.20) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 5 tps: 91.20 qps: 1825.51 (r/w/o: 1278.21/364.90/182.40) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 5 tps: 93.30 qps: 1866.90 (r/w/o: 1306.90/373.40/186.60) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 5 tps: 86.80 qps: 1735.77 (r/w/o: 1215.18/346.99/173.60) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 5 tps: 93.20 qps: 1863.73 (r/w/o: 1304.52/372.81/186.40) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 5 tps: 99.10 qps: 1981.19 (r/w/o: 1386.69/396.30/198.20) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 5 tps: 87.40 qps: 1748.91 (r/w/o: 1224.51/349.60/174.80) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 5 tps: 89.80 qps: 1794.69 (r/w/o: 1255.60/359.50/179.60) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 5 tps: 90.70 qps: 1815.61 (r/w/o: 1271.70/362.50/181.40) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 5 tps: 96.60 qps: 1932.88 (r/w/o: 1353.19/386.50/193.20) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 5 tps: 92.80 qps: 1853.20 (r/w/o: 1296.50/371.10/185.60) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 5 tps: 84.80 qps: 1697.40 (r/w/o: 1188.60/339.20/169.60) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 5 tps: 86.90 qps: 1736.28 (r/w/o: 1214.78/347.70/173.80) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 5 tps: 96.20 qps: 1924.43 (r/w/o: 1347.32/384.71/192.40) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 5 tps: 84.80 qps: 1695.60 (r/w/o: 1186.80/339.20/169.60) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 5 tps: 85.80 qps: 1718.39 (r/w/o: 1203.49/343.30/171.60) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 5 tps: 87.70 qps: 1752.68 (r/w/o: 1226.38/350.90/175.40) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 5 tps: 83.10 qps: 1663.23 (r/w/o: 1164.82/332.21/166.20) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 5 tps: 86.30 qps: 1726.50 (r/w/o: 1208.40/345.50/172.60) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 5 tps: 91.40 qps: 1826.09 (r/w/o: 1277.79/365.50/182.80) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 5 tps: 85.59 qps: 1710.77 (r/w/o: 1197.41/342.17/171.19) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 5 tps: 88.01 qps: 1759.73 (r/w/o: 1231.69/352.03/176.01) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 5 tps: 94.30 qps: 1888.40 (r/w/o: 1322.40/377.40/188.60) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 5 tps: 89.70 qps: 1792.41 (r/w/o: 1254.44/358.58/179.39) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 5 tps: 81.80 qps: 1637.60 (r/w/o: 1146.80/327.20/163.60) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 5 tps: 90.60 qps: 1810.58 (r/w/o: 1266.96/362.42/181.21) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 5 tps: 83.40 qps: 1670.39 (r/w/o: 1169.79/333.80/166.80) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 5 tps: 90.90 qps: 1814.90 (r/w/o: 1269.70/363.40/181.80) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 5 tps: 88.30 qps: 1767.91 (r/w/o: 1238.01/353.30/176.60) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 5 tps: 89.70 qps: 1792.29 (r/w/o: 1254.09/358.80/179.40) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 5 tps: 93.30 qps: 1865.59 (r/w/o: 1305.90/373.10/186.60) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 5 tps: 84.80 qps: 1696.91 (r/w/o: 1188.21/339.30/169.40) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 5 tps: 83.40 qps: 1668.21 (r/w/o: 1167.71/333.50/167.00) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 5 tps: 84.10 qps: 1681.29 (r/w/o: 1176.69/336.40/168.20) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 5 tps: 85.89 qps: 1716.78 (r/w/o: 1201.41/343.58/171.79) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 5 tps: 85.91 qps: 1722.22 (r/w/o: 1206.49/343.92/171.81) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 5 tps: 89.40 qps: 1786.81 (r/w/o: 1250.50/357.50/178.80) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 5 tps: 85.30 qps: 1704.70 (r/w/o: 1193.10/341.00/170.60) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 5 tps: 86.90 qps: 1739.29 (r/w/o: 1217.89/347.60/173.80) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 5 tps: 80.70 qps: 1613.32 (r/w/o: 1129.11/322.80/161.40) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 5 tps: 86.50 qps: 1730.89 (r/w/o: 1211.90/346.00/173.00) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 5 tps: 82.30 qps: 1646.40 (r/w/o: 1152.60/329.20/164.60) lat (ms,99%): 253.35 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 5 tps: 83.39 qps: 1667.64 (r/w/o: 1166.99/333.87/166.78) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 5 tps: 80.31 qps: 1605.94 (r/w/o: 1124.40/320.93/160.61) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 5 tps: 80.70 qps: 1614.41 (r/w/o: 1130.01/323.00/161.40) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 5 tps: 80.50 qps: 1608.99 (r/w/o: 1126.00/322.00/161.00) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 5 tps: 86.50 qps: 1729.96 (r/w/o: 1211.17/345.79/173.00) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 5 tps: 86.40 qps: 1726.94 (r/w/o: 1208.43/345.71/172.80) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 5 tps: 90.80 qps: 1817.50 (r/w/o: 1272.80/363.10/181.60) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 5 tps: 87.80 qps: 1754.00 (r/w/o: 1227.20/351.20/175.60) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 5 tps: 90.00 qps: 1802.40 (r/w/o: 1262.30/360.10/180.00) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 5 tps: 79.50 qps: 1587.10 (r/w/o: 1110.20/317.90/159.00) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 5 tps: 88.99 qps: 1782.69 (r/w/o: 1248.75/355.96/177.98) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 5 tps: 77.51 qps: 1550.79 (r/w/o: 1085.73/310.04/155.02) lat (ms,99%): 244.38 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 5 tps: 83.50 qps: 1667.07 (r/w/o: 1166.08/333.99/167.00) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 5 tps: 93.70 qps: 1876.55 (r/w/o: 1314.23/374.91/187.40) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 5 tps: 94.40 qps: 1887.69 (r/w/o: 1321.19/377.70/188.80) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 5 tps: 91.10 qps: 1821.90 (r/w/o: 1275.40/364.30/182.20) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 5 tps: 87.60 qps: 1750.80 (r/w/o: 1225.10/350.50/175.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 5 tps: 88.70 qps: 1774.50 (r/w/o: 1242.40/354.70/177.40) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 5 tps: 89.90 qps: 1798.49 (r/w/o: 1258.99/359.70/179.80) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 5 tps: 87.50 qps: 1748.59 (r/w/o: 1223.79/349.80/175.00) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 5 tps: 79.39 qps: 1586.18 (r/w/o: 1109.82/317.58/158.79) lat (ms,99%): 231.53 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 5 tps: 85.91 qps: 1719.94 (r/w/o: 1204.50/343.63/171.81) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 5 tps: 81.20 qps: 1625.87 (r/w/o: 1138.48/324.99/162.40) lat (ms,99%): 244.38 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 5 tps: 88.20 qps: 1764.13 (r/w/o: 1235.12/352.61/176.40) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 5 tps: 84.50 qps: 1689.57 (r/w/o: 1182.38/338.19/169.00) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 5 tps: 88.30 qps: 1766.51 (r/w/o: 1236.61/353.30/176.60) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 5 tps: 89.10 qps: 1779.52 (r/w/o: 1245.22/356.10/178.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 5 tps: 92.70 qps: 1855.89 (r/w/o: 1299.60/370.90/185.40) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 5 tps: 87.40 qps: 1747.00 (r/w/o: 1222.50/349.70/174.80) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 5 tps: 84.60 qps: 1692.87 (r/w/o: 1185.38/338.29/169.20) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 5 tps: 79.50 qps: 1590.73 (r/w/o: 1113.62/318.11/159.00) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 5 tps: 76.60 qps: 1531.31 (r/w/o: 1071.81/306.30/153.20) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 5 tps: 86.40 qps: 1728.34 (r/w/o: 1209.76/345.79/172.79) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 5 tps: 91.50 qps: 1828.85 (r/w/o: 1280.13/365.71/183.00) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 5 tps: 87.40 qps: 1750.29 (r/w/o: 1225.69/349.80/174.80) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 5 tps: 86.60 qps: 1728.53 (r/w/o: 1209.12/346.21/173.20) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 5 tps: 89.20 qps: 1786.67 (r/w/o: 1251.48/356.79/178.40) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 5 tps: 87.20 qps: 1743.31 (r/w/o: 1219.91/349.00/174.40) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 5 tps: 81.20 qps: 1622.31 (r/w/o: 1135.31/324.60/162.40) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 5 tps: 76.00 qps: 1521.08 (r/w/o: 1065.09/304.00/152.00) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 5 tps: 76.20 qps: 1525.09 (r/w/o: 1067.59/305.10/152.40) lat (ms,99%): 244.38 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 5 tps: 80.70 qps: 1610.40 (r/w/o: 1126.50/322.50/161.40) lat (ms,99%): 244.38 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 5 tps: 85.20 qps: 1705.92 (r/w/o: 1194.71/340.80/170.40) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 5 tps: 84.70 qps: 1694.41 (r/w/o: 1186.21/338.80/169.40) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 5 tps: 85.40 qps: 1709.18 (r/w/o: 1196.58/341.80/170.80) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 5 tps: 89.30 qps: 1785.21 (r/w/o: 1249.51/357.10/178.60) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 5 tps: 78.60 qps: 1573.21 (r/w/o: 1101.71/314.30/157.20) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 5 tps: 89.20 qps: 1783.52 (r/w/o: 1248.01/357.10/178.40) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 5 tps: 85.30 qps: 1705.49 (r/w/o: 1193.89/341.00/170.60) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 5 tps: 87.40 qps: 1747.80 (r/w/o: 1223.30/349.70/174.80) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 5 tps: 86.90 qps: 1734.19 (r/w/o: 1212.99/347.40/173.80) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 5 tps: 82.50 qps: 1652.30 (r/w/o: 1157.30/330.00/165.00) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 5 tps: 83.30 qps: 1668.62 (r/w/o: 1168.51/333.50/166.60) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 5 tps: 84.50 qps: 1687.89 (r/w/o: 1181.20/337.70/169.00) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 5 tps: 84.30 qps: 1687.10 (r/w/o: 1181.30/337.20/168.60) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 5 tps: 93.50 qps: 1870.61 (r/w/o: 1309.41/374.20/187.00) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 5 tps: 77.00 qps: 1540.00 (r/w/o: 1078.20/307.80/154.00) lat (ms,99%): 240.02 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 5 tps: 87.30 qps: 1745.68 (r/w/o: 1221.89/349.20/174.60) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 5 tps: 83.30 qps: 1665.41 (r/w/o: 1165.60/333.20/166.60) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 5 tps: 77.10 qps: 1541.90 (r/w/o: 1079.30/308.40/154.20) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 5 tps: 82.40 qps: 1648.90 (r/w/o: 1154.50/329.60/164.80) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 5 tps: 88.30 qps: 1766.90 (r/w/o: 1237.00/353.30/176.60) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 5 tps: 91.60 qps: 1829.60 (r/w/o: 1280.10/366.30/183.20) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 5 tps: 80.70 qps: 1615.19 (r/w/o: 1130.99/322.80/161.40) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 5 tps: 87.80 qps: 1756.71 (r/w/o: 1229.80/351.30/175.60) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2470510
        write:                           705860
        other:                           352930
        total:                           3529300
    transactions:                        176465 (98.02 per sec.)
    queries:                             3529300 (1960.43 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.2662s
    total number of events:              176465

Latency (ms):
         min:                                    3.76
         avg:                                   51.00
         max:                                  641.14
         99th percentile:                      200.47
         sum:                              8999742.45

Threads fairness:
    events (avg/stddev):           35293.0000/93.61
    execution time (avg/stddev):   1799.9485/0.05



        