
insert 断点调试

1. 查看 mysql 进程 id
	[root@localhost mysql]# 
	[root@localhost mysql]# ps aux | grep mysql
	mysql    25848  0.1 18.3 1259836 186924 pts/0  Sl   12:19   0:12 /home/mysql/bin/mysqld --defaults-file=/etc/my.cnf
	root     25952  0.0 28.9 491924 294288 pts/3   S+   12:24   0:05 gdb -x /root/debug.file /home/mysql/bin/mysqld
	root     25954  0.0  0.4  63948  4952 pts/3    t    12:24   0:00 /home/mysql/bin/mysqld --defaults-file=/etc/my.cnf --user=mysql --gdb
	root     27642  0.0  0.0 112828   976 pts/0    R+   14:25   0:00 grep --color=auto mysql



	可以看到此时mysql的进程号为：25848



2. gdb 中 attach mysql 进程

	(gdb) attach 25848
	A program is being debugged already.  Kill it? (y or n) y
	Attaching to program: /home/mysql/bin/mysqld, process 25848
	Reading symbols from /lib64/libpthread.so.0...(no debugging symbols found)...done.
	[New LWP 25890]
	[New LWP 25884]
	[New LWP 25883]
	[New LWP 25882]
	[New LWP 25881]
	[New LWP 25880]
	[New LWP 25879]
	[New LWP 25878]
	[New LWP 25877]
	[New LWP 25876]
	[New LWP 25875]
	[New LWP 25874]
	[New LWP 25873]
	[New LWP 25872]
	[New LWP 25871]
	[New LWP 25870]
	[New LWP 25868]
	[New LWP 25867]
	[New LWP 25866]
	[New LWP 25865]
	[New LWP 25864]
	[New LWP 25863]
	[New LWP 25862]
	[New LWP 25861]
	[New LWP 25860]
	[New LWP 25859]
	[New LWP 25858]
	[New LWP 25857]
	[New LWP 25856]
	[New LWP 25855]
	[New LWP 25854]
	[New LWP 25853]
	[New LWP 25852]
	[New LWP 25851]
	[New LWP 25850]
	[New LWP 25849]
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
	0x00007f293d978ccd in poll () from /lib64/libc.so.6


3. 找到断点
	这次看的是 insert 插入的流程，找到 sql_insert.cc 文件：
	源码中的函数为：Sql_cmd_insert::mysql_insert

4. 设置断点
	(gdb) b Sql_cmd_insert::mysql_insert
	Breakpoint 2 at 0x1754d6d: file /usr/local/mysql/sql/sql_insert.cc, line 423.


	然后查看下线程的栈帧：
		(gdb) bt
		#0  0x00007f293d978ccd in poll () from /lib64/libc.so.6
		#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x4f9c800) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
		#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4f89ce0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
		#3  0x0000000000ea2eea in mysqld_main (argc=109, argv=0x442d948) at /usr/local/mysql/sql/mysqld.cc:5149
		#4  0x0000000000e9a05d in main (argc=2, argv=0x7fffb8c05a78) at /usr/local/mysql/sql/main.cc:25
	
	
5. 数据库登陆
	gdb断点设置完后，起个新的数据库连接：	
		[root@localhost mysql]# mysql -uroot -p123456abc
		mysql: [Warning] Using a password on the command line interface can be insecure.
			
			
	会发现此时无法登陆，在gdb中执行next：

		(gdb) n
		Single stepping until exit from function poll,
		which has no line number information.
		Mysqld_socket_listener::listen_for_connection_event (this=0x4f9c800) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:859
		859	  if (retval < 0 && socket_errno != SOCKET_EINTR)


		通过输出可以知道数据库处于获取系统 socket 状态。接下来需要跳过的步骤有些多，我们直接使用 continue （直接到下一段可执行代码）
		
	(gdb) c
	Continuing.

	新起客户端连接成功：
	
		[root@localhost mysql]# mysql -uroot -p123456abc
		mysql: [Warning] Using a password on the command line interface can be insecure.


		Welcome to the MySQL monitor.  Commands end with ; or \g.
		Your MySQL connection id is 5
		Server version: 5.7.26-debug-log Source distribution

		Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

		Oracle is a registered trademark of Oracle Corporation and/or its
		affiliates. Other names may be trademarks of their respective
		owners.

		Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

		mysql> 
		mysql> 
		mysql> 
			
	插入操作前，创建/切换schema和查询都是没问题的：
	
		create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		use sbtest;
		CREATE TABLE `t` (
		  `id` bigint(11) NOT NULL AUTO_INCREMENT,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


		mysql> create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
			-> ;
		Query OK, 1 row affected (0.00 sec)

		mysql> use sbtest;
		Database changed
		mysql> CREATE TABLE `t` (
			->   `id` bigint(11) NOT NULL AUTO_INCREMENT,
			->   `c` int(11) DEFAULT NULL,
			->   `d` int(11) DEFAULT NULL,
			->   PRIMARY KEY (`id`),
			->   KEY `c` (`c`)
			-> ) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
		Query OK, 0 rows affected (0.05 sec)

		mysql> show create table t\G;
		*************************** 1. row ***************************
			   Table: t
		Create Table: CREATE TABLE `t` (
		  `id` bigint(11) NOT NULL AUTO_INCREMENT,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
		1 row in set (0.01 sec)
		
		mysql> select * from t;
		Empty set (0.00 sec)

		INSERT INTO `t` (`c`, `d`) VALUES ('1', '1');
		
		
7. 分析断点信息

	断点触发，如下：
		(gdb) c
		Continuing.
		[Switching to Thread 0x7f29341ce700 (LWP 25890)]

		Breakpoint 2, Sql_cmd_insert::mysql_insert (this=0x7f2930013d48, thd=0x7f293001c0f0, table_list=0x7f2930013568) at /usr/local/mysql/sql/sql_insert.cc:423
		423	  DBUG_ENTER("mysql_insert");
		
		bt 命令展示栈帧：
			(gdb) bt
			#0  Sql_cmd_insert::mysql_insert (this=0x7f2930013d48, thd=0x7f293001c0f0, table_list=0x7f2930013568) at /usr/local/mysql/sql/sql_insert.cc:423
			#1  0x000000000175c3ef in Sql_cmd_insert::execute (this=0x7f2930013d48, thd=0x7f293001c0f0) at /usr/local/mysql/sql/sql_insert.cc:3118
			#2  0x0000000001535155 in mysql_execute_command (thd=0x7f293001c0f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3596
			#3  0x000000000153a849 in mysql_parse (thd=0x7f293001c0f0, parser_state=0x7f29341cd690) at /usr/local/mysql/sql/sql_parse.cc:5570
			#4  0x00000000015302d8 in dispatch_command (thd=0x7f293001c0f0, com_data=0x7f29341cddf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
			#5  0x000000000152f20c in do_command (thd=0x7f293001c0f0) at /usr/local/mysql/sql/sql_parse.cc:1025
			#6  0x000000000165f7c8 in handle_connection (arg=0x50e8490) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
			#7  0x0000000001ce7612 in pfs_spawn_thread (arg=0x5028510) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
			#8  0x00007f293eabdea5 in start_thread () from /lib64/libpthread.so.0
			#9  0x00007f293d9839fd in clone () from /lib64/libc.so.6
	
	接下来输入 n 会逐行输出，如果直接 continue，阻塞的 insert 也完成了：

		(gdb) n
		425	  LEX *const lex= thd->lex;
		(gdb) n
		427	  bool err= true;
		(gdb) n
		428	  bool transactional_table, joins_freed= FALSE;
		(gdb) n
		430	  bool is_locked= false;
		(gdb) c
		Continuing.

		
		mysql> INSERT INTO `t` (`c`, `d`) VALUES ('1', '1');
		Query OK, 1 row affected (2 min 6.35 sec)

		mysql> select * from t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		+----+------+------+
		1 row in set (0.00 sec)
