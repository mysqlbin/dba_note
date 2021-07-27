Thread 70 (Thread 0x7fef3d317700 (LWP 20584)):
#0  0x00007fef4519358a in sigwaitinfo () from /lib64/libc.so.6
#1  0x0000000000f56eab in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/mysys/posix_timers.c:77
#2  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2bfb0f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#3  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 69 (Thread 0x7fecfeccc700 (LWP 20587)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfeccbdd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfeccbdd0, m1=0x7fecfeccbe88, m2=0x7fecfeccbe80, request=0x7fecfeccbe50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfeccbe50, m2=0x7fecfeccbe80, m1=0x7fecfeccbe88, global_segment=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=0, m1=0x7fecfeccbe88, m2=0x7fecfeccbe80, request=0x7fecfeccbe50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 68 (Thread 0x7fecfe4cb700 (LWP 20588)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfe4cadd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfe4cadd0, m1=0x7fecfe4cae88, m2=0x7fecfe4cae80, request=0x7fecfe4cae50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfe4cae50, m2=0x7fecfe4cae80, m1=0x7fecfe4cae88, global_segment=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=1, m1=0x7fecfe4cae88, m2=0x7fecfe4cae80, request=0x7fecfe4cae50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 67 (Thread 0x7fecfdcca700 (LWP 20589)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfdcc9dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfdcc9dd0, m1=0x7fecfdcc9e88, m2=0x7fecfdcc9e80, request=0x7fecfdcc9e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfdcc9e50, m2=0x7fecfdcc9e80, m1=0x7fecfdcc9e88, global_segment=2) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=2, m1=0x7fecfdcc9e88, m2=0x7fecfdcc9e80, request=0x7fecfdcc9e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 66 (Thread 0x7fecfd4c9700 (LWP 20590)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfd4c8dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfd4c8dd0, m1=0x7fecfd4c8e88, m2=0x7fecfd4c8e80, request=0x7fecfd4c8e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfd4c8e50, m2=0x7fecfd4c8e80, m1=0x7fecfd4c8e88, global_segment=3) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=3, m1=0x7fecfd4c8e88, m2=0x7fecfd4c8e80, request=0x7fecfd4c8e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 65 (Thread 0x7fecfccc8700 (LWP 20591)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfccc7dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfccc7dd0, m1=0x7fecfccc7e88, m2=0x7fecfccc7e80, request=0x7fecfccc7e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfccc7e50, m2=0x7fecfccc7e80, m1=0x7fecfccc7e88, global_segment=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=4, m1=0x7fecfccc7e88, m2=0x7fecfccc7e80, request=0x7fecfccc7e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 64 (Thread 0x7fecfc4c7700 (LWP 20592)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfc4c6dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfc4c6dd0, m1=0x7fecfc4c6e88, m2=0x7fecfc4c6e80, request=0x7fecfc4c6e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfc4c6e50, m2=0x7fecfc4c6e80, m1=0x7fecfc4c6e88, global_segment=5) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=5, m1=0x7fecfc4c6e88, m2=0x7fecfc4c6e80, request=0x7fecfc4c6e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 63 (Thread 0x7fecfbcc6700 (LWP 20593)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfbcc5dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfbcc5dd0, m1=0x7fecfbcc5e88, m2=0x7fecfbcc5e80, request=0x7fecfbcc5e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfbcc5e50, m2=0x7fecfbcc5e80, m1=0x7fecfbcc5e88, global_segment=6) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=6, m1=0x7fecfbcc5e88, m2=0x7fecfbcc5e80, request=0x7fecfbcc5e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 62 (Thread 0x7fecfb4c5700 (LWP 20594)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfb4c4dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfb4c4dd0, m1=0x7fecfb4c4e88, m2=0x7fecfb4c4e80, request=0x7fecfb4c4e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfb4c4e50, m2=0x7fecfb4c4e80, m1=0x7fecfb4c4e88, global_segment=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=7, m1=0x7fecfb4c4e88, m2=0x7fecfb4c4e80, request=0x7fecfb4c4e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 61 (Thread 0x7fecfacc4700 (LWP 20595)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfacc3dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfacc3dd0, m1=0x7fecfacc3e88, m2=0x7fecfacc3e80, request=0x7fecfacc3e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfacc3e50, m2=0x7fecfacc3e80, m1=0x7fecfacc3e88, global_segment=8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=8, m1=0x7fecfacc3e88, m2=0x7fecfacc3e80, request=0x7fecfacc3e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 60 (Thread 0x7fecfa4c3700 (LWP 20596)):
#0  0x00007fef46599644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7fecfa4c2dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7fecfa4c2dd0, m1=0x7fecfa4c2e88, m2=0x7fecfa4c2e80, request=0x7fecfa4c2e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7fecfa4c2e50, m2=0x7fecfa4c2e80, m1=0x7fecfa4c2e88, global_segment=9) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=9, m1=0x7fecfa4c2e88, m2=0x7fecfa4c2e80, request=0x7fecfa4c2e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 59 (Thread 0x7fecf9cc2700 (LWP 20597)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fecf9cc19a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x2c3a878, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000001203623 in pc_sleep_if_needed (sig_count=2, next_loop_time=1627372420728) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:2690
#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3191
#5  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 58 (Thread 0x7fecf94c1700 (LWP 20598)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x1075d8e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x1075d8e8, reset_sig_count=5732) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000001204ed7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3496
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 57 (Thread 0x7fecf8a9a700 (LWP 20605)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fecf8a99db0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x1075baf8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000109a924 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/lock/lock0wait.cc:501
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 56 (Thread 0x7fed0be0f700 (LWP 20606)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fed0be0eac0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x2c3a6c8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000115e8f5 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:1751
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 55 (Thread 0x7fed0b60e700 (LWP 20607)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fed0b60de30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x2c3a758, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000115d985 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:1585
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 54 (Thread 0x7fed0ae0d700 (LWP 20608)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x000000000115dfab in srv_master_sleep () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 53 (Thread 0x7fed0a60c700 (LWP 20609)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a488) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a488, reset_sig_count=668) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115f98d in srv_purge_coordinator_suspend (rseg_history_len=16, slot=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2676
#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2792
#5  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 52 (Thread 0x7fed09e0b700 (LWP 20610)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a518) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a518, reset_sig_count=2757) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 51 (Thread 0x7fed0960a700 (LWP 20611)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a5a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a5a8, reset_sig_count=2617) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 50 (Thread 0x7fed08e09700 (LWP 20612)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a638) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a638, reset_sig_count=2512) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 49 (Thread 0x7fed08608700 (LWP 20613)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a7e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a7e8, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x00000000011fcecc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0dump.cc:782
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 48 (Thread 0x7fed07e07700 (LWP 20614)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fed07e06dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x10761238, time_in_usec=<optimized out>, reset_sig_count=362) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000001246297 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/dict/dict0stats_bg.cc:428
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 47 (Thread 0x7fed07606700 (LWP 20615)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7fed07605ab0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x10912108, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x00000000011af7f4 in ib_wqueue_timedwait (wq=0x10912008, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/ut/ut0wqueue.cc:160
#4  0x000000000128f042 in fts_optimize_thread (arg=0x10912008) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fts/fts0opt.cc:2900
#5  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 46 (Thread 0x7fed06e05700 (LWP 20616)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2c3a908) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2c3a908, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x00000000011f337c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:3019
#4  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 45 (Thread 0x7fed05d3c700 (LWP 20620)):
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
Thread 44 (Thread 0x7fed05cb8700 (LWP 20621)):
#0  0x00007fef467aa3c1 in sigwait () from /lib64/libpthread.so.0
#1  0x00000000007c70bb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/mysqld.cc:2125
#2  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10966ab0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#3  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 43 (Thread 0x7fed05c76700 (LWP 20622)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ec1e35 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=879, src_file=0x15e7fa0 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/rpl_gtid_persist.cc:879
#5  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a57250) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#6  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 42 (Thread 0x7fed03e8b700 (LWP 26627)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 41 (Thread 0x7fed04581700 (LWP 26630)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a57250) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7fed04227700 (LWP 30748)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
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
Thread 38 (Thread 0x7fed03d41700 (LWP 30787)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0a810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7fed04017700 (LWP 30794)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a09d90) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 36 (Thread 0x7fed0519f700 (LWP 30798)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b5cb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7fec840064d0, record=0x7fec840217f0 "\004p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7fec840064d0, buf=0x7fec840217f0 "\004p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7fecc4070290, table=0x7fec84020e40, info=0x7fed0519d4a0, update=0x7fed0519d420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecc406c9b8, thd=0x7fecc4070290, table_list=0x7fecc406bba8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecc406c9b8, thd=0x7fecc4070290) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7fecc4070290, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7fecc4070290, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7fecc4070290, com_data=0x7fed0519eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7fecc4070290) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c05720) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7fed04647700 (LWP 32677)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b63d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7feca40364c0, record=0x7feca4013390 "\ap*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7feca40364c0, buf=0x7feca4013390 "\ap*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7fecac04e4d0, table=0x7feca4003e70, info=0x7fed046454a0, update=0x7fed04645420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecac00cb18, thd=0x7fecac04e4d0, table_list=0x7fecac00bd08) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecac00cb18, thd=0x7fecac04e4d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7fecac04e4d0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7fecac04e4d0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7fecac04e4d0, com_data=0x7fed04646da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7fecac04e4d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7fed047d3700 (LWP 32679)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b5590) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7fec88014fc0, record=0x7fec88006930 "\003p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7fec88014fc0, buf=0x7fec88006930 "\003p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7fec840079b0, table=0x7fec8800fd80, info=0x7fed047d14a0, update=0x7fed047d1420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fec84012a88, thd=0x7fec840079b0, table_list=0x7fec84011c78) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fec84012a88, thd=0x7fec840079b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7fec840079b0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7fec840079b0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7fec840079b0, com_data=0x7fed047d2da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7fec840079b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0da50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7fed05223700 (LWP 32680)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7fed03dc5700 (LWP 32681)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7fed04269700 (LWP 32682)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x000000000088f26c in native_cond_timedwait (abstime=0x7fed04266ea0, mutex=0x1e60800 <LOCK_item_func_sleep>, cond=0x7fed04266f10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:129
#2  my_cond_timedwait (abstime=0x7fed04266ea0, mp=0x1e60800 <LOCK_item_func_sleep>, cond=0x7fed04266f10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:182
#3  inline_mysql_cond_timedwait (src_line=5262, src_file=0x1356a80 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc", abstime=0x7fed04266ea0, mutex=0x1e60800 <LOCK_item_func_sleep>, that=0x7fed04266f10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1229
#4  Interruptible_wait::wait (this=0x7fed04266f80, cond=0x7fed04266f10, mutex=0x1e60800 <LOCK_item_func_sleep>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc:5262
#5  0x0000000000899158 in Item_func_sleep::val_int (this=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc:6063
#6  0x00000000008285b4 in Item::send (this=0x7feca40171a0, protocol=0x7feca400f358, buffer=0x7fed04267340) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item.cc:7569
#7  0x0000000000cd4c13 in THD::send_result_set_row (this=0x7feca400e300, row_items=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_class.cc:4695
#8  0x0000000000cd4cfb in Query_result_send::send_data (this=0x7feca40178f0, items=...) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_class.cc:2725
#9  0x0000000000ce6488 in end_send (join=0x7feca4017a10, qep_tab=0x7feca4018268, end_of_records=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:2927
#10 0x0000000000ceb90e in evaluate_join_record (join=0x7feca4017a10, qep_tab=0x7feca40180f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:1645
#11 0x0000000000ceca03 in sub_select (join=0x7feca4017a10, qep_tab=0x7feca40180f0, end_of_records=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:1297
#12 0x0000000000cebeca in do_select (join=0x7feca4017a10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:950
#13 JOIN::exec (this=0x7feca4017a10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:199
#14 0x0000000000d56760 in handle_query (thd=0x7feca400e300, lex=0x7feca4010470, result=0x7feca40178f0, added_options=1, removed_options=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_select.cc:184
#15 0x0000000000d17253 in execute_sqlcom_select (thd=0x7feca400e300, all_tables=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5144
#16 0x0000000000d1acda in mysql_execute_command (thd=0x7feca400e300, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:2816
#17 0x0000000000d1c86d in mysql_parse (thd=0x7feca400e300, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#18 0x0000000000d1da95 in dispatch_command (thd=0x7feca400e300, com_data=0x7fed04268da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#19 0x0000000000d1e944 in do_command (thd=0x7feca400e300) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#20 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0e8d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#22 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7fed0515d700 (LWP 437)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7fed042ab700 (LWP 439)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f610) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7fed03bf7700 (LWP 442)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7fed04479700 (LWP 454)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7fed0536d700 (LWP 680)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cf60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7fed04899700 (LWP 682)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a2a260) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7fed042ed700 (LWP 684)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10b7ddb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7fed03fd5700 (LWP 685)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7fed04c35700 (LWP 2846)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5fc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7fed04059700 (LWP 2847)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae5c70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7fed04b6f700 (LWP 2848)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x000000000088f26c in native_cond_timedwait (abstime=0x7fed04b6cea0, mutex=0x1e60800 <LOCK_item_func_sleep>, cond=0x7fed04b6cf10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:129
#2  my_cond_timedwait (abstime=0x7fed04b6cea0, mp=0x1e60800 <LOCK_item_func_sleep>, cond=0x7fed04b6cf10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:182
#3  inline_mysql_cond_timedwait (src_line=5262, src_file=0x1356a80 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc", abstime=0x7fed04b6cea0, mutex=0x1e60800 <LOCK_item_func_sleep>, that=0x7fed04b6cf10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1229
#4  Interruptible_wait::wait (this=0x7fed04b6cf80, cond=0x7fed04b6cf10, mutex=0x1e60800 <LOCK_item_func_sleep>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc:5262
#5  0x0000000000899158 in Item_func_sleep::val_int (this=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc:6063
#6  0x00000000008285b4 in Item::send (this=0x7fec7da5ac20, protocol=0x7fec7da5ec88, buffer=0x7fed04b6d340) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item.cc:7569
#7  0x0000000000cd4c13 in THD::send_result_set_row (this=0x7fec7da5dc30, row_items=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_class.cc:4695
#8  0x0000000000cd4cfb in Query_result_send::send_data (this=0x7fec7da5b370, items=...) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_class.cc:2725
#9  0x0000000000ce6488 in end_send (join=0x7fec7da5b490, qep_tab=0x7fec7da5bce8, end_of_records=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:2927
#10 0x0000000000ceb90e in evaluate_join_record (join=0x7fec7da5b490, qep_tab=0x7fec7da5bb70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:1645
#11 0x0000000000ceca03 in sub_select (join=0x7fec7da5b490, qep_tab=0x7fec7da5bb70, end_of_records=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:1297
#12 0x0000000000cebeca in do_select (join=0x7fec7da5b490) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:950
#13 JOIN::exec (this=0x7fec7da5b490) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:199
#14 0x0000000000d56760 in handle_query (thd=0x7fec7da5dc30, lex=0x7fec7da5fda0, result=0x7fec7da5b370, added_options=1, removed_options=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_select.cc:184
#15 0x0000000000d17253 in execute_sqlcom_select (thd=0x7fec7da5dc30, all_tables=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5144
#16 0x0000000000d1acda in mysql_execute_command (thd=0x7fec7da5dc30, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:2816
#17 0x0000000000d1c86d in mysql_parse (thd=0x7fec7da5dc30, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#18 0x0000000000d1da95 in dispatch_command (thd=0x7fec7da5dc30, com_data=0x7fed04b6eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#19 0x0000000000d1e944 in do_command (thd=0x7fec7da5dc30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#20 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0e8d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#22 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7fed03ecd700 (LWP 2849)):
#0  0x00007fef467a9aeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012c5c70 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fec880008e0, mysql_socket=..., src_line=123, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fec8800f650, buf=0x7fec880008e0 "\a", size=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:123
#3  0x0000000000c6e8a3 in net_read_raw_loop (net=0x7fec88012ce8, count=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:672
#4  0x0000000000c6f13b in net_read_packet_header (net=0x7fec88012ce8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:756
#5  net_read_packet (net=<optimized out>, complen=0x7fed03ecccf8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:822
#6  0x0000000000c6f3ec in my_net_read (net=0x7fec88012ce8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:899
#7  0x0000000000c7cc8c in Protocol_classic::read_packet (this=0x7fec88012588) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:808
#8  0x0000000000c7ba22 in Protocol_classic::get_command (this=0x7fec88012588, com_data=0x7fed03eccda0, cmd=0x7fed03eccdcc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:965
#9  0x0000000000d1e847 in do_command (thd=0x7fec88011530) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:964
#10 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#11 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae6310) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#12 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7fed04bb1700 (LWP 3062)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7fed03aef700 (LWP 3063)):
#0  0x00007fef467a9aeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012c5c70 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fec8c026620, mysql_socket=..., src_line=123, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fec8c00fd10, buf=0x7fec8c026620 "\001", size=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:123
#3  0x0000000000c6e8a3 in net_read_raw_loop (net=0x7fec8c01cab8, count=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:672
#4  0x0000000000c6f13b in net_read_packet_header (net=0x7fec8c01cab8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:756
#5  net_read_packet (net=<optimized out>, complen=0x7fed03aeecf8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:822
#6  0x0000000000c6f3ec in my_net_read (net=0x7fec8c01cab8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:899
#7  0x0000000000c7cc8c in Protocol_classic::read_packet (this=0x7fec8c01c358) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:808
#8  0x0000000000c7ba22 in Protocol_classic::get_command (this=0x7fec8c01c358, com_data=0x7fed03aeeda0, cmd=0x7fed03aeedcc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:965
#9  0x0000000000d1e847 in do_command (thd=0x7fec8c01b300) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:964
#10 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#11 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ec20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#12 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7fed03e49700 (LWP 3064)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7fed05097700 (LWP 9625)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0e8d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7fed03f51700 (LWP 9626)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10ae6310) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7fed046cb700 (LWP 9627)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b6040) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7fecd00044d0, record=0x7fecd00395f0 "\006p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7fecd00044d0, buf=0x7fecd00395f0 "\006p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7fecc0028230, table=0x7fecd0b138d0, info=0x7fed046c94a0, update=0x7fed046c9420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecc0005c48, thd=0x7fecc0028230, table_list=0x7fecc0004e38) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecc0005c48, thd=0x7fecc0028230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7fecc0028230, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7fecc0028230, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7fecc0028230, com_data=0x7fed046cada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7fecc0028230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7fed03b31700 (LWP 9628)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0c8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7fed03b73700 (LWP 9629)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ec20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7fed03c39700 (LWP 9630)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7fed049a1700 (LWP 9631)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a2a810) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7fed04c77700 (LWP 9632)):
#0  0x00007fef467a6de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x000000000088f26c in native_cond_timedwait (abstime=0x7fed04c74ea0, mutex=0x1e60800 <LOCK_item_func_sleep>, cond=0x7fed04c74f10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:129
#2  my_cond_timedwait (abstime=0x7fed04c74ea0, mp=0x1e60800 <LOCK_item_func_sleep>, cond=0x7fed04c74f10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:182
#3  inline_mysql_cond_timedwait (src_line=5262, src_file=0x1356a80 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc", abstime=0x7fed04c74ea0, mutex=0x1e60800 <LOCK_item_func_sleep>, that=0x7fed04c74f10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1229
#4  Interruptible_wait::wait (this=0x7fed04c74f80, cond=0x7fed04c74f10, mutex=0x1e60800 <LOCK_item_func_sleep>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc:5262
#5  0x0000000000899158 in Item_func_sleep::val_int (this=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item_func.cc:6063
#6  0x00000000008285b4 in Item::send (this=0x7fecb80120d0, protocol=0x7fecb800cb88, buffer=0x7fed04c75340) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/item.cc:7569
#7  0x0000000000cd4c13 in THD::send_result_set_row (this=0x7fecb800bb30, row_items=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_class.cc:4695
#8  0x0000000000cd4cfb in Query_result_send::send_data (this=0x7fecb8012820, items=...) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_class.cc:2725
#9  0x0000000000ce6488 in end_send (join=0x7fecb8012940, qep_tab=0x7fecb8013198, end_of_records=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:2927
#10 0x0000000000ceb90e in evaluate_join_record (join=0x7fecb8012940, qep_tab=0x7fecb8013020) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:1645
#11 0x0000000000ceca03 in sub_select (join=0x7fecb8012940, qep_tab=0x7fecb8013020, end_of_records=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:1297
#12 0x0000000000cebeca in do_select (join=0x7fecb8012940) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:950
#13 JOIN::exec (this=0x7fecb8012940) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_executor.cc:199
#14 0x0000000000d56760 in handle_query (thd=0x7fecb800bb30, lex=0x7fecb800dca0, result=0x7fecb8012820, added_options=1, removed_options=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_select.cc:184
#15 0x0000000000d17253 in execute_sqlcom_select (thd=0x7fecb800bb30, all_tables=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5144
#16 0x0000000000d1acda in mysql_execute_command (thd=0x7fecb800bb30, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:2816
#17 0x0000000000d1c86d in mysql_parse (thd=0x7fecb800bb30, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#18 0x0000000000d1da95 in dispatch_command (thd=0x7fecb800bb30, com_data=0x7fed04c76da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#19 0x0000000000d1e944 in do_command (thd=0x7fecb800bb30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#20 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f2c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#22 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7fed04bf3700 (LWP 9633)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a2a260) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7fed04dc1700 (LWP 9634)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0da50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7fed0511b700 (LWP 9635)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cf60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7fed0453f700 (LWP 9636)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10b7ddb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7fed03f0f700 (LWP 9638)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x109a7800) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7fed05265700 (LWP 9640)):
#0  0x00007fef467a6a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000defb38 in native_cond_wait (mutex=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e843a0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e843e0 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000defe3f in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
#6  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0f610) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#7  0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fef4525a9fd in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7fef46bca780 (LWP 20583)):
#0  0x00007fef4524fccd in poll () from /lib64/libc.so.6
#1  0x0000000000df1319 in Mysqld_socket_listener::listen_for_connection_event (this=0x1092b110) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cc55d in connection_event_loop (this=0x107b8b10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=59, argv=0x2ad93b8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/mysqld.cc:5149
#4  0x00007fef4517e555 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c2089 in _start ()
