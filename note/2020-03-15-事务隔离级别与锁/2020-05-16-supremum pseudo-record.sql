
0. 什么是supremum pseudo-record
1.初始表结构、数据和实验目的
2. MySQL 5.7.22	
	2.1 环境 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
	2.2 环境 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
3. MySQL 8.0.19
	3.1 环境 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
4. 小结


0. 什么是supremum pseudo-record

	InnoDB给每个索引加了一个不存在的最大值 supremum, 相当于比索引中最大值还大，相当于最后一行之后的间隙锁， LOCK_DATA列值将显示伪记录(supremum pseudo-record)。
	
	RR隔离级别才会持有。（总的来说就是每个索引页不存在的最大值）
	
	
	https://phpor.net/blog/post/3186  关于mysql锁的学习
	
	
	扩展:
	
		LOCK_DATA：该字段值显示与锁定记录相关的数据（如果存在锁定数据记录的话）。
		如果LOCK_TYPE为RECORD，则该列值显示的值为锁定记录的主键值，否则为NULL。
		如果没有主键，则LOCK_DATA是具有唯一性的InnoDB内部行ID号值。
		如果对索引中锁定的键值比最大值还大，或者键值是一个间隙锁定，则LOCK_DATA列值将显示伪记录(supremum pseudo-record)。
		当包含已锁定记录的页面不在缓冲池中时（在锁定期间已将其分页到磁盘的情况下），InnoDB为避免不必要的磁盘操作不会从磁盘获取页面。此时，LOCK_DATA列值显示为NULL

		https://mp.weixin.qq.com/s/CWUz4oTIhMwqkkqQyRjr7g  InnoDB 层锁、事务、统计信息字典表 | 全方位认识 information_schema




1. 初始表结构和数据
	
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

	mysql>select * from t;
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

	实验目的
		验证事务B是否会被阻塞：
		session A           session B
		begin;				begin;
		select * from t where id>=5 for update;
							insert into t(c,d) values(6,6);
		
	
2.1 环境 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交

	root@localhost [db1]>select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.19-log |
	+------------+
	1 row in set (0.00 sec)

	root@localhost [db1]>show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.01 sec)

	root@localhost [db1]>show global variables like '%isolation%';
	+---------------+----------------+
	| Variable_name | Value          |
	+---------------+----------------+
	| tx_isolation  | READ-COMMITTED |
	+---------------+----------------+
	1 row in set (0.00 sec)

	root@localhost [db1]>select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+
	1 row in set (0.00 sec)

	root@localhost [db1]>SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='db2' and table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              6 |
	+----------------+
	1 row in set (0.00 sec)

	session A           session B
	begin;				begin;
	select * from t where id>=5 for update;
	
						insert into t(c,d) values(6,6);
						(Query OK)
						
	select * from t where id>=5 lock in share mode; 呢
	
	mysql>select * from information_schema.innodb_trx\G;

	*************************** 1. row ***************************
						trx_id: 5893700
					 trx_state: RUNNING
				   trx_started: 2020-05-17 03:23:09
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 2
		   trx_mysql_thread_id: 29
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 1
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 0
			 trx_rows_modified: 1
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
						trx_id: 5893699
					 trx_state: RUNNING
				   trx_started: 2020-05-17 03:22:43
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 2
		   trx_mysql_thread_id: 30
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
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


2.2 环境 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读

	mysql>select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.19-log |
	+------------+
	1 row in set (0.00 sec)

	mysql>show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.01 sec)

	mysql>show global variables like '%isolation%';
	+---------------+-----------------+
	| Variable_name | Value           |
	+---------------+-----------------+
	| tx_isolation  | REPEATABLE-READ |
	+---------------+-----------------+
	1 row in set (0.00 sec)

	mysql>select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| REPEATABLE-READ        |
	+------------------------+
	1 row in set (0.00 sec)


	mysql>SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='db2' and table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              6 |
	+----------------+
	1 row in set (0.00 sec)

	session A           session B
	begin;				begin;
	
	select * from t where id>=5 for update;
	
						insert into t(c,d) values(6,6);
						(Blocked)

	root@localhost [(none)]>select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5893705
					 trx_state: LOCK WAIT
				   trx_started: 2020-05-17 03:27:57
		 trx_requested_lock_id: 5893705:236:3:1
			  trx_wait_started: 2020-05-17 03:27:57
					trx_weight: 2
		   trx_mysql_thread_id: 37
					 trx_query: insert into t(c,d) values(6,6)
		   trx_operation_state: inserting
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
						trx_id: 5893704
					 trx_state: RUNNING
				   trx_started: 2020-05-17 03:27:56
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 38
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 2
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
	
	
	root@localhost [(none)]>select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 5893705:236:3:1
	lock_trx_id: 5893705
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `db2`.`t`
	 lock_index: PRIMARY
	 lock_space: 236
	  lock_page: 3
	   lock_rec: 1
	  lock_data: supremum pseudo-record
	*************************** 2. row ***************************
		lock_id: 5893704:236:3:1
	lock_trx_id: 5893704
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `db2`.`t`
	 lock_index: PRIMARY
	 lock_space: 236
	  lock_page: 3
	   lock_rec: 1
	  lock_data: supremum pseudo-record
	2 rows in set, 1 warning (0.00 sec)

	root@localhost [(none)]>select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 5893705
	requested_lock_id: 5893705:236:3:1
	  blocking_trx_id: 5893704
	 blocking_lock_id: 5893704:236:3:1
	1 row in set, 1 warning (0.00 sec)

	root@localhost [(none)]>SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+--------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                  | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+--------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | insert into t(c,d) values(6,6) | X                 | X                  |
	+--------------+-------------+--------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.00 sec)

3.1 环境 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
	root@mysqldb 02:37:  [(none)]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)

	root@mysqldb 02:33:  [(none)]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.17 sec)

	root@mysqldb 02:33:  [(none)]> select @@global.transaction_isolation;
	+--------------------------------+
	| @@global.transaction_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
	+--------------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 02:33:  [(none)]> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

	session A           session B
	begin;				begin;
	select * from t where id>=5 for update;
						insert into t(c,d) values(6,6);
						(Blocked)
							
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE          | LOCK_STATUS | LOCK_DATA              |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	| 140538819522872:1070:140538711973976   |                  2347 |        58 | t           | NULL       | TABLE     | IX                 | GRANTED     | NULL                   |
	| 140538819522872:13:4:1:140538711971096 |                  2347 |        58 | t           | PRIMARY    | RECORD    | X,INSERT_INTENTION | WAITING     | supremum pseudo-record |
	| 140538819523744:1070:140538711979976   |                  2346 |        62 | t           | NULL       | TABLE     | IX                 | GRANTED     | NULL                   |
	| 140538819523744:13:4:6:140538711976936 |                  2346 |        62 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP      | GRANTED     | 5                      |
	| 140538819523744:13:4:1:140538711977280 |                  2346 |        62 | t           | PRIMARY    | RECORD    | X                  | GRANTED     | supremum pseudo-record |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
	5 rows in set (0.00 sec)

	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 2347
					 trx_state: LOCK WAIT
				   trx_started: 2020-05-17 02:37:23
		 trx_requested_lock_id: 140538819522872:13:4:1:140538711971096
			  trx_wait_started: 2020-05-17 02:37:23
					trx_weight: 2
		   trx_mysql_thread_id: 8
					 trx_query: insert into t(c,d) values(6,6)
		   trx_operation_state: inserting
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
						trx_id: 2346
					 trx_state: RUNNING
				   trx_started: 2020-05-17 02:36:32
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 12
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 2
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
	2 rows in set (0.06 sec)

	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;

	*************************** 1. row ***************************
		  locked_index: PRIMARY
		   locked_type: RECORD
		 waiting_query: insert into t(c,d) values(6,6)
	 waiting_lock_mode: X,INSERT_INTENTION
	blocking_lock_mode: X
	1 row in set (0.39 sec)
	
	
4. 小结
	supremum pseudo-record : 
		比索引中的最大值还大，相当于最后一行之后的间隙锁， LOCK_DATA列值将显示伪记录(supremum pseudo-record)。
		RR隔离级别持有；
		RC隔离级别下也会持有，不过如果 supremum 没有被别的事务锁住，那么会立即被释放。

	

