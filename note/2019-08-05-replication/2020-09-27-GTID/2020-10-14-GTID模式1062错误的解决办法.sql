
0. 从库的read_only参数本来是开启，不知咋地关闭了
1. 通过删除从库的记录解决1062
2. 通过跳过一个GTID来解决


1. 通过删除从库的记录解决1062
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000239
			  Read_Master_Log_Pos: 77160655
				   Relay_Log_File: db-b-relay-bin.000008
					Relay_Log_Pos: 76924523
			Relay_Master_Log_File: mysql-bin.000239
				 Slave_IO_Running: Yes
				Slave_SQL_Running: No
			.........................................
					   Last_Errno: 1062
					   Last_Error: 
									Could not execute Write_rows event on table aiuaiuh9_db.table_aaaaaaaabbbbbbbb; 
									Duplicate entry '46' for key 'PRIMARY', Error_code: 1062; handler error HA_ERR_FOUND_DUPP_KEY; the events master log mysql-bin.000239, end_log_pos 76925054
					 Skip_Counter: 0
			  Exec_Master_Log_Pos: 76924310
				  Relay_Log_Space: 77162202
			.........................................
			Seconds_Behind_Master: NULL
			.........................................
				   Last_SQL_Errno: 1062
				   Last_SQL_Error: 
									Could not execute Write_rows event on table aiuaiuh9_db.table_aaaaaaaabbbbbbbb; 
									Duplicate entry '46' for key 'PRIMARY', Error_code: 1062; handler error HA_ERR_FOUND_DUPP_KEY; the events master log mysql-bin.000239, end_log_pos 76925054
			.........................................
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
			.........................................
		 Last_SQL_Error_Timestamp: 201014 15:28:56
			.........................................
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-1279459
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-1279139,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-523920
					Auto_Position: 1
			.........................................
	
	1 row in set (0.00 sec)

	ERROR: 
	No query specified

	把从库的记录复制出来做备份
		INSERT INTO `aiuaiuh9_db`.`table_aaaaaaaabbbbbbbb` (`ID`, .......) VALUES ('47', .......));
		INSERT INTO `aiuaiuh9_db`.`table_aaaaaaaabbbbbbbb` (`ID`, .......) VALUES ('46', .......));
	
	delete from `aiuaiuh9_db`.`table_aaaaaaaabbbbbbbb` where id=46;
	delete from `aiuaiuh9_db`.`table_aaaaaaaabbbbbbbb` where id=47;


	mysql> stop slave;
	Query OK, 0 rows affected (0.00 sec)

	mysql> delete from `aiuaiuh9_db`.`table_aaaaaaaabbbbbbbb` where id=46;
	Query OK, 1 row affected (0.00 sec)

	mysql> delete from `aiuaiuh9_db`.`table_aaaaaaaabbbbbbbb` where id=47;
	Query OK, 1 row affected (0.00 sec)

	mysql> start slave;
	Query OK, 0 rows affected (0.00 sec)


	slave:
		mysql> select count(*) from `aiuaiuh9_db`.`table_aaaaaaaabbbbbbbb`;
		+----------+
		| count(*) |
		+----------+
		|       50 |
		+----------+
		1 row in set (0.00 sec)

	master:

		mysql> select count(*) from `aiuaiuh9_db`.`table_aaaaaaaabbbbbbbb`;
		+----------+
		| count(*) |
		+----------+
		|       50 |
		+----------+
		1 row in set (0.00 sec)
		
	
2. 通过跳过一个GTID来解决

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000239
			  Read_Master_Log_Pos: 77242498
				   Relay_Log_File: db-b-relay-bin.000008
					Relay_Log_Pos: 77187094
			Relay_Master_Log_File: mysql-bin.000239
				 Slave_IO_Running: Yes
				Slave_SQL_Running: No
			.........................................
					   Last_Errno: 1062
					   Last_Error: 
									Could not execute Write_rows event on table aiuaiuh9_db.table_aaaaaaaa; 
									Duplicate entry '4' for key 'PRIMARY', Error_code: 1062; handler error HA_ERR_FOUND_DUPP_KEY; the events master log mysql-bin.000239, end_log_pos 77187311
					 Skip_Counter: 0
			  Exec_Master_Log_Pos: 77186881
				  Relay_Log_Space: 77244551
			.........................................
			Seconds_Behind_Master: NULL
	Master_SSL_Verify_Server_Cert: No
					Last_IO_Errno: 0
					Last_IO_Error: 
				   Last_SQL_Errno: 1062
				   Last_SQL_Error: 
									Could not execute Write_rows event on table aiuaiuh9_db.table_aaaaaaaa; 
									Duplicate entry '4' for key 'PRIMARY', Error_code: 1062; handler error HA_ERR_FOUND_DUPP_KEY; the events master log mysql-bin.000239, end_log_pos 77187311
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 1
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
			.........................................
		 Last_SQL_Error_Timestamp: 201014 15:52:31
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-1279569
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-1279494,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-523922
					Auto_Position: 1
			......................................... 
	1 row in set (0.00 sec)



	set gtid_next='7664fad8-49fd-11e8-a546-4201c0a8010a:1279495';
	begin;commit;
	set gtid_next='automatic';
	start slave;;



	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000239
			  Read_Master_Log_Pos: 77291887
				   Relay_Log_File: db-b-relay-bin.000009
					Relay_Log_Pos: 53089
			Relay_Master_Log_File: mysql-bin.000239
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		.........................................
			  Exec_Master_Log_Pos: 77291887
				  Relay_Log_Space: 77292606
		.........................................
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
		.........................................
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-1279631
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-1279631,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-523930
					Auto_Position: 1
		.........................................
	1 row in set (0.00 sec)


