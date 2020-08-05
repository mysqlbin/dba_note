repl_set:PRIMARY> db.t1.find({'tEndTime': {'$lt': '2020-05-04 00:00:00'}}).explain("executionStats")
{
	"queryPlanner" : {
		"plannerVersion" : 1,
		"namespace" : "niuniu_h5.t1",
		"indexFilterSet" : false,
		"parsedQuery" : {
			"tEndTime" : {
				"$lt" : "2020-05-04 00:00:00"
			}
		},
		"winningPlan" : {
			"stage" : "COLLSCAN",
			"filter" : {
				"tEndTime" : {
					"$lt" : "2020-05-04 00:00:00"
				}
			},
			"direction" : "forward"
		},
		"rejectedPlans" : [ ]
	},
	"executionStats" : {
		"executionSuccess" : true,
		"nReturned" : 170116,             -- 查询返回的文档数
		"executionTimeMillis" : 10943,    -- 耗时
		"totalKeysExamined" : 0,          -- 根据索引扫描的文档数
		"totalDocsExamined" : 4461538,    -- 总共扫描的文档数
		"executionStages" : {
			"stage" : "COLLSCAN",
			"filter" : {
				"tEndTime" : {
					"$lt" : "2020-05-04 00:00:00"
				}
			},
			"nReturned" : 170116,
			"executionTimeMillisEstimate" : 807,
			"works" : 4461540,
			"advanced" : 170116,
			"needTime" : 4291423,
			"needYield" : 0,
			"saveState" : 34855,
			"restoreState" : 34855,
			"isEOF" : 1,
			"direction" : "forward",
			"docsExamined" : 4461538
		}
	},
	"serverInfo" : {
		"host" : "database-03.system.com",
		"port" : 27017,
		"version" : "4.2.7",
		"gitVersion" : "51d9fe12b5d19720e72dcd7db0f2f17dd9a19212"
	},
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1593673232, 1),
		"signature" : {
			"hash" : BinData(0,"Km+47VtNin9sB0UrsCwnJxLwJUU="),
			"keyId" : NumberLong("6838881995993382915")
		}
	},
	"operationTime" : Timestamp(1593673232, 1)
}
