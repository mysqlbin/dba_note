CREATE TABLE `table_web_zhanji` (
  `Idx` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '主键Id',
  `nPlayerId` int(11) NOT NULL COMMENT '玩家Id',
  `nGameId` int(11) DEFAULT NULL COMMENT '麻将类型',
  `nTableId` int(11) NOT NULL COMMENT '桌子号',
  `nMyChairId` int(11) NOT NULL COMMENT '桌子顺序',
  `nChair0Score` int(11) NOT NULL COMMENT '座位顺序1的得分',
  `nChair1Score` int(11) NOT NULL COMMENT '座位顺序2的得分',
  `nChair2Score` int(11) NOT NULL COMMENT '座位顺序3的得分',
  `nChair3Score` int(11) NOT NULL COMMENT '座位顺序4的得分',
  `szChair0Name` varchar(64) NOT NULL COMMENT '座位顺序1的名称',
  `szChair1Name` varchar(64) NOT NULL COMMENT '座位顺序2的名称',
  `szChair2Name` varchar(64) NOT NULL COMMENT '座位顺序3的名称',
  `szChair3Name` varchar(64) NOT NULL COMMENT '座位顺序4的名称',
  `szTime` varchar(64) NOT NULL COMMENT '牌局结束时间',
  `nChair4Score` int(11) DEFAULT NULL COMMENT '座位顺序5的得分',
  `nChair5Score` int(11) DEFAULT NULL COMMENT '座位顺序6的得分',
  `nChair6Score` int(11) DEFAULT NULL COMMENT '座位顺序7的得分',
  `nChair7Score` int(11) DEFAULT NULL COMMENT '座位顺序8的得分',
  `szChair4Name` varchar(64) DEFAULT NULL COMMENT '座位顺序5的名称',
  `szChair5Name` varchar(64) DEFAULT NULL COMMENT '座位顺序6的名称',
  `szChair6Name` varchar(64) DEFAULT NULL COMMENT '座位顺序7的名称',
  `szChair7Name` varchar(64) DEFAULT NULL COMMENT '座位顺序8的名称',
  `nGameRound` int(11) DEFAULT NULL COMMENT '游戏打的局数',
  `nTotalRound` int(11) DEFAULT NULL COMMENT '设置的总局数',
  KEY `idx_Table_Web_ZhanJi` (`nPlayerId`,`nTableId`,`szTime`),
  KEY `idx_szTime` (`szTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



78569    94761 这两个ID，最近100局的战绩分数。
小卢配合查一下，老友的最近的这两个ID的战绩。

把nPlayerID,时间，当时的桌号，分数 等一起打出来。

玩家ID为78569的战绩分数列表
玩家ID为94761的战绩分数列表

因为需要查询 table_web_zhanji战绩历史表,然后在 excel中合并,所以刚才查询操作需要的时间久了一点.

SELECT
	nPlayerId,
	szTime,
	nTableId,
	nMyChairId,
	(
		CASE nMyChairId
		WHEN 0 THEN
			`nChair0Score`
		WHEN 1 THEN
			`nChair1Score`
		WHEN 2 THEN
			`nChair2Score`
		WHEN 3 THEN
					`nChair3Score`
		WHEN 4 THEN
					`nChair4Score`
		WHEN 5 THEN
					`nChair5Score`
		WHEN 6 THEN
					`nChair6Score`
		WHEN 7 THEN
			`nChair7Score`
		ELSE
			0
		END 'score'
	) 
FROM
	table_web_zhanji
WHERE
	nPlayerId = 94761;
