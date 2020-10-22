
1. 初始化表结构和数据
2. 执行DDL和查看对应的binlog 
3. 简单追踪延迟情况 


1. 初始化表结构和数据
	CREATE TABLE `t_20201021` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	`name` varchar(32) not NULL default '',
	`age` int(11) not NULL default 0,
	`ismale` tinyint(1) not null default 0,
	`id_card` varchar(32) not NULL default '',
	`test1` text COMMENT '',
	`test2` text COMMENT '',
	`createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	`b` int(11) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `idx_age` (`age`),
	KEY `idx_name` (`name`),
	KEY `idx_card` (`id_card`),
	KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;


	drop procedure if exists idata ;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  start transaction;
		  while(i<=10000)do
			insert into t_20201021(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'));
			set i=i+1;
		  end while;
	  commit;
	end;;
	delimiter ;
		
	call idata();

	mysql> select count(*) from t_20201021;
	+----------+
	| count(*) |
	+----------+
	|   230000 |
	+----------+
	1 row in set (0.71 sec)


2. 执行DDL和查看对应的binlog 

	mysql> alter table t_20201021 add column c int(11) default null;


	--语句执行期间没有记录binlog。

	mysql> show binlog events in 'mysql-bin.000013';
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                       |
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------+
	| mysql-bin.000013 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4      |
	| mysql-bin.000013 | 123 | Previous_gtids |    330607 |         194 | 9e520b78-013c-11eb-a84c-0800271bf591:1-103 |
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------+
	2 rows in set (0.00 sec)




	mysql> alter table t_20201021 add column d int(11) default null;
	Query OK, 0 rows affected (14.14 sec)
	Records: 0  Duplicates: 0  Warnings: 0


	mysql> show binlog events in 'mysql-bin.000013';
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                    |
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------+
	| mysql-bin.000013 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                   |
	| mysql-bin.000013 | 123 | Previous_gtids |    330607 |         194 | 9e520b78-013c-11eb-a84c-0800271bf591:1-103                              |
	| mysql-bin.000013 | 194 | Gtid           |    330607 |         259 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:104'     |
	| mysql-bin.000013 | 259 | Query          |    330607 |         399 | use `test_db`; alter table t_20201021 add column c int(11) default null |
	| mysql-bin.000013 | 399 | Gtid           |    330607 |         464 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:105'     |
	| mysql-bin.000013 | 464 | Query          |    330607 |         604 | use `test_db`; alter table t_20201021 add column d int(11) default null |
	| mysql-bin.000013 | 604 | Rotate         |    330607 |         651 | mysql-bin.000014;pos=4                                                  |
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------+
	7 rows in set (0.00 sec)



	[root@localhost logs]#  mysqlbinlog -vv --base64-output='decode-rows' mysql-bin.000013
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
	/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
	DELIMITER /*!*/;
	# at 4
	#201022 17:00:58 server id 330607  end_log_pos 123 CRC32 0x2e0d78c9 	Start: binlog v 4, server v 5.7.22-log created 201022 17:00:58
	# at 123
	#201022 17:00:58 server id 330607  end_log_pos 194 CRC32 0xbf10dc28 	Previous-GTIDs
	# 9e520b78-013c-11eb-a84c-0800271bf591:1-103
	# at 194
	#201022 17:09:13 server id 330607  end_log_pos 259 CRC32 0xca678f06 	GTID	last_committed=0	sequence_number=1	rbr_only=no
	SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:104'/*!*/;
	# at 259
	#201022 17:09:13 server id 330607  end_log_pos 399 CRC32 0x026d92e3 	Query	thread_id=3	exec_time=18	error_code=0
	use `test_db`/*!*/;
	SET TIMESTAMP=1603357753.278261/*!*/;
	SET @@session.pseudo_thread_id=3/*!*/;
	SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
	SET @@session.sql_mode=1075838976/*!*/;
	SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
	/*!\C utf8 *//*!*/;
	SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
	SET @@session.lc_time_names=0/*!*/;
	SET @@session.collation_database=DEFAULT/*!*/;
	alter table t_20201021 add column c int(11) default null
	/*!*/;
	# at 399
	#201022 17:16:57 server id 330607  end_log_pos 464 CRC32 0x97353a85 	GTID	last_committed=1	sequence_number=2	rbr_only=no
	SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:105'/*!*/;
	# at 464
	#201022 17:16:57 server id 330607  end_log_pos 604 CRC32 0x95e6586e 	Query	thread_id=3	exec_time=14	error_code=0
	SET TIMESTAMP=1603358217.425848/*!*/;
	alter table t_20201021 add column d int(11) default null
	/*!*/;
	# at 604
	#201022 17:20:07 server id 330607  end_log_pos 651 CRC32 0xbe37acb8 	Rotate to mysql-bin.000014  pos: 4
	SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
	DELIMITER ;
	# End of log file
	/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;



	-- exec_time=14：验证了 query event 实际记录了 DDL语句的执行时间。

 
3. 简单追踪延迟情况 
 
	mysql> show slave status\G;
	*************************** 1. row ***************************
		 Slave_IO_State: Waiting for master to send event
		..........................................................................
			Seconds_Behind_Master: 0
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: creating table
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-105
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-104,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................
	1 row in set (0.00 sec)

	 mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000013
			  Read_Master_Log_Pos: 604
				   Relay_Log_File: localhost-relay-bin.000033
					Relay_Log_Pos: 612
			Relay_Master_Log_File: mysql-bin.000013
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 399
		..........................................................................
			Seconds_Behind_Master: 6
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: creating table
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-105
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-104,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................
	1 row in set (0.00 sec)

	 mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000013
			  Read_Master_Log_Pos: 604
				   Relay_Log_File: localhost-relay-bin.000033
					Relay_Log_Pos: 612
			Relay_Master_Log_File: mysql-bin.000013
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 399
		..........................................................................
			Seconds_Behind_Master: 6
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: altering table
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-105
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-104,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................
	1 row in set (0.00 sec)


	......................................................................
	 
	 mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000013
			  Read_Master_Log_Pos: 604
				   Relay_Log_File: localhost-relay-bin.000033
					Relay_Log_Pos: 612
			Relay_Master_Log_File: mysql-bin.000013
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 399
		..........................................................................
			Seconds_Behind_Master: 22
		..........................................................................
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: altering table
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-105
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-104,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................
	1 row in set (0.00 sec)



	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000013
			  Read_Master_Log_Pos: 604
				   Relay_Log_File: localhost-relay-bin.000033
					Relay_Log_Pos: 817
			Relay_Master_Log_File: mysql-bin.000013
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 604
		..........................................................................
			Seconds_Behind_Master: 0
		..........................................................................
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-105
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-105,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................
	1 row in set (0.00 sec)


	-- DDL 在从库执行完成 ，Seconds_Behind_Master的值从22跌为0.
	-- 假设从库执行耗时22秒，那么Seconds_Behind_Master的值会依次增加到22，然后再跌为0.

	从服务器时间 - (query_event header中timestamp的时间 + 本DDL在主库执行的时间(exec_time)) - 主从服务器时间差

	
从库相关参数
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
	1 row in set (0.00 sec)

	mysql> show global variables like '%relay_log_recovery%';
	+--------------------+-------+
	| Variable_name      | Value |
	+--------------------+-------+
	| relay_log_recovery | ON    |
	+--------------------+-------+
	1 row in set (0.01 sec)

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
	1 row in set (0.01 sec)

	mysql> show global variables like '%updates%';
	+-----------------------------------------+-------+
	| Variable_name                           | Value |
	+-----------------------------------------+-------+
	| binlog_direct_non_transactional_updates | OFF   |
	| log_slave_updates                       | OFF   |
	| low_priority_updates                    | OFF   |
	| sql_safe_updates                        | OFF   |
	+-----------------------------------------+-------+
	4 rows in set (0.00 sec)

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)


