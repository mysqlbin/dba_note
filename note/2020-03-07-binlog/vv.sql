/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200307 15:00:13 server id 330640  end_log_pos 123 CRC32 0xd80973c0 	Start: binlog v 4, server v 5.7.22-log created 200307 15:00:13
BINLOG '
fUZjXg+QCwUAdwAAAHsAAAAAAAQANS43LjIyLWxvZwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAEzgNAAgAEgAEBAQEEgAAXwAEGggAAAAICAgCAAAACgoKKioAEjQA
AcBzCdg=
'/*!*/;
# at 194
#200307 15:00:49 server id 330640  end_log_pos 259 CRC32 0xe4880974 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5601'/*!*/;
# at 259
#200307 15:00:49 server id 330640  end_log_pos 346 CRC32 0x6e22eefc 	Query	thread_id=412	exec_time=0	error_code=0
SET TIMESTAMP=1583564449/*!*/;
SET @@session.pseudo_thread_id=412/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1075838976/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
BEGIN
/*!*/;
# at 346
#200307 15:00:49 server id 330640  end_log_pos 400 CRC32 0xf921d051 	Table_map: `niuniuh5_db`.`t` mapped to number 562
# at 400
#200307 15:00:49 server id 330640  end_log_pos 448 CRC32 0x28510b29 	Write_rows: table id 562 flags: STMT_END_F

BINLOG '
oUZjXhOQCwUANgAAAJABAAAAADICAAAAAAEAC25pdW5pdWg1X2RiAAF0AAMDAxEBAAJR0CH5
oUZjXh6QCwUAMAAAAMABAAAAADICAAAAAAEAAgAD//gBAAAAAQAAAFvpo4ApC1Eo
'/*!*/;
### INSERT INTO `niuniuh5_db`.`t`
### SET
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 448
#200307 15:00:49 server id 330640  end_log_pos 479 CRC32 0xa4119ce5 	Xid = 36095
COMMIT/*!*/;
# at 479
#200307 15:00:49 server id 330640  end_log_pos 544 CRC32 0xd722831a 	GTID	last_committed=1	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5602'/*!*/;
# at 544
#200307 15:00:49 server id 330640  end_log_pos 631 CRC32 0x7c69568b 	Query	thread_id=412	exec_time=0	error_code=0
SET TIMESTAMP=1583564449/*!*/;
BEGIN
/*!*/;
# at 631
#200307 15:00:49 server id 330640  end_log_pos 685 CRC32 0x0980a2b6 	Table_map: `niuniuh5_db`.`t` mapped to number 562
# at 685
#200307 15:00:49 server id 330640  end_log_pos 733 CRC32 0xd80542c4 	Write_rows: table id 562 flags: STMT_END_F

BINLOG '
oUZjXhOQCwUANgAAAK0CAAAAADICAAAAAAEAC25pdW5pdWg1X2RiAAF0AAMDAxEBAAK2ooAJ
oUZjXh6QCwUAMAAAAN0CAAAAADICAAAAAAEAAgAD//gCAAAAAgAAAFvoUgDEQgXY
'/*!*/;
### INSERT INTO `niuniuh5_db`.`t`
### SET
###   @1=2 /* INT meta=0 nullable=0 is_null=0 */
###   @2=2 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1541952000 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 733
#200307 15:00:49 server id 330640  end_log_pos 764 CRC32 0x28e2a07a 	Xid = 36096
COMMIT/*!*/;
# at 764
#200307 15:01:33 server id 330640  end_log_pos 829 CRC32 0x0a8ab72f 	GTID	last_committed=2	sequence_number=3	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5603'/*!*/;
# at 829
#200307 15:01:33 server id 330640  end_log_pos 908 CRC32 0x4ecb5036 	Query	thread_id=412	exec_time=0	error_code=0
SET TIMESTAMP=1583564493/*!*/;
BEGIN
/*!*/;
# at 908
#200307 15:01:33 server id 330640  end_log_pos 962 CRC32 0x808e658a 	Table_map: `niuniuh5_db`.`t` mapped to number 562
# at 962
#200307 15:01:33 server id 330640  end_log_pos 1024 CRC32 0x2ff91084 	Update_rows: table id 562 flags: STMT_END_F

BINLOG '
zUZjXhOQCwUANgAAAMIDAAAAADICAAAAAAEAC25pdW5pdWg1X2RiAAF0AAMDAxEBAAKKZY6A
zUZjXh+QCwUAPgAAAAAEAAAAADICAAAAAAEAAgAD///4AQAAAAEAAABb6aOA+AEAAAADAAAAW+mj
gIQQ+S8=
'/*!*/;
### UPDATE `niuniuh5_db`.`t`
### WHERE
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
### SET
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=3 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 1024
#200307 15:01:33 server id 330640  end_log_pos 1055 CRC32 0x802e7340 	Xid = 36102
COMMIT/*!*/;
# at 1055
#200307 15:02:10 server id 330640  end_log_pos 1120 CRC32 0xa344c1a8 	GTID	last_committed=3	sequence_number=4	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5604'/*!*/;
# at 1120
#200307 15:02:10 server id 330640  end_log_pos 1199 CRC32 0xc94171d2 	Query	thread_id=412	exec_time=0	error_code=0
SET TIMESTAMP=1583564530/*!*/;
BEGIN
/*!*/;
# at 1199
#200307 15:02:10 server id 330640  end_log_pos 1253 CRC32 0x8edadbfa 	Table_map: `niuniuh5_db`.`t` mapped to number 562
# at 1253
#200307 15:02:10 server id 330640  end_log_pos 1301 CRC32 0x83431650 	Delete_rows: table id 562 flags: STMT_END_F

BINLOG '
8kZjXhOQCwUANgAAAOUEAAAAADICAAAAAAEAC25pdW5pdWg1X2RiAAF0AAMDAxEBAAL629qO
8kZjXiCQCwUAMAAAABUFAAAAADICAAAAAAEAAgAD//gBAAAAAwAAAFvpo4BQFkOD
'/*!*/;
### DELETE FROM `niuniuh5_db`.`t`
### WHERE
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=3 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 1301
#200307 15:02:10 server id 330640  end_log_pos 1332 CRC32 0xbcee98cb 	Xid = 36108
COMMIT/*!*/;
# at 1332
#200307 15:04:32 server id 330640  end_log_pos 1379 CRC32 0x4be88a1f 	Rotate to mysql-bin.000009  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
