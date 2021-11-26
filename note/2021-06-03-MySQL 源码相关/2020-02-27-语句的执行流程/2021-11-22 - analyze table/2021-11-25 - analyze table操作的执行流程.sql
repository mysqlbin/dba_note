

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

mysql> SELECT * FROM t;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  1 |    1 |    1 |
|  2 |    2 |    2 |
|  3 |    3 |    3 |
|  4 |    4 |    4 |
|  5 |    5 |    5 |
|  6 |    6 |    6 |
|  7 |    7 |    7 |
|  8 |    8 |    8 |
|  9 |    9 |    9 |
| 10 |   10 |   10 |
| 11 |   11 |   11 |
| 12 |   12 |   12 |
| 13 |   13 |   13 |
| 14 |   14 |   14 |
| 15 |   15 |   15 |
+----+------+------+
15 rows in set (0.01 sec)

------------------------------------------------------------------------------

session A              session B      

b dict_stats_save		
					  analyze table t;
					  
					  


(gdb) b dict_stats_save
Breakpoint 2 at 0x1bc2178: file /usr/local/mysql/storage/innobase/dict/dict0stats.cc, line 2371.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000001bc2178 in dict_stats_save(dict_table_t*, index_id_t const*) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
(gdb) c
Continuing.
[Switching to Thread 0x7f59101b9700 (LWP 11748)]

Breakpoint 2, dict_stats_save (table_orig=0x7f58f096ce40, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
2371		table = dict_stats_snapshot_create(table_orig);
(gdb) bt
#0  dict_stats_save (table_orig=0x7f58f096ce40, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7f58f096ce40, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x00000000018ca6ae in ha_innobase::info_low (this=0x7f58f0945040, flag=28, is_analyze=true) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:14028
#3  0x00000000018cb3c1 in ha_innobase::analyze (this=0x7f58f0945040, thd=0x7f58f000a8c0, check_opt=0x7f58f000d0d8) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:14487
#4  0x0000000000f2f9c7 in handler::ha_analyze (this=0x7f58f0945040, thd=0x7f58f000a8c0, check_opt=0x7f58f000d0d8) at /usr/local/mysql/sql/handler.cc:4733

lock_type=TL_READ_NO_INSERT：表示加 read only 锁，阻塞DML请求。
	
#5  0x000000000173fc7c in mysql_admin_table(THD *, TABLE_LIST *, HA_CHECK_OPT *, const char *, thr_lock_type, bool, bool, uint, int (*)(THD *, TABLE_LIST *, HA_CHECK_OPT *), struct {...}, int (*)(THD *, TABLE_LIST *)) (thd=0x7f58f000a8c0, tables=0x7f58f000ff68, 
    check_opt=0x7f58f000d0d8, operator_name=0x219bb4f "analyze", lock_type=TL_READ_NO_INSERT, open_for_modify=true, repair_table_use_frm=false, extra_open_options=0, prepare_func=0x0, operator_func=
    (int (handler::*)(handler * const, THD *, HA_CHECK_OPT *)) 0xf2f946 <handler::ha_analyze(THD*, st_ha_check_opt*)>, view_operator_func=0x0) at /usr/local/mysql/sql/sql_admin.cc:708
#6  0x00000000017416ea in Sql_cmd_analyze_table::execute (this=0x7f58f00104f8, thd=0x7f58f000a8c0) at /usr/local/mysql/sql/sql_admin.cc:1214
#7  0x0000000001538aa0 in mysql_execute_command (thd=0x7f58f000a8c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4835
#8  0x000000000153a849 in mysql_parse (thd=0x7f58f000a8c0, parser_state=0x7f59101b8690) at /usr/local/mysql/sql/sql_parse.cc:5570
#9  0x00000000015302d8 in dispatch_command (thd=0x7f58f000a8c0, com_data=0x7f59101b8df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#10 0x000000000152f20c in do_command (thd=0x7f58f000a8c0) at /usr/local/mysql/sql/sql_parse.cc:1025
#11 0x000000000165f7c8 in handle_connection (arg=0x6089170) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#12 0x0000000001ce7612 in pfs_spawn_thread (arg=0x64db6d0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#13 0x00007f591b197ea5 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f591a05d9fd in clone () from /lib64/libc.so.6




Sql_cmd_analyze_table::execute 
	-> mysql_admin_table
		-> handler::ha_analyze
			-> ha_innobase::analyze
				-> ha_innobase::info_low
					-> dict_stats_update
						-> dict_stats_save
						

--------------------------------------------------------------------------------------------------

The current lock types are:

TL_READ	 		# Low priority read
TL_READ_WITH_SHARED_LOCKS
TL_READ_HIGH_PRIORITY	# High priority read
TL_READ_NO_INSERT	# Read without concurrent inserts
TL_WRITE_ALLOW_WRITE	# Write lock that allows other writers
TL_WRITE_CONCURRENT_INSERT
			# Insert that can be mixed when selects
			# Allows lower locks to take over
TL_WRITE_LOW_PRIORITY	# Low priority write
TL_WRITE		# High priority write
TL_WRITE_ONLY		# High priority write
			# Abort all new lock request with an error
			
			
---------------------------------------------------------------------------------------------------------------------------------------------------			
			

bool Sql_cmd_analyze_table::execute(THD *thd)
{
  TABLE_LIST *first_table= thd->lex->select_lex->get_table_list();
  bool res= TRUE;
  thr_lock_type lock_type = TL_READ_NO_INSERT;
  DBUG_ENTER("Sql_cmd_analyze_table::execute");

  if (check_table_access(thd, SELECT_ACL | INSERT_ACL, first_table,
                         FALSE, UINT_MAX, FALSE))
    goto error;
  thd->enable_slow_log= opt_log_slow_admin_statements;
  res= mysql_admin_table(thd, first_table, &thd->lex->check_opt,
                         "analyze", lock_type, 1, 0, 0, 0,
                         &handler::ha_analyze, 0);
  /* ! we write after unlocking the table */
  if (!res && !thd->lex->no_write_to_binlog)
  {
    /*
      Presumably, ANALYZE and binlog writing doesn't require synchronization
    */
    res= write_bin_log(thd, true, thd->query().str, thd->query().length);
  }
  thd->lex->select_lex->table_list.first= first_table;
  thd->lex->query_tables= first_table;

error:
  DBUG_RETURN(res);
}



/*
	将表的统计信息返回给MySQL解释器，在handle对象的各个领域
*/
/*********************************************************************//**
Returns statistics information of the table to the MySQL interpreter,
in various fields of the handle object.
@return HA_ERR_* error code or 0 */

int
ha_innobase::info_low(
/*==================*/
	uint	flag,	/*!< in: what information is requested */
	bool	is_analyze)
{


