
1. 初始化表分区结构和数据
2. 分区表 t 的加锁范围
3. 分区表共用MDL锁


1. 初始化表分区结构和数据
	CREATE TABLE `t` (
	  `ftime` datetime NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  KEY (`ftime`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1
	PARTITION BY RANGE (YEAR(ftime))
	(PARTITION p_2017 VALUES LESS THAN (2017) ENGINE = InnoDB,
	 PARTITION p_2018 VALUES LESS THAN (2018) ENGINE = InnoDB,
	 PARTITION p_2019 VALUES LESS THAN (2019) ENGINE = InnoDB,
	PARTITION p_others VALUES LESS THAN MAXVALUE ENGINE = InnoDB);
	insert into t values('2017-4-1',1),('2018-4-1',1);
	
	表 t 的磁盘文件
		-rw-r----- 1 mysql mysql    114688 2020-04-23 15:15 t#P#p_2017.ibd
		-rw-r----- 1 mysql mysql    114688 2020-04-23 15:15 t#P#p_2018.ibd
		-rw-r----- 1 mysql mysql    114688 2020-04-23 15:15 t#P#p_2019.ibd
		-rw-r----- 1 mysql mysql    114688 2020-04-23 15:15 t#P#p_others.ibd
		-rw-r----- 1 mysql mysql      8586 2020-04-23 15:15 t.frm

	desc select * from t where ftime='2017-4-1';
	desc select * from t where ftime='2018-4-1';

	mysql> desc select * from t where ftime='2017-4-1';
	+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------+
	| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref   | rows | filtered | Extra |
	+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t     | p_2018     | ref  | ftime         | ftime | 5       | const |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)

	mysql> desc select * from t where ftime='2018-4-1';
	+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------+
	| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref   | rows | filtered | Extra |
	+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------+
	|  1 | SIMPLE      | t     | p_2019     | ref  | ftime         | ftime | 5       | const |    1 |   100.00 | NULL  |
	+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------+
	1 row in set, 1 warning (0.00 sec)
	
	
	2017-4-1 落在了 p_2018 分区, 2018-4-1 落在了 p_2019 分区
	


2. 分区表 t 的加锁范围

	session A                           			session B                               session C

	start transaction;
	select * from t where ftime='2017-5-1' for update; 
			
													insert into t values('2018-2-1',1);
													insert into t values('2017-12-1',1);
													
													
																							select * from sys.innodb_lock_waits\G;
																							show engine innodb status\G;

	mysql> select * from sys.innodb_lock_waits\G;
		*************************** 1. row ***************************
						wait_started: 2020-04-23 16:08:23
							wait_age: 00:00:17
					   wait_age_secs: 17
						locked_table: `partition_db`.`t` /* Partition `p_2018` */
						locked_index: ftime
						 locked_type: RECORD
					  waiting_trx_id: 276595788
				 waiting_trx_started: 2020-04-23 16:08:23
					 waiting_trx_age: 00:00:17
			 waiting_trx_rows_locked: 1
		   waiting_trx_rows_modified: 1
						 waiting_pid: 74727
					   waiting_query: insert into t values('2017-12-1',1)
					 waiting_lock_id: 276595788:2064:4:1
				   waiting_lock_mode: X
					 blocking_trx_id: 276595777
						blocking_pid: 82264
					  blocking_query: NULL
					blocking_lock_id: 276595777:2064:4:1
				  blocking_lock_mode: X
				blocking_trx_started: 2020-04-23 16:07:47
					blocking_trx_age: 00:00:53
			blocking_trx_rows_locked: 3
		  blocking_trx_rows_modified: 0
			 sql_kill_blocking_query: KILL QUERY 82264
		sql_kill_blocking_connection: KILL 82264
		1 row in set, 3 warnings (0.07 sec)


	show engine innodb status\G;
		---TRANSACTION 276595795, ACTIVE 8 sec inserting
		mysql tables in use 1, locked 1
		LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
		MySQL thread id 74727, OS thread handle 139788282091264, query id 1621922 localhost root update
		insert into t values('2017-12-1',1)
		------- TRX HAS BEEN WAITING 8 SEC FOR THIS LOCK TO BE GRANTED:
		RECORD LOCKS space id 2064 page no 4 n bits 72 index ftime of table `partition_db`.`t` /* Partition `p_2018` */ trx id 276595795 lock_mode X insert intention waiting
		Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
		 0: len 8; hex 73757072656d756d; asc supremum;;

	
	
3. 分区表共用MDL锁
				
	session A										session B                                       session C
	begin;
	select * from t where ftime='2018-4-1';
													alter table t truncate PARTITION p_2018;
																									show processlist; 
																									select * from sys.schema_table_lock_waits\G;	
																									select * from information_schema.innodb_trx\G;
	mysql> show processlist;.
	+-------+-----------------+---------------------+--------------+---------+---------+---------------------------------+-----------------------------------------+
	| Id    | User            | Host                | db           | Command | Time    | State                           | Info                                    |
	+-------+-----------------+---------------------+--------------+---------+---------+---------------------------------+-----------------------------------------+
	|     1 | event_scheduler | localhost           | NULL         | Daemon  |   44167 | Waiting for next activation     | NULL                                    |

	| 72266 | root            | localhost           | audit_db     | Query   |       0 | starting                        | show processlist                        |
	| 74727 | root            | localhost           | partition_db | Query   |      15 | Waiting for table metadata lock | alter table t truncate PARTITION p_2018 |


	mysql>select * from sys.schema_table_lock_waits\G;
	*************************** 1. row ***************************
				   object_schema: partition_db
					 object_name: t
			   waiting_thread_id: 74761
					 waiting_pid: 74727
				 waiting_account: root@localhost
			   waiting_lock_type: EXCLUSIVE
		   waiting_lock_duration: TRANSACTION
				   waiting_query: alter table t truncate PARTITION p_2018
			  waiting_query_secs: 78
	 waiting_query_rows_affected: 0
	 waiting_query_rows_examined: 0
			  blocking_thread_id: 82299
					blocking_pid: 82265
				blocking_account: root@localhost
			  blocking_lock_type: SHARED_READ
		  blocking_lock_duration: TRANSACTION
		 sql_kill_blocking_query: KILL QUERY 82265
	sql_kill_blocking_connection: KILL 82265
	1 row in set (0.01 sec)


	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 421269807800336
					 trx_state: RUNNING
				   trx_started: 2020-04-23 16:45:42
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 0
		   trx_mysql_thread_id: 82265
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


	mysql> kill  74727;
	Query OK, 0 rows affected (0.00 sec)

		
	mysql> alter table t truncate PARTITION p_2018;
	ERROR 2013 (HY000): Lost connection to MySQL server during query
	

	mysql> select * from t where ftime='2017-4-1';
	+---------------------+------+
	| ftime               | c    |
	+---------------------+------+
	| 2017-04-01 00:00:00 |    1 |
	+---------------------+------+
	1 row in set (0.00 sec)

