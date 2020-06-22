
1. 制造数据
2. 没有创建索引 
	2.1 查询执行计划
3. 创建索引 
	3.1 开始创建索引 
	3.2 查看索引
	3.3 查询执行计划	
	
1. 制造数据

	db.food.insert({"_id" : 1, "fruit" : ["apple", "banana", "peach"]})
	db.food.insert({"_id" : 2, "fruit" : ["apple", "kumquat", "orange"]})
	db.food.insert({"_id" : 3, "fruit" : ["cherry", "banana", "apple"]})

2. 没有创建索引 
2.1 查询执行计划

	查询既有 "apple" 又有 "banana" 的文档
	db.food.find({fruit : {$all : ["apple", "banana"]}}).explain()       # 这里的顺序无关紧要
	
	repl_set:PRIMARY> db.food.find({fruit : {$all : ["apple", "banana"]}}).explain()
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "abc_db.food",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"$and" : [
					{
						"fruit" : {
							"$eq" : "apple"
						}
					},
					{
						"fruit" : {
							"$eq" : "banana"
						}
					}
				]
			},
			"queryHash" : "758F4A1C",
			"planCacheKey" : "758F4A1C",
			"winningPlan" : {
				"stage" : "COLLSCAN",   -- queryPlanner.winningPlan.stage = COLLSCAN，表示进行了一次全集合扫描
				"filter" : {
					"$and" : [
						{
							"fruit" : {
								"$eq" : "apple"
							}
						},
						{
							"fruit" : {
								"$eq" : "banana"
							}
						}
					]
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
			"clusterTime" : Timestamp(1592806655, 1),
			"signature" : {
				"hash" : BinData(0,"pwTfqbHGclK9ajKsLNyiGkJLfCA="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592806655, 1)
	}


3. 创建索引 	
	
3.1 开始创建索引	
	db.food.createIndex({fruit: 1})  //自动创建多key索引
	
	repl_set:PRIMARY> db.food.createIndex({fruit: 1})
	{
		"createdCollectionAutomatically" : false,
		"numIndexesBefore" : 1,
		"numIndexesAfter" : 2,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592806916, 2),
			"signature" : {
				"hash" : BinData(0,"nlo6QFb45PF7/8+YoQLQj8vRWqE="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592806916, 2)
	}

3.2 查看索引
	db.food.getIndexes()
	
	repl_set:PRIMARY> db.food.getIndexes()
	[
		{
			"v" : 2,
			"key" : {
				"_id" : 1
			},
			"name" : "_id_",
			"ns" : "abc_db.food"
		},
		{
			"v" : 2,
			"key" : {
				"fruit" : 1
			},
			"name" : "fruit_1",
			"ns" : "abc_db.food"
		}
	]
		
3.3 查询执行计划	
	db.food.find({fruit : {$all : ["apple", "banana"]}}).explain() 
	repl_set:PRIMARY> db.food.find({fruit : {$all : ["apple", "banana"]}}).explain() 
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "abc_db.food",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"$and" : [
					{
						"fruit" : {
							"$eq" : "apple"
						}
					},
					{
						"fruit" : {
							"$eq" : "banana"
						}
					}
				]
			},
			"queryHash" : "758F4A1C",
			"planCacheKey" : "9341FB47",
			"winningPlan" : {
				"stage" : "FETCH",
				"filter" : {
					"fruit" : {
						"$eq" : "apple"
					}
				},
				"inputStage" : {
					"stage" : "IXSCAN",  -- queryPlanner.winningPlan.stage = IXSCAN，表示进行了一次索引扫描
					"keyPattern" : {
						"fruit" : 1
					},
					"indexName" : "fruit_1", 
					"isMultiKey" : true,
					"multiKeyPaths" : {
						"fruit" : [
							"fruit"
						]
					},
					"isUnique" : false,
					"isSparse" : false,
					"isPartial" : false,
					"indexVersion" : 2,
					"direction" : "forward",
					"indexBounds" : {
						"fruit" : [
							"[\"banana\", \"banana\"]"
						]
					}
				}
			},
			"rejectedPlans" : [
				{
					"stage" : "FETCH",
					"filter" : {
						"fruit" : {
							"$eq" : "banana"
						}
					},
					"inputStage" : {
						"stage" : "IXSCAN",
						"keyPattern" : {
							"fruit" : 1
						},
						"indexName" : "fruit_1",
						"isMultiKey" : true,
						"multiKeyPaths" : {
							"fruit" : [
								"fruit"
							]
						},
						"isUnique" : false,
						"isSparse" : false,
						"isPartial" : false,
						"indexVersion" : 2,
						"direction" : "forward",
						"indexBounds" : {
							"fruit" : [
								"[\"apple\", \"apple\"]"
							]
						}
					}
				},
				{
					"stage" : "FETCH",
					"filter" : {
						"$and" : [
							{
								"fruit" : {
									"$eq" : "apple"
								}
							},
							{
								"fruit" : {
									"$eq" : "banana"
								}
							}
						]
					},
					"inputStage" : {
						"stage" : "AND_SORTED",
						"inputStages" : [
							{
								"stage" : "IXSCAN",
								"keyPattern" : {
									"fruit" : 1
								},
								"indexName" : "fruit_1",
								"isMultiKey" : true,
								"multiKeyPaths" : {
									"fruit" : [
										"fruit"
									]
								},
								"isUnique" : false,
								"isSparse" : false,
								"isPartial" : false,
								"indexVersion" : 2,
								"direction" : "forward",
								"indexBounds" : {
									"fruit" : [
										"[\"apple\", \"apple\"]"
									]
								}
							},
							{
								"stage" : "IXSCAN",
								"keyPattern" : {
									"fruit" : 1
								},
								"indexName" : "fruit_1",
								"isMultiKey" : true,
								"multiKeyPaths" : {
									"fruit" : [
										"fruit"
									]
								},
								"isUnique" : false,
								"isSparse" : false,
								"isPartial" : false,
								"indexVersion" : 2,
								"direction" : "forward",
								"indexBounds" : {
									"fruit" : [
										"[\"banana\", \"banana\"]"
									]
								}
							}
						]
					}
				}
			]
		},
		"serverInfo" : {
			"host" : "database-03.system.com",
			"port" : 27017,
			"version" : "4.2.7",
			"gitVersion" : "51d9fe12b5d19720e72dcd7db0f2f17dd9a19212"
		},
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592806955, 1),
			"signature" : {
				"hash" : BinData(0,"e33wZo5lZZWpDQwXvKfgxEsN2AI="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592806955, 1)
	}
	repl_set:PRIMARY> 
