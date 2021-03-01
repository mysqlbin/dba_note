/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#210222 12:17:45 server id 330607  end_log_pos 123 CRC32 0x0f62ccd2 	Start: binlog v 4, server v 5.7.22-log created 210222 12:17:45 at startup
# Warning: this binlog is either in use or was not closed properly.
ROLLBACK/*!*/;
# at 123
#210222 12:17:46 server id 330607  end_log_pos 154 CRC32 0xadf140ec 	Previous-GTIDs
# [empty]
# at 154
#210222 12:20:48 server id 330607  end_log_pos 219 CRC32 0x66a81be6 	GTID	last_committed=0	sequence_number=1	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:513'/*!*/;
# at 219
#210222 12:20:48 server id 330607  end_log_pos 298 CRC32 0x2f6e051c 	Query	thread_id=4	exec_time=0	error_code=0
SET TIMESTAMP=1613967648/*!*/;
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
# at 298
#210222 12:20:48 server id 330607  end_log_pos 383 CRC32 0x4889ff12 	Table_map: `niuniuh5_db`.`admin_user` mapped to number 1213
# at 383
#210222 12:20:48 server id 330607  end_log_pos 510 CRC32 0x88820b7d 	Delete_rows: table id 1213 flags: STMT_END_F
### DELETE FROM `niuniuh5_db`.`admin_user`
### WHERE
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
###   @3='admin' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @4='E10ADC3949BA59ABBE56E057F20F883E' /* VARSTRING(200) meta=200 nullable=0 is_null=0 */
###   @5='admin管理员' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @6='15858585858' /* VARSTRING(44) meta=44 nullable=1 is_null=0 */
###   @7='' /* VARSTRING(200) meta=200 nullable=1 is_null=0 */
###   @8='' /* VARSTRING(800) meta=800 nullable=1 is_null=0 */
###   @9=1 /* INT meta=0 nullable=0 is_null=0 */
###   @10=1612234321 /* TIMESTAMP(0) meta=0 nullable=1 is_null=0 */
###   @11=1612234321 /* TIMESTAMP(0) meta=0 nullable=1 is_null=0 */
# at 510
#210222 12:20:48 server id 330607  end_log_pos 541 CRC32 0x3022a1d5 	Xid = 60
COMMIT/*!*/;
# at 541
#210223 17:03:40 server id 330607  end_log_pos 606 CRC32 0x4dc9d4b0 	GTID	last_committed=1	sequence_number=2	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:514'/*!*/;
# at 606
#210223 17:03:40 server id 330607  end_log_pos 841 CRC32 0x541c8e94 	Query	thread_id=2303	exec_time=1	error_code=0
use `test_db`/*!*/;
SET TIMESTAMP=1614071020/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE `t20210223` (
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
/*!*/;
# at 841
#210223 17:04:00 server id 330607  end_log_pos 906 CRC32 0xcd932725 	GTID	last_committed=2	sequence_number=3	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:515'/*!*/;
# at 906
#210223 17:04:00 server id 330607  end_log_pos 981 CRC32 0x4850762c 	Query	thread_id=2304	exec_time=0	error_code=0
SET TIMESTAMP=1614071040/*!*/;
BEGIN
/*!*/;
# at 981
#210223 17:04:00 server id 330607  end_log_pos 1038 CRC32 0xaf174bb2 	Table_map: `test_db`.`t20210223` mapped to number 25067
# at 1038
#210223 17:04:00 server id 330607  end_log_pos 1082 CRC32 0x39db499b 	Write_rows: table id 25067 flags: STMT_END_F
### INSERT INTO `test_db`.`t20210223`
### SET
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1614071040 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 1082
#210223 17:04:00 server id 330607  end_log_pos 1113 CRC32 0x426f1118 	Xid = 10811
COMMIT/*!*/;
# at 1113
#210223 17:07:17 server id 330607  end_log_pos 1178 CRC32 0xde3d2a25 	GTID	last_committed=3	sequence_number=4	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:516'/*!*/;
# at 1178
#210223 17:07:17 server id 330607  end_log_pos 1440 CRC32 0x2b9b5457 	Query	thread_id=2307	exec_time=0	error_code=0
SET TIMESTAMP=1614071237/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE `t20210224` (
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `idx_age` (`age`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4
/*!*/;
# at 1440
#210223 17:07:40 server id 330607  end_log_pos 1505 CRC32 0xbc5b3ab0 	GTID	last_committed=4	sequence_number=5	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:517'/*!*/;
# at 1505
#210223 17:07:40 server id 330607  end_log_pos 1588 CRC32 0xa21b1c69 	Query	thread_id=2307	exec_time=0	error_code=0
SET TIMESTAMP=1614071260/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
BEGIN
/*!*/;
# at 1588
#210223 17:07:40 server id 330607  end_log_pos 1645 CRC32 0xefb8875a 	Table_map: `test_db`.`t20210224` mapped to number 25068
# at 1645
#210223 17:07:40 server id 330607  end_log_pos 1689 CRC32 0xaacff501 	Write_rows: table id 25068 flags: STMT_END_F
### INSERT INTO `test_db`.`t20210224`
### SET
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1614071260 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 1689
#210223 17:07:40 server id 330607  end_log_pos 1720 CRC32 0x6c7635a8 	Xid = 10862
COMMIT/*!*/;
# at 1720
#210223 17:10:50 server id 330607  end_log_pos 1785 CRC32 0x12ea3e33 	GTID	last_committed=5	sequence_number=6	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:518'/*!*/;
# at 1785
#210223 17:10:50 server id 330607  end_log_pos 2138 CRC32 0xe4ee8113 	Query	thread_id=2307	exec_time=0	error_code=0
SET TIMESTAMP=1614071450/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE `t20210225` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_age` (`age`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
/*!*/;
# at 2138
#210223 17:10:51 server id 330607  end_log_pos 2203 CRC32 0x13a2e140 	GTID	last_committed=6	sequence_number=7	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:519'/*!*/;
# at 2203
#210223 17:10:51 server id 330607  end_log_pos 2286 CRC32 0x0f094451 	Query	thread_id=2307	exec_time=0	error_code=0
SET TIMESTAMP=1614071451/*!*/;
BEGIN
/*!*/;
# at 2286
#210223 17:10:51 server id 330607  end_log_pos 2344 CRC32 0x73dacb6f 	Table_map: `test_db`.`t20210225` mapped to number 25069
# at 2344
#210223 17:10:51 server id 330607  end_log_pos 2392 CRC32 0x29d9385a 	Write_rows: table id 25069 flags: STMT_END_F
### INSERT INTO `test_db`.`t20210225`
### SET
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1614071451 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 2392
#210223 17:10:51 server id 330607  end_log_pos 2423 CRC32 0x39174d88 	Xid = 10899
COMMIT/*!*/;
# at 2423
#210226 10:38:06 server id 330607  end_log_pos 2488 CRC32 0xd19642c6 	GTID	last_committed=7	sequence_number=8	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:520'/*!*/;
# at 2488
#210226 10:38:06 server id 330607  end_log_pos 2617 CRC32 0xf003cf00 	Query	thread_id=7514	exec_time=0	error_code=0
use `yldbs`/*!*/;
SET TIMESTAMP=1614307086/*!*/;
DROP TABLE `table_user_bak` /* generated by server */
/*!*/;
# at 2617
#210226 10:38:06 server id 330607  end_log_pos 2682 CRC32 0x433374a0 	GTID	last_committed=8	sequence_number=9	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:521'/*!*/;
# at 2682
#210226 10:38:06 server id 330607  end_log_pos 2824 CRC32 0x09b7baa0 	Query	thread_id=7514	exec_time=0	error_code=0
SET TIMESTAMP=1614307086/*!*/;
DROP TABLE `table_webdata_roomcardfirst` /* generated by server */
/*!*/;
# at 2824
#210226 10:38:06 server id 330607  end_log_pos 2889 CRC32 0xcf972946 	GTID	last_committed=9	sequence_number=10	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:522'/*!*/;
# at 2889
#210226 10:38:06 server id 330607  end_log_pos 3039 CRC32 0xe83001af 	Query	thread_id=7514	exec_time=0	error_code=0
SET TIMESTAMP=1614307086/*!*/;
DROP TABLE `table_webdata_roomcardfirstgamehelp` /* generated by server */
/*!*/;
# at 3039
#210226 10:38:06 server id 330607  end_log_pos 3104 CRC32 0xf65436ee 	GTID	last_committed=10	sequence_number=11	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:523'/*!*/;
# at 3104
#210226 10:38:06 server id 330607  end_log_pos 3254 CRC32 0xbda4067c 	Query	thread_id=7514	exec_time=0	error_code=0
SET TIMESTAMP=1614307086/*!*/;
DROP TABLE `table_webdata_roomcardroundstatiall` /* generated by server */
/*!*/;
# at 3254
#210226 10:38:07 server id 330607  end_log_pos 3319 CRC32 0x890b5d7c 	GTID	last_committed=11	sequence_number=12	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:524'/*!*/;
# at 3319
#210226 10:38:07 server id 330607  end_log_pos 3470 CRC32 0xaf6b2b8f 	Query	thread_id=7514	exec_time=0	error_code=0
SET TIMESTAMP=1614307087/*!*/;
DROP TABLE `table_webdata_roomcardroundstaticlub` /* generated by server */
/*!*/;
# at 3470
#210226 10:38:07 server id 330607  end_log_pos 3535 CRC32 0xf4511d9b 	GTID	last_committed=12	sequence_number=13	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:525'/*!*/;
# at 3535
#210226 10:38:07 server id 330607  end_log_pos 3680 CRC32 0xb8d5bd6a 	Query	thread_id=7514	exec_time=0	error_code=0
SET TIMESTAMP=1614307087/*!*/;
DROP TABLE `table_webdata_roomcardsortclub` /* generated by server */
/*!*/;
# at 3680
#210226 10:38:07 server id 330607  end_log_pos 3745 CRC32 0x56f1abb1 	GTID	last_committed=13	sequence_number=14	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:526'/*!*/;
# at 3745
#210226 10:38:07 server id 330607  end_log_pos 3890 CRC32 0x4b3882c0 	Query	thread_id=7514	exec_time=0	error_code=0
SET TIMESTAMP=1614307087/*!*/;
DROP TABLE `table_webdata_roomcardsortuser` /* generated by server */
/*!*/;
# at 3890
#210226 10:40:28 server id 330607  end_log_pos 3955 CRC32 0x63eec045 	GTID	last_committed=14	sequence_number=15	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:527'/*!*/;
# at 3955
#210226 10:40:28 server id 330607  end_log_pos 4298 CRC32 0x529ba4db 	Query	thread_id=7521	exec_time=0	error_code=0
SET TIMESTAMP=1614307228/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE `t1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_age` (`age`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4
/*!*/;
# at 4298
#210226 10:40:35 server id 330607  end_log_pos 4363 CRC32 0x15a28499 	GTID	last_committed=15	sequence_number=16	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:528'/*!*/;
# at 4363
#210226 10:40:35 server id 330607  end_log_pos 4436 CRC32 0x231fb101 	Query	thread_id=7522	exec_time=0	error_code=0
SET TIMESTAMP=1614307235/*!*/;
BEGIN
/*!*/;
# at 4436
#210226 10:40:35 server id 330607  end_log_pos 4485 CRC32 0x54b30f3e 	Table_map: `yldbs`.`t1` mapped to number 47835
# at 4485
#210226 10:40:35 server id 330607  end_log_pos 4533 CRC32 0xa1c05af2 	Write_rows: table id 47835 flags: STMT_END_F
### INSERT INTO `yldbs`.`t1`
### SET
###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1614307235 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 4533
#210226 10:40:35 server id 330607  end_log_pos 4564 CRC32 0x43891acc 	Xid = 35073
COMMIT/*!*/;
# at 4564
#210301 10:00:00 server id 330607  end_log_pos 4629 CRC32 0x6c10b109 	GTID	last_committed=16	sequence_number=17	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:529'/*!*/;
# at 4629
#210301 10:00:00 server id 330607  end_log_pos 6700 CRC32 0x26c4520c 	Query	thread_id=13182	exec_time=1	error_code=0
use `niuniuh5_db`/*!*/;
SET TIMESTAMP=1614564000/*!*/;
SET @@session.sql_auto_is_null=1/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210401 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1871800000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 6700
#210301 10:00:01 server id 330607  end_log_pos 6765 CRC32 0x1584ab93 	GTID	last_committed=17	sequence_number=18	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:530'/*!*/;
# at 6765
#210301 10:00:01 server id 330607  end_log_pos 9138 CRC32 0xb0985974 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564001/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210401 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1871800000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 9138
#210301 10:00:01 server id 330607  end_log_pos 9203 CRC32 0xadf2e5b8 	GTID	last_committed=18	sequence_number=19	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:531'/*!*/;
# at 9203
#210301 10:00:01 server id 330607  end_log_pos 11285 CRC32 0x353d0ef8 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564001/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210401 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1871800000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 11285
#210301 10:00:02 server id 330607  end_log_pos 11350 CRC32 0xb0e7ecb3 	GTID	last_committed=19	sequence_number=20	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:532'/*!*/;
# at 11350
#210301 10:00:02 server id 330607  end_log_pos 13421 CRC32 0xf57ab4b9 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564002/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210402 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1871900000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 13421
#210301 10:00:02 server id 330607  end_log_pos 13486 CRC32 0xcd4d5c55 	GTID	last_committed=20	sequence_number=21	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:533'/*!*/;
# at 13486
#210301 10:00:02 server id 330607  end_log_pos 15859 CRC32 0x7d0f4272 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564002/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210402 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1871900000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 15859
#210301 10:00:02 server id 330607  end_log_pos 15924 CRC32 0x0efa43dd 	GTID	last_committed=21	sequence_number=22	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:534'/*!*/;
# at 15924
#210301 10:00:02 server id 330607  end_log_pos 18006 CRC32 0x2bb78460 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564002/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210402 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1871900000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 18006
#210301 10:00:03 server id 330607  end_log_pos 18071 CRC32 0x6d239333 	GTID	last_committed=22	sequence_number=23	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:535'/*!*/;
# at 18071
#210301 10:00:03 server id 330607  end_log_pos 20142 CRC32 0x5c286b9b 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564003/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210403 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872000000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 20142
#210301 10:00:03 server id 330607  end_log_pos 20207 CRC32 0xe9630895 	GTID	last_committed=23	sequence_number=24	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:536'/*!*/;
# at 20207
#210301 10:00:03 server id 330607  end_log_pos 22580 CRC32 0xbaf8fe1f 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564003/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210403 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872000000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 22580
#210301 10:00:03 server id 330607  end_log_pos 22645 CRC32 0x7a8f15fc 	GTID	last_committed=24	sequence_number=25	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:537'/*!*/;
# at 22645
#210301 10:00:03 server id 330607  end_log_pos 24727 CRC32 0x258a12b9 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564003/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210403 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872000000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 24727
#210301 10:00:04 server id 330607  end_log_pos 24792 CRC32 0xa4a7c7af 	GTID	last_committed=25	sequence_number=26	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:538'/*!*/;
# at 24792
#210301 10:00:04 server id 330607  end_log_pos 26863 CRC32 0x43070d43 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564004/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210404 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872100000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 26863
#210301 10:00:04 server id 330607  end_log_pos 26928 CRC32 0x289c58fc 	GTID	last_committed=26	sequence_number=27	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:539'/*!*/;
# at 26928
#210301 10:00:04 server id 330607  end_log_pos 29301 CRC32 0x5b9143b8 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564004/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210404 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872100000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 29301
#210301 10:00:04 server id 330607  end_log_pos 29366 CRC32 0x7145b396 	GTID	last_committed=27	sequence_number=28	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:540'/*!*/;
# at 29366
#210301 10:00:04 server id 330607  end_log_pos 31448 CRC32 0x324946f7 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564004/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210404 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872100000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 31448
#210301 10:00:05 server id 330607  end_log_pos 31513 CRC32 0x8815a820 	GTID	last_committed=28	sequence_number=29	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:541'/*!*/;
# at 31513
#210301 10:00:05 server id 330607  end_log_pos 33584 CRC32 0x81f30856 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564005/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210405 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872200000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 33584
#210301 10:00:05 server id 330607  end_log_pos 33649 CRC32 0xd4142f45 	GTID	last_committed=29	sequence_number=30	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:542'/*!*/;
# at 33649
#210301 10:00:05 server id 330607  end_log_pos 36022 CRC32 0x6e27913d 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564005/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210405 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872200000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 36022
#210301 10:00:05 server id 330607  end_log_pos 36087 CRC32 0xf86906ad 	GTID	last_committed=30	sequence_number=31	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:543'/*!*/;
# at 36087
#210301 10:00:05 server id 330607  end_log_pos 38169 CRC32 0x7c005a12 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564005/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210405 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872200000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 38169
#210301 10:00:06 server id 330607  end_log_pos 38234 CRC32 0xccda49c0 	GTID	last_committed=31	sequence_number=32	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:544'/*!*/;
# at 38234
#210301 10:00:06 server id 330607  end_log_pos 40305 CRC32 0x29a6d038 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564006/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210406 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872300000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 40305
#210301 10:00:06 server id 330607  end_log_pos 40370 CRC32 0x7fa24bdd 	GTID	last_committed=32	sequence_number=33	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:545'/*!*/;
# at 40370
#210301 10:00:06 server id 330607  end_log_pos 42743 CRC32 0x00b4ff5a 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564006/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210406 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872300000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 42743
#210301 10:00:06 server id 330607  end_log_pos 42808 CRC32 0xb2876e28 	GTID	last_committed=33	sequence_number=34	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:546'/*!*/;
# at 42808
#210301 10:00:06 server id 330607  end_log_pos 44890 CRC32 0x713ec610 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564006/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210406 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872300000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 44890
#210301 10:00:07 server id 330607  end_log_pos 44955 CRC32 0x36a6e1ad 	GTID	last_committed=34	sequence_number=35	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:547'/*!*/;
# at 44955
#210301 10:00:07 server id 330607  end_log_pos 47026 CRC32 0xe11d45e3 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564007/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210407 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872400000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 47026
#210301 10:00:07 server id 330607  end_log_pos 47091 CRC32 0x01d19a5e 	GTID	last_committed=35	sequence_number=36	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:548'/*!*/;
# at 47091
#210301 10:00:07 server id 330607  end_log_pos 49464 CRC32 0xfb226cdb 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564007/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210407 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872400000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 49464
#210301 10:00:07 server id 330607  end_log_pos 49529 CRC32 0x4a0f2f44 	GTID	last_committed=36	sequence_number=37	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:549'/*!*/;
# at 49529
#210301 10:00:07 server id 330607  end_log_pos 51611 CRC32 0xf78119d6 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564007/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210407 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872400000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 51611
#210301 10:00:08 server id 330607  end_log_pos 51676 CRC32 0x993f03f3 	GTID	last_committed=37	sequence_number=38	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:550'/*!*/;
# at 51676
#210301 10:00:08 server id 330607  end_log_pos 53747 CRC32 0xa6a76d62 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564008/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210408 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872500000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 53747
#210301 10:00:08 server id 330607  end_log_pos 53812 CRC32 0xe6d3237f 	GTID	last_committed=38	sequence_number=39	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:551'/*!*/;
# at 53812
#210301 10:00:08 server id 330607  end_log_pos 56185 CRC32 0x3036a91b 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564008/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210408 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872500000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 56185
#210301 10:00:08 server id 330607  end_log_pos 56250 CRC32 0x85cd9f69 	GTID	last_committed=39	sequence_number=40	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:552'/*!*/;
# at 56250
#210301 10:00:08 server id 330607  end_log_pos 58332 CRC32 0xafee7731 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564008/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210408 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872500000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 58332
#210301 10:00:09 server id 330607  end_log_pos 58397 CRC32 0xf679bd11 	GTID	last_committed=40	sequence_number=41	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:553'/*!*/;
# at 58397
#210301 10:00:09 server id 330607  end_log_pos 60468 CRC32 0xe622d58f 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564009/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210409 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872600000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 60468
#210301 10:00:09 server id 330607  end_log_pos 60533 CRC32 0x9fdc2bf6 	GTID	last_committed=41	sequence_number=42	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:554'/*!*/;
# at 60533
#210301 10:00:09 server id 330607  end_log_pos 62906 CRC32 0xe402a4d9 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564009/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210409 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872600000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 62906
#210301 10:00:09 server id 330607  end_log_pos 62971 CRC32 0x081df6b5 	GTID	last_committed=42	sequence_number=43	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:555'/*!*/;
# at 62971
#210301 10:00:09 server id 330607  end_log_pos 65053 CRC32 0xb0845841 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564009/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210409 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872600000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 65053
#210301 10:00:10 server id 330607  end_log_pos 65118 CRC32 0x6b9dd46b 	GTID	last_committed=43	sequence_number=44	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:556'/*!*/;
# at 65118
#210301 10:00:10 server id 330607  end_log_pos 67189 CRC32 0xf5b39b53 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564010/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210410 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872700000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 67189
#210301 10:00:10 server id 330607  end_log_pos 67254 CRC32 0x108386cb 	GTID	last_committed=44	sequence_number=45	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:557'/*!*/;
# at 67254
#210301 10:00:10 server id 330607  end_log_pos 69627 CRC32 0x194aa17b 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564010/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210410 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872700000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 69627
#210301 10:00:10 server id 330607  end_log_pos 69692 CRC32 0x1c528d6b 	GTID	last_committed=45	sequence_number=46	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:558'/*!*/;
# at 69692
#210301 10:00:10 server id 330607  end_log_pos 71774 CRC32 0xe427873e 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564010/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210410 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872700000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 71774
#210301 10:00:11 server id 330607  end_log_pos 71839 CRC32 0x987302ee 	GTID	last_committed=46	sequence_number=47	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:559'/*!*/;
# at 71839
#210301 10:00:11 server id 330607  end_log_pos 73910 CRC32 0xbf83a440 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564011/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210411 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872800000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 73910
#210301 10:00:11 server id 330607  end_log_pos 73975 CRC32 0x360db570 	GTID	last_committed=47	sequence_number=48	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:560'/*!*/;
# at 73975
#210301 10:00:11 server id 330607  end_log_pos 76348 CRC32 0x492d7bc7 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564011/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210411 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872800000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 76348
#210301 10:00:11 server id 330607  end_log_pos 76413 CRC32 0x8ca082af 	GTID	last_committed=48	sequence_number=49	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:561'/*!*/;
# at 76413
#210301 10:00:11 server id 330607  end_log_pos 78495 CRC32 0xa2af9bb6 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564011/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210411 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872800000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 78495
#210301 10:00:12 server id 330607  end_log_pos 78560 CRC32 0xa6c64110 	GTID	last_committed=49	sequence_number=50	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:562'/*!*/;
# at 78560
#210301 10:00:12 server id 330607  end_log_pos 80631 CRC32 0x30c04159 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564012/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210412 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872900000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 80631
#210301 10:00:12 server id 330607  end_log_pos 80696 CRC32 0x9cf89d85 	GTID	last_committed=50	sequence_number=51	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:563'/*!*/;
# at 80696
#210301 10:00:12 server id 330607  end_log_pos 83069 CRC32 0x87e8be49 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564012/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210412 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872900000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 83069
#210301 10:00:12 server id 330607  end_log_pos 83134 CRC32 0x7d69ab44 	GTID	last_committed=51	sequence_number=52	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:564'/*!*/;
# at 83134
#210301 10:00:12 server id 330607  end_log_pos 85216 CRC32 0x028e2ab3 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564012/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210412 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1872900000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 85216
#210301 10:00:13 server id 330607  end_log_pos 85281 CRC32 0x323cf334 	GTID	last_committed=52	sequence_number=53	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:565'/*!*/;
# at 85281
#210301 10:00:13 server id 330607  end_log_pos 87352 CRC32 0x7f5c3911 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564013/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210413 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873000000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 87352
#210301 10:00:13 server id 330607  end_log_pos 87417 CRC32 0xccb98f00 	GTID	last_committed=53	sequence_number=54	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:566'/*!*/;
# at 87417
#210301 10:00:13 server id 330607  end_log_pos 89790 CRC32 0x59fcc13e 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564013/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210413 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873000000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 89790
#210301 10:00:13 server id 330607  end_log_pos 89855 CRC32 0x9e518d3d 	GTID	last_committed=54	sequence_number=55	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:567'/*!*/;
# at 89855
#210301 10:00:13 server id 330607  end_log_pos 91937 CRC32 0xe58da7ad 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564013/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210413 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873000000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 91937
#210301 10:00:14 server id 330607  end_log_pos 92002 CRC32 0x3358e973 	GTID	last_committed=55	sequence_number=56	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:568'/*!*/;
# at 92002
#210301 10:00:14 server id 330607  end_log_pos 94073 CRC32 0x31edf804 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564014/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210414 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873100000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 94073
#210301 10:00:14 server id 330607  end_log_pos 94138 CRC32 0xc73ded4b 	GTID	last_committed=56	sequence_number=57	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:569'/*!*/;
# at 94138
#210301 10:00:14 server id 330607  end_log_pos 96511 CRC32 0x87c45708 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564014/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210414 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873100000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 96511
#210301 10:00:14 server id 330607  end_log_pos 96576 CRC32 0x116ba664 	GTID	last_committed=57	sequence_number=58	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:570'/*!*/;
# at 96576
#210301 10:00:14 server id 330607  end_log_pos 98658 CRC32 0x6ef92a5f 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564014/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210414 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873100000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 98658
#210301 10:00:15 server id 330607  end_log_pos 98723 CRC32 0xcc6c3b2a 	GTID	last_committed=58	sequence_number=59	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:571'/*!*/;
# at 98723
#210301 10:00:15 server id 330607  end_log_pos 100794 CRC32 0x71eb893a 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564015/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210415 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873200000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 100794
#210301 10:00:15 server id 330607  end_log_pos 100859 CRC32 0x6c3baa0a 	GTID	last_committed=59	sequence_number=60	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:572'/*!*/;
# at 100859
#210301 10:00:15 server id 330607  end_log_pos 103232 CRC32 0xff449ea3 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564015/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210415 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873200000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 103232
#210301 10:00:16 server id 330607  end_log_pos 103297 CRC32 0x228f997e 	GTID	last_committed=60	sequence_number=61	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:573'/*!*/;
# at 103297
#210301 10:00:16 server id 330607  end_log_pos 105379 CRC32 0xd94a9153 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564016/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210415 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873200000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 105379
#210301 10:00:16 server id 330607  end_log_pos 105444 CRC32 0xb6a23094 	GTID	last_committed=61	sequence_number=62	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:574'/*!*/;
# at 105444
#210301 10:00:16 server id 330607  end_log_pos 107515 CRC32 0xb7454cdf 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564016/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210416 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873300000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 107515
#210301 10:00:16 server id 330607  end_log_pos 107580 CRC32 0x43952a21 	GTID	last_committed=62	sequence_number=63	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:575'/*!*/;
# at 107580
#210301 10:00:16 server id 330607  end_log_pos 109953 CRC32 0xdb9cbd34 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564016/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210416 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873300000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 109953
#210301 10:00:17 server id 330607  end_log_pos 110018 CRC32 0x7885f85c 	GTID	last_committed=63	sequence_number=64	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:576'/*!*/;
# at 110018
#210301 10:00:17 server id 330607  end_log_pos 112100 CRC32 0xa0d72bd1 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564017/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210416 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873300000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 112100
#210301 10:00:17 server id 330607  end_log_pos 112165 CRC32 0xf9c65eb4 	GTID	last_committed=64	sequence_number=65	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:577'/*!*/;
# at 112165
#210301 10:00:17 server id 330607  end_log_pos 114236 CRC32 0x6a0ed740 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564017/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210417 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873400000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 114236
#210301 10:00:18 server id 330607  end_log_pos 114301 CRC32 0xa0315cd4 	GTID	last_committed=65	sequence_number=66	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:578'/*!*/;
# at 114301
#210301 10:00:18 server id 330607  end_log_pos 116674 CRC32 0x273ad3c7 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564018/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210417 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873400000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 116674
#210301 10:00:18 server id 330607  end_log_pos 116739 CRC32 0xca9a5024 	GTID	last_committed=66	sequence_number=67	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:579'/*!*/;
# at 116739
#210301 10:00:18 server id 330607  end_log_pos 118821 CRC32 0xcafe78a2 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564018/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210417 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873400000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 118821
#210301 10:00:18 server id 330607  end_log_pos 118886 CRC32 0x006514da 	GTID	last_committed=67	sequence_number=68	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:580'/*!*/;
# at 118886
#210301 10:00:18 server id 330607  end_log_pos 120957 CRC32 0x7fcaf505 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564018/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210418 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873500000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 120957
#210301 10:00:19 server id 330607  end_log_pos 121022 CRC32 0xfadec292 	GTID	last_committed=68	sequence_number=69	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:581'/*!*/;
# at 121022
#210301 10:00:19 server id 330607  end_log_pos 123395 CRC32 0xaa1b1b8f 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564019/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210418 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873500000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 123395
#210301 10:00:19 server id 330607  end_log_pos 123460 CRC32 0xed7ca7e8 	GTID	last_committed=69	sequence_number=70	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:582'/*!*/;
# at 123460
#210301 10:00:19 server id 330607  end_log_pos 125542 CRC32 0x074011cc 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564019/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210418 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873500000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 125542
#210301 10:00:19 server id 330607  end_log_pos 125607 CRC32 0x7812661b 	GTID	last_committed=70	sequence_number=71	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:583'/*!*/;
# at 125607
#210301 10:00:19 server id 330607  end_log_pos 127678 CRC32 0x062e1034 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564019/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210419 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873600000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 127678
#210301 10:00:20 server id 330607  end_log_pos 127743 CRC32 0xac9d33d0 	GTID	last_committed=71	sequence_number=72	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:584'/*!*/;
# at 127743
#210301 10:00:20 server id 330607  end_log_pos 130116 CRC32 0xa1d20300 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564020/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210419 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873600000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 130116
#210301 10:00:21 server id 330607  end_log_pos 130181 CRC32 0xf0cc1a66 	GTID	last_committed=72	sequence_number=73	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:585'/*!*/;
# at 130181
#210301 10:00:21 server id 330607  end_log_pos 132263 CRC32 0x2bf32fcc 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564021/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210419 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873600000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 132263
#210301 10:00:21 server id 330607  end_log_pos 132328 CRC32 0xe7e16e1a 	GTID	last_committed=73	sequence_number=74	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:586'/*!*/;
# at 132328
#210301 10:00:21 server id 330607  end_log_pos 134399 CRC32 0xff9215ab 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564021/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210420 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873700000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 134399
#210301 10:00:21 server id 330607  end_log_pos 134464 CRC32 0x0758f200 	GTID	last_committed=74	sequence_number=75	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:587'/*!*/;
# at 134464
#210301 10:00:21 server id 330607  end_log_pos 136837 CRC32 0x1f684c0f 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564021/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210420 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873700000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 136837
#210301 10:00:22 server id 330607  end_log_pos 136902 CRC32 0xd8d6ce2b 	GTID	last_committed=75	sequence_number=76	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:588'/*!*/;
# at 136902
#210301 10:00:22 server id 330607  end_log_pos 138984 CRC32 0x9b57ba5c 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564022/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210420 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873700000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 138984
#210301 10:00:22 server id 330607  end_log_pos 139049 CRC32 0x30c99beb 	GTID	last_committed=76	sequence_number=77	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:589'/*!*/;
# at 139049
#210301 10:00:22 server id 330607  end_log_pos 141120 CRC32 0x80b1ea6d 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564022/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210421 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873800000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 141120
#210301 10:00:23 server id 330607  end_log_pos 141185 CRC32 0xf249bed7 	GTID	last_committed=77	sequence_number=78	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:590'/*!*/;
# at 141185
#210301 10:00:23 server id 330607  end_log_pos 143558 CRC32 0x5fe49eb5 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564023/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210421 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873800000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 143558
#210301 10:00:23 server id 330607  end_log_pos 143623 CRC32 0x6b4262e5 	GTID	last_committed=78	sequence_number=79	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:591'/*!*/;
# at 143623
#210301 10:00:23 server id 330607  end_log_pos 145705 CRC32 0x81c0a454 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564023/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210421 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873800000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 145705
#210301 10:00:23 server id 330607  end_log_pos 145770 CRC32 0x6d2471e8 	GTID	last_committed=79	sequence_number=80	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:592'/*!*/;
# at 145770
#210301 10:00:23 server id 330607  end_log_pos 147841 CRC32 0x923054cf 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564023/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210422 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873900000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 147841
#210301 10:00:24 server id 330607  end_log_pos 147906 CRC32 0xb082d42c 	GTID	last_committed=80	sequence_number=81	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:593'/*!*/;
# at 147906
#210301 10:00:24 server id 330607  end_log_pos 150279 CRC32 0x182b0731 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564024/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210422 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873900000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 150279
#210301 10:00:24 server id 330607  end_log_pos 150344 CRC32 0x1ec90ae6 	GTID	last_committed=81	sequence_number=82	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:594'/*!*/;
# at 150344
#210301 10:00:24 server id 330607  end_log_pos 152426 CRC32 0xb67a0d0b 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564024/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210422 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1873900000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 152426
#210301 10:00:25 server id 330607  end_log_pos 152491 CRC32 0xd74f2f3f 	GTID	last_committed=82	sequence_number=83	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:595'/*!*/;
# at 152491
#210301 10:00:25 server id 330607  end_log_pos 154562 CRC32 0xe95b5726 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564025/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210423 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874000000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 154562
#210301 10:00:25 server id 330607  end_log_pos 154627 CRC32 0xb185ce78 	GTID	last_committed=83	sequence_number=84	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:596'/*!*/;
# at 154627
#210301 10:00:25 server id 330607  end_log_pos 157000 CRC32 0xd6f814c5 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564025/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210423 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874000000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 157000
#210301 10:00:26 server id 330607  end_log_pos 157065 CRC32 0xc0ae69a7 	GTID	last_committed=84	sequence_number=85	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:597'/*!*/;
# at 157065
#210301 10:00:26 server id 330607  end_log_pos 159147 CRC32 0xf2266430 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564026/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210423 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874000000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 159147
#210301 10:00:26 server id 330607  end_log_pos 159212 CRC32 0x5483c04d 	GTID	last_committed=85	sequence_number=86	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:598'/*!*/;
# at 159212
#210301 10:00:26 server id 330607  end_log_pos 161283 CRC32 0xdd410ad2 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564026/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210424 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874100000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 161283
#210301 10:00:26 server id 330607  end_log_pos 161348 CRC32 0x47ede388 	GTID	last_committed=86	sequence_number=87	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:599'/*!*/;
# at 161348
#210301 10:00:26 server id 330607  end_log_pos 163721 CRC32 0x998af9fc 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564026/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210424 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874100000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 163721
#210301 10:00:27 server id 330607  end_log_pos 163786 CRC32 0x593e12a1 	GTID	last_committed=87	sequence_number=88	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:600'/*!*/;
# at 163786
#210301 10:00:27 server id 330607  end_log_pos 165868 CRC32 0xd1eecb25 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564027/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210424 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874100000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 165868
#210301 10:00:27 server id 330607  end_log_pos 165933 CRC32 0x9025c3b8 	GTID	last_committed=88	sequence_number=89	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:601'/*!*/;
# at 165933
#210301 10:00:27 server id 330607  end_log_pos 168004 CRC32 0x4402cf11 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564027/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210425 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874200000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 168004
#210301 10:00:28 server id 330607  end_log_pos 168069 CRC32 0xc7301c6d 	GTID	last_committed=89	sequence_number=90	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:602'/*!*/;
# at 168069
#210301 10:00:28 server id 330607  end_log_pos 170442 CRC32 0x64ec4709 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564028/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210425 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874200000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 170442
#210301 10:00:28 server id 330607  end_log_pos 170507 CRC32 0xca5f7594 	GTID	last_committed=90	sequence_number=91	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:603'/*!*/;
# at 170507
#210301 10:00:28 server id 330607  end_log_pos 172589 CRC32 0xa97b7ecf 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564028/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210425 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874200000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 172589
#210301 10:00:29 server id 330607  end_log_pos 172654 CRC32 0x3f262e7f 	GTID	last_committed=91	sequence_number=92	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:604'/*!*/;
# at 172654
#210301 10:00:29 server id 330607  end_log_pos 174725 CRC32 0xa4cf1e3e 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564029/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210426 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874300000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 174725
#210301 10:00:29 server id 330607  end_log_pos 174790 CRC32 0x62d7f587 	GTID	last_committed=92	sequence_number=93	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:605'/*!*/;
# at 174790
#210301 10:00:29 server id 330607  end_log_pos 177163 CRC32 0x6871d0a6 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564029/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210426 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874300000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 177163
#210301 10:00:30 server id 330607  end_log_pos 177228 CRC32 0x157b7ecc 	GTID	last_committed=93	sequence_number=94	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:606'/*!*/;
# at 177228
#210301 10:00:30 server id 330607  end_log_pos 179310 CRC32 0xe8f0a83d 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564030/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210426 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874300000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 179310
#210301 10:00:30 server id 330607  end_log_pos 179375 CRC32 0x8015bf3f 	GTID	last_committed=94	sequence_number=95	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:607'/*!*/;
# at 179375
#210301 10:00:30 server id 330607  end_log_pos 181446 CRC32 0x9a7ae0c0 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564030/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210427 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874400000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 181446
#210301 10:00:30 server id 330607  end_log_pos 181511 CRC32 0x3f5a8ec1 	GTID	last_committed=95	sequence_number=96	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:608'/*!*/;
# at 181511
#210301 10:00:30 server id 330607  end_log_pos 183884 CRC32 0xf6f84740 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564030/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210427 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874400000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 183884
#210301 10:00:31 server id 330607  end_log_pos 183949 CRC32 0x867c8439 	GTID	last_committed=96	sequence_number=97	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:609'/*!*/;
# at 183949
#210301 10:00:31 server id 330607  end_log_pos 186031 CRC32 0x5b9d73e3 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564031/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210427 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874400000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 186031
#210301 10:00:32 server id 330607  end_log_pos 186096 CRC32 0x3b7ddded 	GTID	last_committed=97	sequence_number=98	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:610'/*!*/;
# at 186096
#210301 10:00:32 server id 330607  end_log_pos 188167 CRC32 0x582714a6 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564032/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210428 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874500000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 188167
#210301 10:00:32 server id 330607  end_log_pos 188232 CRC32 0xb63880b5 	GTID	last_committed=98	sequence_number=99	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:611'/*!*/;
# at 188232
#210301 10:00:32 server id 330607  end_log_pos 190605 CRC32 0xecc14997 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564032/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210428 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874500000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 190605
#210301 10:00:33 server id 330607  end_log_pos 190670 CRC32 0x53d808b5 	GTID	last_committed=99	sequence_number=100	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:612'/*!*/;
# at 190670
#210301 10:00:33 server id 330607  end_log_pos 192752 CRC32 0x6482d651 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564033/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210428 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874500000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 192752
#210301 10:00:33 server id 330607  end_log_pos 192817 CRC32 0xf71e3522 	GTID	last_committed=100	sequence_number=101	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:613'/*!*/;
# at 192817
#210301 10:00:33 server id 330607  end_log_pos 194888 CRC32 0xda83b9cf 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564033/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210429 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874600000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 194888
#210301 10:00:34 server id 330607  end_log_pos 194953 CRC32 0xc096b01d 	GTID	last_committed=101	sequence_number=102	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:614'/*!*/;
# at 194953
#210301 10:00:34 server id 330607  end_log_pos 197326 CRC32 0x3d05bb2b 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564034/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210429 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874600000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 197326
#210301 10:00:34 server id 330607  end_log_pos 197391 CRC32 0xb16a3354 	GTID	last_committed=102	sequence_number=103	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:615'/*!*/;
# at 197391
#210301 10:00:34 server id 330607  end_log_pos 199473 CRC32 0x5cf51426 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564034/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210429 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874600000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 199473
#210301 10:00:35 server id 330607  end_log_pos 199538 CRC32 0x8391ba61 	GTID	last_committed=103	sequence_number=104	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:616'/*!*/;
# at 199538
#210301 10:00:35 server id 330607  end_log_pos 201609 CRC32 0x1082e57d 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564035/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clublogscore20210430 (
		  `ID` bigint(20) unsigned NOT NULL  AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874700000000 DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log表'
/*!*/;
# at 201609
#210301 10:00:35 server id 330607  end_log_pos 201674 CRC32 0xe1aa9681 	GTID	last_committed=104	sequence_number=105	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:617'/*!*/;
# at 201674
#210301 10:00:35 server id 330607  end_log_pos 204047 CRC32 0x758d733b 	Query	thread_id=13182	exec_time=1	error_code=0
SET TIMESTAMP=1614564035/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_clubgamescoredetail20210430 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '座位号',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  `nRound` int(11) NOT NULL COMMENT '当前局数',
		  `nBaseScore` int(11) NOT NULL COMMENT '底分',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  `szCardData` varchar(256) DEFAULT NULL COMMENT '牌型详情',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '成绩中积分部分',
		  `nPlayerScore` bigint(20) DEFAULT '0' COMMENT '剩余分数(扣税后)',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额',
		  `nGameType` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1代表牛牛，2代表三公...',
		  `nServerID` int(11) DEFAULT '0' COMMENT '新手场,初，中，高等',
		  `nCardData` varchar(256) NOT NULL DEFAULT '' COMMENT '玩家的手牌',
		  `nBankID` int(11) NOT NULL DEFAULT '0' COMMENT '庄家id',
		  `szExtChar` text COMMENT '扩展字串（Json）用于差异化',
		  `CardData` text COMMENT '牌局详情',
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(28)),
		  KEY `idx_tEndTime` (`tEndTime`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
		  KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
		  KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874700000000 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部6人房模式牌局明细表（每小局结束时写入）'
/*!*/;
# at 204047
#210301 10:00:36 server id 330607  end_log_pos 204112 CRC32 0xf69b4720 	GTID	last_committed=105	sequence_number=106	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:618'/*!*/;
# at 204112
#210301 10:00:36 server id 330607  end_log_pos 206194 CRC32 0x036ff9dc 	Query	thread_id=13182	exec_time=0	error_code=0
SET TIMESTAMP=1614564036/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE table_third_score_detail20210430 (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `DataType` int(11) NOT NULL COMMENT '数据类型:1-战绩,2-任务完成记录,3-返利',
		  `SubDataType` int(11) NOT NULL COMMENT '当为任务完成记录时是做为任务ID',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
		  `nChairID` int(11) DEFAULT '0' COMMENT '椅子ID',
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round-chair (把椅子ID加上去) 为空时生成：俱乐部ID-时间秒数-3位随机数',
		  `Accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号(从member表中获得)',
		  `nPlayCount` tinyint(4) NOT NULL COMMENT '本局参与人数',
		  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nEnterScore` bigint(20) DEFAULT '0' COMMENT '带入分数:为进房时的分数',
		  `nBetScore` int(11) DEFAULT '0' COMMENT '下注',
		  `nValidBet` int(11) DEFAULT '0' COMMENT '有效投注',
		  `nResultMoney` int(11) DEFAULT '0' COMMENT '盈利,',
		  `nTax` int(11) DEFAULT '0' COMMENT '扣税额, 任务的资讯积分',
		  `nGameType` tinyint(4) NOT NULL COMMENT '游戏ID',
		  `nServerID` int(11) DEFAULT '0' COMMENT '服务器ID',
		  `CardData` text COMMENT '牌局详情:对局类游戏时记录公共牌信息，每个人的牌信息，方便后台显示。任务的Mask',
		  `LineCode` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家站点信息，用于内部区分',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_tEndTime` (`nClubID`,`tEndTime`),
		  KEY `idx_szToken` (`szToken`)
		) ENGINE=InnoDB AUTO_INCREMENT=1874700000000 DEFAULT CHARSET=utf8mb4 COMMENT='针对第三方的积分战绩明细表（包含战绩和任务完成数据）'
/*!*/;
# at 206194
#210301 10:27:42 server id 330607  end_log_pos 206259 CRC32 0x4c9703be 	GTID	last_committed=106	sequence_number=107	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:619'/*!*/;
# at 206259
#210301 10:27:42 server id 330607  end_log_pos 206632 CRC32 0xee087531 	Query	thread_id=13224	exec_time=0	error_code=0
use `test_db`/*!*/;
SET TIMESTAMP=1614565662/*!*/;
SET @@session.sql_auto_is_null=0/*!*/;
SET @@session.sql_mode=1076363264/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=45,@@session.collation_connection=45,@@session.collation_server=45/*!*/;
SET @@session.explicit_defaults_for_timestamp=1/*!*/;
CREATE TABLE `test_db`.`_t1_new` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_age` (`age`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4
/*!*/;
# at 206632
#210301 10:27:42 server id 330607  end_log_pos 206697 CRC32 0x617f0cd4 	GTID	last_committed=107	sequence_number=108	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:620'/*!*/;
# at 206697
#210301 10:27:42 server id 330607  end_log_pos 206874 CRC32 0xbde750dd 	Query	thread_id=13224	exec_time=1	error_code=0
SET TIMESTAMP=1614565662/*!*/;
ALTER TABLE `test_db`.`_t1_new` add column filed_02 int(10) not null default 0 comment 'filed_02'
/*!*/;
# at 206874
#210301 10:27:43 server id 330607  end_log_pos 206939 CRC32 0x7d38d2a0 	GTID	last_committed=108	sequence_number=109	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:621'/*!*/;
# at 206939
#210301 10:27:43 server id 330607  end_log_pos 207215 CRC32 0xe836640f 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565663.322423/*!*/;
CREATE DEFINER=`root`@`%` TRIGGER `pt_osc_test_db_t1_del` AFTER DELETE ON `test_db`.`t1` FOR EACH ROW DELETE IGNORE FROM `test_db`.`_t1_new` WHERE `test_db`.`_t1_new`.`id` <=> OLD.`id`
/*!*/;
# at 207215
#210301 10:27:43 server id 330607  end_log_pos 207280 CRC32 0x1f182b7e 	GTID	last_committed=109	sequence_number=110	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:622'/*!*/;
# at 207280
#210301 10:27:43 server id 330607  end_log_pos 207699 CRC32 0x81aa3446 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565663.443861/*!*/;
CREATE DEFINER=`root`@`%` TRIGGER `pt_osc_test_db_t1_upd` AFTER UPDATE ON `test_db`.`t1` FOR EACH ROW BEGIN DELETE IGNORE FROM `test_db`.`_t1_new` WHERE !(OLD.`id` <=> NEW.`id`) AND `test_db`.`_t1_new`.`id` <=> OLD.`id`;REPLACE INTO `test_db`.`_t1_new` (`id`, `age`, `tendtime`) VALUES (NEW.`id`, NEW.`age`, NEW.`tendtime`);END
/*!*/;
# at 207699
#210301 10:27:43 server id 330607  end_log_pos 207764 CRC32 0xa03d2822 	GTID	last_committed=110	sequence_number=111	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:623'/*!*/;
# at 207764
#210301 10:27:43 server id 330607  end_log_pos 208061 CRC32 0xca3e56de 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565663.569042/*!*/;
CREATE DEFINER=`root`@`%` TRIGGER `pt_osc_test_db_t1_ins` AFTER INSERT ON `test_db`.`t1` FOR EACH ROW REPLACE INTO `test_db`.`_t1_new` (`id`, `age`, `tendtime`) VALUES (NEW.`id`, NEW.`age`, NEW.`tendtime`)
/*!*/;
# at 208061
#210301 10:27:43 server id 330607  end_log_pos 208126 CRC32 0x8f435805 	GTID	last_committed=111	sequence_number=112	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:624'/*!*/;
# at 208126
#210301 10:27:43 server id 330607  end_log_pos 208201 CRC32 0xc5225a88 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565663/*!*/;
BEGIN
/*!*/;
# at 208201
#210301 10:27:43 server id 330607  end_log_pos 208258 CRC32 0x5d50438c 	Table_map: `test_db`.`_t1_new` mapped to number 72042
# at 208258
#210301 10:27:43 server id 330607  end_log_pos 208429 CRC32 0x30baf48d 	Write_rows: table id 72042 flags: STMT_END_F
### INSERT INTO `test_db`.`_t1_new`
### SET
###   @1=2 /* INT meta=0 nullable=0 is_null=0 */
###   @2=2 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1594621437 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
### INSERT INTO `test_db`.`_t1_new`
### SET
###   @1=3 /* INT meta=0 nullable=0 is_null=0 */
###   @2=3 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1594621440 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
### INSERT INTO `test_db`.`_t1_new`
### SET
###   @1=4 /* INT meta=0 nullable=0 is_null=0 */
###   @2=4 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1594621443 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
### INSERT INTO `test_db`.`_t1_new`
### SET
###   @1=5 /* INT meta=0 nullable=0 is_null=0 */
###   @2=5 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1594621445 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
### INSERT INTO `test_db`.`_t1_new`
### SET
###   @1=6 /* INT meta=0 nullable=0 is_null=0 */
###   @2=6 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1594621448 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
### INSERT INTO `test_db`.`_t1_new`
### SET
###   @1=7 /* INT meta=0 nullable=0 is_null=0 */
###   @2=7 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1594621451 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
### INSERT INTO `test_db`.`_t1_new`
### SET
###   @1=8 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1594622503 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
### INSERT INTO `test_db`.`_t1_new`
### SET
###   @1=10 /* INT meta=0 nullable=0 is_null=0 */
###   @2=1 /* INT meta=0 nullable=0 is_null=0 */
###   @3=1594622503 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
# at 208429
#210301 10:27:43 server id 330607  end_log_pos 208460 CRC32 0xccf0f7c6 	Xid = 62298
COMMIT/*!*/;
# at 208460
#210301 10:27:43 server id 330607  end_log_pos 208525 CRC32 0x613176fe 	GTID	last_committed=112	sequence_number=113	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:625'/*!*/;
# at 208525
#210301 10:27:43 server id 330607  end_log_pos 208658 CRC32 0x302fa288 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565663/*!*/;
ANALYZE TABLE `test_db`.`_t1_new` /* pt-online-schema-change */
/*!*/;
# at 208658
#210301 10:27:43 server id 330607  end_log_pos 208723 CRC32 0x7e62934a 	GTID	last_committed=113	sequence_number=114	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:626'/*!*/;
# at 208723
#210301 10:27:43 server id 330607  end_log_pos 208892 CRC32 0x9f5b1b09 	Query	thread_id=13224	exec_time=1	error_code=0
SET TIMESTAMP=1614565663/*!*/;
RENAME TABLE `test_db`.`t1` TO `test_db`.`_t1_old`, `test_db`.`_t1_new` TO `test_db`.`t1`
-- 原子操作
/*!*/;
# at 208892
#210301 10:27:44 server id 330607  end_log_pos 208957 CRC32 0xd1602d92 	GTID	last_committed=114	sequence_number=115	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:627'/*!*/;
# at 208957
#210301 10:27:44 server id 330607  end_log_pos 209093 CRC32 0x79c37fdb 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565664/*!*/;
DROP TABLE IF EXISTS `_t1_old` /* generated by server */
/*!*/;
# at 209093
#210301 10:27:44 server id 330607  end_log_pos 209158 CRC32 0x14cd54d4 	GTID	last_committed=115	sequence_number=116	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:628'/*!*/;
# at 209158
#210301 10:27:44 server id 330607  end_log_pos 209284 CRC32 0x8319d267 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565664/*!*/;
DROP TRIGGER IF EXISTS `test_db`.`pt_osc_test_db_t1_del`
/*!*/;
# at 209284
#210301 10:27:44 server id 330607  end_log_pos 209349 CRC32 0x73410c8e 	GTID	last_committed=116	sequence_number=117	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:629'/*!*/;
# at 209349
#210301 10:27:44 server id 330607  end_log_pos 209475 CRC32 0x4d77c24c 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565664/*!*/;
DROP TRIGGER IF EXISTS `test_db`.`pt_osc_test_db_t1_upd`
/*!*/;
# at 209475
#210301 10:27:44 server id 330607  end_log_pos 209540 CRC32 0x8cf3de95 	GTID	last_committed=117	sequence_number=118	rbr_only=no
SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:630'/*!*/;
# at 209540
#210301 10:27:44 server id 330607  end_log_pos 209666 CRC32 0x7627216f 	Query	thread_id=13224	exec_time=0	error_code=0
SET TIMESTAMP=1614565664/*!*/;
DROP TRIGGER IF EXISTS `test_db`.`pt_osc_test_db_t1_ins`
/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
