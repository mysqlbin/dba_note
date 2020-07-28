

-- 查看索引 

	repl_set:PRIMARY> db.table_match_aaaaaaaaaaaaaaaaaaaaa.getIndexes()
	[
		{
			"v" : 2,
			"key" : {
				"_id" : 1
			},
			"name" : "_id_",
			"ns" : "abdb.table_match_aaaaaaaaaaaaaaaaaaaaa"
		},
		{
			"v" : 2,
			"key" : {
				"szMatchID" : 1
			},
			"name" : "szMatchID_1",
			"ns" : "abdb.table_match_aaaaaaaaaaaaaaaaaaaaa"
		},
		{
			"v" : 2,
			"key" : {
				"CreateTime" : 1
			},
			"name" : "CreateTime_1",
			"ns" : "abdb.table_match_aaaaaaaaaaaaaaaaaaaaa"
	
-- 查看执行计划
repl_set:PRIMARY> db.table_match_aaaaaaaaaaaaaaaaaaaaa.find({"szMatchID" : "89-1595836236-6", "nTableID" : 890717, "nRound": 3}).explain()
{
	"queryPlanner" : {
		"plannerVersion" : 1,
		"namespace" : "abdb.table_match_aaaaaaaaaaaaaaaaaaaaa",
		"indexFilterSet" : false,
		"parsedQuery" : {
			"$and" : [
				{
					"nRound" : {
						"$eq" : 3
					}
				},
				{
					"nTableID" : {
						"$eq" : 890717
					}
				},
				{
					"szMatchID" : {
						"$eq" : "89-1595836236-6"
					}
				}
			]
		},
		"queryHash" : "6B867A19",
		"planCacheKey" : "6B9F17D1",
		"winningPlan" : {
			"stage" : "FETCH",
			"filter" : {
				"$and" : [
					{
						"nRound" : {
							"$eq" : 3
						}
					},
					{
						"nTableID" : {
							"$eq" : 890717
						}
					}
				]
			},
			"inputStage" : {
				"stage" : "IXSCAN",
				"keyPattern" : {
					"szMatchID" : 1
				},
				"indexName" : "szMatchID_1",
				"isMultiKey" : false,
				"multiKeyPaths" : {
					"szMatchID" : [ ]
				},
				"isUnique" : false,
				"isSparse" : false,
				"isPartial" : false,
				"indexVersion" : 2,
				"direction" : "forward",
				"indexBounds" : {
					"szMatchID" : [
						"[\"89-1595836236-6\", \"89-1595836236-6\"]"
					]
				}
			}
		},
		"rejectedPlans" : [ ]
	},
	"serverInfo" : {
		"host" : "localhost.localdomain",
		"port" : 27017,
		"version" : "4.2.7",
		"gitVersion" : "51d9fe12b5d19720e72dcd7db0f2f17dd9a19212"
	},
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1595905385, 1),
		"signature" : {
			"hash" : BinData(0,"Lovk/J/sKUVt+4ywOJC3v9myTS0="),
			"keyId" : NumberLong("6839627628085772291")
		}
	},
	"operationTime" : Timestamp(1595905385, 1)
}