

shell> date
Thu Aug 13 15:54:55 CST 2020

shell> ls
-rwxr-xr--  1 mysql mysql        112 Aug 13 15:52 mysql-error.log
-rwxr-xr--  1 mysql mysql       6106 Jun 12 06:33 mysql-error.log-20200612
-rwxr-xr--  1 mysql mysql       5760 Jun 13 04:43 mysql-error.log-20200613
-rwxr-xr--  1 mysql mysql       5760 Jun 14 03:51 mysql-error.log-20200614
-rwxr-xr--  1 mysql mysql       5760 Jun 15 05:47 mysql-error.log-20200615
-rwxr-xr--  1 mysql mysql       5760 Jun 16 04:46 mysql-error.log-20200616
-rwxr-xr--  1 mysql mysql       6279 Jun 17 06:13 mysql-error.log-20200617
-rwxr-xr--  1 mysql mysql       6569 Jun 18 09:19 mysql-error.log-20200618
-rwxr-xr--  1 mysql mysql       5732 Jun 19 03:46 mysql-error.log-20200619
-rwxr-xr--  1 mysql mysql       4812 Jun 20 06:10 mysql-error.log-20200620


	可以发现，有差不多2个月的错误日志丢失了，也就是产生的错误日志写入到mysql-error.log中失败了。



shell> cat mysql_error 
/data_volume/mysql/mysql-error.log {
    daily
    rotate 10
    dateext
    nocompress
    delaycompress
    missingok
    #notifempty
	create
	copytruncate 
}

	-- 按天切割MySQL 错误日志文件

解决办法：
	1. 重启MySQL 
	2. 执行 flush logs; 命令
	
	
	
https://dev.mysql.com/doc/refman/5.7/en/flush.html#flush-logs

Closes and reopens any log file to which the server is writing. 
If binary logging is enabled, the sequence number of the binary log file is incremented by one relative to the previous file. 
If relay logging is enabled, the sequence number of the relay log file is incremented by one relative to the previous file.
	关闭并重新打开服务器正在写入的任何日志文件。 
	如果启用了二进制日志记录，则二进制日志文件的序列号将相对于前一个文件增加一个。
	如果启用了中继日志记录，则中继日志文件的序列号将相对于前一个文件增加一个。

	
FLUSH LOGS has no effect on tables used for the general query log or for the slow query log (see Section 5.4.1, “Selecting General Query Log and Slow Query Log Output Destinations”).

	FLUSH LOGS对用于常规查询日志或慢速查询日志的表没有影响（请参见第5.4.1节“选择常规查询日志和慢速查询日志输出目的地”）。
	
	