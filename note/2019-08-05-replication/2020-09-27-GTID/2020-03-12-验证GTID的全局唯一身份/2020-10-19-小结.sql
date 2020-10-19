
验证了同一个事务在 master-binary-log、slave-binary-log、relay-log 中记录的位点是不一样的，但是记录的GTID是一样的, 同时说明了GTID在整个复制中是全局唯一的。


在从库执行 show master status 命令，Executed_Gtid_Set的值显示的是主库的信息。

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
