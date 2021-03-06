


1. innobackupex --defaults-file=/etc/my.cnf  -uroot -p123456abc /data/backup/
	# 输出日志，参考 《innobackupex.log》
2. innobackupex    --apply-log   /data/backup/2020-03-15_19-46-09

3. xtrabackup_binlog_info 和 xtrabackup_binlog_pos_innodb 记录的二进制信息不一样


1. innobackupex --defaults-file=/etc/my.cnf  -uroot -p123456abc /data/backup/
	
	# 输出日志，参考 《innobackupex.log》

	查看备份的信息
	[root@env backup]# ll
	total 8204
	drwxr-x--- 8 root root     272 Mar 15 19:50 2020-03-15_19-46-09
	-rw-r--r-- 1 root root 8399944 Mar 17  2020 percona-xtrabackup-24-2.4.9-1.el6.x86_64.rpm
	[root@env backup]# cd 2020-03-15_19-46-09/
	[root@env 2020-03-15_19-46-09]# ll
	total 1806396
	-rw-r----- 1 root root        431 Mar 15 19:50 backup-my.cnf
	-rw-r----- 1 root root       1034 Mar 15 19:50 ib_buffer_pool
	-rw-r----- 1 root root 1849688064 Mar 15 19:49 ibdata1
	drwxr-x--- 2 root root       4096 Mar 15 19:50 mysql
	drwxr-x--- 2 root root       8192 Mar 15 19:50 performance_schema
	drwxr-x--- 2 root root        126 Mar 15 19:50 repl_monitor
	drwxr-x--- 2 root root       8192 Mar 15 19:50 sys
	drwxr-x--- 2 root root       4096 Mar 15 19:50 terrace_db
	-rw-r----- 1 root root         64 Mar 15 19:50 xtrabackup_binlog_info
	-rw-r----- 1 root root        121 Mar 15 19:50 xtrabackup_checkpoints
	-rw-r----- 1 root root        563 Mar 15 19:50 xtrabackup_info
	-rw-r----- 1 root root       2560 Mar 15 19:50 xtrabackup_logfile
	drwxr-x--- 2 root root       4096 Mar 15 19:50 zst


	[root@env 2020-03-15_19-46-09]# cat backup-my.cnf
	# This MySQL options file was generated by innobackupex.

	# The MySQL server
	[mysqld]
	innodb_checksum_algorithm=crc32
	innodb_log_checksum_algorithm=strict_crc32
	innodb_data_file_path=ibdata1:100M:autoextend
	innodb_log_files_in_group=3
	innodb_log_file_size=104857600
	innodb_fast_checksum=false
	innodb_page_size=16384
	innodb_log_block_size=512
	innodb_undo_directory=./
	innodb_undo_tablespaces=0
	server_id=273306

	redo_log_version=1



	[root@env 2020-03-15_19-46-09]# cat xtrabackup_binlog_info
	mysql-bin.000002	2696	f7323d17-6442-11ea-8a77-080027758761:1-14


	[root@env 2020-03-15_19-46-09]# cat  xtrabackup_checkpoints
	backup_type = full-backuped
	from_lsn = 0
	to_lsn = 18238654358         #  备份文件 最后一次 checkpoint 的 LSN
	last_lsn = 18238654367       #  备份文件 最新的 LSN
	compact = 0
	recover_binlog_info = 0

		
	[root@env 2020-03-15_19-46-09]# cat xtrabackup_info
	uuid = 2a603a77-66b3-11ea-adbe-080027758761
	name = 
	tool_name = innobackupex
	tool_command = --defaults-file=/etc/my.cnf -uroot -p123456abc /data/backup/
	tool_version = 2.4.9
	ibbackup_version = 2.4.9
	server_version = 5.7.19-log
	start_time = 2020-03-15 19:46:16
	end_time = 2020-03-15 19:50:28
	lock_time = 0
	binlog_pos = filename 'mysql-bin.000002', position '2696', GTID of the last change 'f7323d17-6442-11ea-8a77-080027758761:1-14'
	innodb_from_lsn = 0
	innodb_to_lsn = 18238654358
	partial = N
	incremental = N
	format = file
	compact = N
	compressed = N
	encrypted = N
	

2. innobackupex    --apply-log   /data/backup/2020-03-15_19-46-09


	[root@env backup]# innobackupex    --apply-log   /data/backup/2020-03-15_19-46-09
	200315 20:06:38 innobackupex: Starting the apply-log operation

	IMPORTANT: Please check that the apply-log run completes successfully.
			   At the end of a successful apply-log run innobackupex
			   prints "completed OK!".

	innobackupex version 2.4.9 based on MySQL server 5.7.13 Linux (x86_64) (revision id: a467167cdd4)
	xtrabackup: cd to /data/backup/2020-03-15_19-46-09/
	xtrabackup: This target seems to be not prepared yet.
	InnoDB: Number of pools: 1
	xtrabackup: xtrabackup_logfile detected: size=8388608, start_lsn=(18238654358)
	xtrabackup: using the following InnoDB configuration for recovery:
	xtrabackup:   innodb_data_home_dir = .
	xtrabackup:   innodb_data_file_path = ibdata1:100M:autoextend
	xtrabackup:   innodb_log_group_home_dir = .
	xtrabackup:   innodb_log_files_in_group = 1
	xtrabackup:   innodb_log_file_size = 8388608
	xtrabackup: using the following InnoDB configuration for recovery:
	xtrabackup:   innodb_data_home_dir = .
	xtrabackup:   innodb_data_file_path = ibdata1:100M:autoextend
	xtrabackup:   innodb_log_group_home_dir = .
	xtrabackup:   innodb_log_files_in_group = 1
	xtrabackup:   innodb_log_file_size = 8388608
	xtrabackup: Starting InnoDB instance for recovery.
	xtrabackup: Using 104857600 bytes for buffer pool (set by --use-memory parameter)
	InnoDB: PUNCH HOLE support available
	InnoDB: Mutexes and rw_locks use GCC atomic builtins
	InnoDB: Uses event mutexes
	InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
	InnoDB: Compressed tables use zlib 1.2.3
	InnoDB: Number of pools: 1
	InnoDB: Using CPU crc32 instructions
	InnoDB: Initializing buffer pool, total size = 100M, instances = 1, chunk size = 100M
	InnoDB: Completed initialization of buffer pool
	InnoDB: page_cleaner coordinator priority: -20
	InnoDB: Highest supported file format is Barracuda.
	InnoDB: Log scan progressed past the checkpoint lsn 18238654358
	InnoDB: Doing recovery: scanned up to log sequence number 18238654367 (0%)
	InnoDB: Doing recovery: scanned up to log sequence number 18238654367 (0%)
	InnoDB: Database was not shutdown normally!
	InnoDB: Starting crash recovery.
	InnoDB: xtrabackup: Last MySQL binlog file position 1504, file name mysql-bin.000002
	InnoDB: Creating shared tablespace for temporary tables
	InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
	InnoDB: File './ibtmp1' size is now 12 MB.
	InnoDB: 96 redo rollback segment(s) found. 1 redo rollback segment(s) are active.
	InnoDB: 32 non-redo rollback segment(s) are active.
	InnoDB: Waiting for purge to start
	InnoDB: 5.7.13 started; log sequence number 18238654367
	InnoDB: xtrabackup: Last MySQL binlog file position 1504, file name mysql-bin.000002

	xtrabackup: starting shutdown with innodb_fast_shutdown = 1
	InnoDB: FTS optimize thread exiting.
	InnoDB: Starting shutdown...
	InnoDB: Shutdown completed; log sequence number 18238654679
	InnoDB: Number of pools: 1
	xtrabackup: using the following InnoDB configuration for recovery:
	xtrabackup:   innodb_data_home_dir = .
	xtrabackup:   innodb_data_file_path = ibdata1:100M:autoextend
	xtrabackup:   innodb_log_group_home_dir = .
	xtrabackup:   innodb_log_files_in_group = 3
	xtrabackup:   innodb_log_file_size = 104857600
	InnoDB: PUNCH HOLE support available
	InnoDB: Mutexes and rw_locks use GCC atomic builtins
	InnoDB: Uses event mutexes
	InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
	InnoDB: Compressed tables use zlib 1.2.3
	InnoDB: Number of pools: 1
	InnoDB: Using CPU crc32 instructions
	InnoDB: Initializing buffer pool, total size = 100M, instances = 1, chunk size = 100M
	InnoDB: Completed initialization of buffer pool
	InnoDB: page_cleaner coordinator priority: -20
	InnoDB: Setting log file ./ib_logfile101 size to 100 MB
	InnoDB: Progress in MB:
	 100
	InnoDB: Setting log file ./ib_logfile1 size to 100 MB
	InnoDB: Progress in MB:
	 100
	InnoDB: Setting log file ./ib_logfile2 size to 100 MB
	InnoDB: Progress in MB:
	 100
	InnoDB: Renaming log file ./ib_logfile101 to ./ib_logfile0
	InnoDB: New log files created, LSN=18238654679
	InnoDB: Highest supported file format is Barracuda.
	InnoDB: Log scan progressed past the checkpoint lsn 18238654988
	InnoDB: Doing recovery: scanned up to log sequence number 18238654997 (0%)
	InnoDB: Doing recovery: scanned up to log sequence number 18238654997 (0%)
	InnoDB: Database was not shutdown normally!
	InnoDB: Starting crash recovery.
	InnoDB: xtrabackup: Last MySQL binlog file position 1504, file name mysql-bin.000002
	InnoDB: Removed temporary tablespace data file: "ibtmp1"
	InnoDB: Creating shared tablespace for temporary tables
	InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
	InnoDB: File './ibtmp1' size is now 12 MB.
	InnoDB: 96 redo rollback segment(s) found. 1 redo rollback segment(s) are active.
	InnoDB: 32 non-redo rollback segment(s) are active.
	InnoDB: Waiting for purge to start
	InnoDB: 5.7.13 started; log sequence number 18238654997
	xtrabackup: starting shutdown with innodb_fast_shutdown = 1
	InnoDB: FTS optimize thread exiting.
	InnoDB: Starting shutdown...
	InnoDB: Shutdown completed; log sequence number 18238655016
	200315 20:06:43 completed OK!


	[root@env backup]# ll
	total 8208
	drwxr-x--- 8 root root    4096 Mar 15 20:06 2020-03-15_19-46-09
	-rw-r--r-- 1 root root 8399944 Mar 17  2020 percona-xtrabackup-24-2.4.9-1.el6.x86_64.rpm
	[root@env backup]# cd 2020-03-15_19-46-09/
	[root@env 2020-03-15_19-46-09]# ll
	total 2134076
	-rw-r----- 1 root root        431 Mar 15 19:50 backup-my.cnf
	-rw-r----- 1 root root       1034 Mar 15 19:50 ib_buffer_pool
	-rw-r----- 1 root root 1849688064 Mar 15 20:06 ibdata1
	-rw-r----- 1 root root  104857600 Mar 15 20:06 ib_logfile0
	-rw-r----- 1 root root  104857600 Mar 15 20:06 ib_logfile1
	-rw-r----- 1 root root  104857600 Mar 15 20:06 ib_logfile2
	-rw-r----- 1 root root   12582912 Mar 15 20:06 ibtmp1
	drwxr-x--- 2 root root       4096 Mar 15 19:50 mysql
	drwxr-x--- 2 root root       8192 Mar 15 19:50 performance_schema
	drwxr-x--- 2 root root        126 Mar 15 19:50 repl_monitor
	drwxr-x--- 2 root root       8192 Mar 15 19:50 sys
	drwxr-x--- 2 root root       4096 Mar 15 19:50 terrace_db
	-rw-r----- 1 root root         64 Mar 15 19:50 xtrabackup_binlog_info
	-rw-r--r-- 1 root root         22 Mar 15 20:06 xtrabackup_binlog_pos_innodb
	-rw-r----- 1 root root        121 Mar 15 20:06 xtrabackup_checkpoints
	-rw-r----- 1 root root        563 Mar 15 19:50 xtrabackup_info
	-rw-r----- 1 root root    8388608 Mar 15 20:06 xtrabackup_logfile
	drwxr-x--- 2 root root       4096 Mar 15 19:50 zst
	[root@env 2020-03-15_19-46-09]# cat backup-my.cnf 
	# This MySQL options file was generated by innobackupex.

	# The MySQL server
	[mysqld]
	innodb_checksum_algorithm=crc32
	innodb_log_checksum_algorithm=strict_crc32
	innodb_data_file_path=ibdata1:100M:autoextend
	innodb_log_files_in_group=3
	innodb_log_file_size=104857600
	innodb_fast_checksum=false
	innodb_page_size=16384
	innodb_log_block_size=512
	innodb_undo_directory=./
	innodb_undo_tablespaces=0
	server_id=273306

	redo_log_version=1

	[root@env 2020-03-15_19-46-09]# cat xtrabackup_binlog_info
	mysql-bin.000002	2696	f7323d17-6442-11ea-8a77-080027758761:1-14
	[root@env 2020-03-15_19-46-09]# cat xtrabackup_binlog_pos_innodb
	mysql-bin.000002	1504
	
	[root@env 2020-03-15_19-46-09]# cat xtrabackup_checkpoints
	backup_type = full-prepared
	from_lsn = 0
	to_lsn = 18238654358
	last_lsn = 18238654367
	compact = 0
	recover_binlog_info = 0
	[root@env 2020-03-15_19-46-09]# cat xtrabackup_info
	uuid = 2a603a77-66b3-11ea-adbe-080027758761
	name = 
	tool_name = innobackupex
	tool_command = --defaults-file=/etc/my.cnf -uroot -p123456abc /data/backup/
	tool_version = 2.4.9
	ibbackup_version = 2.4.9
	server_version = 5.7.19-log
	start_time = 2020-03-15 19:46:16
	end_time = 2020-03-15 19:50:28
	lock_time = 0
	binlog_pos = filename 'mysql-bin.000002', position '2696', GTID of the last change 'f7323d17-6442-11ea-8a77-080027758761:1-14'
	innodb_from_lsn = 0
	innodb_to_lsn = 18238654358
	partial = N
	incremental = N
	format = file
	compact = N
	compressed = N
	encrypted = N

	
3. xtrabackup_binlog_info 和 xtrabackup_binlog_pos_innodb 记录的二进制信息不一样
	 
	[root@env 2020-03-15_19-46-09]# cat xtrabackup_binlog_info
	mysql-bin.000002	2696	f7323d17-6442-11ea-8a77-080027758761:1-14
	
	[root@env 2020-03-15_19-46-09]# cat xtrabackup_binlog_pos_innodb
	mysql-bin.000002	1504
	
	xtrabackup_binlog_info        表示 通过 show master status; 获取。
	xtrabackup_binlog_pos_innodb  表示 通过 redo last commit（最后一次） 提交对应的 二进制信息 获取。

	
	mysqlbinlog -vv --base64-output='decode-rows' --stop-position=2696 mysql-bin.000002 > 2696.sql
	
	mysqlbinlog -vv --base64-output='decode-rows' --stop-position=1504 mysql-bin.000002 > 1504.sql
		
		# at 1243
		#200315 13:04:32 server id 273306  end_log_pos 1308 CRC32 0x1f26e9a1 	GTID	last_committed=4	sequence_number=5	rbr_only=yes
		/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
		SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:11'/*!*/;
		# at 1308
		#200315 13:04:32 server id 273306  end_log_pos 1379 CRC32 0x10ddd0c1 	Query	thread_id=71	exec_time=0	error_code=0
		SET TIMESTAMP=1584248672/*!*/;
		BEGIN
		/*!*/;
		# at 1379
		#200315 13:04:32 server id 273306  end_log_pos 1425 CRC32 0x2a129731 	Table_map: `zst`.`t` mapped to number 494
		# at 1425
		#200315 13:04:32 server id 273306  end_log_pos 1473 CRC32 0x95764059 	Delete_rows: table id 494 flags: STMT_END_F
		### DELETE FROM `zst`.`t`
		### WHERE
		###   @1=2 /* INT meta=0 nullable=0 is_null=0 */
		###   @2=2 /* INT meta=0 nullable=1 is_null=0 */
		###   @3=1584248500 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
		# at 1473
		#200315 13:04:32 server id 273306  end_log_pos 1504 CRC32 0xabf8ab77 	Xid = 3389
		COMMIT/*!*/;
		# at 1504
		#200315 13:20:06 server id 273306  end_log_pos 1569 CRC32 0x1a75210b 	GTID	last_committed=5	sequence_number=6	rbr_only=no
		SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:12'/*!*/;
		# at 1569
		#200315 13:20:06 server id 273306  end_log_pos 1850 CRC32 0xe98be48a 	Query	thread_id=80	exec_time=0	error_code=0
		use `zst`/*!*/;
		SET TIMESTAMP=1584249606/*!*/;
		CREATE TABLE `a` (
		  `t1` varchar(10) DEFAULT NULL,
		  `t2` varchar(10) DEFAULT NULL,
		  `t3` char(10) DEFAULT NULL,
		  `t4` varchar(10) DEFAULT NULL
		) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT
		/*!*/;
		# at 1850
		#200315 13:20:14 server id 273306  end_log_pos 1915 CRC32 0x86b7948a 	GTID	last_committed=6	sequence_number=7	rbr_only=yes
		/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
		SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:13'/*!*/;
		# at 1915
		#200315 13:20:14 server id 273306  end_log_pos 1986 CRC32 0x3c9f9381 	Query	thread_id=81	exec_time=0	error_code=0
		SET TIMESTAMP=1584249614/*!*/;
		BEGIN
		/*!*/;
		# at 1986
		#200315 13:20:14 server id 273306  end_log_pos 2040 CRC32 0xf169357f 	Table_map: `zst`.`a` mapped to number 503
		# at 2040
		#200315 13:20:14 server id 273306  end_log_pos 2084 CRC32 0x2f4a7c50 	Write_rows: table id 503 flags: STMT_END_F
		### INSERT INTO `zst`.`a`
		### SET
		###   @1='1' /* VARSTRING(10) meta=10 nullable=1 is_null=0 */
		###   @2='1' /* VARSTRING(10) meta=10 nullable=1 is_null=0 */
		###   @3='1' /* STRING(10) meta=65034 nullable=1 is_null=0 */
		###   @4='1' /* VARSTRING(10) meta=10 nullable=1 is_null=0 */
		# at 2084
		#200315 13:20:14 server id 273306  end_log_pos 2156 CRC32 0x2e3bf9ec 	Query	thread_id=81	exec_time=0	error_code=0
		SET TIMESTAMP=1584249614/*!*/;
		COMMIT
		/*!*/;
		# at 2156
		#200315 13:20:40 server id 273306  end_log_pos 2221 CRC32 0x664fd1e1 	GTID	last_committed=7	sequence_number=8	rbr_only=no
		SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:14'/*!*/;
		# at 2221
		#200315 13:20:40 server id 273306  end_log_pos 2696 CRC32 0x578570ed 	Query	thread_id=83	exec_time=0	error_code=0
		SET TIMESTAMP=1584249640/*!*/;
		SET @@session.explicit_defaults_for_timestamp=0/*!*/;
		CREATE TABLE `t2020` (
		  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
		  `tableid` int(11) NOT NULL,
		  `playerid` int(11) NOT NULL,
		  `szEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`),
		  KEY `idx_szEndTime` (`szEndTime`),
		  KEY `idx_playerid` (`playerid`)
		) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4
		/*!*/;
		SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
		DELIMITER ;
		# End of log file
		
	
	可以发现: 
		start-position = 1504 and stop-position = 2696 之间的是操作 MyISAM 表数据 的位点.
		end-position = 1504 是最后一次操作 InnoDB 表数据的位点.
	
	因此,  要用 xtrabackup_binlog_info 文件 中的位点信息或者 GTID 做主从复制.
	
	主从一致性校验:
		[root@env data]# python replication-consitent-check.py 
		\            TS ERRORS  DIFFS     ROWS  CHUNKS SKIPPED    TIME TABLE
		03-16T13:34:46      0      0        0       1       0   0.011 mysql.columns_priv
		03-16T13:34:46      0      0        2       1       0   0.018 mysql.db
		03-16T13:34:46      0      0        2       1       0   0.027 mysql.engine_cost
		03-16T13:34:46      0      0        0       1       0   0.028 mysql.event
		03-16T13:34:46      0      0        0       1       0   0.026 mysql.func
		03-16T13:34:46      0      0        1       1       0   0.024 mysql.gtid_executed
		03-16T13:34:46      0      0       40       1       0   0.026 mysql.help_category
		03-16T13:34:46      0      0      686       1       0   0.032 mysql.help_keyword
		03-16T13:34:46      0      0     1371       1       0   0.023 mysql.help_relation
		03-16T13:34:46      0      0      637       1       0   0.032 mysql.help_topic
		03-16T13:34:46      0      0        0       1       0   0.022 mysql.ndb_binlog_index
		03-16T13:34:46      0      0        2       1       0   0.034 mysql.plugin
		03-16T13:34:46      0      0       50       1       0   0.023 mysql.proc
		03-16T13:34:46      0      0        0       1       0   0.028 mysql.procs_priv
		03-16T13:34:46      0      0        1       1       0   0.026 mysql.proxies_priv
		03-16T13:34:46      0      0        6       1       0   0.029 mysql.server_cost
		03-16T13:34:46      0      0        0       1       0   0.024 mysql.servers
		03-16T13:34:46      0      0        2       1       0   0.025 mysql.tables_priv
		03-16T13:34:46      0      0        0       1       0   0.027 mysql.time_zone
		03-16T13:34:46      0      0        0       1       0   0.030 mysql.time_zone_leap_second
		03-16T13:34:46      0      0        0       1       0   0.021 mysql.time_zone_name
		03-16T13:34:46      0      0        0       1       0   0.030 mysql.time_zone_transition
		03-16T13:34:47      0      0        0       1       0   0.029 mysql.time_zone_transition_type
		03-16T13:34:47      0      0        8       1       0   0.032 mysql.user
		03-16T13:34:47      0      0       57       1       0   0.028 repl_monitor.master_statment
		03-16T13:34:47      0      0       57       1       0   0.047 repl_monitor.slave_statment
		03-16T13:34:47      0      0        6       1       0   0.033 sys.sys_config
		03-16T13:34:47      0      0        0       1       0   0.026 terrace_db.auth_group
		03-16T13:34:47      0      0        0       1       0   0.036 terrace_db.auth_group_permissions
		03-16T13:34:47      0      0       96       1       0   0.028 terrace_db.auth_permission
		03-16T13:34:47      0      0        4       1       0   0.021 terrace_db.auth_user
		03-16T13:34:47      0      0        0       1       0   0.028 terrace_db.auth_user_groups
		03-16T13:34:47      0      0        0       1       0   0.026 terrace_db.auth_user_user_permissions
		03-16T13:34:47      0      0       38       1       0   0.033 terrace_db.django_admin_log
		03-16T13:34:47      0      0        0       1       0   0.022 terrace_db.django_celery_results_taskresult
		03-16T13:34:47      0      0       23       1       0   0.029 terrace_db.django_content_type
		03-16T13:34:47      0      0       44       1       0   0.028 terrace_db.django_migrations
		03-16T13:34:47      0      0        0       1       0   0.027 terrace_db.django_q_ormq
		03-16T13:34:47      0      0        0       1       0   0.028 terrace_db.django_q_schedule
		03-16T13:34:47      0      0        0       1       0   0.041 terrace_db.django_q_task
		03-16T13:34:47      0      0       18       1       0   0.036 terrace_db.django_session
		03-16T13:34:47      0      0        5       1       0   0.032 terrace_db.myapp_db_instance
		03-16T13:34:47      0      0        7       1       0   0.032 terrace_db.myapp_db_name
		03-16T13:34:47      0      0        0       1       0   0.023 terrace_db.myapp_oper_log
		03-16T13:34:47      0      0        0       1       0   0.026 terrace_db.myapp_permission
		03-16T13:34:47      0      0        0       1       0   0.027 terrace_db.myapp_query_log
		03-16T13:34:47      0      0        6       1       0   0.027 terrace_db.mysql_slow_query_review
		03-16T13:34:47      0      0        7       1       0   0.029 terrace_db.mysql_slow_query_review_history
		03-16T13:34:47      0      0        1       1       0   0.031 terrace_db.salt_record
		03-16T13:34:47      0      0        0       1       0   0.021 terrace_db.tb_blacklist
		03-16T13:34:47      0      0        0       1       0   0.026 terrace_db.tb_blacklist_user_permit
		03-16T13:34:48      0      0        1       1       0   0.028 zst.a
		03-16T13:34:48      0      0        3       1       0   0.030 zst.mytest
		03-16T13:34:48      0      0        3       1       0   0.282 zst.mytest01
		03-16T13:34:48      0      0        1       1       0   0.019 zst.product
		03-16T13:34:48      0      0        0       1       0   0.039 zst.t
		03-16T13:34:48      0      0        6       1       0   0.035 zst.t1
		03-16T13:34:48      0      0   110000       4       0   0.542 zst.t1_10yi
		03-16T13:34:49      0      0        0       1       0   0.067 zst.t2
		03-16T13:34:49      0      0        0       1       0   0.022 zst.t20190930
		03-16T13:34:49      0      0        3       1       0   0.030 zst.t20191007
		03-16T13:34:49      0      0        3       1       0   0.023 zst.t2019100702
		03-16T13:34:49      0      0        0       1       0   0.028 zst.t2020


	
	root@localhost [zst]>show tables;
	+---------------+
	| Tables_in_zst |
	+---------------+
	| a             |
	| mytest        |
	| mytest01      |
	| product       |
	| t             |
	| t1            |
	| t1_10yi       |
	| t2            |
	| t20190930     |
	| t20191007     |
	| t2019100702   |
	| t2020         |
	+---------------+
	12 rows in set (0.00 sec)
	
	
	root@localhost [zst]>show create table a\G;
	*************************** 1. row ***************************
		   Table: a
	Create Table: CREATE TABLE `a` (
	  `t1` varchar(10) DEFAULT NULL,
	  `t2` varchar(10) DEFAULT NULL,
	  `t3` char(10) DEFAULT NULL,
	  `t4` varchar(10) DEFAULT NULL
	) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT
	1 row in set (0.00 sec)
	
	
	root@localhost [zst]>show create table t2020\G;
	*************************** 1. row ***************************
		   Table: t2020
	Create Table: CREATE TABLE `t2020` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '璐?.缂..',
	  `tableid` int(11) NOT NULL,
	  `playerid` int(11) NOT NULL,
	  `szEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `idx_szEndTime` (`szEndTime`),
	  KEY `idx_playerid` (`playerid`)
	) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)