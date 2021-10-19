


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

show global variables like '%sync_binlog%';
show global variables like '%innodb_flush_log_at_trx_commit%';

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
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_10_not11_.log &



如何测试写的性能？



innodb_log_file_size*innodb_log_files_in_group - (Log flushed up to-Last checkpoint at)
 
---
LOG
---
Log sequence number 156022292410
Log flushed up to   156022118021
Pages flushed up to 155991906715
Last checkpoint at  155991826018
0 pending log flushes, 0 pending chkp writes
12924 log i/o's done, 78.29 log i/o's/second
 
 

mysql> show global variables like '%innodb_log_file%';
+---------------------------+------------+
| Variable_name             | Value      |
+---------------------------+------------+
| innodb_log_file_size      | 1073741824 |
| innodb_log_files_in_group | 3          |
+---------------------------+------------+
2 rows in set (0.07 sec)


SELECT (1073741824*3)-(156022118021-155991826018) = 3190933469 byte = 3043 MB

select 1024*3 = 3072 MB



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  |  509 | Waiting on empty queue | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |    0 | starting               | show processlist                                                                                     |
|  4 | sysbench        | 192.168.1.12:43284 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest3 WHERE id=1076380                                                               |
|  5 | sysbench        | 192.168.1.12:43285 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest7 WHERE id BETWEEN 3287169 AND 3287268                                           |
|  6 | sysbench        | 192.168.1.12:43292 | sbtest | Query   |    0 | statistics             | SELECT SUM(K) FROM sbtest6 WHERE id BETWEEN 105060 AND 105159                                        |
|  7 | sysbench        | 192.168.1.12:43296 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest10 WHERE id=2213663                                                              |
|  8 | sysbench        | 192.168.1.12:43294 | sbtest | Query   |    0 | updating               | UPDATE sbtest9 SET c='76709036655-74381164697-77116823599-42207677411-16939000993-52028440822-580328 |
|  9 | sysbench        | 192.168.1.12:43286 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest5 WHERE id BETWEEN 4440449 AND 4440548 ORDER BY c                                |
| 10 | sysbench        | 192.168.1.12:43300 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest8 WHERE id=4946138                                                               |
| 11 | sysbench        | 192.168.1.12:43302 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest9 WHERE id=3294720                                                               |
| 12 | sysbench        | 192.168.1.12:43304 | sbtest | Query   |    0 | updating               | UPDATE sbtest3 SET c='38469238726-31541537144-67692240932-36924100937-37318771937-55254667167-229782 |
| 13 | sysbench        | 192.168.1.12:43298 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest4 WHERE id=4968540                                                               |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
12 rows in set (0.27 sec)



[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    0.84    2.71     0.06     0.08    81.55     0.03    8.32   26.07    2.84   0.61   0.21

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00 1038.00  119.00    48.01     5.03    93.88    15.71   13.43   14.84    1.06   0.85  98.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  904.00  131.00    48.01     4.87   104.63    20.23   19.18   21.84    0.88   0.96  99.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  859.00  124.00    48.01     4.66   109.74    20.45   21.37   24.27    1.26   1.01  99.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  899.00  129.00    48.05     5.04   105.77    20.44   18.39   20.87    1.12   0.97  99.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  827.00  115.00    47.97     4.64   114.39    21.42   23.94   27.13    0.99   1.06  99.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  934.00  127.00    48.00     4.97   102.24    22.06   21.06   23.76    1.20   0.94  99.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  926.00  137.00    47.99     7.11   106.16    19.48   18.36   20.90    1.20   0.94  99.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  802.00   80.00    48.00     4.15   121.10    19.05   21.68   23.72    1.23   1.13  99.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  935.00  182.00    47.98     6.10    99.16    19.12   16.52   19.53    1.09   0.89  99.00



[coding001@voice ~]$ iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.40    0.00    0.63    0.08    0.00   98.90

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               3.55        58.39        86.18  473410074  698730320

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          19.80    0.00   10.41   65.99    0.00    3.81

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1202.00     49168.00     11348.00      49168      11348

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          17.22    0.00    9.87   69.62    0.00    3.29

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1181.00     49104.00     12668.00      49104      12668

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.76    0.00    8.91   74.55    0.00    1.78

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             931.00     49124.00      6380.00      49124       6380

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          17.77    0.00   10.66   68.27    0.00    3.30

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1040.00     49272.00      8588.00      49272       8588

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          20.30    0.00   10.15   63.45    0.00    6.09

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1255.00     49136.00      9596.00      49136       9596


[coding001@voice ~]$ top
top - 11:19:48 up 93 days, 20:18,  4 users,  load average: 11.04, 11.12, 9.24
Tasks: 121 total,   1 running, 120 sleeping,   0 stopped,   0 zombie
%Cpu0  : 17.1 us,  7.2 sy,  0.0 ni,  2.4 id, 70.6 wa,  0.0 hi,  2.7 si,  0.0 st
%Cpu1  : 17.3 us,  7.8 sy,  0.0 ni, 12.2 id, 61.7 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu2  : 15.4 us,  8.4 sy,  0.0 ni,  6.0 id, 69.2 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu3  : 16.8 us,  8.1 sy,  0.0 ni,  4.0 id, 70.0 wa,  0.0 hi,  1.0 si,  0.0 st
KiB Mem : 16266300 total,   164128 free,  9823456 used,  6278716 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5394112 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 1583 mysql     20   0   11.2g   8.8g   4440 S  90.3 56.9  19:39.89 mysqld                                                                                                                                                                    
 1708 coding0+  20   0  759788   6200   1268 S  14.3  0.0   3:03.51 sysbench      
 
 
 
[coding001@voice ~]$ tail -f sysbench_oltpX_10_not11_.log 
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 10 tps: 125.67 qps: 2523.81 (r/w/o: 1768.48/502.98/252.34) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 10 tps: 43.00 qps: 858.22 (r/w/o: 600.51/171.70/86.00) lat (ms,99%): 569.67 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 10 tps: 45.00 qps: 899.20 (r/w/o: 629.10/180.10/90.00) lat (ms,99%): 634.66 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 10 tps: 38.80 qps: 779.09 (r/w/o: 546.29/155.20/77.60) lat (ms,99%): 802.05 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 10 tps: 48.20 qps: 963.62 (r/w/o: 674.31/192.90/96.40) lat (ms,99%): 601.29 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 10 tps: 44.50 qps: 887.59 (r/w/o: 620.79/177.80/89.00) lat (ms,99%): 646.19 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 10 tps: 45.40 qps: 911.19 (r/w/o: 638.49/181.90/90.80) lat (ms,99%): 569.67 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 10 tps: 46.10 qps: 922.32 (r/w/o: 645.91/184.20/92.20) lat (ms,99%): 669.89 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 10 tps: 49.10 qps: 978.60 (r/w/o: 684.10/196.30/98.20) lat (ms,99%): 580.02 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 10 tps: 53.80 qps: 1076.60 (r/w/o: 753.80/215.20/107.60) lat (ms,99%): 601.29 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 10 tps: 64.30 qps: 1285.80 (r/w/o: 900.00/257.20/128.60) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 10 tps: 62.60 qps: 1252.76 (r/w/o: 877.07/250.49/125.20) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 10 tps: 82.50 qps: 1646.80 (r/w/o: 1151.90/329.90/165.00) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 10 tps: 74.70 qps: 1496.35 (r/w/o: 1048.03/298.91/149.40) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 10 tps: 89.20 qps: 1786.67 (r/w/o: 1251.38/356.89/178.40) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 10 tps: 88.10 qps: 1761.12 (r/w/o: 1232.61/352.30/176.20) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 10 tps: 93.10 qps: 1860.20 (r/w/o: 1301.70/372.30/186.20) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 10 tps: 88.50 qps: 1770.10 (r/w/o: 1239.00/354.10/177.00) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 10 tps: 77.40 qps: 1549.70 (r/w/o: 1085.10/309.80/154.80) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 10 tps: 70.50 qps: 1410.61 (r/w/o: 987.40/282.20/141.00) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 10 tps: 65.90 qps: 1315.20 (r/w/o: 920.30/263.10/131.80) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 10 tps: 64.50 qps: 1291.00 (r/w/o: 904.00/258.00/129.00) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 10 tps: 64.70 qps: 1297.09 (r/w/o: 908.69/259.00/129.40) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 10 tps: 62.80 qps: 1254.09 (r/w/o: 876.99/251.50/125.60) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 10 tps: 58.00 qps: 1159.23 (r/w/o: 811.52/231.71/116.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 10 tps: 60.70 qps: 1216.39 (r/w/o: 851.70/243.30/121.40) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 10 tps: 73.90 qps: 1476.96 (r/w/o: 1033.97/295.19/147.80) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 10 tps: 73.40 qps: 1466.93 (r/w/o: 1026.42/293.71/146.80) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 10 tps: 88.70 qps: 1773.57 (r/w/o: 1241.48/354.69/177.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 10 tps: 100.70 qps: 2017.47 (r/w/o: 1413.18/402.89/201.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 10 tps: 106.50 qps: 2130.72 (r/w/o: 1491.72/426.00/213.00) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 10 tps: 111.79 qps: 2229.46 (r/w/o: 1559.10/446.77/223.59) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 10 tps: 114.01 qps: 2281.40 (r/w/o: 1597.34/456.04/228.02) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 10 tps: 110.40 qps: 2207.70 (r/w/o: 1545.30/441.60/220.80) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 10 tps: 99.60 qps: 1994.40 (r/w/o: 1396.40/398.80/199.20) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 10 tps: 111.30 qps: 2227.42 (r/w/o: 1560.01/444.80/222.60) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 10 tps: 111.70 qps: 2231.37 (r/w/o: 1561.18/446.79/223.40) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 10 tps: 130.00 qps: 2601.29 (r/w/o: 1821.09/520.20/260.00) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 10 tps: 138.00 qps: 2759.71 (r/w/o: 1931.51/552.20/276.00) lat (ms,99%): 244.38 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 10 tps: 123.30 qps: 2464.01 (r/w/o: 1724.41/493.00/246.60) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 10 tps: 132.70 qps: 2655.39 (r/w/o: 1859.29/530.70/265.40) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 10 tps: 131.70 qps: 2633.51 (r/w/o: 1843.41/526.70/263.40) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 10 tps: 128.90 qps: 2579.12 (r/w/o: 1805.74/515.58/257.79) lat (ms,99%): 231.53 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 10 tps: 129.30 qps: 2583.60 (r/w/o: 1807.37/517.62/258.61) lat (ms,99%): 215.44 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 10 tps: 122.39 qps: 2449.05 (r/w/o: 1715.09/489.17/244.78) lat (ms,99%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 10 tps: 119.31 qps: 2385.54 (r/w/o: 1669.60/477.33/238.61) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 10 tps: 119.10 qps: 2381.80 (r/w/o: 1667.20/476.40/238.20) lat (ms,99%): 240.02 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 10 tps: 123.69 qps: 2476.62 (r/w/o: 1734.47/494.76/247.38) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 10 tps: 106.31 qps: 2125.06 (r/w/o: 1487.01/425.43/212.62) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 10 tps: 115.30 qps: 2306.60 (r/w/o: 1615.10/460.90/230.60) lat (ms,99%): 235.74 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 10 tps: 110.70 qps: 2213.27 (r/w/o: 1548.88/442.99/221.40) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 10 tps: 111.10 qps: 2221.91 (r/w/o: 1555.41/444.30/222.20) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 10 tps: 101.20 qps: 2026.80 (r/w/o: 1419.30/405.10/202.40) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 10 tps: 110.90 qps: 2213.01 (r/w/o: 1548.01/443.20/221.80) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 10 tps: 116.50 qps: 2333.81 (r/w/o: 1634.61/466.20/233.00) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 10 tps: 112.80 qps: 2254.56 (r/w/o: 1577.77/451.19/225.60) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 10 tps: 118.20 qps: 2362.29 (r/w/o: 1652.79/473.10/236.40) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 10 tps: 116.60 qps: 2333.26 (r/w/o: 1633.75/466.31/233.21) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 10 tps: 122.00 qps: 2440.58 (r/w/o: 1708.99/487.60/244.00) lat (ms,99%): 227.40 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 10 tps: 106.10 qps: 2120.98 (r/w/o: 1484.38/424.40/212.20) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 10 tps: 111.50 qps: 2228.19 (r/w/o: 1559.19/446.00/223.00) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 10 tps: 110.00 qps: 2200.02 (r/w/o: 1540.01/440.00/220.00) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 10 tps: 105.80 qps: 2119.12 (r/w/o: 1483.91/423.60/211.60) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 10 tps: 111.90 qps: 2239.10 (r/w/o: 1567.70/447.60/223.80) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 10 tps: 107.70 qps: 2154.99 (r/w/o: 1508.89/430.70/215.40) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 10 tps: 110.20 qps: 2200.95 (r/w/o: 1539.87/440.69/220.40) lat (ms,99%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 10 tps: 109.30 qps: 2186.46 (r/w/o: 1530.84/437.01/218.61) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 10 tps: 107.20 qps: 2144.89 (r/w/o: 1501.09/429.40/214.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 10 tps: 99.00 qps: 1977.71 (r/w/o: 1384.31/395.40/198.00) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 10 tps: 99.70 qps: 1995.80 (r/w/o: 1397.30/399.10/199.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 10 tps: 107.80 qps: 2157.79 (r/w/o: 1511.00/431.20/215.60) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 10 tps: 96.40 qps: 1927.90 (r/w/o: 1349.40/385.70/192.80) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 10 tps: 99.70 qps: 1990.96 (r/w/o: 1393.17/398.39/199.40) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 10 tps: 92.10 qps: 1843.54 (r/w/o: 1290.73/368.61/184.20) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 10 tps: 97.10 qps: 1939.99 (r/w/o: 1357.60/388.20/194.20) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 10 tps: 104.10 qps: 2085.02 (r/w/o: 1460.11/416.70/208.20) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 10 tps: 106.30 qps: 2127.09 (r/w/o: 1489.59/424.90/212.60) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 10 tps: 96.90 qps: 1934.50 (r/w/o: 1352.80/387.90/193.80) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 10 tps: 111.60 qps: 2230.19 (r/w/o: 1560.70/446.30/223.20) lat (ms,99%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 10 tps: 106.10 qps: 2121.98 (r/w/o: 1485.59/424.20/212.20) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 10 tps: 102.10 qps: 2048.21 (r/w/o: 1435.61/408.40/204.20) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 10 tps: 107.60 qps: 2146.91 (r/w/o: 1501.11/430.60/215.20) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 10 tps: 103.00 qps: 2059.99 (r/w/o: 1441.99/412.00/206.00) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 10 tps: 102.00 qps: 2042.28 (r/w/o: 1430.39/407.90/204.00) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 10 tps: 97.80 qps: 1955.81 (r/w/o: 1369.00/391.20/195.60) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 10 tps: 86.90 qps: 1736.31 (r/w/o: 1214.90/347.60/173.80) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 10 tps: 85.70 qps: 1716.00 (r/w/o: 1201.60/343.00/171.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 10 tps: 102.40 qps: 2047.17 (r/w/o: 1432.88/409.49/204.80) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 10 tps: 98.20 qps: 1962.53 (r/w/o: 1373.52/392.61/196.40) lat (ms,99%): 262.64 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 10 tps: 92.20 qps: 1844.90 (r/w/o: 1291.50/369.00/184.40) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 10 tps: 88.70 qps: 1773.10 (r/w/o: 1241.00/354.70/177.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 10 tps: 91.10 qps: 1825.71 (r/w/o: 1278.81/364.70/182.20) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 10 tps: 99.70 qps: 1994.10 (r/w/o: 1395.60/399.10/199.40) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 10 tps: 90.20 qps: 1801.10 (r/w/o: 1260.60/360.10/180.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 10 tps: 101.80 qps: 2036.29 (r/w/o: 1425.49/407.20/203.60) lat (ms,99%): 257.95 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 10 tps: 89.70 qps: 1793.69 (r/w/o: 1255.49/358.80/179.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 10 tps: 86.70 qps: 1735.11 (r/w/o: 1214.51/347.20/173.40) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 10 tps: 84.50 qps: 1689.88 (r/w/o: 1183.08/337.80/169.00) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 10 tps: 95.90 qps: 1918.91 (r/w/o: 1343.71/383.40/191.80) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 10 tps: 88.90 qps: 1777.02 (r/w/o: 1243.42/355.80/177.80) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 10 tps: 92.50 qps: 1851.06 (r/w/o: 1295.37/370.69/185.00) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 10 tps: 100.30 qps: 2004.62 (r/w/o: 1403.41/400.60/200.60) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 10 tps: 95.30 qps: 1904.71 (r/w/o: 1333.00/381.10/190.60) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 10 tps: 87.49 qps: 1753.19 (r/w/o: 1227.52/350.68/174.99) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 10 tps: 86.00 qps: 1717.79 (r/w/o: 1202.57/343.22/172.01) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 10 tps: 94.30 qps: 1885.62 (r/w/o: 1319.91/377.10/188.60) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 10 tps: 88.39 qps: 1767.97 (r/w/o: 1237.21/353.97/176.79) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 10 tps: 91.91 qps: 1836.83 (r/w/o: 1285.79/367.23/183.81) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 10 tps: 85.30 qps: 1710.81 (r/w/o: 1198.31/341.90/170.60) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 10 tps: 84.60 qps: 1685.59 (r/w/o: 1178.80/337.70/169.10) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 10 tps: 91.20 qps: 1829.01 (r/w/o: 1281.41/365.10/182.50) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 10 tps: 95.50 qps: 1910.99 (r/w/o: 1338.09/381.90/191.00) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 10 tps: 87.50 qps: 1746.91 (r/w/o: 1221.91/350.00/175.00) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 10 tps: 90.50 qps: 1810.91 (r/w/o: 1267.91/362.00/181.00) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 10 tps: 90.30 qps: 1804.68 (r/w/o: 1263.08/361.00/180.60) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 10 tps: 81.00 qps: 1618.62 (r/w/o: 1132.61/324.00/162.00) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 10 tps: 84.10 qps: 1684.10 (r/w/o: 1179.40/336.50/168.20) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 10 tps: 80.80 qps: 1618.29 (r/w/o: 1133.39/323.30/161.60) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 10 tps: 92.60 qps: 1849.51 (r/w/o: 1293.91/370.50/185.10) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 10 tps: 95.10 qps: 1901.68 (r/w/o: 1331.08/380.30/190.30) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 10 tps: 87.30 qps: 1747.30 (r/w/o: 1223.70/349.00/174.60) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 10 tps: 95.70 qps: 1911.31 (r/w/o: 1337.10/382.80/191.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 10 tps: 84.30 qps: 1688.00 (r/w/o: 1182.10/337.30/168.60) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 10 tps: 84.09 qps: 1683.48 (r/w/o: 1179.02/336.28/168.19) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 10 tps: 88.51 qps: 1767.53 (r/w/o: 1236.49/354.03/177.01) lat (ms,99%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 10 tps: 85.50 qps: 1711.47 (r/w/o: 1198.38/342.09/171.00) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 10 tps: 93.00 qps: 1859.54 (r/w/o: 1301.43/372.11/186.00) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 10 tps: 88.80 qps: 1773.99 (r/w/o: 1241.19/355.20/177.60) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 10 tps: 88.00 qps: 1760.70 (r/w/o: 1232.70/352.00/176.00) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 10 tps: 91.30 qps: 1825.19 (r/w/o: 1277.39/365.20/182.60) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 10 tps: 95.70 qps: 1916.72 (r/w/o: 1342.32/383.00/191.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 10 tps: 91.80 qps: 1836.11 (r/w/o: 1285.61/366.90/183.60) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 10 tps: 87.50 qps: 1750.09 (r/w/o: 1224.89/350.20/175.00) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 10 tps: 84.10 qps: 1680.21 (r/w/o: 1175.90/336.10/168.20) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 10 tps: 86.30 qps: 1726.60 (r/w/o: 1208.80/345.20/172.60) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 10 tps: 89.90 qps: 1802.70 (r/w/o: 1263.00/359.90/179.80) lat (ms,99%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 10 tps: 81.50 qps: 1625.59 (r/w/o: 1136.69/325.90/163.00) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 10 tps: 94.20 qps: 1884.52 (r/w/o: 1319.11/377.00/188.40) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 10 tps: 86.00 qps: 1718.57 (r/w/o: 1202.98/343.59/172.00) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 10 tps: 85.20 qps: 1703.93 (r/w/o: 1192.62/340.91/170.40) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 10 tps: 83.90 qps: 1677.29 (r/w/o: 1173.99/335.50/167.80) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 10 tps: 90.80 qps: 1818.89 (r/w/o: 1273.80/363.50/181.60) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 10 tps: 88.10 qps: 1763.20 (r/w/o: 1234.70/352.30/176.20) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 10 tps: 89.10 qps: 1781.01 (r/w/o: 1246.51/356.30/178.20) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 10 tps: 82.80 qps: 1655.89 (r/w/o: 1158.90/331.40/165.60) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 10 tps: 86.50 qps: 1731.61 (r/w/o: 1212.70/345.90/173.00) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 10 tps: 84.40 qps: 1681.41 (r/w/o: 1175.21/337.40/168.80) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 10 tps: 79.20 qps: 1588.04 (r/w/o: 1112.56/317.09/158.39) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 10 tps: 83.20 qps: 1666.93 (r/w/o: 1167.82/332.71/166.40) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 10 tps: 91.00 qps: 1817.03 (r/w/o: 1270.92/364.11/182.00) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 10 tps: 86.90 qps: 1737.51 (r/w/o: 1216.21/347.50/173.80) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 10 tps: 83.90 qps: 1678.98 (r/w/o: 1175.59/335.60/167.80) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 10 tps: 88.20 qps: 1763.82 (r/w/o: 1234.51/352.90/176.40) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 10 tps: 87.70 qps: 1751.59 (r/w/o: 1225.69/350.50/175.40) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 10 tps: 80.10 qps: 1603.12 (r/w/o: 1122.31/320.60/160.20) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 10 tps: 84.00 qps: 1682.69 (r/w/o: 1178.10/336.60/168.00) lat (ms,99%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 10 tps: 82.10 qps: 1641.86 (r/w/o: 1149.87/327.79/164.20) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 10 tps: 92.30 qps: 1844.72 (r/w/o: 1291.02/369.10/184.60) lat (ms,99%): 272.27 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 10 tps: 83.90 qps: 1676.10 (r/w/o: 1172.80/335.50/167.80) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 10 tps: 94.10 qps: 1885.81 (r/w/o: 1320.90/376.70/188.20) lat (ms,99%): 292.60 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 10 tps: 87.30 qps: 1741.69 (r/w/o: 1218.19/348.90/174.60) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 10 tps: 95.59 qps: 1914.98 (r/w/o: 1341.12/382.68/191.19) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 10 tps: 86.21 qps: 1722.64 (r/w/o: 1205.40/344.83/172.41) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 10 tps: 91.60 qps: 1831.39 (r/w/o: 1282.09/366.10/183.20) lat (ms,99%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 10 tps: 88.10 qps: 1766.41 (r/w/o: 1237.31/352.90/176.20) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 10 tps: 85.20 qps: 1700.39 (r/w/o: 1189.69/340.30/170.40) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 10 tps: 90.70 qps: 1815.60 (r/w/o: 1271.00/363.20/181.40) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 10 tps: 82.70 qps: 1654.39 (r/w/o: 1158.29/330.70/165.40) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 10 tps: 84.00 qps: 1678.10 (r/w/o: 1174.40/335.70/168.00) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 10 tps: 76.30 qps: 1526.32 (r/w/o: 1068.41/305.30/152.60) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 10 tps: 88.70 qps: 1776.69 (r/w/o: 1244.19/355.10/177.40) lat (ms,99%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 10 tps: 90.90 qps: 1813.79 (r/w/o: 1268.79/363.20/181.80) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 10 tps: 90.90 qps: 1818.51 (r/w/o: 1273.11/363.60/181.80) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 10 tps: 93.10 qps: 1860.10 (r/w/o: 1301.50/372.40/186.20) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 10 tps: 91.60 qps: 1834.90 (r/w/o: 1285.30/366.40/183.20) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 10 tps: 80.60 qps: 1611.90 (r/w/o: 1128.10/322.60/161.20) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 10 tps: 86.10 qps: 1720.70 (r/w/o: 1204.10/344.40/172.20) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 10 tps: 87.50 qps: 1750.09 (r/w/o: 1225.29/349.80/175.00) lat (ms,99%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 10 tps: 85.10 qps: 1700.60 (r/w/o: 1190.00/340.40/170.20) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 10 tps: 92.50 qps: 1852.40 (r/w/o: 1297.20/370.20/185.00) lat (ms,99%): 303.33 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2321480
        write:                           663280
        other:                           331640
        total:                           3316400
    transactions:                        165820 (92.10 per sec.)
    queries:                             3316400 (1841.97 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.4642s
    total number of events:              165820

Latency (ms):
         min:                                    3.82
         avg:                                  108.56
         max:                                  917.83
         99th percentile:                      369.77
         sum:                             18000590.78

Threads fairness:
    events (avg/stddev):           16582.0000/35.47
    execution time (avg/stddev):   1800.0591/0.14




 