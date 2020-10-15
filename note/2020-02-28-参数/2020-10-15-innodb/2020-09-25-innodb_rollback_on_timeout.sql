
1. innodb_rollback_on_timeout参数的含义
2. 环境和初始化表结构和数据
3. innodb_rollback_on_timeout=OFF
4. innodb_rollback_on_timeout=ON
5. 相关参考
6. 小结


1. innodb_rollback_on_timeout参数的含义
	InnoDB rolls back only the last statement on a transaction timeout by default. If --innodb-rollback-on-timeout is specified, a transaction timeout causes InnoDB to abort and roll back the entire transaction.
	--默认情况下，InnoDB仅回退事务超时时的最后一条语句。 如果指定了--innodb-rollback-on-timeout，则事务超时将导致InnoDB中止并回滚整个事务。
	--默认情况下innodb_lock_wait_timeout 超时后只是超时的sql执行失败，整个事务并不回滚，也不做提交，如需要事务在超时的时候回滚，则需要设置innodb_rollback_on_timeout=ON，该参数默认为OFF

	---------------------------------------------------------------------------------------------------------------------
	如果这个参数为true，则当发生因为等待行锁而产生的超时时，回滚掉整个事务，否则只回滚当前的语句。这个就是隐式回滚机制。
	之前就在测试环境遇到过，因为这个参数是OFF, 在等待行锁而产生的超时后，只回滚事务超时时的最后一条语句, 导致时常有长时间未提交的事务出现。


	思考：  
		参数关闭的情况下：死锁情况下是否会回滚？
		死锁是会把整个事务回滚。
		innodb_rollback_on_timeout是会对行锁超时而言的。
		

	 

2. 环境和初始化表结构和数据
	环境
		mysql> select @@tx_isolation;
		+-----------------+
		| @@tx_isolation  |
		+-----------------+
		| REPEATABLE-READ |
		+-----------------+
		1 row in set, 1 warning (0.01 sec)

		mysql> select version();
		+------------+
		| version()  |
		+------------+
		| 5.7.22-log |
		+------------+
		1 row in set (0.00 sec)


		mysql> show global variables like 'innodb_lock_wait_timeout';
		+--------------------------+-------+
		| Variable_name            | Value |
		+--------------------------+-------+
		| innodb_lock_wait_timeout | 10    |
		+--------------------------+-------+
		1 row in set (0.01 sec)


		mysql> show global variables like '%innodb_rollback_on_timeout%';
		+----------------------------+-------+
		| Variable_name              | Value |
		+----------------------------+-------+
		| innodb_rollback_on_timeout | OFF   |
		+----------------------------+-------+
	1 row in set (0.01 sec)


	初始化表结构和数据
		CREATE TABLE `product` (
		  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
		  `name` varchar(20) DEFAULT NULL,
		  `amount` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_name` (`name`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

		INSERT INTO `product` VALUES ('1', 'mi8', '1');
		INSERT INTO `product` VALUES ('3', 'mi9', '1');


3. innodb_rollback_on_timeout=OFF
事务的执行次序
	SESSION A						SESSION B                session C
	begin;
	update product set amount=amount+1 where name = 'mi8';
	
									begin;
									update product set amount=amount+1 where name = 'mi9';
									(Query OK)
									
									update product set amount=amount+1 where name = 'mi8';
									(Blocked，
										超过10秒后，提示 ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
										)
										
															show processlist;
			
															select * from information_schema.INNODB_TRX\G;

															select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;

																
	commit;
	
	
	session C
		mysql> show processlist;
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		| Id | User            | Host      | db      | Command | Time | State                       | Info             |
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		|  1 | event_scheduler | localhost | NULL    | Daemon  |  370 | Waiting for next activation | NULL             |
		|  3 | root            | localhost | test_db | Sleep   |   60 |                             | NULL             |
		|  4 | root            | localhost | test_db | Sleep   |  125 |                             | NULL             |
		|  5 | root            | localhost | test_db | Query   |    0 | starting                    | show processlist |
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		4 rows in set (0.00 sec)

		 
		mysql> select * from information_schema.INNODB_TRX\G;
		*************************** 1. row ***************************
							trx_id: 5247237
						 trx_state: RUNNING
					   trx_started: 2020-09-25 15:59:26
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 4
			   trx_mysql_thread_id: 3
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 3
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 4
				 trx_rows_modified: 1
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
							trx_id: 5247236
						 trx_state: RUNNING
					   trx_started: 2020-09-25 15:59:16
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 5
			   trx_mysql_thread_id: 4
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 4
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 3
				 trx_rows_modified: 1
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


		mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
		+-----------+------+---------+------+---------+---------+-----------+-----------+
		| host      | user | db      | time | COMMAND | trx_id  | trx_state | trx_query |
		+-----------+------+---------+------+---------+---------+-----------+-----------+
		| localhost | root | test_db |  125 | Sleep   | 5247236 | RUNNING   | NULL      |
		| localhost | root | test_db |   60 | Sleep   | 5247237 | RUNNING   | NULL      |
		+-----------+------+---------+------+---------+---------+-----------+-----------+
		2 rows in set (0.00 sec)


	session A 提交commit之后的状态：
		mysql> show processlist;
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		| Id | User            | Host      | db      | Command | Time | State                       | Info             |
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		|  1 | event_scheduler | localhost | NULL    | Daemon  |  641 | Waiting for next activation | NULL             |
		|  3 | root            | localhost | test_db | Sleep   |  331 |                             | NULL             |
		|  4 | root            | localhost | test_db | Sleep   |   17 |                             | NULL             |
		|  5 | root            | localhost | test_db | Query   |    0 | starting                    | show processlist |
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		4 rows in set (0.00 sec)

		mysql> select * from information_schema.INNODB_TRX\G;
		*************************** 1. row ***************************
							trx_id: 5247237
						 trx_state: RUNNING
					   trx_started: 2020-09-25 15:59:26
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 4
			   trx_mysql_thread_id: 3
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 3
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 4
				 trx_rows_modified: 1
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		1 row in set (0.00 sec)

		
		mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
		+-----------+------+---------+------+---------+---------+-----------+-----------+
		| host      | user | db      | time | COMMAND | trx_id  | trx_state | trx_query |
		+-----------+------+---------+------+---------+---------+-----------+-----------+
		| localhost | root | test_db |  335 | Sleep   | 5247237 | RUNNING   | NULL      |
		+-----------+------+---------+------+---------+---------+-----------+-----------+
		1 row in set (0.01 sec)




4. innodb_rollback_on_timeout=ON

mysql> show global variables like '%innodb_rollback_on_timeout%';
+----------------------------+-------+
| Variable_name              | Value |
+----------------------------+-------+
| innodb_rollback_on_timeout | ON    |
+----------------------------+-------+
1 row in set (0.01 sec)


事务的执行次序
	SESSION A						SESSION B                session C
	begin;
	update product set amount=amount+1 where name = 'mi8';
	
									begin;
									update product set amount=amount+1 where name = 'mi9';
									(Query OK)
									
									update product set amount=amount+1 where name = 'mi8';
									(Blocked，
										超过10秒后，提示 ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
										)
										
															show processlist;
			
															select * from information_schema.INNODB_TRX\G;


	session C															
		mysql> show processlist;
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		| Id | User            | Host      | db      | Command | Time | State                       | Info             |
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		|  1 | event_scheduler | localhost | NULL    | Daemon  | 1749 | Waiting for next activation | NULL             |
		|  3 | root            | localhost | test_db | Sleep   |   45 |                             | NULL             |
		|  4 | root            | localhost | test_db | Query   |    0 | starting                    | show processlist |
		|  5 | root            | localhost | test_db | Sleep   |   29 |                             | NULL             |
		+----+-----------------+-----------+---------+---------+------+-----------------------------+------------------+
		4 rows in set (0.00 sec)

		mysql> select * from information_schema.INNODB_TRX\G;
		*************************** 1. row ***************************
							trx_id: 5247748
						 trx_state: RUNNING
					   trx_started: 2020-09-25 16:37:51
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 5
			   trx_mysql_thread_id: 3
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 4
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 3
				 trx_rows_modified: 1
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		1 row in set (0.00 sec)



5. 相关参考
	https://www.cnblogs.com/mydriverc/p/8297108.html MYSQL数据库INNODB_ROLLBACK_ON_TIMEOUT默认值的危害？
	
	   
	官方文档
		https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_rollback_on_timeout
		https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_rollback_on_timeout
			5.7 和 8.0 版本下都是为 OFF.
	
6. 小结

	默认情况下，InnoDB仅回退事务超时时的最后一条语句。 如果指定了--innodb-rollback-on-timeout，则事务超时将导致InnoDB中止并回滚整个事务。
	
	
	