

1. 异步复制 半同步复制 无损复制
	1.1 异步复制
	1.2 半同步复制（semi-sync replication） 		
	1.3 无损复制 lossless replication
2. 性能提升
3. 管理接口
4. 配置无损复制
5. 相关参考
6. 小结

1. 异步复制 半同步复制 无损复制

	1.1 异步复制
		1. 主库写二进制日志
		2. 从库的I/O线程读主库的二进制日志写入到本地的中转日志(relay log)
		3. 从库的SQL线程重放中转日志
		4. 1-3这三步操作都是异步进行的
			
		异步复制的缺点：
			1. 导致系统数据丢失：
				如果主库掉电，有些 binlog还来不及发给从库，会导致系统数据丢失，如果此时强行主从切换，可能导致新主库上的数据不完整。
			2. 不能保证主从数据实时一致，也无法控制从库的延迟时间，因此不适用于要求主从数据实时同步的场景
				例如：为了分解读写压力，同一程序写主库读从库，但要求读到的数据与读主库相同，异步复制不能满足这种强数据一致性需求
		
	1.2 半同步复制（semi-sync replication） 	
		
		为了解决异步复制的缺点，在5.6版本引入了半同步复制（semi-sync replication）
		semi-sync的设计：
			1. 事务提交的时候，主库把 binlog发送给从库；
			2. 从库收到 binlog 以后，发回给主库一个 ack，表示收到了；
			3. 主库收到这个 ack 以后，才能给客户端返回 “事务完成” 的确认。
		即如果启用了 semi-sync, 就表示 所有给客户端发送过确认的事务，都确保了备库已经收到了这个日志
		
		semi-sync的缺陷：
		
			1. 在事务提交以后才发送给备库，再返回客户端的流程，所以还是存在数据丢失的风险
				# 事务提交，把 binlog 发送给从库期间发送失败，导致存在数据丢失
			
				binlog 未发送到从库:
					事务B获取到事务A提交的内容， 此时宕机故障切换到slave，事务B获取到的内容却丢失了。
					
			2. 因为需要等从库，所以提交事务会变慢，事务执行完成可能会有延迟，延迟至少是将提交发送到从库并等待从库确认收到的TCP/IP往返时间。
				这意味着半同步复制最好在低延时的网络中使用。
				
			3. 当主库收不到从库的变更通知超时时(由系统变量 rpl_semi_sync_master_timeout 控制)，由半同步复制自动切换到异步同步，这样就极大了保证了数据的一致性（至少一个从库）
				但是在性能上有所下降，特别是在网络不稳定的情况下，半同步和同步之间来回切换，对正常的业务是有影响的。

	1.3 无损复制 lossless replication
			
	　　直到MySQL官方5.7版本推出无损复制lossless replication
		
		lossless的设计：
			1. 客户端发出 commit请求后，在主库上写入binlog并发送给从库
			2. 从库接收到 binlog并写入 relay log， 发回给主库一个 ack, 表示收到了；
			3. 主库收到这个 ack之后，提交事务，给客户端返回 “事务完成” 的确认。
			
			这时的同步复制是在事务提交之前就把数据发送给从机，能够确保数据的完全一致
		
		故障分析：
			假设主库在接收ack时宕机， 因为事务没有提交， HA切换到从库后，因为binlog已经写入到从库relay log, 因此不会造成数据丢失。
			
		缺陷：
			1. 这种同步复制在写密集型的场景下依旧存在问题，主要表现在从库没办法跟上主库进行复制，导致主库长期处于异步复制状态，从而导致切换的时候丢失数据。	
				解决方案：
					不让 同步复制退化为异步复制就行，但是会导致事务不能提交。
					
			2. 同样需要等从库，当主库提交事务时，所有从库也将在主库返回执行事务的会话之前提交事务。
				这样做的缺点是完成事务可能会有很大延迟。
		
	
2. 性能提升
	1. 支持发送二进制日志事件和接收ACK的异步化
	    旧版本的半同步复制受限于Binlog Dump线程，原因是该线程承担了两份不同且又十分频繁的任务：
			1. 传送二进制日志事件给从库 ；
			2. 接收从库的ACK反馈信息。
		这两个任务是串行的，Binlog Dump线程必须等待从库返回之后才会传送下一个事件。
		Binlog Dump线程已然成为整个半同步复制性能的瓶颈。在高并发业务场景下，这样的机制会影响数据库整体的TPS
		
		为了解决上述问题，在5.7.4版本的半同步复制框架中，独立出一个Ack Receiver线程 ，专门用于接收从库返回的ACK请求，
		这将之前Binlog Dump线程的发送和接收工作分为了两个线程来处理。
		这样主库上有两个线程独立工作，可以同时发送二进制日志事件到从库，和接收从库的ACK信息。因此半同步复制得到了极大的性能提升。

	2. 控制主库接收确认反馈从库的数量
        MySQL 5.7新增了 rpl_semi_sync_master_wait_for_slave_count 系统变量，可以用来控制主库接收多少个从库写事务成功反馈，给高可用架构切换提供了灵活性。
		如图3所示，当该变量值为2时，主库需等待两个从库的ACK。
		

3. 管理接口
    这里所说的半同步复制管理接口包含相关插件和变量。
	（1）两个插件，主库端的 semisync_master.so 和从库端的 semisync_slave.so ，实现半同步复制功能。
	（2）系统变量控制插件行为，例如：
		
		rpl_semi_sync_master_enabled 
			控制是否在主库上启用半同步复制。要启用或禁用插件，将此变量分别设置为1或0，默认值为0（关闭）。
		rpl_semi_sync_master_timeout
			一个以毫秒为单位的值，用于控制主库在超时并退化到异步复制之前等待来自从库确认提交的时间。默认值为10000（10秒）。
		rpl_semi_sync_slave_enabled
			与 rpl_semi_sync_master_enabled 类似，控制启用从库的插件。
			
	（3）状态变量用来反映半同步复制的状态信息，例如：

		Rpl_semi_sync_master_clients ：半同步从库的数量。
		Rpl_semi_sync_master_status ：
			半同步复制当前是否在主库上运行。如果已启用插件且未发生提交确认，则该值为ON。如果未启用插件，或者由于提交确认超时，主服务器已回退到异步复制，则为OFF。
		Rpl_semi_sync_master_no_tx ：表示异步复制的事务数，该值如果变化了，那么也需要检查半同步复制是否已经退化为异步复制，在退化时从error log也可以看到
		Rpl_semi_sync_master_yes_tx ： Semi-sync模式下，从库成功确认的事务数
		Rpl_semi_sync_slave_status ：半同步复制当前是否在从库上运行。如果插件已启用且从库的I/O线程正在运行，则此值为ON，否则为OFF。
		
        仅当使用INSTALL PLUGIN安装了相应的插件时，系统和状态变量才可用。

4. 配置无损复制
	# 参考 <2019-10-31-无损复制的搭建-测试-维护.sql>	
	

5. 相关参考
	https://blog.csdn.net/wzy0623/article/details/90267132  MySQL 8 复制（二）——半同步复制
	https://www.jianshu.com/p/3bfb0bfb8b34                 【MySQL】5.7增强半同步AFTER SYNC&AFTER COMMIT 
	
	https://www.jianshu.com/p/59c6ecb46fe5    MySQL 5.7中sync_binlog参数和半同步中after_commit和after_sync的区别
	
	https://mp.weixin.qq.com/s/t-LSbDeGvVX_OIFHy4YDRA   半同步复制after_sync模式下的一则客户端断开问题分析
	
	http://mysql.taobao.org/monthly/2017/04/01/         MySQL · 源码分析 · MySQL 半同步复制数据一致性分析
	
	
	
6. 小结
	after commit(半同步复制)
		5.5 版本开始支持
		在存储引擎层提交之后才把 binlog发送给从库, 从库确认接收到之后, 返回一个 ack 给主库, 这时候主库的事务执行完成.
		
	after sync(增强半同步复制)
		5.7 版本开始支持
		在写入binlog之后,存储引擎层提交之前把binlog发送给从库, 从库把 binlog 写入到 relay log后, 再返回一个 ack 应答给主库, 这时候主库的事务执行完成.
		
	dump thread过程分析:

		mysql5.6版本之前：
			1. master dump thread 发送binlog events 给 slave 的IO thread，等待 slave 的ack反馈
			2. slave 接受binlog events 写入relay log ，返回 ack 消息给master dump thread
			3. master dump thread 收到ack消息，给session返回commit ok，然后继续发送写一个事务的binlog。

		mysql5.7之后新增ack线程：
			1. master dump thread 发送binlog events 给 slave 的IO thread，开启ack线程等待 slave 的ack反馈，dump 线程继续向slaveIO thread发送下一个事务的binlog。
			2. slave 接受binlog events 写入relay log ，返回 ack 消息给master ack线程，然后给session返回commit ok。

