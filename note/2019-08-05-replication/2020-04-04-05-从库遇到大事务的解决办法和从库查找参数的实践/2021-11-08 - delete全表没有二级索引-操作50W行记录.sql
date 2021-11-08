

环境：
	4核CPU、16GB内存、100GB的SSD盘



50W行记录
	从库查找方式   'INDEX_SCAN,TABLE_SCAN'   						'INDEX_SCAN,HASH_SCAN'  
	耗时            2000s=33分钟(1W行要40秒/5W行要200s=3.5分钟)			 158S  
					5W行延迟200s

1. slave_rows_search_algorithms = 'INDEX_SCAN,TABLE_SCAN'
		
	stop slave;
	SET GLOBAL slave_rows_search_algorithms = 'INDEX_SCAN,TABLE_SCAN';
	start slave;

	+------------------------------+-----------------------+
	| Variable_name                | Value                 |
	+------------------------------+-----------------------+
	| slave_rows_search_algorithms | TABLE_SCAN,INDEX_SCAN |
	+------------------------------+-----------------------+
	1 row in set (0.00 sec)


2. 删除数据

	mysql> delete from niuniuh5_db.table_web_loginlog_debug;
	Query OK, 500000 rows affected (1.57 sec)


3. 查看延迟

	mysql>  select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 272903079
					 trx_state: RUNNING
				   trx_started: 2021-11-08 18:10:55
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 30074
		   trx_mysql_thread_id: 82704
					 trx_query: delete from niuniuh5_db.table_web_loginlog_debug
		   trx_operation_state: NULL
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 125
		 trx_lock_memory_bytes: 24784
			   trx_rows_locked: 29949
			 trx_rows_modified: 29949
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	1 row in set (0.00 sec)



	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000297
			  Read_Master_Log_Pos: 339289230
				   Relay_Log_File: db-b-relay-bin.000183
					Relay_Log_Pos: 1297
			Relay_Master_Log_File: mysql-bin.000297
				 Slave_IO_Running: Yes
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
			  Exec_Master_Log_Pos: 319156623
				  Relay_Log_Space: 20134824
				  Until_Condition: None
				   Until_Log_File: 
					Until_Log_Pos: 0
			   Master_SSL_Allowed: No
			   Master_SSL_CA_File: 
			   Master_SSL_CA_Path: 
				  Master_SSL_Cert: 
				Master_SSL_Cipher: 
				   Master_SSL_Key: 
			Seconds_Behind_Master: 112
	Master_SSL_Verify_Server_Cert: No
					Last_IO_Errno: 0
					Last_IO_Error: 
				   Last_SQL_Errno: 0
				   Last_SQL_Error: 
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 1
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Reading event from the relay log
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561924
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561922,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512361
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)





4. 修复

	mysql> stop slave;
	Query OK, 0 rows affected (5.70 sec)



	mysql> drop table niuniuh5_db.table_web_loginlog_debug;
	Query OK, 0 rows affected (0.75 sec)
	


	mysql> show create table niuniuh5_db.table_web_loginlog_debug\G;
	*************************** 1. row ***************************
		   Table: table_web_loginlog_debug
	Create Table: CREATE TABLE niuniuh5_db.`table_web_loginlog_debug` (
	  `nPlayerId` int(11) NOT NULL,
	  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
	  `szNickName` varchar(64) DEFAULT NULL,
	  `nAction` int(11) NOT NULL DEFAULT '0',
	  `szTime` timestamp NULL DEFAULT NULL,
	  `loginIp` varchar(64) DEFAULT NULL,
	  `strRe1` varchar(128) DEFAULT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)


	
	stop slave;
	set gtid_next=' 7664fad8-49fd-11e8-a546-4201c0a8010a:4561923';
	begin;commit;
	set gtid_next='automatic';
	start slave;
	
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000297
			  Read_Master_Log_Pos: 339295551
				   Relay_Log_File: db-b-relay-bin.000184
					Relay_Log_Pos: 6775
			Relay_Master_Log_File: mysql-bin.000297
				 Slave_IO_Running: Yes
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
			  Exec_Master_Log_Pos: 339295551
				  Relay_Log_Space: 20140731
				  Until_Condition: None
				   Until_Log_File: 
					Until_Log_Pos: 0
			   Master_SSL_Allowed: No
			   Master_SSL_CA_File: 
			   Master_SSL_CA_Path: 
				  Master_SSL_Cert: 
				Master_SSL_Cipher: 
				   Master_SSL_Key: 
			Seconds_Behind_Master: 0
	Master_SSL_Verify_Server_Cert: No
					Last_IO_Errno: 0
					Last_IO_Error: 
				   Last_SQL_Errno: 0
				   Last_SQL_Error: 
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 1
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561948
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561948,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512376
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)



