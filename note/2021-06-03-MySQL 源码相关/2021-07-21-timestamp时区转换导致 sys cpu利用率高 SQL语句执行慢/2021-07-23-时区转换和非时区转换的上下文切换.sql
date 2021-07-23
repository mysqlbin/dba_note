

CREATE TABLE `t_20210722` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
`name` varchar(32) not NULL default '',
`age` int(11) not NULL default 0,
`createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
PRIMARY KEY (`id`),
KEY `idx_createTime` (`createTime`)
) ENGINE=InnoDB;

insert into t_20210722(name, age) values('bin', 1);
insert into t_20210722(name, age) values('bin1', 1);
insert into t_20210722(name, age) values('bi2', 1);
insert into t_20210722(name, age) values('bi3', 1);
insert into t_20210722(name, age) values('bi4', 1);
insert into t_20210722(name, age) values('bi5', 1);
insert into t_20210722(name, age) values('bi6', 1);
insert into t_20210722(name, age) values('bin7', 1);
insert into t_20210722(name, age) values('bin8', 1);
insert into t_20210722(name, age) values('bin9', 1);
insert into t_20210722(name, age) values('bin10', 1);

mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | SYSTEM |
+---------------+--------+
1 row in set (0.01 sec)


mysql> select * from t_20210722;
+----+-------+-----+---------------------+
| id | name  | age | createTime          |
+----+-------+-----+---------------------+
|  1 | bin   |   1 | 2021-07-22 15:55:28 |
|  2 | bin1  |   1 | 2021-07-22 15:55:28 |
|  3 | bi2   |   1 | 2021-07-22 15:55:28 |
|  4 | bi3   |   1 | 2021-07-22 15:55:28 |
|  5 | bi4   |   1 | 2021-07-22 15:55:28 |
|  6 | bi5   |   1 | 2021-07-22 15:55:28 |
|  7 | bi6   |   1 | 2021-07-22 15:55:28 |
|  8 | bin7  |   1 | 2021-07-22 15:55:28 |
|  9 | bin8  |   1 | 2021-07-22 15:55:28 |
| 10 | bin9  |   1 | 2021-07-22 15:55:28 |
| 11 | bin10 |   1 | 2021-07-22 15:55:30 |
+----+-------+-----+---------------------+
11 rows in set (0.00 sec)

/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime=now() where id=1'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime=now() where id=2'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime=now() where id=3'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime=now() where id=4'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime=now() where id=5'

Tasks: 138 total,   1 running, 137 sleeping,   0 stopped,   0 zombie
%Cpu0  : 59.6 us, 30.0 sy,  0.0 ni,  2.4 id,  0.0 wa,  0.0 hi,  8.1 si,  0.0 st
%Cpu1  : 57.5 us, 30.8 sy,  0.0 ni,  3.0 id,  0.0 wa,  0.0 hi,  8.7 si,  0.0 st
%Cpu2  : 59.0 us, 30.7 sy,  0.0 ni,  2.3 id,  0.3 wa,  0.0 hi,  7.7 si,  0.0 st
%Cpu3  : 56.9 us, 32.3 sy,  0.0 ni,  2.7 id,  0.0 wa,  0.0 hi,  8.1 si,  0.0 st
KiB Mem : 16266300 total, 11453432 free,  2176620 used,  2636248 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13723684 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.0g   1.4g  12316 S 313.3  9.2  10:30.41 mysqld                                                                                                                                                                                                   
22770 coding0+  20   0   98952   1792   1416 S  16.9  0.0   0:12.49 mysqlslap                                                                                                                                                                                                
22706 coding0+  20   0   98952   1792   1416 S  16.6  0.0   0:37.54 mysqlslap                                                                                                                                                                                                
22742 coding0+  20   0   98952   1792   1416 S  15.3  0.0   0:17.16 mysqlslap                                                                                                                                                                                                
22798 coding0+  20   0   98952   1792   1416 S  15.0  0.0   0:09.31 mysqlslap                                                                                                                                                                                                
22847 coding0+  20   0   98952   1792   1416 S  13.6  0.0   0:08.08 mysqlslap                                                                                                                                                                                                

	
[coding001@voice ~]$ vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 7  0      0  11731      2   2697    0    0     1     2   11    7  0  1 99  0  0
 5  0      0  11731      2   2697    0    0     0    48 5393 55153 59 38  3  0  0
 5  0      0  11731      2   2697    0    0     0    44 5379 54866 58 40  3  0  0
 5  0      0  11731      2   2697    0    0     0    40 5391 54065 59 39  3  0  0
 5  0      0  11731      2   2697    0    0     0   124 5504 55458 57 40  2  0  0
 5  0      0  11731      2   2697    0    0     0    44 5975 54439 56 41  3  0  0
 5  0      0  11731      2   2697    0    0     0    44 5373 54864 61 37  3  0  0
 5  0      0  11729      2   2697    0    0     0    60 5406 53742 57 41  2  0  0
 6  0      0  11730      2   2697    0    0     0    40 5392 54568 57 41  2  0  0
 5  0      0  11730      2   2697    0    0     0    52 5418 55199 59 38  2  0  0
 6  0      0  11730      2   2697    0    0     0    48 5443 55667 57 41  2  0  0
 6  0      0  11730      2   2697    0    0     0   160 5555 54065 57 40  3  0  0
 5  0      0  11730      2   2697    0    0     0   144 5418 55357 56 42  3  0  0
 5  0      0  11730      2   2697    0    0     0   152 5419 54479 58 39  3  0  0
 5  0      0  11730      2   2697    0    0     0   160 5536 55129 58 39  3  0  0
 6  0      0  11730      2   2697    0    0     0    36 5408 54414 59 39  2  0  0
 5  0      0  11730      2   2697    0    0     0    44 5446 54744 57 41  2  0  0
 6  0      0  11730      2   2697    0    0     0    44 5700 53523 58 39  3  0  0
 5  0      0  11730      2   2697    0    0     0    44 5375 54541 57 40  3  0  0
 6  0      0  11730      2   2697    0    0     0    60 5479 54998 57 40  3  0  0
 5  0      0  11730      2   2697    0    0     0    48 5125 53812 59 39  2  0  0
 5  0      0  11728      2   2697    0    0     0    44 5384 54795 59 38  3  0  0
 5  0      0  11728      2   2697    0    0     0    80 5486 54984 56 41  3  0  0
 6  0      0  11728      2   2697    0    0     0    36 5468 55303 57 40  3  0  0
 5  0      0  11728      2   2697    0    0     0    60 5779 54313 56 41  3  0  0
 5  0      0  11728      2   2697    0    0     0    40 5641 54690 60 37  3  0  0
 5  0      0  11728      2   2697    0    0     0    48 5335 54967 59 39  3  0  0
 5  0      0  11728      2   2697    0    0     0   404 5419 54971 58 39  3  0  0
 5  0      0  11728      2   2697    0    0     0    40 5874 54247 57 40  3  0  0



	
------------------------------------------------------------------------------------------------------------


带入指定时间

/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime="2021-07-22 15:59:01" where id=1'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime="2021-07-22 15:59:02" where id=2'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime="2021-07-22 15:59:03" where id=3'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime="2021-07-22 15:59:04" where id=4'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set createTime="2021-07-22 15:59:05" where id=5'

[coding001@voice ~]$ vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 6  0      0  11701      2   2697    0    0     1     2   11   10  0  1 99  0  0
 5  0      0  11701      2   2697    0    0     0    72 5059 53132 60 38  2  0  0
 6  0      0  11701      2   2697    0    0     0    72 5165 52877 59 39  2  0  0
 5  0      0  11701      2   2697    0    0     0    76 5165 53237 57 41  1  0  0
 5  0      0  11701      2   2697    0    0     0    72 5110 52923 58 41  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5112 52735 60 38  2  0  0
 6  0      0  11701      2   2697    0    0     0    72 5082 51742 58 40  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5123 53023 60 39  1  0  0
 6  0      0  11701      2   2697    0    0     0    80 5113 51906 59 39  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5087 52027 60 39  1  0  0
 5  0      0  11701      2   2697    0    0     0    72 5120 53216 58 40  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5155 52570 56 43  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5163 52832 61 37  2  0  0
 5  0      0  11701      2   2697    0    0     0    84 5116 52393 59 39  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5148 52705 58 40  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5119 52812 57 41  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5060 52467 58 40  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5140 51939 58 41  2  0  0
 6  0      0  11701      2   2697    0    0     0   240 5043 52636 59 40  1  0  0
 5  0      0  11701      2   2697    0    0     0    72 5110 52703 60 38  2  0  0
 6  0      0  11701      2   2697    0    0     0    72 5146 52811 60 38  2  0  0
 6  0      0  11701      2   2697    0    0     0    72 5104 51959 61 38  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5233 53501 58 40  1  0  0
 6  0      0  11701      2   2697    0    0     0   104 5126 52089 60 39  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5165 52738 61 37  2  0  0
 5  0      0  11701      2   2697    0    0     0   136 5234 52688 58 41  2  0  0
 5  0      0  11701      2   2697    0    0     0    72 5115 53110 60 38  2  0  0
 6  0      0  11701      2   2697    0    0     0    72 4896 52757 58 41  1  0  0
 6  0      0  11701      2   2697    0    0     0    80 5156 53233 59 39  2  0  0
 8  0      0  11701      2   2697    0    0     0    72 5167 53597 59 40  2  0  0
 7  0      0  11700      2   2697    0    0     0    72 5215 52746 62 37  1  0  0


[coding001@voice ~]$ top
top - 16:03:53 up 6 days,  1:02,  8 users,  load average: 3.78, 1.63, 0.79
Tasks: 139 total,   1 running, 138 sleeping,   0 stopped,   0 zombie
%Cpu0  : 58.8 us, 32.2 sy,  0.0 ni,  1.3 id,  0.0 wa,  0.0 hi,  7.6 si,  0.0 st
%Cpu1  : 56.7 us, 31.9 sy,  0.0 ni,  2.0 id,  0.0 wa,  0.0 hi,  9.4 si,  0.0 st
%Cpu2  : 59.9 us, 30.4 sy,  0.0 ni,  1.3 id,  0.0 wa,  0.0 hi,  8.4 si,  0.0 st
%Cpu3  : 55.9 us, 33.4 sy,  0.0 ni,  2.0 id,  0.0 wa,  0.0 hi,  8.7 si,  0.0 st
KiB Mem : 16266300 total, 11425136 free,  2204404 used,  2636760 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13695720 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.0g   1.4g  12320 S 315.0  9.2  15:18.34 mysqld                                                                                                                                                                                                   
23068 coding0+  20   0   98952   1792   1416 S  17.9  0.0   0:08.14 mysqlslap                                                                                                                                                                                                
23066 coding0+  20   0   98952   1788   1416 S  17.6  0.0   0:10.12 mysqlslap                                                                                                                                                                                                
23051 coding0+  20   0   98952   1788   1416 S  15.0  0.0   0:12.01 mysqlslap                                                                                                                                                                                                
23027 coding0+  20   0   98952   1792   1416 S  14.6  0.0   0:33.73 mysqlslap                                                                                                                                                                                                
23049 coding0+  20   0   98952   1784   1416 S  13.0  0.0   0:15.38 mysqlslap                                                                                                                                                                                                
 1052 coding0+  20   0  147768  41756   1404 S   1.3  0.3 341:57.52 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39632   1320 S   1.0  0.2 342:55.31 skynet                                                                                                                                                                                                   
 1142 mongodb   20   0 1617356 116944  11588 S   0.7  0.7  48:25.51 mongod                                                                                                                                                                                                   
20759 coding0+  20   0  156800   2556   1204 S   0.3  0.0   0:00.11 sshd    









/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set age=2 where id=1'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set age=3 where id=2'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set age=4 where id=3'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set age=5 where id=4'
/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=1000000 --concurrency=1 --query='update t_20210722 set age=6 where id=5'        



[coding001@voice ~]$ vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0  11507      2   2850    0    0     0    16 12580 25448 12 11 76  0  0
 3  0      0  11507      2   2850    0    0     0   644 13526 27452 13 12 75  0  0
 2  0      0  11507      2   2850    0    0     0    24 25219 46725 27 22 51  0  0
 3  1      0  11507      2   2850    0    0     0   156 25015 46312 27 22 51  0  0
 2  0      0  11507      2   2850    0    0     0    68 24996 46353 28 22 50  0  0
 2  0      0  11507      2   2850    0    0     0    72 25166 46476 28 21 51  0  0
 2  0      0  11507      2   2850    0    0     0    72 24982 46378 29 20 51  0  0
 2  0      0  11506      2   2850    0    0     0    72 24639 45692 28 22 50  0  0
 3  0      0  11506      2   2850    0    0     0    72 25051 46358 29 21 50  0  0
 3  0      0  11506      2   2850    0    0     0    72 25068 46451 28 22 50  0  0
 2  0      0  11506      2   2850    0    0     0    76 24668 45699 28 22 50  0  0
 4  0      0  11506      2   2850    0    0     0    92 23110 46059 31 24 45  0  0
 3  0      0  11506      2   2850    0    0     0    32 15127 45902 43 32 25  0  0
 5  0      0  11506      2   2850    0    0     0   160 14912 45112 43 32 25  0  0
 3  0      0  11506      2   2850    0    0     0    72 14849 45133 43 32 25  0  0
 3  0      0  11506      2   2850    0    0     0    72 15147 45628 44 32 25  0  0
 3  0      0  11506      2   2850    0    0     0   152 15018 45547 42 33 25  0  0
 3  0      0  11506      2   2850    0    0     0    72 14950 45401 43 32 25  0  0
 3  0      0  11506      2   2850    0    0     0    72 14993 45374 44 31 24  0  0
 3  0      0  11506      2   2850    0    0     0    64 14880 45192 44 32 24  0  0
 4  0      0  11506      2   2850    0    0     0    56 15000 45738 43 32 25  0  0
 3  0      0  11506      2   2850    0    0     0    64 14945 45642 44 31 25  0  0
 5  0      0  11506      2   2850    0    0     0    84 7134 44285 54 40  6  0  0
 4  0      0  11506      2   2850    0    0     0     8 4777 44647 60 40  0  0  0
 4  0      0  11506      2   2850    0    0     0   176 4802 44816 59 41  0  0  0
 4  0      0  11506      2   2850    0    0     0    72 4936 44429 59 40  1  0  0
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 6  0      0  11504      2   2850    0    0     0    80 4828 42840 57 43  0  0  0
 4  0      0  11504      2   2850    0    0     0    80 4789 44499 58 42  0  0  0
 4  0      0  11504      2   2850    0    0     0    72 4834 41223 61 39  0  0  0
 4  0      0  11505      2   2850    0    0     0    72 4803 44042 59 41  0  0  0
 5  0      0  11505      2   2850    0    0     0    92 4851 44768 58 41  0  0  0
 5  0      0  11505      2   2850    0    0     0   348 4804 44522 59 41  0  0  0
 5  0      0  11505      2   2850    0    0     0   176 4807 44776 59 41  0  0  0
 5  0      0  11505      2   2850    0    0     0    72 4796 44656 59 40  1  0  0
 6  0      0  11505      2   2850    0    0     0    72 4811 44599 58 42  1  0  0
 5  0      0  11505      2   2850    0    0     0    80 4803 44459 59 41  1  0  0
 7  0      0  11505      2   2850    0    0     0    72 4713 44103 58 41  1  0  0
 ................................................................................
 5  0      0  11504      2   2850    0    0     0    72 4802 44464 59 41  0  0  0
 6  0      0  11504      2   2850    0    0     0    72 4784 44518 60 40  0  0  0
 5  0      0  11504      2   2850    0    0     0    72 4802 44048 58 42  0  0  0
 7  0      0  11500      2   2850    0    0     0    72 4806 44495 59 41  0  0  0
 5  0      0  11500      2   2850    0    0     0    76 4816 43933 59 41  1  0  0
 6  0      0  11500      2   2850    0    0     0    72 4805 44505 59 41  0  0  0
 5  0      0  11500      2   2850    0    0     0    72 4802 44452 58 41  1  0  0
 7  0      0  11500      2   2850    0    0     0    72 4555 44906 59 41  0  0  0
 5  0      0  11500      2   2850    0    0     0    80 4777 44262 59 41  0  0  0
 5  0      0  11499      2   2850    0    0     0    72 4748 44421 59 41  0  0  0
 5  0      0  11499      2   2850    0    0     0    72 4760 44508 59 40  1  0  0
 5  0      0  11500      2   2850    0    0     0    76 4848 44317 58 41  0  0  0
 5  0      0  11500      2   2850    0    0     0   144 4812 44743 59 41  0  0  0
 5  0      0  11500      2   2850    0    0     0    76 4817 44834 59 41  0  0  0
 5  0      0  11500      2   2850    0    0     0    72 4817 44513 58 42  0  0  0
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 7  0      0  11500      2   2850    0    0     0    72 4805 44572 59 41  0  0  0
 5  0      0  11500      2   2850    0    0     0    72 4792 44419 59 40  0  0  0
 7  0      0  11500      2   2850    0    0     0    72 4816 44702 60 40  0  0  0
 5  0      0  11500      2   2850    0    0     0    80 4783 44059 59 41  1  0  0
 5  0      0  11500      2   2850    0    0     0    72 4802 44233 59 40  0  0  0
 6  0      0  11500      2   2850    0    0     0    72 4792 44181 59 40  0  0  0
 5  0      0  11500      2   2850    0    0     0    72 4718 44466 59 41  0  0  0
 6  0      0  11499      2   2850    0    0     0    76 4640 43327 57 43  0  0  0
 5  0      0  11499      2   2850    0    0     0    72 4676 44346 58 42  1  0  0
 6  1      0  11499      2   2850    0    0     0    60 4831 44481 59 41  0  0  0
 7  0      0  11499      2   2850    0    0     0    60 4503 44626 60 40  0  0  0
 5  0      0  11499      2   2850    0    0     0    72 4749 44481 58 43  0  0  0
 5  0      0  11499      2   2850    0    0     0   384 4806 44594 59 41  1  0  0
 6  0      0  11499      2   2850    0    0     0    88 4801 45062 58 42  0  0  0
 5  0      0  11500      2   2850    0    0     0    72 4800 44858 60 40  0  0  0
 6  0      0  11500      2   2850    0    0     0    72 4637 44699 58 42  0  0  0
 
	  
	  [coding001@voice ~]$ top
top - 18:03:07 up 7 days,  3:01,  8 users,  load average: 4.07, 1.29, 0.49
Tasks: 139 total,   1 running, 138 sleeping,   0 stopped,   0 zombie
%Cpu0  : 59.3 us, 31.8 sy,  0.0 ni,  0.3 id,  0.0 wa,  0.0 hi,  8.6 si,  0.0 st
%Cpu1  : 59.5 us, 30.9 sy,  0.0 ni,  0.3 id,  0.0 wa,  0.0 hi,  9.3 si,  0.0 st
%Cpu2  : 57.8 us, 33.2 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  9.0 si,  0.0 st
%Cpu3  : 58.8 us, 31.2 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 10.0 si,  0.0 st
KiB Mem : 16266300 total, 11230460 free,  2249972 used,  2785868 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13623832 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.0g   1.5g  12320 S 310.0  9.4  24:07.37 mysqld                                                                                                                                                                                                   
20996 coding0+  20   0   98952   1788   1416 S  21.9  0.0   0:15.32 mysqlslap                                                                                                                                                                                                
21018 coding0+  20   0   98952   1792   1416 S  19.3  0.0   0:10.06 mysqlslap                                                                                                                                                                                                
20998 coding0+  20   0   98952   1788   1416 S  17.9  0.0   0:12.77 mysqlslap                                                                                                                                                                                                
20991 coding0+  20   0   98952   1792   1416 S  15.6  0.0   0:19.67 mysqlslap                                                                                                                                                                                                
20993 coding0+  20   0   98952   1792   1416 S  13.0  0.0   0:19.62 mysqlslap                                                                                                                                                                                                
 1052 coding0+  20   0  147768  41756   1404 S   1.0  0.3 404:06.03 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39632   1320 S   0.7  0.2 405:16.89 skynet                                                                                                                                                                                                   
 1142 mongodb   20   0 1617356 122492  11616 S   0.3  0.8  57:08.80 mongod                                                                                                                                                                                                   
20925 coding0+  20   0  162104   2312   1584 R   0.3  0.0   0:00.30 top                                                                                                                                                                                                      
    1 root      20   0  193664   6668   4156 S   0.0  0.0   3:03.68 systemd                                                                                                                                                                                                  
    2 root      20   0       0      0      0 S   0.0  0.0   0:00.31 kthreadd                                                                                                                                                                                                 
    4 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H                                                                                                                                                                                             
    6 root      20   0       0      0      0 S   0.0  0.0   0:02.95 ksoftirqd/0                                                                                                                                                                                              
    7 root      rt   0       0      0      0 S   0.0  0.0   0:00.31 migration/0   



cs(context switch)是每秒上下文切换的次数。


root@mysqldb 18:08:  [(none)]> select 54000-44450;
+-------------+
| 54000-44450 |
+-------------+
|        9550 |
+-------------+
1 row in set (0.00 sec)


	