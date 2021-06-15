

use db切换数据库的源码部分
	
	com_use入口函数

		/* mysql-5.7.26\client\mysql.cc */
			/* ARGSUSED */
		static int
		com_use(String *buffer MY_ATTRIBUTE((unused)), char *line)
		{
		  char *tmp, buff[FN_REFLEN + 1];
		  int select_db;
		  uint warnings;

		  memset(buff, 0, sizeof(buff));

		  /*
			In case of quotes used, try to get the normalized db name.
		  */
		  if (get_quote_count(line) > 0)
		  {
			if (normalize_dbname(line, buff, sizeof(buff)))
			  return put_error(&mysql);
			tmp= buff;
		  }
		  else
		  {
			strmake(buff, line, sizeof(buff) - 1);
			tmp= get_arg(buff, 0);
		  }

		  if (!tmp || !*tmp)
		  {
			put_info("USE must be followed by a database name", INFO_ERROR);
			return 0;
		  }
		  /*
			We need to recheck the current database, because it may change
			under our feet, for example if DROP DATABASE or RENAME DATABASE
			(latter one not yet available by the time the comment was written)
		  */
		  get_current_db();

		  if (!current_db || cmp_database(charset_info, current_db,tmp))
		  {
			if (one_database)
			{
			  skip_updates= 1;
			  select_db= 0;    // don't do mysql_select_db()
			}
			else
			  select_db= 2;    // do mysql_select_db() and build_completion_hash()
		  }
		  else
		  {
			/*
			  USE to the current db specified.
			  We do need to send mysql_select_db() to make server
			  update database level privileges, which might
			  change since last USE (see bug#10979).
			  For performance purposes, we'll skip rebuilding of completion hash.
			*/
			skip_updates= 0;
			select_db= 1;      // do only mysql_select_db(), without completion
		  }

		  if (select_db)
		  {
			/*
			  reconnect once if connection is down or if connection was found to
			  be down during query
			*/
			if (!connected && reconnect())
			  return opt_reconnect ? -1 : 1;                        // Fatal error
			if (mysql_select_db(&mysql,tmp))
			{
			  if (mysql_errno(&mysql) != CR_SERVER_GONE_ERROR)
				return put_error(&mysql);

			  if (reconnect())
				return opt_reconnect ? -1 : 1;                      // Fatal error
			  if (mysql_select_db(&mysql,tmp))
				return put_error(&mysql);
			}
			my_free(current_db);
			current_db=my_strdup(PSI_NOT_INSTRUMENTED,
								 tmp,MYF(MY_WME));
		#ifdef HAVE_READLINE
			if (select_db > 1)
			  build_completion_hash(opt_rehash, 1);
		#endif
		  }


		  if (0 < (warnings= mysql_warning_count(&mysql)))
		  {
			my_snprintf(buff, sizeof(buff),
						"Database changed, %u warning%s", warnings,
						warnings > 1 ? "s" : "");
			put_info(buff, INFO_INFO);
			if (show_warnings == 1)
			  print_warnings();
		  }
		  else
		  put_info("Database changed",INFO_INFO);
		  return 0;
		}

	build_completion_hash函数
		/* Build up the completion hash */
		/* 构建哈希表 */
		/* Build up the completion hash */

		static void build_completion_hash(bool rehash, bool write_info)
		{
		  COMMANDS *cmd=commands;
		  MYSQL_RES *databases=0,*tables=0;
		  MYSQL_RES *fields;
		  static char ***field_names= 0;
		  MYSQL_ROW database_row,table_row;
		  MYSQL_FIELD *sql_field;
		  char buf[NAME_LEN*2+2];		 // table name plus field name plus 2
		  int i,j,num_fields;
		  DBUG_ENTER("build_completion_hash");

		#ifndef DBUG_OFF
		  if (!opt_build_completion_hash)
		#endif
		  {
			if (status.batch || quick || !current_db)
			  DBUG_VOID_RETURN;			// We don't need completion in batches
		  }

		  if (!rehash)
			DBUG_VOID_RETURN;

		  /* Free old used memory */
		  if (field_names)
			field_names=0;
		  completion_hash_clean(&ht);
		  free_root(&hash_mem_root,MYF(0));

		  /* hash this file's known subset of SQL commands */
		  while (cmd->name) {
			add_word(&ht,(char*) cmd->name);
			cmd++;
		  }

		  /* hash MySQL functions (to be implemented) */

		  /* hash all database names */
		  /* 哈希所有的数据库名称 */
		  if (mysql_query(&mysql,"show databases") == 0)
		  {
			if (!(databases = mysql_store_result(&mysql)))
			  put_info(mysql_error(&mysql),INFO_INFO);
			else
			{
			  while ((database_row=mysql_fetch_row(databases)))
			  {
			char *str=strdup_root(&hash_mem_root, (char*) database_row[0]);
			if (str)
			  add_word(&ht,(char*) str);
			  }
			  mysql_free_result(databases);
			}
		  }
		  /* hash all table names */
		  /* 给当前库所有的表名构建哈希索引 */
		  if (mysql_query(&mysql,"show tables")==0)
		  {
			if (!(tables = mysql_store_result(&mysql)))
			  put_info(mysql_error(&mysql),INFO_INFO);
			else
			{
			  if (mysql_num_rows(tables) > 0 && !opt_silent && write_info)
			  {
			tee_fprintf(stdout, "\
		Reading table information for completion of table and column names\n\
		You can turn off this feature to get a quicker startup with -A\n\n");
			  }
			  while ((table_row=mysql_fetch_row(tables)))
			  {
			char *str=strdup_root(&hash_mem_root, (char*) table_row[0]);
			if (str &&
				!completion_hash_exists(&ht,(char*) str, (uint) strlen(str)))
			  add_word(&ht,str);
			  }
			}
		  }

		  /* hash all field names, both with the table prefix and without it */
		  if (!tables)					/* no tables */
		  {
			DBUG_VOID_RETURN;
		  }
		  mysql_data_seek(tables,0);
		  if (!(field_names= (char ***) alloc_root(&hash_mem_root,sizeof(char **) *
							   (uint) (mysql_num_rows(tables)+1))))
		  {
			mysql_free_result(tables);
			DBUG_VOID_RETURN;
		  }
		  i=0;
		  while ((table_row=mysql_fetch_row(tables)))
		  {
			if ((fields=mysql_list_fields(&mysql,(const char*) table_row[0],NullS)))
			{
			  num_fields=mysql_num_fields(fields);
			  if (!(field_names[i] = (char **) alloc_root(&hash_mem_root,
								  sizeof(char *) *
								  (num_fields*2+1))))
			  {
				mysql_free_result(fields);
				break;
			  }
			  field_names[i][num_fields*2]= NULL;
			  j=0;
			  while ((sql_field=mysql_fetch_field(fields)))
			  {
			sprintf(buf,"%.64s.%.64s",table_row[0],sql_field->name);
			field_names[i][j] = strdup_root(&hash_mem_root,buf);
			add_word(&ht,field_names[i][j]);
			field_names[i][num_fields+j] = strdup_root(&hash_mem_root,
								   sql_field->name);
			if (!completion_hash_exists(&ht,field_names[i][num_fields+j],
							(uint) strlen(field_names[i][num_fields+j])))
			  add_word(&ht,field_names[i][num_fields+j]);
			j++;
			  }
			  mysql_free_result(fields);
			}
			else
			  field_names[i]= 0;

			i++;
		  }
		  mysql_free_result(tables);
		  field_names[i]=0;				// End pointer
		  DBUG_VOID_RETURN;
		}



	void add_word
		/* mysql-5.7.26\client\completion_hash.cc */

		void add_word(HashTable *ht,char *str)
		{
		  int i;
		  char *pos=str;
		  for (i=1; *pos; i++, pos++)
			completion_hash_update(ht, str, i, str);
		}



方向不对的记录

	[root@localhost data]# /home/mysql/bin/mysql -uroot -p123456abc sbtest
	mysql: [Warning] Using a password on the command line interface can be insecure.
	Reading table information for completion of table and column names
	You can turn off this feature to get a quicker startup with -A


	[root@localhost mysql]# gdb -x /root/debug.file /home/mysql/bin/mysqld
	GNU gdb (GDB) Red Hat Enterprise Linux 7.6.1-120.el7
	Copyright (C) 2013 Free Software Foundation, Inc.
	License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
	This is free software: you are free to change and redistribute it.
	There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
	and "show warranty" for details.
	This GDB was configured as "x86_64-redhat-linux-gnu".
	For bug reporting instructions, please see:
	<http://www.gnu.org/software/gdb/bugs/>...
	Reading symbols from /home/mysql/bin/mysqld...done.
	Breakpoint 1 at 0xe9a04c: file /usr/local/mysql/sql/main.cc, line 25.
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".

	Breakpoint 1, main (argc=4, argv=0x7fffffffe528) at /usr/local/mysql/sql/main.cc:25
	25	  return mysqld_main(argc, argv);
	Missing separate debuginfos, use: debuginfo-install glibc-2.17-324.el7_9.x86_64 libgcc-4.8.5-44.el7.x86_64 libstdc++-4.8.5-44.el7.x86_64 nss-softokn-freebl-3.53.1-6.el7_9.x86_64
	(gdb) attach 31379
	A program is being debugged already.  Kill it? (y or n) y
	Attaching to program: /home/mysql/bin/mysqld, process 31379
	Reading symbols from /lib64/libpthread.so.0...(no debugging symbols found)...done.
	[New LWP 31432]
	[New LWP 31431]
	[New LWP 31420]
	[New LWP 31419]
	[New LWP 31418]
	[New LWP 31417]
	[New LWP 31416]
	[New LWP 31415]
	[New LWP 31414]
	[New LWP 31413]
	[New LWP 31412]
	[New LWP 31411]
	[New LWP 31410]
	[New LWP 31409]
	[New LWP 31408]
	[New LWP 31407]
	[New LWP 31406]
	[New LWP 31399]
	[New LWP 31398]
	[New LWP 31397]
	[New LWP 31396]
	[New LWP 31395]
	[New LWP 31394]
	[New LWP 31393]
	[New LWP 31392]
	[New LWP 31391]
	[New LWP 31390]
	[New LWP 31389]
	[New LWP 31388]
	[New LWP 31387]
	[New LWP 31386]
	[New LWP 31385]
	[New LWP 31384]
	[New LWP 31383]
	[New LWP 31382]
	[New LWP 31381]
	[New LWP 31380]
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".
	Loaded symbols for /lib64/libpthread.so.0
	Reading symbols from /lib64/libcrypt.so.1...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libcrypt.so.1
	Reading symbols from /lib64/libdl.so.2...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libdl.so.2
	Reading symbols from /lib64/librt.so.1...(no debugging symbols found)...done.
	Loaded symbols for /lib64/librt.so.1
	Reading symbols from /lib64/libstdc++.so.6...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libstdc++.so.6
	Reading symbols from /lib64/libm.so.6...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libm.so.6
	Reading symbols from /lib64/libgcc_s.so.1...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libgcc_s.so.1
	Reading symbols from /lib64/libc.so.6...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libc.so.6
	Reading symbols from /lib64/ld-linux-x86-64.so.2...(no debugging symbols found)...done.
	Loaded symbols for /lib64/ld-linux-x86-64.so.2
	Reading symbols from /lib64/libfreebl3.so...Reading symbols from /lib64/libfreebl3.so...(no debugging symbols found)...done.
	(no debugging symbols found)...done.
	Loaded symbols for /lib64/libfreebl3.so
	Reading symbols from /lib64/libnss_files.so.2...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libnss_files.so.2
	0x00007fe08f46fccd in poll () from /lib64/libc.so.6
	(gdb) n
	Single stepping until exit from function poll,
	which has no line number information.
	Mysqld_socket_listener::listen_for_connection_event (this=0x60ee810) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:859
	859	  if (retval < 0 && socket_errno != SOCKET_EINTR)
	(gdb) n
	871	  if (retval < 0 || abort_loop)
	(gdb) n
	876	  MYSQL_SOCKET listen_sock= MYSQL_INVALID_SOCKET;
	(gdb) n
	877	  bool is_unix_socket= false;
	(gdb) n
	879	  for (uint i= 0; i < m_socket_map.size(); ++i)
	(gdb) n
	881	    if (m_poll_info.m_fds[i].revents & POLLIN)
	(gdb) n
	879	  for (uint i= 0; i < m_socket_map.size(); ++i)
	(gdb) s
	std::map<st_mysql_socket, bool, Socket_lt_type, std::allocator<std::pair<st_mysql_socket const, bool> > >::size (this=0x60ee838) at /usr/include/c++/4.8.2/bits/stl_map.h:435
	435	      { return _M_t.size(); }
	(gdb) s
	std::_Rb_tree<st_mysql_socket, std::pair<st_mysql_socket const, bool>, std::_Select1st<std::pair<st_mysql_socket const, bool> >, Socket_lt_type, std::allocator<std::pair<st_mysql_socket const, bool> > >::size (this=0x60ee838)
		at /usr/include/c++/4.8.2/bits/stl_tree.h:728
	728	      { return _M_impl._M_node_count; }
	(gdb) s
	Mysqld_socket_listener::listen_for_connection_event (this=0x60ee810) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:881
	881	    if (m_poll_info.m_fds[i].revents & POLLIN)
	(gdb) s
	883	      listen_sock= m_poll_info.m_pfs_fds[i];
	(gdb) s
	884	      is_unix_socket= m_socket_map[listen_sock];
	(gdb) n
	885	      break;
	(gdb) n
	904	  for (uint retry= 0; retry < MAX_ACCEPT_RETRY; retry++)
	(gdb) n
	906	    socket_len_t length= sizeof(struct sockaddr_storage);
	(gdb) n
	907	    connect_sock= mysql_socket_accept(key_socket_client_connection, listen_sock,
	(gdb) n
	908	                                      (struct sockaddr *)(&cAddr), &length);
	(gdb) n
	909	    if (mysql_socket_getfd(connect_sock) != INVALID_SOCKET ||
	(gdb) bt
	#0  Mysqld_socket_listener::listen_for_connection_event (this=0x60ee810) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:909
	#1  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x52e0cf0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#2  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x480c948) at /usr/local/mysql/sql/mysqld.cc:5149
	#3  0x0000000000e9a05d in main (argc=2, argv=0x7ffeca80a078) at /usr/local/mysql/sql/main.cc:25
	(gdb) bt
	#0  Mysqld_socket_listener::listen_for_connection_event (this=0x60ee810) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:909
	#1  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x52e0cf0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#2  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x480c948) at /usr/local/mysql/sql/mysqld.cc:5149
	#3  0x0000000000e9a05d in main (argc=2, argv=0x7ffeca80a078) at /usr/local/mysql/sql/main.cc:25
	(gdb) bt
	#0  Mysqld_socket_listener::listen_for_connection_event (this=0x60ee810) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:909
	#1  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x52e0cf0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#2  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x480c948) at /usr/local/mysql/sql/mysqld.cc:5149
	#3  0x0000000000e9a05d in main (argc=2, argv=0x7ffeca80a078) at /usr/local/mysql/sql/main.cc:25
	(gdb) n
	913	  if (mysql_socket_getfd(connect_sock) == INVALID_SOCKET)
	(gdb) n
	980	  Channel_info* channel_info= NULL;
	(gdb) n
	981	  if (is_unix_socket)
	(gdb) n
	982	    channel_info= new (std::nothrow) Channel_info_local_socket(connect_sock);
	(gdb) n
	985	  if (channel_info == NULL)
	(gdb) nn
	Undefined command: "nn".  Try "help".
	(gdb) n
	993	  return channel_info;
	(gdb) n
	994	}
	(gdb) n
	Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x52e0cf0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:67
	67	      if (channel_info != NULL)
	(gdb) n
	68	        mgr->process_new_connection(channel_info);
	(gdb) n
	64	    while (!abort_loop)
	(gdb) n
	66	      Channel_info *channel_info= m_listener->listen_for_connection_event();
	(gdb) n
	n
	nn


	  /**
		Connection acceptor loop to accept connections from clients.
		连接接收器循环接收来自客户端的连接。
	  */
	  void connection_event_loop()
	  {
		Connection_handler_manager *mgr= Connection_handler_manager::get_instance();
		while (!abort_loop)
		{
		  Channel_info *channel_info= m_listener->listen_for_connection_event();
		  if (channel_info != NULL)
			mgr->process_new_connection(channel_info);
		}
	  }
	  
	  
	  
	  
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------







	(gdb) attach 31379
	A program is being debugged already.  Kill it? (y or n) y
	Attaching to program: /home/mysql/bin/mysqld, process 31379
	Reading symbols from /lib64/libpthread.so.0...(no debugging symbols found)...done.
	[New LWP 31432]
	[New LWP 31431]
	[New LWP 31420]
	[New LWP 31419]
	[New LWP 31418]
	[New LWP 31417]
	[New LWP 31416]
	[New LWP 31415]
	[New LWP 31414]
	[New LWP 31413]
	[New LWP 31412]
	[New LWP 31411]
	[New LWP 31410]
	[New LWP 31409]
	[New LWP 31408]
	[New LWP 31407]
	[New LWP 31406]
	[New LWP 31399]
	[New LWP 31398]
	[New LWP 31397]
	[New LWP 31396]
	[New LWP 31395]
	[New LWP 31394]
	[New LWP 31393]
	[New LWP 31392]
	[New LWP 31391]
	[New LWP 31390]
	[New LWP 31389]
	[New LWP 31388]
	[New LWP 31387]
	[New LWP 31386]
	[New LWP 31385]
	[New LWP 31384]
	[New LWP 31383]
	[New LWP 31382]
	[New LWP 31381]
	[New LWP 31380]
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".
	Loaded symbols for /lib64/libpthread.so.0
	Reading symbols from /lib64/libcrypt.so.1...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libcrypt.so.1
	Reading symbols from /lib64/libdl.so.2...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libdl.so.2
	Reading symbols from /lib64/librt.so.1...(no debugging symbols found)...done.
	Loaded symbols for /lib64/librt.so.1
	Reading symbols from /lib64/libstdc++.so.6...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libstdc++.so.6
	Reading symbols from /lib64/libm.so.6...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libm.so.6
	Reading symbols from /lib64/libgcc_s.so.1...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libgcc_s.so.1
	Reading symbols from /lib64/libc.so.6...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libc.so.6
	Reading symbols from /lib64/ld-linux-x86-64.so.2...(no debugging symbols found)...done.
	Loaded symbols for /lib64/ld-linux-x86-64.so.2
	Reading symbols from /lib64/libfreebl3.so...Reading symbols from /lib64/libfreebl3.so...(no debugging symbols found)...done.
	(no debugging symbols found)...done.
	Loaded symbols for /lib64/libfreebl3.so
	Reading symbols from /lib64/libnss_files.so.2...(no debugging symbols found)...done.
	Loaded symbols for /lib64/libnss_files.so.2
	0x00007fe08f46fccd in poll () from /lib64/libc.so.6
	(gdb) bt
	#0  0x00007fe08f46fccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x60ee810) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x52e0cf0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x480c948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffeca80a078) at /usr/local/mysql/sql/main.cc:25
	(gdb) bt
	#0  0x00007fe08f46fccd in poll () from /lib64/libc.so.6
	#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x60ee810) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x52e0cf0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x480c948) at /usr/local/mysql/sql/mysqld.cc:5149
	#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffeca80a078) at /usr/local/mysql/sql/main.cc:25
	(gdb) n
	Single stepping until exit from function poll,
	which has no line number information.




	[root@localhost data]# /home/mysql/bin/mysql -uroot -p123456abc sbtest
	mysql: [Warning] Using a password on the command line interface can be insecure.
	Reading table information for completion of table and column names
	You can turn off this feature to get a quicker startup with -A

	  
	  
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	  