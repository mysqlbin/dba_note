

system_time_zone：

    系统时区，在MySQL启动时会检查当前系统的时区并根据系统时区设置全局参数system_time_zone的
	
time_zone：

    用来设置每个连接会话的时区；
    默认为system时，使用全局参数system_time_zone的值。

	https://www.jianshu.com/p/e8b904e5e890   MySQL：timestamp时区转换导致CPU %sy高的问题  # 再一次用到了 pstack 
	参考笔记：《2021-03-31-update 一个字段，赋值为now()返回需要几秒，赋值为具体的时间很快》

		对于使用 timestamp 的场景，MySQL 在访问 timestamp 字段时会做时区转换，当 time_zone 设置为 system 时，
			MySQL 访问每一行的 timestamp 字段时，都会通过 libc 的时区函数，获取 Linux 设置的时区，
			在这个 libc 时区函数中会持有mutex，当大量并发SQL需要访问 timestamp 字段时，会出现 mutex 竞争。

		MySQL 访问每一行都会做这个时区转换，转换完后释放 mutex，所有等待这个 mutex 的线程全部唤醒，结果又会只有一个线程会成功持有 mutex，
			其余又会再次sleep，这样就会导致 context switch 非常高但 qps 很低，系统吞吐量急剧下降。

		解决办法：设置 time_zone="+8:00"，这样就不会访问 Linux 系统时区，直接转换，避免了mutex问题。

		

	timestap转换
		在进行新纪元时间（1970-01-01 00:00:00）以来的秒到实际时间之间转换的时候MySQL根据参数time_zone的设置有两种选择：

		time_zone：设置为SYSTEM的话，使用sys_time_zone获取的OS会话时区，同时使用OS API进行转换。对应转换函数 Time_zone_system::gmt_sec_to_TIME
		time_zone：设置为实际的时区的话，比如‘+08:00’，那么使用MySQL自己的方法进行转换。对应转换函数 Time_zone_offset::gmt_sec_to_TIME


log_timestamps：

    general log、slow log和error log的日志时间， 默认为 UTC；
    当设置为  UTC， general log、slow log和error log会落后系统时间8个小时，所以需要设置为跟 time_zone 的值 SYSTEM 一样。


	set global log_timestamps="SYSTEM";


正确配置1
	root@mysqldb 10:47:  [(none)]>  show global variables like '%time_zone%';
	+------------------+--------+
	| Variable_name    | Value  |
	+------------------+--------+
	| system_time_zone | CST    |
	| time_zone        | SYSTEM |
	+------------------+--------+
	2 rows in set (0.00 sec)

	root@mysqldb 10:47:  [(none)]> show global variables like '%log_timestamps%';
	+----------------+--------+
	| Variable_name  | Value  |
	+----------------+--------+
	| log_timestamps | SYSTEM |
	+----------------+--------+
	1 row in set (0.00 sec)

-----------------------------------------------------------------------------

正确配置2


	root@mysqldb 10:49:  [(none)]> set global time_zone='+8:00';
	Query OK, 0 rows affected (0.00 sec)



	root@mysqldb 10:51:  [(none)]> show global variables like '%time_zone%';
	+------------------+--------+
	| Variable_name    | Value  |
	+------------------+--------+
	| system_time_zone | CST    |
	| time_zone        | +08:00 |
	+------------------+--------+
	2 rows in set (0.00 sec)



	root@mysqldb 10:50:  [(none)]> show global variables like '%log_timestamps%';
	+----------------+--------+
	| Variable_name  | Value  |
	+----------------+--------+
	| log_timestamps | SYSTEM |
	+----------------+--------+
	1 row in set (0.00 sec)


	[root@localhost ~]# date
	2021年 03月 31日 星期三 10:51:55 CST

	root@mysqldb 10:51:  [(none)]> select now();
	+---------------------+
	| now()               |
	+---------------------+
	| 2021-03-31 10:51:58 |
	+---------------------+
	1 row in set (0.00 sec)


	DROP TABLE IF EXISTS `table_abc`;
	CREATE TABLE `table_abc` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `nAmount` bigint(20) NOT NULL DEFAULT '0' COMMENT '金额',
	  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_CreateTime` (`CreateTime`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';

	insert into table_abc(nAmount) values(10);

	root@mysqldb 10:54:  [test_db]> select * from table_abc;
	+----+---------+---------------------+
	| ID | nAmount | CreateTime          |
	+----+---------+---------------------+
	|  1 |      10 | 2021-03-31 10:54:41 |
	+----+---------+---------------------+
	1 row in set (0.00 sec)







