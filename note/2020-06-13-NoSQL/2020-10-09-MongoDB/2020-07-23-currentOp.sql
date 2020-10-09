

https://www.cnblogs.com/xiaoit/p/4597100.html  MongoDB 进程控制系列一：查看当前正在执行的进程
https://www.cnblogs.com/xiaoit/p/4597268.html  MongoDB 进程控制系列二：结束进程



repl_set:PRIMARY> db.currentOp()
{
	"inprog" : [
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "ftdc",
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"opid" : 242422,
			"secs_running" : NumberLong(0),
			"microsecs_running" : NumberLong(85145),
			"op" : "none",
			"ns" : "local.oplog.rs",
			"command" : {
				
			},
			"numYields" : 0,
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(2)
					}
				},
				"Global" : {
					"acquireCount" : {
						"r" : NumberLong(2)
					}
				},
				"Database" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"Mutex" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"oplog" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				}
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "NoopWriter",
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"opid" : 242383,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "conn14",
			"connectionId" : 14,
			"client" : "10.31.76.227:35470",
			"clientMetadata" : {
				"driver" : {
					"name" : "NetworkInterfaceTL",
					"version" : "4.2.7"
				},
				"os" : {
					"type" : "Linux",
					"name" : "CentOS Linux release 7.3.1611 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-514.26.2.el7.x86_64"
				}
			},
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"effectiveUsers" : [
				{
					"user" : "__system",
					"db" : "local"
				}
			],
			"opid" : 242387,
			"secs_running" : NumberLong(4),
			"microsecs_running" : NumberLong(4768393),
			"op" : "getmore",
			"ns" : "local.oplog.rs",
			"command" : {
				"getMore" : NumberLong("6058030055514127609"),
				"collection" : "oplog.rs",
				"batchSize" : 13981010,
				"maxTimeMS" : NumberLong(5000),
				"term" : NumberLong(166),
				"lastKnownCommittedOpTime" : {
					"ts" : Timestamp(1595485960, 1),
					"t" : NumberLong(166)
				},
				"$replData" : 1,
				"$oplogQueryData" : 1,
				"$readPreference" : {
					"mode" : "secondaryPreferred"
				},
				"$clusterTime" : {
					"clusterTime" : Timestamp(1595485960, 1),
					"signature" : {
						"hash" : BinData(0,"AEVMTuY7TMlyo7DF79FTUq+rzmw="),
						"keyId" : NumberLong("6838881995993382915")
					}
				},
				"$db" : "local"
			},
			"planSummary" : "COLLSCAN",
			"cursor" : {
				"cursorId" : NumberLong("6058030055514127609"),
				"createdDate" : ISODate("2020-07-23T03:06:29.872Z"),
				"lastAccessDate" : ISODate("2020-07-23T06:32:40.316Z"),
				"nDocsReturned" : NumberLong(10269820),
				"nBatchesReturned" : NumberLong(71776),
				"noCursorTimeout" : false,
				"tailable" : true,
				"awaitData" : true,
				"originatingCommand" : {
					"find" : "oplog.rs",
					"filter" : {
						"ts" : {
							"$gte" : Timestamp(1595473581, 1)
						}
					},
					"tailable" : true,
					"oplogReplay" : true,
					"awaitData" : true,
					"maxTimeMS" : NumberLong(60000),
					"batchSize" : 13981010,
					"term" : NumberLong(166),
					"readConcern" : {
						"afterClusterTime" : Timestamp(0, 1)
					},
					"$replData" : 1,
					"$oplogQueryData" : 1,
					"$readPreference" : {
						"mode" : "secondaryPreferred"
					},
					"$clusterTime" : {
						"clusterTime" : Timestamp(1595473588, 2),
						"signature" : {
							"hash" : BinData(0,"QCRN1NgsuLJ03EtJr3mvO+/X3c4="),
							"keyId" : NumberLong("6838881995993382915")
						}
					},
					"$db" : "local"
				},
				"operationUsingCursorId" : NumberLong(242387)
			},
			"numYields" : 2,
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(2)
					}
				},
				"Global" : {
					"acquireCount" : {
						"r" : NumberLong(2)
					}
				},
				"Database" : {
					"acquireCount" : {
						"r" : NumberLong(2)
					}
				},
				"Mutex" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"oplog" : {
					"acquireCount" : {
						"r" : NumberLong(2)
					}
				}
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "conn118",
			"connectionId" : 118,
			"client" : "10.31.76.149:56002",
			"appName" : "MongoDB Shell",
			"clientMetadata" : {
				"application" : {
					"name" : "MongoDB Shell"
				},
				"driver" : {
					"name" : "MongoDB Internal Client",
					"version" : "4.2.7"
				},
				"os" : {
					"type" : "Linux",
					"name" : "CentOS Linux release 7.3.1611 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-514.26.2.el7.x86_64"
				}
			},
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"effectiveUsers" : [
				{
					"user" : "admin",
					"db" : "admin"
				}
			],
			"opid" : 242423,
			"lsid" : {
				"id" : UUID("1c056273-c492-4da8-98e4-f32a07c44eaf"),
				"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
			},
			"secs_running" : NumberLong(0),
			"microsecs_running" : NumberLong(181),
			"op" : "command",
			"ns" : "admin.$cmd.aggregate",
			"command" : {
				"currentOp" : 1,
				"lsid" : {
					"id" : UUID("1c056273-c492-4da8-98e4-f32a07c44eaf")
				},
				"$clusterTime" : {
					"clusterTime" : Timestamp(1595485960, 1),
					"signature" : {
						"hash" : BinData(0,"AEVMTuY7TMlyo7DF79FTUq+rzmw="),
						"keyId" : NumberLong("6838881995993382915")
					}
				},
				"$db" : "admin"
			},
			"numYields" : 0,
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "conn116",
			"connectionId" : 116,
			"client" : "10.31.76.149:55982",
			"appName" : "MongoDB Shell",
			"clientMetadata" : {
				"application" : {
					"name" : "MongoDB Shell"
				},
				"driver" : {
					"name" : "MongoDB Internal Client",
					"version" : "4.2.7"
				},
				"os" : {
					"type" : "Linux",
					"name" : "CentOS Linux release 7.3.1611 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-514.26.2.el7.x86_64"
				}
			},
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"effectiveUsers" : [
				{
					"user" : "admin",
					"db" : "admin"
				}
			],
			"opid" : 241597,
			"lsid" : {
				"id" : UUID("ba44b5db-6a6a-43ab-b6ff-8c414ee74dff"),
				"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
			},
			"secs_running" : NumberLong(109),
			"microsecs_running" : NumberLong(109205494),
			"op" : "command",
			"ns" : "aiuaiu_h5.$cmd",
			"command" : {
				"collStats" : "table_abcdgameaaa",
				"scale" : undefined,
				"lsid" : {
					"id" : UUID("ba44b5db-6a6a-43ab-b6ff-8c414ee74dff")
				},
				"$clusterTime" : {
					"clusterTime" : Timestamp(1595485840, 1),
					"signature" : {
						"hash" : BinData(0,"NzNu1Ah7g9p1MYLmkgO+5bRReq8="),
						"keyId" : NumberLong("6838881995993382915")
					}
				},
				"$db" : "aiuaiu_h5"
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2020-07-23T06:32:45.078Z"),
				"captureName" : "CondVarLockGrantNotification::_mutex"
			},
			"locks" : {
				"ReplicationStateTransition" : "w",
				"Global" : "r",
				"Database" : "r"
			},
			"waitingForLock" : true,
			"lockStats" : {
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(1)
					}
				},
				"Global" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"Database" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					},
					"acquireWaitCount" : {
						"r" : NumberLong(1)
					},
					"timeAcquiringMicros" : {
						"r" : NumberLong(109098084)
					}
				}
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "rsSync-0",
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"effectiveUsers" : [
				{
					"user" : "__system",
					"db" : "local"
				}
			],
			"opid" : 242417,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				"ParallelBatchWriterMode" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(1)
					}
				},
				"Global" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"Database" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"Collection" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"Mutex" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				}
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "WT-OplogTruncaterThread-local.oplog.rs",
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"opid" : 235861,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(2)
					}
				},
				"Global" : {
					"acquireCount" : {
						"w" : NumberLong(2)
					}
				},
				"Database" : {
					"acquireCount" : {
						"w" : NumberLong(1)
					}
				}
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				"acquireCount" : NumberLong(1)
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "ReplBatcher",
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"opid" : 242420,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "waitForMajority",
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"opid" : 2,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2020-07-23T03:02:13.334Z"),
				"captureName" : "WaitForMaorityService::_mutex"
			},
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "conn31",
			"connectionId" : 31,
			"client" : "10.31.76.149:52030",
			"appName" : "MongoDB Shell",
			"clientMetadata" : {
				"application" : {
					"name" : "MongoDB Shell"
				},
				"driver" : {
					"name" : "MongoDB Internal Client",
					"version" : "4.2.7"
				},
				"os" : {
					"type" : "Linux",
					"name" : "CentOS Linux release 7.3.1611 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-514.26.2.el7.x86_64"
				}
			},
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"effectiveUsers" : [
				{
					"user" : "admin",
					"db" : "admin"
				}
			],
			"opid" : 241413,
			"lsid" : {
				"id" : UUID("725e9933-ebba-4cde-9edc-597e8727bb90"),
				"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
			},
			"secs_running" : NumberLong(131),
			"microsecs_running" : NumberLong(131380883),
			"op" : "command",
			"ns" : "aiuaiu_h5.table_abcdgameaaa",
			"command" : {
				"reIndex" : "table_abcdgameaaa",       --db.table_abcdgameaaa.reIndex()
				"lsid" : {
					"id" : UUID("725e9933-ebba-4cde-9edc-597e8727bb90")
				},
				"$clusterTime" : {
					"clusterTime" : Timestamp(1595485470, 1),
					"signature" : {
						"hash" : BinData(0,"1S6c4248mQR66mpU/TjxJa9VnzY="),
						"keyId" : NumberLong("6838881995993382915")
					}
				},
				"$db" : "aiuaiu_h5"
			},
			"msg" : "Index Build: scanning collection Index Build: scanning collection: 12763930/15116380 84%",
			"progress" : {
				"done" : 12763930,
				"total" : 15116380
			},
			"numYields" : 0,
			"locks" : {
				"ParallelBatchWriterMode" : "r",
				"ReplicationStateTransition" : "w",
				"Global" : "w",
				"Database" : "W",
				"Collection" : "W"
			},
			"waitingForLock" : false,
			"lockStats" : {
				"ParallelBatchWriterMode" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(1)
					}
				},
				"Global" : {
					"acquireCount" : {
						"w" : NumberLong(1)
					}
				},
				"Database" : {
					"acquireCount" : {
						"W" : NumberLong(1)
					}
				},
				"Collection" : {
					"acquireCount" : {
						"W" : NumberLong(1)
					}
				},
				"Mutex" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				}
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				"acquireCount" : NumberLong(1),
				"timeAcquiringMicros" : NumberLong(1)
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "monitoring-keys-for-HMAC",
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"opid" : 2446,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2020-07-23T03:06:29.039Z"),
				"captureName" : "PeriodicRunner::_mutex"
			},
			"locks" : {
				
			},
			"waitingForLock" : false,
			"lockStats" : {
				
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		},
		{
			"type" : "op",
			"host" : "database-03.system.com:27017",
			"desc" : "conn111",
			"connectionId" : 111,
			"client" : "10.31.76.149:55874",
			"appName" : "mongodump",
			"clientMetadata" : {
				"driver" : {
					"name" : "mongo-go-driver",
					"version" : "v1.2.1"
				},
				"os" : {
					"type" : "linux",
					"architecture" : "amd64"
				},
				"platform" : "go1.12.17",
				"application" : {
					"name" : "mongodump"
				}
			},
			"active" : true,
			"currentOpTime" : "2020-07-23T14:32:45.085+0800",
			"effectiveUsers" : [
				{
					"user" : "admin",
					"db" : "admin"
				}
			],
			"opid" : 241414,
			"lsid" : {
				"id" : UUID("31c9c06e-c54d-40ca-bb5e-62e4bd74865b"),
				"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
			},
			"secs_running" : NumberLong(131),
			"microsecs_running" : NumberLong(131286101),
			"op" : "getmore",
			"ns" : "aiuaiu_h5.$cmd",
			"command" : {
				"getMore" : NumberLong("8373689109314391195"),
				"collection" : "table_abcdgameaaa",
				"lsid" : {
					"id" : UUID("31c9c06e-c54d-40ca-bb5e-62e4bd74865b")
				},
				"$clusterTime" : {
					"clusterTime" : Timestamp(1595485830, 1),
					"signature" : {
						"hash" : BinData(0,"VtHtww2F44oqVKkw9jLZzX/E0JY="),
						"keyId" : NumberLong("6838881995993382915")
					}
				},
				"$db" : "aiuaiu_h5",
				"$readPreference" : {
					"mode" : "primaryPreferred"
				}
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2020-07-23T06:32:45.036Z"),
				"captureName" : "CondVarLockGrantNotification::_mutex"
			},
			"locks" : {
				"ReplicationStateTransition" : "w",
				"Global" : "r",
				"Database" : "r"
			},
			"waitingForLock" : true,
			"lockStats" : {
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(1)
					}
				},
				"Global" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					}
				},
				"Database" : {
					"acquireCount" : {
						"r" : NumberLong(1)
					},
					"acquireWaitCount" : {
						"r" : NumberLong(1)
					},
					"timeAcquiringMicros" : {
						"r" : NumberLong(131137064)
					}
				}
			},
			"waitingForFlowControl" : false,
			"flowControlStats" : {
				
			}
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1595485960, 1),
		"signature" : {
			"hash" : BinData(0,"AEVMTuY7TMlyo7DF79FTUq+rzmw="),
			"keyId" : NumberLong("6838881995993382915")
		}
	},
	"operationTime" : Timestamp(1595485960, 1)
}



2020-07-23T14:32:29.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:32.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:35.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:38.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:41.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:44.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:47.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:50.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:53.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:56.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:32:59.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:02.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:05.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:08.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:11.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:14.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:17.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:20.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:23.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:26.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:29.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:32.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:35.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:38.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3791594/15116380  (25.1%)
2020-07-23T14:33:41.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3793349/15116380  (25.1%)
2020-07-23T14:33:44.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3825436/15116380  (25.3%)
2020-07-23T14:33:47.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3859483/15116380  (25.5%)
2020-07-23T14:33:50.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3893297/15116380  (25.8%)
2020-07-23T14:33:53.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3927850/15116380  (26.0%)
2020-07-23T14:33:56.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3960365/15116380  (26.2%)
2020-07-23T14:33:59.675+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  3995629/15116380  (26.4%)
2020-07-23T14:34:02.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  4027328/15116380  (26.6%)
2020-07-23T14:34:05.669+0800	[######..................]  aiuaiu_h5.table_abcdgameaaa  4062193/15116380  (26.9%)

