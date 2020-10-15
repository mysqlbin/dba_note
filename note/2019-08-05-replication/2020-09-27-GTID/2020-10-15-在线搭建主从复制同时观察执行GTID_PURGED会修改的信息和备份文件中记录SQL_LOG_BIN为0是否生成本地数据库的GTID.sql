

1. master
2. 在线建slave
3. 小结


1. master

	mysqldump  -uroot -p123456abc --single-transaction  --master-data=2  -R -E --triggers  --all-databases > 2020-03-14.sql
	CREATE USER 'repl'@'%' IDENTIFIED BY  '123456abc';
	GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' ;

	备份文件的内容，参考笔记 《基于mysqldump的全备-2020-03-14.sql》
	
	
2. 在线建slave
	
		mysql> select version();
		+------------+
		| version()  |
		+------------+
		| 5.7.19-log |
		+------------+
		1 row in set (0.00 sec)

		mysql> show global variables like '%gtid%';
		+----------------------------------+------------------------------------------+
		| Variable_name                    | Value                                    |
		+----------------------------------+------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                       |
		| enforce_gtid_consistency         | ON                                       |
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-6 |
		| gtid_executed_compression_period | 1000                                     |
		| gtid_mode                        | ON                                       |
		| gtid_owned                       |                                          |
		| gtid_purged                      |                                          |
		| session_track_gtids              | OFF                                      |
		+----------------------------------+------------------------------------------+
		8 rows in set (0.00 sec)
		
		mysql> select * from mysql.gtid_executed;
		+--------------------------------------+----------------+--------------+
		| source_uuid                          | interval_start | interval_end |
		+--------------------------------------+----------------+--------------+
		| f7323d17-6442-11ea-8a77-080027758761 |              1 |            6 |
		+--------------------------------------+----------------+--------------+
		1 row in set (0.00 sec)
		
		
		mysql> reset master;
		Query OK, 0 rows affected (0.04 sec)

		mysql> show global variables like '%gtid%';
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

		mysql> select * from mysql.gtid_executed;
		Empty set (0.00 sec)
	
		mysql> show binary logs;
		+------------------+-----------+
		| Log_name         | File_size |
		+------------------+-----------+
		| mysql-bin.000001 |       154 |
		+------------------+-----------+
		1 row in set (0.00 sec)

		-- 导入备份文件
		shell> mysql -uroot -p123456abc < 2020-03-14.sql
		mysql: [Warning] Using a password on the command line interface can be insecure.
		
		
		mysql> show binary logs;
		+------------------+-----------+
		| Log_name         | File_size |
		+------------------+-----------+
		| mysql-bin.000001 |       154 |
		+------------------+-----------+
		1 row in set (0.00 sec)

		由于2020-03-14.sql文件中存在语句： 
			SET @@SESSION.SQL_LOG_BIN= 0;  表示这个会话接下来的数据操作，不会产生binlog，所以导入备份的数据也不会生成 GTID .
		
		mysql> select * from mysql.gtid_executed;
		+--------------------------------------+----------------+--------------+
		| source_uuid                          | interval_start | interval_end |
		+--------------------------------------+----------------+--------------+
		| f7323d17-6442-11ea-8a77-080027758761 |              1 |            2 |
		+--------------------------------------+----------------+--------------+
		1 row in set (0.00 sec)
		
		mysql> show global variables like '%gtid%';
		+----------------------------------+------------------------------------------+
		| Variable_name                    | Value                                    |
		+----------------------------------+------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                       |
		| enforce_gtid_consistency         | ON                                       |
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-2 |
		| gtid_executed_compression_period | 1000                                     |
		| gtid_mode                        | ON                                       |
		| gtid_owned                       |                                          |
		| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-2 |
		| session_track_gtids              | OFF                                      |
		+----------------------------------+------------------------------------------+
		8 rows in set (0.01 sec)
		
		
		验证了设置GTID_PURGED会设置三个地方的Gtid如下: 

			mysql.gtid_executed表
			gtid_purge变量
			gtid_executed变量
		
		-----------------------------------------------------------------------------------------
		
		mysql> show binlog events in 'mysql-bin.000001';
		+------------------+-----+----------------+-----------+-------------+---------------------------------------+
		| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
		+------------------+-----+----------------+-----------+-------------+---------------------------------------+
		| mysql-bin.000001 |   4 | Format_desc    |    293306 |         123 | Server ver: 5.7.19-log, Binlog ver: 4 |
		| mysql-bin.000001 | 123 | Previous_gtids |    293306 |         154 |                                       |
		+------------------+-----+----------------+-----------+-------------+---------------------------------------+
		2 rows in set (0.00 sec)
		
		
		change master to 
		master_host='192.168.1.27',
		master_user='repl',
		master_password='123456abc',
		master_port=3306,
		MASTER_AUTO_POSITION = 1;

		start slave;
		
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000001
				  Read_Master_Log_Pos: 946
					   Relay_Log_File: relay-bin.000002
						Relay_Log_Pos: 855
				Relay_Master_Log_File: mysql-bin.000001
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
			................................................................
					 Master_Server_Id: 273306
						  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
					 Master_Info_File: /data/mysql/mysql3306/data/master.info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			................................................................
				   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:3-4
					Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-4
						Auto_Position: 1
			................................................................
		1 row in set (0.00 sec)


		
	master：
		delete from zst.t2 where id=1;
	
	
	slave:
		mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.27
					  Master_User: repl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000001
			  Read_Master_Log_Pos: 1204
				   Relay_Log_File: relay-bin.000002
					Relay_Log_Pos: 1113
			Relay_Master_Log_File: mysql-bin.000001
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		................................................................
				 Master_Server_Id: 273306
					  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
				 Master_Info_File: /data/mysql/mysql3306/data/master.info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		................................................................
			   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:3-5
				Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-5
					Auto_Position: 1
		................................................................
	1 row in set (0.00 sec)


	mysql> select * from zst.t2;
	Empty set (0.00 sec)


3. 小结

	SET @@SESSION.SQL_LOG_BIN= 0;  表示这个会话接下来的数据操作，不会产生binlog，所以导入备份的数据也不会生成 GTID 
	验证了设置GTID_PURGED会设置三个地方的Gtid如下:
		mysql.gtid_executed表
		gtid_purge变量
		gtid_executed变量
		
		
		
		
		
		
	