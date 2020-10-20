
	


新建连接连到 149
	import pymongo
	from pymongo import MongoClient
	mongoserver_uri = "mongodb://test_user:test123456@80.91.99.149:27017/admin?replicaSet=repl_set"
	client = MongoClient(mongoserver_uri)
	db = client['test']
	collection = db['abc']
	x = collection.find_one()	
	print(x)
	{u'date': datetime.datetime(2020, 6, 19, 11, 49, 49, 672000), u'_id': ObjectId('5eec35debbdf90b02ffe8fea'), u'idx': 100}
	
	249宕机、223成为主库
		[root@database-02 ~]# mongo -host 80.91.99.149 -u admin -p admin123456
		repl_set:PRIMARY> 

		[root@database-02 ~]# mongo -host 80.91.99.149 -u admin -p admin123456
		MongoDB shell version v4.2.7
		connecting to: mongodb://80.91.99.149:27017/?compressors=disabled&gssapiServiceName=mongodb
		2020-06-19T14:14:45.316+0800 E  QUERY    [js] Error: couldnt connect to server 80.91.99.149:27017, connection attempt failed: SocketException: Error connecting to 80.91.99.149:27017 :: caused by :: Connection refused :
		connect@src/mongo/shell/mongo.js:341:17
		@(connect):2:6
		2020-06-19T14:14:45.317+0800 F  -        [main] exception: connect failed
		2020-06-19T14:14:45.317+0800 E  -        [main] exiting with code 1

	再次查询数据 --没有新建连接
		>>> print(x)
		{u'date': datetime.datetime(2020, 6, 19, 11, 49, 49, 672000), u'_id': ObjectId('5eec35debbdf90b02ffe8fea'), u'idx': 100}


使用新的连接
	import pymongo
	from pymongo import MongoClient
	mongoserver_uri = "mongodb://test_user:test123456@80.91.99.149:27017/admin?replicaSet=repl_set"
	client = MongoClient(mongoserver_uri)
	db = client['test']
	collection = db['abc']
	x = collection.find_one()	
	print(x)   --这里会卡住

使用新的连接
	import pymongo
	from pymongo import MongoClient
	mongoserver_uri = "mongodb://test_user:test123456@10.31.76.227:27017/admin?replicaSet=repl_set"
	client = MongoClient(mongoserver_uri)
	db = client['test']
	collection = db['abc']
	x = collection.find_one()	
	print(x)
	{u'date': datetime.datetime(2020, 6, 19, 11, 49, 49, 672000), u'_id': ObjectId('5eec35debbdf90b02ffe8fea'), u'idx': 100}
