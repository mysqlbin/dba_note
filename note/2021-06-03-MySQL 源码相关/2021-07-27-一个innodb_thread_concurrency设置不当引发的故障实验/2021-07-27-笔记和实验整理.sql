


1. innodb_thread_concurrency参数初体验

	set global innodb_thread_concurrency=3;

	 
	 CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB;

	 insert into t values(1,1)
	 
	 session A                  session B                  session C                 session D         session E
	 select sleep(100) from t;  select sleep(100) from t;  select sleep(100) from t; 
																				
																					 select 1; 
																					 (Query OK)
																					 insert into t values(2,1)
																					 (Blocked)
																					 

	mysql> show processlist;
	+------+-----------------+-----------+--------+---------+--------+------------------------+---------------------------+
	| Id   | User            | Host      | db     | Command | Time   | State                  | Info                      |
	+------+-----------------+-----------+--------+---------+--------+------------------------+---------------------------+
	|    3 | event_scheduler | localhost | NULL   | Daemon  | 419531 | Waiting on empty queue | NULL                      |
	| 2747 | root            | localhost | sbtest | Query   |     44 | User sleep             | select sleep(100) from t  |
	| 2759 | root            | localhost | sbtest | Query   |     41 | User sleep             | select sleep(100) from t  |
	| 2783 | root            | localhost | sbtest | Query   |     15 | User sleep             | select sleep(100) from t  |
	| 2784 | root            | localhost | sbtest | Query   |     12 | update                 | insert into t values(2,1) |
	| 2796 | root            | localhost | sbtest | Query   |      0 | starting               | show processlist          |
	+------+-----------------+-----------+--------+---------+--------+------------------------+---------------------------+
	6 rows in set (0.00 sec)


-----------------------------------------------------------------------------------------------------------------------------


2. Threads_running可以大于innodb_thread_concurrency



	set global innodb_thread_concurrency=3;

	mysql>  show global variables like '%innodb_thread_concurrency%';
	+---------------------------+-------+
	| Variable_name             | Value |
	+---------------------------+-------+
	| innodb_thread_concurrency | 3     |
	+---------------------------+-------+
	1 row in set (0.00 sec)




	CREATE TABLE `t_20210722` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	`name` varchar(32) not NULL default '',
	`age` int(11) not NULL default 0,
	`createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
	PRIMARY KEY (`id`),
	KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;

	truncate table t_20210722;


	select count(*) from t_20210722;


	/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=1000000 --concurrency=10 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'

	mysql> show processlist;
	+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
	| Id   | User            | Host               | db     | Command | Time   | State                  | Info                                                                                                 |
	+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
	|    3 | event_scheduler | localhost          | NULL   | Daemon  | 419734 | Waiting on empty queue | NULL                                                                                                 |
	| 2747 | root            | localhost          | sbtest | Query   |      0 | starting               | show processlist                                                                                     |
	| 2759 | root            | localhost          | sbtest | Sleep   |    177 |                        | NULL                                                                                                 |
	| 2783 | root            | localhost          | sbtest | Sleep   |    218 |                        | NULL                                                                                                 |
	| 2784 | root            | localhost          | sbtest | Sleep   |    169 |                        | NULL                                                                                                 |
	| 2796 | root            | localhost          | sbtest | Sleep   |    164 |                        | NULL                                                                                                 |
	| 2806 | pt_user         | 192.168.1.12:49376 | NULL   | Sleep   |      7 |                        | NULL                                                                                                 |
	| 2807 | pt_user         | 192.168.1.12:49378 | sbtest | Query   |      0 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2808 | pt_user         | 192.168.1.12:49380 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2809 | pt_user         | 192.168.1.12:49382 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2810 | pt_user         | 192.168.1.12:49384 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2811 | pt_user         | 192.168.1.12:49386 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2812 | pt_user         | 192.168.1.12:49388 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2813 | pt_user         | 192.168.1.12:49390 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2814 | pt_user         | 192.168.1.12:49392 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2815 | pt_user         | 192.168.1.12:49394 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2816 | pt_user         | 192.168.1.12:49396 | sbtest | Query   |      0 | query end              | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
	17 rows in set (0.00 sec)


	mysql> show global status like '%thread%';
	+------------------------------------------+-------+
	| Variable_name                            | Value |
	+------------------------------------------+-------+
	| Delayed_insert_threads                   | 0     |
	| Performance_schema_thread_classes_lost   | 0     |
	| Performance_schema_thread_instances_lost | 0     |
	| Slow_launch_threads                      | 0     |
	| Threads_cached                           | 23    |
	| Threads_connected                        | 16    |
	| Threads_created                          | 550   |
	| Threads_running                          | 12    |
	+------------------------------------------+-------+
	8 rows in set (0.00 sec)



-------------------------------------------------------------------------------------------------------------------------------------------------

3. 线程不能进入InnoDB层的状态之一

	set global innodb_thread_concurrency=3;

	mysql>  show global variables like '%innodb_thread_concurrency%';
	+---------------------------+-------+
	| Variable_name             | Value |
	+---------------------------+-------+
	| innodb_thread_concurrency | 3     |
	+---------------------------+-------+
	1 row in set (0.00 sec)

	 
	 session A                  session B                  session C                 session D         session E
	 select sleep(100) from t;  select sleep(100) from t;  select sleep(100) from t; 
																				
																					 select 1; 
																					 (Query OK)
																					 /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=1000000 --concurrency=10 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'


	mysql> show processlist;
	+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
	| Id   | User            | Host               | db     | Command | Time   | State                  | Info                                                                                                 |
	+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
	|    3 | event_scheduler | localhost          | NULL   | Daemon  | 420523 | Waiting on empty queue | NULL                                                                                                 |
	| 2747 | root            | localhost          | sbtest | Query   |     71 | User sleep             | select sleep(100) from t                                                                             |
	| 2783 | root            | localhost          | sbtest | Query   |     99 | User sleep             | select sleep(100) from t                                                                             |
	| 2784 | root            | localhost          | sbtest | Query   |      0 | starting               | show processlist                                                                                     |
	| 2796 | root            | localhost          | sbtest | Query   |     64 | User sleep             | select sleep(100) from t                                                                             |
	| 2868 | pt_user         | 192.168.1.12:49566 | NULL   | Sleep   |     45 |                        | NULL                                                                                                 |
	| 2869 | pt_user         | 192.168.1.12:49570 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2870 | pt_user         | 192.168.1.12:49568 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2871 | pt_user         | 192.168.1.12:49572 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2872 | pt_user         | 192.168.1.12:49574 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2873 | pt_user         | 192.168.1.12:49576 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2874 | pt_user         | 192.168.1.12:49578 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2875 | pt_user         | 192.168.1.12:49580 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2876 | pt_user         | 192.168.1.12:49582 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2877 | pt_user         | 192.168.1.12:49584 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	| 2878 | pt_user         | 192.168.1.12:49586 | sbtest | Query   |     45 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
	+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
	16 rows in set (0.00 sec)


---------------------------------------------------------------------------------------------------------------------------------------------------------------------

4. 参数设置的性能对比
	4.1 innodb_thread_concurrency=3

		set global innodb_thread_concurrency=3;


		CREATE TABLE `t_20210727` (
		`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
		`name` varchar(32) not NULL default '',
		`age` int(11) not NULL default 0,
		`createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
		PRIMARY KEY (`id`),
		KEY `idx_createTime` (`createTime`)
		) ENGINE=InnoDB;

		CREATE TABLE `t_2021072702` (
		`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
		`name` varchar(32) not NULL default '',
		`age` int(11) not NULL default 0,
		`createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
		PRIMARY KEY (`id`),
		KEY `idx_createTime` (`createTime`)
		) ENGINE=InnoDB;

		truncate table t_20210727;


		select count(*) from t_20210727;


		/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=300000 --concurrency=6 --query='insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'


		/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=300000 --concurrency=6 --query='insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'


		mysql> show processlist;
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		| Id   | User            | Host               | db     | Command | Time   | State                  | Info                                                                                                 |
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		|    3 | event_scheduler | localhost          | NULL   | Daemon  | 422504 | Waiting on empty queue | NULL                                                                                                 |
		| 2747 | root            | localhost          | sbtest | Sleep   |   1112 |                        | NULL                                                                                                 |
		| 2784 | root            | localhost          | sbtest | Query   |      0 | starting               | show processlist                                                                                     |
		| 2796 | root            | localhost          | sbtest | Sleep   |   1189 |                        | NULL                                                                                                 |
		| 2900 | pt_user         | 192.168.1.12:49816 | NULL   | Sleep   |     16 |                        | NULL                                                                                                 |
		| 2901 | pt_user         | 192.168.1.12:49819 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2902 | pt_user         | 192.168.1.12:49818 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2903 | pt_user         | 192.168.1.12:49822 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2904 | pt_user         | 192.168.1.12:49826 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2905 | pt_user         | 192.168.1.12:49824 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2906 | pt_user         | 192.168.1.12:49828 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2907 | pt_user         | 192.168.1.12:49830 | NULL   | Sleep   |      8 |                        | NULL                                                                                                 |
		| 2908 | pt_user         | 192.168.1.12:49833 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2909 | pt_user         | 192.168.1.12:49832 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2910 | pt_user         | 192.168.1.12:49836 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2911 | pt_user         | 192.168.1.12:49838 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2912 | pt_user         | 192.168.1.12:49840 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2913 | pt_user         | 192.168.1.12:49842 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		18 rows in set (0.00 sec)

		mysql> show processlist;
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		| Id   | User            | Host               | db     | Command | Time   | State                  | Info                                                                                                 |
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		|    3 | event_scheduler | localhost          | NULL   | Daemon  | 422506 | Waiting on empty queue | NULL                                                                                                 |
		| 2747 | root            | localhost          | sbtest | Sleep   |   1114 |                        | NULL                                                                                                 |
		| 2784 | root            | localhost          | sbtest | Query   |      0 | starting               | show processlist                                                                                     |
		| 2796 | root            | localhost          | sbtest | Sleep   |   1191 |                        | NULL                                                                                                 |
		| 2900 | pt_user         | 192.168.1.12:49816 | NULL   | Sleep   |     18 |                        | NULL                                                                                                 |
		| 2901 | pt_user         | 192.168.1.12:49819 | sbtest | Query   |      0 | update                 | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2902 | pt_user         | 192.168.1.12:49818 | sbtest | Query   |      0 | update                 | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2903 | pt_user         | 192.168.1.12:49822 | sbtest | Query   |      0 | update                 | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2904 | pt_user         | 192.168.1.12:49826 | sbtest | Query   |      0 | update                 | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2905 | pt_user         | 192.168.1.12:49824 | sbtest | Query   |      0 | update                 | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2906 | pt_user         | 192.168.1.12:49828 | sbtest | Query   |      0 | update                 | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2907 | pt_user         | 192.168.1.12:49830 | NULL   | Sleep   |     10 |                        | NULL                                                                                                 |
		| 2908 | pt_user         | 192.168.1.12:49833 | sbtest | Query   |      0 | update                 | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2909 | pt_user         | 192.168.1.12:49832 | sbtest | Query   |      0 | update                 | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2910 | pt_user         | 192.168.1.12:49836 | sbtest | Query   |      0 | update                 | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2911 | pt_user         | 192.168.1.12:49838 | sbtest | Query   |      0 | update                 | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2912 | pt_user         | 192.168.1.12:49840 | sbtest | Query   |      0 | update                 | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2913 | pt_user         | 192.168.1.12:49842 | sbtest | Query   |      0 | update                 | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		18 rows in set (0.00 sec)


		mysql> show processlist;
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		| Id   | User            | Host               | db     | Command | Time   | State                  | Info                                                                                                 |
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		|    3 | event_scheduler | localhost          | NULL   | Daemon  | 422717 | Waiting on empty queue | NULL                                                                                                 |
		| 2747 | root            | localhost          | sbtest | Sleep   |   1325 |                        | NULL                                                                                                 |
		| 2784 | root            | localhost          | sbtest | Query   |      0 | starting               | show processlist                                                                                     |
		| 2796 | root            | localhost          | sbtest | Sleep   |   1402 |                        | NULL                                                                                                 |
		| 2900 | pt_user         | 192.168.1.12:49816 | NULL   | Sleep   |    229 |                        | NULL                                                                                                 |
		| 2901 | pt_user         | 192.168.1.12:49819 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2902 | pt_user         | 192.168.1.12:49818 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2903 | pt_user         | 192.168.1.12:49822 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2904 | pt_user         | 192.168.1.12:49826 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2905 | pt_user         | 192.168.1.12:49824 | sbtest | Sleep   |      0 |                        | NULL                                                                                                 |
		| 2906 | pt_user         | 192.168.1.12:49828 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2907 | pt_user         | 192.168.1.12:49830 | NULL   | Sleep   |    221 |                        | NULL                                                                                                 |
		| 2908 | pt_user         | 192.168.1.12:49833 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2909 | pt_user         | 192.168.1.12:49832 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2910 | pt_user         | 192.168.1.12:49836 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2911 | pt_user         | 192.168.1.12:49838 | sbtest | Sleep   |      0 |                        | NULL                                                                                                 |
		| 2912 | pt_user         | 192.168.1.12:49840 | sbtest | Query   |      0 | update                 | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2913 | pt_user         | 192.168.1.12:49842 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		18 rows in set (0.00 sec)


		[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=300000 --concurrency=6 --query='insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'
		mysqlslap: [Warning] Using a password on the command line interface can be insecure.
		Benchmark
			Average number of seconds to run all queries: 465.992 seconds
			Minimum number of seconds to run all queries: 465.992 seconds
			Maximum number of seconds to run all queries: 465.992 seconds
			Number of clients running queries: 6
			Average number of queries per client: 50000

		[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=300000 --concurrency=6 --query='insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'
		mysqlslap: [Warning] Using a password on the command line interface can be insecure.
		Benchmark
			Average number of seconds to run all queries: 466.344 seconds
			Minimum number of seconds to run all queries: 466.344 seconds
			Maximum number of seconds to run all queries: 466.344 seconds
			Number of clients running queries: 6
			Average number of queries per client: 50000




---------------------------------------------------------------------------

	4.2 innodb_thread_concurrency=0

		set global innodb_thread_concurrency=0;

		truncate table t_20210727;
		truncate table t_2021072702;


		/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=300000 --concurrency=6 --query='insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'


		/usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=300000 --concurrency=6 --query='insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'


		mysql> show processlist;
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		| Id   | User            | Host               | db     | Command | Time   | State                  | Info                                                                                                 |
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		|    3 | event_scheduler | localhost          | NULL   | Daemon  | 429164 | Waiting on empty queue | NULL                                                                                                 |
		| 2747 | root            | localhost          | sbtest | Sleep   |     30 |                        | NULL                                                                                                 |
		| 2784 | root            | localhost          | sbtest | Query   |      0 | starting               | show processlist                                                                                     |
		| 2796 | root            | localhost          | sbtest | Sleep   |   7849 |                        | NULL                                                                                                 |
		| 2914 | pt_user         | 192.168.1.12:50454 | NULL   | Sleep   |     24 |                        | NULL                                                                                                 |
		| 2915 | pt_user         | 192.168.1.12:50456 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2916 | pt_user         | 192.168.1.12:50458 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2917 | pt_user         | 192.168.1.12:50460 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2918 | pt_user         | 192.168.1.12:50462 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2919 | pt_user         | 192.168.1.12:50464 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2920 | pt_user         | 192.168.1.12:50466 | sbtest | Query   |      0 | query end              | insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
		| 2921 | pt_user         | 192.168.1.12:50468 | NULL   | Sleep   |     18 |                        | NULL                                                                                                 |
		| 2922 | pt_user         | 192.168.1.12:50470 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2923 | pt_user         | 192.168.1.12:50472 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2924 | pt_user         | 192.168.1.12:50474 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2925 | pt_user         | 192.168.1.12:50476 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2926 | pt_user         | 192.168.1.12:50478 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		| 2927 | pt_user         | 192.168.1.12:50480 | sbtest | Query   |      0 | query end              | insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(ran |
		+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
		18 rows in set (0.00 sec)


		[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=300000 --concurrency=6 --query='insert into t_20210727(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'
		mysqlslap: [Warning] Using a password on the command line interface can be insecure.
		Benchmark
			Average number of seconds to run all queries: 456.304 seconds
			Minimum number of seconds to run all queries: 456.304 seconds
			Maximum number of seconds to run all queries: 456.304 seconds
			Number of clients running queries: 6
			Average number of queries per client: 50000


		[coding001@voice ~]$ /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=300000 --concurrency=6 --query='insert into t_2021072702(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'
		mysqlslap: [Warning] Using a password on the command line interface can be insecure.
		Benchmark
			Average number of seconds to run all queries: 455.599 seconds
			Minimum number of seconds to run all queries: 455.599 seconds
			Maximum number of seconds to run all queries: 455.599 seconds
			Number of clients running queries: 6
			Average number of queries per client: 50000

	4.3 小结
		16个线程并发的场景下，总的速度可以提高20秒。
		

--------------------------------------------------------------------------------------------------

5. 相关参数含义和设置建议

	mysql> show global variables like '%innodb_thread_concurrency%';
	+---------------------------+-------+
	| Variable_name             | Value |
	+---------------------------+-------+
	| innodb_thread_concurrency | 0     |
	+---------------------------+-------+
	1 row in set (0.01 sec)
		
		innodb_thread_concurrency：
			参数的作用：
				控制 InnoDB 的并发线程上限，也就是同时进入InnoDB层的线程数据。
				一旦并发线程数达到这个值，InnoDB 在接收到新请求的时候，就会进入等待状态，直到有线程退出。
				


	mysql> show global variables like '%innodb_concurrency_tickets%';
	+----------------------------+-------+
	| Variable_name              | Value |
	+----------------------------+-------+
	| innodb_concurrency_tickets | 5000  |
	+----------------------------+-------+
	1 row in set (0.01 sec)
		-- 每个线程可以在InnoDB层处于数据的时间，超过这个时间就要退出来，让别人进入
		
		
	mysql> show global variables like '%innodb_thread_sleep_delay%';
	+---------------------------+-------+
	| Variable_name             | Value |
	+---------------------------+-------+
	| innodb_thread_sleep_delay | 0     |
	+---------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%innodb_adaptive_max_sleep_delay%';
	+---------------------------------+--------+
	| Variable_name                   | Value  |
	+---------------------------------+--------+
	| innodb_adaptive_max_sleep_delay | 150000 |
	+---------------------------------+--------+
	1 row in set (0.00 sec)
		-- 线程在InnoDB层外最大的等待时间，超过这个时间我就要进去



	innodb_thread_concurrency使用建议

		在官方文档上，对于 innodb_thread_concurrency 的使用，也给出了一些建议，如下：

			1. 如果一个工作负载中，并发用户线程的数量小于64，建议设置innodb_thread_concurrency=0；
				--通过日常运维的数据库可以发现，可以设置innodb_thread_concurrency=0；
				
			2. 如果工作负载一直较为严重甚至偶尔达到顶峰，建议先设置innodb_thread_concurrency=128，并通过不断的降低这个参数，96, 80, 64等等，直到发现能够提供最佳性能的线程数
				例如，假设系统通常有40到50个用户，但定期的数量增加至60，70，甚至200。你会发现，性能在80个并发用户设置时表现稳定，如果高于这个数，性能反而下降。在这种情况下，建议设置innodb_thread_concurrency参数为80，以避免影响性能。

			3. 如果你不希望InnoDB使用的虚拟CPU数量比用户线程使用的虚拟CPU更多（比如20个虚拟CPU），建议通过设置innodb_thread_concurrency参数为这个值（也可能更低，这取决于性能体现）
				如果你的目标是将MySQL与其他应用隔离，你可以考虑绑定mysqld进程到专有的虚拟CPU。但是需要注意的是，这种绑定，在myslqd进程一直不是很忙的情况下，可能会导致非最优的硬件使用率。
				在这种情况下，你可能会设置mysqld进程绑定的虚拟CPU，允许其他应用程序使用虚拟CPU的一部分或全部。

			4. 在某些情况下，最佳的innodb_thread_concurrency参数设置可以比虚拟CPU的数量小。定期检测和分析系统，负载量、用户数或者工作环境的改变可能都需要对innodb_thread_concurrency参数的设置进行调整。
	
	
	