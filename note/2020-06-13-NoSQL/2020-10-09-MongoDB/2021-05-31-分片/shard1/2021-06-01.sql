

configsvr = true

bash-4.2$ mongod -f /etc/mongodb.conf --fork
about to fork child process, waiting until server is ready for connections.
forked process: 12020
child process started successfully, parent exiting


2021-05-31T02:56:23.493+0800 I  SHARDING [thread1] creating distributed lock ping thread for process ConfigServer (sleeping for 30000ms)
2021-05-31T02:56:23.493+0800 I  SHARDING [shard-registry-reload] Periodic reload of shard registry failed  :: caused by :: ReadConcernMajorityNotAvailableYet: could not get updated shard list from config server :: caused by :: Read concern majority reads are currently not possible.; will retry after 30s


-- 不能从副本集升级为shard模式






架构如下:
192.168.0.201  (主库)
192.168.0.202  (副本)
192.168.0.203  (副本)
端口号：27016



2. 架构2 --1主2从





3. 创建目录（数据目录、日志目录、PID文件目录）
	
192.168.0.201 

	rm -rf /home/mongodb/shard1
	mkdir -p /home/mongodb/shard1/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard1/*
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard1.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard1.conf
	 

192.168.0.202

	rm -rf /home/mongodb/shard1
	mkdir -p /home/mongodb/shard1/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard1/*
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard1.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard1.conf
	 
	


192.168.0.203
	
	rm -rf /home/mongodb/shard1
	mkdir -p /home/mongodb/shard1/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard1
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard1.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard1.conf
	 
	



配置
	
	登录这台 192.168.0.201 
	
	mongo -port 27016
	
	> configs={_id:"shard1",members:[{_id:0,host:"192.168.0.201:27016",priority:90},{_id:1,host:"192.168.0.202:27016",priority:90},{_id:2,host:"192.168.0.203:27016",priority:90}]};
	{
		"_id" : "shard1",
		"members" : [
			{
				"_id" : 0,
				"host" : "192.168.0.201:27016",
				"priority" : 90
			},
			{
				"_id" : 1,
				"host" : "192.168.0.202:27016",
				"priority" : 90
			},
			{
				"_id" : 2,
				"host" : "192.168.0.203:27016",
				"priority" : 90
			}
		]
	}



	> rs.initiate(configs);
	{
		"ok" : 1,
		"$gleStats" : {
			"lastOpTime" : Timestamp(1622404906, 1),
			"electionId" : ObjectId("000000000000000000000000")
		},
		"lastCommittedOpTime" : Timestamp(0, 0),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1622404906, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		},
		"operationTime" : Timestamp(1622404906, 1)
	}


shard1:PRIMARY> rs.status()
{
	"set" : "shard1",
	"date" : ISODate("2021-05-31T01:08:30.793Z"),
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
			"ts" : Timestamp(1622423308, 3),
			"t" : NumberLong(1)
		},
		"lastCommittedWallTime" : ISODate("2021-05-31T01:08:28.752Z"),
		"readConcernMajorityOpTime" : {
			"ts" : Timestamp(1622423308, 3),
			"t" : NumberLong(1)
		},
		"readConcernMajorityWallTime" : ISODate("2021-05-31T01:08:28.752Z"),
		"appliedOpTime" : {
			"ts" : Timestamp(1622423308, 3),
			"t" : NumberLong(1)
		},
		"durableOpTime" : {
			"ts" : Timestamp(1622423308, 3),
			"t" : NumberLong(1)
		},
		"lastAppliedWallTime" : ISODate("2021-05-31T01:08:28.752Z"),
		"lastDurableWallTime" : ISODate("2021-05-31T01:08:28.752Z")
	},
	"lastStableRecoveryTimestamp" : Timestamp(1622423308, 3),
	"lastStableCheckpointTimestamp" : Timestamp(1622423308, 3),
	"electionCandidateMetrics" : {
		"lastElectionReason" : "electionTimeout",
		"lastElectionDate" : ISODate("2021-05-31T01:08:28.723Z"),
		"electionTerm" : NumberLong(1),
		"lastCommittedOpTimeAtElection" : {
			"ts" : Timestamp(0, 0),
			"t" : NumberLong(-1)
		},
		"lastSeenOpTimeAtElection" : {
			"ts" : Timestamp(1622423297, 1),
			"t" : NumberLong(-1)
		},
		"numVotesNeeded" : 2,
		"priorityAtElection" : 90,
		"electionTimeoutMillis" : NumberLong(10000),
		"numCatchUpOps" : NumberLong(0),
		"newTermStartDate" : ISODate("2021-05-31T01:08:28.752Z"),
		"wMajorityWriteAvailabilityDate" : ISODate("2021-05-31T01:08:29.520Z")
	},
	"members" : [
		{
			"_id" : 0,
			"name" : "192.168.0.201:27016",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 41,
			"optime" : {
				"ts" : Timestamp(1622423308, 3),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-31T01:08:28Z"),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "could not find member to sync from",
			"electionTime" : Timestamp(1622423308, 1),
			"electionDate" : ISODate("2021-05-31T01:08:28Z"),
			"configVersion" : 1,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 1,
			"name" : "192.168.0.202:27016",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 12,
			"optime" : {
				"ts" : Timestamp(1622423308, 3),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622423308, 3),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-31T01:08:28Z"),
			"optimeDurableDate" : ISODate("2021-05-31T01:08:28Z"),
			"lastHeartbeat" : ISODate("2021-05-31T01:08:30.732Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-31T01:08:29.542Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:27016",
			"syncSourceHost" : "192.168.0.201:27016",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		},
		{
			"_id" : 2,
			"name" : "192.168.0.203:27016",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 12,
			"optime" : {
				"ts" : Timestamp(1622423308, 3),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622423308, 3),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-31T01:08:28Z"),
			"optimeDurableDate" : ISODate("2021-05-31T01:08:28Z"),
			"lastHeartbeat" : ISODate("2021-05-31T01:08:30.732Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-31T01:08:29.538Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:27016",
			"syncSourceHost" : "192.168.0.201:27016",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1622423308, 3),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1622423308, 3)
}




mongos> use admin
switched to db admin
mongos> sh.addShard("shard1/192.168.0.201:27016,192.168.0.202:27016,192.168.0.203:27016")
{
	"shardAdded" : "shard1",
	"ok" : 1,
	"operationTime" : Timestamp(1622423402, 7),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1622423402, 7),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}
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
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }



