
session = db.getMongo().startSession()
session.startTransaction()
t1 = session.getDatabase("test_db").t1
t1.update({'nPlayerid':10},{ $inc: { 'scores': -5 }})  


repl_set:PRIMARY> db.currentOp()
{
	"inprog" : [
		{
			"type" : "op",
			"host" : "db-a:27017",
			"desc" : "WT-OplogTruncaterThread-local.oplog.rs",
			"active" : true,
			"currentOpTime" : "2021-05-17T15:39:28.269+0800",
			"opid" : 37,
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
			"host" : "db-a:27017",
			"desc" : "rsSync-0",
			"active" : true,
			"currentOpTime" : "2021-05-17T15:39:28.269+0800",
			"effectiveUsers" : [
				{
					"user" : "__system",
					"db" : "local"
				}
			],
			"opid" : 70852071,
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
			"host" : "db-a:27017",
			"desc" : "conn465",
			"connectionId" : 465,
			"client" : "192.168.1.10:38426",
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
					"name" : "CentOS Linux release 7.6.1810 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-957.10.1.el7.x86_64"
				}
			},
			"active" : true,
			"currentOpTime" : "2021-05-17T15:39:28.269+0800",
			"effectiveUsers" : [
				{
					"user" : "admin",
					"db" : "admin"
				}
			],
			"opid" : 70852076,
			"lsid" : {
				"id" : UUID("76038536-d68d-4154-ba27-0270bc8acace"),
				"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
			},
			"secs_running" : NumberLong(0),
			"microsecs_running" : NumberLong(152),
			"op" : "command",
			"ns" : "admin.$cmd.aggregate",
			"command" : {
				"currentOp" : 1,
				"lsid" : {
					"id" : UUID("76038536-d68d-4154-ba27-0270bc8acace")
				},
				"$clusterTime" : {
					"clusterTime" : Timestamp(1621237160, 1),
					"signature" : {
						"hash" : BinData(0,"FNKxOBCtc9c0VcJSYekhezDb8T0="),
						"keyId" : NumberLong("6922357820717268993")
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
			"host" : "db-a:27017",
			"desc" : "NoopWriter",
			"active" : true,
			"currentOpTime" : "2021-05-17T15:39:28.269+0800",
			"opid" : 70852011,
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
			"host" : "db-a:27017",
			"desc" : "waitForMajority",
			"active" : true,
			"currentOpTime" : "2021-05-17T15:39:28.269+0800",
			"opid" : 2,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2021-01-27T08:43:51.025Z"),
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
			"host" : "db-a:27017",
			"desc" : "monitoring-keys-for-HMAC",
			"active" : true,
			"currentOpTime" : "2021-05-17T15:39:28.269+0800",
			"opid" : 14083937,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2021-02-17T20:23:37.261Z"),
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
			"host" : "db-a:27017",
			"desc" : "ReplBatcher",
			"active" : true,
			"currentOpTime" : "2021-05-17T15:39:28.269+0800",
			"opid" : 70852072,
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
			"host" : "db-a:27017",
			"desc" : "conn14",
			"connectionId" : 14,
			"client" : "192.168.1.11:49214",
			"clientMetadata" : {
				"driver" : {
					"name" : "NetworkInterfaceTL",
					"version" : "4.2.7"
				},
				"os" : {
					"type" : "Linux",
					"name" : "CentOS Linux release 7.6.1810 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-957.10.1.el7.x86_64"
				}
			},
			"active" : true,
			"currentOpTime" : "2021-05-17T15:39:28.269+0800",
			"effectiveUsers" : [
				{
					"user" : "__system",
					"db" : "local"
				}
			],
			"opid" : 70852052,
			"secs_running" : NumberLong(3),
			"microsecs_running" : NumberLong(3223135),
			"op" : "getmore",
			"ns" : "local.oplog.rs",
			"command" : {
				"getMore" : NumberLong("2807335188450239548"),
				"collection" : "oplog.rs",
				"batchSize" : 13981010,
				"maxTimeMS" : NumberLong(5000),
				"term" : NumberLong(9),
				"lastKnownCommittedOpTime" : {
					"ts" : Timestamp(1621237160, 1),
					"t" : NumberLong(9)
				},
				"$replData" : 1,
				"$oplogQueryData" : 1,
				"$readPreference" : {
					"mode" : "secondaryPreferred"
				},
				"$clusterTime" : {
					"clusterTime" : Timestamp(1621237160, 1),
					"signature" : {
						"hash" : BinData(0,"FNKxOBCtc9c0VcJSYekhezDb8T0="),
						"keyId" : NumberLong("6922357820717268993")
					}
				},
				"$db" : "local"
			},
			"planSummary" : "COLLSCAN",
			"cursor" : {
				"cursorId" : NumberLong("2807335188450239548"),
				"createdDate" : ISODate("2021-01-27T08:44:57.402Z"),
				"lastAccessDate" : ISODate("2021-05-17T07:39:25.045Z"),
				"nDocsReturned" : NumberLong(953600),
				"nBatchesReturned" : NumberLong(2853826),
				"noCursorTimeout" : false,
				"tailable" : true,
				"awaitData" : true,
				"originatingCommand" : {
					"find" : "oplog.rs",
					"filter" : {
						"ts" : {
							"$gte" : Timestamp(1611737077, 1)
						}
					},
					"tailable" : true,
					"oplogReplay" : true,
					"awaitData" : true,
					"maxTimeMS" : NumberLong(60000),
					"batchSize" : 13981010,
					"term" : NumberLong(9),
					"readConcern" : {
						"afterClusterTime" : Timestamp(0, 1)
					},
					"$replData" : 1,
					"$oplogQueryData" : 1,
					"$readPreference" : {
						"mode" : "secondaryPreferred"
					},
					"$clusterTime" : {
						"clusterTime" : Timestamp(1611737096, 2),
						"signature" : {
							"hash" : BinData(0,"OBui6oH/cQnpsVzuN7CWagTzSOc="),
							"keyId" : NumberLong("6918875817715957761")
						}
					},
					"$db" : "local"
				},
				"operationUsingCursorId" : NumberLong(70852052)
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
			"type" : "idleSession",      -- 空闲会话
			"host" : "db-a:27017",
			"desc" : "inactive transaction",   -- 活跃事务
			"client" : "192.168.1.10:38422",
			"connectionId" : NumberLong(464),
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
					"name" : "CentOS Linux release 7.6.1810 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-957.10.1.el7.x86_64"
				}
			},
			"lsid" : {
				"id" : UUID("5f672f52-f162-406d-8b43-632288702fcd"),
				"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
			},
			"transaction" : {
				"parameters" : {
					"txnNumber" : NumberLong(0),
					"autocommit" : false,
					"readConcern" : {
						"level" : "snapshot"
					}
				},
				"readTimestamp" : Timestamp(0, 0),
				"startWallClockTime" : "2021-05-17T15:39:15.199+0800",
				"timeOpenMicros" : NumberLong(13070189),
				"timeActiveMicros" : NumberLong(192),
				"timeInactiveMicros" : NumberLong(13069997),
				"expiryTime" : "2021-05-17T15:40:15.199+0800"     --事务的过期时间
			},
			"waitingForLock" : false,
			"active" : false,
			"locks" : {
				"ReplicationStateTransition" : "w",
				"Global" : "w",
				"Database" : "w",
				"Collection" : "w"
			},
			"lockStats" : {
				"ReplicationStateTransition" : {
					"acquireCount" : {
						"w" : NumberLong(3)
					}
				},
				"Global" : {
					"acquireCount" : {
						"w" : NumberLong(2)
					}
				},
				"Database" : {
					"acquireCount" : {
						"w" : NumberLong(2)
					}
				},
				"Collection" : {
					"acquireCount" : {
						"w" : NumberLong(2)
					}
				},
				"Mutex" : {
					"acquireCount" : {
						"r" : NumberLong(2)
					}
				}
			}
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1621237160, 1),
		"signature" : {
			"hash" : BinData(0,"FNKxOBCtc9c0VcJSYekhezDb8T0="),
			"keyId" : NumberLong("6922357820717268993")
		}
	},
	"operationTime" : Timestamp(1621237160, 1)
}


