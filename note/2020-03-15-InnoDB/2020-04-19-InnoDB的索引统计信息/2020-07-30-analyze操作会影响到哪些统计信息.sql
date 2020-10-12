

1. 更新 information_schema.tables 的 index_length 字段值：
	analyze table 会更新 information_schema.tables 中的 index_length 字段值
	
2. 更新 mysql.innodb_table_stats 和 mysql.innodb_index_stats 的表和索引的统计信息

3. 更新 information_schema.statistics 的信息：
	比如 索引基数字段CARDINALITY
	
4. analyze table命令只对二级索引有效。
	如果需要对主键索引有效，那就需要重建表了。
	
5. 小结
	索引统计信息不准确或者说优化器选择的索引并不是最优的， 用 analyze table；

	
	
