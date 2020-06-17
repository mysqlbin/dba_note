
1. Oplog Size
2. 可能需要较大Oplog大小的工作负载
3. Oplog Status 
4. 复制延迟和流控制
5. 慢Oplog应用
6. Oplog集合行为


1. Oplog Size


	首次启动副本集成员时，如果未指定操作日志大小，则MongoDB将创建默认大小的操作日志。

	默认操作日志大小取决于存储引擎：

		Storage Engine	           Default Oplog Size	    Lower Bound	  Upper Bound
		In-Memory Storage Engine	5% of physical memory	50 MB	      50 GB
		WiredTiger Storage Engine	5% of free disk space	990 MB	      50 GB


	在大多数情况下，默认操作日志大小已足够。 例如，如果操作日志是可用磁盘空间的5％，并且在24小时的操作中已满，则辅助服务器可以在长达24小时的时间内停止从操作日志中复制条目，而不会过时而无法继续复制。 但是，大多数副本集的操作量要少得多，并且它们的oplog可以容纳更多的操作。

	在mongod创建操作日志之前，您可以使用oplogSizeMB选项指定其大小。 首次启动副本集成员后，请使用 replSetResizeOplog 管理命令来更改操作日志大小。 replSetResizeOplog使您能够动态调整操作日志的大小，而无需重新启动mongod进程。

	从MongoDB 4.0开始，操作日志可以超过其配置的大小限制，以避免删除多数提交点。

2. 可能需要较大Oplog大小的工作负载
	如果您可以预测副本集的工作量类似于以下模式之一，那么您可能希望创建一个大于默认值的操作日志。 相反，如果您的应用程序主要以最少的写操作执行读取，则较小的oplog可能就足够了。
	
	以下工作负载可能需要更大的oplog大小:
		1. 一次更新多个文档
			操作日志必须将多次更新转换为单独的操作，以保持幂等性。 这会占用大量操作日志空间，而不会相应增加数据大小或磁盘使用量。
		
		2. 删除等于插入的数据量
			如果删除与插入时大致相同的数据量，则数据库在磁盘使用方面不会显着增长，但是操作日志的大小可能会很大。
		3. 大量的原地更新
			如果工作量的很大一部分是不增加文档大小的更新，则数据库会记录大量操作，但不会更改磁盘上的数据量。
		
3. Oplog Status 

	rs.printReplicationInfo() 
	
	repl_set:PRIMARY> db.printReplicationInfo()
	configured oplog size:   1578.782958984375MB   -- 配置的oplog文件大小。 select 197*0.05 = 9.85GB.
	log length start to end: 101090secs (28.08hrs) -- oplog日志的启用时间段。
	oplog first event time:  Tue Jun 16 2020 17:54:46 GMT+0800 (CST) -- 第一个oplog日志的产生时间。
	oplog last event time:   Wed Jun 17 2020 21:59:36 GMT+0800 (CST) -- 最后一个oplog日志的产生时间。
	now:                     Wed Jun 17 2020 21:59:45 GMT+0800 (CST) -- 当前时间。


	repl_set:SECONDARY> db.printReplicationInfo()
	configured oplog size:   6312.335205078125MB
	log length start to end: 101090secs (28.08hrs)
	oplog first event time:  Tue Jun 16 2020 17:54:46 GMT+0800 (CST)
	oplog last event time:   Wed Jun 17 2020 21:59:36 GMT+0800 (CST)
	now:                     Wed Jun 17 2020 21:59:37 GMT+0800 (CST)
	
	
4. 复制延迟和流控制

	在各种特殊情况下，对次要操作日志的更新可能会滞后于所需的性能时间。 使用辅助成员中的 db.getReplicationInfo() 和复制状态输出来评估当前复制状态并确定是否存在意外复制延迟。

	从MongoDB 4.2开始，管理员可以限制主数据库应用其写入的速率，以将大多数承诺滞后时间保持在可配置的最大值flowControlTargetLagSeconds以下。
	
	默认情况下，启用流量控制。
	
	
	为了启用流控制，副本集/分片群集必须具有：featureCompatibilityVersion（FCV）为4.2且启用了读取关注多数。 也就是说，如果FCV不是4.2或禁用了大多数读取关注，则启用的流控制无效。
	
5. 慢Oplog应用

	从版本4.2（也从版本4.0.6开始也可用）开始，副本集的辅助成员现在记录的操作日志条目所花费的时间比应用慢操作阈值长。 
	这些消息记录在REPL组件下的辅助服务器上，并使用op文本：<oplog entry> took <num>ms.
	2018-11-16T12:31:35.886-0500 I REPL   [repl writer worker 13] applied op: command { ... }, took 112ms

	
	在次要节点上运行缓慢的oplog应用程序日志为：
		mongod --slowms
		slowOpThresholdMs
		The profile command or db.setProfilingLevel() shell helper method.
		
6. Oplog集合行为
	如果您的MongoDB部署使用WiredTiger存储引擎，则不能从任何副本集成员中删除local.oplog.rs集合。 
	此限制适用于单成员和多成员副本集。 如果节点暂时关闭并尝试在重新启动过程中重播oplog，则删除oplog可能导致副本集中的数据不一致。

		
		
		
		

		