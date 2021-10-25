
set global innodb_adaptive_hash_index=OFF;


mysql> set global innodb_adaptive_hash_index=OFF;

Query OK, 0 rows affected (0.37 sec)

mysql> 
mysql> show global variables like '%innodb_adaptive_hash_index%';
+----------------------------------+-------+
| Variable_name                    | Value |
+----------------------------------+-------+
| innodb_adaptive_hash_index       | OFF   |
| innodb_adaptive_hash_index_parts | 8     |
+----------------------------------+-------+
2 rows in set (0.00 sec)




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
drop table sbtest16; 
drop table sbtest17; 
drop table sbtest18; 
drop table sbtest19; 
drop table sbtest20; 


set global sync_binlog=0;
set global innodb_flush_log_at_trx_commit=0;

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='' --mysql-db=sbtest --tables=20 --table-size=3000000 --threads=32 --time=1800 --report-interval=10 --db-driver=mysql prepare &



purge binary logs to 'mysql-bin.000259';  



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


purge binary logs to 'mysql-bin.000281';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --mysql-db=sbtest --tables=20 \
--table-size=3000000 --threads=32 --time=1800 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_32_11_vesion7_notAHI.log &


[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_32_11_vesion7_notAHI.log
[ 50s ] thds: 32 tps: 395.90 qps: 2375.48 (r/w/o: 0.00/1583.69/791.79) lat (ms,95%): 121.08 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 32 tps: 422.70 qps: 2525.92 (r/w/o: 0.00/1680.51/845.41) lat (ms,95%): 110.66 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 32 tps: 433.40 qps: 2600.90 (r/w/o: 0.00/1734.10/866.80) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 32 tps: 429.19 qps: 2575.96 (r/w/o: 0.00/1717.57/858.39) lat (ms,95%): 114.72 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 32 tps: 445.01 qps: 2678.85 (r/w/o: 0.00/1788.83/890.02) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 32 tps: 444.60 qps: 2667.90 (r/w/o: 0.00/1778.70/889.20) lat (ms,95%): 102.97 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 32 tps: 456.00 qps: 2728.60 (r/w/o: 0.00/1816.60/912.00) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 32 tps: 442.30 qps: 2661.21 (r/w/o: 0.00/1776.61/884.60) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 32 tps: 445.40 qps: 2671.90 (r/w/o: 0.00/1781.10/890.80) lat (ms,95%): 106.75 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 32 tps: 439.40 qps: 2629.89 (r/w/o: 0.00/1751.10/878.80) lat (ms,95%): 106.75 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 32 tps: 449.40 qps: 2703.39 (r/w/o: 0.00/1804.59/898.80) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 32 tps: 470.70 qps: 2824.22 (r/w/o: 0.00/1882.81/941.41) lat (ms,95%): 102.97 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 32 tps: 541.20 qps: 3246.72 (r/w/o: 0.00/2164.31/1082.41) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 32 tps: 658.50 qps: 3942.39 (r/w/o: 0.00/2625.40/1317.00) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 32 tps: 599.00 qps: 3602.57 (r/w/o: 0.00/2404.68/1197.89) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 32 tps: 567.60 qps: 3406.10 (r/w/o: 0.00/2270.80/1135.30) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 32 tps: 504.90 qps: 3029.01 (r/w/o: 0.00/2019.21/1009.80) lat (ms,95%): 102.97 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 32 tps: 504.50 qps: 3027.19 (r/w/o: 0.00/2018.20/1009.00) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 32 tps: 527.59 qps: 3165.76 (r/w/o: 0.00/2110.57/1055.19) lat (ms,95%): 106.75 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 32 tps: 533.81 qps: 3202.85 (r/w/o: 0.00/2135.23/1067.62) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 32 tps: 535.40 qps: 3212.40 (r/w/o: 0.00/2141.60/1070.80) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 32 tps: 561.29 qps: 3362.26 (r/w/o: 0.00/2239.68/1122.59) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 32 tps: 609.91 qps: 3658.64 (r/w/o: 0.00/2438.83/1219.81) lat (ms,95%): 106.75 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 32 tps: 618.00 qps: 3705.60 (r/w/o: 0.00/2469.60/1236.00) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 32 tps: 604.60 qps: 3636.28 (r/w/o: 0.00/2427.08/1209.19) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 32 tps: 570.10 qps: 3420.61 (r/w/o: 0.00/2280.41/1140.20) lat (ms,95%): 102.97 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 32 tps: 552.70 qps: 3316.18 (r/w/o: 0.00/2210.79/1105.39) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 32 tps: 577.71 qps: 3466.23 (r/w/o: 0.00/2310.82/1155.41) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 32 tps: 585.20 qps: 3511.20 (r/w/o: 0.00/2340.80/1170.40) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 32 tps: 594.60 qps: 3567.59 (r/w/o: 0.00/2378.39/1189.20) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 32 tps: 556.60 qps: 3339.60 (r/w/o: 0.00/2226.40/1113.20) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 32 tps: 608.40 qps: 3643.43 (r/w/o: 0.00/2426.62/1216.81) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 32 tps: 665.20 qps: 3998.18 (r/w/o: 0.00/2667.79/1330.39) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 32 tps: 630.00 qps: 3779.58 (r/w/o: 0.00/2519.59/1259.99) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 32 tps: 604.80 qps: 3620.20 (r/w/o: 0.00/2410.60/1209.60) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 32 tps: 598.60 qps: 3593.27 (r/w/o: 0.00/2396.08/1197.19) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 32 tps: 598.81 qps: 3589.33 (r/w/o: 0.00/2392.22/1197.11) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 32 tps: 601.70 qps: 3610.88 (r/w/o: 0.00/2406.98/1203.89) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 32 tps: 600.30 qps: 3611.42 (r/w/o: 0.00/2410.92/1200.51) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 32 tps: 600.70 qps: 3598.30 (r/w/o: 0.00/2396.80/1201.50) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 32 tps: 601.90 qps: 3608.68 (r/w/o: 0.00/2404.88/1203.79) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 32 tps: 704.99 qps: 4235.03 (r/w/o: 0.00/2825.05/1409.98) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 32 tps: 705.21 qps: 4233.07 (r/w/o: 0.00/2822.65/1410.42) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 32 tps: 644.51 qps: 3868.95 (r/w/o: 0.00/2579.93/1289.02) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 32 tps: 633.90 qps: 3796.69 (r/w/o: 0.00/2528.90/1267.80) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 32 tps: 611.00 qps: 3663.59 (r/w/o: 0.00/2441.59/1222.00) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 32 tps: 626.30 qps: 3757.90 (r/w/o: 0.00/2505.30/1252.60) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 32 tps: 620.60 qps: 3724.90 (r/w/o: 0.00/2483.70/1241.20) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 32 tps: 627.29 qps: 3765.13 (r/w/o: 0.00/2510.75/1254.38) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 32 tps: 676.72 qps: 4060.01 (r/w/o: 0.00/2706.37/1353.64) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 32 tps: 683.30 qps: 4096.78 (r/w/o: 0.00/2730.19/1366.59) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 32 tps: 754.20 qps: 4526.31 (r/w/o: 0.00/3017.90/1508.40) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 32 tps: 694.90 qps: 4176.12 (r/w/o: 0.00/2786.31/1389.81) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 32 tps: 667.99 qps: 4000.42 (r/w/o: 0.00/2664.75/1335.67) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 32 tps: 654.59 qps: 3932.67 (r/w/o: 0.00/2623.28/1309.39) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 32 tps: 640.80 qps: 3845.17 (r/w/o: 0.00/2563.58/1281.59) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 32 tps: 657.62 qps: 3948.91 (r/w/o: 0.00/2633.57/1315.34) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 32 tps: 631.39 qps: 3784.72 (r/w/o: 0.00/2522.05/1262.67) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 32 tps: 652.30 qps: 3913.50 (r/w/o: 0.00/2608.80/1304.70) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 32 tps: 716.41 qps: 4296.06 (r/w/o: 0.00/2863.44/1432.62) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 32 tps: 744.91 qps: 4469.05 (r/w/o: 0.00/2980.33/1488.72) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 32 tps: 774.29 qps: 4648.77 (r/w/o: 0.00/3098.98/1549.79) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 32 tps: 710.89 qps: 4266.94 (r/w/o: 0.00/2845.06/1421.88) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 32 tps: 661.00 qps: 3967.42 (r/w/o: 0.00/2645.52/1321.91) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 32 tps: 675.60 qps: 4049.79 (r/w/o: 0.00/2698.49/1351.30) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 32 tps: 665.90 qps: 3997.43 (r/w/o: 0.00/2665.62/1331.81) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 32 tps: 640.01 qps: 3837.93 (r/w/o: 0.00/2557.92/1280.01) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 32 tps: 627.69 qps: 3770.66 (r/w/o: 0.00/2515.28/1255.39) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 32 tps: 712.49 qps: 4271.05 (r/w/o: 0.00/2846.07/1424.98) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 32 tps: 719.59 qps: 4316.25 (r/w/o: 0.00/2877.46/1438.78) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 32 tps: 796.50 qps: 4782.81 (r/w/o: 0.00/3189.61/1593.20) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 32 tps: 775.00 qps: 4647.78 (r/w/o: 0.00/3097.58/1550.19) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 32 tps: 717.31 qps: 4305.45 (r/w/o: 0.00/2870.93/1434.52) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 32 tps: 698.29 qps: 4184.37 (r/w/o: 0.00/2788.38/1395.99) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 32 tps: 707.39 qps: 4247.65 (r/w/o: 0.00/2832.57/1415.08) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 32 tps: 710.12 qps: 4259.09 (r/w/o: 0.00/2838.66/1420.43) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 32 tps: 718.99 qps: 4316.33 (r/w/o: 0.00/2878.45/1437.88) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 32 tps: 632.22 qps: 3797.13 (r/w/o: 0.00/2532.49/1264.64) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 32 tps: 727.49 qps: 4363.54 (r/w/o: 0.00/2908.46/1455.08) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 32 tps: 745.08 qps: 4466.86 (r/w/o: 0.00/2976.71/1490.15) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 32 tps: 794.43 qps: 4770.49 (r/w/o: 0.00/3181.72/1588.76) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 32 tps: 797.19 qps: 4783.47 (r/w/o: 0.00/3188.98/1594.49) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 32 tps: 781.39 qps: 4681.82 (r/w/o: 0.00/3119.85/1561.97) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 32 tps: 717.70 qps: 4313.42 (r/w/o: 0.00/2877.21/1436.21) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 32 tps: 726.18 qps: 4352.99 (r/w/o: 0.00/2900.62/1452.36) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 32 tps: 690.92 qps: 4145.91 (r/w/o: 0.00/2764.07/1381.84) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 32 tps: 683.00 qps: 4095.80 (r/w/o: 0.00/2730.50/1365.30) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 32 tps: 658.71 qps: 3956.36 (r/w/o: 0.00/2638.24/1318.12) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 32 tps: 730.27 qps: 4377.01 (r/w/o: 0.00/2917.07/1459.94) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 32 tps: 745.71 qps: 4475.03 (r/w/o: 0.00/2983.82/1491.21) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 32 tps: 815.61 qps: 4896.06 (r/w/o: 0.00/3264.64/1631.42) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 32 tps: 795.11 qps: 4770.64 (r/w/o: 0.00/3179.82/1590.81) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 32 tps: 781.68 qps: 4690.16 (r/w/o: 0.00/3127.21/1562.95) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 32 tps: 780.00 qps: 4673.92 (r/w/o: 0.00/3114.11/1559.81) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 32 tps: 705.82 qps: 4242.34 (r/w/o: 0.00/2830.10/1412.25) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 32 tps: 782.60 qps: 4696.69 (r/w/o: 0.00/3131.59/1565.10) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 32 tps: 698.40 qps: 4189.99 (r/w/o: 0.00/2793.09/1396.90) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 32 tps: 717.71 qps: 4304.39 (r/w/o: 0.00/2869.26/1435.13) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 32 tps: 707.19 qps: 4241.14 (r/w/o: 0.00/2826.86/1414.28) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 32 tps: 758.21 qps: 4551.15 (r/w/o: 0.00/3034.33/1516.82) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 32 tps: 781.29 qps: 4690.02 (r/w/o: 0.00/3127.55/1562.47) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 32 tps: 830.71 qps: 4984.33 (r/w/o: 0.00/3322.92/1661.41) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 32 tps: 804.91 qps: 4827.53 (r/w/o: 0.00/3217.62/1609.91) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 32 tps: 768.39 qps: 4607.14 (r/w/o: 0.00/3070.46/1536.68) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 32 tps: 739.90 qps: 4443.31 (r/w/o: 0.00/2963.41/1479.90) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 32 tps: 801.00 qps: 4803.49 (r/w/o: 0.00/3201.49/1602.00) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 32 tps: 712.09 qps: 4271.22 (r/w/o: 0.00/2847.25/1423.97) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 32 tps: 710.13 qps: 4262.57 (r/w/o: 0.00/2842.22/1420.36) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 32 tps: 653.79 qps: 3925.34 (r/w/o: 0.00/2617.66/1307.68) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 32 tps: 767.31 qps: 4598.58 (r/w/o: 0.00/3063.96/1534.63) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 32 tps: 775.48 qps: 4656.51 (r/w/o: 0.00/3105.54/1550.97) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 32 tps: 875.02 qps: 5251.61 (r/w/o: 0.00/3501.67/1749.94) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 32 tps: 866.10 qps: 5194.79 (r/w/o: 0.00/3462.89/1731.90) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 32 tps: 810.19 qps: 4861.02 (r/w/o: 0.00/3240.45/1620.57) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 32 tps: 779.01 qps: 4674.27 (r/w/o: 0.00/3116.15/1558.12) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 32 tps: 710.49 qps: 4261.64 (r/w/o: 0.00/2840.56/1421.08) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 32 tps: 851.40 qps: 5105.82 (r/w/o: 0.00/3403.51/1702.31) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 32 tps: 707.50 qps: 4244.92 (r/w/o: 0.00/2829.42/1415.51) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 32 tps: 655.81 qps: 3941.55 (r/w/o: 0.00/2630.03/1311.52) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 32 tps: 757.39 qps: 4541.73 (r/w/o: 0.00/3027.16/1514.58) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 32 tps: 788.30 qps: 4728.01 (r/w/o: 0.00/3151.20/1576.80) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 32 tps: 841.29 qps: 5049.13 (r/w/o: 0.00/3366.65/1682.48) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 32 tps: 862.01 qps: 5167.76 (r/w/o: 0.00/3443.64/1724.12) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 32 tps: 781.01 qps: 4694.15 (r/w/o: 0.00/3132.03/1562.12) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 32 tps: 786.80 qps: 4713.82 (r/w/o: 0.00/3140.21/1573.61) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 32 tps: 789.79 qps: 4746.07 (r/w/o: 0.00/3166.48/1579.59) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 32 tps: 814.18 qps: 4882.48 (r/w/o: 0.00/3254.42/1628.06) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 32 tps: 751.71 qps: 4512.88 (r/w/o: 0.00/3009.15/1503.73) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 32 tps: 732.07 qps: 4385.72 (r/w/o: 0.00/2921.68/1464.04) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 32 tps: 685.93 qps: 4111.76 (r/w/o: 0.00/2740.51/1371.25) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 32 tps: 829.60 qps: 4981.88 (r/w/o: 0.00/3321.98/1659.89) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 32 tps: 800.80 qps: 4807.68 (r/w/o: 0.00/3206.08/1601.59) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 32 tps: 845.70 qps: 5062.49 (r/w/o: 0.00/3373.79/1688.70) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 32 tps: 875.60 qps: 5266.21 (r/w/o: 0.00/3512.31/1753.90) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 32 tps: 839.01 qps: 5036.46 (r/w/o: 0.00/3358.44/1678.02) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 32 tps: 784.51 qps: 4701.34 (r/w/o: 0.00/3132.33/1569.01) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 32 tps: 816.70 qps: 4899.59 (r/w/o: 0.00/3266.20/1633.40) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 32 tps: 865.99 qps: 5200.24 (r/w/o: 0.00/3468.26/1731.98) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 32 tps: 749.99 qps: 4501.67 (r/w/o: 0.00/3001.68/1499.99) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 32 tps: 721.10 qps: 4312.99 (r/w/o: 0.00/2871.90/1441.10) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 32 tps: 773.52 qps: 4655.00 (r/w/o: 0.00/3106.87/1548.13) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 32 tps: 809.20 qps: 4855.22 (r/w/o: 0.00/3236.81/1618.41) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 32 tps: 828.36 qps: 4962.47 (r/w/o: 0.00/3306.05/1656.42) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 32 tps: 894.42 qps: 5369.72 (r/w/o: 0.00/3581.38/1788.34) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 32 tps: 880.82 qps: 5289.43 (r/w/o: 0.00/3526.99/1762.44) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 32 tps: 840.40 qps: 5042.40 (r/w/o: 0.00/3361.60/1680.80) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 32 tps: 819.66 qps: 4914.05 (r/w/o: 0.00/3274.73/1639.32) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 32 tps: 823.23 qps: 4936.28 (r/w/o: 0.00/3289.82/1646.46) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 32 tps: 866.80 qps: 5200.18 (r/w/o: 0.00/3466.59/1733.59) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 32 tps: 760.91 qps: 4567.26 (r/w/o: 0.00/3045.44/1521.82) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 32 tps: 725.30 qps: 4357.62 (r/w/o: 0.00/2907.01/1450.61) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 32 tps: 776.69 qps: 4658.03 (r/w/o: 0.00/3104.65/1553.38) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 32 tps: 843.81 qps: 5056.64 (r/w/o: 0.00/3369.53/1687.11) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 32 tps: 830.80 qps: 4985.00 (r/w/o: 0.00/3322.90/1662.10) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 32 tps: 913.07 qps: 5485.15 (r/w/o: 0.00/3659.00/1826.15) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 32 tps: 896.62 qps: 5376.71 (r/w/o: 0.00/3583.47/1793.24) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 32 tps: 827.80 qps: 4969.09 (r/w/o: 0.00/3313.59/1655.50) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 32 tps: 859.11 qps: 5156.75 (r/w/o: 0.00/3438.43/1718.32) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 32 tps: 830.89 qps: 4978.25 (r/w/o: 0.00/3316.47/1661.78) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 32 tps: 876.41 qps: 5265.57 (r/w/o: 0.00/3512.75/1752.82) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 32 tps: 758.48 qps: 4548.51 (r/w/o: 0.00/3031.54/1516.97) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 32 tps: 684.01 qps: 4101.76 (r/w/o: 0.00/2733.94/1367.82) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 32 tps: 807.70 qps: 4850.90 (r/w/o: 0.00/3235.30/1615.60) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 32 tps: 851.19 qps: 5099.15 (r/w/o: 0.00/3396.97/1702.18) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 32 tps: 855.60 qps: 5140.72 (r/w/o: 0.00/3429.31/1711.41) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 32 tps: 933.70 qps: 5601.07 (r/w/o: 0.00/3733.68/1867.39) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 32 tps: 905.31 qps: 5433.86 (r/w/o: 0.00/3623.24/1810.62) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 32 tps: 841.21 qps: 5046.04 (r/w/o: 0.00/3363.63/1682.41) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 32 tps: 851.70 qps: 5111.38 (r/w/o: 0.00/3407.99/1703.39) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 32 tps: 813.20 qps: 4872.89 (r/w/o: 0.00/3246.90/1626.00) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 32 tps: 894.09 qps: 5362.97 (r/w/o: 0.00/3574.78/1788.19) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 32 tps: 767.30 qps: 4611.71 (r/w/o: 0.00/3076.71/1535.00) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 32 tps: 710.90 qps: 4256.59 (r/w/o: 0.00/2834.79/1421.80) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 32 tps: 790.30 qps: 4750.63 (r/w/o: 0.00/3170.02/1580.61) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 32 tps: 878.89 qps: 5268.14 (r/w/o: 0.00/3510.36/1757.78) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 32 tps: 869.11 qps: 5219.87 (r/w/o: 0.00/3481.64/1738.22) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           5246072
        other:                           2623036
        total:                           7869108
    transactions:                        1311518 (728.61 per sec.)
    queries:                             7869108 (4371.65 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0299s
    total number of events:              1311518

Latency (ms):
         min:                                    7.80
         avg:                                   43.92
         max:                                  327.32
         95th percentile:                       94.10
         sum:                             57595580.26

Threads fairness:
    events (avg/stddev):           40984.9375/195.82
    execution time (avg/stddev):   1799.8619/0.00


mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------+
| Id | User            | Host               | db     | Command | Time | State                  | Info             |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 1605 | Waiting on empty queue | NULL             |
|  3 | root            | localhost          | sbtest | Query   |    0 | starting               | show processlist |
| 36 | sysbench        | 192.168.1.10:53482 | sbtest | Execute |    0 | starting               | COMMIT           |
| 37 | sysbench        | 192.168.1.10:53484 | sbtest | Sleep   |    0 |                        | NULL             |
| 38 | sysbench        | 192.168.1.10:53486 | sbtest | Execute |    0 | starting               | COMMIT           |
| 39 | sysbench        | 192.168.1.10:53494 | sbtest | Sleep   |    0 |                        | NULL             |
| 40 | sysbench        | 192.168.1.10:53488 | sbtest | Execute |    0 | starting               | COMMIT           |
| 41 | sysbench        | 192.168.1.10:53490 | sbtest | Sleep   |    0 |                        | NULL             |
| 42 | sysbench        | 192.168.1.10:53496 | sbtest | Execute |    0 | starting               | COMMIT           |
| 43 | sysbench        | 192.168.1.10:53492 | sbtest | Execute |    0 | starting               | COMMIT           |
| 44 | sysbench        | 192.168.1.10:53498 | sbtest | Sleep   |    0 |                        | NULL             |
| 45 | sysbench        | 192.168.1.10:53500 | sbtest | Execute |    0 | starting               | COMMIT           |
| 46 | sysbench        | 192.168.1.10:53502 | sbtest | Execute |    0 | starting               | COMMIT           |
| 47 | sysbench        | 192.168.1.10:53504 | sbtest | Execute |    0 | starting               | COMMIT           |
| 48 | sysbench        | 192.168.1.10:53506 | sbtest | Execute |    0 | starting               | COMMIT           |
| 49 | sysbench        | 192.168.1.10:53508 | sbtest | Execute |    0 | starting               | COMMIT           |
| 50 | sysbench        | 192.168.1.10:53510 | sbtest | Sleep   |    0 |                        | NULL             |
| 51 | sysbench        | 192.168.1.10:53512 | sbtest | Sleep   |    0 |                        | NULL             |
| 52 | sysbench        | 192.168.1.10:53514 | sbtest | Sleep   |    0 |                        | NULL             |
| 53 | sysbench        | 192.168.1.10:53516 | sbtest | Sleep   |    0 |                        | NULL             |
| 54 | sysbench        | 192.168.1.10:53518 | sbtest | Execute |    0 | starting               | COMMIT           |
| 55 | sysbench        | 192.168.1.10:53520 | sbtest | Execute |    0 | starting               | COMMIT           |
| 56 | sysbench        | 192.168.1.10:53522 | sbtest | Execute |    0 | starting               | COMMIT           |
| 57 | sysbench        | 192.168.1.10:53526 | sbtest | Execute |    0 | starting               | COMMIT           |
| 58 | sysbench        | 192.168.1.10:53524 | sbtest | Execute |    0 | starting               | COMMIT           |
| 59 | sysbench        | 192.168.1.10:53542 | sbtest | Execute |    0 | starting               | COMMIT           |
| 60 | sysbench        | 192.168.1.10:53534 | sbtest | Execute |    0 | starting               | COMMIT           |
| 61 | sysbench        | 192.168.1.10:53536 | sbtest | Execute |    0 | starting               | COMMIT           |
| 62 | sysbench        | 192.168.1.10:53540 | sbtest | Execute |    0 | starting               | COMMIT           |
| 63 | sysbench        | 192.168.1.10:53544 | sbtest | Execute |    0 | starting               | COMMIT           |
| 64 | sysbench        | 192.168.1.10:53528 | sbtest | Execute |    0 | starting               | COMMIT           |
| 65 | sysbench        | 192.168.1.10:53530 | sbtest | Sleep   |    0 |                        | NULL             |
| 66 | sysbench        | 192.168.1.10:53538 | sbtest | Execute |    0 | starting               | COMMIT           |
| 67 | sysbench        | 192.168.1.10:53532 | sbtest | Execute |    0 | starting               | COMMIT           |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------+
34 rows in set (0.00 sec)

[root@voice mysql3307]# top
top - 17:39:26 up 98 days,  2:37,  4 users,  load average: 6.31, 7.03, 6.85
Tasks: 124 total,   1 running, 123 sleeping,   0 stopped,   0 zombie
%Cpu0  : 23.4 us, 12.4 sy,  0.0 ni, 42.3 id, 19.6 wa,  0.0 hi,  2.4 si,  0.0 st
%Cpu1  : 25.4 us, 11.9 sy,  0.0 ni, 42.4 id, 18.3 wa,  0.0 hi,  2.0 si,  0.0 st
%Cpu2  : 22.9 us, 11.0 sy,  0.0 ni, 35.3 id, 29.5 wa,  0.0 hi,  1.4 si,  0.0 st
%Cpu3  : 20.5 us,  9.2 sy,  0.0 ni, 38.4 id, 30.8 wa,  0.0 hi,  1.0 si,  0.0 st
KiB Mem : 16266300 total,   154284 free, 10231508 used,  5880508 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  4916824 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
 5560 mysql     20   0   11.4g   9.2g  12000 S 144.9 59.4  35:10.86 mysqld       
 
 
[root@voice mysql3307]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.35   12.14     0.15     0.46    86.03     0.16   10.91   25.61    8.06   0.52   0.75

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     6.00  183.00  984.00     7.99    47.93    98.14     4.83    4.08    2.28    4.41   0.83  96.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  173.00  913.00     7.81    48.00   105.25     3.64    3.38    1.79    3.69   0.88  95.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  220.00  805.00     9.83    47.90   115.34     3.82    3.76    1.60    4.35   0.94  96.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  235.00 1015.00     9.34    48.01    93.96     3.85    3.07    2.10    3.30   0.77  95.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  206.00  916.00    10.30    48.07   106.55     3.66    3.23    1.88    3.54   0.85  95.40

^C
[root@voice mysql3307]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.73    0.00    0.73    0.23    0.00   98.31

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              14.49       153.51       469.90 1301281374 3983203256

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          23.16    0.00   14.25   24.94    0.00   37.66

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1024.00      9104.00     49348.00       9104      49348

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          22.51    0.00   12.02   26.34    0.00   39.13

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1044.00      6960.00     49212.00       6960      49212

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          26.15    0.00   14.36   23.85    0.00   35.64

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1063.00      6352.00     48952.00       6352      48952



mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-22 17:36:35 0x7ff7b00a7700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 44 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 591 srv_active, 0 srv_shutdown, 317 srv_idle
srv_master_thread log flush and writes: 908
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 1600192
--Thread 140701152139008 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x367d3f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 140701152950016 has waited at btr0cur.cc line 976 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7ff72c00c990 created in file dict0dict.cc line 2737
a writer (thread id 140701151057664) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file btr0cur.cc line 1008
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
--Thread 140701153761024 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x367d3f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 140701151057664 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x367d3f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 140701156464384 has waited at btr0cur.cc line 976 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7ff72c00c990 created in file dict0dict.cc line 2737
a writer (thread id 140701151057664) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file btr0cur.cc line 1008
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
--Thread 140701452605184 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x367d3f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 140701694150400 has waited at btr0cur.cc line 976 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7ff72c00c990 created in file dict0dict.cc line 2737
a writer (thread id 140701151057664) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file btr0cur.cc line 1008
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
--Thread 140701153490688 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x367d3f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

--Thread 140701153220352 has waited at btr0cur.cc line 976 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7ff72c00c990 created in file dict0dict.cc line 2737
a writer (thread id 140701151057664) has reserved it in mode  SX
number of readers 0, waiters flag 1, lock_word: 10000000
Last time read locked in file btr0cur.cc line 1008
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
--Thread 140701668972288 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x367d3f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

OS WAIT ARRAY INFO: signal count 621742
RW-shared spins 0, rounds 47293, OS waits 4504
RW-excl spins 0, rounds 683188, OS waits 21184
RW-sx spins 6100, rounds 175400, OS waits 2962
Spin rounds per wait: 47293.00 RW-shared, 683188.00 RW-excl, 28.75 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 60524168
Purge done for trx's n:o < 60524121 undo n:o < 0 state: running
History list length 196
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 422186032399344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422186032380192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422186032375632, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 60524166, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 54, OS thread handle 140701451794176, query id 334309 192.168.1.10 sysbench
---TRANSACTION 60524164, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 37, OS thread handle 140701153761024, query id 334277 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=1549564
---TRANSACTION 60524163, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 61, OS thread handle 140701154031360, query id 334265 192.168.1.10 sysbench
---TRANSACTION 60524162, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 43, OS thread handle 140701152139008, query id 334272 192.168.1.10 sysbench updating
UPDATE sbtest11 SET c='28944341948-47224255133-33807086292-73871162078-08292049891-40629333402-23894483878-85785086231-78440327441-70297409540' WHERE id=1702816
---TRANSACTION 60524160, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 36, OS thread handle 140701154842368, query id 334314 192.168.1.10 sysbench
---TRANSACTION 60524159, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 60, OS thread handle 140701153490688, query id 334278 192.168.1.10 sysbench updating
DELETE FROM sbtest12 WHERE id=1731632
---TRANSACTION 60524157, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 48, OS thread handle 140701668972288, query id 334279 192.168.1.10 sysbench update
INSERT INTO sbtest15 (id, k, c, pad) VALUES (1503860, 1508874, '68686924367-69905470813-41797044098-77208326299-06050409605-52232384449-19787236268-16388589341-80912167194-66130960724', '98557283467-03331181678-36415095241-53282933602-67242691491')
---TRANSACTION 60524156, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 44, OS thread handle 140701151598336, query id 334321 192.168.1.10 sysbench starting
DELETE FROM sbtest12 WHERE id=?
---TRANSACTION 60524155, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 51, OS thread handle 140701155383040, query id 334317 192.168.1.10 sysbench
---TRANSACTION 60524154, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 59, OS thread handle 140701155923712, query id 334313 192.168.1.10 sysbench updating
DELETE FROM sbtest8 WHERE id=886237
---TRANSACTION 60524153, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 52, OS thread handle 140701451523840, query id 334306 192.168.1.10 sysbench
---TRANSACTION 60524152, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 63, OS thread handle 140701156464384, query id 334273 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (1492527, 1501567, '18299574012-66103977998-99708312590-74634575027-68307572398-68490838707-60907142325-86575364099-15973577582-34305981981', '89952092361-75462540764-65626447225-38982662937-27145209689')
---TRANSACTION 60524150, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 39, OS thread handle 140701154572032, query id 334303 192.168.1.10 sysbench
---TRANSACTION 60524149, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 40, OS thread handle 140701152409344, query id 334312 192.168.1.10 sysbench
---TRANSACTION 60524148, ACTIVE 0 sec
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 56, OS thread handle 140701452334848, query id 334310 192.168.1.10 sysbench
---TRANSACTION 60524147, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 55, OS thread handle 140701452605184, query id 334271 192.168.1.10 sysbench update
INSERT INTO sbtest20 (id, k, c, pad) VALUES (1495575, 1508604, '42320770099-20133394390-08086149191-84091660713-36131399420-88159990035-15808225612-75471927904-25864630093-27713993273', '66106002745-45963189825-69005183272-69074331071-64246359384')
---TRANSACTION 60524140, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 45, OS thread handle 140701151057664, query id 334268 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (1501792, 1497236, '77204198988-11932863656-22375492059-61807135803-86394602864-11061520064-36082132800-34366318796-14992727094-12975566183', '05856818209-47614445720-58109497496-29379988019-25486400361')
---TRANSACTION 60524139, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 66, OS thread handle 140701152950016, query id 334223 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=1506034
---TRANSACTION 60524138, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 57, OS thread handle 140701153220352, query id 334220 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=1502383
---TRANSACTION 60524137, ACTIVE 0 sec preparing
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 64, OS thread handle 140701155112704, query id 334320 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 60524136, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 67, OS thread handle 140701668701952, query id 334302 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 60524135, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 58, OS thread handle 140701668431616, query id 334299 192.168.1.10 sysbench
---TRANSACTION 60524134, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 49, OS thread handle 140701668161280, query id 334318 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 60524133, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 38, OS thread handle 140701154301696, query id 334311 192.168.1.10 sysbench
---TRANSACTION 60524125, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 46, OS thread handle 140701151328000, query id 334307 192.168.1.10 sysbench
---TRANSACTION 60524123, ACTIVE 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 50, OS thread handle 140701452064512, query id 334316 192.168.1.10 sysbench
---TRANSACTION 60524122, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 41, OS thread handle 140701152679680, query id 334292 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 60524121, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 53, OS thread handle 140701155653376, query id 334294 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 60524106, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 47, OS thread handle 140701151868672, query id 334308 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 60524105, ACTIVE 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 42, OS thread handle 140701156194048, query id 334322 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 60524100, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 65, OS thread handle 140701786855168, query id 334287 192.168.1.10 sysbench starting
COMMIT
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
Pending flushes (fsync) log: 1; buffer pool: 1
653456 OS file reads, 992722 OS file writes, 82644 OS fsyncs
1 pending preads, 0 pending pwrites
368.81 reads/s, 16384 avg bytes/read, 902.09 writes/s, 231.02 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 1 merges
merged operations:
 insert 0, delete mark 1, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365241, node heap has 0 buffer(s)
Hash table size 2365241, node heap has 0 buffer(s)
Hash table size 2365241, node heap has 0 buffer(s)
Hash table size 2365241, node heap has 0 buffer(s)
Hash table size 2365241, node heap has 0 buffer(s)
Hash table size 2365241, node heap has 0 buffer(s)
Hash table size 2365241, node heap has 0 buffer(s)
Hash table size 2365241, node heap has 0 buffer(s)
0.00 hash searches/s, 20897.03 non-hash searches/s
---
LOG
---
Log sequence number 480326088679
Log flushed up to   480325889261
Pages flushed up to 479501447035
Last checkpoint at  479499909860
1 pending log flushes, 0 pending chkp writes
10645 log i/o's done, 197.82 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 259676
Buffer pool size   524224
Free buffers       1780
Database pages     522444
Old database pages 192816
Modified db pages  105036
Pending reads      1
Pending writes: LRU 0, flush list 123, single page 0
Pages made young 101161, not young 575108
610.85 youngs/s, 1578.74 non-youngs/s
Pages read 650312, created 896356, written 906358
368.81 reads/s, 533.40 creates/s, 682.73 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 4 / 1000 not 12 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 522444, unzip_LRU len: 0
I/O sum[86964]:cur[5798], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       876
Database pages     261236
Old database pages 96414
Modified db pages  52782
Pending reads      1
Pending writes: LRU 0, flush list 28, single page 0
Pages made young 50514, not young 286010
306.11 youngs/s, 768.78 non-youngs/s
Pages read 324877, created 448361, written 452576
181.13 reads/s, 270.88 creates/s, 334.45 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 4 / 1000 not 12 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 261236, unzip_LRU len: 0
I/O sum[43482]:cur[2899], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       904
Database pages     261208
Old database pages 96402
Modified db pages  52254
Pending reads      0
Pending writes: LRU 0, flush list 95, single page 0
Pages made young 50647, not young 289098
304.74 youngs/s, 809.96 non-youngs/s
Pages read 325435, created 447995, written 453782
187.68 reads/s, 262.52 creates/s, 348.29 writes/s
Buffer pool hit rate 997 / 1000, young-making rate 4 / 1000 not 13 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 261208, unzip_LRU len: 0
I/O sum[43482]:cur[2899], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=5560, Main thread ID=140701796058880, state: sleeping
Number of rows inserted 60051310, updated 103034, deleted 51521, read 154698
1170.22 inserts/s, 2341.15 updates/s, 1170.41 deletes/s, 3511.65 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.01 sec)

ERROR: 
No query specified



