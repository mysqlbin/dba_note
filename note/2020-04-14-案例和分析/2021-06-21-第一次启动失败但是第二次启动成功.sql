

第一次启动失败：
	/home/mysql/bin/mysqld --defaults-file=/etc/my.cnf &
	2021-06-15T07:34:08.380619Z 0 [Warning] 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
	2021-06-15T07:34:08.380691Z 0 [Warning] 'NO_AUTO_CREATE_USER' sql mode was not set.
	2021-06-15T07:34:08.380728Z 0 [Note] --secure-file-priv is set to NULL. Operations related to importing and exporting data are disabled
	2021-06-15T07:34:08.380774Z 0 [Note] /home/mysql/bin/mysqld (mysqld 5.7.26-debug-log) starting as process 3353 ...
	2021-06-15T07:34:08.380821Z 0 [ERROR] Can't find error-message file '/usr/local/mysql/share/errmsg.sys'. Check error-message file location and 'lc-messages-dir' configuration directive.
	2021-06-15T07:34:08.390684Z 0 [Note] InnoDB: PUNCH HOLE support available
	2021-06-15T07:34:08.390729Z 0 [Note] InnoDB: !!!!!!!! UNIV_DEBUG switched on !!!!!!!!!
	2021-06-15T07:34:08.390739Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
	2021-06-15T07:34:08.390747Z 0 [Note] InnoDB: Uses event mutexes
	2021-06-15T07:34:08.390754Z 0 [Note] InnoDB: GCC builtin __atomic_thread_fence() is used for memory barrier
	2021-06-15T07:34:08.390761Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
	2021-06-15T07:34:08.390788Z 0 [Note] InnoDB: Adjusting innodb_buffer_pool_instances from 2 to 1 since innodb_buffer_pool_size is less than 1024 MiB
	2021-06-15T07:34:08.391589Z 0 [Note] InnoDB: Number of pools: 1
	2021-06-15T07:34:08.391730Z 0 [Note] InnoDB: Using CPU crc32 instructions
	2021-06-15T07:34:08.394012Z 0 [Note] InnoDB: Initializing buffer pool, total size = 128M, instances = 1, chunk size = 128M
	2021-06-15T07:34:08.508210Z 0 [Note] InnoDB: Completed initialization of buffer pool
	2021-06-15T07:34:08.510800Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
	2021-06-15T07:34:08.578309Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
	2021-06-15T07:34:11.164362Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
	2021-06-15T07:34:11.164512Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 64 MB. Physically writing the file full; Please wait ...
	2021-06-15T07:34:11.279299Z 0 [Note] InnoDB: File './ibtmp1' size is now 64 MB.
	2021-06-15T07:34:11.293587Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
	2021-06-15T07:34:11.293625Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
	2021-06-15T07:34:11.295856Z 0 [Note] InnoDB: Waiting for purge to start
	2021-06-15T07:34:11.367707Z 0 [Note] InnoDB: 5.7.26 started; log sequence number 171514329
	2021-06-15T07:34:11.383347Z 0 [Note] Plugin 'FEDERATED' is disabled.
	2021-06-15T07:34:11.394596Z 0 [Note] InnoDB: Loading buffer pool(s) from /home/mysql/data/ib_buffer_pool
	2021-06-15T07:34:11.401602Z 0 [Note] InnoDB: Buffer pool(s) load completed at 210615 15:34:11
	2021-06-15T07:34:11.476482Z 0 [Note] Recovering after a crash using /home/mysql/logs/mysql-bin
	2021-06-15T07:34:11.476820Z 0 [Note] Starting crash recovery...
	2021-06-15T07:34:11.476862Z 0 [Note] Crash recovery finished.
	2021-06-15T07:34:11.528664Z 0 [Note] Read 2 events from binary log file '/home/mysql/logs/mysql-bin.000004' to determine the GTIDs purged from binary logs.
	2021-06-15T07:34:11.574572Z 0 [Note] Read 2 events from binary log file '/home/mysql/logs/mysql-bin.000004' to determine the GTIDs purged from binary logs.
	mysqld: /usr/local/mysql/sql/mysqld.cc:4891: int mysqld_main(int, char**): Assertion `lost_gtids->is_empty()' failed.
	07:34:11 UTC - mysqld got signal 6 ;
	This could be because you hit a bug. It is also possible that this binary
	or one of the libraries it was linked against is corrupt, improperly built,
	or misconfigured. This error can also be caused by malfunctioning hardware.
	Attempting to collect some information that could help diagnose the problem.
	As this is a crash and something is definitely wrong, the information
	collection process might fail.

	key_buffer_size=33554432
	read_buffer_size=8388608
	max_used_connections=0
	max_threads=1024
	thread_count=0
	connection_count=0
	It is possible that mysqld could use up to 
	key_buffer_size + (read_buffer_size + sort_buffer_size)*max_threads = 12629824 K  bytes of memory
	Hope that s ok; if not, decrease some variables in the equation.

	Thread pointer: 0x0
	Attempting backtrace. You can use the following information to find out
	where mysqld died. If you see no messages after this, something went
	terribly wrong...
	stack_bottom = 0 thread_stack 0x80000
	/home/mysql/bin/mysqld(my_print_stacktrace+0x35)[0x186d920]
	/home/mysql/bin/mysqld(handle_fatal_signal+0x3f6)[0xeb1de9]
	/lib64/libpthread.so.0(+0xf630)[0x7f0df7477630]
	/lib64/libc.so.6(gsignal+0x37)[0x7f0df626d387]
	/lib64/libc.so.6(abort+0x148)[0x7f0df626ea78]
	/lib64/libc.so.6(+0x2f1a6)[0x7f0df62661a6]
	/lib64/libc.so.6(+0x2f252)[0x7f0df6266252]
	/home/mysql/bin/mysqld(_Z11mysqld_mainiPPc+0xd11)[0xea27e7]
	/home/mysql/bin/mysqld(main+0x20)[0xe9a05d]
	/lib64/libc.so.6(__libc_start_main+0xf5)[0x7f0df6259555]
	/home/mysql/bin/mysqld[0xe99f79]
	The manual page at http://dev.mysql.com/doc/mysql/en/crashing.html contains
	information that should help you find out what is causing the crash.







第二次启动成功：

	2021-06-15T07:40:32.050801Z 0 [Warning] 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
	2021-06-15T07:40:32.050868Z 0 [Warning] 'NO_AUTO_CREATE_USER' sql mode was not set.
	2021-06-15T07:40:32.050905Z 0 [Note] --secure-file-priv is set to NULL. Operations related to importing and exporting data are disabled
	2021-06-15T07:40:32.050950Z 0 [Note] /home/mysql/bin/mysqld (mysqld 5.7.26-debug-log) starting as process 3395 ...
	2021-06-15T07:40:32.050996Z 0 [ERROR] Can t find error-message file '/usr/local/mysql/share/errmsg.sys'. Check error-message file location and 'lc-messages-dir' configuration directive.
	2021-06-15T07:40:32.060563Z 0 [Note] InnoDB: PUNCH HOLE support available
	2021-06-15T07:40:32.060640Z 0 [Note] InnoDB: !!!!!!!! UNIV_DEBUG switched on !!!!!!!!!
	2021-06-15T07:40:32.060662Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
	2021-06-15T07:40:32.060669Z 0 [Note] InnoDB: Uses event mutexes
	2021-06-15T07:40:32.060676Z 0 [Note] InnoDB: GCC builtin __atomic_thread_fence() is used for memory barrier
	2021-06-15T07:40:32.060682Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
	2021-06-15T07:40:32.060709Z 0 [Note] InnoDB: Adjusting innodb_buffer_pool_instances from 2 to 1 since innodb_buffer_pool_size is less than 1024 MiB
	2021-06-15T07:40:32.061585Z 0 [Note] InnoDB: Number of pools: 1
	2021-06-15T07:40:32.061727Z 0 [Note] InnoDB: Using CPU crc32 instructions
	2021-06-15T07:40:32.063979Z 0 [Note] InnoDB: Initializing buffer pool, total size = 128M, instances = 1, chunk size = 128M
	2021-06-15T07:40:32.172954Z 0 [Note] InnoDB: Completed initialization of buffer pool
	2021-06-15T07:40:32.174524Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
	2021-06-15T07:40:32.225225Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
	2021-06-15T07:40:32.229836Z 0 [Note] InnoDB: Log scan progressed past the checkpoint lsn 171514329
	2021-06-15T07:40:32.229925Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 171514535
	2021-06-15T07:40:32.244836Z 0 [Note] InnoDB: Database was not shutdown normally!
	2021-06-15T07:40:32.244874Z 0 [Note] InnoDB: Starting crash recovery.
	2021-06-15T07:40:32.532301Z 0 [Note] InnoDB: Starting an apply batch of log records to the database...
	InnoDB: Progress in percent: 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 
	2021-06-15T07:40:33.039128Z 0 [Note] InnoDB: Apply batch completed
	2021-06-15T07:40:33.039245Z 0 [Note] InnoDB: Last MySQL binlog file position 0 3450, file name mysql-bin.000015
	2021-06-15T07:41:08.198806Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
	2021-06-15T07:41:08.198867Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
	2021-06-15T07:41:08.198997Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 64 MB. Physically writing the file full; Please wait ...
	2021-06-15T07:41:08.360373Z 0 [Note] InnoDB: File './ibtmp1' size is now 64 MB.
	2021-06-15T07:41:08.386949Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
	2021-06-15T07:41:08.386986Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
	2021-06-15T07:41:08.398695Z 0 [Note] InnoDB: Waiting for purge to start
	2021-06-15T07:41:08.449300Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 36275ms. The settings might not be optimal. (flushed=0 and evicted=0, during the time.)
	2021-06-15T07:41:08.471904Z 0 [Note] InnoDB: 5.7.26 started; log sequence number 171514535
	2021-06-15T07:41:08.478118Z 0 [Note] InnoDB: Loading buffer pool(s) from /home/mysql/data/ib_buffer_pool
	2021-06-15T07:41:08.484402Z 0 [Note] InnoDB: Buffer pool(s) load completed at 210615 15:41:08
	2021-06-15T07:41:08.495465Z 0 [Note] Plugin 'FEDERATED' is disabled.
	2021-06-15T07:41:08.638936Z 0 [Note] Recovering after a crash using /home/mysql/logs/mysql-bin
	2021-06-15T07:41:08.639047Z 0 [Note] Starting crash recovery...
	2021-06-15T07:41:08.639263Z 0 [Note] Crash recovery finished.
	2021-06-15T07:41:08.805575Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
	2021-06-15T07:41:08.805603Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
	2021-06-15T07:41:08.806505Z 0 [Note] IPv6 is available.
	2021-06-15T07:41:08.806524Z 0 [Note]   - '::' resolves to '::';
	2021-06-15T07:41:08.806556Z 0 [Note] Server socket created on IP: '::'.
	2021-06-15T07:41:08.954508Z 0 [Note] Failed to start slave threads for channel ''
	2021-06-15T07:41:09.108030Z 0 [Note] Event Scheduler: Loaded 0 events
	2021-06-15T07:41:09.108816Z 0 [Note] 
	2021-06-15T07:41:09.109045Z 1 [Note] Event Scheduler: scheduler thread started with id 1


