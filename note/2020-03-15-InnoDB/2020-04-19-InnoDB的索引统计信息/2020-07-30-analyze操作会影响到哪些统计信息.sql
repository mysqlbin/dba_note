

1. 更新 information_schema.tables 的 index_length 和 table_rows 字段值
	
2. 更新 mysql.innodb_table_stats 和 mysql.innodb_index_stats 的表和索引的统计信息
	包括主键索引、所有的二级索引
	先更新聚集索引，再更新二级索引，均调用函数 dict_stats_analyze_index.

	dict_stats_update 
		-> dict_stats_update_persistent
			-> dict_stats_analyze_index
			/* analyze the clustered index first */
			/* analyze other indexes from the table, if any */
				
3. 更新 information_schema.statistics 的信息：
	比如 索引基数字段CARDINALITY
	
4. 小结
	索引统计信息不准确或者说优化器选择的索引并不是最优的， 用 analyze table；

5. 不会回收二级索引的碎片空间。

6. analyze table 操作会写binlog，因此会同步到从库。


	
	
