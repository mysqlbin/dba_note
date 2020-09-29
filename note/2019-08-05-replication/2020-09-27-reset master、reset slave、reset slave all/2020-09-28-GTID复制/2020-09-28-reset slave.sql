
1. slave的状态
2. master的状态
3. reset slave
4. 修复主从关系


1. slave的状态

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.201
                  Master_User: rpl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 424
               Relay_Log_File: localhost-relay-bin.000002
                Relay_Log_Pos: 637
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
	....................................................
          Exec_Master_Log_Pos: 424
              Relay_Log_Space: 848
	....................................................
             Master_Server_Id: 330607
                  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
	....................................................
           Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1
            Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
	1 row in set (0.00 sec)


	mysql> select * from mysql.gtid_executed;
	+--------------------------------------+----------------+--------------+
	| source_uuid                          | interval_start | interval_end |
	+--------------------------------------+----------------+--------------+
	| 9e520b78-013c-11eb-a84c-0800271bf591 |              1 |            1 |
	+--------------------------------------+----------------+--------------+
	1 row in set (0.00 sec)

	mysql> show global variables  like '%gtid%';
	+----------------------------------+----------------------------------------+
	| Variable_name                    | Value                                  |
	+----------------------------------+----------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                     |
	| enforce_gtid_consistency         | ON                                     |
	| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1 |
	| gtid_executed_compression_period | 1000                                   |
	| gtid_mode                        | ON                                     |
	| gtid_owned                       |                                        |
	| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1 |
	| session_track_gtids              | OFF                                    |
	+----------------------------------+----------------------------------------+
	8 rows in set (0.00 sec)
	
	
	mysql> select * from mysql.slave_master_info\G;
	*************************** 1. row ***************************
		   Number_of_lines: 25
		   Master_log_name: mysql-bin.000002
			Master_log_pos: 154
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


	mysql> 
	mysql> select * from mysql.slave_relay_log_info\G;
	*************************** 1. row ***************************
	  Number_of_lines: 7
	   Relay_log_name: ./localhost-relay-bin.000002
		Relay_log_pos: 637
	  Master_log_name: mysql-bin.000002
	   Master_log_pos: 424
			Sql_delay: 0
	Number_of_workers: 0
				   Id: 1
		 Channel_name: 
	1 row in set (0.00 sec)



	shell> ll
	-rw-r-----. 1 mysql mysql        211 9月  28 18:13 localhost-relay-bin.000001
	-rw-r-----. 1 mysql mysql        637 9月  28 18:13 localhost-relay-bin.000002
	-rw-r-----. 1 mysql mysql         58 9月  28 18:13 localhost-relay-bin.index


2. master的状态

	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000002
			 Position: 424
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1
	1 row in set (0.00 sec)


3. reset slave

	mysql> stop slave;
	Query OK, 0 rows affected (0.02 sec)

	mysql> reset slave;
	Query OK, 0 rows affected (0.02 sec)
	
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
	....................................................
			  Exec_Master_Log_Pos: 0
				  Relay_Log_Space: 217
	....................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
	....................................................
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1
					Auto_Position: 1
	....................................................
	1 row in set (0.00 sec)


	mysql> select * from mysql.gtid_executed;
	+--------------------------------------+----------------+--------------+
	| source_uuid                          | interval_start | interval_end |
	+--------------------------------------+----------------+--------------+
	| 9e520b78-013c-11eb-a84c-0800271bf591 |              1 |            1 |
	+--------------------------------------+----------------+--------------+
	1 row in set (0.00 sec)

	mysql> 
	mysql> show global variables  like '%gtid%';
	+----------------------------------+----------------------------------------+
	| Variable_name                    | Value                                  |
	+----------------------------------+----------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                     |
	| enforce_gtid_consistency         | ON                                     |
	| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1 |
	| gtid_executed_compression_period | 1000                                   |
	| gtid_mode                        | ON                                     |
	| gtid_owned                       |                                        |
	| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1 |
	| session_track_gtids              | OFF                                    |
	+----------------------------------+----------------------------------------+
	8 rows in set (0.00 sec)

	mysql> select * from mysql.slave_master_info\G;
	Empty set (0.00 sec)


	mysql> select * from mysql.slave_relay_log_info\G;
	Empty set (0.00 sec)


		
	shell> ll

	-rw-r-----. 1 mysql mysql        217 9月  28 18:21 localhost-relay-bin.000001
	-rw-r-----. 1 mysql mysql         29 9月  28 18:21 localhost-relay-bin.index

	
		


4. 修复主从关系
	
	master
	
		INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('8', '8', '8');

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002
				 Position: 696
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-2
		1 row in set (0.00 sec)

		ERROR: 
		No query specified

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
		+----+------+------+
		8 rows in set (0.00 sec)
		
	slave
		
		mysql> start slave;
		Query OK, 0 rows affected (0.06 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000002
				  Read_Master_Log_Pos: 696
					   Relay_Log_File: localhost-relay-bin.000003
						Relay_Log_Pos: 686
				Relay_Master_Log_File: mysql-bin.000002
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
		....................................................
				  Exec_Master_Log_Pos: 696
					  Relay_Log_Space: 897
		....................................................
					 Master_Server_Id: 330607
						  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		....................................................
				   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:2
					Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-2
						Auto_Position: 1
		....................................................
		1 row in set (0.00 sec)


		
	
l
