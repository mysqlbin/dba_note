Thread 62 (Thread 0x7f02dc8aa700 (LWP 13280)):
#0  0x00007f02e472658a in sigwaitinfo () from /lib64/libc.so.6
#1  0x0000000000f56eab in timer_notify_thread_func (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/mysys/posix_timers.c:77
#2  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x26120f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#3  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 61 (Thread 0x7f009e25e700 (LWP 13284)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009e25ddd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009e25ddd0, m1=0x7f009e25de88, m2=0x7f009e25de80, request=0x7f009e25de50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009e25de50, m2=0x7f009e25de80, m1=0x7f009e25de88, global_segment=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=0, m1=0x7f009e25de88, m2=0x7f009e25de80, request=0x7f009e25de50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 60 (Thread 0x7f009da5d700 (LWP 13285)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009da5cdd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009da5cdd0, m1=0x7f009da5ce88, m2=0x7f009da5ce80, request=0x7f009da5ce50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009da5ce50, m2=0x7f009da5ce80, m1=0x7f009da5ce88, global_segment=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=1, m1=0x7f009da5ce88, m2=0x7f009da5ce80, request=0x7f009da5ce50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 59 (Thread 0x7f009d25c700 (LWP 13286)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009d25bdd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009d25bdd0, m1=0x7f009d25be88, m2=0x7f009d25be80, request=0x7f009d25be50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009d25be50, m2=0x7f009d25be80, m1=0x7f009d25be88, global_segment=2) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=2, m1=0x7f009d25be88, m2=0x7f009d25be80, request=0x7f009d25be50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=2) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 58 (Thread 0x7f009ca5b700 (LWP 13287)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009ca5add0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009ca5add0, m1=0x7f009ca5ae88, m2=0x7f009ca5ae80, request=0x7f009ca5ae50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009ca5ae50, m2=0x7f009ca5ae80, m1=0x7f009ca5ae88, global_segment=3) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=3, m1=0x7f009ca5ae88, m2=0x7f009ca5ae80, request=0x7f009ca5ae50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=3) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 57 (Thread 0x7f009c25a700 (LWP 13288)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009c259dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009c259dd0, m1=0x7f009c259e88, m2=0x7f009c259e80, request=0x7f009c259e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009c259e50, m2=0x7f009c259e80, m1=0x7f009c259e88, global_segment=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=4, m1=0x7f009c259e88, m2=0x7f009c259e80, request=0x7f009c259e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 56 (Thread 0x7f009ba59700 (LWP 13289)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009ba58dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009ba58dd0, m1=0x7f009ba58e88, m2=0x7f009ba58e80, request=0x7f009ba58e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009ba58e50, m2=0x7f009ba58e80, m1=0x7f009ba58e88, global_segment=5) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=5, m1=0x7f009ba58e88, m2=0x7f009ba58e80, request=0x7f009ba58e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=5) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 55 (Thread 0x7f009b258700 (LWP 13290)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009b257dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009b257dd0, m1=0x7f009b257e88, m2=0x7f009b257e80, request=0x7f009b257e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009b257e50, m2=0x7f009b257e80, m1=0x7f009b257e88, global_segment=6) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=6, m1=0x7f009b257e88, m2=0x7f009b257e80, request=0x7f009b257e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=6) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 54 (Thread 0x7f009aa57700 (LWP 13291)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009aa56dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009aa56dd0, m1=0x7f009aa56e88, m2=0x7f009aa56e80, request=0x7f009aa56e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009aa56e50, m2=0x7f009aa56e80, m1=0x7f009aa56e88, global_segment=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=7, m1=0x7f009aa56e88, m2=0x7f009aa56e80, request=0x7f009aa56e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=7) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 53 (Thread 0x7f009a256700 (LWP 13292)):
#0  0x00007f02e5b2c644 in __io_getevents_0_4 () from /lib64/libaio.so.1
#1  0x00000000010bc854 in LinuxAIOHandler::collect (this=0x7f009a255dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2506
#2  0x00000000010bea94 in LinuxAIOHandler::poll (this=0x7f009a255dd0, m1=0x7f009a255e88, m2=0x7f009a255e80, request=0x7f009a255e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2666
#3  0x00000000010bee4c in os_aio_linux_handler (request=0x7f009a255e50, m2=0x7f009a255e80, m1=0x7f009a255e88, global_segment=8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:2722
#4  os_aio_handler (segment=8, m1=0x7f009a255e88, m2=0x7f009a255e80, request=0x7f009a255e50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:6268
#5  0x000000000125b78d in fil_aio_wait (segment=8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5854
#6  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#7  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 52 (Thread 0x7f0099a55700 (LWP 13293)):
#0  0x00007f02e5d3cd7d in fsync () from /lib64/libpthread.so.0
#1  0x00000000010bdf74 in os_file_fsync_posix (file=69) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:3073
#2  os_file_flush_func (file=69) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0file.cc:3177
#3  0x00000000012545b3 in pfs_os_file_flush_func (src_line=6035, file=..., src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/os0file.ic:505
#4  fil_flush (space_id=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:6035
#5  0x0000000001254805 in fil_flush_file_spaces (purpose=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:6128
#6  0x00000000011f55db in buf_dblwr_update (bpage=<optimized out>, flush_type=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0dblwr.cc:750
#7  0x00000000011e9a38 in buf_page_io_complete (bpage=0x7f01dbf5f300, evict=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:5876
#8  0x000000000125b84e in fil_aio_wait (segment=9) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:5888
#9  0x0000000001160a30 in io_handler_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0start.cc:311
#10 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#11 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 51 (Thread 0x7f0099254700 (LWP 13294)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x10180818) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x10180818, reset_sig_count=48343) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x00000000011f8d6e in buf_dblwr_add_to_batch (bpage=0x7f026f6d7e78) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0dblwr.cc:1110
#4  0x0000000001200d4b in buf_flush_write_block_low (sync=false, flush_type=BUF_FLUSH_LIST, bpage=0x7f026f6d7e78) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1099
#5  buf_flush_page (buf_pool=<optimized out>, bpage=0x7f026f6d7e78, flush_type=BUF_FLUSH_LIST, sync=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1230
#6  0x000000000120129e in buf_flush_try_neighbors (n_to_flush=714, n_flushed=481, flush_type=BUF_FLUSH_LIST, page_id=...) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1453
#7  buf_flush_page_and_try_neighbors (bpage=<optimized out>, flush_type=BUF_FLUSH_LIST, n_to_flush=714, count=0x7f0099253940) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1526
#8  0x00000000012025c2 in buf_do_flush_list_batch (lsn_limit=18446744073709551615, min_n=714, buf_pool=0x29463f8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1780
#9  buf_flush_batch (lsn_limit=18446744073709551615, min_n=714, flush_type=BUF_FLUSH_LIST, buf_pool=0x29463f8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1858
#10 buf_flush_do_batch (buf_pool=0x29463f8, type=BUF_FLUSH_LIST, min_n=714, lsn_limit=18446744073709551615, n_processed=0x10178020) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:2018
#11 0x000000000120327a in pc_flush_slot () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:2874
#12 0x00000000012037b5 in buf_flush_page_cleaner_coordinator (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3298
#13 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 50 (Thread 0x7f0098a53700 (LWP 13295)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x10180818) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x10180818, reset_sig_count=48343) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x00000000011f8d6e in buf_dblwr_add_to_batch (bpage=0x7f01b284c098) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0dblwr.cc:1110
#4  0x0000000001200d4b in buf_flush_write_block_low (sync=false, flush_type=BUF_FLUSH_LIST, bpage=0x7f01b284c098) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1099
#5  buf_flush_page (buf_pool=<optimized out>, bpage=0x7f01b284c098, flush_type=BUF_FLUSH_LIST, sync=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1230
#6  0x000000000120129e in buf_flush_try_neighbors (n_to_flush=701, n_flushed=536, flush_type=BUF_FLUSH_LIST, page_id=...) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1453
#7  buf_flush_page_and_try_neighbors (bpage=<optimized out>, flush_type=BUF_FLUSH_LIST, n_to_flush=701, count=0x7f0098a52c90) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1526
#8  0x00000000012025c2 in buf_do_flush_list_batch (lsn_limit=18446744073709551615, min_n=701, buf_pool=0x29468b8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1780
#9  buf_flush_batch (lsn_limit=18446744073709551615, min_n=701, flush_type=BUF_FLUSH_LIST, buf_pool=0x29468b8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:1858
#10 buf_flush_do_batch (buf_pool=0x29468b8, type=BUF_FLUSH_LIST, min_n=701, lsn_limit=18446744073709551615, n_processed=0x10178068) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:2018
#11 0x000000000120327a in pc_flush_slot () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:2874
#12 0x0000000001204ec5 in buf_flush_page_cleaner_worker (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0flu.cc:3504
#13 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 49 (Thread 0x7f00ab3a4700 (LWP 13300)):
#0  0x00007f02e5d39de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7f00ab3a3db0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x101760f8, time_in_usec=<optimized out>, reset_sig_count=310) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000109a924 in lock_wait_timeout_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/lock/lock0wait.cc:501
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 48 (Thread 0x7f00aaba3700 (LWP 13301)):
#0  0x00007f02e5d39de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7f00aaba2ac0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x26516c8, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000115e8f5 in srv_error_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:1751
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 47 (Thread 0x7f00aa3a2700 (LWP 13302)):
#0  0x00007f02e5d39de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7f00aa3a1e30) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x2651758, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x000000000115d985 in srv_monitor_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:1585
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 46 (Thread 0x7f00a9ba1700 (LWP 13303)):
#0  0x00007f02e5d3ce9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x000000000115dfab in srv_master_sleep () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2330
#3  srv_master_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2377
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 45 (Thread 0x7f00a93a0700 (LWP 13304)):
#0  0x00007f02e47d2917 in sched_yield () from /lib64/libc.so.6
#1  0x000000000117cedd in trx_purge_wait_for_workers_to_complete (purge_sys=0x101c45d8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/trx/trx0purge.cc:1785
#2  trx_purge (n_purge_threads=4, batch_size=300, truncate=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/trx/trx0purge.cc:1889
#3  0x000000000115fbd7 in srv_do_purge (n_total_purged=<optimized out>, n_threads=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2631
#4  srv_purge_coordinator_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2803
#5  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 44 (Thread 0x7f00a8b9f700 (LWP 13305)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2651518) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2651518, reset_sig_count=1437025) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 43 (Thread 0x7f00a3fff700 (LWP 13306)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2651638) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2651638, reset_sig_count=1378222) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000115d27e in srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2520
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 42 (Thread 0x7f00a37fe700 (LWP 13307)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0xbbc7c58) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0xbbc7c58, reset_sig_count=9) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x263a238, cell=@0x7f00a37fbe50: 0x7f02d1e48768) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d26a in rw_lock_x_lock_wait_func (line=153, file_name=0x162bf30 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic", threshold=0, lock=0x7f00a37fbe48) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:510
#5  rw_lock_x_lock_low (line=153, file_name=0x162bf30 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic", pass=1, lock=0x7f00a37fbe48) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:566
#6  rw_lock_x_lock_func (lock=0x7f00a37fbe48, pass=1, file_name=0x162bf30 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic", line=153) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:729
#7  0x00000000011d2536 in pfs_rw_lock_x_lock_func (line=153, file_name=0x162bf30 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic", lock=<optimized out>, pass=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#8  x_latch_at_savepoint (block=0x7f0168ae89f8, savepoint=<optimized out>, this=0x7f00a37fcec0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/mtr0mtr.ic:153
#9  btr_cur_search_to_nth_level (index=0x7f00200ab9b8, level=0, tuple=0x7f008800a048, mode=PAGE_CUR_LE, latch_mode=33, cursor=0x7f00a37fd4f0, has_search_latch=0, file=0x161efb0 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0row.cc", line=1075, mtr=0x7f00a37fcec0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1700
#10 0x000000000112e34b in btr_pcur_open_low (mtr=<optimized out>, line=1075, cursor=0x7f00a37fd4f0, latch_mode=65569, tuple=0x7f008800a048, index=0x7f00200ab9b8, level=<optimized out>, mode=<optimized out>, file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/btr0pcur.ic:465
#11 row_search_index_entry (index=0x7f00200ab9b8, entry=0x7f008800a048, mode=65569, pcur=0x7f00a37fd4f0, mtr=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0row.cc:1075
#12 0x000000000112b4e2 in row_purge_remove_sec_if_poss_tree (node=0x101c57a8, index=0x7f00200ab9b8, entry=0x7f008800a048) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0purge.cc:324
#13 0x000000000112cb89 in row_purge_remove_sec_if_poss (entry=0x7f008800a048, index=0x7f00200ab9b8, node=0x101c57a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0purge.cc:593
#14 row_purge_upd_exist_or_extern_func (node=0x101c57a8, undo_rec=0x7f00a4012f18 "\035W\f") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0purge.cc:710
#15 0x000000000112d0e8 in row_purge_record_func (updated_extern=<optimized out>, undo_rec=0x7f00a4012f18 "\035W\f", node=0x101c57a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0purge.cc:1002
#16 row_purge (thr=0x101c5320, undo_rec=0x7f00a4012f18 "\035W\f", node=0x101c57a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0purge.cc:1046
#17 row_purge_step (thr=0x101c5320) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0purge.cc:1125
#18 0x00000000010e3abf in que_thr_step (thr=0x101c5320) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/que/que0que.cc:1049
#19 que_run_threads_low (thr=0x101c5320) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/que/que0que.cc:1111
#20 que_run_threads (thr=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/que/que0que.cc:1151
#21 0x000000000115d1d0 in srv_task_execute () at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2472
#22 srv_worker_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0srv.cc:2522
#23 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 41 (Thread 0x7f00a2ffd700 (LWP 13308)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x26517e8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x26517e8, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x00000000011fcecc in buf_dump_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0dump.cc:782
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 40 (Thread 0x7f0091be7700 (LWP 13309)):
#0  0x00007f02e5d39de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7f0091be6dd0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x1017b838, time_in_usec=<optimized out>, reset_sig_count=537) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x0000000001246297 in dict_stats_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/dict/dict0stats_bg.cc:428
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 39 (Thread 0x7f00913e6700 (LWP 13310)):
#0  0x00007f02e5d39de2 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c380e in os_event::timed_wait (this=<optimized out>, abstime=0x7f00913e5ab0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:285
#2  0x00000000010c3b2e in os_event::wait_time_low (this=0x10344f98, time_in_usec=<optimized out>, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:412
#3  0x00000000011af7f4 in ib_wqueue_timedwait (wq=0x10344e68, wait_in_usecs=5000000) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/ut/ut0wqueue.cc:160
#4  0x000000000128f042 in fts_optimize_thread (arg=0x10344e68) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/fts/fts0opt.cc:2900
#5  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 38 (Thread 0x7f0090be5700 (LWP 13311)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x2651908) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x2651908, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x00000000011f337c in buf_resize_thread (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:3019
#4  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 37 (Thread 0x7f00a80dc700 (LWP 13320)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eb6120 in native_cond_wait (mutex=0x1043e620, cond=0x1043e650) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1043e620, cond=0x1043e650) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=751, src_file=0x15e7630 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_queue.cc", mutex=0x1043e620, that=0x1043e650) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Event_queue::cond_wait (this=0x1043e620, thd=0x1045bda0, abstime=0x0, stage=<optimized out>, src_func=0x15e7780 <Event_queue::get_top_for_execution_if_time(THD*, Event_queue_element_for_exec**)::__func__> "get_top_for_execution_if_time", src_file=0x15e7630 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_queue.cc", src_line=579) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_queue.cc:751
#5  0x0000000000eb70bc in Event_queue::get_top_for_execution_if_time (this=0x1043e620, thd=0x1045bda0, event_name=0x7f00a80dbe38) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_queue.cc:579
#6  0x0000000000eb893f in Event_scheduler::run (this=0x1043e6f0, thd=0x1045bda0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_scheduler.cc:519
#7  0x0000000000eb8abc in event_scheduler_thread (arg=0x104a9de0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/event_scheduler.cc:243
#8  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#9  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#10 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 36 (Thread 0x7f00a809a700 (LWP 13321)):
#0  0x00007f02e5d3d3c1 in sigwait () from /lib64/libpthread.so.0
#1  0x00000000007c70bb in signal_hand (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/mysqld.cc:2125
#2  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x103e1910) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#3  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 35 (Thread 0x7f007bfff700 (LWP 13322)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000ec1e35 in native_cond_wait (mutex=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=<optimized out>, cond=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=879, src_file=0x15e7fa0 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/rpl_gtid_persist.cc", mutex=<optimized out>, that=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  compress_gtid_table (p_thd=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/rpl_gtid_persist.cc:879
#5  0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#6  0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 34 (Thread 0x7f00a8058700 (LWP 13368)):
#0  0x00007f02e5d3caeb in recv () from /lib64/libpthread.so.0
#1  0x00000000012c5c70 in inline_mysql_socket_recv (flags=0, n=4, buf=0x7f007000a200, mysql_socket=..., src_line=123, src_file=0x1642a38 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_socket.h:808
#2  vio_read (vio=0x7f00700008e0, buf=0x7f007000a200 '-' <repeats 15 times>, "\nIbuf: size 1, free list len 866, seg size 868, 0 merges\nmerged operations:\n insert 0, delete mark 0, delete 0\ndiscarded operations:\n insert 0, delete mark 0, delete 0\nHash table size 2"..., size=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/vio/viosocket.c:123
#3  0x0000000000c6e8a3 in net_read_raw_loop (net=0x7f0070002298, count=4) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:672
#4  0x0000000000c6f13b in net_read_packet_header (net=0x7f0070002298) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:756
#5  net_read_packet (net=<optimized out>, complen=0x7f00a8057cf8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:822
#6  0x0000000000c6f3ec in my_net_read (net=0x7f0070002298) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/net_serv.cc:899
#7  0x0000000000c7cc8c in Protocol_classic::read_packet (this=0x7f0070001b38) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:808
#8  0x0000000000c7ba22 in Protocol_classic::get_command (this=0x7f0070001b38, com_data=0x7f00a8057da0, cmd=0x7f00a8057dcc) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/protocol_classic.cc:965
#9  0x0000000000d1e847 in do_command (thd=0x7f0070000ae0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:964
#10 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#11 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#12 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#13 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 33 (Thread 0x7f00a21f5700 (LWP 13461)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f00680ac880, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00680ac880, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00680ac880, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f00680ac880, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f00680ac880) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00680ac880, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0068018230, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0068018230, expanded_query=0x7f00a21f42b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00680ac880, stmt_id=<optimized out>, flags=0, params=0x7f006801208a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f00680ac880, com_data=0x7f00a21f4da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f00680ac880) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 32 (Thread 0x7f00a21b3700 (LWP 13462)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f006c4ce5a0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f006c4ce5a0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f006c4ce5a0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f006c4ce5a0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f006c4ce5a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f006c4ce5a0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f006c4cd930, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f006c4cd930, expanded_query=0x7f00a21b22b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f006c4ce5a0, stmt_id=<optimized out>, flags=0, params=0x7f006c01233a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f006c4ce5a0, com_data=0x7f00a21b2da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f006c4ce5a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 31 (Thread 0x7f00903e4700 (LWP 13463)):
#0  0x00007f02e47e4d7d in fdatasync () from /lib64/libc.so.6
#1  0x0000000000f4e240 in my_sync (fd=29, my_flags=48) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/mysys/my_sync.c:76
#2  0x0000000000ee893f in inline_mysql_file_sync (flags=48, fd=29, src_line=9229, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_file.h:1420
#3  MYSQL_BIN_LOG::sync_binlog_file (this=<optimized out>, force=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9227
#4  0x0000000000ef495a in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0060012450, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9664
#5  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0060012450, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#6  0x0000000000823434 in ha_commit_trans (thd=0x7f0060012450, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#7  0x0000000000dd38f9 in trans_commit (thd=0x7f0060012450) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#8  0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f0060012450, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#9  0x0000000000d45720 in Prepared_statement::execute (this=0x7f006000f560, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#10 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f006000f560, expanded_query=0x7f00903e32b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#11 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f0060012450, stmt_id=<optimized out>, flags=0, params=0x7f00600008ea "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#12 0x0000000000d1d3ef in dispatch_command (thd=0x7f0060012450, com_data=0x7f00903e3da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#13 0x0000000000d1e944 in do_command (thd=0x7f0060012450) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#14 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#16 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 30 (Thread 0x7f00903a2700 (LWP 13464)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f00640ac860, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00640ac860, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00640ac860, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f00640ac860, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f00640ac860) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00640ac860, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0064018ef0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0064018ef0, expanded_query=0x7f00903a12b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00640ac860, stmt_id=<optimized out>, flags=0, params=0x7f00640008ea "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f00640ac860, com_data=0x7f00903a1da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f00640ac860) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7f0090360700 (LWP 13465)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00000000010c365b in wait (this=0x35e97c8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:165
#2  os_event::wait_low (this=0x35e97c8, reset_sig_count=1) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0event.cc:335
#3  0x000000000116a0d9 in sync_array_wait_event (arr=0x263a238, cell=@0x7f009035ac58: 0x7f02d1e48728) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0arr.cc:475
#4  0x000000000116d082 in rw_lock_x_lock_func (lock=0x7f02b0ef0dd8, pass=0, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2998) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/sync/sync0rw.cc:795
#5  0x00000000011efb06 in pfs_rw_lock_x_lock_func (line=2998, file_name=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", pass=0, lock=0x7f02b0ef0dd8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/include/sync0rw.ic:711
#6  buf_page_get_gen (page_id=..., page_size=..., rw_latch=2, guess=<optimized out>, mode=11, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2998, mtr=0x7f009035c6c0, dirty_with_no_latch=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/buf/buf0buf.cc:4642
#7  0x00000000011d13a0 in btr_cur_search_to_nth_level (index=0x7f00200ab9b8, level=0, tuple=0x7f0058156ce8, mode=PAGE_CUR_LE, latch_mode=2, cursor=0x7f009035d110, has_search_latch=0, file=0x161a990 "/export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc", line=2998, mtr=0x7f009035c6c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/btr/btr0cur.cc:1107
#8  0x0000000001101f36 in row_ins_sec_index_entry_low (flags=0, mode=2, index=0x7f00200ab9b8, offsets_heap=0x7f0058205ad8, heap=0x7f0058206988, entry=0x7f0058156ce8, trx_id=0, thr=0x7f00581550e0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:2998
#9  0x000000000110553d in row_ins_sec_index_entry (index=0x7f00200ab9b8, entry=0x7f0058156ce8, thr=0x7f00581550e0, dup_chk_only=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3382
#10 0x0000000001105d4a in row_ins_index_entry (entry=<optimized out>, index=<optimized out>, thr=0x7f00581550e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3431
#11 row_ins_index_entry_step (node=0x7f005802c020, thr=0x7f00581550e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3579
#12 row_ins (thr=0x7f00581550e0, node=0x7f005802c020) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3717
#13 row_ins_step (thr=0x7f00581550e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0ins.cc:3853
#14 0x0000000001120875 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7f009035dce0 "\003", prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/row/row0mysql.cc:1738
#15 0x000000000104e744 in ha_innobase::write_row (this=0x7f005802a510, record=0x7f005802a920 "\377\030\342\024") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7598
#16 0x000000000081fe7b in handler::ha_write_row (this=0x7f005802a510, buf=0x7f005802a920 "\377\030\342\024") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#17 0x0000000000ea0427 in write_record (thd=0x7f00581e8620, table=0x7f0058029b60, info=0x7f009035e240, update=0x7f009035e1c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#18 0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7f005812e638, thd=0x7f00581e8620, table_list=0x7f005812dbf0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#19 0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7f005812e638, thd=0x7f00581e8620) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#20 0x0000000000d1835c in mysql_execute_command (thd=0x7f00581e8620, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#21 0x0000000000d45720 in Prepared_statement::execute (this=0x7f005812b640, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#22 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f005812b640, expanded_query=0x7f009035f2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#23 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00581e8620, stmt_id=<optimized out>, flags=0, params=0x7f00581e33ba "", params_length=198) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#24 0x0000000000d1d3ef in dispatch_command (thd=0x7f00581e8620, com_data=0x7f009035fda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#25 0x0000000000d1e944 in do_command (thd=0x7f00581e8620) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#26 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#27 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#28 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#29 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7f009031e700 (LWP 13466)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f005c00a710, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f005c00a710, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f005c00a710, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f005c00a710, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f005c00a710) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f005c00a710, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f005c4e7330, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f005c4e7330, expanded_query=0x7f009031d2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f005c00a710, stmt_id=<optimized out>, flags=0, params=0x7f005c0aca9a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f005c00a710, com_data=0x7f009031dda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f005c00a710) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7f00902dc700 (LWP 13467)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f0050012400, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0050012400, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0050012400, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f0050012400, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f0050012400) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f0050012400, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f005000e900, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f005000e900, expanded_query=0x7f00902db2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f0050012400, stmt_id=<optimized out>, flags=0, params=0x7f005000a8fa "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f0050012400, com_data=0x7f00902dbda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f0050012400) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7f009029a700 (LWP 13468)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f00540120e0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00540120e0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00540120e0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f00540120e0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f00540120e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00540120e0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f00541d2440, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f00541d2440, expanded_query=0x7f00902992b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00540120e0, stmt_id=<optimized out>, flags=0, params=0x7f005400305a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f00540120e0, com_data=0x7f0090299da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f00540120e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7f0090258700 (LWP 13469)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f004800a950, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004800a950, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004800a950, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f004800a950, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f004800a950) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f004800a950, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f00481efec0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f00481efec0, expanded_query=0x7f00902572b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f004800a950, stmt_id=<optimized out>, flags=0, params=0x7f00480008ea "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f004800a950, com_data=0x7f0090257da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f004800a950) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7f0090216700 (LWP 13470)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f004c0121e0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004c0121e0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004c0121e0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f004c0121e0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f004c0121e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f004c0121e0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f004c015770, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f004c015770, expanded_query=0x7f00902152b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f004c0121e0, stmt_id=<optimized out>, flags=0, params=0x7f004c00294a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f004c0121e0, com_data=0x7f0090215da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f004c0121e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x104c0780) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7f00901d4700 (LWP 13471)):
#0  0x00007f02e5d3c54d in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x00007f02e5d37e9b in _L_lock_883 () from /lib64/libpthread.so.0
#2  0x00007f02e5d37d68 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x0000000000ee48a3 in native_mutex_lock (mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_mutex.h:84
#4  my_mutex_lock (mp=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_mutex.h:182
#5  inline_mysql_mutex_lock (that=0x1e84a48 <mysql_bin_log+8>, src_file=<optimized out>, src_line=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:715
#6  0x0000000000eefc54 in MYSQL_BIN_LOG::change_stage (this=<optimized out>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9170
#7  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00400008c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#8  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00400008c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#9  0x0000000000823434 in ha_commit_trans (thd=0x7f00400008c0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#10 0x0000000000dd38f9 in trans_commit (thd=0x7f00400008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#11 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00400008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#12 0x0000000000d45720 in Prepared_statement::execute (this=0x7f00401ee390, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#13 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f00401ee390, expanded_query=0x7f00901d32b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#14 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00400008c0, stmt_id=<optimized out>, flags=0, params=0x7f00400122aa "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#15 0x0000000000d1d3ef in dispatch_command (thd=0x7f00400008c0, com_data=0x7f00901d3da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#16 0x0000000000d1e944 in do_command (thd=0x7f00400008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#17 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#18 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#19 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#20 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7f0090192700 (LWP 13472)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f0045bfab20, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0045bfab20, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0045bfab20, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f0045bfab20, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f0045bfab20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f0045bfab20, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f004400e8b0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f004400e8b0, expanded_query=0x7f00901912b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f0045bfab20, stmt_id=<optimized out>, flags=0, params=0x7f0045c06c4a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f0045bfab20, com_data=0x7f0090191da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f0045bfab20) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x104c0780) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7f0090150700 (LWP 13473)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f003800bfc0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003800bfc0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003800bfc0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f003800bfc0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f003800bfc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f003800bfc0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0038002aa0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0038002aa0, expanded_query=0x7f009014f2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f003800bfc0, stmt_id=<optimized out>, flags=0, params=0x7f00381b943a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f003800bfc0, com_data=0x7f009014fda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f003800bfc0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7f009010e700 (LWP 13474)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f003c1e6a70, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003c1e6a70, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003c1e6a70, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f003c1e6a70, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f003c1e6a70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f003c1e6a70, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f003c1eead0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f003c1eead0, expanded_query=0x7f009010d2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f003c1e6a70, stmt_id=<optimized out>, flags=0, params=0x7f003c1d637a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f003c1e6a70, com_data=0x7f009010dda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f003c1e6a70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x104c0780) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7f00900cc700 (LWP 13475)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f00302008c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00302008c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00302008c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f00302008c0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f00302008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00302008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f00302062a0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f00302062a0, expanded_query=0x7f00900cb2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00302008c0, stmt_id=<optimized out>, flags=0, params=0x7f003000697a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f00302008c0, com_data=0x7f00900cbda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f00302008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7f009008a700 (LWP 13476)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f003437eec0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003437eec0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003437eec0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f003437eec0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f003437eec0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f003437eec0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f003401db70, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f003401db70, expanded_query=0x7f00900892b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f003437eec0, stmt_id=<optimized out>, flags=0, params=0x7f003438b72a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f003437eec0, com_data=0x7f0090089da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f003437eec0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x104c0780) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7f0090048700 (LWP 25600)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x105809a0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x105809a0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x105809a0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x105809a0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x105809a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x105809a0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x261b730, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x261b730, expanded_query=0x7f00900472b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x105809a0, stmt_id=<optimized out>, flags=0, params=0x104e934a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x105809a0, com_data=0x7f0090047da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x105809a0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7f007b7fe700 (LWP 25601)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f001c012230, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f001c012230, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f001c012230, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f001c012230, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f001c012230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f001c012230, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f001c015bf0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f001c015bf0, expanded_query=0x7f007b7fd2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f001c012230, stmt_id=<optimized out>, flags=0, params=0x7f001c00294a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f001c012230, com_data=0x7f007b7fdda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f001c012230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7f007b7bc700 (LWP 25602)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f0018015350, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0018015350, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0018015350, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f0018015350, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f0018015350) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f0018015350, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0018014ba0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0018014ba0, expanded_query=0x7f007b7bb2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f0018015350, stmt_id=<optimized out>, flags=0, params=0x7f0018003c5a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f0018015350, com_data=0x7f007b7bbda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f0018015350) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7f007b77a700 (LWP 25603)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f002400a300, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f002400a300, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f002400a300, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f002400a300, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f002400a300) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f002400a300, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f002400f1f0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f002400f1f0, expanded_query=0x7f007b7792b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f002400a300, stmt_id=<optimized out>, flags=0, params=0x7f00240008ea "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f002400a300, com_data=0x7f007b779da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f002400a300) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7f007b738700 (LWP 25604)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f00200121d0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00200121d0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00200121d0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f00200121d0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f00200121d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00200121d0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0020015b90, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0020015b90, expanded_query=0x7f007b7372b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00200121d0, stmt_id=<optimized out>, flags=0, params=0x7f00200059ca "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f00200121d0, com_data=0x7f007b737da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f00200121d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7f007b6f6700 (LWP 25605)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f002c000b50, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f002c000b50, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f002c000b50, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f002c000b50, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f002c000b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f002c000b50, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f002c010dd0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f002c010dd0, expanded_query=0x7f007b6f52b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f002c000b50, stmt_id=<optimized out>, flags=0, params=0x7f002c00a20a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f002c000b50, com_data=0x7f007b6f5da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f002c000b50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7f007b6b4700 (LWP 25606)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f0028002e60, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0028002e60, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0028002e60, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f0028002e60, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f0028002e60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f0028002e60, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0028001800, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0028001800, expanded_query=0x7f007b6b32b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f0028002e60, stmt_id=<optimized out>, flags=0, params=0x7f002800da5a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f0028002e60, com_data=0x7f007b6b3da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f0028002e60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7f007b672700 (LWP 25607)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f003401e050, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003401e050, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003401e050, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f003401e050, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f003401e050) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f003401e050, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0034384490, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0034384490, expanded_query=0x7f007b6712b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f003401e050, stmt_id=<optimized out>, flags=0, params=0x7f00343795da "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f003401e050, com_data=0x7f007b671da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f003401e050) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7f007b630700 (LWP 25608)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f00302067f0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00302067f0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00302067f0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f00302067f0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f00302067f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00302067f0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f003020e8b0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f003020e8b0, expanded_query=0x7f007b62f2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00302067f0, stmt_id=<optimized out>, flags=0, params=0x7f003001227a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f00302067f0, com_data=0x7f007b62fda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f00302067f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7f007b5ee700 (LWP 25609)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f003c0008c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003c0008c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f003c0008c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f003c0008c0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f003c0008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f003c0008c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f003c008a20, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f003c008a20, expanded_query=0x7f007b5ed2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f003c0008c0, stmt_id=<optimized out>, flags=0, params=0x7f003c0122aa "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f003c0008c0, com_data=0x7f007b5edda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f003c0008c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7f007b5ac700 (LWP 25610)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f0038019260, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0038019260, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f0038019260, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f0038019260, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f0038019260) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f0038019260, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0038017300, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0038017300, expanded_query=0x7f007b5ab2b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f0038019260, stmt_id=<optimized out>, flags=0, params=0x7f0038003f8a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f0038019260, com_data=0x7f007b5abda0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f0038019260) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7f007b56a700 (LWP 25611)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f004400a8d0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004400a8d0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004400a8d0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f004400a8d0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f004400a8d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f004400a8d0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0045c21a70, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0045c21a70, expanded_query=0x7f007b5692b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f004400a8d0, stmt_id=<optimized out>, flags=0, params=0x7f00440015ca "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f004400a8d0, com_data=0x7f007b569da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f004400a8d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1049f4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7f007b528700 (LWP 28315)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f004c1c5690, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004c1c5690, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004c1c5690, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f004c1c5690, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f004c1c5690) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f004c1c5690, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f004c1d2d30, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f004c1d2d30, expanded_query=0x7f007b5272b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f004c1c5690, stmt_id=<optimized out>, flags=0, params=0x7f004c1cccea "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f004c1c5690, com_data=0x7f007b527da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f004c1c5690) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x1043e8e0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7f007b4e6700 (LWP 28316)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f00541cc8c0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00541cc8c0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00541cc8c0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f00541cc8c0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f00541cc8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00541cc8c0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f00540238c0, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f00540238c0, expanded_query=0x7f007b4e52b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00541cc8c0, stmt_id=<optimized out>, flags=0, params=0x7f005401d87a "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f00541cc8c0, com_data=0x7f007b4e5da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f00541cc8c0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x261bac0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7f007b4a4700 (LWP 28317)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f004801d4b0, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004801d4b0, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f004801d4b0, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f004801d4b0, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f004801d4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f004801d4b0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f00481ee140, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f00481ee140, expanded_query=0x7f007b4a32b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f004801d4b0, stmt_id=<optimized out>, flags=0, params=0x7f0048022aca "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f004801d4b0, com_data=0x7f007b4a3da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f004801d4b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x101b1570) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7f007b462700 (LWP 28318)):
#0  0x00007f02e5d39a35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000000000eefb32 in native_cond_wait (mutex=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:140
#2  my_cond_wait (mp=0x1e85aa8 <mysql_bin_log+4200>, cond=0x1e85a70 <mysql_bin_log+4144>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/thr_cond.h:195
#3  inline_mysql_cond_wait (src_line=2227, mutex=0x1e85aa8 <mysql_bin_log+4200>, that=0x1e85a70 <mysql_bin_log+4144>, src_file=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
#4  Stage_manager::enroll_for (this=0x1e85998 <mysql_bin_log+3928>, stage=<optimized out>, thd=0x7f00401df690, stage_mutex=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:2227
#5  0x0000000000eefc21 in MYSQL_BIN_LOG::change_stage (this=0x1e84a40 <mysql_bin_log>, thd=<optimized out>, stage=<optimized out>, queue=<optimized out>, leave_mutex=<optimized out>, enter_mutex=0x1e84a48 <mysql_bin_log+8>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9156
#6  0x0000000000ef44f3 in MYSQL_BIN_LOG::ordered_commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00401df690, all=<optimized out>, skip_commit=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:9570
#7  0x0000000000ef4f7d in MYSQL_BIN_LOG::commit (this=0x1e84a40 <mysql_bin_log>, thd=0x7f00401df690, all=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/binlog.cc:8851
#8  0x0000000000823434 in ha_commit_trans (thd=0x7f00401df690, all=true, ignore_global_read_lock=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:1799
#9  0x0000000000dd38f9 in trans_commit (thd=0x7f00401df690) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/transaction.cc:239
#10 0x0000000000d1a1a9 in mysql_execute_command (thd=0x7f00401df690, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:4244
#11 0x0000000000d45720 in Prepared_statement::execute (this=0x7f0040054110, expanded_query=<optimized out>, open_cursor=false) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3977
#12 0x0000000000d4599b in Prepared_statement::execute_loop (this=0x7f0040054110, expanded_query=0x7f007b4612b0, open_cursor=<optimized out>, packet=<optimized out>, packet_end=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:3585
#13 0x0000000000d45e0e in mysqld_stmt_execute (thd=0x7f00401df690, stmt_id=<optimized out>, flags=0, params=0x7f00401e6cea "", params_length=0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_prepare.cc:2574
#14 0x0000000000d1d3ef in dispatch_command (thd=0x7f00401df690, com_data=0x7f007b461da0, command=COM_STMT_EXECUTE) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1421
#15 0x0000000000d1e944 in do_command (thd=0x7f00401df690) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#16 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x101b4930) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#18 0x00007f02e5d35ea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007f02e47edb0d in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7f02e615c780 (LWP 13276)):
#0  0x00007f02e47e2ddd in poll () from /lib64/libc.so.6
#1  0x0000000000df1319 in Mysqld_socket_listener::listen_for_connection_event (this=0x2620360) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
#2  0x00000000007cc55d in connection_event_loop (this=0x101f4600) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
#3  mysqld_main (argc=63, argv=0x24f03f0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/mysqld.cc:5149
#4  0x00007f02e4711555 in __libc_start_main () from /lib64/libc.so.6
#5  0x00000000007c2089 in _start ()
