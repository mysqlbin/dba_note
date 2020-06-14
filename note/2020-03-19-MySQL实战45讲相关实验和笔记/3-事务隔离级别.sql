

隔离性与隔离级别:

SQL 标准的事务隔离级别包括：
	读未提交（read uncommitted）、读提交（read committed）、可重复读（repeatable read）和串行化（serializable ）。

	
举例说明事务隔离级别:

	假设数据表 T 中只有一列，其中一行的值为 1，下面是按照时间顺序执行两个事务的行为。

	mysql> create table t(c int) engine=InnoDB;
	insert into t(c) values(1);



	事务A            事务B
	启动事务         启动事务
	查询得到值1  
					
					 查询得到值1
					 将1改成2
					 
	查询得到值V1
					 提交事务B
	查询得到值V2
	提交事务A
	查询得到值V3



	session A              session B
	begin;                 begin;

	select * from t;
						   update t set c=2;
						   
	select * from t;			
						   commit;
						   
	select * from t;			

	commit;

	select * from t;			


1. 可重复读隔离级别

	root@localhost [zst]>select @@tx_isolation;
	+-----------------+
	| @@tx_isolation  |
	+-----------------+
	| REPEATABLE-READ |
	+-----------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| REPEATABLE-READ       |
	+-----------------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| REPEATABLE-READ        |
	+------------------------+
	1 row in set (0.00 sec)



	session A                                                       session B
	root@localhost [zst]>begin; 
	Query OK, 0 rows affected (0.00 sec)
																	root@localhost [zst]>begin; 
																	Query OK, 0 rows affected (0.00 sec)
	root@localhost [zst]>select * from t;
	+------+
	| c    |
	+------+
	|    1 |
	+------+
	1 row in set (0.00 sec)

																	root@localhost [zst]>update t set c=2;
																	Query OK, 1 row affected (0.01 sec)
																	Rows matched: 1  Changed: 1  Warnings: 0

	root@localhost [zst]>select * from t;
	+------+
	| c    |
	+------+
	|    1 |
	+------+
	1 row in set (0.00 sec)

																	root@localhost [zst]>commit;
																	Query OK, 0 rows affected (0.00 sec)

	root@localhost [zst]>select * from t;
	+------+
	| c    |
	+------+
	|    1 |
	+------+
	1 row in set (0.00 sec)

	root@localhost [zst]>commit;
	Query OK, 0 rows affected (0.00 sec)

	root@localhost [zst]>select * from t;
	+------+
	| c    |
	+------+
	|    2 |
	+------+




2. 读已提交隔离级别
	
	root@localhost [zst]>select @@tx_isolation;
	+----------------+
	| @@tx_isolation |
	+----------------+
	| READ-COMMITTED |
	+----------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| READ-COMMITTED        |
	+-----------------------+
	1 row in set (0.00 sec)

	root@localhost [zst]>select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+
	1 row in set (0.00 sec)



	session A                                                       session B

	root@localhost [zst]>begin;
	Query OK, 0 rows affected (0.00 sec)

																	root@localhost [zst]>begin;
																	Query OK, 0 rows affected (0.00 sec)


	root@localhost [zst]>select * from t;
	+------+
	| c    |
	+------+
	|    1 |
	+------+
	1 row in set (0.52 sec)
		
																	root@localhost [zst]>update t set c=2;
																	Query OK, 1 row affected (0.01 sec)
																	Rows matched: 1  Changed: 1  Warnings: 0
																	
	root@localhost [zst]>select * from t;
	+------+
	| c    |
	+------+
	|    1 |
	+------+
	1 row in set (0.00 sec)
	
																	root@localhost [zst]>commit;
																	Query OK, 0 rows affected (0.00 sec)

	root@localhost [zst]>select * from t;
	+------+
	| c    |
	+------+
	|    2 |
	+------+
	1 row in set (0.00 sec)

	root@localhost [zst]>commit;
	Query OK, 0 rows affected (0.00 sec)

	root@localhost [zst]>select * from t;
	+------+
	| c    |
	+------+
	|    2 |
	+------+
	1 row in set (0.00 sec)





