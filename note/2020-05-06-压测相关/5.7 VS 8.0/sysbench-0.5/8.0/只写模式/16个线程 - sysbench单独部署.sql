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

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench --mysql-password='' --mysql-db=sbtest --tables=20 --table-size=3000000 --threads=16 --time=1800 --report-interval=10 --db-driver=mysql prepare



purge binary logs to 'mysql-bin.000033';  



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


purge binary logs to 'mysql-bin.000044';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench \
--mysql-password='' --mysql-db=sbtest --tables=20 \
--table-size=3000000 --threads=16 --time=1800 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_16_11_vesion8.log &


[coding001@db-a ~]$ cat /home/coding001/log/sysbench_oltpX_16_11_vesion8.log
sysbench 1.0.20 (using bundled LuaJIT 2.1.0-beta2)

Running the test with following options:
Number of threads: 16
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 16 tps: 856.11 qps: 5144.15 (r/w/o: 0.00/3430.34/1713.82) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 16 tps: 898.74 qps: 5389.04 (r/w/o: 0.00/3591.66/1797.38) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 16 tps: 900.09 qps: 5402.62 (r/w/o: 0.00/3602.45/1800.17) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 16 tps: 907.10 qps: 5440.70 (r/w/o: 0.00/3626.60/1814.10) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 16 tps: 903.50 qps: 5423.32 (r/w/o: 0.00/3616.11/1807.21) lat (ms,95%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 16 tps: 928.61 qps: 5571.25 (r/w/o: 0.00/3714.03/1857.22) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 16 tps: 943.70 qps: 5663.80 (r/w/o: 0.00/3776.40/1887.40) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 16 tps: 747.30 qps: 4482.51 (r/w/o: 0.00/2987.91/1494.60) lat (ms,95%): 33.12 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 16 tps: 834.69 qps: 5009.05 (r/w/o: 0.00/3339.66/1669.38) lat (ms,95%): 31.37 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 16 tps: 946.00 qps: 5674.13 (r/w/o: 0.00/3782.32/1891.81) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 16 tps: 934.31 qps: 5607.75 (r/w/o: 0.00/3738.93/1868.82) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 16 tps: 960.09 qps: 5759.84 (r/w/o: 0.00/3839.66/1920.18) lat (ms,95%): 26.20 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 16 tps: 638.50 qps: 3828.03 (r/w/o: 0.00/2551.12/1276.91) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 16 tps: 587.10 qps: 3526.90 (r/w/o: 0.00/2352.60/1174.30) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 16 tps: 556.19 qps: 3337.14 (r/w/o: 0.00/2224.76/1112.38) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 16 tps: 596.51 qps: 3579.05 (r/w/o: 0.00/2386.03/1193.02) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 16 tps: 681.30 qps: 4087.81 (r/w/o: 0.00/2725.20/1362.60) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 16 tps: 692.98 qps: 4154.51 (r/w/o: 0.00/2768.54/1385.97) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 16 tps: 737.21 qps: 4423.13 (r/w/o: 0.00/2948.72/1474.41) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 16 tps: 780.01 qps: 4683.15 (r/w/o: 0.00/3123.13/1560.02) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 16 tps: 776.90 qps: 4660.79 (r/w/o: 0.00/3106.99/1553.80) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 16 tps: 763.20 qps: 4578.12 (r/w/o: 0.00/3051.71/1526.41) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 16 tps: 735.60 qps: 4415.72 (r/w/o: 0.00/2944.51/1471.21) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 16 tps: 617.91 qps: 3707.43 (r/w/o: 0.00/2471.62/1235.81) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 16 tps: 512.19 qps: 3069.86 (r/w/o: 0.00/2045.47/1024.39) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 16 tps: 522.00 qps: 3129.28 (r/w/o: 0.00/2085.29/1043.99) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 16 tps: 537.51 qps: 3231.04 (r/w/o: 0.00/2156.03/1075.01) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 16 tps: 563.79 qps: 3376.74 (r/w/o: 0.00/2250.36/1126.38) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 16 tps: 630.61 qps: 3789.66 (r/w/o: 0.00/2527.24/1262.42) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 16 tps: 663.18 qps: 3977.08 (r/w/o: 0.00/2651.12/1325.96) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 16 tps: 632.81 qps: 3795.27 (r/w/o: 0.00/2529.25/1266.02) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 16 tps: 640.61 qps: 3846.84 (r/w/o: 0.00/2565.62/1281.21) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 16 tps: 611.10 qps: 3666.90 (r/w/o: 0.00/2444.70/1222.20) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 16 tps: 555.19 qps: 3331.07 (r/w/o: 0.00/2220.68/1110.39) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 16 tps: 526.11 qps: 3150.33 (r/w/o: 0.00/2098.22/1052.11) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 16 tps: 499.70 qps: 3004.40 (r/w/o: 0.00/2004.90/999.50) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 16 tps: 522.50 qps: 3135.00 (r/w/o: 0.00/2090.00/1045.00) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 16 tps: 598.60 qps: 3591.92 (r/w/o: 0.00/2394.71/1197.21) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 16 tps: 630.00 qps: 3775.48 (r/w/o: 0.00/2515.49/1259.99) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 16 tps: 618.70 qps: 3714.60 (r/w/o: 0.00/2477.40/1237.20) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 16 tps: 633.20 qps: 3800.11 (r/w/o: 0.00/2533.60/1266.50) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 16 tps: 613.50 qps: 3682.19 (r/w/o: 0.00/2455.09/1227.10) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 16 tps: 532.90 qps: 3197.40 (r/w/o: 0.00/2131.60/1065.80) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 16 tps: 510.50 qps: 3062.61 (r/w/o: 0.00/2041.61/1021.00) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 16 tps: 652.10 qps: 3910.98 (r/w/o: 0.00/2606.79/1304.19) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 16 tps: 584.70 qps: 3503.68 (r/w/o: 0.00/2334.69/1168.99) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 16 tps: 616.41 qps: 3704.94 (r/w/o: 0.00/2471.72/1233.21) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 16 tps: 618.59 qps: 3710.52 (r/w/o: 0.00/2473.54/1236.97) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 16 tps: 630.61 qps: 3784.66 (r/w/o: 0.00/2523.24/1261.42) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 16 tps: 643.51 qps: 3861.03 (r/w/o: 0.00/2574.02/1287.01) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 16 tps: 606.69 qps: 3635.34 (r/w/o: 0.00/2421.96/1213.38) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 16 tps: 619.01 qps: 3718.37 (r/w/o: 0.00/2480.45/1237.92) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 16 tps: 619.69 qps: 3718.64 (r/w/o: 0.00/2479.16/1239.48) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 16 tps: 574.50 qps: 3446.82 (r/w/o: 0.00/2297.82/1149.01) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 16 tps: 535.10 qps: 3210.82 (r/w/o: 0.00/2140.61/1070.21) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 16 tps: 551.60 qps: 3309.28 (r/w/o: 0.00/2206.09/1103.19) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 16 tps: 588.20 qps: 3529.51 (r/w/o: 0.00/2353.11/1176.40) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 16 tps: 579.80 qps: 3478.48 (r/w/o: 0.00/2318.89/1159.59) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 16 tps: 579.69 qps: 3474.64 (r/w/o: 0.00/2315.26/1159.38) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 16 tps: 581.30 qps: 3491.61 (r/w/o: 0.00/2329.00/1162.60) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 16 tps: 588.21 qps: 3529.23 (r/w/o: 0.00/2352.82/1176.41) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 16 tps: 586.30 qps: 3517.82 (r/w/o: 0.00/2345.21/1172.61) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 16 tps: 599.20 qps: 3595.19 (r/w/o: 0.00/2396.79/1198.40) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 16 tps: 568.60 qps: 3411.58 (r/w/o: 0.00/2274.38/1137.19) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 16 tps: 610.70 qps: 3664.23 (r/w/o: 0.00/2442.82/1221.41) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 16 tps: 588.90 qps: 3533.12 (r/w/o: 0.00/2355.32/1177.81) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 16 tps: 555.10 qps: 3330.87 (r/w/o: 0.00/2220.68/1110.19) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 16 tps: 550.00 qps: 3300.03 (r/w/o: 0.00/2200.02/1100.01) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 16 tps: 584.50 qps: 3506.49 (r/w/o: 0.00/2337.59/1168.90) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 16 tps: 571.90 qps: 3430.39 (r/w/o: 0.00/2286.49/1143.90) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 16 tps: 623.00 qps: 3739.52 (r/w/o: 0.00/2493.51/1246.01) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 16 tps: 623.20 qps: 3738.79 (r/w/o: 0.00/2492.40/1246.40) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 16 tps: 618.58 qps: 3707.99 (r/w/o: 0.00/2470.83/1237.16) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 16 tps: 527.92 qps: 3170.89 (r/w/o: 0.00/2115.16/1055.73) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 16 tps: 730.80 qps: 4385.01 (r/w/o: 0.00/2923.31/1461.70) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 16 tps: 654.79 qps: 3928.96 (r/w/o: 0.00/2619.38/1309.59) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 16 tps: 592.80 qps: 3556.89 (r/w/o: 0.00/2371.29/1185.60) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 16 tps: 615.01 qps: 3689.84 (r/w/o: 0.00/2459.83/1230.01) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 16 tps: 633.20 qps: 3798.78 (r/w/o: 0.00/2532.38/1266.39) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 16 tps: 639.61 qps: 3837.64 (r/w/o: 0.00/2558.43/1279.21) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 16 tps: 652.39 qps: 3909.82 (r/w/o: 0.00/2605.05/1304.77) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 16 tps: 682.31 qps: 4098.83 (r/w/o: 0.00/2734.22/1364.61) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 16 tps: 693.21 qps: 4158.94 (r/w/o: 0.00/2772.52/1386.41) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 16 tps: 658.10 qps: 3948.80 (r/w/o: 0.00/2632.60/1316.20) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 16 tps: 590.29 qps: 3537.07 (r/w/o: 0.00/2356.48/1180.59) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 16 tps: 545.80 qps: 3277.41 (r/w/o: 0.00/2185.81/1091.60) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 16 tps: 555.40 qps: 3334.72 (r/w/o: 0.00/2223.91/1110.81) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 16 tps: 569.70 qps: 3418.20 (r/w/o: 0.00/2278.80/1139.40) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 16 tps: 627.60 qps: 3765.52 (r/w/o: 0.00/2510.31/1255.21) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 16 tps: 646.19 qps: 3877.27 (r/w/o: 0.00/2584.88/1292.39) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 16 tps: 643.80 qps: 3862.60 (r/w/o: 0.00/2575.00/1287.60) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 16 tps: 609.50 qps: 3657.19 (r/w/o: 0.00/2438.19/1219.00) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 16 tps: 571.29 qps: 3420.66 (r/w/o: 0.00/2279.48/1141.19) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 16 tps: 555.90 qps: 3341.98 (r/w/o: 0.00/2228.89/1113.09) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 16 tps: 566.51 qps: 3399.16 (r/w/o: 0.00/2266.04/1133.12) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 16 tps: 561.00 qps: 3366.31 (r/w/o: 0.00/2244.31/1122.00) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 16 tps: 645.50 qps: 3873.09 (r/w/o: 0.00/2582.09/1291.00) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 16 tps: 637.10 qps: 3822.42 (r/w/o: 0.00/2548.21/1274.21) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 16 tps: 606.40 qps: 3638.58 (r/w/o: 0.00/2425.78/1212.79) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 16 tps: 612.60 qps: 3675.60 (r/w/o: 0.00/2450.40/1225.20) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 16 tps: 569.40 qps: 3416.42 (r/w/o: 0.00/2277.61/1138.81) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 16 tps: 544.00 qps: 3264.00 (r/w/o: 0.00/2176.00/1088.00) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 16 tps: 536.79 qps: 3220.75 (r/w/o: 0.00/2147.17/1073.58) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 16 tps: 572.41 qps: 3434.46 (r/w/o: 0.00/2289.64/1144.82) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 16 tps: 630.19 qps: 3780.77 (r/w/o: 0.00/2520.38/1260.39) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 16 tps: 621.20 qps: 3727.63 (r/w/o: 0.00/2485.22/1242.41) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 16 tps: 626.60 qps: 3759.40 (r/w/o: 0.00/2506.20/1253.20) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 16 tps: 622.00 qps: 3732.19 (r/w/o: 0.00/2488.19/1244.00) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 16 tps: 624.80 qps: 3748.80 (r/w/o: 0.00/2499.20/1249.60) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 16 tps: 549.80 qps: 3297.69 (r/w/o: 0.00/2198.09/1099.60) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 16 tps: 691.59 qps: 4150.65 (r/w/o: 0.00/2767.46/1383.18) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 16 tps: 658.20 qps: 3949.22 (r/w/o: 0.00/2632.81/1316.41) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 16 tps: 747.30 qps: 4478.33 (r/w/o: 0.00/2984.52/1493.81) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 16 tps: 808.01 qps: 4853.54 (r/w/o: 0.00/3236.73/1616.81) lat (ms,95%): 36.24 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 16 tps: 699.38 qps: 4192.80 (r/w/o: 0.00/2794.03/1398.77) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 16 tps: 623.61 qps: 3744.68 (r/w/o: 0.00/2497.55/1247.13) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 16 tps: 593.60 qps: 3562.09 (r/w/o: 0.00/2374.79/1187.30) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 16 tps: 556.61 qps: 3339.63 (r/w/o: 0.00/2226.42/1113.21) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 16 tps: 648.90 qps: 3893.30 (r/w/o: 0.00/2595.50/1297.80) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 16 tps: 611.28 qps: 3665.80 (r/w/o: 0.00/2443.23/1222.57) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 16 tps: 632.92 qps: 3799.49 (r/w/o: 0.00/2533.66/1265.83) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 16 tps: 713.40 qps: 4280.39 (r/w/o: 0.00/2853.59/1426.80) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 16 tps: 698.10 qps: 4188.61 (r/w/o: 0.00/2792.40/1396.20) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 16 tps: 624.70 qps: 3748.19 (r/w/o: 0.00/2498.79/1249.40) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 16 tps: 679.19 qps: 4073.66 (r/w/o: 0.00/2715.27/1358.39) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 16 tps: 679.90 qps: 4080.69 (r/w/o: 0.00/2720.89/1359.80) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 16 tps: 634.51 qps: 3806.45 (r/w/o: 0.00/2537.43/1269.02) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 16 tps: 645.60 qps: 3873.38 (r/w/o: 0.00/2582.19/1291.19) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 16 tps: 659.20 qps: 3954.28 (r/w/o: 0.00/2635.89/1318.39) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 16 tps: 703.60 qps: 4222.81 (r/w/o: 0.00/2815.61/1407.20) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 16 tps: 695.81 qps: 4175.55 (r/w/o: 0.00/2783.93/1391.62) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 16 tps: 672.29 qps: 4029.82 (r/w/o: 0.00/2685.55/1344.27) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 16 tps: 622.41 qps: 3736.46 (r/w/o: 0.00/2491.44/1245.02) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 16 tps: 647.40 qps: 3881.99 (r/w/o: 0.00/2587.19/1294.80) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 16 tps: 606.50 qps: 3639.40 (r/w/o: 0.00/2426.30/1213.10) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 16 tps: 543.50 qps: 3264.82 (r/w/o: 0.00/2177.81/1087.01) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 16 tps: 597.60 qps: 3584.27 (r/w/o: 0.00/2389.08/1195.19) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 16 tps: 632.90 qps: 3795.50 (r/w/o: 0.00/2530.30/1265.20) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 16 tps: 642.71 qps: 3856.83 (r/w/o: 0.00/2570.82/1286.01) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 16 tps: 601.90 qps: 3614.09 (r/w/o: 0.00/2410.29/1203.80) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 16 tps: 577.40 qps: 3463.32 (r/w/o: 0.00/2308.51/1154.81) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 16 tps: 573.29 qps: 3439.74 (r/w/o: 0.00/2293.36/1146.38) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 16 tps: 603.40 qps: 3618.52 (r/w/o: 0.00/2411.51/1207.01) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 16 tps: 573.70 qps: 3444.28 (r/w/o: 0.00/2296.89/1147.39) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 16 tps: 588.71 qps: 3532.08 (r/w/o: 0.00/2354.66/1177.43) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 16 tps: 640.09 qps: 3840.25 (r/w/o: 0.00/2560.07/1280.18) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 16 tps: 659.10 qps: 3955.79 (r/w/o: 0.00/2637.59/1318.20) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 16 tps: 637.00 qps: 3819.23 (r/w/o: 0.00/2545.22/1274.01) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 16 tps: 549.20 qps: 3292.90 (r/w/o: 0.00/2194.70/1098.20) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 16 tps: 537.40 qps: 3227.19 (r/w/o: 0.00/2152.19/1075.00) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 16 tps: 574.40 qps: 3447.27 (r/w/o: 0.00/2298.48/1148.79) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 16 tps: 581.70 qps: 3490.72 (r/w/o: 0.00/2327.42/1163.31) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 16 tps: 596.10 qps: 3573.68 (r/w/o: 0.00/2381.58/1192.09) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 16 tps: 624.71 qps: 3752.26 (r/w/o: 0.00/2502.64/1249.62) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 16 tps: 605.89 qps: 3634.25 (r/w/o: 0.00/2422.47/1211.78) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 16 tps: 621.50 qps: 3729.10 (r/w/o: 0.00/2486.10/1243.00) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 16 tps: 573.10 qps: 3438.29 (r/w/o: 0.00/2292.29/1146.00) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 16 tps: 559.51 qps: 3356.63 (r/w/o: 0.00/2237.42/1119.21) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 16 tps: 593.30 qps: 3560.41 (r/w/o: 0.00/2373.91/1186.50) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 16 tps: 559.90 qps: 3359.37 (r/w/o: 0.00/2239.48/1119.89) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 16 tps: 601.19 qps: 3605.24 (r/w/o: 0.00/2402.86/1202.38) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 16 tps: 662.11 qps: 3973.67 (r/w/o: 0.00/2649.75/1323.92) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 16 tps: 660.50 qps: 3963.62 (r/w/o: 0.00/2642.32/1321.31) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 16 tps: 623.99 qps: 3741.24 (r/w/o: 0.00/2493.66/1247.58) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 16 tps: 554.30 qps: 3328.23 (r/w/o: 0.00/2219.22/1109.01) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 16 tps: 546.90 qps: 3280.10 (r/w/o: 0.00/2186.30/1093.80) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 16 tps: 565.70 qps: 3395.02 (r/w/o: 0.00/2263.91/1131.11) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 16 tps: 565.09 qps: 3387.85 (r/w/o: 0.00/2257.87/1129.98) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 16 tps: 619.21 qps: 3718.85 (r/w/o: 0.00/2480.13/1238.72) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 16 tps: 701.90 qps: 4212.23 (r/w/o: 0.00/2808.32/1403.91) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 16 tps: 699.90 qps: 4196.57 (r/w/o: 0.00/2796.68/1399.89) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 16 tps: 661.50 qps: 3969.82 (r/w/o: 0.00/2646.82/1323.01) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 16 tps: 562.50 qps: 3376.91 (r/w/o: 0.00/2251.91/1125.00) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 16 tps: 526.60 qps: 3160.08 (r/w/o: 0.00/2106.89/1053.19) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 16 tps: 647.61 qps: 3885.34 (r/w/o: 0.00/2590.13/1295.21) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 16 tps: 660.30 qps: 3961.17 (r/w/o: 0.00/2640.58/1320.59) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 16 tps: 675.60 qps: 4052.00 (r/w/o: 0.00/2700.90/1351.10) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 16 tps: 634.90 qps: 3810.82 (r/w/o: 0.00/2540.91/1269.91) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 16 tps: 681.80 qps: 4089.87 (r/w/o: 0.00/2726.58/1363.29) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 16 tps: 636.79 qps: 3821.36 (r/w/o: 0.00/2547.57/1273.79) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           4565684
        other:                           2282842
        total:                           6848526
    transactions:                        1141421 (634.12 per sec.)
    queries:                             6848526 (3804.69 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0197s
    total number of events:              1141421

Latency (ms):
         min:                                    8.69
         avg:                                   25.23
         max:                                 1366.90
         95th percentile:                       40.37
         sum:                             28795249.86

Threads fairness:
    events (avg/stddev):           71338.8125/658.63
    execution time (avg/stddev):   1799.7031/0.02



[coding001@voice ~]$ top
top - 11:55:26 up 97 days, 20:53,  4 users,  load average: 6.19, 6.51, 8.39
Tasks: 125 total,   1 running, 124 sleeping,   0 stopped,   0 zombie
%Cpu0  : 25.8 us, 11.1 sy,  0.0 ni, 40.5 id, 17.2 wa,  0.0 hi,  5.4 si,  0.0 st
%Cpu1  : 26.6 us, 10.4 sy,  0.0 ni, 42.9 id, 19.4 wa,  0.0 hi,  0.7 si,  0.0 st
%Cpu2  : 26.7 us,  9.0 sy,  0.0 ni, 43.1 id, 20.5 wa,  0.0 hi,  0.7 si,  0.0 st
%Cpu3  : 28.5 us,  8.3 sy,  0.0 ni, 44.4 id, 16.0 wa,  0.0 hi,  2.8 si,  0.0 st
KiB Mem : 16266300 total,   156528 free, 11741508 used,  4368264 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  3407712 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
32578 mysql     20   0   11.2g   9.4g   9780 S 164.0 60.5 599:24.97 mysqld         



[root@voice data]# iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.70    0.00    0.72    0.20    0.00   98.38

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              13.04       145.01       397.19 1226171802 3358675440

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          27.23    0.00   12.83   16.49    0.00   43.46

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3274.00      2048.00     49256.00       2048      49256

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          29.74    0.00   11.58   16.58    0.00   42.11

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3224.00      2208.00     49080.00       2208      49080

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          27.49    0.00   12.30   16.49    0.00   43.72

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3259.00      1792.00     49156.00       1792      49156

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          28.91    0.00   11.98   16.67    0.00   42.45

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3261.00      1888.00     49268.00       1888      49268



[root@voice data]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.23   10.82     0.14     0.39    83.10     0.10    7.66   23.46    4.40   0.48   0.63

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  104.00 3036.00     1.62    47.97    32.35     6.32    2.01    0.67    2.06   0.31  95.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  108.00 3021.00     1.69    48.10    32.59     6.61    2.11    0.78    2.16   0.30  95.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  116.00 3064.00     1.81    48.00    32.08     6.94    2.18    0.73    2.24   0.30  96.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  130.00 3034.00     2.03    47.98    32.37     6.65    2.10    0.71    2.16   0.31  97.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  124.00 2991.00     1.94    48.03    32.85     7.05    2.26    0.77    2.32   0.31  95.20


[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_16_11_vesion8.log
[ 10s ] thds: 16 tps: 856.11 qps: 5144.15 (r/w/o: 0.00/3430.34/1713.82) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 16 tps: 898.74 qps: 5389.04 (r/w/o: 0.00/3591.66/1797.38) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 16 tps: 900.09 qps: 5402.62 (r/w/o: 0.00/3602.45/1800.17) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 16 tps: 907.10 qps: 5440.70 (r/w/o: 0.00/3626.60/1814.10) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 16 tps: 903.50 qps: 5423.32 (r/w/o: 0.00/3616.11/1807.21) lat (ms,95%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 16 tps: 928.61 qps: 5571.25 (r/w/o: 0.00/3714.03/1857.22) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 16 tps: 943.70 qps: 5663.80 (r/w/o: 0.00/3776.40/1887.40) lat (ms,95%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 16 tps: 747.30 qps: 4482.51 (r/w/o: 0.00/2987.91/1494.60) lat (ms,95%): 33.12 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 16 tps: 834.69 qps: 5009.05 (r/w/o: 0.00/3339.66/1669.38) lat (ms,95%): 31.37 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 16 tps: 946.00 qps: 5674.13 (r/w/o: 0.00/3782.32/1891.81) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 16 tps: 934.31 qps: 5607.75 (r/w/o: 0.00/3738.93/1868.82) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 16 tps: 960.09 qps: 5759.84 (r/w/o: 0.00/3839.66/1920.18) lat (ms,95%): 26.20 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 16 tps: 638.50 qps: 3828.03 (r/w/o: 0.00/2551.12/1276.91) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 16 tps: 587.10 qps: 3526.90 (r/w/o: 0.00/2352.60/1174.30) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 16 tps: 556.19 qps: 3337.14 (r/w/o: 0.00/2224.76/1112.38) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 16 tps: 596.51 qps: 3579.05 (r/w/o: 0.00/2386.03/1193.02) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 16 tps: 681.30 qps: 4087.81 (r/w/o: 0.00/2725.20/1362.60) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 16 tps: 692.98 qps: 4154.51 (r/w/o: 0.00/2768.54/1385.97) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 16 tps: 737.21 qps: 4423.13 (r/w/o: 0.00/2948.72/1474.41) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 16 tps: 780.01 qps: 4683.15 (r/w/o: 0.00/3123.13/1560.02) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 16 tps: 776.90 qps: 4660.79 (r/w/o: 0.00/3106.99/1553.80) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 16 tps: 763.20 qps: 4578.12 (r/w/o: 0.00/3051.71/1526.41) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 16 tps: 735.60 qps: 4415.72 (r/w/o: 0.00/2944.51/1471.21) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 16 tps: 617.91 qps: 3707.43 (r/w/o: 0.00/2471.62/1235.81) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 16 tps: 512.19 qps: 3069.86 (r/w/o: 0.00/2045.47/1024.39) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 16 tps: 522.00 qps: 3129.28 (r/w/o: 0.00/2085.29/1043.99) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 16 tps: 537.51 qps: 3231.04 (r/w/o: 0.00/2156.03/1075.01) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 16 tps: 563.79 qps: 3376.74 (r/w/o: 0.00/2250.36/1126.38) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 16 tps: 630.61 qps: 3789.66 (r/w/o: 0.00/2527.24/1262.42) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 16 tps: 663.18 qps: 3977.08 (r/w/o: 0.00/2651.12/1325.96) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 16 tps: 632.81 qps: 3795.27 (r/w/o: 0.00/2529.25/1266.02) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 16 tps: 640.61 qps: 3846.84 (r/w/o: 0.00/2565.62/1281.21) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 16 tps: 611.10 qps: 3666.90 (r/w/o: 0.00/2444.70/1222.20) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 16 tps: 555.19 qps: 3331.07 (r/w/o: 0.00/2220.68/1110.39) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 16 tps: 526.11 qps: 3150.33 (r/w/o: 0.00/2098.22/1052.11) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 16 tps: 499.70 qps: 3004.40 (r/w/o: 0.00/2004.90/999.50) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 16 tps: 522.50 qps: 3135.00 (r/w/o: 0.00/2090.00/1045.00) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 16 tps: 598.60 qps: 3591.92 (r/w/o: 0.00/2394.71/1197.21) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 16 tps: 630.00 qps: 3775.48 (r/w/o: 0.00/2515.49/1259.99) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 16 tps: 618.70 qps: 3714.60 (r/w/o: 0.00/2477.40/1237.20) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 16 tps: 633.20 qps: 3800.11 (r/w/o: 0.00/2533.60/1266.50) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 16 tps: 613.50 qps: 3682.19 (r/w/o: 0.00/2455.09/1227.10) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 16 tps: 532.90 qps: 3197.40 (r/w/o: 0.00/2131.60/1065.80) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 16 tps: 510.50 qps: 3062.61 (r/w/o: 0.00/2041.61/1021.00) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 16 tps: 652.10 qps: 3910.98 (r/w/o: 0.00/2606.79/1304.19) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 16 tps: 584.70 qps: 3503.68 (r/w/o: 0.00/2334.69/1168.99) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 16 tps: 616.41 qps: 3704.94 (r/w/o: 0.00/2471.72/1233.21) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 16 tps: 618.59 qps: 3710.52 (r/w/o: 0.00/2473.54/1236.97) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 16 tps: 630.61 qps: 3784.66 (r/w/o: 0.00/2523.24/1261.42) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 16 tps: 643.51 qps: 3861.03 (r/w/o: 0.00/2574.02/1287.01) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 16 tps: 606.69 qps: 3635.34 (r/w/o: 0.00/2421.96/1213.38) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 16 tps: 619.01 qps: 3718.37 (r/w/o: 0.00/2480.45/1237.92) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 16 tps: 619.69 qps: 3718.64 (r/w/o: 0.00/2479.16/1239.48) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 16 tps: 574.50 qps: 3446.82 (r/w/o: 0.00/2297.82/1149.01) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 16 tps: 535.10 qps: 3210.82 (r/w/o: 0.00/2140.61/1070.21) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 16 tps: 551.60 qps: 3309.28 (r/w/o: 0.00/2206.09/1103.19) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 16 tps: 588.20 qps: 3529.51 (r/w/o: 0.00/2353.11/1176.40) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 16 tps: 579.80 qps: 3478.48 (r/w/o: 0.00/2318.89/1159.59) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 16 tps: 579.69 qps: 3474.64 (r/w/o: 0.00/2315.26/1159.38) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 16 tps: 581.30 qps: 3491.61 (r/w/o: 0.00/2329.00/1162.60) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 16 tps: 588.21 qps: 3529.23 (r/w/o: 0.00/2352.82/1176.41) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 16 tps: 586.30 qps: 3517.82 (r/w/o: 0.00/2345.21/1172.61) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 16 tps: 599.20 qps: 3595.19 (r/w/o: 0.00/2396.79/1198.40) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 16 tps: 568.60 qps: 3411.58 (r/w/o: 0.00/2274.38/1137.19) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 16 tps: 610.70 qps: 3664.23 (r/w/o: 0.00/2442.82/1221.41) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 16 tps: 588.90 qps: 3533.12 (r/w/o: 0.00/2355.32/1177.81) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 16 tps: 555.10 qps: 3330.87 (r/w/o: 0.00/2220.68/1110.19) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 16 tps: 550.00 qps: 3300.03 (r/w/o: 0.00/2200.02/1100.01) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 16 tps: 584.50 qps: 3506.49 (r/w/o: 0.00/2337.59/1168.90) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 16 tps: 571.90 qps: 3430.39 (r/w/o: 0.00/2286.49/1143.90) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 16 tps: 623.00 qps: 3739.52 (r/w/o: 0.00/2493.51/1246.01) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 16 tps: 623.20 qps: 3738.79 (r/w/o: 0.00/2492.40/1246.40) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 16 tps: 618.58 qps: 3707.99 (r/w/o: 0.00/2470.83/1237.16) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 16 tps: 527.92 qps: 3170.89 (r/w/o: 0.00/2115.16/1055.73) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 16 tps: 730.80 qps: 4385.01 (r/w/o: 0.00/2923.31/1461.70) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 16 tps: 654.79 qps: 3928.96 (r/w/o: 0.00/2619.38/1309.59) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 16 tps: 592.80 qps: 3556.89 (r/w/o: 0.00/2371.29/1185.60) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 16 tps: 615.01 qps: 3689.84 (r/w/o: 0.00/2459.83/1230.01) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 16 tps: 633.20 qps: 3798.78 (r/w/o: 0.00/2532.38/1266.39) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 16 tps: 639.61 qps: 3837.64 (r/w/o: 0.00/2558.43/1279.21) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 16 tps: 652.39 qps: 3909.82 (r/w/o: 0.00/2605.05/1304.77) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 16 tps: 682.31 qps: 4098.83 (r/w/o: 0.00/2734.22/1364.61) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 16 tps: 693.21 qps: 4158.94 (r/w/o: 0.00/2772.52/1386.41) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 16 tps: 658.10 qps: 3948.80 (r/w/o: 0.00/2632.60/1316.20) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 16 tps: 590.29 qps: 3537.07 (r/w/o: 0.00/2356.48/1180.59) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 16 tps: 545.80 qps: 3277.41 (r/w/o: 0.00/2185.81/1091.60) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 16 tps: 555.40 qps: 3334.72 (r/w/o: 0.00/2223.91/1110.81) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 16 tps: 569.70 qps: 3418.20 (r/w/o: 0.00/2278.80/1139.40) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 16 tps: 627.60 qps: 3765.52 (r/w/o: 0.00/2510.31/1255.21) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 16 tps: 646.19 qps: 3877.27 (r/w/o: 0.00/2584.88/1292.39) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 16 tps: 643.80 qps: 3862.60 (r/w/o: 0.00/2575.00/1287.60) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 16 tps: 609.50 qps: 3657.19 (r/w/o: 0.00/2438.19/1219.00) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 16 tps: 571.29 qps: 3420.66 (r/w/o: 0.00/2279.48/1141.19) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 16 tps: 555.90 qps: 3341.98 (r/w/o: 0.00/2228.89/1113.09) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 16 tps: 566.51 qps: 3399.16 (r/w/o: 0.00/2266.04/1133.12) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 16 tps: 561.00 qps: 3366.31 (r/w/o: 0.00/2244.31/1122.00) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 16 tps: 645.50 qps: 3873.09 (r/w/o: 0.00/2582.09/1291.00) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 16 tps: 637.10 qps: 3822.42 (r/w/o: 0.00/2548.21/1274.21) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 16 tps: 606.40 qps: 3638.58 (r/w/o: 0.00/2425.78/1212.79) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 16 tps: 612.60 qps: 3675.60 (r/w/o: 0.00/2450.40/1225.20) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 16 tps: 569.40 qps: 3416.42 (r/w/o: 0.00/2277.61/1138.81) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 16 tps: 544.00 qps: 3264.00 (r/w/o: 0.00/2176.00/1088.00) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 16 tps: 536.79 qps: 3220.75 (r/w/o: 0.00/2147.17/1073.58) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 16 tps: 572.41 qps: 3434.46 (r/w/o: 0.00/2289.64/1144.82) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 16 tps: 630.19 qps: 3780.77 (r/w/o: 0.00/2520.38/1260.39) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 16 tps: 621.20 qps: 3727.63 (r/w/o: 0.00/2485.22/1242.41) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 16 tps: 626.60 qps: 3759.40 (r/w/o: 0.00/2506.20/1253.20) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 16 tps: 622.00 qps: 3732.19 (r/w/o: 0.00/2488.19/1244.00) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 16 tps: 624.80 qps: 3748.80 (r/w/o: 0.00/2499.20/1249.60) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 16 tps: 549.80 qps: 3297.69 (r/w/o: 0.00/2198.09/1099.60) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 16 tps: 691.59 qps: 4150.65 (r/w/o: 0.00/2767.46/1383.18) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 16 tps: 658.20 qps: 3949.22 (r/w/o: 0.00/2632.81/1316.41) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 16 tps: 747.30 qps: 4478.33 (r/w/o: 0.00/2984.52/1493.81) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 16 tps: 808.01 qps: 4853.54 (r/w/o: 0.00/3236.73/1616.81) lat (ms,95%): 36.24 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 16 tps: 699.38 qps: 4192.80 (r/w/o: 0.00/2794.03/1398.77) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 16 tps: 623.61 qps: 3744.68 (r/w/o: 0.00/2497.55/1247.13) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 16 tps: 593.60 qps: 3562.09 (r/w/o: 0.00/2374.79/1187.30) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 16 tps: 556.61 qps: 3339.63 (r/w/o: 0.00/2226.42/1113.21) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 16 tps: 648.90 qps: 3893.30 (r/w/o: 0.00/2595.50/1297.80) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 16 tps: 611.28 qps: 3665.80 (r/w/o: 0.00/2443.23/1222.57) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 16 tps: 632.92 qps: 3799.49 (r/w/o: 0.00/2533.66/1265.83) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 16 tps: 713.40 qps: 4280.39 (r/w/o: 0.00/2853.59/1426.80) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 16 tps: 698.10 qps: 4188.61 (r/w/o: 0.00/2792.40/1396.20) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 16 tps: 624.70 qps: 3748.19 (r/w/o: 0.00/2498.79/1249.40) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 16 tps: 679.19 qps: 4073.66 (r/w/o: 0.00/2715.27/1358.39) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 16 tps: 679.90 qps: 4080.69 (r/w/o: 0.00/2720.89/1359.80) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 16 tps: 634.51 qps: 3806.45 (r/w/o: 0.00/2537.43/1269.02) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 16 tps: 645.60 qps: 3873.38 (r/w/o: 0.00/2582.19/1291.19) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 16 tps: 659.20 qps: 3954.28 (r/w/o: 0.00/2635.89/1318.39) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 16 tps: 703.60 qps: 4222.81 (r/w/o: 0.00/2815.61/1407.20) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 16 tps: 695.81 qps: 4175.55 (r/w/o: 0.00/2783.93/1391.62) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 16 tps: 672.29 qps: 4029.82 (r/w/o: 0.00/2685.55/1344.27) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 16 tps: 622.41 qps: 3736.46 (r/w/o: 0.00/2491.44/1245.02) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 16 tps: 647.40 qps: 3881.99 (r/w/o: 0.00/2587.19/1294.80) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 16 tps: 606.50 qps: 3639.40 (r/w/o: 0.00/2426.30/1213.10) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 16 tps: 543.50 qps: 3264.82 (r/w/o: 0.00/2177.81/1087.01) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 16 tps: 597.60 qps: 3584.27 (r/w/o: 0.00/2389.08/1195.19) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 16 tps: 632.90 qps: 3795.50 (r/w/o: 0.00/2530.30/1265.20) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 16 tps: 642.71 qps: 3856.83 (r/w/o: 0.00/2570.82/1286.01) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 16 tps: 601.90 qps: 3614.09 (r/w/o: 0.00/2410.29/1203.80) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 16 tps: 577.40 qps: 3463.32 (r/w/o: 0.00/2308.51/1154.81) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 16 tps: 573.29 qps: 3439.74 (r/w/o: 0.00/2293.36/1146.38) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 16 tps: 603.40 qps: 3618.52 (r/w/o: 0.00/2411.51/1207.01) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 16 tps: 573.70 qps: 3444.28 (r/w/o: 0.00/2296.89/1147.39) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 16 tps: 588.71 qps: 3532.08 (r/w/o: 0.00/2354.66/1177.43) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 16 tps: 640.09 qps: 3840.25 (r/w/o: 0.00/2560.07/1280.18) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 16 tps: 659.10 qps: 3955.79 (r/w/o: 0.00/2637.59/1318.20) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 16 tps: 637.00 qps: 3819.23 (r/w/o: 0.00/2545.22/1274.01) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 16 tps: 549.20 qps: 3292.90 (r/w/o: 0.00/2194.70/1098.20) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 16 tps: 537.40 qps: 3227.19 (r/w/o: 0.00/2152.19/1075.00) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 16 tps: 574.40 qps: 3447.27 (r/w/o: 0.00/2298.48/1148.79) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 16 tps: 581.70 qps: 3490.72 (r/w/o: 0.00/2327.42/1163.31) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 16 tps: 596.10 qps: 3573.68 (r/w/o: 0.00/2381.58/1192.09) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 16 tps: 624.71 qps: 3752.26 (r/w/o: 0.00/2502.64/1249.62) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 16 tps: 605.89 qps: 3634.25 (r/w/o: 0.00/2422.47/1211.78) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 16 tps: 621.50 qps: 3729.10 (r/w/o: 0.00/2486.10/1243.00) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 16 tps: 573.10 qps: 3438.29 (r/w/o: 0.00/2292.29/1146.00) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 16 tps: 559.51 qps: 3356.63 (r/w/o: 0.00/2237.42/1119.21) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 16 tps: 593.30 qps: 3560.41 (r/w/o: 0.00/2373.91/1186.50) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 16 tps: 559.90 qps: 3359.37 (r/w/o: 0.00/2239.48/1119.89) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 16 tps: 601.19 qps: 3605.24 (r/w/o: 0.00/2402.86/1202.38) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 16 tps: 662.11 qps: 3973.67 (r/w/o: 0.00/2649.75/1323.92) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 16 tps: 660.50 qps: 3963.62 (r/w/o: 0.00/2642.32/1321.31) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 16 tps: 623.99 qps: 3741.24 (r/w/o: 0.00/2493.66/1247.58) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 16 tps: 554.30 qps: 3328.23 (r/w/o: 0.00/2219.22/1109.01) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 16 tps: 546.90 qps: 3280.10 (r/w/o: 0.00/2186.30/1093.80) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 16 tps: 565.70 qps: 3395.02 (r/w/o: 0.00/2263.91/1131.11) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 16 tps: 565.09 qps: 3387.85 (r/w/o: 0.00/2257.87/1129.98) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 16 tps: 619.21 qps: 3718.85 (r/w/o: 0.00/2480.13/1238.72) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 16 tps: 701.90 qps: 4212.23 (r/w/o: 0.00/2808.32/1403.91) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 16 tps: 699.90 qps: 4196.57 (r/w/o: 0.00/2796.68/1399.89) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 16 tps: 661.50 qps: 3969.82 (r/w/o: 0.00/2646.82/1323.01) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 16 tps: 562.50 qps: 3376.91 (r/w/o: 0.00/2251.91/1125.00) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 16 tps: 526.60 qps: 3160.08 (r/w/o: 0.00/2106.89/1053.19) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 16 tps: 647.61 qps: 3885.34 (r/w/o: 0.00/2590.13/1295.21) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 16 tps: 660.30 qps: 3961.17 (r/w/o: 0.00/2640.58/1320.59) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 16 tps: 675.60 qps: 4052.00 (r/w/o: 0.00/2700.90/1351.10) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 16 tps: 634.90 qps: 3810.82 (r/w/o: 0.00/2540.91/1269.91) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 16 tps: 681.80 qps: 4089.87 (r/w/o: 0.00/2726.58/1363.29) lat (ms,95%): 38.94 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 16 tps: 636.79 qps: 3821.36 (r/w/o: 0.00/2547.57/1273.79) lat (ms,95%): 40.37 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           4565684
        other:                           2282842
        total:                           6848526
    transactions:                        1141421 (634.12 per sec.)
    queries:                             6848526 (3804.69 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0197s
    total number of events:              1141421

Latency (ms):
         min:                                    8.69
         avg:                                   25.23
         max:                                 1366.90
         95th percentile:                       40.37
         sum:                             28795249.86

Threads fairness:
    events (avg/stddev):           71338.8125/658.63
    execution time (avg/stddev):   1799.7031/0.02
