
> db.currentOp(true)
{
	"inprog" : [
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "ftdc",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "LogicalSessionCacheRefresh",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "conn45",
			"connectionId" : 45,
			"client" : "192.168.1.31:53360",
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
					"name" : "CentOS Linux release 7.4.1708 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-693.el7.x86_64"
				}
			},
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800",
			"effectiveUsers" : [
				{
					"user" : "admin",
					"db" : "admin"
				}
			]
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "startPeriodicThreadToDecreaseSnapshotHistoryCachePressure",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "clientcursormon",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "FlowControlRefresher",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "FreeMonHTTP-0",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "initandlisten",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "TTLMonitor",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800",
			"effectiveUsers" : [
				{
					"user" : "__system",
					"db" : "local"
				}
			]
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "conn48",
			"connectionId" : 48,
			"client" : "192.168.1.31:53366",
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
					"name" : "CentOS Linux release 7.4.1708 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-693.el7.x86_64"
				}
			},
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800",
			"effectiveUsers" : [
				{
					"user" : "web_user",
					"db" : "admin"
				}
			]
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "WTCheckpointThread",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "TimestampMonitor",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "waitForMajority",
			"active" : true,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800",
			"opid" : 2,
			"op" : "none",
			"ns" : "",
			"command" : {
				
			},
			"numYields" : 0,
			"waitingForLatch" : {
				"timestamp" : ISODate("2020-06-13T03:49:34.350Z"),
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
			"host" : "env30:27017",
			"desc" : "SessionKiller",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "WTIdleSessionSweeper",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "WTJournalFlusher",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "FreeMonProcessor",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "LogicalSessionCacheReap",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		},
		{
			"type" : "op",
			"host" : "env30:27017",
			"desc" : "conn47",
			"connectionId" : 47,
			"client" : "192.168.1.31:53364",
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
					"name" : "CentOS Linux release 7.4.1708 (Core) ",
					"architecture" : "x86_64",
					"version" : "Kernel 3.10.0-693.el7.x86_64"
				}
			},
			"active" : true,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800",
			"effectiveUsers" : [
				{
					"user" : "admin",
					"db" : "admin"
				}
			],
			"opid" : 81668,
			"lsid" : {
				"id" : UUID("7e4e2f09-9f99-4afd-a218-a193162c4276"),
				"uid" : BinData(0,"O0CMtIVItQN4IsEOsJdrPL8s7jv5xwh5a/A5Qfvs2A8=")
			},
			"secs_running" : NumberLong(0),
			"microsecs_running" : NumberLong(165),
			"op" : "command",
			"ns" : "admin.$cmd.aggregate",
			"command" : {
				"currentOp" : 1,
				"$all" : true,
				"lsid" : {
					"id" : UUID("7e4e2f09-9f99-4afd-a218-a193162c4276")
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
			"host" : "env30:27017",
			"desc" : "abortExpiredTransactions",
			"active" : false,
			"currentOpTime" : "2020-06-13T20:45:48.600+0800"
		}
	],
	"ok" : 1
}
> 
