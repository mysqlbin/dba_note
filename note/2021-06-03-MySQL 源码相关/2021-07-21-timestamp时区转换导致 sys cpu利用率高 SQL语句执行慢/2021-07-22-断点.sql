

Thread 38 (Thread 0x7fe57a86f700 (LWP 67268)):
#0  0x0000003dee4f82ce in __lll_lock_wait_private () from /lib64/libc.so.6
#1  0x0000003dee49df8d in _L_lock_2163 () from /lib64/libc.so.6
#2  0x0000003dee49dd47 in __tz_convert () from /lib64/libc.so.6
#3  0x00000000007c02e7 in Time_zone_system::gmt_sec_to_TIME(st_mysql_time*, long) const ()
#4  0x0000000000811df6 in Field_timestampf::get_date_internal(st_mysql_time*) ()
#5  0x0000000000809ea9 in Field_temporal_with_date::val_date_temporal() ()
#6  0x00000000005f43cc in get_datetime_value(THD*, Item***, Item**, Item*, bool*) ()
#7  0x00000000005e7ba7 in Arg_comparator::compare_datetime() ()
#8  0x00000000005eef4e in Item_func_gt::val_int() ()
#9  0x00000000006fc6ab in evaluate_join_record(JOIN*, st_join_table*) ()
#10 0x0000000000700e7e in sub_select(JOIN*, st_join_table*, bool) ()
#11 0x00000000006fecc1 in JOIN::exec() ()



time_zone：设置为SYSTEM的话，使用sys_time_zone获取的OS会话时区，同时使用OS API进行转换。对应转换函数 Time_zone_system::gmt_sec_to_TIME
time_zone：设置为实际的时区的话，比如‘+08:00’，那么使用使用MySQL自己的方法进行转换。对应转换函数 Time_zone_offset::gmt_sec_to_TIME



实际上Time_zone_system和Time_zone_offset均继承于Time_zone类，并且实现了Time_zone类的虚函数进行了重写，因此上层调用都是Time_zone::gmt_sec_to_TIME。

b Time_zone_system::gmt_sec_to_TIME

mysql> select now();


(gdb) b Time_zone_system::gmt_sec_to_TIME
Breakpoint 2 at 0x163a1d4: file /usr/local/mysql/sql/tztime.cc, line 1092.
(gdb) c
Continuing.
[Switching to Thread 0x7fd81aff5700 (LWP 4771)]

Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd81aff4220, t=1626162817) at /usr/local/mysql/sql/tztime.cc:1092
1092	  time_t tmp_t= (time_t)t;
(gdb) c
Continuing.

Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd8561e6208, t=1626162847) at /usr/local/mysql/sql/tztime.cc:1092
1092	  time_t tmp_t= (time_t)t;
(gdb) bt
#0  Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd8561e6208, t=1626162847) at /usr/local/mysql/sql/tztime.cc:1092
#1  0x0000000000f135b9 in Time_zone::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd8561e6208, tv=...) at /usr/local/mysql/sql/tztime.h:60
#2  0x00000000013f9745 in MYSQL_TIME_cache::set_datetime (this=0x7fd8561e6208, tv=..., dec_arg=0 '\000', tz=0x2d23c68 <tz_SYSTEM>) at /usr/local/mysql/sql/item_timefunc.cc:1810
#3  0x00000000013f9cc9 in Item_func_now::fix_length_and_dec (this=0x7fd8561e6130) at /usr/local/mysql/sql/item_timefunc.cc:1954
#4  0x0000000000fb5c97 in Item_func::fix_fields (this=0x7fd8561e6130, thd=0x7fd854024e30, ref=0x7fd8561e6350) at /usr/local/mysql/sql/item_func.cc:246
#5  0x00000000014ba21e in setup_fields (thd=0x7fd854024e30, ref_pointer_array=..., fields=..., want_privilege=1, sum_func_list=0x7fd8561e5960, allow_sum_func=true, column_update=false) at /usr/local/mysql/sql/sql_base.cc:8998
#6  0x0000000001577da8 in st_select_lex::prepare (this=0x7fd8561e5800, thd=0x7fd854024e30) at /usr/local/mysql/sql/sql_resolver.cc:190
#7  0x0000000001583a0e in handle_query (thd=0x7fd854024e30, lex=0x7fd854027150, result=0x7fd8561e64e8, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:132
#8  0x000000000153996f in execute_sqlcom_select (thd=0x7fd854024e30, all_tables=0x0) at /usr/local/mysql/sql/sql_parse.cc:5144
#9  0x000000000153339d in mysql_execute_command (thd=0x7fd854024e30, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
#10 0x000000000153a849 in mysql_parse (thd=0x7fd854024e30, parser_state=0x7fd81aff4690) at /usr/local/mysql/sql/sql_parse.cc:5570
#11 0x00000000015302d8 in dispatch_command (thd=0x7fd854024e30, com_data=0x7fd81aff4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#12 0x000000000152f20c in do_command (thd=0x7fd854024e30) at /usr/local/mysql/sql/sql_parse.cc:1025
#13 0x000000000165f7c8 in handle_connection (arg=0x467bd10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3aeb000) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#15 0x00007fd8647d0ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fd8636969fd in clone () from /lib64/libc.so.6




update t_20210722 set createTime=now() where id=1;

(gdb) b Time_zone_system::gmt_sec_to_TIME
Breakpoint 2 at 0x163a1d4: file /usr/local/mysql/sql/tztime.cc, line 1092.
(gdb) c
Continuing.
[Switching to Thread 0x7fd81aff5700 (LWP 4771)]

Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd81aff4220, t=1626162949) at /usr/local/mysql/sql/tztime.cc:1092
1092	  time_t tmp_t= (time_t)t;
(gdb) c
Continuing.

Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd8561e63c0, t=1626162962) at /usr/local/mysql/sql/tztime.cc:1092
1092	  time_t tmp_t= (time_t)t;
(gdb) bt
#0  Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd8561e63c0, t=1626162962) at /usr/local/mysql/sql/tztime.cc:1092
#1  0x0000000000f135b9 in Time_zone::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd8561e63c0, tv=...) at /usr/local/mysql/sql/tztime.h:60
#2  0x00000000013f9745 in MYSQL_TIME_cache::set_datetime (this=0x7fd8561e63c0, tv=..., dec_arg=0 '\000', tz=0x2d23c68 <tz_SYSTEM>) at /usr/local/mysql/sql/item_timefunc.cc:1810
#3  0x00000000013f9cc9 in Item_func_now::fix_length_and_dec (this=0x7fd8561e62e8) at /usr/local/mysql/sql/item_timefunc.cc:1954
#4  0x0000000000fb5c97 in Item_func::fix_fields (this=0x7fd8561e62e8, thd=0x7fd854024e30, ref=0x7fd8561e6480) at /usr/local/mysql/sql/item_func.cc:246
#5  0x00000000014ba21e in setup_fields (thd=0x7fd854024e30, ref_pointer_array=..., fields=..., want_privilege=1, sum_func_list=0x0, allow_sum_func=false, column_update=false) at /usr/local/mysql/sql/sql_base.cc:8998
#6  0x00000000015e8bb6 in mysql_prepare_update (thd=0x7fd854024e30, update_table_ref=0x7fd8561e67d0, covering_keys_for_cond=0x7fd81aff3320, update_value_list=...) at /usr/local/mysql/sql/sql_update.cc:1176
#7  0x00000000015e6078 in mysql_update (thd=0x7fd854024e30, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd81aff3428, updated_return=0x7fd81aff3420) at /usr/local/mysql/sql/sql_update.cc:293
#8  0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fd8561e6798, thd=0x7fd854024e30, switch_to_multitable=0x7fd81aff34cf) at /usr/local/mysql/sql/sql_update.cc:2891
#9  0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fd8561e6798, thd=0x7fd854024e30) at /usr/local/mysql/sql/sql_update.cc:3018
#10 0x00000000015351f1 in mysql_execute_command (thd=0x7fd854024e30, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#11 0x000000000153a849 in mysql_parse (thd=0x7fd854024e30, parser_state=0x7fd81aff4690) at /usr/local/mysql/sql/sql_parse.cc:5570
#12 0x00000000015302d8 in dispatch_command (thd=0x7fd854024e30, com_data=0x7fd81aff4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#13 0x000000000152f20c in do_command (thd=0x7fd854024e30) at /usr/local/mysql/sql/sql_parse.cc:1025
#14 0x000000000165f7c8 in handle_connection (arg=0x467bd10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3aeb000) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#16 0x00007fd8647d0ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fd8636969fd in clone () from /lib64/libc.so.6
(gdb) 


b Time_zone_system::gmt_sec_to_TIME


update t_20210722 set createTime="2021-07-22 15:59:01" where id=1;

mysql> update t_20210722 set createTime="2021-07-22 15:59:01" where id=1
Query OK, 1 row affected (0.01 sec)


mysql> select * from t_20210722;
(block)
走 Time_zone_system::gmt_sec_to_TIME 这里的逻辑。

(gdb) c
Continuing.

Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd81aff2880, t=1626940741) at /usr/local/mysql/sql/tztime.cc:1092
1092	  time_t tmp_t= (time_t)t;
(gdb) bt
#0  Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd81aff2880, t=1626940741) at /usr/local/mysql/sql/tztime.cc:1092
#1  0x0000000000f135b9 in Time_zone::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd81aff2880, tv=...) at /usr/local/mysql/sql/tztime.h:60
#2  0x0000000000ef8b8d in Field_timestampf::get_date_internal (this=0x7fd85404ea30, ltime=0x7fd81aff2880) at /usr/local/mysql/sql/field.cc:5986
#3  0x0000000000ef753b in Field_temporal_with_date::val_str (this=0x7fd85404ea30, val_buffer=0x7fd81aff28f0, val_ptr=0x7fd81aff28f0) at /usr/local/mysql/sql/field.cc:5401
#4  0x0000000000ed0c59 in Field::val_str (this=0x7fd85404ea30, str=0x7fd81aff28f0) at /usr/local/mysql/sql/field.h:864
#5  0x0000000000eece4e in Field::send_text (this=0x7fd85404ea30, protocol=0x7fd854025fd0) at /usr/local/mysql/sql/field.cc:1722
#6  0x0000000001455236 in Protocol_text::store (this=0x7fd854025fd0, field=0x7fd85404ea30) at /usr/local/mysql/sql/protocol_classic.cc:1415
#7  0x0000000000f55b0b in Item_field::send (this=0x7fd8561e6eb0, protocol=0x7fd854025fd0, buffer=0x7fd81aff2ca0) at /usr/local/mysql/sql/item.cc:7806
#8  0x00000000014d9ad7 in THD::send_result_set_row (this=0x7fd854024e30, row_items=0x7fd8561e5958) at /usr/local/mysql/sql/sql_class.cc:4695
#9  0x00000000014d4162 in Query_result_send::send_data (this=0x7fd8561e6aa8, items=...) at /usr/local/mysql/sql/sql_class.cc:2725
#10 0x00000000014f1233 in end_send (join=0x7fd8561e7100, qep_tab=0x7fd8540502c0, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:2927
#11 0x00000000014edf39 in evaluate_join_record (join=0x7fd8561e7100, qep_tab=0x7fd854050148) at /usr/local/mysql/sql/sql_executor.cc:1645
#12 0x00000000014ed379 in sub_select (join=0x7fd8561e7100, qep_tab=0x7fd854050148, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1297
#13 0x00000000014ecbfa in do_select (join=0x7fd8561e7100) at /usr/local/mysql/sql/sql_executor.cc:950
#14 0x00000000014eab61 in JOIN::exec (this=0x7fd8561e7100) at /usr/local/mysql/sql/sql_executor.cc:199
#15 0x0000000001583b64 in handle_query (thd=0x7fd854024e30, lex=0x7fd854027150, result=0x7fd8561e6aa8, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
#16 0x000000000153996f in execute_sqlcom_select (thd=0x7fd854024e30, all_tables=0x7fd8561e6460) at /usr/local/mysql/sql/sql_parse.cc:5144
#17 0x000000000153339d in mysql_execute_command (thd=0x7fd854024e30, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
#18 0x000000000153a849 in mysql_parse (thd=0x7fd854024e30, parser_state=0x7fd81aff4690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7fd854024e30, com_data=0x7fd81aff4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7fd854024e30) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x467bd10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3aeb000) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fd8647d0ea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fd8636969fd in clone () from /lib64/libc.so.6


+----+-------+-----+---------------------+
| id | name  | age | createTime          |
+----+-------+-----+---------------------+
|  1 | bin   |   1 | 2021-07-22 15:59:01 |
|  2 | bin1  |   1 | 2021-07-13 15:48:43 |
|  3 | bi2   |   1 | 2021-07-13 15:48:43 |
|  4 | bi3   |   1 | 2021-07-13 15:48:43 |
|  5 | bi4   |   1 | 2021-07-13 15:48:43 |
|  6 | bi5   |   1 | 2021-07-13 15:48:43 |
|  7 | bi6   |   1 | 2021-07-13 15:48:43 |
|  8 | bin7  |   1 | 2021-07-13 15:48:43 |
|  9 | bin8  |   1 | 2021-07-13 15:48:43 |
| 10 | bin9  |   1 | 2021-07-13 15:48:43 |
| 11 | bin10 |   1 | 2021-07-13 15:48:44 |
+----+-------+-----+---------------------+
11 rows in set (24.74 sec)


------------------------------------------------------------------------------------------------------------------------------

b Time_zone_system::gmt_sec_to_TIME


select createTime from t_20210722 where id=1;
(Blocked)

(gdb) bt
#0  Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd81aff29b0, t=1626940741) at /usr/local/mysql/sql/tztime.cc:1092
#1  0x0000000000f135b9 in Time_zone::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7fd81aff29b0, tv=...) at /usr/local/mysql/sql/tztime.h:60
#2  0x0000000000ef8b8d in Field_timestampf::get_date_internal (this=0x7fd85405d600, ltime=0x7fd81aff29b0) at /usr/local/mysql/sql/field.cc:5986
#3  0x0000000000ef753b in Field_temporal_with_date::val_str (this=0x7fd85405d600, val_buffer=0x7fd81aff2a20, val_ptr=0x7fd81aff2a20) at /usr/local/mysql/sql/field.cc:5401
#4  0x0000000000ed0c59 in Field::val_str (this=0x7fd85405d600, str=0x7fd81aff2a20) at /usr/local/mysql/sql/field.h:864
#5  0x0000000000eece4e in Field::send_text (this=0x7fd85405d600, protocol=0x7fd854025fd0) at /usr/local/mysql/sql/field.cc:1722
#6  0x0000000001455236 in Protocol_text::store (this=0x7fd854025fd0, field=0x7fd85405d600) at /usr/local/mysql/sql/protocol_classic.cc:1415
#7  0x0000000000f55b0b in Item_field::send (this=0x7fd8561e6798, protocol=0x7fd854025fd0, buffer=0x7fd81aff2dd0) at /usr/local/mysql/sql/item.cc:7806
#8  0x00000000014d9ad7 in THD::send_result_set_row (this=0x7fd854024e30, row_items=0x7fd8561e5978) at /usr/local/mysql/sql/sql_class.cc:4695
#9  0x00000000014d4162 in Query_result_send::send_data (this=0x7fd8561e71d0, items=...) at /usr/local/mysql/sql/sql_class.cc:2725
#10 0x00000000014f1233 in end_send (join=0x7fd8561e72f0, qep_tab=0x0, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:2927
#11 0x00000000014ec950 in do_select (join=0x7fd8561e72f0) at /usr/local/mysql/sql/sql_executor.cc:895
#12 0x00000000014eab61 in JOIN::exec (this=0x7fd8561e72f0) at /usr/local/mysql/sql/sql_executor.cc:199
#13 0x0000000001583b64 in handle_query (thd=0x7fd854024e30, lex=0x7fd854027150, result=0x7fd8561e71d0, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
#14 0x000000000153996f in execute_sqlcom_select (thd=0x7fd854024e30, all_tables=0x7fd8561e68c8) at /usr/local/mysql/sql/sql_parse.cc:5144
#15 0x000000000153339d in mysql_execute_command (thd=0x7fd854024e30, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
#16 0x000000000153a849 in mysql_parse (thd=0x7fd854024e30, parser_state=0x7fd81aff4690) at /usr/local/mysql/sql/sql_parse.cc:5570
#17 0x00000000015302d8 in dispatch_command (thd=0x7fd854024e30, com_data=0x7fd81aff4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#18 0x000000000152f20c in do_command (thd=0x7fd854024e30) at /usr/local/mysql/sql/sql_parse.cc:1025
#19 0x000000000165f7c8 in handle_connection (arg=0x467bd10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#20 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3aeb000) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#21 0x00007fd8647d0ea5 in start_thread () from /lib64/libpthread.so.0
#22 0x00007fd8636969fd in clone () from /lib64/libc.so.6

------------------------------------------------------------------------------------------------------------------------------

b Time_zone_system::gmt_sec_to_TIME

mysql> select age,name from t_20210722 where id=1;
+-----+------+
| age | name |
+-----+------+
|   1 | bin  |
+-----+------+
1 row in set (0.00 sec)

----------------------------------------


-- 访问到 timestamp 字段，都会走 Time_zone_system::gmt_sec_to_TIME 时区转换的逻辑。
-- 这种转换操作是每行符合条件的数据都需要转换的。








----------------------------------------------------------------------------------------------------------------------------

b Time_zone_system::gmt_sec_to_TIME


mysql> show global variables like 'time_zone';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| time_zone     | +08:00 |
+---------------+--------+
1 row in set (0.00 sec)

----------------------------------------------------------------------------------------------------------------------------



(gdb) b Time_zone_system::gmt_sec_to_TIME
Breakpoint 2 at 0x163a1d4: file /usr/local/mysql/sql/tztime.cc, line 1092.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x000000000163a1d4 in Time_zone_system::gmt_sec_to_TIME(st_mysql_time*, long) const at /usr/local/mysql/sql/tztime.cc:1092


update t_20210722 set createTime="2021-07-22 15:59:01" where id=1;
(Query OK)

-----------------------------------------------------------------------------

b Time_zone_system::gmt_sec_to_TIME

update t_20210722 set createTime=now() where id=1;
(Query OK)

mysql> select now();
+---------------------+
| now()               |
+---------------------+
| 2021-07-13 16:48:04 |
+---------------------+
1 row in set (0.00 sec)

mysql> update t_20210722 set createTime=now() where id=1;
Query OK, 1 row affected (0.03 sec)

mysql> select * from t_20210722;
+----+-------+-----+---------------------+
| id | name  | age | createTime          |
+----+-------+-----+---------------------+
|  1 | bin   |   1 | 2021-07-13 16:48:07 |
|  2 | bin1  |   1 | 2021-07-13 15:48:43 |
|  3 | bi2   |   1 | 2021-07-13 15:48:43 |
|  4 | bi3   |   1 | 2021-07-13 15:48:43 |
|  5 | bi4   |   1 | 2021-07-13 15:48:43 |
|  6 | bi5   |   1 | 2021-07-13 15:48:43 |
|  7 | bi6   |   1 | 2021-07-13 15:48:43 |
|  8 | bin7  |   1 | 2021-07-13 15:48:43 |
|  9 | bin8  |   1 | 2021-07-13 15:48:43 |
| 10 | bin9  |   1 | 2021-07-13 15:48:43 |
| 11 | bin10 |   1 | 2021-07-13 15:48:44 |
+----+-------+-----+---------------------+
11 rows in set (0.01 sec)

-------------------------------------------------------------

b Time_zone_offset::gmt_sec_to_TIME

mysql> update t_20210722 set createTime=now() where id=1;
(Blocked)



(gdb) b Time_zone_offset::gmt_sec_to_TIME
Breakpoint 2 at 0x163a648: file /usr/local/mysql/sql/tztime.cc, line 1418.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x000000000163a648 in Time_zone_offset::gmt_sec_to_TIME(st_mysql_time*, long) const at /usr/local/mysql/sql/tztime.cc:1418
(gdb) c
Continuing.
[Switching to Thread 0x7fd81aff5700 (LWP 4771)]

Breakpoint 2, Time_zone_offset::gmt_sec_to_TIME (this=0x486e498, tmp=0x7fd81aff4220, t=1626166303) at /usr/local/mysql/sql/tztime.cc:1418
1418	  sec_to_TIME(tmp, t, offset);
(gdb) c
Continuing.

Breakpoint 2, Time_zone_offset::gmt_sec_to_TIME (this=0x486e498, tmp=0x7fd8561e63c0, t=1626166312) at /usr/local/mysql/sql/tztime.cc:1418
1418	  sec_to_TIME(tmp, t, offset);
(gdb) bt
#0  Time_zone_offset::gmt_sec_to_TIME (this=0x486e498, tmp=0x7fd8561e63c0, t=1626166312) at /usr/local/mysql/sql/tztime.cc:1418
#1  0x0000000000f135b9 in Time_zone::gmt_sec_to_TIME (this=0x486e498, tmp=0x7fd8561e63c0, tv=...) at /usr/local/mysql/sql/tztime.h:60
#2  0x00000000013f9745 in MYSQL_TIME_cache::set_datetime (this=0x7fd8561e63c0, tv=..., dec_arg=0 '\000', tz=0x486e498) at /usr/local/mysql/sql/item_timefunc.cc:1810
#3  0x00000000013f9cc9 in Item_func_now::fix_length_and_dec (this=0x7fd8561e62e8) at /usr/local/mysql/sql/item_timefunc.cc:1954
#4  0x0000000000fb5c97 in Item_func::fix_fields (this=0x7fd8561e62e8, thd=0x7fd854024e30, ref=0x7fd8561e6480) at /usr/local/mysql/sql/item_func.cc:246
#5  0x00000000014ba21e in setup_fields (thd=0x7fd854024e30, ref_pointer_array=..., fields=..., want_privilege=1, sum_func_list=0x0, allow_sum_func=false, column_update=false) at /usr/local/mysql/sql/sql_base.cc:8998
#6  0x00000000015e8bb6 in mysql_prepare_update (thd=0x7fd854024e30, update_table_ref=0x7fd8561e67d0, covering_keys_for_cond=0x7fd81aff3320, update_value_list=...) at /usr/local/mysql/sql/sql_update.cc:1176
#7  0x00000000015e6078 in mysql_update (thd=0x7fd854024e30, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd81aff3428, updated_return=0x7fd81aff3420) at /usr/local/mysql/sql/sql_update.cc:293
#8  0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7fd8561e6798, thd=0x7fd854024e30, switch_to_multitable=0x7fd81aff34cf) at /usr/local/mysql/sql/sql_update.cc:2891
#9  0x00000000015ee453 in Sql_cmd_update::execute (this=0x7fd8561e6798, thd=0x7fd854024e30) at /usr/local/mysql/sql/sql_update.cc:3018
#10 0x00000000015351f1 in mysql_execute_command (thd=0x7fd854024e30, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#11 0x000000000153a849 in mysql_parse (thd=0x7fd854024e30, parser_state=0x7fd81aff4690) at /usr/local/mysql/sql/sql_parse.cc:5570
#12 0x00000000015302d8 in dispatch_command (thd=0x7fd854024e30, com_data=0x7fd81aff4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#13 0x000000000152f20c in do_command (thd=0x7fd854024e30) at /usr/local/mysql/sql/sql_parse.cc:1025
#14 0x000000000165f7c8 in handle_connection (arg=0x467bd10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#15 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3aeb000) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#16 0x00007fd8647d0ea5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fd8636969fd in clone () from /lib64/libc.so.6


-------------------------------------------------------------