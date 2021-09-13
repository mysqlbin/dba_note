
1. 关于skip_name_resolve参数
2. skip-name-resolve参数的作用
3. 反解析连接不上MySQL的错误日志
4. skip_name_resolve参数不是1个动态参数
5. skip_name_resolve参数写入到配置文件不管值为什么只要再启动就会生效
6. 实践1
7. 实践2
8. 相关参考


1. 关于skip_name_resolve参数
	
	当一个客户端连接上来的时候，服务端会执行主机名解释操作，当 DNS 很慢时，建立的连接也会很慢。
	因此建议在启动的时候设置 skip-name-resolve 来禁用 DNS 查找。
	唯一的局限是 GRANT 语句仅且仅能使用 IP 地址，所以，在已有系统中添加这个选项时需要格外小心。

	检查客户端连接时是否解析主机名。 
	如果此变量为OFF，则mysqld在检查客户端连接时解析主机名。 
	如果为ON，则mysqld禁用 DNS 查找, 仅使用IP号。 在这种情况下，授予表中的所有“主机”列值都必须是IP地址。

	Default Value	OFF
	

2. skip-name-resolve参数的作用
	
	通过IP反解析成DNS域名，然后再通过域名连接MySQL 
		
	不再进行反解析（ip不反解成域名），这样可以加快数据库的反应时间


3. 反解析连接不上MySQL的错误日志

	tail -f /dba/mysql/iZoi1yuqcvndysZ.err
	2018-07-23 04:25:42 5874 [Warning] IP address '47.97.16.76' could not be resolved: Name or service not known
	2018-07-23 09:33:46 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:33:47 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:34:37 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:35:19 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:38:51 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:43:17 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:57:07 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:57:08 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:58:46 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:59:20 5874 [Warning] IP address '121.35.103.64' has been resolved to the host name '64.103.35.121.broad.sz.gd.dynamic.163data.com.cn', which resembles IPv4-address itself.
	2018-07-23 09:59:21 5874 [Warning] IP address '121.35.103.64' could not be resolved: Name or service not known
		-- IP反解析成域名


4. skip_name_resolve参数不是1个动态参数
	root@mysqldb 14:21:  [(none)]> set global skip_name_resolve=0;
	ERROR 1238 (HY000): Variable 'skip_name_resolve' is a read only variable




5. skip_name_resolve参数写入到配置文件不管值为什么只要再启动就会生效

	--------------------------------------------------------------------------------------------------------------------------------------------------------



	#skip_name_resolve = 0

	root@mysqldb 16:27:  [(none)]> show global variables like '%skip%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| skip_external_locking  | ON    |
	| skip_name_resolve      | OFF   |
	| skip_networking        | OFF   |
	| skip_show_database     | OFF   |
	| slave_skip_errors      | OFF   |
	| sql_slave_skip_counter | 0     |
	+------------------------+-------+
	6 rows in set (0.01 sec)



	--------------------------------------------------------------------------------------------------------------------------------------------------------

	skip_name_resolve = OFF

	root@mysqldb 16:35:  [(none)]> show global variables like '%skip%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| skip_external_locking  | ON    |
	| skip_name_resolve      | ON    |
	| skip_networking        | OFF   |
	| skip_show_database     | OFF   |
	| slave_skip_errors      | OFF   |
	| sql_slave_skip_counter | 0     |
	+------------------------+-------+
	6 rows in set (0.01 sec)

	--------------------------------------------------------------------------------------------------------------------------------------------------------

	skip_name_resolve = ON

	root@mysqldb 16:38:  [(none)]> show global variables like '%skip%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| skip_external_locking  | ON    |
	| skip_name_resolve      | ON    |
	| skip_networking        | OFF   |
	| skip_show_database     | OFF   |
	| slave_skip_errors      | OFF   |
	| sql_slave_skip_counter | 0     |
	+------------------------+-------+
	6 rows in set (0.00 sec)

	--------------------------------------------------------------------------------------------------------------------------------------------------------

	skip_name_resolve = 1

	root@mysqldb 16:39:  [(none)]> show global variables like '%skip%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| skip_external_locking  | ON    |
	| skip_name_resolve      | ON    |
	| skip_networking        | OFF   |
	| skip_show_database     | OFF   |
	| slave_skip_errors      | OFF   |
	| sql_slave_skip_counter | 0     |
	+------------------------+-------+
	6 rows in set (0.01 sec)

	--------------------------------------------------------------------------------------------------------------------------------------------------------
	skip_name_resolve = 0

	root@mysqldb 16:40:  [(none)]> show global variables like '%skip%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| skip_external_locking  | ON    |
	| skip_name_resolve      | ON    |
	| skip_networking        | OFF   |
	| skip_show_database     | OFF   |
	| slave_skip_errors      | OFF   |
	| sql_slave_skip_counter | 0     |
	+------------------------+-------+
	6 rows in set (0.00 sec)



--------------------------------------------------------------------------------------------------------------------------------------------------------


6. 实践1
	create user 'skip_user'@'h_tt_%' identified by '123456';
	grant all privileges on *.* to 'skip_user'@'h_tt_%' with grant option;


	[root@localhost ~]# cat /etc/hosts
	192.168.0.252 abc.com.cn


	[root@soft ~]# mysql -h 192.168.0.242 -uskip_user -p123456
	ERROR 1045 (28000): Access denied for user 'skip_user'@'192.168.0.252' (using password: YES)
	[root@soft ~]# 
	[root@soft ~]# mysql -h 192.168.0.242 -uskip_user -p123456
	ERROR 1045 (28000): Access denied for user 'skip_user'@'192.168.0.252' (using password: YES)
	[root@soft ~]# 

	[root@soft ~]# mysql -h 192.168.0.242 -uskip_user -p123456
	ERROR 1045 (28000): Access denied for user 'skip_user'@'192.168.0.252' (using password: YES)


	2021-04-09T12:00:03.531380+08:00 8 [Warning] IP address '192.168.0.220' could not be resolved: Name or service not known
	2021-04-09T12:00:58.314184+08:00 10 [Warning] IP address '192.168.0.252' could not be resolved: Name or service not known
	2021-04-09T12:00:58.352601+08:00 10 [Note] Access denied for user 'skip_user'@'192.168.0.252' (using password: YES)
	2021-04-09T12:01:06.071910+08:00 12 [Note] Access denied for user 'skip_user'@'192.168.0.252' (using password: YES)
	2021-04-09T12:01:25.871272+08:00 13 [Note] Access denied for user 'skip_user'@'192.168.0.252' (using password: YES)


--------------------------------------------------------------------------------------------------------------------------------------------------------


7. 实践2
	create user 'skip_user'@'h_tt_%' identified by '123456';
	grant all privileges on *.* to 'skip_user'@'h_tt_%' with grant option;

	[root@localhost ~]# cat /etc/hosts
	192.168.0.252 h_tt_aaa.com.cn

	[root@soft ~]# mysql -h 192.168.0.242 -uskip_user -p123456
	Welcome to the MySQL monitor.  Commands end with ; or \g.
	Your MySQL connection id is 26
	Server version: 5.7.22-log MySQL Community Server (GPL)

	Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

	Oracle is a registered trademark of Oracle Corporation and/or its
	affiliates. Other names may be trademarks of their respective
	owners.

	Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

	skip_user@mysqldb 12:07:  [(none)]> 


8. 相关参考

	https://blog.csdn.net/u010584271/article/details/80835378  MySQL在远程访问时非常慢的解决skip-name-resolve

	https://www.jb51.net/article/70893.htm  mysql could not be resolved: Name or service not known

	https://blog.csdn.net/hwhua1986/article/details/78188231




