
1. log_warnings
2. log_error_verbosity
3. 相关参考
4. 小结
5. other 
6. 案例


0. Got an error reading communication packets

	读取通信数据包时出错


1. log_warnings
	
	log_warnings 定义是否将告警信息（warning messages）也写入错误日志。此选项默认启用，具体来说：
	
		log_warnings Value 		含义
		
		0						不记录告警信息。

		1						把告警信息写入错误日志。

		>1						各类告警信息，例如有关网络故障的信息和重新连接信息写入错误日志。
	
	
	5.6 
		Command-Line Format					--log-warnings[=#]
		System Variable						log_warnings
		Scope								Global
		Dynamic								Yes
		Type								Integer
		Default Value						1
		Minimum Value						0
		Maximum Value (64-bit platforms)	18446744073709551615
		Maximum Value (32-bit platforms)	4294967295


		mysql> show global variables like '%log_warnings%';
		+---------------+-------+
		| Variable_name | Value |
		+---------------+-------+
		| log_warnings  | 1     |
		+---------------+-------+
		1 row in set (0.00 sec)
		
		shell> mysql -uroot -p123
		ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)
		
		错误日志中没有记录。
		
		
	5.7
	
		Command-Line Format					--log-warnings[=#]
		Deprecated							Yes
		System Variable						log_warnings
		Scope								Global
		Dynamic								Yes
		Type								Integer
		Default Value						2
		Minimum Value						0
		Maximum Value (64-bit platforms)	18446744073709551615
		Maximum Value (32-bit platforms)	4294967295


		root@mysqldb 10:46:  [(none)]> show global variables like '%log_warnings%';
		+---------------+-------+
		| Variable_name | Value |
		+---------------+-------+
		| log_warnings  | 2     |
		+---------------+-------+
		1 row in set (0.00 sec)

		root@mysqldb 10:09:  [(none)]> show global variables like '%log_error_verbosity%';
		+---------------------+-------+
		| Variable_name       | Value |
		+---------------------+-------+
		| log_error_verbosity | 3     |
		+---------------------+-------+
		1 row in set (0.00 sec)


		shell> mysql -uroot -p123
		ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)
		
		错误日志中的记录：
			2021-06-29T10:46:58.239605+08:00 7157 [Note] Access denied for user 'root'@'localhost' (using password: YES)

		
2. log_error_verbosity

	5.7 新增的参数
	
	5.7 
		Command-Line Format			--log-error-verbosity=#
		System Variable				log_error_verbosity
		Scope						Global
		Dynamic						Yes
		Type						Integer
		Default Value				3
		Minimum Value				1
		Maximum Value				3

		log_error_verbosity Value	Permitted Messages                          含义     
		1							Error messages								错误信息
		2							Error and warning messages					错误信息和告警信息
		3							Error, warning, and information messages	错误信息、告警信息和通知信息。
		
		
		mysql> select version();
		+------------+
		| version()  |
		+------------+
		| 5.7.22-log |
		+------------+
		1 row in set (0.00 sec)
	
		mysql> show global variables like '%log_warnings%';
		+---------------+-------+
		| Variable_name | Value |
		+---------------+-------+
		| log_warnings  | 2     |
		+---------------+-------+
		1 row in set (0.01 sec)

		mysql> show global variables like '%log_error_verbosity%';
		+---------------------+-------+
		| Variable_name       | Value |
		+---------------------+-------+
		| log_error_verbosity | 3     |
		+---------------------+-------+
		1 row in set (0.00 sec)

				
	
	8.0

		Command-Line Format				--log-error-verbosity=#
		System Variable					log_error_verbosity
		Scope							Global
		Dynamic							Yes
		SET_VAR Hint Applies			No
		Type							Integer
		Default Value					2
		Minimum Value					1
		Maximum Value					3
		
		log_error_verbosity Value	Permitted Messages                          含义     
		1							Error messages								错误信息
		2							Error and warning messages					错误信息和告警信息
		3							Error, warning, and information messages	错误信息、告警信息和通知信息。
		

3. 相关参考

	https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_log-warnings

	https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_log_error_verbosity

	https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity

	https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_log_warnings

	
4. 小结

	从MySQL 5.7.2开始，首选 log_error_verbosity 系统变量，而不是使用log-warnings选项或 log_warnings 系统变量，这个 log_warnings 参数从MySQL 8.0.3开始被移除了：

		This system variable was removed in MySQL 8.0.3. Use the log_error_verbosity system variable instead.


5. other 

	5.7有大量爆[Note] Got an error reading communication packets
	
	朝露昙花(672885382) 2021/8/3 14:27:25
	现在对比下来相关参数就一个 log_warnings 不一样

	朝露昙花(672885382) 2021/8/3 14:27:31
	5.6是1 5.7是2

	朝露昙花(672885382) 2021/8/3 14:27:53
	实际问题不大，就是刷日志刷的烦

	A群主-吴炳锡@知数堂(82565387)  15:06:59
	这个是一个提示, 需要 log_warnings >1 才会显示
	
	
	
6. 案例

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.21-log |
	+------------+
	1 row in set (0.00 sec)
	
	mysql> show global variables like '%log_error_verbosity%';
	+---------------------+-------+
	| Variable_name       | Value |
	+---------------------+-------+
	| log_error_verbosity | 3     |
	+---------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%log_warnings%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| log_warnings  | 2     |
	+---------------+-------+
	1 row in set (0.00 sec)
		
		
	07:01 分停游戏服器，报大量的 Note 
	2021-09-10T06:30:02.167895+08:00 1323595 [Note] Aborted connection 1323595 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
	2021-09-10T07:00:01.717750+08:00 1323702 [Note] Aborted connection 1323702 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
	2021-09-10T07:00:01.822816+08:00 1323700 [Note] Aborted connection 1323700 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
	2021-09-10T07:01:45.953143+08:00 1263873 [Note] Aborted connection 1263873 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:45.953144+08:00 1263874 [Note] Aborted connection 1263874 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:45.953144+08:00 1263875 [Note] Aborted connection 1263875 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:45.990132+08:00 1263878 [Note] Aborted connection 1263878 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	.................................................................................................................................................................................
	2021-09-10T07:01:47.167103+08:00 1263896 [Note] Aborted connection 1263896 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.309250+08:00 1323711 [Note] Aborted connection 1323711 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:48.317376+08:00 1263903 [Note] Aborted connection 1263903 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)

	2021-09-10T07:01:48.322063+08:00 1263901 [Note] Aborted connection 1263901 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.322030+08:00 1263902 [Note] Aborted connection 1263902 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.462855+08:00 1323712 [Note] Aborted connection 1323712 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	
	
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	2021-09-13T16:58:13.072917+08:00 275945 [Note] Aborted connection 275945 to db: 'niuniuh5_db' user: 'dengpengcheng' host: '192.168.0.251' (Got an error reading communication packets)
	2021-09-13T16:58:13.072980+08:00 275946 [Note] Aborted connection 275946 to db: 'niuniuh5_db' user: 'dengpengcheng' host: '192.168.0.251' (Got an error reading communication packets)
	2021-09-13T16:58:13.073044+08:00 275947 [Note] Aborted connection 275947 to db: 'niuniuh5_db' user: 'dengpengcheng' host: '192.168.0.251' (Got an error reading communication packets)
	.................................................................................................................................................................................
	2021-09-13T16:58:13.073933+08:00 275952 [Note] Aborted connection 275952 to db: 'niuniuh5_db' user: 'dengpengcheng' host: '192.168.0.251' (Got an error reading communication packets)
	.................................................................................................................................................................................
	2021-09-13T16:58:13.076523+08:00 275973 [Note] Aborted connection 275973 to db: 'niuniuh5_db' user: 'dengpengcheng' host: '192.168.0.251' (Got an error reading communication packets)
	.................................................................................................................................................................................
	2021-09-13T16:58:13.076632+08:00 275971 [Note] Aborted connection 275971 to db: 'niuniuh5_db' user: 'dengpengcheng' host: '192.168.0.251' (Got an error reading communication packets)
	2021-09-13T16:58:13.194914+08:00 275985 [Note] Aborted connection 275985 to db: 'niuniuh5_db' user: 'dengpengcheng' host: '192.168.0.251' (Got an error reading communication packets)

		
	set global log_warnings=1;
	set global log_error_verbosity=2;

	mysql> show global variables like '%log_warnings%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| log_warnings  | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%log_error_verbosity%';
	+---------------------+-------+
	| Variable_name       | Value |
	+---------------------+-------+
	| log_error_verbosity | 2     |
	+---------------------+-------+
	1 row in set (0.00 sec)

	---- 持续跟踪，看看是否还会  'Got an error reading communication packets' 这个提示
	
	
	