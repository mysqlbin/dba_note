


1. 版本
2. 执行流程
3. 状态							
4. 错误日志记录了创建索引的过程和耗时
5. 小结

1. 版本
	version: "4.2.7" 
 

2. 执行流程
	session A                     session B
	
	db.table_clubgamelog.createIndex({"szToken" : 1})
						
								db.getCollection("table_clubgamelog").insert( {
									_id: ObjectId("5efc0fd03f2609ef4eea1c78"),
									nGameType: NumberInt("9"),
									tStartTime: "2020-07-01 12:23:22",
									tEndTime: "new Date()",
									szToken: "10001-870730-1593577402-1-1",
									LogData: "..."
									nServerID: NumberInt("901")
								} );


								db.getCollection("table_clubgamelog").insert( {
									_id: ObjectId("5efc0fd03f2609ef4eea1c79"),
									nGameType: NumberInt("9"),
									tStartTime: "2020-07-01 12:23:22",
									tEndTime: "new Date()",
									szToken: "10001-870730-1593577402-1-1",
									LogData: "..."
									nServerID: NumberInt("901")
								} );

	是否会阻塞写操作？
	
	
3. 状态		
	
	repl_set:PRIMARY> db.table_clubgamelog.createIndex({"szToken" : 1})
	{
		"createdCollectionAutomatically" : false,
		"numIndexesBefore" : 2,
		"numIndexesAfter" : 3,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1596771378, 1),
			"signature" : {
				"hash" : BinData(0,"Pd6WvcQB4TFr9ovme5O102pT3Fk="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1596771378, 1)
	}



4. 错误日志记录了创建索引的过程和耗时	
	
	using method: Hybrid  使用方式：混合
	2020-08-07T11:35:00.842+0800 I  INDEX    [conn1782] index build: starting on aiuaiu_h5.table_clubgamelog properties: { v: 2, key: { szToken: 1.0 }, name: "szToken_1", ns: "aiuaiu_h5.table_clubgamelog" } using method: Hybrid
	
	构建索引可能会临时使用多达 200 MB的RAM(内存)
	2020-08-07T11:35:00.842+0800 I  INDEX    [conn1782] build may temporarily use up to 200 megabytes of RAM
	
	开始扫描集合的所有文档
	2020-08-07T11:35:03.009+0800 I  -        [conn1782]   Index Build: scanning collection: 474600/10309173 4%
	2020-08-07T11:35:06.001+0800 I  -        [conn1782]   Index Build: scanning collection: 1274400/10309173 12%
	2020-08-07T11:35:09.001+0800 I  -        [conn1782]   Index Build: scanning collection: 2083500/10309173 20%
	2020-08-07T11:35:12.001+0800 I  -        [conn1782]   Index Build: scanning collection: 2895500/10309173 28%
	2020-08-07T11:35:14.901+0800 I  ACCESS   [conn1777] Successfully authenticated as principal __system on local from client 10.10.10.227:43787
	2020-08-07T11:35:14.902+0800 I  ACCESS   [conn1776] Successfully authenticated as principal __system on local from client 10.10.10.227:43786
	2020-08-07T11:35:14.942+0800 I  ACCESS   [conn1777] Successfully authenticated as principal __system on local from client 10.10.10.227:43787
	2020-08-07T11:35:14.985+0800 I  ACCESS   [conn1777] Successfully authenticated as principal __system on local from client 10.10.10.227:43787
	2020-08-07T11:35:15.029+0800 I  ACCESS   [conn1777] Successfully authenticated as principal __system on local from client 10.10.10.227:43787
	2020-08-07T11:35:16.523+0800 I  NETWORK  [listener] connection accepted from 10.10.10.223:48466 #1783 (11 connections now open)
	2020-08-07T11:35:16.523+0800 I  NETWORK  [conn1783] received client metadata from 10.10.10.223:48466 conn1783: { driver: { name: "MongoDB Internal Client", version: "4.2.7" }, os: { type: "Linux", name: "CentOS Linux release 7.3.1611 (Core) ", architecture: "x86_64", version: "Kernel 3.10.0-514.26.2.el7.x86_64" } }
	2020-08-07T11:35:16.561+0800 I  ACCESS   [conn1783] Successfully authenticated as principal __system on local from client 10.10.10.223:48466
	2020-08-07T11:35:16.562+0800 I  NETWORK  [conn1783] end connection 10.10.10.223:48466 (10 connections now open)
	2020-08-07T11:35:20.653+0800 I  -        [conn1782]   Index Build: scanning collection: 3172600/10309173 30%
	2020-08-07T11:35:23.002+0800 I  -        [conn1782]   Index Build: scanning collection: 3757800/10309173 36%
	2020-08-07T11:35:26.001+0800 I  -        [conn1782]   Index Build: scanning collection: 4578300/10309173 44%
	2020-08-07T11:35:29.003+0800 I  -        [conn1782]   Index Build: scanning collection: 5358000/10309174 51%
	2020-08-07T11:35:32.001+0800 I  -        [conn1782]   Index Build: scanning collection: 6177000/10309174 59%
	2020-08-07T11:35:40.712+0800 I  -        [conn1782]   Index Build: scanning collection: 6344600/10309174 61%
	2020-08-07T11:35:43.001+0800 I  -        [conn1782]   Index Build: scanning collection: 6922700/10309174 67%
	2020-08-07T11:35:46.497+0800 I  -        [conn1782]   Index Build: scanning collection: 7329700/10309174 71%
	2020-08-07T11:35:46.500+0800 I  COMMAND  [ftdc] serverStatus was very slow: { after basic: 0, after asserts: 0, after connections: 0, after electionMetrics: 0, after extra_info: 0, after flowControl: 0, after globalLock: 0, after locks: 0, after logicalSessionRecordCache: 0, after network: 0, after opLatencies: 0, after opReadConcernCounters: 0, after opcounters: 0, after opcountersRepl: 0, after oplogTruncation: 0, after repl: 0, after security: 0, after storageEngine: 0, after tcmalloc: 0, after trafficRecording: 0, after transactions: 0, after transportSecurity: 0, after twoPhaseCommitCoordinator: 0, after wiredTiger: 0, at end: 1500 }
	2020-08-07T11:35:49.001+0800 I  -        [conn1782]   Index Build: scanning collection: 7961000/10309174 77%
	2020-08-07T11:35:52.001+0800 I  -        [conn1782]   Index Build: scanning collection: 8725800/10309174 84%
	2020-08-07T11:35:55.001+0800 I  -        [conn1782]   Index Build: scanning collection: 9496100/10309174 92%
	2020-08-07T11:36:03.059+0800 I  -        [conn1782]   Index Build: scanning collection: 9517200/10309174 92%
	2020-08-07T11:36:06.383+0800 I  -        [conn1782]   Index Build: scanning collection: 10062700/10309174 97%
	2020-08-07T11:36:09.282+0800 I  -        [conn1782]   Index Build: scanning collection: 10412000/10309174 100%
	
	扫描集合的所有文档，耗时 69 秒
	2020-08-07T11:36:09.859+0800 I  INDEX    [conn1782] index build: collection scan done. scanned 10442726 total records in 69 seconds
	
	mongod完成集合扫描后，会将已排序的键转储到索引中。

	2020-08-07T11:36:14.000+0800 I  -        [conn1782]   Index Build: inserting keys from external sorter into index: 3653800/10442726 34%
	2020-08-07T11:36:17.001+0800 I  -        [conn1782]   Index Build: inserting keys from external sorter into index: 9028400/10442726 86%
	
	构造索引树耗时 7 秒
	2020-08-07T11:36:17.780+0800 I  INDEX    [conn1782] index build: inserted 10442726 keys from external sorter into index in 7 seconds
	
	新插入的2个文档也加入到索引树中
	2020-08-07T11:36:18.256+0800 I  INDEX    [conn1782] index build: drain applied 2 side writes (inserted: 2, deleted: 0) for 'szToken_1' in 1 ms
	
	
	2020-08-07T11:36:18.256+0800 I  INDEX    [conn1782] index build: done building index szToken_1 on ns aiuaiu_h5.table_clubgamelog
	
	2020-08-07T11:36:18.258+0800 I  COMMAND  [conn1782] command aiuaiu_h5.table_clubgamelog appName: "MongoDB Shell" command: 
		createIndexes { createIndexes: "table_clubgamelog", 
		indexes: [ { key: { szToken: 1.0 }, name: "szToken_1" } ], 
		lsid: { id: UUID("b5c1f3b9-6eaa-4aa6-8177-f15271f8572e") }, 
		$clusterTime: { clusterTime: Timestamp(1596771255, 1), 
		signature: { hash: BinData(0, 2BD9714F3531A2D9BBFA03D0373505D3DAE390B5), 
		keyId: 6838881995993382915 } }, $db: "aiuaiu_h5" } 
		numYields:81606 reslen:239 
		locks:{ ParallelBatchWriterMode: { acquireCount: { r: 81608 } }, 
		ReplicationStateTransition: { acquireCount: { w: 81609 } },
		Global: { acquireCount: { r: 1, w: 81608 } }, 
		Database: { acquireCount: { r: 1, w: 81608 } }, 
		Collection: { acquireCount: { r: 81608, w: 1, R: 1, W: 2 } }, 
		Mutex: { acquireCount: { r: 4 } } } 
		flowControl:{ acquireCount: 81607, timeAcquiringMicros: 38067 } 
		storage:{ data: { bytesRead: 23191340682, timeReadingMicros: 32559107 }, timeWaitingMicros: { cache: 111 } } protocol:op_msg 77440ms
		
		创建索引的耗时：77440ms = 77.44秒
	
		
		
5. 小结

	索引还是要提前创建好
	
	MongoDB 4.2 版本支持在线添加索引，不再需要通过添加 {background: true} 参数让添加索引操作在后台执行。
	
	https://docs.mongodb.com/v4.2/tutorial/build-indexes-on-replica-sets/ 
	
	创建索引的过程中，在错误日志中记录了一些日志，便于了解创建索引的流程，这点做得比MySQL要好。
	
	