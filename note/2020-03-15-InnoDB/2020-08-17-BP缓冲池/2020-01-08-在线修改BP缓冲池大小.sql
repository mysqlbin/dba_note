

在MySQL 5.7之前 innodb_buffer_pool_size 的修改需要重启实例，在5.7后支持了动态修改 innodb_buffer_pool_size
可以在线修改buffer pool对DBA来说实在太方便了，实例运行过程中可以动态调整，避免事先分配不合理的情况，不过 innodb_buffer_pool_instances 不能修改，而且在 innodb_buffer_pool_instances 大于 1 时，也不能将 buffer pool 调整到 1GB 以内，需要稍加注意

叶老师实际测试:

	实际测试时，发现在线修改 buffer poo 的代价并不大，SQL命令提交完毕后都是瞬间完成，而后台进程的耗时也并不太久。
	在一个并发128线程跑tpcc压测的环境中，将 buffer pool 从32G扩展到48G，后台线程耗时 3秒，而从 48G 缩减回 32G 则耗时 18秒，期间压测的事务未发生任何锁等待。
	
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
		
		
生产环境演示
在线减少 InnoDB buffer pool size： 从10G缩减到8G
mysql > SET GLOBAL innodb_buffer_pool_size = 8589934592;     #耗时: 0.091s		

-- 看看日志记录

2019-03-01T09:37:07.362785+08:00 0 [Note] InnoDB: Resizing buffer pool from 10737418240 to 8589934592 (unit=134217728).
2019-03-01T09:37:07.362819+08:00 0 [Note] InnoDB: Disabling adaptive hash index.
2019-03-01T09:37:07.403130+08:00 0 [Note] InnoDB: disabled adaptive hash index.
2019-03-01T09:37:07.403177+08:00 0 [Note] InnoDB: Withdrawing blocks to be shrunken.
2019-03-01T09:37:07.403187+08:00 0 [Note] InnoDB: buffer pool 0 : start to withdraw the last 65528 blocks.
2019-03-01T09:37:07.427227+08:00 1167661 [Note] InnoDB: Requested to resize buffer pool. (new size: 8589934592 bytes)
2019-03-01T09:37:07.435654+08:00 0 [Note] InnoDB: buffer pool 0 : withdrawing blocks. (65528/65528)
2019-03-01T09:37:07.435676+08:00 0 [Note] InnoDB: buffer pool 0 : withdrew 65528 blocks from free list. Tried to relocate 0 pages (65528/65528).
2019-03-01T09:37:07.436506+08:00 0 [Note] InnoDB: buffer pool 0 : withdrawn target 65528 blocks.
2019-03-01T09:37:07.436523+08:00 0 [Note] InnoDB: buffer pool 1 : start to withdraw the last 65528 blocks.
2019-03-01T09:37:07.487056+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65528/65528)
2019-03-01T09:37:07.487084+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 65528 blocks from free list. Tried to relocate 0 pages (65528/65528).
2019-03-01T09:37:07.488008+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawn target 65528 blocks.
2019-03-01T09:37:07.488031+08:00 0 [Note] InnoDB: Latching whole of buffer pool.
2019-03-01T09:37:07.488053+08:00 0 [Note] InnoDB: buffer pool 0 : resizing with chunks 40 to 32.
2019-03-01T09:37:07.507333+08:00 0 [Note] InnoDB: buffer pool 0 : 8 chunks (65528 blocks) were freed.
2019-03-01T09:37:07.507423+08:00 0 [Note] InnoDB: buffer pool 1 : resizing with chunks 40 to 32.
2019-03-01T09:37:07.526689+08:00 0 [Note] InnoDB: buffer pool 1 : 8 chunks (65528 blocks) were freed.
2019-03-01T09:37:07.526773+08:00 0 [Note] InnoDB: Completed to resize buffer pool from 10737418240 to 8589934592.
2019-03-01T09:37:07.526785+08:00 0 [Note] InnoDB: Re-enabled adaptive hash index.
2019-03-01T09:37:07.526794+08:00 0 [Note] InnoDB: Completed resizing buffer pool at 190301 9:37:07.


小结:
	resize阶段buffer pool会不可用，此阶段会锁所有buffer pool, 但此阶段都是内存操作，时间比较短。
	收缩内存阶段耗时可能会很长，也有一定影响，但是每次都是以instance为单位进行锁定的。 
	总的来说，buffer pool 动态调整大小对应用的影响并不大。
	buffer pool 动态调整尽量在业务低锋时进行。


