

6. 相关参数

	缓冲区参数
		binlog_cache_size
		
	物理磁盘参数
		max_binlog_cache_size
			控制 binlog cache 使用的磁盘临时文件能达到的上限
			
		max_binlog_size
			控制单个 binlog 文件大小能达到的上限，超过这个上限就切换binlog到下一个 binlog 来写。
			
			
参考笔记：《13-binlog cache 简介.sql》