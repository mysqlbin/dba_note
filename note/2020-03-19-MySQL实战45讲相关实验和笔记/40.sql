

1. 初始化表结构和数据
2. insert ... select 语句的加锁 
3. insert 循环写入
4. insert 唯一键冲突
5. 唯一键冲突加锁			
6. insert into … on duplicate key update
7. 小结

1. 初始化表结构和数据
	drop table if exists t;
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `c` (`c`)
	) ENGINE=InnoDB;

	insert into t values(null, 1,1);
	insert into t values(null, 2,2);
	insert into t values(null, 3,3);
	insert into t values(null, 4,4);

	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	+----+------+------+
	4 rows in set (0.00 sec)

	create table t2 like t;


2. insert ... select 语句的加锁 
	事务隔离级别: 可重复读
	binlog_format: statement 格式;
	
	为什么 insert into t2(c,d) select c,d from t; 会对表 t 的所有行和间隙加锁;

	session A                 			session B
										begin;
										insert into t2(c,d) select c,d from t;
	begin;
	insert into t values(-1, -1, -1);    
	(Blocked)
	
	mysql> select locked_index,locked_type,blocking_lock_mode,waiting_lock_mode,waiting_query from sys.innodb_lock_waits;
	+--------------+-------------+--------------------+-------------------+----------------------------------+
	| locked_index | locked_type | blocking_lock_mode | waiting_lock_mode | waiting_query                    |
	+--------------+-------------+--------------------+-------------------+----------------------------------+
	| PRIMARY      | RECORD      | S                  | X,GAP             | insert into t values(-1, -1, -1) |
	+--------------+-------------+--------------------+-------------------+----------------------------------+
	1 row in set, 3 warnings (0.01 sec)



	从binlog日志和数据的一致性作为考虑方向：

		如果没有锁的话，就可能出现 session B 的 insert 语句先执行，但是后写入 binlog 的情况
		于是，在 binlog_format=statement 的情况下，binlog 里面就记录了这样的语句序列：
			insert into t values(-1, -1, -1);
			insert into t2(c,d) select c,d from t;
		这个语句到了备库执行，就会把 id=-1 这一行也写到表 t2 中，出现主备不一致。

		执行 insert … select 的时候，对目标表也不是锁全表，而是只锁住需要访问的资源。
	

3. insert 循环写入

	都能够学会用 explain 的结果来脑补整条语句的执行过程。


	root@mysqldb 17:14:  [420_db]> desc insert into t2(c,d)  (select c+1, d from t force index(c) order by c desc limit 1);
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
	| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
	|  1 | INSERT      | t2    | NULL       | ALL   | NULL          | NULL | NULL    | NULL | NULL |     NULL | NULL  |
	|  1 | SIMPLE      | t     | NULL       | index | NULL          | c    | 5       | NULL |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-------+
	2 rows in set (0.00 sec)
	
	
	
	-------------------------------------------------------------------------------------------------------------------------------------
	
	set global long_query_time=0;
	show GLOBAL variables like '%long_query_time%';
	show status like '%Innodb_rows_read%';
	insert into t(c,d)  (select c+1, d from t force index(c) order by c desc limit 1);
	show status like '%Innodb_rows_read%';


	需求：
		要往表 t 中插入一行数据，这一行的 c 值是表 t 中 c 值的最大值加 1。
		
	SQL语句:
		insert into t(c,d)  (select c+1, d from t force index(c) order by c desc limit 1);
		
		mysql> desc insert into t(c,d)  (select c+1, d from t force index(c) order by c desc limit 1);
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------+
		| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra           |
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------+
		|  1 | INSERT      | t     | NULL       | ALL   | NULL          | NULL | NULL    | NULL | NULL |     NULL | NULL            |
		|  1 | SIMPLE      | t     | NULL       | index | NULL          | c    | 5       | NULL |    1 |   100.00 | Using temporary |
		+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------+
		2 rows in set (0.01 sec)


	分析语句的执行流程和扫描行数的方向:
		
		查看执行计划
			用 explain 的结果来“脑补”整条语句的执行过程。
		分析扫描的行数的方法:
			show status like '%Innodb_rows_read%';
			从慢查询查看SQL语句的Rows_examined
			explain.rows
			
	查看慢查询:
		语句的 Rows_examined 的值是 5
		
	查看执行计划:
		Extra = Using temporary:
			表示这个语句用到了临时表;
			说明执行过程中，需要把表 t 的内容读出来，写入临时表。
		rows = 1:
			预计扫描的行数
			
		rows = 1, 先对这个语句的执行流程做一个猜测：
			如果说是把子查询的结果读出来（扫描 1 行），写入临时表，然后再从临时表读出来（扫描 1 行），写回表 t 中。
			那么，这个语句的扫描行数就应该是 2，而不是 5。
			
			所以，这个猜测不对; 推翻了猜测的思路

	先说结论:
		实际上，Explain 结果里的 rows=1 是因为受到了 limit 1 的影响。	
	
	查看Innodb_rows_read变化:
	
		从另一个角度考虑的话，我们可以看看 InnoDB 扫描了多少行:

			mysql> set global long_query_time=0;
			Query OK, 0 rows affected (0.00 sec)

			mysql> show GLOBAL variables like '%long_query_time%';
			+-----------------+----------+
			| Variable_name   | Value    |
			+-----------------+----------+
			| long_query_time | 0.000000 |
			+-----------------+----------+
			1 row in set (0.01 sec)

			mysql> show status like '%Innodb_rows_read%';
			+------------------+-------+
			| Variable_name    | Value |
			+------------------+-------+
			| Innodb_rows_read | 23    |
			+------------------+-------+
			1 row in set (0.00 sec)

			mysql> insert into t(c,d)  (select c+1, d from t force index(c) order by c desc limit 1);
			Query OK, 1 row affected (0.06 sec)
			Records: 1  Duplicates: 0  Warnings: 0

			mysql> show status like '%Innodb_rows_read%';
			+------------------+-------+
			| Variable_name    | Value |
			+------------------+-------+
			| Innodb_rows_read | 27    |
			+------------------+-------+
			1 row in set (0.00 sec)
			
		可以看到，这个语句执行前后，Innodb_rows_read 的值增加了 4。
		因为默认临时表是使用 Memory 引擎的，所以这 4 行查的都是表 t，也就是说对表 t 做了全表扫描。
		
		
	整个执行过程:
		1. 创建临时表，表里有两个字段 c 和 d。
		
		2. 按照索引 c 扫描表 t，依次取 c=4、3、2、1，然后回表，读到 c 和 d 的值写入临时表。
			这时，Rows_examined=4。
			
		3. 由于语义里面有 limit 1，所以只取了临时表的第一行，再插入到表 t 中。
			这时，Rows_examined 的值加 1，变成了 5。
		
		4. 这个语句会导致在表 t 上做全表扫描，并且会给索引 c 上的所有间隙都加上共享的 next-key lock; 
			这个语句执行期间，其他事务不能在这个表上插入数据。
		
	为什么这个语句的执行需要临时表:
		原因是这类一边遍历数据，一边更新数据的情况
		如果读出来的数据直接写回原表，就可能在遍历过程中，读到刚刚插入的记录，新插入的记录如果参与计算逻辑，就跟语义不符。	
			--这里不是很理解。
			
	这个语句为什么需要遍历整张表:
		由于实现上这个语句没有在子查询中就直接使用 limit 1，从而导致了这个语句的执行需要遍历整个表 t。

	优化方法:
		先 insert into 到临时表 temp_t，这样就只需要扫描一行;
		然后再从表 temp_t 里面取出这行数据插入表 t1;	

		由于这个语句涉及的数据量很小，可以考虑使用内存临时表来做这个优化。
		使用内存临时表优化时，语句序列的写法如下：
			create temporary table temp_t(c int,d int) engine=memory;
			insert into temp_t  (select c+1, d from t force index(c) order by c desc limit 1);
			insert into t select * from temp_t;
			drop table temp_t;

4. insert 唯一键冲突

	root@mysqldb 09:55:  [420_db]> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	+----+------+------+
	4 rows in set (0.06 sec)

	root@mysqldb 09:56:  [420_db]> show create table t\G;
	*************************** 1. row ***************************
		   Table: t
	Create Table: CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)	
	
	时间点	session A                      		session B                  					session C
			begin;
			insert into t values(null, 5, 5);
	T1 
			
												insert into t values(null, 5, 5);		    
	T2																					     insert into t values(null, 5, 5);

			rollback;
												Query OK, 1 row affected (27.78 sec)

																							ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction

																				


	T1 
		root@mysqldb 10:15:  [(none)]> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 9499678
						 trx_state: RUNNING
					   trx_started: 2021-04-30 10:16:03
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 2
			   trx_mysql_thread_id: 3
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 0
				 trx_tables_locked: 1
				  trx_lock_structs: 1
			 trx_lock_memory_bytes: 1136
				   trx_rows_locked: 0
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

	T2

		root@mysqldb 10:16:  [(none)]> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 9499679
						 trx_state: LOCK WAIT
					   trx_started: 2021-04-30 10:17:02
			 trx_requested_lock_id: 9499679:27403:4:6
				  trx_wait_started: 2021-04-30 10:17:02
						trx_weight: 3
			   trx_mysql_thread_id: 2
						 trx_query: insert into t values(null, 5, 5)
			   trx_operation_state: inserting
				 trx_tables_in_use: 1
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
		*************************** 2. row ***************************
							trx_id: 9499678
						 trx_state: RUNNING
					   trx_started: 2021-04-30 10:16:03
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 3
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
		2 rows in set (0.00 sec)



	T3

		root@mysqldb 10:17:  [(none)]> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 9499680
						 trx_state: LOCK WAIT
					   trx_started: 2021-04-30 10:17:16
			 trx_requested_lock_id: 9499680:27403:4:6
				  trx_wait_started: 2021-04-30 10:17:16
						trx_weight: 3
			   trx_mysql_thread_id: 4
						 trx_query: insert into t values(null, 5, 5)
			   trx_operation_state: inserting
				 trx_tables_in_use: 1
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
		*************************** 2. row ***************************
							trx_id: 9499679
						 trx_state: LOCK WAIT
					   trx_started: 2021-04-30 10:17:02
			 trx_requested_lock_id: 9499679:27403:4:6
				  trx_wait_started: 2021-04-30 10:17:02
						trx_weight: 3
			   trx_mysql_thread_id: 2
						 trx_query: insert into t values(null, 5, 5)
			   trx_operation_state: inserting
				 trx_tables_in_use: 1
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
		*************************** 3. row ***************************
							trx_id: 9499678
						 trx_state: RUNNING
					   trx_started: 2021-04-30 10:16:03
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 3
			   trx_mysql_thread_id: 3
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
		3 rows in set (0.00 sec)

		root@mysqldb 10:17:  [(none)]> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
			lock_id: 9499680:27403:4:6
		lock_trx_id: 9499680
		  lock_mode: S
		  lock_type: RECORD
		 lock_table: `420_db`.`t`
		 lock_index: c
		 lock_space: 27403
		  lock_page: 4
		   lock_rec: 6
		  lock_data: 5
		*************************** 2. row ***************************
			lock_id: 9499678:27403:4:6
		lock_trx_id: 9499678
		  lock_mode: X
		  lock_type: RECORD
		 lock_table: `420_db`.`t`
		 lock_index: c
		 lock_space: 27403
		  lock_page: 4
		   lock_rec: 6
		  lock_data: 5
		*************************** 3. row ***************************
			lock_id: 9499679:27403:4:6
		lock_trx_id: 9499679
		  lock_mode: S
		  lock_type: RECORD
		 lock_table: `420_db`.`t`
		 lock_index: c
		 lock_space: 27403
		  lock_page: 4
		   lock_rec: 6
		  lock_data: 5
		3 rows in set, 1 warning (0.00 sec)

		root@mysqldb 10:17:  [(none)]> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 9499680
		requested_lock_id: 9499680:27403:4:6
		  blocking_trx_id: 9499678
		 blocking_lock_id: 9499678:27403:4:6
		*************************** 2. row ***************************
		requesting_trx_id: 9499679
		requested_lock_id: 9499679:27403:4:6
		  blocking_trx_id: 9499678
		 blocking_lock_id: 9499678:27403:4:6
		2 rows in set, 1 warning (0.01 sec)

	

		root@mysqldb 10:17:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+----------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                    | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+----------------------------------+-------------------+--------------------+
		| c            | RECORD      | insert into t values(null, 5, 5) | S                 | X                  |
		| c            | RECORD      | insert into t values(null, 5, 5) | S                 | X                  |
		+--------------+-------------+----------------------------------+-------------------+--------------------+
		2 rows in set, 3 warnings (0.00 sec)
		

		死锁日志:
			2021-04-30T10:17:30.276895+08:00 4 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
			2021-04-30T10:17:30.276925+08:00 4 [Note] InnoDB: 
			*** (1) TRANSACTION:

			TRANSACTION 9499679, ACTIVE 28 sec inserting
			mysql tables in use 1, locked 1
			LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
			MySQL thread id 2, OS thread handle 140670100358912, query id 62 localhost root update
			insert into t values(null, 5, 5)
			2021-04-30T10:17:30.277315+08:00 4 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

			RECORD LOCKS space id 27403 page no 4 n bits 72 index c of table `420_db`.`t` trx id 9499679 lock_mode X insert intention waiting
			Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
			 0: len 8; hex 73757072656d756d; asc supremum;;

			2021-04-30T10:17:30.277744+08:00 4 [Note] InnoDB: *** (2) TRANSACTION:

			TRANSACTION 9499680, ACTIVE 14 sec inserting
			mysql tables in use 1, locked 1
			4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
			MySQL thread id 4, OS thread handle 140670099293952, query id 64 localhost root update
			insert into t values(null, 5, 5)
			2021-04-30T10:17:30.277891+08:00 4 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

			RECORD LOCKS space id 27403 page no 4 n bits 72 index c of table `420_db`.`t` trx id 9499680 lock mode S
			Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
			 0: len 8; hex 73757072656d756d; asc supremum;;

			2021-04-30T10:17:30.278148+08:00 4 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

			RECORD LOCKS space id 27403 page no 4 n bits 72 index c of table `420_db`.`t` trx id 9499680 lock_mode X insert intention waiting
			Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
			 0: len 8; hex 73757072656d756d; asc supremum;;

			2021-04-30T10:17:30.278529+08:00 4 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)
					


5. 唯一键冲突加锁			
	root@mysqldb 09:55:  [420_db]> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	+----+------+------+
	4 rows in set (0.06 sec)

	root@mysqldb 09:56:  [420_db]> show create table t\G;
	*************************** 1. row ***************************
		   Table: t
	Create Table: CREATE TABLE `t` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)		
			
	
	session A                                            session B
	insert into t values(10, 10, 10);
	select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	| 10 |   10 |   10 |
	+----+------+------+
	5 rows in set (0.00 sec)

	begin;
	mysql> insert into t values(11, 10, 10);
	ERROR 1062 (23000): Duplicate entry '10' for key 'c'
	
	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 9499653
					 trx_state: RUNNING
				   trx_started: 2021-04-30 09:58:45
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 2
		   trx_mysql_thread_id: 3
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
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
	1 row in set (0.00 sec)

													mysql> insert into t values(12, 9, 9);		



													mysql> select * from information_schema.innodb_trx\G;
													*************************** 1. row ***************************
																		trx_id: 9499655
																	 trx_state: LOCK WAIT
																   trx_started: 2021-04-30 10:00:08
														 trx_requested_lock_id: 9499655:27401:4:6
															  trx_wait_started: 2021-04-30 10:00:08
																	trx_weight: 3
														   trx_mysql_thread_id: 2
																	 trx_query: insert into t values(12, 9, 9)
														   trx_operation_state: inserting
															 trx_tables_in_use: 1
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
													*************************** 2. row ***************************
																		trx_id: 9499653
																	 trx_state: RUNNING
																   trx_started: 2021-04-30 09:58:45
														 trx_requested_lock_id: NULL
															  trx_wait_started: NULL
																	trx_weight: 2
														   trx_mysql_thread_id: 3
																	 trx_query: NULL
														   trx_operation_state: NULL
															 trx_tables_in_use: 0
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
														lock_id: 9499655:27401:4:6
													lock_trx_id: 9499655
													  lock_mode: X,GAP
													  lock_type: RECORD
													 lock_table: `420_db`.`t`
													 lock_index: c
													 lock_space: 27401
													  lock_page: 4
													   lock_rec: 6
													  lock_data: 10
													*************************** 2. row ***************************
														lock_id: 9499653:27401:4:6
													lock_trx_id: 9499653
													  lock_mode: S
													  lock_type: RECORD
													 lock_table: `420_db`.`t`
													 lock_index: c
													 lock_space: 27401
													  lock_page: 4
													   lock_rec: 6
													  lock_data: 10
													2 rows in set, 1 warning (0.00 sec)

													
													mysql> select * from information_schema.innodb_lock_waits\G;
													*************************** 1. row ***************************
													requesting_trx_id: 9499655
													requested_lock_id: 9499655:27401:4:6
													  blocking_trx_id: 9499653
													 blocking_lock_id: 9499653:27401:4:6
													1 row in set, 1 warning (0.00 sec)

													
													mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
													+--------------+-------------+--------------------------------+-------------------+--------------------+
													| locked_index | locked_type | waiting_query                  | waiting_lock_mode | blocking_lock_mode |
													+--------------+-------------+--------------------------------+-------------------+--------------------+
													| c            | RECORD      | insert into t values(12, 9, 9) | X,GAP             | S                  |
													+--------------+-------------+--------------------------------+-------------------+--------------------+
													1 row in set, 3 warnings (0.02 sec)




6. insert into … on duplicate key update

	insert into … on duplicate key update 这个语义的逻辑:
		插入一行数据，如果碰到唯一键约束，就执行后面的更新语句。
		如果有多个列违反了唯一性约束，就会按照索引的顺序，修改跟第一个索引冲突的行。	
	
	样例：
		表 t 里面已经有了 (1,1,1) 和 (2,2,2) 这两行；
		执行语句： insert into t values(2, 1, 100) on duplicate key update d=100;
		主键 id 是先判断的，MySQL 认为这个语句跟 id=2 这一行冲突，所以修改的是 id=2 的行。
		执行这条语句的 affected rows 返回的是 2，很容易造成误解：
			实际上，真正更新的只有一行，只是在代码实现上，insert 和 update 都认为自己成功了，update 计数加了 1， insert 计数也加了 1。	


7. 小结
	第40讲涉及到的东西还挺多。
	

select * from information_schema.innodb_trx\G;
select * from information_schema.innodb_locks\G;
select * from information_schema.innodb_lock_waits\G;
SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
