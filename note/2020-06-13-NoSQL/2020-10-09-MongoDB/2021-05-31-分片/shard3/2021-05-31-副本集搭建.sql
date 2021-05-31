


架构如下:
192.168.0.201  (主库)
192.168.0.202  (副本)
192.168.0.203  (副本)


2. 架构2 --1主2从





3. 创建目录（数据目录、日志目录、PID文件目录）
	
192.168.0.201 

	mkdir -p /home/mongodb/shard3/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard3
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard3.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard3.conf
	 

192.168.0.202

	mkdir -p /home/mongodb/shard3/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard3
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard3.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard3.conf
	 
	


192.168.0.203

	mkdir -p /home/mongodb/shard3/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard3
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard3.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard3.conf
	 
	



配置
	
	登录这台 192.168.0.201 

	mongo -port 27019



	> configs={_id:"repl_shard3",members:[{_id:0,host:"192.168.0.201:27019",priority:90},{_id:1,host:"192.168.0.202:27019",priority:90},{_id:2,host:"192.168.0.203:27019",priority:90}]};
	{
		"_id" : "repl_shard3",
		"members" : [
			{
				"_id" : 0,
				"host" : "192.168.0.201:27019",
				"priority" : 90
			},
			{
				"_id" : 1,
				"host" : "192.168.0.202:27019",
				"priority" : 90
			},
			{
				"_id" : 2,
				"host" : "192.168.0.203:27019",
				"priority" : 90
			}
		]
	}
	> rs.initiate(configs);
	{
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1622394023, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		},
		"operationTime" : Timestamp(1622394023, 1)
	}


repl_shard3:PRIMARY> rs.status()
{
	"set" : "repl_shard3",
	"date" : ISODate("2021-05-30T17:01:17.214Z"),
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
			"ts" : Timestamp(1622394074, 1),
			"t" : NumberLong(1)
		},
		"lastCommittedWallTime" : ISODate("2021-05-30T17:01:14.403Z"),
		"readConcernMajorityOpTime" : {
			"ts" : Timestamp(1622394074, 1),
			"t" : NumberLong(1)
		},
		"readConcernMajorityWallTime" : ISODate("2021-05-30T17:01:14.403Z"),
		"appliedOpTime" : {
			"ts" : Timestamp(1622394074, 1),
			"t" : NumberLong(1)
		},
		"durableOpTime" : {
			"ts" : Timestamp(1622394074, 1),
			"t" : NumberLong(1)
		},
		"lastAppliedWallTime" : ISODate("2021-05-30T17:01:14.403Z"),
		"lastDurableWallTime" : ISODate("2021-05-30T17:01:14.403Z")
	},
	"lastStableRecoveryTimestamp" : Timestamp(1622394034, 3),
	"lastStableCheckpointTimestamp" : Timestamp(1622394034, 3),
	"electionCandidateMetrics" : {
		"lastElectionReason" : "electionTimeout",
		"lastElectionDate" : ISODate("2021-05-30T17:00:34.362Z"),
		"electionTerm" : NumberLong(1),
		"lastCommittedOpTimeAtElection" : {
			"ts" : Timestamp(0, 0),
			"t" : NumberLong(-1)
		},
		"lastSeenOpTimeAtElection" : {
			"ts" : Timestamp(1622394023, 1),
			"t" : NumberLong(-1)
		},
		"numVotesNeeded" : 2,
		"priorityAtElection" : 90,
		"electionTimeoutMillis" : NumberLong(10000),
		"numCatchUpOps" : NumberLong(0),
		"newTermStartDate" : ISODate("2021-05-30T17:00:34.400Z"),
		"wMajorityWriteAvailabilityDate" : ISODate("2021-05-30T17:00:35.465Z")
	},
	"members" : [
		{
			"_id" : 0,
			"name" : "192.168.0.201:27019",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 275,
			"optime" : {
				"ts" : Timestamp(1622394074, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T17:01:14Z"),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "could not find member to sync from",
			"electionTime" : Timestamp(1622394034, 1),
			"electionDate" : ISODate("2021-05-30T17:00:34Z"),
			"configVersion" : 1,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 1,
			"name" : "192.168.0.202:27019",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 54,
			"optime" : {
				"ts" : Timestamp(1622394074, 1),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622394074, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T17:01:14Z"),
			"optimeDurableDate" : ISODate("2021-05-30T17:01:14Z"),
			"lastHeartbeat" : ISODate("2021-05-30T17:01:16.391Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-30T17:01:15.472Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:27019",
			"syncSourceHost" : "192.168.0.201:27019",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		},
		{
			"_id" : 2,
			"name" : "192.168.0.203:27019",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 54,
			"optime" : {
				"ts" : Timestamp(1622394074, 1),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622394074, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T17:01:14Z"),
			"optimeDurableDate" : ISODate("2021-05-30T17:01:14Z"),
			"lastHeartbeat" : ISODate("2021-05-30T17:01:16.391Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-30T17:01:15.468Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:27019",
			"syncSourceHost" : "192.168.0.201:27019",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1622394074, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1622394074, 1)
}
