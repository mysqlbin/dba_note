

1. 环境 
2. 配置 [binlog*]
3. 检查整个复制环境状况
4. 数据准备
5. 切换测试	
6. 查看数据是否有补全
7. 宕机的master恢复


1. 环境 

	hostname    主机          端口号  通信端口号(server-id)    server_uuid                              MySQL版本      role      mha-node
	mha01		192.168.0.101  3306   3306101				   1b9bc372-0042-11ea-b8fa-0800274617cc     MySQL 8.0.18   Master 
	mha02       192.168.0.102  3306   3306102                  e588e3eb-0042-11ea-a95b-0800275dde84     MySQL 8.0.18   Slave     Mha manager & slave 
	mha03       192.168.0.103  3306   3306103                  cbe6921b-0043-11ea-b484-0800270d5e94     MySQL 8.0.18   Slave     new master
	VIP         192.168.0.104



2. 配置 [binlog*]
	
	MHA在GTID模式下，需要配置[binlog*]，可以是单独的Binlog Server服务器，也可以是主库的binlog目录。
	如果不配置[binlog*]，即使主服务器没挂，也不会从主服务器拉binlog，所有未传递到从库的日志将丢失
	注意事项:
		如果配置[binlog*] ,需要配置在 Mha manage节点上.    ************
	缺点:
		如果配置[binlog*], 每次发生切换后都需要手工修改这个 /etc/masterha/app1.conf 配置文件


	mha02:
		shell> cat /etc/masterha/app1.conf
		[binlog1]
		hostname=192.168.0.101
		master_binlog_dir=/data/mysql/mysql3306/data    -- 配置binlog，也就是主库的binlog目录。
		no_master=1


3. 检查整个复制环境状况

	在 mha02 上用root用户操作。
	masterha_check_repl --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf
	
	错误1:
		Fri Nov  8 07:11:30 2019 - [error][/usr/share/perl5/vendor_perl/MHA/ServerManager.pm, ln781] Multi-master configuration is detected, 
			but two or more masters are either writable (read-only is not set) or dead! Check configurations for details. Master configurations are as below: 
				Master 192.168.0.103(192.168.0.103:3306), replicating from 192.168.0.101(192.168.0.101:3306)
				Master 192.168.0.101(192.168.0.101:3306), replicating from 192.168.0.103(192.168.0.103:3306)
				
		Fri Nov  8 07:11:30 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln427] Error happened on checking configurations.  
			at /usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm line 329.
		Fri Nov  8 07:11:30 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln525] Error happened on monitoring servers.
		Fri Nov  8 07:11:30 2019 - [info] Got exit code 1 (Not master dead).

		MySQL Replication Health is NOT OK!
		
		
		mha01:
			mysql> stop slave;
			mysql> reset slave all;
		
		
	错误2:
	
		Fri Nov  8 07:14:24 2019 - [debug]    Relay log info repository: TABLE
		Fri Nov  8 07:14:24 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Fri Nov  8 07:14:24 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Fri Nov  8 07:14:24 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Fri Nov  8 07:14:24 2019 - [info]     GTID ON
		Fri Nov  8 07:14:24 2019 - [debug]    Relay log info repository: TABLE
		Fri Nov  8 07:14:24 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Fri Nov  8 07:14:24 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Fri Nov  8 07:14:24 2019 - [info] Current Alive Master: 192.168.0.101(192.168.0.101:3306)
		Fri Nov  8 07:14:24 2019 - [info] Checking slave configurations..
		Fri Nov  8 07:14:24 2019 - [info]  read_only=1 is not set on slave 192.168.0.102(192.168.0.102:3306).
		Fri Nov  8 07:14:24 2019 - [info]  read_only=1 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Fri Nov  8 07:14:24 2019 - [info] Checking replication filtering settings..
		Fri Nov  8 07:14:24 2019 - [info]  binlog_do_db= , binlog_ignore_db= 
		Fri Nov  8 07:14:24 2019 - [info]  Replication filtering check ok.
		Fri Nov  8 07:14:24 2019 - [info] GTID (with auto-pos) is supported. Skipping all SSH and Node package checking.
		Fri Nov  8 07:14:24 2019 - [debug] SSH connection test to 192.168.0.102, option -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o BatchMode=yes -o ConnectTimeout=5, timeout 5
		Fri Nov  8 07:14:25 2019 - [info] HealthCheck: SSH to 192.168.0.102 is reachable.
		Fri Nov  8 07:14:25 2019 - [info] Binlog server 192.168.0.102 is reachable.
		Fri Nov  8 07:14:25 2019 - [info] Checking recovery script configurations on 192.168.0.102(192.168.0.102:3306)..
		Fri Nov  8 07:14:25 2019 - [info]   Executing command: save_binary_logs --command=test --start_pos=4 --binlog_dir=/data/mysql/mysql3306/data --output_file=/var/log/masterha/app1/save_binary_logs_test --manager_version=0.58 --start_file=mysql-bin.000014 --debug  
		Fri Nov  8 07:14:25 2019 - [info]   Connecting to root@192.168.0.102(192.168.0.102:22).. 
		Failed to save binary log: Binlog not found from /data/mysql/mysql3306/data! 
		If you got this error at MHA Manager, please set "master_binlog_dir=/path/to/binlog_directory_of_the_master" correctly in the MHA Manager s configuration file and try again.
		 at /usr/bin/save_binary_logs line 123.
			eval {...} called at /usr/bin/save_binary_logs line 70
			main::main() called at /usr/bin/save_binary_logs line 66
		Fri Nov  8 07:14:25 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln161] Binlog setting check failed!
		Fri Nov  8 07:14:25 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln267] Binlog server configuration failed.
		Fri Nov  8 07:14:25 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln427] Error happened on checking configurations.  at /usr/bin/masterha_check_repl line 48.
		Fri Nov  8 07:14:25 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln525] Error happened on monitoring servers.
		Fri Nov  8 07:14:25 2019 - [info] Got exit code 1 (Not master dead).

		MySQL Replication Health is NOT OK!
		
		原因: 
			配置[binlog*]，不是主库的binlog目录,
		解决办法:
			mha02:
			shell> cat /etc/masterha/app1.conf
			[binlog1]
			hostname=192.168.0.101
			master_binlog_dir=/data/mysql/mysql3306/data
			no_master=1
		
	错误3:
	
		Fri Nov  8 10:41:50 2019 - [error][/usr/share/perl5/vendor_perl/MHA/ServerManager.pm, ln653] There are 2 non-slave servers! MHA manages at most one non-slave server. Check configurations.
		Fri Nov  8 10:41:50 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln427] Error happened on checking configurations.  at /usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm line 329.
		Fri Nov  8 10:41:50 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln525] Error happened on monitoring servers.
		Fri Nov  8 10:41:50 2019 - [info] Got exit code 1 (Not master dead).

		MySQL Replication Health is NOT OK!

		原因:
			配置文件中 有两个从库, 但是实际上只有一个从库.
			
			
4. 数据准备
	mha01: 写入第1条记录
		use test;
		truncate table t1;
		insert into t1 values (1);
		
	mha02: 停止io_thread 模拟主从延时：
		stop slave io_thread;
		
	mha01: 写入第2条记录
		insert into t1 values (2);

	mha03: 停止io_thread 模拟主从延时：
		stop slave io_thread;
		
	mha01: 写入第3条记录
		insert into t1 values (3);
	
	很明显从节点mha02落后于从节点mha03、从节点mha03落后于主节点mha01
	把 mha03提升为库, 由于 mha03就是最新的 slave, 不需要补全跟最新slave的差异 
	此时主库有未发送到从库的binlog
	
5. 切换测试	

关闭mha01节点数据库服务
	shell> /etc/init.d/mysql stop
		
mha01节点手动故障切换, 在 mha02上执行:
	 
	shell> masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --dead_master_host=192.168.0.101 --master_state=dead --new_master_host=192.168.0.103 --ignore_last_failover

	
	--dead_master_ip=<dead_master_ip> is not set. Using 192.168.0.101.
	--dead_master_port=<dead_master_port> is not set. Using 3306.
	Fri Nov  8 07:41:32 2019 - [info] Reading default configuration from /etc/masterha/masterha_default.conf..
	Fri Nov  8 07:41:32 2019 - [info] Reading application default configuration from /etc/masterha/app1.conf..
	Fri Nov  8 07:41:32 2019 - [info] Reading server configuration from /etc/masterha/app1.conf..
	Fri Nov  8 07:41:32 2019 - [info] MHA::MasterFailover version 0.58.
	Fri Nov  8 07:41:32 2019 - [info] Starting master failover.
	Fri Nov  8 07:41:32 2019 - [info] 
	
	==================== 1、配置检查阶段，Start ====================
	
	Fri Nov  8 07:41:32 2019 - [info] * Phase 1: Configuration Check Phase..
	Fri Nov  8 07:41:32 2019 - [info] 
	Fri Nov  8 07:41:32 2019 - [debug] SSH connection test to 192.168.0.101, option -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o BatchMode=yes -o ConnectTimeout=5, timeout 5
	Fri Nov  8 07:41:33 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
	Fri Nov  8 07:41:33 2019 - [info] Binlog server 192.168.0.101 is reachable.
	Fri Nov  8 07:41:33 2019 - [debug] Connecting to servers..
	Fri Nov  8 07:41:33 2019 - [debug] Got MySQL error when connecting 192.168.0.101(192.168.0.101:3306) :2003:Can t connect to MySQL server on '192.168.0.101' (111)
	Fri Nov  8 07:41:34 2019 - [debug]  Connected to: 192.168.0.102(192.168.0.102:3306), user=root
	Fri Nov  8 07:41:34 2019 - [debug]  Number of slave worker threads on host 192.168.0.102(192.168.0.102:3306): 0
	Fri Nov  8 07:41:34 2019 - [debug]  Connected to: 192.168.0.103(192.168.0.103:3306), user=root
	Fri Nov  8 07:41:34 2019 - [debug]  Number of slave worker threads on host 192.168.0.103(192.168.0.103:3306): 0
	Fri Nov  8 07:41:34 2019 - [debug]  Comparing MySQL versions..
	Fri Nov  8 07:41:34 2019 - [debug]   Comparing MySQL versions done.
	Fri Nov  8 07:41:34 2019 - [debug] Connecting to servers done.
	Fri Nov  8 07:41:34 2019 - [info] GTID failover mode = 1
	Fri Nov  8 07:41:34 2019 - [info] Dead Servers:
	Fri Nov  8 07:41:34 2019 - [info]   192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 07:41:34 2019 - [info] Checking master reachability via MySQL(double check)...
	Fri Nov  8 07:41:34 2019 - [info]  ok.
	Fri Nov  8 07:41:34 2019 - [info] Alive Servers:
	Fri Nov  8 07:41:34 2019 - [info]   192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 07:41:34 2019 - [info]   192.168.0.103(192.168.0.103:3306)
	Fri Nov  8 07:41:34 2019 - [info] Alive Slaves:
	Fri Nov  8 07:41:34 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 07:41:34 2019 - [info]     GTID ON
	Fri Nov  8 07:41:34 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 07:41:34 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 07:41:34 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 07:41:34 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 07:41:34 2019 - [info]     GTID ON
	Fri Nov  8 07:41:34 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 07:41:34 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 07:41:34 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	
	******************** 输出的信息会询问你是否进行切换：选择是否继续进行 ********************
	Master 192.168.0.101(192.168.0.101:3306) is dead. Proceed? (yes/NO): yes
	Fri Nov  8 07:41:39 2019 - [info] Starting GTID based failover.
	Fri Nov  8 07:41:39 2019 - [info] 
	Fri Nov  8 07:41:39 2019 - [info] ** Phase 1: Configuration Check Phase completed.
	==================== 1、配置检查阶段，End ====================
	
	Fri Nov  8 07:41:39 2019 - [info] 
	
	==================== 2、故障Master关闭阶段，Start ====================
	Fri Nov  8 07:41:39 2019 - [info] * Phase 2: Dead Master Shutdown Phase..
	Fri Nov  8 07:41:39 2019 - [info] 
	Fri Nov  8 07:41:39 2019 - [debug] SSH connection test to 192.168.0.101, option -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o BatchMode=yes -o ConnectTimeout=5, timeout 5
	Fri Nov  8 07:41:39 2019 - [debug]  Stopping IO thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 07:41:39 2019 - [debug]  Stopping IO thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 07:41:39 2019 - [debug]  Stop IO thread on 192.168.0.102(192.168.0.102:3306) done.
	Fri Nov  8 07:41:39 2019 - [debug]  Stop IO thread on 192.168.0.103(192.168.0.103:3306) done.
	Fri Nov  8 07:41:39 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
	Fri Nov  8 07:41:39 2019 - [info] Forcing shutdown so that applications never connect to the current master..
	Fri Nov  8 07:41:39 2019 - [info] Executing master IP deactivation script:
	Fri Nov  8 07:41:39 2019 - [info]   /etc/masterha/master_ip_failover --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --command=stopssh --ssh_user=root  
	Fri Nov  8 07:41:39 2019 - [info]  done.
	Fri Nov  8 07:41:39 2019 - [warning] shutdown_script is not set. Skipping explicit shutting down of the dead master.
	Fri Nov  8 07:41:39 2019 - [info] * Phase 2: Dead Master Shutdown Phase completed.
	
	==================== 2、故障Master关闭阶段，End ====================
	
	
	Fri Nov  8 07:41:39 2019 - [info] 
	
	==================== 3、新Master恢复阶段，Start ====================
	Fri Nov  8 07:41:39 2019 - [info] * Phase 3: Master Recovery Phase..
	Fri Nov  8 07:41:39 2019 - [info] 
	
	==================== 3.1、获取最新的Slave ====================
	******************** 最新Slave，用于补全New Master缺少的数据；用于save故障Master的binlog的起始点 ********************

	Fri Nov  8 07:41:39 2019 - [info] * Phase 3.1: Getting Latest Slaves Phase..
	Fri Nov  8 07:41:39 2019 - [info] 
	Fri Nov  8 07:41:39 2019 - [debug] Fetching current slave status..
	Fri Nov  8 07:41:39 2019 - [debug]  Fetching current slave status done.
	Fri Nov  8 07:41:39 2019 - [info] The latest binary log file/position on all slaves is mysql-bin.000014:2046
	Fri Nov  8 07:41:39 2019 - [info] Retrieved Gtid Set: 1b9bc372-0042-11ea-b8fa-0800274617cc:15-18
	Fri Nov  8 07:41:39 2019 - [info] Latest slaves (Slaves that received relay log files to the latest):
	Fri Nov  8 07:41:39 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 07:41:39 2019 - [info]     GTID ON
	Fri Nov  8 07:41:39 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 07:41:39 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 07:41:39 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 07:41:39 2019 - [info] The oldest binary log file/position on all slaves is mysql-bin.000014:1793
	Fri Nov  8 07:41:39 2019 - [info] Retrieved Gtid Set: 1b9bc372-0042-11ea-b8fa-0800274617cc:15-17,
	cbe6921b-0043-11ea-b484-0800270d5e94:4
	Fri Nov  8 07:41:39 2019 - [info] Oldest slaves:
	Fri Nov  8 07:41:39 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 07:41:39 2019 - [info]     GTID ON
	Fri Nov  8 07:41:39 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 07:41:39 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 07:41:39 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 07:41:39 2019 - [info] 
	
	==================== 3.3、选举新Master ====================
	
	Fri Nov  8 07:41:39 2019 - [info] * Phase 3.3: Determining New Master Phase..
	Fri Nov  8 07:41:39 2019 - [info] 
	Fri Nov  8 07:41:39 2019 - [info] 192.168.0.103 can be new master.
	Fri Nov  8 07:41:39 2019 - [info] New master is 192.168.0.103(192.168.0.103:3306)
	Fri Nov  8 07:41:39 2019 - [info] Starting master failover..
	Fri Nov  8 07:41:39 2019 - [info] 
	From:
	192.168.0.101(192.168.0.101:3306) (current master)
	 +--192.168.0.102(192.168.0.102:3306)
	 +--192.168.0.103(192.168.0.103:3306)

	To:
	192.168.0.103(192.168.0.103:3306) (new master)
	 +--192.168.0.102(192.168.0.102:3306)

	Starting master switch from 192.168.0.101(192.168.0.101:3306) to 192.168.0.103(192.168.0.103:3306)? (yes/NO): yes
	Fri Nov  8 07:41:42 2019 - [info] New master decided manually is 192.168.0.103(192.168.0.103:3306)
	Fri Nov  8 07:41:42 2019 - [info] 
	
	==================== 3.3、新的Master恢复 ====================

	Fri Nov  8 07:41:42 2019 - [info] * Phase 3.3: New Master Recovery Phase..
	Fri Nov  8 07:41:42 2019 - [info] 
	
	******************** 等待新Master应用完自己的relay-log ********************
	Fri Nov  8 07:41:42 2019 - [info]  Waiting all logs to be applied.. 
	Fri Nov  8 07:41:42 2019 - [info]   done.
	
	Fri Nov  8 07:41:42 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 07:41:42 2019 - [debug]   done.
	
	
	----------------------- 在故障Master/BinlogServer执行，取最新Slave之后的部分
							
	
	Fri Nov  8 07:41:42 2019 - [info] -- Saving binlog from host 192.168.0.101 started, pid: 16074
	Fri Nov  8 07:41:43 2019 - [info] 
	Fri Nov  8 07:41:43 2019 - [info] Log messages from 192.168.0.101 ...
	Fri Nov  8 07:41:43 2019 - [info] 
	Fri Nov  8 07:41:42 2019 - [info] Fetching binary logs from binlog server 192.168.0.101..
	Fri Nov  8 07:41:42 2019 - [info] Executing binlog save command: save_binary_logs --command=save --start_file=mysql-bin.000014  --start_pos=2046 --output_file=/var/log/masterha/app1/saved_binlog_binlog1_20191108074132.binlog --handle_raw_binlog=0 --skip_filter=1 --disable_log_bin=0 --manager_version=0.58 --oldest_version=8.0.18  --debug  --binlog_dir=/data/mysql/mysql3306/data 
	  Creating /var/log/masterha/app1 if not exists..    ok.
	 Concat binary/relay logs from mysql-bin.000014 pos 2046 to mysql-bin.000014 EOF into /var/log/masterha/app1/saved_binlog_binlog1_20191108074132.binlog ..
	 
	Executing command: mysqlbinlog --start-position=2046  /data/mysql/mysql3306/data/mysql-bin.000014 >> /var/log/masterha/app1/saved_binlog_binlog1_20191108074132.binlog
	 Concat succeeded.
	 
	******************** 将得到的binlog scp 到 手动failover 运行的工作目录 ********************
	******************** 这就是补binlog数据到从库的逻辑 ********************
	-------------------- saved_binlog_192.168.0.101_binlog1_20191108074132.binlog
	
	Fri Nov  8 07:41:42 2019 - [info] scp from root@192.168.0.101:/var/log/masterha/app1/saved_binlog_binlog1_20191108074132.binlog to local:/var/log/masterha/app1/saved_binlog_192.168.0.101_binlog1_20191108074132.binlog succeeded.
	
	Fri Nov  8 07:41:43 2019 - [info] End of log messages from 192.168.0.101.
	Fri Nov  8 07:41:43 2019 - [info] Saved mysqlbinlog size from 192.168.0.101 is 2622 bytes.
	Fri Nov  8 07:41:43 2019 - [info] Checking if super_read_only is defined and turned on..
	Fri Nov  8 07:41:43 2019 - [info]  not present or turned off, ignoring.
	
	---------------------------------- 应用差异日志 --------------------------------------------

	Fri Nov  8 07:41:43 2019 - [info] Applying differential binlog /var/log/masterha/app1/saved_binlog_192.168.0.101_binlog1_20191108074132.binlog ..
	Fri Nov  8 07:41:43 2019 - [info] Differential log apply from binlog server succeeded.
	
	******************** 新Master应用完binlog，得到当前位置 ********************
	
	Fri Nov  8 07:41:43 2019 - [info] Getting new master s binlog name and position..
	Fri Nov  8 07:41:43 2019 - [info]  mysql-bin.000010:1675
	Fri Nov  8 07:41:43 2019 - [info]  All other slaves should start replication from here. Statement should be: CHANGE MASTER TO MASTER_HOST='192.168.0.103', MASTER_PORT=3306, MASTER_AUTO_POSITION=1, MASTER_USER='mharpl', MASTER_PASSWORD='xxx';
	Fri Nov  8 07:41:43 2019 - [info] Master Recovery succeeded. File:Pos:Exec_Gtid_Set: mysql-bin.000010, 1675, 1b9bc372-0042-11ea-b8fa-0800274617cc:1-19,
	cbe6921b-0043-11ea-b484-0800270d5e94:1-6
	
	******************** 开启虚拟IP，新Master可以对外提供服务 ********************
	
	Fri Nov  8 07:41:43 2019 - [info] Executing master IP activate script:
	Fri Nov  8 07:41:43 2019 - [info]   /etc/masterha/master_ip_failover --command=start --ssh_user=root --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --new_master_host=192.168.0.103 --new_master_ip=192.168.0.103 --new_master_port=3306 --new_master_user='root'   --new_master_password=xxx
	Set read_only=0 on the new master.
	Fri Nov  8 07:41:43 2019 - [info]  OK.
	Fri Nov  8 07:41:43 2019 - [info] ** Finished master recovery successfully.
	Fri Nov  8 07:41:43 2019 - [info] * Phase 3: Master Recovery Phase completed.
	Fri Nov  8 07:41:43 2019 - [info] 
	
	==================== 4、Slave恢复阶段，Start ====================
	Fri Nov  8 07:41:43 2019 - [info] * Phase 4: Slaves Recovery Phase..
	Fri Nov  8 07:41:43 2019 - [info] 
	Fri Nov  8 07:41:43 2019 - [info] 
	Fri Nov  8 07:41:43 2019 - [info] * Phase 4.1: Starting Slaves in parallel..
	Fri Nov  8 07:41:43 2019 - [info] 
	Fri Nov  8 07:41:43 2019 - [info] -- Slave recovery on host 192.168.0.102(192.168.0.102:3306) started, pid: 16091. Check tmp log /var/log/masterha/app1/192.168.0.102_3306_20191108074132.log if it takes time..
	Fri Nov  8 07:41:44 2019 - [info] 
	Fri Nov  8 07:41:44 2019 - [info] Log messages from 192.168.0.102 ...
	Fri Nov  8 07:41:44 2019 - [info] 
	Fri Nov  8 07:41:43 2019 - [info]  Resetting slave 192.168.0.102(192.168.0.102:3306) and starting replication from the new master 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 07:41:43 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 07:41:43 2019 - [debug]   done.
	Fri Nov  8 07:41:43 2019 - [info]  Executed CHANGE MASTER.
	Fri Nov  8 07:41:43 2019 - [debug]  Starting slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 07:41:43 2019 - [debug]   done.
	Fri Nov  8 07:41:43 2019 - [info]  Slave started.
	Fri Nov  8 07:41:44 2019 - [info]  gtid_wait(1b9bc372-0042-11ea-b8fa-0800274617cc:1-19,
	cbe6921b-0043-11ea-b484-0800270d5e94:1-6) completed on 192.168.0.102(192.168.0.102:3306). Executed 5 events.
	Fri Nov  8 07:41:44 2019 - [info] End of log messages from 192.168.0.102.
	Fri Nov  8 07:41:44 2019 - [info] -- Slave on host 192.168.0.102(192.168.0.102:3306) started.
	Fri Nov  8 07:41:44 2019 - [info] All new slave servers recovered successfully.
	Fri Nov  8 07:41:44 2019 - [info] 
	
	==================== 4、Slave恢复阶段，End ====================
	
	==================== 5、新Master清理阶段，Start ====================
	Fri Nov  8 07:41:44 2019 - [info] * Phase 5: New master cleanup phase..
	Fri Nov  8 07:41:44 2019 - [info] 
	Fri Nov  8 07:41:44 2019 - [info] Resetting slave info on the new master..
	Fri Nov  8 07:41:44 2019 - [debug]  Clearing slave info..
	Fri Nov  8 07:41:44 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 07:41:44 2019 - [debug]   done.
	Fri Nov  8 07:41:44 2019 - [debug]  SHOW SLAVE STATUS shows new master does not replicate from anywhere. OK.
	Fri Nov  8 07:41:44 2019 - [info]  192.168.0.103: Resetting slave info succeeded.
	
	==================== 5、新Master清理阶段，End ====================
	
	
	Fri Nov  8 07:41:44 2019 - [info] Master failover to 192.168.0.103(192.168.0.103:3306) completed successfully.
	Fri Nov  8 07:41:44 2019 - [debug]  Disconnected from 192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 07:41:44 2019 - [debug]  Disconnected from 192.168.0.103(192.168.0.103:3306)
	Fri Nov  8 07:41:44 2019 - [info] 

	----- Failover Report -----

	app1: MySQL Master failover 192.168.0.101(192.168.0.101:3306) to 192.168.0.103(192.168.0.103:3306) succeeded

	Master 192.168.0.101(192.168.0.101:3306) is down!

	Check MHA Manager logs at mha02 for details.

	Started manual(interactive) failover.
	Invalidated master IP address on 192.168.0.101(192.168.0.101:3306)
	Selected 192.168.0.103(192.168.0.103:3306) as a new master.
	192.168.0.103(192.168.0.103:3306): OK: Applying all logs succeeded.
	192.168.0.103(192.168.0.103:3306): OK: Activated master IP address.
	192.168.0.102(192.168.0.102:3306): OK: Slave started, replicating from 192.168.0.103(192.168.0.103:3306)
	192.168.0.103(192.168.0.103:3306): Resetting slave info succeeded.
	Master failover to 192.168.0.103(192.168.0.103:3306) completed successfully.
	
	
6. 查看数据是否有补全
	mha02:
	
		mysql> select * from test.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		+------+
		3 rows in set (0.00 sec)
	
	mha03:
		mysql> select * from test.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		+------+
		3 rows in set (0.00 sec)

	可以看到, 数据已经补全完成.
	
	
7. 宕机的master恢复
		
	CHANGE MASTER TO MASTER_HOST='192.168.0.103', MASTER_PORT=3306, MASTER_AUTO_POSITION=1, MASTER_USER='mharpl', MASTER_PASSWORD='123456abc';
 
 
 
 
