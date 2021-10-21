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


purge binary logs to 'mysql-bin.000026';  



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
--mysql-password='1234Abc&' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_10_11_vision8.log &
 
 
-bash-4.2$ tail -f  /home/coding001/log/sysbench_oltpX_10_11_vision8.log
Number of threads: 10
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 10, tps: 276.70, reads: 3884.76, writes: 1107.79, response time: 54.63ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 10, tps: 307.70, reads: 4306.80, writes: 1230.20, response time: 41.81ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 10, tps: 319.10, reads: 4468.70, writes: 1276.80, response time: 38.87ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 10, tps: 322.10, reads: 4508.30, writes: 1288.60, response time: 39.11ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 10, tps: 325.80, reads: 4560.10, writes: 1302.60, response time: 37.98ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 10, tps: 322.30, reads: 4514.90, writes: 1291.00, response time: 39.11ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 10, tps: 329.50, reads: 4609.99, writes: 1317.80, response time: 38.06ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 10, tps: 326.90, reads: 4574.71, writes: 1305.90, response time: 37.41ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 10, tps: 333.70, reads: 4676.80, writes: 1336.00, response time: 36.39ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 10, tps: 333.50, reads: 4667.70, writes: 1333.70, response time: 36.46ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 10, tps: 332.50, reads: 4654.90, writes: 1329.80, response time: 36.63ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 10, tps: 337.40, reads: 4724.40, writes: 1349.60, response time: 35.72ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 10, tps: 334.50, reads: 4683.50, writes: 1339.90, response time: 36.15ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 10, tps: 336.70, reads: 4710.10, writes: 1344.40, response time: 35.63ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 10, tps: 338.90, reads: 4748.10, writes: 1356.80, response time: 35.57ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 10, tps: 338.80, reads: 4737.90, writes: 1353.90, response time: 36.07ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 10, tps: 337.70, reads: 4731.50, writes: 1351.50, response time: 35.28ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 10, tps: 340.70, reads: 4768.50, writes: 1362.40, response time: 34.90ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 10, tps: 335.90, reads: 4702.90, writes: 1343.70, response time: 39.02ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 10, tps: 338.80, reads: 4740.61, writes: 1354.40, response time: 35.19ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 10, tps: 339.40, reads: 4755.20, writes: 1359.10, response time: 35.28ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 10, tps: 339.10, reads: 4746.20, writes: 1356.10, response time: 34.92ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 10, tps: 340.00, reads: 4761.80, writes: 1359.50, response time: 34.83ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 10, tps: 341.40, reads: 4781.20, writes: 1367.30, response time: 34.53ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 10, tps: 339.40, reads: 4747.80, writes: 1356.40, response time: 35.41ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 10, tps: 342.10, reads: 4791.09, writes: 1367.60, response time: 34.34ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 10, tps: 342.60, reads: 4795.01, writes: 1371.50, response time: 34.41ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 10, tps: 343.20, reads: 4807.20, writes: 1373.20, response time: 34.68ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 10, tps: 344.70, reads: 4826.30, writes: 1378.30, response time: 33.84ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 10, tps: 335.30, reads: 4692.10, writes: 1340.60, response time: 35.18ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 10, tps: 327.60, reads: 4587.39, writes: 1311.50, response time: 39.69ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 10, tps: 338.80, reads: 4743.81, writes: 1355.30, response time: 35.08ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 10, tps: 342.60, reads: 4796.18, writes: 1369.00, response time: 36.15ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 10, tps: 346.00, reads: 4842.41, writes: 1384.40, response time: 33.92ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 10, tps: 347.00, reads: 4856.71, writes: 1387.40, response time: 33.58ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 10, tps: 348.30, reads: 4878.80, writes: 1393.40, response time: 33.53ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 10, tps: 347.10, reads: 4859.40, writes: 1389.20, response time: 34.23ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 10, tps: 348.10, reads: 4867.70, writes: 1391.40, response time: 33.91ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 10, tps: 343.80, reads: 4819.40, writes: 1375.90, response time: 33.96ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 10, tps: 348.10, reads: 4869.60, writes: 1392.40, response time: 33.77ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 10, tps: 345.80, reads: 4843.20, writes: 1382.70, response time: 33.86ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 10, tps: 347.20, reads: 4862.20, writes: 1389.40, response time: 33.89ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 10, tps: 347.20, reads: 4857.70, writes: 1388.70, response time: 33.85ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 10, tps: 336.90, reads: 4720.20, writes: 1349.20, response time: 46.64ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 10, tps: 332.20, reads: 4650.60, writes: 1326.50, response time: 47.19ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 10, tps: 328.40, reads: 4595.50, writes: 1314.00, response time: 49.59ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 10, tps: 330.40, reads: 4627.50, writes: 1323.00, response time: 46.07ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 10, tps: 329.50, reads: 4613.70, writes: 1316.90, response time: 48.97ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 10, tps: 330.80, reads: 4630.70, writes: 1323.10, response time: 49.09ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 10, tps: 325.60, reads: 4558.50, writes: 1302.50, response time: 49.24ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 10, tps: 327.60, reads: 4585.40, writes: 1311.00, response time: 49.12ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 10, tps: 328.20, reads: 4591.60, writes: 1311.90, response time: 48.48ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 10, tps: 325.90, reads: 4558.30, writes: 1303.00, response time: 48.30ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 10, tps: 341.90, reads: 4795.60, writes: 1369.70, response time: 44.13ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 10, tps: 332.30, reads: 4650.69, writes: 1329.00, response time: 47.67ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 10, tps: 327.10, reads: 4579.90, writes: 1307.40, response time: 48.49ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 10, tps: 331.10, reads: 4638.00, writes: 1325.40, response time: 47.77ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 10, tps: 333.80, reads: 4663.50, writes: 1333.10, response time: 47.76ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 10, tps: 332.60, reads: 4664.59, writes: 1332.80, response time: 47.64ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 10, tps: 327.60, reads: 4584.21, writes: 1309.40, response time: 47.70ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 10, tps: 331.80, reads: 4648.90, writes: 1328.20, response time: 47.82ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 10, tps: 329.00, reads: 4604.50, writes: 1316.10, response time: 47.83ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 10, tps: 331.60, reads: 4637.41, writes: 1325.00, response time: 44.10ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 10, tps: 329.20, reads: 4609.70, writes: 1317.70, response time: 47.87ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 10, tps: 332.40, reads: 4658.30, writes: 1329.40, response time: 46.71ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 10, tps: 335.30, reads: 4691.80, writes: 1340.60, response time: 47.90ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 10, tps: 337.10, reads: 4711.60, writes: 1347.20, response time: 46.34ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 10, tps: 337.30, reads: 4725.19, writes: 1349.50, response time: 47.13ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 10, tps: 328.10, reads: 4595.60, writes: 1312.50, response time: 46.78ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 10, tps: 333.00, reads: 4664.71, writes: 1332.20, response time: 48.35ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 10, tps: 334.00, reads: 4678.50, writes: 1336.20, response time: 48.46ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 10, tps: 279.60, reads: 3915.50, writes: 1119.40, response time: 77.24ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 10, tps: 346.70, reads: 4843.70, writes: 1385.40, response time: 40.65ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 10, tps: 336.80, reads: 4721.30, writes: 1348.20, response time: 47.96ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 10, tps: 335.40, reads: 4693.80, writes: 1340.20, response time: 47.66ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 10, tps: 329.00, reads: 4609.70, writes: 1318.30, response time: 47.84ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 10, tps: 333.30, reads: 4662.80, writes: 1331.70, response time: 46.96ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 10, tps: 330.40, reads: 4622.50, writes: 1321.10, response time: 46.71ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 10, tps: 330.80, reads: 4637.20, writes: 1324.90, response time: 48.09ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 10, tps: 333.49, reads: 4669.01, writes: 1331.97, response time: 48.74ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 10, tps: 334.61, reads: 4684.99, writes: 1339.23, response time: 46.14ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 10, tps: 337.50, reads: 4725.49, writes: 1350.30, response time: 46.54ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 10, tps: 331.50, reads: 4637.91, writes: 1325.70, response time: 47.20ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 10, tps: 330.80, reads: 4633.00, writes: 1324.10, response time: 47.79ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 10, tps: 337.20, reads: 4720.00, writes: 1349.50, response time: 46.88ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 10, tps: 334.40, reads: 4678.60, writes: 1335.30, response time: 47.90ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 10, tps: 334.70, reads: 4690.67, writes: 1339.89, response time: 48.38ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 10, tps: 334.20, reads: 4677.43, writes: 1337.81, response time: 47.32ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 10, tps: 322.10, reads: 4510.80, writes: 1287.10, response time: 45.92ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 10, tps: 320.50, reads: 4485.20, writes: 1282.20, response time: 48.81ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 10, tps: 316.20, reads: 4424.60, writes: 1264.00, response time: 47.63ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 10, tps: 322.10, reads: 4508.79, writes: 1288.10, response time: 45.96ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 10, tps: 322.80, reads: 4521.11, writes: 1292.20, response time: 47.52ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 10, tps: 318.60, reads: 4459.80, writes: 1274.50, response time: 46.67ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 10, tps: 297.50, reads: 4169.50, writes: 1191.50, response time: 41.95ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 10, tps: 320.30, reads: 4482.60, writes: 1279.50, response time: 39.94ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 10, tps: 326.90, reads: 4575.80, writes: 1308.50, response time: 38.02ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 10, tps: 309.10, reads: 4324.00, writes: 1234.60, response time: 40.19ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 10, tps: 314.10, reads: 4401.30, writes: 1259.20, response time: 39.29ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 10, tps: 302.80, reads: 4239.39, writes: 1209.40, response time: 41.58ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 10, tps: 302.90, reads: 4240.71, writes: 1213.00, response time: 41.28ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 10, tps: 307.80, reads: 4309.00, writes: 1229.10, response time: 40.11ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 10, tps: 301.40, reads: 4220.10, writes: 1207.60, response time: 42.82ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 10, tps: 310.70, reads: 4349.20, writes: 1242.30, response time: 39.28ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 10, tps: 298.70, reads: 4182.30, writes: 1194.30, response time: 41.60ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 10, tps: 304.50, reads: 4259.60, writes: 1217.80, response time: 40.56ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 10, tps: 303.30, reads: 4250.50, writes: 1215.40, response time: 41.42ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 10, tps: 303.80, reads: 4249.20, writes: 1212.40, response time: 41.25ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 10, tps: 302.10, reads: 4231.79, writes: 1209.50, response time: 42.12ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 10, tps: 298.20, reads: 4172.71, writes: 1192.80, response time: 42.42ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 10, tps: 308.30, reads: 4319.10, writes: 1234.80, response time: 40.22ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 10, tps: 306.20, reads: 4285.10, writes: 1222.10, response time: 40.96ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 10, tps: 305.50, reads: 4276.10, writes: 1222.50, response time: 40.65ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 10, tps: 307.70, reads: 4310.50, writes: 1232.50, response time: 39.49ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 10, tps: 302.60, reads: 4232.60, writes: 1208.50, response time: 40.92ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 10, tps: 304.00, reads: 4259.80, writes: 1216.90, response time: 39.94ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 10, tps: 301.80, reads: 4221.60, writes: 1207.50, response time: 41.13ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 10, tps: 299.40, reads: 4194.60, writes: 1198.00, response time: 41.64ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 10, tps: 290.90, reads: 4066.80, writes: 1161.60, response time: 67.71ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 10, tps: 305.10, reads: 4275.71, writes: 1221.90, response time: 40.11ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 10, tps: 302.60, reads: 4234.60, writes: 1210.00, response time: 45.58ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 10, tps: 301.90, reads: 4228.30, writes: 1206.30, response time: 41.83ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 10, tps: 307.30, reads: 4301.90, writes: 1230.70, response time: 40.75ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 10, tps: 303.70, reads: 4254.30, writes: 1215.90, response time: 41.52ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 10, tps: 296.00, reads: 4143.19, writes: 1182.10, response time: 44.04ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 10, tps: 306.50, reads: 4284.60, writes: 1225.50, response time: 40.28ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 10, tps: 306.00, reads: 4283.40, writes: 1224.40, response time: 40.35ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 10, tps: 309.10, reads: 4331.59, writes: 1236.90, response time: 40.15ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 10, tps: 305.30, reads: 4278.01, writes: 1223.10, response time: 41.23ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 10, tps: 303.20, reads: 4241.50, writes: 1210.60, response time: 40.57ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 10, tps: 308.40, reads: 4315.49, writes: 1233.00, response time: 40.90ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 10, tps: 295.90, reads: 4146.50, writes: 1185.20, response time: 48.92ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 10, tps: 291.20, reads: 4075.60, writes: 1164.00, response time: 49.33ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 10, tps: 307.90, reads: 4305.49, writes: 1230.80, response time: 39.14ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 10, tps: 313.80, reads: 4400.00, writes: 1256.80, response time: 38.58ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 10, tps: 312.80, reads: 4380.00, writes: 1252.30, response time: 40.03ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 10, tps: 309.60, reads: 4328.50, writes: 1235.30, response time: 40.31ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 10, tps: 312.30, reads: 4374.70, writes: 1250.80, response time: 39.93ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 10, tps: 302.00, reads: 4228.50, writes: 1208.50, response time: 46.81ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 10, tps: 311.70, reads: 4363.30, writes: 1245.60, response time: 39.92ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 10, tps: 306.80, reads: 4296.50, writes: 1228.30, response time: 41.50ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 10, tps: 302.40, reads: 4236.90, writes: 1209.70, response time: 41.24ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 10, tps: 310.50, reads: 4339.70, writes: 1240.20, response time: 40.30ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 10, tps: 307.20, reads: 4309.00, writes: 1231.90, response time: 40.57ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 10, tps: 310.00, reads: 4332.00, writes: 1237.00, response time: 40.41ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 10, tps: 310.90, reads: 4356.10, writes: 1245.20, response time: 40.51ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 10, tps: 303.00, reads: 4243.10, writes: 1211.80, response time: 42.44ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 10, tps: 309.40, reads: 4332.70, writes: 1238.50, response time: 40.29ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 10, tps: 307.10, reads: 4290.10, writes: 1225.70, response time: 40.65ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 10, tps: 302.50, reads: 4242.50, writes: 1211.50, response time: 40.97ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 10, tps: 307.00, reads: 4299.10, writes: 1228.70, response time: 41.54ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 10, tps: 311.30, reads: 4360.70, writes: 1243.70, response time: 39.40ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 10, tps: 302.30, reads: 4226.90, writes: 1209.80, response time: 41.28ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 10, tps: 301.20, reads: 4219.80, writes: 1204.10, response time: 41.07ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 10, tps: 312.20, reads: 4372.00, writes: 1248.90, response time: 40.10ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 10, tps: 305.70, reads: 4280.70, writes: 1223.50, response time: 40.15ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 10, tps: 285.00, reads: 3986.30, writes: 1139.40, response time: 46.03ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 10, tps: 284.80, reads: 3986.30, writes: 1140.40, response time: 45.91ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 10, tps: 308.40, reads: 4318.90, writes: 1232.50, response time: 41.13ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 10, tps: 308.90, reads: 4325.50, writes: 1236.30, response time: 39.95ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 10, tps: 278.50, reads: 3899.90, writes: 1113.90, response time: 48.42ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 10, tps: 284.50, reads: 3983.30, writes: 1138.80, response time: 48.48ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 10, tps: 297.20, reads: 4159.70, writes: 1187.40, response time: 44.24ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 10, tps: 308.30, reads: 4315.90, writes: 1232.70, response time: 40.24ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 10, tps: 309.20, reads: 4329.20, writes: 1238.30, response time: 39.35ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 10, tps: 310.80, reads: 4353.50, writes: 1243.20, response time: 39.49ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 10, tps: 309.90, reads: 4336.40, writes: 1239.00, response time: 40.09ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 10, tps: 306.10, reads: 4282.60, writes: 1223.10, response time: 41.08ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 10, tps: 307.00, reads: 4300.90, writes: 1229.40, response time: 41.02ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 10, tps: 298.50, reads: 4177.00, writes: 1194.90, response time: 43.14ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 10, tps: 307.60, reads: 4299.60, writes: 1228.10, response time: 40.97ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 10, tps: 306.80, reads: 4302.00, writes: 1229.20, response time: 39.94ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 10, tps: 301.00, reads: 4207.80, writes: 1202.00, response time: 42.43ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 10, tps: 306.00, reads: 4288.09, writes: 1224.80, response time: 40.92ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 10, tps: 305.20, reads: 4277.41, writes: 1221.90, response time: 40.34ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 10, tps: 293.80, reads: 4109.70, writes: 1173.30, response time: 43.53ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 10, tps: 301.90, reads: 4230.89, writes: 1209.70, response time: 40.64ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 10, tps: 304.50, reads: 4258.31, writes: 1216.70, response time: 41.16ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 10, tps: 310.00, reads: 4343.10, writes: 1241.00, response time: 39.34ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 10, tps: 314.60, reads: 4403.20, writes: 1258.10, response time: 39.15ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            8048488
        write:                           2299568
        other:                           1149784
        total:                           11497840
    transactions:                        574892 (319.38 per sec.)
    read/write requests:                 10348056 (5748.84 per sec.)
    other operations:                    1149784 (638.76 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0243s
    total number of events:              574892
    total time taken by event execution: 17999.0936s
    response time:
         min:                                 23.54ms
         avg:                                 31.31ms
         max:                                124.79ms
         approx.  99 percentile:              44.54ms

Threads fairness:
    events (avg/stddev):           57489.2000/705.80
    execution time (avg/stddev):   1799.9094/0.01



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+-------+----------------------------+----------------------------------------+
| Id | User            | Host               | db     | Command | Time  | State                      | Info                                   |
+----+-----------------+--------------------+--------+---------+-------+----------------------------+----------------------------------------+
|  5 | event_scheduler | localhost          | NULL   | Daemon  | 70976 | Waiting on empty queue     | NULL                                   |
| 72 | sysbench        | 192.168.1.12:56390 | sbtest | Query   |     0 | init                       | show processlist                       |
| 73 | sysbench        | 192.168.1.11:47018 | sbtest | Sleep   |     0 |                            | NULL                                   |
| 74 | sysbench        | 192.168.1.11:47017 | sbtest | Query   |     0 | waiting for handler commit | SELECT c FROM sbtest4 WHERE id=1431986 |
| 75 | sysbench        | 192.168.1.11:47031 | sbtest | Sleep   |     0 |                            | NULL                                   |
| 76 | sysbench        | 192.168.1.11:47038 | sbtest | Query   |     0 | waiting for handler commit | COMMIT                                 |
| 77 | sysbench        | 192.168.1.11:47030 | sbtest | Sleep   |     0 |                            | NULL                                   |
| 78 | sysbench        | 192.168.1.11:47036 | sbtest | Query   |     0 | waiting for handler commit | COMMIT                                 |
| 79 | sysbench        | 192.168.1.11:47019 | sbtest | Query   |     0 | waiting for handler commit | COMMIT                                 |
| 80 | sysbench        | 192.168.1.11:47028 | sbtest | Query   |     0 | waiting for handler commit | COMMIT                                 |
| 81 | sysbench        | 192.168.1.11:47034 | sbtest | Query   |     0 | waiting for handler commit | COMMIT                                 |
| 82 | sysbench        | 192.168.1.11:47016 | sbtest | Sleep   |     0 |                            | NULL                                   |
+----+-----------------+--------------------+--------+---------+-------+----------------------------+----------------------------------------+
12 rows in set (0.00 sec)

mysql> show processlist;
+----+-----------------+--------------------+--------+---------+-------+----------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time  | State                      | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+-------+----------------------------+------------------------------------------------------------------------------------------------------+
|  5 | event_scheduler | localhost          | NULL   | Daemon  | 72297 | Waiting on empty queue     | NULL                                                                                                 |
| 73 | sysbench        | 192.168.1.11:47018 | sbtest | Query   |     0 | starting                   | UPDATE sbtest4 SET c='14966868833-77505097418-18230103788-05167407403-39927975216-96954791940-886979 |
| 74 | sysbench        | 192.168.1.11:47017 | sbtest | Sleep   |     0 |                            | NULL                                                                                                 |
| 75 | sysbench        | 192.168.1.11:47031 | sbtest | Query   |     0 | waiting for handler commit | COMMIT                                                                                               |
| 76 | sysbench        | 192.168.1.11:47038 | sbtest | Sleep   |     0 |                            | NULL                                                                                                 |
| 77 | sysbench        | 192.168.1.11:47030 | sbtest | Sleep   |     0 |                            | NULL                                                                                                 |
| 78 | sysbench        | 192.168.1.11:47036 | sbtest | Query   |     0 | waiting for handler commit | COMMIT                                                                                               |
| 79 | sysbench        | 192.168.1.11:47019 | sbtest | Query   |     0 | waiting for handler commit | SELECT c FROM sbtest10 WHERE id BETWEEN 1113942 AND 1113942+99 ORDER BY c                            |
| 80 | sysbench        | 192.168.1.11:47028 | sbtest | Sleep   |     0 |                            | NULL                                                                                                 |
| 81 | sysbench        | 192.168.1.11:47034 | sbtest | Query   |     0 | Sending to client          | INSERT INTO sbtest8 (id, k, c, pad) VALUES (1070915, 82455, '96111041317-62149686883-37505858239-378 |
| 82 | sysbench        | 192.168.1.11:47016 | sbtest | Sleep   |     0 |                            | NULL                                                                                                 |
| 83 | sysbench        | 192.168.1.12:56504 | sbtest | Query   |     0 | init                       | show processlist                                                                                     |
+----+-----------------+--------------------+--------+---------+-------+----------------------------+------------------------------------------------------------------------------------------------------+
12 rows in set (0.00 sec)



[coding001@voice lib]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.09    8.72     0.14     0.34    91.69     0.08    7.82   23.67    4.02   0.53   0.57

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3509.00     0.00    44.13    25.76     1.86    0.53    0.00    0.53   0.23  79.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3784.00     0.00    45.58    24.67     2.10    0.55    0.00    0.55   0.23  86.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3760.00     0.00    45.88    24.99     2.04    0.54    0.00    0.54   0.22  84.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00 3721.00     0.00    45.36    24.96     2.11    0.57    0.00    0.57   0.23  85.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3912.00     0.00    46.13    24.15     2.10    0.54    0.00    0.54   0.22  86.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 3863.00     0.00    45.95    24.36     2.09    0.54    0.00    0.54   0.23  87.40

^C
[coding001@voice lib]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.66    0.00    0.71    0.19    0.00   98.44

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              10.81       143.19       352.32 1199625530 2951690932

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          46.80    0.00   17.14    7.42    0.00   28.64

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3913.00         0.00     48568.00          0      48568

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          45.99    0.00   17.05    7.75    0.00   29.20

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3827.00         0.00     46632.00          0      46632

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          45.31    0.00   17.19    7.55    0.00   29.95

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3819.00         0.00     48760.00          0      48760



[coding001@voice lib]$ top
top - 14:16:39 up 96 days, 23:14,  4 users,  load average: 5.56, 5.65, 3.21
Tasks: 122 total,   1 running, 121 sleeping,   0 stopped,   0 zombie
%Cpu0  : 45.9 us, 13.1 sy,  0.0 ni, 25.2 id,  4.5 wa,  0.0 hi, 11.4 si,  0.0 st
%Cpu1  : 44.7 us, 11.9 sy,  0.0 ni, 31.8 id,  9.6 wa,  0.0 hi,  2.0 si,  0.0 st
%Cpu2  : 44.4 us, 11.9 sy,  0.0 ni, 32.9 id,  9.2 wa,  0.0 hi,  1.7 si,  0.0 st
%Cpu3  : 39.1 us, 10.4 sy,  0.0 ni, 38.8 id, 10.4 wa,  0.0 hi,  1.4 si,  0.0 st
KiB Mem : 16266300 total,   186920 free, 11392988 used,  4686392 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  3764424 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
32578 mysql     20   0   11.2g   9.1g  10172 S 233.9 58.4 308:06.29 mysqld           