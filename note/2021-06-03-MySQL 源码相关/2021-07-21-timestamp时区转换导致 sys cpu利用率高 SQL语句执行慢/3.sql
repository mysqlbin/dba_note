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
#3  0x0000000001203623 in pc_sleep_if_needed (sig_count=2, next_loop_time=1627284563880) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:2690
#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3191
#5  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 69 (Thread 0x7fecf94c1700 (LWP 20598)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x1075d8e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x1075d8e8, reset_sig_count=1698) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
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
#2  os_event::wait_low (this=0x2c3a488, reset_sig_count=378) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115f98d in srv_purge_coordinator_suspend (rseg_history_len=61, slot=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2676
#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2792
#5  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 63 (Thread 0x7fed09e0b700 (LWP 20610)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a518) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a518, reset_sig_count=1527) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 62 (Thread 0x7fed0960a700 (LWP 20611)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a5a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a5a8, reset_sig_count=1462) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 61 (Thread 0x7fed08e09700 (LWP 20612)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a638) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a638, reset_sig_count=1359) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
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
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x10761238, time_in_usec=<optimized out>, reset_sig_count=110) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
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
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed05050508: 0x7fef328b5728) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed05051810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fecb4024d38, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed05052320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed05051810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed05051810, line=2502, cursor=0x7fed05052320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fecb4024d38, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fecb4024d38, n_ext=0, thr=0x7fecb4024430, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fecb4024d38, thr=0x7fecb4024430, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fecb4024430) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fecb4024128, thr=0x7fecb4024430) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fecb4024430, node=0x7fecb4024128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fecb4024430) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed05052f40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fecb4022eb0, record=0x7fecb40232c0 "|\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fecb4022eb0, buf=0x7fecb40232c0 "|\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecdc065ba0, table=0x7fecb40045b0, info=0x7fed050534a0, update=0x7fed05053420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecdc07bea8, thd=0x7fecdc065ba0, table_list=0x7fecdc07b5e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecdc07bea8, thd=0x7fecdc065ba0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecdc065ba0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecdc065ba0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecdc065ba0, com_data=0x7fed05054da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecdc065ba0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10b44df0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 51 (Thread 0x7fed03d83700 (LWP 26305)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec6c04ab40, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c04ab40, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c04ab40, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec6c04ab40, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec6c04ab40, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec6c04ab40, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec6c04ab40, com_data=0x7fed03d82da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec6c04ab40) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0cd70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 50 (Thread 0x7fed04bf3700 (LWP 26620)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb001b3a0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb001b3a0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb001b3a0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb001b3a0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb001b3a0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb001b3a0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb001b3a0, com_data=0x7fed04bf2da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb001b3a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 49 (Thread 0x7fed03e8b700 (LWP 26627)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec74049230, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec74049230, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec74049230, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec74049230, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec74049230, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec74049230, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec74049230, com_data=0x7fed03e8ada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec74049230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 48 (Thread 0x7fed04581700 (LWP 26630)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed0457c508: 0x7fef328b52a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed0457d810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fecd0b18038, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed0457e320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed0457d810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed0457d810, line=2502, cursor=0x7fed0457e320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fecd0b18038, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fecd0b18038, n_ext=0, thr=0x7fecd0b1d030, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fecd0b18038, thr=0x7fecd0b1d030, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fecd0b1d030) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fecd0b1cd28, thr=0x7fecd0b1d030) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fecd0b1d030, node=0x7fecd0b1cd28) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fecd0b1d030) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed0457ef40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fecd0b11270, record=0x7fecd0b11680 "y\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fecd0b11270, buf=0x7fecd0b11680 "y\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fec8c0008c0, table=0x7fecd0b10880, info=0x7fed0457f4a0, update=0x7fed0457f420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fec8c013b98, thd=0x7fec8c0008c0, table_list=0x7fec8c0132d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fec8c013b98, thd=0x7fec8c0008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fec8c0008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fec8c0008c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fec8c0008c0, com_data=0x7fed04580da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fec8c0008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a57250) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 47 (Thread 0x7fed05097700 (LWP 26655)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed05092508: 0x7fef328b5928) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed05093810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fec74009b08, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed05094320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed05093810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed05093810, line=2502, cursor=0x7fed05094320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fec74009b08, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fec74009b08, n_ext=0, thr=0x7fec74009310, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fec74009b08, thr=0x7fec74009310, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fec74009310) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fec74009008, thr=0x7fec74009310) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fec74009310, node=0x7fec74009008) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fec74009310) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed05094f40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fec740578f0, record=0x7fec74057d00 "z\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fec740578f0, buf=0x7fec74057d00 "z\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecc402c8b0, table=0x7fec74016bf0, info=0x7fed050954a0, update=0x7fed05095420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecc4038d68, thd=0x7fecc402c8b0, table_list=0x7fecc40384a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecc4038d68, thd=0x7fecc402c8b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecc402c8b0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecc402c8b0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecc402c8b0, com_data=0x7fed05096da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecc402c8b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0b290) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 46 (Thread 0x7fed04f8f700 (LWP 30744)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec6c01ebc0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c01ebc0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c01ebc0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec6c01ebc0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec6c01ebc0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec6c01ebc0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec6c01ebc0, com_data=0x7fed04f8eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec6c01ebc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a2a810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 45 (Thread 0x7fed04227700 (LWP 30748)):
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
Thread 44 (Thread 0x7fed04b2d700 (LWP 30761)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7feca40162c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca40162c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca40162c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7feca40162c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7feca40162c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7feca40162c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7feca40162c0, com_data=0x7fed04b2cda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7feca40162c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cf60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 43 (Thread 0x7fed0453f700 (LWP 30765)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec94002860, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec94002860, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec94002860, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec94002860, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec94002860, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec94002860, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec94002860, com_data=0x7fed0453eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec94002860) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f610) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 42 (Thread 0x7fed0432f700 (LWP 30769)):
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
Thread 41 (Thread 0x7fed046cb700 (LWP 30776)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed046c6508: 0x7fef328b5628) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed046c7810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fecb8015ef8, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed046c8320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed046c7810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed046c7810, line=2502, cursor=0x7fed046c8320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fecb8015ef8, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fecb8015ef8, n_ext=0, thr=0x7fecb8015230, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fecb8015ef8, thr=0x7fecb8015230, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fecb8015230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fecb8014f28, thr=0x7fecb8015230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fecb8015230, node=0x7fecb8014f28) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fecb8015230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed046c8f40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fecb8037c30, record=0x7fecb8038040 "}\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fecb8037c30, buf=0x7fecb8038040 "}\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecb8028b10, table=0x7fecb8037240, info=0x7fed046c94a0, update=0x7fed046c9420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecb8035aa8, thd=0x7fecb8028b10, table_list=0x7fecb80351e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecb8035aa8, thd=0x7fecb8028b10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecb8028b10, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecb8028b10, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecb8028b10, com_data=0x7fed046cada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecb8028b10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10b45870) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7fed048db700 (LWP 30780)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed048d6508: 0x7fef328b55e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed048d7810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fecb002bfa8, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed048d8320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed048d7810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed048d7810, line=2502, cursor=0x7fed048d8320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fecb002bfa8, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fecb002bfa8, n_ext=0, thr=0x7fecb002b430, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fecb002bfa8, thr=0x7fecb002b430, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fecb002b430) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fecb002b128, thr=0x7fecb002b430) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fecb002b430, node=0x7fecb002b128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fecb002b430) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed048d8f40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fecb00067a0, record=0x7fecb0006bb0 "~\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fecb00067a0, buf=0x7fecb0006bb0 "~\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecbc015af0, table=0x7fecb0005df0, info=0x7fed048d94a0, update=0x7fed048d9420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecbc01bbc8, thd=0x7fecbc015af0, table_list=0x7fecbc01b300) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecbc01bbc8, thd=0x7fecbc015af0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecbc015af0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecbc015af0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecbc015af0, com_data=0x7fed048dada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecbc015af0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0d0f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 39 (Thread 0x7fed03d41700 (LWP 30787)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed03d3c508: 0x7fef328b53a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed03d3d810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fecc40685d8, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed03d3e320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed03d3d810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed03d3d810, line=2502, cursor=0x7fed03d3e320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fecc40685d8, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fecc40685d8, n_ext=0, thr=0x7fecc4067960, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fecc40685d8, thr=0x7fecc4067960, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fecc4067960) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fecc4067658, thr=0x7fecc4067960) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fecc4067960, node=0x7fecc4067658) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fecc4067960) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed03d3ef40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fecc403bdb0, record=0x7fecc402b260 "w\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fecc403bdb0, buf=0x7fecc402b260 "w\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecc401c360, table=0x7fecc402a8b0, info=0x7fed03d3f4a0, update=0x7fed03d3f420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecc400a828, thd=0x7fecc401c360, table_list=0x7fecc4009f60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecc400a828, thd=0x7fecc401c360) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecc401c360, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecc401c360, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecc401c360, com_data=0x7fed03d40da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecc401c360) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0a810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 38 (Thread 0x7fed04e87700 (LWP 30788)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed04e82508: 0x7fef328b5568) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed04e83810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fecc0012948, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed04e84320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed04e83810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed04e83810, line=2502, cursor=0x7fed04e84320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fecc0012948, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fecc0012948, n_ext=0, thr=0x7fecc0011dd0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fecc0012948, thr=0x7fecc0011dd0, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fecc0011dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fecc0011ac8, thr=0x7fecc0011dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fecc0011dd0, node=0x7fecc0011ac8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fecc0011dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed04e84f40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fecc003ce70, record=0x7fecc0006f00 "s\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fecc003ce70, buf=0x7fecc0006f00 "s\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecd0b01700, table=0x7fecc003c4c0, info=0x7fed04e854a0, update=0x7fed04e85420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecd0ada8a8, thd=0x7fecd0b01700, table_list=0x7fecd0ad9fe0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecd0ada8a8, thd=0x7fecd0b01700) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecd0b01700, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecd0b01700, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecd0b01700, com_data=0x7fed04e86da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecd0b01700) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0a490) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7fed03c39700 (LWP 30791)):
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
Thread 36 (Thread 0x7fed04017700 (LWP 30794)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecd0af2070, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd0af2070, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecd0af2070, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecd0af2070, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecd0af2070, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecd0af2070, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecd0af2070, com_data=0x7fed04016da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecd0af2070) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a09d90) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7fed0519f700 (LWP 30798)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed0519a508: 0x7fef328b5128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed0519b810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fece80212a8, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed0519c320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed0519b810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed0519b810, line=2502, cursor=0x7fed0519c320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fece80212a8, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fece80212a8, n_ext=0, thr=0x7fece80205e0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fece80212a8, thr=0x7fece80205e0, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fece80205e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fece80202d8, thr=0x7fece80205e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fece80205e0, node=0x7fece80202d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fece80205e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed0519cf40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fece800a1b0, record=0x7fece800a5c0 "{\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fece800a1b0, buf=0x7fece800a5c0 "{\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecc4000910, table=0x7fece8057460, info=0x7fed0519d4a0, update=0x7fed0519d420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecc4029178, thd=0x7fecc4000910, table_list=0x7fecc40288b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecc4029178, thd=0x7fecc4000910) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecc4000910, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecc4000910, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecc4000910, com_data=0x7fed0519eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecc4000910) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c05720) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7fed04aa9700 (LWP 32358)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed04aa4508: 0x7fef328b5b68) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed04aa5810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x10bde4a8, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed04aa6320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed04aa5810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed04aa5810, line=2502, cursor=0x7fed04aa6320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x10bde4a8, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x10bde4a8, n_ext=0, thr=0x10bdda90, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x10bde4a8, thr=0x10bdda90, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x10bdda90) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x10bdd788, thr=0x10bdda90) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x10bdda90, node=0x10bdd788) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x10bdda90) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed04aa6f40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x10a0c0a0, record=0x10bb13e0 "\200\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x10a0c0a0, buf=0x10bb13e0 "\200\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x10a00100, table=0x10bb0a30, info=0x7fed04aa74a0, update=0x7fed04aa7420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x10bc5618, thd=0x10a00100, table_list=0x10bc4d50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x10bc5618, thd=0x10a00100) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x10a00100, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x10a00100, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x10a00100, com_data=0x7fed04aa8da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x10a00100) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7800) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7fed03b73700 (LWP 32365)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fece8047c10, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece8047c10, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece8047c10, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fece8047c10, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fece8047c10, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fece8047c10, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fece8047c10, com_data=0x7fed03b72da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fece8047c10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5920) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7fed03e49700 (LWP 32366)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed03e44508: 0x7fef328b5c68) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed03e45810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fecf403cfe8, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed03e46320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed03e45810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed03e45810, line=2502, cursor=0x7fed03e46320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fecf403cfe8, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fecf403cfe8, n_ext=0, thr=0x7fecd003d070, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fecf403cfe8, thr=0x7fecd003d070, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fecd003d070) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fecd003cd68, thr=0x7fecd003d070) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fecd003d070, node=0x7fecd003cd68) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fecd003d070) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed03e46f40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fecd0038130, record=0x7fecd0038540 "x\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fecd0038130, buf=0x7fecd0038540 "x\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecf4027230, table=0x7fecd0b138d0, info=0x7fed03e474a0, update=0x7fed03e47420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecf4022388, thd=0x7fecf4027230, table_list=0x7fecf4021ac0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecf4022388, thd=0x7fecf4027230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecf4027230, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecf4027230, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecf4027230, com_data=0x7fed03e48da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecf4027230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7fed04c35700 (LWP 32673)):
#0  0x00007fef467a9aeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012c5c70 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fec900079d0, mysql_socket=..., src_line=123, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fec900108b0, buf=0x7fec900079d0 "\a", size=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:123
#3  0x0000000000c6e8a3 in net_read_raw_loop (net=0x7fec90038398, count=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:672
#4  0x0000000000c6f13b in net_read_packet_header (net=0x7fec90038398) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:756
#5  net_read_packet (net=<optimized out>, complen=0x7fed04c34cf8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:822
#6  0x0000000000c6f3ec in my_net_read (net=0x7fec90038398) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:899
#7  0x0000000000c7cc8c in Protocol_classic::read_packet (this=0x7fec90037c38) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:808
#8  0x0000000000c7ba22 in Protocol_classic::get_command (this=0x7fec90037c38, com_data=0x7fed04c34da0, cmd=0x7fed04c34dcc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:965
#9  0x0000000000d1e847 in do_command (thd=0x7fec90036be0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:964
#10 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#11 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ec20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#12 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7fed04bb1700 (LWP 32675)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed04bac508: 0x7fef328b5aa8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed04bad810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fec94001ec8, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed04bae320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed04bad810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed04bad810, line=2502, cursor=0x7fed04bae320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fec94001ec8, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fec94001ec8, n_ext=0, thr=0x7fec940255f0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fec94001ec8, thr=0x7fec940255f0, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fec940255f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fec940252e8, thr=0x7fec940255f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fec940255f0, node=0x7fec940252e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fec940255f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed04baef40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fec94006d50, record=0x7fec94058e20 "\177\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fec94006d50, buf=0x7fec94058e20 "\177\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fec9400b460, table=0x7fec9405dbe0, info=0x7fed04baf4a0, update=0x7fed04baf420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fec9401d508, thd=0x7fec9400b460, table_list=0x7fec9401cc40) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fec9401d508, thd=0x7fec9400b460) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fec9400b460, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fec9400b460, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fec9400b460, com_data=0x7fed04bb0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fec9400b460) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5fc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7fed04647700 (LWP 32677)):
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
Thread 28 (Thread 0x7fed047d3700 (LWP 32679)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed047ce508: 0x7fef328b52e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed047cf810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fecdc05f348, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed047d0320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed047cf810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed047cf810, line=2502, cursor=0x7fed047d0320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fecdc05f348, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fecdc05f348, n_ext=0, thr=0x7fecdc074d80, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fecdc05f348, thr=0x7fecdc074d80, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fecdc074d80) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fecdc074a78, thr=0x7fecdc074d80) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fecdc074d80, node=0x7fecdc074a78) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fecdc074d80) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed047d0f40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fecdc00faf0, record=0x7fecdc07fff0 "v\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fecdc00faf0, buf=0x7fecdc07fff0 "v\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fec84028510, table=0x7fecdc07f640, info=0x7fed047d14a0, update=0x7fed047d1420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fec84005258, thd=0x7fec84028510, table_list=0x7fec84004990) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fec84005258, thd=0x7fec84028510) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fec84028510, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fec84028510, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fec84028510, com_data=0x7fed047d2da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fec84028510) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0da50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7fed05223700 (LWP 32680)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec90027c70, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec90027c70, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec90027c70, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec90027c70, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec90027c70, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec90027c70, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec90027c70, com_data=0x7fed05222da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec90027c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7fed03dc5700 (LWP 32681)):
#0  0x00007fef467a9aeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012c5c70 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fec8c01c8e0, mysql_socket=..., src_line=123, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fec8c051010, buf=0x7fec8c01c8e0 "v", size=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:123
#3  0x0000000000c6e8a3 in net_read_raw_loop (net=0x7fec8c018a88, count=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:672
#4  0x0000000000c6f13b in net_read_packet_header (net=0x7fec8c018a88) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:756
#5  net_read_packet (net=<optimized out>, complen=0x7fed03dc4cf8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:822
#6  0x0000000000c6f3ec in my_net_read (net=0x7fec8c018a88) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:899
#7  0x0000000000c7cc8c in Protocol_classic::read_packet (this=0x7fec8c018328) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:808
#8  0x0000000000c7ba22 in Protocol_classic::get_command (this=0x7fec8c018328, com_data=0x7fed03dc4da0, cmd=0x7fed03dc4dcc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:965
#9  0x0000000000d1e847 in do_command (thd=0x7fec8c0172d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:964
#10 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#11 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#12 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7fed04269700 (LWP 32682)):
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
Thread 24 (Thread 0x7fed0515d700 (LWP 437)):
#0  0x00007fef467a9c5b in send () from /lib64/libpthread.so.0
#1  0x00000000012c5b4d in inline_mysql_socket_send (flags=64, n=14, buf=0x7fecd0ad4020, mysql_socket=..., src_line=201, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:766
#2  vio_write (vio=0x7fecd0b13400, buf=0x7fecd0ad4020 "\n", size=14) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:201
#3  0x0000000000c6ea2a in net_write_raw_loop (count=14, buf=0x7fecd0ad4020 "\n", net=0x7fecd0ad01c8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:500
#4  net_write_packet (net=0x7fecd0ad01c8, packet=0x7fecd0ad4020 "\n", length=14) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:639
#5  0x0000000000c6ed73 in net_flush (net=0x7fecd0ad01c8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:222
#6  0x0000000000c7d718 in net_send_ok (thd=0x7fecd0acea10, server_status=2, statement_warn_count=0, affected_rows=140655090015744, id=<optimized out>, message=0x7fecd0ad1688 "", eof_identifier=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:369
#7  0x0000000000c7d778 in Protocol_classic::send_ok (this=<optimized out>, server_status=<optimized out>, statement_warn_count=<optimized out>, affected_rows=<optimized out>, last_insert_id=<optimized out>, message=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:643
#8  0x0000000000ccfa4f in THD::send_statement_status (this=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_class.cc:4731
#9  0x0000000000d1cbc5 in dispatch_command (thd=0x7fecd0acea10, com_data=0x7fed0515cda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1901
#10 0x0000000000d1e944 in do_command (thd=0x7fecd0acea10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#11 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7fed042ab700 (LWP 439)):
#0  0x00007fef467a9d7d in fsync () from /lib64/libpthread.so.0
#1  0x00000000010bdf74 in os_file_fsync_posix (file=10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:3073
#2  os_file_flush_func (file=10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:3177
#3  0x00000000012545b3 in pfs_os_file_flush_func (src_line=6035, file=..., src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/os0file.ic:505
#4  fil_flush (space_id=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:6035
#5  0x000000000109cf82 in log_write_flush_to_disk_low () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/log/log0log.cc:1156
#6  0x000000000109e0b9 in log_write_up_to (lsn=<optimized out>, flush_to_disk=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/log/log0log.cc:1406
#7  0x0000000001038bc6 in innobase_flush_logs (hton=<optimized out>, binlog_group_flush=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:4241
#8  0x0000000000d3b030 in plugin_foreach_with_mask (thd=0x0, funcs=0x7fed042a8390, type=<optimized out>, state_mask=4294967287, arg=0x7fed042a83bc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_plugin.cc:2517
#9  0x0000000000d3b14d in plugin_foreach_with_mask (thd=<optimized out>, func=<optimized out>, type=<optimized out>, state_mask=<optimized out>, arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_plugin.cc:2532
#10 0x0000000000818fa2 in ha_flush_logs (db_type=<optimized out>, binlog_group_flush=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:2491
#11 0x0000000000ef406b in MYSQL_BIN_LOG::process_flush_stage_queue (this=<optimized out>, total_bytes_var=0x7fed042a8490, rotate_var=0x7fed042a849f, out_queue_var=0x7fed042a8488) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8951
#12 0x0000000000ef453e in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc80040e0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9595
#13 0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc80040e0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#14 0x0000000000823434 in ha_commit_trans (thd=0x7fecc80040e0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#15 0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#16 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc80040e0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#17 0x0000000000d1c86d in mysql_parse (thd=0x7fecc80040e0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#18 0x0000000000d1da95 in dispatch_command (thd=0x7fecc80040e0, com_data=0x7fed042aada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#19 0x0000000000d1e944 in do_command (thd=0x7fecc80040e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#20 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f610) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#22 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7fed045c3700 (LWP 440)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecac02ca80, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecac02ca80, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecac02ca80, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecac02ca80, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecac02ca80, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecac02ca80, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecac02ca80, com_data=0x7fed045c2da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecac02ca80) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5fc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7fed051e1700 (LWP 441)):
#0  MYSQLparse (YYTHD=0x7fecd40008c0) at /export/home2/pb2/build/sb_2-33647514-1555162505.73/dist_GPL/sql/sql_yacc.cc:39697
#1  0x0000000000d1344a in parse_sql (thd=0x7fecd40008c0, parser_state=0x7fed051e09f0, creation_ctx=0x0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:7116
#2  0x0000000000d1c61d in mysql_parse (thd=0x7fecd40008c0, parser_state=0x7fed051e09f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5457
#3  0x0000000000d1da95 in dispatch_command (thd=0x7fecd40008c0, com_data=0x7fed051e0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#4  0x0000000000d1e944 in do_command (thd=0x7fecd40008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#5  0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f2c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7fed03bf7700 (LWP 442)):
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
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb0011ff0, com_data=0x7fed03bf6da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb0011ff0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7fed03ecd700 (LWP 443)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xa421128) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xa421128, reset_sig_count=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x2c23238, cell=@0x7fed03ec8508: 0x7fef328b51a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7fee131a10d8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2502, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7fee131a10d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=10, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed03ec9810, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7fecd003a4b8, level=0, tuple=0x7fec9c010f58, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7fed03eca320, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2502, mtr=0x7fed03ec9810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x00000000010ff80f in btr_pcur_open_low (mtr=0x7fed03ec9810, line=2502, cursor=0x7fed03eca320, latch_mode=2, mode=PAGE_CUR_LE, tuple=0x7fec9c010f58, index=0x7fecd003a4b8, level=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#9  row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7fecd003a4b8, n_uniq=1, entry=0x7fec9c010f58, n_ext=0, thr=0x7fec9c01cb30, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2502
#10 0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fec9c010f58, thr=0x7fec9c01cb30, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#11 0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fec9c01cb30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#12 row_ins_index_entry_step (node=0x7fec9c01c828, thr=0x7fec9c01cb30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#13 row_ins (thr=0x7fec9c01cb30, node=0x7fec9c01c828) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#14 row_ins_step (thr=0x7fec9c01cb30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#15 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed03ecaf40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#16 0x000000000104e744 in ha_innobase::write_row (this=0x7fec9c00fe00, record=0x7fec9c010210 "u\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#17 0x000000000081fe7b in handler::ha_write_row (this=0x7fec9c00fe00, buf=0x7fec9c010210 "u\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#18 0x0000000000ea0427 in write_record (thd=0x7fecbc007fe0, table=0x7fec9c013320, info=0x7fed03ecb4a0, update=0x7fed03ecb420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#19 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecbc019bb8, thd=0x7fecbc007fe0, table_list=0x7fecbc0192f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#20 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecbc019bb8, thd=0x7fecbc007fe0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#21 0x0000000000d1835c in mysql_execute_command (thd=0x7fecbc007fe0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#22 0x0000000000d1c86d in mysql_parse (thd=0x7fecbc007fe0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#23 0x0000000000d1da95 in dispatch_command (thd=0x7fecbc007fe0, com_data=0x7fed03eccda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#24 0x0000000000d1e944 in do_command (thd=0x7fecbc007fe0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#25 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#26 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#27 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#28 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7fed05433700 (LWP 451)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecb80180c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb80180c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecb80180c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecb80180c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecb80180c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecb80180c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb80180c0, com_data=0x7fed05432da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb80180c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0e8d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7fed03bb5700 (LWP 453)):
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
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecb4017850, com_data=0x7fed03bb4da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecb4017850) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae6310) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7fed04479700 (LWP 454)):
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
Thread 15 (Thread 0x7fed03aef700 (LWP 455)):
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
Thread 14 (Thread 0x7fed03b31700 (LWP 676)):
#0  allocate (throw_on_error=false, set_to_zero=false, file=0x16154b8 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/mem/mem0mem.cc", hint=0x0, n_elements=248, this=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/ut0new.h:327
#1  mem_heap_create_block_func (heap=0x0, n=136, type=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/mem/mem0mem.cc:302
#2  0x00000000011c4a4c in mem_heap_create_func (size=<optimized out>, type=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mem0mem.ic:493
#3  0x00000000011ca8b1 in page_cur_tuple_insert (cursor=0x7fed03b2e328, tuple=0x7fec6c011ee8, index=<optimized out>, offsets=0x7fed03b2e428, heap=0x7fed03b2e430, n_ext=<optimized out>, mtr=0x7fed03b2d810, use_cache=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/page0cur.ic:267
#4  0x00000000011cd4f3 in btr_cur_optimistic_insert (flags=0, cursor=0x7fed03b2e320, offsets=0x7fed03b2e428, heap=0x7fed03b2e430, entry=<optimized out>, rec=0x7fed03b2e420, big_rec=0x7fed03b2e438, n_ext=0, thr=0x7fec6c00bf50, mtr=0x7fed03b2d810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:3218
#5  0x00000000010ff8a0 in row_ins_clust_index_entry_low (flags=0, mode=<optimized out>, index=0x7fecd003a4b8, n_uniq=<optimized out>, entry=0x7fec6c011ee8, n_ext=0, thr=0x7fec6c00bf50, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2607
#6  0x0000000001105828 in row_ins_clust_index_entry (index=0x7fecd003a4b8, entry=0x7fec6c011ee8, thr=0x7fec6c00bf50, n_ext=0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3293
#7  0x0000000001105c0f in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7fec6c00bf50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3429
#8  row_ins_index_entry_step (node=0x7fec6c00bc48, thr=0x7fec6c00bf50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#9  row_ins (thr=0x7fec6c00bf50, node=0x7fec6c00bc48) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#10 row_ins_step (thr=0x7fec6c00bf50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#11 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7fed03b2ef40 "", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#12 0x000000000104e744 in ha_innobase::write_row (this=0x7fec6c022c40, record=0x7fec6c02c270 "t\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#13 0x000000000081fe7b in handler::ha_write_row (this=0x7fec6c022c40, buf=0x7fec6c02c270 "t\262\003") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#14 0x0000000000ea0427 in write_record (thd=0x7fec7da5dc30, table=0x7fec6c02b8c0, info=0x7fed03b2f4a0, update=0x7fed03b2f420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#15 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fec7c0051e8, thd=0x7fec7da5dc30, table_list=0x7fec7c004920) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#16 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fec7c0051e8, thd=0x7fec7da5dc30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#17 0x0000000000d1835c in mysql_execute_command (thd=0x7fec7da5dc30, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#18 0x0000000000d1c86d in mysql_parse (thd=0x7fec7da5dc30, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#19 0x0000000000d1da95 in dispatch_command (thd=0x7fec7da5dc30, com_data=0x7fed03b30da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#20 0x0000000000d1e944 in do_command (thd=0x7fec7da5dc30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#21 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ec20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#23 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7fed04dc1700 (LWP 677)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fece0000f90, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece0000f90, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece0000f90, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fece0000f90, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fece0000f90, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fece0000f90, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fece0000f90, com_data=0x7fed04dc0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fece0000f90) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a2a810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7fed03f51700 (LWP 678)):
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
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc0028230, com_data=0x7fed03f50da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc0028230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7fed04c77700 (LWP 679)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7feca00238c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca00238c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7feca00238c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7feca00238c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7feca00238c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7feca00238c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7feca00238c0, com_data=0x7fed04c76da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7feca00238c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7fed0536d700 (LWP 680)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecec016d10, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecec016d10, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecec016d10, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecec016d10, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecec016d10, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecec016d10, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecec016d10, com_data=0x7fed0536cda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecec016d10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cf60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7fed05013700 (LWP 681)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecdc009fc0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecdc009fc0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecdc009fc0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecdc009fc0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecdc009fc0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecdc009fc0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecdc009fc0, com_data=0x7fed05012da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecdc009fc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f2c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7fed04899700 (LWP 682)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fece80121e0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece80121e0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece80121e0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fece80121e0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fece80121e0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fece80121e0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fece80121e0, com_data=0x7fed04898da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fece80121e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a2a260) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7fed049a1700 (LWP 683)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fece400a1e0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece400a1e0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fece400a1e0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fece400a1e0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fece400a1e0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fece400a1e0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fece400a1e0, com_data=0x7fed049a0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fece400a1e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0da50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7fed042ed700 (LWP 684)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecf4032890, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecf4032890, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecf4032890, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecf4032890, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecf4032890, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecf4032890, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecf4032890, com_data=0x7fed042ecda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecf4032890) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10b7ddb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7fed03fd5700 (LWP 685)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x10b400c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x10b400c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x10b400c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x10b400c0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x10b400c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x10b400c0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x10b400c0, com_data=0x7fed03fd4da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x10b400c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7fed04059700 (LWP 686)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec7404f860, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec7404f860, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec7404f860, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec7404f860, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec7404f860, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec7404f860, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec7404f860, com_data=0x7fed04058da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec7404f860) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5920) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7fed04b6f700 (LWP 687)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fec6c02d730, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c02d730, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fec6c02d730, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fec6c02d730, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fec6c02d730, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fec6c02d730, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fec6c02d730, com_data=0x7fed04b6eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fec6c02d730) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7800) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7fed0511b700 (LWP 688)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7fecc000b9e0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc000b9e0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7fecc000b9e0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7fecc000b9e0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd35d6 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:458
#10 0x0000000000d17c5f in mysql_execute_command (thd=0x7fecc000b9e0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4985
#11 0x0000000000d1c86d in mysql_parse (thd=0x7fecc000b9e0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#12 0x0000000000d1da95 in dispatch_command (thd=0x7fecc000b9e0, com_data=0x7fed0511ada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#13 0x0000000000d1e944 in do_command (thd=0x7fecc000b9e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f610) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7fef46bca780 (LWP 20583)):
#0  0x00007fef4524fccd in poll () from /lib64/libc.so.6
#1  0x0000000000df1319 in Mysqld_socket_listener::listen_for_connection_event (this=0x1092b110) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cc55d in connection_event_loop (this=0x107b8b10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=59, argv=0x2ad93b8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/mysqld.cc:5149
#4  0x00007fef4517e555 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c2089 in _start ()
