1. mongos 的配置
2. config server的配置
3. config server的主节点发生故障	
4. 查看config server的选举	



1. mongos 的配置	
	-rw-r--r--. 1 root root 409 5月  31 08:54 router.conf
	[root@localhost conf]# cat router.conf 


	systemLog:
	  destination: file
	  logAppend: true
	  path: /home/mongodb/router/log/mongos.log
	# network interfaces

	net:
	  port: 20000
	  # 允许所有连接
	  bindIp: 0.0.0.0
	# how the process runs
	processManagement:
	  fork: true

	#监听的配置服务器,只能有1个或者3个 config 为配置服务器的副本集名字
	sharding:
	  configDB: configserver/192.168.0.201:21000
	  
	
2. config server的配置
		
	IP			   	 		   		

	192.168.0.201			config: 21000主节点  	     
	192.168.0.202 			config: 21000副节点
	192.168.0.203			config: 21000副节点	
	


3. config server的主节点发生故障	
	
连接到mongos
	

	use admin
	sh.enableSharding("05_db")

	###片键必须是一个索引，通过sh.shardCollection加会自动创建索引（前提是此集合不存在的情况下）:
	sh.shardCollection("05_db.user",{userid:"hashed"})

	使用sh.status()方法或db.printShardingStatus()命令查看分片状态信息
				
	mongos                         mongos                                    				
	use 05_db
	for(i=0;i<100000;i++)(db.user.insert({"userid":i, "Date":new Date()}));
																			[root@localhost conf]# ps aux|grep config.conf
																			root      1894  1.8  9.7 2063492 99080 ?       Sl   01:50   0:05 /usr/local/mongodb/bin/mongod --config /etc/config.conf
																			root      2087  0.0  0.0 112668   980 pts/4    R+   01:55   0:00 grep --color=auto config.conf
																			[root@localhost conf]# kill 1894
																			[root@localhost conf]# ps aux|grep config.conf
																			root      2111  0.0  0.0 112668   980 pts/4    R+   01:56   0:00 grep --color=auto config.conf



									-- 查看数据能否正确写入
									mongos> use 05_db
									switched to db 05_db
									mongos> show collections
									user
									mongos> db.user.count()
									9292
									mongos> db.user.count()
									9407
									mongos> db.user.count()
									9714
	
	-- 查看数据的分片情况
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
						No recent migrations
		  databases:
				{  "_id" : "05_db",  "primary" : "shard1",  "partitioned" : true,  "version" : {  "uuid" : UUID("7da0b325-ba92-470e-8041-99dd77ee8bb9"),  "lastMod" : 1 } }
						05_db.user
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

	
	
4. 查看config server的选举	
	192.168.0.202:21000 已成为主节点
	configserver:PRIMARY> rs.status()
	{
		"set" : "configserver",
		"date" : ISODate("2021-06-01T17:57:50.748Z"),
		"myState" : 1,
		"members" : [
			{
				"_id" : 0,
				"name" : "192.168.0.201:21000",
				"health" : 0,
				"state" : 8,
				"stateStr" : "(not reachable/healthy)",
				"uptime" : 0,
				"optime" : {
					"ts" : Timestamp(0, 0),
					"t" : NumberLong(-1)
				},
				"optimeDurable" : {
					"ts" : Timestamp(0, 0),
					"t" : NumberLong(-1)
				},
				"optimeDate" : ISODate("1970-01-01T00:00:00Z"),
				"optimeDurableDate" : ISODate("1970-01-01T00:00:00Z"),
				"lastHeartbeat" : ISODate("2021-06-01T17:57:50.195Z"),
				"lastHeartbeatRecv" : ISODate("2021-06-01T17:55:54.930Z"),
				"pingMs" : NumberLong(1),
				"lastHeartbeatMessage" : "Error connecting to 192.168.0.201:21000 :: caused by :: Connection refused",
				"syncingTo" : "",
				"syncSourceHost" : "",
				"syncSourceId" : -1,
				"infoMessage" : "",
				"configVersion" : -1
			},
			{
				"_id" : 1,
				"name" : "192.168.0.202:21000",
				"health" : 1,
				"state" : 1,
				"stateStr" : "PRIMARY",
				"uptime" : 286,
				"optime" : {
					"ts" : Timestamp(1622570269, 1),
					"t" : NumberLong(4)
				},
				"optimeDate" : ISODate("2021-06-01T17:57:49Z"),
				"syncingTo" : "",
				"syncSourceHost" : "",
				"syncSourceId" : -1,
				"infoMessage" : "",
				"electionTime" : Timestamp(1622570155, 1),
				"electionDate" : ISODate("2021-06-01T17:55:55Z"),
				"configVersion" : 1,
				"self" : true,
				"lastHeartbeatMessage" : ""
			},
			{
				"_id" : 2,
				"name" : "192.168.0.203:21000",
				"health" : 1,
				"state" : 2,
				"stateStr" : "SECONDARY",
				"uptime" : 281,
				"optime" : {
					"ts" : Timestamp(1622570269, 1),
					"t" : NumberLong(4)
				},
				"optimeDurable" : {
					"ts" : Timestamp(1622570269, 1),
					"t" : NumberLong(4)
				},
				"optimeDate" : ISODate("2021-06-01T17:57:49Z"),
				"optimeDurableDate" : ISODate("2021-06-01T17:57:49Z"),
				"lastHeartbeat" : ISODate("2021-06-01T17:57:50.047Z"),
				"lastHeartbeatRecv" : ISODate("2021-06-01T17:57:50.185Z"),
				"pingMs" : NumberLong(1),
				"lastHeartbeatMessage" : "",
				"syncingTo" : "192.168.0.202:21000",
				"syncSourceHost" : "192.168.0.202:21000",
				"syncSourceId" : 1,
				"infoMessage" : "",
				"configVersion" : 1
			}
		],
	}

	-- 192.168.0.201:21000 恢复后，自动变成了从节点 
	"members" : [
		{
			"_id" : 0,
			"name" : "192.168.0.201:21000",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 11,
			"optime" : {
				"ts" : Timestamp(1622570601, 1),
				"t" : NumberLong(4)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622570601, 1),
				"t" : NumberLong(4)
			},
			"optimeDate" : ISODate("2021-06-01T18:03:21Z"),
			"optimeDurableDate" : ISODate("2021-06-01T18:03:21Z"),
			"lastHeartbeat" : ISODate("2021-06-01T18:03:25.170Z"),
			"lastHeartbeatRecv" : ISODate("2021-06-01T18:03:26.608Z"),
			"pingMs" : NumberLong(1),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.203:21000",
			"syncSourceHost" : "192.168.0.203:21000",
			"syncSourceId" : 2,
			"infoMessage" : "",
			"configVersion" : 1
		},
		{
			"_id" : 1,
			"name" : "192.168.0.202:21000",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 623,
			"optime" : {
				"ts" : Timestamp(1622570606, 2),
				"t" : NumberLong(4)
			},
			"optimeDate" : ISODate("2021-06-01T18:03:26Z"),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "",
			"electionTime" : Timestamp(1622570155, 1),
			"electionDate" : ISODate("2021-06-01T17:55:55Z"),
			"configVersion" : 1,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 2,
			"name" : "192.168.0.203:21000",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 618,
			"optime" : {
				"ts" : Timestamp(1622570606, 2),
				"t" : NumberLong(4)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622570606, 2),
				"t" : NumberLong(4)
			},
			"optimeDate" : ISODate("2021-06-01T18:03:26Z"),
			"optimeDurableDate" : ISODate("2021-06-01T18:03:26Z"),
			"lastHeartbeat" : ISODate("2021-06-01T18:03:26.449Z"),
			"lastHeartbeatRecv" : ISODate("2021-06-01T18:03:26.604Z"),
			"pingMs" : NumberLong(1),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.202:21000",
			"syncSourceHost" : "192.168.0.202:21000",
			"syncSourceId" : 1,
			"infoMessage" : "",
			"configVersion" : 1
		}
	],

