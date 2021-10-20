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


purge binary logs to 'mysql-bin.000084';  


./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_10_not11.log &


[coding001@voice log]$ tail -f sysbench_oltpX_10_not11.log
Number of threads: 10
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 10, tps: 478.99, reads: 6716.11, writes: 1916.87, response time: 61.26ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 10, tps: 504.59, reads: 7064.23, writes: 2017.98, response time: 58.10ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 10, tps: 514.37, reads: 7203.22, writes: 2058.39, response time: 51.76ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 10, tps: 514.52, reads: 7198.76, writes: 2056.78, response time: 49.95ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 10, tps: 495.01, reads: 6932.68, writes: 1980.15, response time: 54.91ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 10, tps: 483.70, reads: 6773.11, writes: 1935.20, response time: 57.09ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 10, tps: 474.70, reads: 6641.12, writes: 1898.50, response time: 61.03ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 10, tps: 466.19, reads: 6530.46, writes: 1865.16, response time: 61.60ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 10, tps: 465.98, reads: 6524.95, writes: 1865.00, response time: 66.04ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 10, tps: 467.42, reads: 6542.84, writes: 1867.90, response time: 60.72ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 10, tps: 464.47, reads: 6502.75, writes: 1858.57, response time: 63.75ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 10, tps: 471.74, reads: 6603.31, writes: 1886.37, response time: 60.46ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 10, tps: 476.00, reads: 6662.66, writes: 1904.19, response time: 59.39ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 10, tps: 481.30, reads: 6741.00, writes: 1925.60, response time: 61.72ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 10, tps: 483.89, reads: 6771.80, writes: 1934.97, response time: 59.98ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 10, tps: 485.01, reads: 6792.80, writes: 1940.33, response time: 61.12ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 10, tps: 485.49, reads: 6796.36, writes: 1942.26, response time: 58.31ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 10, tps: 490.01, reads: 6857.14, writes: 1959.94, response time: 58.36ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 10, tps: 492.09, reads: 6890.92, writes: 1967.95, response time: 58.12ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 10, tps: 504.41, reads: 7059.47, writes: 2017.45, response time: 56.27ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 10, tps: 505.60, reads: 7083.87, writes: 2023.09, response time: 54.99ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 10, tps: 510.71, reads: 7146.47, writes: 2042.52, response time: 54.42ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 10, tps: 513.79, reads: 7194.21, writes: 2054.97, response time: 54.86ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 10, tps: 518.50, reads: 7256.36, writes: 2073.82, response time: 53.91ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 10, tps: 530.10, reads: 7421.69, writes: 2120.40, response time: 52.75ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 10, tps: 532.68, reads: 7460.14, writes: 2131.63, response time: 51.81ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 10, tps: 530.82, reads: 7431.15, writes: 2122.77, response time: 52.80ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 10, tps: 533.40, reads: 7466.13, writes: 2133.28, response time: 51.24ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 10, tps: 541.85, reads: 7588.78, writes: 2168.09, response time: 50.00ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 10, tps: 539.66, reads: 7550.60, writes: 2157.93, response time: 51.65ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 10, tps: 542.70, reads: 7602.90, writes: 2171.30, response time: 50.34ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 10, tps: 538.09, reads: 7528.91, writes: 2151.97, response time: 52.21ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 10, tps: 542.41, reads: 7595.00, writes: 2169.53, response time: 50.70ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 10, tps: 543.24, reads: 7602.43, writes: 2172.85, response time: 49.85ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 10, tps: 552.27, reads: 7733.92, writes: 2210.16, response time: 49.40ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 10, tps: 546.80, reads: 7654.37, writes: 2186.79, response time: 49.62ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 10, tps: 546.80, reads: 7656.11, writes: 2187.20, response time: 53.05ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 10, tps: 554.20, reads: 7760.22, writes: 2216.21, response time: 48.94ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 10, tps: 557.70, reads: 7807.66, writes: 2230.69, response time: 49.03ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 10, tps: 553.59, reads: 7750.93, writes: 2214.85, response time: 48.06ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 10, tps: 556.71, reads: 7793.36, writes: 2226.55, response time: 46.57ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 10, tps: 555.61, reads: 7777.68, writes: 2222.92, response time: 49.48ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 10, tps: 557.18, reads: 7802.25, writes: 2228.93, response time: 46.73ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 10, tps: 557.71, reads: 7806.52, writes: 2230.63, response time: 47.90ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 10, tps: 556.80, reads: 7795.06, writes: 2226.92, response time: 47.26ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 10, tps: 565.30, reads: 7916.04, writes: 2261.28, response time: 46.46ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 10, tps: 557.41, reads: 7803.71, writes: 2229.53, response time: 47.16ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 10, tps: 555.10, reads: 7769.87, writes: 2221.09, response time: 48.41ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 10, tps: 555.50, reads: 7780.04, writes: 2222.21, response time: 47.13ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 10, tps: 555.30, reads: 7770.50, writes: 2219.90, response time: 47.94ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 10, tps: 551.90, reads: 7726.39, writes: 2207.70, response time: 48.89ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 10, tps: 552.10, reads: 7730.60, writes: 2208.60, response time: 47.37ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 10, tps: 549.10, reads: 7685.05, writes: 2196.39, response time: 48.94ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 10, tps: 547.10, reads: 7663.43, writes: 2189.01, response time: 48.52ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 10, tps: 549.80, reads: 7697.28, writes: 2199.09, response time: 49.48ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 10, tps: 554.10, reads: 7757.04, writes: 2216.01, response time: 47.79ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 10, tps: 555.49, reads: 7776.60, writes: 2222.04, response time: 48.39ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 10, tps: 545.41, reads: 7635.43, writes: 2181.74, response time: 50.07ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 10, tps: 544.26, reads: 7618.08, writes: 2176.52, response time: 51.86ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 10, tps: 544.05, reads: 7617.59, writes: 2176.30, response time: 49.34ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 10, tps: 556.60, reads: 7791.00, writes: 2226.30, response time: 47.16ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 10, tps: 551.79, reads: 7727.03, writes: 2207.35, response time: 49.25ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 10, tps: 557.51, reads: 7805.09, writes: 2230.63, response time: 47.59ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 10, tps: 558.00, reads: 7810.82, writes: 2231.71, response time: 47.52ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 10, tps: 556.20, reads: 7784.96, writes: 2224.22, response time: 47.92ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 10, tps: 549.49, reads: 7694.16, writes: 2198.36, response time: 49.19ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 10, tps: 553.21, reads: 7742.11, writes: 2212.43, response time: 47.72ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 10, tps: 553.20, reads: 7747.54, writes: 2213.01, response time: 48.57ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 10, tps: 556.09, reads: 7784.43, writes: 2224.15, response time: 47.62ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 10, tps: 551.11, reads: 7718.94, writes: 2205.54, response time: 48.89ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 10, tps: 553.20, reads: 7745.28, writes: 2211.70, response time: 48.35ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 10, tps: 553.00, reads: 7738.63, writes: 2212.51, response time: 49.56ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 10, tps: 553.50, reads: 7749.23, writes: 2213.71, response time: 48.68ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 10, tps: 555.70, reads: 7780.47, writes: 2223.39, response time: 47.02ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 10, tps: 554.60, reads: 7764.55, writes: 2218.18, response time: 47.39ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 10, tps: 556.60, reads: 7792.72, writes: 2226.91, response time: 47.13ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 10, tps: 557.50, reads: 7802.96, writes: 2228.92, response time: 47.05ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 10, tps: 555.36, reads: 7778.00, writes: 2222.06, response time: 47.03ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 10, tps: 557.53, reads: 7802.95, writes: 2229.73, response time: 47.76ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 10, tps: 556.50, reads: 7791.35, writes: 2226.21, response time: 48.28ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 10, tps: 556.50, reads: 7792.58, writes: 2226.19, response time: 46.74ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 10, tps: 553.60, reads: 7750.14, writes: 2213.98, response time: 47.60ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 10, tps: 556.00, reads: 7782.46, writes: 2224.12, response time: 47.73ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 10, tps: 516.00, reads: 7223.84, writes: 2063.68, response time: 55.58ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 10, tps: 551.38, reads: 7721.06, writes: 2205.83, response time: 48.94ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 10, tps: 552.92, reads: 7740.12, writes: 2212.29, response time: 48.89ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 10, tps: 557.19, reads: 7798.01, writes: 2227.88, response time: 47.46ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 10, tps: 554.50, reads: 7764.73, writes: 2218.21, response time: 48.73ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 10, tps: 556.00, reads: 7785.00, writes: 2224.00, response time: 47.29ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 10, tps: 551.00, reads: 7715.54, writes: 2204.41, response time: 48.58ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 10, tps: 545.20, reads: 7631.93, writes: 2180.81, response time: 51.47ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 10, tps: 549.20, reads: 7690.53, writes: 2196.38, response time: 48.75ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 10, tps: 551.80, reads: 7721.61, writes: 2207.20, response time: 48.80ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 10, tps: 553.99, reads: 7757.42, writes: 2216.28, response time: 48.00ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 10, tps: 557.91, reads: 7808.91, writes: 2231.73, response time: 47.19ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 10, tps: 549.90, reads: 7699.84, writes: 2199.58, response time: 48.15ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 10, tps: 557.20, reads: 7801.14, writes: 2229.18, response time: 47.20ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 10, tps: 553.60, reads: 7748.23, writes: 2214.01, response time: 48.17ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 10, tps: 554.90, reads: 7772.49, writes: 2220.10, response time: 48.62ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 10, tps: 554.40, reads: 7759.97, writes: 2216.62, response time: 46.25ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 10, tps: 557.80, reads: 7809.41, writes: 2231.40, response time: 48.13ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 10, tps: 559.20, reads: 7829.59, writes: 2236.50, response time: 46.74ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 10, tps: 556.00, reads: 7785.71, writes: 2224.80, response time: 48.57ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 10, tps: 554.60, reads: 7760.62, writes: 2217.91, response time: 48.43ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 10, tps: 552.00, reads: 7727.01, writes: 2208.40, response time: 49.48ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 10, tps: 555.48, reads: 7779.97, writes: 2221.54, response time: 47.54ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 10, tps: 556.41, reads: 7789.60, writes: 2225.76, response time: 48.25ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 10, tps: 557.80, reads: 7806.54, writes: 2231.11, response time: 47.57ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 10, tps: 559.20, reads: 7830.15, writes: 2236.89, response time: 47.43ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 10, tps: 554.05, reads: 7753.98, writes: 2216.10, response time: 48.65ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 10, tps: 558.45, reads: 7821.66, writes: 2233.89, response time: 47.89ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 10, tps: 557.70, reads: 7808.43, writes: 2231.01, response time: 48.16ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 10, tps: 557.10, reads: 7799.89, writes: 2228.30, response time: 47.83ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 10, tps: 548.30, reads: 7675.27, writes: 2193.09, response time: 51.32ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 10, tps: 369.39, reads: 5171.52, writes: 1477.68, response time: 82.50ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 10, tps: 558.72, reads: 7822.51, writes: 2234.86, response time: 46.66ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 10, tps: 555.40, reads: 7774.95, writes: 2221.49, response time: 49.24ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 10, tps: 557.40, reads: 7805.05, writes: 2229.81, response time: 47.80ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 10, tps: 555.90, reads: 7780.48, writes: 2223.50, response time: 48.73ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 10, tps: 555.50, reads: 7777.75, writes: 2222.08, response time: 48.13ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 10, tps: 558.40, reads: 7815.57, writes: 2233.02, response time: 46.50ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 10, tps: 555.30, reads: 7776.94, writes: 2222.18, response time: 48.15ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 10, tps: 551.61, reads: 7724.29, writes: 2205.72, response time: 49.85ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 10, tps: 559.30, reads: 7826.13, writes: 2237.08, response time: 48.10ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 10, tps: 561.30, reads: 7859.66, writes: 2245.92, response time: 46.84ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 10, tps: 553.00, reads: 7744.42, writes: 2211.61, response time: 46.80ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 10, tps: 558.80, reads: 7817.67, writes: 2235.39, response time: 47.60ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 10, tps: 556.70, reads: 7796.82, writes: 2226.11, response time: 48.26ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 10, tps: 556.00, reads: 7787.19, writes: 2224.10, response time: 47.33ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 10, tps: 554.70, reads: 7766.10, writes: 2219.00, response time: 48.61ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 10, tps: 559.80, reads: 7836.19, writes: 2239.20, response time: 47.08ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 10, tps: 555.69, reads: 7777.71, writes: 2222.48, response time: 47.56ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 10, tps: 558.51, reads: 7820.69, writes: 2234.03, response time: 47.94ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 10, tps: 561.40, reads: 7858.99, writes: 2246.30, response time: 47.56ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 10, tps: 556.80, reads: 7796.33, writes: 2226.81, response time: 48.00ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 10, tps: 558.19, reads: 7814.80, writes: 2232.94, response time: 48.28ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 10, tps: 562.71, reads: 7872.35, writes: 2250.74, response time: 46.70ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 10, tps: 561.10, reads: 7860.97, writes: 2244.89, response time: 48.71ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 10, tps: 561.40, reads: 7857.36, writes: 2244.92, response time: 47.37ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 10, tps: 561.30, reads: 7858.89, writes: 2245.30, response time: 47.42ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 10, tps: 556.30, reads: 7790.01, writes: 2225.00, response time: 48.36ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 10, tps: 559.40, reads: 7830.51, writes: 2238.20, response time: 46.75ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 10, tps: 561.90, reads: 7865.62, writes: 2246.90, response time: 47.49ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 10, tps: 559.39, reads: 7830.13, writes: 2237.55, response time: 48.49ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 10, tps: 557.71, reads: 7810.35, writes: 2230.84, response time: 49.27ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 10, tps: 561.40, reads: 7855.67, writes: 2245.99, response time: 47.19ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 10, tps: 560.27, reads: 7843.36, writes: 2240.67, response time: 46.78ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 10, tps: 556.73, reads: 7795.07, writes: 2226.93, response time: 47.77ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 10, tps: 559.59, reads: 7835.90, writes: 2238.74, response time: 48.19ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 10, tps: 558.11, reads: 7815.40, writes: 2232.76, response time: 47.63ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 10, tps: 558.30, reads: 7816.98, writes: 2232.69, response time: 46.57ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 10, tps: 557.37, reads: 7803.13, writes: 2229.76, response time: 49.06ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 10, tps: 552.53, reads: 7734.79, writes: 2210.51, response time: 48.46ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 10, tps: 547.81, reads: 7669.50, writes: 2190.33, response time: 51.84ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 10, tps: 560.19, reads: 7836.13, writes: 2240.85, response time: 47.19ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 10, tps: 552.71, reads: 7741.86, writes: 2211.15, response time: 46.87ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 10, tps: 558.00, reads: 7814.93, writes: 2232.08, response time: 47.69ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 10, tps: 560.90, reads: 7847.51, writes: 2243.10, response time: 48.93ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 10, tps: 561.11, reads: 7860.27, writes: 2244.82, response time: 46.13ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 10, tps: 556.90, reads: 7797.45, writes: 2228.29, response time: 48.51ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 10, tps: 558.30, reads: 7815.74, writes: 2232.61, response time: 47.89ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 10, tps: 557.40, reads: 7803.38, writes: 2229.49, response time: 47.79ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 10, tps: 557.90, reads: 7806.22, writes: 2231.41, response time: 48.02ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 10, tps: 557.90, reads: 7814.77, writes: 2231.69, response time: 46.29ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 10, tps: 558.90, reads: 7818.84, writes: 2235.38, response time: 47.03ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 10, tps: 561.61, reads: 7864.47, writes: 2247.22, response time: 47.60ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 10, tps: 556.20, reads: 7790.41, writes: 2224.10, response time: 47.66ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 10, tps: 560.60, reads: 7848.67, writes: 2242.49, response time: 46.81ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 10, tps: 559.79, reads: 7834.91, writes: 2239.07, response time: 47.66ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 10, tps: 559.69, reads: 7837.32, writes: 2239.48, response time: 46.05ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 10, tps: 561.01, reads: 7854.59, writes: 2243.95, response time: 48.67ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 10, tps: 560.90, reads: 7851.73, writes: 2242.88, response time: 46.78ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 10, tps: 559.91, reads: 7838.37, writes: 2239.82, response time: 47.40ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 10, tps: 551.20, reads: 7715.90, writes: 2205.10, response time: 49.55ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 10, tps: 559.00, reads: 7828.11, writes: 2235.60, response time: 47.79ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 10, tps: 560.28, reads: 7841.37, writes: 2241.13, response time: 47.46ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 10, tps: 557.41, reads: 7805.68, writes: 2230.45, response time: 47.56ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 10, tps: 556.80, reads: 7792.75, writes: 2226.61, response time: 48.39ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 10, tps: 563.97, reads: 7898.79, writes: 2255.88, response time: 47.27ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 10, tps: 563.23, reads: 7885.70, writes: 2253.11, response time: 48.28ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            13729604
        write:                           3922744
        other:                           1961372
        total:                           19613720
    transactions:                        980686 (544.82 per sec.)
    read/write requests:                 17652348 (9806.77 per sec.)
    other operations:                    1961372 (1089.64 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0166s
    total number of events:              980686
    total time taken by event execution: 17997.4866s
    response time:
         min:                                  3.91ms
         avg:                                 18.35ms
         max:                                126.16ms
         approx.  99 percentile:              50.34ms

Threads fairness:
    events (avg/stddev):           98068.6000/241.42
    execution time (avg/stddev):   1799.7487/0.00


[root@voice sbtest]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.54    0.00    0.68    0.18    0.00   98.61

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               7.14       144.35       246.99 1186449102 2030019428

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          66.67    0.00   25.81    2.01    0.00    5.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             585.00         8.00     32064.00          8      32064

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          67.67    0.00   24.06    2.01    0.00    6.27

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             587.00         0.00     33248.00          0      33248

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          66.92    0.00   25.31    1.75    0.00    6.02

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             585.00         0.00     31072.00          0      31072




[root@voice sbtest]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    2.10    5.04     0.14     0.24   109.64     0.07   10.43   23.96    4.79   0.64   0.46

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  564.00     0.00    32.68   118.65     0.70    1.24    0.00    1.24   0.31  17.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  542.00     0.00    30.37   114.75     0.57    1.05    0.00    1.05   0.32  17.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     3.00    0.00  616.00     0.00    32.63   108.49     0.69    1.11    0.00    1.11   0.30  18.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  487.00     0.00    30.12   126.69     0.54    1.10    0.00    1.10   0.34  16.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  519.00     0.00    31.28   123.44     0.59    1.12    0.00    1.12   0.32  16.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  535.00     0.00    32.39   123.98     0.56    1.07    0.00    1.07   0.31  16.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  531.00     0.00    30.46   117.48     0.55    1.03    0.00    1.03   0.32  16.80



[root@voice sbtest]# top
top - 18:07:07 up 95 days,  3:05,  4 users,  load average: 11.20, 8.32, 5.12
Tasks: 125 total,   1 running, 124 sleeping,   0 stopped,   0 zombie
%Cpu0  : 66.4 us, 20.5 sy,  0.0 ni,  5.7 id,  2.3 wa,  0.0 hi,  5.0 si,  0.0 st
%Cpu1  : 66.9 us, 20.2 sy,  0.0 ni,  5.6 id,  2.6 wa,  0.0 hi,  4.6 si,  0.0 st
%Cpu2  : 68.7 us, 17.7 sy,  0.0 ni,  7.0 id,  1.7 wa,  0.0 hi,  5.0 si,  0.0 st
%Cpu3  : 68.3 us, 20.7 sy,  0.0 ni,  5.7 id,  1.0 wa,  0.0 hi,  4.3 si,  0.0 st
KiB Mem : 16266300 total,   169756 free, 10079444 used,  6017100 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5085976 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   9.0g   4436 S 302.7 58.3 700:22.54 mysqld                                                                                                                                                                    
 4604 coding0+  20   0  692112   5312   1904 S  63.1  0.0   3:33.97 sysbench  
 
 
	-- 感觉瓶颈在CPU了。
	
	-- IO 还没有遇到瓶颈。
	
	set global sync_binlog=1000;
	set global innodb_flush_log_at_trx_commit=2;
	
	
 