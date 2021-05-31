


架构如下:
192.168.0.201  (主库)
192.168.0.202  (副本)
192.168.0.203  (副本)


2. 架构2 --1主2从





3. 创建目录（数据目录、日志目录、PID文件目录）
	
192.168.0.201 

	mkdir -p /home/mongodb/shard2/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard2
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard2.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard2.conf
	 

192.168.0.202

	mkdir -p /home/mongodb/shard2/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard2
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard2.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard2.conf
	 
	


192.168.0.203

	mkdir -p /home/mongodb/shard2/{data,log,run}

	chown -R mongodb:mongodb  /home/mongodb/shard2
	
	

	/usr/local/mongodb/bin/mongod --config /etc/shard2.conf 
	/usr/local/mongodb/bin/mongod --shutdown --config /etc/shard2.conf
	 
	



配置
	
	登录这台 192.168.0.201 
	
	mongo -port 27018
	
	> configs={_id:"repl_shard2",members:[{_id:0,host:"192.168.0.201:27018",priority:90},{_id:1,host:"192.168.0.202:27018",priority:90},{_id:2,host:"192.168.0.203:27018",priority:90}]};
	{
		"_id" : "repl_shard2",
		"members" : [
			{
				"_id" : 0,
				"host" : "192.168.0.201:27018",
				"priority" : 90
			},
			{
				"_id" : 1,
				"host" : "192.168.0.202:27018",
				"priority" : 90
			},
			{
				"_id" : 2,
				"host" : "192.168.0.203:27018",
				"priority" : 90
			}
		]
	}


	> rs.initiate(configs);
	{
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1622393412, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		},
		"operationTime" : Timestamp(1622393412, 1)
	}


repl_shard2:SECONDARY> rs.status()
{
	"set" : "repl_shard2",
	"date" : ISODate("2021-05-30T16:51:09.079Z"),
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
			"ts" : Timestamp(1622393463, 1),
			"t" : NumberLong(1)
		},
		"lastCommittedWallTime" : ISODate("2021-05-30T16:51:03.100Z"),
		"readConcernMajorityOpTime" : {
			"ts" : Timestamp(1622393463, 1),
			"t" : NumberLong(1)
		},
		"readConcernMajorityWallTime" : ISODate("2021-05-30T16:51:03.100Z"),
		"appliedOpTime" : {
			"ts" : Timestamp(1622393463, 1),
			"t" : NumberLong(1)
		},
		"durableOpTime" : {
			"ts" : Timestamp(1622393463, 1),
			"t" : NumberLong(1)
		},
		"lastAppliedWallTime" : ISODate("2021-05-30T16:51:03.100Z"),
		"lastDurableWallTime" : ISODate("2021-05-30T16:51:03.100Z")
	},
	"lastStableRecoveryTimestamp" : Timestamp(1622393423, 3),
	"lastStableCheckpointTimestamp" : Timestamp(1622393423, 3),
	"electionCandidateMetrics" : {
		"lastElectionReason" : "electionTimeout",
		"lastElectionDate" : ISODate("2021-05-30T16:50:23.069Z"),
		"electionTerm" : NumberLong(1),
		"lastCommittedOpTimeAtElection" : {
			"ts" : Timestamp(0, 0),
			"t" : NumberLong(-1)
		},
		"lastSeenOpTimeAtElection" : {
			"ts" : Timestamp(1622393412, 1),
			"t" : NumberLong(-1)
		},
		"numVotesNeeded" : 2,
		"priorityAtElection" : 90,
		"electionTimeoutMillis" : NumberLong(10000),
		"numCatchUpOps" : NumberLong(0),
		"newTermStartDate" : ISODate("2021-05-30T16:50:23.095Z"),
		"wMajorityWriteAvailabilityDate" : ISODate("2021-05-30T16:50:24.481Z")
	},
	"members" : [
		{
			"_id" : 0,
			"name" : "192.168.0.201:27018",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 351,
			"optime" : {
				"ts" : Timestamp(1622393463, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T16:51:03Z"),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "could not find member to sync from",
			"electionTime" : Timestamp(1622393423, 1),
			"electionDate" : ISODate("2021-05-30T16:50:23Z"),
			"configVersion" : 1,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 1,
			"name" : "192.168.0.202:27018",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 56,
			"optime" : {
				"ts" : Timestamp(1622393463, 1),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622393463, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T16:51:03Z"),
			"optimeDurableDate" : ISODate("2021-05-30T16:51:03Z"),
			"lastHeartbeat" : ISODate("2021-05-30T16:51:07.093Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-30T16:51:08.510Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:27018",
			"syncSourceHost" : "192.168.0.201:27018",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		},
		{
			"_id" : 2,
			"name" : "192.168.0.203:27018",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 56,
			"optime" : {
				"ts" : Timestamp(1622393463, 1),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622393463, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T16:51:03Z"),
			"optimeDurableDate" : ISODate("2021-05-30T16:51:03Z"),
			"lastHeartbeat" : ISODate("2021-05-30T16:51:07.093Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-30T16:51:08.492Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:27018",
			"syncSourceHost" : "192.168.0.201:27018",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1622393463, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1622393463, 1)
}
