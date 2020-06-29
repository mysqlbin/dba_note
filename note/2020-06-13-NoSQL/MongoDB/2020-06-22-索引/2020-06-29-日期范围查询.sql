
1. 测试范围删除
2. 测试时间范围查询要扫描的记录数



1. 测试范围删除

	for (i=0; i<5; i++) {db.t1.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : new Date()})}
	 
	for (i=0; i<5; i++) {db.t1.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : new Date()})}

	repl_set:PRIMARY> db.t1.find()
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25a"), "i" : 0, "username" : "user0", "age" : 115, "created" : ISODate("2020-06-29T03:59:04.805Z") }
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25b"), "i" : 1, "username" : "user1", "age" : 52, "created" : ISODate("2020-06-29T03:59:04.939Z") }
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25c"), "i" : 2, "username" : "user2", "age" : 29, "created" : ISODate("2020-06-29T03:59:04.939Z") }
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25d"), "i" : 3, "username" : "user3", "age" : 54, "created" : ISODate("2020-06-29T03:59:04.940Z") }
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25e"), "i" : 4, "username" : "user4", "age" : 87, "created" : ISODate("2020-06-29T03:59:04.941Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad25f"), "i" : 0, "username" : "user0", "age" : 22, "created" : ISODate("2020-06-29T04:01:28.135Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad260"), "i" : 1, "username" : "user1", "age" : 116, "created" : ISODate("2020-06-29T04:01:28.136Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad261"), "i" : 2, "username" : "user2", "age" : 30, "created" : ISODate("2020-06-29T04:01:28.137Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad262"), "i" : 3, "username" : "user3", "age" : 34, "created" : ISODate("2020-06-29T04:01:28.137Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad263"), "i" : 4, "username" : "user4", "age" : 7, "created" : ISODate("2020-06-29T04:01:28.138Z") }

	比较操作符
			
		运算符	     描述
		$lt          <
		$lte         <=
		$gt			 >
		$gte         >=

				
	查询  created >= '2020-06-29 03:59:04' and created <= '2020-06-29 04:00:00' 的所有文档
		repl_set:PRIMARY> db.t1.find({"created" : {"$gte" : '2020-06-29 03:59:04', "$lte" : '2020-06-29 04:00:00'}}) 
		------------------------------------------------------------------------------------------------------------------------------
		
		repl_set:PRIMARY> db.t1.find({"created" : {"$gte" : ISODate('2020-06-29 03:59:04'), "$lte" : ISODate('2020-06-29 04:00:00')}})
		{ "_id" : ObjectId("5ef967083bbebf84e41ad25a"), "i" : 0, "username" : "user0", "age" : 115, "created" : ISODate("2020-06-29T03:59:04.805Z") }
		{ "_id" : ObjectId("5ef967083bbebf84e41ad25b"), "i" : 1, "username" : "user1", "age" : 52, "created" : ISODate("2020-06-29T03:59:04.939Z") }
		{ "_id" : ObjectId("5ef967083bbebf84e41ad25c"), "i" : 2, "username" : "user2", "age" : 29, "created" : ISODate("2020-06-29T03:59:04.939Z") }
		{ "_id" : ObjectId("5ef967083bbebf84e41ad25d"), "i" : 3, "username" : "user3", "age" : 54, "created" : ISODate("2020-06-29T03:59:04.940Z") }
		{ "_id" : ObjectId("5ef967083bbebf84e41ad25e"), "i" : 4, "username" : "user4", "age" : 87, "created" : ISODate("2020-06-29T03:59:04.941Z") }
		

	不需要 TTL索引让数据过期后自动删除也行，
	但是同样需要 新建一个日期类型的字段，并且添加对应的索引， 根据索引定位到要删除记录的位置（比如定位到32天前的数据不再需要，只需要根据索引扫描32天之前的记录即可）


	repl_set:PRIMARY> 
	repl_set:PRIMARY> db.t1.find({"created" : {"$lt" :  ISODate('2020-06-29 04:00:00')}}) 
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25a"), "i" : 0, "username" : "user0", "age" : 115, "created" : ISODate("2020-06-29T03:59:04.805Z") }
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25b"), "i" : 1, "username" : "user1", "age" : 52, "created" : ISODate("2020-06-29T03:59:04.939Z") }
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25c"), "i" : 2, "username" : "user2", "age" : 29, "created" : ISODate("2020-06-29T03:59:04.939Z") }
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25d"), "i" : 3, "username" : "user3", "age" : 54, "created" : ISODate("2020-06-29T03:59:04.940Z") }
	{ "_id" : ObjectId("5ef967083bbebf84e41ad25e"), "i" : 4, "username" : "user4", "age" : 87, "created" : ISODate("2020-06-29T03:59:04.941Z") }

	repl_set:PRIMARY> db.t1.remove({"created" : {"$lt" :  ISODate('2020-06-29 04:00:00')}})
	WriteResult({ "nRemoved" : 5 })

	repl_set:PRIMARY> db.t1.find()
	{ "_id" : ObjectId("5ef967983bbebf84e41ad25f"), "i" : 0, "username" : "user0", "age" : 22, "created" : ISODate("2020-06-29T04:01:28.135Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad260"), "i" : 1, "username" : "user1", "age" : 116, "created" : ISODate("2020-06-29T04:01:28.136Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad261"), "i" : 2, "username" : "user2", "age" : 30, "created" : ISODate("2020-06-29T04:01:28.137Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad262"), "i" : 3, "username" : "user3", "age" : 34, "created" : ISODate("2020-06-29T04:01:28.137Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad263"), "i" : 4, "username" : "user4", "age" : 7, "created" : ISODate("2020-06-29T04:01:28.138Z") }


2. 测试时间范围查询要扫描的记录数

	for (i=0; i<5; i++) {db.t1.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : new Date()})}
	 
	for (i=0; i<5; i++) {db.t1.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : new Date()})}

	repl_set:PRIMARY> db.t1.find()
	{ "_id" : ObjectId("5ef967983bbebf84e41ad25f"), "i" : 0, "username" : "user0", "age" : 22, "created" : ISODate("2020-06-29T04:01:28.135Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad260"), "i" : 1, "username" : "user1", "age" : 116, "created" : ISODate("2020-06-29T04:01:28.136Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad261"), "i" : 2, "username" : "user2", "age" : 30, "created" : ISODate("2020-06-29T04:01:28.137Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad262"), "i" : 3, "username" : "user3", "age" : 34, "created" : ISODate("2020-06-29T04:01:28.137Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad263"), "i" : 4, "username" : "user4", "age" : 7, "created" : ISODate("2020-06-29T04:01:28.138Z") }
	{ "_id" : ObjectId("5ef96c413bbebf84e41ad264"), "i" : 0, "username" : "user0", "age" : 70, "created" : ISODate("2020-06-29T04:21:21.217Z") }
	{ "_id" : ObjectId("5ef96c413bbebf84e41ad265"), "i" : 1, "username" : "user1", "age" : 54, "created" : ISODate("2020-06-29T04:21:21.218Z") }
	{ "_id" : ObjectId("5ef96c413bbebf84e41ad266"), "i" : 2, "username" : "user2", "age" : 27, "created" : ISODate("2020-06-29T04:21:21.226Z") }
	{ "_id" : ObjectId("5ef96c413bbebf84e41ad267"), "i" : 3, "username" : "user3", "age" : 28, "created" : ISODate("2020-06-29T04:21:21.266Z") }
	{ "_id" : ObjectId("5ef96c413bbebf84e41ad268"), "i" : 4, "username" : "user4", "age" : 84, "created" : ISODate("2020-06-29T04:21:21.267Z") }


	db.t1.find({"created" : {"$lt" :  ISODate('2020-06-29 04:02:00')}}) 
	
	repl_set:PRIMARY> db.t1.find({"created" : {"$lt" :  ISODate('2020-06-29 04:02:00')}}) 
	{ "_id" : ObjectId("5ef967983bbebf84e41ad25f"), "i" : 0, "username" : "user0", "age" : 22, "created" : ISODate("2020-06-29T04:01:28.135Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad260"), "i" : 1, "username" : "user1", "age" : 116, "created" : ISODate("2020-06-29T04:01:28.136Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad261"), "i" : 2, "username" : "user2", "age" : 30, "created" : ISODate("2020-06-29T04:01:28.137Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad262"), "i" : 3, "username" : "user3", "age" : 34, "created" : ISODate("2020-06-29T04:01:28.137Z") }
	{ "_id" : ObjectId("5ef967983bbebf84e41ad263"), "i" : 4, "username" : "user4", "age" : 7, "created" : ISODate("2020-06-29T04:01:28.138Z") }
	
		
	db.t1.ensureIndex({"created" : 1})
	
	repl_set:PRIMARY>  db.t1.getIndexes()
	[
		{
			"v" : 2,
			"key" : {
				"_id" : 1
			},
			"name" : "_id_",
			"ns" : "test.t1"
		},
		{
			"v" : 2,
			"key" : {
				"created" : 1
			},
			"name" : "created_1",
			"ns" : "test.t1"
		}
	]
	
	
	repl_set:PRIMARY> db.t1.count()
	10

	db.t1.find({"created" : {"$lt" :  ISODate('2020-06-29 04:02:00')}}).explain()
	
	
	repl_set:PRIMARY> db.t1.find({"created" : {"$lt" :  ISODate('2020-06-29 04:02:00')}}).explain()
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "test.t1",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"created" : {
					"$lt" : ISODate("2020-06-29T04:02:00Z")
				}
			},
			"queryHash" : "052EF5C0",
			"planCacheKey" : "C8677FBF",
			"winningPlan" : {
				"stage" : "FETCH",
				"inputStage" : {
					"stage" : "IXSCAN",
					"keyPattern" : {
						"created" : 1
					},
					"indexName" : "created_1",
					"isMultiKey" : false,
					"multiKeyPaths" : {
						"created" : [ ]
					},
					"isUnique" : false,
					"isSparse" : false,
					"isPartial" : false,
					"indexVersion" : 2,
					"direction" : "forward",
					"indexBounds" : {
						"created" : [
							"(true, new Date(1593403320000))"
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
			"clusterTime" : Timestamp(1593411486, 1),
			"signature" : {
				"hash" : BinData(0,"HpmlBiaUCMUkJe1HS1fBK00yvXM="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1593411486, 1)
	}

	
	.explain() 看不到扫描的行数吗
	
	
	repl_set:PRIMARY> db.t1.find({"created" : {"$lt" :  ISODate('2020-06-29 04:02:00')}}).explain("executionStats")
	{
		"queryPlanner" : {
			"plannerVersion" : 1,
			"namespace" : "test.t1",
			"indexFilterSet" : false,
			"parsedQuery" : {
				"created" : {
					"$lt" : ISODate("2020-06-29T04:02:00Z")
				}
			},
			"winningPlan" : {
				"stage" : "FETCH",
				"inputStage" : {
					"stage" : "IXSCAN",
					"keyPattern" : {
						"created" : 1
					},
					"indexName" : "created_1",
					"isMultiKey" : false,
					"multiKeyPaths" : {
						"created" : [ ]
					},
					"isUnique" : false,
					"isSparse" : false,
					"isPartial" : false,
					"indexVersion" : 2,
					"direction" : "forward",
					"indexBounds" : {
						"created" : [
							"(true, new Date(1593403320000))"
						]
					}
				}
			},
			"rejectedPlans" : [ ]
		},
		"executionStats" : {
			"executionSuccess" : true,
			"nReturned" : 5,
			"executionTimeMillis" : 0,
			"totalKeysExamined" : 5,
			"totalDocsExamined" : 5,
			"executionStages" : {
				"stage" : "FETCH",
				"nReturned" : 5,
				"executionTimeMillisEstimate" : 0,
				"works" : 6,
				"advanced" : 5,
				"needTime" : 0,
				"needYield" : 0,
				"saveState" : 0,
				"restoreState" : 0,
				"isEOF" : 1,
				"docsExamined" : 5,
				"alreadyHasObj" : 0,
				"inputStage" : {
					"stage" : "IXSCAN",
					"nReturned" : 5,
					"executionTimeMillisEstimate" : 0,
					"works" : 6,
					"advanced" : 5,
					"needTime" : 0,
					"needYield" : 0,
					"saveState" : 0,
					"restoreState" : 0,
					"isEOF" : 1,
					"keyPattern" : {
						"created" : 1
					},
					"indexName" : "created_1",
					"isMultiKey" : false,
					"multiKeyPaths" : {
						"created" : [ ]
					},
					"isUnique" : false,
					"isSparse" : false,
					"isPartial" : false,
					"indexVersion" : 2,
					"direction" : "forward",
					"indexBounds" : {
						"created" : [
							"(true, new Date(1593403320000))"
						]
					},
					"keysExamined" : 5,
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
			"clusterTime" : Timestamp(1593411516, 1),
			"signature" : {
				"hash" : BinData(0,"dmMf5T1Ou8UH9En7K6priFcyNJk="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1593411516, 1)
	}

	-- 从当前的结果看，没有 20%-30%原则。
	
	