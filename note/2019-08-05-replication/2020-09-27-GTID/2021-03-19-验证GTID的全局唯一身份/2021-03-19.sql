

1. 主库
2. 从库
3. 命令执行
4. 小结
5. 在从库执行show master status的实验

1. 主库
	DML:
		mysql> delete from t1 where a=2;
		Query OK, 1 row affected (0.02 sec)

	
	root@mysqldb 11:20:  [(none)]> show binlog events in 'mysql-bin.000007';
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                                   |
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------+
	| mysql-bin.000007 |   4 | Format_desc    |    330691 |         124 | Server ver: 8.0.18, Binlog ver: 4                                                      |
	| mysql-bin.000007 | 124 | Previous_gtids |    330691 |         231 | 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-100176,
	e136faa2-eeab-11e9-9494-080027cb3816:14 |
	| mysql-bin.000007 | 231 | Gtid           |    330691 |         306 | SET @@SESSION.GTID_NEXT= '48c3fa1e-06a6-11ea-a25d-0800275219f4:100177'                 |
	| mysql-bin.000007 | 306 | Query          |    330691 |         386 | BEGIN                                                                                  |
	| mysql-bin.000007 | 386 | Table_map      |    330691 |         440 | table_id: 100 (test_20191101.t1)                                                       |
	| mysql-bin.000007 | 440 | Delete_rows    |    330691 |         480 | table_id: 100 flags: STMT_END_F                                                        |
	| mysql-bin.000007 | 480 | Xid            |    330691 |         507 | COMMIT /* xid=11756220 */                                                              |
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------+
	7 rows in set (0.00 sec)

  
2. 从库

	mysql>  show binlog events in 'mysql-bin.000005';
	+------------------+-----+----------------+-----------+-------------+------------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                   |
	+------------------+-----+----------------+-----------+-------------+------------------------------------------------------------------------+
	| mysql-bin.000005 |   4 | Format_desc    |    330692 |         124 | Server ver: 8.0.18, Binlog ver: 4                                      |
	| mysql-bin.000005 | 124 | Previous_gtids |    330692 |         191 | 48c3fa1e-06a6-11ea-a25d-0800275219f4:19-100176                         |
	| mysql-bin.000005 | 191 | Gtid           |    330691 |         273 | SET @@SESSION.GTID_NEXT= '48c3fa1e-06a6-11ea-a25d-0800275219f4:100177' |
	| mysql-bin.000005 | 273 | Query          |    330691 |         348 | BEGIN                                                                  |
	| mysql-bin.000005 | 348 | Table_map      |    330691 |         402 | table_id: 102 (test_20191101.t1)                                       |
	| mysql-bin.000005 | 402 | Delete_rows    |    330691 |         442 | table_id: 102 flags: STMT_END_F                                        |
	| mysql-bin.000005 | 442 | Xid            |    330691 |         469 | COMMIT /* xid=200552 */                                                |
	+------------------+-----+----------------+-----------+-------------+------------------------------------------------------------------------+
	7 rows in set (0.00 sec)

	show relaylog events in '';
	 
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.91
					  Master_User: keepalived
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000007
			  Read_Master_Log_Pos: 507
				   Relay_Log_File: kp05-relay-bin.000005
					Relay_Log_Pos: 673
			Relay_Master_Log_File: mysql-bin.000007
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
			  Exec_Master_Log_Pos: 507
				  Relay_Log_Space: 955
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
				 Master_Server_Id: 330691
					  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
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
			   Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:71-100177
				Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-100177,
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


3. 命令执行
	mysqlbinlog -vv --base64-output='decode-rows' --stop-position=673 kp05-relay-bin.000005  > relay-log.sql
	mysqlbinlog -vv --base64-output='decode-rows'  mysql-bin.000005  > slave-binary-log.sql
	mysqlbinlog -vv --base64-output='decode-rows'  mysql-bin.000007  > master-binary-log.sql
	
	
	
4. 小结

	验证了同一个事务在 master-binary-log(主库binlog)、slave-binary-log(从库binlog) 中记录的位点是不一样的，但是记录的GTID是一样的, 同时说明了GTID在整个复制中是全局唯一的。

	验证了同一个事务在 master-binary-log(主库binlog)、relay-log(从库relay log) 中记录的位点是不一样的



5. 在从库执行show master status的实验

	这个实验是基于MySQL 8.0.18 版本的.

	在从库执行 show master status 命令，Executed_Gtid_Set(已经执行的GTID集合) 的值显示的是主库的信息：

		master
			mysql> show master status\G;
			*************************** 1. row ***************************
						 File: mysql-bin.000006
					 Position: 136159580
				 Binlog_Do_DB: 
			 Binlog_Ignore_DB: 
			Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
			1 row in set (0.00 sec)

		slave1
			mysql> show master status\G;
			*************************** 1. row ***************************
						 File: mysql-bin.000001
					 Position: 154
				 Binlog_Do_DB: 
			 Binlog_Ignore_DB: 
			Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
			1 row in set (0.00 sec)

		slave2
			mysql> show master status\G;
			*************************** 1. row ***************************
						 File: mysql-bin.000001
					 Position: 3902
				 Binlog_Do_DB: 
			 Binlog_Ignore_DB: 
			Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
			1 row in set (0.00 sec)

	master
		shell> cat auto.cnf 
		[auto]
		server-uuid=9e520b78-013c-11eb-a84c-0800271bf591
		
		
		mysql> show global variables like '%server_uuid%';
		+---------------+--------------------------------------+
		| Variable_name | Value                                |
		+---------------+--------------------------------------+
		| server_uuid   | 9e520b78-013c-11eb-a84c-0800271bf591 |
		+---------------+--------------------------------------+
		1 row in set (0.00 sec)


	slave2
		-- 停止复制
		mysql> stop slave;
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002
				 Position: 194
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
		1 row in set (0.00 sec)
	
	master
		mysql> delete from t_20201019 where id=1;
		Query OK, 1 row affected (0.05 sec)

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000006
				 Position: 136159863
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-68
		1 row in set (0.00 sec)

	
	slave2
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002   -- 自己本地的
				 Position: 194                -- 自己本地的
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
		1 row in set (0.00 sec)
		
		mysql> show slave status\G;
			Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:58-67
			 Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67

		mysql> start slave io_thread;
		Query OK, 0 rows affected (0.00 sec)

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002
				 Position: 194
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
		1 row in set (0.00 sec)
		
		mysql> show slave status\G;
		   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:58-68
			Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67

	
	从库有保存主库的位点和GTID
	
	