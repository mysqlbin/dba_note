
1. log_warnings
2. log_error_verbosity
3. 相关参考
4. 小结
5. other 
6. 案例


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
	2021-09-10T07:01:45.990153+08:00 1263879 [Note] Aborted connection 1263879 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:45.990146+08:00 1263877 [Note] Aborted connection 1263877 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.002452+08:00 1263836 [Note] Aborted connection 1263836 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.002470+08:00 1263837 [Note] Aborted connection 1263837 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.002498+08:00 1263839 [Note] Aborted connection 1263839 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.002534+08:00 1263845 [Note] Aborted connection 1263845 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.004662+08:00 1263851 [Note] Aborted connection 1263851 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.002463+08:00 1263843 [Note] Aborted connection 1263843 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.004985+08:00 1263849 [Note] Aborted connection 1263849 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.004988+08:00 1263841 [Note] Aborted connection 1263841 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.002456+08:00 1263834 [Note] Aborted connection 1263834 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.002501+08:00 1263847 [Note] Aborted connection 1263847 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.017646+08:00 1263866 [Note] Aborted connection 1263866 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.017685+08:00 1263868 [Note] Aborted connection 1263868 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.017727+08:00 1263867 [Note] Aborted connection 1263867 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.018117+08:00 1263870 [Note] Aborted connection 1263870 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.018150+08:00 1263869 [Note] Aborted connection 1263869 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:46.150203+08:00 1323710 [Note] Aborted connection 1323710 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.50' (Got an error reading communication packets)
	2021-09-10T07:01:47.161238+08:00 1263888 [Note] Aborted connection 1263888 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.161240+08:00 1263889 [Note] Aborted connection 1263889 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.161238+08:00 1263887 [Note] Aborted connection 1263887 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.161280+08:00 1263891 [Note] Aborted connection 1263891 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.162941+08:00 1263885 [Note] Aborted connection 1263885 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.162956+08:00 1263884 [Note] Aborted connection 1263884 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.162977+08:00 1263886 [Note] Aborted connection 1263886 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.162946+08:00 1263883 [Note] Aborted connection 1263883 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.162956+08:00 1263882 [Note] Aborted connection 1263882 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.167020+08:00 1263892 [Note] Aborted connection 1263892 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.167041+08:00 1263893 [Note] Aborted connection 1263893 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.167077+08:00 1263894 [Note] Aborted connection 1263894 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.167081+08:00 1263895 [Note] Aborted connection 1263895 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.167103+08:00 1263896 [Note] Aborted connection 1263896 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:47.309250+08:00 1323711 [Note] Aborted connection 1323711 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.53' (Got an error reading communication packets)
	2021-09-10T07:01:48.317376+08:00 1263903 [Note] Aborted connection 1263903 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.317428+08:00 1263907 [Note] Aborted connection 1263907 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.317394+08:00 1263906 [Note] Aborted connection 1263906 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.317415+08:00 1263905 [Note] Aborted connection 1263905 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.317376+08:00 1263904 [Note] Aborted connection 1263904 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.321977+08:00 1263898 [Note] Aborted connection 1263898 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.322025+08:00 1263899 [Note] Aborted connection 1263899 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.322040+08:00 1263900 [Note] Aborted connection 1263900 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.322063+08:00 1263901 [Note] Aborted connection 1263901 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.322030+08:00 1263902 [Note] Aborted connection 1263902 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
	2021-09-10T07:01:48.462855+08:00 1323712 [Note] Aborted connection 1323712 to db: 'niynioh9_db' user: 'apph5_user' host: '172.16.0.54' (Got an error reading communication packets)
