


mysql> delete from table_aaaaaaaaaaaaaaaaaaaaaa limit 10000;
^CCtrl-C -- sending "KILL QUERY 107317" to server ...
Ctrl-C -- query aborted.
ERROR 1317 (70100): Query execution was interrupted



普通查询下使用

	mysql> show processlist;
	+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
	| Id | User            | Host                | db              | Command | Time | State                       | Info             |
	+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
	|  1 | event_scheduler | localhost           | NULL            | Daemon  | 2007 | Waiting for next activation | NULL             |
	|  3 | root            | localhost           | NULL            | Query   |    0 | starting                    | show processlist |
	|  4 | root            | localhost           | bak_aiuaiuh9_db | Sleep   |    5 |                             | NULL             |
	|  6 | ljb_user        | 192.168.0.218:53852 | bak_aiuaiuh9_db | Sleep   |   61 |                             | NULL             |
	|  7 | ljb_user        | 192.168.0.218:53855 | bak_aiuaiuh9_db | Sleep   |   59 |                             | NULL             |
	|  8 | ljb_user        | 192.168.0.218:53859 | bak_aiuaiuh9_db | Sleep   |   35 |                             | NULL             |
	+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
	6 rows in set (0.00 sec)

	session A           session B 

	mysql> select count(*) from t1;



						mysql> select * from information_schema.innodb_trx\G;
						*************************** 1. row ***************************
											trx_id: 421941023209296
										 trx_state: RUNNING
									   trx_started: 2020-09-27 15:03:21
							 trx_requested_lock_id: NULL
								  trx_wait_started: NULL
										trx_weight: 0
							   trx_mysql_thread_id: 4
										 trx_query: select count(*) from t1
							   trx_operation_state: fetching rows
								 trx_tables_in_use: 1
								 trx_tables_locked: 0
								  trx_lock_structs: 0
							 trx_lock_memory_bytes: 1136
								   trx_rows_locked: 0
								 trx_rows_modified: 0
						   trx_concurrency_tickets: 0
							   trx_isolation_level: REPEATABLE READ
								 trx_unique_checks: 1
							trx_foreign_key_checks: 1
						trx_last_foreign_key_error: NULL
						 trx_adaptive_hash_latched: 0
						 trx_adaptive_hash_timeout: 0
								  trx_is_read_only: 1
						trx_autocommit_non_locking: 1
						1 row in set (0.00 sec)

	
	执行 Ctrl+C
	^C^C -- query aborted
	ERROR 1317 (70100): Query execution was interrupted
					
						mysql> show processlist;
						+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
						| Id | User            | Host                | db              | Command | Time | State                       | Info             |
						+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
						|  1 | event_scheduler | localhost           | NULL            | Daemon  | 2146 | Waiting for next activation | NULL             |
						|  3 | root            | localhost           | NULL            | Query   |    0 | starting                    | show processlist |
						|  4 | root            | localhost           | bak_aiuaiuh9_db | Sleep   |  109 |                             | NULL             |
						|  6 | ljb_user        | 192.168.0.218:53852 | bak_aiuaiuh9_db | Sleep   |  200 |                             | NULL             |
						|  7 | ljb_user        | 192.168.0.218:53855 | bak_aiuaiuh9_db | Sleep   |  198 |                             | NULL             |
						|  8 | ljb_user        | 192.168.0.218:53859 | bak_aiuaiuh9_db | Sleep   |  174 |                             | NULL             |
						+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
						6 rows in set (0.00 sec)
						
						
						mysql> select * from information_schema.innodb_trx\G;
						Empty set (0.00 sec)
	
DML事务下使用

	session A  
	begin;
	delete from t where id=1;	
	Query OK, 1 row affected (0.00 sec)
	mysql> ^C

	
	mysql> show processlist;
	+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
	| Id | User            | Host                | db              | Command | Time | State                       | Info             |
	+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
	|  1 | event_scheduler | localhost           | NULL            | Daemon  | 4499 | Waiting for next activation | NULL             |
	|  3 | root            | localhost           | NULL            | Query   |    0 | starting                    | show processlist |
	|  4 | root            | localhost           | test_db         | Sleep   |   12 |                             | NULL             |
	|  6 | ljb_user        | 192.168.0.218:53852 | bak_aiuaiuh9_db | Sleep   | 2553 |                             | NULL             |
	|  7 | ljb_user        | 192.168.0.218:53855 | bak_aiuaiuh9_db | Sleep   | 2551 |                             | NULL             |
	|  8 | ljb_user        | 192.168.0.218:53859 | bak_aiuaiuh9_db | Sleep   | 2527 |                             | NULL             |
	| 11 | ljb_user        | 192.168.0.218:54719 | test_db         | Sleep   |   71 |                             | NULL             |
	| 12 | ljb_user        | 192.168.0.218:54720 | test_db         | Sleep   |   76 |                             | NULL             |
	| 13 | ljb_user        | 192.168.0.218:54721 | test_db         | Sleep   |   73 |                             | NULL             |
	+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
	9 rows in set (0.00 sec)

	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 5392190
					 trx_state: RUNNING
				   trx_started: 2020-09-27 15:44:11
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 4
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 2
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 1
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

	
	关闭xshell中的当前会话后，查看事务的信息
	
			
		mysql> show processlist;
		+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
		| Id | User            | Host                | db              | Command | Time | State                       | Info             |
		+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
		|  1 | event_scheduler | localhost           | NULL            | Daemon  | 4721 | Waiting for next activation | NULL             |
		|  3 | root            | localhost           | NULL            | Query   |    0 | starting                    | show processlist |
		|  6 | ljb_user        | 192.168.0.218:53852 | bak_aiuaiuh9_db | Sleep   | 2775 |                             | NULL             |
		|  7 | ljb_user        | 192.168.0.218:53855 | bak_aiuaiuh9_db | Sleep   | 2773 |                             | NULL             |
		|  8 | ljb_user        | 192.168.0.218:53859 | bak_aiuaiuh9_db | Sleep   | 2749 |                             | NULL             |
		| 11 | ljb_user        | 192.168.0.218:54719 | test_db         | Sleep   |  293 |                             | NULL             |
		| 12 | ljb_user        | 192.168.0.218:54720 | test_db         | Sleep   |  178 |                             | NULL             |
		| 13 | ljb_user        | 192.168.0.218:54721 | test_db         | Sleep   |  295 |                             | NULL             |
		+----+-----------------+---------------------+-----------------+---------+------+-----------------------------+------------------+
		8 rows in set (0.00 sec)

		mysql> select * from information_schema.innodb_trx\G;
		Empty set (0.00 sec)

