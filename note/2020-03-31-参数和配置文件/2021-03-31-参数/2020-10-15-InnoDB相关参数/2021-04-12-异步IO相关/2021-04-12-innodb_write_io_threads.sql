


innodb_write_io_threads

	用于写脏页的线程数(数据库写操作时的线程数，多线程就用于并发)
	InnoDB 使用后台线程处理数据页上写 I/O（输入）请求的数量
	
如何确定是否需要增加写线程的数量
　　查看线程的状态：I/O thread 18 state: waiting for completed aio requests (write thread)  闲


写操作：innodb_write_io_threads
　　1、发起者：page_cleaner线程发起
　　2、完成者：写线程（innodb_write_io_threads）执行请求队列中的写请求操作
	
	意思是说  通过 innodb_write_io_threads 

　　3、如何调整写线程的数量

		mysql> show variables like 'innodb_write_io_threads';
		+-------------------------+-------+
		| Variable_name           | Value |
		+-------------------------+-------+
		| innodb_write_io_threads | 4     |
		+-------------------------+-------+
		1 row in set (0.01 sec)
　　　　默认是开启4个写线程，静态参数，修改至配置文件中

　　4、如何确定是否需要增加写线程的数量
　　　　查看线程的状态：I/O thread 6 state: waiting for i/o request (write thread)


https://www.cnblogs.com/geaozhang/p/7214257.html  MySQL IO线程及相关参数调优


