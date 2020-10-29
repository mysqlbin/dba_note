

mysql> update t_20201029 set extendCode=0 where;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1


1. 初始化表结构和数据
2. 执行更新语句
3. 查看binlog
4. 小结


1. 初始化表结构和数据
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)


	CREATE TABLE `t_20201029` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `nPlayerID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
	  `ExtendCode` varchar(36) DEFAULT NULL COMMENT '推广码',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


	mysql> select * from t_20201029;
	+----+-----------+------------+
	| ID | nPlayerID | ExtendCode |
	+----+-----------+------------+
	|  1 |         1 | 1          |
	|  2 |         2 | 2          |
	+----+-----------+------------+
	2 rows in set (0.04 sec)


2. 执行更新语句
	update t_20201029 set extendCode=0 where 149435;

	mysql> update t_20201029 set extendCode=0 where 149435;
	Query OK, 2 rows affected (0.05 sec)
	Rows matched: 2  Changed: 2  Warnings: 0


	mysql> select * from t_20201029;
	+----+-----------+------------+
	| ID | nPlayerID | ExtendCode |
	+----+-----------+------------+
	|  1 |         1 | 0          |
	|  2 |         2 | 0          |
	+----+-----------+------------+
	2 rows in set (0.00 sec)

3. 查看binlog
	show binlog events in 'mysql-bin.000044';

	mysql> show binlog events in 'mysql-bin.000044';
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                              |
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------+
	| mysql-bin.000044 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                             |
	| mysql-bin.000044 | 123 | Previous_gtids |    330607 |         154 |                                                                   |
	| mysql-bin.000044 | 154 | Gtid           |    330607 |         219 | SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1' |
	| mysql-bin.000044 | 219 | Query          |    330607 |         294 | BEGIN                                                             |
	| mysql-bin.000044 | 294 | Table_map      |    330607 |         354 | table_id: 108 (test_db.t_20201029)                                |
	| mysql-bin.000044 | 354 | Update_rows    |    330607 |         434 | table_id: 108 flags: STMT_END_F                                   |
	| mysql-bin.000044 | 434 | Xid            |    330607 |         465 | COMMIT /* xid=12 */                                               |
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------+
	7 rows in set (0.00 sec)


	mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000044 
	shell> mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000044 
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
	/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
	DELIMITER /*!*/;
	# at 4
	#201029 10:58:11 server id 330607  end_log_pos 123 CRC32 0x9413f0db 	Start: binlog v 4, server v 5.7.22-log created 201029 10:58:11 at startup
	# Warning: this binlog is either in use or was not closed properly.
	ROLLBACK/*!*/;
	# at 123
	#201029 10:58:11 server id 330607  end_log_pos 154 CRC32 0xf2b4705c 	Previous-GTIDs
	# [empty]
	# at 154
	#201029 11:00:03 server id 330607  end_log_pos 219 CRC32 0xd68c8d52 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1'/*!*/;
	# at 219
	#201029 11:00:03 server id 330607  end_log_pos 294 CRC32 0xce385b7a 	Query	thread_id=4	exec_time=0	error_code=0
	SET TIMESTAMP=1603940403/*!*/;
	SET @@session.pseudo_thread_id=4/*!*/;
	SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
	SET @@session.sql_mode=1075838976/*!*/;
	SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
	/*!\C utf8 *//*!*/;
	SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
	SET @@session.lc_time_names=0/*!*/;
	SET @@session.collation_database=DEFAULT/*!*/;
	BEGIN
	/*!*/;
	# at 294
	#201029 11:00:03 server id 330607  end_log_pos 354 CRC32 0x5918924e 	Table_map: `test_db`.`t_20201029` mapped to number 108
	# at 354
	#201029 11:00:03 server id 330607  end_log_pos 434 CRC32 0x5fa92154 	Update_rows: table id 108 flags: STMT_END_F
	### UPDATE `test_db`.`t_20201029`
	### WHERE
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @3='1' /* VARSTRING(144) meta=144 nullable=1 is_null=0 */
	### SET
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @3='0' /* VARSTRING(144) meta=144 nullable=1 is_null=0 */
	### UPDATE `test_db`.`t_20201029`
	### WHERE
	###   @1=2 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=2 /* INT meta=0 nullable=0 is_null=0 */
	###   @3='2' /* VARSTRING(144) meta=144 nullable=1 is_null=0 */
	### SET
	###   @1=2 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=2 /* INT meta=0 nullable=0 is_null=0 */
	###   @3='0' /* VARSTRING(144) meta=144 nullable=1 is_null=0 */
	# at 434
	#201029 11:00:03 server id 330607  end_log_pos 465 CRC32 0x1ccbc101 	Xid = 12
	COMMIT/*!*/;
	SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
	DELIMITER ;
	# End of log file
	/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;


4. 小结
	update语句的where条件后面直接赋值，并不会导致执行报错，而是会造成全表更新。
	
	
	