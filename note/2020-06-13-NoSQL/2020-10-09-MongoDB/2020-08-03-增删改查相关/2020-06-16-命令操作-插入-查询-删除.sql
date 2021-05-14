

如何查看和修改 系统参数 变量

1. 插入单个文档
2. 批量插入多个文档
3. 删除集合中的所有文档
4. 清空整个集合	
5. 修改/更新
6. 查询
7. OR 查询
8. 查询数组
9. 在不同字段中使用 and
10. 查询最后一个文档


1. 插入单个文档
	repl_set:PRIMARY> use abc_db
	switched to db abc_db


	repl_set:PRIMARY> db.foo.insert({"bar" : "baz"})
	WriteResult({ "nInserted" : 1 })
	repl_set:PRIMARY> 
	repl_set:PRIMARY> db.foo.find()
	{ "_id" : ObjectId("5ddee9ccd514eb7772049dc3"), "bar" : "baz" }


2. 批量插入多个文档
	repl_set:PRIMARY> use test_db
	switched to db test_db

	repl_set:PRIMARY> db.foo.batchInsert([{"_id" : 0}, {"_id" : 1}, {"_id" : 2}])
	2019-11-28T05:29:32.974+0800 E QUERY    [js] TypeError: db.foo.batchInsert is not a function :
	@(shell):1:1
	# 不再支持 batchInsert 函数.
	
	repl_set:PRIMARY> db.version()
	4.0.13
	
	repl_set:PRIMARY> db.foo.insert([{"_id" : 0}, {"_id" : 1}, {"_id" : 2}])
	BulkWriteResult({
		"writeErrors" : [ ],
		"writeConcernErrors" : [ ],
		"nInserted" : 3,
		"nUpserted" : 0,
		"nMatched" : 0,
		"nModified" : 0,
		"nRemoved" : 0,
		"upserted" : [ ]
	})

	

3. 删除集合中的所有文档
		
	db.foo.remove({})    # 不会删除集合本身，也不会删除集合的元信息。

4. 清空整个集合	

	db.foo.drop()      # 删除集合本身 和 集合的元数据


删除单个文档
	db.table_clubgamelog.remove({'szToken':'10002-890598-1593716379-1-3'})



5. 修改/更新
	
	
6. 查询
	db.foo.find()   # 查询返回所有文档

	db.foo.find({"age" : 27})   # 查询 age=27 的所有文档
	db.foo.find({"username" : "bin"})   # 查询  username='bin' 的所有文档

	db.foo.find({"age" : 27, "username" : "bin"})   # 查询 age=27 并且 username=bin 的所有文档

	repl_set:PRIMARY> db.foo.insert({"username" : "bin", "age" : 27, "email" : "122405623@qq.com"})
	WriteResult({ "nInserted" : 1 })
		
	repl_set:PRIMARY> db.foo.find({}, {"username" : 1, "email" : 1})   # 返回指定的键: username, email
	{ "_id" : ObjectId("5ddf12bcd514eb7772049dc9"), "username" : "bin", "email" : "122405623@qq.com" }
	
	repl_set:PRIMARY> db.foo.insert({"username" : "jian", "age" : 30, "email" : "122405623@163.com"})
	WriteResult({ "nInserted" : 1 })
	
	repl_set:PRIMARY> db.foo.find()
	{ "_id" : ObjectId("5ddf12bcd514eb7772049dc9"), "username" : "bin", "age" : 27, "email" : "122405623@qq.com" }
	{ "_id" : ObjectId("5ddf131ad514eb7772049dca"), "username" : "jian", "age" : 30, "email" : "122405623@163.com" }

	比较操作符
		
		运算符	     描述
		$lt          <
		$lte         <=
		$gt			 >
		$gte         >=
		
	
	db.foo.find({"age" : {"$gt" : 25, "$lt" : 30}})         查询  age > 25 and age < 30 的所有文档
	repl_set:PRIMARY> db.foo.find({"age" : {"$gt" : 25, "$lt" : 30}})
	{ "_id" : ObjectId("5ddf12bcd514eb7772049dc9"), "username" : "bin", "age" : 27, "email" : "122405623@qq.com" }
			

	
7. OR 查询
	$in 查询
		repl_set:PRIMARY> db.foo.insert({"username" : "lu", "age" : 35, "email" : "abc@163.com"})
		WriteResult({ "nInserted" : 1 })
		
		db.foo.find({"age" : {"$in" : [27, 30]}})
	
		repl_set:PRIMARY> db.foo.find()
		{ "_id" : ObjectId("5ddf12bcd514eb7772049dc9"), "username" : "bin", "age" : 27, "email" : "122405623@qq.com" }
		{ "_id" : ObjectId("5ddf131ad514eb7772049dca"), "username" : "jian", "age" : 30, "email" : "122405623@163.com" }
		{ "_id" : ObjectId("5ddf1a83d514eb7772049dcb"), "username" : "lu", "age" : 35, "email" : "abc@163.com" }

		repl_set:PRIMARY> db.foo.find({"age" : {"$in" : [27, 30]}})
		{ "_id" : ObjectId("5ddf12bcd514eb7772049dc9"), "username" : "bin", "age" : 27, "email" : "122405623@qq.com" }
		{ "_id" : ObjectId("5ddf131ad514eb7772049dca"), "username" : "jian", "age" : 30, "email" : "122405623@163.com" }
	
	$nin 查询
		repl_set:PRIMARY> db.foo.find({"age" : {"$nin" : [27, 30]}})
		{ "_id" : ObjectId("5ddf1a83d514eb7772049dcb"), "username" : "lu", "age" : 35, "email" : "abc@163.com" }
		
	$or 查询
		repl_set:PRIMARY> db.foo.find({"$or" : [{"username" : "bin"}, {"age" : 30}]})
		{ "_id" : ObjectId("5ddf12bcd514eb7772049dc9"), "username" : "bin", "age" : 27, "email" : "122405623@qq.com" }
		{ "_id" : ObjectId("5ddf131ad514eb7772049dca"), "username" : "jian", "age" : 30, "email" : "122405623@163.com" }

8. 查询数组
1. $all
	db.food.insert({"_id" : 1, "fruit" : ["apple", "banana", "peach"]})
	db.food.insert({"_id" : 2, "fruit" : ["apple", "kumquat", "orange"]})
	db.food.insert({"_id" : 3, "fruit" : ["cherry", "banana", "apple"]})
	
	# 查询既有 "apple" 又有 "banana" 的文档
	repl_set:PRIMARY> db.food.find({fruit : {$all : ["apple", "banana"]}})       # 这里的顺序无关紧要
	{ "_id" : 1, "fruit" : [ "apple", "banana", "peach" ] }
	{ "_id" : 3, "fruit" : [ "cherry", "banana", "apple" ] }

	
	repl_set:PRIMARY> db.food.find({fruit :["apple", "banana"]})
	repl_set:PRIMARY> 
	
	# 查询数组特定位置的元素, 需要使用 key.index 语法指定下标, 数组下标是从0开始
	repl_set:PRIMARY> db.food.find({"fruit.2" : "peach"})
	{ "_id" : 1, "fruit" : [ "apple", "banana", "peach" ] }
	
2. $size
	
	$size是匹配数组内的元素数量的(查询特定长度的数组)，如有一个对象：{a:["foo"]}，他只有一个元素：
		下面的语句就可以匹配：

		db.things.find( { a : { $size: 1 } } ); 
	
	repl_set:PRIMARY> db.food.find({"fruit" : {"$size" : 3}})
	{ "_id" : 1, "fruit" : [ "apple", "banana", "peach" ] }
	{ "_id" : 2, "fruit" : [ "apple", "kumquat", "orange" ] }
	{ "_id" : 3, "fruit" : [ "cherry", "banana", "apple" ] }

	repl_set:PRIMARY> db.food.find({"fruit" : {"$size" : 2}})
	repl_set:PRIMARY> db.food.find({"fruit" : {"$size" : 1}})
	repl_set:PRIMARY> 
	
	
	repl_set:PRIMARY> db.food.update(criteria, {"$push" : {"fruit" : "strawberry"}, "$inc" : {"size" : 1}})
	2019-12-03T18:50:33.190+0800 E QUERY    [js] ReferenceError: criteria is not defined :
	@(shell):1:1

	

9. 在不同字段中使用 and
		
	CreateTime <  ISODate('2020-07-02 04:00:00') and tEndTime < '2020-07-01 15:12:33'

	db.table_clubgamelog.find({'$and': [ {'CreateTime': {'$lt': ISODate('2020-07-02 04:00:00')}},  {'tEndTime': {'$lt': '2020-07-01 15:12:33'}} ] })
	
	repl_set:SECONDARY> db.table_report_log.find({"nplayerid" : 126213}).sort({"_id":-1}).limit(1)
	{ "_id" : ObjectId("5feff5e09cea903206aad573"), "CreateTime" : ISODate("2021-01-02T04:26:08Z"), "mark" : "", "nplayerid" : 126213, "tag" : "errorexception", "val" : 0 }
	-- 组合查询
	repl_set:SECONDARY> db.table_report_log.find({'$and': [ {'CreateTime': {'$gt': ISODate('2021-01-02T03:00:00Z')}},  {'nplayerid': 126213} ] })
	{ "_id" : ObjectId("5feff5e09cea903206aad573"), "CreateTime" : ISODate("2021-01-02T04:26:08Z"), "mark" : "", "nplayerid" : 126213, "tag" : "errorexception", "val" : 0 }
	
		table_report_log    mongo 这个表里，查找 

		1：nPlayerID = 234143 and CreateTime > 20210220 以后的数据

		2：nPlayerID = 189288 and CreateTime > 20210217 以后的数据


10. 查询最后一个文档
	db.table_clubgamelog.find().sort({"_id":-1}).limit(1)
	db.table_clubgamescorerobotdetail.find().sort({"_id":-1}).limit(1)


11. 删除数据库
	repl_set:PRIMARY> use abc_db
	switched to db abc_db
	repl_set:PRIMARY> db.dropDatabase()
	{
		"dropped" : "abc_db",
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1599721912, 11),
			"signature" : {
				"hash" : BinData(0,"p51L+zyZRE6Ltsy75uLiIxbI20M="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1599721912, 11)
	}
	repl_set:PRIMARY> show dbs
	admin      0.000GB
	benet      0.000GB
	config     0.000GB
	local      2.491GB
	niuniu_h5  6.482GB
	test       0.049GB
	
	https://www.runoob.com/mongodb/mongodb-dropdatabase.html  MongoDB 删除数据库


	
