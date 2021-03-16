
1. 环境 
2. 配置 [binlog*]
3. 检查整个复制环境状况
4. 数据准备
5. 切换测试	
6. 查看数据是否有补全
7. 产生的补全文件


1. 环境 

	hostname    主机          端口号  通信端口号(server-id)    server_uuid                              MySQL版本      role      mha-node
	mha01		192.168.0.101  3306   3306101				   1b9bc372-0042-11ea-b8fa-0800274617cc     MySQL 8.0.18   Master 
	mha02       192.168.0.102  3306   3306102                  e588e3eb-0042-11ea-a95b-0800275dde84     MySQL 8.0.18   Slave      new Master
	mha03       192.168.0.103  3306   3306103                  cbe6921b-0043-11ea-b484-0800270d5e94     MySQL 8.0.18   Slave      Mha manager & slave 
	VIP         192.168.0.104



2. 配置 [binlog*]

	MHA在GTID模式下，需要配置[binlog*]，可以是单独的Binlog Server服务器，也可以是主库的binlog目录。
	如果不配置[binlog*]，即使主服务器没挂，也不会从主服务器拉binlog，所有未传递到从库的日志将丢失
	注意事项:
		如果配置[binlog*] ,需要配置在 Mha manage节点上.
	缺点:
		如果配置[binlog*], 每次发生切换后都需要手工修改这个 /etc/masterha/app1.conf 配置文件


	mha01:
		shell> cat /etc/masterha/app1.conf
		[binlog1]
		hostname=192.168.0.101
		master_binlog_dir=/data/mysql/mysql3306/data
		no_master=1

	
	

3. 检查整个复制环境状况
	在 mha03 上用root用户操作。

	masterha_check_repl --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf
	
			
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
	把 mha02提升为库, 由于 mha03是最新的 slave, 新Master需要补全跟最新slave的差异 	
	此时主库有未发送到从库的binlog

5. 切换测试	
	
关闭mha01节点数据库服务
	shell> /etc/init.d/mysql stop
	
	
		
mha01节点手动故障切换, 在 mha03上执行:
	 
	masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --dead_master_host=192.168.0.101 --master_state=dead --new_master_host=192.168.0.102 --ignore_last_failover

	--dead_master_ip=<dead_master_ip> is not set. Using 192.168.0.101.
	--dead_master_port=<dead_master_port> is not set. Using 3306.
	Fri Nov  8 10:52:22 2019 - [info] Reading default configuration from /etc/masterha/masterha_default.conf..
	Fri Nov  8 10:52:22 2019 - [info] Reading application default configuration from /etc/masterha/app1.conf..
	Fri Nov  8 10:52:22 2019 - [info] Reading server configuration from /etc/masterha/app1.conf..
	Fri Nov  8 10:52:22 2019 - [info] MHA::MasterFailover version 0.58.
	Fri Nov  8 10:52:22 2019 - [info] Starting master failover.
	Fri Nov  8 10:52:22 2019 - [info] 
	Fri Nov  8 10:52:22 2019 - [info] * Phase 1: Configuration Check Phase..
	Fri Nov  8 10:52:22 2019 - [info] 
	Fri Nov  8 10:52:22 2019 - [debug] SSH connection test to 192.168.0.101, option -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o BatchMode=yes -o ConnectTimeout=5, timeout 5
	Fri Nov  8 10:52:22 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
	Fri Nov  8 10:52:22 2019 - [info] Binlog server 192.168.0.101 is reachable.
	Fri Nov  8 10:52:22 2019 - [debug] Connecting to servers..
	Fri Nov  8 10:52:22 2019 - [debug] Got MySQL error when connecting 192.168.0.101(192.168.0.101:3306) :2003:Can t connect to MySQL server on '192.168.0.101' (111)
	Fri Nov  8 10:52:23 2019 - [debug]  Connected to: 192.168.0.102(192.168.0.102:3306), user=root
	Fri Nov  8 10:52:23 2019 - [debug]  Number of slave worker threads on host 192.168.0.102(192.168.0.102:3306): 0
	Fri Nov  8 10:52:23 2019 - [debug]  Connected to: 192.168.0.103(192.168.0.103:3306), user=root
	Fri Nov  8 10:52:23 2019 - [debug]  Number of slave worker threads on host 192.168.0.103(192.168.0.103:3306): 0
	Fri Nov  8 10:52:23 2019 - [debug]  Comparing MySQL versions..
	Fri Nov  8 10:52:23 2019 - [debug]   Comparing MySQL versions done.
	Fri Nov  8 10:52:23 2019 - [debug] Connecting to servers done.
	Fri Nov  8 10:52:23 2019 - [info] GTID failover mode = 1
	Fri Nov  8 10:52:23 2019 - [info] Dead Servers:
	Fri Nov  8 10:52:23 2019 - [info]   192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:52:23 2019 - [info] Checking master reachability via MySQL(double check)...
	Fri Nov  8 10:52:23 2019 - [info]  ok.
	Fri Nov  8 10:52:23 2019 - [info] Alive Servers:
	Fri Nov  8 10:52:23 2019 - [info]   192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 10:52:23 2019 - [info]   192.168.0.103(192.168.0.103:3306)
	Fri Nov  8 10:52:23 2019 - [info] Alive Slaves:
	Fri Nov  8 10:52:23 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 10:52:23 2019 - [info]     GTID ON
	Fri Nov  8 10:52:23 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 10:52:23 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:52:23 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 10:52:23 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 10:52:23 2019 - [info]     GTID ON
	Fri Nov  8 10:52:23 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 10:52:23 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:52:23 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Master 192.168.0.101(192.168.0.101:3306) is dead. Proceed? (yes/NO): yes
	Fri Nov  8 10:52:25 2019 - [info] Starting GTID based failover.
	Fri Nov  8 10:52:25 2019 - [info] 
	Fri Nov  8 10:52:25 2019 - [info] ** Phase 1: Configuration Check Phase completed.
	Fri Nov  8 10:52:25 2019 - [info] 
	Fri Nov  8 10:52:25 2019 - [info] * Phase 2: Dead Master Shutdown Phase..
	Fri Nov  8 10:52:25 2019 - [info] 
	Fri Nov  8 10:52:25 2019 - [debug] SSH connection test to 192.168.0.101, option -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o BatchMode=yes -o ConnectTimeout=5, timeout 5
	Fri Nov  8 10:52:25 2019 - [debug]  Stopping IO thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 10:52:25 2019 - [debug]  Stopping IO thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:52:25 2019 - [debug]  Stop IO thread on 192.168.0.103(192.168.0.103:3306) done.
	Fri Nov  8 10:52:25 2019 - [debug]  Stop IO thread on 192.168.0.102(192.168.0.102:3306) done.
	Fri Nov  8 10:52:25 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
	Fri Nov  8 10:52:25 2019 - [info] Forcing shutdown so that applications never connect to the current master..
	Fri Nov  8 10:52:25 2019 - [info] Executing master IP deactivation script:
	Fri Nov  8 10:52:25 2019 - [info]   /etc/masterha/master_ip_failover --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --command=stopssh --ssh_user=root  
	Fri Nov  8 10:52:25 2019 - [info]  done.
	Fri Nov  8 10:52:25 2019 - [warning] shutdown_script is not set. Skipping explicit shutting down of the dead master.
	Fri Nov  8 10:52:25 2019 - [info] * Phase 2: Dead Master Shutdown Phase completed.
	Fri Nov  8 10:52:25 2019 - [info] 
	Fri Nov  8 10:52:25 2019 - [info] * Phase 3: Master Recovery Phase..
	Fri Nov  8 10:52:25 2019 - [info] 
	Fri Nov  8 10:52:25 2019 - [info] * Phase 3.1: Getting Latest Slaves Phase..
	Fri Nov  8 10:52:25 2019 - [info] 
	Fri Nov  8 10:52:25 2019 - [debug] Fetching current slave status..
	Fri Nov  8 10:52:25 2019 - [debug]  Fetching current slave status done.
	Fri Nov  8 10:52:25 2019 - [info] The latest binary log file/position on all slaves is mysql-bin.000016:902
	Fri Nov  8 10:52:25 2019 - [info] Retrieved Gtid Set: 1b9bc372-0042-11ea-b8fa-0800274617cc:23-26
	Fri Nov  8 10:52:25 2019 - [info] Latest slaves (Slaves that received relay log files to the latest):
	Fri Nov  8 10:52:25 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 10:52:25 2019 - [info]     GTID ON
	Fri Nov  8 10:52:25 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 10:52:25 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:52:25 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 10:52:25 2019 - [info] The oldest binary log file/position on all slaves is mysql-bin.000016:649
	Fri Nov  8 10:52:25 2019 - [info] Retrieved Gtid Set: 1b9bc372-0042-11ea-b8fa-0800274617cc:23-25
	Fri Nov  8 10:52:25 2019 - [info] Oldest slaves:
	Fri Nov  8 10:52:25 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 10:52:25 2019 - [info]     GTID ON
	Fri Nov  8 10:52:25 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 10:52:25 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:52:25 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 10:52:25 2019 - [info] 
	Fri Nov  8 10:52:25 2019 - [info] * Phase 3.3: Determining New Master Phase..
	Fri Nov  8 10:52:25 2019 - [info] 
	Fri Nov  8 10:52:25 2019 - [info] 192.168.0.102 can be new master.
	Fri Nov  8 10:52:25 2019 - [info] New master is 192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 10:52:25 2019 - [info] Starting master failover..
	Fri Nov  8 10:52:25 2019 - [info] 
	From:
	192.168.0.101(192.168.0.101:3306) (current master)
	 +--192.168.0.102(192.168.0.102:3306)
	 +--192.168.0.103(192.168.0.103:3306)

	To:
	192.168.0.102(192.168.0.102:3306) (new master)
	 +--192.168.0.103(192.168.0.103:3306)

	Starting master switch from 192.168.0.101(192.168.0.101:3306) to 192.168.0.102(192.168.0.102:3306)? (yes/NO): yes
	Fri Nov  8 10:52:27 2019 - [info] New master decided manually is 192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 10:52:27 2019 - [info] 
	
	==================== 3.3、新的Master恢复 ====================
	Fri Nov  8 10:52:27 2019 - [info] * Phase 3.3: New Master Recovery Phase..
	Fri Nov  8 10:52:27 2019 - [info]
	
	******************** 等待新Master应用完自己的relay-log ********************	
	Fri Nov  8 10:52:27 2019 - [info]  Waiting all logs to be applied.. 
	Fri Nov  8 10:52:27 2019 - [info]   done.
	Fri Nov  8 10:52:27 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:52:27 2019 - [debug]   done.
	Fri Nov  8 10:52:27 2019 - [info]  Replicating from the latest slave 192.168.0.103(192.168.0.103:3306) and waiting to apply..
	
	******************** 等待最新的Slave应用完自己的relay-log ********************
	
	Fri Nov  8 10:52:27 2019 - [info]  Waiting all logs to be applied on the latest slave.. 
	Fri Nov  8 10:52:27 2019 - [info]  Resetting slave 192.168.0.102(192.168.0.102:3306) and starting replication from the new master 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 10:52:27 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:52:27 2019 - [debug]   done.
	Fri Nov  8 10:52:27 2019 - [info]  Executed CHANGE MASTER.
	Fri Nov  8 10:52:27 2019 - [debug]  Starting slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:52:27 2019 - [debug]   done.
	Fri Nov  8 10:52:27 2019 - [info]  Slave started.
	Fri Nov  8 10:52:27 2019 - [info]  Waiting to execute all relay logs on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:52:27 2019 - [info]  master_pos_wait(mysql-bin.000011:1850) completed on 192.168.0.102(192.168.0.102:3306). Executed 2 events.
	Fri Nov  8 10:52:27 2019 - [info]   done.
	Fri Nov  8 10:52:27 2019 - [debug]  Stopping SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:52:27 2019 - [debug]   done.
	Fri Nov  8 10:52:27 2019 - [info]   done.
	Fri Nov  8 10:52:27 2019 - [info] -- Saving binlog from host 192.168.0.101 started, pid: 22257
	Fri Nov  8 10:52:28 2019 - [info] 
	Fri Nov  8 10:52:28 2019 - [info] Log messages from 192.168.0.101 ...
	Fri Nov  8 10:52:28 2019 - [info] 
	Fri Nov  8 10:52:27 2019 - [info] Fetching binary logs from binlog server 192.168.0.101..
	Fri Nov  8 10:52:27 2019 - [info] Executing binlog save command: save_binary_logs --command=save --start_file=mysql-bin.000016  --start_pos=902 --output_file=/var/log/masterha/app1/saved_binlog_binlog1_20191108105222.binlog --handle_raw_binlog=0 --skip_filter=1 --disable_log_bin=0 --manager_version=0.58 --oldest_version=8.0.18  --debug  --binlog_dir=/data/mysql/mysql3306/data 
	  Creating /var/log/masterha/app1 if not exists..    ok.
	 Concat binary/relay logs from mysql-bin.000016 pos 902 to mysql-bin.000016 EOF into /var/log/masterha/app1/saved_binlog_binlog1_20191108105222.binlog ..
	Executing command: mysqlbinlog --start-position=902  /data/mysql/mysql3306/data/mysql-bin.000016 >> /var/log/masterha/app1/saved_binlog_binlog1_20191108105222.binlog
	 Concat succeeded.
	Fri Nov  8 10:52:27 2019 - [info] scp from root@192.168.0.101:/var/log/masterha/app1/saved_binlog_binlog1_20191108105222.binlog to local:/var/log/masterha/app1/saved_binlog_192.168.0.101_binlog1_20191108105222.binlog succeeded.
	Fri Nov  8 10:52:28 2019 - [info] End of log messages from 192.168.0.101.
	Fri Nov  8 10:52:28 2019 - [info] Saved mysqlbinlog size from 192.168.0.101 is 2645 bytes.
	Fri Nov  8 10:52:28 2019 - [info] Checking if super_read_only is defined and turned on..
	Fri Nov  8 10:52:28 2019 - [info]  not present or turned off, ignoring.
	Fri Nov  8 10:52:28 2019 - [info] Applying differential binlog /var/log/masterha/app1/saved_binlog_192.168.0.101_binlog1_20191108105222.binlog ..
	Fri Nov  8 10:52:28 2019 - [info] Differential log apply from binlog server succeeded.
	Fri Nov  8 10:52:28 2019 - [info] Getting new master's binlog name and position..
	Fri Nov  8 10:52:28 2019 - [info]  mysql-bin.000011:1428
	Fri Nov  8 10:52:28 2019 - [info]  All other slaves should start replication from here. Statement should be: CHANGE MASTER TO MASTER_HOST='192.168.0.102', MASTER_PORT=3306, MASTER_AUTO_POSITION=1, MASTER_USER='mharpl', MASTER_PASSWORD='xxx';
	Fri Nov  8 10:52:28 2019 - [info] Master Recovery succeeded. File:Pos:Exec_Gtid_Set: mysql-bin.000011, 1428, 1b9bc372-0042-11ea-b8fa-0800274617cc:1-27,
	cbe6921b-0043-11ea-b484-0800270d5e94:1-6
	Fri Nov  8 10:52:28 2019 - [info] Executing master IP activate script:
	Fri Nov  8 10:52:28 2019 - [info]   /etc/masterha/master_ip_failover --command=start --ssh_user=root --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --new_master_host=192.168.0.102 --new_master_ip=192.168.0.102 --new_master_port=3306 --new_master_user='root'   --new_master_password=xxx
	Set read_only=0 on the new master.
	Fri Nov  8 10:52:28 2019 - [info]  OK.
	Fri Nov  8 10:52:28 2019 - [info] ** Finished master recovery successfully.
	Fri Nov  8 10:52:28 2019 - [info] * Phase 3: Master Recovery Phase completed.
	Fri Nov  8 10:52:28 2019 - [info] 
	Fri Nov  8 10:52:28 2019 - [info] * Phase 4: Slaves Recovery Phase..
	Fri Nov  8 10:52:28 2019 - [info] 
	Fri Nov  8 10:52:28 2019 - [info] 
	Fri Nov  8 10:52:28 2019 - [info] * Phase 4.1: Starting Slaves in parallel..
	Fri Nov  8 10:52:28 2019 - [info] 
	Fri Nov  8 10:52:28 2019 - [info] -- Slave recovery on host 192.168.0.103(192.168.0.103:3306) started, pid: 22274. Check tmp log /var/log/masterha/app1/192.168.0.103_3306_20191108105222.log if it takes time..
	Fri Nov  8 10:52:30 2019 - [info] 
	Fri Nov  8 10:52:30 2019 - [info] Log messages from 192.168.0.103 ...
	Fri Nov  8 10:52:30 2019 - [info] 
	Fri Nov  8 10:52:28 2019 - [info]  Resetting slave 192.168.0.103(192.168.0.103:3306) and starting replication from the new master 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:52:28 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 10:52:28 2019 - [debug]   done.
	Fri Nov  8 10:52:28 2019 - [info]  Executed CHANGE MASTER.
	Fri Nov  8 10:52:28 2019 - [debug]  Starting slave IO/SQL thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 10:52:29 2019 - [debug]   done.
	Fri Nov  8 10:52:29 2019 - [info]  Slave started.
	Fri Nov  8 10:52:29 2019 - [info]  gtid_wait(1b9bc372-0042-11ea-b8fa-0800274617cc:1-27,
	cbe6921b-0043-11ea-b484-0800270d5e94:1-6) completed on 192.168.0.103(192.168.0.103:3306). Executed 0 events.
	Fri Nov  8 10:52:30 2019 - [info] End of log messages from 192.168.0.103.
	Fri Nov  8 10:52:30 2019 - [info] -- Slave on host 192.168.0.103(192.168.0.103:3306) started.
	Fri Nov  8 10:52:30 2019 - [info] All new slave servers recovered successfully.
	Fri Nov  8 10:52:30 2019 - [info] 
	Fri Nov  8 10:52:30 2019 - [info] * Phase 5: New master cleanup phase..
	Fri Nov  8 10:52:30 2019 - [info] 
	Fri Nov  8 10:52:30 2019 - [info] Resetting slave info on the new master..
	Fri Nov  8 10:52:30 2019 - [debug]  Clearing slave info..
	Fri Nov  8 10:52:30 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:52:30 2019 - [debug]   done.
	Fri Nov  8 10:52:30 2019 - [debug]  SHOW SLAVE STATUS shows new master does not replicate from anywhere. OK.
	Fri Nov  8 10:52:30 2019 - [info]  192.168.0.102: Resetting slave info succeeded.
	Fri Nov  8 10:52:30 2019 - [info] Master failover to 192.168.0.102(192.168.0.102:3306) completed successfully.
	Fri Nov  8 10:52:30 2019 - [debug]  Disconnected from 192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 10:52:30 2019 - [debug]  Disconnected from 192.168.0.103(192.168.0.103:3306)
	Fri Nov  8 10:52:30 2019 - [info] 

	----- Failover Report -----

	app1: MySQL Master failover 192.168.0.101(192.168.0.101:3306) to 192.168.0.102(192.168.0.102:3306) succeeded

	Master 192.168.0.101(192.168.0.101:3306) is down!

	Check MHA Manager logs at mha03 for details.

	Started manual(interactive) failover.
	Invalidated master IP address on 192.168.0.101(192.168.0.101:3306)
	Selected 192.168.0.102(192.168.0.102:3306) as a new master.
	192.168.0.102(192.168.0.102:3306): OK: Applying all logs succeeded.
	192.168.0.102(192.168.0.102:3306): OK: Activated master IP address.
	192.168.0.103(192.168.0.103:3306): OK: Slave started, replicating from 192.168.0.102(192.168.0.102:3306)
	192.168.0.102(192.168.0.102:3306): Resetting slave info succeeded.
	Master failover to 192.168.0.102(192.168.0.102:3306) completed successfully.



6. 查看数据是否有补全
	mha02:
		root@mysqldb 10:49:  [(none)]>  select * from test.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		+------+
		3 rows in set (0.00 sec)
	
	mha03:
		root@mysqldb 10:49:  [(none)]> select * from test.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		+------+
		3 rows in set (0.00 sec)

	可以看到, 数据已经补全完成.
		
7. 产生的补全文件
	
	[root@mha03 app1]# ll
	total 84
	-rw-r--r--. 1 root root     0 Nov  8 10:52 app1.failover.complete
	-rw-r--r--. 1 root root 77140 Nov  7 15:19 app1.log
	-rw-r--r--. 1 root root  3230 Nov  8 10:52 mysql_from_binlog.err
	-rw-r--r--. 1 root root  2645 Nov  8 10:52 saved_binlog_192.168.0.101_binlog1_20191108105222.binlog

			
	[root@mha01 app1]# pwd
	/var/log/masterha/app1
	[root@mha01 app1]# ll
	total 8
	-rw-r--r-- 1 root root 1214 Nov  6 17:50 app1.log
	-rw-r--r-- 1 root root 2645 Nov  8 10:52 saved_binlog_binlog1_20191108105222.binlog
