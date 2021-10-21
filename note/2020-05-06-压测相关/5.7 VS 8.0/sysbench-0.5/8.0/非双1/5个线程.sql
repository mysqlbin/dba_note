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

./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 --oltp-table-size=2000000 --rand-init=on prepare


purge binary logs to 'mysql-bin.000103';  



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


sudo /etc/init.d/mysql restart 


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
--oltp-table-size=2000000 --num-threads=5 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_5_not11.log &


[coding001@voice ~]$ tail -f /home/coding001/log/sysbench_oltpX_5_not11.log
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 5, tps: 401.39, reads: 5621.60, writes: 1605.54, response time: 42.41ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 5, tps: 419.71, reads: 5877.93, writes: 1678.84, response time: 40.67ms (99%), errors: 0.00, reconnects:  0.00







[  30s] threads: 5, tps: 405.58, reads: 5678.34, writes: 1622.33, response time: 42.71ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 5, tps: 380.51, reads: 5327.58, writes: 1522.02, response time: 43.70ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 5, tps: 403.70, reads: 5651.53, writes: 1614.78, response time: 38.65ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 5, tps: 403.52, reads: 5649.25, writes: 1614.47, response time: 38.95ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 5, tps: 392.90, reads: 5501.47, writes: 1571.59, response time: 43.97ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 5, tps: 384.19, reads: 5378.29, writes: 1536.77, response time: 42.29ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 5, tps: 375.61, reads: 5258.60, writes: 1502.03, response time: 43.40ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 5, tps: 356.70, reads: 4992.20, writes: 1426.80, response time: 47.18ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 5, tps: 360.90, reads: 5054.93, writes: 1443.81, response time: 47.09ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 5, tps: 390.80, reads: 5469.79, writes: 1563.00, response time: 39.80ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 5, tps: 382.10, reads: 5350.52, writes: 1529.00, response time: 42.78ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 5, tps: 397.00, reads: 5556.00, writes: 1587.60, response time: 39.24ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 5, tps: 381.50, reads: 5343.22, writes: 1526.00, response time: 42.24ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 5, tps: 387.90, reads: 5427.97, writes: 1551.39, response time: 43.58ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 5, tps: 370.68, reads: 5191.12, writes: 1482.72, response time: 44.57ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 5, tps: 371.12, reads: 5194.71, writes: 1484.49, response time: 48.04ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 5, tps: 384.70, reads: 5385.44, writes: 1538.78, response time: 44.20ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 5, tps: 370.60, reads: 5190.24, writes: 1482.41, response time: 46.16ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 5, tps: 398.90, reads: 5585.50, writes: 1595.90, response time: 40.62ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 5, tps: 398.09, reads: 5570.22, writes: 1592.08, response time: 41.38ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 5, tps: 383.90, reads: 5376.83, writes: 1535.68, response time: 44.46ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 5, tps: 440.41, reads: 6165.48, writes: 1761.55, response time: 35.48ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 5, tps: 415.10, reads: 5812.10, writes: 1660.80, response time: 37.87ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 5, tps: 420.30, reads: 5883.38, writes: 1680.80, response time: 37.20ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 5, tps: 411.10, reads: 5755.22, writes: 1644.71, response time: 39.30ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 5, tps: 409.69, reads: 5736.11, writes: 1638.67, response time: 41.89ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 5, tps: 393.35, reads: 5506.55, writes: 1573.19, response time: 43.01ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 5, tps: 386.65, reads: 5414.25, writes: 1546.72, response time: 44.59ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 5, tps: 432.60, reads: 6054.98, writes: 1730.29, response time: 37.05ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 5, tps: 435.38, reads: 6096.27, writes: 1741.51, response time: 37.97ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 5, tps: 390.62, reads: 5468.99, writes: 1562.48, response time: 45.29ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 5, tps: 432.30, reads: 6051.83, writes: 1729.21, response time: 37.61ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 5, tps: 414.30, reads: 5800.18, writes: 1657.19, response time: 42.85ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 5, tps: 439.29, reads: 6150.72, writes: 1757.48, response time: 36.27ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 5, tps: 432.81, reads: 6059.57, writes: 1731.02, response time: 38.11ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 5, tps: 455.30, reads: 6373.02, writes: 1821.11, response time: 35.87ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 5, tps: 451.18, reads: 6316.37, writes: 1804.73, response time: 35.95ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 5, tps: 426.62, reads: 5973.81, writes: 1706.76, response time: 39.80ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 5, tps: 389.70, reads: 5454.35, writes: 1558.79, response time: 48.89ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 5, tps: 377.70, reads: 5287.99, writes: 1510.50, response time: 50.13ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 5, tps: 398.10, reads: 5573.46, writes: 1592.42, response time: 46.32ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 5, tps: 389.69, reads: 5456.08, writes: 1558.77, response time: 47.06ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 5, tps: 446.51, reads: 6251.72, writes: 1786.24, response time: 36.64ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 5, tps: 445.40, reads: 6232.72, writes: 1781.41, response time: 38.82ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 5, tps: 435.50, reads: 6097.72, writes: 1742.01, response time: 37.62ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 5, tps: 451.50, reads: 6323.97, writes: 1806.09, response time: 36.59ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 5, tps: 444.30, reads: 6219.47, writes: 1777.49, response time: 37.66ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 5, tps: 418.20, reads: 5853.95, writes: 1673.21, response time: 45.50ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 5, tps: 355.76, reads: 4981.48, writes: 1422.85, response time: 50.33ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 5, tps: 421.44, reads: 5900.55, writes: 1685.36, response time: 41.13ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 5, tps: 416.10, reads: 5824.05, writes: 1664.22, response time: 42.79ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 5, tps: 422.69, reads: 5917.17, writes: 1691.36, response time: 43.59ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 5, tps: 435.68, reads: 6099.86, writes: 1742.43, response time: 36.07ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 5, tps: 437.73, reads: 6128.01, writes: 1750.62, response time: 36.95ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 5, tps: 439.79, reads: 6157.50, writes: 1759.37, response time: 37.11ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 5, tps: 420.50, reads: 5887.86, writes: 1682.02, response time: 39.68ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 5, tps: 420.99, reads: 5892.40, writes: 1683.74, response time: 41.61ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 5, tps: 445.84, reads: 6241.62, writes: 1783.35, response time: 38.26ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 5, tps: 461.85, reads: 6466.81, writes: 1847.80, response time: 36.35ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 5, tps: 465.15, reads: 6511.50, writes: 1861.40, response time: 35.30ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 5, tps: 425.40, reads: 5954.44, writes: 1700.71, response time: 40.73ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 5, tps: 389.60, reads: 5456.95, writes: 1558.38, response time: 43.01ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 5, tps: 358.80, reads: 5020.74, writes: 1435.01, response time: 45.67ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 5, tps: 424.50, reads: 5945.61, writes: 1698.10, response time: 41.13ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 5, tps: 415.80, reads: 5819.90, writes: 1663.00, response time: 41.91ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 5, tps: 433.10, reads: 6064.19, writes: 1732.40, response time: 37.35ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 5, tps: 423.70, reads: 5931.92, writes: 1694.81, response time: 39.94ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 5, tps: 410.59, reads: 5746.25, writes: 1642.36, response time: 42.34ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 5, tps: 410.41, reads: 5744.30, writes: 1642.03, response time: 42.42ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 5, tps: 399.87, reads: 5602.80, writes: 1601.09, response time: 45.85ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 5, tps: 418.03, reads: 5850.08, writes: 1670.54, response time: 40.51ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 5, tps: 412.40, reads: 5772.40, writes: 1649.50, response time: 40.91ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 5, tps: 403.70, reads: 5654.96, writes: 1614.99, response time: 42.97ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 5, tps: 431.10, reads: 6035.10, writes: 1723.90, response time: 38.72ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 5, tps: 411.60, reads: 5761.98, writes: 1646.69, response time: 41.96ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 5, tps: 399.20, reads: 5586.39, writes: 1596.80, response time: 45.05ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 5, tps: 394.40, reads: 5524.51, writes: 1577.80, response time: 44.47ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 5, tps: 372.60, reads: 5213.65, writes: 1489.91, response time: 48.87ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 5, tps: 371.89, reads: 5208.68, writes: 1487.56, response time: 49.12ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 5, tps: 370.91, reads: 5191.09, writes: 1483.62, response time: 47.94ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 5, tps: 395.09, reads: 5531.03, writes: 1580.65, response time: 47.19ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 5, tps: 410.62, reads: 5748.92, writes: 1642.16, response time: 45.43ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 5, tps: 444.79, reads: 6227.69, writes: 1779.17, response time: 37.52ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 5, tps: 438.10, reads: 6135.14, writes: 1752.58, response time: 36.93ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 5, tps: 417.21, reads: 5838.61, writes: 1668.63, response time: 39.59ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 5, tps: 427.90, reads: 5991.35, writes: 1711.71, response time: 41.02ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 5, tps: 378.39, reads: 5297.24, writes: 1513.56, response time: 50.66ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 5, tps: 419.51, reads: 5872.42, writes: 1678.03, response time: 42.62ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 5, tps: 429.90, reads: 6018.03, writes: 1719.51, response time: 39.17ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 5, tps: 451.89, reads: 6328.31, writes: 1807.57, response time: 35.94ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 5, tps: 402.31, reads: 5631.68, writes: 1609.22, response time: 42.02ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 5, tps: 418.10, reads: 5854.32, writes: 1672.51, response time: 41.63ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 5, tps: 422.40, reads: 5911.68, writes: 1689.89, response time: 38.93ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 5, tps: 425.00, reads: 5949.30, writes: 1699.60, response time: 42.22ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 5, tps: 407.50, reads: 5705.64, writes: 1630.08, response time: 42.23ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 5, tps: 423.40, reads: 5929.85, writes: 1693.51, response time: 38.70ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 5, tps: 435.09, reads: 6091.40, writes: 1740.64, response time: 38.42ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 5, tps: 436.81, reads: 6112.25, writes: 1746.94, response time: 38.51ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 5, tps: 428.29, reads: 5999.01, writes: 1713.57, response time: 38.83ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 5, tps: 426.81, reads: 5974.72, writes: 1707.13, response time: 41.78ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 5, tps: 429.56, reads: 6014.12, writes: 1717.94, response time: 37.70ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 5, tps: 418.93, reads: 5864.26, writes: 1675.93, response time: 39.62ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 5, tps: 408.29, reads: 5717.65, writes: 1633.06, response time: 42.32ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 5, tps: 448.90, reads: 6282.55, writes: 1795.82, response time: 36.46ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 5, tps: 412.32, reads: 5772.71, writes: 1649.06, response time: 41.35ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 5, tps: 422.79, reads: 5921.05, writes: 1691.16, response time: 39.54ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 5, tps: 298.19, reads: 4171.52, writes: 1192.65, response time: 46.61ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 5, tps: 424.23, reads: 5939.39, writes: 1697.31, response time: 38.38ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 5, tps: 415.26, reads: 5815.59, writes: 1660.75, response time: 39.62ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 5, tps: 430.24, reads: 6021.82, writes: 1720.85, response time: 37.86ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 5, tps: 443.76, reads: 6213.40, writes: 1775.06, response time: 37.31ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 5, tps: 403.74, reads: 5652.90, writes: 1615.34, response time: 43.29ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 5, tps: 414.50, reads: 5802.89, writes: 1657.60, response time: 40.75ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 5, tps: 423.18, reads: 5923.16, writes: 1692.70, response time: 41.81ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 5, tps: 388.52, reads: 5438.52, writes: 1554.09, response time: 43.71ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 5, tps: 402.40, reads: 5633.36, writes: 1609.59, response time: 42.10ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 5, tps: 378.60, reads: 5300.03, writes: 1514.41, response time: 45.19ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 5, tps: 389.00, reads: 5449.81, writes: 1556.40, response time: 45.58ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 5, tps: 446.17, reads: 6246.46, writes: 1784.48, response time: 36.67ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 5, tps: 440.01, reads: 6157.69, writes: 1760.12, response time: 36.57ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 5, tps: 402.62, reads: 5638.13, writes: 1610.39, response time: 44.13ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 5, tps: 422.76, reads: 5919.12, writes: 1690.94, response time: 38.56ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 5, tps: 428.53, reads: 5996.69, writes: 1714.04, response time: 39.06ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 5, tps: 445.10, reads: 6231.74, writes: 1780.71, response time: 36.16ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 5, tps: 447.10, reads: 6258.37, writes: 1788.12, response time: 35.33ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 5, tps: 440.99, reads: 6178.02, writes: 1765.18, response time: 35.78ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 5, tps: 447.30, reads: 6258.79, writes: 1788.20, response time: 35.01ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 5, tps: 456.70, reads: 6394.75, writes: 1826.81, response time: 35.51ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 5, tps: 440.99, reads: 6176.32, writes: 1763.78, response time: 38.71ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 5, tps: 448.90, reads: 6283.17, writes: 1795.59, response time: 34.99ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 5, tps: 445.06, reads: 6229.03, writes: 1780.24, response time: 36.12ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 5, tps: 442.35, reads: 6191.48, writes: 1769.40, response time: 37.39ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 5, tps: 439.20, reads: 6151.09, writes: 1757.00, response time: 35.66ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 5, tps: 446.58, reads: 6253.08, writes: 1786.41, response time: 36.58ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 5, tps: 463.22, reads: 6483.90, writes: 1852.88, response time: 35.01ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 5, tps: 443.20, reads: 6205.26, writes: 1772.52, response time: 37.13ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 5, tps: 458.10, reads: 6413.39, writes: 1832.60, response time: 34.15ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 5, tps: 428.69, reads: 6001.71, writes: 1715.17, response time: 37.29ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 5, tps: 430.11, reads: 6021.20, writes: 1720.03, response time: 37.10ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 5, tps: 456.27, reads: 6386.65, writes: 1824.87, response time: 34.00ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 5, tps: 443.13, reads: 6204.92, writes: 1772.62, response time: 35.69ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 5, tps: 457.14, reads: 6399.61, writes: 1828.47, response time: 35.16ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 5, tps: 422.35, reads: 5915.52, writes: 1689.90, response time: 39.70ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 5, tps: 427.80, reads: 5984.38, writes: 1710.70, response time: 42.07ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 5, tps: 435.10, reads: 6093.39, writes: 1740.40, response time: 37.13ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 5, tps: 431.80, reads: 6047.36, writes: 1727.42, response time: 38.26ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 5, tps: 449.80, reads: 6295.41, writes: 1799.40, response time: 35.77ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 5, tps: 438.18, reads: 6136.99, writes: 1752.94, response time: 37.70ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 5, tps: 460.80, reads: 6449.86, writes: 1842.72, response time: 34.62ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 5, tps: 451.38, reads: 6319.38, writes: 1805.74, response time: 34.97ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 5, tps: 447.93, reads: 6270.86, writes: 1791.40, response time: 37.70ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 5, tps: 464.40, reads: 6503.80, writes: 1858.40, response time: 35.30ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 5, tps: 446.79, reads: 6251.51, writes: 1786.37, response time: 35.59ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 5, tps: 438.51, reads: 6140.10, writes: 1754.03, response time: 37.50ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 5, tps: 441.39, reads: 6179.68, writes: 1765.77, response time: 36.06ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 5, tps: 451.61, reads: 6323.38, writes: 1806.42, response time: 36.73ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 5, tps: 456.70, reads: 6393.91, writes: 1827.00, response time: 34.05ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 5, tps: 451.70, reads: 6322.59, writes: 1806.40, response time: 35.97ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 5, tps: 462.70, reads: 6478.70, writes: 1851.70, response time: 34.00ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 5, tps: 449.09, reads: 6287.32, writes: 1795.68, response time: 36.27ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 5, tps: 427.90, reads: 5989.84, writes: 1711.71, response time: 37.29ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 5, tps: 449.99, reads: 6299.29, writes: 1799.97, response time: 36.51ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 5, tps: 445.01, reads: 6232.11, writes: 1780.23, response time: 35.81ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 5, tps: 418.00, reads: 5849.46, writes: 1671.52, response time: 44.61ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 5, tps: 452.20, reads: 6331.80, writes: 1808.90, response time: 34.71ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 5, tps: 457.70, reads: 6408.80, writes: 1831.50, response time: 35.06ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 5, tps: 469.79, reads: 6578.09, writes: 1878.77, response time: 32.83ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 5, tps: 433.14, reads: 6064.32, writes: 1732.78, response time: 36.83ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 5, tps: 431.65, reads: 6042.79, writes: 1726.00, response time: 36.76ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 5, tps: 412.51, reads: 5773.38, writes: 1650.05, response time: 40.89ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 5, tps: 466.20, reads: 6527.61, writes: 1864.80, response time: 33.93ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 5, tps: 448.40, reads: 6276.89, writes: 1793.60, response time: 35.58ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 5, tps: 447.79, reads: 6269.92, writes: 1791.75, response time: 35.69ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 5, tps: 454.60, reads: 6364.38, writes: 1818.09, response time: 34.88ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 5, tps: 419.17, reads: 5867.63, writes: 1676.66, response time: 39.81ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 5, tps: 415.14, reads: 5812.30, writes: 1660.77, response time: 40.89ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 5, tps: 432.30, reads: 6053.82, writes: 1729.21, response time: 39.51ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 5, tps: 458.10, reads: 6412.77, writes: 1832.29, response time: 34.55ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            10624124
        write:                           3035464
        other:                           1517732
        total:                           15177320
    transactions:                        758866 (421.59 per sec.)
    read/write requests:                 13659588 (7588.64 per sec.)
    other operations:                    1517732 (843.18 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0056s
    total number of events:              758866
    total time taken by event execution: 8996.9619s
    response time:
         min:                                  4.40ms
         avg:                                 11.86ms
         max:                                139.67ms
         approx.  99 percentile:              40.42ms

Threads fairness:
    events (avg/stddev):           151773.2000/159.48
    execution time (avg/stddev):   1799.3924/0.00


mysql> show processlist;
+----+-----------------+--------------------+--------+---------+-------+------------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time  | State                        | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+-------+------------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 62442 | Waiting on empty queue       | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |     0 | starting                     | show processlist                                                                                     |
| 33 | sysbench        | 192.168.1.12:51454 | sbtest | Query   |     0 | Waiting for query cache lock | SELECT c FROM sbtest6 WHERE id BETWEEN 555560 AND 555560+99 ORDER BY c                               |
| 34 | sysbench        | 192.168.1.12:51450 | sbtest | Query   |     0 | Opening tables               | INSERT INTO sbtest3 (id, k, c, pad) VALUES (1517079, 1061476, '7545590584-79905949463-77772093689-7' |
| 35 | sysbench        | 192.168.1.12:51449 | sbtest | Query   |     0 | init                         | SELECT c FROM sbtest7 WHERE id=493010                                                                |
| 36 | sysbench        | 192.168.1.12:51448 | sbtest | Query   |     0 | Creating sort index          | SELECT c FROM sbtest8 WHERE id BETWEEN 606268 AND 606268+99 ORDER BY c                               |
| 37 | sysbench        | 192.168.1.12:51456 | sbtest | Sleep   |     0 |                              | NULL                                                                                                 |
+----+-----------------+--------------------+--------+---------+-------+------------------------------+------------------------------------------------------------------------------------------------------+
7 rows in set (0.00 sec)

[root@voice mysql]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    2.10    4.53     0.14     0.22   110.88     0.07   10.79   23.98    4.68   0.65   0.43

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    2.00  445.00     0.01    25.37   116.28     0.58    1.30    0.50    1.31   0.41  18.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  446.00     0.00    24.96   114.62     0.58    1.31    0.00    1.31   0.41  18.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  442.00     0.00    27.26   126.30     0.66    1.49    0.00    1.49   0.44  19.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  443.00     0.00    24.97   115.45     0.61    1.39    0.00    1.39   0.43  18.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  455.00     0.00    25.05   112.76     0.60    1.33    0.00    1.33   0.42  19.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  407.00     0.00    27.32   137.49     0.65    1.59    0.00    1.59   0.49  20.00

^C
[root@voice mysql]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.51    0.00    0.67    0.18    0.00   98.64

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               6.63       144.27       223.17 1184921994 1832934320

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          62.22    0.00   23.17    3.02    0.00   11.59

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             401.00         0.00     28084.00          0      28084

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          62.53    0.00   22.78    2.78    0.00   11.90

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             407.00         0.00     25704.00          0      25704

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          61.68    0.00   20.81    3.81    0.00   13.71

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             441.00         0.00     25708.00          0      25708

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          59.49    0.00   22.53    3.54    0.00   14.43

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             437.00         0.00     27644.00          0      27644





[root@voice mysql]# top
top - 16:25:39 up 95 days,  1:23,  4 users,  load average: 5.79, 5.24, 3.64
Tasks: 122 total,   3 running, 119 sleeping,   0 stopped,   0 zombie
%Cpu0  : 56.0 us, 17.9 sy,  0.0 ni, 16.7 id,  4.8 wa,  0.0 hi,  4.8 si,  0.0 st
%Cpu1  : 57.6 us, 17.6 sy,  0.0 ni, 16.5 id,  3.5 wa,  0.0 hi,  4.7 si,  0.0 st
%Cpu2  : 56.5 us, 15.3 sy,  0.0 ni, 17.6 id,  4.7 wa,  0.0 hi,  5.9 si,  0.0 st
%Cpu3  : 59.0 us, 20.5 sy,  0.0 ni, 10.8 id,  6.0 wa,  0.0 hi,  3.6 si,  0.0 st
KiB Mem : 16266300 total,   169280 free, 10040572 used,  6056448 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5124112 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   9.0g   4336 S 265.5 58.2 534:30.21 mysqld                                                                                                                                                                    
28383 coding0+  20   0  363692   4524   1944 S  53.6  0.0   4:37.72 sysbench                                                                                                                                                                  
12433 coding0+  20   0  174352  27040    688 S   2.4  0.2 246:15.14 skynet                                                                                                                                                                    
31174 coding0+  20   0  147768  35060    844 S   2.4  0.2 283:49.68 skynet                                                                                                                                                                    
   46 root      20   0       0      0      0 S   1.2  0.0   7:39.38 kswapd0                                                                                                                                                                   
28810 root      20   0       0      0      0 R   1.2  0.0   0:00.02 kworker/3:2     








mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-19 16:25:55 0x7fc4c816b700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 60 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 17085 srv_active, 0 srv_shutdown, 62123 srv_idle
srv_master_thread log flush and writes: 79208
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 912599
OS WAIT ARRAY INFO: signal count 606155
RW-shared spins 0, rounds 351389, OS waits 68002
RW-excl spins 0, rounds 2324018, OS waits 62340
RW-sx spins 22791, rounds 618103, OS waits 11844
Spin rounds per wait: 351389.00 RW-shared, 2324018.00 RW-excl, 27.12 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 42561819
Purge done for trx's n:o < 42561813 undo n:o < 0 state: running
History list length 28
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421967708637920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421967708638832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 42561817, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 90, OS thread handle 140483147790080, query id 87184545 192.168.1.12 sysbench
Trx read view will not see trx with id >= 42561813, sees < 42561809
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
2762744 OS file reads, 19120094 OS file writes, 2216344 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1190.20 writes/s, 100.93 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 162252 merges
merged operations:
 insert 81305, delete mark 140992, delete 44934
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365241, node heap has 5836 buffer(s)
Hash table size 2365241, node heap has 2920 buffer(s)
Hash table size 2365241, node heap has 5791 buffer(s)
Hash table size 2365241, node heap has 5835 buffer(s)
Hash table size 2365241, node heap has 5834 buffer(s)
Hash table size 2365241, node heap has 5835 buffer(s)
Hash table size 2365241, node heap has 5833 buffer(s)
Hash table size 2365241, node heap has 5833 buffer(s)
8010.35 hash searches/s, 6602.34 non-hash searches/s
---
LOG
---
Log sequence number 334289689675
Log flushed up to   334289657411
Pages flushed up to 333963133792
Last checkpoint at  333958660629
0 pending log flushes, 0 pending chkp writes
4255943 log i/o's done, 417.42 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 215408
Buffer pool size   524224
Free buffers       2047
Database pages     478460
Old database pages 176578
Modified db pages  181713
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 22611662, not young 9187721
1935.60 youngs/s, 0.00 non-youngs/s
Pages read 2758774, created 4592649, written 14358154
0.00 reads/s, 0.78 creates/s, 758.65 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 27 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 478460, unzip_LRU len: 0
I/O sum[75794]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1024
Database pages     239227
Old database pages 88288
Modified db pages  91493
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 11300946, not young 4630763
972.67 youngs/s, 0.00 non-youngs/s
Pages read 1381843, created 2296605, written 7170509
0.00 reads/s, 0.53 creates/s, 379.26 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 27 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239227, unzip_LRU len: 0
I/O sum[37897]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       1023
Database pages     239233
Old database pages 88290
Modified db pages  90220
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 11310716, not young 4556958
962.93 youngs/s, 0.00 non-youngs/s
Pages read 1376931, created 2296044, written 7187645
0.00 reads/s, 0.25 creates/s, 379.39 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 28 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239233, unzip_LRU len: 0
I/O sum[37897]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
5 read views open inside InnoDB
Process ID=6404, Main thread ID=140483397408512, state: sleeping
Number of rows inserted 314355612, updated 8710881, deleted 4355479, read 1850125512
419.88 inserts/s, 839.72 updates/s, 419.88 deletes/s, 175068.47 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.00 sec)

