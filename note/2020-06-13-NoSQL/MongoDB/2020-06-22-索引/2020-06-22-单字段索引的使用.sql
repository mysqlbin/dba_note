

1. 制造数据
2. 没有创建索引 
	2.1 查询执行计划
3. 创建索引 
	3.1 开始创建索引 
	3.2 查看索引
	3.3 查询执行计划
4. 删除索引 
	4.1 开始删除索引 
	4.2 查看索引 
	
5. 相关参考

1. 制造数据
	repl_set:PRIMARY> for (i=0; i<1000; i++) {db.t1.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : new Date()})}
	WriteResult({ "nInserted" : 1 })
	
	repl_set:PRIMARY> db.t1.count()
	1000

2.1 查询执行计划
	
	db.t1.find({"username":"user1"}).explain()
	db.t1.find({"username":"user1"}).explain("executionStats")
	
	repl_set:PRIMARY> db.t1.find({"username":"user1"}).explain()
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "abc_db.t1",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"username" : {
					"$eq" : "user1"
				}
			},
			"queryHash" : "379E82C5",
			"planCacheKey" : "379E82C5",
			"winningPlan" : {
				"stage" : "COLLSCAN",   -- queryPlanner.winningPlan.stage = COLLSCAN，表示进行了一次全集合扫描
				"filter" : {
					"username" : {
						"$eq" : "user1"
					}
				},
				"direction" : "forward"
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
			"clusterTime" : Timestamp(1592797602, 1),
			"signature" : {
				"hash" : BinData(0,"KIxX+d8gozAo8bLajVolRwDR8gc="),
				"keyId" : NumberLong("6839627628085772291")
			}
		},
		"operationTime" : Timestamp(1592797602, 1)
	}

	repl_set:PRIMARY> db.t1.find({"username":"user1"}).explain("executionStats")
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "abc_db.t1",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"username" : {
					"$eq" : "user1"
				}
			},
			"winningPlan" : {
				"stage" : "COLLSCAN",
				"filter" : {
					"username" : {
						"$eq" : "user1"
					}
				},
				"direction" : "forward"
			},
			"rejectedPlans" : [ ]
		},
		"executionStats" : {
			"executionSuccess" : true,
			"nReturned" : 1,
			"executionTimeMillis" : 1,
			"totalKeysExamined" : 0,
			"totalDocsExamined" : 1000,
			"executionStages" : {
				"stage" : "COLLSCAN",
				"filter" : {
					"username" : {
						"$eq" : "user1"
					}
				},
				"nReturned" : 1,
				"executionTimeMillisEstimate" : 0,
				"works" : 1002,
				"advanced" : 1,
				"needTime" : 1000,
				"needYield" : 0,
				"saveState" : 7,
				"restoreState" : 7,
				"isEOF" : 1,
				"direction" : "forward",
				"docsExamined" : 1000
			}
		},
		"serverInfo" : {
			"host" : "localhost.localdomain",
			"port" : 27017,
			"version" : "4.2.7",
			"gitVersion" : "51d9fe12b5d19720e72dcd7db0f2f17dd9a19212"
		},
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592797652, 1),
			"signature" : {
				"hash" : BinData(0,"pApU9PSnPe//LdgUZUuTUIiApAo="),
				"keyId" : NumberLong("6839627628085772291")
			}
		},
		"operationTime" : Timestamp(1592797652, 1)
	}


	executionStats.executionSuccess   # 是否执行成功
	executionStats.nReturned          # 查询的返回条数
		"nReturned" : 1
	executionStats.executionTimeMillis  # 整体执行时间
		"executionTimeMillis" : 1
	executionStats.totalKeysExamined   # 索引扫描次数
		"totalKeysExamined" : 0
	executionStats.totalDocsExamined   # document扫描次数
		"totalDocsExamined" : 1000
		

3.1 开始创建索引
	db.t1.ensureIndex({"username" : 1})
	
	repl_set:PRIMARY> db.t1.ensureIndex({"username" : 1})
	{
		"createdCollectionAutomatically" : false,
		"numIndexesBefore" : 1,
		"numIndexesAfter" : 2,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592797796, 2),
			"signature" : {
				"hash" : BinData(0,"dwNX0Zr0SByxdg4sYNLj2vqQ1W8="),
				"keyId" : NumberLong("6839627628085772291")
			}
		},
		"operationTime" : Timestamp(1592797796, 2)
	}



3.2 查看索引
	
	repl_set:PRIMARY> db.t1.getIndexes()
	[
		{
			"v" : 2,
			"key" : {
				"_id" : 1
			},
			"name" : "_id_",
			"ns" : "abc_db.t1"
		},
		{
			"v" : 2,
			"key" : {
				"username" : 1
			},
			"name" : "username_1",
			"ns" : "abc_db.t1"
		}
	]

3.3 查询执行计划
	repl_set:PRIMARY> db.t1.find({"username":"user1"}).explain()
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "abc_db.t1",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"username" : {
					"$eq" : "user1"
				}
			},
			"queryHash" : "379E82C5",
			"planCacheKey" : "965E0A67",
			"winningPlan" : {
				"stage" : "FETCH",
				"inputStage" : {
					"stage" : "IXSCAN",  -- queryPlanner.winningPlan.stage = IXSCAN，表示进行了一次索引扫描
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
							"[\"user1\", \"user1\"]"
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
			"clusterTime" : Timestamp(1592797972, 1),
			"signature" : {
				"hash" : BinData(0,"SnBXAouJcgqo3buQzRCVSU0Eefk="),
				"keyId" : NumberLong("6839627628085772291")
			}
		},
		"operationTime" : Timestamp(1592797972, 1)
	}
	
	repl_set:PRIMARY> db.t1.find({"username":"user1"}).explain("executionStats")
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "abc_db.t1",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"username" : {
					"$eq" : "user1"
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
							"[\"user1\", \"user1\"]"
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
							"[\"user1\", \"user1\"]"
						]
					},
					"keysExamined" : 1,
					"seeks" : 1,
					"dupsTested" : 0,
					"dupsDropped" : 0
				}
			}
		},
		"serverInfo" : {
			"host" : "localhost.localdomain",
			"port" : 27017,
			"version" : "4.2.7",
			"gitVersion" : "51d9fe12b5d19720e72dcd7db0f2f17dd9a19212"
		},
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592797972, 1),
			"signature" : {
				"hash" : BinData(0,"SnBXAouJcgqo3buQzRCVSU0Eefk="),
				"keyId" : NumberLong("6839627628085772291")
			}
		},
		"operationTime" : Timestamp(1592797972, 1)
	}



4. 删除索引
	4.1 开始删除索引 

		repl_set:PRIMARY> db.t1.dropIndex("username_1")
		{
			"nIndexesWas" : 2,
			"ok" : 1,
			"$clusterTime" : {
				"clusterTime" : Timestamp(1592798616, 1),
				"signature" : {
					"hash" : BinData(0,"Q+7o/tq9Rp5Xc4y4t7x+SsGefRU="),
					"keyId" : NumberLong("6839627628085772291")
				}
			},
			"operationTime" : Timestamp(1592798616, 1)
		}
	
	4.2 查看索引 
		repl_set:PRIMARY> db.t1.getIndexes()
		[
			{
				"v" : 2,
				"key" : {
					"_id" : 1
				},
				"name" : "_id_",
				"ns" : "abc_db.t1"
			}
		]
		
5. 相关参考
	http://www.mongoing.com/eshu_explain1
	
	