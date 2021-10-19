


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
show global variables like '%innodb_io_capacity%';
show global variables like 'time_zone';


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
1 row in set (0.00 sec)


purge binary logs to 'mysql-bin.000072';  


./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_10_not11.log &



[root@voice mysql]# cat /home/coding001/log/sysbench_oltpX_10_not11.log
sysbench 0.5:  multi-threaded system evaluation benchmark

Running the test with following options:
Number of threads: 10
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 10, tps: 492.89, reads: 6911.19, writes: 1972.34, response time: 61.14ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 10, tps: 435.40, reads: 6092.66, writes: 1740.82, response time: 71.56ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 10, tps: 434.90, reads: 6089.66, writes: 1739.99, response time: 71.16ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 10, tps: 416.00, reads: 5823.13, writes: 1663.78, response time: 72.73ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 10, tps: 438.91, reads: 6147.39, writes: 1755.63, response time: 63.24ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 10, tps: 398.00, reads: 5568.59, writes: 1592.00, response time: 72.79ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 10, tps: 329.30, reads: 4612.56, writes: 1317.72, response time: 87.45ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 10, tps: 327.50, reads: 4585.30, writes: 1309.70, response time: 85.10ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 10, tps: 329.40, reads: 4606.60, writes: 1317.20, response time: 88.93ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 10, tps: 323.90, reads: 4535.79, writes: 1295.60, response time: 92.46ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 10, tps: 329.20, reads: 4609.71, writes: 1317.10, response time: 87.04ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 10, tps: 331.20, reads: 4643.69, writes: 1328.50, response time: 82.82ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 10, tps: 443.30, reads: 6202.78, writes: 1770.09, response time: 74.71ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 10, tps: 503.59, reads: 7047.71, writes: 2013.88, response time: 54.27ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 10, tps: 508.11, reads: 7114.91, writes: 2032.73, response time: 54.46ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 10, tps: 517.09, reads: 7235.73, writes: 2068.25, response time: 53.51ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 10, tps: 525.61, reads: 7360.58, writes: 2102.22, response time: 52.70ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 10, tps: 530.46, reads: 7426.24, writes: 2121.64, response time: 52.86ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 10, tps: 533.85, reads: 7474.95, writes: 2135.99, response time: 50.92ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 10, tps: 536.07, reads: 7506.28, writes: 2143.78, response time: 50.78ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 10, tps: 543.53, reads: 7608.36, writes: 2174.00, response time: 52.51ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 10, tps: 549.10, reads: 7685.23, writes: 2196.21, response time: 48.99ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 10, tps: 551.70, reads: 7726.79, writes: 2207.10, response time: 49.85ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 10, tps: 557.60, reads: 7806.14, writes: 2230.21, response time: 49.06ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 10, tps: 564.10, reads: 7897.08, writes: 2256.70, response time: 46.68ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 10, tps: 561.80, reads: 7863.59, writes: 2247.30, response time: 47.40ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 10, tps: 567.87, reads: 7952.10, writes: 2271.39, response time: 45.17ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 10, tps: 565.72, reads: 7918.91, writes: 2262.49, response time: 47.15ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 10, tps: 563.10, reads: 7883.53, writes: 2253.21, response time: 48.07ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 10, tps: 570.10, reads: 7982.32, writes: 2280.01, response time: 43.03ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 10, tps: 582.40, reads: 8154.16, writes: 2329.39, response time: 42.56ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 10, tps: 583.90, reads: 8173.51, writes: 2335.60, response time: 41.11ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 10, tps: 582.81, reads: 8159.49, writes: 2331.83, response time: 41.21ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 10, tps: 584.77, reads: 8187.82, writes: 2338.29, response time: 42.02ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 10, tps: 580.97, reads: 8135.00, writes: 2324.59, response time: 42.41ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 10, tps: 587.43, reads: 8223.48, writes: 2349.54, response time: 38.38ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 10, tps: 594.61, reads: 8322.66, writes: 2377.94, response time: 39.41ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 10, tps: 598.21, reads: 8372.45, writes: 2392.84, response time: 35.85ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 10, tps: 594.40, reads: 8324.96, writes: 2378.59, response time: 38.51ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 10, tps: 591.80, reads: 8283.66, writes: 2367.12, response time: 38.13ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 10, tps: 596.00, reads: 8344.47, writes: 2383.29, response time: 36.09ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 10, tps: 594.40, reads: 8323.44, writes: 2378.41, response time: 37.00ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 10, tps: 596.89, reads: 8356.90, writes: 2387.27, response time: 37.41ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 10, tps: 594.10, reads: 8318.06, writes: 2376.52, response time: 37.72ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 10, tps: 604.10, reads: 8454.68, writes: 2415.69, response time: 34.40ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 10, tps: 590.90, reads: 8273.24, writes: 2364.18, response time: 39.09ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 10, tps: 601.91, reads: 8427.99, writes: 2407.23, response time: 35.45ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 10, tps: 605.30, reads: 8475.40, writes: 2421.80, response time: 34.99ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 10, tps: 599.40, reads: 8388.57, writes: 2397.59, response time: 35.78ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 10, tps: 598.39, reads: 8377.95, writes: 2393.06, response time: 33.91ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 10, tps: 598.61, reads: 8382.01, writes: 2394.76, response time: 35.98ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 10, tps: 583.40, reads: 8165.99, writes: 2332.90, response time: 42.18ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 10, tps: 582.58, reads: 8157.19, writes: 2330.54, response time: 43.20ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 10, tps: 581.40, reads: 8139.26, writes: 2326.22, response time: 41.05ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 10, tps: 580.81, reads: 8129.24, writes: 2322.44, response time: 39.84ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 10, tps: 582.19, reads: 8152.93, writes: 2329.58, response time: 42.32ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 10, tps: 582.11, reads: 8149.09, writes: 2327.63, response time: 41.54ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 10, tps: 573.30, reads: 8027.40, writes: 2293.70, response time: 43.33ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 10, tps: 578.20, reads: 8091.19, writes: 2312.70, response time: 40.57ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 10, tps: 571.59, reads: 8003.16, writes: 2286.26, response time: 45.02ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 10, tps: 572.61, reads: 8017.36, writes: 2290.24, response time: 43.49ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 10, tps: 572.89, reads: 8022.22, writes: 2291.85, response time: 44.04ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 10, tps: 567.61, reads: 7948.07, writes: 2270.95, response time: 43.42ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 10, tps: 556.39, reads: 7785.02, writes: 2224.68, response time: 46.09ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 10, tps: 570.20, reads: 7982.68, writes: 2280.99, response time: 42.51ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 10, tps: 568.00, reads: 7954.86, writes: 2272.42, response time: 43.60ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 10, tps: 565.04, reads: 7906.94, writes: 2259.55, response time: 44.65ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 10, tps: 567.26, reads: 7943.51, writes: 2269.46, response time: 42.90ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 10, tps: 566.10, reads: 7926.97, writes: 2264.19, response time: 44.98ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 10, tps: 563.80, reads: 7893.11, writes: 2255.50, response time: 45.54ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 10, tps: 569.87, reads: 7976.37, writes: 2279.08, response time: 43.93ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 10, tps: 566.58, reads: 7933.54, writes: 2266.33, response time: 42.69ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 10, tps: 568.15, reads: 7954.87, writes: 2272.69, response time: 43.71ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 10, tps: 560.00, reads: 7839.27, writes: 2240.49, response time: 45.88ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 10, tps: 558.90, reads: 7825.07, writes: 2234.89, response time: 45.17ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 10, tps: 560.60, reads: 7846.04, writes: 2242.81, response time: 46.38ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 10, tps: 559.00, reads: 7824.48, writes: 2235.79, response time: 46.52ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 10, tps: 559.60, reads: 7836.21, writes: 2238.50, response time: 45.52ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 10, tps: 556.40, reads: 7791.65, writes: 2226.41, response time: 47.47ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 10, tps: 557.69, reads: 7805.75, writes: 2230.26, response time: 45.51ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 10, tps: 558.91, reads: 7823.42, writes: 2235.53, response time: 46.87ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 10, tps: 558.59, reads: 7820.58, writes: 2233.97, response time: 47.27ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 10, tps: 558.11, reads: 7816.95, writes: 2233.44, response time: 46.85ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 10, tps: 558.80, reads: 7820.18, writes: 2234.19, response time: 46.36ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 10, tps: 564.30, reads: 7903.63, writes: 2257.61, response time: 46.16ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 10, tps: 562.30, reads: 7873.27, writes: 2249.29, response time: 46.05ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 10, tps: 567.50, reads: 7942.01, writes: 2270.20, response time: 44.42ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 10, tps: 573.10, reads: 8024.05, writes: 2292.29, response time: 45.69ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 10, tps: 574.00, reads: 8033.77, writes: 2295.29, response time: 44.94ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 10, tps: 570.70, reads: 7990.43, writes: 2283.21, response time: 44.58ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 10, tps: 576.60, reads: 8072.76, writes: 2306.29, response time: 43.77ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 10, tps: 571.84, reads: 8006.39, writes: 2287.74, response time: 44.58ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 10, tps: 577.77, reads: 8088.65, writes: 2311.17, response time: 43.46ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 10, tps: 578.61, reads: 8101.68, writes: 2314.12, response time: 44.06ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 10, tps: 578.99, reads: 8106.22, writes: 2316.78, response time: 44.71ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 10, tps: 574.85, reads: 8045.56, writes: 2298.12, response time: 44.35ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 10, tps: 577.05, reads: 8079.44, writes: 2308.48, response time: 43.84ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 10, tps: 579.11, reads: 8106.67, writes: 2316.12, response time: 43.29ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 10, tps: 585.89, reads: 8202.81, writes: 2343.85, response time: 41.30ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 10, tps: 583.41, reads: 8171.78, writes: 2334.95, response time: 42.76ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 10, tps: 578.20, reads: 8093.53, writes: 2311.98, response time: 43.19ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 10, tps: 576.80, reads: 8074.35, writes: 2307.02, response time: 42.51ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 10, tps: 573.00, reads: 8020.29, writes: 2291.80, response time: 43.88ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 10, tps: 577.00, reads: 8076.94, writes: 2307.61, response time: 42.09ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 10, tps: 579.79, reads: 8119.02, writes: 2319.78, response time: 45.09ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 10, tps: 578.50, reads: 8099.08, writes: 2313.79, response time: 43.79ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 10, tps: 580.80, reads: 8131.28, writes: 2323.39, response time: 43.81ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 10, tps: 581.70, reads: 8145.72, writes: 2327.31, response time: 42.34ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 10, tps: 583.80, reads: 8170.02, writes: 2334.91, response time: 42.75ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 10, tps: 578.20, reads: 8097.78, writes: 2312.10, response time: 42.90ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 10, tps: 576.91, reads: 8075.17, writes: 2308.12, response time: 43.42ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 10, tps: 580.60, reads: 8127.43, writes: 2322.11, response time: 41.84ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 10, tps: 578.27, reads: 8095.31, writes: 2313.39, response time: 41.64ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 10, tps: 578.72, reads: 8101.05, writes: 2314.80, response time: 43.66ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 10, tps: 575.70, reads: 8059.77, writes: 2302.29, response time: 43.55ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 10, tps: 579.40, reads: 8115.32, writes: 2318.61, response time: 43.06ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 10, tps: 579.10, reads: 8103.71, writes: 2315.90, response time: 41.86ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 10, tps: 576.29, reads: 8071.32, writes: 2305.18, response time: 42.32ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 10, tps: 572.70, reads: 8014.44, writes: 2290.71, response time: 44.98ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 10, tps: 576.70, reads: 8076.83, writes: 2307.11, response time: 42.42ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 10, tps: 572.00, reads: 8008.85, writes: 2287.49, response time: 44.50ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 10, tps: 574.29, reads: 8038.20, writes: 2297.27, response time: 44.02ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 10, tps: 571.41, reads: 7997.59, writes: 2286.12, response time: 44.63ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 10, tps: 556.29, reads: 7790.65, writes: 2224.56, response time: 46.70ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 10, tps: 569.55, reads: 7971.91, writes: 2278.00, response time: 44.49ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 10, tps: 568.16, reads: 7954.67, writes: 2273.05, response time: 43.03ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 10, tps: 564.80, reads: 7908.04, writes: 2259.11, response time: 46.02ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 10, tps: 567.35, reads: 7942.73, writes: 2269.58, response time: 43.24ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 10, tps: 571.23, reads: 7997.59, writes: 2284.51, response time: 43.41ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 10, tps: 566.72, reads: 7935.25, writes: 2267.50, response time: 44.92ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 10, tps: 570.78, reads: 7990.30, writes: 2283.41, response time: 44.33ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 10, tps: 570.82, reads: 7991.70, writes: 2282.58, response time: 44.18ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 10, tps: 564.70, reads: 7905.76, writes: 2259.02, response time: 44.77ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 10, tps: 567.78, reads: 7948.30, writes: 2270.81, response time: 46.02ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 10, tps: 566.42, reads: 7930.99, writes: 2265.88, response time: 44.67ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 10, tps: 565.88, reads: 7920.39, writes: 2263.64, response time: 45.28ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 10, tps: 566.41, reads: 7930.86, writes: 2265.85, response time: 45.00ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 10, tps: 568.60, reads: 7959.37, writes: 2273.82, response time: 44.27ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 10, tps: 563.00, reads: 7882.27, writes: 2252.69, response time: 45.65ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 10, tps: 565.87, reads: 7924.23, writes: 2263.07, response time: 45.23ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 10, tps: 569.71, reads: 7973.85, writes: 2278.74, response time: 45.16ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 10, tps: 571.26, reads: 7998.70, writes: 2285.26, response time: 45.32ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 10, tps: 573.51, reads: 8026.77, writes: 2293.72, response time: 44.10ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 10, tps: 566.65, reads: 7935.93, writes: 2267.71, response time: 45.80ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 10, tps: 570.00, reads: 7976.52, writes: 2279.11, response time: 44.98ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 10, tps: 567.88, reads: 7952.76, writes: 2271.40, response time: 44.89ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 10, tps: 402.00, reads: 5628.30, writes: 1608.80, response time: 72.34ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 10, tps: 571.59, reads: 8001.79, writes: 2285.44, response time: 44.70ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 10, tps: 573.14, reads: 8022.95, writes: 2292.46, response time: 42.99ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 10, tps: 573.79, reads: 8032.53, writes: 2295.48, response time: 44.34ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 10, tps: 572.09, reads: 8011.86, writes: 2287.96, response time: 44.38ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 10, tps: 575.61, reads: 8056.15, writes: 2303.24, response time: 43.47ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 10, tps: 575.50, reads: 8056.46, writes: 2301.32, response time: 44.65ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 10, tps: 578.10, reads: 8094.66, writes: 2312.59, response time: 44.02ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 10, tps: 571.00, reads: 7994.95, writes: 2283.71, response time: 45.04ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 10, tps: 573.40, reads: 8028.16, writes: 2293.99, response time: 43.77ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 10, tps: 579.48, reads: 8111.13, writes: 2317.82, response time: 42.47ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 10, tps: 572.12, reads: 8009.84, writes: 2288.67, response time: 44.17ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 10, tps: 578.01, reads: 8095.71, writes: 2312.43, response time: 41.68ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 10, tps: 576.49, reads: 8067.11, writes: 2305.25, response time: 42.47ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 10, tps: 575.11, reads: 8049.63, writes: 2300.34, response time: 43.63ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 10, tps: 578.00, reads: 8093.52, writes: 2312.00, response time: 43.73ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 10, tps: 574.30, reads: 8043.34, writes: 2297.88, response time: 42.15ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 10, tps: 575.31, reads: 8052.09, writes: 2300.83, response time: 42.75ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 10, tps: 575.20, reads: 8054.20, writes: 2300.90, response time: 44.31ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 10, tps: 572.29, reads: 8008.44, writes: 2288.65, response time: 43.45ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 10, tps: 577.57, reads: 8089.62, writes: 2310.76, response time: 43.87ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 10, tps: 577.55, reads: 8081.15, writes: 2309.69, response time: 43.01ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 10, tps: 577.00, reads: 8078.99, writes: 2309.10, response time: 43.54ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 10, tps: 572.79, reads: 8020.08, writes: 2290.17, response time: 44.29ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 10, tps: 574.97, reads: 8048.84, writes: 2299.90, response time: 44.47ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 10, tps: 568.63, reads: 7961.35, writes: 2274.70, response time: 43.66ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 10, tps: 569.50, reads: 7974.84, writes: 2278.61, response time: 45.81ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 10, tps: 576.57, reads: 8071.95, writes: 2305.37, response time: 43.16ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 10, tps: 571.52, reads: 7999.53, writes: 2286.29, response time: 44.16ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 10, tps: 571.30, reads: 7998.68, writes: 2285.30, response time: 43.97ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 10, tps: 575.01, reads: 8049.70, writes: 2300.03, response time: 44.06ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 10, tps: 567.61, reads: 7950.00, writes: 2270.53, response time: 43.96ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 10, tps: 577.80, reads: 8085.93, writes: 2311.41, response time: 43.23ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 10, tps: 573.60, reads: 8032.67, writes: 2294.59, response time: 43.81ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            14050610
        write:                           4014460
        other:                           2007230
        total:                           20072300
    transactions:                        1003615 (557.56 per sec.)
    read/write requests:                 18065070 (10036.10 per sec.)
    other operations:                    2007230 (1115.12 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0096s
    total number of events:              1003615
    total time taken by event execution: 17997.5572s
    response time:
         min:                                  4.04ms
         avg:                                 17.93ms
         max:                                241.58ms
         approx.  99 percentile:              50.43ms

Threads fairness:
    events (avg/stddev):           100361.5000/203.64
    execution time (avg/stddev):   1799.7557/0.00


