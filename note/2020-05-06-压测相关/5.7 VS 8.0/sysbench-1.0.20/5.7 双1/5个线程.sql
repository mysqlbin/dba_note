
set global sync_binlog=0;
set global innodb_flush_log_at_trx_commit=0;
 
[coding001@voice ~]$ time mysql -uroot -p sbtest < sbtest.sql
Enter password: 

real	15m37.718s
user	1m54.932s
sys	0m9.416s

sudo /etc/init.d/mysql restart 


set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;


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
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_5_.log &



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+------------------------+--------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time | State                  | Info                                                                           |
+----+-----------------+--------------------+--------+---------+------+------------------------+--------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 1982 | Waiting on empty queue | NULL                                                                           |
|  3 | root            | localhost          | sbtest | Query   |    0 | starting               | show processlist                                                               |
|  7 | sysbench        | 192.168.1.12:49457 | sbtest | Query   |    0 | updating               | UPDATE sbtest6 SET k=k+1 WHERE id=3317814                                      |
|  8 | sysbench        | 192.168.1.12:49455 | sbtest | Query   |    0 | updating               | UPDATE sbtest6 SET k=k+1 WHERE id=56361                                        |
|  9 | sysbench        | 192.168.1.12:49456 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest6 WHERE id=1039144                                         |
| 10 | sysbench        | 192.168.1.12:49464 | sbtest | Query   |    0 | statistics             | SELECT DISTINCT c FROM sbtest2 WHERE id BETWEEN 1892814 AND 1892913 ORDER BY c |
| 11 | sysbench        | 192.168.1.12:49454 | sbtest | Query   |    0 | statistics             | SELECT DISTINCT c FROM sbtest3 WHERE id BETWEEN 100349 AND 100448 ORDER BY c   |
+----+-----------------+--------------------+--------+---------+------+------------------------+--------------------------------------------------------------------------------+
7 rows in set (0.00 sec)


[coding001@voice ~]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/15/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.38    0.00    0.62    0.03    0.00   98.97

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               2.53        21.15        62.53  166435791  492096580

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.20    0.00   10.13   48.86    0.00   24.81

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1731.00     49140.00     11576.00      49140      11576

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          15.60    0.00    8.44   52.69    0.00   23.27

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1599.00     49184.00     11300.00      49184      11300

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.72    0.00    9.90   59.90    0.00   15.48

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1511.00     49156.00     10660.00      49156      10660

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          17.56    0.00   10.18   52.42    0.00   19.85

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1668.00     49108.00     11336.00      49108      11336

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.87    0.00    8.46   60.26    0.00   16.41

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1507.00     49144.00     10948.00      49144      10948



[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/15/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    0.27    2.26     0.02     0.06    66.14     0.01    4.98   20.53    3.10   0.57   0.14

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  758.00  493.00    48.25    10.64    96.40    28.94   23.13   37.58    0.91   0.79  98.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  847.00  726.00    48.02    11.04    76.89    12.67    7.98   14.12    0.83   0.62  96.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  842.00  612.00    47.91    10.67    82.50    14.76   10.23   17.04    0.86   0.68  98.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  987.00  777.00    48.09    10.37    67.88     9.26    5.24    8.82    0.71   0.55  97.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00  875.00  670.00    48.00     9.98    76.85    11.07    6.97   11.71    0.77   0.64  98.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  856.00  627.00    48.01     9.75    79.77    11.29    7.82   12.97    0.79   0.67  98.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  903.00  665.00    48.05     9.49    75.16    18.91   12.02   20.29    0.78   0.63  98.00


[coding001@voice ~]$ top
top - 16:58:22 up 91 days,  1:56,  4 users,  load average: 5.37, 4.49, 3.28
Tasks: 119 total,   1 running, 118 sleeping,   0 stopped,   0 zombie
%Cpu0  : 14.4 us,  7.5 sy,  0.0 ni, 12.0 id, 64.0 wa,  0.0 hi,  2.1 si,  0.0 st
%Cpu1  : 12.1 us,  5.7 sy,  0.0 ni, 27.2 id, 53.4 wa,  0.0 hi,  1.7 si,  0.0 st
%Cpu2  : 11.1 us,  6.0 sy,  0.0 ni, 30.2 id, 51.7 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu3  : 12.1 us,  6.0 sy,  0.0 ni, 27.5 id, 53.4 wa,  0.0 hi,  1.0 si,  0.0 st
KiB Mem : 16266300 total,   172408 free,  9877072 used,  6216820 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5363120 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
16680 mysql     20   0   11.0g   8.9g   4456 S  69.8 57.2  22:31.73 mysqld                                                                                                                                                                    
19006 coding0+  20   0  429528   4176   1376 S  13.0  0.0   1:35.53 sysbench                  



[coding001@voice ~]$ cat  sysbench_oltpX_5_.log
WARNING: --num-threads is deprecated, use --threads instead
WARNING: --max-time is deprecated, use --time instead
sysbench 1.0.20 (using bundled LuaJIT 2.1.0-beta2)

Running the test with following options:
Number of threads: 5
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 5 tps: 262.96 qps: 5267.60 (r/w/o: 3688.17/1053.02/526.41) lat (ms,99%): 62.19 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 5 tps: 95.12 qps: 1900.39 (r/w/o: 1330.54/379.60/190.25) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 5 tps: 91.20 qps: 1822.91 (r/w/o: 1275.91/364.60/182.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 5 tps: 95.90 qps: 1916.82 (r/w/o: 1341.11/383.90/191.80) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 5 tps: 104.80 qps: 2095.81 (r/w/o: 1467.41/418.80/209.60) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 5 tps: 112.20 qps: 2247.70 (r/w/o: 1573.70/449.60/224.40) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 5 tps: 112.70 qps: 2252.19 (r/w/o: 1576.49/450.30/225.40) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 5 tps: 114.50 qps: 2290.68 (r/w/o: 1603.78/457.90/229.00) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 5 tps: 93.50 qps: 1867.53 (r/w/o: 1306.72/373.81/187.00) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 5 tps: 99.70 qps: 1994.21 (r/w/o: 1395.84/398.98/199.39) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 5 tps: 105.30 qps: 2105.89 (r/w/o: 1474.27/421.02/210.61) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 5 tps: 102.30 qps: 2046.00 (r/w/o: 1432.20/409.20/204.60) lat (ms,99%): 244.38 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 5 tps: 94.70 qps: 1895.92 (r/w/o: 1327.35/379.18/189.39) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 5 tps: 108.91 qps: 2180.30 (r/w/o: 1526.07/436.42/217.81) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 5 tps: 112.30 qps: 2242.59 (r/w/o: 1569.89/448.10/224.60) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 5 tps: 113.99 qps: 2280.33 (r/w/o: 1596.08/456.27/227.98) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 5 tps: 124.81 qps: 2495.58 (r/w/o: 1747.13/498.84/249.62) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 5 tps: 115.90 qps: 2319.51 (r/w/o: 1623.51/464.20/231.80) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 5 tps: 125.40 qps: 2507.80 (r/w/o: 1755.60/501.40/250.80) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 5 tps: 146.10 qps: 2919.41 (r/w/o: 2043.31/584.00/292.10) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 5 tps: 120.09 qps: 2403.60 (r/w/o: 1682.96/480.36/240.28) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 5 tps: 140.21 qps: 2803.90 (r/w/o: 1962.14/561.34/280.42) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 5 tps: 127.80 qps: 2556.99 (r/w/o: 1790.49/510.90/255.60) lat (ms,99%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 5 tps: 123.90 qps: 2479.21 (r/w/o: 1735.31/496.10/247.80) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 5 tps: 131.90 qps: 2634.72 (r/w/o: 1844.01/526.90/263.80) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 5 tps: 126.30 qps: 2526.29 (r/w/o: 1768.39/505.30/252.60) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 5 tps: 132.70 qps: 2656.71 (r/w/o: 1860.31/531.00/265.40) lat (ms,99%): 139.85 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 5 tps: 125.50 qps: 2510.31 (r/w/o: 1757.51/501.80/251.00) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 5 tps: 110.50 qps: 2207.40 (r/w/o: 1544.50/441.90/221.00) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 5 tps: 114.40 qps: 2290.29 (r/w/o: 1603.50/458.00/228.80) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 5 tps: 117.50 qps: 2347.80 (r/w/o: 1643.20/469.60/235.00) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 5 tps: 104.50 qps: 2090.29 (r/w/o: 1463.09/418.20/209.00) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 5 tps: 104.10 qps: 2085.61 (r/w/o: 1460.00/417.40/208.20) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 5 tps: 115.90 qps: 2314.07 (r/w/o: 1619.48/462.79/231.80) lat (ms,99%): 142.39 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 5 tps: 118.19 qps: 2361.54 (r/w/o: 1652.79/472.37/236.38) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 5 tps: 119.01 qps: 2381.70 (r/w/o: 1667.54/476.14/238.02) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 5 tps: 119.50 qps: 2392.49 (r/w/o: 1674.79/478.70/239.00) lat (ms,99%): 142.39 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 5 tps: 107.50 qps: 2149.19 (r/w/o: 1504.39/429.80/215.00) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 5 tps: 103.40 qps: 2068.82 (r/w/o: 1448.61/413.40/206.80) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 5 tps: 115.80 qps: 2316.30 (r/w/o: 1621.10/463.60/231.60) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 5 tps: 115.00 qps: 2295.27 (r/w/o: 1606.08/459.19/230.00) lat (ms,99%): 150.29 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 5 tps: 93.30 qps: 1868.61 (r/w/o: 1308.61/373.40/186.60) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 5 tps: 110.70 qps: 2214.66 (r/w/o: 1550.27/442.99/221.40) lat (ms,99%): 147.61 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 5 tps: 110.40 qps: 2208.53 (r/w/o: 1546.12/441.61/220.80) lat (ms,99%): 150.29 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 5 tps: 113.70 qps: 2273.10 (r/w/o: 1591.10/454.60/227.40) lat (ms,99%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 5 tps: 110.80 qps: 2216.70 (r/w/o: 1552.10/443.00/221.60) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 5 tps: 108.50 qps: 2169.42 (r/w/o: 1518.42/434.00/217.00) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 5 tps: 103.30 qps: 2066.77 (r/w/o: 1446.78/413.39/206.60) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 5 tps: 110.60 qps: 2209.64 (r/w/o: 1546.23/442.21/221.20) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 5 tps: 105.80 qps: 2116.58 (r/w/o: 1481.79/423.20/211.60) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 5 tps: 96.70 qps: 1935.32 (r/w/o: 1354.71/387.20/193.40) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 5 tps: 119.30 qps: 2386.16 (r/w/o: 1670.77/476.79/238.60) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 5 tps: 104.50 qps: 2090.42 (r/w/o: 1462.92/418.50/209.00) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 5 tps: 101.20 qps: 2022.97 (r/w/o: 1416.28/404.29/202.40) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 5 tps: 110.80 qps: 2218.20 (r/w/o: 1552.70/443.90/221.60) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 5 tps: 96.00 qps: 1919.78 (r/w/o: 1343.99/383.80/192.00) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 5 tps: 104.40 qps: 2084.15 (r/w/o: 1458.24/417.11/208.81) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 5 tps: 92.50 qps: 1852.08 (r/w/o: 1297.09/370.00/185.00) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 5 tps: 102.20 qps: 2044.51 (r/w/o: 1430.91/409.30/204.30) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 5 tps: 93.90 qps: 1877.91 (r/w/o: 1314.91/375.10/187.90) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 5 tps: 97.80 qps: 1955.68 (r/w/o: 1368.88/391.20/195.60) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 5 tps: 105.40 qps: 2105.12 (r/w/o: 1472.71/421.60/210.80) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 5 tps: 100.40 qps: 2009.18 (r/w/o: 1406.79/401.60/200.80) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 5 tps: 98.90 qps: 1979.11 (r/w/o: 1385.71/395.60/197.80) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 5 tps: 101.50 qps: 2028.51 (r/w/o: 1419.51/406.00/203.00) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 5 tps: 88.30 qps: 1768.18 (r/w/o: 1237.99/353.60/176.60) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 5 tps: 98.60 qps: 1971.53 (r/w/o: 1380.32/394.01/197.20) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 5 tps: 94.70 qps: 1893.70 (r/w/o: 1325.50/378.80/189.40) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 5 tps: 103.10 qps: 2064.59 (r/w/o: 1445.79/412.60/206.20) lat (ms,99%): 147.61 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 5 tps: 102.50 qps: 2047.90 (r/w/o: 1433.10/409.80/205.00) lat (ms,99%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 5 tps: 96.60 qps: 1931.79 (r/w/o: 1352.19/386.40/193.20) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 5 tps: 87.00 qps: 1739.72 (r/w/o: 1217.71/348.00/174.00) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 5 tps: 103.10 qps: 2063.56 (r/w/o: 1444.98/412.39/206.20) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 5 tps: 106.00 qps: 2118.41 (r/w/o: 1482.41/424.00/212.00) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 5 tps: 93.30 qps: 1866.11 (r/w/o: 1306.11/373.40/186.60) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 5 tps: 94.40 qps: 1890.71 (r/w/o: 1323.41/378.50/188.80) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 5 tps: 85.80 qps: 1714.40 (r/w/o: 1200.40/342.50/171.50) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 5 tps: 91.30 qps: 1825.67 (r/w/o: 1277.98/364.99/182.70) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 5 tps: 96.80 qps: 1935.82 (r/w/o: 1355.01/387.20/193.60) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 5 tps: 88.50 qps: 1770.70 (r/w/o: 1239.70/354.00/177.00) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 5 tps: 99.70 qps: 1993.19 (r/w/o: 1394.90/398.90/199.40) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 5 tps: 91.30 qps: 1826.21 (r/w/o: 1278.71/364.90/182.60) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 5 tps: 99.70 qps: 1995.29 (r/w/o: 1396.30/399.60/199.40) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 5 tps: 93.40 qps: 1868.21 (r/w/o: 1308.61/372.80/186.80) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 5 tps: 92.60 qps: 1852.39 (r/w/o: 1295.79/371.40/185.20) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 5 tps: 92.00 qps: 1837.51 (r/w/o: 1286.50/367.00/184.00) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 5 tps: 83.70 qps: 1672.90 (r/w/o: 1170.70/334.80/167.40) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 5 tps: 94.20 qps: 1886.20 (r/w/o: 1320.80/377.00/188.40) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 5 tps: 95.20 qps: 1903.59 (r/w/o: 1332.59/380.60/190.40) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 5 tps: 91.00 qps: 1818.40 (r/w/o: 1272.30/364.10/182.00) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 5 tps: 95.10 qps: 1905.39 (r/w/o: 1334.09/381.10/190.20) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 5 tps: 97.30 qps: 1945.61 (r/w/o: 1362.50/388.50/194.60) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 5 tps: 92.20 qps: 1841.61 (r/w/o: 1288.50/368.70/184.40) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 5 tps: 84.90 qps: 1697.71 (r/w/o: 1188.31/339.60/169.80) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 5 tps: 82.60 qps: 1652.20 (r/w/o: 1156.30/330.70/165.20) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 5 tps: 80.80 qps: 1616.70 (r/w/o: 1131.90/323.20/161.60) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 5 tps: 91.60 qps: 1832.39 (r/w/o: 1283.09/366.10/183.20) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 5 tps: 86.00 qps: 1717.70 (r/w/o: 1201.70/344.00/172.00) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 5 tps: 93.30 qps: 1866.70 (r/w/o: 1306.90/373.20/186.60) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 5 tps: 81.30 qps: 1625.09 (r/w/o: 1137.30/325.20/162.60) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 5 tps: 87.30 qps: 1749.70 (r/w/o: 1225.50/349.60/174.60) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 5 tps: 89.30 qps: 1785.00 (r/w/o: 1249.10/357.30/178.60) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 5 tps: 88.90 qps: 1777.16 (r/w/o: 1244.17/355.19/177.80) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 5 tps: 89.30 qps: 1785.83 (r/w/o: 1249.92/357.31/178.60) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 5 tps: 93.60 qps: 1873.52 (r/w/o: 1311.91/374.40/187.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 5 tps: 92.90 qps: 1858.39 (r/w/o: 1300.79/371.80/185.80) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 5 tps: 89.60 qps: 1790.71 (r/w/o: 1253.30/358.20/179.20) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 5 tps: 93.00 qps: 1859.39 (r/w/o: 1301.50/371.90/186.00) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 5 tps: 89.50 qps: 1790.40 (r/w/o: 1252.90/358.50/179.00) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 5 tps: 101.30 qps: 2025.77 (r/w/o: 1418.58/404.59/202.60) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 5 tps: 94.50 qps: 1892.39 (r/w/o: 1325.00/378.40/189.00) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 5 tps: 95.20 qps: 1901.73 (r/w/o: 1330.92/380.41/190.40) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 5 tps: 81.80 qps: 1636.20 (r/w/o: 1145.30/327.30/163.60) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 5 tps: 90.50 qps: 1811.91 (r/w/o: 1268.81/362.10/181.00) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 5 tps: 83.50 qps: 1668.50 (r/w/o: 1167.70/333.80/167.00) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 5 tps: 91.70 qps: 1832.19 (r/w/o: 1281.99/366.80/183.40) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 5 tps: 83.00 qps: 1660.01 (r/w/o: 1162.01/332.00/166.00) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 5 tps: 88.50 qps: 1769.69 (r/w/o: 1238.69/354.00/177.00) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 5 tps: 79.80 qps: 1598.81 (r/w/o: 1119.91/319.30/159.60) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 5 tps: 78.20 qps: 1562.00 (r/w/o: 1092.90/312.70/156.40) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 5 tps: 88.50 qps: 1771.19 (r/w/o: 1240.19/354.00/177.00) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 5 tps: 88.30 qps: 1762.46 (r/w/o: 1232.77/353.19/176.50) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 5 tps: 86.70 qps: 1739.50 (r/w/o: 1218.40/347.60/173.50) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 5 tps: 82.40 qps: 1645.95 (r/w/o: 1152.33/328.81/164.80) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 5 tps: 89.40 qps: 1786.60 (r/w/o: 1250.20/357.60/178.80) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 5 tps: 78.80 qps: 1574.30 (r/w/o: 1101.50/315.20/157.60) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 5 tps: 78.60 qps: 1576.58 (r/w/o: 1104.69/314.70/157.20) lat (ms,99%): 253.35 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 5 tps: 82.90 qps: 1655.31 (r/w/o: 1158.20/331.30/165.80) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 5 tps: 91.10 qps: 1824.21 (r/w/o: 1276.91/365.10/182.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 5 tps: 90.20 qps: 1803.01 (r/w/o: 1262.41/360.20/180.40) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 5 tps: 88.00 qps: 1757.69 (r/w/o: 1229.89/351.90/175.90) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 5 tps: 86.90 qps: 1741.10 (r/w/o: 1219.50/347.70/173.90) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 5 tps: 81.20 qps: 1624.49 (r/w/o: 1137.30/324.80/162.40) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 5 tps: 78.90 qps: 1577.20 (r/w/o: 1103.20/316.30/157.70) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 5 tps: 89.30 qps: 1785.76 (r/w/o: 1249.87/357.19/178.70) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 5 tps: 83.90 qps: 1677.85 (r/w/o: 1175.23/334.81/167.80) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 5 tps: 86.40 qps: 1726.90 (r/w/o: 1208.60/345.60/172.70) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 5 tps: 88.40 qps: 1768.97 (r/w/o: 1238.48/353.59/176.90) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 5 tps: 81.80 qps: 1637.22 (r/w/o: 1146.22/327.40/163.60) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 5 tps: 90.20 qps: 1805.12 (r/w/o: 1262.61/362.20/180.30) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 5 tps: 89.50 qps: 1787.19 (r/w/o: 1251.69/356.40/179.10) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 5 tps: 89.10 qps: 1781.20 (r/w/o: 1246.60/356.40/178.20) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 5 tps: 88.10 qps: 1765.80 (r/w/o: 1235.60/354.00/176.20) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 5 tps: 85.99 qps: 1716.85 (r/w/o: 1202.50/342.37/171.99) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 5 tps: 94.31 qps: 1883.35 (r/w/o: 1317.51/377.23/188.62) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 5 tps: 84.90 qps: 1705.10 (r/w/o: 1194.03/341.28/169.79) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 5 tps: 87.71 qps: 1749.90 (r/w/o: 1225.37/349.12/175.41) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 5 tps: 87.90 qps: 1758.79 (r/w/o: 1231.19/351.80/175.80) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 5 tps: 91.10 qps: 1821.68 (r/w/o: 1275.29/364.20/182.20) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 5 tps: 92.40 qps: 1847.52 (r/w/o: 1293.12/369.60/184.80) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 5 tps: 88.50 qps: 1770.19 (r/w/o: 1238.79/354.40/177.00) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 5 tps: 92.10 qps: 1842.76 (r/w/o: 1290.47/368.09/184.20) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 5 tps: 96.40 qps: 1931.28 (r/w/o: 1351.25/387.22/192.81) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 5 tps: 94.90 qps: 1894.59 (r/w/o: 1326.89/377.90/189.80) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 5 tps: 82.90 qps: 1657.40 (r/w/o: 1160.00/331.60/165.80) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 5 tps: 92.80 qps: 1856.09 (r/w/o: 1299.29/371.20/185.60) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 5 tps: 82.30 qps: 1646.30 (r/w/o: 1152.50/329.20/164.60) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 5 tps: 79.40 qps: 1587.87 (r/w/o: 1110.98/318.09/158.80) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 5 tps: 90.60 qps: 1810.72 (r/w/o: 1267.22/362.30/181.20) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 5 tps: 82.20 qps: 1643.90 (r/w/o: 1151.10/328.40/164.40) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 5 tps: 88.40 qps: 1769.20 (r/w/o: 1238.80/353.60/176.80) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 5 tps: 80.50 qps: 1608.01 (r/w/o: 1125.00/322.00/161.00) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 5 tps: 88.20 qps: 1767.59 (r/w/o: 1237.99/353.20/176.40) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 5 tps: 83.20 qps: 1662.90 (r/w/o: 1164.10/332.40/166.40) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 5 tps: 87.40 qps: 1747.11 (r/w/o: 1222.70/349.60/174.80) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 5 tps: 97.00 qps: 1939.39 (r/w/o: 1357.19/388.20/194.00) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 5 tps: 85.50 qps: 1710.39 (r/w/o: 1197.39/342.00/171.00) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 5 tps: 81.30 qps: 1625.73 (r/w/o: 1137.92/325.21/162.60) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 5 tps: 90.50 qps: 1810.39 (r/w/o: 1267.60/361.80/181.00) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 5 tps: 91.90 qps: 1836.40 (r/w/o: 1285.00/367.60/183.80) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 5 tps: 84.50 qps: 1690.20 (r/w/o: 1183.20/338.00/169.00) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 5 tps: 91.30 qps: 1826.60 (r/w/o: 1278.80/365.20/182.60) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 5 tps: 90.00 qps: 1800.70 (r/w/o: 1260.50/360.20/180.00) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 5 tps: 90.09 qps: 1801.36 (r/w/o: 1261.00/360.17/180.19) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 5 tps: 90.11 qps: 1801.23 (r/w/o: 1260.59/360.43/180.21) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 5 tps: 84.00 qps: 1681.50 (r/w/o: 1177.50/336.00/168.00) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 5 tps: 86.20 qps: 1723.40 (r/w/o: 1206.20/344.80/172.40) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 5 tps: 86.20 qps: 1723.31 (r/w/o: 1206.10/344.80/172.40) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 5 tps: 88.09 qps: 1762.89 (r/w/o: 1234.32/352.38/176.19) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 5 tps: 82.60 qps: 1654.99 (r/w/o: 1158.16/331.62/165.21) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2461270
        write:                           703220
        other:                           351610
        total:                           3516100
    transactions:                        175805 (97.65 per sec.)
    queries:                             3516100 (1953.03 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.3249s
    total number of events:              175805

Latency (ms):
         min:                                    6.88
         avg:                                   51.19
         max:                                  506.86
         99th percentile:                      196.89
         sum:                              8999391.75

Threads fairness:
    events (avg/stddev):           35161.0000/44.56
    execution time (avg/stddev):   1799.8784/0.13



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 5427 | Waiting on empty queue | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |    0 | starting               | show processlist                                                                                     |
| 33 | sysbench        | 192.168.1.12:44919 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest8 WHERE id=2998904                                                               |
| 34 | sysbench        | 192.168.1.12:44918 | sbtest | Query   |    0 | updating               | UPDATE sbtest6 SET k=k+1 WHERE id=4364016                                                            |
| 35 | sysbench        | 192.168.1.12:44920 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest6 WHERE id=3008333                                                               |
| 36 | sysbench        | 192.168.1.12:44921 | sbtest | Query   |    0 | updating               | UPDATE sbtest6 SET c='1114971842-97755075453-93472963190-33789754139-24900223203-79093990853-129666' |
| 37 | sysbench        | 192.168.1.12:44930 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest3 WHERE id=1189810                                                               |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
7 rows in set (0.28 sec)




[coding001@voice mysql]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    1.43    3.00     0.10     0.11    96.61     0.04    9.35   23.02    2.83   0.65   0.29

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  952.00  658.00    47.98     8.27    71.55    12.01    7.53   12.22    0.73   0.60  97.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  694.00  441.00    47.84     6.11    97.34    15.44   13.38   21.36    0.80   0.87  98.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  829.00  523.00    48.03     7.37    83.92    14.24   10.73   17.02    0.76   0.73  98.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     4.00  808.00  638.00    48.00     9.08    80.84    10.58    7.25   12.34    0.81   0.68  97.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  765.00  538.00    47.95     7.01    86.39    10.80    8.31   13.62    0.76   0.76  98.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  712.00  405.00    48.10     6.24    99.62    20.41   18.20   28.10    0.80   0.88  98.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  737.00  529.00    47.96     7.09    89.07    15.47   12.26   20.57    0.68   0.78  98.40


[coding001@voice mysql]$ iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.42    0.00    0.63    0.12    0.00   98.83

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               4.44        98.05       116.38  796615362  945509024

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          15.01    0.00    8.91   55.47    0.00   20.61

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1435.00     48012.00      8352.00      48012       8352

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.29    0.00    8.42   60.20    0.00   17.09

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1384.00     50244.00      7728.00      50244       7728

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          15.23    0.00   10.66   54.06    0.00   20.05

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1327.00     49360.00      7136.00      49360       7136

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.58    0.00    9.69   54.34    0.00   19.39

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1511.00     48944.00      9304.00      48944       9304



[coding001@voice mysql]$ top
top - 15:46:30 up 94 days, 44 min,  4 users,  load average: 5.84, 5.03, 3.61
Tasks: 123 total,   2 running, 121 sleeping,   0 stopped,   0 zombie
%Cpu0  : 19.8 us, 10.9 sy,  0.0 ni, 18.8 id, 47.5 wa,  0.0 hi,  3.0 si,  0.0 st
%Cpu1  : 17.6 us,  6.9 sy,  0.0 ni, 11.8 id, 62.7 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu2  : 16.7 us,  7.8 sy,  0.0 ni, 26.5 id, 48.0 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu3  : 15.8 us,  7.9 sy,  0.0 ni, 19.8 id, 55.4 wa,  0.0 hi,  1.0 si,  0.0 st
KiB Mem : 16266300 total,   168744 free,  9876460 used,  6221096 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5332644 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
19543 mysql     20   0   11.0g   8.9g   3324 S  97.1 57.2  63:09.33 mysqld                                                                                                                                                                    
26302 coding0+  20   0  429528   4156   1084 S  16.3  0.0   1:55.68 sysbench                                                                                                                                                                  
12433 coding0+  20   0  174352  26924    608 S   2.9  0.2 206:18.56 skynet                          


[coding001@voice ~]$ tail -f sysbench_oltpX_5_.log
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 5 tps: 257.13 qps: 5149.81 (r/w/o: 3606.13/1028.92/514.76) lat (ms,99%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 5 tps: 95.51 qps: 1906.64 (r/w/o: 1334.00/381.63/191.01) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 5 tps: 92.09 qps: 1843.69 (r/w/o: 1290.32/369.18/184.19) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 5 tps: 113.41 qps: 2266.31 (r/w/o: 1586.68/452.82/226.81) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 5 tps: 117.50 qps: 2350.94 (r/w/o: 1645.63/470.41/234.90) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 5 tps: 130.09 qps: 2602.72 (r/w/o: 1822.40/520.04/260.27) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 5 tps: 119.91 qps: 2398.15 (r/w/o: 1678.38/479.95/239.83) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 5 tps: 110.80 qps: 2216.89 (r/w/o: 1552.10/443.20/221.60) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 5 tps: 106.60 qps: 2131.50 (r/w/o: 1492.10/426.20/213.20) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 5 tps: 115.10 qps: 2299.13 (r/w/o: 1608.72/460.21/230.20) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 5 tps: 107.10 qps: 2144.66 (r/w/o: 1501.87/428.59/214.20) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 5 tps: 99.70 qps: 1995.83 (r/w/o: 1397.12/399.31/199.40) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 5 tps: 114.60 qps: 2289.79 (r/w/o: 1602.70/457.90/229.20) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 5 tps: 107.20 qps: 2145.53 (r/w/o: 1501.75/429.39/214.39) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 5 tps: 113.50 qps: 2267.87 (r/w/o: 1587.65/453.21/227.01) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 5 tps: 127.50 qps: 2550.03 (r/w/o: 1784.65/510.39/254.99) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 5 tps: 133.60 qps: 2674.88 (r/w/o: 1872.66/535.02/267.21) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 5 tps: 130.30 qps: 2602.99 (r/w/o: 1822.19/520.20/260.60) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 5 tps: 131.80 qps: 2635.01 (r/w/o: 1843.81/527.60/263.60) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 5 tps: 132.60 qps: 2652.00 (r/w/o: 1856.80/530.00/265.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 5 tps: 109.99 qps: 2200.22 (r/w/o: 1540.27/439.96/219.98) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 5 tps: 124.51 qps: 2490.81 (r/w/o: 1743.74/498.04/249.02) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 5 tps: 139.20 qps: 2783.16 (r/w/o: 1947.87/556.89/278.40) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 5 tps: 137.40 qps: 2749.14 (r/w/o: 1924.83/549.51/274.80) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 5 tps: 138.40 qps: 2766.31 (r/w/o: 1935.91/553.60/276.80) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 5 tps: 140.70 qps: 2816.00 (r/w/o: 1971.40/563.20/281.40) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 5 tps: 134.40 qps: 2689.28 (r/w/o: 1882.88/537.60/268.80) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 5 tps: 140.40 qps: 2807.59 (r/w/o: 1965.59/561.20/280.80) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 5 tps: 125.20 qps: 2503.30 (r/w/o: 1751.90/501.00/250.40) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 5 tps: 138.20 qps: 2765.86 (r/w/o: 1935.87/553.59/276.40) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 5 tps: 129.20 qps: 2580.65 (r/w/o: 1806.43/515.81/258.40) lat (ms,99%): 147.61 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 5 tps: 123.00 qps: 2461.39 (r/w/o: 1723.19/492.20/246.00) lat (ms,99%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 5 tps: 115.60 qps: 2312.33 (r/w/o: 1618.92/462.21/231.20) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 5 tps: 114.79 qps: 2294.80 (r/w/o: 1605.96/459.26/229.58) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 5 tps: 118.01 qps: 2359.08 (r/w/o: 1651.03/472.04/236.02) lat (ms,99%): 134.90 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 5 tps: 124.70 qps: 2498.17 (r/w/o: 1749.38/499.39/249.40) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 5 tps: 105.00 qps: 2098.71 (r/w/o: 1468.61/420.10/210.00) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 5 tps: 111.40 qps: 2226.50 (r/w/o: 1558.70/445.00/222.80) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 5 tps: 100.40 qps: 2009.68 (r/w/o: 1406.29/402.60/200.80) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 5 tps: 114.10 qps: 2281.63 (r/w/o: 1597.72/455.71/228.20) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 5 tps: 108.70 qps: 2173.17 (r/w/o: 1521.08/434.69/217.40) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 5 tps: 110.90 qps: 2216.82 (r/w/o: 1551.61/443.40/221.80) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 5 tps: 109.40 qps: 2187.90 (r/w/o: 1531.70/437.40/218.80) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 5 tps: 119.40 qps: 2391.02 (r/w/o: 1673.42/478.80/238.80) lat (ms,99%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 5 tps: 107.00 qps: 2138.19 (r/w/o: 1497.29/426.90/214.00) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 5 tps: 103.30 qps: 2064.89 (r/w/o: 1445.20/413.10/206.60) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 5 tps: 109.30 qps: 2185.39 (r/w/o: 1529.59/437.20/218.60) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 5 tps: 107.00 qps: 2141.72 (r/w/o: 1499.72/428.00/214.00) lat (ms,99%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 5 tps: 107.70 qps: 2154.20 (r/w/o: 1507.70/431.10/215.40) lat (ms,99%): 150.29 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 5 tps: 106.30 qps: 2127.05 (r/w/o: 1488.66/425.79/212.59) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 5 tps: 106.60 qps: 2130.75 (r/w/o: 1492.04/425.51/213.21) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 5 tps: 102.60 qps: 2052.39 (r/w/o: 1436.69/410.50/205.20) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 5 tps: 98.70 qps: 1972.80 (r/w/o: 1380.70/394.70/197.40) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 5 tps: 102.60 qps: 2049.50 (r/w/o: 1433.90/410.40/205.20) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 5 tps: 104.50 qps: 2093.40 (r/w/o: 1466.40/418.00/209.00) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 5 tps: 99.00 qps: 1980.11 (r/w/o: 1385.31/396.80/198.00) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 5 tps: 96.30 qps: 1928.10 (r/w/o: 1350.60/384.90/192.60) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 5 tps: 104.60 qps: 2090.48 (r/w/o: 1462.59/418.70/209.20) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 5 tps: 97.60 qps: 1950.61 (r/w/o: 1365.81/389.60/195.20) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 5 tps: 95.30 qps: 1906.18 (r/w/o: 1334.18/381.40/190.60) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 5 tps: 90.90 qps: 1819.41 (r/w/o: 1274.11/363.50/181.80) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 5 tps: 90.90 qps: 1815.20 (r/w/o: 1269.90/363.50/181.80) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 5 tps: 95.20 qps: 1907.29 (r/w/o: 1336.09/380.80/190.40) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 5 tps: 93.40 qps: 1869.31 (r/w/o: 1307.71/374.80/186.80) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 5 tps: 104.80 qps: 2091.51 (r/w/o: 1463.91/418.00/209.60) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 5 tps: 92.00 qps: 1841.07 (r/w/o: 1288.98/368.09/184.00) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 5 tps: 92.10 qps: 1842.14 (r/w/o: 1289.63/368.31/184.20) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 5 tps: 97.00 qps: 1940.57 (r/w/o: 1358.18/388.39/194.00) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 5 tps: 82.50 qps: 1649.80 (r/w/o: 1155.20/329.60/165.00) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 5 tps: 91.60 qps: 1830.82 (r/w/o: 1281.21/366.40/183.20) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 5 tps: 91.00 qps: 1822.39 (r/w/o: 1276.20/364.20/182.00) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 5 tps: 94.50 qps: 1888.81 (r/w/o: 1321.71/378.10/189.00) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 5 tps: 91.50 qps: 1829.29 (r/w/o: 1280.60/365.70/183.00) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 5 tps: 104.90 qps: 2096.39 (r/w/o: 1466.99/419.60/209.80) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 5 tps: 97.70 qps: 1957.38 (r/w/o: 1370.78/391.20/195.40) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 5 tps: 95.40 qps: 1907.02 (r/w/o: 1334.61/381.60/190.80) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 5 tps: 93.60 qps: 1871.99 (r/w/o: 1310.79/374.00/187.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 5 tps: 91.20 qps: 1824.02 (r/w/o: 1276.81/364.80/182.40) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 5 tps: 95.40 qps: 1907.61 (r/w/o: 1334.81/382.00/190.80) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 5 tps: 91.10 qps: 1823.98 (r/w/o: 1276.79/365.00/182.20) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 5 tps: 89.40 qps: 1787.31 (r/w/o: 1251.31/357.20/178.80) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 5 tps: 99.70 qps: 1992.27 (r/w/o: 1394.68/398.19/199.40) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 5 tps: 91.30 qps: 1824.82 (r/w/o: 1277.01/365.20/182.60) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 5 tps: 85.80 qps: 1715.58 (r/w/o: 1200.79/343.20/171.60) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 5 tps: 82.20 qps: 1645.72 (r/w/o: 1152.32/329.00/164.40) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 5 tps: 90.30 qps: 1807.80 (r/w/o: 1266.00/361.20/180.60) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 5 tps: 90.90 qps: 1814.89 (r/w/o: 1269.69/363.40/181.80) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 5 tps: 85.70 qps: 1715.21 (r/w/o: 1200.90/342.90/171.40) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 5 tps: 91.20 qps: 1821.99 (r/w/o: 1274.89/364.70/182.40) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 5 tps: 91.40 qps: 1830.51 (r/w/o: 1282.11/365.60/182.80) lat (ms,99%): 176.73 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 5 tps: 89.30 qps: 1786.79 (r/w/o: 1250.69/357.50/178.60) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 5 tps: 96.60 qps: 1930.90 (r/w/o: 1351.50/386.20/193.20) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 5 tps: 92.10 qps: 1842.82 (r/w/o: 1290.31/368.30/184.20) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 5 tps: 90.70 qps: 1811.80 (r/w/o: 1267.60/362.80/181.40) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 5 tps: 93.00 qps: 1861.96 (r/w/o: 1303.97/371.99/186.00) lat (ms,99%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 5 tps: 78.60 qps: 1573.13 (r/w/o: 1101.42/314.51/157.20) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 5 tps: 95.50 qps: 1908.31 (r/w/o: 1335.31/382.00/191.00) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 5 tps: 85.50 qps: 1707.80 (r/w/o: 1194.90/341.90/171.00) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 5 tps: 88.69 qps: 1775.57 (r/w/o: 1243.41/354.77/177.39) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 5 tps: 95.41 qps: 1908.25 (r/w/o: 1335.81/381.63/190.82) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 5 tps: 82.90 qps: 1658.59 (r/w/o: 1161.19/331.60/165.80) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 5 tps: 87.30 qps: 1744.39 (r/w/o: 1220.59/349.20/174.60) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 5 tps: 87.90 qps: 1756.49 (r/w/o: 1229.09/351.60/175.80) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 5 tps: 82.00 qps: 1643.88 (r/w/o: 1151.79/328.10/164.00) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 5 tps: 81.20 qps: 1624.84 (r/w/o: 1137.53/324.91/162.40) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 5 tps: 90.80 qps: 1814.90 (r/w/o: 1270.30/363.00/181.60) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 5 tps: 85.89 qps: 1716.87 (r/w/o: 1201.11/343.97/171.79) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 5 tps: 82.00 qps: 1641.39 (r/w/o: 1148.96/328.42/164.01) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 5 tps: 78.80 qps: 1576.83 (r/w/o: 1104.72/314.51/157.60) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 5 tps: 73.70 qps: 1473.68 (r/w/o: 1031.58/294.70/147.40) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 5 tps: 77.90 qps: 1558.03 (r/w/o: 1090.52/311.71/155.80) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 5 tps: 72.20 qps: 1442.19 (r/w/o: 1009.09/288.70/144.40) lat (ms,99%): 244.38 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 5 tps: 79.20 qps: 1587.59 (r/w/o: 1110.80/318.40/158.40) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 5 tps: 84.70 qps: 1690.62 (r/w/o: 1183.92/337.30/169.40) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 5 tps: 89.60 qps: 1791.50 (r/w/o: 1254.00/358.30/179.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 5 tps: 81.80 qps: 1636.50 (r/w/o: 1145.70/327.20/163.60) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 5 tps: 79.60 qps: 1591.50 (r/w/o: 1113.90/318.40/159.20) lat (ms,99%): 231.53 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 5 tps: 89.40 qps: 1788.20 (r/w/o: 1251.80/357.60/178.80) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 5 tps: 81.70 qps: 1636.57 (r/w/o: 1146.18/326.99/163.40) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 5 tps: 89.70 qps: 1792.53 (r/w/o: 1254.52/358.61/179.40) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 5 tps: 80.90 qps: 1617.55 (r/w/o: 1132.16/323.59/161.79) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 5 tps: 83.50 qps: 1669.35 (r/w/o: 1168.33/334.01/167.00) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 5 tps: 80.70 qps: 1615.19 (r/w/o: 1130.99/322.80/161.40) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 5 tps: 85.00 qps: 1697.20 (r/w/o: 1187.20/340.00/170.00) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 5 tps: 84.00 qps: 1680.61 (r/w/o: 1176.61/336.00/168.00) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 5 tps: 83.10 qps: 1662.61 (r/w/o: 1163.80/332.60/166.20) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 5 tps: 81.00 qps: 1623.69 (r/w/o: 1136.89/324.80/162.00) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 5 tps: 89.60 qps: 1787.81 (r/w/o: 1251.21/357.40/179.20) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 5 tps: 84.00 qps: 1680.79 (r/w/o: 1176.79/336.00/168.00) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 5 tps: 92.40 qps: 1849.92 (r/w/o: 1295.51/369.60/184.80) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 5 tps: 87.70 qps: 1752.18 (r/w/o: 1225.89/350.90/175.40) lat (ms,99%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 5 tps: 85.60 qps: 1711.51 (r/w/o: 1198.01/342.30/171.20) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 5 tps: 94.10 qps: 1884.91 (r/w/o: 1319.71/377.00/188.20) lat (ms,99%): 223.34 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 5 tps: 82.50 qps: 1647.70 (r/w/o: 1153.30/329.40/165.00) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 5 tps: 89.20 qps: 1786.29 (r/w/o: 1250.69/357.20/178.40) lat (ms,99%): 167.44 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 5 tps: 88.40 qps: 1769.20 (r/w/o: 1238.40/354.00/176.80) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 5 tps: 79.00 qps: 1576.50 (r/w/o: 1103.10/315.40/158.00) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 5 tps: 93.50 qps: 1872.97 (r/w/o: 1311.18/374.79/187.00) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 5 tps: 87.39 qps: 1743.58 (r/w/o: 1219.81/348.98/174.79) lat (ms,99%): 161.51 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 5 tps: 93.01 qps: 1861.15 (r/w/o: 1303.50/371.63/186.01) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 5 tps: 89.10 qps: 1782.71 (r/w/o: 1247.71/356.80/178.20) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 5 tps: 81.70 qps: 1634.31 (r/w/o: 1144.51/326.40/163.40) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 5 tps: 87.90 qps: 1759.36 (r/w/o: 1231.67/351.89/175.80) lat (ms,99%): 193.38 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 5 tps: 80.50 qps: 1609.01 (r/w/o: 1126.31/321.70/161.00) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 5 tps: 86.60 qps: 1731.02 (r/w/o: 1211.21/346.60/173.20) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 5 tps: 88.80 qps: 1776.19 (r/w/o: 1243.60/355.00/177.60) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 5 tps: 88.80 qps: 1778.89 (r/w/o: 1245.29/356.00/177.60) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 5 tps: 90.60 qps: 1807.12 (r/w/o: 1264.31/361.60/181.20) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 5 tps: 84.10 qps: 1683.50 (r/w/o: 1178.90/336.40/168.20) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 5 tps: 84.30 qps: 1686.20 (r/w/o: 1180.00/337.60/168.60) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 5 tps: 81.60 qps: 1631.70 (r/w/o: 1142.20/326.30/163.20) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 5 tps: 87.70 qps: 1753.37 (r/w/o: 1227.08/350.89/175.40) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 5 tps: 85.90 qps: 1721.24 (r/w/o: 1205.06/344.39/171.79) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 5 tps: 86.40 qps: 1726.37 (r/w/o: 1208.35/345.21/172.81) lat (ms,99%): 200.47 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 5 tps: 88.80 qps: 1775.81 (r/w/o: 1243.41/354.80/177.60) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 5 tps: 83.10 qps: 1662.50 (r/w/o: 1164.20/332.10/166.20) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 5 tps: 86.30 qps: 1724.40 (r/w/o: 1206.70/345.10/172.60) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 5 tps: 89.50 qps: 1792.64 (r/w/o: 1254.75/358.89/178.99) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 5 tps: 84.80 qps: 1692.94 (r/w/o: 1185.03/338.31/169.60) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 5 tps: 81.60 qps: 1634.00 (r/w/o: 1144.40/326.40/163.20) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 5 tps: 80.29 qps: 1607.10 (r/w/o: 1124.93/321.58/160.59) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 5 tps: 90.90 qps: 1816.28 (r/w/o: 1271.25/363.22/181.81) lat (ms,99%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 5 tps: 78.10 qps: 1559.84 (r/w/o: 1091.23/312.41/156.20) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 5 tps: 88.30 qps: 1769.41 (r/w/o: 1239.20/353.60/176.60) lat (ms,99%): 211.60 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 5 tps: 89.80 qps: 1795.92 (r/w/o: 1257.11/359.20/179.60) lat (ms,99%): 183.21 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 5 tps: 77.60 qps: 1549.68 (r/w/o: 1084.39/310.10/155.20) lat (ms,99%): 240.02 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 5 tps: 76.20 qps: 1527.19 (r/w/o: 1069.69/305.10/152.40) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 5 tps: 83.00 qps: 1661.08 (r/w/o: 1161.89/333.20/166.00) lat (ms,99%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 5 tps: 93.80 qps: 1873.04 (r/w/o: 1311.43/374.01/187.60) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 5 tps: 87.40 qps: 1748.11 (r/w/o: 1224.10/349.20/174.80) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 5 tps: 90.50 qps: 1808.00 (r/w/o: 1265.00/362.00/181.00) lat (ms,99%): 204.11 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 5 tps: 90.40 qps: 1808.21 (r/w/o: 1265.81/361.60/180.80) lat (ms,99%): 179.94 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 5 tps: 84.00 qps: 1682.55 (r/w/o: 1178.17/336.39/168.00) lat (ms,99%): 253.35 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 5 tps: 86.30 qps: 1726.53 (r/w/o: 1209.12/344.81/172.60) lat (ms,99%): 196.89 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 5 tps: 86.10 qps: 1724.43 (r/w/o: 1206.42/345.81/172.20) lat (ms,99%): 189.93 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 5 tps: 87.80 qps: 1754.39 (r/w/o: 1228.19/350.60/175.60) lat (ms,99%): 231.53 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 5 tps: 85.90 qps: 1719.20 (r/w/o: 1203.70/343.70/171.80) lat (ms,99%): 219.36 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 5 tps: 83.60 qps: 1670.40 (r/w/o: 1168.90/334.30/167.20) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 5 tps: 99.20 qps: 1982.39 (r/w/o: 1387.89/396.10/198.40) lat (ms,99%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 5 tps: 81.80 qps: 1635.81 (r/w/o: 1144.90/327.30/163.60) lat (ms,99%): 186.54 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2455600
        write:                           701600
        other:                           350800
        total:                           3508000
    transactions:                        175400 (97.43 per sec.)
    queries:                             3508000 (1948.58 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.2806s
    total number of events:              175400

Latency (ms):
         min:                                    7.06
         avg:                                   51.31
         max:                                  715.97
         99th percentile:                      196.89
         sum:                              8999576.08

Threads fairness:
    events (avg/stddev):           35080.0000/59.13
    execution time (avg/stddev):   1799.9152/0.10






