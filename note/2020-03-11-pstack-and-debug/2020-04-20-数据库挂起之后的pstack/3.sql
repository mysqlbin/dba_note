Thread 182 (Thread 0x7f9eeb65b700 (LWP 3033)):
#0  0x00007f9ef358247a in sigwaitinfo () from /lib64/libc.so.6
#1  0x0000000000f5299b in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/mysys/posix_timers.c:77
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0x28f0010) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 181 (Thread 0x7f9d4b656700 (LWP 3035)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4b655dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4b655dd0, m1=0x7f9d4b655e88, m2=0x7f9d4b655e80, request=0x7f9d4b655e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4b655e50, m2=0x7f9d4b655e80, m1=0x7f9d4b655e88, global_segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=0, m1=0x7f9d4b655e88, m2=0x7f9d4b655e80, request=0x7f9d4b655e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 180 (Thread 0x7f9d4ae55700 (LWP 3036)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4ae54dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4ae54dd0, m1=0x7f9d4ae54e88, m2=0x7f9d4ae54e80, request=0x7f9d4ae54e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4ae54e50, m2=0x7f9d4ae54e80, m1=0x7f9d4ae54e88, global_segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=1, m1=0x7f9d4ae54e88, m2=0x7f9d4ae54e80, request=0x7f9d4ae54e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 179 (Thread 0x7f9d4a654700 (LWP 3037)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4a653dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4a653dd0, m1=0x7f9d4a653e88, m2=0x7f9d4a653e80, request=0x7f9d4a653e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4a653e50, m2=0x7f9d4a653e80, m1=0x7f9d4a653e88, global_segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=2, m1=0x7f9d4a653e88, m2=0x7f9d4a653e80, request=0x7f9d4a653e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 178 (Thread 0x7f9d49e53700 (LWP 3038)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d49e52dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d49e52dd0, m1=0x7f9d49e52e88, m2=0x7f9d49e52e80, request=0x7f9d49e52e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d49e52e50, m2=0x7f9d49e52e80, m1=0x7f9d49e52e88, global_segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=3, m1=0x7f9d49e52e88, m2=0x7f9d49e52e80, request=0x7f9d49e52e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 177 (Thread 0x7f9d49652700 (LWP 3039)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d49651dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d49651dd0, m1=0x7f9d49651e88, m2=0x7f9d49651e80, request=0x7f9d49651e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d49651e50, m2=0x7f9d49651e80, m1=0x7f9d49651e88, global_segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=4, m1=0x7f9d49651e88, m2=0x7f9d49651e80, request=0x7f9d49651e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 176 (Thread 0x7f9d48e51700 (LWP 3040)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d48e50dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d48e50dd0, m1=0x7f9d48e50e88, m2=0x7f9d48e50e80, request=0x7f9d48e50e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d48e50e50, m2=0x7f9d48e50e80, m1=0x7f9d48e50e88, global_segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=5, m1=0x7f9d48e50e88, m2=0x7f9d48e50e80, request=0x7f9d48e50e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 175 (Thread 0x7f9d48650700 (LWP 3041)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4864fdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4864fdd0, m1=0x7f9d4864fe88, m2=0x7f9d4864fe80, request=0x7f9d4864fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4864fe50, m2=0x7f9d4864fe80, m1=0x7f9d4864fe88, global_segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=6, m1=0x7f9d4864fe88, m2=0x7f9d4864fe80, request=0x7f9d4864fe50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 174 (Thread 0x7f9d47e4f700 (LWP 3042)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d47e4edd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d47e4edd0, m1=0x7f9d47e4ee88, m2=0x7f9d47e4ee80, request=0x7f9d47e4ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d47e4ee50, m2=0x7f9d47e4ee80, m1=0x7f9d47e4ee88, global_segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=7, m1=0x7f9d47e4ee88, m2=0x7f9d47e4ee80, request=0x7f9d47e4ee50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 173 (Thread 0x7f9d4764e700 (LWP 3043)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4764ddd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4764ddd0, m1=0x7f9d4764de88, m2=0x7f9d4764de80, request=0x7f9d4764de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4764de50, m2=0x7f9d4764de80, m1=0x7f9d4764de88, global_segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=8, m1=0x7f9d4764de88, m2=0x7f9d4764de80, request=0x7f9d4764de50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 172 (Thread 0x7f9d46e4d700 (LWP 3044)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d46e4cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d46e4cdd0, m1=0x7f9d46e4ce88, m2=0x7f9d46e4ce80, request=0x7f9d46e4ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d46e4ce50, m2=0x7f9d46e4ce80, m1=0x7f9d46e4ce88, global_segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=9, m1=0x7f9d46e4ce88, m2=0x7f9d46e4ce80, request=0x7f9d46e4ce50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 171 (Thread 0x7f9d4664c700 (LWP 3045)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d4664bdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d4664bdd0, m1=0x7f9d4664be88, m2=0x7f9d4664be80, request=0x7f9d4664be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d4664be50, m2=0x7f9d4664be80, m1=0x7f9d4664be88, global_segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=10, m1=0x7f9d4664be88, m2=0x7f9d4664be80, request=0x7f9d4664be50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 170 (Thread 0x7f9d45e4b700 (LWP 3046)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d45e4add0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d45e4add0, m1=0x7f9d45e4ae88, m2=0x7f9d45e4ae80, request=0x7f9d45e4ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d45e4ae50, m2=0x7f9d45e4ae80, m1=0x7f9d45e4ae88, global_segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=11, m1=0x7f9d45e4ae88, m2=0x7f9d45e4ae80, request=0x7f9d45e4ae50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=11) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 169 (Thread 0x7f9d4564a700 (LWP 3047)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d45649dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d45649dd0, m1=0x7f9d45649e88, m2=0x7f9d45649e80, request=0x7f9d45649e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d45649e50, m2=0x7f9d45649e80, m1=0x7f9d45649e88, global_segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=12, m1=0x7f9d45649e88, m2=0x7f9d45649e80, request=0x7f9d45649e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=12) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 168 (Thread 0x7f9d44e49700 (LWP 3048)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d44e48dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d44e48dd0, m1=0x7f9d44e48e88, m2=0x7f9d44e48e80, request=0x7f9d44e48e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d44e48e50, m2=0x7f9d44e48e80, m1=0x7f9d44e48e88, global_segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=13, m1=0x7f9d44e48e88, m2=0x7f9d44e48e80, request=0x7f9d44e48e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=13) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 167 (Thread 0x7f9d44648700 (LWP 3049)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d44647dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d44647dd0, m1=0x7f9d44647e88, m2=0x7f9d44647e80, request=0x7f9d44647e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d44647e50, m2=0x7f9d44647e80, m1=0x7f9d44647e88, global_segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=14, m1=0x7f9d44647e88, m2=0x7f9d44647e80, request=0x7f9d44647e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=14) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 166 (Thread 0x7f9d43e47700 (LWP 3050)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d43e46dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d43e46dd0, m1=0x7f9d43e46e88, m2=0x7f9d43e46e80, request=0x7f9d43e46e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d43e46e50, m2=0x7f9d43e46e80, m1=0x7f9d43e46e88, global_segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=15, m1=0x7f9d43e46e88, m2=0x7f9d43e46e80, request=0x7f9d43e46e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=15) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 165 (Thread 0x7f9d43646700 (LWP 3051)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d43645dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d43645dd0, m1=0x7f9d43645e88, m2=0x7f9d43645e80, request=0x7f9d43645e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d43645e50, m2=0x7f9d43645e80, m1=0x7f9d43645e88, global_segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=16, m1=0x7f9d43645e88, m2=0x7f9d43645e80, request=0x7f9d43645e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=16) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 164 (Thread 0x7f9d42e45700 (LWP 3052)):
#0  0x00007f9ef4987644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000ff30c4 in LinuxAIOHandler::collect (this=0x7f9d42e44dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2502
#2  0x0000000000ff47e4 in LinuxAIOHandler::poll (this=0x7f9d42e44dd0, m1=0x7f9d42e44e88, m2=0x7f9d42e44e80, request=0x7f9d42e44e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2648
#3  0x0000000000ff620c in os_aio_linux_handler (request=0x7f9d42e44e50, m2=0x7f9d42e44e80, m1=0x7f9d42e44e88, global_segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:2704
#4  os_aio_handler (segment=17, m1=0x7f9d42e44e88, m2=0x7f9d42e44e80, request=0x7f9d42e44e50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:6261
#5  0x000000000118a7cd in fil_aio_wait (segment=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5835
#6  0x0000000001097640 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0start.cc:311
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 163 (Thread 0x7f9d42644700 (LWP 3053)):
#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d426439a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2925138, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001139d13 in pc_sleep_if_needed (sig_count=2, next_loop_time=1587364328146) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:2690
#4  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3191
#5  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 162 (Thread 0x7f9d41e43700 (LWP 3054)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0xce80de8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xce80de8, reset_sig_count=103) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 161 (Thread 0x7f9d41642700 (LWP 3055)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0xce80de8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xce80de8, reset_sig_count=103) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 160 (Thread 0x7f9d40e41700 (LWP 3056)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0xce80de8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xce80de8, reset_sig_count=103) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000113b5c7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0flu.cc:3496
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 159 (Thread 0x7f9d3bfff700 (LWP 3063)):
#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d3bffedb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0xce7dce8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000000fd2494 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/lock/lock0wait.cc:501
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 158 (Thread 0x7f9d54795700 (LWP 3064)):
#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d54794ac0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2924f88, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001095505 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1751
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 157 (Thread 0x7f9d53f94700 (LWP 3065)):
#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d53f93e30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0x2925018, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x0000000001094595 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:1585
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 156 (Thread 0x7f9d53793700 (LWP 3066)):
#0  0x00007f9ef4b97f3d in nanosleep () from /lib64/libpthread.so.0
#1  0x0000000000ffb7a0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0thread.cc:279
#2  0x0000000001094bbb in srv_master_sleep () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 155 (Thread 0x7f9d52f92700 (LWP 3067)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924d48) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924d48, reset_sig_count=17) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x000000000109659d in srv_purge_coordinator_suspend (rseg_history_len=28, slot=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2676
#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2792
#5  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 154 (Thread 0x7f9d52791700 (LWP 3068)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924ef8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924ef8, reset_sig_count=61) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 153 (Thread 0x7f9d51f90700 (LWP 3069)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924dd8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924dd8, reset_sig_count=62) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 152 (Thread 0x7f9d5178f700 (LWP 3070)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x2924e68) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2924e68, reset_sig_count=61) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001093e8e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 151 (Thread 0x7f9d50f8e700 (LWP 3071)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x29250a8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x29250a8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x00000000011335bc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0dump.cc:782
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 150 (Thread 0x7f9d5078d700 (LWP 3072)):
#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d5078cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0xcea5708, time_in_usec=<optimized out>, reset_sig_count=2) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x000000000117c887 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats_bg.cc:428
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 149 (Thread 0x7f9d4ff8c700 (LWP 3073)):
#0  0x00007f9ef4b94d42 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb1ee in os_event::timed_wait (this=<optimized out>, abstime=0x7f9d4ff8b950) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:285
#2  0x0000000000ffb50e in os_event::wait_time_low (this=0xcf1e0d8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:412
#3  0x00000000010e63d4 in ib_wqueue_timedwait (wq=0xcf46688, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/ut/ut0wqueue.cc:160
#4  0x00000000011c543a in fts_optimize_thread (arg=0xcf46688) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fts/fts0opt.cc:3031
#5  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 148 (Thread 0x7f9d4f78b700 (LWP 3074)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ffb03b in wait (this=0x29251c8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x29251c8, reset_sig_count=1) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0event.cc:335
#3  0x0000000001129a6c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/buf/buf0buf.cc:3019
#4  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 147 (Thread 0x7f9d4e6bc700 (LWP 3077)):
#0  0x00007f9ef4b98461 in sigwait () from /lib64/libpthread.so.0
#1  0x00000000007c5eeb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:2120
#2  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#3  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 146 (Thread 0x7f9d39fac700 (LWP 3078)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ebee55 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=874, src_file=0x15e0220 "/export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/rpl_gtid_persist.cc:874
#5  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#6  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#7  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 145 (Thread 0x7f9d4e63a700 (LWP 3080)):
#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
#3  0x00000000012be678 in vio_read (vio=0x7f9d200435c0, buf=0x7f9d20d94a00 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
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
Thread 144 (Thread 0x7f9d4e5b8700 (LWP 3082)):
#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
#3  0x00000000012be678 in vio_read (vio=0x7f9d20971550, buf=0x7f9d2097a120 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d20d9e428, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d20d9e428) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f9d20d9e428, complen=0x7f9d4e5b7cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#7  0x0000000000c6d80c in my_net_read (net=0x7f9d20d9e428) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d20d9dcc8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d20d9dcc8, com_data=0x7f9d4e5b7da0, cmd=0x7f9d4e5b7dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#10 0x0000000000d1ca77 in do_command (thd=0x7f9d20d9cc70) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 143 (Thread 0x7f9d4e535700 (LWP 3084)):
#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
#3  0x00000000012be678 in vio_read (vio=0x7f9d280144c0, buf=0x7f9d28042a50 "\001", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
#4  0x0000000000c6ccc3 in net_read_raw_loop (net=0x7f9d2801c098, count=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:672
#5  0x0000000000c6d55b in net_read_packet_header (net=0x7f9d2801c098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f9d2801c098, complen=0x7f9d4e534cf8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:822
#7  0x0000000000c6d80c in my_net_read (net=0x7f9d2801c098) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/net_serv.cc:899
#8  0x0000000000c7b07c in Protocol_classic::read_packet (this=0x7f9d2801b938) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:808
#9  0x0000000000c79e12 in Protocol_classic::get_command (this=0x7f9d2801b938, com_data=0x7f9d4e534da0, cmd=0x7f9d4e534dcc) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/protocol_classic.cc:965
#10 0x0000000000d1ca77 in do_command (thd=0x7f9d2801a8e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:938
#11 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
#12 0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#13 0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 142 (Thread 0x7f9d4041a700 (LWP 4433)):
#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
#3  0x00000000012be678 in vio_read (vio=0x7f9d305f6670, buf=0x7f9d30031390 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
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
Thread 141 (Thread 0x7f9d40398700 (LWP 4435)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 140 (Thread 0x7f9d40316700 (LWP 4436)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 139 (Thread 0x7f9d40294700 (LWP 4444)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 138 (Thread 0x7f9d40212700 (LWP 4446)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 137 (Thread 0x7f9d40190700 (LWP 4453)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 136 (Thread 0x7f9d4010e700 (LWP 4670)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 135 (Thread 0x7f9d4008c700 (LWP 20485)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 134 (Thread 0x7f9d38faa700 (LWP 20488)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 133 (Thread 0x7f9d38f28700 (LWP 20491)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 132 (Thread 0x7f9d38ea6700 (LWP 20501)):
#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
#1  0x00000000012bdf4f in vio_io_wait (vio=<optimized out>, event=<optimized out>, timeout=3600000) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:786
#2  0x00000000012be043 in vio_socket_io_wait (vio=<optimized out>, event=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:77
#3  0x00000000012be678 in vio_read (vio=0x7f9d2c0658c0, buf=0x7f9d2c037b30 "\a", size=4) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/vio/viosocket.c:132
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
Thread 131 (Thread 0x7f9d38e24700 (LWP 20521)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 130 (Thread 0x7f9d38da2700 (LWP 20550)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 129 (Thread 0x7f9d38d20700 (LWP 20551)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 128 (Thread 0x7f9d38c9e700 (LWP 6762)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 127 (Thread 0x7f9d38c1c700 (LWP 11276)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 126 (Thread 0x7f9d38b9a700 (LWP 11278)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 125 (Thread 0x7f9d38b18700 (LWP 11446)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 124 (Thread 0x7f9d38a96700 (LWP 11453)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 123 (Thread 0x7f9d38a14700 (LWP 28887)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd01cdd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 122 (Thread 0x7f9d38992700 (LWP 28888)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdff30) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 121 (Thread 0x7f9d38910700 (LWP 28889)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd108310) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 120 (Thread 0x7f9d3888e700 (LWP 28890)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd108660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 119 (Thread 0x7f9d3880c700 (LWP 28891)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1089b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 118 (Thread 0x7f9d3878a700 (LWP 28892)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd162310) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 117 (Thread 0x7f9d38708700 (LWP 28893)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd162660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 116 (Thread 0x7f9d38686700 (LWP 28894)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1629b0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 115 (Thread 0x7f9d38604700 (LWP 28895)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd162d00) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 114 (Thread 0x7f9d38582700 (LWP 28896)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd045fa0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 113 (Thread 0x7f9d38500700 (LWP 28897)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e4170) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 112 (Thread 0x7f9d3847e700 (LWP 28898)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e44f0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 111 (Thread 0x7f9d383fc700 (LWP 28899)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e4870) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 110 (Thread 0x7f9d3837a700 (LWP 28900)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e4bf0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 109 (Thread 0x7f9d382f8700 (LWP 28901)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd137c60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 108 (Thread 0x7f9d38276700 (LWP 28902)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1649c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 107 (Thread 0x7f9d381f4700 (LWP 28903)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd164d40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 106 (Thread 0x7f9d38172700 (LWP 28904)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1650c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 105 (Thread 0x7f9d380f0700 (LWP 28905)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd165440) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 104 (Thread 0x7f9d1bfff700 (LWP 28906)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1657c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 103 (Thread 0x7f9d1bf7d700 (LWP 28907)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfe09d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 102 (Thread 0x7f9d1befb700 (LWP 28908)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfe0d50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 101 (Thread 0x7f9d1be79700 (LWP 28909)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfe10d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 100 (Thread 0x7f9d1bdf7700 (LWP 28910)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfe1450) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 99 (Thread 0x7f9d1bd75700 (LWP 28911)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfe17d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 98 (Thread 0x7f9d1bcf3700 (LWP 28912)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfe1b50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 97 (Thread 0x7f9d1bc71700 (LWP 28913)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xcfdb730) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 96 (Thread 0x7f9d1bbef700 (LWP 28914)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e0350) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 95 (Thread 0x7f9d1bb6d700 (LWP 28915)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e06d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 94 (Thread 0x7f9d1baeb700 (LWP 28916)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e0a50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 93 (Thread 0x7f9d1ba69700 (LWP 28917)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e0dd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 92 (Thread 0x7f9d1b9e7700 (LWP 28918)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e1150) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 91 (Thread 0x7f9d1b965700 (LWP 28919)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e14d0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 90 (Thread 0x7f9d1b8e3700 (LWP 28920)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e1850) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 89 (Thread 0x7f9d1b861700 (LWP 28921)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e1bd0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 88 (Thread 0x7f9d1b7df700 (LWP 28922)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0e1f50) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 87 (Thread 0x7f9d1b75d700 (LWP 28923)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1886c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 86 (Thread 0x7f9d1b6db700 (LWP 28924)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd188a40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 85 (Thread 0x7f9d1b659700 (LWP 28925)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd188dc0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 84 (Thread 0x7f9d1b5d7700 (LWP 28926)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd189140) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 83 (Thread 0x7f9d1b555700 (LWP 28927)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1894c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 82 (Thread 0x7f9d1b4d3700 (LWP 28928)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd189840) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 81 (Thread 0x7f9d1b451700 (LWP 28929)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd189bc0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 80 (Thread 0x7f9d1b3cf700 (LWP 28930)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd189f40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 79 (Thread 0x7f9d1b34d700 (LWP 28931)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18a2c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 78 (Thread 0x7f9d1b2cb700 (LWP 28932)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18a640) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 77 (Thread 0x7f9d1b249700 (LWP 28933)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18a9c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 76 (Thread 0x7f9d1b1c7700 (LWP 28934)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18ad40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 75 (Thread 0x7f9d1b145700 (LWP 28935)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18b0c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 74 (Thread 0x7f9d1b0c3700 (LWP 28936)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18b440) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 73 (Thread 0x7f9d1b041700 (LWP 28937)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18b7c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 72 (Thread 0x7f9d1afbf700 (LWP 28938)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18bb40) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 71 (Thread 0x7f9d1af3d700 (LWP 28939)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18bec0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 70 (Thread 0x7f9d1aebb700 (LWP 28940)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18c240) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 69 (Thread 0x7f9d1ae39700 (LWP 28941)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd18c5c0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 68 (Thread 0x7f9d1adb7700 (LWP 28942)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd12aad0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 67 (Thread 0x7f9d1ad35700 (LWP 28943)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd10f560) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 66 (Thread 0x7f9d1acb3700 (LWP 28944)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd10f8e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 65 (Thread 0x7f9d1ac31700 (LWP 28945)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd10fc60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 64 (Thread 0x7f9d1abaf700 (LWP 28946)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd10ffe0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 63 (Thread 0x7f9d1ab2d700 (LWP 28947)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd110360) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 62 (Thread 0x7f9d1aaab700 (LWP 28948)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1106e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 61 (Thread 0x7f9d1aa29700 (LWP 28949)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd110a60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 60 (Thread 0x7f9d1a9a7700 (LWP 28950)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd110de0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 59 (Thread 0x7f9d1a925700 (LWP 28951)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd111160) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 58 (Thread 0x7f9d1a8a3700 (LWP 28952)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1114e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 57 (Thread 0x7f9d1a821700 (LWP 28953)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd111860) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 56 (Thread 0x7f9d1a79f700 (LWP 28954)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd111be0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 55 (Thread 0x7f9d1a71d700 (LWP 28955)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd111f60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 54 (Thread 0x7f9d1a69b700 (LWP 28956)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1122e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 53 (Thread 0x7f9d1a619700 (LWP 28957)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd112660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 52 (Thread 0x7f9d1a597700 (LWP 28958)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1129e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 51 (Thread 0x7f9d1a515700 (LWP 28959)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd112d60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 50 (Thread 0x7f9d1a493700 (LWP 28960)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1130e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 49 (Thread 0x7f9d1a411700 (LWP 28961)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd113460) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 48 (Thread 0x7f9d1a38f700 (LWP 28962)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd1137e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 47 (Thread 0x7f9d1a30d700 (LWP 28963)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd076be0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 46 (Thread 0x7f9d1a28b700 (LWP 28964)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd076f60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 45 (Thread 0x7f9d1a209700 (LWP 28965)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0772e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 44 (Thread 0x7f9d1a187700 (LWP 28966)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd077660) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 43 (Thread 0x7f9d1a105700 (LWP 28967)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0779e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 42 (Thread 0x7f9d1a083700 (LWP 28968)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd077d60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 41 (Thread 0x7f9d1a001700 (LWP 28969)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0780e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7f9d19f7f700 (LWP 28970)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd078460) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 39 (Thread 0x7f9d19efd700 (LWP 28971)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0787e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 38 (Thread 0x7f9d19e7b700 (LWP 28972)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd078b60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7f9d19df9700 (LWP 28973)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd078ee0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 36 (Thread 0x7f9d19d77700 (LWP 28974)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd079260) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7f9d19cf5700 (LWP 28975)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd0795e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7f9d19c73700 (LWP 28976)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd079960) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7f9d19bf1700 (LWP 28977)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd079ce0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7f9d19b6f700 (LWP 28978)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07a060) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7f9d19aed700 (LWP 28979)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07a3e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7f9d19a6b700 (LWP 28980)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07a760) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7f9d199e9700 (LWP 28981)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07aae0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7f9d19967700 (LWP 28982)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07ae60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7f9d198e5700 (LWP 28983)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07b1e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7f9d19863700 (LWP 28984)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07b560) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7f9d197e1700 (LWP 28985)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07b8e0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7f9d1975f700 (LWP 28986)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd07bc60) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7f9d196dd700 (LWP 28987)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd173690) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7f9d1965b700 (LWP 28988)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd173a10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7f9d195d9700 (LWP 28989)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd173d90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7f9d19557700 (LWP 28990)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd174110) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7f9d194d5700 (LWP 28991)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd174490) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7f9d19453700 (LWP 28992)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd174810) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7f9d193d1700 (LWP 28993)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd174b90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7f9d1934f700 (LWP 28994)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd174f10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7f9d192cd700 (LWP 28995)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd175290) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7f9d1924b700 (LWP 28996)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd175610) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7f9d191c9700 (LWP 28997)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd175990) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7f9d19147700 (LWP 28998)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd175d10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7f9d190c5700 (LWP 28999)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd176090) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7f9d19043700 (LWP 29000)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd176410) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7f9d18fc1700 (LWP 29001)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd176790) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7f9d18f3f700 (LWP 29002)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd176b10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7f9d18ebd700 (LWP 29003)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd176e90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7f9d18e3b700 (LWP 29004)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd177210) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7f9d18db9700 (LWP 29005)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd177590) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7f9d18d37700 (LWP 29006)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd177910) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7f9d18cb5700 (LWP 29007)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd177c90) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7f9d18c33700 (LWP 29008)):
#0  0x00007f9ef4b94995 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ded798 in native_cond_wait (mutex=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e7dae0 <Per_thread_connection_handler::LOCK_thread_cache>, cond=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=145, that=0x1e7db20 <Per_thread_connection_handler::COND_thread_cache>, mutex=<optimized out>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/include/mysql/psi/mysql_thread.h:1184
#4  Per_thread_connection_handler::block_until_new_connection () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:145
#5  0x0000000000ded998 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:329
#6  0x0000000001256a94 in pfs_spawn_thread (arg=0xd178010) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
#7  0x00007f9ef4b90e25 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f9ef3649bad in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7f9ef4fb7780 (LWP 3030)):
#0  0x00007f9ef363ef0d in poll () from /lib64/libc.so.6
#1  0x0000000000deee39 in Mysqld_socket_listener::listen_for_connection_event (this=0xcf37920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cb384 in connection_event_loop (this=0xcf29ad0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=130, argv=0x27d45f8) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/mysqld.cc:5132
#4  0x00007f9ef356d445 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c0ed9 in _start ()
