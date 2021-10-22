mysql> show global variables like '%innodb_adaptive_hash_index%';
+----------------------------------+-------+
| Variable_name                    | Value |
+----------------------------------+-------+
| innodb_adaptive_hash_index       | ON    |
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



purge binary logs to 'mysql-bin.000234';  



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
--table-size=3000000 --threads=32 --time=1800 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_32_11_vesion7.log &


[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_32_11_vesion7.log


Initializing worker threads...

Threads started!

[ 10s ] thds: 32 tps: 1694.38 qps: 10176.79 (r/w/o: 0.00/6785.13/3391.66) lat (ms,95%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 32 tps: 1747.99 qps: 10491.46 (r/w/o: 0.00/6995.17/3496.29) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 32 tps: 1795.81 qps: 10773.46 (r/w/o: 0.00/7182.24/3591.22) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 32 tps: 1081.09 qps: 6479.55 (r/w/o: 0.00/4316.96/2162.58) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00

[ 50s ] thds: 32 tps: 385.31 qps: 2314.84 (r/w/o: 0.00/1544.22/770.61) lat (ms,95%): 127.81 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 32 tps: 418.99 qps: 2514.85 (r/w/o: 0.00/1676.87/837.98) lat (ms,95%): 116.80 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 32 tps: 427.81 qps: 2573.34 (r/w/o: 0.00/1717.73/855.61) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 32 tps: 439.20 qps: 2623.80 (r/w/o: 0.00/1745.60/878.20) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 32 tps: 440.10 qps: 2640.98 (r/w/o: 0.00/1760.68/880.29) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 32 tps: 441.99 qps: 2656.15 (r/w/o: 0.00/1772.06/884.08) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 32 tps: 452.41 qps: 2712.38 (r/w/o: 0.00/1807.55/904.83) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 32 tps: 450.30 qps: 2710.71 (r/w/o: 0.00/1810.10/900.60) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 32 tps: 448.89 qps: 2685.55 (r/w/o: 0.00/1787.77/897.78) lat (ms,95%): 114.72 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 32 tps: 449.31 qps: 2697.24 (r/w/o: 0.00/1798.63/898.61) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 32 tps: 449.80 qps: 2705.22 (r/w/o: 0.00/1805.61/899.61) lat (ms,95%): 112.67 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 32 tps: 467.90 qps: 2797.68 (r/w/o: 0.00/1861.89/935.79) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 32 tps: 541.00 qps: 3254.28 (r/w/o: 0.00/2172.28/1081.99) lat (ms,95%): 102.97 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 32 tps: 654.41 qps: 3927.55 (r/w/o: 0.00/2618.73/1308.82) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 32 tps: 621.90 qps: 3723.28 (r/w/o: 0.00/2479.48/1243.79) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 32 tps: 555.20 qps: 3328.81 (r/w/o: 0.00/2218.41/1110.40) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 32 tps: 520.80 qps: 3128.60 (r/w/o: 0.00/2087.00/1041.60) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 32 tps: 519.50 qps: 3114.61 (r/w/o: 0.00/2075.61/1039.00) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 32 tps: 515.30 qps: 3092.78 (r/w/o: 0.00/2062.18/1030.59) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 32 tps: 538.90 qps: 3234.30 (r/w/o: 0.00/2156.50/1077.80) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 32 tps: 550.00 qps: 3307.03 (r/w/o: 0.00/2207.02/1100.01) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 32 tps: 567.39 qps: 3394.62 (r/w/o: 0.00/2259.85/1134.77) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 32 tps: 604.21 qps: 3635.48 (r/w/o: 0.00/2427.05/1208.43) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 32 tps: 628.70 qps: 3772.22 (r/w/o: 0.00/2514.81/1257.41) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 32 tps: 636.30 qps: 3810.17 (r/w/o: 0.00/2537.58/1272.59) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 32 tps: 588.50 qps: 3531.51 (r/w/o: 0.00/2354.51/1177.00) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 32 tps: 572.29 qps: 3428.85 (r/w/o: 0.00/2284.27/1144.58) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 32 tps: 588.31 qps: 3531.85 (r/w/o: 0.00/2355.23/1176.62) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 32 tps: 596.89 qps: 3580.23 (r/w/o: 0.00/2386.45/1193.78) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 32 tps: 614.21 qps: 3686.55 (r/w/o: 0.00/2458.24/1228.32) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 32 tps: 560.10 qps: 3370.11 (r/w/o: 0.00/2249.81/1120.30) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 32 tps: 586.60 qps: 3519.88 (r/w/o: 0.00/2346.69/1173.19) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 32 tps: 619.01 qps: 3713.24 (r/w/o: 0.00/2475.22/1238.01) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 32 tps: 664.69 qps: 3980.96 (r/w/o: 0.00/2651.57/1329.39) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 32 tps: 630.70 qps: 3791.88 (r/w/o: 0.00/2530.49/1261.39) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 32 tps: 598.10 qps: 3575.09 (r/w/o: 0.00/2379.89/1195.20) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 32 tps: 618.51 qps: 3724.34 (r/w/o: 0.00/2486.43/1237.91) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 32 tps: 642.70 qps: 3856.73 (r/w/o: 0.00/2571.22/1285.51) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 32 tps: 632.10 qps: 3783.98 (r/w/o: 0.00/2519.78/1264.19) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 32 tps: 605.69 qps: 3638.94 (r/w/o: 0.00/2427.56/1211.38) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 32 tps: 680.71 qps: 4088.07 (r/w/o: 0.00/2726.65/1361.42) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 32 tps: 659.20 qps: 3955.21 (r/w/o: 0.00/2636.80/1318.40) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 32 tps: 664.40 qps: 3986.41 (r/w/o: 0.00/2657.61/1328.80) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 32 tps: 635.10 qps: 3810.18 (r/w/o: 0.00/2539.99/1270.19) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 32 tps: 652.69 qps: 3913.45 (r/w/o: 0.00/2608.07/1305.38) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 32 tps: 648.19 qps: 3891.94 (r/w/o: 0.00/2595.56/1296.38) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 32 tps: 637.02 qps: 3822.42 (r/w/o: 0.00/2548.38/1274.04) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 32 tps: 662.00 qps: 3972.01 (r/w/o: 0.00/2648.00/1324.00) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 32 tps: 632.49 qps: 3794.96 (r/w/o: 0.00/2529.98/1264.99) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 32 tps: 645.00 qps: 3869.63 (r/w/o: 0.00/2579.62/1290.01) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 32 tps: 734.60 qps: 4408.00 (r/w/o: 0.00/2938.80/1469.20) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 32 tps: 662.70 qps: 3976.20 (r/w/o: 0.00/2650.80/1325.40) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 32 tps: 701.80 qps: 4210.78 (r/w/o: 0.00/2807.19/1403.59) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 32 tps: 722.60 qps: 4335.52 (r/w/o: 0.00/2890.32/1445.21) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 32 tps: 656.50 qps: 3933.60 (r/w/o: 0.00/2620.60/1313.00) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 32 tps: 685.60 qps: 4119.09 (r/w/o: 0.00/2747.89/1371.20) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 32 tps: 685.61 qps: 4113.64 (r/w/o: 0.00/2742.42/1371.21) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 32 tps: 676.90 qps: 4054.78 (r/w/o: 0.00/2700.99/1353.79) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 32 tps: 627.20 qps: 3769.82 (r/w/o: 0.00/2515.41/1254.41) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 32 tps: 735.20 qps: 4411.18 (r/w/o: 0.00/2940.79/1470.39) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 32 tps: 733.00 qps: 4389.60 (r/w/o: 0.00/2923.60/1466.00) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 32 tps: 696.00 qps: 4184.41 (r/w/o: 0.00/2792.40/1392.00) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 32 tps: 701.80 qps: 4199.59 (r/w/o: 0.00/2795.99/1403.60) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 32 tps: 702.70 qps: 4226.61 (r/w/o: 0.00/2821.21/1405.40) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 32 tps: 674.20 qps: 4045.99 (r/w/o: 0.00/2697.59/1348.40) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 32 tps: 685.80 qps: 4106.10 (r/w/o: 0.00/2734.50/1371.60) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 32 tps: 752.60 qps: 4513.20 (r/w/o: 0.00/3008.00/1505.20) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 32 tps: 661.80 qps: 3971.59 (r/w/o: 0.00/2647.99/1323.60) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 32 tps: 657.09 qps: 3945.63 (r/w/o: 0.00/2631.45/1314.18) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 32 tps: 783.22 qps: 4706.02 (r/w/o: 0.00/3139.68/1566.34) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 32 tps: 753.50 qps: 4520.82 (r/w/o: 0.00/3013.71/1507.11) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 32 tps: 740.09 qps: 4441.11 (r/w/o: 0.00/2960.94/1480.17) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 32 tps: 729.21 qps: 4366.44 (r/w/o: 0.00/2908.03/1458.41) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 32 tps: 737.69 qps: 4425.85 (r/w/o: 0.00/2950.47/1475.38) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 32 tps: 679.21 qps: 4084.45 (r/w/o: 0.00/2726.04/1358.42) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 32 tps: 746.70 qps: 4472.40 (r/w/o: 0.00/2979.00/1493.40) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 32 tps: 752.20 qps: 4521.00 (r/w/o: 0.00/3016.60/1504.40) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 32 tps: 722.80 qps: 4336.81 (r/w/o: 0.00/2891.20/1445.60) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 32 tps: 673.10 qps: 4031.81 (r/w/o: 0.00/2685.61/1346.20) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 32 tps: 818.00 qps: 4914.80 (r/w/o: 0.00/3278.80/1636.00) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 32 tps: 786.30 qps: 4708.70 (r/w/o: 0.00/3136.10/1572.60) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 32 tps: 773.59 qps: 4638.13 (r/w/o: 0.00/3090.95/1547.18) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 32 tps: 771.62 qps: 4633.29 (r/w/o: 0.00/3090.06/1543.23) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 32 tps: 726.30 qps: 4359.37 (r/w/o: 0.00/2906.78/1452.59) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 32 tps: 707.00 qps: 4237.70 (r/w/o: 0.00/2823.70/1414.00) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 32 tps: 726.60 qps: 4363.89 (r/w/o: 0.00/2910.69/1453.20) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 32 tps: 770.60 qps: 4630.88 (r/w/o: 0.00/3089.68/1541.19) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 32 tps: 724.70 qps: 4348.22 (r/w/o: 0.00/2898.82/1449.41) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 32 tps: 655.70 qps: 3934.17 (r/w/o: 0.00/2622.78/1311.39) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 32 tps: 810.65 qps: 4863.52 (r/w/o: 0.00/3242.21/1621.31) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 32 tps: 801.62 qps: 4806.51 (r/w/o: 0.00/3203.87/1602.64) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 32 tps: 794.63 qps: 4764.50 (r/w/o: 0.00/3174.63/1589.87) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 32 tps: 793.00 qps: 4759.71 (r/w/o: 0.00/3173.70/1586.00) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 32 tps: 754.30 qps: 4530.98 (r/w/o: 0.00/3022.39/1508.59) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 32 tps: 741.80 qps: 4450.81 (r/w/o: 0.00/2967.21/1483.60) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 32 tps: 734.01 qps: 4403.43 (r/w/o: 0.00/2935.42/1468.01) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 32 tps: 756.19 qps: 4537.76 (r/w/o: 0.00/3025.38/1512.39) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 32 tps: 791.90 qps: 4751.40 (r/w/o: 0.00/3167.60/1583.80) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 32 tps: 699.51 qps: 4189.14 (r/w/o: 0.00/2790.12/1399.01) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 32 tps: 767.50 qps: 4604.08 (r/w/o: 0.00/3069.09/1534.99) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 32 tps: 870.90 qps: 5234.20 (r/w/o: 0.00/3492.40/1741.80) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 32 tps: 776.29 qps: 4650.63 (r/w/o: 0.00/3098.05/1552.58) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 32 tps: 812.71 qps: 4883.36 (r/w/o: 0.00/3257.94/1625.42) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 32 tps: 794.18 qps: 4754.79 (r/w/o: 0.00/3166.43/1588.36) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 32 tps: 735.91 qps: 4417.19 (r/w/o: 0.00/2945.36/1471.83) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 32 tps: 738.50 qps: 4439.61 (r/w/o: 0.00/2962.61/1477.00) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 32 tps: 736.30 qps: 4417.79 (r/w/o: 0.00/2945.20/1472.60) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 32 tps: 832.90 qps: 4996.43 (r/w/o: 0.00/3330.62/1665.81) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 32 tps: 738.09 qps: 4428.57 (r/w/o: 0.00/2952.38/1476.19) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 32 tps: 696.20 qps: 4178.30 (r/w/o: 0.00/2785.80/1392.50) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 32 tps: 888.01 qps: 5327.94 (r/w/o: 0.00/3552.03/1775.91) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 32 tps: 839.30 qps: 5025.49 (r/w/o: 0.00/3346.89/1678.60) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 32 tps: 826.79 qps: 4965.24 (r/w/o: 0.00/3311.66/1653.58) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 32 tps: 797.11 qps: 4788.48 (r/w/o: 0.00/3194.26/1594.23) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 32 tps: 769.38 qps: 4610.39 (r/w/o: 0.00/3071.63/1538.76) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 32 tps: 838.62 qps: 5037.52 (r/w/o: 0.00/3360.28/1677.24) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 32 tps: 1311.17 qps: 7859.41 (r/w/o: 0.00/5237.58/2621.84) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 32 tps: 1050.50 qps: 6307.38 (r/w/o: 0.00/4205.99/2101.39) lat (ms,95%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 32 tps: 1041.91 qps: 6244.65 (r/w/o: 0.00/4161.13/2083.52) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 32 tps: 473.21 qps: 2849.25 (r/w/o: 0.00/1902.43/946.82) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 32 tps: 481.40 qps: 2882.41 (r/w/o: 0.00/1919.61/962.80) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 32 tps: 513.49 qps: 3085.26 (r/w/o: 0.00/2058.28/1026.99) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 32 tps: 726.40 qps: 4348.60 (r/w/o: 0.00/2895.80/1452.80) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 32 tps: 762.59 qps: 4575.17 (r/w/o: 0.00/3049.98/1525.19) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 32 tps: 774.19 qps: 4646.83 (r/w/o: 0.00/3099.46/1547.38) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 32 tps: 771.62 qps: 4640.04 (r/w/o: 0.00/3095.79/1544.25) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 32 tps: 823.60 qps: 4941.57 (r/w/o: 0.00/3294.38/1647.19) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 32 tps: 1028.70 qps: 6172.23 (r/w/o: 0.00/4114.82/2057.41) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 32 tps: 1021.60 qps: 6118.88 (r/w/o: 0.00/4075.69/2043.19) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 32 tps: 993.91 qps: 5968.04 (r/w/o: 0.00/3980.23/1987.81) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 32 tps: 670.89 qps: 4026.83 (r/w/o: 0.00/2685.05/1341.78) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 32 tps: 634.11 qps: 3800.83 (r/w/o: 0.00/2532.62/1268.21) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 32 tps: 678.00 qps: 4063.88 (r/w/o: 0.00/2707.89/1355.99) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 32 tps: 721.41 qps: 4331.43 (r/w/o: 0.00/2888.62/1442.81) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 32 tps: 795.60 qps: 4783.10 (r/w/o: 0.00/3191.90/1591.20) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 32 tps: 770.60 qps: 4617.30 (r/w/o: 0.00/3076.10/1541.20) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 32 tps: 782.20 qps: 4686.91 (r/w/o: 0.00/3122.51/1564.40) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 32 tps: 702.29 qps: 4226.36 (r/w/o: 0.00/2821.78/1404.59) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 32 tps: 1734.90 qps: 10401.41 (r/w/o: 0.00/6931.61/3469.80) lat (ms,95%): 36.89 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 32 tps: 802.97 qps: 4815.80 (r/w/o: 0.00/3209.87/1605.93) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 32 tps: 739.53 qps: 4442.19 (r/w/o: 0.00/2963.13/1479.06) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 32 tps: 544.39 qps: 3259.64 (r/w/o: 0.00/2171.86/1087.78) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 32 tps: 622.61 qps: 3747.19 (r/w/o: 0.00/2500.96/1246.23) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 32 tps: 722.30 qps: 4324.52 (r/w/o: 0.00/2879.92/1444.61) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 32 tps: 766.39 qps: 4606.23 (r/w/o: 0.00/3073.45/1532.78) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 32 tps: 777.51 qps: 4666.63 (r/w/o: 0.00/3111.62/1555.01) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 32 tps: 808.80 qps: 4843.69 (r/w/o: 0.00/3226.09/1617.60) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 32 tps: 799.40 qps: 4805.48 (r/w/o: 0.00/3206.68/1598.79) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 32 tps: 962.89 qps: 5777.36 (r/w/o: 0.00/3851.57/1925.79) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 32 tps: 1039.71 qps: 6238.26 (r/w/o: 0.00/4158.84/2079.42) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 32 tps: 1020.30 qps: 6111.10 (r/w/o: 0.00/4070.50/2040.60) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 32 tps: 895.20 qps: 5381.91 (r/w/o: 0.00/3591.51/1790.40) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 32 tps: 582.99 qps: 3497.93 (r/w/o: 0.00/2331.95/1165.98) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 32 tps: 677.91 qps: 4052.24 (r/w/o: 0.00/2699.42/1352.81) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 32 tps: 757.71 qps: 4554.98 (r/w/o: 0.00/3036.55/1518.43) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 32 tps: 810.68 qps: 4864.40 (r/w/o: 0.00/3244.03/1620.37) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 32 tps: 807.81 qps: 4852.87 (r/w/o: 0.00/3236.24/1616.62) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 32 tps: 830.00 qps: 4970.89 (r/w/o: 0.00/3310.89/1660.00) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 32 tps: 816.20 qps: 4906.52 (r/w/o: 0.00/3274.11/1632.41) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 32 tps: 1006.00 qps: 6036.01 (r/w/o: 0.00/4024.01/2012.00) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 32 tps: 1041.89 qps: 6251.17 (r/w/o: 0.00/4167.38/2083.79) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 32 tps: 1009.31 qps: 6047.93 (r/w/o: 0.00/4029.42/2018.51) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 32 tps: 867.37 qps: 5212.21 (r/w/o: 0.00/3477.37/1734.84) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 32 tps: 580.02 qps: 3480.22 (r/w/o: 0.00/2320.18/1160.04) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 32 tps: 676.19 qps: 4045.94 (r/w/o: 0.00/2693.96/1351.98) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 32 tps: 756.41 qps: 4549.06 (r/w/o: 0.00/3035.84/1513.22) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 32 tps: 825.70 qps: 4954.70 (r/w/o: 0.00/3303.30/1651.40) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 32 tps: 787.10 qps: 4722.69 (r/w/o: 0.00/3148.49/1574.20) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 32 tps: 860.40 qps: 5162.42 (r/w/o: 0.00/3441.61/1720.81) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 32 tps: 810.80 qps: 4853.81 (r/w/o: 0.00/3232.21/1621.60) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 32 tps: 1042.60 qps: 6266.59 (r/w/o: 0.00/4181.39/2085.20) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 32 tps: 1025.90 qps: 6144.32 (r/w/o: 0.00/4092.52/2051.81) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 32 tps: 1033.20 qps: 6200.11 (r/w/o: 0.00/4133.81/2066.30) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 32 tps: 840.59 qps: 5043.15 (r/w/o: 0.00/3361.97/1681.18) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 32 tps: 622.00 qps: 3731.50 (r/w/o: 0.00/2487.40/1244.10) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 32 tps: 699.10 qps: 4196.99 (r/w/o: 0.00/2798.79/1398.20) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           5331436
        other:                           2665718
        total:                           7997154
    transactions:                        1332859 (740.45 per sec.)
    queries:                             7997154 (4442.70 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0655s
    total number of events:              1332859

Latency (ms):
         min:                                    7.93
         avg:                                   43.21
         max:                                 2832.99
         95th percentile:                       92.42
         sum:                             57596620.56

Threads fairness:
    events (avg/stddev):           41651.8438/358.97
    execution time (avg/stddev):   1799.8944/0.01


[root@voice mysql3307]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.30   11.81     0.15     0.43    83.46     0.13    9.13   24.22    6.20   0.50   0.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  345.00 1113.00    11.26    48.09    83.37     3.55    2.43    1.48    2.72   0.64  92.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  256.00 1178.00     9.94    47.80    82.45     3.35    2.32    1.34    2.53   0.65  93.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  270.00 1226.00    12.14    47.95    82.26     3.66    2.51    2.21    2.57   0.62  93.20

^C
[root@voice mysql3307]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.72    0.00    0.73    0.21    0.00   98.34

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              14.11       149.32       439.46 1264612190 3721869536

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          24.68    0.00   13.62   24.94    0.00   36.76

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1340.00     12216.00     49296.00      12216      49296

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          22.48    0.00   12.14   25.06    0.00   40.31

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1211.00      7752.00     49160.00       7752      49160



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time  | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 10948 | Waiting on empty queue | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |     0 | starting               | show processlist                                                                                     |
| 68 | sysbench        | 192.168.1.10:52561 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 69 | sysbench        | 192.168.1.10:52578 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 70 | sysbench        | 192.168.1.10:52560 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 71 | sysbench        | 192.168.1.10:52574 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 72 | sysbench        | 192.168.1.10:52572 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 73 | sysbench        | 192.168.1.10:52570 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 74 | sysbench        | 192.168.1.10:52580 | sbtest | Execute |     0 | updating               | UPDATE sbtest20 SET k=k+1 WHERE id=1503297                                                           |
| 75 | sysbench        | 192.168.1.10:52576 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 76 | sysbench        | 192.168.1.10:52562 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 77 | sysbench        | 192.168.1.10:52567 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 78 | sysbench        | 192.168.1.10:52566 | sbtest | Sleep   |     0 |                        | NULL                                                                                                 |
| 79 | sysbench        | 192.168.1.10:52582 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 80 | sysbench        | 192.168.1.10:52584 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 81 | sysbench        | 192.168.1.10:52586 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 82 | sysbench        | 192.168.1.10:52588 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 83 | sysbench        | 192.168.1.10:52590 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 84 | sysbench        | 192.168.1.10:52594 | sbtest | Execute |     0 | updating               | UPDATE sbtest12 SET c='80376797258-45878468597-19242367803-33405500605-35397455591-35565112826-2756' |
| 85 | sysbench        | 192.168.1.10:52592 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 86 | sysbench        | 192.168.1.10:52598 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 87 | sysbench        | 192.168.1.10:52596 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 88 | sysbench        | 192.168.1.10:52602 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 89 | sysbench        | 192.168.1.10:52600 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 90 | sysbench        | 192.168.1.10:52604 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 91 | sysbench        | 192.168.1.10:52608 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 92 | sysbench        | 192.168.1.10:52606 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 93 | sysbench        | 192.168.1.10:52610 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 94 | sysbench        | 192.168.1.10:52614 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 95 | sysbench        | 192.168.1.10:52612 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 96 | sysbench        | 192.168.1.10:52622 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 97 | sysbench        | 192.168.1.10:52616 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 98 | sysbench        | 192.168.1.10:52620 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 99 | sysbench        | 192.168.1.10:52618 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
34 rows in set (0.00 sec)



mysql> show processlist;
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time  | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  | 10949 | Waiting on empty queue | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |     0 | starting               | show processlist                                                                                     |
| 68 | sysbench        | 192.168.1.10:52561 | sbtest | Execute |     0 | updating               | UPDATE sbtest4 SET k=k+1 WHERE id=1426905                                                            |
| 69 | sysbench        | 192.168.1.10:52578 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 70 | sysbench        | 192.168.1.10:52560 | sbtest | Execute |     0 | updating               | UPDATE sbtest4 SET k=k+1 WHERE id=1639092                                                            |
| 71 | sysbench        | 192.168.1.10:52574 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 72 | sysbench        | 192.168.1.10:52572 | sbtest | Execute |     0 | starting               | COMMIT                                                                                               |
| 73 | sysbench        | 192.168.1.10:52570 | sbtest | Execute |     0 | updating               | UPDATE sbtest19 SET k=k+1 WHERE id=1510952                                                           |
| 74 | sysbench        | 192.168.1.10:52580 | sbtest | Execute |     0 | updating               | UPDATE sbtest18 SET k=k+1 WHERE id=1504729                                                           |
| 75 | sysbench        | 192.168.1.10:52576 | sbtest | Execute |     0 | update                 | INSERT INTO sbtest12 (id, k, c, pad) VALUES (1499293, 1361982, '91630042846-63556641169-71038240039- |
| 76 | sysbench        | 192.168.1.10:52562 | sbtest | Execute |     0 | updating               | UPDATE sbtest8 SET k=k+1 WHERE id=1496972                                                            |
| 77 | sysbench        | 192.168.1.10:52567 | sbtest | Execute |     0 | updating               | UPDATE sbtest11 SET k=k+1 WHERE id=1513084                                                           |
| 78 | sysbench        | 192.168.1.10:52566 | sbtest | Execute |     0 | updating               | UPDATE sbtest13 SET k=k+1 WHERE id=1508830                                                           |
| 79 | sysbench        | 192.168.1.10:52582 | sbtest | Sleep   |     0 | starting               | NULL                                                                                                 |
| 80 | sysbench        | 192.168.1.10:52584 | sbtest | Execute |     0 | updating               | UPDATE sbtest6 SET k=k+1 WHERE id=1505829                                                            |
| 81 | sysbench        | 192.168.1.10:52586 | sbtest | Execute |     0 | updating               | UPDATE sbtest9 SET k=k+1 WHERE id=1492721                                                            |
| 82 | sysbench        | 192.168.1.10:52588 | sbtest | Execute |     0 | updating               | UPDATE sbtest11 SET k=k+1 WHERE id=1219258                                                           |
| 83 | sysbench        | 192.168.1.10:52590 | sbtest | Execute |     0 | updating               | UPDATE sbtest1 SET k=k+1 WHERE id=1509139                                                            |
| 84 | sysbench        | 192.168.1.10:52594 | sbtest | Execute |     0 | update                 | INSERT INTO sbtest2 (id, k, c, pad) VALUES (1514814, 1510211, '77290882081-93477894225-13035034842-6 |
| 85 | sysbench        | 192.168.1.10:52592 | sbtest | Execute |     0 | updating               | UPDATE sbtest19 SET k=k+1 WHERE id=1500856                                                           |
| 86 | sysbench        | 192.168.1.10:52598 | sbtest | Execute |     0 | update                 | INSERT INTO sbtest8 (id, k, c, pad) VALUES (1840159, 1508285, '96290734632-09042575006-99584489585-7 |
| 87 | sysbench        | 192.168.1.10:52596 | sbtest | Execute |     0 | updating               | UPDATE sbtest13 SET k=k+1 WHERE id=1506213                                                           |
| 88 | sysbench        | 192.168.1.10:52602 | sbtest | Execute |     0 | updating               | UPDATE sbtest6 SET k=k+1 WHERE id=1492950                                                            |
| 89 | sysbench        | 192.168.1.10:52600 | sbtest | Execute |     0 | update                 | INSERT INTO sbtest6 (id, k, c, pad) VALUES (1503687, 1556784, '59042614076-48287753323-60317565539-5 |
| 90 | sysbench        | 192.168.1.10:52604 | sbtest | Execute |     0 | update                 | INSERT INTO sbtest20 (id, k, c, pad) VALUES (1514528, 1498875, '97987945622-57940070310-73134734310' |
| 91 | sysbench        | 192.168.1.10:52608 | sbtest | Execute |     0 | updating               | UPDATE sbtest10 SET k=k+1 WHERE id=1514603                                                           |
| 92 | sysbench        | 192.168.1.10:52606 | sbtest | Execute |     0 | updating               | UPDATE sbtest11 SET k=k+1 WHERE id=889200                                                            |
| 93 | sysbench        | 192.168.1.10:52610 | sbtest | Execute |     0 | updating               | UPDATE sbtest18 SET k=k+1 WHERE id=1496344                                                           |
| 94 | sysbench        | 192.168.1.10:52614 | sbtest | Execute |     0 | updating               | UPDATE sbtest20 SET k=k+1 WHERE id=1505885                                                           |
| 95 | sysbench        | 192.168.1.10:52612 | sbtest | Execute |     0 | updating               | UPDATE sbtest8 SET k=k+1 WHERE id=1514099                                                            |
| 96 | sysbench        | 192.168.1.10:52622 | sbtest | Execute |     0 | update                 | INSERT INTO sbtest10 (id, k, c, pad) VALUES (1494992, 1493417, '5753795459-96350742545-64716482303-' |
| 97 | sysbench        | 192.168.1.10:52616 | sbtest | Execute |     0 | updating               | UPDATE sbtest6 SET k=k+1 WHERE id=1497043                                                            |
| 98 | sysbench        | 192.168.1.10:52620 | sbtest | Execute |     0 | updating               | UPDATE sbtest11 SET k=k+1 WHERE id=1482142                                                           |
| 99 | sysbench        | 192.168.1.10:52618 | sbtest | Execute |     0 | updating               | UPDATE sbtest13 SET k=k+1 WHERE id=1625815                                                           |
+----+-----------------+--------------------+--------+---------+-------+------------------------+------------------------------------------------------------------------------------------------------+
34 rows in set (0.00 sec)


[root@voice mysql3307]# perf top -p 13276 >> 1.log
[root@voice mysql3307]# cat 1.log 

   PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cpu-clock],  (target_pid: 13276)
-------------------------------------------------------------------------------

   PerfTop:    5163 irqs/sec  kernel:33.8%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cpu-clock],  (target_pid: 13276)
-------------------------------------------------------------------------------

     9.61%  libc-2.17.so   [.] __sched_yield
     4.72%  [kernel]       [k] __raw_spin_unlock_irq
     3.44%  [kernel]       [k] system_call_after_swapgs
     3.29%  [kernel]       [k] _raw_spin_unlock_irqrestore
     2.80%  mysqld         [.] rec_get_offsets_func
     1.95%  libc-2.17.so   [.] __memmove_ssse3_back
     1.82%  mysqld         [.] buf_page_get_gen
     1.62%  [kernel]       [k] finish_task_switch
     1.34%  mysqld         [.] page_cur_insert_rec_write_log
     1.30%  [kernel]       [k] copy_user_enhanced_fast_string
     1.20%  mysqld         [.] ut_delay
     1.10%  libc-2.17.so   [.] _int_malloc
     0.94%  [kernel]       [k] __do_softirq
     0.91%  [kernel]       [k] ipt_do_table
     0.77%  mysqld         [.] page_cur_insert_rec_low
     0.75%  mysqld         [.] PolicyMutex<TTASEventMutex<GenericPolicy> >::en
     0.72%  mysqld         [.] ha_insert_for_fold_func
     0.64%  mysqld         [.] btr_cur_search_to_nth_level
     0.59%  mysqld         [.] pfs_start_mutex_wait_v1
     0.56%  libc-2.17.so   [.] malloc

   PerfTop:    6456 irqs/sec  kernel:33.3%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cpu-clock],  (target_pid: 13276)
-------------------------------------------------------------------------------

     9.61%  libc-2.17.so   [.] __sched_yield
     4.46%  [kernel]       [k] __raw_spin_unlock_irq
     3.42%  [kernel]       [k] system_call_after_swapgs
     3.07%  [kernel]       [k] _raw_spin_unlock_irqrestore
     2.89%  mysqld         [.] rec_get_offsets_func
     1.93%  libc-2.17.so   [.] __memmove_ssse3_back
     1.82%  mysqld         [.] buf_page_get_gen
     1.60%  [kernel]       [k] finish_task_switch
     1.27%  mysqld         [.] page_cur_insert_rec_write_log
     1.20%  [kernel]       [k] copy_user_enhanced_fast_string
     1.16%  mysqld         [.] ut_delay
     1.09%  libc-2.17.so   [.] _int_malloc
     1.03%  [kernel]       [k] __do_softirq
     1.02%  [kernel]       [k] ipt_do_table
     0.77%  mysqld         [.] page_cur_insert_rec_low
     0.77%  mysqld         [.] PolicyMutex<TTASEventMutex<GenericPolicy> >::en
     0.71%  mysqld         [.] ha_insert_for_fold_func
     0.61%  mysqld         [.] btr_cur_search_to_nth_level
     0.61%  mysqld         [.] pfs_start_mutex_wait_v1
     0.54%  libc-2.17.so   [.] malloc

   PerfTop:    6630 irqs/sec  kernel:31.9%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cpu-clock],  (target_pid: 13276)
-------------------------------------------------------------------------------

     8.35%  libc-2.17.so   [.] __sched_yield
     3.78%  [kernel]       [k] __raw_spin_unlock_irq
     3.18%  [kernel]       [k] _raw_spin_unlock_irqrestore
     3.01%  mysqld         [.] rec_get_offsets_func
     2.93%  [kernel]       [k] system_call_after_swapgs
     2.06%  libc-2.17.so   [.] __memmove_ssse3_back
     1.87%  mysqld         [.] buf_page_get_gen
     1.73%  [kernel]       [k] finish_task_switch
     1.28%  mysqld         [.] page_cur_insert_rec_write_log
     1.20%  [kernel]       [k] copy_user_enhanced_fast_string
     1.14%  libc-2.17.so   [.] _int_malloc
     1.07%  mysqld         [.] ut_delay
     1.02%  [kernel]       [k] ipt_do_table
     1.02%  [kernel]       [k] __do_softirq
     0.79%  mysqld         [.] page_cur_insert_rec_low
     0.76%  mysqld         [.] btr_cur_search_to_nth_level
     0.71%  mysqld         [.] PolicyMutex<TTASEventMutex<GenericPolicy> >::en
     0.70%  mysqld         [.] ha_insert_for_fold_func
     0.60%  mysqld         [.] page_cur_search_with_match
     0.57%  mysqld         [.] pfs_start_mutex_wait_v1

   PerfTop:    7243 irqs/sec  kernel:34.6%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cpu-clock],  (target_pid: 13276)
-------------------------------------------------------------------------------

     9.25%  libc-2.17.so   [.] __sched_yield
     4.30%  [kernel]       [k] __raw_spin_unlock_irq
     3.20%  [kernel]       [k] system_call_after_swapgs
     3.10%  [kernel]       [k] _raw_spin_unlock_irqrestore
     2.86%  mysqld         [.] rec_get_offsets_func
     1.99%  libc-2.17.so   [.] __memmove_ssse3_back
     1.84%  mysqld         [.] buf_page_get_gen
     1.81%  [kernel]       [k] finish_task_switch
     1.22%  mysqld         [.] page_cur_insert_rec_write_log
     1.19%  [kernel]       [k] copy_user_enhanced_fast_string
     1.12%  libc-2.17.so   [.] _int_malloc
     1.08%  mysqld         [.] ut_delay
     1.00%  [kernel]       [k] __do_softirq
     0.96%  [kernel]       [k] ipt_do_table
     0.79%  mysqld         [.] page_cur_insert_rec_low
     0.74%  mysqld         [.] PolicyMutex<TTASEventMutex<GenericPolicy> >::en
     0.74%  mysqld         [.] btr_cur_search_to_nth_level
     0.66%  mysqld         [.] ha_insert_for_fold_func
     0.60%  mysqld         [.] page_cur_search_with_match
     0.58%  mysqld         [.] pfs_start_mutex_wait_v1

   PerfTop:    6155 irqs/sec  kernel:33.9%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cpu-clock],  (target_pid: 13276)
-------------------------------------------------------------------------------


[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_32_11_vesion7.log


Initializing worker threads...

Threads started!

[ 10s ] thds: 32 tps: 1694.38 qps: 10176.79 (r/w/o: 0.00/6785.13/3391.66) lat (ms,95%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 32 tps: 1747.99 qps: 10491.46 (r/w/o: 0.00/6995.17/3496.29) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 32 tps: 1795.81 qps: 10773.46 (r/w/o: 0.00/7182.24/3591.22) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 32 tps: 1081.09 qps: 6479.55 (r/w/o: 0.00/4316.96/2162.58) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00

[ 50s ] thds: 32 tps: 385.31 qps: 2314.84 (r/w/o: 0.00/1544.22/770.61) lat (ms,95%): 127.81 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 32 tps: 418.99 qps: 2514.85 (r/w/o: 0.00/1676.87/837.98) lat (ms,95%): 116.80 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 32 tps: 427.81 qps: 2573.34 (r/w/o: 0.00/1717.73/855.61) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 32 tps: 439.20 qps: 2623.80 (r/w/o: 0.00/1745.60/878.20) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 32 tps: 440.10 qps: 2640.98 (r/w/o: 0.00/1760.68/880.29) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 32 tps: 441.99 qps: 2656.15 (r/w/o: 0.00/1772.06/884.08) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 32 tps: 452.41 qps: 2712.38 (r/w/o: 0.00/1807.55/904.83) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 32 tps: 450.30 qps: 2710.71 (r/w/o: 0.00/1810.10/900.60) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 32 tps: 448.89 qps: 2685.55 (r/w/o: 0.00/1787.77/897.78) lat (ms,95%): 114.72 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 32 tps: 449.31 qps: 2697.24 (r/w/o: 0.00/1798.63/898.61) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 32 tps: 449.80 qps: 2705.22 (r/w/o: 0.00/1805.61/899.61) lat (ms,95%): 112.67 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 32 tps: 467.90 qps: 2797.68 (r/w/o: 0.00/1861.89/935.79) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 32 tps: 541.00 qps: 3254.28 (r/w/o: 0.00/2172.28/1081.99) lat (ms,95%): 102.97 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 32 tps: 654.41 qps: 3927.55 (r/w/o: 0.00/2618.73/1308.82) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 32 tps: 621.90 qps: 3723.28 (r/w/o: 0.00/2479.48/1243.79) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 32 tps: 555.20 qps: 3328.81 (r/w/o: 0.00/2218.41/1110.40) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 32 tps: 520.80 qps: 3128.60 (r/w/o: 0.00/2087.00/1041.60) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 32 tps: 519.50 qps: 3114.61 (r/w/o: 0.00/2075.61/1039.00) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 32 tps: 515.30 qps: 3092.78 (r/w/o: 0.00/2062.18/1030.59) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 32 tps: 538.90 qps: 3234.30 (r/w/o: 0.00/2156.50/1077.80) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 32 tps: 550.00 qps: 3307.03 (r/w/o: 0.00/2207.02/1100.01) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 32 tps: 567.39 qps: 3394.62 (r/w/o: 0.00/2259.85/1134.77) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 32 tps: 604.21 qps: 3635.48 (r/w/o: 0.00/2427.05/1208.43) lat (ms,95%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 32 tps: 628.70 qps: 3772.22 (r/w/o: 0.00/2514.81/1257.41) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 32 tps: 636.30 qps: 3810.17 (r/w/o: 0.00/2537.58/1272.59) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 32 tps: 588.50 qps: 3531.51 (r/w/o: 0.00/2354.51/1177.00) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 32 tps: 572.29 qps: 3428.85 (r/w/o: 0.00/2284.27/1144.58) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 32 tps: 588.31 qps: 3531.85 (r/w/o: 0.00/2355.23/1176.62) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 32 tps: 596.89 qps: 3580.23 (r/w/o: 0.00/2386.45/1193.78) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 32 tps: 614.21 qps: 3686.55 (r/w/o: 0.00/2458.24/1228.32) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 32 tps: 560.10 qps: 3370.11 (r/w/o: 0.00/2249.81/1120.30) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 32 tps: 586.60 qps: 3519.88 (r/w/o: 0.00/2346.69/1173.19) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 32 tps: 619.01 qps: 3713.24 (r/w/o: 0.00/2475.22/1238.01) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 32 tps: 664.69 qps: 3980.96 (r/w/o: 0.00/2651.57/1329.39) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 32 tps: 630.70 qps: 3791.88 (r/w/o: 0.00/2530.49/1261.39) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 32 tps: 598.10 qps: 3575.09 (r/w/o: 0.00/2379.89/1195.20) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 32 tps: 618.51 qps: 3724.34 (r/w/o: 0.00/2486.43/1237.91) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 32 tps: 642.70 qps: 3856.73 (r/w/o: 0.00/2571.22/1285.51) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 32 tps: 632.10 qps: 3783.98 (r/w/o: 0.00/2519.78/1264.19) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 32 tps: 605.69 qps: 3638.94 (r/w/o: 0.00/2427.56/1211.38) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 32 tps: 680.71 qps: 4088.07 (r/w/o: 0.00/2726.65/1361.42) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 32 tps: 659.20 qps: 3955.21 (r/w/o: 0.00/2636.80/1318.40) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 32 tps: 664.40 qps: 3986.41 (r/w/o: 0.00/2657.61/1328.80) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 32 tps: 635.10 qps: 3810.18 (r/w/o: 0.00/2539.99/1270.19) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 32 tps: 652.69 qps: 3913.45 (r/w/o: 0.00/2608.07/1305.38) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 32 tps: 648.19 qps: 3891.94 (r/w/o: 0.00/2595.56/1296.38) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 32 tps: 637.02 qps: 3822.42 (r/w/o: 0.00/2548.38/1274.04) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 32 tps: 662.00 qps: 3972.01 (r/w/o: 0.00/2648.00/1324.00) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 32 tps: 632.49 qps: 3794.96 (r/w/o: 0.00/2529.98/1264.99) lat (ms,95%): 99.33 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 32 tps: 645.00 qps: 3869.63 (r/w/o: 0.00/2579.62/1290.01) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 32 tps: 734.60 qps: 4408.00 (r/w/o: 0.00/2938.80/1469.20) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 32 tps: 662.70 qps: 3976.20 (r/w/o: 0.00/2650.80/1325.40) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 32 tps: 701.80 qps: 4210.78 (r/w/o: 0.00/2807.19/1403.59) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 32 tps: 722.60 qps: 4335.52 (r/w/o: 0.00/2890.32/1445.21) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 32 tps: 656.50 qps: 3933.60 (r/w/o: 0.00/2620.60/1313.00) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 32 tps: 685.60 qps: 4119.09 (r/w/o: 0.00/2747.89/1371.20) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 32 tps: 685.61 qps: 4113.64 (r/w/o: 0.00/2742.42/1371.21) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 32 tps: 676.90 qps: 4054.78 (r/w/o: 0.00/2700.99/1353.79) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 32 tps: 627.20 qps: 3769.82 (r/w/o: 0.00/2515.41/1254.41) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 32 tps: 735.20 qps: 4411.18 (r/w/o: 0.00/2940.79/1470.39) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 32 tps: 733.00 qps: 4389.60 (r/w/o: 0.00/2923.60/1466.00) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 32 tps: 696.00 qps: 4184.41 (r/w/o: 0.00/2792.40/1392.00) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 32 tps: 701.80 qps: 4199.59 (r/w/o: 0.00/2795.99/1403.60) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 32 tps: 702.70 qps: 4226.61 (r/w/o: 0.00/2821.21/1405.40) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 32 tps: 674.20 qps: 4045.99 (r/w/o: 0.00/2697.59/1348.40) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 32 tps: 685.80 qps: 4106.10 (r/w/o: 0.00/2734.50/1371.60) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 32 tps: 752.60 qps: 4513.20 (r/w/o: 0.00/3008.00/1505.20) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 32 tps: 661.80 qps: 3971.59 (r/w/o: 0.00/2647.99/1323.60) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 32 tps: 657.09 qps: 3945.63 (r/w/o: 0.00/2631.45/1314.18) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 32 tps: 783.22 qps: 4706.02 (r/w/o: 0.00/3139.68/1566.34) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 32 tps: 753.50 qps: 4520.82 (r/w/o: 0.00/3013.71/1507.11) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 32 tps: 740.09 qps: 4441.11 (r/w/o: 0.00/2960.94/1480.17) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 32 tps: 729.21 qps: 4366.44 (r/w/o: 0.00/2908.03/1458.41) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 32 tps: 737.69 qps: 4425.85 (r/w/o: 0.00/2950.47/1475.38) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 32 tps: 679.21 qps: 4084.45 (r/w/o: 0.00/2726.04/1358.42) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 32 tps: 746.70 qps: 4472.40 (r/w/o: 0.00/2979.00/1493.40) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 32 tps: 752.20 qps: 4521.00 (r/w/o: 0.00/3016.60/1504.40) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 32 tps: 722.80 qps: 4336.81 (r/w/o: 0.00/2891.20/1445.60) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 32 tps: 673.10 qps: 4031.81 (r/w/o: 0.00/2685.61/1346.20) lat (ms,95%): 97.55 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 32 tps: 818.00 qps: 4914.80 (r/w/o: 0.00/3278.80/1636.00) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 32 tps: 786.30 qps: 4708.70 (r/w/o: 0.00/3136.10/1572.60) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 32 tps: 773.59 qps: 4638.13 (r/w/o: 0.00/3090.95/1547.18) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 32 tps: 771.62 qps: 4633.29 (r/w/o: 0.00/3090.06/1543.23) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 32 tps: 726.30 qps: 4359.37 (r/w/o: 0.00/2906.78/1452.59) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 32 tps: 707.00 qps: 4237.70 (r/w/o: 0.00/2823.70/1414.00) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 32 tps: 726.60 qps: 4363.89 (r/w/o: 0.00/2910.69/1453.20) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 32 tps: 770.60 qps: 4630.88 (r/w/o: 0.00/3089.68/1541.19) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 32 tps: 724.70 qps: 4348.22 (r/w/o: 0.00/2898.82/1449.41) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 32 tps: 655.70 qps: 3934.17 (r/w/o: 0.00/2622.78/1311.39) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 32 tps: 810.65 qps: 4863.52 (r/w/o: 0.00/3242.21/1621.31) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 32 tps: 801.62 qps: 4806.51 (r/w/o: 0.00/3203.87/1602.64) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 32 tps: 794.63 qps: 4764.50 (r/w/o: 0.00/3174.63/1589.87) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 32 tps: 793.00 qps: 4759.71 (r/w/o: 0.00/3173.70/1586.00) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 32 tps: 754.30 qps: 4530.98 (r/w/o: 0.00/3022.39/1508.59) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 32 tps: 741.80 qps: 4450.81 (r/w/o: 0.00/2967.21/1483.60) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 32 tps: 734.01 qps: 4403.43 (r/w/o: 0.00/2935.42/1468.01) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 32 tps: 756.19 qps: 4537.76 (r/w/o: 0.00/3025.38/1512.39) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 32 tps: 791.90 qps: 4751.40 (r/w/o: 0.00/3167.60/1583.80) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 32 tps: 699.51 qps: 4189.14 (r/w/o: 0.00/2790.12/1399.01) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 32 tps: 767.50 qps: 4604.08 (r/w/o: 0.00/3069.09/1534.99) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 32 tps: 870.90 qps: 5234.20 (r/w/o: 0.00/3492.40/1741.80) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 32 tps: 776.29 qps: 4650.63 (r/w/o: 0.00/3098.05/1552.58) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 32 tps: 812.71 qps: 4883.36 (r/w/o: 0.00/3257.94/1625.42) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 32 tps: 794.18 qps: 4754.79 (r/w/o: 0.00/3166.43/1588.36) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 32 tps: 735.91 qps: 4417.19 (r/w/o: 0.00/2945.36/1471.83) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 32 tps: 738.50 qps: 4439.61 (r/w/o: 0.00/2962.61/1477.00) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 32 tps: 736.30 qps: 4417.79 (r/w/o: 0.00/2945.20/1472.60) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 32 tps: 832.90 qps: 4996.43 (r/w/o: 0.00/3330.62/1665.81) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 32 tps: 738.09 qps: 4428.57 (r/w/o: 0.00/2952.38/1476.19) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 32 tps: 696.20 qps: 4178.30 (r/w/o: 0.00/2785.80/1392.50) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 32 tps: 888.01 qps: 5327.94 (r/w/o: 0.00/3552.03/1775.91) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 32 tps: 839.30 qps: 5025.49 (r/w/o: 0.00/3346.89/1678.60) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 32 tps: 826.79 qps: 4965.24 (r/w/o: 0.00/3311.66/1653.58) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 32 tps: 797.11 qps: 4788.48 (r/w/o: 0.00/3194.26/1594.23) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 32 tps: 769.38 qps: 4610.39 (r/w/o: 0.00/3071.63/1538.76) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 32 tps: 838.62 qps: 5037.52 (r/w/o: 0.00/3360.28/1677.24) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 32 tps: 1311.17 qps: 7859.41 (r/w/o: 0.00/5237.58/2621.84) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 32 tps: 1050.50 qps: 6307.38 (r/w/o: 0.00/4205.99/2101.39) lat (ms,95%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 32 tps: 1041.91 qps: 6244.65 (r/w/o: 0.00/4161.13/2083.52) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 32 tps: 473.21 qps: 2849.25 (r/w/o: 0.00/1902.43/946.82) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 32 tps: 481.40 qps: 2882.41 (r/w/o: 0.00/1919.61/962.80) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 32 tps: 513.49 qps: 3085.26 (r/w/o: 0.00/2058.28/1026.99) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 32 tps: 726.40 qps: 4348.60 (r/w/o: 0.00/2895.80/1452.80) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 32 tps: 762.59 qps: 4575.17 (r/w/o: 0.00/3049.98/1525.19) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 32 tps: 774.19 qps: 4646.83 (r/w/o: 0.00/3099.46/1547.38) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 32 tps: 771.62 qps: 4640.04 (r/w/o: 0.00/3095.79/1544.25) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 32 tps: 823.60 qps: 4941.57 (r/w/o: 0.00/3294.38/1647.19) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 32 tps: 1028.70 qps: 6172.23 (r/w/o: 0.00/4114.82/2057.41) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 32 tps: 1021.60 qps: 6118.88 (r/w/o: 0.00/4075.69/2043.19) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 32 tps: 993.91 qps: 5968.04 (r/w/o: 0.00/3980.23/1987.81) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 32 tps: 670.89 qps: 4026.83 (r/w/o: 0.00/2685.05/1341.78) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 32 tps: 634.11 qps: 3800.83 (r/w/o: 0.00/2532.62/1268.21) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 32 tps: 678.00 qps: 4063.88 (r/w/o: 0.00/2707.89/1355.99) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 32 tps: 721.41 qps: 4331.43 (r/w/o: 0.00/2888.62/1442.81) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 32 tps: 795.60 qps: 4783.10 (r/w/o: 0.00/3191.90/1591.20) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 32 tps: 770.60 qps: 4617.30 (r/w/o: 0.00/3076.10/1541.20) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 32 tps: 782.20 qps: 4686.91 (r/w/o: 0.00/3122.51/1564.40) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 32 tps: 702.29 qps: 4226.36 (r/w/o: 0.00/2821.78/1404.59) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 32 tps: 1734.90 qps: 10401.41 (r/w/o: 0.00/6931.61/3469.80) lat (ms,95%): 36.89 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 32 tps: 802.97 qps: 4815.80 (r/w/o: 0.00/3209.87/1605.93) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 32 tps: 739.53 qps: 4442.19 (r/w/o: 0.00/2963.13/1479.06) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 32 tps: 544.39 qps: 3259.64 (r/w/o: 0.00/2171.86/1087.78) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 32 tps: 622.61 qps: 3747.19 (r/w/o: 0.00/2500.96/1246.23) lat (ms,95%): 92.42 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 32 tps: 722.30 qps: 4324.52 (r/w/o: 0.00/2879.92/1444.61) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 32 tps: 766.39 qps: 4606.23 (r/w/o: 0.00/3073.45/1532.78) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 32 tps: 777.51 qps: 4666.63 (r/w/o: 0.00/3111.62/1555.01) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 32 tps: 808.80 qps: 4843.69 (r/w/o: 0.00/3226.09/1617.60) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 32 tps: 799.40 qps: 4805.48 (r/w/o: 0.00/3206.68/1598.79) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 32 tps: 962.89 qps: 5777.36 (r/w/o: 0.00/3851.57/1925.79) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 32 tps: 1039.71 qps: 6238.26 (r/w/o: 0.00/4158.84/2079.42) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 32 tps: 1020.30 qps: 6111.10 (r/w/o: 0.00/4070.50/2040.60) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 32 tps: 895.20 qps: 5381.91 (r/w/o: 0.00/3591.51/1790.40) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 32 tps: 582.99 qps: 3497.93 (r/w/o: 0.00/2331.95/1165.98) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 32 tps: 677.91 qps: 4052.24 (r/w/o: 0.00/2699.42/1352.81) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 32 tps: 757.71 qps: 4554.98 (r/w/o: 0.00/3036.55/1518.43) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 32 tps: 810.68 qps: 4864.40 (r/w/o: 0.00/3244.03/1620.37) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 32 tps: 807.81 qps: 4852.87 (r/w/o: 0.00/3236.24/1616.62) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 32 tps: 830.00 qps: 4970.89 (r/w/o: 0.00/3310.89/1660.00) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 32 tps: 816.20 qps: 4906.52 (r/w/o: 0.00/3274.11/1632.41) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 32 tps: 1006.00 qps: 6036.01 (r/w/o: 0.00/4024.01/2012.00) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 32 tps: 1041.89 qps: 6251.17 (r/w/o: 0.00/4167.38/2083.79) lat (ms,95%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 32 tps: 1009.31 qps: 6047.93 (r/w/o: 0.00/4029.42/2018.51) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 32 tps: 867.37 qps: 5212.21 (r/w/o: 0.00/3477.37/1734.84) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 32 tps: 580.02 qps: 3480.22 (r/w/o: 0.00/2320.18/1160.04) lat (ms,95%): 95.81 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 32 tps: 676.19 qps: 4045.94 (r/w/o: 0.00/2693.96/1351.98) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 32 tps: 756.41 qps: 4549.06 (r/w/o: 0.00/3035.84/1513.22) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 32 tps: 825.70 qps: 4954.70 (r/w/o: 0.00/3303.30/1651.40) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 32 tps: 787.10 qps: 4722.69 (r/w/o: 0.00/3148.49/1574.20) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 32 tps: 860.40 qps: 5162.42 (r/w/o: 0.00/3441.61/1720.81) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 32 tps: 810.80 qps: 4853.81 (r/w/o: 0.00/3232.21/1621.60) lat (ms,95%): 89.16 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 32 tps: 1042.60 qps: 6266.59 (r/w/o: 0.00/4181.39/2085.20) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 32 tps: 1025.90 qps: 6144.32 (r/w/o: 0.00/4092.52/2051.81) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 32 tps: 1033.20 qps: 6200.11 (r/w/o: 0.00/4133.81/2066.30) lat (ms,95%): 86.00 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 32 tps: 840.59 qps: 5043.15 (r/w/o: 0.00/3361.97/1681.18) lat (ms,95%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 32 tps: 622.00 qps: 3731.50 (r/w/o: 0.00/2487.40/1244.10) lat (ms,95%): 94.10 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 32 tps: 699.10 qps: 4196.99 (r/w/o: 0.00/2798.79/1398.20) lat (ms,95%): 90.78 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           5331436
        other:                           2665718
        total:                           7997154
    transactions:                        1332859 (740.45 per sec.)
    queries:                             7997154 (4442.70 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0655s
    total number of events:              1332859

Latency (ms):
         min:                                    7.93
         avg:                                   43.21
         max:                                 2832.99
         95th percentile:                       92.42
         sum:                             57596620.56

Threads fairness:
    events (avg/stddev):           41651.8438/358.97
    execution time (avg/stddev):   1799.8944/0.01


mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-22 15:39:56 0x7f00a8058700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 4 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 3777 srv_active, 0 srv_shutdown, 6569 srv_idle
srv_master_thread log flush and writes: 10346
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 6827985
--Thread 139640719795968 has waited at btr0cur.cc line 976 for 0.00 seconds the semaphore:
SX-lock on RW-latch at 0x7f0054002aa0 created in file dict0dict.cc line 2737
a writer (thread id 139640394835712) has reserved it in mode  SX
number of readers 1, waiters flag 1, lock_word: fffffff
Last time read locked in file btr0cur.cc line 1008
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
--Thread 139640696690432 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640044922624 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640395376384 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640046544640 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640045192960 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640047355648 has waited at fsp0fsp.cc line 3365 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x101786a8 created in file fil0fil.cc line 1383
a writer (thread id 139640393213696) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: ffffffffe0000000
Last time read locked in file not yet reserved line 0
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fsp/fsp0fsp.cc line 2617
--Thread 139640046003968 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640393484032 has waited at fsp0fsp.cc line 3365 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x101786a8 created in file fil0fil.cc line 1383
a writer (thread id 139640393213696) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: ffffffffe0000000
Last time read locked in file not yet reserved line 0
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fsp/fsp0fsp.cc line 2617
--Thread 139640396187392 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640394295040 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640394024704 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640392943360 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640047625984 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock (wait_ex) on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640048707328 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640394835712 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640395917056 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640045463296 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640047896320 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640396457728 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640045733632 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640048166656 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640046814976 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640696420096 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640396728064 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640393754368 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640395106048 has waited at row0ins.cc line 2998 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f02155704a0 created in file buf0buf.cc line 1460
a writer (thread id 139640394835712) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139640048436992 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640046274304 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640047085312 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640394565376 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640395646720 has waited at btr0cur.cc line 3874 for 0.00 seconds the semaphore:
X-lock on RW-latch at 0x1016b988 created in file btr0sea.cc line 195
a writer (thread id 139640047625984) has reserved it in mode  wait exclusive
number of readers 1, waiters flag 1, lock_word: ffffffffffffffff
Last time read locked in file btr0sea.ic line 128
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 3874
--Thread 139640393213696 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

OS WAIT ARRAY INFO: signal count 8398538
RW-shared spins 0, rounds 2797902, OS waits 95264
RW-excl spins 0, rounds 19016533, OS waits 232857
RW-sx spins 104504, rounds 2903681, OS waits 62378
Spin rounds per wait: 2797902.00 RW-shared, 19016533.00 RW-excl, 27.79 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 58548917
Purge done for trx's n:o < 58548845 undo n:o < 0 state: running
History list length 257
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421125060591216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421125060589392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 58548916, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 87, OS thread handle 139640396187392, query id 11106774 192.168.1.10 sysbench updating
UPDATE sbtest7 SET k=k+1 WHERE id=1496466
---TRANSACTION 58548914, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 96, OS thread handle 139640044922624, query id 11106772 192.168.1.10 sysbench updating
UPDATE sbtest16 SET k=k+1 WHERE id=1505303
---TRANSACTION 58548913, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 83, OS thread handle 139640395376384, query id 11106770 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=1494169
---TRANSACTION 58548912, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 81, OS thread handle 139640396728064, query id 11106768 192.168.1.10 sysbench updating
UPDATE sbtest4 SET k=k+1 WHERE id=1492591
---TRANSACTION 58548911, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 69, OS thread handle 139640396457728, query id 11106765 192.168.1.10 sysbench updating
UPDATE sbtest18 SET k=k+1 WHERE id=1498563
---TRANSACTION 58548910, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 88, OS thread handle 139640696690432, query id 11106766 192.168.1.10 sysbench updating
UPDATE sbtest12 SET k=k+1 WHERE id=1626360
---TRANSACTION 58548908, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 86, OS thread handle 139640047896320, query id 11106764 192.168.1.10 sysbench updating
UPDATE sbtest19 SET k=k+1 WHERE id=1533189
---TRANSACTION 58548907, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 91, OS thread handle 139640395646720, query id 11106763 192.168.1.10 sysbench updating
UPDATE sbtest14 SET k=k+1 WHERE id=1575150
---TRANSACTION 58548906, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 98, OS thread handle 139640045192960, query id 11106760 192.168.1.10 sysbench updating
UPDATE sbtest7 SET k=k+1 WHERE id=1492835
---TRANSACTION 58548905, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 97, OS thread handle 139640045733632, query id 11106761 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=1840502
---TRANSACTION 58548904, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 82, OS thread handle 139640394565376, query id 11106759 192.168.1.10 sysbench updating
UPDATE sbtest16 SET k=k+1 WHERE id=1666846
---TRANSACTION 58548903, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 71, OS thread handle 139640046274304, query id 11106758 192.168.1.10 sysbench updating
UPDATE sbtest20 SET k=k+1 WHERE id=1700077
---TRANSACTION 58548902, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 77, OS thread handle 139640047355648, query id 11106757 192.168.1.10 sysbench updating
UPDATE sbtest5 SET k=k+1 WHERE id=1701333
---TRANSACTION 58548901, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 70, OS thread handle 139640046003968, query id 11106756 192.168.1.10 sysbench updating
UPDATE sbtest11 SET k=k+1 WHERE id=1510602
---TRANSACTION 58548900, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 79, OS thread handle 139640048707328, query id 11106753 192.168.1.10 sysbench updating
UPDATE sbtest8 SET k=k+1 WHERE id=1507224
---TRANSACTION 58548899, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 85, OS thread handle 139640392943360, query id 11106755 192.168.1.10 sysbench updating
UPDATE sbtest11 SET k=k+1 WHERE id=1502174
---TRANSACTION 58548898, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 73, OS thread handle 139640046544640, query id 11106743 192.168.1.10 sysbench updating
UPDATE sbtest2 SET k=k+1 WHERE id=1398108
---TRANSACTION 58548897, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 74, OS thread handle 139640394024704, query id 11106754 192.168.1.10 sysbench updating
UPDATE sbtest2 SET k=k+1 WHERE id=1514677
---TRANSACTION 58548896, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 68, OS thread handle 139640047085312, query id 11106769 192.168.1.10 sysbench updating
UPDATE sbtest10 SET c='11348636165-69248483789-30426505380-53087074532-23267135633-93316677793-24519552512-15198510401-06668317184-85227660496' WHERE id=1504960
---TRANSACTION 58548895, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 90, OS thread handle 139640393484032, query id 11106751 192.168.1.10 sysbench updating
UPDATE sbtest10 SET k=k+1 WHERE id=1492779
---TRANSACTION 58548894, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 92, OS thread handle 139640048436992, query id 11106750 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=1511893
---TRANSACTION 58548893, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 80, OS thread handle 139640395917056, query id 11106748 192.168.1.10 sysbench updating
UPDATE sbtest11 SET k=k+1 WHERE id=1407172
---TRANSACTION 58548892, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 94, OS thread handle 139640394295040, query id 11106747 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=1888276
---TRANSACTION 58548891, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 84, OS thread handle 139640696420096, query id 11106746 192.168.1.10 sysbench updating
UPDATE sbtest6 SET k=k+1 WHERE id=1498212
---TRANSACTION 58548890, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 95, OS thread handle 139640048166656, query id 11106745 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=1509871
---TRANSACTION 58548889, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 72, OS thread handle 139640047625984, query id 11106744 192.168.1.10 sysbench updating
UPDATE sbtest16 SET k=k+1 WHERE id=1503753
---TRANSACTION 58548888, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 89, OS thread handle 139640393754368, query id 11106742 192.168.1.10 sysbench updating
UPDATE sbtest9 SET k=k+1 WHERE id=1807019
---TRANSACTION 58548887, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 99, OS thread handle 139640045463296, query id 11106762 192.168.1.10 sysbench updating
UPDATE sbtest12 SET c='27545161166-28584675540-84818029730-83500148088-08119875729-64759768573-77481677234-07683016050-97099277857-89438346015' WHERE id=1493331
---TRANSACTION 58548886, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 76, OS thread handle 139640046814976, query id 11106767 192.168.1.10 sysbench updating
UPDATE sbtest6 SET c='02813144289-36316834086-26187649599-24269376196-61728221934-45401513219-60423836756-31120857553-79829726222-20767785192' WHERE id=1499714
---TRANSACTION 58548865, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 75, OS thread handle 139640393213696, query id 11106709 192.168.1.10 sysbench updating
UPDATE sbtest10 SET k=k+1 WHERE id=1493333
---TRANSACTION 58548833, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 93, OS thread handle 139640395106048, query id 11106683 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (1506083, 1230354, '00536003146-20515835603-39521922878-80014931369-11173561242-29541213634-41330415695-34198077646-12281821633-20377072070', '67995536574-06697511422-51541824548-62846860302-40003210125')
---TRANSACTION 58548820, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 78, OS thread handle 139640394835712, query id 11106667 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (1494166, 1024946, '18501059313-26309816280-28997349966-05962405470-23240905369-46885086263-17489211968-51906665056-68619704655-22009154103', '19689239784-19633627646-24169390095-62655274558-37911135775')
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
I/O thread 9 state: complete io for buf page (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 1
1164865 OS file reads, 6014923 OS file writes, 1123845 OS fsyncs
104.97 reads/s, 16384 avg bytes/read, 1590.85 writes/s, 331.42 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 0 merges
merged operations:
 insert 0, delete mark 0, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365399, node heap has 1 buffer(s)
Hash table size 2365399, node heap has 1 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 8565 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 1 buffer(s)
2952.51 hash searches/s, 8748.56 non-hash searches/s
---
LOG
---
Log sequence number 443598015553
Log flushed up to   443597807460
Pages flushed up to 443165252165
Last checkpoint at  443161327224
1 pending log flushes, 0 pending chkp writes
485337 log i/o's done, 117.75 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 259676
Buffer pool size   524256
Free buffers       2003
Database pages     513685
Old database pages 189581
Modified db pages  108277
Pending reads      0
Pending writes: LRU 0, flush list 123, single page 0
Pages made young 600069, not young 2085214
120.22 youngs/s, 384.40 non-youngs/s
Pages read 1158647, created 1810719, written 5318004
105.97 reads/s, 1.25 creates/s, 1448.39 writes/s
Buffer pool hit rate 999 / 1000, young-making rate 2 / 1000 not 6 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 513685, unzip_LRU len: 0
I/O sum[141156]:cur[1502], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1001
Database pages     256846
Old database pages 94792
Modified db pages  53931
Pending reads      0
Pending writes: LRU 0, flush list 61, single page 0
Pages made young 300272, not young 1041056
63.48 youngs/s, 196.20 non-youngs/s
Pages read 579288, created 905260, written 2657005
53.24 reads/s, 0.25 creates/s, 770.06 writes/s
Buffer pool hit rate 999 / 1000, young-making rate 2 / 1000 not 6 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 256846, unzip_LRU len: 0
I/O sum[70578]:cur[751], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262144
Free buffers       1002
Database pages     256839
Old database pages 94789
Modified db pages  54346
Pending reads      0
Pending writes: LRU 0, flush list 62, single page 0
Pages made young 299797, not young 1044158
56.74 youngs/s, 188.20 non-youngs/s
Pages read 579359, created 905459, written 2660999
52.74 reads/s, 1.00 creates/s, 678.33 writes/s
Buffer pool hit rate 999 / 1000, young-making rate 1 / 1000 not 6 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 256839, unzip_LRU len: 0
I/O sum[70578]:cur[751], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=13276, Main thread ID=139640824272640, state: sleeping
Number of rows inserted 121842270, updated 3685488, deleted 1842746, read 5528621
775.56 inserts/s, 1558.61 updates/s, 777.06 deletes/s, 2336.92 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.04 sec)

ERROR: 
No query specified



mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-22 15:28:48 0x7f00a8058700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 4 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 3118 srv_active, 0 srv_shutdown, 6569 srv_idle
srv_master_thread log flush and writes: 9687
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 6497433
--Thread 139640047355648 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640048166656 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640396187392 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640546084608 has waited at buf0flu.cc line 1422 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640696420096 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640393213696 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640045463296 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640719795968 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640696690432 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640394565376 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640393754368 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640046544640 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640394835712 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640394024704 has waited at row0ins.cc line 2998 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f01a21b9090 created in file buf0buf.cc line 1460
a writer (thread id 139640047896320) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139640395917056 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640395646720 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640393484032 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640047625984 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640394295040 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640048436992 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640047896320 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640047085312 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640048707328 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640396728064 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640044922624 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640045733632 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640395376384 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640046003968 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29463f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

OS WAIT ARRAY INFO: signal count 8269504
RW-shared spins 0, rounds 2710315, OS waits 64889
RW-excl spins 0, rounds 16355852, OS waits 157741
RW-sx spins 75365, rounds 2080542, OS waits 44710
Spin rounds per wait: 2710315.00 RW-shared, 16355852.00 RW-excl, 27.61 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 57649871
Purge done for trx's n:o < 57649797 undo n:o < 0 state: running
History list length 327
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421125060591216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421125060589392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 57649870, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 76, OS thread handle 139640046814976, query id 8409671 192.168.1.10 sysbench
---TRANSACTION 57649869, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 98, OS thread handle 139640045192960, query id 8409670 192.168.1.10 sysbench
---TRANSACTION 57649868, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 93, OS thread handle 139640395106048, query id 8409669 192.168.1.10 sysbench updating
UPDATE sbtest2 SET k=k+1 WHERE id=1508202
---TRANSACTION 57649867, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 71, OS thread handle 139640046274304, query id 8409667 192.168.1.10 sysbench updating
UPDATE sbtest6 SET k=k+1 WHERE id=1352820
---TRANSACTION 57649866, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 85, OS thread handle 139640392943360, query id 8409672 192.168.1.10 sysbench updating
UPDATE sbtest15 SET c='15052537091-31235070778-59727686576-51436665238-18879679183-51063367310-93605689865-77707893469-78915283813-16320820736' WHERE id=1497263
---TRANSACTION 57649865, ACTIVE 0 sec
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 69, OS thread handle 139640396457728, query id 8409668 192.168.1.10 sysbench
---TRANSACTION 57649858, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 88, OS thread handle 139640696690432, query id 8409659 192.168.1.10 sysbench updating
UPDATE sbtest18 SET c='96111617240-48457828590-42296554945-78171901291-87554573315-93705574477-50752647476-11863398756-11445551049-19934630218' WHERE id=1279182
---TRANSACTION 57649855, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 70, OS thread handle 139640046003968, query id 8409652 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (1503834, 1105555, '62169814443-72726198476-39043088599-11617244279-65831823468-07081475128-63833002884-10504599332-40096449644-47273913817', '89763851746-39225753707-80284463663-95338424944-70916747165')
---TRANSACTION 57649854, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 90, OS thread handle 139640393484032, query id 8409613 192.168.1.10 sysbench updating
UPDATE sbtest15 SET k=k+1 WHERE id=1507818
---TRANSACTION 57649852, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 79, OS thread handle 139640048707328, query id 8409609 192.168.1.10 sysbench updating
UPDATE sbtest2 SET k=k+1 WHERE id=1503856
---TRANSACTION 57649851, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 91, OS thread handle 139640395646720, query id 8409607 192.168.1.10 sysbench updating
UPDATE sbtest16 SET k=k+1 WHERE id=1402266
---TRANSACTION 57649850, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 74, OS thread handle 139640394024704, query id 8409646 192.168.1.10 sysbench update
INSERT INTO sbtest3 (id, k, c, pad) VALUES (1501627, 1501343, '13003987232-36628182220-66920765037-39681765674-24430413558-45886064773-59262972806-69518786071-96250783538-91149225717', '62853282665-54433403287-35363687090-34635786662-25628111717')
---TRANSACTION 57649849, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 81, OS thread handle 139640396728064, query id 8409604 192.168.1.10 sysbench updating
UPDATE sbtest19 SET k=k+1 WHERE id=1531309
---TRANSACTION 57649848, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 75, OS thread handle 139640393213696, query id 8409602 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=1512036
---TRANSACTION 57649847, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 82, OS thread handle 139640394565376, query id 8409630 192.168.1.10 sysbench updating
DELETE FROM sbtest17 WHERE id=1579993
---TRANSACTION 57649846, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 94, OS thread handle 139640394295040, query id 8409600 192.168.1.10 sysbench updating
UPDATE sbtest6 SET k=k+1 WHERE id=1507622
---TRANSACTION 57649845, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 80, OS thread handle 139640395917056, query id 8409599 192.168.1.10 sysbench updating
UPDATE sbtest15 SET k=k+1 WHERE id=1519017
---TRANSACTION 57649844, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 84, OS thread handle 139640696420096, query id 8409598 192.168.1.10 sysbench updating
UPDATE sbtest7 SET k=k+1 WHERE id=1141888
---TRANSACTION 57649842, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 77, OS thread handle 139640047355648, query id 8409596 192.168.1.10 sysbench updating
UPDATE sbtest3 SET k=k+1 WHERE id=1503520
---TRANSACTION 57649841, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 92, OS thread handle 139640048436992, query id 8409595 192.168.1.10 sysbench updating
UPDATE sbtest1 SET k=k+1 WHERE id=1635553
---TRANSACTION 57649839, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 96, OS thread handle 139640044922624, query id 8409593 192.168.1.10 sysbench updating
UPDATE sbtest1 SET k=k+1 WHERE id=1512643
---TRANSACTION 57649837, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 95, OS thread handle 139640048166656, query id 8409637 192.168.1.10 sysbench update
INSERT INTO sbtest19 (id, k, c, pad) VALUES (1507532, 1503659, '92554578456-76612043710-64621693577-76383634431-85427226924-13422724059-63736145583-15641515418-61129474375-54671601720', '25565380785-37729088582-62916184622-79472297066-24058822818')
---TRANSACTION 57649836, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 87, OS thread handle 139640396187392, query id 8409634 192.168.1.10 sysbench update
INSERT INTO sbtest1 (id, k, c, pad) VALUES (1112198, 1510360, '65971102105-08780152195-95118065746-80530613380-29957760440-00615215262-36420085262-73445250792-35508037534-06248753008', '62950739843-29176258600-73806023781-98288171201-85705920417')
---TRANSACTION 57649835, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 86, OS thread handle 139640047896320, query id 8409641 192.168.1.10 sysbench update
INSERT INTO sbtest3 (id, k, c, pad) VALUES (1513182, 1503144, '45410201854-71774978844-83139075257-25166123192-15414388406-53396976689-89961259870-93000013427-91909873328-24743586536', '38104906936-98936433980-89485293301-74106669675-58405542879')
---TRANSACTION 57649834, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 78, OS thread handle 139640394835712, query id 8409587 192.168.1.10 sysbench updating
UPDATE sbtest16 SET k=k+1 WHERE id=1382300
---TRANSACTION 57649833, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 72, OS thread handle 139640047625984, query id 8409632 192.168.1.10 sysbench update
INSERT INTO sbtest13 (id, k, c, pad) VALUES (1500090, 1498644, '41430654846-45521733145-07707387720-26441759561-69271718979-38734736327-67339903632-92464045516-74627809144-43552193654', '04994619347-80711797251-42851588399-43282047356-11928704228')
---TRANSACTION 57649806, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 73, OS thread handle 139640046544640, query id 8409556 192.168.1.10 sysbench updating
UPDATE sbtest14 SET k=k+1 WHERE id=1495062
---TRANSACTION 57649805, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 83, OS thread handle 139640395376384, query id 8409555 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=1503540
---TRANSACTION 57649803, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 97, OS thread handle 139640045733632, query id 8409552 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=1503752
---TRANSACTION 57649802, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 99, OS thread handle 139640045463296, query id 8409546 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=1975030
---TRANSACTION 57649801, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 89, OS thread handle 139640393754368, query id 8409545 192.168.1.10 sysbench updating
UPDATE sbtest14 SET k=k+1 WHERE id=1500377
---TRANSACTION 57649797, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 68, OS thread handle 139640047085312, query id 8409558 192.168.1.10 sysbench update
INSERT INTO sbtest6 (id, k, c, pad) VALUES (1587023, 1508040, '33186810641-31318906777-01193879592-17726687100-31731975991-17712488335-63106994152-07481313195-52344395339-76625234027', '59849013418-00437510726-29584371237-27600446164-95579913936')
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
I/O thread 7 state: complete io for buf page (write thread)
I/O thread 8 state: waiting for completed aio requests (write thread)
I/O thread 9 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 1
1063817 OS file reads, 5063794 OS file writes, 934636 OS fsyncs
127.97 reads/s, 16384 avg bytes/read, 1125.97 writes/s, 210.45 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 0 merges
merged operations:
 insert 0, delete mark 0, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365399, node heap has 1 buffer(s)
Hash table size 2365399, node heap has 1 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 1515 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 1 buffer(s)
1577.36 hash searches/s, 5735.32 non-hash searches/s
---
LOG
---
Log sequence number 440523408794
Log flushed up to   440523404814
Pages flushed up to 440070607161
Last checkpoint at  440048192914
0 pending log flushes, 0 pending chkp writes
418182 log i/o's done, 69.25 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 259676
Buffer pool size   524256
Free buffers       2032
Database pages     520705
Old database pages 192174
Modified db pages  89041
Pending reads      0
Pending writes: LRU 0, flush list 123, single page 0
Pages made young 517046, not young 1714743
119.47 youngs/s, 484.63 non-youngs/s
Pages read 1057597, created 1807665, written 4449455
129.22 reads/s, 8.00 creates/s, 1037.99 writes/s
Buffer pool hit rate 997 / 1000, young-making rate 3 / 1000 not 12 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 520705, unzip_LRU len: 0
I/O sum[145656]:cur[806], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1017
Database pages     260343
Old database pages 96084
Modified db pages  44300
Pending reads      0
Pending writes: LRU 0, flush list 58, single page 0
Pages made young 258793, not young 856004
56.99 youngs/s, 239.69 non-youngs/s
Pages read 528806, created 903692, written 2222631
62.98 reads/s, 3.50 creates/s, 526.12 writes/s
Buffer pool hit rate 997 / 1000, young-making rate 2 / 1000 not 11 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 260343, unzip_LRU len: 0
I/O sum[72828]:cur[403], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262144
Free buffers       1015
Database pages     260362
Old database pages 96090
Modified db pages  44741
Pending reads      0
Pending writes: LRU 0, flush list 65, single page 0
Pages made young 258253, not young 858739
62.48 youngs/s, 244.94 non-youngs/s
Pages read 528791, created 903973, written 2226824
66.23 reads/s, 4.50 creates/s, 511.87 writes/s
Buffer pool hit rate 997 / 1000, young-making rate 3 / 1000 not 12 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 260362, unzip_LRU len: 0
I/O sum[72828]:cur[403], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=13276, Main thread ID=139640824272640, state: sleeping
Number of rows inserted 121392763, updated 2786473, deleted 1393244, read 4180073
463.63 inserts/s, 929.52 updates/s, 463.38 deletes/s, 1390.40 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.05 sec)

ERROR: 
No query specified


mysql> show global status like '%wait%';
+-------------------------------+-------+
| Variable_name                 | Value |
+-------------------------------+-------+
| Innodb_buffer_pool_wait_free  | 0     |
| Innodb_log_waits              | 0     |
| Innodb_row_lock_current_waits | 0     |
| Innodb_row_lock_waits         | 407   |
| Table_locks_waited            | 0     |
| Tc_log_page_waits             | 0     |
+-------------------------------+-------+
6 rows in set (0.00 sec)



mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-22 15:44:17 0x7f00a8058700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 17 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 4035 srv_active, 0 srv_shutdown, 6569 srv_idle
srv_master_thread log flush and writes: 10604
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 6966713
--Thread 139640046003968 has waited at row0row.cc line 1075 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f01066ce518 created in file buf0buf.cc line 1460
a writer (thread id 139640047625984) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139640807487232 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640048436992 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640393213696 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640728188672 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640395106048 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640395917056 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640396457728 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640393484032 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640719795968 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640047625984 has waited at buf0lru.cc line 1139 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640696690432 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640046274304 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640046814976 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640395376384 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640396187392 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640396728064 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640048707328 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640046544640 has waited at row0row.cc line 1075 for 0.00 seconds the semaphore:
S-lock on RW-latch at 0x7f011f0fe9c8 created in file buf0buf.cc line 1460
a writer (thread id 139640395917056) has reserved it in mode  exclusive
number of readers 0, waiters flag 1, lock_word: 0
Last time read locked in file row0ins.cc line 2998
Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic line 153
--Thread 139640047355648 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640047896320 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640045192960 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640696420096 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 139640815879936 has waited at buf0lru.cc line 1320 for 0.00 seconds the semaphore:
Mutex at 0x29468b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

OS WAIT ARRAY INFO: signal count 8461005
RW-shared spins 0, rounds 2834643, OS waits 107662
RW-excl spins 0, rounds 20641443, OS waits 275050
RW-sx spins 113797, rounds 3159430, OS waits 67588
Spin rounds per wait: 2834643.00 RW-shared, 20641443.00 RW-excl, 27.76 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 58952394
Purge done for trx's n:o < 58952341 undo n:o < 0 state: running
History list length 521
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421125060611280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421125060591216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421125060589392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 58952392, ACTIVE 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 2
MySQL thread id 89, OS thread handle 139640393754368, query id 12317261 192.168.1.10 sysbench closing tables
---TRANSACTION 58952390, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 85, OS thread handle 139640392943360, query id 12317257 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952389, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 91, OS thread handle 139640395646720, query id 12317258 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952388, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 70, OS thread handle 139640046003968, query id 12317241 192.168.1.10 sysbench updating
DELETE FROM sbtest14 WHERE id=1494579
---TRANSACTION 58952387, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 76, OS thread handle 139640046814976, query id 12317196 192.168.1.10 sysbench updating
UPDATE sbtest19 SET k=k+1 WHERE id=1500519
---TRANSACTION 58952386, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 95, OS thread handle 139640048166656, query id 12317250 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952385, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 90, OS thread handle 139640393484032, query id 12317192 192.168.1.10 sysbench updating
UPDATE sbtest15 SET k=k+1 WHERE id=1506854
---TRANSACTION 58952384, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 81, OS thread handle 139640396728064, query id 12317193 192.168.1.10 sysbench updating
UPDATE sbtest17 SET k=k+1 WHERE id=974967
---TRANSACTION 58952383, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 74, OS thread handle 139640394024704, query id 12317251 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952382, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 96, OS thread handle 139640044922624, query id 12317256 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952381, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 79, OS thread handle 139640048707328, query id 12317186 192.168.1.10 sysbench updating
UPDATE sbtest7 SET k=k+1 WHERE id=1509766
---TRANSACTION 58952380, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 82, OS thread handle 139640394565376, query id 12317255 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952379, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 75, OS thread handle 139640393213696, query id 12317181 192.168.1.10 sysbench updating
UPDATE sbtest14 SET k=k+1 WHERE id=1456374
---TRANSACTION 58952378, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 3
MySQL thread id 73, OS thread handle 139640046544640, query id 12317219 192.168.1.10 sysbench updating
DELETE FROM sbtest4 WHERE id=1504863
---TRANSACTION 58952377, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
1 lock struct(s), heap size 1136, 0 row lock(s)
MySQL thread id 86, OS thread handle 139640047896320, query id 12317177 192.168.1.10 sysbench updating
UPDATE sbtest13 SET k=k+1 WHERE id=1125923
---TRANSACTION 58952376, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 99, OS thread handle 139640045463296, query id 12317249 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952375, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 98, OS thread handle 139640045192960, query id 12317175 192.168.1.10 sysbench updating
UPDATE sbtest3 SET k=k+1 WHERE id=1503658
---TRANSACTION 58952373, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 77, OS thread handle 139640047355648, query id 12317229 192.168.1.10 sysbench update
INSERT INTO sbtest19 (id, k, c, pad) VALUES (1505881, 1511483, '01396155618-23277026548-99601231296-64927403782-68639982194-79562625230-23837354204-20643461834-73514113802-43253384592', '02875760076-62346673020-16527322882-41783924399-58346305884')
---TRANSACTION 58952372, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 84, OS thread handle 139640696420096, query id 12317173 192.168.1.10 sysbench updating
UPDATE sbtest19 SET k=k+1 WHERE id=1366818
---TRANSACTION 58952371, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 72, OS thread handle 139640047625984, query id 12317233 192.168.1.10 sysbench update
INSERT INTO sbtest14 (id, k, c, pad) VALUES (1513321, 1495076, '41618588095-44934636894-20629219791-14837316409-69621281245-35588805353-96853425756-03791836540-79332664930-67352940439', '03075172544-69995048369-48703965275-19118524649-12789271836')
---TRANSACTION 58952370, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 71, OS thread handle 139640046274304, query id 12317170 192.168.1.10 sysbench updating
UPDATE sbtest1 SET k=k+1 WHERE id=1559710
---TRANSACTION 58952369, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 92, OS thread handle 139640048436992, query id 12317201 192.168.1.10 sysbench updating
UPDATE sbtest5 SET c='33360583918-70558209373-58340433604-11885447936-23803311268-00710410607-85250368033-93939299085-79996745164-73650500543' WHERE id=1665371
---TRANSACTION 58952368, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 80, OS thread handle 139640395917056, query id 12317168 192.168.1.10 sysbench updating
UPDATE sbtest4 SET k=k+1 WHERE id=1234452
---TRANSACTION 58952367, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 93, OS thread handle 139640395106048, query id 12317221 192.168.1.10 sysbench update
INSERT INTO sbtest1 (id, k, c, pad) VALUES (1496592, 1478553, '51366134066-48615231551-28559992353-47511611911-15080952515-00328241099-64887544233-37061358511-93543384103-56466096016', '19920685364-46089214395-49260645613-65450113782-73666018846')
---TRANSACTION 58952366, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 94, OS thread handle 139640394295040, query id 12317242 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952365, ACTIVE 0 sec inserting
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 87, OS thread handle 139640396187392, query id 12317224 192.168.1.10 sysbench update
INSERT INTO sbtest8 (id, k, c, pad) VALUES (1508496, 1499850, '32576665456-40793927143-91878228746-03182220238-02538037157-71170524189-94131642298-54928479666-57868475167-08084439498', '33654992010-19934512253-12623151460-35565412451-32288903610')
---TRANSACTION 58952364, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 88, OS thread handle 139640696690432, query id 12317203 192.168.1.10 sysbench updating
DELETE FROM sbtest3 WHERE id=1919335
---TRANSACTION 58952363, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 69, OS thread handle 139640396457728, query id 12317198 192.168.1.10 sysbench updating
DELETE FROM sbtest2 WHERE id=1474973
---TRANSACTION 58952362, ACTIVE (PREPARED) 0 sec
6 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 68, OS thread handle 139640047085312, query id 12317248 192.168.1.10 sysbench starting
COMMIT
---TRANSACTION 58952361, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
MySQL thread id 83, OS thread handle 139640395376384, query id 12317156 192.168.1.10 sysbench updating
UPDATE sbtest6 SET k=k+1 WHERE id=1579672
---TRANSACTION 58952360, ACTIVE (PREPARED) 0 sec
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 4
MySQL thread id 97, OS thread handle 139640045733632, query id 12317244 192.168.1.10 sysbench starting
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
I/O thread 9 state: complete io for buf page (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 1; buffer pool: 1
1189849 OS file reads, 6390123 OS file writes, 1203044 OS fsyncs
89.05 reads/s, 16384 avg bytes/read, 1481.85 writes/s, 322.92 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 0 merges
merged operations:
 insert 0, delete mark 0, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365399, node heap has 1 buffer(s)
Hash table size 2365399, node heap has 1 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 11724 buffer(s)
Hash table size 2365399, node heap has 0 buffer(s)
Hash table size 2365399, node heap has 1 buffer(s)
3371.04 hash searches/s, 9173.05 non-hash searches/s
---
LOG
---
Log sequence number 444697254800
Log flushed up to   444697253664
Pages flushed up to 444266295455
Last checkpoint at  444248685619
1 pending log flushes, 0 pending chkp writes
515871 log i/o's done, 128.35 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 259676
Buffer pool size   524256
Free buffers       1993
Database pages     510536
Old database pages 188423
Modified db pages  113278
Pending reads      1
Pending writes: LRU 0, flush list 121, single page 0
Pages made young 627896, not young 2176844
102.64 youngs/s, 331.04 non-youngs/s
Pages read 1183629, created 1811185, written 5656680
89.17 reads/s, 1.76 creates/s, 1330.16 writes/s
Buffer pool hit rate 999 / 1000, young-making rate 1 / 1000 not 5 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 510536, unzip_LRU len: 0
I/O sum[137912]:cur[1604], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       996
Database pages     255269
Old database pages 94212
Modified db pages  57024
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 314175, not young 1086448
50.88 youngs/s, 167.99 non-youngs/s
Pages read 591720, created 905521, written 2825942
45.53 reads/s, 0.59 creates/s, 620.49 writes/s
Buffer pool hit rate 999 / 1000, young-making rate 1 / 1000 not 5 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 255269, unzip_LRU len: 0
I/O sum[68956]:cur[741], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262144
Free buffers       997
Database pages     255267
Old database pages 94211
Modified db pages  56254
Pending reads      1
Pending writes: LRU 0, flush list 121, single page 0
Pages made young 313721, not young 1090396
51.76 youngs/s, 163.05 non-youngs/s
Pages read 591909, created 905664, written 2830738
43.64 reads/s, 1.18 creates/s, 709.66 writes/s
Buffer pool hit rate 999 / 1000, young-making rate 1 / 1000 not 5 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 255267, unzip_LRU len: 0
I/O sum[68956]:cur[863], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=13276, Main thread ID=139640824272640, state: sleeping
Number of rows inserted 122044017, updated 4088988, deleted 2044499, read 6133882
837.95 inserts/s, 1677.96 updates/s, 838.60 deletes/s, 2516.91 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.03 sec)

ERROR: 
No query specified




