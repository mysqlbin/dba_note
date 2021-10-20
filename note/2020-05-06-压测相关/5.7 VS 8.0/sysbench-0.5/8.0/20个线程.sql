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


purge binary logs to 'mysql-bin.000128';  



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


set global sync_binlog=1000;
set global innodb_flush_log_at_trx_commit=2;
show global variables like '%sync_binlog%';
show global variables like '%innodb_flush_log_at_trx_commit%';
show global variables like '%innodb_io_capacity%';
show global variables like '%time_zone%';

mysql> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 1000  |
+---------------+-------+
1 row in set (0.05 sec)

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
2 rows in set (0.00 sec)

mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | SYSTEM |
+---------------+--------+
1 row in set (0.01 sec)


purge binary logs to 'mysql-bin.000153';  


./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=20 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_20_not11.log &


[coding001@voice log]$ tail -f  /home/coding001/log/sysbench_oltpX_20_not11.log
Number of threads: 20
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 20, tps: 504.49, reads: 7079.66, writes: 2019.06, response time: 120.72ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 20, tps: 514.90, reads: 7212.62, writes: 2060.21, response time: 127.86ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 20, tps: 535.40, reads: 7492.24, writes: 2140.21, response time: 108.52ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 20, tps: 528.79, reads: 7403.27, writes: 2115.56, response time: 112.05ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 20, tps: 511.19, reads: 7158.39, writes: 2044.44, response time: 110.29ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 20, tps: 504.92, reads: 7072.24, writes: 2020.00, response time: 114.08ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 20, tps: 482.87, reads: 6754.31, writes: 1931.79, response time: 120.47ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 20, tps: 476.22, reads: 6670.74, writes: 1904.60, response time: 128.02ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 20, tps: 482.19, reads: 6748.16, writes: 1929.76, response time: 121.89ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 20, tps: 491.27, reads: 6884.66, writes: 1966.87, response time: 124.65ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 20, tps: 494.94, reads: 6921.73, writes: 1976.98, response time: 116.64ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 20, tps: 491.30, reads: 6878.46, writes: 1965.29, response time: 117.30ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 20, tps: 491.20, reads: 6881.37, writes: 1964.69, response time: 119.32ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 20, tps: 494.10, reads: 6916.25, writes: 1977.12, response time: 115.80ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 20, tps: 491.89, reads: 6886.05, writes: 1967.76, response time: 120.69ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 20, tps: 497.01, reads: 6957.62, writes: 1986.43, response time: 113.95ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 20, tps: 499.70, reads: 6988.65, writes: 1999.31, response time: 114.29ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 20, tps: 503.80, reads: 7058.27, writes: 2016.19, response time: 112.32ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 20, tps: 515.10, reads: 7208.47, writes: 2059.89, response time: 110.52ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 20, tps: 514.70, reads: 7209.42, writes: 2058.20, response time: 113.54ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 20, tps: 522.09, reads: 7304.80, writes: 2088.57, response time: 114.01ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 20, tps: 533.40, reads: 7472.35, writes: 2134.61, response time: 109.50ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 20, tps: 532.10, reads: 7449.40, writes: 2127.00, response time: 106.97ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 20, tps: 530.71, reads: 7430.08, writes: 2123.22, response time: 112.46ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 20, tps: 538.50, reads: 7532.63, writes: 2153.61, response time: 108.68ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 20, tps: 542.19, reads: 7597.41, writes: 2169.48, response time: 100.57ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 20, tps: 544.70, reads: 7627.97, writes: 2179.42, response time: 103.48ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 20, tps: 557.79, reads: 7805.18, writes: 2230.06, response time: 99.77ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 20, tps: 559.37, reads: 7836.70, writes: 2237.99, response time: 99.56ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 20, tps: 555.64, reads: 7773.31, writes: 2222.15, response time: 101.70ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 20, tps: 557.55, reads: 7810.07, writes: 2230.72, response time: 95.93ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 20, tps: 557.64, reads: 7803.75, writes: 2230.96, response time: 99.47ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 20, tps: 563.11, reads: 7884.08, writes: 2252.02, response time: 100.67ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 20, tps: 564.60, reads: 7901.97, writes: 2257.99, response time: 98.61ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 20, tps: 563.59, reads: 7891.19, writes: 2254.44, response time: 99.68ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 20, tps: 566.91, reads: 7938.15, writes: 2268.04, response time: 96.27ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 20, tps: 567.50, reads: 7943.86, writes: 2270.29, response time: 89.49ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 20, tps: 557.40, reads: 7803.75, writes: 2229.21, response time: 101.57ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 20, tps: 563.20, reads: 7882.93, writes: 2252.41, response time: 94.84ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 20, tps: 557.40, reads: 7805.84, writes: 2229.81, response time: 96.71ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 20, tps: 568.40, reads: 7961.31, writes: 2273.40, response time: 93.24ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 20, tps: 569.40, reads: 7970.01, writes: 2278.20, response time: 90.52ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 20, tps: 576.14, reads: 8065.99, writes: 2303.94, response time: 89.49ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 20, tps: 565.66, reads: 7914.88, writes: 2262.82, response time: 95.47ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 20, tps: 568.99, reads: 7969.32, writes: 2275.65, response time: 92.43ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 20, tps: 563.81, reads: 7893.38, writes: 2255.82, response time: 96.07ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 20, tps: 565.91, reads: 7921.91, writes: 2263.03, response time: 96.62ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 20, tps: 565.90, reads: 7920.95, writes: 2263.89, response time: 93.52ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 20, tps: 572.91, reads: 8022.53, writes: 2291.44, response time: 86.72ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 20, tps: 564.19, reads: 7897.58, writes: 2256.47, response time: 97.06ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 20, tps: 565.04, reads: 7911.68, writes: 2260.17, response time: 99.05ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 20, tps: 565.07, reads: 7910.85, writes: 2259.97, response time: 97.17ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 20, tps: 566.90, reads: 7933.64, writes: 2268.08, response time: 94.31ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 20, tps: 571.35, reads: 8002.92, writes: 2286.41, response time: 96.68ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 20, tps: 568.45, reads: 7956.44, writes: 2272.81, response time: 95.44ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 20, tps: 569.69, reads: 7980.19, writes: 2279.67, response time: 92.16ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 20, tps: 569.11, reads: 7961.80, writes: 2275.53, response time: 94.73ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 20, tps: 554.33, reads: 7762.78, writes: 2217.31, response time: 107.58ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 20, tps: 451.96, reads: 6328.03, writes: 1808.44, response time: 135.10ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 20, tps: 569.48, reads: 7971.01, writes: 2277.02, response time: 95.81ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 20, tps: 572.62, reads: 8015.73, writes: 2291.07, response time: 92.05ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 20, tps: 571.20, reads: 7998.84, writes: 2285.31, response time: 93.69ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 20, tps: 569.30, reads: 7969.28, writes: 2277.49, response time: 92.85ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 20, tps: 570.70, reads: 7982.22, writes: 2281.20, response time: 89.73ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 20, tps: 568.28, reads: 7963.14, writes: 2273.93, response time: 88.51ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 20, tps: 570.50, reads: 7987.37, writes: 2281.72, response time: 88.96ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 20, tps: 571.21, reads: 7999.90, writes: 2284.86, response time: 94.67ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 20, tps: 570.18, reads: 7983.71, writes: 2280.52, response time: 90.38ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 20, tps: 571.40, reads: 7991.54, writes: 2285.41, response time: 87.74ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 20, tps: 570.61, reads: 7997.57, writes: 2284.55, response time: 90.27ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 20, tps: 567.70, reads: 7945.44, writes: 2269.61, response time: 94.93ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 20, tps: 572.70, reads: 8011.82, writes: 2290.91, response time: 89.36ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 20, tps: 573.40, reads: 8031.55, writes: 2292.89, response time: 88.59ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 20, tps: 569.50, reads: 7969.55, writes: 2278.21, response time: 91.42ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 20, tps: 570.00, reads: 7983.93, writes: 2280.41, response time: 89.28ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 20, tps: 568.60, reads: 7961.32, writes: 2274.21, response time: 90.57ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 20, tps: 568.79, reads: 7961.29, writes: 2275.57, response time: 94.82ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 20, tps: 569.28, reads: 7970.85, writes: 2276.30, response time: 93.04ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 20, tps: 570.48, reads: 7981.97, writes: 2281.74, response time: 89.09ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 20, tps: 567.44, reads: 7951.87, writes: 2270.66, response time: 96.07ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 20, tps: 579.20, reads: 8103.35, writes: 2315.81, response time: 88.19ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 20, tps: 578.70, reads: 8105.02, writes: 2315.80, response time: 88.14ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 20, tps: 573.40, reads: 8025.05, writes: 2293.11, response time: 90.35ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 20, tps: 572.50, reads: 8016.36, writes: 2289.79, response time: 91.69ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 20, tps: 569.07, reads: 7967.28, writes: 2277.38, response time: 91.33ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 20, tps: 573.13, reads: 8021.93, writes: 2291.12, response time: 88.72ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 20, tps: 575.59, reads: 8061.30, writes: 2304.74, response time: 89.33ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 20, tps: 576.71, reads: 8077.04, writes: 2305.34, response time: 86.10ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 20, tps: 579.60, reads: 8110.36, writes: 2318.22, response time: 90.41ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 20, tps: 577.20, reads: 8077.81, writes: 2308.50, response time: 88.22ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 20, tps: 584.44, reads: 8188.37, writes: 2338.66, response time: 85.64ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 20, tps: 576.16, reads: 8063.20, writes: 2304.43, response time: 88.93ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 20, tps: 576.69, reads: 8078.02, writes: 2307.48, response time: 90.14ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 20, tps: 574.00, reads: 8032.93, writes: 2295.08, response time: 91.88ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 20, tps: 581.01, reads: 8130.35, writes: 2323.84, response time: 88.88ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 20, tps: 581.80, reads: 8145.46, writes: 2326.69, response time: 89.36ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 20, tps: 580.19, reads: 8124.43, writes: 2320.88, response time: 89.95ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 20, tps: 566.01, reads: 7923.90, writes: 2264.33, response time: 99.71ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 20, tps: 569.40, reads: 7977.15, writes: 2277.79, response time: 92.79ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 20, tps: 568.80, reads: 7959.17, writes: 2274.99, response time: 86.23ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 20, tps: 565.81, reads: 7917.09, writes: 2263.33, response time: 91.99ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 20, tps: 565.99, reads: 7930.71, writes: 2264.28, response time: 94.00ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 20, tps: 570.20, reads: 7980.16, writes: 2280.22, response time: 91.63ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 20, tps: 564.59, reads: 7906.71, writes: 2259.38, response time: 94.08ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 20, tps: 574.91, reads: 8047.43, writes: 2298.24, response time: 91.11ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 20, tps: 572.00, reads: 8011.48, writes: 2288.30, response time: 91.25ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 20, tps: 572.29, reads: 8008.60, writes: 2290.07, response time: 91.74ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 20, tps: 567.00, reads: 7937.84, writes: 2267.38, response time: 97.52ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 20, tps: 570.30, reads: 7986.24, writes: 2282.81, response time: 91.50ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 20, tps: 557.31, reads: 7799.84, writes: 2227.14, response time: 98.05ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 20, tps: 550.00, reads: 7700.46, writes: 2200.39, response time: 96.68ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 20, tps: 544.60, reads: 7622.50, writes: 2178.20, response time: 93.77ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 20, tps: 554.30, reads: 7760.50, writes: 2217.80, response time: 97.99ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 20, tps: 490.89, reads: 6874.07, writes: 1963.26, response time: 105.41ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 20, tps: 485.41, reads: 6797.15, writes: 1942.24, response time: 102.12ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 20, tps: 541.70, reads: 7581.10, writes: 2166.10, response time: 92.71ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 20, tps: 554.80, reads: 7764.06, writes: 2219.09, response time: 95.96ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 20, tps: 563.69, reads: 7895.03, writes: 2254.48, response time: 91.44ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 20, tps: 567.06, reads: 7941.28, writes: 2268.65, response time: 94.19ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 20, tps: 578.75, reads: 8100.14, writes: 2314.58, response time: 88.77ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 20, tps: 573.19, reads: 8024.72, writes: 2293.48, response time: 93.55ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 20, tps: 572.30, reads: 8015.51, writes: 2289.60, response time: 89.17ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 20, tps: 570.30, reads: 7980.95, writes: 2281.01, response time: 87.40ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 20, tps: 556.90, reads: 7796.54, writes: 2227.31, response time: 94.50ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 20, tps: 557.18, reads: 7804.54, writes: 2228.82, response time: 96.10ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 20, tps: 564.52, reads: 7897.45, writes: 2258.37, response time: 90.87ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 20, tps: 563.10, reads: 7887.01, writes: 2252.40, response time: 94.08ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 20, tps: 566.90, reads: 7933.97, writes: 2267.59, response time: 94.14ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 20, tps: 567.09, reads: 7941.22, writes: 2267.88, response time: 94.99ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 20, tps: 566.60, reads: 7935.66, writes: 2266.59, response time: 89.63ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 20, tps: 569.69, reads: 7972.26, writes: 2278.46, response time: 94.90ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 20, tps: 565.52, reads: 7914.98, writes: 2261.78, response time: 89.68ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 20, tps: 567.90, reads: 7955.59, writes: 2271.60, response time: 89.90ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 20, tps: 557.49, reads: 7800.47, writes: 2230.26, response time: 94.02ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 20, tps: 555.20, reads: 7773.85, writes: 2221.11, response time: 97.55ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 20, tps: 563.27, reads: 7881.41, writes: 2252.56, response time: 91.33ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 20, tps: 562.04, reads: 7876.21, writes: 2248.74, response time: 90.49ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 20, tps: 562.60, reads: 7874.29, writes: 2249.80, response time: 94.36ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 20, tps: 565.09, reads: 7911.66, writes: 2261.06, response time: 93.30ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 20, tps: 565.18, reads: 7909.26, writes: 2260.50, response time: 93.46ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 20, tps: 565.44, reads: 7912.68, writes: 2262.37, response time: 89.90ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 20, tps: 566.20, reads: 7934.40, writes: 2263.30, response time: 90.92ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 20, tps: 567.76, reads: 7945.65, writes: 2271.94, response time: 96.25ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 20, tps: 566.73, reads: 7936.44, writes: 2266.42, response time: 86.46ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 20, tps: 568.01, reads: 7948.98, writes: 2272.92, response time: 93.63ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 20, tps: 569.79, reads: 7977.61, writes: 2278.27, response time: 90.14ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 20, tps: 565.90, reads: 7924.10, writes: 2263.90, response time: 91.85ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 20, tps: 571.80, reads: 8005.47, writes: 2286.92, response time: 89.12ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 20, tps: 569.10, reads: 7967.43, writes: 2277.11, response time: 88.43ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 20, tps: 568.29, reads: 7957.51, writes: 2272.77, response time: 93.10ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 20, tps: 568.71, reads: 7960.10, writes: 2275.83, response time: 91.80ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 20, tps: 568.79, reads: 7962.98, writes: 2274.37, response time: 91.77ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 20, tps: 571.40, reads: 7999.80, writes: 2284.80, response time: 90.52ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 20, tps: 567.41, reads: 7944.81, writes: 2270.13, response time: 93.10ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 20, tps: 371.79, reads: 5200.43, writes: 1487.38, response time: 139.96ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 20, tps: 543.50, reads: 7614.66, writes: 2173.99, response time: 95.87ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 20, tps: 567.80, reads: 7944.32, writes: 2270.71, response time: 92.71ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 20, tps: 555.01, reads: 7774.72, writes: 2220.03, response time: 95.30ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 20, tps: 569.00, reads: 7967.40, writes: 2276.00, response time: 95.04ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 20, tps: 570.00, reads: 7977.40, writes: 2280.60, response time: 91.77ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 20, tps: 569.90, reads: 7978.89, writes: 2280.10, response time: 88.38ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 20, tps: 571.30, reads: 7997.41, writes: 2285.70, response time: 89.04ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 20, tps: 569.70, reads: 7976.64, writes: 2279.18, response time: 87.85ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 20, tps: 570.20, reads: 7979.84, writes: 2278.48, response time: 92.54ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 20, tps: 570.31, reads: 7990.33, writes: 2281.74, response time: 88.03ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 20, tps: 564.00, reads: 7892.79, writes: 2255.50, response time: 93.69ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 20, tps: 571.20, reads: 7999.30, writes: 2285.70, response time: 93.04ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 20, tps: 560.89, reads: 7849.40, writes: 2243.97, response time: 93.86ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 20, tps: 562.21, reads: 7870.53, writes: 2248.24, response time: 96.16ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 20, tps: 554.90, reads: 7759.79, writes: 2219.20, response time: 97.17ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 20, tps: 555.50, reads: 7789.08, writes: 2222.40, response time: 92.35ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 20, tps: 542.19, reads: 7586.54, writes: 2168.95, response time: 94.53ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 20, tps: 546.91, reads: 7659.67, writes: 2188.65, response time: 93.69ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 20, tps: 536.20, reads: 7506.18, writes: 2143.49, response time: 93.35ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 20, tps: 537.70, reads: 7524.05, writes: 2150.48, response time: 98.93ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 20, tps: 541.99, reads: 7593.23, writes: 2168.48, response time: 92.18ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 20, tps: 536.01, reads: 7503.08, writes: 2143.82, response time: 97.03ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 20, tps: 546.39, reads: 7647.99, writes: 2185.27, response time: 92.96ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 20, tps: 537.91, reads: 7533.30, writes: 2151.96, response time: 95.01ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 20, tps: 528.09, reads: 7389.39, writes: 2112.47, response time: 96.19ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            13975248
        write:                           3992928
        other:                           1996464
        total:                           19964640
    transactions:                        998232 (554.56 per sec.)
    read/write requests:                 17968176 (9982.13 per sec.)
    other operations:                    1996464 (1109.13 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0337s
    total number of events:              998232
    total time taken by event execution: 35997.5924s
    response time:
         min:                                  3.95ms
         avg:                                 36.06ms
         max:                                272.74ms
         approx.  99 percentile:              98.81ms

Threads fairness:
    events (avg/stddev):           49911.6000/116.10
    execution time (avg/stddev):   1799.8796/0.01


[root@voice sbtest]# top
top - 10:50:39 up 95 days, 19:48,  4 users,  load average: 9.32, 7.66, 5.77
Tasks: 125 total,   2 running, 123 sleeping,   0 stopped,   0 zombie
%Cpu0  : 70.0 us, 20.0 sy,  0.0 ni,  1.7 id,  2.7 wa,  0.0 hi,  5.7 si,  0.0 st
%Cpu1  : 70.8 us, 19.6 sy,  0.0 ni,  3.7 id,  1.0 wa,  0.0 hi,  5.0 si,  0.0 st
%Cpu2  : 70.1 us, 20.6 sy,  0.0 ni,  3.7 id,  0.3 wa,  0.0 hi,  5.3 si,  0.0 st
%Cpu3  : 71.7 us, 18.7 sy,  0.0 ni,  4.7 id,  0.0 wa,  0.0 hi,  5.0 si,  0.0 st
KiB Mem : 16266300 total,   170576 free, 10074132 used,  6021592 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5091560 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   9.1g   4132 S 312.6 58.4 899:48.00 mysqld                                                                                                                                                                    
25496 coding0+  20   0 1349076   5748   1856 S  67.1  0.0   4:14.29 sysbench     


[root@voice sbtest]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/20/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    2.09    5.55     0.14     0.27   109.13     0.08   10.18   23.92    5.01   0.63   0.48

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  496.00     0.00    33.09   136.63     0.57    1.15    0.00    1.15   0.38  18.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  456.00     0.00    32.36   145.33     0.49    1.08    0.00    1.08   0.38  17.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  554.00     0.00    34.79   128.59     0.61    1.10    0.00    1.10   0.36  19.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  453.00     0.00    32.73   147.99     0.54    1.19    0.00    1.19   0.39  17.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  513.00     0.00    35.25   140.74     0.59    1.15    0.00    1.15   0.37  18.90

^C
[root@voice sbtest]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/20/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.57    0.00    0.69    0.18    0.00   98.56

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               7.64       143.52       273.22 1188287442 2262116992

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          69.35    0.00   24.62    1.26    0.00    4.77

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             530.00         0.00     35768.00          0      35768

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          69.75    0.00   24.25    1.50    0.00    4.50

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             515.00         0.00     33720.00          0      33720

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          69.60    0.00   25.13    1.26    0.00    4.02

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             528.00         0.00     35640.00          0      35640





mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-20 10:54:07 0x7fc4c816b700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 11 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 26527 srv_active, 0 srv_shutdown, 118850 srv_idle
srv_master_thread log flush and writes: 145377
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 1901616
OS WAIT ARRAY INFO: signal count 1131489
RW-shared spins 0, rounds 538563, OS waits 107788
RW-excl spins 0, rounds 3614791, OS waits 108115
RW-sx spins 62613, rounds 1682097, OS waits 29188
Spin rounds per wait: 538563.00 RW-shared, 3614791.00 RW-excl, 26.86 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 49403303
Purge done for trx's n:o < 49403255 undo n:o < 0 state: running
History list length 169
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421967708643392, not started
mysql tables in use 1, locked 0
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421967708640656, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421967708637920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421967708638832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 49403302, ACTIVE 0 sec
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 134, OS thread handle 140483146979072, query id 155172711 192.168.1.12 sysbench query end
UPDATE sbtest12 SET k=k+1 WHERE id=295790
Trx read view will not see trx with id >= 49403272, sees < 49403267
---TRANSACTION 49403301, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 144, OS thread handle 140483344930560, query id 155172693 192.168.1.12 sysbench
Trx read view will not see trx with id >= 49403270, sees < 49403260
---TRANSACTION 49403300, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 140, OS thread handle 140483032925952, query id 155172694 192.168.1.12 sysbench
Trx read view will not see trx with id >= 49403273, sees < 49403267
---TRANSACTION 49403298, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 150, OS thread handle 140483031844608, query id 155172685 192.168.1.12 sysbench
Trx read view will not see trx with id >= 49403282, sees < 49403273
---TRANSACTION 49403297, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 145, OS thread handle 140483146438400, query id 155172699 192.168.1.12 sysbench
Trx read view will not see trx with id >= 49403269, sees < 49403260
---TRANSACTION 49403295, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 143, OS thread handle 140483033736960, query id 155172707 192.168.1.12 sysbench
Trx read view will not see trx with id >= 49403265, sees < 49403246
---TRANSACTION 49403290, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 146, OS thread handle 140483146708736, query id 155172678 192.168.1.12 sysbench
Trx read view will not see trx with id >= 49403273, sees < 49403267
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
Pending flushes (fsync) log: 0; buffer pool: 0
2769373 OS file reads, 31224127 OS file writes, 4265561 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1590.49 writes/s, 123.44 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 162252 merges
merged operations:
 insert 81305, delete mark 140992, delete 44934
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365241, node heap has 5890 buffer(s)
Hash table size 2365241, node heap has 5729 buffer(s)
Hash table size 2365241, node heap has 5721 buffer(s)
Hash table size 2365241, node heap has 5891 buffer(s)
Hash table size 2365241, node heap has 5867 buffer(s)
Hash table size 2365241, node heap has 2946 buffer(s)
Hash table size 2365241, node heap has 5890 buffer(s)
Hash table size 2365241, node heap has 5890 buffer(s)
11348.24 hash searches/s, 8748.57 non-hash searches/s
---
LOG
---
Log sequence number 374851830367
Log flushed up to   374851409941
Pages flushed up to 374470130004
Last checkpoint at  374465664731
0 pending log flushes, 0 pending chkp writes
7140193 log i/o's done, 577.00 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 215408
Buffer pool size   524224
Free buffers       2048
Database pages     478352
Old database pages 176538
Modified db pages  211284
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 39082535, not young 9193892
2632.49 youngs/s, 0.00 non-youngs/s
Pages read 2758923, created 6367213, written 23310721
0.00 reads/s, 1.09 creates/s, 995.73 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 27 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 478352, unzip_LRU len: 0
I/O sum[99856]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1024
Database pages     239228
Old database pages 88288
Modified db pages  105466
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 19531618, not young 4635015
1329.42 youngs/s, 0.00 non-youngs/s
Pages read 1381946, created 3183638, written 11642098
0.00 reads/s, 0.36 creates/s, 503.86 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 27 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239228, unzip_LRU len: 0
I/O sum[49928]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       1024
Database pages     239124
Old database pages 88250
Modified db pages  105818
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 19550917, not young 4558877
1303.06 youngs/s, 0.00 non-youngs/s
Pages read 1376977, created 3183575, written 11668623
0.00 reads/s, 0.73 creates/s, 491.86 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 27 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239124, unzip_LRU len: 0
I/O sum[49928]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
18 read views open inside InnoDB
Process ID=6404, Main thread ID=140483397408512, state: sleeping
Number of rows inserted 437752784, updated 15505213, deleted 7752655, read 3268672150
579.04 inserts/s, 1158.44 updates/s, 579.13 deletes/s, 241566.58 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.00 sec)
