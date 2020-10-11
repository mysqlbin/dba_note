


1. 内部缓存
2. Jounal 
3. checkpoint 
4. 后台线程

1. 语句的执行流程
	语句的执行流程
		1. 客户端的数据进来；
		2. 数据操作写入到日志缓冲；
		3. 数据写入到数据缓冲；
		4. 返回操作结果到客户端(异步)；
		5. 后台线程进行日志缓冲中的日志数据刷盘，默认100毫秒（非常频繁），也可自行设置（30-60）；
		6. 后台线程进行数据缓冲中的数据刷盘，默认是60秒；

	单节点上的update 语句的更新流程

		0. 客户端的数据进来；
		1. 数据页不在内存中，先读入内存中
		2. 在内存中修改数据页的时候，会先把数据页拷贝出来成为一个新的数据页
		3. 然后在新的数据页上做修改
		4. 写 jounal 日志到 journal buffer 中
		5. 返回操作结果到客户端(异步)；
		6. 后台线程进行日志缓冲中的日志数据刷盘，默认100毫秒（非常频繁），也可自行设置（30-60）；
		7. 后台线程进行数据缓冲中的脏数据刷盘，默认是60秒(触发checkpoint)；
			Wiredtiger采用 Copy on write（快照）的方式管理修改操作（insert、update、delete），
			数据页持久化时，修改操作不会在原来的leaf page上进行，而是写入新分配的page，每次checkpoint都会产生一个新的root page。


			
			
		
	
MySQL 也有checkpoint, 当把脏页刷盘，对应的redo日志就可以进行checkpoint，
	数据页有 LSN, redo日志也有LSN， LSN 表示checkpoint的大小
	redo日志也有LSN >= 数据页的LSN

MongoDB 也有checkpoint，当把脏页刷盘，并做一个标记点即checkpoint，对应的journal日志就可以进行清除
	-- by自己的整理
	
	从3.6版开始，MongoDB配置WiredTiger以60秒的间隔创建检查点（即将快照数据写入磁盘）。
	一旦Checkpoint创建成功，WiredTiger保证数据文件和内存数据是一致性的
	checkpoint机制将内存中的数据变更（脏页）flush到磁盘中的数据文件中，并做一个标记点，表示标记点之前的数据已经持久存储在了数据文件中，标记点之前的内存数据与磁盘的数据一致，同时释放了缓冲池空间；
	
		检测点创建后，此前的journal日志即可清除；标记点之后的数据变更存在于内存和journal日志中。
	
		崩溃恢复的起点就从这个checkpoint开始，缩短了数据库的恢复时间。
		
		
	对于write操作，首先被持久写入journal，然后在内存中保存变更数据，条件满足后提交一个新的检测点，即检测点之前的数据只是在journal中持久存储，但并没有在mongodb的数据文件中持久化，延迟持久化可以提升磁盘效率，
	如果在提交checkpoint之前，mongodb异常退出，此后再次启动可以根据journal日志恢复数据。
	journal日志默认每个100毫秒同步磁盘一次，每100M数据生成一个新的journal文件同时会把日志同步到磁盘，journal默认使用了snappy压缩，检测点创建后，此前的journal日志即可清除。
	mongod可以禁用journal，这在一定程度上可以降低它带来的开支；对于单点mongod，关闭journal可能会在异常关闭时丢失checkpoint之间的数据（那些尚未提交到磁盘数据文件的数据）；
	对于replica set架构，持久性的保证稍高，但仍然不能保证绝对的安全（比如replica set中所有节点几乎同时退出时）。

		
	checkpoint、脏数据页、journal 之间的关系、那checkpoint跟evict page的关系呢
	threads_min、threads_max
		当cache里面的脏页达到一定比例或cache使用量达到一定比例时就会触发相应的evict page线程来将pages（包含干净的pages和脏pages）按一定的算法（LRU队列）淘汰出去，以便腾挪出内存空间，保障后面新的插入或修改等操作。	
		
	在Checkpoint操作开始时，WiredTiger提供指定时间点（point-in-time）的数据库快照（Snapshot），该Snapshot呈现的是内存中数据的一致性视图。
	当向Disk写入数据时，WiredTiger将Snapshot中的所有数据以一致性方式写入到数据文件（Disk Files）中。
	一旦Checkpoint创建成功，WiredTiger保证数据文件和内存数据是一致性的，因此，Checkpoint担当的是还原点（Recovery Point），Checkpoint操作能够缩短MongoDB从Journal日志文件还原数据的时间。
	--MySQL 是从redo checkpoint lsn进行应用redo log进行还原数据页。
	
	 MySQL 的 Checkpoint 解决了什么问题：
        1）. 缩短数据库的恢复时间：
				数据库发生宕机时，如果全量Redo log都需要恢复，那么恢复时间会很长；
				所以需要Checkpoint 之前的页刷新到磁盘，不需要重做所有的Redo log, 数据库只需要对Redo log LSN - Checkpoint LSN的重做日志进行恢复，大大缩短了恢复的时间。
        2）. 保证缓冲池有空闲页：
				当缓冲池（内存）不够用时，根据LRU算法会溢出最近最少使用的页， 若此页为脏页，那么需要强制执行Checkpint， 将脏页刷新回磁盘。
        3）. 确保重做日志可用：
                Redo log 不够用时，需要触发 Checkpoint 把 Redo log LSN 减去 Checkpoint LSN  的日志对应的脏页刷新到磁盘，Checkpoint 完成之后，在这个位置之前的Redo log日志不再需要，即可以循环覆盖使用。


				
				
2. 快照和检查点 --Snapshots and Checkpoints 
	-- by官方文档的翻译
	
	WiredTiger使用MultiVersion并发控制（MVCC）。在操作开始时，WiredTiger为操作提供数据的时间点快照。快照提供了内存数据的一致视图。

	写入磁盘时，WiredTiger将所有数据文件中的快照中的所有数据以一致的方式写入磁盘。现在持久的数据充当数据文件中的检查点。该检查点可确保数据文件直到最后一个检查点（包括最后一个检查点）都保持一致；即检查点可以充当恢复点。(检查点前的脏页数据跟磁盘上的一致)

	从3.6版开始，MongoDB配置WiredTiger以60秒的间隔创建检查点（即将快照数据写入磁盘）。
	
	在早期版本中，MongoDB将检查点设置为在WiredTiger中以60秒的间隔或在写入2 GB日记数据时对用户数据进行检查，以先到者为准。

	在写入新检查点期间，先前的检查点仍然有效。这样，即使MongoDB在写入新检查点时终止或遇到错误，在重新启动后，MongoDB也可以从上一个有效检查点中恢复。

	当WiredTiger的元数据表被原子更新以引用新的检查点时，新的检查点将变为可访问且永久的。一旦可以访问新的检查点，WiredTiger就会从旧的检查点释放页面。
	
	使用WiredTiger，即使没有日记，MongoDB也可以从最后一个检查点恢复； 但是，要恢复上一个检查点之后所做的更改，请开启日记功能。
	--这个是重点。

	
checkpoint 
	
	
	

        
按照MongoDB默认的配置，WiredTiger的写操作会先写入Cache（BTree结构），当Cache大小达到128KB时便将其持久化到 预写日志文件(Write ahead log) 。
	MongoDB配置WiredTiger使用内存缓冲区来存储Journal Records，所有没有达到128KB的Journal Records都会被缓存在缓冲区中，直到大小超过128KB。
	在执行写操作时，WiredTiger将Journal Records存储在缓冲区中，如果MongoDB异常关机，存储在内存中的Journal Records将丢失，这意味着，WiredTiger将丢失最大128KB的数据更新。

	
	

从上图可以看到，页面的修改并不是在原有的空间进行，而是将改变的页面在新的页面生成，在通过指针从新的生成的页面，指向未改变的页面。将新的根地址写入到 metadata 中。
这样的处理的速度要比加锁，然后改变数据的方式要快的多。
并且大部分MONGODB处理的方式多是写和读，大量的UPDATE 的并不多见。
	
	https://mp.weixin.qq.com/s/-LssIUI4fjwUVaAYvAyA8Q MONGODB Wiredtiger 为什么那么快？

	https://blog.csdn.net/gaozhigang/article/details/79241044  Mongodb存储特性与内部原理
	https://docs.mongodb.com/manual/core/wiredtiger/ 
	https://docs.mongodb.com/manual/core/wiredtiger/#storage-wiredtiger-checkpoints

	
	

	
[root@mongodb03 journal]# pwd
/data/mongodb/data/journal
[root@mongodb03 journal]# ll
total 307200
-rw------- 1 root root 104857600 Dec  6 13:11 WiredTigerLog.0000000007
-rw------- 1 root root 104857600 Nov 28 09:36 WiredTigerPreplog.0000000004
-rw------- 1 root root 104857600 Dec  5 03:05 WiredTigerPreplog.0000000005

journal存储Write ahead log


[root@mongodb03 data]# pwd
/data/mongodb/data
[root@mongodb03 data]# ll
-rw------- 1 root root        45 Nov 27 11:50 WiredTiger
-rw------- 1 root root      4096 Nov 28 03:45 WiredTigerLAS.wt
-rw------- 1 root root        21 Nov 27 11:50 WiredTiger.lock
-rw------- 1 root root      1083 Dec  6 13:11 WiredTiger.turtle
-rw------- 1 root root    167936 Dec  6 13:11 WiredTiger.wt




	

use admin

db.runCommand( { getParameter : '*' } )



repl_set:PRIMARY> db.runCommand( { getParameter : '*' } )
{
	"AsyncRequestsSenderUseBaton" : true,
	"KeysRotationIntervalSec" : 7776000,
	"ShardingTaskExecutorPoolHostTimeoutMS" : 300000,
	"ShardingTaskExecutorPoolMaxConnecting" : 2,
	"ShardingTaskExecutorPoolMaxSize" : -1,
	"ShardingTaskExecutorPoolMinSize" : 1,
	"ShardingTaskExecutorPoolRefreshRequirementMS" : 60000,
	"ShardingTaskExecutorPoolRefreshTimeoutMS" : 20000,
	"TransactionRecordMinimumLifetimeMinutes" : 30,
	"adaptiveServiceExecutorIdlePctThreshold" : 60,
	"adaptiveServiceExecutorMaxQueueLatencyMicros" : 500,
	"adaptiveServiceExecutorRecursionLimit" : 8,
	"adaptiveServiceExecutorReservedThreads" : -1,
	"adaptiveServiceExecutorRunTimeJitterMillis" : 500,
	"adaptiveServiceExecutorRunTimeMillis" : 5000,
	"adaptiveServiceExecutorStuckThreadTimeoutMillis" : 250,
	"allowRolesFromX509Certificates" : true,
	"allowSecondaryReadsDuringBatchApplication" : true,
	"authSchemaVersion" : 5,
	"authenticationMechanisms" : [
		"MONGODB-X509",
		"SCRAM-SHA-1",
		"SCRAM-SHA-256"
	],
	"bgSyncOplogFetcherBatchSize" : 13981010,
	"clientCursorMonitorFrequencySecs" : 4,
	"cloudFreeMonitoringEndpointURL" : "https://cloud.mongodb.com/freemonitoring/mongo",
	"clusterAuthMode" : "undefined",
	"collectionClonerBatchSize" : -1,
	"connPoolMaxConnsPerHost" : 200,
	"connPoolMaxInUseConnsPerHost" : 2147483647,
	"connPoolMaxShardedConnsPerHost" : 200,
	"connPoolMaxShardedInUseConnsPerHost" : 2147483647,
	"createRollbackDataFiles" : true,
	"createTimestampSafeUniqueIndex" : false,
	"cursorTimeoutMillis" : NumberLong(600000),
	"debugCollectionUUIDs" : false,
	"diagnosticDataCollectionDirectorySizeMB" : 200,
	"diagnosticDataCollectionEnabled" : true,
	"diagnosticDataCollectionFileSizeMB" : 10,
	"diagnosticDataCollectionPeriodMillis" : 1000,
	"diagnosticDataCollectionSamplesPerChunk" : 300,
	"diagnosticDataCollectionSamplesPerInterimUpdate" : 10,
	"disableJavaScriptJIT" : true,
	"disableLogicalSessionCacheRefresh" : false,
	"disableNonSSLConnectionLogging" : false,
	"disabledSecureAllocatorDomains" : [ ],
	"enableElectionHandoff" : true,
	"enableInMemoryTransactions" : false,
	"enableLocalhostAuthBypass" : true,
	"enableTestCommands" : false,
	"failIndexKeyTooLong" : true,
	"featureCompatibilityVersion" : {
		"version" : "4.0"
	},
	"forceRollbackViaRefetch" : false,
	"globalConnPoolIdleTimeoutMinutes" : 2147483647,
	"heapProfilingEnabled" : false,
	"heapProfilingSampleIntervalBytes" : NumberLong(262144),
	"honorSystemUmask" : false,
	"initialSyncOplogBuffer" : "collection",
	"initialSyncOplogBufferPeekCacheSize" : 10000,
	"initialSyncOplogFetcherBatchSize" : 13981010,
	"internalDocumentSourceCursorBatchSizeBytes" : 4194304,
	"internalDocumentSourceLookupCacheSizeBytes" : 104857600,
	"internalGeoNearQuery2DMaxCoveringCells" : 16,
	"internalGeoPredicateQuery2DMaxCoveringCells" : 16,
	"internalInsertMaxBatchSize" : 64,
	"internalLookupStageIntermediateDocumentMaxSizeBytes" : NumberLong(104857600),
	"internalProhibitShardOperationRetry" : false,
	"internalQueryAlwaysMergeOnPrimaryShard" : false,
	"internalQueryCacheEvictionRatio" : 10,
	"internalQueryCacheFeedbacksStored" : 20,
	"internalQueryCacheSize" : 5000,
	"internalQueryEnumerationMaxIntersectPerAnd" : 3,
	"internalQueryEnumerationMaxOrSolutions" : 10,
	"internalQueryExecMaxBlockingSortBytes" : 33554432,
	"internalQueryExecYieldIterations" : 128,
	"internalQueryExecYieldPeriodMS" : 10,
	"internalQueryFacetBufferSizeBytes" : 104857600,
	"internalQueryForceIntersectionPlans" : false,
	"internalQueryIgnoreUnknownJSONSchemaKeywords" : false,
	"internalQueryMaxScansToExplode" : 200,
	"internalQueryPlanEvaluationCollFraction" : 0.3,
	"internalQueryPlanEvaluationMaxResults" : 101,
	"internalQueryPlanEvaluationWorks" : 10000,
	"internalQueryPlanOrChildrenIndependently" : true,
	"internalQueryPlannerEnableHashIntersection" : false,
	"internalQueryPlannerEnableIndexIntersection" : true,
	"internalQueryPlannerGenerateCoveredWholeIndexScans" : false,
	"internalQueryPlannerMaxIndexedSolutions" : 64,
	"internalQueryProhibitBlockingMergeOnMongoS" : false,
	"internalQueryProhibitMergingOnMongoS" : false,
	"internalQueryS2GeoCoarsestLevel" : 0,
	"internalQueryS2GeoFinestLevel" : 23,
	"internalQueryS2GeoMaxCells" : 20,
	"internalValidateFeaturesAsMaster" : true,
	"javascriptProtection" : false,
	"journalCommitInterval" : 0,
	"jsHeapLimitMB" : 1100,
	"localLogicalSessionTimeoutMinutes" : 30,
	"logComponentVerbosity" : {
		"verbosity" : 0,
		"accessControl" : {
			"verbosity" : -1
		},
		"command" : {
			"verbosity" : -1
		},
		"control" : {
			"verbosity" : -1
		},
		"executor" : {
			"verbosity" : -1
		},
		"geo" : {
			"verbosity" : -1
		},
		"index" : {
			"verbosity" : -1
		},
		"network" : {
			"verbosity" : -1,
			"asio" : {
				"verbosity" : -1
			},
			"bridge" : {
				"verbosity" : -1
			},
			"connectionPool" : {
				"verbosity" : -1
			}
		},
		"query" : {
			"verbosity" : -1
		},
		"replication" : {
			"verbosity" : -1,
			"heartbeats" : {
				"verbosity" : -1
			},
			"rollback" : {
				"verbosity" : -1
			}
		},
		"sharding" : {
			"verbosity" : -1,
			"shardingCatalogRefresh" : {
				"verbosity" : -1
			}
		},
		"storage" : {
			"verbosity" : -1,
			"recovery" : {
				"verbosity" : -1
			},
			"journal" : {
				"verbosity" : -1
			}
		},
		"write" : {
			"verbosity" : -1
		},
		"ftdc" : {
			"verbosity" : -1
		},
		"tracking" : {
			"verbosity" : -1
		},
		"transaction" : {
			"verbosity" : -1
		}
	},
	"logLevel" : 0,
	"logicalSessionRefreshMillis" : 300000,
	"maxAcceptableLogicalClockDriftSecs" : NumberLong(31536000),
	"maxBSONDepth" : 200,
	"maxIndexBuildMemoryUsageMegabytes" : 500,
	"maxLogSizeKB" : 10,
	"maxNumInitialSyncCollectionClonerCursors" : 1,
	"maxSessions" : 1000000,
	"maxSyncSourceLagSecs" : 30,
	"maxTransactionLockRequestTimeoutMillis" : 5,
	"migrateCloneInsertionBatchDelayMS" : 0,
	"migrateCloneInsertionBatchSize" : 0,
	"newCollectionsUsePowerOf2Sizes" : true,
	"notablescan" : false,
	"numInitialSyncAttempts" : 10,
	"numInitialSyncCollectionCountAttempts" : 3,
	"numInitialSyncCollectionFindAttempts" : 3,
	"numInitialSyncConnectAttempts" : 10,
	"numInitialSyncListCollectionsAttempts" : 3,
	"numInitialSyncListDatabasesAttempts" : 3,
	"numInitialSyncListIndexesAttempts" : 3,
	"numInitialSyncOplogFindAttempts" : 3,
	"opensslCipherConfig" : "",
	"opensslDiffieHellmanParameters" : "",
	"oplogFetcherInitialSyncMaxFetcherRestarts" : 10,
	"oplogFetcherSteadyStateMaxFetcherRestarts" : 1,
	"oplogInitialFindMaxSeconds" : 60,
	"oplogRetriedFindMaxSeconds" : 2,
	"orphanCleanupDelaySecs" : 900,
	"periodicNoopIntervalSecs" : 10,
	"priorityTakeoverFreshnessWindowSeconds" : 2,
	"quiet" : false,
	"rangeDeleterBatchDelayMS" : 20,
	"rangeDeleterBatchSize" : 0,
	"recoverFromOplogAsStandalone" : false,
	"replBatchLimitBytes" : 104857600,
	"replBatchLimitOperations" : 5000,
	"replElectionTimeoutOffsetLimitFraction" : 0.15,
	"replIndexPrefetch" : "all",
	"replWriterThreadCount" : 16,
	"reportOpWriteConcernCountersInServerStatus" : false,
	"reservedServiceExecutorRecursionLimit" : 8,
	"rollbackRemoteOplogQueryBatchSize" : 2000,
	"rollbackTimeLimitSecs" : 86400,
	"saslHostName" : "mongodb03",
	"saslServiceName" : "mongodb",
	"saslauthdPath" : "",
	"scramIterationCount" : 10000,
	"scramSHA256IterationCount" : 15000,
	"scriptingEngineInterruptIntervalMS" : 1000,
	"shardedConnPoolIdleTimeoutMinutes" : 2147483647,
	"skipCorruptDocumentsWhenCloning" : false,
	"skipShardingConfigurationChecks" : false,
	"sslMode" : "disabled",
	"sslWithholdClientCertificate" : false,
	"startupAuthSchemaValidation" : true,
	"suppressNoTLSPeerCertificateWarning" : false,
	"syncdelay" : 60,
	"synchronousServiceExecutorRecursionLimit" : 8,
	"taskExecutorPoolSize" : 1,
	"tcmallocAggressiveMemoryDecommit" : 0,
	"tcmallocEnableMarkThreadTemporarilyIdle" : false,
	"tcmallocMaxTotalThreadCacheBytes" : 240123904,
	"testingSnapshotBehaviorInIsolation" : false,
	"traceExceptions" : false,
	"traceWriteConflictExceptions" : false,
	"transactionLifetimeLimitSeconds" : 60,
	"ttlMonitorEnabled" : true,
	"ttlMonitorSleepSecs" : 60,
	"waitForSecondaryBeforeNoopWriteMS" : 10,
	"waitForStepDownOnNonCommandShutdown" : true,
	"wiredTigerConcurrentReadTransactions" : 128,
	"wiredTigerConcurrentWriteTransactions" : 128,
	"wiredTigerCursorCacheSize" : -100,
	"wiredTigerEngineRuntimeConfig" : "",
	"wiredTigerMaxCacheOverflowSizeGB" : 0,
	"wiredTigerSessionCloseIdleTimeSecs" : 300,
	"writePeriodicNoops" : true,
	"ok" : 1,
	"operationTime" : Timestamp(1575759306, 2),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1575759306, 2),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}


