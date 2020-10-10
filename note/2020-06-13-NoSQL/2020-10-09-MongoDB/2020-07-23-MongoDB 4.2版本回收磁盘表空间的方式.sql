
1. 删除文档之前的数据大小如下
2. 删除文档之后的数据大小如下
3. 删除文档之后如何回收磁盘空间
4. 相关参考
5. 通过compact回收磁盘空间的实验 
	5.1 table_t1集合的大小如下
	5.2 删除第一批数据
	5.3 删除第一批数据之后的集合stats状态对比
	5.4 删除第二批数据之后的集合stats状态对比
	5.5 对table_t1集合执行compact命令
	5.6 对table_t1集合执行compact命令之后的stats状态对比
	5.7 查看副本集从库table_t1集合的stats
6. 小结


1. 删除文档之前的数据大小如下
	table_t1
	数据大小： 3.3GB
	索引大小： 0.9GB
	文档大小(行数)： 27625465
	目前共有多少天的数据：76天
	SELECT (DATEDIFF('2020-07-22','2020-05-07'));



	repl_set:SECONDARY> db.table_t1.stats(); 
	{
		"ns" : "mon_db.table_t1",
		"size" : 12882682995,         -- 12 GB
		"count" : 27625465,          
		"avgObjSize" : 466,
		"storageSize" : 3575160832,   -- 3.33 GB
		"capped" : false,
		"wiredTiger" : {
			"metadata" : {
				"formatVersion" : 1
			},
			
		"nindexes" : 3,
		"indexBuilds" : [ ],
		"totalIndexSize" : 970227712,  -- 0.90 GB
		"indexSizes" : {
			"_id_" : 307818496,
			"szToken_1" : 477192192,
			"CreateTime_1" : 185217024
		},
		
		
		
2. 删除文档之后的数据大小如下

	table_t1
	数据大小： 3.3GB
	索引大小： 0.9GB
	文档大小(行数)： 16348728
	目前共有多少天的数据：76天
	SELECT (DATEDIFF('2020-07-22','2020-06-07'));

	

	repl_set:SECONDARY> db.table_t1.stats(); 
	{
		"ns" : "mon_db.table_t1",
		"size" : 7717437344,          -- 7.20 GB
		"count" : 16348728,
		"avgObjSize" : 472,
		"storageSize" : 3578699776,   -- 3.33 GB
		"capped" : false,
		"wiredTiger" : {
			"metadata" : {
				"formatVersion" : 1
			},

		"nindexes" : 3,
		"indexBuilds" : [ ],
		"totalIndexSize" : 1155227648,  -- 1.07 GB
		"indexSizes" : {
			"_id_" : 308129792,
			"szToken_1" : 661782528,
			"CreateTime_1" : 185315328
		},
	
	
	-- 删除了11276737个文档：select 27625465-16348728=11276737
	
	
3. 删除文档之后如何回收磁盘空间

	这些空间会被复用吗：
		会的。
		remove 会产生逻辑的空闲空间，这些空间能立即用于写入新数据，但文件占用的总物理空间不会立即回收；
		通常只要持续在写入数据，有物理空间碎片问题并不大，不需要去 compact 集合，有的场景，remove 了大量的数据后，后续的写入可能并不多，这时如果想回收空间，就需要显式的调用 compact。
		
	如何查看碎片空间的大小
		观察 block-manager.file bytes available for reuse 指标就知道碎片空间的大小了。
	
	1. repairDatabase 期间会产生锁，建议关闭应用后再进行此操作
	2. 需要额外一倍的磁盘空间，如果文档大小为50GB，那么最少要有50GB的磁盘剩余空间（跟MySQL的重建表一样）
	3. 是否会造成副本集的从库延迟


	从4.2版开始，MongoDB将删除repairDatabase命令，用 compact 命令替代。
		-- Remove Support for the repairDatabase Command



	紧凑命令不会复制到副本集中的辅助副本，除非加 force 参数。
	 
4. 相关参考

	https://docs.mongodb.com/manual/reference/command/compact/#dbcmd.compact

	https://docs.mongodb.com/manual/release-notes/4.2-compatibility/#remove-support-for-the-repairdatabase-command
	
	http://www.gxlcms.com/mysql-315133.html
	
	https://docs.mongodb.com/manual/reference/method/db.repairDatabase/

	https://docs.mongodb.com/manual/reference/method/db.collection.reIndex/#db.collection.reIndex 

	https://mongoing.com/archives/26907  MongoDB compact 命令详解



5. 实验 

5.1 table_t1集合的大小如下

	repl_set:PRIMARY> show dbs
	abc_db     0.001GB
	admin      0.000GB
	benet      0.000GB
	config     0.000GB
	local      2.528GB
	aiuaiu_h5  9.079GB
	test       0.003GB


	repl_set:PRIMARY> db.table_t1.stats()
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 25157166819,
		"count" : 15116380,
		"avgObjSize" : 1664,
		"storageSize" : 9329381376,
		"capped" : false,
		"wiredTiger" : {
			"metadata" : {
				"formatVersion" : 1
			},
			"creationString" : "access_pattern_hint=none,allocation_size=4KB,app_metadata=(formatVersion=1),assert=(commit_timestamp=none,durable_timestamp=none,read_timestamp=none),block_allocation=best,block_compressor=snappy,cache_resident=false,checksum=on,colgroups=,collator=,columns=,dictionary=0,encryption=(keyid=,name=),exclusive=false,extractor=,format=btree,huffman_key=,huffman_value=,ignore_in_memory_cache_size=false,immutable=false,internal_item_max=0,internal_key_max=0,internal_key_truncate=true,internal_page_max=4KB,key_format=q,key_gap=10,leaf_item_max=0,leaf_key_max=0,leaf_page_max=32KB,leaf_value_max=64MB,log=(enabled=false),lsm=(auto_throttle=true,bloom=true,bloom_bit_count=16,bloom_config=,bloom_hash_count=8,bloom_oldest=false,chunk_count_limit=0,chunk_max=5GB,chunk_size=10MB,merge_custom=(prefix=,start_generation=0,suffix=),merge_max=15,merge_min=0),memory_page_image_max=0,memory_page_max=10m,os_cache_dirty_max=0,os_cache_max=0,prefix_compression=false,prefix_compression_min=4,source=,split_deepen_min_child=0,split_deepen_per_child=0,split_pct=90,type=file,value_format=u",
			"type" : "file",
			"uri" : "statistics:table:collection-0-6672498773433336180",
			"LSM" : {
				"bloom filter false positives" : 0,
				"bloom filter hits" : 0,
				"bloom filter misses" : 0,
				"bloom filter pages evicted from cache" : 0,
				"bloom filter pages read into cache" : 0,
				"bloom filters in the LSM tree" : 0,
				"chunks in the LSM tree" : 0,
				"highest merge generation in the LSM tree" : 0,
				"queries that could have benefited from a Bloom filter that did not exist" : 0,
				"sleep for LSM checkpoint throttle" : 0,
				"sleep for LSM merge throttle" : 0,
				"total size of bloom filters" : 0
			},
			"block-manager" : {
				"allocations requiring file extension" : 373260,
				"blocks allocated" : 378421,
				"blocks freed" : 2393,
				"checkpoint size" : 9329180672,
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 184320,
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 9329381376,
				"minor version number" : 0
			},
			"btree" : {
				"btree checkpoint generation" : 229,
				"column-store fixed-size leaf pages" : 0,
				"column-store internal pages" : 0,
				"column-store variable-size RLE encoded values" : 0,
				"column-store variable-size deleted values" : 0,
				"column-store variable-size leaf pages" : 0,
				"fixed-record size" : 0,
				"maximum internal page key size" : 368,
				"maximum internal page size" : 4096,
				"maximum leaf page key size" : 2867,
				"maximum leaf page size" : 32768,
				"maximum leaf page value size" : 67108864,
				"maximum tree depth" : 5,
				"number of key/value pairs" : 0,
				"overflow pages" : 0,
				"pages rewritten by compaction" : 0,
				"row-store empty values" : 0,
				"row-store internal pages" : 0,
				"row-store leaf pages" : 0
			},
			"cache" : {
				"bytes currently in the cache" : 865205785,
				"bytes dirty in the cache cumulative" : 933170045,
				"bytes read into cache" : 81671151280,
				"bytes written from cache" : 17468219091,
				"checkpoint blocked page eviction" : 752,
				"data source pages selected for eviction unable to be evicted" : 3539,
				"eviction walk passes of a file" : 68906,
				"eviction walk target pages histogram - 0-9" : 7011,
				"eviction walk target pages histogram - 10-31" : 17709,
				"eviction walk target pages histogram - 128 and higher" : 0,
				"eviction walk target pages histogram - 32-63" : 15658,
				"eviction walk target pages histogram - 64-128" : 28528,
				"eviction walks abandoned" : 2181,
				"eviction walks gave up because they restarted their walk twice" : 666,
				"eviction walks gave up because they saw too many pages and found no candidates" : 5795,
				"eviction walks gave up because they saw too many pages and found too few candidates" : 2758,
				"eviction walks reached end of tree" : 12258,
				"eviction walks started from root of tree" : 11403,
				"eviction walks started from saved location in tree" : 57503,
				"hazard pointer blocked page eviction" : 622,
				"in-memory page passed criteria to be split" : 4246,
				"in-memory page splits" : 1949,
				"internal pages evicted" : 13354,
				"internal pages split during eviction" : 37,
				"leaf pages split during eviction" : 4972,
				"modified pages evicted" : 289072,
				"overflow pages read into cache" : 0,
				"page split during eviction deepened the tree" : 0,
				"page written requiring cache overflow records" : 7969,
				"pages read into cache" : 1615291,
				"pages read into cache after truncate" : 0,
				"pages read into cache after truncate in prepare state" : 0,
				"pages read into cache requiring cache overflow entries" : 7972,
				"pages requested from the cache" : 33631833,
				"pages seen by eviction walk" : 27770584,
				"pages written from cache" : 378321,
				"pages written requiring in-memory restoration" : 206592,
				"tracked dirty bytes in the cache" : 0,
				"unmodified pages evicted" : 1866955
			},
			"cache_walk" : {
				"Average difference between current eviction generation when the page was last considered" : 0,
				"Average on-disk page image size seen" : 0,
				"Average time in cache for pages that have been visited by the eviction server" : 0,
				"Average time in cache for pages that have not been visited by the eviction server" : 0,
				"Clean pages currently in cache" : 0,
				"Current eviction generation" : 0,
				"Dirty pages currently in cache" : 0,
				"Entries in the root page" : 0,
				"Internal pages currently in cache" : 0,
				"Leaf pages currently in cache" : 0,
				"Maximum difference between current eviction generation when the page was last considered" : 0,
				"Maximum page size seen" : 0,
				"Minimum on-disk page image size seen" : 0,
				"Number of pages never visited by eviction server" : 0,
				"On-disk page image sizes smaller than a single allocation unit" : 0,
				"Pages created in memory and never written" : 0,
				"Pages currently queued for eviction" : 0,
				"Pages that could not be queued for eviction" : 0,
				"Refs skipped during cache traversal" : 0,
				"Size of the root page" : 0,
				"Total number of pages currently in cache" : 0
			},
			"compression" : {
				"compressed page maximum internal page size prior to compression" : 4096,
				"compressed page maximum leaf page size prior to compression " : 75380,
				"compressed pages read" : 1570325,
				"compressed pages written" : 360144,
				"page written failed to compress" : 0,
				"page written was too small to compress" : 18147
			},
			"cursor" : {
				"bulk loaded cursor insert calls" : 0,
				"cache cursors reuse count" : 168275,
				"close calls that result in cache" : 0,
				"create calls" : 34,
				"insert calls" : 10400960,
				"insert key and value bytes" : 17323429269,
				"modify" : 0,
				"modify key and value bytes affected" : 0,
				"modify value bytes modified" : 0,
				"next calls" : 41216322,
				"open cursor count" : 0,
				"operation restarted" : 2691,
				"prev calls" : 1,
				"remove calls" : 0,
				"remove key bytes removed" : 0,
				"reserve calls" : 0,
				"reset calls" : 660227,
				"search calls" : 2,
				"search near calls" : 323170,
				"truncate calls" : 0,
				"update calls" : 0,
				"update key and value bytes" : 0,
				"update value size change" : 0
			},
			"reconciliation" : {
				"dictionary matches" : 0,
				"fast-path pages deleted" : 0,
				"internal page key bytes discarded using suffix compression" : 601380,
				"internal page multi-block writes" : 87,
				"internal-page overflow keys" : 0,
				"leaf page key bytes discarded using prefix compression" : 0,
				"leaf page multi-block writes" : 4993,
				"leaf-page overflow keys" : 0,
				"maximum blocks required for a page" : 11,
				"overflow values written" : 0,
				"page checksum matches" : 800,
				"page reconciliation calls" : 301063,
				"page reconciliation calls for eviction" : 291213,
				"pages deleted" : 3331
			},
			"session" : {
				"object compaction" : 1
			},
			"transaction" : {
				"update conflicts" : 0
			}
		},
		"nindexes" : 3,
		"indexBuilds" : [ ],
		"totalIndexSize" : 418766848,
		"indexSizes" : {
			"_id_" : 153161728,
			"szToken_1" : 182095872,
			"CreateTime_1" : 83509248
		},
		"scaleFactor" : 1,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1595486869, 1),
			"signature" : {
				"hash" : BinData(0,"I3ZRIedacVLClNybG697aO8zqCo="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1595486869, 1)
	}
	repl_set:PRIMARY> 



-----------------------------------------------------------

5.2 删除第一批数据

	repl_set:PRIMARY> db.table_t1.remove({"CreateTime" : {"$lt" :  ISODate('2020-07-01 00:00:00')}})
	WriteResult({ "nRemoved" : 3566551 })
	-- 删除了 3566551 个文档

	repl_set:PRIMARY> db.table_t1.stats();
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 19236001000,
		"count" : 11559829,
		"avgObjSize" : 1664,
		"storageSize" : 9329381376,
		"capped" : false,
		"wiredTiger" : {
			"metadata" : {
				"formatVersion" : 1
			},
			"creationString" : "access_pattern_hint=none,allocation_size=4KB,app_metadata=(formatVersion=1),assert=(commit_timestamp=none,durable_timestamp=none,read_timestamp=none),block_allocation=best,block_compressor=snappy,cache_resident=false,checksum=on,colgroups=,collator=,columns=,dictionary=0,encryption=(keyid=,name=),exclusive=false,extractor=,format=btree,huffman_key=,huffman_value=,ignore_in_memory_cache_size=false,immutable=false,internal_item_max=0,internal_key_max=0,internal_key_truncate=true,internal_page_max=4KB,key_format=q,key_gap=10,leaf_item_max=0,leaf_key_max=0,leaf_page_max=32KB,leaf_value_max=64MB,log=(enabled=false),lsm=(auto_throttle=true,bloom=true,bloom_bit_count=16,bloom_config=,bloom_hash_count=8,bloom_oldest=false,chunk_count_limit=0,chunk_max=5GB,chunk_size=10MB,merge_custom=(prefix=,start_generation=0,suffix=),merge_max=15,merge_min=0),memory_page_image_max=0,memory_page_max=10m,os_cache_dirty_max=0,os_cache_max=0,prefix_compression=false,prefix_compression_min=4,source=,split_deepen_min_child=0,split_deepen_per_child=0,split_pct=90,type=file,value_format=u",
			"type" : "file",
			"uri" : "statistics:table:collection-0-6672498773433336180",
			"LSM" : {
				"bloom filter false positives" : 0,
				"bloom filter hits" : 0,
				"bloom filter misses" : 0,
				"bloom filter pages evicted from cache" : 0,
				"bloom filter pages read into cache" : 0,
				"bloom filters in the LSM tree" : 0,
				"chunks in the LSM tree" : 0,
				"highest merge generation in the LSM tree" : 0,
				"queries that could have benefited from a Bloom filter that did not exist" : 0,
				"sleep for LSM checkpoint throttle" : 0,
				"sleep for LSM merge throttle" : 0,
				"total size of bloom filters" : 0
			},
			"block-manager" : {
				"allocations requiring file extension" : 374195,
				"blocks allocated" : 407327,
				"blocks freed" : 153986,
				"checkpoint size" : 7175368704,
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 2153996288,
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 9329381376,
				"minor version number" : 0
			},
			"btree" : {
				"btree checkpoint generation" : 246,
				"column-store fixed-size leaf pages" : 0,
				"column-store internal pages" : 0,
				"column-store variable-size RLE encoded values" : 0,
				"column-store variable-size deleted values" : 0,
				"column-store variable-size leaf pages" : 0,
				"fixed-record size" : 0,
				"maximum internal page key size" : 368,
				"maximum internal page size" : 4096,
				"maximum leaf page key size" : 2867,
				"maximum leaf page size" : 32768,
				"maximum leaf page value size" : 67108864,
				"maximum tree depth" : 5,
				"number of key/value pairs" : 0,
				"overflow pages" : 0,
				"pages rewritten by compaction" : 0,
				"row-store empty values" : 0,
				"row-store internal pages" : 0,
				"row-store leaf pages" : 0
			},
			"cache" : {
				"bytes currently in the cache" : 604025597,
				"bytes dirty in the cache cumulative" : 16283986967,
				"bytes read into cache" : 91327863550,
				"bytes written from cache" : 18499620682,
				"checkpoint blocked page eviction" : 755,
				"data source pages selected for eviction unable to be evicted" : 68226,
				"eviction walk passes of a file" : 108961,
				"eviction walk target pages histogram - 0-9" : 14769,
				"eviction walk target pages histogram - 10-31" : 31410,
				"eviction walk target pages histogram - 128 and higher" : 0,
				"eviction walk target pages histogram - 32-63" : 30221,
				"eviction walk target pages histogram - 64-128" : 32561,
				"eviction walks abandoned" : 2320,
				"eviction walks gave up because they restarted their walk twice" : 725,
				"eviction walks gave up because they saw too many pages and found no candidates" : 12170,
				"eviction walks gave up because they saw too many pages and found too few candidates" : 6628,
				"eviction walks reached end of tree" : 21402,
				"eviction walks started from root of tree" : 21852,
				"eviction walks started from saved location in tree" : 87109,
				"hazard pointer blocked page eviction" : 636,
				"in-memory page passed criteria to be split" : 4246,
				"in-memory page splits" : 1949,
				"internal pages evicted" : 14453,
				"internal pages split during eviction" : 37,
				"leaf pages split during eviction" : 15149,
				"modified pages evicted" : 622189,
				"overflow pages read into cache" : 0,
				"page split during eviction deepened the tree" : 0,
				"page written requiring cache overflow records" : 38721,
				"pages read into cache" : 1832228,
				"pages read into cache after truncate" : 0,
				"pages read into cache after truncate in prepare state" : 0,
				"pages read into cache requiring cache overflow entries" : 32751,
				"pages requested from the cache" : 65859863,
				"pages seen by eviction walk" : 52094370,
				"pages written from cache" : 407201,
				"pages written requiring in-memory restoration" : 406254,
				"tracked dirty bytes in the cache" : 0,
				"unmodified pages evicted" : 1940647
			},
			"cache_walk" : {
				"Average difference between current eviction generation when the page was last considered" : 0,
				"Average on-disk page image size seen" : 0,
				"Average time in cache for pages that have been visited by the eviction server" : 0,
				"Average time in cache for pages that have not been visited by the eviction server" : 0,
				"Clean pages currently in cache" : 0,
				"Current eviction generation" : 0,
				"Dirty pages currently in cache" : 0,
				"Entries in the root page" : 0,
				"Internal pages currently in cache" : 0,
				"Leaf pages currently in cache" : 0,
				"Maximum difference between current eviction generation when the page was last considered" : 0,
				"Maximum page size seen" : 0,
				"Minimum on-disk page image size seen" : 0,
				"Number of pages never visited by eviction server" : 0,
				"On-disk page image sizes smaller than a single allocation unit" : 0,
				"Pages created in memory and never written" : 0,
				"Pages currently queued for eviction" : 0,
				"Pages that could not be queued for eviction" : 0,
				"Refs skipped during cache traversal" : 0,
				"Size of the root page" : 0,
				"Total number of pages currently in cache" : 0
			},
			"compression" : {
				"compressed page maximum internal page size prior to compression" : 4096,
				"compressed page maximum leaf page size prior to compression " : 88460,
				"compressed pages read" : 1779844,
				"compressed pages written" : 388718,
				"page written failed to compress" : 0,
				"page written was too small to compress" : 18443
			},
			"cursor" : {
				"bulk loaded cursor insert calls" : 0,
				"cache cursors reuse count" : 168593,
				"close calls that result in cache" : 0,
				"create calls" : 36,
				"insert calls" : 10410960,
				"insert key and value bytes" : 17340039677,
				"modify" : 0,
				"modify key and value bytes affected" : 0,
				"modify value bytes modified" : 0,
				"next calls" : 42705020,
				"open cursor count" : 0,
				"operation restarted" : 2691,
				"prev calls" : 1,
				"remove calls" : 3566551,
				"remove key bytes removed" : 14183839,
				"reserve calls" : 0,
				"reset calls" : 11409543,
				"search calls" : 10699655,
				"search near calls" : 334881,
				"truncate calls" : 0,
				"update calls" : 0,
				"update key and value bytes" : 0,
				"update value size change" : 0
			},
			"reconciliation" : {
				"dictionary matches" : 0,
				"fast-path pages deleted" : 0,
				"internal page key bytes discarded using suffix compression" : 737292,
				"internal page multi-block writes" : 96,
				"internal-page overflow keys" : 0,
				"leaf page key bytes discarded using prefix compression" : 0,
				"leaf page multi-block writes" : 15207,
				"leaf-page overflow keys" : 0,
				"maximum blocks required for a page" : 11,
				"overflow values written" : 0,
				"page checksum matches" : 834,
				"page reconciliation calls" : 673904,
				"page reconciliation calls for eviction" : 649648,
				"pages deleted" : 137539
			},
			"session" : {
				"object compaction" : 1
			},
			"transaction" : {
				"update conflicts" : 0
			}
		},
		"nindexes" : 3,
		"indexBuilds" : [ ],
		"totalIndexSize" : 638005248,
		"indexSizes" : {
			"_id_" : 153137152,
			"szToken_1" : 401371136,
			"CreateTime_1" : 83496960
		},
		"scaleFactor" : 1,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1595487980, 1),
			"signature" : {
				"hash" : BinData(0,"jftpW4GcaJGdtcQGPZQtSDMQ1Oc="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1595487980, 1)
	}


5.3 删除第一批数据之后的集合stats状态对比

		repl_set:PRIMARY> db.table_t1.stats()
		{
			"ns" : "aiuaiu_h5.table_t1",
			"size" : 25157166819,
			"count" : 15116380,
			"avgObjSize" : 1664,
			"storageSize" : 9329381376,
			
			"block-manager" : {
					"allocations requiring file extension" : 373260,
					"blocks allocated" : 378421,
					"blocks freed" : 2393,
					"checkpoint size" : 9329180672,
					"file allocation unit size" : 4096,
					"file bytes available for reuse" : 184320,
					"file magic number" : 120897,
					"file major version number" : 1,
					"file size in bytes" : 9329381376,
					"minor version number" : 0
				},
				
				
		repl_set:PRIMARY> db.table_t1.stats();
		{
			"ns" : "aiuaiu_h5.table_t1",
			"size" : 19236001000,
			"count" : 11559829,
			"avgObjSize" : 1664,
			"storageSize" : 9329381376,
			
			"block-manager" : {
					"allocations requiring file extension" : 374195,
					"blocks allocated" : 407327,
					"blocks freed" : 153986,       -- 增大了好多
					"checkpoint size" : 7175368704,  
					"file allocation unit size" : 4096,
					"file bytes available for reuse" : 2153996288,  -- 增大了好多
					"file magic number" : 120897,
					"file major version number" : 1,
					"file size in bytes" : 9329381376,
					"minor version number" : 0
				},
		

	
-------------------------------------------------------------	

5.4 第二次删除数据

	repl_set:PRIMARY> db.table_t1.remove({"CreateTime" : {"$lt" :  ISODate('2020-07-08 00:00:00')}})
	WriteResult({ "nRemoved" : 1140327 })
	repl_set:PRIMARY> db.table_t1.remove({"CreateTime" : {"$lt" :  ISODate('2020-07-15 00:00:00')}})
	WriteResult({ "nRemoved" : 133294 })

	repl_set:PRIMARY> db.table_t1.stats();
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 17087789323,
		"count" : 10286208,
		"avgObjSize" : 1661,
		"storageSize" : 9329381376,
		"capped" : false,
		"wiredTiger" : {
			"metadata" : {
				"formatVersion" : 1
			},
			"creationString" : "access_pattern_hint=none,allocation_size=4KB,app_metadata=(formatVersion=1),assert=(commit_timestamp=none,durable_timestamp=none,read_timestamp=none),block_allocation=best,block_compressor=snappy,cache_resident=false,checksum=on,colgroups=,collator=,columns=,dictionary=0,encryption=(keyid=,name=),exclusive=false,extractor=,format=btree,huffman_key=,huffman_value=,ignore_in_memory_cache_size=false,immutable=false,internal_item_max=0,internal_key_max=0,internal_key_truncate=true,internal_page_max=4KB,key_format=q,key_gap=10,leaf_item_max=0,leaf_key_max=0,leaf_page_max=32KB,leaf_value_max=64MB,log=(enabled=false),lsm=(auto_throttle=true,bloom=true,bloom_bit_count=16,bloom_config=,bloom_hash_count=8,bloom_oldest=false,chunk_count_limit=0,chunk_max=5GB,chunk_size=10MB,merge_custom=(prefix=,start_generation=0,suffix=),merge_max=15,merge_min=0),memory_page_image_max=0,memory_page_max=10m,os_cache_dirty_max=0,os_cache_max=0,prefix_compression=false,prefix_compression_min=4,source=,split_deepen_min_child=0,split_deepen_per_child=0,split_pct=90,type=file,value_format=u",
			"type" : "file",
			"uri" : "statistics:table:collection-0-6672498773433336180",
			"LSM" : {
				"bloom filter false positives" : 0,
				"bloom filter hits" : 0,
				"bloom filter misses" : 0,
				"bloom filter pages evicted from cache" : 0,
				"bloom filter pages read into cache" : 0,
				"bloom filters in the LSM tree" : 0,
				"chunks in the LSM tree" : 0,
				"highest merge generation in the LSM tree" : 0,
				"queries that could have benefited from a Bloom filter that did not exist" : 0,
				"sleep for LSM checkpoint throttle" : 0,
				"sleep for LSM merge throttle" : 0,
				"total size of bloom filters" : 0
			},
			"block-manager" : {
				"allocations requiring file extension" : 374195,
				"blocks allocated" : 409732,
				"blocks freed" : 199559,
				"checkpoint size" : 6396182528,
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 2933178368,
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 9329381376,
				"minor version number" : 0
			},
			"btree" : {
				"btree checkpoint generation" : 255,
				"column-store fixed-size leaf pages" : 0,
				"column-store internal pages" : 0,
				"column-store variable-size RLE encoded values" : 0,
				"column-store variable-size deleted values" : 0,
				"column-store variable-size leaf pages" : 0,
				"fixed-record size" : 0,
				"maximum internal page key size" : 368,
				"maximum internal page size" : 4096,
				"maximum leaf page key size" : 2867,
				"maximum leaf page size" : 32768,
				"maximum leaf page value size" : 67108864,
				"maximum tree depth" : 5,
				"number of key/value pairs" : 0,
				"overflow pages" : 0,
				"pages rewritten by compaction" : 0,
				"row-store empty values" : 0,
				"row-store internal pages" : 0,
				"row-store leaf pages" : 0
			},
			"cache" : {
				"bytes currently in the cache" : 526019585,
				"bytes dirty in the cache cumulative" : 19935056247,
				"bytes read into cache" : 93569197523,
				"bytes written from cache" : 18596494783,
				"checkpoint blocked page eviction" : 755,
				"data source pages selected for eviction unable to be evicted" : 92224,
				"eviction walk passes of a file" : 117134,
				"eviction walk target pages histogram - 0-9" : 16021,
				"eviction walk target pages histogram - 10-31" : 33992,
				"eviction walk target pages histogram - 128 and higher" : 0,
				"eviction walk target pages histogram - 32-63" : 34256,
				"eviction walk target pages histogram - 64-128" : 32865,
				"eviction walks abandoned" : 2322,
				"eviction walks gave up because they restarted their walk twice" : 725,
				"eviction walks gave up because they saw too many pages and found no candidates" : 12916,
				"eviction walks gave up because they saw too many pages and found too few candidates" : 7619,
				"eviction walks reached end of tree" : 22686,
				"eviction walks started from root of tree" : 23598,
				"eviction walks started from saved location in tree" : 93536,
				"hazard pointer blocked page eviction" : 647,
				"in-memory page passed criteria to be split" : 4246,
				"in-memory page splits" : 1949,
				"internal pages evicted" : 14777,
				"internal pages split during eviction" : 37,
				"leaf pages split during eviction" : 16819,
				"modified pages evicted" : 691748,
				"overflow pages read into cache" : 0,
				"page split during eviction deepened the tree" : 0,
				"page written requiring cache overflow records" : 41199,
				"pages read into cache" : 1877315,
				"pages read into cache after truncate" : 0,
				"pages read into cache after truncate in prepare state" : 0,
				"pages read into cache requiring cache overflow entries" : 34639,
				"pages requested from the cache" : 77382930,
				"pages seen by eviction walk" : 58126759,
				"pages written from cache" : 409588,
				"pages written requiring in-memory restoration" : 430790,
				"tracked dirty bytes in the cache" : 0,
				"unmodified pages evicted" : 1941379
			},
			"cache_walk" : {
				"Average difference between current eviction generation when the page was last considered" : 0,
				"Average on-disk page image size seen" : 0,
				"Average time in cache for pages that have been visited by the eviction server" : 0,
				"Average time in cache for pages that have not been visited by the eviction server" : 0,
				"Clean pages currently in cache" : 0,
				"Current eviction generation" : 0,
				"Dirty pages currently in cache" : 0,
				"Entries in the root page" : 0,
				"Internal pages currently in cache" : 0,
				"Leaf pages currently in cache" : 0,
				"Maximum difference between current eviction generation when the page was last considered" : 0,
				"Maximum page size seen" : 0,
				"Minimum on-disk page image size seen" : 0,
				"Number of pages never visited by eviction server" : 0,
				"On-disk page image sizes smaller than a single allocation unit" : 0,
				"Pages created in memory and never written" : 0,
				"Pages currently queued for eviction" : 0,
				"Pages that could not be queued for eviction" : 0,
				"Refs skipped during cache traversal" : 0,
				"Size of the root page" : 0,
				"Total number of pages currently in cache" : 0
			},
			"compression" : {
				"compressed page maximum internal page size prior to compression" : 4096,
				"compressed page maximum leaf page size prior to compression " : 91736,
				"compressed pages read" : 1824435,
				"compressed pages written" : 391028,
				"page written failed to compress" : 0,
				"page written was too small to compress" : 18520
			},
			"cursor" : {
				"bulk loaded cursor insert calls" : 0,
				"cache cursors reuse count" : 168662,
				"close calls that result in cache" : 0,
				"create calls" : 38,
				"insert calls" : 10410960,
				"insert key and value bytes" : 17340039677,
				"modify" : 0,
				"modify key and value bytes affected" : 0,
				"modify value bytes modified" : 0,
				"next calls" : 42705097,
				"open cursor count" : 0,
				"operation restarted" : 2691,
				"prev calls" : 1,
				"remove calls" : 4840172,
				"remove key bytes removed" : 19278323,
				"reserve calls" : 0,
				"reset calls" : 15242274,
				"search calls" : 14520518,
				"search near calls" : 334891,
				"truncate calls" : 0,
				"update calls" : 0,
				"update key and value bytes" : 0,
				"update value size change" : 0
			},
			"reconciliation" : {
				"dictionary matches" : 0,
				"fast-path pages deleted" : 0,
				"internal page key bytes discarded using suffix compression" : 750861,
				"internal page multi-block writes" : 99,
				"internal-page overflow keys" : 0,
				"leaf page key bytes discarded using prefix compression" : 0,
				"leaf page multi-block writes" : 16878,
				"leaf-page overflow keys" : 0,
				"maximum blocks required for a page" : 11,
				"overflow values written" : 0,
				"page checksum matches" : 834,
				"page reconciliation calls" : 745689,
				"page reconciliation calls for eviction" : 720834,
				"pages deleted" : 181866
			},
			"session" : {
				"object compaction" : 1
			},
			"transaction" : {
				"update conflicts" : 0
			}
		},
		"nindexes" : 3,
		"indexBuilds" : [ ],
		"totalIndexSize" : 630984704,
		"indexSizes" : {
			"_id_" : 153137152,
			"szToken_1" : 394395648,
			"CreateTime_1" : 83451904
		},
		"scaleFactor" : 1,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1595488490, 1),
			"signature" : {
				"hash" : BinData(0,"+EHwFXXbve0LBJTez7kmYGdUN68="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1595488490, 1)
	}



5.4 删除第二批数据之后的集合stats状态对比

	repl_set:PRIMARY> db.table_t1.stats()
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 25157166819,
		"count" : 15116380,
		"avgObjSize" : 1664,
		"storageSize" : 9329381376,
		
		"block-manager" : {
				"allocations requiring file extension" : 373260,
				"blocks allocated" : 378421,
				"blocks freed" : 2393,
				"checkpoint size" : 9329180672,
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 184320,
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 9329381376,
				"minor version number" : 0
			},
			
			
	repl_set:PRIMARY> db.table_t1.stats();
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 19236001000,
		"count" : 11559829,
		"avgObjSize" : 1664,
		"storageSize" : 9329381376,
		
		"block-manager" : {
				"allocations requiring file extension" : 374195,
				"blocks allocated" : 407327,
				"blocks freed" : 153986,       -- 增大了好多
				"checkpoint size" : 7175368704,  
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 2153996288,  -- 增大了好多
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 9329381376,
				"minor version number" : 0
			},
	
	
	repl_set:PRIMARY> db.table_t1.stats();
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 17087789323,
		"count" : 10286208,
		"avgObjSize" : 1661,
		"storageSize" : 9329381376,

		"block-manager" : {
			"allocations requiring file extension" : 374195,
			"blocks allocated" : 409732,
			"blocks freed" : 199559,        -- 又增加了  
			"checkpoint size" : 6396182528,
			"file allocation unit size" : 4096,
			"file bytes available for reuse" : 2933178368,   -- 再次增加了
			"file magic number" : 120897,
			"file major version number" : 1,
			"file size in bytes" : 9329381376,
			"minor version number" : 0
		},
		
	
------------------------------------------------------------



5.5 对table_t1集合执行compact命令

	db.runCommand({compact: "table_t1", force: true}) 


	repl_set:PRIMARY> db.runCommand({compact: "table_t1", force: true}) 
	{
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1595488630, 1),
			"signature" : {
				"hash" : BinData(0,"3+uLwdJ7sKzdpNVtBFTYZyZs9oc="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1595488630, 1)
	}

	select from_unixtime(1595488630);   --2020-07-23 15:17:10


	--从 15:26:40开始操作， 耗时约30秒
	   

	repl_set:PRIMARY> db.table_t1.stats()
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 17125570526,
		"count" : 10309208,
		"avgObjSize" : 1661,
		"storageSize" : 6717177856,
		"capped" : false,
		"wiredTiger" : {
			"metadata" : {
				"formatVersion" : 1
			},
			"creationString" : "access_pattern_hint=none,allocation_size=4KB,app_metadata=(formatVersion=1),assert=(commit_timestamp=none,durable_timestamp=none,read_timestamp=none),block_allocation=best,block_compressor=snappy,cache_resident=false,checksum=on,colgroups=,collator=,columns=,dictionary=0,encryption=(keyid=,name=),exclusive=false,extractor=,format=btree,huffman_key=,huffman_value=,ignore_in_memory_cache_size=false,immutable=false,internal_item_max=0,internal_key_max=0,internal_key_truncate=true,internal_page_max=4KB,key_format=q,key_gap=10,leaf_item_max=0,leaf_key_max=0,leaf_page_max=32KB,leaf_value_max=64MB,log=(enabled=false),lsm=(auto_throttle=true,bloom=true,bloom_bit_count=16,bloom_config=,bloom_hash_count=8,bloom_oldest=false,chunk_count_limit=0,chunk_max=5GB,chunk_size=10MB,merge_custom=(prefix=,start_generation=0,suffix=),merge_max=15,merge_min=0),memory_page_image_max=0,memory_page_max=10m,os_cache_dirty_max=0,os_cache_max=0,prefix_compression=false,prefix_compression_min=4,source=,split_deepen_min_child=0,split_deepen_per_child=0,split_pct=90,type=file,value_format=u",
			"type" : "file",
			"uri" : "statistics:table:collection-0-6672498773433336180",
			"LSM" : {
				"bloom filter false positives" : 0,
				"bloom filter hits" : 0,
				"bloom filter misses" : 0,
				"bloom filter pages evicted from cache" : 0,
				"bloom filter pages read into cache" : 0,
				"bloom filters in the LSM tree" : 0,
				"chunks in the LSM tree" : 0,
				"highest merge generation in the LSM tree" : 0,
				"queries that could have benefited from a Bloom filter that did not exist" : 0,
				"sleep for LSM checkpoint throttle" : 0,
				"sleep for LSM merge throttle" : 0,
				"total size of bloom filters" : 0
			},
			"block-manager" : {
				"allocations requiring file extension" : 374195,
				"blocks allocated" : 584163,
				"blocks freed" : 359732,
				"checkpoint size" : 6443270144,
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 273891328,
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 6717177856,
				"minor version number" : 0
			},
			"btree" : {
				"btree checkpoint generation" : 290,
				"column-store fixed-size leaf pages" : 0,
				"column-store internal pages" : 0,
				"column-store variable-size RLE encoded values" : 0,
				"column-store variable-size deleted values" : 0,
				"column-store variable-size leaf pages" : 0,
				"fixed-record size" : 0,
				"maximum internal page key size" : 368,
				"maximum internal page size" : 4096,
				"maximum leaf page key size" : 2867,
				"maximum leaf page size" : 32768,
				"maximum leaf page value size" : 67108864,
				"maximum tree depth" : 5,
				"number of key/value pairs" : 0,
				"overflow pages" : 0,
				"pages rewritten by compaction" : 159998,
				"row-store empty values" : 0,
				"row-store internal pages" : 0,
				"row-store leaf pages" : 0
			},
			"cache" : {
				"bytes currently in the cache" : 587348421,
				"bytes dirty in the cache cumulative" : 27705737641,
				"bytes read into cache" : 100657271638,
				"bytes written from cache" : 25722581181,
				"checkpoint blocked page eviction" : 788,
				"data source pages selected for eviction unable to be evicted" : 93486,
				"eviction walk passes of a file" : 121265,
				"eviction walk target pages histogram - 0-9" : 16142,
				"eviction walk target pages histogram - 10-31" : 34479,
				"eviction walk target pages histogram - 128 and higher" : 0,
				"eviction walk target pages histogram - 32-63" : 34614,
				"eviction walk target pages histogram - 64-128" : 36030,
				"eviction walks abandoned" : 2342,
				"eviction walks gave up because they restarted their walk twice" : 748,
				"eviction walks gave up because they saw too many pages and found no candidates" : 12916,
				"eviction walks gave up because they saw too many pages and found too few candidates" : 7619,
				"eviction walks reached end of tree" : 22800,
				"eviction walks started from root of tree" : 23641,
				"eviction walks started from saved location in tree" : 97624,
				"hazard pointer blocked page eviction" : 664,
				"in-memory page passed criteria to be split" : 4254,
				"in-memory page splits" : 1953,
				"internal pages evicted" : 23042,
				"internal pages split during eviction" : 37,
				"leaf pages split during eviction" : 30160,
				"modified pages evicted" : 851132,
				"overflow pages read into cache" : 0,
				"page split during eviction deepened the tree" : 0,
				"page written requiring cache overflow records" : 41199,
				"pages read into cache" : 2041378,
				"pages read into cache after truncate" : 0,
				"pages read into cache after truncate in prepare state" : 0,
				"pages read into cache requiring cache overflow entries" : 35244,
				"pages requested from the cache" : 77655607,
				"pages seen by eviction walk" : 59620720,
				"pages written from cache" : 583955,
				"pages written requiring in-memory restoration" : 430790,
				"tracked dirty bytes in the cache" : 0,
				"unmodified pages evicted" : 1987012
			},
			"cache_walk" : {
				"Average difference between current eviction generation when the page was last considered" : 0,
				"Average on-disk page image size seen" : 0,
				"Average time in cache for pages that have been visited by the eviction server" : 0,
				"Average time in cache for pages that have not been visited by the eviction server" : 0,
				"Clean pages currently in cache" : 0,
				"Current eviction generation" : 0,
				"Dirty pages currently in cache" : 0,
				"Entries in the root page" : 0,
				"Internal pages currently in cache" : 0,
				"Leaf pages currently in cache" : 0,
				"Maximum difference between current eviction generation when the page was last considered" : 0,
				"Maximum page size seen" : 0,
				"Minimum on-disk page image size seen" : 0,
				"Number of pages never visited by eviction server" : 0,
				"On-disk page image sizes smaller than a single allocation unit" : 0,
				"Pages created in memory and never written" : 0,
				"Pages currently queued for eviction" : 0,
				"Pages that could not be queued for eviction" : 0,
				"Refs skipped during cache traversal" : 0,
				"Size of the root page" : 0,
				"Total number of pages currently in cache" : 0
			},
			"compression" : {
				"compressed page maximum internal page size prior to compression" : 4096,
				"compressed page maximum leaf page size prior to compression " : 72104,
				"compressed pages read" : 1974912,
				"compressed pages written" : 555950,
				"page written failed to compress" : 0,
				"page written was too small to compress" : 27906
			},
			"cursor" : {
				"bulk loaded cursor insert calls" : 0,
				"cache cursors reuse count" : 169032,
				"close calls that result in cache" : 0,
				"create calls" : 38,
				"insert calls" : 10433960,
				"insert key and value bytes" : 17377912880,
				"modify" : 0,
				"modify key and value bytes affected" : 0,
				"modify value bytes modified" : 0,
				"next calls" : 42705099,
				"open cursor count" : 0,
				"operation restarted" : 2691,
				"prev calls" : 1,
				"remove calls" : 4840172,
				"remove key bytes removed" : 19278323,
				"reserve calls" : 0,
				"reset calls" : 15243014,
				"search calls" : 14520518,
				"search near calls" : 334891,
				"truncate calls" : 0,
				"update calls" : 0,
				"update key and value bytes" : 0,
				"update value size change" : 0
			},
			"reconciliation" : {
				"dictionary matches" : 0,
				"fast-path pages deleted" : 0,
				"internal page key bytes discarded using suffix compression" : 814927,
				"internal page multi-block writes" : 109,
				"internal-page overflow keys" : 0,
				"leaf page key bytes discarded using prefix compression" : 0,
				"leaf page multi-block writes" : 30283,
				"leaf-page overflow keys" : 0,
				"maximum blocks required for a page" : 11,
				"overflow values written" : 0,
				"page checksum matches" : 861,
				"page reconciliation calls" : 906513,
				"page reconciliation calls for eviction" : 878589,
				"pages deleted" : 182535
			},
			"session" : {
				"object compaction" : 5
			},
			"transaction" : {
				"update conflicts" : 0
			}
		},
		"nindexes" : 3,
		"indexBuilds" : [ ],
		"totalIndexSize" : 306696192,
		"indexSizes" : {
			"_id_" : 110284800,
			"szToken_1" : 149090304,
			"CreateTime_1" : 47321088
		},
		"scaleFactor" : 1,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1595488850, 1),
			"signature" : {
				"hash" : BinData(0,"cPH7/qlLqzFaV+TaB7kt2lGk6VQ="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1595488850, 1)
	}


5.6 对table_t1集合执行compact命令之后的stats状态对比


	repl_set:PRIMARY> db.table_t1.stats()
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 25157166819,
		"count" : 15116380,
		"avgObjSize" : 1664,
		"storageSize" : 9329381376,
		
		"block-manager" : {
				"allocations requiring file extension" : 373260,
				"blocks allocated" : 378421,
				"blocks freed" : 2393,
				"checkpoint size" : 9329180672,
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 184320,
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 9329381376,
				"minor version number" : 0
			},
			
			
	repl_set:PRIMARY> db.table_t1.stats();
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 19236001000,
		"count" : 11559829,
		"avgObjSize" : 1664,
		"storageSize" : 9329381376,
		
		"block-manager" : {
				"allocations requiring file extension" : 374195,
				"blocks allocated" : 407327,
				"blocks freed" : 153986,       -- 增大了好多
				"checkpoint size" : 7175368704,  
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 2153996288,  -- 增大了好多
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 9329381376,
				"minor version number" : 0
			},
	
	
	repl_set:PRIMARY> db.table_t1.stats();
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 17087789323,
		"count" : 10286208,
		"avgObjSize" : 1661,
		"storageSize" : 9329381376,              -- 8.68866 GB

		"block-manager" : {
			"allocations requiring file extension" : 374195,
			"blocks allocated" : 409732,
			"blocks freed" : 199559,        -- 又增加了  
			"checkpoint size" : 6396182528,
			"file allocation unit size" : 4096,
			"file bytes available for reuse" : 2933178368,   -- 可重复使用的文件字节: 2.73174 GB
			"file magic number" : 120897,
			"file major version number" : 1,
			"file size in bytes" : 9329381376,    -- 8.68866 GB
			"minor version number" : 0
		},
	

	
	repl_set:PRIMARY> db.table_t1.stats()
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 17125570526,
		"count" : 10309208,
		"avgObjSize" : 1661,
		"storageSize" : 6717177856,              -- 6.25586 GB
		
		"block-manager" : {
			"allocations requiring file extension" : 374195,
			"blocks allocated" : 584163,
			"blocks freed" : 359732,
			"checkpoint size" : 6443270144,
			"file allocation unit size" : 4096,
			"file bytes available for reuse" : 273891328,  -- 可重复使用的文件字节: 0.255081 GB
			"file magic number" : 120897,
			"file major version number" : 1,
			"file size in bytes" : 6717177856,   -- 6.25586 GB
			"minor version number" : 0
		},
		
	-- 	可重复使用的文件字节明显变少了：从 2.73174 GB 降到了 0.255081 GB
--------------------------------------------------------------------------

5.7 查看副本集从库table_t1集合的stats
	repl_set:SECONDARY> db.table_t1.stats();
	{
		"ns" : "aiuaiu_h5.table_t1",
		"size" : 17350180989,
		"count" : 10442760,
		"avgObjSize" : 1661,
		"storageSize" : 9265397760,
		"capped" : false,
		"wiredTiger" : {
			"metadata" : {
				"formatVersion" : 1
			},
			"creationString" : "access_pattern_hint=none,allocation_size=4KB,app_metadata=(formatVersion=1),assert=(commit_timestamp=none,durable_timestamp=none,read_timestamp=none),block_allocation=best,block_compressor=snappy,cache_resident=false,checksum=on,colgroups=,collator=,columns=,dictionary=0,encryption=(keyid=,name=),exclusive=false,extractor=,format=btree,huffman_key=,huffman_value=,ignore_in_memory_cache_size=false,immutable=false,internal_item_max=0,internal_key_max=0,internal_key_truncate=true,internal_page_max=4KB,key_format=q,key_gap=10,leaf_item_max=0,leaf_key_max=0,leaf_page_max=32KB,leaf_value_max=64MB,log=(enabled=false),lsm=(auto_throttle=true,bloom=true,bloom_bit_count=16,bloom_config=,bloom_hash_count=8,bloom_oldest=false,chunk_count_limit=0,chunk_max=5GB,chunk_size=10MB,merge_custom=(prefix=,start_generation=0,suffix=),merge_max=15,merge_min=0),memory_page_image_max=0,memory_page_max=10m,os_cache_dirty_max=0,os_cache_max=0,prefix_compression=false,prefix_compression_min=4,source=,split_deepen_min_child=0,split_deepen_per_child=0,split_pct=90,type=file,value_format=u",
			"type" : "file",
			"uri" : "statistics:table:collection-0-4882731678886540250",
			"LSM" : {
				"bloom filter false positives" : 0,
				"bloom filter hits" : 0,
				"bloom filter misses" : 0,
				"bloom filter pages evicted from cache" : 0,
				"bloom filter pages read into cache" : 0,
				"bloom filters in the LSM tree" : 0,
				"chunks in the LSM tree" : 0,
				"highest merge generation in the LSM tree" : 0,
				"queries that could have benefited from a Bloom filter that did not exist" : 0,
				"sleep for LSM checkpoint throttle" : 0,
				"sleep for LSM merge throttle" : 0,
				"total size of bloom filters" : 0
			},
			"block-manager" : {
				"allocations requiring file extension" : 339227,
				"blocks allocated" : 351824,
				"blocks freed" : 173538,
				"checkpoint size" : 6348529664,
				"file allocation unit size" : 4096,
				"file bytes available for reuse" : 2916851712,
				"file magic number" : 120897,
				"file major version number" : 1,
				"file size in bytes" : 9265397760,
				"minor version number" : 0
			},
			"btree" : {
				"btree checkpoint generation" : 276,
				"column-store fixed-size leaf pages" : 0,
				"column-store internal pages" : 0,
				"column-store variable-size RLE encoded values" : 0,
				"column-store variable-size deleted values" : 0,
				"column-store variable-size leaf pages" : 0,
				"fixed-record size" : 0,
				"maximum internal page key size" : 368,
				"maximum internal page size" : 4096,
				"maximum leaf page key size" : 2867,
				"maximum leaf page size" : 32768,
				"maximum leaf page value size" : 67108864,
				"maximum tree depth" : 5,
				"number of key/value pairs" : 0,
				"overflow pages" : 0,
				"pages rewritten by compaction" : 0,
				"row-store empty values" : 0,
				"row-store internal pages" : 0,
				"row-store leaf pages" : 0
			},
			"cache" : {
				"bytes currently in the cache" : 166550315,
				"bytes dirty in the cache cumulative" : 10876249192,
				"bytes read into cache" : 8303518559,
				"bytes written from cache" : 17867914276,
				"checkpoint blocked page eviction" : 577,
				"data source pages selected for eviction unable to be evicted" : 9324,
				"eviction walk passes of a file" : 94948,
				"eviction walk target pages histogram - 0-9" : 15076,
				"eviction walk target pages histogram - 10-31" : 22522,
				"eviction walk target pages histogram - 128 and higher" : 0,
				"eviction walk target pages histogram - 32-63" : 28199,
				"eviction walk target pages histogram - 64-128" : 29151,
				"eviction walks abandoned" : 205,
				"eviction walks gave up because they restarted their walk twice" : 580,
				"eviction walks gave up because they saw too many pages and found no candidates" : 12592,
				"eviction walks gave up because they saw too many pages and found too few candidates" : 5131,
				"eviction walks reached end of tree" : 19887,
				"eviction walks started from root of tree" : 18512,
				"eviction walks started from saved location in tree" : 76436,
				"hazard pointer blocked page eviction" : 83,
				"in-memory page passed criteria to be split" : 4570,
				"in-memory page splits" : 1926,
				"internal pages evicted" : 4287,
				"internal pages split during eviction" : 33,
				"leaf pages split during eviction" : 3199,
				"modified pages evicted" : 261035,
				"overflow pages read into cache" : 0,
				"page split during eviction deepened the tree" : 0,
				"page written requiring cache overflow records" : 5090,
				"pages read into cache" : 167140,
				"pages read into cache after truncate" : 0,
				"pages read into cache after truncate in prepare state" : 0,
				"pages read into cache requiring cache overflow entries" : 5065,
				"pages requested from the cache" : 74843443,
				"pages seen by eviction walk" : 48488516,
				"pages written from cache" : 351704,
				"pages written requiring in-memory restoration" : 78814,
				"tracked dirty bytes in the cache" : 0,
				"unmodified pages evicted" : 263713
			},
			"cache_walk" : {
				"Average difference between current eviction generation when the page was last considered" : 0,
				"Average on-disk page image size seen" : 0,
				"Average time in cache for pages that have been visited by the eviction server" : 0,
				"Average time in cache for pages that have not been visited by the eviction server" : 0,
				"Clean pages currently in cache" : 0,
				"Current eviction generation" : 0,
				"Dirty pages currently in cache" : 0,
				"Entries in the root page" : 0,
				"Internal pages currently in cache" : 0,
				"Leaf pages currently in cache" : 0,
				"Maximum difference between current eviction generation when the page was last considered" : 0,
				"Maximum page size seen" : 0,
				"Minimum on-disk page image size seen" : 0,
				"Number of pages never visited by eviction server" : 0,
				"On-disk page image sizes smaller than a single allocation unit" : 0,
				"Pages created in memory and never written" : 0,
				"Pages currently queued for eviction" : 0,
				"Pages that could not be queued for eviction" : 0,
				"Refs skipped during cache traversal" : 0,
				"Size of the root page" : 0,
				"Total number of pages currently in cache" : 0
			},
			"compression" : {
				"compressed page maximum internal page size prior to compression" : 4096,
				"compressed page maximum leaf page size prior to compression " : 131072,
				"compressed pages read" : 164353,
				"compressed pages written" : 345149,
				"page written failed to compress" : 0,
				"page written was too small to compress" : 6533
			},
			"cursor" : {
				"bulk loaded cursor insert calls" : 0,
				"cache cursors reuse count" : 757492,
				"close calls that result in cache" : 0,
				"create calls" : 157,
				"insert calls" : 10407857,
				"insert key and value bytes" : 17369161482,
				"modify" : 0,
				"modify key and value bytes affected" : 0,
				"modify value bytes modified" : 0,
				"next calls" : 1,
				"open cursor count" : 0,
				"operation restarted" : 109906,
				"prev calls" : 1,
				"remove calls" : 4830252,
				"remove key bytes removed" : 19263885,
				"reserve calls" : 0,
				"reset calls" : 21323729,
				"search calls" : 14340129,
				"search near calls" : 0,
				"truncate calls" : 0,
				"update calls" : 0,
				"update key and value bytes" : 0,
				"update value size change" : 0
			},
			"reconciliation" : {
				"dictionary matches" : 0,
				"fast-path pages deleted" : 0,
				"internal page key bytes discarded using suffix compression" : 666886,
				"internal page multi-block writes" : 95,
				"internal-page overflow keys" : 0,
				"leaf page key bytes discarded using prefix compression" : 0,
				"leaf page multi-block writes" : 3236,
				"leaf-page overflow keys" : 0,
				"maximum blocks required for a page" : 1,
				"overflow values written" : 0,
				"page checksum matches" : 663,
				"page reconciliation calls" : 275944,
				"page reconciliation calls for eviction" : 266302,
				"pages deleted" : 166519
			},
			"session" : {
				"object compaction" : 0
			},
			"transaction" : {
				"update conflicts" : 0
			}
		},
		"nindexes" : 3,
		"indexBuilds" : [ ],
		"totalIndexSize" : 684670976,
		"indexSizes" : {
			"_id_" : 175722496,
			"szToken_1" : 402329600,
			"CreateTime_1" : 106618880
		},
		"scaleFactor" : 1,
		"ok" : 1,
		"$clusterTime" : {
			"clusterTime" : Timestamp(1595489170, 1),
			"signature" : {
				"hash" : BinData(0,"EufAoWYHIFgCxu+KtSp1LTGk5SI="),
				"keyId" : NumberLong("6838881995993382915")
			}
		},
		"operationTime" : Timestamp(1595489170, 1)
	}


------------------------------------------------------------------------------------------------------------


6. 小结

	1. remove 会产生逻辑的空闲空间，这些空间能立即用于写入新数据，但文件占用的总物理空间不会立即回收；
	
	2. 如何查看碎片空间的大小
		
		观察 block-manager.file bytes available for reuse 指标就知道碎片空间的大小了。
		
	3. compact 的加锁：
	
		一个集合，会加集合所在DB的互斥写锁，会导致该DB上所有的读写请求都阻塞；
		因为 compact 执行的时间可能很长，跟集合的数据量相关，所以强烈建议在业务低峰期执行，避免影响业务。  --已验证。
	
	4. compact 命令不会复制到副本集中的辅助副本，在副本集主库执行 compact，需要加 force 选项

		repl_set:PRIMARY> db.runCommand({compact: "table_t1"})
		{
			"ok" : 0,
			"errmsg" : "will not run compact on an active replica set primary as this is a slow blocking operation. use force:true to force",
			"$clusterTime" : {
				"clusterTime" : Timestamp(1595489290, 1),
				"signature" : {
					"hash" : BinData(0,"UgPuwCvGTB2OqdNnfWQli5AeXWU="),
					"keyId" : NumberLong("6838881995993382915")
				}
			},
			"operationTime" : Timestamp(1595489290, 1)
		}

	
db.table_t1.remove({"CreateTime" : {"$lt" :  ISODate('2020-07-08 00:00:00')}})
