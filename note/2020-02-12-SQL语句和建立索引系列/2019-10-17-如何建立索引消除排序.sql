

CREATE TABLE `t_detail` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
  `nClubID` int(11) NOT NULL COMMENT 'club_id',
  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
  `nPlayerID` int(11) DEFAULT '0' COMMENT 'player_id',
  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='t_detail';


alter table t_detail add index idx_nClubID_bRobot_tEndTime(`nClubID`,`bRobot`,`tEndTime`);

select * from  t_detail detail where detail.bRobot = 0
AND detail.nClubID = 10003
AND detail.tEndTime >= '2019-07-01 00:00:00'
AND detail.tEndTime <= '2019-08-14 23:59:59'
GROUP BY
	detail.nClubID,
	detail.nPlayerId
	
	
	
	
	