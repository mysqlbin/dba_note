
master
	root@mysqldb 12:20:  [sbtest]> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000002
			 Position: 261687382
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-102821,
	bebc6d54-fc75-11e9-8ea8-080027e2e489:1-13,
	e136faa2-eeab-11e9-9494-080027cb3816:1-14
	1 row in set (0.28 sec)

slave
	root@mysqldb 12:15:  [sbtest]> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: 
					  Master_Host: 192.168.0.91
					  Master_User: keepalived
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000005
			  Read_Master_Log_Pos: 1220
				   Relay_Log_File: kp05-relay-bin.000003
					Relay_Log_Pos: 4
			Relay_Master_Log_File: mysql-bin.000005
				 Slave_IO_Running: No
				Slave_SQL_Running: Yes
			Seconds_Behind_Master: NULL
					Last_IO_Errno: 13114
					Last_IO_Error: Got fatal error 1236 from master when reading data from binary log: 'Cannot replicate because the master purged required binary logs. Replicate the missing transactions from elsewhere, or provision a new slave from backup. Consider increasing the master's binary log expiration period. To find the missing transactions, see the master's error log or the manual for GTID_SUBTRACT.'
				 Master_Server_Id: 330691
					  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
				 Master_Info_File: mysql.slave_master_info
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-3,
	bebc6d54-fc75-11e9-8ea8-080027e2e489:1-13,
	e136faa2-eeab-11e9-9494-080027cb3816:1-14
					Auto_Position: 1
	1 row in set (0.00 sec)


从库的事务比主库的多:
	stop slave;
	set gtid_next='48c3fa1e-06a6-11ea-a25d-0800275219f4:102822';
	begin;commit;
	set gtid_next='automatic';
	start slave;;

	root@mysqldb 12:22:  [sbtest]> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: 
					  Master_Host: 192.168.0.91
					  Master_User: keepalived
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000005
			  Read_Master_Log_Pos: 1220
				   Relay_Log_File: kp05-relay-bin.000003
					Relay_Log_Pos: 4
			Relay_Master_Log_File: mysql-bin.000005
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
			  Exec_Master_Log_Pos: 1220
				  Relay_Log_Space: 1275
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
					Last_IO_Errno: 13114
					Last_IO_Error: Got fatal error 1236 from master when reading data from binary log: 
					'Slave has more GTIDs than the master has, using the master s SERVER_UUID. This may indicate that the end of the binary log was truncated or that the last binary log file was lost, e.g., 
					after a power or disk failure when sync_binlog != 1. The master may or may not have rolled back transactions that were already replica'
					
				   Last_SQL_Errno: 0
				   Last_SQL_Error: 
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 330691
					  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 200506 12:22:41
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 
				Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-3:102821-102822,
	bebc6d54-fc75-11e9-8ea8-080027e2e489:1-13,
	e136faa2-eeab-11e9-9494-080027cb3816:1-14
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
		   Master_public_key_path: 
			Get_master_public_key: 0
				Network_Namespace: 
	1 row in set (0.00 sec)


			 
	show global variables like '%sync_binlog%';
	show global variables like '%innodb_flush_log_at_trx_commit%';

	root@mysqldb 12:22:  [sbtest]> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 10000 |
	+---------------+-------+
	1 row in set (0.01 sec)

	root@mysqldb 12:24:  [sbtest]> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)




重建:
	stop slave;
	reset slave all;
	reset master;   -- 清空 GTID信息和binlog信息.
	change master to master_host='192.168.0.91', master_port=3306, master_user='keepalived', master_password='123456abc', master_auto_position=1;
	Start slave;
	
		

	
	
