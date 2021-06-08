Thread 1 (process 28811):
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
