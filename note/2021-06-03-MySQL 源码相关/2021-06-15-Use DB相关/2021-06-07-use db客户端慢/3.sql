Thread 43 (Thread 0x7f7244447700 (LWP 28672)):
#0  0x00007f724c24f58a in sigwaitinfo () from /lib64/libc.so.6
#1  0x0000000000f5299b in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/mysys/posix_timers.c:77
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x32e4810) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 42 (Thread 0x7f6fd7ca9700 (LWP 28673)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd7ca8dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd7ca8dd0, m1=0x7f6fd7ca8e88, m2=0x7f6fd7ca8e80, request=0x7f6fd7ca8e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd7ca8e50, m2=0x7f6fd7ca8e80, m1=0x7f6fd7ca8e88, global_segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=0, m1=0x7f6fd7ca8e88, m2=0x7f6fd7ca8e80, request=0x7f6fd7ca8e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 41 (Thread 0x7f6fd74a8700 (LWP 28674)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd74a7dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd74a7dd0, m1=0x7f6fd74a7e88, m2=0x7f6fd74a7e80, request=0x7f6fd74a7e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd74a7e50, m2=0x7f6fd74a7e80, m1=0x7f6fd74a7e88, global_segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=1, m1=0x7f6fd74a7e88, m2=0x7f6fd74a7e80, request=0x7f6fd74a7e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7f6fd6ca7700 (LWP 28675)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd6ca6dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd6ca6dd0, m1=0x7f6fd6ca6e88, m2=0x7f6fd6ca6e80, request=0x7f6fd6ca6e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd6ca6e50, m2=0x7f6fd6ca6e80, m1=0x7f6fd6ca6e88, global_segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=2, m1=0x7f6fd6ca6e88, m2=0x7f6fd6ca6e80, request=0x7f6fd6ca6e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 39 (Thread 0x7f6fd64a6700 (LWP 28676)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd64a5dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd64a5dd0, m1=0x7f6fd64a5e88, m2=0x7f6fd64a5e80, request=0x7f6fd64a5e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd64a5e50, m2=0x7f6fd64a5e80, m1=0x7f6fd64a5e88, global_segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=3, m1=0x7f6fd64a5e88, m2=0x7f6fd64a5e80, request=0x7f6fd64a5e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 38 (Thread 0x7f6fd5ca5700 (LWP 28677)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd5ca4dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd5ca4dd0, m1=0x7f6fd5ca4e88, m2=0x7f6fd5ca4e80, request=0x7f6fd5ca4e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd5ca4e50, m2=0x7f6fd5ca4e80, m1=0x7f6fd5ca4e88, global_segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=4, m1=0x7f6fd5ca4e88, m2=0x7f6fd5ca4e80, request=0x7f6fd5ca4e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7f6fd54a4700 (LWP 28678)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd54a3dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd54a3dd0, m1=0x7f6fd54a3e88, m2=0x7f6fd54a3e80, request=0x7f6fd54a3e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd54a3e50, m2=0x7f6fd54a3e80, m1=0x7f6fd54a3e88, global_segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=5, m1=0x7f6fd54a3e88, m2=0x7f6fd54a3e80, request=0x7f6fd54a3e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 36 (Thread 0x7f6fd4ca3700 (LWP 28679)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd4ca2dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd4ca2dd0, m1=0x7f6fd4ca2e88, m2=0x7f6fd4ca2e80, request=0x7f6fd4ca2e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd4ca2e50, m2=0x7f6fd4ca2e80, m1=0x7f6fd4ca2e88, global_segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=6, m1=0x7f6fd4ca2e88, m2=0x7f6fd4ca2e80, request=0x7f6fd4ca2e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7f6fd44a2700 (LWP 28680)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd44a1dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd44a1dd0, m1=0x7f6fd44a1e88, m2=0x7f6fd44a1e80, request=0x7f6fd44a1e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd44a1e50, m2=0x7f6fd44a1e80, m1=0x7f6fd44a1e88, global_segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=7, m1=0x7f6fd44a1e88, m2=0x7f6fd44a1e80, request=0x7f6fd44a1e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7f6fd3ca1700 (LWP 28681)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd3ca0dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd3ca0dd0, m1=0x7f6fd3ca0e88, m2=0x7f6fd3ca0e80, request=0x7f6fd3ca0e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd3ca0e50, m2=0x7f6fd3ca0e80, m1=0x7f6fd3ca0e88, global_segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=8, m1=0x7f6fd3ca0e88, m2=0x7f6fd3ca0e80, request=0x7f6fd3ca0e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7f6fd34a0700 (LWP 28682)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd349fdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd349fdd0, m1=0x7f6fd349fe88, m2=0x7f6fd349fe80, request=0x7f6fd349fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd349fe50, m2=0x7f6fd349fe80, m1=0x7f6fd349fe88, global_segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=9, m1=0x7f6fd349fe88, m2=0x7f6fd349fe80, request=0x7f6fd349fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7f6fd2c9f700 (LWP 28683)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd2c9edd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd2c9edd0, m1=0x7f6fd2c9ee88, m2=0x7f6fd2c9ee80, request=0x7f6fd2c9ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd2c9ee50, m2=0x7f6fd2c9ee80, m1=0x7f6fd2c9ee88, global_segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=10, m1=0x7f6fd2c9ee88, m2=0x7f6fd2c9ee80, request=0x7f6fd2c9ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7f6fd249e700 (LWP 28684)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd249ddd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd249ddd0, m1=0x7f6fd249de88, m2=0x7f6fd249de80, request=0x7f6fd249de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd249de50, m2=0x7f6fd249de80, m1=0x7f6fd249de88, global_segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=11, m1=0x7f6fd249de88, m2=0x7f6fd249de80, request=0x7f6fd249de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7f6fd1c9d700 (LWP 28685)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd1c9cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd1c9cdd0, m1=0x7f6fd1c9ce88, m2=0x7f6fd1c9ce80, request=0x7f6fd1c9ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd1c9ce50, m2=0x7f6fd1c9ce80, m1=0x7f6fd1c9ce88, global_segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=12, m1=0x7f6fd1c9ce88, m2=0x7f6fd1c9ce80, request=0x7f6fd1c9ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7f6fd149c700 (LWP 28686)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd149bdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd149bdd0, m1=0x7f6fd149be88, m2=0x7f6fd149be80, request=0x7f6fd149be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd149be50, m2=0x7f6fd149be80, m1=0x7f6fd149be88, global_segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=13, m1=0x7f6fd149be88, m2=0x7f6fd149be80, request=0x7f6fd149be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7f6fd0c9b700 (LWP 28687)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd0c9add0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd0c9add0, m1=0x7f6fd0c9ae88, m2=0x7f6fd0c9ae80, request=0x7f6fd0c9ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd0c9ae50, m2=0x7f6fd0c9ae80, m1=0x7f6fd0c9ae88, global_segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=14, m1=0x7f6fd0c9ae88, m2=0x7f6fd0c9ae80, request=0x7f6fd0c9ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7f6fd049a700 (LWP 28688)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fd0499dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fd0499dd0, m1=0x7f6fd0499e88, m2=0x7f6fd0499e80, request=0x7f6fd0499e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fd0499e50, m2=0x7f6fd0499e80, m1=0x7f6fd0499e88, global_segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=15, m1=0x7f6fd0499e88, m2=0x7f6fd0499e80, request=0x7f6fd0499e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7f6fcfc99700 (LWP 28689)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fcfc98dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fcfc98dd0, m1=0x7f6fcfc98e88, m2=0x7f6fcfc98e80, request=0x7f6fcfc98e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fcfc98e50, m2=0x7f6fcfc98e80, m1=0x7f6fcfc98e88, global_segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=16, m1=0x7f6fcfc98e88, m2=0x7f6fcfc98e80, request=0x7f6fcfc98e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7f6fcf498700 (LWP 28690)):
#0  0x00007f724d654644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f6fcf497dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f6fcf497dd0, m1=0x7f6fcf497e88, m2=0x7f6fcf497e80, request=0x7f6fcf497e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f6fcf497e50, m2=0x7f6fcf497e80, m1=0x7f6fcf497e88, global_segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=17, m1=0x7f6fcf497e88, m2=0x7f6fcf497e80, request=0x7f6fcf497e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7f6fcec97700 (LWP 28691)):
#0  0x00007f724d861de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f6fcec969a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x3317578, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001139d13 in pc_sleep_if_needed (sig_count=2, next_loop_time=1623030270050) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:2690
#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3191
#5  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7f6fce496700 (LWP 28692)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x1294b448) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x1294b448, reset_sig_count=5705) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7f6fe5554700 (LWP 28696)):
#0  0x00007f724d861de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f6fe5553db0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x12948348, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000000fd2494 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/lock/lock0wait.cc:501
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7f6fe4d53700 (LWP 28697)):
#0  0x00007f724d861de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f6fe4d52ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x33173c8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001095505 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1751
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7f6fdffff700 (LWP 28698)):
#0  0x00007f724d861de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f6fdfffee30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x3317458, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001094595 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1585
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7f6fdf7fe700 (LWP 28699)):
#0  0x00007f724d864e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x0000000000ffb7a0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0thread.cc:279
#2  0x0000000001094bbb in srv_master_sleep () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7f6fdeffd700 (LWP 28700)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x3317188) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3317188, reset_sig_count=1339) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000109659d in srv_purge_coordinator_suspend (rseg_history_len=67, slot=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2676
#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2792
#5  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7f6fde7fc700 (LWP 28701)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x33172a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x33172a8, reset_sig_count=5524) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7f6fddffb700 (LWP 28702)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x3317338) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3317338, reset_sig_count=5157) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7f6fdd7fa700 (LWP 28703)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x3317218) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3317218, reset_sig_count=6485) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7f6fdcff9700 (LWP 28704)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x33174e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x33174e8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000011335bc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0dump.cc:782
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7f6fcc832700 (LWP 28705)):
#0  0x00007f724d861de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f6fcc831dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x1294ed48, time_in_usec=<optimized out>, reset_sig_count=402) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x000000000117c887 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats_bg.cc:428
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7f6fc6dc2700 (LWP 28706)):
#0  0x00007f724d861de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f6fc6dc1950) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x129b9cc8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x00000000010e63d4 in ib_wqueue_timedwait (wq=0x129b9b98, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/ut/ut0wqueue.cc:160
#4  0x00000000011c543a in fts_optimize_thread (arg=0x129b9b98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fts/fts0opt.cc:3031
#5  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7f6fc65c1700 (LWP 28707)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x3317608) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3317608, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001129a6c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0buf.cc:3019
#4  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7f6fe4151700 (LWP 28708)):
#0  0x00007f724d8653c1 in sigwait () from /lib64/libpthread.so.0
#1  0x00000000007c5eeb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:2120
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7f6fc5dc0700 (LWP 28709)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ebee55 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=874, src_file=0x15e0220 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc:874
#5  0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#6  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7f6fe40cf700 (LWP 28733)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6

Thread 7 (Thread 0x7f6fdc331700 (LWP 28811)):
#0  0x00007f724d864aeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7f6f9401d150, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7f6f94014dc0, buf=0x7f6f9401d150 "d", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f6f94031298, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7f6f94031298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7f6f94031298, complen=0x7f6fdc330cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7f6f94031298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f6f94030b38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f6f94030b38, com_data=0x7f6fdc330da0, cmd=0x7f6fdc330dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7f6f9402fae0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007f724c3168dd in clone () from /lib64/libc.so.6

Thread 6 (Thread 0x7f6fdc2af700 (LWP 28812)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7f6fdc22d700 (LWP 28813)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7f6fc40ca700 (LWP 28815)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7f6fbffff700 (LWP 29317)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7f6fbff7d700 (LWP 17189)):
#0  0x00007f724d861a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x12b81ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f724d85dea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f724c3168dd in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7f724dc83780 (LWP 28671)):
#0  0x00007f724c30bc3d in poll () from /lib64/libc.so.6
#1  0x0000000000deee39 in Mysqld_socket_listener::listen_for_connection_event (this=0x129c8c50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cb384 in connection_event_loop (this=0x12980de0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=108, argv=0x319cb98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:5132
#4  0x00007f724c23a555 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c0ed9 in _start ()
