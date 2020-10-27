

1. 操作系统和MySQL的相关配置
2. 在主库执行的语句
3. 操作系统messages的日志
4. MySQL的错误日志 
5. DDL生成的临时文件并没有被删除
6. 小结


1. 操作系统和MySQL的相关配置

	[root@localhost data]# free -h
				  total        used        free      shared  buff/cache   available
	Mem:           992M        816M         62M        1.1M        113M         38M
	Swap:          2.0G        801M        1.2G

	innodb_buffer_pool_size = 10G
	innodb_buffer_pool_instances = 2

2. 在主库执行的语句

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



	mysql> alter table t_20201021 add column c int(11) default null;



3. 操作系统messages的日志 
	Oct 22 11:13:10 localhost kernel: mysqld invoked oom-killer: gfp_mask=0x200da, order=0, oom_score_adj=0
	Oct 22 11:13:11 localhost kernel: mysqld cpuset=/ mems_allowed=0
	Oct 22 11:13:11 localhost kernel: CPU: 0 PID: 4297 Comm: mysqld Not tainted 3.10.0-514.el7.x86_64 #1
	Oct 22 11:13:11 localhost kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
	Oct 22 11:13:11 localhost kernel: ffff88003da3ce70 0000000080847197 ffff88003baf3990 ffffffff81685fac
	Oct 22 11:13:11 localhost kernel: ffff88003baf3a20 ffffffff81680f57 ffffffff812ae71b ffff88003bb93750
	Oct 22 11:13:11 localhost kernel: ffff88003bb93768 ffffffff00000202 fffeefff00000000 0000000000000001
	Oct 22 11:13:11 localhost kernel: Call Trace:
	Oct 22 11:13:11 localhost kernel: [<ffffffff81685fac>] dump_stack+0x19/0x1b
	Oct 22 11:13:11 localhost kernel: [<ffffffff81680f57>] dump_header+0x8e/0x225
	Oct 22 11:13:11 localhost kernel: [<ffffffff812ae71b>] ? cred_has_capability+0x6b/0x120
	Oct 22 11:13:11 localhost kernel: [<ffffffff8113cb03>] ? delayacct_end+0x33/0xb0
	Oct 22 11:13:11 localhost kernel: [<ffffffff8118460e>] oom_kill_process+0x24e/0x3c0
	Oct 22 11:13:11 localhost kernel: [<ffffffff81184e46>] out_of_memory+0x4b6/0x4f0
	Oct 22 11:13:11 localhost kernel: [<ffffffff81681a60>] __alloc_pages_slowpath+0x5d7/0x725
	Oct 22 11:13:11 localhost kernel: [<ffffffff8118af55>] __alloc_pages_nodemask+0x405/0x420
	Oct 22 11:13:11 localhost kernel: [<ffffffff811d20ba>] alloc_pages_vma+0x9a/0x150
	Oct 22 11:13:11 localhost kernel: [<ffffffff811c2eab>] read_swap_cache_async+0xeb/0x160
	Oct 22 11:13:11 localhost kernel: [<ffffffff811c2fc8>] swapin_readahead+0xa8/0x110
	Oct 22 11:13:11 localhost kernel: [<ffffffff811b122c>] handle_mm_fault+0xb1c/0xfe0
	Oct 22 11:13:11 localhost kernel: [<ffffffff81691a94>] __do_page_fault+0x154/0x450
	Oct 22 11:13:11 localhost kernel: [<ffffffff81691dc5>] do_page_fault+0x35/0x90
	Oct 22 11:13:11 localhost kernel: [<ffffffff8168e088>] page_fault+0x28/0x30
	Oct 22 11:13:11 localhost kernel: Mem-Info:
	Oct 22 11:13:11 localhost kernel: active_anon:110175 inactive_anon:110433 isolated_anon:0#012 active_file:68 inactive_file:2679 isolated_file:0#012 unevictable:0 dirty:0 writeback:12 unstable:0#012 slab_reclaimable:5434 slab_unreclaimable:5717#012 mapped:64 shmem:2 pagetables:2572 bounce:0#012 free:12219 free_pcp:83 free_cma:0
	Oct 22 11:13:11 localhost kernel: Node 0 DMA free:4600kB min:704kB low:880kB high:1056kB active_anon:4520kB inactive_anon:5388kB active_file:0kB inactive_file:12kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15992kB managed:15908kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:248kB slab_unreclaimable:268kB kernel_stack:0kB pagetables:600kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
	Oct 22 11:13:11 localhost kernel: lowmem_reserve[]: 0 975 975 975
	Oct 22 11:13:11 localhost kernel: Node 0 DMA32 free:44276kB min:44348kB low:55432kB high:66520kB active_anon:436180kB inactive_anon:436344kB active_file:272kB inactive_file:10704kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:1032128kB managed:1000568kB mlocked:0kB dirty:0kB writeback:48kB mapped:256kB shmem:8kB slab_reclaimable:21488kB slab_unreclaimable:22600kB kernel_stack:2576kB pagetables:9688kB unstable:0kB bounce:0kB free_pcp:332kB local_pcp:332kB free_cma:0kB writeback_tmp:0kB pages_scanned:1030 all_unreclaimable? yes
	Oct 22 11:13:11 localhost kernel: lowmem_reserve[]: 0 0 0 0
	Oct 22 11:13:11 localhost kernel: Node 0 DMA: 2*4kB (U) 10*8kB (UE) 14*16kB (UEM) 4*32kB (UM) 3*64kB (U) 1*128kB (E) 1*256kB (M) 1*512kB (E) 1*1024kB (E) 1*2048kB (M) 0*4096kB = 4600kB
	Oct 22 11:13:11 localhost kernel: Node 0 DMA32: 225*4kB (UEM) 368*8kB (UEM) 317*16kB (UEM) 99*32kB (UE) 33*64kB (UE) 11*128kB (UE) 14*256kB (UEM) 9*512kB (U) 2*1024kB (U) 3*2048kB (M) 3*4096kB (M) = 44276kB
	Oct 22 11:13:11 localhost kernel: Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
	Oct 22 11:13:11 localhost kernel: 34064 total pagecache pages
	Oct 22 11:13:11 localhost kernel: 31316 pages in swap cache
	Oct 22 11:13:11 localhost kernel: Swap cache stats: add 1747371, delete 1716055, find 550131/636341
	Oct 22 11:13:11 localhost kernel: Free swap  = 0kB
	Oct 22 11:13:11 localhost kernel: Total swap = 2097148kB
	Oct 22 11:13:11 localhost kernel: 262030 pages RAM
	Oct 22 11:13:11 localhost kernel: 0 pages HighMem/MovableOnly
	Oct 22 11:13:11 localhost kernel: 7911 pages reserved
	Oct 22 11:13:11 localhost kernel: [ pid ]   uid  tgid total_vm      rss nr_ptes swapents oom_score_adj name
	Oct 22 11:13:11 localhost kernel: [  466]     0   466     8745        1      19       77             0 systemd-journal
	Oct 22 11:13:11 localhost kernel: [  477]     0   477    11645        0      25      524         -1000 systemd-udevd
	Oct 22 11:13:11 localhost kernel: [  490]     0   490    48780        0      28      397             0 lvmetad
	Oct 22 11:13:11 localhost kernel: [  601]     0   601    13854        1      26      108         -1000 auditd
	Oct 22 11:13:11 localhost kernel: [  622]     0   622     6048       16      15       62             0 systemd-logind
	Oct 22 11:13:11 localhost kernel: [  623]    81   623    15539        3      31      168          -900 dbus-daemon
	Oct 22 11:13:11 localhost kernel: [  629]     0   629   110601        0      66      455             0 NetworkManager
	Oct 22 11:13:11 localhost kernel: [  630]   998   630   133571        0      59     1654             0 polkitd
	Oct 22 11:13:11 localhost kernel: [  638]     0   638    31555       19      20      138             0 crond
	Oct 22 11:13:11 localhost kernel: [  639]     0   639    23079        1      50      160             0 login
	Oct 22 11:13:11 localhost kernel: [  847]     0   847    70869        0      39      272             0 rsyslogd
	Oct 22 11:13:11 localhost kernel: [  848]     0   848   141163       82      93     2600             0 tuned
	Oct 22 11:13:11 localhost kernel: [  858]     0   858    20617        0      42      214         -1000 sshd
	Oct 22 11:13:11 localhost kernel: [ 1470]     0  1470    22245       17      42      239             0 master
	Oct 22 11:13:11 localhost kernel: [ 1647]    89  1647    22288        4      43      247             0 qmgr
	Oct 22 11:13:11 localhost kernel: [ 2064]     0  2064    28845        0      17      111             0 bash
	Oct 22 11:13:11 localhost kernel: [ 2489]     0  2489    28312        1      14       87             0 mysqld_safe
	Oct 22 11:13:11 localhost kernel: [ 3871]  1000  3871  3108800   188554    1475   512574             0 mysqld
	Oct 22 11:13:11 localhost kernel: [ 4844]     0  4844    35743        0      71      318             0 sshd
	Oct 22 11:13:11 localhost kernel: [ 4848]     0  4848    28846        0      15       97             0 bash
	Oct 22 11:13:11 localhost kernel: [ 4866]     0  4866    33444        0      22      187             0 mysql
	Oct 22 11:13:11 localhost kernel: [ 5040]     0  5040    35741       30      72      287             0 sshd
	Oct 22 11:13:11 localhost kernel: [ 5044]     0  5044    28846        0      14       97             0 bash
	Oct 22 11:13:11 localhost kernel: [ 5062]     0  5062    33516       82      23      161             0 mysql
	Oct 22 11:13:11 localhost kernel: [ 5071]     0  5071    35774       37      67      283             0 sshd
	Oct 22 11:13:11 localhost kernel: [ 5075]     0  5075    28846       51      14       48             0 bash
	Oct 22 11:13:11 localhost kernel: [ 5100]    89  5100    22271       13      44      235             0 pickup
	Oct 22 11:13:11 localhost kernel: [ 5102]     0  5102    35741       33      68      285             0 sshd
	Oct 22 11:13:11 localhost kernel: [ 5106]     0  5106    28846       50      14       49             0 bash
	Oct 22 11:13:11 localhost kernel: [ 5136]     0  5136    30799        1      17       56             0 anacron
	Oct 22 11:13:11 localhost kernel: Out of memory: Kill process 3871 (mysqld) score 902 or sacrifice child
	Oct 22 11:13:11 localhost kernel: Killed process 3871 (mysqld) total-vm:12435200kB, anon-rss:754216kB, file-rss:0kB, shmem-rss:0kB




4. MySQL的错误日志 
	2020-10-22T03:13:12.857222Z 0 [Warning] 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
	2020-10-22T03:13:12.857271Z 0 [Warning] 'NO_AUTO_CREATE_USER' sql mode was not set.
	2020-10-22T03:13:12.857294Z 0 [Note] --secure-file-priv is set to NULL. Operations related to importing and exporting data are disabled
	2020-10-22T03:13:12.857319Z 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.22-log) starting as process 5164 ...
	2020-10-22T03:13:12.993299Z 0 [Note] InnoDB: PUNCH HOLE support available
	2020-10-22T03:13:12.993331Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
	2020-10-22T03:13:12.993337Z 0 [Note] InnoDB: Uses event mutexes
	2020-10-22T03:13:12.993342Z 0 [Note] InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
	2020-10-22T03:13:12.993347Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.3
	2020-10-22T03:13:12.993352Z 0 [Note] InnoDB: Using Linux native AIO
	2020-10-22T03:13:12.993839Z 0 [Note] InnoDB: Number of pools: 1
	2020-10-22T03:13:12.994027Z 0 [Note] InnoDB: Using CPU crc32 instructions
	2020-10-22T03:13:12.995645Z 0 [Note] InnoDB: Initializing buffer pool, total size = 10G, instances = 2, chunk size = 128M
	2020-10-22T03:13:15.516803Z 0 [Note] InnoDB: Completed initialization of buffer pool
	2020-10-22T03:13:23.101463Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
	2020-10-22T03:13:23.442472Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
	2020-10-22T03:13:23.589240Z 0 [Note] InnoDB: Log scan progressed past the checkpoint lsn 1118986668
	2020-10-22T03:13:23.686761Z 0 [Note] InnoDB: Ignoring data file './test_db/t_20201021.ibd' with space ID 41, since the redo log references ./test_db/t_20201021.ibd with space ID 40.
	2020-10-22T03:13:23.728784Z 0 [Note] InnoDB: Ignoring data file './test_db/t_20201021.ibd' with space ID 40. Another data file called ./test_db/#sql-ib58-2480555926.ibd exists with the same space ID.
	2020-10-22T03:13:23.728835Z 0 [Note] InnoDB: Ignoring data file './test_db/#sql-ib57-2480555925.ibd' with space ID 41. Another data file called ./test_db/t_20201021.ibd exists with the same space ID.
	2020-10-22T03:13:23.728847Z 0 [Note] InnoDB: Ignoring data file './test_db/t_20201021.ibd' with space ID 40. Another data file called ./test_db/#sql-ib58-2480555926.ibd exists with the same space ID.
	2020-10-22T03:13:23.728855Z 0 [Note] InnoDB: Ignoring data file './test_db/#sql-ib57-2480555925.ibd' with space ID 41. Another data file called ./test_db/t_20201021.ibd exists with the same space ID.
	2020-10-22T03:13:23.806317Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 1119103778
	2020-10-22T03:13:23.811158Z 0 [Note] InnoDB: Database was not shutdown normally!
	2020-10-22T03:13:23.811180Z 0 [Note] InnoDB: Starting crash recovery.
	2020-10-22T03:13:25.202925Z 0 [Note] InnoDB: 1 transaction(s) which must be rolled back or cleaned up in total 3 row operations to undo
	2020-10-22T03:13:25.238081Z 0 [Note] InnoDB: Trx id counter is 2816
	2020-10-22T03:13:25.241214Z 0 [Note] InnoDB: Starting an apply batch of log records to the database...
	InnoDB: Progress in percent: 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 
	2020-10-22T03:13:27.814115Z 0 [Note] InnoDB: Apply batch completed
	2020-10-22T03:13:27.814954Z 0 [Note] InnoDB: Last MySQL binlog file position 0 701964942, file name mysql-bin.000002
	2020-10-22T03:13:28.010520Z 0 [Note] InnoDB: Rolling back trx with id 2407, 3 rows to undo
	2020-10-22T03:13:28.064482Z 0 [Note] InnoDB: Rollback of trx with id 2407 completed
	2020-10-22T03:13:28.198514Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
	2020-10-22T03:13:28.198536Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
	2020-10-22T03:13:28.198623Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 64 MB. Physically writing the file full; Please wait ...
	2020-10-22T03:13:28.747816Z 0 [Note] InnoDB: File './ibtmp1' size is now 64 MB.
	2020-10-22T03:13:28.789429Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
	2020-10-22T03:13:28.789451Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
	2020-10-22T03:13:28.789693Z 0 [Note] InnoDB: Waiting for purge to start
	2020-10-22T03:13:28.839964Z 0 [Note] InnoDB: Waiting for purge to start
	2020-10-22T03:13:28.890669Z 0 [Note] InnoDB: Waiting for purge to start
	2020-10-22T03:13:28.941597Z 0 [Note] InnoDB: Waiting for purge to start
	2020-10-22T03:13:28.991829Z 0 [Note] InnoDB: Waiting for purge to start
	2020-10-22T03:13:29.016369Z 0 [ERROR] InnoDB: Trying to load index `PRIMARY` for table `test_db`.`#sql-ib58-2480555926`, but the index tree has been freed!
	2020-10-22T03:13:29.042096Z 0 [Note] InnoDB: 5.7.22 started; log sequence number 1119103778
	2020-10-22T03:13:29.042562Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 6533ms. The settings might not be optimal. (flushed=0 and evicted=0, during the time.)
	2020-10-22T03:13:29.099074Z 0 [Note] InnoDB: Loading buffer pool(s) from /home/mysql/3306/data/ib_buffer_pool
	2020-10-22T03:13:29.143095Z 0 [Note] InnoDB: Buffer pool(s) load completed at 201022 11:13:29
	2020-10-22T03:13:29.171566Z 0 [Note] Plugin 'FEDERATED' is disabled.
	2020-10-22T03:13:29.270469Z 0 [Note] Recovering after a crash using /home/mysql/3306/logs/mysql-bin
	2020-10-22T03:13:36.852671Z 0 [Note] Starting crash recovery...
	2020-10-22T03:13:36.872707Z 0 [Note] Crash recovery finished.
	2020-10-22T03:13:44.254422Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
	2020-10-22T03:13:44.254458Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
	2020-10-22T03:13:44.266218Z 0 [Note] IPv6 is available.
	2020-10-22T03:13:44.286138Z 0 [Note]   - '::' resolves to '::';
	2020-10-22T03:13:44.286243Z 0 [Note] Server socket created on IP: '::'.
	2020-10-22T03:13:44.369164Z 0 [Warning] 'user' entry 'root@localhost' ignored in --skip-name-resolve mode.
	2020-10-22T03:13:44.369221Z 0 [Warning] 'user' entry 'mysql.session@localhost' ignored in --skip-name-resolve mode.
	2020-10-22T03:13:44.369233Z 0 [Warning] 'user' entry 'mysql.sys@localhost' ignored in --skip-name-resolve mode.
	2020-10-22T03:13:44.369660Z 0 [Warning] 'db' entry 'performance_schema mysql.session@localhost' ignored in --skip-name-resolve mode.
	2020-10-22T03:13:44.369672Z 0 [Warning] 'db' entry 'sys mysql.sys@localhost' ignored in --skip-name-resolve mode.
	2020-10-22T03:13:44.370153Z 0 [Warning] 'proxies_priv' entry '@ root@localhost' ignored in --skip-name-resolve mode.
	2020-10-22T03:13:44.480667Z 0 [Warning] 'tables_priv' entry 'user mysql.session@localhost' ignored in --skip-name-resolve mode.
	2020-10-22T03:13:44.480687Z 0 [Warning] 'tables_priv' entry 'sys_config mysql.sys@localhost' ignored in --skip-name-resolve mode.

	2020-10-22T03:13:44.504329Z 0 [Warning] Neither --relay-log nor --relay-log-index were used; so replication may break when this MySQL server acts as a slave and has his hostname changed!! Please use '--relay-log=localhost-relay-bin' to avoid this problem.
	2020-10-22T03:13:44.519884Z 0 [Warning] Recovery from master pos 4 and file mysql-bin.000011 for channel ''. Previous relay log pos and relay log file had been set to 241, ./localhost-relay-bin.000015 respectively.
	2020-10-22T03:13:44.550609Z 1 [Warning] Storing MySQL user name or password information in the master info repository is not secure and is therefore not recommended. Please consider using the USER and PASSWORD connection options for START SLAVE; see the 'START SLAVE Syntax' in the MySQL Manual for more information.
	2020-10-22T03:13:44.583708Z 1 [Note] Slave I/O thread for channel '': connected to master 'rpl@192.168.0.201:3306',replication started in log 'mysql-bin.000011' at position 4
	2020-10-22T03:13:44.587117Z 2 [Note] Slave SQL thread for channel '' initialized, starting replication in log 'mysql-bin.000011' at position 4, relay log './localhost-relay-bin.000019' position: 4

	-- 重点日志
	2020-10-22T03:13:44.930353Z 2 [Warning] InnoDB: Table test_db/t_20201021 contains 9 user defined columns in InnoDB, but 8 columns in MySQL. Please check INFORMATION_SCHEMA.INNODB_SYS_COLUMNS and http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:13:44.930380Z 2 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:13:44.930430Z 2 [ERROR] Slave SQL for channel '': Error 'Table 'test_db.t_20201021' doesn't exist' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null', Error_code: 1146
	2020-10-22T03:13:44.972156Z 2 [Warning] Slave: Table 'test_db.t_20201021' doesn't exist Error_code: 1146
	2020-10-22T03:13:44.972178Z 2 [ERROR] Error running query, slave SQL thread aborted. Fix the problem, and restart the slave SQL thread with "SLAVE START". We stopped at log 'mysql-bin.000011' position 194
	2020-10-22T03:13:44.997574Z 0 [Note] Event Scheduler: Loaded 0 events
	2020-10-22T03:13:45.005671Z 3 [Note] Event Scheduler: scheduler thread started with id 3
	2020-10-22T03:13:45.013733Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
	Version: '5.7.22-log'  socket: '/home/mysql/3306/data/3306.sock'  port: 3306  MySQL Community Server (GPL)
	2020-10-22T03:31:26.510727Z 0 [Note] Giving 2 client threads a chance to die gracefully
	2020-10-22T03:31:26.510746Z 0 [Note] Shutting down slave threads
	2020-10-22T03:31:26.528005Z 1 [Note] Slave I/O thread killed while reading event for channel ''
	2020-10-22T03:31:26.528020Z 1 [Note] Slave I/O thread exiting for channel '', read up to log 'mysql-bin.000012', position 194
	2020-10-22T03:31:28.707495Z 0 [Note] Forcefully disconnecting 1 remaining clients
	2020-10-22T03:31:28.707538Z 0 [Note] Event Scheduler: Killing the scheduler thread, thread id 3
	2020-10-22T03:31:28.707545Z 0 [Note] Event Scheduler: Waiting for the scheduler thread to reply
	2020-10-22T03:31:28.707620Z 0 [Note] Event Scheduler: Stopped
	2020-10-22T03:31:28.707627Z 0 [Note] Event Scheduler: Purging the queue. 0 events
	2020-10-22T03:31:28.712437Z 0 [Note] Binlog end
	2020-10-22T03:31:28.725992Z 0 [Note] Shutting down plugin 'ngram'
	2020-10-22T03:31:28.726034Z 0 [Note] Shutting down plugin 'ARCHIVE'
	2020-10-22T03:31:28.726039Z 0 [Note] Shutting down plugin 'partition'
	2020-10-22T03:31:28.726056Z 0 [Note] Shutting down plugin 'BLACKHOLE'
	2020-10-22T03:31:28.726060Z 0 [Note] Shutting down plugin 'PERFORMANCE_SCHEMA'
	2020-10-22T03:31:28.726084Z 0 [Note] Shutting down plugin 'CSV'
	2020-10-22T03:31:28.726089Z 0 [Note] Shutting down plugin 'MEMORY'
	2020-10-22T03:31:28.726093Z 0 [Note] Shutting down plugin 'MRG_MYISAM'
	2020-10-22T03:31:28.726097Z 0 [Note] Shutting down plugin 'MyISAM'
	2020-10-22T03:31:28.726105Z 0 [Note] Shutting down plugin 'INNODB_SYS_VIRTUAL'
	2020-10-22T03:31:28.726108Z 0 [Note] Shutting down plugin 'INNODB_SYS_DATAFILES'
	2020-10-22T03:31:28.726111Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESPACES'
	2020-10-22T03:31:28.726114Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN_COLS'
	2020-10-22T03:31:28.726117Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN'
	2020-10-22T03:31:28.726120Z 0 [Note] Shutting down plugin 'INNODB_SYS_FIELDS'
	2020-10-22T03:31:28.726123Z 0 [Note] Shutting down plugin 'INNODB_SYS_COLUMNS'
	2020-10-22T03:31:28.726126Z 0 [Note] Shutting down plugin 'INNODB_SYS_INDEXES'
	2020-10-22T03:31:28.726129Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESTATS'
	2020-10-22T03:31:28.726132Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLES'
	2020-10-22T03:31:28.726135Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_TABLE'
	2020-10-22T03:31:28.726137Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_CACHE'
	2020-10-22T03:31:28.726148Z 0 [Note] Shutting down plugin 'INNODB_FT_CONFIG'
	2020-10-22T03:31:28.726152Z 0 [Note] Shutting down plugin 'INNODB_FT_BEING_DELETED'
	2020-10-22T03:31:28.726154Z 0 [Note] Shutting down plugin 'INNODB_FT_DELETED'
	2020-10-22T03:31:28.726157Z 0 [Note] Shutting down plugin 'INNODB_FT_DEFAULT_STOPWORD'
	2020-10-22T03:31:28.726160Z 0 [Note] Shutting down plugin 'INNODB_METRICS'
	2020-10-22T03:31:28.726163Z 0 [Note] Shutting down plugin 'INNODB_TEMP_TABLE_INFO'
	2020-10-22T03:31:28.726166Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_POOL_STATS'
	2020-10-22T03:31:28.726169Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE_LRU'
	2020-10-22T03:31:28.726172Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE'
	2020-10-22T03:31:28.726175Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX_RESET'
	2020-10-22T03:31:28.726178Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX'
	2020-10-22T03:31:28.726181Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM_RESET'
	2020-10-22T03:31:28.726184Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM'
	2020-10-22T03:31:28.726187Z 0 [Note] Shutting down plugin 'INNODB_CMP_RESET'
	2020-10-22T03:31:28.726190Z 0 [Note] Shutting down plugin 'INNODB_CMP'
	2020-10-22T03:31:28.726193Z 0 [Note] Shutting down plugin 'INNODB_LOCK_WAITS'
	2020-10-22T03:31:28.726196Z 0 [Note] Shutting down plugin 'INNODB_LOCKS'
	2020-10-22T03:31:28.726198Z 0 [Note] Shutting down plugin 'INNODB_TRX'
	2020-10-22T03:31:28.726201Z 0 [Note] Shutting down plugin 'InnoDB'
	2020-10-22T03:31:28.726235Z 0 [Note] InnoDB: FTS optimize thread exiting.
	2020-10-22T03:31:28.726325Z 0 [Note] InnoDB: Starting shutdown...
	2020-10-22T03:31:28.827301Z 0 [Note] InnoDB: Dumping buffer pool(s) to /home/mysql/3306/data/ib_buffer_pool
	2020-10-22T03:31:28.827494Z 0 [Note] InnoDB: Buffer pool(s) dump completed at 201022 11:31:28
	2020-10-22T03:31:34.714826Z 0 [Note] InnoDB: Shutdown completed; log sequence number 1119110224
	2020-10-22T03:31:34.714950Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
	2020-10-22T03:31:34.714974Z 0 [Note] Shutting down plugin 'sha256_password'
	2020-10-22T03:31:34.714978Z 0 [Note] Shutting down plugin 'mysql_native_password'
	2020-10-22T03:31:34.769283Z 0 [Note] Shutting down plugin 'binlog'
	2020-10-22T03:31:34.848464Z 0 [Note] /usr/local/mysql/bin/mysqld: Shutdown complete


5. DDL生成的临时文件并没有被删除
	[root@localhost data]# cd test_db/
	[root@localhost test_db]# ll
	总用量 1724572
	-rw-r-----. 1 mysql mysql        67 10月 19 11:52 db.opt
	-rw-r-----. 1 mysql mysql      8828 10月 22 10:56 #sql-f1f_11.frm
	-rw-r-----. 1 mysql mysql 876609536 10月 22 11:13 #sql-ib58-2480555926.ibd
	-rw-r-----. 1 mysql mysql      8696 10月 19 11:52 t_20201019.frm
	-rw-r-----. 1 mysql mysql    114688 10月 19 21:41 t_20201019.ibd
	-rw-r-----. 1 mysql mysql      8804 10月 21 01:38 t_20201021.frm
	-rw-r-----. 1 mysql mysql 889192448 10月 22 11:09 t_20201021.ibd


6. 小结
	innodb_buffer_pool_size 设置太大，再加上server层使用的内存，导致内存超过系统上限被oom。
	 
	本案例关联的笔记：《2020-10-22-Online DDL之后第2个从库报表结构不存在的报错.sq》