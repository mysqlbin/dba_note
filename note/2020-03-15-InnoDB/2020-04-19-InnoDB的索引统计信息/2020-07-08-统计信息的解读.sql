
5. mysql.innodb_index_stats 的解读	
6. 小结



5. mysql.innodb_index_stats 的解读	
	stat_name=size ：        stat_value 表示 索引的页的数量（Number of pages in the index）
	stat_name=n_leaf_pages ：stat_value 表示 叶子节点的数量（Number of leaf pages in the index）
	stat_name=n_diff_pfxNN ：stat_value 表示 索引字段上唯一值的数量
	
	具体说明：
	1. n_diff_pfx01 表示索引第一列 distinct 之后的数量
		如PRIMARY的ID列，index_name='PRIMARY' and stat_name='n_diff_pfx01'时，stat_value=6
			
	2. n_diff_pfx02 表示索引前两列 distinct 之后的数量
		如 idx_t1_t2 的 t1,t2 列 有 5 个值
		所以index_name='idx_t1_t2' and stat_name='n_diff_pfx02'时，stat_value=5

	3. n_diff_pfx03 表示索引前两个列+主键索引列 distinct 之后的数量
		如 idx_t1_t2 的 t1,t2,ID 列，有 6 个值
		
	4. n_diff_pfx 表示索引列不同值的个数
	

6. 小结
	了解了 stat_name 和 stat_value 的具体含义，就可以协助我们排查SQL执行时为什么没有使用合适的索引:
	例如某个索引 n_diff_pfxNN 的 stat_value 远小于实际值，查询优化器认为该索引选择度较差，就有可能导致使用错误的索引。
	通过 innodb_index_stats 表信息获取联合索引的distinct之后的数量, 跟主键的distinct之后的数量做对比, 获取判断这个联合索引的区分度
	
	新增一行记录之后的20秒内，本案例的统计信息都没有自动更新，说明统计信息会有一定的延迟。
	
	
	