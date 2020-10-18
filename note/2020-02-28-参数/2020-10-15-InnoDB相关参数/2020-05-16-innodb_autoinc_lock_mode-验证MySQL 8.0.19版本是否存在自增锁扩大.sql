
0. 使用到的相关SQL语句 
1. 初始表结构和数据
2. MySQL 8.0.19
	2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
	2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
3. 小结
4. 相关参考

-1. 实验目的 

	验证 innodb_autoinc_lock_mode=1： 
		INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
		在 8.0.18 以上的版本中还需要持有 _t_new.id > 500000 的自增锁吗
			
0. 使用到的相关SQL语句 

	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;

	select version();
	show global variables like '%innodb_autoinc_lock_mode%';
	show global variables like '%isolation%';
	select @@session.transaction_isolation;

	truncate table _t_new;
	--ALTER TABLE t auto_increment=500001;
	SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="t";
	SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="_t_new";

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
	  while(i<=500000) do
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
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)



2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.01 sec)

	mysql> show global variables like '%isolation%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	+-----------------------+----------------+
	1 row in set (0.01 sec)

	mysql> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|         500001 |
	+----------------+
	1 row in set (0.01 sec)

	mysql> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="_t_new";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|           NULL |
	+----------------+
	1 row in set (0.00 sec)

	session A             session B

	begin;
	INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
						  INSERT INTO `_t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001'); 
						  (Blocked)
	Query OK, 500000 rows affected (29.80 sec)
	Records: 500000  Duplicates: 0  Warnings: 0
						 
							
	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	*************************** 1. row ***************************
	      locked_index: NULL
	       locked_type: TABLE
	     waiting_query: INSERT INTO `_t_new` (`id`, `c`, ... ('500001', '500001', '500001')
	 waiting_lock_mode: AUTO_INC
	blocking_lock_mode: AUTO_INC
	1 row in set (0.14 sec)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

	+------------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                           | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+------------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140402122887480:1064:140402011218008     |                  1755 |        69 | _t_new      | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140402122887480:1064:140402011218096     |                  1755 |        69 | _t_new      | NULL       | TABLE     | AUTO_INC      | WAITING     | NULL      |
	| 140402122886608:1059:140402011212024     |                  1750 |        68 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140402122886608:2:6:2:140402011209096    |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140402122886608:2:6:3:140402011209096    |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140402122886608:2:6:4:140402011209096    |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140402122886608:2:6:5:140402011209096    |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140402122886608:2:6:6:140402011209096    |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 140402122886608:2:6:7:140402011209096    |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 6         |
	| 140402122886608:2:6:8:140402011209096    |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 7         |
	| 140402122886608:2:6:9:140402011209096    |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 8         |
	| 140402122886608:2:6:10:140402011209096   |                  1750 |        68 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 9         |


2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)

	rmysql> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.01 sec)

	mysql> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.01 sec)

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)

	mysql> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|         500001 |
	+----------------+
	1 row in set (0.01 sec)

	mysql> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="_t_new";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|           NULL |
	+----------------+
	1 row in set (0.00 sec)

	session A             session B

	begin;
	INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
						  INSERT INTO `_t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001'); 
						  (Blocked)
	Query OK, 500000 rows affected (29.80 sec)
	Records: 500000  Duplicates: 0  Warnings: 0
						 

	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
	                    trx_id: 1826
	                 trx_state: LOCK WAIT
	               trx_started: 2020-05-16 15:19:12
	     trx_requested_lock_id: 140402122887480:1066:140402011218096
	          trx_wait_started: 2020-05-16 15:19:12
	                trx_weight: 3
	       trx_mysql_thread_id: 68
	                 trx_query: INSERT INTO `_t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001')
	       trx_operation_state: setting auto-inc lock
	         trx_tables_in_use: 1
	         trx_tables_locked: 2
	          trx_lock_structs: 2
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
	                    trx_id: 1821
	                 trx_state: RUNNING
	               trx_started: 2020-05-16 15:19:10
	     trx_requested_lock_id: NULL
	          trx_wait_started: NULL
	                trx_weight: 81816
	       trx_mysql_thread_id: 57
	                 trx_query: INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
	       trx_operation_state: NULL
	         trx_tables_in_use: 2
	         trx_tables_locked: 3
	          trx_lock_structs: 196
	     trx_lock_memory_bytes: 41168
	           trx_rows_locked: 81811
	         trx_rows_modified: 81620
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


	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	*************************** 1. row ***************************
	      locked_index: NULL
	       locked_type: TABLE
	     waiting_query: INSERT INTO `_t_new` (`id`, `c`, ... ('500001', '500001', '500001')
	 waiting_lock_mode: AUTO_INC
	blocking_lock_mode: AUTO_INC
	1 row in set (0.50 sec)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;

	+-------------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
	| ENGINE_LOCK_ID                            | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA              |
	+-------------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+------------------------+
	| 140402122887480:1066:140402011218008      |                  1826 |       118 | _t_new      | NULL       | TABLE     | IX            | GRANTED     | NULL                   |
	| 140402122887480:1066:140402011218096      |                  1826 |       118 | _t_new      | NULL       | TABLE     | AUTO_INC      | WAITING     | NULL                   |
	| 140402122885736:1059:140402011206072      |                  1821 |       107 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL                   |
	| 140402122885736:2:6:2:140402011203032     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1                      |
	| 140402122885736:1066:140402011206160      |                  1821 |       107 | _t_new      | NULL       | TABLE     | IX            | GRANTED     | NULL                   |
	| 140402122885736:1066:140399000739096      |                  1821 |       107 | _t_new      | NULL       | TABLE     | AUTO_INC      | GRANTED     | NULL                   |
	| 140402122885736:2:6:1:140402011203376     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | supremum pseudo-record |
	| 140402122885736:2:6:3:140402011203376     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 2                      |
	| 140402122885736:2:6:4:140402011203376     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 3                      |
	| 140402122885736:2:6:5:140402011203376     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 4                      |
	| 140402122885736:2:6:6:140402011203376     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 5                      |
	| 140402122885736:2:6:7:140402011203376     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 6                      |
	| 140402122885736:2:6:8:140402011203376     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 7                      |
	| 140402122885736:2:6:9:140402011203376     |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 8                      |
	| 140402122885736:2:6:10:140402011203376    |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 9                      |
	| 140402122885736:2:6:11:140402011203376    |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 10                     |
	| 140402122885736:2:6:12:140402011203376    |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 11                     |
	| 140402122885736:2:6:13:140402011203376    |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 12                     |
	| 140402122885736:2:6:14:140402011203376    |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 13                     |
	| 140402122885736:2:6:15:140402011203376    |                  1821 |       107 | t           | PRIMARY    | RECORD    | S             | GRANTED     | 14                     |

	select * from information_schema.innodb_trx\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;


3. 小结

	1. innodb_autoinc_lock_mode=1： INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
		 在 8.0.18 以上的版本中还需要持有 _t_new.id > 500000 的自增锁吗

		答： 需要。 实验如下：
			2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
			2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读



6. 相关参考
	https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_autoinc_lock_mode
	https://dev.mysql.com/doc/refman/8.0/en/innodb-auto-increment-handling.html#innodb-auto-increment-lock-modes


