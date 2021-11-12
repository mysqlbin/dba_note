
innodb_lru_scan_depth 是用来控制LRU刷脏的，有2个含义：
	
	默认值为 1024 
	
	innodb_lru_scan_depth 表示 innodb lru列表扫描的深度
	
	当Buffer Pool的Free list的 Page数量小于innodb_lru_scan_depth时，才进行LRU刷脏

	每次LRU刷脏，扫描的页数不超过 innodb_lru_scan_depth 个。
		
	 
相关参考
	
	https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth
	 
	https://mp.weixin.qq.com/s/i0sIfUqUUX5c_GkFTYh64Q   
	
	https://www.cnblogs.com/zengkefu/p/5692803.html

	《2020-10-27-InnoDB buffer pool缓冲池的重新学习和整理》