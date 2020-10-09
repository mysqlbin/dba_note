

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
	 
	 
db.table_fish_bullet_record.find({"szToken" : "99-1596420318-3"}).limit(NUMBER).skip(NUMBER)


db.table_fish_bullet_record.find({"szToken" : "99-1596420318-3"}).sort({"_id":1}).skip(2).limit(2)

根据_id升序
limit：取多少条记录
skip ： 舍弃前面的多少条

