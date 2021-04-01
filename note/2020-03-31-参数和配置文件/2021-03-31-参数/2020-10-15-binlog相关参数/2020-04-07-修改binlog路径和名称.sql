
斌斌，请教下，如果对现有mysql，修改binlog的名字及保存路径，重启后会是个什么情况？原先的文件怎么处理
如果有从库的话，就是要重做了？

修改前
	my.cnf
		log-bin = /data/mysql/mysql3306/logs/mysql-bin

	root@mysqldb 19:34:  [(none)]> show global variables like '%log_bin%';
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

	/data/mysql/mysql3306/logs 目录下
		[root@mgr9 logs]# ll
		total 44
		-rw-r----- 1 mysql mysql 35852 Apr  5 19:33 mysql-bin.000069
		-rw-r----- 1 mysql mysql   154 Apr  5 19:33 mysql-bin.000070
		-rw-r----- 1 mysql mysql    88 Apr  5 19:33 mysql-bin.index


修改后
	my.cnf
		log-bin = /data/mysql/mysql3306/data/mysqls-bin
	
	重启MySQL 之后
	
	root@mysqldb 19:36:  [(none)]> show global variables like '%log_bin%';
	+---------------------------------+---------------------------------------------+
	| Variable_name                   | Value                                       |
	+---------------------------------+---------------------------------------------+
	| log_bin                         | ON                                          |
	| log_bin_basename                | /data/mysql/mysql3306/data/mysqls-bin       |
	| log_bin_index                   | /data/mysql/mysql3306/data/mysqls-bin.index |
	| log_bin_trust_function_creators | OFF                                         |
	| log_bin_use_v1_row_events       | OFF                                         |
	+---------------------------------+---------------------------------------------+
	5 rows in set (0.01 sec)

	/data/mysql/mysql3306/logs 目录下
		[root@mgr9 logs]# ll
		total 44
		-rw-r----- 1 mysql mysql 35852 Apr  5 19:33 mysql-bin.000069
		-rw-r----- 1 mysql mysql   177 Apr  5 19:36 mysql-bin.000070
		-rw-r----- 1 mysql mysql    88 Apr  5 19:33 mysql-bin.index

	/data/mysql/mysql3306/data 目录下
		-rw-r----- 1 mysql mysql        419 Apr  5 19:38 mysqls-bin.000001
		-rw-r----- 1 mysql mysql         45 Apr  5 19:36 mysqls-bin.index

		
原先的文件怎么处理：不处理，保留着。
原有的从库，不需要重做。

