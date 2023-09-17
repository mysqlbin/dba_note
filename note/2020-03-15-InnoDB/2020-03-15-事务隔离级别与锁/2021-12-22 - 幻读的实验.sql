

1. 初始化表结构和数据
2. READ-COMMITTED 下的二级索引
	2.1 for update + insert
	2.2 for update + delete
	2.3 select + insert 
	2.4 select + delete 
	
3. REPEATABLE-READ下的二级索引
4. REPEATABLE-READ下的主键索引
5. 小结


1. 初始化表结构和数据
	
	DROP TABLE IF EXISTS `t`;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  3 |    3 |    3 |
	|  5 |    5 |    5 |
	+----+------+------+
	3 rows in set (0.01 sec)


2. READ-COMMITTED 下的二级索引

2.1 for update + insert
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	mysql> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| READ-COMMITTED                 |
	+--------------------------------+
	1 row in set (0.00 sec)



	session A                      session B
	begin;
	select * from t where c=3 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)
		
									
									INSERT INTO `t` (`c`, `d`) VALUES ('3', '6');
									Query OK, 1 row affected (0.05 sec)
									
									
	select * from t where c=3 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	|  6 |    3 |    6 |
	+----+------+------+
	2 rows in set (0.00 sec)
									
	行锁只能锁住行记录，无法锁住记录之间的空隙，如果别的事务有数据写入，那么就会读取到多余的数据。
	
	
2.2 for update + delete:
	session A                      session B
	begin;
	select * from t where c=3 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)
									delete * from t where c=3;
									(Blocked)


2.3 select + insert 

	session A                      session B
	begin;
	select * from t where c=3;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)
		
									
									INSERT INTO `t` (`c`, `d`) VALUES ('3', '6');
									Query OK, 1 row affected (0.05 sec)
									
	select * from t where c=3;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	|  6 |    3 |    6 |  
	+----+------+------+
	2 rows in set (0.00 sec)
	

2.4 select + delete 

	session A                      session B
	begin;
	select * from t where c=3;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)
		
									
									delete * from t where c=3;
									Query OK, 1 row affected (0.05 sec)
									
	select * from t where c=3;
	0 rows in set (0.00 sec)
	
	
	
	
	
3. REPEATABLE-READ下的二级索引
	
	mysql> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
	+--------------------------------+
	1 row in set (0.00 sec)
			
	
	
3.1 不指定自增主键

	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  3 |    3 |    3 |
	|  5 |    5 |    5 |
	+----+------+------+
	3 rows in set (0.01 sec)
	
	
	session A                      session B
	begin;
	select * from t where c=3 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)
		
									
									INSERT INTO `t` (`c`, `d`) VALUES ('3', '6');
									(Blocked)


		
	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;									
								
										
	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 27244310:45590:4:4
	lock_trx_id: 27244310
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: c
	 lock_space: 45590
	  lock_page: 4
	   lock_rec: 4
	  lock_data: 5, 5
	*************************** 2. row ***************************
		lock_id: 27244309:45590:4:4
	lock_trx_id: 27244309
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: c
	 lock_space: 45590
	  lock_page: 4
	   lock_rec: 4
	  lock_data: 5, 5
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 27244310
	requested_lock_id: 27244310:45590:4:4
	  blocking_trx_id: 27244309
	 blocking_lock_id: 27244309:45590:4:4
	1 row in set, 1 warning (0.00 sec)



	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+----------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                                | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+----------------------------------------------+-------------------+--------------------+
	| c            | RECORD      | INSERT INTO `t` (`c`, `d`) VALUES ('3', '6') | X,GAP             | X,GAP              |
	+--------------+-------------+----------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.26 sec)


	
	session A 的加锁范围：
		c: next-key lock: (1,3)
		primary: record lock: id=3
		c: gap lock: (3, 5)
		
	session B 想要往二级索引c中插入这一行记录：c=3, id=6
	
	二级索引c的索引结构
		mysql> select c,id from test_db. t order by c,id;
		+------+----+
		| c    | id |
		+------+----+
		|    1 |  1 |
		|    3 |  3 |
		-- 会落到这里，所以会被阻塞。同时明白了为什么需要对 二级索引c (3, 5) 的这个范围加间隙锁。
		|    5 |  5 |
		+------+----+
		3 rows in set (0.03 sec)

		

3.2 指定自增主键
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  3 |    3 |    3 |
	|  5 |    5 |    5 |
	+----+------+------+
	3 rows in set (0.01 sec)
	

	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;		

	
	session A                      session B
	begin;
	select * from t where c=3 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)
		
									
									INSERT INTO `t` (`id`, `c`, `d`) VALUES (2, '3', '2');
									(Blocked)


	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 27244312:45590:4:3
	lock_trx_id: 27244312
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: c
	 lock_space: 45590
	  lock_page: 4
	   lock_rec: 3
	  lock_data: 3, 3
	*************************** 2. row ***************************
		lock_id: 27244309:45590:4:3
	lock_trx_id: 27244309
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: c
	 lock_space: 45590
	  lock_page: 4
	   lock_rec: 3
	  lock_data: 3, 3
	2 rows in set, 1 warning (0.00 sec)



	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 27244312
	requested_lock_id: 27244312:45590:4:3
	  blocking_trx_id: 27244309
	 blocking_lock_id: 27244309:45590:4:3
	1 row in set, 1 warning (0.00 sec)


	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-------------------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                                         | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-------------------------------------------------------+-------------------+--------------------+
	| c            | RECORD      | INSERT INTO `t` (`id`, `c`, `d`) VALUES (2, '3', '2') | X,GAP             | X                  |
	+--------------+-------------+-------------------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.00 sec)

	
	session A 的加锁范围：
		c: next-key lock: (1,3)
		primary: record lock: id=3
		c: gap lock: (3, 5)
		
	session B 想要往二级索引c中插入这一行记录：c=3, id=2
	
	二级索引c的索引结构
		mysql> select c,id from test_db. t order by c,id;
		+------+----+
		| c    | id |
		+------+----+
		|    1 |  1 |
		-- 会落到这里，所以会被阻塞。同时明白了为什么需要对 二级索引c (1, 3) 的这个范围加间隙锁。
		|    3 |  3 |
		|    5 |  5 |
		+------+----+
		3 rows in set (0.03 sec)


4. REPEATABLE-READ下的主键索引

	mysql> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
	+--------------------------------+
	1 row in set (0.00 sec)


	DROP TABLE IF EXISTS `t`;

	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;

	insert into t values(0,0,0),(5,5,5),
	(10,10,10),(15,15,15),(20,20,20),(25,25,25);




	session A                      session B
	begin;
	select * from t where id=9 for update;
	Empty set (0.00 sec)

		
									
									insert into t values(9,9,9);
									(Blocked)
									

	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;									
																	
										
	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 27240755:45578:3:4
	lock_trx_id: 27240755
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 45578
	  lock_page: 3
	   lock_rec: 4
	  lock_data: 10
	*************************** 2. row ***************************
		lock_id: 27240754:45578:3:4
	lock_trx_id: 27240754
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 45578
	  lock_page: 3
	   lock_rec: 4
	  lock_data: 10
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 27240755
	requested_lock_id: 27240755:45578:3:4
	  blocking_trx_id: 27240754
	 blocking_lock_id: 27240754:45578:3:4
	1 row in set, 1 warning (0.00 sec)


	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | insert into t values(9,9,9) | X,GAP             | X,GAP              |
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.00 sec)
	
	
	
5. 小结

	
	幻读针对 insert，事务内相同的两次查询，后一次看到了前一次没有看到的行记录。
	
	解决幻读的方式：使用RR可重复读事务隔离级别，通过 gap lock 阻塞 insert。
	
	-------------------------------------------------------------------------------------
	
	session A 的加锁范围：
		c: next-key lock: (1,3)
		primary: record lock: id=3
		c: gap lock: (3, 5)
		
		
		
	session B 想要往二级索引c中插入这一行记录：c=3, id=6
	
	二级索引c的索引结构
		mysql> select c,id from test_db. t order by c,id;
		+------+----+
		| c    | id |
		+------+----+
		|    1 |  1 |
		|    3 |  3 |
		-- 会落到这里，所以会被阻塞。同时明白了为什么需要对 二级索引c (3, 5) 的这个范围加间隙锁。
		|    5 |  5 |
		+------+----+
		3 rows in set (0.03 sec)
	
	
	session B 想要往二级索引c中插入这一行记录：c=3, id=2
	
	二级索引c的索引结构
		mysql> select c,id from test_db. t order by c,id;
		+------+----+
		| c    | id |
		+------+----+
		|    1 |  1 |
		-- 会落到这里，所以会被阻塞。同时明白了为什么需要对 二级索引c (1, 3) 的这个范围加间隙锁。
		|    3 |  3 |
		|    5 |  5 |
		+------+----+
		3 rows in set (0.03 sec)
	
	
	
	

思考：所有的 gap lock 都是为了防止幻读吗









	
