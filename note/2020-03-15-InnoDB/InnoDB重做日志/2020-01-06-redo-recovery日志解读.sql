


2018-11-18T09:05:04.432929Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2018-11-18T09:05:04.433005Z 0 [Warning] 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
2018-11-18T09:05:04.433009Z 0 [Warning] 'NO_AUTO_CREATE_USER' sql mode was not set.
2018-11-18T09:05:04.433034Z 0 [Note] --secure-file-priv is set to NULL. Operations related to importing and exporting data are disabled
2018-11-18T09:05:04.433064Z 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.21-log) starting as process 27058 ...
2018-11-18T09:05:04.544077Z 0 [Warning] InnoDB: innodb_open_files should not be greater than the open_files_limit.
2018-11-18T09:05:04.544155Z 0 [Note] InnoDB: PUNCH HOLE support available
2018-11-18T09:05:04.544167Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2018-11-18T09:05:04.544172Z 0 [Note] InnoDB: Uses event mutexes
2018-11-18T09:05:04.544176Z 0 [Note] InnoDB: GCC builtin __sync_synchronize() is used for memory barrier

# Compressed 行记录格式使用的是 zlib 算法
2018-11-18T09:05:04.544180Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.3

# Linux 的异步IO
2018-11-18T09:05:04.544184Z 0 [Note] InnoDB: Using Linux native AIO                
2018-11-18T09:05:04.545733Z 0 [Note] InnoDB: Number of pools: 1
2018-11-18T09:05:04.545853Z 0 [Note] InnoDB: Using CPU crc32 instructions
2018-11-18T09:05:04.548205Z 0 [Note] InnoDB: Initializing buffer pool, total size = 10G, instances = 2, chunk size = 128M
2018-11-18T09:05:05.479775Z 0 [Note] InnoDB: Completed initialization of buffer pool
2018-11-18T09:05:05.562491Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. 
	See the man page of setpriority().
2018-11-18T09:05:05.598637Z 0 [Note] InnoDB: Opened 3 undo tablespaces
2018-11-18T09:05:05.598662Z 0 [Note] InnoDB: 3 undo tablespaces made active
2018-11-18T09:05:05.598668Z 0 [Warning] InnoDB: Will use system tablespace for all newly created rollback-segment as innodb_undo_tablespaces=0
2018-11-18T09:05:05.599022Z 0 [Note] InnoDB: Highest supported file format is Barracuda.


# 找到 checkpoint lsn, 崩溃恢复从这里开始, 然后顺序地扫描 redo 
2018-11-18T09:05:05.659248Z 0 [Note] InnoDB: Log scan progressed past the checkpoint lsn 66934104855
2018-11-18T09:05:06.020490Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66939347456
2018-11-18T09:05:06.351024Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66944590336
2018-11-18T09:05:06.682787Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66949833216
2018-11-18T09:05:07.012686Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66955076096
2018-11-18T09:05:07.341407Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66960318976
2018-11-18T09:05:07.670294Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66965561856
2018-11-18T09:05:08.001280Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66970804736
2018-11-18T09:05:08.333313Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66976047616
2018-11-18T09:05:08.665291Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66981290496
2018-11-18T09:05:08.735768Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 66982370956

# 如果发现checkpoint之后还有日志，说明数据库之前没有正常关闭，需要做崩溃恢复，
2018-11-18T09:05:08.737749Z 0 [Note] InnoDB: Database was not shutdown normally!

# 崩溃恢复开始
2018-11-18T09:05:08.737762Z 0 [Note] InnoDB: Starting crash recovery.

# undo 的回滚操作
2018-11-18T09:05:58.283977Z 0 [Note] InnoDB: 1 transaction(s) which must be rolled back or cleaned up in total 50886919 row operations to undo
2018-11-18T09:05:58.284022Z 0 [Note] InnoDB: Trx id counter is 97054976
2018-11-18T09:05:58.287518Z 0 [Note] InnoDB: Starting an apply batch of log records to the database...
InnoDB: Progress in percent: 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 
2018-11-18T09:06:00.441813Z 0 [Note] InnoDB: Apply batch completed

2018-11-18T09:06:00.441867Z 0 [Note] InnoDB: Last MySQL binlog file position 0 153437758, file name mysql-bin.000070

# 通过 后台线程 开始回滚未提交的事务
2018-11-18T09:06:00.853119Z 0 [Note] InnoDB: Starting in background the rollback of uncommitted transactions
# 回滚的事务ID 为 97012170, 一共需要回滚 50886919 行记录
2018-11-18T09:06:00.853166Z 0 [Note] InnoDB: Rolling back trx with id 97012170, 50886919 rows to undo

InnoDB: Progress in percents: 12018-11-18T09:06:00.855262Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
2018-11-18T09:06:00.855278Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
2018-11-18T09:06:00.855318Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
2018-11-18T09:06:00.979084Z 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.

2018-11-18T09:06:00.980082Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
2018-11-18T09:06:00.980096Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.

# 等待purge线程清除开始
2018-11-18T09:06:00.980958Z 0 [Note] InnoDB: Waiting for purge to start

# 每隔1秒刷脏页的时候被拉长到了 55.469 S,  说明有大量的脏页需要刷盘, 导致数据库的关闭也需要更长的时间
2018-11-18T09:06:01.031134Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 55469ms. The settings might not be optimal. (flushed=0 and evicted=0, during the time.)
2018-11-18T09:06:01.031134Z 0 [Note] InnoDB: 5.7.21 started; log sequence number 66982370956

# 把 buffer pool缓冲池 的数据页加载到 缓冲池中
2018-11-18T09:06:01.031420Z 0 [Note] InnoDB: Loading buffer pool(s) from /mydata/mysql/ib_buffer_pool
2018-11-18T09:06:01.031900Z 0 [Note] Plugin 'FEDERATED' is disabled.

# BP缓冲池的数据页加载完成
2018-11-18T09:06:01.038790Z 0 [Note] InnoDB: Buffer pool(s) load completed at 181118 17:06:01

# 崩溃恢复依赖于 binlog
2018-11-18T09:06:01.113969Z 0 [Note] Recovering after a crash using /usr/local/mysql/binlog/mysql-bin

2018-11-18T09:06:02.569074Z 0 [Note] Starting crash recovery...

# 崩溃恢复完成 
2018-11-18T09:06:02.569167Z 0 [Note] Crash recovery finished.

2018-11-18T09:06:03.085178Z 0 [Warning] Failed to set up SSL because of the following SSL library error: 
	SSL context is not usable without certificate and private key
2018-11-18T09:06:03.085210Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
2018-11-18T09:06:03.085254Z 0 [Note] IPv6 is available.
2018-11-18T09:06:03.085264Z 0 [Note]   - '::' resolves to '::';
2018-11-18T09:06:03.085289Z 0 [Note] Server socket created on IP: '::'.
2018-11-18T09:06:03.129425Z 0 [Warning] 'user' entry 'root@localhost' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.129510Z 0 [Warning] 'user' entry 'mysql.session@localhost' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.129532Z 0 [Warning] 'user' entry 'mysql.sys@localhost' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.129552Z 0 [Warning] 'user' entry 'root@local' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.130168Z 0 [Warning] 'db' entry 'performance_schema mysql.session@localhost' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.130179Z 0 [Warning] 'db' entry 'sys mysql.sys@localhost' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.130761Z 0 [Warning] 'proxies_priv' entry '@ root@localhost' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.141148Z 0 [Warning] 'tables_priv' entry 'user mysql.session@localhost' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.141161Z 0 [Warning] 'tables_priv' entry 'sys_config mysql.sys@localhost' ignored in --skip-name-resolve mode.
2018-11-18T09:06:03.231154Z 0 [Note] Event Scheduler: Loaded 6 events
2018-11-18T09:06:03.231295Z 1 [Note] Event Scheduler: scheduler thread started with id 1
2018-11-18T09:06:03.231450Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
Version: '5.7.21-log'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MySQL Community Server (GPL)

2018-11-18T09:06:03.410334Z 8 [Note] Start binlog_dump to master_thread_id(8) slave_server(330607), pos(mysql-bin.000070, 153437758)
2018-11-18T09:06:03.512626Z 9 [Note] Start binlog_dump to master_thread_id(9) slave_server(241), pos(mysql-bin.000070, 153437758)
 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100

# undo的回滚操作完成: 回滚的事务ID 为 97012170, 一共需要回滚 50886919 行记录
2018-11-18T09:15:40.795869Z 0 [Note] InnoDB: Rollback of trx with id 97012170 completed
2018-11-18T09:15:40.795915Z 0 [Note] InnoDB: Rollback of non-prepared transactions completed

-----------------------------------------------------------------------------------------------
Crash recovery 完成
-----------------------------------------------------------------------------------------------

小结:  通过日志可以看到, 在有大事务的undo需要回滚的场景, crash recovery 的时间会大大加长.




2018-11-18T09:36:13.340562Z 46 [Note] Aborted connection 46 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T09:36:13.340562Z 32 [Note] Aborted connection 32 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T09:36:13.340569Z 125 [Note] Aborted connection 125 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T11:16:33.463923Z 48 [Note] Aborted connection 48 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T11:18:22.007918Z 49 [Note] Aborted connection 49 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T11:18:42.487928Z 50 [Note] Aborted connection 50 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T11:18:48.631978Z 53 [Note] Aborted connection 53 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T11:20:02.359883Z 108 [Note] Aborted connection 108 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T11:20:06.455966Z 109 [Note] Aborted connection 109 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)
2018-11-18T11:20:35.127909Z 116 [Note] Aborted connection 116 to db: 'yqdb' user: 'app_user' host: '11.111.111.111' (Got an error reading communication packets)


2018-11-18T20:03:53.315035Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4995ms. The settings might not be optimal. (flushed=200 and evicted=0, during the time.)
2018-11-18T20:04:19.523268Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2018-11-18T20:04:19.523347Z 0 [Warning] 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
2018-11-18T20:04:19.523351Z 0 [Warning] 'NO_AUTO_CREATE_USER' sql mode was not set.
2018-11-18T20:04:19.523387Z 0 [Note] --secure-file-priv is set to NULL. Operations related to importing and exporting data are disabled
2018-11-18T20:04:19.523420Z 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.21-log) starting as process 15435 ...
2018-11-18T20:04:19.575015Z 0 [Warning] InnoDB: innodb_open_files should not be greater than the open_files_limit.
2018-11-18T20:04:19.575088Z 0 [Note] InnoDB: PUNCH HOLE support available
2018-11-18T20:04:19.575099Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2018-11-18T20:04:19.575104Z 0 [Note] InnoDB: Uses event mutexes
2018-11-18T20:04:19.575108Z 0 [Note] InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
2018-11-18T20:04:19.575113Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.3
2018-11-18T20:04:19.575117Z 0 [Note] InnoDB: Using Linux native AIO
2018-11-18T20:04:19.576673Z 0 [Note] InnoDB: Number of pools: 1
2018-11-18T20:04:19.576799Z 0 [Note] InnoDB: Using CPU crc32 instructions
2018-11-18T20:04:19.578946Z 0 [Note] InnoDB: Initializing buffer pool, total size = 10G, instances = 2, chunk size = 128M
2018-11-18T20:04:20.472117Z 0 [Note] InnoDB: Completed initialization of buffer pool
2018-11-18T20:04:20.555099Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
2018-11-18T20:04:20.589191Z 0 [Note] InnoDB: Opened 3 undo tablespaces
2018-11-18T20:04:20.589223Z 0 [Note] InnoDB: 3 undo tablespaces made active
2018-11-18T20:04:20.589229Z 0 [Warning] InnoDB: Will use system tablespace for all newly created rollback-segment as innodb_undo_tablespaces=0
2018-11-18T20:04:20.589649Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
2018-11-18T20:04:20.649178Z 0 [Note] InnoDB: Log scan progressed past the checkpoint lsn 83978821599
2018-11-18T20:04:20.649218Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 83978821608
2018-11-18T20:04:20.649225Z 0 [Note] InnoDB: Database was not shutdown normally!
2018-11-18T20:04:20.649230Z 0 [Note] InnoDB: Starting crash recovery.
2018-11-18T20:05:27.768165Z 0 [Note] InnoDB: 1 transaction(s) which must be rolled back or cleaned up in total 103411492 row operations to undo
2018-11-18T20:05:27.768218Z 0 [Note] InnoDB: Trx id counter is 97264128
2018-11-18T20:05:27.885228Z 0 [Note] InnoDB: Last MySQL binlog file position 0 80581133, file name mysql-bin.000071
2018-11-18T20:05:28.318524Z 0 [Note] InnoDB: Starting in background the rollback of uncommitted transactions
2018-11-18T20:05:28.318589Z 0 [Note] InnoDB: Rolling back trx with id 97173409, 103411492 rows to undo

InnoDB: Progress in percents: 12018-11-18T20:05:28.319280Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
2018-11-18T20:05:28.319296Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
2018-11-18T20:05:28.319335Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
2018-11-18T20:05:28.423092Z 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
2018-11-18T20:05:28.423947Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
2018-11-18T20:05:28.423961Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
2018-11-18T20:05:28.424652Z 0 [Note] InnoDB: Waiting for purge to start
2018-11-18T20:05:28.474836Z 0 [Note] InnoDB: 5.7.21 started; log sequence number 83978821608
2018-11-18T20:05:28.474841Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 67919ms. The settings might not be optimal. (flushed=0 and evicted=0, during the time.)
2018-11-18T20:05:28.475182Z 0 [Note] InnoDB: Loading buffer pool(s) from /mydata/mysql/ib_buffer_pool
2018-11-18T20:05:28.475572Z 0 [Note] Plugin 'FEDERATED' is disabled.
2018-11-18T20:05:28.483138Z 0 [Note] InnoDB: Buffer pool(s) load completed at 181119  4:05:28
2018-11-18T20:05:28.512403Z 0 [Note] Recovering after a crash using /usr/local/mysql/binlog/mysql-bin
2018-11-18T20:05:29.408615Z 0 [Note] Starting crash recovery...
2018-11-18T20:05:29.408686Z 0 [Note] Crash recovery finished.
2018-11-18T20:05:29.921673Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
2018-11-18T20:05:29.921703Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
2018-11-18T20:05:29.921747Z 0 [Note] IPv6 is available.
2018-11-18T20:05:29.921758Z 0 [Note]   - '::' resolves to '::';
2018-11-18T20:05:29.921783Z 0 [Note] Server socket created on IP: '::'.
2018-11-18T20:05:29.933503Z 0 [Warning] 'user' entry 'root@localhost' ignored in --skip-name-resolve mode.
2018-11-18T20:05:29.933543Z 0 [Warning] 'user' entry 'mysql.session@localhost' ignored in --skip-name-resolve mode.
2018-11-18T20:05:29.933555Z 0 [Warning] 'user' entry 'mysql.sys@localhost' ignored in --skip-name-resolve mode.
2018-11-18T20:05:29.933574Z 0 [Warning] 'user' entry 'root@local' ignored in --skip-name-resolve mode.
2018-11-18T20:05:29.934161Z 0 [Warning] 'db' entry 'performance_schema mysql.session@localhost' ignored in --skip-name-resolve mode.
2018-11-18T20:05:29.934174Z 0 [Warning] 'db' entry 'sys mysql.sys@localhost' ignored in --skip-name-resolve mode.
2018-11-18T20:05:29.934722Z 0 [Warning] 'proxies_priv' entry '@ root@localhost' ignored in --skip-name-resolve mode.
2018-11-18T20:05:29.946090Z 0 [Warning] 'tables_priv' entry 'user mysql.session@localhost' ignored in --skip-name-resolve mode.
2018-11-18T20:05:29.946104Z 0 [Warning] 'tables_priv' entry 'sys_config mysql.sys@localhost' ignored in --skip-name-resolve mode.
2018-11-18T20:05:30.039977Z 0 [Note] Event Scheduler: Loaded 6 events
2018-11-18T20:05:30.040134Z 1 [Note] Event Scheduler: scheduler thread started with id 1
2018-11-18T20:05:30.040304Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
Version: '5.7.21-log'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MySQL Community Server (GPL)
 2 3 4 5
2018-11-18T20:06:18.217921Z 49 [Note] Start binlog_dump to master_thread_id(49) slave_server(241), pos(mysql-bin.000071, 80581133)
2018-11-18T20:06:18.217931Z 48 [Note] Start binlog_dump to master_thread_id(48) slave_server(330607), pos(mysql-bin.000071, 80581133)
 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100
2018-11-18T20:25:52.520511Z 0 [Note] InnoDB: Rollback of trx with id 97173409 completed
2018-11-18T20:25:52.520546Z 0 [Note] InnoDB: Rollback of non-prepared transactions completed


