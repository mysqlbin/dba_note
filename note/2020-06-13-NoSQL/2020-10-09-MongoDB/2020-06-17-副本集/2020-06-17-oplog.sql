


0. 前言
1. Oplog Size
2. 可能需要较大Oplog大小的工作负载
3. Oplog Status 
4. 复制延迟和流控制
5. 慢Oplog应用
6. Oplog集合行为
7. 备份的时候添加参数 "--oplog"， 用于一致性备份快照
8. oplog 的幂等性			
9. 相关参考
10. 思考
		
		   
0. 前言

	oplog（操作日志）是一个特殊的，有上限的集合，该记录保持所有修改存储在数据库中的数据的操作的滚动记录。
	
	从MongoDB 4.0开始，与其他设置上限的集合不同，oplog可以超出其配置的大小限制，以避免删除多数提交点。
	
	MongoDB在主数据库上应用数据库操作，然后在主数据库的操作日志中记录这些操作。 然后，辅助成员将这些操作复制并应用到异步过程中。 所有副本集成员都在 local.oplog.rs 集合中包含操作日志的副本，这使他们可以维护数据库的当前状态。
	
	为了促进复制，所有副本集成员都将心跳（ping）发送给所有其他成员。 任何辅助成员都可以从任何其他成员导入操作日志条目。
	
	操作日志中的每个操作都是幂等的。 也就是说，oplog操作会产生相同的结果，无论是一次还是多次应用于目标数据集。
	
	oplog有一个非常重要的特性——幂等性（idempotent）。即对一个数据集合，使用oplog中记录的操作重放时，无论被重放多少次，其结果会是一样的。举例来说，如果oplog中记录的是一个插入操作，并不会因为你重放了两次，数据库中就得到两条相同的记录。这是一个很重要的特性，也是后面这些操作的基础。

	已存在的数据，重做oplog不会重复；不存在的数据重做oplog就可以进入数据库。所以当做完截止到某个时间点的oplog时，数据库就恢复到了截止那个时间点的状态。
	
	
1. Oplog Size


	首次启动副本集成员时，如果未指定操作日志大小，则MongoDB将创建默认大小的操作日志。

	默认操作日志大小取决于存储引擎：

		Storage Engine	           Default Oplog Size	    Lower Bound	  Upper Bound
		In-Memory Storage Engine	5% of physical memory	50 MB	      50 GB
		WiredTiger Storage Engine	5% of free disk space	990 MB	      50 GB


	在大多数情况下，默认操作日志大小已足够。 例如，如果操作日志是可用磁盘空间的5％，并且在24小时的操作中已满，则辅助服务器可以在长达24小时的时间内停止从操作日志中复制条目，而不会过时而无法继续复制。 但是，大多数副本集的操作量要少得多，并且它们的oplog可以容纳更多的操作。

	在mongod创建操作日志之前，您可以使用oplogSizeMB选项指定其大小。 首次启动副本集成员后，请使用 replSetResizeOplog 管理命令来更改操作日志大小。 replSetResizeOplog 使您能够动态调整操作日志的大小，而无需重新启动mongod进程。

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

		
7. 备份的时候添加参数 "--oplog"， 用于一致性备份快照
	--oplog：  use oplog for taking a point-in-time snapshot
	即通过 oplog 得到基于备份结束时间点的一致性快照， 从dump开始的时间系统将记录所有的oplog到oplog.bson中
	
	举例说明： 
	
		有2个表，表A 和 表B

		当表A备份完成，开始备份表B, 备份表B期间向表A插入了一行记录同时记录到 oplog 中， 这时候备份完成，时间节点在 15:30 。 
		
		假设 拿这个备份去恢复数据， 会发生表A少了一行记录。

		这时候 oplog 的作用就体现出来了，在备份数据的基础上，同时备份 oplop，在恢复的数据的基础上，再重做一遍oplog中记录的所有操作，这时的数据就可以代表dump结束时那个时间点(point-in-time)的数据库状态。
			
8. oplog 的幂等性			
	已存在的数据，重做oplog不会重复；不存在的数据重做oplog就可以进入数据库。
		
	举例说明： 
	
		有2个表，表A 和 表B

		当表A备份完成，开始备份表B, 备份表B期间向表B插入了一行记录同时记录到 oplog 中， 这时候备份完成，备份包含了表B新插入的记录， 时间节点在 15:30 。 
		
		在恢复备份的时候，因为备份包含了表B新插入的记录， 重做 oplog 的时候不会把这一行记录写入数据库中。
		
		
9. 相关参考
	
	https://docs.mongodb.com/manual/core/replica-set-oplog/
	https://www.cnblogs.com/operationhome/p/10688798.html MongoDB-Oplog详解


10. 思考
	oplog 的刷盘时机？
	
	