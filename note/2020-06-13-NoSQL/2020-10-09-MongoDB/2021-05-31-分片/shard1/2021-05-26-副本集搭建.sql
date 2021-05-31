


架构如下:
192.168.0.201 (主库)
192.168.0.202  (副本)
192.168.0.203  (副本)


2. 架构2 --1主2从


2.1 配置
	修改配置文件，加上这一行
		replSet=repl_set



	强制重新配置： re.reconfig(config, {"force" : true})

> configs={_id:"repl_set",members:[{_id:0,host:"192.168.0.201:27017",priority:90},{_id:1,host:"192.168.0.202:27017",priority:90},{_id:2,host:"192.168.0.203:27017",priority:90}]};
{
	"_id" : "repl_set",
	"members" : [
		{
			"_id" : 0,
			"host" : "192.168.0.201:27017",
			"priority" : 90
		},
		{
			"_id" : 1,
			"host" : "192.168.0.202:27017",
			"priority" : 90
		},
		{
			"_id" : 2,
			"host" : "192.168.0.203:27017",
			"priority" : 90
		}
	]
}


> rs.initiate(configs);
{
	"ok" : 0,
	"errmsg" : "replSetInitiate quorum check failed because not all proposed set members responded affirmatively: 
	192.168.0.202:27017 failed with command replSetHeartbeat requires authentication, 192.168.0.203:27017 failed with command replSetHeartbeat requires authentication",
	"code" : 74,
	"codeName" : "NodeNotFound"
}

-- 修改配置文件，不需要添加这一行： auth = true，否则在没有配置 key 前设置密码登录，配置副本集不成功。


> rs.initiate(configs);
{
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1621999160, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1621999160, 1)
}






repl_set:SECONDARY> rs.status()
{
	"set" : "repl_set",
	"date" : ISODate("2021-05-26T03:19:43.037Z"),
	"myState" : 2,
	"term" : NumberLong(1),
	"syncingTo" : "192.168.0.201:27017",
	"syncSourceHost" : "192.168.0.201:27017",
	"syncSourceId" : 0,
	"heartbeatIntervalMillis" : NumberLong(2000),
	"majorityVoteCount" : 2,
	"writeMajorityCount" : 2,
	"optimes" : {
		"lastCommittedOpTime" : {
			"ts" : Timestamp(1621999173, 1),
			"t" : NumberLong(1)
		},
		"lastCommittedWallTime" : ISODate("2021-05-26T03:19:33.719Z"),
		"readConcernMajorityOpTime" : {
			"ts" : Timestamp(1621999173, 1),
			"t" : NumberLong(1)
		},
		"readConcernMajorityWallTime" : ISODate("2021-05-26T03:19:33.719Z"),
		"appliedOpTime" : {
			"ts" : Timestamp(1621999173, 1),
			"t" : NumberLong(1)
		},
		"durableOpTime" : {
			"ts" : Timestamp(1621999173, 1),
			"t" : NumberLong(1)
		},
		"lastAppliedWallTime" : ISODate("2021-05-26T03:19:33.719Z"),
		"lastDurableWallTime" : ISODate("2021-05-26T03:19:33.719Z")
	},
	"lastStableRecoveryTimestamp" : Timestamp(1621999173, 1),
	"lastStableCheckpointTimestamp" : Timestamp(1621999173, 1),
	"electionParticipantMetrics" : {
		"votedForCandidate" : true,
		"electionTerm" : NumberLong(1),
		"lastVoteDate" : ISODate("2021-05-26T03:19:32.289Z"),
		"electionCandidateMemberId" : 0,
		"voteReason" : "",
		"lastAppliedOpTimeAtElection" : {
			"ts" : Timestamp(1621999160, 1),
			"t" : NumberLong(-1)
		},
		"maxAppliedOpTimeInSet" : {
			"ts" : Timestamp(1621999160, 1),
			"t" : NumberLong(-1)
		},
		"priorityAtElection" : 90,
		"newTermStartDate" : ISODate("2021-05-26T03:19:32.375Z"),
		"newTermAppliedDate" : ISODate("2021-05-26T03:19:33.633Z")
	},
	"members" : [
		{
			"_id" : 0,
			"name" : "192.168.0.201:27017",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 21,
			"optime" : {
				"ts" : Timestamp(1621999173, 1),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1621999173, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-26T03:19:33Z"),
			"optimeDurableDate" : ISODate("2021-05-26T03:19:33Z"),
			"lastHeartbeat" : ISODate("2021-05-26T03:19:41.622Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-26T03:19:42.296Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "",
			"electionTime" : Timestamp(1621999172, 1),
			"electionDate" : ISODate("2021-05-26T03:19:32Z"),
			"configVersion" : 1
		},
		{
			"_id" : 1,
			"name" : "192.168.0.202:27017",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 66,
			"optime" : {
				"ts" : Timestamp(1621999173, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-26T03:19:33Z"),
			"syncingTo" : "192.168.0.201:27017",
			"syncSourceHost" : "192.168.0.201:27017",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 2,
			"name" : "192.168.0.203:27017",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 21,
			"optime" : {
				"ts" : Timestamp(1621999173, 1),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1621999173, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-26T03:19:33Z"),
			"optimeDurableDate" : ISODate("2021-05-26T03:19:33Z"),
			"lastHeartbeat" : ISODate("2021-05-26T03:19:41.622Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-26T03:19:41.621Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:27017",
			"syncSourceHost" : "192.168.0.201:27017",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1621999173, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1621999173, 1)
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
			use admin
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
		
		
	修改配置文件，加上这2行
		auth = true
		keyFile=/home/mongodb/keyfile/mongo.key

		
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
			"date" : ISODate("2021-05-26T03:33:35.488Z"),
			"myState" : 1,
			"term" : NumberLong(6),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"heartbeatIntervalMillis" : NumberLong(2000),
			"majorityVoteCount" : 2,
			"writeMajorityCount" : 2,
			"optimes" : {
				"lastCommittedOpTime" : {
					"ts" : Timestamp(1622000009, 1),
					"t" : NumberLong(6)
				},
				"lastCommittedWallTime" : ISODate("2021-05-26T03:33:29.048Z"),
				"readConcernMajorityOpTime" : {
					"ts" : Timestamp(1622000009, 1),
					"t" : NumberLong(6)
				},
				"readConcernMajorityWallTime" : ISODate("2021-05-26T03:33:29.048Z"),
				"appliedOpTime" : {
					"ts" : Timestamp(1622000009, 1),
					"t" : NumberLong(6)
				},
				"durableOpTime" : {
					"ts" : Timestamp(1622000009, 1),
					"t" : NumberLong(6)
				},
				"lastAppliedWallTime" : ISODate("2021-05-26T03:33:29.048Z"),
				"lastDurableWallTime" : ISODate("2021-05-26T03:33:29.048Z")
			},
			"lastStableRecoveryTimestamp" : Timestamp(1621999959, 1),
			"lastStableCheckpointTimestamp" : Timestamp(1621999959, 1),
			"electionCandidateMetrics" : {
				"lastElectionReason" : "electionTimeout",
				"lastElectionDate" : ISODate("2021-05-26T03:33:19.036Z"),
				"electionTerm" : NumberLong(6),
				"lastCommittedOpTimeAtElection" : {
					"ts" : Timestamp(0, 0),
					"t" : NumberLong(-1)
				},
				"lastSeenOpTimeAtElection" : {
					"ts" : Timestamp(1621999969, 1),
					"t" : NumberLong(5)
				},
				"numVotesNeeded" : 2,
				"priorityAtElection" : 90,
				"electionTimeoutMillis" : NumberLong(10000),
				"numCatchUpOps" : NumberLong(0),
				"newTermStartDate" : ISODate("2021-05-26T03:33:19.045Z"),
				"wMajorityWriteAvailabilityDate" : ISODate("2021-05-26T03:33:20.262Z")
			},
			"members" : [
				{
					"_id" : 0,
					"name" : "192.168.0.201:27017",
					"health" : 1,
					"state" : 1,
					"stateStr" : "PRIMARY",
					"uptime" : 39,
					"optime" : {
						"ts" : Timestamp(1622000009, 1),
						"t" : NumberLong(6)
					},
					"optimeDate" : ISODate("2021-05-26T03:33:29Z"),
					"syncingTo" : "",
					"syncSourceHost" : "",
					"syncSourceId" : -1,
					"infoMessage" : "could not find member to sync from",
					"electionTime" : Timestamp(1621999999, 1),
					"electionDate" : ISODate("2021-05-26T03:33:19Z"),
					"configVersion" : 1,
					"self" : true,
					"lastHeartbeatMessage" : ""
				},
				{
					"_id" : 1,
					"name" : "192.168.0.202:27017",
					"health" : 1,
					"state" : 2,
					"stateStr" : "SECONDARY",
					"uptime" : 26,
					"optime" : {
						"ts" : Timestamp(1622000009, 1),
						"t" : NumberLong(6)
					},
					"optimeDurable" : {
						"ts" : Timestamp(1622000009, 1),
						"t" : NumberLong(6)
					},
					"optimeDate" : ISODate("2021-05-26T03:33:29Z"),
					"optimeDurableDate" : ISODate("2021-05-26T03:33:29Z"),
					"lastHeartbeat" : ISODate("2021-05-26T03:33:35.051Z"),
					"lastHeartbeatRecv" : ISODate("2021-05-26T03:33:34.537Z"),
					"pingMs" : NumberLong(0),
					"lastHeartbeatMessage" : "",
					"syncingTo" : "192.168.0.201:27017",
					"syncSourceHost" : "192.168.0.201:27017",
					"syncSourceId" : 0,
					"infoMessage" : "",
					"configVersion" : 1
				},
				{
					"_id" : 2,
					"name" : "192.168.0.203:27017",
					"health" : 1,
					"state" : 2,
					"stateStr" : "SECONDARY",
					"uptime" : 21,
					"optime" : {
						"ts" : Timestamp(1622000009, 1),
						"t" : NumberLong(6)
					},
					"optimeDurable" : {
						"ts" : Timestamp(1622000009, 1),
						"t" : NumberLong(6)
					},
					"optimeDate" : ISODate("2021-05-26T03:33:29Z"),
					"optimeDurableDate" : ISODate("2021-05-26T03:33:29Z"),
					"lastHeartbeat" : ISODate("2021-05-26T03:33:35.052Z"),
					"lastHeartbeatRecv" : ISODate("2021-05-26T03:33:34.244Z"),
					"pingMs" : NumberLong(0),
					"lastHeartbeatMessage" : "",
					"syncingTo" : "192.168.0.201:27017",
					"syncSourceHost" : "192.168.0.201:27017",
					"syncSourceId" : 0,
					"infoMessage" : "",
					"configVersion" : 1
				}
			],
			"ok" : 1,
			"$clusterTime" : {
				"clusterTime" : Timestamp(1622000009, 1),
				"signature" : {
					"hash" : BinData(0,"RNueTJo7so8au75KY7c3uFla4M0="),
					"keyId" : NumberLong("6966433397879078915")
				}
			},
			"operationTime" : Timestamp(1622000009, 1)
		}

2.9 做数据同步测试
	201 
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

	202
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


