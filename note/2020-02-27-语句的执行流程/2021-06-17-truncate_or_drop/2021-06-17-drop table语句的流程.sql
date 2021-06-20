




https://baike.baidu.com/item/%E6%A0%88%E5%B8%A7/5662951?fr=aladdin    栈帧
	C语言中，每个栈帧对应着一个未运行完的函数。栈帧中保存了该函数的返回地址和局部变量。
	从逻辑上讲，栈帧就是一个函数执行的环境：函数参数、函数的局部变量、函数执行完后返回到哪里等等。
	

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
	
	
	1. 从磁盘上删除表空间是在哪1个步骤？
	
	2. 锁自适应哈希索引是在哪个步骤？
	3. 锁自适应哈希索引这个步骤会锁BP缓冲池吗
	buf_LRU_flush_or_remove_pages
	
		在我们尝试一个一个地删除页面之前，我们首先尝试批量删除页面哈希索引条目以提高效率。 
			先删除表对应的AHI，再淘汰表在BP缓冲池中的脏页。
		批处理尝试是尽力而为的尝试，并不能保证所有页面哈希条目都将被删除。 
		我们在下面一一去除剩余的页面哈希条目。
		？？？ 没有看到有清除数据表的AHI啊？ 不在 buf_LRU_flush_or_remove_pages 接口函数中
		
		----------------------------------
	
		
	drop table引起的MySQL 短暂hang死的问题，是由于drop 一张使用AHI空间较大的表时，调用执行AHI的清理动作，会消耗较长时间，
	执行期间长时间持有dict_operation_lock的X锁，阻塞了其他后台线程和用户线程;
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
	
	drop table引起的MySQL 短暂hang死的问题，是由于drop 一张使用AHI空间较大的表时，调用执行AHI的清理动作，会消耗较长时间，执行期间长时间持有dict_operation_lock的X锁，阻塞了其他后台线程和用户线程;
	调用执行AHI的清理动作会长时间持有 dict_operation_lock的X锁 ？
	不理解。
	
	--------------------------------------
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
		-- 删除表对应的AHI需要持有一把数据字典的互斥锁、读写锁？
		-- 我看源码并不是这样的。
		而这两把锁有分别和Master Thread和用户线程互斥，所以导致在删除AHI时，会有大量的Opening tables用户线程状态显示。
		对于这个问题，可以在DROP TABLE的时候关闭AHI功能。不过姜老师更为推荐直接关闭AHI功能。

		这里的数据字典是什么东西
		
		------------------------------------------------------
		
		删除表对应的AHI，需要持有一把 数据字典的互斥锁、读写锁。
			
			

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
	
	https://blog.csdn.net/qiuyepiaoling/article/details/6545372
	
	
	https://blog.csdn.net/weixin_35849182/article/details/113056288   delete mysql 大表_MySQL的DropTable影响分析和最佳实践

	https://www.jianshu.com/p/f8e124116094   MySQL drop/truncatre 大表分析及解决方案    --实实在在的好文啊。
	

	 
	
drop table 的风险和避免方法
	1. Drop table 要做的主要有3件事：
		把硬盘上的这个文件删了

		把内存中的这个库已经加载加来的Page删了，腾出空间

		把MySQL元数据字典中这张表关联信息删了

	2. 可能会引起的风险有3种：
		
		MySQL长时间阻塞其他事务执行，大量请求堆积，实例假死。(锁)
		
		内存里的page大量置换，引起线程阻塞，实例假死(内存)
		
		磁盘IO被短时间大量占用，数据库性能明显下降(IO)


	3. 解决和避免的方法3种：
	
		io占用的问题，对这个表建一个硬链，使Drop table 表的时候并没有真的去磁盘上删那个巨大的ibd文件，事后再用truncate的方式慢慢的删除这个文件，如果是SSD盘和卡,drop table后再直接rm文件也没问题

		内存和IO占用的问题，升级MySQL版本

		MySQL 5.5.23 引入了 lazy drop table 来优化改进了drop 操作影响(改进，改进，并没有说完全消除!!!拐杖敲黑板3次)

		MySQL5.7.8 拆分了AHI共用一个全局的锁结构 btr_search_latch

		MySQL8.0 解决了truncate table 的风险
	4. 持有的锁
		BP缓冲池互斥锁
		数据字典的互斥锁、读写锁
		
	
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


一、知道了删除大表耗时的几个位置在drop表时我们就可以对其今进行优化
	1.优化删除.ibd慢：做硬连接删除，然后使用Linux truncate命令逐步缩小.ibd_bak文件进行删除
	2.优化释放AHI慢：此处暂时没有想到好的方法，网上有些人说临时关闭AHI，这个关闭可以在线通过innodb_adaptive_hash_index=off立即清空AHI，这样就不会清理AHI了，但是所有页面是否要循环取决于版本(percona-5.6.44版本没有if (ahi)这个判断，所以无论是否关闭AHI都会循环调用,oracle-mysql5.7.17这个版本有if (ahi)这个判断，所以关闭AHI是可以生效的，其他版本是否有这个判断，请自行判断)，这个参数在线关闭是否会影响线上环境，需要根据各自的业务和环境来进行选择
	3.优化释放索引段加载描述符页面到bufferpool慢，还是用SSD来解决吧，普通磁盘性能实在是差差差...
	4.drop表会清理bufferpool脏页，但是不会清理bufferpool数据页，所以对于热点表还是先采取rename方式，在进行删除操作
	
二、删除索引并不会释放表空间，这部分索引只是还给了表的free列表，并没有清理
三、drop表或者删除索引的时候只会将XDES描述符页面(每256个区加载一个XDES页面)加载到bufferpool，在释放extent过程中通过xdes_init方法来重新初始化该XDES描述符内对应区的属性，将其置为干净可用状态，在整个	过程中数据和索引页面不会加载到bufferpool
四、drop表期间会持有row_mysql_lock_data_dictionary数据字典锁，这个锁是一个全局锁，对于后续操作数据字典的都会阻塞，例如create、show create、select等操作，被阻塞的SQL状态表现为Opening tables，drop		表这个SQL的状态为checking permissions,这个锁会在删除表时获取直到将.ibd文件删除才会用row_mysql_unlock_data_dictionary释放，另外truncate table也会走这个持这个锁的流程
	
	将.ibd文件删除才会用row_mysql_unlock_data_dictionary释放  -- 这个需要验证下。
	
五、看了truncate流程后，对于允许drop或者truncate的表，优选drop,原因如下:
	1.truncate table与mysql版本有很大关系，版本不同影响很大,5.6(本人percona-5.6.29) truncate是真正的删除.ibd文件然后重建，5.7(本人percona-5.7.26)是释放所有的索引树然后重用该ibd文件,也就是说5.6可以采用硬连接来消除删除.ibd这段时间，但是5.7不行，因为是重用该.ibd文件，硬连接空间会随着.ibd一同释放
	2.truncate table不管5.6还是5.7都会立即清理bufferpool的数据页和脏页，而drop table只立即释放脏页面
	3.由上可知如果业务允许最好采用drop+create清理表，drop表可以通过硬连接+bufferpool数据页后台清理来降低持有数据字典这个全局锁的时间，进而降低对业务的影响	
	