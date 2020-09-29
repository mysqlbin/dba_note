
1. slave的状态
2. master 的状态
3. reset slave
4. 修改主从关系
	4.1 方式1 
	4.2 方式2
	
1. slave的状态

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000003
			  Read_Master_Log_Pos: 448
				   Relay_Log_File: localhost-relay-bin.000003
					Relay_Log_Pos: 320
			Relay_Master_Log_File: mysql-bin.000003
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
	....................................................
			  Exec_Master_Log_Pos: 448
				  Relay_Log_Space: 991
	....................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
	....................................................
	1 row in set (0.00 sec)
	
	
	mysql> select * from slave_master_info\G;
	*************************** 1. row ***************************
		   Number_of_lines: 25
		   Master_log_name: mysql-bin.000003
			Master_log_pos: 448
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
	 Enabled_auto_position: 0
			  Channel_name: 
			   Tls_version: 
	1 row in set (0.00 sec)

	
	mysql> select * from slave_relay_log_info\G;
	*************************** 1. row ***************************
	  Number_of_lines: 7
	   Relay_log_name: ./localhost-relay-bin.000003
		Relay_log_pos: 2214
	  Master_log_name: mysql-bin.000003
	   Master_log_pos: 2342
			Sql_delay: 0
	Number_of_workers: 0
				   Id: 1
		 Channel_name: 
	1 row in set (0.00 sec)


	shell> ll
	-rw-r-----. 1 mysql mysql        671 9月  28 12:30 localhost-relay-bin.000002
	-rw-r-----. 1 mysql mysql       2214 9月  28 14:27 localhost-relay-bin.000003
	-rw-r-----. 1 mysql mysql         58 9月  28 12:30 localhost-relay-bin.index
	

2. master 的状态
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000003
			 Position: 2342
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 
	1 row in set (0.00 sec)

3. reset slave
	
	shell> stop slave;
	shell> reset slave;
	
	
	
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
				Slave_SQL_Running: No
				  Replicate_Do_DB: 
			  Replicate_Ignore_DB: 
			   Replicate_Do_Table: 
		   Replicate_Ignore_Table: 
		  Replicate_Wild_Do_Table: 
	  Replicate_Wild_Ignore_Table: 
					   Last_Errno: 0
					   Last_Error: 
					 Skip_Counter: 0
			  Exec_Master_Log_Pos: 0
				  Relay_Log_Space: 177
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
					Last_IO_Errno: 0
					Last_IO_Error: 
				   Last_SQL_Errno: 0
				   Last_SQL_Error: 
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: 
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 
				Executed_Gtid_Set: 
					Auto_Position: 0
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 




	mysql> select * from slave_master_info\G;
	Empty set (0.00 sec)


	mysql> select * from slave_relay_log_info\G;
	Empty set (0.00 sec)


	shell> ll

	-rw-r-----. 1 mysql mysql        177 9月  28 16:59 localhost-relay-bin.000001
	-rw-r-----. 1 mysql mysql         29 9月  28 16:59 localhost-relay-bin.index

4. 修改主从关系

4.1 方式1 	
	master:
	
		INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('6', '6', '6');
		
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
		+----+------+------+
		6 rows in set (0.00 sec)
		

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000003
				 Position: 2614
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 
		1 row in set (0.00 sec)

		
	slave:

		mysql> start slave;
		Query OK, 0 rows affected (0.07 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000003
				  Read_Master_Log_Pos: 2614
					   Relay_Log_File: localhost-relay-bin.000005
						Relay_Log_Pos: 661
				Relay_Master_Log_File: mysql-bin.000003
					 Slave_IO_Running: Yes
					Slave_SQL_Running: No
					  Replicate_Do_DB: 
				  Replicate_Ignore_DB: 
				   Replicate_Do_Table: 
			   Replicate_Ignore_Table: 
			  Replicate_Wild_Do_Table: 
		  Replicate_Wild_Ignore_Table: 
						   Last_Errno: 1007
						   Last_Error: Error 'Can't create database 'test_db'; database exists' on query. Default database: 'test_db'. Query: 'create  database test_db DEFAULT CHARSET utf8mb4'
						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 448
					  Relay_Log_Space: 3511
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
						Last_IO_Errno: 0
						Last_IO_Error: 
					   Last_SQL_Errno: 1007
					   Last_SQL_Error: Error 'Can't create database 'test_db'; database exists' on query. Default database: 'test_db'. Query: 'create  database test_db DEFAULT CHARSET utf8mb4'
		  Replicate_Ignore_Server_Ids: 
					 Master_Server_Id: 330607
						  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: 
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 
			 Last_SQL_Error_Timestamp: 200928 17:05:18
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: 
					Executed_Gtid_Set: 
						Auto_Position: 0
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)
		


	4.2 方式2 
	
		mysql> stop slave;
		Query OK, 0 rows affected (0.00 sec)

		mysql> reset slave all;
		Query OK, 0 rows affected (0.02 sec)
			
		mysql> select * from t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		|  2 |    2 |    2 |
		|  3 |    3 |    3 |
		|  4 |    4 |    4 |
		|  5 |    5 |    5 |
		+----+------+------+
		5 rows in set (0.00 sec)
	
	
		CHANGE MASTER TO MASTER_HOST='192.168.0.201',MASTER_USER='rpl',MASTER_PASSWORD='123546abc',MASTER_LOG_FILE='mysql-bin.000003',MASTER_LOG_POS=2407;
		
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
						Relay_Log_Pos: 527
				Relay_Master_Log_File: mysql-bin.000003
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
			..................................
				  Exec_Master_Log_Pos: 2614
					  Relay_Log_Space: 738
			..................................
					 Master_Server_Id: 330607
						  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				   Master_Retry_Count: 86400
			..................................
		1 row in set (0.00 sec)


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
		+----+------+------+
		6 rows in set (0.00 sec)
		
	