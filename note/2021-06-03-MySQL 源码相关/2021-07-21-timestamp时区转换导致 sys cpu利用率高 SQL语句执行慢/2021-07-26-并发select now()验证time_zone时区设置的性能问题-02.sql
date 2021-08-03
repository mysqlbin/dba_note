

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


/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=10000000 --concurrency=100 --query='select now()'



[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=10000000 --concurrency=100 --query='select now()'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 401.446 seconds
	Minimum number of seconds to run all queries: 401.446 seconds
	Maximum number of seconds to run all queries: 401.446 seconds
	Number of clients running queries: 100
	Average number of queries per client: 100000




--------------------------------------------------------------------------------------------------------------------------------------------





set global time_zone="+8:00";


mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | +08:00 |
+---------------+--------+
1 row in set (0.01 sec)

/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=10000000 --concurrency=100 --query='select now()'



[coding001@voice ~]$ mysql -uroot -p -e 'select @@time_zone'
Enter password: 
+-------------+
| @@time_zone |
+-------------+
| +08:00      |
+-------------+
[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --number-of-queries=10000000 --concurrency=100 --query='select now()'
mysqlslap: [Warning] Using a password on the command line interface can be insecure.
Benchmark
	Average number of seconds to run all queries: 410.760 seconds
	Minimum number of seconds to run all queries: 410.760 seconds
	Maximum number of seconds to run all queries: 410.760 seconds
	Number of clients running queries: 100
	Average number of queries per client: 100000

没有体现出来的差距。
