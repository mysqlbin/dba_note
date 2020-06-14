
目录
1. 初始表结构和数据初始化
2. 现象和我的问题
2. MySQL 8.0.17版本
	2.1 事务隔离级别为RC读已提交
	2.2 事务隔离级别为RR可重复读
3. MySQL 8.0.18版本
	3.1 事务隔离级别为RC读已提交
	3.2 事务隔离级别为RR可重复读

1. 初始表结构和数据初始化
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');
	
2. 现象和我的问题
	
	事务的执行次序
		session A           session B
		begin;	            
		INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  
		
							begin;	  
							SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
							
	现象:
		在MySQL 8.0.17版本和MySQL 8.0.17之前的版本中, 在 RC读已提交和RR可重复读隔离级别下, session B都会被阻塞.
		在MySQL 8.0.18版本和MySQL 8.0.18以上的版本中, 在 RC读已提交隔离级别下, session B会被阻塞, 在RR可重复读级别下, session B不会被阻塞.

			
	我的问题:
		1. 为什么在MySQL 8.0.18版本和MySQL 8.0.18以上的版本中, 在RR可重复读级别下, session B不会被阻塞.
			答: 8.0.18或者以上的版本中，对加锁规则有一个优化: 在RR可重复读级别下，唯一索引上的范围查询，不再需要访问到不满足条件的第一个值为止。
			
		2. 在RC读已提交隔离级别下, session B 为什么会被阻塞.
		
		
2. MySQL 8.0.17版本
	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.17    |
	+-----------+
	1 row in set (0.00 sec)
	
2.1 事务隔离级别为RC读已提交
	

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	事务的执行次序
	session A           session B

	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
						begin;	  
						SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Blocked)
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140412282083920:1059:140412211753048  |                  4343 |        65 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140412282083920:2:4:7:140412211750008 |                  4343 |        66 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 6         |
	| 140412282084784:1059:140412211759000  |       421887258795440 |        66 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140412282084784:2:4:2:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140412282084784:2:4:3:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140412282084784:2:4:4:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140412282084784:2:4:5:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140412282084784:2:4:6:140412211756072 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 140412282084784:2:4:7:140412211756416 |       421887258795440 |        66 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 6         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)

	session A 持有 id=6 的行锁
	session B 是当前读，想持有 id=6 的行锁，处于等待状态中
			
	
2.2 事务隔离级别为RR可重复读

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	事务的执行次序
	session A           session B

	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
						begin;	  
						SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Blocked)
	
	通过 performance_schema.data_locks 视图查看锁数据详情	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140077984447920:1059:140077875398552  |                  1588 |        62 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140077984447920:2:4:7:140077875395624 |                  1588 |        60 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 6         |
	| 140077984447056:1059:140077875392600  |       421552961157712 |        60 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140077984447056:2:4:2:140077875389560 |       421552961157712 |        60 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140077984447056:2:4:3:140077875389904 |       421552961157712 |        60 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 2         |
	| 140077984447056:2:4:4:140077875389904 |       421552961157712 |        60 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 3         |
	| 140077984447056:2:4:5:140077875389904 |       421552961157712 |        60 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4         |
	| 140077984447056:2:4:6:140077875389904 |       421552961157712 |        60 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 5         |
	| 140077984447056:2:4:7:140077875390248 |       421552961157712 |        60 | t           | PRIMARY    | RECORD    | S             | WAITING     | 6         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.01 sec)
	
	session A 持有 id=6 的行锁
	session B 是当前读，想持有 id=6 的行锁，处于等待状态中
			
	
3. MySQL 8.0.18版本

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)
	
3.1 事务隔离级别为RC读已提交

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	事务的执行次序
	session A           session B

	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');
	Query OK, 1 row affected (0.00 sec)	
						begin;	  
						SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Blocked, 被阻塞)
						
									
	通过 performance_schema.data_locks 视图查看锁数据详情					
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760522344:1338:140570655781544    |               1005113 |        66 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140570760522344:281:4:7:140570655778504 |               1005113 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 6         |
	| 140570760523216:1338:140570655787496    |       422045737233872 |        67 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760523216:281:4:2:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140570760523216:281:4:3:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140570760523216:281:4:4:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760523216:281:4:5:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760523216:281:4:6:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 140570760523216:281:4:7:140570655784912 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 6         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)
	
	session A 持有 id=6 的行锁
	session B 是当前读，想持有 id=6 的行锁，处于等待状态中
	
		
3.2 事务隔离级别为RR可重复读

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	
	session A           session B
	
	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
	Query OK, 1 row affected (0.00 sec)
	
						begin;  
						SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Query OK, 不会被阻塞)
						
						
						