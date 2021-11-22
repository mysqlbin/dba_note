
1. 初始化表结构和数据
2. MDL锁的复现
3. 对MDL锁的处理
4. 参数lock_wait_timeout=10下的MDL锁超时
5. 小结
6. 相关参考
7. 查杀MDL锁的SQL语句

1. 初始化表结构和数据
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('5', '5', '5');
	
	
2. MDL锁的复现
	SESSION A					SESSION B	                    SESSION C
	begin;
	select * from t limit 1;

								alter table  t add column test_filed int(11);
								(block)
																select * from t limit 1; 				
																(blocked)
																	   
	mysql> show processlist;
	+-------+-----------------+---------------------+---------+---------+-------+---------------------------------+----------------------------------------------+
	| Id    | User            | Host                | db      | Command | Time  | State                           | Info                                         |
	+-------+-----------------+---------------------+---------+---------+-------+---------------------------------+----------------------------------------------+
	|     1 | event_scheduler | localhost           | NULL    | Daemon  | 17330 | Waiting for next activation     | NULL                                         |
	| 34118 | root            | localhost           | test_db | Query   |    14 | Waiting for table metadata lock | alter table  t add column test_filed int(11) |
	| 34119 | root            | localhost           | test_db | Query   |     6 | Waiting for table metadata lock | select * from t limit 1                      |
	| 34120 | ljb_user        | 192.168.0.218:53918 | NULL    | Sleep   |  1846 |                                 | NULL                                         |
	| 34121 | ljb_user        | 192.168.0.218:53919 | test_db | Sleep   |  1838 |                                 | NULL                                         |
	| 34122 | ljb_user        | 192.168.0.218:53923 | test_db | Sleep   |  1841 |                                 | NULL                                         |
	| 34123 | root            | localhost           | test_db | Sleep   |    35 |                                 | NULL                                         |
	| 34124 | root            | localhost           | test_db | Query   |     0 | starting                        | show processlist                             |
	+-------+-----------------+---------------------+---------+---------+-------+---------------------------------+----------------------------------------------+
	8 rows in set (0.00 sec)


	session A先启动, 对表加一个MDL读锁;
	session B被blocked, 因为session A的MDL读锁还没有释放,
	session B需要 MDL写锁, 因此只能被阻塞.
	session B被阻塞, 之后所有要在表上新申请MDL读锁的请求也会被 session B阻塞
	所有对表的增删改查操作都需要先申请MDL读锁, 就都被锁住, 等于这个表现在完成不可读写了.
	如果是热点表，应用有太多的连接进来连接这个表，数据库的连接数被爆满。
	
	******************************************************
	mysql> select * from sys.schema_table_lock_waits\G;
	*************************** 1. row ***************************
				   object_schema: test_db
					 object_name: t
			   waiting_thread_id: 34151
					 waiting_pid: 34118
				 waiting_account: root@localhost
			   waiting_lock_type: EXCLUSIVE
		   waiting_lock_duration: TRANSACTION
				   waiting_query: alter table  t add column test_filed int(11)
			  waiting_query_secs: 25
	 waiting_query_rows_affected: 0
	 waiting_query_rows_examined: 0
			  blocking_thread_id: 34151
					blocking_pid: 34118    -- 查获加MDL写锁的线程 id，也就是造成阻塞的 thread id。
				blocking_account: root@localhost
			  blocking_lock_type: SHARED_UPGRADABLE
		  blocking_lock_duration: TRANSACTION
		 sql_kill_blocking_query: KILL QUERY 34118
	sql_kill_blocking_connection: KILL 34118
	*************************** 2. row ***************************
				   object_schema: test_db
					 object_name: t
			   waiting_thread_id: 34151
					 waiting_pid: 34118
				 waiting_account: root@localhost
			   waiting_lock_type: EXCLUSIVE
		   waiting_lock_duration: TRANSACTION
				   waiting_query: alter table  t add column test_filed int(11)
			  waiting_query_secs: 25
	 waiting_query_rows_affected: 0
	 waiting_query_rows_examined: 0
			  blocking_thread_id: 34156
					blocking_pid: 34123
				blocking_account: root@localhost
			  blocking_lock_type: SHARED_READ
		  blocking_lock_duration: TRANSACTION
		 sql_kill_blocking_query: KILL QUERY 34123
	sql_kill_blocking_connection: KILL 34123
	*************************** 3. row ***************************
				   object_schema: test_db
					 object_name: t
			   waiting_thread_id: 34152
					 waiting_pid: 34119
				 waiting_account: root@localhost
			   waiting_lock_type: SHARED_READ
		   waiting_lock_duration: TRANSACTION
				   waiting_query: select * from t limit 1
			  waiting_query_secs: 17
	 waiting_query_rows_affected: 0
	 waiting_query_rows_examined: 0
			  blocking_thread_id: 34151
					blocking_pid: 34118
				blocking_account: root@localhost
			  blocking_lock_type: SHARED_UPGRADABLE
		  blocking_lock_duration: TRANSACTION
		 sql_kill_blocking_query: KILL QUERY 34118
	sql_kill_blocking_connection: KILL 34118
	*************************** 4. row ***************************
				   object_schema: test_db
					 object_name: t
			   waiting_thread_id: 34152
					 waiting_pid: 34119
				 waiting_account: root@localhost
			   waiting_lock_type: SHARED_READ
		   waiting_lock_duration: TRANSACTION
				   waiting_query: select * from t limit 1
			  waiting_query_secs: 17
	 waiting_query_rows_affected: 0
	 waiting_query_rows_examined: 0
			  blocking_thread_id: 34156
					blocking_pid: 34123
				blocking_account: root@localhost
			  blocking_lock_type: SHARED_READ
		  blocking_lock_duration: TRANSACTION
		 sql_kill_blocking_query: KILL QUERY 34123
	sql_kill_blocking_connection: KILL 34123
	4 rows in set (0.01 sec)



	mysql> select * from information_schema.INNODB_TRX\G;
	*************************** 1. row ***************************
						trx_id: 5246884
					 trx_state: RUNNING
				   trx_started: 2020-09-25 11:18:15
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 0
		   trx_mysql_thread_id: 34123
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
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
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	1 row in set (0.00 sec)


3. 对MDL锁的处理

	msyql> KILL 34118;
	Query OK, 0 rows affected (0.01 sec)

	mysql> show processlist;
	+-------+-----------------+---------------------+---------+---------+-------+-----------------------------+------------------+
	| Id    | User            | Host                | db      | Command | Time  | State                       | Info             |
	+-------+-----------------+---------------------+---------+---------+-------+-----------------------------+------------------+
	|     1 | event_scheduler | localhost           | NULL    | Daemon  | 17656 | Waiting for next activation | NULL             |
	| 34119 | root            | localhost           | test_db | Sleep   |   332 |                             | NULL             |
	| 34120 | ljb_user        | 192.168.0.218:53918 | NULL    | Sleep   |  2172 |                             | NULL             |
	| 34121 | ljb_user        | 192.168.0.218:53919 | test_db | Sleep   |  2164 |                             | NULL             |
	| 34122 | ljb_user        | 192.168.0.218:53923 | test_db | Sleep   |  2167 |                             | NULL             |
	| 34123 | root            | localhost           | test_db | Sleep   |   361 |                             | NULL             |
	| 34124 | root            | localhost           | test_db | Query   |     0 | starting                    | show processlist |
	+-------+-----------------+---------------------+---------+---------+-------+-----------------------------+------------------+
	7 rows in set (0.00 sec)
	
	session B
	mysql> alter table  t add column test_filed int(11);
	ERROR 2013 (HY000): Lost connection to MySQL server during query

	
	SESSION C
	mysql>  select * from t limit 1; 
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	+----+------+------+
	1 row in set (5 min 13.26 sec)   --从被MDL锁锁住到MDL锁释放，总共执行耗长：5 min 13.26 sec
	
	mysql> select * from information_schema.INNODB_TRX\G;
	*************************** 1. row ***************************
						trx_id: 5246884
					 trx_state: RUNNING
				   trx_started: 2020-09-25 11:18:15
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 0
		   trx_mysql_thread_id: 34123
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
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
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	1 row in set (0.00 sec)



4. 参数lock_wait_timeout=10下的MDL锁超时

	msyql> set global lock_wait_timeout=10;
	Query OK, 0 rows affected (0.00 sec)


	SESSION A					SESSION B	                    SESSION C
	begin;
	select * from t limit 1;

								alter table  t add column test_filed int(11);
								(block)
																select * from t limit 1; 				
																(blocked)
								
								ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
								
																+----+------+------+
																| id | c    | d    |
																+----+------+------+
																|  1 |    1 |    1 |
																+----+------+------+
																1 row in set (6.82 sec)

5. 小结

	读/写长事务持有MDL读锁，DDL需要持有MDL写锁， MDL读锁没有释放，MDL写锁就会一直处于阻塞状态。
	5.7版本下处理MDL锁是非常方便的。
	
	需要到的SQL语句列表：
		show processlist;
		select * from sys.schema_table_lock_waits\G;
		select * from information_schema.INNODB_TRX\G;
		3联SQL语句。

6. 相关参考
	https://www.cnblogs.com/ivictor/p/9460147.html  MySQL 5.7中如何定位DDL被阻塞的问题

	
7. 查杀MDL锁的SQL语句

	八怪师兄(22389860) 2021/10/29 9:13:07
	@小徐 应该查一下 大于最大 MDL LOCK 等待 之前的一个事务，通过事务的启动时间来查。

	八怪师兄(22389860) 2021/10/29 9:13:12
	我处理过很多次了

	八怪师兄(22389860) 2021/10/29 9:14:52
	select trx_id,trx_operation_state,trx_mysql_thread_id process_id,trx_started,
	to_seconds(now())-to_seconds(trx_started) trx_es_time,
	user,db,host,state,Time,info current_sql
	from information_schema.innodb_trx t1,information_schema.processlist t2,performance_schema.threads  t3
	where t1.trx_mysql_thread_id=t2.id 
	and   t1.trx_mysql_thread_id=t3.PROCESSLIST_ID
	and   t1.trx_mysql_thread_id!=connection_id()
	and   to_seconds(now())-to_seconds(t1.trx_started) >=
	(select max(time) from information_schema.processlist where STATE like 'Waiting for%');

	八怪师兄(22389860) 2021/10/29 9:15:00
	这个语句 你收录 一下 备用

	八怪师兄(22389860) 2021/10/29 9:16:05
	偶尔被堵塞者是 SQL线程和 或者 MGR的applier 通道 可能查不到 就去掉最后的 那个and 条件 按照事务的 先后启动顺序来杀。我发现 MDL LOCK等待 不比 row lock等待的案例少。基本持平

	八怪师兄(22389860) 2021/10/29 9:16:24
	生活小妙招 记住了。。

