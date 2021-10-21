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


./sysbench --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench --mysql-password='1234Abc&' --test=tests/db/oltp.lua --oltp_tables_count=15 --oltp-table-size=2000000 --rand-init=on prepare


purge binary logs to 'mysql-bin.000176';  


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


sudo /etc/init.d/mysql restart 


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
2 rows in set (0.01 sec)

mysql> show global variables like '%time_zone%';
+------------------+--------+
| Variable_name    | Value  |
+------------------+--------+
| system_time_zone | CST    |
| time_zone        | SYSTEM |
+------------------+--------+
2 rows in set (0.01 sec)



purge binary logs to 'mysql-bin.000084';  


./sysbench --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench \
--mysql-password='1234Abc&' --test=tests/db/oltp.lua --oltp_tables_count=15 \
--oltp-table-size=2000000 --num-threads=5 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/coding001/log/sysbench_oltpX_5_11_vision8.log &


-bash-4.2$ cat  sysbench_oltpX_5_11_vision8.log
sysbench 0.5:  multi-threaded system evaluation benchmark

Running the test with following options:
Number of threads: 5
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 5, tps: 185.50, reads: 2601.27, writes: 741.99, response time: 38.76ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 5, tps: 208.40, reads: 2917.30, writes: 833.60, response time: 28.82ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 5, tps: 213.40, reads: 2988.10, writes: 853.80, response time: 28.00ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 5, tps: 214.90, reads: 3009.30, writes: 859.60, response time: 27.83ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 5, tps: 219.60, reads: 3071.30, writes: 878.20, response time: 26.60ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 5, tps: 220.10, reads: 3083.10, writes: 880.40, response time: 26.68ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 5, tps: 220.70, reads: 3090.00, writes: 882.80, response time: 26.45ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 5, tps: 221.00, reads: 3094.40, writes: 884.30, response time: 26.26ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 5, tps: 222.30, reads: 3114.20, writes: 889.10, response time: 25.92ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 5, tps: 222.80, reads: 3116.80, writes: 891.00, response time: 26.18ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 5, tps: 223.20, reads: 3124.60, writes: 893.10, response time: 25.62ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 5, tps: 222.00, reads: 3108.40, writes: 888.00, response time: 25.96ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 5, tps: 223.70, reads: 3131.50, writes: 894.50, response time: 25.49ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 5, tps: 223.70, reads: 3132.00, writes: 895.10, response time: 25.37ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 5, tps: 223.80, reads: 3134.90, writes: 895.40, response time: 25.18ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 5, tps: 223.50, reads: 3126.10, writes: 893.70, response time: 25.36ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 5, tps: 222.10, reads: 3112.50, writes: 888.90, response time: 25.68ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 5, tps: 224.00, reads: 3134.80, writes: 895.30, response time: 25.19ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 5, tps: 224.30, reads: 3138.50, writes: 897.20, response time: 25.30ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 5, tps: 223.10, reads: 3123.80, writes: 892.50, response time: 25.37ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 5, tps: 223.80, reads: 3133.90, writes: 895.40, response time: 25.46ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 5, tps: 223.30, reads: 3124.91, writes: 892.90, response time: 25.66ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 5, tps: 224.10, reads: 3138.90, writes: 896.40, response time: 25.35ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 5, tps: 223.80, reads: 3134.30, writes: 895.40, response time: 25.00ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 5, tps: 222.30, reads: 3111.50, writes: 889.00, response time: 25.07ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 5, tps: 218.20, reads: 3054.30, writes: 872.90, response time: 25.72ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 5, tps: 220.00, reads: 3079.60, writes: 880.30, response time: 25.67ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 5, tps: 223.20, reads: 3125.40, writes: 892.80, response time: 25.34ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 5, tps: 223.70, reads: 3130.50, writes: 894.50, response time: 25.31ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 5, tps: 222.90, reads: 3120.10, writes: 891.50, response time: 25.97ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 5, tps: 221.60, reads: 3105.80, writes: 886.60, response time: 26.12ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 5, tps: 223.10, reads: 3122.10, writes: 892.40, response time: 25.14ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 5, tps: 223.20, reads: 3124.30, writes: 892.90, response time: 24.87ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 5, tps: 223.60, reads: 3129.80, writes: 894.10, response time: 25.02ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 5, tps: 224.10, reads: 3137.90, writes: 896.40, response time: 24.91ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 5, tps: 223.10, reads: 3122.90, writes: 892.60, response time: 25.62ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 5, tps: 224.30, reads: 3142.50, writes: 897.50, response time: 24.81ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 5, tps: 224.70, reads: 3145.70, writes: 899.20, response time: 24.76ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 5, tps: 225.00, reads: 3150.70, writes: 899.60, response time: 24.56ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 5, tps: 225.00, reads: 3146.60, writes: 900.20, response time: 24.61ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 5, tps: 224.40, reads: 3142.10, writes: 896.90, response time: 24.78ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 5, tps: 225.40, reads: 3156.20, writes: 901.70, response time: 24.91ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 5, tps: 223.70, reads: 3130.70, writes: 894.70, response time: 24.94ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 5, tps: 224.30, reads: 3140.40, writes: 897.20, response time: 24.86ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 5, tps: 223.40, reads: 3129.20, writes: 893.90, response time: 25.13ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 5, tps: 225.60, reads: 3157.70, writes: 902.30, response time: 24.76ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 5, tps: 226.90, reads: 3176.80, writes: 907.40, response time: 24.49ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 5, tps: 224.40, reads: 3140.80, writes: 897.90, response time: 25.91ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 5, tps: 226.20, reads: 3168.10, writes: 904.80, response time: 24.59ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 5, tps: 224.30, reads: 3139.90, writes: 896.90, response time: 25.24ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 5, tps: 225.80, reads: 3160.70, writes: 903.60, response time: 24.78ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 5, tps: 226.30, reads: 3168.90, writes: 905.20, response time: 24.47ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 5, tps: 226.30, reads: 3166.39, writes: 905.20, response time: 24.59ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 5, tps: 226.10, reads: 3166.51, writes: 904.00, response time: 24.65ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 5, tps: 225.60, reads: 3158.80, writes: 902.70, response time: 24.63ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 5, tps: 224.80, reads: 3146.00, writes: 899.00, response time: 25.33ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 5, tps: 225.80, reads: 3159.70, writes: 903.10, response time: 25.13ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 5, tps: 221.50, reads: 3102.60, writes: 886.00, response time: 25.77ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 5, tps: 225.20, reads: 3156.10, writes: 901.90, response time: 24.70ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 5, tps: 226.50, reads: 3168.40, writes: 905.50, response time: 24.93ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 5, tps: 226.50, reads: 3170.80, writes: 905.40, response time: 24.46ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 5, tps: 225.00, reads: 3149.50, writes: 900.00, response time: 25.04ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 5, tps: 223.90, reads: 3135.60, writes: 896.10, response time: 24.72ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 5, tps: 225.20, reads: 3154.50, writes: 900.80, response time: 24.90ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 5, tps: 225.80, reads: 3160.60, writes: 903.10, response time: 25.92ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 5, tps: 226.60, reads: 3172.10, writes: 906.30, response time: 24.67ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 5, tps: 226.70, reads: 3173.00, writes: 906.50, response time: 24.64ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 5, tps: 226.80, reads: 3175.20, writes: 907.60, response time: 24.39ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 5, tps: 226.00, reads: 3162.70, writes: 904.00, response time: 24.45ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 5, tps: 226.50, reads: 3170.60, writes: 905.60, response time: 24.56ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 5, tps: 227.40, reads: 3185.11, writes: 909.60, response time: 24.19ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 5, tps: 227.80, reads: 3189.40, writes: 911.30, response time: 24.27ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 5, tps: 227.00, reads: 3176.90, writes: 907.90, response time: 24.11ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 5, tps: 227.80, reads: 3189.30, writes: 911.20, response time: 23.89ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 5, tps: 227.70, reads: 3189.80, writes: 911.00, response time: 24.14ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 5, tps: 228.50, reads: 3198.10, writes: 913.80, response time: 24.10ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 5, tps: 228.00, reads: 3190.00, writes: 912.00, response time: 23.98ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 5, tps: 227.30, reads: 3184.20, writes: 909.60, response time: 24.11ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 5, tps: 228.90, reads: 3204.60, writes: 915.40, response time: 24.39ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 5, tps: 228.20, reads: 3195.30, writes: 912.60, response time: 24.18ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 5, tps: 228.20, reads: 3192.70, writes: 912.90, response time: 24.01ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 5, tps: 227.80, reads: 3189.90, writes: 911.30, response time: 24.42ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 5, tps: 228.50, reads: 3200.30, writes: 913.80, response time: 23.99ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 5, tps: 227.60, reads: 3183.10, writes: 910.40, response time: 24.72ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 5, tps: 228.10, reads: 3196.60, writes: 912.80, response time: 24.01ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 5, tps: 225.90, reads: 3163.50, writes: 903.70, response time: 24.56ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 5, tps: 228.70, reads: 3200.10, writes: 914.30, response time: 23.99ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 5, tps: 228.00, reads: 3191.70, writes: 912.00, response time: 24.23ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 5, tps: 224.50, reads: 3144.80, writes: 898.00, response time: 24.57ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 5, tps: 226.60, reads: 3172.00, writes: 906.80, response time: 25.63ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 5, tps: 228.00, reads: 3193.00, writes: 912.00, response time: 24.17ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 5, tps: 228.10, reads: 3192.50, writes: 912.30, response time: 24.07ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 5, tps: 227.40, reads: 3182.10, writes: 909.60, response time: 24.58ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 5, tps: 226.70, reads: 3173.80, writes: 906.70, response time: 24.90ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 5, tps: 228.90, reads: 3205.80, writes: 915.80, response time: 23.89ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 5, tps: 228.80, reads: 3201.90, writes: 914.90, response time: 24.48ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 5, tps: 228.60, reads: 3201.20, writes: 914.50, response time: 23.86ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 5, tps: 228.60, reads: 3198.60, writes: 914.20, response time: 24.03ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 5, tps: 227.70, reads: 3189.10, writes: 910.80, response time: 24.36ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 5, tps: 228.10, reads: 3193.20, writes: 912.70, response time: 24.02ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 5, tps: 228.00, reads: 3190.90, writes: 912.10, response time: 23.95ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 5, tps: 226.10, reads: 3166.50, writes: 904.50, response time: 24.62ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 5, tps: 227.90, reads: 3192.30, writes: 911.20, response time: 23.95ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 5, tps: 227.40, reads: 3183.90, writes: 909.80, response time: 24.20ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 5, tps: 227.00, reads: 3176.10, writes: 908.10, response time: 24.16ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 5, tps: 227.20, reads: 3178.90, writes: 908.40, response time: 24.28ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 5, tps: 227.80, reads: 3191.30, writes: 911.60, response time: 24.20ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 5, tps: 228.10, reads: 3192.80, writes: 912.10, response time: 24.26ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 5, tps: 228.70, reads: 3204.80, writes: 915.30, response time: 23.78ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 5, tps: 227.50, reads: 3183.30, writes: 909.80, response time: 24.29ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 5, tps: 228.50, reads: 3197.30, writes: 913.60, response time: 24.03ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 5, tps: 227.80, reads: 3190.40, writes: 911.50, response time: 24.35ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 5, tps: 228.20, reads: 3193.10, writes: 912.80, response time: 24.09ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 5, tps: 228.60, reads: 3201.20, writes: 914.10, response time: 24.02ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 5, tps: 229.10, reads: 3210.00, writes: 917.00, response time: 23.89ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 5, tps: 227.00, reads: 3174.70, writes: 907.40, response time: 24.51ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 5, tps: 227.60, reads: 3188.40, writes: 910.90, response time: 24.57ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 5, tps: 228.40, reads: 3197.10, writes: 913.10, response time: 24.13ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 5, tps: 228.40, reads: 3197.90, writes: 913.90, response time: 23.95ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 5, tps: 224.50, reads: 3142.20, writes: 897.70, response time: 24.86ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 5, tps: 208.80, reads: 2924.30, writes: 835.20, response time: 37.27ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 5, tps: 216.10, reads: 3024.30, writes: 864.70, response time: 29.24ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 5, tps: 228.30, reads: 3196.00, writes: 913.20, response time: 24.34ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 5, tps: 227.10, reads: 3179.00, writes: 908.50, response time: 24.36ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 5, tps: 226.80, reads: 3178.50, writes: 907.90, response time: 24.13ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 5, tps: 227.70, reads: 3187.50, writes: 910.00, response time: 24.30ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 5, tps: 228.00, reads: 3188.60, writes: 911.70, response time: 24.27ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 5, tps: 226.40, reads: 3170.80, writes: 905.60, response time: 24.45ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 5, tps: 228.10, reads: 3193.10, writes: 912.60, response time: 24.17ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 5, tps: 228.10, reads: 3195.10, writes: 912.20, response time: 24.02ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 5, tps: 228.30, reads: 3196.00, writes: 914.00, response time: 23.97ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 5, tps: 228.20, reads: 3195.20, writes: 912.00, response time: 24.46ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 5, tps: 228.80, reads: 3201.10, writes: 915.20, response time: 24.02ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 5, tps: 228.30, reads: 3197.90, writes: 913.40, response time: 24.16ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 5, tps: 228.10, reads: 3190.60, writes: 912.30, response time: 24.28ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 5, tps: 228.30, reads: 3196.90, writes: 913.10, response time: 24.08ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 5, tps: 228.00, reads: 3192.89, writes: 912.00, response time: 23.95ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 5, tps: 228.50, reads: 3199.01, writes: 914.20, response time: 24.43ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 5, tps: 228.10, reads: 3191.50, writes: 912.50, response time: 24.23ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 5, tps: 227.20, reads: 3183.40, writes: 909.10, response time: 24.37ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 5, tps: 228.50, reads: 3198.50, writes: 913.80, response time: 24.16ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 5, tps: 228.10, reads: 3194.30, writes: 912.00, response time: 24.21ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 5, tps: 228.60, reads: 3199.30, writes: 914.60, response time: 24.08ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 5, tps: 228.40, reads: 3196.10, writes: 913.40, response time: 24.21ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 5, tps: 228.70, reads: 3202.50, writes: 914.90, response time: 24.14ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 5, tps: 228.50, reads: 3199.30, writes: 913.90, response time: 24.24ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 5, tps: 226.20, reads: 3168.00, writes: 905.20, response time: 24.56ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 5, tps: 228.10, reads: 3194.10, writes: 912.10, response time: 24.35ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 5, tps: 228.30, reads: 3196.20, writes: 913.80, response time: 24.22ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 5, tps: 227.20, reads: 3182.40, writes: 908.90, response time: 25.21ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 5, tps: 228.50, reads: 3197.90, writes: 913.60, response time: 24.41ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 5, tps: 225.30, reads: 3152.70, writes: 901.10, response time: 24.54ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 5, tps: 223.60, reads: 3129.80, writes: 894.10, response time: 24.64ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 5, tps: 226.50, reads: 3170.89, writes: 906.00, response time: 24.25ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 5, tps: 226.90, reads: 3176.11, writes: 907.60, response time: 24.10ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 5, tps: 226.50, reads: 3169.70, writes: 906.00, response time: 24.82ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 5, tps: 228.70, reads: 3206.30, writes: 915.10, response time: 23.85ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 5, tps: 228.60, reads: 3199.80, writes: 915.10, response time: 23.82ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 5, tps: 228.80, reads: 3202.70, writes: 914.20, response time: 23.92ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 5, tps: 228.40, reads: 3195.70, writes: 913.60, response time: 23.94ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 5, tps: 228.70, reads: 3204.71, writes: 915.30, response time: 24.17ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 5, tps: 227.80, reads: 3188.90, writes: 910.70, response time: 24.68ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 5, tps: 227.60, reads: 3183.40, writes: 910.40, response time: 24.51ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 5, tps: 228.40, reads: 3199.80, writes: 914.10, response time: 24.56ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 5, tps: 227.10, reads: 3177.00, writes: 908.10, response time: 24.14ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 5, tps: 227.90, reads: 3192.00, writes: 911.40, response time: 24.44ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 5, tps: 227.90, reads: 3188.10, writes: 911.60, response time: 24.36ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 5, tps: 228.10, reads: 3195.50, writes: 912.40, response time: 24.37ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 5, tps: 228.00, reads: 3194.80, writes: 912.20, response time: 24.37ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 5, tps: 227.90, reads: 3189.90, writes: 911.80, response time: 24.38ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 5, tps: 229.50, reads: 3211.10, writes: 917.80, response time: 23.89ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 5, tps: 228.80, reads: 3201.90, writes: 915.00, response time: 24.59ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 5, tps: 228.40, reads: 3200.00, writes: 913.60, response time: 24.52ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 5, tps: 228.40, reads: 3194.70, writes: 913.70, response time: 24.18ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 5, tps: 229.20, reads: 3210.10, writes: 916.70, response time: 23.85ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 5, tps: 228.30, reads: 3198.10, writes: 913.30, response time: 24.39ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 5, tps: 226.60, reads: 3171.20, writes: 906.60, response time: 24.70ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 5, tps: 227.80, reads: 3190.19, writes: 911.50, response time: 24.39ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 5, tps: 227.70, reads: 3186.60, writes: 910.20, response time: 24.46ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 5, tps: 227.40, reads: 3184.60, writes: 910.00, response time: 24.67ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            5688956
        write:                           1625416
        other:                           812708
        total:                           8127080
    transactions:                        406354 (225.75 per sec.)
    read/write requests:                 7314372 (4063.49 per sec.)
    other operations:                    812708 (451.50 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0206s
    total number of events:              406354
    total time taken by event execution: 8999.2994s
    response time:
         min:                                 19.55ms
         avg:                                 22.15ms
         max:                                 92.91ms
         approx.  99 percentile:              25.61ms

Threads fairness:
    events (avg/stddev):           81270.8000/843.41
    execution time (avg/stddev):   1799.8599/0.01



[coding001@voice ~]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.13    2.09    9.61     0.14     0.36    87.50     0.09    7.31   23.63    3.75   0.50   0.59

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1456.00     0.00    28.11    39.54     0.82    0.56    0.00    0.56   0.11  16.20

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1567.00     0.00    30.60    39.99     0.86    0.55    0.00    0.55   0.11  16.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00 1425.00     0.00    27.86    40.04     0.78    0.55    0.00    0.55   0.11  15.30

^C
[coding001@voice ~]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/21/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.67    0.00    0.72    0.19    0.00   98.42

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda              11.70       143.23       368.70 1200515658 3090325800

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          27.98    0.00    9.33    1.81    0.00   60.88

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1448.00         0.00     28704.00          0      28704

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          27.70    0.00    8.71    2.37    0.00   61.21

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1454.00         0.00     28832.00          0      28832

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          27.89    0.00    8.68    2.11    0.00   61.32

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1443.00         0.00     28664.00          0      28664

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          27.89    0.00    8.42    2.37    0.00   61.32

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1506.00        16.00     29464.00         16      29464

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          28.05    0.00    9.35    2.08    0.00   60.52

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda            1478.00         0.00     29612.00          0      29612


[coding001@voice ~]$ top
top - 15:16:24 up 97 days, 14 min,  3 users,  load average: 1.57, 1.60, 1.93
Tasks: 116 total,   1 running, 115 sleeping,   0 stopped,   0 zombie
%Cpu0  : 33.0 us,  7.6 sy,  0.0 ni, 56.2 id,  1.0 wa,  0.0 hi,  2.1 si,  0.0 st
%Cpu1  : 32.9 us,  7.9 sy,  0.0 ni, 56.5 id,  1.7 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu2  : 28.6 us,  7.5 sy,  0.0 ni, 60.0 id,  1.4 wa,  0.0 hi,  2.5 si,  0.0 st
%Cpu3  : 19.9 us,  7.1 sy,  0.0 ni, 69.6 id,  3.4 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem : 16266300 total,   188112 free, 11399272 used,  4678916 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  3758092 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
32578 mysql     20   0   11.2g   9.1g   9812 S 153.2 58.4 404:24.09 mysqld     