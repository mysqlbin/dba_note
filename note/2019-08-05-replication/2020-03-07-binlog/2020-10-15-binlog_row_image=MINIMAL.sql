
1. 初始化表结构
2. update
3. insert
4. delete 
5. 小结


1. 初始化表结构
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB;
	
2. 验证 binlog_row_image = minimal 下的update 的 binlog 格式

		mysql> >set global binlog_row_image=minimal;
		Query OK, 0 rows affected (0.00 sec)

		mysql> >show global variables like '%binlog_row_image%';
		+------------------+---------+
		| Variable_name    | Value   |
		+------------------+---------+
		| binlog_row_image | MINIMAL |
		+------------------+---------+
		1 row in set (0.00 sec)
		
		update t set a=3 where id=1;
		
		mysql> >show binlog events in 'mysql-bin.000036';
		+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------+
		| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                                       |
		+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------+
		| mysql-bin.000036 |   4 | Format_desc    |    273306 |         123 | Server ver: 5.7.19-log, Binlog ver: 4                                                      |
		| mysql-bin.000036 | 123 | Previous_gtids |    273306 |         234 | c27f419e-cecd-27e7-9649-0800279d4f09:1-1609,
		c39f419e-cecd-26e7-9649-0800279d4f09:1-922364 |
		| mysql-bin.000036 | 234 | Gtid           |    273306 |         299 | SET @@SESSION.GTID_NEXT= 'c27f419e-cecd-27e7-9649-0800279d4f09:1610'                       |
		| mysql-bin.000036 | 299 | Query          |    273306 |         370 | BEGIN                                                                                      |
		| mysql-bin.000036 | 370 | Table_map      |    273306 |         416 | table_id: 277 (zst.t)                                                                      |
		| mysql-bin.000036 | 416 | Update_rows    |    273306 |         462 | table_id: 277 flags: STMT_END_F                                                            |
		| mysql-bin.000036 | 462 | Xid            |    273306 |         493 | COMMIT /* xid=98 */                                                                        |
		+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------+
		7 rows in set (0.00 sec)
		
		shell> mysqlbinlog -vv --base64-output='decode-rows' --start-position=234 mysql-bin.000036
		/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
		/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
		DELIMITER /*!*/;
		# at 234
		#200308 22:08:48 server id 273306  end_log_pos 299 CRC32 0xc5bd5291 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
		/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
		SET @@SESSION.GTID_NEXT= 'c27f419e-cecd-27e7-9649-0800279d4f09:1610'/*!*/;
		# at 299
		#200308 22:08:48 server id 273306  end_log_pos 370 CRC32 0x5751cfd4 	Query	thread_id=11	exec_time=0	error_code=0
		SET TIMESTAMP=1583676528/*!*/;
		SET @@session.pseudo_thread_id=11/*!*/;
		SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
		SET @@session.sql_mode=1436549152/*!*/;
		SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
		/*!\C utf8 *//*!*/;
		SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=33/*!*/;
		SET @@session.lc_time_names=0/*!*/;
		SET @@session.collation_database=DEFAULT/*!*/;
		BEGIN
		/*!*/;
		# at 370
		#200308 22:08:48 server id 273306  end_log_pos 416 CRC32 0xdcfa47e9 	Table_map: `zst`.`t` mapped to number 277
		# at 416
		#200308 22:08:48 server id 273306  end_log_pos 462 CRC32 0x3962cf5a 	Update_rows: table id 277 flags: STMT_END_F
		### UPDATE `zst`.`t`
		### WHERE
		###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
		### SET
		###   @2=3 /* INT meta=0 nullable=1 is_null=0 */
		# at 462
		#200308 22:08:48 server id 273306  end_log_pos 493 CRC32 0x853a3e9b 	Xid = 98
		COMMIT/*!*/;
		SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
		DELIMITER ;
		# End of log file
		/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
		/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;

3. insert

	mysql> set global binlog_row_image=minimal;
	Query OK, 0 rows affected (0.00 sec)
	
	mysql> show global variables like '%binlog_row_image%';
	+------------------+---------+
	| Variable_name    | Value   |
	+------------------+---------+
	| binlog_row_image | MINIMAL |
	+------------------+---------+
	1 row in set (0.00 sec)

	mysql> show binlog events in 'mysql-bin.000004';
	+------------------+-----+----------------+-----------+-------------+------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                     |
	+------------------+-----+----------------+-----------+-------------+------------------------------------------+
	| mysql-bin.000004 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4    |
	| mysql-bin.000004 | 123 | Previous_gtids |    330607 |         194 | 9e520b78-013c-11eb-a84c-0800271bf591:1-4 |
	+------------------+-----+----------------+-----------+-------------+------------------------------------------+
	2 rows in set (0.00 sec)

	mysql> 
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000004
			 Position: 194
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-4
	1 row in set (0.00 sec)

	
	CREATE TABLE `t1` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB;

	insert into t1 values(1,1,'2018-11-13');
	
	
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000004
			 Position: 823
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-6
	1 row in set (0.00 sec)

	
	mysql> show binlog events in 'mysql-bin.000004';
	+------------------+-----+----------------+-----------+-------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                                                                                                                                                                        |
	+------------------+-----+----------------+-----------+-------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| mysql-bin.000004 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                                                                                                                                                                       |
	| mysql-bin.000004 | 123 | Previous_gtids |    330607 |         194 | 9e520b78-013c-11eb-a84c-0800271bf591:1-4                                                                                                                                                                                    |
	| mysql-bin.000004 | 194 | Gtid           |    330607 |         259 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:5'                                                                                                                                                           |
	| mysql-bin.000004 | 259 | Query          |    330607 |         545 | use `test_db`; CREATE TABLE `t1` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB |
	| mysql-bin.000004 | 545 | Gtid           |    330607 |         610 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:6'                                                                                                                                                           |
	| mysql-bin.000004 | 610 | Query          |    330607 |         693 | BEGIN                                                                                                                                                                                                                       |
	| mysql-bin.000004 | 693 | Table_map      |    330607 |         744 | table_id: 143 (test_db.t1)                                                                                                                                                                                                  |
	| mysql-bin.000004 | 744 | Write_rows     |    330607 |         792 | table_id: 143 flags: STMT_END_F                                                                                                                                                                                             |
	| mysql-bin.000004 | 792 | Xid            |    330607 |         823 | COMMIT /* xid=501 */                                                                                                                                                                                                        |
	+------------------+-----+----------------+-----------+-------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	9 rows in set (0.00 sec)

	
	shell> mysqlbinlog -vv --base64-output='decode-rows' /home/mysql/3306/logs/mysql-bin.000004
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
	/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
	DELIMITER /*!*/;
	# at 4
	#200929  3:23:37 server id 330607  end_log_pos 123 CRC32 0x3e23484c 	Start: binlog v 4, server v 5.7.22-log created 200929  3:23:37
	# Warning: this binlog is either in use or was not closed properly.
	# at 123
	#200929  3:23:37 server id 330607  end_log_pos 194 CRC32 0xd39fbc19 	Previous-GTIDs
	# 9e520b78-013c-11eb-a84c-0800271bf591:1-4
	# at 194
	#200929  3:25:15 server id 330607  end_log_pos 259 CRC32 0x1b35d3ca 	GTID	last_committed=0	sequence_number=1	rbr_only=no
	SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:5'/*!*/;
	# at 259
	#200929  3:25:15 server id 330607  end_log_pos 545 CRC32 0x893f84cd 	Query	thread_id=6	exec_time=0	error_code=0
	use `test_db`/*!*/;
	SET TIMESTAMP=1601321115/*!*/;
	SET @@session.pseudo_thread_id=6/*!*/;
	SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
	SET @@session.sql_mode=1075838976/*!*/;
	SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
	/*!\C utf8 *//*!*/;
	SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
	SET @@session.lc_time_names=0/*!*/;
	SET @@session.collation_database=DEFAULT/*!*/;
	SET @@session.explicit_defaults_for_timestamp=1/*!*/;
	CREATE TABLE `t1` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB
	/*!*/;
	# at 545
	#200929  3:25:15 server id 330607  end_log_pos 610 CRC32 0x9e4707bb 	GTID	last_committed=1	sequence_number=2	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:6'/*!*/;
	# at 610
	#200929  3:25:15 server id 330607  end_log_pos 693 CRC32 0x81a4496d 	Query	thread_id=6	exec_time=0	error_code=0
	SET TIMESTAMP=1601321115/*!*/;
	SET @@session.time_zone='SYSTEM'/*!*/;
	BEGIN
	/*!*/;
	# at 693
	#200929  3:25:15 server id 330607  end_log_pos 744 CRC32 0x0a7aa9b3 	Table_map: `test_db`.`t1` mapped to number 143
	# at 744
	#200929  3:25:15 server id 330607  end_log_pos 792 CRC32 0x33bd7e3d 	Write_rows: table id 143 flags: STMT_END_F
	### INSERT INTO `test_db`.`t1`
	### SET
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
	###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
	# at 792
	#200929  3:25:15 server id 330607  end_log_pos 823 CRC32 0xf2fed134 	Xid = 501
	COMMIT/*!*/;
	SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
	DELIMITER ;
	# End of log file
	/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;



4. delete 

	mysql> show global variables like '%binlog_row_image%';
	+------------------+---------+
	| Variable_name    | Value   |
	+------------------+---------+
	| binlog_row_image | MINIMAL |
	+------------------+---------+
	1 row in set (0.00 sec)
	mysql> show binlog events in 'mysql-bin.000005';
	+------------------+-----+----------------+-----------+-------------+------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                     |
	+------------------+-----+----------------+-----------+-------------+------------------------------------------+
	| mysql-bin.000005 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4    |
	| mysql-bin.000005 | 123 | Previous_gtids |    330607 |         194 | 9e520b78-013c-11eb-a84c-0800271bf591:1-6 |
	+------------------+-----+----------------+-----------+-------------+------------------------------------------+
	2 rows in set (0.00 sec)

	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000005
			 Position: 194
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-6
	1 row in set (0.00 sec)

	mysql> delete from t1 where id=1;
	Query OK, 1 row affected (0.01 sec)

	mysql> show binlog events in 'mysql-bin.000005';
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                              |
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------+
	| mysql-bin.000005 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                             |
	| mysql-bin.000005 | 123 | Previous_gtids |    330607 |         194 | 9e520b78-013c-11eb-a84c-0800271bf591:1-6                          |
	| mysql-bin.000005 | 194 | Gtid           |    330607 |         259 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:7' |
	| mysql-bin.000005 | 259 | Query          |    330607 |         334 | BEGIN                                                             |
	| mysql-bin.000005 | 334 | Table_map      |    330607 |         385 | table_id: 143 (test_db.t1)                                        |
	| mysql-bin.000005 | 385 | Delete_rows    |    330607 |         433 | table_id: 143 flags: STMT_END_F                                   |
	| mysql-bin.000005 | 433 | Xid            |    330607 |         464 | COMMIT /* xid=509 */                                              |
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------+
	7 rows in set (0.00 sec)


	shell> mysqlbinlog -vv --base64-output='decode-rows' /home/mysql/3306/logs/mysql-bin.000005
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
	/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
	DELIMITER /*!*/;
	# at 4
	#200929  3:28:17 server id 330607  end_log_pos 123 CRC32 0x25493458 	Start: binlog v 4, server v 5.7.22-log created 200929  3:28:17
	# Warning: this binlog is either in use or was not closed properly.
	# at 123
	#200929  3:28:17 server id 330607  end_log_pos 194 CRC32 0x49535f11 	Previous-GTIDs
	# 9e520b78-013c-11eb-a84c-0800271bf591:1-6
	# at 194
	#200929  3:29:20 server id 330607  end_log_pos 259 CRC32 0x3e664dcd 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:7'/*!*/;
	# at 259
	#200929  3:29:20 server id 330607  end_log_pos 334 CRC32 0xa16b320f 	Query	thread_id=6	exec_time=0	error_code=0
	SET TIMESTAMP=1601321360/*!*/;
	SET @@session.pseudo_thread_id=6/*!*/;
	SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
	SET @@session.sql_mode=1075838976/*!*/;
	SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
	/*!\C utf8 *//*!*/;
	SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
	SET @@session.lc_time_names=0/*!*/;
	SET @@session.collation_database=DEFAULT/*!*/;
	BEGIN
	/*!*/;
	# at 334
	#200929  3:29:20 server id 330607  end_log_pos 385 CRC32 0x6e50423d 	Table_map: `test_db`.`t1` mapped to number 143
	# at 385
	#200929  3:29:20 server id 330607  end_log_pos 433 CRC32 0x7111e231 	Delete_rows: table id 143 flags: STMT_END_F
	### DELETE FROM `test_db`.`t1`
	### WHERE
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
	###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
	# at 433
	#200929  3:29:20 server id 330607  end_log_pos 464 CRC32 0xbd2fe81f 	Xid = 509
	COMMIT/*!*/;
	SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
	DELIMITER ;
	# End of log file
	/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;


	
5. 小结

	binlog_row_image=minimal：update操作在binlog event中只保留 更新后的值，这也意味着 update操作 通过binlog做不了数据的闪回操作。
	
	