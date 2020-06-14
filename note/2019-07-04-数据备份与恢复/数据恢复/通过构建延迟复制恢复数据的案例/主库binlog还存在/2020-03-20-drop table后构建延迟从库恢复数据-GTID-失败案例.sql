
关于 drop table 后的黑科技恢复
    

恢复方法:
	
	1. 假设没有构建延迟从库 
		复制架构: 一主一从, 每天凌晨6点在从库进行单库全备
		主库保留7天的binlog
		
	2. 发生drop table后，必须要停止业务
	
	3. 然后通过已经有的全备建立延迟从库，start slave until 直到删除到drop table之前停下来.
	
	注意事项:
		不能在已有的从库做数据恢复操作
		 
	
		 
		 
Master 制造数据
		 
	create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

	use db1;
	CREATE TABLE `product` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (1, '1', 2); 

	INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (2, '1', 2); 

	INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (3, '1', 2); 
	
	
	
	# 这里开始备份数据 并且 应用 apply-log
	# apply-log 对应的日志： apply-log.log
	
	
	CREATE TABLE `product2` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db1`.`product2`(`id`, `name`, `amount`) VALUES (1, '1', 2); 

	INSERT INTO `db1`.`product2`(`id`, `name`, `amount`) VALUES (2, '1', 2); 

	INSERT INTO `db1`.`product2`(`id`, `name`, `amount`) VALUES (3, '1', 2); 


	INSERT INTO `db1`.`product2`(`id`, `name`, `amount`) VALUES (4, '1', 2); 
	
		
	INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (4, '1', 2); 

	
	root@localhost [(none)]>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000006
			 Position: 4585
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110646
	1 row in set (0.01 sec)

	ERROR: 
	No query specified



	

发起一个误删除数据表操作

	drop table db1.product;  
	
	mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000006  > 06_.sql

	SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110647'
	
	

建立复制关系:

	
	
	[root@env 2020-03-20_15-46-42]# cat xtrabackup_binlog_info 
	mysql-bin.000006	5039	f7323d17-6442-11ea-8a77-080027758761:1-110648
	[root@env 2020-03-20_15-46-42]# cat xtrabackup_binlog_pos_innodb 
	mysql-bin.000006	5039
	

	

	Slave:
		
		reset master; \
		
		set global gtid_purged = 'f7323d17-6442-11ea-8a77-080027758761:1-110648'; \
		
		change master to master_host='192.168.1.27',master_user='repl',master_password='123456abc',master_port=3306,master_auto_position=1; \
		
		change replication filter replicate_do_table = (db1.product); 
		
		root@localhost [(none)]>show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000007
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
					  Relay_Log_Space: 1543
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
				   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:110649
					Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110648
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)

		ERROR: 
		No query specified		
		
		
	



