
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
		

相关参考:

	https://dev.mysql.com/doc/refman/5.7/en/replica-logs-relaylog.html
	https://dev.mysql.com/doc/refman/5.7/en/show-relaylog-events.html
	https://dev.mysql.com/doc/refman/5.7/en/replica-logs-status.html	
		
	