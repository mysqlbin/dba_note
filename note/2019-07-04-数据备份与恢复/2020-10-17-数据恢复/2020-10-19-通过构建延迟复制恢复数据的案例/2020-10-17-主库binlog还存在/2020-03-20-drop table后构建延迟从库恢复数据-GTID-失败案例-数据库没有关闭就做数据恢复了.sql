
关于 drop table 后的黑科技恢复
    

恢复思路
	
	1. 假设没有构建延迟从库 
		复制架构: 一主一从, 每天凌晨6点在从库进行单库全备
		主库保留7天的binlog
		
	2. 发生drop table后，必须要停止业务
	
	3. 然后通过已经有的全备建立延迟从库，start slave until 直到删除到drop table之前停下来.
	
	注意事项:
		不能在已有的从库做数据恢复操作
		 
	
		 
实操
		 
Master 制造数据
		 
	create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

	use db1;
	CREATE TABLE `t1` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db1`.`t1`(`id`, `name`, `amount`) VALUES (1, '1', 2); 

	INSERT INTO `db1`.`t1`(`id`, `name`, `amount`) VALUES (2, '1', 2); 

	INSERT INTO `db1`.`t1`(`id`, `name`, `amount`) VALUES (3, '1', 2); 
	
	
	root@localhost [(none)]>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000007
			 Position: 1385
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110653
	1 row in set (0.00 sec)

	ERROR: 
	No query specified

	# 这里开始备份数据 并且 应用 apply-log 并且待 apply-log 应用完成后再执行下面的部分

	
	CREATE TABLE `t2` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db1`.`t2`(`id`, `name`, `amount`) VALUES (1, '1', 2); 

	INSERT INTO `db1`.`t2`(`id`, `name`, `amount`) VALUES (2, '1', 2); 

	INSERT INTO `db1`.`t2`(`id`, `name`, `amount`) VALUES (3, '1', 2); 


	INSERT INTO `db1`.`t2`(`id`, `name`, `amount`) VALUES (4, '1', 2); 
	
		
	INSERT INTO `db1`.`t1`(`id`, `name`, `amount`) VALUES (4, '1', 2); 

	
	root@localhost [(none)]>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000007
			 Position: 3106
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110659
	1 row in set (0.00 sec)

	ERROR: 
No query specified	

	

发起一个误删除数据表操作

	drop table db1.t1;  
	
	INSERT INTO `db1`.`t2`(`id`, `name`, `amount`) VALUES (5, '1', 2); 
	
	root@localhost [(none)]>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000007
			 Position: 3549
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110661
	1 row in set (0.00 sec)

	ERROR: 
	No query specified

	root@localhost [(none)]>flush logs;
	Query OK, 0 rows affected (0.90 sec)

	root@localhost [(none)]>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000008
			 Position: 194
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110661
	1 row in set (0.00 sec)
	
	mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000007  > 07.sql

	# at 3106
	#200320 17:41:39 server id 273306  end_log_pos 3171 CRC32 0x3119ae99 	GTID	last_committed=10	sequence_number=11	rbr_only=no
	SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110660'/*!*/;
	# at 3171
	#200320 17:41:39 server id 273306  end_log_pos 3284 CRC32 0x91212cb0 	Query	thread_id=39	exec_time=0	error_code=0
	SET TIMESTAMP=1584697299/*!*/;
	DROP TABLE `t1` /* generated by server */
	/*!*/;
	# at 3284

建立复制关系:

	
	[root@env 2020-03-20_17-27-54]# cat xtrabackup_binlog_info
	mysql-bin.000007	1385	f7323d17-6442-11ea-8a77-080027758761:1-110653
	
	[root@env 2020-03-20_17-27-54]# cat xtrabackup_binlog_pos_innodb
	mysql-bin.000007	1385

	
	Slave:
		
		reset master; \
		
		set global gtid_purged = 'f7323d17-6442-11ea-8a77-080027758761:1-110653'; \
		
		change master to master_host='192.168.1.27',master_user='repl',master_password='123456abc',master_port=3306,master_auto_position=1; \
		
		change replication filter replicate_do_table = (db1.t1); 
		# 到时候验证下 db1.t2 表会不会复制过来。
		start slave until SQL_BEFORE_GTIDS = 'f7323d17-6442-11ea-8a77-080027758761:110660';
		
		
		show slave status\G;
		
		
		root@localhost [(none)]>show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000008
				  Read_Master_Log_Pos: 194
					   Relay_Log_File: relay-bin.000002
						Relay_Log_Pos: 1870
				Relay_Master_Log_File: mysql-bin.000007
					 Slave_IO_Running: Yes
					Slave_SQL_Running: No
					  Replicate_Do_DB: 
				  Replicate_Ignore_DB: 
				   Replicate_Do_Table: db1.t1
			   Replicate_Ignore_Table: 
			  Replicate_Wild_Do_Table: 
		  Replicate_Wild_Ignore_Table: 
						   Last_Errno: 1146
						   Last_Error: Error executing row event: 'Table 'db1.t1' doesn't exist'
						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 2841
					  Relay_Log_Space: 3561
					  Until_Condition: SQL_BEFORE_GTIDS
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
					   Last_SQL_Errno: 1146
					   Last_SQL_Error: Error executing row event: 'Table 'db1.t1' doesn't exist'
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
			 Last_SQL_Error_Timestamp: 200320 17:55:37
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:110654-110661
					Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110658
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)

		ERROR: 
		No query specified

		root@localhost [(none)]>select * from db1.t1;
		ERROR 1146 (42S02): Table 'db1.t1' doesn t exist		
			
		MySQL 的错误日志：
			2020-03-20T09:50:38.858413Z 0 [ERROR] Can't start server: Bind on TCP/IP port: Address already in use
			2020-03-20T09:50:38.858461Z 0 [ERROR] Do you already have another mysqld server running on port: 3306 ?
			2020-03-20T09:50:38.858479Z 0 [ERROR] Aborting

			2020-03-20T09:50:38.858501Z 0 [Note] Binlog end
							
		原因： MySQL 没有关闭成功。 
		
	
		解决办法: 重新操作一遍。
		
		
		
		
			
mysqlbinlog -vv --base64-output='decode-rows' relay-bin.000002 > relay02.sql

				

下面的错误原因： MySQL 没有关闭成功，就做数据恢复了。

	root@localhost [(none)]>reset master; \
	Query OK, 0 rows affected (0.07 sec)

	root@localhost [(none)]>
	root@localhost [(none)]>set global gtid_purged = 'f7323d17-6442-11ea-8a77-080027758761:1-110653'; \
	Query OK, 0 rows affected (0.01 sec)

	root@localhost [(none)]>
	root@localhost [(none)]>change master to master_host='192.168.1.27',master_user='repl',master_password='123456abc',master_port=3306,master_auto_position=1; \
	ERROR 3081 (HY000): This operation cannot be performed with running replication threads; run STOP SLAVE FOR CHANNEL '' first
	root@localhost [(none)]>set global gtid_purged = 'f7323d17-6442-11ea-8a77-080027758761:1-110653'; 
	ERROR 1840 (HY000): @@GLOBAL.GTID_PURGED can only be set when @@GLOBAL.GTID_EXECUTED is empty.
	root@localhost [(none)]>slave status\G;
	ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'slave status' at line 1
	ERROR: 
	No query specified

	root@localhost [(none)]>SHOW slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.27
					  Master_User: repl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000008
			  Read_Master_Log_Pos: 194
				   Relay_Log_File: relay-bin.000001
					Relay_Log_Pos: 4
			Relay_Master_Log_File: 
				 Slave_IO_Running: Yes
				Slave_SQL_Running: No
				  Replicate_Do_DB: 
			  Replicate_Ignore_DB: 
			   Replicate_Do_Table: db1.product
		   Replicate_Ignore_Table: 
		  Replicate_Wild_Do_Table: 
	  Replicate_Wild_Ignore_Table: 
					   Last_Errno: 0
					   Last_Error: 
					 Skip_Counter: 0
			  Exec_Master_Log_Pos: 0
				  Relay_Log_Space: 5640
				  Until_Condition: SQL_BEFORE_GTIDS
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
			   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:110649-110661
				Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110653
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)

	ERROR: 
	No query specified

	root@localhost [(none)]>

	先执行 stop slave;




