Thread 81 (Thread 0x7fef3d317700 (LWP 20584)):
#0  0x00007fef4519358a in sigwaitinfo () from /lib64/libc.so.6
#1  0x0000000000f56eab in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/mysys/posix_timers.c:77
#2  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2bfb0f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#3  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 80 (Thread 0x7fecfeccc700 (LWP 20587)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfeccbdd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfeccbdd0, m1=0x7fecfeccbe88, m2=0x7fecfeccbe80, request=0x7fecfeccbe50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfeccbe50, m2=0x7fecfeccbe80, m1=0x7fecfeccbe88, global_segment=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=0, m1=0x7fecfeccbe88, m2=0x7fecfeccbe80, request=0x7fecfeccbe50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 79 (Thread 0x7fecfe4cb700 (LWP 20588)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfe4cadd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfe4cadd0, m1=0x7fecfe4cae88, m2=0x7fecfe4cae80, request=0x7fecfe4cae50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfe4cae50, m2=0x7fecfe4cae80, m1=0x7fecfe4cae88, global_segment=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=1, m1=0x7fecfe4cae88, m2=0x7fecfe4cae80, request=0x7fecfe4cae50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 78 (Thread 0x7fecfdcca700 (LWP 20589)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfdcc9dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfdcc9dd0, m1=0x7fecfdcc9e88, m2=0x7fecfdcc9e80, request=0x7fecfdcc9e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfdcc9e50, m2=0x7fecfdcc9e80, m1=0x7fecfdcc9e88, global_segment=2) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=2, m1=0x7fecfdcc9e88, m2=0x7fecfdcc9e80, request=0x7fecfdcc9e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 77 (Thread 0x7fecfd4c9700 (LWP 20590)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfd4c8dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfd4c8dd0, m1=0x7fecfd4c8e88, m2=0x7fecfd4c8e80, request=0x7fecfd4c8e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfd4c8e50, m2=0x7fecfd4c8e80, m1=0x7fecfd4c8e88, global_segment=3) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=3, m1=0x7fecfd4c8e88, m2=0x7fecfd4c8e80, request=0x7fecfd4c8e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 76 (Thread 0x7fecfccc8700 (LWP 20591)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfccc7dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfccc7dd0, m1=0x7fecfccc7e88, m2=0x7fecfccc7e80, request=0x7fecfccc7e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfccc7e50, m2=0x7fecfccc7e80, m1=0x7fecfccc7e88, global_segment=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=4, m1=0x7fecfccc7e88, m2=0x7fecfccc7e80, request=0x7fecfccc7e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 75 (Thread 0x7fecfc4c7700 (LWP 20592)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfc4c6dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfc4c6dd0, m1=0x7fecfc4c6e88, m2=0x7fecfc4c6e80, request=0x7fecfc4c6e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfc4c6e50, m2=0x7fecfc4c6e80, m1=0x7fecfc4c6e88, global_segment=5) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=5, m1=0x7fecfc4c6e88, m2=0x7fecfc4c6e80, request=0x7fecfc4c6e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 74 (Thread 0x7fecfbcc6700 (LWP 20593)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfbcc5dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfbcc5dd0, m1=0x7fecfbcc5e88, m2=0x7fecfbcc5e80, request=0x7fecfbcc5e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfbcc5e50, m2=0x7fecfbcc5e80, m1=0x7fecfbcc5e88, global_segment=6) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=6, m1=0x7fecfbcc5e88, m2=0x7fecfbcc5e80, request=0x7fecfbcc5e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 73 (Thread 0x7fecfb4c5700 (LWP 20594)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfb4c4dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfb4c4dd0, m1=0x7fecfb4c4e88, m2=0x7fecfb4c4e80, request=0x7fecfb4c4e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfb4c4e50, m2=0x7fecfb4c4e80, m1=0x7fecfb4c4e88, global_segment=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=7, m1=0x7fecfb4c4e88, m2=0x7fecfb4c4e80, request=0x7fecfb4c4e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 72 (Thread 0x7fecfacc4700 (LWP 20595)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfacc3dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfacc3dd0, m1=0x7fecfacc3e88, m2=0x7fecfacc3e80, request=0x7fecfacc3e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfacc3e50, m2=0x7fecfacc3e80, m1=0x7fecfacc3e88, global_segment=8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=8, m1=0x7fecfacc3e88, m2=0x7fecfacc3e80, request=0x7fecfacc3e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 71 (Thread 0x7fecfa4c3700 (LWP 20596)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfa4c2dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfa4c2dd0, m1=0x7fecfa4c2e88, m2=0x7fecfa4c2e80, request=0x7fecfa4c2e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfa4c2e50, m2=0x7fecfa4c2e80, m1=0x7fecfa4c2e88, global_segment=9) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=9, m1=0x7fecfa4c2e88, m2=0x7fecfa4c2e80, request=0x7fecfa4c2e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 70 (Thread 0x7fecf9cc2700 (LWP 20597)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fecf9cc19a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x2c3a878, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000001203623 in pc_sleep_if_needed (sig_count=2, next_loop_time=1627284287627) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:2690
#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3191
#5  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 69 (Thread 0x7fecf94c1700 (LWP 20598)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x1075d8e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x1075d8e8, reset_sig_count=1525) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000001204ed7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3496
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 68 (Thread 0x7fecf8a9a700 (LWP 20605)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fecf8a99db0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x1075baf8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000109a924 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/lock/lock0wait.cc:501
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 67 (Thread 0x7fed0be0f700 (LWP 20606)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fed0be0eac0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x2c3a6c8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000115e8f5 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:1751
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 66 (Thread 0x7fed0b60e700 (LWP 20607)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fed0b60de30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x2c3a758, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000115d985 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:1585
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 65 (Thread 0x7fed0ae0d700 (LWP 20608)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x000000000115dfab in srv_master_sleep () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 64 (Thread 0x7fed0a60c700 (LWP 20609)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a488) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a488, reset_sig_count=367) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115f98d in srv_purge_coordinator_suspend (rseg_history_len=39, slot=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2676
#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2792
#5  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 63 (Thread 0x7fed09e0b700 (LWP 20610)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a518) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a518, reset_sig_count=1474) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 62 (Thread 0x7fed0960a700 (LWP 20611)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a5a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a5a8, reset_sig_count=1420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 61 (Thread 0x7fed08e09700 (LWP 20612)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a638) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a638, reset_sig_count=1312) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 60 (Thread 0x7fed08608700 (LWP 20613)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a7e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a7e8, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x00000000011fcecc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0dump.cc:782
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 59 (Thread 0x7fed07e07700 (LWP 20614)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fed07e06dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x10761238, time_in_usec=<optimized out>, reset_sig_count=102) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000001246297 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/dict/dict0stats_bg.cc:428
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 58 (Thread 0x7fed07606700 (LWP 20615)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fed07605ab0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x10912108, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x00000000011af7f4 in ib_wqueue_timedwait (wq=0x10912008, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/ut/ut0wqueue.cc:160
#4  0x000000000128f042 in fts_optimize_thread (arg=0x10912008) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fts/fts0opt.cc:2900
#5  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 57 (Thread 0x7fed06e05700 (LWP 20616)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a908) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a908, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x00000000011f337c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:3019
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 56 (Thread 0x7fed05d3c700 (LWP 20620)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eb6120 in native_cond_wait (mutex=0x109e6c00, cond=0x109e6c30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x109e6c00, cond=0x109e6c30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=751, src_file=0x15e7630 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_queue.cc", mutex=0x109e6c00, that=0x109e6c30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Event_queue::cond_wait (this=0x109e6c00, thd=0x10ab54f0, abstime=0x0, stage=<optimized out>, src_func=0x15e7780 <Event_queue::get_top_for_execution_if_time(THD*, Event_queue_element_for_exec**)::__func__> "get_top_for_execution_if_time", src_file=0x15e7630 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_queue.cc", src_line=579) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_queue.cc:751
#5  0x0000000000eb70bc in Event_queue::get_top_for_execution_if_time (this=0x109e6c00, thd=0x10ab54f0, event_name=0x7fed05d3be38) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_queue.cc:579
#6  0x0000000000eb893f in Event_scheduler::run (this=0x10a5cc80, thd=0x10ab54f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_scheduler.cc:519
#7  0x0000000000eb8abc in event_scheduler_thread (arg=0x10aff700) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_scheduler.cc:243
#8  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a57250) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#9  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#10 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 55 (Thread 0x7fed05cb8700 (LWP 20621)):
#0  0x00007fef467aa3c1 in sigwait () from /lib64/libpthread.so.0
#1  0x00000000007c70bb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/mysqld.cc:2125
#2  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10966ab0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#3  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 54 (Thread 0x7fed05c76700 (LWP 20622)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ec1e35 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=879, src_file=0x15e7fa0 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/rpl_gtid_persist.cc:879
#5  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a57250) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#6  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 53 (Thread 0x7fed05475700 (LWP 20624)):
#0  0x00007fef467a9aeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012c5c70 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fecd00008e0, mysql_socket=..., src_line=123, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fecd002ad50, buf=0x7fecd00008e0 "\001", size=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:123
#3  0x0000000000c6e8a3 in net_read_raw_loop (net=0x7fecd0013ae8, count=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:672
#4  0x0000000000c6f13b in net_read_packet_header (net=0x7fecd0013ae8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:756
#5  net_read_packet (net=<optimized out>, complen=0x7fed05474cf8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:822
#6  0x0000000000c6f3ec in my_net_read (net=0x7fecd0013ae8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:899
#7  0x0000000000c7cc8c in Protocol_classic::read_packet (this=0x7fecd0013388) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:808
#8  0x0000000000c7ba22 in Protocol_classic::get_command (this=0x7fecd0013388, com_data=0x7fed05474da0, cmd=0x7fed05474dcc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:965
#9  0x0000000000d1e847 in do_command (thd=0x7fecd0012330) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:964
#10 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#11 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a57250) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#12 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 52 (Thread 0x7fed05055700 (LWP 26299)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecdc06adb0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecdc06adb0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecdc06adb0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecdc06adb0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecdc06adb0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecdc06adb0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecdc06adb0, com_data=0x7fed05054da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecdc06adb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10b44df0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 51 (Thread 0x7fed03d83700 (LWP 26305)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec6c0008c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c0008c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c0008c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec6c0008c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec6c0008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec6c0008c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec6c0008c0, com_data=0x7fed03d82da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec6c0008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0cd70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 50 (Thread 0x7fed04bf3700 (LWP 26620)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb0011ff0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb0011ff0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb0011ff0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb0011ff0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb0011ff0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb0011ff0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb0011ff0, com_data=0x7fed04bf2da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb0011ff0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 49 (Thread 0x7fed03e8b700 (LWP 26627)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec740115b0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec740115b0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec740115b0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec740115b0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec740115b0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec740115b0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec740115b0, com_data=0x7fed03e8ada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec740115b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 48 (Thread 0x7fed04581700 (LWP 26630)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec8c0172a0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec8c0172a0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec8c0172a0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec8c0172a0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec8c0172a0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec8c0172a0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec8c0172a0, com_data=0x7fed04580da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec8c0172a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a57250) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 47 (Thread 0x7fed04899700 (LWP 26637)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x10a00100, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x10a00100, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x10a00100, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x10a00100, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x10a00100, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x10a00100, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x10a00100, com_data=0x7fed04898da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x10a00100) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c05020) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 46 (Thread 0x7fed05097700 (LWP 26655)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecc403c3c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc403c3c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc403c3c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecc403c3c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc403c3c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecc403c3c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc403c3c0, com_data=0x7fed05096da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc403c3c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0b290) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 45 (Thread 0x7fed03b31700 (LWP 26669)):
#0  0x00007fef467a9aeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012c5c70 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fec7c0008e0, mysql_socket=..., src_line=123, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fec7da64bd0, buf=0x7fec7c0008e0 "\a", size=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:123
#3  0x0000000000c6e8a3 in net_read_raw_loop (net=0x7fec7da5f3e8, count=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:672
#4  0x0000000000c6f13b in net_read_packet_header (net=0x7fec7da5f3e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:756
#5  net_read_packet (net=<optimized out>, complen=0x7fed03b30cf8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:822
#6  0x0000000000c6f3ec in my_net_read (net=0x7fec7da5f3e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:899
#7  0x0000000000c7cc8c in Protocol_classic::read_packet (this=0x7fec7da5ec88) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:808
#8  0x0000000000c7ba22 in Protocol_classic::get_command (this=0x7fec7da5ec88, com_data=0x7fed03b30da0, cmd=0x7fed03b30dcc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:965
#9  0x0000000000d1e847 in do_command (thd=0x7fec7da5dc30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:964
#10 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#11 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109fbe70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#12 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 44 (Thread 0x7fed04c77700 (LWP 30742)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecf402b260, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecf402b260, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecf402b260, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecf402b260, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecf402b260, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecf402b260, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecf402b260, com_data=0x7fed04c76da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecf402b260) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10b7ddb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 43 (Thread 0x7fed04f8f700 (LWP 30744)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec6c014760, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c014760, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c014760, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec6c014760, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec6c014760, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec6c014760, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec6c014760, com_data=0x7fed04f8eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec6c014760) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a2a810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 42 (Thread 0x7fed04227700 (LWP 30748)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec88011530, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec88011530, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec88011530, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec88011530, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec88011530, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec88011530, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec88011530, com_data=0x7fed04226da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec88011530) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 41 (Thread 0x7fed0511b700 (LWP 30754)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec7401cb60, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec7401cb60, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec7401cb60, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec7401cb60, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec7401cb60, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec7401cb60, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec7401cb60, com_data=0x7fed0511ada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec7401cb60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ec20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7fed04b2d700 (LWP 30761)):
#0  0x00007fef45251c6d in fdatasync () from /lib64/libc.so.6
#1  0x0000000000f4e240 in my_sync (fd=115, my_flags=48) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/mysys/my_sync.c:76
#2  0x0000000000ee893f in inline_mysql_file_sync (flags=48, fd=115, src_line=9229, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_file.h:1420
#3  MYSQL_BIN_LOG::sync_binlog_file (this=<optimized out>, force=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9227
#4  0x0000000000ef495a in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca4030580, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9664
#5  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca4030580, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#6  0x0000000000823434 in ha_commit_trans (thd=0x7feca4030580, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#7  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#8  0x0000000000d17c5f in mysql_execute_command (thd=0x7feca4030580, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#9  0x0000000000d1c86d in mysql_parse (thd=0x7feca4030580, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#10 0x0000000000d1da95 in dispatch_command (thd=0x7feca4030580, com_data=0x7fed04b2cda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#11 0x0000000000d1e944 in do_command (thd=0x7feca4030580) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#12 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#13 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cf60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#14 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#15 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 39 (Thread 0x7fed0453f700 (LWP 30765)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec94018be0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec94018be0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec94018be0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec94018be0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec94018be0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec94018be0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec94018be0, com_data=0x7fed0453eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec94018be0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f610) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 38 (Thread 0x7fed0432f700 (LWP 30769)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb800bb30, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb800bb30, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb800bb30, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb800bb30, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb800bb30, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb800bb30, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb800bb30, com_data=0x7fed0432eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb800bb30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a57250) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7fed046cb700 (LWP 30776)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb80008c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb80008c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb80008c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb80008c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb80008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb80008c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb80008c0, com_data=0x7fed046cada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb80008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10b45870) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 36 (Thread 0x7fed048db700 (LWP 30780)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecbc007fe0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecbc007fe0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecbc007fe0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecbc007fe0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecbc007fe0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecbc007fe0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecbc007fe0, com_data=0x7fed048dada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecbc007fe0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0d0f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7fed03d41700 (LWP 30787)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecc4004940, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc4004940, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc4004940, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecc4004940, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc4004940, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecc4004940, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc4004940, com_data=0x7fed03d40da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc4004940) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0a810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7fed04e87700 (LWP 30788)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecd0acea10, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd0acea10, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd0acea10, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecd0acea10, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecd0acea10, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecd0acea10, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecd0acea10, com_data=0x7fed04e86da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecd0acea10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0a490) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7fed03c39700 (LWP 30791)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec9c0144c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec9c0144c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec9c0144c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec9c0144c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec9c0144c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec9c0144c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec9c0144c0, com_data=0x7fed03c38da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec9c0144c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0af10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7fed04017700 (LWP 30794)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecd0ad9fb0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd0ad9fb0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd0ad9fb0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecd0ad9fb0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecd0ad9fb0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecd0ad9fb0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecd0ad9fb0, com_data=0x7fed04016da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecd0ad9fb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a09d90) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7fed0519f700 (LWP 30798)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecc402c8b0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc402c8b0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc402c8b0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecc402c8b0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc402c8b0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecc402c8b0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc402c8b0, com_data=0x7fed0519eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc402c8b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c05720) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7fed04aa9700 (LWP 32358)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x10b77eb0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x10b77eb0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x10b77eb0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x10b77eb0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x10b77eb0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x10b77eb0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x10b77eb0, com_data=0x7fed04aa8da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x10b77eb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7800) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7fed049a1700 (LWP 32360)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb4017850, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb4017850, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb4017850, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb4017850, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb4017850, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb4017850, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb4017850, com_data=0x7fed049a0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb4017850) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7fed03f51700 (LWP 32364)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecdc077900, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecdc077900, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecdc077900, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecdc077900, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecdc077900, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecdc077900, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecdc077900, com_data=0x7fed03f50da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecdc077900) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ec20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7fed03b73700 (LWP 32365)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fece80479f0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece80479f0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece80479f0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fece80479f0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fece80479f0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fece80479f0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fece80479f0, com_data=0x7fed03b72da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fece80479f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5920) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7fed03e49700 (LWP 32366)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecf4038710, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecf4038710, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecf4038710, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecf4038710, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecf4038710, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecf4038710, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecf4038710, com_data=0x7fed03e48da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecf4038710) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7fed03fd5700 (LWP 32446)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec88009a10, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec88009a10, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec88009a10, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec88009a10, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec88009a10, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec88009a10, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec88009a10, com_data=0x7fed03fd4da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec88009a10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7fed04c35700 (LWP 32673)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec9000cad0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec9000cad0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec9000cad0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec9000cad0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec9000cad0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec9000cad0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec9000cad0, com_data=0x7fed04c34da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec9000cad0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ec20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7fed04059700 (LWP 32674)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec980155f0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec980155f0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec980155f0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec980155f0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec980155f0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec980155f0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec980155f0, com_data=0x7fed04058da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec980155f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7800) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7fed04bb1700 (LWP 32675)):
#0  0x00007fef467a954d in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x00007fef467a4e9b in _L_lock_883 () from /lib64/libpthread.so.0
#2  0x00007fef467a4d68 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x0000000000ee48a3 in native_mutex_lock (mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_mutex.h:84
#4  my_mutex_lock (mp=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_mutex.h:182
#5  inline_mysql_mutex_lock (that=0x1e84a48 <mysql_bin_log+8>, src_file=<optimized out>, src_line=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:715
#6  0x0000000000eefc54 in MYSQL_BIN_LOG::change_stage (this=<optimized out>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9170
#7  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec94002860, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#8  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec94002860, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#9  0x0000000000823434 in ha_commit_trans (thd=0x7fec94002860, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#10 0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#11 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec94002860, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#12 0x0000000000d1c86d in mysql_parse (thd=0x7fec94002860, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#13 0x0000000000d1da95 in dispatch_command (thd=0x7fec94002860, com_data=0x7fed04bb0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#14 0x0000000000d1e944 in do_command (thd=0x7fec94002860) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#15 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#16 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5fc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#17 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#18 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7fed04647700 (LWP 32677)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecac0008c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecac0008c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecac0008c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecac0008c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecac0008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecac0008c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecac0008c0, com_data=0x7fed04646da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecac0008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7fed047d3700 (LWP 32679)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec84028510, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec84028510, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec84028510, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec84028510, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec84028510, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec84028510, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec84028510, com_data=0x7fed047d2da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec84028510) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0da50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7fed05223700 (LWP 32680)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec9002bca0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec9002bca0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec9002bca0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec9002bca0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec9002bca0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec9002bca0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec9002bca0, com_data=0x7fed05222da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec9002bca0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7fed03dc5700 (LWP 32681)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec8c0008c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec8c0008c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec8c0008c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec8c0008c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec8c0008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec8c0008c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec8c0008c0, com_data=0x7fed03dc4da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec8c0008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7fed04269700 (LWP 32682)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7feca400e300, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca400e300, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca400e300, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7feca400e300, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7feca400e300, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7feca400e300, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7feca400e300, com_data=0x7fed04268da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7feca400e300) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0e8d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7fed04b6f700 (LWP 32683)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7feca0007cb0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca0007cb0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca0007cb0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7feca0007cb0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7feca0007cb0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7feca0007cb0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7feca0007cb0, com_data=0x7fed04b6eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7feca0007cb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f610) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7fed042ed700 (LWP 32685)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7feca8012360, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca8012360, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca8012360, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7feca8012360, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7feca8012360, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7feca8012360, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7feca8012360, com_data=0x7fed042ecda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7feca8012360) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7fed0515d700 (LWP 437)):
#0  0x00007fef467a9aeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012c5c70 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fecd0b26730, mysql_socket=..., src_line=123, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fecd0ae1630, buf=0x7fecd0b26730 "v", size=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:123
#3  0x0000000000c6e8a3 in net_read_raw_loop (net=0x7fecd0b03958, count=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:672
#4  0x0000000000c6f13b in net_read_packet_header (net=0x7fecd0b03958) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:756
#5  net_read_packet (net=<optimized out>, complen=0x7fed0515ccf8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:822
#6  0x0000000000c6f3ec in my_net_read (net=0x7fecd0b03958) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:899
#7  0x0000000000c7cc8c in Protocol_classic::read_packet (this=0x7fecd0b031f8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:808
#8  0x0000000000c7ba22 in Protocol_classic::get_command (this=0x7fecd0b031f8, com_data=0x7fed0515cda0, cmd=0x7fed0515cdcc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:965
#9  0x0000000000d1e847 in do_command (thd=0x7fecd0b021a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:964
#10 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#11 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#12 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7fed0536d700 (LWP 438)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecc0028230, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc0028230, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc0028230, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecc0028230, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc0028230, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecc0028230, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc0028230, com_data=0x7fed0536cda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc0028230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7800) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7fed042ab700 (LWP 439)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecc80040e0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc80040e0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc80040e0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecc80040e0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc80040e0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecc80040e0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc80040e0, com_data=0x7fed042aada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc80040e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f610) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7fed045c3700 (LWP 440)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecac017550, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecac017550, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecac017550, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecac017550, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecac017550, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecac017550, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecac017550, com_data=0x7fed045c2da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecac017550) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5fc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7fed051e1700 (LWP 441)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecd4000b50, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd4000b50, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd4000b50, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecd4000b50, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecd4000b50, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecd4000b50, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecd4000b50, com_data=0x7fed051e0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecd4000b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f2c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7fed03bf7700 (LWP 442)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb0017370, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb0017370, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb0017370, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb0017370, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb0017370, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb0017370, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb0017370, com_data=0x7fed03bf6da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb0017370) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7fed03ecd700 (LWP 443)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecbc0192c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecbc0192c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecbc0192c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecbc0192c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecbc0192c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecbc0192c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecbc0192c0, com_data=0x7fed03eccda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecbc0192c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7fed04dc1700 (LWP 444)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecc804fce0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc804fce0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc804fce0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecc804fce0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc804fce0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecc804fce0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc804fce0, com_data=0x7fed04dc0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc804fce0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ec20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7fed05013700 (LWP 450)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecc404dd20, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc404dd20, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc404dd20, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecc404dd20, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc404dd20, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecc404dd20, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc404dd20, com_data=0x7fed05012da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc404dd20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a2a810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7fed05433700 (LWP 451)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb804dfc0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb804dfc0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb804dfc0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb804dfc0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb804dfc0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb804dfc0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb804dfc0, com_data=0x7fed05432da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb804dfc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0e8d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7fed03bb5700 (LWP 453)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb40053b0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb40053b0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb40053b0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb40053b0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb40053b0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb40053b0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb40053b0, com_data=0x7fed03bb4da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb40053b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae6310) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7fed04479700 (LWP 454)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7feccc0008c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feccc0008c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feccc0008c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7feccc0008c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7feccc0008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7feccc0008c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7feccc0008c0, com_data=0x7fed04478da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7feccc0008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7fed03aef700 (LWP 455)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecd8007790, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd8007790, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd8007790, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecd8007790, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecd8007790, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecd8007790, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecd8007790, com_data=0x7fed03aeeda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecd8007790) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cf60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7fef46bca780 (LWP 20583)):
#0  0x00007fef4524fccd in poll () from /lib64/libc.so.6
#1  0x0000000000df1319 in Mysqld_socket_listener::listen_for_connection_event (this=0x1092b110) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cc55d in connection_event_loop (this=0x107b8b10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=59, argv=0x2ad93b8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/mysqld.cc:5149
#4  0x00007fef4517e555 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c2089 in _start ()
