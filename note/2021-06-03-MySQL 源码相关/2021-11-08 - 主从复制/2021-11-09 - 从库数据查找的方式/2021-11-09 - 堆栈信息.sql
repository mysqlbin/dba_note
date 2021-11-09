Thread 195 (Thread 0x7f7689e8b700 (LWP 14196)):
#0  0x00007f7691cc640a in sigwaitinfo () from /lib64/libc.so.6
#1  0x0000000000f0f9bb in timer_notify_thread_func (arg=arg@entry=0x7fffb8f2fc50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/mysys/posix_timers.c:77
#2  0x0000000001280284 in pfs_spawn_thread (arg=0x3529ac0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#3  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 194 (Thread 0x7f7519de5700 (LWP 14198)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f7519de4da0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f7519de4da0, m1=m1@entry=0x7f7519de4e40, m2=m2@entry=0x7f7519de4e48, request=request@entry=0x7f7519de4e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f7519de4e50, m2=0x7f7519de4e48, m1=0x7f7519de4e40, global_segment=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=0, m1=m1@entry=0x7f7519de4e40, m2=m2@entry=0x7f7519de4e48, request=request@entry=0x7f7519de4e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 193 (Thread 0x7f75195e4700 (LWP 14199)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f75195e3da0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f75195e3da0, m1=m1@entry=0x7f75195e3e40, m2=m2@entry=0x7f75195e3e48, request=request@entry=0x7f75195e3e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f75195e3e50, m2=0x7f75195e3e48, m1=0x7f75195e3e40, global_segment=1) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=1, m1=m1@entry=0x7f75195e3e40, m2=m2@entry=0x7f75195e3e48, request=request@entry=0x7f75195e3e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=1) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 192 (Thread 0x7f7518de3700 (LWP 14200)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f7518de2da0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f7518de2da0, m1=m1@entry=0x7f7518de2e40, m2=m2@entry=0x7f7518de2e48, request=request@entry=0x7f7518de2e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f7518de2e50, m2=0x7f7518de2e48, m1=0x7f7518de2e40, global_segment=2) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=2, m1=m1@entry=0x7f7518de2e40, m2=m2@entry=0x7f7518de2e48, request=request@entry=0x7f7518de2e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=2) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 191 (Thread 0x7f75185e2700 (LWP 14201)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f75185e1da0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f75185e1da0, m1=m1@entry=0x7f75185e1e40, m2=m2@entry=0x7f75185e1e48, request=request@entry=0x7f75185e1e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f75185e1e50, m2=0x7f75185e1e48, m1=0x7f75185e1e40, global_segment=3) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=3, m1=m1@entry=0x7f75185e1e40, m2=m2@entry=0x7f75185e1e48, request=request@entry=0x7f75185e1e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=3) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 190 (Thread 0x7f7517de1700 (LWP 14202)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f7517de0da0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f7517de0da0, m1=m1@entry=0x7f7517de0e40, m2=m2@entry=0x7f7517de0e48, request=request@entry=0x7f7517de0e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f7517de0e50, m2=0x7f7517de0e48, m1=0x7f7517de0e40, global_segment=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=4, m1=m1@entry=0x7f7517de0e40, m2=m2@entry=0x7f7517de0e48, request=request@entry=0x7f7517de0e50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 189 (Thread 0x7f75175e0700 (LWP 14203)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f75175dfda0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f75175dfda0, m1=m1@entry=0x7f75175dfe40, m2=m2@entry=0x7f75175dfe48, request=request@entry=0x7f75175dfe50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f75175dfe50, m2=0x7f75175dfe48, m1=0x7f75175dfe40, global_segment=5) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=5, m1=m1@entry=0x7f75175dfe40, m2=m2@entry=0x7f75175dfe48, request=request@entry=0x7f75175dfe50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=5) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 188 (Thread 0x7f7516ddf700 (LWP 14204)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f7516ddeda0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f7516ddeda0, m1=m1@entry=0x7f7516ddee40, m2=m2@entry=0x7f7516ddee48, request=request@entry=0x7f7516ddee50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f7516ddee50, m2=0x7f7516ddee48, m1=0x7f7516ddee40, global_segment=6) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=6, m1=m1@entry=0x7f7516ddee40, m2=m2@entry=0x7f7516ddee48, request=request@entry=0x7f7516ddee50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=6) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 187 (Thread 0x7f75165de700 (LWP 14205)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f75165ddda0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f75165ddda0, m1=m1@entry=0x7f75165dde40, m2=m2@entry=0x7f75165dde48, request=request@entry=0x7f75165dde50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f75165dde50, m2=0x7f75165dde48, m1=0x7f75165dde40, global_segment=7) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=7, m1=m1@entry=0x7f75165dde40, m2=m2@entry=0x7f75165dde48, request=request@entry=0x7f75165dde50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=7) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 186 (Thread 0x7f7515ddd700 (LWP 14206)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f7515ddcda0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f7515ddcda0, m1=m1@entry=0x7f7515ddce40, m2=m2@entry=0x7f7515ddce48, request=request@entry=0x7f7515ddce50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f7515ddce50, m2=0x7f7515ddce48, m1=0x7f7515ddce40, global_segment=8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=8, m1=m1@entry=0x7f7515ddce40, m2=m2@entry=0x7f7515ddce48, request=request@entry=0x7f7515ddce50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 185 (Thread 0x7f75155dc700 (LWP 14207)):
#0  0x00007f76930ca644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x0000000000fcab50 in LinuxAIOHandler::collect (this=this@entry=0x7f75155dbda0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x0000000000fcb5bd in LinuxAIOHandler::poll (this=this@entry=0x7f75155dbda0, m1=m1@entry=0x7f75155dbe40, m2=m2@entry=0x7f75155dbe48, request=request@entry=0x7f75155dbe50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x0000000000fcdc1e in os_aio_linux_handler (request=0x7f75155dbe50, m2=0x7f75155dbe48, m1=0x7f75155dbe40, global_segment=9) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=segment@entry=9, m1=m1@entry=0x7f75155dbe40, m2=m2@entry=0x7f75155dbe48, request=request@entry=0x7f75155dbe50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000119848f in fil_aio_wait (segment=segment@entry=9) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001080d18 in io_handler_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 184 (Thread 0x7f7514ddb700 (LWP 14208)):
#0  0x00007f76932d7d12 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf252 in os_event::timed_wait (this=this@entry=0x3566eb8, abstime=abstime@entry=0x7f7514ddab70) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x0000000000fcf481 in os_event::wait_time_low (this=0x3566eb8, time_in_usec=<optimized out>, reset_sig_count=<optimized out>, reset_sig_count@entry=12938) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000000fcf6ea in os_event_wait_time_low (event=<optimized out>, time_in_usec=<optimized out>, reset_sig_count=reset_sig_count@entry=12938) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:517
#4  0x000000000113c72f in pc_sleep_if_needed (sig_count=12938, next_loop_time=1636360089248) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:2690
#5  buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3191
#6  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 183 (Thread 0x7f75145da700 (LWP 14209)):
#0  0x00007f76932d7965 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf391 in wait (this=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xbf8bba8, reset_sig_count=<optimized out>, reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000000fcf6fa in os_event_wait_low (event=<optimized out>, reset_sig_count=reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:534
#4  0x000000000113f3b7 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3496
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 182 (Thread 0x7f752190d700 (LWP 14211)):
#0  0x00007f76932d7d12 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf252 in os_event::timed_wait (this=this@entry=0xbf89db8, abstime=abstime@entry=0x7f752190cd00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x0000000000fcf481 in os_event::wait_time_low (this=this@entry=0xbf89db8, time_in_usec=time_in_usec@entry=1000000, reset_sig_count=<optimized out>, reset_sig_count@entry=1) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000000fcf6ea in os_event_wait_time_low (event=event@entry=0xbf89db8, time_in_usec=time_in_usec@entry=1000000, reset_sig_count=reset_sig_count@entry=1) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:517
#4  0x0000000000f9a637 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/lock/lock0wait.cc:501
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 181 (Thread 0x7f752110c700 (LWP 14212)):
#0  0x00007f76932d7d12 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf252 in os_event::timed_wait (this=this@entry=0x3566d08, abstime=abstime@entry=0x7f752110bc40) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x0000000000fcf481 in os_event::wait_time_low (this=0x3566d08, time_in_usec=time_in_usec@entry=1000000, reset_sig_count=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000000fcf6ea in os_event_wait_time_low (event=<optimized out>, time_in_usec=time_in_usec@entry=1000000, reset_sig_count=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:517
#4  0x000000000107aefa in srv_error_monitor_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:1751
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 180 (Thread 0x7f752090b700 (LWP 14213)):
#0  0x00007f76932d7d12 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf252 in os_event::timed_wait (this=this@entry=0x3566d98, abstime=abstime@entry=0x7f752090add0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x0000000000fcf481 in os_event::wait_time_low (this=0x3566d98, time_in_usec=time_in_usec@entry=5000000, reset_sig_count=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000000fcf6ea in os_event_wait_time_low (event=<optimized out>, time_in_usec=time_in_usec@entry=5000000, reset_sig_count=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:517
#4  0x000000000107aa39 in srv_monitor_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:1585
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 179 (Thread 0x7f752010a700 (LWP 14214)):
#0  0x00007f76932dae3d in nanosleep () from /lib64/libpthread.so.0
#1  0x0000000000fcfbdf in os_thread_sleep (tm=tm@entry=1000000) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x000000000107c3b3 in srv_master_sleep () at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 178 (Thread 0x7f751f909700 (LWP 14215)):
#0  0x00007f76932d7965 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf391 in wait (this=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3566ac8, reset_sig_count=<optimized out>, reset_sig_count@entry=3507653) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000000fcf6fa in os_event_wait_low (event=<optimized out>, reset_sig_count=reset_sig_count@entry=3507653) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:534
#4  0x000000000107e777 in srv_purge_coordinator_suspend (rseg_history_len=<optimized out>, slot=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2676
#5  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2792
#6  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 177 (Thread 0x7f751f108700 (LWP 14216)):
#0  0x00007f76932d7965 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf391 in wait (this=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3566c78, reset_sig_count=<optimized out>, reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000000fcf6fa in os_event_wait_low (event=<optimized out>, reset_sig_count=reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:534
#4  0x000000000107cfaa in srv_worker_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 176 (Thread 0x7f751e907700 (LWP 14217)):
#0  0x00007f76932d7965 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf391 in wait (this=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3566b58, reset_sig_count=<optimized out>, reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000000fcf6fa in os_event_wait_low (event=<optimized out>, reset_sig_count=reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:534
#4  0x000000000107cfaa in srv_worker_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 175 (Thread 0x7f751e106700 (LWP 14218)):
#0  0x00007f76932d7965 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf391 in wait (this=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3566be8, reset_sig_count=<optimized out>, reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000000fcf6fa in os_event_wait_low (event=<optimized out>, reset_sig_count=reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:534
#4  0x000000000107cfaa in srv_worker_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 174 (Thread 0x7f751d905700 (LWP 14219)):
#0  0x00007f76932d7965 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf391 in wait (this=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3566e28, reset_sig_count=<optimized out>, reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000000fcf6fa in os_event_wait_low (event=<optimized out>, reset_sig_count=reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:534
#4  0x00000000011336fc in buf_dump_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/buf/buf0dump.cc:782
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 173 (Thread 0x7f751d104700 (LWP 14220)):
#0  0x00007f76932d7d12 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf252 in os_event::timed_wait (this=this@entry=0xbf8e878, abstime=abstime@entry=0x7f751d103d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x0000000000fcf481 in os_event::wait_time_low (this=0xbf8e878, time_in_usec=time_in_usec@entry=10000000, reset_sig_count=<optimized out>, reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000000fcf6ea in os_event_wait_time_low (event=<optimized out>, time_in_usec=time_in_usec@entry=10000000, reset_sig_count=reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:517
#4  0x0000000001190edd in dict_stats_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/dict/dict0stats_bg.cc:428
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 172 (Thread 0x7f751276f700 (LWP 14221)):
#0  0x00007f76932d7d12 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf252 in os_event::timed_wait (this=this@entry=0xc0f5e98, abstime=abstime@entry=0x7f751276ebd0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x0000000000fcf481 in os_event::wait_time_low (this=0xc0f5e98, time_in_usec=time_in_usec@entry=5000000, reset_sig_count=<optimized out>, reset_sig_count@entry=1) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000000fcf6ea in os_event_wait_time_low (event=<optimized out>, time_in_usec=time_in_usec@entry=5000000, reset_sig_count=reset_sig_count@entry=1) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:517
#4  0x00000000010e0338 in ib_wqueue_timedwait (wq=wq@entry=0xc0f5d98, wait_in_usecs=wait_in_usecs@entry=5000000) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/ut/ut0wqueue.cc:160
#5  0x00000000011e7b78 in fts_optimize_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/fts/fts0opt.cc:2900
#6  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 171 (Thread 0x7f7511f6e700 (LWP 14222)):
#0  0x00007f76932d7965 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000fcf391 in wait (this=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x3566f48, reset_sig_count=<optimized out>, reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x0000000000fcf6fa in os_event_wait_low (event=<optimized out>, reset_sig_count=reset_sig_count@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/os/os0event.cc:534
#4  0x0000000001127542 in buf_resize_thread (arg=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:3019
#5  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 170 (Thread 0x7f7511123700 (LWP 14252)):
#0  0x00007f76932d7d12 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000e6313f in native_cond_timedwait (abstime=0x7f7511122dd0, mutex=0xc22c7f0, cond=0xc22c820) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/thr_cond.h:129
#2  my_cond_timedwait (abstime=0x7f7511122dd0, mp=0xc22c7f0, cond=0xc22c820) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/thr_cond.h:182
#3  inline_mysql_cond_timedwait (src_file=0x1616bd8 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/event_queue.cc", src_line=753, abstime=0x7f7511122dd0, mutex=0xc22c7f0, that=0xc22c820) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1229
#4  Event_queue::cond_wait (this=this@entry=0xc22c7f0, thd=thd@entry=0xc226b80, abstime=abstime@entry=0x7f7511122dd0, stage=<optimized out>, src_func=src_func@entry=0x1616d40 <Event_queue::get_top_for_execution_if_time(THD*, Event_queue_element_for_exec**)::__func__> "get_top_for_execution_if_time", src_file=src_file@entry=0x1616bd8 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/event_queue.cc", src_line=src_line@entry=601) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/event_queue.cc:753
#5  0x0000000000e633ba in Event_queue::get_top_for_execution_if_time (this=0xc22c7f0, thd=thd@entry=0xc226b80, event_name=event_name@entry=0x7f7511122e30) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/event_queue.cc:601
#6  0x0000000000e64e9e in Event_scheduler::run (this=this@entry=0xc1875f0, thd=0xc226b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/event_scheduler.cc:519
#7  0x0000000000e65034 in event_scheduler_thread (arg=arg@entry=0xc178930) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/event_scheduler.cc:243
#8  0x0000000001280284 in pfs_spawn_thread (arg=0xc231ff0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#9  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#10 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 169 (Thread 0x7f75110e1700 (LWP 14253)):
#0  0x00007f76932db361 in sigwait () from /lib64/libpthread.so.0
#1  0x00000000007abb5b in signal_hand (arg=arg@entry=0x0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/mysqld.cc:2125
#2  0x0000000001280284 in pfs_spawn_thread (arg=0xc1ab060) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#3  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 168 (Thread 0x7f751109f700 (LWP 14254)):
#0  0x00007f76932d7965 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000e6d593 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (that=<optimized out>, mutex=<optimized out>, src_file=0x1617400 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_gtid_persist.cc", src_line=879) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=p_thd@entry=0xc24ddf0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_gtid_persist.cc:879
#5  0x0000000001280284 in pfs_spawn_thread (arg=0xc231ff0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#6  0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 167 (Thread 0x7f75103b8700 (LWP 6772)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ae1c3a50, __fd=161) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ae1c3a50, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ade88010, buf=0x7f74ae1c3a50 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ae42ad68, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ae42ad68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ae42ad68, complen=0x7f75103b7ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ae42ad68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ae42a608) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ae42a608, com_data=0x7f75103b7da0, cmd=0x7f75103b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ae4295b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfd51b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xc273b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 166 (Thread 0x7f7493ad7700 (LWP 8254)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e23424a0, __fd=1194) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e23424a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e02d5820, buf=0x7f74e23424a0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e021ade8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e021ade8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e021ade8, complen=0x7f7493ad6ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e021ade8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e021a688) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e021a688, com_data=0x7f7493ad6da0, cmd=0x7f7493ad6d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e0219630) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfdcee0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xc273b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 165 (Thread 0x7f751005e700 (LWP 16554)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74cc6382a0, __fd=168) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74cc6382a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74cdf39050, buf=0x7f74cc6382a0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74cdd02298, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74cdd02298) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74cdd02298, complen=0x7f751005dce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74cdd02298) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74cdd01b38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74cdd01b38, com_data=0x7f751005dda0, cmd=0x7f751005dd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74cdd00ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc45c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xbfca420) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 164 (Thread 0x7f75106d0700 (LWP 28127)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750ce76200, __fd=167) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750ce76200, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f750c01b7f0, buf=0x7f750ce76200 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750d097e48, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750d097e48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750d097e48, complen=0x7f75106cfce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750d097e48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750d0976e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750d0976e8, com_data=0x7f75106cfda0, cmd=0x7f75106cfd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750d096690) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xe118fb0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xec94320) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 163 (Thread 0x7f74933e1700 (LWP 11483)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c9fbcbd0, __fd=1193) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c9fbcbd0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c819e630, buf=0x7f74c9fbcbd0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c8a7f728, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c8a7f728) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c8a7f728, complen=0x7f74933e0ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c8a7f728) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c8a7efc8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c8a7efc8, com_data=0x7f74933e0da0, cmd=0x7f74933e0d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c8a7df70) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0288c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 162 (Thread 0x7f7492889700 (LWP 11763)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f543ee30, __fd=187) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f543ee30, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f6a00110, buf=0x7f74f543ee30 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f45946f8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f45946f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f45946f8, complen=0x7f7492888ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f45946f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f4593f98) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f4593f98, com_data=0x7f7492888da0, cmd=0x7f7492888d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f4592f40) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e9690) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 161 (Thread 0x7f7493255700 (LWP 11765)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74fc0e5790, __fd=251) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74fc0e5790, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74fc2a0c80, buf=0x7f74fc0e5790 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74fc763c78, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74fc763c78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74fc763c78, complen=0x7f7493254ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74fc763c78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74fc763518) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74fc763518, com_data=0x7f7493254da0, cmd=0x7f7493254d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74fc7624c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e9690) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 160 (Thread 0x7f7492b5f700 (LWP 11766)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7508020780, __fd=176) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7508020780, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7508140cc0, buf=0x7f7508020780 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f75086dd878, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f75086dd878) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f75086dd878, complen=0x7f7492b5ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f75086dd878) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f75086dd118) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f75086dd118, com_data=0x7f7492b5eda0, cmd=0x7f7492b5ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f75086dc0c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e9690) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 159 (Thread 0x7f7491df7700 (LWP 11767)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f75058602e0, __fd=258) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f75058602e0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7505d84c50, buf=0x7f75058602e0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f7505830788, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f7505830788) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f7505830788, complen=0x7f7491df6ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f7505830788) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f7505830028) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f7505830028, com_data=0x7f7491df6da0, cmd=0x7f7491df6d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750582efd0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e9690) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 158 (Thread 0x7f7493c21700 (LWP 11769)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750cef0960, __fd=254) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750cef0960, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f750cf59330, buf=0x7f750cef0960 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750cd9eb38, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750cd9eb38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750cd9eb38, complen=0x7f7493c20ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750cd9eb38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750cd9e3d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750cd9e3d8, com_data=0x7f7493c20da0, cmd=0x7f7493c20d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750cd9d380) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e9690) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 157 (Thread 0x7f74934e9700 (LWP 11770)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0xc282130, __fd=257) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0xc282130, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0xc2062b0, buf=0xc282130 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0xc293518, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0xc293518) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0xc293518, complen=0x7f74934e8ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0xc293518) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0xc292db8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0xc292db8, com_data=0x7f74934e8da0, cmd=0x7f74934e8d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0xc291d60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e9690) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 156 (Thread 0x7f749394b700 (LWP 11771)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749a1b3180, __fd=189) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749a1b3180, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f749a0f3580, buf=0x7f749a1b3180 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f749a2e5568, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f749a2e5568) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f749a2e5568, complen=0x7f749394ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f749a2e5568) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f749a2e4e08) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f749a2e4e08, com_data=0x7f749394ada0, cmd=0x7f749394ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f749a2e3db0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 155 (Thread 0x7f7492db1700 (LWP 11773)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7494629f40, __fd=188) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7494629f40, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74944ca490, buf=0x7f7494629f40 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74942f6a58, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74942f6a58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74942f6a58, complen=0x7f7492db0ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74942f6a58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74942f62f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74942f62f8, com_data=0x7f7492db0da0, cmd=0x7f7492db0d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74942f52a0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 154 (Thread 0x7f751064c700 (LWP 11774)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a0452d50, __fd=256) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a0452d50, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a052edd0, buf=0x7f74a0452d50 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a052c538, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a052c538) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a052c538, complen=0x7f751064bce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a052c538) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a052bdd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a052bdd8, com_data=0x7f751064bda0, cmd=0x7f751064bd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a052ad80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 153 (Thread 0x7f7492f3d700 (LWP 11775)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749c484130, __fd=253) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749c484130, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f749c5aa850, buf=0x7f749c484130 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f749c6ad2a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f749c6ad2a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f749c6ad2a8, complen=0x7f7492f3cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f749c6ad2a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f749c6acb48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f749c6acb48, com_data=0x7f7492f3cda0, cmd=0x7f7492f3cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f749c6abaf0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 152 (Thread 0x7f75107d8700 (LWP 11776)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a81c38d0, __fd=1151) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a81c38d0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a864a380, buf=0x7f74a81c38d0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a80e2628, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a80e2628) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a80e2628, complen=0x7f75107d7ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a80e2628) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a80e1ec8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a80e1ec8, com_data=0x7f75107d7da0, cmd=0x7f75107d7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a80e0e70) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 151 (Thread 0x7f74920cd700 (LWP 11777)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a42f0ea0, __fd=171) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a42f0ea0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a40a7000, buf=0x7f74a42f0ea0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a419ef68, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a419ef68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a419ef68, complen=0x7f74920ccce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a419ef68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a419e808) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a419e808, com_data=0x7f74920ccda0, cmd=0x7f74920ccd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a419d7b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 150 (Thread 0x7f749398d700 (LWP 11778)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b1d639f0, __fd=690) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b1d639f0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b20f39b0, buf=0x7f74b1d639f0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b2010bd8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b2010bd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b2010bd8, complen=0x7f749398cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b2010bd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b2010478) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b2010478, com_data=0x7f749398cda0, cmd=0x7f749398cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b200f420) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 149 (Thread 0x7f74931d1700 (LWP 11780)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ac0a6570, __fd=252) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ac0a6570, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ae0ec5f0, buf=0x7f74ac0a6570 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74adfdf098, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74adfdf098) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74adfdf098, complen=0x7f74931d0ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74adfdf098) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74adfde938) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74adfde938, com_data=0x7f74931d0da0, cmd=0x7f74931d0d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74adfdd8e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 148 (Thread 0x7f7491f83700 (LWP 11781)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ba032910, __fd=688) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ba032910, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b9e88fe0, buf=0x7f74ba032910 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b8672028, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b8672028) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b8672028, complen=0x7f7491f82ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b8672028) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b86718c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b86718c8, com_data=0x7f7491f82da0, cmd=0x7f7491f82d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b8670870) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 147 (Thread 0x7f7493801700 (LWP 11782)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b44931e0, __fd=250) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b44931e0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b409ce00, buf=0x7f74b44931e0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b4180c78, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b4180c78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b4180c78, complen=0x7f7493800ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b4180c78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b4180518) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b4180518, com_data=0x7f7493800da0, cmd=0x7f7493800d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b417f4c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 146 (Thread 0x7f749208b700 (LWP 11789)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d0373c20, __fd=739) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d0373c20, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d00b32f0, buf=0x7f74d0373c20 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d006b468, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d006b468) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d006b468, complen=0x7f749208ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d006b468) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d006ad08) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d006ad08, com_data=0x7f749208ada0, cmd=0x7f749208ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d0069cb0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfce4e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 145 (Thread 0x7f749310b700 (LWP 11911)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ca36f1a0, __fd=172) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ca36f1a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c81a02d0, buf=0x7f74ca36f1a0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ca330c48, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ca330c48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ca330c48, complen=0x7f749310ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ca330c48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ca3304e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ca3304e8, com_data=0x7f749310ada0, cmd=0x7f749310ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ca32f490) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfd51b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 144 (Thread 0x7f7492427700 (LWP 11912)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c5b5db60, __fd=740) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c5b5db60, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c457b920, buf=0x7f74c5b5db60 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c6c21178, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c6c21178) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c6c21178, complen=0x7f7492426ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c6c21178) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c6c20a18) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c6c20a18, com_data=0x7f7492426da0, cmd=0x7f7492426d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c6c1f9c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfd51b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 143 (Thread 0x7f7492571700 (LWP 12284)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d036a5e0, __fd=193) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d036a5e0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d0217800, buf=0x7f74d036a5e0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d01497a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d01497a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d01497a8, complen=0x7f7492570ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d01497a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d0149048) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d0149048, com_data=0x7f7492570da0, cmd=0x7f7492570d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d0147ff0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfd51b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 142 (Thread 0x7f7493ce7700 (LWP 13250)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d4c40360, __fd=255) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d4c40360, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d4c20380, buf=0x7f74d4c40360 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d50c5d28, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d50c5d28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d50c5d28, complen=0x7f7493ce6ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d50c5d28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d50c55c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d50c55c8, com_data=0x7f7493ce6da0, cmd=0x7f7493ce6d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d50c4570) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfd51b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 141 (Thread 0x7f7491c6b700 (LWP 13919)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e42a2df0, __fd=746) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e42a2df0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e41cba10, buf=0x7f74e42a2df0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e47f58d8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e47f58d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e47f58d8, complen=0x7f7491c6ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e47f58d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e47f5178) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e47f5178, com_data=0x7f7491c6ada0, cmd=0x7f7491c6ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e47f4120) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 140 (Thread 0x7f7493e73700 (LWP 13920)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74dc0745b0, __fd=742) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74dc0745b0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74dc1c8e50, buf=0x7f74dc0745b0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74dc1ecf88, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74dc1ecf88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74dc1ecf88, complen=0x7f7493e72ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74dc1ecf88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74dc1ec828) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74dc1ec828, com_data=0x7f7493e72da0, cmd=0x7f7493e72d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74dc1eb7d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 139 (Thread 0x7f74921d5700 (LWP 13922)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e8879f70, __fd=751) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e8879f70, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e80ee900, buf=0x7f74e8879f70 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e897c418, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e897c418) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e897c418, complen=0x7f74921d4ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e897c418) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e897bcb8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e897bcb8, com_data=0x7f74921d4da0, cmd=0x7f74921d4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e897ac60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 138 (Thread 0x7f74929d3700 (LWP 13923)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74bc33ded0, __fd=753) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74bc33ded0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74bc035070, buf=0x7f74bc33ded0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74bc1cf1e8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74bc1cf1e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74bc1cf1e8, complen=0x7f74929d2ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74bc1cf1e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74bc1cea88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74bc1cea88, com_data=0x7f74929d2da0, cmd=0x7f74929d2d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74bc1cda30) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 137 (Thread 0x7f7491d31700 (LWP 13924)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74dc155c90, __fd=752) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74dc155c90, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74dc0116e0, buf=0x7f74dc155c90 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74dc959ea8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74dc959ea8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74dc959ea8, complen=0x7f7491d30ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74dc959ea8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74dc959748) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74dc959748, com_data=0x7f7491d30da0, cmd=0x7f7491d30d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74dc9586f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 136 (Thread 0x7f7491cef700 (LWP 13926)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e90af440, __fd=754) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e90af440, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e8332fc0, buf=0x7f74e90af440 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e90c2cb8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e90c2cb8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e90c2cb8, complen=0x7f7491ceece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e90c2cb8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e90c2558) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e90c2558, com_data=0x7f7491ceeda0, cmd=0x7f7491ceed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e90c1500) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 135 (Thread 0x7f7493ca5700 (LWP 13927)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e40767a0, __fd=756) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e40767a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e476b090, buf=0x7f74e40767a0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e41c6548, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e41c6548) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e41c6548, complen=0x7f7493ca4ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e41c6548) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e41c5de8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e41c5de8, com_data=0x7f7493ca4da0, cmd=0x7f7493ca4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e41c4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 134 (Thread 0x7f7491cad700 (LWP 13928)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f20829a0, __fd=757) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f20829a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f0067f00, buf=0x7f74f20829a0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f1a21078, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f1a21078) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f1a21078, complen=0x7f7491cacce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f1a21078) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f1a20918) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f1a20918, com_data=0x7f7491cacda0, cmd=0x7f7491cacd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f1a1f8c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 133 (Thread 0x7f7491db5700 (LWP 13930)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ec0ae4a0, __fd=758) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ec0ae4a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ec7b0840, buf=0x7f74ec0ae4a0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ec259198, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ec259198) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ec259198, complen=0x7f7491db4ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ec259198) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ec258a38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ec258a38, com_data=0x7f7491db4da0, cmd=0x7f7491db4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ec2579e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 132 (Thread 0x7f7491c29700 (LWP 13931)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f81ce060, __fd=760) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f81ce060, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f80d5740, buf=0x7f74f81ce060 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f8037218, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f8037218) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f8037218, complen=0x7f7491c28ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f8037218) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f8036ab8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f8036ab8, com_data=0x7f7491c28da0, cmd=0x7f7491c28d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f8035a60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 131 (Thread 0x7f7491be7700 (LWP 13932)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f4151ff0, __fd=759) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f4151ff0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f41f70a0, buf=0x7f74f4151ff0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f6bfbe58, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f6bfbe58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f6bfbe58, complen=0x7f7491be6ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f6bfbe58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f6bfb6f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f6bfb6f8, com_data=0x7f7491be6da0, cmd=0x7f7491be6d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f6bfa6a0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 130 (Thread 0x7f7492b1d700 (LWP 13933)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f75020c02d0, __fd=763) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f75020c02d0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f75020690e0, buf=0x7f75020c02d0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750002d338, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750002d338) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750002d338, complen=0x7f7492b1cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750002d338) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750002cbd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750002cbd8, com_data=0x7f7492b1cda0, cmd=0x7f7492b1cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750002bb80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 129 (Thread 0x7f7491ba5700 (LWP 13934)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74fc0321d0, __fd=761) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74fc0321d0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74fc0f39a0, buf=0x7f74fc0321d0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74fc3a1408, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74fc3a1408) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74fc3a1408, complen=0x7f7491ba4ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74fc3a1408) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74fc3a0ca8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74fc3a0ca8, com_data=0x7f7491ba4da0, cmd=0x7f7491ba4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74fc39fc50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 128 (Thread 0x7f7492c25700 (LWP 13935)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7508138d90, __fd=762) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7508138d90, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7508429350, buf=0x7f7508138d90 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f75086e18a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f75086e18a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f75086e18a8, complen=0x7f7492c24ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f75086e18a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f75086e1148) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f75086e1148, com_data=0x7f7492c24da0, cmd=0x7f7492c24d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f75086e00f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 127 (Thread 0x7f7491d73700 (LWP 13937)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7505943ac0, __fd=765) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7505943ac0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7505ce16d0, buf=0x7f7505943ac0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f7505619238, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f7505619238) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f7505619238, complen=0x7f7491d72ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f7505619238) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f7505618ad8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f7505618ad8, com_data=0x7f7491d72da0, cmd=0x7f7491d72d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f7505617a80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 126 (Thread 0x7f7493003700 (LWP 13938)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750c186c60, __fd=769) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750c186c60, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f750c1867c0, buf=0x7f750c186c60 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750c42acf8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750c42acf8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750c42acf8, complen=0x7f7493002ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750c42acf8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750c42a598) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750c42a598, com_data=0x7f7493002da0, cmd=0x7f7493002d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750c429540) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfc4b00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 125 (Thread 0x7f749273f700 (LWP 14085)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a04675b0, __fd=774) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a04675b0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a00c4e60, buf=0x7f74a04675b0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a00ca958, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a00ca958) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a00ca958, complen=0x7f749273ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a00ca958) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a00ca1f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a00ca1f8, com_data=0x7f749273eda0, cmd=0x7f749273ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a00c91a0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc224790) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 124 (Thread 0x7f74926fd700 (LWP 14086)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749c80c880, __fd=773) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749c80c880, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f749c1a5120, buf=0x7f749c80c880 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f749c19d868, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f749c19d868) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f749c19d868, complen=0x7f74926fcce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f749c19d868) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f749c19d108) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f749c19d108, com_data=0x7f74926fcda0, cmd=0x7f74926fcd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f749c19c0b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc224790) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 123 (Thread 0x7f75102f2700 (LWP 14334)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c01ddd10, __fd=775) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c01ddd10, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c00890f0, buf=0x7f74c01ddd10 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c01db578, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c01db578) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c01db578, complen=0x7f75102f1ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c01db578) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c01dae18) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c01dae18, com_data=0x7f75102f1da0, cmd=0x7f75102f1d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c01d9dc0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 122 (Thread 0x7f7510712700 (LWP 14335)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a816d9a0, __fd=778) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a816d9a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a8485030, buf=0x7f74a816d9a0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a80a8b88, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a80a8b88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a80a8b88, complen=0x7f7510711ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a80a8b88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a80a8428) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a80a8428, com_data=0x7f7510711da0, cmd=0x7f7510711d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a80a73d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 121 (Thread 0x7f7492469700 (LWP 14337)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a42506b0, __fd=779) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a42506b0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a40e6510, buf=0x7f74a42506b0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a42fcd88, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a42fcd88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a42fcd88, complen=0x7f7492468ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a42fcd88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a42fc628) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a42fc628, com_data=0x7f7492468da0, cmd=0x7f7492468d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a42fb5d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 120 (Thread 0x7f74924ed700 (LWP 14338)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b0023000, __fd=780) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b0023000, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b1c078a0, buf=0x7f74b0023000 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b1e83da8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b1e83da8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b1e83da8, complen=0x7f74924ecce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b1e83da8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b1e83648) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b1e83648, com_data=0x7f74924ecda0, cmd=0x7f74924ecd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b1e825f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 119 (Thread 0x7f74934a7700 (LWP 14339)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74adde1aa0, __fd=781) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74adde1aa0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74aca01f30, buf=0x7f74adde1aa0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ae284bd8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ae284bd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ae284bd8, complen=0x7f74934a6ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ae284bd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ae284478) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ae284478, com_data=0x7f74934a6da0, cmd=0x7f74934a6d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ae283420) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 118 (Thread 0x7f749252f700 (LWP 14341)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b9b5cfa0, __fd=782) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b9b5cfa0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b89430d0, buf=0x7f74b9b5cfa0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b81885c8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b81885c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b81885c8, complen=0x7f749252ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b81885c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b8187e68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b8187e68, com_data=0x7f749252eda0, cmd=0x7f749252ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b8186e10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 117 (Thread 0x7f7493def700 (LWP 14342)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b408e690, __fd=783) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b408e690, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b4499010, buf=0x7f74b408e690 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b4480968, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b4480968) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b4480968, complen=0x7f7493deece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b4480968) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b4480208) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b4480208, com_data=0x7f7493deeda0, cmd=0x7f7493deed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b447f1b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 116 (Thread 0x7f751026e700 (LWP 14343)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c035f090, __fd=784) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c035f090, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c0228ae0, buf=0x7f74c035f090 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c03331e8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c03331e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c03331e8, complen=0x7f751026dce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c03331e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c0332a88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c0332a88, com_data=0x7f751026dda0, cmd=0x7f751026dd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c0331a30) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 115 (Thread 0x7f7492361700 (LWP 14345)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74bc029530, __fd=785) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74bc029530, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74bc0ea650, buf=0x7f74bc029530 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74bc032338, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74bc032338) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74bc032338, complen=0x7f7492360ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74bc032338) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74bc031bd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74bc031bd8, com_data=0x7f7492360da0, cmd=0x7f7492360d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74bc030b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 114 (Thread 0x7f749290d700 (LWP 14346)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ca674ad0, __fd=786) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ca674ad0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ca1c7fb0, buf=0x7f74ca674ad0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c8224d28, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c8224d28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c8224d28, complen=0x7f749290cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c8224d28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c82245c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c82245c8, com_data=0x7f749290cda0, cmd=0x7f749290cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c8223570) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 113 (Thread 0x7f7493297700 (LWP 14347)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c6cc2d10, __fd=787) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c6cc2d10, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c5c4d7a0, buf=0x7f74c6cc2d10 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c5a18a78, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c5a18a78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c5a18a78, complen=0x7f7493296ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c5a18a78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c5a18318) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c5a18318, com_data=0x7f7493296da0, cmd=0x7f7493296d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c5a172c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 112 (Thread 0x7f749331b700 (LWP 14348)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d019f120, __fd=788) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d019f120, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d0356d80, buf=0x7f74d019f120 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d03953c8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d03953c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d03953c8, complen=0x7f749331ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d03953c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d0394c68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d0394c68, com_data=0x7f749331ada0, cmd=0x7f749331ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d0393c10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 111 (Thread 0x7f7510502700 (LWP 14349)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74cc230270, __fd=789) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74cc230270, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74cde35bf0, buf=0x7f74cc230270 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74cc4f9598, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74cc4f9598) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74cc4f9598, complen=0x7f7510501ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74cc4f9598) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74cc4f8e38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74cc4f8e38, com_data=0x7f7510501da0, cmd=0x7f7510501d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74cc4f7de0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 110 (Thread 0x7f7491adf700 (LWP 14350)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d8a15370, __fd=790) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d8a15370, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d80fe220, buf=0x7f74d8a15370 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d8321668, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d8321668) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d8321668, complen=0x7f7491adece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d8321668) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d8320f08) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d8320f08, com_data=0x7f7491adeda0, cmd=0x7f7491aded90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d831feb0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 109 (Thread 0x7f7492217700 (LWP 14352)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d4024100, __fd=791) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d4024100, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d4ce9f70, buf=0x7f74d4024100 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d6a1cf28, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d6a1cf28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d6a1cf28, complen=0x7f7492216ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d6a1cf28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d6a1c7c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d6a1c7c8, com_data=0x7f7492216da0, cmd=0x7f7492216d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d6a1b770) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 108 (Thread 0x7f7492df3700 (LWP 14353)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e23a2260, __fd=792) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e23a2260, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e0814670, buf=0x7f74e23a2260 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e27a1788, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e27a1788) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e27a1788, complen=0x7f7492df2ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e27a1788) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e27a1028) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e27a1028, com_data=0x7f7492df2da0, cmd=0x7f7492df2d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e279ffd0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 107 (Thread 0x7f749314d700 (LWP 14354)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74dc8946e0, __fd=793) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74dc8946e0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74dc308480, buf=0x7f74dc8946e0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74dc312698, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74dc312698) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74dc312698, complen=0x7f749314cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74dc312698) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74dc311f38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74dc311f38, com_data=0x7f749314cda0, cmd=0x7f749314cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74dc310ee0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 106 (Thread 0x7f7492ca9700 (LWP 14356)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e81abb70, __fd=794) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e81abb70, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e8879720, buf=0x7f74e81abb70 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e8334ba8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e8334ba8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e8334ba8, complen=0x7f7492ca8ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e8334ba8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e8334448) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e8334448, com_data=0x7f7492ca8da0, cmd=0x7f7492ca8d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e83333f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 105 (Thread 0x7f7493f39700 (LWP 14357)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e4237740, __fd=795) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e4237740, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e47181f0, buf=0x7f74e4237740 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e47ced28, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e47ced28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e47ced28, complen=0x7f7493f38ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e47ced28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e47ce5c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e47ce5c8, com_data=0x7f7493f38da0, cmd=0x7f7493f38d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e47cd570) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 104 (Thread 0x7f74924ab700 (LWP 14358)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f06040c0, __fd=796) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f06040c0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f1d70e50, buf=0x7f74f06040c0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f029b398, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f029b398) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f029b398, complen=0x7f74924aace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f029b398) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f029ac38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f029ac38, com_data=0x7f74924aada0, cmd=0x7f74924aad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f0299be0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 103 (Thread 0x7f74928cb700 (LWP 14359)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ec09ed60, __fd=797) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ec09ed60, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ec0df980, buf=0x7f74ec09ed60 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ec271ed8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ec271ed8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ec271ed8, complen=0x7f74928cace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ec271ed8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ec271778) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ec271778, com_data=0x7f74928cada0, cmd=0x7f74928cad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ec270720) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 102 (Thread 0x7f749352b700 (LWP 14360)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f8cb0910, __fd=798) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f8cb0910, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f81f6380, buf=0x7f74f8cb0910 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f834ffd8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f834ffd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f834ffd8, complen=0x7f749352ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f834ffd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f834f878) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f834f878, com_data=0x7f749352ada0, cmd=0x7f749352ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f834e820) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 101 (Thread 0x7f751047e700 (LWP 14361)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f5e37390, __fd=799) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f5e37390, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f4269180, buf=0x7f74f5e37390 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f42aabd8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f42aabd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f42aabd8, complen=0x7f751047dce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f42aabd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f42aa478) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f42aa478, com_data=0x7f751047dda0, cmd=0x7f751047dd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f42a9420) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 100 (Thread 0x7f7492049700 (LWP 14363)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f75000a8e90, __fd=800) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f75000a8e90, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f750002b880, buf=0x7f75000a8e90 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750022c448, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750022c448) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750022c448, complen=0x7f7492048ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750022c448) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750022bce8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750022bce8, com_data=0x7f7492048da0, cmd=0x7f7492048d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750022ac90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 99 (Thread 0x7f7493b19700 (LWP 14364)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74fc0a1310, __fd=801) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74fc0a1310, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74fc025810, buf=0x7f74fc0a1310 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74fc037998, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74fc037998) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74fc037998, complen=0x7f7493b18ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74fc037998) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74fc037238) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74fc037238, com_data=0x7f7493b18da0, cmd=0x7f7493b18d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74fc0361e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 98 (Thread 0x7f7510796700 (LWP 14365)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7508390fc0, __fd=802) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7508390fc0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f75085f2980, buf=0x7f7508390fc0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750813e558, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750813e558) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750813e558, complen=0x7f7510795ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750813e558) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750813ddf8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750813ddf8, com_data=0x7f7510795da0, cmd=0x7f7510795d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750813cda0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 97 (Thread 0x7f749210f700 (LWP 14367)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750563b330, __fd=803) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750563b330, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7505ba8230, buf=0x7f750563b330 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f7505d64508, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f7505d64508) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f7505d64508, complen=0x7f749210ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f7505d64508) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f7505d63da8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f7505d63da8, com_data=0x7f749210eda0, cmd=0x7f749210ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f7505d62d50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 96 (Thread 0x7f74922dd700 (LWP 14368)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750d00ec70, __fd=804) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750d00ec70, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f750c02dc40, buf=0x7f750d00ec70 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750c877418, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750c877418) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750c877418, complen=0x7f74922dcce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750c877418) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750c876cb8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750c876cb8, com_data=0x7f74922dcda0, cmd=0x7f74922dcd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750c875c60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 95 (Thread 0x7f749335d700 (LWP 14369)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x3529e10, __fd=805) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x3529e10, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0xc28c900, buf=0x3529e10 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0xc2bf5f8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0xc2bf5f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0xc2bf5f8, complen=0x7f749335cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0xc2bf5f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0xc2bee98) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0xc2bee98, com_data=0x7f749335cda0, cmd=0x7f749335cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0xc2bde40) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc215d20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 94 (Thread 0x7f7492e77700 (LWP 14371)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749838a8e0, __fd=806) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749838a8e0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74982c2440, buf=0x7f749838a8e0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f749832c118, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f749832c118) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f749832c118, complen=0x7f7492e76ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f749832c118) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f749832b9b8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f749832b9b8, com_data=0x7f7492e76da0, cmd=0x7f7492e76d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f749832a960) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 93 (Thread 0x7f74935af700 (LWP 14372)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7494300b00, __fd=807) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7494300b00, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7494077e00, buf=0x7f7494300b00 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74941f43c8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74941f43c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74941f43c8, complen=0x7f74935aece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74941f43c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74941f3c68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74941f3c68, com_data=0x7f74935aeda0, cmd=0x7f74935aed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74941f2c10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 92 (Thread 0x7f7491f41700 (LWP 14373)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a004c380, __fd=808) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a004c380, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a02feec0, buf=0x7f74a004c380 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a05289f8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a05289f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a05289f8, complen=0x7f7491f40ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a05289f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a0528298) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a0528298, com_data=0x7f7491f40da0, cmd=0x7f7491f40d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a0527240) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 91 (Thread 0x7f7493bdf700 (LWP 14375)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749c1ad0a0, __fd=809) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749c1ad0a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f749c0886d0, buf=0x7f749c1ad0a0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f749c4e0f28, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f749c4e0f28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f749c4e0f28, complen=0x7f7493bdece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f749c4e0f28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f749c4e07c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f749c4e07c8, com_data=0x7f7493bdeda0, cmd=0x7f7493bded90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f749c4df770) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 90 (Thread 0x7f74936b7700 (LWP 14376)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a80008e0, __fd=810) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a80008e0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a864a5a0, buf=0x7f74a80008e0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a86533f8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a86533f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a86533f8, complen=0x7f74936b6ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a86533f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a8652c98) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a8652c98, com_data=0x7f74936b6da0, cmd=0x7f74936b6d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a8651c40) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 89 (Thread 0x7f7492adb700 (LWP 14377)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a41ded70, __fd=811) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a41ded70, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a401dee0, buf=0x7f74a41ded70 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a42566d8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a42566d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a42566d8, complen=0x7f7492adace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a42566d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a4255f78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a4255f78, com_data=0x7f7492adada0, cmd=0x7f7492adad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a4254f20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 88 (Thread 0x7f7491b21700 (LWP 14378)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b1aeb6c0, __fd=812) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b1aeb6c0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b1da6a80, buf=0x7f74b1aeb6c0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b1d6c288, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b1d6c288) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b1d6c288, complen=0x7f7491b20ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b1d6c288) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b1d6bb28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b1d6bb28, com_data=0x7f7491b20da0, cmd=0x7f7491b20d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b1d6aad0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 87 (Thread 0x7f7492a15700 (LWP 14379)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ae37d5f0, __fd=813) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ae37d5f0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74adeef440, buf=0x7f74ae37d5f0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ae8d7db8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ae8d7db8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ae8d7db8, complen=0x7f7492a14ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ae8d7db8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ae8d7658) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ae8d7658, com_data=0x7f7492a14da0, cmd=0x7f7492a14d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ae8d6600) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 86 (Thread 0x7f7493dad700 (LWP 14380)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b9dc4640, __fd=814) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b9dc4640, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b8330b50, buf=0x7f74b9dc4640 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b8bc5678, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b8bc5678) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b8bc5678, complen=0x7f7493dacce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b8bc5678) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b8bc4f18) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b8bc4f18, com_data=0x7f7493dacda0, cmd=0x7f7493dacd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b8bc3ec0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 85 (Thread 0x7f7493a53700 (LWP 14381)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b4145880, __fd=815) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b4145880, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b4182a70, buf=0x7f74b4145880 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b4002078, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b4002078) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b4002078, complen=0x7f7493a52ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b4002078) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b4001918) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b4001918, com_data=0x7f7493a52da0, cmd=0x7f7493a52d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b40008c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 84 (Thread 0x7f7493909700 (LWP 14382)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c0363550, __fd=816) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c0363550, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c01d85e0, buf=0x7f74c0363550 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c0243f38, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c0243f38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c0243f38, complen=0x7f7493908ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c0243f38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c02437d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c02437d8, com_data=0x7f7493908da0, cmd=0x7f7493908d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c0242780) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 83 (Thread 0x7f749373b700 (LWP 14383)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74bc1c5e10, __fd=817) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74bc1c5e10, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74bc33d9c0, buf=0x7f74bc1c5e10 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74bc126d88, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74bc126d88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74bc126d88, complen=0x7f749373ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74bc126d88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74bc126628) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74bc126628, com_data=0x7f749373ada0, cmd=0x7f749373ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74bc1255d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 82 (Thread 0x7f74938c7700 (LWP 14385)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ca1fd120, __fd=818) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ca1fd120, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ca32f130, buf=0x7f74ca1fd120 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c822dd58, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c822dd58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c822dd58, complen=0x7f74938c6ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c822dd58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c822d5f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c822d5f8, com_data=0x7f74938c6da0, cmd=0x7f74938c6d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c822c5a0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 81 (Thread 0x7f7492d6f700 (LWP 14386)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c5f71b50, __fd=819) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c5f71b50, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c5c0f550, buf=0x7f74c5f71b50 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c6ef5288, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c6ef5288) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c6ef5288, complen=0x7f7492d6ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c6ef5288) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c6ef4b28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c6ef4b28, com_data=0x7f7492d6eda0, cmd=0x7f7492d6ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c6ef3ad0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 80 (Thread 0x7f7491b63700 (LWP 14387)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d04479d0, __fd=820) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d04479d0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d03181b0, buf=0x7f74d04479d0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d00b0098, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d00b0098) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d00b0098, complen=0x7f7491b62ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d00b0098) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d00af938) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d00af938, com_data=0x7f7491b62da0, cmd=0x7f7491b62d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d00ae8e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 79 (Thread 0x7f7492ba1700 (LWP 14389)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74cc3baf60, __fd=821) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74cc3baf60, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74cc4137f0, buf=0x7f74cc3baf60 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ce1d90a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ce1d90a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ce1d90a8, complen=0x7f7492ba0ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ce1d90a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ce1d8948) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ce1d8948, com_data=0x7f7492ba0da0, cmd=0x7f7492ba0d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ce1d78f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 78 (Thread 0x7f74932d9700 (LWP 14390)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d8364130, __fd=822) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d8364130, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d81a4470, buf=0x7f74d8364130 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d8232318, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d8232318) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d8232318, complen=0x7f74932d8ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d8232318) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d8231bb8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d8231bb8, com_data=0x7f74932d8da0, cmd=0x7f74932d8d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d8230b60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 77 (Thread 0x7f7492fc1700 (LWP 14391)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d4012330, __fd=823) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d4012330, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d49e21c0, buf=0x7f74d4012330 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d4cbc218, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d4cbc218) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d4cbc218, complen=0x7f7492fc0ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d4cbc218) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d4cbbab8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d4cbbab8, com_data=0x7f7492fc0da0, cmd=0x7f7492fc0d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d4cbaa60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 76 (Thread 0x7f749377d700 (LWP 14393)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e2072f10, __fd=824) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e2072f10, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e23fdcb0, buf=0x7f74e2072f10 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e1f69088, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e1f69088) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e1f69088, complen=0x7f749377cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e1f69088) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e1f68928) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e1f68928, com_data=0x7f749377cda0, cmd=0x7f749377cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e1f678d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 75 (Thread 0x7f75103fa700 (LWP 14394)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74dc88d0a0, __fd=825) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74dc88d0a0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74dc073e40, buf=0x7f74dc88d0a0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74dc1dad58, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74dc1dad58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74dc1dad58, complen=0x7f75103f9ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74dc1dad58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74dc1da5f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74dc1da5f8, com_data=0x7f75103f9da0, cmd=0x7f75103f9d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74dc1d95a0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 74 (Thread 0x7f7510334700 (LWP 14395)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e80e2090, __fd=826) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e80e2090, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e8338a50, buf=0x7f74e80e2090 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e831bc58, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e831bc58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e831bc58, complen=0x7f7510333ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e831bc58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e831b4f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e831b4f8, com_data=0x7f7510333da0, cmd=0x7f7510333d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e831a4a0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 73 (Thread 0x7f7492d2d700 (LWP 14397)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e43a61d0, __fd=827) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e43a61d0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e474aec0, buf=0x7f74e43a61d0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e40296c8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e40296c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e40296c8, complen=0x7f7492d2cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e40296c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e4028f68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e4028f68, com_data=0x7f7492d2cda0, cmd=0x7f7492d2cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e4027f10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 72 (Thread 0x7f7493465700 (LWP 14398)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f093fd00, __fd=828) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f093fd00, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f034af50, buf=0x7f74f093fd00 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f0509e38, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f0509e38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f0509e38, complen=0x7f7493464ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f0509e38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f05096d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f05096d8, com_data=0x7f7493464da0, cmd=0x7f7493464d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f0508680) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 71 (Thread 0x7f7492a57700 (LWP 14399)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ec12e7f0, __fd=829) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ec12e7f0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ec0b2a60, buf=0x7f74ec12e7f0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ec2bbf38, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ec2bbf38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ec2bbf38, complen=0x7f7492a56ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ec2bbf38) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ec2bb7d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ec2bb7d8, com_data=0x7f7492a56da0, cmd=0x7f7492a56d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ec2ba780) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 70 (Thread 0x7f7510124700 (LWP 14401)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f8c5f990, __fd=830) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f8c5f990, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f8b97c20, buf=0x7f74f8c5f990 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f80333c8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f80333c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f80333c8, complen=0x7f7510123ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f80333c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f8032c68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f8032c68, com_data=0x7f7510123da0, cmd=0x7f7510123d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f8031c10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 69 (Thread 0x7f7492f7f700 (LWP 14402)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f538ae90, __fd=831) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f538ae90, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f41d25e0, buf=0x7f74f538ae90 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f41a24e8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f41a24e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f41a24e8, complen=0x7f7492f7ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f41a24e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f41a1d88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f41a1d88, com_data=0x7f7492f7eda0, cmd=0x7f7492f7ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f41a0d30) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 68 (Thread 0x7f7510754700 (LWP 14403)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750037c3b0, __fd=832) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750037c3b0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f750037c0e0, buf=0x7f750037c3b0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f7502231358, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f7502231358) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f7502231358, complen=0x7f7510753ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f7502231358) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f7502230bf8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f7502230bf8, com_data=0x7f7510753da0, cmd=0x7f7510753d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750222fba0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 67 (Thread 0x7f749339f700 (LWP 14404)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74fc3a6e30, __fd=833) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74fc3a6e30, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74fc28b5f0, buf=0x7f74fc3a6e30 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74fc022768, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74fc022768) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74fc022768, complen=0x7f749339ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74fc022768) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74fc022008) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74fc022008, com_data=0x7f749339eda0, cmd=0x7f749339ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74fc020fb0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 66 (Thread 0x7f7492679700 (LWP 14405)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f75081568c0, __fd=834) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f75081568c0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f75081542a0, buf=0x7f75081568c0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f7508cf8518, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f7508cf8518) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f7508cf8518, complen=0x7f7492678ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f7508cf8518) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f7508cf7db8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f7508cf7db8, com_data=0x7f7492678da0, cmd=0x7f7492678d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f7508cf6d60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 65 (Thread 0x7f749318f700 (LWP 14406)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7505d5ea60, __fd=835) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7505d5ea60, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f75058b67b0, buf=0x7f7505d5ea60 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f7505cc3ef8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f7505cc3ef8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f7505cc3ef8, complen=0x7f749318ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f7505cc3ef8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f7505cc3798) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f7505cc3798, com_data=0x7f749318eda0, cmd=0x7f749318ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f7505cc2740) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 64 (Thread 0x7f74926bb700 (LWP 14407)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750cd620b0, __fd=836) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750cd620b0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f750c1f2720, buf=0x7f750cd620b0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750c7730d8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750c7730d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750c7730d8, complen=0x7f74926bace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750c7730d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750c772978) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750c772978, com_data=0x7f74926bada0, cmd=0x7f74926bad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750c771920) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 63 (Thread 0x7f74927c3700 (LWP 14408)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0xd9b85d0, __fd=837) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0xd9b85d0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0xc1ed060, buf=0xd9b85d0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0xc150a18, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0xc150a18) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0xc150a18, complen=0x7f74927c2ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0xc150a18) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0xc1502b8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0xc1502b8, com_data=0x7f74927c2da0, cmd=0x7f74927c2d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0xc14f260) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc218b80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 62 (Thread 0x7f7493633700 (LWP 14409)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749a252d30, __fd=838) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749a252d30, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7498102a90, buf=0x7f749a252d30 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74982bfea8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74982bfea8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74982bfea8, complen=0x7f7493632ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74982bfea8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74982bf748) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74982bf748, com_data=0x7f7493632da0, cmd=0x7f7493632d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74982be6f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 61 (Thread 0x7f751081a700 (LWP 14410)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7494338960, __fd=839) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7494338960, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74941f6bb0, buf=0x7f7494338960 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f7494013808, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f7494013808) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f7494013808, complen=0x7f7510819ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f7494013808) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74940130a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74940130a8, com_data=0x7f7510819da0, cmd=0x7f7510819d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f7494012050) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 60 (Thread 0x7f7493a95700 (LWP 14411)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a02f0d20, __fd=840) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a02f0d20, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a01ee220, buf=0x7f74a02f0d20 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a0051b48, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a0051b48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a0051b48, complen=0x7f7493a94ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a0051b48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a00513e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a00513e8, com_data=0x7f7493a94da0, cmd=0x7f7493a94d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a0050390) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 59 (Thread 0x7f74939cf700 (LWP 14412)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749c097560, __fd=841) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749c097560, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f749c2c3190, buf=0x7f749c097560 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f749c1a6c58, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f749c1a6c58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f749c1a6c58, complen=0x7f74939cece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f749c1a6c58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f749c1a64f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f749c1a64f8, com_data=0x7f74939ceda0, cmd=0x7f74939ced90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f749c1a54a0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 58 (Thread 0x7f749356d700 (LWP 14414)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a864cb80, __fd=842) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a864cb80, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a80d84f0, buf=0x7f74a864cb80 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a80de6b8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a80de6b8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a80de6b8, complen=0x7f749356cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a80de6b8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a80ddf58) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a80ddf58, com_data=0x7f749356cda0, cmd=0x7f749356cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a80dcf00) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 57 (Thread 0x7f74925f5700 (LWP 14415)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a60e1f80, __fd=843) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a60e1f80, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a41a0d60, buf=0x7f74a60e1f80 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a41eda28, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a41eda28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a41eda28, complen=0x7f74925f4ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a41eda28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a41ed2c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a41ed2c8, com_data=0x7f74925f4da0, cmd=0x7f74925f4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a41ec270) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 56 (Thread 0x7f7492ceb700 (LWP 14416)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b1db1880, __fd=844) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b1db1880, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b1d4ccb0, buf=0x7f74b1db1880 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b1d95e88, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b1d95e88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b1d95e88, complen=0x7f7492ceace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b1d95e88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b1d95728) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b1d95728, com_data=0x7f7492ceada0, cmd=0x7f7492cead90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b1d946d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 55 (Thread 0x7f751022c700 (LWP 14417)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ad900460, __fd=845) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ad900460, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ae6f4970, buf=0x7f74ad900460 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74aec63878, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74aec63878) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74aec63878, complen=0x7f751022bce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74aec63878) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74aec63118) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74aec63118, com_data=0x7f751022bda0, cmd=0x7f751022bd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74aec620c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 54 (Thread 0x7f7510376700 (LWP 14418)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ba1f4330, __fd=846) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ba1f4330, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ba210b70, buf=0x7f74ba1f4330 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b9fd9a88, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b9fd9a88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b9fd9a88, complen=0x7f7510375ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b9fd9a88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b9fd9328) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b9fd9328, com_data=0x7f7510375da0, cmd=0x7f7510375d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b9fd82d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 53 (Thread 0x7f7492e35700 (LWP 14419)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b4499280, __fd=847) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b4499280, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b4522950, buf=0x7f74b4499280 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b477cec8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b477cec8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b477cec8, complen=0x7f7492e34ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b477cec8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b477c768) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b477c768, com_data=0x7f7492e34da0, cmd=0x7f7492e34d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b477b710) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 52 (Thread 0x7f7493ef7700 (LWP 14421)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c057ce90, __fd=848) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c057ce90, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c0320a00, buf=0x7f74c057ce90 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c022aca8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c022aca8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c022aca8, complen=0x7f7493ef6ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c022aca8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c022a548) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c022a548, com_data=0x7f7493ef6da0, cmd=0x7f7493ef6d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c02294f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 51 (Thread 0x7f7491ebd700 (LWP 14422)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74bc0dc700, __fd=849) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74bc0dc700, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74bc272390, buf=0x7f74bc0dc700 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74bc0bddf8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74bc0bddf8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74bc0bddf8, complen=0x7f7491ebcce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74bc0bddf8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74bc0bd698) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74bc0bd698, com_data=0x7f7491ebcda0, cmd=0x7f7491ebcd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74bc0bc640) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 50 (Thread 0x7f7492637700 (LWP 14423)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c89df270, __fd=850) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c89df270, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c9ec08b0, buf=0x7f74c89df270 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ca706d18, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ca706d18) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ca706d18, complen=0x7f7492636ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ca706d18) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ca7065b8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ca7065b8, com_data=0x7f7492636da0, cmd=0x7f7492636d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ca705560) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 49 (Thread 0x7f7492efb700 (LWP 14425)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c69c4400, __fd=851) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c69c4400, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c433c500, buf=0x7f74c69c4400 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c70493e8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c70493e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c70493e8, complen=0x7f7492eface0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c70493e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c7048c88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c7048c88, com_data=0x7f7492efada0, cmd=0x7f7492efad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c7047c30) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 48 (Thread 0x7f751068e700 (LWP 14426)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d0310380, __fd=852) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d0310380, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d0365240, buf=0x7f74d0310380 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d02c2e78, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d02c2e78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d02c2e78, complen=0x7f751068dce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d02c2e78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d02c2718) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d02c2718, com_data=0x7f751068dda0, cmd=0x7f751068dd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d02c16c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 47 (Thread 0x7f7493087700 (LWP 14427)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74cc320700, __fd=853) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74cc320700, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74cd824ee0, buf=0x7f74cc320700 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74cc046368, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74cc046368) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74cc046368, complen=0x7f7493086ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74cc046368) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74cc045c08) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74cc045c08, com_data=0x7f7493086da0, cmd=0x7f7493086d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74cc044bb0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 46 (Thread 0x7f749294f700 (LWP 14429)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d82c3ec0, __fd=855) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d82c3ec0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74da4abaf0, buf=0x7f74d82c3ec0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d81abc88, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d81abc88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d81abc88, complen=0x7f749294ece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d81abc88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d81ab528) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d81ab528, com_data=0x7f749294eda0, cmd=0x7f749294ed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d81aa4d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 45 (Thread 0x7f7510166700 (LWP 14430)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d6570390, __fd=856) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d6570390, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d6754870, buf=0x7f74d6570390 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d4a49658, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d4a49658) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d4a49658, complen=0x7f7510165ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d4a49658) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d4a48ef8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d4a48ef8, com_data=0x7f7510165da0, cmd=0x7f7510165d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d4a47ea0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 44 (Thread 0x7f74923e5700 (LWP 14431)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e0b8e850, __fd=857) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e0b8e850, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e279fd50, buf=0x7f74e0b8e850 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e02df218, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e02df218) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e02df218, complen=0x7f74923e4ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e02df218) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e02deab8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e02deab8, com_data=0x7f74923e4da0, cmd=0x7f74923e4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e02dda60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 43 (Thread 0x7f7492151700 (LWP 14433)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74dc2ff800, __fd=858) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74dc2ff800, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74dc89ab80, buf=0x7f74dc2ff800 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74dc892868, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74dc892868) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74dc892868, complen=0x7f7492150ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74dc892868) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74dc892108) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74dc892108, com_data=0x7f7492150da0, cmd=0x7f7492150d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74dc8910b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 42 (Thread 0x7f7493045700 (LWP 14434)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e8415ef0, __fd=861) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e8415ef0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e808f6a0, buf=0x7f74e8415ef0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e80ca1a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e80ca1a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e80ca1a8, complen=0x7f7493044ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e80ca1a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e80c9a48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e80c9a48, com_data=0x7f7493044da0, cmd=0x7f7493044d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e80c89f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 41 (Thread 0x7f7492781700 (LWP 14435)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e42e0530, __fd=862) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e42e0530, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e47d8010, buf=0x7f74e42e0530 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e477e8c8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e477e8c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e477e8c8, complen=0x7f7492780ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e477e8c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e477e168) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e477e168, com_data=0x7f7492780da0, cmd=0x7f7492780d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e477d110) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7f751060a700 (LWP 14436)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f0283ef0, __fd=864) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f0283ef0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f0943d30, buf=0x7f74f0283ef0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f1f19468, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f1f19468) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f1f19468, complen=0x7f7510609ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f1f19468) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f1f18d08) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f1f18d08, com_data=0x7f7510609da0, cmd=0x7f7510609d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f1f17cb0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 39 (Thread 0x7f75105c8700 (LWP 14437)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ec4728f0, __fd=865) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ec4728f0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ec01c780, buf=0x7f74ec4728f0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ec91bcc8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ec91bcc8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ec91bcc8, complen=0x7f75105c7ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ec91bcc8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ec91b568) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ec91b568, com_data=0x7f75105c7da0, cmd=0x7f75105c7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ec91a510) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 38 (Thread 0x7f7493d6b700 (LWP 14438)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f81ecf00, __fd=866) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f81ecf00, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f86df710, buf=0x7f74f81ecf00 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f86cab88, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f86cab88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f86cab88, complen=0x7f7493d6ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f86cab88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f86ca428) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f86ca428, com_data=0x7f7493d6ada0, cmd=0x7f7493d6ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f86c93d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7f7492c67700 (LWP 14440)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f5f5b290, __fd=1072) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f5f5b290, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f5aebc90, buf=0x7f74f5f5b290 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f4ec64e8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f4ec64e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f4ec64e8, complen=0x7f7492c66ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f4ec64e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f4ec5d88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f4ec5d88, com_data=0x7f7492c66da0, cmd=0x7f7492c66d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f4ec4d30) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 36 (Thread 0x7f74923a3700 (LWP 14441)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7500160d80, __fd=1101) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7500160d80, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7500320a30, buf=0x7f7500160d80 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750229d118, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750229d118) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750229d118, complen=0x7f74923a2ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750229d118) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750229c9b8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750229c9b8, com_data=0x7f74923a2da0, cmd=0x7f74923a2d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750229b960) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7f7493b5b700 (LWP 14442)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74fc02bf00, __fd=1102) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74fc02bf00, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74fc03acb0, buf=0x7f74fc02bf00 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74fc3ac5f8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74fc3ac5f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74fc3ac5f8, complen=0x7f7493b5ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74fc3ac5f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74fc3abe98) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74fc3abe98, com_data=0x7f7493b5ada0, cmd=0x7f7493b5ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74fc3aae40) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7f75102b0700 (LWP 14444)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750827fe90, __fd=1103) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750827fe90, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7508d002c0, buf=0x7f750827fe90 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750815c088, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750815c088) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750815c088, complen=0x7f75102afce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750815c088) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750815b928) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750815b928, com_data=0x7f75102afda0, cmd=0x7f75102afd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750815a8d0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7f75100e2700 (LWP 14445)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7505d5a750, __fd=1105) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7505d5a750, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7505d9dab0, buf=0x7f7505d5a750 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f7505ce4038, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f7505ce4038) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f7505ce4038, complen=0x7f75100e1ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f7505ce4038) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f7505ce38d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f7505ce38d8, com_data=0x7f75100e1da0, cmd=0x7f75100e1d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f7505ce2880) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7f74937bf700 (LWP 14446)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f750c307510, __fd=1106) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f750c307510, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f750c275f40, buf=0x7f750c307510 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750d0946d8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750d0946d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750d0946d8, complen=0x7f74937bece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750d0946d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750d093f78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750d093f78, com_data=0x7f74937beda0, cmd=0x7f74937bed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750d092f20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7f749229b700 (LWP 14448)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0xddc0dd0, __fd=1107) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0xddc0dd0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0xc23e900, buf=0xddc0dd0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0xc27e7a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0xc27e7a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0xc27e7a8, complen=0x7f749229ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0xc27e7a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0xc27e048) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0xc27e048, com_data=0x7f749229ada0, cmd=0x7f749229ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0xc27cff0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0e6ae0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7f75101ea700 (LWP 14449)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749a59df90, __fd=1109) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749a59df90, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74980bbfd0, buf=0x7f749a59df90 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74982bc5d8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74982bc5d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74982bc5d8, complen=0x7f75101e9ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74982bc5d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74982bbe78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74982bbe78, com_data=0x7f75101e9da0, cmd=0x7f75101e9d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74982bae20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7f7491fc5700 (LWP 14450)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f7494308470, __fd=1110) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f7494308470, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74941f6f40, buf=0x7f7494308470 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74941f0798, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74941f0798) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74941f0798, complen=0x7f7491fc4ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74941f0798) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74941f0038) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74941f0038, com_data=0x7f7491fc4da0, cmd=0x7f7491fc4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74941eefe0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7f7493c63700 (LWP 14452)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a04ff2c0, __fd=1111) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a04ff2c0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a0010690, buf=0x7f74a04ff2c0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a02f64e8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a02f64e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a02f64e8, complen=0x7f7493c62ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a02f64e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a02f5d88) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a02f5d88, com_data=0x7f7493c62da0, cmd=0x7f7493c62d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a02f4d30) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7f751085c700 (LWP 14453)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f749c539620, __fd=1112) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f749c539620, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f749c6161f0, buf=0x7f749c539620 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f749c4ac668, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f749c4ac668) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f749c4ac668, complen=0x7f751085bce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f749c4ac668) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f749c4abf08) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f749c4abf08, com_data=0x7f751085bda0, cmd=0x7f751085bd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f749c4aaeb0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7f7493fbd700 (LWP 14454)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a80d2240, __fd=1113) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a80d2240, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a808efc0, buf=0x7f74a80d2240 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a8092678, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a8092678) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a8092678, complen=0x7f7493fbcce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a8092678) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a8091f18) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a8091f18, com_data=0x7f7493fbcda0, cmd=0x7f7493fbcd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a8090ec0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7f7493213700 (LWP 14455)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74a408be30, __fd=1114) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74a408be30, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74a42f4ed0, buf=0x7f74a408be30 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74a41001a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74a41001a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74a41001a8, complen=0x7f7493212ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74a41001a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74a40ffa48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74a40ffa48, com_data=0x7f7493212da0, cmd=0x7f7493212d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74a40fe9f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7f7492259700 (LWP 14456)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b1d9b510, __fd=1115) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b1d9b510, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b0030750, buf=0x7f74b1d9b510 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b1d99418, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b1d99418) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b1d99418, complen=0x7f7492258ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b1d99418) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b1d98cb8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b1d98cb8, com_data=0x7f7492258da0, cmd=0x7f7492258d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b1d97c60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7f7493f7b700 (LWP 14457)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ae33a560, __fd=1116) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ae33a560, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74adea7500, buf=0x7f74ae33a560 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74aec1acf8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74aec1acf8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74aec1acf8, complen=0x7f7493f7ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74aec1acf8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74aec1a598) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74aec1a598, com_data=0x7f7493f7ada0, cmd=0x7f7493f7ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74aec19540) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7f7492991700 (LWP 14459)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ba126410, __fd=1117) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ba126410, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b9eb2bc0, buf=0x7f74ba126410 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ba045cd8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ba045cd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ba045cd8, complen=0x7f7492990ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ba045cd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ba045578) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ba045578, com_data=0x7f7492990da0, cmd=0x7f7492990d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ba044520) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7f7493d29700 (LWP 14460)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74b4086f20, __fd=1118) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74b4086f20, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74b42702c0, buf=0x7f74b4086f20 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74b4184538, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74b4184538) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74b4184538, complen=0x7f7493d28ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74b4184538) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74b4183dd8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74b4183dd8, com_data=0x7f7493d28da0, cmd=0x7f7493d28d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74b4182d80) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7f7492805700 (LWP 14461)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c01cb460, __fd=1119) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c01cb460, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c0234370, buf=0x7f74c01cb460 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c01c3898, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c01c3898) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c01c3898, complen=0x7f7492804ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c01c3898) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c01c3138) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c01c3138, com_data=0x7f7492804da0, cmd=0x7f7492804d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c01c20e0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7f751043c700 (LWP 14463)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74bc346940, __fd=1120) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74bc346940, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74bc1c5a60, buf=0x7f74bc346940 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74bc0e1ec8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74bc0e1ec8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74bc0e1ec8, complen=0x7f751043bce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74bc0e1ec8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74bc0e1768) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74bc0e1768, com_data=0x7f751043bda0, cmd=0x7f751043bd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74bc0e0710) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7f7510544700 (LWP 14464)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c8007970, __fd=1121) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c8007970, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c802e980, buf=0x7f74c8007970 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ca5b7618, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ca5b7618) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ca5b7618, complen=0x7f7510543ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ca5b7618) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ca5b6eb8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ca5b6eb8, com_data=0x7f7510543da0, cmd=0x7f7510543d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ca5b5e60) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7f7491e7b700 (LWP 14465)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74c5aa6540, __fd=1122) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74c5aa6540, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74c610a100, buf=0x7f74c5aa6540 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74c45009a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74c45009a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74c45009a8, complen=0x7f7491e7ace0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74c45009a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74c4500248) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74c4500248, com_data=0x7f7491e7ada0, cmd=0x7f7491e7ad90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74c44ff1f0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7f7493423700 (LWP 14467)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d0198360, __fd=1123) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d0198360, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d052cbe0, buf=0x7f74d0198360 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d02143a8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d02143a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d02143a8, complen=0x7f7493422ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d02143a8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d0213c48) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d0213c48, com_data=0x7f7493422da0, cmd=0x7f7493422d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d0212bf0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7f7493b9d700 (LWP 14468)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ce3c3bf0, __fd=1124) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ce3c3bf0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ce1050b0, buf=0x7f74ce3c3bf0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74cd9bfd28, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74cd9bfd28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74cd9bfd28, complen=0x7f7493b9cce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74cd9bfd28) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74cd9bf5c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74cd9bf5c8, com_data=0x7f7493b9cda0, cmd=0x7f7493b9cd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74cd9be570) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7f7493eb5700 (LWP 14469)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d81a4710, __fd=1126) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d81a4710, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d8234110, buf=0x7f74d81a4710 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74da4a72c8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74da4a72c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74da4a72c8, complen=0x7f7493eb4ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74da4a72c8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74da4a6b68) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74da4a6b68, com_data=0x7f7493eb4da0, cmd=0x7f7493eb4d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74da4a5b10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7f751089e700 (LWP 14471)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74d4a4b880, __fd=1127) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74d4a4b880, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74d50c7b20, buf=0x7f74d4a4b880 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74d4c7a528, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74d4c7a528) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74d4c7a528, complen=0x7f751089dce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74d4c7a528) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74d4c79dc8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74d4c79dc8, com_data=0x7f751089dda0, cmd=0x7f751089dd90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74d4c78d70) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7f7510586700 (LWP 14472)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e25a4200, __fd=1149) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e25a4200, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e25d4a70, buf=0x7f74e25a4200 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e250b9f8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e250b9f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e250b9f8, complen=0x7f7510585ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e250b9f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e250b298) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e250b298, com_data=0x7f7510585da0, cmd=0x7f7510585d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e250a240) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7f7493fff700 (LWP 14473)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74dc06b810, __fd=1150) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74dc06b810, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74dc0a4ef0, buf=0x7f74dc06b810 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74dc002078, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74dc002078) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74dc002078, complen=0x7f7493ffece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74dc002078) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74dc001918) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74dc001918, com_data=0x7f7493ffeda0, cmd=0x7f7493ffed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74dc0008c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7f7493675700 (LWP 14475)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e8329440, __fd=1192) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e8329440, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e8cac8f0, buf=0x7f74e8329440 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e8091748, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e8091748) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e8091748, complen=0x7f7493674ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e8091748) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e8090fe8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e8090fe8, com_data=0x7f7493674da0, cmd=0x7f7493674d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e808ff90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7f7511165700 (LWP 14476)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74e41f1fa0, __fd=1197) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74e41f1fa0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74e42177e0, buf=0x7f74e41f1fa0 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74e455f038, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74e455f038) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74e455f038, complen=0x7f7511164ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74e455f038) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74e455e8d8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74e455e8d8, com_data=0x7f7511164da0, cmd=0x7f7511164d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74e455d880) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfccaa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7f7492be3700 (LWP 14482)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f01e3ac0, __fd=1153) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f01e3ac0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f1cec920, buf=0x7f74f01e3ac0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f1f56258, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f1f56258) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f1f56258, complen=0x7f7492be2ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f1f56258) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f1f55af8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f1f55af8, com_data=0x7f7492be2da0, cmd=0x7f7492be2d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f1f54aa0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0eb230) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7f7493885700 (LWP 14483)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ec3cc560, __fd=1164) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ec3cc560, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ec45fa30, buf=0x7f74ec3cc560 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ec3a87f8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ec3a87f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ec3a87f8, complen=0x7f7493884ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ec3a87f8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ec3a8098) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ec3a8098, com_data=0x7f7493884da0, cmd=0x7f7493884d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ec3a7040) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc0eb230) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7f74935f1700 (LWP 14666)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74f6bd6330, __fd=160) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74f6bd6330, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74f6a03140, buf=0x7f74f6bd6330 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74f42750e8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74f42750e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74f42750e8, complen=0x7f74935f0ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74f42750e8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74f4274988) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74f4274988, com_data=0x7f74935f0da0, cmd=0x7f74935f0d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74f4273930) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc17e070) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7f7491eff700 (LWP 14694)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f75005062d0, __fd=726) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f75005062d0, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f7501f5e690, buf=0x7f75005062d0 "\a", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f750005eef8, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f750005eef8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f750005eef8, complen=0x7f7491efece0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f750005eef8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f750005e798) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f750005e798, com_data=0x7f7491efeda0, cmd=0x7f7491efed90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f750005d740) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xc17e070) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7f7492847700 (LWP 17203)):
#0  0x00007f76932daa8b in recv () from /lib64/libpthread.so.0
#1  0x00000000012e73b7 in recv (__flags=0, __n=4, __buf=0x7f74ec2a8290, __fd=1198) at /usr/include/bits/socket2.h:44
#2  inline_mysql_socket_recv (src_file=0x16732d0 "/export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c", src_line=123, flags=0, n=4, buf=0x7f74ec2a8290, mysql_socket=...) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#3  vio_read (vio=0x7f74ec0b2fb0, buf=0x7f74ec2a8290 "\001", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:123
#4  0x0000000000c2761f in net_read_raw_loop (net=net@entry=0x7f74ec2c1b78, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#5  0x0000000000c27923 in net_read_packet_header (net=0x7f74ec2c1b78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:756
#6  net_read_packet (net=0x7f74ec2c1b78, complen=0x7f7492846ce0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#7  0x0000000000c287d4 in my_net_read (net=0x7f74ec2c1b78) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#8  0x0000000000c3457c in Protocol_classic::read_packet (this=0x7f74ec2c1418) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:808
#9  0x0000000000c343eb in Protocol_classic::get_command (this=0x7f74ec2c1418, com_data=0x7f7492846da0, cmd=0x7f7492846d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/protocol_classic.cc:965
#10 0x0000000000cd62db in do_command (thd=thd@entry=0x7f74ec2c03c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/sql_parse.cc:964
#11 0x0000000000d98320 in handle_connection (arg=arg@entry=0xbfebb10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001280284 in pfs_spawn_thread (arg=0xd9b24c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#13 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7f751c642700 (LWP 24589)):
#0  0x00007f7691d8220d in poll () from /lib64/libc.so.6
#1  0x00000000012e7262 in poll (__timeout=60000, __nfds=1, __fds=0x7f751c641810) at /usr/include/bits/poll2.h:46
#2  vio_io_wait (vio=vio@entry=0x7f74a41eb7b0, event=event@entry=VIO_IO_EVENT_READ, timeout=60000) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:786
#3  0x00000000012e72f8 in vio_socket_io_wait (vio=vio@entry=0x7f74a41eb7b0, event=event@entry=VIO_IO_EVENT_READ) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:77
#4  0x00000000012e73ef in vio_read (vio=vio@entry=0x7f74a41eb7b0, buf=0x7f74a424c0b0 "(", size=size@entry=16384) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:132
#5  0x00000000012e74a1 in vio_read_buff (vio=0x7f74a41eb7b0, buf=0x7f74a40a7f40 "", size=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/vio/viosocket.c:166
#6  0x0000000000c2761f in net_read_raw_loop (net=0x7f74a4194c10, count=count@entry=4) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:672
#7  0x0000000000c27a50 in net_read_packet_header (net=0x7f74a4194c10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:762
#8  net_read_packet (net=0x7f74a4194c10, complen=0x7f751c641a50) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:822
#9  0x0000000000c287d4 in my_net_read (net=net@entry=0x7f74a4194c10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/net_serv.cc:899
#10 0x0000000000d8c3c2 in cli_safe_read_with_ok (mysql=0x7f74a4194c10, parse_ok=<optimized out>, is_data_packet=0x0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql-common/client.c:1061
#11 0x0000000000ec4893 in read_event (suppress_warnings=0x7f751c641b80, mi=0xc11c180, mysql=0x7f74a4194c10) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_slave.cc:4487
#12 handle_slave_io (arg=arg@entry=0xc11c180) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_slave.cc:5774
#13 0x0000000001280284 in pfs_spawn_thread (arg=0x7f74b87e43b0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#14 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#15 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7f749231f700 (LWP 24590)):
#0  pfs_unlock_mutex_v1 (mutex=0x7f768a383d40) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:3622
#1  0x0000000000f549d5 in pfs_exit (this=0x7f767f028750) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/include/ib0mutex.h:1139
#2  PolicyMutex<TTASEventMutex<GenericPolicy> >::exit (this=0x7f767f028750) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/include/ib0mutex.h:956
#3  0x0000000000f973d8 in lock_rec_lock_fast (thr=0x7f74b20de378, index=0x7f74c6cc72f8, heap_no=121, block=0x7f7645b9ecf0, mode=1027, impl=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/lock/lock0lock.cc:1922
#4  lock_rec_lock (impl=<optimized out>, mode=1027, block=0x7f7645b9ecf0, heap_no=121, index=0x7f74c6cc72f8, thr=0x7f74b20de378) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/lock/lock0lock.cc:2055
#5  0x0000000000f97e35 in lock_clust_rec_read_check_and_lock (flags=flags@entry=0, block=block@entry=0x7f7645b9ecf0, rec=rec@entry=0x7f764bc5dd72 "", index=index@entry=0x7f74c6cc72f8, offsets=offsets@entry=0x7f749231dc00, mode=mode@entry=LOCK_X, gap_mode=gap_mode@entry=1024, thr=thr@entry=0x7f74b20de378) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/lock/lock0lock.cc:6414
#6  0x000000000104ac3a in sel_set_rec_lock (pcur=pcur@entry=0x7f74b20ddd58, rec=rec@entry=0x7f764bc5dd72 "", index=index@entry=0x7f74c6cc72f8, offsets=0x7f749231dc00, mode=3, type=1024, thr=thr@entry=0x7f74b20de378, mtr=mtr@entry=0x7f749231df20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/row/row0sel.cc:1254
#7  0x0000000001053844 in row_search_mvcc (buf=buf@entry=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>, mode=mode@entry=PAGE_CUR_G, prebuilt=0x7f74b20ddb48, match_mode=match_mode@entry=0, direction=direction@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/row/row0sel.cc:5524
#8  0x0000000000f4804f in ha_innobase::index_read (this=0x7f74b001a5a0, buf=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>, key_ptr=<optimized out>, key_len=<optimized out>, find_flag=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:8740
#9  0x0000000000f36470 in ha_innobase::index_first (this=0x7f74b001a5a0, buf=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:9157
#10 0x0000000000f486bf in ha_innobase::rnd_next (this=0x7f74b001a5a0, buf=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:9255
#11 0x0000000000807fef in handler::ha_rnd_next (this=0x7f74b001a5a0, buf=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/handler.cc:2955
#12 0x0000000000e81671 in Rows_log_event::next_record_scan (this=this@entry=0x7f74b20f41e0, first_read=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/log_event.cc:10169
#13 0x0000000000e81fcf in Rows_log_event::do_scan_and_update (this=0x7f74b20f41e0, rli=0xc1b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/log_event.cc:10625
#14 0x0000000000e80ace in Rows_log_event::do_apply_event (this=0x7f74b20f41e0, rli=0xc1b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/log_event.cc:11280
#15 0x0000000000e7979d in Log_event::apply_event (this=this@entry=0x7f74b20f41e0, rli=rli@entry=0xc1b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/log_event.cc:3354
#16 0x0000000000ebf493 in apply_event_and_update_pos (ptr_ev=ptr_ev@entry=0x7f749231e9a0, thd=thd@entry=0x7f74b00008c0, rli=rli@entry=0xc1b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_slave.cc:4734
#17 0x0000000000ecc36a in exec_relay_log_event (rli=0xc1b7d90, thd=0x7f74b00008c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_slave.cc:5272
#18 handle_slave_sql (arg=arg@entry=0xc11c180) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_slave.cc:7463
#19 0x0000000001280284 in pfs_spawn_thread (arg=0x7f74b82eb490) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#20 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
#21 0x00007f7691d8cead in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7f76936fb780 (LWP 14195)):
#0  0x00007f7691d8220d in poll () from /lib64/libc.so.6
#1  0x0000000000d99fce in poll (__timeout=-1, __nfds=<optimized out>, __fds=0xc1023e0) at /usr/include/bits/poll2.h:41
#2  Mysqld_socket_listener::listen_for_connection_event (this=0xc102380) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
#3  0x00000000007b50e0 in connection_event_loop (this=0xc0ec380) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
#4  mysqld_main (argc=54, argv=0x33fa3b8) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/mysqld.cc:5149
#5  0x00007f7691cb13d5 in __libc_start_main () from /lib64/libc.so.6
#6  0x00000000007a95f4 in _start ()
