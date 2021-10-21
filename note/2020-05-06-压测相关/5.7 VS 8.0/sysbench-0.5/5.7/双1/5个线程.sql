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


purge binary logs to 'mysql-bin.000176';  



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
2 rows in set (0.01 sec)

mysql> show global variables like '%time_zone%';
+------------------+--------+
| Variable_name    | Value  |
+------------------+--------+
| system_time_zone | CST    |
| time_zone        | SYSTEM |
+------------------+--------+
2 rows in set (0.01 sec)



purge binary logs to 'mysql-bin.000084';  


./sysbench --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=5 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_5_11.log &

[coding001@voice ~]$ tail -f /home/coding001/log/sysbench_oltpX_5_11.log
Number of threads: 5
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 5, tps: 315.60, reads: 4423.26, writes: 1262.79, response time: 47.15ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 5, tps: 290.40, reads: 4067.69, writes: 1163.20, response time: 49.73ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 5, tps: 316.80, reads: 4434.70, writes: 1266.00, response time: 42.90ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 5, tps: 339.80, reads: 4755.44, writes: 1358.78, response time: 39.21ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 5, tps: 339.10, reads: 4749.26, writes: 1357.62, response time: 34.34ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 5, tps: 345.70, reads: 4839.20, writes: 1382.80, response time: 35.58ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 5, tps: 346.70, reads: 4853.10, writes: 1385.90, response time: 35.89ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 5, tps: 329.60, reads: 4612.70, writes: 1318.20, response time: 39.51ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 5, tps: 328.06, reads: 4593.46, writes: 1311.75, response time: 38.95ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 5, tps: 318.64, reads: 4461.52, writes: 1275.35, response time: 40.61ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 5, tps: 312.90, reads: 4381.38, writes: 1251.79, response time: 42.29ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 5, tps: 318.08, reads: 4453.99, writes: 1272.11, response time: 44.75ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 5, tps: 323.02, reads: 4522.54, writes: 1292.40, response time: 40.73ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 5, tps: 308.89, reads: 4323.12, writes: 1235.25, response time: 42.79ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 5, tps: 307.80, reads: 4309.68, writes: 1231.19, response time: 43.10ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 5, tps: 298.89, reads: 4184.29, writes: 1195.57, response time: 44.54ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 5, tps: 231.49, reads: 3241.23, writes: 925.55, response time: 62.39ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 5, tps: 312.44, reads: 4375.04, writes: 1250.25, response time: 44.75ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 5, tps: 331.99, reads: 4647.24, writes: 1327.75, response time: 38.18ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 5, tps: 318.21, reads: 4454.27, writes: 1272.95, response time: 40.25ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 5, tps: 321.48, reads: 4501.01, writes: 1285.92, response time: 39.78ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 5, tps: 329.81, reads: 4616.88, writes: 1319.35, response time: 41.30ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 5, tps: 324.31, reads: 4541.11, writes: 1297.53, response time: 38.93ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 5, tps: 333.70, reads: 4670.99, writes: 1334.00, response time: 37.34ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 5, tps: 324.90, reads: 4548.81, writes: 1300.40, response time: 40.72ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 5, tps: 323.70, reads: 4531.64, writes: 1294.58, response time: 40.64ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 5, tps: 332.47, reads: 4655.83, writes: 1329.99, response time: 39.55ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 5, tps: 338.93, reads: 4743.89, writes: 1355.31, response time: 37.51ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 5, tps: 334.50, reads: 4683.40, writes: 1338.90, response time: 39.68ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 5, tps: 325.49, reads: 4556.92, writes: 1300.98, response time: 37.42ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 5, tps: 341.01, reads: 4772.78, writes: 1364.22, response time: 38.26ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 5, tps: 330.60, reads: 4629.15, writes: 1322.32, response time: 37.43ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 5, tps: 324.20, reads: 4539.29, writes: 1297.30, response time: 39.93ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 5, tps: 333.70, reads: 4671.81, writes: 1335.10, response time: 39.14ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 5, tps: 338.00, reads: 4731.69, writes: 1351.10, response time: 38.01ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 5, tps: 337.00, reads: 4718.40, writes: 1348.60, response time: 39.14ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 5, tps: 356.70, reads: 4993.52, writes: 1426.80, response time: 34.59ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 5, tps: 345.20, reads: 4833.20, writes: 1380.80, response time: 34.52ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 5, tps: 356.60, reads: 4991.40, writes: 1425.90, response time: 33.75ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 5, tps: 354.30, reads: 4959.70, writes: 1416.90, response time: 34.58ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 5, tps: 354.30, reads: 4960.78, writes: 1417.99, response time: 36.25ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 5, tps: 359.20, reads: 5028.01, writes: 1436.00, response time: 34.31ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 5, tps: 346.30, reads: 4847.79, writes: 1385.60, response time: 35.27ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 5, tps: 351.30, reads: 4920.92, writes: 1405.80, response time: 34.78ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 5, tps: 347.20, reads: 4857.75, writes: 1388.19, response time: 35.64ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 5, tps: 352.40, reads: 4935.42, writes: 1409.60, response time: 33.85ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 5, tps: 331.98, reads: 4647.61, writes: 1327.92, response time: 38.40ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 5, tps: 341.82, reads: 4785.18, writes: 1367.28, response time: 34.31ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 5, tps: 358.10, reads: 5014.03, writes: 1432.41, response time: 34.06ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 5, tps: 352.10, reads: 4929.61, writes: 1409.20, response time: 33.84ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 5, tps: 363.20, reads: 5083.98, writes: 1451.79, response time: 32.14ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 5, tps: 366.70, reads: 5130.89, writes: 1466.20, response time: 32.75ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 5, tps: 342.20, reads: 4794.25, writes: 1369.59, response time: 36.11ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 5, tps: 339.31, reads: 4750.17, writes: 1357.22, response time: 38.09ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 5, tps: 347.30, reads: 4862.31, writes: 1389.60, response time: 34.21ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 5, tps: 350.90, reads: 4912.60, writes: 1403.60, response time: 34.65ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 5, tps: 362.00, reads: 5065.59, writes: 1447.00, response time: 32.68ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 5, tps: 353.20, reads: 4947.00, writes: 1413.40, response time: 34.21ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 5, tps: 352.30, reads: 4932.98, writes: 1409.60, response time: 35.13ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 5, tps: 362.50, reads: 5074.02, writes: 1449.30, response time: 33.66ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 5, tps: 352.20, reads: 4930.87, writes: 1409.49, response time: 32.97ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 5, tps: 356.90, reads: 4994.90, writes: 1426.80, response time: 35.48ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 5, tps: 356.48, reads: 4991.89, writes: 1426.21, response time: 34.25ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 5, tps: 345.02, reads: 4831.39, writes: 1380.48, response time: 36.36ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 5, tps: 334.70, reads: 4684.93, writes: 1338.51, response time: 36.95ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 5, tps: 291.60, reads: 4081.39, writes: 1166.00, response time: 44.49ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 5, tps: 370.70, reads: 5191.29, writes: 1483.20, response time: 31.46ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 5, tps: 347.30, reads: 4860.70, writes: 1388.80, response time: 34.61ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 5, tps: 354.60, reads: 4964.47, writes: 1418.19, response time: 34.50ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 5, tps: 355.60, reads: 4979.45, writes: 1423.31, response time: 33.13ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 5, tps: 339.40, reads: 4752.11, writes: 1357.30, response time: 35.95ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 5, tps: 353.30, reads: 4945.99, writes: 1412.90, response time: 34.00ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 5, tps: 357.70, reads: 5006.17, writes: 1430.49, response time: 33.29ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 5, tps: 357.80, reads: 5011.53, writes: 1432.21, response time: 33.33ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 5, tps: 357.70, reads: 5007.16, writes: 1430.69, response time: 33.69ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 5, tps: 347.10, reads: 4859.83, writes: 1388.11, response time: 34.64ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 5, tps: 329.60, reads: 4613.22, writes: 1318.41, response time: 37.18ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 5, tps: 350.88, reads: 4912.08, writes: 1403.31, response time: 34.79ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 5, tps: 353.12, reads: 4944.12, writes: 1412.69, response time: 34.07ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 5, tps: 349.17, reads: 4889.74, writes: 1396.70, response time: 35.30ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 5, tps: 348.43, reads: 4877.56, writes: 1393.70, response time: 34.86ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 5, tps: 356.30, reads: 4988.87, writes: 1425.59, response time: 33.32ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 5, tps: 348.00, reads: 4870.43, writes: 1391.81, response time: 34.10ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 5, tps: 342.20, reads: 4792.18, writes: 1369.00, response time: 36.05ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 5, tps: 358.20, reads: 5014.32, writes: 1432.81, response time: 32.66ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 5, tps: 350.60, reads: 4905.39, writes: 1401.20, response time: 34.05ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 5, tps: 374.50, reads: 5245.06, writes: 1497.99, response time: 30.85ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 5, tps: 376.40, reads: 5268.64, writes: 1506.41, response time: 30.82ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 5, tps: 365.00, reads: 5112.30, writes: 1460.00, response time: 33.19ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 5, tps: 359.90, reads: 5036.91, writes: 1439.50, response time: 31.95ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 5, tps: 346.80, reads: 4855.70, writes: 1387.30, response time: 33.64ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 5, tps: 357.20, reads: 5000.94, writes: 1429.18, response time: 33.79ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 5, tps: 348.50, reads: 4879.59, writes: 1394.20, response time: 34.78ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 5, tps: 365.70, reads: 5119.90, writes: 1462.60, response time: 32.04ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 5, tps: 356.60, reads: 4992.55, writes: 1426.42, response time: 33.15ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 5, tps: 333.70, reads: 4669.80, writes: 1334.40, response time: 36.99ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 5, tps: 349.30, reads: 4890.71, writes: 1397.20, response time: 35.29ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 5, tps: 359.40, reads: 5028.66, writes: 1436.79, response time: 32.91ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 5, tps: 361.90, reads: 5071.77, writes: 1449.19, response time: 32.95ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 5, tps: 355.20, reads: 4971.54, writes: 1420.01, response time: 33.96ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 5, tps: 348.00, reads: 4873.22, writes: 1392.80, response time: 33.98ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 5, tps: 368.70, reads: 5161.30, writes: 1474.30, response time: 31.65ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 5, tps: 368.50, reads: 5157.60, writes: 1474.10, response time: 31.48ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 5, tps: 361.60, reads: 5062.19, writes: 1445.60, response time: 32.48ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 5, tps: 354.80, reads: 4967.71, writes: 1419.60, response time: 33.67ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 5, tps: 355.40, reads: 4975.61, writes: 1421.60, response time: 33.70ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 5, tps: 347.60, reads: 4864.18, writes: 1389.60, response time: 34.68ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 5, tps: 345.10, reads: 4834.72, writes: 1381.50, response time: 36.25ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 5, tps: 365.90, reads: 5121.58, writes: 1463.70, response time: 31.52ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 5, tps: 370.30, reads: 5184.71, writes: 1481.20, response time: 31.13ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 5, tps: 370.10, reads: 5182.11, writes: 1480.40, response time: 31.35ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 5, tps: 366.60, reads: 5131.59, writes: 1466.40, response time: 32.98ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 5, tps: 364.70, reads: 5105.50, writes: 1458.40, response time: 32.78ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 5, tps: 272.10, reads: 3808.68, writes: 1087.99, response time: 48.04ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 5, tps: 270.80, reads: 3791.48, writes: 1083.00, response time: 44.06ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 5, tps: 353.48, reads: 4948.18, writes: 1414.11, response time: 33.00ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 5, tps: 371.83, reads: 5205.59, writes: 1486.91, response time: 32.56ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 5, tps: 361.00, reads: 5052.38, writes: 1444.10, response time: 32.80ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 5, tps: 359.90, reads: 5042.07, writes: 1440.69, response time: 31.82ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 5, tps: 366.30, reads: 5126.04, writes: 1464.41, response time: 32.32ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 5, tps: 365.60, reads: 5120.81, writes: 1463.40, response time: 33.55ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 5, tps: 373.00, reads: 5220.98, writes: 1491.69, response time: 31.90ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 5, tps: 357.90, reads: 5010.52, writes: 1431.81, response time: 33.21ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 5, tps: 366.50, reads: 5131.59, writes: 1466.30, response time: 33.23ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 5, tps: 368.50, reads: 5158.30, writes: 1472.90, response time: 32.36ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 5, tps: 367.19, reads: 5141.29, writes: 1468.87, response time: 32.29ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 5, tps: 361.70, reads: 5063.80, writes: 1447.20, response time: 34.29ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 5, tps: 337.91, reads: 4731.41, writes: 1351.43, response time: 35.24ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 5, tps: 315.90, reads: 4421.88, writes: 1263.99, response time: 40.33ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 5, tps: 345.30, reads: 4832.74, writes: 1380.38, response time: 35.26ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 5, tps: 354.10, reads: 4957.05, writes: 1416.61, response time: 35.24ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 5, tps: 367.30, reads: 5143.53, writes: 1469.41, response time: 32.04ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 5, tps: 365.39, reads: 5116.18, writes: 1461.56, response time: 32.90ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 5, tps: 360.61, reads: 5047.51, writes: 1442.83, response time: 33.05ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 5, tps: 345.50, reads: 4836.70, writes: 1382.00, response time: 35.67ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 5, tps: 351.20, reads: 4918.51, writes: 1404.70, response time: 33.84ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 5, tps: 361.80, reads: 5065.10, writes: 1447.40, response time: 33.37ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 5, tps: 353.40, reads: 4946.71, writes: 1413.50, response time: 33.73ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 5, tps: 367.80, reads: 5148.81, writes: 1471.20, response time: 32.64ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 5, tps: 363.60, reads: 5091.65, writes: 1454.78, response time: 33.34ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 5, tps: 357.50, reads: 5003.74, writes: 1429.61, response time: 32.91ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 5, tps: 354.10, reads: 4958.71, writes: 1416.70, response time: 33.60ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 5, tps: 355.80, reads: 4979.19, writes: 1422.10, response time: 34.43ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 5, tps: 358.50, reads: 5019.91, writes: 1434.40, response time: 32.71ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 5, tps: 362.80, reads: 5080.38, writes: 1451.59, response time: 33.43ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 5, tps: 359.10, reads: 5026.32, writes: 1436.41, response time: 33.12ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 5, tps: 373.40, reads: 5227.59, writes: 1494.00, response time: 31.52ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 5, tps: 369.60, reads: 5175.76, writes: 1478.29, response time: 32.19ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 5, tps: 356.80, reads: 4992.82, writes: 1426.81, response time: 33.91ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 5, tps: 362.90, reads: 5082.72, writes: 1451.71, response time: 32.17ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 5, tps: 362.80, reads: 5077.40, writes: 1450.60, response time: 33.00ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 5, tps: 358.90, reads: 5025.60, writes: 1435.80, response time: 33.20ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 5, tps: 362.20, reads: 5070.52, writes: 1449.01, response time: 33.80ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 5, tps: 364.50, reads: 5101.38, writes: 1457.40, response time: 33.09ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 5, tps: 362.30, reads: 5072.81, writes: 1449.40, response time: 33.90ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 5, tps: 357.20, reads: 5001.40, writes: 1429.00, response time: 33.62ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 5, tps: 374.50, reads: 5243.10, writes: 1497.60, response time: 31.54ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 5, tps: 368.20, reads: 5155.60, writes: 1473.60, response time: 31.64ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 5, tps: 364.10, reads: 5097.18, writes: 1456.10, response time: 31.90ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 5, tps: 343.00, reads: 4801.84, writes: 1371.48, response time: 35.12ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 5, tps: 369.80, reads: 5175.57, writes: 1479.22, response time: 32.61ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 5, tps: 378.90, reads: 5305.21, writes: 1515.20, response time: 30.21ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 5, tps: 357.60, reads: 5003.67, writes: 1430.39, response time: 32.46ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 5, tps: 355.80, reads: 4984.82, writes: 1424.80, response time: 32.89ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 5, tps: 365.80, reads: 5120.82, writes: 1462.81, response time: 32.26ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 5, tps: 353.00, reads: 4941.05, writes: 1411.19, response time: 34.74ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 5, tps: 353.40, reads: 4948.54, writes: 1414.01, response time: 34.94ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 5, tps: 350.00, reads: 4901.00, writes: 1400.00, response time: 34.83ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 5, tps: 351.00, reads: 4912.26, writes: 1403.89, response time: 33.75ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 5, tps: 360.50, reads: 5048.04, writes: 1442.11, response time: 34.07ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 5, tps: 372.00, reads: 5207.40, writes: 1488.00, response time: 32.04ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 5, tps: 380.60, reads: 5329.50, writes: 1522.40, response time: 30.70ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 5, tps: 371.69, reads: 5203.54, writes: 1487.05, response time: 31.53ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 5, tps: 357.51, reads: 5004.34, writes: 1429.74, response time: 32.64ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 5, tps: 367.80, reads: 5150.81, writes: 1471.60, response time: 32.41ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 5, tps: 359.20, reads: 5027.89, writes: 1436.80, response time: 32.86ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 5, tps: 353.70, reads: 4950.21, writes: 1414.30, response time: 33.74ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 5, tps: 354.40, reads: 4962.99, writes: 1417.40, response time: 32.89ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 5, tps: 358.20, reads: 5014.80, writes: 1433.50, response time: 33.69ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 5, tps: 364.10, reads: 5097.29, writes: 1456.20, response time: 31.93ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            8792882
        write:                           2512252
        other:                           1256126
        total:                           12561260
    transactions:                        628063 (348.92 per sec.)
    read/write requests:                 11305134 (6280.57 per sec.)
    other operations:                    1256126 (697.84 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0176s
    total number of events:              628063
    total time taken by event execution: 8997.2724s
    response time:
         min:                                  7.40ms
         avg:                                 14.33ms
         max:                                121.64ms
         approx.  99 percentile:              35.39ms

Threads fairness:
    events (avg/stddev):           125612.6000/41.26
    execution time (avg/stddev):   1799.4545/0.01


[root@voice mysql]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    2.10    4.72     0.14     0.23   111.28     0.07   10.70   23.97    4.80   0.64   0.44

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1359.00     0.00    27.11    40.86     1.42    1.05    0.00    1.05   0.57  77.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 1497.00     0.00    27.27    37.31     1.50    1.00    0.00    1.00   0.52  78.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1564.00     0.00    28.12    36.82     1.24    0.80    0.00    0.80   0.46  71.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1550.00     0.00    28.11    37.14     1.22    0.79    0.00    0.79   0.46  71.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1606.00     0.00    28.24    36.01     1.22    0.76    0.00    0.76   0.44  70.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1615.00     0.00    28.04    35.56     1.30    0.81    0.00    0.81   0.45  72.00

^C
[root@voice mysql]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.53    0.00    0.67    0.18    0.00   98.62

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               6.82       144.30       235.24 1185606570 1932788296

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          47.68    0.00   22.16    7.22    0.00   22.94

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1569.00       252.00     28092.00        252      28092

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          48.84    0.00   21.08    6.68    0.00   23.39

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1617.00         0.00     28716.00          0      28716

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          46.91    0.00   21.91    7.22    0.00   23.97

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1554.00         0.00     28040.00          0      28040

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          47.44    0.00   21.28    6.92    0.00   24.36

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1572.00         0.00     28356.00          0      28356


[root@voice mysql]# top
top - 17:21:02 up 95 days,  2:19,  4 users,  load average: 3.41, 3.47, 2.78
Tasks: 122 total,   1 running, 121 sleeping,   0 stopped,   0 zombie
%Cpu0  : 48.3 us, 18.2 sy,  0.0 ni, 19.9 id,  5.5 wa,  0.0 hi,  8.2 si,  0.0 st
%Cpu1  : 48.1 us, 16.6 sy,  0.0 ni, 24.7 id,  6.4 wa,  0.0 hi,  4.1 si,  0.0 st
%Cpu2  : 49.3 us, 17.5 sy,  0.0 ni, 21.6 id,  7.9 wa,  0.0 hi,  3.8 si,  0.0 st
%Cpu3  : 47.5 us, 17.3 sy,  0.0 ni, 24.7 id,  7.5 wa,  0.0 hi,  3.1 si,  0.0 st
KiB Mem : 16266300 total,   170772 free, 10046624 used,  6048904 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5118980 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   9.0g   4396 S 228.2 58.2 622:49.71 mysqld                                                                                                                                                                    
  574 coding0+  20   0  363692   4952   1948 S  52.5  0.0   4:09.13 sysbench   









mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-19 17:21:21 0x7fc4c816b700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 32 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 19433 srv_active, 0 srv_shutdown, 63031 srv_idle
srv_master_thread log flush and writes: 82464
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 1076743
OS WAIT ARRAY INFO: signal count 720501
RW-shared spins 0, rounds 389377, OS waits 77038
RW-excl spins 0, rounds 2466067, OS waits 66363
RW-sx spins 33444, rounds 908603, OS waits 17139
Spin rounds per wait: 389377.00 RW-shared, 2466067.00 RW-excl, 27.17 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 44008348
Purge done for trx's n:o < 44008340 undo n:o < 0 state: running but idle
History list length 4
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421967708637920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421967708638832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 44008347, ACTIVE 0 sec
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 95, OS thread handle 140483146168064, query id 101543388 192.168.1.12 sysbench
Trx read view will not see trx with id >= 44008344, sees < 44008344
---TRANSACTION 44008346, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 97, OS thread handle 140483147519744, query id 101543377 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 44008344, sees < 44008344
---TRANSACTION 44008345, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 94, OS thread handle 140483033736960, query id 101543389 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 44008340, sees < 44008335
---TRANSACTION 44008344, ACTIVE (PREPARED) 0 sec
4 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 93, OS thread handle 140483032925952, query id 101543363 192.168.1.12 sysbench starting
COMMIT
Trx read view will not see trx with id >= 44008341, sees < 44008336
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
2764408 OS file reads, 21929235 OS file writes, 2594751 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 988.13 writes/s, 391.18 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 162252 merges
merged operations:
 insert 81305, delete mark 140992, delete 44934
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365241, node heap has 5709 buffer(s)
Hash table size 2365241, node heap has 5697 buffer(s)
Hash table size 2365241, node heap has 2846 buffer(s)
Hash table size 2365241, node heap has 5718 buffer(s)
Hash table size 2365241, node heap has 5699 buffer(s)
Hash table size 2365241, node heap has 5693 buffer(s)
Hash table size 2365241, node heap has 5698 buffer(s)
Hash table size 2365241, node heap has 5710 buffer(s)
6391.83 hash searches/s, 5984.34 non-hash searches/s
---
LOG
---
Log sequence number 344136216781
Log flushed up to   344136212798
Pages flushed up to 343845830311
Last checkpoint at  343840019770
1 pending log flushes, 0 pending chkp writes
4943726 log i/o's done, 299.59 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 215408
Buffer pool size   524224
Free buffers       2035
Database pages     479419
Old database pages 176932
Modified db pages  160059
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 26100013, not young 9189217
1688.07 youngs/s, 0.00 non-youngs/s
Pages read 2758818, created 5036120, written 16418070
0.00 reads/s, 0.81 creates/s, 675.70 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 28 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 479419, unzip_LRU len: 0
I/O sum[69936]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1017
Database pages     239721
Old database pages 88470
Modified db pages  80212
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 13050585, not young 4631492
844.19 youngs/s, 0.00 non-youngs/s
Pages read 1381867, created 2518145, written 8199425
0.00 reads/s, 0.28 creates/s, 337.86 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 28 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239721, unzip_LRU len: 0
I/O sum[34968]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       1018
Database pages     239698
Old database pages 88462
Modified db pages  79847
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 13049428, not young 4557725
843.88 youngs/s, 0.00 non-youngs/s
Pages read 1376951, created 2517975, written 8218645
0.00 reads/s, 0.53 creates/s, 337.83 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 27 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239698, unzip_LRU len: 0
I/O sum[34968]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
5 read views open inside InnoDB
Process ID=6404, Main thread ID=140483397408512, state: sleeping
Number of rows inserted 345072993, updated 10145646, deleted 5072861, read 2149260810
353.96 inserts/s, 708.01 updates/s, 353.96 deletes/s, 147618.07 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.03 sec)

ERROR: 
No query specified



  