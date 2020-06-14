/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200314 22:06:02 server id 273306  end_log_pos 123 CRC32 0x8800c34f 	Start: binlog v 4, server v 5.7.19-log created 200314 22:06:02
# at 123
#200314 22:06:02 server id 273306  end_log_pos 194 CRC32 0x8107e767 	Previous-GTIDs
# f7323d17-6442-11ea-8a77-080027758761:1-6
# at 194
#200314 23:05:11 server id 273306  end_log_pos 259 CRC32 0xd4c70316 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:7'/*!*/;
# at 259
#200314 23:05:11 server id 273306  end_log_pos 330 CRC32 0x889021b2 	Query	thread_id=51	exec_time=0	error_code=0
SET TIMESTAMP=1584198311/*!*/;
SET @@session.pseudo_thread_id=51/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1436549152/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=33/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
BEGIN
/*!*/;
# at 330
#200314 23:05:11 server id 273306  end_log_pos 377 CRC32 0xffd8acdf 	Table_map: `zst`.`t1` mapped to number 481
# at 377
#200314 23:05:11 server id 273306  end_log_pos 429 CRC32 0xa50217cd 	Delete_rows: table id 481 flags: STMT_END_F
### DELETE FROM `zst`.`t1`
### WHERE
###   @1=0 /* INT meta=0 nullable=0 is_null=0 */
###   @2=0 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
# at 429
#200314 23:05:11 server id 273306  end_log_pos 460 CRC32 0x31c1d5ff 	Xid = 3258
COMMIT/*!*/;
# at 460
#200315 12:59:27 server id 273306  end_log_pos 525 CRC32 0x5e9cbf03 	GTID	last_committed=1	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:8'/*!*/;
# at 525
#200315 12:59:27 server id 273306  end_log_pos 596 CRC32 0x87aa6df9 	Query	thread_id=69	exec_time=0	error_code=0
SET TIMESTAMP=1584248367/*!*/;
BEGIN
/*!*/;
# at 596
#200315 12:59:27 server id 273306  end_log_pos 642 CRC32 0x71c011ad 	Table_map: `zst`.`t` mapped to number 494
# at 642
#200315 12:59:27 server id 273306  end_log_pos 690 CRC32 0x3353a158 	Write_rows: table id 494 flags: STMT_END_F
### INSERT INTO `zst`.`t`
### SET
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1584248367 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 690
#200315 12:59:27 server id 273306  end_log_pos 721 CRC32 0x5205b199 	Xid = 3360
COMMIT/*!*/;
# at 721
#200315 13:01:40 server id 273306  end_log_pos 786 CRC32 0x7b058b5b 	GTID	last_committed=2	sequence_number=3	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:9'/*!*/;
# at 786
#200315 13:01:40 server id 273306  end_log_pos 857 CRC32 0x54b18789 	Query	thread_id=69	exec_time=1	error_code=0
SET TIMESTAMP=1584248500/*!*/;
BEGIN
/*!*/;
# at 857
#200315 13:01:40 server id 273306  end_log_pos 903 CRC32 0xff39ca9f 	Table_map: `zst`.`t` mapped to number 494
# at 903
#200315 13:01:40 server id 273306  end_log_pos 951 CRC32 0x51eeef53 	Write_rows: table id 494 flags: STMT_END_F
### INSERT INTO `zst`.`t`
### SET
###   @1=2 /* INT meta=0 nullable=0 is_null=0 */
###   @2=2 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1584248500 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 951
#200315 13:01:40 server id 273306  end_log_pos 982 CRC32 0x6594f4fd 	Xid = 3378
COMMIT/*!*/;
# at 982
#200315 13:03:45 server id 273306  end_log_pos 1047 CRC32 0xf7a6793c 	GTID	last_committed=3	sequence_number=4	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:10'/*!*/;
# at 1047
#200315 13:03:45 server id 273306  end_log_pos 1118 CRC32 0xf788aa9c 	Query	thread_id=71	exec_time=0	error_code=0
SET TIMESTAMP=1584248625/*!*/;
BEGIN
/*!*/;
# at 1118
#200315 13:03:45 server id 273306  end_log_pos 1164 CRC32 0xc90cd146 	Table_map: `zst`.`t` mapped to number 494
# at 1164
#200315 13:03:45 server id 273306  end_log_pos 1212 CRC32 0xfcef13af 	Delete_rows: table id 494 flags: STMT_END_F
### DELETE FROM `zst`.`t`
### WHERE
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1584248367 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 1212
#200315 13:03:45 server id 273306  end_log_pos 1243 CRC32 0x0a1e1fb3 	Xid = 3386
COMMIT/*!*/;
# at 1243
#200315 13:04:32 server id 273306  end_log_pos 1308 CRC32 0x1f26e9a1 	GTID	last_committed=4	sequence_number=5	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:11'/*!*/;
# at 1308
#200315 13:04:32 server id 273306  end_log_pos 1379 CRC32 0x10ddd0c1 	Query	thread_id=71	exec_time=0	error_code=0
SET TIMESTAMP=1584248672/*!*/;
BEGIN
/*!*/;
# at 1379
#200315 13:04:32 server id 273306  end_log_pos 1425 CRC32 0x2a129731 	Table_map: `zst`.`t` mapped to number 494
# at 1425
#200315 13:04:32 server id 273306  end_log_pos 1473 CRC32 0x95764059 	Delete_rows: table id 494 flags: STMT_END_F
### DELETE FROM `zst`.`t`
### WHERE
###   @1=2 /* INT meta=0 nullable=0 is_null=0 */
###   @2=2 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1584248500 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 1473
#200315 13:04:32 server id 273306  end_log_pos 1504 CRC32 0xabf8ab77 	Xid = 3389
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
