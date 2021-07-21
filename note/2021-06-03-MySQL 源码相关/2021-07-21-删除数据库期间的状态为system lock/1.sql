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
#3  0x0000000001139d13 in pc_sleep_if_needed (sig_count=2, next_loop_time=1626832851491) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:2690
#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3191
#5  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7fba4fb6f700 (LWP 12517)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x11f58648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f58648, reset_sig_count=4525) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
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
#1  0x0000000000ffb03b in wait (this=0x11f61588) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f61588, reset_sig_count=5666) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000010a0ce9 in sync_array_wait_event (arr=0x290d0a8, cell=@0x7fba5fffeaf8: 0x7fbcc32b4228) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0arr.cc:475
#4  0x00000000010a33e6 in rw_lock_s_lock_spin (lock=0x11f87cb8, pass=<optimized out>, file_name=0x1609d20 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc", line=862) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0rw.cc:425
#5  0x0000000001063f2d in rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:433
#6  pfs_rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:796
#7  row_purge_parse_undo_rec (thr=0x11fad978, updated_extern=0x7fba5fffec4f, undo_rec=0x7fba6001f260 "'9\016\037\r", node=0x11fada40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:862
#8  row_purge (thr=0x11fad978, undo_rec=0x7fba6001f260 "'9\016\037\r", node=0x11fada40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1043
#9  row_purge_step (thr=0x11fad978) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1125
#10 0x000000000101b4af in que_thr_step (thr=0x11fad978) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1053
#11 que_run_threads_low (thr=0x11fad978) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1115
#12 que_run_threads (thr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1155
#13 0x00000000010b3ab9 in trx_purge (n_purge_threads=4, batch_size=300, truncate=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0purge.cc:1883
#14 0x00000000010967e7 in srv_do_purge (n_total_purged=<optimized out>, n_threads=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2631
#15 srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2803
#16 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7fba5f7fe700 (LWP 12526)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x11f61588) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f61588, reset_sig_count=5666) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000010a0ce9 in sync_array_wait_event (arr=0x290d0a8, cell=@0x7fba5f7fdc18: 0x7fbcc32b41e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0arr.cc:475
#4  0x00000000010a33e6 in rw_lock_s_lock_spin (lock=0x11f87cb8, pass=<optimized out>, file_name=0x1609d20 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc", line=862) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0rw.cc:425
#5  0x0000000001063f2d in rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:433
#6  pfs_rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:796
#7  row_purge_parse_undo_rec (thr=0x11fad350, updated_extern=0x7fba5f7fdd6f, undo_rec=0x7fba60016fe0 "\a\350\016\037\002", node=0x11fad7d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:862
#8  row_purge (thr=0x11fad350, undo_rec=0x7fba60016fe0 "\a\350\016\037\002", node=0x11fad7d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1043
#9  row_purge_step (thr=0x11fad350) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1125
#10 0x000000000101b4af in que_thr_step (thr=0x11fad350) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1053
#11 que_run_threads_low (thr=0x11fad350) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1115
#12 que_run_threads (thr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1155
#13 0x0000000001093de0 in srv_task_execute () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2472
#14 srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2522
#15 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7fba5effd700 (LWP 12527)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x11f61588) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f61588, reset_sig_count=5666) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000010a0ce9 in sync_array_wait_event (arr=0x290d0a8, cell=@0x7fba5effcc18: 0x7fbcc32b40e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0arr.cc:475
#4  0x00000000010a33e6 in rw_lock_s_lock_spin (lock=0x11f87cb8, pass=<optimized out>, file_name=0x1609d20 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc", line=862) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0rw.cc:425
#5  0x0000000001063f2d in rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:433
#6  pfs_rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:796
#7  row_purge_parse_undo_rec (thr=0x11facd88, updated_extern=0x7fba5effcd6f, undo_rec=0x7fba6001cf00 "\bR\016!\002", node=0x11facf48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:862
#8  row_purge (thr=0x11facd88, undo_rec=0x7fba6001cf00 "\bR\016!\002", node=0x11facf48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1043
#9  row_purge_step (thr=0x11facd88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1125
#10 0x000000000101b4af in que_thr_step (thr=0x11facd88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1053
#11 que_run_threads_low (thr=0x11facd88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1115
#12 que_run_threads (thr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1155
#13 0x0000000001093de0 in srv_task_execute () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2472
#14 srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2522
#15 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7fba5e7fc700 (LWP 12528)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x11f61588) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f61588, reset_sig_count=5666) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000010a0ce9 in sync_array_wait_event (arr=0x290d0a8, cell=@0x7fba5e7fbc18: 0x7fbcc32b4128) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0arr.cc:475
#4  0x00000000010a33e6 in rw_lock_s_lock_spin (lock=0x11f87cb8, pass=<optimized out>, file_name=0x1609d20 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc", line=862) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0rw.cc:425
#5  0x0000000001063f2d in rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:433
#6  pfs_rw_lock_s_lock_func (line=862, lock=0x11f87cb8, pass=<optimized out>, file_name=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/sync0rw.ic:796
#7  row_purge_parse_undo_rec (thr=0x11fad0e8, updated_extern=0x7fba5e7fbd6f, undo_rec=0x7fba60012630 "\030\221\016\035\002", node=0x11fad1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:862
#8  row_purge (thr=0x11fad0e8, undo_rec=0x7fba60012630 "\030\221\016\035\002", node=0x11fad1b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1043
#9  row_purge_step (thr=0x11fad0e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0purge.cc:1125
#10 0x000000000101b4af in que_thr_step (thr=0x11fad0e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1053
#11 que_run_threads_low (thr=0x11fad0e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1115
#12 que_run_threads (thr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1155
#13 0x0000000001093de0 in srv_task_execute () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2472
#14 srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2522
#15 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
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
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x11f5bf48, time_in_usec=<optimized out>, reset_sig_count=406) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
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
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba1ce48b30, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba1cd7be00, buf=0x7fba1ce48b30 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba1c01d438, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba1c01d438) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba1c01d438, complen=0x7fba640a2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba1c01d438) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba1c01ccd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba1c01ccd8, com_data=0x7fba640a2da0, cmd=0x7fba640a2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba1c01bc80) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7fba5d9f4700 (LWP 13505)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x11f54248) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f54248, reset_sig_count=66942) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000000fd5d23 in log_write_up_to (lsn=147573166158, flush_to_disk=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1286
#4  0x0000000000f71dd6 in innobase_flush_logs (hton=<optimized out>, binlog_group_flush=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:4218
#5  0x0000000000d392b0 in plugin_foreach_with_mask (thd=0x0, funcs=0x7fba5d9f13c0, type=<optimized out>, state_mask=4294967287, arg=0x7fba5d9f13ec) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_plugin.cc:2516
#6  0x0000000000d393cd in plugin_foreach_with_mask (thd=<optimized out>, func=<optimized out>, type=<optimized out>, state_mask=<optimized out>, arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_plugin.cc:2531
#7  0x0000000000817972 in ha_flush_logs (db_type=<optimized out>, binlog_group_flush=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/handler.cc:2481
#8  0x0000000000ef024b in MYSQL_BIN_LOG::process_flush_stage_queue (this=0x1e7e180 <mysql_bin_log>, total_bytes_var=0x7fba5d9f14b0, rotate_var=0x7fba5d9f14bf, out_queue_var=0x7fba5d9f14a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/binlog.cc:8729
#9  0x0000000000ef070e in MYSQL_BIN_LOG::ordered_commit (this=0x1e7e180 <mysql_bin_log>, thd=0x7fba04016af0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/binlog.cc:9357
#10 0x0000000000ef112d in MYSQL_BIN_LOG::commit (this=0x1e7e180 <mysql_bin_log>, thd=0x7fba04016af0, all=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/binlog.cc:8629
#11 0x0000000000821c44 in ha_commit_trans (thd=0x7fba04016af0, all=false, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/handler.cc:1796
#12 0x0000000000dd1432 in trans_commit_stmt (thd=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/transaction.cc:458
#13 0x0000000000d15d27 in mysql_execute_command (thd=0x7fba04016af0, first_level=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5004
#14 0x0000000000d1aaad in mysql_parse (thd=0x7fba04016af0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5582
#15 0x0000000000d1bcca in dispatch_command (thd=0x7fba04016af0, com_data=0x7fba5d9f3da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:1458
#16 0x0000000000d1cb74 in do_command (thd=0x7fba04016af0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:999
#17 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#18 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#19 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#20 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6

Thread 4 (Thread 0x7fba5d972700 (LWP 13506)):
#0  0x00007fbccef3dd7d in fsync () from /lib64/libpthread.so.0
#1  0x0000000000ff5610 in os_file_fsync_posix (file=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:3055
#2  os_file_flush_func (file=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:3170
#3  0x000000000118d8f9 in pfs_os_file_flush_func (src_line=5992, file=..., src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/os0file.ic:505
#4  fil_flush (space_id=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5992
#5  0x0000000000fd4af2 in log_write_flush_to_disk_low () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1156
#6  0x0000000000fd5c29 in log_write_up_to (lsn=<optimized out>, flush_to_disk=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1406
#7  0x00000000010d1b2d in trx_flush_log_if_needed_low (lsn=147573166158) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:1794
#8  trx_flush_log_if_needed (trx=0x7fbcc2eb4920, lsn=147573166158) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:1816
#9  trx_commit_in_memory (serialised=<optimized out>, mtr=<optimized out>, trx=0x7fbcc2eb4920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2043
#10 trx_commit_low (trx=0x7fbcc2eb4920, mtr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2180
#11 0x00000000010d1d34 in trx_commit (trx=0x7fbcc2eb4920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2204
#12 0x00000000010d3627 in trx_commit_for_mysql (trx=0x7fbcc2eb4920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2423
#13 0x0000000001176bac in dict_stats_exec_sql (pinfo=<optimized out>, sql=0x161f450 "PROCEDURE DELETE_FROM_INDEX_STATS () IS\nBEGIN\nDELETE FROM \"mysql/innodb_index_stats\" WHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nEND;\n", trx=0x7fbcc2eb4920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:324
#14 0x0000000001176ffb in dict_stats_drop_table (db_and_table=<optimized out>, errstr=0x7fba5d96c580 "", errstr_sz=1024) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:3465
#15 0x0000000001050338 in row_drop_table_for_mysql (name=0x7fba5d96d720 "sbtest/table_clublogscore20190825", trx=0x7fbcc2eb4590, drop_db=true, nonatomic=<optimized out>, handler=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0mysql.cc:4341
#16 0x0000000000f883c2 in ha_innobase::delete_table (this=<optimized out>, name=0x7fba5d96eb30 "./sbtest/table_clublogscore20190825") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:12539
#17 0x000000000081e6d8 in ha_delete_table (thd=0x7fb9f8583050, table_type=<optimized out>, path=0x7fba5d96eb30 "./sbtest/table_clublogscore20190825", db=0x7fb9f8cc1568 "sbtest", alias=0x7fb9f8cc156f "table_clublogscore20190825", generate_warning=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/handler.cc:2586
#18 0x0000000000d7f6fd in mysql_rm_table_no_locks (thd=0x7fb9f8583050, tables=0x7fb9f800e300, if_exists=true, drop_temporary=false, drop_view=true, dont_log_query=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_table.cc:2546
#19 0x0000000000cdf397 in mysql_rm_db (thd=0x7fb9f8583050, db=..., if_exists=<optimized out>, silent=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_db.cc:865
#20 0x0000000000d1a2e5 in mysql_execute_command (thd=0x7fb9f8583050, first_level=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:3818
#21 0x0000000000d1aaad in mysql_parse (thd=0x7fb9f8583050, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5582
#22 0x0000000000d1bcca in dispatch_command (thd=0x7fb9f8583050, com_data=0x7fba5d971da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:1458
#23 0x0000000000d1cb74 in do_command (thd=0x7fb9f8583050) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:999
#24 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#25 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#26 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#27 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6


Thread 3 (Thread 0x7fba5d8f0700 (LWP 13507)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9fc507640, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9fc37f670, buf=0x7fb9fc507640 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9fc4b65f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9fc4b65f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9fc4b65f8, complen=0x7fba5d8efcf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9fc4b65f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9fc4b5e98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9fc4b5e98, com_data=0x7fba5d8efda0, cmd=0x7fba5d8efdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9fc4b4e40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7fba4c0ac700 (LWP 13978)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f0031d60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f0017d90, buf=0x7fb9f0031d60 "\006InnoDB\002\061\060\aDynamic\001\060\001\060\005\061\066\063\070\064\001\060\005\071\070\063\060\064\001\060\001\061\023\062\060\062\061-07-21 09:58:54\373\373\022utf8mb4_general_c", <incomplete sequence \373>, size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f000fb38, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f000fb38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f000fb38, complen=0x7fba4c0abcf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f000fb38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f000f3d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f000f3d8, com_data=0x7fba4c0abda0, cmd=0x7fba4c0abdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f000e380) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7fbccf35c780 (LWP 12496)):
#0  0x00007fbccd9e4c3d in poll () from /lib64/libc.so.6
#1  0x0000000000deee39 in Mysqld_socket_listener::listen_for_connection_event (this=0x121347f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cb384 in connection_event_loop (this=0x13658b20) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=115, argv=0x27a8208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:5132
#4  0x00007fbccd913555 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c0ed9 in _start ()
