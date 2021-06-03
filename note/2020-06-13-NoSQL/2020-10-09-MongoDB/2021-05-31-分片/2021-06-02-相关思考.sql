

1. 扩容
2. 一致性备份
3. shards的扩容
4. mongos 的高可用
5. config server 发生主从切换，会发生什么?
	shard的数据可以正常写入。
	
6. 指定不分片的库存储到某个shard上
	有个问题，就是有的库我不分片，目前我有2个分片集(A和B)，然后我创建一个新数据库，怎么指定其在分片集B上面
	作者回复: db.adminCommand( { movePrimary : "your_dbname", to : "shard0001" } )
	https://docs.mongodb.com/manual/reference/command/movePrimary/
		





