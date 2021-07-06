
1. sel_set_rec_lock--判断是否给主键索引还是二级索引的记录加锁
2. lock_sec_rec_read_check_and_lock--锁二级索引的记录
3. lock_clust_rec_read_check_and_lock--锁主键索引的记录
4. row_sel_get_clust_rec_for_mysql--根据二级索引的记录回表查找主键索引的记录
5. lock_sec_rec_modify_check_and_lock--对二级索引的记录加锁，用于update语句更新的时候有更新二级索引的数据
6. lock_rec_lock--行级锁加锁的入口函数

1. sel_set_rec_lock--判断是否给主键索引还是二级索引的记录加锁

	E:\github\mysql-5.7.26\storage\innobase\row\row0sel.cc
	/*********************************************************************//**
	Sets a lock on a record.
	@return DB_SUCCESS, DB_SUCCESS_LOCKED_REC, or error code */
	UNIV_INLINE
	dberr_t
	sel_set_rec_lock(
	/*=============*/
		btr_pcur_t*		pcur,	/*!< in: cursor */
		const rec_t*		rec,	/*!< in: record */
		dict_index_t*		index,	/*!< in: index */
		const ulint*		offsets,/*!< in: rec_get_offsets(rec, index) */
		ulint			mode,	/*!< in: lock mode */
		ulint			type,	/*!< in: LOCK_ORDINARY, LOCK_GAP, or
						LOC_REC_NOT_GAP */
		que_thr_t*		thr,	/*!< in: query thread */
		mtr_t*			mtr)	/*!< in: mtr */
	{
		trx_t*			trx;
		dberr_t			err = DB_SUCCESS;
		const buf_block_t*	block;

		block = btr_pcur_get_block(pcur);

		trx = thr_get_trx(thr);

		if (UT_LIST_GET_LEN(trx->lock.trx_locks) > 10000) {
			if (buf_LRU_buf_pool_running_out()) {

				return(DB_LOCK_TABLE_FULL);
			}
		}
		
		-- 对主键索引加锁
		if (dict_index_is_clust(index)) {
			err = lock_clust_rec_read_check_and_lock(
				0, block, rec, index, offsets,
				static_cast<lock_mode>(mode), type, thr);
		-- 对二级索引加锁
		} else {
			-- 空间索引，暂时忽略
			if (dict_index_is_spatial(index)) {
				if (type == LOCK_GAP || type == LOCK_ORDINARY) {
					ut_ad(0);
					ib::error() << "Incorrectly request GAP lock "
						"on RTree";
					return(DB_SUCCESS);
				}
				err = sel_set_rtr_rec_lock(pcur, rec, index, offsets,
							   mode, type, thr, mtr);
			} else {
				-- 对二级索引加锁
				err = lock_sec_rec_read_check_and_lock(
					0, block, rec, index, offsets,
					static_cast<lock_mode>(mode), type, thr);
			}
		}

		return(err);
	}


2. lock_sec_rec_read_check_and_lock--锁二级索引的记录

	/*********************************************************************//**
	Like lock_clust_rec_read_check_and_lock(), but reads a
	secondary index record.
	@return DB_SUCCESS, DB_SUCCESS_LOCKED_REC, DB_LOCK_WAIT, DB_DEADLOCK,
	or DB_QUE_THR_SUSPENDED */
	dberr_t
	lock_sec_rec_read_check_and_lock(
	/*=============================*/
		ulint			flags,	/*!< in: if BTR_NO_LOCKING_FLAG
						bit is set, does nothing */
		const buf_block_t*	block,	/*!< in: buffer block of rec */
		const rec_t*		rec,	/*!< in: user record or page
						supremum record which should
						be read or passed over by a
						read cursor */
		dict_index_t*		index,	/*!< in: secondary index */
		const ulint*		offsets,/*!< in: rec_get_offsets(rec, index) */
		lock_mode		mode,	/*!< in: mode of the lock which
						the read cursor should set on
						records: LOCK_S or LOCK_X; the
						latter is possible in
						SELECT FOR UPDATE */
		ulint			gap_mode,/*!< in: LOCK_ORDINARY, LOCK_GAP, or
						LOCK_REC_NOT_GAP */
		que_thr_t*		thr)	/*!< in: query thread */
	{
		dberr_t	err;
		ulint	heap_no;

		ut_ad(!dict_index_is_clust(index));
		ut_ad(!dict_index_is_online_ddl(index));
		ut_ad(block->frame == page_align(rec));
		ut_ad(page_rec_is_user_rec(rec) || page_rec_is_supremum(rec));
		ut_ad(rec_offs_validate(rec, index, offsets));
		ut_ad(mode == LOCK_X || mode == LOCK_S);

		if ((flags & BTR_NO_LOCKING_FLAG)
			|| srv_read_only_mode
			|| dict_table_is_temporary(index->table)) {

			return(DB_SUCCESS);
		}

		heap_no = page_rec_get_heap_no(rec);

		/* Some transaction may have an implicit x-lock on the record only
		if the max trx id for the page >= min trx id for the trx list or a
		database recovery is running. */

		if ((page_get_max_trx_id(block->frame) >= trx_rw_min_trx_id()
			 || recv_recovery_is_on())
			&& !page_rec_is_supremum(rec)) {

			lock_rec_convert_impl_to_expl(block, rec, index, offsets);
		}

		lock_mutex_enter();

		ut_ad(mode != LOCK_X
			  || lock_table_has(thr_get_trx(thr), index->table, LOCK_IX));
		ut_ad(mode != LOCK_S
			  || lock_table_has(thr_get_trx(thr), index->table, LOCK_IS));

		err = lock_rec_lock(FALSE, mode | gap_mode,
					block, heap_no, index, thr);

		MONITOR_INC(MONITOR_NUM_RECLOCK_REQ);

		lock_mutex_exit();

		ut_ad(lock_rec_queue_validate(FALSE, block, rec, index, offsets));

		return(err);
	}




3. lock_clust_rec_read_check_and_lock--锁主键索引的记录
	/*********************************************************************//**
	Checks if locks of other transactions prevent an immediate read, or passing
	over by a read cursor, of a clustered index record. If they do, first tests
	if the query thread should anyway be suspended for some reason; if not, then
	puts the transaction and the query thread to the lock wait state and inserts a
	waiting request for a record lock to the lock queue. Sets the requested mode
	lock on the record.
	@return DB_SUCCESS, DB_SUCCESS_LOCKED_REC, DB_LOCK_WAIT, DB_DEADLOCK,
	or DB_QUE_THR_SUSPENDED */
	dberr_t
	lock_clust_rec_read_check_and_lock(
	/*===============================*/
		ulint			flags,	/*!< in: if BTR_NO_LOCKING_FLAG
						bit is set, does nothing */
		const buf_block_t*	block,	/*!< in: buffer block of rec */
		const rec_t*		rec,	/*!< in: user record or page
						supremum record which should
						be read or passed over by a
						read cursor */
		dict_index_t*		index,	/*!< in: clustered index */
		const ulint*		offsets,/*!< in: rec_get_offsets(rec, index) */
		lock_mode		mode,	/*!< in: mode of the lock which
						the read cursor should set on
						records: LOCK_S or LOCK_X; the
						latter is possible in
						SELECT FOR UPDATE */
		ulint			gap_mode,/*!< in: LOCK_ORDINARY, LOCK_GAP, or
						LOCK_REC_NOT_GAP */
		que_thr_t*		thr)	/*!< in: query thread */
	{
		dberr_t	err;
		ulint	heap_no;

		ut_ad(dict_index_is_clust(index));
		ut_ad(block->frame == page_align(rec));
		ut_ad(page_rec_is_user_rec(rec) || page_rec_is_supremum(rec));
		ut_ad(gap_mode == LOCK_ORDINARY || gap_mode == LOCK_GAP
			  || gap_mode == LOCK_REC_NOT_GAP);
		ut_ad(rec_offs_validate(rec, index, offsets));

		if ((flags & BTR_NO_LOCKING_FLAG)
			|| srv_read_only_mode
			|| dict_table_is_temporary(index->table)) {

			return(DB_SUCCESS);
		}

		heap_no = page_rec_get_heap_no(rec);

		if (heap_no != PAGE_HEAP_NO_SUPREMUM) {

			lock_rec_convert_impl_to_expl(block, rec, index, offsets);
		}

		lock_mutex_enter();

		ut_ad(mode != LOCK_X
			  || lock_table_has(thr_get_trx(thr), index->table, LOCK_IX));
		ut_ad(mode != LOCK_S
			  || lock_table_has(thr_get_trx(thr), index->table, LOCK_IS));

		err = lock_rec_lock(FALSE, mode | gap_mode, block, heap_no, index, thr);

		MONITOR_INC(MONITOR_NUM_RECLOCK_REQ);

		lock_mutex_exit();

		ut_ad(lock_rec_queue_validate(FALSE, block, rec, index, offsets));

		DEBUG_SYNC_C("after_lock_clust_rec_read_check_and_lock");

		return(err);
	}


4. row_sel_get_clust_rec_for_mysql--根据二级索引的记录回表查找主键索引的记录
	/*********************************************************************//**
	Retrieves the clustered index record corresponding to a record in a
	non-clustered index. Does the necessary locking. Used in the MySQL
	interface.
	@return DB_SUCCESS, DB_SUCCESS_LOCKED_REC, or error code */
	static MY_ATTRIBUTE((warn_unused_result))
	dberr_t
	row_sel_get_clust_rec_for_mysql(
	/*============================*/
		row_prebuilt_t*	prebuilt,/*!< in: prebuilt struct in the handle */
		dict_index_t*	sec_index,/*!< in: secondary index where rec resides */
		const rec_t*	rec,	/*!< in: record in a non-clustered index; if
					this is a locking read, then rec is not
					allowed to be delete-marked, and that would
					not make sense either */
		que_thr_t*	thr,	/*!< in: query thread */
		const rec_t**	out_rec,/*!< out: clustered record or an old version of
					it, NULL if the old version did not exist
					in the read view, i.e., it was a fresh
					inserted version */
		ulint**		offsets,/*!< in: offsets returned by
					rec_get_offsets(rec, sec_index);
					out: offsets returned by
					rec_get_offsets(out_rec, clust_index) */
		mem_heap_t**	offset_heap,/*!< in/out: memory heap from which
					the offsets are allocated */
		const dtuple_t**vrow,	/*!< out: virtual column to fill */
		mtr_t*		mtr)	/*!< in: mtr used to get access to the
					non-clustered record; the same mtr is used to
					access the clustered index */
	{


		if (prebuilt->select_lock_type != LOCK_NONE) {
			/* Try to place a lock on the index record; we are searching
			the clust rec with a unique condition, hence
			we set a LOCK_REC_NOT_GAP type lock */

			err = lock_clust_rec_read_check_and_lock(
				0, btr_pcur_get_block(prebuilt->clust_pcur),
				clust_rec, clust_index, *offsets,
				static_cast<lock_mode>(prebuilt->select_lock_type),
				LOCK_REC_NOT_GAP,
				thr);

			switch (err) {
			case DB_SUCCESS:
			case DB_SUCCESS_LOCKED_REC:
				break;
			default:
				goto err_exit;
			}
		} else {
			/* This is a non-locking consistent read: if necessary, fetch
			a previous version of the record */

			old_vers = NULL;

			/* If the isolation level allows reading of uncommitted data,
			then we never look for an earlier version */

			if (trx->isolation_level > TRX_ISO_READ_UNCOMMITTED
				&& !lock_clust_rec_cons_read_sees(
					clust_rec, clust_index, *offsets,
					trx_get_read_view(trx))) {

				/* The following call returns 'offsets' associated with
				'old_vers' */
				err = row_sel_build_prev_vers_for_mysql(
					trx->read_view, clust_index, prebuilt,
					clust_rec, offsets, offset_heap, &old_vers,
					vrow, mtr);

				if (err != DB_SUCCESS || old_vers == NULL) {

					goto err_exit;
				}

				clust_rec = old_vers;
			}

			/* If we had to go to an earlier version of row or the
			secondary index record is delete marked, then it may be that
			the secondary index record corresponding to clust_rec
			(or old_vers) is not rec; in that case we must ignore
			such row because in our snapshot rec would not have existed.
			Remember that from rec we cannot see directly which transaction
			id corresponds to it: we have to go to the clustered index
			record. A query where we want to fetch all rows where
			the secondary index value is in some interval would return
			a wrong result if we would not drop rows which we come to
			visit through secondary index records that would not really
			exist in our snapshot. */

			/* And for spatial index, since the rec is from shadow buffer,
			so we need to check if it's exactly match the clust_rec. */
			if (clust_rec
				&& (old_vers
				|| trx->isolation_level <= TRX_ISO_READ_UNCOMMITTED
				|| dict_index_is_spatial(sec_index)
				|| rec_get_deleted_flag(rec, dict_table_is_comp(
								sec_index->table)))
				&& !row_sel_sec_rec_is_for_clust_rec(
					rec, sec_index, clust_rec, clust_index, thr)) {
				clust_rec = NULL;
			}

			err = DB_SUCCESS;
		}
	}
	



------------------------------------------------------------------------

5. lock_sec_rec_modify_check_and_lock--对二级索引的记录加锁，用于update语句更新的时候有更新二级索引的数据


	主要用于数据修改阶段加隐式锁，二级索引由于行数据的修改（update修改了本二级索引字包含段值或者尾部的主键）而被动维护的加锁。
	注意如果是select for update where条件是主键则不会加判断二级索引是否包含隐含锁，如果出现冲突会堵塞在主键上。

	对二级索引的记录加锁，用于update语句更新的时候有更新二级索引的数据

	/*********************************************************************//**
	Checks if locks of other transactions prevent an immediate modify (delete
	mark or delete unmark) of a secondary index record.
	@return DB_SUCCESS, DB_LOCK_WAIT, DB_DEADLOCK, or DB_QUE_THR_SUSPENDED */
	dberr_t
	lock_sec_rec_modify_check_and_lock(
	/*===============================*/
		ulint		flags,	/*!< in: if BTR_NO_LOCKING_FLAG
					bit is set, does nothing */
		buf_block_t*	block,	/*!< in/out: buffer block of rec */
		const rec_t*	rec,	/*!< in: record which should be
					modified; NOTE: as this is a secondary
					index, we always have to modify the
					clustered index record first: see the
					comment below */
		dict_index_t*	index,	/*!< in: secondary index */
		que_thr_t*	thr,	/*!< in: query thread
					(can be NULL if BTR_NO_LOCKING_FLAG) */
		mtr_t*		mtr)	/*!< in/out: mini-transaction */
	{
		dberr_t	err;
		ulint	heap_no;

		ut_ad(!dict_index_is_clust(index));
		ut_ad(!dict_index_is_online_ddl(index) || (flags & BTR_CREATE_FLAG));
		ut_ad(block->frame == page_align(rec));
		ut_ad(mtr->is_named_space(index->space));

		if (flags & BTR_NO_LOCKING_FLAG) {

			return(DB_SUCCESS);
		}
		ut_ad(!dict_table_is_temporary(index->table));

		heap_no = page_rec_get_heap_no(rec);

		/* Another transaction cannot have an implicit lock on the record,
		because when we come here, we already have modified the clustered
		index record, and this would not have been possible if another active
		transaction had modified this secondary index record. */

		lock_mutex_enter();

		ut_ad(lock_table_has(thr_get_trx(thr), index->table, LOCK_IX));

		err = lock_rec_lock(TRUE, LOCK_X | LOCK_REC_NOT_GAP,
					block, heap_no, index, thr);

		MONITOR_INC(MONITOR_NUM_RECLOCK_REQ);

		lock_mutex_exit();

	#ifdef UNIV_DEBUG
		{
			mem_heap_t*	heap		= NULL;
			ulint		offsets_[REC_OFFS_NORMAL_SIZE];
			const ulint*	offsets;
			rec_offs_init(offsets_);

			offsets = rec_get_offsets(rec, index, offsets_,
						  ULINT_UNDEFINED, &heap);

			ut_ad(lock_rec_queue_validate(
				FALSE, block, rec, index, offsets));

			if (heap != NULL) {
				mem_heap_free(heap);
			}
		}
	#endif /* UNIV_DEBUG */

		if (err == DB_SUCCESS || err == DB_SUCCESS_LOCKED_REC) {
			/* Update the page max trx id field */
			/* It might not be necessary to do this if
			err == DB_SUCCESS (no new lock created),
			but it should not cost too much performance. */
			page_update_max_trx_id(block,
						   buf_block_get_page_zip(block),
						   thr_get_trx(thr)->id, mtr);
			err = DB_SUCCESS;
		}

		return(err);
	}


6. lock_rec_lock--行级锁加锁的入口函数
	/*********************************************************************//**
	Tries to lock the specified record in the mode requested. If not immediately
	possible, enqueues a waiting lock request. This is a low-level function
	which does NOT look at implicit locks! Checks lock compatibility within
	explicit locks. This function sets a normal next-key lock, or in the case
	of a page supremum record, a gap type lock.
	@return DB_SUCCESS, DB_SUCCESS_LOCKED_REC, DB_LOCK_WAIT, DB_DEADLOCK,
	or DB_QUE_THR_SUSPENDED */
	static
	dberr_t
	lock_rec_lock(
	/*==========*/
		bool			impl,	/*!< in: if true, no lock is set
						if no wait is necessary: we
						assume that the caller will
						set an implicit lock */
		ulint			mode,	/*!< in: lock mode: LOCK_X or
						LOCK_S possibly ORed to either
						LOCK_GAP or LOCK_REC_NOT_GAP */
		const buf_block_t*	block,	/*!< in: buffer block containing
						the record */
		ulint			heap_no,/*!< in: heap number of record */
		dict_index_t*		index,	/*!< in: index of record */
		que_thr_t*		thr)	/*!< in: query thread */
	{
		ut_ad(lock_mutex_own());
		ut_ad(!srv_read_only_mode);
		ut_ad((LOCK_MODE_MASK & mode) != LOCK_S
			  || lock_table_has(thr_get_trx(thr), index->table, LOCK_IS));
		ut_ad((LOCK_MODE_MASK & mode) != LOCK_X
			  || lock_table_has(thr_get_trx(thr), index->table, LOCK_IX));
		ut_ad((LOCK_MODE_MASK & mode) == LOCK_S
			  || (LOCK_MODE_MASK & mode) == LOCK_X);
		ut_ad(mode - (LOCK_MODE_MASK & mode) == LOCK_GAP
			  || mode - (LOCK_MODE_MASK & mode) == LOCK_REC_NOT_GAP
			  || mode - (LOCK_MODE_MASK & mode) == 0);
		ut_ad(dict_index_is_clust(index) || !dict_index_is_online_ddl(index));

		/* We try a simplified and faster subroutine for the most
		common cases */
		switch (lock_rec_lock_fast(impl, mode, block, heap_no, index, thr)) {
		case LOCK_REC_SUCCESS:
			return(DB_SUCCESS);
		case LOCK_REC_SUCCESS_CREATED:
			return(DB_SUCCESS_LOCKED_REC);
		case LOCK_REC_FAIL:
			return(lock_rec_lock_slow(impl, mode, block,
						  heap_no, index, thr));
		}

		ut_error;
		return(DB_ERROR);
	}



------------------------------------------------------------------------


E:\github\mysql-5.7.26\storage\innobase\lock\lock0lock.cc
/*********************************************************************//**
Check whether the transaction has already been rolled back because it
was selected as a deadlock victim, or if it has to wait then cancel
the wait lock.
@return DB_DEADLOCK, DB_LOCK_WAIT or DB_SUCCESS */
dberr_t
lock_trx_handle_wait(
/*=================*/
	trx_t*	trx)	/*!< in/out: trx lock state */
{
	dberr_t	err;
	-- 行锁开销大
	lock_mutex_enter();

	trx_mutex_enter(trx);

	if (trx->lock.was_chosen_as_deadlock_victim) {
		err = DB_DEADLOCK;
	} else if (trx->lock.wait_lock != NULL) {
		lock_cancel_waiting_and_release(trx->lock.wait_lock);
		err = DB_LOCK_WAIT;
	} else {
		/* The lock was probably granted before we got here. */
		err = DB_SUCCESS;
	}

	lock_mutex_exit();

	trx_mutex_exit(trx);

	return(err);
}