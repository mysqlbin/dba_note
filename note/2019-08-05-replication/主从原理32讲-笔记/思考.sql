

DML 语句、DDL 语句 在主库执行的哪个阶段开始发送给从库？

	DML 语句:
		由于 binlog 已经写入完成 到 binlog files（os cache）中, 之后主从复制线程的dump线程会从binlog_cache里把event主动发送给slave的I/O线程，同时执行 fsync刷盘(大事务的话这步非常耗时)，并清空 binlog cache。
	

2. relay log 日志切换的时机：
	1. flush logs;
	2. 
	