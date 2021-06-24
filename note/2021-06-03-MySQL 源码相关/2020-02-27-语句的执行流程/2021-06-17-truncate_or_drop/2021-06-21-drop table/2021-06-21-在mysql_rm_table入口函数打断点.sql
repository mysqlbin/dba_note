
(gdb) bt
#0  ha_remove_all_nodes_to_page (table=0x4d4d878, fold=12525122382799968870, page=0x7f2930fd4000 "V@G\253\377\377\377\377") at /usr/local/mysql/storage/innobase/ha/ha0ha.cc:414
#1  0x0000000001b385ee in btr_search_drop_page_hash_index (block=0x7f292fa77d48) at /usr/local/mysql/storage/innobase/btr/btr0sea.cc:1326
#2  0x0000000001b779fa in buf_LRU_free_page (bpage=0x7f292fa77d48, zip=true) at /usr/local/mysql/storage/innobase/buf/buf0lru.cc:2062
#3  0x0000000001b6a9d4 in buf_flush_LRU_list_batch (buf_pool=0x46f54f8, max=4000) at /usr/local/mysql/storage/innobase/buf/buf0flu.cc:1650
#4  0x0000000001b6ae51 in buf_do_LRU_batch (buf_pool=0x46f54f8, max=4000) at /usr/local/mysql/storage/innobase/buf/buf0flu.cc:1723
#5  0x0000000001b6b483 in buf_flush_batch (buf_pool=0x46f54f8, flush_type=BUF_FLUSH_LRU, min_n=4000, lsn_limit=0) at /usr/local/mysql/storage/innobase/buf/buf0flu.cc:1855
#6  0x0000000001b6ba34 in buf_flush_do_batch (buf_pool=0x46f54f8, type=BUF_FLUSH_LRU, min_n=4000, lsn_limit=0, n_processed=0x7f292218c950) at /usr/local/mysql/storage/innobase/buf/buf0flu.cc:2018
#7  0x0000000001b6c350 in buf_flush_LRU_list (buf_pool=0x46f54f8) at /usr/local/mysql/storage/innobase/buf/buf0flu.cc:2293
#8  0x0000000001b6e77b in pc_flush_slot () at /usr/local/mysql/storage/innobase/buf/buf0flu.cc:2855
#9  0x0000000001b6f75d in buf_flush_page_cleaner_coordinator (arg=0x0) at /usr/local/mysql/storage/innobase/buf/buf0flu.cc:3298
#10 0x00007f2947fe5ea5 in start_thread () from /lib64/libpthread.so.0
#11 0x00007f2946eab9fd in clone () from /lib64/libc.so.6


CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB; 
insert into t values(5,1,'2018-11-13');


b mysql_rm_table

fseg_free_page_low



(gdb) b mysql_rm_table
Breakpoint 2 at 0x15b8259: file /usr/local/mysql/sql/sql_table.cc, line 2078.
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) n
Single stepping until exit from function poll,
which has no line number information.

	-- #0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6




	breakpoint already hit 1 time
(gdb) b mysql_rm_table
Breakpoint 2 at 0x15b8259: file /usr/local/mysql/sql/sql_table.cc, line 2078.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x00000000015b8259 in mysql_rm_table(THD*, TABLE_LIST*, char, char) at /usr/local/mysql/sql/sql_table.cc:2078
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x00000000015b8259 in mysql_rm_table(THD*, TABLE_LIST*, char, char) at /usr/local/mysql/sql/sql_table.cc:2078
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x00000000015b8259 in mysql_rm_table(THD*, TABLE_LIST*, char, char) at /usr/local/mysql/sql/sql_table.cc:2078
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) bt
#0  0x00007f2946ea0ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x53f1de0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x50b7920) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x42dc948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffd18c8fb68) at /usr/local/mysql/sql/main.cc:25
(gdb) c
Continuing.
[Switching to Thread 0x7f29200a2700 (LWP 32661)]

Breakpoint 2, mysql_rm_table (thd=0x7f2939c88220, tables=0x7f2939ed28f8, if_exists=0 '\000', drop_temporary=0 '\000') at /usr/local/mysql/sql/sql_table.cc:2078
2078	  Drop_table_error_handler err_handler;
(gdb) bt
#0  mysql_rm_table (thd=0x7f2939c88220, tables=0x7f2939ed28f8, if_exists=0 '\000', drop_temporary=0 '\000') at /usr/local/mysql/sql/sql_table.cc:2078
#1  0x00000000015352a5 in mysql_execute_command (thd=0x7f2939c88220, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3619
#2  0x000000000153a849 in mysql_parse (thd=0x7f2939c88220, parser_state=0x7f29200a1690) at /usr/local/mysql/sql/sql_parse.cc:5570
#3  0x00000000015302d8 in dispatch_command (thd=0x7f2939c88220, com_data=0x7f29200a1df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#4  0x000000000152f20c in do_command (thd=0x7f2939c88220) at /usr/local/mysql/sql/sql_parse.cc:1025
#5  0x000000000165f7c8 in handle_connection (arg=0x5cdeb30) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#6  0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f82310) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#7  0x00007f2947fe5ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f2946eab9fd in clone () from /lib64/libc.so.6
(gdb) bt
#0  mysql_rm_table (thd=0x7f2939c88220, tables=0x7f2939ed28f8, if_exists=0 '\000', drop_temporary=0 '\000') at /usr/local/mysql/sql/sql_table.cc:2078
#1  0x00000000015352a5 in mysql_execute_command (thd=0x7f2939c88220, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3619
#2  0x000000000153a849 in mysql_parse (thd=0x7f2939c88220, parser_state=0x7f29200a1690) at /usr/local/mysql/sql/sql_parse.cc:5570
#3  0x00000000015302d8 in dispatch_command (thd=0x7f2939c88220, com_data=0x7f29200a1df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#4  0x000000000152f20c in do_command (thd=0x7f2939c88220) at /usr/local/mysql/sql/sql_parse.cc:1025
#5  0x000000000165f7c8 in handle_connection (arg=0x5cdeb30) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#6  0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f82310) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#7  0x00007f2947fe5ea5 in start_thread () from /lib64/libpthread.so.0
#8  0x00007f2946eab9fd in clone () from /lib64/libc.so.6
(gdb) n
2083	  uint have_non_tmp_table= 0;
(gdb) n
2084	  uint have_trans_tmp_table= 0;
(gdb) n
2085	  uint have_non_trans_tmp_table= 0;
(gdb) n
2087	  DBUG_ENTER("mysql_rm_table");
(gdb) n
2090	  if (thd->get_transaction()->xid_state()->check_xa_idle_or_prepared(true))
(gdb) n
2096	  for (table= tables; table; table= table->next_local)
(gdb) n
2098	    if (query_logger.check_if_log_table(table, true))
(gdb) n
2107	    if (is_temporary_table(table))
(gdb) n
2096	  for (table= tables; table; table= table->next_local)
(gdb) n
2116	  if (!drop_temporary)
(gdb) n
2118	    if (!thd->locked_tables_mode)
(gdb) n
2121	                           thd->variables.lock_wait_timeout, 0))
(gdb) n
2120	      if (lock_table_names(thd, tables, NULL,
(gdb) n
2123	      for (table= tables; table; table= table->next_local)
(gdb) n
2125	        if (is_temporary_table(table))
(gdb) n
2129	                         false);
(gdb) n
2131	        have_non_tmp_table= 1;
(gdb) n
2123	      for (table= tables; table; table= table->next_local)
(gdb) n
2182	  if (thd->variables.gtid_next.type == GTID_GROUP &&
(gdb) n
2194	  thd->push_internal_handler(&err_handler);
(gdb) n
2196	                                 false, false);
(gdb) n
2197	  thd->pop_internal_handler();
(gdb) n
2199	  if (error)
(gdb) n
2200	    DBUG_RETURN(TRUE);
(gdb) n
2214	}
(gdb) n
mysql_execute_command (thd=0x7f2939c88220, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3622
3622	    if(!res && lex->drop_temporary)
(gdb) n
3628	  break;
(gdb) n
4940	  goto finish;
(gdb) n
4946	  THD_STAGE_INFO(thd, stage_query_end);
(gdb) n
4949	  if (!thd->in_sub_stmt)
(gdb) n
4951	    if (is_explainable_query(lex->sql_command))
(gdb) n
4960	    thd->query_plan.set_query_plan(SQLCOM_END, NULL, false);
(gdb) n
4963	  DBUG_ASSERT(!thd->in_active_multi_stmt_transaction() ||
(gdb) n
4964	               thd->in_multi_stmt_transaction_mode());
(gdb) n
4966	  if (! thd->in_sub_stmt)
(gdb) n
4973	                                     "MYSQL_AUDIT_QUERY_NESTED_STATUS_END");
(gdb) n
4977	    if (thd->killed_errno())
(gdb) n
4979	    if (thd->is_error() || (thd->variables.option_bits & OPTION_MASTER_SQL_ERROR))
(gdb) n
4980	      trans_rollback_stmt(thd);
(gdb) n
4988	    if (thd->killed == THD::KILL_QUERY ||
(gdb) n
4989	        thd->killed == THD::KILL_TIMEOUT ||
(gdb) n
4988	    if (thd->killed == THD::KILL_QUERY ||
(gdb) n
4990	        thd->killed == THD::KILL_BAD_DATA)
(gdb) n
4989	        thd->killed == THD::KILL_TIMEOUT ||
(gdb) n
4988	    if (thd->killed == THD::KILL_QUERY ||
(gdb) n
4996	  lex->unit->cleanup(true);
(gdb) n
4998	  THD_STAGE_INFO(thd, stage_closing_tables);
(gdb) n
4999	  close_thread_tables(thd);
(gdb) n
5002	  if (lex->sql_command != SQLCOM_SET_OPTION && ! thd->in_sub_stmt)
(gdb) n
5003	    DEBUG_SYNC(thd, "execute_command_after_close_tables");
(gdb) n
5006	  if (! thd->in_sub_stmt && thd->transaction_rollback_request)
(gdb) n
5016	  else if (stmt_causes_implicit_commit(thd, CF_IMPLICIT_COMMIT_END))
(gdb) n
5019	    DBUG_ASSERT(! thd->in_sub_stmt);
(gdb) n
5021	    thd->get_stmt_da()->set_overwrite_status(true);
(gdb) n
5023	    trans_commit_implicit(thd);
(gdb) n
5024	    thd->get_stmt_da()->set_overwrite_status(false);
(gdb) n
5025	    thd->mdl_context.release_transactional_locks();
(gdb) n
5046	  if (thd->variables.session_track_transaction_info > TX_TRACK_NONE)
(gdb) n
5084	  if (!res && !thd->is_error()) {      // if statement succeeded
(gdb) n
5087	  } else if (!gtid_consistency_violation_state &&    // if the consistency state
(gdb) n
5094	  DBUG_RETURN(res || thd->is_error());
(gdb) n
2638	  Opt_trace_array trace_command_steps(&thd->opt_trace, "steps");
(gdb) n
2637	  Opt_trace_object trace_command(&thd->opt_trace);
(gdb) n
5094	  DBUG_RETURN(res || thd->is_error());
(gdb) n
5095	}
(gdb) n
mysql_parse (thd=0x7f2939c88220, parser_state=0x7f29200a1690) at /usr/local/mysql/sql/sql_parse.cc:5610
5610	    THD_STAGE_INFO(thd, stage_freeing_items);
(gdb) n
5611	    sp_cache_enforce_limit(thd->sp_proc_cache, stored_program_cache_size);
(gdb) n
5612	    sp_cache_enforce_limit(thd->sp_func_cache, stored_program_cache_size);
(gdb) n
5613	    thd->end_statement();
(gdb) bt
#0  mysql_parse (thd=0x7f2939c88220, parser_state=0x7f29200a1690) at /usr/local/mysql/sql/sql_parse.cc:5613
#1  0x00000000015302d8 in dispatch_command (thd=0x7f2939c88220, com_data=0x7f29200a1df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#2  0x000000000152f20c in do_command (thd=0x7f2939c88220) at /usr/local/mysql/sql/sql_parse.cc:1025
#3  0x000000000165f7c8 in handle_connection (arg=0x5cdeb30) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#4  0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f82310) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#5  0x00007f2947fe5ea5 in start_thread () from /lib64/libpthread.so.0
#6  0x00007f2946eab9fd in clone () from /lib64/libc.so.6
(gdb) n
5614	    thd->cleanup_after_query();
(gdb) n
5615	    DBUG_ASSERT(thd->change_list.is_empty());
(gdb) n
5635	  DBUG_VOID_RETURN;
(gdb) n
5636	}
(gdb) n
dispatch_command (thd=0x7f2939c88220, com_data=0x7f29200a1df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1486
1486	    while (!thd->killed && (parser_state.m_lip.found_semicolon != NULL) &&
(gdb) n
1570	    if((thd->lex->sql_command == SQLCOM_SHUTDOWN) && (thd->get_stmt_da()->is_ok()))
(gdb) n
1573	    DBUG_PRINT("info",("query ready"));
(gdb) n
1574	    break;
(gdb) n
1893	  DBUG_ASSERT(thd->derived_tables == NULL &&
(gdb) n
1895	               (thd->locked_tables_mode == LTM_LOCK_TABLES)));
(gdb) n
1893	  DBUG_ASSERT(thd->derived_tables == NULL &&
(gdb) n
1898	  thd->update_server_status();
(gdb) n
1899	  if (thd->killed)
(gdb) n
1901	  thd->send_statement_status();
(gdb) n
1902	  thd->rpl_thd_ctx.session_gtids_ctx().notify_after_response_packet(thd);
(gdb) n
1903	  query_cache.end_of_result(thd);
(gdb) quit
A debugging session is active.

	Inferior 1 [process 32615] will be detached.

Quit anyway? (y or n) y
Detaching from program: /home/mysql/bin/mysqld, process 32615
[Inferior 1 (process 32615) detached]
[root@localhost mysql]# 




