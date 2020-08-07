
1. 通过 db.currentOp() 查看创建索引的进度
	1.1 主库 
	1.2  从库

2. 通过查看日志查看创建索引的进度


1. 主库 
	repl_set:PRIMARY> db.currentOp()
	{
		"inprog" : [
			{
				"type" : "op",
				"host" : "database-03.system.com:27017",
				"desc" : "conn16",
				"connectionId" : 16,
				"client" : "10.10.10.227:46606",
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
				"currentOpTime" : "2020-06-22T12:11:01.280+0800",
				"effectiveUsers" : [
					{
						"user" : "__system",
						"db" : "local"
					}
				],
				"opid" : 1857902,
				"secs_running" : NumberLong(1),
				"microsecs_running" : NumberLong(1063844),
				"op" : "getmore",
				"ns" : "local.oplog.rs",
				"command" : {
					"getMore" : NumberLong("8016721009601370168"),
					"collection" : "oplog.rs",
					"batchSize" : 13981010,
					"maxTimeMS" : NumberLong(5000),
					"term" : NumberLong(155),
					"lastKnownCommittedOpTime" : {
						"ts" : Timestamp(1592799055, 1),
						"t" : NumberLong(155)
					},
					"$replData" : 1,
					"$oplogQueryData" : 1,
					"$readPreference" : {
						"mode" : "secondaryPreferred"
					},
					"$clusterTime" : {
						"clusterTime" : Timestamp(1592799055, 1),
						"signature" : {
							"hash" : BinData(0,"DgVt9swt7H9E6vXwOlb6+E1O4o8="),
							"keyId" : NumberLong("6838881995993382915")
						}
					},
					"$db" : "local"
				},
				"planSummary" : "COLLSCAN",
				"cursor" : {
					"cursorId" : NumberLong("8016721009601370168"),
					"createdDate" : ISODate("2020-06-19T06:18:40.068Z"),
					"lastAccessDate" : ISODate("2020-06-22T04:11:00.216Z"),
					"nDocsReturned" : NumberLong(25158),
					"nBatchesReturned" : NumberLong(76003),
					"noCursorTimeout" : false,
					"tailable" : true,
					"awaitData" : true,
					"originatingCommand" : {
						"find" : "oplog.rs",
						"filter" : {
							"ts" : {
								"$gte" : Timestamp(1592547502, 1)
							}
						},
						"tailable" : true,
						"oplogReplay" : true,
						"awaitData" : true,
						"maxTimeMS" : NumberLong(60000),
						"batchSize" : 13981010,
						"term" : NumberLong(155),
						"readConcern" : {
							"afterClusterTime" : Timestamp(0, 1)
						},
						"$replData" : 1,
						"$oplogQueryData" : 1,
						"$readPreference" : {
							"mode" : "secondaryPreferred"
						},
						"$clusterTime" : {
							"clusterTime" : Timestamp(1592547519, 2),
							"signature" : {
								"hash" : BinData(0,"0mPR1TUMOj3VfPJexN3aHi3UMTc="),
								"keyId" : NumberLong("6838881995993382915")
							}
						},
						"$db" : "local"
					},
					"operationUsingCursorId" : NumberLong(1857902)
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
				"desc" : "conn1279",
				"connectionId" : 1279,
				"client" : "127.0.0.1:37914",
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
				"currentOpTime" : "2020-06-22T12:11:01.292+0800",
				"effectiveUsers" : [
					{
						"user" : "admin",
						"db" : "admin"
					}
				],
				"opid" : 1857908,
				"lsid" : {
					"id" : UUID("97d33c3f-5d31-46ac-a2c5-813ca5903980"),
					"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
				},
				"secs_running" : NumberLong(0),
				"microsecs_running" : NumberLong(162603),
				"op" : "command",
				"ns" : "admin.$cmd.aggregate",
				"command" : {
					"currentOp" : 1,
					"lsid" : {
						"id" : UUID("97d33c3f-5d31-46ac-a2c5-813ca5903980")
					},
					"$clusterTime" : {
						"clusterTime" : Timestamp(1592798995, 1),
						"signature" : {
							"hash" : BinData(0,"yAWUlYcZ56vxFvkULG2K4uSZz0I="),
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
				"desc" : "monitoring-keys-for-HMAC",
				"active" : true,
				"currentOpTime" : "2020-06-22T12:11:01.292+0800",
				"opid" : 195,
				"op" : "none",
				"ns" : "",
				"command" : {
					
				},
				"numYields" : 0,
				"waitingForLatch" : {
					"timestamp" : ISODate("2020-06-19T06:18:39.567Z"),
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
				"desc" : "ReplBatcher",
				"active" : true,
				"currentOpTime" : "2020-06-22T12:11:01.292+0800",
				"opid" : 1857907,
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
				"desc" : "conn1278",
				"connectionId" : 1278,
				"client" : "127.0.0.1:37904",
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
				"currentOpTime" : "2020-06-22T12:11:01.292+0800",
				"effectiveUsers" : [
					{
						"user" : "admin",
						"db" : "admin"
					}
				],
				"opid" : 1857695,
				"lsid" : {
					"id" : UUID("e28b1323-0171-4077-b0af-f384b1c39bb0"),
					"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
				},
				"secs_running" : NumberLong(28),
				"microsecs_running" : NumberLong(28661403),
				"op" : "command",
				"ns" : "niuniuh5_modb_02.table_clubgamelog",
				"command" : {
					"createIndexes" : "table_clubgamelog",
					"indexes" : [
						{
							"key" : {
								"szToken" : 1
							},
							"name" : "szToken_1"
						}
					],
					"lsid" : {
						"id" : UUID("e28b1323-0171-4077-b0af-f384b1c39bb0")
					},
					"$clusterTime" : {
						"clusterTime" : Timestamp(1592798855, 1),
						"signature" : {
							"hash" : BinData(0,"cywiLP/T7IjiL29a1WchLZgek1E="),
							"keyId" : NumberLong("6838881995993382915")
						}
					},
					"$db" : "niuniuh5_modb_02"
				},
				"msg" : "Index Build: scanning collection Index Build: scanning collection: 3631292/5126153 70%",
				"progress" : {
					"done" : 3631292,
					"total" : 5126153
				},
				"numYields" : 28375,
				"locks" : {
					"ParallelBatchWriterMode" : "r",
					"ReplicationStateTransition" : "w",
					"Global" : "w",
					"Database" : "w",
					"Collection" : "r"
				},
				"waitingForLock" : false,
				"lockStats" : {
					"ParallelBatchWriterMode" : {
						"acquireCount" : {
							"r" : NumberLong(28377)
						}
					},
					"ReplicationStateTransition" : {
						"acquireCount" : {
							"w" : NumberLong(28378)
						}
					},
					"Global" : {
						"acquireCount" : {
							"r" : NumberLong(1),
							"w" : NumberLong(28377)
						}
					},
					"Database" : {
						"acquireCount" : {
							"r" : NumberLong(1),
							"w" : NumberLong(28377)
						}
					},
					"Collection" : {
						"acquireCount" : {
							"r" : NumberLong(28376),
							"w" : NumberLong(1),
							"W" : NumberLong(1)
						}
					},
					"Mutex" : {
						"acquireCount" : {
							"r" : NumberLong(3)
						}
					}
				},
				"waitingForFlowControl" : false,
				"flowControlStats" : {
					"acquireCount" : NumberLong(28376),
					"timeAcquiringMicros" : NumberLong(17927)
				}
			},
			{
				"type" : "op",
				"host" : "database-03.system.com:27017",
				"desc" : "WT-OplogTruncaterThread-local.oplog.rs",
				"active" : true,
				"currentOpTime" : "2020-06-22T12:11:01.292+0800",
				"opid" : 36,
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
					"acquireCount" : NumberLong(1),
					"timeAcquiringMicros" : NumberLong(1)
				}
			},
			{
				"type" : "op",
				"host" : "database-03.system.com:27017",
				"desc" : "NoopWriter",
				"active" : true,
				"currentOpTime" : "2020-06-22T12:11:01.292+0800",
				"opid" : 1857864,
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
				"currentOpTime" : "2020-06-22T12:11:01.292+0800",
				"opid" : 2,
				"op" : "none",
				"ns" : "",
				"command" : {
					
				},
				"numYields" : 0,
				"waitingForLatch" : {
					"timestamp" : ISODate("2020-06-19T06:18:24.176Z"),
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
				"desc" : "rsSync-0",
				"active" : true,
				"currentOpTime" : "2020-06-22T12:11:01.292+0800",
				"effectiveUsers" : [
					{
						"user" : "__system",
						"db" : "local"
					}
				],
				"opid" : 1857905,
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
			}
		],
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592799055, 1),
			"signature" : {
				"hash" : BinData(0,"DgVt9swt7H9E6vXwOlb6+E1O4o8="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592799055, 1)
	}
	
2. 从库
repl_set:SECONDARY> db.currentOp()
{
	"inprog" : [
		{
			"type" : "op",
			"host" : "database-04.system.com:27017",
			"desc" : "monitoring-keys-for-HMAC",
			"active" : true,
			"currentOpTime" : "2020-06-22T12:11:33.323+0800",
			"opid" : 25,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2020-06-19T06:18:32.242Z"),
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
			"host" : "database-04.system.com:27017",
			"desc" : "rsSync-0",
			"active" : true,
			"currentOpTime" : "2020-06-22T12:11:33.323+0800",
			"effectiveUsers" : [
				{
					"user" : "__system",
					"db" : "local"
				}
			],
			"opid" : 1812545,
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
			"host" : "database-04.system.com:27017",
			"desc" : "conn416",
			"connectionId" : 416,
			"client" : "127.0.0.1:48016",
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
			"currentOpTime" : "2020-06-22T12:11:33.323+0800",
			"effectiveUsers" : [
				{
					"user" : "admin",
					"db" : "admin"
				}
			],
			"opid" : 1812549,
			"lsid" : {
				"id" : UUID("d14dc85a-6315-4076-bfe4-3530bf9fb534"),
				"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
			},
			"secs_running" : NumberLong(0),
			"microsecs_running" : NumberLong(391),
			"op" : "command",
			"ns" : "admin.$cmd.aggregate",
			"command" : {
				"currentOp" : 1,
				"lsid" : {
					"id" : UUID("d14dc85a-6315-4076-bfe4-3530bf9fb534")
				},
				"$clusterTime" : {
					"clusterTime" : Timestamp(1592799078, 1),
					"signature" : {
						"hash" : BinData(0,"ZRozqz0+G4EKoV4DHpDvtGYla+k="),
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
			"host" : "database-04.system.com:27017",
			"desc" : "ReplBatcher",
			"active" : true,
			"currentOpTime" : "2020-06-22T12:11:33.323+0800",
			"opid" : 1812544,
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
			"host" : "database-04.system.com:27017",
			"desc" : "IndexBuildsCoordinatorMongod-0",
			"active" : true,
			"currentOpTime" : "2020-06-22T12:11:33.323+0800",
			"opid" : 1812446,
			"secs_running" : NumberLong(14),
			"microsecs_running" : NumberLong(14938167),
			"op" : "command",
			"ns" : "",
			"command" : {
				"createIndexes" : "table_clubgamelog",
				"indexes" : [
					{
						"v" : 2,
						"key" : {
							"szToken" : 1
						},
						"name" : "szToken_1",
						"ns" : "niuniuh5_modb_02.table_clubgamelog"
					}
				]
			},
			"msg" : "Index Build: scanning collection Index Build: scanning collection: 2315996/5126153 45%",
			"progress" : {
				"done" : 2315998,
				"total" : 5126153
			},
			"numYields" : 18098,
			"locks" : {
				"Global" : "w",
				"Database" : "w",
				"Collection" : "w"
			},
			"waitingForLock" : false,
			"lockStats" : {
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(1)
					}
				},
				"Global" : {
					"acquireCount" : {
						"w" : NumberLong(18099)
					}
				},
				"Database" : {
					"acquireCount" : {
						"w" : NumberLong(18099)
					}
				},
				"Collection" : {
					"acquireCount" : {
						"w" : NumberLong(18099),
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
			"host" : "database-04.system.com:27017",
			"desc" : "waitForMajority",
			"active" : true,
			"currentOpTime" : "2020-06-22T12:11:33.323+0800",
			"opid" : 2,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2020-06-19T06:18:32.037Z"),
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
			"host" : "database-04.system.com:27017",
			"desc" : "WT-OplogTruncaterThread-local.oplog.rs",
			"active" : true,
			"currentOpTime" : "2020-06-22T12:11:33.323+0800",
			"opid" : 33,
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
				"acquireCount" : NumberLong(1),
				"timeAcquiringMicros" : NumberLong(1)
			}
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1592799078, 1),
		"signature" : {
			"hash" : BinData(0,"ZRozqz0+G4EKoV4DHpDvtGYla+k="),
			"keyId" : NumberLong("6838881995993382915")
		}
	},
	"operationTime" : Timestamp(1592799078, 1)
}



2. 通过查看日志查看创建索引的进度
	
	2020-08-07T10:50:48.827+0800 I  INDEX    [conn1729] index build: starting on aiuaiu_h5.table_clubgamelog properties: { v: 2, key: { szToken: 1.0 }, name: "szToken_1", ns: "aiuaiu_h5.table_clubgamelog" } using method: Hybrid
	2020-08-07T10:50:48.827+0800 I  INDEX    [conn1729] build may temporarily use up to 200 megabytes of RAM
	2020-08-07T10:50:51.001+0800 I  -        [conn1729]   Index Build: scanning collection: 588000/10309190 5%
	2020-08-07T10:50:54.001+0800 I  -        [conn1729]   Index Build: scanning collection: 1400100/10309190 13%
	2020-08-07T10:50:57.001+0800 I  -        [conn1729]   Index Build: scanning collection: 2228000/10309190 21%
	2020-08-07T10:51:00.001+0800 I  -        [conn1729]   Index Build: scanning collection: 3019500/10309190 29%
	2020-08-07T10:51:08.850+0800 I  -        [conn1729]   Index Build: scanning collection: 3172600/10309190 30%
	2020-08-07T10:51:11.610+0800 I  -        [conn1729]   Index Build: scanning collection: 3473900/10309190 33%
	2020-08-07T10:51:14.001+0800 I  -        [conn1729]   Index Build: scanning collection: 3897200/10309190 37%
	2020-08-07T10:51:17.159+0800 I  -        [conn1729]   Index Build: scanning collection: 4112000/10309190 39%
	2020-08-07T10:51:20.001+0800 I  -        [conn1729]   Index Build: scanning collection: 4800300/10309190 46%
	2020-08-07T10:51:23.001+0800 I  -        [conn1729]   Index Build: scanning collection: 5537200/10309190 53%
	2020-08-07T10:51:26.001+0800 I  -        [conn1729]   Index Build: scanning collection: 6299200/10309190 61%
	2020-08-07T10:51:31.189+0800 I  NETWORK  [conn117] end connection 10.10.10.227:19984 (9 connections now open)
	2020-08-07T10:51:34.207+0800 I  -        [conn1729]   Index Build: scanning collection: 6344600/10309190 61%
	2020-08-07T10:51:37.001+0800 I  -        [conn1729]   Index Build: scanning collection: 7044200/10309190 68%
	2020-08-07T10:51:39.916+0800 I  COMMAND  [conn66] command admin.$cmd command: replSetHeartbeat { replSetHeartbeat: "repl_set", configVersion: 4, hbv: 1, from: "10.10.10.223:27017", fromId: 3, term: 170, $replData: 1, $db: "admin" } numYields:0 reslen:609 locks:{} protocol:op_msg 812ms
	2020-08-07T10:51:39.916+0800 I  COMMAND  [conn105] command admin.$cmd command: replSetHeartbeat { replSetHeartbeat: "repl_set", configVersion: 4, hbv: 1, from: "10.10.10.227:27017", fromId: 1, term: 170, $replData: 1, $clusterTime: { clusterTime: Timestamp(1596768688, 1), signature: { hash: BinData(0, 8C8B4840B38B9EB4359FA1E330E866F1119166EE), keyId: 6838881995993382915 } }, $db: "admin" } numYields:0 reslen:609 locks:{} protocol:op_msg 417ms
	2020-08-07T10:51:40.001+0800 I  -        [conn1729]   Index Build: scanning collection: 7389600/10309190 71%
	2020-08-07T10:51:43.005+0800 I  -        [conn1729]   Index Build: scanning collection: 8126600/10309190 78%
	2020-08-07T10:51:44.896+0800 I  COMMAND  [conn107] command local.oplog.rs command: getMore { getMore: 8851265460055525400, collection: "oplog.rs", batchSize: 13981010, maxTimeMS: 5000, term: 170, lastKnownCommittedOpTime: { ts: Timestamp(1596768612, 1), t: 170 }, $replData: 1, $oplogQueryData: 1, $readPreference: { mode: "secondaryPreferred" }, $clusterTime: { clusterTime: Timestamp(1596768698, 1), signature: { hash: BinData(0, 7ABC34BB0CC0EA6FA166C9BDF45A75F71318716D), keyId: 6838881995993382915 } }, $db: "local" } originatingCommand: { find: "oplog.rs", filter: { ts: { $gte: Timestamp(1596443479, 1) } }, tailable: true, oplogReplay: true, awaitData: true, maxTimeMS: 60000, batchSize: 13981010, term: 170, readConcern: { afterClusterTime: Timestamp(0, 1) }, $replData: 1, $oplogQueryData: 1, $readPreference: { mode: "secondaryPreferred" }, $clusterTime: { clusterTime: Timestamp(1596443491, 2), signature: { hash: BinData(0, E867F33D22DC4CCBF887C2290E8C424668E61046), keyId: 6838881995993382915 } }, $db: "local" } planSummary: COLLSCAN cursorid:8851265460055525400 keysExamined:0 docsExamined:0 numYields:2 nreturned:0 reslen:646 locks:{ ReplicationStateTransition: { acquireCount: { w: 3 } }, Global: { acquireCount: { r: 3 } }, Database: { acquireCount: { r: 3 } }, Mutex: { acquireCount: { r: 1 } }, oplog: { acquireCount: { r: 3 } } } storage:{} protocol:op_msg 305ms
	2020-08-07T10:51:46.002+0800 I  -        [conn1729]   Index Build: scanning collection: 8913300/10309190 86%
	2020-08-07T10:51:48.347+0800 I  COMMAND  [PeriodicTaskRunner] task: DBConnectionPool-cleaner took: 277ms
	2020-08-07T10:51:51.165+0800 I  NETWORK  [listener] connection accepted from 10.10.10.227:40038 #1748 (10 connections now open)
	2020-08-07T10:51:51.180+0800 I  NETWORK  [conn1748] received client metadata from 10.10.10.227:40038 conn1748: { driver: { name: "NetworkInterfaceTL", version: "4.2.7" }, os: { type: "Linux", name: "CentOS Linux release 7.3.1611 (Core) ", architecture: "x86_64", version: "Kernel 3.10.0-514.26.2.el7.x86_64" } }
	2020-08-07T10:51:51.219+0800 I  ACCESS   [conn1748] Successfully authenticated as principal __system on local from client 10.10.10.227:40038
	2020-08-07T10:51:51.287+0800 I  ACCESS   [conn119] Successfully authenticated as principal __system on local from client 10.10.10.227:19987
	2020-08-07T10:51:51.288+0800 I  ACCESS   [conn118] Successfully authenticated as principal __system on local from client 10.10.10.227:19986
	2020-08-07T10:51:51.322+0800 I  ACCESS   [conn119] Successfully authenticated as principal __system on local from client 10.10.10.227:19987
	2020-08-07T10:51:51.358+0800 I  ACCESS   [conn119] Successfully authenticated as principal __system on local from client 10.10.10.227:19987
	2020-08-07T10:51:51.393+0800 I  ACCESS   [conn119] Successfully authenticated as principal __system on local from client 10.10.10.227:19987
	2020-08-07T10:51:54.464+0800 I  STORAGE  [TimestampMonitor] Removing drop-pending idents with drop timestamps before timestamp Timestamp(1596768703, 1)
	2020-08-07T10:51:54.464+0800 I  STORAGE  [TimestampMonitor] Completing drop for ident index-4-1333472901181259253 (ns: aiuaiu_h5.table_clubgamelog.$szToken_1) with drop timestamp Timestamp(1596768619, 1)
	2020-08-07T10:51:56.497+0800 I  -        [conn1729]   Index Build: scanning collection: 9517200/10309190 92%
	2020-08-07T10:51:59.318+0800 I  -        [conn1729]   Index Build: scanning collection: 9905300/10309190 96%
	2020-08-07T10:52:02.001+0800 I  -        [conn1729]   Index Build: scanning collection: 10377000/10309190 100%
	2020-08-07T10:52:04.300+0800 I  COMMAND  [ftdc] serverStatus was very slow: { after basic: 0, after asserts: 0, after connections: 0, after electionMetrics: 0, after extra_info: 0, after flowControl: 0, after globalLock: 0, after locks: 0, after logicalSessionRecordCache: 0, after network: 0, after opLatencies: 0, after opReadConcernCounters: 0, after opcounters: 0, after opcountersRepl: 0, after oplogTruncation: 0, after repl: 0, after security: 0, after storageEngine: 0, after tcmalloc: 0, after trafficRecording: 0, after transactions: 0, after transportSecurity: 0, after twoPhaseCommitCoordinator: 0, after wiredTiger: 0, at end: 1299 }
	2020-08-07T10:52:04.778+0800 I  INDEX    [conn1729] index build: collection scan done. scanned 10442742 total records in 75 seconds
	
	--在集合有1000W个文档的场景，创建一个索引花了 75 秒。
	
	2020-08-07T10:52:10.000+0800 I  -        [conn1729]   Index Build: inserting keys from external sorter into index: 3715100/10442742 35%
	2020-08-07T10:52:13.000+0800 I  -        [conn1729]   Index Build: inserting keys from external sorter into index: 9052700/10442742 86%
	2020-08-07T10:52:13.764+0800 I  INDEX    [conn1729] index build: inserted 10442742 keys from external sorter into index in 8 seconds
	2020-08-07T10:52:14.280+0800 I  INDEX    [conn1729] index build: done building index szToken_1 on ns aiuaiu_h5.table_clubgamelog
	2020-08-07T10:52:14.294+0800 I  COMMAND  [conn1729] command aiuaiu_h5.table_clubgamelog appName: "MongoDB Shell" command: createIndexes { createIndexes: "table_clubgamelog", indexes: [ { key: { szToken: 1.0 }, name: "szToken_1" } ], lsid: { id: UUID("d9f33e54-a973-4d47-8c1d-21f29ccba5c8") }, $clusterTime: { clusterTime: Timestamp(1596768619, 1), signature: { hash: BinData(0, C989B2F76714BDF8FE5D76CD982A2F1DAD9B4447), keyId: 6838881995993382915 } }, $db: "aiuaiu_h5" } numYields:81616 reslen:239 locks:{ ParallelBatchWriterMode: { acquireCount: { r: 81618 } }, ReplicationStateTransition: { acquireCount: { w: 81619 } }, Global: { acquireCount: { r: 1, w: 81618 } }, Database: { acquireCount: { r: 1, w: 81618 } }, Collection: { acquireCount: { r: 81618, w: 1, R: 1, W: 2 } }, Mutex: { acquireCount: { r: 4 } } } flowControl:{ acquireCount: 81617, timeAcquiringMicros: 36910 } storage:{ data: { bytesRead: 23188016671, timeReadingMicros: 39321171 }, timeWaitingMicros: { cache: 662 } } protocol:op_msg 85509ms


	