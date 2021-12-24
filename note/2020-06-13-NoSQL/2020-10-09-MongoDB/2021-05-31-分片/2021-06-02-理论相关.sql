
MongoDB目前3大核心优势：『灵活模式』+ 『高可用性』 + 『可扩展性』，通过json文档来实现灵活模式，通过复制集来保证高可用，通过Sharded cluster来保证可扩展性。


是在客户端分片还是服务端分片？
客户端定好分片规则。

1. 3个组件
	mongos 
	基于副本集的config server
	基于副本集的shard 
	
	mongos：
	
		mongos充当查询路由器，在客户端应用程序和分片集群之间提供接口。
		
		从MongoDB 4.4开始，mongos可以支持对冲读取（hedged reads）以最大程度地减少延迟。
		
		Mongos 作为Sharded cluster的访问入口，所有的请求都由mongos来路由、分发、合并，这些动作对客户端driver透明，用户连接mongos就像连接mongod一样使用。
		
		Mongos 是Sharded cluster的访问入口，强烈建议所有的管理操作、读写操作都通过mongos来完成，以保证cluster多个组件处于一致的状态。

		Mongos 本身并不持久化数据，Sharded cluster所有的元数据都会存储到Config Server，而用户的数据则会分散存储到各个shard。
		
		Mongos 在 config server和 sharding 副本集 之后启动，它会从config server加载元数据，开始提供服务，将用户的请求正确路由到对应的Shard。
			-- 所以mongos要最后启动，并且所有对分片的操作，都是在mongos中做。
			http://mysql.taobao.org/monthly/2016/05/08/
			

		Mongos 作为Sharded cluster的访问入口，所有的请求都由mongos来路由、分发、合并，这些动作对客户端driver透明，用户连接mongos就像连接mongod一样使用。


	config服务器：	
		config servers（配置服务器）存储了分片集群的元数据和配置信息。
		从MongoDB 3.4版本开始，config servers必须部署为副本集架构 (CSRS)。
						
	分片：			
		存储用户数据。
		每个shard（分片）包含被分片的数据集中的一个子集。
		每个分片也是采用副本集架构。	
		
1.1 mongos
	
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

							
		
1.2 config server 

	Config server存储Sharded cluster的所有元数据，所有的元数据都存储在config数据库, config数据库又有很多个集合。

		
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
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- config.databases集合存储所有数据库的信息，包括DB是否开启分片，primary shard信息，对于数据库内没有开启分片的集合，所有的数据都会存储在数据库的primary shard上。
	config.database
	configserver:PRIMARY> db.databases.find()
	{ "_id" : "01_db", "primary" : "shard3", "partitioned" : true, "version" : { "uuid" : UUID("490e3c88-94b8-412d-9c33-f3cf95ccdc4a"), "lastMod" : 1 } }
	{ "_id" : "02_db", "primary" : "shard1", "partitioned" : true, "version" : { "uuid" : UUID("dbcdb56b-2f3f-4523-a6d1-eacab67d00c4"), "lastMod" : 1 } }
	{ "_id" : "03_db", "primary" : "shard3", "partitioned" : true, "version" : { "uuid" : UUID("71fe2127-fee0-4ac4-a217-1fa46b54d245"), "lastMod" : 1 } }
	{ "_id" : "04_db", "primary" : "shard2", "partitioned" : false, "version" : { "uuid" : UUID("1eb4f8ed-0412-43fb-9c7d-ba003801531e"), "lastMod" : 1 } }
	
	"partitioned" : true   表示数据库有开启分片
	"partitioned" : false  表示数据库没有开启分片
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- 数据分片是针对集合维度的，某个数据库开启分片功能后，如果需要让其中的集合分片存储，则需调用 shardCollection 命令来针对集合开启分片。
	
	config.collections
	configserver:PRIMARY> db.collections.find()
	{ "_id" : "config.system.sessions", "lastmodEpoch" : ObjectId("60b4385329a21eaeea745cd9"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "_id" : 1 }, "unique" : false, "uuid" : UUID("e2976da6-2813-4bf2-bc80-ef6260275983") }
	{ "_id" : "posdb.testc_co", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:34:53.975Z"), "dropped" : true }
	{ "_id" : "shardtest_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:50.688Z"), "dropped" : true }
	{ "_id" : "shard_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:37.137Z"), "dropped" : true }
	{ "_id" : "1008_db.user", "lastmodEpoch" : ObjectId("000000000000000000000000"), "lastmod" : ISODate("2021-05-31T22:35:06.645Z"), "dropped" : true }
	{ "_id" : "01_db.user", "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "lastmod" : ISODate("1970-02-19T17:02:47.301Z"), "dropped" : false, "key" : { "userid" : "hashed" }, "unique" : false, "uuid" : UUID("35690a88-6d22-4e0f-84a3-042ac07a0df7") }
	{ "_id" : "02_db.user", "lastmodEpoch" : ObjectId("60b5382629a21eaeea79c904"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "id" : 1 }, "unique" : false, "uuid" : UUID("744c45d5-2a71-4254-9cb3-beb77fdf6f8d") }
	{ "_id" : "03_db.user", "lastmodEpoch" : ObjectId("60b56164813b999acac37673"), "lastmod" : ISODate("1970-02-19T17:02:47.296Z"), "dropped" : false, "key" : { "id" : 1 }, "unique" : false, "uuid" : UUID("dd1dca41-aea3-4fd7-afd4-c055ab6b41d1") }
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- config.shards集合存储各个Shard的信息，可通过 addShard、removeShard 命令来动态的从Sharded cluster里增加或移除shard。如下所示，cluster目前拥有3个shard，均为复制集。
	config.shards 
	configserver:PRIMARY> db.shards.find()
	{ "_id" : "shard1", "host" : "shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016", "state" : 1 }
	{ "_id" : "shard2", "host" : "shard2/192.168.0.201:27018,192.168.0.202:27018,192.168.0.203:27018", "state" : 1 }
	{ "_id" : "shard3", "host" : "shard3/192.168.0.201:27019,192.168.0.202:27019,192.168.0.203:27019", "state" : 1 }

	
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------
	
	config.mongos
	configserver:PRIMARY> db.mongos.find()
	{ "_id" : "localhost.localdomain:20000", "advisoryHostFQDNs" : [ ], "mongoVersion" : "4.2.7", "ping" : ISODate("2021-05-31T23:53:22.076Z"), "up" : NumberLong(82712), "waiting" : true }

	存储当前集群所有mongos的信息；
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------

	为什么需要 configer server？
	
		还是不理解它的作用。
		
		http://mysql.taobao.org/monthly/2016/05/08/  	这篇文章讲的Config Server还不错。
		
		----------------------------------------------------------------------------------------------------
		知道哪些DB有做分片，哪些没有
		知道哪些集合有做分片，哪些没有，如果有做分片：是范围分片还是哈希分片，分片键是哪个。
		
			by 2021-12-20
		

1.3 组件小结
	
	
	
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
	
	
	
	
	
	