
rebuild table：重建表； 
	添加、删除字段； 
	
no rebuild table：
	添加、删除索引； 
	


在一些需要 rebuild table 的 Online DDL 操作中，例如Dropping a column, 为了不阻塞 DML 操作，需要引入row_log来暂存在 DDL 过程中用户的数据修改操作; 
在二级索引的创建过程中并不需要 rebuild table, 所以不需要row_log, 用户对于数据的修改可以直接基于聚簇索引进行修改.