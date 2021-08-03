
CREATE TABLE `t_20210722` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
`name` varchar(32) not NULL default '',
`age` int(11) not NULL default 0,
`createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
PRIMARY KEY (`id`),
KEY `idx_createTime` (`createTime`)
) ENGINE=InnoDB;

insert into t_20210722(name, age, createTime) values('bin0', 1, "2021-07-17 15:14:08");
insert into t_20210722(name, age, createTime) values('bin1', 1, "2021-07-17 15:14:09");
insert into t_20210722(name, age, createTime) values('bin2', 1, "2021-07-17 15:14:10");
insert into t_20210722(name, age, createTime) values('bin3', 1, "2021-07-17 15:14:11");
insert into t_20210722(name, age, createTime) values('bin4', 1, "2021-07-17 15:14:12");
insert into t_20210722(name, age, createTime) values('bin5', 1, "2021-07-17 15:14:13");
insert into t_20210722(name, age, createTime) values('bin6', 1, "2021-07-17 15:14:14");
insert into t_20210722(name, age, createTime) values('bin7', 1, "2021-07-17 15:14:15");
insert into t_20210722(name, age, createTime) values('bin8', 1, "2021-07-17 15:14:16");
insert into t_20210722(name, age, createTime) values('bin9', 1, "2021-07-17 15:14:17");
insert into t_20210722(name, age, createTime) values('bin10', 1, "2021-07-17 15:14:19");
insert into t_20210722(name, age, createTime) values('bin11', 1, "2021-07-17 15:14:18");
	
	
mysql> select * from t_20210722;
+----+-------+-----+---------------------+
| id | name  | age | createTime          |
+----+-------+-----+---------------------+
|  1 | bin0  |   1 | 2021-07-17 15:14:08 |
|  2 | bin1  |   1 | 2021-07-17 15:14:09 |
|  3 | bin2  |   1 | 2021-07-17 15:14:10 |
|  4 | bin3  |   1 | 2021-07-17 15:14:11 |
|  5 | bin4  |   1 | 2021-07-17 15:14:12 |
|  6 | bin5  |   1 | 2021-07-17 15:14:13 |
|  7 | bin6  |   1 | 2021-07-17 15:14:14 |
|  8 | bin7  |   1 | 2021-07-17 15:14:15 |
|  9 | bin8  |   1 | 2021-07-17 15:14:16 |
| 10 | bin9  |   1 | 2021-07-17 15:14:17 |
| 11 | bin10 |   1 | 2021-07-17 15:14:19 |
| 12 | bin11 |   1 | 2021-07-17 15:14:18 |
+----+-------+-----+---------------------+
12 rows in set (0.00 sec)



mysql> desc select age,name,createTime from  t_20210722 where createTime='2021-07-17 15:14:08';
+----+-------------+------------+------------+------+----------------+----------------+---------+-------+------+----------+-------+
| id | select_type | table      | partitions | type | possible_keys  | key            | key_len | ref   | rows | filtered | Extra |
+----+-------------+------------+------------+------+----------------+----------------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | t_20210722 | NULL       | ref  | idx_createTime | idx_createTime | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+------------+------------+------+----------------+----------------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)


mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | SYSTEM |
+---------------+--------+
1 row in set (0.01 sec)

/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=3000000 --concurrency=20 --query='select age,name,createTime from t_20210722 where createTime="2021-07-17 15:14:08"';

/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=3000000 --concurrency=20 --query='select age,name,createTime from t_20210722 where id=12';

[coding001@voice ~]$ top
top - 16:27:33 up 10 days,  1:25,  6 users,  load average: 30.97, 17.84, 7.98
Tasks: 129 total,   1 running, 128 sleeping,   0 stopped,   0 zombie
%Cpu0  : 29.4 us, 53.8 sy,  0.0 ni,  3.0 id,  0.0 wa,  0.0 hi, 13.7 si,  0.0 st
%Cpu1  : 31.7 us, 52.7 sy,  0.0 ni,  3.3 id,  0.0 wa,  0.0 hi, 12.3 si,  0.0 st
%Cpu2  : 31.2 us, 52.5 sy,  0.0 ni,  3.3 id,  0.0 wa,  0.0 hi, 13.0 si,  0.0 st
%Cpu3  : 29.3 us, 53.7 sy,  0.0 ni,  3.3 id,  0.0 wa,  0.0 hi, 13.7 si,  0.0 st
KiB Mem : 16266300 total,  5490072 free,  2548416 used,  8227812 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13297092 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.4g   1.7g  12792 S 242.5 10.9 235:07.59 mysqld                                                                                                                                                                                                   
 2824 coding0+  20   0 1499860   1784   1416 S  71.4  0.0   1:28.48 mysqlslap                                                                                                                                                                                                
 2803 coding0+  20   0 1499860   1792   1416 S  70.8  0.0   1:37.09 mysqlslap                                                                                                                                                                                                
 2733 root      20   0  349220  57088  21888 S   3.0  0.4   0:06.48 perf                                                                                                                                                                                                     
 1085 coding0+  20   0  174352  39640   1320 S   1.3  0.2 591:04.90 skynet                                                                                                                                                                                                   
 1052 coding0+  20   0  147768  41760   1404 S   1.0  0.3 589:12.88 skynet                                                                                                                                                                                                   
  704 coding0+  20   0  162104   2328   1600 R   0.3  0.0   0:05.22 top                                                                                                                                                                                                      
 1142 mongodb   20   0 1617356 116868  11636 S   0.3  0.7  81:37.72 mongod                                                                                                                                                                                                   
    1 root      20   0  193664   6668   4156 S   0.0  0.0   4:23.94 systemd                   



[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=3000000 --concurrency=20 --query='select age,name,createTime from t_20210722 where createTime="2021-07-17 15:14:08"';
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 194.858 seconds
	Minimum number of seconds to run all queries: 194.858 seconds
	Maximum number of seconds to run all queries: 194.858 seconds
	Number of clients running queries: 20
	Average number of queries per client: 150000

[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=3000000 --concurrency=20 --query='select age,name,createTime from t_20210722 where id=12';
mysqlslap: [Warning] Using a password on the command line interface can be insecure.

Benchmark
	Average number of seconds to run all queries: 191.933 seconds
	Minimum number of seconds to run all queries: 191.933 seconds
	Maximum number of seconds to run all queries: 191.933 seconds
	Number of clients running queries: 20
	Average number of queries per client: 150000

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


mysql> set global time_zone="+8:00";
Query OK, 0 rows affected (0.00 sec)

mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | +08:00 |
+---------------+--------+
1 row in set (0.00 sec)


/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=3000000 --concurrency=20 --query='select age,name,createTime from t_20210722 where createTime="2021-07-17 15:14:08"';

/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=3000000 --concurrency=20 --query='select age,name,createTime from t_20210722 where id=12';


[coding001@voice ~]$ top
top - 16:32:28 up 10 days,  1:30,  6 users,  load average: 36.73, 25.60, 13.68
Tasks: 129 total,   2 running, 127 sleeping,   0 stopped,   0 zombie
%Cpu0  : 29.2 us, 60.5 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi, 10.3 si,  0.0 st
%Cpu1  : 31.1 us, 53.5 sy,  0.0 ni,  1.0 id,  0.0 wa,  0.0 hi, 14.4 si,  0.0 st
%Cpu2  : 31.8 us, 54.3 sy,  0.0 ni,  1.0 id,  0.0 wa,  0.0 hi, 12.9 si,  0.0 st
%Cpu3  : 32.3 us, 53.3 sy,  0.0 ni,  1.0 id,  0.0 wa,  0.0 hi, 13.3 si,  0.0 st
KiB Mem : 16266300 total,  5477720 free,  2560608 used,  8227972 buff/cache
KiB Swap:        0 total,        0 free,        0 used. 13284900 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
20583 mysql     20   0   11.4g   1.7g  12792 S 223.9 10.9 243:14.66 mysqld                                                                                                                                                                                                   
 3041 coding0+  20   0 1499860  12032   1416 S  71.1  0.1   1:40.32 mysqlslap                                                                                                                                                                                                
 3020 coding0+  20   0 1499860   1788   1416 S  69.8  0.0   1:43.27 mysqlslap                                                                                                                                                                                                
 2733 root      20   0  351148  58820  22416 R  27.9  0.4   2:11.79 perf                                                                                                                                                                                                     
 1052 coding0+  20   0  147768  41760   1404 S   1.0  0.3 589:18.49 skynet                                                                                                                                                                                                   
 1085 coding0+  20   0  174352  39640   1320 S   1.0  0.2 591:10.60 skynet                                                                                                                                                                                                   
 1142 mongodb   20   0 1617356 116868  11636 S   0.7  0.7  81:39.66 mongod                                                                                                                                                                                                   
 1002 root      20   0  217828  13480   4176 S   0.3  0.1   1:28.42 google_accounts      
 

[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=3000000 --concurrency=20 --query='select age,name,createTime from t_20210722 where createTime="2021-07-17 15:14:08"';
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 194.540 seconds
	Minimum number of seconds to run all queries: 194.540 seconds
	Maximum number of seconds to run all queries: 194.540 seconds
	Number of clients running queries: 20
	Average number of queries per client: 150000


[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=3000000 --concurrency=20 --query='select age,name,createTime from t_20210722 where id=12';
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 193.271 seconds
	Minimum number of seconds to run all queries: 193.271 seconds
	Maximum number of seconds to run all queries: 193.271 seconds
	Number of clients running queries: 20
	Average number of queries per client: 150000





------------------------------------------------------------------------------------------------------------------------------------------------------


/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=1000000 --concurrency=15 --query='select age,name,createTime from t_20210722 where id=11';




