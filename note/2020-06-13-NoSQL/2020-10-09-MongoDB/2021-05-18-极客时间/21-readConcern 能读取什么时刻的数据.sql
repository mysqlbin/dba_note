


架构如下:
	192.168.0.201  (主库)
	192.168.0.202  (副本)
	192.168.0.203  (副本)

	
执行次序
	
	3节点都配置：enableMajorityReadConcern=true
	
	第一次执行
		0.201							0.202									0.203
										mongo -host 192.168.0.202:27017 -u admin -p admin
										db.fsyncLock()							
										
																				mongo -host 192.168.0.203:27017 -u admin -p admin
																				db.fsyncLock()
																			
		mongo -host repl_set/192.168.0.201:27017 -u admin -p admin																			
		use test_db
		db.test_co.drop()
		db.test_co.insert({"x" : 1})
		db.test_co.find()
		db.test_co.find().readConcern("local")
		db.test_co.find().readConcern("majority")
					
					
		repl_set:PRIMARY> use test_db
		switched to db test_db
		repl_set:PRIMARY> db.test_co.drop()
		true
		repl_set:PRIMARY> db.test_co.insert({"x" : 1})
		WriteResult({ "nInserted" : 1 })
		repl_set:PRIMARY> db.test_co.find()
		{ "_id" : ObjectId("60ae338bd1cabb7420eb6fd6"), "x" : 1 }
		repl_set:PRIMARY> db.test_co.find().readConcern("local")
		{ "_id" : ObjectId("60ae338bd1cabb7420eb6fd6"), "x" : 1 }
		
		repl_set:PRIMARY> db.test_co.find().readConcern("majority")
		-- 读取不到数据。
		repl_set:PRIMARY> 

										use test_db	
										db.test_co.find()
										repl_set:SECONDARY> db.test_co.find()
										repl_set:SECONDARY> 

										
																			 db.fsyncUnlock()
										
																			 repl_set:SECONDARY> db.test_co.find()
																			 repl_set:SECONDARY> 	
																			 
		repl_set:PRIMARY> db.test_co.find().readConcern("majority")
		{ "_id" : ObjectId("60ae338bd1cabb7420eb6fd6"), "x" : 1 }
		
										注释配置：enableMajorityReadConcern=true，并重启，然后可以查询到数据
										
										repl_set:SECONDARY> db.test_co.find()
										{ "_id" : ObjectId("60ae338bd1cabb7420eb6fd6"), "x" : 1 }
												
																						
																						
																					
执行次序
	
	只在主节点都配置：enableMajorityReadConcern=true	
	
	第一次执行
		
		0.201							0.202									0.203
										mongo -host 192.168.0.202:27017 -u admin -p admin
										db.fsyncLock()							
										
																				mongo -host 192.168.0.203:27017 -u admin -p admin
																				db.fsyncLock()						
																				
																			
		mongo -host repl_set/192.168.0.201:27017 -u admin -p admin																			
		use test_db
		db.test_co.drop()
		db.test_co.insert({"x" : 1})
		db.test_co.find()
		db.test_co.find().readConcern("local")
		db.test_co.find().readConcern("majority")																			
		
		
																				
		repl_set:PRIMARY> use test_db
		switched to db test_db
		repl_set:PRIMARY> db.test_co.drop()
		true
		repl_set:PRIMARY> db.test_co.insert({"x" : 1})
		WriteResult({ "nInserted" : 1 })
		repl_set:PRIMARY> db.test_co.find()
		{ "_id" : ObjectId("60ae60d99da08022c6797969"), "x" : 1 }
		repl_set:PRIMARY> db.test_co.find().readConcern("local")
		{ "_id" : ObjectId("60ae60d99da08022c6797969"), "x" : 1 }
		repl_set:PRIMARY> db.test_co.find().readConcern("majority")
		--被阻塞，直到超时。
		repl_set:PRIMARY> 	
										db.fsyncUnlock()	
										rs.slaveOk()															
										use test_db	
										db.test_co.find()										
													
																				
										repl_set:SECONDARY> rs.slaveOk()
										repl_set:SECONDARY> use test_db
										switched to db test_db
										repl_set:SECONDARY> db.test_co.find()
										{ "_id" : ObjectId("60ae60d99da08022c6797969"), "x" : 1 }
																														
																				
