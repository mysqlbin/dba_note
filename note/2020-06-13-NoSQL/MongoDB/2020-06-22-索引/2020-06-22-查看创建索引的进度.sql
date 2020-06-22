
通过 db.currentOp() 查看创建索引的进度
1. 主库 
2. 从库


1. 主库 
	repl_set:PRIMARY> db.currentOp()
	{
		"inprog" : [
			{
				"type" : "op",
				"host" : "database-03.system.com:27017",
				"desc" : "conn16",
				"connectionId" : 16,
				"client" : "10.31.76.227:46606",
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
	