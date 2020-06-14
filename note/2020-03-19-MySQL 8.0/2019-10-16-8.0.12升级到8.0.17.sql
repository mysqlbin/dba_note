

3. MySQL 8.0.16 的新的升级方式
4. 新的升级方式的优势
5. 相关参考
6. 注意事项 



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
	

	
升级 案例
cd /usr/local/
[root@env local]# ll
total 4544060
drwxr-xr-x.  2 root  root          22 Feb  2  2018 bin
drwxr-xr-x.  2 root  root           6 Nov  5  2016 etc
drwxr-xr-x.  2 root  root           6 Nov  5  2016 games
drwxr-xr-x.  2 root  root           6 Nov  5  2016 include
drwxr-xr-x.  2 root  root           6 Nov  5  2016 lib
drwxr-xr-x.  2 root  root           6 Nov  5  2016 lib64
drwxr-xr-x.  2 root  root           6 Nov  5  2016 libexec
drwxr-xr-x   9 mysql mysql        129 May 23 13:25 mysql
-rw-r--r--   1 root  root  1867110400 May 23 12:07 mysql-8.0.12-linux-glibc2.12-x86_64.tar
drwxr-xr-x  11 root  root         194 May 24 02:59 mysql-8.0.17-linux-glibc2.12-x86_64
-rw-r--r--   1  7155 31415 2601118720 Jun 27  2019 mysql-8.0.17-linux-glibc2.12-x86_64.tar
-rw-r--r--   1  7155 31415   34514636 Jun 27  2019 mysql-router-8.0.17-linux-glibc2.12-x86_64.tar.xz
-rw-r--r--   1  7155 31415  150488620 Jun 27  2019 mysql-test-8.0.17-linux-glibc2.12-x86_64.tar.xz
drwxr-xr-x.  2 root  root           6 Nov  5  2016 sbin
drwxr-xr-x.  6 root  root          60 Feb  2  2018 share
drwxr-xr-x.  2 root  root           6 Nov  5  2016 src	

[root@env local]# /etc/init.d/mysql stop
Shutting down MySQL.... SUCCESS! 
mv mysql mysql-8.0.12


[root@env local]# mv mysql mysql-8.0.12
[root@env local]# ll
total 4544060
drwxr-xr-x.  2 root  root          22 Feb  2  2018 bin
drwxr-xr-x.  2 root  root           6 Nov  5  2016 etc
drwxr-xr-x.  2 root  root           6 Nov  5  2016 games
drwxr-xr-x.  2 root  root           6 Nov  5  2016 include
drwxr-xr-x.  2 root  root           6 Nov  5  2016 lib
drwxr-xr-x.  2 root  root           6 Nov  5  2016 lib64
drwxr-xr-x.  2 root  root           6 Nov  5  2016 libexec
drwxr-xr-x   9 mysql mysql        129 May 23 13:25 mysql-8.0.12
-rw-r--r--   1 root  root  1867110400 May 23 12:07 mysql-8.0.12-linux-glibc2.12-x86_64.tar
drwxr-xr-x  11 root  root         194 May 24 02:59 mysql-8.0.17-linux-glibc2.12-x86_64
-rw-r--r--   1  7155 31415 2601118720 Jun 27  2019 mysql-8.0.17-linux-glibc2.12-x86_64.tar
-rw-r--r--   1  7155 31415   34514636 Jun 27  2019 mysql-router-8.0.17-linux-glibc2.12-x86_64.tar.xz
-rw-r--r--   1  7155 31415  150488620 Jun 27  2019 mysql-test-8.0.17-linux-glibc2.12-x86_64.tar.xz
drwxr-xr-x.  2 root  root           6 Nov  5  2016 sbin
drwxr-xr-x.  6 root  root          60 Feb  2  2018 share
drwxr-xr-x.  2 root  root           6 Nov  5  2016 src
[root@env local]# mv mysql-8.0.17-linux-glibc2.12-x86_64 mysql
[root@env local]# cchown -R  mysql:mysql mysql^C
[root@env local]# chown -R  mysql:mysql mysql


[root@env local]# ll
total 4544060
drwxr-xr-x.  2 root  root          22 Feb  2  2018 bin
drwxr-xr-x.  2 root  root           6 Nov  5  2016 etc
drwxr-xr-x.  2 root  root           6 Nov  5  2016 games
drwxr-xr-x.  2 root  root           6 Nov  5  2016 include
drwxr-xr-x.  2 root  root           6 Nov  5  2016 lib
drwxr-xr-x.  2 root  root           6 Nov  5  2016 lib64
drwxr-xr-x.  2 root  root           6 Nov  5  2016 libexec
drwxr-xr-x  11 mysql mysql        194 May 24 02:59 mysql
drwxr-xr-x   9 mysql mysql        129 May 23 13:25 mysql-8.0.12
-rw-r--r--   1 root  root  1867110400 May 23 12:07 mysql-8.0.12-linux-glibc2.12-x86_64.tar
-rw-r--r--   1  7155 31415 2601118720 Jun 27  2019 mysql-8.0.17-linux-glibc2.12-x86_64.tar
-rw-r--r--   1  7155 31415   34514636 Jun 27  2019 mysql-router-8.0.17-linux-glibc2.12-x86_64.tar.xz
-rw-r--r--   1  7155 31415  150488620 Jun 27  2019 mysql-test-8.0.17-linux-glibc2.12-x86_64.tar.xz
drwxr-xr-x.  2 root  root           6 Nov  5  2016 sbin
drwxr-xr-x.  6 root  root          60 Feb  2  2018 share
drwxr-xr-x.  2 root  root           6 Nov  5  2016 src


cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql

/etc/init.d/mysql start 

[root@env local]# mysql -uroot -p123456abc
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.17 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

root@mysqldb 03:04:  [(none)]> select version();
+-----------+
| version() |
+-----------+
| 8.0.17    |
+-----------+
1 row in set (0.06 sec)

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
	
	[root@env local]# /usr/local/mysql/bin/mysqld --upgrade=
	[root@env local]# 