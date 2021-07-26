

CREATE TABLE `t_20210722` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
`name` varchar(32) not NULL default '',
`age` int(11) not NULL default 0,
`createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
PRIMARY KEY (`id`),
KEY `idx_createTime` (`createTime`)
) ENGINE=InnoDB;

truncate table t_20210722;

mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | SYSTEM |
+---------------+--------+
1 row in set (0.01 sec)




/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=30 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'

mysql> show processlist;
+-----+-----------------+--------------------+-----------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
| Id  | User            | Host               | db        | Command | Time   | State                  | Info                                                                                                 |
+-----+-----------------+--------------------+-----------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
|   3 | event_scheduler | localhost          | NULL      | Daemon  | 330867 | Waiting on empty queue | NULL                                                                                                 |
| 184 | root            | localhost          | mysqlslap | Query   |      0 | starting               | show processlist                                                                                     |
| 248 | pt_user         | 192.168.1.12:36210 | NULL      | Sleep   |     85 |                        | NULL                                                                                                 |
| 249 | pt_user         | 192.168.1.12:36212 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 250 | pt_user         | 192.168.1.12:36214 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 251 | pt_user         | 192.168.1.12:36218 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 252 | pt_user         | 192.168.1.12:36216 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 253 | pt_user         | 192.168.1.12:36220 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 254 | pt_user         | 192.168.1.12:36222 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 255 | pt_user         | 192.168.1.12:36224 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 256 | pt_user         | 192.168.1.12:36226 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 257 | pt_user         | 192.168.1.12:36228 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 258 | pt_user         | 192.168.1.12:36230 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 259 | pt_user         | 192.168.1.12:36232 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 260 | pt_user         | 192.168.1.12:36233 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 261 | pt_user         | 192.168.1.12:36236 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 262 | pt_user         | 192.168.1.12:36240 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 263 | pt_user         | 192.168.1.12:36242 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 264 | pt_user         | 192.168.1.12:36238 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 265 | pt_user         | 192.168.1.12:36244 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 266 | pt_user         | 192.168.1.12:36246 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 267 | pt_user         | 192.168.1.12:36248 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 268 | pt_user         | 192.168.1.12:36252 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 269 | pt_user         | 192.168.1.12:36262 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 270 | pt_user         | 192.168.1.12:36264 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 271 | pt_user         | 192.168.1.12:36268 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 272 | pt_user         | 192.168.1.12:36256 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 273 | pt_user         | 192.168.1.12:36250 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 274 | pt_user         | 192.168.1.12:36258 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 275 | pt_user         | 192.168.1.12:36260 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 276 | pt_user         | 192.168.1.12:36254 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 277 | pt_user         | 192.168.1.12:36266 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 278 | pt_user         | 192.168.1.12:36270 | mysqlslap | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
+-----+-----------------+--------------------+-----------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
33 rows in set (0.00 sec)


top - 10:53:39 up 9 days, 19:51,  6 users,  load average: 3.47, 1.77, 0.82
Tasks: 128 total,   2 running, 126 sleeping,   0 stopped,   0 zombie
%Cpu0  : 17.4 us, 15.3 sy,  0.0 ni, 53.7 id, 10.0 wa,  0.0 hi,  3.6 si,  0.0 st
%Cpu1  : 19.9 us, 12.3 sy,  0.0 ni, 56.2 id,  9.2 wa,  0.0 hi,  2.4 si,  0.0 st
%Cpu2  : 17.3 us, 11.9 sy,  0.0 ni, 58.6 id,  9.8 wa,  0.0 hi,  2.4 si,  0.0 st
%Cpu3  : 17.5 us, 10.7 sy,  0.0 ni, 61.2 id,  8.6 wa,  0.0 hi,  2.1 si,  0.0 st
KiB Mem : 16266300 total, 10562820 free,  2292800 used,  3410680 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13553004 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.4g   1.5g  12488 S 141.9  9.8  41:53.62 mysqld                                                                                                                                                                                                   
21897 coding0+  20   0 2237180   2056   1468 S  21.9  0.0   0:15.68 mysqlslap                                                                                                                                                                                                
  202 root       0 -20       0      0      0 S   5.0  0.0   0:21.88 kworker/0:1H                                                                                                                                                                                             
 1052 coding0+  20   0  147768  41760   1404 S   4.7  0.3 576:40.89 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39640   1320 S   4.7  0.2 578:28.18 skynet                                                                                                                                                                                                   
18673 root      20   0       0      0      0 R   1.7  0.0   0:04.86 kworker/0:2                                                                                                                                                                                              
 1142 mongodb   20   0 1617356 121068  11636 S   1.0  0.7  79:35.30 mongod                                                                                                                                                                                                   
    6 root      20   0       0      0      0 S   0.3  0.0   0:05.05 ksoftirqd/0                                                                                                                                                                                              
21526 coding0+  20   0  162104   2332   1604 R   0.3  0.0   0:00.89 top                                                                                                                                                                                                      
21822 root      20   0       0      0      0 S   0.3  0.0   0:00.17 kworker/2:2                                                                                                                                                                                              
    1 root      20   0  193664   6668   4156 S   0.0  0.0   4:16.97 systemd                                                                                                                                                                                                  
    2 root      20   0       0      0      0 S   0.0  0.0   0:00.44 kthreadd                                                                                                                                                                                                 
    4 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H         

	
vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 3  2      0  10838      2   3468    0    0     0  6496 12678 30565 18 16 56 10  0
 1  0      0  10836      2   3470    0    0     0  6100 11768 28786 18 15 57 10  0
 2  2      0  10833      2   3472    0    0     0  6140 11879 28634 19 15 55 10  0
 2  0      0  10831      2   3474    0    0     0  6272 12452 29926 19 16 55 10  0
 0  0      0  10829      2   3476    0    0     0  6056 11813 28656 18 15 57 10  0
 1  2      0  10826      2   3480    0    0     0  7112 11728 28617 19 15 56  9  0
 6  2      0  10824      2   3482    0    0     0  5688 11177 27048 19 14 58  9  0
 4  2      0  10821      2   3484    0    0     0  5824 11598 27742 18 15 57  9  0
 3  2      0  10820      2   3486    0    0     0  5788 11270 27352 17 14 60  9  0
 4  2      0  10818      2   3488    0    0     0  6312 12457 30076 18 16 57  9  0
 1  2      0  10815      2   3491    0    0     0  7104 13336 32862 20 16 54 10  0
 2  2      0  10812      2   3493    0    0     0  6872 13117 31967 20 16 55  8  0
 5  2      0  10809      2   3497    0    0     0  7924 13020 32230 20 16 56  9  0
 0  2      0  10806      2   3499    0    0     0  6996 13059 32535 21 16 54  9  0
 3  2      0  10804      2   3502    0    0     0  6752 12677 31452 18 16 57  9  0
 5  2      0  10801      2   3504    0    0     0  6852 12760 31718 18 16 57  9  0
 1  1      0  10799      2   3507    0    0     0  7060 13368 33066 19 16 56  9  0
 0  0      0  10795      2   3511    0    0     0  8180 13306 33079 20 16 55  9  0
 3  1      0  10793      2   3513    0    0     0  6964 12967 32157 19 16 56  9  0
 5  1      0  10791      2   3515    0    0     0  7060 13194 32875 19 16 55  9  0
 0  0      0  10788      2   3518    0    0     0  6924 12939 31852 19 16 56  8  0
 3  0      0  10784      2   3521    0    0     0  8016 13136 32672 19 16 56  9  0
 0  0      0  10779      2   3525    0    0     0  7052 13398 33083 19 16 56  9  0
 3  2      0  10777      2   3527    0    0     0  6788 12987 31954 19 16 56  9  0
 3  1      0  10774      2   3529    0    0     0  6800 12903 31815 20 14 56 10  0
 4  2      0  10771      2   3533    0    0     0  7988 13095 32486 18 16 57  9  0
 2  1      0  10768      2   3535    0    0     0  7052 13157 32918 19 15 57  8  0
 1  0      0  10766      2   3538    0    0     0  6752 12839 31655 18 16 57  9  0
 2  0      0  10763      2   3540    0    0     0  7312 13417 33356 21 16 54  9  0
 2  0      0  10761      2   3543    0    0     0  6928 13236 32605 20 15 55 10  0
 3  2      0  10756      2   3546    0    0     0  6732 12821 31512 19 15 57  9  0
 0  0      0  10754      2   3547    0    0     0  6688 12792 31567 19 16 57  9  0
 5  1      0  10750      2   3550    0    0     0  6796 12706 31326 20 18 53  8  0
 7  2      0  10748      2   3553    0    0     0  6924 13236 32562 20 16 55  9  0
 4  2      0  10747      2   3555    0    0     0  6812 12981 31957 19 16 57  8  0
 0  0      0  10744      2   3558    0    0     0  6820 12816 31776 20 14 57  9  0
 5  2      0  10741      2   3561    0    0     0  7812 12924 31949 19 16 56  9  0
 0  0      0  10738      2   3564    0    0     0  7076 13042 32431 19 16 56  9  0
 2  0      0  10736      2   3566    0    0     0  6624 12565 31081 18 15 58  9  0
 0  0      0  10733      2   3568    0    0     0  6680 13007 31560 18 15 58  9  0
 5  2      0  10731      2   3571    0    0     0  7044 13110 32308 19 15 56  9  0
 1  0      0  10728      2   3573    0    0     0  7008 13107 32620 20 15 56  9  0
 4  2      0  10723      2   3576    0    0     0  7040 13357 32649 19 16 55  9  0
 3  2      0  10720      2   3580    0    0     0  8104 13162 32843 19 16 56  9  0
 2  1      0  10717      2   3582    0    0     0  6636 12650 30958 19 14 57  9  0
 2  1      0  10712      2   3586    0    0     0  9232 13240 33114 20 16 55  9  0
 1  0      0  10709      2   3589    0    0     0  7428 13578 34103 21 17 54  8  0
 2  0      0  10707      2   3592    0    0     0  6892 13170 32250 19 16 58  8  0
 3  2      0  10704      2   3594    0    0     0  6964 13258 32675 20 15 56  9  0
 3  0      0  10702      2   3597    0    0     0  6976 13087 32400 19 16 56  9  0
 0  0      0  10699      2   3599    0    0     0  6848 12898 31818 19 15 57 10  0
 4  0      0  10694      2   3602    0    0     0  6860 13081 32328 20 16 56  8  0
 2  2      0  10691      2   3605    0    0     0  7848 12966 32159 19 16 55  9  0


[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=30 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 323.253 seconds
	Minimum number of seconds to run all queries: 323.253 seconds
	Maximum number of seconds to run all queries: 323.253 seconds
	Number of clients running queries: 30
	Average number of queries per client: 33333



--------------------------------------------------------------------------------------------------------------------------------------------

truncate table t_20210722;

mysql> select count(*) from t_20210722;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.00 sec)



set global time_zone="+8:00";


mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | +08:00 |
+---------------+--------+
1 row in set (0.01 sec)


/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=30 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'



[coding001@voice ~]$ top
top - 11:01:58 up 9 days, 20:00,  6 users,  load average: 3.62, 2.77, 1.72
Tasks: 129 total,   1 running, 128 sleeping,   0 stopped,   0 zombie
%Cpu0  : 19.9 us, 14.9 sy,  0.0 ni, 51.2 id,  9.6 wa,  0.0 hi,  4.3 si,  0.0 st
%Cpu1  : 21.0 us, 12.9 sy,  0.0 ni, 55.3 id,  8.1 wa,  0.0 hi,  2.7 si,  0.0 st
%Cpu2  : 18.5 us, 12.5 sy,  0.0 ni, 56.9 id,  9.4 wa,  0.0 hi,  2.7 si,  0.0 st
%Cpu3  : 17.4 us, 11.6 sy,  0.0 ni, 60.4 id,  7.8 wa,  0.0 hi,  2.7 si,  0.0 st
KiB Mem : 16266300 total,  9499504 free,  2345964 used,  4420832 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13499544 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.4g   1.6g  12568 S 144.2 10.1  51:37.34 mysqld                                                                                                                                                                                                   
22202 coding0+  20   0 2237180   2056   1468 S  22.9  0.0   0:34.52 mysqlslap                                                                                                                                                                                                
  202 root       0 -20       0      0      0 S   4.7  0.0   0:42.07 kworker/0:1H                                                                                                                                                                                             
 1052 coding0+  20   0  147768  41760   1404 S   4.0  0.3 577:01.45 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39640   1320 S   4.0  0.2 578:48.82 skynet                                                                                                                                                                                                   
18673 root      20   0       0      0      0 S   1.3  0.0   0:11.66 kworker/0:2                                                                                                                                                                                              
21526 coding0+  20   0  162104   2332   1604 R   0.7  0.0   0:01.71 top                                                                                                                                                                                                      
    6 root      20   0       0      0      0 S   0.3  0.0   0:05.98 ksoftirqd/0    


procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 4  2      0   9857      2   4378    0    0     0  7772 12842 31254 18 16 57  9  0
 0  0      0   9855      2   4381    0    0     0  6992 13321 32488 18 16 57  9  0
 0  0      0   9852      2   4383    0    0     0  7472 13400 33032 19 15 56  9  0
 1  2      0   9849      2   4386    0    0     0  8188 13592 32960 20 14 56 10  0
 0  0      0   9845      2   4389    0    0     0  7324 13744 33543 19 16 56  9  0
 1  0      0   9843      2   4392    0    0     0  7152 13402 32768 19 16 56  9  0
 6  2      0   9840      2   4395    0    0     0  7228 13533 32913 20 16 55  9  0
 0  0      0   9838      2   4397    0    0     0  7240 13801 33495 20 16 55  9  0
 3  1      0   9834      2   4400    0    0     0  7756 12772 30896 19 14 57  9  0
 0  0      0   9831      2   4403    0    0     0  7120 13535 32875 19 15 56  9  0
 0  2      0   9829      2   4406    0    0     0  7468 13755 33873 21 16 55  8  0
 7  2      0   9825      2   4409    0    0     0  7792 12947 31349 19 16 56  9  0
 2  0      0   9822      2   4412    0    0     0  6848 13197 31749 19 15 57  9  0
 0  0      0   9818      2   4414    0    0     0  7096 13428 32559 22 16 54  8  0
 4  1      0   9812      2   4418    0    0     0  8104 12861 31550 20 16 55  9  0
 1  2      0   9809      2   4421    0    0     0  6880 12938 31282 19 15 57  9  0
 4  2      0   9807      2   4423    0    0     0  6656 12627 30494 18 16 57  9  0
 7  1      0   9704      2   4425    0    0     0  6832 11298 28710 34 17 42  7  0
 3  1      0   9726      2   4432    0    0     0 10944 10360 27059 40 15 38  7  0
 2  0      0   9816      2   4435    0    0     0  6936 13197 32041 19 17 55  9  0
 7  2      0   9813      2   4437    0    0     0  6804 12549 30688 19 16 56  9  0
 4  2      0   9811      2   4440    0    0     0  7056 13375 32449 20 16 56  9  0
 7  2      0   9809      2   4442    0    0     0  6952 12769 31169 19 15 57  9  0
 3  0      0   9806      2   4444    0    0     0  6912 12910 31765 18 16 57  9  0
 2  0      0   9804      2   4447    0    0     0  7268 13646 33125 19 17 55  9  0
 4  0      0   9801      2   4450    0    0     0  7112 13299 32593 19 16 55  9  0
 3  2      0   9799      2   4453    0    0     0  6952 13382 32277 19 15 57  9  0
 0  0      0   9796      2   4455    0    0     0  7404 14039 34142 20 17 54  9  0
 4  2      0   9794      2   4458    0    0     0  7412 14052 34052 20 16 54  9  0
 4  0      0   9791      2   4460    0    0     0  7132 13390 32678 20 15 55  9  0
 1  0      0   9788      2   4463    0    0     0  7136 13460 32643 20 16 55 10  0
 2  2      0   9786      2   4465    0    0     0  6912 13227 32041 19 15 57  9  0
 3  2      0   9783      2   4468    0    0     0  6936 13166 32097 19 16 57  9  0
 3  2      0   9781      2   4470    0    0     0  6856 12989 31452 19 14 57 10  0
 2  2      0   9778      2   4473    0    0     0  7092 13258 32113 19 16 55 10  0
 6  1      0   9777      2   4475    0    0     0  7004 13415 32655 18 15 57  9  0
 0  0      0   9773      2   4478    0    0     0  6988 13351 32362 19 16 56  9  0
 3  0      0   9771      2   4481    0    0     0  6708 12640 30694 19 15 57 10  0
 2  0      0   9764      2   4487    0    0     0 11208 13123 32192 19 15 56  9  0
 0  0      0   9762      2   4489    0    0     0  6864 13038 31703 19 15 57  9  0
 2  0      0   9759      2   4492    0    0     0  6860 13221 31876 19 15 56  9  0
 1  0      0   9756      2   4495    0    0     0  7012 13434 32469 19 15 57 10  0
 4  1      0   9754      2   4497    0    0     0  6892 13024 31602 19 16 57  9  0
 1  0      0   9752      2   4500    0    0     0  6948 13003 31483 19 15 57  9  0
 0  0      0   9749      2   4502    0    0     0  7148 13060 31837 18 16 57  9  0
 3  0      0   9746      2   4505    0    0     0  7200 13703 33165 20 16 55  9  0
 2  0      0   9744      2   4507    0    0     0  7028 13288 32264 19 15 57  9  0
 4  2      0   9741      2   4510    0    0     0  7172 13502 33092 19 16 56  9  0
 2  1      0   9739      2   4513    0    0     0  7044 13450 32578 19 16 56  9  0
 5  1      0   9737      2   4515    0    0     0  6812 12921 31265 19 14 58  9  0
 3  2      0   9734      2   4517    0    0     0  6988 13324 32295 20 15 56  9  0
 5  0      0   9731      2   4520    0    0     0  7028 13254 32244 19 16 56  8  0
 0  0      0   9729      2   4523    0    0     0  7084 13455 32648 18 17 56  9  0

	
	
[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=30 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 325.035 seconds
	Minimum number of seconds to run all queries: 325.035 seconds
	Maximum number of seconds to run all queries: 325.035 seconds
	Number of clients running queries: 30
	Average number of queries per client: 33333

	
	
没有体现出来的差距。


