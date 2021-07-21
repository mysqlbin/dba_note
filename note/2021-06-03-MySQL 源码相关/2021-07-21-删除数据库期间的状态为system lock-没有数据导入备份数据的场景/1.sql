Thread 142 (Thread 0x7fbcc5b20700 (LWP 12497)):
#0  0x00007fbccd92858a in sigwaitinfo () from /lib64/libc.so.6
#1  0x0000000000f5299b in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/mysys/posix_timers.c:77
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x28ef8a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
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
Thread 140 (Thread 0x7fba58b81700 (LWP 12499)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba58b80dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba58b80dd0, m1=0x7fba58b80e88, m2=0x7fba58b80e80, request=0x7fba58b80e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba58b80e50, m2=0x7fba58b80e80, m1=0x7fba58b80e88, global_segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=1, m1=0x7fba58b80e88, m2=0x7fba58b80e80, request=0x7fba58b80e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
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
Thread 124 (Thread 0x7fba50b71700 (LWP 12515)):
#0  0x00007fbcced2d644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7fba50b70dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7fba50b70dd0, m1=0x7fba50b70e88, m2=0x7fba50b70e80, request=0x7fba50b70e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7fba50b70e50, m2=0x7fba50b70e80, m1=0x7fba50b70e88, global_segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=17, m1=0x7fba50b70e88, m2=0x7fba50b70e80, request=0x7fba50b70e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 123 (Thread 0x7fba50370700 (LWP 12516)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba5036f9a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2924778, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001139d13 in pc_sleep_if_needed (sig_count=2, next_loop_time=1626851864786) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:2690
#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3191
#5  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 122 (Thread 0x7fba4fb6f700 (LWP 12517)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x11f58648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f58648, reset_sig_count=5614) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 121 (Thread 0x7fba663ea700 (LWP 12521)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba663e9db0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x11f55548, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000000fd2494 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/lock/lock0wait.cc:501
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 120 (Thread 0x7fba65be9700 (LWP 12522)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba65be8ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x29245c8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001095505 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1751
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 119 (Thread 0x7fba653e8700 (LWP 12523)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba653e7e30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2924658, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001094595 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1585
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 118 (Thread 0x7fba64be7700 (LWP 12524)):
#0  0x00007fbccef3de9d in nanosleep () from /lib64/libpthread.so.0
#1  0x0000000000ffb7a0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0thread.cc:279
#2  0x0000000001094bbb in srv_master_sleep () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
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
Thread 113 (Thread 0x7fba4ccce700 (LWP 12531)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x29246e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x29246e8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000011335bc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0dump.cc:782
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 112 (Thread 0x7fba3ffff700 (LWP 12532)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba3fffedd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x11f5bf48, time_in_usec=<optimized out>, reset_sig_count=615) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x000000000117c887 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats_bg.cc:428
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 111 (Thread 0x7fba3f7fe700 (LWP 12533)):
#0  0x00007fbccef3ade2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7fba3f7fd950) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x123298a8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x00000000010e63d4 in ib_wqueue_timedwait (wq=0x12329778, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/ut/ut0wqueue.cc:160
#4  0x00000000011c543a in fts_optimize_thread (arg=0x12329778) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fts/fts0opt.cc:3031
#5  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 110 (Thread 0x7fba3effd700 (LWP 12534)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924808, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001129a6c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0buf.cc:3019
#4  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 109 (Thread 0x7fba64125700 (LWP 12537)):
#0  0x00007fbccef3e3c1 in sigwait () from /lib64/libpthread.so.0
#1  0x00000000007c5eeb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:2120
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 108 (Thread 0x7fba3e7fc700 (LWP 12538)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ebee55 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=874, src_file=0x15e0220 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc:874
#5  0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#6  0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 107 (Thread 0x7fba640a3700 (LWP 12541)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba1cd45000, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba1d1513e0, buf=0x7fba1cd45000 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba1c01d1e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba1c01d1e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba1c01d1e8, complen=0x7fba640a2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba1c01d1e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba1c01ca88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba1c01ca88, com_data=0x7fba640a2da0, cmd=0x7fba640a2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba1c01ba30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 106 (Thread 0x7fba5d9f4700 (LWP 13505)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba04020540, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba051f1470, buf=0x7fba04020540 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba04bc53b8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba04bc53b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba04bc53b8, complen=0x7fba5d9f3cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba04bc53b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba04bc4c58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba04bc4c58, com_data=0x7fba5d9f3da0, cmd=0x7fba5d9f3dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba04bc3c00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 105 (Thread 0x7fba5d972700 (LWP 13506)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f83987d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f84619a0, buf=0x7fb9f83987d0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f83c1198, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f83c1198) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f83c1198, complen=0x7fba5d971cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f83c1198) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f83c0a38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f83c0a38, com_data=0x7fba5d971da0, cmd=0x7fba5d971dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f83bf9e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 104 (Thread 0x7fba5d8f0700 (LWP 13507)):
#0  0x00007fbccef3aa35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x11f87e48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x11f87e48, reset_sig_count=2779) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000010a0ce9 in sync_array_wait_event (arr=0x290d0a8, cell=@0x7fba5d8eb8a8: 0x7fbcc32b4068) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/sync/sync0arr.cc:475
#4  0x0000000000f8c1c4 in TTASEventMutex<GenericPolicy>::wait (this=0x11f87d58, filename=0x1603970 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc", line=1235, spin=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/ut0mutex.ic:89
#5  0x000000000101bb52 in spin_and_try_lock (max_delay=100, max_spins=<optimized out>, line=1235, filename=0x1603970 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc", this=0x11f87d58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/ib0mutex.h:850
#6  enter (line=1235, filename=0x1603970 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc", this=0x11f87d58, max_delay=100, max_spins=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/ib0mutex.h:707
#7  enter (line=1235, name=0x1603970 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc", n_delay=100, n_spins=<optimized out>, this=0x11f87d58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/ib0mutex.h:987
#8  que_eval_sql (info=0x7fb900000064, sql=<optimized out>, reserve_dict_mutex=<optimized out>, trx=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/que/que0que.cc:1235
#9  0x000000000117a4f6 in dict_stats_fetch_from_ps (table=0x7fb9fc73b798) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:2994
#10 dict_stats_update (table=0x7fb9fc3d8fa8, stats_upd_option=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:3187
#11 0x0000000000f81e9c in dict_stats_init (table=0x7fb9fc3d8fa8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/dict0stats.ic:173
#12 ha_innobase::open (this=0x7fb9fd33d780, name=0x7fb9fc3b8768 "./niuniuh5_db/table_citypartner_info", mode=<optimized out>, test_if_locked=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:5956
#13 0x000000000081b33e in handler::ha_open (this=0x7fb9fd33d780, table_arg=<optimized out>, name=0x7fb9fc3b8768 "./niuniuh5_db/table_citypartner_info", mode=2, test_if_locked=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/handler.cc:2759
#14 0x0000000000dc239a in open_table_from_share (thd=0x7fb9fc3eae60, share=<optimized out>, alias=0x7fb900000010 <Address 0x7fb900000010 out of bounds>, db_stat=39, prgflag=<optimized out>, ha_open_flags=0, outparam=0x7fb9fd3e2fb0, is_create_table=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/table.cc:3353
#15 0x0000000000cc18b9 in open_table (thd=0x7fb9fc3eae60, table_list=0x7fb9fd3af4e0, ot_ctx=0x7fba5d8ed090) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_base.cc:3559
#16 0x0000000000cc52b6 in open_and_process_table (ot_ctx=0x7fba5d8ed090, has_prelocking_list=false, prelocking_strategy=0x7fba5d8ed160, flags=1026, counter=0x7fba5d8ed2c0, tables=0x7fb9fd3af4e0, lex=0x7fba5d8ed200, thd=0x7fb9fc3eae60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_base.cc:5145
#17 open_tables (thd=0x7fb9fc3eae60, start=0x7fba5d8ed148, counter=0x7fba5d8ed2c0, flags=1026, prelocking_strategy=0x7fba5d8ed160) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_base.cc:5756
#18 0x0000000000cc5e62 in open_tables_for_query (thd=<optimized out>, tables=0x7fb9fd3af4e0, flags=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_base.cc:6531
#19 0x0000000000d625f4 in fill_schema_table_by_open (thd=0x7fb9fc3eae60, mem_root=<optimized out>, is_show_fields_or_keys=true, table=0x7fb9fd3b9cd0, schema_table=0x1dc1380 <schema_tables+192>, orig_db_name=0x7fba5d8ee0c0, orig_table_name=0x7fba5d8edda0, open_tables_state_backup=0x7fba5d8edfb0, can_deadlock=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_show.cc:3965
#20 0x0000000000d70267 in get_all_tables (thd=0x7fb9fc3eae60, tables=0x7fb9fc3f7d28, cond=0x0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_show.cc:4596
#21 0x0000000000d5dc98 in do_fill_table (thd=0x7fb9fc3eae60, table_list=0x7fb9fc3f7d28, qep_tab=0x7fb9fd3dcc28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_show.cc:8148
#22 0x0000000000d5def9 in get_schema_tables_result (join=0x7fb9fd3dc6f0, executed_place=PROCESSED_BY_JOIN_EXEC) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_show.cc:8278
#23 0x0000000000d5364d in JOIN::prepare_result (this=0x7fb9fd3dc6f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_select.cc:908
#24 0x0000000000cea100 in JOIN::exec (this=0x7fb9fd3dc6f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_executor.cc:124
#25 0x0000000000d54a10 in handle_query (thd=0x7fb9fc3eae60, lex=0x7fb9fc3ecfc8, result=0x7fb9fd3d5248, added_options=1, removed_options=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_select.cc:184
#26 0x0000000000d15353 in execute_sqlcom_select (thd=0x7fb9fc3eae60, all_tables=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5156
#27 0x0000000000d18bce in mysql_execute_command (thd=0x7fb9fc3eae60, first_level=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:2792
#28 0x0000000000d1aaad in mysql_parse (thd=0x7fb9fc3eae60, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5582
#29 0x0000000000d1bcca in dispatch_command (thd=0x7fb9fc3eae60, com_data=0x7fba5d8efda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:1458
#30 0x0000000000d1cb74 in do_command (thd=0x7fb9fc3eae60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:999
#31 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#32 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#33 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#34 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 103 (Thread 0x7fba4c0ac700 (LWP 13978)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f0012230, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f0017d90, buf=0x7fb9f0012230 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f03abaf8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f03abaf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f03abaf8, complen=0x7fba4c0abcf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f03abaf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f03ab398) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f03ab398, com_data=0x7fba4c0abda0, cmd=0x7fba4c0abdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f03aa340) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 102 (Thread 0x7fba3cf27700 (LWP 24842)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9eb337490, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9e081dd70, buf=0x7fb9eb337490 "14\033", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9e09df9a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9e09df9a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9e09df9a8, complen=0x7fba3cf26cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9e09df9a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9e09df248) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9e09df248, com_data=0x7fba3cf26da0, cmd=0x7fba3cf26dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9e09de1f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 101 (Thread 0x7fba3cea5700 (LWP 32356)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d0023390, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9d0070350, buf=0x7fb9d0023390 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d00139f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d00139f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d00139f8, complen=0x7fba3cea4cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d00139f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d0013298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d0013298, com_data=0x7fba3cea4da0, cmd=0x7fba3cea4dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d0012240) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 100 (Thread 0x7fba3ce23700 (LWP 32357)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d40356f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9d426d7d0, buf=0x7fb9d40356f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d4061ac8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d4061ac8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d4061ac8, complen=0x7fba3ce22cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d4061ac8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d4061368) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d4061368, com_data=0x7fba3ce22da0, cmd=0x7fba3ce22dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d4060310) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 99 (Thread 0x7fba3cda1700 (LWP 32358)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c8011770, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c805da60, buf=0x7fb9c8011770 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c800d918, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c800d918) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c800d918, complen=0x7fba3cda0cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c800d918) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c800d1b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c800d1b8, com_data=0x7fba3cda0da0, cmd=0x7fba3cda0dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c800c160) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 98 (Thread 0x7fba3cd1f700 (LWP 32359)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9cc0356f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9cc046820, buf=0x7fb9cc0356f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9cc048638, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9cc048638) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9cc048638, complen=0x7fba3cd1ecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9cc048638) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9cc047ed8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9cc047ed8, com_data=0x7fba3cd1eda0, cmd=0x7fba3cd1edcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9cc046e80) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 97 (Thread 0x7fba3cc9d700 (LWP 32360)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c000e9d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c004ad90, buf=0x7fb9c000e9d0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c0052838, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c0052838) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c0052838, complen=0x7fba3cc9ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c0052838) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c00520d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c00520d8, com_data=0x7fba3cc9cda0, cmd=0x7fba3cc9cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c0051080) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 96 (Thread 0x7fba3cc1b700 (LWP 32361)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c4023390, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c48b56c0, buf=0x7fb9c4023390 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c402b378, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c402b378) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c402b378, complen=0x7fba3cc1acf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c402b378) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c402ac18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c402ac18, com_data=0x7fba3cc1ada0, cmd=0x7fba3cc1adcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c4029bc0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 95 (Thread 0x7fba3cb99700 (LWP 32362)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9b803c900, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9b805eca0, buf=0x7fb9b803c900 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9b804e808, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9b804e808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9b804e808, complen=0x7fba3cb98cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9b804e808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9b804e0a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9b804e0a8, com_data=0x7fba3cb98da0, cmd=0x7fba3cb98dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9b804d050) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 94 (Thread 0x7fba3cb17700 (LWP 32363)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x28e9100, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x13479940, buf=0x28e9100 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x137f5ef8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x137f5ef8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x137f5ef8, complen=0x7fba3cb16cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x137f5ef8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x137f5798) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x137f5798, com_data=0x7fba3cb16da0, cmd=0x7fba3cb16dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x137f4740) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 93 (Thread 0x7fba3ca95700 (LWP 32364)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9b8037750, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9b804ad00, buf=0x7fb9b8037750 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9b8058668, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9b8058668) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9b8058668, complen=0x7fba3ca94cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9b8058668) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9b8057f08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9b8057f08, com_data=0x7fba3ca94da0, cmd=0x7fba3ca94dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9b8056eb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 92 (Thread 0x7fba3ca13700 (LWP 32365)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c4052ca0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c402d310, buf=0x7fb9c4052ca0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c401ac08, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c401ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c401ac08, complen=0x7fba3ca12cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c401ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c401a4a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c401a4a8, com_data=0x7fba3ca12da0, cmd=0x7fba3ca12dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c4019450) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 91 (Thread 0x7fba3c991700 (LWP 32366)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c003e960, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c0046820, buf=0x7fb9c003e960 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c0048868, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c0048868) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c0048868, complen=0x7fba3c990cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c0048868) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c0048108) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c0048108, com_data=0x7fba3c990da0, cmd=0x7fba3c990dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c00470b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 90 (Thread 0x7fba3c90f700 (LWP 32367)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9cc005ed0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9cc05fdc0, buf=0x7fb9cc005ed0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9cc002078, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9cc002078) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9cc002078, complen=0x7fba3c90ecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9cc002078) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9cc001918) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9cc001918, com_data=0x7fba3c90eda0, cmd=0x7fba3c90edcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9cc0008c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 89 (Thread 0x7fba3c88d700 (LWP 32368)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c8018a70, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c8046820, buf=0x7fb9c8018a70 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c80488e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c80488e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c80488e8, complen=0x7fba3c88ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c80488e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c8048188) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c8048188, com_data=0x7fba3c88cda0, cmd=0x7fba3c88cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c8047130) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 88 (Thread 0x7fba3c80b700 (LWP 32369)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d40008e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9d426bf80, buf=0x7fb9d40008e0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d40488c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d40488c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d40488c8, complen=0x7fba3c80acf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d40488c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d4048168) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d4048168, com_data=0x7fba3c80ada0, cmd=0x7fba3c80adcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d4047110) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 87 (Thread 0x7fba3c789700 (LWP 32370)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d0081c30, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9d004c400, buf=0x7fb9d0081c30 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d001ac08, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d001ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d001ac08, complen=0x7fba3c788cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d001ac08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d001a4a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d001a4a8, com_data=0x7fba3c788da0, cmd=0x7fba3c788dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d0019450) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 86 (Thread 0x7fba3c707700 (LWP 32371)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d8ad7470, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9e95ba600, buf=0x7fb9d8ad7470 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d88cdae8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d88cdae8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d88cdae8, complen=0x7fba3c706cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d88cdae8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d88cd388) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d88cd388, com_data=0x7fba3c706da0, cmd=0x7fba3c706dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d88cc330) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 85 (Thread 0x7fba3c685700 (LWP 32372)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f445f690, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f40390a0, buf=0x7fb9f445f690 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f4036c78, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f4036c78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f4036c78, complen=0x7fba3c684cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f4036c78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f4036518) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f4036518, com_data=0x7fba3c684da0, cmd=0x7fba3c684dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f40354c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 84 (Thread 0x7fba3c603700 (LWP 32373)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f0452740, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f03e7890, buf=0x7fb9f0452740 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f0516788, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f0516788) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f0516788, complen=0x7fba3c602cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f0516788) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f0516028) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f0516028, com_data=0x7fba3c602da0, cmd=0x7fba3c602dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f0514fd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 83 (Thread 0x7fba3c581700 (LWP 32379)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9fd3c75d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9fd3635d0, buf=0x7fb9fd3c75d0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9fc757fc8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9fc757fc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9fc757fc8, complen=0x7fba3c580cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9fc757fc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9fc757868) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9fc757868, com_data=0x7fba3c580da0, cmd=0x7fba3c580dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9fc756810) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 82 (Thread 0x7fba3c4ff700 (LWP 32380)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f8432550, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f83935c0, buf=0x7fb9f8432550 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f84f0128, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f84f0128) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f84f0128, complen=0x7fba3c4fecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f84f0128) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f84ef9c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f84ef9c8, com_data=0x7fba3c4feda0, cmd=0x7fba3c4fedcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f84ee970) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 81 (Thread 0x7fba3c47d700 (LWP 32381)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba04000930, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0524c940, buf=0x7fba04000930 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba040182a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba040182a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba040182a8, complen=0x7fba3c47ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba040182a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba04017b48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba04017b48, com_data=0x7fba3c47cda0, cmd=0x7fba3c47cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba04016af0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 80 (Thread 0x7fba3c3fb700 (LWP 32382)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba00027a60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0004cc00, buf=0x7fba00027a60 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba00036c78, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba00036c78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba00036c78, complen=0x7fba3c3facf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba00036c78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba00036518) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba00036518, com_data=0x7fba3c3fada0, cmd=0x7fba3c3fadcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba000354c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 79 (Thread 0x7fba3c379700 (LWP 32383)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba0c01bc60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0c00e010, buf=0x7fba0c01bc60 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba0c00f9c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba0c00f9c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba0c00f9c8, complen=0x7fba3c378cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba0c00f9c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba0c00f268) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba0c00f268, com_data=0x7fba3c378da0, cmd=0x7fba3c378dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba0c00e210) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 78 (Thread 0x7fba3c2f7700 (LWP 32384)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba0803b610, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba08039400, buf=0x7fba0803b610 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba080060a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba080060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba080060a8, complen=0x7fba3c2f6cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba080060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba08005948) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba08005948, com_data=0x7fba3c2f6da0, cmd=0x7fba3c2f6dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba080048f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 77 (Thread 0x7fba3c275700 (LWP 32385)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba140008e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba14031510, buf=0x7fba140008e0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba14036518, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba14036518) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba14036518, complen=0x7fba3c274cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba14036518) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba14035db8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba14035db8, com_data=0x7fba3c274da0, cmd=0x7fba3c274dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba14034d60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 76 (Thread 0x7fba3c1f3700 (LWP 32386)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba100008e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba10031510, buf=0x7fba100008e0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba10036518, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba10036518) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba10036518, complen=0x7fba3c1f2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba10036518) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba10035db8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba10035db8, com_data=0x7fba3c1f2da0, cmd=0x7fba3c1f2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba10034d60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 75 (Thread 0x7fba3c171700 (LWP 32387)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba1cd87d50, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba1cd7be00, buf=0x7fba1cd87d50 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba1cd7da88, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba1cd7da88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba1cd7da88, complen=0x7fba3c170cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba1cd7da88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba1cd7d328) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba1cd7d328, com_data=0x7fba3c170da0, cmd=0x7fba3c170dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba1cd7c2d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 74 (Thread 0x7fba3c0ef700 (LWP 32388)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba18009fe0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba18012040, buf=0x7fba18009fe0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba18002078, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba18002078) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba18002078, complen=0x7fba3c0eecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba18002078) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba18001918) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba18001918, com_data=0x7fba3c0eeda0, cmd=0x7fba3c0eedcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba180008c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 73 (Thread 0x7fb9effff700 (LWP 32389)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba240234b0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba2401e770, buf=0x7fba240234b0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba2403b678, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba2403b678) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba2403b678, complen=0x7fb9efffecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba2403b678) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba2403af18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba2403af18, com_data=0x7fb9efffeda0, cmd=0x7fb9efffedcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba24039ec0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 72 (Thread 0x7fb9eff7d700 (LWP 32390)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba200daa50, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba2003f320, buf=0x7fba200daa50 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba200d60c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba200d60c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba200d60c8, complen=0x7fb9eff7ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba200d60c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba200d5968) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba200d5968, com_data=0x7fb9eff7cda0, cmd=0x7fb9eff7cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba200d4910) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 71 (Thread 0x7fb9efefb700 (LWP 32391)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba2c019930, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba2c00c020, buf=0x7fba2c019930 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba2c0258e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba2c0258e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba2c0258e8, complen=0x7fb9efefacf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba2c0258e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba2c025188) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba2c025188, com_data=0x7fb9efefada0, cmd=0x7fb9efefadcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba2c024130) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 70 (Thread 0x7fb9efe79700 (LWP 32392)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba28028ed0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba28022cd0, buf=0x7fba28028ed0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba280469b8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba280469b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba280469b8, complen=0x7fb9efe78cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba280469b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba28046258) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba28046258, com_data=0x7fb9efe78da0, cmd=0x7fb9efe78dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba28045200) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 69 (Thread 0x7fb9efdf7700 (LWP 32393)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba34012270, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba34482890, buf=0x7fba34012270 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba34025468, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba34025468) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba34025468, complen=0x7fb9efdf6cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba34025468) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba34024d08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba34024d08, com_data=0x7fb9efdf6da0, cmd=0x7fb9efdf6dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba34023cb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 68 (Thread 0x7fb9efd75700 (LWP 32394)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba3001d810, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba30019930, buf=0x7fba3001d810 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba30027008, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba30027008) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba30027008, complen=0x7fb9efd74cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba30027008) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba300268a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba300268a8, com_data=0x7fb9efd74da0, cmd=0x7fb9efd74dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba30025850) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 67 (Thread 0x7fb9efcf3700 (LWP 32395)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba38022b00, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba3806d030, buf=0x7fba38022b00 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba3804d188, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba3804d188) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba3804d188, complen=0x7fb9efcf2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba3804d188) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba3804ca28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba3804ca28, com_data=0x7fb9efcf2da0, cmd=0x7fb9efcf2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba3804b9d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 66 (Thread 0x7fb9efc71700 (LWP 32396)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba44013890, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba44009fe0, buf=0x7fba44013890 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba4400b998, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba4400b998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba4400b998, complen=0x7fb9efc70cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba4400b998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba4400b238) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba4400b238, com_data=0x7fb9efc70da0, cmd=0x7fb9efc70dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba4400a1e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 65 (Thread 0x7fb9efbef700 (LWP 32397)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba40013890, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba40009fe0, buf=0x7fba40013890 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba4000b998, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba4000b998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba4000b998, complen=0x7fb9efbeecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba4000b998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba4000b238) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba4000b238, com_data=0x7fb9efbeeda0, cmd=0x7fb9efbeedcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba4000a1e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 64 (Thread 0x7fb9efb6d700 (LWP 32398)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba60013a30, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba6000a140, buf=0x7fba60013a30 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba6000baf8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba6000baf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba6000baf8, complen=0x7fb9efb6ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba6000baf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba6000b398) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba6000b398, com_data=0x7fb9efb6cda0, cmd=0x7fb9efb6cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba6000a340) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 63 (Thread 0x7fb9efaeb700 (LWP 32399)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba4801b4d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba480379a0, buf=0x7fba4801b4d0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba48025458, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba48025458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba48025458, complen=0x7fb9efaeacf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba48025458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba48024cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba48024cf8, com_data=0x7fb9efaeada0, cmd=0x7fb9efaeadcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba48023ca0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 62 (Thread 0x7fb9efa69700 (LWP 32400)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x137cba90, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x11fc02d0, buf=0x137cba90 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x137206c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x137206c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x137206c8, complen=0x7fb9efa68cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x137206c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x1371ff68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x1371ff68, com_data=0x7fb9efa68da0, cmd=0x7fb9efa68dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x1371ef10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 61 (Thread 0x7fb9ef9e7700 (LWP 32401)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9b80008e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9b805c8d0, buf=0x7fb9b80008e0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9b8025278, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9b8025278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9b8025278, complen=0x7fb9ef9e6cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9b8025278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9b8024b18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9b8024b18, com_data=0x7fb9ef9e6da0, cmd=0x7fb9ef9e6dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9b8023ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 60 (Thread 0x7fb9ef965700 (LWP 32402)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c4041d90, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c40505e0, buf=0x7fb9c4041d90 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c4058468, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c4058468) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c4058468, complen=0x7fb9ef964cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c4058468) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c4057d08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c4057d08, com_data=0x7fb9ef964da0, cmd=0x7fb9ef964dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c4056cb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 59 (Thread 0x7fb9ef8e3700 (LWP 32403)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c0004980, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c0054b90, buf=0x7fb9c0004980 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c0014198, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c0014198) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c0014198, complen=0x7fb9ef8e2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c0014198) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c0013a38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c0013a38, com_data=0x7fb9ef8e2da0, cmd=0x7fb9ef8e2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c00129e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 58 (Thread 0x7fb9ef861700 (LWP 32404)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9cc02d050, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9cc042d50, buf=0x7fb9cc02d050 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9cc052838, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9cc052838) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9cc052838, complen=0x7fb9ef860cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9cc052838) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9cc0520d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9cc0520d8, com_data=0x7fb9ef860da0, cmd=0x7fb9ef860dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9cc051080) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 57 (Thread 0x7fb9ef7df700 (LWP 32405)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c802d5d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c804aea0, buf=0x7fb9c802d5d0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c80060a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c80060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c80060a8, complen=0x7fb9ef7decf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c80060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c8005948) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c8005948, com_data=0x7fb9ef7deda0, cmd=0x7fb9ef7dedcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c80048f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 56 (Thread 0x7fb9ef75d700 (LWP 32406)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d4273c00, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9d404a6c0, buf=0x7fb9d4273c00 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d4050928, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d4050928) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d4050928, complen=0x7fb9ef75ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d4050928) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d40501c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d40501c8, com_data=0x7fb9ef75cda0, cmd=0x7fb9ef75cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d404f170) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 55 (Thread 0x7fb9ef6db700 (LWP 32407)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d003bd00, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9d0011ab0, buf=0x7fb9d003bd00 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d00873f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d00873f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d00873f8, complen=0x7fb9ef6dacf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d00873f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d0086c98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d0086c98, com_data=0x7fb9ef6dada0, cmd=0x7fb9ef6dadcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d0085c40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 54 (Thread 0x7fb9ef659700 (LWP 32408)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9e8e4bcb0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9e1515260, buf=0x7fb9e8e4bcb0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d931bdd8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d931bdd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d931bdd8, complen=0x7fb9ef658cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d931bdd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d931b678) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d931b678, com_data=0x7fb9ef658da0, cmd=0x7fb9ef658dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d931a620) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 53 (Thread 0x7fb9ef5d7700 (LWP 32409)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f4487c60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f404e050, buf=0x7fb9f4487c60 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f446f788, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f446f788) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f446f788, complen=0x7fb9ef5d6cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f446f788) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f446f028) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f446f028, com_data=0x7fb9ef5d6da0, cmd=0x7fb9ef5d6dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f446dfd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 52 (Thread 0x7fb9ef555700 (LWP 32410)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f04f5870, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f0459650, buf=0x7fb9f04f5870 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f055b458, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f055b458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f055b458, complen=0x7fb9ef554cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f055b458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f055acf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f055acf8, com_data=0x7fb9ef554da0, cmd=0x7fb9ef554dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f0559ca0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 51 (Thread 0x7fb9ef4d3700 (LWP 32411)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9fd3ebfe0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9fd31c830, buf=0x7fb9fd3ebfe0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9fd40d858, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9fd40d858) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9fd40d858, complen=0x7fb9ef4d2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9fd40d858) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9fd40d0f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9fd40d0f8, com_data=0x7fb9ef4d2da0, cmd=0x7fb9ef4d2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9fd40c0a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 50 (Thread 0x7fb9ef451700 (LWP 32412)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f858c370, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f850b830, buf=0x7fb9f858c370 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f8584808, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f8584808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f8584808, complen=0x7fb9ef450cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f8584808) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f85840a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f85840a8, com_data=0x7fb9ef450da0, cmd=0x7fb9ef450dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f8583050) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 49 (Thread 0x7fb9ef3cf700 (LWP 32413)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba045ccdf0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0523f530, buf=0x7fba045ccdf0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba04877ca8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba04877ca8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba04877ca8, complen=0x7fb9ef3cecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba04877ca8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba04877548) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba04877548, com_data=0x7fb9ef3ceda0, cmd=0x7fb9ef3cedcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba048764f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 48 (Thread 0x7fb9ef34d700 (LWP 32414)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba00016a20, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba00009620, buf=0x7fba00016a20 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba00004098, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba00004098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba00004098, complen=0x7fb9ef34ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba00004098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba00003938) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba00003938, com_data=0x7fb9ef34cda0, cmd=0x7fb9ef34cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba000028e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 47 (Thread 0x7fb9ef2cb700 (LWP 32415)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba0c009fe0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0c012040, buf=0x7fba0c009fe0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba0c002078, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba0c002078) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba0c002078, complen=0x7fb9ef2cacf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba0c002078) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba0c001918) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba0c001918, com_data=0x7fb9ef2cada0, cmd=0x7fb9ef2cadcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba0c0008c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 46 (Thread 0x7fb9ef249700 (LWP 32416)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba0802aed0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0802a960, buf=0x7fba0802aed0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba08036c78, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba08036c78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba08036c78, complen=0x7fb9ef248cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba08036c78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba08036518) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba08036518, com_data=0x7fb9ef248da0, cmd=0x7fb9ef248dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba080354c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 45 (Thread 0x7fb9ef1c7700 (LWP 32417)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba14010a10, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba14039370, buf=0x7fba14010a10 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba140060a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba140060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba140060a8, complen=0x7fb9ef1c6cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba140060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba14005948) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba14005948, com_data=0x7fb9ef1c6da0, cmd=0x7fb9ef1c6dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba140048f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 44 (Thread 0x7fb9ef145700 (LWP 32418)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba10010a10, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba10039370, buf=0x7fba10010a10 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba100060a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba100060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba100060a8, complen=0x7fb9ef144cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba100060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba10005948) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba10005948, com_data=0x7fb9ef144da0, cmd=0x7fb9ef144dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba100048f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 43 (Thread 0x7fb9ef0c3700 (LWP 32422)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba1cd94040, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba1ce4c900, buf=0x7fba1cd94040 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba1ce4a2c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba1ce4a2c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba1ce4a2c8, complen=0x7fb9ef0c2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba1ce4a2c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba1ce49b68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba1ce49b68, com_data=0x7fb9ef0c2da0, cmd=0x7fb9ef0c2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba1ce48b10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 42 (Thread 0x7fb9ef041700 (LWP 32423)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba1801bc60, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba1800e010, buf=0x7fba1801bc60 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba1800f9c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba1800f9c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba1800f9c8, complen=0x7fb9ef040cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba1800f9c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba1800f268) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba1800f268, com_data=0x7fb9ef040da0, cmd=0x7fb9ef040dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba1800e210) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 41 (Thread 0x7fb9eefbf700 (LWP 32426)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba24041d70, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba240274e0, buf=0x7fba24041d70 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba2402d588, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba2402d588) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba2402d588, complen=0x7fb9eefbecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba2402d588) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba2402ce28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba2402ce28, com_data=0x7fb9eefbeda0, cmd=0x7fb9eefbedcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba2402bdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7fb9eef3d700 (LWP 32427)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba200a21f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba200cf3f0, buf=0x7fba200a21f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba200e0218, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba200e0218) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba200e0218, complen=0x7fb9eef3ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba200e0218) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba200dfab8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba200dfab8, com_data=0x7fb9eef3cda0, cmd=0x7fb9eef3cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba200dea60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 39 (Thread 0x7fb9eeebb700 (LWP 32428)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba2c00c2a0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba2c0176e0, buf=0x7fba2c00c2a0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba2c005d78, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba2c005d78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba2c005d78, complen=0x7fb9eeebacf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba2c005d78) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba2c005618) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba2c005618, com_data=0x7fb9eeebada0, cmd=0x7fb9eeebadcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba2c0045c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 38 (Thread 0x7fb9eee39700 (LWP 32429)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba2801b4f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba28048ee0, buf=0x7fba2801b4f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba2802e698, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba2802e698) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba2802e698, complen=0x7fb9eee38cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba2802e698) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba2802df38) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba2802df38, com_data=0x7fb9eee38da0, cmd=0x7fb9eee38dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba2802cee0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7fb9eedb7700 (LWP 32430)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba34019480, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba34477240, buf=0x7fba34019480 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba340040d8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba340040d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba340040d8, complen=0x7fb9eedb6cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba340040d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba34003978) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba34003978, com_data=0x7fb9eedb6da0, cmd=0x7fb9eedb6dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba34002920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 36 (Thread 0x7fb9eed35700 (LWP 32431)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba3002fe90, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba30029620, buf=0x7fba3002fe90 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba30013eb8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba30013eb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba30013eb8, complen=0x7fb9eed34cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba30013eb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba30013758) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba30013758, com_data=0x7fb9eed34da0, cmd=0x7fb9eed34dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba30012700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7fb9eecb3700 (LWP 32432)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba3801d950, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba3806a800, buf=0x7fba3801d950 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba38074c28, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba38074c28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba38074c28, complen=0x7fb9eecb2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba38074c28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba380744c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba380744c8, com_data=0x7fb9eecb2da0, cmd=0x7fb9eecb2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba38073470) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7fb9eec31700 (LWP 32433)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba440252f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba440178c0, buf=0x7fba440252f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba44019278, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba44019278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba44019278, complen=0x7fb9eec30cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba44019278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba44018b18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba44018b18, com_data=0x7fb9eec30da0, cmd=0x7fb9eec30dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba44017ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7fb9eebaf700 (LWP 32434)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba400252f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba400178c0, buf=0x7fba400252f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba40019278, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba40019278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba40019278, complen=0x7fb9eebaecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba40019278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba40018b18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba40018b18, com_data=0x7fb9eebaeda0, cmd=0x7fb9eebaedcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba40017ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7fb9eeb2d700 (LWP 32435)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba60025490, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba60017a60, buf=0x7fba60025490 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba60019418, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba60019418) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba60019418, complen=0x7fb9eeb2ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba60019418) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba60018cb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba60018cb8, com_data=0x7fb9eeb2cda0, cmd=0x7fb9eeb2cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba60017c60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7fb9eeaab700 (LWP 32439)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba4802fc70, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba48027ac0, buf=0x7fba4802fc70 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba480139f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba480139f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba480139f8, complen=0x7fb9eeaaacf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba480139f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba48013298) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba48013298, com_data=0x7fb9eeaaada0, cmd=0x7fb9eeaaadcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba48012240) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7fb9eea29700 (LWP 32440)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x1375b8a0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x13682030, buf=0x1375b8a0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x13820828, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x13820828) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x13820828, complen=0x7fb9eea28cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x13820828) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x138200c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x138200c8, com_data=0x7fb9eea28da0, cmd=0x7fb9eea28dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x1381f070) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7fb9ee9a7700 (LWP 32441)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9b8010a10, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9b8094f40, buf=0x7fb9b8010a10 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9b80060a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9b80060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9b80060a8, complen=0x7fb9ee9a6cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9b80060a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9b8005948) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9b8005948, com_data=0x7fb9ee9a6da0, cmd=0x7fb9ee9a6dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9b80048f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7fb9ee925700 (LWP 32442)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c40008e0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c405cc20, buf=0x7fb9c40008e0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c402f3a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c402f3a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c402f3a8, complen=0x7fb9ee924cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c402f3a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c402ec48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c402ec48, com_data=0x7fb9ee924da0, cmd=0x7fb9ee924dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c402dbf0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7fb9ee8a3700 (LWP 32443)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c005fb00, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c00166a0, buf=0x7fb9c005fb00 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c000a148, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c000a148) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c000a148, complen=0x7fb9ee8a2cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c000a148) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c00099e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c00099e8, com_data=0x7fb9ee8a2da0, cmd=0x7fb9ee8a2dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c0008990) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7fb9ee821700 (LWP 32444)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9cc074ac0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9cc04a800, buf=0x7fb9cc074ac0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9cc0400f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9cc0400f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9cc0400f8, complen=0x7fb9ee820cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9cc0400f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9cc03f998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9cc03f998, com_data=0x7fb9ee820da0, cmd=0x7fb9ee820dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9cc03e940) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7fb9ee79f700 (LWP 32445)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9c8021630, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9c8018460, buf=0x7fb9c8021630 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9c8032d98, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9c8032d98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9c8032d98, complen=0x7fb9ee79ecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9c8032d98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9c8032638) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9c8032638, com_data=0x7fb9ee79eda0, cmd=0x7fb9ee79edcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9c80315e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7fb9ee71d700 (LWP 32446)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d402ea10, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9d426ba90, buf=0x7fb9d402ea10 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d420e278, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d420e278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d420e278, complen=0x7fb9ee71ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d420e278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d420db18) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d420db18, com_data=0x7fb9ee71cda0, cmd=0x7fb9ee71cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d420cac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7fb9ee69b700 (LWP 32450)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9d0031cb0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9d0027b60, buf=0x7fb9d0031cb0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d00414c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d00414c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d00414c8, complen=0x7fb9ee69acf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d00414c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d0040d68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d0040d68, com_data=0x7fb9ee69ada0, cmd=0x7fb9ee69adcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d003fd10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x1369cfb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7fb9ee619700 (LWP 32451)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9e1736fa0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9e12cf5b0, buf=0x7fb9e1736fa0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9d9540c98, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9d9540c98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9d9540c98, complen=0x7fb9ee618cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9d9540c98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9d9540538) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9d9540538, com_data=0x7fb9ee618da0, cmd=0x7fb9ee618dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9d953f4e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x13733f00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7fb9ee597700 (LWP 32452)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f40089b0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f4480d10, buf=0x7fb9f40089b0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f448d428, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f448d428) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f448d428, complen=0x7fb9ee596cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f448d428) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f448ccc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f448ccc8, com_data=0x7fb9ee596da0, cmd=0x7fb9ee596dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f448bc70) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x136a8190) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7fb9ee515700 (LWP 32453)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f03a18b0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f051bf00, buf=0x7fb9f03a18b0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f003a2a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f003a2a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f003a2a8, complen=0x7fb9ee514cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f003a2a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f0039b48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f0039b48, com_data=0x7fb9ee514da0, cmd=0x7fb9ee514dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f0038af0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x1369cfb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7fb9ee493700 (LWP 32454)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9fd4160a0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9fd3a1fb0, buf=0x7fb9fd4160a0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9fd3f17a8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9fd3f17a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9fd3f17a8, complen=0x7fb9ee492cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9fd3f17a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9fd3f1048) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9fd3f1048, com_data=0x7fb9ee492da0, cmd=0x7fb9ee492dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9fd3efff0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x13733f00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7fb9ee411700 (LWP 32455)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fb9f80370c0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fb9f8438710, buf=0x7fb9f80370c0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fb9f83c6e98, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fb9f83c6e98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fb9f83c6e98, complen=0x7fb9ee410cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fb9f83c6e98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fb9f83c6738) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fb9f83c6738, com_data=0x7fb9ee410da0, cmd=0x7fb9ee410dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fb9f83c56e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x136a8190) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7fb9ee38f700 (LWP 32456)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba045dceb0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0526e9f0, buf=0x7fba045dceb0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba045d65e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba045d65e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba045d65e8, complen=0x7fb9ee38ecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba045d65e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba045d5e88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba045d5e88, com_data=0x7fb9ee38eda0, cmd=0x7fb9ee38edcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba045d4e30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x1369cfb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7fb9ee30d700 (LWP 32457)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba00453600, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0000a450, buf=0x7fba00453600 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba0001c1e8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba0001c1e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba0001c1e8, complen=0x7fb9ee30ccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba0001c1e8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba0001ba88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba0001ba88, com_data=0x7fb9ee30cda0, cmd=0x7fb9ee30cdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba0001aa30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x13733f00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7fb9ee28b700 (LWP 32461)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba0c02d690, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba0c01fc90, buf=0x7fba0c02d690 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba0c021648, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba0c021648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba0c021648, complen=0x7fb9ee28acf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba0c021648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba0c020ee8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba0c020ee8, com_data=0x7fb9ee28ada0, cmd=0x7fb9ee28adcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba0c01fe90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x136a8190) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7fb9ee209700 (LWP 32462)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba08025260, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba080315b0, buf=0x7fba08025260 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba08040dd8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba08040dd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba08040dd8, complen=0x7fb9ee208cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba08040dd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba08040678) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba08040678, com_data=0x7fb9ee208da0, cmd=0x7fb9ee208dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba0803f620) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x1369cfb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7fb9ee187700 (LWP 32463)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba14022270, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba14014a40, buf=0x7fba14022270 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba140163f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba140163f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba140163f8, complen=0x7fb9ee186cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba140163f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba14015c98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba14015c98, com_data=0x7fb9ee186da0, cmd=0x7fb9ee186dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba14014c40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x13733f00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7fb9ee105700 (LWP 32464)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba10022270, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba10014a40, buf=0x7fba10022270 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba100163f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba100163f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba100163f8, complen=0x7fb9ee104cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba100163f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba10015c98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba10015c98, com_data=0x7fb9ee104da0, cmd=0x7fb9ee104dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba10014c40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x136a8190) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7fb9ee083700 (LWP 32465)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba1d153da0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba1cd52ab0, buf=0x7fba1d153da0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba1cd56b58, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba1cd56b58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba1cd56b58, complen=0x7fb9ee082cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba1cd56b58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba1cd563f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba1cd563f8, com_data=0x7fb9ee082da0, cmd=0x7fb9ee082dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba1cd553a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x1369cfb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7fb9ee001700 (LWP 32466)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba1802d690, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba1801fc90, buf=0x7fba1802d690 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba18021648, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba18021648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba18021648, complen=0x7fb9ee000cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba18021648) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba18020ee8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba18020ee8, com_data=0x7fb9ee000da0, cmd=0x7fb9ee000dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba1801fe90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x13733f00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7fb9edf7f700 (LWP 32467)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba24006970, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba2402f820, buf=0x7fba24006970 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba24047538, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba24047538) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba24047538, complen=0x7fb9edf7ecf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba24047538) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba24046dd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba24046dd8, com_data=0x7fb9edf7eda0, cmd=0x7fb9edf7edcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba24045d80) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x136a8190) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7fb9edefd700 (LWP 32468)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba200b3ac0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba200a6220, buf=0x7fba200b3ac0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba200a7bd8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba200a7bd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba200a7bd8, complen=0x7fb9edefccf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba200a7bd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba200a7478) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba200a7478, com_data=0x7fb9edefcda0, cmd=0x7fb9edefcdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba200a6420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x1369cfb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7fb9ede7b700 (LWP 32594)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba2c02f8a0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba2c022110, buf=0x7fba2c02f8a0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba2c029a08, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba2c029a08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba2c029a08, complen=0x7fb9ede7acf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba2c029a08) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba2c0292a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba2c0292a8, com_data=0x7fb9ede7ada0, cmd=0x7fb9ede7adcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba2c028250) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x13733f00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7fb9eddf9700 (LWP 32635)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba280411f0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba2803af90, buf=0x7fba280411f0 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba28034798, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba28034798) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba28034798, complen=0x7fb9eddf8cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba28034798) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba28034038) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba28034038, com_data=0x7fb9eddf8da0, cmd=0x7fb9eddf8dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba28032fe0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x136a8190) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7fb9edd77700 (LWP 32636)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba340384d0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba34022900, buf=0x7fba340384d0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba340315f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba340315f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba340315f8, complen=0x7fb9edd76cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba340315f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba34030e98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba34030e98, com_data=0x7fb9edd76da0, cmd=0x7fb9edd76dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba3402fe40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x1369cfb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7fb9edcf5700 (LWP 32659)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba3003fce0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba30025560, buf=0x7fba3003fce0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba30037e68, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba30037e68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba30037e68, complen=0x7fb9edcf4cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba30037e68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba30037708) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba30037708, com_data=0x7fb9edcf4da0, cmd=0x7fb9edcf4dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba300366b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x13733f00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7fb9edc73700 (LWP 32750)):
#0  0x00007fbccef3daeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012be640 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7fba380479c0, mysql_socket=..., src_line=123, src_file=0x163a800 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7fba3803b4f0, buf=0x7fba380479c0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:123
#3  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7fba380416f8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#4  0x0000000000c6d55b in net_read_packet_header (net=0x7fba380416f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#5  net_read_packet (net=0x7fba380416f8, complen=0x7fb9edc72cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#6  0x0000000000c6d80c in my_net_read (net=0x7fba380416f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#7  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7fba38040f98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#8  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7fba38040f98, com_data=0x7fb9edc72da0, cmd=0x7fb9edc72dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#9  0x0000000000d1ca77 in do_command (thd=0x7fba3803ff40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#10 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#11 0x0000000001256a94 in pfs_spawn_thread (arg=0x132021f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#12 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7fb9edbf1700 (LWP 846)):
#0  0x00007fbccef3dd7d in fsync () from /lib64/libpthread.so.0
#1  0x0000000000ff5610 in os_file_fsync_posix (file=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:3055
#2  os_file_flush_func (file=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:3170
#3  0x000000000118d8f9 in pfs_os_file_flush_func (src_line=5992, file=..., src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/os0file.ic:505
#4  fil_flush (space_id=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5992
#5  0x0000000000fd4af2 in log_write_flush_to_disk_low () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1156
#6  0x0000000000fd5c29 in log_write_up_to (lsn=<optimized out>, flush_to_disk=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1406
#7  0x00000000010d1b2d in trx_flush_log_if_needed_low (lsn=148036255452) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:1794
#8  trx_flush_log_if_needed (trx=0x7fbcc2ebb790, lsn=148036255452) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:1816
#9  trx_commit_in_memory (serialised=<optimized out>, mtr=<optimized out>, trx=0x7fbcc2ebb790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2043
#10 trx_commit_low (trx=0x7fbcc2ebb790, mtr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2180
#11 0x00000000010d1d34 in trx_commit (trx=0x7fbcc2ebb790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2204
#12 0x00000000010d3627 in trx_commit_for_mysql (trx=0x7fbcc2ebb790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2423
#13 0x0000000001176bac in dict_stats_exec_sql (pinfo=<optimized out>, sql=0x161f450 "PROCEDURE DELETE_FROM_INDEX_STATS () IS\nBEGIN\nDELETE FROM \"mysql/innodb_index_stats\" WHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nEND;\n", trx=0x7fbcc2ebb790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:324
#14 0x0000000001176ffb in dict_stats_drop_table (db_and_table=<optimized out>, errstr=0x7fb9edbeb580 "", errstr_sz=1024) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:3465
#15 0x0000000001050338 in row_drop_table_for_mysql (name=0x7fb9edbec720 "sbtest/table_clublogscore20111221", trx=0x7fbcc2ebb400, drop_db=true, nonatomic=<optimized out>, handler=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0mysql.cc:4341
#16 0x0000000000f883c2 in ha_innobase::delete_table (this=<optimized out>, name=0x7fb9edbedb30 "./sbtest/table_clublogscore20111221") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:12539
#17 0x000000000081e6d8 in ha_delete_table (thd=0x7fba44029300, table_type=<optimized out>, path=0x7fb9edbedb30 "./sbtest/table_clublogscore20111221", db=0x7fba441ae070 "sbtest", alias=0x7fba441ae077 "table_clublogscore20111221", generate_warning=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/handler.cc:2586
#18 0x0000000000d7f6fd in mysql_rm_table_no_locks (thd=0x7fba44029300, tables=0x7fba44062ee0, if_exists=true, drop_temporary=false, drop_view=true, dont_log_query=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_table.cc:2546
#19 0x0000000000cdf397 in mysql_rm_db (thd=0x7fba44029300, db=..., if_exists=<optimized out>, silent=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_db.cc:865
#20 0x0000000000d1a2e5 in mysql_execute_command (thd=0x7fba44029300, first_level=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:3818
#21 0x0000000000d1aaad in mysql_parse (thd=0x7fba44029300, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5582
#22 0x0000000000d1bcca in dispatch_command (thd=0x7fba44029300, com_data=0x7fb9edbf0da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:1458
#23 0x0000000000d1cb74 in do_command (thd=0x7fba44029300) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:999
#24 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#25 0x0000000001256a94 in pfs_spawn_thread (arg=0x12de9700) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#26 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
#27 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7fbccf35c780 (LWP 12496)):
#0  0x00007fbccd9e4c3d in poll () from /lib64/libc.so.6
#1  0x0000000000deee39 in Mysqld_socket_listener::listen_for_connection_event (this=0x121347f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cb384 in connection_event_loop (this=0x13658b20) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=115, argv=0x27a8208) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:5132
#4  0x00007fbccd913555 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c0ed9 in _start ()
