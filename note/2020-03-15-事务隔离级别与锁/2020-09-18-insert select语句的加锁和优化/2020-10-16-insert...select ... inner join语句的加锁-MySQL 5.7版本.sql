

1. 初始化表结构和数据
2. RC隔离级别
3. RR隔离级别
	3.1 SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED
	3.2 初始化新的表结构和数据
	3.3 SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED
	3.4 使用RR隔离级别
4. 小结
5. 相关参考
	
1. 初始化表结构和数据

	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
	
	CREATE TABLE `t1` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
	
	CREATE TABLE `_t_new` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  `CreateTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`) USING BTREE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('5', '5', '5');

	INSERT INTO `t1` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t1` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `t1` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `t1` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `t1` (`id`, `c`, `d`) VALUES ('5', '5', '5');
	
	mysql> select * from t;
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
	
	mysql> select * from t1;
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


	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

2. RC隔离级别
	
	mysql> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| READ-COMMITTED        |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	mysql>  select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+
	1 row in set, 1 warning (0.00 sec)


	事务的执行次序	
	session A             session B            
	begin;
	insert into _t_new(id,c,d) select t.id,t.c,t.d from t inner join t1 on t.id=t1.id;
	Query OK, 5 rows affected (0.00 sec)
	Records: 5  Duplicates: 0  Warnings: 0

						  begin;
						  delete from t1 where id=1;
						  (Query OK)
						  
							mysql> select * from t1;
							+----+------+------+
							| id | c    | d    |
							+----+------+------+
							|  2 |    2 |    2 |
							|  3 |    3 |    3 |
							|  4 |    4 |    4 |
							|  5 |    5 |    5 |
							+----+------+------+
							4 rows in set (0.00 sec)

				  
	
	

					  
3. RR隔离级别

	
	3.1 SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED
	
		mysql> select @@global.tx_isolation;
		+-----------------------+
		| @@global.tx_isolation |
		+-----------------------+
		| REPEATABLE-READ       |
		+-----------------------+
		1 row in set, 1 warning (0.00 sec)

		mysql> select @@session.tx_isolation;
		+------------------------+
		| @@session.tx_isolation |
		+------------------------+
		| REPEATABLE-READ        |
		+------------------------+
		1 row in set, 1 warning (0.00 sec)

			
		session A             session B 
		SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
		begin;
		insert into _t_new(id,c,d) select t.id,t.c,t.d from t inner join t1 on t.id=t1.id;
		Query OK, 5 rows affected (0.00 sec)
		Records: 5  Duplicates: 0  Warnings: 0

							  begin;
							  delete from t1 where id=1;
							  Query OK, 1 row affected (0.00 sec)

							mysql> select * from t1;
							+----+------+------+
							| id | c    | d    |
							+----+------+------+
							|  2 |    2 |    2 |
							|  3 |    3 |    3 |
							|  4 |    4 |    4 |
							|  5 |    5 |    5 |
							+----+------+------+
							4 rows in set (0.00 sec)
		
	
	
	3.2 初始化新的表结构和数据
	
		DROP TABLE IF EXISTS `t`;
		CREATE TABLE `t` (
			`id` BIGINT (11) NOT NULL AUTO_INCREMENT,
			`c` INT (11) DEFAULT NULL,
			`d` INT (11) DEFAULT NULL,
			PRIMARY KEY (`id`)
		) ENGINE = INNODB DEFAULT CHARSET = utf8mb4;
		
		DROP TABLE IF EXISTS `t1`;
		CREATE TABLE `t1` (
			`id` BIGINT (11) NOT NULL AUTO_INCREMENT,
			`c` INT (11) DEFAULT NULL,
			`d` INT (11) DEFAULT NULL,
			PRIMARY KEY (`id`)
		) ENGINE = INNODB DEFAULT CHARSET = utf8mb4;
		
		DROP TABLE IF EXISTS `t_new`;
		CREATE TABLE `t_new` (
			`id` BIGINT (11) NOT NULL AUTO_INCREMENT,
			`c` INT (11) DEFAULT NULL,
			`d` INT (11) DEFAULT NULL,
			PRIMARY KEY (`id`)
		) ENGINE = INNODB DEFAULT CHARSET = utf8mb4;

		DROP PROCEDURE IF EXISTS `test_data`;
		DELIMITER;;
		CREATE DEFINER = `root`@`localhost` PROCEDURE `test_data` ()
		BEGIN

		DECLARE i INT;
		SET i = 1;

			START TRANSACTION;
			WHILE (i <= 500000) DO
				INSERT INTO t (c, d) VALUES(i, i);
				INSERT INTO t1 (c, d) VALUES(i, i);
				SET i = i + 1;
			END
			WHILE;
			COMMIT;

		END;;

		DELIMITER;

		CALL test_data ();
	
	
	3.3 SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED
	
		session A             session B 
		
		SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
		mysql> select @@session.tx_isolation;
		+------------------------+
		| @@session.tx_isolation |
		+------------------------+
		| READ-COMMITTED         |
		+------------------------+
		1 row in set, 1 warning (0.00 sec)

		insert into _t_new(id,c,d) select t.id,t.c,t.d from t inner join t1 on t.id=t1.id;

							  begin;
							  delete from t1 where id=1;
							  Query OK, 1 row affected (0.00 sec)
							  
		
		
		小结：
			在RR隔离级别执行SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; 之后，接下来不需要显示声明事务也可以使用READ COMMITTED隔离级别。
			
	-----------------------------------------------------------------------------------
	
	3.4 使用RR隔离级别
	
		session A             session B 
		
		mysql> select @@session.tx_isolation;
		+------------------------+
		| @@session.tx_isolation |
		+------------------------+
		| REPEATABLE-READ        |
		+------------------------+
		1 row in set, 1 warning (0.00 sec)

		
		insert into _t_new(id,c,d) select t.id,t.c,t.d from t inner join t1 on t.id=t1.id;

							  begin;
							  delete from t1 where id=1;
							  (Blocked)
		
		select * from information_schema.innodb_trx\G;
		select * from information_schema.innodb_locks\G;
		select * from information_schema.innodb_lock_waits\G;
		SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;

		
		mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 3943
						 trx_state: LOCK WAIT
					   trx_started: 2020-09-30 03:23:18
			 trx_requested_lock_id: 3943:34:4:2
				  trx_wait_started: 2020-09-30 03:23:18
						trx_weight: 2
			   trx_mysql_thread_id: 20
						 trx_query: delete from t1 where id=1
			   trx_operation_state: starting index read
				 trx_tables_in_use: 1
				 trx_tables_locked: 1
				  trx_lock_structs: 2
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 1
				 trx_rows_modified: 0
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		*************************** 2. row ***************************
							trx_id: 3938
						 trx_state: RUNNING
					   trx_started: 2020-09-30 03:23:17
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 502343
			   trx_mysql_thread_id: 15
						 trx_query: insert into _t_new(id,c,d) select t.id,t.c,t.d from t inner join t1 on t.id=t1.id
			   trx_operation_state: committing
				 trx_tables_in_use: 3
				 trx_tables_locked: 4
				  trx_lock_structs: 2343
			 trx_lock_memory_bytes: 336080
				   trx_rows_locked: 1001170
				 trx_rows_modified: 500000
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		2 rows in set (0.33 sec)


		mysql> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
			lock_id: 3943:34:4:2
		lock_trx_id: 3943
		  lock_mode: X
		  lock_type: RECORD
		 lock_table: `test_db`.`t1`
		 lock_index: PRIMARY
		 lock_space: 34
		  lock_page: 4
		   lock_rec: 2
		  lock_data: 1
		*************************** 2. row ***************************
			lock_id: 3938:34:4:2
		lock_trx_id: 3938
		  lock_mode: S
		  lock_type: RECORD
		 lock_table: `test_db`.`t1`
		 lock_index: PRIMARY
		 lock_space: 34
		  lock_page: 4
		   lock_rec: 2
		  lock_data: 1
		2 rows in set, 1 warning (0.00 sec)


		mysql> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 3943
		requested_lock_id: 3943:34:4:2
		  blocking_trx_id: 3938
		 blocking_lock_id: 3938:34:4:2
		1 row in set, 1 warning (0.00 sec)


		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+---------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query             | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+---------------------------+-------------------+--------------------+
		| PRIMARY      | RECORD      | delete from t1 where id=1 | X                 | S                  |
		+--------------+-------------+---------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.20 sec)

4. 小结
	RC隔离级别的 insert ... select ... t 语句,默认对 t表的数据不加锁
	RR隔离级别的 insert ... select ... t 语句,默认对 t表的数据加共享锁.
	在RR隔离级别执行SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; 之后，接下来不需要显示声明事务也可以使用COMMITTED隔离级别。
	
5. 相关参考
	《21-RR行锁-为什么只改一行的语句，锁这么多.sql》
	《21-8.0.18版本下做实验.sql》



