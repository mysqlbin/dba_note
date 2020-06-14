

1. 初始化表结构和数据 
2. 实验1
3. 实验2				

1. 初始化表结构和数据 
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
	
	
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');
	
	root@mysqldb 13:32:  [sbtest]> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (0.00 sec)
		
	select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.12    |
	+-----------+
	1 row in set (0.07 sec)

	root@mysqldb 15:13:  [(none)]> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)

2. 实验1

	ALTER table t auto_increment=6;
	session A           session B

	begin;	            
	mysql> INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
	Query OK, 1 row affected (0.00 sec)
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	|  6 |    6 |    6 |
	+----+------+------+
	6 rows in set (0.00 sec)
	T1时刻
						begin;  
						mysql> SELECT `id`, `c`, `d` from t WHERE ((`id` >= '4')) AND ((`id` <= '5')) LOCK IN SHARE MODE;	 
						(Blocked)
	T2时刻
		
		
	T1时刻
	
		root@mysqldb 19:12:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| ENGINE_LOCK_ID | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
		+----------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| 1594:1059      |                  1594 |        65 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
		+----------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		1 row in set (0.00 sec)
		
		
	T2时刻	
	
		---TRANSACTION 1594, ACTIVE 446 sec
		2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
		MySQL thread id 17, OS thread handle 140146535069440, query id 94 localhost root
		TABLE LOCK table `sbtest`.`t` trx id 1594 lock mode IX
		RECORD LOCKS space id 2 page no 4 n bits 80 index PRIMARY of table `sbtest`.`t` trx id 1594 lock_mode X locks rec but not gap
		Record lock, heap no 7 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000000006; asc         ;;
		 1: len 6; hex 00000000063a; asc      :;;
		 2: len 7; hex 810000008b0110; asc        ;;
		 3: len 4; hex 80000006; asc     ;;
		 4: len 4; hex 80000006; asc     ;;

		
		root@mysqldb 19:34:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| ENGINE_LOCK_ID        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
		+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		| 1594:1059             |                  1594 |        65 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL      |
		
		| 1594:2:4:7            |                  1594 |        66 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 6         |
		
		| 421624251677432:1059  |       421624251677432 |        66 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL      |
		| 421624251677432:2:4:5 |       421624251677432 |        66 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 4         |
		| 421624251677432:2:4:6 |       421624251677432 |        66 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 5         |
		
		| 421624251677432:2:4:7 |       421624251677432 |        66 | t           | PRIMARY    | RECORD    | S         | WAITING     | 6         |
		+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
		6 rows in set (0.00 sec)
	
		thread_id看起来也很奇怪。
		
			session A 持有 id=6 的行锁
			session B 是当前读，想持有 id=6 的行锁，处于等待状态中
			
		mysql> select * from performance_schema.data_lock_waits;
		+--------+---------------------------+----------------------------------+----------------------+---------------------+----------------------------------+-------------------------+--------------------------------+--------------------+-------------------+--------------------------------+
		| ENGINE | REQUESTING_ENGINE_LOCK_ID | REQUESTING_ENGINE_TRANSACTION_ID | REQUESTING_THREAD_ID | REQUESTING_EVENT_ID | REQUESTING_OBJECT_INSTANCE_BEGIN | BLOCKING_ENGINE_LOCK_ID | BLOCKING_ENGINE_TRANSACTION_ID | BLOCKING_THREAD_ID | BLOCKING_EVENT_ID | BLOCKING_OBJECT_INSTANCE_BEGIN |
		+--------+---------------------------+----------------------------------+----------------------+---------------------+----------------------------------+-------------------------+--------------------------------+--------------------+-------------------+--------------------------------+
		| INNODB | 421624251677432:2:4:7     |                  421624251677432 |                   66 |                   8 |                  140149279202752 | 1594:2:4:7              |                           1594 |                 66 |                 4 |                140149279196456 |
		+--------+---------------------------+----------------------------------+----------------------+---------------------+----------------------------------+-------------------------+--------------------------------+--------------------+-------------------+--------------------------------+


	
	session B先执行， session A不会被阻塞，如下所示
	
		session A           session B
		begin;				
		SELECT `id`, `c`, `d` from t WHERE ((`id` >= '4')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  4 |    4 |    4 |
		|  5 |    5 |    5 |
		+----+------+------+
		2 rows in set (0.00 sec)
		
							begin;
							insert into t(c,d) values(6,6);
							(Query OK)
							1 row in set (0.00 sec)	
							
							mysql> select * from t;
							+----+------+------+
							| id | c    | d    |
							+----+------+------+
							|  1 |    1 |    1 |
							|  2 |    2 |    2 |
							|  3 |    3 |    3 |
							|  4 |    4 |    4 |
							|  5 |    5 |    5 |
							|  6 |    6 |    6 |
							+----+------+------+
							6 rows in set (0.00 sec)

		
		session A 持有的锁
			root@mysqldb 22:05:  [sbtest]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			| ENGINE_LOCK_ID        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
			+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			| 421624251676512:1059  |       421624251676512 |        69 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL      |
			| 421624251676512:2:4:5 |       421624251676512 |        69 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 4         |
			| 421624251676512:2:4:6 |       421624251676512 |        69 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 5         |
			+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
			3 rows in set (0.10 sec)
		
3. 实验2				
	session A           session B

	begin;	         
	SELECT `id`, `c`, `d` from t WHERE ((`id` >= '4')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	2 rows in set (0.03 sec)

	T1
						begin;
						INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
						Query OK, 1 row affected (0.00 sec)
											  
										
	root@mysqldb 15:13:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| ENGINE_LOCK_ID        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA |
	+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	| 421624251676512:1059  |       421624251676512 |        59 | t           | NULL       | TABLE     | IS        | GRANTED     | NULL      |
	| 421624251676512:2:4:5 |       421624251676512 |        59 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 4         |
	| 421624251676512:2:4:6 |       421624251676512 |        59 | t           | PRIMARY    | RECORD    | S         | GRANTED     | 5         |
	+-----------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+-----------+
	3 rows in set (0.01 sec)



