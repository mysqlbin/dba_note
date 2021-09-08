

-- mysql-5.7.26\storage\innobase\btr\btr0cur.cc

-- 申请对叶子节点数据页或者数据页加LATCH锁
/** Latches the leaf page or pages requested.
@param[in]	block		leaf page where the search converged
@param[in]	page_id		page id of the leaf
@param[in]	latch_mode	BTR_SEARCH_LEAF, ...
@param[in]	cursor		cursor
@param[in]	mtr		mini-transaction
@return	blocks and savepoints which actually latched. */
btr_latch_leaves_t
btr_cur_latch_leaves(
	buf_block_t*		block,
	const page_id_t&	page_id,
	const page_size_t&	page_size,
	ulint			latch_mode,
	btr_cur_t*		cursor,
	mtr_t*			mtr)
{
	ulint		mode;
	ulint		left_page_no;
	ulint		right_page_no;
	buf_block_t*	get_block;
	page_t*		page = buf_block_get_frame(block);
	bool		spatial;
	btr_latch_leaves_t latch_leaves = {{NULL, NULL, NULL}, {0, 0, 0}};

	spatial = dict_index_is_spatial(cursor->index) && cursor->rtr_info;
	ut_ad(buf_page_in_file(&block->page));

	switch (latch_mode) {
	case BTR_SEARCH_LEAF:
	case BTR_MODIFY_LEAF:
	case BTR_SEARCH_TREE:
		if (spatial) {
			cursor->rtr_info->tree_savepoints[RTR_MAX_LEVELS]
				= mtr_set_savepoint(mtr);
		}

		mode = latch_mode == BTR_MODIFY_LEAF ? RW_X_LATCH : RW_S_LATCH;
		latch_leaves.savepoints[1] = mtr_set_savepoint(mtr);
		get_block = btr_block_get(page_id, page_size, mode,
					  cursor->index, mtr);
		latch_leaves.blocks[1] = get_block;
#ifdef UNIV_BTR_DEBUG
		ut_a(page_is_comp(get_block->frame) == page_is_comp(page));
#endif /* UNIV_BTR_DEBUG */
		if (spatial) {
			cursor->rtr_info->tree_blocks[RTR_MAX_LEVELS]
				= get_block;
		}

		return(latch_leaves);
	case BTR_MODIFY_TREE:
		/* It is exclusive for other operations which calls
		btr_page_set_prev() */
		ut_ad(mtr_memo_contains_flagged(mtr,
			dict_index_get_lock(cursor->index),
			MTR_MEMO_X_LOCK | MTR_MEMO_SX_LOCK)
		      || dict_table_is_intrinsic(cursor->index->table));
		/* x-latch also siblings from left to right */
		left_page_no = btr_page_get_prev(page, mtr);

		if (left_page_no != FIL_NULL) {

			if (spatial) {
				cursor->rtr_info->tree_savepoints[
					RTR_MAX_LEVELS] = mtr_set_savepoint(mtr);
			}

			latch_leaves.savepoints[0] = mtr_set_savepoint(mtr);
			get_block = btr_block_get(
				page_id_t(page_id.space(), left_page_no),
				page_size, RW_X_LATCH, cursor->index, mtr);
			latch_leaves.blocks[0] = get_block;

			if (spatial) {
				cursor->rtr_info->tree_blocks[RTR_MAX_LEVELS]
					= get_block;
			}
		}

		if (spatial) {
			cursor->rtr_info->tree_savepoints[RTR_MAX_LEVELS + 1]
				= mtr_set_savepoint(mtr);
		}

		latch_leaves.savepoints[1] = mtr_set_savepoint(mtr);
		get_block = btr_block_get(
			page_id, page_size, RW_X_LATCH, cursor->index, mtr);
		latch_leaves.blocks[1] = get_block;

#ifdef UNIV_BTR_DEBUG
		/* Sanity check only after both the blocks are latched. */
		if (latch_leaves.blocks[0] != NULL) {
			ut_a(page_is_comp(latch_leaves.blocks[0]->frame)
				== page_is_comp(page));
			ut_a(btr_page_get_next(
				latch_leaves.blocks[0]->frame, mtr)
				== page_get_page_no(page));
		}
		ut_a(page_is_comp(get_block->frame) == page_is_comp(page));
#endif /* UNIV_BTR_DEBUG */

		if (spatial) {
			cursor->rtr_info->tree_blocks[RTR_MAX_LEVELS + 1]
				= get_block;
		}

		right_page_no = btr_page_get_next(page, mtr);

		if (right_page_no != FIL_NULL) {
			if (spatial) {
				cursor->rtr_info->tree_savepoints[
					RTR_MAX_LEVELS + 2] = mtr_set_savepoint(
								mtr);
			}
			latch_leaves.savepoints[2] = mtr_set_savepoint(mtr);
			get_block = btr_block_get(
				page_id_t(page_id.space(), right_page_no),
				page_size, RW_X_LATCH, cursor->index, mtr);
			latch_leaves.blocks[2] = get_block;
#ifdef UNIV_BTR_DEBUG
			ut_a(page_is_comp(get_block->frame)
			     == page_is_comp(page));
			ut_a(btr_page_get_prev(get_block->frame, mtr)
			     == page_get_page_no(page));
#endif /* UNIV_BTR_DEBUG */
			if (spatial) {
				cursor->rtr_info->tree_blocks[
					RTR_MAX_LEVELS + 2] = get_block;
			}
		}

		return(latch_leaves);

	case BTR_SEARCH_PREV:
	case BTR_MODIFY_PREV:
		mode = latch_mode == BTR_SEARCH_PREV ? RW_S_LATCH : RW_X_LATCH;
		/* latch also left sibling */
		rw_lock_s_lock(&block->lock);
		left_page_no = btr_page_get_prev(page, mtr);
		rw_lock_s_unlock(&block->lock);

		if (left_page_no != FIL_NULL) {
			latch_leaves.savepoints[0] = mtr_set_savepoint(mtr);
			get_block = btr_block_get(
				page_id_t(page_id.space(), left_page_no),
				page_size, mode, cursor->index, mtr);
			latch_leaves.blocks[0] = get_block;
			cursor->left_block = get_block;
#ifdef UNIV_BTR_DEBUG
			ut_a(page_is_comp(get_block->frame)
			     == page_is_comp(page));
			ut_a(btr_page_get_next(get_block->frame, mtr)
			     == page_get_page_no(page));
#endif /* UNIV_BTR_DEBUG */
		}

		latch_leaves.savepoints[1] = mtr_set_savepoint(mtr);
		get_block = btr_block_get(page_id, page_size, mode,
					  cursor->index, mtr);
		latch_leaves.blocks[1] = get_block;
#ifdef UNIV_BTR_DEBUG
		ut_a(page_is_comp(get_block->frame) == page_is_comp(page));
#endif /* UNIV_BTR_DEBUG */
		return(latch_leaves);
	case BTR_CONT_MODIFY_TREE:
		ut_ad(dict_index_is_spatial(cursor->index));
		return(latch_leaves);
	}

	ut_error;
	return(latch_leaves);
}