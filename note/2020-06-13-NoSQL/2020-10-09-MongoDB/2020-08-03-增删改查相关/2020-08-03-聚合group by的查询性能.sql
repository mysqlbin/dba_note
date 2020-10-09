
1. 造200W行数据
2. 创建索引
3. 造1000W行数据
4. group by分组测试1
5. group by分组测试2
6. 问题
7. 相关参考

1. 造200W行数据

	for (i=0; i<5; i++) {db.t1.insert({
	"i" : i,
	 "username" : "user"+i,
	 "age" : Math.floor(Math.random()*1000000),
	 "created" : new Date()
	 })}
	 
	 
	for (i=0; i<10000; i++) {db.table_fish_bullet_record.insert({
		"nBulletID" : i,
		"nPlayerID" : Math.floor(Math.random()*6),
		"szToken" : "99-1596420318-3",
		"created" : new Date(),
		"nBulletPrice" : Math.floor(Math.random()*50),
		"nFishPrice" : Math.floor(Math.random()*20),
		"nFishType" : Math.floor(Math.random()*4),
		"capture" : 1
	})}
	 

	for (i=0; i<50000; i++) {db.table_fish_bullet_record.insert({
		"nBulletID" : i,
		"nPlayerID" : Math.floor(Math.random()*6),
		"szToken" : "99-1596420318-4",
		"created" : new Date(),
		"nBulletPrice" : Math.floor(Math.random()*50),
		"nFishPrice" : Math.floor(Math.random()*20),
		"nFishType" : Math.floor(Math.random()*4),
		"capture" : 1
	})}
	 
	 
	 
	for (i=0; i<1000000; i++) {db.table_fish_bullet_record.insert({
		"nBulletID" : i,
		"nPlayerID" : Math.floor(Math.random()*6),
		"szToken" : "99-1596420318-5",
		"created" : new Date(),
		"nBulletPrice" : Math.floor(Math.random()*50),
		"nFishPrice" : Math.floor(Math.random()*20),
		"nFishType" : Math.floor(Math.random()*4),
		"capture" : 1
	})}


	 
	for (i=0; i<1000000; i++) {db.table_fish_bullet_record.insert({
		"nBulletID" : i,
		"nPlayerID" : Math.floor(Math.random()*6),
		"szToken" : Math.floor(Math.random()*1000000),
		"created" : new Date(),
		"nBulletPrice" : Math.floor(Math.random()*50),
		"nFishPrice" : Math.floor(Math.random()*20),
		"nFishType" : Math.floor(Math.random()*4),
		"capture" : 1
	})}


	repl_set:PRIMARY> db.table_fish_bullet_record.count()
	2060000


2. 创建索引

	db.table_fish_bullet_record.createIndex( {szToken: 1,nBulletID: 1} ) 
	
	

-------------------------------------------------------------

3. 造1000W行数据

	for (i=0; i<8000000; i++) {db.table_fish_bullet_record.insert({
		"nBulletID" : i,
		"nPlayerID" : Math.floor(Math.random()*6),
		"szToken" : Math.floor(Math.random()*10000000),
		"created" : new Date(),
		"nBulletPrice" : Math.floor(Math.random()*50),
		"nFishPrice" : Math.floor(Math.random()*20),
		"nFishType" : Math.floor(Math.random()*4),
		"capture" : 1
	})}
	
	
	for (i=0; i<100000; i++) {db.table_fish_bullet_record.insert({
		"nBulletID" : i,
		"nPlayerID" : Math.floor(Math.random()*6),
		"szToken" : "99-1596420318-10",
		"created" : new Date(),
		"nBulletPrice" : Math.floor(Math.random()*50),
		"nFishPrice" : Math.floor(Math.random()*20),
		"nFishType" : Math.floor(Math.random()*50),
		"capture" : 1
	})}
 
	repl_set:PRIMARY>  db.table_fish_bullet_record.count()
	10160000


4. group by分组测试1

	总共有200W行记录
	"szToken" : "99-1596420318-3" 有1W行, 并且这1W行有4个鱼类型 
	查询如下
		db.table_fish_bullet_record.aggregate([
		{
			$match: {"szToken" : "99-1596420318-3"},
		},
		{
		  $group : {
			"_id" : "$nFishType",
			sum_nBulletPrice : {$sum: "$nBulletPrice"},
			sum_nFishPrice : {$sum: "$nFishPrice"},
			counts : {$sum: 1} 
		  }
		}
		])

	-- 平均耗时约：0.08S


5. group by分组测试2

	总共有1000W行记录
	"szToken" : "99-1596420318-10" 有10W行，并且这10W行有50个鱼类型 
	查询如下
		db.table_fish_bullet_record.aggregate([
		{
			$match: {"szToken" : "99-1596420318-10"},
		},
		{
		  $group : {
			"_id" : "$nFishType",
			sum_nBulletPrice : {$sum: "$nBulletPrice"},
			sum_nFishPrice : {$sum: "$nFishPrice"},
			counts : {$sum: 1} 
		  }
		}
		])

	-- 平均耗时约：0.30S
	
	
6. 问题
	MongoDB分组统计语句：
	db.table_fish_bullet_record.aggregate([
		{
			$match: {"szToken" : "99-1596420318-10"},
		},
		{
		  $group : {
			"_id" : "$nFishType",
			sum_nBulletPrice : {$sum: "$nBulletPrice"},
			sum_nFishPrice : {$sum: "$nFishPrice"},
			counts : {$sum: 1} 
		  }
		}
	])

	我的问题：
	怎么在分组统计把两个sum的值相减，比如 sum_nBulletPrice - sum_nFishPrice
	然后加入 group by中：
	db.table_fish_bullet_record.aggregate([
		{
			$match: {"szToken" : "99-1596420318-10"},
		},
		{
		  $group : {
			"_id" : "$nFishType",
			sum_nBulletPrice : {$sum: "$nBulletPrice"},
			sum_nFishPrice : {$sum: "$nFishPrice"},
			counts : {$sum: 1},
			sum_subtract : sum_nBulletPrice - sum_nFishPrice,
		  }
		}
	])
	
	
7. 相关参考
	https://mp.weixin.qq.com/s/GhCLnK3dSAngFggrX2rxuA   MongoDB 常用查询操作

	https://www.cnblogs.com/wslook/p/9831842.html mongoTemplate.aggregate()聚合查询

	https://docs.mongodb.com/manual/reference/operator/aggregation/

	https://docs.mongodb.com/manual/reference/operator/aggregation/group/  







