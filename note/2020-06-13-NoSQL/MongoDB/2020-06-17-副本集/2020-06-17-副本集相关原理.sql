

复制的原理：
	
	第一次是走全量数据复制。
	
	
	复制是基于操作日志 oplog ，相当于 MySQL 中的二进制日志，只会记录发生改变的记录。
	复制是将主节点的 oplog 日志同步并应用到其他的从节点的过程。
	
	副本集中数据同步过程：
		Primary节点写入数据，Secondary通过读取Primary的oplog得到复制信息，开始复制数据并且将复制信息写入到自己的oplog。
		
	当Primary节点完成数据操作后，Secondary会做出一系列的动作保证数据的同步：
		1：检查自己local库的oplog.rs集合找出最近的时间戳。
		2：检查Primary节点local库oplog.rs集合，找出大于此时间戳的记录。
		3：将找到的记录插入到自己的oplog.rs集合中，并执行这些操作。

	Primary中所有的写入操作都会记录到MongoDB Oplog中，然后从库拉取主库的Oplog并应用到自己的数据库中，当某个从节点准备更新自己的数据时， 它会做3件事情。
		首先， 它会查看自己 oplog里最新记录的时间戳(timestamp)；
		然后， 它会查询主节点的 oplog, 查询所有时间戳大于自己时间戳的oplog记录；
		最后， 将找到的记录插入到自己的oplog.rs集合中，并执行这些操作。（当启用日志的时候， 在同一个事务里，文档被写入核心数据文件， 而且同时入 oplog.）
		这3个步骤的总结：
			从库通过自己 Oplog的时间戳跟主库的 Oplog的时间戳比较， 获取时间戳大于自己的oplog记录，然后把这部分日志应用到从库中。
		


触发选举的条件
	初始化一个副本集时
	备份节点无法与主节点连通时
	主节点故障
	修改优先级
	将Primary节点降级为Secondary节点： rs.setpDown()
	

选举的原理
	节点类型分为标准（host）节点、被动（passive）节点和仲裁（arbiter）节点。
	只有标准节点肯被选举为活跃节点，由选举权。被动节点由完整副本，不可能成为活跃节点，由选举权。仲裁节点不复制数据，不能成为活跃节点，只有选举权。
	标准节点与被动节点的区别：priority 值高者是标准节点，低者为被动节点
	选举规则是票数高的获胜，priority 是优先权为 0 ~ 1000 的值，相当于额外增加 0 ~ 1000 的票数。
		选举结果：票数高的获胜，若票数相同，数据新者获胜。	
		
	

那 MongoDB 是怎进行选举的呢？官方这么描述:

	We use a consensus protocol to pick a primary. Exact details will be spared here but that basic process is:

	1. get maxLocalOpOrdinal from each server.

	2. if a majority of servers are not up (from this server’s POV), remain in Secondary mode and stop.

	3. if the last op time seems very old, stop and await human intervention.

	4. else, using a consensus protocol, pick the server with the highest maxLocalOpOrdinal as the Primary.

	大致翻译过来为使用一致协议选择主节点。基本步骤为：

	1. 得到每个服务器节点的最后操作时间戳。
		每个mongodb都有oplog机制会记录本机的操作，方便和主服务器进行对比数据是否同步还可以用于错误恢复。

	2. 如果集群中大部分服务器down机了，保留活着的节点都为 secondary 状态并停止服务，不选举了。

	3. 如果集群中选举出来的主节点或者所有从节点最后一次同步时间看起来很旧了，停止选举等待人来操作。

	4. 2-3步骤都没有问题就选择最后操作时间戳最新（保证数据是最新的）的服务器节点作为主节点。		
		
	5. 所有从节点的最后操作时间都是一样怎么办？就是谁先成为主节点的时间最快就选谁。
	
	
	