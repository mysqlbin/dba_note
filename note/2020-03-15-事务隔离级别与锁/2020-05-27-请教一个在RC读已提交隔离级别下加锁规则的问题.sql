
目录
1. 初始表结构和数据初始化
2. 现象和我的问题
3. MySQL 8.0.17版本
	3.1 事务隔离级别为RC读已提交
4. MySQL 8.0.18版本
	4.1 事务隔离级别为RC读已提交

	
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
		在MySQL 8.0.17版本和MySQL 8.0.18版本中, 在 RC读已提交隔离级别下, session B都会被阻塞.
		
		这个现象的实验在 '3.1 事务隔离级别为RC读已提交' 和 '4.1 事务隔离级别为RC读已提交' 中.
		
	我的问题:
		
		在RC读已提交隔离级别下, session B 为什么会被阻塞？
		
		理解了，参考笔记 《2020-05-27-证明RC隔离级别下先加锁再退化释放锁的实验.sql》
		
	姜少华的解答
		1.insert的通过自增加的隐式锁       
		2.第二个语句是锁的过程实际上是id<=5的下一条记录也就是这个页的最大记录（如果这个在RC级别下没有被锁，则会立即释放）
		举个例子  id 1，3，5   
		在RC级别下 select * from table where id<=3 实际上加锁的过程是1 3 5(这个随后释放掉)   最终加锁1 3


3. MySQL 8.0.17版本
	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.17    |
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
	session B 是当前读，想持有 id=6 的行锁，处于等待状态中。
			
4. MySQL 8.0.18版本

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)
	
4.1 事务隔离级别为RC读已提交

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
	session B 是当前读，想持有 id=6 的行锁，处于等待状态中。
	
