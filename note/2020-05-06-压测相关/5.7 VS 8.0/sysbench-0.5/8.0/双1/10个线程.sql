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


./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_10_11.log &


[coding001@voice log]$ tail -f sysbench_oltpX_10_11.log
[ 110s] threads: 10, tps: 435.80, reads: 6100.34, writes: 1742.91, response time: 56.36ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 10, tps: 438.30, reads: 6138.36, writes: 1753.59, response time: 56.34ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 10, tps: 439.50, reads: 6151.24, writes: 1758.21, response time: 56.54ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 10, tps: 437.90, reads: 6132.14, writes: 1751.78, response time: 56.42ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 10, tps: 442.70, reads: 6196.63, writes: 1769.81, response time: 56.42ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 10, tps: 442.10, reads: 6188.83, writes: 1768.21, response time: 56.19ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 10, tps: 444.30, reads: 6219.96, writes: 1777.39, response time: 56.86ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 10, tps: 429.70, reads: 6017.38, writes: 1719.09, response time: 59.55ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 10, tps: 430.80, reads: 6030.46, writes: 1723.42, response time: 57.62ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 10, tps: 451.99, reads: 6330.04, writes: 1808.96, response time: 56.12ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 10, tps: 449.80, reads: 6296.04, writes: 1798.51, response time: 56.73ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 10, tps: 455.21, reads: 6375.52, writes: 1821.64, response time: 55.20ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 10, tps: 465.79, reads: 6520.52, writes: 1863.18, response time: 53.67ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 10, tps: 455.09, reads: 6369.30, writes: 1819.44, response time: 56.05ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 10, tps: 473.41, reads: 6629.40, writes: 1894.96, response time: 53.93ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 10, tps: 477.70, reads: 6685.52, writes: 1908.70, response time: 53.72ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 10, tps: 480.00, reads: 6721.19, writes: 1921.90, response time: 51.72ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 10, tps: 480.60, reads: 6729.27, writes: 1922.72, response time: 52.40ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 10, tps: 485.30, reads: 6791.24, writes: 1939.68, response time: 51.02ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 10, tps: 481.81, reads: 6747.47, writes: 1927.72, response time: 51.89ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 10, tps: 483.88, reads: 6774.25, writes: 1935.93, response time: 50.58ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 10, tps: 487.22, reads: 6820.96, writes: 1948.77, response time: 51.02ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 10, tps: 495.20, reads: 6933.97, writes: 1980.89, response time: 50.63ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 10, tps: 494.10, reads: 6916.83, writes: 1976.01, response time: 50.39ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 10, tps: 480.40, reads: 6724.18, writes: 1921.69, response time: 51.92ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 10, tps: 482.20, reads: 6748.02, writes: 1928.11, response time: 50.69ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 10, tps: 500.76, reads: 7011.78, writes: 2002.02, response time: 48.73ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 10, tps: 502.80, reads: 7041.36, writes: 2012.02, response time: 47.94ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 10, tps: 512.34, reads: 7172.40, writes: 2049.24, response time: 46.68ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 10, tps: 508.31, reads: 7118.08, writes: 2034.92, response time: 45.13ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 10, tps: 475.10, reads: 6648.86, writes: 1899.99, response time: 52.09ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 10, tps: 512.10, reads: 7169.18, writes: 2046.80, response time: 46.66ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 10, tps: 514.60, reads: 7206.11, writes: 2059.40, response time: 43.59ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 10, tps: 513.90, reads: 7190.90, writes: 2054.60, response time: 44.67ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 10, tps: 511.90, reads: 7167.97, writes: 2047.69, response time: 43.92ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 10, tps: 513.71, reads: 7194.68, writes: 2056.32, response time: 44.31ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 10, tps: 515.10, reads: 7213.09, writes: 2060.70, response time: 43.87ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 10, tps: 515.40, reads: 7209.84, writes: 2060.08, response time: 43.16ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 10, tps: 516.70, reads: 7237.23, writes: 2067.61, response time: 42.56ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 10, tps: 516.29, reads: 7229.10, writes: 2064.07, response time: 43.59ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 10, tps: 513.50, reads: 7188.38, writes: 2054.69, response time: 43.05ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 10, tps: 510.45, reads: 7146.79, writes: 2041.80, response time: 43.66ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 10, tps: 515.66, reads: 7217.83, writes: 2061.84, response time: 42.92ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 10, tps: 513.40, reads: 7186.61, writes: 2054.50, response time: 44.42ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 10, tps: 513.60, reads: 7192.13, writes: 2055.01, response time: 44.67ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 10, tps: 515.80, reads: 7219.61, writes: 2062.50, response time: 43.43ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 10, tps: 512.79, reads: 7180.47, writes: 2051.36, response time: 45.99ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 10, tps: 514.01, reads: 7196.11, writes: 2056.03, response time: 43.16ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 10, tps: 522.20, reads: 7308.11, writes: 2088.90, response time: 43.85ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 10, tps: 509.68, reads: 7138.37, writes: 2037.63, response time: 45.25ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 10, tps: 514.31, reads: 7200.47, writes: 2057.95, response time: 44.00ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 10, tps: 514.70, reads: 7207.66, writes: 2059.52, response time: 43.96ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 10, tps: 514.60, reads: 7202.78, writes: 2056.80, response time: 44.83ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 10, tps: 516.20, reads: 7226.22, writes: 2065.81, response time: 44.27ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 10, tps: 518.60, reads: 7255.90, writes: 2073.10, response time: 44.05ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 10, tps: 513.40, reads: 7190.97, writes: 2054.09, response time: 43.21ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 10, tps: 504.65, reads: 7066.55, writes: 2019.49, response time: 45.21ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 10, tps: 511.25, reads: 7158.73, writes: 2045.71, response time: 43.16ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 10, tps: 511.68, reads: 7160.94, writes: 2045.92, response time: 44.96ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 10, tps: 515.92, reads: 7223.84, writes: 2063.30, response time: 42.94ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 10, tps: 514.60, reads: 7206.31, writes: 2060.30, response time: 44.46ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 10, tps: 511.80, reads: 7162.79, writes: 2046.10, response time: 45.06ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 10, tps: 519.60, reads: 7275.61, writes: 2078.00, response time: 42.74ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 10, tps: 513.79, reads: 7190.50, writes: 2055.57, response time: 44.83ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 10, tps: 513.40, reads: 7188.74, writes: 2053.31, response time: 45.92ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 10, tps: 513.20, reads: 7185.96, writes: 2052.22, response time: 44.66ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 10, tps: 507.80, reads: 7108.16, writes: 2031.49, response time: 43.18ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 10, tps: 501.40, reads: 7019.39, writes: 2005.40, response time: 46.36ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 10, tps: 510.50, reads: 7145.32, writes: 2042.41, response time: 42.23ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 10, tps: 508.39, reads: 7120.16, writes: 2034.16, response time: 42.76ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 10, tps: 511.97, reads: 7168.00, writes: 2047.58, response time: 43.83ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 10, tps: 513.54, reads: 7191.27, writes: 2055.46, response time: 43.56ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 10, tps: 514.09, reads: 7191.98, writes: 2054.57, response time: 42.78ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 10, tps: 514.20, reads: 7202.35, writes: 2056.42, response time: 43.50ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 10, tps: 518.00, reads: 7249.89, writes: 2073.10, response time: 41.85ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 10, tps: 518.50, reads: 7261.98, writes: 2073.99, response time: 43.40ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 10, tps: 517.30, reads: 7240.24, writes: 2068.28, response time: 41.33ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 10, tps: 513.31, reads: 7185.47, writes: 2053.72, response time: 42.48ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 10, tps: 507.99, reads: 7112.50, writes: 2031.47, response time: 43.58ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 10, tps: 504.91, reads: 7071.87, writes: 2021.05, response time: 46.59ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 10, tps: 508.48, reads: 7116.69, writes: 2033.71, response time: 45.61ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 10, tps: 510.52, reads: 7142.08, writes: 2039.78, response time: 43.14ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 10, tps: 508.40, reads: 7123.53, writes: 2035.91, response time: 44.37ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 10, tps: 508.39, reads: 7116.73, writes: 2033.08, response time: 41.27ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 10, tps: 517.40, reads: 7243.20, writes: 2069.60, response time: 40.97ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 10, tps: 513.89, reads: 7191.42, writes: 2055.25, response time: 43.51ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 10, tps: 515.29, reads: 7219.73, writes: 2061.75, response time: 44.31ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 10, tps: 509.70, reads: 7133.56, writes: 2038.92, response time: 44.22ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 10, tps: 511.82, reads: 7165.61, writes: 2047.19, response time: 44.58ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 10, tps: 515.30, reads: 7216.22, writes: 2062.21, response time: 44.14ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 10, tps: 521.40, reads: 7298.25, writes: 2083.79, response time: 43.64ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 10, tps: 513.50, reads: 7187.44, writes: 2053.71, response time: 43.72ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 10, tps: 517.40, reads: 7244.61, writes: 2069.80, response time: 41.28ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 10, tps: 518.40, reads: 7256.62, writes: 2073.71, response time: 41.95ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 10, tps: 510.50, reads: 7149.83, writes: 2043.58, response time: 45.27ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 10, tps: 512.30, reads: 7168.27, writes: 2047.12, response time: 44.06ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 10, tps: 517.90, reads: 7253.90, writes: 2074.10, response time: 42.88ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 10, tps: 520.37, reads: 7284.33, writes: 2079.67, response time: 42.46ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 10, tps: 514.92, reads: 7208.84, writes: 2059.00, response time: 44.08ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 10, tps: 515.91, reads: 7219.88, writes: 2064.12, response time: 40.70ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 10, tps: 513.00, reads: 7185.95, writes: 2051.91, response time: 43.41ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 10, tps: 517.00, reads: 7237.00, writes: 2069.50, response time: 41.84ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 10, tps: 508.70, reads: 7119.69, writes: 2033.30, response time: 44.97ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 10, tps: 506.27, reads: 7089.60, writes: 2024.78, response time: 45.21ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 10, tps: 505.52, reads: 7076.17, writes: 2021.78, response time: 42.36ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 10, tps: 501.00, reads: 7014.35, writes: 2003.51, response time: 45.00ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 10, tps: 502.21, reads: 7030.30, writes: 2009.43, response time: 41.21ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 10, tps: 512.80, reads: 7179.58, writes: 2052.09, response time: 42.53ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 10, tps: 510.10, reads: 7139.06, writes: 2039.49, response time: 42.37ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 10, tps: 508.10, reads: 7114.36, writes: 2032.62, response time: 42.23ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 10, tps: 516.99, reads: 7240.39, writes: 2068.97, response time: 44.16ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 10, tps: 515.90, reads: 7221.35, writes: 2062.01, response time: 41.94ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 10, tps: 516.70, reads: 7234.02, writes: 2067.81, response time: 43.84ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 10, tps: 514.60, reads: 7204.84, writes: 2058.81, response time: 42.73ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 10, tps: 518.39, reads: 7256.59, writes: 2073.37, response time: 44.94ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 10, tps: 518.91, reads: 7262.71, writes: 2074.03, response time: 44.86ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 10, tps: 519.70, reads: 7279.59, writes: 2080.80, response time: 42.70ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 10, tps: 516.30, reads: 7227.80, writes: 2065.50, response time: 41.56ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 10, tps: 505.20, reads: 7073.05, writes: 2020.09, response time: 44.30ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 10, tps: 505.60, reads: 7077.73, writes: 2022.81, response time: 41.90ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 10, tps: 519.90, reads: 7278.71, writes: 2078.40, response time: 41.27ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 10, tps: 519.70, reads: 7277.14, writes: 2081.18, response time: 41.47ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 10, tps: 520.90, reads: 7286.14, writes: 2080.81, response time: 41.16ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 10, tps: 521.40, reads: 7303.54, writes: 2086.61, response time: 41.28ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 10, tps: 522.50, reads: 7314.97, writes: 2090.29, response time: 43.89ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 10, tps: 521.10, reads: 7297.35, writes: 2084.59, response time: 43.21ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 10, tps: 521.21, reads: 7297.08, writes: 2085.32, response time: 42.31ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 10, tps: 507.90, reads: 7110.54, writes: 2031.08, response time: 45.80ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 10, tps: 513.70, reads: 7192.17, writes: 2055.49, response time: 42.61ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 10, tps: 515.70, reads: 7217.66, writes: 2061.72, response time: 43.71ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 10, tps: 516.90, reads: 7234.99, writes: 2067.80, response time: 41.47ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 10, tps: 516.20, reads: 7227.28, writes: 2064.69, response time: 42.78ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 10, tps: 520.40, reads: 7285.74, writes: 2081.01, response time: 41.19ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 10, tps: 515.40, reads: 7217.06, writes: 2060.99, response time: 42.55ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 10, tps: 519.20, reads: 7265.84, writes: 2078.01, response time: 42.38ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 10, tps: 518.19, reads: 7256.40, writes: 2071.97, response time: 43.37ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 10, tps: 516.71, reads: 7236.72, writes: 2068.43, response time: 43.07ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 10, tps: 520.39, reads: 7284.60, writes: 2080.77, response time: 42.66ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 10, tps: 518.56, reads: 7258.37, writes: 2073.85, response time: 41.06ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 10, tps: 511.04, reads: 7156.22, writes: 2045.98, response time: 45.02ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 10, tps: 517.10, reads: 7238.59, writes: 2067.40, response time: 40.74ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 10, tps: 515.99, reads: 7221.99, writes: 2063.17, response time: 43.07ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 10, tps: 515.20, reads: 7210.51, writes: 2060.00, response time: 43.87ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 10, tps: 517.81, reads: 7253.31, writes: 2073.43, response time: 42.02ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 10, tps: 519.29, reads: 7269.61, writes: 2076.27, response time: 43.36ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 10, tps: 518.51, reads: 7258.89, writes: 2074.33, response time: 42.13ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 10, tps: 520.90, reads: 7293.87, writes: 2083.69, response time: 40.68ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 10, tps: 521.80, reads: 7303.51, writes: 2087.00, response time: 41.84ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 10, tps: 522.19, reads: 7313.46, writes: 2088.26, response time: 40.72ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 10, tps: 518.51, reads: 7259.66, writes: 2076.15, response time: 43.14ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 10, tps: 516.28, reads: 7228.78, writes: 2064.91, response time: 40.38ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 10, tps: 510.32, reads: 7140.59, writes: 2038.88, response time: 38.95ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 10, tps: 518.20, reads: 7257.61, writes: 2074.90, response time: 41.81ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 10, tps: 520.50, reads: 7282.82, writes: 2079.80, response time: 38.27ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 10, tps: 520.80, reads: 7293.77, writes: 2083.69, response time: 39.79ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 10, tps: 520.30, reads: 7285.41, writes: 2082.30, response time: 40.91ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 10, tps: 524.78, reads: 7346.25, writes: 2098.63, response time: 42.42ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 10, tps: 518.92, reads: 7264.87, writes: 2075.68, response time: 43.51ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 10, tps: 518.19, reads: 7254.82, writes: 2073.18, response time: 42.85ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 10, tps: 521.41, reads: 7300.48, writes: 2085.72, response time: 41.23ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 10, tps: 523.60, reads: 7330.61, writes: 2095.20, response time: 42.47ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 10, tps: 524.69, reads: 7344.13, writes: 2095.78, response time: 43.06ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 10, tps: 523.10, reads: 7323.02, writes: 2092.91, response time: 41.85ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 10, tps: 521.20, reads: 7298.52, writes: 2086.41, response time: 40.97ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 10, tps: 520.70, reads: 7287.79, writes: 2082.20, response time: 41.60ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 10, tps: 521.50, reads: 7302.93, writes: 2085.31, response time: 41.00ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 10, tps: 522.40, reads: 7312.81, writes: 2091.40, response time: 40.24ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 10, tps: 519.90, reads: 7276.46, writes: 2077.59, response time: 41.00ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 10, tps: 527.50, reads: 7385.23, writes: 2110.21, response time: 39.66ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 10, tps: 519.30, reads: 7266.49, writes: 2076.50, response time: 44.90ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            12686394
        write:                           3624684
        other:                           1812342
        total:                           18123420
    transactions:                        906171 (503.42 per sec.)
    read/write requests:                 16311078 (9061.62 per sec.)
    other operations:                    1812342 (1006.85 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0186s
    total number of events:              906171
    total time taken by event execution: 17997.6095s
    response time:
         min:                                  7.31ms
         avg:                                 19.86ms
         max:                                111.18ms
         approx.  99 percentile:              48.04ms

Threads fairness:
    events (avg/stddev):           90617.1000/117.16
    execution time (avg/stddev):   1799.7609/0.00


mysql> show processlist;
+-----+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
| Id  | User            | Host               | db     | Command | Time   | State                  | Info                                                                                                 |
+-----+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
|   1 | event_scheduler | localhost          | NULL   | Daemon  | 144107 | Waiting on empty queue | NULL                                                                                                 |
|  73 | root            | localhost          | sbtest | Query   |      0 | starting               | show processlist                                                                                     |
| 121 | sysbench        | 192.168.1.12:59306 | sbtest | Query   |      0 | updating               | UPDATE sbtest7 SET c='06036966182-04267786257-54514415638-59323789981-12490344217-67103519417-84806' |
| 122 | sysbench        | 192.168.1.12:59307 | sbtest | Query   |      0 | statistics             | SELECT c FROM sbtest8 WHERE id=511763                                                                |
| 123 | sysbench        | 192.168.1.12:59308 | sbtest | Query   |      0 | statistics             | SELECT c FROM sbtest9 WHERE id=1459261                                                               |
| 124 | sysbench        | 192.168.1.12:59314 | sbtest | Query   |      0 | statistics             | SELECT DISTINCT c FROM sbtest13 WHERE id BETWEEN 763416 AND 763416+99 ORDER BY c                     |
| 125 | sysbench        | 192.168.1.12:59316 | sbtest | Query   |      0 | statistics             | SELECT c FROM sbtest2 WHERE id=205691                                                                |
| 126 | sysbench        | 192.168.1.12:59318 | sbtest | Query   |      0 | statistics             | SELECT c FROM sbtest3 WHERE id BETWEEN 1316364 AND 1316364+99 ORDER BY c                             |
| 127 | sysbench        | 192.168.1.12:59320 | sbtest | Query   |      0 | statistics             | SELECT c FROM sbtest9 WHERE id=1317850                                                               |
| 128 | sysbench        | 192.168.1.12:59322 | sbtest | Query   |      0 | statistics             | SELECT c FROM sbtest11 WHERE id=825225                                                               |
| 129 | sysbench        | 192.168.1.12:59324 | sbtest | Query   |      0 | statistics             | SELECT c FROM sbtest12 WHERE id=869686                                                               |
| 130 | sysbench        | 192.168.1.12:59326 | sbtest | Query   |      0 | statistics             | SELECT c FROM sbtest15 WHERE id=890944                                                               |
+-----+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
12 rows in set (0.00 sec)



[root@voice sbtest]# top
top - 10:11:05 up 95 days, 19:09,  4 users,  load average: 8.95, 8.82, 5.90
Tasks: 124 total,   2 running, 122 sleeping,   0 stopped,   0 zombie
%Cpu0  : 56.8 us, 18.9 sy,  0.0 ni, 10.8 id,  5.4 wa,  0.0 hi,  8.1 si,  0.0 st
%Cpu1  : 59.5 us, 18.9 sy,  0.0 ni, 10.8 id,  5.4 wa,  0.0 hi,  5.4 si,  0.0 st
%Cpu2  : 62.2 us, 18.9 sy,  0.0 ni, 13.5 id,  0.0 wa,  0.0 hi,  5.4 si,  0.0 st
%Cpu3  : 53.8 us, 20.5 sy,  0.0 ni, 12.8 id,  7.7 wa,  0.0 hi,  5.1 si,  0.0 st
KiB Mem : 16266300 total,   169580 free, 10072916 used,  6023804 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5092532 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   9.0g   2892 S 271.1 58.3 823:48.66 mysqld                                                                                                                                                                    
21657 coding0+  20   0  692112   4324   1228 S  55.3  0.0   8:22.91 sysbench  


[root@voice sbtest]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/20/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    2.09    5.19     0.14     0.25   110.57     0.08   10.41   23.93    4.97   0.64   0.46

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 1602.00     0.00    38.08    48.68     1.18    0.74    0.00    0.74   0.35  56.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1684.00     0.00    37.79    45.96     1.24    0.74    0.00    0.74   0.35  59.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  392.00 1503.00    10.81    37.79    52.52     1.48    0.78    0.72    0.80   0.35  67.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  202.00 1752.00     5.56    38.06    45.72     1.40    0.72    0.72    0.72   0.31  60.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1697.00     0.00    39.14    47.23     1.18    0.70    0.00    0.70   0.33  56.60

^C
[root@voice sbtest]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/20/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.55    0.00    0.68    0.18    0.00   98.59

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               7.28       143.48       258.67 1187522806 2140878324

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          64.74    0.00   24.43    3.02    0.00    7.81

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1744.00         0.00     38208.00          0      38208

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          62.03    0.00   24.81    3.29    0.00    9.87

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1621.00         0.00     38108.00          0      38108

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          62.66    0.00   24.06    3.51    0.00    9.77

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1644.55         0.00     37346.53          0      37720

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          61.96    0.00   24.69    3.53    0.00    9.82

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1702.00         0.00     38252.00          0      38252

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          65.24    0.00   23.68    3.27    0.00    7.81

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1595.00         0.00     38056.00          0      38056



mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-20 10:13:01 0x7fc4c816b700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 40 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 24550 srv_active, 0 srv_shutdown, 118452 srv_idle
srv_master_thread log flush and writes: 143002
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 1594145
OS WAIT ARRAY INFO: signal count 993618
RW-shared spins 0, rounds 482584, OS waits 94069
RW-excl spins 0, rounds 3094645, OS waits 88562
RW-sx spins 56062, rounds 1510957, OS waits 27237
Spin rounds per wait: 482584.00 RW-shared, 3094645.00 RW-excl, 26.95 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 47848905
Purge done for trx's n:o < 47848888 undo n:o < 0 state: running
History list length 119
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421967708637920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421967708638832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 47848904, ACTIVE 0 sec
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 124, OS thread handle 140483033466624, query id 139735159 192.168.1.12 sysbench System lock
DELETE FROM sbtest1 WHERE id=1650270
Trx read view will not see trx with id >= 47848900, sees < 47848890
---TRANSACTION 47848903, ACTIVE 0 sec
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 127, OS thread handle 140483344389888, query id 139735156 192.168.1.12 sysbench
Trx read view will not see trx with id >= 47848898, sees < 47848890
---TRANSACTION 47848901, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 122, OS thread handle 140483034547968, query id 139735147 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 47848895, sees < 47848884
---TRANSACTION 47848899, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 128, OS thread handle 140483033196288, query id 139735085 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 47848890, sees < 47848881
---TRANSACTION 47848898, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 126, OS thread handle 140483146168064, query id 139735082 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 47848891, sees < 47848881
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
2767731 OS file reads, 28549176 OS file writes, 3798289 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1150.55 writes/s, 385.27 fsyncs/s
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
Hash table size 2365241, node heap has 2946 buffer(s)
Hash table size 2365241, node heap has 5891 buffer(s)
Hash table size 2365241, node heap has 5891 buffer(s)
Hash table size 2365241, node heap has 5891 buffer(s)
10341.22 hash searches/s, 7701.71 non-hash searches/s
---
LOG
---
Log sequence number 364897797329
Log flushed up to   364897794523
Pages flushed up to 364533217208
Last checkpoint at  364530582550
1 pending log flushes, 0 pending chkp writes
6568000 log i/o's done, 284.70 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 215408
Buffer pool size   524224
Free buffers       2047
Database pages     477994
Old database pages 176406
Modified db pages  218339
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 35303655, not young 9192736
2361.89 youngs/s, 0.00 non-youngs/s
Pages read 2758901, created 5923628, written 21272902
0.00 reads/s, 0.32 creates/s, 850.30 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 27 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 477994, unzip_LRU len: 0
I/O sum[85330]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1024
Database pages     238988
Old database pages 88200
Modified db pages  108861
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 17643977, not young 4633998
1177.55 youngs/s, 0.00 non-youngs/s
Pages read 1381926, created 2961843, written 10624559
0.00 reads/s, 0.10 creates/s, 437.09 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 28 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 238988, unzip_LRU len: 0
I/O sum[42665]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       1023
Database pages     239006
Old database pages 88206
Modified db pages  109478
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 17659678, not young 4558738
1184.35 youngs/s, 0.00 non-youngs/s
Pages read 1376975, created 2961785, written 10648343
0.00 reads/s, 0.22 creates/s, 413.21 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 27 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239006, unzip_LRU len: 0
I/O sum[42665]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
9 read views open inside InnoDB
Process ID=6404, Main thread ID=140483397408512, state: sleeping
Number of rows inserted 406981470, updated 13962584, deleted 6981337, read 2947050875
520.69 inserts/s, 1041.42 updates/s, 520.69 deletes/s, 217108.45 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.02 sec)

ERROR: 
No query specified


