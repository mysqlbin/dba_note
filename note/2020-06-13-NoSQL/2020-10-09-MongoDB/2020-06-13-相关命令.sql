


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
		
	得到当前集合的状态
		db.userInfo.stats();
		
	得到集合总大小
		db.userInfo.totalSize();
		
	集合储存空间大小
		db.userInfo.storageSize();	
		
	db.table_fish_bullet_record.dataSize(1048576);
	db.table_fish_bullet_record.count();
	
	
table_clubgamelog
table_clubgamescorerobotdetail
table_fish_bullet_record
table_fish_bullet_statistics
table_match_clubgamelog
table_match_clubgamescorerobotdetail
table_play_back
table_report_log


db.table_clubgamelog.dataSize()
db.table_clubgamescorerobotdetail.dataSize()
db.table_fish_bullet_record.dataSize()
db.table_fish_bullet_statistics.dataSize()
db.table_match_clubgamelog.dataSize()
db.table_match_clubgamescorerobotdetail.dataSize()
db.table_play_back.dataSize()
db.table_report_log.dataSize()




repl_set:SECONDARY> db.table_clubgamelog.dataSize()
9062638815
repl_set:SECONDARY> db.table_clubgamescorerobotdetail.dataSize()
4555881015
repl_set:SECONDARY> db.table_fish_bullet_record.dataSize()
21070954800
repl_set:SECONDARY> db.table_fish_bullet_statistics.dataSize()
224043004
repl_set:SECONDARY> db.table_match_clubgamelog.dataSize()
2216832151
repl_set:SECONDARY> db.table_match_clubgamescorerobotdetail.dataSize()
1105006135
repl_set:SECONDARY> db.table_play_back.dataSize()
0
repl_set:SECONDARY> db.table_report_log.dataSize()
360641409

