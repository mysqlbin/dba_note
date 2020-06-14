
	

思考:
	1. 如何批量 kill show PROCESSLIST.command=sleep&Time最大的100个连接
	
		参考: https://www.cnblogs.com/duhuo/p/5678286.html
		
		
	2. 参数 skip_networking 的用法
		
		https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_skip-networking
		
		Do not listen for TCP/IP connections at all. All interaction with mysqld must be made using named pipes or shared memory (on Windows) or Unix socket files (on Unix). 
		This option is highly recommended for systems where only local clients are permitted.
		
		vim /etc/my.cnf
		skip_networking=on;
		
		[root@mgr9 ~]# mysql -h192.168.0.54 -uroot -p123456abc
		mysql: [Warning] Using a password on the command line interface can be insecure.
		ERROR 2003 (HY000): Can't connect to MySQL server on '192.168.0.54' (111)
		
		[root@mgr9 ~]# mysql -uroot -pwubxwubx
		# login OK
		
		
		
	
	
	