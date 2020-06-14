
-1. 实验目的	
0. 使用到的相关SQL语句 
1. 初始表结构和数据
2. MySQL 8.0.18

	2.1 环境1--事务隔离级别为RC读已提交
	2.2 环境2--事务隔离级别为RR可重复读
	


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
		
	MySQL 8.0.18
		select * from information_schema.innodb_trx\G;
		SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
		select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		
		
	select version();
	show global variables like '%innodb_autoinc_lock_mode%';
	show global variables like '%isolation%';
	select @@session.transaction_isolation;

	truncate table _t_new;
	--ALTER TABLE t auto_increment=500001;
	SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='sbtest' and table_name="t";
	SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='sbtest' and table_name="_t_new";

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
	| 8.0.18-log |
	+------------+
	1 row in set (0.00 sec)

2.1 环境1--事务隔离级别为RC读已提交
	root@mysqldb 03:11:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='sbtest' and table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              6 |
	+----------------+
	1 row in set (0.00 sec)

	root@mysqldb 03:11:  [(none)]> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)

	session A           session B

	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
						begin;	  
						SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
						(Blocked)
						
	root@mysqldb 11:11:  [(none)]> select * from information_schema.innodb_trx\G;
	ERROR 2006 (HY000): MySQL server has gone away
	No connection. Trying to reconnect...
	Connection id:    18
	Current database: *** NONE ***

	*************************** 1. row ***************************
						trx_id: 1005113
					 trx_state: RUNNING
				   trx_started: 2020-05-24 19:43:50
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 16
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 2
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 1
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
						trx_id: 422045737233872
					 trx_state: LOCK WAIT
				   trx_started: 2020-05-24 19:44:48
		 trx_requested_lock_id: 140570760523216:281:4:7:140570655784912
			  trx_wait_started: 2020-05-24 19:44:48
					trx_weight: 3
		   trx_mysql_thread_id: 17
					 trx_query: SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE
		   trx_operation_state: fetching rows
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 6
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

	ERROR: 
	No query specified

	root@mysqldb 19:44:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;

	*************************** 1. row ***************************
		  locked_index: PRIMARY
		   locked_type: RECORD
		 waiting_query: SELECT * from t WHERE ((`id` > ... d` <= '5')) LOCK IN SHARE MODE
	 waiting_lock_mode: S,REC_NOT_GAP
	blocking_lock_mode: X,REC_NOT_GAP
	1 row in set (0.12 sec)

	ERROR: 
	No query specified

	root@mysqldb 19:44:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760522344:1338:140570655781544    |               1005113 |        66 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140570760522344:281:4:7:140570655778504 |               1005113 |        67 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 6         |
	| 140570760523216:1338:140570655787496    |       422045737233872 |        67 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760523216:281:4:2:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140570760523216:281:4:3:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140570760523216:281:4:4:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760523216:281:4:5:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760523216:281:4:6:140570655784568 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 140570760523216:281:4:7:140570655784912 |       422045737233872 |        67 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 6         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.00 sec)


2.2 环境2--事务隔离级别为RR可重复读
	ALTER TABLE t auto_increment=6;
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

	root@mysqldb 03:08:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='sbtest' and table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              6 |
	+----------------+
	1 row in set (0.04 sec)

	root@mysqldb 03:08:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema='sbtest' and table_name="_t_new";
	Empty set (0.00 sec)


	session A           session B
	
	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');  							
	Query OK, 1 row affected (0.00 sec)
						begin;  
						SELECT * from t WHERE ((`id` >= '1')) AND ((`id` <= '5')) LOCK IN SHARE MODE;
	
						Query OK, 5 rows affected (0.00 sec)
						Records: 5  Duplicates: 0  Warnings: 0

	select * from information_schema.innodb_trx\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

	root@mysqldb 19:48:  [(none)]> select * from information_schema.innodb_trx\G;
	,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	*************************** 1. row ***************************
						trx_id: 1005121
					 trx_state: RUNNING
				   trx_started: 2020-05-24 19:48:07
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 2
		   trx_mysql_thread_id: 21
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
	*************************** 2. row ***************************
						trx_id: 422045737233872
					 trx_state: RUNNING
				   trx_started: 2020-05-24 19:48:49
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 22
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 5
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

	
	root@mysqldb 19:49:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760522344:1338:140570655781544    |               1005121 |        71 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140570760523216:1338:140570655787496    |       422045737233872 |        72 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760523216:281:4:2:140570655784568 |       422045737233872 |        72 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140570760523216:281:4:3:140570655784912 |       422045737233872 |        72 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 2         |
	| 140570760523216:281:4:4:140570655784912 |       422045737233872 |        72 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 3         |
	| 140570760523216:281:4:5:140570655784912 |       422045737233872 |        72 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4         |
	| 140570760523216:281:4:6:140570655784912 |       422045737233872 |        72 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 5         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)




\