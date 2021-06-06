
1. 下载 mysql-boost-5.7.26.tar.gz
2.  cmake 命令安装
3. 解压 mysql-boost-5.7.26.tar.gz
4. 创建 数据目录、binlog目录、tmp 目录
5. 编译MySQL，但这里的编译是通过CMake而非configure进行的，指定boost的源码路径。
6. make&&make install
7. 初始化数据库
8. 准备gdb命令文件
9. 使用gdb启动MySQL
10. 相关参考


1. 下载 mysql-boost-5.7.26.tar.gz
	https://downloads.mysql.com/archives/community/
	下面是我的选项：
		Product Version:   5.7.26
		Operating System:  Source Code
		OS Version:        Generic Linux (Architecture Independent)

2.  cmake 命令安装
	[root@env etc]# cmake
	bash: cmake: command not found...
	Similar command is: 'make'

	[root@env etc]# yum install -y cmake



	
3. 解压 mysql-boost-5.7.26.tar.gz
 
	[root@env local]# tar -xzvf mysql-boost-5.7.26.tar.gz
	[root@env local]# pwd
	/usr/local
	[root@env local]# ll
	total 49908
	drwxr-xr-x.  2 root root        60 Jul 27  2019 bin
	drwxr-xr-x.  2 root root         6 Nov  5  2016 etc
	drwxr-xr-x.  2 root root         6 Nov  5  2016 games
	drwxr-xr-x.  2 root root         6 Nov  5  2016 include
	drwxr-xr-x.  2 root root         6 Nov  5  2016 lib
	drwxr-xr-x.  2 root root         6 Nov  5  2016 lib64
	drwxr-xr-x.  2 root root         6 Nov  5  2016 libexec
	drwxr-xr-x  36 7161 31415     4096 Apr 13  2019 mysql-5.7.26
	-rw-r--r--   1 root root  51098338 Mar 10 14:59 mysql-boost-5.7.26.tar.gz
	drwxr-xr-x.  2 root root         6 Nov  5  2016 sbin
	drwxr-xr-x.  7 root root        72 Jul 27  2019 share
	drwxr-xr-x.  2 root root         6 Nov  5  2016 src

4. 创建 数据目录、binlog目录、tmp 目录

	groupadd mysql
	useradd -g mysql -d /usr/local/mysql -s /sbin/nologin -M mysql
	id mysql

	mkdir /home/mysql/{data,logs,tmp} -p


	chown -R mysql:mysql /home/mysql/



5. 编译MySQL，但这里的编译是通过CMake而非configure进行的，指定boost的源码路径。

	参数说明：

		-DCMAKE_INSTALL_PREFIX=安装路径

		-DMYSQL_DATADIR=默认数据路径

		-DSYSCONFDIR=配置文件路径

		-DMYSQL_TCP_PORT=默认端口

		-DMYSQL_UNIX_ADDR=socket路径

		-DWITH_BOOST=boost源码路径

	cmake -DCMAKE_INSTALL_PREFIX=/home/mysql/ \
	-DMYSQL_DATADIR=/home/mysql/data/ \
	-DSYSCONFDIR=/usr/local/mysql/ \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
	-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
	-DWITH_FEDERATED_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1  \
	-DMYSQL_UNIX_ADDR=/home/mysql/3306.sock \
	-DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 \
	-DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8  \
	-DDEFAULT_COLLATION=utf8_general_ci  -DMYSQL_USER=mysql  \
	-DWITH_BINLOG_PREALLOC=ON   \
	-DWITH_BOOST=/usr/local/mysql/boost/boost_1_59_0 \
	-DWITH_DEBUG=1

	遇到的错误：

		原因： 执行目录不对
			CMake Error: The source directory "/etc" does not appear to contain CMakeLists.txt.
			Specify --help for usage, or press the help button on the CMake GUI.
	
		正确目录：
			[root@localhost mysql]# pwd
			/usr/local/mysql

		
		原因：
			-- Generating done
			CMake Warning:
			  Manually-specified variables were not used by the project:

				MYSQL_USER
				WITH_BINLOG_PREALLOC


			-- Build files have been written to: /usr/local/mysql
			
			这个 warning 可以忽略	



		原因： 要安装依赖 ncurses-devel
			-- Could NOT find Curses (missing:  CURSES_LIBRARY CURSES_INCLUDE_PATH) 
			CMake Error at cmake/readline.cmake:64 (MESSAGE):
			  Curses library not found.  Please install appropriate package,

				  remove CMakeCache.txt and rerun cmake.On Debian/Ubuntu, package name is libncurses5-dev, on Redhat and derivates it is ncurses-devel.
			Call Stack (most recent call first):
			  cmake/readline.cmake:107 (FIND_CURSES)
			  cmake/readline.cmake:197 (MYSQL_USE_BUNDLED_EDITLINE)
			  CMakeLists.txt:542 (MYSQL_CHECK_EDITLINE)


			-- Configuring incomplete, errors occurred!
			See also "/usr/local/mysql/CMakeFiles/CMakeOutput.log".
			See also "/usr/local/mysql/CMakeFiles/CMakeError.log".

		
			执行命令： yum install ncurses-devel -y

		

		-- BOOST_INCLUDE_DIR /usr/local/mysql/boost/boost_1_59_0
		-- NUMA library missing or required version not available
		-- Could NOT find Curses (missing:  CURSES_LIBRARY CURSES_INCLUDE_PATH) 
		CMake Error at cmake/readline.cmake:64 (MESSAGE):
		  Curses library not found.  Please install appropriate package,

			  remove CMakeCache.txt and rerun cmake.On Debian/Ubuntu, package name is libncurses5-dev, on Redhat and derivates it is ncurses-devel.
		Call Stack (most recent call first):
		  cmake/readline.cmake:107 (FIND_CURSES)
		  cmake/readline.cmake:197 (MYSQL_USE_BUNDLED_EDITLINE)
		  CMakeLists.txt:542 (MYSQL_CHECK_EDITLINE)


		-- Configuring incomplete, errors occurred!
		See also "/usr/local/mysql/CMakeFiles/CMakeOutput.log".
		See also "/usr/local/mysql/CMakeFiles/CMakeError.log".


		[root@localhost mysql]# rm CMakeCache.txt 
		rm：是否删除普通文件 "CMakeCache.txt"？Y



		
6. make&&make install

   编译和安装。
	-- Installing: /data/mysql/mysql-test/./t/wl6301_1_not_windows-master.opt
	-- Installing: /data/mysql/mysql-test/./t/wl6301_1_not_windows.test
	-- Installing: /data/mysql/mysql-test/./t/wl6301_2_not_windows-master.opt
	-- Installing: /data/mysql/mysql-test/./t/wl6301_2_not_windows.test
	-- Installing: /data/mysql/mysql-test/./t/wl6301_3-master.opt
	-- Installing: /data/mysql/mysql-test/./t/wl6301_3.test
	-- Installing: /data/mysql/mysql-test/./t/wl6443_deprecation-master.opt
	-- Installing: /data/mysql/mysql-test/./t/wl6443_deprecation.test
	-- Installing: /data/mysql/mysql-test/./t/wl6661-master.opt
	-- Installing: /data/mysql/mysql-test/./t/wl6661.test
	-- Installing: /data/mysql/mysql-test/./t/wl6711_heap_to_disk.test
	-- Installing: /data/mysql/mysql-test/./t/wl6978.test
	-- Installing: /data/mysql/mysql-test/./t/xa.test
	-- Installing: /data/mysql/mysql-test/./t/xa_debug.test
	-- Installing: /data/mysql/mysql-test/./t/xa_gtid-master.opt
	-- Installing: /data/mysql/mysql-test/./t/xa_gtid.test
	-- Installing: /data/mysql/mysql-test/./t/xa_prepared_binlog_off-master.opt
	-- Installing: /data/mysql/mysql-test/./t/xa_prepared_binlog_off.test
	-- Installing: /data/mysql/mysql-test/./t/xml.test
	-- Installing: /data/mysql/mysql-test/./valgrind.supp
	-- Installing: /data/mysql/mysql-test/./mtr
	-- Installing: /data/mysql/mysql-test/./mysql-test-run
	-- Installing: /data/mysql/mysql-test/./Makefile
	-- Installing: /data/mysql/mysql-test/./cmake_install.cmake
	-- Installing: /data/mysql/mysql-test/./CTestTestfile.cmake
	-- Installing: /data/mysql/./COPYING-test
	-- Installing: /data/mysql/./README-test
	-- Up-to-date: /data/mysql/mysql-test/mtr
	-- Up-to-date: /data/mysql/mysql-test/mysql-test-run
	-- Installing: /data/mysql/mysql-test/lib/My/SafeProcess/my_safe_process
	-- Up-to-date: /data/mysql/mysql-test/lib/My/SafeProcess/my_safe_process
	-- Installing: /data/mysql/mysql-test/lib/My/SafeProcess/Base.pm
	-- Installing: /data/mysql/support-files/mysqld_multi.server
	-- Installing: /data/mysql/support-files/mysql-log-rotate
	-- Installing: /data/mysql/support-files/magic
	-- Installing: /data/mysql/share/aclocal/mysql.m4
	-- Installing: /data/mysql/support-files/mysql.server

	
	编译成功，耗时约60分钟。
	

7. 初始化数据库
	
	修改权限	
		chown -R mysql:mysql /home/mysql/
		
	初始化
		/home/mysql/bin/mysqld --defaults-file=/etc/my.cnf --initialize
	
	

	启动
		cp /home/mysql/support-files/mysql.server /etc/init.d/mysql
		/etc/init.d/mysql start

		OR 

		/home/mysql/bin/mysqld --defaults-file=/etc/my.cnf &   # 生成.sock文件)
	
	环境变量
		echo $PATH
		echo "export PATH=$PATH:/home/mysql/bin">>/etc/profile
		source /etc/profile  //让配置生效


	连接和修改密码
		/home/mysql/bin/mysql -uroot -p

		alter user user() identified by '123456abc';


8. 准备gdb命令文件
	如下是我准备的命令文件：
	[root@gp1 ~]# more debug.file
	break main
	run --defaults-file=/etc/my.cnf --user=mysql --gdb
	
	第一行是在main函数处打一个断点。
	第二行就是gdb调用MySQLD的时候，MySQLD加什么参数了，注意run不要写掉了
	
	
9. 使用gdb启动MySQL
	使用如下命令启动调试环境：
			
		gdb -x /root/debug.file /home/mysql/bin/mysqld
			
			
	下面就是我启动调试环境成功的记录：
	
		[root@localhost ~]# gdb -x /root/debug.file /home/mysql/bin/mysqld
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

		Breakpoint 1, main (argc=4, argv=0x7fffffffe538) at /usr/local/mysql/sql/main.cc:25
		25	  return mysqld_main(argc, argv);
		Missing separate debuginfos, use: debuginfo-install glibc-2.17-324.el7_9.x86_64 libgcc-4.8.5-44.el7.x86_64 libstdc++-4.8.5-44.el7.x86_64 nss-softokn-freebl-3.53.1-6.el7_9.x86_64
		(gdb) 
		
		
	
10. 相关参考

	https://mp.weixin.qq.com/s/Ov-mw-crQ6-UdBCobOUZ-A  线程简介和MySQL调试环境搭建
	https://mp.weixin.qq.com/s/Lrx-YYYWtHHaxLfY_UZ8GQ  玩转MySQL 8.0源码编译
	https://blog.51cto.com/hzde0128/2299593     mysql-5.7.23源码编译安装
	https://mp.weixin.qq.com/s/9mmOzsSAzA4HaUJStfjmCQ  MySQL 5.7.19编译安装及简单配置方法
	https://segmentfault.com/a/1190000018176119?utm_source=tag-newest  GDB 调试 Mysql 实战（二）GDB 调试打印
	