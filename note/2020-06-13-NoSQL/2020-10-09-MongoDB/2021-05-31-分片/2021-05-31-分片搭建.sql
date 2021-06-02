
1. 环境规划如下
2. 安装shard1、shard2、shard3 3个分片对应的副本集
3. 三个节点配置 config server 并启动
4. 安装和配置mongos
5. 设置三节点的分片和路由配置服务器串联成集群
6. 验证分片
7. 启用分片
	7.1 哈希分片
	7.2 范围分片1
	7.3 范围分片2
	7.4 不需要分片的集合



1. 环境规划如下
	
	IP			192.168.0.201   	 		192.168.0.202    		192.168.0.203

				mongos: 20000  	
				
				config: 21000主节点  	config: 21000副节点     config: 21000副节点
				
	shard1		shard1: 27016主节点 	shard1: 27016副节点 	shard1: 27016副节点
			
	shard1		shard2: 27018主节点   	shard2: 27018副节点		shard2: 27018副节点

	shard3     	shard3: 27019主节点 	shard3: 27019副节点   	shard3: 27019副节点



	端口分配：

		mongos： 20000
		config： 21000
		
		shard1： 27016
		shard2： 27018
		shard3： 27019






2. 安装shard1、shard2、shard3 3个分片对应的副本集



3. 三个节点配置 config server 并启动

	参考：《2021-06-01-配置config》

4. 安装和配置mongos
	
	mongos  --config  /home/mongodb/router/conf/router.conf

	-- 查看日志
	
	2021-05-31T06:05:34.605+0800 W  NETWORK  [ReplicaSetMonitor-TaskExecutor] Unable to reach primary for set configs
	2021-05-31T06:05:34.792+0800 I  CONTROL  [signalProcessingThread] got signal 15 (Terminated), will terminate after current cmd ends
	2021-05-31T06:05:34.792+0800 I  NETWORK  [signalProcessingThread] shutdown: going to close all sockets...
	2021-05-31T06:05:34.792+0800 I  ASIO     [ReplicaSetMonitor-TaskExecutor] Killing all outstanding egress activity.
	2021-05-31T06:05:34.793+0800 I  CONNPOOL [ReplicaSetMonitor-TaskExecutor] Dropping all pooled connections to 192.168.0.202:21000 due to ShutdownInProgress: Shutting down the connection pool
	2021-05-31T06:05:34.793+0800 I  CONNPOOL [ReplicaSetMonitor-TaskExecutor] Dropping all pooled connections to 192.168.0.203:21000 due to ShutdownInProgress: Shutting down the connection pool
	2021-05-31T06:05:34.793+0800 I  CONNPOOL [ReplicaSetMonitor-TaskExecutor] Dropping all pooled connections to 192.168.0.201:21000 due to ShutdownInProgress: Shutting down the connection pool
	2021-05-31T06:05:34.793+0800 W  SHARDING [mongosMain] Error initializing sharding state, sleeping for 2 seconds and trying again :: caused by :: InterruptedAtShutdown: Error loading clusterID :: caused by :: interrupted at shutdown
	2021-05-31T06:05:34.794+0800 W  SHARDING [replSetDistLockPinger] pinging failed for distributed lock pinger :: caused by :: InterruptedAtShutdown: interrupted at shutdown
	2021-05-31T06:05:34.794+0800 I  SHARDING [shard-registry-reload] Periodic reload of shard registry failed  :: caused by :: InterruptedAtShutdown: could not get updated shard list from config server :: caused by :: interrupted at shutdown; will retry after 30s
	2021-05-31T06:05:34.794+0800 I  ASIO     [ShardRegistry] Killing all outstanding egress activity.
	2021-05-31T06:05:34.794+0800 I  ASIO     [TaskExecutorPool-0] Killing all outstanding egress activity.
	2021-05-31T06:05:34.794+0800 W  SHARDING [signalProcessingThread] error encountered while cleaning up distributed ping entry for localhost.localdomain:20000:1622412265:5108986554103424942 :: caused by :: ShutdownInProgress: Server is shutting down
	2021-05-31T06:05:34.794+0800 W  SHARDING [shard-registry-reload] cant reload ShardRegistry  :: caused by :: CallbackCanceled: Callback canceled
	2021-05-31T06:05:34.794+0800 I  ASIO     [shard-registry-reload] Killing all outstanding egress activity.
	2021-05-31T06:05:34.794+0800 I  CONTROL  [signalProcessingThread] shutting down with code:0
	2021-05-31T06:05:49.981+0800 I  CONTROL  [main] ***** SERVER RESTARTED *****
	2021-05-31T06:05:49.987+0800 I  CONTROL  [main] Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'
	2021-05-31T06:05:49.998+0800 I  CONTROL  [main] 
	2021-05-31T06:05:49.998+0800 I  CONTROL  [main] ** WARNING: Access control is not enabled for the database.
	2021-05-31T06:05:49.998+0800 I  CONTROL  [main] **          Read and write access to data and configuration is unrestricted.
	2021-05-31T06:05:49.998+0800 I  CONTROL  [main] ** WARNING: You are running this process as the root user, which is not recommended.
	2021-05-31T06:05:49.998+0800 I  CONTROL  [main] 
	2021-05-31T06:05:49.998+0800 I  SHARDING [mongosMain] mongos version v4.2.7
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain] db version v4.2.7
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain] git version: 51d9fe12b5d19720e72dcd7db0f2f17dd9a19212
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain] OpenSSL version: OpenSSL 1.0.1e-fips 11 Feb 2013
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain] allocator: tcmalloc
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain] modules: none
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain] build environment:
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain]     distmod: rhel70
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain]     distarch: x86_64
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain]     target_arch: x86_64
	2021-05-31T06:05:49.998+0800 I  CONTROL  [mongosMain] options: { config: "/home/mongodb/router/conf/router.conf", net: { bindIp: "0.0.0.0", port: 20000 }, processManagement: { fork: true }, sharding: { configDB: "config/192.168.0.201:21000,192.168.0.202:21000,192.168.0.203:21000" }, systemLog: { destination: "file", logAppend: true, path: "/home/mongodb/router/log/mongos.log" } }
	2021-05-31T06:05:50.002+0800 I  NETWORK  [mongosMain] Starting new replica set monitor for config/192.168.0.201:21000,192.168.0.202:21000,192.168.0.203:21000
	2021-05-31T06:05:50.020+0800 I  CONNPOOL [ReplicaSetMonitor-TaskExecutor] Connecting to 192.168.0.201:21000
	2021-05-31T06:05:50.020+0800 I  CONNPOOL [ReplicaSetMonitor-TaskExecutor] Connecting to 192.168.0.203:21000
	2021-05-31T06:05:50.020+0800 I  CONNPOOL [ReplicaSetMonitor-TaskExecutor] Connecting to 192.168.0.202:21000
	2021-05-31T06:05:50.020+0800 I  SHARDING [thread1] creating distributed lock ping thread for process localhost.localdomain:20000:1622412349:-6315730949836661159 (sleeping for 30000ms)
	2021-05-31T06:05:50.022+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for config is config/192.168.0.201:21000,192.168.0.202:21000,192.168.0.203:21000
	2021-05-31T06:05:50.022+0800 I  SHARDING [Sharding-Fixed-0] Updating sharding state with confirmed set config/192.168.0.201:21000,192.168.0.202:21000,192.168.0.203:21000
	2021-05-31T06:05:50.024+0800 I  SHARDING [ShardRegistry] Received reply from config server node (unknown) indicating config server optime term has increased, previous optime { ts: Timestamp(0, 0), t: -1 }, now { ts: Timestamp(1622412344, 1), t: 1 }
	2021-05-31T06:05:50.031+0800 W  SHARDING [replSetDistLockPinger] pinging failed for distributed lock pinger :: caused by :: LockStateChangeFailed: findAndModify query predicate didn t match any lock document
	2021-05-31T06:05:52.024+0800 I  CONNPOOL [ShardRegistry] Connecting to 192.168.0.202:21000
	2021-05-31T06:05:52.027+0800 I  FTDC     [mongosMain] Initializing full-time diagnostic data capture with directory '/home/mongodb/router/log/mongos.diagnostic.data'
	2021-05-31T06:05:52.059+0800 I  NETWORK  [listener] Listening on /tmp/mongodb-20000.sock
	2021-05-31T06:05:52.059+0800 I  NETWORK  [listener] Listening on 0.0.0.0
	2021-05-31T06:05:52.059+0800 I  NETWORK  [listener] waiting for connections on port 20000
	2021-05-31T06:05:52.062+0800 I  SH_REFR  [ConfigServerCatalogCacheLoader-0] Refresh for database config from version {} to version { uuid: UUID("a0900c6c-da82-4a26-b932-d5eee62df9d0"), lastMod: 0 } took 3 ms
	2021-05-31T06:05:52.062+0800 I  CONNPOOL [ShardRegistry] Connecting to 192.168.0.203:21000
	2021-05-31T06:05:52.064+0800 I  CONTROL  [LogicalSessionCacheReap] Sessions collection is not set up; waiting until next sessions reap interval: Collection config.system.sessions is not sharded.
	2021-05-31T06:05:52.064+0800 I  CONTROL  [LogicalSessionCacheRefresh] Sessions collection is not set up; waiting until next sessions refresh interval: Collection config.system.sessions is not sharded.




	-- 查看集群的信息
	
	mongos> sh.status()    
	--- Sharding Status --- 
	  sharding version: {
		"_id" : 1,
		"minCompatibleVersion" : 5,
		"currentVersion" : 6,
		"clusterId" : ObjectId("60b3d7e937728f7d80dc3200")
	  }
	  shards:
	  active mongoses:
	  autosplit:
			Currently enabled: yes
	  balancer:
			Currently enabled:  yes
			Currently running:  no
			Failed balancer rounds in last 5 attempts:  0
			Migration Results for the last 24 hours: 
					No recent migrations
	  databases:
			{  "_id" : "config",  "primary" : "config",  "partitioned" : true }



		
5. 设置三节点的分片和路由配置服务器串联成集群
	
	先启动配置服务器和分片服务器， 后启动路由实例启动路由实例:
	
	
	登陆任意一台mongos

	mongo --host 192.168.0.201 --port 20000

	#使用admin数据库

	use admin

	#串联 路由服务器 与 分片副本集 -----------------------------------------------

	sh.addShard("shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016")

	sh.addShard("shard2/192.168.0.201:27018,192.168.0.202:27018,192.168.0.203:27018")

	sh.addShard("shard3/192.168.0.201:27019,192.168.0.202:27019,192.168.0.203:27019")



	#查看集群状态

	sh.status()

	报错1：
		mongos> sh.addShard("shard1/192.168.0.54:27001,192.168.0.55:27001,192.168.0.56:27001")
		{
			"ok" : 0,
			"errmsg" : "failed to satisfy writeConcern for command { update: \"system.version\", bypassDocumentValidation: false, ordered: true, updates: [ { q: { _id: \"shardIdentity\", shardName: \"shard1\", clusterId: ObjectId('5bd952b0ebca002718ee668f') }, u: { $set: { configsvrConnectionString: \"myshard/192.168.0.54:21000,192.168.0.55:21000,192.168.0.56:21000\" } }, multi: false, upsert: true } ], writeConcern: { w: \"majority\", wtimeout: 15000 } } when attempting to add shard shard1/192.168.0.54:27001,192.168.0.55:27001 :: caused by :: WriteConcernFailed: waiting for replication timed out. Error details: { wtimeout: true }",
			"code" : 96,
			"codeName" : "OperationFailed",
			"operationTime" : Timestamp(1541028304, 1),
			"$clusterTime" : {
				"clusterTime" : Timestamp(1541028304, 1),
				"signature" : {
					"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
					"keyId" : NumberLong(0)
				}
			}
		}

		解决办法：
			需要再执行一次  sh.addShard("shard1/192.168.0.54:27001,192.168.0.55:27001,192.168.0.56:27001") 就好了。
			


	报错2：
		mongos> sh.addShard("shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016")
		{
			"ok" : 0,
			"errmsg" : "Cannot add shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016 as a shard since it is a config server",
			-- mongodb 无法添加为分片，因为它是配置服务器 
			"code" : 96,
			"codeName" : "OperationFailed",
			"operationTime" : Timestamp(1622412622, 1),
			"$clusterTime" : {
				"clusterTime" : Timestamp(1622412622, 1),
				"signature" : {
					"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
					"keyId" : NumberLong(0)
				}
			}
		}



		2021-05-31T06:57:36.281+0800 I  NETWORK  [conn25] Starting new replica set monitor for shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016
		2021-05-31T06:57:36.282+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for shard1 is shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016
		2021-05-31T06:57:36.282+0800 I  NETWORK  [conn25] Removed ReplicaSetMonitor for replica set shard1
		2021-05-31T06:57:36.282+0800 I  SHARDING [conn25] addShard request 'AddShardRequest shard: shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016'failed :: caused by :: OperationFailed: Cannot add shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016 as a shard since it is a config server

		
		-- 应该是配置不对，是的， 要把 configsvr=true 改为  shardsvr=true 。


		

	
	mongos> sh.status()
	--- Sharding Status --- 
	  sharding version: {
		"_id" : 1,
		"minCompatibleVersion" : 5,
		"currentVersion" : 6,
		"clusterId" : ObjectId("60b422603cd71bde20721c1e")
	  }
	  shards:
			{  "_id" : "shard1",  "host" : "shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016",  "state" : 1 }
			{  "_id" : "shard2",  "host" : "shard2/192.168.0.201:27018,192.168.0.202:27018,192.168.0.203:27018",  "state" : 1 }
			{  "_id" : "shard3",  "host" : "shard3/192.168.0.201:27019,192.168.0.202:27019,192.168.0.203:27019",  "state" : 1 }
	  active mongoses:
			"4.2.7" : 1
	  autosplit:
			Currently enabled: yes
	  balancer:
			Currently enabled:  yes
			Currently running:  no
			Failed balancer rounds in last 5 attempts:  0
			Migration Results for the last 24 hours: 
					276 : Success
	  databases:
			{  "_id" : "config",  "primary" : "config",  "partitioned" : true }
					config.system.sessions
							shard key: { "_id" : 1 }
							unique: false
							balancing: true
							chunks:
									shard1	748
									shard2	274
									shard3	2
							too many chunks to print, use verbose if you want to force print


---------------------------------------------------------------------------------------------------------------------------------------------------


6. 验证分片

	mongos> use config;
	switched to db config
	mongos> db.shards.find()
	{ "_id" : "shard1", "host" : "shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016", "state" : 1 }
	{ "_id" : "shard2", "host" : "shard2/192.168.0.201:27018,192.168.0.202:27018,192.168.0.203:27018", "state" : 1 }
	{ "_id" : "shard3", "host" : "shard3/192.168.0.201:27019,192.168.0.202:27019,192.168.0.203:27019", "state" : 1 }



7. 启用分片

7.1 哈希分片
	
	use admin
	sh.enableSharding("01_db")

	###片键必须是一个索引，通过sh.shardCollection加会自动创建索引（前提是此集合不存在的情况下）:
	sh.shardCollection("01_db.user",{userid:"hashed"})

	使用sh.status()方法或db.printShardingStatus()命令查看分片状态信息

	use 01_db
	for(i=0;i<100000;i++)(db.user.insert({"userid":i, "Date":new Date()}));



	登录到 shard 节点进行数据查看：

		shard1:PRIMARY> db.user.count()
		33755
		shard1:PRIMARY> db.user.find().limit(10)
		{ "_id" : ObjectId("60b52da39a3ffc30911d1dfc"), "userid" : 6, "Date" : ISODate("2021-05-31T18:40:35.768Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1dfe"), "userid" : 8, "Date" : ISODate("2021-05-31T18:40:35.777Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e02"), "userid" : 12, "Date" : ISODate("2021-05-31T18:40:35.786Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e0a"), "userid" : 20, "Date" : ISODate("2021-05-31T18:40:35.800Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e0b"), "userid" : 21, "Date" : ISODate("2021-05-31T18:40:35.801Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e10"), "userid" : 26, "Date" : ISODate("2021-05-31T18:40:35.811Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e11"), "userid" : 27, "Date" : ISODate("2021-05-31T18:40:35.813Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e16"), "userid" : 32, "Date" : ISODate("2021-05-31T18:40:35.860Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e17"), "userid" : 33, "Date" : ISODate("2021-05-31T18:40:35.864Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e1e"), "userid" : 40, "Date" : ISODate("2021-05-31T18:40:35.889Z") }


		shard2:PRIMARY> db.user.count()
		33142
		shard2:PRIMARY> db.user.find().limit(10)
		{ "_id" : ObjectId("60b52da39a3ffc30911d1df8"), "userid" : 2, "Date" : ISODate("2021-05-31T18:40:35.762Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1df9"), "userid" : 3, "Date" : ISODate("2021-05-31T18:40:35.764Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1dfa"), "userid" : 4, "Date" : ISODate("2021-05-31T18:40:35.766Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e01"), "userid" : 11, "Date" : ISODate("2021-05-31T18:40:35.783Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e06"), "userid" : 16, "Date" : ISODate("2021-05-31T18:40:35.794Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e0d"), "userid" : 23, "Date" : ISODate("2021-05-31T18:40:35.806Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e0e"), "userid" : 24, "Date" : ISODate("2021-05-31T18:40:35.807Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e0f"), "userid" : 25, "Date" : ISODate("2021-05-31T18:40:35.809Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e13"), "userid" : 29, "Date" : ISODate("2021-05-31T18:40:35.844Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e14"), "userid" : 30, "Date" : ISODate("2021-05-31T18:40:35.845Z") }


		shard3:PRIMARY> db.user.count()
		33103
		shard3:PRIMARY> db.user.find().limit(10)
		{ "_id" : ObjectId("60b52da39a3ffc30911d1df6"), "userid" : 0, "Date" : ISODate("2021-05-31T18:40:35.666Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1df7"), "userid" : 1, "Date" : ISODate("2021-05-31T18:40:35.760Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1dfb"), "userid" : 5, "Date" : ISODate("2021-05-31T18:40:35.767Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1dfd"), "userid" : 7, "Date" : ISODate("2021-05-31T18:40:35.771Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1dff"), "userid" : 9, "Date" : ISODate("2021-05-31T18:40:35.779Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e00"), "userid" : 10, "Date" : ISODate("2021-05-31T18:40:35.782Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e03"), "userid" : 13, "Date" : ISODate("2021-05-31T18:40:35.789Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e04"), "userid" : 14, "Date" : ISODate("2021-05-31T18:40:35.791Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e05"), "userid" : 15, "Date" : ISODate("2021-05-31T18:40:35.793Z") }
		{ "_id" : ObjectId("60b52da39a3ffc30911d1e07"), "userid" : 17, "Date" : ISODate("2021-05-31T18:40:35.795Z") }

		-- 哈希分片，相对均匀。
		
		

	-- 查看分片情况
		use config
		db.databases.find()
		db.chunks.find({"ns": "01_db.user"})
		db.user.count()	

		mongos> use config
		switched to db config
		mongos> db.databases.find()
		{ "_id" : "posdb", "primary" : "shard3", "partitioned" : true, "version" : { "uuid" : UUID("d28c0ca4-b67f-4d83-b3a2-925502d4d89d"), "lastMod" : 1 } }
		{ "_id" : "postdb", "primary" : "shard2", "partitioned" : false, "version" : { "uuid" : UUID("a7403db3-72a9-4b86-b8cb-1cba563d92ac"), "lastMod" : 1 } }
		{ "_id" : "shardtest_db", "primary" : "shard2", "partitioned" : true, "version" : { "uuid" : UUID("8cdc2c7e-1e2f-4a77-8377-0a82558be285"), "lastMod" : 1 } }
		{ "_id" : "shard_db", "primary" : "shard2", "partitioned" : true, "version" : { "uuid" : UUID("b227f552-abda-4860-901f-9991b48c6743"), "lastMod" : 1 } }
		{ "_id" : "1008_db", "primary" : "shard2", "partitioned" : true, "version" : { "uuid" : UUID("a0b83dcb-0ec9-4456-9863-480105f78d17"), "lastMod" : 1 } }
		{ "_id" : "01_db", "primary" : "shard3", "partitioned" : true, "version" : { "uuid" : UUID("490e3c88-94b8-412d-9c33-f3cf95ccdc4a"), "lastMod" : 1 } }
		mongos> db.chunks.find({"ns": "01_db.user"})
		{ "_id" : "01_db.user-userid_MinKey", "ns" : "01_db.user", "min" : { "userid" : { "$minKey" : 1 } }, "max" : { "userid" : NumberLong("-6148914691236517204") }, "shard" : "shard1", "lastmod" : Timestamp(1, 0), "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "history" : [ { "validAfter" : Timestamp(1622486420, 6), "shard" : "shard1" } ] }
		{ "_id" : "01_db.user-userid_-6148914691236517204", "ns" : "01_db.user", "min" : { "userid" : NumberLong("-6148914691236517204") }, "max" : { "userid" : NumberLong("-3074457345618258602") }, "shard" : "shard1", "lastmod" : Timestamp(1, 1), "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "history" : [ { "validAfter" : Timestamp(1622486420, 6), "shard" : "shard1" } ] }
		{ "_id" : "01_db.user-userid_-3074457345618258602", "ns" : "01_db.user", "min" : { "userid" : NumberLong("-3074457345618258602") }, "max" : { "userid" : NumberLong(0) }, "shard" : "shard2", "lastmod" : Timestamp(1, 2), "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "history" : [ { "validAfter" : Timestamp(1622486420, 6), "shard" : "shard2" } ] }
		{ "_id" : "01_db.user-userid_0", "ns" : "01_db.user", "min" : { "userid" : NumberLong(0) }, "max" : { "userid" : NumberLong("3074457345618258602") }, "shard" : "shard2", "lastmod" : Timestamp(1, 3), "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "history" : [ { "validAfter" : Timestamp(1622486420, 6), "shard" : "shard2" } ] }
		{ "_id" : "01_db.user-userid_3074457345618258602", "ns" : "01_db.user", "min" : { "userid" : NumberLong("3074457345618258602") }, "max" : { "userid" : NumberLong("6148914691236517204") }, "shard" : "shard3", "lastmod" : Timestamp(1, 4), "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "history" : [ { "validAfter" : Timestamp(1622486420, 6), "shard" : "shard3" } ] }
		{ "_id" : "01_db.user-userid_6148914691236517204", "ns" : "01_db.user", "min" : { "userid" : NumberLong("6148914691236517204") }, "max" : { "userid" : { "$maxKey" : 1 } }, "shard" : "shard3", "lastmod" : Timestamp(1, 5), "lastmodEpoch" : ObjectId("60b52d94813b999acac173b6"), "history" : [ { "validAfter" : Timestamp(1622486420, 6), "shard" : "shard3" } ] }

		mongos> db.user.count()
		100000

	-- 通过sh.status()直观的查看分片情况：

		mongos> use 01_db
		switched to db 01_db
		mongos> sh.status()
		--- Sharding Status --- 
		  sharding version: {
			"_id" : 1,
			"minCompatibleVersion" : 5,
			"currentVersion" : 6,
			"clusterId" : ObjectId("60b422603cd71bde20721c1e")
		  }
		  shards:
				{  "_id" : "shard1",  "host" : "shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016",  "state" : 1 }
				{  "_id" : "shard2",  "host" : "shard2/192.168.0.201:27018,192.168.0.202:27018,192.168.0.203:27018",  "state" : 1 }
				{  "_id" : "shard3",  "host" : "shard3/192.168.0.201:27019,192.168.0.202:27019,192.168.0.203:27019",  "state" : 1 }
		  active mongoses:
				"4.2.7" : 1
		  autosplit:
				Currently enabled: yes
		  balancer:
				Currently enabled:  yes
				Currently running:  no
				Failed balancer rounds in last 5 attempts:  0
				Migration Results for the last 24 hours: 
						682 : Success
		  databases:
				{  "_id" : "01_db",  "primary" : "shard3",  "partitioned" : true,  "version" : {  "uuid" : UUID("490e3c88-94b8-412d-9c33-f3cf95ccdc4a"),  "lastMod" : 1 } }
						01_db.user
								shard key: { "userid" : "hashed" }
								unique: false
								balancing: true
								chunks:
										shard1	2
										shard2	2
										shard3	2
								{ "userid" : { "$minKey" : 1 } } -->> { "userid" : NumberLong("-6148914691236517204") } on : shard1 Timestamp(1, 0) 
								{ "userid" : NumberLong("-6148914691236517204") } -->> { "userid" : NumberLong("-3074457345618258602") } on : shard1 Timestamp(1, 1) 
								{ "userid" : NumberLong("-3074457345618258602") } -->> { "userid" : NumberLong(0) } on : shard2 Timestamp(1, 2) 
								{ "userid" : NumberLong(0) } -->> { "userid" : NumberLong("3074457345618258602") } on : shard2 Timestamp(1, 3) 
								{ "userid" : NumberLong("3074457345618258602") } -->> { "userid" : NumberLong("6148914691236517204") } on : shard3 Timestamp(1, 4) 
								{ "userid" : NumberLong("6148914691236517204") } -->> { "userid" : { "$maxKey" : 1 } } on : shard3 Timestamp(1, 5) 
				{  "_id" : "1008_db",  "primary" : "shard2",  "partitioned" : true,  "version" : {  "uuid" : UUID("a0b83dcb-0ec9-4456-9863-480105f78d17"),  "lastMod" : 1 } }



7.2 范围分片1

	use admin
	sh.enableSharding("02_db")
	sh.shardCollection("02_db.user",{id:1})

	use 02_db

	for(i=0;i<100000;i++)(db.user.insert({"id":i, "Date":new Date()}));



	use config
	db.databases.find()
	db.chunks.find({"ns": "02_db.user"})
	db.user.count()	


	mongos> use config
	switched to db config
	mongos> db.databases.find()
	{ "_id" : "posdb", "primary" : "shard3", "partitioned" : true, "version" : { "uuid" : UUID("d28c0ca4-b67f-4d83-b3a2-925502d4d89d"), "lastMod" : 1 } }
	{ "_id" : "postdb", "primary" : "shard2", "partitioned" : false, "version" : { "uuid" : UUID("a7403db3-72a9-4b86-b8cb-1cba563d92ac"), "lastMod" : 1 } }
	{ "_id" : "shardtest_db", "primary" : "shard2", "partitioned" : true, "version" : { "uuid" : UUID("8cdc2c7e-1e2f-4a77-8377-0a82558be285"), "lastMod" : 1 } }
	{ "_id" : "shard_db", "primary" : "shard2", "partitioned" : true, "version" : { "uuid" : UUID("b227f552-abda-4860-901f-9991b48c6743"), "lastMod" : 1 } }
	{ "_id" : "1008_db", "primary" : "shard2", "partitioned" : true, "version" : { "uuid" : UUID("a0b83dcb-0ec9-4456-9863-480105f78d17"), "lastMod" : 1 } }
	{ "_id" : "01_db", "primary" : "shard3", "partitioned" : true, "version" : { "uuid" : UUID("490e3c88-94b8-412d-9c33-f3cf95ccdc4a"), "lastMod" : 1 } }
	{ "_id" : "02_db", "primary" : "shard1", "partitioned" : true, "version" : { "uuid" : UUID("dbcdb56b-2f3f-4523-a6d1-eacab67d00c4"), "lastMod" : 1 } }
	mongos> db.chunks.find({"ns": "02_db.user"})
	{ "_id" : "02_db.user-id_MinKey", "ns" : "02_db.user", "min" : { "id" : { "$minKey" : 1 } }, "max" : { "id" : { "$maxKey" : 1 } }, "shard" : "shard1", "lastmod" : Timestamp(1, 0), "lastmodEpoch" : ObjectId("60b5382629a21eaeea79c904"), "history" : [ { "validAfter" : Timestamp(1622489126, 10), "shard" : "shard1" } ] }
	mongos> db.user.count()
	0
	mongos> use 02_db
	switched to db 02_db
	mongos> db.user.count()
	100000
	
	
	mongos> sh.status()
	--- Sharding Status --- 
	  sharding version: {
		"_id" : 1,
		"minCompatibleVersion" : 5,
		"currentVersion" : 6,
		"clusterId" : ObjectId("60b422603cd71bde20721c1e")
	  }
	  shards:
			{  "_id" : "shard1",  "host" : "shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016",  "state" : 1 }
			{  "_id" : "shard2",  "host" : "shard2/192.168.0.201:27018,192.168.0.202:27018,192.168.0.203:27018",  "state" : 1 }
			{  "_id" : "shard3",  "host" : "shard3/192.168.0.201:27019,192.168.0.202:27019,192.168.0.203:27019",  "state" : 1 }
	  active mongoses:
			"4.2.7" : 1
	  autosplit:
			Currently enabled: yes
	  balancer:
			Currently enabled:  yes
			Currently running:  no
			Failed balancer rounds in last 5 attempts:  0
			Migration Results for the last 24 hours: 
					682 : Success
	  databases:
		
			{  "_id" : "02_db",  "primary" : "shard1",  "partitioned" : true,  "version" : {  "uuid" : UUID("dbcdb56b-2f3f-4523-a6d1-eacab67d00c4"),  "lastMod" : 1 } }
					02_db.user
							shard key: { "id" : 1 }
							unique: false
							balancing: true
							chunks:
									shard1	1
							{ "id" : { "$minKey" : 1 } } -->> { "id" : { "$maxKey" : 1 } } on : shard1 Timestamp(1, 0) 







7.3 范围分片2

	use admin
	sh.enableSharding("03_db")
	sh.shardCollection("03_db.user",{id:1})
	
	use 03_db
	for(i=0;i<300000;i++)(db.user.insert({"id":i, "name": "range key", "Date":new Date()}));

	
	mongos> db.user.count()
	300000
	
	shard3:PRIMARY> use 03_db
	switched to db 03_db
	shard3:PRIMARY> db.user.count()
	300000
	
	-- 数据全部落在 shard3 上了。
	

7.4 不需要分片的集合

	use 04_db
	for(i=0;i<300000;i++)(db.user.insert({"id":i, "name": "not shard key", "Date":new Date()}));


	
	mongos> db.user.count()
	500000

	shard2:SECONDARY> db.user.count()
	500000

	shard1:SECONDARY> show dbs
	01_db   0.002GB
	02_db   0.005GB
	admin   0.000GB
	config  0.001GB
	local   0.005GB
	
	-- 对不需要分片的集合，默认落在任意1个节点上吗？
		是的。
		
	没有分片的集合是会随机找个shard 复制集存吗？
	作者回复: mongos在你新建库的时候会为你的库挑一个“primary shard”，所有未分片的集合都会在这个shard里面。挑选的规则就是看哪个分片相对数据量小一点。
	
