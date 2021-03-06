

1. 环境 
2. 检查整个复制环境状况
3. 数据准备
4. 故障切换测试
5. 查看数据
6. 宕机的mha01恢复


1. 环境 

	hostname    主机          端口号  通信端口号(server-id)    server_uuid                              MySQL版本      role      mha-node
	mha01		192.168.0.101  3306   3306101				   1b9bc372-0042-11ea-b8fa-0800274617cc     MySQL 8.0.18   Master 
	mha02       192.168.0.102  3306   3306102                  e588e3eb-0042-11ea-a95b-0800275dde84     MySQL 8.0.18   Slave     Mha manager & slave 
	mha03       192.168.0.103  3306   3306103                  cbe6921b-0043-11ea-b484-0800270d5e94     MySQL 8.0.18   Slave     new-master   
	VIP         192.168.0.104

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


2. 检查整个复制环境状况

	在 mha03 上用root用户操作。
	masterha_check_repl --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf


3. 数据准备

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
				
4. 故障切换测试
				
	关闭mha01节点数据库服务
		shell> /etc/init.d/mysql stop
			
	mha01节点手动故障切换, 在 mha03上执行:
		 

	
	masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --dead_master_host=192.168.0.101 --master_state=dead --new_master_host=192.168.0.102 --ignore_last_failover

	--dead_master_ip=<dead_master_ip> is not set. Using 192.168.0.101.
	--dead_master_port=<dead_master_port> is not set. Using 3306.
	Fri Nov  8 10:27:11 2019 - [info] Reading default configuration from /etc/masterha/masterha_default.conf..
	Fri Nov  8 10:27:11 2019 - [info] Reading application default configuration from /etc/masterha/app1.conf..
	Fri Nov  8 10:27:11 2019 - [info] Reading server configuration from /etc/masterha/app1.conf..
	Fri Nov  8 10:27:11 2019 - [info] MHA::MasterFailover version 0.58.
	Fri Nov  8 10:27:11 2019 - [info] Starting master failover.
	Fri Nov  8 10:27:11 2019 - [info] 
	Fri Nov  8 10:27:11 2019 - [info] * Phase 1: Configuration Check Phase..
	Fri Nov  8 10:27:11 2019 - [info] 
	Fri Nov  8 10:27:11 2019 - [debug] Connecting to servers..
	Fri Nov  8 10:27:11 2019 - [debug] Got MySQL error when connecting 192.168.0.101(192.168.0.101:3306) :2003:Can t connect to MySQL server on '192.168.0.101' (111)
	Fri Nov  8 10:27:12 2019 - [debug]  Connected to: 192.168.0.102(192.168.0.102:3306), user=root
	Fri Nov  8 10:27:12 2019 - [debug]  Number of slave worker threads on host 192.168.0.102(192.168.0.102:3306): 0
	Fri Nov  8 10:27:12 2019 - [debug]  Connected to: 192.168.0.103(192.168.0.103:3306), user=root
	Fri Nov  8 10:27:12 2019 - [debug]  Number of slave worker threads on host 192.168.0.103(192.168.0.103:3306): 0
	Fri Nov  8 10:27:12 2019 - [debug]  Comparing MySQL versions..
	Fri Nov  8 10:27:12 2019 - [debug]   Comparing MySQL versions done.
	Fri Nov  8 10:27:12 2019 - [debug] Connecting to servers done.
	Fri Nov  8 10:27:12 2019 - [info] GTID failover mode = 1
	Fri Nov  8 10:27:12 2019 - [info] Dead Servers:
	Fri Nov  8 10:27:12 2019 - [info]   192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:27:12 2019 - [info] Checking master reachability via MySQL(double check)...
	Fri Nov  8 10:27:12 2019 - [info]  ok.
	Fri Nov  8 10:27:12 2019 - [info] Alive Servers:
	Fri Nov  8 10:27:12 2019 - [info]   192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 10:27:12 2019 - [info]   192.168.0.103(192.168.0.103:3306)
	Fri Nov  8 10:27:12 2019 - [info] Alive Slaves:
	Fri Nov  8 10:27:12 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 10:27:12 2019 - [info]     GTID ON
	Fri Nov  8 10:27:12 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 10:27:12 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:27:12 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 10:27:12 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 10:27:12 2019 - [info]     GTID ON
	Fri Nov  8 10:27:12 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 10:27:12 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:27:12 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Master 192.168.0.101(192.168.0.101:3306) is dead. Proceed? (yes/NO): yes
	Fri Nov  8 10:27:13 2019 - [info] Starting GTID based failover.
	Fri Nov  8 10:27:13 2019 - [info] 
	Fri Nov  8 10:27:13 2019 - [info] ** Phase 1: Configuration Check Phase completed.
	Fri Nov  8 10:27:13 2019 - [info] 
	Fri Nov  8 10:27:13 2019 - [info] * Phase 2: Dead Master Shutdown Phase..
	Fri Nov  8 10:27:13 2019 - [info] 
	Fri Nov  8 10:27:13 2019 - [debug] SSH connection test to 192.168.0.101, option -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o BatchMode=yes -o ConnectTimeout=5, timeout 5
	Fri Nov  8 10:27:13 2019 - [debug]  Stopping IO thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:27:13 2019 - [debug]  Stopping IO thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 10:27:13 2019 - [debug]  Stop IO thread on 192.168.0.103(192.168.0.103:3306) done.
	Fri Nov  8 10:27:13 2019 - [debug]  Stop IO thread on 192.168.0.102(192.168.0.102:3306) done.
	Fri Nov  8 10:27:14 2019 - [info] HealthCheck: SSH to 192.168.0.101 is reachable.
	Fri Nov  8 10:27:14 2019 - [info] Forcing shutdown so that applications never connect to the current master..
	Fri Nov  8 10:27:14 2019 - [info] Executing master IP deactivation script:
	Fri Nov  8 10:27:14 2019 - [info]   /etc/masterha/master_ip_failover --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --command=stopssh --ssh_user=root  
	Fri Nov  8 10:27:14 2019 - [info]  done.
	Fri Nov  8 10:27:14 2019 - [warning] shutdown_script is not set. Skipping explicit shutting down of the dead master.
	Fri Nov  8 10:27:14 2019 - [info] * Phase 2: Dead Master Shutdown Phase completed.
	Fri Nov  8 10:27:14 2019 - [info] 
	Fri Nov  8 10:27:14 2019 - [info] * Phase 3: Master Recovery Phase..
	Fri Nov  8 10:27:14 2019 - [info] 
	Fri Nov  8 10:27:14 2019 - [info] * Phase 3.1: Getting Latest Slaves Phase..
	Fri Nov  8 10:27:14 2019 - [info] 
	Fri Nov  8 10:27:14 2019 - [debug] Fetching current slave status..
	Fri Nov  8 10:27:14 2019 - [debug]  Fetching current slave status done.
	Fri Nov  8 10:27:14 2019 - [info] The latest binary log file/position on all slaves is mysql-bin.000015:1412
	Fri Nov  8 10:27:14 2019 - [info] Retrieved Gtid Set: 1b9bc372-0042-11ea-b8fa-0800274617cc:20-22
	Fri Nov  8 10:27:14 2019 - [info] Latest slaves (Slaves that received relay log files to the latest):
	Fri Nov  8 10:27:14 2019 - [info]   192.168.0.103(192.168.0.103:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 10:27:14 2019 - [info]     GTID ON
	Fri Nov  8 10:27:14 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 10:27:14 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:27:14 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 10:27:14 2019 - [info] The oldest binary log file/position on all slaves is mysql-bin.000015:1159
	Fri Nov  8 10:27:14 2019 - [info] Retrieved Gtid Set: 1b9bc372-0042-11ea-b8fa-0800274617cc:20-21
	Fri Nov  8 10:27:14 2019 - [info] Oldest slaves:
	Fri Nov  8 10:27:14 2019 - [info]   192.168.0.102(192.168.0.102:3306)  Version=8.0.18 (oldest major version between slaves) log-bin:enabled
	Fri Nov  8 10:27:14 2019 - [info]     GTID ON
	Fri Nov  8 10:27:14 2019 - [debug]    Relay log info repository: TABLE
	Fri Nov  8 10:27:14 2019 - [info]     Replicating from 192.168.0.101(192.168.0.101:3306)
	Fri Nov  8 10:27:14 2019 - [info]     Primary candidate for the new Master (candidate_master is set)
	Fri Nov  8 10:27:14 2019 - [info] 
	Fri Nov  8 10:27:14 2019 - [info] * Phase 3.3: Determining New Master Phase..
	Fri Nov  8 10:27:14 2019 - [info] 
	Fri Nov  8 10:27:14 2019 - [info] 192.168.0.102 can be new master.
	Fri Nov  8 10:27:14 2019 - [info] New master is 192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 10:27:14 2019 - [info] Starting master failover..
	Fri Nov  8 10:27:14 2019 - [info] 
	From:
	192.168.0.101(192.168.0.101:3306) (current master)
	 +--192.168.0.102(192.168.0.102:3306)
	 +--192.168.0.103(192.168.0.103:3306)

	To:
	192.168.0.102(192.168.0.102:3306) (new master)
	 +--192.168.0.103(192.168.0.103:3306)

	Starting master switch from 192.168.0.101(192.168.0.101:3306) to 192.168.0.102(192.168.0.102:3306)? (yes/NO): yes
	Fri Nov  8 10:27:16 2019 - [info] New master decided manually is 192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 10:27:16 2019 - [info] 
	Fri Nov  8 10:27:16 2019 - [info] * Phase 3.3: New Master Recovery Phase..
	Fri Nov  8 10:27:16 2019 - [info] 
	Fri Nov  8 10:27:16 2019 - [info]  Waiting all logs to be applied.. 
	Fri Nov  8 10:27:16 2019 - [info]   done.
	Fri Nov  8 10:27:16 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:27:16 2019 - [debug]   done.
	Fri Nov  8 10:27:16 2019 - [info]  Replicating from the latest slave 192.168.0.103(192.168.0.103:3306) and waiting to apply..
	Fri Nov  8 10:27:16 2019 - [info]  Waiting all logs to be applied on the latest slave.. 
	Fri Nov  8 10:27:16 2019 - [info]  Resetting slave 192.168.0.102(192.168.0.102:3306) and starting replication from the new master 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 10:27:16 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:27:16 2019 - [debug]   done.
	Fri Nov  8 10:27:16 2019 - [info]  Executed CHANGE MASTER.
	Fri Nov  8 10:27:16 2019 - [debug]  Starting slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:27:16 2019 - [debug]   done.
	Fri Nov  8 10:27:16 2019 - [info]  Slave started.
	Fri Nov  8 10:27:16 2019 - [info]  Waiting to execute all relay logs on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:27:16 2019 - [info]  master_pos_wait(mysql-bin.000011:913) completed on 192.168.0.102(192.168.0.102:3306). Executed 2 events.
	Fri Nov  8 10:27:16 2019 - [info]   done.
	Fri Nov  8 10:27:16 2019 - [debug]  Stopping SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:27:16 2019 - [debug]   done.
	Fri Nov  8 10:27:16 2019 - [info]   done.
	Fri Nov  8 10:27:16 2019 - [info] Getting new master s binlog name and position..
	Fri Nov  8 10:27:16 2019 - [info]  mysql-bin.000010:3512
	Fri Nov  8 10:27:16 2019 - [info]  All other slaves should start replication from here. Statement should be: CHANGE MASTER TO MASTER_HOST='192.168.0.102', MASTER_PORT=3306, MASTER_AUTO_POSITION=1, MASTER_USER='mharpl', MASTER_PASSWORD='xxx';
	Fri Nov  8 10:27:16 2019 - [info] Master Recovery succeeded. File:Pos:Exec_Gtid_Set: mysql-bin.000010, 3512, 1b9bc372-0042-11ea-b8fa-0800274617cc:1-22,
	cbe6921b-0043-11ea-b484-0800270d5e94:1-6
	Fri Nov  8 10:27:16 2019 - [info] Executing master IP activate script:
	Fri Nov  8 10:27:16 2019 - [info]   /etc/masterha/master_ip_failover --command=start --ssh_user=root --orig_master_host=192.168.0.101 --orig_master_ip=192.168.0.101 --orig_master_port=3306 --new_master_host=192.168.0.102 --new_master_ip=192.168.0.102 --new_master_port=3306 --new_master_user='root'   --new_master_password=xxx
	Set read_only=0 on the new master.
	Fri Nov  8 10:27:16 2019 - [info]  OK.
	Fri Nov  8 10:27:16 2019 - [info] ** Finished master recovery successfully.
	Fri Nov  8 10:27:16 2019 - [info] * Phase 3: Master Recovery Phase completed.
	Fri Nov  8 10:27:16 2019 - [info] 
	Fri Nov  8 10:27:16 2019 - [info] * Phase 4: Slaves Recovery Phase..
	Fri Nov  8 10:27:16 2019 - [info] 
	Fri Nov  8 10:27:16 2019 - [info] 
	Fri Nov  8 10:27:16 2019 - [info] * Phase 4.1: Starting Slaves in parallel..
	Fri Nov  8 10:27:16 2019 - [info] 
	Fri Nov  8 10:27:16 2019 - [info] -- Slave recovery on host 192.168.0.103(192.168.0.103:3306) started, pid: 20939. Check tmp log /var/log/masterha/app1/192.168.0.103_3306_20191108102711.log if it takes time..
	Fri Nov  8 10:27:17 2019 - [info] 
	Fri Nov  8 10:27:17 2019 - [info] Log messages from 192.168.0.103 ...
	Fri Nov  8 10:27:17 2019 - [info] 
	Fri Nov  8 10:27:16 2019 - [info]  Resetting slave 192.168.0.103(192.168.0.103:3306) and starting replication from the new master 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:27:16 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 10:27:16 2019 - [debug]   done.
	Fri Nov  8 10:27:16 2019 - [info]  Executed CHANGE MASTER.
	Fri Nov  8 10:27:16 2019 - [debug]  Starting slave IO/SQL thread on 192.168.0.103(192.168.0.103:3306)..
	Fri Nov  8 10:27:16 2019 - [debug]   done.
	Fri Nov  8 10:27:16 2019 - [info]  Slave started.
	Fri Nov  8 10:27:16 2019 - [info]  gtid_wait(1b9bc372-0042-11ea-b8fa-0800274617cc:1-22,
	cbe6921b-0043-11ea-b484-0800270d5e94:1-6) completed on 192.168.0.103(192.168.0.103:3306). Executed 0 events.
	Fri Nov  8 10:27:17 2019 - [info] End of log messages from 192.168.0.103.
	Fri Nov  8 10:27:17 2019 - [info] -- Slave on host 192.168.0.103(192.168.0.103:3306) started.
	Fri Nov  8 10:27:17 2019 - [info] All new slave servers recovered successfully.
	Fri Nov  8 10:27:17 2019 - [info] 
	Fri Nov  8 10:27:17 2019 - [info] * Phase 5: New master cleanup phase..
	Fri Nov  8 10:27:17 2019 - [info] 
	Fri Nov  8 10:27:17 2019 - [info] Resetting slave info on the new master..
	Fri Nov  8 10:27:17 2019 - [debug]  Clearing slave info..
	Fri Nov  8 10:27:17 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..
	Fri Nov  8 10:27:17 2019 - [debug]   done.
	Fri Nov  8 10:27:17 2019 - [debug]  SHOW SLAVE STATUS shows new master does not replicate from anywhere. OK.
	Fri Nov  8 10:27:17 2019 - [info]  192.168.0.102: Resetting slave info succeeded.
	Fri Nov  8 10:27:17 2019 - [info] Master failover to 192.168.0.102(192.168.0.102:3306) completed successfully.
	Fri Nov  8 10:27:17 2019 - [debug]  Disconnected from 192.168.0.102(192.168.0.102:3306)
	Fri Nov  8 10:27:17 2019 - [debug]  Disconnected from 192.168.0.103(192.168.0.103:3306)
	Fri Nov  8 10:27:17 2019 - [info] 

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
		
	
	
	
5. 查看数据
	mha02:
		root@mysqldb 10:24:  [(none)]> select * from test.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		+------+
		2 rows in set (0.00 sec)

	mha03:

		root@mysqldb 10:29:  [(none)]> select * from test.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		+------+
		2 rows in set (0.00 sec)
	
	mha01: 	
		root@mysqldb 10:30:  [(none)]> select * from test.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		+------+
		3 rows in set (0.03 sec)
	
	数据没有补全.
		
	
6. 宕机的mha01恢复

	stop slave;
	CHANGE MASTER TO MASTER_HOST='192.168.0.101', MASTER_PORT=3306, MASTER_AUTO_POSITION=1, MASTER_USER='mharpl', MASTER_PASSWORD='123456abc';
	start slave;
	show slave status\G;
	
