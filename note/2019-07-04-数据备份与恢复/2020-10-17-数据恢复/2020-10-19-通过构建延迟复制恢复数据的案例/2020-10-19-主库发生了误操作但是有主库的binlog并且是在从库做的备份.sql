
大纲
	1. 数据库架构
	2. master的状态
	3. slave1的状态
	4. 在slave1备份
	5. 在new_slave建立复制 
	6. 各个节点的状态
	7. 小结


1. 数据库架构

	IP   			角色
	192.168.0.201	master
	192.168.0.202   slave1
	192.168.0.203   new_slave

2. master的状态

	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000006
			 Position: 136155768
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-57
	1 row in set (0.00 sec)


3. slave1的状态
	
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000001
			 Position: 154
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-57
	1 row in set (0.00 sec)

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000006
			  Read_Master_Log_Pos: 136155768
				   Relay_Log_File: localhost-relay-bin.000005
					Relay_Log_Pos: 136155981
			Relay_Master_Log_File: mysql-bin.000006
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		...................................................
			  Exec_Master_Log_Pos: 136155768
				  Relay_Log_Space: 136162031
		...................................................
			Seconds_Behind_Master: 0
		...................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
		...................................................
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:5-57
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-57
					Auto_Position: 1
		...................................................
	1 row in set (0.00 sec)



4. 在slave1备份


	/usr/local/mysql/bin/mysqldump -uroot -p123456abc --single-transaction --master-data=2 -R -E -B  -A  > 2020-10-19.dump

	Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. 
	If you dont want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events.



	master:
		mysql> INSERT INTO `test_db`.`t_20201019` (`ID`, `t1`, `t2`, `t3`) VALUES ('7', '7', '7', now());
		Query OK, 1 row affected (0.01 sec)

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000006
				 Position: 136156059
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-58
		1 row in set (0.00 sec)

	slave1:

		mysql> select * from t_20201019;
		+----+----+------+---------------------+
		| ID | t1 | t2   | t3                  |
		+----+----+------+---------------------+
		|  1 |  1 |    1 | 2020-10-02 23:45:20 |
		|  3 |  3 |    3 | 2020-10-02 23:45:20 |
		|  4 |  1 |    4 | 2020-10-02 23:45:20 |
		|  5 |  4 |    1 | 2020-10-02 23:45:20 |
		|  6 |  5 |    5 | 2020-10-02 23:45:20 |
		|  7 |  7 |    7 | 2020-10-02 23:53:56 |
		+----+----+------+---------------------+
		6 rows in set (0.00 sec)


5. 在new_slave建立复制 
		
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000002
			 Position: 414
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 20e66c62-11bb-11eb-9ee9-0800278c059b:1
	1 row in set (0.00 sec)
	
	
	mysql> show global variables like '%gtid%';
	+----------------------------------+----------------------------------------+
	| Variable_name                    | Value                                  |
	+----------------------------------+----------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                     |
	| enforce_gtid_consistency         | ON                                     |
	| gtid_executed                    | 20e66c62-11bb-11eb-9ee9-0800278c059b:1 |
	| gtid_executed_compression_period | 1000                                   |
	| gtid_mode                        | ON                                     |
	| gtid_owned                       |                                        |
	| gtid_purged                      |                                        |
	| session_track_gtids              | OFF                                    |
	+----------------------------------+----------------------------------------+
	8 rows in set (0.00 sec)

	导入备份的数据
	
		mysql> reset master;
		Query OK, 0 rows affected (0.05 sec)

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000001
				 Position: 154
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 
		1 row in set (0.00 sec)

		mysql> show global variables like '%gtid%';
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

		
		shell> mysql -uroot -p123456abc < 2020-10-19.dump 
		mysql: [Warning] Using a password on the command line interface can be insecure.


		mysql> select * from t_20201019;
		+----+----+------+---------------------+
		| ID | t1 | t2   | t3                  |
		+----+----+------+---------------------+
		|  1 |  1 |    1 | 2020-10-02 23:45:20 |
		|  3 |  3 |    3 | 2020-10-02 23:45:20 |
		|  4 |  1 |    4 | 2020-10-02 23:45:20 |
		|  5 |  4 |    1 | 2020-10-02 23:45:20 |
		|  6 |  5 |    5 | 2020-10-02 23:45:20 |
		+----+----+------+---------------------+
		5 rows in set (0.00 sec)


		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000001
				 Position: 154
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-57
		1 row in set (0.00 sec)

		mysql> show global variables like '%gtid%';
		+----------------------------------+-------------------------------------------+
		| Variable_name                    | Value                                     |
		+----------------------------------+-------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                        |
		| enforce_gtid_consistency         | ON                                        |
		| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-57 |
		| gtid_executed_compression_period | 1000                                      |
		| gtid_mode                        | ON                                        |
		| gtid_owned                       |                                           |
		| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1-57 |
		| session_track_gtids              | OFF                                       |
		+----------------------------------+-------------------------------------------+
		8 rows in set (0.00 sec)


	start slave
	
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Connecting to master
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: 
				  Read_Master_Log_Pos: 4
					   Relay_Log_File: localhost-relay-bin.000001
						Relay_Log_Pos: 4
				Relay_Master_Log_File: 
					 Slave_IO_Running: Connecting
					Slave_SQL_Running: Yes
			...................................................
				Seconds_Behind_Master: 0
		Master_SSL_Verify_Server_Cert: No
						Last_IO_Errno: 1045
						Last_IO_Error: error connecting to master 'rpl@192.168.0.201:3306' - retry-time: 60  retries: 1
			...................................................
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 201019 11:59:07
			...................................................
					Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-57
						Auto_Position: 1
			...................................................
		1 row in set (0.00 sec)

		master
			create user 'rpl'@'192.168.0.203' identified by '123456abc';
			GRANT REPLICATION SLAVE ON *.* TO 'rpl'@'192.168.0.203';
		
		slave
			
			stop slave;

			CHANGE MASTER TO MASTER_HOST='192.168.0.201',MASTER_USER='rpl',MASTER_PASSWORD='123456abc',master_auto_position=1;
				-- 会覆盖已有的。
				
			start slave;
			
			mysql> show slave status\G;
			*************************** 1. row ***************************
						   Slave_IO_State: Waiting for master to send event
							  Master_Host: 192.168.0.201
							  Master_User: rpl
							  Master_Port: 3306
							Connect_Retry: 60
						  Master_Log_File: mysql-bin.000006
					  Read_Master_Log_Pos: 136156536
						   Relay_Log_File: localhost-relay-bin.000002
							Relay_Log_Pos: 1182
					Relay_Master_Log_File: mysql-bin.000006
						 Slave_IO_Running: Yes
						Slave_SQL_Running: Yes
				...................................................
					  Exec_Master_Log_Pos: 136156536
				...................................................
						 Master_Server_Id: 330607
							  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
						 Master_Info_File: mysql.slave_master_info
								SQL_Delay: 0
					  SQL_Remaining_Delay: NULL
				  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
					   Master_Retry_Count: 86400
				................................................... 
					   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:58-60
						Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-60
							Auto_Position: 1
				................................................... 
			1 row in set (0.00 sec)


		
6. 各个节点的状态
	
	master:
	
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000006
				 Position: 136156536
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-60
		1 row in set (0.00 sec)
			
		mysql> show global variables like '%gtid%';
		+----------------------------------+-------------------------------------------+
		| Variable_name                    | Value                                     |
		+----------------------------------+-------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                        |
		| enforce_gtid_consistency         | ON                                        |
		| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-67 |
		| gtid_executed_compression_period | 1000                                      |
		| gtid_mode                        | ON                                        |
		| gtid_owned                       |                                           |
		| gtid_purged                      |                                           |
		| session_track_gtids              | OFF                                       |
		+----------------------------------+-------------------------------------------+
		8 rows in set (0.01 sec)


	slave1:
	
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000001
				 Position: 154
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
		1 row in set (0.00 sec)

		mysql> show global variables like '%gtid%';
		+----------------------------------+-------------------------------------------+
		| Variable_name                    | Value                                     |
		+----------------------------------+-------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                        |
		| enforce_gtid_consistency         | ON                                        |
		| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-67 |
		| gtid_executed_compression_period | 1000                                      |
		| gtid_mode                        | ON                                        |
		| gtid_owned                       |                                           |
		| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1-67 |
		| session_track_gtids              | OFF                                       |
		+----------------------------------+-------------------------------------------+
		8 rows in set (0.01 sec)

	
	new_slave:
	
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000001
				 Position: 902
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-60
		1 row in set (0.00 sec)

		mysql> select * from t_20201019;
		+----+----+------+---------------------+
		| ID | t1 | t2   | t3                  |
		+----+----+------+---------------------+
		|  1 |  1 |    1 | 2020-10-02 23:45:20 |
		|  3 |  3 |    3 | 2020-10-02 23:45:20 |
		|  4 |  1 |    4 | 2020-10-02 23:45:20 |
		|  5 |  4 |    1 | 2020-10-02 23:45:20 |
		|  6 |  5 |    5 | 2020-10-02 23:45:20 |
		|  7 |  7 |    7 | 2020-10-02 23:53:56 |
		+----+----+------+---------------------+
		6 rows in set (0.00 sec)

		mysql> show global variables like '%gtid%';
		+----------------------------------+-------------------------------------------+
		| Variable_name                    | Value                                     |
		+----------------------------------+-------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                        |
		| enforce_gtid_consistency         | ON                                        |
		| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-67 |
		| gtid_executed_compression_period | 1000                                      |
		| gtid_mode                        | ON                                        |
		| gtid_owned                       |                                           |
		| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1-57 |
		| session_track_gtids              | OFF                                       |
		+----------------------------------+-------------------------------------------+
		8 rows in set (0.00 sec)


7. 小结
	
	1. 在从库执行 show master status 命令，Executed_Gtid_Set的值显示的是主库的。
	2. 如果要做 binlog server， 那么在哪一台从库做备份，就做对应备份从库的 binlog server。
		-- GTID模式下不需要这样做，在从库做备份，可以根据主库来做 binlog server。
	3. GTID模式下，在从库做备份，可以用主库的binlog做数据恢复，从库可以不用开启binlog。
		-- 把主库的binlog在从库中注册。
		
		
	
	
	

