


内存使用
	称为 internal Cache	
	由参数 wiredTigerCacheSizeGB 控制内部内存的大小
	通过WiredTiger，MongoDB可以利用WiredTiger内部缓存和文件系统缓存。
	从MongoDB 3.4开始，默认的WiredTiger内部缓存大小是以下两者中的较大者：
		50％（RAM-1 GB）或256 MB。
		例如，在总共有4GB RAM的系统上，WiredTiger缓存将使用1.5GB RAM（0.5 *（4 GB-1 GB）= 1.5 GB）。
		相反，总内存为1.25 GB的系统将为WiredTiger缓存分配256 MB，因为这是总RAM的一半以上减去一GB（0.5 *（1.25 GB-1 GB）= 128 MB <256 MB） 。
		
		wiredTigerCacheSizeGB=10
		
	此内存用于缓存工作集数据（索引、namespace，未提交的write，query缓冲等）
	
	MongoDB 不宜与 MySQL 部署在同一个机器上。
	
	