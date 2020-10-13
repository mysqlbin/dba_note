

1. master的信息
2. slave的信息
3. reset master
4. reset master之后的slave
5. 修复从库
	5.1 方式1 
	5.2 方式2
	5.3 方式3
	
	
1. master的信息

	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000002
			 Position: 968
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
	1 row in set (0.00 sec)
	
	
	
	mysql> show global variables  like '%gtid%';
	+----------------------------------+------------------------------------------+
	| Variable_name                    | Value                                    |
	+----------------------------------+------------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                       |
	| enforce_gtid_consistency         | ON                                       |
	| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-3 |
	| gtid_executed_compression_period | 1000                                     |
	| gtid_mode                        | ON                                       |
	| gtid_owned                       |                                          |
	| gtid_purged                      |                                          |
	| session_track_gtids              | OFF                                      |
	+----------------------------------+------------------------------------------+
	8 rows in set (0.00 sec)


	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000001 |       177 |
	| mysql-bin.000002 |       968 |
	+------------------+-----------+
	2 rows in set (0.00 sec)

		
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	|  6 |    6 |    6 |
	|  7 |    7 |    7 |
	|  8 |    8 |    8 |
	|  9 |    9 |    9 |
	+----+------+------+
	9 rows in set (0.00 sec)


2. slave的信息
	
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000002
			  Read_Master_Log_Pos: 968
				   Relay_Log_File: localhost-relay-bin.000002
					Relay_Log_Pos: 686
			Relay_Master_Log_File: mysql-bin.000002
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		....................................................
			  Exec_Master_Log_Pos: 968
				  Relay_Log_Space: 897
				  Until_Condition: None
				   Until_Log_File: 
					Until_Log_Pos: 0
			   Master_SSL_Allowed: No
		....................................................
			Seconds_Behind_Master: 0
	Master_SSL_Verify_Server_Cert: No
		....................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		....................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:3
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
					Auto_Position: 1

	1 row in set (0.00 sec)


3. reset master
	
	mysql> reset master;
	Query OK, 0 rows affected (0.01 sec)

	
	
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

	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000001 |       154 |
	+------------------+-----------+
	1 row in set (0.00 sec)

	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000001
			 Position: 154
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 
	1 row in set (0.00 sec)
	
4. reset master之后的slave

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: 
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000002
			  Read_Master_Log_Pos: 968
				   Relay_Log_File: localhost-relay-bin.000002
					Relay_Log_Pos: 686
			Relay_Master_Log_File: mysql-bin.000002
				 Slave_IO_Running: No
				Slave_SQL_Running: Yes
			....................................................
			  Exec_Master_Log_Pos: 968
				  Relay_Log_Space: 897
			....................................................
					Last_IO_Errno: 1236
					Last_IO_Error: Got fatal error 1236 from master when reading data from binary log: 
					'could not find next log; the first event '' at 4, the last event read from '/home/mysql/3306/logs/mysql-bin.000002' at 968, the last byte read from '/home/mysql/3306/logs/mysql-bin.000002' at 968.'
			....................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 200928 18:54:08
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:3
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
					Auto_Position: 1
			....................................................
	1 row in set (0.00 sec)



	mysql> select * from mysql.slave_relay_log_info\G;
	*************************** 1. row ***************************
	  Number_of_lines: 7
	   Relay_log_name: ./localhost-relay-bin.000002
		Relay_log_pos: 686
	  Master_log_name: mysql-bin.000002
	   Master_log_pos: 968
			Sql_delay: 0
	Number_of_workers: 0
				   Id: 1
		 Channel_name: 
	1 row in set (0.00 sec)

	mysql> show global variables  like '%gtid%';
	+----------------------------------+------------------------------------------+
	| Variable_name                    | Value                                    |
	+----------------------------------+------------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                       |
	| enforce_gtid_consistency         | ON                                       |
	| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-3 |
	| gtid_executed_compression_period | 1000                                     |
	| gtid_mode                        | ON                                       |
	| gtid_owned                       |                                          |
	| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1-3 |
	| session_track_gtids              | OFF                                      |
	+----------------------------------+------------------------------------------+
	8 rows in set (0.00 sec)

	mysql> select * from mysql.slave_master_info\G;
	*************************** 1. row ***************************
		   Number_of_lines: 25
		   Master_log_name: mysql-bin.000002
			Master_log_pos: 696
					  Host: 192.168.0.201
				 User_name: rpl
			 User_password: 123546abc
					  Port: 3306
			 Connect_retry: 60
			   Enabled_ssl: 0
					Ssl_ca: 
				Ssl_capath: 
				  Ssl_cert: 
				Ssl_cipher: 
				   Ssl_key: 
	Ssl_verify_server_cert: 0
				 Heartbeat: 30
					  Bind: 
		Ignored_server_ids: 0
					  Uuid: 9e520b78-013c-11eb-a84c-0800271bf591
			   Retry_count: 86400
				   Ssl_crl: 
			   Ssl_crlpath: 
	 Enabled_auto_position: 1
			  Channel_name: 
			   Tls_version: 
	1 row in set (0.00 sec)




5. 修复从库

	5.1 方式1 
		mysql> stop slave;
		Query OK, 0 rows affected (0.01 sec)

		mysql> start slave;
		Query OK, 0 rows affected (0.04 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: 
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000002
				  Read_Master_Log_Pos: 968
					   Relay_Log_File: localhost-relay-bin.000002
						Relay_Log_Pos: 686
				Relay_Master_Log_File: mysql-bin.000002
					 Slave_IO_Running: No
					Slave_SQL_Running: Yes
				...........................................
						Last_IO_Errno: 1236
						Last_IO_Error: Got fatal error 1236 from master when reading data from binary log: 
						'Slave has more GTIDs than the master has, using the master s SERVER_UUID. 
						This may indicate that the end of the binary log was truncated or that the last binary log file was lost, e.g., after a power or disk failure when sync_binlog != 1. 
						The master may or may not have rolled back transactions that were already replica'
					   Last_SQL_Errno: 0
					   Last_SQL_Error: 
		  Replicate_Ignore_Server_Ids: 
					 Master_Server_Id: 330607
						  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 200928 18:58:23
				...........................................
				   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:3
					Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
						Auto_Position: 1
				...........................................
		1 row in set (0.00 sec)
		
		-- 说明了从库已经执行完成的GTID比主库生成的GTID要大。
		
		
	5.2 方式2
		
		mysql> stop slave;
		Query OK, 0 rows affected (0.00 sec)

		mysql> reset slave all;
		Query OK, 0 rows affected (0.02 sec)

		mysql> start slave;
		ERROR 1200 (HY000): The server is not configured as slave; fix in config file or with CHANGE MASTER TO
		
		mysql> CHANGE MASTER TO MASTER_HOST='192.168.0.201',MASTER_USER='rpl',MASTER_PASSWORD='123546abc',master_auto_position=1;
		Query OK, 0 rows affected, 2 warnings (0.02 sec)

		mysql> start slave;
		Query OK, 0 rows affected (0.04 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: 
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: 
				  Read_Master_Log_Pos: 4
					   Relay_Log_File: localhost-relay-bin.000001
						Relay_Log_Pos: 4
				Relay_Master_Log_File: 
					 Slave_IO_Running: No
					Slave_SQL_Running: Yes
			....................................................
				  Exec_Master_Log_Pos: 0
					  Relay_Log_Space: 154
			....................................................
						Last_IO_Errno: 1236
						Last_IO_Error: 
						Got fatal error 1236 from master when reading data from binary log: 
						'Slave has more GTIDs than the master has, using the master s SERVER_UUID. 
						This may indicate that the end of the binary log was truncated or that the last binary log file was lost, e.g., after a power or disk failure when sync_binlog != 1. 
						The master may or may not have rolled back transactions that were already replica'
					   Last_SQL_Errno: 0
					   Last_SQL_Error: 
		  Replicate_Ignore_Server_Ids: 
					 Master_Server_Id: 330607
						  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				....................................................
				   Retrieved_Gtid_Set: 
					Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
						Auto_Position: 1
			....................................................
		1 row in set (0.00 sec)

			
		-- 说明了从库已经执行完成的GTID比主库生成的GTID要大。
			


	5.3 方式3
		
		mysql> show global variables  like '%gtid%';
		+----------------------------------+------------------------------------------+
		| Variable_name                    | Value                                    |
		+----------------------------------+------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                       |
		| enforce_gtid_consistency         | ON                                       |
		| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-3 |
		| gtid_executed_compression_period | 1000                                     |
		| gtid_mode                        | ON                                       |
		| gtid_owned                       |                                          |
		| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1-3 |
		| session_track_gtids              | OFF                                      |
		+----------------------------------+------------------------------------------+
		8 rows in set (0.01 sec)


		stop slave;
		reset slave all;
		reset master;   
		CHANGE MASTER TO MASTER_HOST='192.168.0.201',MASTER_USER='rpl',MASTER_PASSWORD='123546abc',master_auto_position=1;
		Start slave;
		show slave status\G;


		mysql> stop slave;
		Query OK, 0 rows affected, 1 warning (0.00 sec)

		mysql> reset slave all;
		Query OK, 0 rows affected (0.02 sec)

		mysql> reset master;   
		Query OK, 0 rows affected (0.12 sec)

		mysql> CHANGE MASTER TO MASTER_HOST='192.168.0.201',MASTER_USER='rpl',MASTER_PASSWORD='123546abc',master_auto_position=1;
		Query OK, 0 rows affected, 2 warnings (0.04 sec)

		mysql> Start slave;
		Query OK, 0 rows affected (0.05 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000001
				  Read_Master_Log_Pos: 426
					   Relay_Log_File: localhost-relay-bin.000002
						Relay_Log_Pos: 639
				Relay_Master_Log_File: mysql-bin.000001
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
		....................................................
				  Exec_Master_Log_Pos: 426
					  Relay_Log_Space: 850
		....................................................
					 Master_Server_Id: 330607
						  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		....................................................
				   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1
					Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1
						Auto_Position: 1
		....................................................
		1 row in set (0.00 sec)

		mysql> use mysql;
		Database changed
		mysql> use test_db;
		Reading table information for completion of table and column names
		You can turn off this feature to get a quicker startup with -A

		Database changed
		mysql> select * from t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		|  2 |    2 |    2 |
		|  3 |    3 |    3 |
		|  4 |    4 |    4 |
		|  5 |    5 |    5 |
		|  6 |    6 |    6 |
		|  7 |    7 |    7 |
		|  8 |    8 |    8 |
		|  9 |    9 |    9 |
		| 10 |   10 |   10 |
		+----+------+------+
		10 rows in set (0.00 sec)
	
		
		参考实验笔记：《2020-05-06-实验环境MySQL 1236的解决办法.sql》
