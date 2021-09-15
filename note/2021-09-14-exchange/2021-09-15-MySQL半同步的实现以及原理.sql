

	
6. 小结
	after commit(半同步复制)
		5.6 版本开始支持
		在存储引擎层提交之后才把 binlog发送给从库, 从库确认接收到之后, 返回一个 ack 应答给主库, 这时候主库的事务执行完成.
		
	after sync(增强半同步复制)
		5.7 版本开始支持
		在写入binlog之后, 存储引擎层提交之前把binlog发送给从库, 从库把 binlog 写入到 relay log后, 再返回一个 ack 应答给主库, 这时候主库的事务执行完成.
		-- 主库事务响应变慢。
		
	dump thread过程分析:

		mysql5.6版本之前：
			1. master dump thread 发送binlog events 给 slave 的IO thread，等待 slave 的ack反馈
			2. slave 接受binlog events 写入relay log ，返回 ack 消息给master dump thread
			3. master dump thread 收到ack消息，给session返回commit ok，然后继续发送写一个事务的binlog。

		mysql5.7之后新增ack线程：
			1. master dump thread 发送binlog events 给 slave 的IO thread，开启ack线程等待 slave 的ack反馈，dump 线程继续向slaveIO thread发送下一个事务的binlog。
			2. slave 接受binlog events 写入relay log ，返回 ack 消息给master ack线程，然后给session返回commit ok。



