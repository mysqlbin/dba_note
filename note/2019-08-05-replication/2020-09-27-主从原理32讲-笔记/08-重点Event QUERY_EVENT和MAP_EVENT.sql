1. QUERY_EVENT
	1.1 QUERY_EVENT 的作用
	1.2 主体格式
	1.3 生成时机
	
2. MAP_EVENT
	2.1 MAP_EVENT 的作用
	2.2 生成时机
	
1. QUERY_EVENT

	1.1 QUERY_EVENT 的作用
		QUERY_EVENT 不仅会记录一些语句运行的环境比如 SQL_MODE, 客户端字符集, 自增环境设置, 当前登录数据库等, 而且会记录执行时间
		但是对于行模式的DDL和DML记录的执行时间会有所不同, 如下
			DML
				执行时间记录的是第一条数据更改后的时间, 而不是真正本条DML语句执行的时间(因为一个DML语句可能修改很多条数据), 往往这个时间非常短, 
				不能正确的表示DML语句执行的时间. 语句部分记录的是 "BEGIN"
			DDL
				执行时间是实际语句的执行时间, 语句部分记录的是实际的语句
				
	1.2 主体格式
		QUERY_EVENT 包含固定和可变两部分
		固定部分：
			slave_proxy_id 
				4 bytes
				主库生成本 event 的 thread id，它和 show processlist 中的 id 对应
			query_exec_time
				4 bytes
				表示执行时间
				对于行模式的DML语句来讲这个执行时间并不准确, 只记录第一条数据更改消耗的时间
				对于 DDL 语句来讲 是准确的
			db_len
				1 bytes
				用于描述数据库名的长度
			error_code
				2 bytes
				执行语句的错误码
			status_vars_len
				2 bytes
				status variables 部分的长度
			
		可变部分
				
	1.3 生成时机
		1. 对于行模式的DML语句而言，生成时机是事务的第一个DML语句第一行需要修改的数据在 InnoDB 引擎层修改完成后
		   通常来讲一个事务对应一个 QUERY_EVENT
		2. 对于 DDL语句而言，生成时机是在整个操作执行完成之后。
		

2. MAP_EVENT

	2.1 MAP_EVENT 的作用
		MAP_EVENT是行模式特有的，它主要作用是做 table id 和 实际访问表的映射
		同时其中还包含了一些表的定义，如：表所在库名、表名、字段类型、可变字段长度等
		
		每个表都有一个对应的 Table_map event、都会 map 到一个单独的数字，用于区分对不同表的操作。
			--by 24: MySQL主从原理和binlog的3种格式-双M结构的循环复制
			
	2.2 生成时机
		只会在行模式下生成
		生成时机是事务的第一个DML语句第一行需要修改的数据在 InnoDB 引擎层修改完成后， QUERY_EVENT 生成之后
		通常来讲每个语句的每个表(table_list)都会包含这样一个 MAP_EVENT; 
		
		
		

	
	