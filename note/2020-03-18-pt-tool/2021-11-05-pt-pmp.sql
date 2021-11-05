

https://www.cnblogs.com/ivictor/p/6012183.html


https://www.fordba.com/percona-toolkit-pt-pmp.html


https://mp.weixin.qq.com/s/A1IhA82xvbaIZK1kWPUduw	推荐几款我常用的MySQL调式分析利器




pstack $(pgrep -xn mysqld) > 1.sql
	
	
pt-pmp对堆栈信息排序

	pt-pmp 1.sql | less
	
		 24 pthread_cond_wait,native_cond_wait(thr_cond.h:140),my_cond_wait(thr_cond.h:140),inline_mysql_cond_wait(thr_cond.h:140),Per_thread_connection_handler::block_until_new_connection(thr_cond.h:140),handle_connection(connection_handler_per_thread.cc:329),pfs_spawn_thread(pfs.cc:2190),start_thread(libpthread.so.0),clone(libc.so.6)
		 18 __io_getevents_0_4(libaio.so.1),LinuxAIOHandler::collect(os0file.cc:2502),LinuxAIOHandler::poll(os0file.cc:2648),os_aio_linux_handler(os0file.cc:2704),os_aio_handler(os0file.cc:2704),fil_aio_wait(fil0fil.cc:5835),io_handler_thread(srv0start.cc:311),start_thread(libpthread.so.0),clone(libc.so.6)
		  3 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),srv_worker_thread(srv0srv.cc:2520),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 sigwait(libpthread.so.0),signal_hand(mysqld.cc:2120),pfs_spawn_thread(pfs.cc:2190),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 sigwaitinfo(libc.so.6),timer_notify_thread_func(posix_timers.c:77),pfs_spawn_thread(pfs.cc:2190),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),srv_purge_coordinator_suspend(srv0srv.cc:2676),srv_purge_coordinator_thread(srv0srv.cc:2676),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),buf_resize_thread(buf0buf.cc:3019),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),buf_flush_page_cleaner_worker(buf0flu.cc:3496),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),buf_dump_thread(buf0dump.cc:782),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,native_cond_wait(thr_cond.h:140),my_cond_wait(thr_cond.h:140),inline_mysql_cond_wait(thr_cond.h:140),compress_gtid_table(thr_cond.h:140),pfs_spawn_thread(pfs.cc:2190),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),srv_monitor_thread(srv0srv.cc:1585),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),srv_error_monitor_thread(srv0srv.cc:1751),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),pc_sleep_if_needed(buf0flu.cc:2690),buf_flush_page_cleaner_coordinator(buf0flu.cc:2690),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),lock_wait_timeout_thread(lock0wait.cc:501),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),ib_wqueue_timedwait(ut0wqueue.cc:160),fts_optimize_thread(fts0opt.cc:3031),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),dict_stats_thread(dict0stats_bg.cc:428),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 poll(libc.so.6),Mysqld_socket_listener::listen_for_connection_event(socket_connection.cc:852),connection_event_loop(connection_acceptor.h:66),mysqld_main(connection_acceptor.h:66),__libc_start_main(libc.so.6),_start
		  1 nanosleep(libpthread.so.0),os_thread_sleep(os0thread.cc:279),srv_master_sleep(srv0srv.cc:2330),srv_master_thread(srv0srv.cc:2330),start_thread(libpthread.so.0),clone(libc.so.6)

	
pt-pmp --pid $(pgrep -xn mysqld)
	[root@localhost ~]# pt-pmp --pid $(pgrep -xn mysqld)
	2021年 11月 05日 星期五 17:28:44 CST
		 24 pthread_cond_wait,native_cond_wait(thr_cond.h:140),my_cond_wait(thr_cond.h:140),inline_mysql_cond_wait(thr_cond.h:140),Per_thread_connection_handler::block_until_new_connection(thr_cond.h:140),handle_connection(connection_handler_per_thread.cc:329),pfs_spawn_thread(pfs.cc:2190),start_thread(libpthread.so.0),clone(libc.so.6)
		 18 __io_getevents_0_4(libaio.so.1),LinuxAIOHandler::collect(os0file.cc:2502),LinuxAIOHandler::poll(os0file.cc:2648),os_aio_linux_handler(os0file.cc:2704),os_aio_handler(os0file.cc:2704),fil_aio_wait(fil0fil.cc:5835),io_handler_thread(srv0start.cc:311),start_thread(libpthread.so.0),clone(libc.so.6)
		  3 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),srv_worker_thread(srv0srv.cc:2520),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 sigwait(libpthread.so.0),signal_hand(mysqld.cc:2120),pfs_spawn_thread(pfs.cc:2190),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 sigwaitinfo(libc.so.6),timer_notify_thread_func(posix_timers.c:77),pfs_spawn_thread(pfs.cc:2190),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),srv_purge_coordinator_suspend(srv0srv.cc:2676),srv_purge_coordinator_thread(srv0srv.cc:2676),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),buf_resize_thread(buf0buf.cc:3019),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),buf_flush_page_cleaner_worker(buf0flu.cc:3496),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,wait(os0event.cc:165),os_event::wait_low(os0event.cc:165),buf_dump_thread(buf0dump.cc:782),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_wait,native_cond_wait(thr_cond.h:140),my_cond_wait(thr_cond.h:140),inline_mysql_cond_wait(thr_cond.h:140),compress_gtid_table(thr_cond.h:140),pfs_spawn_thread(pfs.cc:2190),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),srv_monitor_thread(srv0srv.cc:1585),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),srv_error_monitor_thread(srv0srv.cc:1751),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),pc_sleep_if_needed(buf0flu.cc:2690),buf_flush_page_cleaner_coordinator(buf0flu.cc:2690),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),lock_wait_timeout_thread(lock0wait.cc:501),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),ib_wqueue_timedwait(ut0wqueue.cc:160),fts_optimize_thread(fts0opt.cc:3031),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 pthread_cond_timedwait,os_event::timed_wait(os0event.cc:285),os_event::wait_time_low(os0event.cc:412),dict_stats_thread(dict0stats_bg.cc:428),start_thread(libpthread.so.0),clone(libc.so.6)
		  1 poll(libc.so.6),Mysqld_socket_listener::listen_for_connection_event(socket_connection.cc:852),connection_event_loop(connection_acceptor.h:66),mysqld_main(connection_acceptor.h:66),__libc_start_main(libc.so.6),_start
		  1 nanosleep(libpthread.so.0),os_thread_sleep(os0thread.cc:279),srv_master_sleep(srv0srv.cc:2330),srv_master_thread(srv0srv.cc:2330),start_thread(libpthread.so.0),clone(libc.so.6)



	

