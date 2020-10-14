

1. 先介绍主从复制三个线程的作用
2. 主从复制原理
3. 一个事务日志主备同步的完整过程       
4. 3个线程处于空闲的状态  
5. 主从复制原理的3个关键字

1. 先介绍主从复制三个线程的作用

	Dump_thread: 
	
		对于每一个从库在主库都对应了一个 dump 线程，主要功能就是读取event和发送event给从库的 IO 线程
		一主2从的架构：
			mysql> select id,user,command,time,state from information_schema.`PROCESSLIST`;
			+-------+-----------------+------------------+---------+---------------------------------------------------------------+
			| id    | user            | command          | time    | state                                                         |
			+-------+-----------------+------------------+---------+---------------------------------------------------------------+
			|    31 | event_scheduler | Daemon           |      38 | Waiting for next activation                                   |
			| 49631 | repl_user       | Binlog Dump GTID | 2373324 | Master has sent all binlog to slave; waiting for more updates |
			|    27 | repl_user       | Binlog Dump GTID | 5236064 | Master has sent all binlog to slave; waiting for more updates |
			
		参考笔记：《17-主库的dump线程.sql》
		
	IO_Thread: 
		1. 实时连接-负责与主库建立连接
		2. 初始化情况下将需要读取的信息发送给主库
		3. 接收来自 dump线程的 event 
		4. 将接收到的 event 写入 relay log	
		参考笔记：《22-从库的IO线程.sql》
		
	SQL_thread：
		1. 读取 relay log 中的 event 
		2. 应用这些读取到的 event, 将修改作用于从库
		3. 如果是 MTS (并行复制) 通过情况下不会应用 event, SQL线程会蜕变为协调线程, 分发 event 给工作线程.
	
		即 读取中转日志，解析出日志里的命令，并执行。
	
		SQL 线程是单线程，意味着每次只能应用一个event, 这也是高并发下从库延迟的重要因素。
		主库并发高、TPS高，就会导致备库消费中转日志（relay log）的速度，比主库生产 binlog 的速度要慢， 从而出现严重的主备延迟问题。
		参考笔记：《23-从库的SQL线程.sql》
		解决这种延迟的方式：
			1. 从库不需要开启log_slave_updates参数
			2. innodb_flush_log_at_trx_commit 设置为2
			3. 启用并行复制 
		
			参数						配置
			master_info_repository		table
			relay_log_info_repository	table
			recovery_relay_log			on
			sync_master_info			默认，10000
			sync_relay_log				默认，10000
			sync_relay_log_info			默认，10000
			
			
		
2. 主从复制原理
	
	1、主库上有数据改变然后写入 binlog event, dump 线程 读取 event 和 发送 event 给从库的 IO 线程（master会为每个slave创建一个dump线程，在主库执行 show processlist；就可以看到）
	2、 从库通过 I/O thread 接收来自 dump 线程的 event  并把 event 写入 relay log 
		这个步骤的确认： 参考笔记  《2020-03-12-验证GTID的全局唯一身份》
	3、 从库通过 SQL thread 读取 relay log 中的 event, 解析出日志里面的命令, 并执行.
	
	# 这个描述可以.

		
3. 一个事务日志主备同步的完整过程       
	1. 备库 B 跟主库 A 之间维持了一个长连接， 主库 A 内部有一个线程(dump 线程)，专门用于服务备库 B 的这个长连接。
	2. 在备库 B 上通过 change master 命令：
		 设置主库 A 的 IP、端口、用户名、密码
		从哪个文件名和日志偏移量开始请求 binlog。
	3. 在备库 B 上执行 start slave 命令，备库会启动两个线程：
		  1. io_thread: io_thread 负责与主库建立连接; 
		  2. sql_thread: 读取中转日志，解析出日志里的命令，并执行。
	4. 主库 A 校验完用户名、密码后，开始按照备库 B 传过来的位置，从本地读取 binlog，发给备库 B。
	5. 备库 B 拿到 binlog 后，写到本地文件，称为中转日志/relay log。
	6. sql_thread 读取中转日志，解析出日志里的命令，并执行。
	
	来源： 24: MySQL主从原理和binlog的3种格式
  
4. 3个线程处于空闲的状态  
	master：
		mysql> show processlist;
		+----+------+--------------------+------+------------------+-------+---------------------------------------------------------------+------------------+
		| Id | User | Host               | db   | Command          | Time  | State                                                         | Info             |
		+----+------+--------------------+------+------------------+-------+---------------------------------------------------------------+------------------+
		| 52 | repl | 192.168.1.29:45726 | NULL | Binlog Dump GTID | 39628 | Master has sent all binlog to slave; waiting for more updates | NULL             |
		| 62 | root | localhost          | NULL | Query            |     0 | starting                                                      | show processlist |
		+----+------+--------------------+------+------------------+-------+---------------------------------------------------------------+------------------+
		2 rows in set (0.00 sec)
		
	slave:
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates		
		
		
		mysql> show processlist;
		+----+-------------+-----------+------+---------+-------+--------------------------------------------------------+------------------+
		| Id | User        | Host      | db   | Command | Time  | State                                                  | Info             |
		+----+-------------+-----------+------+---------+-------+--------------------------------------------------------+------------------+
		| 11 | system user |           | NULL | Connect | 39713 | Waiting for master to send event                       | NULL             |
		| 12 | system user |           | NULL | Connect | 39712 | Slave has read all relay log; waiting for more updates | NULL             |
		| 13 | root        | localhost | NULL | Query   |     0 | starting                                               | show processlist |
		+----+-------------+-----------+------+---------+-------+--------------------------------------------------------+------------------+
		3 rows in set (0.00 sec)		  
		
		
5. 主从复制原理的3个关键字
	读取、发送
	接收、写入
	读取、应用
	
		