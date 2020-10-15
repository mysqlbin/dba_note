
1. slave reset master
2. master 

1. slave reset master
	mysql> show global variables like '%gtid%';
	+----------------------------------+----------------------------------------------------------------------------------+
	| Variable_name                    | Value                                                                            |
	+----------------------------------+----------------------------------------------------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                                                               |
	| enforce_gtid_consistency         | ON                                                                               |
	| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-3,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1 |
	| gtid_executed_compression_period | 1000                                                                             |
	| gtid_mode                        | ON                                                                               |
	| gtid_owned                       |                                                                                  |
	| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1-3                                         |
	| session_track_gtids              | OFF                                                                              |
	+----------------------------------+----------------------------------------------------------------------------------+
	8 rows in set (0.00 sec)

	mysql> select * from mysql.gtid_executed;
	+--------------------------------------+----------------+--------------+
	| source_uuid                          | interval_start | interval_end |
	+--------------------------------------+----------------+--------------+
	| 9e520b78-013c-11eb-a84c-0800271bf591 |              1 |            1 |
	| 9e520b78-013c-11eb-a84c-0800271bf591 |              2 |            2 |
	| 9e520b78-013c-11eb-a84c-0800271bf591 |              3 |            3 |
	+--------------------------------------+----------------+--------------+
	3 rows in set (0.00 sec)


	shell> ll
	-rw-r-----. 1 mysql mysql        464 9月  28 23:18 localhost-relay-bin.000003
	-rw-r-----. 1 mysql mysql        937 9月  28 23:21 localhost-relay-bin.000004
	-rw-r-----. 1 mysql mysql         58 9月  28 23:19 localhost-relay-bin.index
	
	-- reset master;
	
	mysql> reset master;
	Query OK, 0 rows affected (0.03 sec)

	mysql> select * from mysql.gtid_executed;
	Empty set (0.00 sec)

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


	shell> ll
	-rw-r-----. 1 mysql mysql        464 9月  28 23:18 localhost-relay-bin.000003
	-rw-r-----. 1 mysql mysql        937 9月  28 23:21 localhost-relay-bin.000004
	-rw-r-----. 1 mysql mysql         58 9月  28 23:19 localhost-relay-bin.index

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000003
			  Read_Master_Log_Pos: 724
				   Relay_Log_File: localhost-relay-bin.000004
					Relay_Log_Pos: 937
			Relay_Master_Log_File: mysql-bin.000003
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		....................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
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
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
				Executed_Gtid_Set: 
					Auto_Position: 1
		....................................................
	1 row in set (0.00 sec)


2. master 
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000003
			 Position: 724
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
	1 row in set (0.00 sec)



	mysql> delete from test_db.t where id=3;
	Query OK, 1 row affected (0.00 sec)

	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000003
			 Position: 989
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-4
	1 row in set (0.00 sec)

	mysql> SELECT * FROM test_db.t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	|  6 |    6 |    6 |
	|  7 |    7 |    7 |
	|  8 |    8 |    8 |
	|  9 |    9 |    9 |
	| 10 |   10 |   10 |
	+----+------+------+
	7 rows in set (0.00 sec)


3. slave 的状态

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000003
			  Read_Master_Log_Pos: 989
				   Relay_Log_File: localhost-relay-bin.000004
					Relay_Log_Pos: 1202
			Relay_Master_Log_File: mysql-bin.000003
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
	....................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
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
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-4
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:4
					Auto_Position: 1
	....................................................
	1 row in set (0.00 sec)


	mysql> SELECT * FROM test_db.t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	|  6 |    6 |    6 |
	|  7 |    7 |    7 |
	|  8 |    8 |    8 |
	|  9 |    9 |    9 |
	| 10 |   10 |   10 |
	+----+------+------+
	7 rows in set (0.00 sec)


	mysql> show global variables like '%gtid%';
	+----------------------------------+----------------------------------------+
	| Variable_name                    | Value                                  |
	+----------------------------------+----------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                     |
	| enforce_gtid_consistency         | ON                                     |
	| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:4 |
	| gtid_executed_compression_period | 1000                                   |
	| gtid_mode                        | ON                                     |
	| gtid_owned                       |                                        |
	| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:4 |
	| session_track_gtids              | OFF                                    |
	+----------------------------------+----------------------------------------+
	8 rows in set (0.00 sec)

	mysql> select * from mysql.gtid_executed;
	+--------------------------------------+----------------+--------------+
	| source_uuid                          | interval_start | interval_end |
	+--------------------------------------+----------------+--------------+
	| 9e520b78-013c-11eb-a84c-0800271bf591 |              4 |            4 |
	+--------------------------------------+----------------+--------------+
	1 row in set (0.00 sec)


4. 小结
	
	GTID模式下从库执行reset master，会清空的信息：
		mysql.gtid_executed表
		gtid_executed变量
		gtid_purged变量
		同时，从库复制并不会报错，因为 Retrieved_Gtid_Set 并不会被清空。
		
	
	
	
