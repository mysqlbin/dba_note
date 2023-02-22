
1. 前言

2. 叶老师的实际测试
	2.0 结论
	2.1 缓冲池扩容
	2.2 缓冲池缩容

3. 生产环境演示
	3.1 缩容
	3.2 扩容
4. 结论


1. 前言
	在MySQL 5.7之前 innodb_buffer_pool_size 的修改需要重启实例，在5.7后支持了动态修改 innodb_buffer_pool_size
	可以在线修改buffer pool对DBA来说实在太方便了，实例运行过程中可以动态调整，避免事先分配不合理的情况，
	不过 innodb_buffer_pool_instances 不能修改，而且在 innodb_buffer_pool_instances 大于 1 时，也不能将 buffer pool 调整到 1GB 以内，需要稍加注意

2. 叶老师的实际测试

	2.0 结论
	
		实际测试时，发现在线修改 buffer poo 的代价并不大，SQL命令提交完毕后都是瞬间完成，而后台进程的耗时也并不太久。
		在一个并发128线程跑tpcc压测的环境中，将 buffer pool 从32G扩展到48G，后台线程耗时 3秒，而从 48G 缩减回 32G 则耗时 18秒，期间压测的事务未发生任何锁等待。
		-- 不会有锁等待，但是会阻塞sql请求导致sql执行变慢； 
		
	2.1 缓冲池扩容
		-- 演示1：从 1G 扩大到 16G
		[yejr@imysql.com]> SET GLOBAL innodb_buffer_pool_size = 17179869184;
		Query OK, 0 rows affected (0.00 sec)

		-- 看看日志记录
		09:21:19.460543Z 0 [Note] InnoDB: Resizing buffer pool from 1073741824 to 17179869184. (unit=134217728)
		09:21:19.468069Z 0 [Note] InnoDB: disabled adaptive hash index.
		09:21:20.760724Z 0 [Note] InnoDB: buffer pool 0 : 60 chunks (491511 blocks) were added.
		09:21:21.922869Z 0 [Note] InnoDB: buffer pool 1 : 60 chunks (491520 blocks) were added.
		09:21:21.935114Z 0 [Note] InnoDB: buffer pool 0 : hash tables were resized.
		09:21:21.947264Z 0 [Note] InnoDB: buffer pool 1 : hash tables were resized.
		09:21:22.203031Z 0 [Note] InnoDB: Resized hash tables at lock_sys, adaptive hash index, dictionary.
		09:21:22.203062Z 0 [Note] InnoDB: Completed to resize buffer pool from 1073741824 to 17179869184.
		09:21:22.203075Z 0 [Note] InnoDB: Re-enabled adaptive hash index.
		
		加大buffer pool，其过程大致是：

			1、以innodb_buffer_pool_chunk_size为单位，分配新的内存pages；
			2、扩展buffer pool的AHI(adaptive hash index)链表，将新分配的pages包含进来；
			3、将新分配的pages添加到free list中；
	
	2.2 缓冲池缩容
		-- 演示2：从 16G 缩减到 1G
		[yejr@imysql.com]> SET GLOBAL innodb_buffer_pool_size = 1073741824;
		Query OK, 0 rows affected (0.00 sec)
		
		-- 看看日志记录
		09:22:55.591669Z 0 [Note] InnoDB: Resizing buffer pool from 17179869184 to 1073741824. (unit=134217728)
		09:22:55.680836Z 0 [Note] InnoDB: disabled adaptive hash index.
		09:22:55.680864Z 0 [Note] InnoDB: buffer pool 0 : start to withdraw the last 491511 blocks.
		09:22:55.765778Z 0 [Note] InnoDB: buffer pool 0 : withdrew 489812 blocks from free list. Tried to relocate 1698 pages (491510/491511).
		09:22:55.774492Z 0 [Note] InnoDB: buffer pool 0 : withdrew 0 blocks from free list. Tried to relocate 1 pages (491511/491511).
		09:22:55.782745Z 0 [Note] InnoDB: buffer pool 0 : withdrawn target 491511 blocks.
		09:22:55.782786Z 0 [Note] InnoDB: buffer pool 1 : start to withdraw the last 491520 blocks.
		09:22:55.892068Z 0 [Note] InnoDB: buffer pool 1 : withdrew 489350 blocks from free list. Tried to relocate 2166 pages (491517/491520).
		09:22:55.900743Z 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 2 pages (491519/491520).
		09:22:55.908257Z 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 0 pages (491519/491520).
		09:22:55.915778Z 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 1 pages (491520/491520).
		09:22:55.923836Z 0 [Note] InnoDB: buffer pool 1 : withdrawn target 491520 blocks.
		09:22:56.149172Z 0 [Note] InnoDB: buffer pool 0 : 60 chunks (491511 blocks) were freed.
		09:22:56.308997Z 0 [Note] InnoDB: buffer pool 1 : 60 chunks (491520 blocks) were freed.
		09:22:56.316258Z 0 [Note] InnoDB: buffer pool 0 : hash tables were resized.
		09:22:56.324027Z 0 [Note] InnoDB: buffer pool 1 : hash tables were resized.
		09:22:56.393589Z 0 [Note] InnoDB: Resized hash tables at lock_sys, adaptive hash index, dictionary.
		09:22:56.393616Z 0 [Note] InnoDB: Completed to resize buffer pool from 17179869184 to 1073741824.
		09:22:56.393628Z 0 [Note] InnoDB: Re-enabled adaptive hash index.
		
		
		缩减buffer pool，其过程则大致是：
			1、重整buffer pool，准备回收pages；
			2、以innodb_buffer_pool_chunk_size为单位，释放删除这些pages（这个过程会有一点点耗时）；
			3、调整AHI链表，使用新的内存地址。
		
		
3. 生产环境演示

	3.1 缩容 

		mysql> show global variables like '%pool_instance%';
		+------------------------------+-------+
		| Variable_name                | Value |
		+------------------------------+-------+
		| innodb_buffer_pool_instances | 2     |
		+------------------------------+-------+
		1 row in set (0.00 sec)
		
		
		mysql> show global variables like '%chunk%';
		+-------------------------------+-----------+
		| Variable_name                 | Value     |
		+-------------------------------+-----------+
		| innodb_buffer_pool_chunk_size | 134217728 |
		+-------------------------------+-----------+
		1 row in set (0.00 sec)


		在线减少 InnoDB buffer pool size： 从10G缩减到8G
		mysql > SET GLOBAL innodb_buffer_pool_size = 8589934592;     #耗时: 0.091s		

		-- 看看日志记录

		参考笔记：《2020-06-19-在线回收buffer pool导致sql语句变慢.sql》

		-------------------------------------------------------------------------------------------------------------------------------------------
		

		
	3.2 扩容


		mysql> show global variables like '%buffer_pool_size%';
		+-------------------------+------------+
		| Variable_name           | Value      |
		+-------------------------+------------+
		| innodb_buffer_pool_size | 5368709120 |
		+-------------------------+------------+
		1 row in set (0.00 sec)



		mysql> show global variables like '%buffer_pool_instances%';
		+------------------------------+-------+
		| Variable_name                | Value |
		+------------------------------+-------+
		| innodb_buffer_pool_instances | 2     |
		+------------------------------+-------+
		1 row in set (0.00 sec)
		
		-- 5GB 扩大到 9GB
		
		mysql> set global innodb_buffer_pool_size=9663676416;
		Query OK, 0 rows affected (0.00 sec)

		错误日志
			
			2021-12-08T10:20:40.755481+08:00 48 [Note] InnoDB: Requested to resize buffer pool. (new size: 9663676416 bytes)
			2021-12-08T10:20:40.773212+08:00 0 [Note] InnoDB: Resizing buffer pool from 5368709120 to 9663676416 (unit=134217728).
			2021-12-08T10:20:40.773279+08:00 0 [Note] InnoDB: Disabling adaptive hash index.
			2021-12-08T10:20:40.793594+08:00 0 [Note] InnoDB: disabled adaptive hash index.
			2021-12-08T10:20:40.793636+08:00 0 [Note] InnoDB: Withdrawing blocks to be shrunken.
			2021-12-08T10:20:40.793648+08:00 0 [Note] InnoDB: Latching whole of buffer pool.
			2021-12-08T10:20:40.793674+08:00 0 [Note] InnoDB: buffer pool 0 : resizing with chunks 20 to 36.
			2021-12-08T10:20:40.896552+08:00 0 [Note] InnoDB: buffer pool 0 : 16 chunks (131072 blocks) were added.
			2021-12-08T10:20:40.896584+08:00 0 [Note] InnoDB: buffer pool 1 : resizing with chunks 20 to 36.
			2021-12-08T10:20:40.970811+08:00 0 [Note] InnoDB: buffer pool 1 : 16 chunks (131072 blocks) were added.
			2021-12-08T10:20:40.970850+08:00 0 [Note] InnoDB: Completed to resize buffer pool from 5368709120 to 9663676416.
			2021-12-08T10:20:40.970858+08:00 0 [Note] InnoDB: Re-enabled adaptive hash index.
			2021-12-08T10:20:40.970874+08:00 0 [Note] InnoDB: Completed resizing buffer pool at 211208 10:20:40.
		
		-- 耗时 0.2秒； 10:20:40.76 ~ 10:20:40.97

	
4. 小结
	
	扩大内存比缩小内存相对容易些；
	收缩内存阶段耗时可能会很长，也有一定影响，但是每次都是以instance为单位进行锁定的。           
		-- 明白了； 这里是说在计算要回收的chunk数目、数据页阶段，需要把待回收的page放入待回收链表，耗时较长，所以持有锁（以instance为单位）的时间也会相对长一点；
	resize阶段buffer pool会不可用，此阶段会锁所有buffer pool, 但此阶段都是内存操作，时间比较短。 -- 是的；
	总的来说，buffer pool 动态调整大小对应用的影响并不大； buffer pool 动态调整尽量在业务低锋时进行。

	
