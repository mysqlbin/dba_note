

				
			
				
	

思考:
	1. 如何批量 kill show PROCESSLIST.command=sleep&Time最大的100个连接
	
		参考: https://www.cnblogs.com/duhuo/p/5678286.html
		
		
	2. 参数skip-networking 的用法 
		
	

query_rewrite功能:
	insert into query_rewrite.rewrite_rules(pattern, replacement, pattern_database) values ("select * from t where id + 1 = ?", "select * from t where id = ? - 1", "db1");

	call query_rewrite.flush_rewrite_rules();
	