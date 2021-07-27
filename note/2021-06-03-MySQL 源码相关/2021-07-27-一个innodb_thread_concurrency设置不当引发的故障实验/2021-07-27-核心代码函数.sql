
Thread 39 (Thread 0x7fed04b2d700 (LWP 30761)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b5200) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7feccc037b90, record=0x7feccc037fa0 "\005p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7feccc037b90, buf=0x7feccc037fa0 "\005p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7feca402eaa0, table=0x7feccc0371a0, info=0x7fed04b2b4a0, update=0x7fed04b2b420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7feca401b7b8, thd=0x7feca402eaa0, table_list=0x7feca401a9a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7feca401b7b8, thd=0x7feca402eaa0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7feca402eaa0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7feca402eaa0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7feca402eaa0, com_data=0x7fed04b2cda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7feca402eaa0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cf60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
			
/*********************************************************************//**
如果并发线程太多，则让 OS 线程等待(>= srv_thread_concurrency) 在 InnoDB 中。 线程在 FIFO 队列中等待。

Puts an OS thread to wait if there are too many concurrent threads
(>= srv_thread_concurrency) inside InnoDB. The threads wait in a FIFO queue.
@param[in,out]	prebuilt	row prebuilt handler */
void
srv_conc_enter_innodb(
	row_prebuilt_t*	prebuilt)
{
	trx_t*	trx	= prebuilt->trx;

#ifdef UNIV_DEBUG
	{
		btrsea_sync_check	check(trx->has_search_latch);

		ut_ad(!sync_check_iterate(check));
	}
#endif /* UNIV_DEBUG */

	srv_conc_enter_innodb_with_atomics(trx);
}

/*********************************************************************//**
Handle the scheduling of a user thread that wants to enter InnoDB.  Setting
srv_adaptive_max_sleep_delay > 0 switches the adaptive sleep calibration to
ON. When set, we want to wait in the queue for as little time as possible.
However, very short waits will result in a lot of context switches and that
is also not desirable. When threads need to sleep multiple times we increment
os_thread_sleep_delay by one. When we see threads getting a slot without
waiting and there are no other threads waiting in the queue, we try and reduce
the wait as much as we can. Currently we reduce it by half each time. If the
thread only had to wait for one turn before it was able to enter InnoDB we
decrement it by one. This is to try and keep the sleep time stable around the
"optimum" sleep time. */
static
void
srv_conc_enter_innodb_with_atomics(
/*===============================*/
	trx_t*	trx)			/*!< in/out: transaction that wants
					to enter InnoDB */
{
	ulint	n_sleeps = 0;
	ibool	notified_mysql = FALSE;

	ut_a(!trx->declared_to_be_inside_innodb);

	for (;;) {
		ulint	sleep_in_us;

		if (srv_thread_concurrency == 0) {

			if (notified_mysql) {

				(void) os_atomic_decrement_lint(
					&srv_conc.n_waiting, 1);

				thd_wait_end(trx->mysql_thd);
			}

			return;
		}

		if (srv_conc.n_active < (lint) srv_thread_concurrency) {
			ulint	n_active;

			/* Check if there are any free tickets. */
			n_active = os_atomic_increment_lint(
				&srv_conc.n_active, 1);

			if (n_active <= srv_thread_concurrency) {

				srv_enter_innodb_with_tickets(trx);

				if (notified_mysql) {

					(void) os_atomic_decrement_lint(
						&srv_conc.n_waiting, 1);

					thd_wait_end(trx->mysql_thd);
				}

				if (srv_adaptive_max_sleep_delay > 0) {
					if (srv_thread_sleep_delay > 20
					    && n_sleeps == 1) {

						--srv_thread_sleep_delay;
					}

					if (srv_conc.n_waiting == 0) {
						srv_thread_sleep_delay >>= 1;
					}
				}

				return;
			}

			/* Since there were no free seats, we relinquish
			the overbooked ticket. */

			(void) os_atomic_decrement_lint(
				&srv_conc.n_active, 1);
		}

		if (!notified_mysql) {
			(void) os_atomic_increment_lint(
				&srv_conc.n_waiting, 1);

			/* Release possible search system latch this
			thread has */

			if (trx->has_search_latch) {
				trx_search_latch_release_if_reserved(trx);
			}

			thd_wait_begin(trx->mysql_thd, THD_WAIT_USER_LOCK);

			notified_mysql = TRUE;
		}

		DEBUG_SYNC_C("user_thread_waiting");
		trx->op_info = "sleeping before entering InnoDB";

		sleep_in_us = srv_thread_sleep_delay;

		/* Guard against overflow when adaptive sleep delay is on. */

		if (srv_adaptive_max_sleep_delay > 0
		    && sleep_in_us > srv_adaptive_max_sleep_delay) {

			sleep_in_us = srv_adaptive_max_sleep_delay;
			srv_thread_sleep_delay = static_cast<ulong>(sleep_in_us);
		}

		os_thread_sleep(sleep_in_us);

		trx->op_info = "";

		++n_sleeps;

		if (srv_adaptive_max_sleep_delay > 0 && n_sleeps > 1) {
			++srv_thread_sleep_delay;
		}
	}
}



/*****************************************************************//**
The thread sleeps at least the time given in microseconds. */
void
os_thread_sleep(
/*============*/
	ulint	tm)	/*!< in: time in microseconds */
{
#ifdef _WIN32
	Sleep((DWORD) tm / 1000);
#elif defined(HAVE_NANOSLEEP)
	struct timespec	t;

	t.tv_sec = tm / 1000000;
	t.tv_nsec = (tm % 1000000) * 1000;

	::nanosleep(&t, NULL);
#else
	struct timeval  t;

	t.tv_sec = tm / 1000000;
	t.tv_usec = tm % 1000000;

	select(0, NULL, NULL, NULL, &t);
#endif /* _WIN32 */
}