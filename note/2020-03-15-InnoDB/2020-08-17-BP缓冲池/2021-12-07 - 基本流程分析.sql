
1. 在线收缩和加大BP缓冲池大小执行速度快的解释
2. 在线收缩BP缓冲池的流程和应用场景
3. 在线加大BP缓冲池的流程
4. 小结
5. 相关参考
6. innodb_buffer_pool_size 、 innnodb_buffer_pool_instaces 、innodb_buffer_pool_chunk_size 这3个参数的关系
7. 从1个收缩案例看每个instance需要回收多少个chunk


1. 在线收缩和加大BP缓冲池大小执行速度快的解释

	设置变量 innodb_buffer_pool_size 时，触发函数 innodb_buffer_pool_size_update，在必要的检查后（例如避免重复发送请求，或者resize的太小），发送信号量 srv_buf_resize_event, 然后立刻返回
	因此设置变量成功，不等于 bp 的size已经调整好了，只是发出了一个 resize 请求而已.

	Buffer Pool 提供了专门的一个后台线程 buf_resize_thread 来完成 resize 过程, 具体的操作函数是 buf_pool_resize()


2. 在线收缩BP缓冲池的流程和应用场景

	-- 画流程图：大纲、子项
	
	在线收缩BP缓冲池的流程
	
		1. 假如开启了 AHI, 需要关闭 AHI(关闭AHI, 会释放Hash table中的数据).

		2. 假如是缩小 Buffer Pool 的大小, 计算需收缩的chunk数
			
			需要设置每个 Buffer Pool Instance 的 withdraw_target , 即设置回收的 Page 数目.
			-- buf_pool->withdraw_target = withdraw_target; ——> 需要缩小的block（Page）数
			在函数 buf_pool_withdraw_blocks() 进行回收 Page 操作:
			
				遍历buffer pool instances，以 buffer pool instances 为单位进行加锁
				
					首先从buf_pool->free开始回收, 将 Page 从free_list中释放, 插入 withdraw list(待删除链表).
			
					假如从free_list中回收的 Page 数目没有达到要求, 则需要继续从 lru_list 中回收. 将脏页刷盘, 然后插入 withdraw_list .
				
				释放buffer pool instances锁
				
				
		3. 停止加载 Buffer Pool

		4. 开始 resize
				
			锁住所有instance的buffer_pool，page_hash
			
			以chunk为单位释放要收缩的内存
			
			清空 withdraw list
			
			更新每个 Buffer Pool Instance 的大小buf_pool->curr_size 和 Chunk数量buf_pool->n_chunks_new, Page 数目等.

			假如 Buffer Pool 的大小扩大了2倍或者缩小了2倍, 则需要新建新的page_hash和zip_hash.
			
			释放buffer_pool,page_hash锁

		5. 重新开启 AHI.
		
		6. 结合 源码+错误日志中记录的步骤+文章 来整理的流程.
		
		

	应用场景:
		收缩BP缓冲池空间大小的场景: 由于设置得太大, 数据库在运行一段时间后, 加上其它线程占用的内存, 导致物理内存剩余空间比较少, 容易引发OOM, 不需要重启数据库, 可以选择在业务低峰期进行回收内存, 避免OOM
		

3. 在线加大BP缓冲池的流程
	
	1. 假如开启了 AHI, 需要关闭 AHI(关闭AHI, 会释放Hash table中的数据).
	2. 停止加载 Buffer Pool
	3. 开始 resize
	
		锁住所有instance的buffer_pool，page_hash
		
		以chunk为单位增加内存
		
		释放buffer_pool,page_hash锁。
			
	4. 重新开启 AHI.
	

4. 小结
	
	resize阶段buffer pool会不可用，此阶段会锁所有buffer pool, 但此阶段都是内存操作，时间比较短。
		-- 理解了.
		
	在线加大BP缓冲池 比 在线收缩BP缓冲池的代价要小, 因为在线加大BP缓冲池不需要做回收内存数据页这个操作, 直接加chunk.
	收缩内存阶段耗时可能会很长，也有一定影响，但是每次都是以instance为单位进行锁定的。
		-- 理解了.
	
	扩展:
		innodb_buffer_pool_chunk_size 默认是为 128MB
		
	
5. 相关参考

	http://mysql.taobao.org/monthly/2016/05/04/
	http://mysql.taobao.org/monthly/2018/03/06/
	https://www.leviathan.vip/2018/12/18/InnoDB%E7%9A%84BufferPool%E5%88%86%E6%9E%90/	
	http://mingxinglai.com/cn/2016/04/optimizing-in-MySQL57-buffer-pool/
	https://developer.aliyun.com/article/41130


6. innodb_buffer_pool_size 、 innnodb_buffer_pool_instaces 、innodb_buffer_pool_chunk_size 这3个参数的关系
	
	innodb_buffer_pool_size 可以划分为多个instance实例
	每个instance实例的大小由多个128MB大小的chunk组成
	
	innodb_buffer_pool_size 应一直保持是 innodb_buffer_pool_chunk_size*innodb_buffer_pool_instances 的倍数。
		128MB * 2 = 256MB 
		10GB = 10240MB
		8GB = 8192MB
		
		mysql> select 10240/256;
		+-----------+
		| 10240/256 |
		+-----------+
		|   40.0000 |
		+-----------+
		1 row in set (0.00 sec)

		mysql> select 8192/256;
		+----------+
		| 8192/256 |
		+----------+
		|  32.0000 |
		+----------+
		1 row in set (0.00 sec)
		
		10GB 或者 8GB 都是 innodb_buffer_pool_chunk_size*innodb_buffer_pool_instances 的倍数。
		
	
7. 从1个收缩案例看每个instance需要回收多少个chunk
	
	由 10GB -> 8GB 
	2个 instances
	1个chunk=128MB
	10GB: 
		每个 instance = 5GB, 每个instance有40个chunks
	8GB:
		每个 instance = 4GB, 每个instance有32个chunks
	
	因此, 每个 instance 需要回收 8个chunks
	
		
	


