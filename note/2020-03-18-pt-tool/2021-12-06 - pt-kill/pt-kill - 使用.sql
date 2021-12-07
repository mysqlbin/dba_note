
[root@localhost ~]# /usr/bin/pt-kill --version
pt-kill 3.0.11



1. 授权
2. pt-kill 不同的场景
	2.1 杀sleep状态超过60s的会话(连接)
	2.2 杀SQL运行时间超过5s的会话(连接)
	2.3 杀某个账号的会话(连接)
	2.4 记录到数据表中




1. 授权
	create user 'pt_kill'@'%' identified by '123456Abc%';
	grant all privileges on *.* to 'pt_kill'@'%' with grant option;

	create user 'new_app_user'@'%' identified by '123456Abc%';
	grant all privileges on *.* to 'new_app_user'@'%' with grant option;

	create user 'test_user_20211207'@'%' identified by 'abc123456';
	grant all privileges on *.* to 'test_user_20211207'@'%' with grant option;

2. pt-kill 不同的场景

2.1 杀sleep状态超过60s的会话(连接)

	/usr/bin/pt-kill  --match-command 'Sleep'  --idle-time=200s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill

	
	mysql> show processlist;
	+----+------+---------------------+------+---------+------+----------+------------------+
	| Id | User | Host                | db   | Command | Time | State    | Info             |
	+----+------+---------------------+------+---------+------+----------+------------------+
	|  5 | root | localhost           | NULL | Query   |    0 | starting | show processlist |
	|  6 | root | localhost           | NULL | Sleep   |  595 |          | NULL             |
	|  7 | root | 192.168.0.220:61516 | NULL | Sleep   |  341 |          | NULL             |
	|  8 | root | 192.168.0.220:61517 | NULL | Sleep   |  338 |          | NULL             |
	|  9 | root | 192.168.0.220:61518 | NULL | Sleep   |  337 |          | NULL             |
	+----+------+---------------------+------+---------+------+----------+------------------+
	5 rows in set (0.00 sec)

	shell> /usr/bin/pt-kill  --match-command 'Sleep'  --idle-time=200s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill
	# 2021-12-07T10:39:42 KILL 6 (Sleep 604 sec) NULL
	# 2021-12-07T10:39:42 KILL 7 (Sleep 350 sec) NULL
	# 2021-12-07T10:39:42 KILL 8 (Sleep 347 sec) NULL
	# 2021-12-07T10:39:42 KILL 9 (Sleep 346 sec) NULL

	
	mysql> show processlist;
	+----+---------+---------------------+------+---------+------+----------+------------------+
	| Id | User    | Host                | db   | Command | Time | State    | Info             |
	+----+---------+---------------------+------+---------+------+----------+------------------+
	|  5 | root    | localhost           | NULL | Query   |    0 | starting | show processlist |
	| 13 | pt_kill | 192.168.0.242:49284 | NULL | Sleep   |    3 |          | NULL             |
	+----+---------+---------------------+------+---------+------+----------+------------------+
	2 rows in set (0.00 sec)


2.2 杀SQL运行时间超过5s的会话(连接)

	/usr/bin/pt-kill   --busy-time=30s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill

		/usr/bin/pt-kill   --busy-time=30s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill
		-- 没反应, 因为下面的语句是1个长时间未提交的事务, 不是1个实际执行耗时超过30s的语句.
		
		mysql> begin;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 10:49:  [test_db]> select * from t limit 1;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		+----+------+------+
		1 row in set (0.01 sec)


		mysql> select now();
		+---------------------+
		| now()               |
		+---------------------+
		| 2021-12-07 10:52:52 |
		+---------------------+
		1 row in set (0.00 sec)

		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 421577678243664
						 trx_state: RUNNING
					   trx_started: 2021-12-07 10:50:09
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 0
			   trx_mysql_thread_id: 14
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 0
				  trx_lock_structs: 0
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 0
				 trx_rows_modified: 0
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		1 row in set (0.00 sec)

	---------------------------------
	
	/usr/bin/pt-kill   --busy-time=5s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill
	
	
	mysql> show processlist;
	+----+------+---------------------+------------+---------+------+--------------+-------------------------------+
	| Id | User | Host                | db         | Command | Time | State        | Info                          |
	+----+------+---------------------+------------+---------+------+--------------+-------------------------------+
	| 14 | root | localhost           | sbtest1105 | Query   |    8 | Sending data | select count(*) from sbtest12 |
	| 15 | root | localhost           | NULL       | Query   |    0 | starting     | show processlist              |
	| 17 | root | 192.168.0.220:59644 | NULL       | Sleep   |  304 |              | NULL                          |
	| 18 | root | 192.168.0.220:59645 | sbtest1105 | Sleep   |  298 |              | NULL                          |
	| 19 | root | 192.168.0.220:59646 | sbtest1105 | Sleep   |  296 |              | NULL                          |
	| 20 | root | 192.168.0.220:59648 | sbtest1104 | Sleep   |  231 |              | NULL                          |
	| 21 | root | 192.168.0.220:59649 | sbtest1103 | Sleep   |  281 |              | NULL                          |
	| 22 | root | 192.168.0.220:59650 | sbtest1102 | Sleep   |  277 |              | NULL                          |
	| 23 | root | 192.168.0.220:59658 | sbtest1104 | Sleep   |  261 |              | NULL                          |
	| 24 | root | 192.168.0.220:59664 | sbtest1104 | Sleep   |   59 |              | NULL                          |
	+----+------+---------------------+------------+---------+------+--------------+-------------------------------+
	10 rows in set (0.00 sec)
	
	shell> /usr/bin/pt-kill   --busy-time=5s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill
	# 2021-12-07T11:11:15 KILL 14 (Query 14 sec) select count(*) from sbtest12

	mysql> select count(*) from sbtest12;
	ERROR 2013 (HY000): Lost connection to MySQL server during query


	mysql> show processlist;
	+----+---------+---------------------+------------+---------+------+----------+------------------+
	| Id | User    | Host                | db         | Command | Time | State    | Info             |
	+----+---------+---------------------+------------+---------+------+----------+------------------+
	| 15 | root    | localhost           | NULL       | Query   |    0 | starting | show processlist |
	| 17 | root    | 192.168.0.220:59644 | NULL       | Sleep   |  315 |          | NULL             |
	| 18 | root    | 192.168.0.220:59645 | sbtest1105 | Sleep   |  309 |          | NULL             |
	| 19 | root    | 192.168.0.220:59646 | sbtest1105 | Sleep   |  307 |          | NULL             |
	| 20 | root    | 192.168.0.220:59648 | sbtest1104 | Sleep   |  242 |          | NULL             |
	| 21 | root    | 192.168.0.220:59649 | sbtest1103 | Sleep   |  292 |          | NULL             |
	| 22 | root    | 192.168.0.220:59650 | sbtest1102 | Sleep   |  288 |          | NULL             |
	| 23 | root    | 192.168.0.220:59658 | sbtest1104 | Sleep   |  272 |          | NULL             |
	| 24 | root    | 192.168.0.220:59664 | sbtest1104 | Sleep   |   70 |          | NULL             |
	| 26 | pt_kill | 192.168.0.242:49350 | NULL       | Sleep   |    1 |          | NULL             |
	+----+---------+---------------------+------------+---------+------+----------+------------------+
	10 rows in set (0.00 sec)


2.3 杀某个账号的会话(连接)
	
	/usr/bin/pt-kill  -h192.168.0.242 -upt_kill -p'123456Abc%' --match-user "new_app_user" --victim  'all' --print --kill
	
	mysql> show processlist;
	+----+--------------+---------------------+------------+---------+------+----------+------------------+
	| Id | User         | Host                | db         | Command | Time | State    | Info             |
	+----+--------------+---------------------+------------+---------+------+----------+------------------+
	| 15 | root         | localhost           | NULL       | Query   |    0 | starting | show processlist |
	| 28 | root         | 192.168.0.220:59990 | sbtest1104 | Sleep   |   60 |          | NULL             |
	| 29 | new_app_user | 192.168.0.242:49374 | NULL       | Sleep   |    9 |          | NULL             |
	| 30 | new_app_user | 192.168.0.242:49376 | NULL       | Sleep   |    3 |          | NULL             |
	+----+--------------+---------------------+------------+---------+------+----------+------------------+
	4 rows in set (0.00 sec)

	shell> /usr/bin/pt-kill  -h192.168.0.242 -upt_kill -p'123456Abc%' --match-user "new_app_user" --victim  'all' --print --kill
	# 2021-12-07T11:21:24 KILL 29 (Sleep 26 sec) NULL
	# 2021-12-07T11:21:24 KILL 30 (Sleep 20 sec) NULL
	
	
	mysql> show processlist;
	+----+---------+---------------------+------------+---------+------+----------+------------------+
	| Id | User    | Host                | db         | Command | Time | State    | Info             |
	+----+---------+---------------------+------------+---------+------+----------+------------------+
	| 15 | root    | localhost           | NULL       | Query   |    0 | starting | show processlist |
	| 28 | root    | 192.168.0.220:59990 | sbtest1104 | Sleep   |   80 |          | NULL             |
	| 31 | pt_kill | 192.168.0.242:49378 | NULL       | Sleep   |    3 |          | NULL             |
	+----+---------+---------------------+------------+---------+------+----------+------------------+
	3 rows in set (0.00 sec)


2.4 记录到数据表中

	/usr/bin/pt-kill  --log-dsn D=test_db,t=pk_log --create-log-table  --busy-time=8s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill

	[root@localhost ~]# /usr/bin/pt-kill  --log-dsn D=test_db,t=pk_log --create-log-table  --busy-time=8s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill
	# 2021-12-07T11:28:38 KILL 40 (Query 8 sec) select count(*) from sbtest12

	new_app_user@mysqldb 11:27:  [sbtest1104]> select count(*) from sbtest12;
	ERROR 2013 (HY000): Lost connection to MySQL server during query

	
	new_app_user@mysqldb 11:31:  [test_Db]> show create table pk_log\G;
	*************************** 1. row ***************************
		   Table: pk_log
	Create Table: CREATE TABLE `pk_log` (
	  `kill_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `server_id` bigint(4) NOT NULL DEFAULT '0',
	  `timestamp` datetime DEFAULT NULL,
	  `reason` text,
	  `kill_error` text,
	  `Id` bigint(4) NOT NULL DEFAULT '0',
	  `User` varchar(16) NOT NULL DEFAULT '',
	  `Host` varchar(64) NOT NULL DEFAULT '',
	  `db` varchar(64) DEFAULT NULL,
	  `Command` varchar(16) NOT NULL DEFAULT '',
	  `Time` int(7) NOT NULL DEFAULT '0',
	  `State` varchar(64) DEFAULT NULL,
	  `Info` longtext,
	  `Time_ms` bigint(21) DEFAULT '0',
	  PRIMARY KEY (`kill_id`)
	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8
	1 row in set (0.00 sec)

	ERROR: 
	No query specified

	new_app_user@mysqldb 11:31:  [test_Db]> SELECT * FROM pk_log;
	+---------+-----------+---------------------+-------------------+------------+----+--------------+---------------------+------------+---------+------+--------------+-------------------------------+---------+
	| kill_id | server_id | timestamp           | reason            | kill_error | Id | User         | Host                | db         | Command | Time | State        | Info                          | Time_ms |
	+---------+-----------+---------------------+-------------------+------------+----+--------------+---------------------+------------+---------+------+--------------+-------------------------------+---------+
	|       1 |    330607 | 2021-12-07 11:28:38 | Exceeds busy time |            | 40 | new_app_user | 192.168.0.242:49400 | sbtest1104 | Query   |    8 | Sending data | select count(*) from sbtest12 |    NULL |
	+---------+-----------+---------------------+-------------------+------------+----+--------------+---------------------+------------+---------+------+--------------+-------------------------------+---------+
	1 row in set (0.00 sec)

	
	-- 可以记录到远程数据表中吗?
	答: 可以的.
	
		/usr/bin/pt-kill  --log-dsn D=mysqlslap,t=pk_log,h=192.168.0.252,u=test_user_20211207,p="abc123456" --create-log-table  --busy-time=8s  -h192.168.0.242 -upt_kill -p'123456Abc%' --victim  'all' --print --kill
	
	
	

