	
3.1 buf_LRU_flush_or_remove_pages
	3.1.1 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages
	3.1.2 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages
	3.1.3 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages->buf_pool_mutex_enter
	3.1.4 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages->->buf_flush_or_remove_pages	
	3.1.5 ulint BUF_LRU_DROP_SEARCH_SIZE = 1024
	
	3.1 buf_LRU_flush_or_remove_pages

		buf_LRU_flush_or_remove_pages (id=121, buf_remove=BUF_REMOVE_FLUSH_NO_WRITE
		
		/* 删除所有脏页或删除属于指定表空间的所有页（）。 */ 
		/******************************************************************//**
		Flushes all dirty pages or removes all pages belonging
		to a given tablespace. A PROBLEM: if readahead is being started, what
		guarantees that it will not try to read in pages after this operation
		has completed? */
		void
		buf_LRU_flush_or_remove_pages(
		/*==========================*/
			ulint		id,		/*!< in: space id */
			buf_remove_t	buf_remove,	/*!< in: remove or flush strategy */
			const trx_t*	trx)		/*!< to check if the operation must
							be interrupted */
		{
			ulint		i;
			
			/*
			在我们尝试一个一个地删除页面之前，我们首先尝试批量删除页面哈希索引条目以提高效率。 
			批处理尝试是尽力而为的尝试，并不能保证所有页面哈希条目都将被删除。 
			我们在下面一一去除剩余的页面哈希条目。
			？？？ 没有看到有清除数据表的AHI啊？ 不在 buf_LRU_flush_or_remove_pages 接口函数中
			*/
			/* Before we attempt to drop pages one by one we first
			attempt to drop page hash index entries in batches to make
			it more efficient. The batching attempt is a best effort
			attempt and does not guarantee that all pages hash entries
			will be dropped. We get rid of remaining page hash entries
			one by one below. */
			for (i = 0; i < srv_buf_pool_instances; i++) {
				buf_pool_t*	buf_pool;

				buf_pool = buf_pool_from_array(i);

				switch (buf_remove) {
				
				case BUF_REMOVE_FLUSH_NO_WRITE:
					/* It is a DROP TABLE for a single table
					tablespace. No AHI entries exist because
					we already dealt with them when freeing up
					extents. */
		
				buf_LRU_remove_pages(buf_pool, id, buf_remove, trx);
			}
		}


	3.1.1 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages
		/******************************************************************//**
		Remove pages belonging to a given tablespace inside a specific
		buffer pool instance when we are deleting the data file(s) of that
		tablespace. The pages still remain a part of LRU and are evicted from
		the list as they age towards the tail of the LRU only if buf_remove
		is BUF_REMOVE_FLUSH_NO_WRITE. */
		static
		void
		buf_LRU_remove_pages(
		/*=================*/
			buf_pool_t*	buf_pool,	/*!< buffer pool instance */
			ulint		id,		/*!< in: space id */
			buf_remove_t	buf_remove,	/*!< in: remove or flush strategy */
			const trx_t*	trx)		/*!< to check if the operation must
							be interrupted */
		{
			FlushObserver*	observer = (trx == NULL) ? NULL : trx->flush_observer;

			switch (buf_remove) {

			case BUF_REMOVE_FLUSH_NO_WRITE:
				/* Pass trx as NULL to avoid interruption check. */
				buf_flush_dirty_pages(buf_pool, id, observer, false, NULL);
				break;

			
		}
	
	3.1.2 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages
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
				
				/* 持有buffer pool mutex； */
				buf_pool_mutex_enter(buf_pool);
				
				/* 淘汰数据表的脏页 */	
				err = buf_flush_or_remove_pages(
					buf_pool, id, observer, flush, trx);
				
				/* 释放BP缓冲池的mutex互斥锁 */
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

	
	3.1.3 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages->buf_pool_mutex_enter
		/* 持有buffer pool mutex； */
		/** Acquire a buffer pool mutex. */
		#define buf_pool_mutex_enter(b) do {		\
			ut_ad(!(b)->zip_mutex.is_owned());	\
			mutex_enter(&(b)->mutex);		\
		} while (0)

		
	3.1.4 buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages->buf_flush_dirty_pages->->buf_flush_or_remove_pages
	
	
			/*
			当我们删除该表空间的数据文件时，删除属于特定缓冲池实例中给定表空间的所有脏页。 这些页面仍然是 LRU 的一部分，并且随着它们老化到 LRU 的尾部而从列表中被逐出。
			*/
			
			/******************************************************************//**
			Remove all dirty pages belonging to a given tablespace inside a specific
			buffer pool instance when we are deleting the data file(s) of that
			tablespace. The pages still remain a part of LRU and are evicted from
			the list as they age towards the tail of the LRU.
			@retval DB_SUCCESS if all freed
			@retval DB_FAIL if not all freed
			@retval DB_INTERRUPTED if the transaction was interrupted */
			static	MY_ATTRIBUTE((warn_unused_result))
			dberr_t
			buf_flush_or_remove_pages(
			/*======================*/
				buf_pool_t*	buf_pool,	/*!< buffer pool instance */
				ulint		id,		/*!< in: target space id for which
								to remove or flush pages */
				FlushObserver*	observer,	/*!< in: flush observer */
				bool		flush,		/*!< in: flush to disk if true but
								don't remove else remove without
								flushing to disk */
				const trx_t*	trx)		/*!< to check if the operation must
								be interrupted, can be 0 */--
							
		
		
			---------------------------------------------------------

	
	
	
	
	3.1.5 ulint BUF_LRU_DROP_SEARCH_SIZE = 1024
	
		/** When dropping the search hash index entries before deleting an ibd
		file, we build a local array of pages belonging to that tablespace
		in the buffer pool. Following is the size of that array.
		We also release buf_pool->mutex after scanning this many pages of the
		flush_list when dropping a table. This is to ensure that other threads
		are not blocked for extended period of time when using very large
		buffer pools. */
		
		/*
		
		在删除 ibd 之前删除搜索哈希索引条目时文件，我们构建属于该表空间的页面的本地数组在缓冲池中。 
		以下是该数组的大小。
		我们在扫描了这么多页面后也释放了 buf_pool->mutex删除表时flush_list。
		这是为了确保在使用非常大的缓冲池时不会长时间阻塞其他线程
		*/
		static const ulint BUF_LRU_DROP_SEARCH_SIZE = 1024;



