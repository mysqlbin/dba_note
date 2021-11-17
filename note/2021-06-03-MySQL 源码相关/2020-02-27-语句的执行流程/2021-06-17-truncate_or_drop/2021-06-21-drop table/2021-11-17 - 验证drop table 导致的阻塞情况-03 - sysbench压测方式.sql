

机器配置：4 CPU、16GB 内存，100GB的SSD盘。


CREATE TABLE `sbtest1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `k` int(10) unsigned NOT NULL DEFAULT '0',
  `c` char(120) NOT NULL DEFAULT '',
  `pad` char(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `k_1` (`k`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb4;


注意：不需要重启MySQL .

[root@voice sbtest]# ls -lht sbtest1.ibd 
-rw-r-----. 1 mysql mysql 38G Nov 17 10:41 sbtest1.ibd

该表没有脏页。

iostat -dmx 1


sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='1234Abc&' \
--mysql-db=sbtest_02 \
--num-threads=8 \
--oltp-table-size=100000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=600 prepare


innodb_adaptive_hash_index=ON

set global innodb_flush_log_at_trx_commit=1;
set global sync_binlog=1;
show global variables like '%innodb_flush_log_at_trx_commit%';
show global variables like '%sync_binlog%';


mysql> set global innodb_flush_log_at_trx_commit=1;
Query OK, 0 rows affected (0.02 sec)

mysql> set global sync_binlog=1;
Query OK, 0 rows affected (0.00 sec)

mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_trx_commit | 1     |
+--------------------------------+-------+
1 row in set (0.02 sec)

mysql> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 1     |
+---------------+-------+
1 row in set (0.00 sec)


sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='1234Abc&' \
--mysql-db=sbtest_02 \
--num-threads=8 \
--oltp-table-size=100000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=1 --rand-type=uniform --max-time=600 \
--max-requests=0 --percentile=99 run >> /home/coding001/2021_11_17_01.log &



mysql> drop table sbtest.sbtest1;
Query OK, 0 rows affected (17.70 sec)


-bash-4.2$ tail -f /home/coding001/2021_11_17_01.log

[ 1s ] thds: 8 tps: 158.55 qps: 3257.81 (r/w/o: 2290.54/642.19/325.08) lat (ms,99%): 114.72 err/s: 0.00 reconn/s: 0.00
[ 2s ] thds: 8 tps: 226.12 qps: 4517.34 (r/w/o: 3162.64/903.47/451.23) lat (ms,99%): 104.84 err/s: 0.00 reconn/s: 0.00
[ 3s ] thds: 8 tps: 249.00 qps: 4984.02 (r/w/o: 3484.01/1002.00/498.00) lat (ms,99%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 4s ] thds: 8 tps: 267.98 qps: 5365.58 (r/w/o: 3761.71/1067.92/535.96) lat (ms,99%): 73.13 err/s: 0.00 reconn/s: 0.00
[ 5s ] thds: 8 tps: 279.03 qps: 5585.58 (r/w/o: 3903.40/1123.12/559.06) lat (ms,99%): 62.19 err/s: 0.00 reconn/s: 0.00
[ 6s ] thds: 8 tps: 291.99 qps: 5785.74 (r/w/o: 4049.82/1151.95/583.97) lat (ms,99%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 7s ] thds: 8 tps: 302.01 qps: 6090.25 (r/w/o: 4270.17/1216.05/604.02) lat (ms,99%): 51.94 err/s: 0.00 reconn/s: 0.00
[ 8s ] thds: 8 tps: 304.00 qps: 6091.91 (r/w/o: 4268.94/1214.98/607.99) lat (ms,99%): 49.21 err/s: 0.00 reconn/s: 0.00
[ 9s ] thds: 8 tps: 305.97 qps: 6100.41 (r/w/o: 4271.59/1216.88/611.94) lat (ms,99%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 10s ] thds: 8 tps: 314.03 qps: 6279.55 (r/w/o: 4386.38/1265.11/628.05) lat (ms,99%): 34.33 err/s: 0.00 reconn/s: 0.00
[ 11s ] thds: 8 tps: 317.98 qps: 6351.68 (r/w/o: 4443.78/1272.94/634.97) lat (ms,99%): 38.94 err/s: 0.00 reconn/s: 0.00
........................................................................................................................
[ 85s ] thds: 8 tps: 323.01 qps: 6460.16 (r/w/o: 4525.11/1289.03/646.02) lat (ms,99%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 86s ] thds: 8 tps: 318.01 qps: 6354.19 (r/w/o: 4451.13/1268.04/635.02) lat (ms,99%): 30.81 err/s: 0.00 reconn/s: 0.00
[ 87s ] thds: 8 tps: 320.98 qps: 6414.59 (r/w/o: 4494.72/1276.92/642.96) lat (ms,99%): 29.72 err/s: 0.00 reconn/s: 0.00
[ 88s ] thds: 8 tps: 321.02 qps: 6448.34 (r/w/o: 4515.24/1291.07/642.03) lat (ms,99%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 89s ] thds: 8 tps: 323.99 qps: 6443.86 (r/w/o: 4498.90/1296.97/647.99) lat (ms,99%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 8 tps: 320.99 qps: 6433.88 (r/w/o: 4508.92/1283.98/640.99) lat (ms,99%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 91s ] thds: 8 tps: 331.00 qps: 6626.95 (r/w/o: 4635.96/1327.99/662.99) lat (ms,99%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 92s ] thds: 8 tps: 329.00 qps: 6595.07 (r/w/o: 4626.05/1311.01/658.01) lat (ms,99%): 28.67 err/s: 0.00 reconn/s: 0.00
[ 93s ] thds: 8 tps: 326.02 qps: 6522.33 (r/w/o: 4557.23/1314.07/651.03) lat (ms,99%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 94s ] thds: 8 tps: 325.99 qps: 6523.82 (r/w/o: 4571.88/1298.96/652.98) lat (ms,99%): 28.16 err/s: 0.00 reconn/s: 0.00
[ 95s ] thds: 8 tps: 327.99 qps: 6520.74 (r/w/o: 4552.82/1311.95/655.97) lat (ms,99%): 27.17 err/s: 0.00 reconn/s: 0.00

-- drop table操作开始执行，耗时18秒。

[ 96s ] thds: 8 tps: 257.02 qps: 5162.38 (r/w/o: 3622.27/1026.08/514.04) lat (ms,99%): 62.19 err/s: 0.00 reconn/s: 0.00
[ 97s ] thds: 8 tps: 257.99 qps: 5166.83 (r/w/o: 3616.88/1033.97/515.98) lat (ms,99%): 84.47 err/s: 0.00 reconn/s: 0.00
[ 98s ] thds: 8 tps: 263.01 qps: 5240.15 (r/w/o: 3673.10/1041.03/526.01) lat (ms,99%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 99s ] thds: 8 tps: 245.99 qps: 4906.74 (r/w/o: 3429.82/984.95/491.97) lat (ms,99%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 8 tps: 249.00 qps: 5003.01 (r/w/o: 3506.00/999.00/498.00) lat (ms,99%): 64.47 err/s: 0.00 reconn/s: 0.00
[ 101s ] thds: 8 tps: 245.00 qps: 4886.05 (r/w/o: 3417.04/979.01/490.01) lat (ms,99%): 66.84 err/s: 0.00 reconn/s: 0.00
[ 102s ] thds: 8 tps: 249.00 qps: 4975.97 (r/w/o: 3478.98/999.99/497.00) lat (ms,99%): 78.60 err/s: 0.00 reconn/s: 0.00
[ 103s ] thds: 8 tps: 255.00 qps: 5084.08 (r/w/o: 3561.05/1013.02/510.01) lat (ms,99%): 58.92 err/s: 0.00 reconn/s: 0.00
[ 104s ] thds: 8 tps: 268.99 qps: 5398.89 (r/w/o: 3777.92/1082.98/537.99) lat (ms,99%): 63.32 err/s: 0.00 reconn/s: 0.00
[ 105s ] thds: 8 tps: 268.00 qps: 5335.90 (r/w/o: 3734.93/1063.98/536.99) lat (ms,99%): 71.83 err/s: 0.00 reconn/s: 0.00
[ 106s ] thds: 8 tps: 254.01 qps: 5105.19 (r/w/o: 3576.13/1021.04/508.02) lat (ms,99%): 58.92 err/s: 0.00 reconn/s: 0.00
[ 107s ] thds: 8 tps: 262.00 qps: 5241.10 (r/w/o: 3670.07/1047.02/524.01) lat (ms,99%): 87.56 err/s: 0.00 reconn/s: 0.00
[ 108s ] thds: 8 tps: 249.99 qps: 4980.80 (r/w/o: 3480.86/999.96/499.98) lat (ms,99%): 66.84 err/s: 0.00 reconn/s: 0.00
[ 109s ] thds: 8 tps: 252.00 qps: 5052.94 (r/w/o: 3536.96/1011.99/503.99) lat (ms,99%): 63.32 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 8 tps: 270.99 qps: 5452.75 (r/w/o: 3818.83/1091.95/541.98) lat (ms,99%): 61.08 err/s: 0.00 reconn/s: 0.00
[ 111s ] thds: 8 tps: 267.02 qps: 5318.46 (r/w/o: 3724.32/1061.09/533.05) lat (ms,99%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 112s ] thds: 8 tps: 255.99 qps: 5118.83 (r/w/o: 3588.88/1016.97/512.98) lat (ms,99%): 49.21 err/s: 0.00 reconn/s: 0.00
[ 113s ] thds: 8 tps: 264.01 qps: 5285.23 (r/w/o: 3700.16/1057.05/528.02) lat (ms,99%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 114s ] thds: 8 tps: 157.00 qps: 3139.91 (r/w/o: 2191.94/633.98/313.99) lat (ms,99%): 68.05 err/s: 0.00 reconn/s: 0.00
[ 115s ] thds: 8 tps: 137.01 qps: 2735.10 (r/w/o: 1915.07/546.02/274.01) lat (ms,99%): 90.78 err/s: 0.00 reconn/s: 0.00
[ 116s ] thds: 8 tps: 171.00 qps: 3417.93 (r/w/o: 2395.95/679.99/341.99) lat (ms,99%): 61.08 err/s: 0.00 reconn/s: 0.00
[ 117s ] thds: 8 tps: 185.00 qps: 3710.00 (r/w/o: 2593.00/748.00/369.00) lat (ms,99%): 53.85 err/s: 0.00 reconn/s: 0.00
[ 118s ] thds: 8 tps: 196.00 qps: 3926.09 (r/w/o: 2750.06/783.02/393.01) lat (ms,99%): 50.11 err/s: 0.00 reconn/s: 0.00
-- 大概是到这里，drop table操作执行完成。

[ 119s ] thds: 8 tps: 201.00 qps: 3994.96 (r/w/o: 2791.97/800.99/402.00) lat (ms,99%): 51.02 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 8 tps: 225.99 qps: 4540.75 (r/w/o: 3180.82/907.95/451.97) lat (ms,99%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 121s ] thds: 8 tps: 253.01 qps: 5047.19 (r/w/o: 3528.13/1013.04/506.02) lat (ms,99%): 40.37 err/s: 0.00 reconn/s: 0.00
[ 122s ] thds: 8 tps: 326.01 qps: 6549.11 (r/w/o: 4594.08/1303.02/652.01) lat (ms,99%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 123s ] thds: 8 tps: 328.98 qps: 6582.69 (r/w/o: 4610.79/1313.94/657.97) lat (ms,99%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 124s ] thds: 8 tps: 328.01 qps: 6527.20 (r/w/o: 4557.14/1314.04/656.02) lat (ms,99%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 125s ] thds: 8 tps: 324.99 qps: 6499.75 (r/w/o: 4557.82/1291.95/649.97) lat (ms,99%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 126s ] thds: 8 tps: 327.00 qps: 6541.97 (r/w/o: 4578.98/1308.99/654.00) lat (ms,99%): 27.17 err/s: 0.00 reconn/s: 0.00
[ 127s ] thds: 8 tps: 324.01 qps: 6470.19 (r/w/o: 4528.13/1294.04/648.02) lat (ms,99%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 128s ] thds: 8 tps: 318.00 qps: 6368.09 (r/w/o: 4450.06/1282.02/636.01) lat (ms,99%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 129s ] thds: 8 tps: 323.00 qps: 6481.09 (r/w/o: 4553.06/1282.02/646.01) lat (ms,99%): 29.19 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 8 tps: 325.99 qps: 6504.80 (r/w/o: 4537.86/1313.96/652.98) lat (ms,99%): 28.16 err/s: 0.00 reconn/s: 0.00
^C



[root@voice sbtest]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	11/17/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.18    2.07   12.12     0.14     0.53    96.17     0.23   16.51   24.37   15.17   0.60   0.86

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    1.00 1390.00     0.01    20.46    30.14     0.94    0.67    1.00    0.67   0.48  67.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    8.00 1290.00     0.34    19.39    31.14     0.91    0.70    1.50    0.70   0.46  59.40

..........................................................................................................................

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1347.00     0.00    10.44    15.88     0.81    0.60    0.00    0.60   0.50  67.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1283.00     0.00    10.21    16.31     0.75    0.58    0.00    0.58   0.47  60.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1198.00     0.00     9.68    16.54     0.71    0.59    0.00    0.59   0.48  57.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1241.00     0.00     9.83    16.22     0.77    0.62    0.00    0.62   0.49  60.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00   96.00 1136.00     6.86    10.02    28.06     0.97    0.79    2.54    0.64   0.47  57.70

-- 写的能力开始下降

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1000.00     0.00    11.82    24.21     0.64    0.64    0.00    0.64   0.54  54.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00    0.00  998.00     0.00     8.53    17.50     0.66    0.66    0.00    0.66   0.55  55.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  954.00     0.00     8.21    17.64     0.66    0.69    0.00    0.69   0.56  53.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    1.00  914.00     0.02     8.05    18.06     0.63    0.69    1.00    0.69   0.56  50.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  956.00     0.00     8.34    17.86     0.65    0.69    0.00    0.69   0.55  52.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  871.00     0.00     7.93    18.65     0.63    0.73    0.00    0.73   0.59  51.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  947.00     0.00     8.17    17.67     0.65    0.68    0.00    0.68   0.55  52.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  956.00     0.00     8.14    17.45     0.65    0.68    0.00    0.68   0.57  54.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  972.00     0.00     8.46    17.83     0.67    0.69    0.00    0.69   0.55  53.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  958.00     0.00     8.23    17.59     0.66    0.69    0.00    0.69   0.57  55.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  948.00     0.00     8.59    18.57     0.65    0.69    0.00    0.69   0.57  54.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00   89.00  969.00     3.22     8.38    22.46     0.80    0.76    1.44    0.70   0.54  57.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  890.00     0.00     7.58    17.44     0.64    0.72    0.00    0.72   0.58  52.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  935.00     0.00     7.64    16.74     0.62    0.66    0.00    0.66   0.56  51.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1020.00     0.00     7.98    16.02     0.68    0.66    0.00    0.66   0.54  55.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  957.00     0.00     8.07    17.26     0.62    0.65    0.00    0.65   0.54  51.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00    11.00  119.00  988.00     5.58     8.23    25.54     0.96    0.88    2.29    0.70   0.49  54.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  187.00  971.00     3.34    12.91    28.75     0.99    0.85    1.62    0.71   0.49  57.10

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  582.18     0.00     7.21    25.37     0.48    0.84    0.00    0.84   0.72  41.78

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  536.00     0.00     6.68    25.52     0.45    0.85    0.00    0.85   0.74  39.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  648.00     0.00     7.75    24.51     0.52    0.80    0.00    0.80   0.67  43.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  689.00     0.00     7.72    22.96     0.59    0.85    0.00    0.85   0.68  46.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  738.00     0.00     7.69    21.34     0.53    0.72    0.00    0.72   0.61  45.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00    43.00    1.00  835.00     0.02     8.62    21.15     0.67    0.81    1.00    0.81   0.55  45.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  889.00     0.00     8.51    19.61     0.63    0.71    0.00    0.71   0.60  53.30

^C


