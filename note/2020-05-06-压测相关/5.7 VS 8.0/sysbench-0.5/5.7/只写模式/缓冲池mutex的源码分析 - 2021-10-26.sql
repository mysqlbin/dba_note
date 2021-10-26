
0. 数据库版本
	5.7.26
	4核CPU、16GB内存，200GB的SSD盘
	数据库核心参数：
		双1配置
		innodb_buffer_pool_size=8GB
		innodb_buffer_pool_size_instance=2
		
1. 结合游戏业务压测，发现到一定人数之后，性能上不去

	通过 show engine innodb status 查看到 mutex 争用频繁
	
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

2. 结合源码分析
	
	主要是在 buf0buf.cc:1731 缓冲池文件中的某一行代码存在mutex争用
	对应的函数：将lru list中冷数据区域的数据页移动到热数据区域中，需要对缓冲池实例加mutex互斥锁
	
		
	5.7.26
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
			
			-- 对数据页所在的缓冲池实例加mutex锁
			buf_pool_mutex_enter(buf_pool);

			ut_a(buf_page_in_file(bpage));
			
			-- 移动old列表的数据页到young列表
			buf_LRU_make_block_young(bpage);
			
			-- 释放数据页所在的缓冲池实例的mutex锁
			buf_pool_mutex_exit(buf_pool);
		}
	

3. 解决办法
	1. 
		innodb_buffer_pool_size=12GB
		innodb_buffer_pool_size_instance=6
		
		性能得到进一步提升
		
	
	2. 用8.0.26版本

		8.0.26
			/** Moves a page to the start of the buffer pool LRU list. This high-level
			function can be used to prevent an important page from slipping out of
			the buffer pool.
			@param[in,out]	bpage	buffer block of a file page */
			void buf_page_make_young(buf_page_t *bpage) {
			  buf_pool_t *buf_pool = buf_pool_from_bpage(bpage);
			
			  -- 对数据页所在的缓冲池实例的lru list加mutex锁
			  mutex_enter(&buf_pool->LRU_list_mutex);

			  ut_a(buf_page_in_file(bpage));

			  buf_LRU_make_block_young(bpage);
			
			  -- 释放数据页所在的缓冲池实例的 lru list mutex锁
			  mutex_exit(&buf_pool->LRU_list_mutex);
			}
			
		innodb_buffer_pool_size=12GB
		innodb_buffer_pool_size_instance=3
		
		性能得到进一步提升
		

4. 8.0版本把全局大锁buffer pool mutex拆分

	https://www.cnblogs.com/jishuxiaobai/p/5940209.html	
		
	8.0最重要的一个改进就是：终于把全局大锁buffer pool mutex拆分了，各个链表由其专用的mutex保护，大大提升了访问扩展性。

	原来的一个大mutex被拆分成多个为free_list, LRU_list, zip_free, 和zip_hash单独使用mutex:

		批量扫描LRU（buf_do_LRU_batch）: buf_pool_t::LRU_list_mutex

		批量扫描FLUSH_LIST（buf_do_flush_list_batch）: buf_pool_t::flush_list_mutex

		脏页加入到flush_list(buf_flush_insert_into_flush_list): buf_pool_t::flush_list_mutex

		脏页写回磁盘后，从flush list上移除(buf_flush_write_complete): buf_pool_t::flush_state_mutex/flush_list_mutex

		从LRU上驱逐Page(buf_LRU_free_page):buf_pool_t::LRU_list_mutex， 及buf_pool_t::free_list_mutex(buf_LRU_block_free_non_file_page)

		buf_flush_LRU_list_batch 使用mutex_enter_nowait 来获取block锁，如果获取失败，说明正被其他session占用，忽略该block.

			
	

5. 关于buffer pool
	
	buffer pool包含：
		lru list
		free list 
		diry list 
		change bufer 
		double buffer 
		
		对 buffer pool instance加 mutex，会阻塞 instance 下所有的DML请求吗
			-- 自己也整理下
			从lru list的冷数据区域把数据页移动到热数据区域中，需要加 buffer pool mutex
			
			修改数据的时候，需要把数据页写入flush list, 需要加 buffer pool mutex
			
			因此，会阻塞 instance 下所有的DML请求。
			
			
	lru list 包含：
		
		冷数据和热数据
		对 buffer pool instance的 lru list 加 mutex，会阻塞 instance 下所有的DML请求吗
			-- 自己也整理下
			
			要更新的数据页不在LRU里：
				DML的时候，会产生脏页，那么这些脏页要加入flush list   如果flush list加了mutex，DML的请求会受到影响	
				
			要更新的数据页在LRU里
				LRU上的数据页，DML更新这些数据页，这些数据页也只是使用链表加入到flush list   如有 mutex 要研究下这个流程


6. 其它相关源码

	-- 获取数据页所在的缓冲池实例
	/******************************************************************//**
	Returns the buffer pool instance given a page instance
	@return buf_pool */
	UNIV_INLINE
	buf_pool_t*
	buf_pool_from_bpage(
	/*================*/
		const buf_page_t*	bpage); /*!< in: buffer pool page */
		
		
	buffer pool mutex 是对整个缓冲池加锁，还是对 instance 加锁？
		对 instance。
		
		
		
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
	
	
	/******************************************************************//**
	Remove or flush all the dirty pages that belong to a given tablespace
	inside a specific buffer pool instance. The pages will remain in the LRU
	list and will be evicted from the LRU list as they age and move towards
	the tail of the LRU list. */
	static
	void
	buf_flush_dirty_pages(
	/*==================*/
		buf_pool_t*	buf_pool,	/*!< buffer pool instance */
		ulint		id,		/*!< in: space id */
		FlushObserver*	observer,	/*!< in: flush observer */
		bool		flush,		/*!< in: flush to disk if true otherwise
						remove the pages without flushing */
		const trx_t*	trx)		/*!< to check if the operation must
						be interrupted */
	{
		dberr_t		err;

		do {
			buf_pool_mutex_enter(buf_pool);

			err = buf_flush_or_remove_pages(
				buf_pool, id, observer, flush, trx);

			buf_pool_mutex_exit(buf_pool);

			ut_ad(buf_flush_validate(buf_pool));

			if (err == DB_FAIL) {
				os_thread_sleep(2000);
			}

			if (err == DB_INTERRUPTED && observer != NULL) {
				ut_a(flush);

				flush = false;
				err = DB_FAIL;
			}

			/* DB_FAIL is a soft error, it means that the task wasn't
			completed, needs to be retried. */

			ut_ad(buf_flush_validate(buf_pool));

		} while (err == DB_FAIL);

		ut_ad(err == DB_INTERRUPTED
			  || buf_pool_get_dirty_pages_count(buf_pool, id, observer) == 0);
	}

