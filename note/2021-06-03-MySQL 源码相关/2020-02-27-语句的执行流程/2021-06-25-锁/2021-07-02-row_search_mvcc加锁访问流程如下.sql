
	dberr_t
	row_search_mvcc(
		byte*		buf,
		page_cur_mode_t	mode,
		row_prebuilt_t*	prebuilt,
		ulint		match_mode,
		ulint		direction)
	{


	
	-- 第1步：判断是否是唯一索引的等值查询
	if (match_mode == ROW_SEL_EXACT
	    && dict_index_is_unique(index)
	    && dtuple_get_n_fields(search_tuple)
	    == dict_index_get_n_unique(index)
	    && (dict_index_is_clust(index)
		|| !dtuple_contains_null(search_tuple))) {

		/* Note above that a UNIQUE secondary index can contain many
		rows with the same key value if one of the columns is the SQL
		null. A clustered index under MySQL can never contain null
		columns because we demand that all the columns in primary key
		are non-null. */
		-- 等值查询，并且查询的索引为聚族索引 */
        -- 或者查询的索引为辅助索引且辅助索引是唯一的且查询条件中不含有NULL值*/
		unique_search = TRUE;

	}

	
	-- 第2步：对表加意向锁
	wait_table_again:
			--  根据行锁类型获取相应的意向锁
			err = lock_table(0, index->table,
					 prebuilt->select_lock_type == LOCK_S
					 ? LOCK_IS : LOCK_IX, thr);
			-- 加意向锁失败，处于锁等待状态
			if (err != DB_SUCCESS) {

				table_lock_waited = TRUE;
				goto lock_table_wait;
			}
			prebuilt->sql_stat_start = FALSE;
		}

		-- 根据查询条件search_tuple建立B+树的cursor
		btr_pcur_open_with_no_init(index, search_tuple, mode, BTR_SEARCH_LEAF, pcur, 0, &mtr);

		
	-- 第3步：获取行数据
	rec_loop:
		DEBUG_SYNC_C("row_search_rec_loop");
		
		/*-------------------------------------------------------------*/
		/* PHASE 4: Look for matching records in a loop */
		
		-- 从cursor中读取行记录，也就是根据条件获取行数据
		rec = btr_pcur_get_rec(pcur);


	-- 第4点：添加行锁
	wrong_offs:
		
		prev_rec = rec;
		
		-- 加间隙锁
		-- 非唯一索引的等值查询
		if (match_mode == ROW_SEL_EXACT) {    --等值查询
				
			if (0 != cmp_dtuple_rec(search_tuple, rec, offsets)) {
				
				-- 间隙锁
				if (set_also_gap_locks
					&& !(srv_locks_unsafe_for_binlog
					 || trx->isolation_level
					 <= TRX_ISO_READ_COMMITTED)
					&& prebuilt->select_lock_type != LOCK_NONE
					&& !dict_index_is_spatial(index)) {

					/* Try to place a gap lock on the index record only if innodb_locks_unsafe_for_binlog option is not set or this session is not using a READ COMMITTED isolation level. */
					仅当 innodb_locks_unsafe_for_binlog 选项未设置或此会话未使用 READ COMMITTED 隔离级别时，才尝试在索引记录上放置间隙锁
					如何解决幻读的:
						1、MySQL在RR隔离级别引入gap lock，把2条记录中间的gap锁住，避免其他事务写入(例如在二级索引上锁定记录1-3之间的gap，那么其他会话无法在这个gap间插入数据)
						2、MySQL出现幻读的条件是隔离级别<=RC，或者 innodb_locks_unsafe_for_binlog=1(8.0已取消该选项)
					
					- LOCK_GAP 512

					只锁住索引记录之间或者第一条索引记录前或者最后一条索引记录之后的范围，并不锁住记录本身。  --《4.1.1 唯一索引等值查询间隙锁》

					例如在RR隔离级别下，非唯一索引条件上的等值当前读，会在等值记录上加NEXT-KEY LOCK同时锁住行和前面范围的记录，同时会在后面一个值上加LOCK\_GAP锁住下一个值前面的范围。
					
					err = sel_set_rec_lock(
						pcur,
						rec, index, offsets,
						prebuilt->select_lock_type, LOCK_GAP,
						thr, &mtr);

					switch (err) {
					case DB_SUCCESS_LOCKED_REC:
					case DB_SUCCESS:
						break;
					default:
						goto lock_wait_or_error;
					}
				}

				btr_pcur_store_position(pcur, &mtr);
				
				ut_ad(pcur->rel_pos == BTR_PCUR_ON);
				pcur->rel_pos = BTR_PCUR_BEFORE;

				err = DB_RECORD_NOT_FOUND;
				goto normal_return;
			}
		
		} else if (match_mode == ROW_SEL_EXACT_PREFIX) {

			if (!cmp_dtuple_is_prefix_of_rec(search_tuple, rec, offsets)) {
				-- 间隙锁
				if (set_also_gap_locks
					&& !(srv_locks_unsafe_for_binlog
					 || trx->isolation_level
					 <= TRX_ISO_READ_COMMITTED)
					&& prebuilt->select_lock_type != LOCK_NONE
					&& !dict_index_is_spatial(index)) {

		
					err = sel_set_rec_lock(
						pcur,
						rec, index, offsets,
						prebuilt->select_lock_type, LOCK_GAP,
						thr, &mtr);

					switch (err) {
					case DB_SUCCESS_LOCKED_REC:
					case DB_SUCCESS:
						break;
					default:
						goto lock_wait_or_error;
					}
				}

				btr_pcur_store_position(pcur, &mtr);

				/* The found record was not a match, but may be used
				as NEXT record (index_next). Set the relative position
				to BTR_PCUR_BEFORE, to reflect that the position of
				the persistent cursor is before the found/stored row
				(pcur->old_rec). */
				ut_ad(pcur->rel_pos == BTR_PCUR_ON);
				pcur->rel_pos = BTR_PCUR_BEFORE;

				err = DB_RECORD_NOT_FOUND;
				goto normal_return;
			}

		}


		ulint		select_lock_type;/*!< LOCK_NONE, LOCK_S, or LOCK_X */


		-- 添加行锁
		if (prebuilt->select_lock_type != LOCK_NONE) {
			
				 -- 锁定义，需要根据 lock_type 加相应的锁 
				 
				ulint	lock_type;;
				
				if (!set_also_gap_locks   --没有间隙锁
					|| srv_locks_unsafe_for_binlog
					|| trx->isolation_level <= TRX_ISO_READ_COMMITTED
					|| (unique_search && !rec_get_deleted_flag(rec, comp))  -- unique_search唯一索引查找
					|| dict_index_is_spatial(index)) {
					
					-- 唯一查询，加 LOCK_REC_NOT_GAP 锁
					goto no_gap_lock;
					
				} else {
				
					-- 非唯一索引查询，加 next-key lock
					lock_type = LOCK_ORDINARY;
				}
				
				-- id 为主键索引，WHERE id >= 100
				-- 那么不需要锁定该 id=100 记录之前的间隙
				
		
				-- 聚集索引的加锁	
				if (index == clust_index
					&& mode == PAGE_CUR_GE
					&& direction == 0
					&& dtuple_get_n_fields_cmp(search_tuple)
					== dict_index_get_n_unique(index)
					&& 0 == cmp_dtuple_rec(search_tuple, rec, offsets)) {
		no_gap_lock:
					-- 锁的类型为行锁
					lock_type = LOCK_REC_NOT_GAP;
				}
				
				-- 进行加锁
				err = sel_set_rec_lock(pcur,
					   rec, index, offsets,
					   prebuilt->select_lock_type,
					   lock_type, thr, &mtr);
					   
				-- 根据返回值 err 判断加锁是否成功	   
				switch (err) {
					const rec_t*	old_vers;
					
				-- 创建锁成功，加锁成功 
				case DB_SUCCESS_LOCKED_REC:
					if (srv_locks_unsafe_for_binlog
						|| trx->isolation_level
						<= TRX_ISO_READ_COMMITTED) {
						/* Note that a record of
						prebuilt->index was locked. */
						prebuilt->new_rec_locks = 1;
					}
					
					err = DB_SUCCESS;
					// Fall through
					
				-- 找到了当前事务之前创建并且兼容的锁，复用之，加锁成功	
				case DB_SUCCESS:
					break;
					
				-- 加锁不成功，因为有锁等待
				case DB_LOCK_WAIT:
					/* Lock wait for R-tree should already
					be handled in sel_set_rtr_rec_lock() */
					ut_ad(!dict_index_is_spatial(index));
					/* Never unlock rows that were part of a conflict. */
					prebuilt->new_rec_locks = 0;

					if (UNIV_LIKELY(prebuilt->row_read_type
							!= ROW_READ_TRY_SEMI_CONSISTENT)
						|| unique_search
						|| index != clust_index) {
						-- 处理lock wait错误
						goto lock_wait_or_error;
					}

					-- 检查是否为死锁，如果不是死锁，则事务必须等待，然后释放它正在等待的锁。
					
					err = lock_trx_handle_wait(trx);

					switch (err) {
					-- 加锁成功
					case DB_SUCCESS:

						offsets = rec_get_offsets(
							rec, index, offsets, ULINT_UNDEFINED,
							&heap);
						goto locks_ok;
					-- 死锁
					case DB_DEADLOCK:
						goto lock_wait_or_error;
					-- 锁等待
					case DB_LOCK_WAIT:
						ut_ad(!dict_index_is_spatial(index));
						err = DB_SUCCESS;
						break;
					default:
						ut_error;
					}
				-- 没有找到记录	
				case DB_RECORD_NOT_FOUND:
					if (dict_index_is_spatial(index)) {
						goto next_rec;
					} else {
						goto lock_wait_or_error;
					}

				default:

					goto lock_wait_or_error;
				}
		}



lock_wait_or_error:
	/* Reset the old and new "did semi-consistent read" flags. */
	if (UNIV_UNLIKELY(prebuilt->row_read_type
			  == ROW_READ_DID_SEMI_CONSISTENT)) {
		prebuilt->row_read_type = ROW_READ_TRY_SEMI_CONSISTENT;
	}
	did_semi_consistent_read = FALSE;

	/*-------------------------------------------------------------*/
	if (!dict_index_is_spatial(index)) {
		btr_pcur_store_position(pcur, &mtr);
	}



