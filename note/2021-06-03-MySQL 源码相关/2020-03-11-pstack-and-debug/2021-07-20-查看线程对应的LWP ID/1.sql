Thread 41 (Thread 0x7fbcc5b20700 (LWP 12497)):
#0  0x00007fbccd92858a in sigwaitinfo () from /lib64/libc.so.6
#1  0x0000000000f5299b in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/mysys/posix_timers.c:77
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x28ef8a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7fba59382700 (LWP 12498)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba59381dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba59381dd0, m1=0x7fba59381e88, m2=0x7fba59381e80, request=0x7fba59381e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba59381e50, m2=0x7fba59381e80, m1=0x7fba59381e88, global_segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=0, m1=0x7fba59381e88, m2=0x7fba59381e80, request=0x7fba59381e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 39 (Thread 0x7fba58b81700 (LWP 12499)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba58b80dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba58b80dd0, m1=0x7fba58b80e88, m2=0x7fba58b80e80, request=0x7fba58b80e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba58b80e50, m2=0x7fba58b80e80, m1=0x7fba58b80e88, global_segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=1, m1=0x7fba58b80e88, m2=0x7fba58b80e80, request=0x7fba58b80e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 38 (Thread 0x7fba58380700 (LWP 12500)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba5837fdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba5837fdd0, m1=0x7fba5837fe88, m2=0x7fba5837fe80, request=0x7fba5837fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba5837fe50, m2=0x7fba5837fe80, m1=0x7fba5837fe88, global_segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=2, m1=0x7fba5837fe88, m2=0x7fba5837fe80, request=0x7fba5837fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7fba57b7f700 (LWP 12501)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba57b7edd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba57b7edd0, m1=0x7fba57b7ee88, m2=0x7fba57b7ee80, request=0x7fba57b7ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba57b7ee50, m2=0x7fba57b7ee80, m1=0x7fba57b7ee88, global_segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=3, m1=0x7fba57b7ee88, m2=0x7fba57b7ee80, request=0x7fba57b7ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 36 (Thread 0x7fba5737e700 (LWP 12502)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba5737ddd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba5737ddd0, m1=0x7fba5737de88, m2=0x7fba5737de80, request=0x7fba5737de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba5737de50, m2=0x7fba5737de80, m1=0x7fba5737de88, global_segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=4, m1=0x7fba5737de88, m2=0x7fba5737de80, request=0x7fba5737de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7fba56b7d700 (LWP 12503)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba56b7cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba56b7cdd0, m1=0x7fba56b7ce88, m2=0x7fba56b7ce80, request=0x7fba56b7ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba56b7ce50, m2=0x7fba56b7ce80, m1=0x7fba56b7ce88, global_segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=5, m1=0x7fba56b7ce88, m2=0x7fba56b7ce80, request=0x7fba56b7ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7fba5637c700 (LWP 12504)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba5637bdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba5637bdd0, m1=0x7fba5637be88, m2=0x7fba5637be80, request=0x7fba5637be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba5637be50, m2=0x7fba5637be80, m1=0x7fba5637be88, global_segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=6, m1=0x7fba5637be88, m2=0x7fba5637be80, request=0x7fba5637be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7fba55b7b700 (LWP 12505)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba55b7add0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba55b7add0, m1=0x7fba55b7ae88, m2=0x7fba55b7ae80, request=0x7fba55b7ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba55b7ae50, m2=0x7fba55b7ae80, m1=0x7fba55b7ae88, global_segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=7, m1=0x7fba55b7ae88, m2=0x7fba55b7ae80, request=0x7fba55b7ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7fba5537a700 (LWP 12506)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba55379dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba55379dd0, m1=0x7fba55379e88, m2=0x7fba55379e80, request=0x7fba55379e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba55379e50, m2=0x7fba55379e80, m1=0x7fba55379e88, global_segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=8, m1=0x7fba55379e88, m2=0x7fba55379e80, request=0x7fba55379e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7fba54b79700 (LWP 12507)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba54b78dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba54b78dd0, m1=0x7fba54b78e88, m2=0x7fba54b78e80, request=0x7fba54b78e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba54b78e50, m2=0x7fba54b78e80, m1=0x7fba54b78e88, global_segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=9, m1=0x7fba54b78e88, m2=0x7fba54b78e80, request=0x7fba54b78e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7fba54378700 (LWP 12508)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba54377dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba54377dd0, m1=0x7fba54377e88, m2=0x7fba54377e80, request=0x7fba54377e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba54377e50, m2=0x7fba54377e80, m1=0x7fba54377e88, global_segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=10, m1=0x7fba54377e88, m2=0x7fba54377e80, request=0x7fba54377e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7fba53b77700 (LWP 12509)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba53b76dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba53b76dd0, m1=0x7fba53b76e88, m2=0x7fba53b76e80, request=0x7fba53b76e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba53b76e50, m2=0x7fba53b76e80, m1=0x7fba53b76e88, global_segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=11, m1=0x7fba53b76e88, m2=0x7fba53b76e80, request=0x7fba53b76e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7fba53376700 (LWP 12510)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba53375dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba53375dd0, m1=0x7fba53375e88, m2=0x7fba53375e80, request=0x7fba53375e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba53375e50, m2=0x7fba53375e80, m1=0x7fba53375e88, global_segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=12, m1=0x7fba53375e88, m2=0x7fba53375e80, request=0x7fba53375e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7fba52b75700 (LWP 12511)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba52b74dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba52b74dd0, m1=0x7fba52b74e88, m2=0x7fba52b74e80, request=0x7fba52b74e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba52b74e50, m2=0x7fba52b74e80, m1=0x7fba52b74e88, global_segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=13, m1=0x7fba52b74e88, m2=0x7fba52b74e80, request=0x7fba52b74e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7fba52374700 (LWP 12512)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba52373dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba52373dd0, m1=0x7fba52373e88, m2=0x7fba52373e80, request=0x7fba52373e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba52373e50, m2=0x7fba52373e80, m1=0x7fba52373e88, global_segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=14, m1=0x7fba52373e88, m2=0x7fba52373e80, request=0x7fba52373e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7fba51b73700 (LWP 12513)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba51b72dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba51b72dd0, m1=0x7fba51b72e88, m2=0x7fba51b72e80, request=0x7fba51b72e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba51b72e50, m2=0x7fba51b72e80, m1=0x7fba51b72e88, global_segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=15, m1=0x7fba51b72e88, m2=0x7fba51b72e80, request=0x7fba51b72e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7fba51372700 (LWP 12514)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba51371dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba51371dd0, m1=0x7fba51371e88, m2=0x7fba51371e80, request=0x7fba51371e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba51371e50, m2=0x7fba51371e80, m1=0x7fba51371e88, global_segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=16, m1=0x7fba51371e88, m2=0x7fba51371e80, request=0x7fba51371e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7fba50b71700 (LWP 12515)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba50b70dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba50b70dd0, m1=0x7fba50b70e88, m2=0x7fba50b70e80, request=0x7fba50b70e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba50b70e50, m2=0x7fba50b70e80, m1=0x7fba50b70e88, global_segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=17, m1=0x7fba50b70e88, m2=0x7fba50b70e80, request=0x7fba50b70e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7fba50370700 (LWP 12516)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba5036f9a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2924778, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001139d13 in pc_sleep_if_needed (sig_count=2, next_loop_time=1626775610470) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:2690
#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3191
#5  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7fba4fb6f700 (LWP 12517)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x11f58648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f58648, reset_sig_count=3815) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7fba663ea700 (LWP 12521)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba663e9db0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x11f55548, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000000fd2494 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/lock/lock0wait.cc:501
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7fba65be9700 (LWP 12522)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba65be8ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x29245c8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001095505 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1751
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7fba653e8700 (LWP 12523)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba653e7e30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2924658, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001094595 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1585
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7fba64be7700 (LWP 12524)):
#0  0x00007fbccef3de9d in nanosleep () from /lib64/libpthread.so.0
#1  0x0000000000ffb7a0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0thread.cc:279
#2  0x0000000001094bbb in srv_master_sleep () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7fba5ffff700 (LWP 12525)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924388) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924388, reset_sig_count=373) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000109659d in srv_purge_coordinator_suspend (rseg_history_len=23, slot=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2676
#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2792
#5  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7fba5f7fe700 (LWP 12526)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924538) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924538, reset_sig_count=1474) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7fba5effd700 (LWP 12527)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924418) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924418, reset_sig_count=1740) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7fba5e7fc700 (LWP 12528)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x29244a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x29244a8, reset_sig_count=1624) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7fba4ccce700 (LWP 12531)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x29246e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x29246e8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000011335bc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0dump.cc:782
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7fba3ffff700 (LWP 12532)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba3fffedd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x11f5bf48, time_in_usec=<optimized out>, reset_sig_count=304) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x000000000117c887 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats_bg.cc:428
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7fba3f7fe700 (LWP 12533)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba3f7fd950) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x123298a8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x00000000010e63d4 in ib_wqueue_timedwait (wq=0x12329778, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/ut/ut0wqueue.cc:160
#4  0x00000000011c543a in fts_optimize_thread (arg=0x12329778) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fts/fts0opt.cc:3031
#5  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7fba3effd700 (LWP 12534)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924808, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001129a6c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0buf.cc:3019
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7fba64125700 (LWP 12537)):
#0  0x00007fbccef3e3c1 in sigwait () from /lib64/libpthread.so.0
#1  0x00000000007c5eeb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:2120
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7fba3e7fc700 (LWP 12538)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ebee55 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=874, src_file=0x15e0220 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc:874
#5  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#6  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7fba640a3700 (LWP 12541)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7fba5d9f4700 (LWP 13505)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7fba5d972700 (LWP 13506)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f851e3f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f83d54c0, buf=0x7fb9f851e3f0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f8584808, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f8584808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f8584808, complen=0x7fba5d971cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f8584808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f85840a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f85840a8, com_data=0x7fba5d971da0, cmd=0x7fba5d971dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f8583050) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7fba5d8f0700 (LWP 13507)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7fba4c0ac700 (LWP 13978)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7fbccf35c780 (LWP 12496)):
#0  0x00007fbccd9e4c3d in poll () from /lib64/libc.so.6
#1  0x0000000000deee39 in Mysqld_socket_listener::listen_for_connection_event (this=0x121347f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cb384 in connection_event_loop (this=0x13658b20) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=115, argv=0x27a8208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:5132
#4  0x00007fbccd913555 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c0ed9 in _start ()
