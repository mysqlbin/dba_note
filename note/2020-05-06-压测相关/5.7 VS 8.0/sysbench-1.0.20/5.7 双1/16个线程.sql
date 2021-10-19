


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
		
set global sync_binlog=0;
set global innodb_flush_log_at_trx_commit=0;
 
mysql -uroot -p'' sbtest < sbtest.sql &




/etc/init.d/mysql restart 

set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;

sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='' \
--mysql-db=sbtest \
--num-threads=16 \
--oltp-table-size=5000000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=1800 \
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_16_.log &


mysql> show processlist;
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db     | Command | Time | State                  | Info                                                                                                 |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL   | Daemon  |  878 | Waiting on empty queue | NULL                                                                                                 |
|  3 | root            | localhost          | sbtest | Query   |    0 | starting               | show processlist                                                                                     |
|  4 | sysbench        | 192.168.1.12:49765 | sbtest | Query   |    0 | statistics             | SELECT SUM(K) FROM sbtest9 WHERE id BETWEEN 2812856 AND 2812955                                      |
|  5 | sysbench        | 192.168.1.12:49764 | sbtest | Query   |    0 | updating               | DELETE FROM sbtest9 WHERE id=3927475                                                                 |
|  6 | sysbench        | 192.168.1.12:49772 | sbtest | Query   |    0 | statistics             | SELECT DISTINCT c FROM sbtest8 WHERE id BETWEEN 1326280 AND 1326379 ORDER BY c                       |
|  7 | sysbench        | 192.168.1.12:49766 | sbtest | Query   |    0 | updating               | UPDATE sbtest7 SET c='18941872629-03801075586-86883758186-12358923130-09256002645-41305659045-679837 |
|  8 | sysbench        | 192.168.1.12:49774 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest8 WHERE id=4704779                                                               |
|  9 | sysbench        | 192.168.1.12:49778 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest9 WHERE id=654889                                                                |
| 10 | sysbench        | 192.168.1.12:49776 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest3 WHERE id=3561506                                                               |
| 11 | sysbench        | 192.168.1.12:49780 | sbtest | Query   |    0 | updating               | UPDATE sbtest1 SET k=k+1 WHERE id=1700649                                                            |
| 12 | sysbench        | 192.168.1.12:49782 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest8 WHERE id=367066                                                                |
| 13 | sysbench        | 192.168.1.12:49786 | sbtest | Query   |    0 | updating               | UPDATE sbtest2 SET c='07568058055-38856703204-06125808164-30535572466-19171679948-77706763292-939793 |
| 14 | sysbench        | 192.168.1.12:49784 | sbtest | Query   |    0 | statistics             | SELECT SUM(K) FROM sbtest3 WHERE id BETWEEN 4441530 AND 4441629                                      |
| 15 | sysbench        | 192.168.1.12:49790 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest2 WHERE id=3762415                                                               |
| 16 | sysbench        | 192.168.1.12:49788 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest6 WHERE id BETWEEN 4347872 AND 4347971                                           |
| 17 | sysbench        | 192.168.1.12:49796 | sbtest | Query   |    0 | statistics             | SELECT SUM(K) FROM sbtest8 WHERE id BETWEEN 4359840 AND 4359939                                      |
| 18 | sysbench        | 192.168.1.12:49792 | sbtest | Query   |    0 | statistics             | SELECT DISTINCT c FROM sbtest4 WHERE id BETWEEN 924776 AND 924875 ORDER BY c                         |
| 19 | sysbench        | 192.168.1.12:49794 | sbtest | Query   |    0 | statistics             | SELECT c FROM sbtest1 WHERE id=2755420                                                               |
+----+-----------------+--------------------+--------+---------+------+------------------------+------------------------------------------------------------------------------------------------------+
18 rows in set (0.00 sec)


[coding001@voice ~]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/15/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.39    0.00    0.63    0.05    0.00   98.94

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               2.98        37.29        71.36  293582575  561770532

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          20.45    0.00   10.35   67.68    0.00    1.52

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1534.00     49088.00      6948.00      49088       6948

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.33    0.00    9.69   73.72    0.00    0.26

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1311.00     49184.00      6808.00      49184       6808

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.28    0.00   10.43   69.47    0.00    3.82

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1732.00     49196.00      6884.00      49196       6884

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          17.68    0.00   11.62   69.44    0.00    1.26

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1185.00     49184.00      4184.00      49184       4184

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          11.96    0.00    6.87   79.64    0.00    1.53

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1371.00     49308.00     10072.00      49308      10072

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          16.84    0.00   11.48   70.66    0.00    1.02

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1283.00     49160.00      6076.00      49160       6076

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          19.75    0.00   11.65   67.85    0.00    0.76

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1345.00     49020.00      5448.00      49020       5448

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.29    0.00    9.44   75.26    0.00    1.02

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1194.00     49120.00      5116.00      49120       5116

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.97    0.00   10.15   74.87    0.00    0.00

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1183.00     49176.00      5200.00      49176       5200

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           9.44    0.00    5.87   83.93    0.00    0.77

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1056.00     49080.00      1244.00      49080       1244

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          12.34    0.00    7.30   79.35    0.00    1.01

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1473.00     49168.00     10628.00      49168      10628


[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/15/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    0.53    2.46     0.04     0.07    72.89     0.02    6.37   22.17    2.97   0.59   0.18

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  732.00  855.00    47.94     9.70    74.38    32.33   20.32   43.18    0.74   0.63 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00  830.00 1023.00    48.11    12.58    67.07    29.27   15.21   33.14    0.65   0.54 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  780.00  707.00    48.03     5.64    73.92    29.02   20.24   38.01    0.64   0.67 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  739.00  505.00    47.92     5.68    88.25    37.01   29.93   49.87    0.75   0.80 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  813.00  840.00    48.00     8.88    70.47    33.33   19.94   39.85    0.66   0.60 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  840.00  810.00    48.06     7.28    68.69    26.99   16.49   31.75    0.66   0.61  99.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  876.00  555.00    47.99     5.93    77.17    30.44   21.30   34.37    0.68   0.70 100.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  727.00  958.00    48.03    10.46    71.09    29.97   16.87   38.30    0.60   0.59 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  787.00  591.00    47.88     4.95    78.51    32.21   24.60   42.55    0.71   0.73 100.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  765.00  715.00    48.03     7.81    77.28    28.71   19.39   36.90    0.65   0.68 100.00



[coding001@voice ~]$ top
top - 18:04:15 up 91 days,  3:02,  4 users,  load average: 17.85, 17.89, 14.21
Tasks: 121 total,   1 running, 119 sleeping,   1 stopped,   0 zombie
%Cpu0  : 16.3 us, 10.4 sy,  0.0 ni,  4.8 id, 65.7 wa,  0.0 hi,  2.8 si,  0.0 st
%Cpu1  : 19.0 us, 10.8 sy,  0.0 ni,  0.7 id, 68.5 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu2  : 15.1 us,  9.4 sy,  0.0 ni,  3.7 id, 70.6 wa,  0.0 hi,  1.3 si,  0.0 st
%Cpu3  : 13.5 us,  6.8 sy,  0.0 ni,  0.0 id, 78.4 wa,  0.0 hi,  1.4 si,  0.0 st
KiB Mem : 16266300 total,   172184 free,  9872412 used,  6221704 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5370944 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                  
24103 mysql     20   0   11.4g   8.9g   4604 S  94.7 57.1  21:01.50 mysqld                                                                                                                                                                   
24202 coding0+  20   0 1156100   7904   1320 S  13.6  0.0   3:05.63 sysbench       







[coding001@voice ~]$ cat sysbench_oltpX_16_.log
WARNING: --num-threads is deprecated, use --threads instead
WARNING: --max-time is deprecated, use --time instead
sysbench 1.0.20 (using bundled LuaJIT 2.1.0-beta2)

Running the test with following options:
Number of threads: 16
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 16 tps: 133.55 qps: 2686.42 (r/w/o: 1883.31/534.40/268.70) lat (ms,99%): 861.95 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 16 tps: 40.10 qps: 806.38 (r/w/o: 565.56/160.62/80.21) lat (ms,99%): 846.57 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 16 tps: 38.50 qps: 768.34 (r/w/o: 537.06/154.29/76.99) lat (ms,99%): 926.33 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 16 tps: 41.30 qps: 824.56 (r/w/o: 577.14/164.81/82.61) lat (ms,99%): 1032.01 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 16 tps: 45.20 qps: 905.80 (r/w/o: 634.50/180.90/90.40) lat (ms,99%): 1129.24 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 16 tps: 43.60 qps: 873.07 (r/w/o: 611.08/174.79/87.20) lat (ms,99%): 977.74 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 16 tps: 39.90 qps: 793.66 (r/w/o: 554.57/159.29/79.80) lat (ms,99%): 1013.60 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 16 tps: 52.70 qps: 1055.11 (r/w/o: 739.01/210.70/105.40) lat (ms,99%): 846.57 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 16 tps: 50.80 qps: 1010.67 (r/w/o: 706.05/203.01/101.61) lat (ms,99%): 861.95 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 16 tps: 55.80 qps: 1120.10 (r/w/o: 785.30/223.20/111.60) lat (ms,99%): 816.63 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 16 tps: 66.50 qps: 1331.22 (r/w/o: 931.55/266.68/132.99) lat (ms,99%): 733.00 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 16 tps: 71.50 qps: 1429.79 (r/w/o: 1001.57/285.22/143.01) lat (ms,99%): 694.45 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 16 tps: 80.89 qps: 1619.07 (r/w/o: 1133.51/323.77/161.79) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 16 tps: 80.21 qps: 1602.51 (r/w/o: 1121.48/320.62/160.41) lat (ms,99%): 569.67 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 16 tps: 93.10 qps: 1860.60 (r/w/o: 1302.10/372.30/186.20) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 16 tps: 94.70 qps: 1893.01 (r/w/o: 1324.71/378.90/189.40) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 16 tps: 83.10 qps: 1666.50 (r/w/o: 1167.60/332.70/166.20) lat (ms,99%): 559.50 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 16 tps: 81.40 qps: 1627.00 (r/w/o: 1138.70/325.50/162.80) lat (ms,99%): 569.67 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 16 tps: 78.60 qps: 1570.71 (r/w/o: 1099.21/314.30/157.20) lat (ms,99%): 623.33 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 16 tps: 84.40 qps: 1689.80 (r/w/o: 1183.30/337.70/168.80) lat (ms,99%): 590.56 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 16 tps: 71.10 qps: 1421.08 (r/w/o: 994.49/284.40/142.20) lat (ms,99%): 682.06 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 16 tps: 64.70 qps: 1294.81 (r/w/o: 906.41/259.00/129.40) lat (ms,99%): 682.06 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 16 tps: 65.20 qps: 1303.78 (r/w/o: 912.79/260.60/130.40) lat (ms,99%): 612.21 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 16 tps: 59.40 qps: 1188.75 (r/w/o: 832.26/237.69/118.79) lat (ms,99%): 669.89 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 16 tps: 66.50 qps: 1326.79 (r/w/o: 928.06/265.72/133.01) lat (ms,99%): 694.45 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 16 tps: 70.89 qps: 1418.89 (r/w/o: 993.43/283.68/141.79) lat (ms,99%): 623.33 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 16 tps: 79.90 qps: 1596.00 (r/w/o: 1116.77/319.52/159.71) lat (ms,99%): 559.50 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 16 tps: 72.60 qps: 1455.22 (r/w/o: 1019.12/290.80/145.30) lat (ms,99%): 646.19 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 16 tps: 86.00 qps: 1721.80 (r/w/o: 1206.20/343.60/172.00) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 16 tps: 99.60 qps: 1989.80 (r/w/o: 1392.20/398.40/199.20) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 16 tps: 103.80 qps: 2077.88 (r/w/o: 1454.39/415.90/207.60) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 16 tps: 102.70 qps: 2055.01 (r/w/o: 1439.01/410.60/205.40) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 16 tps: 109.90 qps: 2192.71 (r/w/o: 1533.40/439.50/219.80) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 16 tps: 113.10 qps: 2267.49 (r/w/o: 1588.19/453.10/226.20) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 16 tps: 107.40 qps: 2148.42 (r/w/o: 1504.41/429.20/214.80) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 16 tps: 126.80 qps: 2537.77 (r/w/o: 1776.58/507.59/253.60) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 16 tps: 128.90 qps: 2573.59 (r/w/o: 1801.30/514.50/257.80) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 16 tps: 117.80 qps: 2352.89 (r/w/o: 1645.79/471.50/235.60) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 16 tps: 124.90 qps: 2500.71 (r/w/o: 1751.50/499.40/249.80) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 16 tps: 125.70 qps: 2510.34 (r/w/o: 1756.22/502.71/251.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 16 tps: 129.98 qps: 2598.07 (r/w/o: 1818.50/519.81/259.76) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 16 tps: 134.62 qps: 2698.24 (r/w/o: 1890.31/538.49/269.44) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 16 tps: 136.80 qps: 2731.80 (r/w/o: 1910.80/547.40/273.60) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 16 tps: 135.10 qps: 2704.62 (r/w/o: 1894.21/540.20/270.20) lat (ms,99%): 344.08 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 16 tps: 119.70 qps: 2394.79 (r/w/o: 1675.99/479.40/239.40) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 16 tps: 128.20 qps: 2561.09 (r/w/o: 1792.49/512.20/256.40) lat (ms,99%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 16 tps: 128.30 qps: 2564.81 (r/w/o: 1794.91/513.30/256.60) lat (ms,99%): 325.98 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 16 tps: 117.40 qps: 2351.21 (r/w/o: 1646.61/469.80/234.80) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 16 tps: 122.10 qps: 2444.31 (r/w/o: 1711.50/488.60/244.20) lat (ms,99%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 16 tps: 123.00 qps: 2455.60 (r/w/o: 1718.10/491.50/246.00) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 16 tps: 122.80 qps: 2455.70 (r/w/o: 1718.90/491.20/245.60) lat (ms,99%): 363.18 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 16 tps: 121.30 qps: 2431.60 (r/w/o: 1703.70/485.30/242.60) lat (ms,99%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 16 tps: 115.00 qps: 2297.40 (r/w/o: 1607.30/460.10/230.00) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 16 tps: 112.70 qps: 2258.89 (r/w/o: 1582.09/451.40/225.40) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 16 tps: 108.90 qps: 2173.80 (r/w/o: 1520.80/435.20/217.80) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 16 tps: 114.30 qps: 2288.80 (r/w/o: 1601.50/458.70/228.60) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 16 tps: 109.90 qps: 2187.76 (r/w/o: 1530.27/437.69/219.80) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 16 tps: 120.10 qps: 2408.05 (r/w/o: 1687.33/480.51/240.20) lat (ms,99%): 350.33 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 16 tps: 107.20 qps: 2145.21 (r/w/o: 1501.91/428.90/214.40) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 16 tps: 103.50 qps: 2069.59 (r/w/o: 1448.60/414.00/207.00) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 16 tps: 106.70 qps: 2132.80 (r/w/o: 1492.60/426.80/213.40) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 16 tps: 95.10 qps: 1906.40 (r/w/o: 1334.80/381.40/190.20) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 16 tps: 107.50 qps: 2145.30 (r/w/o: 1501.10/429.20/215.00) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 16 tps: 117.40 qps: 2347.29 (r/w/o: 1642.70/469.80/234.80) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 16 tps: 109.50 qps: 2195.01 (r/w/o: 1538.31/437.70/219.00) lat (ms,99%): 383.33 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 16 tps: 105.80 qps: 2113.79 (r/w/o: 1479.30/422.90/211.60) lat (ms,99%): 369.77 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 16 tps: 116.10 qps: 2322.90 (r/w/o: 1624.50/466.20/232.20) lat (ms,99%): 376.49 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 16 tps: 109.40 qps: 2184.08 (r/w/o: 1529.19/436.10/218.80) lat (ms,99%): 356.70 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 16 tps: 107.40 qps: 2146.42 (r/w/o: 1502.11/429.50/214.80) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 16 tps: 108.80 qps: 2179.39 (r/w/o: 1526.09/435.70/217.60) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 16 tps: 106.00 qps: 2123.76 (r/w/o: 1486.77/424.99/212.00) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 16 tps: 104.00 qps: 2078.25 (r/w/o: 1455.63/414.61/208.00) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 16 tps: 103.00 qps: 2058.15 (r/w/o: 1440.06/412.09/205.99) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 16 tps: 95.90 qps: 1918.14 (r/w/o: 1343.13/383.21/191.80) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 16 tps: 106.90 qps: 2139.30 (r/w/o: 1496.90/428.60/213.80) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 16 tps: 100.50 qps: 2006.61 (r/w/o: 1404.00/401.60/201.00) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 16 tps: 96.30 qps: 1927.70 (r/w/o: 1350.40/384.70/192.60) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 16 tps: 99.70 qps: 1993.21 (r/w/o: 1395.10/398.70/199.40) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 16 tps: 110.50 qps: 2215.46 (r/w/o: 1551.17/443.29/221.00) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 16 tps: 106.20 qps: 2119.85 (r/w/o: 1483.03/424.41/212.40) lat (ms,99%): 397.39 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 16 tps: 104.09 qps: 2077.24 (r/w/o: 1453.59/415.47/208.18) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 16 tps: 98.99 qps: 1986.16 (r/w/o: 1392.10/396.07/197.99) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 16 tps: 88.11 qps: 1759.63 (r/w/o: 1230.49/352.93/176.21) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 16 tps: 103.31 qps: 2070.10 (r/w/o: 1449.97/413.52/206.61) lat (ms,99%): 411.96 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 16 tps: 95.20 qps: 1900.08 (r/w/o: 1329.38/380.30/190.40) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 16 tps: 91.20 qps: 1822.45 (r/w/o: 1275.53/364.51/182.40) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 16 tps: 87.20 qps: 1751.32 (r/w/o: 1226.91/350.00/174.40) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 16 tps: 93.50 qps: 1865.08 (r/w/o: 1305.18/372.90/187.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 16 tps: 88.30 qps: 1765.59 (r/w/o: 1235.39/353.60/176.60) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 16 tps: 84.70 qps: 1690.32 (r/w/o: 1182.32/338.60/169.40) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 16 tps: 95.80 qps: 1922.16 (r/w/o: 1347.18/383.39/191.60) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 16 tps: 92.50 qps: 1845.03 (r/w/o: 1290.42/369.61/185.00) lat (ms,99%): 657.93 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 16 tps: 84.70 qps: 1698.90 (r/w/o: 1190.60/338.90/169.40) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 16 tps: 95.90 qps: 1919.98 (r/w/o: 1343.19/385.00/191.80) lat (ms,99%): 404.61 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 16 tps: 93.40 qps: 1867.32 (r/w/o: 1308.41/372.10/186.80) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 16 tps: 96.49 qps: 1925.59 (r/w/o: 1346.42/386.18/192.99) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 16 tps: 88.50 qps: 1774.40 (r/w/o: 1243.27/354.12/177.01) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 16 tps: 82.60 qps: 1645.59 (r/w/o: 1150.50/329.90/165.20) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 16 tps: 89.70 qps: 1794.50 (r/w/o: 1255.90/359.20/179.40) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 16 tps: 83.70 qps: 1675.81 (r/w/o: 1173.61/334.80/167.40) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 16 tps: 88.20 qps: 1766.49 (r/w/o: 1237.49/352.60/176.40) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 16 tps: 90.00 qps: 1799.50 (r/w/o: 1259.00/360.50/180.00) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 16 tps: 89.80 qps: 1797.89 (r/w/o: 1258.49/359.80/179.60) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 16 tps: 92.49 qps: 1848.94 (r/w/o: 1294.82/369.15/184.97) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 16 tps: 79.61 qps: 1588.84 (r/w/o: 1111.57/318.05/159.22) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 16 tps: 92.80 qps: 1856.58 (r/w/o: 1299.59/371.40/185.60) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 16 tps: 82.20 qps: 1641.02 (r/w/o: 1147.91/328.70/164.40) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 16 tps: 88.20 qps: 1769.00 (r/w/o: 1239.50/353.10/176.40) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 16 tps: 96.60 qps: 1926.51 (r/w/o: 1347.30/386.00/193.20) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 16 tps: 86.50 qps: 1734.97 (r/w/o: 1215.58/346.39/173.00) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 16 tps: 83.70 qps: 1672.71 (r/w/o: 1170.91/334.40/167.40) lat (ms,99%): 511.33 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 16 tps: 86.50 qps: 1729.12 (r/w/o: 1210.22/345.90/173.00) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 16 tps: 93.30 qps: 1867.70 (r/w/o: 1307.20/374.00/186.50) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 16 tps: 89.20 qps: 1780.89 (r/w/o: 1245.39/357.00/178.50) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 16 tps: 83.00 qps: 1660.51 (r/w/o: 1163.21/331.30/166.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 16 tps: 88.19 qps: 1765.07 (r/w/o: 1236.21/352.47/176.39) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 16 tps: 84.10 qps: 1680.52 (r/w/o: 1175.81/336.50/168.20) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 16 tps: 86.01 qps: 1723.81 (r/w/o: 1206.58/345.22/172.01) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 16 tps: 96.00 qps: 1920.06 (r/w/o: 1344.77/383.29/192.00) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 16 tps: 88.40 qps: 1767.70 (r/w/o: 1237.70/353.20/176.80) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 16 tps: 87.70 qps: 1754.00 (r/w/o: 1227.70/350.90/175.40) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 16 tps: 88.70 qps: 1770.62 (r/w/o: 1238.71/354.50/177.40) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 16 tps: 86.10 qps: 1722.48 (r/w/o: 1205.49/344.80/172.20) lat (ms,99%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 16 tps: 84.70 qps: 1697.80 (r/w/o: 1189.40/339.00/169.40) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 16 tps: 84.10 qps: 1680.41 (r/w/o: 1175.61/336.60/168.20) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 16 tps: 84.10 qps: 1680.69 (r/w/o: 1176.90/335.60/168.20) lat (ms,99%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 16 tps: 82.30 qps: 1645.19 (r/w/o: 1151.40/329.20/164.60) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 16 tps: 86.90 qps: 1738.10 (r/w/o: 1216.50/347.80/173.80) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 16 tps: 83.90 qps: 1676.61 (r/w/o: 1172.91/335.90/167.80) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 16 tps: 84.90 qps: 1702.01 (r/w/o: 1193.01/339.20/169.80) lat (ms,99%): 549.52 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 16 tps: 84.20 qps: 1679.09 (r/w/o: 1174.00/336.70/168.40) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 16 tps: 93.50 qps: 1872.45 (r/w/o: 1311.07/374.39/187.00) lat (ms,99%): 390.30 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 16 tps: 78.40 qps: 1573.66 (r/w/o: 1102.27/314.59/156.80) lat (ms,99%): 580.02 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 16 tps: 80.50 qps: 1604.39 (r/w/o: 1122.76/320.62/161.01) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 16 tps: 81.69 qps: 1632.68 (r/w/o: 1142.31/326.98/163.39) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 16 tps: 90.51 qps: 1813.40 (r/w/o: 1269.77/362.62/181.01) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 16 tps: 87.40 qps: 1746.11 (r/w/o: 1222.11/349.20/174.80) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 16 tps: 92.40 qps: 1850.42 (r/w/o: 1296.11/369.50/184.80) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 16 tps: 85.00 qps: 1699.66 (r/w/o: 1189.77/339.89/170.00) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 16 tps: 84.20 qps: 1687.07 (r/w/o: 1180.28/338.39/168.40) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 16 tps: 84.80 qps: 1693.64 (r/w/o: 1185.73/338.31/169.60) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 16 tps: 86.30 qps: 1726.31 (r/w/o: 1208.91/344.80/172.60) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 16 tps: 84.30 qps: 1685.31 (r/w/o: 1179.90/336.80/168.60) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 16 tps: 75.70 qps: 1513.79 (r/w/o: 1059.09/303.30/151.40) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 16 tps: 86.30 qps: 1724.46 (r/w/o: 1206.97/344.89/172.60) lat (ms,99%): 569.67 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 16 tps: 88.00 qps: 1759.52 (r/w/o: 1231.01/352.50/176.00) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 16 tps: 89.40 qps: 1787.12 (r/w/o: 1251.51/356.80/178.80) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 16 tps: 89.50 qps: 1793.45 (r/w/o: 1256.27/358.19/179.00) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 16 tps: 81.30 qps: 1622.87 (r/w/o: 1134.85/325.41/162.61) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 16 tps: 79.00 qps: 1580.09 (r/w/o: 1106.49/315.60/158.00) lat (ms,99%): 569.67 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 16 tps: 85.80 qps: 1715.41 (r/w/o: 1200.11/343.70/171.60) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 16 tps: 86.89 qps: 1742.98 (r/w/o: 1221.94/347.26/173.78) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 16 tps: 84.51 qps: 1685.90 (r/w/o: 1178.74/338.14/169.02) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 16 tps: 86.00 qps: 1722.60 (r/w/o: 1206.70/343.90/172.00) lat (ms,99%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 16 tps: 84.00 qps: 1681.39 (r/w/o: 1176.80/336.60/168.00) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 16 tps: 78.50 qps: 1566.80 (r/w/o: 1096.50/313.30/157.00) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 16 tps: 85.10 qps: 1702.47 (r/w/o: 1190.48/341.79/170.20) lat (ms,99%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 16 tps: 84.00 qps: 1677.87 (r/w/o: 1174.78/335.09/168.00) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 16 tps: 84.40 qps: 1690.75 (r/w/o: 1184.46/337.49/168.79) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 16 tps: 84.70 qps: 1694.77 (r/w/o: 1186.08/339.29/169.40) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 16 tps: 96.41 qps: 1925.44 (r/w/o: 1347.49/385.13/192.81) lat (ms,99%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 16 tps: 79.60 qps: 1591.42 (r/w/o: 1114.12/318.10/159.20) lat (ms,99%): 530.08 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 16 tps: 90.10 qps: 1805.65 (r/w/o: 1264.86/360.59/180.19) lat (ms,99%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 16 tps: 84.60 qps: 1685.23 (r/w/o: 1177.82/338.21/169.20) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 16 tps: 83.90 qps: 1683.82 (r/w/o: 1180.52/335.50/167.80) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 16 tps: 87.60 qps: 1752.30 (r/w/o: 1226.70/350.40/175.20) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 16 tps: 82.50 qps: 1648.51 (r/w/o: 1153.61/329.90/165.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 16 tps: 83.80 qps: 1677.19 (r/w/o: 1174.19/335.40/167.60) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 16 tps: 79.20 qps: 1584.10 (r/w/o: 1109.10/316.60/158.40) lat (ms,99%): 520.62 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 16 tps: 87.40 qps: 1745.71 (r/w/o: 1221.20/349.70/174.80) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 16 tps: 86.40 qps: 1727.80 (r/w/o: 1209.10/345.90/172.80) lat (ms,99%): 467.30 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 16 tps: 88.00 qps: 1763.20 (r/w/o: 1235.40/351.80/176.00) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 16 tps: 86.80 qps: 1730.80 (r/w/o: 1209.80/347.40/173.60) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 16 tps: 78.10 qps: 1565.10 (r/w/o: 1096.90/312.00/156.20) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 16 tps: 89.10 qps: 1785.40 (r/w/o: 1250.70/356.50/178.20) lat (ms,99%): 458.96 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 16 tps: 80.60 qps: 1610.49 (r/w/o: 1125.99/323.30/161.20) lat (ms,99%): 484.44 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 16 tps: 88.30 qps: 1765.90 (r/w/o: 1236.70/352.60/176.60) lat (ms,99%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 16 tps: 82.20 qps: 1637.81 (r/w/o: 1145.00/328.40/164.40) lat (ms,99%): 502.20 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 16 tps: 83.60 qps: 1677.77 (r/w/o: 1175.58/334.99/167.20) lat (ms,99%): 493.24 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 16 tps: 86.70 qps: 1732.70 (r/w/o: 1213.13/346.18/173.39) lat (ms,99%): 475.79 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            2307942
        write:                           659412
        other:                           329706
        total:                           3297060
    transactions:                        164853 (91.56 per sec.)
    queries:                             3297060 (1831.20 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.4891s
    total number of events:              164853

Latency (ms):
         min:                                    6.94
         avg:                                  174.72
         max:                                 1339.85
         99th percentile:                      569.67
         sum:                             28802446.80

Threads fairness:
    events (avg/stddev):           10303.3125/44.61
    execution time (avg/stddev):   1800.1529/0.15










