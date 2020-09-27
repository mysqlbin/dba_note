
1. reset slave会重置的信息
2. 通过实验来验证 reset slave会重置的信息
3. reset slave all
4. 思考：
	1. stop slave; reset slave; 后 start slave; 但是此时 master 的 binary log 并不是从第一个文件开始，有什么问题？
5. 相关参考
	https://dev.mysql.com/doc/refman/5.7/en/reset-slave.html
6. cat master.info 和 cat relay-log.info  
7. 小结
	
1. reset slave会重置的信息
	
	1. master.info 文件 
	2. relay.info 文件 
	3. 删除所有的 relay log（中继日志）文件 并且 创建一个新的 relay log 文件
		It clears the master info and relay log info repositories, deletes all the relay log files, and starts a new relay log file
		重置中继日志。
		
	4. GTID 模式下：
		不影响GTID的执行信息， 比如不会重置gtid_executed变量、gtid_purged变量、mysql.gtid_executed表
		issuing RESET SLAVE has no effect on the GTID execution history. The statement does not change the values of gtid_executed or gtid_purged, or the mysql.gtid_executed table.
		
	5. reset slave 存在的问题：
		RESET SLAVE有个问题，它虽然删除了上述文件，但内存中的 change master 信息并没有删除，
		此时，可直接执行start slave，但因为删除了master.info和relay-log.info，它会从头开始接受主的binlog并应用。
	
	
2. 通过实验来验证 reset slave会重置的信息

	主库：
		192.168.1.27
		
	从库：
		192.168.1.29
		
	mysql>select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.19-log |
	+------------+
	1 row in set (0.04 sec)	
	
	slave old info：

		mysql>select * from mysql.gtid_executed;
		+--------------------------------------+----------------+--------------+
		| source_uuid                          | interval_start | interval_end |
		+--------------------------------------+----------------+--------------+
		| f7323d17-6442-11ea-8a77-080027758761 |              1 |            2 |
		+--------------------------------------+----------------+--------------+
		1 row in set (0.01 sec)
		
		mysql>show global variables  like '%gtid%';
		+----------------------------------+------------------------------------------+
		| Variable_name                    | Value                                    |
		+----------------------------------+------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                       |
		| enforce_gtid_consistency         | ON                                       |
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-5 |
		| gtid_executed_compression_period | 1000                                     |
		| gtid_mode                        | ON                                       |
		| gtid_owned                       |                                          |
		| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-2 |
		| session_track_gtids              | OFF                                      |
		+----------------------------------+------------------------------------------+
		8 rows in set (0.00 sec)

				
		[root@env data]# ll
		total 2129920
		-rw-r----- 1 mysql mysql         56 Mar 14 06:02 auto.cnf
		-rw-r----- 1 mysql mysql     519397 Oct  3 10:27 env.log
		-rw-r----- 1 mysql mysql     983526 Mar 14 06:20 error.log
		-rw-r----- 1 mysql mysql        807 Mar 14 06:02 ib_buffer_pool
		-rw-r----- 1 mysql mysql 1849688064 Mar 14 06:21 ibdata1
		-rw-r----- 1 mysql mysql  104857600 Mar 14 06:21 ib_logfile0
		-rw-r----- 1 mysql mysql  104857600 Jul 27  2019 ib_logfile1
		-rw-r----- 1 mysql mysql  104857600 Mar 14 06:21 ib_logfile2
		-rw-r----- 1 mysql mysql   12582912 Mar 14 06:02 ibtmp1
		-rw-r----- 1 mysql mysql        129 Mar 14 06:24 master.info
		drwxr-x--- 2 mysql mysql       4096 Mar 14 06:10 mysql
		-rw-r----- 1 mysql mysql          6 Mar 14 06:02 mysql.pid
		drwxr-x--- 2 mysql mysql       8192 Nov 21  2017 performance_schema
		-rw-r----- 1 mysql mysql        201 Mar 14 06:20 relay-bin.000001
		-rw-r----- 1 mysql mysql       1113 Mar 14 06:21 relay-bin.000002
		-rw-r----- 1 mysql mysql         38 Mar 14 06:20 relay-bin.index
		-rw-r----- 1 mysql mysql         55 Mar 14 06:21 relay-log.info
		drwxr-x--- 2 mysql mysql        126 Mar 14 06:10 repl_monitor
		-rw-r--r-- 1 root  root          24 Nov 22  2017 report6.log
		-rw-r--r-- 1 root  root          24 Nov 22  2017 report7.log
		-rw-r--r-- 1 root  root          24 Nov 22  2017 report.log
		-rw-r----- 1 mysql mysql    2591497 Mar 14 06:02 slow.log
		-rw-r--r-- 1 root  root          24 Nov 22  2017 slow_report6.log
		-rw-r--r-- 1 root  root        5373 Nov 22  2017 slow_report.log
		drwxr-x--- 2 mysql mysql       8192 Nov 21  2017 sys
		drwxr-x--- 2 mysql mysql       4096 Mar 14 06:10 terrace_db
		drwxr-x--- 2 mysql mysql       4096 Mar 14 06:10 zst

		
		mysql>show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000001
				  Read_Master_Log_Pos: 1204
					   Relay_Log_File: relay-bin.000002
						Relay_Log_Pos: 1113
				Relay_Master_Log_File: mysql-bin.000001
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
				  Exec_Master_Log_Pos: 1204
					  Relay_Log_Space: 1314
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
					 Master_Server_Id: 273306
						  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
					 Master_Info_File: /data/mysql/mysql3306/data/master.info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 
			 Last_SQL_Error_Timestamp: 
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:3-5
					Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-5
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)



	reset slave;

		mysql>reset slave;
		ERROR 3081 (HY000): This operation cannot be performed with running replication threads; run STOP SLAVE FOR CHANNEL '' first
		
		mysql>stop slave;
		Query OK, 0 rows affected (0.00 sec)

		mysql>reset slave;
		Query OK, 0 rows affected (0.01 sec)
		
		
		mysql>select * from mysql.gtid_executed;
		+--------------------------------------+----------------+--------------+
		| source_uuid                          | interval_start | interval_end |
		+--------------------------------------+----------------+--------------+
		| f7323d17-6442-11ea-8a77-080027758761 |              1 |            2 |
		+--------------------------------------+----------------+--------------+
		1 row in set (0.00 sec)

		mysql>show global variables  like '%gtid%';
		+----------------------------------+------------------------------------------+
		| Variable_name                    | Value                                    |
		+----------------------------------+------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                       |
		| enforce_gtid_consistency         | ON                                       |
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-5 |
		| gtid_executed_compression_period | 1000                                     |
		| gtid_mode                        | ON                                       |
		| gtid_owned                       |                                          |
		| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-2 |
		| session_track_gtids              | OFF                                      |
		+----------------------------------+------------------------------------------+
		8 rows in set (0.00 sec)

		[root@env data]# ll
		total 2129908
		-rw-r----- 1 mysql mysql         56 Mar 14 06:02 auto.cnf
		-rw-r----- 1 mysql mysql     519397 Oct  3 10:27 env.log
		-rw-r----- 1 mysql mysql     984118 Mar 14 06:39 error.log
		-rw-r----- 1 mysql mysql        807 Mar 14 06:02 ib_buffer_pool
		-rw-r----- 1 mysql mysql 1849688064 Mar 14 06:21 ibdata1
		-rw-r----- 1 mysql mysql  104857600 Mar 14 06:21 ib_logfile0
		-rw-r----- 1 mysql mysql  104857600 Jul 27  2019 ib_logfile1
		-rw-r----- 1 mysql mysql  104857600 Mar 14 06:21 ib_logfile2
		-rw-r----- 1 mysql mysql   12582912 Mar 14 06:02 ibtmp1
		drwxr-x--- 2 mysql mysql       4096 Mar 14 06:10 mysql
		-rw-r----- 1 mysql mysql          6 Mar 14 06:02 mysql.pid
		drwxr-x--- 2 mysql mysql       8192 Nov 21  2017 performance_schema
		-rw-r----- 1 mysql mysql        217 Mar 14 06:39 relay-bin.000001
		-rw-r----- 1 mysql mysql         19 Mar 14 06:39 relay-bin.index
		drwxr-x--- 2 mysql mysql        126 Mar 14 06:10 repl_monitor
		-rw-r--r-- 1 root  root          24 Nov 22  2017 report6.log
		-rw-r--r-- 1 root  root          24 Nov 22  2017 report7.log
		-rw-r--r-- 1 root  root          24 Nov 22  2017 report.log
		-rw-r----- 1 mysql mysql    2591497 Mar 14 06:02 slow.log
		-rw-r--r-- 1 root  root          24 Nov 22  2017 slow_report6.log
		-rw-r--r-- 1 root  root        5373 Nov 22  2017 slow_report.log
		drwxr-x--- 2 mysql mysql       8192 Nov 21  2017 sys
		drwxr-x--- 2 mysql mysql       4096 Mar 14 06:10 terrace_db
		drwxr-x--- 2 mysql mysql       4096 Mar 14 06:10 zst

		mysql>show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: 
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: 
				  Read_Master_Log_Pos: 4
					   Relay_Log_File: relay-bin.000001
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
					  Relay_Log_Space: 217
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
					 Master_Server_Id: 273306
						  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
					 Master_Info_File: /data/mysql/mysql3306/data/master.info
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
					Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-5
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)

	start slave;

	
		mysql>start slave;
		Query OK, 0 rows affected (0.05 sec)

		mysql>show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000001
				  Read_Master_Log_Pos: 1204
					   Relay_Log_File: relay-bin.000003
						Relay_Log_Pos: 414
				Relay_Master_Log_File: mysql-bin.000001
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
				  Exec_Master_Log_Pos: 1204
					  Relay_Log_Space: 615
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
					 Master_Server_Id: 273306
						  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
					 Master_Info_File: /data/mysql/mysql3306/data/master.info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 
			 Last_SQL_Error_Timestamp: 
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: 
					Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-5
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)


	
	master：
		mysql>delete from zst.t20190930 where id=1;
		Query OK, 1 row affected (0.05 sec)
	
	slave：
		mysql>show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000001
				  Read_Master_Log_Pos: 1475
					   Relay_Log_File: relay-bin.000003
						Relay_Log_Pos: 685
				Relay_Master_Log_File: mysql-bin.000001
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
				  Exec_Master_Log_Pos: 1475
					  Relay_Log_Space: 886
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
					 Master_Server_Id: 273306
						  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
					 Master_Info_File: /data/mysql/mysql3306/data/master.info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 
			 Last_SQL_Error_Timestamp: 
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:6
					Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-6
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)

		

		
3. reset slave all

	mysql> reset slave all;
	ERROR 3081 (HY000): This operation cannot be performed with running replication threads; run STOP SLAVE FOR CHANNEL '' first
	
	mysql>stop slave;
	Query OK, 0 rows affected (0.04 sec)

	mysql> reset slave all;
	Query OK, 0 rows affected (0.02 sec)

	mysql>show slave status\G;
	Empty set (0.00 sec)

	mysql>start slave;
	ERROR 1200 (HY000): The server is not configured as slave; fix in config file or with CHANGE MASTER TO


	mysql>change master to 
    -> master_host='192.168.1.27',
    -> master_user='repl',
    -> master_password='123456abc',
    -> master_port=3306,
    -> MASTER_AUTO_POSITION = 1;
	Query OK, 0 rows affected, 2 warnings (0.09 sec)

	mysql>
	mysql>start slave;
	ERROR 1872 (HY000): Slave failed to initialize relay log info structure from the repository

	error.log
		2020-03-16T00:12:38.481407Z 3 [ERROR] Slave SQL for channel '': Slave failed to initialize relay log info structure from the repository, Error_code: 1872
	
	mysql>show global variables like '%relay_log_recovery%';
	+--------------------+-------+
	| Variable_name      | Value |
	+--------------------+-------+
	| relay_log_recovery | ON    |
	+--------------------+-------+
	1 row in set (0.00 sec)
	
	现象：
		
		When i tried to configurate a crash safe slave with MTS and GTID based replication, but after a OS crash replication failed to be start.
		
		当我尝试使用基于MTS和GTID的复制配置崩溃安全从服务器时，但是在操作系统崩溃复制后无法启动。
		
	对应的解决方案：
		https://www.cnblogs.com/shengdimaya/p/7681550.html
		https://bugs.mysql.com/bug.php?id=83713
		
	mysql>reset slave;
	Query OK, 0 rows affected (0.03 sec)

	mysql>start slave IO_THREAD;
	Query OK, 0 rows affected (0.05 sec)

	mysql>stop slave IO_THREAD;
	Query OK, 0 rows affected (0.00 sec)

	mysql>reset slave;
	Query OK, 0 rows affected (0.04 sec)

	mysql>start slave;
	Query OK, 0 rows affected (0.02 sec)

	mysql>show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.27
					  Master_User: repl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000002
			  Read_Master_Log_Pos: 194
				   Relay_Log_File: relay-bin.000003
					Relay_Log_Pos: 367
			Relay_Master_Log_File: mysql-bin.000002
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
			  Exec_Master_Log_Pos: 194
				  Relay_Log_Space: 568
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
				 Master_Server_Id: 273306
					  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
				 Master_Info_File: /data/mysql/mysql3306/data/master.info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 
				Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-6
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)

	
4. 思考：

	1. stop slave; reset slave; 后 start slave; 但是此时 master 的 binary log 并不是从第一个文件开始，有什么问题？
		验证如下：
		master：
			mysql>show binary logs;
			+------------------+-----------+
			| Log_name         | File_size |
			+------------------+-----------+
			| mysql-bin.000001 |      1522 |
			| mysql-bin.000002 |       460 |
			+------------------+-----------+
			2 rows in set (0.00 sec)
				
			purge binary logs to 'mysql-bin.000002';
			
			
			mysql>show binary logs;
			+------------------+-----------+
			| Log_name         | File_size |
			+------------------+-----------+
			| mysql-bin.000002 |       460 |
			+------------------+-----------+
			1 row in set (0.00 sec)


		slave:
		
			mysql>stop slave;
			Query OK, 0 rows affected (0.00 sec)

			mysql>reset slave;
			Query OK, 0 rows affected (0.02 sec)

			mysql>start slave;
			Query OK, 0 rows affected (0.03 sec)

			mysql>show slave status\G;
			*************************** 1. row ***************************
						   Slave_IO_State: Waiting for master to send event
							  Master_Host: 192.168.1.27
							  Master_User: repl
							  Master_Port: 3306
							Connect_Retry: 60
						  Master_Log_File: mysql-bin.000002
					  Read_Master_Log_Pos: 460
						   Relay_Log_File: relay-bin.000003
							Relay_Log_Pos: 414
					Relay_Master_Log_File: mysql-bin.000002
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
					  Exec_Master_Log_Pos: 460
						  Relay_Log_Space: 615
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
						 Master_Server_Id: 273306
							  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
						 Master_Info_File: /data/mysql/mysql3306/data/master.info
								SQL_Delay: 0
					  SQL_Remaining_Delay: NULL
				  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
					   Master_Retry_Count: 86400
							  Master_Bind: 
				  Last_IO_Error_Timestamp: 
				 Last_SQL_Error_Timestamp: 
						   Master_SSL_Crl: 
					   Master_SSL_Crlpath: 
					   Retrieved_Gtid_Set: 
						Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-7
							Auto_Position: 1
					 Replicate_Rewrite_DB: 
							 Channel_Name: 
					   Master_TLS_Version: 
			1 row in set (0.00 sec)

			ERROR: 
			No query specified

		
		GTID模式下不会有问题，因为是从master上的第一个binary log 文件开始读取，如果第一个 binary log 文件是 mysql-bin.000002， 那么就从 mysql-bin.000002 开始读取。
		
		
		彻底清空复制信息。
		
	
5. 相关参考
	https://dev.mysql.com/doc/refman/5.7/en/reset-slave.html


	
6. cat master.info 和 cat relay-log.info  

	cat master.info 

		[root@env data]# cat master.info 
		25
		mysql-bin.000001
		1204
		192.168.1.27
		repl
		123456abc
		3306
		60
		0





		0
		30.000

		0
		f7323d17-6442-11ea-8a77-080027758761
		86400


		1

	cat relay-log.info  
		[root@env data]# cat relay-log.info 
		7
		./relay-bin.000002
		1113
		mysql-bin.000001
		1204
		0
		0
		1


7. 小结
	reset slave:
		重置relay log、change master to 的复制信息还在。
	reset slave all:
		重置relay log，清空所有的复制信息，包含在内存中的 change master 信息。
		
	
	