






drop table 的执行流程
	MySQL lazy模式
	在MySQL 5.5.23以后的版本，也实现了一个lazy drop table的方式，和percona的方式有所区别，下面来看一下具体的过程：

	1. 持有buffer pool mutex；
		导致不可以写，不可以读。
		数据库的查询和DML操作都需要走BP缓冲池。
		
	2. 持有buffer pool中的flush list mutex；
		
	3. 开始扫描flush list；
	
		3.1 如果dirty page属于drop table，那么就直接从flush list中remove掉；
			-- 对应 buf_flush_or_remove_pages 函数
		3.2 如果删除的page个数超过了#define BUF_LRU_DROP_SEARCH_SIZE 1024 这个数目的话，释放buffer pool mutex，flush list mutex，释放cpu资源：
			释放flush list mutex；
			释放buffer pool mutex；
			强制通过pthread_yield进行一次OS context switch，释放剩余的cpu时间片；
			
		3.3 重新持有buffer pool mutex；
		3.4 重新持有flush list mutext；
		
	4. 释放flush list mutex；
	5. 释放buffer pool mutex；
	
	从磁盘上删除表空间是在哪1个步骤？
	锁自适应哈希索引是在哪个步骤？ 
	
	drop table引起的MySQL 短暂hang死的问题，是由于drop 一张使用AHI空间较大的表时，调用执行AHI的清理动作，会消耗较长时间，执行期间长时间持有dict_operation_lock的X锁，阻塞了其他后台线程和用户线程;
	drop table执行结束锁释放，MySQL积压的用户线程集中运行，出现了并发线程和连接数瞬间上升的现象。
	规避问题的方法，可以考虑在drop table前关闭AHI。
	

	AHI存在一个副作用：当删除大表，且缓冲池（Buffer Pool，下简称BP）比较大，如超过32G，则MySQL数据库可能会有短暂被hang住的情况发生。
	这时会对业务线程造成一定影响，从而导致业务系统的抖动。
	产生这个问题的原因是在删除表的时候，InnoDB存储引擎会将该表在BP中的内存都淘汰掉，释放可用空间。
	这其中包括数据页、索引页、自适应哈希页等。
	当BP比较大是，扫描BP中flush_list链表需要比较长的时间，因此会产生系统的抖动。
	因此在海量的互联网并发业务中，删除表操作需要做精细的逻辑控制，如：
		1. 业务低峰期删除大表；
		2. 删除表前禁用AHI功能；
		3. 控制脏页链表长度，只有长度小于一定阈值，才发起删除操作；
		4. 删除表后启用AHI功能；
	不过呢，所有这么麻烦的处理在 MySQL 8.0.23 版本之后，就都不再需要了。

	-----------------------------------------------------------------------------------------------------------------------------------------
	
	1. 锁住BP缓冲池;
	2. 锁住BP缓冲池的脏页链表;
	3. 删除数据表在BP缓冲池的脏页;
	4. 释放脏页链表的锁;
	5. 释放BP缓冲池的锁。


	other:
		持有一把数据字典的互斥锁、读写锁。

		最近，我们中心的同学发现，仅上述这两种操作步骤依然无法达到优雅的定义。因为在DROP TABLE过程中，依然会存在大量的线程处于 OPENING TABLES 的状态。
		最终，姜老师发现除了BP的大锁之外，还存在一把数据字典的锁，而这把锁会引起性能的抖动。
		BP变大，意味着AHI所占用的空间也变大。当DROP TABLE时，InnoDB引擎还会删除表对应的AHI（自适应哈希索引）。而这个过程需要持有一把数据字典的互斥锁、读写锁。
		而这两把锁有分别和Master Thread和用户线程互斥，所以导致在删除AHI时，会有大量的Opening tables用户线程状态显示。
		对于这个问题，可以在DROP TABLE的时候关闭AHI功能。不过姜老师更为推荐直接关闭AHI功能。

		这里的数据字典是什么东西
		

核心源码

	其核心的代码如下：

	buf_LRU_flush_or_remove_pages(id, BUF_REMOVE_FLUSH_NO_WRITE, 0);

	buf_pool_mutex_enter(buf_pool);

	err = buf_flush_or_remove_pages(buf_pool, id, flush, trx);
	......
	buf_pool_mutex_exit(buf_pool);

	/* BUF_REMOVE_FLUSH_NO_WRITE：意思表示，只对dirty block进行remove操作，不做写入。 */



思考：

	1. drop table 临时表也是走drop table 磁盘表的流程吗
	
		#创建临时表
		DROP TEMPORARY TABLE IF EXISTS temp_RoomCardClubUserSort;
		 
		CREATE TEMPORARY TABLE temp_RoomCardClubUserSort(  
				Id INT UNSIGNED  NOT NULL  AUTO_INCREMENT PRIMARY KEY,
				nClubId INT DEFAULT 0,
				nPlayerId INT DEFAULT 0,
				nScore BIGINT DEFAULT 0,
				nResult BIGINT DEFAULT 0,
				nBigWinner BIGINT DEFAULT 0
		);
	
	2.  pt操作后drop旧表的操作 
		drop表会带来的问题  会把整个库锁住  整个系统会在drop表期间不可用
		--[no]drop-old-table             Drop the original table after renaming it (default yes)
		 
		系统会短暂不可用，在意的话做pt-osc加上不删除旧表的选项，停服更新的时候删除旧表，不过一般都在业务低期做表的变更
		 
		 

小结：

	DML请求都需要访问BP内存缓冲池，如果内存缓冲池被锁住了，自然阻塞所有的DML请求，QPS降为0。
	如何删除大表？  在业务低峰期通过 pt-atchiver 归档是最好的方式。
	在游戏业务的停服更新期间，直接做表的 drop table操作。


相关参考

	http://mysql.taobao.org/monthly/2016/01/07/  MySQL · 特性分析 · drop table的优化

	https://www.jianshu.com/p/a956a3e30eb6   随笔：Innodb truncate内存维护代价高于drop

	https://mp.weixin.qq.com/s/nW9FARyeqfjQktpSaQkASQ  如何优雅地在MySQL中DROP TABLE？

	https://dev.mysql.com/doc/refman/5.7/en/drop-table.html  

	https://mp.weixin.qq.com/s/U3PJWI8l4DgJKm-p09Pc2Q    Drop Table对MySQL的性能影响分析

	

生产环境清空表数据实践

	机器配置：4 CPU、16GB 内存，200GB的SSD盘。
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
	
	

	
	八怪师兄(22389860) 2020/8/14 15:04:57
	我们1000W数据 以前删除 堵了 好几秒。。


	
	