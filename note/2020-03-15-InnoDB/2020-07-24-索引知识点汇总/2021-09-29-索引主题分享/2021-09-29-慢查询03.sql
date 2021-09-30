
1. 优化前的执行计划
	
		pr_league_get_gamescore_total：查看战绩列表，合计界面
		
		desc SELECT MIN(id), MAX(id) from (
		SELECT id FROM `table_league_club_game_score_total` WHERE `nClubID` = 666154 AND  tCreateTime>= '2021-09-27 00:00:00' GROUP BY szToken LIMIT 100
		)temp;
		+----+-------------+------------------------------------+------------+------+--------------------------------+------------------------+---------+-------+-------+----------+---------------------------------------------------------------------+
		| id | select_type | table                              | partitions | type | possible_keys                  | key                    | key_len | ref   | rows  | filtered | Extra                                                               |
		+----+-------------+------------------------------------+------------+------+--------------------------------+------------------------+---------+-------+-------+----------+---------------------------------------------------------------------+
		|  1 | PRIMARY     | <derived2>                         | NULL       | ALL  | NULL                           | NULL                   | NULL    | NULL  |   100 |   100.00 | NULL                                                                |
		|  2 | DERIVED     | table_league_club_game_score_total | NULL       | ref  | szToken,idx_nClubID_tStartTime | idx_nClubID_tStartTime | 4       | const | 20042 |    33.33 | Using index condition; Using where; Using temporary; Using filesort |
		+----+-------------+------------------------------------+------------+------+--------------------------------+------------------------+---------+-------+-------+----------+---------------------------------------------------------------------+
		2 rows in set, 1 warning (0.00 sec)

		
		SELECT temp12.ID, tu.szNickName, temp12.nPlayerID, temp12.szToken, temp12.nTableID, temp12.nRound, UNIX_TIMESTAMP(temp12.tCreateTime) AS tStartTime, temp12.nKindID, temp12.`nTotalResult`, temp12.BigWinner, temp12.Dismiss 
		FROM (SELECT b.ID, b.nPlayerID ,b.szToken, b.nTableID, b.nRound, b.tCreateTime, b.nKindID, b.`nTotalResult`, b.BigWinner, b.Dismiss  FROM (
		SELECT nPlayerID, szToken FROM `table_league_club_game_score_total`  WHERE `nClubID` = 666154  AND `tCreateTime` >= '2021-09-27 00:00:00'
		AND (ID BETWEEN 834068 AND 848211)
		GROUP BY szToken ORDER BY ID DESC
		LIMIT 1, 5
		) temp11 LEFT JOIN table_league_club_game_score_total b ON b.szToken = temp11.szToken GROUP BY b.nPlayerID,b.szToken
		) temp12 INNER JOIN table_user tu ON tu.nPlayerID = temp12.nPlayerID  ORDER BY temp12.ID DESC;
		+----+-------------+------------------------------------+------------+--------+--------------------------------+------------------------+---------+------------------+-------+----------+---------------------------------------------------------------------+
		| id | select_type | table                              | partitions | type   | possible_keys                  | key                    | key_len | ref              | rows  | filtered | Extra                                                               |
		+----+-------------+------------------------------------+------------+--------+--------------------------------+------------------------+---------+------------------+-------+----------+---------------------------------------------------------------------+
		|  1 | PRIMARY     | <derived2>                         | NULL       | ALL    | NULL                           | NULL                   | NULL    | NULL             |    25 |   100.00 | Using where; Using filesort                                         |
		|  1 | PRIMARY     | tu                                 | NULL       | eq_ref | PRIMARY                        | PRIMARY                | 4       | temp12.nPlayerID |     1 |   100.00 | Using where                                                         |
		|  2 | DERIVED     | <derived3>                         | NULL       | ALL    | NULL                           | NULL                   | NULL    | NULL             |     6 |   100.00 | Using temporary; Using filesort                                     |
		|  2 | DERIVED     | b                                  | NULL       | ref    | szToken                        | szToken                | 258     | temp11.szToken   |     4 |   100.00 | NULL                                                                |
		|  3 | DERIVED     | table_league_club_game_score_total | NULL       | ref    | szToken,idx_nClubID_tStartTime | idx_nClubID_tStartTime | 4       | const            | 20042 |     3.70 | Using index condition; Using where; Using temporary; Using filesort |
		+----+-------------+------------------------------------+------------+--------+--------------------------------+------------------------+---------+------------------+-------+----------+---------------------------------------------------------------------+
		5 rows in set, 1 warning (0.00 sec)

		key = idx_nClubID_tStartTime, key_len=4：说明只用到了 nClubID 索引。
		
		rows = 20042， 表示预计扫描的行数为 20042
		
2. 优化后的执行计划
		
		desc SELECT MIN(id), MAX(id) from (
			SELECT id FROM `table_league_club_game_score_total` WHERE `nClubID` = 666154 AND  tStartTime>= '2021-09-27 00:00:00' GROUP BY szToken LIMIT 100
		)temp;

		+----+-------------+------------------------------------+------------+-------+--------------------------------+------------------------+---------+------+------+----------+--------------------------------------------------------+
		| id | select_type | table                              | partitions | type  | possible_keys                  | key                    | key_len | ref  | rows | filtered | Extra                                                  |
		+----+-------------+------------------------------------+------------+-------+--------------------------------+------------------------+---------+------+------+----------+--------------------------------------------------------+
		|  1 | PRIMARY     | <derived2>                         | NULL       | ALL   | NULL                           | NULL                   | NULL    | NULL |  100 |   100.00 | NULL                                                   |
		|  2 | DERIVED     | table_league_club_game_score_total | NULL       | range | szToken,idx_nClubID_tStartTime | idx_nClubID_tStartTime | 8       | NULL | 1034 |   100.00 | Using index condition; Using temporary; Using filesort |
		+----+-------------+------------------------------------+------------+-------+--------------------------------+------------------------+---------+------+------+----------+--------------------------------------------------------+
		2 rows in set, 1 warning (0.00 sec)


		desc SELECT temp12.ID, tu.szNickName, temp12.nPlayerID, temp12.szToken, temp12.nTableID, temp12.nRound, UNIX_TIMESTAMP(temp12.tCreateTime) AS tStartTime, temp12.nKindID, temp12.`nTotalResult`, temp12.BigWinner, temp12.Dismiss 
			FROM (SELECT b.ID, b.nPlayerID ,b.szToken, b.nTableID, b.nRound, b.tCreateTime, b.nKindID, b.`nTotalResult`, b.BigWinner, b.Dismiss  FROM (
				SELECT nPlayerID, szToken FROM `table_league_club_game_score_total` WHERE `nClubID` = 666154  AND `tStartTime` >= '2021-09-27 00:00:00'
				AND (ID BETWEEN 834068 AND 848211)
				GROUP BY szToken ORDER BY ID DESC
				LIMIT 1, 5
			) temp11 LEFT JOIN table_league_club_game_score_total b ON b.szToken = temp11.szToken GROUP BY b.nPlayerID,b.szToken
		  ) temp12 INNER JOIN table_user tu ON tu.nPlayerID = temp12.nPlayerID  ORDER BY temp12.ID DESC;
			
		+----+-------------+------------------------------------+------------+--------+----------------------------------------+------------------------+---------+------------------+------+----------+--------------------------------------------------------+
		| id | select_type | table                              | partitions | type   | possible_keys                          | key                    | key_len | ref              | rows | filtered | Extra                                                  |
		+----+-------------+------------------------------------+------------+--------+----------------------------------------+------------------------+---------+------------------+------+----------+--------------------------------------------------------+
		|  1 | PRIMARY     | <derived2>                         | NULL       | ALL    | NULL                                   | NULL                   | NULL    | NULL             |   25 |   100.00 | Using where; Using filesort                            |
		|  1 | PRIMARY     | tu                                 | NULL       | eq_ref | PRIMARY                                | PRIMARY                | 4       | temp12.nPlayerID |    1 |   100.00 | Using where                                            |
		|  2 | DERIVED     | <derived3>                         | NULL       | ALL    | NULL                                   | NULL                   | NULL    | NULL             |    6 |   100.00 | Using temporary; Using filesort                        |
		|  2 | DERIVED     | b                                  | NULL       | ref    | szToken                                | szToken                | 258     | temp11.szToken   |    4 |   100.00 | NULL                                                   |
		|  3 | DERIVED     | table_league_club_game_score_total | NULL       | range  | PRIMARY,szToken,idx_nClubID_tStartTime | idx_nClubID_tStartTime | 8       | NULL             | 1034 |     4.12 | Using index condition; Using temporary; Using filesort |
		+----+-------------+------------------------------------+------------+--------+----------------------------------------+------------------------+---------+------------------+------+----------+--------------------------------------------------------+
		5 rows in set, 1 warning (0.00 sec)
		
		
		key = idx_nClubID_tStartTime, key_len=8：说明只用到了 (nClubID, tStartTime) 联合索引。
		
		rows = 1034， 表示预计扫描的行数为 1034 

3. 优化前和优化后的扫描行数、耗时对比
		
	对比再者扫描的行数： 
		nClubID索引  (nClubID, tStartTime) 联合索引
		20042   	 1090

	对比两者执行耗时：   
		优化前的执行耗时 优化后的执行耗时
		1.5秒   		 小于0.1秒。

4. 有2种优化办法

	
	1. 查询时间字段的调整

		`nClubID` = 666154  AND `tCreateTime` >= '2021-09-27 00:00:00' 改为  `nClubID` = 666154  AND `tStartTime` >= '2021-09-27 00:00:00'
	
	2. 建联合索引
		 建立由 (`nClubID`,`tCreateTime`) 组成的联合索引
		 
		 现在表已经有下面的4个索引：
			KEY `idx_nPlayerId_tStartTime` (`nPlayerID`,`tStartTime`)
			KEY `szToken` (`szToken`)
			KEY `idx_nClubID_tStartTime` (`nClubID`,`tStartTime`),
			KEY `idx_tCreateTime` (`tCreateTime`)	
		 索引并不是越多越好，建索引也需要权衡利弊。
		 
		 
		 
			