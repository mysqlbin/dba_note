

1. 基本信息
2. reset master
3. reset master重置的信息
4. 主库执行 reset maser，slave会发生什么


1. 基本信息
	mysql>select @@server_uuid;
	+--------------------------------------+
	| @@server_uuid                        |
	+--------------------------------------+
	| f7323d17-6442-11ea-8a77-080027758761 |
	+--------------------------------------+
	1 row in set (0.00 sec)

	mysql>select * from mysql.gtid_executed;
	+--------------------------------------+----------------+--------------+
	| source_uuid                          | interval_start | interval_end |
	+--------------------------------------+----------------+--------------+
	| c27f419e-cecd-27e7-9649-0800279d4f09 |              1 |         1613 |
	| c39f419e-cecd-26e7-9649-0800279d4f09 |              1 |       922364 |
	| f7323d17-6442-11ea-8a77-080027758761 |              1 |            1 |
	+--------------------------------------+----------------+--------------+
	3 rows in set (0.00 sec)

	mysql> show global variables  like '%gtid%';
	+----------------------------------+--------------------------------------------------------------------------------------------------------------------------------------+
	| Variable_name                    | Value                                                                                                                                |
	+----------------------------------+--------------------------------------------------------------------------------------------------------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                                                                                                                   |
	| enforce_gtid_consistency         | ON                                                                                                                                   |
	| gtid_executed                    | c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
	c39f419e-cecd-26e7-9649-0800279d4f09:1-922364,
	f7323d17-6442-11ea-8a77-080027758761:1-2 |
	| gtid_executed_compression_period | 1000                                                                                                                                 |
	| gtid_mode                        | ON                                                                                                                                   |
	| gtid_owned                       |                                                                                                                                      |
	| gtid_purged                      | c27f419e-cecd-27e7-9649-0800279d4f09:1-620,
	c39f419e-cecd-26e7-9649-0800279d4f09:1-922364                                            |
	| session_track_gtids              | OFF                                                                                                                                  |
	+----------------------------------+--------------------------------------------------------------------------------------------------------------------------------------+
	8 rows in set (0.00 sec)

	mysql>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000044
			 Position: 548
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
	c39f419e-cecd-26e7-9649-0800279d4f09:1-922364,
	f7323d17-6442-11ea-8a77-080027758761:1-2
	1 row in set (0.00 sec)


2. reset master

	mysql>reset master;
	Query OK, 0 rows affected (0.01 sec)

	mysql>select * from mysql.gtid_executed;
	Empty set (0.00 sec)

	mysql> show global variables  like '%gtid%';
	+----------------------------------+-------+
	| Variable_name                    | Value |
	+----------------------------------+-------+
	| binlog_gtid_simple_recovery      | ON    |
	| enforce_gtid_consistency         | ON    |
	| gtid_executed                    |       |
	| gtid_executed_compression_period | 1000  |
	| gtid_mode                        | ON    |
	| gtid_owned                       |       |
	| gtid_purged                      |       |
	| session_track_gtids              | OFF   |
	+----------------------------------+-------+
	8 rows in set (0.00 sec)

	mysql>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000001
			 Position: 154
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 
	1 row in set (0.00 sec)



	[root@env logs]# ll
	total 8
	-rw-r----- 1 mysql mysql 154 Mar 14 12:40 mysql-bin.000001
	-rw-r----- 1 mysql mysql  44 Mar 14 12:40 mysql-bin.index

	mysql>show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000001 |       154 |
	+------------------+-----------+
	1 row in set (0.00 sec)


3. reset master重置的信息
	清除 GTID 信息：
		mysql.gtid_executed 表信息
		gtid_executed
		gtid_purged
		
	清空 binary log

	也就是说重置GTID信息、清空binary log。
	

4. 主库执行 reset maser，slave会发生什么
	slave会报错，需要重建从库。
	-- 操作要谨慎。
	
	

