

1. 初始表结构和数据
2. binlog_row_image=FULL and binlog_format=ROW 
3. binlog_row_image=FULL and binlog_format=statement
4. binlog_row_image=FULL and binlog_format=mixed
5. 小结
6. 相关参考 


1. 初始表结构和数据
	CREATE TABLE `t` (
	`id` int(11) NOT NULL primary key auto_increment,
	`a` int(11) DEFAULT NULL
	) ENGINE=InnoDB;

	insert into t values(1,2);


2. binlog_row_image=FULL and binlog_format=ROW 

	show global variables like 'binlog_row_image';
	show global variables like 'binlog_format';
	mysql> show global variables like 'binlog_row_image';

	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| binlog_row_image | FULL  |
	+------------------+-------+
	1 row in set (0.58 sec)

	mysql> show global variables like 'binlog_format';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| binlog_format | ROW   |
	+---------------+-------+
	1 row in set (0.01 sec)


		
	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000029 |       761 |
	| mysql-bin.000030 |       194 |
	+------------------+-----------+
	17 rows in set (0.00 sec)

	
	mysql> update t set a=2 where id=1;
	Query OK, 0 rows affected (0.00 sec)
	Rows matched: 1  Changed: 0  Warnings: 0


	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000029 |       761 |
	| mysql-bin.000030 |       194 |
	+------------------+-----------+
	17 rows in set (0.00 sec)

	-- 执行了更新语句，发现没有写binlog

	------------------------------------------------------------------

	session A               session B

	begin;										
	update t set a=2 where id=1;

							begin;										
							select * from t where id=1 for update; 
							(Blocked)
							
	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 2957898
					 trx_state: LOCK WAIT
				   trx_started: 2020-10-30 16:49:27
		 trx_requested_lock_id: 2957898:91:3:2
			  trx_wait_started: 2020-10-30 16:49:27
					trx_weight: 2
		   trx_mysql_thread_id: 27
					 trx_query: select * from t where id=1 for update
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
						trx_id: 2957897
					 trx_state: RUNNING
				   trx_started: 2020-10-30 16:49:15
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 2
		   trx_mysql_thread_id: 20
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
	2 rows in set (1.00 sec)

	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 2957898:91:3:2
	lock_trx_id: 2957898
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 91
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	*************************** 2. row ***************************
		lock_id: 2957897:91:3:2
	lock_trx_id: 2957897
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 91
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	2 rows in set, 1 warning (0.07 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 2957898
	requested_lock_id: 2957898:91:3:2
	  blocking_trx_id: 2957897
	 blocking_lock_id: 2957897:91:3:2
	1 row in set, 1 warning (0.00 sec)


	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                         | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | select * from t where id=1 for update | X                 | X                  |
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.46 sec)
		

	-- 虽然没有写binlog，但是需要对行记录加锁。
	
	
3. binlog_row_image=FULL and binlog_format=statement 
	
	set global binlog_format=statement;
	
		
	mysql> show global variables like 'binlog_row_image';

	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| binlog_row_image | FULL  |
	+------------------+-------+
	1 row in set (0.12 sec)

	mysql> show global variables like 'binlog_format';
	+---------------+-----------+
	| Variable_name | Value     |
	+---------------+-----------+
	| binlog_format | STATEMENT |
	+---------------+-----------+
	1 row in set (0.00 sec)

	
	
	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000029 |       761 |
	| mysql-bin.000030 |       194 |
	+------------------+-----------+
	17 rows in set (0.00 sec)


	mysql> update t set a=2 where id=1;
	Query OK, 0 rows affected (0.01 sec)
	Rows matched: 1  Changed: 0  Warnings: 0

	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000029 |       761 |
	| mysql-bin.000030 |       482 |
	+------------------+-----------+
	17 rows in set (0.00 sec)


		mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000030

		[root@localhost logs]# mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000030
		/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
		/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
		DELIMITER /*!*/;
		# at 4
		#201030 16:47:46 server id 330607  end_log_pos 123 CRC32 0xa7f6735f 	Start: binlog v 4, server v 5.7.22-log created 201030 16:47:46
		# Warning: this binlog is either in use or was not closed properly.
		# at 123
		#201030 16:47:46 server id 330607  end_log_pos 194 CRC32 0xea91fba3 	Previous-GTIDs
		# 9e520b78-013c-11eb-a84c-0800271bf591:1-2950278
		# at 194
		#201030 17:13:26 server id 330607  end_log_pos 259 CRC32 0x37a3df95 	GTID	last_committed=0	sequence_number=1	rbr_only=no
		SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:2950279'/*!*/;
		# at 259
		#201030 17:13:26 server id 330607  end_log_pos 344 CRC32 0x2845d9a9 	Query	thread_id=29	exec_time=0	error_code=0
		SET TIMESTAMP=1604049206/*!*/;
		SET @@session.pseudo_thread_id=29/*!*/;
		SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
		SET @@session.sql_mode=1075838976/*!*/;
		SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
		/*!\C utf8 *//*!*/;
		SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
		SET @@session.lc_time_names=0/*!*/;
		SET @@session.collation_database=DEFAULT/*!*/;
		BEGIN
		/*!*/;
		# at 344
		#201030 17:13:26 server id 330607  end_log_pos 451 CRC32 0x5e886223 	Query	thread_id=29	exec_time=0	error_code=0
		use `test_db`/*!*/;
		SET TIMESTAMP=1604049206/*!*/;
		update t set a=2 where id=1
		/*!*/;
		# at 451
		#201030 17:13:26 server id 330607  end_log_pos 482 CRC32 0x8a8f1f26 	Xid = 8851928
		COMMIT/*!*/;
		SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
		DELIMITER ;
		# End of log file
		/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
		/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;

	
	
	-- 执行了更新语句，发现有写binlog

	------------------------------------------------------------------

	session A               session B

	begin;										
	update t set a=2 where id=1;

							begin;										
							select * from t where id=1 for update; 
							(Blocked)
							
							
							
						
	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000029 |       761 |
	| mysql-bin.000030 |       529 |
	| mysql-bin.000031 |       194 |
	+------------------+-----------+
	18 rows in set (0.00 sec)
		

	mysql> select * from information_schema.innodb_trx\G;
	its;

	*************************** 1. row ***************************
						trx_id: 2957910
					 trx_state: LOCK WAIT
				   trx_started: 2020-10-30 17:18:31
		 trx_requested_lock_id: 2957910:91:3:2
			  trx_wait_started: 2020-10-30 17:18:31
					trx_weight: 2
		   trx_mysql_thread_id: 28
					 trx_query: select * from t where id=1 for update
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
						trx_id: 2957909
					 trx_state: RUNNING
				   trx_started: 2020-10-30 17:18:01
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 29
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
	2 rows in set (0.71 sec)

	
	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 2957910:91:3:2
	lock_trx_id: 2957910
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 91
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	*************************** 2. row ***************************
		lock_id: 2957909:91:3:2
	lock_trx_id: 2957909
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 91
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 2957910
	requested_lock_id: 2957910:91:3:2
	  blocking_trx_id: 2957909
	 blocking_lock_id: 2957909:91:3:2
	1 row in set, 1 warning (0.00 sec)



	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                         | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | select * from t where id=1 for update | X                 | X                  |
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.13 sec)





4. binlog_row_image=FULL and binlog_format=mixed 
	
	show global variables like 'binlog_row_image';
	show global variables like 'binlog_format';
		
	mysql> show global variables like 'binlog_row_image';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| binlog_row_image | FULL  |
	+------------------+-------+
	1 row in set (0.04 sec)

	mysql> show global variables like 'binlog_format';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| binlog_format | MIXED |
	+---------------+-------+
	1 row in set (0.00 sec)

	
	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000029 |       761 |
	| mysql-bin.000030 |       529 |
	| mysql-bin.000031 |       241 |
	| mysql-bin.000032 |       194 |
	+------------------+-----------+
	19 rows in set (0.00 sec)

	mysql> update t set a=2 where id=1;
	Query OK, 0 rows affected (0.01 sec)
	Rows matched: 1  Changed: 0  Warnings: 0


	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000029 |       761 |
	| mysql-bin.000030 |       529 |
	| mysql-bin.000031 |       241 |
	| mysql-bin.000032 |       482 |
	+------------------+-----------+
	19 rows in set (0.00 sec)


		mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000032

		[root@localhost logs]# mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000032
		/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
		/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
		DELIMITER /*!*/;
		# at 4
		#201030 17:20:44 server id 330607  end_log_pos 123 CRC32 0x71ddba01 	Start: binlog v 4, server v 5.7.22-log created 201030 17:20:44
		# Warning: this binlog is either in use or was not closed properly.
		# at 123
		#201030 17:20:44 server id 330607  end_log_pos 194 CRC32 0x89b8d0aa 	Previous-GTIDs
		# 9e520b78-013c-11eb-a84c-0800271bf591:1-2950279
		# at 194
		#201030 17:21:47 server id 330607  end_log_pos 259 CRC32 0x233f7bd9 	GTID	last_committed=0	sequence_number=1	rbr_only=no
		SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:2950280'/*!*/;
		# at 259
		#201030 17:21:47 server id 330607  end_log_pos 344 CRC32 0x05450836 	Query	thread_id=32	exec_time=0	error_code=0
		SET TIMESTAMP=1604049707/*!*/;
		SET @@session.pseudo_thread_id=32/*!*/;
		SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
		SET @@session.sql_mode=1075838976/*!*/;
		SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
		/*!\C utf8 *//*!*/;
		SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
		SET @@session.lc_time_names=0/*!*/;
		SET @@session.collation_database=DEFAULT/*!*/;
		BEGIN
		/*!*/;
		# at 344
		#201030 17:21:47 server id 330607  end_log_pos 451 CRC32 0x67cbd6e6 	Query	thread_id=32	exec_time=0	error_code=0
		use `test_db`/*!*/;
		SET TIMESTAMP=1604049707/*!*/;
		update t set a=2 where id=1
		/*!*/;
		# at 451
		#201030 17:21:47 server id 330607  end_log_pos 482 CRC32 0x523a160a 	Xid = 8851990
		COMMIT/*!*/;
		SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
		DELIMITER ;
		# End of log file
		/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
		/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;

	
	-- 执行了更新语句，发现有写binlog

	------------------------------------------------------------------

	session A               session B

	begin;										
	update t set a=2 where id=1;

							begin;										
							select * from t where id=1 for update; 
							(Blocked)
							
	
	
	mysql> select * from information_schema.innodb_trx\G;
	*************************** 1. row ***************************
						trx_id: 2957915
					 trx_state: LOCK WAIT
				   trx_started: 2020-10-30 17:33:07
		 trx_requested_lock_id: 2957915:91:3:2
			  trx_wait_started: 2020-10-30 17:33:07
					trx_weight: 2
		   trx_mysql_thread_id: 31
					 trx_query: select * from t where id=1 for update
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
						trx_id: 2957914
					 trx_state: RUNNING
				   trx_started: 2020-10-30 17:32:32
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 32
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

	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 2957915:91:3:2
	lock_trx_id: 2957915
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 91
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	*************************** 2. row ***************************
		lock_id: 2957914:91:3:2
	lock_trx_id: 2957914
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `test_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 91
	  lock_page: 3
	   lock_rec: 2
	  lock_data: 1
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 2957915
	requested_lock_id: 2957915:91:3:2
	  blocking_trx_id: 2957914
	 blocking_lock_id: 2957914:91:3:2
	1 row in set, 1 warning (0.00 sec)



	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                         | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | select * from t where id=1 for update | X                 | X                  |
	+--------------+-------------+---------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.01 sec)
		
	select * from information_schema.innodb_trx\G;
	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;


5. 小结

	binlog_row_image=FULL and binlog_format=ROW ：      加锁，不写binlog
		
	binlog_row_image=FULL and binlog_format=statement ：加锁，写binlog
		
	binlog_row_image=FULL and binlog_format=mixed ：    加锁，写binlog
		
	是否记录binlog，跟 binlog_format 参数的设置有关系。
		
	其中，binlog_format=ROW 格式下，会修改 .ibd 文件 

		shell> ll
		-rw-r-----. 1 mysql mysql      8580 10月 30 16:47 t.frm
		-rw-r-----. 1 mysql mysql     98304 10月 30 17:36 t.ibd

		shell> date
		2020年 10月 30日 星期五 17:36:34 CST


		mysql> show global variables like 'binlog_format';
		+---------------+-------+
		| Variable_name | Value |
		+---------------+-------+
		| binlog_format | ROW   |
		+---------------+-------+
		1 row in set (0.00 sec)

		mysql> update t set a=2 where id=1;
		Query OK, 0 rows affected (0.01 sec)
		Rows matched: 1  Changed: 0  Warnings: 0


		shell> ll
		-rw-r-----. 1 mysql mysql      8580 10月 30 16:47 t.frm
		-rw-r-----. 1 mysql mysql     98304 10月 30 17:37 t.ibd


6. 相关参考
	
	https://mp.weixin.qq.com/s/HKnV-SCJ4dV6g2u9HIP3tQ  MySQL|update字段为相同的值是否会记录binlog

	16 | “order by”是怎么工作的？
	
	
	
	
