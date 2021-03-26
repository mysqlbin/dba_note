
1. 实验目的
2. 实操
3. 验证数据					

1. 实验目的 
	通过把已有Slave伪装成主库并把 binlog server 放到伪装主库的 二进制文件目录，然后把全备恢复到一个新建一个的实例中，通过 start slave until 恢复到误操作之前的位置。
	在Slave手工注册binlog。

2. 实操
		 
2.1 Master 制造数据
		 
	create  database db3 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

	use db3;
	CREATE TABLE `t1` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db3`.`t1`(`id`, `name`, `amount`) VALUES (1, '1', 2); 

	INSERT INTO `db3`.`t1`(`id`, `name`, `amount`) VALUES (2, '1', 2); 

	INSERT INTO `db3`.`t1`(`id`, `name`, `amount`) VALUES (3, '1', 2); 
	
2.2 备库备份数据
	
	innobackupex --defaults-file=/etc/my.cnf  -uroot -p123456abc /data
	
	innobackupex  --apply-log   /data/2020-03-21_10-56-25
	
	# 在这里开始备份数据 并且 应用 apply-log 并且待 apply-log 应用完成后再执行下面的部分
	
	root@localhost [(none)]>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000008
			 Position: 4804
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110680
	1 row in set (0.00 sec)

	ERROR: 
	No query specified


	cat xtrabackup_binlog_info
		
	[root@env29 2020-03-21_12-10-37]# cat xtrabackup_binlog_info
	mysql-bin.000008	4804	f7323d17-6442-11ea-8a77-080027758761:1-110680

2.3 Master 再次制造数据

	从库： flush logs;
	
	Master dump 线程从这里开始把 binlog event 发送给 从库的 IO 线程。 
	
	CREATE TABLE `t2` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `db3`.`t2`(`id`, `name`, `amount`) VALUES (1, '1', 2); 

	INSERT INTO `db3`.`t2`(`id`, `name`, `amount`) VALUES (2, '1', 2); 

	INSERT INTO `db3`.`t2`(`id`, `name`, `amount`) VALUES (3, '1', 2); 
	
2.4 备库 执行  purge binary log to 
	
	flush logs;
	
	root@localhost [(none)]>show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000001 |  27286141 |
	| mysql-bin.000002 |    192181 |
	| mysql-bin.000003 |       217 |
	| mysql-bin.000004 |      8645 |
	| mysql-bin.000005 |       241 |
	| mysql-bin.000006 |       724 |
	| mysql-bin.000007 |       217 |
	| mysql-bin.000008 |      4851 |
	| mysql-bin.000009 |      1408 |
	| mysql-bin.000010 |       241 |
	| mysql-bin.000011 |       194 |
	+------------------+-----------+
	11 rows in set (0.00 sec)
	
	purge binary logs to 'mysql-bin.000011';    # 为了演示把之前删掉的 binlog 放回备库
	
	INSERT INTO `db3`.`t2`(`id`, `name`, `amount`) VALUES (4, '1', 2); 
	
	INSERT INTO `db3`.`t1`(`id`, `name`, `amount`) VALUES (4, '1', 2);     # 最终需要恢复到这里。
	
	
2.5 发起一个误删除数据表操作
	
	drop table db3.t1;  
	
	INSERT INTO `db3`.`t2`(`id`, `name`, `amount`) VALUES (5, '1', 2); 
	
	
	备库
		root@localhost [(none)]>show binary logs;
		+------------------+-----------+
		| Log_name         | File_size |
		+------------------+-----------+
		| mysql-bin.000011 |      1143 |
		+------------------+-----------+
		1 row in set (0.00 sec)
			
	
2.6 恢复步骤
	
	0. 在临时实例恢复全备
		[root@env30 data]# ps aux|grep mysql
		mysql     7694  0.0 18.1 1090680 184800 ?      Sl   Mar20   0:26 /usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf
		root     13423  0.0  0.1 133776  1532 pts/2    S+   02:10   0:00 mysql -uroot -px xxxxxxx
		root     21071  0.0  0.0 112660   976 pts/4    R+   12:37   0:00 grep --color=auto mysql
		
		[root@env30 data]# /etc/init.d/mysql stop
		Shutting down MySQL.. SUCCESS! 
		
		[root@env30 data]# ps aux|grep mysqld
		root     21102  0.0  0.0 112660   976 pts/4    R+   12:38   0:00 grep --color=auto mysqld
			
		root@localhost [(none)]>show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000004
				 Position: 154
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110663
		1 row in set (0.00 sec)

		ERROR: 
		No query specified

		root@localhost [(none)]>show slave status\G;
		Empty set (0.00 sec)


	1. 从备份系统下载 mysql-bin.000008 、 master.000009、mysql-bin.000010 这3个文件，放到备库的日志目录下；
		[root@env29 logs]# ll
		total 24
		-rw-r----- 1 root  root  4851 Mar 21 12:28 mysql-bin.000008
		-rw-r----- 1 root  root  1408 Mar 21 12:28 mysql-bin.000009
		-rw-r----- 1 root  root   241 Mar 21 12:28 mysql-bin.000010
		-rw-r----- 1 mysql mysql 1143 Mar 21 12:24 mysql-bin.000011
		-rw-r----- 1 mysql mysql  176 Mar 
		[root@env29 logs]# chown -R mysql:mysql *
		[root@env29 logs]# ll
		total 24
		-rw-r----- 1 mysql mysql 4851 Mar 21 12:28 mysql-bin.000008
		-rw-r----- 1 mysql mysql 1408 Mar 21 12:28 mysql-bin.000009
		-rw-r----- 1 mysql mysql  241 Mar 21 12:28 mysql-bin.000010
		-rw-r----- 1 mysql mysql 1143 Mar 21 12:24 mysql-bin.000011
		-rw-r----- 1 mysql mysql  176 Mar 21 12:28 mysql-bin.index21 12:28 mysql-bin.index
		
		
	2. 打开日志目录下的 mysql-bin.index 文件，在文件开头加入两行，内容分别是 ./master.000005 和 ./master.000006 ;
		/data/mysql/mysql3306/logs/mysql-bin.000008
		/data/mysql/mysql3306/logs/mysql-bin.000009
		/data/mysql/mysql3306/logs/mysql-bin.000010
		
	3. 重启备库，目的是要让备库重新识别这3个日志文件；
		[root@env29 logs]# /etc/init.d/mysql stop
		Shutting down MySQL............ SUCCESS! 
		[1]+  Done                    mysqlbinlog --raw --read-from-remote-server --host 192.168.1.29 --port 3306 --stop-never -ubinlog_server_user -p123456abc mysql-bin.000001  (wd: /data/backup)
		(wd now: /data/mysql/mysql3306/logs)
		
		[root@env29 logs]# /etc/init.d/mysql start
		Starting MySQL... SUCCESS!
		
		同时也可以看看错误日志有没有异常
		
		root@localhost [(none)]>show binary logs;
		+------------------+-----------+
		| Log_name         | File_size |
		+------------------+-----------+
		| mysql-bin.000008 |      4851 |
		| mysql-bin.000009 |      1408 |
		| mysql-bin.000010 |       241 |
		| mysql-bin.000011 |      1166 |
		| mysql-bin.000012 |       194 |
		+------------------+-----------+
		5 rows in set (0.00 sec)

	
	4. 再检查一下上面的步骤 
	
	
	5. 现在这个备库上就有了临时库需要的所有 binlog 了，建立主备关系，就可以正常同步了。
		
		#200321 12:24:54 server id 273306  end_log_pos 773 CRC32 0x303b063d 	GTID	last_committed=2	sequence_number=3	rbr_only=no
		SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110687'/*!*/;
		# at 773
		#200321 12:24:54 server id 273306  end_log_pos 886 CRC32 0x09001c7a 	Query	thread_id=80	exec_time=0	error_code=0
		use `db3`/*!*/;
		SET TIMESTAMP=1584764694/*!*/;
		SET @@session.sql_mode=1436549152/*!*/;
		DROP TABLE `t1` /* generated by server */
		/*!*/;
		# at 886
		
		----------------------------------------------------------------------------------------------------------------------------------
		reset master; \
		
		set global gtid_purged = 'f7323d17-6442-11ea-8a77-080027758761:1-110680'; \
		
		change master to master_host='192.168.1.29',master_user='repl',master_password='123456abc',master_port=3306,master_auto_position=1; \
		
		-- 只恢复db3库的 t1表。
		change replication filter replicate_do_table = (db3.t1); \
		
		start slave until SQL_BEFORE_GTIDS = 'f7323d17-6442-11ea-8a77-080027758761:110687'; 
		
		show slave status\G;
		
		
		
		详细如下：
			root@localhost [(none)]>reset master; \
			ERROR 2006 (HY000): MySQL server has gone away
			No connection. Trying to reconnect...
			Connection id:    4
			Current database: *** NONE ***

			Query OK, 0 rows affected (0.02 sec)

			root@localhost [(none)]>
			root@localhost [(none)]>set global gtid_purged = 'f7323d17-6442-11ea-8a77-080027758761:1-110680'; \
			Query OK, 0 rows affected (0.00 sec)

			root@localhost [(none)]>
			root@localhost [(none)]>change master to master_host='192.168.1.29',master_user='repl',master_password='123456abc',master_port=3306,master_auto_position=1; \
			Query OK, 0 rows affected, 2 warnings (0.05 sec)

			root@localhost [(none)]>
			root@localhost [(none)]>change replication filter replicate_do_table = (db3.t1); \
			Query OK, 0 rows affected (0.00 sec)

			root@localhost [(none)]>
			root@localhost [(none)]>start slave until SQL_BEFORE_GTIDS = 'f7323d17-6442-11ea-8a77-080027758761:110687'; \
			Query OK, 0 rows affected (0.00 sec)

			root@localhost [(none)]>
			root@localhost [(none)]>show slave status\G;
			*************************** 1. row ***************************
						   Slave_IO_State: Connecting to master
							  Master_Host: 192.168.1.29
							  Master_User: repl
							  Master_Port: 3306
							Connect_Retry: 60
						  Master_Log_File: 
					  Read_Master_Log_Pos: 4
						   Relay_Log_File: relay-bin.000001
							Relay_Log_Pos: 4
					Relay_Master_Log_File: 
						 Slave_IO_Running: Connecting
						Slave_SQL_Running: Yes
						  Replicate_Do_DB: 
					  Replicate_Ignore_DB: 
					   Replicate_Do_Table: db3.t1
				   Replicate_Ignore_Table: 
				  Replicate_Wild_Do_Table: 
			  Replicate_Wild_Ignore_Table: 
							   Last_Errno: 0
							   Last_Error: 
							 Skip_Counter: 0
					  Exec_Master_Log_Pos: 0
						  Relay_Log_Space: 154
						  Until_Condition: SQL_BEFORE_GTIDS
						   Until_Log_File: 
							Until_Log_Pos: 0
					   Master_SSL_Allowed: No
					   Master_SSL_CA_File: 
					   Master_SSL_CA_Path: 
						  Master_SSL_Cert: 
						Master_SSL_Cipher: 
						   Master_SSL_Key: 
					Seconds_Behind_Master: 0
			Master_SSL_Verify_Server_Cert: No
							Last_IO_Errno: 0
							Last_IO_Error: 
						   Last_SQL_Errno: 0
						   Last_SQL_Error: 
			  Replicate_Ignore_Server_Ids: 
						 Master_Server_Id: 0
							  Master_UUID: 
						 Master_Info_File: /data/mysql/mysql3306/data/master.info
								SQL_Delay: 0
					  SQL_Remaining_Delay: NULL
				  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
					   Master_Retry_Count: 86400
							  Master_Bind: 
				  Last_IO_Error_Timestamp: 
				 Last_SQL_Error_Timestamp: 
						   Master_SSL_Crl: 
					   Master_SSL_Crlpath: 
					   Retrieved_Gtid_Set: 
						Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110680
							Auto_Position: 1
					 Replicate_Rewrite_DB: 
							 Channel_Name: 
					   Master_TLS_Version: 
			1 row in set (0.01 sec)

			ERROR: 
			No query specified

			root@localhost [(none)]>start slave until SQL_BEFORE_GTIDS = 'f7323d17-6442-11ea-8a77-080027758761:110687';
			Query OK, 0 rows affected (0.04 sec)

			root@localhost [(none)]>show slave status\G;
			*************************** 1. row ***************************
						   Slave_IO_State: Waiting for master to send event
							  Master_Host: 192.168.1.29
							  Master_User: repl
							  Master_Port: 3306
							Connect_Retry: 60
						  Master_Log_File: mysql-bin.000012
					  Read_Master_Log_Pos: 194
						   Relay_Log_File: relay-bin.000006
							Relay_Log_Pos: 921
					Relay_Master_Log_File: mysql-bin.000011
						 Slave_IO_Running: Yes
						Slave_SQL_Running: No
						  Replicate_Do_DB: 
					  Replicate_Ignore_DB: 
					   Replicate_Do_Table: db3.t1
				   Replicate_Ignore_Table: 
				  Replicate_Wild_Do_Table: 
			  Replicate_Wild_Ignore_Table: 
							   Last_Errno: 0
							   Last_Error: 
							 Skip_Counter: 0
					  Exec_Master_Log_Pos: 708
						  Relay_Log_Space: 2098
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
						 Master_Server_Id: 293306
							  Master_UUID: 89f12dce-6828-11ea-9c33-080027fc8003
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
					   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:110681-110688
						Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110686
							Auto_Position: 1
					 Replicate_Rewrite_DB: 
							 Channel_Name: 
					   Master_TLS_Version: 
			1 row in set (0.00 sec)

			ERROR: 
			No query specified

			
3. 验证数据					
	root@localhost [(none)]>select * from db3.t1;
	+----+------+--------+
	| id | name | amount |
	+----+------+--------+
	|  1 | 1    |      2 |
	|  2 | 1    |      2 |
	|  3 | 1    |      2 |
	|  4 | 1    |      2 |
	+----+------+--------+
	4 rows in set (0.00 sec)	

	root@localhost [(none)]>select * from `db3`.`t2`;
	ERROR 1146 (42S02): Table 'db3.t2' doesn't exist
	
	