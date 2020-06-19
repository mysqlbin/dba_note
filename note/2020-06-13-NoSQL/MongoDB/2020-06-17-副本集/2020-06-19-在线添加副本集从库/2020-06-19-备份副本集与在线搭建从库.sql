
http://blog.itpub.net/15498/viewspace-2656983/  mongodb副本集用一致性快照方法添加从节点步骤



压缩备份
mongodump  --host "repl_set/192.168.0.252:27017"  -u "admin" -p "admin" --authenticationDatabase "admin"  --oplog --gzip  --out /root/mongodb_backup/`date +%Y%m%d` 
2020-06-19T15:43:15.903+0800	WARNING: ignoring unsupported URI parameter 'replicaset'
2020-06-19T15:43:16.015+0800	writing admin.system.users to 
2020-06-19T15:43:16.027+0800	done dumping admin.system.users (5 documents)
2020-06-19T15:43:16.028+0800	writing admin.system.version to 
2020-06-19T15:43:16.030+0800	done dumping admin.system.version (2 documents)
2020-06-19T15:43:16.044+0800	writing test_db.table_clubgamescorerobotdetail to 
2020-06-19T15:43:16.089+0800	writing test02_db.table_clubgamescorerobotdetail to 
2020-06-19T15:43:16.106+0800	writing yldb.table_clubgamescorerobotdetail to 
2020-06-19T15:43:16.107+0800	writing yldb.table_clubgamelog to 
2020-06-19T15:43:16.119+0800	done dumping test_db.table_clubgamescorerobotdetail (984 documents)
2020-06-19T15:43:16.134+0800	writing test02_db.table_clubgamelog to 
2020-06-19T15:43:16.365+0800	done dumping yldb.table_clubgamelog (766 documents)
2020-06-19T15:43:16.369+0800	writing test_db.table_clubgamelog to 
2020-06-19T15:43:16.416+0800	done dumping test02_db.table_clubgamescorerobotdetail (1640 documents)
2020-06-19T15:43:16.420+0800	writing yldb.abc to 
2020-06-19T15:43:16.428+0800	done dumping yldb.abc (3 documents)
2020-06-19T15:43:16.432+0800	writing test02_db.abc to 
2020-06-19T15:43:16.434+0800	done dumping test02_db.table_clubgamelog (595 documents)
2020-06-19T15:43:16.438+0800	writing test_db.abc to 
2020-06-19T15:43:16.440+0800	done dumping test02_db.abc (3 documents)
2020-06-19T15:43:16.444+0800	writing admin.yldb to 
2020-06-19T15:43:16.446+0800	done dumping test_db.abc (3 documents)
2020-06-19T15:43:16.450+0800	writing test.test to 
2020-06-19T15:43:16.452+0800	done dumping admin.yldb (2 documents)
2020-06-19T15:43:16.454+0800	writing niuniuh5_modb.abc to 
2020-06-19T15:43:16.454+0800	done dumping test.test (1 document)
2020-06-19T15:43:16.457+0800	writing abc_db.foo to 
2020-06-19T15:43:16.459+0800	done dumping niuniuh5_modb.abc (1 document)
2020-06-19T15:43:16.463+0800	done dumping test_db.table_clubgamelog (327 documents)
2020-06-19T15:43:16.463+0800	done dumping abc_db.foo (1 document)
2020-06-19T15:43:16.497+0800	done dumping yldb.table_clubgamescorerobotdetail (2060 documents)
2020-06-19T15:43:16.498+0800	writing captured oplog to 
2020-06-19T15:43:16.499+0800		dumped 1 oplog entry


scp -r /root/mongodb_backup/20200619 root@192.168.251:/root/mongodb_backup 

在251恢复

	mongorestore --oplogReplay --dir="/root/mongodb_backup/20200619" 
		2020-06-19T17:30:59.293+0800	preparing collections to restore from
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/abc_db/foo.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/abc_db/foo.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/admin/system.users.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/admin/system.users.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/admin/system.version.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/admin/system.version.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/admin/yldb.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/admin/yldb.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/niuniuh5_modb/abc.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/niuniuh5_modb/abc.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test/test.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test/test.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test02_db/abc.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test02_db/abc.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test02_db/table_clubgamelog.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test02_db/table_clubgamelog.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test02_db/table_clubgamescorerobotdetail.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test02_db/table_clubgamescorerobotdetail.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test_db/abc.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test_db/abc.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test_db/table_clubgamelog.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test_db/table_clubgamelog.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test_db/table_clubgamescorerobotdetail.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/test_db/table_clubgamescorerobotdetail.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/yldb/abc.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/yldb/abc.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/yldb/table_clubgamelog.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/yldb/table_clubgamelog.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/yldb/table_clubgamescorerobotdetail.bson.gz", skipping...
		2020-06-19T17:30:59.293+0800	don't know what to do with file "/root/mongodb_backup/20200619/yldb/table_clubgamescorerobotdetail.metadata.json.gz", skipping...
		2020-06-19T17:30:59.293+0800	replaying oplog
		2020-06-19T17:30:59.293+0800	applied 0 oplog entries
		2020-06-19T17:30:59.293+0800	Failed: restore error: error reading oplog bson input: unexpected EOF
		2020-06-19T17:30:59.293+0800	0 document(s) restored successfully. 0 document(s) failed to restore.


	mongorestore  -d abc_db --gzip --dir="/root/mongodb_backup/20200619/abc_db" 
	mongorestore  -d admin --gzip --dir="/root/mongodb_backup/20200619/admin" 
	mongorestore  -d niuniuh5_modb --gzip --dir="/root/mongodb_backup/20200619/niuniuh5_modb" 
	mongorestore  -d test --gzip --dir="/root/mongodb_backup/20200619/test" 
	mongorestore  -d test02_db --gzip --dir="/root/mongodb_backup/20200619/test02_db" 
	mongorestore  -d test_db --gzip --dir="/root/mongodb_backup/20200619/test_db" 
	mongorestore  -d yldb --gzip --dir="/root/mongodb_backup/20200619/yldb" 


	use abc_db
	db.dropDatabase()

	use niuniuh5_modb
	db.dropDatabase()

	use test02_db
	db.dropDatabase()

	use test_db
	db.dropDatabase()

	use yldb
	db.dropDatabase()


	创建oplog.rs集合并初始化大小:

	use local
	db.createCollection("oplog.rs",{"capped":true,"size":1073741824})


	mongorestore -d local -c oplog.rs  /root/mongodb_backup/20200619/oplog.bson
		Failed: local.oplog.rs: error restoring from /root/mongodb_backup/20200619/oplog.bson: reading bson input: unexpected EOF



	mongoimport -d local -c oplog.rs --type json --file oplog.bson


		2020-06-19T17:56:32.239+0800	connected to: mongodb://localhost/
		2020-06-19T17:56:32.239+0800	Failed: error processing document #1: invalid character '\x1f' looking for beginning of value
		2020-06-19T17:56:32.239+0800	0 document(s) imported successfully. 0 document(s) failed to import.




在主库备份
	mongodump  --host "192.168.0.242:27017"  -u "admin" -p "admin" --authenticationDatabase "admin"  --oplog --gzip  --out /root/mongodb_backup/`date +%Y%m%d` 

	scp -r /root/mongodb_backup/20200619 root@192.168.251:/root/mongodb_backup 



	mongorestore  -d abc_db --gzip --dir="/root/mongodb_backup/20200619/abc_db" 
	mongorestore  -d admin --gzip --dir="/root/mongodb_backup/20200619/admin" 
	mongorestore  -d niuniuh5_modb --gzip --dir="/root/mongodb_backup/20200619/niuniuh5_modb" 
	mongorestore  -d test --gzip --dir="/root/mongodb_backup/20200619/test" 
	mongorestore  -d test02_db --gzip --dir="/root/mongodb_backup/20200619/test02_db" 
	mongorestore  -d test_db --gzip --dir="/root/mongodb_backup/20200619/test_db" 
	mongorestore  -d yldb --gzip --dir="/root/mongodb_backup/20200619/yldb" 

	mongorestore -d local -c oplog.rs  /root/mongodb_backup/20200619/oplog.bson
		Failed: local.oplog.rs: error restoring from /root/mongodb_backup/20200619/oplog.bson: reading bson input: unexpected EOF



	mongoimport -d local -c oplog.rs --type json --file oplog.bson


		2020-06-19T17:56:32.239+0800	connected to: mongodb://localhost/
		2020-06-19T17:56:32.239+0800	Failed: error processing document #1: invalid character '\x1f' looking for beginning of value
		2020-06-19T17:56:32.239+0800	0 document(s) imported successfully. 0 document(s) failed to import.




在从库不压缩备份


	mongodump  --host "192.168.0.252:27017"  -u "admin" -p "admin" --authenticationDatabase "admin"  --oplog  --out /root/mongodb_backup/`date +%Y%m%d` 

	scp -r /root/mongodb_backup/20200619 root@192.168.251:/root/mongodb_backup 


恢复
mongorestore --oplogReplay --dir="/root/mongodb_backup/20200619" 

	[root@test mongodb_backup]# mongorestore --oplogReplay --dir="/root/mongodb_backup/20200619" 
	2020-06-19T18:11:05.834+0800	preparing collections to restore from
	2020-06-19T18:11:05.836+0800	reading metadata for yldb.table_clubgamescorerobotdetail from /root/mongodb_backup/20200619/yldb/table_clubgamescorerobotdetail.metadata.json
	2020-06-19T18:11:05.836+0800	reading metadata for test02_db.table_clubgamescorerobotdetail from /root/mongodb_backup/20200619/test02_db/table_clubgamescorerobotdetail.metadata.json
	2020-06-19T18:11:05.836+0800	reading metadata for test_db.table_clubgamescorerobotdetail from /root/mongodb_backup/20200619/test_db/table_clubgamescorerobotdetail.metadata.json
	2020-06-19T18:11:05.837+0800	restoring to existing collection test.test without dropping
	2020-06-19T18:11:05.837+0800	reading metadata for test.test from /root/mongodb_backup/20200619/test/test.metadata.json
	2020-06-19T18:11:05.837+0800	restoring test.test from /root/mongodb_backup/20200619/test/test.bson
	2020-06-19T18:11:05.838+0800	continuing through error: E11000 duplicate key error collection: test.test index: _id_ dup key: { _id: ObjectId('5eeb4140076369dfbc9b620e') }
	2020-06-19T18:11:05.838+0800	continuing through error: E11000 duplicate key error collection: test.test index: _id_ dup key: { _id: ObjectId('5eec6d978eff4eaec78c74d3') }
	2020-06-19T18:11:05.838+0800	no indexes to restore
	2020-06-19T18:11:05.838+0800	finished restoring test.test (0 documents, 2 failures)
	2020-06-19T18:11:05.838+0800	restoring to existing collection admin.yldb without dropping
	2020-06-19T18:11:05.838+0800	reading metadata for admin.yldb from /root/mongodb_backup/20200619/admin/yldb.metadata.json
	2020-06-19T18:11:05.838+0800	restoring admin.yldb from /root/mongodb_backup/20200619/admin/yldb.bson
	2020-06-19T18:11:05.844+0800	continuing through error: E11000 duplicate key error collection: admin.yldb index: _id_ dup key: { _id: ObjectId('5ee36a808ec3611fc02989a6') }
	2020-06-19T18:11:05.844+0800	continuing through error: E11000 duplicate key error collection: admin.yldb index: _id_ dup key: { _id: ObjectId('5ee36a868ec3611fc02989a7') }
	2020-06-19T18:11:05.844+0800	no indexes to restore
	2020-06-19T18:11:05.844+0800	finished restoring admin.yldb (0 documents, 2 failures)
	2020-06-19T18:11:05.844+0800	reading metadata for abc_db.foo from /root/mongodb_backup/20200619/abc_db/foo.metadata.json
	2020-06-19T18:11:06.239+0800	restoring yldb.table_clubgamescorerobotdetail from /root/mongodb_backup/20200619/yldb/table_clubgamescorerobotdetail.bson
	2020-06-19T18:11:06.270+0800	no indexes to restore
	2020-06-19T18:11:06.270+0800	finished restoring yldb.table_clubgamescorerobotdetail (2060 documents, 0 failures)
	2020-06-19T18:11:06.270+0800	reading metadata for yldb.table_clubgamelog from /root/mongodb_backup/20200619/yldb/table_clubgamelog.metadata.json
	2020-06-19T18:11:06.322+0800	restoring test02_db.table_clubgamescorerobotdetail from /root/mongodb_backup/20200619/test02_db/table_clubgamescorerobotdetail.bson
	2020-06-19T18:11:06.347+0800	no indexes to restore
	2020-06-19T18:11:06.347+0800	finished restoring test02_db.table_clubgamescorerobotdetail (1640 documents, 0 failures)
	2020-06-19T18:11:06.347+0800	reading metadata for test02_db.table_clubgamelog from /root/mongodb_backup/20200619/test02_db/table_clubgamelog.metadata.json
	2020-06-19T18:11:06.397+0800	restoring test_db.table_clubgamescorerobotdetail from /root/mongodb_backup/20200619/test_db/table_clubgamescorerobotdetail.bson
	2020-06-19T18:11:06.411+0800	no indexes to restore
	2020-06-19T18:11:06.411+0800	finished restoring test_db.table_clubgamescorerobotdetail (984 documents, 0 failures)
	2020-06-19T18:11:06.411+0800	reading metadata for test_db.table_clubgamelog from /root/mongodb_backup/20200619/test_db/table_clubgamelog.metadata.json
	2020-06-19T18:11:06.476+0800	restoring abc_db.foo from /root/mongodb_backup/20200619/abc_db/foo.bson
	2020-06-19T18:11:06.478+0800	no indexes to restore
	2020-06-19T18:11:06.478+0800	finished restoring abc_db.foo (1 document, 0 failures)
	2020-06-19T18:11:06.479+0800	reading metadata for niuniuh5_modb.abc from /root/mongodb_backup/20200619/niuniuh5_modb/abc.metadata.json
	2020-06-19T18:11:06.848+0800	restoring yldb.table_clubgamelog from /root/mongodb_backup/20200619/yldb/table_clubgamelog.bson
	2020-06-19T18:11:06.861+0800	no indexes to restore
	2020-06-19T18:11:06.861+0800	finished restoring yldb.table_clubgamelog (766 documents, 0 failures)
	2020-06-19T18:11:06.861+0800	reading metadata for yldb.abc from /root/mongodb_backup/20200619/yldb/abc.metadata.json
	2020-06-19T18:11:06.923+0800	restoring test02_db.table_clubgamelog from /root/mongodb_backup/20200619/test02_db/table_clubgamelog.bson
	2020-06-19T18:11:06.933+0800	no indexes to restore
	2020-06-19T18:11:06.934+0800	finished restoring test02_db.table_clubgamelog (595 documents, 0 failures)
	2020-06-19T18:11:06.934+0800	reading metadata for test02_db.abc from /root/mongodb_backup/20200619/test02_db/abc.metadata.json
	2020-06-19T18:11:07.015+0800	restoring test_db.table_clubgamelog from /root/mongodb_backup/20200619/test_db/table_clubgamelog.bson
	2020-06-19T18:11:07.022+0800	no indexes to restore
	2020-06-19T18:11:07.022+0800	finished restoring test_db.table_clubgamelog (327 documents, 0 failures)
	2020-06-19T18:11:07.022+0800	reading metadata for test_db.abc from /root/mongodb_backup/20200619/test_db/abc.metadata.json
	2020-06-19T18:11:07.090+0800	restoring niuniuh5_modb.abc from /root/mongodb_backup/20200619/niuniuh5_modb/abc.bson
	2020-06-19T18:11:07.093+0800	no indexes to restore
	2020-06-19T18:11:07.093+0800	finished restoring niuniuh5_modb.abc (1 document, 0 failures)
	2020-06-19T18:11:07.380+0800	restoring yldb.abc from /root/mongodb_backup/20200619/yldb/abc.bson
	2020-06-19T18:11:07.383+0800	no indexes to restore
	2020-06-19T18:11:07.383+0800	finished restoring yldb.abc (3 documents, 0 failures)
	2020-06-19T18:11:07.466+0800	restoring test02_db.abc from /root/mongodb_backup/20200619/test02_db/abc.bson
	2020-06-19T18:11:07.468+0800	no indexes to restore
	2020-06-19T18:11:07.468+0800	finished restoring test02_db.abc (3 documents, 0 failures)
	2020-06-19T18:11:07.522+0800	restoring test_db.abc from /root/mongodb_backup/20200619/test_db/abc.bson
	2020-06-19T18:11:07.525+0800	no indexes to restore
	2020-06-19T18:11:07.525+0800	finished restoring test_db.abc (3 documents, 0 failures)
	2020-06-19T18:11:07.525+0800	restoring users from /root/mongodb_backup/20200619/admin/system.users.bson
	2020-06-19T18:11:07.738+0800	replaying oplog
	2020-06-19T18:11:07.739+0800	applied 0 oplog entries
	2020-06-19T18:11:07.739+0800	6383 document(s) restored successfully. 4 document(s) failed to restore.

[root@test mongodb_backup]# mongorestore -d local -c oplog.rs  /root/mongodb_backup/20200619/oplog.bson
2020-06-19T18:14:54.680+0800	checking for collection data in /root/mongodb_backup/20200619/oplog.bson
2020-06-19T18:14:54.680+0800	restoring to existing collection local.oplog.rs without dropping
2020-06-19T18:14:54.680+0800	restoring local.oplog.rs from /root/mongodb_backup/20200619/oplog.bson
2020-06-19T18:14:54.741+0800	no indexes to restore
2020-06-19T18:14:54.741+0800	finished restoring local.oplog.rs (1 document, 0 failures)
2020-06-19T18:14:54.741+0800	1 document(s) restored successfully. 0 document(s) failed to restore.



use test
db.test.insert({"wang5" : "wang5"})
db.test.find()
	repl_set:PRIMARY> use test
	switched to db test
	repl_set:PRIMARY> db.test.insert({"wang5" : "wang5"})
	WriteResult({ "nInserted" : 1 })
	repl_set:PRIMARY> db.test.find()
	{ "_id" : ObjectId("5eeb4140076369dfbc9b620e"), "zhang3" : "zhang3" }
	{ "_id" : ObjectId("5eec6d978eff4eaec78c74d3"), "ljb" : "ljb" }
	{ "_id" : ObjectId("5eec906f8eff4eaec78c74d4"), "wang5" : "wang5" }



mkdir /home/mongodb/keyfile/
上传 mongo.key 文件
chown -R mongodb:mongodb  /home/mongodb/keyfile
chmod 755  /home/mongodb/keyfile
chmod 600 /home/mongodb/keyfile/mongo.key



[root@test mongodb_backup]# service mongodb restart
Redirecting to /bin/systemctl restart mongodb.service


主节点执行添加节点操作:

mongo admin -u admin  -p admin


rs.add("192.168.0.251:27017");

	repl_set:PRIMARY> rs.add("192.168.0.251:27017");
	{
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592562006, 1),
			"signature" : {
				"hash" : BinData(0,"sOyI04W0iUXS6f1vBtL6HxE7lMs="),
				"keyId" : NumberLong("6839627628085772291")
			}
		},
		"operationTime" : Timestamp(1592562006, 1)
	}

repl_set:PRIMARY> rs.status()
{
	"set" : "repl_set",
	"date" : ISODate("2020-06-19T10:20:33.789Z"),
	"myState" : 1,
	"term" : NumberLong(23),
	"syncingTo" : "",
	"syncSourceHost" : "",
	"syncSourceId" : -1,
	"heartbeatIntervalMillis" : NumberLong(2000),
	"majorityVoteCount" : 3,
	"writeMajorityCount" : 3,
	"optimes" : {
		"lastCommittedOpTime" : {
			"ts" : Timestamp(1592562024, 1),
			"t" : NumberLong(23)
		},
		"lastCommittedWallTime" : ISODate("2020-06-19T10:20:24.685Z"),
		"readConcernMajorityOpTime" : {
			"ts" : Timestamp(1592562024, 1),
			"t" : NumberLong(23)
		},
		"readConcernMajorityWallTime" : ISODate("2020-06-19T10:20:24.685Z"),
		"appliedOpTime" : {
			"ts" : Timestamp(1592562024, 1),
			"t" : NumberLong(23)
		},
		"durableOpTime" : {
			"ts" : Timestamp(1592562024, 1),
			"t" : NumberLong(23)
		},
		"lastAppliedWallTime" : ISODate("2020-06-19T10:20:24.685Z"),
		"lastDurableWallTime" : ISODate("2020-06-19T10:20:24.685Z")
	},
	"lastStableRecoveryTimestamp" : Timestamp(1592562024, 1),
	"lastStableCheckpointTimestamp" : Timestamp(1592562024, 1),
	"electionCandidateMetrics" : {
		"lastElectionReason" : "electionTimeout",
		"lastElectionDate" : ISODate("2020-06-19T04:16:23.839Z"),
		"electionTerm" : NumberLong(23),
		"lastCommittedOpTimeAtElection" : {
			"ts" : Timestamp(1592539341, 1),
			"t" : NumberLong(20)
		},
		"lastSeenOpTimeAtElection" : {
			"ts" : Timestamp(1592540151, 1),
			"t" : NumberLong(22)
		},
		"numVotesNeeded" : 2,
		"priorityAtElection" : 90,
		"electionTimeoutMillis" : NumberLong(10000),
		"numCatchUpOps" : NumberLong(0),
		"newTermStartDate" : ISODate("2020-06-19T04:16:23.918Z"),
		"wMajorityWriteAvailabilityDate" : ISODate("2020-06-19T04:16:25.213Z")
	},
	"members" : [
		{
			"_id" : 0,
			"name" : "192.168.0.242:27017",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 21862,
			"optime" : {
				"ts" : Timestamp(1592562024, 1),
				"t" : NumberLong(23)
			},
			"optimeDate" : ISODate("2020-06-19T10:20:24Z"),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "",
			"electionTime" : Timestamp(1592540183, 1),
			"electionDate" : ISODate("2020-06-19T04:16:23Z"),
			"configVersion" : 2,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 1,
			"name" : "192.168.0.252:27017",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 21855,
			"optime" : {
				"ts" : Timestamp(1592562024, 1),
				"t" : NumberLong(23)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1592562024, 1),
				"t" : NumberLong(23)
			},
			"optimeDate" : ISODate("2020-06-19T10:20:24Z"),
			"optimeDurableDate" : ISODate("2020-06-19T10:20:24Z"),
			"lastHeartbeat" : ISODate("2020-06-19T10:20:32.901Z"),
			"lastHeartbeatRecv" : ISODate("2020-06-19T10:20:32.027Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.251:27017",
			"syncSourceHost" : "192.168.0.251:27017",
			"syncSourceId" : 3,
			"infoMessage" : "",
			"configVersion" : 2
		},
		{
			"_id" : 2,
			"name" : "192.168.0.241:27017",
			"health" : 1,
			"state" : 7,
			"stateStr" : "ARBITER",
			"uptime" : 21860,
			"lastHeartbeat" : ISODate("2020-06-19T10:20:32.903Z"),
			"lastHeartbeatRecv" : ISODate("2020-06-19T10:20:32.990Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "",
			"configVersion" : 2
		},
		{
			"_id" : 3,
			"name" : "192.168.0.251:27017",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 26,
			"optime" : {
				"ts" : Timestamp(1592562024, 1),
				"t" : NumberLong(23)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1592562024, 1),
				"t" : NumberLong(23)
			},
			"optimeDate" : ISODate("2020-06-19T10:20:24Z"),
			"optimeDurableDate" : ISODate("2020-06-19T10:20:24Z"),
			"lastHeartbeat" : ISODate("2020-06-19T10:20:32.922Z"),
			"lastHeartbeatRecv" : ISODate("2020-06-19T10:20:33.471Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.242:27017",
			"syncSourceHost" : "192.168.0.242:27017",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 2
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1592562024, 1),
		"signature" : {
			"hash" : BinData(0,"eg99zsPhgwRxNYiptvlJYq+gAto="),
			"keyId" : NumberLong("6839627628085772291")
		}
	},
	"operationTime" : Timestamp(1592562024, 1)
}
repl_set:PRIMARY


251

[root@test mongodb_backup]# mongo -uadmin -padmin


rs.slaveOk()
use test
db.test.find()

repl_set:SECONDARY> rs.slaveOk()
repl_set:SECONDARY> use test
switched to db test
repl_set:SECONDARY> db.test.find()
{ "_id" : ObjectId("5eeb4140076369dfbc9b620e"), "zhang3" : "zhang3" }
{ "_id" : ObjectId("5eec6d978eff4eaec78c74d3"), "ljb" : "ljb" }
{ "_id" : ObjectId("5eec906f8eff4eaec78c74d4"), "wang5" : "wang5" }



primary

use test
db.test.insert({"yi9" : "yi9"})
db.test.find()
	repl_set:PRIMARY> use test
	switched to db test
	repl_set:PRIMARY> db.test.insert({"yi9" : "yi9"})
	WriteResult({ "nInserted" : 1 })
	repl_set:PRIMARY> db.test.find()
	{ "_id" : ObjectId("5eeb4140076369dfbc9b620e"), "zhang3" : "zhang3" }
	{ "_id" : ObjectId("5eec6d978eff4eaec78c74d3"), "ljb" : "ljb" }
	{ "_id" : ObjectId("5eec906f8eff4eaec78c74d4"), "wang5" : "wang5" }
	{ "_id" : ObjectId("5eec91f08eff4eaec78c74d5"), "yi9" : "yi9" }

251

use test
db.test.find()

repl_set:SECONDARY> use test
switched to db test
repl_set:SECONDARY> db.test.find()
{ "_id" : ObjectId("5eeb4140076369dfbc9b620e"), "zhang3" : "zhang3" }
{ "_id" : ObjectId("5eec6d978eff4eaec78c74d3"), "ljb" : "ljb" }
{ "_id" : ObjectId("5eec906f8eff4eaec78c74d4"), "wang5" : "wang5" }
{ "_id" : ObjectId("5eec91f08eff4eaec78c74d5"), "yi9" : "yi9" }


252
repl_set:SECONDARY> use test
switched to db test
repl_set:SECONDARY> db.test.find()
{ "_id" : ObjectId("5eeb4140076369dfbc9b620e"), "zhang3" : "zhang3" }
{ "_id" : ObjectId("5eec6d978eff4eaec78c74d3"), "ljb" : "ljb" }
{ "_id" : ObjectId("5eec906f8eff4eaec78c74d4"), "wang5" : "wang5" }
{ "_id" : ObjectId("5eec91f08eff4eaec78c74d5"), "yi9" : "yi9" }



rs.remove("192.168.0.251:27017");
	repl_set:PRIMARY> rs.remove("192.168.0.251:27017");
	{
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592562523, 1),
			"signature" : {
				"hash" : BinData(0,"7KR39oFLZbvYIb9VnBlus+fhMog="),
				"keyId" : NumberLong("6839627628085772291")
			}
		},
		"operationTime" : Timestamp(1592562523, 1)
	}

repl_set:PRIMARY> rs.status()
{
	"set" : "repl_set",
	"date" : ISODate("2020-06-19T10:29:06.491Z"),
	"myState" : 1,
	"term" : NumberLong(23),
	"syncingTo" : "",
	"syncSourceHost" : "",
	"syncSourceId" : -1,
	"heartbeatIntervalMillis" : NumberLong(2000),
	"majorityVoteCount" : 2,
	"writeMajorityCount" : 2,
	"optimes" : {
		"lastCommittedOpTime" : {
			"ts" : Timestamp(1592562544, 1),
			"t" : NumberLong(23)
		},
		"lastCommittedWallTime" : ISODate("2020-06-19T10:29:04.702Z"),
		"readConcernMajorityOpTime" : {
			"ts" : Timestamp(1592562544, 1),
			"t" : NumberLong(23)
		},
		"readConcernMajorityWallTime" : ISODate("2020-06-19T10:29:04.702Z"),
		"appliedOpTime" : {
			"ts" : Timestamp(1592562544, 1),
			"t" : NumberLong(23)
		},
		"durableOpTime" : {
			"ts" : Timestamp(1592562544, 1),
			"t" : NumberLong(23)
		},
		"lastAppliedWallTime" : ISODate("2020-06-19T10:29:04.702Z"),
		"lastDurableWallTime" : ISODate("2020-06-19T10:29:04.702Z")
	},
	"lastStableRecoveryTimestamp" : Timestamp(1592562504, 1),
	"lastStableCheckpointTimestamp" : Timestamp(1592562504, 1),
	"electionCandidateMetrics" : {
		"lastElectionReason" : "electionTimeout",
		"lastElectionDate" : ISODate("2020-06-19T04:16:23.839Z"),
		"electionTerm" : NumberLong(23),
		"lastCommittedOpTimeAtElection" : {
			"ts" : Timestamp(1592539341, 1),
			"t" : NumberLong(20)
		},
		"lastSeenOpTimeAtElection" : {
			"ts" : Timestamp(1592540151, 1),
			"t" : NumberLong(22)
		},
		"numVotesNeeded" : 2,
		"priorityAtElection" : 90,
		"electionTimeoutMillis" : NumberLong(10000),
		"numCatchUpOps" : NumberLong(0),
		"newTermStartDate" : ISODate("2020-06-19T04:16:23.918Z"),
		"wMajorityWriteAvailabilityDate" : ISODate("2020-06-19T04:16:25.213Z")
	},
	"members" : [
		{
			"_id" : 0,
			"name" : "192.168.0.242:27017",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 22375,
			"optime" : {
				"ts" : Timestamp(1592562544, 1),
				"t" : NumberLong(23)
			},
			"optimeDate" : ISODate("2020-06-19T10:29:04Z"),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "",
			"electionTime" : Timestamp(1592540183, 1),
			"electionDate" : ISODate("2020-06-19T04:16:23Z"),
			"configVersion" : 3,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 1,
			"name" : "192.168.0.252:27017",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 22368,
			"optime" : {
				"ts" : Timestamp(1592562544, 1),
				"t" : NumberLong(23)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1592562544, 1),
				"t" : NumberLong(23)
			},
			"optimeDate" : ISODate("2020-06-19T10:29:04Z"),
			"optimeDurableDate" : ISODate("2020-06-19T10:29:04Z"),
			"lastHeartbeat" : ISODate("2020-06-19T10:29:05.796Z"),
			"lastHeartbeatRecv" : ISODate("2020-06-19T10:29:05.820Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "192.168.0.242:27017",
			"syncSourceHost" : "192.168.0.242:27017",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 3
		},
		{
			"_id" : 2,
			"name" : "192.168.0.241:27017",
			"health" : 1,
			"state" : 7,
			"stateStr" : "ARBITER",
			"uptime" : 22373,
			"lastHeartbeat" : ISODate("2020-06-19T10:29:05.797Z"),
			"lastHeartbeatRecv" : ISODate("2020-06-19T10:29:05.875Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "",
			"configVersion" : 3
		}
	],
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1592562544, 1),
		"signature" : {
			"hash" : BinData(0,"82ZNZzPqpIGsf6y/qyEQ2FgXnm0="),
			"keyId" : NumberLong("6839627628085772291")
		}
	},
	"operationTime" : Timestamp(1592562544, 1)
}
repl_set:PRIMARY> db.isMaster()
{
	"hosts" : [
		"192.168.0.242:27017",
		"192.168.0.252:27017"
	],
	"arbiters" : [
		"192.168.0.241:27017"
	],
	"setName" : "repl_set",
	"setVersion" : 3,
	"ismaster" : true,
	"secondary" : false,
	"primary" : "192.168.0.242:27017",
	"me" : "192.168.0.242:27017",
	"electionId" : ObjectId("7fffffff0000000000000017"),
	"lastWrite" : {
		"opTime" : {
			"ts" : Timestamp(1592562544, 1),
			"t" : NumberLong(23)
		},
		"lastWriteDate" : ISODate("2020-06-19T10:29:04Z"),
		"majorityOpTime" : {
			"ts" : Timestamp(1592562544, 1),
			"t" : NumberLong(23)
		},
		"majorityWriteDate" : ISODate("2020-06-19T10:29:04Z")
	},
	"maxBsonObjectSize" : 16777216,
	"maxMessageSizeBytes" : 48000000,
	"maxWriteBatchSize" : 100000,
	"localTime" : ISODate("2020-06-19T10:29:13.708Z"),
	"logicalSessionTimeoutMinutes" : 30,
	"connectionId" : 404,
	"minWireVersion" : 0,
	"maxWireVersion" : 8,
	"readOnly" : false,
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1592562544, 1),
		"signature" : {
			"hash" : BinData(0,"82ZNZzPqpIGsf6y/qyEQ2FgXnm0="),
			"keyId" : NumberLong("6839627628085772291")
		}
	},
	"operationTime" : Timestamp(1592562544, 1)
}
repl_set:PRIMARY> 
