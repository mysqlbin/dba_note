	
问题：

	支持 join 查询不
	
	支持分页不
	
	需要创建索引不
		支持二级索引
		
	数据结构
		
	分区？
		CREATE TABLE lineorder_flat
		ENGINE = MergeTree
		PARTITION BY toYear(LO_ORDERDATE)
		ORDER BY (LO_ORDERDATE, LO_ORDERKEY) AS