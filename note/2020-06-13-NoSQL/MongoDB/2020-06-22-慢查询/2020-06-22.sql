
1. db profiling
2. 在指定db下开启 profile
3. 执行慢查询
4. 获取慢查询


1. db profiling

	MongoDB支持对DB的请求进行profiling，目前支持3种级别的profiling。
	
	0： 不开启profiling
	1： 将处理时间超过某个阈值(默认100ms)的请求都记录到DB下的system.profile集合 （类似于mysql、redis的slowlog）
	2： 将所有的请求都记录到DB下的system.profile集合（生产环境慎用）
	
	通常，生产环境建议使用1级别的profiling，并根据自身需求配置合理的阈值，用于监测慢请求的情况，并及时的做索引优化。

	如果能在集合创建的时候就能『根据业务查询需求决定应该创建哪些索引』，当然是最佳的选择；但由于业务需求多变，要根据实际情况不断的进行优化。
	索引并不是越多越好，集合的索引太多，会影响写入、更新的性能，每次写入都需要更新所有索引的数据；所以你 system.profile 里的慢请求可能是索引建立的不够导致，也可能是索引过多导致。


2. 在指定db下开启 profile
	
	
	use niuniuh5_modb_02
	
	> db.setProfilingLevel(1,100)
	{ "was" : 0, "slowms" : 100, "sampleRate" : 1, "ok" : 1 }


	> db.getProfilingStatus()
	{ "was" : 1, "slowms" : 100, "sampleRate" : 1 }


3. 执行慢查询

	repl_set:PRIMARY> db.table_clubgamelog.find({"szToken":"10001-748723-1553653368-1"})


4. 获取慢查询	
repl_set:PRIMARY> 
repl_set:PRIMARY> db.system.profile.find().limit(10).sort( { ts : -1 } ).pretty()
{
	"op" : "query",
	"ns" : "niuniuh5_modb_02.table_clubgamelog",
	"command" : {
		"find" : "table_clubgamelog",
		"filter" : {
			"szToken" : "10001-748723-1553653368-1"
		},
		"lsid" : {
			"id" : UUID("e28b1323-0171-4077-b0af-f384b1c39bb0")
		},
		"$clusterTime" : {
			"clusterTime" : Timestamp(1592808825, 1),
			"signature" : {
				"hash" : BinData(0,"mfDLav+8wltMjWkP+9Y45f0rB7w="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"$db" : "niuniuh5_modb_02"
	},
	"keysExamined" : 0,
	"docsExamined" : 5126153,   --扫描集合中的文档数
	"cursorExhausted" : true,
	"numYield" : 40048,
	"nreturned" : 1,    -- 操作返回的文档数
	"queryHash" : "16AB364D",
	"planCacheKey" : "16AB364D",
	"locks" : {
		"ParallelBatchWriterMode" : {
			"acquireCount" : {
				"r" : NumberLong(1)
			}
		},
		"ReplicationStateTransition" : {
			"acquireCount" : {
				"w" : NumberLong(40050)
			}
		},
		"Global" : {
			"acquireCount" : {
				"r" : NumberLong(40050)
			}
		},
		"Database" : {
			"acquireCount" : {
				"r" : NumberLong(40049)
			}
		},
		"Collection" : {
			"acquireCount" : {
				"r" : NumberLong(40049)
			}
		},
		"Mutex" : {
			"acquireCount" : {
				"r" : NumberLong(1)
			}
		}
	},
	"flowControl" : {
		
	},
	"storage" : {
		"data" : {
			"bytesRead" : NumberLong("8601379714"),
			"timeReadingMicros" : NumberLong(9264984)
		},
		"timeWaitingMicros" : {
			"cache" : NumberLong(1346)
		}
	},
	"responseLength" : 4389,
	"protocol" : "op_msg",
	"millis" : 12751,
	"planSummary" : "COLLSCAN",
	"execStats" : {
		"stage" : "COLLSCAN",
		"filter" : {
			"szToken" : {
				"$eq" : "10001-748723-1553653368-1"
			}
		},
		"nReturned" : 1,     -- 操作返回的文档数
		"executionTimeMillisEstimate" : 1033,  -- 耗时
		"works" : 5126155,
		"advanced" : 1,
		"needTime" : 5126153,
		"needYield" : 0,
		"saveState" : 40048,
		"restoreState" : 40048,
		"isEOF" : 1,
		"direction" : "forward",
		"docsExamined" : 5126153     -- 总共扫描的文档数
	},
	"ts" : ISODate("2020-06-22T06:54:09.339Z"),  -- 发生时间
	"client" : "127.0.0.1",
	"appName" : "MongoDB Shell",
	"allUsers" : [
		{
			"user" : "admin",
			"db" : "admin"
		}
	],
	"user" : "admin@admin"
}




