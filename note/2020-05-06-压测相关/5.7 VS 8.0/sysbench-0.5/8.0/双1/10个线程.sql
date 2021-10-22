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


purge binary logs to 'mysql-bin.000141';  


./sysbench --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench \
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_10_11_vision8.log &

coding001@voice mysql3307]$ tail -f /home/coding001/log/sysbench_oltpX_10_11_vision8.log
Number of threads: 10
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 10, tps: 255.28, reads: 3585.62, writes: 1023.02, response time: 69.20ms (99%), errors: 0.00, reconnects:  0.00

[  20s] threads: 10, tps: 301.32, reads: 4214.48, writes: 1204.58, response time: 57.00ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 10, tps: 323.07, reads: 4529.28, writes: 1293.98, response time: 53.61ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 10, tps: 333.33, reads: 4661.63, writes: 1332.02, response time: 51.62ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 10, tps: 342.89, reads: 4803.95, writes: 1371.36, response time: 47.99ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 10, tps: 351.41, reads: 4918.92, writes: 1406.13, response time: 48.94ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 10, tps: 351.90, reads: 4926.79, writes: 1408.30, response time: 48.96ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 10, tps: 357.40, reads: 5000.51, writes: 1428.20, response time: 47.05ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 10, tps: 362.00, reads: 5069.32, writes: 1449.01, response time: 48.30ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 10, tps: 358.80, reads: 5023.80, writes: 1435.00, response time: 47.05ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 10, tps: 364.60, reads: 5106.69, writes: 1458.30, response time: 45.72ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 10, tps: 367.00, reads: 5138.31, writes: 1468.20, response time: 46.00ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 10, tps: 367.60, reads: 5145.36, writes: 1470.89, response time: 45.57ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 10, tps: 370.10, reads: 5180.33, writes: 1479.61, response time: 45.19ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 10, tps: 369.30, reads: 5171.68, writes: 1477.79, response time: 45.54ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 10, tps: 373.30, reads: 5222.05, writes: 1491.58, response time: 45.70ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 10, tps: 376.21, reads: 5269.00, writes: 1506.03, response time: 44.65ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 10, tps: 373.29, reads: 5224.63, writes: 1491.98, response time: 46.09ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 10, tps: 374.60, reads: 5245.87, writes: 1498.79, response time: 43.87ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 10, tps: 375.01, reads: 5252.01, writes: 1502.03, response time: 45.83ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 10, tps: 373.90, reads: 5233.19, writes: 1493.90, response time: 44.55ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 10, tps: 375.70, reads: 5258.40, writes: 1502.90, response time: 45.47ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 10, tps: 378.20, reads: 5296.06, writes: 1513.59, response time: 44.17ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 10, tps: 379.20, reads: 5309.46, writes: 1516.39, response time: 44.77ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 10, tps: 378.49, reads: 5295.13, writes: 1513.58, response time: 44.63ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 10, tps: 385.11, reads: 5393.48, writes: 1540.42, response time: 43.20ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 10, tps: 377.10, reads: 5281.37, writes: 1507.02, response time: 47.06ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 10, tps: 381.50, reads: 5342.87, writes: 1528.79, response time: 45.70ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 10, tps: 387.50, reads: 5424.14, writes: 1549.21, response time: 43.80ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 10, tps: 387.70, reads: 5423.56, writes: 1548.99, response time: 43.84ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 10, tps: 384.99, reads: 5388.82, writes: 1539.98, response time: 43.40ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 10, tps: 386.91, reads: 5422.11, writes: 1549.83, response time: 42.98ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 10, tps: 386.49, reads: 5409.97, writes: 1545.36, response time: 44.14ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 10, tps: 389.19, reads: 5449.83, writes: 1557.35, response time: 43.07ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 10, tps: 391.42, reads: 5477.47, writes: 1564.78, response time: 42.57ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 10, tps: 391.80, reads: 5486.34, writes: 1567.91, response time: 41.95ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 10, tps: 391.59, reads: 5480.75, writes: 1565.16, response time: 42.79ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 10, tps: 390.71, reads: 5471.35, writes: 1563.94, response time: 42.08ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 10, tps: 393.19, reads: 5499.78, writes: 1570.47, response time: 42.56ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 10, tps: 396.10, reads: 5551.57, writes: 1586.39, response time: 41.65ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 10, tps: 390.80, reads: 5470.05, writes: 1563.01, response time: 42.76ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 10, tps: 389.10, reads: 5444.09, writes: 1555.80, response time: 43.34ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 10, tps: 396.40, reads: 5549.44, writes: 1585.61, response time: 42.31ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 10, tps: 394.91, reads: 5530.68, writes: 1580.02, response time: 42.48ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 10, tps: 393.09, reads: 5502.16, writes: 1571.96, response time: 43.29ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 10, tps: 387.69, reads: 5431.35, writes: 1550.46, response time: 44.90ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 10, tps: 392.02, reads: 5487.41, writes: 1568.96, response time: 42.31ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 10, tps: 398.20, reads: 5573.32, writes: 1593.21, response time: 41.53ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 10, tps: 396.50, reads: 5551.00, writes: 1584.70, response time: 42.04ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 10, tps: 397.61, reads: 5569.17, writes: 1591.92, response time: 42.05ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 10, tps: 389.10, reads: 5444.66, writes: 1555.99, response time: 46.74ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 10, tps: 399.30, reads: 5590.48, writes: 1596.70, response time: 41.70ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 10, tps: 400.80, reads: 5613.40, writes: 1602.90, response time: 41.33ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 10, tps: 399.50, reads: 5592.85, writes: 1598.41, response time: 41.98ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 10, tps: 400.00, reads: 5599.07, writes: 1601.39, response time: 41.66ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 10, tps: 397.40, reads: 5565.41, writes: 1590.30, response time: 41.78ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 10, tps: 395.50, reads: 5533.39, writes: 1580.00, response time: 44.55ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 10, tps: 401.08, reads: 5616.78, writes: 1604.64, response time: 42.33ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 10, tps: 396.91, reads: 5555.63, writes: 1586.14, response time: 42.87ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 10, tps: 398.61, reads: 5577.40, writes: 1594.53, response time: 41.74ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 10, tps: 396.78, reads: 5559.31, writes: 1587.72, response time: 41.33ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 10, tps: 399.62, reads: 5595.16, writes: 1600.38, response time: 41.08ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 10, tps: 394.60, reads: 5522.63, writes: 1576.91, response time: 43.50ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 10, tps: 397.80, reads: 5571.41, writes: 1592.80, response time: 41.33ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 10, tps: 401.30, reads: 5612.19, writes: 1602.50, response time: 41.02ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 10, tps: 394.80, reads: 5533.39, writes: 1581.90, response time: 42.53ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 10, tps: 390.40, reads: 5464.82, writes: 1560.91, response time: 44.65ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 10, tps: 373.40, reads: 5225.90, writes: 1493.10, response time: 46.00ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 10, tps: 376.30, reads: 5270.10, writes: 1505.10, response time: 46.71ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 10, tps: 381.60, reads: 5341.21, writes: 1526.50, response time: 44.86ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 10, tps: 381.69, reads: 5343.85, writes: 1527.56, response time: 45.08ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 10, tps: 382.00, reads: 5347.79, writes: 1526.10, response time: 45.19ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 10, tps: 387.81, reads: 5431.85, writes: 1554.24, response time: 42.82ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 10, tps: 387.10, reads: 5416.29, writes: 1546.70, response time: 43.14ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 10, tps: 384.80, reads: 5383.35, writes: 1538.19, response time: 44.26ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 10, tps: 378.40, reads: 5303.57, writes: 1515.62, response time: 45.72ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 10, tps: 384.69, reads: 5383.27, writes: 1537.26, response time: 44.81ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 10, tps: 381.41, reads: 5340.88, writes: 1524.42, response time: 46.77ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 10, tps: 374.70, reads: 5245.60, writes: 1499.90, response time: 46.20ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 10, tps: 377.10, reads: 5278.24, writes: 1509.21, response time: 46.54ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 10, tps: 374.40, reads: 5241.84, writes: 1496.78, response time: 46.25ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 10, tps: 374.40, reads: 5242.26, writes: 1496.79, response time: 47.96ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 10, tps: 371.00, reads: 5190.14, writes: 1484.71, response time: 47.29ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 10, tps: 381.80, reads: 5348.62, writes: 1526.91, response time: 45.54ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 10, tps: 380.09, reads: 5321.79, writes: 1519.57, response time: 45.19ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 10, tps: 384.30, reads: 5380.73, writes: 1537.31, response time: 44.45ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 10, tps: 376.91, reads: 5270.57, writes: 1507.52, response time: 47.33ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 10, tps: 386.30, reads: 5414.73, writes: 1546.71, response time: 44.57ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 10, tps: 382.19, reads: 5351.77, writes: 1529.46, response time: 45.89ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 10, tps: 380.50, reads: 5325.72, writes: 1521.21, response time: 46.18ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 10, tps: 377.09, reads: 5277.71, writes: 1507.78, response time: 46.50ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 10, tps: 378.51, reads: 5302.28, writes: 1515.25, response time: 45.66ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 10, tps: 380.39, reads: 5323.58, writes: 1520.87, response time: 45.65ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 10, tps: 377.70, reads: 5284.86, writes: 1509.89, response time: 46.50ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 10, tps: 374.51, reads: 5244.48, writes: 1499.65, response time: 47.12ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 10, tps: 376.00, reads: 5266.31, writes: 1504.50, response time: 46.87ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 10, tps: 376.90, reads: 5272.90, writes: 1506.40, response time: 45.62ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 10, tps: 379.20, reads: 5313.80, writes: 1518.50, response time: 46.09ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 10, tps: 379.68, reads: 5312.31, writes: 1516.52, response time: 46.56ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 10, tps: 384.91, reads: 5389.15, writes: 1539.94, response time: 44.85ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 10, tps: 383.71, reads: 5369.93, writes: 1535.24, response time: 45.77ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 10, tps: 383.99, reads: 5375.99, writes: 1534.87, response time: 44.74ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 10, tps: 386.40, reads: 5410.41, writes: 1544.80, response time: 46.05ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 10, tps: 386.51, reads: 5413.00, writes: 1546.93, response time: 44.89ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 10, tps: 381.40, reads: 5341.11, writes: 1527.90, response time: 46.43ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 10, tps: 387.49, reads: 5423.17, writes: 1549.06, response time: 45.61ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 10, tps: 387.90, reads: 5432.47, writes: 1552.02, response time: 44.59ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 10, tps: 384.59, reads: 5384.41, writes: 1537.58, response time: 44.63ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 10, tps: 377.51, reads: 5282.93, writes: 1508.94, response time: 46.57ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 10, tps: 380.40, reads: 5324.21, writes: 1522.00, response time: 46.10ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 10, tps: 383.90, reads: 5373.11, writes: 1535.70, response time: 45.57ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 10, tps: 382.49, reads: 5358.27, writes: 1530.96, response time: 45.88ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 10, tps: 385.40, reads: 5392.43, writes: 1540.11, response time: 45.31ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 10, tps: 381.01, reads: 5338.31, writes: 1526.03, response time: 46.63ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 10, tps: 379.90, reads: 5317.78, writes: 1519.10, response time: 46.89ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 10, tps: 378.30, reads: 5295.27, writes: 1513.09, response time: 45.77ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 10, tps: 377.30, reads: 5280.32, writes: 1509.21, response time: 46.57ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 10, tps: 382.00, reads: 5350.79, writes: 1527.40, response time: 46.82ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 10, tps: 379.80, reads: 5318.13, writes: 1520.41, response time: 45.27ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 10, tps: 376.50, reads: 5269.11, writes: 1505.40, response time: 46.28ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 10, tps: 380.10, reads: 5320.30, writes: 1520.80, response time: 46.71ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 10, tps: 382.20, reads: 5351.70, writes: 1528.80, response time: 45.62ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 10, tps: 380.39, reads: 5326.67, writes: 1520.86, response time: 47.83ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 10, tps: 385.21, reads: 5393.22, writes: 1541.34, response time: 44.14ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 10, tps: 384.20, reads: 5377.01, writes: 1536.10, response time: 44.93ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 10, tps: 208.49, reads: 2920.55, writes: 833.46, response time: 127.67ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 10, tps: 373.32, reads: 5223.24, writes: 1492.47, response time: 82.10ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 10, tps: 399.79, reads: 5598.72, writes: 1601.18, response time: 41.08ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 10, tps: 395.89, reads: 5545.19, writes: 1584.27, response time: 42.14ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 10, tps: 402.51, reads: 5631.58, writes: 1607.45, response time: 41.64ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 10, tps: 391.00, reads: 5475.09, writes: 1565.40, response time: 45.08ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 10, tps: 285.60, reads: 4000.46, writes: 1143.29, response time: 75.16ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 10, tps: 381.31, reads: 5337.48, writes: 1525.02, response time: 44.77ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 10, tps: 384.60, reads: 5382.80, writes: 1537.20, response time: 45.28ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 10, tps: 377.99, reads: 5293.12, writes: 1512.18, response time: 47.69ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 10, tps: 392.90, reads: 5500.06, writes: 1572.82, response time: 42.96ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 10, tps: 396.59, reads: 5552.11, writes: 1585.87, response time: 42.22ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 10, tps: 393.11, reads: 5504.84, writes: 1571.84, response time: 44.81ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 10, tps: 381.20, reads: 5336.55, writes: 1524.69, response time: 46.18ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 10, tps: 382.30, reads: 5351.41, writes: 1528.80, response time: 46.07ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 10, tps: 382.80, reads: 5361.80, writes: 1532.90, response time: 45.23ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 10, tps: 384.00, reads: 5372.79, writes: 1534.00, response time: 45.50ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 10, tps: 381.10, reads: 5335.14, writes: 1524.31, response time: 45.65ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 10, tps: 378.20, reads: 5297.41, writes: 1513.30, response time: 46.61ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 10, tps: 383.79, reads: 5370.92, writes: 1534.78, response time: 45.77ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 10, tps: 382.20, reads: 5348.76, writes: 1528.72, response time: 45.95ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 10, tps: 377.40, reads: 5286.81, writes: 1511.60, response time: 47.33ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 10, tps: 385.79, reads: 5399.25, writes: 1542.16, response time: 44.61ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 10, tps: 386.91, reads: 5419.82, writes: 1549.03, response time: 44.46ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 10, tps: 388.79, reads: 5443.28, writes: 1555.16, response time: 44.26ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 10, tps: 380.41, reads: 5321.33, writes: 1519.24, response time: 51.48ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 10, tps: 383.10, reads: 5360.94, writes: 1532.41, response time: 45.65ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 10, tps: 374.88, reads: 5255.34, writes: 1501.13, response time: 46.09ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 10, tps: 379.10, reads: 5306.10, writes: 1515.40, response time: 44.74ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 10, tps: 378.71, reads: 5299.75, writes: 1515.44, response time: 46.59ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 10, tps: 379.50, reads: 5315.83, writes: 1517.31, response time: 45.46ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 10, tps: 379.29, reads: 5304.52, writes: 1516.85, response time: 45.85ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 10, tps: 380.92, reads: 5337.45, writes: 1524.57, response time: 47.01ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 10, tps: 382.29, reads: 5352.71, writes: 1529.25, response time: 45.70ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 10, tps: 379.31, reads: 5310.36, writes: 1517.75, response time: 46.10ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 10, tps: 379.88, reads: 5317.27, writes: 1519.33, response time: 44.09ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 10, tps: 377.51, reads: 5286.68, writes: 1509.15, response time: 45.43ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 10, tps: 380.40, reads: 5323.77, writes: 1520.82, response time: 45.62ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 10, tps: 380.20, reads: 5323.54, writes: 1521.48, response time: 46.60ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 10, tps: 373.10, reads: 5221.38, writes: 1492.69, response time: 47.89ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 10, tps: 377.00, reads: 5279.45, writes: 1508.01, response time: 47.94ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 10, tps: 382.80, reads: 5360.25, writes: 1531.69, response time: 44.00ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 10, tps: 382.11, reads: 5348.18, writes: 1528.32, response time: 44.29ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 10, tps: 383.90, reads: 5373.46, writes: 1535.19, response time: 45.66ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 10, tps: 382.40, reads: 5355.78, writes: 1529.79, response time: 44.85ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 10, tps: 381.10, reads: 5335.97, writes: 1524.72, response time: 46.63ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 10, tps: 377.20, reads: 5278.69, writes: 1508.70, response time: 46.11ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 10, tps: 376.58, reads: 5273.67, writes: 1506.33, response time: 45.43ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 10, tps: 380.01, reads: 5320.57, writes: 1518.95, response time: 45.13ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 10, tps: 357.01, reads: 4999.39, writes: 1430.63, response time: 74.65ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 10, tps: 386.40, reads: 5406.38, writes: 1543.09, response time: 45.70ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 10, tps: 376.90, reads: 5278.90, writes: 1508.60, response time: 48.00ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 10, tps: 383.40, reads: 5365.69, writes: 1533.00, response time: 44.93ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 10, tps: 381.40, reads: 5338.28, writes: 1525.09, response time: 45.37ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 10, tps: 383.30, reads: 5368.74, writes: 1533.18, response time: 46.03ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            9560614
        write:                           2731604
        other:                           1365802
        total:                           13658020
    transactions:                        682901 (379.39 per sec.)
    read/write requests:                 12292218 (6828.95 per sec.)
    other operations:                    1365802 (758.77 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0145s
    total number of events:              682901
    total time taken by event execution: 17998.1078s
    response time:
         min:                                 10.48ms
         avg:                                 26.36ms
         max:                                442.78ms
         approx.  99 percentile:              46.78ms

Threads fairness:
    events (avg/stddev):           68290.1000/114.66
    execution time (avg/stddev):   1799.8108/0.00



[coding001@voice ~]$ top
top - 10:00:23 up 96 days, 18:58,  4 users,  load average: 12.99, 10.49, 5.27
Tasks: 126 total,   1 running, 125 sleeping,   0 stopped,   0 zombie
%Cpu0  : 63.2 us, 23.3 sy,  0.0 ni,  2.4 id,  1.7 wa,  0.0 hi,  9.5 si,  0.0 st
%Cpu1  : 71.9 us, 18.4 sy,  0.0 ni,  4.3 id,  1.0 wa,  0.0 hi,  4.3 si,  0.0 st
%Cpu2  : 70.8 us, 19.8 sy,  0.0 ni,  3.4 id,  2.0 wa,  0.0 hi,  4.0 si,  0.0 st
%Cpu3  : 70.1 us, 19.8 sy,  0.0 ni,  4.4 id,  1.0 wa,  0.0 hi,  4.7 si,  0.0 st
KiB Mem : 16266300 total,   155324 free, 10101464 used,  6009512 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5055948 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
32578 mysql     20   0   11.2g   8.8g  18092 S 264.1 56.8  35:21.58 mysqld                                                                                                                                                                     
11299 coding0+  20   0  692112   5704   2112 S 110.3  0.0   8:07.93 sysbench 


[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.09    6.27     0.14     0.30   107.59     0.08    9.74   23.75    5.07   0.61   0.51

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3612.00     0.00    48.53    27.52     1.88    0.52    0.00    0.52   0.21  74.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 3509.00     0.00    46.68    27.24     1.86    0.53    0.00    0.53   0.21  75.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3536.00     0.00    47.90    27.74     1.88    0.53    0.00    0.53   0.22  77.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 3630.00     0.00    49.45    27.90     1.92    0.53    0.00    0.53   0.21  76.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3592.00     0.00    47.78    27.24     1.81    0.50    0.00    0.50   0.20  71.00

^C
[coding001@voice ~]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.62    0.00    0.70    0.18    0.00   98.50

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               8.36       143.18       306.34 1197353274 2561753776

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          69.52    0.00   25.19    1.51    0.00    3.78

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3641.00         0.00     50320.00          0      50320

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          70.85    0.00   24.62    1.26    0.00    3.27

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3682.00         0.00     50180.00          0      50180

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          69.70    0.00   25.25    1.52    0.00    3.54

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3612.00         0.00     49144.00          0      49144

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          70.03    0.00   25.94    1.01    0.00    3.02

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3720.00         0.00     49756.00          0      49756




mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-21 09:58:18 140111566685952 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 7 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 1053 srv_active, 0 srv_shutdown, 54712 srv_idle
srv_master_thread log flush and writes: 0
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 7716
OS WAIT ARRAY INFO: signal count 11007
RW-shared spins 0, rounds 0, OS waits 0
RW-excl spins 0, rounds 0, OS waits 0
RW-sx spins 0, rounds 0, OS waits 0
Spin rounds per wait: 0.00 RW-shared, 0.00 RW-excl, 0.00 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 308938
Purge done for trx's n:o < 308875 undo n:o < 0 state: running but idle
History list length 231
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421586588642520, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 421586588641712, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 421586588640096, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 308936, ACTIVE 0 sec
2 lock struct(s), heap size 1128, 1 row lock(s), undo log entries 1
MySQL thread id 22, OS thread handle 140111432173312, query id 2527479 192.168.1.12 sysbench
Trx read view will not see trx with id >= 308925, sees < 308913
---TRANSACTION 308935, ACTIVE 0 sec
3 lock struct(s), heap size 1128, 2 row lock(s), undo log entries 2
MySQL thread id 13, OS thread handle 140111566153472, query id 2527485 192.168.1.12 sysbench
Trx read view will not see trx with id >= 308931, sees < 308925
---TRANSACTION 308934, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 17, OS thread handle 140111431640832, query id 2527484 192.168.1.12 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 308925, sees < 308913
---TRANSACTION 308933, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 15, OS thread handle 140111434303232, query id 2527489 192.168.1.12 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 308928, sees < 308920
---TRANSACTION 308932, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 19, OS thread handle 140111432705792, query id 2527488 192.168.1.12 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 308925, sees < 308913
---TRANSACTION 308931, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 21, OS thread handle 140111433770752, query id 2527469 192.168.1.12 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 308923, sees < 308913
---TRANSACTION 308925, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 16, OS thread handle 140111434835712, query id 2527422 192.168.1.12 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 308920, sees < 308910
--------
FILE I/O
--------
I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
I/O thread 1 state: waiting for completed aio requests (log thread)
I/O thread 2 state: waiting for completed aio requests (read thread)
I/O thread 3 state: waiting for completed aio requests (read thread)
I/O thread 4 state: waiting for completed aio requests (read thread)
I/O thread 5 state: waiting for completed aio requests (read thread)
I/O thread 6 state: waiting for completed aio requests (read thread)
I/O thread 7 state: waiting for completed aio requests (read thread)
I/O thread 8 state: waiting for completed aio requests (read thread)
I/O thread 9 state: waiting for completed aio requests (read thread)
I/O thread 10 state: waiting for completed aio requests (write thread)
I/O thread 11 state: waiting for completed aio requests (write thread)
I/O thread 12 state: waiting for completed aio requests (write thread)
I/O thread 13 state: waiting for completed aio requests (write thread)
I/O thread 14 state: waiting for completed aio requests (write thread)
I/O thread 15 state: waiting for completed aio requests (write thread)
I/O thread 16 state: waiting for completed aio requests (write thread)
I/O thread 17 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 0, 0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 1; buffer pool: 0
86506 OS file reads, 3445082 OS file writes, 469253 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 2790.89 writes/s, 1258.39 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 0, seg size 2, 10561 merges
merged operations:
 insert 0, delete mark 10568, delete 3
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2212699, node heap has 5126 buffer(s)
Hash table size 2212699, node heap has 5136 buffer(s)
Hash table size 2212699, node heap has 5163 buffer(s)
Hash table size 2212699, node heap has 5163 buffer(s)
Hash table size 2212699, node heap has 2553 buffer(s)
Hash table size 2212699, node heap has 5192 buffer(s)
Hash table size 2212699, node heap has 5112 buffer(s)
Hash table size 2212699, node heap has 5155 buffer(s)
5595.49 hash searches/s, 7923.73 non-hash searches/s
---
LOG
---
Log sequence number          15336218564
Log buffer assigned up to    15336218564
Log buffer completed up to   15336218564
Log written up to            15336218564
Log flushed up to            15336215572
Added dirty pages up to      15336218564
Pages flushed up to          15211948803
Last checkpoint at           15202442937
2481935 log i/o's done, 1303.29 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8770551808
Dictionary memory allocated 590518
Buffer pool size   524240
Free buffers       22229
Database pages     463411
Old database pages 171023
Modified db pages  94031
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 1007695, not young 97510
0.00 youngs/s, 0.00 non-youngs/s
Pages read 45509, created 442892, written 832446
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 51 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 463411, unzip_LRU len: 0
I/O sum[132252]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262116
Free buffers       11056
Database pages     231761
Old database pages 85532
Modified db pages  46877
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 503301, not young 48381
0.00 youngs/s, 0.00 non-youngs/s
Pages read 22799, created 221461, written 416323
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 49 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 231761, unzip_LRU len: 0
I/O sum[66126]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262124
Free buffers       11173
Database pages     231650
Old database pages 85491
Modified db pages  47154
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 504394, not young 49129
0.00 youngs/s, 0.00 non-youngs/s
Pages read 22710, created 221431, written 416123
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 53 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 231650, unzip_LRU len: 0
I/O sum[66126]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
10 read views open inside InnoDB
Process ID=32578, Main thread ID=140101919622912 , state=sleeping
Number of rows inserted 30125806, updated 251619, deleted 125808, read 51958090
382.80 inserts/s, 766.03 updates/s, 382.80 deletes/s, 158260.96 reads/s
Number of system rows inserted 10332, updated 724, deleted 10221, read 17126
9.71 inserts/s, 0.29 updates/s, 14.43 deletes/s, 15.14 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================
