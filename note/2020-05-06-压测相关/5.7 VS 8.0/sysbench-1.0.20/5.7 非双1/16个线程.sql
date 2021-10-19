


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
--num-threads=16 \
--oltp-table-size=5000000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=1800 \
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_16_not16_.log &




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
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time  | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 10027 | Waiting on empty queue | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |     0 | starting               | show processlist                                                                                     |
| 40 | sysbench        | 192.168.1.12:45414 | sbtest | Query   |     0 | updating               | DELETE FROM sbtest2 WHERE id=4172988                                                                 |
| 41 | sysbench        | 192.168.1.12:45415 | sbtest | Query   |     0 | statistics             | SELECT c FROM sbtest2 WHERE id=672994                                                                |
| 42 | sysbench        | 192.168.1.12:45426 | sbtest | Query   |     0 | updating               | UPDATE sbtest10 SET c='86854380877-25201467547-57066014774-80337920436-11455633596-90973791626-78681 |
| 43 | sysbench        | 192.168.1.12:45413 | sbtest | Query   |     0 | updating               | DELETE FROM sbtest10 WHERE id=4684779                                                                |
| 44 | sysbench        | 192.168.1.12:45412 | sbtest | Query   |     0 | statistics             | SELECT c FROM sbtest2 WHERE id=3832631                                                               |
| 45 | sysbench        | 192.168.1.12:45424 | sbtest | Query   |     0 | statistics             | SELECT c FROM sbtest1 WHERE id=3016607                                                               |
| 46 | sysbench        | 192.168.1.12:45428 | sbtest | Query   |     0 | statistics             | SELECT SUM(K) FROM sbtest2 WHERE id BETWEEN 4481106 AND 4481205                                      |
| 47 | sysbench        | 192.168.1.12:45434 | sbtest | Query   |     0 | statistics             | SELECT c FROM sbtest3 WHERE id=69705                                                                 |
| 48 | sysbench        | 192.168.1.12:45432 | sbtest | Query   |     0 | updating               | UPDATE sbtest10 SET c='58979648458-91353972482-53289892782-25142596806-82143182824-26662037267-63887 |
| 49 | sysbench        | 192.168.1.12:45436 | sbtest | Query   |     0 | statistics             | SELECT c FROM sbtest1 WHERE id BETWEEN 2026517 AND 2026616                                           |
| 50 | sysbench        | 192.168.1.12:45438 | sbtest | Query   |     0 | Creating sort index    | SELECT c FROM sbtest2 WHERE id BETWEEN 3441949 AND 3442048 ORDER BY c                                |
| 51 | sysbench        | 192.168.1.12:45430 | sbtest | Query   |     0 | updating               | UPDATE sbtest3 SET k=k+1 WHERE id=1129138                                                            |
| 52 | sysbench        | 192.168.1.12:45440 | sbtest | Query   |     0 | statistics             | SELECT DISTINCT c FROM sbtest2 WHERE id BETWEEN 2067680 AND 2067779 ORDER BY c                       |
| 53 | sysbench        | 192.168.1.12:45442 | sbtest | Query   |     0 | statistics             | SELECT c FROM sbtest10 WHERE id BETWEEN 1913454 AND 1913553                                          |
| 54 | sysbench        | 192.168.1.12:45444 | sbtest | Query   |     0 | statistics             | SELECT c FROM sbtest1 WHERE id=1962443                                                               |
| 55 | sysbench        | 192.168.1.12:45446 | sbtest | Query   |     0 | statistics             | SELECT c FROM sbtest3 WHERE id=993116                                                                |
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
18 rows in set (0.00 sec)


2021-10-18T09:01:34.362041Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4133ms. The settings might not be optimal. (flushed=1156 and evicted=0, during the time.)
2021-10-18T09:02:05.341708Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 10017ms. The settings might not be optimal. (flushed=1432 and evicted=0, during the time.)
2021-10-18T09:02:53.559742Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 8495ms. The settings might not be optimal. (flushed=1141 and evicted=0, during the time.)
2021-10-18T09:04:13.728239Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4313ms. The settings might not be optimal. (flushed=371 and evicted=0, during the time.)
2021-10-18T09:04:41.068310Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 7163ms. The settings might not be optimal. (flushed=240 and evicted=529, during the time.)
2021-10-18T09:05:02.362753Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 8032ms. The settings might not be optimal. (flushed=178 and evicted=643, during the time.)
2021-10-18T09:05:10.491630Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4558ms. The settings might not be optimal. (flushed=187 and evicted=297, during the time.)
2021-10-18T09:05:25.924740Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 6191ms. The settings might not be optimal. (flushed=143 and evicted=546, during the time.)
2021-10-18T09:05:52.146692Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5253ms. The settings might not be optimal. (flushed=132 and evicted=445, during the time.)
2021-10-18T09:06:06.759232Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4810ms. The settings might not be optimal. (flushed=122 and evicted=385, during the time.)
2021-10-18T09:06:37.582733Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4518ms. The settings might not be optimal. (flushed=118 and evicted=344, during the time.)
2021-10-18T09:06:59.250976Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 6477ms. The settings might not be optimal. (flushed=99 and evicted=371, during the time.)
2021-10-18T09:07:07.038286Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4285ms. The settings might not be optimal. (flushed=94 and evicted=296, during the time.)
2021-10-18T09:07:25.241357Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5449ms. The settings might not be optimal. (flushed=86 and evicted=387, during the time.)
2021-10-18T09:07:40.082236Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 6219ms. The settings might not be optimal. (flushed=71 and evicted=580, during the time.)
2021-10-18T09:07:49.065012Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5500ms. The settings might not be optimal. (flushed=69 and evicted=539, during the time.)
2021-10-18T09:08:12.149037Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4924ms. The settings might not be optimal. (flushed=73 and evicted=396, during the time.)
2021-10-18T09:08:51.242476Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5951ms. The settings might not be optimal. (flushed=57 and evicted=593, during the time.)
2021-10-18T09:09:43.596126Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5925ms. The settings might not be optimal. (flushed=46 and evicted=595, during the time.)
2021-10-18T09:11:31.748113Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4398ms. The settings might not be optimal. (flushed=49 and evicted=498, during the time.)
2021-10-18T09:15:05.370527Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 7162ms. The settings might not be optimal. (flushed=19 and evicted=687, during the time.)
2021-10-18T09:22:22.805939Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 7640ms. The settings might not be optimal. (flushed=14 and evicted=757, during the time.)



[coding001@voice data_volume]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    1.61    3.14     0.11     0.12    98.60     0.05    9.58   22.82    2.78   0.66   0.31

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  892.00  370.00    48.04     8.12    91.14    31.90   25.33   35.54    0.73   0.79 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  816.00  412.00    47.92     6.51    90.78    27.11   21.54   32.05    0.74   0.81 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     3.00  927.00  313.00    48.09     5.61    88.70    27.48   22.36   29.62    0.86   0.80  99.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  894.00  574.00    48.08     9.87    80.84    29.09   19.85   32.13    0.73   0.68 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  912.00  229.00    48.05     4.62    94.53    29.35   26.06   32.39    0.84   0.88 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  827.00  384.00    47.93     6.97    92.84    31.89   26.13   37.90    0.79   0.83 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  795.00  242.00    47.91     4.92   104.33    39.08   32.44   42.07    0.79   0.97 100.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  824.00  295.00    48.03     3.58    94.46    30.07   31.64   42.70    0.73   0.89 100.00


[coding001@voice data_volume]$ iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/18/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.42    0.00    0.64    0.13    0.00   98.81

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               4.75       109.77       124.54  892337834 1012385376

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          22.22    0.00   16.16   61.36    0.00    0.25

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1389.00     48936.00      7716.00      48936       7716

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.67    0.00    9.85   72.73    0.00    0.76

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1122.00     49232.00      6840.00      49232       6840

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          20.10    0.00    9.67   69.72    0.00    0.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1308.00     49144.00      6528.00      49144       6528

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.90    0.00    9.09   72.98    0.00    3.03

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1332.00     49152.00      7908.00      49152       7908

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          15.15    0.00    8.84   75.51    0.00    0.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1131.00     49280.00      6228.00      49280       6228

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          12.15    0.00    5.82   80.00    0.00    2.03

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             997.00     49088.00      2644.00      49088       2644



[coding001@voice data_volume]$ top
1
top - 17:10:09 up 94 days,  2:08,  4 users,  load average: 18.29, 15.02, 8.03
Tasks: 125 total,   2 running, 123 sleeping,   0 stopped,   0 zombie
%Cpu0  : 18.3 us,  6.7 sy,  0.0 ni,  0.0 id, 71.7 wa,  0.0 hi,  3.3 si,  0.0 st
%Cpu1  : 16.4 us,  8.2 sy,  0.0 ni,  0.0 id, 73.8 wa,  0.0 hi,  1.6 si,  0.0 st
%Cpu2  : 20.3 us, 10.2 sy,  0.0 ni,  0.0 id, 69.5 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  : 16.9 us,  5.1 sy,  0.0 ni, 11.9 id, 64.4 wa,  0.0 hi,  1.7 si,  0.0 st
KiB Mem : 16266300 total,   155712 free,  9955504 used,  6155084 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5255632 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
19543 mysql     20   0   11.5g   8.9g   3392 S  93.3 57.5 101:58.71 mysqld                                                                                                                                                                    
  960 coding0+  20   0 1156100   7976   1396 S  15.0  0.0   1:27.11 sysbench     
  
  
  
[coding001@voice ~]$ tail -f sysbench_oltpX_16_not16_.log
[ 60s ] thds: 16 tps: 118.60 qps: 2370.61 (r/w/o: 1659.10/474.30/237.20) lat (ms,99%): 694.45 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 16 tps: 122.10 qps: 2445.82 (r/w/o: 1712.61/489.00/244.20) lat (ms,99%): 634.66 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 16 tps: 102.40 qps: 2045.78 (r/w/o: 1431.88/409.10/204.80) lat (ms,99%): 612.21 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 16 tps: 110.30 qps: 2206.80 (r/w/o: 1544.90/441.30/220.60) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 16 tps: 111.70 qps: 2231.02 (r/w/o: 1561.01/446.60/223.40) lat (ms,99%): 590.56 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 16 tps: 104.30 qps: 2092.51 (r/w/o: 1466.10/417.80/208.60) lat (ms,99%): 590.56 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 16 tps: 104.20 qps: 2079.50 (r/w/o: 1454.70/416.40/208.40) lat (ms,99%): 634.66 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 16 tps: 98.90 qps: 1979.08 (r/w/o: 1385.49/395.80/197.80) lat (ms,99%): 719.92 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 16 tps: 99.70 qps: 1996.11 (r/w/o: 1398.01/398.70/199.40) lat (ms,99%): 719.92 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 16 tps: 121.80 qps: 2434.89 (r/w/o: 1704.19/487.10/243.60) lat (ms,99%): 569.67 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 16 tps: 111.50 qps: 2229.91 (r/w/o: 1560.91/446.00/223.00) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 16 tps: 111.70 qps: 2230.82 (r/w/o: 1560.61/446.80/223.40) lat (ms,99%): 623.33 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 16 tps: 131.99 qps: 2643.42 (r/w/o: 1851.60/527.84/263.97) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 16 tps: 136.11 qps: 2719.55 (r/w/o: 1902.98/544.35/272.23) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 16 tps: 140.70 qps: 2812.83 (r/w/o: 1968.42/563.01/281.40) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 16 tps: 137.90 qps: 2759.26 (r/w/o: 1931.98/551.49/275.80) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 16 tps: 145.50 qps: 2910.09 (r/w/o: 2037.19/581.90/291.00) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 16 tps: 142.90 qps: 2859.65 (r/w/o: 2001.83/572.01/285.80) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 16 tps: 141.70 qps: 2832.08 (r/w/o: 1982.08/566.60/283.40) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 16 tps: 157.10 qps: 3143.80 (r/w/o: 2201.00/628.60/314.20) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 16 tps: 152.60 qps: 3051.11 (r/w/o: 2135.91/610.00/305.20) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 16 tps: 146.80 qps: 2934.69 (r/w/o: 2053.69/587.40/293.60) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 16 tps: 148.00 qps: 2962.31 (r/w/o: 2074.10/592.20/296.00) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 16 tps: 143.10 qps: 2865.21 (r/w/o: 2006.80/572.20/286.20) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 16 tps: 134.00 qps: 2677.79 (r/w/o: 1873.89/535.90/268.00) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 16 tps: 131.10 qps: 2624.30 (r/w/o: 1837.50/524.60/262.20) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 16 tps: 124.80 qps: 2493.88 (r/w/o: 1744.99/499.40/249.50) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 16 tps: 116.40 qps: 2326.82 (r/w/o: 1628.81/465.10/232.90) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 16 tps: 110.30 qps: 2204.69 (r/w/o: 1542.59/441.50/220.60) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 16 tps: 113.40 qps: 2273.30 (r/w/o: 1592.40/454.10/226.80) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 16 tps: 118.60 qps: 2367.71 (r/w/o: 1656.71/473.80/237.20) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 16 tps: 123.00 qps: 2463.30 (r/w/o: 1725.00/492.30/246.00) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 16 tps: 126.30 qps: 2525.38 (r/w/o: 1767.69/505.10/252.60) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 16 tps: 112.29 qps: 2242.46 (r/w/o: 1568.90/448.97/224.59) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 16 tps: 122.81 qps: 2456.78 (r/w/o: 1720.13/491.04/245.62) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 16 tps: 117.59 qps: 2353.41 (r/w/o: 1647.46/470.76/235.18) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 16 tps: 106.61 qps: 2132.67 (r/w/o: 1493.12/426.33/213.22) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 16 tps: 109.70 qps: 2192.30 (r/w/o: 1534.30/438.60/219.40) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 16 tps: 110.49 qps: 2210.77 (r/w/o: 1547.74/442.05/220.98) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 16 tps: 110.21 qps: 2203.02 (r/w/o: 1541.66/440.94/220.42) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 16 tps: 101.30 qps: 2024.49 (r/w/o: 1416.79/405.10/202.60) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 16 tps: 108.00 qps: 2160.30 (r/w/o: 1512.50/431.80/216.00) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 16 tps: 103.30 qps: 2066.32 (r/w/o: 1446.51/413.20/206.60) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 16 tps: 104.10 qps: 2083.77 (r/w/o: 1458.98/416.59/208.20) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 16 tps: 101.00 qps: 2023.72 (r/w/o: 1417.41/404.30/202.00) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 16 tps: 99.40 qps: 1981.59 (r/w/o: 1385.69/397.10/198.80) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 16 tps: 99.40 qps: 1988.61 (r/w/o: 1392.20/397.60/198.80) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 16 tps: 104.10 qps: 2083.00 (r/w/o: 1458.20/416.60/208.20) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 16 tps: 105.60 qps: 2111.41 (r/w/o: 1477.11/423.10/211.20) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 16 tps: 106.90 qps: 2140.70 (r/w/o: 1500.00/426.90/213.80) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 16 tps: 106.19 qps: 2119.24 (r/w/o: 1482.09/424.77/212.38) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 16 tps: 97.71 qps: 1958.54 (r/w/o: 1371.80/391.43/195.31) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 16 tps: 88.90 qps: 1777.09 (r/w/o: 1243.99/355.30/177.80) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 16 tps: 94.90 qps: 1898.62 (r/w/o: 1329.11/379.60/189.90) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 16 tps: 90.50 qps: 1808.87 (r/w/o: 1266.28/361.59/181.00) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 16 tps: 100.90 qps: 2017.82 (r/w/o: 1412.52/403.50/201.80) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 16 tps: 101.40 qps: 2028.40 (r/w/o: 1419.80/405.80/202.80) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 16 tps: 95.99 qps: 1918.16 (r/w/o: 1342.40/383.77/191.99) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 16 tps: 96.01 qps: 1922.51 (r/w/o: 1345.77/384.72/192.01) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 16 tps: 92.00 qps: 1837.92 (r/w/o: 1286.11/367.80/184.00) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 16 tps: 89.20 qps: 1787.10 (r/w/o: 1252.30/356.40/178.40) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 16 tps: 96.00 qps: 1920.20 (r/w/o: 1344.10/384.10/192.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 16 tps: 96.60 qps: 1932.24 (r/w/o: 1352.86/386.19/193.19) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 16 tps: 99.80 qps: 1989.86 (r/w/o: 1391.04/399.21/199.61) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 16 tps: 87.40 qps: 1751.49 (r/w/o: 1226.79/349.90/174.80) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 16 tps: 96.80 qps: 1936.11 (r/w/o: 1355.31/387.20/193.60) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 16 tps: 90.39 qps: 1808.67 (r/w/o: 1266.21/361.67/180.79) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 16 tps: 95.31 qps: 1906.13 (r/w/o: 1334.09/381.43/190.61) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 16 tps: 87.50 qps: 1748.02 (r/w/o: 1223.41/349.60/175.00) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 16 tps: 83.00 qps: 1661.10 (r/w/o: 1163.10/332.00/166.00) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 16 tps: 82.49 qps: 1651.16 (r/w/o: 1155.90/330.27/164.99) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 16 tps: 88.91 qps: 1774.85 (r/w/o: 1241.81/355.23/177.82) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 16 tps: 84.60 qps: 1693.47 (r/w/o: 1185.68/338.59/169.20) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 16 tps: 82.20 qps: 1644.12 (r/w/o: 1150.71/329.00/164.40) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 16 tps: 86.80 qps: 1739.89 (r/w/o: 1219.59/346.70/173.60) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 16 tps: 82.80 qps: 1653.09 (r/w/o: 1155.59/331.90/165.60) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 16 tps: 89.00 qps: 1781.31 (r/w/o: 1247.21/356.10/178.00) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 16 tps: 88.20 qps: 1762.50 (r/w/o: 1234.13/351.98/176.39) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 16 tps: 84.81 qps: 1696.01 (r/w/o: 1186.78/339.62/169.61) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 16 tps: 96.30 qps: 1924.59 (r/w/o: 1347.00/385.00/192.60) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 16 tps: 93.20 qps: 1864.88 (r/w/o: 1305.78/372.70/186.40) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 16 tps: 85.60 qps: 1713.12 (r/w/o: 1199.01/342.90/171.20) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 16 tps: 86.90 qps: 1736.47 (r/w/o: 1215.38/347.29/173.80) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 16 tps: 88.60 qps: 1776.23 (r/w/o: 1244.52/354.51/177.20) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 16 tps: 82.50 qps: 1648.49 (r/w/o: 1153.49/330.00/165.00) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 16 tps: 89.00 qps: 1778.40 (r/w/o: 1244.40/356.00/178.00) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 16 tps: 84.10 qps: 1678.01 (r/w/o: 1173.60/336.20/168.20) lat (ms,99%): 559.50 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 16 tps: 86.90 qps: 1741.88 (r/w/o: 1220.59/347.50/173.80) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 16 tps: 76.70 qps: 1534.32 (r/w/o: 1074.12/306.80/153.40) lat (ms,99%): 694.45 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 16 tps: 88.30 qps: 1765.90 (r/w/o: 1235.90/353.40/176.60) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 16 tps: 82.10 qps: 1645.69 (r/w/o: 1152.99/328.50/164.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 16 tps: 92.70 qps: 1848.50 (r/w/o: 1292.80/370.40/185.30) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 16 tps: 89.20 qps: 1786.11 (r/w/o: 1250.61/357.00/178.50) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 16 tps: 88.80 qps: 1778.00 (r/w/o: 1244.90/355.50/177.60) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 16 tps: 88.50 qps: 1764.50 (r/w/o: 1233.80/353.70/177.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 16 tps: 85.40 qps: 1708.70 (r/w/o: 1196.30/341.60/170.80) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 16 tps: 84.79 qps: 1697.58 (r/w/o: 1188.62/339.38/169.59) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 16 tps: 92.11 qps: 1841.51 (r/w/o: 1288.97/368.32/184.21) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 16 tps: 85.30 qps: 1705.31 (r/w/o: 1193.81/340.90/170.60) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 16 tps: 94.90 qps: 1899.40 (r/w/o: 1329.90/379.70/189.80) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 16 tps: 85.20 qps: 1705.70 (r/w/o: 1194.30/341.00/170.40) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 16 tps: 82.50 qps: 1648.82 (r/w/o: 1154.11/329.70/165.00) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 16 tps: 80.80 qps: 1614.79 (r/w/o: 1129.79/323.40/161.60) lat (ms,99%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 16 tps: 92.20 qps: 1842.91 (r/w/o: 1289.61/368.90/184.40) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 16 tps: 84.00 qps: 1684.71 (r/w/o: 1180.60/336.10/168.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 16 tps: 87.20 qps: 1744.87 (r/w/o: 1221.68/348.79/174.40) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 16 tps: 84.90 qps: 1694.91 (r/w/o: 1185.21/339.90/169.80) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 16 tps: 83.70 qps: 1672.49 (r/w/o: 1170.89/334.20/167.40) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 16 tps: 87.30 qps: 1746.28 (r/w/o: 1222.59/349.10/174.60) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 16 tps: 89.60 qps: 1791.63 (r/w/o: 1254.02/358.41/179.20) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 16 tps: 93.70 qps: 1875.34 (r/w/o: 1312.95/374.99/187.39) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 16 tps: 83.10 qps: 1661.24 (r/w/o: 1162.53/332.51/166.20) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 16 tps: 87.50 qps: 1751.08 (r/w/o: 1226.19/349.90/175.00) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 16 tps: 79.80 qps: 1595.22 (r/w/o: 1116.52/319.10/159.60) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 16 tps: 82.50 qps: 1649.48 (r/w/o: 1154.19/330.30/165.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 16 tps: 86.40 qps: 1725.91 (r/w/o: 1207.61/345.50/172.80) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 16 tps: 78.50 qps: 1573.00 (r/w/o: 1102.10/313.90/157.00) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 16 tps: 86.40 qps: 1727.31 (r/w/o: 1208.81/345.70/172.80) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 16 tps: 90.39 qps: 1807.23 (r/w/o: 1265.18/361.27/180.78) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 16 tps: 87.11 qps: 1742.13 (r/w/o: 1219.19/348.73/174.21) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 16 tps: 76.90 qps: 1537.61 (r/w/o: 1076.21/307.60/153.80) lat (ms,99%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 16 tps: 83.39 qps: 1670.58 (r/w/o: 1170.12/333.68/166.79) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 16 tps: 82.31 qps: 1645.73 (r/w/o: 1151.99/329.13/164.61) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 16 tps: 80.20 qps: 1601.39 (r/w/o: 1120.30/320.70/160.40) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 16 tps: 85.80 qps: 1715.54 (r/w/o: 1200.93/343.01/171.60) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 16 tps: 77.49 qps: 1551.64 (r/w/o: 1086.69/309.97/154.98) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 16 tps: 77.21 qps: 1542.44 (r/w/o: 1079.00/309.03/154.41) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 16 tps: 87.40 qps: 1749.32 (r/w/o: 1225.05/349.48/174.79) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 16 tps: 84.00 qps: 1683.16 (r/w/o: 1178.78/336.39/168.00) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 16 tps: 83.40 qps: 1665.30 (r/w/o: 1165.17/333.32/166.81) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 16 tps: 87.90 qps: 1759.78 (r/w/o: 1231.89/352.10/175.80) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 16 tps: 86.10 qps: 1719.69 (r/w/o: 1203.60/343.90/172.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 16 tps: 92.20 qps: 1846.22 (r/w/o: 1293.11/368.70/184.40) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 16 tps: 87.10 qps: 1740.68 (r/w/o: 1217.79/348.70/174.20) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 16 tps: 87.10 qps: 1742.54 (r/w/o: 1220.12/348.21/174.20) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 16 tps: 80.00 qps: 1602.39 (r/w/o: 1121.90/320.50/160.00) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 16 tps: 83.60 qps: 1669.38 (r/w/o: 1168.48/333.70/167.20) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 16 tps: 78.30 qps: 1566.22 (r/w/o: 1096.02/313.60/156.60) lat (ms,99%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 16 tps: 81.10 qps: 1622.00 (r/w/o: 1135.60/324.20/162.20) lat (ms,99%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 16 tps: 90.10 qps: 1801.71 (r/w/o: 1261.11/360.40/180.20) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 16 tps: 86.50 qps: 1727.51 (r/w/o: 1208.31/346.20/173.00) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 16 tps: 83.30 qps: 1669.68 (r/w/o: 1170.19/332.90/166.60) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 16 tps: 83.40 qps: 1665.80 (r/w/o: 1165.50/333.50/166.80) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 16 tps: 85.09 qps: 1703.84 (r/w/o: 1192.69/340.97/170.18) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 16 tps: 83.11 qps: 1658.94 (r/w/o: 1160.90/331.83/166.21) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 16 tps: 89.40 qps: 1787.29 (r/w/o: 1250.59/357.90/178.80) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 16 tps: 81.70 qps: 1637.61 (r/w/o: 1147.71/326.50/163.40) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 16 tps: 86.00 qps: 1715.82 (r/w/o: 1199.31/344.50/172.00) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 16 tps: 80.30 qps: 1609.20 (r/w/o: 1127.70/320.90/160.60) lat (ms,99%): 623.33 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 16 tps: 80.60 qps: 1614.50 (r/w/o: 1130.70/322.60/161.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 16 tps: 89.50 qps: 1790.32 (r/w/o: 1253.22/358.10/179.00) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 16 tps: 79.10 qps: 1581.07 (r/w/o: 1106.78/316.09/158.20) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 16 tps: 80.50 qps: 1608.47 (r/w/o: 1125.38/322.09/161.00) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 16 tps: 88.30 qps: 1764.24 (r/w/o: 1234.43/353.21/176.60) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 16 tps: 78.00 qps: 1563.68 (r/w/o: 1095.59/312.10/156.00) lat (ms,99%): 569.67 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 16 tps: 87.30 qps: 1740.61 (r/w/o: 1216.81/349.20/174.60) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 16 tps: 85.40 qps: 1712.72 (r/w/o: 1200.31/341.60/170.80) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 16 tps: 81.00 qps: 1619.05 (r/w/o: 1133.46/323.59/161.99) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 16 tps: 79.30 qps: 1586.34 (r/w/o: 1110.12/317.61/158.60) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 16 tps: 87.20 qps: 1742.82 (r/w/o: 1219.92/348.50/174.40) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 16 tps: 86.20 qps: 1726.98 (r/w/o: 1209.69/344.90/172.40) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 16 tps: 89.90 qps: 1798.51 (r/w/o: 1258.71/360.00/179.80) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 16 tps: 86.29 qps: 1723.58 (r/w/o: 1206.12/344.88/172.59) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 16 tps: 84.31 qps: 1683.91 (r/w/o: 1178.28/337.02/168.61) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 16 tps: 84.10 qps: 1681.10 (r/w/o: 1176.60/336.30/168.20) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 16 tps: 90.40 qps: 1808.20 (r/w/o: 1265.40/362.00/180.80) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 16 tps: 82.40 qps: 1649.60 (r/w/o: 1155.50/329.30/164.80) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 16 tps: 78.50 qps: 1570.80 (r/w/o: 1099.90/313.90/157.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 16 tps: 81.80 qps: 1632.81 (r/w/o: 1142.01/327.20/163.60) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 16 tps: 81.00 qps: 1623.10 (r/w/o: 1136.70/324.40/162.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 16 tps: 85.20 qps: 1704.29 (r/w/o: 1193.49/340.40/170.40) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 16 tps: 80.30 qps: 1605.91 (r/w/o: 1123.80/321.50/160.60) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 16 tps: 79.40 qps: 1589.90 (r/w/o: 1113.70/317.40/158.80) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 16 tps: 78.30 qps: 1564.59 (r/w/o: 1094.70/313.30/156.60) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 16 tps: 82.29 qps: 1643.27 (r/w/o: 1149.51/329.17/164.59) lat (ms,99%): 623.33 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2437050
        write:                           696300
        other:                           348150
        total:                           3481500
    transactions:                        174075 (96.67 per sec.)
    queries:                             3481500 (1933.39 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.7214s
    total number of events:              174075

Latency (ms):
         min:                                    3.56
         avg:                                  165.48
         max:                                 1499.27
         99th percentile:                      520.62
         sum:                             28805221.65

Threads fairness:
    events (avg/stddev):           10879.6875/74.03
    execution time (avg/stddev):   1800.3264/0.25

