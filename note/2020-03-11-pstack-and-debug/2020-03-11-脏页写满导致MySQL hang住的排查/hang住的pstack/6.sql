Thread 142 (Thread 0x7fe7bb96e700 (LWP 19543)):
#0  0x00007fe7c38943da in sigwaitinfo () from /usr/lib64/libc.so.6
#1  0x0000000000f5299b in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/mysys/posix_timers.c:77
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x24b09d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#4  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 141 (Thread 0x7fe6e8111700 (LWP 19544)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e8110e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e8110e10, m1=0x7fe6e8110ec8, m2=0x7fe6e8110ec0, request=0x7fe6e8110e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e8110e90, m2=0x7fe6e8110ec0, m1=0x7fe6e8110ec8, global_segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=0, m1=0x7fe6e8110ec8, m2=0x7fe6e8110ec0, request=0x7fe6e8110e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 140 (Thread 0x7fe6e7910700 (LWP 19545)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e790fe10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e790fe10, m1=0x7fe6e790fec8, m2=0x7fe6e790fec0, request=0x7fe6e790fe90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e790fe90, m2=0x7fe6e790fec0, m1=0x7fe6e790fec8, global_segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=1, m1=0x7fe6e790fec8, m2=0x7fe6e790fec0, request=0x7fe6e790fe90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 139 (Thread 0x7fe6e710f700 (LWP 19546)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e710ee10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e710ee10, m1=0x7fe6e710eec8, m2=0x7fe6e710eec0, request=0x7fe6e710ee90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e710ee90, m2=0x7fe6e710eec0, m1=0x7fe6e710eec8, global_segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=2, m1=0x7fe6e710eec8, m2=0x7fe6e710eec0, request=0x7fe6e710ee90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 138 (Thread 0x7fe6e690e700 (LWP 19547)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e690de10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e690de10, m1=0x7fe6e690dec8, m2=0x7fe6e690dec0, request=0x7fe6e690de90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e690de90, m2=0x7fe6e690dec0, m1=0x7fe6e690dec8, global_segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=3, m1=0x7fe6e690dec8, m2=0x7fe6e690dec0, request=0x7fe6e690de90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 137 (Thread 0x7fe6e610d700 (LWP 19548)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e610ce10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e610ce10, m1=0x7fe6e610cec8, m2=0x7fe6e610cec0, request=0x7fe6e610ce90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e610ce90, m2=0x7fe6e610cec0, m1=0x7fe6e610cec8, global_segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=4, m1=0x7fe6e610cec8, m2=0x7fe6e610cec0, request=0x7fe6e610ce90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 136 (Thread 0x7fe6e590c700 (LWP 19549)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e590be10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e590be10, m1=0x7fe6e590bec8, m2=0x7fe6e590bec0, request=0x7fe6e590be90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e590be90, m2=0x7fe6e590bec0, m1=0x7fe6e590bec8, global_segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=5, m1=0x7fe6e590bec8, m2=0x7fe6e590bec0, request=0x7fe6e590be90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 135 (Thread 0x7fe6e510b700 (LWP 19550)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e510ae10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e510ae10, m1=0x7fe6e510aec8, m2=0x7fe6e510aec0, request=0x7fe6e510ae90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e510ae90, m2=0x7fe6e510aec0, m1=0x7fe6e510aec8, global_segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=6, m1=0x7fe6e510aec8, m2=0x7fe6e510aec0, request=0x7fe6e510ae90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 134 (Thread 0x7fe6e490a700 (LWP 19551)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e4909e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e4909e10, m1=0x7fe6e4909ec8, m2=0x7fe6e4909ec0, request=0x7fe6e4909e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e4909e90, m2=0x7fe6e4909ec0, m1=0x7fe6e4909ec8, global_segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=7, m1=0x7fe6e4909ec8, m2=0x7fe6e4909ec0, request=0x7fe6e4909e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 133 (Thread 0x7fe6e4109700 (LWP 19552)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e4108e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e4108e10, m1=0x7fe6e4108ec8, m2=0x7fe6e4108ec0, request=0x7fe6e4108e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e4108e90, m2=0x7fe6e4108ec0, m1=0x7fe6e4108ec8, global_segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=8, m1=0x7fe6e4108ec8, m2=0x7fe6e4108ec0, request=0x7fe6e4108e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 132 (Thread 0x7fe6e3908700 (LWP 19553)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e3907e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e3907e10, m1=0x7fe6e3907ec8, m2=0x7fe6e3907ec0, request=0x7fe6e3907e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e3907e90, m2=0x7fe6e3907ec0, m1=0x7fe6e3907ec8, global_segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=9, m1=0x7fe6e3907ec8, m2=0x7fe6e3907ec0, request=0x7fe6e3907e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 131 (Thread 0x7fe6e3107700 (LWP 19554)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e3106e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e3106e10, m1=0x7fe6e3106ec8, m2=0x7fe6e3106ec0, request=0x7fe6e3106e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e3106e90, m2=0x7fe6e3106ec0, m1=0x7fe6e3106ec8, global_segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=10, m1=0x7fe6e3106ec8, m2=0x7fe6e3106ec0, request=0x7fe6e3106e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 130 (Thread 0x7fe6e2906700 (LWP 19555)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e2905e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e2905e10, m1=0x7fe6e2905ec8, m2=0x7fe6e2905ec0, request=0x7fe6e2905e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e2905e90, m2=0x7fe6e2905ec0, m1=0x7fe6e2905ec8, global_segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=11, m1=0x7fe6e2905ec8, m2=0x7fe6e2905ec0, request=0x7fe6e2905e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 129 (Thread 0x7fe6e2105700 (LWP 19556)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e2104e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e2104e10, m1=0x7fe6e2104ec8, m2=0x7fe6e2104ec0, request=0x7fe6e2104e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e2104e90, m2=0x7fe6e2104ec0, m1=0x7fe6e2104ec8, global_segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=12, m1=0x7fe6e2104ec8, m2=0x7fe6e2104ec0, request=0x7fe6e2104e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 128 (Thread 0x7fe6e1904700 (LWP 19557)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e1903e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e1903e10, m1=0x7fe6e1903ec8, m2=0x7fe6e1903ec0, request=0x7fe6e1903e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e1903e90, m2=0x7fe6e1903ec0, m1=0x7fe6e1903ec8, global_segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=13, m1=0x7fe6e1903ec8, m2=0x7fe6e1903ec0, request=0x7fe6e1903e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 127 (Thread 0x7fe6e1103700 (LWP 19558)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e1102e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e1102e10, m1=0x7fe6e1102ec8, m2=0x7fe6e1102ec0, request=0x7fe6e1102e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e1102e90, m2=0x7fe6e1102ec0, m1=0x7fe6e1102ec8, global_segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=14, m1=0x7fe6e1102ec8, m2=0x7fe6e1102ec0, request=0x7fe6e1102e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 126 (Thread 0x7fe6e0902700 (LWP 19559)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e0901e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e0901e10, m1=0x7fe6e0901ec8, m2=0x7fe6e0901ec0, request=0x7fe6e0901e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e0901e90, m2=0x7fe6e0901ec0, m1=0x7fe6e0901ec8, global_segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=15, m1=0x7fe6e0901ec8, m2=0x7fe6e0901ec0, request=0x7fe6e0901e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 125 (Thread 0x7fe6e0101700 (LWP 19560)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6e0100e10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6e0100e10, m1=0x7fe6e0100ec8, m2=0x7fe6e0100ec0, request=0x7fe6e0100e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6e0100e90, m2=0x7fe6e0100ec0, m1=0x7fe6e0100ec8, global_segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=16, m1=0x7fe6e0100ec8, m2=0x7fe6e0100ec0, request=0x7fe6e0100e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 124 (Thread 0x7fe6df900700 (LWP 19561)):
#0  0x00007fe7c4c8f644 in __io_getevents_0_4 () from /usr/lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fe6df8ffe10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fe6df8ffe10, m1=0x7fe6df8ffec8, m2=0x7fe6df8ffec0, request=0x7fe6df8ffe90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fe6df8ffe90, m2=0x7fe6df8ffec0, m1=0x7fe6df8ffec8, global_segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=17, m1=0x7fe6df8ffec8, m2=0x7fe6df8ffec0, request=0x7fe6df8ffe90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#8  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
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
Thread 121 (Thread 0x7fe6ecae2700 (LWP 19567)):
#0  0x00007fe7c4e9ca82 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fe6ecae1df0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x791cbc8, time_in_usec=<optimized out>, reset_sig_count=143) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000000fd2494 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/lock/lock0wait.cc:501
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 120 (Thread 0x7fe6ec2e1700 (LWP 19568)):
#0  0x00007fe7c4e9ca82 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fe6ec2e0b00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x24e5a78, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001095505 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1751
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
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
Thread 113 (Thread 0x7fe6c7fff700 (LWP 19575)):
#0  0x00007fe7c4e9c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x24e5b98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x24e5b98, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000011335bc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0dump.cc:782
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 112 (Thread 0x7fe6c77fe700 (LWP 19576)):
#0  0x00007fe7c4e9ca82 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fe6c77fde10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x7923528, time_in_usec=<optimized out>, reset_sig_count=237) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x000000000117c887 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats_bg.cc:428
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 111 (Thread 0x7fe6c6ffd700 (LWP 19577)):
#0  0x00007fe7c4e9ca82 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fe6c6ffc990) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x7981568, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x00000000010e63d4 in ib_wqueue_timedwait (wq=0x7981438, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/ut/ut0wqueue.cc:160
#4  0x00000000011c543a in fts_optimize_thread (arg=0x7981438) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fts/fts0opt.cc:3031
#5  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#6  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 110 (Thread 0x7fe6c67fc700 (LWP 19578)):
#0  0x00007fe7c4e9c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x24e5cb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x24e5cb8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001129a6c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0buf.cc:3019
#4  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 109 (Thread 0x7fe6e9adc700 (LWP 19579)):
#0  0x00007fe7c4e9c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000eb3160 in native_cond_wait (mutex=0x7ab8f20, cond=0x7ab8f50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x7ab8f20, cond=0x7ab8f50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=751, src_file=0x15df8b0 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/event_queue.cc", mutex=0x7ab8f20, that=0x7ab8f50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Event_queue::cond_wait (this=0x7ab8f20, thd=0x7a8a730, abstime=0x0, stage=<optimized out>, src_func=0x15dfa00 <Event_queue::get_top_for_execution_if_time(THD*, Event_queue_element_for_exec**)::__func__> "get_top_for_execution_if_time", src_file=0x15df8b0 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/event_queue.cc", src_line=579) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/event_queue.cc:751
#5  0x0000000000eb40fc in Event_queue::get_top_for_execution_if_time (this=0x7ab8f20, thd=0x7a8a730, event_name=0x7fe6e9adbe78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/event_queue.cc:579
#6  0x0000000000eb597f in Event_scheduler::run (this=0x7ad04e0, thd=0x7a8a730) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/event_scheduler.cc:519
#7  0x0000000000eb5afc in event_scheduler_thread (arg=0x7a29170) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/event_scheduler.cc:243
#8  0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#9  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#10 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 108 (Thread 0x7fe6e9a5b700 (LWP 19580)):
#0  0x00007fe7c4ea0101 in sigwait () from /usr/lib64/libpthread.so.0
#1  0x00000000007c5eeb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:2120
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x7a77bd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#4  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 107 (Thread 0x7fe6c5939700 (LWP 19581)):
#0  0x00007fe7c4e9c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x0000000000ebee55 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=874, src_file=0x15e0220 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc:874
#5  0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#6  0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#7  0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 106 (Thread 0x7fe6e99d9700 (LWP 19584)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b4058860, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b402b710, buf=0x7fe6b4058860 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b4013ae8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b4013ae8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b4013ae8, complen=0x7fe6e99d8d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b4013ae8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b4013388) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b4013388, com_data=0x7fe6e99d8de0, cmd=0x7fe6e99d8e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b4012330) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 105 (Thread 0x7fe6e9958700 (LWP 19606)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a83c71a0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a8f2e320, buf=0x7fe6a83c71a0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a83cee08, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a83cee08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a83cee08, complen=0x7fe6e9957d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a83cee08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a83ce6a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a83ce6a8, com_data=0x7fe6e9957de0, cmd=0x7fe6e9957e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a83cd650) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 104 (Thread 0x7fe6e98d7700 (LWP 19608)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe68c3dcad0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe68c00db30, buf=0x7fe68c3dcad0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe68c3e5238, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe68c3e5238) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe68c3e5238, complen=0x7fe6e98d6d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe68c3e5238) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe68c3e4ad8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe68c3e4ad8, com_data=0x7fe6e98d6de0, cmd=0x7fe6e98d6e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68c3e3a80) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 103 (Thread 0x7fe6dc2ab700 (LWP 19609)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6800f0160, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6800a7d20, buf=0x7fe6800f0160 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe680030918, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe680030918) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe680030918, complen=0x7fe6dc2aad38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe680030918) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6800301b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6800301b8, com_data=0x7fe6dc2aade0, cmd=0x7fe6dc2aae0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68002f160) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 102 (Thread 0x7fe6dc22a700 (LWP 19658)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe684004910, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe684543860, buf=0x7fe684004910 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe68460bdb8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe68460bdb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe68460bdb8, complen=0x7fe6dc229d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe68460bdb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe68460b658) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe68460b658, com_data=0x7fe6dc229de0, cmd=0x7fe6dc229e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68460a600) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 101 (Thread 0x7fe6dc1a9700 (LWP 22936)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe67c08ef20, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe67c0008e0, buf=0x7fe67c08ef20 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe67c3e3788, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe67c3e3788) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe67c3e3788, complen=0x7fe6dc1a8d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe67c3e3788) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe67c3e3028) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe67c3e3028, com_data=0x7fe6dc1a8de0, cmd=0x7fe6dc1a8e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe67c3e1fd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 100 (Thread 0x7fe6dc128700 (LWP 22937)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe670061a40, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe670031450, buf=0x7fe670061a40 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe670485658, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe670485658) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe670485658, complen=0x7fe6dc127d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe670485658) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe670484ef8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe670484ef8, com_data=0x7fe6dc127de0, cmd=0x7fe6dc127e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe670483ea0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 99 (Thread 0x7fe6dc0a7700 (LWP 22938)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe674002940, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe674069740, buf=0x7fe674002940 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe674052808, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe674052808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe674052808, complen=0x7fe6dc0a6d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe674052808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6740520a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6740520a8, com_data=0x7fe6dc0a6de0, cmd=0x7fe6dc0a6e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe674051050) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 98 (Thread 0x7fe6c5138700 (LWP 22939)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66801bc60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66800e230, buf=0x7fe66801bc60 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe66800fbe8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe66800fbe8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe66800fbe8, complen=0x7fe6c5137d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe66800fbe8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe66800f488) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe66800f488, com_data=0x7fe6c5137de0, cmd=0x7fe6c5137e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe66800e430) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 97 (Thread 0x7fe6c50b7700 (LWP 22940)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66c014a40, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66c056aa0, buf=0x7fe66c014a40 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe66c00a0d8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe66c00a0d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe66c00a0d8, complen=0x7fe6c50b6d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe66c00a0d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe66c009978) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe66c009978, com_data=0x7fe6c50b6de0, cmd=0x7fe6c50b6e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe66c008920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 96 (Thread 0x7fe6c5036700 (LWP 22941)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66049cd20, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66048d4f0, buf=0x7fe66049cd20 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6604ad288, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6604ad288) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6604ad288, complen=0x7fe6c5035d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6604ad288) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6604acb28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6604acb28, com_data=0x7fe6c5035de0, cmd=0x7fe6c5035e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6604abad0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 95 (Thread 0x7fe6c4fb5700 (LWP 22942)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6580a8980, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe658047310, buf=0x7fe6580a8980 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe658036e88, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe658036e88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe658036e88, complen=0x7fe6c4fb4d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe658036e88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe658036728) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe658036728, com_data=0x7fe6c4fb4de0, cmd=0x7fe6c4fb4e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6580356d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 94 (Thread 0x7fe6c4f34700 (LWP 22943)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe664066510, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66406d910, buf=0x7fe664066510 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6640526a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6640526a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6640526a8, complen=0x7fe6c4f33d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6640526a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe664051f48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe664051f48, com_data=0x7fe6c4f33de0, cmd=0x7fe6c4f33e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe664050ef0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 93 (Thread 0x7fe6c4eb3700 (LWP 22944)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7bae830, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7baa4c0, buf=0x7bae830 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7ba6118, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7ba6118) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7ba6118, complen=0x7fe6c4eb2d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7ba6118) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7ba59b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7ba59b8, com_data=0x7fe6c4eb2de0, cmd=0x7fe6c4eb2e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7ba4960) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 92 (Thread 0x7fe6c4e32700 (LWP 22945)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6580b95f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6580314c0, buf=0x7fe6580b95f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6580ae148, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6580ae148) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6580ae148, complen=0x7fe6c4e31d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6580ae148) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6580ad9e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6580ad9e8, com_data=0x7fe6c4e31de0, cmd=0x7fe6c4e31e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6580ac990) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 91 (Thread 0x7fe6c4db1700 (LWP 22946)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66400e9d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe664039b70, buf=0x7fe66400e9d0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6640060a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6640060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6640060a8, complen=0x7fe6c4db0d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6640060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe664005948) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe664005948, com_data=0x7fe6c4db0de0, cmd=0x7fe6c4db0e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6640048f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 90 (Thread 0x7fe6c4d30700 (LWP 22947)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6600356f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66004ac40, buf=0x7fe6600356f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe66048afb8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe66048afb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe66048afb8, complen=0x7fe6c4d2fd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe66048afb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe66048a858) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe66048a858, com_data=0x7fe6c4d2fde0, cmd=0x7fe6c4d2fe0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe660489800) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 89 (Thread 0x7fe6c4caf700 (LWP 22948)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66c04d070, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66c04af40, buf=0x7fe66c04d070 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe66c065d98, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe66c065d98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe66c065d98, complen=0x7fe6c4caed38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe66c065d98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe66c065638) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe66c065638, com_data=0x7fe6c4caede0, cmd=0x7fe6c4caee0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe66c0645e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 88 (Thread 0x7fe6c4c2e700 (LWP 22949)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66806d200, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe668066020, buf=0x7fe66806d200 "\236", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe668079a38, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe668079a38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe668079a38, complen=0x7fe6c4c2dd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe668079a38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6680792d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6680792d8, com_data=0x7fe6c4c2dde0, cmd=0x7fe6c4c2de0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe668078280) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 87 (Thread 0x7fe6c4bad700 (LWP 22950)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe67404d040, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe67404af10, buf=0x7fe67404d040 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe67405cde8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe67405cde8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe67405cde8, complen=0x7fe6c4bacd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe67405cde8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe67405c688) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe67405c688, com_data=0x7fe6c4bacde0, cmd=0x7fe6c4bace0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe67405b630) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 86 (Thread 0x7fe6c4b2c700 (LWP 22951)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe67003b610, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe670038c30, buf=0x7fe67003b610 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe67047a498, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe67047a498) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe67047a498, complen=0x7fe6c4b2bd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe67047a498) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe670479d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe670479d38, com_data=0x7fe6c4b2bde0, cmd=0x7fe6c4b2be0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe670478ce0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 85 (Thread 0x7fe6c4aab700 (LWP 22952)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe67c059770, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe67c436c60, buf=0x7fe67c059770 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe67c421f08, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe67c421f08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe67c421f08, complen=0x7fe6c4aaad38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe67c421f08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe67c4217a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe67c4217a8, com_data=0x7fe6c4aaade0, cmd=0x7fe6c4aaae0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe67c420750) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 84 (Thread 0x7fe6c4a2a700 (LWP 22953)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe67800ef90, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe678477640, buf=0x7fe67800ef90 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe678019038, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe678019038) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe678019038, complen=0x7fe6c4a29d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe678019038) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6780188d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6780188d8, com_data=0x7fe6c4a29de0, cmd=0x7fe6c4a29e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe678017880) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 83 (Thread 0x7fe6c49a9700 (LWP 22954)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe68463f130, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe684601780, buf=0x7fe68463f130 "8-01-19 16:36:08\001\061\001\062\rIVJ1516350963\373\005youke", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe684639298, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe684639298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe684639298, complen=0x7fe6c49a8d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe684639298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe684638b38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe684638b38, com_data=0x7fe6c49a8de0, cmd=0x7fe6c49a8e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe684637ae0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 82 (Thread 0x7fe6c4928700 (LWP 22955)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6800c1ef0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe68005c0d0, buf=0x7fe6800c1ef0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe680063548, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe680063548) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe680063548, complen=0x7fe6c4927d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe680063548) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe680062de8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe680062de8, com_data=0x7fe6c4927de0, cmd=0x7fe6c4927e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe680061d90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a8e660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 81 (Thread 0x7fe6c48a7700 (LWP 22956)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe68c033840, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe68c38b4c0, buf=0x7fe68c033840 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe68c3fa708, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe68c3fa708) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe68c3fa708, complen=0x7fe6c48a6d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe68c3fa708) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe68c3f9fa8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe68c3f9fa8, com_data=0x7fe6c48a6de0, cmd=0x7fe6c48a6e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68c3f8f50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 80 (Thread 0x7fe6c4826700 (LWP 22957)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe68808e9f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe68807f8e0, buf=0x7fe68808e9f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6880250b8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6880250b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6880250b8, complen=0x7fe6c4825d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6880250b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe688024958) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe688024958, com_data=0x7fe6c4825de0, cmd=0x7fe6c4825e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe688023900) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 79 (Thread 0x7fe6c47a5700 (LWP 22958)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe694038160, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6944688f0, buf=0x7fe694038160 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe69401ac08, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe69401ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe69401ac08, complen=0x7fe6c47a4d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe69401ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe69401a4a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe69401a4a8, com_data=0x7fe6c47a4de0, cmd=0x7fe6c47a4e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe694019450) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 78 (Thread 0x7fe6c4724700 (LWP 22959)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6900375a0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6903eabb0, buf=0x7fe6900375a0 "$", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe690025428, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe690025428) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe690025428, complen=0x7fe6c4723d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe690025428) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe690024cc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe690024cc8, com_data=0x7fe6c4723de0, cmd=0x7fe6c4723e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe690023c70) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 77 (Thread 0x7fe6c46a3700 (LWP 22960)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe69c012260, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe69c050870, buf=0x7fe69c012260 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe69c47dd38, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe69c47dd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe69c47dd38, complen=0x7fe6c46a2d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe69c47dd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe69c47d5d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe69c47d5d8, com_data=0x7fe6c46a2de0, cmd=0x7fe6c46a2e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe69c47c580) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 76 (Thread 0x7fe6c4622700 (LWP 22961)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe698006970, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe69805dc00, buf=0x7fe698006970 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6980251e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6980251e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6980251e8, complen=0x7fe6c4621d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6980251e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe698024a88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe698024a88, com_data=0x7fe6c4621de0, cmd=0x7fe6c4621e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe698023a30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 75 (Thread 0x7fe6c45a1700 (LWP 22962)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a483a490, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a4032cb0, buf=0x7fe6a483a490 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a44687c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a44687c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a44687c8, complen=0x7fe6c45a0d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a44687c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a4468068) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a4468068, com_data=0x7fe6c45a0de0, cmd=0x7fe6c45a0e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a4467010) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 74 (Thread 0x7fe6c4520700 (LWP 22963)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a03d64e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a03e36b0, buf=0x7fe6a03d64e0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a03c3c68, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a03c3c68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a03c3c68, complen=0x7fe6c451fd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a03c3c68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a03c3508) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a03c3508, com_data=0x7fe6c451fde0, cmd=0x7fe6c451fe0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a03c24b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 73 (Thread 0x7fe6c449f700 (LWP 22964)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6ac3d2340, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6ac003970, buf=0x7fe6ac3d2340 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6ac043998, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6ac043998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6ac043998, complen=0x7fe6c449ed38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6ac043998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6ac043238) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6ac043238, com_data=0x7fe6c449ede0, cmd=0x7fe6c449ee0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6ac0421e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 72 (Thread 0x7fe6c441e700 (LWP 22965)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a83c2ac0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a8ed40b0, buf=0x7fe6a83c2ac0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a83bfd18, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a83bfd18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a83bfd18, complen=0x7fe6c441dd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a83bfd18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a83bf5b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a83bf5b8, com_data=0x7fe6c441dde0, cmd=0x7fe6c441de0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a83be560) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 71 (Thread 0x7fe6c439d700 (LWP 22966)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b4039a50, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b40536b0, buf=0x7fe6b4039a50 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b4031128, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b4031128) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b4031128, complen=0x7fe6c439cd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b4031128) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b40309c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b40309c8, com_data=0x7fe6c439cde0, cmd=0x7fe6c439ce0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b402f970) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 70 (Thread 0x7fe6c431c700 (LWP 22967)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b00e8d40, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b002abc0, buf=0x7fe6b00e8d40 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b00251d8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b00251d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b00251d8, complen=0x7fe6c431bd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b00251d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b0024a78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b0024a78, com_data=0x7fe6c431bde0, cmd=0x7fe6c431be0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b0023a20) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 69 (Thread 0x7fe6c429b700 (LWP 22968)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6bc019470, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6bc074380, buf=0x7fe6bc019470 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6bc04e5e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6bc04e5e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6bc04e5e8, complen=0x7fe6c429ad38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6bc04e5e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6bc04de88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6bc04de88, com_data=0x7fe6c429ade0, cmd=0x7fe6c429ae0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6bc04ce30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 68 (Thread 0x7fe6c421a700 (LWP 22969)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b8012260, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b8039910, buf=0x7fe6b8012260 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b801ac08, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b801ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b801ac08, complen=0x7fe6c4219d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b801ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b801a4a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b801a4a8, com_data=0x7fe6c4219de0, cmd=0x7fe6c4219e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b8019450) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 67 (Thread 0x7fe6c4199700 (LWP 22970)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6c00194d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6c0020110, buf=0x7fe6c00194d0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6c0049408, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6c0049408) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6c0049408, complen=0x7fe6c4198d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6c0049408) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6c0048ca8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6c0048ca8, com_data=0x7fe6c4198de0, cmd=0x7fe6c4198e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6c0047c50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 66 (Thread 0x7fe6c4118700 (LWP 22971)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6cc022b00, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6cc03ea80, buf=0x7fe6cc022b00 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6cc052a38, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6cc052a38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6cc052a38, complen=0x7fe6c4117d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6cc052a38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6cc0522d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6cc0522d8, com_data=0x7fe6c4117de0, cmd=0x7fe6c4117e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6cc051280) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 65 (Thread 0x7fe6c4097700 (LWP 22972)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6c8058540, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6c802c460, buf=0x7fe6c8058540 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6c802eae8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6c802eae8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6c802eae8, complen=0x7fe6c4096d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6c802eae8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6c802e388) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6c802e388, com_data=0x7fe6c4096de0, cmd=0x7fe6c4096e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6c802d330) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 64 (Thread 0x7fe65ffff700 (LWP 22973)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6d4009fe0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6d402c5d0, buf=0x7fe6d4009fe0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6d4024298, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6d4024298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6d4024298, complen=0x7fe65fffed38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6d4024298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6d4023b38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6d4023b38, com_data=0x7fe65fffede0, cmd=0x7fe65fffee0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6d4022ae0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 63 (Thread 0x7fe65ff7e700 (LWP 22974)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6d0013a30, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6d000a140, buf=0x7fe6d0013a30 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6d000baf8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6d000baf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6d000baf8, complen=0x7fe65ff7dd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6d000baf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6d000b398) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6d000b398, com_data=0x7fe65ff7dde0, cmd=0x7fe65ff7de0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6d000a340) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 62 (Thread 0x7fe65fefd700 (LWP 22975)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6d800a200, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6d80008e0, buf=0x7fe6d800a200 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6d8002298, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6d8002298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6d8002298, complen=0x7fe65fefcd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6d8002298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6d8001b38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6d8001b38, com_data=0x7fe65fefcde0, cmd=0x7fe65fefce0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6d8000ae0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 61 (Thread 0x7fe65fe7c700 (LWP 22976)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7ba0950, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7b7c790, buf=0x7ba0950 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7b9c798, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7b9c798) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7b9c798, complen=0x7fe65fe7bd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7b9c798) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7b9c038) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7b9c038, com_data=0x7fe65fe7bde0, cmd=0x7fe65fe7be0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7b9afe0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7b2a1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 60 (Thread 0x7fe65fdfb700 (LWP 22977)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe65808d530, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6580b04a0, buf=0x7fe65808d530 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe65809b508, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe65809b508) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe65809b508, complen=0x7fe65fdfad38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe65809b508) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe65809ada8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe65809ada8, com_data=0x7fe65fdfade0, cmd=0x7fe65fdfae0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe658099d50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 59 (Thread 0x7fe65fd7a700 (LWP 22978)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6640008e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66406e450, buf=0x7fe6640008e0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe664037558, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe664037558) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe664037558, complen=0x7fe65fd79d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe664037558) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe664036df8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe664036df8, com_data=0x7fe65fd79de0, cmd=0x7fe65fd79e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe664035da0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 58 (Thread 0x7fe65fcf9700 (LWP 22979)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe660074380, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6604aa840, buf=0x7fe660074380 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6604900e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6604900e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6604900e8, complen=0x7fe65fcf8d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6604900e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe66048f988) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe66048f988, com_data=0x7fe65fcf8de0, cmd=0x7fe65fcf8e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe66048e930) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 57 (Thread 0x7fe65fc78700 (LWP 22980)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66c004910, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66c068160, buf=0x7fe66c004910 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe66c052838, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe66c052838) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe66c052838, complen=0x7fe65fc77d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe66c052838) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe66c0520d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe66c0520d8, com_data=0x7fe65fc77de0, cmd=0x7fe65fc77e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe66c051080) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 56 (Thread 0x7fe65fbf7700 (LWP 22981)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66802d690, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66801fc90, buf=0x7fe66802d690 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe668021648, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe668021648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe668021648, complen=0x7fe65fbf6d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe668021648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe668020ee8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe668020ee8, com_data=0x7fe65fbf6de0, cmd=0x7fe65fbf6e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe66801fe90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 55 (Thread 0x7fe65fb76700 (LWP 22982)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe674010a30, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe674054d50, buf=0x7fe674010a30 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe674008108, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe674008108) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe674008108, complen=0x7fe65fb75d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe674008108) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6740079a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6740079a8, com_data=0x7fe65fb75de0, cmd=0x7fe65fb75e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe674006950) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 54 (Thread 0x7fe65faf5700 (LWP 22983)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe670056060, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe670046d40, buf=0x7fe670056060 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe670067208, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe670067208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe670067208, complen=0x7fe65faf4d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe670067208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe670066aa8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe670066aa8, com_data=0x7fe65faf4de0, cmd=0x7fe65faf4e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe670065a50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 53 (Thread 0x7fe65fa74700 (LWP 22984)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe67c40a2f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe67c092f50, buf=0x7fe67c40a2f0 "$", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe67c076598, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe67c076598) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe67c076598, complen=0x7fe65fa73d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe67c076598) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe67c075e38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe67c075e38, com_data=0x7fe65fa73de0, cmd=0x7fe65fa73e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe67c074de0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 52 (Thread 0x7fe65f9f3700 (LWP 22985)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe678066fe0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6784694d0, buf=0x7fe678066fe0 "\237", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6780368b8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6780368b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6780368b8, complen=0x7fe65f9f2d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6780368b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe678036158) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe678036158, com_data=0x7fe65f9f2de0, cmd=0x7fe65f9f2e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe678035100) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 51 (Thread 0x7fe65f972700 (LWP 22986)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6845c9c50, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe684605940, buf=0x7fe6845c9c50 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6845e5208, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6845e5208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6845e5208, complen=0x7fe65f971d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6845e5208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6845e4aa8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6845e4aa8, com_data=0x7fe65f971de0, cmd=0x7fe65f971e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6845e3a50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 50 (Thread 0x7fe65f8f1700 (LWP 22987)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe680076020, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe68000c610, buf=0x7fe680076020 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe68000fb08, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe68000fb08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe68000fb08, complen=0x7fe65f8f0d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe68000fb08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe68000f3a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe68000f3a8, com_data=0x7fe65f8f0de0, cmd=0x7fe65f8f0e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68000e350) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 49 (Thread 0x7fe65f870700 (LWP 22988)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe68c3eed60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe68c3a79e0, buf=0x7fe68c3eed60 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe68c017c18, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe68c017c18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe68c017c18, complen=0x7fe65f86fd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe68c017c18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe68c0174b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe68c0174b8, com_data=0x7fe65f86fde0, cmd=0x7fe65f86fe0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68c016460) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 48 (Thread 0x7fe65f7ef700 (LWP 22989)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe688002940, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe68805aa40, buf=0x7fe688002940 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6880941b8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6880941b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6880941b8, complen=0x7fe65f7eed38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6880941b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe688093a58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe688093a58, com_data=0x7fe65f7eede0, cmd=0x7fe65f7eee0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe688092a00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 47 (Thread 0x7fe65f76e700 (LWP 22990)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe69402dc80, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe69445e330, buf=0x7fe69402dc80 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe69404dfa8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe69404dfa8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe69404dfa8, complen=0x7fe65f76dd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe69404dfa8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe69404d848) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe69404d848, com_data=0x7fe65f76dde0, cmd=0x7fe65f76de0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe69404c7f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 46 (Thread 0x7fe65f6ed700 (LWP 22991)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6903986b0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6903a5c80, buf=0x7fe6903986b0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6903d6938, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6903d6938) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6903d6938, complen=0x7fe65f6ecd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6903d6938) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6903d61d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6903d61d8, com_data=0x7fe65f6ecde0, cmd=0x7fe65f6ece0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6903d5180) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 45 (Thread 0x7fe65f66c700 (LWP 22992)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe69c03c320, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe69c01fa00, buf=0x7fe69c03c320 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe69c048548, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe69c048548) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe69c048548, complen=0x7fe65f66bd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe69c048548) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe69c047de8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe69c047de8, com_data=0x7fe65f66bde0, cmd=0x7fe65f66be0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe69c046d90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 44 (Thread 0x7fe65f5eb700 (LWP 22993)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6984b2060, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe69809b8d0, buf=0x7fe6984b2060 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe698ab45d8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe698ab45d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe698ab45d8, complen=0x7fe65f5ead38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe698ab45d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe698ab3e78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe698ab3e78, com_data=0x7fe65f5eade0, cmd=0x7fe65f5eae0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe698ab2e20) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 43 (Thread 0x7fe65f56a700 (LWP 22994)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a47ffec0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a47b4d30, buf=0x7fe6a47ffec0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a47d8488, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a47d8488) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a47d8488, complen=0x7fe65f569d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a47d8488) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a47d7d28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a47d7d28, com_data=0x7fe65f569de0, cmd=0x7fe65f569e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a47d6cd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 42 (Thread 0x7fe65f4e9700 (LWP 22995)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a03c8900, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a03c22a0, buf=0x7fe6a03c8900 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a03d2508, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a03d2508) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a03d2508, complen=0x7fe65f4e8d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a03d2508) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a03d1da8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a03d1da8, com_data=0x7fe65f4e8de0, cmd=0x7fe65f4e8e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a03d0d50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 41 (Thread 0x7fe65f468700 (LWP 22996)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6ac426b60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6ac3ba3d0, buf=0x7fe6ac426b60 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6ac420cc8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6ac420cc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6ac420cc8, complen=0x7fe65f467d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6ac420cc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6ac420568) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6ac420568, com_data=0x7fe65f467de0, cmd=0x7fe65f467e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6ac41f510) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 40 (Thread 0x7fe65f3e7700 (LWP 22997)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a94d70b0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a8d4fff0, buf=0x7fe6a94d70b0 <incomplete sequence \366>, size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a948e018, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a948e018) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a948e018, complen=0x7fe65f3e6d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a948e018) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a948d8b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a948d8b8, com_data=0x7fe65f3e6de0, cmd=0x7fe65f3e6e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a948c860) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 39 (Thread 0x7fe65f366700 (LWP 22998)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b40e0a40, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b40c21f0, buf=0x7fe6b40e0a40 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b40d2ef8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b40d2ef8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b40d2ef8, complen=0x7fe65f365d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b40d2ef8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b40d2798) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b40d2798, com_data=0x7fe65f365de0, cmd=0x7fe65f365e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b40d1740) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7af7a00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 38 (Thread 0x7fe65f2e5700 (LWP 22999)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b00ca000, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b0046500, buf=0x7fe6b00ca000 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b00617a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b00617a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b00617a8, complen=0x7fe65f2e4d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b00617a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b0061048) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b0061048, com_data=0x7fe65f2e4de0, cmd=0x7fe65f2e4e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b005fff0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 37 (Thread 0x7fe65f264700 (LWP 23027)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6bc07fdf0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6bc048d50, buf=0x7fe6bc07fdf0 ")", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6bc002078, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6bc002078) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6bc002078, complen=0x7fe65f263d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6bc002078) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6bc001918) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6bc001918, com_data=0x7fe65f263de0, cmd=0x7fe65f263e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6bc0008c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7af7a00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 36 (Thread 0x7fe65f1e3700 (LWP 23028)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b8023cc0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b8036fb0, buf=0x7fe6b8023cc0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b8057028, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b8057028) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b8057028, complen=0x7fe65f1e2d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b8057028) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b80568c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b80568c8, com_data=0x7fe65f1e2de0, cmd=0x7fe65f1e2e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b8055870) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 35 (Thread 0x7fe65f162700 (LWP 23029)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6c00122c0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6c0021d80, buf=0x7fe6c00122c0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6c005b368, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6c005b368) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6c005b368, complen=0x7fe65f161d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6c005b368) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6c005ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6c005ac08, com_data=0x7fe65f161de0, cmd=0x7fe65f161e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6c0059bb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7af7a00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 34 (Thread 0x7fe65f0e1700 (LWP 23030)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6cc95bcb0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6cc045050, buf=0x7fe6cc95bcb0 "G", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6cc015818, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6cc015818) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6cc015818, complen=0x7fe65f0e0d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6cc015818) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6cc0150b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6cc0150b8, com_data=0x7fe65f0e0de0, cmd=0x7fe65f0e0e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6cc014060) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 33 (Thread 0x7fe65f060700 (LWP 23031)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6c8033270, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6c8031140, buf=0x7fe6c8033270 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6c8024298, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6c8024298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6c8024298, complen=0x7fe65f05fd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6c8024298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6c8023b38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6c8023b38, com_data=0x7fe65f05fde0, cmd=0x7fe65f05fe0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6c8022ae0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7af7a00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 32 (Thread 0x7fe65efdf700 (LWP 23032)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6d402c7f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6d40219a0, buf=0x7fe6d402c7f0 "&", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6d400f7a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6d400f7a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6d400f7a8, complen=0x7fe65efded38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6d400f7a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6d400f048) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6d400f048, com_data=0x7fe65efdede0, cmd=0x7fe65efdee0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6d400dff0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 31 (Thread 0x7fe65ef5e700 (LWP 23033)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6d0025490, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6d0017ac0, buf=0x7fe6d0025490 "\237", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6d0019478, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6d0019478) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6d0019478, complen=0x7fe65ef5dd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6d0019478) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6d0018d18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6d0018d18, com_data=0x7fe65ef5dde0, cmd=0x7fe65ef5de0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6d0017cc0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7af7a00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 30 (Thread 0x7fe65eedd700 (LWP 23034)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7b259f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7b6ed30, buf=0x7b259f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7b7a998, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7b7a998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7b7a998, complen=0x7fe65eedcd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7b7a998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7b7a238) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7b7a238, com_data=0x7fe65eedcde0, cmd=0x7fe65eedce0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7b791e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 29 (Thread 0x7fe65ee5c700 (LWP 23035)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6d80183e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6d800e320, buf=0x7fe6d80183e0 "\006", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6d800fcd8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6d800fcd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6d800fcd8, complen=0x7fe65ee5bd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6d800fcd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6d800f578) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6d800f578, com_data=0x7fe65ee5bde0, cmd=0x7fe65ee5be0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6d800e520) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7baa170) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 28 (Thread 0x7fe65eddb700 (LWP 23036)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6588fd250, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6584d6f70, buf=0x7fe6588fd250 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe65805b088, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe65805b088) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe65805b088, complen=0x7fe65eddad38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe65805b088) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe65805a928) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe65805a928, com_data=0x7fe65eddade0, cmd=0x7fe65eddae0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6580598d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 27 (Thread 0x7fe65ed5a700 (LWP 23037)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66404cee0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe664046590, buf=0x7fe66404cee0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe664048af8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe664048af8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe664048af8, complen=0x7fe65ed59d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe664048af8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe664048398) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe664048398, com_data=0x7fe65ed59de0, cmd=0x7fe65ed59e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe664047340) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 26 (Thread 0x7fe65ecd9700 (LWP 23038)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66003c900, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66006dbd0, buf=0x7fe66003c900 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6600488e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6600488e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6600488e8, complen=0x7fe65ecd8d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6600488e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe660048188) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe660048188, com_data=0x7fe65ecd8de0, cmd=0x7fe65ecd8e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe660047130) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 25 (Thread 0x7fe65ec58700 (LWP 23039)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66c03c900, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe66c0698c0, buf=0x7fe66c03c900 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe66c0488e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe66c0488e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe66c0488e8, complen=0x7fe65ec57d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe66c0488e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe66c048188) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe66c048188, com_data=0x7fe65ec57de0, cmd=0x7fe65ec57e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe66c047130) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 24 (Thread 0x7fe65ebd7700 (LWP 23040)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe66800a200, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6680008e0, buf=0x7fe66800a200 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe668002298, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe668002298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe668002298, complen=0x7fe65ebd6d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe668002298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe668001b38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe668001b38, com_data=0x7fe65ebd6de0, cmd=0x7fe65ebd6e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe668000ae0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 23 (Thread 0x7fe65eb56700 (LWP 23041)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6740356f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe674066b90, buf=0x7fe6740356f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe674048898, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe674048898) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe674048898, complen=0x7fe65eb55d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe674048898) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe674048138) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe674048138, com_data=0x7fe65eb55de0, cmd=0x7fe65eb55e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6740470e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 22 (Thread 0x7fe65ead5700 (LWP 23042)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe670474cd0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe67005d570, buf=0x7fe670474cd0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe670036e38, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe670036e38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe670036e38, complen=0x7fe65ead4d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe670036e38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6700366d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6700366d8, com_data=0x7fe65ead4de0, cmd=0x7fe65ead4e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe670035680) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24b89a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 21 (Thread 0x7fe65ea54700 (LWP 23254)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe67c09f810, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe67c413f60, buf=0x7fe67c09f810 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe67c095568, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe67c095568) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe67c095568, complen=0x7fe65ea53d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe67c095568) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe67c094e08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe67c094e08, com_data=0x7fe65ea53de0, cmd=0x7fe65ea53e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe67c093db0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 20 (Thread 0x7fe65e9d3700 (LWP 23386)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe678461ea0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe678475620, buf=0x7fe678461ea0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe67846b698, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe67846b698) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe67846b698, complen=0x7fe65e9d2d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe67846b698) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe67846af38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe67846af38, com_data=0x7fe65e9d2de0, cmd=0x7fe65e9d2e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe678469ee0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 19 (Thread 0x7fe65e952700 (LWP 23387)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6845f1a30, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6845342d0, buf=0x7fe6845f1a30 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6845b97f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6845b97f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6845b97f8, complen=0x7fe65e951d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6845b97f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6845b9098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6845b9098, com_data=0x7fe65e951de0, cmd=0x7fe65e951e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6845b8040) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 18 (Thread 0x7fe65e8d1700 (LWP 23393)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe680122440, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6800c1b10, buf=0x7fe680122440 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe68003c1c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe68003c1c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe68003c1c8, complen=0x7fe65e8d0d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe68003c1c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe68003ba68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe68003ba68, com_data=0x7fe65e8d0de0, cmd=0x7fe65e8d0e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68003aa10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 17 (Thread 0x7fe65e850700 (LWP 23394)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe68c3fd6d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe68c3a7140, buf=0x7fe68c3fd6d0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe68c407258, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe68c407258) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe68c407258, complen=0x7fe65e84fd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe68c407258) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe68c406af8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe68c406af8, com_data=0x7fe65e84fde0, cmd=0x7fe65e84fe0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68c405aa0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 16 (Thread 0x7fe65e7cf700 (LWP 23395)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6885f4340, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe688065c90, buf=0x7fe6885f4340 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe68803c838, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe68803c838) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe68803c838, complen=0x7fe65e7ced38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe68803c838) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe68803c0d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe68803c0d8, com_data=0x7fe65e7cede0, cmd=0x7fe65e7cee0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe68803b080) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 15 (Thread 0x7fe65e74e700 (LWP 23396)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe694489640, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6940528e0, buf=0x7fe694489640 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe694025458, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe694025458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe694025458, complen=0x7fe65e74dd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe694025458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe694024cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe694024cf8, com_data=0x7fe65e74dde0, cmd=0x7fe65e74de0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe694023ca0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 14 (Thread 0x7fe65e6cd700 (LWP 23397)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6900405c0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe690035430, buf=0x7fe6900405c0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6903a9a88, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6903a9a88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6903a9a88, complen=0x7fe65e6ccd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6903a9a88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6903a9328) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6903a9328, com_data=0x7fe65e6ccde0, cmd=0x7fe65e6cce0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6903a82d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 13 (Thread 0x7fe65e64c700 (LWP 23398)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe69c45fd10, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe69c0532a0, buf=0x7fe69c45fd10 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe69c025458, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe69c025458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe69c025458, complen=0x7fe65e64bd38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe69c025458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe69c024cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe69c024cf8, com_data=0x7fe65e64bde0, cmd=0x7fe65e64be0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe69c023ca0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 12 (Thread 0x7fe65e5cb700 (LWP 23399)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe698057e10, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6980394a0, buf=0x7fe698057e10 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe69803ef58, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe69803ef58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe69803ef58, complen=0x7fe65e5cad38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe69803ef58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe69803e7f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe69803e7f8, com_data=0x7fe65e5cade0, cmd=0x7fe65e5cae0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe69803d7a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 11 (Thread 0x7fe65e54a700 (LWP 23400)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a4034920, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a4031330, buf=0x7fe6a4034920 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a4053a18, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a4053a18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a4053a18, complen=0x7fe65e549d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a4053a18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a40532b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a40532b8, com_data=0x7fe65e549de0, cmd=0x7fe65e549e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a4052260) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 10 (Thread 0x7fe65e4c9700 (LWP 23401)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a03dd060, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a0398b20, buf=0x7fe6a03dd060 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a0395d48, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a0395d48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a0395d48, complen=0x7fe65e4c8d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a0395d48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a03955e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a03955e8, com_data=0x7fe65e4c8de0, cmd=0x7fe65e4c8e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a0394590) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 9 (Thread 0x7fe65e448700 (LWP 23402)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6ac02bb60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6ac007aa0, buf=0x7fe6ac02bb60 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6ac417298, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6ac417298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6ac417298, complen=0x7fe65e447d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6ac417298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6ac416b38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6ac416b38, com_data=0x7fe65e447de0, cmd=0x7fe65e447e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6ac415ae0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 8 (Thread 0x7fe65e3c7700 (LWP 23403)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6a903ca70, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6a8d6e060, buf=0x7fe6a903ca70 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6a8ff9e68, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6a8ff9e68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6a8ff9e68, complen=0x7fe65e3c6d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6a8ff9e68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6a8ff9708) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6a8ff9708, com_data=0x7fe65e3c6de0, cmd=0x7fe65e3c6e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6a8ff86b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 7 (Thread 0x7fe65e346700 (LWP 23404)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b402b960, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b40160b0, buf=0x7fe6b402b960 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b4066048, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b4066048) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b4066048, complen=0x7fe65e345d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b4066048) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b40658e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b40658e8, com_data=0x7fe65e345de0, cmd=0x7fe65e345e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b4064890) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 6 (Thread 0x7fe65e2c5700 (LWP 24413)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6b003c9e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6b0044090, buf=0x7fe6b003c9e0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6b004e998, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6b004e998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6b004e998, complen=0x7fe65e2c4d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6b004e998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6b004e238) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6b004e238, com_data=0x7fe65e2c4de0, cmd=0x7fe65e2c4e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6b004d1e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a93f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 5 (Thread 0x7fe65e244700 (LWP 24414)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6bc023cc0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6bc076e20, buf=0x7fe6bc023cc0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6bc06af58, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6bc06af58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6bc06af58, complen=0x7fe65e243d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6bc06af58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6bc06a7f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6bc06a7f8, com_data=0x7fe65e243de0, cmd=0x7fe65e243e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6bc0697a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x24a73e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 4 (Thread 0x7fe65e1c3700 (LWP 11610)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6d848aae0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6d8480350, buf=0x7fe6d848aae0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6d8484c48, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6d8484c48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6d8484c48, complen=0x7fe65e1c2d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6d8484c48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6d84844e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6d84844e8, com_data=0x7fe65e1c2de0, cmd=0x7fe65e1c2e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6d8483490) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7a68720) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 3 (Thread 0x7fe65e142700 (LWP 11611)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7bc9f70, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7babb50, buf=0x7bc9f70 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7bb3ff8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7bb3ff8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7bb3ff8, complen=0x7fe65e141d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7bb3ff8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7bb3898) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7bb3898, com_data=0x7fe65e141de0, cmd=0x7fe65e141e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7bb2840) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7af7a00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 2 (Thread 0x7fe65e0c1700 (LWP 11612)):
#0  0x00007fe7c4e9f82b in recv () from /usr/lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fe6584cc670, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fe6588dfd00, buf=0x7fe6584cc670 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fe6588e5dd8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fe6588e5dd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fe6588e5dd8, complen=0x7fe65e0c0d38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fe6588e5dd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fe6588e5678) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fe6588e5678, com_data=0x7fe65e0c0de0, cmd=0x7fe65e0c0e0c) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fe6588e4620) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x7957e30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fe7c4e98dc5 in start_thread () from /usr/lib64/libpthread.so.0
#13 0x00007fe7c395576d in clone () from /usr/lib64/libc.so.6
Thread 1 (Thread 0x7fe7c52b5740 (LWP 19542)):
#0  0x00007fe7c394ae2d in poll () from /usr/lib64/libc.so.6
#1  0x0000000000deee39 in Mysqld_socket_listener::listen_for_connection_event (this=0x24b8570) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cb384 in connection_event_loop (this=0x7928cf0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=117, argv=0x2395208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:5132
#4  0x00007fe7c387fb35 in __libc_start_main () from /usr/lib64/libc.so.6
#5  0x00000000007c0ed9 in _start ()
