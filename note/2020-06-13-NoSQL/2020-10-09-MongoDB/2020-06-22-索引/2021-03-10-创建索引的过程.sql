
1. 4.2 版本的变化 
2. 加锁过程
3. 索引的构建过程
4. 索引构建对数据库性能的影响	
5. 相关参考
6. 未完成


1. 4.2 版本的变化 
	
	弃用 {background: true} 参数
	只需要在构建索引的开始和结束阶段，加集合排他锁。
	
	-------------------------------------------------------------------
	
	对于功能兼容版本（fcv）“ 4.0”，请指定后台：true 指示MongoDB在后台构建索引。 后台构建不会阻止对集合的操作。 默认值为false。

	{background: true} 参数可选的。 在MongoDB 4.2中已弃用。
		db.values.createIndex({open: 1, close: 1}, {background: true})

	对于功能兼容版本（fcv）“ 4.2”，所有索引构建都使用优化的构建过程，该过程仅在构建过程的开始和结束时才持有集合的排他锁。 
	其余的构建过程将产生交错的读写操作。 如果指定，MongoDB将忽略后台选项。
	
	
2. 加锁过程

	1. 对集合加 排他锁，此时会阻塞集合的读写操作
	2. 释放独点锁，对集合的数据加意向排他锁(类似于MDL读锁)，可以做DML操作
	3. 释放意向排他锁，添加排他锁，此时会阻塞集合的读写操作
	4. 标记索引状态为已可用，释放集合的排他锁。


3. 索引的构建过程
	
	1. 创建一张临时表("side writes table")，用于存储构建索引期间产生的增量数据
	2. 遍历集合的所有数据
	3. 期间增量数据记录在临时表中
	4. 集合数据遍历完成后，会将已排序的键插入到索引树中，同时把临时表的数据插入到索引树中
	5. 第4步完成后，mongod将索引元数据更新为可使用状态，索引构建完成。


4. 索引构建对数据库性能的影响	
	1. 高负载写入时的索引构建
		消耗IO资源，导致写入性能下降
	
	2. 使用内存的限制
		200MB（对于4.2.3及更高版本）和500MB（对于版本4.2.2及更早版本）
		
		索引大小超过内存限制，就需要临时磁盘文件暂存数据。
		使用--dbpath目录下_tmp文件夹下的临时磁盘文件空间，用于完成索引构建。
	
	
5. 相关参考
	
	https://docs.mongodb.com/manual/reference/method/db.collection.createIndex/
	
	https://mp.weixin.qq.com/s/feAQJLMlwoCTFgURx37kQQ   如何在MongoDB集合上创建索引，翻译了官方文档
	
	https://docs.mongodb.com/v4.2/core/index-creation/index.html
	
	https://stackoverflow.com/questions/60666018/mongodb-index-build-process-why-does-index-creation-blocks-all-the-database-ac
	


6. 未完成
	4.2 版本创建索引的流程跟MySQL Online DDL对比 
	
