
mysql> show global variables like '%relay%';
+---------------------------+-----------------------------------------+
| Variable_name             | Value                                   |
+---------------------------+-----------------------------------------+
| max_relay_log_size        | 0                                       |
| relay_log                 |                                         |
| relay_log_basename        | /data_volume/mysql/db-b-relay-bin       |
| relay_log_index           | /data_volume/mysql/db-b-relay-bin.index |
| relay_log_info_file       | relay-log.info                          |
| relay_log_info_repository | TABLE                                   |
| relay_log_purge           | ON                                      |
| relay_log_recovery        | OFF                                     |
| relay_log_space_limit     | 0                                       |
| sync_relay_log            | 10000                                   |
| sync_relay_log_info       | 10000                                   |
+---------------------------+-----------------------------------------+
11 rows in set (0.00 sec)

副本服务器在以下情况下创建一个新的中继日志文件：

	每次复制I/O线程启动。

	刷新日志时（例如，使用FLUSH LOGS或mysqladmin flush-logs）。

	当当前中继日志文件的大小太大时，确定如下：
	
		如果 max_relay_log_size 的值大于0，则这是最大中继日志文件大小。

		如果 max_relay_log_size 的值为0，则 max_binlog_size 确定最大中继日志文件大小。


复制SQL线程在执行每个中继日志文件中的所有事件并且不再需要该文件后，会自动删除该文件。
没有删除中继日志的显式机制，因为复制SQL线程会这样做。但是，FLUSH LOGS旋转中继日志，这会影响复制SQL线程删除它们的时间。

每次复制I/O线程启动
	shell> ll
	-rw-r-----. 1 mysql mysql        211 10月 19 12:01 localhost-relay-bin.000001
	-rw-r-----. 1 mysql mysql       4226 10月 19 15:22 localhost-relay-bin.000002
	-rw-r-----. 1 mysql mysql         58 10月 19 12:01 localhost-relay-bin.index

	mysql> stop slave;
	Query OK, 0 rows affected (0.03 sec)

	mysql> start slave;
	Query OK, 0 rows affected (0.04 sec)

	shell> ll
	-rw-r-----. 1 mysql mysql       4283 10月 19 18:30 localhost-relay-bin.000002
	-rw-r-----. 1 mysql mysql        454 10月 19 18:30 localhost-relay-bin.000003
	-rw-r-----. 1 mysql mysql         58 10月 19 18:30 localhost-relay-bin.index

-----------------------------------------------------------------------------


flush logs
	shell> ll
	-rw-r-----. 1 mysql mysql       4283 10月 19 18:30 localhost-relay-bin.000002
	-rw-r-----. 1 mysql mysql        454 10月 19 18:30 localhost-relay-bin.000003
	-rw-r-----. 1 mysql mysql         58 10月 19 18:30 localhost-relay-bin.index

	mysql> flush logs;
	Query OK, 0 rows affected (0.09 sec)

	shell> ll
	-rw-r-----. 1 mysql mysql        511 10月 19 18:32 localhost-relay-bin.000003
	-rw-r-----. 1 mysql mysql        313 10月 19 18:32 localhost-relay-bin.000004
	-rw-r-----. 1 mysql mysql         58 10月 19 18:32 localhost-relay-bin.index



2.5 判断是否需要切换和清理relay log
	
	如果发现 relay log 已满， 则需要进行切换。
	如果这个 evnet 并不是事务的结束，那么是不能切换的，因此常规情况下  relay log 和 binary log 一样是不能跨事务的
	
	参数 relay_log_recovery = 0 并且从库异常重启的场景下 relay log 可能出现跨事务的情况：
		1. gtid auto_position mode 模式下可能会出现 partial transaction, 会造成额外的回滚操作
		2. position mode           模式下会继续发送事务余下的部分的 event 
		
	relay_log_recovery = on:
		如果读取完了一个非当前 relay log 的 event 会进行清理流程
		如果读取完了当前 relay log， 则不能清理，会等待 IO 线程的唤醒，如果是 MTS 等待唤醒期间还需要进行 MTS 的检查点
		

	mysql> show global variables like '%relay%';
	+---------------------------+-----------------------------------------+
	| Variable_name             | Value                                   |
	+---------------------------+-----------------------------------------+
	| max_relay_log_size        | 0                                       |
	| relay_log                 |                                         |
	| relay_log_basename        | /data_volume/mysql/db-b-relay-bin       |
	| relay_log_index           | /data_volume/mysql/db-b-relay-bin.index |
	| relay_log_info_file       | relay-log.info                          |
	| relay_log_info_repository | TABLE                                   |
	| relay_log_purge           | ON                                      |
	| relay_log_recovery        | OFF                                     |
	| relay_log_space_limit     | 0                                       |
	| sync_relay_log            | 10000                                   |
	| sync_relay_log_info       | 10000                                   |
	+---------------------------+-----------------------------------------+
	11 rows in set (0.00 sec)
	
	-rw-r-----  1 mysql mysql  400778593 Jan 18 07:38 db-b-relay-bin.000098
	-rw-r-----  1 mysql mysql   71807789 May 11 10:25 db-b-relay-bin.000099
	-rw-r-----  1 mysql mysql         48 Jan 18 07:38 db-b-relay-bin.index
	
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.1.10
					  Master_User: repl_user
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000270
			  Read_Master_Log_Pos: 71807576
				   Relay_Log_File: db-b-relay-bin.000099
					Relay_Log_Pos: 71807789
			Relay_Master_Log_File: mysql-bin.000270
				 Slave_IO_Running: Yes
				Slave_SQL_Running: Yes
			  Exec_Master_Log_Pos: 71807576
				  Relay_Log_Space: 472586382 
			Seconds_Behind_Master: 0
					  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-2731764
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-2731764,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1005032
					Auto_Position: 1 
	1 row in set (0.00 sec)




相关参考:

	https://dev.mysql.com/doc/refman/5.7/en/replica-logs-relaylog.html
	https://dev.mysql.com/doc/refman/5.7/en/show-relaylog-events.html
	https://dev.mysql.com/doc/refman/5.7/en/replica-logs-status.html	
		
	