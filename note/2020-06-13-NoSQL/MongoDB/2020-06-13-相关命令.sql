


db.t1.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
{ "_id" : null, "num_tutorial" : 500003 }

use niuniu_h5
db.test.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])

db.t1.stats(); 
db.t2.stats();

db.serverStatus
MongoDB查看当前连接数
	db.serverStatus().connections
	
	repl_set:PRIMARY> db.serverStatus().connections
	{ "current" : 139, "available" : 680, "totalCreated" : 1048, "active" : 2 }
	
	repl_set:SECONDARY> db.serverStatus().connections
	{ "current" : 6, "available" : 813, "totalCreated" : 206, "active" : 1 }


Collection聚集集合操作


	查询当前集合的数据条数
		db.yourColl.count();
		
	查看数据空间大小
		db.userInfo.dataSize();
		
	得到当前聚集的状态
		db.userInfo.stats();
		
	得到聚集集合总大小
		db.userInfo.totalSize();
		
	聚集集合储存空间大小
		db.userInfo.storageSize();	
		
	