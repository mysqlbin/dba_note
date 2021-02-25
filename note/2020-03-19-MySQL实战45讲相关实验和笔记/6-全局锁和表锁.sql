

表锁
	表锁的语法: lock tables … read/write。
	释放表锁: unlock tables; 也可以在客户端断开的时候自动释放。
	lock tables 语法除了会限制别的线程的读写外，也限定了本线程接下来的操作对象。
	举例说明:
		在某个线程 A 中执行 lock tables t1 read, t2 write; 这个语句，则其他线程写 t1、读写 t2 的语句都会被阻塞。
		同时，线程 A 在执行 unlock tables 之前，也只能执行读 t1、读写 t2 的操作。
		连写 t1 都不允许，自然也不能访问其他表。
	应用场景：
		mysqldump备份生成的逻辑文件中， 在insert ...语句前面会对表加表的写锁
		参考实验笔记：《2020-04-22-导入mysqldump备份的数据期间查询表数据会处于MDL锁状态.sql》
		lock tables ... write;
		insert into ...
		unlock tables;
		
	
MyISAM:
	不支持行锁
	不支持事务
	
	
给一个表加字段、删除字段，需要扫描全表的数据, 即需要重建表。
对大表的操作要谨慎，以免对线上服务造成影响。
对小表操作不慎也会出问题。


