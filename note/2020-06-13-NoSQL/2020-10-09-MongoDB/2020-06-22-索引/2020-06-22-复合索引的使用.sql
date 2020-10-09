

1. 制造数据
2. 创建索引 
	2.1 开始创建索引 
	2.2 查看索引
	2.3 查询执行计划
4. 删除索引 
	4.1 开始删除索引 
	4.2 查看索引 
	
5. 相关参考

6. 小结


1. 制造数据
	repl_set:PRIMARY> for (i=0; i<1000; i++) {db.t1.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : new Date()})}
	WriteResult({ "nInserted" : 1 })
	
	repl_set:PRIMARY> db.t1.count()
	1000
		
3.1 开始创建索引
	db.t1.createIndex( {username: 1,age: 1} ) 

	repl_set:PRIMARY> db.t1.createIndex( {username: 1,age: 1} ) 
	{
		"createdCollectionAutomatically" : false,
		"numIndexesBefore" : 1,
		"numIndexesAfter" : 2,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592800002, 2),
			"signature" : {
				"hash" : BinData(0,"dBJZjeAU0ebPaKAqgLT16TagwUc="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592800002, 2)
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
				"username" : 1,
				"age" : 1
			},
			"name" : "username_1_age_1",
			"ns" : "abc_db.t1"
		}
	]


3.3 查询执行计划
	db.t1.find({"username":"user1"}).explain()
	db.t1.find({"age":"47"}).explain()
	db.t1.find({"age" : 47, "username" : "user1"}).explain()
	
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
					"stage" : "IXSCAN",
					"keyPattern" : {
						"username" : 1,
						"age" : 1
					},
					"indexName" : "username_1_age_1",
					"isMultiKey" : false,
					"multiKeyPaths" : {
						"username" : [ ],
						"age" : [ ]
					},
					"isUnique" : false,
					"isSparse" : false,
					"isPartial" : false,
					"indexVersion" : 2,
					"direction" : "forward",
					"indexBounds" : {
						"username" : [
							"[\"user1\", \"user1\"]"
						],
						"age" : [
							"[MinKey, MaxKey]"
						]
					}
				}
			},
			"rejectedPlans" : [ ]
		},
		"serverInfo" : {
			"host" : "database-03.system.com",
			"port" : 27017,
			"version" : "4.2.7",
			"gitVersion" : "51d9fe12b5d19720e72dcd7db0f2f17dd9a19212"
		},
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592800035, 1),
			"signature" : {
				"hash" : BinData(0,"WkDbJzVD8zXSZ5Un8zlcCCnMgxo="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592800035, 1)
	}
		
		
	repl_set:PRIMARY> db.t1.find({"age":"47"}).explain()
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "abc_db.t1",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"age" : {
					"$eq" : "47"
				}
			},
			"queryHash" : "3838C5F3",
			"planCacheKey" : "041C5DE3",
			"winningPlan" : {
				"stage" : "COLLSCAN",
				"filter" : {
					"age" : {
						"$eq" : "47"
					}
				},
				"direction" : "forward"
			},
			"rejectedPlans" : [ ]
		},
		"serverInfo" : {
			"host" : "database-03.system.com",
			"port" : 27017,
			"version" : "4.2.7",
			"gitVersion" : "51d9fe12b5d19720e72dcd7db0f2f17dd9a19212"
		},
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592800085, 1),
			"signature" : {
				"hash" : BinData(0,"OHXefc/+4I41Wj1fXTwyZThtzyY="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592800085, 1)
	}
	
	-- 也要符合最左匹配原则才能用到索引 。
	
		
	repl_set:PRIMARY> db.t1.find({"age" : 47, "username" : "user1"}).explain()
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "abc_db.t1",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"$and" : [
					{
						"age" : {
							"$eq" : 47
						}
					},
					{
						"username" : {
							"$eq" : "user1"
						}
					}
				]
			},
			"queryHash" : "F4D31696",
			"planCacheKey" : "A40174C4",
			"winningPlan" : {
				"stage" : "FETCH",
				"inputStage" : {
					"stage" : "IXSCAN",
					"keyPattern" : {
						"username" : 1,
						"age" : 1
					},
					"indexName" : "username_1_age_1",
					"isMultiKey" : false,
					"multiKeyPaths" : {
						"username" : [ ],
						"age" : [ ]
					},
					"isUnique" : false,
					"isSparse" : false,
					"isPartial" : false,
					"indexVersion" : 2,
					"direction" : "forward",
					"indexBounds" : {
						"username" : [
							"[\"user1\", \"user1\"]"
						],
						"age" : [
							"[47.0, 47.0]"
						]
					}
				}
			},
			"rejectedPlans" : [ ]
		},
		"serverInfo" : {
			"host" : "database-03.system.com",
			"port" : 27017,
			"version" : "4.2.7",
			"gitVersion" : "51d9fe12b5d19720e72dcd7db0f2f17dd9a19212"
		},
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592800205, 1),
			"signature" : {
				"hash" : BinData(0,"rf/bqrhTM/57ct70VYS1uhmOiYk="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592800205, 1)
	}
	repl_set:PRIMARY> 
		

4. 删除索引
	4.1 开始删除索引 

		repl_set:PRIMARY> db.t1.dropIndex("username_1_age_1")
		{
			"nIndexesWas" : 2,
			"ok" : 1,
			"$clusterTime" : {
				"clusterTime" : Timestamp(1592800250, 1),
				"signature" : {
					"hash" : BinData(0,"jSr8y5VcX77X9MSdMQ7E7rFmkQo="),
					"keyId" : NumberLong("6838881995993382915")
				}
			},
			"operationTime" : Timestamp(1592800250, 1)
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
	

6. 小结
	也要符合最左匹配原则才能用到索引。
	
	