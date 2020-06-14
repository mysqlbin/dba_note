
1. 初始化表结构
2. 验证 binlog_row_image = minimal 下的 update 的 binlog 格式
3. 验证 binlog_row_image = minimal 下的 insert 的 binlog 格式
4. 小结


1. 初始化表结构
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB;
	
2. 验证 binlog_row_image = minimal 下的update 的 binlog 格式

		root@localhost [zst]>set global binlog_row_image=minimal;
		Query OK, 0 rows affected (0.00 sec)

		root@localhost [zst]>show global variables like '%binlog_row_image%';
		+------------------+---------+
		| Variable_name    | Value   |
		+------------------+---------+
		| binlog_row_image | MINIMAL |
		+------------------+---------+
		1 row in set (0.00 sec)
		
		update t set a=3 where id=1;
		
		root@localhost [zst]>show binlog events in 'mysql-bin.000036';
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
		
		[root@env logs]# mysqlbinlog -vv --base64-output='decode-rows' --start-position=234 mysql-bin.000036
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

3. 验证 binlog_row_image = minimal 下的 insert 的 binlog 格式
	root@localhost [zst]>set global binlog_row_image=full;
	Query OK, 0 rows affected (0.00 sec)

	root@localhost [zst]>show global variables like '%binlog_row_image%';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| binlog_row_image | FULL  |
	+------------------+-------+
	1 row in set (0.00 sec)
	
	
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB;

	insert into t values(1,1,'2018-11-13');
	
	root@localhost [zst]>show binlog events in 'mysql-bin.000037';
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                                       |
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------+
	| mysql-bin.000037 |   4 | Format_desc    |    273306 |         123 | Server ver: 5.7.19-log, Binlog ver: 4                                                      |
	| mysql-bin.000037 | 123 | Previous_gtids |    273306 |         234 | c27f419e-cecd-27e7-9649-0800279d4f09:1-1612,
	c39f419e-cecd-26e7-9649-0800279d4f09:1-922364 |
	| mysql-bin.000037 | 234 | Gtid           |    273306 |         299 | SET @@SESSION.GTID_NEXT= 'c27f419e-cecd-27e7-9649-0800279d4f09:1613'                       |
	| mysql-bin.000037 | 299 | Query          |    273306 |         378 | BEGIN                                                                                      |
	| mysql-bin.000037 | 378 | Table_map      |    273306 |         424 | table_id: 278 (zst.t)                                                                      |
	| mysql-bin.000037 | 424 | Write_rows     |    273306 |         472 | table_id: 278 flags: STMT_END_F                                                            |
	| mysql-bin.000037 | 472 | Xid            |    273306 |         503 | COMMIT /* xid=166 */                                                                       |
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------+
	7 rows in set (0.00 sec)
	
	[root@env ~]# mysqlbinlog -vv --base64-output='decode-rows' --start-position=234 /data/mysql/mysql3306/logs/mysql-bin.000037
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
	/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
	DELIMITER /*!*/;
	# at 234
	#200309  0:46:54 server id 273306  end_log_pos 299 CRC32 0xf413a472 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'c27f419e-cecd-27e7-9649-0800279d4f09:1613'/*!*/;
	# at 299
	#200309  0:46:54 server id 273306  end_log_pos 378 CRC32 0x91c40f01 	Query	thread_id=15	exec_time=0	error_code=0
	SET TIMESTAMP=1583686014/*!*/;
	SET @@session.pseudo_thread_id=15/*!*/;
	SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
	SET @@session.sql_mode=1436549152/*!*/;
	SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
	/*!\C utf8 *//*!*/;
	SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=33/*!*/;
	SET @@session.time_zone='SYSTEM'/*!*/;
	SET @@session.lc_time_names=0/*!*/;
	SET @@session.collation_database=DEFAULT/*!*/;
	BEGIN
	/*!*/;
	# at 378
	#200309  0:46:54 server id 273306  end_log_pos 424 CRC32 0x51e65df1 	Table_map: `zst`.`t` mapped to number 278
	# at 424
	#200309  0:46:54 server id 273306  end_log_pos 472 CRC32 0xf511bd5c 	Write_rows: table id 278 flags: STMT_END_F
	### INSERT INTO `zst`.`t`
	### SET
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
	###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
	# at 472
	#200309  0:46:54 server id 273306  end_log_pos 503 CRC32 0xb0ee634b 	Xid = 166
	COMMIT/*!*/;
	SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
	DELIMITER ;
	# End of log file
	/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
	
4. 小结
	binlog_row_image=minimal，意味着 delete 和 update 做不了数据的闪回操作。
	
	