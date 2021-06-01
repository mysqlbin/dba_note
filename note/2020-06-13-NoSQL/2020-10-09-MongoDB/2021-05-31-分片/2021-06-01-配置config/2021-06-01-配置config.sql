

config 配置3个节点都要有，并且是搭建成副本集模式


rm -rf /home/mongodb/config

mkdir -p /home/mongodb/config/{data,log,run}

chown -R mongodb:mongodb  /home/mongodb/config/*



/usr/local/mongodb/bin/mongod --config /etc/config.conf 


mongo -port 21000


> configs={_id:"configserver",members:[{_id:0,host:"192.168.0.201:21000",priority:100},{_id:1,host:"192.168.0.202:21000",priority:100},{_id:2,host:"192.168.0.203:21000",priority:100}]};
{
	"_id" : "configserver",
	"members" : [
		{
			"_id" : 0,
			"host" : "192.168.0.201:21000",
			"priority" : 100
		},
		{
			"_id" : 1,
			"host" : "192.168.0.202:21000",
			"priority" : 100
		},
		{
			"_id" : 2,
			"host" : "192.168.0.203:21000",
			"priority" : 100
		}
	]
}

> rs.initiate(configs);
{
	"ok" : 1,
	"$gleStats" : {
		"lastOpTime" : Timestamp(1622398942, 1),
		"electionId" : ObjectId("000000000000000000000000")
	},
	"lastCommittedOpTime" : Timestamp(0, 0),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1622398942, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1622398942, 1)
}



configserver:PRIMARY> rs.status()
{
	"set" : "configserver",
	"date" : ISODate("2021-05-30T23:40:25.337Z"),
	"myState" : 1,
	"term" : NumberLong(1),
	"syncingTo" : "",
	"syncSourceHost" : "",
	"syncSourceId" : -1,
	"configsvr" : true,
	"heartbeatIntervalMillis" : NumberLong(2000),
	"majorityVoteCount" : 2,
	"writeMajorityCount" : 2,
	"optimes" : {
		"lastCommittedOpTime" : {
			"ts" : Timestamp(1622418025, 1),
			"t" : NumberLong(1)
		},
		"lastCommittedWallTime" : ISODate("2021-05-30T23:40:25.081Z"),
		"readConcernMajorityOpTime" : {
			"ts" : Timestamp(1622418025, 1),
			"t" : NumberLong(1)
		},
		"readConcernMajorityWallTime" : ISODate("2021-05-30T23:40:25.081Z"),
		"appliedOpTime" : {
			"ts" : Timestamp(1622418025, 1),
			"t" : NumberLong(1)
		},
		"durableOpTime" : {
			"ts" : Timestamp(1622418025, 1),
			"t" : NumberLong(1)
		},
		"lastAppliedWallTime" : ISODate("2021-05-30T23:40:25.081Z"),
		"lastDurableWallTime" : ISODate("2021-05-30T23:40:25.081Z")
	},
	"lastStableRecoveryTimestamp" : Timestamp(1622418016, 3),
	"lastStableCheckpointTimestamp" : Timestamp(1622418016, 3),
	"electionCandidateMetrics" : {
		"lastElectionReason" : "electionTimeout",
		"lastElectionDate" : ISODate("2021-05-30T23:40:16.027Z"),
		"electionTerm" : NumberLong(1),
		"lastCommittedOpTimeAtElection" : {
			"ts" : Timestamp(0, 0),
			"t" : NumberLong(-1)
		},
		"lastSeenOpTimeAtElection" : {
			"ts" : Timestamp(1622418005, 1),
			"t" : NumberLong(-1)
		},
		"numVotesNeeded" : 2,
		"priorityAtElection" : 100,
		"electionTimeoutMillis" : NumberLong(10000),
		"numCatchUpOps" : NumberLong(0),
		"newTermStartDate" : ISODate("2021-05-30T23:40:16.059Z"),
		"wMajorityWriteAvailabilityDate" : ISODate("2021-05-30T23:40:17.227Z")
	},
	"members" : [
		{
			"_id" : 0,
			"name" : "192.168.0.201:21000",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 91,
			"optime" : {
				"ts" : Timestamp(1622418025, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T23:40:25Z"),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "could not find member to sync from",
			"electionTime" : Timestamp(1622418016, 1),
			"electionDate" : ISODate("2021-05-30T23:40:16Z"),
			"configVersion" : 1,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 1,
			"name" : "192.168.0.202:21000",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 19,
			"optime" : {
				"ts" : Timestamp(1622418017, 3),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622418017, 3),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T23:40:17Z"),
			"optimeDurableDate" : ISODate("2021-05-30T23:40:17Z"),
			"lastHeartbeat" : ISODate("2021-05-30T23:40:24.035Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-30T23:40:25.203Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:21000",
			"syncSourceHost" : "192.168.0.201:21000",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		},
		{
			"_id" : 2,
			"name" : "192.168.0.203:21000",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 19,
			"optime" : {
				"ts" : Timestamp(1622418017, 3),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1622418017, 3),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2021-05-30T23:40:17Z"),
			"optimeDurableDate" : ISODate("2021-05-30T23:40:17Z"),
			"lastHeartbeat" : ISODate("2021-05-30T23:40:24.040Z"),
			"lastHeartbeatRecv" : ISODate("2021-05-30T23:40:25.217Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.201:21000",
			"syncSourceHost" : "192.168.0.201:21000",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		}
	],
	"ok" : 1,
	"$gleStats" : {
		"lastOpTime" : Timestamp(0, 0),
		"electionId" : ObjectId("7fffffff0000000000000001")
	},
	"lastCommittedOpTime" : Timestamp(1622418025, 1),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1622418025, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1622418025, 1)
}



config:PRIMARY> use config
switched to db config
config:PRIMARY> show collections
chunks
lockpings
locks
migrations
shards
tags
transactions
version


