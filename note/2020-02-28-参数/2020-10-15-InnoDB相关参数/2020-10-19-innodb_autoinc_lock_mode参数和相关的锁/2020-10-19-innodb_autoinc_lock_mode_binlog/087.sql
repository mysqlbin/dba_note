
show binlog events in 'mysql-bin.000087';

+------------------+----------+----------------+-----------+-------------+---------------------------------------------------------------------------+
| Log_name         | Pos      | Event_type     | Server_id | End_log_pos | Info                                                                      |
+------------------+----------+----------------+-----------+-------------+---------------------------------------------------------------------------+
| mysql-bin.000087 |        4 | Format_desc    |    330640 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                     |
| mysql-bin.000087 |      123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-164282457                          |
| mysql-bin.000087 |      194 | Gtid           |    330640 |         259 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:164282458' |
| mysql-bin.000087 |      259 | Query          |    330640 |         337 | BEGIN                                                                     |
| mysql-bin.000087 |      337 | Table_map      |    330640 |         392 | table_id: 149 (sbtest._t_new)                                             |
| mysql-bin.000087 |      392 | Write_rows     |    330640 |         450 | table_id: 149 flags: STMT_END_F                                           |
| mysql-bin.000087 |      450 | Xid            |    330640 |         481 | COMMIT /* xid=91 */                                                       |
| mysql-bin.000087 |      481 | Gtid           |    330640 |         546 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:164282459' |
| mysql-bin.000087 |      546 | Query          |    330640 |         624 | BEGIN                                                                     |
| mysql-bin.000087 |      624 | Table_map      |    330640 |         679 | table_id: 149 (sbtest._t_new)                                             |
| mysql-bin.000087 |      679 | Write_rows     |    330640 |        8879 | table_id: 149                                                             |
| mysql-bin.000087 |     8879 | Write_rows     |    330640 |       17079 | table_id: 149                                                             |
| mysql-bin.000087 |    17079 | Write_rows     |    330640 |       25279 | table_id: 149                                                             |
| mysql-bin.000087 |    25279 | Write_rows     |    330640 |       33479 | table_id: 149                                                             |
| mysql-bin.000087 |    33479 | Write_rows     |    330640 |       41679 | table_id: 149                                                             |
| mysql-bin.000087 |    41679 | Write_rows     |    330640 |       49879 | table_id: 149                                                             |
| mysql-bin.000087 |    49879 | Write_rows     |    330640 |       58079 | table_id: 149                                                             |

......................................................................................................

| mysql-bin.000087 | 11505279 | Write_rows     |    330640 |    11513479 | table_id: 149                                                             |
| mysql-bin.000087 | 11513479 | Write_rows     |    330640 |    11521679 | table_id: 149                                                             |
| mysql-bin.000087 | 11521679 | Write_rows     |    330640 |    11529879 | table_id: 149                                                             |
| mysql-bin.000087 | 11529879 | Write_rows     |    330640 |    11538079 | table_id: 149                                                             |
| mysql-bin.000087 | 11538079 | Write_rows     |    330640 |    11546279 | table_id: 149                                                             |
| mysql-bin.000087 | 11546279 | Write_rows     |    330640 |    11549994 | table_id: 149 flags: STMT_END_F                                           |
| mysql-bin.000087 | 11549994 | Xid            |    330640 |    11550025 | COMMIT /* xid=90 */                                                       |
| mysql-bin.000087 | 11550025 | Rotate         |    330640 |    11550072 | mysql-bin.000088;pos=4                                                    |
+------------------+----------+----------------+-----------+-------------+---------------------------------------------------------------------------+

[root@voice logs]# head -70 087.sql 
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200515 14:58:24 server id 330640  end_log_pos 123 CRC32 0xa8e19ca2 	Start: binlog v 4, server v 5.7.22-log created 200515 14:58:24
# at 123
#200515 14:58:24 server id 330640  end_log_pos 194 CRC32 0x785385f2 	Previous-GTIDs
# 7af746a1-5c2d-11ea-bc75-00163e08b460:1-164282457
# at 194
#200515 14:58:28 server id 330640  end_log_pos 259 CRC32 0xfdb09c51 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:164282458'/*!*/;
# at 259
#200515 14:58:28 server id 330640  end_log_pos 337 CRC32 0x0a80d035 	Query	thread_id=4	exec_time=4	error_code=0
SET TIMESTAMP=1589525908.773150/*!*/;
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
# at 337
#200515 14:58:28 server id 330640  end_log_pos 392 CRC32 0xfceff1a2 	Table_map: `sbtest`.`_t_new` mapped to number 149
# at 392
#200515 14:58:28 server id 330640  end_log_pos 450 CRC32 0x45c9eaf9 	Write_rows: table id 149 flags: STMT_END_F
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=500001 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=500001 /* INT meta=0 nullable=1 is_null=0 */
###   @3=500001 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589525908.773 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
# at 450
#200515 14:58:28 server id 330640  end_log_pos 481 CRC32 0x32b3e112 	Xid = 91
COMMIT/*!*/;
# at 481
#200515 14:58:48 server id 330640  end_log_pos 546 CRC32 0xf7fb76d1 	GTID	last_committed=0	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:164282459'/*!*/;
# at 546
#200515 14:58:28 server id 330640  end_log_pos 624 CRC32 0x868239c4 	Query	thread_id=3	exec_time=0	error_code=0
SET TIMESTAMP=1589525908.080948/*!*/;
BEGIN
/*!*/;
# at 624
#200515 14:58:28 server id 330640  end_log_pos 679 CRC32 0xb7a329e3 	Table_map: `sbtest`.`_t_new` mapped to number 149
# at 679
#200515 14:58:28 server id 330640  end_log_pos 8879 CRC32 0x3943e6df 	Write_rows: table id 149
# at 8879
#200515 14:58:28 server id 330640  end_log_pos 17079 CRC32 0x53a3f61d 	Write_rows: table id 149
# at 17079
#200515 14:58:28 server id 330640  end_log_pos 25279 CRC32 0x801668a9 	Write_rows: table id 149
# at 25279
#200515 14:58:28 server id 330640  end_log_pos 33479 CRC32 0x19b6ea26 	Write_rows: table id 149
# at 33479

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
###   @4=1589525908.080 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=499999 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=499999 /* INT meta=0 nullable=1 is_null=0 */
###   @3=499999 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589525908.080 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
### INSERT INTO `sbtest`.`_t_new`
### SET
###   @1=500000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=500000 /* INT meta=0 nullable=1 is_null=0 */
###   @3=500000 /* INT meta=0 nullable=1 is_null=0 */
###   @4=1589525908.080 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
# at 11549994
#200515 14:58:48 server id 330640  end_log_pos 11550025 CRC32 0x2b242580        Xid = 90
COMMIT/*!*/;
# at 11550025
#200515 15:00:27 server id 330640  end_log_pos 11550072 CRC32 0x6fef0325        Rotate to mysql-bin.000088  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;


