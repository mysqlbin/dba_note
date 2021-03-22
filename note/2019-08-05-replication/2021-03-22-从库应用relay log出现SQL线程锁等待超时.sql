


老系统所在的数据库出现下面的错误日志 
	2021-03-21 04:22:23 23322 [Warning] Slave SQL: Could not execute Write_rows event on table yldb.table_web_userzhangji; Lock wait timeout exceeded; try restarting transaction, Error_code: 1205; handler error HA_ERR_LOCK_WAIT_TIMEOUT; the event s master log mysql-bin.000769, end_log_pos 181629791, Error_code: 1205
	2021-03-21 04:22:44 23322 [Note] Event Scheduler: [root@%][yldb.totalTableLog] Data truncated for column 'Rate' at row 1
	2021-03-21 04:22:44 23322 [Note] Event Scheduler: [root@%][yldb.totalTableLog] Data truncated for column 'ARPU' at row 1

	2021-03-22 04:21:15 23322 [Warning] Slave SQL: Could not execute Write_rows event on table yldb.table_web_userzhangji;
	 Lock wait timeout exceeded; try restarting transaction, Error_code: 1205; 
	 handler error HA_ERR_LOCK_WAIT_TIMEOUT; 
	 the event s master log mysql-bin.000770, end_log_pos 75004569, Error_code: 1205
	2021-03-22 04:21:17 23322 [Note] Event Scheduler: [root@%][yldb.totalTableLog] Data truncated for column 'Rate' at row 1
	2021-03-22 04:21:17 23322 [Note] Event Scheduler: [root@%][yldb.totalTableLog] Data truncated for column 'ARPU' at row 1


CREATE TABLE `table_web_userzhangji` (
  `Idx` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '主键Id',
  `TableId` int(11) NOT NULL,
  `nPlayerID` int(11) NOT NULL,
  `szNickName` varchar(64) NOT NULL,
  `szStartTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `szEndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `nDiFen` int(11) NOT NULL,
  `jushu` int(11) NOT NULL,
  `fuju` int(11) NOT NULL,
  `fuType` varchar(64) NOT NULL,
  `fuFangShi` varchar(64) NOT NULL,
  `zhangjia` int(11) NOT NULL,
  `szPlayerId1` int(11) NOT NULL,
  `nArrow1` int(11) NOT NULL,
  `nScore1` int(11) NOT NULL,
  `szNickname1` varchar(64) NOT NULL,
  `szPlayerId2` int(11) NOT NULL,
  `nArrow2` int(11) NOT NULL,
  `nScore2` int(11) NOT NULL,
  `szNickName2` varchar(64) NOT NULL,
  `szPlayerId3` int(11) NOT NULL,
  `nArrorw3` int(11) NOT NULL,
  `nScore3` int(11) NOT NULL,
  `szNickName3` varchar(64) NOT NULL,
  `szPlayerId4` int(11) NOT NULL,
  `nArrow4` int(11) NOT NULL,
  `nScore4` int(11) NOT NULL,
  `szNickName4` varchar(64) NOT NULL,
  `minggan1` int(11) NOT NULL,
  `minggan2` int(11) NOT NULL,
  `minggan3` int(11) NOT NULL,
  `minggan4` int(11) NOT NULL,
  `angan1` int(11) NOT NULL,
  `angan2` int(11) NOT NULL,
  `angan3` int(11) NOT NULL,
  `angan4` int(11) NOT NULL,
  `totalJu` int(11) DEFAULT NULL,
  `nMyChairId` int(11) DEFAULT NULL,
  `szRecToken` varchar(64) DEFAULT NULL,
  `nRecShareID` int(11) DEFAULT NULL,
  `szPlayerId5` int(11) DEFAULT NULL,
  `nArrow5` int(11) DEFAULT NULL,
  `nScore5` int(11) DEFAULT NULL,
  `szNickname5` varchar(64) DEFAULT NULL,
  `szPlayerId6` int(11) DEFAULT NULL,
  `nArrow6` int(11) DEFAULT NULL,
  `nScore6` int(11) DEFAULT NULL,
  `szNickname6` varchar(64) DEFAULT NULL,
  `szPlayerId7` int(11) DEFAULT NULL,
  `nArrow7` int(11) DEFAULT NULL,
  `nScore7` int(11) DEFAULT NULL,
  `szNickname7` varchar(64) DEFAULT NULL,
  `szPlayerId8` int(11) DEFAULT NULL,
  `nArrow8` int(11) DEFAULT NULL,
  `nScore8` int(11) DEFAULT NULL,
  `szNickname8` varchar(32) DEFAULT NULL,
  `minggan5` int(11) DEFAULT NULL,
  `minggan6` int(11) DEFAULT NULL,
  `minggan7` int(11) DEFAULT NULL,
  `minggan8` int(11) DEFAULT NULL,
  `angan5` int(11) DEFAULT NULL,
  `angan6` int(11) DEFAULT NULL,
  `angan7` int(11) DEFAULT NULL,
  `angan8` int(11) DEFAULT NULL,
  `nGameId` int(11) DEFAULT NULL,
  KEY `idx_Table_Web_UserZHangJi` (`nPlayerID`,`TableId`,`szEndTime`),
  KEY `idx_szStartTime` (`szStartTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




declare _oldDiffDate VARCHAR(30) default CONCAT(date_sub(CURDATE(),interval 1 day),' 00:00:00');

	root@mysqldb 15:37:  [yldb]> select CONCAT(date_sub(CURDATE(),interval 1 day),' 00:00:00');
	+--------------------------------------------------------+
	| CONCAT(date_sub(CURDATE(),interval 1 day),' 00:00:00') |
	+--------------------------------------------------------+
	| 2021-03-21 00:00:00                                    |
	+--------------------------------------------------------+
	1 row in set (0.00 sec)


declare _curDiffDate VARCHAR(30) default CONCAT(CURDATE(),' 00:00:00');
	root@mysqldb 15:39:  [yldb]> select CONCAT(CURDATE(),' 00:00:00');
	+-------------------------------+
	| CONCAT(CURDATE(),' 00:00:00') |
	+-------------------------------+
	| 2021-03-22 00:00:00           |
	+-------------------------------+
	1 row in set (0.00 sec)




定时器触发的语句
	在从库执行，每天的 04:20 执行一次。
	CREATE DEFINER=`root`@`%` EVENT `totalTableLog` ON SCHEDULE EVERY 1 DAY STARTS '2018-01-15 04:20:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL Pr_totalTableLog()

	insert into EffectiveNumber_DayLog
	(
	 Sum,MnnSum,MylSum,MslSum,MhxSum,MggSum,MlsSum,MlzSum,MglSum,PbzSum,PsySum,PsszSum,MwzSum,PddzSum,Psgsum,PwzsgSum,PlbsszSum,MlbSum,CreateTime
	)
	 select COUNT(*) as 'yxyh',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1001 group by nPlayerId)a) as 'Mnnmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1002 group by nPlayerId)a) as 'Mylmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1003 group by nPlayerId)a) as 'Mslmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1004 group by nPlayerId)a) as 'Mhxmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1005 group by nPlayerId)a) as 'Mggmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1006 group by nPlayerId)a) as 'Mlsmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1007 group by nPlayerId)a) as 'Mlzmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1008 group by nPlayerId)a) as 'Mglmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=2001 group by nPlayerId)a) as 'Pbzrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=2002 group by nPlayerId)a) as 'Psyrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=2003 group by nPlayerId)a) as 'Psszrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1011 group by nPlayerId)a) as 'Mwzmjrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=2005 group by nPlayerId)a) as 'Pddzrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=2009 group by nPlayerId)a) as 'Psgrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=2012 group by nPlayerId)a) as 'Pwzsgrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=2022 group by nPlayerId)a) as 'Plbsszrs',
	(SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>_oldDiffDate and szEndTime<_curDiffDate and nGameId=1015 group by nPlayerId)a) as 'MlbSumrs',
	_oldDiffDate
	from 
	 (SELECT nPlayerID FROM Table_Web_UserZHangJi where nGameId is not null and szEndTime>_oldDiffDate and szEndTime<_curDiffDate group by nPlayerId)t;




root@mysqldb 15:22:  [yldb]> show global variables like '%isolation%';
+-----------------------+-----------------+
| Variable_name         | Value           |
+-----------------------+-----------------+
| transaction_isolation | REPEATABLE-READ |
| tx_isolation          | REPEATABLE-READ |
+-----------------------+-----------------+
2 rows in set (0.00 sec)


root@mysqldb 15:37:  [yldb]> select count(*) from Table_Web_UserZHangJi;
+----------+
| count(*) |
+----------+
|  1020281 |
+----------+
1 row in set (0.37 sec)


desc SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>'2021-03-21 00:00:00'  and szEndTime<'2021-03-22 00:00:00' and nGameId=1001 group by nPlayerId)a

	root@mysqldb 15:39:  [yldb]> desc SELECT count(*) from(SELECT nPlayerId FROM Table_Web_UserZHangJi where szEndTime>'2021-03-21 00:00:00'  and szEndTime<'2021-03-22 00:00:00' and nGameId=1001 group by nPlayerId)a;
	+----+-------------+-----------------------+------------+-------+---------------------------+---------------------------+---------+------+--------+----------+-------------+
	| id | select_type | table                 | partitions | type  | possible_keys             | key                       | key_len | ref  | rows   | filtered | Extra       |
	+----+-------------+-----------------------+------------+-------+---------------------------+---------------------------+---------+------+--------+----------+-------------+
	|  1 | PRIMARY     | <derived2>            | NULL       | ALL   | NULL                      | NULL                      | NULL    | NULL |  10767 |   100.00 | NULL        |
	|  2 | DERIVED     | Table_Web_UserZHangJi | NULL       | index | idx_Table_Web_UserZHangJi | idx_Table_Web_UserZHangJi | 12      | NULL | 969262 |     1.11 | Using where |
	+----+-------------+-----------------------+------------+-------+---------------------------+---------------------------+---------+------+--------+----------+-------------+
	2 rows in set, 1 warning (0.00 sec)

	使用 (`nPlayerID`,`TableId`,`szEndTime`) 索引，意味着需要对二级索引的全索引扫描，同时对二级索引+主键索引的记录加锁，相当于是对全表的记录加锁。	

主库21号的数据量

	mysql> SELECT count(*) FROM Table_Web_UserZHangJi where szEndTime>'2021-03-21 00:00:00'  and szEndTime<'2021-03-22 00:00:00';

	+----------+
	| count(*) |
	+----------+
	|   211982 |
	+----------+
	1 row in set (0.71 sec)

从库21号的数据量

	msyql> SELECT count(*) FROM Table_Web_UserZHangJi where szEndTime>'2021-03-21 00:00:00'  and szEndTime<'2021-03-22 00:00:00';

	+----------+
	| count(*) |
	+----------+
	|   211982 |
	+----------+
	1 row in set (0.71 sec)


解析主库的binlog
	
	the event s master log mysql-bin.000770, end_log_pos 75004569, Error_code: 1205
	
	mysqlbinlog --no-defaults -vv --base64-output=decode-rows  --start-datetime='2021-03-22 04:20:00' --stop-datetime='2021-03-22 04:21:30' mysql-bin.000770  > mysqlbinlog_770.sql
	
	#210322  4:20:23 server id 1  end_log_pos 75003970 CRC32 0x625f8fe2 	Xid = 3213510446
	COMMIT/*!*/;
	# at 75003970
	#210322  4:20:24 server id 1  end_log_pos 75004050 CRC32 0x6cf66b32 	Query	thread_id=2519612	exec_time=0	error_code=0
	SET TIMESTAMP=1616358024/*!*/;
	/*!\C utf8 *//*!*/;
	SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
	BEGIN
	/*!*/;
	# at 75004050
	#210322  4:20:24 server id 1  end_log_pos 75004212 CRC32 0xa6efa07b 	Table_map: `yldb`.`table_web_userzhangji` mapped to number 107
	# at 75004212
	#210322  4:20:24 server id 1  end_log_pos 75004569 CRC32 0x770ab042 	Write_rows: table id 107 flags: STMT_END_F
	### INSERT INTO `yldb`.`table_web_userzhangji`
	### SET
	###   @1=0 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @2=808125 /* INT meta=0 nullable=0 is_null=0 */
	###   @3=170060 /* INT meta=0 nullable=0 is_null=0 */
	###   @4='彬哥哥' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
	###   @5=1616357988 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
	###   @6=1616358024 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
	###   @7=5 /* INT meta=0 nullable=0 is_null=0 */
	###   @8=3 /* INT meta=0 nullable=0 is_null=0 */
	###   @9=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @10='0' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
	###   @11='0' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
	###   @12=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @13=170060 /* INT meta=0 nullable=0 is_null=0 */
	###   @14=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @15=25 /* INT meta=0 nullable=0 is_null=0 */
	###   @16='彬哥哥' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
	###   @17=64684 /* INT meta=0 nullable=0 is_null=0 */
	###   @18=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @19=-90 (4294967206) /* INT meta=0 nullable=0 is_null=0 */
	###   @20='啊杰' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
	###   @21=65689 /* INT meta=0 nullable=0 is_null=0 */
	###   @22=2 /* INT meta=0 nullable=0 is_null=0 */
	###   @23=125 /* INT meta=0 nullable=0 is_null=0 */
	###   @24='伊SQ似蜜' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
	###   @25=92617 /* INT meta=0 nullable=0 is_null=0 */
	###   @26=3 /* INT meta=0 nullable=0 is_null=0 */
	###   @27=-60 (4294967236) /* INT meta=0 nullable=0 is_null=0 */
	###   @28='夜空中最亮的星' /* VARSTRING(256) meta=256 nullable=0 is_null=0 */
	###   @29=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @30=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @31=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @32=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @33=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @34=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @35=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @36=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @37=10 /* INT meta=0 nullable=1 is_null=0 */
	###   @38=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @39='808125042024' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
	###   @40=NULL /* INT meta=0 nullable=1 is_null=1 */
	###   @41=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @42=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @43=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @44='' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
	###   @45=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @46=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @47=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @48='' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
	###   @49=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @50=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @51=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @52='' /* VARSTRING(256) meta=256 nullable=1 is_null=0 */
	###   @53=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @54=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @55=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @56='' /* VARSTRING(128) meta=128 nullable=1 is_null=0 */
	###   @57=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @58=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @59=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @60=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @61=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @62=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @63=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @64=0 /* INT meta=0 nullable=1 is_null=0 */
	###   @65=2003 /* INT meta=0 nullable=1 is_null=0 */
	# at 75004569
	#210322  4:20:24 server id 1  end_log_pos 75004600 CRC32 0x470aba74 	Xid = 3213510492
	COMMIT/*!*/;
	# at 75004600



	root@mysqldb 16:39:  [yldb]> select count(*) from table_web_userzhangji where nPlayerID=170060 and TableId=808125 and nScore1=25;
	+----------+
	| count(*) |
	+----------+
	|        1 |
	+----------+
	1 row in set (0.01 sec)


解决办法之一
	把RR事务隔离级别改为RC事务隔离级别
	SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
	insert into EffectiveNumber_DayLog
	(
	 Sum,MnnSum,MylSum,MslSum,MhxSum,MggSum,MlsSum,MlzSum,MglSum,PbzSum,PsySum,PsszSum,MwzSum,PddzSum,Psgsum,PwzsgSum,PlbsszSum,MlbSum,CreateTime
	)
	
	
小结和思考 

	2021-03-22 04:21:15 23322 [Warning] Slave SQL: Could not execute Write_rows event on table yldb.table_web_userzhangji;
		 Lock wait timeout exceeded; try restarting transaction, Error_code: 1205; 
		 handler error HA_ERR_LOCK_WAIT_TIMEOUT; 
		 the event s master log mysql-bin.000770, end_log_pos 75004569, Error_code: 1205
		 
	估计SQL线程具有事务被回滚之后的重试机制。

	