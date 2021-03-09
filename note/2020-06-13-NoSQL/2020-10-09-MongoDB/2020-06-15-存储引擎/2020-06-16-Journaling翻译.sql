

1. 日志的介绍
2. 日志处理 --Journaling Process
3. 日志文件 --Journal Files
4. 日志文件中的记录 --Journal Records
5. 压缩 --Compression
6. 日志文件的大小限制 --Journal File Size Limit
7. 相关参考

1. 日志的介绍
	
	本节中提到的日志是指WiredTiger预写日志（即日志），而不是MongoDB日志文件。
	WiredTiger使用检查点提供磁盘上数据的一致视图，并允许MongoDB从最后一个检查点恢复。 但是，如果MongoDB在检查点之间意外退出，则需要日志记录来恢复在最后一个检查点之后发生的信息。
	从MongoDB 4.0开始，您不能指定--nojournal选项或storage.journal.enabled：使用WiredTiger存储引擎的副本集成员为false。


	使用日记的恢复过程：

		在数据文件中查找到最后一个检查点的标识符。
		在日志文件中搜索与最后一个检查点的标识符匹配的记录。
		重做对应记录之后的全部操作；
		
		/*
		为了在数据库宕机保证 MongoDB 中数据的持久性，MongoDB 使用了 Write Ahead Logging 向磁盘上的 journal 文件预先进行写入；
		除了 journal 日志，MongoDB 还使用检查点（Checkpoint）来保证数据的一致性，当数据库发生宕机时，我们就需要 Checkpoint 和 journal 文件协作完成数据的恢复工作：

			在数据文件中查找上一个检查点的标识符；

			在 journal 文件中查找标识符对应的记录；

			重做对应记录之后的全部操作；
			
			https://mp.weixin.qq.com/s/jUhXqrGuHBK32bSlWolu5w  『浅入浅出』MongoDB 和 WiredTiger 
				
		*/
		
	
2. 日志处理 --Journaling Process
	
	1. 使用日记功能，WiredTiger为每个客户端开启的写操作创建一个日记记录。 
		日记记录包括由初始写入引起的任何内部写入操作。 
		例如，对集合中文档的更新可能会导致对索引的修改； WiredTiger创建一条日志记录，其中包含更新操作及其关联的索引修改。

	2. MongoDB将WiredTiger配置为使用内存缓冲来存储日记记录。 线程进行协调以分配并复制到其缓冲区中。 最多可缓存128kB的所有日记记录。
	
	3. WiredTiger在以下任一情况下将缓冲的日记记录同步到磁盘：
		
		1. 对于副本集成员（主要和次要成员）：
			
			如果有操作在等待操作日志条目。 可以等待操作日志条目的操作包括：
				针对oplog转发扫描查询
				读取操作作为因果一致会话的一部分
			此外，对于次要成员，在每次批处理操作日志条目之后。
			
		2. 如果写操作包括或暗示 j：true 的写关注(写入操作的journal持久化后才向客户端确认)。
			
		3. 每100毫秒(每隔0.1秒)
		
		4. WiredTiger创建新的日记文件时。 
			由于MongoDB使用的日志文件大小限制为100 MB，因此WiredTiger大约每100 MB数据创建一个新的日志文件。
		
		
3. 日志文件 --Journal Files

	对于日记文件，MongoDB在dbPath目录下创建一个名为journal的子目录。 
	WiredTiger日志文件的名称具有以下格式WiredTigerLog。<sequence>，其中<sequence>是从0000000001开始的零填充数字。

	[root@database-03 journal]# pwd
	/mydata/mongodb/data/journal
	[root@database-03 journal]# ll
	total 307200
	-rw------- 1 mongodb mongodb 104857600 2020-06-15 18:04 WiredTigerLog.0000000200
	-rw------- 1 mongodb mongodb 104857600 2020-06-15 14:22 WiredTigerPreplog.0000000023
	-rw------- 1 mongodb mongodb 104857600 2020-06-15 14:28 WiredTigerPreplog.0000000057
	
4. 日志文件中的记录 --Journal Records
	
	日志文件包含每个客户端的写操作的记录
	
	日记记录包括由初始写入引起的任何内部写入操作。 例如，对集合中文档的更新可能会导致对索引的修改； WiredTiger创建一条日志记录，其中包含更新操作及其关联的索引修改。
	
	每个记录都有一个唯一的标识符。
	
	WiredTiger的最小日志记录大小为128个字节。
	
5. 压缩 --Compression

	默认情况下，MongoDB将WiredTiger配置为对其日记数据使用快速压缩(snappy compression)。
	
	
6. 日志文件的大小限制 --Journal File Size Limit

	MongoDB的WiredTiger日志文件的最大大小限制为大约100 MB。
	一旦文件超过该限制，WiredTiger将创建一个新的日记文件。
	WiredTiger自动删除旧的日记文件，只需要维护从上一个检查点开始需要恢复的文件。
	-- 类似于binlog，单个文件的大小超过一定的阀值，会自动创建下一个文件。

	shell> date
	Tue Mar  9 15:40:10 CST 2021
	
	shell> ll
	total 307200
	-rw-------. 1 mongodb mongodb 104857600 Mar  9 15:39 WiredTigerLog.0000001054
	-rw-------. 1 mongodb mongodb 104857600 Jul 21  2020 WiredTigerPreplog.0000000031
	-rw-------. 1 mongodb mongodb 104857600 Mar  9 13:35 WiredTigerPreplog.0000000970
	
	
7. 相关参考
	
	https://docs.mongodb.com/manual/core/journaling/

8. 小结
	


	