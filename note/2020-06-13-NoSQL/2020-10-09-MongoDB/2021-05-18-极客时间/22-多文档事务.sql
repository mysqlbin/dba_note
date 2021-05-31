
1. 架构如下
2. 事务的隔离性实验
3. 可重复读隔离级别的实验
4. 事务内WriteConflict写冲突的处理
5. 事务内和事务外的WriteConflict写冲突的处理




1. 架构如下
	192.168.0.201  (主库)
	192.168.0.202  (副本)
	192.168.0.203  (副本)

	
2. 事务的隔离性实验

	session A(192.168.0.201) 									session B(192.168.0.202) 	
	
	use test_db
	db.co_20210528.drop()
	db.co_20210528.insertMany([{x:1}, {x:2}])
	db.co_20210528.find()
	{ "_id" : ObjectId("60b362c1a5df5ac6c49874a0"), "x" : 1 }
	{ "_id" : ObjectId("60b362c1a5df5ac6c49874a1"), "x" : 2 }

																use test_db
																rs.slaveOk()
																db.co_20210528.find()
																{ "_id" : ObjectId("60b36649a5df5ac6c49874a4"), "x" : 1 }
																{ "_id" : ObjectId("60b36649a5df5ac6c49874a5"), "x" : 2 }


	session = db.getMongo().startSession()
	session.startTransaction()
	co_20210528 = session.getDatabase("test_db").co_20210528
	-- 更新操作
	co_20210528.updateOne({x:1}, {$set: {y: 1}})
	-- 事务内的读取
	co_20210528.findOne({x: 1})	
																-- 事务外的读取
																db.co_20210528.findOne({x: 1})
	session.commitTransaction()
																db.co_20210528.findOne({x: 1})
																
																
	-------------------------------------------------------------------------

	repl_set:PRIMARY> session = db.getMongo().startSession()
	session { "id" : UUID("fd499178-3f12-464d-9c22-e3307e2f0c69") }
	repl_set:PRIMARY> session.startTransaction()
	repl_set:PRIMARY> co_20210528 = session.getDatabase("test_db").co_20210528
	test_db.co_20210528
	repl_set:PRIMARY> co_20210528.updateOne({x:1}, {$set: {y: 1}})
	{ "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }
	repl_set:PRIMARY> co_20210528.findOne({x: 1})
	{ "_id" : ObjectId("60b36649a5df5ac6c49874a4"), "x" : 1, "y" : 1 }
					
																-- 事务外的读取，不能读取未提交事务的数据
																-- 内部实现也是基于MVCC的多版本控制
																repl_set:SECONDARY> db.co_20210528.findOne({x: 1})
																{ "_id" : ObjectId("60b36649a5df5ac6c49874a4"), "x" : 1 }
																	
	repl_set:PRIMARY> session.commitTransaction()
	
																repl_set:SECONDARY> db.co_20210528.findOne({x: 1})
																{ "_id" : ObjectId("60b36649a5df5ac6c49874a4"), "x" : 1, "y" : 1 }



3. 可重复读隔离级别的实验


	session A(192.168.0.201) 									session B(192.168.0.201) 	
	
	use test_db
	db.co_20210528.drop()
	db.co_20210528.insertMany([{x:1}, {x:2}])
	db.co_20210528.find()
	{ "_id" : ObjectId("60b36deda5df5ac6c49874a8"), "x" : 1 }
	{ "_id" : ObjectId("60b36deda5df5ac6c49874a9"), "x" : 2 }



																use test_db
																db.co_20210528.find()
																{ "_id" : ObjectId("60b36deda5df5ac6c49874a8"), "x" : 1 }
																{ "_id" : ObjectId("60b36deda5df5ac6c49874a9"), "x" : 2 }




	session = db.getMongo().startSession()
	session.startTransaction({readConcern: {level: "snapshot"}, writeConcern: {w: "majority"}})
	co_20210528 = session.getDatabase("test_db").co_20210528
	co_20210528.findOne({x: 1})	
	-- 第一次读取的结果
	{ "_id" : ObjectId("60b36deda5df5ac6c49874a8"), "x" : 1 }  

																db.co_20210528.updateOne({x:1}, {$set: {y: 1}})
																{ "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }

																db.co_20210528.findOne({x: 1})	
																{ "_id" : ObjectId("60b36deda5df5ac6c49874a8"), "x" : 1, "y" : 1 }
	-- 第二次读取的结果
	co_20210528.findOne({x: 1})	
	{ "_id" : ObjectId("60b36deda5df5ac6c49874a8"), "x" : 1 }	
	
	session.commitTransaction()
	
																
	-------------------------------------------------------------------------


4. 事务内WriteConflict写冲突的处理


	session A(192.168.0.201) 									session B(192.168.0.201) 														
	
	use test_db
	db.co_20210528.drop()
	db.co_20210528.insertMany([{x:1}, {x:2}])
	db.co_20210528.find()
	{ "_id" : ObjectId("60b399cc80276b51da465941"), "x" : 1 }
	{ "_id" : ObjectId("60b399cc80276b51da465942"), "x" : 2 }




																use test_db
																db.co_20210528.find()
																{ "_id" : ObjectId("60b399cc80276b51da465941"), "x" : 1 }
																{ "_id" : ObjectId("60b399cc80276b51da465942"), "x" : 2 }





	session = db.getMongo().startSession()
	session.startTransaction({readConcern: {level: "snapshot"}, writeConcern: {w: "majority"}})
	co_20210528 = session.getDatabase("test_db").co_20210528
	
																session = db.getMongo().startSession()
																session.startTransaction({readConcern: {level: "snapshot"}, writeConcern: {w: "majority"}})
																co_20210528 = session.getDatabase("test_db").co_20210528

	
	co_20210528.updateOne({x:1}, {$set: {y: 1}})
	{ "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }

																co_20210528.updateOne({x:1}, {$set: {y: 2}})
																																
																2021-05-30T21:58:30.479+0800 E  QUERY    [js] uncaught exception: WriteCommandError({
																	"errorLabels" : [
																		"TransientTransactionError"
																	],
																	"operationTime" : Timestamp(1622383108, 1),
																	"ok" : 0,
																	"errmsg" : "WriteConflict",
																	"code" : 112,
																	"codeName" : "WriteConflict",
																	"$clusterTime" : {
																		"clusterTime" : Timestamp(1622383108, 1),
																		"signature" : {
																			"hash" : BinData(0,"ih+OSExSKk78oLZTzAg7QoPNLIA="),
																			"keyId" : NumberLong("6966433397879078915")
																		}
																	}
																}) :
																WriteCommandError({
																	"errorLabels" : [
																		"TransientTransactionError"
																	],
																	"operationTime" : Timestamp(1622383108, 1),
																	"ok" : 0,
																	"errmsg" : "WriteConflict",
																	"code" : 112,
																	"codeName" : "WriteConflict",
																	"$clusterTime" : {
																		"clusterTime" : Timestamp(1622383108, 1),
																		"signature" : {
																			"hash" : BinData(0,"ih+OSExSKk78oLZTzAg7QoPNLIA="),
																			"keyId" : NumberLong("6966433397879078915")
																		}
																	}
																})
																WriteCommandError@src/mongo/shell/bulk_api.js:417:48
																executeBatch@src/mongo/shell/bulk_api.js:915:23
																Bulk/this.execute@src/mongo/shell/bulk_api.js:1163:21
																DBCollection.prototype.updateOne@src/mongo/shell/crud_api.js:600:17
																@(shell):1:1

																
	session.commitTransaction()
																-- 重启事务
																session.abortTransaction()    
																session.startTransaction({readConcern: {level: "snapshot"}, writeConcern: {w: "majority"}})
																co_20210528 = session.getDatabase("test_db").co_20210528
																co_20210528.updateOne({x:1}, {$set: {y: 2}})								
																session.commitTransaction()
																repl_set:PRIMARY> db.co_20210528.find()
																{ "_id" : ObjectId("60b399cc80276b51da465941"), "x" : 1, "y" : 2 }
																{ "_id" : ObjectId("60b399cc80276b51da465942"), "x" : 2 }

	
	-- 2个事务同时更新同一行数据，被阻塞的事务会出现异常，需要重启事务。

5. 事务内和事务外的WriteConflict写冲突的处理

	session A(192.168.0.201)                      session B(192.168.0.201) 		
	
	use test_db
	db.co_20210528.drop()
	db.co_20210528.insertMany([{x:1}, {x:2}])
	db.co_20210528.find()
												  
												  db.co_20210528.find()
												  
												  
	session = db.getMongo().startSession()
	session.startTransaction({readConcern: {level: "snapshot"}, writeConcern: {w: "majority"}})
	co_20210528 = session.getDatabase("test_db").co_20210528
	co_20210528.updateOne({x:1}, {$set: {y: 1}})	
												
												  db.co_20210528.updateOne({x:1}, {$set: {y: 10}})
												  (Blocked)
	
	session.commitTransaction()
												  (Query OK)
												  { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }
												  
												  repl_set:PRIMARY> db.co_20210528.find()
												  { "_id" : ObjectId("60b39aec80276b51da465943"), "x" : 1, "y" : 10 }
												  { "_id" : ObjectId("60b39aec80276b51da465944"), "x" : 2 }
	
	
	repl_set:PRIMARY> db.co_20210528.find()
	{ "_id" : ObjectId("60b39aec80276b51da465943"), "x" : 1, "y" : 10 }
	{ "_id" : ObjectId("60b39aec80276b51da465944"), "x" : 2 }

	
	-- 事务外更新，会出现等待。
	
	
	