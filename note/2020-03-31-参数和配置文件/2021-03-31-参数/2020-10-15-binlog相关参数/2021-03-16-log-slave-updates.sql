
log-slave-updates：
	表示备库执行 relay log后生成binlog.


为什么要启用log-slave-updates参数
	从库做为其他从库的主库时 log-slave-updates参数是必须要添加的，该参数就是为了让从库从主库复制数据时可以写入到binlog日志，为什么要用这个参数写binlog日志呢，不是在配置文件中开启log-bin  = /data/3307/mysql-bin选项就可以吗？

	答：从库开启log-bin参数，如果直接往从库写数据，是可以记录log-bin日志的，但是从库通过I0线程读取主库二进制日志文件，然后通过SQL线程写入数据的过程，是不会记录binlog日志的。也就是说从库从主库上复制的数据，是不写入从库的binlog日志的。
		所以从库做为其他从库的主库时需要在配置文件中添加log-slave-updates参数。
	
	 
