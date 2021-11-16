
1. 堆栈
	row_drop_table_for_mysql
		-> que_eval_sql	
			-> que_run_threads	
				-> que_run_threads_low	
					-> que_thr_step	
						 -> row_upd_step	
							-> row_upd	
								-> row_upd_clust_step	
									-> dict_drop_index_tree	
										-> btr_free_if_exists

											清理索引非根节点的ahi
											-> btr_free_but_not_root
												-> fseg_free_step   /* page hash indexes are dropped when a page is freed inside */
													-> fseg_free_extent
														-> btr_search_drop_page_hash_when_freed    -- 删除bufferpool中对应的AHI
															-> btr_search_drop_page_hash_index     -- 删除索引页的自适应哈希索引项
															
											清理索引根节点的ahi	
											-> btr_free_root	
												-> btr_search_drop_page_hash_index	   -- 删除索引页的自适应哈希索引项
													-> ha_remove_all_nodes_to_page	
		




2. 部分核心函数
	
	2.1 btr_free_but_not_root

		/* NOTE: page hash indexes are dropped when a page is freed inside
		fsp0fsp. */
		-- 注意：当页面在内部被释放时，页面哈希索引被删除
		finished = fseg_free_step(root + PAGE_HEADER + PAGE_BTR_SEG_LEAF,
					  true, &mtr);
					  
					  
		mtr_commit(&mtr);
	

	2.2 btr_search_drop_page_hash_when_freed
	
		-- 当页面从缓冲池中被逐出或在文件段中被释放时，删除任何可能指向在缓冲池中的索引页的自适应哈希索引条目(ahi在buffer pool缓冲池中)
		
		/** Drop any adaptive hash index entries that may point to an index
		page that may be in the buffer pool, when a page is evicted from the
		buffer pool or freed in a file segment.
		@param[in]	page_id		page id
		@param[in]	page_size	page size */
		void
		btr_search_drop_page_hash_when_freed(
			const page_id_t&	page_id,
			const page_size_t&	page_size)
		{
			buf_block_t*	block;
			mtr_t		mtr;

			ut_d(export_vars.innodb_ahi_drop_lookups++);

			mtr_start(&mtr);

			/* If the caller has a latch on the page, then the caller must
			have a x-latch on the page and it must have already dropped
			the hash index for the page. Because of the x-latch that we
			are possibly holding, we cannot s-latch the page, but must
			(recursively) x-latch it, even though we are only reading. */

			block = buf_page_get_gen(page_id, page_size, RW_X_LATCH, NULL,
						 BUF_PEEK_IF_IN_POOL, __FILE__, __LINE__,
						 &mtr);

			if (block) {

				/* If AHI is still valid, page can't be in free state.
				AHI is dropped when page is freed. */
				ut_ad(!block->page.file_page_was_freed);

				buf_block_dbg_add_level(block, SYNC_TREE_NODE_FROM_HASH);

				dict_index_t*	index = block->index;
				if (index != NULL) {
					/* In all our callers, the table handle should
					be open, or we should be in the process of
					dropping the table (preventing eviction). */
					ut_ad(index->table->n_ref_count > 0
						  || mutex_own(&dict_sys->mutex));
					btr_search_drop_page_hash_index(block);
				}
			}

			mtr_commit(&mtr);
		}