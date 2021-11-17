

alter_stats_norebuild  D:\mysqlbin\mysql_source_code\mysql-5.7.26\storage\innobase\handler\handler0alter.cc
	-> dict_stats_drop_index  D:\mysqlbin\mysql_source_code\mysql-5.7.26\storage\innobase\dict\dict0stats.cc
	  
	
dict_stats_drop_index	
	-- 从系统表mysql/innodb_index_stats中删除索引的统计信息
	ret = dict_stats_exec_sql(
		pinfo,
		"PROCEDURE DROP_INDEX_STATS () IS\n"
		"BEGIN\n"
		"DELETE FROM \"" INDEX_STATS_NAME "\" WHERE\n"
		"database_name = :database_name AND\n"
		"table_name = :table_name AND\n"
		"index_name = :index_name;\n"
		"END;\n", NULL);
		
		
		