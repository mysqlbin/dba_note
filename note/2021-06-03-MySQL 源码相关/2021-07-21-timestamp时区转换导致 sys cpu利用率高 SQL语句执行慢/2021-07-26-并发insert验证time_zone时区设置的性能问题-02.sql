

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


[coding001@voice ~]$ mysql -uroot -p -e 'select @@time_zone'
Enter password: 
+-------------+
| @@time_zone |
+-------------+
| SYSTEM      |
+-------------+


/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=1000000 --concurrency=50 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'


[coding001@voice ~]$ top
top - 15:14:23 up 10 days, 12 min,  6 users,  load average: 4.23, 1.92, 2.90
Tasks: 129 total,   1 running, 128 sleeping,   0 stopped,   0 zombie
%Cpu0  : 29.1 us, 19.4 sy,  0.0 ni, 37.7 id,  7.3 wa,  0.0 hi,  6.6 si,  0.0 st
%Cpu1  : 30.5 us, 17.1 sy,  0.0 ni, 41.6 id,  6.7 wa,  0.0 hi,  4.0 si,  0.0 st
%Cpu2  : 28.4 us, 16.9 sy,  0.0 ni, 43.6 id,  7.4 wa,  0.0 hi,  3.7 si,  0.0 st
%Cpu3  : 28.4 us, 16.4 sy,  0.0 ni, 45.9 id,  6.5 wa,  0.0 hi,  2.7 si,  0.0 st
KiB Mem : 16266300 total,  8271132 free,  2408028 used,  5587140 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13437096 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.4g   1.6g  12704 S 194.0 10.4 202:23.48 mysqld                                                                                                                                                                                                   
32304 coding0+  20   0 2466776   2056   1468 S  31.9  0.0   0:49.37 mysqlslap                                                                                                                                                                                                
  202 root       0 -20       0      0      0 S   5.6  0.0   0:59.48 kworker/0:1H                                                                                                                                                                                             
 1052 coding0+  20   0  147768  41760   1404 S   3.0  0.3 586:09.98 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39640   1320 S   3.0  0.2 588:01.14 skynet                                                                                                                                                                                                   
32056 root      20   0       0      0      0 S   1.3  0.0   0:02.33 kworker/0:2                                                                                                                                                                                              
 1142 mongodb   20   0 1617356 122660  11636 S   0.7  0.8  81:11.33 mongod             


procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
10  2      0   8845      2   5366    0    0     0  8440 15414 43427 30 21 42  7  0
 5  1      0   8842      2   5370    0    0     0  8500 14900 42457 31 22 41  7  0
 7  1      0   8838      2   5375    0    0     0  8828 15328 44587 30 21 42  7  0
 2  0      0   8834      2   5379    0    0     0  8400 15120 42533 28 22 44  7  0
 2  0      0   8830      2   5383    0    0     0  8344 14776 42061 30 21 41  7  0
 4  1      0   8827      2   5386    0    0     0  7932 14520 40304 29 20 44  7  0
 0  0      0   8823      2   5390    0    0     0  8236 15070 42244 27 20 45  8  0
 3  0      0   8819      2   5394    0    0     0  8704 15620 44053 29 21 42  7  0
10  1      0   8812      2   5398    0    0     0  8816 15738 45069 30 22 41  7  0
 8  0      0   8808      2   5402    0    0     0  8940 15651 45355 31 22 40  7  0
 7  1      0   8800      2   5411    0    0     0 12404 15441 42802 29 20 43  8  0
 0  0      0   8796      2   5414    0    0     0  8112 14953 42174 27 21 44  7  0
 7  2      0   8792      2   5418    0    0     0  8380 15136 42400 28 21 44  8  0
 4  1      0   8788      2   5422    0    0     0  8232 15173 42463 29 20 43  8  0
 4  2      0   8784      2   5426    0    0     0  8328 15181 42306 30 20 43  7  0
 8  1      0   8781      2   5430    0    0     0  8372 15600 43661 30 20 43  7  0
 3  2      0   8777      2   5434    0    0     0  8416 15083 42720 28 22 43  7  0
 2  2      0   8771      2   5438    0    0     0  8412 14972 42860 28 21 44  7  0
 4  0      0   8767      2   5442    0    0     0  9112 15731 45555 30 22 41  7  0
 0  0      0   8762      2   5446    0    0     0  8880 15519 44678 30 22 42  6  0
 4  2      0   8758      2   5450    0    0     0  8868 15974 45401 31 21 41  7  0
 2  2      0   8754      2   5454    0    0     0  8952 15450 44708 30 21 42  7  0
 6  1      0   8748      2   5458    0    0     0  8740 15495 44485 30 21 43  7  0
 4  1      0   8743      2   5463    0    0     0  8892 15767 44990 30 21 42  7  0
 8  0      0   8736      2   5471    0    0     0 12320 15280 42306 27 22 43  8  0
 5  2      0   8731      2   5475    0    0     0  8544 15344 43288 29 21 43  7  0
 0  0      0   8727      2   5479    0    0     0  8760 15271 43981 31 21 41  7  0
10  0      0   8723      2   5483    0    0     0  8872 15891 44761 30 22 42  7  0
 6  2      0   8719      2   5487    0    0     0  8728 15559 44050 29 21 42  8  0
 6  2      0   8713      2   5491    0    0     0  8752 15556 44418 31 22 41  7  0
 6  1      0   8709      2   5495    0    0     0  8776 15673 44411 31 21 41  7  0
 2  0      0   8705      2   5499    0    0     0  8384 15632 43516 29 21 43  8  0
 2  0      0   8701      2   5503    0    0     0  8516 15511 43565 28 21 43  7  0
 3  2      0   8695      2   5507    0    0     0  8592 15802 44604 30 21 42  7  0
 3  0      0   8691      2   5511    0    0     0  8504 15487 43759 29 21 43  7  0
 3  2      0   8687      2   5515    0    0     0  8992 15306 44359 30 21 42  7  0
 2  1      0   8682      2   5519    0    0     0  8748 15608 44690 30 21 42  7  0
 4  0      0   8678      2   5523    0    0     0  8324 15416 43008 28 21 43  7  0
 9  1      0   8670      2   5531    0    0     0 12668 15338 43955 29 21 43  7  0
 4  2      0   8666      2   5535    0    0     0  8604 15918 44432 28 22 43  7  0
 5  2      0   8662      2   5540    0    0     0  8848 15240 44171 30 22 42  7  0
 0  0      0   8658      2   5544    0    0     0  8576 15182 43270 29 21 42  7  0
 4  2      0   8654      2   5548    0    0     0  8448 15046 43161 29 21 43  7  0
 0  0      0   8648      2   5551    0    0     0  8056 15159 41897 28 20 44  8  0
 5  2      0   8644      2   5555    0    0     0  8156 14769 41427 27 21 45  8  0
 5  2      0   8640      2   5559    0    0     0  8544 15385 43554 30 21 42  7  0
 3  0      0   8636      2   5563    0    0     0  9104 15886 45706 31 22 40  7  0
 4  1      0   8631      2   5567    0    0     0  8904 15616 44770 29 23 41  7  0
 1  0      0   8626      2   5572    0    0     0  9056 15552 44904 31 22 42  6  0
 3  0      0   8622      2   5576    0    0     0  8780 15633 44015 29 21 43  7  0
 0  0      0   8618      2   5580    0    0     0  8608 15522 43557 29 21 43  7  0
 4  2      0   8610      2   5588    0    0     0 12648 15514 43948 29 21 43  7  0
 1  0      0   8606      2   5592    0    0     0  8524 15536 43976 29 20 43  7  0



[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=1000000 --concurrency=50 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 201.085 seconds
	Minimum number of seconds to run all queries: 201.085 seconds
	Maximum number of seconds to run all queries: 201.085 seconds
	Number of clients running queries: 50
	Average number of queries per client: 20000


pstack $(pgrep -xn mysqld) > 3.sql


--------------------------------------------------------------------------------------------------------------------------------------------

truncate table t_20210722;

mysql> select count(*) from t_20210722;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.00 sec)


[coding001@voice ~]$ mysql -uroot -p -e 'select @@time_zone'
Enter password: 
+-------------+
| @@time_zone |
+-------------+
| +08:00      |
+-------------+

mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | +08:00 |
+---------------+--------+
1 row in set (0.01 sec)


/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=1000000 --concurrency=50 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'



[coding001@voice ~]$ top
top - 15:21:52 up 10 days, 20 min,  6 users,  load average: 4.56, 2.58, 2.66
Tasks: 126 total,   1 running, 125 sleeping,   0 stopped,   0 zombie
%Cpu0  : 29.7 us, 18.7 sy,  0.0 ni, 38.2 id,  7.4 wa,  0.0 hi,  6.0 si,  0.0 st
%Cpu1  : 30.3 us, 18.0 sy,  0.0 ni, 42.5 id,  5.8 wa,  0.0 hi,  3.4 si,  0.0 st
%Cpu2  : 28.1 us, 16.3 sy,  0.0 ni, 44.4 id,  7.5 wa,  0.0 hi,  3.7 si,  0.0 st
%Cpu3  : 26.9 us, 17.2 sy,  0.0 ni, 45.8 id,  6.7 wa,  0.0 hi,  3.4 si,  0.0 st
KiB Mem : 16266300 total,  7476748 free,  2433360 used,  6356192 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13410892 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.4g   1.6g  12704 S 192.0 10.5 208:42.71 mysqld                                                                                                                                                                                                   
32622 coding0+  20   0 2467164  14336   1468 S  31.9  0.1   0:49.52 mysqlslap                                                                                                                                                                                                
  202 root       0 -20       0      0      0 S   5.3  0.0   1:10.39 kworker/0:1H                                                                                                                                                                                             
 1052 coding0+  20   0  147768  41760   1404 S   3.3  0.3 586:27.90 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39640   1320 S   3.3  0.2 588:19.13 skynet                                                                                                                                                                                                   
32056 root      20   0       0      0      0 S   1.7  0.0   0:05.32 kworker/0:2                                                                                                                                                                                              
 1142 mongodb   20   0 1617356 122636  11636 S   0.3  0.8  81:13.99 mongod                                                                                                                                                                                                   
32479 coding0+  20   0  162104   2312   1584 R   0.3  0.0   0:00.67 top                                                                                                                                                                                                      
32500 root      20   0       0      0      0 S   0.3  0.0   0:00.21 kworker/2:0                                                                                                                                                                                              
32711 root      20   0       0      0      0 S   0.3  0.0   0:00.15 kworker/1:0                                                                                                                                                                                              
    1 root      20   0  193664   6668   4156 S   0.0  0.0   4:22.62 systemd                  

[coding001@voice ~]$ vmstat -S m 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 2  0      0   7817      2   6349    0    0     0     5    2   10  1  1 98  0  0
 3  1      0   7813      2   6353    0    0     0  8132 15018 40820 27 21 45  8  0
 1  0      0   7809      2   6357    0    0     0  8284 14986 41632 27 21 43  8  0
 0  0      0   7805      2   6361    0    0     0  8124 14950 41207 27 20 45  7  0
 4  2      0   7797      2   6368    0    0     0 12388 14960 41440 32 20 41  7  0
 2  2      0   7793      2   6373    0    0     0  8724 15363 43200 29 21 43  7  0
 0  0      0   7789      2   6377    0    0     0  8204 15127 41415 28 21 45  7  0
 2  0      0   7785      2   6381    0    0     0  8424 14552 41028 29 20 44  7  0
 7  1      0   7781      2   6385    0    0     0  8652 15115 42268 29 22 43  7  0
 2  2      0   7777      2   6389    0    0     0  8828 15727 43862 30 21 41  7  0
 1  0      0   7773      2   6393    0    0     0  8532 14708 41777 28 21 43  7  0
 2  1      0   7769      2   6397    0    0     0  8940 15675 44075 30 22 42  7  0
 3  0      0   7764      2   6401    0    0     0  8620 15315 42836 29 21 42  8  0
 1  2      0   7760      2   6405    0    0     0  9012 15833 44377 29 23 41  7  0
 4  2      0   7757      2   6409    0    0     0  8104 15048 41143 28 22 43  8  0
 3  2      0   7753      2   6413    0    0     0  8708 15372 42929 29 21 43  7  0
 5  0      0   7749      2   6417    0    0     0  8380 15709 42955 28 21 44  8  0
 0  0      0   7745      2   6421    0    0     0  8228 15122 41723 28 21 44  8  0
 9  2      0   7737      2   6429    0    0     0 12680 15467 42546 28 21 44  8  0
 2  0      0   7732      2   6433    0    0     0  8572 15709 43486 28 21 43  7  0
 2  0      0   7729      2   6437    0    0     0  8416 15453 42534 28 22 43  7  0
 7  2      0   7725      2   6441    0    0     0  8424 15525 42590 29 21 43  7  0
 6  2      0   7721      2   6445    0    0     0  8856 15538 43520 27 22 43  8  0
 6  2      0   7717      2   6449    0    0     0  8592 15169 42606 27 22 44  7  0
 8  2      0   7713      2   6453    0    0     0  8192 15180 41428 28 21 44  7  0
 4  2      0   7709      2   6457    0    0     0  8436 15305 42089 28 21 44  7  0
 4  2      0   7705      2   6461    0    0     0  8476 15357 42575 29 21 43  7  0
10  2      0   7701      2   6465    0    0     0  8452 15113 41986 30 20 43  7  0
 8  1      0   7697      2   6469    0    0     0  8480 15358 42479 29 22 41  7  0
 6  2      0   7693      2   6473    0    0     0  8740 15196 42937 29 22 42  7  0
 3  0      0   7681      2   6482    0    0     0 12800 14567 42497 35 20 37  7  0
 2  0      0   7677      2   6485    0    0     0  8708 14400 41695 36 21 37  6  0
 5  1      0   7673      2   6490    0    0     0  8696 14296 41800 38 21 35  6  0
 4  0      0   7668      2   6494    0    0     0  8788 15424 43301 29 22 42  7  0
 2  0      0   7664      2   6498    0    0     0  8592 15404 42972 29 22 43  7  0
 8  0      0   7660      2   6502    0    0     0  8672 15522 43570 29 21 42  7  0
 3  0      0   7656      2   6506    0    0     0  8548 15683 43351 28 22 42  7  0
 5  0      0   7652      2   6510    0    0     0  8696 15858 44012 28 22 43  7  0
 5  0      0   7648      2   6514    0    0     0  8488 15427 43089 29 21 43  7  0
 2  2      0   7645      2   6518    0    0     0  8556 15729 43334 29 21 43  7  0
 0  0      0   7641      2   6522    0    0     0  8308 15355 42205 27 22 43  7  0
 4  0      0   7637      2   6526    0    0     0  8208 15393 42046 27 21 44  8  0
 3  2      0   7633      2   6530    0    0     0  7700 14061 39040 26 21 45  8  0
 0  0      0   7625      2   6537    0    0     0 11444 13940 38054 25 20 47  8  0
 1  0      0   7622      2   6541    0    0     0  7872 14281 39528 26 20 46  7  0
 6  1      0   7618      2   6545    0    0     0  7796 14904 40762 26 21 45  8  0
 0  0      0   7614      2   6549    0    0     0  7328 13825 37839 27 22 44  8  0
 3  0      0   7611      2   6552    0    0     0  7252 14339 38303 26 20 46  7  0


	
	
[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=1000000 --concurrency=50 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 203.486 seconds
	Minimum number of seconds to run all queries: 203.486 seconds
	Maximum number of seconds to run all queries: 203.486 seconds
	Number of clients running queries: 50
	Average number of queries per client: 20000


pstack $(pgrep -xn mysqld) > 1.sql
	
	
没有体现出来的差距。


