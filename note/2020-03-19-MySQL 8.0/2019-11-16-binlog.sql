

当 expire_logs_days 与 binlog_expire_logs_seconds 参数都设置的情况下，如果设置了 skip-log-bin ，现在开始这个信息会被写入错误日志。

5.7 :

	log-bin = /data/mysql/mysql3306/logs/mysql-bin    # 设置 binlog路径的参数
	
	root@mysqldb 00:16:  [(none)]> show global variables like '%log_bin%';
	+---------------------------------+--------------------------------------------+
	| Variable_name                   | Value                                      |
	+---------------------------------+--------------------------------------------+
	| log_bin                         | ON                                         |
	| log_bin_basename                | /data/mysql/mysql3306/logs/mysql-bin       |
	| log_bin_index                   | /data/mysql/mysql3306/logs/mysql-bin.index |
	| log_bin_trust_function_creators | OFF                                        |
	| log_bin_use_v1_row_events       | OFF                                        |
	+---------------------------------+--------------------------------------------+
	5 rows in set (0.00 sec)

8.0:  

	log-bin = /data/mysql/mysql3306/logs/mysql-bin    # 设置 binlog路径的参数
	root@mysqldb 10:22:  [(none)]> show global variables like '%log_bin%';
	+---------------------------------+--------------------------------------------+
	| Variable_name                   | Value                                      |
	+---------------------------------+--------------------------------------------+
	| log_bin                         | ON                                         |
	| log_bin_basename                | /data/mysql/mysql3306/logs/mysql-bin       |
	| log_bin_index                   | /data/mysql/mysql3306/logs/mysql-bin.index |
	| log_bin_trust_function_creators | OFF                                        |
	| log_bin_use_v1_row_events       | OFF                                        |
	+---------------------------------+--------------------------------------------+
	5 rows in set (0.01 sec)

	

	
	#expire_logs_days 参数默认为0，取而代之的是 binlog_expire_logs_seconds, 单位为秒, 默认是 
	binlog_expire_logs_seconds=604800


	mysql> show global variables like '%binlog_expire_logs_seconds%';
	+----------------------------+--------+
	| Variable_name              | Value  |
	+----------------------------+--------+
	| binlog_expire_logs_seconds | 604800 |
	+----------------------------+--------+
	1 row in set (0.00 sec)


	mysql> show global variables like '%expire_logs_days%';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| expire_logs_days | 0     |
	+------------------+-------+
	1 row in set (0.05 sec)





