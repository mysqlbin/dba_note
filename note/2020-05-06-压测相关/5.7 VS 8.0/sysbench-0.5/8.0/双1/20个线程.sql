-- IO没有跑满，但是CPU先打满了，所以TPS、QPS上不去

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


./sysbench --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench --mysql-password='1234Abc&' --test=tests/db/oltp.lua --oltp_tables_count=15 --oltp-table-size=2000000 --rand-init=on prepare &


purge binary logs to 'mysql-bin.000013';  



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


./sysbench --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench \
--mysql-password='1234Abc&' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=20 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_20_11_vision8.log &
 

[coding001@voice mysql3307]$ tail -f /home/coding001/log/sysbench_oltpX_20_11_vision8.log
Number of threads: 20
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 20, tps: 379.69, reads: 5336.49, writes: 1520.14, response time: 99.26ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 20, tps: 395.21, reads: 5536.40, writes: 1583.83, response time: 95.70ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 20, tps: 392.59, reads: 5495.00, writes: 1567.77, response time: 92.63ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 20, tps: 385.89, reads: 5401.82, writes: 1544.38, response time: 95.04ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 20, tps: 390.11, reads: 5462.91, writes: 1561.53, response time: 96.13ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 20, tps: 388.60, reads: 5436.79, writes: 1552.30, response time: 96.39ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 20, tps: 391.99, reads: 5489.98, writes: 1567.66, response time: 96.79ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 20, tps: 400.40, reads: 5608.24, writes: 1606.01, response time: 94.50ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 20, tps: 397.61, reads: 5563.66, writes: 1587.55, response time: 96.02ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 20, tps: 389.39, reads: 5450.72, writes: 1557.28, response time: 97.84ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 20, tps: 398.41, reads: 5583.28, writes: 1594.62, response time: 93.94ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 20, tps: 406.60, reads: 5691.13, writes: 1628.51, response time: 93.32ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 20, tps: 408.59, reads: 5716.37, writes: 1632.76, response time: 92.79ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 20, tps: 416.60, reads: 5831.78, writes: 1666.29, response time: 91.77ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 20, tps: 400.51, reads: 5609.13, writes: 1602.44, response time: 93.49ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 20, tps: 399.39, reads: 5593.41, writes: 1599.28, response time: 94.73ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 20, tps: 409.21, reads: 5724.10, writes: 1633.63, response time: 91.42ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 20, tps: 402.80, reads: 5640.00, writes: 1611.00, response time: 94.87ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 20, tps: 406.99, reads: 5693.67, writes: 1626.16, response time: 92.91ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 20, tps: 407.10, reads: 5702.00, writes: 1629.30, response time: 91.72ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 20, tps: 405.11, reads: 5675.10, writes: 1622.83, response time: 91.74ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 20, tps: 401.50, reads: 5620.00, writes: 1604.50, response time: 96.04ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 20, tps: 400.30, reads: 5601.75, writes: 1601.48, response time: 93.18ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 20, tps: 395.91, reads: 5548.60, writes: 1583.93, response time: 94.45ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 20, tps: 396.70, reads: 5551.93, writes: 1585.98, response time: 96.88ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 20, tps: 390.80, reads: 5467.89, writes: 1562.80, response time: 96.04ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 20, tps: 400.00, reads: 5601.55, writes: 1602.09, response time: 97.26ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 20, tps: 390.20, reads: 5463.67, writes: 1560.92, response time: 95.64ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 20, tps: 390.50, reads: 5468.44, writes: 1563.08, response time: 98.05ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 20, tps: 404.10, reads: 5652.02, writes: 1612.71, response time: 92.02ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 20, tps: 404.41, reads: 5665.07, writes: 1620.42, response time: 92.18ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 20, tps: 410.40, reads: 5743.25, writes: 1638.08, response time: 91.88ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 20, tps: 410.60, reads: 5751.04, writes: 1644.21, response time: 90.82ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 20, tps: 400.49, reads: 5603.93, writes: 1603.58, response time: 97.29ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 20, tps: 402.21, reads: 5637.28, writes: 1609.62, response time: 96.25ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 20, tps: 409.50, reads: 5731.94, writes: 1638.68, response time: 92.74ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 20, tps: 410.90, reads: 5747.16, writes: 1641.29, response time: 92.88ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 20, tps: 411.00, reads: 5758.36, writes: 1643.62, response time: 94.59ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 20, tps: 406.50, reads: 5689.84, writes: 1626.21, response time: 93.60ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 20, tps: 402.50, reads: 5635.86, writes: 1608.29, response time: 95.50ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 20, tps: 412.20, reads: 5775.33, writes: 1654.91, response time: 91.77ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 20, tps: 408.00, reads: 5709.18, writes: 1629.29, response time: 93.66ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 20, tps: 411.69, reads: 5762.20, writes: 1645.37, response time: 89.98ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 20, tps: 411.21, reads: 5755.70, writes: 1643.83, response time: 92.21ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 20, tps: 405.30, reads: 5677.43, writes: 1625.21, response time: 97.26ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 20, tps: 410.50, reads: 5745.17, writes: 1638.09, response time: 92.79ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 20, tps: 411.50, reads: 5754.19, writes: 1646.20, response time: 92.54ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 20, tps: 400.20, reads: 5606.72, writes: 1603.51, response time: 96.33ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 20, tps: 398.79, reads: 5584.02, writes: 1592.88, response time: 97.46ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 20, tps: 406.80, reads: 5690.34, writes: 1624.78, response time: 93.88ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 20, tps: 409.60, reads: 5734.61, writes: 1638.80, response time: 91.72ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 20, tps: 406.51, reads: 5699.57, writes: 1630.22, response time: 92.38ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 20, tps: 407.20, reads: 5699.99, writes: 1626.60, response time: 96.30ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 20, tps: 408.10, reads: 5712.15, writes: 1630.69, response time: 92.49ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 20, tps: 415.61, reads: 5816.00, writes: 1661.63, response time: 91.03ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 20, tps: 409.89, reads: 5739.70, writes: 1640.77, response time: 91.22ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 20, tps: 409.91, reads: 5739.78, writes: 1641.52, response time: 92.52ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 20, tps: 412.30, reads: 5773.60, writes: 1649.20, response time: 89.15ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 20, tps: 404.50, reads: 5662.85, writes: 1619.38, response time: 92.10ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 20, tps: 400.51, reads: 5605.49, writes: 1599.22, response time: 93.60ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 20, tps: 396.29, reads: 5548.43, writes: 1585.68, response time: 94.28ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 20, tps: 409.60, reads: 5726.62, writes: 1636.71, response time: 92.35ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 20, tps: 401.99, reads: 5631.53, writes: 1609.15, response time: 94.56ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 20, tps: 402.21, reads: 5630.51, writes: 1608.36, response time: 94.93ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 20, tps: 414.10, reads: 5801.34, writes: 1659.21, response time: 90.27ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 20, tps: 409.20, reads: 5729.19, writes: 1635.70, response time: 94.45ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 20, tps: 408.80, reads: 5726.68, writes: 1638.29, response time: 92.27ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 20, tps: 410.40, reads: 5745.15, writes: 1637.79, response time: 94.00ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 20, tps: 413.20, reads: 5777.56, writes: 1653.42, response time: 90.22ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 20, tps: 405.79, reads: 5683.79, writes: 1622.57, response time: 96.13ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 20, tps: 406.11, reads: 5682.83, writes: 1624.34, response time: 103.14ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 20, tps: 404.60, reads: 5670.90, writes: 1620.00, response time: 91.99ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 20, tps: 404.20, reads: 5653.88, writes: 1617.10, response time: 94.67ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 20, tps: 407.60, reads: 5708.81, writes: 1630.00, response time: 94.08ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 20, tps: 408.90, reads: 5721.08, writes: 1634.69, response time: 91.96ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 20, tps: 408.60, reads: 5718.27, writes: 1633.39, response time: 95.01ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 20, tps: 409.40, reads: 5734.66, writes: 1639.09, response time: 92.41ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 20, tps: 406.00, reads: 5691.34, writes: 1626.98, response time: 93.04ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 20, tps: 414.01, reads: 5788.62, writes: 1652.13, response time: 91.50ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 20, tps: 408.60, reads: 5721.86, writes: 1633.22, response time: 92.02ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 20, tps: 402.49, reads: 5638.57, writes: 1613.46, response time: 95.10ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 20, tps: 410.20, reads: 5733.05, writes: 1635.89, response time: 90.90ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 20, tps: 402.41, reads: 5639.95, writes: 1611.74, response time: 96.10ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 20, tps: 405.40, reads: 5677.45, writes: 1620.41, response time: 94.08ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 20, tps: 412.70, reads: 5765.95, writes: 1651.39, response time: 91.80ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 20, tps: 406.40, reads: 5704.61, writes: 1631.20, response time: 95.27ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 20, tps: 406.59, reads: 5689.91, writes: 1622.85, response time: 92.68ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 20, tps: 399.29, reads: 5588.50, writes: 1596.94, response time: 94.14ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 20, tps: 397.53, reads: 5567.09, writes: 1589.21, response time: 94.73ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 20, tps: 412.00, reads: 5763.20, writes: 1646.70, response time: 91.99ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 20, tps: 405.10, reads: 5673.99, writes: 1620.70, response time: 91.96ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 20, tps: 400.40, reads: 5603.83, writes: 1601.51, response time: 94.73ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 20, tps: 409.69, reads: 5738.13, writes: 1640.15, response time: 92.49ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 20, tps: 407.00, reads: 5702.27, writes: 1631.02, response time: 92.88ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 20, tps: 310.49, reads: 4343.31, writes: 1237.67, response time: 188.30ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 20, tps: 251.41, reads: 3516.11, writes: 1004.83, response time: 205.00ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 20, tps: 407.80, reads: 5713.86, writes: 1633.39, response time: 94.02ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 20, tps: 411.38, reads: 5756.30, writes: 1644.71, response time: 90.44ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 20, tps: 407.41, reads: 5703.09, writes: 1628.25, response time: 93.49ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 20, tps: 405.60, reads: 5678.84, writes: 1623.08, response time: 94.67ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 20, tps: 410.60, reads: 5752.25, writes: 1644.41, response time: 91.03ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 20, tps: 404.41, reads: 5664.00, writes: 1621.76, response time: 93.18ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 20, tps: 401.80, reads: 5622.13, writes: 1601.38, response time: 94.82ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 20, tps: 408.61, reads: 5721.67, writes: 1638.92, response time: 92.18ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 20, tps: 410.40, reads: 5739.46, writes: 1636.39, response time: 91.99ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 20, tps: 405.70, reads: 5675.06, writes: 1624.89, response time: 92.68ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 20, tps: 404.79, reads: 5673.68, writes: 1616.87, response time: 91.66ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 20, tps: 401.41, reads: 5618.04, writes: 1605.94, response time: 94.53ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 20, tps: 396.00, reads: 5542.27, writes: 1583.79, response time: 96.45ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 20, tps: 398.21, reads: 5584.18, writes: 1598.82, response time: 94.62ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 20, tps: 396.60, reads: 5545.04, writes: 1582.38, response time: 96.71ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 20, tps: 400.20, reads: 5606.75, writes: 1603.08, response time: 95.99ms (99%), errors: 0.00, reconnects:  0.00
^C
[coding001@voice mysql3307]$ tail -f /home/coding001/log/sysbench_oltpX_20_11_vision8.log
[1290s] threads: 20, tps: 380.70, reads: 5332.56, writes: 1523.39, response time: 101.85ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 20, tps: 394.50, reads: 5524.34, writes: 1580.01, response time: 102.34ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 20, tps: 412.49, reads: 5776.33, writes: 1650.68, response time: 91.01ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 20, tps: 411.10, reads: 5742.19, writes: 1638.10, response time: 96.19ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 20, tps: 409.60, reads: 5746.72, writes: 1643.80, response time: 92.30ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 20, tps: 404.20, reads: 5651.17, writes: 1613.52, response time: 94.45ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 20, tps: 398.49, reads: 5580.08, writes: 1593.96, response time: 94.00ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 20, tps: 405.59, reads: 5683.09, writes: 1625.27, response time: 94.25ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 20, tps: 403.10, reads: 5643.73, writes: 1611.71, response time: 96.51ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 20, tps: 403.91, reads: 5655.70, writes: 1616.26, response time: 93.83ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 20, tps: 415.20, reads: 5810.78, writes: 1661.69, response time: 88.61ms (99%), errors: 0.00, reconnects:  0.00


[1400s] threads: 20, tps: 413.59, reads: 5790.50, writes: 1651.67, response time: 91.74ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 20, tps: 415.31, reads: 5810.81, writes: 1662.53, response time: 90.90ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 20, tps: 410.90, reads: 5754.15, writes: 1642.39, response time: 91.83ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 20, tps: 415.69, reads: 5824.90, writes: 1665.57, response time: 92.96ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 20, tps: 411.40, reads: 5757.53, writes: 1644.01, response time: 94.84ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 20, tps: 406.21, reads: 5681.32, writes: 1622.53, response time: 92.10ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 20, tps: 387.98, reads: 5431.81, writes: 1552.62, response time: 92.41ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 20, tps: 381.00, reads: 5335.62, writes: 1522.00, response time: 92.82ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 20, tps: 383.62, reads: 5365.62, writes: 1534.56, response time: 91.42ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 20, tps: 391.60, reads: 5488.84, writes: 1570.21, response time: 94.76ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 20, tps: 392.69, reads: 5501.03, writes: 1571.25, response time: 87.30ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 20, tps: 400.90, reads: 5605.14, writes: 1600.28, response time: 94.19ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 20, tps: 412.00, reads: 5775.46, writes: 1649.82, response time: 89.36ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 20, tps: 408.91, reads: 5723.49, writes: 1637.23, response time: 89.09ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 20, tps: 399.30, reads: 5586.67, writes: 1593.89, response time: 93.52ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 20, tps: 394.81, reads: 5526.99, writes: 1578.82, response time: 91.58ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 20, tps: 389.90, reads: 5459.83, writes: 1560.91, response time: 92.21ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 20, tps: 393.59, reads: 5510.94, writes: 1574.25, response time: 92.74ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 20, tps: 399.40, reads: 5592.87, writes: 1596.62, response time: 90.84ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 20, tps: 408.29, reads: 5710.52, writes: 1634.18, response time: 93.49ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 20, tps: 408.90, reads: 5730.83, writes: 1636.11, response time: 91.50ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 20, tps: 409.01, reads: 5727.55, writes: 1638.54, response time: 91.74ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 20, tps: 400.59, reads: 5602.20, writes: 1600.37, response time: 92.35ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 20, tps: 395.89, reads: 5543.80, writes: 1582.97, response time: 89.82ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 20, tps: 395.41, reads: 5536.27, writes: 1583.85, response time: 90.41ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 20, tps: 398.40, reads: 5579.63, writes: 1590.71, response time: 90.38ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 20, tps: 405.99, reads: 5684.45, writes: 1624.56, response time: 91.20ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 20, tps: 408.51, reads: 5710.54, writes: 1632.74, response time: 89.44ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 20, tps: 393.39, reads: 5516.87, writes: 1573.26, response time: 91.83ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 20, tps: 392.80, reads: 5489.73, writes: 1570.81, response time: 94.42ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 20, tps: 400.69, reads: 5610.27, writes: 1602.76, response time: 90.73ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 20, tps: 388.81, reads: 5446.71, writes: 1556.53, response time: 92.32ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 20, tps: 392.50, reads: 5499.68, writes: 1572.00, response time: 90.11ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 20, tps: 400.80, reads: 5612.39, writes: 1603.30, response time: 89.36ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 20, tps: 400.11, reads: 5603.52, writes: 1601.63, response time: 93.04ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 20, tps: 401.10, reads: 5613.81, writes: 1603.70, response time: 93.97ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 20, tps: 401.79, reads: 5620.02, writes: 1603.88, response time: 92.77ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 20, tps: 398.80, reads: 5586.56, writes: 1597.49, response time: 90.25ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 20, tps: 393.41, reads: 5508.41, writes: 1574.43, response time: 92.93ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 20, tps: 395.00, reads: 5523.73, writes: 1579.58, response time: 92.52ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 20, tps: 393.80, reads: 5514.26, writes: 1572.02, response time: 93.04ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            10111612
        write:                           2889032
        other:                           1444516
        total:                           14445160
    transactions:                        722258 (401.25 per sec.)
    read/write requests:                 13000644 (7222.47 per sec.)
    other operations:                    1444516 (802.50 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0282s
    total number of events:              722258
    total time taken by event execution: 35997.8464s
    response time:
         min:                                 11.67ms
         avg:                                 49.84ms
         max:                                270.54ms
         approx.  99 percentile:              95.56ms

Threads fairness:
    events (avg/stddev):           36112.9000/95.96
    execution time (avg/stddev):   1799.8923/0.01


[coding001@voice ~]$ top
top - 11:00:49 up 96 days, 19:59,  4 users,  load average: 18.37, 17.96, 13.73
Tasks: 127 total,   2 running, 125 sleeping,   0 stopped,   0 zombie
%Cpu0  : 66.2 us, 23.7 sy,  0.0 ni,  0.7 id,  0.7 wa,  0.0 hi,  8.7 si,  0.0 st
%Cpu1  : 74.1 us, 19.3 sy,  0.0 ni,  1.7 id,  0.3 wa,  0.0 hi,  4.7 si,  0.0 st
%Cpu2  : 75.4 us, 18.3 sy,  0.0 ni,  1.3 id,  0.7 wa,  0.0 hi,  4.3 si,  0.0 st
%Cpu3  : 76.1 us, 17.3 sy,  0.0 ni,  1.7 id,  0.0 wa,  0.0 hi,  5.0 si,  0.0 st
KiB Mem : 16266300 total,  1113872 free, 11197212 used,  3955216 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  3962376 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
32578 mysql     20   0   11.2g   8.8g   7940 S 271.2 57.0 142:49.14 mysqld                                                                                                                                                                     
15412 coding0+  20   0 1349076   6268   2100 S 114.2  0.0  21:37.27 sysbench   


[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.09    7.42     0.14     0.32    98.88     0.08    8.64   23.74    4.40   0.56   0.53

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3596.00     0.00    49.66    28.28     1.99    0.55    0.00    0.55   0.21  76.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 3420.00     0.00    46.16    27.64     1.90    0.56    0.00    0.56   0.22  74.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3715.00     0.00    51.80    28.55     2.06    0.55    0.00    0.55   0.21  79.10

^C
[coding001@voice ~]$ iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.64    0.00    0.70    0.18    0.00   98.47

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               9.51       143.18       327.00 1197936822 2735840484

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          72.68    0.00   26.32    0.25    0.00    0.75

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3641.00         0.00     51448.00          0      51448

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          73.43    0.00   25.06    0.50    0.00    1.00

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3568.00         0.00     49332.00          0      49332

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          72.32    0.00   26.43    0.25    0.00    1.00

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3589.00         0.00     49972.00          0      49972




