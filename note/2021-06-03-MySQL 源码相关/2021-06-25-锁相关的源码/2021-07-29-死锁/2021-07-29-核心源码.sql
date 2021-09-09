

基本的代码流程如下

	-- 检查是否存在和当前申请锁模式冲突的锁（lock_rec_other_has_conflicting），如果存在的话，就创建一个锁对象（RecLock::RecLock），并加入到等待队列中（RecLock::add_to_waitq），这里会进行死锁检测;
	-- 当发现有冲突的锁时，调用函数 RecLock::add_to_waitq 进行锁等待/死锁的判断
	-- @return DB_LOCK_WAIT, DB_DEADLOCK, or DB_QUE_THR_SUSPENDED, or DB_SUCCESS_LOCKED_REC;
	RecLock::add_to_waitq
		-- 进行死锁的检测
		RecLock::deadlock_check
			-- 进行死锁检测，假如存在死锁返回一个需要被回滚的事务
			DeadlockChecker::check_and_resolve
				-- 进行死锁检测，并返回选中要回滚的事务.
				DeadlockChecker::search
					-- 选择1个牺牲者作为要回滚的事务
					DeadlockChecker::select_victim
			-- 检查死锁检测的结果	
			RecLock::check_deadlock_result
		-- 回滚事务1	
		DeadlockChecker::trx_rollback

	-- 打印有关已回滚的事务的信息	
	DeadlockChecker::rollback_print


/**
Enqueue a lock wait for normal transaction. If it is a high priority transaction
then jump the record lock wait queue and if the transaction at the head of the
queue is itself waiting roll it back, also do a deadlock check and resolve.
@param[in, out] wait_for	The lock that the joining transaction is
				waiting for
@param[in] prdt			Predicate [optional]
@return DB_LOCK_WAIT, DB_DEADLOCK, or DB_QUE_THR_SUSPENDED, or
	DB_SUCCESS_LOCKED_REC; DB_SUCCESS_LOCKED_REC means that
	there was a deadlock, but another transaction was chosen
	as a victim, and we got the lock immediately: no need to
	wait then */
dberr_t
RecLock::add_to_waitq(const lock_t* wait_for, const lock_prdt_t* prdt)
{
	ut_ad(lock_mutex_own());
	ut_ad(m_trx == thr_get_trx(m_thr));
	ut_ad(trx_mutex_own(m_trx));

	DEBUG_SYNC_C("rec_lock_add_to_waitq");

	m_mode |= LOCK_WAIT;

	/* Do the preliminary checks, and set query thread state */

	prepare();

	bool	high_priority = trx_is_high_priority(m_trx);

	/* Don't queue the lock to hash table, if high priority transaction. */
	lock_t*	lock = create(m_trx, true, !high_priority, prdt);

	/* Attempt to jump over the low priority waiting locks. */
	if (high_priority && jump_queue(lock, wait_for)) {

		/* Lock is granted */
		return(DB_SUCCESS);
	}

	ut_ad(lock_get_wait(lock));
	
	-- 进行死锁的检测
	dberr_t	err = deadlock_check(lock);

	ut_ad(trx_mutex_own(m_trx));

	/* m_trx->mysql_thd is NULL if it's an internal trx. So current_thd is used */
	if (err == DB_LOCK_WAIT) {
		thd_report_row_lock_wait(current_thd, wait_for->trx->mysql_thd);
	}
	return(err);
}



-- 进行死锁的检测
/**
Check and resolve any deadlocks
@param[in, out] lock		The lock being acquired
@return DB_LOCK_WAIT, DB_DEADLOCK, or DB_QUE_THR_SUSPENDED, or
	DB_SUCCESS_LOCKED_REC; DB_SUCCESS_LOCKED_REC means that
	there was a deadlock, but another transaction was chosen
	as a victim, and we got the lock immediately: no need to
	wait then */
dberr_t
RecLock::deadlock_check(lock_t* lock)
{
	
	ut_ad(lock_mutex_own());
	ut_ad(lock->trx == m_trx);
	ut_ad(trx_mutex_own(m_trx));

	const trx_t*	victim_trx =
			DeadlockChecker::check_and_resolve(lock, m_trx);

	/* Check the outcome of the deadlock test. It is possible that
	the transaction that blocked our lock was rolled back and we
	were granted our lock. */
	
	dberr_t	err = check_deadlock_result(victim_trx, lock);

	if (err == DB_LOCK_WAIT) {

		set_wait_state(lock);

		MONITOR_INC(MONITOR_LOCKREC_WAIT);
	}

	return(err);
}


/* 死锁检测，假如存在死锁返回一个需要被回滚的事务. */

/** Checks if a joining lock request results in a deadlock. If a deadlock is
found this function will resolve the deadlock by choosing a victim transaction
and rolling it back. It will attempt to resolve all deadlocks. The returned
transaction id will be the joining transaction instance or NULL if some other
transaction was chosen as a victim and rolled back or no deadlock found.

/*
 检查自己的加入也就是申请持有锁是否会导致死锁
 如果发现死锁，此函数将通过选择受害者事务并将其回滚来解决死锁。 
 它将尝试解决所有死锁。 
 返回的事务 id 将是加入的事务实例或 NULL，如果某个其他事务被选为受害者并回滚或未发现死锁

*/

@param[in]	lock lock the transaction is requesting
@param[in,out]	trx transaction requesting the lock

@return transaction instanace chosen as victim or 0 */
const trx_t*
DeadlockChecker::check_and_resolve(const lock_t* lock, trx_t* trx)
{
	-- 确保同时持有 lock_sys->mutex 和 trx->mutex. 
	ut_ad(lock_mutex_own());
	ut_ad(trx_mutex_own(trx));
	check_trx_state(trx);
	ut_ad(!srv_read_only_mode);

	/* If transaction is marked for ASYNC rollback then we should
	not allow it to wait for another lock causing possible deadlock.
	We return current transaction as deadlock victim here. */
	if (trx->in_innodb & TRX_FORCE_ROLLBACK_ASYNC) {
		return(trx);
	} else if (!innobase_deadlock_detect) {
		return(NULL);
	}

	/*  Release the mutex to obey the latching order.
	This is safe, because DeadlockChecker::check_and_resolve()
	is invoked when a lock wait is enqueued for the currently
	running transaction. Because m_trx is a running transaction
	(it is not currently suspended because of a lock wait),
	its state can only be changed by this thread, which is
	currently associated with the transaction. */
	
	-- 释放 trx->mutex: trx 的事务状态只能被当前 thread 修改, 所以是安全的. 
	trx_mutex_exit(trx);

	const trx_t*	victim_trx;
	
	-- 尝试解决尽可能多的死锁
	/* Try and resolve as many deadlocks as possible. */
	do {
		-- 构建死锁检测 DeadlockChecker. 
		DeadlockChecker	checker(trx, lock, s_lock_mark_counter);
		
		-- 进行死锁检测，并返回选中要回滚的事务.
		victim_trx = checker.search();

		/* Search too deep, we rollback the joining transaction only
		if it is possible to rollback. Otherwise we rollback the
		transaction that is holding the lock that the joining
		transaction wants. */
		if (checker.is_too_deep()) {
			
			-- 假如死锁检测过深, 打印死锁信息.
			ut_ad(trx == checker.m_start);
			ut_ad(trx == victim_trx);
			
			-- 打印有关已回滚的事务的信息。
			rollback_print(victim_trx, lock);

			MONITOR_INC(MONITOR_DEADLOCK);

			break;
			
		-- 如果需要回滚的是其他事务，那么调用 checker.trx_rollback() 进行回滚
		-- 回滚的是造成死锁的第1个事务
		} else if (victim_trx != NULL && victim_trx != trx) {

			ut_ad(victim_trx == checker.m_wait_lock->trx);
			
			-- 回滚事务1
			checker.trx_rollback();
			print("*** WE ROLL BACK TRANSACTION (1)\n");
			
			lock_deadlock_found = true;

			MONITOR_INC(MONITOR_DEADLOCK);
		}

	} while (victim_trx != NULL && victim_trx != trx);
	
	/* If the joining transaction was selected as the victim. */
	-- 回滚当前事务，非第1个事务
	if (victim_trx != NULL) {
		
		-- 回滚事务2
		print("*** WE ROLL BACK TRANSACTION (2)\n");

		lock_deadlock_found = true;
	}
	
	-- 重新持有 trx->mutex 锁. 
	trx_mutex_enter(trx);

	return(victim_trx);
}


-- 检查死锁检测的结果.
 
/**
Check the outcome of the deadlock check
@param[in,out] victim_trx	Transaction selected for rollback
@param[in,out] lock		Lock being requested
@return DB_LOCK_WAIT, DB_DEADLOCK or DB_SUCCESS_LOCKED_REC */
dberr_t
RecLock::check_deadlock_result(const trx_t* victim_trx, lock_t* lock)
{
	ut_ad(lock_mutex_own());
	ut_ad(m_trx == lock->trx);
	ut_ad(trx_mutex_own(m_trx));

	if (victim_trx != NULL) {

		ut_ad(victim_trx == m_trx);

		lock_reset_lock_and_trx_wait(lock);

		lock_rec_reset_nth_bit(lock, m_rec_id.m_heap_no);

		return(DB_DEADLOCK);

	} else if (m_trx->lock.wait_lock == NULL) {

		/* If there was a deadlock but we chose another
		transaction as a victim, it is possible that we
		already have the lock now granted! */

		return(DB_SUCCESS_LOCKED_REC);
	}

	return(DB_LOCK_WAIT);
}




/** Rollback transaction selected as the victim. */
void
DeadlockChecker::trx_rollback()
{
	ut_ad(lock_mutex_own());

	trx_t*	trx = m_wait_lock->trx;

	print("*** WE ROLL BACK TRANSACTION (1)\n");

	trx_mutex_enter(trx);

	trx->lock.was_chosen_as_deadlock_victim = true;

	lock_cancel_waiting_and_release(trx->lock.wait_lock);

	trx_mutex_exit(trx);
}


-- 关于MySQL死锁检测如何判断是否存在死锁核心代码在函数DeadlockChecker::search()
-- 迭代查找死锁。
-- 注意：加入事务可能已通过死锁检查获得锁定

/** Looks iteratively for a deadlock. Note: the joining transaction may
have been granted its lock by the deadlock checks.
@return 0 if no deadlock else the victim transaction instance.*/
const trx_t*
DeadlockChecker::search()
{
	ut_ad(lock_mutex_own());
	ut_ad(!trx_mutex_own(m_start));

	ut_ad(m_start != NULL);
	ut_ad(m_wait_lock != NULL);
	check_trx_state(m_wait_lock->trx);
	ut_ad(m_mark_start <= s_lock_mark_counter);

	/* Look at the locks ahead of wait_lock in the lock queue. */
	ulint		heap_no;
	const lock_t*	lock = get_first_lock(&heap_no);

	for (;;) {

		/* We should never visit the same sub-tree more than once. */
		ut_ad(lock == NULL || !is_visited(lock));

		while (m_n_elems > 0 && lock == NULL) {

			/* Restore previous search state. */

			pop(lock, heap_no);

			lock = get_next_lock(lock, heap_no);
		}

		if (lock == NULL) {
			break;
		} else if (lock == m_wait_lock) {

			/* We can mark this subtree as searched */
			ut_ad(lock->trx->lock.deadlock_mark <= m_mark_start);

			lock->trx->lock.deadlock_mark = ++s_lock_mark_counter;

			/* We are not prepared for an overflow. This 64-bit
			counter should never wrap around. At 10^9 increments
			per second, it would take 10^3 years of uptime. */

			ut_ad(s_lock_mark_counter > 0);

			/* Backtrack */
			lock = NULL;

		} else if (!lock_has_to_wait(m_wait_lock, lock)) {

			/* No conflict, next lock */
			lock = get_next_lock(lock, heap_no);

		} else if (lock->trx == m_start) {

			/* Found a cycle. */

			notify(lock);

			return(select_victim());

		} else if (is_too_deep()) {

			/* Search too deep to continue. */
			m_too_deep = true;
			return(m_start);

		} else if (lock->trx->lock.que_state == TRX_QUE_LOCK_WAIT) {

			/* Another trx ahead has requested a lock in an
			incompatible mode, and is itself waiting for a lock. */

			++m_cost;

			if (!push(lock, heap_no)) {
				m_too_deep = true;
				return(m_start);
			}


			m_wait_lock = lock->trx->lock.wait_lock;

			lock = get_first_lock(&heap_no);

			if (is_visited(lock)) {
				lock = get_next_lock(lock, heap_no);
			}

		} else {
			lock = get_next_lock(lock, heap_no);
		}
	}

	ut_a(lock == NULL && m_n_elems == 0);

	/* No deadlock found. */
	return(0);
}


/** Select the victim transaction that should be rolledback.
@return victim transaction */
const trx_t*
DeadlockChecker::select_victim() const
{
	ut_ad(lock_mutex_own());
	ut_ad(m_start->lock.wait_lock != 0);
	ut_ad(m_wait_lock->trx != m_start);

	-- 判断权重
	-- 这里的代码还没看懂
	if (thd_trx_priority(m_start->mysql_thd) > 0
	    || thd_trx_priority(m_wait_lock->trx->mysql_thd) > 0) {

		const trx_t*	victim;

		victim = trx_arbitrate(m_start, m_wait_lock->trx);

		if (victim != NULL) {

			return(victim);
		}
	}

	if (trx_weight_ge(m_wait_lock->trx, m_start)) {
		-- 加入代价最小的事务，选择它作为牺牲者并回滚
		/* The joining transaction is 'smaller',
		choose it as the victim and roll it back. */

		return(m_start);
	}

	return(m_wait_lock->trx);
}

--打印有关已回滚的事务的信息。
/** Print info about transaction that was rolled back.
@param trx transaction rolled back
@param lock lock trx wants */
void
DeadlockChecker::rollback_print(const trx_t*	trx, const lock_t* lock)
{
	ut_ad(lock_mutex_own());

	/* If the lock search exceeds the max step
	or the max depth, the current trx will be
	the victim. Print its information. */
	start_print();

	print("TOO DEEP OR LONG SEARCH IN THE LOCK TABLE"
	      " WAITS-FOR GRAPH, WE WILL ROLL BACK"
	      " FOLLOWING TRANSACTION \n\n"
	      "*** TRANSACTION:\n");

	print(trx, 3000);

	print("*** WAITING FOR THIS LOCK TO BE GRANTED:\n");

	print(lock);
}



