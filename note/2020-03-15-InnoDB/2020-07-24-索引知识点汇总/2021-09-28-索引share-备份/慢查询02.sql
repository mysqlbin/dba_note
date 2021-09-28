0. 表的DDL
	CREATE TABLE `table_league_club_game_score_detail` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
	  `nKindID` int(11) NOT NULL COMMENT '游戏ID',
	  `nGameType` tinyint(4) NOT NULL COMMENT '游戏类型（1-麻将，2-纸牌，3-字牌）',
	  `nPlayCount` tinyint(4) NOT NULL COMMENT '参与人数',
	  `nTableID` int(11) NOT NULL COMMENT '桌子ID',
	  `nChairID` int(11) NOT NULL COMMENT '椅子ID',
	  `szToken` varchar(64) NOT NULL DEFAULT '' COMMENT 'clubid-roomid-time(与明细表对应)',
	  `nRound` int(11) NOT NULL COMMENT '当前局数',
	  `nBaseScore` int(11) NOT NULL COMMENT '底分',
	  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
	  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
	  `nResult` int(11) NOT NULL COMMENT '玩家ID',
	  `nBankID` int(11) NOT NULL COMMENT '玩家ID',
	  `nPlayBackCode` varchar(32) NOT NULL DEFAULT '' COMMENT '回放码',
	  PRIMARY KEY (`ID`),
	  KEY `idx_szToken` (`szToken`) USING BTREE,
	  KEY `idx_tEndTime` (`tEndTime`),
	  KEY `idx_nPlayerId` (`nPlayerID`)
	) ENGINE=InnoDB AUTO_INCREMENT=7388724 DEFAULT CHARSET=utf8mb4 COMMENT='明细战绩表（按游戏类型分麻将，字牌，纸牌，按人数分类）';

	table_league_club_game_score_detail 表保留近3个月的数据
	

1. 慢查询语句

	-- 这个是查统计/汇总的数据
	-- 每次执行约耗时6秒
	SELECT
		count(1) totalCount,
		SUM(detail.nResult) totalnResult
	FROM
		(
			SELECT
				detail.nClubId,
				detail.nKindId,
				detail.nTableId,
				detail.tEndTime,
				detail.nPlayerId,
				detail.nResult,
				detail.nRound,
				detail.szToken,
				detail.nPlayBackCode,
				detail.nChairId,
				users.szNickName,
				users.szThirdAccount,
				info.szClubName
			FROM
				table_league_club_game_score_detail detail
			LEFT JOIN table_user users ON users.nPlayerId = detail.nPlayerId
			LEFT JOIN table_league_club_info info ON info.nClubId = detail.nClubId
			WHERE
				1 = 1
			AND detail.tEndTime >= '2021-08-05 00:00:00'
			AND detail.tEndTime <= '2021-09-04 23:59:59'
			AND detail.nTableId = '925954'
			GROUP BY
				detail.nClubId,
				detail.nPlayerId,
				detail.nTableId,
				detail.nRound
		) detail
		
	-- 语句的执行计划如下:
		
		+----+-------------+------------+------------+--------+---------------+---------+---------+------------------------------+---------+----------+----------------------------------------------+
		| id | select_type | table      | partitions | type   | possible_keys | key     | key_len | ref                          | rows    | filtered | Extra                                        |
		+----+-------------+------------+------------+--------+---------------+---------+---------+------------------------------+---------+----------+----------------------------------------------+
		|  1 | PRIMARY     | <derived2> | NULL       | ALL    | NULL          | NULL    | NULL    | NULL                         |  172846 |   100.00 | NULL                                         |
		|  2 | DERIVED     | detail     | NULL       | ALL    | idx_tEndTime  | NULL    | NULL    | NULL                         | 3456926 |     5.00 | Using where; Using temporary; Using filesort |
		|  2 | DERIVED     | users      | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | niuniuh5_db.detail.nPlayerID |       1 |   100.00 | Using where                                  |
		|  2 | DERIVED     | info       | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | niuniuh5_db.detail.nClubID   |       1 |   100.00 | Using where                                  |
		+----+-------------+------------+------------+--------+---------------+---------+---------+------------------------------+---------+----------+----------------------------------------------+
		4 rows in set, 1 warning (0.00 sec)

	-- 执行慢的原因：
		table_league_club_game_score_detail 表保留近3个月的数据，现在要根据时间查询1个月的，超过了20%+原则，自然用不到索引，导致全表扫描。
		
	-- 后台对这个表的查询条件：
		1. 单独根据时间查询，只带时间最多可以查询1天的数据
		2. 组合查询，其中时间字段是必选：
			1. 根据 nClubId + tEndTime 查询
			2. 根据 nPlayerId + tEndTime 查询
			3. 根据	nTableID + tEndTime 查询
			4. 根据 nClubId + nPlayerId + nTableID + tEndTime 查询
	
	-- 经过沟通，发现 nTableID 字段的区分度很高也就是索引基数很大
		因此，可以单独建 nTableID 字段的索引，不需要建 nTableID + tEndTime 的联合索引
		alter table table_league_club_game_score_detail add index idx_nTableID(`nTableID`);
	
	-- 查看 nTableID 字段的索引基数
		
		-- 测试环境
		mysql> show index from table_league_club_game_score_detail;
		+-------------------------------------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table                               | Non_unique | Key_name      | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+-------------------------------------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| table_league_club_game_score_detail |          0 | PRIMARY       |            1 | ID          | A         |      101780 |     NULL | NULL   |      | BTREE      |         |               |
		| table_league_club_game_score_detail |          1 | idx_szToken   |            1 | szToken     | A         |       12195 |     NULL | NULL   |      | BTREE      |         |               |
		| table_league_club_game_score_detail |          1 | idx_tEndTime  |            1 | tEndTime    | A         |       21903 |     NULL | NULL   | YES  | BTREE      |         |               |
		| table_league_club_game_score_detail |          1 | idx_nPlayerId |            1 | nPlayerID   | A         |        1087 |     NULL | NULL   |      | BTREE      |         |               |
		| table_league_club_game_score_detail |          1 | idx_nTableID  |            1 | nTableID    | A         |       10724 |     NULL | NULL   |      | BTREE      |         |               |
		+-------------------------------------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		5 rows in set (0.00 sec)
			
			-- 同1个nTableID桌子号，平均大概有9个重复值，索引基数很高。
			-- select 101780/10724 = 9;  
			
		-- 生产环境
		mysql> show index from table_league_club_game_score_detail;
		+-------------------------------------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table                               | Non_unique | Key_name      | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+-------------------------------------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| table_league_club_game_score_detail |          0 | PRIMARY       |            1 | ID          | A         |     3455165 |     NULL | NULL   |      | BTREE      |         |               |
		| table_league_club_game_score_detail |          1 | idx_szToken   |            1 | szToken     | A         |       96680 |     NULL | NULL   |      | BTREE      |         |               |
		| table_league_club_game_score_detail |          1 | idx_tEndTime  |            1 | tEndTime    | A         |      852462 |     NULL | NULL   | YES  | BTREE      |         |               |
		| table_league_club_game_score_detail |          1 | idx_nPlayerId |            1 | nPlayerID   | A         |        3465 |     NULL | NULL   |      | BTREE      |         |               |
		| table_league_club_game_score_detail |          1 | idx_nTableID  |            1 | nTableID    | A         |       40744 |     NULL | NULL   |      | BTREE      |         |               |
		+-------------------------------------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		5 rows in set (0.00 sec)
		
			-- 同1个nTableID桌子号，平均大概有84个重复值，索引基数相对较高。
			-- select 3455165/40744 = 84;  
		
	
	-- 语句的执行计划
		+----+-------------+------------+------------+--------+---------------------------+--------------+---------+------------------------------+------+----------+---------------------------------------------------------------------+
		| id | select_type | table      | partitions | type   | possible_keys             | key          | key_len | ref                          | rows | filtered | Extra                                                               |
		+----+-------------+------------+------------+--------+---------------------------+--------------+---------+------------------------------+------+----------+---------------------------------------------------------------------+
		|  1 | PRIMARY     | <derived2> | NULL       | ALL    | NULL                      | NULL         | NULL    | NULL                         |    2 |   100.00 | NULL                                                                |
		|  2 | DERIVED     | detail     | NULL       | ref    | idx_tEndTime,idx_nTableID | idx_nTableID | 4       | const                        |    6 |     0.83 | Using index condition; Using where; Using temporary; Using filesort |
		|  2 | DERIVED     | users      | NULL       | eq_ref | PRIMARY                   | PRIMARY      | 4       | niuniuh5_db.detail.nPlayerID |    1 |   100.00 | Using where                                                         |
		|  2 | DERIVED     | info       | NULL       | eq_ref | PRIMARY                   | PRIMARY      | 4       | niuniuh5_db.detail.nClubID   |    1 |   100.00 | Using where                                                         |
		+----+-------------+------------+------------+--------+---------------------------+--------------+---------+------------------------------+------+----------+---------------------------------------------------------------------+
		4 rows in set, 1 warning (0.00 sec)

	-- 优化后的执行时间：0.01 秒。
		
		
		