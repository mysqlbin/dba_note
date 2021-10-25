Last time write locked in file /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc line 976
	
	mtr_sx_lock(dict_index_get_lock(index), mtr);



Last time read locked in file btr0cur.cc line 1008

	root_leaf_rw_latch = btr_cur_latch_for_root_leaf(latch_mode);



Mutex at 0x367d3f8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 0

	mutex_create(LATCH_ID_BUF_POOL, &buf_pool->mutex);


	--Thread 140701152139008 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
		
		buf_pool_mutex_enter(buf_pool);
		
		这意味着它已经等待了0秒。在这个场景下，争用很快消失
		
		
		
SX-lock on RW-latch at 0x7ff72c00c990 created in file dict0dict.cc line 2737

	rw_lock_create(index_tree_rw_lock_key, &new_index->lock,
		      SYNC_INDEX_TREE);
	


我们需要查看的文件有：

	btr0cur.cc

	dict0dict.cc

	buf0buf.cc




将page变成young的函数，变成young就是插入到LRU列表的头部。
/********************************************************************//**
Moves a page to the start of the buffer pool LRU list. This high-level
function can be used to prevent an important page from slipping out of
the buffer pool. */
void
buf_page_make_young(
/*================*/
	buf_page_t*	bpage)	/*!< in: buffer block of a file page */
{
	buf_pool_t*	buf_pool = buf_pool_from_bpage(bpage);
	
	-- 添加 BP 缓冲池 mutex锁
	buf_pool_mutex_enter(buf_pool);

	ut_a(buf_page_in_file(bpage));
	
	-- 移动old列表的数据页到young列表
	buf_LRU_make_block_young(bpage);
	
	-- 释放 BP 缓冲池 mutex锁
	buf_pool_mutex_exit(buf_pool);
}


/********************************************************************//**
Moves a page to the start of the buffer pool LRU list if it is too old.
This high-level function can be used to prevent an important page from
slipping out of the buffer pool. */
static
void
buf_page_make_young_if_needed(
/*==========================*/
	buf_page_t*	bpage)		/*!< in/out: buffer block of a
					file page */
{
#ifdef UNIV_DEBUG
	buf_pool_t*	buf_pool = buf_pool_from_bpage(bpage);
	ut_ad(!buf_pool_mutex_own(buf_pool));
#endif /* UNIV_DEBUG */
	ut_a(buf_page_in_file(bpage));

	if (buf_page_peek_if_too_old(bpage)) {
		buf_page_make_young(bpage);
	}
}
