


通过 pstack 抓取，然后找到函数：	
	buf_flush_page_cleaner_coordinator
		# 刷脏页的协调线程
	buf_flush_page_cleaner_worker
		# 刷脏页的工作线程

	Thread 123 (Thread 0x7fe6df0ff700 (LWP 19562)):
	#0  0x00007fe7c4e9ca82 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fe6df0fe9e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x24e5c28, time_in_usec=<optimized out>, reset_sig_count=6298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x0000000001139d13 in pc_sleep_if_needed (sig_count=6298, next_loop_time=1583929138433) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:2690
	#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3191
	#5  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
	#6  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6

	Thread 122 (Thread 0x7fe6de8fe700 (LWP 19563)):
	#0  0x00007fe7c4e9c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x791fcc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x791fcc8, reset_sig_count=14671) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
	#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
	#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
	
简化后
	Thread 123 (Thread 0x7fe6df0ff700 (LWP 19562)):
	#0  pthread_cond_timedwait@@GLIBC_2.3.2 () 
	#1  os_event::timed_wait 
	#2  os_event::wait_time_low 
	#3  pc_sleep_if_needed
	#4  buf_flush_page_cleaner_coordinator 
	#5  start_thread () 
	#6  clone () from 
	
	Thread 122 (Thread 0x7fe6de8fe700 (LWP 19563)):
	#0  pthread_cond_wait@@GLIBC_2.3.2 
	#1  in wait (this=0x791fcc8) 
	#2  os_event::wait_low 
	#3  buf_flush_page_cleaner_worker
	#4  start_thread () 
	#5  clone () 


		参考：https://www.cnblogs.com/CtripDBA/p/11465315.html


buf_flush_page_cleaner_coordinator

	/******************************************************************//**
	page_cleaner thread tasked with flushing dirty pages from the buffer
	pools. As of now we'll have only one coordinator.
	@return a dummy parameter */
	extern "C"
	os_thread_ret_t
	DECLARE_THREAD(buf_flush_page_cleaner_coordinator)(
	/*===============================================*/
		void*	arg MY_ATTRIBUTE((unused)))
				/*!< in: a dummy parameter required by
				os_thread_create */
	{
		ulint	next_loop_time = ut_time_ms() + 1000;
		ulint	n_flushed = 0;
		ulint	last_activity = srv_get_activity_count();
		ulint	last_pages = 0;

		my_thread_init();

	#ifdef UNIV_PFS_THREAD
		pfs_register_thread(page_cleaner_thread_key);
	#endif /* UNIV_PFS_THREAD */

	#ifdef UNIV_DEBUG_THREAD_CREATION
		ib::info() << "page_cleaner thread running, id "
			<< os_thread_pf(os_thread_get_curr_id());
	#endif /* UNIV_DEBUG_THREAD_CREATION */

	#ifdef UNIV_LINUX
		/* linux might be able to set different setting for each thread.
		worth to try to set high priority for page cleaner threads */
		if (buf_flush_page_cleaner_set_priority(
			buf_flush_page_cleaner_priority)) {

			ib::info() << "page_cleaner coordinator priority: "
				<< buf_flush_page_cleaner_priority;
		} else {
			ib::info() << "If the mysqld execution user is authorized,"
			" page cleaner thread priority can be changed."
			" See the man page of setpriority().";
		}
	#endif /* UNIV_LINUX */

		buf_page_cleaner_is_active = true;

		while (!srv_read_only_mode
			   && srv_shutdown_state == SRV_SHUTDOWN_NONE
			   && recv_sys->heap != NULL) {
			/* treat flushing requests during recovery. */
			ulint	n_flushed_lru = 0;
			ulint	n_flushed_list = 0;

			os_event_wait(recv_sys->flush_start);

			if (srv_shutdown_state != SRV_SHUTDOWN_NONE
				|| recv_sys->heap == NULL) {
				break;
			}

			switch (recv_sys->flush_type) {
			case BUF_FLUSH_LRU:
				/* Flush pages from end of LRU if required */
				pc_request(0, LSN_MAX);
				while (pc_flush_slot() > 0) {}
				pc_wait_finished(&n_flushed_lru, &n_flushed_list);
				break;

			case BUF_FLUSH_LIST:
				/* Flush all pages */
				do {
					pc_request(ULINT_MAX, LSN_MAX);
					while (pc_flush_slot() > 0) {}
				} while (!pc_wait_finished(&n_flushed_lru,
							   &n_flushed_list));
				break;

			default:
				ut_ad(0);
			}

			os_event_reset(recv_sys->flush_start);
			os_event_set(recv_sys->flush_end);
		}

		os_event_wait(buf_flush_event);

		ulint		ret_sleep = 0;
		ulint		n_evicted = 0;
		ulint		n_flushed_last = 0;
		ulint		warn_interval = 1;
		ulint		warn_count = 0;
		int64_t		sig_count = os_event_reset(buf_flush_event);

		while (srv_shutdown_state == SRV_SHUTDOWN_NONE) {

			/* The page_cleaner skips sleep if the server is
			idle and there are no pending IOs in the buffer pool
			and there is work to do. */
			if (srv_check_activity(last_activity)
				|| buf_get_n_pending_read_ios()
				|| n_flushed == 0) {

				ret_sleep = pc_sleep_if_needed(
					next_loop_time, sig_count);

				if (srv_shutdown_state != SRV_SHUTDOWN_NONE) {
					break;
				}
			} else if (ut_time_ms() > next_loop_time) {
				ret_sleep = OS_SYNC_TIME_EXCEEDED;
			} else {
				ret_sleep = 0;
			}

			sig_count = os_event_reset(buf_flush_event);

			if (ret_sleep == OS_SYNC_TIME_EXCEEDED) {
				ulint	curr_time = ut_time_ms();

				if (curr_time > next_loop_time + 3000) {
					if (warn_count == 0) {
						ib::info() << "page_cleaner: 1000ms"
							" intended loop took "
							<< 1000 + curr_time
							   - next_loop_time
							<< "ms. The settings might not"
							" be optimal. (flushed="
							<< n_flushed_last
							<< " and evicted="
							<< n_evicted
							<< ", during the time.)";
						if (warn_interval > 300) {
							warn_interval = 600;
						} else {
							warn_interval *= 2;
						}

						warn_count = warn_interval;
					} else {
						--warn_count;
					}
				} else {
					/* reset counter */
					warn_interval = 1;
					warn_count = 0;
				}

				next_loop_time = curr_time + 1000;
				n_flushed_last = n_evicted = 0;
			}

			if (ret_sleep != OS_SYNC_TIME_EXCEEDED
				&& srv_flush_sync
				&& buf_flush_sync_lsn > 0) {
				/* woke up for flush_sync */
				mutex_enter(&page_cleaner->mutex);
				lsn_t	lsn_limit = buf_flush_sync_lsn;
				buf_flush_sync_lsn = 0;
				mutex_exit(&page_cleaner->mutex);

				/* Request flushing for threads */
				pc_request(ULINT_MAX, lsn_limit);

				ulint tm = ut_time_ms();

				/* Coordinator also treats requests */
				while (pc_flush_slot() > 0) {}

				/* only coordinator is using these counters,
				so no need to protect by lock. */
				page_cleaner->flush_time += ut_time_ms() - tm;
				page_cleaner->flush_pass++;

				/* Wait for all slots to be finished */
				ulint	n_flushed_lru = 0;
				ulint	n_flushed_list = 0;
				pc_wait_finished(&n_flushed_lru, &n_flushed_list);

				if (n_flushed_list > 0 || n_flushed_lru > 0) {
					buf_flush_stats(n_flushed_list, n_flushed_lru);

					MONITOR_INC_VALUE_CUMULATIVE(
						MONITOR_FLUSH_SYNC_TOTAL_PAGE,
						MONITOR_FLUSH_SYNC_COUNT,
						MONITOR_FLUSH_SYNC_PAGES,
						n_flushed_lru + n_flushed_list);
				}

				n_flushed = n_flushed_lru + n_flushed_list;

			} else if (srv_check_activity(last_activity)) {
				ulint	n_to_flush;
				lsn_t	lsn_limit = 0;

				/* Estimate pages from flush_list to be flushed */
				if (ret_sleep == OS_SYNC_TIME_EXCEEDED) {
					last_activity = srv_get_activity_count();
					n_to_flush =
						page_cleaner_flush_pages_recommendation(
							&lsn_limit, last_pages);
				} else {
					n_to_flush = 0;
				}

				/* Request flushing for threads */
				pc_request(n_to_flush, lsn_limit);

				ulint tm = ut_time_ms();

				/* Coordinator also treats requests */
				while (pc_flush_slot() > 0) {
					/* No op */
				}

				/* only coordinator is using these counters,
				so no need to protect by lock. */
				page_cleaner->flush_time += ut_time_ms() - tm;
				page_cleaner->flush_pass++ ;

				/* Wait for all slots to be finished */
				ulint	n_flushed_lru = 0;
				ulint	n_flushed_list = 0;

				pc_wait_finished(&n_flushed_lru, &n_flushed_list);

				if (n_flushed_list > 0 || n_flushed_lru > 0) {
					buf_flush_stats(n_flushed_list, n_flushed_lru);
				}

				if (ret_sleep == OS_SYNC_TIME_EXCEEDED) {
					last_pages = n_flushed_list;
				}

				n_evicted += n_flushed_lru;
				n_flushed_last += n_flushed_list;

				n_flushed = n_flushed_lru + n_flushed_list;

				if (n_flushed_lru) {
					MONITOR_INC_VALUE_CUMULATIVE(
						MONITOR_LRU_BATCH_FLUSH_TOTAL_PAGE,
						MONITOR_LRU_BATCH_FLUSH_COUNT,
						MONITOR_LRU_BATCH_FLUSH_PAGES,
						n_flushed_lru);
				}

				if (n_flushed_list) {
					MONITOR_INC_VALUE_CUMULATIVE(
						MONITOR_FLUSH_ADAPTIVE_TOTAL_PAGE,
						MONITOR_FLUSH_ADAPTIVE_COUNT,
						MONITOR_FLUSH_ADAPTIVE_PAGES,
						n_flushed_list);
				}

			} else if (ret_sleep == OS_SYNC_TIME_EXCEEDED) {
				/* no activity, slept enough */
				buf_flush_lists(PCT_IO(100), LSN_MAX, &n_flushed);

				n_flushed_last += n_flushed;

				if (n_flushed) {
					MONITOR_INC_VALUE_CUMULATIVE(
						MONITOR_FLUSH_BACKGROUND_TOTAL_PAGE,
						MONITOR_FLUSH_BACKGROUND_COUNT,
						MONITOR_FLUSH_BACKGROUND_PAGES,
						n_flushed);

				}

			} else {
				/* no activity, but woken up by event */
				n_flushed = 0;
			}

			ut_d(buf_flush_page_cleaner_disabled_loop());
		}

		ut_ad(srv_shutdown_state > 0);
		if (srv_fast_shutdown == 2
			|| srv_shutdown_state == SRV_SHUTDOWN_EXIT_THREADS) {
			/* In very fast shutdown or when innodb failed to start, we
			simulate a crash of the buffer pool. We are not required to do
			any flushing. */
			goto thread_exit;
		}

		/* In case of normal and slow shutdown the page_cleaner thread
		must wait for all other activity in the server to die down.
		Note that we can start flushing the buffer pool as soon as the
		server enters shutdown phase but we must stay alive long enough
		to ensure that any work done by the master or purge threads is
		also flushed.
		During shutdown we pass through two stages. In the first stage,
		when SRV_SHUTDOWN_CLEANUP is set other threads like the master
		and the purge threads may be working as well. We start flushing
		the buffer pool but can't be sure that no new pages are being
		dirtied until we enter SRV_SHUTDOWN_FLUSH_PHASE phase. */

		do {
			pc_request(ULINT_MAX, LSN_MAX);

			while (pc_flush_slot() > 0) {}

			ulint	n_flushed_lru = 0;
			ulint	n_flushed_list = 0;
			pc_wait_finished(&n_flushed_lru, &n_flushed_list);

			n_flushed = n_flushed_lru + n_flushed_list;

			/* We sleep only if there are no pages to flush */
			if (n_flushed == 0) {
				os_thread_sleep(100000);
			}
		} while (srv_shutdown_state == SRV_SHUTDOWN_CLEANUP);

		/* At this point all threads including the master and the purge
		thread must have been suspended. */
		ut_a(srv_get_active_thread_type() == SRV_NONE);
		ut_a(srv_shutdown_state == SRV_SHUTDOWN_FLUSH_PHASE);

		/* We can now make a final sweep on flushing the buffer pool
		and exit after we have cleaned the whole buffer pool.
		It is important that we wait for any running batch that has
		been triggered by us to finish. Otherwise we can end up
		considering end of that batch as a finish of our final
		sweep and we'll come out of the loop leaving behind dirty pages
		in the flush_list */
		buf_flush_wait_batch_end(NULL, BUF_FLUSH_LIST);
		buf_flush_wait_LRU_batch_end();

		bool	success;

		do {
			pc_request(ULINT_MAX, LSN_MAX);

			while (pc_flush_slot() > 0) {}

			ulint	n_flushed_lru = 0;
			ulint	n_flushed_list = 0;
			success = pc_wait_finished(&n_flushed_lru, &n_flushed_list);

			n_flushed = n_flushed_lru + n_flushed_list;

			buf_flush_wait_batch_end(NULL, BUF_FLUSH_LIST);
			buf_flush_wait_LRU_batch_end();

		} while (!success || n_flushed > 0);

		/* Some sanity checks */
		ut_a(srv_get_active_thread_type() == SRV_NONE);
		ut_a(srv_shutdown_state == SRV_SHUTDOWN_FLUSH_PHASE);

		for (ulint i = 0; i < srv_buf_pool_instances; i++) {
			buf_pool_t* buf_pool = buf_pool_from_array(i);
			ut_a(UT_LIST_GET_LEN(buf_pool->flush_list) == 0);
		}

		/* We have lived our life. Time to die. */

	thread_exit:
		/* All worker threads are waiting for the event here,
		and no more access to page_cleaner structure by them.
		Wakes worker threads up just to make them exit. */
		page_cleaner->is_running = false;
		os_event_set(page_cleaner->is_requested);

		buf_flush_page_cleaner_close();

		buf_page_cleaner_is_active = false;

		my_thread_end();

		/* We count the number of threads in os_thread_exit(). A created
		thread should always use that to exit and not use return() to exit. */
		os_thread_exit();

		OS_THREAD_DUMMY_RETURN;
	}


buf_flush_page_cleaner_worker

	/******************************************************************//**
	Worker thread of page_cleaner.
	@return a dummy parameter */
	extern "C"
	os_thread_ret_t
	DECLARE_THREAD(buf_flush_page_cleaner_worker)(
	/*==========================================*/
		void*	arg MY_ATTRIBUTE((unused)))
				/*!< in: a dummy parameter required by
				os_thread_create */
	{
		my_thread_init();

		mutex_enter(&page_cleaner->mutex);
		page_cleaner->n_workers++;
		mutex_exit(&page_cleaner->mutex);

	#ifdef UNIV_LINUX
		/* linux might be able to set different setting for each thread
		worth to try to set high priority for page cleaner threads */
		if (buf_flush_page_cleaner_set_priority(
			buf_flush_page_cleaner_priority)) {

			ib::info() << "page_cleaner worker priority: "
				<< buf_flush_page_cleaner_priority;
		}
	#endif /* UNIV_LINUX */

		while (true) {
			os_event_wait(page_cleaner->is_requested);

			ut_d(buf_flush_page_cleaner_disabled_loop());

			if (!page_cleaner->is_running) {
				break;
			}

			pc_flush_slot();
		}

		mutex_enter(&page_cleaner->mutex);
		page_cleaner->n_workers--;
		mutex_exit(&page_cleaner->mutex);

		my_thread_end();

		os_thread_exit();

		OS_THREAD_DUMMY_RETURN;
	}

