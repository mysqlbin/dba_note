
1. 实验目的
2. 实验步骤
3. 实验详情
4. 小结

1. 实验目的:
	验证 执行"SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	START TRANSACTION  WITH CONSISTENT SNAPSHOT ;" 之后能否获取到一致性的binlog position位点信息

2. 实验步骤
	SESSION  A                                                         SESSION B
	select * from t where id=1;
	show master status\G;
	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
																		delete from t where id=1;
																		show master status\G;
	START TRANSACTION WITH CONSISTENT SNAPSHOT;
																		delete from t where id=2;	
																		show master status\G;
	show master status\G;



3. 实验详情
	SESSION A                                                           SESSION B
	
	mysql>select * from t where id=1;
	+----+------+---------------------+
	| id | a    | t_modified          |
	+----+------+---------------------+
	|  1 |    1 | 2020-03-15 12:59:27 |
	+----+------+---------------------+
	1 row in set (0.00 sec)


	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000002
			 Position: 982
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-9
	1 row in set (0.00 sec)

	mysql> SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	Query OK, 0 rows affected (0.00 sec)

																							
																		mysql> delete from t where id=1;
																		root@localhost [zst]>show master status\G;
																		*************************** 1. row ***************************
																					 File: mysql-bin.000002
																				 Position: 1243
																			 Binlog_Do_DB: 
																		 Binlog_Ignore_DB: 
																		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-10
																		1 row in set (0.00 sec)
																		
	mysql> START TRANSACTION WITH CONSISTENT SNAPSHOT;
	Query OK, 0 rows affected (0.00 sec)
																		
																		mysql> delete from t where id=2;
																		Query OK, 1 row affected (0.01 sec)

																		mysql> show master status\G;
																		*************************** 1. row ***************************
																					 File: mysql-bin.000002
																				 Position: 1504
																			 Binlog_Do_DB: 
																		 Binlog_Ignore_DB: 
																		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-11
																		1 row in set (0.00 sec)
																			
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000002
			 Position: 1504
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-11
	1 row in set (0.00 sec)
	
	
4. 小结
	通过实验可以看到, 执行 "SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	START TRANSACTION WITH CONSISTENT SNAPSHOT ;" , 如果期间有事务做写操作, 是获取不到一致性的 binlog position 位点信息.
	
	
	