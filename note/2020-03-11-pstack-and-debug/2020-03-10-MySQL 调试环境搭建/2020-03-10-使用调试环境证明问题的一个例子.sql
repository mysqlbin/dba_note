
1. 初始化表结构
2. 实际操作
3. 用 pstack 分析下这个例子
4. 查看全部线程
5. 指定某个线程
6. 长时间不提交的影响： 脏页的刷新拉长了
7. gdb 退出
8. 小结

1. 初始化表结构
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB;




2. 实际操作
	2.1 查找MySQL PID
		[root@env ~]# ps aux|grep mysqld
		mysql     1882  2.2 31.9 10617672 1292200 ?    Sl   22:18   1:25 /data/mysql/bin/mysqld --basedir=/data/mysql --datadir=/data/mysql/data --plugin-dir=/data/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/data/mysql/data/mysqldb.pid --socket=/data/mysql/3306.sock --port=3306
		root      3077  0.0  0.0 112712   968 pts/9    R+   23:21   0:00 grep --color=auto mysqld
		root     32627  0.0  0.0 113312  1656 ?        S    22:18   0:00 /bin/sh /data/mysql/bin/mysqld_safe --datadir=/data/mysql/data --pid-file=/data/mysql/data/mysqldb.pid

	2.2 启动 gdb
		[root@env ~]# gdb
		GNU gdb (GDB) Red Hat Enterprise Linux 7.6.1-100.el7
		Copyright (C) 2013 Free Software Foundation, Inc.
		License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
		This is free software: you are free to change and redistribute it.
		There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
		and "show warranty" for details.
		This GDB was configured as "x86_64-redhat-linux-gnu".
		For bug reporting instructions, please see:
		<http://www.gnu.org/software/gdb/bugs/>.
		(gdb) 

	2.3 attach pid
		attach 1882

		(gdb) attach 1882
		Attaching to process 1882
		Reading symbols from /data/mysql/bin/mysqld...done.
		Reading symbols from /lib64/libpthread.so.0...Reading symbols from /usr/lib/debug/usr/lib64/libpthread-2.17.so.debug...done.
		done.
		[New LWP 2905]
		[New LWP 2207]
		[New LWP 2206]
		[New LWP 2205]
		[New LWP 1990]
		[New LWP 1973]
		[New LWP 1972]
		[New LWP 1968]
		[New LWP 1966]
		[New LWP 1965]
		[New LWP 1964]
		[New LWP 1963]
		[New LWP 1962]
		[New LWP 1961]
		[New LWP 1960]
		[New LWP 1959]
		[New LWP 1957]
		[New LWP 1956]
		[New LWP 1953]
		[New LWP 1942]
		[New LWP 1941]
		[New LWP 1940]
		[New LWP 1939]
		[New LWP 1938]
		[New LWP 1937]
		[New LWP 1936]
		[New LWP 1935]
		[New LWP 1934]
		[New LWP 1930]
		[New LWP 1926]
		[New LWP 1925]
		[New LWP 1924]
		[New LWP 1922]
		[New LWP 1921]
		[New LWP 1918]
		[New LWP 1917]
		[New LWP 1916]
		[New LWP 1915]
		[New LWP 1914]
		[New LWP 1913]
		[New LWP 1912]
		[New LWP 1896]
		[Thread debugging using libthread_db enabled]
		Using host libthread_db library "/lib64/libthread_db.so.1".
		Loaded symbols for /lib64/libpthread.so.0
		Reading symbols from /lib64/libcrypt.so.1...Reading symbols from /usr/lib/debug/usr/lib64/libcrypt-2.17.so.debug...done.
		done.
		Loaded symbols for /lib64/libcrypt.so.1
		Reading symbols from /lib64/libdl.so.2...Reading symbols from /usr/lib/debug/usr/lib64/libdl-2.17.so.debug...done.
		done.
		Loaded symbols for /lib64/libdl.so.2
		Reading symbols from /lib64/librt.so.1...Reading symbols from /usr/lib/debug/usr/lib64/librt-2.17.so.debug...done.
		done.
		Loaded symbols for /lib64/librt.so.1
		Reading symbols from /lib64/libstdc++.so.6...(no debugging symbols found)...done.
		Loaded symbols for /lib64/libstdc++.so.6
		Reading symbols from /lib64/libm.so.6...Reading symbols from /usr/lib/debug/usr/lib64/libm-2.17.so.debug...done.
		done.
		Loaded symbols for /lib64/libm.so.6
		Reading symbols from /lib64/libgcc_s.so.1...(no debugging symbols found)...done.
		Loaded symbols for /lib64/libgcc_s.so.1
		Reading symbols from /lib64/libc.so.6...Reading symbols from /usr/lib/debug/usr/lib64/libc-2.17.so.debug...done.
		done.
		Loaded symbols for /lib64/libc.so.6
		Reading symbols from /lib64/ld-linux-x86-64.so.2...Reading symbols from /usr/lib/debug/usr/lib64/ld-2.17.so.debug...done.
		done.
		Loaded symbols for /lib64/ld-linux-x86-64.so.2
		Reading symbols from /lib64/libfreebl3.so...warning: the debug information found in "/usr/lib/debug//lib64/libfreebl3.so.debug" does not match "/lib64/libfreebl3.so" (CRC mismatch).

		warning: the debug information found in "/usr/lib/debug/usr/lib64/libfreebl3.so.debug" does not match "/lib64/libfreebl3.so" (CRC mismatch).

		Reading symbols from /lib64/libfreebl3.so...(no debugging symbols found)...done.
		(no debugging symbols found)...done.
		Loaded symbols for /lib64/libfreebl3.so
		Reading symbols from /lib64/libnss_files.so.2...Reading symbols from /usr/lib/debug/usr/lib64/libnss_files-2.17.so.debug...done.
		done.
		Loaded symbols for /lib64/libnss_files.so.2
		Reading symbols from /lib64/libnss_sss.so.2...Reading symbols from /lib64/libnss_sss.so.2...(no debugging symbols found)...done.
		(no debugging symbols found)...done.
		Loaded symbols for /lib64/libnss_sss.so.2
		0x00007fc884251bed in poll () at ../sysdeps/unix/syscall-template.S:81
		81	T_PSEUDO (SYSCALL_SYMBOL, SYSCALL_NAME, SYSCALL_NARGS)
		Missing separate debuginfos, use: debuginfo-install libgcc-4.8.5-39.el7.x86_64 libstdc++-4.8.5-16.el7_4.1.x86_64 nss-softokn-freebl-3.28.3-6.el7.x86_64 sssd-client-1.15.2-50.el7.x86_64

	2.4 将断点打到这个 binlog_cache_data::flush 函数如下：

		(gdb) b binlog_cache_data::flush
		Breakpoint 1 at 0x17cdae8: file /usr/local/mysql-5.7.26/sql/binlog.cc, line 1674.


	2.5 客户端连接
		[root@env ~]# mysql -uroot -p123456abc lujb_db
		mysql: [Warning] Using a password on the command line interface can be insecure.
		阻塞中

	2.6 使用bt命令查看栈帧发现如下：
		(gdb) bt
		#0  0x00007fc884251bed in poll () at ../sysdeps/unix/syscall-template.S:81
		#1  0x00000000016626a1 in Mysqld_socket_listener::listen_for_connection_event (this=0x4bae670) at /usr/local/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
		#2  0x0000000000eab53c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x1df368d0) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
		#3  0x0000000000ea2fba in mysqld_main (argc=127, argv=0x4a80d38) at /usr/local/mysql-5.7.26/sql/mysqld.cc:5149
		#4  0x0000000000e9a12d in main (argc=10, argv=0x7ffc661a0418) at /usr/local/mysql-5.7.26/sql/main.cc:25

		因为主进程在 poll 一直在等待客户端连接请求。


	2.7 执行 continue
		(gdb) c
		Continuing.

		此时，mysql 客户端则进入 mysql 命令行界面

			[root@env ~]# mysql -uroot -p123456abc lujb_db
			mysql: [Warning] Using a password on the command line interface can be insecure.
			Welcome to the MySQL monitor.  Commands end with ; or \g.
			Your MySQL connection id is 16
			Server version: 5.7.26-debug-log Source distribution

			Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

			Oracle is a registered trademark of Oracle Corporation and/or its
			affiliates. Other names may be trademarks of their respective
			owners.

			Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.




	2.8 然后我们在MySQL客户端执行一个事物如下，并且提交：
		root@mysqldb 23:30:  [lujb_db]> begin;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 23:31:  [lujb_db]> insert into t values(5,1,'2018-11-13');
		Query OK, 1 row affected (0.00 sec)

		root@mysqldb 23:32:  [lujb_db]> commit;

		commit的时候已经卡主了，断点触发如下：

			Breakpoint 1, binlog_cache_data::flush (this=0x7fc624014090, thd=0x7fc624000d20, bytes_written=0x7fc647518120, wrote_xid=0x7fc647518157) at /usr/local/mysql-5.7.26/sql/binlog.cc:1674
			1674	  DBUG_ENTER("binlog_cache_data::flush");

	2.9 我们使用bt命令查看栈帧发现如下：

		gdb) bt
		#0  binlog_cache_data::flush (this=0x7fc624014090, thd=0x7fc624000d20, bytes_written=0x7fc647518120, wrote_xid=0x7fc647518157) at /usr/local/mysql-5.7.26/sql/binlog.cc:1674
		#1  0x00000000017e8c35 in binlog_cache_mngr::flush (this=0x7fc624014090, thd=0x7fc624000d20, bytes_written=0x7fc647518158, wrote_xid=0x7fc647518157) at /usr/local/mysql-5.7.26/sql/binlog.cc:967
		#2  0x00000000017de955 in MYSQL_BIN_LOG::flush_thread_caches (this=0x2d2d760 <mysql_bin_log>, thd=0x7fc624000d20) at /usr/local/mysql-5.7.26/sql/binlog.cc:8894
		#3  0x00000000017deb72 in MYSQL_BIN_LOG::process_flush_stage_queue (this=0x2d2d760 <mysql_bin_log>, total_bytes_var=0x7fc6475182a8, rotate_var=0x7fc6475182a7, out_queue_var=0x7fc647518298)
			at /usr/local/mysql-5.7.26/sql/binlog.cc:8957
		#4  0x00000000017e00e8 in MYSQL_BIN_LOG::ordered_commit (this=0x2d2d760 <mysql_bin_log>, thd=0x7fc624000d20, all=true, skip_commit=false) at /usr/local/mysql-5.7.26/sql/binlog.cc:9595
		#5  0x00000000017de7ca in MYSQL_BIN_LOG::commit (this=0x2d2d760 <mysql_bin_log>, thd=0x7fc624000d20, all=true) at /usr/local/mysql-5.7.26/sql/binlog.cc:8851
		#6  0x0000000000f282dd in ha_commit_trans (thd=0x7fc624000d20, all=true, ignore_global_read_lock=false) at /usr/local/mysql-5.7.26/sql/handler.cc:1799
		#7  0x0000000001632fab in trans_commit (thd=0x7fc624000d20) at /usr/local/mysql-5.7.26/sql/transaction.cc:239
		#8  0x00000000015379e1 in mysql_execute_command (thd=0x7fc624000d20, first_level=true) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:4244
		#9  0x000000000153af3e in mysql_parse (thd=0x7fc624000d20, parser_state=0x7fc64751a690) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:5570
		#10 0x000000000153084f in dispatch_command (thd=0x7fc624000d20, com_data=0x7fc64751adf0, command=COM_QUERY) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1484
		#11 0x000000000152f6b8 in do_command (thd=0x7fc624000d20) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1025
		#12 0x000000000165fff6 in handle_connection (arg=0x1e16e960) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
		#13 0x0000000001ce8640 in pfs_spawn_thread (arg=0x1e191d20) at /usr/local/mysql-5.7.26/storage/perfschema/pfs.cc:2190
		#14 0x00007fc885396e65 in start_thread (arg=0x7fc64751b700) at pthread_create.c:307
		#15 0x00007fc88425c88d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111


3. 用 pstack 分析下这个例子
	 [root@env ~]# pstack 1882 > 1882-pstack.log
	[root@env ~]# cat 1882-pstack.log  
	# 无数据

4. 查看全部线程
	(gdb) info thread
	  Id   Target Id         Frame 
	  43   Thread 0x7fc87c033700 (LWP 1896) "mysqld" 0x00007fc88419553a in do_sigwaitinfo (info=0x7fc87c032da0, set=0x7fc87c032e20) at ../sysdeps/unix/sysv/linux/sigwaitinfo.c:54
	  42   Thread 0x7fc641f12700 (LWP 1912) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  41   Thread 0x7fc641711700 (LWP 1913) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  40   Thread 0x7fc640f10700 (LWP 1914) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  39   Thread 0x7fc64070f700 (LWP 1915) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  38   Thread 0x7fc63ff0e700 (LWP 1916) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  37   Thread 0x7fc63f70d700 (LWP 1917) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  36   Thread 0x7fc63ef0c700 (LWP 1918) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  35   Thread 0x7fc63e70b700 (LWP 1921) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  34   Thread 0x7fc63df0a700 (LWP 1922) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  33   Thread 0x7fc63d709700 (LWP 1924) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  32   Thread 0x7fc63cf08700 (LWP 1925) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  31   Thread 0x7fc63c707700 (LWP 1926) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  30   Thread 0x7fc63bf06700 (LWP 1930) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  29   Thread 0x7fc63b705700 (LWP 1934) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  28   Thread 0x7fc63af04700 (LWP 1935) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  27   Thread 0x7fc63a703700 (LWP 1936) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  26   Thread 0x7fc639f02700 (LWP 1937) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  25   Thread 0x7fc639701700 (LWP 1938) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  24   Thread 0x7fc638f00700 (LWP 1939) "mysqld" pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
	  23   Thread 0x7fc6386ff700 (LWP 1940) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  22   Thread 0x7fc637efe700 (LWP 1941) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  21   Thread 0x7fc6376fd700 (LWP 1942) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  20   Thread 0x7fc64e4ee700 (LWP 1953) "mysqld" pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
	  19   Thread 0x7fc64dced700 (LWP 1956) "mysqld" pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
	  18   Thread 0x7fc64d4ec700 (LWP 1957) "mysqld" pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
	  17   Thread 0x7fc64cceb700 (LWP 1959) "mysqld" 0x00007fc88539de5d in nanosleep () at ../sysdeps/unix/syscall-template.S:81
	  16   Thread 0x7fc64c4ea700 (LWP 1960) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  15   Thread 0x7fc64bce9700 (LWP 1961) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  14   Thread 0x7fc64b4e8700 (LWP 1962) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  13   Thread 0x7fc64ace7700 (LWP 1963) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  12   Thread 0x7fc64a4e6700 (LWP 1964) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  11   Thread 0x7fc649ce5700 (LWP 1965) "mysqld" pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
	  10   Thread 0x7fc6494e4700 (LWP 1966) "mysqld" pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
	  9    Thread 0x7fc648ce3700 (LWP 1968) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  8    Thread 0x7fc8780fd700 (LWP 1972) "mysqld" 0x00007fc88539e381 in do_sigwait (sig=0x7fc8780fcebc, set=<optimized out>) at ../sysdeps/unix/sysv/linux/sigwait.c:60
	  7    Thread 0x7fc647e20700 (LWP 1973) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  6    Thread 0x7fc64761f700 (LWP 1990) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  5    Thread 0x7fc64759d700 (LWP 2205) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	* 4    Thread 0x7fc64751b700 (LWP 2206) "mysqld" binlog_cache_data::flush (this=0x7fc624014090, thd=0x7fc624000d20, bytes_written=0x7fc647518120, wrote_xid=0x7fc647518157)
		at /usr/local/mysql-5.7.26/sql/binlog.cc:1674
	  3    Thread 0x7fc647499700 (LWP 2207) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  2    Thread 0x7fc647417700 (LWP 2905) "mysqld" pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	  1    Thread 0x7fc8857b0740 (LWP 1882) "mysqld" 0x00007fc884251bed in poll () at ../sysdeps/unix/syscall-template.S:81

5. 指定某个线程
	(gdb) thread 5
	[Switching to thread 5 (Thread 0x7fc64759d700 (LWP 2205))]
	#0  pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	185	62:	movl	(%rsp), %edi

	(gdb) where
	#0  pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
	#1  0x000000000186ee26 in native_cond_wait (cond=0x2d2d240 <Per_thread_connection_handler::COND_thread_cache>, mutex=0x2d2d1e8 <Per_thread_connection_handler::LOCK_thread_cache+40>)
		at /usr/local/mysql-5.7.26/include/thr_cond.h:140
	#2  0x000000000186ef8c in safe_cond_wait (cond=0x2d2d240 <Per_thread_connection_handler::COND_thread_cache>, mp=0x2d2d1c0 <Per_thread_connection_handler::LOCK_thread_cache>, 
		file=0x2112e18 "/usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc", line=145) at /usr/local/mysql-5.7.26/mysys/thr_cond.c:48
	#3  0x000000000165f3fc in my_cond_wait (cond=0x2d2d240 <Per_thread_connection_handler::COND_thread_cache>, mp=0x2d2d1c0 <Per_thread_connection_handler::LOCK_thread_cache>, 
		file=0x2112e18 "/usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc", line=145) at /usr/local/mysql-5.7.26/include/thr_cond.h:193
	#4  0x000000000165f6c7 in inline_mysql_cond_wait (that=0x2d2d240 <Per_thread_connection_handler::COND_thread_cache>, mutex=0x2d2d1c0 <Per_thread_connection_handler::LOCK_thread_cache>, 
		src_file=0x2112e18 "/usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc", src_line=145) at /usr/local/mysql-5.7.26/include/mysql/psi/mysql_thread.h:1184
	#5  0x000000000165fb14 in Per_thread_connection_handler::block_until_new_connection () at /usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:145
	#6  0x00000000016600be in handle_connection (arg=0x1df094f0) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:337
	#7  0x0000000001ce8640 in pfs_spawn_thread (arg=0x1e1a1220) at /usr/local/mysql-5.7.26/storage/perfschema/pfs.cc:2190
	#8  0x00007fc885396e65 in start_thread (arg=0x7fc64759d700) at pthread_create.c:307
	#9  0x00007fc88425c88d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111

6. 长时间不提交的影响： 脏页的刷新拉长了
	2020-03-10T18:42:52.572251Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 11443290ms. The settings might not be optimal. (flushed=0 and evicted=0, during the time.)


7. gdb 退出
	(gdb) quit
	A debugging session is active.

		Inferior 1 [process 1882] will be detached.

	Quit anyway? (y or n) y
	Detaching from program: /data/mysql/bin/mysqld, process 1882

	MySQL 的错误日志：
		2020-03-10T18:42:52.572251Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 11443290ms. The settings might not be optimal. (flushed=0 and evicted=0, during the time.)
		2020-03-10T18:46:07.882415Z 18 [Note] Got an error writing communication packets
		18:46:07 UTC - mysqld got signal 11 ;
		This could be because you hit a bug. It is also possible that this binary
		or one of the libraries it was linked against is corrupt, improperly built,
		or misconfigured. This error can also be caused by malfunctioning hardware.
		Attempting to collect some information that could help diagnose the problem.
		As this is a crash and something is definitely wrong, the information
		collection process might fail.

		key_buffer_size=33554432
		read_buffer_size=8388608
		max_used_connections=5
		max_threads=512
		thread_count=1
		connection_count=1
		It is possible that mysqld could use up to 
		key_buffer_size + (read_buffer_size + sort_buffer_size)*max_threads = 6331296 K  bytes of memory
		Hope thats ok; if not, decrease some variables in the equation.

		Thread pointer: 0x7fc624000d20
		Attempting backtrace. You can use the following information to find out
		where mysqld died. If you see no messages after this, something went
		terribly wrong...
		stack_bottom = 7fc64751ae40 thread_stack 0x80000
		/data/mysql/bin/mysqld(my_print_stacktrace+0x35)[0x186e306]
		/data/mysql/bin/mysqld(handle_fatal_signal+0x3f6)[0xeb1eb9]
		/lib64/libpthread.so.0(+0xf5f0)[0x7fc88539e5f0]
		/data/mysql/bin/mysqld(_db_enter_+0x66)[0x1dc69d1]
		/data/mysql/bin/mysqld(_ZN17binlog_cache_data5flushEP3THDPyPb+0x37)[0x17cdb07]
		/data/mysql/bin/mysqld(_ZN17binlog_cache_mngr5flushEP3THDPyPb+0x6f)[0x17e8c35]
		/data/mysql/bin/mysqld(_ZN13MYSQL_BIN_LOG19flush_thread_cachesEP3THD+0x45)[0x17de955]
		/data/mysql/bin/mysqld(_ZN13MYSQL_BIN_LOG25process_flush_stage_queueEPyPbPP3THD+0x13a)[0x17deb72]
		/data/mysql/bin/mysqld(_ZN13MYSQL_BIN_LOG14ordered_commitEP3THDbb+0x4c2)[0x17e00e8]
		/data/mysql/bin/mysqld(_ZN13MYSQL_BIN_LOG6commitEP3THDb+0xd92)[0x17de7ca]
		/data/mysql/bin/mysqld(_Z15ha_commit_transP3THDbb+0x611)[0xf282dd]
		/data/mysql/bin/mysqld(_Z12trans_commitP3THD+0xc5)[0x1632fab]
		/data/mysql/bin/mysqld(_Z21mysql_execute_commandP3THDb+0x4cfd)[0x15379e1]
		/data/mysql/bin/mysqld(_Z11mysql_parseP3THDP12Parser_state+0x5fc)[0x153af3e]
		/data/mysql/bin/mysqld(_Z16dispatch_commandP3THDPK8COM_DATA19enum_server_command+0xca9)[0x153084f]
		/data/mysql/bin/mysqld(_Z10do_commandP3THD+0x4b2)[0x152f6b8]
		/data/mysql/bin/mysqld(handle_connection+0x1e0)[0x165fff6]
		/data/mysql/bin/mysqld(pfs_spawn_thread+0x170)[0x1ce8640]
		/lib64/libpthread.so.0(+0x7e65)[0x7fc885396e65]
		/lib64/libc.so.6(clone+0x6d)[0x7fc88425c88d]

		Trying to get some variables.
		Some pointers may be invalid and cause the dump to abort.
		Query (7fc6240057e0): is an invalid pointer
		Connection ID (thread ID): 16
		Status: NOT_KILLED
		
		The manual page at http://dev.mysql.com/doc/mysql/en/crashing.html contains
		information that should help you find out what is causing the crash.


		分析：
			This could be because you hit a bug. It is also possible that this binary
			or one of the libraries it was linked against is corrupt, improperly built,
			or misconfigured.    日志损坏

			This error can also be caused by malfunctioning hardware.   # 此错误也可能是由硬件故障引起。
		
		尝试解决
		[root@env ~]# /etc/init.d/mysqld restart
		 ERROR! MySQL server process #1882 is not running!
		Starting MySQL......... SUCCESS!
		
		查看错误日志：
			2020-03-10T18:52:15.741705Z 0 [Note] --secure-file-priv is set to NULL. Operations related to importing and exporting data are disabled
			2020-03-10T18:52:15.741859Z 0 [Note] /data/mysql/bin/mysqld (mysqld 5.7.26-debug-log) starting as process 7475 ...
			2020-03-10T18:52:15.773625Z 0 [Note] InnoDB: PUNCH HOLE support available
			2020-03-10T18:52:15.773684Z 0 [Note] InnoDB: !!!!!!!! UNIV_DEBUG switched on !!!!!!!!!
			2020-03-10T18:52:15.773692Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
			2020-03-10T18:52:15.773697Z 0 [Note] InnoDB: Uses event mutexes
			2020-03-10T18:52:15.773701Z 0 [Note] InnoDB: GCC builtin __atomic_thread_fence() is used for memory barrier
			2020-03-10T18:52:15.773706Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
			2020-03-10T18:52:15.774229Z 0 [Note] InnoDB: Number of pools: 1
			2020-03-10T18:52:15.774358Z 0 [Note] InnoDB: Using CPU crc32 instructions
			2020-03-10T18:52:15.776191Z 0 [Note] InnoDB: Initializing buffer pool, total size = 8G, instances = 4, chunk size = 128M
			2020-03-10T18:52:19.520903Z 0 [Note] InnoDB: Completed initialization of buffer pool
			2020-03-10T18:52:19.588528Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
			2020-03-10T18:52:19.693034Z 0 [Note] InnoDB: Opened 95 undo tablespaces
			2020-03-10T18:52:19.693068Z 0 [Note] InnoDB: 95 undo tablespaces made active
			2020-03-10T18:52:19.693737Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
			2020-03-10T18:52:19.776810Z 0 [Note] InnoDB: Log scan progressed past the checkpoint lsn 2647381
			2020-03-10T18:52:19.776856Z 0 [Note] InnoDB: Doing recovery: scanned up to log sequence number 2647572
			2020-03-10T18:52:19.833153Z 0 [Note] InnoDB: Database was not shutdown normally!
			
			2020-03-10T18:52:19.833197Z 0 [Note] InnoDB: Starting crash recovery.
			2020-03-10T18:52:21.359417Z 0 [Note] InnoDB: Transaction 1816 was in the XA prepared state.
			2020-03-10T18:52:21.476426Z 0 [Note] InnoDB: 1 transaction(s) which must be rolled back or cleaned up in total 0 row operations to undo
			2020-03-10T18:52:21.476465Z 0 [Note] InnoDB: Trx id counter is 2304
			2020-03-10T18:52:21.716501Z 0 [Note] InnoDB: Last MySQL binlog file position 0 1730, file name mysql-bin.000003
			2020-03-10T18:52:22.145154Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
			2020-03-10T18:52:22.145180Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
			2020-03-10T18:52:22.145276Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
			2020-03-10T18:52:22.145888Z 0 [Note] InnoDB: Starting in background the rollback of uncommitted transactions
			2020-03-10T18:52:22.145916Z 0 [Note] InnoDB: Rollback of non-prepared transactions completed
			2020-03-10T18:52:22.302654Z 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
			2020-03-10T18:52:22.310972Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
			2020-03-10T18:52:22.311061Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
			2020-03-10T18:52:22.381323Z 0 [Note] InnoDB: Waiting for purge to start
			2020-03-10T18:52:22.442611Z 0 [Note] InnoDB: 5.7.26 started; log sequence number 2647572
			2020-03-10T18:52:22.457871Z 0 [Note] InnoDB: Loading buffer pool(s) from /data/mysql/data/ib_buffer_pool
			2020-03-10T18:52:22.496404Z 0 [Note] Plugin 'FEDERATED' is disabled.
			2020-03-10T18:52:22.680586Z 0 [Note] Recovering after a crash using /data/mysql/logs/mysql-bin
			2020-03-10T18:52:22.680774Z 0 [Note] Starting crash recovery...
			2020-03-10T18:52:22.680836Z 0 [Note] InnoDB: Starting recovery for XA transactions...
			2020-03-10T18:52:22.680852Z 0 [Note] InnoDB: Transaction 1816 in prepared state after recovery
			2020-03-10T18:52:22.680859Z 0 [Note] InnoDB: Transaction contains changes to 1 rows
			2020-03-10T18:52:22.680865Z 0 [Note] InnoDB: 1 transactions in prepared state after recovery
			2020-03-10T18:52:22.680870Z 0 [Note] Found 1 prepared transaction(s) in InnoDB
			2020-03-10T18:52:22.680880Z 0 [Note] rollback xid 'MySQLXidi\13\5\0\0\0\0\0I\0\0\0\0\0\0\0'
			# 事务处于 prepare，binlog 不完整， 会回滚。  灾里验证了这个逻辑。
			2020-03-10T18:52:22.922647Z 0 [Note] Crash recovery finished.
			2020-03-10T18:52:23.069053Z 0 [Note] Read 2 events from binary log file '/data/mysql/logs/mysql-bin.000001' to determine the GTIDs purged from binary logs.
			2020-03-10T18:52:23.086365Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
			2020-03-10T18:52:23.086483Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
			2020-03-10T18:52:23.086535Z 0 [Note] IPv6 is available.
			2020-03-10T18:52:23.086548Z 0 [Note]   - '::' resolves to '::';
			2020-03-10T18:52:23.086570Z 0 [Note] Server socket created on IP: '::'.
			2020-03-10T18:52:23.264677Z 0 [Note] InnoDB: Buffer pool(s) load completed at 200311  2:52:23
			2020-03-10T18:52:23.610709Z 0 [Note] Failed to start slave threads for channel ''
			2020-03-10T18:52:23.683568Z 0 [Note] Event Scheduler: Loaded 0 events
			2020-03-10T18:52:23.684279Z 0 [Note] /data/mysql/bin/mysqld: ready for connections.
			Version: '5.7.26-debug-log'  socket: '/data/mysql/3306.sock'  port: 3306  Source distribution
		
		进行DML操作：
			root@mysqldb 02:53:  [lujb_db]> select * from t;
			+----+------+---------------------+
			| id | a    | t_modified          |
			+----+------+---------------------+
			|  1 |    1 | 2018-11-13 00:00:00 |
			|  2 |    1 | 2018-11-13 00:00:00 |
			+----+------+---------------------+
			2 rows in set (0.01 sec)

			root@mysqldb 02:53:  [lujb_db]> delete from t where id=1;
			Query OK, 1 row affected (0.11 sec)

			root@mysqldb 02:53:  [lujb_db]> update t set a=3  where id=2;
			Query OK, 1 row affected (0.03 sec)
			Rows matched: 1  Changed: 1  Warnings: 0

			root@mysqldb 02:54:  [lujb_db]> insert into t values(5,1,'2018-11-13');\
			Query OK, 1 row affected (0.02 sec)

			root@mysqldb 02:56:  [lujb_db]> select * from t;
			+----+------+---------------------+
			| id | a    | t_modified          |
			+----+------+---------------------+
			|  2 |    3 | 2018-11-13 00:00:00 |
			|  5 |    1 | 2018-11-13 00:00:00 |
			+----+------+---------------------+
			2 rows in set (0.00 sec)
		

8. 小结
	gdb 命令不建议在生产环境上用。

