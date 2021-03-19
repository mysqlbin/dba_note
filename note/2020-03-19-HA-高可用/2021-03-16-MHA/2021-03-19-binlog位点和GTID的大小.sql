


环境 
	hostname    主机          端口号  通信端口号(server-id)    server_uuid                              MySQL版本      role      mha-node
	mha01		192.168.0.101  3306   3306101				   1b9bc372-0042-11ea-b8fa-0800274617cc     MySQL 8.0.18   Master 
	mha02       192.168.0.102  3306   3306102                  e588e3eb-0042-11ea-a95b-0800275dde84     MySQL 8.0.18   Slave      new Master
	mha03       192.168.0.103  3306   3306103                  cbe6921b-0043-11ea-b484-0800270d5e94     MySQL 8.0.18   Slave      Mha manager & slave 
	VIP         192.168.0.104


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
		
	很明显从节点mha02落后于从节点mha03、从节点mha03落后于主节点mha01
	把 mha02提升为库, 由于 mha03 是最新的 slave, 新Master需要补全跟最新slave的差异 	
	此时主库有未发送到从库的binlog
	
	
mha01的位点和GTID
	

mha02的位点和GTID
	Fri Nov  8 10:52:25 2019 - [info] The oldest binary log file/position on all slaves is mysql-bin.000016:649
	Fri Nov  8 10:52:25 2019 - [info] Retrieved Gtid Set: 1b9bc372-0042-11ea-b8fa-0800274617cc:23-25
	
	mysql-bin.000016:649
	1b9bc372-0042-11ea-b8fa-0800274617cc:23-25
	
	
mha03的位点和GTID

	Fri Nov  8 10:52:25 2019 - [info] The latest binary log file/position on all slaves is mysql-bin.000016:902
	Fri Nov  8 10:52:25 2019 - [info] Retrieved Gtid Set: 1b9bc372-0042-11ea-b8fa-0800274617cc:23-26
	
	mysql-bin.000016:902
	1b9bc372-0042-11ea-b8fa-0800274617cc:23-26
	
-------------------------------------------------------------------------------------------------------------------	
	
mha02	
	192.168.0.102成为192.168.0.103的从库，用于补偿缺省的日志 
	Fri Nov  8 10:52:27 2019 - [info]  Waiting all logs to be applied on the latest slave.. 
	Fri Nov  8 10:52:27 2019 - [info]  Resetting slave 192.168.0.102(192.168.0.102:3306) and starting replication from the new master 192.168.0.103(192.168.0.103:3306)..
	
	
mha01的位点	

	mysql-bin.000016
	start-position=902
	
	
	从故障的master保存binlog到新主的目录下
	Fri Nov  8 10:52:27 2019 - [info] Fetching binary logs from binlog server 192.168.0.101..
	Fri Nov  8 10:52:27 2019 - [info] Executing binlog save command: save_binary_logs --command=save --start_file=mysql-bin.000016  --start_pos=902 --output_file=/var/log/masterha/app1/saved_binlog_binlog1_20191108105222.binlog --handle_raw_binlog=0 --skip_filter=1 --disable_log_bin=0 --manager_version=0.58 --oldest_version=8.0.18  --debug  --binlog_dir=/data/mysql/mysql3306/data 
	  Creating /var/log/masterha/app1 if not exists..    ok.
	 Concat binary/relay logs from mysql-bin.000016 pos 902 to mysql-bin.000016 EOF into /var/log/masterha/app1/saved_binlog_binlog1_20191108105222.binlog ..
	Executing command: mysqlbinlog --start-position=902  /data/mysql/mysql3306/data/mysql-bin.000016 >> /var/log/masterha/app1/saved_binlog_binlog1_20191108105222.binlog
	
	
mha02

	Fri Nov  8 10:52:28 2019 - [info] Applying differential binlog /var/log/masterha/app1/saved_binlog_192.168.0.101_binlog1_20191108105222.binlog ..
	Fri Nov  8 10:52:28 2019 - [info] Differential log apply from binlog server succeeded.
	
	Fri Nov  8 10:52:28 2019 - [info] Getting new master s binlog name and position..
	Fri Nov  8 10:52:28 2019 - [info]  mysql-bin.000011:1428		
							
	mysql-bin.000011:1428

	File:Pos:Exec_Gtid_Set: mysql-bin.000011, 1428, 1b9bc372-0042-11ea-b8fa-0800274617cc:1-27,
	cbe6921b-0043-11ea-b484-0800270d5e94:1-6
	
	
mha03

	Fri Nov  8 10:52:29 2019 - [info]  gtid_wait(1b9bc372-0042-11ea-b8fa-0800274617cc:1-27,
	cbe6921b-0043-11ea-b484-0800270d5e94:1-6) completed on 192.168.0.103(192.168.0.103:3306). Executed 0 events.
	
	
