
1. 开始构建3600秒的延迟复制
2. 做误操作
3. show binlog events
4. 解析 binlog 获取误操作对应的GTID
5. start slave until SQL_BEFORE_GTIDS


1. 开始构建3600秒的延迟复制
	stop slave sql_thread; \
	change master to master_delay=3600; \
	start slave sql_thread; \
	show slave status\G; 
		SQL_Delay: 3600


2. 做误操作
	CREATE TABLE `product` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

		
	INSERT INTO `zst`.`product`(`id`, `name`, `amount`) VALUES (1, '1', 2);

	INSERT INTO `zst`.`product`(`id`, `name`, `amount`) VALUES (2, '1', 2); 
	
	#让复制停止到这里。
	DELETE FROM `zst`.`product` WHERE `id`=2 ; 
	
	


3. show binlog events
	root@localhost [zst]>show binlog events in 'mysql-bin.000006';
	+------------------+------+----------------+-----------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Log_name         | Pos  | Event_type     | Server_id | End_log_pos | Info                                                                                                                                                                                                                                                                                |
	+------------------+------+----------------+-----------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| mysql-bin.000006 |    4 | Format_desc    |    273306 |         123 | Server ver: 5.7.19-log, Binlog ver: 4                                                                                                                                                                                                                                               |
	| mysql-bin.000006 |  123 | Previous_gtids |    273306 |         194 | f7323d17-6442-11ea-8a77-080027758761:1-110631                                                                                                                                                                                                                                       |
	| mysql-bin.000006 |  194 | Gtid           |    273306 |         259 | SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110632'                                                                                                                                                                                                              |
	| mysql-bin.000006 |  259 | Query          |    273306 |         595 | use `zst`; CREATE TABLE `product` (
		  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '涓婚.Id',
		  `name` varchar(20) DEFAULT NULL,
		  `amount` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_name` (`name`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4   |
	| mysql-bin.000006 |  595 | Gtid           |    273306 |         660 | SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110633'                                                                                                                                                                                                              |
	| mysql-bin.000006 |  660 | Query          |    273306 |         731 | BEGIN                                                                                                                                                                                                                                                                               |
	| mysql-bin.000006 |  731 | Table_map      |    273306 |         784 | table_id: 258 (zst.product)                                                                                                                                                                                                                                                         |
	| mysql-bin.000006 |  784 | Write_rows     |    273306 |         834 | table_id: 258 flags: STMT_END_F                                                                                                                                                                                                                                                     |
	| mysql-bin.000006 |  834 | Xid            |    273306 |         865 | COMMIT /* xid=64 */                                                                                                                                                                                                                                                                 |
	| mysql-bin.000006 |  865 | Gtid           |    273306 |         930 | SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110634'                                                                                                                                                                                                              |
	| mysql-bin.000006 |  930 | Query          |    273306 |        1001 | BEGIN                                                                                                                                                                                                                                                                               |
	| mysql-bin.000006 | 1001 | Table_map      |    273306 |        1054 | table_id: 258 (zst.product)                                                                                                                                                                                                                                                         |
	| mysql-bin.000006 | 1054 | Write_rows     |    273306 |        1104 | table_id: 258 flags: STMT_END_F                                                                                                                                                                                                                                                     |
	| mysql-bin.000006 | 1104 | Xid            |    273306 |        1135 | COMMIT /* xid=65 */                                                                                                                                                                                                                                                                 |
	| mysql-bin.000006 | 1135 | Gtid           |    273306 |        1200 | SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110635'                                                                                                                                                                                                              |
	| mysql-bin.000006 | 1200 | Query          |    273306 |        1271 | BEGIN                                                                                                                                                                                                                                                                               |
	| mysql-bin.000006 | 1271 | Table_map      |    273306 |        1324 | table_id: 258 (zst.product)                                                                                                                                                                                                                                                         |
	| mysql-bin.000006 | 1324 | Delete_rows    |    273306 |        1374 | table_id: 258 flags: STMT_END_F                                                                                                                                                                                                                                                     |
	| mysql-bin.000006 | 1374 | Xid            |    273306 |        1405 | COMMIT /* xid=66 */                                                                                                                                                                                                                                                                 |
	+------------------+------+----------------+-----------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	19 rows in set (0.00 sec)


4. 解析 binlog 获取误操作对应的GTID
		
		
	mysqlbinlog --no-defaults -vv --base64-output=decode-rows --start-datetime='2020-03-20 15:06:00'  --stop-datetime='2020-03-20 15:08:00'  mysql-bin.000006  > 06.sql

		

5. start slave until SQL_BEFORE_GTIDS

	stop slave sql_thread; \
	change master to master_delay=0; \
	start slave until SQL_BEFORE_GTIDS='f7323d17-6442-11ea-8a77-080027758761:110635'; \
	root@localhost [(none)]>show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.27
					  Master_User: repl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000006
			  Read_Master_Log_Pos: 1405
				   Relay_Log_File: relay-bin.000010
					Relay_Log_Pos: 1348
			Relay_Master_Log_File: mysql-bin.000006
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
			  Exec_Master_Log_Pos: 1135
				  Relay_Log_Space: 1906
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
			   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:110631-110635
				Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110634
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec);

	master:
		root@localhost [zst]>select * from `zst`.`product` where id=2;
		Empty set (0.00 sec)		
			
	slave:
		root@localhost [(none)]>select * from `zst`.`product` where id=2;
		+----+------+--------+
		| id | name | amount |
		+----+------+--------+
		|  2 | 1    |      2 |
		+----+------+--------+
		1 row in set (0.00 sec)
	