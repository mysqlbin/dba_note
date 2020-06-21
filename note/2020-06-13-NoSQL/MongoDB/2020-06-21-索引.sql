
	制造数据
	查看执行计划
	语句的执行时间
	创建索引
	查看索引
	删除索引
	查看执行计划
	有索引和没有索引的对比
	查看创建索引的进度
	相关参考

制造数据
	for (i=0; i<1000000; i++) {db.table_index.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : new Date()})}
	
	repl_set:PRIMARY> db.table_index.count()
	1000000

查看执行计划
	
	repl_set:PRIMARY>  db.table_index.explain("executionStats").find({"username":"user101"})
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "test_db.table_index",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"username" : {
					"$eq" : "user101"
				}
			},
			"winningPlan" : {
				"stage" : "COLLSCAN",
				"filter" : {
					"username" : {
						"$eq" : "user101"
					}
				},
				"direction" : "forward"
			},
			"rejectedPlans" : [ ]
		},
		"executionStats" : {
			"executionSuccess" : true,
			"nReturned" : 1,
			"executionTimeMillis" : 323,
			"totalKeysExamined" : 0,
			"totalDocsExamined" : 1000000,
			"executionStages" : {
				"stage" : "COLLSCAN",
				"filter" : {
					"username" : {
						"$eq" : "user101"
					}
				},
				"nReturned" : 1,
				"executionTimeMillisEstimate" : 5,
				"works" : 1000002,
				"advanced" : 1,
				"needTime" : 1000000,
				"needYield" : 0,
				"saveState" : 7812,
				"restoreState" : 7812,
				"isEOF" : 1,
				"invalidates" : 0,
				"direction" : "forward",
				"docsExamined" : 1000000
			}
		},
		"serverInfo" : {
			"host" : "mongodb03",
			"port" : 27017,
			"version" : "4.0.13",
			"gitVersion" : "bda366f0b0e432ca143bc41da54d8732bd8d03c0"
		},
		"ok" : 1,
		"operationTime" : Timestamp(1574907047, 1),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1574907047, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}

	executionStats.executionSuccess   # 是否执行成功
	executionStats.nReturned          # 查询的返回条数
		"nReturned" : 1
	executionStats.executionTimeMillis  # 整体执行时间
		"executionTimeMillis" : 323
	executionStats.totalKeysExamined   # 索引扫描次数
		"totalKeysExamined" : 0
	executionStats.totalDocsExamined   # document扫描次数
		"totalDocsExamined" : 1000000
		
	
语句的执行时间
	repl_set:PRIMARY>  db.table_index.find({"username" : "user101"})
	{ "_id" : ObjectId("5ddf2241d514eb77720624d1"), "i" : 101, "username" : "user101", "age" : 102, "created" : ISODate("2019-11-28T01:26:25.430Z") }


创建索引
	repl_set:PRIMARY> db.table_index.ensureIndex({"username" : 1})
	{
		"createdCollectionAutomatically" : false,
		"numIndexesBefore" : 1,
		"numIndexesAfter" : 2,
		"ok" : 1,
		"operationTime" : Timestamp(1574905631, 1),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1574905631, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}
	
	repl_set:PRIMARY> db.table_index.ensureIndex({"username" : 1})
	{
		"numIndexesBefore" : 2,
		"numIndexesAfter" : 2,
		"note" : "all indexes already exist",
		"ok" : 1,
		"operationTime" : Timestamp(1574906129, 1),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1574906129, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}


查看索引
	
	repl_set:PRIMARY> db.table_index.getIndexes()
	[
		{
			"v" : 2,
			"key" : {
				"_id" : 1
			},
			"name" : "_id_",
			"ns" : "test_db.table_index"
		},
		{
			"v" : 2,
			"key" : {
				"username" : 1
			},
			"name" : "username_1",
			"ns" : "test_db.table_index"
		}
	]



删除索引
	
	repl_set:PRIMARY> db.table_index.dropIndex("username_1")
	{
		"nIndexesWas" : 2,
		"ok" : 1,
		"operationTime" : Timestamp(1574905612, 1),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1574905612, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}

查看执行计划		
	
	 db.table_index.explain("executionStats").find({"username":"user101"})
	 
	 
	repl_set:PRIMARY> db.table_index.explain("executionStats").find({"username":"user101"})
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "test_db.table_index",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"username" : {
					"$eq" : "user101"
				}
			},
			"winningPlan" : {
				"stage" : "FETCH",
				"inputStage" : {
					"stage" : "IXSCAN",
					"keyPattern" : {
						"username" : 1
					},
					"indexName" : "username_1",
					"isMultiKey" : false,
					"multiKeyPaths" : {
						"username" : [ ]
					},
					"isUnique" : false,
					"isSparse" : false,
					"isPartial" : false,
					"indexVersion" : 2,
					"direction" : "forward",
					"indexBounds" : {
						"username" : [
							"[\"user101\", \"user101\"]"
						]
					}
				}
			},
			"rejectedPlans" : [ ]
		},
		"executionStats" : {
			"executionSuccess" : true,
			"nReturned" : 1,
			"executionTimeMillis" : 0,
			"totalKeysExamined" : 1,
			"totalDocsExamined" : 1,
			"executionStages" : {
				"stage" : "FETCH",
				"nReturned" : 1,
				"executionTimeMillisEstimate" : 0,
				"works" : 2,
				"advanced" : 1,
				"needTime" : 0,
				"needYield" : 0,
				"saveState" : 0,
				"restoreState" : 0,
				"isEOF" : 1,
				"invalidates" : 0,
				"docsExamined" : 1,
				"alreadyHasObj" : 0,
				"inputStage" : {
					"stage" : "IXSCAN",
					"nReturned" : 1,
					"executionTimeMillisEstimate" : 0,
					"works" : 2,
					"advanced" : 1,
					"needTime" : 0,
					"needYield" : 0,
					"saveState" : 0,
					"restoreState" : 0,
					"isEOF" : 1,
					"invalidates" : 0,
					"keyPattern" : {
						"username" : 1
					},
					"indexName" : "username_1",
					"isMultiKey" : false,
					"multiKeyPaths" : {
						"username" : [ ]
					},
					"isUnique" : false,
					"isSparse" : false,
					"isPartial" : false,
					"indexVersion" : 2,
					"direction" : "forward",
					"indexBounds" : {
						"username" : [
							"[\"user101\", \"user101\"]"
						]
					},
					"keysExamined" : 1,
					"seeks" : 1,
					"dupsTested" : 0,
					"dupsDropped" : 0,
					"seenInvalidated" : 0
				}
			}
		},
		"serverInfo" : {
			"host" : "mongodb03",
			"port" : 27017,
			"version" : "4.0.13",
			"gitVersion" : "bda366f0b0e432ca143bc41da54d8732bd8d03c0"
		},
		"ok" : 1,
		"operationTime" : Timestamp(1574906929, 1),
		"$clusterTime" : {
			"clusterTime" : Timestamp(1574906929, 1),
			"signature" : {
				"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
				"keyId" : NumberLong(0)
			}
		}
	}

	executionStats.executionSuccess   # 是否执行成功
	executionStats.nReturned          # 查询的返回条数
		"nReturned" : 1
	executionStats.executionTimeMillis  # 整体执行时间
		"executionTimeMillis" : 0
	executionStats.totalKeysExamined   # 索引扫描次数
		"totalKeysExamined" : 1,
	executionStats.totalDocsExamined   # document扫描次数
		"totalDocsExamined" : 1,


有索引和没有索引的对比		 
	# 整体执行时间                       # 索引扫描次数                      # document扫描次数
	executionStats.executionTimeMillis   executionStats.totalKeysExamined    executionStats.totalDocsExamined   

	"executionTimeMillis" : 323
	"executionTimeMillis" : 0
										"totalKeysExamined" : 0
										"totalKeysExamined" : 1

																			"totalDocsExamined" : 1000000	
																			"totalDocsExamined" : 1,	
	
	没有索引就是基于全文档扫描, 查询耗时长
	有索引就是只需要扫描符合条件的记录数, 查询耗时短
	
	
	
查看创建索引的进度	
	

	执行 db.currentOp() 命令
	repl_set:PRIMARY> db.currentOp()
	
	
	查看日志
		
		
		
相关参考
	http://www.mongoing.com/eshu_explain1
	
	