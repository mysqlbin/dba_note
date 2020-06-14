


Thread 119 (Thread 0x7fe6ebae0700 (LWP 19569)):
#0  0x00007fe7c4e9ca82 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fe6ebadfe70) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x24e5b08, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001094595 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1585
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6

Thread 118 (Thread 0x7fe6eb2df700 (LWP 19570)):
#0  0x00007fe7c4e9fbdd in nanosleep () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb7a0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0thread.cc:279
#2  0x0000000001094bbb in srv_master_sleep () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6



Thread 117 (Thread 0x7fe6eaade700 (LWP 19571)):
#0  0x00007fe7c393a2e7 in sched_yield () from /usr/lib64/libc.so.6
#1  0x00000000010b3aed in trx_purge_wait_for_workers_to_complete (purge_sys=0x7966e18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0purge.cc:1785
#2  trx_purge (n_purge_threads=4, batch_size=300, truncate=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0purge.cc:1889
#3  0x00000000010967e7 in srv_do_purge (n_total_purged=<optimized out>, n_threads=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2631
#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2803
#5  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#6  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6



简化后

	Thread 118 (Thread 0x7fe6eb2df700 (LWP 19570)):
	#0  0x00007fe7c4e9fbdd in nanosleep () 
	#1  0x0000000000ffb7a0 in os_thread_sleep 
	#2  0x0000000001094bbb in srv_master_sleep () 
	#3  srv_master_thread 
	#4  0x00007fe7c4e98dc5 in start_thread () 
	#5  0x00007fe7c395576d in clone ()

	Thread 117 (Thread 0x7fe6eaade700 (LWP 19571)):
	#0  sched_yield ()
	#1  trx_purge_wait_for_workers_to_complete 
	#2  trx_purge 
	#3  srv_do_purge 
	#4  srv_purge_coordinator_thread
	#5  start_thread () 
	#6  clone () 


/*******************************************************************//**
Wait for pending purge jobs to complete. */
static
void
trx_purge_wait_for_workers_to_complete(
/*===================================*/
	trx_purge_t*	purge_sys)	/*!< in: purge instance */
{

/*********************************************************************//**
Purge coordinator thread that schedules the purge tasks.
@return a dummy parameter */
extern "C"
os_thread_ret_t
DECLARE_THREAD(srv_purge_coordinator_thread)(


purge 线程也分为 协调线程和工作线程， 协调线程分发需要purge的 undo 给 工作线程， cleaner 线程、SQL 多线程也是如此。


Thread 116 (Thread 0x7fe6ea2dd700 (LWP 19572)):
#0  0x00007fe7c4e9c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x24e58c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x24e58c8, reset_sig_count=304561) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 115 (Thread 0x7fe6dd2ad700 (LWP 19573)):
#0  0x00007fe7c4e9c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x24e5958) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x24e5958, reset_sig_count=296006) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 114 (Thread 0x7fe6dcaac700 (LWP 19574)):
#0  0x00007fe7c4e9c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x24e59e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x24e59e8, reset_sig_count=290278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
