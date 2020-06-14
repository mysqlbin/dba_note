
第一次启动：
第二次启动：


第一次启动：
[root@env ~]# /etc/init.d/mysql restart
 ERROR! MySQL server process #2527 is not running!
Starting MySQL....... ERROR! The server quit without updating PID file (/data/mysql/mysql3306/data/mysql.pid).
	对应的错误日志
		2020-03-08T13:54:56.289607Z 0 [Warning] The syntax '--log_warnings/-W' is deprecated and will be removed in a future release. Please use '--log_error_verbosity' instead.
		2020-03-08T13:54:56.289729Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
		2020-03-08T13:54:56.292665Z 0 [Warning] Insecure configuration for --secure-file-priv: Location is accessible to all OS users. Consider choosing a different directory.
		2020-03-08T13:54:56.292721Z 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.19-log) starting as process 2520 ...
		2020-03-08T13:54:56.377755Z 0 [Note] InnoDB: PUNCH HOLE support available
		2020-03-08T13:54:56.377829Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
		2020-03-08T13:54:56.377841Z 0 [Note] InnoDB: Uses event mutexes
		2020-03-08T13:54:56.377853Z 0 [Note] InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
		2020-03-08T13:54:56.377863Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.3
		2020-03-08T13:54:56.377872Z 0 [Note] InnoDB: Using Linux native AIO
		2020-03-08T13:54:56.378398Z 0 [Note] InnoDB: Number of pools: 1
		2020-03-08T13:54:56.378654Z 0 [Note] InnoDB: Using CPU crc32 instructions
		2020-03-08T13:54:56.386884Z 0 [Note] InnoDB: Initializing buffer pool, total size = 100M, instances = 1, chunk size = 100M
		2020-03-08T13:54:56.406175Z 0 [Note] InnoDB: Completed initialization of buffer pool
		2020-03-08T13:54:56.410624Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
		2020-03-08T13:54:56.487135Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
		2020-03-08T13:54:56.523437Z 0 [Note] InnoDB: Log scan progressed past the checkpoint lsn 18237383586
		2020-03-08T13:54:56.523464Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 18237383595
		2020-03-08T13:54:56.523472Z 0 [Note] InnoDB: Database was not shutdown normally!
		2020-03-08T13:54:56.523490Z 0 [Note] InnoDB: Starting crash recovery.
		2020-03-08T13:54:57.615795Z 0 [Note] InnoDB: Last MySQL binlog file position 0 1031191, file name mysql-bin.000031
		2020-03-08T13:54:58.647436Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
		2020-03-08T13:54:58.647469Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
		2020-03-08T13:54:58.647542Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
		2020-03-08T13:54:59.074533Z 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
		2020-03-08T13:54:59.077346Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
		2020-03-08T13:54:59.077418Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
		2020-03-08T13:54:59.085182Z 0 [Note] InnoDB: Waiting for purge to start
		2020-03-08T13:54:59.155915Z 0 [Note] InnoDB: 5.7.19 started; log sequence number 18237383595
		2020-03-08T13:54:59.156217Z 0 [Note] Plugin 'FEDERATED' is disabled.
		2020-03-08T13:54:59.157144Z 0 [Note] InnoDB: Loading buffer pool(s) from /data/mysql/mysql3306/data/ib_buffer_pool
		2020-03-08T13:54:59.414284Z 0 [Note] Recovering after a crash using /data/mysql/mysql3306/logs/mysql-bin
		2020-03-08T13:54:59.435275Z 0 [Note] Starting crash recovery...
		2020-03-08T13:54:59.435525Z 0 [Note] Crash recovery finished.
		2020-03-08T13:54:59.550076Z 0 [Note] InnoDB: Buffer pool(s) load completed at 200308 21:54:59
		2020-03-08T13:54:59.590174Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
		2020-03-08T13:54:59.590208Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
		2020-03-08T13:54:59.590257Z 0 [Note] IPv6 is available.
		2020-03-08T13:54:59.590272Z 0 [Note]   - '::' resolves to '::';
		2020-03-08T13:54:59.590294Z 0 [Note] Server socket created on IP: '::'.
		2020-03-08T13:54:59.603343Z 0 [ERROR] Another process with pid 2527 is using unix socket file.
		2020-03-08T13:54:59.603407Z 0 [ERROR] Unable to setup unix socket lock file.
		2020-03-08T13:54:59.603415Z 0 [ERROR] Aborting

		2020-03-08T13:54:59.603432Z 0 [Note] Binlog end
		2020-03-08T13:54:59.605225Z 0 [Note] Shutting down plugin 'rpl_semi_sync_slave'
		2020-03-08T13:54:59.605263Z 0 [Note] Shutting down plugin 'rpl_semi_sync_master'
		2020-03-08T13:54:59.605324Z 0 [Note] unregister_replicator OK
		2020-03-08T13:54:59.605329Z 0 [Note] Shutting down plugin 'ngram'
		2020-03-08T13:54:59.605333Z 0 [Note] Shutting down plugin 'BLACKHOLE'
		2020-03-08T13:54:59.605338Z 0 [Note] Shutting down plugin 'ARCHIVE'
		2020-03-08T13:54:59.605342Z 0 [Note] Shutting down plugin 'partition'
		2020-03-08T13:54:59.605346Z 0 [Note] Shutting down plugin 'INNODB_SYS_VIRTUAL'
		2020-03-08T13:54:59.605351Z 0 [Note] Shutting down plugin 'INNODB_SYS_DATAFILES'
		2020-03-08T13:54:59.605379Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESPACES'
		2020-03-08T13:54:59.605388Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN_COLS'
		2020-03-08T13:54:59.605392Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN'
		2020-03-08T13:54:59.605396Z 0 [Note] Shutting down plugin 'INNODB_SYS_FIELDS'
		2020-03-08T13:54:59.605400Z 0 [Note] Shutting down plugin 'INNODB_SYS_COLUMNS'
		2020-03-08T13:54:59.605404Z 0 [Note] Shutting down plugin 'INNODB_SYS_INDEXES'
		2020-03-08T13:54:59.605408Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESTATS'
		2020-03-08T13:54:59.605412Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLES'
		2020-03-08T13:54:59.605415Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_TABLE'
		2020-03-08T13:54:59.605419Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_CACHE'
		2020-03-08T13:54:59.605423Z 0 [Note] Shutting down plugin 'INNODB_FT_CONFIG'
		2020-03-08T13:54:59.605427Z 0 [Note] Shutting down plugin 'INNODB_FT_BEING_DELETED'
		2020-03-08T13:54:59.605431Z 0 [Note] Shutting down plugin 'INNODB_FT_DELETED'
		2020-03-08T13:54:59.605435Z 0 [Note] Shutting down plugin 'INNODB_FT_DEFAULT_STOPWORD'
		2020-03-08T13:54:59.605439Z 0 [Note] Shutting down plugin 'INNODB_METRICS'
		2020-03-08T13:54:59.605443Z 0 [Note] Shutting down plugin 'INNODB_TEMP_TABLE_INFO'
		2020-03-08T13:54:59.605446Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_POOL_STATS'
		2020-03-08T13:54:59.605450Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE_LRU'
		2020-03-08T13:54:59.605454Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE'
		2020-03-08T13:54:59.605458Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX_RESET'
		2020-03-08T13:54:59.605462Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX'
		2020-03-08T13:54:59.605466Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM_RESET'
		2020-03-08T13:54:59.605470Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM'
		2020-03-08T13:54:59.605474Z 0 [Note] Shutting down plugin 'INNODB_CMP_RESET'
		2020-03-08T13:54:59.605477Z 0 [Note] Shutting down plugin 'INNODB_CMP'
		2020-03-08T13:54:59.605481Z 0 [Note] Shutting down plugin 'INNODB_LOCK_WAITS'
		2020-03-08T13:54:59.605485Z 0 [Note] Shutting down plugin 'INNODB_LOCKS'
		2020-03-08T13:54:59.605501Z 0 [Note] Shutting down plugin 'INNODB_TRX'
		2020-03-08T13:54:59.605505Z 0 [Note] Shutting down plugin 'InnoDB'
		2020-03-08T13:54:59.605566Z 0 [Note] InnoDB: FTS optimize thread exiting.
		2020-03-08T13:54:59.605701Z 0 [Note] InnoDB: Starting shutdown...
		2020-03-08T13:54:59.706173Z 0 [Note] InnoDB: Dumping buffer pool(s) to /data/mysql/mysql3306/data/ib_buffer_pool
		2020-03-08T13:54:59.706477Z 0 [Note] InnoDB: Buffer pool(s) dump completed at 200308 21:54:59
		2020-03-08T13:55:01.257716Z 0 [Note] InnoDB: Shutdown completed; log sequence number 18237385115
		2020-03-08T13:55:01.258304Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
		2020-03-08T13:55:01.258388Z 0 [Note] Shutting down plugin 'MEMORY'
		2020-03-08T13:55:01.258432Z 0 [Note] Shutting down plugin 'PERFORMANCE_SCHEMA'
		2020-03-08T13:55:01.258933Z 0 [Note] Shutting down plugin 'MRG_MYISAM'
		2020-03-08T13:55:01.259035Z 0 [Note] Shutting down plugin 'MyISAM'
		2020-03-08T13:55:01.259084Z 0 [Note] Shutting down plugin 'CSV'
		2020-03-08T13:55:01.259155Z 0 [Note] Shutting down plugin 'sha256_password'
		2020-03-08T13:55:01.259165Z 0 [Note] Shutting down plugin 'mysql_native_password'
		2020-03-08T13:55:01.260005Z 0 [Note] Shutting down plugin 'binlog'
		2020-03-08T13:55:01.274286Z 0 [Note] /usr/local/mysql/bin/mysqld: Shutdown complete


第二次启动：
	[root@env ~]# /etc/init.d/mysql restart
	 ERROR! MySQL server PID file could not be found!
	Starting MySQL.. SUCCESS! 
	
	对应的错误日志：

		2020-03-08T13:58:04.767728Z 0 [Warning] The syntax '--log_warnings/-W' is deprecated and will be removed in a future release. Please use '--log_error_verbosity' instead.
		2020-03-08T13:58:04.767857Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
		2020-03-08T13:58:04.768726Z 0 [Warning] Insecure configuration for --secure-file-priv: Location is accessible to all OS users. Consider choosing a different directory.
		2020-03-08T13:58:04.768759Z 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.19-log) starting as process 3745 ...
		2020-03-08T13:58:04.773167Z 0 [Note] InnoDB: PUNCH HOLE support available
		2020-03-08T13:58:04.773216Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
		2020-03-08T13:58:04.773222Z 0 [Note] InnoDB: Uses event mutexes
		2020-03-08T13:58:04.773228Z 0 [Note] InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
		2020-03-08T13:58:04.773232Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.3
		2020-03-08T13:58:04.773235Z 0 [Note] InnoDB: Using Linux native AIO
		2020-03-08T13:58:04.773406Z 0 [Note] InnoDB: Number of pools: 1
		2020-03-08T13:58:04.773479Z 0 [Note] InnoDB: Using CPU crc32 instructions
		2020-03-08T13:58:04.775200Z 0 [Note] InnoDB: Initializing buffer pool, total size = 100M, instances = 1, chunk size = 100M
		2020-03-08T13:58:04.781681Z 0 [Note] InnoDB: Completed initialization of buffer pool
		2020-03-08T13:58:04.783925Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
		2020-03-08T13:58:04.849913Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
		2020-03-08T13:58:05.467544Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
		2020-03-08T13:58:05.467699Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
		2020-03-08T13:58:05.776325Z 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
		2020-03-08T13:58:05.777987Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
		2020-03-08T13:58:05.778016Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
		2020-03-08T13:58:05.778566Z 0 [Note] InnoDB: Waiting for purge to start
		2020-03-08T13:58:05.864658Z 0 [Note] InnoDB: 5.7.19 started; log sequence number 18237385115
		2020-03-08T13:58:05.864911Z 0 [Note] Plugin 'FEDERATED' is disabled.
		2020-03-08T13:58:05.869109Z 0 [Note] InnoDB: Loading buffer pool(s) from /data/mysql/mysql3306/data/ib_buffer_pool
		2020-03-08T13:58:05.917914Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
		2020-03-08T13:58:05.917949Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
		2020-03-08T13:58:05.917984Z 0 [Note] IPv6 is available.
		2020-03-08T13:58:05.917993Z 0 [Note]   - '::' resolves to '::';
		2020-03-08T13:58:05.918011Z 0 [Note] Server socket created on IP: '::'.
		2020-03-08T13:58:06.317280Z 0 [Note] InnoDB: Buffer pool(s) load completed at 200308 21:58:06
		2020-03-08T13:58:06.496576Z 0 [Warning] Recovery from master pos 166830097 and file mysql-bin.000003 for channel ''. Previous relay log pos and relay log file had been set to 4, ./relay-bin.000035 respectively.
		2020-03-08T13:58:06.602672Z 0 [Note] Event Scheduler: Loaded 0 events
		2020-03-08T13:58:06.603135Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
		Version: '5.7.19-log'  socket: '/tmp/mysql3306.sock'  port: 3306  MySQL Community Server (GPL)
		2020-03-08T13:58:06.603155Z 0 [Note] Executing 'SELECT * FROM INFORMATION_SCHEMA.TABLES;' to get a list of tables using the deprecated partition engine. You may use the startup option '--disable-partition-engine-check' to skip this check. 
		2020-03-08T13:58:06.603161Z 0 [Note] Beginning of list of non-natively partitioned tables
		2020-03-08T13:58:06.967690Z 0 [Note] End of list of non-natively partitioned tables
