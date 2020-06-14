
要在 admin 系统库下授权
	use sbtest_db

	use admin
	db.createUser( {
		user: "app_user",
		pwd: "app123456",
		roles: [ 
			{ role: "readWrite", db: "sbtest_db" }
		]
	} )

	use admin
	db.createUser( {
		user: "web_user",
		pwd: "web123456",
		roles: [ 
			{ role: "read", db: "sbtest_db" }
		]
	} )


	
删除账号
	use admin
	db.dropUser('app_user')
	db.dropUser('web_user')
	
登录

	mongo -host 192.168.1.31 -u app_user -p app123456
	
	use sbtest_db
	db.t1.insert({'age': "111"})
	> db.t1.find()
	{ "_id" : ObjectId("5ee43cd2da6851bfb99691cd"), "age" : "111" }
	
	
	mongo -host 192.168.1.31 -u web_user -p web123456
	use sbtest_db
	db.t1.insert({'age': "222"})
	WriteCommandError({
		"ok" : 0,
		"errmsg" : "not authorized on sbtest_db to execute command { insert: \"t1\", ordered: true, lsid: { id: UUID(\"0743aa2f-ea2c-4523-ab3d-7592e5082a28\") }, $db: \"sbtest_db\" }",
		"code" : 13,
		"codeName" : "Unauthorized"
	})
	> db.t1.find()
	{ "_id" : ObjectId("5ee43cd2da6851bfb99691cd"), "age" : "111" }
	
	

	
	
	mongo -host 192.168.1.31 -u app_user -p app123456 --authenticationDatabase sbtest_db