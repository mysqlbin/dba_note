


	
select * from information_schema.innodb_trx\G;
select * from information_schema.innodb_locks\G;
select * from information_schema.innodb_lock_waits\G;
SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;




1. 环境、初始化表结构和数据
2. RR事务隔离级别
	2.1 全量操作
	2.2 验证对驱动表的数据加读锁之一
	2.3 验证对驱动表的数据加读锁之二
	2.4 批量小部分操作
3. RC事务隔离级别
4. 小结


1. 环境、初始化表结构和数据

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	drop table  if exists `t_20201029`;
	CREATE TABLE `t_20201029` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `nPlayerID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
	  `ExtendCode` varchar(36) DEFAULT NULL COMMENT '推广码',
	  `socre` int(11) DEFAULT 0 COMMENT '积分',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	drop table  if exists `t_20201030`;
	CREATE TABLE `t_20201030` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `nPlayerID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
	  `ExtendCode` varchar(36) DEFAULT NULL COMMENT '推广码',
	  `socre` int(11) DEFAULT 0 COMMENT '积分',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('1', '1', '0', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('2', '2', '0', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('3', '3', '3', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('4', '4', '4', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('5', '5', '5', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('6', '6', '6', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('7', '7', '7', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('8', '8', '8', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('8', '8', '8', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('8', '8', '8', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('9', '9', '9', 0);
	INSERT INTO `test_db`.`t_20201029` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('10', '10', '10', 0);
	
	INSERT INTO `test_db`.`t_20201030` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('1', '1', '1', 1);
	INSERT INTO `test_db`.`t_20201030` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('2', '2', '2', 2);
	INSERT INTO `test_db`.`t_20201030` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('3', '3', '3', 3);
	INSERT INTO `test_db`.`t_20201030` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('4', '4', '4', 4);

	select * from t_20201029;
	select * from t_20201030;

	mysql> select * from t_20201029;
	+----+-----------+------------+-------+
	| ID | nPlayerID | ExtendCode | socre |
	+----+-----------+------------+-------+
	|  1 |         1 | 0          |     0 |
	|  2 |         2 | 0          |     0 |
	|  3 |         3 | 3          |     0 |
	|  4 |         4 | 4          |     0 |
	|  5 |         5 | 5          |     0 |
	|  6 |         6 | 6          |     0 |
	|  7 |         7 | 7          |     0 |
	|  8 |         8 | 8          |     0 |
	|  9 |         9 | 9          |     0 |
	| 10 |        10 | 10         |     0 |
	+----+-----------+------------+-------+
	10 rows in set (0.00 sec)
	
	mysql> select * from t_20201030;
	+----+-----------+------------+-------+
	| ID | nPlayerID | ExtendCode | socre |
	+----+-----------+------------+-------+
	|  1 |         1 | 1          |     1 |
	|  2 |         2 | 2          |     2 |
	|  3 |         3 | 3          |     3 |
	|  4 |         4 | 4          |     4 |
	+----+-----------+------------+-------+
	4 rows in set (0.01 sec)
	
	
	
	mysql> desc update t_20201029 join t_20201030 on t_20201029.ID=t_20201030.ID set t_20201029.ExtendCode=t_20201030.ExtendCode;
	+----+-------------+------------+------------+--------+---------------+---------+---------+-----------------------+------+----------+-------+
	| id | select_type | table      | partitions | type   | possible_keys | key     | key_len | ref                   | rows | filtered | Extra |
	+----+-------------+------------+------------+--------+---------------+---------+---------+-----------------------+------+----------+-------+
	|  1 | SIMPLE      | t_20201030 | NULL       | ALL    | PRIMARY       | NULL    | NULL    | NULL                  |    4 |   100.00 | NULL  |
	|  1 | UPDATE      | t_20201029 | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.t_20201030.ID |    1 |   100.00 | NULL  |
	+----+-------------+------------+------------+--------+---------------+---------+---------+-----------------------+------+----------+-------+
	2 rows in set (0.01 sec)

	-- 大事务减小事务的案例之一。

2. RR事务隔离级别

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


2.1 全量操作 

	session A                    session B
	begin;
	update t_20201029 join t_20201030 on t_20201029.ID=t_20201030.ID set t_20201029.ExtendCode=t_20201030.ExtendCode;
	Query OK, 2 rows affected (0.01 sec)
	Rows matched: 4  Changed: 2  Warnings: 0

								begin;
								update t_20201029 set socre=1 where ID=1;
								(Blocked)
								 
									
	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5530307
					 trx_state: LOCK WAIT
				   trx_started: 2020-10-29 15:08:31
		 trx_requested_lock_id: 5530307:25154:3:2
			  trx_wait_started: 2020-10-29 15:08:31
					trx_weight: 2
		   trx_mysql_thread_id: 3
					 trx_query: update t_20201029 set socre=1 where ID=1
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
						trx_id: 5530306
					 trx_state: RUNNING
				   trx_started: 2020-10-29 15:07:50
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 6
		   trx_mysql_thread_id: 4
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 2
			  trx_lock_structs: 4
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 9
			 trx_rows_modified: 2
	   trx_concurrency_tickets: 0
		   trx_isolation_level: REPEATABLE READ
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	2 rows in set (0.00 sec)

	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 5530307:25154:3:2
	lock_trx_id: 5530307
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t_20201029`
	 lock_index: PRIMARY
	 lock_space: 25154
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	*************************** 2. row ***************************
		lock_id: 5530306:25154:3:2
	lock_trx_id: 5530306
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t_20201029`
	 lock_index: PRIMARY
	 lock_space: 25154
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	2 rows in set, 1 warning (0.00 sec)

	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 5530307
	requested_lock_id: 5530307:25154:3:2
	  blocking_trx_id: 5530306
	 blocking_lock_id: 5530306:25154:3:2
	1 row in set, 1 warning (0.00 sec)

	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                            | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+------------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | update t_20201029 set socre=1 where ID=1 | X                 | X                  |
	+--------------+-------------+------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.00 sec)


2.2 验证对驱动表的数据加读锁之一
	session A                    session B
	begin;
	update t_20201029 join t_20201030 on t_20201029.nPlayerID=t_20201030.nPlayerID set t_20201029.ExtendCode=t_20201030.ExtendCode;
	Query OK, 2 rows affected (0.01 sec)
	Rows matched: 4  Changed: 2  Warnings: 0
	
									begin;
									update t_20201030 set socre=1 where ID=2;
									(Blocked)

	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5530308
					 trx_state: LOCK WAIT
				   trx_started: 2020-10-29 15:10:31
		 trx_requested_lock_id: 5530308:25155:3:3
			  trx_wait_started: 2020-10-29 15:10:31
					trx_weight: 2
		   trx_mysql_thread_id: 3
					 trx_query: update t_20201030 set socre=1 where ID=2
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
						trx_id: 5530306
					 trx_state: RUNNING
				   trx_started: 2020-10-29 15:07:50
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 6
		   trx_mysql_thread_id: 4
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 2
			  trx_lock_structs: 4
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 9
			 trx_rows_modified: 2
	   trx_concurrency_tickets: 0
		   trx_isolation_level: REPEATABLE READ
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	2 rows in set (0.00 sec)

	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 5530308:25155:3:3
	lock_trx_id: 5530308
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t_20201030`
	 lock_index: PRIMARY
	 lock_space: 25155
	  lock_page: 3
	   lock_rec: 3
	  lock_data: 2
	*************************** 2. row ***************************
		lock_id: 5530306:25155:3:3
	lock_trx_id: 5530306
	  lock_mode: S
	  lock_type: RECORD
	 lock_table: `test_db`.`t_20201030`
	 lock_index: PRIMARY
	 lock_space: 25155
	  lock_page: 3
	   lock_rec: 3
	  lock_data: 2
	2 rows in set, 1 warning (0.00 sec)

	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 5530308
	requested_lock_id: 5530308:25155:3:3
	  blocking_trx_id: 5530306
	 blocking_lock_id: 5530306:25155:3:3
	1 row in set, 1 warning (0.00 sec)
	
	
	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                            | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+------------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | update t_20201030 set socre=1 where ID=2 | X                 | S                  |
	+--------------+-------------+------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.00 sec)



2.3 验证对驱动表的数据加读锁之二

	session A                    session B
	begin;
	update t_20201029 join t_20201030 on t_20201029.ID=t_20201030.ID set t_20201029.ExtendCode=t_20201030.ExtendCode;
	Query OK, 2 rows affected (0.01 sec)
	Rows matched: 4  Changed: 2  Warnings: 0
	
								begin;
								mysql> select * from t_20201030 where ID=2 lock in share mode;
								+----+-----------+------------+-------+
								| ID | nPlayerID | ExtendCode | socre |
								+----+-----------+------------+-------+
								|  2 |         2 | 2          |     2 |
								+----+-----------+------------+-------+
								1 row in set (0.00 sec)

	

2.4 批量小部分操作
	
	
	mysql> DESC update t_20201029 join t_20201030 on t_20201029.ID=t_20201030.ID set t_20201029.ExtendCode=t_20201030.ExtendCode where t_20201029.ID between 1 and 2;
	+----+-------------+------------+------------+--------+---------------+---------+---------+-----------------------+------+----------+-------------+
	| id | select_type | table      | partitions | type   | possible_keys | key     | key_len | ref                   | rows | filtered | Extra       |
	+----+-------------+------------+------------+--------+---------------+---------+---------+-----------------------+------+----------+-------------+
	|  1 | UPDATE      | t_20201029 | NULL       | range  | PRIMARY       | PRIMARY | 4       | NULL                  |    2 |   100.00 | Using where |
	|  1 | SIMPLE      | t_20201030 | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | test_db.t_20201029.ID |    1 |   100.00 | NULL        |
	+----+-------------+------------+------------+--------+---------------+---------+---------+-----------------------+------+----------+-------------+
	2 rows in set (0.00 sec)
	
	session A                    session B
	mysql> begin;
	mysql> update t_20201029 join t_20201030 on t_20201029.ID=t_20201030.ID set t_20201029.ExtendCode=t_20201030.ExtendCode where t_20201029.ID between 1 and 2;


								begin;
								mysql> select * from t_20201029 where ID=4 lock in share mode;	
									
								+----+-----------+------------+-------+
								| ID | nPlayerID | ExtendCode | socre |
								+----+-----------+------------+-------+
								|  4 |         4 | 4          |     0 |
								+----+-----------+------------+-------+
								1 row in set (0.00 sec)

								mysql> select * from t_20201029 where ID=3 lock in share mode;
								(Blocked)



	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5531653
					 trx_state: RUNNING
				   trx_started: 2020-10-29 15:54:46
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 7
		   trx_mysql_thread_id: 5
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 2
			  trx_lock_structs: 5
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 5
			 trx_rows_modified: 2
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
						trx_id: 421783843310304
					 trx_state: LOCK WAIT
				   trx_started: 2020-10-29 15:55:10
		 trx_requested_lock_id: 421783843310304:25154:3:4
			  trx_wait_started: 2020-10-29 15:55:10
					trx_weight: 2
		   trx_mysql_thread_id: 3
					 trx_query: select * from t_20201029 where ID=3 lock in share mode
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
	2 rows in set (0.00 sec)
	
	
	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 421783843310304:25154:3:4
	lock_trx_id: 421783843310304
	  lock_mode: S
	  lock_type: RECORD
	 lock_table: `test_db`.`t_20201029`
	 lock_index: PRIMARY
	 lock_space: 25154
	  lock_page: 3
	   lock_rec: 4
	  lock_data: 3
	*************************** 2. row ***************************
		lock_id: 5531653:25154:3:4
	lock_trx_id: 5531653
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t_20201029`
	 lock_index: PRIMARY
	 lock_space: 25154
	  lock_page: 3
	   lock_rec: 4
	  lock_data: 3
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 421783843310304
	requested_lock_id: 421783843310304:25154:3:4
	  blocking_trx_id: 5531653
	 blocking_lock_id: 5531653:25154:3:4
	1 row in set, 1 warning (0.00 sec)
	
	
	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+--------------------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                                          | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+--------------------------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | select * from t_20201029 where ID=3 lock in share mode | S                 | X                  |
	+--------------+-------------+--------------------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.06 sec)


3. RC事务隔离级别
	
	mysql> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| READ-COMMITTED        |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	
	mysql> select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+
	1 row in set, 1 warning (0.00 sec)


	session A                    session B
	begin;
	update t_20201029 join t_20201030 on t_20201029.ID=t_20201030.ID set t_20201029.ExtendCode=t_20201030.ExtendCode;
	Query OK, 2 rows affected (0.01 sec)
	Rows matched: 4  Changed: 2  Warnings: 0
	
								begin;
								select * from t_20201030 where ID=2 lock in share mode;
								(Query OK)
								
	
	------------------------------------------------------------------------------------------------------------------
	
	session A                    session B
	begin;
	select * from t_20201030 where ID=2 lock in share mode;
	+----+-----------+------------+-------+
	| ID | nPlayerID | ExtendCode | socre |
	+----+-----------+------------+-------+
	|  2 |         2 | 2          |     2 |
	+----+-----------+------------+-------+
	1 row in set (0.00 sec)

	
								begin;
								update t_20201029 join t_20201030 on t_20201029.ID=t_20201030.ID set t_20201029.ExtendCode=t_20201030.ExtendCode;
								Query OK, 2 rows affected (0.00 sec)
								Rows matched: 4  Changed: 2  Warnings: 0


	-----------------------------------------------------------------------------------------------------------------
	
	session A                    session B
	begin;
	update t_20201029 join t_20201030 on t_20201029.ID=t_20201030.ID set t_20201029.ExtendCode=t_20201030.ExtendCode;
	
								begin;
								select * from t_20201029 where ID=2 lock in share mode;
								(Blocked)
	
	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5530321
					 trx_state: RUNNING
				   trx_started: 2020-10-29 15:50:26
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 6
		   trx_mysql_thread_id: 13
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 2
			  trx_lock_structs: 4
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 8
			 trx_rows_modified: 2
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	*************************** 2. row ***************************
						trx_id: 422158257527520
					 trx_state: LOCK WAIT
				   trx_started: 2020-10-29 15:51:22
		 trx_requested_lock_id: 422158257527520:25154:3:3
			  trx_wait_started: 2020-10-29 15:51:22
					trx_weight: 2
		   trx_mysql_thread_id: 14
					 trx_query: select * from t_20201029 where ID=2 lock in share mode
		   trx_operation_state: starting index read
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 2
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 1
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	2 rows in set (0.00 sec)


	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 422158257527520:25154:3:3
	lock_trx_id: 422158257527520
	  lock_mode: S
	  lock_type: RECORD
	 lock_table: `test_db`.`t_20201029`
	 lock_index: PRIMARY
	 lock_space: 25154
	  lock_page: 3
	   lock_rec: 3
	  lock_data: 2
	*************************** 2. row ***************************
		lock_id: 5530321:25154:3:3
	lock_trx_id: 5530321
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t_20201029`
	 lock_index: PRIMARY
	 lock_space: 25154
	  lock_page: 3
	   lock_rec: 3
	  lock_data: 2
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 422158257527520
	requested_lock_id: 422158257527520:25154:3:3
	  blocking_trx_id: 5530321
	 blocking_lock_id: 5530321:25154:3:3
	1 row in set, 1 warning (0.00 sec)

	
	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+--------------------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                                          | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+--------------------------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | select * from t_20201029 where ID=2 lock in share mode | S                 | X                  |
	+--------------+-------------+--------------------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.00 sec)
		
4. 小结

	4.1 update join关联更新的语句加锁规则如下：
		
		RR/RC事务隔离级别下，驱动表的数据都是加写锁； 
		
		RC事务隔离级别下，关联到的被驱动表的数据不加锁；
		RR事务隔离级别下，关联到的被驱动表的数据加读锁；
		
			跟 insert into select 语句一样，RC事务隔离级别下， select 的语句不加锁； RR事务隔离级别下，select 的语句加读锁。
		
	4.2 update join 关联更新还是要拆分成多个小事务，事务快速提交，持有锁的时间就越少，从库也不会有延迟。
		
	
	