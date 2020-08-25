

MySQL lazy模式
在MySQL 5.5.23以后的版本，也实现了一个lazy drop table的方式，和percona的方式有所区别，下面来看一下具体的过程：

1. 持有buffer pool mutex；
	导致不可以写，不可以读。
	数据库的查询和DML操作都需要走BP缓冲池。
2. 持有buffer pool中的flush list mutex；
3. 开始扫描flush list；
	3.1 如果dirty page属于drop table，那么就直接从flush list中remove掉；
	3.2 如果删除的page个数超过了#define BUF_LRU_DROP_SEARCH_SIZE 1024 这个数目的话，释放buffer pool mutex，flush list mutex，释放cpu资源；
		释放flush list mutex；
		释放buffer pool mutex；
		强制通过pthread_yield进行一次OS context switch，释放剩余的cpu时间片；
	3.3 重新持有buffer pool mutex；
	3.4 重新持有flush list mutext；
4. 释放flush list mutex；
5. 释放buffer pool mutex；



other:
	持有一把数据字典的互斥锁、读写锁。

	最近，我们中心的同学发现，仅上述这两种操作步骤依然无法达到优雅的定义。因为在DROP TABLE过程中，依然会存在大量的线程处于 OPENING TABLES 的状态。
	最终，姜老师发现除了BP的大锁之外，还存在一把数据字典的锁，而这把锁会引起性能的抖动。
	BP变大，意味着AHI所占用的空间也变大。当DROP TABLE时，InnoDB引擎还会删除表对应0的AHI（自适应哈希索引）。而这个过程需要持有一把数据字典的互斥锁、读写锁。
	而这两把锁有分别和Master Thread和用户线程互斥，所以导致在删除AHI时，会有大量的Opening tables用户线程状态显示。
	对于这个问题，可以在DROP TABLE的时候关闭AHI功能。不过姜老师更为推荐直接关闭AHI功能。


相关参考
	http://mysql.taobao.org/monthly/2016/01/07/  MySQL · 特性分析 · drop table的优化

	https://www.jianshu.com/p/a956a3e30eb6   随笔：Innodb truncate内存维护代价高于drop

	https://mp.weixin.qq.com/s/nW9FARyeqfjQktpSaQkASQ  如何优雅地在MySQL中DROP TABLE？

	https://dev.mysql.com/doc/refman/5.7/en/drop-table.html  



八怪师兄(22389860) 2020/8/14 15:04:57
我们1000W数据 以前删除 堵了 好几秒。。



生产环境清空表数据实践
	t1   ：表大小13GB
	t2   ：表大小3GB
	t3   ：表大小2.5GB
	t4   ：表大小3GB

	mysql> truncate table t1;
	Query OK, 0 rows affected (0.78 sec)

	mysql> truncate table t2;
	Query OK, 0 rows affected (0.48 sec)

	mysql> truncate table t3;
	Query OK, 0 rows affected (0.43 sec)

	mysql> truncate table t4;
	Query OK, 0 rows affected (0.34 sec)
	
	-- truncate table = drop table + create table;
	-- 3个月前已经把这几个表的数据，按日期写入每天的日期表中，然后这4个表最近3个月都没有数据写入，也没有对表进行读操作。
	-- 在BP缓冲池没有数据，也没有脏页，所以drop table会很快。
	
	
	





