
1. 慢查询日志

	# Attribute    pct   total     min     max     avg     95%  stddev  median
	# ============ === ======= ======= ======= ======= ======= ======= =======
	# Count          0       4
	# Exec time     19    119s     29s     30s     30s     30s   510ms     29s
	# Lock time      0     1ms   325us   344us   334us   332us     7us   332us
	# Rows sent      0      40      10      10      10      10       0      10
	# Rows examine  27  34.30M   8.57M   8.57M   8.57M   8.43M       0   8.43M
	# Query size     2   2.61k     669     669     669     669       0     669
	# String:
	# Databases    niuniuh5_db
	# Hosts        192.168.1.15
	# Users        webh5_user
	# Query_time distribution
	#   1us
	#  10us
	# 100us
	#   1ms
	#  10ms
	# 100ms
	#    1s
	#  10s+  ################################################################
	# Tables
	#    SHOW TABLE STATUS FROM `niuniuh5_db` LIKE 'Table_ClubGameScoreDetail'\G
	#    SHOW CREATE TABLE `niuniuh5_db`.`Table_ClubGameScoreDetail`\G
	#    SHOW TABLE STATUS FROM `niuniuh5_db` LIKE 'table_user'\G
	#    SHOW CREATE TABLE `niuniuh5_db`.`table_user`\G
	# EXPLAIN /*!50100 PARTITIONS*/
	select temp.nClubID,temp.nPlayerId,users.szThirdAccount szNickName,temp.nRound,temp.nValidBet, temp.nResultMoney  from (  select detail.nClubID,detail.nPlayerId,count(detail.nRound) nRound,SUM(detail.nValidBet) nValidBet, SUM(detail.nResultMoney) nResultMoney from Table_ClubGameScoreDetail detail  where detail.ID>=7265116 and detail.ID<=9116059   and detail.nClubID=10002 and detail.bRobot=0  and detail.nGameType in (9,10,11,12,13,14,15,16,17,110,111)  and detail.tEndTime>='2019-05-07 00:00:00'  and detail.tEndTime<='2019-05-13 23:59:59'  GROUP BY detail.nClubID,detail.nPlayerId  limit 0,10       )temp left join table_user users on temp.nPlayerId=users.nPlayerID\G

2. 格式化慢查询SQL 

	SELECT
		temp.nClubID,
		temp.nPlayerId,
		users.szThirdAccount szNickName,
		temp.nRound,
		temp.nValidBet,
		temp.nResultMoney
	FROM
		(
			SELECT
				detail.nClubID,
				detail.nPlayerId,
				count(detail.nRound) nRound,
				SUM(detail.nValidBet) nValidBet,
				SUM(detail.nResultMoney) nResultMoney
			FROM
				Table_ClubGameScoreDetail detail
			WHERE
				detail.ID >= 7265116
			AND detail.ID <= 9116059
			AND detail.nClubID = 10002
			AND detail.bRobot = 0
			AND detail.nGameType IN (
				9,
				10,
				11,
				12,
				13,
				14,
				15,
				16,
				17,
				110,
				111
			)
			AND detail.tEndTime >= '2019-05-07 00:00:00'
			AND detail.tEndTime <= '2019-05-13 23:59:59'
			GROUP BY
				detail.nClubID,
				detail.nPlayerId
			LIMIT 0,
			10
		) temp
	LEFT JOIN table_user users ON temp.nPlayerId = users.nPlayerID \ G

3. SQL的执行计划

	mysql> desc select temp.nClubID,temp.nPlayerId,users.szThirdAccount szNickName,temp.nRound,temp.nValidBet, temp.nResultMoney  from (  select detail.nClubID,detail.nPlayerId,count(detail.nRound) nRound,SUM(detail.nValidBet) nValidBet, SUM(detail.nResultMoney) nResultMoney from Table_ClubGameScoreDetail detail  where detail.ID>=7265116 and detail.ID<=9116059   and detail.nClubID=10002 and detail.bRobot=0  and detail.nGameType in (9,10,11,12,13,14,15,16,17,110,111)  and detail.tEndTime>='2019-05-07 00:00:00'  and detail.tEndTime<='2019-05-13 23:59:59'  GROUP BY detail.nClubID,detail.nPlayerId  limit 0,10 )temp left join table_user users on temp.nPlayerId=users.nPlayerID;
	+----+-------------+------------+------------+--------+------------------------------------------------------------------------------------------------------------+--------------------------------+---------+----------------+--------+----------+-------------+
	| id | select_type | table      | partitions | type   | possible_keys                                                                                              | key                            | key_len | ref            | rows   | filtered | Extra       |
	+----+-------------+------------+------------+--------+------------------------------------------------------------------------------------------------------------+--------------------------------+---------+----------------+--------+----------+-------------+
	|  1 | PRIMARY     | <derived2> | NULL       | ALL    | NULL                                                                                                       | NULL                           | NULL    | NULL           |     10 |   100.00 | NULL        |
	|  1 | PRIMARY     | users      | NULL       | eq_ref | PRIMARY                                                                                                    | PRIMARY                        | 4       | temp.nPlayerId |      1 |   100.00 | Using where |
	|  2 | DERIVED     | detail     | NULL       | index  | PRIMARY,idx_nClubID_szToken,idx_tEndTime_bRobot,idx_nClubID_bRobot_tEndTime,idx_nPlayerID_nClubID_tEndTime | idx_nPlayerID_nClubID_tEndTime | 16      | NULL           | 152608 |     0.42 | Using where |
	+----+-------------+------------+------------+--------+------------------------------------------------------------------------------------------------------------+--------------------------------+---------+----------------+--------+----------+-------------+
	3 rows in set, 1 warning (0.01 sec)


4. SQL语句的耗时

	SQL执行所需要时间： 29.52秒

	mysql> select temp.nClubID,temp.nPlayerId,users.szThirdAccount szNickName,temp.nRound,temp.nValidBet, temp.nResultMoney  from (  select detail.nClubID,detail.nPlayerId,count(detail.nRound) nRound,SUM(detail.nValidBet) nValidBet, SUM(detail.nResultMoney) nResultMoney from Table_ClubGameScoreDetail detail  where detail.ID>=7265116 and detail.ID<=9116059   and detail.nClubID=10002 and detail.bRobot=0  and detail.nGameType in (9,10,11,12,13,14,15,16,17,110,111)  and detail.tEndTime>='2019-05-07 00:00:00'  and detail.tEndTime<='2019-05-13 23:59:59'  GROUP BY detail.nClubID,detail.nPlayerId  limit 0,10 )temp left join table_user users on temp.nPlayerId=users.nPlayerID;
	+---------+-----------+-------------+--------+-----------+--------------+
	| nClubID | nPlayerId | szNickName  | nRound | nValidBet | nResultMoney |
	+---------+-----------+-------------+--------+-----------+--------------+
	|   10002 |    120012 | p38254p     |    513 |  14086400 |     -2412828 |
	|   10002 |    120020 | zhongguo119 |      7 |     53000 |       -37400 |
	|   10002 |    120036 | botion888   |    610 |   5380141 |      -178068 |
	|   10002 |    120044 | lijun120897 |     13 |    493000 |      -195350 |
	|   10002 |    120045 | xusong888   |     26 |   1434176 |       442066 |
	|   10002 |    120051 | CTF8888     |    420 |  21029635 |     -1372635 |
	|   10002 |    120059 | crj2018     |    556 |  35567750 |     -4310900 |
	|   10002 |    120060 | a289987503  |     47 |    153000 |       -25450 |
	|   10002 |    120061 | a201518     |     13 |     93000 |       -65550 |
	|   10002 |    120063 | 15569451791 |    146 |   2737806 |      -720206 |
	+---------+-----------+-------------+--------+-----------+--------------+
	10 rows in set (29.54 sec)


5. 分析语句执行慢的原因
	
	执行时间: 10 rows in set (29.54 sec)
	explain.rows=152608	
	优化器选择索引 idx_nPlayerID_nClubID_tEndTime 的原因:
		where条件没有使用到索引
		group by 分组字段用到了索引，认为使用索引 idx_nPlayerID_nClubID_tEndTime 能够避免使用临时表和排序，同时扫描的行数少, 所以认为代价较小：


6. 通过force index 强制使用主键索引
	mysql> desc select temp.nClubID,temp.nPlayerId,users.szThirdAccount szNickName,temp.nRound,temp.nValidBet, temp.nResultMoney  from (  select detail.nClubID,detail.nPlayerId,count(detail.nRound) nRound,SUM(detail.nValidBet) nValidBet, SUM(detail.nResultMoney) nResultMoney from Table_ClubGameScoreDetail detail force index(`PRIMARY`) where detail.ID>=7265116 and detail.ID<=9116059   and detail.nClubID=10002 and detail.bRobot=0  and detail.nGameType in (9,10,11,12,13,14,15,16,17,110,111)  and detail.tEndTime>='2019-05-07 00:00:00'  and detail.tEndTime<='2019-05-13 23:59:59'  GROUP BY detail.nClubID,detail.nPlayerId  limit 0,10 )temp left join table_user users on temp.nPlayerId=users.nPlayerID;
	+----+-------------+------------+------------+--------+----------------------------------------+---------+---------+----------------+---------+----------+----------------------------------------------+
	| id | select_type | table      | partitions | type   | possible_keys                          | key     | key_len | ref            | rows    | filtered | Extra                                        |
	+----+-------------+------------+------------+--------+----------------------------------------+---------+---------+----------------+---------+----------+----------------------------------------------+
	|  1 | PRIMARY     | <derived2> | NULL       | ALL    | NULL                                   | NULL    | NULL    | NULL           |      10 |   100.00 | NULL                                         |
	|  1 | PRIMARY     | users      | NULL       | eq_ref | PRIMARY                                | PRIMARY | 4       | temp.nPlayerId |       1 |   100.00 | Using where                                  |
	|  2 | DERIVED     | detail     | NULL       | range  | PRIMARY,idx_nPlayerID_nClubID_tEndTime | PRIMARY | 4       | NULL           | 3514838 |     0.00 | Using where; Using temporary; Using filesort |
	+----+-------------+------------+------------+--------+----------------------------------------+---------+---------+----------------+---------+----------+----------------------------------------------+
	3 rows in set, 1 warning (0.00 sec)

	mysql> select temp.nClubID,temp.nPlayerId,users.szThirdAccount szNickName,temp.nRound,temp.nValidBet, temp.nResultMoney  from (  select detail.nClubID,detail.nPlayerId,count(detail.nRound) nRound,SUM(detail.nValidBet) nValidBet, SUM(detail.nResultMoney) nResultMoney from Table_ClubGameScoreDetail detail force index(`PRIMARY`) where detail.ID>=7265116 and detail.ID<=9116059   and detail.nClubID=10002 and detail.bRobot=0  and detail.nGameType in (9,10,11,12,13,14,15,16,17,110,111)  and detail.tEndTime>='2019-05-07 00:00:00'  and detail.tEndTime<='2019-05-13 23:59:59'  GROUP BY detail.nClubID,detail.nPlayerId  limit 0,10 )temp left join table_user users on temp.nPlayerId=users.nPlayerID;
	+---------+-----------+-------------+--------+-----------+--------------+
	| nClubID | nPlayerId | szNickName  | nRound | nValidBet | nResultMoney |
	+---------+-----------+-------------+--------+-----------+--------------+
	|   10002 |    120012 | p38254p     |    513 |  14086400 |     -2412828 |
	|   10002 |    120020 | zhongguo119 |      7 |     53000 |       -37400 |
	|   10002 |    120036 | botion888   |    610 |   5380141 |      -178068 |
	|   10002 |    120044 | lijun120897 |     13 |    493000 |      -195350 |
	|   10002 |    120045 | xusong888   |     26 |   1434176 |       442066 |
	|   10002 |    120051 | CTF8888     |    420 |  21029635 |     -1372635 |
	|   10002 |    120059 | crj2018     |    556 |  35567750 |     -4310900 |
	|   10002 |    120060 | a289987503  |     47 |    153000 |       -25450 |
	|   10002 |    120061 | a201518     |     13 |     93000 |       -65550 |
	|   10002 |    120063 | 15569451791 |    146 |   2737806 |      -720206 |
	+---------+-----------+-------------+--------+-----------+--------------+
	10 rows in set (1.07 sec)


	-- 分析
		执行时间: 10 rows in set (1.07 sec)
		explain.rows=3514838	
		explain.Extra=Using temporary; Using filesort

		强制让优化器选择Primary主键索引 :
			虽然扫描的行数很多, 3514838/152608 = 23, 跟优化器默认选择的索引扫描的行数大了23倍
			同时SQL语句使用到了临时表和排序, 但是这里的需求是只取10条记录
			从SQL的执行效率来看, 这个场景下, 强制使用主键索引往往是更好的选择.
			
