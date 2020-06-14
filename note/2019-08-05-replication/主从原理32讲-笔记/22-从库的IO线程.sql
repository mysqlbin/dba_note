
1. 从库IO线程有三个主要的功能
2. 从库IO线程的流程解析
	2.1 使用 slave_master_info 表中的用户名 密码 IP 端口号信息进行连接
	2.2 通过语句(发起普通的命令)获取主库的重要信息
	2.3 注册从库信息
	2.4 发送需要读取的 gtid set 或者 position 信息给主库
	2.5 通过网络层读取 event 
	2.6 把接收到的 event 写入到 relay log
	2.7 持久化信息
3. 小结
	

1. 从库IO线程有三个主要的功能
	1. 初始化情况下将需要读取的信息发送给主库
	2. 接收来自 dump 线程的 event 
	3. 将接收到的 event 写入 relay log
	
	负责与主库建立连接; 

2. 从库IO线程的流程解析
	2.1 使用 slave_master_info 表中的用户名 密码 IP 端口号信息进行连接
		如果主库不能连接, 则会不断的重连, 重连间隔时间和次数为我们的配置如下:
			master_connect_retry : 每次重连间隔时间, 默认为 60 秒
			master_retry_count   : 重连的次数, 默认为 86400 次
			
		在错误日志中也会出现类似如下的错误:
			141010 0:02:48 [ERROR] Slave I/O: error connecting to master 'my@172.17.210.199:3306' - retry-time: 60 retries: 1, Error_code: 2003
			141010 0:03:48 [ERROR] Slave I/O: error connecting to master 'my@172.17.210.199:3306' - retry-time: 60 retries: 2, Error_code: 2003
			141010 0:04:48 [ERROR] Slave I/O: error connecting to master 'my@172.17.210.199:3306' - retry-time: 60 retries: 3, Error_code: 2003
			141010 0:05:48 [ERROR] Slave I/O: error connecting to master 'my@172.17.210.199:3306' - retry-time: 60 retries: 4, Error_code: 2003
			141010 0:06:48 [ERROR] Slave I/O: error connecting to master 'my@172.17.210.199:3306' - retry-time: 60 retries: 5, Error_code: 2003
			141010 0:07:48 [ERROR] Slave I/O: error connecting to master 'my@172.17.210.199:3306' - retry-time: 60 retries: 6, Error_code: 2003
					
			导致lave_IO_Running 为connecting
				mysql> SHOW slave STATUS \\G
				*************************** 1. row ***************************
					   Slave_IO_State: Connecting to master
						  Master_Host: 172.17.210.199
						  Master_User: my
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: masters-bin.000003
				  Read_Master_Log_Pos: 1224
					   Relay_Log_File: testmysql-relay-bin.000001
						Relay_Log_Pos: 4
				Relay_Master_Log_File: masters-bin.000003
					 Slave_IO_Running: Connecting
					 
		出现错误我们就应该去检查我们的连接信息是否正确.
	

	2.2 通过语句(发起普通的命令)获取主库的重要信息
		这一步实际上就是需要和主库进行相应的交互了, 方式就是发起普通的命令进行查询
		下面列出一些重要的步骤
			1. 发起命令 select unix_timestamp() 获取主库时间
				这一步比较关键, 获取了主库时间会用于计算主库和从库的时间差值, 这个差值是计算 seconds_behind_master 的关键因素
				
			2. 发起命令 select @@global.server_id 获取主库 server id 
				这一步用来比较主库和从库的 server id 是否相同, 如果相同则报错, 报错信息如下:
				
					The slave I/O thread stops because master and slave have equal MySQL server ids; these ids must be different for replication to work
					
			3. 发起命令 select @@global.gtid_mode 获取主库的 gtid 设置
				主要用于检查 gtid 设置是否和从库兼容
				如果主库生成的是 gtid 事务, 从库不能设置  gtid_mode = off
				如果主库生成的是 匿名 事务, 从库不能设置  gtid_mode = on
				如果使用的是 auto_position = 1 那么主库必须设置为 gtid_mode = on 
				
			4. 发起命令 select @@global.server_uuid 获取主库 server_uuid 
				这一步用来比较主库和从库的 server_uuid 是否相同, 如果相同则报错, 报错信息如下:
			
					The slave I/O thread stops because master and slave have equal MySQL server UUIDs; these UUIDs must be different for replication to work

	2.3 注册从库信息
	
		注册完成后通过命令 show slave hosts 就能查询到这个从库了.
		
	2.4 发送需要读取的 gtid set 或者 position 信息给主库
		
		这一步比较关键
		IO 线程会根据配置的不同发送不同的信息给主库的 dump 线程
			auto_position = 1
				发送从库的 gtid set 给主库, 这个 gtid set 是 retrieved_gtid_set 和 executed_gtid_set 的并集
				
			position
				基于位点的方式, 这种方式需要发送 slave_master_info 表中的 master_log_name 和 master_log_pos 信息给主库
				
	2.5 通过网络层读取 event 
		这一步会进入状态: Waiting for master to send event

			mysql> show slave status\G;
			*************************** 1. row ***************************
			Slave_IO_State: Waiting for master to send event


	2.6 把接收到的 event 写入到 relay log
		会进入状态: queueing master event to the relay log
		如果是 gtid event 还会检测是否合法, 主要包含如下一些错误的检测:
		
			1. Cannot replicate GTID-transaction when @@GLOBAL.GTID_MODE = OFF
				如果是GITD_MODE=OFF不能有GTID的event存在
				
				完整报错案例如下:
					Last_IO_Error: Got fatal error 1236 from master when reading data from binary log: Cannot replicate GTID-transaction when @@GLOBAL.GTID_MODE = OFF, at file /storage/single/mysql3306/logs/mysql-binlog.000035, position 194.
		
					相关参考:  https://www.enmotech.com/web/detail/1/789/1.html  MySQL手动注册binlog文件造成主从同步异常该如何解决？
					
					
			2. Cannot replicate anonymous transaction where auto_position = 1
				如果是auto_position=ON不能有匿名event的存在 如果有则报错
					
				相关参考: https://www.cnblogs.com/danhuangpai/p/10364848.html  mysql 案例 ~ mysql主从复制错误问题

					GTID模式下的特殊复制错误

						错误1 Got fatal error 1236 from master when reading data from binary log: Cannot replicate anonymous transaction when AUTO_POSITION = 1

						分析 匿名事务(anonymous transaction ) 的生成是无法生成全局GTID的

						执行命令 set gtid_model =  ON_PERMISSIVE,然后再执行事务

						通过分析主库binlog的位点也可以发现 set  @@session.GTID_NEXT='anonymous' 和之前的猜想相对应

						解决方式:  1 重新在从库执行匿名事务.然后重启slave线程即可 2 严格控制开发行为,不允许手动更改环境变量
		

				相关参考: http://blog.itpub.net/7728585/viewspace-2649957/   十七：主库的DUMP线程（笔记）

				
			3.  Cannot replicate anonymous transaction when @@GLOBAL.GTID_MODE = OFF
				如果是GITD_MODE=OFF不能有GTID的event存在
				相关参考: http://blog.itpub.net/7728585/viewspace-2649957/   十七：主库的DUMP线程（笔记


			以上情况实际上如果正常操作是不会出现的，因为每次设置GITD_MODE总是会切换一个binlog，
            但是如果修改GTID_MODE不按照前面提到的流程可能会出现这些错误。
			 
            对于第2种错误很容易重现，因为auto_postion是start slave初始化传入的。
            对于第1种和第3种错误因为EVENT的生成线程和DUMP线程不是同一个线程是异步通知的方式，也就是说生成GTID event到发送这段时间如果修改了GTID_MODE可能会出现这些问题。

	2.7 持久化信息
		每一个 event 写入到 relay log 后, 就需要考虑持久化这些信息.
		下面就是实现持久化信息的步骤
			1. 根据 sync_relay_log 的设置, 决定是否对 relay log 执行 fsync, 单位为 event
			2. 根据 sync_master_info 的设置, 决定是否更新 slave_master_info 表, 单位为 event 
			3. 如果是一个事务结束还需要更新 retrieved_gtid_set , 如果开启了 gtid 才会更新.
					
3. 小结
	学习了从库 IO 线程的主要作用
	学习了从库 IO 线程的流程解析
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	



	
		