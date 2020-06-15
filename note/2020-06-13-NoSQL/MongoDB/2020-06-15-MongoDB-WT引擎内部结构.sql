
1. 内部缓存
2. Jounal 
3. checkpoint 

update 语句的更新流程
	1. 数据页不在内存中，先读入内存中
	2. 在内存中修改数据页的时候，会先把数据页拷贝出来成为一个新的数据页
	3. 然后在新的数据页上做修改
	4. 写 jounal 日志并且持久化
	5.  
	

使用WiredTiger，MongoDB支持对所有集合和索引进行压缩。 压缩可以最大程度地减少存储使用量，但会增加CPU的开销。



Wiredtiger采用 Copy on write（快照）的方式管理修改操作（insert、update、delete），
修改操作会先缓存在cache里，并持久化到WAL(Write ahead log)， 持久化时，修改操作不会在原来的leaf page上进行，而是写入新分配的page，每次checkpoint都会产生一个新的root page。


https://blog.csdn.net/gaozhigang/article/details/79241044  Mongodb存储特性与内部原理
https://docs.mongodb.com/manual/core/wiredtiger/ 
https://docs.mongodb.com/manual/core/wiredtiger/#storage-wiredtiger-checkpoints


这个描述得可以
	checkpoint（检测点，将内存中的数据变更（脏页）flush到磁盘中的数据文件中，并做一个标记点，表示标记点之前的数据表示已经持久存储在了数据文件中，此时内存的数据与磁盘的数据一致；
	标记点之后的数据变更存在于内存和journal日志中。
	
	崩溃恢复的起点就从这个checkpoint开始。
	
	
WiredTiger使用MultiVersion并发控制（MVCC）。在操作开始时，WiredTiger为操作提供数据的时间点快照。快照提供了内存数据的一致视图。

写入磁盘时，WiredTiger将所有数据文件中的快照中的所有数据以一致的方式写入磁盘。现在持久的数据充当数据文件中的检查点。该检查点可确保数据文件直到最后一个检查点（包括最后一个检查点）都保持一致；即检查点可以充当恢复点。

从3.6版开始，MongoDB配置WiredTiger以60秒的间隔创建检查点（即将快照数据写入磁盘）。在早期版本中，MongoDB将检查点设置为在WiredTiger中以60秒的间隔或在写入2 GB日记数据时对用户数据进行检查，以先到者为准。

在写入新检查点期间，先前的检查点仍然有效。这样，即使MongoDB在写入新检查点时终止或遇到错误，在重新启动后，MongoDB也可以从上一个有效检查点中恢复。

当WiredTiger的元数据表被原子更新以引用新的检查点时，新的检查点将变为可访问且永久的。一旦可以访问新的检查点，WiredTiger就会从旧的检查点释放页面。

使用WiredTiger，即使没有日记，MongoDB也可以从最后一个检查点恢复；但是，要恢复上一个检查点之后所做的更改，请运行日记功能。

从MongoDB 4.0开始，您不能指定--nojournal选项或storage.journal.enabled：使用WiredTiger存储引擎的副本集成员为false。

还是官方文档靠谱， 近期多看官方文档。



