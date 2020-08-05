repl_set:PRIMARY> db.t1.find({'CreateTime': {'$lt': ISODate('2020-05-04 00:00:00')}}).explain("executionStats")
{
	"queryPlanner" : {
		"plannerVersion" : 1,
		"namespace" : "niuniu_h5.t1",
		"indexFilterSet" : false,
		"parsedQuery" : {
			"CreateTime" : {
				"$lt" : ISODate("2020-05-04T00:00:00Z")
			}
		},
		"winningPlan" : {
			"stage" : "FETCH",
			"inputStage" : {
				"stage" : "IXSCAN",
				"keyPattern" : {
					"CreateTime" : 1
				},
				"indexName" : "CreateTime_1",
				"isMultiKey" : false,
				"multiKeyPaths" : {
					"CreateTime" : [ ]
				},
				"isUnique" : false,
				"isSparse" : false,
				"isPartial" : false,
				"indexVersion" : 2,
				"direction" : "forward",
				"indexBounds" : {
					"CreateTime" : [
						"(true, new Date(1588550400000))"
					]
				}
			}
		},
		"rejectedPlans" : [ ]
	},
	"executionStats" : {
		"executionSuccess" : true,
		"nReturned" : 170116,           -- 查询返回的文档数
		"executionTimeMillis" : 180,    -- 耗时
		"totalKeysExamined" : 170116,   -- 根据索引扫描的文档数
		"totalDocsExamined" : 170116,   -- 总共扫描的文档数
		"executionStages" : {
			"stage" : "FETCH",
			"nReturned" : 170116,
			"executionTimeMillisEstimate" : 5,
			"works" : 170117,
			"advanced" : 170116,
			"needTime" : 0,
			"needYield" : 0,
			"saveState" : 1329,
			"restoreState" : 1329,
			"isEOF" : 1,
			"docsExamined" : 170116,
			"alreadyHasObj" : 0,
			"inputStage" : {
				"stage" : "IXSCAN",
				"nReturned" : 170116,
				"executionTimeMillisEstimate" : 2,
				"works" : 170117,
				"advanced" : 170116,
				"needTime" : 0,
				"needYield" : 0,
				"saveState" : 1329,
				"restoreState" : 1329,
				"isEOF" : 1,
				"keyPattern" : {
					"CreateTime" : 1
				},
				"indexName" : "CreateTime_1",
				"isMultiKey" : false,
				"multiKeyPaths" : {
					"CreateTime" : [ ]
				},
				"isUnique" : false,
				"isSparse" : false,
				"isPartial" : false,
				"indexVersion" : 2,
				"direction" : "forward",
				"indexBounds" : {
					"CreateTime" : [
						"(true, new Date(1588550400000))"
					]
				},
				"keysExamined" : 170116,
				"seeks" : 1,
				"dupsTested" : 0,
				"dupsDropped" : 0
			}
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
		"clusterTime" : Timestamp(1593673752, 1),
		"signature" : {
			"hash" : BinData(0,"2885KaPsRbqMHRYA5kK6wm4NoEg="),
			"keyId" : NumberLong("6838881995993382915")
		}
	},
	"operationTime" : Timestamp(1593673752, 1)
}
