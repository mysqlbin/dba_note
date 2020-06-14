
-1. 实验目的	
0. 使用到的相关SQL语句 
1. 初始表结构和数据
2. MySQL 8.0.19
	2.1 环境1 --事务隔离级别为RC读已提交
	2.2 环境2 --事务隔离级别为RR可重复读
3. 	MySQL 5.7.22



-1. 实验目的：
	参数innodb_autoinc_lock_mode=1：INSERT IGNORE INTO `_t_new` ... selet ... from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) lock in share mode; 在 8.0.19  版本中RC或者RR隔离级别还需要申请 t.id = 500001 的主键记录锁吗
		 在 8.0.18 版本中优化了唯一索引范围 bug（RC隔离级别也是如此吗），如下： 

			session A                                       session B                                                                                                                                                                                     
			begin;
			select * from t where id>10 and id<=15 for update;
															update t set d=d+1 where id=20;
															(Query OK)  
		可以通过实验验证下。

0. 使用到的相关SQL语句 

	create  database zst DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		
	MySQL 5.7 
		select * from information_schema.innodb_trx\G;
		select * from information_schema.innodb_locks\G;
		select * from information_schema.innodb_lock_waits\G;
		SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		
	MySQL 8.0.19
		select * from information_schema.innodb_trx\G;
		SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
		
		pager less
		select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		
		
	select version();
	show global variables like '%innodb_autoinc_lock_mode%';
	show global variables like '%isolation%';
	select @@session.transaction_isolation;

	truncate table _t_new;
	--ALTER TABLE t auto_increment=500001;
	SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='zst' and table_name="t";
	SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='zst' and table_name="_t_new";

	show create table _t_new\G;

	set global innodb_flush_log_at_trx_commit=1;
	set global sync_binlog=1;


1. 初始表结构和数据、数据库版本

	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


	CREATE TABLE `_t_new` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  `CreateTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`) USING BTREE
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


	DROP PROCEDURE IF EXISTS `idata`;
	DELIMITER ;;
	CREATE DEFINER=`root`@`%` PROCEDURE `idata`()
	begin
	  declare i int;
	  set i=1;
		start transaction;
	  while(i<=5) do
		INSERT INTO t (c,d) values (i,i);
		set i=i+1;
	  end while;
		commit;
	end
	;;
	DELIMITER ;

	call idata();

	root@mysqldb 18:06:  [(none)]> select version();
	+------------+
	| version()  |
	+------------+
	| 8.0.19-log |
	+------------+
	1 row in set (0.00 sec)

2.1 环境1 --事务隔离级别为RC读已提交

	session A           session B

	begin;	            begin;

	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
							  
						INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Blocked)

2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
	root@mysqldb 12:51:  [zst]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

	root@mysqldb 12:51:  [zst]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.01 sec)

	root@mysqldb 12:51:  [zst]> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.00 sec)

	root@mysqldb 12:51:  [zst]> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 12:52:  [zst]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='zst' and table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              6 |
	+----------------+
	1 row in set (0.01 sec)

	root@mysqldb 12:53:  [zst]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='zst' and table_name="_t_new";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|           NULL |
	+----------------+

	session A           session B
	
	begin;	            begin;

	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
	Query OK, 1 row affected (0.00 sec)
						  
						INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
	
						Query OK, 5 rows affected (0.00 sec)
						Records: 5  Duplicates: 0  Warnings: 0

	select * from information_schema.innodb_trx\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

	root@mysqldb 14:58:  [sbtest]> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 1003812
					 trx_state: RUNNING
				   trx_started: 2020-05-17 14:58:34
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 9
		   trx_mysql_thread_id: 35
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 2
			  trx_lock_structs: 4
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 5
			 trx_rows_modified: 5
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
						trx_id: 1003806
					 trx_state: RUNNING
				   trx_started: 2020-05-17 14:58:32
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 2
		   trx_mysql_thread_id: 36
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
	2 rows in set (0.01 sec)

	root@mysqldb 14:58:  [sbtest]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	Empty set (0.03 sec)


	root@mysqldb 14:58:  [sbtest]> 
	root@mysqldb 14:58:  [sbtest]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140665283602440:1338:140665212194808    |               1003812 |        85 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140665283602440:281:4:2:140665212191768 |               1003812 |        85 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140665283602440:1341:140665212194896    |               1003812 |        85 | _t_new      | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140665283602440:281:4:3:140665212192112 |               1003812 |        85 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 2         |
	| 140665283602440:281:4:4:140665212192112 |               1003812 |        85 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 3         |
	| 140665283602440:281:4:5:140665212192112 |               1003812 |        85 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4         |
	| 140665283602440:281:4:6:140665212192112 |               1003812 |        85 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 5         |
	| 140665283598952:1338:140665212170920    |               1003806 |        86 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	8 rows in set (0.00 sec)




	
3.1 

5.7 

select version();
show global variables like '%innodb_autoinc_lock_mode%';
show global variables like '%isolation%';
select @@session.tx_isolation;


mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.02 sec)

mysql> show global variables like '%innodb_autoinc_lock_mode%';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| innodb_autoinc_lock_mode | 1     |
+--------------------------+-------+
1 row in set (0.42 sec)

mysql> show global variables like '%isolation%';
+-----------------------+-----------------+
| Variable_name         | Value           |
+-----------------------+-----------------+
| transaction_isolation | REPEATABLE-READ |
| tx_isolation          | REPEATABLE-READ |
+-----------------------+-----------------+
2 rows in set (0.00 sec)

mysql> select @@session.tx_isolation;
+------------------------+
| @@session.tx_isolation |
+------------------------+
| REPEATABLE-READ        |
+------------------------+
1 row in set, 1 warning (0.00 sec)

truncate table _t_new;
--ALTER TABLE t auto_increment=500001;
SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='partition_db' and table_name="t";
SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='partition_db' and table_name="_t_new";

mysql> truncate table _t_new;
and table_name="_t_new";Query OK, 0 rows affected (0.09 sec)

mysql> --ALTER TABLE t auto_increment=500001;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '--ALTER TABLE t auto_increment=500001' at line 1
mysql> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='partition_db' and table_name="t";
+----------------+
| AUTO_INCREMENT |
+----------------+
|              6 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='partition_db' and table_name="_t_new";
+----------------+
| AUTO_INCREMENT |
+----------------+
|              1 |
+----------------+
1 row in set (0.00 sec)


	session A           session B

	begin;	            begin;

	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
	Query OK, 1 row affected (0.00 sec)
						  
						INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Blocked)
						
	mysql> select * from information_schema.innodb_trx\G;
	ock_waits;*************************** 1. row ***************************
						trx_id: 276870520
					 trx_state: LOCK WAIT
				   trx_started: 2020-05-17 15:00:03
		 trx_requested_lock_id: 276870520:2256:3:7
			  trx_wait_started: 2020-05-17 15:00:03
					trx_weight: 11
		   trx_mysql_thread_id: 163667
					 trx_query: INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE
		   trx_operation_state: fetching rows
			 trx_tables_in_use: 2
			 trx_tables_locked: 3
			  trx_lock_structs: 6
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 6
			 trx_rows_modified: 5
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
						trx_id: 276870519
					 trx_state: RUNNING
				   trx_started: 2020-05-17 15:00:01
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 160537
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
	2 rows in set (0.01 sec)

	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 276870520:2256:3:7
	lock_trx_id: 276870520
	  lock_mode: S
	  lock_type: RECORD
	 lock_table: `partition_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 2256
	  lock_page: 3
	   lock_rec: 7
	  lock_data: 6
	*************************** 2. row ***************************
		lock_id: 276870519:2256:3:7
	lock_trx_id: 276870519
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `partition_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 2256
	  lock_page: 3
	   lock_rec: 7
	  lock_data: 6
	2 rows in set, 1 warning (0.00 sec)

	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 276870520
	requested_lock_id: 276870520:2256:3:7
	  blocking_trx_id: 276870519
	 blocking_lock_id: 276870519:2256:3:7
	1 row in set, 1 warning (0.00 sec)


	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                                                     | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | INSERT LOW_PRIORITY IGNORE INT ... d` <= '5')) LOCK IN SHARE MODE | S                 | X                  |
	+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.01 sec)
							