

1. 是什么
	控制写入操作返回客户端的回执行为。
	支持客户灵活配置写入策略(writeConcern)，以满足不同场景的需求。
	db.collection.insert({x: 1}, {writeConcern: {w: 1}})

2. writeConcern选项
MongoDB支持的WriteConncern选项如下
	1. w: 数据写入到number个节点才向用客户端确认
		{w: 0} 对客户端的写入不需要发送任何确认，适用于性能要求高，但不关注正确性的场景
		{w: 1} 默认的writeConcern，数据写入到Primary就向客户端发送确认
			如果出现系统崩溃也会导致数据丢失，那就是在日志信息还没有刷新到磁盘的那一刻发生系统宕机，此时内存日志的确是写入成功了于是mongodb就会返回确定信息。
			
		{w: “majority”} 数据写入到副本集大多数成员后向客户端发送确认，适用于对数据安全性要求比较高的场景，该选项会降低写入性能

	2. j: 写入操作的journal持久化后才向客户端确认
		默认为”{j: false}，如果要求Primary写入持久化了才向客户端确认，则指定该选项为true
	
	3. wtimeout: 写入超时时间，仅w的值大于1时有效。
		当指定{w: }时，数据需要成功写入number个节点才算成功，如果写入过程中有节点故障，可能导致这个条件一直不能满足，从而一直不能向客户端发送确认结果
		针对这种情况，客户端可设置wtimeout选项来指定超时时间，当写入过程持续超过该时间仍未结束，则认为写入失败。
		
		

相关参考
	https://www.cnblogs.com/AK47Sonic/p/7560177.html  MongoDB 学习笔记之 WriteConcern
	https://mongoing.com/archives/2916 MongoDB writeConcern原理解析