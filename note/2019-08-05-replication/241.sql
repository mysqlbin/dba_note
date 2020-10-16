/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#201016 11:28:11 server id 1  end_log_pos 123 CRC32 0x459a4b41 	Start: binlog v 4, server v 5.7.26-log created 201016 11:28:11
# Warning: this binlog is either in use or was not closed properly.
# at 51850646
#201016 11:40:00 server id 1  end_log_pos 51850711 CRC32 0xf403161e 	GTID	last_committed=50716	sequence_number=50717	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409288'/*!*/;
# at 51850711
#201016 11:40:00 server id 1  end_log_pos 51850798 CRC32 0x1460162c 	Query	thread_id=98071	exec_time=0	error_code=0
SET TIMESTAMP=1602819600/*!*/;
SET @@session.pseudo_thread_id=98071/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=1, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1075838976/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
BEGIN
/*!*/;
# at 51850798
#201016 11:40:00 server id 1  end_log_pos 51851104 CRC32 0xba648b41 	Rows_query
# INSERT INTO table_webdata_analysis_dailyonline (
# 		`nClubId`,
# 		`onlineCount`,
# 		`tEndTime`
# 	) SELECT
# 		tuser.nLastClubID,
# 		count(*),
# 		now()
# 	FROM
# 		table_user_gamelock game
# 	INNER JOIN table_user tuser ON game.nPlayerID = tuser.nPlayerID
# 	GROUP BY
# 		tuser.nLastClubID
# at 51851104
#201016 11:40:00 server id 1  end_log_pos 51851192 CRC32 0xabfdb02e 	Table_map: `niuniuh5_db`.`table_webdata_analysis_dailyonline` mapped to number 1035
# at 51851192
#201016 11:40:00 server id 1  end_log_pos 51851244 CRC32 0x1a7e05ca 	Write_rows: table id 1035 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_webdata_analysis_dailyonline`
### SET
###   @1=1971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=3 /* INT meta=0 nullable=0 is_null=0 */
###   @4=1602819600 /* TIMESTAMP(0) meta=0 nullable=1 is_null=0 */
# at 51851244
#201016 11:40:00 server id 1  end_log_pos 51851275 CRC32 0xe0eeec38 	Xid = 28395295
COMMIT/*!*/;
# at 51851275
#201016 11:40:02 server id 1  end_log_pos 51851340 CRC32 0x85c2c606 	GTID	last_committed=50717	sequence_number=50718	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409289'/*!*/;
# at 51851340
#201016 11:40:02 server id 1  end_log_pos 51851427 CRC32 0x7c098787 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819602/*!*/;
SET @@session.sql_auto_is_null=0/*!*/;
BEGIN
/*!*/;
# at 51851427
#201016 11:40:02 server id 1  end_log_pos 51851698 CRC32 0x1a34ce6d 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819571-830-12',NULL,208000,5,0,0,'游戏获得',10445,0)
# at 51851698
#201016 11:40:02 server id 1  end_log_pos 51851794 CRC32 0x553cb223 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51851794
#201016 11:40:02 server id 1  end_log_pos 51851932 CRC32 0x4bbf8247 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002605 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819571-830-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=208000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819602 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51851932
#201016 11:40:02 server id 1  end_log_pos 51851963 CRC32 0x2b6b63ff 	Xid = 28395388
COMMIT/*!*/;
# at 51851963
#201016 11:40:02 server id 1  end_log_pos 51852028 CRC32 0xe8be97a7 	GTID	last_committed=50718	sequence_number=50719	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409290'/*!*/;
# at 51852028
#201016 11:40:02 server id 1  end_log_pos 51852115 CRC32 0x69ad702e 	Query	thread_id=94776	exec_time=0	error_code=0
SET TIMESTAMP=1602819602/*!*/;
BEGIN
/*!*/;
# at 51852115
#201016 11:40:02 server id 1  end_log_pos 51852635 CRC32 0x5f36ea8b 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819571-830',830,2000,0,'2020-10-16 11:39:31','2020-10-16 11:40:02',120041,0,0,'鸽子x8 (飞禽x2 )',208000,4000,0,0,208000,0,116,11601,'','','鸽子x8 (飞禽x2 )')
# at 51852635
#201016 11:40:02 server id 1  end_log_pos 51852755 CRC32 0xff9f7fcf 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51852755
#201016 11:40:02 server id 1  end_log_pos 51852961 CRC32 0xa2e70c16 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002605 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819571-830' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=830 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819571.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819602.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='鸽子x8 (飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='鸽子x8 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51852961
#201016 11:40:02 server id 1  end_log_pos 51852992 CRC32 0x0ca086bc 	Xid = 28395390
COMMIT/*!*/;
# at 51852992
#201016 11:40:02 server id 1  end_log_pos 51853057 CRC32 0x56578e49 	GTID	last_committed=50719	sequence_number=50720	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409291'/*!*/;
# at 51853057
#201016 11:40:02 server id 1  end_log_pos 51853144 CRC32 0xc6520c7a 	Query	thread_id=94776	exec_time=0	error_code=0
SET TIMESTAMP=1602819602/*!*/;
BEGIN
/*!*/;
# at 51853144
#201016 11:40:02 server id 1  end_log_pos 51853657 CRC32 0xc389857a 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819571-830-12','test92024',0,'2020-10-16 11:39:31','2020-10-16 11:40:02',120041,208000,4000,0,0,0,116,11601,'鸽子x8 (飞禽x2 )','gj')
# at 51853657
#201016 11:40:02 server id 1  end_log_pos 51853770 CRC32 0x00d8103e 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51853770
#201016 11:40:02 server id 1  end_log_pos 51853952 CRC32 0x06037f51 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002605 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819571-830-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819571.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819602.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='鸽子x8 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51853952
#201016 11:40:02 server id 1  end_log_pos 51853983 CRC32 0x26706230 	Xid = 28395420
COMMIT/*!*/;
# at 51853983
#201016 11:40:04 server id 1  end_log_pos 51854048 CRC32 0x4589e4fc 	GTID	last_committed=50720	sequence_number=50721	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409292'/*!*/;
# at 51854048
#201016 11:40:04 server id 1  end_log_pos 51854127 CRC32 0x7250f74b 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819604/*!*/;
BEGIN
/*!*/;
# at 51854127
#201016 11:40:04 server id 1  end_log_pos 51854263 CRC32 0x2cc0105f 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51854263
#201016 11:40:04 server id 1  end_log_pos 51854357 CRC32 0x1b95cdaf 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51854357
#201016 11:40:04 server id 1  end_log_pos 51854563 CRC32 0xc3c226ee 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=232400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=228400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51854563
#201016 11:40:04 server id 1  end_log_pos 51854594 CRC32 0x3bee9d99 	Xid = 28395423
COMMIT/*!*/;
# at 51854594
#201016 11:40:04 server id 1  end_log_pos 51854659 CRC32 0x41d46588 	GTID	last_committed=50721	sequence_number=50722	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409293'/*!*/;
# at 51854659
#201016 11:40:04 server id 1  end_log_pos 51854746 CRC32 0xa270a02c 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819604/*!*/;
BEGIN
/*!*/;
# at 51854746
#201016 11:40:04 server id 1  end_log_pos 51855020 CRC32 0x8c24df1c 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819576-511-16',NULL,228400,6,0,0,'游戏消耗',10445,0)
# at 51855020
#201016 11:40:04 server id 1  end_log_pos 51855116 CRC32 0x3dfe77e0 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51855116
#201016 11:40:04 server id 1  end_log_pos 51855254 CRC32 0x79e5f9f8 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002606 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819576-511-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=228400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819604 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51855254
#201016 11:40:04 server id 1  end_log_pos 51855285 CRC32 0xa74c4576 	Xid = 28395450
COMMIT/*!*/;
# at 51855285
#201016 11:40:04 server id 1  end_log_pos 51855350 CRC32 0xe7de6b85 	GTID	last_committed=50722	sequence_number=50723	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409294'/*!*/;
# at 51855350
#201016 11:40:04 server id 1  end_log_pos 51855437 CRC32 0xa419e877 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819604/*!*/;
BEGIN
/*!*/;
# at 51855437
#201016 11:40:04 server id 1  end_log_pos 51855947 CRC32 0x96809b6b 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819576-511',511,2000,0,'2020-10-16 11:39:36','2020-10-16 11:40:04',91576,0,0,'玛莎拉蒂',232400,4000,4000,-4000,228400,0,117,11701,'','','玛莎拉蒂')
# at 51855947
#201016 11:40:04 server id 1  end_log_pos 51856067 CRC32 0x7d5f1db1 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51856067
#201016 11:40:04 server id 1  end_log_pos 51856257 CRC32 0x18e9f974 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002606 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819576-511' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=511 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819576.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819604.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='玛莎拉蒂' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=232400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=228400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='玛莎拉蒂' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51856257
#201016 11:40:04 server id 1  end_log_pos 51856288 CRC32 0xbf3d7baa 	Xid = 28395485
COMMIT/*!*/;
# at 51856288
#201016 11:40:04 server id 1  end_log_pos 51856353 CRC32 0x5f560741 	GTID	last_committed=50723	sequence_number=50724	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409295'/*!*/;
# at 51856353
#201016 11:40:04 server id 1  end_log_pos 51856440 CRC32 0xf50c2c44 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819604/*!*/;
BEGIN
/*!*/;
# at 51856440
#201016 11:40:04 server id 1  end_log_pos 51856951 CRC32 0xdd654d3b 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819576-511-16','test92022',0,'2020-10-16 11:39:36','2020-10-16 11:40:04',91576,232400,4000,4000,-4000,0,117,11701,'玛莎拉蒂','gj')
# at 51856951
#201016 11:40:04 server id 1  end_log_pos 51857064 CRC32 0x5c0772fd 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51857064
#201016 11:40:04 server id 1  end_log_pos 51857238 CRC32 0xbf27b6c6 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002606 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819576-511-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819576.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819604.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=232400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='玛莎拉蒂' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51857238
#201016 11:40:04 server id 1  end_log_pos 51857269 CRC32 0xeec9371c 	Xid = 28395512
COMMIT/*!*/;
# at 51857269
#201016 11:40:35 server id 1  end_log_pos 51857334 CRC32 0x08f4ae44 	GTID	last_committed=50724	sequence_number=50725	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409296'/*!*/;
# at 51857334
#201016 11:40:35 server id 1  end_log_pos 51857421 CRC32 0x2fbe12db 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819635/*!*/;
BEGIN
/*!*/;
# at 51857421
#201016 11:40:35 server id 1  end_log_pos 51857692 CRC32 0x9a1e75ad 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819604-831-12',NULL,208000,5,0,0,'游戏获得',10445,0)
# at 51857692
#201016 11:40:35 server id 1  end_log_pos 51857788 CRC32 0xcebb01a6 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51857788
#201016 11:40:35 server id 1  end_log_pos 51857926 CRC32 0xcf46dbf9 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002607 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819604-831-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=208000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819635 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51857926
#201016 11:40:35 server id 1  end_log_pos 51857957 CRC32 0x45a179e0 	Xid = 28395640
COMMIT/*!*/;
# at 51857957
#201016 11:40:35 server id 1  end_log_pos 51858022 CRC32 0xbf241bbb 	GTID	last_committed=50725	sequence_number=50726	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409297'/*!*/;
# at 51858022
#201016 11:40:35 server id 1  end_log_pos 51858109 CRC32 0x556beb84 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819635/*!*/;
BEGIN
/*!*/;
# at 51858109
#201016 11:40:35 server id 1  end_log_pos 51858629 CRC32 0x1f64f53a 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819604-831',831,2000,0,'2020-10-16 11:40:04','2020-10-16 11:40:35',120041,0,0,'鸽子x8 (飞禽x2 )',208000,4000,0,0,208000,0,116,11601,'','','鸽子x8 (飞禽x2 )')
# at 51858629
#201016 11:40:35 server id 1  end_log_pos 51858749 CRC32 0x9fe85791 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51858749
#201016 11:40:35 server id 1  end_log_pos 51858955 CRC32 0x3cce36ca 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002607 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819604-831' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=831 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819604.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819635.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='鸽子x8 (飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='鸽子x8 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51858955
#201016 11:40:35 server id 1  end_log_pos 51858986 CRC32 0xded38502 	Xid = 28395675
COMMIT/*!*/;
# at 51858986
#201016 11:40:35 server id 1  end_log_pos 51859051 CRC32 0xecb60d5c 	GTID	last_committed=50726	sequence_number=50727	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409298'/*!*/;
# at 51859051
#201016 11:40:35 server id 1  end_log_pos 51859138 CRC32 0x101096fa 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819635/*!*/;
BEGIN
/*!*/;
# at 51859138
#201016 11:40:35 server id 1  end_log_pos 51859651 CRC32 0xc6f7672e 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819604-831-12','test92024',0,'2020-10-16 11:40:04','2020-10-16 11:40:35',120041,208000,4000,0,0,0,116,11601,'鸽子x8 (飞禽x2 )','gj')
# at 51859651
#201016 11:40:35 server id 1  end_log_pos 51859764 CRC32 0x61a8d970 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51859764
#201016 11:40:35 server id 1  end_log_pos 51859946 CRC32 0xea74c620 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002607 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819604-831-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819604.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819635.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='鸽子x8 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51859946
#201016 11:40:35 server id 1  end_log_pos 51859977 CRC32 0x2318b0a7 	Xid = 28395702
COMMIT/*!*/;
# at 51859977
#201016 11:40:35 server id 1  end_log_pos 51860042 CRC32 0x7aa7a55d 	GTID	last_committed=50727	sequence_number=50728	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409299'/*!*/;
# at 51860042
#201016 11:40:35 server id 1  end_log_pos 51860121 CRC32 0x4af3a9da 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819635/*!*/;
BEGIN
/*!*/;
# at 51860121
#201016 11:40:35 server id 1  end_log_pos 51860257 CRC32 0xfca01468 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51860257
#201016 11:40:35 server id 1  end_log_pos 51860351 CRC32 0x42fa269a 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51860351
#201016 11:40:35 server id 1  end_log_pos 51860557 CRC32 0x7fc44dba 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=228400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=224400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51860557
#201016 11:40:35 server id 1  end_log_pos 51860588 CRC32 0x52a39c92 	Xid = 28395705
COMMIT/*!*/;
# at 51860588
#201016 11:40:35 server id 1  end_log_pos 51860653 CRC32 0x0a50653f 	GTID	last_committed=50727	sequence_number=50729	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409300'/*!*/;
# at 51860653
#201016 11:40:35 server id 1  end_log_pos 51860740 CRC32 0x37e3a273 	Query	thread_id=94773	exec_time=0	error_code=0
SET TIMESTAMP=1602819635/*!*/;
BEGIN
/*!*/;
# at 51860740
#201016 11:40:35 server id 1  end_log_pos 51861250 CRC32 0xa9e42e08 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819607-512',512,2000,0,'2020-10-16 11:40:07','2020-10-16 11:40:35',91576,0,0,'雷克萨斯',228400,4000,4000,-4000,224400,0,117,11701,'','','雷克萨斯')
# at 51861250
#201016 11:40:35 server id 1  end_log_pos 51861370 CRC32 0x4a6ca888 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51861370
#201016 11:40:35 server id 1  end_log_pos 51861560 CRC32 0x1b794876 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002608 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819607-512' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=512 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819607.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819635.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='雷克萨斯' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=228400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=224400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='雷克萨斯' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51861560
#201016 11:40:35 server id 1  end_log_pos 51861591 CRC32 0xfc1cfa8b 	Xid = 28395737
COMMIT/*!*/;
# at 51861591
#201016 11:40:35 server id 1  end_log_pos 51861656 CRC32 0x5172f5fd 	GTID	last_committed=50728	sequence_number=50730	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409301'/*!*/;
# at 51861656
#201016 11:40:35 server id 1  end_log_pos 51861743 CRC32 0x7469bee5 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819635/*!*/;
BEGIN
/*!*/;
# at 51861743
#201016 11:40:35 server id 1  end_log_pos 51862017 CRC32 0x1ed29407 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819607-512-16',NULL,224400,6,0,0,'游戏消耗',10445,0)
# at 51862017
#201016 11:40:35 server id 1  end_log_pos 51862113 CRC32 0x20631718 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51862113
#201016 11:40:35 server id 1  end_log_pos 51862251 CRC32 0xe806f448 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002608 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819607-512-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=224400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819635 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51862251
#201016 11:40:35 server id 1  end_log_pos 51862282 CRC32 0xb3545a04 	Xid = 28395764
COMMIT/*!*/;
# at 51862282
#201016 11:40:35 server id 1  end_log_pos 51862347 CRC32 0x237e3ef3 	GTID	last_committed=50729	sequence_number=50731	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409302'/*!*/;
# at 51862347
#201016 11:40:35 server id 1  end_log_pos 51862434 CRC32 0x2b4e58b7 	Query	thread_id=94773	exec_time=0	error_code=0
SET TIMESTAMP=1602819635/*!*/;
BEGIN
/*!*/;
# at 51862434
#201016 11:40:35 server id 1  end_log_pos 51862945 CRC32 0x5536fab9 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819607-512-16','test92022',0,'2020-10-16 11:40:07','2020-10-16 11:40:35',91576,228400,4000,4000,-4000,0,117,11701,'雷克萨斯','gj')
# at 51862945
#201016 11:40:35 server id 1  end_log_pos 51863058 CRC32 0x42f53fcd 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51863058
#201016 11:40:35 server id 1  end_log_pos 51863232 CRC32 0x8cce86a8 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002608 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819607-512-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819607.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819635.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=228400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='雷克萨斯' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51863232
#201016 11:40:35 server id 1  end_log_pos 51863263 CRC32 0x8ad6a0ad 	Xid = 28395791
COMMIT/*!*/;
# at 51863263
#201016 11:40:37 server id 1  end_log_pos 51863328 CRC32 0x658cd599 	GTID	last_committed=50731	sequence_number=50732	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409303'/*!*/;
# at 51863328
#201016 11:40:37 server id 1  end_log_pos 51863415 CRC32 0x17ad7328 	Query	thread_id=94637	exec_time=0	error_code=0
SET TIMESTAMP=1602819637/*!*/;
BEGIN
/*!*/;
# at 51863415
#201016 11:40:37 server id 1  end_log_pos 51863516 CRC32 0xf9c21e38 	Rows_query
# insert into Table_Web_TotalInLine_min(szTime, `online`) values(NOW(), $total)
# at 51863516
#201016 11:40:37 server id 1  end_log_pos 51863594 CRC32 0x57d6fc87 	Table_map: `niuniuh5_db`.`table_web_totalinline_min` mapped to number 109
# at 51863594
#201016 11:40:37 server id 1  end_log_pos 51863646 CRC32 0x2a3f0df6 	Write_rows: table id 109 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_web_totalinline_min`
### SET
###   @1=519791 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1602819637 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @3=2 /* INT meta=0 nullable=0 is_null=0 */
# at 51863646
#201016 11:40:37 server id 1  end_log_pos 51863677 CRC32 0xdebd77ce 	Xid = 28395801
COMMIT/*!*/;
# at 51863677
#201016 11:41:06 server id 1  end_log_pos 51863742 CRC32 0x58ef427d 	GTID	last_committed=50732	sequence_number=50733	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409304'/*!*/;
# at 51863742
#201016 11:41:06 server id 1  end_log_pos 51863821 CRC32 0x1795cfbd 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819666/*!*/;
BEGIN
/*!*/;
# at 51863821
#201016 11:41:06 server id 1  end_log_pos 51863957 CRC32 0x0503d489 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51863957
#201016 11:41:06 server id 1  end_log_pos 51864051 CRC32 0x7c7b695d 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51864051
#201016 11:41:06 server id 1  end_log_pos 51864257 CRC32 0xefe01df6 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=224400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=220400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51864257
#201016 11:41:06 server id 1  end_log_pos 51864288 CRC32 0x234b6167 	Xid = 28395889
COMMIT/*!*/;
# at 51864288
#201016 11:41:06 server id 1  end_log_pos 51864353 CRC32 0x541b78cb 	GTID	last_committed=50733	sequence_number=50734	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409305'/*!*/;
# at 51864353
#201016 11:41:06 server id 1  end_log_pos 51864440 CRC32 0xad3b3dbd 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819666/*!*/;
BEGIN
/*!*/;
# at 51864440
#201016 11:41:06 server id 1  end_log_pos 51864714 CRC32 0x35f297b3 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819638-513-16',NULL,220400,6,0,0,'游戏消耗',10445,0)
# at 51864714
#201016 11:41:06 server id 1  end_log_pos 51864810 CRC32 0xaa968add 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51864810
#201016 11:41:06 server id 1  end_log_pos 51864948 CRC32 0xfeb3f616 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002609 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819638-513-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=220400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819666 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51864948
#201016 11:41:06 server id 1  end_log_pos 51864979 CRC32 0xac58f03a 	Xid = 28395916
COMMIT/*!*/;
# at 51864979
#201016 11:41:06 server id 1  end_log_pos 51865044 CRC32 0xc9ceeaa8 	GTID	last_committed=50733	sequence_number=50735	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409306'/*!*/;
# at 51865044
#201016 11:41:06 server id 1  end_log_pos 51865131 CRC32 0x170d630d 	Query	thread_id=94774	exec_time=0	error_code=0
SET TIMESTAMP=1602819666/*!*/;
BEGIN
/*!*/;
# at 51865131
#201016 11:41:06 server id 1  end_log_pos 51865635 CRC32 0x878ed262 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819638-513',513,2000,0,'2020-10-16 11:40:38','2020-10-16 11:41:06',91576,0,0,'保时捷',224400,4000,4000,-4000,220400,0,117,11701,'','','保时捷')
# at 51865635
#201016 11:41:06 server id 1  end_log_pos 51865755 CRC32 0x3e711c21 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51865755
#201016 11:41:06 server id 1  end_log_pos 51865939 CRC32 0xf7f2260a 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002609 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819638-513' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=513 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819638.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819666.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='保时捷' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=224400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=220400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='保时捷' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51865939
#201016 11:41:06 server id 1  end_log_pos 51865970 CRC32 0x5d35aa2a 	Xid = 28395948
COMMIT/*!*/;
# at 51865970
#201016 11:41:06 server id 1  end_log_pos 51866035 CRC32 0xcaaf07e4 	GTID	last_committed=50735	sequence_number=50736	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409307'/*!*/;
# at 51866035
#201016 11:41:06 server id 1  end_log_pos 51866122 CRC32 0x451a761e 	Query	thread_id=94774	exec_time=0	error_code=0
SET TIMESTAMP=1602819666/*!*/;
BEGIN
/*!*/;
# at 51866122
#201016 11:41:06 server id 1  end_log_pos 51866630 CRC32 0x94cb7663 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819638-513-16','test92022',0,'2020-10-16 11:40:38','2020-10-16 11:41:06',91576,224400,4000,4000,-4000,0,117,11701,'保时捷','gj')
# at 51866630
#201016 11:41:06 server id 1  end_log_pos 51866743 CRC32 0x25ca582a 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51866743
#201016 11:41:06 server id 1  end_log_pos 51866914 CRC32 0xe74cc59e 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002609 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819638-513-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819638.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819666.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=224400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='保时捷' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51866914
#201016 11:41:06 server id 1  end_log_pos 51866945 CRC32 0x5cbf08ef 	Xid = 28395978
COMMIT/*!*/;
# at 51866945
#201016 11:41:08 server id 1  end_log_pos 51867010 CRC32 0x82678e7a 	GTID	last_committed=50736	sequence_number=50737	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409308'/*!*/;
# at 51867010
#201016 11:41:08 server id 1  end_log_pos 51867097 CRC32 0xc7060aff 	Query	thread_id=94778	exec_time=0	error_code=0
SET TIMESTAMP=1602819668/*!*/;
BEGIN
/*!*/;
# at 51867097
#201016 11:41:08 server id 1  end_log_pos 51867617 CRC32 0x708fddeb 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819637-832',832,2000,0,'2020-10-16 11:40:37','2020-10-16 11:41:08',120041,0,0,'狮子x12(走兽x2 )',208000,4000,0,0,208000,0,116,11601,'','','狮子x12(走兽x2 )')
# at 51867617
#201016 11:41:08 server id 1  end_log_pos 51867737 CRC32 0xc57c0d72 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51867737
#201016 11:41:08 server id 1  end_log_pos 51867943 CRC32 0xbd3f29a1 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002610 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819637-832' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=832 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819637.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819668.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='狮子x12(走兽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='狮子x12(走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51867943
#201016 11:41:08 server id 1  end_log_pos 51867974 CRC32 0xe2f1b32a 	Xid = 28396027
COMMIT/*!*/;
# at 51867974
#201016 11:41:08 server id 1  end_log_pos 51868039 CRC32 0xc08f9351 	GTID	last_committed=50736	sequence_number=50738	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409309'/*!*/;
# at 51868039
#201016 11:41:08 server id 1  end_log_pos 51868126 CRC32 0x193f2dcc 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819668/*!*/;
BEGIN
/*!*/;
# at 51868126
#201016 11:41:08 server id 1  end_log_pos 51868397 CRC32 0xddf5fd47 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819637-832-12',NULL,208000,5,0,0,'游戏获得',10445,0)
# at 51868397
#201016 11:41:08 server id 1  end_log_pos 51868493 CRC32 0xff6cf5b2 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51868493
#201016 11:41:08 server id 1  end_log_pos 51868631 CRC32 0xc5b82de6 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002610 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819637-832-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=208000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819668 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51868631
#201016 11:41:08 server id 1  end_log_pos 51868662 CRC32 0x6e4eaaf9 	Xid = 28396044
COMMIT/*!*/;
# at 51868662
#201016 11:41:08 server id 1  end_log_pos 51868727 CRC32 0xef4dd1e9 	GTID	last_committed=50737	sequence_number=50739	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409310'/*!*/;
# at 51868727
#201016 11:41:08 server id 1  end_log_pos 51868814 CRC32 0xc7961654 	Query	thread_id=94778	exec_time=0	error_code=0
SET TIMESTAMP=1602819668/*!*/;
BEGIN
/*!*/;
# at 51868814
#201016 11:41:08 server id 1  end_log_pos 51869327 CRC32 0x549be82e 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819637-832-12','test92024',0,'2020-10-16 11:40:37','2020-10-16 11:41:08',120041,208000,4000,0,0,0,116,11601,'狮子x12(走兽x2 )','gj')
# at 51869327
#201016 11:41:08 server id 1  end_log_pos 51869440 CRC32 0x3dfd7927 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51869440
#201016 11:41:08 server id 1  end_log_pos 51869622 CRC32 0x59d37131 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002610 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819637-832-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819637.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819668.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='狮子x12(走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51869622
#201016 11:41:08 server id 1  end_log_pos 51869653 CRC32 0xbbeee36c 	Xid = 28396071
COMMIT/*!*/;
# at 51869653
#201016 11:41:37 server id 1  end_log_pos 51869718 CRC32 0x4a8d9391 	GTID	last_committed=50739	sequence_number=50740	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409311'/*!*/;
# at 51869718
#201016 11:41:37 server id 1  end_log_pos 51869797 CRC32 0x962534fe 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819697/*!*/;
BEGIN
/*!*/;
# at 51869797
#201016 11:41:37 server id 1  end_log_pos 51869933 CRC32 0x7ec06733 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51869933
#201016 11:41:37 server id 1  end_log_pos 51870027 CRC32 0x720dfb01 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51870027
#201016 11:41:37 server id 1  end_log_pos 51870233 CRC32 0xff8a2def 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=220400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=216400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51870233
#201016 11:41:37 server id 1  end_log_pos 51870264 CRC32 0x6e3e4674 	Xid = 28396150
COMMIT/*!*/;
# at 51870264
#201016 11:41:37 server id 1  end_log_pos 51870329 CRC32 0x6f27e410 	GTID	last_committed=50739	sequence_number=50741	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409312'/*!*/;
# at 51870329
#201016 11:41:37 server id 1  end_log_pos 51870416 CRC32 0xeff18d18 	Query	thread_id=94775	exec_time=0	error_code=0
SET TIMESTAMP=1602819697/*!*/;
BEGIN
/*!*/;
# at 51870416
#201016 11:41:37 server id 1  end_log_pos 51870914 CRC32 0xee7e49ad 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819669-514',514,2000,0,'2020-10-16 11:41:09','2020-10-16 11:41:37',91576,0,0,'大众',220400,4000,4000,-4000,216400,0,117,11701,'','','大众')
# at 51870914
#201016 11:41:37 server id 1  end_log_pos 51871034 CRC32 0xc440c050 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51871034
#201016 11:41:37 server id 1  end_log_pos 51871212 CRC32 0xaadfbe5d 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002611 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819669-514' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=514 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819669.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819697.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='大众' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=220400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=216400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51871212
#201016 11:41:37 server id 1  end_log_pos 51871243 CRC32 0xfae068ec 	Xid = 28396182
COMMIT/*!*/;
# at 51871243
#201016 11:41:37 server id 1  end_log_pos 51871308 CRC32 0xba3cbc37 	GTID	last_committed=50740	sequence_number=50742	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409313'/*!*/;
# at 51871308
#201016 11:41:37 server id 1  end_log_pos 51871395 CRC32 0xf8efaeee 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819697/*!*/;
BEGIN
/*!*/;
# at 51871395
#201016 11:41:37 server id 1  end_log_pos 51871669 CRC32 0x610685dd 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819669-514-16',NULL,216400,6,0,0,'游戏消耗',10445,0)
# at 51871669
#201016 11:41:37 server id 1  end_log_pos 51871765 CRC32 0x0a1d594f 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51871765
#201016 11:41:37 server id 1  end_log_pos 51871903 CRC32 0x8111057b 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002611 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819669-514-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=216400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819697 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51871903
#201016 11:41:37 server id 1  end_log_pos 51871934 CRC32 0x452d93bb 	Xid = 28396209
COMMIT/*!*/;
# at 51871934
#201016 11:41:37 server id 1  end_log_pos 51871999 CRC32 0xa029906c 	GTID	last_committed=50741	sequence_number=50743	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409314'/*!*/;
# at 51871999
#201016 11:41:37 server id 1  end_log_pos 51872086 CRC32 0xb299f89a 	Query	thread_id=94775	exec_time=0	error_code=0
SET TIMESTAMP=1602819697/*!*/;
BEGIN
/*!*/;
# at 51872086
#201016 11:41:37 server id 1  end_log_pos 51872591 CRC32 0x44a975c0 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819669-514-16','test92022',0,'2020-10-16 11:41:09','2020-10-16 11:41:37',91576,220400,4000,4000,-4000,0,117,11701,'大众','gj')
# at 51872591
#201016 11:41:37 server id 1  end_log_pos 51872704 CRC32 0x476e384d 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51872704
#201016 11:41:37 server id 1  end_log_pos 51872872 CRC32 0xdc52ca35 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002611 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819669-514-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819669.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819697.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=220400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51872872
#201016 11:41:37 server id 1  end_log_pos 51872903 CRC32 0xb741c698 	Xid = 28396236
COMMIT/*!*/;
# at 51872903
#201016 11:41:41 server id 1  end_log_pos 51872968 CRC32 0x0fe3eb17 	GTID	last_committed=50743	sequence_number=50744	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409315'/*!*/;
# at 51872968
#201016 11:41:41 server id 1  end_log_pos 51873055 CRC32 0xb5c7602d 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819701/*!*/;
BEGIN
/*!*/;
# at 51873055
#201016 11:41:41 server id 1  end_log_pos 51873326 CRC32 0xb9ffc5ee 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819670-833-12',NULL,208000,5,0,0,'游戏获得',10445,0)
# at 51873326
#201016 11:41:41 server id 1  end_log_pos 51873422 CRC32 0x33a7ea8a 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51873422
#201016 11:41:41 server id 1  end_log_pos 51873560 CRC32 0xcacc145f 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002612 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819670-833-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=208000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819701 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51873560
#201016 11:41:41 server id 1  end_log_pos 51873591 CRC32 0x59d12f41 	Xid = 28396298
COMMIT/*!*/;
# at 51873591
#201016 11:41:41 server id 1  end_log_pos 51873656 CRC32 0xd9934fda 	GTID	last_committed=50743	sequence_number=50745	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409316'/*!*/;
# at 51873656
#201016 11:41:41 server id 1  end_log_pos 51873743 CRC32 0xc850b7a9 	Query	thread_id=94779	exec_time=0	error_code=0
SET TIMESTAMP=1602819701/*!*/;
BEGIN
/*!*/;
# at 51873743
#201016 11:41:41 server id 1  end_log_pos 51874263 CRC32 0xcf970d37 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819670-833',833,2000,0,'2020-10-16 11:41:10','2020-10-16 11:41:41',120041,0,0,'鸽子x8 (飞禽x2 )',208000,4000,0,0,208000,0,116,11601,'','','鸽子x8 (飞禽x2 )')
# at 51874263
#201016 11:41:41 server id 1  end_log_pos 51874383 CRC32 0x5fb41104 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51874383
#201016 11:41:41 server id 1  end_log_pos 51874589 CRC32 0xca08f8d6 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002612 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819670-833' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=833 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819670.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819701.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='鸽子x8 (飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='鸽子x8 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51874589
#201016 11:41:41 server id 1  end_log_pos 51874620 CRC32 0x6a6ad42a 	Xid = 28396323
COMMIT/*!*/;
# at 51874620
#201016 11:41:41 server id 1  end_log_pos 51874685 CRC32 0x9adc0d4f 	GTID	last_committed=50745	sequence_number=50746	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409317'/*!*/;
# at 51874685
#201016 11:41:41 server id 1  end_log_pos 51874772 CRC32 0xef05a22f 	Query	thread_id=94779	exec_time=0	error_code=0
SET TIMESTAMP=1602819701/*!*/;
BEGIN
/*!*/;
# at 51874772
#201016 11:41:41 server id 1  end_log_pos 51875285 CRC32 0x400db8fa 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819670-833-12','test92024',0,'2020-10-16 11:41:10','2020-10-16 11:41:41',120041,208000,4000,0,0,0,116,11601,'鸽子x8 (飞禽x2 )','gj')
# at 51875285
#201016 11:41:41 server id 1  end_log_pos 51875398 CRC32 0xd9a1d711 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51875398
#201016 11:41:41 server id 1  end_log_pos 51875580 CRC32 0x6b295792 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002612 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819670-833-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819670.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819701.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='鸽子x8 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51875580
#201016 11:41:41 server id 1  end_log_pos 51875611 CRC32 0x90b4cb62 	Xid = 28396353
COMMIT/*!*/;
# at 51875611
#201016 11:42:08 server id 1  end_log_pos 51875676 CRC32 0x1b56c3a2 	GTID	last_committed=50746	sequence_number=50747	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409318'/*!*/;
# at 51875676
#201016 11:42:08 server id 1  end_log_pos 51875755 CRC32 0x61a1170b 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819728/*!*/;
BEGIN
/*!*/;
# at 51875755
#201016 11:42:08 server id 1  end_log_pos 51875891 CRC32 0xea406961 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51875891
#201016 11:42:08 server id 1  end_log_pos 51875985 CRC32 0x426bcbd8 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51875985
#201016 11:42:08 server id 1  end_log_pos 51876191 CRC32 0xe2deaa29 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=216400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=212400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51876191
#201016 11:42:08 server id 1  end_log_pos 51876222 CRC32 0xf0d9011e 	Xid = 28396425
COMMIT/*!*/;
# at 51876222
#201016 11:42:08 server id 1  end_log_pos 51876287 CRC32 0xecdd2b2e 	GTID	last_committed=50746	sequence_number=50748	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409319'/*!*/;
# at 51876287
#201016 11:42:08 server id 1  end_log_pos 51876374 CRC32 0x4bd561e0 	Query	thread_id=94771	exec_time=0	error_code=0
SET TIMESTAMP=1602819728/*!*/;
BEGIN
/*!*/;
# at 51876374
#201016 11:42:08 server id 1  end_log_pos 51876884 CRC32 0x5d187ce1 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819700-515',515,2000,0,'2020-10-16 11:41:40','2020-10-16 11:42:08',91576,0,0,'雷克萨斯',216400,4000,4000,-4000,212400,0,117,11701,'','','雷克萨斯')
# at 51876884
#201016 11:42:08 server id 1  end_log_pos 51877004 CRC32 0x377c3488 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51877004
#201016 11:42:08 server id 1  end_log_pos 51877194 CRC32 0x7c57dc82 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002613 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819700-515' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=515 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819700.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819728.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='雷克萨斯' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=216400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=212400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='雷克萨斯' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51877194
#201016 11:42:08 server id 1  end_log_pos 51877225 CRC32 0x06c39fec 	Xid = 28396456
COMMIT/*!*/;
# at 51877225
#201016 11:42:08 server id 1  end_log_pos 51877290 CRC32 0xb45b6005 	GTID	last_committed=50747	sequence_number=50749	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409320'/*!*/;
# at 51877290
#201016 11:42:08 server id 1  end_log_pos 51877377 CRC32 0x713c6adc 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819728/*!*/;
BEGIN
/*!*/;
# at 51877377
#201016 11:42:08 server id 1  end_log_pos 51877651 CRC32 0x89c806ec 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819700-515-16',NULL,212400,6,0,0,'游戏消耗',10445,0)
# at 51877651
#201016 11:42:08 server id 1  end_log_pos 51877747 CRC32 0x6dd03425 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51877747
#201016 11:42:08 server id 1  end_log_pos 51877885 CRC32 0x0fd1b85b 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002613 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819700-515-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=212400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819728 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51877885
#201016 11:42:08 server id 1  end_log_pos 51877916 CRC32 0xa2a29e57 	Xid = 28396483
COMMIT/*!*/;
# at 51877916
#201016 11:42:08 server id 1  end_log_pos 51877981 CRC32 0x3bf6b88e 	GTID	last_committed=50748	sequence_number=50750	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409321'/*!*/;
# at 51877981
#201016 11:42:08 server id 1  end_log_pos 51878068 CRC32 0x0b6681bb 	Query	thread_id=94771	exec_time=0	error_code=0
SET TIMESTAMP=1602819728/*!*/;
BEGIN
/*!*/;
# at 51878068
#201016 11:42:08 server id 1  end_log_pos 51878579 CRC32 0xb9c168a7 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819700-515-16','test92022',0,'2020-10-16 11:41:40','2020-10-16 11:42:08',91576,216400,4000,4000,-4000,0,117,11701,'雷克萨斯','gj')
# at 51878579
#201016 11:42:08 server id 1  end_log_pos 51878692 CRC32 0x9c2ebd13 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51878692
#201016 11:42:08 server id 1  end_log_pos 51878866 CRC32 0x6be981bc 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002613 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819700-515-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819700.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819728.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=216400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='雷克萨斯' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51878866
#201016 11:42:08 server id 1  end_log_pos 51878897 CRC32 0x4082c6f3 	Xid = 28396510
COMMIT/*!*/;
# at 51878897
#201016 11:42:14 server id 1  end_log_pos 51878962 CRC32 0xddcacf4e 	GTID	last_committed=50750	sequence_number=50751	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409322'/*!*/;
# at 51878962
#201016 11:42:14 server id 1  end_log_pos 51879049 CRC32 0x65769c4f 	Query	thread_id=94780	exec_time=0	error_code=0
SET TIMESTAMP=1602819734/*!*/;
BEGIN
/*!*/;
# at 51879049
#201016 11:42:14 server id 1  end_log_pos 51879569 CRC32 0x068f2586 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819703-834',834,2000,0,'2020-10-16 11:41:43','2020-10-16 11:42:14',120041,0,0,'孔雀x9 (飞禽x2 )',208000,4000,0,0,208000,0,116,11601,'','','孔雀x9 (飞禽x2 )')
# at 51879569
#201016 11:42:14 server id 1  end_log_pos 51879689 CRC32 0x180d1d20 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51879689
#201016 11:42:14 server id 1  end_log_pos 51879895 CRC32 0xd864888d 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002614 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819703-834' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=834 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819703.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819734.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='孔雀x9 (飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='孔雀x9 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51879895
#201016 11:42:14 server id 1  end_log_pos 51879926 CRC32 0xba43630a 	Xid = 28396577
COMMIT/*!*/;
# at 51879926
#201016 11:42:14 server id 1  end_log_pos 51879991 CRC32 0x26960490 	GTID	last_committed=50750	sequence_number=50752	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409323'/*!*/;
# at 51879991
#201016 11:42:14 server id 1  end_log_pos 51880078 CRC32 0x5568a814 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819734/*!*/;
BEGIN
/*!*/;
# at 51880078
#201016 11:42:14 server id 1  end_log_pos 51880349 CRC32 0xebdab337 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819703-834-12',NULL,208000,5,0,0,'游戏获得',10445,0)
# at 51880349
#201016 11:42:14 server id 1  end_log_pos 51880445 CRC32 0x1babf12a 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51880445
#201016 11:42:14 server id 1  end_log_pos 51880583 CRC32 0x8d5314c2 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002614 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819703-834-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=208000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819734 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51880583
#201016 11:42:14 server id 1  end_log_pos 51880614 CRC32 0x043d376a 	Xid = 28396590
COMMIT/*!*/;
# at 51880614
#201016 11:42:14 server id 1  end_log_pos 51880679 CRC32 0x808cbb64 	GTID	last_committed=50751	sequence_number=50753	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409324'/*!*/;
# at 51880679
#201016 11:42:14 server id 1  end_log_pos 51880766 CRC32 0x24cabc35 	Query	thread_id=94780	exec_time=0	error_code=0
SET TIMESTAMP=1602819734/*!*/;
BEGIN
/*!*/;
# at 51880766
#201016 11:42:14 server id 1  end_log_pos 51881279 CRC32 0x4309099f 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819703-834-12','test92024',0,'2020-10-16 11:41:43','2020-10-16 11:42:14',120041,208000,4000,0,0,0,116,11601,'孔雀x9 (飞禽x2 )','gj')
# at 51881279
#201016 11:42:14 server id 1  end_log_pos 51881392 CRC32 0xab7e43a7 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51881392
#201016 11:42:14 server id 1  end_log_pos 51881574 CRC32 0xd19df775 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002614 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819703-834-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819703.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819734.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='孔雀x9 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51881574
#201016 11:42:14 server id 1  end_log_pos 51881605 CRC32 0xafafa95d 	Xid = 28396617
COMMIT/*!*/;
# at 51881605
#201016 11:42:37 server id 1  end_log_pos 51881670 CRC32 0x1a2ec7d0 	GTID	last_committed=50753	sequence_number=50754	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409325'/*!*/;
# at 51881670
#201016 11:42:37 server id 1  end_log_pos 51881757 CRC32 0x6b81f5d5 	Query	thread_id=94630	exec_time=0	error_code=0
SET TIMESTAMP=1602819757/*!*/;
BEGIN
/*!*/;
# at 51881757
#201016 11:42:37 server id 1  end_log_pos 51881858 CRC32 0x1b59a824 	Rows_query
# insert into Table_Web_TotalInLine_min(szTime, `online`) values(NOW(), $total)
# at 51881858
#201016 11:42:37 server id 1  end_log_pos 51881936 CRC32 0xf2964793 	Table_map: `niuniuh5_db`.`table_web_totalinline_min` mapped to number 109
# at 51881936
#201016 11:42:37 server id 1  end_log_pos 51881988 CRC32 0x9b926624 	Write_rows: table id 109 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_web_totalinline_min`
### SET
###   @1=519792 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1602819757 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @3=2 /* INT meta=0 nullable=0 is_null=0 */
# at 51881988
#201016 11:42:37 server id 1  end_log_pos 51882019 CRC32 0xe7ca1503 	Xid = 28396691
COMMIT/*!*/;
# at 51882019
#201016 11:42:39 server id 1  end_log_pos 51882084 CRC32 0x19e8688a 	GTID	last_committed=50754	sequence_number=50755	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409326'/*!*/;
# at 51882084
#201016 11:42:39 server id 1  end_log_pos 51882163 CRC32 0xfb7cfec0 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819759/*!*/;
BEGIN
/*!*/;
# at 51882163
#201016 11:42:39 server id 1  end_log_pos 51882299 CRC32 0xf8aeafc2 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51882299
#201016 11:42:39 server id 1  end_log_pos 51882393 CRC32 0xca99a0b8 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51882393
#201016 11:42:39 server id 1  end_log_pos 51882599 CRC32 0x8b374044 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=212400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=218400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51882599
#201016 11:42:39 server id 1  end_log_pos 51882630 CRC32 0xd8da61f9 	Xid = 28396694
COMMIT/*!*/;
# at 51882630
#201016 11:42:39 server id 1  end_log_pos 51882695 CRC32 0x8e13c7b4 	GTID	last_committed=50755	sequence_number=50756	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409327'/*!*/;
# at 51882695
#201016 11:42:39 server id 1  end_log_pos 51882782 CRC32 0xf245b63f 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819759/*!*/;
BEGIN
/*!*/;
# at 51882782
#201016 11:42:39 server id 1  end_log_pos 51883055 CRC32 0x0279dc29 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,6000,'10445-611825-1602819731-516-16',NULL,218400,5,0,0,'游戏获得',10445,0)
# at 51883055
#201016 11:42:39 server id 1  end_log_pos 51883151 CRC32 0x71e0b33f 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51883151
#201016 11:42:39 server id 1  end_log_pos 51883289 CRC32 0x1edb785a 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002615 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=6000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819731-516-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=218400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819759 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51883289
#201016 11:42:39 server id 1  end_log_pos 51883320 CRC32 0xb524f238 	Xid = 28396721
COMMIT/*!*/;
# at 51883320
#201016 11:42:39 server id 1  end_log_pos 51883385 CRC32 0x14490e69 	GTID	last_committed=50756	sequence_number=50757	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409328'/*!*/;
# at 51883385
#201016 11:42:39 server id 1  end_log_pos 51883472 CRC32 0x948d0a75 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819759/*!*/;
BEGIN
/*!*/;
# at 51883472
#201016 11:42:39 server id 1  end_log_pos 51883969 CRC32 0xef710291 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819731-516',516,2000,0,'2020-10-16 11:42:11','2020-10-16 11:42:39',91576,0,0,'奔驰',212400,4000,4000,6000,218400,0,117,11701,'','','奔驰')
# at 51883969
#201016 11:42:39 server id 1  end_log_pos 51884089 CRC32 0xc2d10e28 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51884089
#201016 11:42:39 server id 1  end_log_pos 51884267 CRC32 0xb4f69067 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002615 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819731-516' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=516 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819731.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819759.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='奔驰' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=212400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=6000 /* INT meta=0 nullable=1 is_null=0 */
###   @18=218400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='奔驰' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51884267
#201016 11:42:39 server id 1  end_log_pos 51884298 CRC32 0x492ac3df 	Xid = 28396756
COMMIT/*!*/;
# at 51884298
#201016 11:42:39 server id 1  end_log_pos 51884363 CRC32 0xfed94701 	GTID	last_committed=50757	sequence_number=50758	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409329'/*!*/;
# at 51884363
#201016 11:42:39 server id 1  end_log_pos 51884450 CRC32 0xb37864f9 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819759/*!*/;
BEGIN
/*!*/;
# at 51884450
#201016 11:42:39 server id 1  end_log_pos 51884954 CRC32 0xcf7ff4c4 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819731-516-16','test92022',0,'2020-10-16 11:42:11','2020-10-16 11:42:39',91576,212400,4000,4000,6000,0,117,11701,'奔驰','gj')
# at 51884954
#201016 11:42:39 server id 1  end_log_pos 51885067 CRC32 0x070a1542 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51885067
#201016 11:42:39 server id 1  end_log_pos 51885235 CRC32 0xa3d5bb7f 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002615 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819731-516-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819731.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819759.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=212400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=6000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='奔驰' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51885235
#201016 11:42:39 server id 1  end_log_pos 51885266 CRC32 0x1b8305ae 	Xid = 28396783
COMMIT/*!*/;
# at 51885266
#201016 11:42:47 server id 1  end_log_pos 51885331 CRC32 0x8edb63cf 	GTID	last_committed=50758	sequence_number=50759	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409330'/*!*/;
# at 51885331
#201016 11:42:47 server id 1  end_log_pos 51885410 CRC32 0xd510f675 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819767/*!*/;
BEGIN
/*!*/;
# at 51885410
#201016 11:42:47 server id 1  end_log_pos 51885546 CRC32 0xf4b30e8c 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51885546
#201016 11:42:47 server id 1  end_log_pos 51885640 CRC32 0x899d1fde 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51885640
#201016 11:42:47 server id 1  end_log_pos 51885846 CRC32 0x5f6a1539 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=13079 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92024' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1602570911 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=208000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=13079 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92024' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1602570911 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51885846
#201016 11:42:47 server id 1  end_log_pos 51885877 CRC32 0x375ef71c 	Xid = 28396813
COMMIT/*!*/;
# at 51885877
#201016 11:42:47 server id 1  end_log_pos 51885942 CRC32 0x5c8f29c6 	GTID	last_committed=50758	sequence_number=50760	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409331'/*!*/;
# at 51885942
#201016 11:42:47 server id 1  end_log_pos 51886029 CRC32 0xb6875fe0 	Query	thread_id=94776	exec_time=0	error_code=0
SET TIMESTAMP=1602819767/*!*/;
BEGIN
/*!*/;
# at 51886029
#201016 11:42:47 server id 1  end_log_pos 51886531 CRC32 0x542094ba 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819736-835',835,2000,0,'2020-10-16 11:42:16','2020-10-16 11:42:47',120041,0,0,'银鲨x25',208000,4000,0,-4000,204000,0,116,11601,'','','银鲨x25')
# at 51886531
#201016 11:42:47 server id 1  end_log_pos 51886651 CRC32 0xc793170a 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51886651
#201016 11:42:47 server id 1  end_log_pos 51886835 CRC32 0x791e8ca2 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002616 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819736-835' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=835 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819736.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819767.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='银鲨x25' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='银鲨x25' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51886835
#201016 11:42:47 server id 1  end_log_pos 51886866 CRC32 0x3091fe37 	Xid = 28396844
COMMIT/*!*/;
# at 51886866
#201016 11:42:47 server id 1  end_log_pos 51886931 CRC32 0x632de536 	GTID	last_committed=50759	sequence_number=50761	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409332'/*!*/;
# at 51886931
#201016 11:42:47 server id 1  end_log_pos 51887018 CRC32 0x52c1af42 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819767/*!*/;
BEGIN
/*!*/;
# at 51887018
#201016 11:42:47 server id 1  end_log_pos 51887293 CRC32 0xdd9cccca 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,-4000,'10445-599775-1602819736-835-12',NULL,204000,6,0,0,'游戏消耗',10445,0)
# at 51887293
#201016 11:42:47 server id 1  end_log_pos 51887389 CRC32 0x6ca359dc 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51887389
#201016 11:42:47 server id 1  end_log_pos 51887527 CRC32 0xc286027f 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002616 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819736-835-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819767 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51887527
#201016 11:42:47 server id 1  end_log_pos 51887558 CRC32 0xa0213663 	Xid = 28396871
COMMIT/*!*/;
# at 51887558
#201016 11:42:47 server id 1  end_log_pos 51887623 CRC32 0x2696442a 	GTID	last_committed=50760	sequence_number=50762	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409333'/*!*/;
# at 51887623
#201016 11:42:47 server id 1  end_log_pos 51887710 CRC32 0x6a00bccd 	Query	thread_id=94776	exec_time=0	error_code=0
SET TIMESTAMP=1602819767/*!*/;
BEGIN
/*!*/;
# at 51887710
#201016 11:42:47 server id 1  end_log_pos 51888216 CRC32 0x315ed94a 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819736-835-12','test92024',0,'2020-10-16 11:42:16','2020-10-16 11:42:47',120041,208000,4000,0,-4000,0,116,11601,'银鲨x25','gj')
# at 51888216
#201016 11:42:47 server id 1  end_log_pos 51888329 CRC32 0x28d4210d 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51888329
#201016 11:42:47 server id 1  end_log_pos 51888500 CRC32 0xc057e88e 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002616 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819736-835-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819736.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819767.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=208000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='银鲨x25' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51888500
#201016 11:42:47 server id 1  end_log_pos 51888531 CRC32 0x92513ade 	Xid = 28396898
COMMIT/*!*/;
# at 51888531
#201016 11:43:10 server id 1  end_log_pos 51888596 CRC32 0x9dc048c9 	GTID	last_committed=50762	sequence_number=50763	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409334'/*!*/;
# at 51888596
#201016 11:43:10 server id 1  end_log_pos 51888675 CRC32 0x2e63d006 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819790/*!*/;
BEGIN
/*!*/;
# at 51888675
#201016 11:43:10 server id 1  end_log_pos 51888811 CRC32 0x8dda6cd1 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51888811
#201016 11:43:10 server id 1  end_log_pos 51888905 CRC32 0x3d88e3c7 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51888905
#201016 11:43:10 server id 1  end_log_pos 51889111 CRC32 0x69e026f5 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=218400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=214400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51889111
#201016 11:43:10 server id 1  end_log_pos 51889142 CRC32 0xf7e0a716 	Xid = 28396975
COMMIT/*!*/;
# at 51889142
#201016 11:43:10 server id 1  end_log_pos 51889207 CRC32 0x0dcf4355 	GTID	last_committed=50762	sequence_number=50764	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409335'/*!*/;
# at 51889207
#201016 11:43:10 server id 1  end_log_pos 51889294 CRC32 0xda5c56b2 	Query	thread_id=94773	exec_time=0	error_code=0
SET TIMESTAMP=1602819790/*!*/;
BEGIN
/*!*/;
# at 51889294
#201016 11:43:10 server id 1  end_log_pos 51889804 CRC32 0x68045325 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819762-517',517,2000,0,'2020-10-16 11:42:42','2020-10-16 11:43:10',91576,0,0,'雷克萨斯',218400,4000,4000,-4000,214400,0,117,11701,'','','雷克萨斯')
# at 51889804
#201016 11:43:10 server id 1  end_log_pos 51889924 CRC32 0xbcaca850 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51889924
#201016 11:43:10 server id 1  end_log_pos 51890114 CRC32 0xc8caa9b6 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002617 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819762-517' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=517 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819762.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819790.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='雷克萨斯' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=218400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=214400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='雷克萨斯' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51890114
#201016 11:43:10 server id 1  end_log_pos 51890145 CRC32 0xa6e8fcea 	Xid = 28397005
COMMIT/*!*/;
# at 51890145
#201016 11:43:10 server id 1  end_log_pos 51890210 CRC32 0xa8635fd4 	GTID	last_committed=50763	sequence_number=50765	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409336'/*!*/;
# at 51890210
#201016 11:43:10 server id 1  end_log_pos 51890297 CRC32 0xc2ac8d59 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819790/*!*/;
BEGIN
/*!*/;
# at 51890297
#201016 11:43:10 server id 1  end_log_pos 51890571 CRC32 0x4311ef16 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819762-517-16',NULL,214400,6,0,0,'游戏消耗',10445,0)
# at 51890571
#201016 11:43:10 server id 1  end_log_pos 51890667 CRC32 0xa82e07bd 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51890667
#201016 11:43:10 server id 1  end_log_pos 51890805 CRC32 0x51eb978e 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002617 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819762-517-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=214400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819790 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51890805
#201016 11:43:10 server id 1  end_log_pos 51890836 CRC32 0x3e9e2d8e 	Xid = 28397032
COMMIT/*!*/;
# at 51890836
#201016 11:43:10 server id 1  end_log_pos 51890901 CRC32 0x1ffae68f 	GTID	last_committed=50764	sequence_number=50766	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409337'/*!*/;
# at 51890901
#201016 11:43:10 server id 1  end_log_pos 51890988 CRC32 0xad1d37e7 	Query	thread_id=94773	exec_time=0	error_code=0
SET TIMESTAMP=1602819790/*!*/;
BEGIN
/*!*/;
# at 51890988
#201016 11:43:10 server id 1  end_log_pos 51891499 CRC32 0x140caa63 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819762-517-16','test92022',0,'2020-10-16 11:42:42','2020-10-16 11:43:10',91576,218400,4000,4000,-4000,0,117,11701,'雷克萨斯','gj')
# at 51891499
#201016 11:43:10 server id 1  end_log_pos 51891612 CRC32 0x8874d7e2 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51891612
#201016 11:43:10 server id 1  end_log_pos 51891786 CRC32 0xbc795dfa 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002617 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819762-517-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819762.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819790.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=218400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='雷克萨斯' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51891786
#201016 11:43:10 server id 1  end_log_pos 51891817 CRC32 0xcf93484e 	Xid = 28397059
COMMIT/*!*/;
# at 51891817
#201016 11:43:20 server id 1  end_log_pos 51891882 CRC32 0x252a9af9 	GTID	last_committed=50766	sequence_number=50767	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409338'/*!*/;
# at 51891882
#201016 11:43:20 server id 1  end_log_pos 51891969 CRC32 0x78ea807a 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819800/*!*/;
BEGIN
/*!*/;
# at 51891969
#201016 11:43:20 server id 1  end_log_pos 51892240 CRC32 0x49e04544 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819769-836-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51892240
#201016 11:43:20 server id 1  end_log_pos 51892336 CRC32 0xac9d5146 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51892336
#201016 11:43:20 server id 1  end_log_pos 51892474 CRC32 0xef278639 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002618 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819769-836-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819800 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51892474
#201016 11:43:20 server id 1  end_log_pos 51892505 CRC32 0x4a6e38da 	Xid = 28397118
COMMIT/*!*/;
# at 51892505
#201016 11:43:20 server id 1  end_log_pos 51892570 CRC32 0x91c03639 	GTID	last_committed=50767	sequence_number=50768	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409339'/*!*/;
# at 51892570
#201016 11:43:20 server id 1  end_log_pos 51892657 CRC32 0xc36b81b8 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819800/*!*/;
BEGIN
/*!*/;
# at 51892657
#201016 11:43:20 server id 1  end_log_pos 51893177 CRC32 0x5efaf278 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819769-836',836,2000,0,'2020-10-16 11:42:49','2020-10-16 11:43:20',120041,0,0,'燕子x6 (飞禽x2 )',204000,4000,0,0,204000,0,116,11601,'','','燕子x6 (飞禽x2 )')
# at 51893177
#201016 11:43:20 server id 1  end_log_pos 51893297 CRC32 0x7360985f 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51893297
#201016 11:43:20 server id 1  end_log_pos 51893503 CRC32 0x35072de8 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002618 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819769-836' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=836 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819769.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819800.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='燕子x6 (飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='燕子x6 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51893503
#201016 11:43:20 server id 1  end_log_pos 51893534 CRC32 0x631c19e6 	Xid = 28397153
COMMIT/*!*/;
# at 51893534
#201016 11:43:20 server id 1  end_log_pos 51893599 CRC32 0x4e14e7d2 	GTID	last_committed=50768	sequence_number=50769	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409340'/*!*/;
# at 51893599
#201016 11:43:20 server id 1  end_log_pos 51893686 CRC32 0x74dfd39a 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819800/*!*/;
BEGIN
/*!*/;
# at 51893686
#201016 11:43:20 server id 1  end_log_pos 51894199 CRC32 0x94881011 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819769-836-12','test92024',0,'2020-10-16 11:42:49','2020-10-16 11:43:20',120041,204000,4000,0,0,0,116,11601,'燕子x6 (飞禽x2 )','gj')
# at 51894199
#201016 11:43:20 server id 1  end_log_pos 51894312 CRC32 0xea83cb35 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51894312
#201016 11:43:20 server id 1  end_log_pos 51894494 CRC32 0x309b5378 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002618 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819769-836-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819769.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819800.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='燕子x6 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51894494
#201016 11:43:20 server id 1  end_log_pos 51894525 CRC32 0xb0411872 	Xid = 28397180
COMMIT/*!*/;
# at 51894525
#201016 11:43:41 server id 1  end_log_pos 51894590 CRC32 0x9bc4d61f 	GTID	last_committed=50769	sequence_number=50770	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409341'/*!*/;
# at 51894590
#201016 11:43:41 server id 1  end_log_pos 51894669 CRC32 0x01ba48d9 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819821/*!*/;
BEGIN
/*!*/;
# at 51894669
#201016 11:43:41 server id 1  end_log_pos 51894805 CRC32 0xeed1a323 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51894805
#201016 11:43:41 server id 1  end_log_pos 51894899 CRC32 0x6c1a0f20 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51894899
#201016 11:43:41 server id 1  end_log_pos 51895105 CRC32 0x4efdc03e 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=214400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=210400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51895105
#201016 11:43:41 server id 1  end_log_pos 51895136 CRC32 0xd709068e 	Xid = 28397237
COMMIT/*!*/;
# at 51895136
#201016 11:43:41 server id 1  end_log_pos 51895201 CRC32 0x8262577d 	GTID	last_committed=50769	sequence_number=50771	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409342'/*!*/;
# at 51895201
#201016 11:43:41 server id 1  end_log_pos 51895288 CRC32 0x686acf2a 	Query	thread_id=94774	exec_time=0	error_code=0
SET TIMESTAMP=1602819821/*!*/;
BEGIN
/*!*/;
# at 51895288
#201016 11:43:41 server id 1  end_log_pos 51895798 CRC32 0x2bbb785b 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819793-518',518,2000,0,'2020-10-16 11:43:13','2020-10-16 11:43:41',91576,0,0,'雷克萨斯',214400,4000,4000,-4000,210400,0,117,11701,'','','雷克萨斯')
# at 51895798
#201016 11:43:41 server id 1  end_log_pos 51895918 CRC32 0xf5a59e79 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51895918
#201016 11:43:41 server id 1  end_log_pos 51896108 CRC32 0x84d621d7 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002619 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819793-518' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=518 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819793.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819821.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='雷克萨斯' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=214400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=210400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='雷克萨斯' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51896108
#201016 11:43:41 server id 1  end_log_pos 51896139 CRC32 0x89ad8f08 	Xid = 28397268
COMMIT/*!*/;
# at 51896139
#201016 11:43:41 server id 1  end_log_pos 51896204 CRC32 0x5c00ecc4 	GTID	last_committed=50770	sequence_number=50772	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409343'/*!*/;
# at 51896204
#201016 11:43:41 server id 1  end_log_pos 51896291 CRC32 0x94ba7b62 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819821/*!*/;
BEGIN
/*!*/;
# at 51896291
#201016 11:43:41 server id 1  end_log_pos 51896565 CRC32 0x1ff79d86 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819793-518-16',NULL,210400,6,0,0,'游戏消耗',10445,0)
# at 51896565
#201016 11:43:41 server id 1  end_log_pos 51896661 CRC32 0x776e2036 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51896661
#201016 11:43:41 server id 1  end_log_pos 51896799 CRC32 0x77424a6e 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002619 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819793-518-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=210400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819821 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51896799
#201016 11:43:41 server id 1  end_log_pos 51896830 CRC32 0x0093e487 	Xid = 28397295
COMMIT/*!*/;
# at 51896830
#201016 11:43:41 server id 1  end_log_pos 51896895 CRC32 0x82dc2d39 	GTID	last_committed=50771	sequence_number=50773	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409344'/*!*/;
# at 51896895
#201016 11:43:41 server id 1  end_log_pos 51896982 CRC32 0x8c69693d 	Query	thread_id=94774	exec_time=0	error_code=0
SET TIMESTAMP=1602819821/*!*/;
BEGIN
/*!*/;
# at 51896982
#201016 11:43:41 server id 1  end_log_pos 51897493 CRC32 0x8d3e3f1c 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819793-518-16','test92022',0,'2020-10-16 11:43:13','2020-10-16 11:43:41',91576,214400,4000,4000,-4000,0,117,11701,'雷克萨斯','gj')
# at 51897493
#201016 11:43:41 server id 1  end_log_pos 51897606 CRC32 0x7e2f9873 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51897606
#201016 11:43:41 server id 1  end_log_pos 51897780 CRC32 0x96c58cd2 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002619 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819793-518-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819793.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819821.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=214400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='雷克萨斯' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51897780
#201016 11:43:41 server id 1  end_log_pos 51897811 CRC32 0xd7f3a623 	Xid = 28397322
COMMIT/*!*/;
# at 51897811
#201016 11:43:53 server id 1  end_log_pos 51897876 CRC32 0xb25dd7ed 	GTID	last_committed=50773	sequence_number=50774	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409345'/*!*/;
# at 51897876
#201016 11:43:53 server id 1  end_log_pos 51897963 CRC32 0xd6b873f4 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819833/*!*/;
BEGIN
/*!*/;
# at 51897963
#201016 11:43:53 server id 1  end_log_pos 51898234 CRC32 0xcec4aa2f 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819802-837-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51898234
#201016 11:43:53 server id 1  end_log_pos 51898330 CRC32 0x04221d31 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51898330
#201016 11:43:53 server id 1  end_log_pos 51898468 CRC32 0x271ab8d0 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002620 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819802-837-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819833 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51898468
#201016 11:43:53 server id 1  end_log_pos 51898499 CRC32 0x0fa57824 	Xid = 28397414
COMMIT/*!*/;
# at 51898499
#201016 11:43:53 server id 1  end_log_pos 51898564 CRC32 0xc22dcf0c 	GTID	last_committed=50773	sequence_number=50775	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409346'/*!*/;
# at 51898564
#201016 11:43:53 server id 1  end_log_pos 51898651 CRC32 0x90ec66df 	Query	thread_id=94778	exec_time=0	error_code=0
SET TIMESTAMP=1602819833/*!*/;
BEGIN
/*!*/;
# at 51898651
#201016 11:43:53 server id 1  end_log_pos 51899171 CRC32 0x863c655e 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819802-837',837,2000,0,'2020-10-16 11:43:22','2020-10-16 11:43:53',120041,0,0,'兔子x6 (走兽x2 )',204000,4000,0,0,204000,0,116,11601,'','','兔子x6 (走兽x2 )')
# at 51899171
#201016 11:43:53 server id 1  end_log_pos 51899291 CRC32 0x65b03ef0 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51899291
#201016 11:43:53 server id 1  end_log_pos 51899497 CRC32 0x86516f8f 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002620 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819802-837' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=837 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819802.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819833.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='兔子x6 (走兽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51899497
#201016 11:43:53 server id 1  end_log_pos 51899528 CRC32 0x8b667dc1 	Xid = 28397397
COMMIT/*!*/;
# at 51899528
#201016 11:43:53 server id 1  end_log_pos 51899593 CRC32 0xba3b7c15 	GTID	last_committed=50775	sequence_number=50776	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409347'/*!*/;
# at 51899593
#201016 11:43:53 server id 1  end_log_pos 51899680 CRC32 0x5e3fa353 	Query	thread_id=94778	exec_time=0	error_code=0
SET TIMESTAMP=1602819833/*!*/;
BEGIN
/*!*/;
# at 51899680
#201016 11:43:53 server id 1  end_log_pos 51900193 CRC32 0x5500733a 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819802-837-12','test92024',0,'2020-10-16 11:43:22','2020-10-16 11:43:53',120041,204000,4000,0,0,0,116,11601,'兔子x6 (走兽x2 )','gj')
# at 51900193
#201016 11:43:53 server id 1  end_log_pos 51900306 CRC32 0x111da56e 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51900306
#201016 11:43:53 server id 1  end_log_pos 51900488 CRC32 0xcc962b8d 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002620 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819802-837-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819802.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819833.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51900488
#201016 11:43:53 server id 1  end_log_pos 51900519 CRC32 0x3656c05f 	Xid = 28397444
COMMIT/*!*/;
# at 51900519
#201016 11:44:12 server id 1  end_log_pos 51900584 CRC32 0xac609246 	GTID	last_committed=50776	sequence_number=50777	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409348'/*!*/;
# at 51900584
#201016 11:44:12 server id 1  end_log_pos 51900663 CRC32 0x7d462be2 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819852/*!*/;
BEGIN
/*!*/;
# at 51900663
#201016 11:44:12 server id 1  end_log_pos 51900799 CRC32 0x94b983ee 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51900799
#201016 11:44:12 server id 1  end_log_pos 51900893 CRC32 0x78dd24ac 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51900893
#201016 11:44:12 server id 1  end_log_pos 51901099 CRC32 0xc521e1db 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=210400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=206400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51901099
#201016 11:44:12 server id 1  end_log_pos 51901130 CRC32 0x0a76b826 	Xid = 28397522
COMMIT/*!*/;
# at 51901130
#201016 11:44:12 server id 1  end_log_pos 51901195 CRC32 0x78c0a976 	GTID	last_committed=50776	sequence_number=50778	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409349'/*!*/;
# at 51901195
#201016 11:44:12 server id 1  end_log_pos 51901282 CRC32 0xa60a9eb2 	Query	thread_id=94775	exec_time=0	error_code=0
SET TIMESTAMP=1602819852/*!*/;
BEGIN
/*!*/;
# at 51901282
#201016 11:44:12 server id 1  end_log_pos 51901780 CRC32 0xec0e5232 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819824-519',519,2000,0,'2020-10-16 11:43:44','2020-10-16 11:44:12',91576,0,0,'大众',210400,4000,4000,-4000,206400,0,117,11701,'','','大众')
# at 51901780
#201016 11:44:12 server id 1  end_log_pos 51901900 CRC32 0x4ff76027 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51901900
#201016 11:44:12 server id 1  end_log_pos 51902078 CRC32 0xeeabddda 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002621 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819824-519' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=519 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819824.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819852.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='大众' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=210400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=206400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51902078
#201016 11:44:12 server id 1  end_log_pos 51902109 CRC32 0xfff0d658 	Xid = 28397553
COMMIT/*!*/;
# at 51902109
#201016 11:44:12 server id 1  end_log_pos 51902174 CRC32 0x2b0f35af 	GTID	last_committed=50777	sequence_number=50779	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409350'/*!*/;
# at 51902174
#201016 11:44:12 server id 1  end_log_pos 51902261 CRC32 0xf8e57606 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819852/*!*/;
BEGIN
/*!*/;
# at 51902261
#201016 11:44:12 server id 1  end_log_pos 51902535 CRC32 0xe760e6bc 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819824-519-16',NULL,206400,6,0,0,'游戏消耗',10445,0)
# at 51902535
#201016 11:44:12 server id 1  end_log_pos 51902631 CRC32 0x33334356 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51902631
#201016 11:44:12 server id 1  end_log_pos 51902769 CRC32 0xd3fa7a3e 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002621 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819824-519-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=206400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819852 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51902769
#201016 11:44:12 server id 1  end_log_pos 51902800 CRC32 0x58488699 	Xid = 28397580
COMMIT/*!*/;
# at 51902800
#201016 11:44:12 server id 1  end_log_pos 51902865 CRC32 0x7fd49c66 	GTID	last_committed=50778	sequence_number=50780	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409351'/*!*/;
# at 51902865
#201016 11:44:12 server id 1  end_log_pos 51902952 CRC32 0xb7039bdd 	Query	thread_id=94775	exec_time=0	error_code=0
SET TIMESTAMP=1602819852/*!*/;
BEGIN
/*!*/;
# at 51902952
#201016 11:44:12 server id 1  end_log_pos 51903457 CRC32 0xb5b05338 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819824-519-16','test92022',0,'2020-10-16 11:43:44','2020-10-16 11:44:12',91576,210400,4000,4000,-4000,0,117,11701,'大众','gj')
# at 51903457
#201016 11:44:12 server id 1  end_log_pos 51903570 CRC32 0x4a00fd50 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51903570
#201016 11:44:12 server id 1  end_log_pos 51903738 CRC32 0xf419f285 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002621 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819824-519-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819824.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819852.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=210400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51903738
#201016 11:44:12 server id 1  end_log_pos 51903769 CRC32 0xd3029abe 	Xid = 28397607
COMMIT/*!*/;
# at 51903769
#201016 11:44:26 server id 1  end_log_pos 51903834 CRC32 0xdf4583ff 	GTID	last_committed=50780	sequence_number=50781	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409352'/*!*/;
# at 51903834
#201016 11:44:26 server id 1  end_log_pos 51903921 CRC32 0x88702d6a 	Query	thread_id=94779	exec_time=0	error_code=0
SET TIMESTAMP=1602819866/*!*/;
BEGIN
/*!*/;
# at 51903921
#201016 11:44:26 server id 1  end_log_pos 51904441 CRC32 0xd8f0fc00 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819835-838',838,2000,0,'2020-10-16 11:43:55','2020-10-16 11:44:26',120041,0,0,'兔子x6 (走兽x2 )',204000,4000,0,0,204000,0,116,11601,'','','兔子x6 (走兽x2 )')
# at 51904441
#201016 11:44:26 server id 1  end_log_pos 51904561 CRC32 0x3be84ee7 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51904561
#201016 11:44:26 server id 1  end_log_pos 51904767 CRC32 0x69a8c3cb 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002622 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819835-838' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=838 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819835.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819866.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='兔子x6 (走兽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51904767
#201016 11:44:26 server id 1  end_log_pos 51904798 CRC32 0x971a4ba8 	Xid = 28397706
COMMIT/*!*/;
# at 51904798
#201016 11:44:26 server id 1  end_log_pos 51904863 CRC32 0x658f32e1 	GTID	last_committed=50780	sequence_number=50782	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409353'/*!*/;
# at 51904863
#201016 11:44:26 server id 1  end_log_pos 51904950 CRC32 0x1aa1ff5c 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819866/*!*/;
BEGIN
/*!*/;
# at 51904950
#201016 11:44:26 server id 1  end_log_pos 51905221 CRC32 0xdc1efe01 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819835-838-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51905221
#201016 11:44:26 server id 1  end_log_pos 51905317 CRC32 0x48a2b922 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51905317
#201016 11:44:26 server id 1  end_log_pos 51905455 CRC32 0xfa6baa76 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002622 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819835-838-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819866 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51905455
#201016 11:44:26 server id 1  end_log_pos 51905486 CRC32 0x2f85ebb7 	Xid = 28397722
COMMIT/*!*/;
# at 51905486
#201016 11:44:26 server id 1  end_log_pos 51905551 CRC32 0x2432f706 	GTID	last_committed=50781	sequence_number=50783	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409354'/*!*/;
# at 51905551
#201016 11:44:26 server id 1  end_log_pos 51905638 CRC32 0x21bf576f 	Query	thread_id=94779	exec_time=0	error_code=0
SET TIMESTAMP=1602819866/*!*/;
BEGIN
/*!*/;
# at 51905638
#201016 11:44:26 server id 1  end_log_pos 51906151 CRC32 0xc12f87c3 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819835-838-12','test92024',0,'2020-10-16 11:43:55','2020-10-16 11:44:26',120041,204000,4000,0,0,0,116,11601,'兔子x6 (走兽x2 )','gj')
# at 51906151
#201016 11:44:26 server id 1  end_log_pos 51906264 CRC32 0x143ebc60 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51906264
#201016 11:44:26 server id 1  end_log_pos 51906446 CRC32 0xa89d92ce 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002622 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819835-838-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819835.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819866.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51906446
#201016 11:44:26 server id 1  end_log_pos 51906477 CRC32 0x3fd65b29 	Xid = 28397749
COMMIT/*!*/;
# at 51906477
#201016 11:44:37 server id 1  end_log_pos 51906542 CRC32 0x486aac4d 	GTID	last_committed=50783	sequence_number=50784	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409355'/*!*/;
# at 51906542
#201016 11:44:37 server id 1  end_log_pos 51906629 CRC32 0x8134b802 	Query	thread_id=94634	exec_time=0	error_code=0
SET TIMESTAMP=1602819877/*!*/;
BEGIN
/*!*/;
# at 51906629
#201016 11:44:37 server id 1  end_log_pos 51906730 CRC32 0x1ec9afa4 	Rows_query
# insert into Table_Web_TotalInLine_min(szTime, `online`) values(NOW(), $total)
# at 51906730
#201016 11:44:37 server id 1  end_log_pos 51906808 CRC32 0xe71105f4 	Table_map: `niuniuh5_db`.`table_web_totalinline_min` mapped to number 109
# at 51906808
#201016 11:44:37 server id 1  end_log_pos 51906860 CRC32 0xd91541af 	Write_rows: table id 109 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_web_totalinline_min`
### SET
###   @1=519793 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1602819877 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @3=2 /* INT meta=0 nullable=0 is_null=0 */
# at 51906860
#201016 11:44:37 server id 1  end_log_pos 51906891 CRC32 0x5258b6d1 	Xid = 28397783
COMMIT/*!*/;
# at 51906891
#201016 11:44:43 server id 1  end_log_pos 51906956 CRC32 0x27618ddb 	GTID	last_committed=50784	sequence_number=50785	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409356'/*!*/;
# at 51906956
#201016 11:44:43 server id 1  end_log_pos 51907035 CRC32 0xeb55e625 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819883/*!*/;
BEGIN
/*!*/;
# at 51907035
#201016 11:44:43 server id 1  end_log_pos 51907171 CRC32 0x9fd468c9 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51907171
#201016 11:44:43 server id 1  end_log_pos 51907265 CRC32 0x7d091c11 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51907265
#201016 11:44:43 server id 1  end_log_pos 51907471 CRC32 0x53ce37ae 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=206400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=202400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51907471
#201016 11:44:43 server id 1  end_log_pos 51907502 CRC32 0x003ad271 	Xid = 28397797
COMMIT/*!*/;
# at 51907502
#201016 11:44:43 server id 1  end_log_pos 51907567 CRC32 0x2f3eb855 	GTID	last_committed=50784	sequence_number=50786	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409357'/*!*/;
# at 51907567
#201016 11:44:43 server id 1  end_log_pos 51907654 CRC32 0xc4cefa95 	Query	thread_id=94771	exec_time=0	error_code=0
SET TIMESTAMP=1602819883/*!*/;
BEGIN
/*!*/;
# at 51907654
#201016 11:44:43 server id 1  end_log_pos 51908158 CRC32 0x74c20ed8 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819855-520',520,2000,0,'2020-10-16 11:44:15','2020-10-16 11:44:43',91576,0,0,'保时捷',206400,4000,4000,-4000,202400,0,117,11701,'','','保时捷')
# at 51908158
#201016 11:44:43 server id 1  end_log_pos 51908278 CRC32 0x2bb53a7b 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51908278
#201016 11:44:43 server id 1  end_log_pos 51908462 CRC32 0x16c0abfe 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002623 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819855-520' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=520 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819855.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819883.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='保时捷' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=206400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=202400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='保时捷' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51908462
#201016 11:44:43 server id 1  end_log_pos 51908493 CRC32 0x5421cb31 	Xid = 28397829
COMMIT/*!*/;
# at 51908493
#201016 11:44:43 server id 1  end_log_pos 51908558 CRC32 0xe0ccda84 	GTID	last_committed=50785	sequence_number=50787	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409358'/*!*/;
# at 51908558
#201016 11:44:43 server id 1  end_log_pos 51908645 CRC32 0x3700f56c 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819883/*!*/;
BEGIN
/*!*/;
# at 51908645
#201016 11:44:43 server id 1  end_log_pos 51908919 CRC32 0x0766ec3f 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819855-520-16',NULL,202400,6,0,0,'游戏消耗',10445,0)
# at 51908919
#201016 11:44:43 server id 1  end_log_pos 51909015 CRC32 0xbf0bf899 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51909015
#201016 11:44:43 server id 1  end_log_pos 51909153 CRC32 0xd72b5beb 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002623 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819855-520-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=202400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819883 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51909153
#201016 11:44:43 server id 1  end_log_pos 51909184 CRC32 0x63ac09ef 	Xid = 28397856
COMMIT/*!*/;
# at 51909184
#201016 11:44:43 server id 1  end_log_pos 51909249 CRC32 0xe9a85d03 	GTID	last_committed=50787	sequence_number=50788	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409359'/*!*/;
# at 51909249
#201016 11:44:43 server id 1  end_log_pos 51909336 CRC32 0x22d08958 	Query	thread_id=94771	exec_time=0	error_code=0
SET TIMESTAMP=1602819883/*!*/;
BEGIN
/*!*/;
# at 51909336
#201016 11:44:43 server id 1  end_log_pos 51909844 CRC32 0xee0c8177 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819855-520-16','test92022',0,'2020-10-16 11:44:15','2020-10-16 11:44:43',91576,206400,4000,4000,-4000,0,117,11701,'保时捷','gj')
# at 51909844
#201016 11:44:43 server id 1  end_log_pos 51909957 CRC32 0xa7289832 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51909957
#201016 11:44:43 server id 1  end_log_pos 51910128 CRC32 0x6f4f7cd0 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002623 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819855-520-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819855.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819883.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=206400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='保时捷' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51910128
#201016 11:44:43 server id 1  end_log_pos 51910159 CRC32 0x95e90d03 	Xid = 28397883
COMMIT/*!*/;
# at 51910159
#201016 11:44:59 server id 1  end_log_pos 51910224 CRC32 0x48f924fd 	GTID	last_committed=50788	sequence_number=50789	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409360'/*!*/;
# at 51910224
#201016 11:44:59 server id 1  end_log_pos 51910311 CRC32 0x67c29f83 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819899/*!*/;
BEGIN
/*!*/;
# at 51910311
#201016 11:44:59 server id 1  end_log_pos 51910582 CRC32 0x4ab71faf 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819868-839-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51910582
#201016 11:44:59 server id 1  end_log_pos 51910678 CRC32 0xc0370ca2 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51910678
#201016 11:44:59 server id 1  end_log_pos 51910816 CRC32 0x10393345 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002624 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819868-839-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819899 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51910816
#201016 11:44:59 server id 1  end_log_pos 51910847 CRC32 0x2911ae6a 	Xid = 28397986
COMMIT/*!*/;
# at 51910847
#201016 11:44:59 server id 1  end_log_pos 51910912 CRC32 0x5ab710cb 	GTID	last_committed=50788	sequence_number=50790	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409361'/*!*/;
# at 51910912
#201016 11:44:59 server id 1  end_log_pos 51910999 CRC32 0xdf48d56a 	Query	thread_id=94780	exec_time=0	error_code=0
SET TIMESTAMP=1602819899/*!*/;
BEGIN
/*!*/;
# at 51910999
#201016 11:44:59 server id 1  end_log_pos 51911519 CRC32 0x95b5a1aa 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819868-839',839,2000,0,'2020-10-16 11:44:28','2020-10-16 11:44:59',120041,0,0,'兔子x6 (走兽x2 )',204000,4000,0,0,204000,0,116,11601,'','','兔子x6 (走兽x2 )')
# at 51911519
#201016 11:44:59 server id 1  end_log_pos 51911639 CRC32 0x140c76b7 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51911639
#201016 11:44:59 server id 1  end_log_pos 51911845 CRC32 0x94f40fed 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002624 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819868-839' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=839 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819868.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819899.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='兔子x6 (走兽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51911845
#201016 11:44:59 server id 1  end_log_pos 51911876 CRC32 0x1ad7049c 	Xid = 28397978
COMMIT/*!*/;
# at 51911876
#201016 11:44:59 server id 1  end_log_pos 51911941 CRC32 0x91b3f71c 	GTID	last_committed=50790	sequence_number=50791	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409362'/*!*/;
# at 51911941
#201016 11:44:59 server id 1  end_log_pos 51912028 CRC32 0x70b7a93e 	Query	thread_id=94780	exec_time=0	error_code=0
SET TIMESTAMP=1602819899/*!*/;
BEGIN
/*!*/;
# at 51912028
#201016 11:44:59 server id 1  end_log_pos 51912541 CRC32 0x3c624ce4 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819868-839-12','test92024',0,'2020-10-16 11:44:28','2020-10-16 11:44:59',120041,204000,4000,0,0,0,116,11601,'兔子x6 (走兽x2 )','gj')
# at 51912541
#201016 11:44:59 server id 1  end_log_pos 51912654 CRC32 0xc8085427 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51912654
#201016 11:44:59 server id 1  end_log_pos 51912836 CRC32 0x61b6c50a 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002624 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819868-839-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819868.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819899.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51912836
#201016 11:44:59 server id 1  end_log_pos 51912867 CRC32 0xaae29aaf 	Xid = 28398016
COMMIT/*!*/;
# at 51912867
#201016 11:45:00 server id 1  end_log_pos 51912932 CRC32 0x3305e675 	GTID	last_committed=50791	sequence_number=50792	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409363'/*!*/;
# at 51912932
#201016 11:45:00 server id 1  end_log_pos 51913019 CRC32 0x432302c4 	Query	thread_id=98078	exec_time=0	error_code=0
SET TIMESTAMP=1602819900/*!*/;
SET @@session.sql_auto_is_null=1/*!*/;
BEGIN
/*!*/;
# at 51913019
#201016 11:45:00 server id 1  end_log_pos 51913325 CRC32 0x2288a8ab 	Rows_query
# INSERT INTO table_webdata_analysis_dailyonline (
# 		`nClubId`,
# 		`onlineCount`,
# 		`tEndTime`
# 	) SELECT
# 		tuser.nLastClubID,
# 		count(*),
# 		now()
# 	FROM
# 		table_user_gamelock game
# 	INNER JOIN table_user tuser ON game.nPlayerID = tuser.nPlayerID
# 	GROUP BY
# 		tuser.nLastClubID
# at 51913325
#201016 11:45:00 server id 1  end_log_pos 51913413 CRC32 0x47f13b0c 	Table_map: `niuniuh5_db`.`table_webdata_analysis_dailyonline` mapped to number 1035
# at 51913413
#201016 11:45:00 server id 1  end_log_pos 51913465 CRC32 0x13d31313 	Write_rows: table id 1035 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_webdata_analysis_dailyonline`
### SET
###   @1=1972 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=3 /* INT meta=0 nullable=0 is_null=0 */
###   @4=1602819900 /* TIMESTAMP(0) meta=0 nullable=1 is_null=0 */
# at 51913465
#201016 11:45:00 server id 1  end_log_pos 51913496 CRC32 0x262a2ea6 	Xid = 28398020
COMMIT/*!*/;
# at 51913496
#201016 11:45:14 server id 1  end_log_pos 51913561 CRC32 0xe059ca02 	GTID	last_committed=50792	sequence_number=50793	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409364'/*!*/;
# at 51913561
#201016 11:45:14 server id 1  end_log_pos 51913640 CRC32 0x6e3d30be 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819914/*!*/;
SET @@session.sql_auto_is_null=0/*!*/;
BEGIN
/*!*/;
# at 51913640
#201016 11:45:14 server id 1  end_log_pos 51913776 CRC32 0x0bfc126a 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51913776
#201016 11:45:14 server id 1  end_log_pos 51913870 CRC32 0x277dafa9 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51913870
#201016 11:45:14 server id 1  end_log_pos 51914076 CRC32 0x50aecddf 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=202400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=208400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51914076
#201016 11:45:14 server id 1  end_log_pos 51914107 CRC32 0x051c0ac0 	Xid = 28398067
COMMIT/*!*/;
# at 51914107
#201016 11:45:14 server id 1  end_log_pos 51914172 CRC32 0x6c5b2992 	GTID	last_committed=50793	sequence_number=50794	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409365'/*!*/;
# at 51914172
#201016 11:45:14 server id 1  end_log_pos 51914259 CRC32 0x03c2a165 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819914/*!*/;
BEGIN
/*!*/;
# at 51914259
#201016 11:45:14 server id 1  end_log_pos 51914532 CRC32 0xdd6474ac 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,6000,'10445-611825-1602819886-521-16',NULL,208400,5,0,0,'游戏获得',10445,0)
# at 51914532
#201016 11:45:14 server id 1  end_log_pos 51914628 CRC32 0x70a2159f 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51914628
#201016 11:45:14 server id 1  end_log_pos 51914766 CRC32 0x39b0954a 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002625 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=6000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819886-521-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=208400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819914 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51914766
#201016 11:45:14 server id 1  end_log_pos 51914797 CRC32 0xc87ff193 	Xid = 28398094
COMMIT/*!*/;
# at 51914797
#201016 11:45:14 server id 1  end_log_pos 51914862 CRC32 0xf50b4196 	GTID	last_committed=50794	sequence_number=50795	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409366'/*!*/;
# at 51914862
#201016 11:45:14 server id 1  end_log_pos 51914949 CRC32 0x4b02bd66 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819914/*!*/;
BEGIN
/*!*/;
# at 51914949
#201016 11:45:14 server id 1  end_log_pos 51915446 CRC32 0xdef2053e 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819886-521',521,2000,0,'2020-10-16 11:44:46','2020-10-16 11:45:14',91576,0,0,'宝马',202400,4000,4000,6000,208400,0,117,11701,'','','宝马')
# at 51915446
#201016 11:45:14 server id 1  end_log_pos 51915566 CRC32 0xb39cc0b8 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51915566
#201016 11:45:14 server id 1  end_log_pos 51915744 CRC32 0x110d4f93 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002625 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819886-521' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=521 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819886.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819914.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='宝马' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=202400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=6000 /* INT meta=0 nullable=1 is_null=0 */
###   @18=208400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='宝马' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51915744
#201016 11:45:14 server id 1  end_log_pos 51915775 CRC32 0x6c4e3c5e 	Xid = 28398129
COMMIT/*!*/;
# at 51915775
#201016 11:45:14 server id 1  end_log_pos 51915840 CRC32 0xea1bea28 	GTID	last_committed=50795	sequence_number=50796	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409367'/*!*/;
# at 51915840
#201016 11:45:14 server id 1  end_log_pos 51915927 CRC32 0xb84cfaaa 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819914/*!*/;
BEGIN
/*!*/;
# at 51915927
#201016 11:45:14 server id 1  end_log_pos 51916431 CRC32 0x5a033e51 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819886-521-16','test92022',0,'2020-10-16 11:44:46','2020-10-16 11:45:14',91576,202400,4000,4000,6000,0,117,11701,'宝马','gj')
# at 51916431
#201016 11:45:14 server id 1  end_log_pos 51916544 CRC32 0xa4913d22 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51916544
#201016 11:45:14 server id 1  end_log_pos 51916712 CRC32 0x7a672e63 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002625 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819886-521-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819886.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819914.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=202400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=6000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='宝马' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51916712
#201016 11:45:14 server id 1  end_log_pos 51916743 CRC32 0x032d880b 	Xid = 28398156
COMMIT/*!*/;
# at 51916743
#201016 11:45:32 server id 1  end_log_pos 51916808 CRC32 0xa73ba969 	GTID	last_committed=50796	sequence_number=50797	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409368'/*!*/;
# at 51916808
#201016 11:45:32 server id 1  end_log_pos 51916895 CRC32 0x014c5ad0 	Query	thread_id=94776	exec_time=0	error_code=0
SET TIMESTAMP=1602819932/*!*/;
BEGIN
/*!*/;
# at 51916895
#201016 11:45:32 server id 1  end_log_pos 51917415 CRC32 0x6f05d65e 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819901-840',840,2000,0,'2020-10-16 11:45:01','2020-10-16 11:45:32',120041,0,0,'老鹰x12(飞禽x2 )',204000,4000,0,0,204000,0,116,11601,'','','老鹰x12(飞禽x2 )')
# at 51917415
#201016 11:45:32 server id 1  end_log_pos 51917535 CRC32 0xb325c4ea 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51917535
#201016 11:45:32 server id 1  end_log_pos 51917741 CRC32 0x908d59d6 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002626 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819901-840' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=840 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819901.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819932.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='老鹰x12(飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='老鹰x12(飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51917741
#201016 11:45:32 server id 1  end_log_pos 51917772 CRC32 0x871f71ce 	Xid = 28398248
COMMIT/*!*/;
# at 51917772
#201016 11:45:32 server id 1  end_log_pos 51917837 CRC32 0x39dc4afd 	GTID	last_committed=50796	sequence_number=50798	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409369'/*!*/;
# at 51917837
#201016 11:45:32 server id 1  end_log_pos 51917924 CRC32 0x40aab2c9 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819932/*!*/;
BEGIN
/*!*/;
# at 51917924
#201016 11:45:32 server id 1  end_log_pos 51918195 CRC32 0x4749c493 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819901-840-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51918195
#201016 11:45:32 server id 1  end_log_pos 51918291 CRC32 0x35483003 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51918291
#201016 11:45:32 server id 1  end_log_pos 51918429 CRC32 0x72773dde 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002626 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819901-840-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819932 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51918429
#201016 11:45:32 server id 1  end_log_pos 51918460 CRC32 0x4a64565a 	Xid = 28398268
COMMIT/*!*/;
# at 51918460
#201016 11:45:32 server id 1  end_log_pos 51918525 CRC32 0xd3003e3f 	GTID	last_committed=50797	sequence_number=50799	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409370'/*!*/;
# at 51918525
#201016 11:45:32 server id 1  end_log_pos 51918612 CRC32 0x3f8cfb5e 	Query	thread_id=94776	exec_time=0	error_code=0
SET TIMESTAMP=1602819932/*!*/;
BEGIN
/*!*/;
# at 51918612
#201016 11:45:32 server id 1  end_log_pos 51919125 CRC32 0xda7d75fd 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819901-840-12','test92024',0,'2020-10-16 11:45:01','2020-10-16 11:45:32',120041,204000,4000,0,0,0,116,11601,'老鹰x12(飞禽x2 )','gj')
# at 51919125
#201016 11:45:32 server id 1  end_log_pos 51919238 CRC32 0x75ca1f7b 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51919238
#201016 11:45:32 server id 1  end_log_pos 51919420 CRC32 0x3f7dbe16 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002626 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819901-840-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819901.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819932.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='老鹰x12(飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51919420
#201016 11:45:32 server id 1  end_log_pos 51919451 CRC32 0xf5f68154 	Xid = 28398295
COMMIT/*!*/;
# at 51919451
#201016 11:45:45 server id 1  end_log_pos 51919516 CRC32 0x688e9c2d 	GTID	last_committed=50799	sequence_number=50800	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409371'/*!*/;
# at 51919516
#201016 11:45:45 server id 1  end_log_pos 51919595 CRC32 0xf1ebb6b4 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819945/*!*/;
BEGIN
/*!*/;
# at 51919595
#201016 11:45:45 server id 1  end_log_pos 51919731 CRC32 0xa3cee179 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51919731
#201016 11:45:45 server id 1  end_log_pos 51919825 CRC32 0x1f9e522f 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51919825
#201016 11:45:45 server id 1  end_log_pos 51920031 CRC32 0xa84e5e08 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=208400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=204400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51920031
#201016 11:45:45 server id 1  end_log_pos 51920062 CRC32 0x9d97aacd 	Xid = 28398331
COMMIT/*!*/;
# at 51920062
#201016 11:45:45 server id 1  end_log_pos 51920127 CRC32 0x37bae9ad 	GTID	last_committed=50799	sequence_number=50801	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409372'/*!*/;
# at 51920127
#201016 11:45:45 server id 1  end_log_pos 51920214 CRC32 0x1c9e6981 	Query	thread_id=94773	exec_time=0	error_code=0
SET TIMESTAMP=1602819945/*!*/;
BEGIN
/*!*/;
# at 51920214
#201016 11:45:45 server id 1  end_log_pos 51920718 CRC32 0xe7561d2b 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819917-522',522,2000,0,'2020-10-16 11:45:17','2020-10-16 11:45:45',91576,0,0,'保时捷',208400,4000,4000,-4000,204400,0,117,11701,'','','保时捷')
# at 51920718
#201016 11:45:45 server id 1  end_log_pos 51920838 CRC32 0xea26f914 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51920838
#201016 11:45:45 server id 1  end_log_pos 51921022 CRC32 0x431b536e 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002627 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819917-522' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=522 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819917.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819945.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='保时捷' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=208400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=204400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='保时捷' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51921022
#201016 11:45:45 server id 1  end_log_pos 51921053 CRC32 0xe5d11cfa 	Xid = 28398362
COMMIT/*!*/;
# at 51921053
#201016 11:45:45 server id 1  end_log_pos 51921118 CRC32 0xf67c6aa8 	GTID	last_committed=50800	sequence_number=50802	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409373'/*!*/;
# at 51921118
#201016 11:45:45 server id 1  end_log_pos 51921205 CRC32 0xf5809038 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819945/*!*/;
BEGIN
/*!*/;
# at 51921205
#201016 11:45:45 server id 1  end_log_pos 51921479 CRC32 0x61c3f4c3 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819917-522-16',NULL,204400,6,0,0,'游戏消耗',10445,0)
# at 51921479
#201016 11:45:45 server id 1  end_log_pos 51921575 CRC32 0x35ddf856 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51921575
#201016 11:45:45 server id 1  end_log_pos 51921713 CRC32 0x261d600a 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002627 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819917-522-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819945 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51921713
#201016 11:45:45 server id 1  end_log_pos 51921744 CRC32 0x0d7d6886 	Xid = 28398389
COMMIT/*!*/;
# at 51921744
#201016 11:45:45 server id 1  end_log_pos 51921809 CRC32 0xf0b1b5a7 	GTID	last_committed=50801	sequence_number=50803	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409374'/*!*/;
# at 51921809
#201016 11:45:45 server id 1  end_log_pos 51921896 CRC32 0x8314215f 	Query	thread_id=94773	exec_time=0	error_code=0
SET TIMESTAMP=1602819945/*!*/;
BEGIN
/*!*/;
# at 51921896
#201016 11:45:45 server id 1  end_log_pos 51922404 CRC32 0x30e55d7a 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819917-522-16','test92022',0,'2020-10-16 11:45:17','2020-10-16 11:45:45',91576,208400,4000,4000,-4000,0,117,11701,'保时捷','gj')
# at 51922404
#201016 11:45:45 server id 1  end_log_pos 51922517 CRC32 0xd4b433ec 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51922517
#201016 11:45:45 server id 1  end_log_pos 51922688 CRC32 0xb92b4d97 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002627 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819917-522-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819917.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819945.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=208400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='保时捷' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51922688
#201016 11:45:45 server id 1  end_log_pos 51922719 CRC32 0x42e2efc8 	Xid = 28398416
COMMIT/*!*/;
# at 51922719
#201016 11:46:05 server id 1  end_log_pos 51922784 CRC32 0x05ac708e 	GTID	last_committed=50803	sequence_number=50804	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409375'/*!*/;
# at 51922784
#201016 11:46:05 server id 1  end_log_pos 51922871 CRC32 0xbcbda92f 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819965/*!*/;
BEGIN
/*!*/;
# at 51922871
#201016 11:46:05 server id 1  end_log_pos 51923142 CRC32 0x8eb14764 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819934-841-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51923142
#201016 11:46:05 server id 1  end_log_pos 51923238 CRC32 0x2abeaaa2 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51923238
#201016 11:46:05 server id 1  end_log_pos 51923376 CRC32 0x39a3634e 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002628 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819934-841-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819965 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51923376
#201016 11:46:05 server id 1  end_log_pos 51923407 CRC32 0xc9a8016f 	Xid = 28398510
COMMIT/*!*/;
# at 51923407
#201016 11:46:05 server id 1  end_log_pos 51923472 CRC32 0x0edcb95d 	GTID	last_committed=50804	sequence_number=50805	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409376'/*!*/;
# at 51923472
#201016 11:46:05 server id 1  end_log_pos 51923559 CRC32 0x5c26a0d2 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819965/*!*/;
BEGIN
/*!*/;
# at 51923559
#201016 11:46:05 server id 1  end_log_pos 51924079 CRC32 0x46f06be9 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819934-841',841,2000,0,'2020-10-16 11:45:34','2020-10-16 11:46:05',120041,0,0,'孔雀x9 (飞禽x2 )',204000,4000,0,0,204000,0,116,11601,'','','孔雀x9 (飞禽x2 )')
# at 51924079
#201016 11:46:05 server id 1  end_log_pos 51924199 CRC32 0x810d9d97 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51924199
#201016 11:46:05 server id 1  end_log_pos 51924405 CRC32 0xfe1141b0 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002628 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819934-841' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=841 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819934.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819965.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='孔雀x9 (飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='孔雀x9 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51924405
#201016 11:46:05 server id 1  end_log_pos 51924436 CRC32 0x55ebef44 	Xid = 28398545
COMMIT/*!*/;
# at 51924436
#201016 11:46:05 server id 1  end_log_pos 51924501 CRC32 0x3e53cb58 	GTID	last_committed=50805	sequence_number=50806	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409377'/*!*/;
# at 51924501
#201016 11:46:05 server id 1  end_log_pos 51924588 CRC32 0xf3d9dc86 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819965/*!*/;
BEGIN
/*!*/;
# at 51924588
#201016 11:46:05 server id 1  end_log_pos 51925101 CRC32 0xa3e35245 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819934-841-12','test92024',0,'2020-10-16 11:45:34','2020-10-16 11:46:05',120041,204000,4000,0,0,0,116,11601,'孔雀x9 (飞禽x2 )','gj')
# at 51925101
#201016 11:46:05 server id 1  end_log_pos 51925214 CRC32 0x0f193215 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51925214
#201016 11:46:05 server id 1  end_log_pos 51925396 CRC32 0x01d65a14 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002628 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819934-841-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819934.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819965.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='孔雀x9 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51925396
#201016 11:46:05 server id 1  end_log_pos 51925427 CRC32 0x8c8e9320 	Xid = 28398572
COMMIT/*!*/;
# at 51925427
#201016 11:46:16 server id 1  end_log_pos 51925492 CRC32 0xdccb298a 	GTID	last_committed=50806	sequence_number=50807	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409378'/*!*/;
# at 51925492
#201016 11:46:16 server id 1  end_log_pos 51925571 CRC32 0xe42b0cd6 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819976/*!*/;
BEGIN
/*!*/;
# at 51925571
#201016 11:46:16 server id 1  end_log_pos 51925707 CRC32 0xb14dc017 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51925707
#201016 11:46:16 server id 1  end_log_pos 51925801 CRC32 0xe02e1fc4 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51925801
#201016 11:46:16 server id 1  end_log_pos 51926007 CRC32 0x239f308a 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=204400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=200400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51926007
#201016 11:46:16 server id 1  end_log_pos 51926038 CRC32 0xc662bd17 	Xid = 28398603
COMMIT/*!*/;
# at 51926038
#201016 11:46:16 server id 1  end_log_pos 51926103 CRC32 0xf3a33aea 	GTID	last_committed=50806	sequence_number=50808	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409379'/*!*/;
# at 51926103
#201016 11:46:16 server id 1  end_log_pos 51926190 CRC32 0x8fe31e05 	Query	thread_id=94774	exec_time=0	error_code=0
SET TIMESTAMP=1602819976/*!*/;
BEGIN
/*!*/;
# at 51926190
#201016 11:46:16 server id 1  end_log_pos 51926688 CRC32 0xe92b33f4 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819948-523',523,2000,0,'2020-10-16 11:45:48','2020-10-16 11:46:16',91576,0,0,'大众',204400,4000,4000,-4000,200400,0,117,11701,'','','大众')
# at 51926688
#201016 11:46:16 server id 1  end_log_pos 51926808 CRC32 0xd89cb9c4 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51926808
#201016 11:46:16 server id 1  end_log_pos 51926986 CRC32 0xabeacbb4 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002629 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819948-523' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=523 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819948.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819976.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='大众' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=200400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51926986
#201016 11:46:16 server id 1  end_log_pos 51927017 CRC32 0xbd565bde 	Xid = 28398635
COMMIT/*!*/;
# at 51927017
#201016 11:46:16 server id 1  end_log_pos 51927082 CRC32 0xfb8154b0 	GTID	last_committed=50807	sequence_number=50809	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409380'/*!*/;
# at 51927082
#201016 11:46:16 server id 1  end_log_pos 51927169 CRC32 0xb26808dd 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602819976/*!*/;
BEGIN
/*!*/;
# at 51927169
#201016 11:46:16 server id 1  end_log_pos 51927443 CRC32 0x8218638b 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819948-523-16',NULL,200400,6,0,0,'游戏消耗',10445,0)
# at 51927443
#201016 11:46:16 server id 1  end_log_pos 51927539 CRC32 0xa883261e 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51927539
#201016 11:46:16 server id 1  end_log_pos 51927677 CRC32 0x802c33c4 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002629 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819948-523-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=200400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819976 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51927677
#201016 11:46:16 server id 1  end_log_pos 51927708 CRC32 0xdf5853e2 	Xid = 28398662
COMMIT/*!*/;
# at 51927708
#201016 11:46:16 server id 1  end_log_pos 51927773 CRC32 0x3f0b72a4 	GTID	last_committed=50808	sequence_number=50810	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409381'/*!*/;
# at 51927773
#201016 11:46:16 server id 1  end_log_pos 51927860 CRC32 0x3f2c0f13 	Query	thread_id=94774	exec_time=0	error_code=0
SET TIMESTAMP=1602819976/*!*/;
BEGIN
/*!*/;
# at 51927860
#201016 11:46:16 server id 1  end_log_pos 51928365 CRC32 0xe9d2c77e 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819948-523-16','test92022',0,'2020-10-16 11:45:48','2020-10-16 11:46:16',91576,204400,4000,4000,-4000,0,117,11701,'大众','gj')
# at 51928365
#201016 11:46:16 server id 1  end_log_pos 51928478 CRC32 0x7a25ad8b 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51928478
#201016 11:46:16 server id 1  end_log_pos 51928646 CRC32 0xe12e7a67 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002629 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819948-523-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819948.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819976.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51928646
#201016 11:46:16 server id 1  end_log_pos 51928677 CRC32 0x2b18f1dc 	Xid = 28398689
COMMIT/*!*/;
# at 51928677
#201016 11:46:16 server id 1  end_log_pos 51928742 CRC32 0x1272faf6 	GTID	last_committed=50808	sequence_number=50811	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409382'/*!*/;
# at 51928742
#201016 11:46:16 server id 1  end_log_pos 51928824 CRC32 0xb045888a 	Query	thread_id=98054	exec_time=0	error_code=0
SET TIMESTAMP=1602819976/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=45,@@session.collation_connection=45,@@session.collation_server=45/*!*/;
BEGIN
/*!*/;
# at 51928824
#201016 11:46:16 server id 1  end_log_pos 51928887 CRC32 0x6798525a 	Rows_query
# delete from t_20201016 where id=1100000
# at 51928887
#201016 11:46:16 server id 1  end_log_pos 51928964 CRC32 0x217b144b 	Table_map: `consistency_db`.`t_20201016` mapped to number 1077
# at 51928964
#201016 11:46:16 server id 1  end_log_pos 51929295 CRC32 0xcaade60a 	Delete_rows: table id 1077 flags: STMT_END_F
### DELETE FROM `consistency_db`.`t_20201016`
### WHERE
###   @1=1100000 /* INT meta=0 nullable=0 is_null=0 */
###   @2='3c7e1799de' /* VARSTRING(128) meta=128 nullable=0 is_null=0 */
###   @3=100000 /* INT meta=0 nullable=0 is_null=0 */
###   @4=45 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @5='1361d311e2afd53c410f214c62fad8' /* VARSTRING(128) meta=128 nullable=0 is_null=0 */
###   @6='975a0a63aed142bd1ff3862229ee6562d4ce0199a4065a494d5764448a4d6a32验证延迟从库消费1G的binlog大小需要多久' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @7='68e41764919562e7e767f88f003ba906c119608d7aae85a0050b0d0e9a115c65验证延迟从库消费1G的binlog大小需要多久' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @8=1602818900.992 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
# at 51929295
#201016 11:46:16 server id 1  end_log_pos 51929326 CRC32 0x9443c3af 	Xid = 28398690
COMMIT/*!*/;
# at 51929326
#201016 11:46:37 server id 1  end_log_pos 51929391 CRC32 0xfd7c7265 	GTID	last_committed=50811	sequence_number=50812	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409383'/*!*/;
# at 51929391
#201016 11:46:37 server id 1  end_log_pos 51929478 CRC32 0x79d24ec0 	Query	thread_id=94637	exec_time=0	error_code=0
SET TIMESTAMP=1602819997/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
BEGIN
/*!*/;
# at 51929478
#201016 11:46:37 server id 1  end_log_pos 51929579 CRC32 0x397c16ac 	Rows_query
# insert into Table_Web_TotalInLine_min(szTime, `online`) values(NOW(), $total)
# at 51929579
#201016 11:46:37 server id 1  end_log_pos 51929657 CRC32 0x495cee15 	Table_map: `niuniuh5_db`.`table_web_totalinline_min` mapped to number 109
# at 51929657
#201016 11:46:37 server id 1  end_log_pos 51929709 CRC32 0xedc2bab9 	Write_rows: table id 109 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_web_totalinline_min`
### SET
###   @1=519794 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1602819997 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @3=2 /* INT meta=0 nullable=0 is_null=0 */
# at 51929709
#201016 11:46:37 server id 1  end_log_pos 51929740 CRC32 0xf096a67b 	Xid = 28398752
COMMIT/*!*/;
# at 51929740
#201016 11:46:38 server id 1  end_log_pos 51929805 CRC32 0x06b47198 	GTID	last_committed=50812	sequence_number=50813	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409384'/*!*/;
# at 51929805
#201016 11:46:38 server id 1  end_log_pos 51929892 CRC32 0x3bdb6dbc 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602819998/*!*/;
BEGIN
/*!*/;
# at 51929892
#201016 11:46:38 server id 1  end_log_pos 51930163 CRC32 0x023b66c6 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602819967-842-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51930163
#201016 11:46:38 server id 1  end_log_pos 51930259 CRC32 0x1be28aa9 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51930259
#201016 11:46:38 server id 1  end_log_pos 51930397 CRC32 0x6a4fb2cb 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002630 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602819967-842-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602819998 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51930397
#201016 11:46:38 server id 1  end_log_pos 51930428 CRC32 0xaf0ea514 	Xid = 28398814
COMMIT/*!*/;
# at 51930428
#201016 11:46:38 server id 1  end_log_pos 51930493 CRC32 0x87af955b 	GTID	last_committed=50812	sequence_number=50814	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409385'/*!*/;
# at 51930493
#201016 11:46:38 server id 1  end_log_pos 51930580 CRC32 0xdc964670 	Query	thread_id=94778	exec_time=0	error_code=0
SET TIMESTAMP=1602819998/*!*/;
BEGIN
/*!*/;
# at 51930580
#201016 11:46:38 server id 1  end_log_pos 51931100 CRC32 0x7154e06c 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602819967-842',842,2000,0,'2020-10-16 11:46:07','2020-10-16 11:46:38',120041,0,0,'兔子x6 (走兽x2 )',204000,4000,0,0,204000,0,116,11601,'','','兔子x6 (走兽x2 )')
# at 51931100
#201016 11:46:38 server id 1  end_log_pos 51931220 CRC32 0xff7657ed 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51931220
#201016 11:46:38 server id 1  end_log_pos 51931426 CRC32 0xf71cb59e 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002630 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602819967-842' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=842 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819967.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602819998.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='兔子x6 (走兽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51931426
#201016 11:46:38 server id 1  end_log_pos 51931457 CRC32 0x20c1d195 	Xid = 28398811
COMMIT/*!*/;
# at 51931457
#201016 11:46:38 server id 1  end_log_pos 51931522 CRC32 0xff9fda22 	GTID	last_committed=50814	sequence_number=50815	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409386'/*!*/;
# at 51931522
#201016 11:46:38 server id 1  end_log_pos 51931609 CRC32 0x61d251ba 	Query	thread_id=94778	exec_time=0	error_code=0
SET TIMESTAMP=1602819998/*!*/;
BEGIN
/*!*/;
# at 51931609
#201016 11:46:38 server id 1  end_log_pos 51932122 CRC32 0x2452e777 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602819967-842-12','test92024',0,'2020-10-16 11:46:07','2020-10-16 11:46:38',120041,204000,4000,0,0,0,116,11601,'兔子x6 (走兽x2 )','gj')
# at 51932122
#201016 11:46:38 server id 1  end_log_pos 51932235 CRC32 0x079a725a 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51932235
#201016 11:46:38 server id 1  end_log_pos 51932417 CRC32 0xec34f151 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002630 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602819967-842-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819967.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602819998.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51932417
#201016 11:46:38 server id 1  end_log_pos 51932448 CRC32 0x0219be13 	Xid = 28398844
COMMIT/*!*/;
# at 51932448
#201016 11:46:47 server id 1  end_log_pos 51932513 CRC32 0xa90a35ad 	GTID	last_committed=50815	sequence_number=50816	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409387'/*!*/;
# at 51932513
#201016 11:46:47 server id 1  end_log_pos 51932592 CRC32 0x1b54ce03 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820007/*!*/;
BEGIN
/*!*/;
# at 51932592
#201016 11:46:47 server id 1  end_log_pos 51932728 CRC32 0x13980996 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51932728
#201016 11:46:47 server id 1  end_log_pos 51932822 CRC32 0x9ac26d81 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51932822
#201016 11:46:47 server id 1  end_log_pos 51933028 CRC32 0x60c07a0e 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=200400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=196400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51933028
#201016 11:46:47 server id 1  end_log_pos 51933059 CRC32 0xaac7bb90 	Xid = 28398870
COMMIT/*!*/;
# at 51933059
#201016 11:46:47 server id 1  end_log_pos 51933124 CRC32 0xb08904eb 	GTID	last_committed=50815	sequence_number=50817	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409388'/*!*/;
# at 51933124
#201016 11:46:47 server id 1  end_log_pos 51933211 CRC32 0x9b00f2dc 	Query	thread_id=94775	exec_time=0	error_code=0
SET TIMESTAMP=1602820007/*!*/;
BEGIN
/*!*/;
# at 51933211
#201016 11:46:47 server id 1  end_log_pos 51933709 CRC32 0x3d267501 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602819979-524',524,2000,0,'2020-10-16 11:46:19','2020-10-16 11:46:47',91576,0,0,'大众',200400,4000,4000,-4000,196400,0,117,11701,'','','大众')
# at 51933709
#201016 11:46:47 server id 1  end_log_pos 51933829 CRC32 0x048a1ad0 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51933829
#201016 11:46:47 server id 1  end_log_pos 51934007 CRC32 0x408bf875 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002631 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602819979-524' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=524 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602819979.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820007.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='大众' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=200400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=196400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51934007
#201016 11:46:47 server id 1  end_log_pos 51934038 CRC32 0xd3588b16 	Xid = 28398901
COMMIT/*!*/;
# at 51934038
#201016 11:46:47 server id 1  end_log_pos 51934103 CRC32 0x73ca88d4 	GTID	last_committed=50816	sequence_number=50818	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409389'/*!*/;
# at 51934103
#201016 11:46:47 server id 1  end_log_pos 51934190 CRC32 0xac308798 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820007/*!*/;
BEGIN
/*!*/;
# at 51934190
#201016 11:46:47 server id 1  end_log_pos 51934464 CRC32 0xb6e5dc88 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602819979-524-16',NULL,196400,6,0,0,'游戏消耗',10445,0)
# at 51934464
#201016 11:46:47 server id 1  end_log_pos 51934560 CRC32 0xb3431dfc 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51934560
#201016 11:46:47 server id 1  end_log_pos 51934698 CRC32 0x2a1f0eb9 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002631 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602819979-524-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=196400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820007 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51934698
#201016 11:46:47 server id 1  end_log_pos 51934729 CRC32 0x27e3e9b1 	Xid = 28398928
COMMIT/*!*/;
# at 51934729
#201016 11:46:47 server id 1  end_log_pos 51934794 CRC32 0x16fb74ac 	GTID	last_committed=50817	sequence_number=50819	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409390'/*!*/;
# at 51934794
#201016 11:46:47 server id 1  end_log_pos 51934881 CRC32 0x174c4fbc 	Query	thread_id=94775	exec_time=0	error_code=0
SET TIMESTAMP=1602820007/*!*/;
BEGIN
/*!*/;
# at 51934881
#201016 11:46:47 server id 1  end_log_pos 51935386 CRC32 0xc4065673 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602819979-524-16','test92022',0,'2020-10-16 11:46:19','2020-10-16 11:46:47',91576,200400,4000,4000,-4000,0,117,11701,'大众','gj')
# at 51935386
#201016 11:46:47 server id 1  end_log_pos 51935499 CRC32 0x4b33641e 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51935499
#201016 11:46:47 server id 1  end_log_pos 51935667 CRC32 0x3cd7b463 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002631 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602819979-524-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602819979.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820007.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=200400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51935667
#201016 11:46:47 server id 1  end_log_pos 51935698 CRC32 0x33746c3d 	Xid = 28398955
COMMIT/*!*/;
# at 51935698
#201016 11:47:11 server id 1  end_log_pos 51935763 CRC32 0x5e03555f 	GTID	last_committed=50819	sequence_number=50820	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409391'/*!*/;
# at 51935763
#201016 11:47:11 server id 1  end_log_pos 51935850 CRC32 0x9b3e5eae 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602820031/*!*/;
BEGIN
/*!*/;
# at 51935850
#201016 11:47:11 server id 1  end_log_pos 51936121 CRC32 0x799f0f3d 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602820000-843-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51936121
#201016 11:47:11 server id 1  end_log_pos 51936217 CRC32 0x4edf8986 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51936217
#201016 11:47:11 server id 1  end_log_pos 51936355 CRC32 0x98efdeac 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002632 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602820000-843-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820031 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51936355
#201016 11:47:11 server id 1  end_log_pos 51936386 CRC32 0x768cdd03 	Xid = 28399098
COMMIT/*!*/;
# at 51936386
#201016 11:47:11 server id 1  end_log_pos 51936451 CRC32 0x5cf8e436 	GTID	last_committed=50819	sequence_number=50821	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409392'/*!*/;
# at 51936451
#201016 11:47:11 server id 1  end_log_pos 51936538 CRC32 0x4cc19ab5 	Query	thread_id=94779	exec_time=0	error_code=0
SET TIMESTAMP=1602820031/*!*/;
BEGIN
/*!*/;
# at 51936538
#201016 11:47:11 server id 1  end_log_pos 51937058 CRC32 0xca710ea2 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602820000-843',843,2000,0,'2020-10-16 11:46:40','2020-10-16 11:47:11',120041,0,0,'老鹰x12(飞禽x2 )',204000,4000,0,0,204000,0,116,11601,'','','老鹰x12(飞禽x2 )')
# at 51937058
#201016 11:47:11 server id 1  end_log_pos 51937178 CRC32 0x5767cc9c 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51937178
#201016 11:47:11 server id 1  end_log_pos 51937384 CRC32 0x53076f45 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002632 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602820000-843' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=843 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602820000.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820031.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='老鹰x12(飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='老鹰x12(飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51937384
#201016 11:47:11 server id 1  end_log_pos 51937415 CRC32 0xe3cb4fce 	Xid = 28399088
COMMIT/*!*/;
# at 51937415
#201016 11:47:11 server id 1  end_log_pos 51937480 CRC32 0xe25a2207 	GTID	last_committed=50821	sequence_number=50822	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409393'/*!*/;
# at 51937480
#201016 11:47:11 server id 1  end_log_pos 51937567 CRC32 0xd6086603 	Query	thread_id=94779	exec_time=0	error_code=0
SET TIMESTAMP=1602820031/*!*/;
BEGIN
/*!*/;
# at 51937567
#201016 11:47:11 server id 1  end_log_pos 51938080 CRC32 0x511e2c2a 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602820000-843-12','test92024',0,'2020-10-16 11:46:40','2020-10-16 11:47:11',120041,204000,4000,0,0,0,116,11601,'老鹰x12(飞禽x2 )','gj')
# at 51938080
#201016 11:47:11 server id 1  end_log_pos 51938193 CRC32 0x972472e3 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51938193
#201016 11:47:11 server id 1  end_log_pos 51938375 CRC32 0x0cd65374 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002632 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602820000-843-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602820000.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820031.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='老鹰x12(飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51938375
#201016 11:47:11 server id 1  end_log_pos 51938406 CRC32 0xd00e80ac 	Xid = 28399128
COMMIT/*!*/;
# at 51938406
#201016 11:47:18 server id 1  end_log_pos 51938471 CRC32 0xf9053c9e 	GTID	last_committed=50822	sequence_number=50823	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409394'/*!*/;
# at 51938471
#201016 11:47:18 server id 1  end_log_pos 51938550 CRC32 0x2f5facce 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820038/*!*/;
BEGIN
/*!*/;
# at 51938550
#201016 11:47:18 server id 1  end_log_pos 51938686 CRC32 0x05aa086f 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51938686
#201016 11:47:18 server id 1  end_log_pos 51938780 CRC32 0xb0819e55 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51938780
#201016 11:47:18 server id 1  end_log_pos 51938986 CRC32 0x0bea3ba9 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=196400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=192400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51938986
#201016 11:47:18 server id 1  end_log_pos 51939017 CRC32 0x180cccdb 	Xid = 28399143
COMMIT/*!*/;
# at 51939017
#201016 11:47:18 server id 1  end_log_pos 51939082 CRC32 0xc1501888 	GTID	last_committed=50822	sequence_number=50824	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409395'/*!*/;
# at 51939082
#201016 11:47:18 server id 1  end_log_pos 51939169 CRC32 0xc0e33e6e 	Query	thread_id=94771	exec_time=0	error_code=0
SET TIMESTAMP=1602820038/*!*/;
BEGIN
/*!*/;
# at 51939169
#201016 11:47:18 server id 1  end_log_pos 51939667 CRC32 0x57ce8b9e 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602820010-525',525,2000,0,'2020-10-16 11:46:50','2020-10-16 11:47:18',91576,0,0,'大众',196400,4000,4000,-4000,192400,0,117,11701,'','','大众')
# at 51939667
#201016 11:47:18 server id 1  end_log_pos 51939787 CRC32 0xdeb6d000 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51939787
#201016 11:47:18 server id 1  end_log_pos 51939965 CRC32 0xc2abd6bb 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002633 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602820010-525' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=525 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602820010.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820038.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='大众' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=196400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=192400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51939965
#201016 11:47:18 server id 1  end_log_pos 51939996 CRC32 0x3d5f70f5 	Xid = 28399174
COMMIT/*!*/;
# at 51939996
#201016 11:47:18 server id 1  end_log_pos 51940061 CRC32 0xef6b40b8 	GTID	last_committed=50823	sequence_number=50825	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409396'/*!*/;
# at 51940061
#201016 11:47:18 server id 1  end_log_pos 51940148 CRC32 0x6319e63e 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820038/*!*/;
BEGIN
/*!*/;
# at 51940148
#201016 11:47:18 server id 1  end_log_pos 51940422 CRC32 0x3d05f636 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602820010-525-16',NULL,192400,6,0,0,'游戏消耗',10445,0)
# at 51940422
#201016 11:47:18 server id 1  end_log_pos 51940518 CRC32 0xddf98b6c 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51940518
#201016 11:47:18 server id 1  end_log_pos 51940656 CRC32 0xfe993c54 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002633 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602820010-525-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=192400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820038 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51940656
#201016 11:47:18 server id 1  end_log_pos 51940687 CRC32 0x6b861c46 	Xid = 28399201
COMMIT/*!*/;
# at 51940687
#201016 11:47:18 server id 1  end_log_pos 51940752 CRC32 0x1e91ba51 	GTID	last_committed=50824	sequence_number=50826	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409397'/*!*/;
# at 51940752
#201016 11:47:18 server id 1  end_log_pos 51940839 CRC32 0xc9a11577 	Query	thread_id=94771	exec_time=0	error_code=0
SET TIMESTAMP=1602820038/*!*/;
BEGIN
/*!*/;
# at 51940839
#201016 11:47:18 server id 1  end_log_pos 51941344 CRC32 0x6806f199 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602820010-525-16','test92022',0,'2020-10-16 11:46:50','2020-10-16 11:47:18',91576,196400,4000,4000,-4000,0,117,11701,'大众','gj')
# at 51941344
#201016 11:47:18 server id 1  end_log_pos 51941457 CRC32 0x5713d7f6 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51941457
#201016 11:47:18 server id 1  end_log_pos 51941625 CRC32 0x0493f81d 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002633 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602820010-525-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602820010.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820038.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=196400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='大众' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51941625
#201016 11:47:18 server id 1  end_log_pos 51941656 CRC32 0xe04346c0 	Xid = 28399228
COMMIT/*!*/;
# at 51941656
#201016 11:47:44 server id 1  end_log_pos 51941721 CRC32 0x12ab4e59 	GTID	last_committed=50826	sequence_number=50827	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409398'/*!*/;
# at 51941721
#201016 11:47:44 server id 1  end_log_pos 51941808 CRC32 0x43adc953 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602820064/*!*/;
BEGIN
/*!*/;
# at 51941808
#201016 11:47:44 server id 1  end_log_pos 51942079 CRC32 0xc46e98a9 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602820033-844-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51942079
#201016 11:47:44 server id 1  end_log_pos 51942175 CRC32 0x5387d5b6 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51942175
#201016 11:47:44 server id 1  end_log_pos 51942313 CRC32 0x5051903b 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002634 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602820033-844-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820064 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51942313
#201016 11:47:44 server id 1  end_log_pos 51942344 CRC32 0xbf305a75 	Xid = 28399366
COMMIT/*!*/;
# at 51942344
#201016 11:47:44 server id 1  end_log_pos 51942409 CRC32 0xab7735f5 	GTID	last_committed=50826	sequence_number=50828	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409399'/*!*/;
# at 51942409
#201016 11:47:44 server id 1  end_log_pos 51942496 CRC32 0x63daad09 	Query	thread_id=94780	exec_time=0	error_code=0
SET TIMESTAMP=1602820064/*!*/;
BEGIN
/*!*/;
# at 51942496
#201016 11:47:44 server id 1  end_log_pos 51943016 CRC32 0xbf51b431 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602820033-844',844,2000,0,'2020-10-16 11:47:13','2020-10-16 11:47:44',120041,0,0,'兔子x6 (走兽x2 )',204000,4000,0,0,204000,0,116,11601,'','','兔子x6 (走兽x2 )')
# at 51943016
#201016 11:47:44 server id 1  end_log_pos 51943136 CRC32 0xc36bef85 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51943136
#201016 11:47:44 server id 1  end_log_pos 51943342 CRC32 0xfa82b4e2 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002634 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602820033-844' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=844 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602820033.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820064.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='兔子x6 (走兽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51943342
#201016 11:47:44 server id 1  end_log_pos 51943373 CRC32 0x75a5596d 	Xid = 28399365
COMMIT/*!*/;
# at 51943373
#201016 11:47:44 server id 1  end_log_pos 51943438 CRC32 0xe5bdc9fb 	GTID	last_committed=50828	sequence_number=50829	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409400'/*!*/;
# at 51943438
#201016 11:47:44 server id 1  end_log_pos 51943525 CRC32 0x783c7358 	Query	thread_id=94780	exec_time=0	error_code=0
SET TIMESTAMP=1602820064/*!*/;
BEGIN
/*!*/;
# at 51943525
#201016 11:47:44 server id 1  end_log_pos 51944038 CRC32 0xbb524946 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602820033-844-12','test92024',0,'2020-10-16 11:47:13','2020-10-16 11:47:44',120041,204000,4000,0,0,0,116,11601,'兔子x6 (走兽x2 )','gj')
# at 51944038
#201016 11:47:44 server id 1  end_log_pos 51944151 CRC32 0x68c38605 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51944151
#201016 11:47:44 server id 1  end_log_pos 51944333 CRC32 0xd28f024f 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002634 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602820033-844-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602820033.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820064.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51944333
#201016 11:47:44 server id 1  end_log_pos 51944364 CRC32 0xcb11ec01 	Xid = 28399396
COMMIT/*!*/;
# at 51944364
#201016 11:47:49 server id 1  end_log_pos 51944429 CRC32 0xa27e1f91 	GTID	last_committed=50829	sequence_number=50830	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409401'/*!*/;
# at 51944429
#201016 11:47:49 server id 1  end_log_pos 51944508 CRC32 0x1889b273 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820069/*!*/;
BEGIN
/*!*/;
# at 51944508
#201016 11:47:49 server id 1  end_log_pos 51944644 CRC32 0x25af24f5 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51944644
#201016 11:47:49 server id 1  end_log_pos 51944738 CRC32 0x992febf9 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51944738
#201016 11:47:49 server id 1  end_log_pos 51944944 CRC32 0x9a2823bb 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=192400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=198400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51944944
#201016 11:47:49 server id 1  end_log_pos 51944975 CRC32 0x5151a55b 	Xid = 28399410
COMMIT/*!*/;
# at 51944975
#201016 11:47:49 server id 1  end_log_pos 51945040 CRC32 0xf7944747 	GTID	last_committed=50830	sequence_number=50831	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409402'/*!*/;
# at 51945040
#201016 11:47:49 server id 1  end_log_pos 51945127 CRC32 0xbbb01f4c 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820069/*!*/;
BEGIN
/*!*/;
# at 51945127
#201016 11:47:49 server id 1  end_log_pos 51945400 CRC32 0x81beaec6 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,6000,'10445-611825-1602820041-526-16',NULL,198400,5,0,0,'游戏获得',10445,0)
# at 51945400
#201016 11:47:49 server id 1  end_log_pos 51945496 CRC32 0x42d7f8f1 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51945496
#201016 11:47:49 server id 1  end_log_pos 51945634 CRC32 0x9a1442a6 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002635 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=6000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602820041-526-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=198400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820069 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51945634
#201016 11:47:49 server id 1  end_log_pos 51945665 CRC32 0xd0ef8a6b 	Xid = 28399437
COMMIT/*!*/;
# at 51945665
#201016 11:47:49 server id 1  end_log_pos 51945730 CRC32 0x78abe403 	GTID	last_committed=50831	sequence_number=50832	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409403'/*!*/;
# at 51945730
#201016 11:47:49 server id 1  end_log_pos 51945817 CRC32 0x308991d9 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820069/*!*/;
BEGIN
/*!*/;
# at 51945817
#201016 11:47:49 server id 1  end_log_pos 51946314 CRC32 0xf13fdf16 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602820041-526',526,2000,0,'2020-10-16 11:47:21','2020-10-16 11:47:49',91576,0,0,'宝马',192400,4000,4000,6000,198400,0,117,11701,'','','宝马')
# at 51946314
#201016 11:47:49 server id 1  end_log_pos 51946434 CRC32 0x1174baa0 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51946434
#201016 11:47:49 server id 1  end_log_pos 51946612 CRC32 0x5f8b87b0 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002635 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602820041-526' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=526 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602820041.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820069.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='宝马' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=192400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=6000 /* INT meta=0 nullable=1 is_null=0 */
###   @18=198400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='宝马' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51946612
#201016 11:47:49 server id 1  end_log_pos 51946643 CRC32 0xc8fba961 	Xid = 28399472
COMMIT/*!*/;
# at 51946643
#201016 11:47:49 server id 1  end_log_pos 51946708 CRC32 0x50aecf70 	GTID	last_committed=50832	sequence_number=50833	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409404'/*!*/;
# at 51946708
#201016 11:47:49 server id 1  end_log_pos 51946795 CRC32 0x34dffaba 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820069/*!*/;
BEGIN
/*!*/;
# at 51946795
#201016 11:47:49 server id 1  end_log_pos 51947299 CRC32 0x74401665 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602820041-526-16','test92022',0,'2020-10-16 11:47:21','2020-10-16 11:47:49',91576,192400,4000,4000,6000,0,117,11701,'宝马','gj')
# at 51947299
#201016 11:47:49 server id 1  end_log_pos 51947412 CRC32 0xa6e9261c 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51947412
#201016 11:47:49 server id 1  end_log_pos 51947580 CRC32 0x8936b4ee 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002635 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602820041-526-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602820041.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820069.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=192400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=6000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='宝马' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51947580
#201016 11:47:49 server id 1  end_log_pos 51947611 CRC32 0x01d31ea3 	Xid = 28399499
COMMIT/*!*/;
# at 51947611
#201016 11:48:17 server id 1  end_log_pos 51947676 CRC32 0x4194daa8 	GTID	last_committed=50833	sequence_number=50834	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409405'/*!*/;
# at 51947676
#201016 11:48:17 server id 1  end_log_pos 51947763 CRC32 0xfb9eedfe 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602820097/*!*/;
BEGIN
/*!*/;
# at 51947763
#201016 11:48:17 server id 1  end_log_pos 51948034 CRC32 0x988f0b2c 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602820066-845-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51948034
#201016 11:48:17 server id 1  end_log_pos 51948130 CRC32 0xa8afd620 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51948130
#201016 11:48:17 server id 1  end_log_pos 51948268 CRC32 0xb4e5fdd1 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002636 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602820066-845-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820097 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51948268
#201016 11:48:17 server id 1  end_log_pos 51948299 CRC32 0xfc6fabd1 	Xid = 28399655
COMMIT/*!*/;
# at 51948299
#201016 11:48:17 server id 1  end_log_pos 51948364 CRC32 0xdb22b553 	GTID	last_committed=50833	sequence_number=50835	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409406'/*!*/;
# at 51948364
#201016 11:48:17 server id 1  end_log_pos 51948451 CRC32 0x73a088c6 	Query	thread_id=94776	exec_time=0	error_code=0
SET TIMESTAMP=1602820097/*!*/;
BEGIN
/*!*/;
# at 51948451
#201016 11:48:17 server id 1  end_log_pos 51948971 CRC32 0xcda736d9 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602820066-845',845,2000,0,'2020-10-16 11:47:46','2020-10-16 11:48:17',120041,0,0,'兔子x6 (走兽x2 )',204000,4000,0,0,204000,0,116,11601,'','','兔子x6 (走兽x2 )')
# at 51948971
#201016 11:48:17 server id 1  end_log_pos 51949091 CRC32 0x7bbb71b7 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51949091
#201016 11:48:17 server id 1  end_log_pos 51949297 CRC32 0x230eeb9a 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002636 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602820066-845' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=845 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602820066.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820097.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='兔子x6 (走兽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51949297
#201016 11:48:17 server id 1  end_log_pos 51949328 CRC32 0xcc7cd46a 	Xid = 28399656
COMMIT/*!*/;
# at 51949328
#201016 11:48:17 server id 1  end_log_pos 51949393 CRC32 0x1d2ddcbd 	GTID	last_committed=50835	sequence_number=50836	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409407'/*!*/;
# at 51949393
#201016 11:48:17 server id 1  end_log_pos 51949480 CRC32 0xdc5ff492 	Query	thread_id=94776	exec_time=0	error_code=0
SET TIMESTAMP=1602820097/*!*/;
BEGIN
/*!*/;
# at 51949480
#201016 11:48:17 server id 1  end_log_pos 51949993 CRC32 0x97b05d05 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602820066-845-12','test92024',0,'2020-10-16 11:47:46','2020-10-16 11:48:17',120041,204000,4000,0,0,0,116,11601,'兔子x6 (走兽x2 )','gj')
# at 51949993
#201016 11:48:17 server id 1  end_log_pos 51950106 CRC32 0xd33a6779 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51950106
#201016 11:48:17 server id 1  end_log_pos 51950288 CRC32 0xcaab3b15 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002636 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602820066-845-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602820066.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820097.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='兔子x6 (走兽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51950288
#201016 11:48:17 server id 1  end_log_pos 51950319 CRC32 0xc5be4816 	Xid = 28399686
COMMIT/*!*/;
# at 51950319
#201016 11:48:20 server id 1  end_log_pos 51950384 CRC32 0xe4e87efb 	GTID	last_committed=50836	sequence_number=50837	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409408'/*!*/;
# at 51950384
#201016 11:48:20 server id 1  end_log_pos 51950463 CRC32 0xc962ba69 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820100/*!*/;
BEGIN
/*!*/;
# at 51950463
#201016 11:48:20 server id 1  end_log_pos 51950599 CRC32 0x7c60c14c 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51950599
#201016 11:48:20 server id 1  end_log_pos 51950693 CRC32 0x2560f413 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51950693
#201016 11:48:20 server id 1  end_log_pos 51950899 CRC32 0x72395496 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=198400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=194400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51950899
#201016 11:48:20 server id 1  end_log_pos 51950930 CRC32 0x7ff0f008 	Xid = 28399690
COMMIT/*!*/;
# at 51950930
#201016 11:48:20 server id 1  end_log_pos 51950995 CRC32 0x27a4657b 	GTID	last_committed=50836	sequence_number=50838	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409409'/*!*/;
# at 51950995
#201016 11:48:20 server id 1  end_log_pos 51951082 CRC32 0x6a774f27 	Query	thread_id=94773	exec_time=0	error_code=0
SET TIMESTAMP=1602820100/*!*/;
BEGIN
/*!*/;
# at 51951082
#201016 11:48:20 server id 1  end_log_pos 51951592 CRC32 0x8ee959b3 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602820072-527',527,2000,0,'2020-10-16 11:47:52','2020-10-16 11:48:20',91576,0,0,'玛莎拉蒂',198400,4000,4000,-4000,194400,0,117,11701,'','','玛莎拉蒂')
# at 51951592
#201016 11:48:20 server id 1  end_log_pos 51951712 CRC32 0x8b899692 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51951712
#201016 11:48:20 server id 1  end_log_pos 51951902 CRC32 0xbad692dd 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002637 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602820072-527' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=527 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602820072.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820100.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='玛莎拉蒂' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=198400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=194400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='玛莎拉蒂' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51951902
#201016 11:48:20 server id 1  end_log_pos 51951933 CRC32 0x48fa1799 	Xid = 28399721
COMMIT/*!*/;
# at 51951933
#201016 11:48:20 server id 1  end_log_pos 51951998 CRC32 0x60c3860a 	GTID	last_committed=50837	sequence_number=50839	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409410'/*!*/;
# at 51951998
#201016 11:48:20 server id 1  end_log_pos 51952085 CRC32 0x8be6bc76 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820100/*!*/;
BEGIN
/*!*/;
# at 51952085
#201016 11:48:20 server id 1  end_log_pos 51952359 CRC32 0xdcf5be79 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602820072-527-16',NULL,194400,6,0,0,'游戏消耗',10445,0)
# at 51952359
#201016 11:48:20 server id 1  end_log_pos 51952455 CRC32 0xa9b95491 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51952455
#201016 11:48:20 server id 1  end_log_pos 51952593 CRC32 0x5ea16fa2 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002637 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602820072-527-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=194400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820100 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51952593
#201016 11:48:20 server id 1  end_log_pos 51952624 CRC32 0x4543fa2a 	Xid = 28399748
COMMIT/*!*/;
# at 51952624
#201016 11:48:20 server id 1  end_log_pos 51952689 CRC32 0xc8257516 	GTID	last_committed=50838	sequence_number=50840	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409411'/*!*/;
# at 51952689
#201016 11:48:20 server id 1  end_log_pos 51952776 CRC32 0xd179cc98 	Query	thread_id=94773	exec_time=0	error_code=0
SET TIMESTAMP=1602820100/*!*/;
BEGIN
/*!*/;
# at 51952776
#201016 11:48:20 server id 1  end_log_pos 51953287 CRC32 0xe63cd0f4 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602820072-527-16','test92022',0,'2020-10-16 11:47:52','2020-10-16 11:48:20',91576,198400,4000,4000,-4000,0,117,11701,'玛莎拉蒂','gj')
# at 51953287
#201016 11:48:20 server id 1  end_log_pos 51953400 CRC32 0xdcff8003 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51953400
#201016 11:48:20 server id 1  end_log_pos 51953574 CRC32 0x0d8b1b6e 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002637 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602820072-527-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602820072.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820100.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=198400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='玛莎拉蒂' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51953574
#201016 11:48:20 server id 1  end_log_pos 51953605 CRC32 0x8b5e9718 	Xid = 28399775
COMMIT/*!*/;
# at 51953605
#201016 11:48:37 server id 1  end_log_pos 51953670 CRC32 0x44d71e86 	GTID	last_committed=50840	sequence_number=50841	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409412'/*!*/;
# at 51953670
#201016 11:48:37 server id 1  end_log_pos 51953757 CRC32 0xdc969d9e 	Query	thread_id=94630	exec_time=0	error_code=0
SET TIMESTAMP=1602820117/*!*/;
BEGIN
/*!*/;
# at 51953757
#201016 11:48:37 server id 1  end_log_pos 51953858 CRC32 0x4f180278 	Rows_query
# insert into Table_Web_TotalInLine_min(szTime, `online`) values(NOW(), $total)
# at 51953858
#201016 11:48:37 server id 1  end_log_pos 51953936 CRC32 0xeb18bbc1 	Table_map: `niuniuh5_db`.`table_web_totalinline_min` mapped to number 109
# at 51953936
#201016 11:48:37 server id 1  end_log_pos 51953988 CRC32 0xaea05053 	Write_rows: table id 109 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_web_totalinline_min`
### SET
###   @1=519795 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1602820117 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @3=2 /* INT meta=0 nullable=0 is_null=0 */
# at 51953988
#201016 11:48:37 server id 1  end_log_pos 51954019 CRC32 0xb71952ec 	Xid = 28399831
COMMIT/*!*/;
# at 51954019
#201016 11:48:50 server id 1  end_log_pos 51954084 CRC32 0x730ff290 	GTID	last_committed=50841	sequence_number=50842	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409413'/*!*/;
# at 51954084
#201016 11:48:50 server id 1  end_log_pos 51954171 CRC32 0xdd5151c2 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602820130/*!*/;
BEGIN
/*!*/;
# at 51954171
#201016 11:48:50 server id 1  end_log_pos 51954442 CRC32 0x91ccf293 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (120041,11601,0,0,'10445-599775-1602820099-846-12',NULL,204000,5,0,0,'游戏获得',10445,0)
# at 51954442
#201016 11:48:50 server id 1  end_log_pos 51954538 CRC32 0x0a532f47 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51954538
#201016 11:48:50 server id 1  end_log_pos 51954676 CRC32 0x5271845d 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002638 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=120041 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11601 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-599775-1602820099-846-12' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=204000 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=5 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏获得' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820130 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51954676
#201016 11:48:50 server id 1  end_log_pos 51954707 CRC32 0xf1aab916 	Xid = 28399900
COMMIT/*!*/;
# at 51954707
#201016 11:48:50 server id 1  end_log_pos 51954772 CRC32 0xb7ef9602 	GTID	last_committed=50842	sequence_number=50843	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409414'/*!*/;
# at 51954772
#201016 11:48:50 server id 1  end_log_pos 51954859 CRC32 0x49d61aa4 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602820130/*!*/;
BEGIN
/*!*/;
# at 51954859
#201016 11:48:50 server id 1  end_log_pos 51955379 CRC32 0x8488f9f9 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,599775,12,'10445-599775-1602820099-846',846,2000,0,'2020-10-16 11:48:19','2020-10-16 11:48:50',120041,0,0,'燕子x6 (飞禽x2 )',204000,4000,0,0,204000,0,116,11601,'','','燕子x6 (飞禽x2 )')
# at 51955379
#201016 11:48:50 server id 1  end_log_pos 51955499 CRC32 0x043cfcf5 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51955499
#201016 11:48:50 server id 1  end_log_pos 51955705 CRC32 0xb0554b4f 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002638 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @4=12 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-599775-1602820099-846' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=846 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602820099.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820130.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='燕子x6 (飞禽x2 )' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='燕子x6 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51955705
#201016 11:48:50 server id 1  end_log_pos 51955736 CRC32 0x53d15eb5 	Xid = 28399935
COMMIT/*!*/;
# at 51955736
#201016 11:48:50 server id 1  end_log_pos 51955801 CRC32 0xc8feddf6 	GTID	last_committed=50843	sequence_number=50844	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409415'/*!*/;
# at 51955801
#201016 11:48:50 server id 1  end_log_pos 51955888 CRC32 0x6e830f22 	Query	thread_id=94777	exec_time=0	error_code=0
SET TIMESTAMP=1602820130/*!*/;
BEGIN
/*!*/;
# at 51955888
#201016 11:48:50 server id 1  end_log_pos 51956401 CRC32 0x383c8399 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,599775,12,'10445-599775-1602820099-846-12','test92024',0,'2020-10-16 11:48:19','2020-10-16 11:48:50',120041,204000,4000,0,0,0,116,11601,'燕子x6 (飞禽x2 )','gj')
# at 51956401
#201016 11:48:50 server id 1  end_log_pos 51956514 CRC32 0xd019e851 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51956514
#201016 11:48:50 server id 1  end_log_pos 51956696 CRC32 0x9e8f458b 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002638 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=599775 /* INT meta=0 nullable=0 is_null=0 */
###   @6=12 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-599775-1602820099-846-12' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92024' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602820099.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820130.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=120041 /* INT meta=0 nullable=1 is_null=0 */
###   @13=204000 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=0 /* INT meta=0 nullable=1 is_null=0 */
###   @16=0 /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=116 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11601 /* INT meta=0 nullable=1 is_null=0 */
###   @20='燕子x6 (飞禽x2 )' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51956696
#201016 11:48:50 server id 1  end_log_pos 51956727 CRC32 0x2f2a4899 	Xid = 28399962
COMMIT/*!*/;
# at 51956727
#201016 11:48:51 server id 1  end_log_pos 51956792 CRC32 0x926441f9 	GTID	last_committed=50844	sequence_number=50845	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409416'/*!*/;
# at 51956792
#201016 11:48:51 server id 1  end_log_pos 51956871 CRC32 0xa12a4ad5 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820131/*!*/;
BEGIN
/*!*/;
# at 51956871
#201016 11:48:51 server id 1  end_log_pos 51957007 CRC32 0xa3605f62 	Rows_query
# UPDATE table_clubmember SET nScore = @nScore := nScore + $nScore WHERE nPlayerID=$nPlayerID AND nClubID=$nClubID
# at 51957007
#201016 11:48:51 server id 1  end_log_pos 51957101 CRC32 0x7a5f8800 	Table_map: `niuniuh5_db`.`table_clubmember` mapped to number 134
# at 51957101
#201016 11:48:51 server id 1  end_log_pos 51957307 CRC32 0x2c459c60 	Update_rows: table id 134 flags: STMT_END_F
### UPDATE `niuniuh5_db`.`table_clubmember`
### WHERE
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=194400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
### SET
###   @1=12971 /* INT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @4='test92022' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @5=3 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @6=1 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @7=1588647732 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @8=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @9=190400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @10=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='gj' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @13=91207 /* INT meta=0 nullable=1 is_null=0 */
###   @14=NULL /* TIMESTAMP(0) meta=0 nullable=1 is_null=1 */
###   @15=1 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @16=0 /* TINYINT meta=0 nullable=1 is_null=0 */
###   @17=0 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @18=0 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @19=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @20=1 /* INT meta=0 nullable=0 is_null=0 */
# at 51957307
#201016 11:48:51 server id 1  end_log_pos 51957338 CRC32 0xed8409ce 	Xid = 28399967
COMMIT/*!*/;
# at 51957338
#201016 11:48:51 server id 1  end_log_pos 51957403 CRC32 0x2fbd71ac 	GTID	last_committed=50844	sequence_number=50846	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409417'/*!*/;
# at 51957403
#201016 11:48:51 server id 1  end_log_pos 51957490 CRC32 0xc51b4299 	Query	thread_id=94774	exec_time=0	error_code=0
SET TIMESTAMP=1602820131/*!*/;
BEGIN
/*!*/;
# at 51957490
#201016 11:48:51 server id 1  end_log_pos 51957994 CRC32 0x93719abb 	Rows_query
# insert into table_clubgamescoredetail20201016 (nClubID,nTableID,nChairID,szToken,nRound,nBaseScore,nPlayCount,
# 			tStartTime,tEndTime,nPlayerID,bRobot,nBankID,szCardData,nEnterScore,nBetScore,nValidBet,nResultMoney,
# 			nPlayerScore,nTax,nGameType,nServerID,nCardData,szExtChar,CardData) values (10445,611825,16,'10445-611825-1602820103-528',528,2000,0,'2020-10-16 11:48:23','2020-10-16 11:48:51',91576,0,0,'保时捷',194400,4000,4000,-4000,190400,0,117,11701,'','','保时捷')
# at 51957994
#201016 11:48:51 server id 1  end_log_pos 51958114 CRC32 0xa50685be 	Table_map: `niuniuh5_db`.`table_clubgamescoredetail20201016` mapped to number 863
# at 51958114
#201016 11:48:51 server id 1  end_log_pos 51958298 CRC32 0xa639cb84 	Write_rows: table id 863 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clubgamescoredetail20201016`
### SET
###   @1=1855100002639 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @3=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @4=16 /* INT meta=0 nullable=1 is_null=0 */
###   @5='10445-611825-1602820103-528' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @6=528 /* INT meta=0 nullable=0 is_null=0 */
###   @7=2000 /* INT meta=0 nullable=0 is_null=0 */
###   @8=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @9=1602820103.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @10=1602820131.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @11=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @12=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @13='保时捷' /* VARSTRING(1024) meta=1024 nullable=1 is_null=0 */
###   @14=194400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @17=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @18=190400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @19=0 /* INT meta=0 nullable=1 is_null=0 */
###   @20=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @21=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @22='' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @23=0 /* INT meta=0 nullable=0 is_null=0 */
###   @24='' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @25='保时捷' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
# at 51958298
#201016 11:48:51 server id 1  end_log_pos 51958329 CRC32 0x0659ded5 	Xid = 28399998
COMMIT/*!*/;
# at 51958329
#201016 11:48:51 server id 1  end_log_pos 51958394 CRC32 0x89c6e819 	GTID	last_committed=50845	sequence_number=50847	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409418'/*!*/;
# at 51958394
#201016 11:48:51 server id 1  end_log_pos 51958481 CRC32 0xdde6837d 	Query	thread_id=94772	exec_time=0	error_code=0
SET TIMESTAMP=1602820131/*!*/;
BEGIN
/*!*/;
# at 51958481
#201016 11:48:51 server id 1  end_log_pos 51958755 CRC32 0xf93013b3 	Rows_query
# insert into table_clublogscore20201016 (nPlayerID,nGameID,nTableID,nAmount,szOrder,operateID,nScore,nType,nSubType,nTaxRate,szDesc,clubid,bRobot)
# 	values (91576,11701,0,-4000,'10445-611825-1602820103-528-16',NULL,190400,6,0,0,'游戏消耗',10445,0)
# at 51958755
#201016 11:48:51 server id 1  end_log_pos 51958851 CRC32 0xedb83461 	Table_map: `niuniuh5_db`.`table_clublogscore20201016` mapped to number 894
# at 51958851
#201016 11:48:51 server id 1  end_log_pos 51958989 CRC32 0x20f46456 	Write_rows: table id 894 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_clublogscore20201016`
### SET
###   @1=1855100002639 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=91576 /* INT meta=0 nullable=0 is_null=0 */
###   @3=11701 /* INT meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
###   @5=-4000 (18446744073709547616) /* LONGINT meta=0 nullable=0 is_null=0 */
###   @6='10445-611825-1602820103-528-16' /* VARSTRING(512) meta=512 nullable=1 is_null=0 */
###   @7=NULL /* INT meta=0 nullable=1 is_null=1 */
###   @8=190400 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @9=6 /* INT meta=0 nullable=0 is_null=0 */
###   @10=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @11=0 /* INT meta=0 nullable=0 is_null=0 */
###   @12='游戏消耗' /* VARSTRING(1024) meta=1024 nullable=0 is_null=0 */
###   @13=10445 /* INT meta=0 nullable=1 is_null=0 */
###   @14=1602820131 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @15=0 /* TINYINT meta=0 nullable=0 is_null=0 */
# at 51958989
#201016 11:48:51 server id 1  end_log_pos 51959020 CRC32 0x0f726762 	Xid = 28400025
COMMIT/*!*/;
# at 51959020
#201016 11:48:51 server id 1  end_log_pos 51959085 CRC32 0x2d1dff51 	GTID	last_committed=50846	sequence_number=50848	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '7664fad8-49fd-11e8-a546-4201c0a8010a:2409419'/*!*/;
# at 51959085
#201016 11:48:51 server id 1  end_log_pos 51959172 CRC32 0x1a8eb44f 	Query	thread_id=94774	exec_time=0	error_code=0
SET TIMESTAMP=1602820131/*!*/;
BEGIN
/*!*/;
# at 51959172
#201016 11:48:51 server id 1  end_log_pos 51959680 CRC32 0xcf8bb260 	Rows_query
# insert into table_third_score_detail20201016 (`DataType`, `SubDataType`, `nClubID`, `nTableID`, `nChairID`, `szToken`, `Accounts`,
# 	  `nPlayCount`, `tStartTime`, `tEndTime`, `nPlayerID`, `nEnterScore`, `nBetScore`, `nValidBet`, `nResultMoney`, `nTax`, `nGameType`,
# 	  `nServerID`, `CardData`, `LineCode`) values (1,0,10445,611825,16,'10445-611825-1602820103-528-16','test92022',0,'2020-10-16 11:48:23','2020-10-16 11:48:51',91576,194400,4000,4000,-4000,0,117,11701,'保时捷','gj')
# at 51959680
#201016 11:48:51 server id 1  end_log_pos 51959793 CRC32 0x0f2a6fa9 	Table_map: `niuniuh5_db`.`table_third_score_detail20201016` mapped to number 925
# at 51959793
#201016 11:48:51 server id 1  end_log_pos 51959964 CRC32 0x33bdb893 	Write_rows: table id 925 flags: STMT_END_F
### INSERT INTO `niuniuh5_db`.`table_third_score_detail20201016`
### SET
###   @1=1855100002639 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=0 /* INT meta=0 nullable=0 is_null=0 */
###   @4=10445 /* INT meta=0 nullable=0 is_null=0 */
###   @5=611825 /* INT meta=0 nullable=0 is_null=0 */
###   @6=16 /* INT meta=0 nullable=1 is_null=0 */
###   @7='10445-611825-1602820103-528-16' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
###   @8='test92022' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @9=0 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @10=1602820103.000 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
###   @11=1602820131.000 /* TIMESTAMP(3) meta=3 nullable=1 is_null=0 */
###   @12=91576 /* INT meta=0 nullable=1 is_null=0 */
###   @13=194400 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @14=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @15=4000 /* INT meta=0 nullable=1 is_null=0 */
###   @16=-4000 (4294963296) /* INT meta=0 nullable=1 is_null=0 */
###   @17=0 /* INT meta=0 nullable=1 is_null=0 */
###   @18=117 /* TINYINT meta=0 nullable=0 is_null=0 */
###   @19=11701 /* INT meta=0 nullable=1 is_null=0 */
###   @20='保时捷' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
###   @21='gj' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
# at 51959964
#201016 11:48:51 server id 1  end_log_pos 51959995 CRC32 0xb57dc843 	Xid = 28400052
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
