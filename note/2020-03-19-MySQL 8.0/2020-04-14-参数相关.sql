
1. 新增的参数	
	8.0.1 
		1. binlog_expire_logs_seconds

			参数在版本8.0.1中引入，是可以动态调整的global级参数，8.0.4之前默认值为0，8.0.11之后为2592000也就是30天。
			之前版本binlog自动清理时间以参数expire_logs_days也就是以天为单位，当前两个参数并存并且有一个非0时则以非0的参数为binlog自动清理时间，
			如果两个都为非0值则以binlog_expire_logs_seconds为binlog清理时间忽略expire_logs_days参数设置。
			
		2. binlog_transaction_dependency_history_size

			此参数在版本8.0.1中引入，是可以动态调整的global级参数，默认值为25000，可以设置为0-1000000之间的任意整数。
			8.0基于WriteSet进行并行复制时， WriteSet 是一个hash数组， binlog_transaction_dependency_history_size 值就是这个hash数组的最大值。

		3. binlog_transaction_dependency_tracking

			此参数在8.0.1版本引入，是可以动态调整的global级枚举类型参数，默认值为COMMIT_ORDER，也可以设置为WRITESET、WRITESET_SESSION。
			此参数用于主库决定事务间在从库进行多线程复制的依赖模式。

				 COMMIT_ORDERE：根据主库事务提交时间戳进行并行，也就5.7的GroupCommit；

				 WRITESET：根据WriteSet进行并行，只要是不在同一个队列里的都可以并行；

				 WRITESET_SESSION: 根据WriteSet进行并行，但相同session的事务不会并行。
				 
	8.0.2		 
		1. internal_tmp_mem_storage_engine

			参数在8.0.2版本引入，是可以动态调整的全局、session级枚举类型参数，默认值为TempTable，也可以设置为Memory。
			优化器根据此参数选择内存中内部临时表的引擎类型。

		2. innodb_dedicated_server
			参数在8.0.14版本引入
			可以设置参数 innodb_dedicated_server=ON来让MySQL自动探测服务器的内存资源，确定 innodb_buffer_pool_size, innodb_log_file_size 和 innodb_flush_method 三个参数的取值。
			相关参考: https://blog.csdn.net/n88Lpo/article/details/83005892  MySQL 8.0 首个自适应参数横空出世
			
	
2. 移除和不可设置的参数
	1. 关闭 query cache: 
		故没有 query_cache_size, query_cache_type 这两个参数

	2. internal_tmp_disk_storage_engine:
		在新版本中，临时表的存储引擎默认使用innodb，故 internal_tmp_disk_storage_engine 已经被移除。
	
	3. innodb_undo_tablespaces = 95
		默认为2, 可以动态添加undo 表空间的数量
		
	4. innodb_locks_unsafe_for_binlog
		root@mysqldb 10:43:  [sbtest]> show global variables like '%innodb_locks_unsafe_for_binlog%';
		Empty set (0.00 sec)
	
	5. myisam存储引擎模块
		show global VARIABLES like '%myisam%'
		
		
		
3. 事务隔离级别参数
	root@mysqldb 10:59:  [zst]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)
	
	root@mysqldb 11:01:  [zst]> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.00 sec)

	tx_isolation 改为 transaction_isolation
	