
1. MongoDB 版本
2. 执行流程
3. 状态
4. 错误日志记录了创建索引的过程和耗时
5. 小结


1. MongoDB 版本
	version: "4.2.7" 
 

2. 执行流程
	session A                     session B
	
	db.table_clubgamelog.createIndex({"szToken" : 1})
								  
								  db.table_clubgamelog.remove({'szToken':'10045-913672-1593716373-16-8'})
									
								  -- szToken 没有索引，所以会全集合扫描。
								  
								  

3. 状态
	repl_set:PRIMARY> db.table_clubgamelog.createIndex({"szToken" : 1})
	{
		"createdCollectionAutomatically" : false,
		"numIndexesBefore" : 2,
		"numIndexesAfter" : 3,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1596769209, 1),
			"signature" : {
				"hash" : BinData(0,"s0u6+ONcXWND8FkgoQF/Y9y2Cfk="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1596769209, 1)
	}


	repl_set:PRIMARY> db.table_clubgamelog.remove({'szToken':'10045-913672-1593716373-16-8'})
	WriteResult({ "nRemoved" : 18 })
	
4. 错误日志记录了创建索引的过程和耗时	

	2020-08-07T10:58:31.911+0800 I  INDEX    [conn1729] index build: starting on aiuaiu_h5.table_clubgamelog properties: { v: 2, key: { szToken: 1.0 }, name: "szToken_1", ns: "aiuaiu_h5.table_clubgamelog" } using method: Hybrid
	2020-08-07T10:58:31.911+0800 I  INDEX    [conn1729] build may temporarily use up to 200 megabytes of RAM
	2020-08-07T10:58:34.001+0800 I  -        [conn1729]   Index Build: scanning collection: 530000/10309189 5%
	2020-08-07T10:58:37.001+0800 I  -        [conn1729]   Index Build: scanning collection: 1096900/10309187 10%
	2020-08-07T10:58:40.002+0800 I  -        [conn1729]   Index Build: scanning collection: 1880200/10309186 18%
	2020-08-07T10:58:43.003+0800 I  -        [conn1729]   Index Build: scanning collection: 2766600/10309185 26%
	2020-08-07T10:58:55.903+0800 I  -        [conn1729]   Index Build: scanning collection: 3172600/10309178 30%
	2020-08-07T10:58:58.408+0800 I  -        [conn1729]   Index Build: scanning collection: 3284600/10309178 31%
	2020-08-07T10:59:01.519+0800 I  -        [conn1729]   Index Build: scanning collection: 3457500/10309178 33%
	2020-08-07T10:59:04.002+0800 I  -        [conn1729]   Index Build: scanning collection: 3646100/10309178 35%
	2020-08-07T10:59:07.001+0800 I  -        [conn1729]   Index Build: scanning collection: 4178800/10309178 40%
	2020-08-07T10:59:10.001+0800 I  -        [conn1729]   Index Build: scanning collection: 4628700/10309174 44%
	2020-08-07T10:59:13.001+0800 I  -        [conn1729]   Index Build: scanning collection: 5215200/10309174 50%
	2020-08-07T10:59:14.475+0800 I  REPL     [replexec-56] Member 10.10.10.227:27017 is now in state RS_DOWN - no response within election timeout period
	2020-08-07T10:59:16.001+0800 I  ELECTION [conn105] Received vote request: { replSetRequestVotes: 1, setName: "repl_set", dryRun: true, term: 170, candidateIndex: 1, configVersion: 4, lastCommittedOp: { ts: Timestamp(1596769129, 2), t: 170 } }
	2020-08-07T10:59:16.002+0800 I  ELECTION [conn105] Sending vote response: { term: 170, voteGranted: false, reason: "candidate's data is staler than mine. candidate's last applied OpTime: { ts: Timestamp(1596769129, 2), t: 170 }, my last applied OpTime: { ts: Timesta..." }
	2020-08-07T10:59:16.004+0800 I  -        [conn1729]   Index Build: scanning collection: 5796800/10309174 56%
	2020-08-07T10:59:16.192+0800 I  REPL     [replexec-55] Member 10.10.10.227:27017 is now in state SECONDARY
	2020-08-07T10:59:16.432+0800 I  COMMAND  [LogicalSessionCacheRefresh] command config.$cmd command: update { update: "system.sessions", ordered: false, allowImplicitCollectionCreation: false, writeConcern: { w: "majority", wtimeout: 15000 }, $db: "config" } numYields:1 reslen:245 locks:{ ParallelBatchWriterMode: { acquireCount: { r: 3 } }, ReplicationStateTransition: { acquireCount: { w: 3 } }, Global: { acquireCount: { w: 3 } }, Database: { acquireCount: { w: 3 } }, Collection: { acquireCount: { w: 3 } }, Mutex: { acquireCount: { r: 4 } } } flowControl:{ acquireCount: 3, timeAcquiringMicros: 2 } storage:{ data: { bytesRead: 551, timeReadingMicros: 12242 } } protocol:op_msg 863ms
	2020-08-07T10:59:19.003+0800 I  -        [conn1729]   Index Build: scanning collection: 6253800/10309174 60%
	
	-- 到这里执行 delete 删除集合 'szToken':'10045-913672-1593716373-16-8' 的数据
	2020-08-07T10:59:24.224+0800 I  WRITE    [conn1730] remove aiuaiu_h5.table_clubgamelog appName: "MongoDB Shell" command: 
	{ q: { szToken: "10045-913672-1593716373-16-8" }, limit: 0 } 
	planSummary: COLLSCAN keysExamined:0 docsExamined:10442742 ndeleted:18 keysDeleted:54 numYields:81675 queryHash:16AB364D planCacheKey:53A94721 
	locks:{ ParallelBatchWriterMode: { acquireCount: { r: 81676 } }, 
	ReplicationStateTransition: { acquireCount: { w: 81676 } }, 
	Global: { acquireCount: { w: 81676 } }, Database: { acquireCount: { w: 81676 } },
	Collection: { acquireCount: { w: 81676 } }, Mutex: { acquireCount: { r: 37 } } } 
	flowControl:{ acquireCount: 81676, timeAcquiringMicros: 46562 } 
	storage:{ data: { bytesRead: 18090159186, timeReadingMicros: 40237351 }, timeWaitingMicros: { cache: 5771 } } 50413ms
	
	2020-08-07T10:59:24.224+0800 I  COMMAND  [conn1730] command aiuaiu_h5.$cmd appName: "MongoDB Shell" 
	command: delete { delete: "table_clubgamelog", ordered: true, lsid: { id: UUID("8f758dde-8494-469f-a33c-974c3ac45b9d") }, 
	$clusterTime: { clusterTime: Timestamp(1596769058, 1), signature: { hash: BinData(0, 5CA4E2E8B53AD6F8B0699355B1F0BF4A09458361), keyId: 6838881995993382915 } }, 
	$db: "aiuaiu_h5" } numYields:81675 reslen:230 locks:{ ParallelBatchWriterMode: { acquireCount: { r: 81677 } }, 
	ReplicationStateTransition: { acquireCount: { w: 81677 } }, Global: { acquireCount: { r: 1, w: 81676 } }, 
	Database: { acquireCount: { w: 81676 } }, Collection: { acquireCount: { w: 81676 } }, 
	Mutex: { acquireCount: { r: 37 } } } flowControl:{ acquireCount: 81676, timeAcquiringMicros: 46562 } storage:{} protocol:op_msg 50419ms
	
	
	2020-08-07T10:59:28.961+0800 I  -        [conn1729]   Index Build: scanning collection: 6344600/10309172 61%
	2020-08-07T10:59:31.024+0800 I  -        [conn1729]   Index Build: scanning collection: 6620100/10309172 64%
	2020-08-07T10:59:32.815+0800 I  REPL     [replexec-54] Member 10.10.10.227:27017 is now in state RS_DOWN - no response within election timeout period
	2020-08-07T10:59:34.917+0800 I  -        [conn1729]   Index Build: scanning collection: 7071500/10309172 68%
	2020-08-07T10:59:35.083+0800 I  CONNPOOL [Replication] Ending connection to host 10.10.10.227:27017 due to bad connection status: CallbackCanceled: Callback was canceled; 0 connections to that host remain open
	2020-08-07T10:59:35.083+0800 I  CONNPOOL [Replication] Connecting to 10.10.10.227:27017
	2020-08-07T10:59:38.136+0800 I  -        [conn1729]   Index Build: scanning collection: 7138100/10309172 69%
	2020-08-07T10:59:41.015+0800 I  -        [conn1729]   Index Build: scanning collection: 7825300/10309172 75%
	2020-08-07T10:59:44.001+0800 I  -        [conn1729]   Index Build: scanning collection: 8588000/10309172 83%
	2020-08-07T10:59:47.001+0800 I  -        [conn1729]   Index Build: scanning collection: 9381100/10309172 90%
	2020-08-07T10:59:52.005+0800 I  ELECTION [conn105] Received vote request: { replSetRequestVotes: 1, setName: "repl_set", dryRun: true, term: 170, candidateIndex: 1, configVersion: 4, lastCommittedOp: { ts: Timestamp(1596769155, 2), t: 170 } }
	2020-08-07T10:59:52.005+0800 I  ELECTION [conn105] Sending vote response: { term: 170, voteGranted: false, reason: "candidate's data is staler than mine. candidate's last applied OpTime: { ts: Timestamp(1596769155, 2), t: 170 }, my last applied OpTime: { ts: Timesta..." }
	2020-08-07T10:59:52.083+0800 I  REPL     [replexec-55] Member 10.10.10.227:27017 is now in state SECONDARY
	2020-08-07T10:59:55.609+0800 I  -        [conn1729]   Index Build: scanning collection: 9517200/10309172 92%
	2020-08-07T10:59:58.007+0800 I  -        [conn1729]   Index Build: scanning collection: 10129600/10309172 98%
	2020-08-07T10:59:59.461+0800 I  INDEX    [conn1729] index build: collection scan done. scanned 10442730 total records in 87 seconds
	2020-08-07T11:00:05.001+0800 I  -        [conn1729]   Index Build: inserting keys from external sorter into index: 3153700/10442730 30%
	2020-08-07T11:00:08.001+0800 I  -        [conn1729]   Index Build: inserting keys from external sorter into index: 8165100/10442730 78%
	2020-08-07T11:00:09.294+0800 I  INDEX    [conn1729] index build: inserted 10442730 keys from external sorter into index in 9 seconds
	
	deleted: 18：从索引树中删除18个文档
	2020-08-07T11:00:09.787+0800 I  INDEX    [conn1729] index build: drain applied 18 side writes (inserted: 0, deleted: 18) for 'szToken_1' in 1 ms
	
	2020-08-07T11:00:09.787+0800 I  INDEX    [conn1729] index build: done building index szToken_1 on ns aiuaiu_h5.table_clubgamelog
	2020-08-07T11:00:09.791+0800 I  COMMAND  [conn1729] command aiuaiu_h5.table_clubgamelog appName: "MongoDB Shell" 
	command: createIndexes { createIndexes: "table_clubgamelog", indexes: [ { key: { szToken: 1.0 }, name: "szToken_1" } ], 
	lsid: { id: UUID("d9f33e54-a973-4d47-8c1d-21f29ccba5c8") }, $clusterTime: { clusterTime: Timestamp(1596769029, 1), 
	signature: { hash: BinData(0, FE2FD99D8849765F315528E107967B5556A04B9E), keyId: 6838881995993382915 } }, 
	$db: "aiuaiu_h5" } numYields:81650 reslen:239 locks:{ ParallelBatchWriterMode: { acquireCount: { r: 81652 } }, 
	ReplicationStateTransition: { acquireCount: { w: 81653 } }, Global: { acquireCount: { r: 1, w: 81652 } }, 
	Database: { acquireCount: { r: 1, w: 81652 } }, Collection: { acquireCount: { r: 81652, w: 1, R: 1, W: 2 } }, 
	Mutex: { acquireCount: { r: 4 } } } flowControl:{ acquireCount: 81651, timeAcquiringMicros: 42033 } 
	storage:{ data: { bytesRead: 18798994053, timeReadingMicros: 39622037 }, timeWaitingMicros: { cache: 4190 } } 
	protocol:op_msg 97894ms
		创建索引的耗时：97894ms = 98 秒
	2020-08-07T11:00:16.521+0800 I  NETWORK  [listener] connection accepted from 10.10.10.223:41110 #1760 (11 connections now open)
	2020-08-07T11:00:16.521+0800 I  NETWORK  [conn1760] received client metadata from 10.10.10.223:41110 conn1760: { driver: { name: "NetworkInterfaceTL", version: "4.2.7" }, os: { type: "Linux", name: "CentOS Linux release 7.3.1611 (Core) ", architecture: "x86_64", version: "Kernel 3.10.0-514.26.2.el7.x86_64" } }
	2020-08-07T11:00:16.558+0800 I  NETWORK  [conn1746] end connection 10.10.10.223:41034 (10 connections now open)
	2020-08-07T11:00:16.558+0800 I  ACCESS   [conn1760] Successfully authenticated as principal __system on local from client 10.10.10.223:41110
	2020-08-07T11:00:16.559+0800 I  NETWORK  [listener] connection accepted from 10.10.10.223:41112 #1761 (11 connections now open)
	2020-08-07T11:00:16.560+0800 I  NETWORK  [conn1761] received client metadata from 10.10.10.223:41112 conn1761: { driver: { name: "MongoDB Internal Client", version: "4.2.7" }, os: { type: "Linux", name: "CentOS Linux release 7.3.1611 (Core) ", architecture: "x86_64", version: "Kernel 3.10.0-514.26.2.el7.x86_64" } }
	2020-08-07T11:00:16.596+0800 I  ACCESS   [conn1761] Successfully authenticated as principal __system on local from client 10.10.10.223:41112
	2020-08-07T11:00:16.597+0800 I  NETWORK  [conn1761] end connection 10.10.10.223:41112 (10 connections now open)


5. 小结
	4.2 版本支持在线添加索引

