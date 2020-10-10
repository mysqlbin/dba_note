
1. 查看集合的大小
2. 查看数据库的大小


1. 查看集合的大小

> db.table_clubgamescorerobotdetail.stats(); 
{
	"ns" : "aiuaiuh5_modb.table_clubgamescorerobotdetail",  -- 集合的命名空间
	"size" : 12011032377,  -- 集合占用磁盘空间的大小
	"count" : 27497094,    -- 集合中文档的数目
	"avgObjSize" : 436,    -- 集合中平均对象大小
	"storageSize" : 2967015424,   -- 实际数据的大小
	"capped" : false,
	"wiredTiger" : {
		"metadata" : {
			"formatVersion" : 1
		},
		"creationString" : "access_pattern_hint=none,allocation_size=4KB,app_metadata=(formatVersion=1),assert=(commit_timestamp=none,durable_timestamp=none,read_timestamp=none),block_allocation=best,block_compressor=snappy,cache_resident=false,checksum=on,colgroups=,collator=,columns=,dictionary=0,encryption=(keyid=,name=),exclusive=false,extractor=,format=btree,huffman_key=,huffman_value=,ignore_in_memory_cache_size=false,immutable=false,internal_item_max=0,internal_key_max=0,internal_key_truncate=true,internal_page_max=4KB,key_format=q,key_gap=10,leaf_item_max=0,leaf_key_max=0,leaf_page_max=32KB,leaf_value_max=64MB,log=(enabled=true),lsm=(auto_throttle=true,bloom=true,bloom_bit_count=16,bloom_config=,bloom_hash_count=8,bloom_oldest=false,chunk_count_limit=0,chunk_max=5GB,chunk_size=10MB,merge_custom=(prefix=,start_generation=0,suffix=),merge_max=15,merge_min=0),memory_page_image_max=0,memory_page_max=10m,os_cache_dirty_max=0,os_cache_max=0,prefix_compression=false,prefix_compression_min=4,source=,split_deepen_min_child=0,split_deepen_per_child=0,split_pct=90,type=file,value_format=u",
		"type" : "file",
		"uri" : "statistics:table:collection-26-7115895475211548380",
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
			"allocations requiring file extension" : 105365,
			"blocks allocated" : 105630,
			"blocks freed" : 448,
			"checkpoint size" : 2966814720,
			"file allocation unit size" : 4096,
			"file bytes available for reuse" : 184320,
			"file magic number" : 120897,
			"file major version number" : 1,
			"file size in bytes" : 2967015424,
			"minor version number" : 0
		},
		"btree" : {
			"btree checkpoint generation" : 194,
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
			"maximum tree depth" : 4,
			"number of key/value pairs" : 0,
			"overflow pages" : 0,
			"pages rewritten by compaction" : 0,
			"row-store empty values" : 0,
			"row-store internal pages" : 0,
			"row-store leaf pages" : 0
		},
		"cache" : {
			"bytes currently in the cache" : 3720836503,
			"bytes dirty in the cache cumulative" : 20186181,
			"bytes read into cache" : 33352143870,
			"bytes written from cache" : 12254476429,
			"checkpoint blocked page eviction" : 0,
			"data source pages selected for eviction unable to be evicted" : 105,
			"eviction walk passes of a file" : 28424,
			"eviction walk target pages histogram - 0-9" : 1468,
			"eviction walk target pages histogram - 10-31" : 3761,
			"eviction walk target pages histogram - 128 and higher" : 0,
			"eviction walk target pages histogram - 32-63" : 5268,
			"eviction walk target pages histogram - 64-128" : 17927,
			"eviction walks abandoned" : 511,
			"eviction walks gave up because they restarted their walk twice" : 9,
			"eviction walks gave up because they saw too many pages and found no candidates" : 1256,
			"eviction walks gave up because they saw too many pages and found too few candidates" : 351,
			"eviction walks reached end of tree" : 1302,
			"eviction walks started from root of tree" : 2127,
			"eviction walks started from saved location in tree" : 26297,
			"hazard pointer blocked page eviction" : 14,
			"in-memory page passed criteria to be split" : 3550,
			"in-memory page splits" : 1689,
			"internal pages evicted" : 238,
			"internal pages split during eviction" : 10,
			"leaf pages split during eviction" : 1736,
			"modified pages evicted" : 1903,
			"overflow pages read into cache" : 0,
			"page split during eviction deepened the tree" : 1,
			"page written requiring cache overflow records" : 0,
			"pages read into cache" : 283722,
			"pages read into cache after truncate" : 1,
			"pages read into cache after truncate in prepare state" : 0,
			"pages read into cache requiring cache overflow entries" : 0,
			"pages requested from the cache" : 53078341,
			"pages seen by eviction walk" : 8862666,
			"pages written from cache" : 105584,
			"pages written requiring in-memory restoration" : 14,
			"tracked dirty bytes in the cache" : 0,
			"unmodified pages evicted" : 352425
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
			"compressed pages read" : 283525,
			"compressed pages written" : 104155,
			"page written failed to compress" : 0,
			"page written was too small to compress" : 1428
		},
		"cursor" : {
			"bulk loaded cursor insert calls" : 0,
			"cache cursors reuse count" : 440684,
			"close calls that result in cache" : 0,
			"create calls" : 7,
			"insert calls" : 27497094,
			"insert key and value bytes" : 12131650011,
			"modify" : 0,
			"modify key and value bytes affected" : 0,
			"modify value bytes modified" : 0,
			"next calls" : 82566801,
			"open cursor count" : 0,
			"operation restarted" : 0,
			"prev calls" : 1,
			"remove calls" : 0,
			"remove key bytes removed" : 0,
			"reserve calls" : 0,
			"reset calls" : 1530168,
			"search calls" : 0,
			"search near calls" : 648787,
			"truncate calls" : 0,
			"update calls" : 0,
			"update key and value bytes" : 0,
			"update value size change" : 0
		},
		"reconciliation" : {
			"dictionary matches" : 0,
			"fast-path pages deleted" : 0,
			"internal page key bytes discarded using suffix compression" : 207648,
			"internal page multi-block writes" : 48,
			"internal-page overflow keys" : 0,
			"leaf page key bytes discarded using prefix compression" : 0,
			"leaf page multi-block writes" : 1753,
			"leaf-page overflow keys" : 0,
			"maximum blocks required for a page" : 1,
			"overflow values written" : 0,
			"page checksum matches" : 699,
			"page reconciliation calls" : 2869,
			"page reconciliation calls for eviction" : 1695,
			"pages deleted" : 57
		},
		"session" : {
			"object compaction" : 0
		},
		"transaction" : {
			"update conflicts" : 0
		}
	},
	"nindexes" : 3,    -- 索引的个数
	"indexBuilds" : [ ],
	"totalIndexSize" : 1031749632,  -- 总索引的大小
	"indexSizes" : {
		"_id_" : 280039424,         -- _id_ 索引的大小
		"szToken_1" : 565379072,    -- szToken 索引的大小
		"tEndTime_1" : 186331136    -- tEndTime 索引的大小 
	},
	"scaleFactor" : 1,
	"ok" : 1
}


> db.table_clubgamelog.stats();
{
	"ns" : "aiuaiuh5_modb.table_clubgamelog",
	"size" : 8166278793,
	"count" : 5126153,
	"avgObjSize" : 1593,
	"storageSize" : 2909122560,
	"capped" : false,
	"wiredTiger" : {
		"metadata" : {
			"formatVersion" : 1
		},
		"creationString" : "access_pattern_hint=none,allocation_size=4KB,app_metadata=(formatVersion=1),assert=(commit_timestamp=none,durable_timestamp=none,read_timestamp=none),block_allocation=best,block_compressor=snappy,cache_resident=false,checksum=on,colgroups=,collator=,columns=,dictionary=0,encryption=(keyid=,name=),exclusive=false,extractor=,format=btree,huffman_key=,huffman_value=,ignore_in_memory_cache_size=false,immutable=false,internal_item_max=0,internal_key_max=0,internal_key_truncate=true,internal_page_max=4KB,key_format=q,key_gap=10,leaf_item_max=0,leaf_key_max=0,leaf_page_max=32KB,leaf_value_max=64MB,log=(enabled=true),lsm=(auto_throttle=true,bloom=true,bloom_bit_count=16,bloom_config=,bloom_hash_count=8,bloom_oldest=false,chunk_count_limit=0,chunk_max=5GB,chunk_size=10MB,merge_custom=(prefix=,start_generation=0,suffix=),merge_max=15,merge_min=0),memory_page_image_max=0,memory_page_max=10m,os_cache_dirty_max=0,os_cache_max=0,prefix_compression=false,prefix_compression_min=4,source=,split_deepen_min_child=0,split_deepen_per_child=0,split_pct=90,type=file,value_format=u",
		"type" : "file",
		"uri" : "statistics:table:collection-14-7115895475211548380",
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
			"allocations requiring file extension" : 143191,
			"blocks allocated" : 143766,
			"blocks freed" : 1117,
			"checkpoint size" : 2907537408,
			"file allocation unit size" : 4096,
			"file bytes available for reuse" : 1568768,
			"file magic number" : 120897,
			"file major version number" : 1,
			"file size in bytes" : 2909122560,
			"minor version number" : 0
		},
		"btree" : {
			"btree checkpoint generation" : 194,
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
			"maximum tree depth" : 4,
			"number of key/value pairs" : 0,
			"overflow pages" : 0,
			"pages rewritten by compaction" : 0,
			"row-store empty values" : 0,
			"row-store internal pages" : 0,
			"row-store leaf pages" : 0
		},
		"cache" : {
			"bytes currently in the cache" : 2283370252,
			"bytes dirty in the cache cumulative" : 19999229,
			"bytes read into cache" : 13282605877,
			"bytes written from cache" : 8243206645,
			"checkpoint blocked page eviction" : 0,
			"data source pages selected for eviction unable to be evicted" : 56,
			"eviction walk passes of a file" : 17382,
			"eviction walk target pages histogram - 0-9" : 2901,
			"eviction walk target pages histogram - 10-31" : 4511,
			"eviction walk target pages histogram - 128 and higher" : 0,
			"eviction walk target pages histogram - 32-63" : 3822,
			"eviction walk target pages histogram - 64-128" : 6148,
			"eviction walks abandoned" : 987,
			"eviction walks gave up because they restarted their walk twice" : 155,
			"eviction walks gave up because they saw too many pages and found no candidates" : 1792,
			"eviction walks gave up because they saw too many pages and found too few candidates" : 100,
			"eviction walks reached end of tree" : 2816,
			"eviction walks started from root of tree" : 3035,
			"eviction walks started from saved location in tree" : 14347,
			"hazard pointer blocked page eviction" : 19,
			"in-memory page passed criteria to be split" : 2120,
			"in-memory page splits" : 1024,
			"internal pages evicted" : 1763,
			"internal pages split during eviction" : 12,
			"leaf pages split during eviction" : 1037,
			"modified pages evicted" : 2223,
			"overflow pages read into cache" : 0,
			"page split during eviction deepened the tree" : 1,
			"page written requiring cache overflow records" : 0,
			"pages read into cache" : 225629,
			"pages read into cache after truncate" : 1,
			"pages read into cache after truncate in prepare state" : 0,
			"pages read into cache requiring cache overflow entries" : 0,
			"pages requested from the cache" : 10380385,
			"pages seen by eviction walk" : 2391617,
			"pages written from cache" : 143718,
			"pages written requiring in-memory restoration" : 0,
			"tracked dirty bytes in the cache" : 0,
			"unmodified pages evicted" : 309805
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
			"compressed pages read" : 224085,
			"compressed pages written" : 141998,
			"page written failed to compress" : 0,
			"page written was too small to compress" : 1702
		},
		"cursor" : {
			"bulk loaded cursor insert calls" : 0,
			"cache cursors reuse count" : 82509,
			"close calls that result in cache" : 0,
			"create calls" : 12,
			"insert calls" : 5126153,
			"insert key and value bytes" : 8186701040,
			"modify" : 0,
			"modify key and value bytes affected" : 0,
			"modify value bytes modified" : 0,
			"next calls" : 11752524,
			"open cursor count" : 0,
			"operation restarted" : 0,
			"prev calls" : 1,
			"remove calls" : 0,
			"remove key bytes removed" : 0,
			"reserve calls" : 0,
			"reset calls" : 257729,
			"search calls" : 0,
			"search near calls" : 92687,
			"truncate calls" : 0,
			"update calls" : 0,
			"update key and value bytes" : 0,
			"update value size change" : 0
		},
		"reconciliation" : {
			"dictionary matches" : 0,
			"fast-path pages deleted" : 0,
			"internal page key bytes discarded using suffix compression" : 284289,
			"internal page multi-block writes" : 52,
			"internal-page overflow keys" : 0,
			"leaf page key bytes discarded using prefix compression" : 0,
			"leaf page multi-block writes" : 1033,
			"leaf-page overflow keys" : 0,
			"maximum blocks required for a page" : 1,
			"overflow values written" : 0,
			"page checksum matches" : 577,
			"page reconciliation calls" : 2318,
			"page reconciliation calls for eviction" : 973,
			"pages deleted" : 22
		},
		"session" : {
			"object compaction" : 0
		},
		"transaction" : {
			"update conflicts" : 0
		}
	},
	"nindexes" : 3,   -- 索引的个数
	"indexBuilds" : [ ],
	"totalIndexSize" : 314089472,  -- 总索引的大小
	"indexSizes" : {
		"_id_" : 51703808,         -- _id_ 索引的大小
		"szToken_1" : 223526912,   -- szToken 索引的大小
		"tEndTime_1" : 38858752    -- tEndTime 索引的大小
	},
	"scaleFactor" : 1,
	"ok" : 1
}

2. 查看数据库的大小
	 > use aiuaiuh5_modb
	switched to db aiuaiuh5_modb
	> db.stats(1024*1024*1024)
	{
		"db" : "aiuaiuh5_modb",
		"collections" : 2,                    -- 集合数量
		"views" : 0,
		"objects" : 32623247,                 -- 
		"avgObjSize" : 618.4948779010256,
		"dataSize" : 18.791585387662053,      -- 数据占用磁盘空间的大小
		"storageSize" : 5.4725799560546875,   -- 数据的大小，不包含索引的大小
		"numExtents" : 0,
		"indexes" : 6,                        -- 索引的个数
		"indexSize" : 1.2534027099609375,     -- 索引的大小
		"scaleFactor" : 1073741824,
		"fsUsedSize" : 91.74950408935547,
		"fsTotalSize" : 196.7353286743164,
		"ok" : 1
	}

	 
	> db.stats()
	{
		"db" : "aiuaiuh5_modb",
		"collections" : 2,
		"views" : 0,
		"objects" : 32623247,
		"avgObjSize" : 618.4948779010256,
		"dataSize" : 20177311170,
		"storageSize" : 5876137984,
		"numExtents" : 0,
		"indexes" : 6,
		"indexSize" : 1345839104,
		"scaleFactor" : 1,
		"fsUsedSize" : 91768545280,
		"fsTotalSize" : 211242950656,
		"ok" : 1
	}

	> show dbs
	admin          0.000GB
	benet          0.000GB
	config         0.000GB
	local          0.000GB
	aiuaiuh5_modb  6.726GB          -- 数据和索引的大小
		
		

