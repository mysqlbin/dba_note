

1. 初始化表结构和数据
2. READ-COMMITTED 下的二级索引
3. REPEATABLE-READ下的二级索引
4. REPEATABLE-READ下的主键索引


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
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');




2. READ-COMMITTED 下的二级索引

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
								
								
3. REPEATABLE-READ下的二级索引
	
	mysql> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
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


	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;									
								
									
	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 27240731:45577:4:5
	lock_trx_id: 27240731
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: c
	 lock_space: 45577
	  lock_page: 4
	   lock_rec: 5
	  lock_data: 4, 4
	*************************** 2. row ***************************
		lock_id: 27240726:45577:4:5
	lock_trx_id: 27240726
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: c
	 lock_space: 45577
	  lock_page: 4
	   lock_rec: 5
	  lock_data: 4, 4
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 27240731
	requested_lock_id: 27240731:45577:4:5
	  blocking_trx_id: 27240726
	 blocking_lock_id: 27240726:45577:4:5
	1 row in set, 1 warning (0.00 sec)



	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+----------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                                | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+----------------------------------------------+-------------------+--------------------+
	| c            | RECORD      | INSERT INTO `t` (`c`, `d`) VALUES ('3', '6') | X,GAP             | X,GAP              |
	+--------------+-------------+----------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.06 sec)



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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
