

架构如下:
192.168.0.201 (主库)
192.168.0.202  (副本)
192.168.0.203  (副本)


执行次序

	0.201							0.202						0.203


	mongo  -u admin -p admin
	use test_db
	db.test_db.insert({"x" : 1})
	db.test_db.find()
	{ "_id" : ObjectId("60adc3e79aecb541cdb8efca"), "x" : 1 }
									use test_db
									db.test_db.find()	
									{ "_id" : ObjectId("60adc3e79aecb541cdb8efca"), "x" : 1 }
	
																use test_db
																db.test_db.find()	
																{ "_id" : ObjectId("60adc3e79aecb541cdb8efca"), "x" : 1 }




执行次序

	第一次执行
		0.201							0.202										0.203
										db.fsyncLock()							
										
										repl_set:SECONDARY> db.fsyncLock()
										{
											"info" : "now locked against writes, use db.fsyncUnlock() to unlock",
											"lockCount" : NumberLong(1),
											"seeAlso" : "http://dochub.mongodb.org/core/fsynccommand",
											"ok" : 1,
											"$clusterTime" : {
												"clusterTime" : Timestamp(1622001209, 1),
												"signature" : {
													"hash" : BinData(0,"hXoWrOYUIlz6kfzCYb0ZcKz2Xpg="),
													"keyId" : NumberLong("6966433397879078915")
												}
											},
											"operationTime" : Timestamp(1622001209, 1)
										}

																				db.fsyncLock()
																				repl_set:SECONDARY> db.fsyncLock()
																				{
																					"info" : "now locked against writes, use db.fsyncUnlock() to unlock",
																					"lockCount" : NumberLong(1),
																					"seeAlso" : "http://dochub.mongodb.org/core/fsynccommand",
																					"ok" : 1,
																					"$clusterTime" : {
																						"clusterTime" : Timestamp(1622001209, 1),
																						"signature" : {
																							"hash" : BinData(0,"hXoWrOYUIlz6kfzCYb0ZcKz2Xpg="),
																							"keyId" : NumberLong("6966433397879078915")
																						}
																					},
																					"operationTime" : Timestamp(1622001209, 1)
																					}
		mongo -host repl_set/192.168.0.201:27017 -u admin -p admin																			
		use test_db
		db.test_co.insert({"x" : 2})
		db.test_co.find()
		db.test_co.find().readPref("secondary")
		db.test_co.find().readPref("primary")
			
			
		repl_set:PRIMARY> use test_db
		switched to db test_db
		repl_set:PRIMARY> db.test_co.insert({"x" : 2})
		WriteResult({ "nInserted" : 1 })
		repl_set:PRIMARY> db.test_co.find()
		{ "_id" : ObjectId("60adefd1cb0879979de54d84"), "x" : 2 }
		repl_set:PRIMARY> db.test_co.find().readPref("secondary")
		2021-05-26T14:50:57.150+0800 I  NETWORK  [js] Successfully connected to 192.168.0.202:27017 (1 connections now open to 192.168.0.202:27017 with a 0 second timeout)
		repl_set:PRIMARY> db.test_co.find().readPref("primary")
		{ "_id" : ObjectId("60adefd1cb0879979de54d84"), "x" : 2 }

										repl_set:SECONDARY> db.test_co.find()
									
										
										repl_set:SECONDARY> db.fsyncUnlock()
										
										repl_set:SECONDARY> db.test_co.find()
										{ "_id" : ObjectId("60adc6db9aecb541cdb8efcb"), "x" : 2 }
										
																						repl_set:SECONDARY> db.fsyncUnlock()
																						repl_set:SECONDARY> db.test_co.find()
																						{ "_id" : ObjectId("60adc6db9aecb541cdb8efcb"), "x" : 2 }
																						
																						
																						
																						
																					
																				
	第二次执行																				
										
		0.201							0.202										0.203
																			
										repl_set:SECONDARY> db.fsyncLock()
										{
											"info" : "now locked against writes, use db.fsyncUnlock() to unlock",
											"lockCount" : NumberLong(1),
											"seeAlso" : "http://dochub.mongodb.org/core/fsynccommand",
											"ok" : 1,
											"$clusterTime" : {
												"clusterTime" : Timestamp(1622019311, 1),
												"signature" : {
													"hash" : BinData(0,"5gbLtjW/V/MHnegBz1u35qfXss8="),
													"keyId" : NumberLong("6966433397879078915")
												}
											},
											"operationTime" : Timestamp(1622019311, 1)
										}
																				
																					repl_set:SECONDARY> db.fsyncLock()
																					{
																						"info" : "now locked against writes, use db.fsyncUnlock() to unlock",
																						"lockCount" : NumberLong(1),
																						"seeAlso" : "http://dochub.mongodb.org/core/fsynccommand",
																						"ok" : 1,
																						"$clusterTime" : {
																							"clusterTime" : Timestamp(1622019311, 1),
																							"signature" : {
																								"hash" : BinData(0,"5gbLtjW/V/MHnegBz1u35qfXss8="),
																								"keyId" : NumberLong("6966433397879078915")
																							}
																						},
																						"operationTime" : Timestamp(1622019311, 1)
																					}
		mongo -host repl_set/192.168.0.201:27017 -u admin -p admin																			
		use test_db
		db.test_co.find()
		db.test_co.insert({"x" : 3})
		db.test_co.find()
		db.test_co.find().readPref("secondary")
		db.test_co.find().readPref("primary")
					
			
		repl_set:PRIMARY> use test_db
		switched to db test_db
		repl_set:PRIMARY> db.test_co.find()
		{ "_id" : ObjectId("60adefd1cb0879979de54d84"), "x" : 2 }
		repl_set:PRIMARY> db.test_co.insert({"x" : 3})
		WriteResult({ "nInserted" : 1 })
		repl_set:PRIMARY> db.test_co.find()
		{ "_id" : ObjectId("60adefd1cb0879979de54d84"), "x" : 2 }
		{ "_id" : ObjectId("60ae0d3b4204025cb86fff60"), "x" : 3 }
		repl_set:PRIMARY> db.test_co.find().readPref("secondary")
		2021-05-26T16:56:27.063+0800 I  NETWORK  [js] Successfully connected to 192.168.0.202:27017 (1 connections now open to 192.168.0.202:27017 with a 0 second timeout)
		{ "_id" : ObjectId("60adefd1cb0879979de54d84"), "x" : 2 }
		repl_set:PRIMARY> db.test_co.find().readPref("primary")
		{ "_id" : ObjectId("60adefd1cb0879979de54d84"), "x" : 2 }
		{ "_id" : ObjectId("60ae0d3b4204025cb86fff60"), "x" : 3 }




	
如果读取不到最新的数据并不会报错，可以读取到已经在从库提交的数据。
	
	
https://jira.mongodb.org/browse/SERVER-22289																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
													
																				
																				
																				
