
/********************************************************************//**
Searches an index tree and positions a tree cursor on a given level.
NOTE: n_fields_cmp in tuple must be set so that it cannot be compared
to node pointer page number fields on the upper levels of the tree!
Note that if mode is PAGE_CUR_LE, which is used in inserts, then
cursor->up_match and cursor->low_match both will have sensible values.
If mode is PAGE_CUR_GE, then up_match will a have a sensible value.

If mode is PAGE_CUR_LE , cursor is left at the place where an insert of the
search tuple should be performed in the B-tree. InnoDB does an insert
immediately after the cursor. Thus, the cursor may end up on a user record,
or on a page infimum record. */
void
btr_cur_search_to_nth_level(
/*========================*/
	dict_index_t*	index,	/*!< in: index */
	ulint		level,	/*!< in: the tree level of search */
	const dtuple_t*	tuple,	/*!< in: data tuple; NOTE: n_fields_cmp in
				tuple must be set so that it cannot get
				compared to the node ptr page number field! */
	page_cur_mode_t	mode,	/*!< in: PAGE_CUR_L, ...;
				Inserts should always be made using
				PAGE_CUR_LE to search the position! */
	ulint		latch_mode, /*!< in: BTR_SEARCH_LEAF, ..., ORed with
				at most one of BTR_INSERT, BTR_DELETE_MARK,
				BTR_DELETE, or BTR_ESTIMATE;
				cursor->left_block is used to store a pointer
				to the left neighbor page, in the cases
				BTR_SEARCH_PREV and BTR_MODIFY_PREV;
				NOTE that if has_search_latch
				is != 0, we maybe do not have a latch set
				on the cursor page, we assume
				the caller uses his search latch
				to protect the record! */
	btr_cur_t*	cursor, /*!< in/out: tree cursor; the cursor page is
				s- or x-latched, but see also above! */
	ulint		has_search_latch,
				/*!< in: info on the latch mode the
				caller currently has on search system:
				RW_S_LATCH, or 0 */
	const char*	file,	/*!< in: file name */
	ulint		line,	/*!< in: line where called */
	mtr_t*		mtr)	/*!< in: mtr */
{
	page_t*		page = NULL; /* remove warning */
	buf_block_t*	block;
	buf_block_t*	guess;
	ulint		height;
	ulint		up_match;
	ulint		up_bytes;
	ulint		low_match;
	ulint		low_bytes;
	ulint		savepoint;
	ulint		rw_latch;
	page_cur_mode_t	page_mode;
	page_cur_mode_t	search_mode = PAGE_CUR_UNSUPP;
	ulint		buf_mode;
	ulint		estimate;
	ulint		node_ptr_max_size = UNIV_PAGE_SIZE / 2;
	page_cur_t*	page_cursor;
	btr_op_t	btr_op;
	ulint		root_height = 0; /* remove warning */

	ulint		upper_rw_latch, root_leaf_rw_latch;
	btr_intention_t	lock_intention;
	bool		modify_external;
	buf_block_t*	tree_blocks[BTR_MAX_LEVELS];
	ulint		tree_savepoints[BTR_MAX_LEVELS];
	ulint		n_blocks = 0;
	ulint		n_releases = 0;
	bool		detected_same_key_root = false;

	bool		retrying_for_search_prev = false;
	ulint		leftmost_from_level = 0;
	buf_block_t**	prev_tree_blocks = NULL;
	ulint*		prev_tree_savepoints = NULL;
	ulint		prev_n_blocks = 0;
	ulint		prev_n_releases = 0;
	bool		need_path = true;
	bool		rtree_parent_modified = false;
	bool		mbr_adj = false;
	bool		found = false;

	DBUG_ENTER("btr_cur_search_to_nth_level");

#ifdef BTR_CUR_ADAPT
	btr_search_t*	info;
#endif /* BTR_CUR_ADAPT */
	mem_heap_t*	heap		= NULL;
	ulint		offsets_[REC_OFFS_NORMAL_SIZE];
	ulint*		offsets		= offsets_;
	ulint		offsets2_[REC_OFFS_NORMAL_SIZE];
	ulint*		offsets2	= offsets2_;
	rec_offs_init(offsets_);
	rec_offs_init(offsets2_);
	/* Currently, PAGE_CUR_LE is the only search mode used for searches
	ending to upper levels */

	ut_ad(level == 0 || mode == PAGE_CUR_LE
	      || RTREE_SEARCH_MODE(mode));
	ut_ad(dict_index_check_search_tuple(index, tuple));
	ut_ad(!dict_index_is_ibuf(index) || ibuf_inside(mtr));
	ut_ad(dtuple_check_typed(tuple));
	ut_ad(!(index->type & DICT_FTS));
	ut_ad(index->page != FIL_NULL);

	UNIV_MEM_INVALID(&cursor->up_match, sizeof cursor->up_match);
	UNIV_MEM_INVALID(&cursor->up_bytes, sizeof cursor->up_bytes);
	UNIV_MEM_INVALID(&cursor->low_match, sizeof cursor->low_match);
	UNIV_MEM_INVALID(&cursor->low_bytes, sizeof cursor->low_bytes);
#ifdef UNIV_DEBUG
	cursor->up_match = ULINT_UNDEFINED;
	cursor->low_match = ULINT_UNDEFINED;
#endif /* UNIV_DEBUG */

	ibool	s_latch_by_caller;

	s_latch_by_caller = latch_mode & BTR_ALREADY_S_LATCHED;

	ut_ad(!s_latch_by_caller
	      || srv_read_only_mode
	      || mtr_memo_contains_flagged(mtr,
					   dict_index_get_lock(index),
					   MTR_MEMO_S_LOCK
					   | MTR_MEMO_SX_LOCK));

	/* These flags are mutually exclusive, they are lumped together
	with the latch mode for historical reasons. It's possible for
	none of the flags to be set. */
	switch (UNIV_EXPECT(latch_mode
			    & (BTR_INSERT | BTR_DELETE | BTR_DELETE_MARK),
			    0)) {
	case 0:
		btr_op = BTR_NO_OP;
		break;
	case BTR_INSERT:
		btr_op = (latch_mode & BTR_IGNORE_SEC_UNIQUE)
			? BTR_INSERT_IGNORE_UNIQUE_OP
			: BTR_INSERT_OP;
		break;
	case BTR_DELETE:
		btr_op = BTR_DELETE_OP;
		ut_a(cursor->purge_node);
		break;
	case BTR_DELETE_MARK:
		btr_op = BTR_DELMARK_OP;
		break;
	default:
		/* only one of BTR_INSERT, BTR_DELETE, BTR_DELETE_MARK
		should be specified at a time */
		ut_error;
	}

	/* Operations on the insert buffer tree cannot be buffered. */
	ut_ad(btr_op == BTR_NO_OP || !dict_index_is_ibuf(index));
	/* Operations on the clustered index cannot be buffered. */
	ut_ad(btr_op == BTR_NO_OP || !dict_index_is_clust(index));
	/* Operations on the temporary table(indexes) cannot be buffered. */
	ut_ad(btr_op == BTR_NO_OP || !dict_table_is_temporary(index->table));
	/* Operation on the spatial index cannot be buffered. */
	ut_ad(btr_op == BTR_NO_OP || !dict_index_is_spatial(index));

	estimate = latch_mode & BTR_ESTIMATE;

	lock_intention = btr_cur_get_and_clear_intention(&latch_mode);

	modify_external = latch_mode & BTR_MODIFY_EXTERNAL;

	/* Turn the flags unrelated to the latch mode off. */
	latch_mode = BTR_LATCH_MODE_WITHOUT_FLAGS(latch_mode);

	ut_ad(!modify_external || latch_mode == BTR_MODIFY_LEAF);

	ut_ad(!s_latch_by_caller
	      || latch_mode == BTR_SEARCH_LEAF
	      || latch_mode == BTR_SEARCH_TREE
	      || latch_mode == BTR_MODIFY_LEAF);

	cursor->flag = BTR_CUR_BINARY;
	cursor->index = index;

#ifndef BTR_CUR_ADAPT
	guess = NULL;
#else
	info = btr_search_get_info(index);

	if (!buf_pool_is_obsolete(info->withdraw_clock)) {
		guess = info->root_guess;
	} else {
		guess = NULL;
	}

#ifdef BTR_CUR_HASH_ADAPT

# ifdef UNIV_SEARCH_PERF_STAT
	info->n_searches++;
# endif
	/* Use of AHI is disabled for intrinsic table as these tables re-use
	the index-id and AHI validation is based on index-id. */
	if (rw_lock_get_writer(btr_get_search_latch(index))
		== RW_LOCK_NOT_LOCKED
	    && latch_mode <= BTR_MODIFY_LEAF
	    && info->last_hash_succ
	    && !index->disable_ahi
	    && !estimate
# ifdef PAGE_CUR_LE_OR_EXTENDS
	    && mode != PAGE_CUR_LE_OR_EXTENDS
# endif /* PAGE_CUR_LE_OR_EXTENDS */
	    && !dict_index_is_spatial(index)
	    /* If !has_search_latch, we do a dirty read of
	    btr_search_enabled below, and btr_search_guess_on_hash()
	    will have to check it again. */
	    && UNIV_LIKELY(btr_search_enabled)
	    && !modify_external
	    && btr_search_guess_on_hash(index, info, tuple, mode,
					latch_mode, cursor,
					has_search_latch, mtr)) {

		/* Search using the hash index succeeded */

		ut_ad(cursor->up_match != ULINT_UNDEFINED
		      || mode != PAGE_CUR_GE);
		ut_ad(cursor->up_match != ULINT_UNDEFINED
		      || mode != PAGE_CUR_LE);
		ut_ad(cursor->low_match != ULINT_UNDEFINED
		      || mode != PAGE_CUR_LE);
		btr_cur_n_sea++;

		DBUG_VOID_RETURN;
	}
# endif /* BTR_CUR_HASH_ADAPT */
#endif /* BTR_CUR_ADAPT */
	btr_cur_n_non_sea++;

	/* If the hash search did not succeed, do binary search down the
	tree */

	if (has_search_latch) {
		/* Release possible search latch to obey latching order */
		rw_lock_s_unlock(btr_get_search_latch(index));
	}

	/* Store the position of the tree latch we push to mtr so that we
	know how to release it when we have latched leaf node(s) */

	savepoint = mtr_set_savepoint(mtr);

	switch (latch_mode) {
	case BTR_MODIFY_TREE:
		/* Most of delete-intended operations are purging.
		Free blocks and read IO bandwidth should be prior
		for them, when the history list is glowing huge. */
		if (lock_intention == BTR_INTENTION_DELETE
		    && trx_sys->rseg_history_len > BTR_CUR_FINE_HISTORY_LENGTH
			&& buf_get_n_pending_read_ios()) {
			mtr_x_lock(dict_index_get_lock(index), mtr);
		} else if (dict_index_is_spatial(index)
			   && lock_intention <= BTR_INTENTION_BOTH) {
			/* X lock the if there is possibility of
			pessimistic delete on spatial index. As we could
			lock upward for the tree */

			mtr_x_lock(dict_index_get_lock(index), mtr);
		} else {
			mtr_sx_lock(dict_index_get_lock(index), mtr);
		}
		upper_rw_latch = RW_X_LATCH;
		break;
	case BTR_CONT_MODIFY_TREE:
	case BTR_CONT_SEARCH_TREE:
		/* Do nothing */
		ut_ad(srv_read_only_mode
		      || mtr_memo_contains_flagged(mtr,
						   dict_index_get_lock(index),
						   MTR_MEMO_X_LOCK
						   | MTR_MEMO_SX_LOCK));
		if (dict_index_is_spatial(index)
		    && latch_mode == BTR_CONT_MODIFY_TREE) {
			/* If we are about to locating parent page for split
			and/or merge operation for R-Tree index, X latch
			the parent */
			upper_rw_latch = RW_X_LATCH;
		} else {
			upper_rw_latch = RW_NO_LATCH;
		}
		break;
	default:
		if (!srv_read_only_mode) {
			if (s_latch_by_caller) {
				ut_ad(rw_lock_own(dict_index_get_lock(index),
				              RW_LOCK_S));
			} else if (!modify_external) {
				/* BTR_SEARCH_TREE is intended to be used with
				BTR_ALREADY_S_LATCHED */
				ut_ad(latch_mode != BTR_SEARCH_TREE);

				mtr_s_lock(dict_index_get_lock(index), mtr);
			} else {
				/* BTR_MODIFY_EXTERNAL needs to be excluded */
				mtr_sx_lock(dict_index_get_lock(index), mtr);
			}
			upper_rw_latch = RW_S_LATCH;
		} else {
			upper_rw_latch = RW_NO_LATCH;
		}
	}
	root_leaf_rw_latch = btr_cur_latch_for_root_leaf(latch_mode);

	page_cursor = btr_cur_get_page_cur(cursor);

	const ulint		space = dict_index_get_space(index);
	const page_size_t	page_size(dict_table_page_size(index->table));

	/* Start with the root page. */
	page_id_t		page_id(space, dict_index_get_page(index));

	if (root_leaf_rw_latch == RW_X_LATCH) {
		node_ptr_max_size = dict_index_node_ptr_max_size(index);
	}

	up_match = 0;
	up_bytes = 0;
	low_match = 0;
	low_bytes = 0;

	height = ULINT_UNDEFINED;

	/* We use these modified search modes on non-leaf levels of the
	B-tree. These let us end up in the right B-tree leaf. In that leaf
	we use the original search mode. */

	switch (mode) {
	case PAGE_CUR_GE:
		page_mode = PAGE_CUR_L;
		break;
	case PAGE_CUR_G:
		page_mode = PAGE_CUR_LE;
		break;
	default:
#ifdef PAGE_CUR_LE_OR_EXTENDS
		ut_ad(mode == PAGE_CUR_L || mode == PAGE_CUR_LE
		      || RTREE_SEARCH_MODE(mode)
		      || mode == PAGE_CUR_LE_OR_EXTENDS);
#else /* PAGE_CUR_LE_OR_EXTENDS */
		ut_ad(mode == PAGE_CUR_L || mode == PAGE_CUR_LE
		      || RTREE_SEARCH_MODE(mode));
#endif /* PAGE_CUR_LE_OR_EXTENDS */
		page_mode = mode;
		break;
	}

	/* Loop and search until we arrive at the desired level */
	btr_latch_leaves_t latch_leaves = {{NULL, NULL, NULL}, {0, 0, 0}};

search_loop:
	buf_mode = BUF_GET;
	rw_latch = RW_NO_LATCH;
	rtree_parent_modified = false;

	if (height != 0) {
		/* We are about to fetch the root or a non-leaf page. */
		if ((latch_mode != BTR_MODIFY_TREE
		     || height == level)
		    && !retrying_for_search_prev) {
			/* If doesn't have SX or X latch of index,
			each pages should be latched before reading. */
			if (modify_external
			    && height == ULINT_UNDEFINED
			    && upper_rw_latch == RW_S_LATCH) {
				/* needs sx-latch of root page
				for fseg operation */
				rw_latch = RW_SX_LATCH;
			} else {
				rw_latch = upper_rw_latch;
			}
		}
	} else if (latch_mode <= BTR_MODIFY_LEAF) {
		rw_latch = latch_mode;

		if (btr_op != BTR_NO_OP
		    && ibuf_should_try(index, btr_op != BTR_INSERT_OP)) {

			/* Try to buffer the operation if the leaf
			page is not in the buffer pool. */

			buf_mode = btr_op == BTR_DELETE_OP
				? BUF_GET_IF_IN_POOL_OR_WATCH
				: BUF_GET_IF_IN_POOL;
		}
	}

retry_page_get:
	ut_ad(n_blocks < BTR_MAX_LEVELS);
	tree_savepoints[n_blocks] = mtr_set_savepoint(mtr);
	block = buf_page_get_gen(page_id, page_size, rw_latch, guess,
				 buf_mode, file, line, mtr);
	tree_blocks[n_blocks] = block;

	if (block == NULL) {
		/* This must be a search to perform an insert/delete
		mark/ delete; try using the insert/delete buffer */

		ut_ad(height == 0);
		ut_ad(cursor->thr);

		switch (btr_op) {
		case BTR_INSERT_OP:
		case BTR_INSERT_IGNORE_UNIQUE_OP:
			ut_ad(buf_mode == BUF_GET_IF_IN_POOL);
			ut_ad(!dict_index_is_spatial(index));

			if (ibuf_insert(IBUF_OP_INSERT, tuple, index,
					page_id, page_size, cursor->thr)) {

				cursor->flag = BTR_CUR_INSERT_TO_IBUF;

				goto func_exit;
			}
			break;

		case BTR_DELMARK_OP:
			ut_ad(buf_mode == BUF_GET_IF_IN_POOL);
			ut_ad(!dict_index_is_spatial(index));

			if (ibuf_insert(IBUF_OP_DELETE_MARK, tuple,
					index, page_id, page_size,
					cursor->thr)) {

				cursor->flag = BTR_CUR_DEL_MARK_IBUF;

				goto func_exit;
			}

			break;

		case BTR_DELETE_OP:
			ut_ad(buf_mode == BUF_GET_IF_IN_POOL_OR_WATCH);
			ut_ad(!dict_index_is_spatial(index));

			if (!row_purge_poss_sec(cursor->purge_node,
						index, tuple)) {

				/* The record cannot be purged yet. */
				cursor->flag = BTR_CUR_DELETE_REF;
			} else if (ibuf_insert(IBUF_OP_DELETE, tuple,
					       index, page_id, page_size,
					       cursor->thr)) {

				/* The purge was buffered. */
				cursor->flag = BTR_CUR_DELETE_IBUF;
			} else {
				/* The purge could not be buffered. */
				buf_pool_watch_unset(page_id);
				break;
			}

			buf_pool_watch_unset(page_id);
			goto func_exit;

		default:
			ut_error;
		}

		/* Insert to the insert/delete buffer did not succeed, we
		must read the page from disk. */

		buf_mode = BUF_GET;

		goto retry_page_get;
	}

	if (retrying_for_search_prev && height != 0) {
		/* also latch left sibling */
		ulint		left_page_no;
		buf_block_t*	get_block;

		ut_ad(rw_latch == RW_NO_LATCH);

		rw_latch = upper_rw_latch;

		rw_lock_s_lock(&block->lock);
		left_page_no = btr_page_get_prev(
			buf_block_get_frame(block), mtr);
		rw_lock_s_unlock(&block->lock);

		if (left_page_no != FIL_NULL) {
			ut_ad(prev_n_blocks < leftmost_from_level);

			prev_tree_savepoints[prev_n_blocks]
				= mtr_set_savepoint(mtr);
			get_block = buf_page_get_gen(
				page_id_t(page_id.space(), left_page_no),
				page_size, rw_latch, NULL, buf_mode,
				file, line, mtr);
			prev_tree_blocks[prev_n_blocks] = get_block;
			prev_n_blocks++;

			/* BTR_MODIFY_TREE doesn't update prev/next_page_no,
			without their parent page's lock. So, not needed to
			retry here, because we have the parent page's lock. */
		}

		/* release RW_NO_LATCH page and lock with RW_S_LATCH */
		mtr_release_block_at_savepoint(
			mtr, tree_savepoints[n_blocks],
			tree_blocks[n_blocks]);

		tree_savepoints[n_blocks] = mtr_set_savepoint(mtr);
		block = buf_page_get_gen(page_id, page_size, rw_latch, NULL,
					 buf_mode, file, line, mtr);
		tree_blocks[n_blocks] = block;
	}

	page = buf_block_get_frame(block);

	if (height == ULINT_UNDEFINED
	    && page_is_leaf(page)
	    && rw_latch != RW_NO_LATCH
	    && rw_latch != root_leaf_rw_latch) {
		/* We should retry to get the page, because the root page
		is latched with different level as a leaf page. */
		ut_ad(root_leaf_rw_latch != RW_NO_LATCH);
		ut_ad(rw_latch == RW_S_LATCH || rw_latch == RW_SX_LATCH);
		ut_ad(rw_latch == RW_S_LATCH || modify_external);

		ut_ad(n_blocks == 0);
		mtr_release_block_at_savepoint(
			mtr, tree_savepoints[n_blocks],
			tree_blocks[n_blocks]);

		upper_rw_latch = root_leaf_rw_latch;
		goto search_loop;
	}

	if (rw_latch != RW_NO_LATCH) {
#ifdef UNIV_ZIP_DEBUG
		const page_zip_des_t*	page_zip
			= buf_block_get_page_zip(block);
		ut_a(!page_zip || page_zip_validate(page_zip, page, index));
#endif /* UNIV_ZIP_DEBUG */

		buf_block_dbg_add_level(
			block, dict_index_is_ibuf(index)
			? SYNC_IBUF_TREE_NODE : SYNC_TREE_NODE);
	}

	ut_ad(fil_page_index_page_check(page));
	ut_ad(index->id == btr_page_get_index_id(page));

	if (UNIV_UNLIKELY(height == ULINT_UNDEFINED)) {
		/* We are in the root node */

		height = btr_page_get_level(page, mtr);
		root_height = height;
		cursor->tree_height = root_height + 1;

		if (dict_index_is_spatial(index)) {
			ut_ad(cursor->rtr_info);

			node_seq_t      seq_no = rtr_get_current_ssn_id(index);

			/* If SSN in memory is not initialized, fetch
			it from root page */
			if (seq_no < 1) {
				node_seq_t      root_seq_no;

				root_seq_no = page_get_ssn_id(page);

				mutex_enter(&(index->rtr_ssn.mutex));
				index->rtr_ssn.seq_no = root_seq_no + 1;
				mutex_exit(&(index->rtr_ssn.mutex));
			}

			/* Save the MBR */
			cursor->rtr_info->thr = cursor->thr;
			rtr_get_mbr_from_tuple(tuple, &cursor->rtr_info->mbr);
		}

#ifdef BTR_CUR_ADAPT
		if (block != guess) {
			info->root_guess = block;
			info->withdraw_clock = buf_withdraw_clock;
		}
#endif
	}

	if (height == 0) {
		if (rw_latch == RW_NO_LATCH) {

			latch_leaves = btr_cur_latch_leaves(
				block, page_id, page_size, latch_mode,
				cursor, mtr);
		}

		switch (latch_mode) {
		case BTR_MODIFY_TREE:
		case BTR_CONT_MODIFY_TREE:
		case BTR_CONT_SEARCH_TREE:
			break;
		default:
			if (!s_latch_by_caller
			    && !srv_read_only_mode
			    && !modify_external) {
				/* Release the tree s-latch */
				/* NOTE: BTR_MODIFY_EXTERNAL
				needs to keep tree sx-latch */
				mtr_release_s_latch_at_savepoint(
					mtr, savepoint,
					dict_index_get_lock(index));
			}

			/* release upper blocks */
			if (retrying_for_search_prev) {
				for (;
				     prev_n_releases < prev_n_blocks;
				     prev_n_releases++) {
					mtr_release_block_at_savepoint(
						mtr,
						prev_tree_savepoints[
							prev_n_releases],
						prev_tree_blocks[
							prev_n_releases]);
				}
			}

			for (; n_releases < n_blocks; n_releases++) {
				if (n_releases == 0 && modify_external) {
					/* keep latch of root page */
					ut_ad(mtr_memo_contains_flagged(
						mtr, tree_blocks[n_releases],
						MTR_MEMO_PAGE_SX_FIX
						| MTR_MEMO_PAGE_X_FIX));
					continue;
				}

				mtr_release_block_at_savepoint(
					mtr, tree_savepoints[n_releases],
					tree_blocks[n_releases]);
			}
		}

		page_mode = mode;
	}

	if (dict_index_is_spatial(index)) {
		/* Remember the page search mode */
		search_mode = page_mode;

		/* Some adjustment on search mode, when the
		page search mode is PAGE_CUR_RTREE_LOCATE
		or PAGE_CUR_RTREE_INSERT, as we are searching
		with MBRs. When it is not the target level, we
		should search all sub-trees that "CONTAIN" the
		search range/MBR. When it is at the target
		level, the search becomes PAGE_CUR_LE */
		if (page_mode == PAGE_CUR_RTREE_LOCATE
		    && level == height) {
			if (level == 0) {
				page_mode = PAGE_CUR_LE;
			} else {
				page_mode = PAGE_CUR_RTREE_GET_FATHER;
			}
		}

		if (page_mode == PAGE_CUR_RTREE_INSERT) {
			page_mode = (level == height)
					? PAGE_CUR_LE
					: PAGE_CUR_RTREE_INSERT;

			ut_ad(!page_is_leaf(page) || page_mode == PAGE_CUR_LE);
		}

		/* "need_path" indicates if we need to tracking the parent
		pages, if it is not spatial comparison, then no need to
		track it */
		if (page_mode < PAGE_CUR_CONTAIN) {
			need_path = false;
		}

		up_match = 0;
		low_match = 0;

		if (latch_mode == BTR_MODIFY_TREE
		    || latch_mode == BTR_CONT_MODIFY_TREE
		    || latch_mode == BTR_CONT_SEARCH_TREE) {
			/* Tree are locked, no need for Page Lock to protect
			the "path" */
			cursor->rtr_info->need_page_lock = false;
		}
        }

	if (dict_index_is_spatial(index) && page_mode >= PAGE_CUR_CONTAIN) {
		ut_ad(need_path);
		found = rtr_cur_search_with_match(
			block, index, tuple, page_mode, page_cursor,
			cursor->rtr_info);

		/* Need to use BTR_MODIFY_TREE to do the MBR adjustment */
		if (search_mode == PAGE_CUR_RTREE_INSERT
		    && cursor->rtr_info->mbr_adj) {
			if (latch_mode & BTR_MODIFY_LEAF) {
				/* Parent MBR needs updated, should retry
				with BTR_MODIFY_TREE */
				goto func_exit;
			} else if (latch_mode & BTR_MODIFY_TREE) {
				rtree_parent_modified = true;
				cursor->rtr_info->mbr_adj = false;
				mbr_adj = true;
			} else {
				ut_ad(0);
			}
		}

		if (found && page_mode == PAGE_CUR_RTREE_GET_FATHER) {
			cursor->low_match =
				DICT_INDEX_SPATIAL_NODEPTR_SIZE + 1;
		}
	} else if (height == 0 && btr_search_enabled
		   && !dict_index_is_spatial(index)) {
		/* The adaptive hash index is only used when searching
		for leaf pages (height==0), but not in r-trees.
		We only need the byte prefix comparison for the purpose
		of updating the adaptive hash index. */
		page_cur_search_with_match_bytes(
			block, index, tuple, page_mode, &up_match, &up_bytes,
			&low_match, &low_bytes, page_cursor);
	} else {
		/* Search for complete index fields. */
		up_bytes = low_bytes = 0;
		page_cur_search_with_match(
			block, index, tuple, page_mode, &up_match,
			&low_match, page_cursor,
			need_path ? cursor->rtr_info : NULL);
	}

	if (estimate) {
		btr_cur_add_path_info(cursor, height, root_height);
	}

	/* If this is the desired level, leave the loop */

	ut_ad(height == btr_page_get_level(page_cur_get_page(page_cursor),
					   mtr));

	/* Add Predicate lock if it is serializable isolation
	and only if it is in the search case */
	if (dict_index_is_spatial(index)
	    && cursor->rtr_info->need_prdt_lock
	    && mode != PAGE_CUR_RTREE_INSERT
	    && mode != PAGE_CUR_RTREE_LOCATE
	    && mode >= PAGE_CUR_CONTAIN) {
		trx_t*		trx = thr_get_trx(cursor->thr);
		lock_prdt_t	prdt;

		lock_mutex_enter();
		lock_init_prdt_from_mbr(
			&prdt, &cursor->rtr_info->mbr, mode,
			trx->lock.lock_heap);
		lock_mutex_exit();

		if (rw_latch == RW_NO_LATCH && height != 0) {
			rw_lock_s_lock(&(block->lock));
		}

		lock_prdt_lock(block, &prdt, index, LOCK_S,
			       LOCK_PREDICATE, cursor->thr, mtr);

		if (rw_latch == RW_NO_LATCH && height != 0) {
			rw_lock_s_unlock(&(block->lock));
		}
	}

	if (level != height) {

		const rec_t*	node_ptr;
		ut_ad(height > 0);

		height--;
		guess = NULL;

		node_ptr = page_cur_get_rec(page_cursor);

		offsets = rec_get_offsets(
			node_ptr, index, offsets, ULINT_UNDEFINED, &heap);

		/* If the rec is the first or last in the page for
		pessimistic delete intention, it might cause node_ptr insert
		for the upper level. We should change the intention and retry.
		*/
		if (latch_mode == BTR_MODIFY_TREE
		    && btr_cur_need_opposite_intention(
			page, lock_intention, node_ptr)) {

need_opposite_intention:
			ut_ad(upper_rw_latch == RW_X_LATCH);

			if (n_releases > 0) {
				/* release root block */
				mtr_release_block_at_savepoint(
					mtr, tree_savepoints[0],
					tree_blocks[0]);
			}

			/* release all blocks */
			for (; n_releases <= n_blocks; n_releases++) {
				mtr_release_block_at_savepoint(
					mtr, tree_savepoints[n_releases],
					tree_blocks[n_releases]);
			}

			lock_intention = BTR_INTENTION_BOTH;

			page_id.reset(space, dict_index_get_page(index));
			up_match = 0;
			low_match = 0;
			height = ULINT_UNDEFINED;

			n_blocks = 0;
			n_releases = 0;

			goto search_loop;
		}

		if (dict_index_is_spatial(index)) {
			if (page_rec_is_supremum(node_ptr)) {
				cursor->low_match = 0;
				cursor->up_match = 0;
				goto func_exit;
			}

			/* If we are doing insertion or record locating,
			remember the tree nodes we visited */
			if (page_mode == PAGE_CUR_RTREE_INSERT
			    || (search_mode == PAGE_CUR_RTREE_LOCATE
			        && (latch_mode != BTR_MODIFY_LEAF))) {
				bool		add_latch = false;

				if (latch_mode == BTR_MODIFY_TREE
				    && rw_latch == RW_NO_LATCH) {
					ut_ad(mtr_memo_contains_flagged(
						mtr, dict_index_get_lock(index),
						MTR_MEMO_X_LOCK
						| MTR_MEMO_SX_LOCK));
					rw_lock_s_lock(&block->lock);
					add_latch = true;
				}

				/* Store the parent cursor location */
#ifdef UNIV_DEBUG
				ulint	num_stored = rtr_store_parent_path(
					block, cursor, latch_mode,
					height + 1, mtr);
#else
				rtr_store_parent_path(
					block, cursor, latch_mode,
					height + 1, mtr);
#endif

				if (page_mode == PAGE_CUR_RTREE_INSERT) {
					btr_pcur_t*     r_cursor =
						rtr_get_parent_cursor(
							cursor, height + 1,
							true);
					/* If it is insertion, there should
					be only one parent for each level
					traverse */
#ifdef UNIV_DEBUG
					ut_ad(num_stored == 1);
#endif

					node_ptr = btr_pcur_get_rec(r_cursor);

				}

				if (add_latch) {
					rw_lock_s_unlock(&block->lock);
				}

				ut_ad(!page_rec_is_supremum(node_ptr));
			}

			ut_ad(page_mode == search_mode
			      || (page_mode == PAGE_CUR_WITHIN
				  && search_mode == PAGE_CUR_RTREE_LOCATE));

			page_mode = search_mode;
		}

		/* If the first or the last record of the page
		or the same key value to the first record or last record,
		the another page might be choosen when BTR_CONT_MODIFY_TREE.
		So, the parent page should not released to avoiding deadlock
		with blocking the another search with the same key value. */
		if (!detected_same_key_root
		    && lock_intention == BTR_INTENTION_BOTH
		    && !dict_index_is_unique(index)
		    && latch_mode == BTR_MODIFY_TREE
		    && (up_match >= rec_offs_n_fields(offsets) - 1
			|| low_match >= rec_offs_n_fields(offsets) - 1)) {
			const rec_t*	first_rec
						= page_rec_get_next_const(
							page_get_infimum_rec(
								page));
			ulint		matched_fields;

			ut_ad(upper_rw_latch == RW_X_LATCH);

			if (node_ptr == first_rec
			    || page_rec_is_last(node_ptr, page)) {
				detected_same_key_root = true;
			} else {
				matched_fields = 0;

				offsets2 = rec_get_offsets(
					first_rec, index, offsets2,
					ULINT_UNDEFINED, &heap);
				cmp_rec_rec_with_match(node_ptr, first_rec,
					offsets, offsets2, index, FALSE,
					&matched_fields);

				if (matched_fields
				    >= rec_offs_n_fields(offsets) - 1) {
					detected_same_key_root = true;
				} else {
					const rec_t*	last_rec;

					last_rec = page_rec_get_prev_const(
							page_get_supremum_rec(
								page));

					matched_fields = 0;

					offsets2 = rec_get_offsets(
						last_rec, index, offsets2,
						ULINT_UNDEFINED, &heap);
					cmp_rec_rec_with_match(
						node_ptr, last_rec,
						offsets, offsets2, index,
						FALSE, &matched_fields);
					if (matched_fields
					    >= rec_offs_n_fields(offsets) - 1) {
						detected_same_key_root = true;
					}
				}
			}
		}

		/* If the page might cause modify_tree,
		we should not release the parent page's lock. */
		if (!detected_same_key_root
		    && latch_mode == BTR_MODIFY_TREE
		    && !btr_cur_will_modify_tree(
				index, page, lock_intention, node_ptr,
				node_ptr_max_size, page_size, mtr)
		    && !rtree_parent_modified) {
			ut_ad(upper_rw_latch == RW_X_LATCH);
			ut_ad(n_releases <= n_blocks);

			/* we can release upper blocks */
			for (; n_releases < n_blocks; n_releases++) {
				if (n_releases == 0) {
					/* we should not release root page
					to pin to same block. */
					continue;
				}

				/* release unused blocks to unpin */
				mtr_release_block_at_savepoint(
					mtr, tree_savepoints[n_releases],
					tree_blocks[n_releases]);
			}
		}

		if (height == level
		    && latch_mode == BTR_MODIFY_TREE) {
			ut_ad(upper_rw_latch == RW_X_LATCH);
			/* we should sx-latch root page, if released already.
			It contains seg_header. */
			if (n_releases > 0) {
				mtr_block_sx_latch_at_savepoint(
					mtr, tree_savepoints[0],
					tree_blocks[0]);
			}

			/* x-latch the branch blocks not released yet. */
			for (ulint i = n_releases; i <= n_blocks; i++) {
				mtr_block_x_latch_at_savepoint(
					mtr, tree_savepoints[i],
					tree_blocks[i]);
			}
		}

		/* We should consider prev_page of parent page, if the node_ptr
		is the leftmost of the page. because BTR_SEARCH_PREV and
		BTR_MODIFY_PREV latches prev_page of the leaf page. */
		if ((latch_mode == BTR_SEARCH_PREV
		     || latch_mode == BTR_MODIFY_PREV)
		    && !retrying_for_search_prev) {
			/* block should be latched for consistent
			   btr_page_get_prev() */
			ut_ad(mtr_memo_contains_flagged(mtr, block,
				MTR_MEMO_PAGE_S_FIX
				| MTR_MEMO_PAGE_X_FIX));

			if (btr_page_get_prev(page, mtr) != FIL_NULL
			    && page_rec_is_first(node_ptr, page)) {

				if (leftmost_from_level == 0) {
					leftmost_from_level = height + 1;
				}
			} else {
				leftmost_from_level = 0;
			}

			if (height == 0 && leftmost_from_level > 0) {
				/* should retry to get also prev_page
				from level==leftmost_from_level. */
				retrying_for_search_prev = true;

				prev_tree_blocks = static_cast<buf_block_t**>(
					ut_malloc_nokey(sizeof(buf_block_t*)
							* leftmost_from_level));

				prev_tree_savepoints = static_cast<ulint*>(
					ut_malloc_nokey(sizeof(ulint)
							* leftmost_from_level));

				/* back to the level (leftmost_from_level+1) */
				ulint	idx = n_blocks
					- (leftmost_from_level - 1);

				page_id.reset(
					space,
					tree_blocks[idx]->page.id.page_no());

				for (ulint i = n_blocks
					       - (leftmost_from_level - 1);
				     i <= n_blocks; i++) {
					mtr_release_block_at_savepoint(
						mtr, tree_savepoints[i],
						tree_blocks[i]);
				}

				n_blocks -= (leftmost_from_level - 1);
				height = leftmost_from_level;
				ut_ad(n_releases == 0);

				/* replay up_match, low_match */
				up_match = 0;
				low_match = 0;
				rtr_info_t*	rtr_info	= need_path
					? cursor->rtr_info : NULL;

				for (ulint i = 0; i < n_blocks; i++) {
					page_cur_search_with_match(
						tree_blocks[i], index, tuple,
						page_mode, &up_match,
						&low_match, page_cursor,
						rtr_info);
				}

				goto search_loop;
			}
		}

		/* Go to the child node */
		page_id.reset(
			space,
			btr_node_ptr_get_child_page_no(node_ptr, offsets));

		n_blocks++;

		if (UNIV_UNLIKELY(height == 0 && dict_index_is_ibuf(index))) {
			/* We're doing a search on an ibuf tree and we're one
			level above the leaf page. */

			ut_ad(level == 0);

			buf_mode = BUF_GET;
			rw_latch = RW_NO_LATCH;
			goto retry_page_get;
		}

		if (dict_index_is_spatial(index)
		    && page_mode >= PAGE_CUR_CONTAIN
		    && page_mode != PAGE_CUR_RTREE_INSERT) {
			ut_ad(need_path);
			rtr_node_path_t* path =
				cursor->rtr_info->path;

			if (!path->empty() && found) {
#ifdef UNIV_DEBUG
				node_visit_t    last_visit = path->back();

				ut_ad(last_visit.page_no == page_id.page_no());
#endif /* UNIV_DEBUG */

				path->pop_back();

#ifdef UNIV_DEBUG
				if (page_mode == PAGE_CUR_RTREE_LOCATE
				    && (latch_mode != BTR_MODIFY_LEAF)) {
					btr_pcur_t*	cur
					= cursor->rtr_info->parent_path->back(
					  ).cursor;
					rec_t*	my_node_ptr
						= btr_pcur_get_rec(cur);

					offsets = rec_get_offsets(
						my_node_ptr, index, offsets,
						ULINT_UNDEFINED, &heap);

					ulint	my_page_no
					= btr_node_ptr_get_child_page_no(
						my_node_ptr, offsets);

					ut_ad(page_id.page_no() == my_page_no);

				}
#endif
			}
		}

		goto search_loop;
	} else if (!dict_index_is_spatial(index)
		   && latch_mode == BTR_MODIFY_TREE
		   && lock_intention == BTR_INTENTION_INSERT
		   && mach_read_from_4(page + FIL_PAGE_NEXT) != FIL_NULL
		   && page_rec_is_last(page_cur_get_rec(page_cursor), page)) {

		/* btr_insert_into_right_sibling() might cause
		deleting node_ptr at upper level */

		guess = NULL;

		if (height == 0) {
			/* release the leaf pages if latched */
			for (uint i = 0; i < 3; i++) {
				if (latch_leaves.blocks[i] != NULL) {
					mtr_release_block_at_savepoint(
						mtr, latch_leaves.savepoints[i],
						latch_leaves.blocks[i]);
					latch_leaves.blocks[i] = NULL;
				}
			}
		}

		goto need_opposite_intention;
	}

	if (level != 0) {
		if (upper_rw_latch == RW_NO_LATCH) {
			/* latch the page */
			buf_block_t*	child_block;

			if (latch_mode == BTR_CONT_MODIFY_TREE) {
				child_block = btr_block_get(
					page_id, page_size, RW_X_LATCH,
					index, mtr);
			} else {
				ut_ad(latch_mode == BTR_CONT_SEARCH_TREE);
				child_block = btr_block_get(
					page_id, page_size, RW_SX_LATCH,
					index, mtr);
			}

			btr_assert_not_corrupted(child_block, index);
		} else {
			ut_ad(mtr_memo_contains(mtr, block, upper_rw_latch));
			btr_assert_not_corrupted(block, index);

			if (s_latch_by_caller) {
				ut_ad(latch_mode == BTR_SEARCH_TREE);
				/* to exclude modifying tree operations
				should sx-latch the index. */
				ut_ad(mtr_memo_contains(
					mtr, dict_index_get_lock(index),
					MTR_MEMO_SX_LOCK));
				/* because has sx-latch of index,
				can release upper blocks. */
				for (; n_releases < n_blocks; n_releases++) {
					mtr_release_block_at_savepoint(
						mtr,
						tree_savepoints[n_releases],
						tree_blocks[n_releases]);
				}
			}
		}

		if (page_mode <= PAGE_CUR_LE) {
			cursor->low_match = low_match;
			cursor->up_match = up_match;
		}
	} else {
		cursor->low_match = low_match;
		cursor->low_bytes = low_bytes;
		cursor->up_match = up_match;
		cursor->up_bytes = up_bytes;

#ifdef BTR_CUR_ADAPT
		/* We do a dirty read of btr_search_enabled here.  We
		will properly check btr_search_enabled again in
		btr_search_build_page_hash_index() before building a
		page hash index, while holding search latch. */
		if (btr_search_enabled && !index->disable_ahi) {
			btr_search_info_update(index, cursor);
		}
#endif
		ut_ad(cursor->up_match != ULINT_UNDEFINED
		      || mode != PAGE_CUR_GE);
		ut_ad(cursor->up_match != ULINT_UNDEFINED
		      || mode != PAGE_CUR_LE);
		ut_ad(cursor->low_match != ULINT_UNDEFINED
		      || mode != PAGE_CUR_LE);
	}

	/* For spatial index, remember  what blocks are still latched */
	if (dict_index_is_spatial(index)
	    && (latch_mode == BTR_MODIFY_TREE
		|| latch_mode == BTR_MODIFY_LEAF)) {
		for (ulint i = 0; i < n_releases; i++) {
			cursor->rtr_info->tree_blocks[i] = NULL;
			cursor->rtr_info->tree_savepoints[i] = 0;
		}

		for (ulint i = n_releases; i <= n_blocks; i++) {
			cursor->rtr_info->tree_blocks[i] = tree_blocks[i];
			cursor->rtr_info->tree_savepoints[i] = tree_savepoints[i];
		}
	}

func_exit:

	if (UNIV_LIKELY_NULL(heap)) {
		mem_heap_free(heap);
	}

	if (retrying_for_search_prev) {
		ut_free(prev_tree_blocks);
		ut_free(prev_tree_savepoints);
	}

	if (has_search_latch) {

		rw_lock_s_lock(btr_get_search_latch(index));
	}

	if (mbr_adj) {
		/* remember that we will need to adjust parent MBR */
		cursor->rtr_info->mbr_adj = true;
	}

	DBUG_VOID_RETURN;
}