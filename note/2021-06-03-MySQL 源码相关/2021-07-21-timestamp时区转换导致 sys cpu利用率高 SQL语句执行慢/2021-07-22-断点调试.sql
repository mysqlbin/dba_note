
大纲
	1. 初始化表结构和数据
	2. time_zone=system
		2.1 select now()
		2.2 更新操作
			2.2.1 更新timestamp时间字段值为now()
			2.2.2 更新timestamp时间字段值为指定时间
		2.3 查询操作
			2.3.1 查询字段包括timestamp时间类型
			2.3.2 查询字段不包括timestamp时间类型
			2.3.3 根据timestamp类型字段作为查询条件
		2.4 插入操作 
			2.4.1 timestamp时间类型字段使用默认的DEFAULT CURRENT_TIMESTAMP
			2.4.2 timestamp时间类型字段插入now()
			2.4.3 timestamp时间类型字段插入指定时间
		2.5 删除操作
			2.5.1 根据主键ID作为条件删除
			2.5.2 根据时间作为条件删除记录
		2.6 小结

	3. time_zone='+08:00'
		3.1 更新timestamp时间字段值为指定时间
		3.2 更新timestamp时间字段值为now()
		3.3 更新timestamp时间字段值为now()并打断点查看椎栈

	4. 小结
	
	

1. 初始化表结构和数据
	CREATE TABLE `t_20210722` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	`name` varchar(32) not NULL default '',
	`age` int(11) not NULL default 0,
	`createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
	PRIMARY KEY (`id`),
	KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;

	insert into t_20210722(name, age) values('bin', 1);
	insert into t_20210722(name, age) values('bin1', 1);
	insert into t_20210722(name, age) values('bi2', 1);
	insert into t_20210722(name, age) values('bi3', 1);
	insert into t_20210722(name, age) values('bi4', 1);
	insert into t_20210722(name, age) values('bi5', 1);
	insert into t_20210722(name, age) values('bi6', 1);
	insert into t_20210722(name, age) values('bin7', 1);
	insert into t_20210722(name, age) values('bin8', 1);
	insert into t_20210722(name, age) values('bin9', 1);
	insert into t_20210722(name, age) values('bin10', 1);


2. time_zone=system 

	mysql> show global variables like 'time_zone';
	+---------------+--------+
	| Variable_name | Value  |
	+---------------+--------+
	| time_zone     | SYSTEM |
	+---------------+--------+
	1 row in set (0.00 sec)



2.1 select now()

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


2.2 更新操作

2.2.1 更新timestamp时间字段值为now()
	
	b Time_zone_system::gmt_sec_to_TIME
	
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


2.2.2 更新timestamp时间字段值为指定时间

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


2.3 查询操作

2.3.1 查询字段包括timestamp时间类型
	
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

2.3.2 查询字段不包括timestamp时间类型

	b Time_zone_system::gmt_sec_to_TIME

	mysql> select age,name from t_20210722 where id=1;
	+-----+------+
	| age | name |
	+-----+------+
	|   1 | bin  |
	+-----+------+
	1 row in set (0.00 sec)


2.3.3 根据timestamp类型字段作为查询条件
	
	mysql> select * from t_20210722;
	+----+-------+-----+---------------------+
	| id | name  | age | createTime          |
	+----+-------+-----+---------------------+
	|  1 | bin   |   1 | 2021-07-13 16:51:52 |
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
	| 12 | bin11 |   1 | 2021-07-14 11:56:09 |
	+----+-------+-----+---------------------+
	12 rows in set (0.00 sec)



							(gdb) b Time_zone_system::gmt_sec_to_TIME
							
							(gdb) info b
							Num     Type           Disp Enb Address            What
							1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
								breakpoint already hit 1 time
							2       breakpoint     keep y   0x000000000163a1d4 in Time_zone_system::gmt_sec_to_TIME(st_mysql_time*, long) const at /usr/local/mysql/sql/tztime.cc:1092

	
	mysql> select age,name from  t_20210722 where createTime='2021-07-13 15:48:44';
	+-----+-------+
	| age | name  |
	+-----+-------+
	|   1 | bin10 |
	+-----+-------+
	1 row in set (0.08 sec)


	
	
2.4 插入操作 

	2.4.1 timestamp时间类型字段使用默认的DEFAULT CURRENT_TIMESTAMP
	
		mysql> select count(*) from t_20210722;
		+----------+
		| count(*) |
		+----------+
		|       11 |
		+----------+
		1 row in set (0.04 sec)
		
		
												b Time_zone_system::gmt_sec_to_TIME
												
												(gdb) b Time_zone_system::gmt_sec_to_TIME
												Breakpoint 2 at 0x163a1d4: file /usr/local/mysql/sql/tztime.cc, line 1092.
												(gdb) info b
												Num     Type           Disp Enb Address            What
												1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
													breakpoint already hit 1 time
												2       breakpoint     keep n   0x000000000163a1d4 in Time_zone_system::gmt_sec_to_TIME(st_mysql_time*, long) const at /usr/local/mysql/sql/tztime.cc:1092


		insert into t_20210722(name, age) values('bin11', 1);
		Query OK, 1 row affected (0.02 sec)

												(gdb) quit
																
		mysql> select count(*) from t_20210722;
		+----------+
		| count(*) |
		+----------+
		|       12 |
		+----------+
		1 row in set (0.04 sec)
		
		
	-----------------------------------------------------------------------
	
	2.4.2 timestamp时间类型字段插入now()
	
							b Time_zone_system::gmt_sec_to_TIME
		
		
		
		
							(gdb) info b
							Num     Type           Disp Enb Address            What
							1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
								breakpoint already hit 1 time
							2       breakpoint     keep y   0x000000000163a1d4 in Time_zone_system::gmt_sec_to_TIME(st_mysql_time*, long) const at /usr/local/mysql/sql/tztime.cc:1092
							(gdb) c
							Continuing.
							[Switching to Thread 0x7f00a40a5700 (LWP 5816)]

							Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00a40a4220, t=1626244225) at /usr/local/mysql/sql/tztime.cc:1092
							1092	  time_t tmp_t= (time_t)t;
							(gdb) c
							Continuing.
							
		insert into t_20210722(name, age, createTime) values('bin11', 1, now());
		(Blocked)
							Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00bc01ac58, t=1626244240) at /usr/local/mysql/sql/tztime.cc:1092
							1092	  time_t tmp_t= (time_t)t;
							(gdb) bt
							#0  Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00bc01ac58, t=1626244240) at /usr/local/mysql/sql/tztime.cc:1092
							#1  0x0000000000f135b9 in Time_zone::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00bc01ac58, tv=...) at /usr/local/mysql/sql/tztime.h:60
							#2  0x00000000013f9745 in MYSQL_TIME_cache::set_datetime (this=0x7f00bc01ac58, tv=..., dec_arg=0 '\000', tz=0x2d23c68 <tz_SYSTEM>) at /usr/local/mysql/sql/item_timefunc.cc:1810
							#3  0x00000000013f9cc9 in Item_func_now::fix_length_and_dec (this=0x7f00bc01ab80) at /usr/local/mysql/sql/item_timefunc.cc:1954
							#4  0x0000000000fb5c97 in Item_func::fix_fields (this=0x7f00bc01ab80, thd=0x7f00bc01c320, ref=0x7f00bc01acb8) at /usr/local/mysql/sql/item_func.cc:246
							#5  0x00000000014ba21e in setup_fields (thd=0x7f00bc01c320, ref_pointer_array=..., fields=..., want_privilege=1, sum_func_list=0x0, allow_sum_func=false, column_update=false) at /usr/local/mysql/sql/sql_base.cc:8998
							#6  0x00000000017571c7 in Sql_cmd_insert_base::mysql_prepare_insert (this=0x7f00bc01b658, thd=0x7f00bc01c320, table_list=0x7f00bc01ad60, values=0x7f00bc01aa98, select_insert=false) at /usr/local/mysql/sql/sql_insert.cc:1302
							#7  0x0000000001754fb2 in Sql_cmd_insert::mysql_insert (this=0x7f00bc01b658, thd=0x7f00bc01c320, table_list=0x7f00bc01ad60) at /usr/local/mysql/sql/sql_insert.cc:477
							#8  0x000000000175c3ef in Sql_cmd_insert::execute (this=0x7f00bc01b658, thd=0x7f00bc01c320) at /usr/local/mysql/sql/sql_insert.cc:3118
							#9  0x0000000001535155 in mysql_execute_command (thd=0x7f00bc01c320, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3596
							#10 0x000000000153a849 in mysql_parse (thd=0x7f00bc01c320, parser_state=0x7f00a40a4690) at /usr/local/mysql/sql/sql_parse.cc:5570
							#11 0x00000000015302d8 in dispatch_command (thd=0x7f00bc01c320, com_data=0x7f00a40a4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
							#12 0x000000000152f20c in do_command (thd=0x7f00bc01c320) at /usr/local/mysql/sql/sql_parse.cc:1025
							#13 0x000000000165f7c8 in handle_connection (arg=0x6105e10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
							#14 0x0000000001ce7612 in pfs_spawn_thread (arg=0x53a28b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
							#15 0x00007f00cad17ea5 in start_thread () from /lib64/libpthread.so.0
							#16 0x00007f00c9bdd9fd in clone () from /lib64/libc.so.6

		
		[root@localhost ~]# ps aux|grep mysql
		mysql     5775  3.5 22.4 1294368 228308 pts/1  tl   14:28   0:05 /home/mysql/bin/mysqld --defaults-file=/etc/my.cnf
		root      5817  7.0 34.4 549316 349804 pts/7   S+   14:29   0:06 gdb -x /root/debug.file /home/mysql/bin/mysqld
		root      5829  0.0  0.3 134704  3100 pts/5    S+   14:30   0:00 mysql -uroot -px xxxxxxx
		root      5832  0.0  0.0 112828   976 pts/1    R+   14:31   0:00 grep --color=auto mysql
		[root@localhost ~]# kill 5817
		[root@localhost ~]# ps aux|grep mysql
		mysql     5775  2.5 22.6 1294368 229888 pts/1  Sl   14:28   0:05 /home/mysql/bin/mysqld --defaults-file=/etc/my.cnf
		root      5829  0.0  0.3 134704  3100 pts/5    S+   14:30   0:00 mysql -uroot -px xxxxxxx
		root      5834  0.0  0.0 112828   972 pts/1    R+   14:32   0:00 grep --color=auto mysql
		
		
		mysql> select count(*) from t_20210722;
		+----------+
		| count(*) |
		+----------+
		|       13 |
		+----------+
		1 row in set (0.04 sec)


	--------------------------------------------------------------------
	
	
	2.4.3 timestamp时间类型字段插入指定时间
		
		mysql> select count(*) from t_20210722;
		+----------+
		| count(*) |
		+----------+
		|       13 |
		+----------+
		1 row in set (0.04 sec)
		
		mysql> insert into t_20210722(name, age, createTime) values('bin11', 1, '2021-07-14 14:42:13');
		Query OK, 1 row affected (0.03 sec)

		mysql> select count(*) from t_20210722;
		+----------+
		| count(*) |
		+----------+
		|       14 |
		+----------+
		1 row in set (0.00 sec)

2.5 删除操作
 		
	mysql> select * from t_20210722;
	+----+-------+-----+---------------------+
	| id | name  | age | createTime          |
	+----+-------+-----+---------------------+
	|  1 | bin   |   1 | 2021-07-13 16:51:52 |
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
	| 12 | bin11 |   1 | 2021-07-14 11:56:09 |
	| 13 | bin11 |   1 | 2021-07-14 14:30:40 |
	| 14 | bin11 |   1 | 2021-07-14 14:42:13 |
	+----+-------+-----+---------------------+
	14 rows in set (0.00 sec)
	
	2.5.1 根据主键ID作为条件删除
	
	
					(gdb)  b Time_zone_system::gmt_sec_to_TIME
					Breakpoint 2 at 0x163a1d4: file /usr/local/mysql/sql/tztime.cc, line 1092.
					(gdb) info b
					Num     Type           Disp Enb Address            What
					1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
						breakpoint already hit 1 time
					2       breakpoint     keep y   0x000000000163a1d4 in Time_zone_system::gmt_sec_to_TIME(st_mysql_time*, long) const at /usr/local/mysql/sql/tztime.cc:1092
					(gdb) c
					Continuing.
					[Switching to Thread 0x7f00a40a5700 (LWP 5816)]

					Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00a40a4220, t=1626248792) at /usr/local/mysql/sql/tztime.cc:1092
					1092	  time_t tmp_t= (time_t)t;
					(gdb) c
					Continuing.

		mysql> delete from t_20210722 where id=1;
		Query OK, 1 row affected (0.00 sec)

		
	2.5.2 根据时间作为条件删除记录
	
			
					(gdb) b Time_zone_system::gmt_sec_to_TIME
					Breakpoint 2 at 0x163a1d4: file /usr/local/mysql/sql/tztime.cc, line 1092.
					(gdb) info b
					Num     Type           Disp Enb Address            What
					1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
						breakpoint already hit 1 time
					2       breakpoint     keep y   0x000000000163a1d4 in Time_zone_system::gmt_sec_to_TIME(st_mysql_time*, long) const at /usr/local/mysql/sql/tztime.cc:1092
					(gdb) c
					Continuing.
					[Switching to Thread 0x7f00a40a5700 (LWP 5816)]

					Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00a40a4220, t=1626248681) at /usr/local/mysql/sql/tztime.cc:1092
					1092	  time_t tmp_t= (time_t)t;
					(gdb) c
					Continuing.
		
		mysql> delete from t_20210722 where createTime="2021-07-13 15:48:44";
		(Blocked)
					Breakpoint 2, Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00a40a2da0, t=1626162524) at /usr/local/mysql/sql/tztime.cc:1092
					1092	  time_t tmp_t= (time_t)t;
					(gdb) bt
					#0  Time_zone_system::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00a40a2da0, t=1626162524) at /usr/local/mysql/sql/tztime.cc:1092
					#1  0x0000000000f135b9 in Time_zone::gmt_sec_to_TIME (this=0x2d23c68 <tz_SYSTEM>, tmp=0x7f00a40a2da0, tv=...) at /usr/local/mysql/sql/tztime.h:60
					#2  0x0000000000ef8b8d in Field_timestampf::get_date_internal (this=0x7f00bc964de0, ltime=0x7f00a40a2da0) at /usr/local/mysql/sql/field.cc:5986
					#3  0x0000000000ef6e46 in Field_temporal_with_date::val_date_temporal (this=0x7f00bc964de0) at /usr/local/mysql/sql/field.cc:5328
					#4  0x0000000000f48743 in Item_field::val_date_temporal (this=0x7f00bc01ae30) at /usr/local/mysql/sql/item.cc:2993
					#5  0x0000000000f6cf14 in get_datetime_value (thd=0x7f00bc01c320, item_arg=0x7f00bc01b530, cache_arg=0x7f00bc01b570, warn_item=0x7f00bc01b5f8, is_null=0x7f00a40a2eb7) at /usr/local/mysql/sql/item_cmpfunc.cc:1384
					#6  0x0000000000f6d1f5 in Arg_comparator::compare_datetime (this=0x7f00bc01b530) at /usr/local/mysql/sql/item_cmpfunc.cc:1505
					#7  0x0000000000f8268a in Arg_comparator::compare (this=0x7f00bc01b530) at /usr/local/mysql/sql/item_cmpfunc.h:92
					#8  0x0000000000f6fdeb in Item_func_eq::val_int (this=0x7f00bc01b458) at /usr/local/mysql/sql/item_cmpfunc.cc:2509
					#9  0x0000000000f1dc11 in QEP_TAB::skip_record (this=0x7f00a40a31c8, thd=0x7f00bc01c320, skip_record_arg=0x7f00a40a339e) at /usr/local/mysql/sql/sql_executor.h:457
					#10 0x000000000174cd86 in Sql_cmd_delete::mysql_delete (this=0x7f00bc01b108, thd=0x7f00bc01c320, limit=18446744073709551615) at /usr/local/mysql/sql/sql_delete.cc:468
					#11 0x000000000174fb9c in Sql_cmd_delete::execute (this=0x7f00bc01b108, thd=0x7f00bc01c320) at /usr/local/mysql/sql/sql_delete.cc:1392
					#12 0x00000000015351f1 in mysql_execute_command (thd=0x7f00bc01c320, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
					#13 0x000000000153a849 in mysql_parse (thd=0x7f00bc01c320, parser_state=0x7f00a40a4690) at /usr/local/mysql/sql/sql_parse.cc:5570
					#14 0x00000000015302d8 in dispatch_command (thd=0x7f00bc01c320, com_data=0x7f00a40a4df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
					#15 0x000000000152f20c in do_command (thd=0x7f00bc01c320) at /usr/local/mysql/sql/sql_parse.cc:1025
					#16 0x000000000165f7c8 in handle_connection (arg=0x6105e10) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
					#17 0x0000000001ce7612 in pfs_spawn_thread (arg=0x53a28b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
					#18 0x00007f00cad17ea5 in start_thread () from /lib64/libpthread.so.0
					#19 0x00007f00c9bdd9fd in clone () from /lib64/libc.so.6


		
2.9 小结

	-- 查询字段包含 timestamp 类型的字段，更新timestamp类型字段的值，都会走 Time_zone_system::gmt_sec_to_TIME 时区转换的逻辑。
	-- 根据timestamp类型的字段作为where查询条件，不会走操作系统时区转换的逻辑。
	-- 这种转换操作是每行符合条件的数据都需要转换的。
	
	



3. time_zone='+08:00'

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

3.1 更新timestamp时间字段值为指定时间

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

3.2 更新timestamp时间字段值为now()

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

3.3 更新timestamp时间字段值为now()并打断点查看椎栈

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


4. 小结
	
	使用GDB调试源码，自己也会更有底气解释某个原理/实践对不对。
	
	
	
	