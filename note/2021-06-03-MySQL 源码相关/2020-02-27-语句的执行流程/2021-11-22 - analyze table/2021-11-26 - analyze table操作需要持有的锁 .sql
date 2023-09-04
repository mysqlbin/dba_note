



1. 持有 InnoDB 表的 read only 锁，短暂的阻塞读写（DML）请求
	待收集完成表和索引的统计信息后，释放 read only 锁。
	-- lock_type=TL_READ_NO_INSERT：表示加 read only 锁，阻塞DML请求。

2. flush 锁：
	flush tables 关闭实例下所以线程打开的这个表，如果该表有慢查询，analyze table 操作会被阻塞，同时阻塞接下来其它线程对该表的访问。


一些小结：
	
	不要在业务高峰期做数据库相关的维护操作，比如 alter table、analyze table、包括使用第3方工具做表的DDL变更 
	
------------------------------------------------------------------------------------------------------------------------


在analyze table的过程中会持有InnoDB 表的 read only 锁， 因此会存在短暂的阻塞用户写入更新删除（DML）的操作。 

除此之外analyze table 要把table 从 table definition cache 刷出来， 因此还会需要一个 flush lock(flush 关闭表)， 此时如果有长事务使用了这张表， 那么必须等待长事务结束，同时阻塞接下来其它线程对该表的访问。

https://zhuanlan.zhihu.com/p/408703724  MySQL InnoDB 的统计信息



统计信息收集是通过 dict_stats_update_persistent() 函数来完成的，具体收集算法这里不展开，其统计指标更新流程是：

	1. 持写锁
	2. 统计信息缓存清零
	3. 收集表和索引统计信息并更新缓存
	4. 释放写锁
	5. 持读锁获取缓存的快照
	6. 将快照持久化到系统表中
	7. 释放读锁
	
	http://mysql.taobao.org/monthly/2020/12/05/
	
	
	
《2021-11-25 - analyze table操作的执行流程.sql》

