
1. 造成主从不一致的主要原因
	1. binlog_format 参数设置为 statement 
	2. 从库未设置只读，误操作写入数据
	3. 主库上的参数：sync_binlog 和 innodb_flush_log_at_trx_commit 未设置双1
	4. 主库执行更改前有执行set_sql_bin=0, 会使主库不记录binlog，从库也无法变更这部分数据
	5. 主从表的存储引擎或者 row_format 行记录格式不一样
	
2. 如何避免主从不一致
	1. binlog_format 参数设置为 row
	2. 从库设置只读
	3. 主库上的参数：sync_binlog 和 innodb_flush_log_at_trx_commit 设置双1
	4. 主库做好账户权限把控，不可以执行set sql_log_bin=0
	5. 主从表的存储引擎或者 row_format 行记录格式要一样
	
3. 修复主从数据不一致的办法
	1. pt-table-checksum 
	2. 将从库重新实现
	
	
	
	
	
