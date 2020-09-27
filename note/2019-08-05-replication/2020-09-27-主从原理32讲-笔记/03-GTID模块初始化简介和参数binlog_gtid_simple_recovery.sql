
1. GTID模块的初始化必须要从库信息初始化之前进行
2. 两种GTID持久化的介质在GTID模块初始化的时候担当什么的角色
3. 分两种情况来分别讨论主从GTID模块的初始化
4. GTID模拟初始化的步骤解析
	4.1 获取 server_uuid
	4.2 读取mysql.gtid_executed
	4.3 读取binlog文件
	4.4 将只在 binary log的 GTID 加入
	4.5 初始化 gtid_purged 变量
5. 主库GTID模块的初始化实验/验证

	
1. GTID模块的初始化必须要从库信息初始化之前进行
	GTID模块的初始化, 它会在实例启动的时候进行，但是在从库信息初始化之前
		从库信息的初始化将在第25节描述
	因为如果是 gtid auto_position mode 模式， IO线程将会使用到GTID的相关信息进行从库的启动
		这个将在第22节描述

2. 两种GTID持久化的介质在GTID模块初始化的时候担当什么的角色
	1. binary log 文件
	2. mysql.gtid_executed 表
	
3. 分两种情况来分别讨论主从GTID模块的初始化

	1. 主库开启Gtid开启binlog。
	2. 从库开启Gtid、开启binlog、不开启 log_slave_updates 参数。
	
	因为这两种是我们通常设置的方式，下面简称主库和从库。


4. GTID模拟初始化的步骤解析

	4.1 获取 server_uuid
		这一步主要是获取 server_uuid： 读取 auto.cnf 文件， 如果没有找到 auto.cnf 则重新生成一个。
		
	4.2 读取mysql.gtid_executed表
		这一步开始读取我们的第一个Gtid持久化介质 mysql.gtid_executed 表
		一行一行的读取 mysql.gtid_executed 表的内容加入到 executed_gtids 变量中，完成本步骤过后 executed_gtids 变量 将完成设置第一步
		但是对于 主库和从库来讲 这个 executed_gtids 变量 的意义不一样：
			主库这个时候的 executed_gtids 变量 还不是正确的：
				主库因为mysql.gtid_executed只包含上一个binlog的全部Gtid所以，它不包含最新binlog的Gtid，这些 GTID 还存在于 binary log 文件中
				
			主库这个时候的 executed_gtids 变量 是正确的：
				从库因为 mysql.gtid_executed 会实时更新，因此它包含了全部的Gtid。
			 
	4.3 读取binlog文件
		读取我们提及的第二个Gtid持久化介质binlog，读取方式为：
			先反向读取获取  binary log 包含的 GTID 
			然后正向读取获取  lost GTID, 扫描方式和参数 binlog_gtid_sample_recovery 有关
				5.7 中可以理解为第一个 binary log（binlog 列表中最旧的日志） 中的 Previous_gtids_log_event
			
	4.4 将只在 binary log的 GTID 加入
		这一步只有主库才会出现，从库不影响
		这一步会将那些只在 binary log 中存在的 GTID 加入到两个地方：
			mysql.gtid_executed 表
			gtid_executed 变量
		这样主库的 mysql.gtid_executed 表和 gtid_executed 变量 也正确了。
		
	4.5 初始化 gtid_purged 变量
		主库就等于上面扫描到的 lost GTID，一般来讲就是第一个 binary log 中的 Previous_gtids_log_event
		从库就于 gtid_executed 变量了，因为没有 binary log 的存在。
		
		完成了这一步基本上整个初始化过程结束了，几个重要信息都得到了初始化：
			1.1 mysql.gtid_executed表
			1.2 gtid_executed变量
			1.3 gtid_purged变量
		


5. 主库GTID模块的初始化实验/验证
	
	5.1 old gtid info
		root@localhost [(none)]>show global variables  like 'gtid_%';
		+----------------------------------+---------------------------------------------+
		| Variable_name                    | Value                                       |
		+----------------------------------+---------------------------------------------+
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-1005 |
		| gtid_executed_compression_period | 1000                                        |
		| gtid_mode                        | ON                                          |
		| gtid_owned                       |                                             |
		| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-1004 |
		+----------------------------------+---------------------------------------------+
		5 rows in set (0.00 sec)

		root@localhost [(none)]>select * from mysql.gtid_executed;
		+--------------------------------------+----------------+--------------+
		| source_uuid                          | interval_start | interval_end |
		+--------------------------------------+----------------+--------------+
		| f7323d17-6442-11ea-8a77-080027758761 |              1 |         1004 |
		+--------------------------------------+----------------+--------------+
		1 row in set (0.00 sec)

		root@localhost [(none)]>show binary logs;
		+------------------+-----------+
		| Log_name         | File_size |
		+------------------+-----------+
		| mysql-bin.000004 |       648 |
		+------------------+-----------+
		1 row in set (0.00 sec)

		root@localhost [(none)]>show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000004
				 Position: 648
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-1005
		1 row in set (0.00 sec)

		ERROR: 
		No query specified


	5.2 删除一条记录：
		root@localhost [(none)]>delete from sbtest.sbtest1 where id=1007;
		Query OK, 1 row affected (0.00 sec)

	
	5.3 old gtid info：
	
		root@localhost [(none)]>show global variables  like 'gtid_%';
		+----------------------------------+---------------------------------------------+
		| Variable_name                    | Value                                       |
		+----------------------------------+---------------------------------------------+
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-1006 |
		| gtid_executed_compression_period | 1000                                        |
		| gtid_mode                        | ON                                          |
		| gtid_owned                       |                                             |
		| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-1004 |
		+----------------------------------+---------------------------------------------+
		5 rows in set (0.00 sec)

		root@localhost [(none)]>select * from mysql.gtid_executed;
		+--------------------------------------+----------------+--------------+
		| source_uuid                          | interval_start | interval_end |
		+--------------------------------------+----------------+--------------+
		| f7323d17-6442-11ea-8a77-080027758761 |              1 |         1004 |
		+--------------------------------------+----------------+--------------+
		1 row in set (0.00 sec)

		root@localhost [(none)]>show binary logs;
		+------------------+-----------+
		| Log_name         | File_size |
		+------------------+-----------+
		| mysql-bin.000004 |      1096 |
		+------------------+-----------+
		1 row in set (0.00 sec)

		root@localhost [(none)]>show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000004
				 Position: 1096
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-1006
		1 row in set (0.00 sec)

		ERROR: 
		No query specified

	5.4 数据库重启
		shell> /etc/init.d/mysql restart
			Shutting down MySQL.... SUCCESS! 
			Starting MySQL... SUCCESS! 
			
		show global variables  like 'gtid_%'; 
			gtid_executed: f7323d17-6442-11ea-8a77-080027758761:1-1006
			gtid_purged  : f7323d17-6442-11ea-8a77-080027758761:1-1006      # 这里判断错误，因为 gtid 1005-1006 的binlog还在，所以 gtid_purged 还是等于 1004.
			  
		select * from mysql.gtid_executed;
			interval_end: 1006
			
		show binary logs;
			mysql-bin.000004
			mysql-bin.000005
			
		show master status\G;
			Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-1006
			
		
		root@localhost [(none)]>show global variables  like 'gtid_%'; 
		+----------------------------------+---------------------------------------------+
		| Variable_name                    | Value                                       |
		+----------------------------------+---------------------------------------------+
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-1006 |
		| gtid_executed_compression_period | 1000                                        |
		| gtid_mode                        | ON                                          |
		| gtid_owned                       |                                             |
		| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-1004 |
		+----------------------------------+---------------------------------------------+
		5 rows in set (0.00 sec)

		root@localhost [(none)]>select * from mysql.gtid_executed;
		+--------------------------------------+----------------+--------------+
		| source_uuid                          | interval_start | interval_end |
		+--------------------------------------+----------------+--------------+
		| f7323d17-6442-11ea-8a77-080027758761 |              1 |         1004 |
		| f7323d17-6442-11ea-8a77-080027758761 |           1005 |         1006 |
		+--------------------------------------+----------------+--------------+
		2 rows in set (0.00 sec)

		root@localhost [(none)]>show binary logs;
		+------------------+-----------+
		| Log_name         | File_size |
		+------------------+-----------+
		| mysql-bin.000004 |      1119 |
		| mysql-bin.000005 |       194 |
		+------------------+-----------+
		2 rows in set (0.00 sec)

		root@localhost [(none)]>show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000005
				 Position: 194
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-1006
		1 row in set (0.00 sec)

		ERROR: 
		No query specified
				
		