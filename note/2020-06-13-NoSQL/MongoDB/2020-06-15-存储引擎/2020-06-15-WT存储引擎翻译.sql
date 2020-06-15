

1. 文件层级并发 --Document Level Concurrency 
2. 快照和检查点 --Snapshots and Checkpoints 
3. Journal
4. 压缩 --Compression
5. 内存使用 --Memory Use





1. 文档层级并发 --Document Level Concurrency 

	WiredTiger使用文档级并发控制进行写操作。 结果，多个客户端可以同时修改集合的不同文档。

	对于大多数读取和写入操作，WiredTiger使用乐观并发控制。 WiredTiger仅在全局，数据库和集合级别使用意图锁。 当存储引擎检测到两个操作之间存在冲突时，将引发写冲突，从而导致MongoDB透明地重试该操作。

	一些全局操作（通常是涉及多个数据库的短暂操作）仍然需要全局“实例范围”锁。 其他一些操作（例如collMod）仍然需要排他数据库锁。

2. 快照和检查点 --Snapshots and Checkpoints 

	
	WiredTiger使用MultiVersion并发控制（MVCC）。在操作开始时，WiredTiger为操作提供数据的时间点快照。快照提供了内存数据的一致视图。

	写入磁盘时，WiredTiger将所有数据文件中的快照中的所有数据以一致的方式写入磁盘。现在持久的数据充当数据文件中的检查点。该检查点可确保数据文件直到最后一个检查点（包括最后一个检查点）都保持一致；即检查点可以充当恢复点。

	从3.6版开始，MongoDB配置WiredTiger以60秒的间隔创建检查点（即将快照数据写入磁盘）。在早期版本中，MongoDB将检查点设置为在WiredTiger中以60秒的间隔或在写入2 GB日记数据时对用户数据进行检查，以先到者为准。

	在写入新检查点期间，先前的检查点仍然有效。这样，即使MongoDB在写入新检查点时终止或遇到错误，在重新启动后，MongoDB也可以从上一个有效检查点中恢复。

	当WiredTiger的元数据表被原子更新以引用新的检查点时，新的检查点将变为可访问且永久的。一旦可以访问新的检查点，WiredTiger就会从旧的检查点释放页面。
	
	使用WiredTiger，即使没有日记，MongoDB也可以从最后一个检查点恢复； 但是，要恢复上一个检查点之后所做的更改，请运行日记功能。
	
	
3. Journal

	WiredTiger将预写日志（即日志）与检查点结合使用以确保数据的持久性。

	WiredTiger日记保留检查点之间的所有数据修改。 如果MongoDB在检查点之间退出，它将使用日志重播自上一个检查点以来修改的所有数据。 有关MongoDB将日记数据写入磁盘的频率的信息，请参阅日记处理。

	WiredTiger日记使用快速压缩库进行压缩。 要指定其他压缩算法或不进行压缩，请使用storage.wiredTiger.engineConfig.journalCompressor设置。 有关更改日志压缩器的详细信息，请参阅“更改WiredTiger日志压缩器”。
	
	如果日志记录小于或等于128字节（WiredTiger的最小日志记录大小），则WiredTiger不会压缩该记录。
	
	您可以通过将storage.journal.enabled设置为false来禁用独立实例的日志记录，这样可以减少维护日志记录的开销。 对于独立实例，不使用日志意味着MongoDB意外退出时，您将丢失最后一个检查点之前的所有数据修改。  -- 单实例下也要开启 journal.
	
	
4. 压缩 --Compression

	使用WiredTiger，MongoDB支持对所有集合和索引进行压缩。 压缩可以最大程度地减少存储使用量，但会增加CPU的开销。

	默认情况下，WiredTiger对所有集合使用块压缩和snappy压缩库，对所有索引使用前缀压缩。
	
	对于集合，还提供以下块压缩库：
		zlib
		zstd (Available starting in MongoDB 4.2)
		
	要指定替代压缩算法或不进行压缩，请使用 storage.wiredTiger.collectionConfig.blockCompressor 设置。

	对于索引，要禁用前缀压缩，请使用 storage.wiredTiger.indexConfig.prefixCompression 设置。

	压缩设置还可以在收集和索引创建期间基于每个集合和每个索引进行配置。 请参见指定存储引擎选项和db.collection.createIndex（）storageEngine选项。

	对于大多数工作负载，默认压缩设置可以平衡存储效率和处理要求。

	默认情况下，WiredTiger日志也被压缩。 有关日记压缩的信息，请参阅日记。

	
5. 内存使用 --Memory Use
				
	通过WiredTiger，MongoDB可以利用WiredTiger内部缓存和文件系统缓存。			
	
	从MongoDB 3.4开始，默认的WiredTiger内部缓存大小是以下两者中的较大者：
		50％（RAM-1 GB）或256 MB。
		例如，在总共有4GB RAM的系统上，WiredTiger缓存将使用1.5GB RAM（0.5 *（4 GB-1 GB）= 1.5 GB）。
		相反，总内存为1.25 GB的系统将为WiredTiger缓存分配256 MB，因为这是总RAM的一半以上减去一GB（0.5 *（1.25 GB-1 GB）= 128 MB <256 MB） 。
		
	默认情况下，WiredTiger对所有集合使用Snappy块压缩，对所有索引使用前缀压缩。 压缩默认值是可以在全局级别配置的，也可以在收集和索引创建期间基于每个集合和每个索引进行设置。
	
	WiredTiger内部缓存中的数据与磁盘格式使用不同的表示形式：
	
		文件系统缓存中的数据与磁盘上的格式相同，包括对数据文件进行任何压缩的好处。 操作系统使用文件系统缓存来减少磁盘 I / O。
		加载到WiredTiger内部缓存中的索引具有与磁盘格式不同的数据表示形式，但仍可以利用索引前缀压缩来减少RAM使用。 索引前缀压缩对来自索引字段的通用前缀进行重复数据删除。
		WiredTiger内部缓存中的收集数据未压缩，并且使用与磁盘格式不同的表示形式。 块压缩可以节省大量的磁盘存储空间，但是必须对数据进行解压缩才能由服务器进行处理。
		通过文件系统缓存，MongoDB自动使用WiredTiger缓存或其他进程未使用的所有可用内存。
		
		
		
		
		
		
		