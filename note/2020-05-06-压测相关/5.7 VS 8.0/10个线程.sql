

瓶颈在IO

sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='' \
--mysql-db=sbtest \
--num-threads=10 \
--oltp-table-size=5000000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=1800 \
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_10_.log &



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 1758 | Waiting on empty queue | NULL                                                                                                 |
|  4 | sysbench        | 192.168.1.12:49084 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest9 WHERE id=1601532                                                               |
|  5 | sysbench        | 192.168.1.12:49083 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest10 WHERE id BETWEEN 991632 AND 991731 ORDER BY c                                 |
|  6 | sysbench        | 192.168.1.12:49098 | sbtest | Query   |    0 | updating               | DELETE FROM sbtest6 WHERE id=1774073                                                                 |
|  7 | sysbench        | 192.168.1.12:49094 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest1 WHERE id BETWEEN 4739120 AND 4739219 ORDER BY c                                |
|  8 | sysbench        | 192.168.1.12:49096 | sbtest | Query   |    0 | statistics             | SELECT SUM(K) FROM sbtest4 WHERE id BETWEEN 3152521 AND 3152620                                      |
|  9 | sysbench        | 192.168.1.12:49100 | sbtest | Query   |    0 | updating               | UPDATE sbtest10 SET k=k+1 WHERE id=3057711                                                           |
| 10 | sysbench        | 192.168.1.12:49104 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest8 WHERE id BETWEEN 1517916 AND 1518015 ORDER BY c                                |
| 11 | sysbench        | 192.168.1.12:49102 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest7 WHERE id=1405804                                                               |
| 12 | sysbench        | 192.168.1.12:49085 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest5 WHERE id=1502268                                                               |
| 13 | sysbench        | 192.168.1.12:49082 | sbtest | Query   |    0 | updating               | UPDATE sbtest9 SET c='9625824656-83121183688-61139583040-46076816074-49184512158-61257964813-476938' |
| 14 | root            | localhost          | NULL   | Query   |    0 | starting               | show processlist                                                                                     |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
12 rows in set (0.00 sec)


[coding001@voice ~]$ iostat 1 
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/15/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.37    0.00    0.62    0.02    0.00   98.99

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               2.18         9.17        53.31   72160279  419311292

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          13.20    0.00    8.12   73.86    0.00    4.82

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1318.00     49184.00      9776.00      49184       9776

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          12.72    0.00    7.38   73.03    0.00    6.87

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1379.00     49120.00     13824.00      49120      13824

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.41    0.00    9.34   67.42    0.00    6.82

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1473.00     49168.00     12196.00      49168      12196

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           7.59    0.00    4.81   82.28    0.00    5.32

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             994.00     49064.00      5516.00      49064       5516


[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/15/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    0.10    2.10     0.01     0.05    57.35     0.01    3.67   13.51    3.21   0.56   0.12

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  824.00  555.00    47.95    11.66    88.53    21.06   15.07   24.69    0.79   0.72  99.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  896.00  641.00    48.00    14.80    83.67    17.10   11.25   18.76    0.76   0.65  99.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  822.00  514.00    48.18     8.81    87.35    24.17   18.10   28.97    0.73   0.75  99.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  808.00  572.00    47.78    13.67    91.20    21.39   15.55   25.93    0.89   0.72  99.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     5.00  937.00  625.00    48.02    12.75    79.67    18.91   11.93   19.33    0.84   0.64  99.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  822.00  585.00    48.16    11.83    87.32    18.18   11.77   19.56    0.82   0.71  99.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  809.00  493.00    47.93     9.32    90.05    18.16   15.13   23.86    0.82   0.76  99.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  792.00  598.00    47.95    14.54    92.07    22.03   15.95   27.32    0.89   0.72  99.40



top - 16:17:04 up 91 days,  1:15,  4 users,  load average: 11.16, 10.89, 9.19
Tasks: 121 total,   1 running, 120 sleeping,   0 stopped,   0 zombie
%Cpu0  : 16.2 us,  7.9 sy,  0.0 ni,  5.8 id, 67.7 wa,  0.0 hi,  2.4 si,  0.0 st
%Cpu1  : 16.8 us,  7.0 sy,  0.0 ni,  6.0 id, 69.1 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu2  : 12.2 us,  7.1 sy,  0.0 ni,  8.1 id, 71.6 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu3  : 13.5 us,  6.1 sy,  0.0 ni,  7.4 id, 72.4 wa,  0.0 hi,  0.7 si,  0.0 st
KiB Mem : 16266300 total,   159992 free,  9865924 used,  6240384 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5373452 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
11489 mysql     20   0   11.2g   8.9g   4164 S  69.7 57.1  25:48.13 mysqld                                                                                                                                                                    
13098 coding0+  20   0  759788   6340   1348 S  11.3  0.0   4:12.42 sysbench                                                                                                                                                                  
 1142 mongodb   20   0 1617356 110240   5004 S   7.7  0.7 664:12.64 mongod          



WARNING: --num-threads is deprecated, use --threads instead
WARNING: --max-time is deprecated, use --time instead
sysbench 1.0.20 (using bundled LuaJIT 2.1.0-beta2)

Running the test with following options:
Number of threads: 10
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 10 tps: 384.86 qps: 7706.82 (r/w/o: 5396.05/1540.05/770.72) lat (ms,99%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 10 tps: 434.92 qps: 8702.84 (r/w/o: 6092.61/1740.39/869.84) lat (ms,99%): 33.72 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 10 tps: 274.02 qps: 5478.78 (r/w/o: 3835.54/1095.20/548.05) lat (ms,99%): 139.85 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 10 tps: 200.20 qps: 4004.15 (r/w/o: 2802.66/801.09/400.39) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 10 tps: 171.10 qps: 3420.35 (r/w/o: 2394.13/684.01/342.20) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 10 tps: 161.60 qps: 3228.55 (r/w/o: 2259.07/646.29/323.20) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 10 tps: 174.40 qps: 3488.85 (r/w/o: 2442.63/697.41/348.80) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 10 tps: 168.20 qps: 3361.59 (r/w/o: 2352.39/672.80/336.40) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 10 tps: 178.50 qps: 3573.31 (r/w/o: 2502.11/714.20/357.00) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 10 tps: 156.70 qps: 3137.16 (r/w/o: 2196.37/627.39/313.40) lat (ms,99%): 231.53 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 10 tps: 149.00 qps: 2979.84 (r/w/o: 2086.33/595.51/298.00) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 10 tps: 157.60 qps: 3149.00 (r/w/o: 2203.50/630.30/315.20) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 10 tps: 141.90 qps: 2840.68 (r/w/o: 1989.08/567.80/283.80) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 10 tps: 153.20 qps: 3061.22 (r/w/o: 2142.41/612.40/306.40) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 10 tps: 138.40 qps: 2764.41 (r/w/o: 1934.00/553.60/276.80) lat (ms,99%): 253.35 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 10 tps: 143.30 qps: 2872.80 (r/w/o: 2012.60/573.60/286.60) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 10 tps: 126.30 qps: 2522.81 (r/w/o: 1765.31/504.90/252.60) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 10 tps: 113.40 qps: 2273.75 (r/w/o: 1592.17/454.79/226.80) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 10 tps: 116.80 qps: 2332.31 (r/w/o: 1632.31/466.40/233.60) lat (ms,99%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 10 tps: 121.10 qps: 2420.61 (r/w/o: 1694.11/484.30/242.20) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 10 tps: 130.90 qps: 2618.82 (r/w/o: 1833.01/524.00/261.80) lat (ms,99%): 231.53 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 10 tps: 119.30 qps: 2384.00 (r/w/o: 1669.00/476.40/238.60) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 10 tps: 121.90 qps: 2439.00 (r/w/o: 1707.50/487.70/243.80) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 10 tps: 119.00 qps: 2384.29 (r/w/o: 1669.19/477.10/238.00) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 10 tps: 117.60 qps: 2345.72 (r/w/o: 1641.01/469.50/235.20) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 10 tps: 115.50 qps: 2312.46 (r/w/o: 1619.67/461.79/231.00) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 10 tps: 112.90 qps: 2258.13 (r/w/o: 1580.82/451.51/225.80) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 10 tps: 113.20 qps: 2263.46 (r/w/o: 1584.17/452.89/226.40) lat (ms,99%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 10 tps: 115.40 qps: 2310.95 (r/w/o: 1618.33/461.81/230.80) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 10 tps: 106.10 qps: 2121.29 (r/w/o: 1484.99/424.10/212.20) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 10 tps: 116.00 qps: 2316.51 (r/w/o: 1620.31/464.20/232.00) lat (ms,99%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 10 tps: 115.70 qps: 2318.17 (r/w/o: 1623.88/462.89/231.40) lat (ms,99%): 240.02 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 10 tps: 107.20 qps: 2139.73 (r/w/o: 1496.72/428.61/214.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 10 tps: 104.70 qps: 2094.79 (r/w/o: 1466.69/418.70/209.40) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 10 tps: 100.20 qps: 2006.41 (r/w/o: 1405.11/400.90/200.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 10 tps: 105.40 qps: 2108.11 (r/w/o: 1475.31/422.00/210.80) lat (ms,99%): 253.35 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 10 tps: 94.90 qps: 1895.07 (r/w/o: 1325.98/379.29/189.80) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 10 tps: 101.30 qps: 2028.22 (r/w/o: 1420.61/405.00/202.60) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 10 tps: 97.40 qps: 1947.40 (r/w/o: 1362.90/389.70/194.80) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 10 tps: 95.00 qps: 1898.60 (r/w/o: 1328.50/380.10/190.00) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 10 tps: 104.40 qps: 2089.27 (r/w/o: 1462.88/417.59/208.80) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 10 tps: 91.10 qps: 1820.21 (r/w/o: 1273.81/364.20/182.20) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 10 tps: 91.50 qps: 1833.73 (r/w/o: 1284.12/366.61/183.00) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 10 tps: 97.90 qps: 1954.60 (r/w/o: 1367.60/391.20/195.80) lat (ms,99%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 10 tps: 96.80 qps: 1935.79 (r/w/o: 1355.19/387.00/193.60) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 10 tps: 99.70 qps: 1994.99 (r/w/o: 1396.80/398.80/199.40) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 10 tps: 93.90 qps: 1878.41 (r/w/o: 1314.21/376.40/187.80) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 10 tps: 102.00 qps: 2042.51 (r/w/o: 1430.24/408.38/203.89) lat (ms,99%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 10 tps: 85.30 qps: 1705.65 (r/w/o: 1194.04/340.91/170.71) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 10 tps: 95.30 qps: 1902.81 (r/w/o: 1331.91/380.30/190.60) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 10 tps: 90.80 qps: 1814.89 (r/w/o: 1270.09/363.20/181.60) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 10 tps: 86.60 qps: 1736.02 (r/w/o: 1216.01/346.80/173.20) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 10 tps: 94.00 qps: 1874.77 (r/w/o: 1311.18/375.59/188.00) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 10 tps: 100.00 qps: 2000.28 (r/w/o: 1400.29/400.00/200.00) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 10 tps: 88.80 qps: 1780.53 (r/w/o: 1247.12/355.81/177.60) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 10 tps: 84.60 qps: 1689.20 (r/w/o: 1182.00/338.00/169.20) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 10 tps: 92.20 qps: 1847.60 (r/w/o: 1294.00/369.20/184.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 10 tps: 81.80 qps: 1633.09 (r/w/o: 1142.69/326.80/163.60) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 10 tps: 92.30 qps: 1850.72 (r/w/o: 1295.91/370.20/184.60) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 10 tps: 81.00 qps: 1619.51 (r/w/o: 1134.41/323.10/162.00) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 10 tps: 90.10 qps: 1797.49 (r/w/o: 1257.19/360.10/180.20) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 10 tps: 92.50 qps: 1849.89 (r/w/o: 1294.89/370.00/185.00) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 10 tps: 89.20 qps: 1785.90 (r/w/o: 1250.70/356.80/178.40) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 10 tps: 92.30 qps: 1843.11 (r/w/o: 1289.21/369.30/184.60) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 10 tps: 89.40 qps: 1789.80 (r/w/o: 1253.30/357.70/178.80) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 10 tps: 86.50 qps: 1727.61 (r/w/o: 1208.61/346.00/173.00) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 10 tps: 82.90 qps: 1661.78 (r/w/o: 1164.49/331.50/165.80) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 10 tps: 89.80 qps: 1795.72 (r/w/o: 1256.71/359.40/179.60) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 10 tps: 91.20 qps: 1823.90 (r/w/o: 1276.80/364.80/182.30) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 10 tps: 92.30 qps: 1844.68 (r/w/o: 1290.99/369.00/184.70) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 10 tps: 93.80 qps: 1879.70 (r/w/o: 1316.30/375.80/187.60) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 10 tps: 91.80 qps: 1835.21 (r/w/o: 1284.91/366.70/183.60) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 10 tps: 80.00 qps: 1599.74 (r/w/o: 1118.86/320.89/159.99) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 10 tps: 90.70 qps: 1811.23 (r/w/o: 1267.72/362.11/181.40) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 10 tps: 89.70 qps: 1792.23 (r/w/o: 1254.42/358.41/179.40) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 10 tps: 85.20 qps: 1707.50 (r/w/o: 1196.10/341.00/170.40) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 10 tps: 92.40 qps: 1846.40 (r/w/o: 1291.90/369.70/184.80) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 10 tps: 92.00 qps: 1840.01 (r/w/o: 1288.01/368.00/184.00) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 10 tps: 86.70 qps: 1734.37 (r/w/o: 1214.48/346.49/173.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 10 tps: 94.00 qps: 1880.24 (r/w/o: 1316.23/376.01/188.00) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 10 tps: 86.00 qps: 1720.90 (r/w/o: 1204.60/344.40/171.90) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 10 tps: 89.70 qps: 1794.18 (r/w/o: 1256.09/358.60/179.50) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 10 tps: 83.20 qps: 1665.20 (r/w/o: 1165.40/333.40/166.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 10 tps: 87.70 qps: 1752.40 (r/w/o: 1226.60/350.40/175.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 10 tps: 88.20 qps: 1764.09 (r/w/o: 1234.89/352.80/176.40) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 10 tps: 87.80 qps: 1753.39 (r/w/o: 1226.69/351.10/175.60) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 10 tps: 90.00 qps: 1800.03 (r/w/o: 1260.32/359.71/180.00) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 10 tps: 88.20 qps: 1764.40 (r/w/o: 1235.20/352.80/176.40) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 10 tps: 86.70 qps: 1735.18 (r/w/o: 1214.59/347.20/173.40) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 10 tps: 86.20 qps: 1724.42 (r/w/o: 1207.51/344.50/172.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 10 tps: 91.50 qps: 1830.90 (r/w/o: 1281.80/366.10/183.00) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 10 tps: 89.20 qps: 1779.19 (r/w/o: 1244.20/356.60/178.40) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 10 tps: 77.70 qps: 1558.90 (r/w/o: 1092.60/310.90/155.40) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 10 tps: 87.10 qps: 1743.00 (r/w/o: 1220.10/348.70/174.20) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 10 tps: 86.80 qps: 1733.41 (r/w/o: 1212.90/346.90/173.60) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 10 tps: 93.50 qps: 1871.20 (r/w/o: 1309.80/374.40/187.00) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 10 tps: 84.50 qps: 1691.19 (r/w/o: 1183.59/338.60/169.00) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 10 tps: 87.60 qps: 1750.98 (r/w/o: 1226.39/349.40/175.20) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 10 tps: 93.30 qps: 1863.22 (r/w/o: 1303.31/373.30/186.60) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 10 tps: 81.90 qps: 1639.90 (r/w/o: 1148.40/327.70/163.80) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 10 tps: 87.60 qps: 1750.70 (r/w/o: 1225.40/350.10/175.20) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 10 tps: 88.30 qps: 1772.50 (r/w/o: 1241.60/354.30/176.60) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 10 tps: 88.30 qps: 1758.80 (r/w/o: 1229.80/352.40/176.60) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 10 tps: 78.90 qps: 1580.52 (r/w/o: 1107.31/315.40/157.80) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 10 tps: 81.00 qps: 1618.58 (r/w/o: 1132.69/323.90/162.00) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 10 tps: 82.10 qps: 1644.72 (r/w/o: 1152.01/328.50/164.20) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 10 tps: 88.70 qps: 1770.40 (r/w/o: 1238.30/354.70/177.40) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 10 tps: 81.70 qps: 1637.88 (r/w/o: 1146.99/327.50/163.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 10 tps: 92.30 qps: 1844.19 (r/w/o: 1290.89/368.70/184.60) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 10 tps: 89.60 qps: 1791.41 (r/w/o: 1254.01/358.20/179.20) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 10 tps: 94.70 qps: 1889.71 (r/w/o: 1321.31/379.00/189.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 10 tps: 94.20 qps: 1888.10 (r/w/o: 1323.10/376.60/188.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 10 tps: 89.30 qps: 1787.79 (r/w/o: 1251.59/357.60/178.60) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 10 tps: 88.30 qps: 1762.10 (r/w/o: 1232.70/352.80/176.60) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 10 tps: 89.00 qps: 1782.01 (r/w/o: 1248.01/356.00/178.00) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 10 tps: 82.40 qps: 1648.59 (r/w/o: 1153.79/330.00/164.80) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 10 tps: 89.40 qps: 1789.87 (r/w/o: 1253.48/357.59/178.80) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 10 tps: 92.20 qps: 1839.82 (r/w/o: 1286.81/368.60/184.40) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 10 tps: 80.80 qps: 1622.17 (r/w/o: 1136.48/324.09/161.60) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 10 tps: 90.20 qps: 1800.24 (r/w/o: 1259.63/360.21/180.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 10 tps: 90.20 qps: 1804.92 (r/w/o: 1264.22/360.30/180.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 10 tps: 88.30 qps: 1765.19 (r/w/o: 1234.29/354.30/176.60) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 10 tps: 78.90 qps: 1577.80 (r/w/o: 1105.50/314.50/157.80) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 10 tps: 90.20 qps: 1803.78 (r/w/o: 1262.19/361.20/180.40) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 10 tps: 78.50 qps: 1570.91 (r/w/o: 1100.21/313.70/157.00) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 10 tps: 83.70 qps: 1672.09 (r/w/o: 1169.90/334.80/167.40) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 10 tps: 84.60 qps: 1695.71 (r/w/o: 1187.40/339.10/169.20) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 10 tps: 85.20 qps: 1701.21 (r/w/o: 1190.61/340.20/170.40) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 10 tps: 94.40 qps: 1889.70 (r/w/o: 1323.30/377.60/188.80) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 10 tps: 85.80 qps: 1716.55 (r/w/o: 1201.76/343.19/171.59) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 10 tps: 86.90 qps: 1733.05 (r/w/o: 1211.83/347.41/173.80) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 10 tps: 80.40 qps: 1610.60 (r/w/o: 1128.10/321.70/160.80) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 10 tps: 86.70 qps: 1733.99 (r/w/o: 1213.89/346.70/173.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 10 tps: 78.10 qps: 1562.50 (r/w/o: 1093.90/312.40/156.20) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 10 tps: 93.20 qps: 1861.32 (r/w/o: 1301.81/373.10/186.40) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 10 tps: 88.90 qps: 1781.50 (r/w/o: 1248.40/355.30/177.80) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 10 tps: 88.20 qps: 1762.98 (r/w/o: 1233.49/353.10/176.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 10 tps: 90.30 qps: 1806.30 (r/w/o: 1264.80/360.90/180.60) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 10 tps: 81.50 qps: 1628.29 (r/w/o: 1138.99/326.30/163.00) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 10 tps: 86.70 qps: 1734.93 (r/w/o: 1215.02/346.51/173.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 10 tps: 88.50 qps: 1769.68 (r/w/o: 1238.49/354.20/177.00) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 10 tps: 88.30 qps: 1767.70 (r/w/o: 1237.70/353.40/176.60) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 10 tps: 74.00 qps: 1481.31 (r/w/o: 1037.00/296.30/148.00) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 10 tps: 82.99 qps: 1656.95 (r/w/o: 1159.09/331.87/165.98) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 10 tps: 80.21 qps: 1608.36 (r/w/o: 1126.91/321.03/160.42) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 10 tps: 89.20 qps: 1778.90 (r/w/o: 1244.50/356.00/178.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 10 tps: 81.90 qps: 1642.60 (r/w/o: 1150.40/328.40/163.80) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 10 tps: 77.30 qps: 1540.09 (r/w/o: 1076.89/308.60/154.60) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 10 tps: 85.90 qps: 1719.30 (r/w/o: 1204.10/343.40/171.80) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 10 tps: 87.40 qps: 1748.80 (r/w/o: 1224.30/349.70/174.80) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 10 tps: 86.80 qps: 1735.80 (r/w/o: 1215.00/347.20/173.60) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 10 tps: 88.50 qps: 1768.20 (r/w/o: 1237.30/353.90/177.00) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 10 tps: 89.60 qps: 1794.70 (r/w/o: 1257.10/358.40/179.20) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 10 tps: 82.60 qps: 1654.20 (r/w/o: 1158.30/330.70/165.20) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 10 tps: 87.10 qps: 1739.01 (r/w/o: 1216.71/348.10/174.20) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 10 tps: 81.80 qps: 1637.78 (r/w/o: 1146.79/327.40/163.60) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 10 tps: 85.80 qps: 1717.00 (r/w/o: 1202.20/343.20/171.60) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 10 tps: 88.90 qps: 1775.69 (r/w/o: 1241.99/355.90/177.80) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 10 tps: 88.49 qps: 1771.27 (r/w/o: 1240.81/353.47/176.99) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 10 tps: 86.61 qps: 1731.03 (r/w/o: 1211.09/346.73/173.21) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 10 tps: 88.90 qps: 1776.60 (r/w/o: 1243.30/355.50/177.80) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 10 tps: 86.70 qps: 1732.22 (r/w/o: 1212.21/346.60/173.40) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 10 tps: 82.10 qps: 1644.41 (r/w/o: 1151.70/328.50/164.20) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 10 tps: 89.80 qps: 1795.68 (r/w/o: 1256.69/359.40/179.60) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 10 tps: 81.30 qps: 1627.50 (r/w/o: 1139.90/325.00/162.60) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 10 tps: 89.90 qps: 1800.18 (r/w/o: 1259.69/360.70/179.80) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 10 tps: 89.10 qps: 1779.34 (r/w/o: 1245.73/355.41/178.20) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 10 tps: 80.10 qps: 1603.70 (r/w/o: 1122.70/320.80/160.20) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 10 tps: 88.30 qps: 1766.99 (r/w/o: 1237.40/353.00/176.60) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 10 tps: 79.89 qps: 1593.08 (r/w/o: 1114.11/319.18/159.79) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 10 tps: 91.91 qps: 1840.35 (r/w/o: 1288.90/367.63/183.81) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 10 tps: 88.80 qps: 1777.60 (r/w/o: 1244.20/355.80/177.60) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 10 tps: 93.60 qps: 1868.59 (r/w/o: 1307.50/373.90/187.20) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 10 tps: 82.90 qps: 1660.80 (r/w/o: 1163.10/331.90/165.80) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 10 tps: 83.50 qps: 1669.11 (r/w/o: 1168.40/333.70/167.00) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 10 tps: 88.10 qps: 1762.70 (r/w/o: 1234.20/352.30/176.20) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 10 tps: 93.70 qps: 1875.99 (r/w/o: 1313.19/375.40/187.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 10 tps: 89.90 qps: 1797.88 (r/w/o: 1258.28/359.80/179.80) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 10 tps: 82.70 qps: 1653.53 (r/w/o: 1158.12/330.01/165.40) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 10 tps: 84.50 qps: 1683.69 (r/w/o: 1176.69/338.00/169.00) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2544192
        write:                           726912
        other:                           363456
        total:                           3634560
    transactions:                        181728 (100.94 per sec.)
    queries:                             3634560 (2018.74 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.4095s
    total number of events:              181728

Latency (ms):
         min:                                    6.99
         avg:                                   99.06
         max:                                  681.35
         99th percentile:                      308.84
         sum:                             18001196.06

Threads fairness:
    events (avg/stddev):           18172.8000/31.30
    execution time (avg/stddev):   1800.1196/0.14
