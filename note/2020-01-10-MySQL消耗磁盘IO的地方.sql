



消耗磁盘IO的地方:
	各种刷盘操作: 
		binlog 刷盘, redo log 刷盘, 脏页刷盘
		
	从库的relay log刷盘
	
	
	
	
	
	
MySQL中主要的IO读写包括：
	
	Binlog写操作

	Redo写操作

	InnoDB数据页的写操作(脏页刷盘)

	InnoDB数据页的Double Write

	InnoDB数据页的读操作
	
	
	InnoDB的读写信息可以从information_schema.innodb_metrics中查询到。
		
		buffer_data_written是包括redo在内的所有写的总和

		os_log_bytes_written是Redo记录的数据量

		log_padded是Redo write ahead多写部分，无效数据量。

		innodb_dblwr_page_written是double write的数据量。脏页的数据量和double write是一样的。