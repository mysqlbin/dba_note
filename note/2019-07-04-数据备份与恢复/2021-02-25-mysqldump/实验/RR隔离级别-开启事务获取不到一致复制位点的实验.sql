
1. 实验目的
2. 实验步骤
3. 实验详情
4. 小结

1. 实验目的:
	验证 执行"SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */;" 之后能否获取到一致性的binlog position位点信息

2. 实验步骤
	SESSION  A                                                         SESSION B
	select * from t1 where id=1;
	show master status\G;
	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
																		delete from t1 where id=1;
																		show master status\G;
	START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */;
																		delete from t1 where id=2;	
																		show master status\G;
	show master status\G;

####### 去掉 /*!40100 WITH CONSISTENT SNAPSHOT */; 注释试试


3. 实验详情
	SESSION A                                                           SESSION B
	mysql> select * from t1 where id=1;
	+----+------+------+
	| id | a    | b    |
	+----+------+------+
	|  1 | 1000 |    1 |
	+----+------+------+
	1 row in set (0.00 sec)

	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000083
			 Position: 14099692
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: b453f45b-ba9f-11e8-a29c-080027eb50c1:1-7273079
	1 row in set (0.00 sec)

	mysql> SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	Query OK, 0 rows affected (0.00 sec)

																							
																		mysql> delete from t1 where id=1;
																		mysql> show master status\G;
																		*************************** 1. row ***************************
																					 File: mysql-bin.000083
																				 Position: 14099961
																			 Binlog_Do_DB: 
																		 Binlog_Ignore_DB: 
																		Executed_Gtid_Set: b453f45b-ba9f-11e8-a29c-080027eb50c1:1-7273080
																		1 row in set (0.00 sec)
																		
	mysql> START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */;
	Query OK, 0 rows affected (0.00 sec)
																		
																		mysql> delete from t1 where id=2;
																		Query OK, 1 row affected (0.01 sec)

																		mysql> show master status\G;
																		*************************** 1. row ***************************
																					 File: mysql-bin.000083
																				 Position: 14100230
																			 Binlog_Do_DB: 
																		 Binlog_Ignore_DB: 
																		Executed_Gtid_Set: b453f45b-ba9f-11e8-a29c-080027eb50c1:1-7273081
																		1 row in set (0.00 sec)
																			
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000083
			 Position: 14100230
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: b453f45b-ba9f-11e8-a29c-080027eb50c1:1-7273081
	1 row in set (0.00 sec)

4. 小结
	通过实验可以看到, 执行 "SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */;" , 如果期间有事务做写操作, 是获取不到一致性的binlog position位点信息.
	
	
	