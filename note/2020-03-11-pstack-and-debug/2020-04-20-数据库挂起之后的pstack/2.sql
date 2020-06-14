
timer_notify_thread_func
	Thread 60 (Thread 0x7f9eeb65b700 (LWP 3033)):
	#0  0x00007f9ef358247a in sigwaitinfo () from /lib64/libc.so.6
	#1  0x0000000000f5299b in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/mysys/posix_timers.c:77
	#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x28f0010) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#3  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#4  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

os_aio_linux_handler
	Thread 59 (Thread 0x7f9d4b656700 (LWP 3035)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4b655dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4b655dd0, m1=0x7f9d4b655e88, m2=0x7f9d4b655e80, request=0x7f9d4b655e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4b655e50, m2=0x7f9d4b655e80, m1=0x7f9d4b655e88, global_segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=0, m1=0x7f9d4b655e88, m2=0x7f9d4b655e80, request=0x7f9d4b655e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 58 (Thread 0x7f9d4ae55700 (LWP 3036)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4ae54dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4ae54dd0, m1=0x7f9d4ae54e88, m2=0x7f9d4ae54e80, request=0x7f9d4ae54e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4ae54e50, m2=0x7f9d4ae54e80, m1=0x7f9d4ae54e88, global_segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=1, m1=0x7f9d4ae54e88, m2=0x7f9d4ae54e80, request=0x7f9d4ae54e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 57 (Thread 0x7f9d4a654700 (LWP 3037)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4a653dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4a653dd0, m1=0x7f9d4a653e88, m2=0x7f9d4a653e80, request=0x7f9d4a653e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4a653e50, m2=0x7f9d4a653e80, m1=0x7f9d4a653e88, global_segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=2, m1=0x7f9d4a653e88, m2=0x7f9d4a653e80, request=0x7f9d4a653e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 56 (Thread 0x7f9d49e53700 (LWP 3038)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d49e52dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d49e52dd0, m1=0x7f9d49e52e88, m2=0x7f9d49e52e80, request=0x7f9d49e52e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d49e52e50, m2=0x7f9d49e52e80, m1=0x7f9d49e52e88, global_segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=3, m1=0x7f9d49e52e88, m2=0x7f9d49e52e80, request=0x7f9d49e52e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 55 (Thread 0x7f9d49652700 (LWP 3039)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d49651dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d49651dd0, m1=0x7f9d49651e88, m2=0x7f9d49651e80, request=0x7f9d49651e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d49651e50, m2=0x7f9d49651e80, m1=0x7f9d49651e88, global_segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=4, m1=0x7f9d49651e88, m2=0x7f9d49651e80, request=0x7f9d49651e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 54 (Thread 0x7f9d48e51700 (LWP 3040)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d48e50dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d48e50dd0, m1=0x7f9d48e50e88, m2=0x7f9d48e50e80, request=0x7f9d48e50e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d48e50e50, m2=0x7f9d48e50e80, m1=0x7f9d48e50e88, global_segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=5, m1=0x7f9d48e50e88, m2=0x7f9d48e50e80, request=0x7f9d48e50e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 53 (Thread 0x7f9d48650700 (LWP 3041)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4864fdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4864fdd0, m1=0x7f9d4864fe88, m2=0x7f9d4864fe80, request=0x7f9d4864fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4864fe50, m2=0x7f9d4864fe80, m1=0x7f9d4864fe88, global_segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=6, m1=0x7f9d4864fe88, m2=0x7f9d4864fe80, request=0x7f9d4864fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 52 (Thread 0x7f9d47e4f700 (LWP 3042)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d47e4edd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d47e4edd0, m1=0x7f9d47e4ee88, m2=0x7f9d47e4ee80, request=0x7f9d47e4ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d47e4ee50, m2=0x7f9d47e4ee80, m1=0x7f9d47e4ee88, global_segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=7, m1=0x7f9d47e4ee88, m2=0x7f9d47e4ee80, request=0x7f9d47e4ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 51 (Thread 0x7f9d4764e700 (LWP 3043)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4764ddd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4764ddd0, m1=0x7f9d4764de88, m2=0x7f9d4764de80, request=0x7f9d4764de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4764de50, m2=0x7f9d4764de80, m1=0x7f9d4764de88, global_segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=8, m1=0x7f9d4764de88, m2=0x7f9d4764de80, request=0x7f9d4764de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 50 (Thread 0x7f9d46e4d700 (LWP 3044)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d46e4cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d46e4cdd0, m1=0x7f9d46e4ce88, m2=0x7f9d46e4ce80, request=0x7f9d46e4ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d46e4ce50, m2=0x7f9d46e4ce80, m1=0x7f9d46e4ce88, global_segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=9, m1=0x7f9d46e4ce88, m2=0x7f9d46e4ce80, request=0x7f9d46e4ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 49 (Thread 0x7f9d4664c700 (LWP 3045)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4664bdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4664bdd0, m1=0x7f9d4664be88, m2=0x7f9d4664be80, request=0x7f9d4664be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4664be50, m2=0x7f9d4664be80, m1=0x7f9d4664be88, global_segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=10, m1=0x7f9d4664be88, m2=0x7f9d4664be80, request=0x7f9d4664be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 48 (Thread 0x7f9d45e4b700 (LWP 3046)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d45e4add0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d45e4add0, m1=0x7f9d45e4ae88, m2=0x7f9d45e4ae80, request=0x7f9d45e4ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d45e4ae50, m2=0x7f9d45e4ae80, m1=0x7f9d45e4ae88, global_segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=11, m1=0x7f9d45e4ae88, m2=0x7f9d45e4ae80, request=0x7f9d45e4ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 47 (Thread 0x7f9d4564a700 (LWP 3047)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d45649dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d45649dd0, m1=0x7f9d45649e88, m2=0x7f9d45649e80, request=0x7f9d45649e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d45649e50, m2=0x7f9d45649e80, m1=0x7f9d45649e88, global_segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=12, m1=0x7f9d45649e88, m2=0x7f9d45649e80, request=0x7f9d45649e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 46 (Thread 0x7f9d44e49700 (LWP 3048)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d44e48dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d44e48dd0, m1=0x7f9d44e48e88, m2=0x7f9d44e48e80, request=0x7f9d44e48e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d44e48e50, m2=0x7f9d44e48e80, m1=0x7f9d44e48e88, global_segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=13, m1=0x7f9d44e48e88, m2=0x7f9d44e48e80, request=0x7f9d44e48e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 45 (Thread 0x7f9d44648700 (LWP 3049)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d44647dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d44647dd0, m1=0x7f9d44647e88, m2=0x7f9d44647e80, request=0x7f9d44647e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d44647e50, m2=0x7f9d44647e80, m1=0x7f9d44647e88, global_segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=14, m1=0x7f9d44647e88, m2=0x7f9d44647e80, request=0x7f9d44647e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 44 (Thread 0x7f9d43e47700 (LWP 3050)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d43e46dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d43e46dd0, m1=0x7f9d43e46e88, m2=0x7f9d43e46e80, request=0x7f9d43e46e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d43e46e50, m2=0x7f9d43e46e80, m1=0x7f9d43e46e88, global_segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=15, m1=0x7f9d43e46e88, m2=0x7f9d43e46e80, request=0x7f9d43e46e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 43 (Thread 0x7f9d43646700 (LWP 3051)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d43645dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d43645dd0, m1=0x7f9d43645e88, m2=0x7f9d43645e80, request=0x7f9d43645e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d43645e50, m2=0x7f9d43645e80, m1=0x7f9d43645e88, global_segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=16, m1=0x7f9d43645e88, m2=0x7f9d43645e80, request=0x7f9d43645e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 42 (Thread 0x7f9d42e45700 (LWP 3052)):
	#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
	#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d42e44dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
	#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d42e44dd0, m1=0x7f9d42e44e88, m2=0x7f9d42e44e80, request=0x7f9d42e44e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
	#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d42e44e50, m2=0x7f9d42e44e80, m1=0x7f9d42e44e88, global_segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
	#4  os_aio_handler (segment=17, m1=0x7f9d42e44e88, m2=0x7f9d42e44e80, request=0x7f9d42e44e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
	#5  0x000000000118a7cd in fil_aio_wait (segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
	#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6



buf_flush_page_cleaner_coordinator
	Thread 41 (Thread 0x7f9d42644700 (LWP 3053)):
	#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d426439a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2925138, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x0000000001139d13 in pc_sleep_if_needed (sig_count=2, next_loop_time=1587350490954) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:2690
	#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3191
	#5  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#6  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

buf_flush_page_cleaner_worker
	Thread 40 (Thread 0x7f9d41e43700 (LWP 3054)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0xce80de8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0xce80de8, reset_sig_count=102) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 39 (Thread 0x7f9d41642700 (LWP 3055)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0xce80de8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0xce80de8, reset_sig_count=102) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 38 (Thread 0x7f9d40e41700 (LWP 3056)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0xce80de8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0xce80de8, reset_sig_count=102) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

lock_wait_timeout_thread
	Thread 37 (Thread 0x7f9d3bfff700 (LWP 3063)):
	#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d3bffedb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0xce7dce8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x0000000000fd2494 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/lock/lock0wait.cc:501
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

srv_error_monitor_thread
	Thread 36 (Thread 0x7f9d54795700 (LWP 3064)):
	#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d54794ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2924f88, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x0000000001095505 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1751
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

srv_monitor_thread
	Thread 35 (Thread 0x7f9d53f94700 (LWP 3065)):
	#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d53f93e30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2925018, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x0000000001094595 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1585
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

srv_master_sleep
	Thread 34 (Thread 0x7f9d53793700 (LWP 3066)):
	#0  0x00007f9ef4b97f3d in nanosleep () from /lib64/libpthread.so.0
	#1  0x0000000000ffb7a0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0thread.cc:279
	#2  0x0000000001094bbb in srv_master_sleep () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2330
	#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2377
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

srv_purge_coordinator_suspend
	Thread 33 (Thread 0x7f9d52f92700 (LWP 3067)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x2924d48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x2924d48, reset_sig_count=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x000000000109659d in srv_purge_coordinator_suspend (rseg_history_len=28, slot=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2676
	#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2792
	#5  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#6  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

srv_worker_thread
	Thread 32 (Thread 0x7f9d52791700 (LWP 3068)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x2924ef8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x2924ef8, reset_sig_count=61) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 31 (Thread 0x7f9d51f90700 (LWP 3069)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x2924dd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x2924dd8, reset_sig_count=62) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 30 (Thread 0x7f9d5178f700 (LWP 3070)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x2924e68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x2924e68, reset_sig_count=61) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6


buf_dump_thread
	Thread 29 (Thread 0x7f9d50f8e700 (LWP 3071)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x29250a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x29250a8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x00000000011335bc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0dump.cc:782
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

dict_stats_thread
	Thread 28 (Thread 0x7f9d5078d700 (LWP 3072)):
	#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d5078cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0xcea5708, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x000000000117c887 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats_bg.cc:428
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

ib_wqueue_timedwait-fts_optimize_thread
	Thread 27 (Thread 0x7f9d4ff8c700 (LWP 3073)):
	#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d4ff8b950) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
	#2  0x0000000000ffb50e in os_event::wait_time_low (this=0xcf1e0d8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
	#3  0x00000000010e63d4 in ib_wqueue_timedwait (wq=0xcf46688, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/ut/ut0wqueue.cc:160
	#4  0x00000000011c543a in fts_optimize_thread (arg=0xcf46688) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fts/fts0opt.cc:3031
	#5  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#6  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

buf_resize_thread
	Thread 26 (Thread 0x7f9d4f78b700 (LWP 3074)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ffb03b in wait (this=0x29251c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
	#2  os_event::wait_low (this=0x29251c8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
	#3  0x0000000001129a6c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0buf.cc:3019
	#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

pfs_spawn_thread
	Thread 25 (Thread 0x7f9d4e6bc700 (LWP 3077)):
	#0  0x00007f9ef4b98461 in sigwait () from /lib64/libpthread.so.0
	#1  0x00000000007c5eeb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:2120
	#2  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#3  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#4  0x00007f9ef3649bad in clone () from /lib64/libc.so.6

compress_gtid_table
	Thread 24 (Thread 0x7f9d39fac700 (LWP 3078)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ebee55 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
	#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
	#3  inline_mysql_cond_wait (src_line=874, src_file=0x15e0220 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
	#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc:874
	#5  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#6  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#7  0x00007f9ef3649bad in clone () from /lib64/libc.so.6


net_read_packet
	
	Thread 23 (Thread 0x7f9d4e63a700 (LWP 3080)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d200435c0, buf=0x7f9d20020890 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d20013b68, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d20013b68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d20013b68, complen=0x7f9d4e639cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d20013b68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d20013408) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d20013408, com_data=0x7f9d4e639da0, cmd=0x7f9d4e639dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d200123b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 22 (Thread 0x7f9d4e5b8700 (LWP 3082)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d2000ded0, buf=0x7f9d20d94a00 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d20967e98, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d20967e98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d20967e98, complen=0x7f9d4e5b7cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d20967e98) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d20967738) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d20967738, com_data=0x7f9d4e5b7da0, cmd=0x7f9d4e5b7dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d209666e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 21 (Thread 0x7f9d4e535700 (LWP 3084)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d280144c0, buf=0x7f9d28016380 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d2800fbb8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d2800fbb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d2800fbb8, complen=0x7f9d4e534cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d2800fbb8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d2800f458) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d2800f458, com_data=0x7f9d4e534da0, cmd=0x7f9d4e534dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d2800e400) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 20 (Thread 0x7f9d4041a700 (LWP 4433)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d305f6670, buf=0x7f9d30031390 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d3002eb28, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d3002eb28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d3002eb28, complen=0x7f9d40419cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d3002eb28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d3002e3c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d3002e3c8, com_data=0x7f9d40419da0, cmd=0x7f9d40419dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d3002d370) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 19 (Thread 0x7f9d40398700 (LWP 4435)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d2c009fe0, buf=0x7f9d2c013890 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d2c00b998, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d2c00b998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d2c00b998, complen=0x7f9d40397cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d2c00b998) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d2c00b238) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d2c00b238, com_data=0x7f9d40397da0, cmd=0x7f9d40397dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d2c00a1e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 18 (Thread 0x7f9d40316700 (LWP 4436)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d3400a020, buf=0x7f9d340138d0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d3400b9d8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d3400b9d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d3400b9d8, complen=0x7f9d40315cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d3400b9d8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d3400b278) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d3400b278, com_data=0x7f9d40315da0, cmd=0x7f9d40315dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d3400a220) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 17 (Thread 0x7f9d40294700 (LWP 4444)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d3c023290, buf=0x7f9d3c05d4e0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d3c00fa28, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d3c00fa28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d3c00fa28, complen=0x7f9d40293cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d3c00fa28) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d3c00f2c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d3c00f2c8, com_data=0x7f9d40293da0, cmd=0x7f9d40293dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d3c00e270) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 16 (Thread 0x7f9d40212700 (LWP 4446)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0xd093970, buf=0xd1034a0 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0xd133528, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0xd133528) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0xd133528, complen=0x7f9d40211cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0xd133528) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0xd132dc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0xd132dc8, com_data=0x7f9d40211da0, cmd=0x7f9d40211dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0xd131d70) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 15 (Thread 0x7f9d40190700 (LWP 4453)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d20045920, buf=0x7f9d2095a670 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d20026058, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d20026058) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d20026058, complen=0x7f9d4018fcf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d20026058) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d200258f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d200258f8, com_data=0x7f9d4018fda0, cmd=0x7f9d4018fdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d200248a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 14 (Thread 0x7f9d4010e700 (LWP 4670)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d1c000910, buf=0x7f9d1c00a200 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d1c0022c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d1c0022c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d1c0022c8, complen=0x7f9d4010dcf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d1c0022c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d1c001b68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d1c001b68, com_data=0x7f9d4010dda0, cmd=0x7f9d4010ddcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d1c000b10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 13 (Thread 0x7f9d4008c700 (LWP 20485)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d280cfaa0, buf=0x7f9d28042a50 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d2801c098, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d2801c098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d2801c098, complen=0x7f9d4008bcf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d2801c098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d2801b938) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d2801b938, com_data=0x7f9d4008bda0, cmd=0x7f9d4008bdcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d2801a8e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 12 (Thread 0x7f9d38faa700 (LWP 20488)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d24083cf0, buf=0x7f9d240aea80 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d2401d028, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d2401d028) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d2401d028, complen=0x7f9d38fa9cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d2401d028) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d2401c8c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d2401c8c8, com_data=0x7f9d38fa9da0, cmd=0x7f9d38fa9dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d2401b870) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 11 (Thread 0x7f9d38f28700 (LWP 20491)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d304b0620, buf=0x7f9d30080d80 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d300503c8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d300503c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d300503c8, complen=0x7f9d38f27cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d300503c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d3004fc68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d3004fc68, com_data=0x7f9d38f27da0, cmd=0x7f9d38f27dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d3004ec10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 10 (Thread 0x7f9d38ea6700 (LWP 20501)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d2c0658c0, buf=0x7f9d2c037b30 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d2c02e5b8, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d2c02e5b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d2c02e5b8, complen=0x7f9d38ea5cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d2c02e5b8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d2c02de58) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d2c02de58, com_data=0x7f9d38ea5da0, cmd=0x7f9d38ea5dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d2c02ce00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 9 (Thread 0x7f9d38e24700 (LWP 20521)):
	#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
	#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
	#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
	#3  0x00000000012be678 in vio_read (vio=0x7f9d341799e0, buf=0x7f9d3417c570 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
	#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d34019098, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
	#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d34019098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
	#6  net_read_packet (net=0x7f9d34019098, complen=0x7f9d38e23cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
	#7  0x0000000000c6d80c in my_net_read (net=0x7f9d34019098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
	#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d34018938) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
	#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d34018938, com_data=0x7f9d38e23da0, cmd=0x7f9d38e23dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
	#10 0x0000000000d1ca77 in do_command (thd=0x7f9d340178e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
	#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6






Per_thread_connection_handler::block_until_new_connection

	Thread 8 (Thread 0x7f9d38da2700 (LWP 20550)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
	#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
	#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
	#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
	#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
	#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 7 (Thread 0x7f9d38d20700 (LWP 20551)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
	#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
	#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
	#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
	#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
	#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 6 (Thread 0x7f9d38c9e700 (LWP 6762)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
	#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
	#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
	#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
	#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
	#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 5 (Thread 0x7f9d38c1c700 (LWP 11276)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
	#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
	#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
	#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
	#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
	#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 4 (Thread 0x7f9d38b9a700 (LWP 11278)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
	#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
	#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
	#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
	#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
	#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 3 (Thread 0x7f9d38b18700 (LWP 11446)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
	#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
	#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
	#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
	#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
	#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
	Thread 2 (Thread 0x7f9d38a96700 (LWP 11453)):
	#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
	#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
	#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
	#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
	#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
	#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
	#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
	#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6


Thread 1 (Thread 0x7f9ef4fb7780 (LWP 3030)):
#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
#1  0x0000000000deee39 in Mysqld_socket_listener::listen_for_connection_event (this=0xcf37920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cb384 in connection_event_loop (this=0xcf29ad0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=130, argv=0x27d45f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:5132
#4  0x00007f9ef356d445 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c0ed9 in _start ()
