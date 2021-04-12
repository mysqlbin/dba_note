
读操作：innodb_read_io_threads
　　1、发起者：用户线程发起读请求
　　2、完成者：读线程执行请求队列中的读请求操作
　　3、如何调整读线程的数量
		mysql> show variables like 'innodb_read_io_threads';
		+------------------------+-------+
		| Variable_name          | Value |
		+------------------------+-------+
		| innodb_read_io_threads | 4     |
		+------------------------+-------+
		1 row in set (0.01 sec)
　　　　默认是开启4个读线程，静态参数，修改至配置文件中

　　4、如何确定是否需要增加读线程的数量
　　　　查看线程的状态：I/O thread 2 state: waiting for i/o request (read thread)   闲



https://www.cnblogs.com/geaozhang/p/7214257.html  MySQL IO线程及相关参数调优
