
1. mysql_upgrade 升级方式
2. mysql_upgrade 实践
3. MySQL 8.0.16 的新的升级方式
4. 新的升级方式的优势
5. 相关参考
6. 注意事项 


1. mysql_upgrade 升级方式
	1. 关闭MySQL
	2.  unlink mysql 或者 mv mysql mysql-old-version
	3. mv mysql-new-version mysql
	4. /usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf --skip-networking --skip-grant-tables &
		这两个参数表示： 升级版本期间不对外服务 同时不启用密码验证。
	5. /usr/local/mysql/bin/mysql_upgrade -S /mydata/mysql/data/mysql.sock
	Upgrade process completed successfully.
	Checking if update is needed.
	6. /usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf &

2. mysql_upgrade 实践
	1. 关闭MySQL
	2. cd /usr/local/
		上传二进制包到 /usr/local/目录下
		yum install xz
		tar xvJf mysql-8.0.18-linux-glibc2.12-x86_64.tar.xz 	 # 解压 二进制文件
		mv mysql mysql-old-version 
		mv mysql-8.0.18-linux-glibc2.12-x86_64 mysql
		chown -R mysql:mysql mysql/
		
		
	3. /usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf --skip-networking --skip-grant-tables &
		[1] 3562
		shell> ps aux|grep mysql
		mysql     3562 28.9 20.6 3522008 800432 pts/1  Sl   07:30   0:03 /usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf --skip-networking --skip-grant-tables
		root      3614  0.0  0.0 112704   972 pts/1    R+   07:30   0:00 grep --color=auto mysql

	 
	4. /usr/local/mysql/bin/mysql_upgrade -S /tmp/mysql.sock
		The mysql_upgrade client is now deprecated. The actions executed by the upgrade client are now done by the server.
			# 现在不推荐使用mysql_upgrade客户机。升级客户机执行的操作现在由服务器执行。
		To upgrade, please start the new MySQL binary with the older data directory. Repairing user tables is done automatically. Restart is not required after upgrade.
			# 要升级，请使用旧的数据目录启动新的MySQL二进制文件。修复用户表是自动完成的。升级后不需要重新启动。
		The upgrade process automatically starts on running a new MySQL binary with an older data directory. To avoid accidental upgrades, please use the --upgrade=NONE option with the MySQL binary. The option --upgrade=FORCE is also provided to run the server upgrade sequence on demand.
			# 升级过程在运行一个新的MySQL二进制文件和一个旧的数据目录时自动开始。为了避免意外升级，请对MySQL二进制文件使用—upgrade=NONE选项。还提供了选项——upgrade=FORCE来根据需要运行服务器升级序列。
		It may be possible that the server upgrade fails due to a number of reasons. In that case, the upgrade sequence will run again during the next MySQL server start. If the server upgrade fails repeatedly, the server can be started with the --upgrade=MINIMAL option to start the server without executing the upgrade sequence, thus allowing users to manually rectify the problem.
			# 服务器升级失败的原因可能有很多。在这种情况下，升级序列将在下一次MySQL服务器启动时再次运行。如果服务器升级多次失败，可以使用——upgrade= minimum选项启动服务器，而不执行升级顺序，从而允许用户手动纠正问题。


3. MySQL 8.0.16 的新的升级方式
	1. 关闭 MySQL，替换新的二进制 MySQL
	2. 启动 MySQL，升级 DD（数据字典）表和系统表、用户表和帮助表
	3. shell> /usr/local/mysql/bin/mysqld --upgrade=AUTO
	shell> /usr/local/mysql/bin/mysqld --upgrade=
	2019-10-15T23:39:42.352689Z 0 [ERROR] [MY-000071] [Server] /usr/local/mysql/bin/mysqld: option '--upgrade' requires an argument.
	2019-10-15T23:39:42.352753Z 0 [ERROR] [MY-010119] [Server] Aborting
	2019-10-15T23:39:42.352790Z 0 [Note] [MY-010120] [Server] Binlog end

		
4. 新的升级方式的优势
	升级的时间和操作都会大幅度缩短，操作步骤也减少了很多，更方便了用户。
	
5. 相关参考
	https://mp.weixin.qq.com/s/u_YGopxq5UJZbppzvLYJJA   MySQL 8.0.16 告别 mysql_upgrade 升级方式 
	
6. 注意事项 
	internal_tmp_disk_storage_engine=InnoDB   # 把这个参数注释掉, 8.0.18 不再支持这个参数
	2019-10-15T23:30:50.348039Z 0 [ERROR] [MY-000067] [Server] unknown variable 'internal_tmp_disk_storage_engine=InnoDB'.


	innodb_undo_directory = undolog
	innodb_undo_tablespaces = 95
	[root@mgr02 local]# /etc/init.d/mysql start
	2019-10-15T23:40:15.532294Z 0 [System] [MY-010116] [Server] /usr/local/mysql/bin/mysqld (mysqld 8.0.18) starting as process 6932
	2019-10-15T23:40:15.539534Z 0 [Warning] [MY-013267] [InnoDB] The setting INNODB_UNDO_TABLESPACES is deprecated and is no longer used.  
		InnoDB always creates 2 undo tablespaces to start with. If you need more, please use CREATE UNDO TABLESPACE.
		# 不赞成设置 INNODB_UNDO_TABLESPACES ，并且不再使用它。
		# InnoDB总是先创建两个undo表空间。如果需要更多，请使用创建UNDO表空间。
		相关参考: https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html
		
	2019-10-15T23:40:24.587766Z 0 [ERROR] [MY-011685] [Repl] Plugin group_replication reported: 'The group name option is mandatory'
	2019-10-15T23:40:24.588125Z 0 [ERROR] [MY-011660] [Repl] Plugin group_replication reported: 'Unable to start Group Replication on boot'
	2019-10-15T23:40:24.865471Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
	2019-10-15T23:40:24.906690Z 0 [Warning] [MY-010604] [Repl] Neither --relay-log nor --relay-log-index were used; so replication may break when this MySQL server acts as a slave and has his hostname changed!! Please use '--relay-log=mgr02-relay-bin' to avoid this problem.
	2019-10-15T23:40:24.919093Z 0 [Warning] [MY-010539] [Repl] Recovery from master pos 68 and file  for channel 'group_replication_applier'. Previous relay log pos and relay log file had been set to 4, ./mgr02-relay-bin-group_replication_applier.000006 respectively.
	2019-10-15T23:40:24.971426Z 0 [Warning] [MY-010539] [Repl] Recovery from master pos 4 and file  for channel 'group_replication_recovery'. Previous relay log pos and relay log file had been set to 4, ./mgr02-relay-bin-group_replication_recovery.000004 respectively.
	2019-10-15T23:40:24.980628Z 0 [System] [MY-010931] [Server] /usr/local/mysql/bin/mysqld: ready for connections. Version: '8.0.18'  socket: '/tmp/mysql.sock'  port: 3306  MySQL Community Server - GPL.
	2019-10-15T23:40:25.127439Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: '/tmp/mysqlx.sock' bind-address: '::' port: 33060


	#innodb_undo_directory = undolog
	#innodb_undo_tablespaces = 95
	2019-10-15T23:42:32.980354Z 0 [System] [MY-010116] [Server] /usr/local/mysql/bin/mysqld (mysqld 8.0.18) starting as process 8593
	2019-10-15T23:42:34.115890Z 1 [ERROR] [MY-012930] [InnoDB] Plugin initialization aborted with error Invalid Filename.
	2019-10-15T23:42:34.615207Z 1 [ERROR] [MY-010334] [Server] Failed to initialize DD Storage Engine
	2019-10-15T23:42:34.615683Z 0 [ERROR] [MY-010020] [Server] Data Dictionary initialization failed.
	2019-10-15T23:42:34.615984Z 0 [ERROR] [MY-010119] [Server] Aborting
	2019-10-15T23:42:34.617019Z 0 [System] [MY-010910] [Server] /usr/local/mysql/bin/mysqld: Shutdown complete (mysqld 8.0.18)  MySQL Community Server - GPL.

	innodb_undo_directory = undolog
	#innodb_undo_tablespaces = 95
	2019-10-15T23:43:12.753109Z 0 [System] [MY-010116] [Server] /usr/local/mysql/bin/mysqld (mysqld 8.0.18) starting as process 10219
	2019-10-15T23:43:20.859128Z 0 [ERROR] [MY-011685] [Repl] Plugin group_replication reported: 'The group name option is mandatory'
	2019-10-15T23:43:20.859473Z 0 [ERROR] [MY-011660] [Repl] Plugin group_replication reported: 'Unable to start Group Replication on boot'
	2019-10-15T23:43:21.124514Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
	2019-10-15T23:43:21.179585Z 0 [Warning] [MY-010604] [Repl] Neither --relay-log nor --relay-log-index were used; so replication may break when this MySQL server acts as a slave and has his hostname changed!! Please use '--relay-log=mgr02-relay-bin' to avoid this problem.
	2019-10-15T23:43:21.192083Z 0 [Warning] [MY-010539] [Repl] Recovery from master pos 68 and file  for channel 'group_replication_applier'. Previous relay log pos and relay log file had been set to 4, ./mgr02-relay-bin-group_replication_applier.000007 respectively.
	2019-10-15T23:43:21.208897Z 0 [Warning] [MY-010539] [Repl] Recovery from master pos 4 and file  for channel 'group_replication_recovery'. Previous relay log pos and relay log file had been set to 4, ./mgr02-relay-bin-group_replication_recovery.000005 respectively.
	2019-10-15T23:43:21.221364Z 0 [System] [MY-010931] [Server] /usr/local/mysql/bin/mysqld: ready for connections. Version: '8.0.18'  socket: '/tmp/mysql.sock'  port: 3306  MySQL Community Server - GPL.
	2019-10-15T23:43:21.370544Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: '/tmp/mysqlx.sock' bind-address: '::' port: 33060



	mysql> UNINSTALL PLUGIN group_replication;
	Query OK, 0 rows affected (0.37 sec)

	shell> /etc/init.d/mysql restart
	2019-10-16T00:25:21.133872Z 0 [System] [MY-010910] [Server] /usr/local/mysql/bin/mysqld: Shutdown complete (mysqld 8.0.18)  MySQL Community Server - GPL.
	2019-10-16T00:25:22.694364Z 0 [System] [MY-010116] [Server] /usr/local/mysql/bin/mysqld (mysqld 8.0.18) starting as process 12113
	2019-10-16T00:25:56.194275Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
	2019-10-16T00:25:56.277918Z 0 [Warning] [MY-010604] [Repl] Neither --relay-log nor --relay-log-index were used; so replication may break when this MySQL server acts as a slave and has his hostname changed!! Please use '--relay-log=mgr02-relay-bin' to avoid this problem.
	2019-10-16T00:25:56.288562Z 0 [Warning] [MY-010539] [Repl] Recovery from master pos 68 and file  for channel 'group_replication_applier'. Previous relay log pos and relay log file had been set to 4, ./mgr02-relay-bin-group_replication_applier.000008 respectively.
	2019-10-16T00:25:56.310078Z 0 [Warning] [MY-010539] [Repl] Recovery from master pos 4 and file  for channel 'group_replication_recovery'. Previous relay log pos and relay log file had been set to 4, ./mgr02-relay-bin-group_replication_recovery.000006 respectively.
	2019-10-16T00:25:56.449951Z 0 [System] [MY-010931] [Server] /usr/local/mysql/bin/mysqld: ready for connections. Version: '8.0.18'  socket: '/tmp/mysql.sock'  port: 3306  MySQL Community Server - GPL.
	2019-10-16T00:25:56.661520Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: '/tmp/mysqlx.sock' bind-address: '::' port: 33060


升级 案例
	[root@kp05 ~]# cd /usr/local/
	[root@kp05 local]# ll
	total 2099988
	drwxr-xr-x.  2 root    root          180 Nov  1 12:14 bin
	drwxr-xr-x.  4 root    root           41 Nov  1 12:14 etc
	drwxr-xr-x.  2 root    root            6 Nov  5  2016 games
	drwxr-xr-x.  2 root    root         4096 Nov 16  2018 include
	drwxr-xr-x. 12 root    root          274 Nov 16  2018 lib
	drwxr-xr-x.  2 root    root            6 Nov  5  2016 lib64
	drwxr-xr-x.  2 root    root            6 Nov  5  2016 libexec
	drwxr-xr-x.  5 root    root           42 Nov 16  2018 man
	drwxr-xr-x.  3 mongodb mongodb        91 Oct 11  2018 mongodb
	drwxr-xr-x. 11 mysql   mysql         194 Oct 14  2019 mysql
	-rw-r--r--.  1 root    root    644930593 Oct  4  2018 mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz
	-rw-r--r--.  1 root    root    644930593 Nov 20  2018 mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz-back
	-rw-r--r--.  1 root    root    354913940 Aug 15  2018 mysql-8.0.12-linux-glibc2.12-x86_64.tar.xz
	-rw-r--r--.  1 root    root    503854832 Oct 15  2019 mysql-8.0.18-linux-glibc2.12-x86_64.tar.xz
	drwxr-xr-x.  6 root    root           56 Dec  4  2018 python3
	drwxrwxr-x.  6 root    root         4096 Mar 27  2018 redis-4.0.9
	-rw-r--r--.  1 root    root      1737022 Nov 27  2018 redis-4.0.9.tar.gz
	drwxr-xr-x.  2 root    root           24 Nov  1 12:14 sbin
	drwxr-xr-x.  7 root    root           72 Nov  1 12:14 share
	drwxr-xr-x.  2 root    root            6 Nov  5  2016 src
	drwxr-xr-x. 13   15399   19249      4096 Sep 20  2013 tcl8.6.1
	[root@kp05 local]# /etc/init.d/mysql stop
	Shutting down MySQL.. SUCCESS! 
	[root@kp05 local]# mv mysql mysql-8.0.18

	[root@kp05 local]# ll
	total 2573696
	drwxr-xr-x.  2 root    root          180 Nov  1 12:14 bin
	drwxr-xr-x.  4 root    root           41 Nov  1 12:14 etc
	drwxr-xr-x.  2 root    root            6 Nov  5  2016 games
	drwxr-xr-x.  2 root    root         4096 Nov 16  2018 include
	drwxr-xr-x. 12 root    root          274 Nov 16  2018 lib
	drwxr-xr-x.  2 root    root            6 Nov  5  2016 lib64
	drwxr-xr-x.  2 root    root            6 Nov  5  2016 libexec
	drwxr-xr-x.  5 root    root           42 Nov 16  2018 man
	drwxr-xr-x.  3 mongodb mongodb        91 Oct 11  2018 mongodb
	-rw-r--r--.  1 root    root    644930593 Oct  4  2018 mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz
	-rw-r--r--.  1 root    root    644930593 Nov 20  2018 mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz-back
	-rw-r--r--.  1 root    root    354913940 Aug 15  2018 mysql-8.0.12-linux-glibc2.12-x86_64.tar.xz
	drwxr-xr-x. 11 mysql   mysql         194 Oct 14  2019 mysql-8.0.18
	-rw-r--r--.  1 root    root    503854832 Oct 15  2019 mysql-8.0.18-linux-glibc2.12-x86_64.tar.xz
	-rw-r--r--.  1 root    root    485074552 Apr 24  2020 mysql-8.0.19-linux-glibc2.12-x86_64.tar.xz
	drwxr-xr-x.  6 root    root           56 Dec  4  2018 python3
	drwxrwxr-x.  6 root    root         4096 Mar 27  2018 redis-4.0.9
	-rw-r--r--.  1 root    root      1737022 Nov 27  2018 redis-4.0.9.tar.gz
	drwxr-xr-x.  2 root    root           24 Nov  1 12:14 sbin
	drwxr-xr-x.  7 root    root           72 Nov  1 12:14 share
	drwxr-xr-x.  2 root    root            6 Nov  5  2016 src
	drwxr-xr-x. 13   15399   19249      4096 Sep 20  2013 tcl8.6.1

	
	[root@kp05 local]# xz -d mysql-8.0.19-linux-glibc2.12-x86_64.tar.xz 

		-rw-r--r--.  1 root    root    2651712000 Apr 24  2020 mysql-8.0.19-linux-glibc2.12-x86_64.tar
		
	[root@kp05 local]# tar -xvf mysql-8.0.19-linux-glibc2.12-x86_64.tar
	
	[root@kp05 local]# mv mysql-8.0.19-linux-glibc2.12-x86_64 mysql
 
	[root@kp05 local]# chown -R  mysql:mysql mysql

	
	cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql

	/etc/init.d/mysql start 
	
	[root@kp05 local]# mysql -uroot -p123456abc
	mysql: [Warning] Using a password on the command line interface can be insecure.
	Welcome to the MySQL monitor.  Commands end with ; or \g.
	Your MySQL connection id is 12
	Server version: 8.0.19 MySQL Community Server - GPL

	Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

	Oracle is a registered trademark of Oracle Corporation and/or its
	affiliates. Other names may be trademarks of their respective
	owners.

	Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

	root@mysqldb 17:55:  [(none)]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)
	
	/usr/local/mysql/bin/mysqld --upgrade=