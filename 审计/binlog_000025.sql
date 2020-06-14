/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#180510 23:50:33 server id 123306  end_log_pos 123 CRC32 0x96057376 	Start: binlog v 4, server v 5.7.20-log created 180510 23:50:33 at startup
# Warning: this binlog is either in use or was not closed properly.
ROLLBACK/*!*/;
# at 123
#180510 23:50:33 server id 123306  end_log_pos 154 CRC32 0x9a91f9d3 	Previous-GTIDs
# [empty]
# at 154
#180511 23:06:54 server id 123306  end_log_pos 219 CRC32 0x0225b682 	Anonymous_GTID	last_committed=0	sequence_number=1	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 219
#180511 23:06:54 server id 123306  end_log_pos 295 CRC32 0x9e7c0368 	Query	thread_id=12	exec_time=0	error_code=0
SET TIMESTAMP=1526094414/*!*/;
SET @@session.pseudo_thread_id=12/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1436549152/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=33/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
BEGIN
/*!*/;
# at 295
#180511 23:06:54 server id 123306  end_log_pos 360 CRC32 0x3fdea97e 	Table_map: `audit_db`.`accesslog` mapped to number 108
# at 360
#180511 23:06:54 server id 123306  end_log_pos 408 CRC32 0x7726def0 	Write_rows: table id 108 flags: STMT_END_F
### INSERT INTO `audit_db`.`accesslog`
### SET
###   @1=1
###   @2=2
###   @3='2'
###   @4='2'
###   @5=NULL
# at 408
#180511 23:06:54 server id 123306  end_log_pos 439 CRC32 0x1c809de0 	Xid = 614
COMMIT/*!*/;
# at 439
#180511 23:16:56 server id 123306  end_log_pos 504 CRC32 0x4a65ef8a 	Anonymous_GTID	last_committed=1	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 504
#180511 23:16:56 server id 123306  end_log_pos 580 CRC32 0x2a6535b5 	Query	thread_id=21	exec_time=0	error_code=0
SET TIMESTAMP=1526095016/*!*/;
BEGIN
/*!*/;
# at 580
#180511 23:16:56 server id 123306  end_log_pos 645 CRC32 0x8b577f7c 	Table_map: `audit_db`.`accesslog` mapped to number 108
# at 645
#180511 23:16:56 server id 123306  end_log_pos 693 CRC32 0x2b36f1fb 	Delete_rows: table id 108 flags: STMT_END_F
### DELETE FROM `audit_db`.`accesslog`
### WHERE
###   @1=1
###   @2=2
###   @3='2'
###   @4='2'
###   @5=NULL
# at 693
#180511 23:16:56 server id 123306  end_log_pos 724 CRC32 0x2ba58a47 	Xid = 718
COMMIT/*!*/;
# at 724
#180511 23:06:54 server id 123306  end_log_pos 789 CRC32 0xbcc6fedc 	Anonymous_GTID	last_committed=2	sequence_number=3	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 789
#180511 23:06:54 server id 123306  end_log_pos 857 CRC32 0x7a5377ea 	Query	thread_id=12	exec_time=605	error_code=0
SET TIMESTAMP=1526094414/*!*/;
SET @@session.sql_mode=524288/*!*/;
BEGIN
/*!*/;
# at 857
#180511 23:06:54 server id 123306  end_log_pos 922 CRC32 0x95cc2011 	Table_map: `audit_db`.`accesslog` mapped to number 108
# at 922
#180511 23:06:54 server id 123306  end_log_pos 970 CRC32 0xf34e7c90 	Write_rows: table id 108 flags: STMT_END_F
### INSERT INTO `audit_db`.`accesslog`
### SET
###   @1=1
###   @2=2
###   @3='2'
###   @4='2'
###   @5=NULL
# at 970
#180511 23:06:54 server id 123306  end_log_pos 1001 CRC32 0x05183aeb 	Xid = 736
COMMIT/*!*/;
# at 1001
#180511 23:37:19 server id 123306  end_log_pos 1066 CRC32 0xae7fdd36 	Anonymous_GTID	last_committed=3	sequence_number=4	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1066
#180511 23:37:19 server id 123306  end_log_pos 1142 CRC32 0x4a5ea031 	Query	thread_id=23	exec_time=0	error_code=0
SET TIMESTAMP=1526096239/*!*/;
SET @@session.sql_mode=1436549152/*!*/;
BEGIN
/*!*/;
# at 1142
#180511 23:37:19 server id 123306  end_log_pos 1207 CRC32 0xfb76fbd4 	Table_map: `audit_db`.`accesslog` mapped to number 108
# at 1207
#180511 23:37:19 server id 123306  end_log_pos 1255 CRC32 0x3cef2f90 	Delete_rows: table id 108 flags: STMT_END_F
### DELETE FROM `audit_db`.`accesslog`
### WHERE
###   @1=1
###   @2=2
###   @3='2'
###   @4='2'
###   @5=NULL
# at 1255
#180511 23:37:19 server id 123306  end_log_pos 1286 CRC32 0xd0e06646 	Xid = 752
COMMIT/*!*/;
# at 1286
#180511 23:39:01 server id 123306  end_log_pos 1351 CRC32 0x9f257246 	Anonymous_GTID	last_committed=4	sequence_number=5	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1351
#180511 23:39:01 server id 123306  end_log_pos 1427 CRC32 0xbf9fc821 	Query	thread_id=25	exec_time=0	error_code=0
SET TIMESTAMP=1526096341/*!*/;
SET @@session.pseudo_thread_id=25/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
BEGIN
/*!*/;
# at 1427
#180511 23:39:01 server id 123306  end_log_pos 1492 CRC32 0x4025a626 	Table_map: `audit_db`.`accesslog` mapped to number 108
# at 1492
#180511 23:39:01 server id 123306  end_log_pos 1580 CRC32 0xfba22e15 	Write_rows: table id 108 flags: STMT_END_F
### INSERT INTO `audit_db`.`accesslog`
### SET
###   @1=2
###   @2=25
###   @3='operation_user@node12'
###   @4='operation_user@%'
###   @5='2018-05-11 23:39:01'
# at 1580
#180511 23:39:01 server id 123306  end_log_pos 1611 CRC32 0x1155eef5 	Xid = 785
COMMIT/*!*/;
# at 1611
#180511 23:39:52 server id 123306  end_log_pos 1676 CRC32 0xdcf6892d 	Anonymous_GTID	last_committed=5	sequence_number=6	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1676
#180511 23:39:52 server id 123306  end_log_pos 1748 CRC32 0x3841410c 	Query	thread_id=25	exec_time=0	error_code=0
SET TIMESTAMP=1526096392/*!*/;
BEGIN
/*!*/;
# at 1748
#180511 23:39:52 server id 123306  end_log_pos 1841 CRC32 0x1a935e43 	Table_map: `test`.`accountinfo` mapped to number 279
# at 1841
#180511 23:39:52 server id 123306  end_log_pos 2178 CRC32 0x37bd1a77 	Update_rows: table id 279 flags: STMT_END_F
### UPDATE `test`.`accountinfo`
### WHERE
###   @1=7
###   @2='0000000007'
###   @3='00000000010000000006'
###   @4=1
###   @5='gs895'
###   @6='B6343AA888BDA1379674C9499C9564F7'
###   @7='公司3'
###   @8=''
###   @9=''
###   @10=''
###   @11=1
###   @12=1480425381
###   @13=1523479876
###   @14=1523479876
###   @15='7*4edd59c28ce14009b366e529c15b9a91'
###   @16='0'
### SET
###   @1=7
###   @2='0000000007'
###   @3='00000000010000000006'
###   @4=1
###   @5='gs4188'
###   @6='B6343AA888BDA1379674C9499C9564F7'
###   @7='公司3'
###   @8=''
###   @9=''
###   @10=''
###   @11=1
###   @12=1480425381
###   @13=1523479876
###   @14=1523479876
###   @15='7*4edd59c28ce14009b366e529c15b9a91'
###   @16='0'
# at 2178
#180511 23:39:52 server id 123306  end_log_pos 2209 CRC32 0x7fde0cfd 	Xid = 811
COMMIT/*!*/;
# at 2209
#180511 23:40:34 server id 123306  end_log_pos 2274 CRC32 0xcfaa7a09 	Anonymous_GTID	last_committed=6	sequence_number=7	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 2274
#180511 23:40:34 server id 123306  end_log_pos 2346 CRC32 0xac3b49f4 	Query	thread_id=25	exec_time=0	error_code=0
SET TIMESTAMP=1526096434/*!*/;
BEGIN
/*!*/;
# at 2346
#180511 23:40:34 server id 123306  end_log_pos 2439 CRC32 0x2ad91aa0 	Table_map: `test`.`accountinfo` mapped to number 279
# at 2439
#180511 23:40:34 server id 123306  end_log_pos 2622 CRC32 0x022bdb4f 	Delete_rows: table id 279 flags: STMT_END_F
### DELETE FROM `test`.`accountinfo`
### WHERE
###   @1=11
###   @2='0000000011'
###   @3='00000000010000000010'
###   @4=1
###   @5='gc07189'
###   @6='76419C58730D9F35DE7AC538C2FD6737'
###   @7='MG002'
###   @8=''
###   @9=''
###   @10=''
###   @11=1
###   @12=1481551902
###   @13=1487259334
###   @14=1487259334
###   @15='11*e96b1c65962c454094ca8e0fd6801'
###   @16='0'
# at 2622
#180511 23:40:34 server id 123306  end_log_pos 2653 CRC32 0x53585f03 	Xid = 824
COMMIT/*!*/;
# at 2653
#180511 23:41:14 server id 123306  end_log_pos 2718 CRC32 0x999f2f8e 	Anonymous_GTID	last_committed=7	sequence_number=8	rbr_only=no
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 2718
#180511 23:41:14 server id 123306  end_log_pos 2963 CRC32 0x279915ec 	Query	thread_id=29	exec_time=0	error_code=0
SET TIMESTAMP=1526096474/*!*/;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON *.* TO 'init_user'@'%' IDENTIFIED WITH 'mysql_native_password' AS '*FF051C055989F0D4D3E061F738DD68E277934095'
/*!*/;
# at 2963
#180511 23:41:42 server id 123306  end_log_pos 3028 CRC32 0xff1cb99f 	Anonymous_GTID	last_committed=8	sequence_number=9	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 3028
#180511 23:41:42 server id 123306  end_log_pos 3104 CRC32 0x92152f47 	Query	thread_id=30	exec_time=0	error_code=0
SET TIMESTAMP=1526096502/*!*/;
SET @@session.pseudo_thread_id=30/*!*/;
BEGIN
/*!*/;
# at 3104
#180511 23:41:42 server id 123306  end_log_pos 3169 CRC32 0x43d2754e 	Table_map: `audit_db`.`accesslog` mapped to number 108
# at 3169
#180511 23:41:42 server id 123306  end_log_pos 3247 CRC32 0x96a23564 	Write_rows: table id 108 flags: STMT_END_F
### INSERT INTO `audit_db`.`accesslog`
### SET
###   @1=3
###   @2=30
###   @3='init_user@node12'
###   @4='init_user@%'
###   @5='2018-05-11 23:41:42'
# at 3247
#180511 23:41:42 server id 123306  end_log_pos 3278 CRC32 0x946f3b83 	Xid = 834
COMMIT/*!*/;
# at 3278
#180511 23:42:26 server id 123306  end_log_pos 3343 CRC32 0x679f1e93 	Anonymous_GTID	last_committed=9	sequence_number=10	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 3343
#180511 23:42:26 server id 123306  end_log_pos 3415 CRC32 0x49430507 	Query	thread_id=30	exec_time=0	error_code=0
SET TIMESTAMP=1526096546/*!*/;
BEGIN
/*!*/;
# at 3415
#180511 23:42:26 server id 123306  end_log_pos 3508 CRC32 0x5794780a 	Table_map: `test`.`accountinfo` mapped to number 279
# at 3508
#180511 23:42:26 server id 123306  end_log_pos 3689 CRC32 0x4c761176 	Delete_rows: table id 279 flags: STMT_END_F
### DELETE FROM `test`.`accountinfo`
### WHERE
###   @1=13
###   @2='0000000013'
###   @3='00000000010000000012'
###   @4=1
###   @5='MG004'
###   @6='8AEF4D1F64D6DD481BEC830FAA0DE8B2'
###   @7='MG004'
###   @8=''
###   @9=''
###   @10=''
###   @11=1
###   @12=1481552017
###   @13=1489815234
###   @14=1489815234
###   @15='13*9be108d8bffd4b4ba228c71faecee'
###   @16='0'
# at 3689
#180511 23:42:26 server id 123306  end_log_pos 3720 CRC32 0x51a712ca 	Xid = 843
COMMIT/*!*/;
# at 3720
#180511 23:42:32 server id 123306  end_log_pos 3785 CRC32 0xa2462747 	Anonymous_GTID	last_committed=10	sequence_number=11	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 3785
#180511 23:42:32 server id 123306  end_log_pos 3857 CRC32 0x3ea5e890 	Query	thread_id=30	exec_time=0	error_code=0
SET TIMESTAMP=1526096552/*!*/;
BEGIN
/*!*/;
# at 3857
#180511 23:42:32 server id 123306  end_log_pos 3950 CRC32 0x16ac9cdc 	Table_map: `test`.`accountinfo` mapped to number 279
# at 3950
#180511 23:42:32 server id 123306  end_log_pos 4131 CRC32 0x19dcdb1c 	Delete_rows: table id 279 flags: STMT_END_F
### DELETE FROM `test`.`accountinfo`
### WHERE
###   @1=14
###   @2='0000000014'
###   @3='00000000010000000013'
###   @4=1
###   @5='MG005'
###   @6='2C42F62F948CC723FDD90BCC1611B146'
###   @7='MG005'
###   @8=''
###   @9=''
###   @10=''
###   @11=1
###   @12=1481552027
###   @13=1489815270
###   @14=1489815270
###   @15='14*3858ea47363b494bba7a917f6c418'
###   @16='0'
# at 4131
#180511 23:42:32 server id 123306  end_log_pos 4162 CRC32 0x58c19444 	Xid = 846
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
