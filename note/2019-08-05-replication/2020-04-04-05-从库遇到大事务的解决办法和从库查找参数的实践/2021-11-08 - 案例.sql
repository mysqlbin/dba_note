
1. 描述
2. delete 删除大表数据的造成从库延迟很大的解决方案
3. 小结

1. 描述
		
	mysql> select count(*) from niuniuh5_db.table_web_loginlog_debug;
	+----------+
	| count(*) |
	+----------+
	|  5265967 |
	+----------+
	1 row in set (0.83 sec)

	mysql> delete from niuniuh5_db.table_web_loginlog_debug;
	Query OK, 5265967 rows affected (1 min 22.07 sec)

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.26-log |
	+------------+
	1 row in set (0.00 sec)


	现象：
	
		1. 后台负责人在生产环境上执行 delete from t 命令删除500多W行的全表数据
			表没有主键索引，有二级索引，先把二级索引删除，再执行 delete from t 命令删除500多W行的全表数据，说是先删除表的二级索引，再删除数据，执行速度会比较快
			
		2. 在主库执行耗时约80秒
		
		3. 通过监控发现问题：
			主库有长事务
			之后从库也有长事务，同时从库有延迟现象
			
		4. 通过主库的慢查询日志和mysqlbinlog解析binlog发现这是一个delete大事务
			也可以通过 information_schema.innodb_trx 命令来看事务执行的开始时间和操作了多少行数据。
			
		
	解决办法：
		
		1. 修改主从复制参数，slave_rows_search_algorithms 为  "INDEX_SCAN,HASH_SCAN"
			
			在平常的测试中，发现50W行的小表可以用
			
			stop slave; 停止复制， 修改从库查找的参数为的 INDEX_SCAN 和 TABLE_SCAN， 然后再开启复制
			
			这种情况下有会10左右的性能提升，之前测试过。
			
		2. 在从库跳过这个大事务 
			
			由于已经延迟了5分钟，通过 information_schema.innodb_trx 查看长事务的执行状态和已经执行的的行数(7W行左右)
			
			stop slave; 停止复制， 然后 drop table; 跳过这个GTID，也就是在从库跳过这个delete大事务。
			
			
			然后及时止损， 执行 stop slave; 命令会卡住一会，因为在这种情况下执行该命令会回滚数据， 数据回滚完成后， stop slave; 也能停止下来了。
		
	1. 没有索引就添加索引
	2. 根据情况修改从库数据查找的参数
		一般用于表中没有任何索引的情况下。******
		一般表不会没有二级索引，大多数情况下是没有建立主键索引。
	3. 在从库跳过这个大事务
	

2. delete 删除大表的造成从库的解决案例
	
	
	停止复制 stop slave;
	
	从库drop table, 再创建1个空表
	
	跳过这个delete大事务 
		
	开启复制 start slave;
	
	如果是更新语句，也可以跳过，没有索引就加索引，然后拿update的SQL语句到从库执行就好了。
	

3. 详情

			
	参数

		mysql> show global variables like '%updates%';
		+-----------------------------------------+-------+
		| Variable_name                           | Value |
		+-----------------------------------------+-------+
		| binlog_direct_non_transactional_updates | OFF   |
		| log_slave_updates                       | ON    |
		| low_priority_updates                    | OFF   |
		| sql_safe_updates                        | OFF   |
		+-----------------------------------------+-------+
		4 rows in set (0.02 sec)


		mysql> show global variables like '%sync_binlog%';
		+---------------+-------+
		| Variable_name | Value |
		+---------------+-------+
		| sync_binlog   | 1     |
		+---------------+-------+
		1 row in set (0.00 sec)

		mysql> show global variables like '%innodb_flush%';
		+--------------------------------+-------+
		| Variable_name                  | Value |
		+--------------------------------+-------+
		| innodb_flush_log_at_timeout    | 1     |
		| innodb_flush_log_at_trx_commit | 1     |
		| innodb_flush_method            |       |
		| innodb_flush_neighbors         | 1     |
		| innodb_flush_sync              | ON    |
		| innodb_flushing_avg_loops      | 30    |
		+--------------------------------+-------+
		6 rows in set (0.01 sec)


		stop slave;
		SET GLOBAL slave_rows_search_algorithms = 'INDEX_SCAN,HASH_SCAN';
		start slave;

		show global variables like '%slave_rows_search_algorithms%';


		mysql> show global variables like '%slave_rows_search_algorithms%';
		+------------------------------+----------------------+
		| Variable_name                | Value                |
		+------------------------------+----------------------+
		| slave_rows_search_algorithms | INDEX_SCAN,HASH_SCAN |
		+------------------------------+----------------------+
		1 row in set (0.00 sec)
			
			
	查看延迟情况
		-- 查系统表
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 272902411
						 trx_state: RUNNING
					   trx_started: 2021-11-08 16:15:53
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 1765442
			   trx_mysql_thread_id: 82680
						 trx_query: delete from niuniuh5_db.table_web_loginlog_debug
			   trx_operation_state: NULL
				 trx_tables_in_use: 1
				 trx_tables_locked: 1
				  trx_lock_structs: 7184
			 trx_lock_memory_bytes: 827600
				   trx_rows_locked: 1758258
				 trx_rows_modified: 1758258
		   trx_concurrency_tickets: 0
			   trx_isolation_level: READ COMMITTED
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		1 row in set (0.00 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.10
						  Master_User: repl_user
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000297
				  Read_Master_Log_Pos: 202354152
					   Relay_Log_File: db-b-relay-bin.000178
						Relay_Log_Pos: 6775
				Relay_Master_Log_File: mysql-bin.000297
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
				  Exec_Master_Log_Pos: 8186
					  Relay_Log_Space: 202354871

				Seconds_Behind_Master: 1871

						  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Reading event from the relay log
				   Master_Retry_Count: 86400

				   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561676
					Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561588,
		90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512253
						Auto_Position: 1

		1 row in set (0.00 sec)


	修复

		mysql> stop slave;
		Query OK, 0 rows affected (5.70 sec)



		mysql> drop table niuniuh5_db.table_web_loginlog_debug;
		Query OK, 0 rows affected (0.75 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.10
						  Master_User: repl_user
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000297
				  Read_Master_Log_Pos: 202354566
					   Relay_Log_File: db-b-relay-bin.000178
						Relay_Log_Pos: 6775
				Relay_Master_Log_File: mysql-bin.000297
					 Slave_IO_Running: Yes
					Slave_SQL_Running: No
					
						   Last_Errno: 1032
						   Last_Error: Could not execute Delete_rows event on table niuniuh5_db.table_web_loginlog_debug; Can't find record in 'table_web_loginlog_debug', Error_code: 1032; handler error HA_ERR_END_OF_FILE; the event's master log mysql-bin.000297, end_log_pos 16666
						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 8186
				   
				Seconds_Behind_Master: NULL
		Master_SSL_Verify_Server_Cert: No
						Last_IO_Errno: 0
						Last_IO_Error: 
					   Last_SQL_Errno: 1032
					   Last_SQL_Error: Could not execute Delete_rows event on table niuniuh5_db.table_web_loginlog_debug; Can't find record in 'table_web_loginlog_debug', Error_code: 1032; handler error HA_ERR_END_OF_FILE; the event's master log mysql-bin.000297, end_log_pos 16666
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
			 Last_SQL_Error_Timestamp: 211108 16:48:26
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561677
					Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561588,
		90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512255
						Auto_Position: 1

		1 row in set (0.00 sec)



		stop slave;
		set gtid_next='7664fad8-49fd-11e8-a546-4201c0a8010a:4561589';
		begin;commit;
		set gtid_next='automatic';
		start slave;;


		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.10
						  Master_User: repl_user
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000297
				  Read_Master_Log_Pos: 202355609
					   Relay_Log_File: db-b-relay-bin.000181
						Relay_Log_Pos: 454
				Relay_Master_Log_File: mysql-bin.000297
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes

						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 202355609
					  Relay_Log_Space: 960

				Seconds_Behind_Master: 0

						  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				   Master_Retry_Count: 86400

				   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4561679
					Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4561679,
		90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1512255
						Auto_Position: 1

		1 row in set (0.00 sec)






	
4. 小结
	
	监控长事务
	巡检脚本项中加入判断没有主键和没有二级索引的表
		SELECT t.table_schema,t.table_name FROM information_schema.tables AS t LEFT JOIN   
				(SELECT DISTINCT table_schema, table_name FROM information_schema.`KEY_COLUMN_USAGE` ) AS kt ON 
				kt.table_schema=t.table_schema AND kt.table_name = t.table_name WHERE t.table_schema NOT IN 
				('mysql', 'information_schema', 'performance_schema', 'sys') AND kt.table_name IS NULL;		
	
	除了技术总监和DBA，还给其它相关研发人员操作生产环境数据的权限
	
	INDEX_SCAN,HASH_SCAN 的生效时机
		
		stop slave;
		SET GLOBAL slave_rows_search_algorithms = 'INDEX_SCAN,HASH_SCAN';
		start slave;
		
		
	优化点：
		mysql> show global variables like '%log_slave_updates%';
		+-------------------+-------+
		| Variable_name     | Value |
		+-------------------+-------+
		| log_slave_updates | ON    |
		+-------------------+-------+
		1 row in set (0.00 sec)


		
		
	4. sql_thread卡在哪里
	
	1. 根据 Master_Log_File: mysql-bin.000017,  Exec_Master_Log_Pos/end_log_pos 50398187  ; 这个去主库上去解析binlog
		[root@env27 logs]# mysqlbinlog -vv --base64-output=decode-rows --stop-position=50398187 mysql-bin.000017 > 1.sql


	2. 根据 Relay_Log_File: relay-bin.000042  Relay_Log_Pos:50398400 去从库上找：

		[root@env29 data]# mysqlbinlog -vv --base64-output=decode-rows --start-position=50398400 relay-bin.000042 > 2.sq

	3. select * from information_schema.innodb_trx\G; --查看正在执行中的事务。
	
	4. 查看主库的慢日志	
		
		


mysql> show create table niuniuh5_db.table_web_loginlog_debug\G;
*************************** 1. row ***************************
       Table: table_web_loginlog_debug
Create Table: CREATE TABLE `table_web_loginlog_debug` (
  `nPlayerId` int(11) NOT NULL,
  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
  `szNickName` varchar(64) DEFAULT NULL,
  `nAction` int(11) NOT NULL DEFAULT '0',
  `szTime` timestamp NULL DEFAULT NULL,
  `loginIp` varchar(64) DEFAULT NULL,
  `strRe1` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)

mysql> select count(*) from niuniuh5_db.table_web_loginlog_debug;
+----------+
| count(*) |
+----------+
|  5265967 |
+----------+
1 row in set (1.65 sec)


	
