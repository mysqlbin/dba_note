
1. master
2. slave
3. reset master


1. master
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000003
			 Position: 2614
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 
	1 row in set (0.00 sec)

	ERROR: 
	No query specified

	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000001 |       177 |
	| mysql-bin.000002 |       437 |
	| mysql-bin.000003 |      2614 |
	+------------------+-----------+
	3 rows in set (0.00 sec)


2. slave

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000003
			  Read_Master_Log_Pos: 2614
				   Relay_Log_File: localhost-relay-bin.000002
					Relay_Log_Pos: 320
			Relay_Master_Log_File: mysql-bin.000003
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
				
	....................................................
	
			  Exec_Master_Log_Pos: 2614
				  Relay_Log_Space: 531
				  
	....................................................
	
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		  
	....................................................
	
	1 row in set (0.00 sec)



3. reset master
	
	master
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000001
				 Position: 154
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 
		1 row in set (0.00 sec)

		mysql> show binary logs;
		+------------------+-----------+
		| Log_name         | File_size |
		+------------------+-----------+
		| mysql-bin.000001 |       154 |
		+------------------+-----------+
		1 row in set (0.00 sec)

	
	slave
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: 
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000003
				  Read_Master_Log_Pos: 2614
					   Relay_Log_File: localhost-relay-bin.000002
						Relay_Log_Pos: 320
				Relay_Master_Log_File: mysql-bin.000003
					 Slave_IO_Running: No
					Slave_SQL_Running: Yes
					  Replicate_Do_DB: 
				  Replicate_Ignore_DB: 
				   Replicate_Do_Table: 
			   Replicate_Ignore_Table: 
			  Replicate_Wild_Do_Table: 
		  Replicate_Wild_Ignore_Table: 
						   Last_Errno: 0
						   Last_Error: 
						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 2614
					  Relay_Log_Space: 531
					  Until_Condition: None
					   Until_Log_File: 
						Until_Log_Pos: 0
				   Master_SSL_Allowed: No
				   Master_SSL_CA_File: 
				   Master_SSL_CA_Path: 
					  Master_SSL_Cert: 
					Master_SSL_Cipher: 
					   Master_SSL_Key: 
				Seconds_Behind_Master: NULL
		Master_SSL_Verify_Server_Cert: No
						Last_IO_Errno: 1236
						Last_IO_Error: Got fatal error 1236 from master when reading data from binary log: 
						'could not find next log; the first event 'mysql-bin.000003' at 2614, the last event read from '/home/mysql/3306/logs/mysql-bin.000003' at 123, 
						the last byte read from '/home/mysql/3306/logs/mysql-bin.000003' at 2614.'
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
			  Last_IO_Error_Timestamp: 200928 17:45:27
			 Last_SQL_Error_Timestamp: 
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: 
					Executed_Gtid_Set: 
						Auto_Position: 0
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)
		
		-- 说明了
		
		
		
		
		
		


