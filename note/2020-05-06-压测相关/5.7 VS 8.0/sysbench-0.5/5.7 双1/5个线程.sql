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
		
set global sync_binlog=0;
set global innodb_flush_log_at_trx_commit=0;


./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 --oltp-table-size=2000000 --rand-init=on prepare &

purge binary logs to 'mysql-bin.000024';   
	
set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;

show global variables like '%sync_binlog%';
show global variables like '%innodb_flush_log_at_trx_commit%';
show global variables like '%innodb_io_capacity%';
show global variables like 'time_zone';

mysql> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 1     |
+---------------+-------+
1 row in set (0.03 sec)

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

mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | SYSTEM |
+---------------+--------+
1 row in set (0.01 sec)


purge binary logs to 'mysql-bin.000072';  


./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=5 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_5_11.log &



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+-------+------------------------+-------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time  | State                  | Info                                                              |
+----+-----------------+--------------------+--------+---------+-------+------------------------+-------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 64147 | Waiting on empty queue | NULL                                                              |
|  3 | root            | localhost          | sbtest | Query   |     0 | starting               | show processlist                                                  |
| 39 | sysbench        | 192.168.1.12:51715 | sbtest | Query   |     0 | starting               | COMMIT                                                            |
| 40 | sysbench        | 192.168.1.12:51717 | sbtest | Query   |     0 | starting               | SELECT SUM(K) FROM sbtest13 WHERE id BETWEEN 455611 AND 455611+99 |
| 41 | sysbench        | 192.168.1.12:51714 | sbtest | Query   |     0 | starting               | COMMIT                                                            |
| 42 | sysbench        | 192.168.1.12:51726 | sbtest | Query   |     0 | init                   | UPDATE sbtest1 SET k=k+1 WHERE id=140102                          |
| 43 | sysbench        | 192.168.1.12:51716 | sbtest | Query   |     0 | freeing items          | SELECT c FROM sbtest1 WHERE id=1026606                            |
+----+-----------------+--------------------+--------+---------+-------+------------------------+-------------------------------------------------------------------+
7 rows in set (0.00 sec)



[coding001@voice sysbench]$ iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.45    0.00    0.65    0.17    0.00   98.73

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               5.74       140.73       162.43 1153492630 1331299020

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          51.52    0.00   21.83    6.60    0.00   20.05

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1981.00         0.00     29504.00          0      29504

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          50.90    0.00   21.99    6.39    0.00   20.72

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1968.00         0.00     29484.00          0      29484

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          51.66    0.00   21.74    6.14    0.00   20.46

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1993.00         0.00     29544.00          0      29544

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          50.77    0.00   22.45    6.38    0.00   20.41

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1934.00         0.00     29280.00          0      29280

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          50.51    0.00   22.31    6.67    0.00   20.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1962.00         0.00     29396.00          0      29396

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          50.77    0.00   22.31    6.41    0.00   20.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1991.00         0.00     29452.00          0      29452

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          50.76    0.00   22.34    6.60    0.00   20.30


[coding001@voice sysbench]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    2.09    3.83     0.14     0.16   103.43     0.06   10.77   24.15    3.49   0.66   0.39

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    1.00 1800.00     0.01    31.21    35.50     1.13    0.63    0.00    0.63   0.41  73.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1811.00     0.00    31.05    35.11     1.10    0.61    0.00    0.61   0.38  68.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1766.00     0.00    30.97    35.92     1.12    0.63    0.00    0.63   0.40  70.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1780.00     0.00    31.02    35.69     1.09    0.61    0.00    0.61   0.41  73.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1776.00     0.00    30.85    35.57     1.16    0.65    0.00    0.65   0.40  71.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1806.00     0.00    31.03    35.19     1.15    0.64    0.00    0.64   0.39  71.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1674.00     0.00    30.85    37.74     1.06    0.64    0.00    0.64   0.41  68.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1828.00     0.00    31.23    34.99     1.15    0.63    0.00    0.63   0.40  72.30


[coding001@voice sysbench]$ top
top - 12:02:06 up 94 days, 21:00,  4 users,  load average: 6.03, 5.58, 4.54
Tasks: 129 total,   2 running, 127 sleeping,   0 stopped,   0 zombie
%Cpu0  : 49.7 us, 18.1 sy,  0.0 ni, 18.7 id,  4.7 wa,  0.0 hi,  8.8 si,  0.0 st
%Cpu1  : 52.7 us, 18.3 sy,  0.0 ni, 18.3 id,  5.9 wa,  0.0 hi,  4.7 si,  0.0 st
%Cpu2  : 52.9 us, 17.1 sy,  0.0 ni, 19.4 id,  6.5 wa,  0.0 hi,  4.1 si,  0.0 st
%Cpu3  : 52.7 us, 16.0 sy,  0.0 ni, 19.5 id,  5.3 wa,  0.0 hi,  6.5 si,  0.0 st
KiB Mem : 16266300 total,   165272 free, 10000920 used,  6100108 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5172860 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
 6404 mysql     20   0   11.4g   9.0g   4076 S 242.5 57.8 213:07.47 mysqld                                                                                                                                                                     
 5699 coding0+  20   0  363692   4416   1200 S  60.3  0.0  10:08.58 sysbench     




[coding001@voice log]$ tail -f sysbench_oltpX_5_11.log
Number of threads: 5
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 5, tps: 384.29, reads: 5384.64, writes: 1537.96, response time: 40.48ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 5, tps: 350.21, reads: 4904.69, writes: 1400.82, response time: 43.73ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 5, tps: 345.00, reads: 4828.33, writes: 1380.08, response time: 43.85ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 5, tps: 337.60, reads: 4727.36, writes: 1350.32, response time: 43.89ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 5, tps: 340.29, reads: 4764.91, writes: 1361.38, response time: 40.45ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 5, tps: 348.99, reads: 4884.67, writes: 1395.46, response time: 36.10ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 5, tps: 340.62, reads: 4767.43, writes: 1362.36, response time: 39.46ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 5, tps: 344.10, reads: 4818.00, writes: 1376.80, response time: 39.24ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 5, tps: 196.70, reads: 2754.64, writes: 786.48, response time: 81.78ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 5, tps: 269.01, reads: 3763.19, writes: 1075.53, response time: 80.42ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 5, tps: 253.60, reads: 3550.06, writes: 1014.39, response time: 80.98ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 5, tps: 255.80, reads: 3585.23, writes: 1024.11, response time: 81.17ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 5, tps: 353.20, reads: 4942.68, writes: 1412.70, response time: 52.14ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 5, tps: 372.39, reads: 5214.12, writes: 1489.28, response time: 32.78ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 5, tps: 376.31, reads: 5267.07, writes: 1504.92, response time: 31.22ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 5, tps: 384.10, reads: 5379.86, writes: 1537.39, response time: 30.27ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 5, tps: 382.90, reads: 5360.74, writes: 1531.71, response time: 32.30ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 5, tps: 376.10, reads: 5265.92, writes: 1504.71, response time: 31.30ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 5, tps: 387.30, reads: 5420.40, writes: 1548.70, response time: 31.35ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 5, tps: 392.10, reads: 5490.08, writes: 1568.09, response time: 31.71ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 5, tps: 396.20, reads: 5547.03, writes: 1585.21, response time: 30.88ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 5, tps: 402.70, reads: 5637.87, writes: 1610.59, response time: 29.40ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 5, tps: 400.10, reads: 5602.32, writes: 1601.01, response time: 30.27ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 5, tps: 400.70, reads: 5607.50, writes: 1601.90, response time: 30.64ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 5, tps: 407.19, reads: 5701.53, writes: 1629.18, response time: 29.24ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 5, tps: 406.90, reads: 5697.17, writes: 1627.72, response time: 30.85ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 5, tps: 408.80, reads: 5722.10, writes: 1634.80, response time: 29.20ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 5, tps: 410.65, reads: 5749.94, writes: 1641.91, response time: 28.72ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 5, tps: 413.45, reads: 5789.46, writes: 1654.99, response time: 29.13ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 5, tps: 411.00, reads: 5752.71, writes: 1643.60, response time: 29.42ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 5, tps: 418.30, reads: 5857.10, writes: 1673.20, response time: 28.74ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 5, tps: 417.30, reads: 5840.70, writes: 1668.60, response time: 27.31ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 5, tps: 423.30, reads: 5925.29, writes: 1693.30, response time: 27.41ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 5, tps: 422.49, reads: 5916.75, writes: 1690.06, response time: 26.39ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 5, tps: 424.91, reads: 5948.06, writes: 1699.94, response time: 26.93ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 5, tps: 429.77, reads: 6017.18, writes: 1718.48, response time: 25.72ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 5, tps: 428.53, reads: 5998.58, writes: 1714.71, response time: 26.60ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 5, tps: 420.60, reads: 5889.33, writes: 1682.41, response time: 26.24ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 5, tps: 430.90, reads: 6032.30, writes: 1723.20, response time: 25.79ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 5, tps: 428.50, reads: 6000.21, writes: 1714.80, response time: 25.63ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 5, tps: 432.00, reads: 6047.09, writes: 1727.70, response time: 25.77ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 5, tps: 433.10, reads: 6063.50, writes: 1732.70, response time: 25.49ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 5, tps: 433.20, reads: 6064.57, writes: 1732.59, response time: 25.23ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 5, tps: 432.80, reads: 6059.66, writes: 1730.59, response time: 26.22ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 5, tps: 436.11, reads: 6102.78, writes: 1744.42, response time: 25.10ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 5, tps: 438.80, reads: 6146.39, writes: 1756.00, response time: 23.49ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 5, tps: 439.00, reads: 6146.29, writes: 1756.20, response time: 23.49ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 5, tps: 443.60, reads: 6206.58, writes: 1773.19, response time: 22.76ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 5, tps: 433.40, reads: 6070.64, writes: 1734.61, response time: 24.77ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 5, tps: 417.60, reads: 5844.89, writes: 1669.70, response time: 25.41ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 5, tps: 431.20, reads: 6037.96, writes: 1725.09, response time: 23.78ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 5, tps: 439.60, reads: 6153.78, writes: 1758.39, response time: 24.58ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 5, tps: 436.00, reads: 6104.96, writes: 1744.52, response time: 24.49ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 5, tps: 441.70, reads: 6183.49, writes: 1767.10, response time: 23.64ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 5, tps: 441.80, reads: 6184.70, writes: 1766.40, response time: 23.00ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 5, tps: 437.67, reads: 6125.92, writes: 1750.26, response time: 25.20ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 5, tps: 443.13, reads: 6204.82, writes: 1773.02, response time: 22.78ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 5, tps: 443.70, reads: 6212.96, writes: 1774.72, response time: 22.88ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 5, tps: 440.80, reads: 6171.33, writes: 1763.61, response time: 22.39ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 5, tps: 443.40, reads: 6206.29, writes: 1772.60, response time: 23.27ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 5, tps: 444.49, reads: 6223.00, writes: 1778.57, response time: 22.22ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 5, tps: 442.01, reads: 6189.79, writes: 1768.43, response time: 22.52ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 5, tps: 445.50, reads: 6236.02, writes: 1780.91, response time: 23.35ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 5, tps: 441.10, reads: 6176.44, writes: 1765.48, response time: 22.53ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 5, tps: 443.40, reads: 6206.23, writes: 1773.41, response time: 22.11ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 5, tps: 438.70, reads: 6142.67, writes: 1754.79, response time: 22.53ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 5, tps: 434.50, reads: 6083.36, writes: 1738.02, response time: 24.24ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 5, tps: 426.90, reads: 5975.26, writes: 1707.39, response time: 26.17ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 5, tps: 427.70, reads: 5988.61, writes: 1710.80, response time: 26.35ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 5, tps: 428.20, reads: 5993.29, writes: 1712.80, response time: 26.08ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 5, tps: 425.80, reads: 5961.94, writes: 1703.61, response time: 26.21ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 5, tps: 425.60, reads: 5958.18, writes: 1701.99, response time: 25.65ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 5, tps: 423.10, reads: 5924.00, writes: 1692.40, response time: 25.45ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 5, tps: 423.49, reads: 5927.82, writes: 1693.78, response time: 26.19ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 5, tps: 422.87, reads: 5921.69, writes: 1691.38, response time: 25.50ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 5, tps: 418.54, reads: 5857.40, writes: 1673.64, response time: 25.99ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 5, tps: 419.80, reads: 5879.40, writes: 1680.00, response time: 26.44ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 5, tps: 419.60, reads: 5873.48, writes: 1678.19, response time: 26.66ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 5, tps: 417.90, reads: 5850.42, writes: 1671.41, response time: 26.77ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 5, tps: 417.39, reads: 5842.24, writes: 1669.15, response time: 27.03ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 5, tps: 411.41, reads: 5760.26, writes: 1646.24, response time: 27.20ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 5, tps: 395.40, reads: 5535.18, writes: 1581.79, response time: 27.96ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 5, tps: 400.90, reads: 5612.42, writes: 1603.21, response time: 27.97ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 5, tps: 412.40, reads: 5775.39, writes: 1650.00, response time: 27.40ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 5, tps: 410.09, reads: 5740.92, writes: 1640.48, response time: 27.19ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 5, tps: 412.70, reads: 5779.65, writes: 1651.51, response time: 26.89ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 5, tps: 413.60, reads: 5789.29, writes: 1653.60, response time: 26.49ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 5, tps: 410.10, reads: 5741.02, writes: 1640.81, response time: 27.61ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 5, tps: 409.10, reads: 5727.29, writes: 1635.60, response time: 27.78ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 5, tps: 409.30, reads: 5730.62, writes: 1637.91, response time: 27.20ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 5, tps: 411.36, reads: 5759.79, writes: 1645.13, response time: 27.38ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 5, tps: 409.84, reads: 5737.22, writes: 1640.18, response time: 27.47ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 5, tps: 410.80, reads: 5750.24, writes: 1641.98, response time: 27.63ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 5, tps: 413.77, reads: 5793.35, writes: 1654.87, response time: 27.45ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 5, tps: 412.03, reads: 5769.48, writes: 1649.34, response time: 27.26ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 5, tps: 394.90, reads: 5526.38, writes: 1578.59, response time: 29.11ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 5, tps: 409.50, reads: 5735.29, writes: 1639.20, response time: 27.40ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 5, tps: 400.99, reads: 5610.46, writes: 1602.76, response time: 29.91ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 5, tps: 399.81, reads: 5599.35, writes: 1599.84, response time: 28.20ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 5, tps: 411.90, reads: 5766.74, writes: 1647.51, response time: 27.89ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 5, tps: 406.60, reads: 5692.60, writes: 1626.60, response time: 27.78ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 5, tps: 408.00, reads: 5711.47, writes: 1632.09, response time: 28.26ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 5, tps: 411.10, reads: 5757.12, writes: 1644.81, response time: 27.79ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 5, tps: 406.19, reads: 5685.44, writes: 1624.35, response time: 28.65ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 5, tps: 415.21, reads: 5812.86, writes: 1660.65, response time: 27.82ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 5, tps: 416.79, reads: 5835.03, writes: 1666.58, response time: 28.86ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 5, tps: 415.01, reads: 5808.48, writes: 1660.02, response time: 28.28ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 5, tps: 418.80, reads: 5864.26, writes: 1675.99, response time: 28.82ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 5, tps: 423.00, reads: 5923.06, writes: 1691.19, response time: 26.30ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 5, tps: 428.21, reads: 5995.08, writes: 1714.02, response time: 26.88ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 5, tps: 438.10, reads: 6131.95, writes: 1751.99, response time: 24.86ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 5, tps: 436.70, reads: 6114.54, writes: 1746.81, response time: 23.33ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 5, tps: 427.70, reads: 5989.01, writes: 1710.80, response time: 26.20ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 5, tps: 421.70, reads: 5902.70, writes: 1686.40, response time: 26.41ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 5, tps: 431.60, reads: 6043.30, writes: 1727.00, response time: 26.21ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 5, tps: 427.90, reads: 5989.98, writes: 1710.99, response time: 25.90ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 5, tps: 429.10, reads: 6007.51, writes: 1716.40, response time: 26.55ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 5, tps: 431.58, reads: 6041.19, writes: 1725.94, response time: 25.99ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 5, tps: 428.42, reads: 5997.42, writes: 1714.06, response time: 26.64ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 5, tps: 428.50, reads: 5999.40, writes: 1713.60, response time: 26.19ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 5, tps: 424.70, reads: 5945.98, writes: 1699.59, response time: 26.10ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 5, tps: 427.59, reads: 5985.37, writes: 1709.56, response time: 26.23ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 5, tps: 429.11, reads: 6009.25, writes: 1716.94, response time: 26.03ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 5, tps: 426.60, reads: 5972.28, writes: 1706.39, response time: 26.50ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 5, tps: 425.70, reads: 5959.10, writes: 1702.50, response time: 26.71ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 5, tps: 426.49, reads: 5971.33, writes: 1706.48, response time: 26.27ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 5, tps: 415.71, reads: 5819.99, writes: 1662.52, response time: 27.51ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 5, tps: 427.79, reads: 5989.16, writes: 1710.96, response time: 25.82ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 5, tps: 417.81, reads: 5849.93, writes: 1671.44, response time: 26.75ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 5, tps: 411.20, reads: 5755.61, writes: 1644.70, response time: 26.89ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 5, tps: 277.30, reads: 3882.78, writes: 1109.00, response time: 43.30ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 5, tps: 381.70, reads: 5343.82, writes: 1527.71, response time: 30.78ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 5, tps: 423.10, reads: 5923.80, writes: 1691.90, response time: 26.75ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 5, tps: 428.30, reads: 5996.88, writes: 1713.90, response time: 26.77ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 5, tps: 425.70, reads: 5959.73, writes: 1702.71, response time: 26.08ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 5, tps: 419.80, reads: 5873.10, writes: 1677.70, response time: 27.27ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 5, tps: 427.60, reads: 5990.18, writes: 1711.89, response time: 26.69ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 5, tps: 422.50, reads: 5915.12, writes: 1689.71, response time: 26.75ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 5, tps: 424.90, reads: 5946.90, writes: 1699.10, response time: 27.05ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 5, tps: 420.90, reads: 5892.83, writes: 1683.38, response time: 26.68ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 5, tps: 426.30, reads: 5969.36, writes: 1705.32, response time: 26.26ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 5, tps: 426.30, reads: 5966.90, writes: 1705.20, response time: 25.50ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 5, tps: 421.80, reads: 5905.90, writes: 1688.20, response time: 26.74ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 5, tps: 416.79, reads: 5834.75, writes: 1666.36, response time: 26.58ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 5, tps: 408.01, reads: 5713.54, writes: 1632.44, response time: 28.02ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 5, tps: 419.10, reads: 5865.30, writes: 1675.40, response time: 27.54ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 5, tps: 419.00, reads: 5866.00, writes: 1677.00, response time: 27.73ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 5, tps: 421.80, reads: 5905.26, writes: 1686.79, response time: 26.09ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 5, tps: 422.70, reads: 5918.94, writes: 1691.21, response time: 26.61ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 5, tps: 423.99, reads: 5936.55, writes: 1695.66, response time: 27.16ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 5, tps: 424.01, reads: 5934.62, writes: 1695.93, response time: 26.52ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 5, tps: 418.60, reads: 5861.22, writes: 1674.81, response time: 27.07ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 5, tps: 420.30, reads: 5883.21, writes: 1681.20, response time: 26.63ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 5, tps: 420.40, reads: 5885.99, writes: 1681.00, response time: 27.16ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 5, tps: 419.19, reads: 5868.65, writes: 1676.16, response time: 26.70ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 5, tps: 422.39, reads: 5914.30, writes: 1690.27, response time: 26.77ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 5, tps: 412.32, reads: 5772.24, writes: 1649.47, response time: 27.82ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 5, tps: 415.50, reads: 5816.58, writes: 1661.89, response time: 27.54ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 5, tps: 421.40, reads: 5899.11, writes: 1685.60, response time: 26.08ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 5, tps: 421.40, reads: 5900.31, writes: 1685.50, response time: 26.82ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 5, tps: 417.70, reads: 5846.96, writes: 1670.89, response time: 26.86ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 5, tps: 417.30, reads: 5844.34, writes: 1669.81, response time: 27.44ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 5, tps: 421.00, reads: 5890.89, writes: 1683.00, response time: 27.16ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 5, tps: 401.80, reads: 5627.70, writes: 1608.40, response time: 28.73ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 5, tps: 422.50, reads: 5913.60, writes: 1688.80, response time: 26.36ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 5, tps: 420.60, reads: 5889.20, writes: 1683.20, response time: 27.07ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 5, tps: 419.29, reads: 5869.11, writes: 1676.37, response time: 26.86ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 5, tps: 419.71, reads: 5876.28, writes: 1678.92, response time: 27.38ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 5, tps: 417.77, reads: 5850.23, writes: 1671.39, response time: 27.15ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 5, tps: 414.93, reads: 5807.91, writes: 1659.32, response time: 26.97ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 5, tps: 422.20, reads: 5910.39, writes: 1689.20, response time: 27.05ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 5, tps: 424.10, reads: 5937.10, writes: 1696.40, response time: 27.14ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 5, tps: 415.70, reads: 5821.51, writes: 1663.10, response time: 27.81ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 5, tps: 418.50, reads: 5858.39, writes: 1673.30, response time: 27.30ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 5, tps: 417.30, reads: 5840.10, writes: 1669.20, response time: 27.46ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 5, tps: 403.88, reads: 5656.16, writes: 1615.73, response time: 29.00ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 5, tps: 406.12, reads: 5686.25, writes: 1625.07, response time: 28.93ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 5, tps: 420.00, reads: 5878.48, writes: 1679.29, response time: 27.73ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 5, tps: 425.10, reads: 5952.80, writes: 1700.40, response time: 26.92ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 5, tps: 419.40, reads: 5870.61, writes: 1677.90, response time: 27.77ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            10368316
        write:                           2962376
        other:                           1481188
        total:                           14811880
    transactions:                        740594 (411.44 per sec.)
    read/write requests:                 13330692 (7405.89 per sec.)
    other operations:                    1481188 (822.88 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0127s
    total number of events:              740594
    total time taken by event execution: 8998.0323s
    response time:
         min:                                  6.58ms
         avg:                                 12.15ms
         max:                                159.34ms
         approx.  99 percentile:              28.78ms

Threads fairness:
    events (avg/stddev):           148118.8000/126.49
    execution time (avg/stddev):   1799.6065/0.00






 