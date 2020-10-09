


架构如下:
192.168.0.242 (主库)
192.168.0.252  (副本)
192.168.0.241 (仲裁) 


2. 架构2 --1主1从加一个仲裁者


2.1 配置
	修改配置文件，加上这一行
		replSet=repl_set



	强制重新配置： re.reconfig(config, {"force" : true})


	> configs={_id:"repl_set",members:[{_id:0,host:"192.168.0.242:27017",priority:90},{_id:1,host:"192.168.0.252:27017",priority:90},{_id:2,host:"192.168.0.241:27017",arbiterOnly:true}]};
	{
		"_id" : "repl_set",
		"members" : [
			{
				"_id" : 0,
				"host" : "192.168.0.242:27017",
				"priority" : 90
			},
			{
				"_id" : 1,
				"host" : "192.168.0.252:27017",
				"priority" : 90
			},
			{
				"_id" : 2,
				"host" : "192.168.0.241:27017",
				"arbiterOnly" : true
			}
		]
	}
	> 
	> 
	> rs.initiate(configs);
	{
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592474892, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		},
		"operationTime" : Timestamp(1592474892, 1)
	}



	repl_set:SECONDARY> rs.status()
	{
		"set" : "repl_set",
		"date" : ISODate("2020-06-18T10:08:33.117Z"),
		"myState" : 1,
		"term" : NumberLong(1),
		"syncingTo" : "",
		"syncSourceHost" : "",
		"syncSourceId" : -1,
		"heartbeatIntervalMillis" : NumberLong(2000),
		"majorityVoteCount" : 2,
		"writeMajorityCount" : 2,
		"optimes" : {
			"lastCommittedOpTime" : {
				"ts" : Timestamp(1592474904, 1),
				"t" : NumberLong(1)
			},
			"lastCommittedWallTime" : ISODate("2020-06-18T10:08:24.219Z"),
			"readConcernMajorityOpTime" : {
				"ts" : Timestamp(1592474904, 1),
				"t" : NumberLong(1)
			},
			"readConcernMajorityWallTime" : ISODate("2020-06-18T10:08:24.219Z"),
			"appliedOpTime" : {
				"ts" : Timestamp(1592474904, 1),
				"t" : NumberLong(1)
			},
			"durableOpTime" : {
				"ts" : Timestamp(1592474904, 1),
				"t" : NumberLong(1)
			},
			"lastAppliedWallTime" : ISODate("2020-06-18T10:08:24.219Z"),
			"lastDurableWallTime" : ISODate("2020-06-18T10:08:24.219Z")
		},
		"lastStableRecoveryTimestamp" : Timestamp(1592474903, 3),
		"lastStableCheckpointTimestamp" : Timestamp(1592474903, 3),
		"electionCandidateMetrics" : {
			"lastElectionReason" : "electionTimeout",
			"lastElectionDate" : ISODate("2020-06-18T10:08:22.949Z"),
			"electionTerm" : NumberLong(1),
			"lastCommittedOpTimeAtElection" : {
				"ts" : Timestamp(0, 0),
				"t" : NumberLong(-1)
			},
			"lastSeenOpTimeAtElection" : {
				"ts" : Timestamp(1592474892, 1),
				"t" : NumberLong(-1)
			},
			"numVotesNeeded" : 2,
			"priorityAtElection" : 90,
			"electionTimeoutMillis" : NumberLong(10000),
			"numCatchUpOps" : NumberLong(0),
			"newTermStartDate" : ISODate("2020-06-18T10:08:23.224Z"),
			"wMajorityWriteAvailabilityDate" : ISODate("2020-06-18T10:08:24.027Z")
		},
		"members" : [
			{
				"_id" : 0,
				"name" : "192.168.0.242:27017",
				"health" : 1,
				"state" : 1,
				"stateStr" : "PRIMARY",
				"uptime" : 187,
				"optime" : {
					"ts" : Timestamp(1592474904, 1),
					"t" : NumberLong(1)
				},
				"optimeDate" : ISODate("2020-06-18T10:08:24Z"),
				"syncingTo" : "",
				"syncSourceHost" : "",
				"syncSourceId" : -1,
				"infoMessage" : "could not find member to sync from",
				"electionTime" : Timestamp(1592474903, 1),
				"electionDate" : ISODate("2020-06-18T10:08:23Z"),
				"configVersion" : 1,
				"self" : true,
				"lastHeartbeatMessage" : ""
			},
			{
				"_id" : 1,
				"name" : "192.168.0.252:27017",
				"health" : 1,
				"state" : 2,
				"stateStr" : "SECONDARY",
				"uptime" : 20,
				"optime" : {
					"ts" : Timestamp(1592474904, 1),
					"t" : NumberLong(1)
				},
				"optimeDurable" : {
					"ts" : Timestamp(1592474904, 1),
					"t" : NumberLong(1)
				},
				"optimeDate" : ISODate("2020-06-18T10:08:24Z"),
				"optimeDurableDate" : ISODate("2020-06-18T10:08:24Z"),
				"lastHeartbeat" : ISODate("2020-06-18T10:08:33.038Z"),
				"lastHeartbeatRecv" : ISODate("2020-06-18T10:08:31.812Z"),
				"pingMs" : NumberLong(0),
				"lastHeartbeatMessage" : "",
				"syncingTo" : "192.168.0.242:27017",
				"syncSourceHost" : "192.168.0.242:27017",
				"syncSourceId" : 0,
				"infoMessage" : "",
				"configVersion" : 1
			},
			{
				"_id" : 2,
				"name" : "192.168.0.241:27017",
				"health" : 1,
				"state" : 7,
				"stateStr" : "ARBITER",
				"uptime" : 20,
				"lastHeartbeat" : ISODate("2020-06-18T10:08:33.041Z"),
				"lastHeartbeatRecv" : ISODate("2020-06-18T10:08:32.696Z"),
				"pingMs" : NumberLong(0),
				"lastHeartbeatMessage" : "",
				"syncingTo" : "",
				"syncSourceHost" : "",
				"syncSourceId" : -1,
				"infoMessage" : "",
				"configVersion" : 1
			}
		],
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592474904, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		},
		"operationTime" : Timestamp(1592474904, 1)
	}


2.2 测试
	repl_set:PRIMARY> use abc_db
	switched to db abc_db
	repl_set:PRIMARY> db.foo.insert({"zhang6" : "zhang6"})
	WriteResult({ "nInserted" : 1 })
	repl_set:PRIMARY> db.foo.find()
	{ "_id" : ObjectId("5eeb3d4b55179b55f442a160"), "zhang6" : "zhang6" }

	
	rs.slaveOk()
	use abc_db
	db.foo.find()
	
	repl_set:SECONDARY> rs.slaveOk()
	repl_set:SECONDARY> use abc_db
	switched to db abc_db
	repl_set:SECONDARY> db.foo.find()
	{ "_id" : ObjectId("5eeb3d4b55179b55f442a160"), "zhang6" : "zhang6" }




2.5 授权
	
	use admin
	db.createUser( {
		user: "test_user",
		pwd: "test123456",
		roles: [ 
			{ role: "readWrite", db: "test" },
			{ role: "readWrite", db: "abc_db" }
		]
	} )
		
	db.createUser(
	  {
		user: "admin",
		pwd: "admin123456",
		roles: [ { role: "root", db: "admin" } ]
	  }
	)

	mongo --host 10.31.76.149 -u test_user -p test123456 --port 27017
		
		错误日志
			2020-06-17T11:33:45.653+0800 I  REPL     [rsBackgroundSync] waiting for 4 pings from other members before syncing
			2020-06-17T11:34:01.656+0800 I  REPL     [rsBackgroundSync] waiting for 4 pings from other members before syncing

		[root@database-03 ~]# mongo -host 10.31.76.149 -u admin -p @15admin%.
		MongoDB shell version v4.2.7

		repl_set:RECOVERING>   -- 主从都处于 RECOVERING 状态；原因： 没有配置 keyfile 认证
		
	use admin
	db.dropUser('admin')
	db.dropUser('test_user')



2.6 重新授权
		
	
		集群管理员

			db.createUser(         
			{
			user:"clusteradmin",
			pwd:"cluster123456",
			roles:[{role:"clusterAdmin",db:"admin"},{role:"clusterManager",db:"admin"},{role:"clusterMonitor",db:"admin"}]
			})

			Successfully added user: {
				"user" : "clusteradmin",
				"roles" : [
					{
						"role" : "clusterAdmin",
						"db" : "admin"
					},
					{
						"role" : "clusterManager",
						"db" : "admin"
					},
					{
						"role" : "clusterMonitor",
						"db" : "admin"
					}
				]
			}
		
		
		从库查询权限
		
			repl_set:SECONDARY> use admin
			switched to db admin
			repl_set:SECONDARY> show users;
			{
				"_id" : "admin.admin",
				"userId" : UUID("14e331b5-883f-46e5-9e3d-159eb6bb9461"),
				"user" : "admin",
				"db" : "admin",
				"roles" : [
					{
						"role" : "root",
						"db" : "admin"
					}
				],
				"mechanisms" : [
					"SCRAM-SHA-1",
					"SCRAM-SHA-256"
				]
			}
			{
				"_id" : "admin.clusteradmin",
				"userId" : UUID("cc2db5ee-2b84-409a-a9e5-1deb9f1f101e"),
				"user" : "clusteradmin",
				"db" : "admin",
				"roles" : [
					{
						"role" : "clusterAdmin",
						"db" : "admin"
					},
					{
						"role" : "clusterManager",
						"db" : "admin"
					},
					{
						"role" : "clusterMonitor",
						"db" : "admin"
					}
				],
				"mechanisms" : [
					"SCRAM-SHA-1",
					"SCRAM-SHA-256"
				]
			}
			{
				"_id" : "admin.dpc_user",
				"userId" : UUID("234e2763-8307-4df5-9047-97f41245ab5c"),
				"user" : "dpc_user",
				"db" : "admin",
				"roles" : [
					{
						"role" : "readWrite",
						"db" : "niuniuh5_modb"
					}
				],
				"mechanisms" : [
					"SCRAM-SHA-1",
					"SCRAM-SHA-256"
				]
			}
			{
				"_id" : "admin.ldg_user",
				"userId" : UUID("0add0f91-cad6-4cda-8e98-d5095bf9c512"),
				"user" : "ldg_user",
				"db" : "admin",
				"roles" : [
					{
						"role" : "readWrite",
						"db" : "niuniuh5_modb"
					},
					{
						"role" : "readWrite",
						"db" : "yldb"
					}
				],
				"mechanisms" : [
					"SCRAM-SHA-1",
					"SCRAM-SHA-256"
				]
			}
			{
				"_id" : "admin.lxb_user",
				"userId" : UUID("101f90eb-d9a1-48d6-a53e-6f00af21cb1c"),
				"user" : "lxb_user",
				"db" : "admin",
				"roles" : [
					{
						"role" : "read",
						"db" : "niuniuh5_modb"
					},
					{
						"role" : "read",
						"db" : "yldb"
					}
				],
				"mechanisms" : [
					"SCRAM-SHA-1",
					"SCRAM-SHA-256"
				]
			}



2.7 配置 keyfile 认证
	主库
		mkdir /home/mongodb/keyfile/
		openssl rand -base64 90 > /home/mongodb/keyfile/mongo.key
		
		chown -R mongodb:mongodb  /home/mongodb/keyfile
		chmod 755  /home/mongodb/keyfile
		chmod 600 /home/mongodb/keyfile/mongo.key
		
	其它节点
		mkdir /home/mongodb/keyfile/
		上传 mongo.key 文件
		chown -R mongodb:mongodb  /home/mongodb/keyfile
		chmod 755  /home/mongodb/keyfile
		chmod 600 /home/mongodb/keyfile/mongo.key


		mkdir /mydata/mongodb/keyfile/
		上传 mongo.key 文件
		chown -R mongodb:mongodb  /mydata/mongodb/keyfile
		chmod 755  /mydata/mongodb/keyfile
		chmod 600 /mydata/mongodb/keyfile/mongo.key
		
		
	修改配置文件，加上这一行
		
	所有节点的mongodb进程都要关闭，谁要成为 master 就先启动谁。
		service mongodb stop
	
	242要成为主节点，所以先启动
		service mongodb start
		
	其它节点再依次启动	
		service mongodb start
		
2.8 查看副本集状态 --rs.status()

	登录主库
		mongo admin -u admin  -p admin

	repl_set:PRIMARY> rs.status()
	{
		"set" : "repl_set",
		"date" : ISODate("2020-06-18T10:25:07.398Z"),
		"myState" : 1,
		"term" : NumberLong(2),
		"syncingTo" : "",
		"syncSourceHost" : "",
		"syncSourceId" : -1,
		"heartbeatIntervalMillis" : NumberLong(2000),
		"majorityVoteCount" : 2,
		"writeMajorityCount" : 2,
		"optimes" : {
			"lastCommittedOpTime" : {
				"ts" : Timestamp(1592475903, 1),
				"t" : NumberLong(2)
			},
			"lastCommittedWallTime" : ISODate("2020-06-18T10:25:03.814Z"),
			"readConcernMajorityOpTime" : {
				"ts" : Timestamp(1592475903, 1),
				"t" : NumberLong(2)
			},
			"readConcernMajorityWallTime" : ISODate("2020-06-18T10:25:03.814Z"),
			"appliedOpTime" : {
				"ts" : Timestamp(1592475903, 1),
				"t" : NumberLong(2)
			},
			"durableOpTime" : {
				"ts" : Timestamp(1592475903, 1),
				"t" : NumberLong(2)
			},
			"lastAppliedWallTime" : ISODate("2020-06-18T10:25:03.814Z"),
			"lastDurableWallTime" : ISODate("2020-06-18T10:25:03.814Z")
		},
		"lastStableRecoveryTimestamp" : Timestamp(1592475843, 1),
		"lastStableCheckpointTimestamp" : Timestamp(1592475843, 1),
		"electionCandidateMetrics" : {
			"lastElectionReason" : "electionTimeout",
			"lastElectionDate" : ISODate("2020-06-18T10:23:33.770Z"),
			"electionTerm" : NumberLong(2),
			"lastCommittedOpTimeAtElection" : {
				"ts" : Timestamp(0, 0),
				"t" : NumberLong(-1)
			},
			"lastSeenOpTimeAtElection" : {
				"ts" : Timestamp(1592475673, 1),
				"t" : NumberLong(1)
			},
			"numVotesNeeded" : 2,
			"priorityAtElection" : 90,
			"electionTimeoutMillis" : NumberLong(10000),
			"numCatchUpOps" : NumberLong(0),
			"newTermStartDate" : ISODate("2020-06-18T10:23:33.810Z"),
			"wMajorityWriteAvailabilityDate" : ISODate("2020-06-18T10:23:51.271Z")
		},
		"members" : [
			{
				"_id" : 0,
				"name" : "192.168.0.242:27017",
				"health" : 1,
				"state" : 1,
				"stateStr" : "PRIMARY",
				"uptime" : 181,
				"optime" : {
					"ts" : Timestamp(1592475903, 1),
					"t" : NumberLong(2)
				},
				"optimeDate" : ISODate("2020-06-18T10:25:03Z"),
				"syncingTo" : "",
				"syncSourceHost" : "",
				"syncSourceId" : -1,
				"infoMessage" : "could not find member to sync from",
				"electionTime" : Timestamp(1592475813, 1),
				"electionDate" : ISODate("2020-06-18T10:23:33Z"),
				"configVersion" : 1,
				"self" : true,
				"lastHeartbeatMessage" : ""
			},
			{
				"_id" : 1,
				"name" : "192.168.0.252:27017",
				"health" : 1,
				"state" : 2,
				"stateStr" : "SECONDARY",
				"uptime" : 75,
				"optime" : {
					"ts" : Timestamp(1592475903, 1),
					"t" : NumberLong(2)
				},
				"optimeDurable" : {
					"ts" : Timestamp(1592475903, 1),
					"t" : NumberLong(2)
				},
				"optimeDate" : ISODate("2020-06-18T10:25:03Z"),
				"optimeDurableDate" : ISODate("2020-06-18T10:25:03Z"),
				"lastHeartbeat" : ISODate("2020-06-18T10:25:05.852Z"),
				"lastHeartbeatRecv" : ISODate("2020-06-18T10:25:07.306Z"),
				"pingMs" : NumberLong(0),
				"lastHeartbeatMessage" : "",
				"syncingTo" : "192.168.0.242:27017",
				"syncSourceHost" : "192.168.0.242:27017",
				"syncSourceId" : 0,
				"infoMessage" : "",
				"configVersion" : 1
			},
			{
				"_id" : 2,
				"name" : "192.168.0.241:27017",
				"health" : 1,
				"state" : 7,
				"stateStr" : "ARBITER",
				"uptime" : 95,
				"lastHeartbeat" : ISODate("2020-06-18T10:25:05.851Z"),
				"lastHeartbeatRecv" : ISODate("2020-06-18T10:25:05.431Z"),
				"pingMs" : NumberLong(0),
				"lastHeartbeatMessage" : "",
				"syncingTo" : "",
				"syncSourceHost" : "",
				"syncSourceId" : -1,
				"infoMessage" : "",
				"configVersion" : 1
			}
		],
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592475903, 1),
			"signature" : {
				"hash" : BinData(0,"B1dJVUVtYolIHIp4Q0+UdtTz+go="),
				"keyId" : NumberLong("6839627628085772291")
			}
		},
		"operationTime" : Timestamp(1592475903, 1)
	}


2.9 做数据同步测试
	242 
		mongo  -u admin -p admin
			use test
			db.test.insert({"zhang3" : "zhang3"})
			db.test.find()
				repl_set:PRIMARY> use test
				switched to db test
				repl_set:PRIMARY> db.test.insert({"zhang3" : "zhang3"})
				WriteResult({ "nInserted" : 1 })
				repl_set:PRIMARY> db.test.find()
				{ "_id" : ObjectId("5eeb4140076369dfbc9b620e"), "zhang3" : "zhang3" }

	252 
		mongo  -u admin -p admin
		rs.slaveOk();
		use test
		db.test.find()

			repl_set:SECONDARY> rs.slaveOk();
			repl_set:SECONDARY> use test
			switched to db test
			repl_set:SECONDARY> db.test.find()
			{ "_id" : ObjectId("5eeb4140076369dfbc9b620e"), "zhang3" : "zhang3" }

	

-----------------------------------------------------------------------------------------------------------------------------------------------


http://www.mamicode.com/info-detail-3021577.html 
https://www.jianshu.com/p/f021f1f3c60b
https://bbs.huaweicloud.com/blogs/158546


