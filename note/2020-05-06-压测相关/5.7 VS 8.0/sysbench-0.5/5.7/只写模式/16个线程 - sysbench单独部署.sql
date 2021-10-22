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

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='' --mysql-db=sbtest --tables=20 --table-size=3000000 --threads=16 --time=1800 --report-interval=10 --db-driver=mysql prepare &



purge binary logs to 'mysql-bin.000210';  



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
--mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='' --mysql-db=sbtest --tables=20 \
--table-size=3000000 --threads=16 --time=1800 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_16_11_vesion7.log &


[coding001@db-a ~]$ tail -f  /home/coding001/log/sysbench_oltpX_16_11_vesion7.log
Number of threads: 16
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 16 tps: 873.29 qps: 5245.25 (r/w/o: 0.00/3497.26/1747.98) lat (ms,95%): 35.59 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 16 tps: 975.06 qps: 5852.74 (r/w/o: 0.00/3902.42/1950.31) lat (ms,95%): 30.26 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 16 tps: 997.80 qps: 5986.78 (r/w/o: 0.00/3991.19/1995.59) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 16 tps: 862.50 qps: 5170.70 (r/w/o: 0.00/3446.10/1724.60) lat (ms,95%): 33.72 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 16 tps: 925.51 qps: 5555.08 (r/w/o: 0.00/3703.75/1851.33) lat (ms,95%): 31.37 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 16 tps: 616.50 qps: 3700.98 (r/w/o: 0.00/2467.89/1233.09) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 16 tps: 226.20 qps: 1357.60 (r/w/o: 0.00/905.20/452.40) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 16 tps: 229.80 qps: 1378.79 (r/w/o: 0.00/919.19/459.60) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 16 tps: 236.70 qps: 1420.20 (r/w/o: 0.00/946.80/473.40) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 16 tps: 379.20 qps: 2269.89 (r/w/o: 0.00/1511.49/758.40) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 16 tps: 490.90 qps: 2950.71 (r/w/o: 0.00/1968.91/981.80) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 16 tps: 491.60 qps: 2949.18 (r/w/o: 0.00/1965.99/983.19) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 16 tps: 522.80 qps: 3135.40 (r/w/o: 0.00/2089.80/1045.60) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 16 tps: 539.81 qps: 3236.84 (r/w/o: 0.00/2157.23/1079.61) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 16 tps: 505.40 qps: 3036.17 (r/w/o: 0.00/2025.38/1010.79) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 16 tps: 418.00 qps: 2503.52 (r/w/o: 0.00/1667.51/836.01) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 16 tps: 383.30 qps: 2303.51 (r/w/o: 0.00/1536.91/766.60) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 16 tps: 423.80 qps: 2540.40 (r/w/o: 0.00/1692.80/847.60) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 16 tps: 508.80 qps: 3051.98 (r/w/o: 0.00/2034.39/1017.59) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 16 tps: 534.00 qps: 3202.59 (r/w/o: 0.00/2134.69/1067.90) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 16 tps: 547.80 qps: 3292.20 (r/w/o: 0.00/2196.50/1095.70) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 16 tps: 575.20 qps: 3451.22 (r/w/o: 0.00/2300.81/1150.41) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 16 tps: 553.29 qps: 3316.83 (r/w/o: 0.00/2210.26/1106.58) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 16 tps: 486.70 qps: 2918.92 (r/w/o: 0.00/1945.51/973.41) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 16 tps: 445.30 qps: 2671.62 (r/w/o: 0.00/1781.01/890.61) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 16 tps: 459.80 qps: 2758.21 (r/w/o: 0.00/1838.61/919.60) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 16 tps: 472.00 qps: 2833.11 (r/w/o: 0.00/1889.11/944.00) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 16 tps: 515.90 qps: 3095.60 (r/w/o: 0.00/2063.80/1031.80) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 16 tps: 571.10 qps: 3430.30 (r/w/o: 0.00/2288.10/1142.20) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 16 tps: 626.80 qps: 3760.78 (r/w/o: 0.00/2507.19/1253.59) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 16 tps: 620.60 qps: 3718.59 (r/w/o: 0.00/2477.39/1241.20) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 16 tps: 606.60 qps: 3639.61 (r/w/o: 0.00/2426.41/1213.20) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 16 tps: 521.20 qps: 3128.18 (r/w/o: 0.00/2085.78/1042.39) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 16 tps: 483.80 qps: 2906.81 (r/w/o: 0.00/1939.20/967.60) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 16 tps: 515.20 qps: 3085.58 (r/w/o: 0.00/2055.48/1030.09) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 16 tps: 524.19 qps: 3144.95 (r/w/o: 0.00/2096.27/1048.68) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 16 tps: 540.32 qps: 3244.30 (r/w/o: 0.00/2163.67/1080.63) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 16 tps: 576.50 qps: 3458.80 (r/w/o: 0.00/2305.80/1153.00) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 16 tps: 682.00 qps: 4091.88 (r/w/o: 0.00/2727.89/1363.99) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 16 tps: 667.60 qps: 4009.28 (r/w/o: 0.00/2674.09/1335.19) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 16 tps: 610.60 qps: 3663.63 (r/w/o: 0.00/2442.42/1221.21) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 16 tps: 581.20 qps: 3487.21 (r/w/o: 0.00/2324.81/1162.40) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 16 tps: 537.09 qps: 3222.37 (r/w/o: 0.00/2148.18/1074.19) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 16 tps: 546.40 qps: 3274.50 (r/w/o: 0.00/2181.70/1092.80) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 16 tps: 562.51 qps: 3375.83 (r/w/o: 0.00/2250.82/1125.01) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 16 tps: 538.89 qps: 3236.07 (r/w/o: 0.00/2158.28/1077.79) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 16 tps: 584.41 qps: 3501.94 (r/w/o: 0.00/2333.13/1168.81) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 16 tps: 675.49 qps: 4058.05 (r/w/o: 0.00/2707.07/1350.98) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 16 tps: 708.28 qps: 4245.56 (r/w/o: 0.00/2829.01/1416.55) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 16 tps: 678.23 qps: 4073.46 (r/w/o: 0.00/2717.01/1356.45) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 16 tps: 648.99 qps: 3893.47 (r/w/o: 0.00/2595.58/1297.89) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 16 tps: 568.70 qps: 3412.31 (r/w/o: 0.00/2274.81/1137.50) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 16 tps: 567.30 qps: 3399.71 (r/w/o: 0.00/2265.11/1134.60) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 16 tps: 572.40 qps: 3438.80 (r/w/o: 0.00/2294.00/1144.80) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 16 tps: 612.80 qps: 3672.10 (r/w/o: 0.00/2446.50/1225.60) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 16 tps: 576.40 qps: 3459.42 (r/w/o: 0.00/2306.62/1152.81) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 16 tps: 575.30 qps: 3455.57 (r/w/o: 0.00/2304.98/1150.59) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 16 tps: 722.00 qps: 4326.60 (r/w/o: 0.00/2882.60/1444.00) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 16 tps: 742.60 qps: 4457.11 (r/w/o: 0.00/2971.90/1485.20) lat (ms,95%): 73.13 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 16 tps: 700.80 qps: 4203.10 (r/w/o: 0.00/2801.50/1401.60) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 16 tps: 667.50 qps: 4010.62 (r/w/o: 0.00/2675.61/1335.01) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 16 tps: 570.80 qps: 3424.80 (r/w/o: 0.00/2283.20/1141.60) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 16 tps: 576.80 qps: 3456.19 (r/w/o: 0.00/2302.60/1153.60) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 16 tps: 631.70 qps: 3788.70 (r/w/o: 0.00/2525.30/1263.40) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 16 tps: 630.50 qps: 3784.00 (r/w/o: 0.00/2523.00/1261.00) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 16 tps: 647.10 qps: 3881.30 (r/w/o: 0.00/2587.10/1294.20) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 16 tps: 618.60 qps: 3714.39 (r/w/o: 0.00/2477.20/1237.20) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 16 tps: 729.10 qps: 4377.81 (r/w/o: 0.00/2919.61/1458.20) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 16 tps: 770.10 qps: 4618.10 (r/w/o: 0.00/3077.90/1540.20) lat (ms,95%): 70.55 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 16 tps: 741.41 qps: 4447.13 (r/w/o: 0.00/2964.32/1482.81) lat (ms,95%): 69.29 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 16 tps: 659.99 qps: 3964.07 (r/w/o: 0.00/2644.08/1319.99) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 16 tps: 640.01 qps: 3839.94 (r/w/o: 0.00/2559.93/1280.01) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 16 tps: 571.20 qps: 3422.29 (r/w/o: 0.00/2279.89/1142.40) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 16 tps: 644.60 qps: 3870.17 (r/w/o: 0.00/2580.98/1289.19) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 16 tps: 628.60 qps: 3774.13 (r/w/o: 0.00/2516.92/1257.21) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 16 tps: 665.69 qps: 3992.46 (r/w/o: 0.00/2661.07/1331.39) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 16 tps: 634.00 qps: 3801.53 (r/w/o: 0.00/2533.52/1268.01) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 16 tps: 732.80 qps: 4400.98 (r/w/o: 0.00/2935.39/1465.59) lat (ms,95%): 70.55 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 16 tps: 786.40 qps: 4718.42 (r/w/o: 0.00/3145.61/1572.81) lat (ms,95%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 16 tps: 791.70 qps: 4749.80 (r/w/o: 0.00/3166.40/1583.40) lat (ms,95%): 66.84 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 16 tps: 704.30 qps: 4220.82 (r/w/o: 0.00/2812.21/1408.61) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 16 tps: 671.00 qps: 4029.28 (r/w/o: 0.00/2687.29/1341.99) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 16 tps: 617.80 qps: 3703.81 (r/w/o: 0.00/2468.50/1235.30) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 16 tps: 666.10 qps: 4001.69 (r/w/o: 0.00/2669.19/1332.50) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 16 tps: 616.60 qps: 3699.61 (r/w/o: 0.00/2466.41/1233.20) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 16 tps: 672.30 qps: 4033.79 (r/w/o: 0.00/2689.19/1344.60) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 16 tps: 665.21 qps: 3991.24 (r/w/o: 0.00/2660.82/1330.41) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 16 tps: 707.40 qps: 4244.38 (r/w/o: 0.00/2829.59/1414.79) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 16 tps: 781.70 qps: 4685.41 (r/w/o: 0.00/3122.01/1563.40) lat (ms,95%): 70.55 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 16 tps: 792.10 qps: 4757.41 (r/w/o: 0.00/3173.20/1584.20) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 16 tps: 790.89 qps: 4739.56 (r/w/o: 0.00/3158.18/1581.39) lat (ms,95%): 66.84 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 16 tps: 736.00 qps: 4421.80 (r/w/o: 0.00/2949.40/1472.40) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 16 tps: 637.70 qps: 3820.61 (r/w/o: 0.00/2545.21/1275.40) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 16 tps: 638.30 qps: 3830.01 (r/w/o: 0.00/2553.41/1276.60) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 16 tps: 713.70 qps: 4283.10 (r/w/o: 0.00/2855.70/1427.40) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 16 tps: 615.79 qps: 3698.44 (r/w/o: 0.00/2466.86/1231.58) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 16 tps: 710.21 qps: 4257.65 (r/w/o: 0.00/2837.23/1420.42) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 16 tps: 689.30 qps: 4134.10 (r/w/o: 0.00/2755.50/1378.60) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 16 tps: 753.00 qps: 4519.21 (r/w/o: 0.00/3013.21/1506.00) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 16 tps: 819.49 qps: 4921.87 (r/w/o: 0.00/3282.88/1638.99) lat (ms,95%): 63.32 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 16 tps: 814.31 qps: 4882.04 (r/w/o: 0.00/3253.42/1628.61) lat (ms,95%): 69.29 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 16 tps: 806.21 qps: 4836.03 (r/w/o: 0.00/3223.62/1612.41) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 16 tps: 709.49 qps: 4261.97 (r/w/o: 0.00/2842.98/1418.99) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 16 tps: 634.79 qps: 3807.37 (r/w/o: 0.00/2537.78/1269.59) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 16 tps: 681.60 qps: 4091.03 (r/w/o: 0.00/2727.82/1363.21) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 16 tps: 690.50 qps: 4137.22 (r/w/o: 0.00/2756.22/1381.01) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 16 tps: 658.80 qps: 3957.59 (r/w/o: 0.00/2639.99/1317.60) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 16 tps: 712.90 qps: 4274.62 (r/w/o: 0.00/2848.81/1425.81) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 16 tps: 736.30 qps: 4417.28 (r/w/o: 0.00/2944.68/1472.59) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 16 tps: 803.89 qps: 4827.66 (r/w/o: 0.00/3219.88/1607.79) lat (ms,95%): 69.29 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 16 tps: 827.91 qps: 4963.17 (r/w/o: 0.00/3307.35/1655.82) lat (ms,95%): 64.47 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 16 tps: 805.00 qps: 4834.31 (r/w/o: 0.00/3224.30/1610.00) lat (ms,95%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 16 tps: 802.99 qps: 4813.92 (r/w/o: 0.00/3207.95/1605.97) lat (ms,95%): 70.55 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 16 tps: 735.60 qps: 4414.70 (r/w/o: 0.00/2943.50/1471.20) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 16 tps: 659.80 qps: 3956.13 (r/w/o: 0.00/2636.52/1319.61) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 16 tps: 719.60 qps: 4318.02 (r/w/o: 0.00/2878.81/1439.21) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 16 tps: 666.20 qps: 3998.40 (r/w/o: 0.00/2666.00/1332.40) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 16 tps: 662.60 qps: 3974.20 (r/w/o: 0.00/2649.00/1325.20) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 16 tps: 725.70 qps: 4359.61 (r/w/o: 0.00/2908.20/1451.40) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 16 tps: 766.70 qps: 4596.62 (r/w/o: 0.00/3063.22/1533.41) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 16 tps: 820.47 qps: 4922.55 (r/w/o: 0.00/3282.30/1640.25) lat (ms,95%): 69.29 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 16 tps: 840.32 qps: 5045.82 (r/w/o: 0.00/3364.48/1681.34) lat (ms,95%): 61.08 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 16 tps: 824.69 qps: 4944.13 (r/w/o: 0.00/3294.76/1649.38) lat (ms,95%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 16 tps: 787.81 qps: 4730.84 (r/w/o: 0.00/3155.23/1575.61) lat (ms,95%): 73.13 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 16 tps: 749.61 qps: 4497.63 (r/w/o: 0.00/2998.42/1499.21) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 16 tps: 677.90 qps: 4067.40 (r/w/o: 0.00/2711.60/1355.80) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 16 tps: 735.10 qps: 4410.58 (r/w/o: 0.00/2940.39/1470.19) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 16 tps: 687.98 qps: 4127.40 (r/w/o: 0.00/2751.54/1375.87) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 16 tps: 688.72 qps: 4132.80 (r/w/o: 0.00/2755.27/1377.53) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 16 tps: 780.19 qps: 4677.83 (r/w/o: 0.00/3117.45/1560.38) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 16 tps: 786.72 qps: 4723.59 (r/w/o: 0.00/3150.16/1573.43) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 16 tps: 854.99 qps: 5129.94 (r/w/o: 0.00/3419.96/1709.98) lat (ms,95%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 16 tps: 848.81 qps: 5087.85 (r/w/o: 0.00/3390.24/1697.62) lat (ms,95%): 70.55 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 16 tps: 818.40 qps: 4915.37 (r/w/o: 0.00/3278.58/1636.79) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 16 tps: 795.30 qps: 4771.81 (r/w/o: 0.00/3181.21/1590.60) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 16 tps: 746.30 qps: 4477.18 (r/w/o: 0.00/2984.59/1492.59) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 16 tps: 691.91 qps: 4147.74 (r/w/o: 0.00/2763.93/1383.81) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 16 tps: 751.40 qps: 4512.68 (r/w/o: 0.00/3009.89/1502.79) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 16 tps: 680.30 qps: 4081.81 (r/w/o: 0.00/2721.20/1360.60) lat (ms,95%): 82.96 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 16 tps: 721.50 qps: 4325.60 (r/w/o: 0.00/2882.60/1443.00) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 16 tps: 728.69 qps: 4370.43 (r/w/o: 0.00/2913.26/1457.18) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 16 tps: 731.51 qps: 4389.36 (r/w/o: 0.00/2926.14/1463.22) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 16 tps: 846.10 qps: 5081.39 (r/w/o: 0.00/3389.19/1692.20) lat (ms,95%): 69.29 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 16 tps: 838.71 qps: 5032.23 (r/w/o: 0.00/3354.82/1677.41) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 16 tps: 839.89 qps: 5039.37 (r/w/o: 0.00/3359.58/1679.79) lat (ms,95%): 71.83 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 16 tps: 809.51 qps: 4857.05 (r/w/o: 0.00/3238.03/1619.02) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 16 tps: 814.99 qps: 4884.82 (r/w/o: 0.00/3254.85/1629.97) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 16 tps: 764.91 qps: 4590.34 (r/w/o: 0.00/3060.53/1529.81) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 16 tps: 755.19 qps: 4529.76 (r/w/o: 0.00/3019.67/1510.09) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 16 tps: 710.60 qps: 4269.21 (r/w/o: 0.00/2847.71/1421.50) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 16 tps: 720.10 qps: 4320.62 (r/w/o: 0.00/2880.41/1440.21) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 16 tps: 734.40 qps: 4402.91 (r/w/o: 0.00/2934.11/1468.80) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 16 tps: 798.80 qps: 4792.13 (r/w/o: 0.00/3194.52/1597.61) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 16 tps: 842.19 qps: 5057.36 (r/w/o: 0.00/3372.97/1684.39) lat (ms,95%): 64.47 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 16 tps: 856.60 qps: 5139.62 (r/w/o: 0.00/3426.41/1713.21) lat (ms,95%): 65.65 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 16 tps: 836.00 qps: 5015.99 (r/w/o: 0.00/3344.00/1672.00) lat (ms,95%): 71.83 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 16 tps: 815.10 qps: 4890.07 (r/w/o: 0.00/3259.98/1630.09) lat (ms,95%): 69.29 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 16 tps: 814.10 qps: 4881.47 (r/w/o: 0.00/3253.18/1628.29) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 16 tps: 807.51 qps: 4848.65 (r/w/o: 0.00/3233.63/1615.02) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 16 tps: 737.90 qps: 4424.29 (r/w/o: 0.00/2948.49/1475.80) lat (ms,95%): 66.84 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 16 tps: 757.10 qps: 4540.02 (r/w/o: 0.00/3025.82/1514.21) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 16 tps: 705.20 qps: 4236.90 (r/w/o: 0.00/2826.50/1410.40) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 16 tps: 778.60 qps: 4667.77 (r/w/o: 0.00/3110.58/1557.19) lat (ms,95%): 75.82 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 16 tps: 753.30 qps: 4523.20 (r/w/o: 0.00/3016.60/1506.60) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 16 tps: 808.90 qps: 4853.82 (r/w/o: 0.00/3236.01/1617.81) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 16 tps: 843.50 qps: 5061.01 (r/w/o: 0.00/3374.01/1687.00) lat (ms,95%): 70.55 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 16 tps: 837.50 qps: 5024.51 (r/w/o: 0.00/3349.61/1674.90) lat (ms,95%): 66.84 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 16 tps: 845.50 qps: 5069.49 (r/w/o: 0.00/3378.39/1691.10) lat (ms,95%): 73.13 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 16 tps: 818.11 qps: 4906.94 (r/w/o: 0.00/3270.72/1636.21) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 16 tps: 825.79 qps: 4955.53 (r/w/o: 0.00/3303.96/1651.58) lat (ms,95%): 73.13 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 16 tps: 757.80 qps: 4551.72 (r/w/o: 0.00/3036.12/1515.61) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 16 tps: 800.01 qps: 4800.04 (r/w/o: 0.00/3200.02/1600.01) lat (ms,95%): 74.46 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 16 tps: 757.19 qps: 4543.16 (r/w/o: 0.00/3028.77/1514.39) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 16 tps: 718.50 qps: 4307.13 (r/w/o: 0.00/2870.22/1436.91) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 16 tps: 769.00 qps: 4617.89 (r/w/o: 0.00/3079.80/1538.10) lat (ms,95%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 16 tps: 803.09 qps: 4814.74 (r/w/o: 0.00/3208.56/1606.18) lat (ms,95%): 77.19 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 16 tps: 849.01 qps: 5097.85 (r/w/o: 0.00/3399.83/1698.02) lat (ms,95%): 66.84 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 16 tps: 841.10 qps: 5046.58 (r/w/o: 0.00/3364.39/1682.19) lat (ms,95%): 65.65 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 16 tps: 864.20 qps: 5177.98 (r/w/o: 0.00/3450.89/1727.09) lat (ms,95%): 65.65 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 16 tps: 815.01 qps: 4897.23 (r/w/o: 0.00/3265.92/1631.31) lat (ms,95%): 69.29 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           4937720
        other:                           2468860
        total:                           7406580
    transactions:                        1234430 (685.78 per sec.)
    queries:                             7406580 (4114.69 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0339s
    total number of events:              1234430

Latency (ms):
         min:                                    7.57
         avg:                                   23.33
         max:                                  266.06
         95th percentile:                       81.48
         sum:                             28795691.89

Threads fairness:
    events (avg/stddev):           77151.8750/282.84
    execution time (avg/stddev):   1799.7307/0.01



[root@voice mysql3307]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.25   11.38     0.14     0.41    82.44     0.11    8.32   23.56    5.31   0.48   0.66

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  218.00 1095.00    14.68    47.96    97.71     3.25    2.46    2.23    2.50   0.71  93.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00  235.00 1112.00    11.12    48.06    89.99     3.15    2.35    1.34    2.56   0.70  94.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  336.00 1086.00    17.53    48.02    94.41     3.22    2.29    1.76    2.45   0.66  93.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  320.00 1148.00    17.17    51.98    96.47     3.56    2.43    1.79    2.60   0.64  94.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  208.00 1072.00    11.28    48.11    95.03     2.90    2.22    1.54    2.36   0.72  92.60

^C
[root@voice mysql3307]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.71    0.00    0.72    0.20    0.00   98.37

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              13.63       146.07       415.65 1236454094 3518269660

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          21.24    0.00   11.66   24.35    0.00   42.75

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1238.00      8800.00     49492.00       8800      49492

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          21.71    0.00   14.47   24.81    0.00   39.02

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1375.00     18192.00     53128.00      18192      53128

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          22.56    0.00   13.85   22.82    0.00   40.77

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1245.00      6240.00     49172.00       6240      49172

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          19.54    0.00   11.05   26.48    0.00   42.93

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1114.00      7632.00     49188.00       7632      49188
