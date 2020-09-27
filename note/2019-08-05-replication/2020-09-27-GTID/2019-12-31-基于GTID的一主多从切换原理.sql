

Master:
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000237
			 Position: 1222173
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-13797
	1 row in set (0.01 sec)

Slave1:
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000232
			 Position: 43494292
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-14012,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-434
	1 row in set (0.00 sec)

	
Slave2:
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000001
			 Position: 34975738
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-14013,
	76dcdf7c-2873-11ea-a58e-4201c0a8010c:1-23,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-415
	1 row in set (0.00 sec)

	ERROR: 
	No query specified

Slave1:

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
				  Master_Log_File: mysql-bin.000237
			  Read_Master_Log_Pos: 2289431
				   Relay_Log_File: db-b-relay-bin.000002
					Relay_Log_Pos: 2289604
			Relay_Master_Log_File: mysql-bin.000237
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
					 Skip_Counter: 0
			  Exec_Master_Log_Pos: 2289431
				  Relay_Log_Space: 2289810
				  Until_Condition: None

				 Master_Server_Id: 1
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-14027
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-14027,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-434
					Auto_Position: 1
	1 row in set (0.00 sec)

	
Slave2:		
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000237
			  Read_Master_Log_Pos: 2289017
				   Relay_Log_File: voice-relay-bin.000002
					Relay_Log_Pos: 1067258
			Relay_Master_Log_File: mysql-bin.000237
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
					 Skip_Counter: 0
			  Exec_Master_Log_Pos: 2289017
				  Relay_Log_Space: 1067465
			Seconds_Behind_Master: 0
				 Master_Server_Id: 1
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13798-14026
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-14026,
	76dcdf7c-2873-11ea-a58e-4201c0a8010c:1-23,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-415
					Auto_Position: 1
	1 row in set (0.00 sec)

	ERROR: 
	No query specified
