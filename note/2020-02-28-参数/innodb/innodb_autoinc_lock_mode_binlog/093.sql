
show binlog events in 'mysql-bin.000093';

+------------------+----------+----------------+-----------+-------------+---------------------------------------------------------------------------+
| Log_name         | Pos      | Event_type     | Server_id | End_log_pos | Info                                                                      |
+------------------+----------+----------------+-----------+-------------+---------------------------------------------------------------------------+
| mysql-bin.000093 |        4 | Format_desc    |    330640 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                     |
| mysql-bin.000093 |      123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-164282470                          |
| mysql-bin.000093 |      194 | Gtid           |    330640 |         259 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:164282471' |
| mysql-bin.000093 |      259 | Query          |    330640 |         337 | BEGIN                                                                     |
| mysql-bin.000093 |      337 | Table_map      |    330640 |         392 | table_id: 205 (sbtest._t_new)                                             |
| mysql-bin.000093 |      392 | Write_rows     |    330640 |         450 | table_id: 205 flags: STMT_END_F                                           |
| mysql-bin.000093 |      450 | Xid            |    330640 |         481 | COMMIT /* xid=266 */                                                      |
| mysql-bin.000093 |      481 | Gtid           |    330640 |         546 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:164282472' |
| mysql-bin.000093 |      546 | Query          |    330640 |         624 | BEGIN                                                                     |
| mysql-bin.000093 |      624 | Table_map      |    330640 |         679 | table_id: 205 (sbtest._t_new)                                             |
| mysql-bin.000093 |      679 | Write_rows     |    330640 |        8879 | table_id: 205                                                             |
| mysql-bin.000093 |     8879 | Write_rows     |    330640 |       17079 | table_id: 205                                                             |
| mysql-bin.000093 |    17079 | Write_rows     |    330640 |       25279 | table_id: 205                                                             |


......................................................................................................

| mysql-bin.000093 | 11472479 | Write_rows     |    330640 |    11480679 | table_id: 205                                                             |
| mysql-bin.000093 | 11480679 | Write_rows     |    330640 |    11488879 | table_id: 205                                                             |
| mysql-bin.000093 | 11488879 | Write_rows     |    330640 |    11497079 | table_id: 205                                                             |
| mysql-bin.000093 | 11497079 | Write_rows     |    330640 |    11505279 | table_id: 205                                                             |
| mysql-bin.000093 | 11505279 | Write_rows     |    330640 |    11513479 | table_id: 205                                                             |
| mysql-bin.000093 | 11513479 | Write_rows     |    330640 |    11521679 | table_id: 205                                                             |
| mysql-bin.000093 | 11521679 | Write_rows     |    330640 |    11529879 | table_id: 205                                                             |
| mysql-bin.000093 | 11529879 | Write_rows     |    330640 |    11538079 | table_id: 205                                                             |
| mysql-bin.000093 | 11538079 | Write_rows     |    330640 |    11546279 | table_id: 205                                                             |
| mysql-bin.000093 | 11546279 | Write_rows     |    330640 |    11549994 | table_id: 205 flags: STMT_END_F                                           |
| mysql-bin.000093 | 11549994 | Xid            |    330640 |    11550025 | COMMIT /* xid=265 */                                                      |
| mysql-bin.000093 | 11550025 | Rotate         |    330640 |    11550072 | mysql-bin.000094;pos=4                                                    |
+------------------+----------+----------------+-----------+-------------+---------------------------------------------------------------------------+

mysqlbinlog -vv --base64-output=decode-rows  mysql-bin.000093 > 093.sql
head -70 093.sql

[root@voice logs]# mysqlbinlog -vv --base64-output=decode-rows  mysql-bin.000093 > 093.sql
[root@voice logs]# head -70 093.sql
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200515 18:22:55 server id 330640  end_log_pos 123 CRC32 0x3666c8bb 	Start: binlog v 4, server v 5.7.22-log created 200515 18:22:55
# at 123
#200515 18:22:55 server id 330640  end_log_pos 194 CRC32 0xa2cebd7e 	Previous-GTIDs
# 7af746a1-5c2d-11ea-bc75-00163e08b460:1-164282470
# at 194
#200515 18:23:32 server id 330640  end_log_pos 259 CRC32 0x1858752b 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:164282471'/*!*/;
# at 259
#200515 18:23:32 server id 330640  end_log_pos 337 CRC32 0xf461d3de 	Query	thread_id=19	exec_time=4	error_code=0
SET TIMESTAMP=1589538212.041610/*!*/;
SET @@session.pseudo_thread_id=19/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1075838976/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
BEGIN
/*!*/;
# at 337
#200515 18:23:32 server id 330640  end_log_pos 392 CRC32 0xdf45699f 	Table_map: `sbtest`.`_t_new` mapped to number 205
# at 392
#200515 18:23:32 server id 330640  end_log_pos 450 CRC32 0x1cd0198b 	Write_rows: table id 205 flags: STMT_END_F
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=500001 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=500001 /* INT meta=0 nullable=1 is_null=0 */
###   @3=500001 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589538212.041 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
# at 450
#200515 18:23:32 server id 330640  end_log_pos 481 CRC32 0x815dd85a 	Xid = 266
COMMIT/*!*/;
# at 481
#200515 18:23:41 server id 330640  end_log_pos 546 CRC32 0x0c0a4665 	GTID	last_committed=0	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:164282472'/*!*/;
# at 546
#200515 18:23:31 server id 330640  end_log_pos 624 CRC32 0xa8b5e878 	Query	thread_id=18	exec_time=0	error_code=0
SET TIMESTAMP=1589538211.386647/*!*/;
BEGIN
/*!*/;
# at 624
#200515 18:23:31 server id 330640  end_log_pos 679 CRC32 0x8f2261e4 	Table_map: `sbtest`.`_t_new` mapped to number 205
# at 679
#200515 18:23:31 server id 330640  end_log_pos 8879 CRC32 0x85eccd69 	Write_rows: table id 205
# at 8879
#200515 18:23:31 server id 330640  end_log_pos 17079 CRC32 0xef0cddab 	Write_rows: table id 205
# at 17079
#200515 18:23:31 server id 330640  end_log_pos 25279 CRC32 0x3cb9431f 	Write_rows: table id 205
# at 25279
#200515 18:23:31 server id 330640  end_log_pos 33479 CRC32 0xa519c190 	Write_rows: table id 205
# at 33479
#200515 18:23:31 server id 330640  end_log_pos 41679 CRC32 0x3e1367d4 	Write_rows: table id 205
# at 41679
#200515 18:23:31 server id 330640  end_log_pos 49879 CRC32 0xde072908 	Write_rows: table id 205
# at 49879
#200515 18:23:31 server id 330640  end_log_pos 58079 CRC32 0x80c3ea6d 	Write_rows: table id 205
# at 58079
#200515 18:23:31 server id 330640  end_log_pos 66279 CRC32 0x88fae86c 	Write_rows: table id 205
# at 66279
#200515 18:23:31 server id 330640  end_log_pos 74479 CRC32 0xe40219a5 	Write_rows: table id 205
# at 74479
#200515 18:23:31 server id 330640  end_log_pos 82679 CRC32 0xf24af397 	Write_rows: table id 205
# at 82679

..........................................................

#200515 14:58:28 server id 330640  end_log_pos 11529879 CRC32 0x5ab10229 	Write_rows: table id 149
# at 11529879
#200515 14:58:28 server id 330640  end_log_pos 11538079 CRC32 0xecb39987 	Write_rows: table id 149
# at 11538079
#200515 14:58:28 server id 330640  end_log_pos 11546279 CRC32 0xf4eb9995 	Write_rows: table id 149
# at 11546279
#200515 14:58:28 server id 330640  end_log_pos 11549994 CRC32 0x4cb4a0d6 	Write_rows: table id 149 flags: STMT_END_F
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=1 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589525908.080 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=2 /* INT meta=0 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589525908.080 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=3 /* INT meta=0 nullable=1 is_null=0 */
###   @3=3 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589525908.080 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */

...................................

### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=499998 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=499998 /* INT meta=0 nullable=1 is_null=0 */
###   @3=499998 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589538211.386 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=499999 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=499999 /* INT meta=0 nullable=1 is_null=0 */
###   @3=499999 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589538211.386 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=500000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=500000 /* INT meta=0 nullable=1 is_null=0 */
###   @3=500000 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589538211.386 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
# at 11549994
#200515 18:23:41 server id 330640  end_log_pos 11550025 CRC32 0x37bf964e 	Xid = 265
COMMIT/*!*/;
# at 11550025
#200515 18:24:07 server id 330640  end_log_pos 11550072 CRC32 0x1fce7930 	Rotate to mysql-bin.000094  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file


