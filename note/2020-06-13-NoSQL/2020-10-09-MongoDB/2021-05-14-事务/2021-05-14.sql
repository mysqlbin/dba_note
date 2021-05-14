



1. 不支持在单机中使用事务

	> session = db.getMongo().startSession()
	session { "id" : UUID("ff107430-15c1-46ed-8f70-a44df9da10ae") }
	> session.startTransaction()
	> t1 = session.getDatabase("test_db").t1
	test_db.t1
	> t1.update({'nPlayerid':10},{$set:{'scores':-5}})
	WriteCommandError({
		"ok" : 0,
		"errmsg" : "Transaction numbers are only allowed on a replica set member or mongos",
		"code" : 20,
		"codeName" : "IllegalOperation"
	})

	执行更新操作的时候报错了。



2. 在副本集中使用事务 
	
	2.1 初始化数据
	
		t1表插入1行记录：db.t1.insert({"nPlayerid" : 10, "scores" : 10, "name" : "abc"})
		
		t2表插入1行记录：db.t2.insert({"nPlayerid" : 10, "scores" : 10, "name" : "abc"})
		
	
	2.2 commitTransaction()提交事务 
	
		步骤的说明          					操作事务次序
		
		获取session  							session = db.getMongo().startSession()
		声明事务								session.startTransaction()
		获得表t1的collection					t1 = session.getDatabase("test_db").t1
		t1.nPlayerid=10 的 scores字段 减5分		t1.update({'nPlayerid':10},{ $inc: { 'scores': -5 }})   
		获得表t2的collection					t2 = session.getDatabase("test_db").t2
		t2.nPlayerid=10 的 scores字段 加5分		t2.update({'nPlayerid':10},{ $inc: { 'scores': 5 }})     
		提交事务								session.commitTransaction()        
			
		
		查看更新后数据
		
			repl_set:PRIMARY> db.t1.find({"nPlayerid" : 10})
			{ "_id" : ObjectId("609e17a74ac2171e138830d8"), "nPlayerid" : 10, "scores" : 5, "name" : "abc" }
			repl_set:PRIMARY> db.t2.find({"nPlayerid" : 10})
			{ "_id" : ObjectId("609e17a74ac2171e138830db"), "nPlayerid" : 10, "scores" : 15, "name" : "abc" }

			-- t1.nPlayerid=10 的 scores字段 减5分 成功。
			-- t2.nPlayerid=10 的 scores字段 加5分 成功。

	2.3 abortTransaction()回滚事务 
		先查看数据:
			repl_set:PRIMARY> db.t1.find()
			{ "_id" : ObjectId("609e17a74ac2171e138830d8"), "nPlayerid" : 10, "scores" : 5, "name" : "abc" }
			
			repl_set:PRIMARY> db.t2.find()
			{ "_id" : ObjectId("609e17a74ac2171e138830db"), "nPlayerid" : 10, "scores" : 15, "name" : "abc" }
		
		步骤的说明          					操作事务次序
		
		获取session  							session = db.getMongo().startSession()
		声明事务								session.startTransaction()
		获得表t1的collection					t1 = session.getDatabase("test_db").t1
		t1.nPlayerid=10 的 scores字段 减5分		t1.update({'nPlayerid':10},{ $inc: { 'scores': -5 }})    
		获得表t2的collection					t2 = session.getDatabase("test_db").t2
		t2.nPlayerid=10 的 scores字段 加5分		t2.update({'nPlayerid':10},{ $inc: { 'scores': 5 }})
		回滚事务								session.abortTransaction()        
			
	
		查看回滚后的数据
			repl_set:PRIMARY> db.t1.find({"nPlayerid" : 10})
			{ "_id" : ObjectId("609e17a74ac2171e138830d8"), "nPlayerid" : 10, "scores" : 5, "name" : "abc" }
			repl_set:PRIMARY> db.t2.find({"nPlayerid" : 10})
			{ "_id" : ObjectId("609e17a74ac2171e138830db"), "nPlayerid" : 10, "scores" : 15, "name" : "abc" }

			-- 没有变化。
	
	

1. 测试阻塞情况
	
	session A 											         session B 				
	session = db.getMongo().startSession()
	session.startTransaction()
	t1 = session.getDatabase("test_db").t1
	t1.update({'nPlayerid':10},{ $inc: { 'scores': -5 }})    
	
																db.t1.update({'nPlayerid':10},{ $inc: { 'scores': 10 }})
																(Blocked)	
																
																60秒后
																WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })


																repl_set:PRIMARY> db.t1.find()
																{ "_id" : ObjectId("609dece94ac2171e138830d2"), "nPlayerid" : 10, "scores" : -5, "name" : "abc" }
																{ "_id" : ObjectId("609dece94ac2171e138830d3"), "nPlayerid" : 20, "scores" : 20, "name" : "def" }
																{ "_id" : ObjectId("609dece94ac2171e138830d4"), "nPlayerid" : 30, "scores" : 30, "name" : "hik" }

	
	t2 = session.getDatabase("test_db").t2
	t2.update({'nPlayerid':10},{ $inc: { 'scores': 5 }})
	WriteCommandError({
		"errorLabels" : [
			"TransientTransactionError"
		],
		"operationTime" : Timestamp(1620965311, 1),
		"ok" : 0,
		"errmsg" : "Transaction 0 has been aborted.",
		"code" : 251,
		"codeName" : "NoSuchTransaction",
		"$clusterTime" : {
			"clusterTime" : Timestamp(1620965311, 1),
			"signature" : {
				"hash" : BinData(0,"h0l5cjwcTepnbBvUuf2eJUOlRt4="),
				"keyId" : NumberLong("6922357820717268993")
			}
		}
	})

	session.commitTransaction()
	2021-05-14T12:09:00.255+0800 E  QUERY    [js] uncaught exception: Error: command failed: {
		"errorLabels" : [
			"TransientTransactionError"
		],
		"operationTime" : Timestamp(1620965330, 4),
		"ok" : 0,
		"errmsg" : "Transaction 0 has been aborted.",
		"code" : 251,
		"codeName" : "NoSuchTransaction",
		"$clusterTime" : {
			"clusterTime" : Timestamp(1620965330, 4),
			"signature" : {
				"hash" : BinData(0,"lLz0mS275OXp77airSX5eEJQA78="),
				"keyId" : NumberLong("6922357820717268993")
			}
		}
	} :
	_getErrorWithCode@src/mongo/shell/utils.js:25:13
	doassert@src/mongo/shell/assert.js:18:14
	_assertCommandWorked@src/mongo/shell/assert.js:583:17
	assert.commandWorked@src/mongo/shell/assert.js:673:16
	commitTransaction@src/mongo/shell/session.js:971:17
	@(shell):1:1
	repl_set:PRIMA	
	
	
	-- 事务默认必须在60s（可调）没完成，会被取消。
	
	


更新操作没有索引，另1个事务执行更新同1个表不同一行的操作是否会出现阻塞
		
	repl_set:PRIMARY> db.t1.find();
	{ "_id" : ObjectId("609dece94ac2171e138830d2"), "nPlayerid" : 10, "scores" : -5, "name" : "abc" }
	{ "_id" : ObjectId("609dece94ac2171e138830d3"), "nPlayerid" : 20, "scores" : 20, "name" : "def" }
	{ "_id" : ObjectId("609dece94ac2171e138830d4"), "nPlayerid" : 30, "scores" : 30, "name" : "hik" }
	repl_set:PRIMARY> db.t2.find();
	{ "_id" : ObjectId("609dece94ac2171e138830d5"), "nPlayerid" : 10, "scores" : 15, "name" : "abc" }
	{ "_id" : ObjectId("609dece94ac2171e138830d6"), "nPlayerid" : 20, "scores" : 20, "name" : "def" }
	{ "_id" : ObjectId("609dece94ac2171e138830d7"), "nPlayerid" : 30, "scores" : 30, "name" : "hik" }
	repl_set:PRIMARY> 
	


	session A 											         session B 				
	session = db.getMongo().startSession()
	session.startTransaction()
	t1 = session.getDatabase("test_db").t1
	t1.update({'nPlayerid':10},{ $inc: { 'scores': -5 }})         
																db.t1.update({'nPlayerid':20},{ $inc: { 'scores': 10 }})
																WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })

	t2 = session.getDatabase("test_db").t2	
	t2.update({'nPlayerid':10},{ $inc: { 'scores': 5 }})
	session.commitTransaction()
	
	
	repl_set:PRIMARY> db.t1.find()
	{ "_id" : ObjectId("609dece94ac2171e138830d2"), "nPlayerid" : 10, "scores" : -10, "name" : "abc" }
	{ "_id" : ObjectId("609dece94ac2171e138830d3"), "nPlayerid" : 20, "scores" : 30, "name" : "def" }
	{ "_id" : ObjectId("609dece94ac2171e138830d4"), "nPlayerid" : 30, "scores" : 30, "name" : "hik" }
	repl_set:PRIMARY> db.t2.find()
	{ "_id" : ObjectId("609dece94ac2171e138830d5"), "nPlayerid" : 10, "scores" : 20, "name" : "abc" }
	{ "_id" : ObjectId("609dece94ac2171e138830d6"), "nPlayerid" : 20, "scores" : 20, "name" : "def" }
	{ "_id" : ObjectId("609dece94ac2171e138830d7"), "nPlayerid" : 30, "scores" : 30, "name" : "hik" }

	
	-- 不会阻塞，目前还不清楚相关的加锁原理
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------------

	
更新操作没有索引，另1个事务是否可以执行写入操作
	
	session A 											        session B 				
	session = db.getMongo().startSession()
	session.startTransaction()
	t1 = session.getDatabase("test_db").t1
	t1.update({'nPlayerid':10},{ $inc: { 'scores': -5 }})         		
	t2 = session.getDatabase("test_db").t2	
	t2.update({'nPlayerid':10},{ $inc: { 'scores': 5 }})
	
																
																
																db.t1.insert({"nPlayerid" : 40, "scores" : 40, "name" : "def"})
																(Query OK)
																db.t1.insert({"nPlayerid" : 10, "scores" : 10, "name" : "abc"})
																(Query OK)

	session.commitTransaction()
	
	
	
	repl_set:PRIMARY> db.t1.find();
	{ "_id" : ObjectId("609dece94ac2171e138830d2"), "nPlayerid" : 10, "scores" : -15, "name" : "abc" }
	{ "_id" : ObjectId("609dece94ac2171e138830d3"), "nPlayerid" : 20, "scores" : 30, "name" : "def" }
	{ "_id" : ObjectId("609dece94ac2171e138830d4"), "nPlayerid" : 30, "scores" : 30, "name" : "hik" }
	{ "_id" : ObjectId("609dfa10ec54606174fef443"), "nPlayerid" : 40, "scores" : 40, "name" : "def" }
	{ "_id" : ObjectId("609dfa17ec54606174fef444"), "nPlayerid" : 10, "scores" : 10, "name" : "abc" }
	repl_set:PRIMARY> db.t2.find();
	{ "_id" : ObjectId("609dece94ac2171e138830d5"), "nPlayerid" : 10, "scores" : 40, "name" : "abc" }
	{ "_id" : ObjectId("609dece94ac2171e138830d6"), "nPlayerid" : 20, "scores" : 20, "name" : "def" }
	{ "_id" : ObjectId("609dece94ac2171e138830d7"), "nPlayerid" : 30, "scores" : 30, "name" : "hik" }


	-- 可以。
	
	

other

	事务的隔离级别
		事务完成前，事务外的操作对该事务所做的修改不可访问
		如果事务内使用{readConcern:"snapshot"}，则可以达到可重复读 Repeatable Read


注意事项
	1. 可以实现和关系型数据库类似的事务场景
	2. 必须使用与MongoDB4.2兼容的驱动
	3. 事务默认必须在60s（可调）内完成，否则将被取消    --实践了
	4. 涉及事务的分片不能使用仲裁节点
	5. 事务会影响chunk迁移效率。正在迁移的chunk也可能造成事务提交失败（重试即可）
	6. 多文档事务中的读操作必须使用主节点读
	7. readConcern只应该在事务级别设置，不能设置在每次读写操作上


思考
	1. 查看加锁情况
	
		db.serverStatus()
		db.currentOp()
		
		
	2. 加锁是加在索引上不

	
	3. 如何查看长事务 
	
	

相关参考
	
	https://zhuanlan.zhihu.com/p/71679945   mongodb事务(Transaction)学习

	https://mongoing.com/archives/26201     是什么造成了数据库的卡顿

	https://www.cnblogs.com/duanxz/p/10737548.html   MongoDB中的读写锁


	https://www.cnblogs.com/xiaoqingtian/p/13510898.html   MongoDB学习6：MongoDB的事务处理

	https://docs.mongodb.com/v4.2/core/transactions/
		
	https://zhuanlan.zhihu.com/p/107278045
	
	
	https://mp.weixin.qq.com/s/Klyu8L8l7-c-Zpufza8Xtw   MySQL PK MongoDB：多文档事务支持，谁更友好？
	
	

MongoDB目前暂时不支持对查询到的数据加锁，也就是不支持像MySQL一样对查询操作加锁。
