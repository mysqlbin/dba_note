
1. DML语句的执行流程如何与两阶段提交结合起来？

2. 
		
	源码：
		flush_error= process_flush_stage_queue(&total_bytes, &do_rotate,
													 &wait_queue);

		if (flush_error == 0 && total_bytes > 0)
		flush_error= flush_cache_to_file(&flush_end_pos);

	-----------------------------------------------------------------------------------

	对应的函数调用：
		-> MYSQL_BIN_LOG::process_flush_stage_queue -> MYSQL_BIN_LOG::flush_thread_caches

			-> MYSQL_BIN_LOG::flush_thread_caches -> binlog_cache_data::flush   -- 这里已经 flush
				
		flush_cache_to_file     这里又flush 一次?
		

3. after commit 、 after sync 是在哪个步骤
	
4. 
	1. 先把 binlog 从 binlog cache 中写到磁盘上的 binlog 文件；
	2. 调用 fsync 持久化。	

	老师，这两步我不不太理解，写到磁盘binlog文件，不就是持久化了吗，为啥还要调用fsync再刷一次盘呢？能否帮忙解答一下，感谢🙏

	答： write 很多次，fsync 一次。
