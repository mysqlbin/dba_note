
关于drop database后的黑科技恢复
    

恢复方法:
	
	1. 假设没有构建延迟从库 
		复制架构: 一主一从, 每天凌晨6点在从库进行单库全备
		从库保留7天的binlog
		
	2. 发生drop database后，必须要停止业务
	
	3. 然后通过已经有的全备建立延迟从库，start slave until 直到删除到drop database之前停下来.
	
	注意事项:
		
		不能在已有的从库做数据恢复操作
		
		 

Master:
		 
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

	备份数据:


		shell>  mysqldump -h192.168.0.54 -uroot -p123456abc --master-data=2  --single-transaction -B db1 > db1.sql

		mysqldump: [Warning] Using a password on the command line interface can be insecure.
		Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. 
		If you dont want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events. 	

		-- GTID模式下, mysqldump+set-gtid-purged, 表示在备份文件中, 不会显示GTID信息: SET @@GLOBAL.GTID_PURGED='b453f45b-ba9f-11e8-a29c-080027eb50c1:1-7823290';



		INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (3, '1', 2); 

		-- 恢复到这里

		drop database db1;  -- 发起一个误删除数据库操作


 

建立复制关系:


	在数据库恢复实例上导入备份

		mysql> mysql -h192.168.0.55 -uroot -p123456abc < db1.sql
		mysql: [Warning] Using a password on the command line interface can be insecure.
		ERROR 1840 (HY000) at line 24: @@GLOBAL.GTID_PURGED can only be set when @@GLOBAL.GTID_EXECUTED is empty.
		解决办法: 
		reset master;
	

	复制专用账号只要是在做 change master to 之前创建和授权就行
	Master:

		create user 'repl'@'%' identified by '123456abc';
		grant replication slave on *.* to 'repl'@'%' with grant option;

	Slave:
		change master to master_host='192.168.0.54',master_user='repl',master_password='123456abc',master_port=3306,master_auto_position=1;


恢复数据

	获取 SQL_BEFORE_GTIDS
		mysqlbinlog --no-defaults -vv --base64-output=decode-rows --start-datetime='2019-08-22 16:10:00' --stop-datetime='2019-08-22 16:20:00' mysql-bin.000099 > 99.sql

		BEGIN
		/*!*/;
		# at 330
		#190822 16:13:22 server id 330601  end_log_pos 383 CRC32 0x03826ebe     Table_map: `db1`.`product` mapped to number 186
		# at 383
		#190822 16:13:22 server id 330601  end_log_pos 433 CRC32 0xae4fdd0f     Write_rows: table id 186 flags: STMT_END_F
		### INSERT INTO `db1`.`product`
		### SET
		###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
		###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
		###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
		# at 433
		#190822 16:13:22 server id 330601  end_log_pos 464 CRC32 0x26745e22     Xid = 652
		COMMIT/*!*/;
		# at 464
		#190822 16:13:22 server id 330601  end_log_pos 529 CRC32 0x8c0e4962     GTID    last_committed=1        sequence_number=2       rbr_only=no
		SET @@SESSION.GTID_NEXT= 'b453f45b-ba9f-11e8-a29c-080027eb50c1:7823297'/*!*/;
		# at 529
		#190822 16:13:22 server id 330601  end_log_pos 638 CRC32 0xe551da2e     Query   thread_id=66    exec_time=0     error_code=0
		SET TIMESTAMP=1566461602/*!*/;
		#恢复到这里^M
		^M
		drop database db1
		/*!*/;
		# at 638
		#190822 16:17:39 server id 330601  end_log_pos 703 CRC32 0x52380692     GTID    last_committed=2        sequence_number=3       rbr_only=no
		SET @@SESSION.GTID_NEXT= 'b453f45b-ba9f-11e8-a29c-080027eb50c1:7823298'/*!*/;
		# at 703
		#190822 16:17:39 server id 330601  end_log_pos 883 CRC32 0x1b22625b     Query   thread_id=69    exec_time=0     error_code=0
		SET TIMESTAMP=1566461859/*!*/;
		CREATE USER 'repl'@'%' IDENTIFIED WITH 'mysql_native_password' AS '*FF051C055989F0D4D3E061F738DD68E277934095'
		/*!*/;
		# at 883
		#190822 16:17:45 server id 330601  end_log_pos 948 CRC32 0xe959afb0     GTID    last_committed=3        sequence_number=4       rbr_only=no
		SET @@SESSION.GTID_NEXT= 'b453f45b-ba9f-11e8-a29c-080027eb50c1:7823299'/*!*/;
		# at 948
		#190822 16:17:45 server id 330601  end_log_pos 1097 CRC32 0x47a25ed8    Query   thread_id=51    exec_time=0     error_code=0
		SET TIMESTAMP=1566461865/*!*/;
		GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' WITH GRANT OPTION
		/*!*/;
		SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
		DELIMITER ;

----------------------------------------------------------------------------------


		start slave until SQL_BEFORE_GTIDS='b453f45b-ba9f-11e8-a29c-080027eb50c1:7823297'; \

		show slave status\G;

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.54
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000099
				  Read_Master_Log_Pos: 1097
					   Relay_Log_File: mgr01-relay-bin.000002
						Relay_Log_Pos: 637
				Relay_Master_Log_File: mysql-bin.000099
					 Slave_IO_Running: Yes
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
				  Exec_Master_Log_Pos: 464
					  Relay_Log_Space: 1477
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
					 Master_Server_Id: 330601
						  Master_UUID: b453f45b-ba9f-11e8-a29c-080027eb50c1
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: 
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 
			 Last_SQL_Error_Timestamp: 
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: b453f45b-ba9f-11e8-a29c-080027eb50c1:7823296-7823299
					Executed_Gtid_Set: b453f45b-ba9f-11e8-a29c-080027eb50c1:1-7823296
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)



easy.


