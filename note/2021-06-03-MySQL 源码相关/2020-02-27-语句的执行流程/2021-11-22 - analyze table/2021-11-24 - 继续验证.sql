


drop table  if exists t;
CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into t(c,d) values(1,1);
insert into t(c,d) values(2,2);
insert into t(c,d) values(3,3);
insert into t(c,d) values(4,4);
insert into t(c,d) values(5,5);
insert into t(c,d) values(6,6);
insert into t(c,d) values(7,7);
insert into t(c,d) values(8,8);
insert into t(c,d) values(9,9);
insert into t(c,d) values(10,10);
insert into t(c,d) values(11,11);
insert into t(c,d) values(12,12);
insert into t(c,d) values(13,13);
insert into t(c,d) values(14,14);
insert into t(c,d) values(15,15);

------------------------------------------------------------------

session A              session B      

b dict_stats_recalc_pool_add		
					  
					  delete from t where id=1;
					  (Query Ok)
					  
------------------------------------------------------------------




session A              session B      

b row_update_statistics_if_needed		
					  
					  delete from t where id=1;
					  (Blocked)
					  
(gdb) b row_update_statistics_if_needed
Breakpoint 2 at 0x1a1007f: file /usr/local/mysql/storage/innobase/row/row0mysql.cc, line 1193.
(gdb) bt
#0  0x00007f565ae1bccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x556ec20) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x549bd40) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x4141948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffcaf3b27f8) at /usr/local/mysql/sql/main.cc:25
(gdb) c
Continuing.
[Switching to Thread 0x7f56127f4700 (LWP 10784)]

Breakpoint 2, row_update_statistics_if_needed (table=0x7f564c050ac0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
1193		if (!table->stat_initialized) {
(gdb) bt
#0  row_update_statistics_if_needed (table=0x7f564c050ac0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
#1  0x0000000001a1367f in row_update_for_mysql_using_upd_graph (mysql_rec=0x7f564c0273b0 "\371\001", prebuilt=0x7f564c05c930) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2637
#2  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x7f564c0273b0 "\371\001", prebuilt=0x7f564c05c930) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
#3  0x00000000018c0c12 in ha_innobase::delete_row (this=0x7f564c0270c0, record=0x7f564c0273b0 "\371\001") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8356
#4  0x0000000000f37031 in handler::ha_delete_row (this=0x7f564c0270c0, buf=0x7f564c0273b0 "\371\001") at /usr/local/mysql/sql/handler.cc:8136
#5  0x000000000174ce24 in Sql_cmd_delete::mysql_delete (this=0x7f564c011728, thd=0x7f564c00ca70, limit=18446744073709551615) at /usr/local/mysql/sql/sql_delete.cc:479
#6  0x000000000174fb9c in Sql_cmd_delete::execute (this=0x7f564c011728, thd=0x7f564c00ca70) at /usr/local/mysql/sql/sql_delete.cc:1392
#7  0x00000000015351f1 in mysql_execute_command (thd=0x7f564c00ca70, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#8  0x000000000153a849 in mysql_parse (thd=0x7f564c00ca70, parser_state=0x7f56127f3690) at /usr/local/mysql/sql/sql_parse.cc:5570
#9  0x00000000015302d8 in dispatch_command (thd=0x7f564c00ca70, com_data=0x7f56127f3df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#10 0x000000000152f20c in do_command (thd=0x7f564c00ca70) at /usr/local/mysql/sql/sql_parse.cc:1025
#11 0x000000000165f7c8 in handle_connection (arg=0x4c05020) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4d08690) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#13 0x00007f565bf60ea5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f565ae269fd in clone () from /lib64/libc.so.6
					  
			
------------------------------------------------------------------



select * from t where id=1;
session A              session B      

b row_update_statistics_if_needed		
					  
					  update t set d=1 where id=1;
					  (Query Ok)	



------------------------------------------------------------------


session A              session B      

b row_update_statistics_if_needed		
					  
					  update t set c=1 where id=1;
					   Query OK, 0 rows affected (2.68 sec)	
					   
(gdb) b row_update_statistics_if_needed
Breakpoint 2 at 0x1a1007f: file /usr/local/mysql/storage/innobase/row/row0mysql.cc, line 1193.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000001a1007f in row_update_statistics_if_needed(dict_table_t*) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
(gdb) bt
#0  0x00007f0f98fa0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x45d3340) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4f3c5a0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x3651948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7fffb36001a8) at /usr/local/mysql/sql/main.cc:25
(gdb) c
Continuing.

------------------------------------------------------------------


session A              session B      

b row_update_statistics_if_needed		
					  
					  update t set c=10 where id=1;
					  (Blocked)


(gdb) b row_update_statistics_if_needed
Breakpoint 2 at 0x1a1007f: file /usr/local/mysql/storage/innobase/row/row0mysql.cc, line 1193.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000001a1007f in row_update_statistics_if_needed(dict_table_t*) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
(gdb) bt
#0  0x00007feb36274ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x422a580) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4e4b850) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x35bf948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7fffbee2dab8) at /usr/local/mysql/sql/main.cc:25
(gdb) c
Continuing.
[Switching to Thread 0x7feaedbf2700 (LWP 10948)]

Breakpoint 2, row_update_statistics_if_needed (table=0x7feb2896ca80) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
1193		if (!table->stat_initialized) {
(gdb) bt
#0  row_update_statistics_if_needed (table=0x7feb2896ca80) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1193
#1  0x0000000001a1367f in row_update_for_mysql_using_upd_graph (mysql_rec=0x7feb2801b288 "\371\001", prebuilt=0x7feb28972e80) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2637
#2  0x0000000001a1379b in row_update_for_mysql (mysql_rec=0x7feb2801b288 "\371\001", prebuilt=0x7feb28972e80) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:2665
#3  0x00000000018c07e6 in ha_innobase::update_row (this=0x7feb2801af80, old_row=0x7feb2801b288 "\371\001", new_row=0x7feb2801b270 "\371\001") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8243
#4  0x0000000000f36c43 in handler::ha_update_row (this=0x7feb2801af80, old_data=0x7feb2801b288 "\371\001", new_data=0x7feb2801b270 "\371\001") at /usr/local/mysql/sql/handler.cc:8103
#5  0x00000000015e7de5 in mysql_update (thd=0x7feb2800a440, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7feaedbf0428, updated_return=0x7feaedbf0420) at /usr/local/mysql/sql/sql_update.cc:888
#6  0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7feb2800faf8, thd=0x7feb2800a440, switch_to_multitable=0x7feaedbf04cf) at /usr/local/mysql/sql/sql_update.cc:2891
#7  0x00000000015ee453 in Sql_cmd_update::execute (this=0x7feb2800faf8, thd=0x7feb2800a440) at /usr/local/mysql/sql/sql_update.cc:3018
#8  0x00000000015351f1 in mysql_execute_command (thd=0x7feb2800a440, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#9  0x000000000153a849 in mysql_parse (thd=0x7feb2800a440, parser_state=0x7feaedbf1690) at /usr/local/mysql/sql/sql_parse.cc:5570
#10 0x00000000015302d8 in dispatch_command (thd=0x7feb2800a440, com_data=0x7feaedbf1df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#11 0x000000000152f20c in do_command (thd=0x7feb2800a440) at /usr/local/mysql/sql/sql_parse.cc:1025
#12 0x000000000165f7c8 in handle_connection (arg=0x408b080) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#13 0x0000000001ce7612 in pfs_spawn_thread (arg=0x40e62d0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#14 0x00007feb373b9ea5 in start_thread () from /lib64/libpthread.so.0
#15 0x00007feb3627f9fd in clone () from /lib64/libc.so.6



