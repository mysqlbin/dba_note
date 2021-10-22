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

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench --mysql-password='' --mysql-db=sbtest --tables=20 --table-size=3000000 --threads=32 --time=1800 --report-interval=10 --db-driver=mysql prepare



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
--table-size=3000000 --threads=32 --time=1800 --report-interval=10 \
--db-driver=mysql run >> /home/coding001/log/sysbench_oltpX_32_11_vesion8.log &



[coding001@db-a ~]$ tail -f /home/coding001/log/sysbench_oltpX_32_11_vesion8.log

Initializing worker threads...

Threads started!

[ 10s ] thds: 32 tps: 1004.07 qps: 6033.22 (r/w/o: 0.00/4022.28/2010.94) lat (ms,95%): 52.89 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 32 tps: 1499.41 qps: 8994.93 (r/w/o: 0.00/5996.12/2998.81) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 32 tps: 1768.80 qps: 10615.12 (r/w/o: 0.00/7077.41/3537.71) lat (ms,95%): 41.10 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 32 tps: 1745.21 qps: 10473.65 (r/w/o: 0.00/6983.14/3490.52) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 32 tps: 1110.81 qps: 6667.05 (r/w/o: 0.00/4445.23/2221.82) lat (ms,95%): 56.84 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 32 tps: 1276.00 qps: 7657.83 (r/w/o: 0.00/5105.82/2552.01) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 32 tps: 849.90 qps: 5099.40 (r/w/o: 0.00/3399.60/1699.80) lat (ms,95%): 57.87 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 32 tps: 927.99 qps: 5565.06 (r/w/o: 0.00/3709.27/1855.79) lat (ms,95%): 51.94 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 32 tps: 952.19 qps: 5712.84 (r/w/o: 0.00/3808.26/1904.58) lat (ms,95%): 53.85 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 32 tps: 1052.87 qps: 6312.33 (r/w/o: 0.00/4206.79/2105.54) lat (ms,95%): 51.02 err/s: 0.00 reconn/s: 0.00
[ 110s ] thds: 32 tps: 1116.04 qps: 6699.84 (r/w/o: 0.00/4468.06/2231.78) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 32 tps: 1095.88 qps: 6569.80 (r/w/o: 0.00/4377.63/2192.17) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 130s ] thds: 32 tps: 1026.02 qps: 6164.40 (r/w/o: 0.00/4112.27/2052.13) lat (ms,95%): 49.21 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 32 tps: 1012.70 qps: 6077.88 (r/w/o: 0.00/4052.49/2025.39) lat (ms,95%): 50.11 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 32 tps: 1069.19 qps: 6408.42 (r/w/o: 0.00/4270.15/2138.27) lat (ms,95%): 49.21 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 32 tps: 1059.03 qps: 6360.66 (r/w/o: 0.00/4242.51/2118.15) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 32 tps: 961.37 qps: 5762.74 (r/w/o: 0.00/3840.10/1922.65) lat (ms,95%): 50.11 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 32 tps: 1016.12 qps: 6101.32 (r/w/o: 0.00/4069.08/2032.24) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 32 tps: 1042.50 qps: 6256.12 (r/w/o: 0.00/4171.01/2085.11) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 32 tps: 1034.20 qps: 6204.12 (r/w/o: 0.00/4135.82/2068.31) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 32 tps: 1046.40 qps: 6279.49 (r/w/o: 0.00/4186.59/2092.90) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 32 tps: 994.10 qps: 5964.49 (r/w/o: 0.00/3976.29/1988.20) lat (ms,95%): 49.21 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 32 tps: 1044.50 qps: 6262.99 (r/w/o: 0.00/4174.19/2088.80) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 32 tps: 943.10 qps: 5662.70 (r/w/o: 0.00/3776.30/1886.40) lat (ms,95%): 51.02 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 32 tps: 1078.09 qps: 6464.96 (r/w/o: 0.00/4308.78/2156.19) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 260s ] thds: 32 tps: 1104.70 qps: 6630.81 (r/w/o: 0.00/4421.41/2209.40) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 270s ] thds: 32 tps: 1087.81 qps: 6527.88 (r/w/o: 0.00/4352.25/2175.63) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 280s ] thds: 32 tps: 1012.68 qps: 6071.01 (r/w/o: 0.00/4045.94/2025.07) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 290s ] thds: 32 tps: 1069.11 qps: 6419.14 (r/w/o: 0.00/4280.63/2138.51) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 300s ] thds: 32 tps: 1027.40 qps: 6161.78 (r/w/o: 0.00/4106.98/2054.79) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 310s ] thds: 32 tps: 1042.80 qps: 6259.51 (r/w/o: 0.00/4173.91/2085.60) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 320s ] thds: 32 tps: 1005.70 qps: 6032.52 (r/w/o: 0.00/4021.11/2011.41) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 330s ] thds: 32 tps: 1051.80 qps: 6306.49 (r/w/o: 0.00/4203.39/2103.10) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 340s ] thds: 32 tps: 1011.50 qps: 6067.01 (r/w/o: 0.00/4045.21/2021.80) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 350s ] thds: 32 tps: 1075.81 qps: 6463.25 (r/w/o: 0.00/4309.93/2153.32) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 360s ] thds: 32 tps: 1084.78 qps: 6506.50 (r/w/o: 0.00/4336.94/2169.57) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 370s ] thds: 32 tps: 1085.40 qps: 6507.32 (r/w/o: 0.00/4337.21/2170.11) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 380s ] thds: 32 tps: 1077.61 qps: 6472.97 (r/w/o: 0.00/4317.05/2155.92) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 390s ] thds: 32 tps: 1096.39 qps: 6578.37 (r/w/o: 0.00/4385.58/2192.79) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 400s ] thds: 32 tps: 967.70 qps: 5801.81 (r/w/o: 0.00/3866.71/1935.10) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 410s ] thds: 32 tps: 1064.68 qps: 6391.38 (r/w/o: 0.00/4261.72/2129.66) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 420s ] thds: 32 tps: 1012.02 qps: 6073.22 (r/w/o: 0.00/4049.18/2024.04) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 430s ] thds: 32 tps: 1074.88 qps: 6446.95 (r/w/o: 0.00/4297.20/2149.75) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 440s ] thds: 32 tps: 1065.11 qps: 6393.06 (r/w/o: 0.00/4262.84/2130.22) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 450s ] thds: 32 tps: 1012.91 qps: 6075.26 (r/w/o: 0.00/4049.44/2025.82) lat (ms,95%): 48.34 err/s: 0.00 reconn/s: 0.00
[ 460s ] thds: 32 tps: 1043.38 qps: 6256.67 (r/w/o: 0.00/4170.31/2086.36) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 470s ] thds: 32 tps: 1119.33 qps: 6719.86 (r/w/o: 0.00/4480.80/2239.05) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 480s ] thds: 32 tps: 1030.27 qps: 6175.11 (r/w/o: 0.00/4115.47/2059.64) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 490s ] thds: 32 tps: 1073.43 qps: 6448.85 (r/w/o: 0.00/4301.10/2147.75) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 500s ] thds: 32 tps: 1098.10 qps: 6588.19 (r/w/o: 0.00/4392.00/2196.20) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 510s ] thds: 32 tps: 1112.40 qps: 6674.71 (r/w/o: 0.00/4449.91/2224.80) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 520s ] thds: 32 tps: 1080.01 qps: 6480.27 (r/w/o: 0.00/4320.25/2160.02) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 530s ] thds: 32 tps: 1033.68 qps: 6199.07 (r/w/o: 0.00/4131.71/2067.36) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 540s ] thds: 32 tps: 1102.39 qps: 6612.96 (r/w/o: 0.00/4408.17/2204.79) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 550s ] thds: 32 tps: 1128.21 qps: 6768.08 (r/w/o: 0.00/4512.26/2255.83) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 560s ] thds: 32 tps: 1096.60 qps: 6581.51 (r/w/o: 0.00/4387.71/2193.80) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 570s ] thds: 32 tps: 1116.69 qps: 6701.52 (r/w/o: 0.00/4468.14/2233.37) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 580s ] thds: 32 tps: 1093.10 qps: 6557.70 (r/w/o: 0.00/4371.80/2185.90) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 590s ] thds: 32 tps: 1059.41 qps: 6359.58 (r/w/o: 0.00/4240.45/2119.13) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 600s ] thds: 32 tps: 1021.10 qps: 6124.31 (r/w/o: 0.00/4082.11/2042.20) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 610s ] thds: 32 tps: 1008.10 qps: 6043.41 (r/w/o: 0.00/4027.41/2016.00) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 620s ] thds: 32 tps: 1118.49 qps: 6715.24 (r/w/o: 0.00/4478.16/2237.08) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 630s ] thds: 32 tps: 1127.30 qps: 6760.37 (r/w/o: 0.00/4505.68/2254.69) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 640s ] thds: 32 tps: 1150.69 qps: 6910.84 (r/w/o: 0.00/4609.46/2301.38) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 650s ] thds: 32 tps: 1018.23 qps: 6109.40 (r/w/o: 0.00/4072.94/2036.47) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 660s ] thds: 32 tps: 1047.46 qps: 6278.27 (r/w/o: 0.00/4184.65/2093.62) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 670s ] thds: 32 tps: 1184.03 qps: 7104.96 (r/w/o: 0.00/4735.90/2369.05) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 680s ] thds: 32 tps: 1167.11 qps: 7007.63 (r/w/o: 0.00/4673.12/2334.51) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 690s ] thds: 32 tps: 1076.49 qps: 6454.67 (r/w/o: 0.00/4302.38/2152.29) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 700s ] thds: 32 tps: 1091.91 qps: 6549.73 (r/w/o: 0.00/4365.22/2184.51) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 710s ] thds: 32 tps: 1082.30 qps: 6500.51 (r/w/o: 0.00/4335.91/2164.60) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 720s ] thds: 32 tps: 1081.70 qps: 6489.58 (r/w/o: 0.00/4326.19/2163.39) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 730s ] thds: 32 tps: 1111.90 qps: 6669.91 (r/w/o: 0.00/4446.31/2223.60) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 740s ] thds: 32 tps: 1082.00 qps: 6488.67 (r/w/o: 0.00/4324.78/2163.89) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 750s ] thds: 32 tps: 1096.58 qps: 6578.40 (r/w/o: 0.00/4386.03/2192.37) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 760s ] thds: 32 tps: 1062.51 qps: 6379.15 (r/w/o: 0.00/4253.04/2126.12) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 770s ] thds: 32 tps: 1099.31 qps: 6598.28 (r/w/o: 0.00/4399.66/2198.63) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 780s ] thds: 32 tps: 1068.69 qps: 6406.03 (r/w/o: 0.00/4269.65/2136.38) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 790s ] thds: 32 tps: 1082.39 qps: 6493.03 (r/w/o: 0.00/4328.65/2164.38) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 800s ] thds: 32 tps: 1109.61 qps: 6660.56 (r/w/o: 0.00/4440.54/2220.02) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 810s ] thds: 32 tps: 1068.20 qps: 6404.00 (r/w/o: 0.00/4268.70/2135.30) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 820s ] thds: 32 tps: 1086.82 qps: 6530.60 (r/w/o: 0.00/4355.27/2175.33) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 830s ] thds: 32 tps: 1063.68 qps: 6378.38 (r/w/o: 0.00/4251.02/2127.36) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 840s ] thds: 32 tps: 1083.10 qps: 6501.60 (r/w/o: 0.00/4335.50/2166.10) lat (ms,95%): 47.47 err/s: 0.00 reconn/s: 0.00
[ 850s ] thds: 32 tps: 1078.00 qps: 6466.00 (r/w/o: 0.00/4309.90/2156.10) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 860s ] thds: 32 tps: 1062.70 qps: 6373.71 (r/w/o: 0.00/4248.61/2125.10) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 870s ] thds: 32 tps: 1128.51 qps: 6774.76 (r/w/o: 0.00/4517.74/2257.02) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 880s ] thds: 32 tps: 1202.81 qps: 7218.35 (r/w/o: 0.00/4812.44/2405.92) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 890s ] thds: 32 tps: 1245.38 qps: 7466.69 (r/w/o: 0.00/4976.53/2490.16) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 900s ] thds: 32 tps: 1065.11 qps: 6395.66 (r/w/o: 0.00/4264.84/2130.82) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 910s ] thds: 32 tps: 1024.71 qps: 6148.34 (r/w/o: 0.00/4099.03/2049.31) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 920s ] thds: 32 tps: 1068.00 qps: 6408.09 (r/w/o: 0.00/4272.00/2136.10) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 930s ] thds: 32 tps: 1120.59 qps: 6717.96 (r/w/o: 0.00/4476.87/2241.09) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 940s ] thds: 32 tps: 1042.90 qps: 6260.19 (r/w/o: 0.00/4174.29/2085.90) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 950s ] thds: 32 tps: 1091.10 qps: 6544.97 (r/w/o: 0.00/4362.88/2182.09) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 960s ] thds: 32 tps: 1038.71 qps: 6228.75 (r/w/o: 0.00/4151.73/2077.02) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 970s ] thds: 32 tps: 1082.70 qps: 6503.41 (r/w/o: 0.00/4337.50/2165.90) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 980s ] thds: 32 tps: 1178.29 qps: 7064.37 (r/w/o: 0.00/4708.18/2356.19) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 990s ] thds: 32 tps: 1121.91 qps: 6737.93 (r/w/o: 0.00/4493.72/2244.21) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1000s ] thds: 32 tps: 1024.40 qps: 6145.92 (r/w/o: 0.00/4097.22/2048.71) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 1010s ] thds: 32 tps: 1089.37 qps: 6533.42 (r/w/o: 0.00/4354.58/2178.84) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1020s ] thds: 32 tps: 1032.82 qps: 6193.49 (r/w/o: 0.00/4127.86/2065.63) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1030s ] thds: 32 tps: 1111.09 qps: 6670.03 (r/w/o: 0.00/4447.85/2222.18) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1040s ] thds: 32 tps: 1180.33 qps: 7085.15 (r/w/o: 0.00/4724.50/2360.65) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1050s ] thds: 32 tps: 1059.96 qps: 6356.38 (r/w/o: 0.00/4237.05/2119.33) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1060s ] thds: 32 tps: 955.24 qps: 5731.42 (r/w/o: 0.00/3820.55/1910.87) lat (ms,95%): 55.82 err/s: 0.00 reconn/s: 0.00
[ 1070s ] thds: 32 tps: 1124.48 qps: 6750.26 (r/w/o: 0.00/4501.11/2249.15) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1080s ] thds: 32 tps: 1090.82 qps: 6542.21 (r/w/o: 0.00/4360.57/2181.64) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1090s ] thds: 32 tps: 1189.20 qps: 7135.90 (r/w/o: 0.00/4757.60/2378.30) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1100s ] thds: 32 tps: 1151.17 qps: 6902.62 (r/w/o: 0.00/4600.48/2302.14) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1110s ] thds: 32 tps: 1048.42 qps: 6287.70 (r/w/o: 0.00/4192.36/2095.33) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 1120s ] thds: 32 tps: 1135.61 qps: 6816.85 (r/w/o: 0.00/4543.83/2273.02) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1130s ] thds: 32 tps: 1146.20 qps: 6880.22 (r/w/o: 0.00/4587.81/2292.41) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1140s ] thds: 32 tps: 1097.09 qps: 6581.95 (r/w/o: 0.00/4388.17/2193.78) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1150s ] thds: 32 tps: 1207.21 qps: 7246.88 (r/w/o: 0.00/4832.05/2414.83) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1160s ] thds: 32 tps: 1135.99 qps: 6805.26 (r/w/o: 0.00/4533.97/2271.29) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1170s ] thds: 32 tps: 1146.00 qps: 6886.72 (r/w/o: 0.00/4594.01/2292.71) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1180s ] thds: 32 tps: 1038.37 qps: 6224.20 (r/w/o: 0.00/4147.97/2076.23) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 1190s ] thds: 32 tps: 1148.53 qps: 6893.38 (r/w/o: 0.00/4596.22/2297.16) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1200s ] thds: 32 tps: 1137.00 qps: 6824.17 (r/w/o: 0.00/4549.78/2274.39) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1210s ] thds: 32 tps: 1179.41 qps: 7072.94 (r/w/o: 0.00/4714.73/2358.21) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1220s ] thds: 32 tps: 1158.50 qps: 6956.02 (r/w/o: 0.00/4638.41/2317.61) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1230s ] thds: 32 tps: 1195.29 qps: 7165.22 (r/w/o: 0.00/4775.55/2389.67) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1240s ] thds: 32 tps: 1234.62 qps: 7414.33 (r/w/o: 0.00/4944.18/2470.14) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1250s ] thds: 32 tps: 1147.68 qps: 6886.00 (r/w/o: 0.00/4590.63/2295.37) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1260s ] thds: 32 tps: 1153.11 qps: 6918.75 (r/w/o: 0.00/4612.54/2306.22) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1270s ] thds: 32 tps: 1141.21 qps: 6846.44 (r/w/o: 0.00/4564.03/2282.41) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1280s ] thds: 32 tps: 1055.08 qps: 6329.09 (r/w/o: 0.00/4219.13/2109.96) lat (ms,95%): 46.63 err/s: 0.00 reconn/s: 0.00
[ 1290s ] thds: 32 tps: 1242.20 qps: 7452.09 (r/w/o: 0.00/4967.50/2484.60) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1300s ] thds: 32 tps: 1104.10 qps: 6626.98 (r/w/o: 0.00/4418.89/2208.09) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1310s ] thds: 32 tps: 1139.59 qps: 6832.81 (r/w/o: 0.00/4553.74/2279.07) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1320s ] thds: 32 tps: 1139.00 qps: 6832.50 (r/w/o: 0.00/4554.90/2277.60) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1330s ] thds: 32 tps: 1139.03 qps: 6839.25 (r/w/o: 0.00/4560.60/2278.65) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1340s ] thds: 32 tps: 1117.10 qps: 6703.23 (r/w/o: 0.00/4469.02/2234.21) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 1350s ] thds: 32 tps: 1167.59 qps: 6998.93 (r/w/o: 0.00/4664.45/2334.48) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1360s ] thds: 32 tps: 1207.21 qps: 7249.87 (r/w/o: 0.00/4834.74/2415.12) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1370s ] thds: 32 tps: 1253.69 qps: 7515.34 (r/w/o: 0.00/5008.06/2507.28) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1380s ] thds: 32 tps: 1081.61 qps: 6496.86 (r/w/o: 0.00/4333.54/2163.32) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 1390s ] thds: 32 tps: 1149.21 qps: 6896.24 (r/w/o: 0.00/4597.82/2298.41) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1400s ] thds: 32 tps: 1113.77 qps: 6677.80 (r/w/o: 0.00/4450.37/2227.43) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 1410s ] thds: 32 tps: 1181.23 qps: 7092.18 (r/w/o: 0.00/4729.62/2362.56) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1420s ] thds: 32 tps: 1079.61 qps: 6477.66 (r/w/o: 0.00/4318.44/2159.22) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 1430s ] thds: 32 tps: 1067.27 qps: 6397.14 (r/w/o: 0.00/4263.89/2133.25) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1440s ] thds: 32 tps: 1082.90 qps: 6503.92 (r/w/o: 0.00/4336.81/2167.11) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1450s ] thds: 32 tps: 1082.71 qps: 6491.68 (r/w/o: 0.00/4326.46/2165.23) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1460s ] thds: 32 tps: 1045.90 qps: 6274.98 (r/w/o: 0.00/4183.98/2090.99) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1470s ] thds: 32 tps: 1239.09 qps: 7439.16 (r/w/o: 0.00/4959.97/2479.19) lat (ms,95%): 41.85 err/s: 0.00 reconn/s: 0.00
[ 1480s ] thds: 32 tps: 1113.50 qps: 6680.11 (r/w/o: 0.00/4453.11/2227.00) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1490s ] thds: 32 tps: 1247.09 qps: 7474.64 (r/w/o: 0.00/4980.86/2493.78) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1500s ] thds: 32 tps: 1117.11 qps: 6710.07 (r/w/o: 0.00/4475.44/2234.62) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1510s ] thds: 32 tps: 1390.51 qps: 8344.88 (r/w/o: 0.00/5563.85/2781.03) lat (ms,95%): 39.65 err/s: 0.00 reconn/s: 0.00
[ 1520s ] thds: 32 tps: 1097.19 qps: 6577.45 (r/w/o: 0.00/4383.17/2194.28) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1530s ] thds: 32 tps: 1109.39 qps: 6659.43 (r/w/o: 0.00/4440.55/2218.88) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1540s ] thds: 32 tps: 1146.59 qps: 6878.12 (r/w/o: 0.00/4584.95/2293.17) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1550s ] thds: 32 tps: 1083.93 qps: 6506.56 (r/w/o: 0.00/4338.81/2167.75) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 1560s ] thds: 32 tps: 1100.81 qps: 6604.95 (r/w/o: 0.00/4403.23/2201.72) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1570s ] thds: 32 tps: 1115.76 qps: 6695.48 (r/w/o: 0.00/4463.96/2231.53) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1580s ] thds: 32 tps: 1176.12 qps: 7056.12 (r/w/o: 0.00/4703.88/2352.24) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1590s ] thds: 32 tps: 1032.41 qps: 6194.08 (r/w/o: 0.00/4129.45/2064.63) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1600s ] thds: 32 tps: 1131.26 qps: 6786.56 (r/w/o: 0.00/4524.14/2262.42) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1610s ] thds: 32 tps: 1064.64 qps: 6389.85 (r/w/o: 0.00/4260.27/2129.58) lat (ms,95%): 45.79 err/s: 0.00 reconn/s: 0.00
[ 1620s ] thds: 32 tps: 1067.69 qps: 6400.12 (r/w/o: 0.00/4265.54/2134.57) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1630s ] thds: 32 tps: 1092.60 qps: 6561.62 (r/w/o: 0.00/4375.61/2186.01) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1640s ] thds: 32 tps: 1140.99 qps: 6843.05 (r/w/o: 0.00/4561.37/2281.68) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1650s ] thds: 32 tps: 1132.11 qps: 6795.55 (r/w/o: 0.00/4531.03/2264.52) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1660s ] thds: 32 tps: 1132.29 qps: 6786.36 (r/w/o: 0.00/4522.47/2263.89) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1670s ] thds: 32 tps: 1151.41 qps: 6911.83 (r/w/o: 0.00/4608.32/2303.51) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1680s ] thds: 32 tps: 1106.30 qps: 6638.90 (r/w/o: 0.00/4426.30/2212.60) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1690s ] thds: 32 tps: 1091.70 qps: 6550.42 (r/w/o: 0.00/4367.01/2183.41) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1700s ] thds: 32 tps: 1065.68 qps: 6396.78 (r/w/o: 0.00/4265.42/2131.36) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1710s ] thds: 32 tps: 1107.32 qps: 6643.41 (r/w/o: 0.00/4428.78/2214.64) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1720s ] thds: 32 tps: 1163.81 qps: 6983.34 (r/w/o: 0.00/4655.73/2327.61) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1730s ] thds: 32 tps: 1093.88 qps: 6560.07 (r/w/o: 0.00/4372.52/2187.56) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1740s ] thds: 32 tps: 1080.52 qps: 6485.02 (r/w/o: 0.00/4323.78/2161.24) lat (ms,95%): 44.98 err/s: 0.00 reconn/s: 0.00
[ 1750s ] thds: 32 tps: 1087.70 qps: 6522.78 (r/w/o: 0.00/4347.48/2175.29) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1760s ] thds: 32 tps: 1092.88 qps: 6562.00 (r/w/o: 0.00/4376.13/2185.87) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1770s ] thds: 32 tps: 1182.40 qps: 7087.73 (r/w/o: 0.00/4723.92/2363.81) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
[ 1780s ] thds: 32 tps: 1109.22 qps: 6657.02 (r/w/o: 0.00/4438.58/2218.44) lat (ms,95%): 44.17 err/s: 0.00 reconn/s: 0.00
[ 1790s ] thds: 32 tps: 1131.07 qps: 6788.55 (r/w/o: 0.00/4525.40/2263.15) lat (ms,95%): 43.39 err/s: 0.00 reconn/s: 0.00
[ 1800s ] thds: 32 tps: 1173.70 qps: 7044.20 (r/w/o: 0.00/4696.80/2347.40) lat (ms,95%): 42.61 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            0
        write:                           7958616
        other:                           3979308
        total:                           11937924
    transactions:                        1989654 (1105.35 per sec.)
    queries:                             11937924 (6632.08 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0268s
    total number of events:              1989654

Latency (ms):
         min:                                    6.10
         avg:                                   28.95
         max:                                  232.75
         95th percentile:                       45.79
         sum:                             57592488.77

Threads fairness:
    events (avg/stddev):           62176.6875/1186.40
    execution time (avg/stddev):   1799.7653/0.01


[root@voice data]# top
top - 11:02:29 up 97 days, 20:00,  3 users,  load average: 11.24, 12.15, 10.79
Tasks: 129 total,   2 running, 127 sleeping,   0 stopped,   0 zombie
%Cpu0  : 41.8 us, 13.6 sy,  0.0 ni, 24.7 id, 11.8 wa,  0.0 hi,  8.0 si,  0.0 st
%Cpu1  : 44.8 us, 11.4 sy,  0.0 ni, 27.9 id, 12.4 wa,  0.0 hi,  3.4 si,  0.0 st
%Cpu2  : 45.9 us, 10.9 sy,  0.0 ni, 28.2 id, 10.9 wa,  0.0 hi,  4.1 si,  0.0 st
%Cpu3  : 42.3 us, 11.7 sy,  0.0 ni, 30.6 id, 13.7 wa,  0.0 hi,  1.7 si,  0.0 st
KiB Mem : 16266300 total,   174152 free, 11688624 used,  4403524 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  3462392 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
32578 mysql     20   0   11.2g   9.3g  10532 S 240.2 60.1 478:01.77 mysqld     


[root@voice data]# iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.15    9.89     0.14     0.37    86.53     0.09    7.66   23.61    4.19   0.50   0.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  301.00 3167.00     4.70    53.08    34.12     5.13    1.48    0.73    1.55   0.27  93.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  257.00 2694.00     4.02    48.00    36.10     6.47    2.16    0.74    2.29   0.32  94.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  275.00 2856.00     4.30    48.00    34.21     5.64    1.84    0.79    1.94   0.31  95.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     4.00  316.00 2964.00     4.94    48.00    33.05     4.31    1.31    0.78    1.37   0.28  90.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     1.00  269.00 2748.00     4.20    48.09    35.50     5.60    1.86    0.80    1.96   0.31  94.40

^C
[root@voice data]# iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/22/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.68    0.00    0.72    0.19    0.00   98.41

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              12.05       143.45       377.73 1212577162 3192856820

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          52.36    0.00   15.45    9.69    0.00   22.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3363.00      4384.00     53496.00       4384      53496

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          40.98    0.00   14.69   14.69    0.00   29.64

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2952.00      3472.00     49140.00       3472      49140

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          53.51    0.00   18.70    8.31    0.00   19.48

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            2747.00      5408.00     40068.00       5408      40068

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          46.55    0.00   17.90   10.49    0.00   25.06

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            3628.00      4432.00     58220.00       4432      58220


mysql> show processlist;
+-----+-----------------+--------------------+--------+---------+--------+----------------------------+------------------------------------------------------------------------------------------------------+
| Id  | User            | Host               | db     | Command | Time   | State                      | Info                                                                                                 |
+-----+-----------------+--------------------+--------+---------+--------+----------------------------+------------------------------------------------------------------------------------------------------+
|   5 | event_scheduler | localhost          | NULL   | Daemon  | 145922 | Waiting on empty queue     | NULL                                                                                                 |
|  95 | sysbench        | 192.168.1.12:35058 | sbtest | Query   |      0 | init                       | show processlist                                                                                     |
| 160 | sysbench        | 192.168.1.10:59194 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 161 | sysbench        | 192.168.1.10:59188 | sbtest | Execute |      0 | updating                   | UPDATE sbtest3 SET k=k+1 WHERE id=1134781                                                            |
| 162 | sysbench        | 192.168.1.10:59187 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 163 | sysbench        | 192.168.1.10:59186 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 164 | sysbench        | 192.168.1.10:59196 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 165 | sysbench        | 192.168.1.10:59200 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 166 | sysbench        | 192.168.1.10:59198 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 167 | sysbench        | 192.168.1.10:59202 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 168 | sysbench        | 192.168.1.10:59204 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 169 | sysbench        | 192.168.1.10:59208 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 170 | sysbench        | 192.168.1.10:59210 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 171 | sysbench        | 192.168.1.10:59206 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 172 | sysbench        | 192.168.1.10:59212 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 173 | sysbench        | 192.168.1.10:59218 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 174 | sysbench        | 192.168.1.10:59214 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 175 | sysbench        | 192.168.1.10:59216 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 176 | sysbench        | 192.168.1.10:59220 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 177 | sysbench        | 192.168.1.10:59222 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 178 | sysbench        | 192.168.1.10:59228 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 179 | sysbench        | 192.168.1.10:59232 | sbtest | Execute |      0 | Opening tables             | UPDATE sbtest7 SET k=k+1 WHERE id=1510303                                                            |
| 180 | sysbench        | 192.168.1.10:59224 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 181 | sysbench        | 192.168.1.10:59226 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 182 | sysbench        | 192.168.1.10:59230 | sbtest | Execute |      0 | waiting for handler commit | COMMIT                                                                                               |
| 183 | sysbench        | 192.168.1.10:59234 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 184 | sysbench        | 192.168.1.10:59236 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 185 | sysbench        | 192.168.1.10:59238 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 186 | sysbench        | 192.168.1.10:59240 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 187 | sysbench        | 192.168.1.10:59242 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 188 | sysbench        | 192.168.1.10:59244 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 189 | sysbench        | 192.168.1.10:59246 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
| 190 | sysbench        | 192.168.1.10:59250 | sbtest | Execute |      0 | updating                   | UPDATE sbtest14 SET c='14119941707-97999007821-41104498410-20803329026-05247182303-15695972009-50460 |
| 191 | sysbench        | 192.168.1.10:59248 | sbtest | Sleep   |      0 |                            | NULL                                                                                                 |
+-----+-----------------+--------------------+--------+---------+--------+----------------------------+------------------------------------------------------------------------------------------------------+
34 rows in set (0.00 sec)

mysql> show processlist;
+-----+-----------------+--------------------+--------+---------+--------+----------------------------+------------------+
| Id  | User            | Host               | db     | Command | Time   | State                      | Info             |
+-----+-----------------+--------------------+--------+---------+--------+----------------------------+------------------+
|   5 | event_scheduler | localhost          | NULL   | Daemon  | 145924 | Waiting on empty queue     | NULL             |
|  95 | sysbench        | 192.168.1.12:35058 | sbtest | Query   |      0 | init                       | show processlist |
| 160 | sysbench        | 192.168.1.10:59194 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 161 | sysbench        | 192.168.1.10:59188 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 162 | sysbench        | 192.168.1.10:59187 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 163 | sysbench        | 192.168.1.10:59186 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 164 | sysbench        | 192.168.1.10:59196 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 165 | sysbench        | 192.168.1.10:59200 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 166 | sysbench        | 192.168.1.10:59198 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 167 | sysbench        | 192.168.1.10:59202 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 168 | sysbench        | 192.168.1.10:59204 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 169 | sysbench        | 192.168.1.10:59208 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 170 | sysbench        | 192.168.1.10:59210 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 171 | sysbench        | 192.168.1.10:59206 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 172 | sysbench        | 192.168.1.10:59212 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 173 | sysbench        | 192.168.1.10:59218 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 174 | sysbench        | 192.168.1.10:59214 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 175 | sysbench        | 192.168.1.10:59216 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 176 | sysbench        | 192.168.1.10:59220 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 177 | sysbench        | 192.168.1.10:59222 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 178 | sysbench        | 192.168.1.10:59228 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 179 | sysbench        | 192.168.1.10:59232 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 180 | sysbench        | 192.168.1.10:59224 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 181 | sysbench        | 192.168.1.10:59226 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 182 | sysbench        | 192.168.1.10:59230 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 183 | sysbench        | 192.168.1.10:59234 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 184 | sysbench        | 192.168.1.10:59236 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 185 | sysbench        | 192.168.1.10:59238 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 186 | sysbench        | 192.168.1.10:59240 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 187 | sysbench        | 192.168.1.10:59242 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 188 | sysbench        | 192.168.1.10:59244 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 189 | sysbench        | 192.168.1.10:59246 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 190 | sysbench        | 192.168.1.10:59250 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
| 191 | sysbench        | 192.168.1.10:59248 | sbtest | Execute |      0 | waiting for handler commit | COMMIT           |
+-----+-----------------+--------------------+--------+---------+--------+----------------------------+------------------+
34 rows in set (0.00 sec)


