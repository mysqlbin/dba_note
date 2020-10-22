
1. 初始化表结构和数据
2. 简单追踪延迟情况 
3. 小结
4. 从库相关参数

1. 初始化表结构和数据

	drop table  if exists t_20201021;
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
		  while(i<=100000)do
			insert into t_20201021(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'));
			set i=i+1;
		  end while;
	  commit;
	end;;
	delimiter ;
		
	
	mysql> call idata();
	Query OK, 0 rows affected (13.02 sec)



2. 简单追踪延迟情况 


	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 2057
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 2640
		..........................................................................
			Seconds_Behind_Master: 0
		..........................................................................
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		..........................................................................

			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-109
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................

	1 row in set (0.00 sec)
	
	-- 间隔一秒左右执行下面的语句
	
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Queueing master event to the relay log
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 3973004
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 3973587
		..........................................................................、
			Seconds_Behind_Master: 15
		..........................................................................
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Reading event from the relay log   -- 开始读取 relay log event 的时候会进入状态 reading event from the relay log
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-109
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................
	1 row in set (0.02 sec)
	
	-- 验证了主库执行耗时 13秒，从库的 Seconds_Behind_Master 从13秒开始

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: System lock
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 14728178
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 14728761
		..........................................................................
			Seconds_Behind_Master: 15
		..........................................................................
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Reading event from the relay log
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-109
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.07 sec)

	
	mysql> show slave status\G;
	^[[A*************************** 1. row ***************************
				   Slave_IO_State: Queueing master event to the relay log
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 20584606
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 20585189
		..........................................................................
			Seconds_Behind_Master: 17
		..........................................................................
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Reading event from the relay log
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-109
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................
	1 row in set (1.48 sec)


	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 43102232
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 43102815
		..........................................................................
			Seconds_Behind_Master: 19
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: System lock
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-110
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
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
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 43102232
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 43102815
		..........................................................................
			Seconds_Behind_Master: 19
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: System lock
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-110
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
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
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 43102232
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 43102815
		..........................................................................
			Seconds_Behind_Master: 18
		..........................................................................
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: System lock
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-110
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
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
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 43102232
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 43102815
		..........................................................................
			Seconds_Behind_Master: 18
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Reading event from the relay log
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-110
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
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
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 43102232
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 43102815
		..........................................................................
			Seconds_Behind_Master: 18
	Master_SSL_Verify_Server_Cert: No
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: System lock
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-110
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
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
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 43102232
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 2176
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 2057
				  Relay_Log_Space: 43102815
		..........................................................................
			Seconds_Behind_Master: 17
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: System lock
			   Master_Retry_Count: 86400
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-110
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-109,
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
				  Master_Log_File: mysql-bin.000014
			  Read_Master_Log_Pos: 43102232
				   Relay_Log_File: localhost-relay-bin.000036
					Relay_Log_Pos: 43102351
			Relay_Master_Log_File: mysql-bin.000014
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
		..........................................................................
			  Exec_Master_Log_Pos: 43102232
				  Relay_Log_Space: 43102815
		..........................................................................
			Seconds_Behind_Master: 0
		..........................................................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
		..........................................................................
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79-110
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-110,
	9f50ba55-0141-11eb-98ab-0800270c8f40:1
					Auto_Position: 1
		..........................................................................
	1 row in set (0.00 sec)



3. 小结

	-- 验证了DML大事务造成的延迟，其延迟不会从0开始增加，而是直接从主库执行了多久开始。比如主库执行这个事务耗时20秒，那么延迟就从20开始，这是因为query event中没有准确的执行时间，可以参考第8节和第27节。	
	
	-- 本案例主库执行耗时13秒，那么从库的延迟就从13秒开始，假设从库执行这个事务耗时15秒，那么此时的Seconds_Behind_Master值大概为28，然后降为0.
	
	其它实验案例参考：《2020-10-21-pt-osc和gh-ost在1主2从的一些实践对比》
	
	
4. 从库相关参数
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

