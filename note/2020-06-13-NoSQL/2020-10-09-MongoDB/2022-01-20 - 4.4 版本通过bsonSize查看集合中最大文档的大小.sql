



db.table_play_back.aggregate([
  {"$project": {"playBackCode": 1,"task_object_size": { $bsonSize: "$$ROOT" }}},
  { $sort: { "task_object_size" : -1 } },
  { $limit: 1 }
])
{ "_id" : ObjectId("6019457a0f6d744c59727a58"), "playBackCode" : "10000052", "task_object_size" : 2146 }

2146 bytes = 2 KB


------------------------------------------------------------------------------------------------------------------------------------

db.table_league_user_pic_large.aggregate([
  {"$project": {"nPlayerId": "$nPlayerId", "task_object_size": { $bsonSize: "$$ROOT" }}},
  { $sort: { "task_object_size" : -1 } },
  { $limit: 1 }
])
{ "_id" : ObjectId("61e90a86390a05d83f0acfb2"), "nPlayerId" : "2021-07-23 08:19:05", "task_object_size" : 224031 }

224031 bytes = 218 KB




table_play_back表，最大的行占用 59KB 大小。
table_league_user_pic_large表，最大的行占用 218KB 大小。



-----------------------------------
	
	
-- 集合中的最小文档大小：
db.table_league_user_pic_large.aggregate([
  {"$project": {"nPlayerId": "$nPlayerId", "task_object_size": { $bsonSize: "$$ROOT" }}},
  { $sort: { "task_object_size" : 1 } },
  { $limit: 1 }
])

{ "_id" : ObjectId("61e90a84390a05d83f0acb88"), "nPlayerId" : "createTime", "task_object_size" : 142 }
> 


相关参考
	https://www.modb.pro/db/41182
	https://docs.mongodb.com/manual/reference/operator/aggregation/bsonSize/



time /usr/local/mongodb/bin/mongoimport --host "192.168.0.241:27017" -d niuniu_h5 -c table_league_user_pic_large -f  createTime,nPlayerId,picdata,upszNickName  --type csv  --file table_league_user_pic_large.csv



db.table_play_back.find({'$and': [ {'CreateTime': {'$lt': '2020-07-01 15:12:33'}} ] })


db.table_play_back.find({'$and': [ {'CreateTime': {'$gt': ISODate('2022-07-02 04:00:00')}}})



db.table_play_back.find({'CreateTime' : {$gt : ISODate('2021-12-20 00:00:00')}})



time /usr/local/mongodb/bin/mongoimport --host "192.168.0.241:27017" -d niuniu_h5 -c table_play_back -f  playBackCode,playBackData,CreateTime  --type csv  --file table_play_back.csv
