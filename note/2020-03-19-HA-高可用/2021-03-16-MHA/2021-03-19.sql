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
	
我的问题：
	把 mha02提升为库, 由于 mha03 是最新的 slave，这时候 mha02 是怎么进行日志补偿的？
	
	