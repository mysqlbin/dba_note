

https://docs.mongodb.com/manual/reference/method/Date/
	
	在内部，Date对象存储为带符号的64位整数，表示自Unix纪元（1970年1月1日）以来的毫秒数。




--当前一共有4条记录， 其中两条为：ISODate("2020-07-01T06:30:11Z")，另外2条为： ISODate("2020-07-01T06:56:22Z")
	repl_set:PRIMARY> db.t0701.find()
	{ "_id" : ObjectId("5efc2d73b0a90c634cdd3114"), "i" : 0, "username" : "user0", "age" : 67, "created" : ISODate("2020-07-01T06:30:11.968Z") }
	{ "_id" : ObjectId("5efc2d73b0a90c634cdd3115"), "i" : 1, "username" : "user1", "age" : 64, "created" : ISODate("2020-07-01T06:30:11.985Z") }
	{ "_id" : ObjectId("5efc3396b0a90c634cdd3116"), "i" : 0, "username" : "user0", "age" : 36, "created" : ISODate("2020-07-01T06:56:22.155Z") }
	{ "_id" : ObjectId("5efc3396b0a90c634cdd3117"), "i" : 1, "username" : "user1", "age" : 101, "created" : ISODate("2020-07-01T06:56:22.156Z") }


--查询小于 ISODate('2020-07-01 06:32:00') 的：
	repl_set:PRIMARY> db.t0701.find({"created" : {"$lt" :  ISODate('2020-07-01 06:32:00')}})
	{ "_id" : ObjectId("5efc2d73b0a90c634cdd3114"), "i" : 0, "username" : "user0", "age" : 67, "created" : ISODate("2020-07-01T06:30:11.968Z") }
	{ "_id" : ObjectId("5efc2d73b0a90c634cdd3115"), "i" : 1, "username" : "user1", "age" : 64, "created" : ISODate("2020-07-01T06:30:11.985Z") }


--查询大于 ISODate('2020-07-01 06:32:00') 的：

	repl_set:PRIMARY> db.t0701.find({"created" : {"$gt" :  ISODate('2020-07-01 06:32:00')}})
	{ "_id" : ObjectId("5efc3396b0a90c634cdd3116"), "i" : 0, "username" : "user0", "age" : 36, "created" : ISODate("2020-07-01T06:56:22.155Z") }
	{ "_id" : ObjectId("5efc3396b0a90c634cdd3117"), "i" : 1, "username" : "user1", "age" : 101, "created" : ISODate("2020-07-01T06:56:22.156Z") }

	
	
	
db.table_clubgamelog.remove({"tEndTime" : {"$lt" :  '2020-07-02 04:00:00'}})
db.table_clubgamescorerobotdetail.remove({"tEndTime" : {"$lt" :  '2020-07-02 04:00:00'}})

db.table_clubgamelog.remove({"tEndTime" : {"$lt" :  ISODate('2020-07-02 04:00:00')}})
db.table_clubgamescorerobotdetail.remove({"tEndTime" : {"$lt" :  ISODate('2020-07-02 04:00:00')}})


db.table_clubgamelog.getIndexes()
db.table_clubgamescorerobotdetail.getIndexes()

db.table_clubgamelog.dropIndex("tEndTime_1")
db.table_clubgamescorerobotdetail.dropIndex("tEndTime_1")


db.table_clubgamelog.ensureIndex({"CreateTime" : 1})
db.table_clubgamescorerobotdetail.ensureIndex({"CreateTime" : 1})



db.table_clubgamelog.find({"CreateTime" : {"$lt" :  ISODate('2020-07-02 04:00:00')}}).explain()
db.table_clubgamescorerobotdetail.find().sort({"_id":-1}).limit(1)
db.table_clubgamelog.find().sort({"_id":-1}).limit(1)
db.table_report_log.find().sort({"_id":-1}).limit(1)

