


4.2 版本的变化 
	
	对于功能兼容版本（fcv）“ 4.0”，请指定背景：true指示MongoDB在后台构建索引。 后台构建不会阻止对集合的操作。 默认值为false。

	{background: true} 参数可选的。 在MongoDB 4.2中已弃用。
		db.values.createIndex({open: 1, close: 1}, {background: true})

	对于功能兼容版本（fcv）“ 4.2”，所有索引构建都使用优化的构建过程，该过程仅在构建过程的开始和结束时才持有集合的排他锁。 其余的构建过程将产生交错的读写操作。 如果指定，MongoDB将忽略后台选项。


相关参考：
	
	https://docs.mongodb.com/manual/reference/method/db.collection.createIndex/
	
	https://mp.weixin.qq.com/s/feAQJLMlwoCTFgURx37kQQ   如何在MongoDB集合上创建索引



索引构建过程汇总如下：

	1. 初始化
		mongod 进程对正在编制索引的集合使用独占锁。所有对该集合的读写操作将阻塞直到mongod 进程释放锁。在此期间，应用程序无法访问集合。
		
		-- 获取集合的全局锁，会阻塞集合的读写操作。
		
		
	2. 数据提取和加工
		mongod进程释放上一过程中获取的所有锁，然后针对被索引的集合获取一系列意向锁。在此期间，应用程序可以对集合发出读写操作。

	3. 清理
		mongod进程释放上一过程中获取的所有锁，然后针对被索引集合获取独占锁。这时将阻塞对该集合所有读写操作直到mongod进程释放锁。应用程序此时无法访问该集合。


	4. 完成
		mongod进程标记索引状态为已可用，然后释放索引构建过程中的所有锁。


db.table_clubgamelog.dropIndex("szToken_1")

db.table_clubgamelog.createIndex({"szToken" : 1})



db.table_clubgamelog.remove({'szToken':'10002-890598-1593716379-1-3'})

db.table_clubgamelog.remove({'szToken':'10045-913672-1593716373-16-8'})
