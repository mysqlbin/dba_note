



同步刷脏导致性能抖动
	
	同步刷脏会导致瞬间的大量IO，导致性能的抖动，如下图所示。用户可以通过 innodb_flush_sync 参数控制是否要开启同步刷脏功能。
	
	
	根据InnoDB的性能监控信息可以看出是由于 Modified Age 超过 max_modified_age_sync 而导致的同步刷脏。
	
	
	https://mp.weixin.qq.com/s/i0sIfUqUUX5c_GkFTYh64Q  InnoDB的刷脏机制

