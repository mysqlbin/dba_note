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


purge binary logs to 'mysql-bin.000166';  



[root@voice sbtest]# ls -lht 
total 7.0G
-rw-r-----. 1 mysql mysql 472M Oct 19 10:50 sbtest15.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:49 sbtest15.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:49 sbtest14.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:49 sbtest14.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:48 sbtest13.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:48 sbtest13.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:47 sbtest12.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:47 sbtest12.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:46 sbtest11.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:46 sbtest11.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:46 sbtest10.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:45 sbtest10.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:45 sbtest9.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:45 sbtest9.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:44 sbtest8.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:44 sbtest8.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:43 sbtest7.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:43 sbtest7.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:43 sbtest6.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:42 sbtest6.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:42 sbtest5.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:41 sbtest5.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:41 sbtest4.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:41 sbtest4.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:40 sbtest3.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:40 sbtest3.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:39 sbtest2.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:39 sbtest2.frm
-rw-r-----. 1 mysql mysql 472M Oct 19 10:39 sbtest1.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 19 10:39 sbtest1.frm
-rw-r-----. 1 mysql mysql   67 Oct 15 12:10 db.opt


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





./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=20 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_20_11.log &

[coding001@voice log]$ tail -f /home/coding001/log/sysbench_oltpX_20_11.log
Number of threads: 20
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 20, tps: 466.39, reads: 6556.70, writes: 1871.17, response time: 111.82ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 20, tps: 480.90, reads: 6726.89, writes: 1921.50, response time: 102.77ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 20, tps: 483.40, reads: 6768.63, writes: 1934.18, response time: 97.08ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 20, tps: 496.01, reads: 6937.68, writes: 1980.22, response time: 92.52ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 20, tps: 486.49, reads: 6810.62, writes: 1946.18, response time: 101.94ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 20, tps: 470.21, reads: 6585.40, writes: 1880.63, response time: 102.06ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 20, tps: 458.80, reads: 6420.39, writes: 1834.90, response time: 116.78ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 20, tps: 463.90, reads: 6493.69, writes: 1855.70, response time: 107.74ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 20, tps: 469.89, reads: 6586.91, writes: 1882.37, response time: 101.24ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 20, tps: 470.50, reads: 6585.65, writes: 1881.31, response time: 105.23ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 20, tps: 463.30, reads: 6478.73, writes: 1851.31, response time: 108.46ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 20, tps: 475.60, reads: 6664.11, writes: 1902.40, response time: 102.00ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 20, tps: 465.50, reads: 6515.40, writes: 1862.40, response time: 104.85ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 20, tps: 458.10, reads: 6413.99, writes: 1833.30, response time: 110.12ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 20, tps: 462.60, reads: 6476.16, writes: 1848.99, response time: 105.41ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 20, tps: 474.20, reads: 6639.43, writes: 1898.81, response time: 99.41ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 20, tps: 468.40, reads: 6554.90, writes: 1873.20, response time: 107.90ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 20, tps: 464.90, reads: 6517.73, writes: 1862.81, response time: 106.75ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 20, tps: 485.29, reads: 6785.47, writes: 1936.46, response time: 101.03ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 20, tps: 488.58, reads: 6842.64, writes: 1955.63, response time: 96.33ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 20, tps: 491.33, reads: 6876.79, writes: 1963.91, response time: 96.13ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 20, tps: 497.00, reads: 6962.31, writes: 1989.30, response time: 98.67ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 20, tps: 505.60, reads: 7072.89, writes: 2021.70, response time: 94.65ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 20, tps: 506.20, reads: 7091.30, writes: 2027.20, response time: 92.77ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 20, tps: 523.09, reads: 7326.99, writes: 2092.44, response time: 88.01ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 20, tps: 523.01, reads: 7316.91, writes: 2090.03, response time: 87.24ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 20, tps: 528.30, reads: 7398.50, writes: 2114.10, response time: 86.41ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 20, tps: 536.10, reads: 7503.12, writes: 2143.41, response time: 82.99ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 20, tps: 537.89, reads: 7533.38, writes: 2152.17, response time: 83.41ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 20, tps: 536.01, reads: 7503.22, writes: 2143.54, response time: 88.22ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 20, tps: 531.71, reads: 7442.28, writes: 2127.82, response time: 87.69ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 20, tps: 534.60, reads: 7484.26, writes: 2136.39, response time: 87.64ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 20, tps: 536.70, reads: 7512.14, writes: 2147.11, response time: 86.62ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 20, tps: 547.10, reads: 7658.89, writes: 2187.90, response time: 82.27ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 20, tps: 546.30, reads: 7650.00, writes: 2185.20, response time: 85.69ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 20, tps: 548.60, reads: 7679.66, writes: 2196.69, response time: 79.01ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 20, tps: 554.50, reads: 7761.94, writes: 2216.41, response time: 80.69ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 20, tps: 542.00, reads: 7594.51, writes: 2169.50, response time: 85.82ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 20, tps: 544.30, reads: 7621.10, writes: 2177.00, response time: 81.56ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 20, tps: 545.49, reads: 7638.79, writes: 2183.07, response time: 82.57ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 20, tps: 554.00, reads: 7749.56, writes: 2214.02, response time: 78.10ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 20, tps: 552.68, reads: 7739.83, writes: 2209.92, response time: 79.89ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 20, tps: 558.52, reads: 7817.76, writes: 2234.98, response time: 79.16ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 20, tps: 546.90, reads: 7660.02, writes: 2188.31, response time: 82.77ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 20, tps: 561.10, reads: 7853.92, writes: 2243.01, response time: 77.59ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 20, tps: 555.52, reads: 7777.34, writes: 2223.07, response time: 77.63ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 20, tps: 560.59, reads: 7844.41, writes: 2241.65, response time: 77.24ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 20, tps: 555.50, reads: 7777.39, writes: 2222.20, response time: 79.23ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 20, tps: 547.90, reads: 7668.29, writes: 2191.20, response time: 84.09ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 20, tps: 556.40, reads: 7794.49, writes: 2226.10, response time: 80.57ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 20, tps: 557.80, reads: 7810.90, writes: 2232.40, response time: 78.21ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 20, tps: 558.39, reads: 7817.54, writes: 2233.15, response time: 78.03ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 20, tps: 557.90, reads: 7812.35, writes: 2233.11, response time: 77.10ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 20, tps: 560.48, reads: 7843.99, writes: 2239.54, response time: 78.73ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 20, tps: 559.52, reads: 7824.53, writes: 2237.10, response time: 73.78ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 20, tps: 556.30, reads: 7794.30, writes: 2225.80, response time: 79.18ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 20, tps: 558.30, reads: 7815.69, writes: 2233.50, response time: 77.98ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 20, tps: 560.50, reads: 7845.86, writes: 2241.39, response time: 78.00ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 20, tps: 563.30, reads: 7890.68, writes: 2253.59, response time: 77.38ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 20, tps: 559.90, reads: 7841.99, writes: 2244.00, response time: 76.30ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 20, tps: 555.21, reads: 7765.77, writes: 2219.62, response time: 79.47ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 20, tps: 546.88, reads: 7657.39, writes: 2184.41, response time: 81.71ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 20, tps: 555.72, reads: 7784.64, writes: 2225.50, response time: 79.13ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 20, tps: 562.60, reads: 7875.80, writes: 2250.30, response time: 76.75ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 20, tps: 553.10, reads: 7742.88, writes: 2211.29, response time: 79.25ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 20, tps: 556.36, reads: 7784.71, writes: 2224.53, response time: 81.22ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 20, tps: 560.90, reads: 7856.61, writes: 2243.80, response time: 78.45ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 20, tps: 561.44, reads: 7857.32, writes: 2244.78, response time: 76.16ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 20, tps: 563.70, reads: 7895.88, writes: 2257.79, response time: 77.08ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 20, tps: 566.58, reads: 7928.62, writes: 2265.52, response time: 77.31ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 20, tps: 564.12, reads: 7898.55, writes: 2256.17, response time: 77.12ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 20, tps: 559.90, reads: 7835.53, writes: 2239.81, response time: 81.39ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 20, tps: 564.34, reads: 7908.08, writes: 2259.86, response time: 79.68ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 20, tps: 556.46, reads: 7786.08, writes: 2224.02, response time: 81.37ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 20, tps: 562.39, reads: 7869.10, writes: 2248.14, response time: 77.68ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 20, tps: 566.31, reads: 7935.20, writes: 2266.16, response time: 77.33ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 20, tps: 564.70, reads: 7901.26, writes: 2258.79, response time: 78.00ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 20, tps: 567.20, reads: 7943.54, writes: 2269.91, response time: 76.20ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 20, tps: 566.27, reads: 7928.23, writes: 2265.29, response time: 79.25ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 20, tps: 556.12, reads: 7788.30, writes: 2224.59, response time: 78.26ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 20, tps: 561.70, reads: 7859.42, writes: 2244.11, response time: 81.10ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 20, tps: 570.71, reads: 7986.27, writes: 2283.22, response time: 77.59ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 20, tps: 568.86, reads: 7971.38, writes: 2278.32, response time: 79.18ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 20, tps: 570.23, reads: 7983.22, writes: 2279.62, response time: 75.46ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 20, tps: 566.01, reads: 7920.67, writes: 2265.15, response time: 77.96ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 20, tps: 568.30, reads: 7947.56, writes: 2269.49, response time: 76.73ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 20, tps: 568.21, reads: 7959.78, writes: 2273.92, response time: 79.30ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 20, tps: 569.19, reads: 7970.91, writes: 2276.37, response time: 80.01ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 20, tps: 564.90, reads: 7912.96, writes: 2262.59, response time: 76.91ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 20, tps: 571.41, reads: 7996.50, writes: 2284.23, response time: 78.12ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 20, tps: 571.98, reads: 8005.64, writes: 2288.23, response time: 76.62ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 20, tps: 561.51, reads: 7863.69, writes: 2247.25, response time: 79.25ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 20, tps: 571.51, reads: 8003.48, writes: 2285.52, response time: 72.66ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 20, tps: 568.40, reads: 7950.00, writes: 2271.10, response time: 78.73ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 20, tps: 571.89, reads: 8005.22, writes: 2287.08, response time: 77.56ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 20, tps: 538.59, reads: 7549.30, writes: 2155.47, response time: 98.87ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 20, tps: 474.48, reads: 6644.73, writes: 1902.02, response time: 135.67ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 20, tps: 570.04, reads: 7975.41, writes: 2277.05, response time: 78.97ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 20, tps: 561.98, reads: 7873.17, writes: 2249.23, response time: 79.87ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 20, tps: 565.42, reads: 7909.83, writes: 2260.07, response time: 76.41ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 20, tps: 566.20, reads: 7931.03, writes: 2267.91, response time: 72.47ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 20, tps: 564.10, reads: 7888.26, writes: 2251.79, response time: 78.73ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 20, tps: 568.29, reads: 7965.42, writes: 2273.68, response time: 78.59ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 20, tps: 560.79, reads: 7846.53, writes: 2241.45, response time: 80.45ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 20, tps: 567.32, reads: 7944.38, writes: 2270.98, response time: 76.73ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 20, tps: 572.00, reads: 8003.69, writes: 2288.70, response time: 74.78ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 20, tps: 570.70, reads: 7994.39, writes: 2284.80, response time: 75.27ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 20, tps: 567.70, reads: 7946.33, writes: 2269.21, response time: 78.03ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 20, tps: 565.60, reads: 7919.30, writes: 2262.40, response time: 78.05ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 20, tps: 568.29, reads: 7955.99, writes: 2273.07, response time: 78.61ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 20, tps: 572.61, reads: 8017.81, writes: 2290.13, response time: 75.41ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 20, tps: 560.90, reads: 7848.89, writes: 2242.80, response time: 80.06ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 20, tps: 559.09, reads: 7830.49, writes: 2237.17, response time: 77.03ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 20, tps: 567.91, reads: 7952.79, writes: 2273.33, response time: 77.59ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 20, tps: 574.69, reads: 8040.23, writes: 2297.38, response time: 74.67ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 20, tps: 571.00, reads: 7989.93, writes: 2281.61, response time: 75.27ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 20, tps: 571.60, reads: 8009.84, writes: 2287.11, response time: 78.76ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 20, tps: 570.90, reads: 7995.57, writes: 2285.49, response time: 76.94ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 20, tps: 572.20, reads: 8009.23, writes: 2289.21, response time: 73.96ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 20, tps: 569.50, reads: 7972.14, writes: 2278.11, response time: 76.14ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 20, tps: 573.55, reads: 8030.12, writes: 2292.41, response time: 76.32ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 20, tps: 558.84, reads: 7817.31, writes: 2237.15, response time: 79.49ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 20, tps: 568.01, reads: 7959.94, writes: 2269.64, response time: 78.71ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 20, tps: 566.69, reads: 7931.26, writes: 2267.56, response time: 78.71ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 20, tps: 566.31, reads: 7929.92, writes: 2265.73, response time: 76.11ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 20, tps: 569.60, reads: 7976.64, writes: 2281.08, response time: 76.30ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 20, tps: 569.40, reads: 7968.72, writes: 2273.61, response time: 78.45ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 20, tps: 568.00, reads: 7950.87, writes: 2274.09, response time: 76.68ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 20, tps: 570.40, reads: 7983.96, writes: 2280.12, response time: 74.96ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 20, tps: 566.75, reads: 7934.26, writes: 2267.52, response time: 77.82ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 20, tps: 572.15, reads: 8014.43, writes: 2291.68, response time: 74.56ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 20, tps: 568.85, reads: 7962.45, writes: 2271.81, response time: 75.34ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 20, tps: 566.04, reads: 7926.81, writes: 2266.17, response time: 76.71ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 20, tps: 565.90, reads: 7918.09, writes: 2262.70, response time: 80.86ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 20, tps: 570.20, reads: 7978.77, writes: 2279.32, response time: 75.89ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 20, tps: 567.09, reads: 7948.02, writes: 2271.08, response time: 77.56ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 20, tps: 565.10, reads: 7912.06, writes: 2262.82, response time: 79.23ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 20, tps: 569.40, reads: 7967.01, writes: 2271.30, response time: 76.18ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 20, tps: 567.49, reads: 7948.80, writes: 2274.14, response time: 75.61ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 20, tps: 571.31, reads: 7985.03, writes: 2281.04, response time: 78.47ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 20, tps: 570.99, reads: 8001.51, writes: 2287.58, response time: 75.12ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 20, tps: 567.50, reads: 7946.45, writes: 2269.11, response time: 76.30ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 20, tps: 569.30, reads: 7966.23, writes: 2275.71, response time: 75.52ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 20, tps: 563.11, reads: 7882.41, writes: 2252.43, response time: 78.14ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 20, tps: 571.19, reads: 7992.77, writes: 2283.16, response time: 76.25ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 20, tps: 565.90, reads: 7932.34, writes: 2265.41, response time: 75.64ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 20, tps: 574.10, reads: 8033.86, writes: 2295.32, response time: 76.32ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 20, tps: 571.70, reads: 8008.57, writes: 2289.49, response time: 78.26ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 20, tps: 569.60, reads: 7974.51, writes: 2277.00, response time: 76.36ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 20, tps: 569.10, reads: 7965.23, writes: 2276.18, response time: 77.96ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 20, tps: 572.21, reads: 8008.28, writes: 2289.22, response time: 74.71ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 20, tps: 573.10, reads: 8020.38, writes: 2292.60, response time: 74.87ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 20, tps: 566.80, reads: 7934.07, writes: 2265.59, response time: 76.85ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 20, tps: 573.70, reads: 8035.86, writes: 2298.02, response time: 75.16ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 20, tps: 571.70, reads: 8007.30, writes: 2287.10, response time: 75.05ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 20, tps: 570.19, reads: 7984.54, writes: 2280.65, response time: 76.34ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 20, tps: 573.81, reads: 8024.32, writes: 2293.43, response time: 77.47ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 20, tps: 571.20, reads: 7998.38, writes: 2284.39, response time: 77.03ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 20, tps: 569.80, reads: 7978.96, writes: 2279.52, response time: 77.89ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 20, tps: 567.18, reads: 7945.87, writes: 2268.73, response time: 74.91ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 20, tps: 566.81, reads: 7935.31, writes: 2268.96, response time: 75.82ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 20, tps: 571.39, reads: 7996.53, writes: 2284.18, response time: 78.99ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 20, tps: 574.41, reads: 8041.91, writes: 2295.93, response time: 76.80ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 20, tps: 568.44, reads: 7962.22, writes: 2276.68, response time: 75.66ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 20, tps: 577.05, reads: 8073.00, writes: 2306.00, response time: 72.84ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 20, tps: 576.40, reads: 8072.33, writes: 2306.61, response time: 75.21ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 20, tps: 573.80, reads: 8028.82, writes: 2293.01, response time: 75.30ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 20, tps: 570.04, reads: 7987.77, writes: 2284.06, response time: 75.48ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 20, tps: 573.56, reads: 8029.78, writes: 2295.12, response time: 75.39ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 20, tps: 571.80, reads: 7996.37, writes: 2282.22, response time: 78.31ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 20, tps: 569.10, reads: 7972.14, writes: 2279.91, response time: 76.25ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 20, tps: 575.69, reads: 8060.92, writes: 2301.05, response time: 74.27ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 20, tps: 572.21, reads: 8014.17, writes: 2289.75, response time: 75.36ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 20, tps: 570.40, reads: 7982.71, writes: 2281.40, response time: 75.12ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 20, tps: 564.30, reads: 7899.93, writes: 2257.28, response time: 80.25ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 20, tps: 571.30, reads: 7994.63, writes: 2284.51, response time: 76.66ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 20, tps: 568.50, reads: 7962.07, writes: 2273.89, response time: 73.91ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 20, tps: 573.69, reads: 8033.31, writes: 2295.47, response time: 76.27ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 20, tps: 572.79, reads: 8021.31, writes: 2292.85, response time: 76.25ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 20, tps: 572.22, reads: 8009.71, writes: 2287.99, response time: 73.47ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            13890310
        write:                           3968660
        other:                           1984330
        total:                           19843300
    transactions:                        992165 (551.20 per sec.)
    read/write requests:                 17858970 (9921.53 per sec.)
    other operations:                    1984330 (1102.39 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0211s
    total number of events:              992165
    total time taken by event execution: 35997.5334s
    response time:
         min:                                  7.05ms
         avg:                                 36.28ms
         max:                                240.57ms
         approx.  99 percentile:              83.26ms

Threads fairness:
    events (avg/stddev):           49608.2500/131.65
    execution time (avg/stddev):   1799.8767/0.00



[root@voice sbtest]# top
top - 11:45:30 up 95 days, 20:43,  4 users,  load average: 17.89, 16.78, 13.55
Tasks: 124 total,   2 running, 122 sleeping,   0 stopped,   0 zombie
%Cpu0  : 64.6 us, 22.8 sy,  0.0 ni,  1.7 id,  2.3 wa,  0.0 hi,  8.6 si,  0.0 st
%Cpu1  : 70.1 us, 20.5 sy,  0.0 ni,  4.0 id,  0.7 wa,  0.0 hi,  4.7 si,  0.0 st
%Cpu2  : 70.1 us, 19.6 sy,  0.0 ni,  3.7 id,  1.7 wa,  0.0 hi,  5.0 si,  0.0 st
%Cpu3  : 69.1 us, 20.6 sy,  0.0 ni,  4.7 id,  0.7 wa,  0.0 hi,  5.0 si,  0.0 st
KiB Mem : 16266300 total,   172080 free, 10076784 used,  6017436 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5088224 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   9.1g   3244 S 312.0 58.4   1028:41 mysqld                                                                                                                                                                    
29260 coding0+  20   0 1349076   4756   1084 S  66.1  0.0   9:57.74 sysbench       



^C
[root@voice sbtest]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/20/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    2.09    5.85     0.14     0.28   109.22     0.08   10.02   23.91    5.06   0.62   0.49

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1204.00     0.00    37.18    63.24     0.93    0.77    0.00    0.77   0.42  50.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1289.00     0.00    34.59    54.96     0.94    0.72    0.00    0.72   0.41  53.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 1243.00     0.00    37.54    61.84     0.94    0.77    0.00    0.77   0.39  48.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1247.00     0.00    33.12    54.40     0.91    0.73    0.00    0.73   0.39  48.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1242.00     0.00    38.52    63.51     0.90    0.72    0.00    0.72   0.38  47.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1211.00     0.00    34.22    57.87     0.88    0.73    0.00    0.73   0.40  49.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1264.00     0.00    36.82    59.66     0.92    0.72    0.00    0.72   0.39  49.30

^C
[root@voice sbtest]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/20/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.59    0.00    0.69    0.18    0.00   98.53

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               7.94       143.58       290.20 1189265990 2403679328

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          70.28    0.00   26.20    1.01    0.00    2.52

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1264.00         0.00     36764.00          0      36764

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          68.08    0.00   27.43    1.50    0.00    2.99

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1219.00         0.00     36756.00          0      36756

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          68.34    0.00   26.63    1.51    0.00    3.52

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1240.59         0.00     36285.15          0      36648



mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-20 11:51:32 0x7fc4c816b700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 29 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 29538 srv_active, 0 srv_shutdown, 119196 srv_idle
srv_master_thread log flush and writes: 148734
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 2510124
OS WAIT ARRAY INFO: signal count 1355912
RW-shared spins 0, rounds 655144, OS waits 145614
RW-excl spins 0, rounds 5300156, OS waits 176752
RW-sx spins 73635, rounds 1966991, OS waits 33400
Spin rounds per wait: 655144.00 RW-shared, 5300156.00 RW-excl, 26.71 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 52161430
Purge done for trx's n:o < 52161395 undo n:o < 0 state: running
History list length 497
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421967708637920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421967708638832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 52161426, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 171, OS thread handle 140483344930560, query id 182646818 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 52161415, sees < 52161394
---TRANSACTION 52161425, ACTIVE 0 sec
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 167, OS thread handle 140483344389888, query id 182646800 192.168.1.12 sysbench
Trx read view will not see trx with id >= 52161415, sees < 52161394
---TRANSACTION 52161424, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 158, OS thread handle 140483034007296, query id 182646812 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 52161401, sees < 52161370
---TRANSACTION 52161423, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 155, OS thread handle 140483146979072, query id 182646821 192.168.1.12 sysbench
Trx read view will not see trx with id >= 52161415, sees < 52161394
---TRANSACTION 52161422, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 162, OS thread handle 140483032655616, query id 182646799 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 52161415, sees < 52161394
---TRANSACTION 52161421, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 172, OS thread handle 140483344660224, query id 182646796 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 52161401, sees < 52161370
---TRANSACTION 52161420, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 161, OS thread handle 140483033196288, query id 182646790 192.168.1.12 sysbench
Trx read view will not see trx with id >= 52161416, sees < 52161394
---TRANSACTION 52161419, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 170, OS thread handle 140483146708736, query id 182646797 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 52161401, sees < 52161370
---TRANSACTION 52161418, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 153, OS thread handle 140483147790080, query id 182646778 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 52161415, sees < 52161394
---TRANSACTION 52161416, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 163, OS thread handle 140483033736960, query id 182646755 192.168.1.12 sysbench
Trx read view will not see trx with id >= 52161401, sees < 52161370
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
Pending flushes (fsync) log: 1; buffer pool: 0
2771024 OS file reads, 35336448 OS file writes, 4884713 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1183.51 writes/s, 324.99 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 162252 merges
merged operations:
 insert 81305, delete mark 140992, delete 44934
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365241, node heap has 5891 buffer(s)
Hash table size 2365241, node heap has 5891 buffer(s)
Hash table size 2365241, node heap has 5891 buffer(s)
Hash table size 2365241, node heap has 5891 buffer(s)
Hash table size 2365241, node heap has 5850 buffer(s)
Hash table size 2365241, node heap has 5623 buffer(s)
Hash table size 2365241, node heap has 2946 buffer(s)
Hash table size 2365241, node heap has 5891 buffer(s)
11163.06 hash searches/s, 8486.02 non-hash searches/s
---
LOG
---
Log sequence number 386015188831
Log flushed up to   386015177576
Pages flushed up to 385631360501
Last checkpoint at  385626204993
1 pending log flushes, 0 pending chkp writes
8065612 log i/o's done, 214.28 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 215408
Buffer pool size   524224
Free buffers       2048
Database pages     478302
Old database pages 176520
Modified db pages  226537
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 45672955, not young 9194872
2645.49 youngs/s, 0.00 non-youngs/s
Pages read 2758954, created 6811449, written 26415689
0.00 reads/s, 0.52 creates/s, 952.07 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 28 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 478302, unzip_LRU len: 0
I/O sum[97058]:cur[972], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1024
Database pages     239175
Old database pages 88269
Modified db pages  113019
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 22824800, not young 4635899
1318.44 youngs/s, 0.00 non-youngs/s
Pages read 1381975, created 3405690, written 13193983
0.00 reads/s, 0.24 creates/s, 475.09 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 28 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239175, unzip_LRU len: 0
I/O sum[48529]:cur[486], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       1024
Database pages     239127
Old database pages 88251
Modified db pages  113518
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 22848155, not young 4558973
1327.06 youngs/s, 0.00 non-youngs/s
Pages read 1376979, created 3405759, written 13221706
0.00 reads/s, 0.28 creates/s, 476.98 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 28 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239127, unzip_LRU len: 0
I/O sum[48529]:cur[486], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
20 read views open inside InnoDB
Process ID=6404, Main thread ID=140483397408512, state: sleeping
Number of rows inserted 469125929, updated 18251507, deleted 9125811, read 3841246402
568.01 inserts/s, 1135.93 updates/s, 568.01 deletes/s, 236825.87 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.01 sec)
