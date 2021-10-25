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

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 --table-size=2000000 --threads=8 --time=600 --report-interval=10 --db-driver=mysql prepare &



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


purge binary logs to 'mysql-bin.000339';  



sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 \
--table-size=2000000 --threads=8 --time=600 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_8_11_vesion7.log &


[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_8_11_vesion7.log
Number of threads: 8
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 8 tps: 756.96 qps: 4544.59 (r/w/o: 0.00/3029.96/1514.63) lat (ms,95%): 15.00 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 8 tps: 797.60 qps: 4785.11 (r/w/o: 0.00/3189.91/1595.20) lat (ms,95%): 12.52 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 8 tps: 761.70 qps: 4570.80 (r/w/o: 0.00/3047.30/1523.50) lat (ms,95%): 15.55 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 8 tps: 748.90 qps: 4491.89 (r/w/o: 0.00/2994.09/1497.80) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 8 tps: 760.60 qps: 4565.71 (r/w/o: 0.00/3044.51/1521.20) lat (ms,95%): 18.61 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 8 tps: 723.10 qps: 4338.31 (r/w/o: 0.00/2892.10/1446.20) lat (ms,95%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 8 tps: 706.60 qps: 4240.11 (r/w/o: 0.00/2826.90/1413.20) lat (ms,95%): 26.68 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 8 tps: 723.40 qps: 4338.39 (r/w/o: 0.00/2891.60/1446.80) lat (ms,95%): 26.20 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 8 tps: 748.60 qps: 4493.48 (r/w/o: 0.00/2996.29/1497.19) lat (ms,95%): 23.10 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 8 tps: 765.50 qps: 4591.42 (r/w/o: 0.00/3060.41/1531.01) lat (ms,95%): 21.89 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 8 tps: 331.40 qps: 1990.40 (r/w/o: 0.00/1327.60/662.80) lat (ms,95%): 81.48 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 8 tps: 392.30 qps: 2351.69 (r/w/o: 0.00/1567.09/784.60) lat (ms,95%): 80.03 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 8 tps: 530.50 qps: 3182.50 (r/w/o: 0.00/2121.50/1061.00) lat (ms,95%): 55.82 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 8 tps: 614.70 qps: 3689.22 (r/w/o: 0.00/2459.81/1229.41) lat (ms,95%): 36.89 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 8 tps: 664.00 qps: 3982.89 (r/w/o: 0.00/2654.89/1328.00) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 8 tps: 682.00 qps: 4093.21 (r/w/o: 0.00/2729.21/1364.00) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 8 tps: 667.59 qps: 4006.15 (r/w/o: 0.00/2671.06/1335.08) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 8 tps: 599.60 qps: 3597.92 (r/w/o: 0.00/2398.61/1199.31) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 8 tps: 581.91 qps: 3490.34 (r/w/o: 0.00/2326.52/1163.81) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 8 tps: 589.99 qps: 3539.94 (r/w/o: 0.00/2359.96/1179.98) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 8 tps: 622.11 qps: 3732.95 (r/w/o: 0.00/2488.73/1244.22) lat (ms,95%): 37.56 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 8 tps: 689.40 qps: 4136.01 (r/w/o: 0.00/2757.21/1378.80) lat (ms,95%): 26.20 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 8 tps: 736.00 qps: 4415.90 (r/w/o: 0.00/2943.90/1472.00) lat (ms,95%): 24.38 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 8 tps: 725.80 qps: 4354.39 (r/w/o: 0.00/2902.79/1451.60) lat (ms,95%): 24.83 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 8 tps: 705.30 qps: 4233.20 (r/w/o: 0.00/2822.60/1410.60) lat (ms,95%): 25.28 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 8 tps: 643.19 qps: 3859.07 (r/w/o: 0.00/2572.68/1286.39) lat (ms,95%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 8 tps: 656.91 qps: 3942.03 (r/w/o: 0.00/2628.22/1313.81) lat (ms,95%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 8 tps: 663.00 qps: 3976.30 (r/w/o: 0.00/2650.30/1326.00) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 8 tps: 669.10 qps: 4014.69 (r/w/o: 0.00/2676.50/1338.20) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 8 tps: 670.20 qps: 4020.32 (r/w/o: 0.00/2680.01/1340.31) lat (ms,95%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 8 tps: 690.60 qps: 4144.11 (r/w/o: 0.00/2762.81/1381.30) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 8 tps: 742.70 qps: 4457.87 (r/w/o: 0.00/2972.58/1485.29) lat (ms,95%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 8 tps: 726.20 qps: 4355.81 (r/w/o: 0.00/2903.41/1452.40) lat (ms,95%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 8 tps: 677.70 qps: 4066.41 (r/w/o: 0.00/2711.01/1355.40) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 8 tps: 700.99 qps: 4205.32 (r/w/o: 0.00/2803.35/1401.97) lat (ms,95%): 25.28 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 8 tps: 686.91 qps: 4122.06 (r/w/o: 0.00/2748.44/1373.62) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 8 tps: 696.00 qps: 4175.13 (r/w/o: 0.00/2782.82/1392.31) lat (ms,95%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 8 tps: 717.79 qps: 4309.16 (r/w/o: 0.00/2873.58/1435.59) lat (ms,95%): 24.38 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 8 tps: 743.40 qps: 4460.17 (r/w/o: 0.00/2973.38/1486.79) lat (ms,95%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 8 tps: 769.41 qps: 4616.45 (r/w/o: 0.00/3077.63/1538.82) lat (ms,95%): 20.74 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 8 tps: 766.60 qps: 4598.39 (r/w/o: 0.00/3065.19/1533.20) lat (ms,95%): 21.50 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 8 tps: 722.00 qps: 4331.82 (r/w/o: 0.00/2887.91/1443.91) lat (ms,95%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 8 tps: 704.40 qps: 4227.69 (r/w/o: 0.00/2818.79/1408.90) lat (ms,95%): 24.83 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 8 tps: 715.50 qps: 4292.32 (r/w/o: 0.00/2861.31/1431.01) lat (ms,95%): 25.28 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 8 tps: 706.00 qps: 4237.40 (r/w/o: 0.00/2825.40/1412.00) lat (ms,95%): 25.74 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 8 tps: 724.70 qps: 4346.29 (r/w/o: 0.00/2896.89/1449.40) lat (ms,95%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 8 tps: 769.59 qps: 4616.94 (r/w/o: 0.00/3077.86/1539.08) lat (ms,95%): 19.29 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 8 tps: 774.21 qps: 4645.94 (r/w/o: 0.00/3097.53/1548.41) lat (ms,95%): 19.65 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 8 tps: 780.30 qps: 4682.12 (r/w/o: 0.00/3121.41/1560.71) lat (ms,95%): 18.28 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 8 tps: 774.99 qps: 4651.05 (r/w/o: 0.00/3101.07/1549.98) lat (ms,95%): 18.61 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 8 tps: 770.21 qps: 4619.94 (r/w/o: 0.00/3079.53/1540.41) lat (ms,95%): 19.65 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 8 tps: 772.60 qps: 4635.71 (r/w/o: 0.00/3090.61/1545.10) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 8 tps: 770.20 qps: 4622.41 (r/w/o: 0.00/3081.91/1540.50) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 8 tps: 736.99 qps: 4420.05 (r/w/o: 0.00/2946.17/1473.88) lat (ms,95%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 8 tps: 736.10 qps: 4417.81 (r/w/o: 0.00/2945.50/1472.30) lat (ms,95%): 23.10 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 8 tps: 751.20 qps: 4505.52 (r/w/o: 0.00/3003.11/1502.41) lat (ms,95%): 21.11 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 8 tps: 744.40 qps: 4468.09 (r/w/o: 0.00/2979.39/1488.70) lat (ms,95%): 20.74 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 8 tps: 775.10 qps: 4649.69 (r/w/o: 0.00/3099.39/1550.30) lat (ms,95%): 18.95 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 8 tps: 786.70 qps: 4721.92 (r/w/o: 0.00/3148.52/1573.41) lat (ms,95%): 17.63 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 8 tps: 775.10 qps: 4648.79 (r/w/o: 0.00/3098.59/1550.20) lat (ms,95%): 18.61 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           1685500
        other:                           842750
        total:                           2528250
    transactions:                        421375 (702.25 per sec.)
    queries:                             2528250 (4213.50 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          600.0344s
    total number of events:              421375

Latency (ms):
         min:                                    7.10
         avg:                                   11.39
         max:                                  171.31
         95th percentile:                       24.83
         sum:                              4798911.19

Threads fairness:
    events (avg/stddev):           52671.8750/145.95
    execution time (avg/stddev):   599.8639/0.01

[root@voice data]# top
top - 14:45:18 up 100 days, 23:43,  4 users,  load average: 3.79, 2.87, 2.20
Tasks: 122 total,   1 running, 121 sleeping,   0 stopped,   0 zombie
%Cpu0  : 20.6 us, 13.9 sy,  0.0 ni, 46.6 id, 15.3 wa,  0.0 hi,  3.6 si,  0.0 st
%Cpu1  : 25.2 us, 13.6 sy,  0.0 ni, 44.9 id, 15.3 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu2  : 27.0 us, 11.8 sy,  0.0 ni, 44.3 id, 15.2 wa,  0.0 hi,  1.7 si,  0.0 st
%Cpu3  : 22.4 us, 10.5 sy,  0.0 ni, 51.2 id, 15.3 wa,  0.0 hi,  0.7 si,  0.0 st
KiB Mem : 16266300 total,   152728 free, 11696040 used,  4417532 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  3428124 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
23867 mysql     20   0   15.2g  10.6g   5260 S 151.5 68.3  28:20.30 mysqld                 



[root@voice data]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/25/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.14    2.35   13.30     0.15     0.51    86.22     0.19   12.33   25.41   10.02   0.53   0.83

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     2.00   14.00 2846.00     0.10    47.05    33.77     1.69    0.60    1.21    0.59   0.30  86.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 2795.00     0.00    46.84    34.32     1.62    0.58    0.00    0.58   0.31  87.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 2805.00     0.00    47.70    34.83     1.64    0.59    0.00    0.59   0.31  87.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 2822.00     0.00    47.08    34.17     1.64    0.58    0.00    0.58   0.31  87.30

^C
[root@voice data]# iostat  1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/25/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.75    0.00    0.73    0.25    0.00   98.27

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              15.65       152.85       521.54 1333677758 4550641504

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          26.14    0.00   15.48   12.18    0.00   46.19

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2856.00         0.00     49236.00          0      49236

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          26.09    0.00   15.60   12.28    0.00   46.04

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2746.00         0.00     47420.00          0      47420

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          25.77    0.00   15.72   11.86    0.00   46.65

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2878.00         0.00     47576.00          0      47576
