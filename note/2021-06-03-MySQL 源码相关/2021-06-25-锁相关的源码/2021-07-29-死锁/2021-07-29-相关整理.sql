

/** Restricts the search depth we will do in the waits-for graph of
transactions */
static const ulint	LOCK_MAX_DEPTH_IN_DEADLOCK_CHECK = 200;



当发生死锁时，需要选择一个牺牲者(DeadlockChecker::select_victim())来解决死锁，通常事务权重低的回滚(trx_weight_ge)

	1. 修改了非事务表的会话具有更高的权重；
	2. 如果两个表都修改了、或者都没有修改事务表，那么就根据事务的undo数量加上持有的事务锁个数来决定权重值（TRX_WEIGHT）；
		-- 事务的undo数量+持有的事务锁个数来决定权重
	3. 低权重的事务被回滚，高权重的获得锁对象。

	select_victim()返回一个选中需要被回滚的事务，MySQL 并不会迭代所有的 trx 来选择一个代价较小的事务，仅仅在m_start和 m_wait_lock ->trx这两个事务中选一个优先级较低的事务回滚.



死锁检测本身是通过持有全局大锁来进行的，代价非常高昂



在创建了一个处于WAIT状态的锁对象后，我们需要进行死锁检测（RecLock::deadlock_check）
	-- 先有锁等待现象，才可能引发死锁现象 
	
	