

Buffer Pool 提供了专门的一个线程buf_resize_thread来完成 resize 过程, 具体的操作函数是 buf_pool_resize()，resize 流程如下:


在线收缩BP缓冲池的流程

	1. 假如开启了 AHI, 需要关闭 AHI.

	2. 假如是缩小 Buffer Pool 的大小, 需要设置每个 Buffer Pool Instance 的 withdraw_target , 即设置回收的 Page 数目.
		
		在函数 buf_pool_withdraw_blocks() 进行回收 Page 操作:
		
			遍历buffer pool instances，锁住buffer pool
			
				首先从buf_pool->free开始回收, 将 Page 从free_list中释放, 插入 withdraw list.
		
				假如从free_list中回收的 Page 数目没有达到要求, 则需要继续从 lru_list 中回收. 将脏页刷盘, 然后插入 withdraw_list .
			
			释放buffer pool锁
			
			
	3. 停止加载 Buffer Pool

	4. 开始 resize
			
		锁住所有instance的buffer_pool，page_hash
		
		以chunk为单位释放要收缩的内存
		
		清空 withdraw list
		
		更新每个 Buffer Pool Instance 的大小buf_pool->curr_size 和 Chunk数量buf_pool->n_chunks_new, Page 数目等.

		假如 Buffer Pool 的大小扩大了2倍或者缩小了2倍, 则需要新建新的page_hash和zip_hash.
		
		释放buffer_pool,page_hash锁

	5. 重新开启 AHI.
	
	6. 结合 源码+错误日志+文章 来整理的流程.
	
	

应用场景:
	收缩BP缓冲池空间大小的场景: 由于设置得太大, 数据库在运行一段时间后, 加上其它线程占用的内存, 导致物理内存剩余空间比较少, 容易引发OOM, 不需要重启数据库, 可以选择在业务低峰期进行回收内存, 避免OOM
	
	

-- 这个函数被注册为 MySQL 的回调。
/** Update the system variable innodb_buffer_pool_size using the "saved"
value. This function is registered as a callback with MySQL.
@param[in]	thd	thread handle
@param[in]	var	pointer to system variable
@param[out]	var_ptr	where the formal string goes
@param[in]	save	immediate result from check function */
static
void
innodb_buffer_pool_size_update(
	THD*				thd,
	struct st_mysql_sys_var*	var,
	void*				var_ptr,
	const void*			save)
{
        longlong	in_val = *static_cast<const longlong*>(save);

	ut_snprintf(export_vars.innodb_buffer_pool_resize_status,
	        sizeof(export_vars.innodb_buffer_pool_resize_status),
		"Requested to resize buffer pool.");
	-- 发送信号量srv_buf_resize_event.然后立刻返回
	os_event_set(srv_buf_resize_event);

	ib::info() << export_vars.innodb_buffer_pool_resize_status
		<< " (new size: " << in_val << " bytes)";
}

设置变量innodb_buffer_pool_size时，触发函数innodb_buffer_pool_size_update，在必要的检查后（例如避免重复发送请求，或者resize的太小），发送信号量srv_buf_resize_event.然后立刻返回
因此设置变量成功，不等于bp 的size已经调整好了，只是发出了 一个resize请求而已.





