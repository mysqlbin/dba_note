
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
	
	
	use admin
	db.createUser( {
		user: "chh_user",
		pwd: "chh123456",
		roles: [ 
			{ role: "readWrite", db: "yldb" },
			{ role: "readWrite", db: "niuniuh5_modb" }
		]
	} )

	repl_set:PRIMARY> show users;
	{
		"_id" : "admin.admin",
		"userId" : UUID("14e331b5-883f-46e5-9e3d-159eb6bb9461"),
		"user" : "admin",
		"db" : "admin",
		"roles" : [
			{
				"role" : "root",
				"db" : "admin"
			}
		],
		"mechanisms" : [
			"SCRAM-SHA-1",
			"SCRAM-SHA-256"
		]
	}
	{
		"_id" : "admin.chh_user",
		"userId" : UUID("c2456e74-db79-4ae8-a420-124bd349c65e"),
		"user" : "chh_user",
		"db" : "admin",
		"roles" : [
			{
				"role" : "readWrite",
				"db" : "yldb"
			},
			{
				"role" : "readWrite",
				"db" : "niuniuh5_modb"
			}
		],
		"mechanisms" : [
			"SCRAM-SHA-1",
			"SCRAM-SHA-256"
		]
	}
	{
		"_id" : "admin.clusteradmin",
		"userId" : UUID("cc2db5ee-2b84-409a-a9e5-1deb9f1f101e"),
		"user" : "clusteradmin",
		"db" : "admin",
		"roles" : [
			{
				"role" : "clusterAdmin",
				"db" : "admin"
			},
			{
				"role" : "clusterManager",
				"db" : "admin"
			},
			{
				"role" : "clusterMonitor",
				"db" : "admin"
			}
		],
		"mechanisms" : [
			"SCRAM-SHA-1",
			"SCRAM-SHA-256"
		]
	}
	{
		"_id" : "admin.dpc_user",
		"userId" : UUID("234e2763-8307-4df5-9047-97f41245ab5c"),
		"user" : "dpc_user",
		"db" : "admin",
		"roles" : [
			{
				"role" : "readWrite",
				"db" : "niuniuh5_modb"
			}
		],
		"mechanisms" : [
			"SCRAM-SHA-1",
			"SCRAM-SHA-256"
		]
	}
	{
		"_id" : "admin.ldg_user",
		"userId" : UUID("0add0f91-cad6-4cda-8e98-d5095bf9c512"),
		"user" : "ldg_user",
		"db" : "admin",
		"roles" : [
			{
				"role" : "readWrite",
				"db" : "niuniuh5_modb"
			},
			{
				"role" : "readWrite",
				"db" : "yldb"
			}
		],
		"mechanisms" : [
			"SCRAM-SHA-1",
			"SCRAM-SHA-256"
		]
	}
	{
		"_id" : "admin.lxb_user",
		"userId" : UUID("101f90eb-d9a1-48d6-a53e-6f00af21cb1c"),
		"user" : "lxb_user",
		"db" : "admin",
		"roles" : [
			{
				"role" : "read",
				"db" : "niuniuh5_modb"
			},
			{
				"role" : "read",
				"db" : "yldb"
			}
		],
		"mechanisms" : [
			"SCRAM-SHA-1",
			"SCRAM-SHA-256"
		]
	}
	repl_set:PRIMARY> 



	
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