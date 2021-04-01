



transaction_isolation = REPEATABLE-READ
	事务隔离级别参数, 默认为 REPEATABLE-READ(可重复读), 如果业务没有可重复读的场景, 可以改为  读提交 read-committed(读已提交)
	REPEATABLE-READ(可重复读) 的 gap-lock(间隙锁) 影响并发度, 并且死锁的概率更高.
	
	
	
InnoDB参数:
	innodb_buffer_pool_dump_pct  = 25
		只能预热 25% 的LRU列表中的数据页; 有点少了;
		实际上遇到过在 MySQL 5.7 中, 数据库进行正常的关闭/启动后, innodb_buffer_pool_dump_pct = 25 的场景下, 在 预热 完成一段时间后 ,
		BP缓冲池的查询命中率会下降到 95%.
		
	innodb_buffer_pool_size = 128MB
	innodb_rollback_on_timeout = OFF
	innodb_print_all_deadlocks = OFF
	innodb_data_file_path = ibdata1:12MB:autoextend
	innodb_log_file_size = 48 MB
	innodb_temp_data_file_path = ibtmp1:12M:autoextend
		例如 可以改为 innodb_temp_data_file_path = ibtmp1:64M:autoextend:max:5G 

	innodb_io_capacity = 200
		用于告诉InnoDB所在主机的磁盘IO能力, 用于控制每次刷多少脏页到磁盘
		建议设置磁盘的IOPS
		
	
	explicit_defaults_for_timestamp=OFF
		

	