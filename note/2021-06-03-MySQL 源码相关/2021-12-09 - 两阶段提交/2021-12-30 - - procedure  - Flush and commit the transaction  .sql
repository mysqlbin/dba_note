  The procedure is:

  1. Queue ourselves for flushing.
	-- 排队等待做刷盘操作，也就是加入 flush 队列
	-- 这一步正在不断的有事务加入到这个FLUSH队列。第一个进入FLUSH队列的为本阶段的leader，非leader线程将会堵塞，直到COMMIT阶段后由leader线程的唤醒。
	
  2. Grab the log lock, which might result is blocking if the mutex is already held by another thread.
	-- 获取日志锁，如果互斥锁已被另一个线程持有，则可能会被阻塞
	
  3. If we were not committed while waiting for the lock
     1. Fetch the queue
     2. For each thread in the queue:
        a. Attach to it
        b. Flush the caches, saving any error code
     3. Flush and sync (depending on the value of sync_binlog).
     4. Signal that the binary log was updated
	 
  4. Release the log lock
	-- 释放日志锁
	
  5. Grab the commit lock
     1. For each thread in the queue:
        a. If there were no error when flushing and the transaction shall be committed:
           - Commit the transaction, saving the result of executing the commit.
  6. Release the commit lock
  7. Call purge, if any of the committed thread requested a purge.
  8. Return with the saved error code
