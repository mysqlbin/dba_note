1. 正常的stop slave流程
2. stop slave 为什么会慢
3. 从库启动需要读取的信息
	3.1 slave_master_info 表
	3.2 slave_relay_log_info 表
	3.3 slave_worker_info 表
	3.4 Retrieved_Gtid_Set
	3.5 Executed_Gtid_Set 
4. 关于 repository 表的事务性
5. 保证复制信息安全性的重要参数
	1. master_info_repository 
	2. relay_log_info_repository
	3. sync_master_info
	4. sync_relay_log_info
	5. sync_relay_log
	6. recovery_relay_log
6. 结合 recovery_relay_log 参数了解从库的恢复流程


1. 正常的stop slave流程
	学习从库正常关闭做了哪些工作即 stop slave 命令发起后做了哪些工作
	在第23章节的学习中,我们知道单 SQL 线程会以 event 为单位进行应用,最前面有一层循环用于循环读取 event 并且应用, 响应 stop slave 正是在这个循环的判断条件中
	
	stop slave 命令是用户线程发起的, 需要作用于 SQL 线程和 IO 线程, IO 线程和 SQL 线程要达到判断点, 需要将上一个 event 处理完成再次循环的时候才能进行
	如果  IO 线程和 SQL 线程 没有正常终止, 那么用户线程执行的 stop slave 命令需要一直堵塞等待其完成, 参数 rpl_stop_slave_timeout 可以控制等待多久,虽然
	这个参数可以让用户线程退出, 但是实际 IO 线程 和 SQL 线程 的关闭操作可能还是没有完成, 它们依然在继续关闭
	
	通过 stop slave 命令正常的关闭从库一般不会有任何问题, 因为我们的重要信息都已经强制持久化了, 包含: slave_master_info 表 slave_relay_log_info 表 和 relay log
	在 MTS 中还会刷新 slave_worker_info 表和进行检查点
	
2. stop slave 为什么会慢
	首先, 从 25-01.png 中可以看到, stop slave 命令并不会及时响应, 它会在前一个(上一个) event 执行完成后才进行响应, 同时对于 DML 语句而言可能还涉及到回滚
	stop salve 慢的原因如下:
		1. DDL语句包含在 query_event 中, 需要 DDL 语句执行完成才响应 stop slave 命令
		2. DML 语句可能包含多个 dml event, 前一个(上一个) event 执行完成后才响应 stop slave 命令, 然后将整个事务进行回滚.
		   # DML 大事务回滚时间会比较长。
	因此, 如果是大表的 DDL 或者 大事务 在执行期间 执行 stop slave 都会很慢, 因此如果有类似情况最好谨慎操作.
	
	查看正在执行事务的命令:
		show processlist;
		select * from information_schema.innodb_trx;
		
	# 理解了。

3. 从库启动需要读取的信息
	3.1 slave_master_info 表
		root@mysqldb 10:13:  [(none)]> show create table  mysql.slave_master_info\G;
		
		*************************** 1. row ***************************
			   Table: slave_master_info
		Create Table: CREATE TABLE `slave_master_info` (
		  `Number_of_lines` int(10) unsigned NOT NULL COMMENT 'Number of lines in the file.',
		  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The name of the master binary log currently being read from the master.',
		  `Master_log_pos` bigint(20) unsigned NOT NULL COMMENT 'The master log position of the last read event.',
		  `Host` char(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'The host name of the master.',
		  `User_name` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The user name used to connect to the master.',
		  `User_password` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The password used to connect to the master.',
		  `Port` int(10) unsigned NOT NULL COMMENT 'The network port used to connect to the master.',
		  `Connect_retry` int(10) unsigned NOT NULL COMMENT 'The period (in seconds) that the slave will wait before trying to reconnect to the master.',
		  `Enabled_ssl` tinyint(1) NOT NULL COMMENT 'Indicates whether the server supports SSL connections.',
		  `Ssl_ca` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file used for the Certificate Authority (CA) certificate.',
		  `Ssl_capath` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The path to the Certificate Authority (CA) certificates.',
		  `Ssl_cert` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the SSL certificate file.',
		  `Ssl_cipher` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the cipher in use for the SSL connection.',
		  `Ssl_key` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the SSL key file.',
		  `Ssl_verify_server_cert` tinyint(1) NOT NULL COMMENT 'Whether to verify the server certificate.',
		  `Heartbeat` float NOT NULL,
		  `Bind` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Displays which interface is employed when connecting to the MySQL server',
		  `Ignored_server_ids` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The number of server IDs to be ignored, followed by the actual server IDs',
		  `Uuid` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The master server uuid.',
		  `Retry_count` bigint(20) unsigned NOT NULL COMMENT 'Number of reconnect attempts, to the master, before giving up.',
		  `Ssl_crl` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file used for the Certificate Revocation List (CRL)',
		  `Ssl_crlpath` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The path used for Certificate Revocation List (CRL) files',
		  `Enabled_auto_position` tinyint(1) NOT NULL COMMENT 'Indicates whether GTIDs will be used to retrieve events from the master.',
		  `Channel_name` char(64) NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
		  `Tls_version` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Tls version',
		  PRIMARY KEY (`Channel_name`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 COMMENT='Master Information'
		1 row in set (0.00 sec)
		
		关键信息： Master_log_name 和 Master_log_pos 代表 IO线程读取主库 binary log 的位置
		对应 show slave status\G; 中的：
              Master_Log_File: mysql-bin.000238
          Read_Master_Log_Pos: 190533643
		  
	3.2 slave_relay_log_info 表
		
		root@mysqldb 10:16:  [(none)]> show create table  mysql.slave_relay_log_info\G;
		*************************** 1. row ***************************
			   Table: slave_relay_log_info
		Create Table: CREATE TABLE `slave_relay_log_info` (
		  `Number_of_lines` int(10) unsigned NOT NULL COMMENT 'Number of lines in the file or rows in the table. Used to version table definitions.',
		  `Relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The name of the current relay log file.',
		  `Relay_log_pos` bigint(20) unsigned NOT NULL COMMENT 'The relay log position of the last executed event.',
		  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The name of the master binary log file from which the events in the relay log file were read.',
		  `Master_log_pos` bigint(20) unsigned NOT NULL COMMENT 'The master log position of the last executed event.',
		  `Sql_delay` int(11) NOT NULL COMMENT 'The number of seconds that the slave must lag behind the master.',
		  `Number_of_workers` int(10) unsigned NOT NULL,
		  `Id` int(10) unsigned NOT NULL COMMENT 'Internal Id that uniquely identifies this record.',
		  `Channel_name` char(64) NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
		  PRIMARY KEY (`Channel_name`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 COMMENT='Relay Log Information'
		1 row in set (0.00 sec

		关键信息： 
			Relay_log_name  和 Relay_log_pos  代表 SQL 线程应用 relay log 的位置
			Master_log_name 和 Master_log_pos 代表 SQL 线程应用主库 binary log 的位置
		
		对应 show slave status\G; 中的：# 没毛病
				   Relay_Log_File: db-b-relay-bin.000005
					Relay_Log_Pos: 190533856
			Relay_Master_Log_File: mysql-bin.000238
			  Exec_Master_Log_Pos: 190533643
			  
	如果是 MTS ，上面的信息是 协调线程检查点指向的事务信息。
	
	判断主从是否有延迟：
		IO 线程 = SQL 线程：
			Master_Log_File      = Relay_Master_Log_File
			Read_Master_Log_Pos  = Exec_Master_Log_Pos 

	3.3 slave_worker_info 表
	
		root@mysqldb 10:11:  [(none)]> show create table  mysql.slave_worker_info\G;
		*************************** 1. row ***************************
			   Table: slave_worker_info
		Create Table: CREATE TABLE `slave_worker_info` (
		  `Id` int(10) unsigned NOT NULL,
		  `Relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
		  `Relay_log_pos` bigint(20) unsigned NOT NULL,
		  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
		  `Master_log_pos` bigint(20) unsigned NOT NULL,
		  `Checkpoint_relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
		  `Checkpoint_relay_log_pos` bigint(20) unsigned NOT NULL,
		  `Checkpoint_master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
		  `Checkpoint_master_log_pos` bigint(20) unsigned NOT NULL,
		  `Checkpoint_seqno` int(10) unsigned NOT NULL,
		  `Checkpoint_group_size` int(10) unsigned NOT NULL,
		  `Checkpoint_group_bitmap` blob NOT NULL,
		  `Channel_name` char(64) NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
		  PRIMARY KEY (`Channel_name`,`Id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 COMMENT='Worker Information'
		1 row in set (0.00 sec)

		MTS下用于工作线程(即worker线程)信息的持久化。
		
		
	3.4 Retrieved_Gtid_Set  
		从库接收完成的 gtid set 
		
	3.5 Executed_Gtid_Set 
		从库执行完成的 gtid set 
	
	3.6 relay log
		由 IO 线程写入, 由 SQL 线程(MTS协调线程)读取.
	
4. 关于 repository 表的事务性
	主要涉及到两个参数:
		master_info_repository 
		relay_log_info_repository
		如果它们设置为 table 能够具有事务性, 那就完全找不到设置为 file 的理由了.
	以 relay_log_info_repository 为例
		当 relay_log_info_repository = table , 在单 SQL 线程 和 MTS 中含义还有一些区别:
			单 SQL 线程: 表示每次事务提交都会更新 slave_relay_log_info 表
			MTS        : 表示每次事务提交都会更新 slave_worker_info 表 , slave_relay_log_info 表的更新则由检查点负责
			
		事务性: 
			将更改 slave_relay_log_info 表 和 slave_worker_info 表的操作放到应用 event(即 DML event) 的事务中去就可以了.
		验证:
			只需要证明修改 slave_relay_log_info 表 和 slave_worker_info 表的操作和本身的事务是一个事务ID就可以了.
			下面是 debug 的结果:
				修改用户表 tii 的事务ID
					(gdb) p trx->id
					$1 = 350783
					(gdb) p table->name->m_name
					$s2 =  "testmts/tii"
				修改 slave_worker_info 表的事务ID
					(gdb) p trx->id
					$3 = 350783
					(gdb) p table->name->m_name
					$s4 =  "mysql/slave_worker_info"
	
			可以看到 trx->id 都是同一个ID, 因此它们是同一个事务, 会一直提交一起回滚, 这样也就保证了  slave_relay_log_info 表 和 slave_worker_info 表信息的准确性, 设置为 file 则不可能具有这种特性.
			
5. 保证复制信息安全性的重要参数
	1. master_info_repository 
		只考虑为 table 的情况
		该变量的设置还直接影响了 sync_master_info 系统变量的设置
		相关参考: 
			https://dev.mysql.com/doc/refman/5.7/en/replication-options-slave.html#sysvar_master_info_repository
			
	2. relay_log_info_repository
		只考虑为 table 的情况
		
	3. sync_master_info
		
		master_info_repository = TABLE.  
			If the value of sync_master_info is greater than 0, the slave updates its master info repository table after every sync_master_info events. If it is 0, the table is never updated.
		
			如果 master_info_repository 设置为  table, 代表 IO 线程写入多少个 event 到 relay log 后进行一次写 slave_master_info 表操作.   # 没有 master_info_repository 表呀.
		
			根据 sync_master_info 的设置, 决定是否更新 slave_master_info 表, 单位为 event   # 参考 第22章节-从库的 IO 线程
			
			相关参考
				https://dev.mysql.com/doc/refman/5.7/en/replication-options-slave.html#sysvar_sync_master_info
			
	4. sync_relay_log_info
		relay_log_info_repository = table : 
			单 SQL 线程下每次事务的提交都会更新一次 slave_relay_log_info 表
			MTS 下 每次事务提交都会更新 slave_worker_info 相关工作线程的信息, sync_relay_log_info 表 则是由协调线程的检查点进行更改.
		
			https://dev.mysql.com/doc/refman/5.7/en/replication-options-slave.html#sysvar_sync_relay_log_info
			
			sync_relay_log_info = N > 0
				If relay_log_info_repository is set to FILE, the slave synchronizes its relay-log.info file to disk (using fdatasync()) after every N transactions.

				If relay_log_info_repository is set to TABLE, and the storage engine for that table is transactional, the table is updated after each transaction. (The sync_relay_log_info setting is effectively ignored in this case.)
				
					如果将relay_log_info_repository设置为TABLE，并且该表的存储引擎是事务性的，则在每次事务处理后都会更新该表。 （在这种情况下，实际上会忽略sync_relay_log_info设置。）
				
				If relay_log_info_repository is set to TABLE, and the storage engine for that table is not transactional, the table is updated after every N events.

					如果将relay_log_info_repository设置为TABLE，并且该表的存储引擎不是事务性的，则在每N个事件后更新该表。
					
					
	5. sync_relay_log
		代表 IO 线程写入多少个 event 到 relay log 后进行一次 relay log 的 sync
		设置为 1 会严重的影响性能
		
	6. recovery_relay_log
		这个参数的作用极为重要，默认值为 10000
		recovery_relay_log = on : 
			其基本理念就是从 从库 执行到的位置重新拉取 event 重新执行（即 依赖于 slave_relay_log_info 表中的信息）, 而不考虑现有的 relay log 、 retrieved_gtid_set 和 slave_master_info 中的信息,这样虽然增加了一部分带宽消耗但是弱化了 relay log 、 retrieved_gtid_set 和 slave_master_info  的作用, 是提高从库性能的基础.
			同时在 MTS 模式下还会影响 MTS 恢复的时机.
		# 理解了.	
			
6. 结合 recovery_relay_log 参数了解从库的恢复流程
	recovery_relay_log 的作用是非常大的, 主要作用如下:
		6.1 recovery_relay_log = 1 
			不需要初始化 retrieved_gtid_set , 因此避免了扫描 relay log. 这个很容易观察到, 设置 '--skip-slave-start' 后重启MySQL 实例观察  show slave status 命令中的 retrieved_gtid_set 是否有值就可以了, 如下:
		
				Retrieved_Gtid_Set: 
				 Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-700502
					 Auto_Position: 1
				
				root@mysqldb 16:53:  [(none)]> show global variables like '%recovery%';
				+-----------------------------+-------+
				| Variable_name               | Value |
				+-----------------------------+-------+
				| binlog_gtid_simple_recovery | ON    |
				| innodb_force_recovery       | 0     |
				| relay_log_recovery          | ON    |
				+-----------------------------+-------+
				3 rows in set (0.00 sec)
			
			这个时候如果是 gtid auto_position 模式,  retrieved_gtid_set 和 Executed_Gtid_Set 的并集就是 Executed_Gtid_Set,  主库的 dump 线程将把 Executed_Gtid_Set 之后的全部事务发送给从库. 这也符合使用执行的位置重新拉取主库的 binary log 的理念.
			
			# 理解了.
			
		6.2 MTS 下 recovery_relay_log = 1 
		
		6.3 单 SQL 线程 下 recovery_relay_log = 1
			非常简单暴力, 直接使用 'rli' ('rli' 是 slave_relay_log_info 的内存结构 ) 的  Master_log_name 和 Master_log_pos  覆盖 'mi' ('mi' 是 slave_master_info 的内存结构) 的  Master_log_name 和 Master_log_pos , 然后将 'rli' 的 Relay_log_name  和 Relay_log_pos 重置到最新 relay log的位置; 言外之意就是老的 relay log 和 slave_master_info 表的信息不用管了, 从执行到的位置重新拉取 event 重新执行就好了, 这样一定能够保证正确性.
			
			# 理解了
		
		
		
			