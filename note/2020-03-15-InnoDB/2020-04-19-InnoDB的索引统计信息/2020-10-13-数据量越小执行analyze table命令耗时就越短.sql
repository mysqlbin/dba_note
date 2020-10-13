

样例1：
	
	CREATE TABLE `t1` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	  .................................................
	  `nChairID` int(11) DEFAULT '0' COMMENT '',
	  `szToken` varchar(64) DEFAULT NULL COMMENT '',
	  .................................................
	  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
	  .................................................
	  PRIMARY KEY (`ID`),
	  KEY `idx_szToken_nChairID` (`szToken`(28),`nChairID`),
	  KEY `idx_tEndTime` (`tEndTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=14471002 DEFAULT CHARSET=utf8mb4 COMMENT='';


	索引大小：1.16 GB (1,246,543,872)
	数据大小：1.98 GB (2,129,657,856)

	mysql> analyze table t1;
	+--------------------------------------------+---------+----------+----------+
	| Table                                      | Op      | Msg_type | Msg_text |
	+--------------------------------------------+---------+----------+----------+
	| liuliuh5_db.t1							 | analyze | status   | OK       |
	+--------------------------------------------+---------+----------+----------+
	1 row in set (1.86 sec)
	-- 耗时1.86秒

		索引大小：1.34 GB (1,437,417,472)
		数据大小：2.34 GB (2,514,485,248)


样例2：

	CREATE TABLE `t2` (
	  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
	  `nPlayerID` int(11) NOT NULL COMMENT '',
	  `nClubID` int(11) NOT NULL COMMENT '',
	  .................................................
	  PRIMARY KEY (`Id`),
	  KEY `idx_nPlayerID` (`nPlayerID`),
	  KEY `idx_nClubID` (`nClubID`)
	) ENGINE=InnoDB AUTO_INCREMENT=38448 DEFAULT CHARSET=utf8mb4 COMMENT='';


	索引大小：3.03 MB (3,178,496)
	数据大小：2.52 MB (2,637,824)

	mysql> analyze table t2;
	+------------------------+---------+----------+----------+
	| Table                  | Op      | Msg_type | Msg_text |
	+------------------------+---------+----------+----------+
	| liuliuh5_db.t2 		 | analyze | status   | OK       |
	+------------------------+---------+----------+----------+
	1 row in set (0.16 sec)
	-- 耗时0.16秒

		索引大小：3.03 MB (3,178,496)
		数据大小：2.52 MB (2,637,824)
