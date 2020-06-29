


1. 遍历集合
2. 根据 ObjectId 获取 ISO格式的时间
3. ISO格式的时间 转为  标准的年月日 时分秒
4. 根据  标准的年月日 时分秒 做比较，小于32天的就删除
----------------------------------------------------

这么麻烦，不如直接遍历集合取 tEndTime 做判断
但是，遍历整个集合意味着没有索引，不能根据索引定位到要删除记录的位置，因此全集合扫描。

类似MySQL的时间字段有索引，可以根据索引定位到要删除记录的位置，只需要扫描需要删除记录的大小，不需要全表扫描。



repl_set:PRIMARY> db.abc.find()
{ "_id" : ObjectId("5eec35debbdf90b02ffe8fea"), "date" : ISODate("2020-06-19T11:49:49.672Z"), "idx" : 100 }
{ "_id" : ObjectId("5eec3683bbdf90b02ffe8feb"), "date" : ISODate("2020-06-19T11:52:32.875Z"), "idx" : 200 }


repl_set:PRIMARY> ObjectId("5eec35debbdf90b02ffe8fea").getTimestamp()
ISODate("2020-06-19T03:49:50Z")


4e7020cb  -- 1315971275
5eec35de  -- 1592538590


db.abc.find().limit(1)

