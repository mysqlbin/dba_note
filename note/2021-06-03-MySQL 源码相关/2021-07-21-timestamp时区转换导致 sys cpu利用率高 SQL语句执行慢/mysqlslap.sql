create  database mysqlslap DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

alter user 'pt_user'@'%' identified by '#123456Abc';


mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.26-log |
+------------+
1 row in set (0.00 sec)



时区转换的断点


时间字段=now()  和时间字段=带入的时间 的CPU消耗对比



mysqlslap  --no-defaults -h192.168.1.12 -uroot -p'game2018root' --number-of-queries=1000000 --concurrency=10 --query='SELECT NOW()'


show global variables like 'time_zone';
mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | SYSTEM |
+---------------+--------+
1 row in set (0.00 sec)

 /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=10 --query='SELECT NOW()'
 
 
 
 [coding001@voice ~]$  /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=10 --query='SELECT NOW()'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 33.190 seconds
	Minimum number of seconds to run all queries: 33.190 seconds
	Maximum number of seconds to run all queries: 33.190 seconds
	Number of clients running queries: 10
	Average number of queries per client: 100000



 [coding001@voice ~]$ top
top - 15:07:08 up 6 days, 5 min,  3 users,  load average: 1.63, 0.41, 0.16
Tasks: 119 total,   1 running, 118 sleeping,   0 stopped,   0 zombie
%Cpu0  : 46.0 us, 42.7 sy,  0.0 ni,  0.3 id,  0.0 wa,  0.0 hi, 11.0 si,  0.0 st
%Cpu1  : 42.5 us, 44.2 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 13.3 si,  0.0 st
%Cpu2  : 45.8 us, 41.2 sy,  0.0 ni,  0.3 id,  0.0 wa,  0.0 hi, 12.6 si,  0.0 st
%Cpu3  : 48.2 us, 39.8 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 12.0 si,  0.0 st
KiB Mem : 16266300 total, 11493840 free,  2138036 used,  2634424 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13762520 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   10.8g   1.4g  11756 S 270.1  8.9   0:35.30 mysqld                                                                                                                                                                                                   
20962 coding0+  20   0  762540   1792   1416 S 127.2  0.0   0:14.96 mysqlslap                                                                                                                                                                                                
 1052 coding0+  20   0  147768  41756   1404 S   0.7  0.3 339:51.36 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39632   1320 S   0.7  0.2 340:48.84 skynet   
 
 
 [coding001@voice ~]$ vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0  11777      2   2695    0    0     1     2    8    1  0  1 99  0  0
 0  0      0  11777      2   2695    0    0     0     0 1716 3265  1  1 99  0  0
 0  0      0  11777      2   2695    0    0     0     0 1673 3245  0  1 99  0  0
10  0      0  11777      2   2695    0    0     0     0 3160 31951 18 24 58  0  0
10  0      0  11777      2   2695    0    0     0     0 4832 68494 45 54  0  0  0
14  0      0  11777      2   2695    0    0     0     0 4834 68181 45 55  0  0  0
11  0      0  11777      2   2695    0    0     0     0 4809 67056 46 54  0  0  0
13  0      0  11777      2   2695    0    0     0    92 4849 67822 46 54  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4811 67845 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4830 66311 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4806 66708 46 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4821 68097 44 56  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4738 67479 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4510 68793 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4475 66452 45 55  0  0  0
11  0      0  11777      2   2695    0    0     0     0 4801 67232 45 55  0  0  0
11  0      0  11777      2   2695    0    0     0     0 4790 67324 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4804 67670 44 56  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4816 66745 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4798 67775 44 56  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4828 67969 45 54  0  0  0
12  0      0  11777      2   2695    0    0     0     0 4802 66472 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4802 66798 46 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4832 66563 44 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4835 68917 44 56  0  0  0
10  0      0  11777      2   2695    0    0     0   552 4663 68504 44 56  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4816 68393 44 56  0  0  0
11  0      0  11777      2   2695    0    0     0     0 4687 70420 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4887 72488 44 56  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4810 67911 45 55  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4779 67412 45 56  0  0  0
10  0      0  11777      2   2695    0    0     0     0 4842 69125 45 54  0  0  0
 9  0      0  11777      2   2695    0    0     0     8 4805 68467 44 56  0  0  0
 8  0      0  11776      2   2695    0    0     0     0 4926 69407 44 55  1  0  0
 6  0      0  11776      2   2695    0    0     0     0 6676 70219 43 54  3  0  0
 3  0      0  11775      2   2695    0    0     0     8 14303 66588 37 48 14  0  0
 0  0      0  11776      2   2695    0    0     0     0 18433 35410  9 13 78  0  0
 1  0      0  11774      2   2695    0    0     0     0 2582 3621  1  7 92  0  0
 0  0      0  11776      2   2695    0    0     0     4 2375 3853  1  4 95  0  0
 0  0      0  11776      2   2695    0    0     0     0 1712 3269  0  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 1688 3255  0  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 1683 3243  0  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 1695 3263  0  1 99  0  0

 
 
------------------------------------------------------------------------------------------------------------------------------------
 
 
set global time_zone='+08:00';
 
mysql> set global time_zone='+08:00';
Query OK, 0 rows affected (0.00 sec)

mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | +08:00 |
+---------------+--------+
1 row in set (0.00 sec)


[coding001@voice ~]$ top
top - 15:11:18 up 6 days, 9 min,  3 users,  load average: 3.22, 1.21, 0.53
Tasks: 119 total,   1 running, 118 sleeping,   0 stopped,   0 zombie
%Cpu0  : 43.5 us, 45.5 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 11.0 si,  0.0 st
%Cpu1  : 41.9 us, 45.2 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 13.0 si,  0.0 st
%Cpu2  : 43.0 us, 45.3 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 11.7 si,  0.0 st
%Cpu3  : 40.9 us, 46.5 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 12.6 si,  0.0 st
KiB Mem : 16266300 total, 11488500 free,  2143264 used,  2634536 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13757276 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   10.8g   1.4g  11756 S 264.5  8.9   2:31.76 mysqld                                                                                                                                                                                                   
21123 coding0+  20   0  762540   1784   1416 S 132.6  0.0   0:29.93 mysqlslap                                                                                                                                                                                                
 1085 coding0+  20   0  174352  39632   1320 S   1.0  0.2 340:57.45 skynet                                                                                                                                                                                                   
 1052 coding0+  20   0  147768  41756   1404 S   0.7  0.3 339:59.96 skynet   


[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=10 --query='SELECT NOW()'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 32.644 seconds
	Minimum number of seconds to run all queries: 32.644 seconds
	Maximum number of seconds to run all queries: 32.644 seconds
	Number of clients running queries: 10
	Average number of queries per client: 100000


[coding001@voice ~]$ vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0  11777      2   2695    0    0     1     2    8   20  0  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 2353 3882  1  3 96  0  0
 0  0      0  11776      2   2695    0    0     0     0 1712 3274  0  1 99  0  0
10  0      0  11771      2   2695    0    0     0     0 4104 49197 32 44 24  0  0
10  0      0  11771      2   2695    0    0     0     0 4817 64730 44 56  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4839 65246 46 54  0  0  0
11  0      0  11771      2   2695    0    0     0     0 4855 64502 41 58  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4792 64725 42 59  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4840 64526 43 57  0  0  0
12  0      0  11771      2   2695    0    0     0     0 4820 64049 42 58  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4806 64270 42 58  0  0  0
12  0      0  11771      2   2695    0    0     0     0 4818 64012 43 57  0  0  0
11  0      0  11771      2   2695    0    0     0     0 4802 64709 42 58  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4825 65131 44 56  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4810 65093 45 55  0  0  0
11  0      0  11771      2   2695    0    0     0     0 4812 64169 42 58  0  0  0
11  0      0  11771      2   2695    0    0     0     0 4677 64814 44 56  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4444 64216 44 56  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4451 64004 43 57  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4804 63931 44 56  0  0  0
11  0      0  11771      2   2695    0    0     0    92 4834 64781 43 57  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4785 65745 43 57  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4805 63826 43 57  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4831 63592 42 58  0  0  0
12  0      0  11771      2   2695    0    0     0     0 4810 64898 44 56  0  0  0
 6  0      0  11771      2   2695    0    0     0     0 4819 64465 43 57  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4813 63541 43 58  0  0  0
11  0      0  11771      2   2695    0    0     0     0 4807 64690 43 57  0  0  0
12  0      0  11771      2   2695    0    0     0     0 4805 63312 42 58  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4821 64256 41 59  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4612 63784 43 57  0  0  0
11  0      0  11771      2   2695    0    0     0     0 4817 64307 42 58  0  0  0
10  0      0  11771      2   2695    0    0     0     0 4801 62883 43 57  0  0  0
10  0      0  11771      2   2695    0    0     0   136 4809 64285 45 55  0  0  0
 9  0      0  11771      2   2695    0    0     0     0 4873 64158 42 58  0  0  0
 0  0      0  11776      2   2695    0    0     0     0 12640 51900 26 37 37  0  0
 0  0      0  11776      2   2695    0    0     0     0 1707 3253  0  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 1673 3225  0  1 99  0  0
 1  0      0  11776      2   2695    0    0     0     0 1700 3261  0  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 1700 3250  1  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 1687 3251  0  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 1699 3240  0  1 99  0  0
 0  0      0  11776      2   2695    0    0     0     0 1696 3265  0  1 99  0  0

