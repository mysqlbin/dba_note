
大纲
	
	1. 所有的后台线程对应的LWP ID
	2. master thread
	3. io thread
		3.1 insert buffer thread
		3.2 log thread
		3.3 io read thread 
		3.4 io write thread 
	4. purge thread	
	5. page cleaner thread
	6. sql/main
	7. sql/thread_timer_notifier
	8. innodb/srv_lock_timeout_thread
	9. innodb/srv_monitor_thread
	10. innodb/srv_error_monitor_thread 
	11. innodb/buf_dump_thread 
	12. innodb/dict_stats_thread
	13. sql/signal_handler



1. 所有的后台线程对应的LWP ID
	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|      1 |        12496 | sql/main                        | BACKGROUND |
	|      2 |        12497 | sql/thread_timer_notifier       | BACKGROUND |
	|      3 |        12498 | innodb/io_ibuf_thread           | BACKGROUND |
	|      4 |        12499 | innodb/io_log_thread            | BACKGROUND |
	|      5 |        12501 | innodb/io_read_thread           | BACKGROUND |
	|      6 |        12500 | innodb/io_read_thread           | BACKGROUND |
	|      7 |        12502 | innodb/io_read_thread           | BACKGROUND |
	|      8 |        12503 | innodb/io_read_thread           | BACKGROUND |
	|      9 |        12504 | innodb/io_read_thread           | BACKGROUND |
	|     10 |        12505 | innodb/io_read_thread           | BACKGROUND |
	|     11 |        12506 | innodb/io_read_thread           | BACKGROUND |
	|     12 |        12507 | innodb/io_read_thread           | BACKGROUND |
	|     13 |        12509 | innodb/io_write_thread          | BACKGROUND |
	|     14 |        12508 | innodb/io_write_thread          | BACKGROUND |
	|     15 |        12510 | innodb/io_write_thread          | BACKGROUND |
	|     16 |        12511 | innodb/io_write_thread          | BACKGROUND |
	|     17 |        12512 | innodb/io_write_thread          | BACKGROUND |
	|     18 |        12513 | innodb/io_write_thread          | BACKGROUND |
	|     19 |        12514 | innodb/io_write_thread          | BACKGROUND |
	|     20 |        12515 | innodb/io_write_thread          | BACKGROUND |
	|     21 |        12516 | innodb/page_cleaner_thread      | BACKGROUND |
	|     23 |        12521 | innodb/srv_lock_timeout_thread  | BACKGROUND |
	|     24 |        12523 | innodb/srv_monitor_thread       | BACKGROUND |
	|     25 |        12522 | innodb/srv_error_monitor_thread | BACKGROUND |
	|     26 |        12524 | innodb/srv_master_thread        | BACKGROUND |
	|     27 |        12527 | innodb/srv_worker_thread        | BACKGROUND |
	|     28 |        12525 | innodb/srv_purge_thread         | BACKGROUND |
	|     29 |        12528 | innodb/srv_worker_thread        | BACKGROUND |
	|     30 |        12526 | innodb/srv_worker_thread        | BACKGROUND |
	|     31 |        12531 | innodb/buf_dump_thread          | BACKGROUND |
	|     32 |        12532 | innodb/dict_stats_thread        | BACKGROUND |
	|     33 |        12537 | sql/signal_handler              | BACKGROUND |
	|     34 |        12538 | sql/compress_gtid_table         | FOREGROUND |

2. master thread

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     26 |        12524 | innodb/srv_master_thread        | BACKGROUND |

	-- THREAD_OS_ID = LWP ID = 12524

	Thread 118 (Thread 0x7fba64be7700 (LWP 12524)):
	#0  0x00007fbccef3de9d in nanosleep () from /lib64/libpthread.so.0
	#1  0x0000000000ffb7a0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0thread.cc:279
	#2  0x0000000001094bbb in srv_master_sleep () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2330
	#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2377
	#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
	
	
3. io thread
 
	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|      3 |        12498 | innodb/io_ibuf_thread           | BACKGROUND |
	|      4 |        12499 | innodb/io_log_thread            | BACKGROUND |
	|      5 |        12501 | innodb/io_read_thread           | BACKGROUND |
	|      6 |        12500 | innodb/io_read_thread           | BACKGROUND |
	|      7 |        12502 | innodb/io_read_thread           | BACKGROUND |
	|      8 |        12503 | innodb/io_read_thread           | BACKGROUND |
	|      9 |        12504 | innodb/io_read_thread           | BACKGROUND |
	|     10 |        12505 | innodb/io_read_thread           | BACKGROUND |
	|     11 |        12506 | innodb/io_read_thread           | BACKGROUND |
	|     12 |        12507 | innodb/io_read_thread           | BACKGROUND |
	|     13 |        12509 | innodb/io_write_thread          | BACKGROUND |
	|     14 |        12508 | innodb/io_write_thread          | BACKGROUND |
	|     15 |        12510 | innodb/io_write_thread          | BACKGROUND |
	|     16 |        12511 | innodb/io_write_thread          | BACKGROUND |
	|     17 |        12512 | innodb/io_write_thread          | BACKGROUND |
	|     18 |        12513 | innodb/io_write_thread          | BACKGROUND |
	|     19 |        12514 | innodb/io_write_thread          | BACKGROUND |
	|     20 |        12515 | innodb/io_write_thread          | BACKGROUND |
	
	3.1 insert buffer thread
	
		root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
		+--------+--------------+---------------------------------+------------+
		| thd_id | THREAD_OS_ID | user                            | TYPE       |
		+--------+--------------+---------------------------------+------------+
		|      3 |        12498 | innodb/io_ibuf_thread           | BACKGROUND |
		
		-- THREAD_OS_ID = LWP ID = 12498
		
		Thread 141 (Thread 0x7fba59382700 (LWP 12498)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba59381dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba59381dd0, m1=0x7fba59381e88, m2=0x7fba59381e80, request=0x7fba59381e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba59381e50, m2=0x7fba59381e80, m1=0x7fba59381e88, global_segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=0, m1=0x7fba59381e88, m2=0x7fba59381e80, request=0x7fba59381e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6



	3.2 log thread
	
		root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
		+--------+--------------+---------------------------------+------------+
		| thd_id | THREAD_OS_ID | user                            | TYPE       |
		+--------+--------------+---------------------------------+------------+
		|      4 |        12499 | innodb/io_log_thread            | BACKGROUND |
		
		-- THREAD_OS_ID = LWP ID = 12499
		
		Thread 140 (Thread 0x7fba58b81700 (LWP 12499)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba58b80dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba58b80dd0, m1=0x7fba58b80e88, m2=0x7fba58b80e80, request=0x7fba58b80e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba58b80e50, m2=0x7fba58b80e80, m1=0x7fba58b80e88, global_segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=1, m1=0x7fba58b80e88, m2=0x7fba58b80e80, request=0x7fba58b80e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		
		
	3.3 io read thread 
	
		root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
		+--------+--------------+---------------------------------+------------+
		| thd_id | THREAD_OS_ID | user                            | TYPE       |
		+--------+--------------+---------------------------------+------------+
		|      5 |        12501 | innodb/io_read_thread           | BACKGROUND |
		|      6 |        12500 | innodb/io_read_thread           | BACKGROUND |
		|      7 |        12502 | innodb/io_read_thread           | BACKGROUND |
		|      8 |        12503 | innodb/io_read_thread           | BACKGROUND |
		|      9 |        12504 | innodb/io_read_thread           | BACKGROUND |
		|     10 |        12505 | innodb/io_read_thread           | BACKGROUND |
		|     11 |        12506 | innodb/io_read_thread           | BACKGROUND |
		|     12 |        12507 | innodb/io_read_thread           | BACKGROUND |
			
		-- THREAD_OS_ID = LWP ID IN (12500, 12501, 12502, 12503, 12504, 12505, 12506, 12507)
			
		Thread 139 (Thread 0x7fba58380700 (LWP 12500)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba5837fdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba5837fdd0, m1=0x7fba5837fe88, m2=0x7fba5837fe80, request=0x7fba5837fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba5837fe50, m2=0x7fba5837fe80, m1=0x7fba5837fe88, global_segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=2, m1=0x7fba5837fe88, m2=0x7fba5837fe80, request=0x7fba5837fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 138 (Thread 0x7fba57b7f700 (LWP 12501)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba57b7edd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba57b7edd0, m1=0x7fba57b7ee88, m2=0x7fba57b7ee80, request=0x7fba57b7ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba57b7ee50, m2=0x7fba57b7ee80, m1=0x7fba57b7ee88, global_segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=3, m1=0x7fba57b7ee88, m2=0x7fba57b7ee80, request=0x7fba57b7ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 137 (Thread 0x7fba5737e700 (LWP 12502)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba5737ddd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba5737ddd0, m1=0x7fba5737de88, m2=0x7fba5737de80, request=0x7fba5737de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba5737de50, m2=0x7fba5737de80, m1=0x7fba5737de88, global_segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=4, m1=0x7fba5737de88, m2=0x7fba5737de80, request=0x7fba5737de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 136 (Thread 0x7fba56b7d700 (LWP 12503)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba56b7cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba56b7cdd0, m1=0x7fba56b7ce88, m2=0x7fba56b7ce80, request=0x7fba56b7ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba56b7ce50, m2=0x7fba56b7ce80, m1=0x7fba56b7ce88, global_segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=5, m1=0x7fba56b7ce88, m2=0x7fba56b7ce80, request=0x7fba56b7ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 135 (Thread 0x7fba5637c700 (LWP 12504)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba5637bdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba5637bdd0, m1=0x7fba5637be88, m2=0x7fba5637be80, request=0x7fba5637be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba5637be50, m2=0x7fba5637be80, m1=0x7fba5637be88, global_segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=6, m1=0x7fba5637be88, m2=0x7fba5637be80, request=0x7fba5637be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 134 (Thread 0x7fba55b7b700 (LWP 12505)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba55b7add0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba55b7add0, m1=0x7fba55b7ae88, m2=0x7fba55b7ae80, request=0x7fba55b7ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba55b7ae50, m2=0x7fba55b7ae80, m1=0x7fba55b7ae88, global_segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=7, m1=0x7fba55b7ae88, m2=0x7fba55b7ae80, request=0x7fba55b7ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 133 (Thread 0x7fba5537a700 (LWP 12506)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba55379dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba55379dd0, m1=0x7fba55379e88, m2=0x7fba55379e80, request=0x7fba55379e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba55379e50, m2=0x7fba55379e80, m1=0x7fba55379e88, global_segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=8, m1=0x7fba55379e88, m2=0x7fba55379e80, request=0x7fba55379e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 132 (Thread 0x7fba54b79700 (LWP 12507)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba54b78dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba54b78dd0, m1=0x7fba54b78e88, m2=0x7fba54b78e80, request=0x7fba54b78e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba54b78e50, m2=0x7fba54b78e80, m1=0x7fba54b78e88, global_segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=9, m1=0x7fba54b78e88, m2=0x7fba54b78e80, request=0x7fba54b78e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		
		
	3.4 io write thread 
	
		root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
		+--------+--------------+---------------------------------+------------+
		| thd_id | THREAD_OS_ID | user                            | TYPE       |
		+--------+--------------+---------------------------------+------------+
		|     13 |        12509 | innodb/io_write_thread          | BACKGROUND |
		|     14 |        12508 | innodb/io_write_thread          | BACKGROUND |
		|     15 |        12510 | innodb/io_write_thread          | BACKGROUND |
		|     16 |        12511 | innodb/io_write_thread          | BACKGROUND |
		|     17 |        12512 | innodb/io_write_thread          | BACKGROUND |
		|     18 |        12513 | innodb/io_write_thread          | BACKGROUND |
		|     19 |        12514 | innodb/io_write_thread          | BACKGROUND |
		|     20 |        12515 | innodb/io_write_thread          | BACKGROUND |
			
		-- THREAD_OS_ID = LWP ID IN (12508, 12509, 12510, 12511, 12512, 12513, 12514, 12515)
					
		Thread 131 (Thread 0x7fba54378700 (LWP 12508)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba54377dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba54377dd0, m1=0x7fba54377e88, m2=0x7fba54377e80, request=0x7fba54377e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba54377e50, m2=0x7fba54377e80, m1=0x7fba54377e88, global_segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=10, m1=0x7fba54377e88, m2=0x7fba54377e80, request=0x7fba54377e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 130 (Thread 0x7fba53b77700 (LWP 12509)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba53b76dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba53b76dd0, m1=0x7fba53b76e88, m2=0x7fba53b76e80, request=0x7fba53b76e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba53b76e50, m2=0x7fba53b76e80, m1=0x7fba53b76e88, global_segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=11, m1=0x7fba53b76e88, m2=0x7fba53b76e80, request=0x7fba53b76e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 129 (Thread 0x7fba53376700 (LWP 12510)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba53375dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba53375dd0, m1=0x7fba53375e88, m2=0x7fba53375e80, request=0x7fba53375e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba53375e50, m2=0x7fba53375e80, m1=0x7fba53375e88, global_segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=12, m1=0x7fba53375e88, m2=0x7fba53375e80, request=0x7fba53375e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 128 (Thread 0x7fba52b75700 (LWP 12511)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba52b74dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba52b74dd0, m1=0x7fba52b74e88, m2=0x7fba52b74e80, request=0x7fba52b74e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba52b74e50, m2=0x7fba52b74e80, m1=0x7fba52b74e88, global_segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=13, m1=0x7fba52b74e88, m2=0x7fba52b74e80, request=0x7fba52b74e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 127 (Thread 0x7fba52374700 (LWP 12512)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba52373dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba52373dd0, m1=0x7fba52373e88, m2=0x7fba52373e80, request=0x7fba52373e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba52373e50, m2=0x7fba52373e80, m1=0x7fba52373e88, global_segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=14, m1=0x7fba52373e88, m2=0x7fba52373e80, request=0x7fba52373e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 126 (Thread 0x7fba51b73700 (LWP 12513)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba51b72dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba51b72dd0, m1=0x7fba51b72e88, m2=0x7fba51b72e80, request=0x7fba51b72e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba51b72e50, m2=0x7fba51b72e80, m1=0x7fba51b72e88, global_segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=15, m1=0x7fba51b72e88, m2=0x7fba51b72e80, request=0x7fba51b72e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		Thread 125 (Thread 0x7fba51372700 (LWP 12514)):
		#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
		#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba51371dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
		#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba51371dd0, m1=0x7fba51371e88, m2=0x7fba51371e80, request=0x7fba51371e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
		#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba51371e50, m2=0x7fba51371e80, m1=0x7fba51371e88, global_segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
		#4  os_aio_handler (segment=16, m1=0x7fba51371e88, m2=0x7fba51371e80, request=0x7fba51371e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
		#5  0x000000000118a7cd in fil_aio_wait (segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
		#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
		#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
		#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		
		
		
4. purge thread	


	root@mysqldb 10:06:  [(none)]> show global variables like '%purge_thread%';
	+----------------------+-------+
	| Variable_name        | Value |
	+----------------------+-------+
	| innodb_purge_threads | 4     |
	+----------------------+-------+
	1 row in set (0.00 sec)

	innodb_purge_threads=4 拆分为1个协调线程，3个工作线程 

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     27 |        12527 | innodb/srv_worker_thread        | BACKGROUND |
	|     28 |        12525 | innodb/srv_purge_thread         | BACKGROUND |
	|     29 |        12528 | innodb/srv_worker_thread        | BACKGROUND |
	|     30 |        12526 | innodb/srv_worker_thread        | BACKGROUND |
	
	-- THREAD_OS_ID = LWP ID = 12525
	
	Thread 117 (Thread 0x7fba5ffff700 (LWP 12525)):
	#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x11f61588) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x11f61588, reset_sig_count=9351) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x00000000010a0ce9 in sync_array_wait_event (arr=0x290d0a8, cell=@0x7fba5fffeaf8: 0x7fbcc32b41a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0arr.cc:475
	#4  0x00000000010a33e6 in rw_lock_s_lock_spin (lock=0x11f87cb8, pass=<optimized out>, file_name=0x1609d20 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc", line=862) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0rw.cc:425
	#5  0x0000000001063f2d in rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:433
	#6  pfs_rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:796
	#7  row_purge_parse_undo_rec (thr=0x11fad978, updated_extern=0x7fba5fffec4f, undo_rec=0x7fba60039a20 "(\n\016\006\034", node=0x11fada40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:862
	#8  row_purge (thr=0x11fad978, undo_rec=0x7fba60039a20 "(\n\016\006\034", node=0x11fada40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1043
	#9  row_purge_step (thr=0x11fad978) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1125
	#10 0x000000000101b4af in que_thr_step (thr=0x11fad978) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1053
	#11 que_run_threads_low (thr=0x11fad978) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1115
	#12 que_run_threads (thr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1155
	#13 0x00000000010b3ab9 in trx_purge (n_purge_threads=4, batch_size=300, truncate=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0purge.cc:1883
	#14 0x00000000010967e7 in srv_do_purge (n_total_purged=<optimized out>, n_threads=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2631
	#15 srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2803
	#16 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#17 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
	
	-- THREAD_OS_ID = LWP ID IN (12526, 12527, 12528)
	-- srv_worker_thread：工作线程
	Thread 116 (Thread 0x7fba5f7fe700 (LWP 12526)):
	#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x2924538) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x2924538, reset_sig_count=3399) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
	#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
	Thread 115 (Thread 0x7fba5effd700 (LWP 12527)):
	#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x11f61588) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x11f61588, reset_sig_count=9351) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x00000000010a0ce9 in sync_array_wait_event (arr=0x290d0a8, cell=@0x7fba5effcc18: 0x7fbcc32b4128) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0arr.cc:475
	#4  0x00000000010a33e6 in rw_lock_s_lock_spin (lock=0x11f87cb8, pass=<optimized out>, file_name=0x1609d20 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc", line=862) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0rw.cc:425
	#5  0x0000000001063f2d in rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:433
	#6  pfs_rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:796
	#7  row_purge_parse_undo_rec (thr=0x11fad0e8, updated_extern=0x7fba5effcd6f, undo_rec=0x7fba60034ca0 "\026\261\016\024\034", node=0x11fad1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:862
	#8  row_purge (thr=0x11fad0e8, undo_rec=0x7fba60034ca0 "\026\261\016\024\034", node=0x11fad1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1043
	#9  row_purge_step (thr=0x11fad0e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1125
	#10 0x000000000101b4af in que_thr_step (thr=0x11fad0e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1053
	#11 que_run_threads_low (thr=0x11fad0e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1115
	#12 que_run_threads (thr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1155
	#13 0x0000000001093de0 in srv_task_execute () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2472
	#14 srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2522
	#15 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#16 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
	Thread 114 (Thread 0x7fba5e7fc700 (LWP 12528)):
	#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x29244a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x29244a8, reset_sig_count=3620) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
	#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
		
		
		
5. page cleaner thread
	
	root@mysqldb 10:11:  [(none)]> show global variables like '%cleaner%';
	+----------------------+-------+
	| Variable_name        | Value |
	+----------------------+-------+
	| innodb_page_cleaners | 2     |
	+----------------------+-------+
	1 row in set (0.00 sec)


	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     21 |        12516 | innodb/page_cleaner_thread      | BACKGROUND |
	
	-- THREAD_OS_ID = LWP ID = 12516
	-- buf_flush_page_cleaner_coordinator：协调线程
	Thread 123 (Thread 0x7fba50370700 (LWP 12516)):
	#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba5036f9a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2924778, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x0000000001139d13 in pc_sleep_if_needed (sig_count=2, next_loop_time=1626851864786) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:2690
	#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3191
	#5  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0	
		
	-- buf_flush_page_cleaner_worker：工作线程		
	Thread 122 (Thread 0x7fba4fb6f700 (LWP 12517)):
	#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x11f58648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x11f58648, reset_sig_count=5614) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
	#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
	

6. sql/main

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|      1 |        12496 | sql/main                        | BACKGROUND |

	-- THREAD_OS_ID = LWP ID = 12496
	
	Thread 1 (Thread 0x7fbccf35c780 (LWP 12496)):
	#0  0x00007fbccd9e4c3d in poll () from /lib64/libc.so.6
	#1  0x0000000000deee39 in Mysqld_socket_listener::listen_for_connection_event (this=0x121347f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/socket_connection.cc:852
	#2  0x00000000007cb384 in connection_event_loop (this=0x13658b20) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_acceptor.h:66
	#3  mysqld_main (argc=115, argv=0x27a8208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:5132
	#4  0x00007fbccd913555 in __libc_start_main () from /lib64/libc.so.6
	#5  0x00000000007c0ed9 in _start ()

7. sql/thread_timer_notifier

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|      2 |        12497 | sql/thread_timer_notifier       | BACKGROUND |
	
	
	-- THREAD_OS_ID = LWP ID = 12497
	
	Thread 142 (Thread 0x7fbcc5b20700 (LWP 12497)):
	#0  0x00007fbccd92858a in sigwaitinfo () from /lib64/libc.so.6
	#1  0x0000000000f5299b in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/mysys/posix_timers.c:77
	#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x28ef8a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#3  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#4  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6	
	
	
8. innodb/srv_lock_timeout_thread

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     23 |        12521 | innodb/srv_lock_timeout_thread  | BACKGROUND |
	
	-- THREAD_OS_ID = LWP ID = 12521
	
	Thread 121 (Thread 0x7fba663ea700 (LWP 12521)):
	#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba663e9db0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x11f55548, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x0000000000fd2494 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/lock/lock0wait.cc:501
	#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
	
	
8. innodb/srv_monitor_thread

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     24 |        12523 | innodb/srv_monitor_thread       | BACKGROUND |
	

	
9. 	innodb/srv_error_monitor_thread 

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     25 |        12522 | innodb/srv_error_monitor_thread | BACKGROUND |
	
	-- THREAD_OS_ID = LWP ID = 12522
	
	Thread 120 (Thread 0x7fba65be9700 (LWP 12522)):
	#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba65be8ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x29245c8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x0000000001095505 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1751
	#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
	
	
10. innodb/buf_dump_thread 

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     31 |        12531 | innodb/buf_dump_thread          | BACKGROUND 
	
	-- THREAD_OS_ID = LWP ID = 12531
	
	Thread 113 (Thread 0x7fba4ccce700 (LWP 12531)):
	#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x29246e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x29246e8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x00000000011335bc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0dump.cc:782
	#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6	
	

11. innodb/dict_stats_thread
	
	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     32 |        12532 | innodb/dict_stats_thread        | BACKGROUND |
	
	-- THREAD_OS_ID = LWP ID = 12532
	
	Thread 112 (Thread 0x7fba3ffff700 (LWP 12532)):
	#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba3fffedd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x11f5bf48, time_in_usec=<optimized out>, reset_sig_count=615) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x000000000117c887 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats_bg.cc:428
	#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6	
	
	
12. sql/signal_handler

	root@mysqldb 15:17:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|     33 |        12537 | sql/signal_handler              | BACKGROUND |
	
	-- THREAD_OS_ID = LWP ID = 12537
	
	Thread 109 (Thread 0x7fba64125700 (LWP 12537)):
	#0  0x00007fbccef3e3c1 in sigwait () from /lib64/libpthread.so.0
	#1  0x00000000007c5eeb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:2120
	#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#3  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#4  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6	