
验证了同一个事务在 master-binary-log、slave-binary-log、relay-log 中记录的位点是不一样的，但是记录的GTID是一样的, 同时说明了GTID在整个复制中是全局唯一的。

这个实验是基于MySQL 8.0.18 版本的.

在从库执行 show master status 命令，Executed_Gtid_Set(已经执行的GTID集合) 的值显示的是主库的信息

master
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000006
			 Position: 136159580
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
	1 row in set (0.00 sec)

slave1
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000001
			 Position: 154
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
	1 row in set (0.00 sec)

slave2
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000001
			 Position: 3902
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
	1 row in set (0.00 sec)


一个小实验
	
	master
		shell> cat auto.cnf 
		[auto]
		server-uuid=9e520b78-013c-11eb-a84c-0800271bf591
		
		
		mysql> show global variables like '%server_uuid%';
		+---------------+--------------------------------------+
		| Variable_name | Value                                |
		+---------------+--------------------------------------+
		| server_uuid   | 9e520b78-013c-11eb-a84c-0800271bf591 |
		+---------------+--------------------------------------+
		1 row in set (0.00 sec)


	slave2
		mysql> stop slave;
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002
				 Position: 194
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
		1 row in set (0.00 sec)
	
	master
		mysql> delete from t_20201019 where id=1;
		Query OK, 1 row affected (0.05 sec)

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000006
				 Position: 136159863
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-68
		1 row in set (0.00 sec)

	
	slave2
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002   -- 自己本地的
				 Position: 194                -- 自己本地的
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
		1 row in set (0.00 sec)
		
		mysql> show slave status\G;
			Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:58-67
			 Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67

		mysql> start slave io_thread;
		Query OK, 0 rows affected (0.00 sec)

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002
				 Position: 194
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67
		1 row in set (0.00 sec)
		
		mysql> show slave status\G;
           Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:58-68
            Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-67

		