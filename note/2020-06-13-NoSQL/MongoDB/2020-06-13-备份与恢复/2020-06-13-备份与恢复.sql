





目前官方MongoDB社区版是不支持Hot Backup热备份的，我们只能通过mongodump等逻辑备份工具导出bson文件，再mongorestore导入，类似MySQL的mysqldump工具。

在备份副本集时，我们需指定--oplog选项记录备份间产生的增量数据，类似mysqldump --single-transaction --master-data=2（做一致性快照并记录当前的binlog点）。

对副本集的成员恢复，需先切成单机版，mongorestore必须指定--oplogReplay选项，以恢复到某一时刻的快照，最后还需填充oplog（增量数据以哪个位置点开始断点续传），mongorestore -d local -c oplog.rs dump/oplog.bson，最后一步再切为副本集成员重新启动。

中小型数据库备份起来简单快捷，如果过TB级的数据量，那将是痛苦的。



如果你的oplog设置过小，很有可能在备份恢复这段时间，oplog被覆盖重写，那么你将永远无法加入副本集集群里。


压缩备份与恢复：

	备份单机的指定数据库数据
		mongodump  --host "192.168.1.31:27017"  -u "admin" -p "admin" --authenticationDatabase "admin"  -d sbtest_db   -o /data/`date +%Y%m%d` 
		
		mongodump  --host "192.168.1.31:27017"  -u "admin" -p "admin" --authenticationDatabase "admin"  -d sbtest_db --gzip  --out /data/`date +%Y%m%d` 

		
	恢复数据
		
		mongorestore --host "192.168.1.31:27017"  -u "admin" -p "admin" --authenticationDatabase "admin" -d sbtest_db_recovery --dir='/data/20200613/sbtest_db'  
			[root@env30 data]# mongorestore --host "192.168.1.31:27017"  -u "admin" -p "admin" --authenticationDatabase "admin" -d sbtest_db_recovery --dir='/data/20200613/sbtest_db'  
			2020-06-13T13:44:12.657+0800	the --db and --collection args should only be used when restoring from a BSON file. Other uses are deprecated and will not exist in the future; use --nsInclude instead
			2020-06-13T13:44:12.657+0800	building a list of collections to restore from /data/20200613/sbtest_db dir
			2020-06-13T13:44:12.658+0800	reading metadata for sbtest_db_recovery.t1 from /data/20200613/sbtest_db/t1.metadata.json
			2020-06-13T13:44:12.963+0800	restoring sbtest_db_recovery.t1 from /data/20200613/sbtest_db/t1.bson
			2020-06-13T13:44:12.967+0800	no indexes to restore
			2020-06-13T13:44:12.967+0800	finished restoring sbtest_db_recovery.t1 (5 documents, 0 failures)
			2020-06-13T13:44:12.967+0800	5 document(s) restored successfully. 0 document(s) failed to restore.
				
		
		mongorestore --host "192.168.1.31:27017"  -u "admin" -p "admin" --authenticationDatabase "admin" -d sbtest_db_02 --gzip --dir='/data/20200613/sbtest_db'  

		mongorestore --host "1"  -u "admin" -p "admin123456" --authenticationDatabase "admin" -d niuniuh5_modb --gzip --dir='/home/dba2/20200615/niuniuh5_modb' 	
		

生产实践		
	> show dbs
	admin          0.000GB
	benet          0.000GB
	config         0.000GB
	local          0.000GB
	niuniuh5_modb  6.726GB
	
	niuniuh5_modb 占用磁盘的空间大小： 11.20GB + 7.61GB
	
	
备份数据	
	time mongodump -d niuniuh5_modb -o /mydata/`date +%Y%m%d` 
	
	2020-06-13T16:39:42.305+0800	[########################]  niuniuh5_modb.table_clubgamelog  5126153/5126153  (100.0%)
	2020-06-13T16:39:42.305+0800	done dumping niuniuh5_modb.table_clubgamelog (5126153 documents)
	2020-06-13T16:39:42.428+0800	[###############.........]  niuniuh5_modb.table_clubgamescorerobotdetail  18217062/27497094  (66.3%)

	....................................................................................................................................
	
	2020-06-13T16:40:21.477+0800	[########################]  niuniuh5_modb.table_clubgamescorerobotdetail  27497094/27497094  (100.0%)
	2020-06-13T16:40:21.477+0800	done dumping niuniuh5_modb.table_clubgamescorerobotdetail (27497094 documents)

	real	2m18.136s
	user	1m2.872s
	sys	1m2.111s
	
	

	另一个实例：
		repl_set:PRIMARY> show dbs
		abc_db     0.000GB
		admin      0.000GB
		config     0.000GB
		local      3.532GB
		doudou_b5  6.938GB

		压缩备份的耗时

			real	11m40.511s
			user	22m15.517s
			sys	2m19.773s
		
		压缩之后的大小：
			[...... doudou_b5]$ ls -lht
			total 3.0G



恢复数据
	time mongorestore  -d niuniuh5_modb_02 --dir='/mydata/20200613/niuniuh5_modb'  

	[root@database-03 mydata]# time mongorestore  -d niuniuh5_modb_02 --dir='/mydata/20200613/niuniuh5_modb' 
		2020-06-13T21:39:15.926+0800	the --db and --collection args should only be used when restoring from a BSON file. Other uses are deprecated and will not exist in the future; use --nsInclude instead
		2020-06-13T21:39:15.926+0800	building a list of collections to restore from /mydata/20200613/niuniuh5_modb dir
		2020-06-13T21:39:15.928+0800	reading metadata for niuniuh5_modb_02.table_clubgamescorerobotdetail from /mydata/20200613/niuniuh5_modb/table_clubgamescorerobotdetail.metadata.json
		2020-06-13T21:39:15.928+0800	reading metadata for niuniuh5_modb_02.table_clubgamelog from /mydata/20200613/niuniuh5_modb/table_clubgamelog.metadata.json
		2020-06-13T21:39:15.945+0800	restoring niuniuh5_modb_02.table_clubgamescorerobotdetail from /mydata/20200613/niuniuh5_modb/table_clubgamescorerobotdetail.bson
		2020-06-13T21:39:15.960+0800	restoring niuniuh5_modb_02.table_clubgamelog from /mydata/20200613/niuniuh5_modb/table_clubgamelog.bson
		2020-06-13T21:39:18.925+0800	[........................]  niuniuh5_modb_02.table_clubgamescorerobotdetail  66.0MB/11.2GB  (0.6%)
		2020-06-13T21:39:18.925+0800	[........................]               niuniuh5_modb_02.table_clubgamelog   180MB/7.61GB  (2.3%)
		2020-06-13T21:39:18.925+08
		2020-06-13T21:39:30.926+0800	
		2020-06-13T21:39:33.927+0800	[........................]  niuniuh5_modb_02.table_clubgamescorerobotdetail   371MB/11.2GB   (3.2%)
		2020-06-13T21:39:33.927+0800	[###.....................]               niuniuh5_modb_02.table_clubgamelog  1012MB/7.61GB  (13.0%)
		2020-06-13T21:39:33.927+0800	
		....................................................................................................................................
		
		2020-06-13T21:41:39.925+0800	[######################..]               niuniuh5_modb_02.table_clubgamelog  7.20GB/7.61GB  (94.7%)
		2020-06-13T21:41:39.925+0800	
		2020-06-13T21:41:42.925+0800	[#####...................]  niuniuh5_modb_02.table_clubgamescorerobotdetail  2.69GB/11.2GB  (24.0%)
		2020-06-13T21:41:42.925+0800	[#######################.]               niuniuh5_modb_02.table_clubgamelog  7.37GB/7.61GB  (96.9%)
		2020-06-13T21:41:42.925+0800	
		2020-06-13T21:41:45.926+0800	[#####...................]  niuniuh5_modb_02.table_clubgamescorerobotdetail  2.74GB/11.2GB  (24.5%)
		2020-06-13T21:41:45.926+0800	[#######################.]               niuniuh5_modb_02.table_clubgamelog  7.50GB/7.61GB  (98.6%)
		2020-06-13T21:41:45.926+0800	
		2020-06-13T21:41:47.981+0800	[########################]  niuniuh5_modb_02.table_clubgamelog  7.61GB/7.61GB  (100.0%)
		数据导入完成之后才建索引
		2020-06-13T21:41:47.981+0800	restoring indexes for collection niuniuh5_modb_02.table_clubgamelog from metadata
		2020-06-13T21:41:48.925+0800	[######..................]  niuniuh5_modb_02.table_clubgamescorerobotdetail  2.81GB/11.2GB  (25.1%)
		2020-06-13T21:41:51.925+0800	[######..................]  niuniuh5_modb_02.table_clubgamescorerobotdetail  2.88GB/11.2GB  (25.7%)
		
		....................................................................................................................................
		
		2020-06-13T21:42:54.925+0800	[#########...............]  niuniuh5_modb_02.table_clubgamescorerobotdetail  4.26GB/11.2GB  (38.1%)
		2020-06-13T21:42:57.925+0800	[#########...............]  niuniuh5_modb_02.table_clubgamescorerobotdetail  4.33GB/11.2GB  (38.7%)
		2020-06-13T21:43:00.000+0800	finished restoring niuniuh5_modb_02.table_clubgamelog (5126153 documents, 0 failures)
		2020-06-13T21:43:00.925+0800	[#########...............]  niuniuh5_modb_02.table_clubgamescorerobotdetail  4.40GB/11.2GB  (39.4%)
		
		....................................................................................................................................
		
		2020-06-13T21:43:12.925+0800	[##########..............]  niuniuh5_modb_02.table_clubgamescorerobotdetail  4.74GB/11.2GB  (42.3%)
		
		....................................................................................................................................
		
		2020-06-13T21:43:30.925+0800	[###########.............]  niuniuh5_modb_02.table_clubgamescorerobotdetail  5.23GB/11.2GB  (46.8%)
		
		....................................................................................................................................

		2020-06-13T21:47:11.839+0800	[########################]  niuniuh5_modb_02.table_clubgamescorerobotdetail  11.2GB/11.2GB  (100.0%)
		2020-06-13T21:47:11.839+0800	restoring indexes for collection niuniuh5_modb_02.table_clubgamescorerobotdetail from metadata
		2020-06-13T21:51:14.255+0800	finished restoring niuniuh5_modb_02.table_clubgamescorerobotdetail (27497094 documents, 0 failures)
		2020-06-13T21:51:14.255+0800	32623247 document(s) restored successfully. 0 document(s) failed to restore.

		real	11m58.623s
		user	5m41.000s
		sys	1m12.946s

数据对比	
	> show dbs
	admin             0.000GB
	benet             0.000GB
	config            0.000GB
	local             0.000GB
	niuniuh5_modb     6.726GB
	niuniuh5_modb_02  6.278GB

	
	use niuniuh5_modb
	db.table_clubgamelog.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
	db.table_clubgamescorerobotdetail.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
	
	detail:

		> use niuniuh5_modb
		switched to db niuniuh5_modb
		> db.table_clubgamelog.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
		{ "_id" : null, "num_tutorial" : 5126153 }
		> db.table_clubgamescorerobotdetail.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
		{ "_id" : null, "num_tutorial" : 27497094 }
	
	....................................................................................................................................
	
	use niuniuh5_modb_02
	db.table_clubgamelog.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
	db.table_clubgamescorerobotdetail.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
	
	
	detail:
		> use niuniuh5_modb_02
		switched to db niuniuh5_modb_02
		> db.table_clubgamelog.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])

		{ "_id" : null, "num_tutorial" : 5126153 }
		> db.table_clubgamescorerobotdetail.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
		{ "_id" : null, "num_tutorial" : 27497094 }


		
备份的影响：备份操作都会增加系统的负担，备份需要将所有数据都读入内存中。
	
思考： 
	1. 备份对应用的影响： IO 等

	2. 是否支持远程备份
	
	3. 备份是否会加锁
		不加锁。
	

备份方式
	文件系统快照
	复制数据文件: 会加锁，直到数据备份完成才解锁。
	mongodump： 
	
	
备份指令
# 指令中加上副本集的名字mongors是为了从主节点进行备份
# 备份的文件夹以日期命名

folder=`date +%Y%m%d`
mongodump -h 'repl_set/192.168.0.121:27017'  --oplog --gzip -o /data/mongodb/dump/`date +%Y%m%d` 



[root@mongodb01 mongodb]# mongodump -h 'repl_set/192.168.0.121:27017'  --oplog --gzip -o /data/mongodb/dump/`date +%Y%m%d` 
2019-11-29T06:52:29.503+0800	writing admin.system.version to 
2019-11-29T06:52:29.505+0800	done dumping admin.system.version (1 document)
2019-11-29T06:52:29.506+0800	writing test_db.test to 
2019-11-29T06:52:29.506+0800	writing test_db.table_index to 
2019-11-29T06:52:29.506+0800	writing test_db.foo to 
2019-11-29T06:52:29.506+0800	writing test_db.tests to 
2019-11-29T06:52:29.523+0800	done dumping test_db.tests (2 documents)
2019-11-29T06:52:29.523+0800	writing test.foo to 
2019-11-29T06:52:29.541+0800	done dumping test_db.foo (3 documents)
2019-11-29T06:52:29.541+0800	writing test_db.table_covered_index to 
2019-11-29T06:52:29.552+0800	done dumping test.foo (1 document)
2019-11-29T06:52:29.552+0800	done dumping test_db.table_covered_index (1 document)
2019-11-29T06:52:32.478+0800	[############............]         test_db.test  529588/1019550  (51.9%)
2019-11-29T06:52:32.478+0800	[########................]  test_db.table_index  353092/1000000  (35.3%)
2019-11-29T06:52:32.478+0800	
2019-11-29T06:52:34.828+0800	[########################]  test_db.test  1019550/1019550  (100.0%)
2019-11-29T06:52:34.828+0800	done dumping test_db.test (1019550 documents)
2019-11-29T06:52:35.484+0800	[###################.....]  test_db.table_index  830552/1000000  (83.1%)
2019-11-29T06:52:36.168+0800	[########################]  test_db.table_index  1000000/1000000  (100.0%)
2019-11-29T06:52:36.168+0800	done dumping test_db.table_index (1000000 documents)
2019-11-29T06:52:36.169+0800	writing captured oplog to 
2019-11-29T06:52:36.171+0800		dumped 2 oplog entries




mongodb 指令说明：

	-h:        指定当前备份主机ip
	-u:        指定验证的用户名
	-p:        指定用户名对应的密码
	--oplog:   replica set或者master/slave模式专用。在备份过程中捕获oplog更改日志，以保持一致的时间点。该选项只对全库导出有效，所以不能指定-d选项。因为整个实例的变更操作都会集中在local库中的oplog.rs集合中。
	--gzip:    可选项。启用备份文件的内联压缩。
	-o:        指定备份的路径
	--authenticationDatabase:    认证数据库
	--oplogReplay:              


	
# ./mongorestore -h 'mongors/10.133.8.232:27017,10.53.101.8:27017' -u 'user' -p 'pwd' --oplogReplay --gzip /data/mongodb/dump/20190703





	[root@mongodb01 log]# mongodump --help
	Usage:
	  mongodump <options>

	Export the content of a running server into .bson files.

	Specify a database with -d and a collection with -c to only dump that database or collection.

	See http://docs.mongodb.org/manual/reference/program/mongodump/ for more information.

	general options:
		  --help                                                print usage
		  --version                                             print the tool version and exit

	verbosity options:
	  -v, --verbose=<level>                                     more detailed log output (include multiple times for more verbosity, e.g. -vvvvv, or specify a numeric value, e.g. --verbose=N)
		  --quiet                                               hide all log output

	connection options:
	  -h, --host=<hostname>                                     mongodb host to connect to (setname/host1,host2 for replica sets)
		  --port=<port>                                         server port (can also use --host hostname:port)

	ssl options:
		  --ssl                                                 connect to a mongod or mongos that has ssl enabled
		  --sslCAFile=<filename>                                the .pem file containing the root certificate chain from the certificate authority
		  --sslPEMKeyFile=<filename>                            the .pem file containing the certificate and key
		  --sslPEMKeyPassword=<password>                        the password to decrypt the sslPEMKeyFile, if necessary
		  --sslCRLFile=<filename>                               the .pem file containing the certificate revocation list
		  --sslAllowInvalidCertificates                         bypass the validation for server certificates
		  --sslAllowInvalidHostnames                            bypass the validation for server name
		  --sslFIPSMode                                         use FIPS mode of the installed openssl library

	authentication options:
	  -u, --username=<username>                                 username for authentication
	  -p, --password=<password>                                 password for authentication
		  --authenticationDatabase=<database-name>              database that holds the user's credentials
		  --authenticationMechanism=<mechanism>                 authentication mechanism to use

	namespace options:
	  -d, --db=<database-name>                                  database to use
	  -c, --collection=<collection-name>                        collection to use

	uri options:
		  --uri=mongodb-uri                                     mongodb uri connection string

	query options:
	  -q, --query=                                              query filter, as a JSON string, e.g., '{x:{$gt:1}}'
		  --queryFile=                                          path to a file containing a query filter (JSON)
		  --readPreference=<string>|<json>                      specify either a preference name or a preference json object
		  --forceTableScan                                      force a table scan

	output options:
	  -o, --out=<directory-path>                                output directory, or '-' for stdout (defaults to 'dump')
		  --gzip                                                compress archive our collection output with Gzip
		  --repair                                              try to recover documents from damaged data files (not supported by all storage engines)
		  --oplog                                               use oplog for taking a point-in-time snapshot
		  --archive=<file-path>                                 dump as an archive to the specified path. If flag is specified without a value, archive is written to stdout
		  --dumpDbUsersAndRoles                                 dump user and role definitions for the specified database
		  --excludeCollection=<collection-name>                 collection to exclude from the dump (may be specified multiple times to exclude additional collections)
		  --excludeCollectionsWithPrefix=<collection-prefix>    exclude all collections from the dump that have the given prefix (may be specified multiple times to exclude additional prefixes)
	  -j, --numParallelCollections=                             number of collections to dump in parallel (4 by default) (default: 4)
		  --viewsAsCollections                                  dump views as normal collections with their produced data, omitting standard collections

		  
	  
	  
	[root@mongodb01 20191129]# mongorestore --help
	Usage:
	  mongorestore <options> <directory or file to restore>

	Restore backups generated with mongodump to a running server.

	Specify a database with -d to restore a single database from the target directory,
	or use -d and -c to restore a single collection from a single .bson file.

	See http://docs.mongodb.org/manual/reference/program/mongorestore/ for more information.

	general options:
		  --help                                                print usage
		  --version                                             print the tool version and exit

	verbosity options:
	  -v, --verbose=<level>                                     more detailed log output (include multiple times for more verbosity, e.g. -vvvvv, or specify a numeric value, e.g. --verbose=N)
		  --quiet                                               hide all log output

	connection options:
	  -h, --host=<hostname>                                     mongodb host to connect to (setname/host1,host2 for replica sets)
		  --port=<port>                                         server port (can also use --host hostname:port)

	ssl options:
		  --ssl                                                 connect to a mongod or mongos that has ssl enabled
		  --sslCAFile=<filename>                                the .pem file containing the root certificate chain from the certificate authority
		  --sslPEMKeyFile=<filename>                            the .pem file containing the certificate and key
		  --sslPEMKeyPassword=<password>                        the password to decrypt the sslPEMKeyFile, if necessary
		  --sslCRLFile=<filename>                               the .pem file containing the certificate revocation list
		  --sslAllowInvalidCertificates                         bypass the validation for server certificates
		  --sslAllowInvalidHostnames                            bypass the validation for server name
		  --sslFIPSMode                                         use FIPS mode of the installed openssl library

	authentication options:
	  -u, --username=<username>                                 username for authentication
	  -p, --password=<password>                                 password for authentication
		  --authenticationDatabase=<database-name>              database that holds the user's credentials
		  --authenticationMechanism=<mechanism>                 authentication mechanism to use

	uri options:
		  --uri=mongodb-uri                                     mongodb uri connection string

	namespace options:
	  -d, --db=<database-name>                                  database to use when restoring from a BSON file
	  -c, --collection=<collection-name>                        collection to use when restoring from a BSON file
		  --excludeCollection=<collection-name>                 DEPRECATED; collection to skip over during restore (may be specified multiple times to exclude additional collections)
		  --excludeCollectionsWithPrefix=<collection-prefix>    DEPRECATED; collections to skip over during restore that have the given prefix (may be specified multiple times to exclude additional prefixes)
		  --nsExclude=<namespace-pattern>                       exclude matching namespaces
		  --nsInclude=<namespace-pattern>                       include matching namespaces
		  --nsFrom=<namespace-pattern>                          rename matching namespaces, must have matching nsTo
		  --nsTo=<namespace-pattern>                            rename matched namespaces, must have matching nsFrom

	input options:
		  --objcheck                                            validate all objects before inserting
		  --oplogReplay                                         replay oplog for point-in-time restore
		  --oplogLimit=<seconds>[:ordinal]                      only include oplog entries before the provided Timestamp
		  --oplogFile=<filename>                                oplog file to use for replay of oplog
		  --archive=<filename>                                  restore dump from the specified archive file.  If flag is specified without a value, archive is read from stdin
		  --restoreDbUsersAndRoles                              restore user and role definitions for the given database
		  --dir=<directory-name>                                input directory, use '-' for stdin
		  --gzip                                                decompress gzipped input

	restore options:
		  --drop                                                drop each collection before import
		  --dryRun                                              view summary without importing anything. recommended with verbosity
		  --writeConcern=<write-concern>                        write concern options e.g. --writeConcern majority, --writeConcern '{w: 3, wtimeout: 500, fsync: true, j: true}'
		  --noIndexRestore                                      don't restore indexes
		  --noOptionsRestore                                    don't restore collection options
		  --keepIndexVersion                                    don't update index version
		  --maintainInsertionOrder                              preserve order of documents during restoration
	  -j, --numParallelCollections=                             number of collections to restore in parallel (4 by default) (default: 4)
		  --numInsertionWorkersPerCollection=                   number of insert operations to run concurrently per collection (1 by default) (default: 1)
		  --stopOnError                                         stop restoring if an error is encountered on insert (off by default)
		  --bypassDocumentValidation                            bypass document validation
		  --preserveUUID                                        preserve original collection UUIDs (off by default, requires drop)

	  
	  