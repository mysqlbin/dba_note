
1. 数据恢复相关的知识点
	在从库做备份的节点，要有binlog，也就是开启 log_slave_updates 参数。
	
	通过全备+binlog恢复数据，备份所在的从库作为主库进行数据恢复。
	
	
	
	