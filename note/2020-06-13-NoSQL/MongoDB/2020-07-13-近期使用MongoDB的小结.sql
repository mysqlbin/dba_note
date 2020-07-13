
1. 当前实例的Mongodb集合已经有数据，是否可以通过别的实例备份同一个集合的数据，然后导入备份的数据到当前实例已有集合中，而不影响已经有的数据？
2. 集合写入的数据跟导入的数据key的位置/先后顺序不一样，是否有问题？
3. 在当前实例备份某个文档的数据，再往当前实例中导入备份，会报 ObjectID 冲突


1. 当前实例的Mongodb集合已经有数据，是否可以通过别的实例备份同一个集合的数据，然后导入备份的数据到当前实例已有集合中，而不影响已经有的数据？
	不影响。
	没有 schema 的设计，还是挺灵活的。


2. 集合写入的数据跟导入的数据key的位置/先后顺序不一样，是否有问题？

	不会有问题。
	
	导入的数据：
		repl_set:PRIMARY> db.table_clubgamescorerobotdetail.findOne({"szToken": "10001-649413-1575254160-1"})
		{
			"_id" : ObjectId("5f07c26053b953b6b8bd5a7b"),
			"nResultMoney" : 3800,
			"nServerID" : 2501,
			"nBetScore" : 4000,
			"bRobot" : 1
			
		}

	应用程序写入的数据
		repl_set:PRIMARY> db.table_clubgamescorerobotdetail.findOne({"szToken": "10001-532706-1594634034-1"})
		{
			"_id" : ObjectId("5f0c2fb23f2609480e7a3bc4"),
			"nBetScore" : 4000,
			"bRobot" : 1,
			"nResultMoney" : 3800,
			"nServerID" : 2501
		}


	
3. 在当前实例备份某个文档的数据，再往当前实例中导入备份，会报 ObjectID 冲突
	原因：ObjectID 是全局唯一的。



	