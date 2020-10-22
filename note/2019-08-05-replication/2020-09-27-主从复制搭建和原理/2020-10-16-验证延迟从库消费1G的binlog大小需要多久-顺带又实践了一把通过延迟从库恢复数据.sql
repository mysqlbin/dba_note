
0. 测试服务器环境 
1. 表结构和数据的初始化
2. 从库相关参数
3. 延迟从库的状态
4. 主库删除数据
5. 从库 start slave until SQL_BEFORE_GTIDS
6. 查看从库消费1个G的binlog需要多久和数据的恢复情况


0. 测试服务器环境
		
	CPU	物理内存	数据库内存缓冲池大小	数据盘大小
	4核	16GB内存	8GB						100GB

	是否是SSD盘		文件系统		MySQL 版本
	是				ext4			5.7.26
	
	顺序读IOPS		顺序写IOPS		随机读/写的IOPS	
	4800			1000			700/750	
	

1. 表结构和数据的初始化

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.26-log |
	+------------+
	1 row in set (0.00 sec)
	
	drop table if exists t_20201016;
	CREATE TABLE `t_20201016` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `id_card` varchar(32) not NULL default '',
	  `test1` text COMMENT '',
	  `test2` text COMMENT '',
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_age` (`age`),
	  KEY `idx_name` (`name`),
	  KEY `idx_card` (`id_card`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;
	
	drop procedure  if exists idata;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  
	  while(i<=100000)do
		insert into t_20201016(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'));
		set i=i+1;
	  end while;

	end;;
	delimiter ;

	call idata();


	mysql> show binary logs;
	+------------------+------------+
	| Log_name         | File_size  |
	+------------------+------------+
	| mysql-bin.000239 |  101000592 |
	| mysql-bin.000240 | 1073742123 |
	| mysql-bin.000241 |   51717797 |
	+------------------+------------+
	3 rows in set (0.00 sec)
	
	binlog大小： mysql-bin.000240 1073742123 bytes = 1GB

	mysql> select count(*) from t_20201016;
	+----------+
	| count(*) |
	+----------+
	|  1100000 |
	+----------+
	1 row in set (0.20 sec)

	mysql> select id  from consistency_db.t_20201016 order by id desc limit 1;
	+---------+
	| id      |
	+---------+
	| 1100000 |
	+---------+
	1 row in set (0.00 sec)

	
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000241
			 Position: 51740017
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-2409154
	1 row in set (0.00 sec)


2. 从库相关参数

	show global variables like '%master_info_repository%';
	show global variables like '%master_info_repository%';
	show global variables like '%relay_log_info_repository%';
	show global variables like '%relay_log_recovery%';
	show global variables like '%sync_master_info%';
	show global variables like '%sync_relay_log%';
	show global variables like '%sync_relay_log_info%';
	show global variables like '%updates%';
	show global variables like '%innodb_flush_log_at_trx_commit%';


	mysql> show global variables like '%master_info_repository%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| master_info_repository | TABLE |
	+------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%relay_log_info_repository%';
	+---------------------------+-------+
	| Variable_name             | Value |
	+---------------------------+-------+
	| relay_log_info_repository | TABLE |
	+---------------------------+-------+
	1 row in set (0.01 sec)
	
	mysql> show global variables like '%relay_log_recovery%';
	+--------------------+-------+
	| Variable_name      | Value |
	+--------------------+-------+
	| relay_log_recovery | OFF   |
	+--------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%sync_master_info%';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| sync_master_info | 10000 |
	+------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%sync_relay_log%';
	+---------------------+-------+
	| Variable_name       | Value |
	+---------------------+-------+
	| sync_relay_log      | 10000 |
	| sync_relay_log_info | 10000 |
	+---------------------+-------+
	2 rows in set (0.00 sec)

	mysql> show global variables like '%sync_relay_log_info%';
	+---------------------+-------+
	| Variable_name       | Value |
	+---------------------+-------+
	| sync_relay_log_info | 10000 |
	+---------------------+-------+
	1 row in set (0.00 sec)


	mysql> show global variables like '%updates%';
	+-----------------------------------------+-------+
	| Variable_name                           | Value |
	+-----------------------------------------+-------+
	| binlog_direct_non_transactional_updates | OFF   |
	| log_slave_updates                       | OFF   |
	| low_priority_updates                    | OFF   |
	| sql_safe_updates                        | OFF   |
	+-----------------------------------------+-------+
	4 rows in set (0.01 sec)
	
	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)


3. 延迟从库的状态

	select 43200/60/60

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000241
			  Read_Master_Log_Pos: 51736680
				   Relay_Log_File: voice-relay-bin.000008
					Relay_Log_Pos: 92768493
			Relay_Master_Log_File: mysql-bin.000239
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
			  Exec_Master_Log_Pos: 92768280
				  Relay_Log_Space: 2005255224
				  Until_Condition: None
				   Until_Log_File: 
					Until_Log_Pos: 0
			   Master_SSL_Allowed: No
			   Master_SSL_CA_File: 
			   Master_SSL_CA_Path: 
				  Master_SSL_Cert: 
				Master_SSL_Cipher: 
				   Master_SSL_Key: 
			Seconds_Behind_Master: 43186
	Master_SSL_Verify_Server_Cert: No
					Last_IO_Errno: 0
					Last_IO_Error: 
				   Last_SQL_Errno: 0
				   Last_SQL_Error: 
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 1
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 43200
			  SQL_Remaining_Delay: 14
		  Slave_SQL_Running_State: Waiting until MASTER_DELAY seconds after master executed event
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13798-2409150
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-1299009,
	76dcdf7c-2873-11ea-a58e-4201c0a8010c:1-47,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-415
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)



4. 主库删除数据

	mysql> delete from t_20201016 where id=1100000;
	Query OK, 1 row affected (0.01 sec)

	mysql> select id  from t_20201016 order by id desc limit 1;
	+---------+
	| id      |
	+---------+
	| 1099999 |
	+---------+
	1 row in set (0.00 sec)


5. start slave until SQL_BEFORE_GTIDS

	sudo mysqlbinlog --no-defaults -vv --base64-output=decode-rows --start-datetime='2020-10-16 11:40:00'  --stop-datetime='2020-10-16 11:49:00'  /data_volume/mysql/mysql-bin.000241  > 241.sql

	stop slave sql_thread; \
	change master to master_delay=0; \
	start slave until SQL_BEFORE_GTIDS='7664fad8-49fd-11e8-a546-4201c0a8010a:2409382'; 


	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000241
			  Read_Master_Log_Pos: 52134149
				   Relay_Log_File: voice-relay-bin.000014
					Relay_Log_Pos: 51928890
			Relay_Master_Log_File: mysql-bin.000241
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
			  Exec_Master_Log_Pos: 51928677
				  Relay_Log_Space: 52134656
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
				 Master_Server_Id: 1
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
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
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13798-2409629
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-2409381,
	76dcdf7c-2873-11ea-a58e-4201c0a8010c:1-47,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-415
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)


6. 查看从库消费1个G的binlog需要多久和数据的恢复情况

	主库
		mysql> SELECT * FROM information_schema.tables  where table_schema = 'consistency_db' and table_name='t_20201016'\G;
		*************************** 1. row ***************************
		  TABLE_CATALOG: def
		   TABLE_SCHEMA: consistency_db
			 TABLE_NAME: t_20201016
			 TABLE_TYPE: BASE TABLE
				 ENGINE: InnoDB
				VERSION: 10
			 ROW_FORMAT: Dynamic
			 TABLE_ROWS: 1051653
		 AVG_ROW_LENGTH: 343
			DATA_LENGTH: 361594880
		MAX_DATA_LENGTH: 0
		   INDEX_LENGTH: 155648000
			  DATA_FREE: 5242880
		 AUTO_INCREMENT: 1100001
			CREATE_TIME: 2020-10-16 11:14:31
			UPDATE_TIME: 2020-10-16 11:46:16
			 CHECK_TIME: NULL
		TABLE_COLLATION: utf8mb4_general_ci
			   CHECKSUM: NULL
		 CREATE_OPTIONS: 
		  TABLE_COMMENT: 
		1 row in set (0.00 sec)

	从库 
		mysql> SELECT * FROM information_schema.tables  where table_schema = 'consistency_db' and table_name='t_20201016'\G;
		*************************** 1. row ***************************
		  TABLE_CATALOG: def
		   TABLE_SCHEMA: consistency_db
			 TABLE_NAME: t_20201016
			 TABLE_TYPE: BASE TABLE
				 ENGINE: InnoDB
				VERSION: 10
			 ROW_FORMAT: Dynamic
			 TABLE_ROWS: 1078819
		 AVG_ROW_LENGTH: 322
			DATA_LENGTH: 347947008
		MAX_DATA_LENGTH: 0
		   INDEX_LENGTH: 153550848
			  DATA_FREE: 5242880
		 AUTO_INCREMENT: 1100001
			CREATE_TIME: 2020-10-16 11:59:04
			UPDATE_TIME: 2020-10-16 12:02:39
			 CHECK_TIME: NULL
		TABLE_COLLATION: utf8mb4_general_ci
			   CHECKSUM: NULL
		 CREATE_OPTIONS: 
		  TABLE_COMMENT: 
		1 row in set (0.01 sec)


		mysql> select id  from consistency_db.t_20201016 order by id desc limit 1;
		+---------+
		| id      |
		+---------+
		| 1100000 |
		+---------+
		1 row in set (0.00 sec)
		
		从库消费1个G的binlog需要3分30秒
		数据恢复完成，id=1100000的记录并没有被删除。

			
