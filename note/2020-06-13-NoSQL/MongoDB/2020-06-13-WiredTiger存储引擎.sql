

相关参考：
	http://www.mongoing.com/archives/2540               MongoDB Wiredtiger存储引擎实现原理
	
	https://www.jianshu.com/p/782ca4c847de              Mongodb WiredTiger存储结构 
	
	https://www.cnblogs.com/ljhdo/p/4947357.html        MongoDB 存储引擎：WiredTiger和In-Memory
	
	https://www.jianshu.com/p/bea62e2dce31              mongodb存储引擎WiredTiger
	
	https://blog.csdn.net/yuanrxdu/article/details/78339295   解析MongoDB存储引擎WiredTiger：事务实现

	https://www.cnblogs.com/wujuntian/p/8458402.html     MongoDB存储引擎（中）——WiredTiger
	
	https://mp.weixin.qq.com/s/EA_nbUTVUehTLw1TZsfApw    一次错误的mongodb使用案例   
		top -Hp pid 显示所有的线程
	 
	https://mp.weixin.qq.com/s/u1I7i7Id_BQtdvqyKGWwnw    MongoDB技术分享：WiredTiger存储引擎 
	
	https://mp.weixin.qq.com/s/jUhXqrGuHBK32bSlWolu5w   『浅入浅出』MongoDB 和 WiredTiger 
	
	 

	
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



检查点（Checkpoint）

	在Checkpoint操作开始时，WiredTiger提供指定时间点（point-in-time）的数据库快照（Snapshot），该Snapshot呈现的是内存中数据的一致性视图。
	当向Disk写入数据时，WiredTiger将Snapshot中的所有数据以一致性方式写入到数据文件（Disk Files）中。
	一旦Checkpoint创建成功，WiredTiger保证数据文件和内存数据是一致性的，因此，Checkpoint担当的是还原点（Recovery Point），Checkpoint操作能够缩短MongoDB从Journal日志文件还原数据的时间。
	（跟MySQL一样的checkpoint类似，checkpoint记录的是脏页刷盘的位置，下一次刷盘就从checkpoint检查点开始刷脏页， 缩短数据库的恢复时间 ）
	
	 MySQL 的 Checkpoint 解决了什么问题：
        1）. 缩短数据库的恢复时间：
				数据库发生宕机时，如果全量Redo log都需要恢复，那么恢复时间会很长；
				所以需要Checkpoint 之前的页刷新到磁盘，不需要重做所有的Redo log, 数据库只需要对Redo log LSN - Checkpoint LSN的重做日志进行恢复，大大缩短了恢复的时间。
        2）. 保证缓冲池有空闲页：
				当缓冲池（内存）不够用时，根据LRU算法会溢出最近最少使用的页， 若此页为脏页，那么需要强制执行Checkpint， 将脏页刷新回磁盘。
        3）. 确保重做日志可用：
                Redo log 不够用时，需要触发 Checkpoint 把 Redo log LSN 减去 Checkpoint LSN  的日志对应的脏页刷新到磁盘，Checkpoint 完成之后，在这个位置之前的Redo log日志不再需要，即可以循环覆盖使用。



        
按照MongoDB默认的配置，WiredTiger的写操作会先写入Cache（BTree结构），当Cache大小达到128KB时便将其持久化到 预写日志文件(Write ahead log) 。
	MongoDB配置WiredTiger使用内存缓冲区来存储Journal Records，所有没有达到128KB的Journal Records都会被缓存在缓冲区中，直到大小超过128KB。
	在执行写操作时，WiredTiger将Journal Records存储在缓冲区中，如果MongoDB异常关机，存储在内存中的Journal Records将丢失，这意味着，WiredTiger将丢失最大128KB的数据更新。

	

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


