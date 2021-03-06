

mha01: 写入第1条记录
	use test;
	truncate table t1;
	insert into t1 values (1);
	
mha02: 停止io_thread
	stop slave io_thread;
	
mha01: 写入第2条记录
	insert into t1 values (2);

mha03: 停止io_thread
	stop slave io_thread;
	
mha01: 写入第3条记录
	insert into t1 values (3);
	
# 最终各节点记录如下
mha01:
	root@mysqldb 12:42:  [test]> select * from test.t1;
	+------+
	| a    |
	+------+
	|    1 |
	|    2 |
	|    3 |
	+------+
	3 rows in set (0.00 sec)
	
mha02:
	root@mysqldb 12:41:  [(none)]> select * from test.t1;
	+------+
	| a    |
	+------+
	|    1 |
	+------+
	1 row in set (0.00 sec)

mha03:
	root@mysqldb 12:42:  [(none)]> select * from test.t1;
	+------+
	| a    |
	+------+
	|    1 |
	|    2 |
	+------+
	2 rows in set (0.00 sec)

很明显从节点mha02落后于从节点mha03、从节点mha03落后于主节点mha01



手动Failover场景，Master挂掉，但是mha_manager没有开启，可以通过手动Failover

[root@mha03 masterha]#  masterha_check_status --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf
app1 is stopped(2:NOT_RUNNING).

关闭Node1节点数据库服务
	mysql> shutdown; 
	
# mha02 mha03 节点复制状态
mha02
	root@mysqldb 12:42:  [(none)]> pager cat | egrep 'Master_Log_File|Relay_Master_Log_File|Read_Master_Log_Pos|Exec_Master_Log_Pos|Running'
	PAGER set to 'cat | egrep 'Master_Log_File|Relay_Master_Log_File|Read_Master_Log_Pos|Exec_Master_Log_Pos|Running''

	root@mysqldb 12:48:  [(none)]> show slave status\G;
				  Master_Log_File: mysql-bin.000008
			  Read_Master_Log_Pos: 609
			Relay_Master_Log_File: mysql-bin.000008
				 Slave_IO_Running: No
				Slave_SQL_Running: Yes
			  Exec_Master_Log_Pos: 609
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
	1 row in set (0.00 sec)


mha03
	root@mysqldb 12:43:  [(none)]> pager cat | egrep 'Master_Log_File|Relay_Master_Log_File|Read_Master_Log_Pos|Exec_Master_Log_Pos|Running'
	PAGER set to 'cat | egrep 'Master_Log_File|Relay_Master_Log_File|Read_Master_Log_Pos|Exec_Master_Log_Pos|Running''
	root@mysqldb 12:49:  [(none)]> show slave status\G;
				  Master_Log_File: mysql-bin.000008
			  Read_Master_Log_Pos: 862
			Relay_Master_Log_File: mysql-bin.000008
				 Slave_IO_Running: No
				Slave_SQL_Running: Yes
			  Exec_Master_Log_Pos: 862
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
	1 row in set (0.00 sec)


Node1节点手动故障切换, 在 mha03上执行:
	
	shell> masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --dead_master_host=192.168.0.101 --master_state=dead --new_master_host=192.168.0.102 --ignore_last_failover
	Stopped app1 successfully.
	[3]   Exit 1                  masterha_manager --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf > /tmp/mha_manager.log 2>&1
	[root@mha03 masterha]#  masterha_check_status --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf
	app1 is stopped(2:NOT_RUNNING).
	[root@mha03 masterha]# masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --dead_master_host=192.168.0.101 --master_state=dead --new_master_host=192.168.0.102 --ignore_last_failover
	--dead_master_ip=<dead_master_ip> is not set. Using 192.168.0.101.
	--dead_master_port=<dead_master_port> is not set. Using 3306.
	Thu Nov  7 12:50:44 2019 - [info] Reading default configuration from /etc/masterha/masterha_default.conf..
	Thu Nov  7 12:50:44 2019 - [info] Reading application default configuration from /etc/masterha/app1.conf..
	Thu Nov  7 12:50:44 2019 - [info] Reading server configuration from /etc/masterha/app1.conf..
	Thu Nov  7 12:50:44 2019 - [info] MHA::MasterFailover version 0.58.
	Thu Nov  7 12:50:44 2019 - [info] Starting master failover.
	Thu Nov  7 12:50:44 2019 - [info] 
	
	==================== 1、配置检查阶段，Start ====================
	Thu Nov  7 12:50:44 2019 - [info] * Phase 1: Configuration Check Phase..
	Thu Nov  7 12:50:44 2019 - [info] 
	Thu Nov  7 12:50:46 2019 - [info] GTID failover mode = 0
	Thu Nov  7 12:50:46 2019 - [info] Dead Servers:
	Thu Nov  7 12:50:46 2019 - [info]   192.168.0.101(192.168.0.101:3306)
	Thu Nov  7 12:50:46 2019 - [info] Checking master reachability via MySQL(double check)...
	Thu Nov  7 12:50:46 2019 - [info]  ok.
	Thu Nov  7 12:50:46 2019 - [info] Alive Servers:
	Thu Nov  7 12:50:46 2019 - [info]   192.168.0.102(192.168.0.102:3306)
	Thu Nov  7 12:50:46 2019 - [info]   192.168.0.103(192.168.0.103:3306)
	Thu Nov  7 12:50:46 2019 - [info] Alive Slaves:
	Thu Nov  7 12:50:46 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Thu Nov  7 12:50:46 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Thu Nov  7 12:50:46 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Thu Nov  7 12:50:46 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Thu Nov  7 12:50:46 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Thu Nov  7 12:50:46 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	
	******************** 输出的信息会询问你是否进行切换：选择是否继续进行 ********************
	
	Master 192.168.0.101(192.168.0.101:3306) is dead. Proceed? (yes/NO): yes
	Thu Nov  7 12:50:50 2019 - [info] Starting Non-GTID based failover.
	Thu Nov  7 12:50:50 2019 - [info] 
	Thu Nov  7 12:50:50 2019 - [info] ** Phase 1: Configuration Check Phase completed.
	Thu Nov  7 12:50:50 2019 - [info] 
	==================== 1、配置检查阶段，End ====================
	
	==================== 2、故障Master关闭阶段，Start ====================
	Thu Nov  7 12:50:50 2019 - [info] * Phase 2: Dead Master Shutdown Phase..
	Thu Nov  7 12:50:50 2019 - [info] 
	Thu Nov  7 12:50:51 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
	Thu Nov  7 12:50:51 2019 - [info] Forcing shutdown so that applications never connect to the current master..
	Thu Nov  7 12:50:51 2019 - [info] Executing master IP deactivation script:
	Thu Nov  7 12:50:51 2019 - [info]   /etc/masterha/master_ip_failover --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --command=stopssh --ssh_user=root  
	Thu Nov  7 12:50:51 2019 - [info]  done.
	Thu Nov  7 12:50:51 2019 - [warning] shutdown_script is not set. Skipping explicit shutting down of the dead master.
	Thu Nov  7 12:50:51 2019 - [info] * Phase 2: Dead Master Shutdown Phase completed.
	Thu Nov  7 12:50:51 2019 - [info] 
	==================== 2、故障Master关闭阶段，End ====================
	
	==================== 3、新Master恢复阶段，Start ====================
	Thu Nov  7 12:50:51 2019 - [info] * Phase 3: Master Recovery Phase..
	Thu Nov  7 12:50:51 2019 - [info] 
	==================== 3.1、获取最新的Slave ====================
	******************** 最新Slave，用途1：用于补全其他Slave缺少的relay-log；用途2：用于save故障Master的binlog的起始点 ********************
	Thu Nov  7 12:50:51 2019 - [info] * Phase 3.1: Getting Latest Slaves Phase..
	Thu Nov  7 12:50:51 2019 - [info] 
	Thu Nov  7 12:50:51 2019 - [info] The latest binary log file/position on all slaves is mysql-bin.000008:862
	Thu Nov  7 12:50:51 2019 - [info] Latest slaves (Slaves that received relay log files to the latest):
	Thu Nov  7 12:50:51 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Thu Nov  7 12:50:51 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Thu Nov  7 12:50:51 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Thu Nov  7 12:50:51 2019 - [info] The oldest binary log file/position on all slaves is mysql-bin.000008:609
	Thu Nov  7 12:50:51 2019 - [info] Oldest slaves:
	Thu Nov  7 12:50:51 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Thu Nov  7 12:50:51 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Thu Nov  7 12:50:51 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Thu Nov  7 12:50:51 2019 - [info] 
	==================== 3.2、保存故障Master的binlog ====================
	Thu Nov  7 12:50:51 2019 - [info] * Phase 3.2: Saving Dead Master's Binlog Phase..
	Thu Nov  7 12:50:51 2019 - [info] 
	Thu Nov  7 12:50:51 2019 - [info] Fetching dead master's binary logs..
	Thu Nov  7 12:50:51 2019 - [info] Executing command on the dead master 192.168.0.101(192.168.0.101:3306): save_binary_logs --command=save --start_file=mysql-bin.000008  --start_pos=862 --binlog_dir=/data/mysql/mysql3306/data --output_file=/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog --handle_raw_binlog=1 --disable_log_bin=0 --manager_version=0.58
	  Creating /var/log/masterha/app1 if not exists..    ok.
	 Concat binary/relay logs from mysql-bin.000008 pos 862 to mysql-bin.000008 EOF into /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog ..
	  Dumping binlog format description event, from position 0 to 191.. ok.
	  Dumping effective binlog data from /data/mysql/mysql3306/data/mysql-bin.000008 position 862 to tail(1134).. ok.
	 Concat succeeded.
	saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog                                                                                                                                                                           100%  463   602.0KB/s   00:00    
	Thu Nov  7 12:50:52 2019 - [info] scp from root@192.168.0.101:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog to local:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog succeeded.
	Thu Nov  7 12:50:52 2019 - [info] HealthCheck: SSH to 192.168.0.102 is reachable.
	Thu Nov  7 12:50:53 2019 - [info] HealthCheck: SSH to 192.168.0.103 is reachable.
	Thu Nov  7 12:50:53 2019 - [info] 
	
	==================== 3.3、从Slave中选举新的Master阶段 ====================
	Thu Nov  7 12:50:53 2019 - [info] * Phase 3.3: Determining New Master Phase..
	Thu Nov  7 12:50:53 2019 - [info] 
	******************** 查找最新的Slave是否包含其他Slave缺失的 Relay-log  ********************
	Thu Nov  7 12:50:53 2019 - [info] Finding the latest slave that has all relay logs for recovering other slaves..
	Thu Nov  7 12:50:53 2019 - [info] Checking whether 192.168.0.103 has relay logs from the oldest position..
	Thu Nov  7 12:50:53 2019 - [info] Executing command: apply_diff_relay_logs --command=find --latest_mlf=mysql-bin.000008 --latest_rmlp=862 --target_mlf=mysql-bin.000008 --target_rmlp=609 --server_id=3306 --workdir=/var/log/masterha/app1 --timestamp=20191107125044 --manager_version=0.58 --relay_dir=/data/mysql/mysql3306/data --current_relay_log=mha03-relay-bin.000024  :
		Relay log found at /data/mysql/mysql3306/data, up to mha03-relay-bin.000024
	 Fast relay log position search succeeded.
	 Target relay log file/position found. start_file:mha03-relay-bin.000024, start_pos:775.
	Target relay log FOUND!
	Thu Nov  7 12:50:53 2019 - [info] OK. 192.168.0.103 has all relay logs.
	Thu Nov  7 12:50:53 2019 - [info] 192.168.0.102 can be new master.
	Thu Nov  7 12:50:53 2019 - [info] New master is 192.168.0.102(192.168.0.102:3306)
	Thu Nov  7 12:50:53 2019 - [info] Starting master failover..
	Thu Nov  7 12:50:53 2019 - [info] 
	From:
	192.168.0.101(192.168.0.101:3306) (current master)
	 +--192.168.0.102(192.168.0.102:3306)
	 +--192.168.0.103(192.168.0.103:3306)

	To:
	192.168.0.102(192.168.0.102:3306) (new master)
	 +--192.168.0.103(192.168.0.103:3306)
	
	 
	******************** 输出的信息会询问你是否进行切换：选择是否进行切换 ********************

	Starting master switch from 192.168.0.101(192.168.0.101:3306) to 192.168.0.102(192.168.0.102:3306)? (yes/NO): yes
	Thu Nov  7 12:50:56 2019 - [info] New master decided manually is 192.168.0.102(192.168.0.102:3306)
	Thu Nov  7 12:50:56 2019 - [info] 
	
	
	
	
	Thu Nov  7 12:50:56 2019 - [info] * Phase 3.4: New Master Diff Log Generation Phase..
	Thu Nov  7 12:50:56 2019 - [info]
	
	******************** 在最新的Slave，产生新Master与最新的Slave缺失的Relay-log ********************
		
	新主库需要判断自己的relay log是否与 latest(最新) slave 有差异，产生差异relay log；之后 Monitor server 会通过scp将主库差异binlog拷贝到新主库上。
	
	Thu Nov  7 12:50:56 2019 - [info] Server 192.168.0.102 received relay logs up to: mysql-bin.000008:609
	Thu Nov  7 12:50:56 2019 - [info] Need to get diffs from the latest slave(192.168.0.103) up to: mysql-bin.000008:862 (using the latest slave s relay logs)
	Thu Nov  7 12:50:56 2019 - [info] Connecting to the latest slave host 192.168.0.103, generating diff relay log files..
														 apply_diff_relay_logs: 识别差异的中继日志事件并将其差异的事件应用于其它slave。
	Thu Nov  7 12:50:56 2019 - [info] Executing command: apply_diff_relay_logs --command=generate_and_send --scp_user=root --scp_host=192.168.0.102 --latest_mlf=mysql-bin.000008 --latest_rmlp=862 --target_mlf=mysql-bin.000008 --target_rmlp=609 --server_id=3306 --diff_file_readtolatest=/var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog --workdir=/var/log/masterha/app1 --timestamp=20191107125044 --handle_raw_binlog=1 --disable_log_bin=0 --manager_version=0.58 --relay_dir=/data/mysql/mysql3306/data --current_relay_log=mha03-relay-bin.000024 
	Thu Nov  7 12:50:58 2019 - [info] 
		Relay log found at /data/mysql/mysql3306/data, up to mha03-relay-bin.000024
	 Fast relay log position search succeeded.
	 Target relay log file/position found. start_file:mha03-relay-bin.000024, start_pos:775.
	 Concat binary/relay logs from mha03-relay-bin.000024 pos 775 to mha03-relay-bin.000024 EOF into /var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog ..
	  Dumping binlog format description event, from position 0 to 357.. ok.
	  Dumping effective binlog data from /data/mysql/mysql3306/data/mha03-relay-bin.000024 position 775 to tail(1028).. ok.
	 Concat succeeded.
	 Generating diff relay log succeeded. Saved at /var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog .
	 
	******************** 将得到的 relay-log scp到新Master工作目录 ********************
	 scp mha03:/var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog to root@192.168.0.102(22) succeeded.
	Thu Nov  7 12:50:58 2019 - [info]  Generating diff files succeeded.
	Thu Nov  7 12:50:58 2019 - [info] Sending binlog..
	saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog    
	100%  463   684.9KB/s   00:00    
	
	******************** 从管理节点mha-manage/手动failover运行的工作目录scp故障Master的binlog到新Master工作目录 ********************
	Thu Nov  7 12:50:58 2019 - [info] scp from local:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog to root@192.168.0.102:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog succeeded.
	Thu Nov  7 12:50:58 2019 - [info] 
	
	==================== 3.5、新Master应用log ====================
	Thu Nov  7 12:50:58 2019 - [info] * Phase 3.5: Master Log Apply Phase..
	Thu Nov  7 12:50:58 2019 - [info] 
	Thu Nov  7 12:50:58 2019 - [info] *NOTICE: If any error happens from this phase, manual recovery is needed.
	Thu Nov  7 12:50:58 2019 - [info] Starting recovery on 192.168.0.102(192.168.0.102:3306)..
	Thu Nov  7 12:50:58 2019 - [info]  Generating diffs succeeded.
	
	******************** 等待新Master应用完自己的relay-log ********************
	Thu Nov  7 12:50:58 2019 - [info] Waiting until all relay logs are applied.
	Thu Nov  7 12:50:58 2019 - [info]  done.
	Thu Nov  7 12:50:58 2019 - [info] Getting slave status..
	Thu Nov  7 12:50:58 2019 - [info] This slave(192.168.0.102) s Exec_Master_Log_Pos equals to Read_Master_Log_Pos(mysql-bin.000008:609). No need to recover from Exec_Master_Log_Pos.
	Thu Nov  7 12:50:58 2019 - [info] Connecting to the target slave host 192.168.0.102, running recover script..
	
	******************** 新Master按顺序应用与最新的Slave缺失的relay-log，以及故障Master保存的binlog ********************
	Thu Nov  7 12:50:58 2019 - [info] Executing command: 
		apply_diff_relay_logs --command=apply --slave_user='root' --slave_host=192.168.0.102 --slave_ip=192.168.0.102  --slave_port=3306 
			--apply_files=/var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog,/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog 
				--workdir=/var/log/masterha/app1 --target_version=8.0.18 --timestamp=20191107125044 --handle_raw_binlog=1 
				--disable_log_bin=0 --manager_version=0.58 --slave_pass=xxx
	Thu Nov  7 12:50:59 2019 - [info] 
	
	******************** 将所有缺失的relay-log、binlog汇总到 total_binlog ********************
	 Concat all apply files to /var/log/masterha/app1/total_binlog_for_192.168.0.102_3306.20191107125044.binlog ..
	 Copying the first binlog file /var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog to /var/log/masterha/app1/total_binlog_for_192.168.0.102_3306.20191107125044.binlog.. ok.
	  Dumping binlog head events (rotate events), skipping format description events from /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog.. dumped up to pos 191. ok.
	 /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog has effective binlog events from pos 191.
	  Dumping effective binlog data from /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog position 191 to tail(463).. ok.
	 Concat succeeded.
	All apply target binary logs are concatinated at /var/log/masterha/app1/total_binlog_for_192.168.0.102_3306.20191107125044.binlog .
	Applying differential binary/relay log files /var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog,/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog on 192.168.0.102:3306. This may take long time...
	Applying log files succeeded.
	Thu Nov  7 12:50:59 2019 - [info]  All relay logs were successfully applied.
	
	******************** 新Master应用完所有的relay-log、binlog，得到当前位置 ********************
	Thu Nov  7 12:50:59 2019 - [info] Getting new master s binlog name and position..
	Thu Nov  7 12:50:59 2019 - [info]  mysql-bin.000006:1138
	Thu Nov  7 12:50:59 2019 - [info]  All other slaves should start replication from here. Statement should be: CHANGE MASTER TO MASTER_HOST='192.168.0.102', MASTER_PORT=3306, MASTER_LOG_FILE='mysql-bin.000006', MASTER_LOG_POS=1138, MASTER_USER='mharpl', MASTER_PASSWORD='xxx';
	
	******************** 开启虚拟IP，新Master可以对外提供服务 ********************
	Thu Nov  7 12:50:59 2019 - [info] Executing master IP activate script:
	Thu Nov  7 12:50:59 2019 - [info]   /etc/masterha/master_ip_failover --command=start --ssh_user=root --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --new_master_host=192.168.0.102 --new_master_ip=192.168.0.102 --new_master_port=3306 --new_master_user='root'   --new_master_password=xxx
	Set read_only=0 on the new master.
	Thu Nov  7 12:50:59 2019 - [info]  OK.
	Thu Nov  7 12:50:59 2019 - [info] ** Finished master recovery successfully.
	
	==================== 3、新Master恢复阶段，End ====================
	Thu Nov  7 12:50:59 2019 - [info] * Phase 3: Master Recovery Phase completed.
	Thu Nov  7 12:50:59 2019 - [info] 
	
	==================== 4、Slave恢复阶段，Start ====================
	******************** Slave恢复过程类似新Master，首先得到与最新的Slave差异relay-log，然后获取故障Master的binlog ********************

	Thu Nov  7 12:50:59 2019 - [info] * Phase 4: Slaves Recovery Phase..
	Thu Nov  7 12:50:59 2019 - [info] 
	==================== 4.1、生成最新Slave和Slave之间的差异log ====================
	Thu Nov  7 12:50:59 2019 - [info] * Phase 4.1: Starting Parallel Slave Diff Log Generation Phase..
	Thu Nov  7 12:50:59 2019 - [info] 
	Thu Nov  7 12:50:59 2019 - [info] -- Slave diff file generation on host 192.168.0.103(192.168.0.103:3306) started, pid: 17590. Check tmp log /var/log/masterha/app1/192.168.0.103_3306_20191107125044.log if it takes time..
	Thu Nov  7 12:51:00 2019 - [info] 
	Thu Nov  7 12:51:00 2019 - [info] Log messages from 192.168.0.103 ...
	Thu Nov  7 12:51:00 2019 - [info] 
	Thu Nov  7 12:50:59 2019 - [info]  This server has all relay logs. No need to generate diff files from the latest slave.
	Thu Nov  7 12:51:00 2019 - [info] End of log messages from 192.168.0.103.
	Thu Nov  7 12:51:00 2019 - [info] -- 192.168.0.103(192.168.0.103:3306) has the latest relay log events.
	Thu Nov  7 12:51:00 2019 - [info] Generating relay diff files from the latest slave succeeded.
	Thu Nov  7 12:51:00 2019 - [info] 
	==================== 4.2、Slave应用差异log ====================
	Thu Nov  7 12:51:00 2019 - [info] * Phase 4.2: Starting Parallel Slave Log Apply Phase..
	Thu Nov  7 12:51:00 2019 - [info] 
	Thu Nov  7 12:51:00 2019 - [info] -- Slave recovery on host 192.168.0.103(192.168.0.103:3306) started, pid: 17593. Check tmp log /var/log/masterha/app1/192.168.0.103_3306_20191107125044.log if it takes time..
	saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog                                                                                                                                                                           100%  463     1.1MB/s   00:00    
	Thu Nov  7 12:51:02 2019 - [info] 
	Thu Nov  7 12:51:02 2019 - [info] Log messages from 192.168.0.103 ...
	Thu Nov  7 12:51:02 2019 - [info] 
	Thu Nov  7 12:51:00 2019 - [info] Sending binlog..
	
	******************** 从管理节点mha-manage/手动failover运行的工作目录scp故障Master的binlog到Slave工作目录 ********************
	Thu Nov  7 12:51:01 2019 - [info] scp from local:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog to root@192.168.0.103:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog succeeded.
	Thu Nov  7 12:51:01 2019 - [info] Starting recovery on 192.168.0.103(192.168.0.103:3306)..
	Thu Nov  7 12:51:01 2019 - [info]  Generating diffs succeeded.
	Thu Nov  7 12:51:01 2019 - [info] Waiting until all relay logs are applied.
	Thu Nov  7 12:51:01 2019 - [info]  done.
	Thu Nov  7 12:51:01 2019 - [info] Getting slave status..
	Thu Nov  7 12:51:01 2019 - [info] This slave(192.168.0.103) s Exec_Master_Log_Pos equals to Read_Master_Log_Pos(mysql-bin.000008:862). No need to recover from Exec_Master_Log_Pos.
	Thu Nov  7 12:51:01 2019 - [info] Connecting to the target slave host 192.168.0.103, running recover script..
	
	******************** Slave按顺序应用与最新的Slave缺失的relay-log，以及故障Master保存的binlog ********************
	Thu Nov  7 12:51:01 2019 - [info] Executing command: apply_diff_relay_logs --command=apply --slave_user='root' --slave_host=192.168.0.103 --slave_ip=192.168.0.103  --slave_port=3306 --apply_files=/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog --workdir=/var/log/masterha/app1 --target_version=8.0.18 --timestamp=20191107125044 --handle_raw_binlog=1 --disable_log_bin=0 --manager_version=0.58 --slave_pass=xxx
	Thu Nov  7 12:51:01 2019 - [info] 
	Applying differential binary/relay log files /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog on 192.168.0.103:3306. This may take long time...
	Applying log files succeeded.
	Thu Nov  7 12:51:01 2019 - [info]  All relay logs were successfully applied.
	Thu Nov  7 12:51:01 2019 - [info]  Resetting slave 192.168.0.103(192.168.0.103:3306) and starting replication from the new master 192.168.0.102(192.168.0.102:3306)..
	Thu Nov  7 12:51:01 2019 - [info]  Executed CHANGE MASTER.
	Thu Nov  7 12:51:01 2019 - [info]  Slave started.
	Thu Nov  7 12:51:02 2019 - [info] End of log messages from 192.168.0.103.
	Thu Nov  7 12:51:02 2019 - [info] -- Slave recovery on host 192.168.0.103(192.168.0.103:3306) succeeded.
	Thu Nov  7 12:51:02 2019 - [info] All new slave servers recovered successfully.
	==================== 4、Slave恢复阶段，End ====================
	
	Thu Nov  7 12:51:02 2019 - [info] 
	
	==================== 5、新Master清理阶段，Start ====================
	Thu Nov  7 12:51:02 2019 - [info] * Phase 5: New master cleanup phase..
	Thu Nov  7 12:51:02 2019 - [info] 
	Thu Nov  7 12:51:02 2019 - [info] Resetting slave info on the new master..
	Thu Nov  7 12:51:02 2019 - [info]  192.168.0.102: Resetting slave info succeeded.
	Thu Nov  7 12:51:02 2019 - [info] Master failover to 192.168.0.102(192.168.0.102:3306) completed successfully.
	Thu Nov  7 12:51:02 2019 - [info] 

	----- Failover Report -----

	app1: MySQL Master failover 192.168.0.101(192.168.0.101:3306) to 192.168.0.102(192.168.0.102:3306) succeeded

	Master 192.168.0.101(192.168.0.101:3306) is down!

	Check MHA Manager logs at mha03 for details.

	Started manual(interactive) failover.
	Invalidated master IP address on 192.168.0.101(192.168.0.101:3306)
	The latest slave 192.168.0.103(192.168.0.103:3306) has all relay logs for recovery.
	Selected 192.168.0.102(192.168.0.102:3306) as a new master.
	192.168.0.102(192.168.0.102:3306): OK: Applying all logs succeeded.
	192.168.0.102(192.168.0.102:3306): OK: Activated master IP address.
	192.168.0.103(192.168.0.103:3306): This host has the latest relay log events.
	Generating relay diff files from the latest slave succeeded.
	192.168.0.103(192.168.0.103:3306): OK: Applying all logs succeeded. Slave started, replicating from 192.168.0.102(192.168.0.102:3306)
	192.168.0.102(192.168.0.102:3306): Resetting slave info succeeded.
	Master failover to 192.168.0.102(192.168.0.102:3306) completed successfully.


手动Failover(传统复制)切换流程:
	1、配置检查：
		
		连接各实例，检查服务状态，检查主从关系
		
	2、宕机的master处理

		这个阶段包括虚拟ip摘除
		停止各Slave上的IO Thread，
		
		
	3、新Master恢复
		3.1、获取最新的Slave
			用于补全新Master/其他Slave缺少的数据；用于save故障Master的binlog的起始点
		3.2、保存故障Master的binlog
			故障Master上执行save_binary_logs(只取最新Slave之后的部分)\n将得到的binlog scp到手动Failover运行的工作目录
		3.3、选举新Master
			查找最新的Slave是否包含最旧的Slave缺失的relay-log
			确定新Master，得到切换前后结构
			生成最新Slave和新Master之间的差异relay-log，并拷贝到新Master的工作目录
			从手动Failover运行的工作目录scp故障Master的binlog到新Master工作目录
		3.4、新Master应用差异log
			等待新Master应用完自己的relay-log
			按顺序应用与最新的Slave缺失的relay-log，以及故障Master保存的binlog
			将所有缺失的relay-log、binlog汇总到total_binlog
			得到新Master的binlog:pos，其他Slave将从这个位置开始复制
			绑定虚拟IP，新Master可以对外提供服务
	4、其他Slave恢复
		4.1、生成差异log
			生成最新Slave和Slave之间的差异relay-log，并拷贝到Slave的工作目录；从手动Failover运行的工作目录scp故障Master的binlog到Slave工作目录
		4.2、Slave应用差异log
			等待Slave应用完自己的relay-log；按顺序应用与最新的Slave缺失的relay-log，以及故障Master保存的binlog；重置Slave上的复制到新Master~
		4.3、如果存在多个Slaves，重复上述操作
	5、新Master清理：清理旧的复制信息STOP SLAVE;RESET SLAVE ALL;


2.3、目录文件
	切换流程需要补全数据，会产生各类文件
	1. Dead Master
		[root@mha01 app1]# pwd
		/var/log/masterha/app1
		[root@mha01 app1]# ll
		total 8
		-rw-r--r-- 1 root root 1214 Nov  6 17:50 app1.log
		lrwxrwxrwx 1 root root   26 Nov  6 17:48 mysql -> /usr/local/mysql/bin/mysql
		-rw-r--r-- 1 root root  463 Nov  7 12:50 saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog
		saved_master_binlog_from_**：故障Master与最新Slave之间的差异binlog，在故障Master生成，然后拷贝到 MHA管理节点/手动Failover 工作目录
		
	2. new Master:	
		[root@mha02 app1]# pwd
		/var/log/masterha/app1
		[root@mha02 app1]# ll
		total 20
		-rw-r--r--. 1 root root  610 Nov  7 12:50 relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog
		-rw-r--r--. 1 root root 4254 Nov  7 12:50 relay_log_apply_for_192.168.0.102_3306_20191107125044_err.log
		-rw-r--r--. 1 root root  463 Nov  7 12:50 saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog
		-rw-r--r--. 1 root root  882 Nov  7 12:50 total_binlog_for_192.168.0.102_3306.20191107125044.binlog

		relay_from_read_to_latest_**：从最新的Slave上拷贝过来
		saved_master_binlog_from_ **：从管理节点拷贝过来，源头在故障Master
		total_binlog_for_**：汇总所有缺失的relay-log、binlog信息


	3. 最新更新的Slave
		[root@mha03 app1]# pwd
		/var/log/masterha/app1
		[root@mha03 app1]# ll
		total 32
		-rw-r--r--. 1 root root     0 Nov  7 12:51 app1.failover.complete
		-rw-r--r--. 1 root root 19866 Nov  7 12:46 app1.log
		-rw-r--r--. 1 root root   610 Nov  7 12:50 relay_from_read_to_latest_192.168.0.102_3306_20191107125044.binlog
		-rw-r--r--. 1 root root  3200 Nov  7 12:51 relay_log_apply_for_192.168.0.103_3306_20191107125044_err.log
		-rw-r--r--. 1 root root   463 Nov  7 12:51 saved_master_binlog_from_192.168.0.101_3306_20191107125044.binlog


		relay_from_read_to_latest_**：最新Slave与其他Slave之间的差异relay-log，在最新Slave生成，然后拷贝到其他对应Slave
		saved_master_binlog_from_**：从管理节点拷贝过来，源头在故障Master

		
		动故障切换后结构为：mha03(slave)->mha02(master)，且数据进行了自动补全

		
当故障的Master恢复后,如何加入进MHA集群中来 ?
	初步思路: 重建从库
	
	但是, 

	mha02: 写入一条记录
		
		
		root@mysqldb 13:42:  [test]> insert into test.t1 values (4);
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		+------+
		3 rows in set (0.00 sec)
		
		
		insert into test.t1 values (4);
		
		
		root@mysqldb 13:43:  [test]> select * from test.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		|    4 |
		+------+
		4 rows in set (0.00 sec)
		
	
5. 修复宕机的Master 

    通常情况下自动切换以后，原master可能已经废弃掉，待原master主机修复后，如果数据完整的情况下，可能想把原来master重新作为新主库的slave。
	这时我们可以借助当时自动切换(手工切换没有看到All other slaves should start replication from here语句, 原因: 当前手工切换有停止主库,所以看不到对应的语句)时刻的MHA日志来完成对原master的修复。下面是提取相关日志的命令：

	grep -i "All other slaves should start" /var/log/masterha/app1/app1.log
	        可以看到类似下面的信息：

	All other slaves should start replication from here. Statement should be: CHANGE MASTER TO MASTER_HOST='172.16.1.126', MASTER_PORT=3306, MASTER_LOG_FILE='mysql-bin.000005', MASTER_LOG_POS=120, MASTER_USER='repl', MASTER_PASSWORD='123456';
	        意思是说，如果Master主机修复好了，可以在修复好后的Master执行CHANGE MASTER操作，作为新的slave库。

	查看新主的 位点:
		root@mysqldb 13:43:  [test]> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000006
				 Position: 1391

		change master to master_host='192.168.0.102', master_port=3306, master_user='mharpl', master_password='123456abc', master_log_file='mysql-bin.000006', master_log_pos=1391;
		start slave;
		show slave status\G;
		
		set log_bin=OFF;
		insert into test.t1 values (4);
		
		root@mysqldb 14:01:  [(none)]> set log_bin=OFF;
		ERROR 1238 (HY000): Variable 'log_bin' is a read only variable
		
		
		[root@mha02 app1]# 
		[root@mha02 app1]# masterha_check_repl --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf
		Thu Nov  7 14:06:29 2019 - [info] Reading default configuration from /etc/masterha/masterha_default.conf..
		Thu Nov  7 14:06:29 2019 - [info] Reading application default configuration from /etc/masterha/app1.conf..
		Thu Nov  7 14:06:29 2019 - [info] Reading server configuration from /etc/masterha/app1.conf..
		Thu Nov  7 14:06:29 2019 - [info] MHA::MasterMonitor version 0.58.
		Thu Nov  7 14:06:30 2019 - [info] GTID failover mode = 0
		Thu Nov  7 14:06:30 2019 - [info] Dead Servers:
		Thu Nov  7 14:06:30 2019 - [info] Alive Servers:
		Thu Nov  7 14:06:30 2019 - [info]   192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 14:06:30 2019 - [info]   192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 14:06:30 2019 - [info]   192.168.0.103(192.168.0.103:3306)
		Thu Nov  7 14:06:30 2019 - [info] Alive Slaves:
		Thu Nov  7 14:06:30 2019 - [info]   192.168.0.101(192.168.0.101:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 14:06:30 2019 - [info]     Replicating from 192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 14:06:30 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 14:06:30 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 14:06:30 2019 - [info]     Replicating from 192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 14:06:30 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 14:06:30 2019 - [info] Current Alive Master: 192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 14:06:30 2019 - [info] Checking slave configurations..
		Thu Nov  7 14:06:30 2019 - [info]  read_only=1 is not set on slave 192.168.0.101(192.168.0.101:3306).
		Thu Nov  7 14:06:30 2019 - [warning]  relay_log_purge=0 is not set on slave 192.168.0.101(192.168.0.101:3306).
		Thu Nov  7 14:06:30 2019 - [info]  read_only=1 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Thu Nov  7 14:06:30 2019 - [warning]  relay_log_purge=0 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Thu Nov  7 14:06:30 2019 - [info] Checking replication filtering settings..
		Thu Nov  7 14:06:30 2019 - [info]  binlog_do_db= , binlog_ignore_db= 
		Thu Nov  7 14:06:30 2019 - [info]  Replication filtering check ok.
		Thu Nov  7 14:06:30 2019 - [error][/usr/share/perl5/vendor_perl/MHA/Server.pm, ln398] 192.168.0.101(192.168.0.101:3306): User mha does not exist or does not have REPLICATION SLAVE privilege! Other slaves can not start replication from this host.
		Thu Nov  7 14:06:30 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln427] Error happened on checking configurations.  at /usr/share/perl5/vendor_perl/MHA/ServerManager.pm line 1403.
		Thu Nov  7 14:06:30 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln525] Error happened on monitoring servers.
		Thu Nov  7 14:06:30 2019 - [info] Got exit code 1 (Not master dead).

		MySQL Replication Health is NOT OK!
		
		原因: 不要在新主执行 masterha_check_repl, 要在 mha03执行.


	mha02: 新主执行:
		insert into test.t1 values (5);

	

	