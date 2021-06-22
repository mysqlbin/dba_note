
https://baike.baidu.com/item/%E6%A0%88%E5%B8%A7/5662951?fr=aladdin    栈帧
	C语言中，每个栈帧对应着一个未运行完的函数。栈帧中保存了该函数的返回地址和局部变量。
	从逻辑上讲，栈帧就是一个函数执行的环境：函数参数、函数的局部变量、函数执行完后返回到哪里等等。
	
大纲
	0. drop table同步模式
	1. drop table懒加载模式
	2. 整个DROP TABLE过程可以简单地概括为
	3. drop table的风险和避免方法
	4. 小结
	5. 生产环境清空表数据实践
	6. 相关参考
	7. 相关思考
	
	
	
0. drop table同步模式
	
	MySQL在5.5.23版本之前的处理方式即同步模式:
		当要drop table的时候，会在整个操作过程中持有buffer pool的mutex，然后扫描两次LRU链表，把属于这个table的page失效掉，buffer pool中page的个数越多，持有mutex时间就会越长，对在线业务的影响也就越明显。
	简短看下核心处理代码:
	
		fil_delete_tablespace
		buf_LRU_invalidate_tablespace(
			 ulint     id)     /*!< in: space id */
		{
			 ulint     i;()
			 for (i = 0; i < srv_buf_pool_instances; i++) {
				  buf_pool_t*     buf_pool;

				  buf_pool = buf_pool_from_array(i);
				  buf_LRU_drop_page_hash_for_tablespace(buf_pool, id);
				  buf_LRU_invalidate_tablespace_buf_pool_instance(buf_pool, id);
			 }
		}		
		buf_LRU_drop_page_hash_for_tablespace 会扫描一次LRU list，需要从adaptive hash中删除对要删除的表的page的引用；
		buf_LRU_invalidate_tablespace_buf_pool_instance 会扫描一次LRU list: 如果是dirty block，需要从flush list remove掉，然后从page hash中删除，最后从LRU list中删除。		
			
		
	Percona曾经在MySQL官方5.5.23之前的版本中遇到过这个问题，并且提供了一种叫Percona Lazy Drop的补丁。简单来说，他们认为这个问题的瓶颈在CPU。
	在删除一个有独立表空间的大表时，需要对buffer pool中所有和这个表空间有关的数据页做清理工作，包括从AHI，flush list和LRU list上移除，而在这个清理过程中，会一直持有buffer pool的mutex。
	如果buffer pool配置特别大，比如500 GB大小，持有这个mutex的事件会较长，导致其他连接被阻塞住，从而导致系统性能的下降。
	Percona Lazy Drop就是在清理buffer pool这里做了优化，尽量短时间和小粒度的持有mutex。
		
		
1. drop table懒加载模式

	MySQL lazy模式
	在MySQL 5.5.23以后的版本，也实现了一个lazy drop table的方式，和percona的方式有所区别，下面来看一下具体的过程：

	1. 持有buffer pool mutex；
		导致不可以写，不可以读。
		数据库的查询和DML操作都需要走BP缓冲池。
		
	2. 持有buffer pool中的flush list mutex；
		
	3. 开始扫描flush list；
	
		3.1 如果dirty page属于drop table，那么就直接从flush list中remove掉；
			-- 对应 buf_flush_or_remove_pages 函数
		3.2 如果删除的脏页page个数超过了#define BUF_LRU_DROP_SEARCH_SIZE 1024 这个数目的话，释放buffer pool mutex，flush list mutex，释放cpu资源：
			释放flush list mutex；
			释放buffer pool mutex；
			强制通过 pthread_yield 进行一次OS context switch，释放剩余的cpu时间片；
			
		3.3 重新持有buffer pool mutex；
		3.4 重新持有flush list mutext；
		
	4. 释放flush list mutex；
	5. 释放buffer pool mutex；
	
	
	MySQL官方在5.5.23版本中也实现了一个lazy drop的功能，但和Percona的实现方式不一样：
		在移除flush list时，会有一个条件判断，如果已经处理了超过一定数量的page，会强制释放当前持有的buffer pool mutex和flush list mutex，并且让出CPU，过一会儿再重新拿回锁继续清理flush list；
		对于LRU list，则不做处理，因为当这个表被删除后，这些数据页最终会在LRU算法调度下被回收。
	
	
2. 整个DROP TABLE过程可以简单地概括为
	
	0. 申请MDL写锁
		
	1. 获取dict_sys->mutex这个数据字典的全局锁，会阻塞后台线程和用户线程
		-- 函数：ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_lock_data_dictionary
		
	2. 启动一个InnoDB DDL事务
		-- 函数：ha_innobase::delete_table->row_drop_table_for_mysql->trx_start_for_ddl
		
	3. 更新数据字典，包括内存中的数据和mysql库下的数据字典表
		-- 拼接了一个巨大的SQL，用来从系统表中清理信息
		
	4. lazy drop逻辑，清理buffer pool的flush list，会多次持有和释放buffer pool mutex以及flush list mutex，释放cpu资源：
			
		-- ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->buf_LRU_flush_or_remove_pages
		
			参考笔记：《2021-06-17-drop table删除脏页的流程-buf_LRU_flush_or_remove_pages.sql》
			3.1 buf_LRU_flush_or_remove_pages
			3.1.1 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages
			3.1.2 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages
			3.1.3 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages->buf_pool_mutex_enter
			3.1.4 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages->->buf_flush_or_remove_pages
		
	5. 写入MLOG_FILE_DELETE类型的redo日志
		
	6. unlink ibd文件
		-- 删除ibd文件。
		-- ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->os_file_delete
		-- C语言unlink()函数：删除文件
		
	7. 提交InnoDB DLL事务
		-- ha_innobase::delete_table->row_drop_table_for_mysql->trx_commit_for_mysql
		
	8. 释放dict_sys->mutex	
		-- ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_unlock_data_dictionary
	
	不足之处：没有讲到清理AHI
	


3. drop table的风险和避免方法

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
		MDL写锁，数据字典的全局排他锁->BP缓冲池排他锁。
		
	
4. 小结
	持有的锁：
		MDL写锁、数据字典的全局排他锁->BP缓冲池排他锁。
		
		DML请求都需要访问BP内存缓冲池，如果内存缓冲池被锁住了，自然阻塞所有的DML请求，QPS降为0。
	
	如何删除大表?

		1. 在游戏业务的停服更新期间，直接做表的 drop table操作。
		2. 在业务低峰期通过 pt-atchiver 归档。
		3. 不要直接drop 热点表，可以先rename，过一段时间再做drop表操作。
		
	别人的小结：	
	
		一、知道了删除大表耗时的几个位置在drop表时我们就可以对其今进行优化
			1.优化删除.ibd慢：做硬连接删除，然后使用Linux truncate命令逐步缩小.ibd_bak文件进行删除
			2.优化释放AHI慢：此处暂时没有想到好的方法，网上有些人说临时关闭AHI，这个关闭可以在线通过innodb_adaptive_hash_index=off立即清空AHI，这样就不会清理AHI了，
				但是所有页面是否要循环取决于版本(percona-5.6.44版本没有if (ahi)这个判断，所以无论是否关闭AHI都会循环调用,oracle-mysql5.7.17这个版本有if (ahi)这个判断，
				所以关闭AHI是可以生效的，其他版本是否有这个判断，请自行判断)，这个参数在线关闭是否会影响线上环境，需要根据各自的业务和环境来进行选择
			3.优化释放索引段加载描述符页面到bufferpool慢，还是用SSD来解决吧，普通磁盘性能实在是差差差...
			4.drop表会清理bufferpool脏页，但是不会清理bufferpool数据页，所以对于热点表还是先采取rename方式，在进行删除操作
			
		二、删除索引并不会释放表空间，这部分索引只是还给了表的free列表，并没有清理
		三、drop表或者删除索引的时候只会将XDES描述符页面(每256个区加载一个XDES页面)加载到bufferpool，在释放extent过程中通过xdes_init方法来重新初始化该XDES描述符内对应区的属性，将其置为干净可用状态，在整个	过程中数据和索引页面不会加载到bufferpool
		四、drop表期间会持有row_mysql_lock_data_dictionary数据字典锁，这个锁是一个全局锁，对于后续操作数据字典的都会阻塞，例如create、show create、select等操作，
			被阻塞的SQL状态表现为Opening tables，drop表这个SQL的状态为 checking permissions ,这个锁会在删除表时获取直到将.ibd文件删除才会用row_mysql_unlock_data_dictionary释放，另外truncate table也会走这个持这个锁的流程
			将.ibd文件删除才会用row_mysql_unlock_data_dictionary释放  
			-- 理解了。
			
		五、看了truncate流程后，对于允许drop或者truncate的表，优选drop,原因如下:
			1.truncate table与mysql版本有很大关系，版本不同影响很大,5.6(本人percona-5.6.29) truncate是真正的删除.ibd文件然后重建，5.7(本人percona-5.7.26)是释放所有的索引树然后重用该ibd文件,也就是说5.6可以采用硬连接来消除删除.ibd这段时间，但是5.7不行，因为是重用该.ibd文件，硬连接空间会随着.ibd一同释放
			2.truncate table不管5.6还是5.7都会立即清理bufferpool的数据页和脏页，而drop table只立即释放脏页面
			3.由上可知如果业务允许最好采用drop+create清理表，drop表可以通过硬连接+bufferpool数据页后台清理来降低持有数据字典这个全局锁的时间，进而降低对业务的影响	
					
	
5. 生产环境清空表数据实践

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
	-- 在BP缓冲池LRU链表中没有数据，也没有脏页，所以drop table会很快。
	
	
	八怪师兄(22389860) 2020/8/14 15:04:57
	我们1000W数据 以前删除 堵了 好几秒。。

6. 相关参考

	http://mysql.taobao.org/monthly/2016/01/07/  MySQL · 特性分析 · drop table的优化

	https://www.jianshu.com/p/a956a3e30eb6   随笔：Innodb truncate内存维护代价高于drop

	https://mp.weixin.qq.com/s/nW9FARyeqfjQktpSaQkASQ  如何优雅地在MySQL中DROP TABLE？

	https://dev.mysql.com/doc/refman/5.7/en/drop-table.html  

	https://mp.weixin.qq.com/s/U3PJWI8l4DgJKm-p09Pc2Q    Drop Table对MySQL的性能影响分析
	
	https://blog.csdn.net/qiuyepiaoling/article/details/6545372
	
	
	https://blog.csdn.net/weixin_35849182/article/details/113056288   delete mysql 大表_MySQL的DropTable影响分析和最佳实践

	https://www.jianshu.com/p/f8e124116094   MySQL drop/truncatre 大表分析及解决方案    --实实在在的好文啊。
	
	
	https://cloud.tencent.com/developer/article/1006978?fromSource=gwzcw.2456437.2456437.2456437&cps_key=6952b221f5c1294d376262dfc91bc36b&from=console   -- 也是好文
	 

		
7. 相关思考

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
		
		不是。
	
	2.  pt操作后drop旧表的操作 
		drop表会带来的问题  会把整个库锁住  整个系统会在drop表期间不可用
		--[no]drop-old-table             Drop the original table after renaming it (default yes)
		 
		系统会短暂不可用，在意的话做pt-osc加上不删除旧表的选项，停服更新的时候删除旧表，不过一般都在业务低期做表的变更
		 
	
	3. 从磁盘上删除表空间是在哪1个步骤？
		 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->os_file_delete
	
	4. 锁自适应哈希索引是在哪个步骤？
		锁自适应哈希索引这个步骤会锁BP缓冲池吗
		buf_LRU_flush_or_remove_pages
		
			在我们尝试一个一个地删除页面之前，我们首先尝试批量删除页面哈希索引条目以提高效率。 
				先删除表对应的AHI，再淘汰表在BP缓冲池中的脏页。
			批处理尝试是尽力而为的尝试，并不能保证所有页面哈希条目都将被删除。 
			我们在下面一一去除剩余的页面哈希条目。
			？？？ 没有看到有清除数据表的AHI啊？ 不在 buf_LRU_flush_or_remove_pages 接口函数中
			-- 在删除脏页之前清理AHI。

	5. BP变大，意味着AHI所占用的空间也变大。当DROP TABLE时，InnoDB引擎还会删除表对应的AHI（自适应哈希索引）。而这个过程需要持有一把数据字典的互斥锁、读写锁。
		-- 删除表对应的AHI需要持有一把数据字典的互斥锁、读写锁？
		-- 我看源码并不是这样的。
	

