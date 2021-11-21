	
	这里要结合之前的实验来看
	
	/*-------------------------------------------------------------*/
	/* PHASE 4: Look for matching records in a loop */

	rec = btr_pcur_get_rec(pcur);

	ut_ad(!!page_rec_is_comp(rec) == comp);

	if (page_rec_is_infimum(rec)) {

		/* The infimum record on a page cannot be in the result set,
		and neither can a record lock be placed on it: we skip such
		a record. */
		/*
			如果当前读取的记录是 Infimum 记录，则啥也不做，直接去读下一条记录。
		*/
		prev_rec = NULL;
		goto next_rec;
	}
	
	
	if (page_rec_is_supremum(rec)) {

		DBUG_EXECUTE_IF("compare_end_range",
				if (end_loop < 100) {
					end_loop = 100;
				});
		/** Compare the last record of the page with end range
		passed to InnoDB when there is no ICP and number of
		loops in row_search_mvcc for rows found but not
		reporting due to search views etc. */
		if (prev_rec != NULL && !prebuilt->innodb_api
		    && prebuilt->m_mysql_handler->end_range != NULL
		    && prebuilt->idx_cond == NULL && end_loop >= 100) {

			dict_index_t*	key_index = prebuilt->index;
			bool		clust_templ_for_sec = false;

			if (end_range_cache == NULL) {
				end_range_cache = static_cast<byte*>(
					ut_malloc_nokey(prebuilt->mysql_row_len));
			}

			if (index != clust_index
			    && prebuilt->need_to_access_clustered) {
				/** Secondary index record but the template
				based on PK. */
				/*
					二级索引记录但基于主键索引的模板
				*/
				key_index = clust_index;
				clust_templ_for_sec = true;
			}

			/** Create offsets based on prebuilt index. */
			offsets = rec_get_offsets(prev_rec, prebuilt->index,
					offsets, ULINT_UNDEFINED, &heap);

			if (row_sel_store_mysql_rec(
				end_range_cache, prebuilt, prev_rec, prev_vrow,
				clust_templ_for_sec, key_index, offsets,
				clust_templ_for_sec)) {

				if (row_search_end_range_check(
					end_range_cache,
					prebuilt->m_mysql_handler)) {

					/** In case of prebuilt->fetch,
					set the error in prebuilt->end_range. */
					if (next_buf != NULL) {
						prebuilt->m_end_range = true;
					}

					err = DB_RECORD_NOT_FOUND;
					goto normal_return;
				}
			}

			DEBUG_SYNC_C("allow_insert");
		}
		
		/*
			如果当前读取的记录是Supremum记录，则在下边这些条件成立的时候就会为记录添加一个类型为LOCK_ORDINARY的锁，其实也就是next-key锁:
				set_also_gap_locks是TRUE
				innodb_locks_unsafe_for_binlog=ON & 事务隔离级别为 REPEATABLE READ
				本次读取属于加锁读
		*/
	
		if (set_also_gap_locks
		    && !(srv_locks_unsafe_for_binlog
			 || trx->isolation_level <= TRX_ISO_READ_COMMITTED)
		    && prebuilt->select_lock_type != LOCK_NONE
		    && !dict_index_is_spatial(index)) {

			/* Try to place a lock on the index record */
			
			/* 尝试在索引记录上加锁 */
			/* If innodb_locks_unsafe_for_binlog option is used
			or this session is using a READ COMMITTED isolation
			level we do not lock gaps. Supremum record is really
			a gap and therefore we do not set locks there. */

			offsets = rec_get_offsets(rec, index, offsets,
						  ULINT_UNDEFINED, &heap);
			err = sel_set_rec_lock(pcur,
					       rec, index, offsets,
					       prebuilt->select_lock_type,
					       LOCK_ORDINARY, thr, &mtr);

			switch (err) {
			case DB_SUCCESS_LOCKED_REC:
				err = DB_SUCCESS;
			case DB_SUCCESS:
				break;
			default:
				goto lock_wait_or_error;
			}
		}

		/* A page supremum record cannot be in the result set: skip
		it now that we have placed a possible lock on it */

		prev_rec = NULL;
		goto next_rec;
	}

	/*-------------------------------------------------------------*/
	/* Do sanity checks in case our cursor has bumped into page
	corruption */

	if (comp) {
		next_offs = rec_get_next_offs(rec, TRUE);
		if (UNIV_UNLIKELY(next_offs < PAGE_NEW_SUPREMUM)) {

			goto wrong_offs;
		}
	} else {
		next_offs = rec_get_next_offs(rec, FALSE);
		if (UNIV_UNLIKELY(next_offs < PAGE_OLD_SUPREMUM)) {

			goto wrong_offs;
		}
	}

	if (UNIV_UNLIKELY(next_offs >= UNIV_PAGE_SIZE - PAGE_DIR)) {
