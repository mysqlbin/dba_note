
全表删除的记录数
	mysql> select count(*) from niuniuh5_db.table_web_loginlog_debug;
	+----------+
	| count(*) |
	+----------+
	|  5265967 |
	+----------+
	1 row in set (0.83 sec)


在主库执行 delete from niuniuh5_db.table_web_loginlog_debug;
	mysql> delete from niuniuh5_db.table_web_loginlog_debug;
	Query OK, 5265967 rows affected (1 min 22.07 sec)
	-- 耗时约82秒。
	

主库执行完成，在从库执行 show slave status\G;
	-- 差不多是每隔1秒左右执行一次 show slave status\G;
	
	mysql> show slave status\G;
	*************************** 1. row ***************************

				   Master_SSL_Key: 
			Seconds_Behind_Master: 0

			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561262
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561262,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)



	mysql> show slave status\G;

			Seconds_Behind_Master: 83      -- 延迟从83秒开始。
	Master_SSL_Verify_Server_Cert: No
					
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 1
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Reading event from the relay log
			   Master_Retry_Count: 86400

			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561262
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561262,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1

	1 row in set (0.04 sec)

	

	mysql> show slave status\G;
	*************************** 1. row ***************************

			Seconds_Behind_Master: 84

			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561263
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561262,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1

	1 row in set (0.00 sec)



	mysql> mysql> show slave status\G;
	*************************** 1. row ***************************
				 
			Seconds_Behind_Master: 87
	
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561263
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561262,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)

	
	mysql> show slave status\G;
	*************************** 1. row ***************************
				
			Seconds_Behind_Master: 88
	
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561263
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561262,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1

	1 row in set (0.00 sec)


	mysql> show slave status\G;
	*************************** 1. row ***************************

			Seconds_Behind_Master: 89

			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561263
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561262,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1
 
	1 row in set (0.00 sec)

	..............................................................................................
	
		

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Master_SSL_Key: 
			Seconds_Behind_Master: 164
			
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561263
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561262,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1
	1 row in set (0.00 sec)

	
	
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event

				   Master_SSL_Key: 
			Seconds_Behind_Master: 165
	
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561263
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561262,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)
	
	
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
				
			Seconds_Behind_Master: 0
	
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561263
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561263,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512069
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)

