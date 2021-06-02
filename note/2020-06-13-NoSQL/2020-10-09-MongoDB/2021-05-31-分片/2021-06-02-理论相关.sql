


1. 3个组件
	mongos 
	基于副本集的config server
	基于副本集的shard 

	MongoDB分片集群包括以下组件：

		分片：			每个shard（分片）包含被分片的数据集中的一个子集。每个分片可以被部署为副本集架构。

		mongos：		mongos充当查询路由器，在客户端应用程序和分片集群之间提供接口。从MongoDB 4.4开始，mongos可以支持对冲读取（hedged reads）以最大程度地减少延迟。
						mongos充当查询路由的角色，为客户端应用程序和分片集群间的通信提供一个接口。
					
			mongos> show collections
			actionlog
			changelog
			chunks
			collections
			databases
			lockpings
			locks
			migrations
			mongos
			shards
			tags
			transactions
			version

	
			mongos> db.collections.find()
			{ "_id" : "config.system.sessions", "lastmodEpoch" : ObjectId("60b4385329a21eaeea745cd9"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "_id" : 1 }, "unique" : false, "uuid" : UUID("e2976da6-2813-4bf2-bc80-ef6260275983") }
			{ "_id" : "posdb.testc_co", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:34:53.975Z"), "dropped" : true }
			{ "_id" : "shardtest_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:50.688Z"), "dropped" : true }
			{ "_id" : "shard_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:37.137Z"), "dropped" : true }
			{ "_id" : "1008_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:06.645Z"), "dropped" : true }
			{ "_id" : "01_db.user", "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "lastmod" : ISODate("1970-02-19T17:02:47.301Z"), "dropped" : false, "key" : { "userid" : "hashed" }, "unique" : false, "uuid" : UUID("35690a88-6d22-4e0f-84a3-042ac07a0df7") }
			{ "_id" : "02_db.user", "lastmodEpoch" : ObjectId("60b5382629a21eaeea79c904"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "id" : 1 }, "unique" : false, "uuid" : UUID("744c45d5-2a71-4254-9cb3-beb77fdf6f8d") }
			{ "_id" : "03_db.user", "lastmodEpoch" : ObjectId("60b56164813b999acac37673"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "id" : 1 }, "unique" : false, "uuid" : UUID("dd1dca41-aea3-4fd7-afd4-c055ab6b41d1") }
	
							
		config服务器：	config servers存储了分片集群的元数据和配置信息。
						Config servers（配置服务器）存储了分片集群的元数据和配置信息。从MongoDB 3.4版本开始，config servers必须部署为副本集架构 (CSRS)。
							
			configserver:PRIMARY> use config
			switched to db config
				
			configserver:PRIMARY> show collections
			actionlog
			changelog
			chunks
			collections
			databases
			lockpings
			locks
			migrations
			mongos
			shards
			tags
			transactions
			version

			configserver:PRIMARY> db.collections.find()
			{ "_id" : "config.system.sessions", "lastmodEpoch" : ObjectId("60b4385329a21eaeea745cd9"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "_id" : 1 }, "unique" : false, "uuid" : UUID("e2976da6-2813-4bf2-bc80-ef6260275983") }
			{ "_id" : "posdb.testc_co", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:34:53.975Z"), "dropped" : true }
			{ "_id" : "shardtest_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:50.688Z"), "dropped" : true }
			{ "_id" : "shard_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:37.137Z"), "dropped" : true }
			{ "_id" : "1008_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:06.645Z"), "dropped" : true }
			{ "_id" : "01_db.user", "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "lastmod" : ISODate("1970-02-19T17:02:47.301Z"), "dropped" : false, "key" : { "userid" : "hashed" }, "unique" : false, "uuid" : UUID("35690a88-6d22-4e0f-84a3-042ac07a0df7") }
			{ "_id" : "02_db.user", "lastmodEpoch" : ObjectId("60b5382629a21eaeea79c904"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "id" : 1 }, "unique" : false, "uuid" : UUID("744c45d5-2a71-4254-9cb3-beb77fdf6f8d") }
			{ "_id" : "03_db.user", "lastmodEpoch" : ObjectId("60b56164813b999acac37673"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "id" : 1 }, "unique" : false, "uuid" : UUID("dd1dca41-aea3-4fd7-afd4-c055ab6b41d1") }


			configserver:PRIMARY> db.shards.find()
			{ "_id" : "shard1", "host" : "shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016", "state" : 1 }
			{ "_id" : "shard2", "host" : "shard2/192.168.0.201:27018,192.168.0.202:27018,192.168.0.203:27018", "state" : 1 }
			{ "_id" : "shard3", "host" : "shard3/192.168.0.201:27019,192.168.0.202:27019,192.168.0.203:27019", "state" : 1 }


			configserver:PRIMARY> db.mongos.find()
			{ "_id" : "localhost.localdomain:20000", "advisoryHostFQDNs" : [ ], "mongoVersion" : "4.2.7", "ping" : ISODate("2021-05-31T23:53:22.076Z"), "up" : NumberLong(82712), "waiting" : true }

			

		为什么需要 configer server？
			还是不理解它的作用。
			
			
	
	Mongos是Sharded cluster的访问入口，强烈建议所有的管理操作、读写操作都通过mongos来完成，以保证cluster多个组件处于一致的状态。

	Mongos本身并不持久化数据，Sharded cluster所有的元数据都会存储到Config Server（下一节详细介绍），而用户的数据则会分散存储到各个shard。Mongos启动后，会从config server加载元数据，开始提供服务，将用户的请求正确路由到对应的Shard。
		http://mysql.taobao.org/monthly/2016/05/08/
		


2. chunksize

	如何查看MongoDB分片chunksize的值的大小
	原创 NoSQL 作者：chenfeng 时间：2016-08-03 18:25:25  5356  0
	chunksize默认的大小是64M,用mongos连接到config数据库，通过查看config.settings可以看到这个值：
	例如:
	mongos> use config
	mongos> db.settings.find()
	{ "_id" : "chunksize", "value" : 64 }

	----------------------------------------------------------------------------------------------------

	mongos> use config
	switched to db config
	mongos> db.settings.find()
	mongos> db.settings.find()
	mongos> 
	mongos> 

	
	https://docs.mongodb.com/v4.2/reference/configuration-options/index.html
		mongos-only Options
		Changed in version 3.4: MongoDB 3.4 removes sharding.chunkSize and sharding.autoSplit settings可以看到这个值：

		
		mongos-only 选项
		在 3.4 版更改：MongoDB 3.4 删除了 sharding.chunkSize 和 sharding.autoSplit 设置
		
		-- 还是官方文档靠谱
		
		

3. 分片中对于SHARD KEY(片键)的选择
	方案
		范围分片：
			通常能很好的支持基于Shard key的范围查询
			场景：适用于基于片键的范围查询
		Hash分片：
			通常能将写入均衡分布到各个Shard
			场景：不需要1次性根据片键查询多个值
	要素
		key分布足够离散
		写请求均匀分布
		尽量避免scatter-gather(分散-聚集)查询
	限定
		MongoDB不允许插入没有片键的文档
		分片之后数据的存放位置依赖于片键，对于分片Key的选定直接决定了集群中数据分布是否均衡、集群性能是否合理
	
	MongoDB是在collection级别实现的水平分片。

	
4. 分片和未分片集合

	数据库可以混合使用分片和未分片集合。分片集合被分区并分布在集群中的各个分片中。
	
	而未分片集合仅存储在主分片中。每个数据库都有自己的主分片。
	-- 这里的描述不准确。
	
	
	
	
	
	