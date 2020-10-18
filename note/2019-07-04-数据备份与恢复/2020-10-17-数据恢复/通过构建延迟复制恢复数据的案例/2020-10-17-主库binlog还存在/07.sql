/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200320 16:05:40 server id 273306  end_log_pos 123 CRC32 0x55a967b8 	Start: binlog v 4, server v 5.7.19-log created 200320 16:05:40
# at 123
#200320 16:05:40 server id 273306  end_log_pos 194 CRC32 0x0103733f 	Previous-GTIDs
# f7323d17-6442-11ea-8a77-080027758761:1-110649
# at 194
#200320 17:27:35 server id 273306  end_log_pos 259 CRC32 0xad92bf7a 	GTID	last_committed=0	sequence_number=1	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110650'/*!*/;
# at 259
#200320 17:27:35 server id 273306  end_log_pos 590 CRC32 0x42747416 	Query	thread_id=31	exec_time=0	error_code=0
use `db1`/*!*/;
SET TIMESTAMP=1584696455/*!*/;
SET @@session.pseudo_thread_id=31/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1436549152/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=33/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
CREATE TABLE `t1` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4
/*!*/;
# at 590
#200320 17:27:35 server id 273306  end_log_pos 655 CRC32 0x2b71f504 	GTID	last_committed=1	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110651'/*!*/;
# at 655
#200320 17:27:35 server id 273306  end_log_pos 726 CRC32 0x496a7edf 	Query	thread_id=31	exec_time=0	error_code=0
SET TIMESTAMP=1584696455/*!*/;
BEGIN
/*!*/;
# at 726
#200320 17:27:35 server id 273306  end_log_pos 774 CRC32 0x16e775c4 	Table_map: `db1`.`t1` mapped to number 265
# at 774
#200320 17:27:35 server id 273306  end_log_pos 824 CRC32 0x99d43b4c 	Write_rows: table id 265 flags: STMT_END_F
### INSERT INTO `db1`.`t1`
### SET
###   @1=1 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 824
#200320 17:27:35 server id 273306  end_log_pos 855 CRC32 0x8464f8e8 	Xid = 198
COMMIT/*!*/;
# at 855
#200320 17:27:35 server id 273306  end_log_pos 920 CRC32 0xb4d3f1f3 	GTID	last_committed=2	sequence_number=3	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110652'/*!*/;
# at 920
#200320 17:27:35 server id 273306  end_log_pos 991 CRC32 0x3b3a2a98 	Query	thread_id=31	exec_time=0	error_code=0
SET TIMESTAMP=1584696455/*!*/;
BEGIN
/*!*/;
# at 991
#200320 17:27:35 server id 273306  end_log_pos 1039 CRC32 0xda1d72a5 	Table_map: `db1`.`t1` mapped to number 265
# at 1039
#200320 17:27:35 server id 273306  end_log_pos 1089 CRC32 0x67d51df5 	Write_rows: table id 265 flags: STMT_END_F
### INSERT INTO `db1`.`t1`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1089
#200320 17:27:35 server id 273306  end_log_pos 1120 CRC32 0xfba6105a 	Xid = 199
COMMIT/*!*/;
# at 1120
#200320 17:27:35 server id 273306  end_log_pos 1185 CRC32 0xcda100b4 	GTID	last_committed=3	sequence_number=4	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110653'/*!*/;
# at 1185
#200320 17:27:35 server id 273306  end_log_pos 1256 CRC32 0xb2d7ccbc 	Query	thread_id=31	exec_time=0	error_code=0
SET TIMESTAMP=1584696455/*!*/;
BEGIN
/*!*/;
# at 1256
#200320 17:27:35 server id 273306  end_log_pos 1304 CRC32 0x20b4868a 	Table_map: `db1`.`t1` mapped to number 265
# at 1304
#200320 17:27:35 server id 273306  end_log_pos 1354 CRC32 0x3cf2c9e5 	Write_rows: table id 265 flags: STMT_END_F
### INSERT INTO `db1`.`t1`
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1354
#200320 17:27:35 server id 273306  end_log_pos 1385 CRC32 0x51462433 	Xid = 200
COMMIT/*!*/;
# at 1385
#200320 17:40:34 server id 273306  end_log_pos 1450 CRC32 0x15efb4e4 	GTID	last_committed=4	sequence_number=5	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110654'/*!*/;
# at 1450
#200320 17:40:34 server id 273306  end_log_pos 1781 CRC32 0x2cb63957 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1584697234/*!*/;
CREATE TABLE `t2` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4
/*!*/;
# at 1781
#200320 17:40:34 server id 273306  end_log_pos 1846 CRC32 0x978934bd 	GTID	last_committed=5	sequence_number=6	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110655'/*!*/;
# at 1846
#200320 17:40:34 server id 273306  end_log_pos 1917 CRC32 0xc8349001 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1584697234/*!*/;
BEGIN
/*!*/;
# at 1917
#200320 17:40:34 server id 273306  end_log_pos 1965 CRC32 0x00690820 	Table_map: `db1`.`t2` mapped to number 409
# at 1965
#200320 17:40:34 server id 273306  end_log_pos 2015 CRC32 0x9c0d0404 	Write_rows: table id 409 flags: STMT_END_F
### INSERT INTO `db1`.`t2`
### SET
###   @1=1 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 2015
#200320 17:40:34 server id 273306  end_log_pos 2046 CRC32 0x4e159f4e 	Xid = 247
COMMIT/*!*/;
# at 2046
#200320 17:40:34 server id 273306  end_log_pos 2111 CRC32 0xf0dff028 	GTID	last_committed=6	sequence_number=7	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110656'/*!*/;
# at 2111
#200320 17:40:34 server id 273306  end_log_pos 2182 CRC32 0xb1fba547 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1584697234/*!*/;
BEGIN
/*!*/;
# at 2182
#200320 17:40:34 server id 273306  end_log_pos 2230 CRC32 0x07544df2 	Table_map: `db1`.`t2` mapped to number 409
# at 2230
#200320 17:40:34 server id 273306  end_log_pos 2280 CRC32 0x8a1cf750 	Write_rows: table id 409 flags: STMT_END_F
### INSERT INTO `db1`.`t2`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 2280
#200320 17:40:34 server id 273306  end_log_pos 2311 CRC32 0xaa9922b5 	Xid = 248
COMMIT/*!*/;
# at 2311
#200320 17:40:34 server id 273306  end_log_pos 2376 CRC32 0x21f72ee5 	GTID	last_committed=7	sequence_number=8	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110657'/*!*/;
# at 2376
#200320 17:40:34 server id 273306  end_log_pos 2447 CRC32 0xc3abf100 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1584697234/*!*/;
BEGIN
/*!*/;
# at 2447
#200320 17:40:34 server id 273306  end_log_pos 2495 CRC32 0x42ec00a3 	Table_map: `db1`.`t2` mapped to number 409
# at 2495
#200320 17:40:34 server id 273306  end_log_pos 2545 CRC32 0x65150114 	Write_rows: table id 409 flags: STMT_END_F
### INSERT INTO `db1`.`t2`
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 2545
#200320 17:40:34 server id 273306  end_log_pos 2576 CRC32 0xd886d849 	Xid = 249
COMMIT/*!*/;
# at 2576
#200320 17:40:34 server id 273306  end_log_pos 2641 CRC32 0x8b62af82 	GTID	last_committed=8	sequence_number=9	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110658'/*!*/;
# at 2641
#200320 17:40:34 server id 273306  end_log_pos 2712 CRC32 0x5ee0e6a1 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1584697234/*!*/;
BEGIN
/*!*/;
# at 2712
#200320 17:40:34 server id 273306  end_log_pos 2760 CRC32 0xc810163f 	Table_map: `db1`.`t2` mapped to number 409
# at 2760
#200320 17:40:34 server id 273306  end_log_pos 2810 CRC32 0xfe3593a7 	Write_rows: table id 409 flags: STMT_END_F
### INSERT INTO `db1`.`t2`
### SET
###   @1=4 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 2810
#200320 17:40:34 server id 273306  end_log_pos 2841 CRC32 0x25c9f96f 	Xid = 250
COMMIT/*!*/;
# at 2841
#200320 17:40:34 server id 273306  end_log_pos 2906 CRC32 0x175bf75e 	GTID	last_committed=9	sequence_number=10	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110659'/*!*/;
# at 2906
#200320 17:40:34 server id 273306  end_log_pos 2977 CRC32 0x025f1f46 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1584697234/*!*/;
BEGIN
/*!*/;
# at 2977
#200320 17:40:34 server id 273306  end_log_pos 3025 CRC32 0xbd0cdb2e 	Table_map: `db1`.`t1` mapped to number 410
# at 3025
#200320 17:40:34 server id 273306  end_log_pos 3075 CRC32 0x46f6ba79 	Write_rows: table id 410 flags: STMT_END_F
### INSERT INTO `db1`.`t1`
### SET
###   @1=4 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 3075
#200320 17:40:34 server id 273306  end_log_pos 3106 CRC32 0x70fe80f0 	Xid = 251
COMMIT/*!*/;
# at 3106
#200320 17:41:39 server id 273306  end_log_pos 3171 CRC32 0x3119ae99 	GTID	last_committed=10	sequence_number=11	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110660'/*!*/;
# at 3171
#200320 17:41:39 server id 273306  end_log_pos 3284 CRC32 0x91212cb0 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1584697299/*!*/;
DROP TABLE `t1` /* generated by server */
/*!*/;
# at 3284
#200320 17:41:39 server id 273306  end_log_pos 3349 CRC32 0xaf5c03d3 	GTID	last_committed=11	sequence_number=12	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110661'/*!*/;
# at 3349
#200320 17:41:39 server id 273306  end_log_pos 3420 CRC32 0x44edacd0 	Query	thread_id=39	exec_time=0	error_code=0
SET TIMESTAMP=1584697299/*!*/;
BEGIN
/*!*/;
# at 3420
#200320 17:41:39 server id 273306  end_log_pos 3468 CRC32 0xe93d23ed 	Table_map: `db1`.`t2` mapped to number 409
# at 3468
#200320 17:41:39 server id 273306  end_log_pos 3518 CRC32 0x86873042 	Write_rows: table id 409 flags: STMT_END_F
### INSERT INTO `db1`.`t2`
### SET
###   @1=5 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 3518
#200320 17:41:39 server id 273306  end_log_pos 3549 CRC32 0x12590cbc 	Xid = 261
COMMIT/*!*/;
# at 3549
#200320 17:41:56 server id 273306  end_log_pos 3596 CRC32 0x9b019197 	Rotate to mysql-bin.000008  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
