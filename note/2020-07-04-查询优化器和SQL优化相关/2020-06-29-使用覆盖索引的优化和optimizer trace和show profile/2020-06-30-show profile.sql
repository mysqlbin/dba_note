

1. show profile的说明 

	show profile是mysql提供可以用来分析当前会话中语句执行的资源消耗情况，可以用于SQL的调优测量。
	 
	 
2. 相关参考
	https://www.cnblogs.com/xujunkai/p/12496634.html   show profile查看SQL执行生命周期
	https://dev.mysql.com/doc/refman/5.7/en/show-profile.html


3. 使用 idx_loginIp_szTime索引

	set profiling = 1;
	SELECT count(*) FROM `table_web_loginlog` force index(idx_loginIp_szTime) WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
	show profiles;
	show profile for query 1;
	    Status 就是平常我们执行 show processlist 命令看到的 State 的值
		+----------------------+----------+
		| Status               | Duration |
		+----------------------+----------+
		| starting             | 0.000068 |
		| checking permissions | 0.000009 |
		| checking permissions | 0.000004 |
		| Opening tables       | 0.000013 |
		| init                 | 0.000038 |
		| System lock          | 0.000007 |
		| optimizing           | 0.000028 |
		| statistics           | 0.000112 |
		| preparing            | 0.000033 |
		| executing            | 0.000003 |
		| Sending data         | 0.192259 |
		| end                  | 0.000012 |
		| query end            | 0.000010 |
		| closing tables       | 0.000008 |
		| freeing items        | 0.000019 |
		| cleaning up          | 0.000010 |
		+----------------------+----------+
		16 rows in set, 1 warning (0.00 sec)

	root@mysqldb 10:47:  [bak_niuniuh5_db]> show profile cpu,block io for query 1;
	+----------------------+----------+----------+------------+--------------+---------------+
	| Status               | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+----------------------+----------+----------+------------+--------------+---------------+
	| starting             | 0.000068 | 0.000039 |   0.000025 |            0 |             0 |
	| checking permissions | 0.000009 | 0.000005 |   0.000003 |            0 |             0 |
	| checking permissions | 0.000004 | 0.000002 |   0.000002 |            0 |             0 |
	| Opening tables       | 0.000013 | 0.000009 |   0.000004 |            0 |             0 |
	| init                 | 0.000038 | 0.000023 |   0.000015 |            0 |             0 |
	| System lock          | 0.000007 | 0.000004 |   0.000003 |            0 |             0 |
	| optimizing           | 0.000028 | 0.000016 |   0.000011 |            0 |             0 |
	| statistics           | 0.000112 | 0.000069 |   0.000044 |            0 |             0 |
	| preparing            | 0.000033 | 0.000020 |   0.000013 |            0 |             0 |
	| executing            | 0.000003 | 0.000001 |   0.000001 |            0 |             0 |
	| Sending data         | 0.192259 | 0.214179 |   0.000000 |            0 |             0 |
	| end                  | 0.000012 | 0.000000 |   0.000000 |            0 |             0 |
	| query end            | 0.000010 | 0.000000 |   0.000000 |            0 |             0 |
	| closing tables       | 0.000008 | 0.000000 |   0.000000 |            0 |             0 |
	| freeing items        | 0.000019 | 0.000000 |   0.000000 |            0 |             0 |
	| cleaning up          | 0.000010 | 0.000000 |   0.000000 |            0 |             0 |
	+----------------------+----------+----------+------------+--------------+---------------+
	16 rows in set, 1 warning (0.00 sec)

	Duration：持续时间，即每个步骤的耗时。

	这里只列出了cpu和 block io 当然 诊断类型不止这些：

	ALL 显示所有的开销信息
	BLOCK IO 显示块IO相关开销
	CONTEXT SWITCHES 上下文切换相关开销
	CPU  显示CPU相关开销信息
	IPC  显示发送和接收相关开销信息
	MEMORY 显示内存相关开销信息
	PAGE FAULTS 显示页面错误相关开销
	SOURCE  显示和Source_function,Source_file,Source_line相关的开销信息
	SWAPS   显示交换次数相关开销的信息
	象用什么类型只需往后加就行，常用的cpu和block io


	表中遇到Status 需要注意执行时间

	converting HEAP to MySIAM             数据过大MyISAM内存装不下，向磁盘上搬运
	Creating tmp table                   临时表创建
	Copying to tmp table on disk         复制临时表到磁盘
	locked                                锁。阻塞

	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

4. 使用 idx_loginIp_szTime_nPlayerId索引

	set profiling = 1;
	SELECT count(*) FROM `table_web_loginlog` force index(idx_loginIp_szTime_nPlayerId) WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
	show profiles;
	+----------+------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Query_ID | Duration   | Query                                                                                                                                                                         |
	+----------+------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	|        1 | 0.19263125 | SELECT count(*) FROM `table_web_loginlog` force index(idx_loginIp_szTime) WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000           |
	|        2 | 0.00023475 | set profiling = 1                                                                                                                                                             |
	|        3 | 0.11317275 | SELECT count(*) FROM `table_web_loginlog` force index(idx_loginIp_szTime_nPlayerId) WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000 |
	+----------+------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	3 rows in set, 1 warning (0.00 sec)

	show profile for query 3;
	+----------------------+----------+
	| Status               | Duration |
	+----------------------+----------+
	| starting             | 0.000092 |
	| checking permissions | 0.000016 |
	| checking permissions | 0.000008 |
	| Opening tables       | 0.000023 |
	| init                 | 0.000078 |
	| System lock          | 0.000015 |
	| optimizing           | 0.000067 |
	| statistics           | 0.000248 |
	| preparing            | 0.000070 |
	| executing            | 0.000008 |
	| Sending data         | 0.112512 |
	| end                  | 0.000005 |
	| query end            | 0.000007 |
	| closing tables       | 0.000006 |
	| freeing items        | 0.000011 |
	| cleaning up          | 0.000008 |
	+----------------------+----------+
	16 rows in set, 1 warning (0.00 sec)

	root@mysqldb 10:45:  [bak_niuniuh5_db]> show profile cpu,block io for query 3;
	+----------------------+----------+----------+------------+--------------+---------------+
	| Status               | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+----------------------+----------+----------+------------+--------------+---------------+
	| starting             | 0.000092 | 0.000000 |   0.000000 |            0 |             0 |
	| checking permissions | 0.000016 | 0.000000 |   0.000000 |            0 |             0 |
	| checking permissions | 0.000008 | 0.000000 |   0.000000 |            0 |             0 |
	| Opening tables       | 0.000023 | 0.000000 |   0.000000 |            0 |             0 |
	| init                 | 0.000078 | 0.000000 |   0.000000 |            0 |             0 |
	| System lock          | 0.000015 | 0.000000 |   0.000000 |            0 |             0 |
	| optimizing           | 0.000067 | 0.000000 |   0.000000 |            0 |             0 |
	| statistics           | 0.000248 | 0.000439 |   0.000000 |            0 |             0 |
	| preparing            | 0.000070 | 0.000000 |   0.000000 |            0 |             0 |
	| executing            | 0.000008 | 0.000000 |   0.000000 |            0 |             0 |
	| Sending data         | 0.112512 | 0.125422 |   0.000000 |            0 |             0 |
	| end                  | 0.000005 | 0.000000 |   0.000000 |            0 |             0 |
	| query end            | 0.000007 | 0.000000 |   0.000000 |            0 |             0 |
	| closing tables       | 0.000006 | 0.000000 |   0.000000 |            0 |             0 |
	| freeing items        | 0.000011 | 0.000000 |   0.000000 |            0 |             0 |
	| cleaning up          | 0.000008 | 0.000000 |   0.000000 |            0 |             0 |
	+----------------------+----------+----------+------------+--------------+---------------+
	16 rows in set, 1 warning (0.00 sec)

