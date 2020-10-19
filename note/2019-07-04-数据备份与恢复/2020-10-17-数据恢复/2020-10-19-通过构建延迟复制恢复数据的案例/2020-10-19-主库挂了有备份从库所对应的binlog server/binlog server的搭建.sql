

1. 环境配置

	主机名        IP                   server-id        角色

	evn27        192.168.1.27           273306          Master
	evn29        192.168.1.29           293306          Binlog backup server and Slave
	evn30        192.168.1.30           303306          slave 
	
	哪一台做

2. 创建 binlog server 账号

	evn27 创建上binlog server 账号
		
	create user 'binlog_server_user'@'192.168.1.%' identified by '123456abc';
	grant replication slave on *.* to 'binlog_server_user'@'192.168.1.%' with grant option;
	

3. 
	mysqlbinlog --raw --read-from-remote-server --host 192.168.1.29 --port 3306 --stop-never -ubinlog_server_user -p123456abc   mysql-bin.000001  &	
	
	
4. evn29上查看 mysqlbinlog 线程

	root@localhost [(none)]>show processlist;
	+----+--------------------+-------------+------+-------------+------+---------------------------------------------------------------+------------------+
	| Id | User               | Host        | db   | Command     | Time | State                                                         | Info             |
	+----+--------------------+-------------+------+-------------+------+---------------------------------------------------------------+------------------+
	|  3 | binlog_server_user | env29:52746 | NULL | Binlog Dump |   83 | Master has sent all binlog to slave; waiting for more updates | NULL             |
	|  4 | root               | localhost   | NULL | Query       |    0 | starting                                                      | show processlist |
	+----+--------------------+-------------+------+-------------+------+---------------------------------------------------------------+------------------+
	2 rows in set (0.00 sec)
