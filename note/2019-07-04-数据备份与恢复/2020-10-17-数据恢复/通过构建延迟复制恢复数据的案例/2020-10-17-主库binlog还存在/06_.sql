/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200320 15:05:59 server id 273306  end_log_pos 123 CRC32 0xe129ac2f 	Start: binlog v 4, server v 5.7.19-log created 200320 15:05:59
# at 123
#200320 15:05:59 server id 273306  end_log_pos 194 CRC32 0xa541f188 	Previous-GTIDs
# f7323d17-6442-11ea-8a77-080027758761:1-110631
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
# at 1405
#200320 15:28:52 server id 273306  end_log_pos 1470 CRC32 0x495e85a5 	GTID	last_committed=4	sequence_number=5	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110636'/*!*/;
# at 1470
#200320 15:28:52 server id 273306  end_log_pos 1630 CRC32 0x79e72f8c 	Query	thread_id=15	exec_time=0	error_code=0
SET TIMESTAMP=1584689332/*!*/;
create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci
/*!*/;
# at 1630
#200320 15:28:57 server id 273306  end_log_pos 1695 CRC32 0x98f0ead6 	GTID	last_committed=5	sequence_number=6	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110637'/*!*/;
# at 1695
#200320 15:28:57 server id 273306  end_log_pos 2025 CRC32 0x3f509c76 	Query	thread_id=15	exec_time=0	error_code=0
use `db1`/*!*/;
SET TIMESTAMP=1584689337/*!*/;
CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4
/*!*/;
# at 2025
#200320 15:28:57 server id 273306  end_log_pos 2090 CRC32 0x1c7c1c4a 	GTID	last_committed=6	sequence_number=7	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110638'/*!*/;
# at 2090
#200320 15:28:57 server id 273306  end_log_pos 2161 CRC32 0xde799f23 	Query	thread_id=15	exec_time=0	error_code=0
SET TIMESTAMP=1584689337/*!*/;
BEGIN
/*!*/;
# at 2161
#200320 15:28:57 server id 273306  end_log_pos 2214 CRC32 0x9cc2072e 	Table_map: `db1`.`product` mapped to number 259
# at 2214
#200320 15:28:57 server id 273306  end_log_pos 2264 CRC32 0xd12201b6 	Write_rows: table id 259 flags: STMT_END_F
### INSERT INTO `db1`.`product`
### SET
###   @1=1 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 2264
#200320 15:28:57 server id 273306  end_log_pos 2295 CRC32 0x4d16f696 	Xid = 95
COMMIT/*!*/;
# at 2295
#200320 15:28:57 server id 273306  end_log_pos 2360 CRC32 0xb1591ce6 	GTID	last_committed=7	sequence_number=8	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110639'/*!*/;
# at 2360
#200320 15:28:57 server id 273306  end_log_pos 2431 CRC32 0xa8519766 	Query	thread_id=15	exec_time=0	error_code=0
SET TIMESTAMP=1584689337/*!*/;
BEGIN
/*!*/;
# at 2431
#200320 15:28:57 server id 273306  end_log_pos 2484 CRC32 0x438dddd1 	Table_map: `db1`.`product` mapped to number 259
# at 2484
#200320 15:28:57 server id 273306  end_log_pos 2534 CRC32 0x377fc0a3 	Write_rows: table id 259 flags: STMT_END_F
### INSERT INTO `db1`.`product`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 2534
#200320 15:28:57 server id 273306  end_log_pos 2565 CRC32 0xf9d59a06 	Xid = 96
COMMIT/*!*/;
# at 2565
#200320 15:28:57 server id 273306  end_log_pos 2630 CRC32 0x9303647a 	GTID	last_committed=8	sequence_number=9	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110640'/*!*/;
# at 2630
#200320 15:28:57 server id 273306  end_log_pos 2701 CRC32 0xbd220fe9 	Query	thread_id=15	exec_time=0	error_code=0
SET TIMESTAMP=1584689337/*!*/;
BEGIN
/*!*/;
# at 2701
#200320 15:28:57 server id 273306  end_log_pos 2754 CRC32 0xcacb3163 	Table_map: `db1`.`product` mapped to number 259
# at 2754
#200320 15:28:57 server id 273306  end_log_pos 2804 CRC32 0xd7410b3e 	Write_rows: table id 259 flags: STMT_END_F
### INSERT INTO `db1`.`product`
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 2804
#200320 15:28:57 server id 273306  end_log_pos 2835 CRC32 0x769934c7 	Xid = 97
COMMIT/*!*/;
# at 2835
#200320 15:36:57 server id 273306  end_log_pos 2900 CRC32 0x3f367d81 	GTID	last_committed=9	sequence_number=10	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110641'/*!*/;
# at 2900
#200320 15:36:57 server id 273306  end_log_pos 3231 CRC32 0xea9c3bb3 	Query	thread_id=20	exec_time=0	error_code=0
SET TIMESTAMP=1584689817/*!*/;
CREATE TABLE `product2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4
/*!*/;
# at 3231
#200320 15:36:57 server id 273306  end_log_pos 3296 CRC32 0x12583b0e 	GTID	last_committed=10	sequence_number=11	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110642'/*!*/;
# at 3296
#200320 15:36:57 server id 273306  end_log_pos 3367 CRC32 0xd16bf211 	Query	thread_id=20	exec_time=0	error_code=0
SET TIMESTAMP=1584689817/*!*/;
BEGIN
/*!*/;
# at 3367
#200320 15:36:57 server id 273306  end_log_pos 3421 CRC32 0xe617bd98 	Table_map: `db1`.`product2` mapped to number 260
# at 3421
#200320 15:36:57 server id 273306  end_log_pos 3471 CRC32 0x6ee8bb61 	Write_rows: table id 260 flags: STMT_END_F
### INSERT INTO `db1`.`product2`
### SET
###   @1=1 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 3471
#200320 15:36:57 server id 273306  end_log_pos 3502 CRC32 0x0dfb0031 	Xid = 123
COMMIT/*!*/;
# at 3502
#200320 15:36:57 server id 273306  end_log_pos 3567 CRC32 0xfcecde58 	GTID	last_committed=11	sequence_number=12	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110643'/*!*/;
# at 3567
#200320 15:36:57 server id 273306  end_log_pos 3638 CRC32 0x49fd1004 	Query	thread_id=20	exec_time=0	error_code=0
SET TIMESTAMP=1584689817/*!*/;
BEGIN
/*!*/;
# at 3638
#200320 15:36:57 server id 273306  end_log_pos 3692 CRC32 0xa44334be 	Table_map: `db1`.`product2` mapped to number 260
# at 3692
#200320 15:36:57 server id 273306  end_log_pos 3742 CRC32 0x34af0544 	Write_rows: table id 260 flags: STMT_END_F
### INSERT INTO `db1`.`product2`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 3742
#200320 15:36:57 server id 273306  end_log_pos 3773 CRC32 0xa0277c51 	Xid = 124
COMMIT/*!*/;
# at 3773
#200320 15:36:57 server id 273306  end_log_pos 3838 CRC32 0xe829ea2a 	GTID	last_committed=12	sequence_number=13	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110644'/*!*/;
# at 3838
#200320 15:36:57 server id 273306  end_log_pos 3909 CRC32 0x724e9abf 	Query	thread_id=20	exec_time=0	error_code=0
SET TIMESTAMP=1584689817/*!*/;
BEGIN
/*!*/;
# at 3909
#200320 15:36:57 server id 273306  end_log_pos 3963 CRC32 0x673dd549 	Table_map: `db1`.`product2` mapped to number 260
# at 3963
#200320 15:36:57 server id 273306  end_log_pos 4013 CRC32 0xb241521a 	Write_rows: table id 260 flags: STMT_END_F
### INSERT INTO `db1`.`product2`
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 4013
#200320 15:36:57 server id 273306  end_log_pos 4044 CRC32 0xc67bf779 	Xid = 125
COMMIT/*!*/;
# at 4044
#200320 15:36:57 server id 273306  end_log_pos 4109 CRC32 0x587c5c8f 	GTID	last_committed=13	sequence_number=14	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110645'/*!*/;
# at 4109
#200320 15:36:57 server id 273306  end_log_pos 4180 CRC32 0x0aa32c71 	Query	thread_id=20	exec_time=0	error_code=0
SET TIMESTAMP=1584689817/*!*/;
BEGIN
/*!*/;
# at 4180
#200320 15:36:57 server id 273306  end_log_pos 4234 CRC32 0x78584a55 	Table_map: `db1`.`product2` mapped to number 260
# at 4234
#200320 15:36:57 server id 273306  end_log_pos 4284 CRC32 0x7e6d23b3 	Write_rows: table id 260 flags: STMT_END_F
### INSERT INTO `db1`.`product2`
### SET
###   @1=4 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 4284
#200320 15:36:57 server id 273306  end_log_pos 4315 CRC32 0xd8fc15d9 	Xid = 126
COMMIT/*!*/;
# at 4315
#200320 15:36:57 server id 273306  end_log_pos 4380 CRC32 0xb1c7784b 	GTID	last_committed=14	sequence_number=15	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110646'/*!*/;
# at 4380
#200320 15:36:57 server id 273306  end_log_pos 4451 CRC32 0x5eec6d92 	Query	thread_id=20	exec_time=0	error_code=0
SET TIMESTAMP=1584689817/*!*/;
BEGIN
/*!*/;
# at 4451
#200320 15:36:57 server id 273306  end_log_pos 4504 CRC32 0x065c74dc 	Table_map: `db1`.`product` mapped to number 259
# at 4504
#200320 15:36:57 server id 273306  end_log_pos 4554 CRC32 0x8baf0268 	Write_rows: table id 259 flags: STMT_END_F
### INSERT INTO `db1`.`product`
### SET
###   @1=4 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 4554
#200320 15:36:57 server id 273306  end_log_pos 4585 CRC32 0x83784cdb 	Xid = 127
COMMIT/*!*/;
# at 4585
#200320 15:44:49 server id 273306  end_log_pos 4650 CRC32 0x2d0f545a 	GTID	last_committed=15	sequence_number=16	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110647'/*!*/;
# at 4650
#200320 15:44:49 server id 273306  end_log_pos 4772 CRC32 0x62dfb05e 	Query	thread_id=21	exec_time=0	error_code=0
SET TIMESTAMP=1584690289/*!*/;
DROP TABLE `db1`.`product2` /* generated by server */
/*!*/;
# at 4772
#200320 15:45:17 server id 273306  end_log_pos 4837 CRC32 0xa4ea6e11 	GTID	last_committed=16	sequence_number=17	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110648'/*!*/;
# at 4837
#200320 15:45:17 server id 273306  end_log_pos 4905 CRC32 0x36928e77 	Query	thread_id=21	exec_time=0	error_code=0
SET TIMESTAMP=1584690317/*!*/;
BEGIN
/*!*/;
# at 4905
#200320 15:45:17 server id 273306  end_log_pos 4958 CRC32 0x9a1124dd 	Table_map: `db1`.`product` mapped to number 259
# at 4958
#200320 15:45:17 server id 273306  end_log_pos 5008 CRC32 0x3c45024a 	Delete_rows: table id 259 flags: STMT_END_F
### DELETE FROM `db1`.`product`
### WHERE
###   @1=4 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 5008
#200320 15:45:17 server id 273306  end_log_pos 5039 CRC32 0x763a5789 	Xid = 135
COMMIT/*!*/;
# at 5039
#200320 16:04:44 server id 273306  end_log_pos 5104 CRC32 0xbc1669a8 	GTID	last_committed=17	sequence_number=18	rbr_only=no
SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:110649'/*!*/;
# at 5104
#200320 16:04:44 server id 273306  end_log_pos 5225 CRC32 0x7206bb35 	Query	thread_id=24	exec_time=0	error_code=0
SET TIMESTAMP=1584691484/*!*/;
DROP TABLE `db1`.`product` /* generated by server */
/*!*/;
# at 5225
#200320 16:05:40 server id 273306  end_log_pos 5272 CRC32 0xb0c823a9 	Rotate to mysql-bin.000007  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
