


MHA的启动和关闭
	启动:
		nohup masterha_manager --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf > /tmp/mha_manager.log 2>&1 &
		nohup masterha_manager --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --ignore_last_failover > /tmp/mha_manager.log 2>&1 &
		
		tail -f /tmp/mha_manager.log:
		Thu Nov  7 09:36:34 2019 - [info] Reading default configuration from /etc/masterha/masterha_default.conf..
		Thu Nov  7 09:36:34 2019 - [info] Reading application default configuration from /etc/masterha/app1.conf..
		Thu Nov  7 09:36:34 2019 - [info] Reading server configuration from /etc/masterha/app1.conf..
		
		tail -f /tmp/mha_manager.log:
		Thu Nov  7 15:12:59 2019 - [info] Starting ping health check on 192.168.0.101(192.168.0.101:3306)..
		Thu Nov  7 15:13:03 2019 - [warning] Got error when monitoring master:  at /usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm line 489.
		Thu Nov  7 15:13:03 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln491] Target master s advisory lock is already held by someone. Please check whether you monitor the same master from multiple monitoring processes.
		Thu Nov  7 15:13:03 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln511] Error happened on health checking.  at /usr/bin/masterha_manager line 50.
		Thu Nov  7 15:13:03 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterMonitor.pm, ln525] Error happened on monitoring servers.
		Thu Nov  7 15:13:03 2019 - [info] Got exit code 1 (Not master dead).
		
		原因: 已经启动过 masterha_manager
			[root@mha03 app1]#  masterha_stop --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf
			Stopped app1 successfully.
			[5]   Exit 1                  masterha_manager --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf > /tmp/mha_manager.log 2>&1
			[6]   Exit 1                  masterha_manager --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf > /tmp/mha_manager.log 2>&1


检查MHA Manager的状态
	shell> masterha_check_status --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf
	app1 (pid:6832) is running(0:PING_OK), master:192.168.0.101
	可以看见已经在监控了，而且master的主机为192.168.0.101。
	
	停止 mha
	shell> masterha_stop --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf
	
	
	
数据准备

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


	
	
Node2和Node3节点的复制状态

	Node2
		root@mysqldb 12:42:  [(none)]> pager cat | egrep 'Master_Log_File|Relay_Master_Log_File|Read_Master_Log_Pos|Exec_Master_Log_Pos|Running'
		PAGER set to 'cat | egrep 'Master_Log_File|Relay_Master_Log_File|Read_Master_Log_Pos|Exec_Master_Log_Pos|Running''

		root@mysqldb 14:56:  [test]>  show slave status\G;
					  Master_Log_File: mysql-bin.000009
				  Read_Master_Log_Pos: 2035
				Relay_Master_Log_File: mysql-bin.000009
					 Slave_IO_Running: No
					Slave_SQL_Running: Yes
				  Exec_Master_Log_Pos: 2035
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		1 row in set (0.00 sec)



	Node3
		root@mysqldb 12:43:  [(none)]> pager cat | egrep 'Master_Log_File|Relay_Master_Log_File|Read_Master_Log_Pos|Exec_Master_Log_Pos|Running'
		PAGER set to 'cat | egrep 'Master_Log_File|Relay_Master_Log_File|Read_Master_Log_Pos|Exec_Master_Log_Pos|Running''
		root@mysqldb 14:56:  [(none)]> show slave status\G;
					  Master_Log_File: mysql-bin.000009
				  Read_Master_Log_Pos: 2288
				Relay_Master_Log_File: mysql-bin.000009
					 Slave_IO_Running: No
					Slave_SQL_Running: Yes
				  Exec_Master_Log_Pos: 2288
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
		1 row in set (0.00 sec)


故障测试 
		
	关闭Node1节点数据库服务
		mysql> shutdown; 
		
	故障切换日志:
		
		错误1: 
		Thu Nov  7 14:57:26 2019 - [warning] Got error on MySQL select ping: 1053 (Server shutdown in progress)
		Thu Nov  7 14:57:26 2019 - [info] Executing SSH check script: save_binary_logs --command=test --start_pos=4 --binlog_dir=/data/mysql/mysql3306/data --output_file=/var/log/masterha/app1/save_binary_logs_test --manager_version=0.58 --binlog_prefix=mysql-bin
		Thu Nov  7 14:57:26 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
		Thu Nov  7 14:57:27 2019 - [warning] Got error on MySQL connect: 2003 (Can't connect to MySQL server on '192.168.0.101' (111))
		Thu Nov  7 14:57:27 2019 - [warning] Connection failed 2 time(s)..
		Thu Nov  7 14:57:28 2019 - [warning] Got error on MySQL connect: 2003 (Can't connect to MySQL server on '192.168.0.101' (111))
		Thu Nov  7 14:57:28 2019 - [warning] Connection failed 3 time(s)..
		Thu Nov  7 14:57:29 2019 - [warning] Got error on MySQL connect: 2003 (Can t connect to MySQL server on '192.168.0.101' (111))
		Thu Nov  7 14:57:29 2019 - [warning] Connection failed 4 time(s)..
		Thu Nov  7 14:57:29 2019 - [warning] Master is not reachable from health checker!
		Thu Nov  7 14:57:29 2019 - [warning] Master 192.168.0.101(192.168.0.101:3306) is not reachable!
		Thu Nov  7 14:57:29 2019 - [warning] SSH is reachable.
		Thu Nov  7 14:57:29 2019 - [info] Connecting to a master server failed. Reading configuration file /etc/masterha/masterha_default.conf and /etc/masterha/app1.conf again, and trying to connect to all servers to check server status..
		Thu Nov  7 14:57:29 2019 - [info] Reading default configuration from /etc/masterha/masterha_default.conf..
		Thu Nov  7 14:57:29 2019 - [info] Reading application default configuration from /etc/masterha/app1.conf..
		Thu Nov  7 14:57:29 2019 - [info] Reading server configuration from /etc/masterha/app1.conf..
		Thu Nov  7 14:57:30 2019 - [info] GTID failover mode = 0
		Thu Nov  7 14:57:30 2019 - [info] Dead Servers:
		Thu Nov  7 14:57:30 2019 - [info]   192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 14:57:30 2019 - [info] Alive Servers:
		Thu Nov  7 14:57:30 2019 - [info]   192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 14:57:30 2019 - [info]   192.168.0.103(192.168.0.103:3306)
		Thu Nov  7 14:57:30 2019 - [info] Alive Slaves:
		Thu Nov  7 14:57:30 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 14:57:30 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 14:57:30 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 14:57:30 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 14:57:30 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 14:57:30 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 14:57:30 2019 - [info] Checking slave configurations..
		Thu Nov  7 14:57:30 2019 - [info]  read_only=1 is not set on slave 192.168.0.102(192.168.0.102:3306).
		Thu Nov  7 14:57:30 2019 - [warning]  relay_log_purge=0 is not set on slave 192.168.0.102(192.168.0.102:3306).
		Thu Nov  7 14:57:30 2019 - [info]  read_only=1 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Thu Nov  7 14:57:30 2019 - [warning]  relay_log_purge=0 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Thu Nov  7 14:57:30 2019 - [info] Checking replication filtering settings..
		Thu Nov  7 14:57:30 2019 - [info]  Replication filtering check ok.
		Thu Nov  7 14:57:30 2019 - [info] Master is down!
		Thu Nov  7 14:57:30 2019 - [info] Terminating monitoring script.
		Thu Nov  7 14:57:30 2019 - [info] Got exit code 20 (Master dead).
		Thu Nov  7 14:57:30 2019 - [info] MHA::MasterFailover version 0.58.
		Thu Nov  7 14:57:30 2019 - [info] Starting master failover.
		Thu Nov  7 14:57:30 2019 - [info] 
		Thu Nov  7 14:57:30 2019 - [info] * Phase 1: Configuration Check Phase..
		Thu Nov  7 14:57:30 2019 - [info] 
		Thu Nov  7 14:57:31 2019 - [info] GTID failover mode = 0
		Thu Nov  7 14:57:31 2019 - [info] Dead Servers:
		Thu Nov  7 14:57:31 2019 - [info]   192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 14:57:31 2019 - [info] Checking master reachability via MySQL(double check)...
		Thu Nov  7 14:57:31 2019 - [info]  ok.
		Thu Nov  7 14:57:31 2019 - [info] Alive Servers:
		Thu Nov  7 14:57:31 2019 - [info]   192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 14:57:31 2019 - [info]   192.168.0.103(192.168.0.103:3306)
		Thu Nov  7 14:57:31 2019 - [info] Alive Slaves:
		Thu Nov  7 14:57:31 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 14:57:31 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 14:57:31 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 14:57:31 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 14:57:31 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 14:57:31 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 14:57:31 2019 - [error][/usr/share/perl5/vendor_perl/MHA/MasterFailover.pm, ln310] Last failover was done at 2019/11/07 14:42:03. Current time is too early to do failover again. If you want to do failover, manually remove /var/log/masterha/app1/app1.failover.complete and run this script again.
		Thu Nov  7 14:57:31 2019 - [error][/usr/share/perl5/vendor_perl/MHA/ManagerUtil.pm, ln177] Got ERROR:  at /usr/bin/masterha_manager line 65.
			
		原因:  /var/log/masterha/app1/app1.failover.complete 文件已经存在
			If you want to do failover, manually remove /var/log/masterha/app1/app1.failover.complete and run this script again.
		
		分析:
			--ignore_last_failover:
				在缺省情况下，如果 MHA 检测到连续发生宕机，且两次宕机间隔不足 8 小时的话，则不会进行 Failover，之所以这样限制是为了避免 ping-pong 效应。
				该参数代表忽略上次 MHA 触发切换产生的文件，默认情况下，MHA 发生切换后会在日志目录，也就是上面我设置的/var/log/masterha/app1/产生 app1.failover.complete 文件，
				下次再次切换的时候如果发现该目录下存在该文件将不允许触发切换，除非在第一次切换后收到删除该文件，为了方便，这里设置为 --ignore_last_failover。

		解决办法:
			需要删除  /var/log/masterha/app1/app1.failover.complete 文件
			
			
		Thu Nov  7 15:15:48 2019 - [info] MHA::MasterMonitor version 0.58.
		Thu Nov  7 15:15:49 2019 - [info] GTID failover mode = 0
		Thu Nov  7 15:15:49 2019 - [info] Dead Servers:
		Thu Nov  7 15:15:49 2019 - [info] Alive Servers:
		Thu Nov  7 15:15:49 2019 - [info]   192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:15:49 2019 - [info]   192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 15:15:49 2019 - [info]   192.168.0.103(192.168.0.103:3306)
		Thu Nov  7 15:15:49 2019 - [info] Alive Slaves:
		Thu Nov  7 15:15:49 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:15:49 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:15:49 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:15:49 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:15:49 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:15:49 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:15:49 2019 - [info] Current Alive Master: 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:15:49 2019 - [info] Checking slave configurations..
		Thu Nov  7 15:15:49 2019 - [info]  read_only=1 is not set on slave 192.168.0.102(192.168.0.102:3306).
		Thu Nov  7 15:15:49 2019 - [warning]  relay_log_purge=0 is not set on slave 192.168.0.102(192.168.0.102:3306).
		Thu Nov  7 15:15:49 2019 - [info]  read_only=1 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Thu Nov  7 15:15:49 2019 - [warning]  relay_log_purge=0 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Thu Nov  7 15:15:49 2019 - [info] Checking replication filtering settings..
		Thu Nov  7 15:15:49 2019 - [info]  binlog_do_db= , binlog_ignore_db= 
		Thu Nov  7 15:15:49 2019 - [info]  Replication filtering check ok.
		Thu Nov  7 15:15:49 2019 - [info] GTID (with auto-pos) is not supported
		Thu Nov  7 15:15:49 2019 - [info] Starting SSH connection tests..
		Thu Nov  7 15:15:51 2019 - [info] All SSH connection tests passed successfully.
		Thu Nov  7 15:15:51 2019 - [info] Checking MHA Node version..
		Thu Nov  7 15:15:52 2019 - [info]  Version check ok.
		Thu Nov  7 15:15:52 2019 - [info] Checking SSH publickey authentication settings on the current master..
		Thu Nov  7 15:15:52 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
		Thu Nov  7 15:15:52 2019 - [info] Master MHA Node version is 0.58.
		Thu Nov  7 15:15:52 2019 - [info] Checking recovery script configurations on 192.168.0.101(192.168.0.101:3306)..
		Thu Nov  7 15:15:52 2019 - [info]   Executing command: save_binary_logs --command=test --start_pos=4 --binlog_dir=/data/mysql/mysql3306/data --output_file=/var/log/masterha/app1/save_binary_logs_test --manager_version=0.58 --start_file=mysql-bin.000010 
		Thu Nov  7 15:15:52 2019 - [info]   Connecting to root@192.168.0.101(192.168.0.101:22).. 
		  Creating /var/log/masterha/app1 if not exists..    ok.
		  Checking output directory is accessible or not..
		   ok.
		  Binlog found at /data/mysql/mysql3306/data, up to mysql-bin.000010
		Thu Nov  7 15:15:53 2019 - [info] Binlog setting check done.
		Thu Nov  7 15:15:53 2019 - [info] Checking SSH publickey authentication and checking recovery script configurations on all alive slave servers..
		Thu Nov  7 15:15:53 2019 - [info]   Executing command : apply_diff_relay_logs --command=test --slave_user='root' --slave_host=192.168.0.102 --slave_ip=192.168.0.102 --slave_port=3306 --workdir=/var/log/masterha/app1 --target_version=8.0.18 --manager_version=0.58 --relay_dir=/data/mysql/mysql3306/data --current_relay_log=mha02-relay-bin.000005  --slave_pass=xxx
		Thu Nov  7 15:15:53 2019 - [info]   Connecting to root@192.168.0.102(192.168.0.102:22).. 
		  Checking slave recovery environment settings..
			Relay log found at /data/mysql/mysql3306/data, up to mha02-relay-bin.000005
			Temporary relay log file is /data/mysql/mysql3306/data/mha02-relay-bin.000005
			Checking if super_read_only is defined and turned on.. not present or turned off, ignoring.
			Testing mysql connection and privileges..
		mysql: [Warning] Using a password on the command line interface can be insecure.
		 done.
			Testing mysqlbinlog output.. done.
			Cleaning up test file(s).. done.
		Thu Nov  7 15:15:53 2019 - [info]   Executing command : apply_diff_relay_logs --command=test --slave_user='root' --slave_host=192.168.0.103 --slave_ip=192.168.0.103 --slave_port=3306 --workdir=/var/log/masterha/app1 --target_version=8.0.18 --manager_version=0.58 --relay_dir=/data/mysql/mysql3306/data --current_relay_log=mha03-relay-bin.000005  --slave_pass=xxx
		Thu Nov  7 15:15:53 2019 - [info]   Connecting to root@192.168.0.103(192.168.0.103:22).. 
		  Checking slave recovery environment settings..
			Relay log found at /data/mysql/mysql3306/data, up to mha03-relay-bin.000005
			Temporary relay log file is /data/mysql/mysql3306/data/mha03-relay-bin.000005
			Checking if super_read_only is defined and turned on.. not present or turned off, ignoring.
			Testing mysql connection and privileges..
		mysql: [Warning] Using a password on the command line interface can be insecure.
		 done.
			Testing mysqlbinlog output.. done.
			Cleaning up test file(s).. done.
		Thu Nov  7 15:15:54 2019 - [info] Slaves settings check done.
		Thu Nov  7 15:15:54 2019 - [info] 
		192.168.0.101(192.168.0.101:3306) (current master)
		 +--192.168.0.102(192.168.0.102:3306)
		 +--192.168.0.103(192.168.0.103:3306)

		Thu Nov  7 15:15:54 2019 - [info] Checking master_ip_failover_script status:
		Thu Nov  7 15:15:54 2019 - [info]   /etc/masterha/master_ip_failover --command=status --ssh_user=root --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 
		Thu Nov  7 15:15:54 2019 - [info]  OK.
		Thu Nov  7 15:15:54 2019 - [warning] shutdown_script is not defined.
		Thu Nov  7 15:15:54 2019 - [info] Set master ping interval 1 seconds.
		Thu Nov  7 15:15:54 2019 - [warning] secondary_check_script is not defined. It is highly recommended setting it to check master reachability from two or more routes.
		Thu Nov  7 15:15:54 2019 - [info] Starting ping health check on 192.168.0.101(192.168.0.101:3306)..
		Thu Nov  7 15:15:54 2019 - [info] Ping(SELECT) succeeded, waiting until MySQL doesn't respond..
		Thu Nov  7 15:18:50 2019 - [warning] Got error on MySQL select ping: 1053 (Server shutdown in progress)
		Thu Nov  7 15:18:50 2019 - [info] Executing SSH check script: save_binary_logs --command=test --start_pos=4 --binlog_dir=/data/mysql/mysql3306/data --output_file=/var/log/masterha/app1/save_binary_logs_test --manager_version=0.58 --binlog_prefix=mysql-bin
		Thu Nov  7 15:18:50 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
		Thu Nov  7 15:18:51 2019 - [warning] Got error on MySQL connect: 2003 (Can't connect to MySQL server on '192.168.0.101' (111))
		Thu Nov  7 15:18:51 2019 - [warning] Connection failed 2 time(s)..
		Thu Nov  7 15:18:52 2019 - [warning] Got error on MySQL connect: 2003 (Can't connect to MySQL server on '192.168.0.101' (111))
		Thu Nov  7 15:18:52 2019 - [warning] Connection failed 3 time(s)..
		Thu Nov  7 15:18:53 2019 - [warning] Got error on MySQL connect: 2003 (Can't connect to MySQL server on '192.168.0.101' (111))
		Thu Nov  7 15:18:53 2019 - [warning] Connection failed 4 time(s)..
		Thu Nov  7 15:18:53 2019 - [warning] Master is not reachable from health checker!
		Thu Nov  7 15:18:53 2019 - [warning] Master 192.168.0.101(192.168.0.101:3306) is not reachable!
		Thu Nov  7 15:18:53 2019 - [warning] SSH is reachable.
		Thu Nov  7 15:18:53 2019 - [info] Connecting to a master server failed. Reading configuration file /etc/masterha/masterha_default.conf and /etc/masterha/app1.conf again, and trying to connect to all servers to check server status..
		Thu Nov  7 15:18:53 2019 - [info] Reading default configuration from /etc/masterha/masterha_default.conf..
		Thu Nov  7 15:18:53 2019 - [info] Reading application default configuration from /etc/masterha/app1.conf..
		Thu Nov  7 15:18:53 2019 - [info] Reading server configuration from /etc/masterha/app1.conf..
		Thu Nov  7 15:18:54 2019 - [info] GTID failover mode = 0
		Thu Nov  7 15:18:54 2019 - [info] Dead Servers:
		Thu Nov  7 15:18:54 2019 - [info]   192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:54 2019 - [info] Alive Servers:
		Thu Nov  7 15:18:54 2019 - [info]   192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 15:18:54 2019 - [info]   192.168.0.103(192.168.0.103:3306)
		Thu Nov  7 15:18:54 2019 - [info] Alive Slaves:
		Thu Nov  7 15:18:54 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:18:54 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:54 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:18:54 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:18:54 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:54 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:18:54 2019 - [info] Checking slave configurations..
		Thu Nov  7 15:18:54 2019 - [info]  read_only=1 is not set on slave 192.168.0.102(192.168.0.102:3306).
		Thu Nov  7 15:18:54 2019 - [warning]  relay_log_purge=0 is not set on slave 192.168.0.102(192.168.0.102:3306).
		Thu Nov  7 15:18:54 2019 - [info]  read_only=1 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Thu Nov  7 15:18:54 2019 - [warning]  relay_log_purge=0 is not set on slave 192.168.0.103(192.168.0.103:3306).
		Thu Nov  7 15:18:54 2019 - [info] Checking replication filtering settings..
		Thu Nov  7 15:18:54 2019 - [info]  Replication filtering check ok.
		Thu Nov  7 15:18:54 2019 - [info] Master is down!
		Thu Nov  7 15:18:54 2019 - [info] Terminating monitoring script.
		Thu Nov  7 15:18:54 2019 - [info] Got exit code 20 (Master dead).
		Thu Nov  7 15:18:54 2019 - [info] MHA::MasterFailover version 0.58.
		Thu Nov  7 15:18:54 2019 - [info] Starting master failover.
		Thu Nov  7 15:18:54 2019 - [info] 
		
		==================== 1、配置检查阶段，Start ====================
		
		Thu Nov  7 15:18:54 2019 - [info] * Phase 1: Configuration Check Phase..
		Thu Nov  7 15:18:54 2019 - [info] 
		Thu Nov  7 15:18:55 2019 - [info] GTID failover mode = 0
		Thu Nov  7 15:18:55 2019 - [info] Dead Servers:
		Thu Nov  7 15:18:55 2019 - [info]   192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:55 2019 - [info] Checking master reachability via MySQL(double check)...
		Thu Nov  7 15:18:55 2019 - [info]  ok.
		Thu Nov  7 15:18:55 2019 - [info] Alive Servers:
		Thu Nov  7 15:18:55 2019 - [info]   192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 15:18:55 2019 - [info]   192.168.0.103(192.168.0.103:3306)
		Thu Nov  7 15:18:55 2019 - [info] Alive Slaves:
		Thu Nov  7 15:18:55 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:18:55 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:55 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:18:55 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:18:55 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:55 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:18:55 2019 - [info] Starting Non-GTID based failover.
		Thu Nov  7 15:18:55 2019 - [info] 
		Thu Nov  7 15:18:55 2019 - [info] ** Phase 1: Configuration Check Phase completed.
		==================== 1、配置检查阶段，End ====================

		Thu Nov  7 15:18:55 2019 - [info] 
		
		==================== 2、故障Master关闭阶段，Start ====================

		Thu Nov  7 15:18:55 2019 - [info] * Phase 2: Dead Master Shutdown Phase..
		Thu Nov  7 15:18:55 2019 - [info] 
		Thu Nov  7 15:18:55 2019 - [info] Forcing shutdown so that applications never connect to the current master..
		Thu Nov  7 15:18:55 2019 - [info] Executing master IP deactivation script:
		Thu Nov  7 15:18:55 2019 - [info]   /etc/masterha/master_ip_failover --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --command=stopssh --ssh_user=root  
		Thu Nov  7 15:18:55 2019 - [info]  done.
		Thu Nov  7 15:18:55 2019 - [warning] shutdown_script is not set. Skipping explicit shutting down of the dead master.
		Thu Nov  7 15:18:55 2019 - [info] * Phase 2: Dead Master Shutdown Phase completed.
		==================== 2、故障Master关闭阶段，End ====================

		Thu Nov  7 15:18:55 2019 - [info] 
		==================== 3、新Master恢复阶段，Start ====================

		Thu Nov  7 15:18:55 2019 - [info] * Phase 3: Master Recovery Phase..
		Thu Nov  7 15:18:55 2019 - [info] 
		
		==================== 3.1、获取最新的Slave ====================

		Thu Nov  7 15:18:55 2019 - [info] * Phase 3.1: Getting Latest Slaves Phase..
		Thu Nov  7 15:18:55 2019 - [info] 
		Thu Nov  7 15:18:55 2019 - [info] The latest binary log file/position on all slaves is mysql-bin.000010:862
		Thu Nov  7 15:18:55 2019 - [info] Latest slaves (Slaves that received relay log files to the latest):
		Thu Nov  7 15:18:55 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:18:55 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:55 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:18:55 2019 - [info] The oldest binary log file/position on all slaves is mysql-bin.000010:609
		Thu Nov  7 15:18:55 2019 - [info] Oldest slaves:
		Thu Nov  7 15:18:55 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:18:55 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:55 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:18:55 2019 - [info] 
		==================== 3.2、保存故障Master的binlog ====================

		Thu Nov  7 15:18:55 2019 - [info] * Phase 3.2: Saving Dead Master's Binlog Phase..
		Thu Nov  7 15:18:55 2019 - [info] 
		Thu Nov  7 15:18:55 2019 - [info] Fetching dead master's binary logs..
		Thu Nov  7 15:18:55 2019 - [info] Executing command on the dead master 192.168.0.101(192.168.0.101:3306): save_binary_logs --command=save --start_file=mysql-bin.000010  --start_pos=862 --binlog_dir=/data/mysql/mysql3306/data --output_file=/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog --handle_raw_binlog=1 --disable_log_bin=0 --manager_version=0.58
		  Creating /var/log/masterha/app1 if not exists..    ok.
		 Concat binary/relay logs from mysql-bin.000010 pos 862 to mysql-bin.000010 EOF into /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog ..
		  Dumping binlog format description event, from position 0 to 191.. ok.
		  Dumping effective binlog data from /data/mysql/mysql3306/data/mysql-bin.000010 position 862 to tail(1115).. ok.
		 Concat succeeded.
		Thu Nov  7 15:18:56 2019 - [info] scp from root@192.168.0.101:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog to local:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog succeeded.
		Thu Nov  7 15:18:56 2019 - [info] HealthCheck: SSH to 192.168.0.102 is reachable.
		Thu Nov  7 15:18:57 2019 - [info] HealthCheck: SSH to 192.168.0.103 is reachable.
		Thu Nov  7 15:18:57 2019 - [info]
		
		==================== 3.3、从Slave中选举新的Master阶段 ====================
		Thu Nov  7 15:18:57 2019 - [info] * Phase 3.3: Determining New Master Phase..
		Thu Nov  7 15:18:57 2019 - [info] 
		
		******************** 查找最新的Slave是否包含其他Slave缺失的 Relay-log  ********************

		Thu Nov  7 15:18:57 2019 - [info] Finding the latest slave that has all relay logs for recovering other slaves..
		Thu Nov  7 15:18:57 2019 - [info] Checking whether 192.168.0.103 has relay logs from the oldest position..
		Thu Nov  7 15:18:57 2019 - [info] Executing command: apply_diff_relay_logs --command=find --latest_mlf=mysql-bin.000010 --latest_rmlp=862 --target_mlf=mysql-bin.000010 --target_rmlp=609 --server_id=3306 --workdir=/var/log/masterha/app1 --timestamp=20191107151854 --manager_version=0.58 --relay_dir=/data/mysql/mysql3306/data --current_relay_log=mha03-relay-bin.000005  :
			Relay log found at /data/mysql/mysql3306/data, up to mha03-relay-bin.000005
		 Fast relay log position search succeeded.
		 Target relay log file/position found. start_file:mha03-relay-bin.000005, start_pos:775.
		Target relay log FOUND!
		Thu Nov  7 15:18:58 2019 - [info] OK. 192.168.0.103 has all relay logs.
		Thu Nov  7 15:18:58 2019 - [info] Searching new master from slaves..
		Thu Nov  7 15:18:58 2019 - [info]  Candidate masters from the configuration file:
		Thu Nov  7 15:18:58 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:18:58 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:58 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:18:58 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
		Thu Nov  7 15:18:58 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
		Thu Nov  7 15:18:58 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
		Thu Nov  7 15:18:58 2019 - [info]  Non-candidate masters:
		Thu Nov  7 15:18:58 2019 - [info]  Searching from candidate_master slaves which have received the latest relay log events..
		Thu Nov  7 15:18:58 2019 - [info] New master is 192.168.0.103(192.168.0.103:3306)
		Thu Nov  7 15:18:58 2019 - [info] Starting master failover..
		Thu Nov  7 15:18:58 2019 - [info] 
		From:
		192.168.0.101(192.168.0.101:3306) (current master)
		 +--192.168.0.102(192.168.0.102:3306)
		 +--192.168.0.103(192.168.0.103:3306)

		To:
		192.168.0.103(192.168.0.103:3306) (new master)
		 +--192.168.0.102(192.168.0.102:3306)
		Thu Nov  7 15:18:58 2019 - [info] 

		==================== 3.4、新Master产生差异日志 ====================
		******************** 新的Master是最新更新的Slave, 不用跟其它Slave比较差异的relay log,  ********************

		Thu Nov  7 15:18:58 2019 - [info] * Phase 3.4: New Master Diff Log Generation Phase..
		Thu Nov  7 15:18:58 2019 - [info] 
		Thu Nov  7 15:18:58 2019 - [info]  This server has all relay logs. No need to generate diff files from the latest slave.
		Thu Nov  7 15:18:58 2019 - [info] Sending binlog..
		Thu Nov  7 15:18:59 2019 - [info] scp from local:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog to root@192.168.0.103:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog succeeded.
		Thu Nov  7 15:18:59 2019 - [info] 
		
		
		==================== 3.5、新Master应用log ====================

		Thu Nov  7 15:18:59 2019 - [info] * Phase 3.5: Master Log Apply Phase..
		Thu Nov  7 15:18:59 2019 - [info] 
		Thu Nov  7 15:18:59 2019 - [info] *NOTICE: If any error happens from this phase, manual recovery is needed.
		Thu Nov  7 15:18:59 2019 - [info] Starting recovery on 192.168.0.103(192.168.0.103:3306)..
		Thu Nov  7 15:18:59 2019 - [info]  Generating diffs succeeded.
		Thu Nov  7 15:18:59 2019 - [info] Waiting until all relay logs are applied.
		Thu Nov  7 15:18:59 2019 - [info]  done.
		Thu Nov  7 15:18:59 2019 - [info] Getting slave status..
		Thu Nov  7 15:18:59 2019 - [info] This slave(192.168.0.103)'s Exec_Master_Log_Pos equals to Read_Master_Log_Pos(mysql-bin.000010:862). No need to recover from Exec_Master_Log_Pos.
		Thu Nov  7 15:18:59 2019 - [info] Connecting to the target slave host 192.168.0.103, running recover script..
		Thu Nov  7 15:18:59 2019 - [info] Executing command: apply_diff_relay_logs --command=apply --slave_user='root' --slave_host=192.168.0.103 --slave_ip=192.168.0.103  --slave_port=3306 --apply_files=/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog --workdir=/var/log/masterha/app1 --target_version=8.0.18 --timestamp=20191107151854 --handle_raw_binlog=1 --disable_log_bin=0 --manager_version=0.58 --slave_pass=xxx
		Thu Nov  7 15:18:59 2019 - [info] 
		Applying differential binary/relay log files /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog on 192.168.0.103:3306. This may take long time...
		Applying log files succeeded.
		Thu Nov  7 15:18:59 2019 - [info]  All relay logs were successfully applied.
		Thu Nov  7 15:18:59 2019 - [info] Getting new master's binlog name and position..
		Thu Nov  7 15:18:59 2019 - [info]  mysql-bin.000006:4459
		Thu Nov  7 15:18:59 2019 - [info]  All other slaves should start replication from here. Statement should be: CHANGE MASTER TO MASTER_HOST='192.168.0.103', MASTER_PORT=3306, MASTER_LOG_FILE='mysql-bin.000006', MASTER_LOG_POS=4459, MASTER_USER='mharpl', MASTER_PASSWORD='xxx';
		Thu Nov  7 15:18:59 2019 - [info] Executing master IP activate script:
		Thu Nov  7 15:18:59 2019 - [info]   /etc/masterha/master_ip_failover --command=start --ssh_user=root --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --new_master_host=192.168.0.103 --new_master_ip=192.168.0.103 --new_master_port=3306 --new_master_user='root'   --new_master_password=xxx
		Set read_only=0 on the new master.
		Thu Nov  7 15:18:59 2019 - [info]  OK.
		Thu Nov  7 15:19:00 2019 - [info] ** Finished master recovery successfully.
		Thu Nov  7 15:19:00 2019 - [info] * Phase 3: Master Recovery Phase completed.
		Thu Nov  7 15:19:00 2019 - [info] 
		Thu Nov  7 15:19:00 2019 - [info] * Phase 4: Slaves Recovery Phase..
		Thu Nov  7 15:19:00 2019 - [info] 
		Thu Nov  7 15:19:00 2019 - [info] * Phase 4.1: Starting Parallel Slave Diff Log Generation Phase..
		Thu Nov  7 15:19:00 2019 - [info] 
		Thu Nov  7 15:19:00 2019 - [info] -- Slave diff file generation on host 192.168.0.102(192.168.0.102:3306) started, pid: 26270. Check tmp log /var/log/masterha/app1/192.168.0.102_3306_20191107151854.log if it takes time..
		Thu Nov  7 15:19:02 2019 - [info] 
		Thu Nov  7 15:19:02 2019 - [info] Log messages from 192.168.0.102 ...
		Thu Nov  7 15:19:02 2019 - [info] 
		Thu Nov  7 15:19:00 2019 - [info] Server 192.168.0.102 received relay logs up to: mysql-bin.000010:609
		Thu Nov  7 15:19:00 2019 - [info] Need to get diffs from the latest slave(192.168.0.103) up to: mysql-bin.000010:862 (using the latest slave s relay logs)
		Thu Nov  7 15:19:00 2019 - [info] Connecting to the latest slave host 192.168.0.103, generating diff relay log files..
		Thu Nov  7 15:19:00 2019 - [info] Executing command: apply_diff_relay_logs --command=generate_and_send --scp_user=root --scp_host=192.168.0.102 --latest_mlf=mysql-bin.000010 --latest_rmlp=862 --target_mlf=mysql-bin.000010 --target_rmlp=609 --server_id=3306 --diff_file_readtolatest=/var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107151854.binlog --workdir=/var/log/masterha/app1 --timestamp=20191107151854 --handle_raw_binlog=1 --disable_log_bin=0 --manager_version=0.58 --relay_dir=/data/mysql/mysql3306/data --current_relay_log=mha03-relay-bin.000005 
		Thu Nov  7 15:19:01 2019 - [info] 
			Relay log found at /data/mysql/mysql3306/data, up to mha03-relay-bin.000005
		 Fast relay log position search succeeded.
		 Target relay log file/position found. start_file:mha03-relay-bin.000005, start_pos:775.
		 Concat binary/relay logs from mha03-relay-bin.000005 pos 775 to mha03-relay-bin.000005 EOF into /var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107151854.binlog ..
		  Dumping binlog format description event, from position 0 to 357.. ok.
		  Dumping effective binlog data from /data/mysql/mysql3306/data/mha03-relay-bin.000005 position 775 to tail(1028).. ok.
		 Concat succeeded.
		 Generating diff relay log succeeded. Saved at /var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107151854.binlog .
		 scp mha03:/var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107151854.binlog to root@192.168.0.102(22) succeeded.
		Thu Nov  7 15:19:01 2019 - [info]  Generating diff files succeeded.
		Thu Nov  7 15:19:02 2019 - [info] End of log messages from 192.168.0.102.
		Thu Nov  7 15:19:02 2019 - [info] -- Slave diff log generation on host 192.168.0.102(192.168.0.102:3306) succeeded.
		Thu Nov  7 15:19:02 2019 - [info] Generating relay diff files from the latest slave succeeded.
		Thu Nov  7 15:19:02 2019 - [info] 
		Thu Nov  7 15:19:02 2019 - [info] * Phase 4.2: Starting Parallel Slave Log Apply Phase..
		Thu Nov  7 15:19:02 2019 - [info] 
		Thu Nov  7 15:19:02 2019 - [info] -- Slave recovery on host 192.168.0.102(192.168.0.102:3306) started, pid: 26306. Check tmp log /var/log/masterha/app1/192.168.0.102_3306_20191107151854.log if it takes time..
		Thu Nov  7 15:19:04 2019 - [info] 
		Thu Nov  7 15:19:04 2019 - [info] Log messages from 192.168.0.102 ...
		Thu Nov  7 15:19:04 2019 - [info] 
		Thu Nov  7 15:19:02 2019 - [info] Sending binlog..
		Thu Nov  7 15:19:02 2019 - [info] scp from local:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog to root@192.168.0.102:/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog succeeded.
		Thu Nov  7 15:19:02 2019 - [info] Starting recovery on 192.168.0.102(192.168.0.102:3306)..
		Thu Nov  7 15:19:02 2019 - [info]  Generating diffs succeeded.
		Thu Nov  7 15:19:02 2019 - [info] Waiting until all relay logs are applied.
		Thu Nov  7 15:19:02 2019 - [info]  done.
		Thu Nov  7 15:19:02 2019 - [info] Getting slave status..
		Thu Nov  7 15:19:02 2019 - [info] This slave(192.168.0.102) s Exec_Master_Log_Pos equals to Read_Master_Log_Pos(mysql-bin.000010:609). No need to recover from Exec_Master_Log_Pos.
		Thu Nov  7 15:19:02 2019 - [info] Connecting to the target slave host 192.168.0.102, running recover script..
		Thu Nov  7 15:19:02 2019 - [info] Executing command: apply_diff_relay_logs --command=apply --slave_user='root' --slave_host=192.168.0.102 --slave_ip=192.168.0.102  --slave_port=3306 --apply_files=/var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107151854.binlog,/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog --workdir=/var/log/masterha/app1 --target_version=8.0.18 --timestamp=20191107151854 --handle_raw_binlog=1 --disable_log_bin=0 --manager_version=0.58 --slave_pass=xxx
		Thu Nov  7 15:19:03 2019 - [info] 
		 Concat all apply files to /var/log/masterha/app1/total_binlog_for_192.168.0.102_3306.20191107151854.binlog ..
		 Copying the first binlog file /var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107151854.binlog to /var/log/masterha/app1/total_binlog_for_192.168.0.102_3306.20191107151854.binlog.. ok.
		  Dumping binlog head events (rotate events), skipping format description events from /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog.. dumped up to pos 191. ok.
		 /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog has effective binlog events from pos 191.
		  Dumping effective binlog data from /var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog position 191 to tail(444).. ok.
		 Concat succeeded.
		All apply target binary logs are concatinated at /var/log/masterha/app1/total_binlog_for_192.168.0.102_3306.20191107151854.binlog .
		Applying differential binary/relay log files /var/log/masterha/app1/relay_from_read_to_latest_192.168.0.102_3306_20191107151854.binlog,/var/log/masterha/app1/saved_master_binlog_from_192.168.0.101_3306_20191107151854.binlog on 192.168.0.102:3306. This may take long time...
		Applying log files succeeded.
		Thu Nov  7 15:19:03 2019 - [info]  All relay logs were successfully applied.
		Thu Nov  7 15:19:03 2019 - [info]  Resetting slave 192.168.0.102(192.168.0.102:3306) and starting replication from the new master 192.168.0.103(192.168.0.103:3306)..
		Thu Nov  7 15:19:03 2019 - [info]  Executed CHANGE MASTER.
		Thu Nov  7 15:19:03 2019 - [info]  Slave started.
		Thu Nov  7 15:19:04 2019 - [info] End of log messages from 192.168.0.102.
		Thu Nov  7 15:19:04 2019 - [info] -- Slave recovery on host 192.168.0.102(192.168.0.102:3306) succeeded.
		Thu Nov  7 15:19:04 2019 - [info] All new slave servers recovered successfully.
		Thu Nov  7 15:19:04 2019 - [info] 
		Thu Nov  7 15:19:04 2019 - [info] * Phase 5: New master cleanup phase..
		Thu Nov  7 15:19:04 2019 - [info] 
		Thu Nov  7 15:19:04 2019 - [info] Resetting slave info on the new master..
		Thu Nov  7 15:19:04 2019 - [info]  192.168.0.103: Resetting slave info succeeded.
		Thu Nov  7 15:19:04 2019 - [info] Master failover to 192.168.0.103(192.168.0.103:3306) completed successfully.
		Thu Nov  7 15:19:04 2019 - [info] 

		----- Failover Report -----

		app1: MySQL Master failover 192.168.0.101(192.168.0.101:3306) to 192.168.0.103(192.168.0.103:3306) succeeded

		Master 192.168.0.101(192.168.0.101:3306) is down!

		Check MHA Manager logs at mha03:/var/log/masterha/app1/app1.log for details.

		Started automated(non-interactive) failover.
		Invalidated master IP address on 192.168.0.101(192.168.0.101:3306)
		The latest slave 192.168.0.103(192.168.0.103:3306) has all relay logs for recovery.
		Selected 192.168.0.103(192.168.0.103:3306) as a new master.
		192.168.0.103(192.168.0.103:3306): OK: Applying all logs succeeded.
		192.168.0.103(192.168.0.103:3306): OK: Activated master IP address.
		192.168.0.102(192.168.0.102:3306): Generating differential relay logs up to 192.168.0.103(192.168.0.103:3306)succeeded.
		Generating relay diff files from the latest slave succeeded.
		192.168.0.102(192.168.0.102:3306): OK: Applying all logs succeeded. Slave started, replicating from 192.168.0.103(192.168.0.103:3306)
		192.168.0.103(192.168.0.103:3306): Resetting slave info succeeded.
		Master failover to 192.168.0.103(192.168.0.103:3306) completed successfully.


		# 可以看到, VIP 切换到了 mha03这一节点上
		
		
		
		
修复宕机的Master

	All other slaves should start replication from here. Statement should be: 
		CHANGE MASTER TO MASTER_HOST='192.168.0.103', MASTER_PORT=3306, MASTER_LOG_FILE='mysql-bin.000006', MASTER_LOG_POS=4459, MASTER_USER='mharpl', MASTER_PASSWORD='xxx';
	
	CHANGE MASTER TO MASTER_HOST='192.168.0.103', MASTER_PORT=3306, MASTER_LOG_FILE='mysql-bin.000006', MASTER_LOG_POS=4459, MASTER_USER='mharpl', MASTER_PASSWORD='123456abc';
	
	

		