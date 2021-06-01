

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

4. 安装 mongos
	
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


4. 设置Mongs路由服务器

	先启动配置服务器和分片服务器， 后启动路由实例启动路由实例:

		
5. 设置三节点的分片和路由配置服务器串联成集群

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

测试1 

	db.runCommand( { enablesharding :"posdb"});  #设置POSDB数据库分片生效

	#设置数据库posdb里test表根据id自动分片到shard1,2,3中
	#db.runCommand( { shardcollection : "库名.集合名",key : {id: 1} } )

	db.runCommand( { shardcollection : "posdb.testc_co",key : {id: 1} } )



	use  posdb;

	for (var i = 1; i <= 100000; i++){
		db.test.save({id:i,"test":"val1"});
	}
	db.table1.stats();

	-----------------------------
	

	
	mongos> show dbs
	admin   0.000GB
	config  0.003GB
	mongos> use admin
	switched to db admin
	mongos> db.runCommand( { enablesharding :"posdb"});
	{
		"ok" : 1,
		"operationTime" : Timestamp(1622424451, 7),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1622424451, 7),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}
	mongos> show dbs
	admin   0.000GB
	config  0.003GB

	
	
	mongos> db.runCommand( { shardcollection : "posdb.testc_co",key : {id: 1} } )
	{
		"collectionsharded" : "posdb.testc_co",
		"collectionUUID" : UUID("ba2d69ec-7790-46c2-8100-15c2026eb718"),
		"ok" : 1,
		"operationTime" : Timestamp(1622424542, 14),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1622424542, 14),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}




	use  posdb;
	
	
	for (var i = 1; i <= 20; i++){
		db.testc_co.save({id:i,"test":"val1"});
	}
		
	mongos> db.testc_co.count()
	20


	db.testc_co.stats();
	




-------------------------------------------------------------------------------------
	
测试2	

	use admin
	sh.enableSharding("shard_db")
	db.runCommand( { enablesharding :"shard_db"});
	sh.shardCollection("shard_db.user",{userid:"hashed"})
	for(i=0;i<10;i++)(db.user.insert({"userid":i}));
		
		
	mongos> use admin
	switched to db admin
	mongos> sh.enableSharding("shard_db")
	{
		"ok" : 1,
		"operationTime" : Timestamp(1622427438, 7),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1622427438, 7),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}
	mongos> db.runCommand( { enablesharding :"shard_db"});
	{
		"ok" : 1,
		"operationTime" : Timestamp(1622427438, 9),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1622427438, 9),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}
	mongos> sh.shardCollection("shard_db.user",{userid:"hashed"})

	{
		"collectionsharded" : "shard_db.user",
		"collectionUUID" : UUID("39e709b5-d758-408e-a41b-0ef633625704"),
		"ok" : 1,
		"operationTime" : Timestamp(1622427439, 36),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1622427439, 36),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}
	mongos> for(i=0;i<10;i++)(db.user.insert({"userid":i}));
	WriteResult({ "nInserted" : 1 })

	
	db.user.stats()
	db.printShardingStatus()
	
	
	mongos> db.printShardingStatus()
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
			{  "_id" : "config",  "primary" : "config",  "partitioned" : true }
					config.system.sessions
							shard key: { "_id" : 1 }
							unique: false
							balancing: true
							chunks:
									shard1	342
									shard2	341
									shard3	341
							too many chunks to print, use verbose if you want to force print
			{  "_id" : "posdb",  "primary" : "shard3",  "partitioned" : true,  "version" : {  "uuid" : UUID("d28c0ca4-b67f-4d83-b3a2-925502d4d89d"),  "lastMod" : 1 } }
					posdb.testc_co
							shard key: { "id" : 1 }
							unique: false
							balancing: true
							chunks:
									shard3	1
							{ "id" : { "$minKey" : 1 } } -->> { "id" : { "$maxKey" : 1 } } on : shard3 Timestamp(1, 0) 
			{  "_id" : "postdb",  "primary" : "shard2",  "partitioned" : false,  "version" : {  "uuid" : UUID("a7403db3-72a9-4b86-b8cb-1cba563d92ac"),  "lastMod" : 1 } }
			{  "_id" : "shard_db",  "primary" : "shard2",  "partitioned" : true,  "version" : {  "uuid" : UUID("b227f552-abda-4860-901f-9991b48c6743"),  "lastMod" : 1 } }
					shard_db.user
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
			{  "_id" : "shardtest_db",  "primary" : "shard2",  "partitioned" : true,  "version" : {  "uuid" : UUID("8cdc2c7e-1e2f-4a77-8377-0a82558be285"),  "lastMod" : 1 } }
					shardtest_db.user
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

	mongos> 



-------------------------------------------------------------------------------------	
	
10) 查看分片数据：

mongos> db.account.stats() #查看集合的分布情况



测试1）

use  test2db;

#指定testdb分片生效
db.runCommand( { enablesharding :"test2db"});
#指定数据库里需要分片的集合和片键
db.runCommand( { shardcollection : "test2db.table1",key : {id: 1} } )

for (var i = 1; i <= 10000000; i++){
	db.table1.save({id:i,"test1":"testvall"});
}


#指定testdb分片生效
db.runCommand( { enablesharding :"test3db"});
#指定数据库里需要分片的集合和片键
db.runCommand( { shardcollection : "test3db.table3",key : {id: 1} } )

for (var i = 1; i <= 200000; i++){
	db.table3.save({id:i,"table3":"testvall"});
}


config.settings 集合里主要存储sharded cluster的配置信息，比如chunk size，是否开启balancer等

mongos> db.settings.find()
{ "_id" : "balancer", "mode" : "full", "stopped" : false }
{ "_id" : "chunksize", "value" : 2 }

balancer
sh.setBalancerState(true)
db.settings.save( { _id:"chunksize", value: 64 } );




测试2）------- OK
use shardtest
use admin
mongos> sh.enableSharding("shardtest")
db.runCommand( { enablesharding :"shardtest"});

use admin

###片键必须是一个索引，通过sh.shardCollection加会自动创建索引（前提是此集合不存在的情况下）:
sh.shardCollection("shardtest.user",{userid:"hashed"})

使用sh.status()方法或db.printShardingStatus()命令查看分片状态信息

for(i=0;i<100000;i++)(db.user.insert({"userid":i}));

登录到 shard 节点进行数据查看：
shard1:PRIMARY> use shardtest
switched to db shardtest
shard1:PRIMARY> db.user.count()
33755


参考：
https://www.cnblogs.com/mysql-dba/p/5057559.html

http://www.mongoing.com/archives/2782



总结:

Sharding 启动顺序:
mongod -f /data/mongodb/conf/config.conf
mongod -f /data/mongodb/conf/shard1.conf
mongos -f /data/mongodb/conf/mongos.conf