
mysql 内存结构 ：

	mysql使用总内存 = global_buffers + all_thread_buffers
	
	global_buffers ( 全局内存分配总和 ) =

		innodb_buffer_pool_size -- InnoDB高速缓冲，行数据、索引缓冲，以及事务锁、自适应哈希等

		+innodb_additional_mem_pool_size -- InnoDB数据字典额外内存，缓存所有表数据字典

		+innodb_log_buffer_size -- InnoDB REDO日志缓冲，提高REDO日志写入效率

		+key_buffer_size -- MyISAM表索引高速缓冲，提高MyISAM表索引读写效率

		+query_cache_size -- 查询高速缓存，缓存查询结果，提高反复查询返回效率

		+table_cahce -- 表空间文件描述符缓存，提高数据表打开效率

		+table_definition_cache -- 表定义文件描述符缓存，提高数据表打开效率
		
	all_thread_buffers (会话/线程级内存分配总和) =

		max_threads(当前活跃连接数) * (

		read_buffer_size -- 顺序读缓冲，提高顺序读效率

		+read_rnd_buffer_size -- 排序缓冲, 用于存储并排序 MRR优化特性中的主键ID

		+sort_buffer_size -- 排序缓冲，提高排序效率

		+join_buffer_size -- 表连接缓冲，提高表连接效率

		+binlog_cache_size -- 二进制日志缓冲，提高二进制日志写入效率

		+tmp_table_size -- 内存临时表，提高临时表存储效率

		+thread_stack -- 线程堆栈，暂时寄存SQL语句/存储过程

		+thread_cache_size -- 线程缓存，降低多次反复打开线程开销

		+net_buffer_length -- 线程池连接缓冲以及读取结果缓冲

		+bulk_insert_buffer_size ) -- MyISAM表批量写入数据缓冲


https://mp.weixin.qq.com/s/tKODkcvN_Sy322HqqFJAFQ    数据库频频出现OOM问题该如何化解？

