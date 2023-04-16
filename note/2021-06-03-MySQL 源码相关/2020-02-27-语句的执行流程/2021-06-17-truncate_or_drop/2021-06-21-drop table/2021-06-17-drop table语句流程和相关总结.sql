
https://baike.baidu.com/item/%E6%A0%88%E5%B8%A7/5662951?fr=aladdin    栈帧
	C语言中，每个栈帧对应着一个未运行完的函数。栈帧中保存了该函数的返回地址和局部变量。
	从逻辑上讲，栈帧就是一个函数执行的环境：函数参数、函数的局部变量、函数执行完后返回到哪里等等。

	
大纲
	
	0. 函数接口 buf_LRU_flush_or_remove_pages 
	0. drop table同步模式
	1. drop table懒加载模式
	2. 整个DROP TABLE过程可以简单地概括为
	3. drop table的风险和避免方法
	4. 小结
	5. 生产环境清空表数据实践
	6. 相关参考
	7. 相关思考
	
	
0. 函数接口 buf_LRU_flush_or_remove_pages 

	函数接口 buf_LRU_flush_or_remove_pages 用于确认是否维护 LRU list，其中有三种类型：


	/** Algorithm to remove the pages for a tablespace from the buffer pool.
		See buf_LRU_flush_or_remove_pages(). */
		enum buf_remove_t {
			BUF_REMOVE_ALL_NO_WRITE,    /*!< Remove all pages from the buffer
							pool, don't write or sync to disk */  
			BUF_REMOVE_FLUSH_NO_WRITE,  /*!< Remove only, from the flush list,
							don't write or sync to disk */
			BUF_REMOVE_FLUSH_WRITE      /*!< Flush dirty pages to disk only
							don't remove from the buffer pool */
		};


	drop为：     BUF_REMOVE_FLUSH_NO_WRITE ，需要维护flush list，不回写数据
	trunacte为： BUF_REMOVE_ALL_NO_WRITE ，  需要维护flush list和lru list，不回写数据

	作者：重庆八怪
	链接：https://www.jianshu.com/p/a956a3e30eb6
	来源：简书
	著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


	
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
				此时可以正常读写。
				强制通过 pthread_yield 进行一次OS context switch，释放剩余的cpu时间片。
		3.3 重新持有buffer pool mutex；
		3.4 重新持有flush list mutex；
		
	4. 释放flush list mutex；
	5. 释放buffer pool mutex；
	
	-- 这里的加锁流程，可以跟回收BP缓冲池的加锁流程做个对比； 
	
	MySQL官方在5.5.23版本中也实现了一个lazy drop的功能，但和Percona的实现方式不一样：
		在移除flush list时，会有一个条件判断，如果已经处理了超过一定数量的page，会强制释放当前持有的buffer pool mutex和flush list mutex，并且让出CPU，过一会儿再重新拿回锁继续清理flush list；
		对于LRU list，则不做处理，因为当这个表被删除后，这些数据页最终会在LRU算法调度下被回收。
	
	
2. 整个DROP TABLE过程可以简单地概括为
	
	0. 申请持有表的MDL写锁
		-- 不能对该表执行DML操作和查询操作
		
	1. 获取dict_sys->mutex这个数据字典的全局锁
		-- 函数：ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_lock_data_dictionary
		-- 阻塞DML、select、prepare等语句；
		《2022-10-23 - 同时drop 多个大表、总数据量为1TB导致业务的请求被阻塞》
		《2022-10-31 - 异步drop 1.5TB的大表》
		
	2. 启动一个InnoDB DDL事务
		-- 函数：ha_innobase::delete_table->row_drop_table_for_mysql->trx_start_for_ddl
		
	3. 设置 table->to_be_dropped = true
	
	4. row_add_table_to_background_drop_list   -- 后面需要看看这个函数的代码
		-- 这里还不理解
		-- 现在理解了：lazy drop逻辑; -- 2023-04-16
		
	5. 从系统表（数据字典）中清理表信息
		
		拼接了一个巨大的SQL，用来从系统表中清理信息，会释放索引树(主键索引树、二级索引树), 同时清理AHI项。
		
		从数据字典缓存中删除表
		
	
	6. row_drop_single_table_tablespace 删除表空间
	
		lazy drop逻辑，清理buffer pool的flush list，会多次持有和释放buffer pool mutex以及flush list mutex，释放cpu资源：
			-- 这样的处理能让其他业务请求有机会获得大锁的可能，从而业务的请求不会掉底，减少阻塞用户线程的时间。
			
		ha_innobase::delete_table
			->row_drop_table_for_mysql
				->row_drop_single_table_tablespace
					->fil_delete_tablespace
						->buf_LRU_flush_or_remove_pages
		
			参考笔记：《2021-06-17-drop table删除脏页的流程-buf_LRU_flush_or_remove_pages.sql》
			buf_LRU_flush_or_remove_pages
				buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages
				buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages
				buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages->buf_pool_mutex_enter
				buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages->->buf_flush_or_remove_pages
			
			
	7. 写入MLOG_FILE_DELETE类型的redo日志
		
	8. unlink ibd文件
		
		-- 删除ibd文件。
		-- ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->os_file_delete
		-- C语言unlink()函数：删除文件
		
	9. 提交InnoDB DLL事务
		-- ha_innobase::delete_table->row_drop_table_for_mysql->trx_commit_for_mysql
		
	10. 释放dict_sys->mutex	
		-- ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_unlock_data_dictionary
		
	11. 释放表的MDL写锁。
	
	
	-- 少了锁bp缓冲池空间的执行流程； 
	
	
3. drop table的风险和避免方法

	1. Drop table 要做的主要有3件事：
	
		1. 把表在内存缓冲池的脏页删了
		
		2. 把MySQL元数据字典中这张表关联信息删了，同时释放索引树
		
		3. 把硬盘上的这个文件删了


	2. 可能会引起的风险：
		
		MySQL秒级别）阻塞其他事务执行，大量请求堆积，实例假死。
		
			(数据字典全局锁是一把大的全局排他锁，内存缓冲池锁是淘汰1024个脏页后就释放锁，然后反复做这个操作，直到这个表的脏页淘汰完成)
		
		磁盘IO被短时间大量占用，数据库性能明显下降(IO)   -- 不存在。


	3. 解决和避免的方法3种：
	
		1. io占用的问题，对这个表建一个硬链，使Drop table 表的时候并没有真的去磁盘上删那个巨大的ibd文件，事后再用truncate的方式慢慢的删除这个文件，如果是SSD盘和卡,drop table后再直接rm文件也没问题
			不存在IO利用率高的情况。
			
		2. 内存和IO占用的问题，升级MySQL版本

			MySQL 5.5.23 引入了 lazy drop table 来优化改进了drop 操作影响(改进，改进，并没有说完全消除!!!拐杖敲黑板3次)

			MySQL5.7.8 拆分了AHI共用一个全局的锁结构 btr_search_latch
			
			MySQL8.0 解决了truncate table 的风险
		
		3. 业务停服期间做drop table操作。
		
		
	4. 持有的锁
	
		MDL写锁，数据字典的全局排他锁->BP缓冲池排他锁。
		
	
4. 小结

	持有的锁：
	
		MDL写锁、数据字典的全局排他锁、BP缓冲池排他锁。

		数据字典的全局排他锁：
			会阻塞DML、select、prepare等语句(处于 opening tables 状态)，这个影响很大。
		
		BP缓冲池排他锁：      
			内存缓冲池锁是淘汰1024个脏页后就释放锁，然后反复做这个操作，直到这个表的脏页淘汰完成，这个影响不大。
			
	
	如何优雅地删除大表?

		1. 在游戏业务的停服更新期间，直接做表的 drop table 操作。
			-- 大表的话，分别在主从操作，避免导致从库延迟。
			
		2. 在业务低峰期通过 pt-atchiver 归档。
		
		3. 不要直接 drop 热点表，因为热点表存在脏页，如果脏页太多，大于1024个，会反复锁内存， 可以先rename，过一段时间再做drop表操作。
		
		
	别人的小结：	
	
		一、知道了删除大表耗时的几个位置在drop表时我们就可以对其今进行优化
		
			1. 优化删除.ibd慢：做硬连接删除，然后使用Linux truncate命令逐步缩小.ibd_bak文件进行删除
			
			2. 优化释放AHI慢：此处暂时没有想到好的方法，网上有些人说临时关闭AHI，这个关闭可以在线通过innodb_adaptive_hash_index=off立即清空AHI，这样就不会清理AHI了，
				但是所有页面是否要循环取决于版本(percona-5.6.44版本没有if (ahi)这个判断，所以无论是否关闭AHI都会循环调用,oracle-mysql5.7.17这个版本有if (ahi)这个判断，
				所以关闭AHI是可以生效的，其他版本是否有这个判断，请自行判断)，这个参数在线关闭是否会影响线上环境，需要根据各自的业务和环境来进行选择
				
			3. 优化释放索引段加载描述符页面到bufferpool慢，还是用SSD来解决吧，普通磁盘性能实在是差差差...
			
			4. drop表会清理 flush list脏页，但是不会清理bufferpool lru list数据页，所以对于热点表还是先采取rename方式，在进行删除操作
			
		二、删除索引并不会释放表空间，这部分索引只是还给了表的free列表，并没有清理
		
		三、drop表或者删除索引的时候只会将XDES描述符页面(每256个区加载一个XDES页面)加载到bufferpool，在释放extent过程中通过xdes_init方法来重新初始化该XDES描述符内对应区的属性，将其置为干净可用状态，在整个	过程中数据和索引页面不会加载到bufferpool
		
		四、
			drop表期间会持有 row_mysql_lock_data_dictionary 数据字典锁，这个锁是一个全局锁，对于后续操作数据字典的都会阻塞，例如create、show create、DML、select、Prepare等操作；
			被阻塞的SQL状态表现为 Opening tables ，drop表这个SQL的状态为 checking permissions ,这个锁会在删除表时获取直到将.ibd文件删除才会用 row_mysql_unlock_data_dictionary 释放
			另外truncate table也会走这个持这个锁的流程，将.ibd文件删除才会用 row_mysql_unlock_data_dictionary 释放  
			-- 验证了，理解了。
			
		五、看了truncate流程后，对于允许drop或者truncate的表，优选drop,原因如下:
		
			1. truncate table与mysql版本有很大关系，版本不同影响很大,5.6(本人percona-5.6.29) truncate是真正的删除.ibd文件然后重建，5.7(本人percona-5.7.26)是释放所有的索引树然后重用该ibd文件,也就是说5.6可以采用硬连接来消除删除.ibd这段时间，但是5.7不行，因为是重用该.ibd文件，硬连接空间会随着.ibd一同释放
			2.
				truncate table不管5.6还是5.7都会立即清理该表在buffer pool的数据页和脏页，而drop table只立即释放脏页面
				
			3.truncate table 时会扫lru列表中所有的页面，期间会持有全局锁
				持锁时间不仅与表大小有关，也与当前数据库lru中数据页面数量有关，lru中页面越多，持锁时间越长，即便是一个空表也会有这个过程导致夯死数据库
				lru大小不要与bufferpool大小直接挂钩，bufferpool大未必lru列表大，lru列表是随着数据访问量逐步增加的
				所以评估一张表truncate耗时可以依据innodb status中的LRU len长度以及表的.ibd文件来判断。
	
			4. 由上可知如果业务允许最好采用drop+create清理表，drop表可以通过硬连接+bufferpool数据页后台清理来降低持有数据字典这个全局锁的时间，进而降低对业务的影响	
					
	
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
	
	-----------------------------------------
	
	机器配置：4 CPU、16GB 内存，100GB的SSD盘。
	
	
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
	 
	https://blog.csdn.net/qq_42979842/article/details/115016305  MySQL DROP一张表原来竟然要做这么多工作？
	
		
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
	
	
	2.  pt操作后drop旧表的操作会带来的问题：会短暂的把整个库锁住  整个系统会在drop表期间不可用？
	
		
		 如果是大表，还是要谨慎，drop table期间会对数据字典加全局的排他锁，会阻塞DML语句、不会阻塞查询语句。
		 
		 解决办法：
		 
			1. 做pt-osc加上不删除旧表的选项(--[no]drop-old-table             Drop the original table after renaming it (default yes))
			
			2. 看业务：一般游戏业务有停机窗口，可以在停服期间做drop table操作。
			
			3. 旧表可以先用 pt-archive 做小批量删除数据，最后再做drop table。
		 
	
	
	3. 从磁盘上删除表空间是在哪1个步骤？
	
		 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->os_file_delete
	
		
	4. 清理自适应哈希索引是在哪个步骤？
	

		buf_LRU_flush_or_remove_pages函数中的注释：
		
			在我们尝试一个一个地删除页面之前，我们首先尝试批量删除页面哈希索引条目以提高效率。 
				先删除表对应的AHI，再淘汰表在BP缓冲池中的脏页。
			批处理尝试是尽力而为的尝试，并不能保证所有页面哈希条目都将被删除。 
			我们在下面一一去除剩余的页面哈希条目。
			？？？ 没有看到有清除数据表的AHI啊？ 不在 buf_LRU_flush_or_remove_pages 接口函数中
			-- 在删除脏页之前清理AHI。
	
		答：先释放索引树，释放索引树的这个过程会清理自适应哈希索引，最后在删除表空间的时候，会先淘汰脏页。
		
		
		
		问题：清理自适应哈希索引这个步骤会锁BP缓冲池吗
		答：不会。
		
	5. BP变大，意味着AHI所占用的空间也变大。当DROP TABLE时，InnoDB引擎还会删除表对应的AHI（自适应哈希索引）。而这个过程需要持有一把数据字典的互斥锁、读写锁。
	
		-- 删除表对应的AHI需要持有一把数据字典的互斥锁、读写锁？
		-- 我看源码并不是这样的。通过自己的验证：源码+实验，发现这个描述不对。


	6. 跟踪了代码，没有发现有调用 buf_LRU_drop_page_hash_for_tablespace 函数来删除AHI。

		(gdb) b buf_LRU_drop_page_hash_for_tablespace
		Breakpoint 2 at 0x1b73696: file /usr/local/mysql/storage/innobase/buf/buf0lru.cc, line 266.

		(gdb) c
		Continuing.
		[New Thread 0x7fe77008b700 (LWP 2251)]
		
		mysql> drop table t3;
		Query OK, 0 rows affected (0.08 sec)
		
		答：释放索引树的时候会清理ahi.
		
	