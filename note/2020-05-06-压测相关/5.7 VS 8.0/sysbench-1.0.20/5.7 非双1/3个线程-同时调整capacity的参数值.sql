


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
 
mysql -uroot -p'zP1ExFNsugs%' sbtest < sbtest.sql &

sudo /etc/init.d/mysql restart 

set global sync_binlog=1000;
set global innodb_flush_log_at_trx_commit=2;


set global innodb_io_capacity=5000;
set global innodb_io_capacity_max=20000;


show global variables like '%sync_binlog%';
show global variables like '%innodb_flush_log_at_trx_commit%';
show global variables like '%innodb_io_capacity%';

mysql> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 1000  |
+---------------+-------+
1 row in set (0.01 sec)

mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_trx_commit | 2     |
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


sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='' \
--mysql-db=sbtest \
--num-threads=3 \
--oltp-table-size=5000000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=1800 \
--max-requests=0 --percentile=99 run >> /home/coding001/sysbench_oltpX_3_not3_.log &

[coding001@voice data_volume]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    1.99    3.39     0.13     0.14   102.45     0.06   10.86   24.78    2.71   0.67   0.36

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  926.00  204.00    48.01     7.28   100.21    10.43    9.21   11.06    0.78   0.81  91.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  855.00  208.00    48.10     7.35   106.83    10.19    9.41   11.46    0.99   0.87  92.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  986.00  172.00    47.89     6.41    96.03     7.01    6.23    7.18    0.81   0.78  90.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00  880.00  186.00    48.05     6.30   104.41    12.21   11.19   13.34    1.03   0.88  94.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00



[coding001@voice data_volume]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.43    0.00    0.64    0.16    0.00   98.76

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               5.38       134.34       141.34 1100385058 1157755264

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          12.66    0.00    6.84   42.28    0.00   38.23

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1041.00     49344.00      9352.00      49344       9352

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.80    0.00    7.91   41.07    0.00   36.22

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1093.00     49056.00      6440.00      49056       6440

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          14.72    0.00    8.12   39.59    0.00   37.56

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1145.00     49236.00      7684.00      49236       7684

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          12.53    0.00    6.91   44.50    0.00   36.06

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1034.00     49044.00      6556.00      49044       6556


[coding001@voice data_volume]$ top
top - 10:20:53 up 94 days, 19:19,  4 users,  load average: 3.42, 3.01, 1.99
Tasks: 122 total,   1 running, 121 sleeping,   0 stopped,   0 zombie
%Cpu0  : 15.1 us,  5.1 sy,  0.0 ni, 15.1 id, 63.0 wa,  0.0 hi,  1.7 si,  0.0 st
%Cpu1  : 11.4 us,  5.4 sy,  0.0 ni, 34.0 id, 47.8 wa,  0.0 hi,  1.3 si,  0.0 st
%Cpu2  : 11.1 us,  5.1 sy,  0.0 ni, 49.8 id, 32.7 wa,  0.0 hi,  1.3 si,  0.0 st
%Cpu3  : 12.1 us,  6.4 sy,  0.0 ni, 45.8 id, 35.0 wa,  0.0 hi,  0.7 si,  0.0 st
KiB Mem : 16266300 total,   175172 free,  9919812 used,  6171316 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5286736 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   8.9g   4072 S  68.1 57.4  50:30.85 mysqld                                                                                                                                                                    
21265 coding0+  20   0  297424   3892   1336 S  13.6  0.0   1:48.68 sysbench    