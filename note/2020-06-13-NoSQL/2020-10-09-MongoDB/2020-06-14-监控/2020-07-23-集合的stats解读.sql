


https://docs.mongodb.com/manual/reference/method/db.stats/
https://docs.mongodb.com/manual/reference/method/db.collection.stats/


模块：
	LSM
	block-manager
	btree
	cache
		MySQL: sys.innodb_buffer_stats_by_table
	cache_walk
	compression
	cursor
	reconciliation
	session
	transaction


repl_set:PRIMARY> db.table_t1.stats()
{
	"ns" : "mon_db.table_t1",
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
			"maximum internal page key size" : 368,  	-- 最大内节点页的键大小
			"maximum internal page size" : 4096,    	-- 最大内节点页的页面大小
			
			"maximum leaf page key size" : 2867,    	-- 叶子节点页
			"maximum leaf page size" : 32768,        	-- 叶子节点页
			"maximum leaf page value size" : 67108864, 	-- 叶子节点页
			
			"maximum tree depth" : 5,
			"number of key/value pairs" : 0,
			"overflow pages" : 0,
			"pages rewritten by compaction" : 0,
			"row-store empty values" : 0,
			"row-store internal pages" : 0,
			"row-store leaf pages" : 0
		},
		
		/*
		"btree" : {
			"btree checkpoint generation" : 55304,
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
		
		"btree" : {
			"btree checkpoint generation" : 55307,
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
		
		-- btree模块中的指标没有什么意义。
		
		*/
		
		
		
		"cache" : {
			"bytes currently in the cache" : 865205785,   -- 当前在缓存中的字节大小
			"bytes dirty in the cache cumulative" : 933170045,  -- 缓存中累积的脏数据的字节大小
			"bytes read into cache" : 81671151280,   -- 从缓存中读取的字节大小
			"bytes written from cache" : 17468219091,  --写入缓存中的字节大小
			"checkpoint blocked page eviction" : 752,  --从缓存中淘汰的数据页个数
			"data source pages selected for eviction unable to be evicted" : 3539,   --无法逐出选定要逐出的数据源页  选择驱逐的数据源页面无法驱逐
			
			"eviction walk passes of a file" : 68906,   -- 逐出文件
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
			"pages read into cache" : 1615291,  --读入缓存的页面数
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
		
		/*
		
		"cache" : {
			"bytes currently in the cache" : 4847314217,   -- 4.5 GB
			"bytes dirty in the cache cumulative" : 118518143890,
			"bytes read into cache" : 332979272477,   -- 310 GB
			"bytes written from cache" : 219425488730,  -- 204 GB
			"checkpoint blocked page eviction" : 0,
			"data source pages selected for eviction unable to be evicted" : 2981,
			"eviction walk passes of a file" : 162496,
			"eviction walk target pages histogram - 0-9" : 10099,
			"eviction walk target pages histogram - 10-31" : 23616,
			"eviction walk target pages histogram - 128 and higher" : 0,
			"eviction walk target pages histogram - 32-63" : 34558,
			"eviction walk target pages histogram - 64-128" : 94223,
			"eviction walks abandoned" : 24072,
			"eviction walks gave up because they restarted their walk twice" : 0,
			"eviction walks gave up because they saw too many pages and found no candidates" : 2081,
			"eviction walks gave up because they saw too many pages and found too few candidates" : 915,
			"eviction walks reached end of tree" : 18195,
			"eviction walks started from root of tree" : 27072,
			"eviction walks started from saved location in tree" : 135424,
			"hazard pointer blocked page eviction" : 244,
			"in-memory page passed criteria to be split" : 1678,
			"in-memory page splits" : 834,
			"internal pages evicted" : 45077,
			"internal pages split during eviction" : 13,
			"leaf pages split during eviction" : 1177,
			"modified pages evicted" : 187827,
			"overflow pages read into cache" : 0,
			"page split during eviction deepened the tree" : 0,
			"page written requiring cache overflow records" : 0,
			"pages read into cache" : 7439853,
			"pages read into cache after truncate" : 0,
			"pages read into cache after truncate in prepare state" : 0,
			"pages read into cache requiring cache overflow entries" : 0,
			"pages requested from the cache" : 68275244,
			"pages seen by eviction walk" : 15771724,
			"pages written from cache" : 4597362,
			"pages written requiring in-memory restoration" : 1021,
			"tracked dirty bytes in the cache" : 4515700,
			"unmodified pages evicted" : 7162547
		},

		"cache" : {
			"bytes currently in the cache" : 288371018,
			"bytes dirty in the cache cumulative" : 128349663984,
			"bytes read into cache" : 252297210296,
			"bytes written from cache" : 11547099953,
			"checkpoint blocked page eviction" : 0,
			"data source pages selected for eviction unable to be evicted" : 545,
			"eviction walk passes of a file" : 117616,
			"eviction walk target pages histogram - 0-9" : 13197,
			"eviction walk target pages histogram - 10-31" : 37270,
			"eviction walk target pages histogram - 128 and higher" : 0,
			"eviction walk target pages histogram - 32-63" : 36639,
			"eviction walk target pages histogram - 64-128" : 30510,
			"eviction walks abandoned" : 25236,
			"eviction walks gave up because they restarted their walk twice" : 257,
			"eviction walks gave up because they saw too many pages and found no candidates" : 2242,
			"eviction walks gave up because they saw too many pages and found too few candidates" : 714,
			"eviction walks reached end of tree" : 21811,
			"eviction walks started from root of tree" : 28456,
			"eviction walks started from saved location in tree" : 89160,
			"hazard pointer blocked page eviction" : 112,
			"in-memory page passed criteria to be split" : 1219,
			"in-memory page splits" : 577,
			"internal pages evicted" : 16310,
			"internal pages split during eviction" : 3,
			"leaf pages split during eviction" : 2163,
			"modified pages evicted" : 55870,
			"overflow pages read into cache" : 0,
			"page split during eviction deepened the tree" : 0,
			"page written requiring cache overflow records" : 0,
			"pages read into cache" : 2168476,
			"pages read into cache after truncate" : 0,
			"pages read into cache after truncate in prepare state" : 0,
			"pages read into cache requiring cache overflow entries" : 0,
			"pages requested from the cache" : 130599824,
			"pages seen by eviction walk" : 9216940,
			"pages written from cache" : 282287,
			"pages written requiring in-memory restoration" : 5549,
			"tracked dirty bytes in the cache" : 5353214,
			"unmodified pages evicted" : 2119474
		},

		
		
		*/
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


