

1. 查看副本集状态  --rs.status()
2. db.isMaster()
3. 查看oplog状态 --db.printReplicationInfo()
4. 查看复制延迟 --rs.printSlaveReplicationInfo()
5. 查看服务状态详情 --db.serverStatus() 


1. 查看副本集状态  --rs.status() 
	repl_set:PRIMARY> rs.status()
	{
		"set" : "repl_set",
		"date" : ISODate("2020-06-17T14:02:45.906Z"),
		"myState" : 1,
		"term" : NumberLong(107),
		"syncingTo" : "",   --
		"syncSourceHost" : "",
		"syncSourceId" : -1,
		"heartbeatIntervalMillis" : NumberLong(2000),
		"majorityVoteCount" : 2,
		"writeMajorityCount" : 2,
		"optimes" : {
			"lastCommittedOpTime" : {
				"ts" : Timestamp(1592402556, 1),
				"t" : NumberLong(107)
			},
			"lastCommittedWallTime" : ISODate("2020-06-17T14:02:36.840Z"),
			"readConcernMajorityOpTime" : {
				"ts" : Timestamp(1592402556, 1),
				"t" : NumberLong(107)
			},
			"readConcernMajorityWallTime" : ISODate("2020-06-17T14:02:36.840Z"),
			"appliedOpTime" : {
				"ts" : Timestamp(1592402556, 1),
				"t" : NumberLong(107)
			},
			"durableOpTime" : {
				"ts" : Timestamp(1592402556, 1),
				"t" : NumberLong(107)
			},
			"lastAppliedWallTime" : ISODate("2020-06-17T14:02:36.840Z"),
			"lastDurableWallTime" : ISODate("2020-06-17T14:02:36.840Z")
		},
		"lastStableRecoveryTimestamp" : Timestamp(1592402536, 1),
		"lastStableCheckpointTimestamp" : Timestamp(1592402536, 1),
		"electionCandidateMetrics" : {
			"lastElectionReason" : "electionTimeout",
			"lastElectionDate" : ISODate("2020-06-17T09:10:36.332Z"),
			"electionTerm" : NumberLong(107),
			"lastCommittedOpTimeAtElection" : {
				"ts" : Timestamp(1592385026, 238),
				"t" : NumberLong(105)
			},
			"lastSeenOpTimeAtElection" : {
				"ts" : Timestamp(1592385026, 238),
				"t" : NumberLong(105)
			},
			"numVotesNeeded" : 2,
			"priorityAtElection" : 1,
			"electionTimeoutMillis" : NumberLong(10000),
			"numCatchUpOps" : NumberLong(0),
			"newTermStartDate" : ISODate("2020-06-17T09:10:36.338Z"),
			"wMajorityWriteAvailabilityDate" : ISODate("2020-06-17T09:59:15.757Z")
		},
		"electionParticipantMetrics" : {
			"votedForCandidate" : true,
			"electionTerm" : NumberLong(105),
			"lastVoteDate" : ISODate("2020-06-17T09:08:23.782Z"),
			"electionCandidateMemberId" : 0,
			"voteReason" : "",
			"lastAppliedOpTimeAtElection" : {
				"ts" : Timestamp(1592384888, 1),
				"t" : NumberLong(103)
			},
			"maxAppliedOpTimeInSet" : {
				"ts" : Timestamp(1592384888, 1),
				"t" : NumberLong(103)
			},
			"priorityAtElection" : 1
		},
		"members" : [
			{
				"_id" : 0,
				"name" : "192.168.0.1:27017",
				"health" : 1,
				"state" : 2,
				"stateStr" : "SECONDARY",
				"uptime" : 14609,
				"optime" : {
					"ts" : Timestamp(1592402556, 1),
					"t" : NumberLong(107)
				},
				"optimeDurable" : {
					"ts" : Timestamp(1592402556, 1),
					"t" : NumberLong(107)
				},
				"optimeDate" : ISODate("2020-06-17T14:02:36Z"),
				"optimeDurableDate" : ISODate("2020-06-17T14:02:36Z"),
				"lastHeartbeat" : ISODate("2020-06-17T14:02:44.545Z"),
				"lastHeartbeatRecv" : ISODate("2020-06-17T14:02:44.355Z"),
				"pingMs" : NumberLong(0),
				"lastHeartbeatMessage" : "",
				"syncingTo" : "192.168.0.2:27017",
				"syncSourceHost" : "192.168.0.2:27017",
				"syncSourceId" : 1,
				"infoMessage" : "",
				"configVersion" : 4
			},
			{
				"_id" : 1,
				"name" : "192.168.0.2:27017",
				"health" : 1,
				"state" : 1,
				"stateStr" : "PRIMARY",
				"uptime" : 17671,
				"optime" : {
					"ts" : Timestamp(1592402556, 1),
					"t" : NumberLong(107)
				},
				"optimeDate" : ISODate("2020-06-17T14:02:36Z"),
				"syncingTo" : "",
				"syncSourceHost" : "",
				"syncSourceId" : -1,
				"infoMessage" : "",
				"electionTime" : Timestamp(1592385036, 1),
				"electionDate" : ISODate("2020-06-17T09:10:36Z"),
				"configVersion" : 4,
				"self" : true,
				"lastHeartbeatMessage" : ""
			},
			{
				"_id" : 3,
				"name" : "10.31.76.223:27017",
				"health" : 1,
				"state" : 7,
				"stateStr" : "ARBITER",
				"uptime" : 17670,
				"lastHeartbeat" : ISODate("2020-06-17T14:02:45.039Z"),
				"lastHeartbeatRecv" : ISODate("2020-06-17T14:02:44.983Z"),
				"pingMs" : NumberLong(0),
				"lastHeartbeatMessage" : "",
				"syncingTo" : "",
				"syncSourceHost" : "",
				"syncSourceId" : -1,
				"infoMessage" : "",
				"configVersion" : 4
			}
		],
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592402556, 1),
			"signature" : {
				"hash" : BinData(0,"SQxL53MBSZEZjJGWE6WwSHeWIPM="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592402556, 1)
	}

2. db.isMaster()
	repl_set:PRIMARY> db.isMaster()
	{
		"hosts" : [
			"192.168.0.1:27017",
			"192.168.0.2:27017"
		],
		"arbiters" : [
			"10.31.76.223:27017"
		],
		"setName" : "repl_set",
		"setVersion" : 4,
		"ismaster" : true,
		"secondary" : false,
		"primary" : "192.168.0.2:27017",
		"me" : "192.168.0.2:27017",
		"electionId" : ObjectId("7fffffff000000000000006b"),
		"lastWrite" : {
			"opTime" : {
				"ts" : Timestamp(1592402136, 1),
				"t" : NumberLong(107)
			},
			"lastWriteDate" : ISODate("2020-06-17T13:55:36Z"),
			"majorityOpTime" : {
				"ts" : Timestamp(1592402136, 1),
				"t" : NumberLong(107)
			},
			"majorityWriteDate" : ISODate("2020-06-17T13:55:36Z")
		},
		"maxBsonObjectSize" : 16777216,
		"maxMessageSizeBytes" : 48000000,
		"maxWriteBatchSize" : 100000,
		"localTime" : ISODate("2020-06-17T13:55:39.336Z"),
		"logicalSessionTimeoutMinutes" : 30,
		"connectionId" : 40,
		"minWireVersion" : 0,
		"maxWireVersion" : 8,
		"readOnly" : false,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592402136, 1),
			"signature" : {
				"hash" : BinData(0,"+z3/5An8lNwGkgUp6UIsHA7/cPc="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592402136, 1)
	}

	repl_set:SECONDARY> db.isMaster();
	{
		"hosts" : [
			"192.168.0.1:27017",
			"192.168.0.2:27017"
		],
		"arbiters" : [
			"10.31.76.223:27017"
		],
		"setName" : "repl_set",
		"setVersion" : 4,
		"ismaster" : false,
		"secondary" : true,
		"primary" : "192.168.0.2:27017",
		"me" : "192.168.0.1:27017",
		"lastWrite" : {
			"opTime" : {
				"ts" : Timestamp(1592402295, 1),
				"t" : NumberLong(107)
			},
			"lastWriteDate" : ISODate("2020-06-17T13:58:15Z"),
			"majorityOpTime" : {
				"ts" : Timestamp(1592402295, 1),
				"t" : NumberLong(107)
			},
			"majorityWriteDate" : ISODate("2020-06-17T13:58:15Z")
		},
		"maxBsonObjectSize" : 16777216,
		"maxMessageSizeBytes" : 48000000,
		"maxWriteBatchSize" : 100000,
		"localTime" : ISODate("2020-06-17T13:58:24.350Z"),
		"logicalSessionTimeoutMinutes" : 30,
		"connectionId" : 10,
		"minWireVersion" : 0,
		"maxWireVersion" : 8,
		"readOnly" : false,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592402295, 1),
			"signature" : {
				"hash" : BinData(0,"AyBBeD1CrFP3DoZoWEY3n/77f5Y="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1592402295, 1)
	}

3. 查看oplog状态 --db.printReplicationInfo()
	repl_set:PRIMARY> db.printReplicationInfo()
	configured oplog size:   1578.782958984375MB   -- 配置的oplog文件大小。 select 197*0.05 = 9.85GB.
	log length start to end: 101090secs (28.08hrs) -- oplog日志的启用时间段。
	oplog first event time:  Tue Jun 16 2020 17:54:46 GMT+0800 (CST) -- 第一个oplog日志的产生时间。
	oplog last event time:   Wed Jun 17 2020 21:59:36 GMT+0800 (CST) -- 最后一个oplog日志的产生时间。
	now:                     Wed Jun 17 2020 21:59:45 GMT+0800 (CST) -- 当前时间。


	repl_set:SECONDARY> db.printReplicationInfo()
	configured oplog size:   6312.335205078125MB
	log length start to end: 101090secs (28.08hrs)
	oplog first event time:  Tue Jun 16 2020 17:54:46 GMT+0800 (CST)
	oplog last event time:   Wed Jun 17 2020 21:59:36 GMT+0800 (CST)
	now:                     Wed Jun 17 2020 21:59:37 GMT+0800 (CST)
	
	--单机模式下查看  oplog 状态
	> db.printReplicationInfo()
	{ "errmsg" : "replication not detected" }   --未检测到复制


4. 查看复制延迟 --rs.printSlaveReplicationInfo()

	repl_set:PRIMARY> rs.printSlaveReplicationInfo()
	source: 192.168.0.1:27017
		syncedTo: Wed Jun 17 2020 22:00:56 GMT+0800 (CST)
		0 secs (0 hrs) behind the primary 

		
	repl_set:SECONDARY> rs.printSlaveReplicationInfo()
	source: 192.168.0.1:27017
		syncedTo: Wed Jun 17 2020 22:00:46 GMT+0800 (CST)
		0 secs (0 hrs) behind the primary 
		
5. 查看服务状态详情 --db.serverStatus() 
	.................
	"connections" : {
		"current" : 14,
		"available" : 805,
		"totalCreated" : 120,
		"active" : 2
	},
	"electionMetrics" : {
		"stepUpCmd" : {
			"called" : NumberLong(1),
			"successful" : NumberLong(0)
		},
		"priorityTakeover" : {
			"called" : NumberLong(0),
			"successful" : NumberLong(0)
		},
		"catchUpTakeover" : {
			"called" : NumberLong(0),
			"successful" : NumberLong(0)
		},
		"electionTimeout" : {
			"called" : NumberLong(1),
			"successful" : NumberLong(1)
		},
		"freezeTimeout" : {
			"called" : NumberLong(0),
			"successful" : NumberLong(0)
		},
		"numStepDownsCausedByHigherTerm" : NumberLong(0),
		"numCatchUps" : NumberLong(0),
		"numCatchUpsSucceeded" : NumberLong(0),
		"numCatchUpsAlreadyCaughtUp" : NumberLong(1),
		"numCatchUpsSkipped" : NumberLong(0),
		"numCatchUpsTimedOut" : NumberLong(0),
		"numCatchUpsFailedWithError" : NumberLong(0),
		"numCatchUpsFailedWithNewTerm" : NumberLong(0),
		"numCatchUpsFailedWithReplSetAbortPrimaryCatchUpCmd" : NumberLong(0),
		"averageCatchUpOps" : 0
	},
	"extra_info" : {
		"note" : "fields vary by platform",
		"user_time_us" : NumberLong(118079275),
		"system_time_us" : NumberLong(24117959),
		"maximum_resident_set_kb" : NumberLong(167428),
		"input_blocks" : NumberLong(0),
		"output_blocks" : NumberLong(318944),
		"page_reclaims" : NumberLong(68324),
		"page_faults" : NumberLong(0),
		"voluntary_context_switches" : NumberLong(1329399),
		"involuntary_context_switches" : NumberLong(8551)
	},
	"flowControl" : {
		"enabled" : true,
		"targetRateLimit" : 1000000000,
		"timeAcquiringMicros" : NumberLong(14473157),
		"locksPerOp" : 1.17,
		"sustainerRate" : 0,
		"isLagged" : false,
		"isLaggedCount" : 1,
		"isLaggedTimeMicros" : NumberLong("2917999900")
	},
	"freeMonitoring" : {
		"state" : "undecided"
	},
	"globalLock" : {
		"totalTime" : NumberLong("18605979000"),
		"currentQueue" : {
			"total" : 0,
			"readers" : 0,
			"writers" : 0
		},
		"activeClients" : {
			"total" : 0,
			"readers" : 0,
			"writers" : 0
		}
	},
	"locks" : {
		"ParallelBatchWriterMode" : {
			"acquireCount" : {
				"r" : NumberLong(48295),
				"W" : NumberLong(6415)
			},
			"acquireWaitCount" : {
				"r" : NumberLong(1)
			},
			"timeAcquiringMicros" : {
				"r" : NumberLong(3702)
			}
		},
		"ReplicationStateTransition" : {
			"acquireCount" : {
				"w" : NumberLong(254195),
				"W" : NumberLong(2)
			},
			"acquireWaitCount" : {
				"w" : NumberLong(2),
				"W" : NumberLong(1)
			},
			"timeAcquiringMicros" : {
				"w" : NumberLong(491),
				"W" : NumberLong(2)
			}
		},
		"Global" : {
			"acquireCount" : {
				"r" : NumberLong(173214),
				"w" : NumberLong(77210),
				"W" : NumberLong(3)
			}
		},
		"Database" : {
			"acquireCount" : {
				"r" : NumberLong(135963),
				"w" : NumberLong(75350),
				"W" : NumberLong(11)
			}
		},
		"Collection" : {
			"acquireCount" : {
				"r" : NumberLong(32719),
				"w" : NumberLong(68924),
				"W" : NumberLong(3)
			}
		},
		"Mutex" : {
			"acquireCount" : {
				"r" : NumberLong(241070)
			}
		},
		"oplog" : {
			"acquireCount" : {
				"r" : NumberLong(90470),
				"w" : NumberLong(6416)
			}
		}
	},
	"logicalSessionRecordCache" : {
		"activeSessionsCount" : 1,
		"sessionsCollectionJobCount" : 63,
		"lastSessionsCollectionJobDurationMillis" : 4,
		"lastSessionsCollectionJobTimestamp" : ISODate("2020-06-17T14:18:15.739Z"),
		"lastSessionsCollectionJobEntriesRefreshed" : 1,
		"lastSessionsCollectionJobEntriesEnded" : 0,
		"lastSessionsCollectionJobCursorsClosed" : 0,
		"transactionReaperJobCount" : 63,
		"lastTransactionReaperJobDurationMillis" : 0,
		"lastTransactionReaperJobTimestamp" : ISODate("2020-06-17T14:18:15.739Z"),
		"lastTransactionReaperJobEntriesCleanedUp" : 0,
		"sessionCatalogSize" : 0
	},
	"network" : {
		"bytesIn" : NumberLong(12196796),
		"bytesOut" : NumberLong(24314417),
		"physicalBytesIn" : NumberLong(9871784),
		"physicalBytesOut" : NumberLong(17846881),
		"numRequests" : NumberLong(36946),
		"compression" : {
			"snappy" : {
				"compressor" : {
					"bytesIn" : NumberLong(37071549),
					"bytesOut" : NumberLong(24382867)
				},
				"decompressor" : {
					"bytesIn" : NumberLong(23361713),
					"bytesOut" : NumberLong(39147589)
				}
			},
			"zstd" : {
				"compressor" : {
					"bytesIn" : NumberLong(0),
					"bytesOut" : NumberLong(0)
				},
				"decompressor" : {
					"bytesIn" : NumberLong(0),
					"bytesOut" : NumberLong(0)
				}
			},
			"zlib" : {
				"compressor" : {
					"bytesIn" : NumberLong(0),
					"bytesOut" : NumberLong(0)
				},
				"decompressor" : {
					"bytesIn" : NumberLong(0),
					"bytesOut" : NumberLong(0)
				}
			}
		},
		"serviceExecutorTaskStats" : {
			"executor" : "passthrough",
			"threadsRunning" : 14
		}
	},
	"opLatencies" : {
		"reads" : {
			"latency" : NumberLong(1272754),
			"ops" : NumberLong(5137)
		},
		"writes" : {
			"latency" : NumberLong(14884845),
			"ops" : NumberLong(3771)
		},
		"commands" : {
			"latency" : NumberLong(2186862),
			"ops" : NumberLong(28036)
		},
		"transactions" : {
			"latency" : NumberLong(0),
			"ops" : NumberLong(0)
		}
	},
	"opReadConcernCounters" : {
		"available" : NumberLong(0),
		"linearizable" : NumberLong(0),
		"local" : NumberLong(0),
		"majority" : NumberLong(0),
		"snapshot" : NumberLong(0),
		"none" : NumberLong(127)
	},
	"opcounters" : {
		"insert" : NumberLong(3768),
		"query" : NumberLong(127),
		"update" : NumberLong(52),
		"delete" : NumberLong(13),
		"getmore" : NumberLong(5081),
		"command" : NumberLong(28165)
	},
	"opcountersRepl" : {
		"insert" : NumberLong(30139),
		"query" : NumberLong(0),
		"update" : NumberLong(6404),
		"delete" : NumberLong(3),
		"getmore" : NumberLong(0),
		"command" : NumberLong(2)
	},
	"oplogTruncation" : {
		"totalTimeProcessingMicros" : NumberLong(4837),
		"processingMethod" : "sampling",
		"totalTimeTruncatingMicros" : NumberLong(0),
		"truncateCount" : NumberLong(0)
	},
	"repl" : {
		"hosts" : [
			"192.168.0.1:27017",
			"192.168.0.2:27017"
		],
		"arbiters" : [
			"10.31.76.223:27017"
		],
		"setName" : "repl_set",
		"setVersion" : 4,
		"ismaster" : true,
		"secondary" : false,
		"primary" : "192.168.0.2:27017",
		"me" : "192.168.0.2:27017",
		"electionId" : ObjectId("7fffffff000000000000006b"),
		"lastWrite" : {
			"opTime" : {
				"ts" : Timestamp(1592403495, 1),
				"t" : NumberLong(107)
			},
			"lastWriteDate" : ISODate("2020-06-17T14:18:15Z"),
			"majorityOpTime" : {
				"ts" : Timestamp(1592403495, 1),
				"t" : NumberLong(107)
			},
			"majorityWriteDate" : ISODate("2020-06-17T14:18:15Z")
		},
		"rbid" : 1
	},
	"storageEngine" : {
		"name" : "wiredTiger",
		"supportsCommittedReads" : true,
		"oldestRequiredTimestampForCrashRecovery" : Timestamp(1592403436, 1),
		"supportsPendingDrops" : true,
		"dropPendingIdents" : NumberLong(0),
		"supportsSnapshotReadConcern" : true,
		"readOnly" : false,
		"persistent" : true,
		"backupCursorOpen" : false
	},
	"tcmalloc" : {
		"generic" : {
			"current_allocated_bytes" : 162287720,
			"heap_size" : 181092352
		},
		"tcmalloc" : {
			"pageheap_free_bytes" : 5685248,
			"pageheap_unmapped_bytes" : 2056192,
			"max_total_thread_cache_bytes" : NumberLong(1073741824),
			"current_total_thread_cache_bytes" : 7046640,
			"total_free_bytes" : 11063192,
			"central_cache_free_bytes" : 1302696,
			"transfer_cache_free_bytes" : 2713856,
			"thread_cache_free_bytes" : 7046640,
			"aggressive_memory_decommit" : 0,
			"pageheap_committed_bytes" : 179036160,
			"pageheap_scavenge_count" : 718,
			"pageheap_commit_count" : 2428,
			"pageheap_total_commit_bytes" : 507809792,
			"pageheap_decommit_count" : 718,
			"pageheap_total_decommit_bytes" : 328773632,
			"pageheap_reserve_count" : 83,
			"pageheap_total_reserve_bytes" : 181092352,
			"spinlock_total_delay_ns" : 133840,
			"release_rate" : 1,
			"formattedString" : "------------------------------------------------\nMALLOC:      162288296 (  154.8 MiB) Bytes in use by application\nMALLOC: +      5685248 (    5.4 MiB) Bytes in page heap freelist\nMALLOC: +      1302696 (    1.2 MiB) Bytes in central cache freelist\nMALLOC: +      2713856 (    2.6 MiB) Bytes in transfer cache freelist\nMALLOC: +      7046064 (    6.7 MiB) Bytes in thread cache freelists\nMALLOC: +      5111808 (    4.9 MiB) Bytes in malloc metadata\nMALLOC:   ------------\nMALLOC: =    184147968 (  175.6 MiB) Actual memory used (physical + swap)\nMALLOC: +      2056192 (    2.0 MiB) Bytes released to OS (aka unmapped)\nMALLOC:   ------------\nMALLOC: =    186204160 (  177.6 MiB) Virtual address space used\nMALLOC:\nMALLOC:           4912              Spans in use\nMALLOC:             76              Thread heaps in use\nMALLOC:           4096              Tcmalloc page size\n------------------------------------------------\nCall ReleaseFreeMemory() to release freelist memory to the OS (via madvise()).\nBytes released to the OS take up virtual address space but no physical memory.\n"
		}
	},
	"trafficRecording" : {
		"running" : false
	},
	"transactions" : {
		"retriedCommandsCount" : NumberLong(0),
		"retriedStatementsCount" : NumberLong(0),
		"transactionsCollectionWriteCount" : NumberLong(3768),
		"currentActive" : NumberLong(0),
		"currentInactive" : NumberLong(0),
		"currentOpen" : NumberLong(0),
		"totalAborted" : NumberLong(0),
		"totalCommitted" : NumberLong(0),
		"totalStarted" : NumberLong(0),
		"totalPrepared" : NumberLong(0),
		"totalPreparedThenCommitted" : NumberLong(0),
		"totalPreparedThenAborted" : NumberLong(0),
		"currentPrepared" : NumberLong(0)
	},
	"transportSecurity" : {
		"1.0" : NumberLong(0),
		"1.1" : NumberLong(0),
		"1.2" : NumberLong(0),
		"1.3" : NumberLong(0),
		"unknown" : NumberLong(0)
	},
	"twoPhaseCommitCoordinator" : {
		"totalCreated" : NumberLong(0),
		"totalStartedTwoPhaseCommit" : NumberLong(0),
		"totalAbortedTwoPhaseCommit" : NumberLong(0),
		"totalCommittedTwoPhaseCommit" : NumberLong(0),
		"currentInSteps" : {
			"writingParticipantList" : NumberLong(0),
			"waitingForVotes" : NumberLong(0),
			"writingDecision" : NumberLong(0),
			"waitingForDecisionAcks" : NumberLong(0),
			"deletingCoordinatorDoc" : NumberLong(0)
		}
	},
	"wiredTiger" : {
		"uri" : "statistics:",
		"async" : {
			"current work queue length" : 0,
			"maximum work queue length" : 0,
			"number of allocation state races" : 0,
			"number of flush calls" : 0,
			"number of operation slots viewed for allocation" : 0,
			"number of times operation allocation failed" : 0,
			"number of times worker found no work" : 0,
			"total allocations" : 0,
			"total compact calls" : 0,
			"total insert calls" : 0,
			"total remove calls" : 0,
			"total search calls" : 0,
			"total update calls" : 0
		},
		"block-manager" : {
			"blocks pre-loaded" : 33,
			"blocks read" : 1466,
			"blocks written" : 6949,
			"bytes read" : 6733824,
			"bytes written" : 71516160,
			"bytes written for checkpoint" : 71516160,
			"mapped blocks read" : 0,
			"mapped bytes read" : 0
		},
		"cache" : {
			"application threads page read from disk to cache count" : 80,
			"application threads page read from disk to cache time (usecs)" : 2408,
			"application threads page write from cache to disk count" : 4271,
			"application threads page write from cache to disk time (usecs)" : 197674,
			"bytes belonging to page images in the cache" : 483959,
			"bytes belonging to the cache overflow table in the cache" : 182,
			"bytes currently in the cache" : 23888765,
			"bytes dirty in the cache cumulative" : 7799290,
			"bytes not belonging to page images in the cache" : 23404805,
			"bytes read into cache" : 6383908,
			"bytes written from cache" : 135146947,
			"cache overflow cursor application thread wait time (usecs)" : 0,
			"cache overflow cursor internal thread wait time (usecs)" : 0,
			"cache overflow score" : 0,
			"cache overflow table entries" : 0,
			"cache overflow table insert calls" : 0,
			"cache overflow table max on-disk size" : 0,
			"cache overflow table on-disk size" : 0,
			"cache overflow table remove calls" : 0,
			"checkpoint blocked page eviction" : 0,
			"eviction calls to get a page" : 421,
			"eviction calls to get a page found queue empty" : 413,
			"eviction calls to get a page found queue empty after locking" : 0,
			"eviction currently operating in aggressive mode" : 0,
			"eviction empty score" : 0,
			"eviction passes of a file" : 0,
			"eviction server candidate queue empty when topping up" : 0,
			"eviction server candidate queue not empty when topping up" : 0,
			"eviction server evicting pages" : 0,
			"eviction server slept, because we did not make progress with eviction" : 757,
			"eviction server unable to reach eviction goal" : 0,
			"eviction server waiting for a leaf page" : 157254,
			"eviction state" : 128,
			"eviction walk target pages histogram - 0-9" : 0,
			"eviction walk target pages histogram - 10-31" : 0,
			"eviction walk target pages histogram - 128 and higher" : 0,
			"eviction walk target pages histogram - 32-63" : 0,
			"eviction walk target pages histogram - 64-128" : 0,
			"eviction walk target strategy both clean and dirty pages" : 0,
			"eviction walk target strategy only clean pages" : 0,
			"eviction walk target strategy only dirty pages" : 0,
			"eviction walks abandoned" : 0,
			"eviction walks gave up because they restarted their walk twice" : 0,
			"eviction walks gave up because they saw too many pages and found no candidates" : 0,
			"eviction walks gave up because they saw too many pages and found too few candidates" : 0,
			"eviction walks reached end of tree" : 0,
			"eviction walks started from root of tree" : 0,
			"eviction walks started from saved location in tree" : 0,
			"eviction worker thread active" : 4,
			"eviction worker thread created" : 0,
			"eviction worker thread evicting pages" : 7,
			"eviction worker thread removed" : 0,
			"eviction worker thread stable number" : 0,
			"files with active eviction walks" : 0,
			"files with new eviction walks started" : 0,
			"force re-tuning of eviction workers once in a while" : 0,
			"forced eviction - pages evicted that were clean count" : 50,
			"forced eviction - pages evicted that were clean time (usecs)" : 40,
			"forced eviction - pages evicted that were dirty count" : 1,
			"forced eviction - pages evicted that were dirty time (usecs)" : 38,
			"forced eviction - pages selected because of too many deleted items count" : 5,
			"forced eviction - pages selected count" : 64,
			"forced eviction - pages selected unable to be evicted count" : 12,
			"forced eviction - pages selected unable to be evicted time" : 3,
			"hazard pointer blocked page eviction" : 1,
			"hazard pointer check calls" : 71,
			"hazard pointer check entries walked" : 181,
			"hazard pointer maximum array length" : 1,
			"in-memory page passed criteria to be split" : 2,
			"in-memory page splits" : 1,
			"internal pages evicted" : 2,
			"internal pages queued for eviction" : 0,
			"internal pages seen by eviction walk" : 0,
			"internal pages seen by eviction walk that are already queued" : 0,
			"internal pages split during eviction" : 0,
			"leaf pages split during eviction" : 0,
			"maximum bytes configured" : 4294967296,
			"maximum page size at eviction" : 0,
			"modified pages evicted" : 5,
			"modified pages evicted by application threads" : 0,
			"operations timed out waiting for space in cache" : 0,
			"overflow pages read into cache" : 0,
			"page split during eviction deepened the tree" : 0,
			"page written requiring cache overflow records" : 0,
			"pages currently held in the cache" : 62,
			"pages evicted by application threads" : 0,
			"pages queued for eviction" : 0,
			"pages queued for eviction post lru sorting" : 0,
			"pages queued for urgent eviction" : 8,
			"pages queued for urgent eviction during walk" : 0,
			"pages read into cache" : 109,
			"pages read into cache after truncate" : 4,
			"pages read into cache after truncate in prepare state" : 0,
			"pages read into cache requiring cache overflow entries" : 0,
			"pages read into cache requiring cache overflow for checkpoint" : 0,
			"pages read into cache skipping older cache overflow entries" : 0,
			"pages read into cache with skipped cache overflow entries needed later" : 0,
			"pages read into cache with skipped cache overflow entries needed later by checkpoint" : 0,
			"pages requested from the cache" : 438314,
			"pages seen by eviction walk" : 0,
			"pages seen by eviction walk that are already queued" : 0,
			"pages selected for eviction unable to be evicted" : 13,
			"pages selected for eviction unable to be evicted as the parent page has overflow items" : 0,
			"pages selected for eviction unable to be evicted because of active children on an internal page" : 12,
			"pages selected for eviction unable to be evicted because of failure in reconciliation" : 0,
			"pages selected for eviction unable to be evicted due to newer modifications on a clean page" : 0,
			"pages walked for eviction" : 0,
			"pages written from cache" : 4275,
			"pages written requiring in-memory restoration" : 2,
			"percentage overhead" : 8,
			"tracked bytes belonging to internal pages in the cache" : 54826,
			"tracked bytes belonging to leaf pages in the cache" : 23833939,
			"tracked dirty bytes in the cache" : 5642154,
			"tracked dirty pages in the cache" : 6,
			"unmodified pages evicted" : 52
		},
		"capacity" : {
			"background fsync file handles considered" : 0,
			"background fsync file handles synced" : 0,
			"background fsync time (msecs)" : 0,
			"bytes read" : 1175552,
			"bytes written for checkpoint" : 50234416,
			"bytes written for eviction" : 0,
			"bytes written for log" : 819103872,
			"bytes written total" : 869338288,
			"threshold to call fsync" : 0,
			"time waiting due to total capacity (usecs)" : 0,
			"time waiting during checkpoint (usecs)" : 0,
			"time waiting during eviction (usecs)" : 0,
			"time waiting during logging (usecs)" : 0,
			"time waiting during read (usecs)" : 0
		},
		"connection" : {
			"auto adjusting condition resets" : 4043,
			"auto adjusting condition wait calls" : 118371,
			"detected system time went backwards" : 0,
			"files currently open" : 31,
			"memory allocations" : 2359585,
			"memory frees" : 2152581,
			"memory re-allocations" : 314937,
			"pthread mutex condition wait calls" : 314752,
			"pthread mutex shared lock read-lock calls" : 756810,
			"pthread mutex shared lock write-lock calls" : 123419,
			"total fsync I/Os" : 10929,
			"total read I/Os" : 2622,
			"total write I/Os" : 16254
		},
		"cursor" : {
			"cached cursor count" : 41,
			"cursor bulk loaded cursor insert calls" : 0,
			"cursor close calls that result in cache" : 185049,
			"cursor create calls" : 56259,
			"cursor insert calls" : 109615,
			"cursor insert key and value bytes" : 16095678,
			"cursor modify calls" : 25660,
			"cursor modify key and value bytes affected" : 1937330,
			"cursor modify value bytes modified" : 333588,
			"cursor next calls" : 873561,
			"cursor operation restarted" : 10160,
			"cursor prev calls" : 39273,
			"cursor remove calls" : 96,
			"cursor remove key bytes removed" : 2002,
			"cursor reserve calls" : 0,
			"cursor reset calls" : 561420,
			"cursor search calls" : 197483,
			"cursor search near calls" : 42825,
			"cursor sweep buckets" : 18018,
			"cursor sweep cursors closed" : 0,
			"cursor sweep cursors examined" : 362,
			"cursor sweeps" : 3003,
			"cursor truncate calls" : 0,
			"cursor update calls" : 0,
			"cursor update key and value bytes" : 0,
			"cursor update value size change" : 0,
			"cursors reused from cache" : 178959,
			"open cursor count" : 26
		},
		"data-handle" : {
			"connection data handle size" : 432,
			"connection data handles currently active" : 55,
			"connection sweep candidate became referenced" : 0,
			"connection sweep dhandles closed" : 0,
			"connection sweep dhandles removed from hash list" : 1034,
			"connection sweep time-of-death sets" : 4059,
			"connection sweeps" : 1862,
			"session dhandles swept" : 0,
			"session sweep attempts" : 429
		},
		"lock" : {
			"checkpoint lock acquisitions" : 310,
			"checkpoint lock application thread wait time (usecs)" : 12,
			"checkpoint lock internal thread wait time (usecs)" : 0,
			"dhandle lock application thread time waiting (usecs)" : 5,
			"dhandle lock internal thread time waiting (usecs)" : 0,
			"dhandle read lock acquisitions" : 79486,
			"dhandle write lock acquisitions" : 2124,
			"durable timestamp queue lock application thread time waiting (usecs)" : 549,
			"durable timestamp queue lock internal thread time waiting (usecs)" : 0,
			"durable timestamp queue read lock acquisitions" : 0,
			"durable timestamp queue write lock acquisitions" : 58084,
			"metadata lock acquisitions" : 310,
			"metadata lock application thread wait time (usecs)" : 0,
			"metadata lock internal thread wait time (usecs)" : 0,
			"read timestamp queue lock application thread time waiting (usecs)" : 0,
			"read timestamp queue lock internal thread time waiting (usecs)" : 0,
			"read timestamp queue read lock acquisitions" : 0,
			"read timestamp queue write lock acquisitions" : 311,
			"schema lock acquisitions" : 370,
			"schema lock application thread wait time (usecs)" : 3726,
			"schema lock internal thread wait time (usecs)" : 0,
			"table lock application thread time waiting for the table lock (usecs)" : 66,
			"table lock internal thread time waiting for the table lock (usecs)" : 0,
			"table read lock acquisitions" : 0,
			"table write lock acquisitions" : 18647,
			"txn global lock application thread time waiting (usecs)" : 0,
			"txn global lock internal thread time waiting (usecs)" : 55,
			"txn global read lock acquisitions" : 6851,
			"txn global write lock acquisitions" : 25280
		},
		"log" : {
			"busy returns attempting to switch slots" : 0,
			"force archive time sleeping (usecs)" : 0,
			"log bytes of payload data" : 6055978,
			"log bytes written" : 7641216,
			"log files manually zero-filled" : 0,
			"log flush operations" : 194103,
			"log force write operations" : 214383,
			"log force write operations skipped" : 205712,
			"log records compressed" : 5880,
			"log records not compressed" : 6532,
			"log records too small to compress" : 13753,
			"log release advances write LSN" : 317,
			"log scan operations" : 4,
			"log scan records requiring two reads" : 3,
			"log server thread advances write LSN" : 8671,
			"log server thread write LSN walk skipped" : 19140,
			"log sync operations" : 8955,
			"log sync time duration (usecs)" : 10622323,
			"log sync_dir operations" : 1,
			"log sync_dir time duration (usecs)" : 1354,
			"log write operations" : 26166,
			"logging bytes consolidated" : 7640704,
			"maximum log file size" : 104857600,
			"number of pre-allocated log files to create" : 2,
			"pre-allocated log files not ready and missed" : 1,
			"pre-allocated log files prepared" : 2,
			"pre-allocated log files used" : 0,
			"records processed by log scan" : 14,
			"slot close lost race" : 0,
			"slot close unbuffered waits" : 0,
			"slot closures" : 8988,
			"slot join atomic update races" : 1,
			"slot join calls atomic updates raced" : 1,
			"slot join calls did not yield" : 26165,
			"slot join calls found active slot closed" : 0,
			"slot join calls slept" : 0,
			"slot join calls yielded" : 1,
			"slot join found active slot closed" : 0,
			"slot joins yield time (usecs)" : 2,
			"slot transitions unable to find free slot" : 0,
			"slot unbuffered writes" : 0,
			"total in-memory size of compressed records" : 10869937,
			"total log buffer size" : 33554432,
			"total size of compressed records" : 3263829,
			"written slots coalesced" : 0,
			"yields waiting for previous log file close" : 0
		},
		"perf" : {
			"file system read latency histogram (bucket 1) - 10-49ms" : 0,
			"file system read latency histogram (bucket 2) - 50-99ms" : 0,
			"file system read latency histogram (bucket 3) - 100-249ms" : 0,
			"file system read latency histogram (bucket 4) - 250-499ms" : 0,
			"file system read latency histogram (bucket 5) - 500-999ms" : 0,
			"file system read latency histogram (bucket 6) - 1000ms+" : 0,
			"file system write latency histogram (bucket 1) - 10-49ms" : 0,
			"file system write latency histogram (bucket 2) - 50-99ms" : 0,
			"file system write latency histogram (bucket 3) - 100-249ms" : 0,
			"file system write latency histogram (bucket 4) - 250-499ms" : 0,
			"file system write latency histogram (bucket 5) - 500-999ms" : 0,
			"file system write latency histogram (bucket 6) - 1000ms+" : 0,
			"operation read latency histogram (bucket 1) - 100-249us" : 0,
			"operation read latency histogram (bucket 2) - 250-499us" : 0,
			"operation read latency histogram (bucket 3) - 500-999us" : 0,
			"operation read latency histogram (bucket 4) - 1000-9999us" : 0,
			"operation read latency histogram (bucket 5) - 10000us+" : 0,
			"operation write latency histogram (bucket 1) - 100-249us" : 109,
			"operation write latency histogram (bucket 2) - 250-499us" : 35,
			"operation write latency histogram (bucket 3) - 500-999us" : 1,
			"operation write latency histogram (bucket 4) - 1000-9999us" : 8,
			"operation write latency histogram (bucket 5) - 10000us+" : 1
		},
		"reconciliation" : {
			"fast-path pages deleted" : 0,
			"page reconciliation calls" : 3434,
			"page reconciliation calls for eviction" : 4,
			"pages deleted" : 20,
			"split bytes currently awaiting free" : 0,
			"split objects currently awaiting free" : 0
		},
		"session" : {
			"open session count" : 21,
			"session query timestamp calls" : 0,
			"table alter failed calls" : 0,
			"table alter successful calls" : 0,
			"table alter unchanged and skipped" : 0,
			"table compact failed calls" : 0,
			"table compact successful calls" : 0,
			"table create failed calls" : 0,
			"table create successful calls" : 3,
			"table drop failed calls" : 0,
			"table drop successful calls" : 2,
			"table import failed calls" : 0,
			"table import successful calls" : 0,
			"table rebalance failed calls" : 0,
			"table rebalance successful calls" : 0,
			"table rename failed calls" : 0,
			"table rename successful calls" : 0,
			"table salvage failed calls" : 0,
			"table salvage successful calls" : 0,
			"table truncate failed calls" : 0,
			"table truncate successful calls" : 0,
			"table verify failed calls" : 0,
			"table verify successful calls" : 0
		},
		"thread-state" : {
			"active filesystem fsync calls" : 0,
			"active filesystem read calls" : 0,
			"active filesystem write calls" : 0
		},
		"thread-yield" : {
			"application thread time evicting (usecs)" : 0,
			"application thread time waiting for cache (usecs)" : 0,
			"connection close blocked waiting for transaction state stabilization" : 0,
			"connection close yielded for lsm manager shutdown" : 0,
			"data handle lock yielded" : 52,
			"get reference for page index and slot time sleeping (usecs)" : 0,
			"log server sync yielded for log write" : 0,
			"page access yielded due to prepare state change" : 0,
			"page acquire busy blocked" : 0,
			"page acquire eviction blocked" : 0,
			"page acquire locked blocked" : 0,
			"page acquire read blocked" : 0,
			"page acquire time sleeping (usecs)" : 0,
			"page delete rollback time sleeping for state change (usecs)" : 0,
			"page reconciliation yielded due to child modification" : 0
		},
		"transaction" : {
			"Number of prepared updates" : 0,
			"Number of prepared updates added to cache overflow" : 0,
			"durable timestamp queue entries walked" : 82990,
			"durable timestamp queue insert to empty" : 5628,
			"durable timestamp queue inserts to head" : 43136,
			"durable timestamp queue inserts total" : 60253,
			"durable timestamp queue length" : 1,
			"number of named snapshots created" : 0,
			"number of named snapshots dropped" : 0,
			"prepared transactions" : 0,
			"prepared transactions committed" : 0,
			"prepared transactions currently active" : 0,
			"prepared transactions rolled back" : 0,
			"query timestamp calls" : 59634,
			"read timestamp queue entries walked" : 174,
			"read timestamp queue insert to empty" : 137,
			"read timestamp queue inserts to head" : 174,
			"read timestamp queue inserts total" : 311,
			"read timestamp queue length" : 1,
			"rollback to stable calls" : 0,
			"rollback to stable updates aborted" : 0,
			"rollback to stable updates removed from cache overflow" : 0,
			"set timestamp calls" : 14296,
			"set timestamp durable calls" : 0,
			"set timestamp durable updates" : 0,
			"set timestamp oldest calls" : 7133,
			"set timestamp oldest updates" : 7133,
			"set timestamp stable calls" : 7163,
			"set timestamp stable updates" : 7133,
			"transaction begins" : 160060,
			"transaction checkpoint currently running" : 0,
			"transaction checkpoint generation" : 311,
			"transaction checkpoint max time (msecs)" : 217,
			"transaction checkpoint min time (msecs)" : 7,
			"transaction checkpoint most recent time (msecs)" : 56,
			"transaction checkpoint scrub dirty target" : 0,
			"transaction checkpoint scrub time (msecs)" : 0,
			"transaction checkpoint total time (msecs)" : 9913,
			"transaction checkpoints" : 310,
			"transaction checkpoints skipped because database was clean" : 0,
			"transaction failures due to cache overflow" : 0,
			"transaction fsync calls for checkpoint after allocating the transaction ID" : 310,
			"transaction fsync duration for checkpoint after allocating the transaction ID (usecs)" : 2214,
			"transaction range of IDs currently pinned" : 0,
			"transaction range of IDs currently pinned by a checkpoint" : 0,
			"transaction range of IDs currently pinned by named snapshots" : 0,
			"transaction range of timestamps currently pinned" : 21474836480,
			"transaction range of timestamps pinned by a checkpoint" : NumberLong("6839320933061099521"),
			"transaction range of timestamps pinned by the oldest active read timestamp" : 0,
			"transaction range of timestamps pinned by the oldest timestamp" : 21474836480,
			"transaction read timestamp of the oldest active reader" : 0,
			"transaction sync calls" : 0,
			"transactions committed" : 69691,
			"transactions rolled back" : 91890,
			"update conflicts" : 0
		},
		"concurrentTransactions" : {
			"write" : {
				"out" : 0,
				"available" : 128,
				"totalTickets" : 128
			},
			"read" : {
				"out" : 1,
				"available" : 127,
				"totalTickets" : 128
			}
		},
		"snapshot-window-settings" : {
			"cache pressure percentage threshold" : 95,
			"current cache pressure percentage" : NumberLong(0),
			"total number of SnapshotTooOld errors" : NumberLong(0),
			"max target available snapshots window size in seconds" : 5,
			"target available snapshots window size in seconds" : 5,
			"current available snapshots window size in seconds" : 5,
			"latest majority snapshot timestamp available" : "Jun 17 22:18:15:1",
			"oldest majority snapshot timestamp available" : "Jun 17 22:18:10:1"
		},
		"oplog" : {
			"visibility timestamp" : Timestamp(1592403495, 1)
		}
	},
	"mem" : {
		"bits" : 64,
		"resident" : 159,
		"virtual" : 1894,
		"supported" : true
	},
	"metrics" : {
		"aggStageCounters" : {
			"$_internalInhibitOptimization" : NumberLong(0),
			"$_internalSplitPipeline" : NumberLong(0),
			"$addFields" : NumberLong(0),
			"$bucket" : NumberLong(0),
			"$bucketAuto" : NumberLong(0),
			"$changeStream" : NumberLong(0),
			"$collStats" : NumberLong(0),
			"$count" : NumberLong(0),
			"$currentOp" : NumberLong(0),
			"$facet" : NumberLong(0),
			"$geoNear" : NumberLong(0),
			"$graphLookup" : NumberLong(0),
			"$group" : NumberLong(2),
			"$indexStats" : NumberLong(0),
			"$limit" : NumberLong(0),
			"$listLocalSessions" : NumberLong(0),
			"$listSessions" : NumberLong(0),
			"$lookup" : NumberLong(0),
			"$match" : NumberLong(0),
			"$merge" : NumberLong(0),
			"$mergeCursors" : NumberLong(0),
			"$out" : NumberLong(0),
			"$planCacheStats" : NumberLong(0),
			"$project" : NumberLong(0),
			"$redact" : NumberLong(0),
			"$replaceRoot" : NumberLong(0),
			"$replaceWith" : NumberLong(0),
			"$sample" : NumberLong(0),
			"$set" : NumberLong(0),
			"$skip" : NumberLong(0),
			"$sort" : NumberLong(0),
			"$sortByCount" : NumberLong(0),
			"$unset" : NumberLong(0),
			"$unwind" : NumberLong(0)
		},
		"commands" : {
			"_isSelf" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(1)
			},
			"aggregate" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(2)
			},
			"buildInfo" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(8)
			},
			"collStats" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(6)
			},
			"count" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(1)
			},
			"delete" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(6)
			},
			"endSessions" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(4)
			},
			"find" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(127)
			},
			"getCmdLineOpts" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(1)
			},
			"getFreeMonitoringStatus" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(1)
			},
			"getLog" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(1)
			},
			"getMore" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(5081)
			},
			"insert" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(3768)
			},
			"isMaster" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(4820)
			},
			"listCollections" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(8)
			},
			"listDatabases" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(3)
			},
			"listIndexes" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(125)
			},
			"ping" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(56)
			},
			"replSetGetRBID" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(1)
			},
			"replSetGetStatus" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(40)
			},
			"replSetHeartbeat" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(17155)
			},
			"replSetRequestVotes" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(2)
			},
			"replSetStepUp" : {
				"failed" : NumberLong(1),
				"total" : NumberLong(1)
			},
			"replSetUpdatePosition" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(4828)
			},
			"saslContinue" : {
				"failed" : NumberLong(2),
				"total" : NumberLong(728)
			},
			"saslStart" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(365)
			},
			"serverStatus" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(7)
			},
			"update" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(16)
			},
			"whatsmyuri" : {
				"failed" : NumberLong(0),
				"total" : NumberLong(1)
			}
		},
		"cursor" : {
			"timedOut" : NumberLong(1),
			"open" : {
				"noTimeout" : NumberLong(0),
				"pinned" : NumberLong(1),
				"total" : NumberLong(1)
			}
		},
		"document" : {
			"deleted" : NumberLong(3),
			"inserted" : NumberLong(3768),
			"returned" : NumberLong(47793),
			"updated" : NumberLong(43)
		},
		"getLastError" : {
			"wtime" : {
				"num" : 19,
				"totalMillis" : 150195
			},
			"wtimeouts" : NumberLong(10)
		},
		"operation" : {
			"scanAndOrder" : NumberLong(3),
			"writeConflicts" : NumberLong(0)
		},
		"query" : {
			"planCacheTotalSizeEstimateBytes" : NumberLong(0),
			"updateOneOpStyleBroadcastWithExactIDCount" : NumberLong(0)
		},
		"queryExecutor" : {
			"scanned" : NumberLong(39060),
			"scannedObjects" : NumberLong(794184)
		},
		"record" : {
			"moves" : NumberLong(0)
		},
		"repl" : {
			"executor" : {
				"pool" : {
					"inProgressCount" : 0
				},
				"queues" : {
					"networkInProgress" : 0,
					"sleepers" : 3
				},
				"unsignaledEvents" : 0,
				"shuttingDown" : false,
				"networkInterface" : "DEPRECATED: getDiagnosticString is deprecated in NetworkInterfaceTL"
			},
			"apply" : {
				"attemptsToBecomeSecondary" : NumberLong(1),
				"batchSize" : NumberLong(30152),
				"batches" : {
					"num" : 6415,
					"totalMillis" : 136
				},
				"ops" : NumberLong(36556)
			},
			"buffer" : {
				"count" : NumberLong(0),
				"maxSizeBytes" : NumberLong(268435456),
				"sizeBytes" : NumberLong(0)
			},
			"initialSync" : {
				"completed" : NumberLong(0),
				"failedAttempts" : NumberLong(0),
				"failures" : NumberLong(0)
			},
			"network" : {
				"bytes" : NumberLong(9345083),
				"getmores" : {
					"num" : 9951,
					"totalMillis" : 106767
				},
				"notMasterLegacyUnacknowledgedWrites" : NumberLong(0),
				"notMasterUnacknowledgedWrites" : NumberLong(0),
				"ops" : NumberLong(30153),
				"readersCreated" : NumberLong(2),
				"replSetUpdatePosition" : {
					"num" : NumberLong(12648)
				}
			},
			"stateTransition" : {
				"lastStateTransition" : "stepUp",
				"userOperationsKilled" : NumberLong(0),
				"userOperationsRunning" : NumberLong(0)
			},
			"syncSource" : {
				"numSelections" : NumberLong(20),
				"numTimesChoseDifferent" : NumberLong(1),
				"numTimesChoseSame" : NumberLong(0),
				"numTimesCouldNotFind" : NumberLong(19)
			}
		},
		"ttl" : {
			"deletedDocuments" : NumberLong(10),
			"passes" : NumberLong(310)
		}
	},
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1592403495, 1),
		"signature" : {
			"hash" : BinData(0,"N61/vc1YexoxUC/a1u4vI4yVl1o="),
			"keyId" : NumberLong("6838881995993382915")
		}
	},
	"operationTime" : Timestamp(1592403495, 1)
}
repl_set:PRIMARY> 

