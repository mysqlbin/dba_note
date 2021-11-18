
MySQL：
	主动发送binlog给从库
	日志：binlog
	
MongoDB：
	
	从库主动拉取oplog，只拉取大于自己当前oplog最新时间戳的oplog记录
	日志：oplog
	
Redis：
	直接发送在主库执行的命令给从库
	