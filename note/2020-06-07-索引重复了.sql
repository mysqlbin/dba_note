
table_clubgamescoredetail 表索引建重复了
	KEY `idx_nPlayerID_nGameType_tEndTime` (`nPlayerID`,`nGameType`,`tEndTime`),
	KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
	KEY `idx_nGameType_tEndTime` (`nGameType`,`tEndTime`)

	改为 
	
	KEY `idx_nPlayerID_nClubID_tEndTime` (`nPlayerID`,`nClubID`,`tEndTime`),
	KEY `idx_nGameType_nPlayerID_tEndTime` (`nGameType`, `nPlayerID`,`tEndTime`),
	
	
	alter table table_clubgamescoredetail20200608 drop index idx_nPlayerID_nGameType_tEndTime, drop index idx_nGameType_tEndTime, add index `idx_nGameType_nPlayerID_tEndTime` (`nGameType`, `nPlayerID`,`tEndTime`);
	
	
	
table_clublogscore 表
		KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
	改为 
		KEY `idx_nPlayerID_CreateTime` (`nPlayerID`, `CreateTime`),
	
table_third_order   # 需要跟Allan确认下是否会写这张表。
	
  KEY `idx_szOrder_nStatus` (`szOrder`,`nStatus`),
  KEY `idx_nStatus_CreateTime` (`nStatus`,`CreateTime`),
  KEY `idx_nClubID_CreateTime` (`nClubID`,`CreateTime`),
  KEY `idx_nPlayerID_nClubID_CreateTime` (`nPlayerID`,`nClubID`,`CreateTime`)
 
  改为 
	
	KEY `idx_szOrder` (`szOrder`)
	KEY `idx_nClubID` (`nClubID`)
	KEY `idx_nPlayerID` (`nPlayerID`)
	
	alter table table_third_order drop index idx_szOrder_nStatus, add index idx_szOrder(`szOrder`), 
	drop index idx_nClubID_CreateTime, drop index idx_nPlayerID_nClubID_CreateTime,
	add index idx_nPlayerID_(nPlayerID), add index idx_nClubID(`nClubID`);
	
	
	

	drop index idx_nPlayerID_nGameType_tEndTime, drop index idx_nGameType_tEndTime, add index `idx_nGameType_nPlayerID_tEndTime` (`nGameType`, `nPlayerID`,`tEndTime`);
