/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200320 15:05:59 server id 273306  end_log_pos 123 CRC32 0xe129ac2f 	Start: binlog v 4, server v 5.7.19-log created 200320 15:05:59
# Warning: this binlog is either in use or was not closed properly.
# at 194
#200320 15:06:08 server id 273306  end_log_pos 259 CRC32 0xcdde6f44 	GTID	last_committed=0	sequence_number=1	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110632'/*!*/;
# at 259
#200320 15:06:08 server id 273306  end_log_pos 595 CRC32 0x25be4f6d 	Query	thread_id=11	exec_time=0	error_code=0
use `zst`/*!*/;
SET TIMESTAMP=1584687968/*!*/;
SET @@session.pseudo_thread_id=11/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1436549152/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=33/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
CREATE TABLE `product` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `name` varchar(20) DEFAULT NULL,
	  `amount` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4
/*!*/;
# at 595
#200320 15:06:08 server id 273306  end_log_pos 660 CRC32 0x56edb1bd 	GTID	last_committed=1	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110633'/*!*/;
# at 660
#200320 15:06:08 server id 273306  end_log_pos 731 CRC32 0xc74ed528 	Query	thread_id=11	exec_time=0	error_code=0
SET TIMESTAMP=1584687968/*!*/;
BEGIN
/*!*/;
# at 731
#200320 15:06:08 server id 273306  end_log_pos 784 CRC32 0x63e54f84 	Table_map: `zst`.`product` mapped to number 258
# at 784
#200320 15:06:08 server id 273306  end_log_pos 834 CRC32 0xf0767eb0 	Write_rows: table id 258 flags: STMT_END_F
### INSERT INTO `zst`.`product`
### SET
###   @1=1 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 834
#200320 15:06:08 server id 273306  end_log_pos 865 CRC32 0xd184f456 	Xid = 64
COMMIT/*!*/;
# at 865
#200320 15:06:08 server id 273306  end_log_pos 930 CRC32 0xd4ba91e9 	GTID	last_committed=2	sequence_number=3	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110634'/*!*/;
# at 930
#200320 15:06:08 server id 273306  end_log_pos 1001 CRC32 0x94329ba5 	Query	thread_id=11	exec_time=0	error_code=0
SET TIMESTAMP=1584687968/*!*/;
BEGIN
/*!*/;
# at 1001
#200320 15:06:08 server id 273306  end_log_pos 1054 CRC32 0xd9cc64ed 	Table_map: `zst`.`product` mapped to number 258
# at 1054
#200320 15:06:08 server id 273306  end_log_pos 1104 CRC32 0x80ac6baa 	Write_rows: table id 258 flags: STMT_END_F
### INSERT INTO `zst`.`product`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1104
#200320 15:06:08 server id 273306  end_log_pos 1135 CRC32 0xabc6a710 	Xid = 65
COMMIT/*!*/;
# at 1135
#200320 15:06:08 server id 273306  end_log_pos 1200 CRC32 0x061db7ef 	GTID	last_committed=3	sequence_number=4	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110635'/*!*/;
# at 1200
#200320 15:06:08 server id 273306  end_log_pos 1271 CRC32 0x25e2af47 	Query	thread_id=11	exec_time=0	error_code=0
SET TIMESTAMP=1584687968/*!*/;
BEGIN
/*!*/;
# at 1271
#200320 15:06:08 server id 273306  end_log_pos 1324 CRC32 0x1f707ceb 	Table_map: `zst`.`product` mapped to number 258
# at 1324
#200320 15:06:08 server id 273306  end_log_pos 1374 CRC32 0xe70a1410 	Delete_rows: table id 258 flags: STMT_END_F
### DELETE FROM `zst`.`product`
### WHERE
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1374
#200320 15:06:08 server id 273306  end_log_pos 1405 CRC32 0x7f0381b7 	Xid = 66
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
