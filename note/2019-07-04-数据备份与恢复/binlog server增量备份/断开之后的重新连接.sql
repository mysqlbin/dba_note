
master
	root@localhost [(none)]>show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000002 |  28168696 |
	| mysql-bin.000003 |    335398 |
	| mysql-bin.000004 |       217 |
	| mysql-bin.000005 |       424 |
	| mysql-bin.000006 |      5272 |
	| mysql-bin.000007 |      3596 |
	| mysql-bin.000008 |       748 |
	| mysql-bin.000009 |       241 |
	| mysql-bin.000010 |       241 |
	| mysql-bin.000011 |       502 |
	| mysql-bin.000012 |       194 |
	+------------------+-----------+
	11 rows in set (0.00 sec)


	
binlog server：

	[root@env29 backup]# ps aux|grep mysqlbinlog
	root     18085  0.0  0.2  25684  2204 pts/2    S    07:14   0:01 mysqlbinlog --raw --read-from-remote-server --host 192.168.1.27 --port 3306 --stop-never -ubinlog_server_user -px xxxxxxx mysql-bin.000002
	root     19159  0.0  0.0 112660   976 pts/2    R+   08:37   0:00 grep --color=auto mysqlbinlog
	[root@env29 backup]# 
	[root@env29 backup]# 
	[root@env29 backup]# kill 18085
	[root@env29 backup]# ps aux|grep mysqlbinlog
	root     19169  0.0  0.0 112660   972 pts/2    R+   08:38   0:00 grep --color=auto mysqlbinlog
	[1]+  Terminated              mysqlbinlog --raw --read-from-remote-server --host 192.168.1.27 --port 3306 --stop-never -ubinlog_server_user -p123456abc mysql-bin.000002
	[root@env29 backup]# ps aux|grep mysqlbinlog
	root     19171  0.0  0.0 112660   976 pts/2    R+   08:38   0:00 grep --color=auto mysqlbinlog
	[root@env29 backup]# 
	[root@env29 backup]# 
	[root@env29 backup]# ps aux|grep mysqlbinlog
	root     19173  0.0  0.0 112660   976 pts/2    R+   08:38   0:00 grep --color=auto mysqlbinlog
	[root@env29 backup]# ll
	total 27880
	-rw-r----- 1 root root 28168696 Mar 21 07:14 mysql-bin.000002
	-rw-r----- 1 root root   335398 Mar 21 07:14 mysql-bin.000003
	-rw-r----- 1 root root      217 Mar 21 07:14 mysql-bin.000004
	-rw-r----- 1 root root      424 Mar 21 07:14 mysql-bin.000005
	-rw-r----- 1 root root     5272 Mar 21 07:14 mysql-bin.000006
	-rw-r----- 1 root root     3596 Mar 21 07:14 mysql-bin.000007
	-rw-r----- 1 root root      748 Mar 21 07:14 mysql-bin.000008
	-rw-r----- 1 root root      241 Mar 21 07:14 mysql-bin.000009
	-rw-r----- 1 root root      241 Mar 21 07:14 mysql-bin.000010
	-rw-r----- 1 root root      502 Mar 21 07:14 mysql-bin.000011
	-rw-r----- 1 root root      194 Mar 21 07:14 mysql-bin.000012
	
	
master
	root@localhost [(none)]>delete * from zst.t where id=1;
	ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '* from zst.t where id=1' at line 1
	root@localhost [(none)]>delete from zst.t where id=1;
	Query OK, 1 row affected (0.00 sec)

	root@localhost [(none)]>show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000002 |  28168696 |
	| mysql-bin.000003 |    335398 |
	| mysql-bin.000004 |       217 |
	| mysql-bin.000005 |       424 |
	| mysql-bin.000006 |      5272 |
	| mysql-bin.000007 |      3596 |
	| mysql-bin.000008 |       748 |
	| mysql-bin.000009 |       241 |
	| mysql-bin.000010 |       241 |
	| mysql-bin.000011 |       502 |
	| mysql-bin.000012 |       452 |
	+------------------+-----------+
	11 rows in set (0.00 sec)


	
mysqlbinlog 

	[root@env29 backup]# mysqlbinlog --raw --read-from-remote-server --host 192.168.1.27 --port 3306 --stop-never -ubinlog_server_user -p123456abc   mysql-bin.000012  &
	[1] 19230
	[root@env29 backup]# mysqlbinlog: [Warning] Using a password on the command line interface can be insecure.
	^C
	[root@env29 backup]# ll
	total 27880
	-rw-r----- 1 root root 28168696 Mar 21 07:14 mysql-bin.000002
	-rw-r----- 1 root root   335398 Mar 21 07:14 mysql-bin.000003
	-rw-r----- 1 root root      217 Mar 21 07:14 mysql-bin.000004
	-rw-r----- 1 root root      424 Mar 21 07:14 mysql-bin.000005
	-rw-r----- 1 root root     5272 Mar 21 07:14 mysql-bin.000006
	-rw-r----- 1 root root     3596 Mar 21 07:14 mysql-bin.000007
	-rw-r----- 1 root root      748 Mar 21 07:14 mysql-bin.000008
	-rw-r----- 1 root root      241 Mar 21 07:14 mysql-bin.000009
	-rw-r----- 1 root root      241 Mar 21 07:14 mysql-bin.000010
	-rw-r----- 1 root root      502 Mar 21 07:14 mysql-bin.000011
	-rw-r----- 1 root root      452 Mar 21 08:42 mysql-bin.000012

	
