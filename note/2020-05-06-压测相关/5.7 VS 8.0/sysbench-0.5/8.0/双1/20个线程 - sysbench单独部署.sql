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


./sysbench --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench --mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 --oltp-table-size=2000000 --rand-init=on prepare &


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
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=20 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_20_11_vision8.log &
 
-bash-4.2$ tail -f /home/coding001/log/sysbench_oltpX_20_11_vision8.log
Number of threads: 20
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 20, tps: 432.40, reads: 6074.25, writes: 1731.38, response time: 66.80ms (99%), errors: 0.00, reconnects:  0.00


[  20s] threads: 20, tps: 480.00, reads: 6718.30, writes: 1921.00, response time: 58.64ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 20, tps: 495.30, reads: 6934.60, writes: 1980.80, response time: 56.37ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 20, tps: 506.90, reads: 7099.21, writes: 2028.20, response time: 54.69ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 20, tps: 510.60, reads: 7146.97, writes: 2040.89, response time: 54.24ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 20, tps: 510.70, reads: 7150.52, writes: 2043.80, response time: 54.71ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 20, tps: 511.40, reads: 7158.21, writes: 2047.20, response time: 54.60ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 20, tps: 513.20, reads: 7188.58, writes: 2053.19, response time: 54.43ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 20, tps: 509.80, reads: 7136.11, writes: 2037.20, response time: 54.56ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 20, tps: 514.30, reads: 7199.60, writes: 2057.10, response time: 53.26ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 20, tps: 517.20, reads: 7235.50, writes: 2067.90, response time: 52.95ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 20, tps: 516.90, reads: 7236.40, writes: 2067.70, response time: 53.14ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 20, tps: 517.30, reads: 7247.70, writes: 2070.40, response time: 52.28ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 20, tps: 506.20, reads: 7084.19, writes: 2024.50, response time: 53.18ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 20, tps: 495.50, reads: 6936.91, writes: 1981.20, response time: 57.03ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 20, tps: 515.50, reads: 7221.00, writes: 2063.70, response time: 52.95ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 20, tps: 518.80, reads: 7264.31, writes: 2075.40, response time: 53.24ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 20, tps: 522.20, reads: 7297.20, writes: 2085.60, response time: 51.42ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 20, tps: 520.60, reads: 7299.80, writes: 2085.30, response time: 51.01ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 20, tps: 528.00, reads: 7392.50, writes: 2111.40, response time: 51.09ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 20, tps: 442.60, reads: 6201.20, writes: 1772.20, response time: 69.60ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 20, tps: 419.70, reads: 5869.00, writes: 1675.40, response time: 70.84ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 20, tps: 418.00, reads: 5857.10, writes: 1674.40, response time: 69.41ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 20, tps: 430.20, reads: 6014.10, writes: 1720.20, response time: 69.72ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 20, tps: 430.90, reads: 6038.81, writes: 1724.50, response time: 68.60ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 20, tps: 437.59, reads: 6117.53, writes: 1747.35, response time: 68.07ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 20, tps: 399.41, reads: 5602.25, writes: 1600.94, response time: 70.99ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 20, tps: 445.39, reads: 6235.30, writes: 1779.37, response time: 64.68ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 20, tps: 427.11, reads: 5978.69, writes: 1712.93, response time: 67.00ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 20, tps: 435.10, reads: 6094.00, writes: 1741.50, response time: 66.58ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 20, tps: 424.70, reads: 5934.90, writes: 1694.10, response time: 66.78ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 20, tps: 458.70, reads: 6434.00, writes: 1838.60, response time: 65.14ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 20, tps: 414.40, reads: 5793.60, writes: 1651.40, response time: 68.93ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 20, tps: 420.30, reads: 5886.20, writes: 1686.20, response time: 67.99ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 20, tps: 421.10, reads: 5886.61, writes: 1679.40, response time: 67.54ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 20, tps: 400.80, reads: 5607.30, writes: 1603.60, response time: 69.47ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 20, tps: 410.40, reads: 5761.01, writes: 1645.20, response time: 70.04ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 20, tps: 441.30, reads: 6178.69, writes: 1765.60, response time: 67.18ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 20, tps: 413.60, reads: 5791.11, writes: 1651.00, response time: 103.66ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 20, tps: 433.50, reads: 6062.50, writes: 1735.10, response time: 68.46ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 20, tps: 421.60, reads: 5910.40, writes: 1691.50, response time: 68.13ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 20, tps: 435.10, reads: 6091.40, writes: 1739.10, response time: 65.91ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 20, tps: 425.10, reads: 5951.20, writes: 1701.70, response time: 68.19ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 20, tps: 412.70, reads: 5778.20, writes: 1650.30, response time: 67.48ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 20, tps: 476.10, reads: 6664.80, writes: 1904.90, response time: 65.12ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 20, tps: 435.30, reads: 6092.11, writes: 1735.90, response time: 66.32ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 20, tps: 423.40, reads: 5919.00, writes: 1694.90, response time: 68.48ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 20, tps: 440.40, reads: 6174.79, writes: 1764.10, response time: 67.06ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 20, tps: 423.10, reads: 5920.70, writes: 1692.30, response time: 67.32ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 20, tps: 441.70, reads: 6189.00, writes: 1768.80, response time: 67.08ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 20, tps: 437.40, reads: 6123.10, writes: 1749.20, response time: 68.44ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 20, tps: 406.20, reads: 5684.80, writes: 1620.80, response time: 66.86ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 20, tps: 435.60, reads: 6098.39, writes: 1743.40, response time: 67.46ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 20, tps: 416.10, reads: 5822.01, writes: 1663.80, response time: 67.63ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 20, tps: 466.40, reads: 6531.90, writes: 1865.10, response time: 66.84ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 20, tps: 467.80, reads: 6538.59, writes: 1871.30, response time: 67.26ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 20, tps: 458.50, reads: 6432.00, writes: 1837.70, response time: 68.19ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 20, tps: 456.19, reads: 6376.96, writes: 1817.46, response time: 67.02ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 20, tps: 448.91, reads: 6290.44, writes: 1800.04, response time: 66.78ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 20, tps: 438.90, reads: 6146.00, writes: 1753.60, response time: 64.81ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 20, tps: 438.90, reads: 6148.38, writes: 1761.19, response time: 66.52ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 20, tps: 422.00, reads: 5897.61, writes: 1684.00, response time: 69.20ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 20, tps: 412.90, reads: 5766.79, writes: 1648.00, response time: 67.63ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 20, tps: 402.20, reads: 5653.72, writes: 1616.00, response time: 67.44ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 20, tps: 421.50, reads: 5892.80, writes: 1680.50, response time: 67.91ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 20, tps: 443.10, reads: 6211.00, writes: 1775.90, response time: 66.44ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 20, tps: 451.60, reads: 6322.10, writes: 1805.50, response time: 65.99ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 20, tps: 452.20, reads: 6331.60, writes: 1811.70, response time: 65.26ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 20, tps: 460.60, reads: 6439.01, writes: 1838.60, response time: 66.20ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 20, tps: 441.20, reads: 6173.39, writes: 1764.60, response time: 67.63ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 20, tps: 439.70, reads: 6166.50, writes: 1759.40, response time: 66.46ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 20, tps: 444.50, reads: 6223.30, writes: 1780.10, response time: 67.95ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 20, tps: 452.50, reads: 6334.80, writes: 1806.10, response time: 66.08ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 20, tps: 442.80, reads: 6201.20, writes: 1774.70, response time: 66.22ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 20, tps: 428.60, reads: 5996.30, writes: 1711.70, response time: 70.37ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 20, tps: 431.50, reads: 6040.60, writes: 1727.50, response time: 66.82ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 20, tps: 434.80, reads: 6082.40, writes: 1737.80, response time: 67.54ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 20, tps: 433.50, reads: 6078.90, writes: 1737.60, response time: 66.72ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 20, tps: 429.60, reads: 6013.70, writes: 1717.80, response time: 67.26ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 20, tps: 427.40, reads: 5971.50, writes: 1705.40, response time: 68.85ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 20, tps: 401.70, reads: 5616.70, writes: 1605.60, response time: 69.10ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 20, tps: 412.30, reads: 5791.59, writes: 1653.50, response time: 67.38ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 20, tps: 434.50, reads: 6079.60, writes: 1738.00, response time: 67.10ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 20, tps: 466.60, reads: 6534.70, writes: 1868.40, response time: 67.06ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 20, tps: 437.30, reads: 6124.60, writes: 1749.10, response time: 67.16ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 20, tps: 440.50, reads: 6162.50, writes: 1758.10, response time: 66.74ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 20, tps: 439.80, reads: 6153.10, writes: 1761.20, response time: 66.56ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 20, tps: 447.70, reads: 6267.79, writes: 1786.20, response time: 65.42ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 20, tps: 409.70, reads: 5738.19, writes: 1640.00, response time: 67.63ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 20, tps: 415.30, reads: 5812.82, writes: 1662.60, response time: 67.04ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 20, tps: 389.20, reads: 5456.20, writes: 1561.20, response time: 83.86ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 20, tps: 455.79, reads: 6378.11, writes: 1819.57, response time: 67.58ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 20, tps: 403.11, reads: 5645.18, writes: 1611.72, response time: 69.53ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 20, tps: 399.40, reads: 5589.10, writes: 1598.70, response time: 68.46ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 20, tps: 415.40, reads: 5818.39, writes: 1664.40, response time: 66.04ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 20, tps: 431.80, reads: 6042.02, writes: 1722.81, response time: 66.34ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 20, tps: 459.50, reads: 6432.20, writes: 1839.60, response time: 65.61ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 20, tps: 452.90, reads: 6345.40, writes: 1812.80, response time: 64.42ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 20, tps: 420.10, reads: 5862.60, writes: 1676.80, response time: 68.28ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 20, tps: 430.00, reads: 6032.59, writes: 1722.80, response time: 66.98ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 20, tps: 438.70, reads: 6144.61, writes: 1752.40, response time: 70.01ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 20, tps: 427.90, reads: 5976.90, writes: 1709.60, response time: 67.69ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 20, tps: 443.60, reads: 6218.60, writes: 1777.10, response time: 67.38ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 20, tps: 443.40, reads: 6212.80, writes: 1775.10, response time: 67.73ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 20, tps: 431.30, reads: 6029.10, writes: 1720.70, response time: 68.52ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 20, tps: 433.60, reads: 6078.90, writes: 1738.50, response time: 65.51ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 20, tps: 428.80, reads: 6006.39, writes: 1714.80, response time: 65.79ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 20, tps: 415.70, reads: 5820.91, writes: 1666.60, response time: 67.00ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 20, tps: 429.30, reads: 6009.89, writes: 1717.20, response time: 65.36ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 20, tps: 431.50, reads: 6027.21, writes: 1719.60, response time: 66.86ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 20, tps: 433.30, reads: 6074.30, writes: 1734.40, response time: 67.14ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 20, tps: 324.20, reads: 4537.90, writes: 1296.00, response time: 162.03ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 20, tps: 474.30, reads: 6635.99, writes: 1898.00, response time: 65.10ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 20, tps: 474.50, reads: 6650.31, writes: 1897.60, response time: 66.28ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 20, tps: 459.40, reads: 6433.20, writes: 1842.40, response time: 66.36ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 20, tps: 436.00, reads: 6106.10, writes: 1744.80, response time: 67.20ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 20, tps: 426.20, reads: 5960.60, writes: 1698.40, response time: 69.83ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 20, tps: 434.60, reads: 6074.00, writes: 1738.00, response time: 66.90ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 20, tps: 433.50, reads: 6077.39, writes: 1737.30, response time: 65.97ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 20, tps: 436.70, reads: 6110.01, writes: 1744.30, response time: 66.64ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 20, tps: 438.10, reads: 6143.10, writes: 1757.40, response time: 66.52ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 20, tps: 451.00, reads: 6314.40, writes: 1801.40, response time: 66.68ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 20, tps: 446.30, reads: 6243.60, writes: 1786.30, response time: 65.61ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 20, tps: 421.10, reads: 5900.90, writes: 1685.30, response time: 66.50ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 20, tps: 414.70, reads: 5795.50, writes: 1654.60, response time: 66.56ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 20, tps: 412.00, reads: 5778.69, writes: 1653.80, response time: 67.22ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 20, tps: 422.10, reads: 5900.20, writes: 1684.00, response time: 67.24ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 20, tps: 427.40, reads: 5993.50, writes: 1714.00, response time: 68.19ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 20, tps: 452.30, reads: 6326.40, writes: 1806.00, response time: 66.76ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 20, tps: 443.80, reads: 6217.10, writes: 1773.70, response time: 66.40ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 20, tps: 460.70, reads: 6438.40, writes: 1840.50, response time: 66.52ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 20, tps: 468.00, reads: 6551.64, writes: 1871.88, response time: 65.77ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 20, tps: 480.70, reads: 6740.07, writes: 1924.82, response time: 64.12ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 20, tps: 457.20, reads: 6400.50, writes: 1829.50, response time: 66.50ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 20, tps: 431.20, reads: 6037.16, writes: 1723.99, response time: 75.00ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 20, tps: 440.20, reads: 6159.14, writes: 1762.51, response time: 67.28ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 20, tps: 432.70, reads: 6061.90, writes: 1733.50, response time: 66.58ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 20, tps: 423.80, reads: 5933.30, writes: 1694.80, response time: 67.83ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 20, tps: 429.79, reads: 6010.03, writes: 1712.85, response time: 66.66ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 20, tps: 422.61, reads: 5921.57, writes: 1695.55, response time: 67.40ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 20, tps: 421.00, reads: 5894.70, writes: 1682.90, response time: 67.99ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 20, tps: 438.40, reads: 6128.10, writes: 1752.00, response time: 66.06ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 20, tps: 431.90, reads: 6057.70, writes: 1731.00, response time: 66.34ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 20, tps: 427.90, reads: 5992.30, writes: 1713.30, response time: 66.76ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 20, tps: 417.50, reads: 5836.39, writes: 1666.30, response time: 67.24ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 20, tps: 408.50, reads: 5725.11, writes: 1634.00, response time: 66.66ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 20, tps: 413.90, reads: 5791.71, writes: 1656.30, response time: 70.25ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 20, tps: 437.70, reads: 6118.70, writes: 1748.50, response time: 66.84ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 20, tps: 450.20, reads: 6311.09, writes: 1803.10, response time: 66.04ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 20, tps: 420.30, reads: 5886.91, writes: 1681.90, response time: 66.44ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 20, tps: 437.90, reads: 6128.50, writes: 1749.40, response time: 66.06ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 20, tps: 436.60, reads: 6111.50, writes: 1746.50, response time: 66.88ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 20, tps: 430.90, reads: 6032.30, writes: 1725.10, response time: 67.46ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 20, tps: 431.70, reads: 6042.40, writes: 1725.70, response time: 67.10ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 20, tps: 427.30, reads: 5981.00, writes: 1708.80, response time: 68.50ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 20, tps: 428.10, reads: 5998.40, writes: 1711.00, response time: 66.46ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 20, tps: 444.70, reads: 6225.91, writes: 1778.40, response time: 67.24ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 20, tps: 432.40, reads: 6050.59, writes: 1731.30, response time: 68.67ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 20, tps: 432.60, reads: 6060.80, writes: 1730.50, response time: 69.06ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 20, tps: 415.90, reads: 5823.00, writes: 1663.80, response time: 67.67ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 20, tps: 437.30, reads: 6121.30, writes: 1747.70, response time: 68.07ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 20, tps: 437.00, reads: 6112.31, writes: 1748.40, response time: 66.52ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 20, tps: 460.70, reads: 6452.10, writes: 1843.60, response time: 65.26ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 20, tps: 433.00, reads: 6059.10, writes: 1732.00, response time: 67.04ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 20, tps: 416.50, reads: 5838.19, writes: 1668.70, response time: 67.56ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 20, tps: 452.40, reads: 6321.80, writes: 1803.80, response time: 63.43ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 20, tps: 501.50, reads: 7030.60, writes: 2008.70, response time: 62.39ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 20, tps: 497.20, reads: 6960.90, writes: 1988.70, response time: 66.42ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 20, tps: 501.70, reads: 7013.41, writes: 2006.20, response time: 62.58ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 20, tps: 489.30, reads: 6861.40, writes: 1958.10, response time: 63.26ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 20, tps: 460.30, reads: 6440.50, writes: 1840.60, response time: 65.06ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 20, tps: 440.50, reads: 6166.60, writes: 1761.40, response time: 65.20ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 20, tps: 440.70, reads: 6168.10, writes: 1761.80, response time: 65.85ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 20, tps: 447.40, reads: 6263.39, writes: 1791.60, response time: 67.58ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 20, tps: 458.50, reads: 6422.90, writes: 1833.80, response time: 68.11ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 20, tps: 481.30, reads: 6732.01, writes: 1923.40, response time: 64.83ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 20, tps: 475.00, reads: 6654.40, writes: 1900.30, response time: 67.14ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 20, tps: 457.10, reads: 6404.00, writes: 1832.00, response time: 65.53ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 20, tps: 454.60, reads: 6361.30, writes: 1817.30, response time: 64.64ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 20, tps: 445.00, reads: 6227.90, writes: 1779.40, response time: 67.06ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            11188016
        write:                           3196576
        other:                           1598288
        total:                           15982880
    transactions:                        799144 (443.96 per sec.)
    read/write requests:                 14384592 (7991.31 per sec.)
    other operations:                    1598288 (887.92 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0295s
    total number of events:              799144
    total time taken by event execution: 35999.0052s
    response time:
         min:                                 24.49ms
         avg:                                 45.05ms
         max:                                262.07ms
         approx.  99 percentile:              67.38ms

Threads fairness:
    events (avg/stddev):           39957.2000/1501.37
    execution time (avg/stddev):   1799.9503/0.01


[coding001@voice ~]$ top
top - 12:06:45 up 96 days, 21:05,  4 users,  load average: 9.58, 8.17, 6.49
Tasks: 121 total,   3 running, 118 sleeping,   0 stopped,   0 zombie
%Cpu0  : 54.3 us, 13.8 sy,  0.0 ni, 16.0 id,  5.7 wa,  0.0 hi, 10.3 si,  0.0 st
%Cpu1  : 59.5 us, 13.1 sy,  0.0 ni, 15.9 id,  5.9 wa,  0.0 hi,  5.5 si,  0.0 st
%Cpu2  : 52.8 us, 13.5 sy,  0.0 ni, 19.1 id, 11.5 wa,  0.0 hi,  3.1 si,  0.0 st
%Cpu3  : 59.7 us, 10.8 sy,  0.0 ni, 16.7 id,  4.5 wa,  0.0 hi,  8.3 si,  0.0 st
KiB Mem : 16266300 total,   211108 free, 11381964 used,  4673228 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  3775448 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
32578 mysql     20   0   11.2g   9.0g  10264 S 302.7 58.2 241:04.68 mysqld            


[coding001@voice ~]$ top
top - 12:06:13 up 96 days, 21:04,  4 users,  load average: 9.89, 8.09, 6.41
Tasks: 122 total,   3 running, 119 sleeping,   0 stopped,   0 zombie
%Cpu0  : 59.8 us, 22.9 sy,  0.0 ni,  0.7 id,  0.3 wa,  0.0 hi, 16.3 si,  0.0 st
%Cpu1  : 77.0 us, 15.0 sy,  0.0 ni,  1.7 id,  0.3 wa,  0.0 hi,  6.0 si,  0.0 st
%Cpu2  : 71.1 us, 21.1 sy,  0.0 ni,  1.3 id,  1.0 wa,  0.0 hi,  5.4 si,  0.0 st
%Cpu3  : 78.5 us, 13.4 sy,  0.0 ni,  1.0 id,  0.0 wa,  0.0 hi,  7.0 si,  0.0 st
KiB Mem : 16266300 total,   200860 free, 11379540 used,  4685900 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  3777484 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
32578 mysql     20   0   11.2g   9.0g  10264 S 380.2 58.2 239:23.10 mysqld        


[root@db-b sysbench]#  top
top - 11:54:43 up 850 days, 18:23,  2 users,  load average: 0.83, 0.62, 0.35
Tasks: 117 total,   1 running, 116 sleeping,   0 stopped,   0 zombie
%Cpu0  : 15.8 us,  5.1 sy,  0.0 ni, 78.8 id,  0.0 wa,  0.0 hi,  0.3 si,  0.0 st
%Cpu1  : 14.9 us,  5.9 sy,  0.0 ni, 78.1 id,  0.0 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu2  : 10.6 us,  3.1 sy,  0.0 ni, 86.0 id,  0.0 wa,  0.0 hi,  0.3 si,  0.0 st
%Cpu3  : 11.6 us,  4.8 sy,  0.0 ni, 82.5 id,  0.0 wa,  0.0 hi,  1.0 si,  0.0 st
KiB Mem : 16266528 total,   840604 free,  8434900 used,  6991024 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  6618676 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
  919 root      20   0 1347040   7296   2176 S  81.4  0.0   6:08.91 sysbench  
  


[coding001@voice lib]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.65    0.00    0.71    0.19    0.00   98.46

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              10.08       143.23       338.55 1198751566 2833556952

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          48.17    0.00   16.23    9.42    0.00   26.18

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2955.00         0.00     49196.00          0      49196

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          49.61    0.00   16.88   10.39    0.00   23.12

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2925.00         0.00     49120.00          0      49120

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          50.00    0.00   16.93    9.79    0.00   23.28

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2935.00         0.00     49192.00          0      49192

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          62.18    0.00   20.98    4.40    0.00   12.44

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2840.00         0.00     35728.00          0      35728

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          62.50    0.00   19.53    4.95    0.00   13.02

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3683.00         0.00     52184.00          0      52184

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          60.73    0.00   17.54    6.54    0.00   15.18

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3574.00         0.00     53012.00          0      53012

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          54.66    0.00   18.65    7.25    0.00   19.43

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3365.00         0.00     51208.00          0      51208

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          54.47    0.00   18.16    7.37    0.00   20.00

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3369.00         0.00     51428.00          0      51428

^C
[coding001@voice lib]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.09    8.00     0.14     0.33    95.54     0.08    8.24   23.71    4.21   0.54   0.55

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3082.00     0.00    48.36    32.13     6.69    2.17    0.00    2.17   0.31  95.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 3134.00     0.00    48.58    31.75     6.44    2.06    0.00    2.06   0.30  95.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3014.00     0.00    47.64    32.37     6.64    2.20    0.00    2.20   0.32  95.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3031.00     0.00    48.31    32.64     6.75    2.23    0.00    2.23   0.31  94.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3058.00     0.00    48.16    32.25     6.68    2.18    0.00    2.18   0.31  95.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3025.00     0.00    47.99    32.49     6.59    2.18    0.00    2.18   0.31  94.00





mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-21 12:02:44 140111434303232 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 17 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 5910 srv_active, 0 srv_shutdown, 57317 srv_idle
srv_master_thread log flush and writes: 0
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 16043
OS WAIT ARRAY INFO: signal count 46514
RW-shared spins 0, rounds 0, OS waits 0
RW-excl spins 0, rounds 0, OS waits 0
RW-sx spins 0, rounds 0, OS waits 0
Spin rounds per wait: 0.00 RW-shared, 0.00 RW-excl, 0.00 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 3753079
Purge done for trx's n:o < 3753030 undo n:o < 0 state: running
History list length 108
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421586588642520, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 421586588641712, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 421586588640096, not started
0 lock struct(s), heap size 1128, 0 row lock(s)
---TRANSACTION 3753078, ACTIVE 0 sec
3 lock struct(s), heap size 1128, 2 row lock(s), undo log entries 2
MySQL thread id 51, OS thread handle 140106266773248, query id 36265421 192.168.1.11 sysbench
Trx read view will not see trx with id >= 3753060, sees < 3753037
---TRANSACTION 3753077, ACTIVE 0 sec
3 lock struct(s), heap size 1128, 2 row lock(s), undo log entries 2
MySQL thread id 58, OS thread handle 140106266240768, query id 36265415 192.168.1.11 sysbench
Trx read view will not see trx with id >= 3753069, sees < 3753058
---TRANSACTION 3753076, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 55, OS thread handle 140111434835712, query id 36265418 192.168.1.11 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 3753060, sees < 3753037
---TRANSACTION 3753075, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 60, OS thread handle 140111432173312, query id 36265417 192.168.1.11 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 3753060, sees < 3753037
---TRANSACTION 3753074, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 62, OS thread handle 140111566685952, query id 36265403 192.168.1.11 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 3753060, sees < 3753037
---TRANSACTION 3753072, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 63, OS thread handle 140106268370688, query id 36265384 192.168.1.11 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 3753060, sees < 3753037
---TRANSACTION 3753071, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 54, OS thread handle 140111431108352, query id 36265333 192.168.1.11 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 3753060, sees < 3753037
---TRANSACTION 3753070, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1128, 3 row lock(s), undo log entries 4
MySQL thread id 56, OS thread handle 140106267305728, query id 36265331 192.168.1.11 sysbench waiting for handler commit
COMMIT
Trx read view will not see trx with id >= 3753060, sees < 3753037
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
I/O thread 13 state: complete io for buf page (write thread)
I/O thread 14 state: waiting for completed aio requests (write thread)
I/O thread 15 state: waiting for completed aio requests (write thread)
I/O thread 16 state: waiting for completed aio requests (write thread)
I/O thread 17 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 2, 0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 1; buffer pool: 27
113465 OS file reads, 17301397 OS file writes, 5614381 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 2558.97 writes/s, 1057.17 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 0, seg size 2, 21399 merges
merged operations:
 insert 0, delete mark 21428, delete 13
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2212699, node heap has 5887 buffer(s)
Hash table size 2212699, node heap has 5890 buffer(s)
Hash table size 2212699, node heap has 5886 buffer(s)
Hash table size 2212699, node heap has 5892 buffer(s)
Hash table size 2212699, node heap has 5893 buffer(s)
Hash table size 2212699, node heap has 2947 buffer(s)
Hash table size 2212699, node heap has 5890 buffer(s)
Hash table size 2212699, node heap has 5888 buffer(s)
8281.28 hash searches/s, 6181.11 non-hash searches/s
---
LOG
---
Log sequence number          27568195904
Log buffer assigned up to    27568195904
Log buffer completed up to   27568195904
Log written up to            27568195904
Log flushed up to            27568189440
Added dirty pages up to      27568195904
Pages flushed up to          27494442065
Last checkpoint at           27488650489
9394168 log i/o's done, 942.06 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8770551808
Dictionary memory allocated 590518
Buffer pool size   524240
Free buffers       8000
Database pages     472067
Old database pages 174219
Modified db pages  100884
Pending reads      0
Pending writes: LRU 0, flush list 22, single page 0
Pages made young 9903095, not young 209361
0.00 youngs/s, 0.00 non-youngs/s
Pages read 70849, created 887421, written 6972883
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 45 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 472067, unzip_LRU len: 0
I/O sum[138118]:cur[432], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262116
Free buffers       4000
Database pages     236032
Old database pages 87109
Modified db pages  50410
Pending reads      0
Pending writes: LRU 0, flush list 11, single page 0
Pages made young 4949942, not young 105875
0.00 youngs/s, 0.00 non-youngs/s
Pages read 35478, created 443883, written 3487477
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 46 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 236032, unzip_LRU len: 0
I/O sum[69059]:cur[216], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262124
Free buffers       4000
Database pages     236035
Old database pages 87110
Modified db pages  50474
Pending reads      0
Pending writes: LRU 0, flush list 11, single page 0
Pages made young 4953153, not young 103486
0.00 youngs/s, 0.00 non-youngs/s
Pages read 35371, created 443538, written 3485406
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 43 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 236035, unzip_LRU len: 0
I/O sum[69059]:cur[216], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
20 read views open inside InnoDB
Process ID=32578, Main thread ID=140101919622912 , state=sleeping
Number of rows inserted 61812113, updated 3624244, deleted 1812126, read 748396880
416.68 inserts/s, 833.07 updates/s, 416.56 deletes/s, 172177.64 reads/s
Number of system rows inserted 57004, updated 1853, deleted 56877, read 67145
9.41 inserts/s, 0.24 updates/s, 11.82 deletes/s, 12.35 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.01 sec)
  
  