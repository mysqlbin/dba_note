


db.t1.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
{ "_id" : null, "num_tutorial" : 500003 }



db.t1.stats(); 
db.t2.stats();

db.serverStatus
db.serverStatus().connections


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
		
	