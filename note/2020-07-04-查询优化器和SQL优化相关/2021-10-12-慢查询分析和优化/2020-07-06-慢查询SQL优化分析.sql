
1. 表结构
2. innodb_index_stats 和 innodb_table_stats 和 show index from 
3. 慢SQL语句
4. from子查询的执行计划和查询统计
5. from子查询有覆盖索引和没有覆盖索引的耗时对比	
5. from子查询的 show profiles
6. 慢SQL语句的执行计划、show profiles和优化器追踪
	6.1 慢SQL语句的执行计划
	6.2 SQL语句的性能问题
	6.3 show profiles
	
	6.4 优化器追踪(optimizer_trace)
	
7. 优化方向
8. 验证下使用覆盖索引带来的查询性能上的提升
9. 小结

1. 表结构
	CREATE TABLE `table_clubmember` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
	  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
	  `szNickName` varchar(64) DEFAULT NULL COMMENT '玩家昵称',
	  `nLevel` tinyint(4) DEFAULT '3' COMMENT '',
	  `nStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '',
	  `tJoinTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `tEixtTime` timestamp NULL DEFAULT NULL COMMENT '',
	  `nScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
	  `nFreeScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
	  `nExtenRate` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `LineCode` varchar(64) DEFAULT NULL COMMENT '',
	  `nExtenID` int(11) DEFAULT '0' COMMENT '',
	  `tExtenBindingTime` timestamp NULL DEFAULT NULL COMMENT '',
	  `nExtenDivision` tinyint(4) DEFAULT '1' COMMENT '',
	  `nFreeServiceFee` tinyint(4) DEFAULT '0' COMMENT '',
	  `nSafeScore` bigint(20) unsigned DEFAULT '0' COMMENT '',
	  `updateScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
	  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '',
	  `nExLevel` int(10) NOT NULL DEFAULT '1' COMMENT '',
	  PRIMARY KEY (`ID`),
	  KEY `index_tJoinTime` (`tJoinTime`),
	  KEY `idx_nLevel` (`nLevel`),
	  KEY `idx_nPlayerID_nClubID_nStatus` (`nPlayerID`,`nClubID`,`nStatus`),
	  KEY `idx_nClubID_nExtenID` (`nClubID`,`nExtenID`)
	) ENGINE=InnoDB AUTO_INCREMENT=93817 DEFAULT CHARSET=utf8mb4 COMMENT='';


2. innodb_index_stats 和 innodb_table_stats 和 show index from 
	select * from mysql.innodb_index_stats  where database_name='niuniuh5_db' and table_name = 'table_clubmember';
	select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name = 'table_clubmember';

	mysql> select * from mysql.innodb_index_stats  where database_name='niuniuh5_db' and table_name = 'table_clubmember';
	+---------------+------------------+-------------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name       | index_name                    | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------------+-------------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| niuniuh5_db   | table_clubmember | PRIMARY                       | 2020-07-06 11:28:01 | n_diff_pfx01 |      92537 |          20 | ID                                |
	| niuniuh5_db   | table_clubmember | PRIMARY                       | 2020-07-06 11:28:01 | n_leaf_pages |        609 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | table_clubmember | PRIMARY                       | 2020-07-06 11:28:01 | size         |        673 |        NULL | Number of pages in the index      |
	| niuniuh5_db   | table_clubmember | idx_nClubID_nExtenID          | 2020-07-06 11:28:01 | n_diff_pfx01 |        179 |          20 | nClubID                           |
	| niuniuh5_db   | table_clubmember | idx_nClubID_nExtenID          | 2020-07-06 11:28:01 | n_diff_pfx02 |        750 |          20 | nClubID,nExtenID                  |
	| niuniuh5_db   | table_clubmember | idx_nClubID_nExtenID          | 2020-07-06 11:28:01 | n_diff_pfx03 |      91515 |          20 | nClubID,nExtenID,ID               |
	| niuniuh5_db   | table_clubmember | idx_nClubID_nExtenID          | 2020-07-06 11:28:01 | n_leaf_pages |        149 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | table_clubmember | idx_nClubID_nExtenID          | 2020-07-06 11:28:01 | size         |        225 |        NULL | Number of pages in the index      |
	| niuniuh5_db   | table_clubmember | idx_nLevel                    | 2020-07-06 11:28:01 | n_diff_pfx01 |          1 |           2 | nLevel                            |
	| niuniuh5_db   | table_clubmember | idx_nLevel                    | 2020-07-06 11:28:01 | n_diff_pfx02 |      93561 |          20 | nLevel,ID                         |
	| niuniuh5_db   | table_clubmember | idx_nLevel                    | 2020-07-06 11:28:01 | n_leaf_pages |         68 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | table_clubmember | idx_nLevel                    | 2020-07-06 11:28:01 | size         |         97 |        NULL | Number of pages in the index      |
	| niuniuh5_db   | table_clubmember | idx_nPlayerID_nClubID_nStatus | 2020-07-06 11:28:01 | n_diff_pfx01 |      92221 |          20 | nPlayerID                         |
	| niuniuh5_db   | table_clubmember | idx_nPlayerID_nClubID_nStatus | 2020-07-06 11:28:01 | n_diff_pfx02 |      92226 |          20 | nPlayerID,nClubID                 |
	| niuniuh5_db   | table_clubmember | idx_nPlayerID_nClubID_nStatus | 2020-07-06 11:28:01 | n_diff_pfx03 |      94689 |          20 | nPlayerID,nClubID,nStatus         |
	| niuniuh5_db   | table_clubmember | idx_nPlayerID_nClubID_nStatus | 2020-07-06 11:28:01 | n_diff_pfx04 |      94651 |          20 | nPlayerID,nClubID,nStatus,ID      |
	| niuniuh5_db   | table_clubmember | idx_nPlayerID_nClubID_nStatus | 2020-07-06 11:28:01 | n_leaf_pages |        108 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | table_clubmember | idx_nPlayerID_nClubID_nStatus | 2020-07-06 11:28:01 | size         |        161 |        NULL | Number of pages in the index      |
	| niuniuh5_db   | table_clubmember | index_tJoinTime               | 2020-07-06 11:28:01 | n_diff_pfx01 |      93381 |          20 | tJoinTime                         |
	| niuniuh5_db   | table_clubmember | index_tJoinTime               | 2020-07-06 11:28:01 | n_diff_pfx02 |      93705 |          20 | tJoinTime,ID                      |
	| niuniuh5_db   | table_clubmember | index_tJoinTime               | 2020-07-06 11:28:01 | n_leaf_pages |         78 |        NULL | Number of leaf pages in the index |
	| niuniuh5_db   | table_clubmember | index_tJoinTime               | 2020-07-06 11:28:01 | size         |         97 |        NULL | Number of pages in the index      |
	+---------------+------------------+-------------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	22 rows in set (0.01 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name = 'table_clubmember';
	+---------------+------------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name       | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------------+---------------------+--------+----------------------+--------------------------+
	| niuniuh5_db   | table_clubmember | 2020-07-06 11:28:01 |  92537 |                  673 |                      580 |
	+---------------+------------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	---------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	mysql> show index from table_clubmember;
	+------------------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table            | Non_unique | Key_name                      | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_clubmember |          0 | PRIMARY                       |            1 | ID          | A         |       92537 |     NULL | NULL   |      | BTREE      |         |               |
	| table_clubmember |          1 | index_tJoinTime               |            1 | tJoinTime   | A         |       92556 |     NULL | NULL   |      | BTREE      |         |               |
	| table_clubmember |          1 | idx_nLevel                    |            1 | nLevel      | A         |           1 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_clubmember |          1 | idx_nPlayerID_nClubID_nStatus |            1 | nPlayerID   | A         |       92221 |     NULL | NULL   |      | BTREE      |         |               |
	| table_clubmember |          1 | idx_nPlayerID_nClubID_nStatus |            2 | nClubID     | A         |       92226 |     NULL | NULL   |      | BTREE      |         |               |
	| table_clubmember |          1 | idx_nPlayerID_nClubID_nStatus |            3 | nStatus     | A         |       92556 |     NULL | NULL   |      | BTREE      |         |               |
	| table_clubmember |          1 | idx_nClubID_nExtenID          |            1 | nClubID     | A         |         179 |     NULL | NULL   |      | BTREE      |         |               |
	| table_clubmember |          1 | idx_nClubID_nExtenID          |            2 | nExtenID    | A         |         750 |     NULL | NULL   | YES  | BTREE      |         |               |
	+------------------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	8 rows in set (0.00 sec)


------------------------------------------------------------------------------------------------------------------------------------------------------------

3. 慢SQL语句
SELECT
	count(1) totalCount,
	SUM(recharge) recharge,
	SUM(withdrawal) withdrawal,
	SUM(rechargeCount) rechargeCount,
	SUM(rechargeNumber) rechargeNumber,
	SUM(withdrawalCount) withdrawalCount,
	SUM(withdrawalNumber) withdrawalNumber,
	SUM(teamVipCount) teamVipCount,
	SUM(addTeamCount) addTeamCount,
	SUM(weekMyRebate) weekMyRebate,
	SUM(teamRebate) teamRebate,
	SUM(water) water,
	SUM(directlyWater) directlyWater,
	SUM(addDirectlyVipCount) addDirectlyVipCount,
	SUM(teamWater) teamWater,
	SUM(directlyVipCount) directlyVipCount,
	SUM(upnAmount) upnAmount,
	SUM(downnAmount) downnAmount,
	SUM(tasknAmount) tasknAmount,
	SUM(activitynAmount) activitynAmount,
	SUM(nResultMoney) nResultMoney,
	SUM(nTax) nTax,
	SUM(nScore) nScore
FROM
	(
		SELECT
			temp.nClubID,
			temp.nPlayerID,
			temp.nExtenID,
			temp.nExLevel,
			IFNULL(recharge, 0) recharge,
			IFNULL(withdrawal, 0) withdrawal,
			IFNULL(rechargeCount, 0) rechargeCount,
			IFNULL(rechargeNumber, 0) rechargeNumber,
			IFNULL(withdrawalCount, 0) withdrawalCount,
			IFNULL(withdrawalNumber, 0) withdrawalNumber,
			IFNULL(water, 0) water,
			IFNULL(directlyWater, 0) directlyWater,
			IFNULL(teamWater, 0) teamWater,
			IFNULL(upnAmount, 0) upnAmount,
			IFNULL(downnAmount, 0) downnAmount,
			IFNULL(tasknAmount, 0) tasknAmount,
			IFNULL(activitynAmount, 0) activitynAmount,
			IFNULL(nResultMoney, 0) nResultMoney,
			IFNULL(nTax, 0) nTax,
			(
				SELECT
					IFNULL(nScore, 0) nScore
				FROM
					table_clublogscore
				WHERE
					clubID = 10017
				AND nPlayerID = temp.nPlayerID
				AND CreateTime <= '2020-07-02 23:59:59'
				ORDER BY
					CreateTime DESC
				LIMIT 0,
				1
			) nScore,
			(
				SELECT
					count(1)
				FROM
					table_clubmember
				WHERE
					nClubId = 10017
				AND nExtenID = temp.nPlayerID
				AND tJoinTime <= '2020-07-02 23:59:59'
			) directlyVipCount,
			(
				SELECT
					count(1)
				FROM
					table_clubmember
				WHERE
					nClubId = 10017
				AND nExtenID = temp.nPlayerID
				AND tJoinTime >= '2020-07-02 00:00:00'
				AND tJoinTime <= '2020-07-02 23:59:59'
			) addDirectlyVipCount,
			(
				SELECT
					count(1)
				FROM
					table_clubmemberAppLine
				WHERE
					nPlayerID = temp.nPlayerID
				AND tJoinTime <= '2020-07-02 23:59:59'
			) teamVipCount,
			(
				SELECT
					count(1)
				FROM
					table_clubmemberAppLine
				WHERE
					nPlayerID = temp.nPlayerID
				AND tJoinTime >= '2020-07-02 00:00:00'
				AND tJoinTime <= '2020-07-02 23:59:59'
			) addTeamCount,
			(
				SELECT
					IFNULL(sum(nAmount), 0) nAmount
				FROM
					table_clublogscore
				WHERE
					nType = 26
				AND clubid = 10017
				AND nPlayerId = temp.nPlayerID
				AND CreateTime >= '2020-07-02 00:00:00'
				AND CreateTime <= '2020-07-02 23:59:59'
			) weekMyRebate,
			(
				SELECT
					IFNULL(SUM(nAmount), 0) nAmount
				FROM
					table_clubmemberAppLine line
				LEFT JOIN table_clublogscore log ON line.nNextID = log.nPlayerID
				WHERE
					line.nPlayerID = temp.nPlayerID
				AND log.nType = 26
				AND log.clubid = 10017
				AND CreateTime >= '2020-07-02 00:00:00'
				AND CreateTime <= '2020-07-02 23:59:59'
			) teamRebate
		FROM
			(
				SELECT
					nClubId,
					nPlayerId,
					nExLevel,
					nExtenID
				FROM
					table_clubmember
				WHERE
					nClubId = 10017
				AND nExtenID = 132806
			) temp
		LEFT JOIN (
			SELECT
				nClubId,
				nPlayerId,
				SUM(recharge) recharge,
				SUM(withdrawal) withdrawal,
				SUM(rechargeCount) rechargeCount,
				SUM(rechargeNumber) rechargeNumber,
				SUM(withdrawalCount) withdrawalCount,
				SUM(withdrawalNumber) withdrawalNumber,
				SUM(water) water,
				SUM(directlyWater) directlyWater,
				SUM(teamWater) teamWater,
				SUM(upnAmount) upnAmount,
				SUM(downnAmount) downnAmount,
				SUM(tasknAmount) tasknAmount,
				SUM(activitynAmount) activitynAmount,
				SUM(nResultMoney) nResultMoney,
				SUM(nTax) nTax
			FROM
				table_web_clubmemberproxy
			WHERE
				nClubId = 10017
			AND tEndTime >= '2020-07-02 00:00:00'
			AND tEndTime <= '2020-07-02 23:59:59'
			GROUP BY
				nClubId,
				nPlayerId
		) temp2 ON temp.nPlayerID = temp2.nPlayerID
		AND temp.nClubID = temp2.nClubId
	) tempsum;
	
	
------------------------------------------------------------------------------------------------------------------------------------


4. from子查询的执行计划和查询统计 
	desc SELECT nClubId,nPlayerId,nExtenID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
	SELECT count(*) FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	

	mysql> desc SELECT nClubId,nPlayerId,nExtenID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
	+----+-------------+------------------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
	| id | select_type | table            | partitions | type | possible_keys        | key                  | key_len | ref         | rows  | filtered | Extra |
	+----+-------------+------------------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
	|  1 | SIMPLE      | table_clubmember | NULL       | ref  | idx_nClubID_nExtenID | idx_nClubID_nExtenID | 9       | const,const | 18284 |   100.00 | NULL  |
	+----+-------------+------------------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
	1 row in set, 1 warning (0.00 sec)
	
	实践满足条件的只有 10066 行记录，但是 desc.rows = 18284

	mysql> SELECT count(*) FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
	+----------+
	| count(*) |
	+----------+
	|    10066 |
	+----------+
	1 row in set (0.00 sec)

----------------------------------------------------------------------------------------------------------------------------------------------------------

5. from子查询有覆盖索引和没有覆盖索引的耗时对比	
	
	SELECT nClubId,nPlayerId,nExLevel,nExtenID,tJoinTime FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
		-- 0.5S
	SELECT nClubId,nPlayerId,nExtenID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
		-- 0.24S
		
------------------------------------------------------------------------------------------------------------------------------------------------------------



5. from子查询的 show profiles
	SELECT nClubId,nPlayerId,nExLevel,nExtenID,tJoinTime FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
		-- 0.5S
	SELECT nClubId,nPlayerId,nExtenID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
		-- 0.24S
		
	set profiling = 1;
	SELECT nClubId,nPlayerId,nExLevel,nExtenID,tJoinTime FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
	show profiles;
	show profile for query 1;
	mysql> show profile for query 1;
	+--------------------------------+----------+
	| Status                         | Duration |
	+--------------------------------+----------+
	| starting                       | 0.000104 |
	| Waiting for query cache lock   | 0.000014 |
	| starting                       | 0.000008 |
	| checking query cache for query | 0.000074 |
	| checking permissions           | 0.000012 |
	| Opening tables                 | 0.000116 |
	| init                           | 0.000032 |
	| System lock                    | 0.000016 |
	| Waiting for query cache lock   | 0.000008 |
	| System lock                    | 0.000029 |
	| optimizing                     | 0.000017 |
	| statistics                     | 0.000089 |
	| preparing                      | 0.000020 |
	| executing                      | 0.000009 |
	| Sending data                   | 0.000917 |
	| Waiting for query cache lock   | 0.000026 |
	| Sending data                   | 0.000830 |
	| Waiting for query cache lock   | 0.000019 |
	| Sending data                   | 0.000777 |
	| Waiting for query cache lock   | 0.000018 |
	| Sending data                   | 0.000761 |
	| Waiting for query cache lock   | 0.000017 |
	| Sending data                   | 0.000917 |
	| Waiting for query cache lock   | 0.000025 |
	| Sending data                   | 0.000824 |
	| Waiting for query cache lock   | 0.000018 |
	| Sending data                   | 0.000981 |
	| Waiting for query cache lock   | 0.000024 |
	| Sending data                   | 0.000860 |
	| Waiting for query cache lock   | 0.000023 |
	| Sending data                   | 0.000999 |
	| Waiting for query cache lock   | 0.000020 |
	| Sending data                   | 0.001095 |
	| Waiting for query cache lock   | 0.000022 |
	| Sending data                   | 0.015708 |
	| end                            | 0.000038 |
	| query end                      | 0.000015 |
	| closing tables                 | 0.000014 |
	| freeing items                  | 0.000031 |
	| cleaning up                    | 0.000017 |
	+--------------------------------+----------+
	40 rows in set, 1 warning (0.00 sec)

	mysql> show profile cpu,block io for query 1;
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| starting                       | 0.000104 | 0.000079 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000014 | 0.000011 |   0.000000 |            0 |             0 |
	| starting                       | 0.000008 | 0.000008 |   0.000000 |            0 |             0 |
	| checking query cache for query | 0.000074 | 0.000075 |   0.000000 |            0 |             0 |
	| checking permissions           | 0.000012 | 0.000012 |   0.000000 |            0 |             0 |
	| Opening tables                 | 0.000116 | 0.000000 |   0.000117 |            0 |             0 |
	| init                           | 0.000032 | 0.000002 |   0.000029 |            0 |             0 |
	| System lock                    | 0.000016 | 0.000015 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000008 | 0.000008 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000029 | 0.000029 |   0.000000 |            0 |             0 |
	| optimizing                     | 0.000017 | 0.000017 |   0.000000 |            0 |             0 |
	| statistics                     | 0.000089 | 0.000090 |   0.000000 |            0 |             0 |
	| preparing                      | 0.000020 | 0.000018 |   0.000000 |            0 |             0 |
	| executing                      | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000917 | 0.000637 |   0.000293 |            0 |             0 |
	| Waiting for query cache lock   | 0.000026 | 0.000014 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000830 | 0.000544 |   0.000292 |            0 |             0 |
	| Waiting for query cache lock   | 0.000019 | 0.000012 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000777 | 0.000637 |   0.000147 |            0 |             0 |
	| Waiting for query cache lock   | 0.000018 | 0.000012 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000761 | 0.000472 |   0.000292 |            0 |             0 |
	| Waiting for query cache lock   | 0.000017 | 0.000012 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000917 | 0.001059 |   0.000293 |            0 |             0 |
	| Waiting for query cache lock   | 0.000025 | 0.000035 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000824 | 0.000769 |   0.000292 |            0 |             8 |
	| Waiting for query cache lock   | 0.000018 | 0.000012 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000981 | 0.000911 |   0.000439 |            0 |             8 |
	| Waiting for query cache lock   | 0.000024 | 0.000014 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000860 | 0.000652 |   0.000293 |            0 |             8 |
	| Waiting for query cache lock   | 0.000023 | 0.000013 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000999 | 0.000797 |   0.000293 |            0 |             0 |
	| Waiting for query cache lock   | 0.000020 | 0.000013 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.001095 | 0.001252 |   0.000438 |            0 |             0 |
	| Waiting for query cache lock   | 0.000022 | 0.000014 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.015708 | 0.013475 |   0.005121 |            0 |            88 |
	| end                            | 0.000038 | 0.000000 |   0.000020 |            0 |             0 |
	| query end                      | 0.000015 | 0.000000 |   0.000014 |            0 |             0 |
	| closing tables                 | 0.000014 | 0.000000 |   0.000014 |            0 |             0 |
	| freeing items                  | 0.000031 | 0.000000 |   0.000030 |            0 |             0 |
	| cleaning up                    | 0.000017 | 0.000000 |   0.000017 |            0 |             0 |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	40 rows in set, 1 warning (0.00 sec)


	------------------------------------------------------------------------------------------------------------------------


	set profiling = 1;
	SELECT nClubId,nPlayerId,nExtenID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
	show profiles;
	show profile for query 3;
	mysql> show profile for query 3;
	+--------------------------------+----------+
	| Status                         | Duration |
	+--------------------------------+----------+
	| starting                       | 0.000051 |
	| Waiting for query cache lock   | 0.000011 |
	| starting                       | 0.000008 |
	| checking query cache for query | 0.000140 |
	| checking permissions           | 0.000020 |
	| Opening tables                 | 0.000033 |
	| init                           | 0.000040 |
	| System lock                    | 0.000017 |
	| Waiting for query cache lock   | 0.000009 |
	| System lock                    | 0.000033 |
	| optimizing                     | 0.000018 |
	| statistics                     | 0.000110 |
	| preparing                      | 0.000021 |
	| executing                      | 0.000008 |
	| Sending data                   | 0.001057 |
	| Waiting for query cache lock   | 0.000020 |
	| Sending data                   | 0.000943 |
	| Waiting for query cache lock   | 0.000014 |
	| Sending data                   | 0.000913 |
	| Waiting for query cache lock   | 0.000012 |
	| Sending data                   | 0.000882 |
	| Waiting for query cache lock   | 0.000011 |
	| Sending data                   | 0.000905 |
	| Waiting for query cache lock   | 0.000013 |
	| Sending data                   | 0.000896 |
	| Waiting for query cache lock   | 0.000012 |
	| Sending data                   | 0.000857 |
	| Waiting for query cache lock   | 0.000011 |
	| Sending data                   | 0.000868 |
	| Waiting for query cache lock   | 0.000011 |
	| Sending data                   | 0.000865 |
	| Waiting for query cache lock   | 0.000011 |
	| Sending data                   | 0.000874 |
	| Waiting for query cache lock   | 0.000011 |
	| Sending data                   | 0.000891 |
	| Waiting for query cache lock   | 0.000012 |
	| Sending data                   | 0.000998 |
	| Waiting for query cache lock   | 0.000015 |
	| Sending data                   | 0.000896 |
	| Waiting for query cache lock   | 0.000011 |
	| Sending data                   | 0.001020 |
	| Waiting for query cache lock   | 0.000015 |
	| Sending data                   | 0.000918 |
	| end                            | 0.000017 |
	| query end                      | 0.000017 |
	| closing tables                 | 0.000016 |
	| freeing items                  | 0.000020 |
	| Waiting for query cache lock   | 0.000008 |
	| freeing items                  | 0.000034 |
	| Waiting for query cache lock   | 0.000009 |
	| freeing items                  | 0.000007 |
	| storing result in query cache  | 0.000010 |
	| cleaning up                    | 0.000038 |
	+--------------------------------+----------+
	53 rows in set, 1 warning (0.00 sec)

	mysql> show profile cpu,block io for query 3;
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| starting                       | 0.000051 | 0.000030 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
	| starting                       | 0.000008 | 0.000008 |   0.000000 |            0 |             0 |
	| checking query cache for query | 0.000140 | 0.000145 |   0.000000 |            0 |             0 |
	| checking permissions           | 0.000020 | 0.000016 |   0.000000 |            0 |             0 |
	| Opening tables                 | 0.000033 | 0.000034 |   0.000000 |            0 |             0 |
	| init                           | 0.000040 | 0.000039 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000017 | 0.000017 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000009 | 0.000008 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000033 | 0.000033 |   0.000000 |            0 |             0 |
	| optimizing                     | 0.000018 | 0.000018 |   0.000000 |            0 |             0 |
	| statistics                     | 0.000110 | 0.000000 |   0.000112 |            0 |             0 |
	| preparing                      | 0.000021 | 0.000000 |   0.000019 |            0 |             0 |
	| executing                      | 0.000008 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data                   | 0.001057 | 0.000765 |   0.000301 |            0 |             0 |
	| Waiting for query cache lock   | 0.000020 | 0.000012 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000943 | 0.000653 |   0.000292 |            0 |             0 |
	| Waiting for query cache lock   | 0.000014 | 0.000010 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000913 | 0.000770 |   0.000147 |            0 |             0 |
	| Waiting for query cache lock   | 0.000012 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000882 | 0.000591 |   0.000292 |            0 |             0 |
	| Waiting for query cache lock   | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000905 | 0.000615 |   0.000293 |            0 |             0 |
	| Waiting for query cache lock   | 0.000013 | 0.000010 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000896 | 0.000606 |   0.000292 |            0 |             0 |
	| Waiting for query cache lock   | 0.000012 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000857 | 0.000712 |   0.000147 |            0 |             0 |
	| Waiting for query cache lock   | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000868 | 0.000576 |   0.000292 |            0 |             0 |
	| Waiting for query cache lock   | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000865 | 0.000574 |   0.000293 |            0 |             0 |
	| Waiting for query cache lock   | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000874 | 0.000730 |   0.000146 |            0 |             0 |
	| Waiting for query cache lock   | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000891 | 0.000600 |   0.000293 |            0 |             0 |
	| Waiting for query cache lock   | 0.000012 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000998 | 0.000710 |   0.000292 |            0 |             0 |
	| Waiting for query cache lock   | 0.000015 | 0.000011 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000896 | 0.000605 |   0.000293 |            0 |             0 |
	| Waiting for query cache lock   | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.001020 | 0.000733 |   0.000293 |            0 |             0 |
	| Waiting for query cache lock   | 0.000015 | 0.000010 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000918 | 0.000775 |   0.000146 |            0 |             0 |
	| end                            | 0.000017 | 0.000013 |   0.000000 |            0 |             0 |
	| query end                      | 0.000017 | 0.000016 |   0.000000 |            0 |             0 |
	| closing tables                 | 0.000016 | 0.000016 |   0.000000 |            0 |             0 |
	| freeing items                  | 0.000020 | 0.000020 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000008 | 0.000008 |   0.000000 |            0 |             0 |
	| freeing items                  | 0.000034 | 0.000000 |   0.000034 |            0 |             0 |
	| Waiting for query cache lock   | 0.000009 | 0.000000 |   0.000009 |            0 |             0 |
	| freeing items                  | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| storing result in query cache  | 0.000010 | 0.000000 |   0.000009 |            0 |             0 |
	| cleaning up                    | 0.000038 | 0.000000 |   0.000038 |            0 |             0 |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	53 rows in set, 1 warning (0.00 sec)

	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

6. 慢SQL语句的执行计划、show profiles和优化器追踪

6.1 慢SQL语句的执行计划
SELECT
count(1) totalCount,
SUM(recharge) recharge,
SUM(withdrawal) withdrawal,
SUM(rechargeCount) rechargeCount,
SUM(rechargeNumber) rechargeNumber,
SUM(withdrawalCount) withdrawalCount,
SUM(withdrawalNumber) withdrawalNumber,
SUM(teamVipCount) teamVipCount,
SUM(addTeamCount) addTeamCount,
SUM(weekMyRebate) weekMyRebate,
SUM(teamRebate) teamRebate,
SUM(water) water,
SUM(directlyWater) directlyWater,
SUM(addDirectlyVipCount) addDirectlyVipCount,
SUM(teamWater) teamWater,
SUM(directlyVipCount) directlyVipCount,
SUM(upnAmount) upnAmount,
SUM(downnAmount) downnAmount,
SUM(tasknAmount) tasknAmount,
SUM(activitynAmount) activitynAmount,
SUM(nResultMoney) nResultMoney,
SUM(nTax) nTax,
SUM(nScore) nScore
FROM
(
SELECT
temp.nClubID,
temp.nPlayerID,
temp.nExtenID,
temp.nExLevel,
IFNULL(recharge, 0) recharge,
IFNULL(withdrawal, 0) withdrawal,
IFNULL(rechargeCount, 0) rechargeCount,
IFNULL(rechargeNumber, 0) rechargeNumber,
IFNULL(withdrawalCount, 0) withdrawalCount,
IFNULL(withdrawalNumber, 0) withdrawalNumber,
IFNULL(water, 0) water,
IFNULL(directlyWater, 0) directlyWater,
IFNULL(teamWater, 0) teamWater,
IFNULL(upnAmount, 0) upnAmount,
IFNULL(downnAmount, 0) downnAmount,
IFNULL(tasknAmount, 0) tasknAmount,
IFNULL(activitynAmount, 0) activitynAmount,
IFNULL(nResultMoney, 0) nResultMoney,
IFNULL(nTax, 0) nTax,
(
SELECT
IFNULL(nScore, 0) nScore
FROM
table_clublogscore
WHERE
clubID = 10017
AND nPlayerID = temp.nPlayerID
AND CreateTime <= '2020-07-02 23:59:59'
ORDER BY
ID DESC
LIMIT 0,
1
) nScore,
(
SELECT
count(1)
FROM
table_clubmember
WHERE
nClubId = 10017
AND nExtenID = temp.nPlayerID
AND tJoinTime <= '2020-07-02 23:59:59'
) directlyVipCount,
(
SELECT
count(1)
FROM
table_clubmember
WHERE
nClubId = 10017
AND nExtenID = temp.nPlayerID
AND tJoinTime >= '2020-07-02 00:00:00'
AND tJoinTime <= '2020-07-02 23:59:59'
) addDirectlyVipCount,
(
SELECT
count(1)
FROM
table_clubmemberAppLine
WHERE
nPlayerID = temp.nPlayerID
AND tJoinTime <= '2020-07-02 23:59:59'
) teamVipCount,
(
SELECT
count(1)
FROM
table_clubmemberAppLine
WHERE
nPlayerID = temp.nPlayerID
AND tJoinTime >= '2020-07-02 00:00:00'
AND tJoinTime <= '2020-07-02 23:59:59'
) addTeamCount,
(
SELECT
IFNULL(sum(nAmount), 0) nAmount
FROM
table_clublogscore
WHERE
nType = 26
AND clubid = 10017
AND nPlayerId = temp.nPlayerID
AND CreateTime >= '2020-07-02 00:00:00'
AND CreateTime <= '2020-07-02 23:59:59'
) weekMyRebate,
(
SELECT
IFNULL(SUM(nAmount), 0) nAmount
FROM
table_clubmemberAppLine line
LEFT JOIN table_clublogscore log ON line.nNextID = log.nPlayerID
WHERE
line.nPlayerID = temp.nPlayerID
AND log.nType = 26
AND log.clubid = 10017
AND CreateTime >= '2020-07-02 00:00:00'
AND CreateTime <= '2020-07-02 23:59:59'
) teamRebate
FROM
(
SELECT
nClubId,
nPlayerId,
nExLevel,
nExtenID,
tJoinTime
FROM
table_clubmember
WHERE
nClubId = 10017
AND nExtenID = 132806
) temp
LEFT JOIN (
SELECT
nClubId,
nPlayerId,
SUM(recharge) recharge,
SUM(withdrawal) withdrawal,
SUM(rechargeCount) rechargeCount,
SUM(rechargeNumber) rechargeNumber,
SUM(withdrawalCount) withdrawalCount,
SUM(withdrawalNumber) withdrawalNumber,
SUM(water) water,
SUM(directlyWater) directlyWater,
SUM(teamWater) teamWater,
SUM(upnAmount) upnAmount,
SUM(downnAmount) downnAmount,
SUM(tasknAmount) tasknAmount,
SUM(activitynAmount) activitynAmount,
SUM(nResultMoney) nResultMoney,
SUM(nTax) nTax
FROM
table_web_clubmemberproxy
WHERE
nClubId = 10017
AND tEndTime >= '2020-07-02 00:00:00'
AND tEndTime <= '2020-07-02 23:59:59'
GROUP BY
nClubId,
nPlayerId
) temp2 ON temp.nPlayerID = temp2.nPlayerID
AND temp.nClubID = temp2.nClubId
) tempsum;

+----+--------------------+---------------------------+------------+-------+-------------------------------------------------------------------------------------------------+---------------------------------+---------+-------------+-------+----------+--------------------------------------------------------+
| id | select_type        | table                     | partitions | type  | possible_keys                                                                                   | key                             | key_len | ref         | rows  | filtered | Extra                                                  |
+----+--------------------+---------------------------+------------+-------+-------------------------------------------------------------------------------------------------+---------------------------------+---------+-------------+-------+----------+--------------------------------------------------------+
|  1 | PRIMARY            | <derived2>                | NULL       | ALL   | NULL                                                                                            | NULL                            | NULL    | NULL        | 73136 |   100.00 | NULL                                                   |
|  2 | DERIVED            | table_clubmember          | NULL       | ref   | idx_nClubID_nExtenID                                                                            | idx_nClubID_nExtenID            | 9       | const,const | 18284 |   100.00 | NULL                                                   |
|  2 | DERIVED            | <derived11>               | NULL       | ALL   | NULL                                                                                            | NULL                            | NULL    | NULL        |     4 |   100.00 | Using where; Using join buffer (Block Nested Loop)     |
| 11 | DERIVED            | table_web_clubmemberproxy | NULL       | range | idx_nClubID_tEndTime,idx_nClubID_nPlayerId_tEndTime                                             | idx_nClubID_tEndTime            | 10      | NULL        |     4 |   100.00 | Using index condition; Using temporary; Using filesort |
|  9 | DEPENDENT SUBQUERY | log                       | NULL       | range | idx_nPlayerID_clubid_CreateTime,idx_clubid_nType_CreateTime,idx_CreateTime,idx_nType_CreateTime | idx_clubid_nType_CreateTime     | 13      | NULL        |     1 |   100.00 | Using index condition                                  |
|  9 | DEPENDENT SUBQUERY | line                      | NULL       | ref   | index_nPlayerID_tJoinTime                                                                       | index_nPlayerID_tJoinTime       | 4       | func        |    53 |    10.00 | Using index condition; Using where                     |
|  8 | DEPENDENT SUBQUERY | table_clublogscore        | NULL       | range | idx_nPlayerID_clubid_CreateTime,idx_clubid_nType_CreateTime,idx_CreateTime,idx_nType_CreateTime | idx_clubid_nType_CreateTime     | 13      | NULL        |     1 |    10.00 | Using index condition; Using where                     |
|  7 | DEPENDENT SUBQUERY | table_clubmemberAppLine   | NULL       | ref   | index_nPlayerID_tJoinTime                                                                       | index_nPlayerID_tJoinTime       | 4       | func        |    53 |    11.11 | Using where; Using index                               |
|  6 | DEPENDENT SUBQUERY | table_clubmemberAppLine   | NULL       | ref   | index_nPlayerID_tJoinTime                                                                       | index_nPlayerID_tJoinTime       | 4       | func        |    53 |    33.33 | Using where; Using index                               |
|  5 | DEPENDENT SUBQUERY | table_clubmember          | NULL       | ref   | index_tJoinTime,idx_nClubID_nExtenID                                                            | idx_nClubID_nExtenID            | 9       | const,func  |   123 |     0.16 | Using index condition; Using where                     |
|  4 | DEPENDENT SUBQUERY | table_clubmember          | NULL       | ref   | index_tJoinTime,idx_nClubID_nExtenID                                                            | idx_nClubID_nExtenID            | 9       | const,func  |   123 |    50.00 | Using index condition; Using where                     |
|  3 | DEPENDENT SUBQUERY | table_clublogscore        | NULL       | ref   | idx_nPlayerID_clubid_CreateTime,idx_clubid_nType_CreateTime,idx_CreateTime                      | idx_nPlayerID_clubid_CreateTime | 9       | func,const  |   359 |    50.00 | Using index condition; Using filesort                  |
+----+--------------------+---------------------------+------------+-------+-------------------------------------------------------------------------------------------------+---------------------------------+---------+-------------+-------+----------+--------------------------------------------------------+
12 rows in set, 8 warnings (0.01 sec)

6.2 SQL语句的性能问题 
	1. 从table_clubmember 扫描 18284 行记录， 最终返回 10664 行记录，还需要遍历 10664 行记录去查询 取出 nScore，directlyVipCount，addDirectlyVipCount，teamVipCount，addTeamCount，weekMyRebate，teamRebate
		
		整个SQL语句执行在慢查询日志中记录的耗时约 1.6S(通过navicat查询耗时也是1.6S), 而 from 子查询这里就耗时了1.2S:
			SELECT
				nClubId,
				nPlayerId,
				nExLevel,
				nExtenID,
				tJoinTime
			FROM
				table_clubmember
			WHERE
				nClubId = 10017
			AND nExtenID = 132806
		
		整个SQL语句通过本地客户端(命令行)执行耗时约0.45 秒.
		
	2. Using temporary; Using filesort |	
		GROUP BY nClubId, nPlayerId 改为  GROUP BY nClubId, nPlayerId order by null  就可以消除 Using filesort
	
	3. Using index condition; Using filesort
		ORDER BY ID DESC LIMIT 0,1 改为 ORDER BY CreateTime DESC LIMIT 0,1  就可以消除 Using filesort
 	
6.3 show profiles
	mysql>  show profile cpu,block io for query 1;
	+---------------------+----------+----------+------------+--------------+---------------+
	| Status              | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+---------------------+----------+----------+------------+--------------+---------------+
	| Creating sort index | 0.000018 | 0.000000 |   0.000018 |            0 |             0 |    表示需要用到临时表进行order by, 添加上  order by null 呢？
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000011 | 0.000000 |   0.000011 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000011 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Sending data        | 0.000009 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000009 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000015 | 0.000000 |   0.000015 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000008 |            0 |             0 |
	| Sending data        | 0.000019 | 0.000000 |   0.000019 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Creating sort index | 0.000017 | 0.000000 |   0.000017 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000011 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000009 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Sending data        | 0.000009 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000015 | 0.000000 |   0.000015 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000020 | 0.000000 |   0.000020 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Creating sort index | 0.000014 | 0.000000 |   0.000014 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000011 | 0.000000 |   0.000011 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000011 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Sending data        | 0.000009 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000009 |            0 |             0 |
	| executing           | 0.000017 | 0.000000 |   0.000017 |            0 |             0 |
	| Sending data        | 0.000017 | 0.000000 |   0.000017 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000008 |            0 |             0 |
	| Sending data        | 0.000020 | 0.000000 |   0.000020 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Creating sort index | 0.000017 | 0.000000 |   0.000018 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000011 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000009 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000016 | 0.000000 |   0.000016 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000012 |            0 |             0 |
	| Sending data        | 0.000025 | 0.000000 |   0.000020 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000008 |            0 |             0 |
	| Sending data        | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Creating sort index | 0.000016 | 0.000000 |   0.000016 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000011 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000011 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000006 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000009 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000015 | 0.000000 |   0.000015 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000019 | 0.000000 |   0.000020 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Creating sort index | 0.000016 | 0.000000 |   0.000016 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000010 | 0.000000 |   0.000009 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000009 | 0.000000 |   0.000010 |            0 |             0 |
	| executing           | 0.000007 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.000015 | 0.000000 |   0.000015 |            0 |             0 |
	| executing           | 0.000008 | 0.000000 |   0.000007 |            0 |             0 |
	| Sending data        | 0.020093 | 0.000000 |   0.023377 |            0 |            88 |          -- 这里慢, 说明查询返回的数据相关较多.
	| end                 | 0.000047 | 0.000000 |   0.000081 |            0 |             8 |
	| query end           | 0.000027 | 0.000000 |   0.000031 |            0 |             0 |
	| removing tmp table  | 0.000015 | 0.000000 |   0.000015 |            0 |             0 |
	| query end           | 0.000021 | 0.000000 |   0.000020 |            0 |             0 |
	| closing tables      | 0.000009 | 0.000000 |   0.000010 |            0 |             0 |
	| removing tmp table  | 0.000019 | 0.000000 |   0.000018 |            0 |             0 |
	| closing tables      | 0.000008 | 0.000000 |   0.000008 |            0 |             0 |
	| removing tmp table  | 0.000011 | 0.000000 |   0.000012 |            0 |             0 |
	| closing tables      | 0.000016 | 0.000000 |   0.000016 |            0 |             0 |
	| freeing items       | 0.000085 | 0.000000 |   0.000090 |            0 |             0 |
	| logging slow query  | 0.000066 | 0.000000 |   0.000062 |            0 |            16 |
	| cleaning up         | 0.000044 | 0.000000 |   0.000042 |            0 |             0 |
	+---------------------+----------+----------+------------+--------------+---------------+
	100 rows in set, 1 warning (0.00 sec)



6.4 优化器追踪(optimizer_trace)
	SET optimizer_trace='enabled=on'; 

	执行SQL 

	SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 
	mysql> SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G; 
	*************************** 1. row ***************************
								QUERY: SELECT
	count(1) totalCount,
	SUM(recharge) recharge,
	SUM(withdrawal) withdrawal,
	SUM(rechargeCount) rechargeCount,
	SUM(rechargeNumber) rechargeNumber,
	SUM(withdrawalCount) withdrawalCount,
	SUM(withdrawalNumber) withdrawalNumber,
	SUM(teamVipCount) teamVipCount,
	SUM(addTeamCount) addTeamCount,
	SUM(weekMyRebate) weekMyRebate,
	SUM(teamRebate) teamRebate,
	SUM(water) water,
	SUM(directlyWater) directlyWater,
	SUM(addDirectlyVipCount) addDirectlyVipCount,
	SUM(teamWater) teamWater,
	SUM(directlyVipCount) directlyVipCount,
	SUM(upnAmount) upnAmount,
	SUM(downnAmount) downnAmount,
	SUM(tasknAmount) tasknAmount,
	SUM(activitynAmount) activitynAmount,
	SUM(nResultMoney) nResultMoney,
	SUM(nTax) nTax,
	SUM(nScore) nScore
	FROM
	(
	SELECT
	temp.nClubID,
	temp.nPlayerID,
	temp.nExtenID,
	temp.nExLevel,
	IFNULL(recharge, 0) recharge,
	IFNULL(withdrawal, 0) withdrawal,
	IFNULL(rechargeCount, 0) rechargeCount,
	IFNULL(rechargeNumber, 0) rechargeNumber,
	IFNULL(withdrawalCount, 0) withdrawalCount,
	IFNULL(withdrawalNumber, 0) withdrawalNumber,
	IFNULL(water, 0) water,
	IFNULL(directlyWater, 0) directlyWater,
	IFNULL(teamWater, 0) teamWater,
	IFNULL(upnAmount, 0) upnAmount,
	IFNULL(downnAmount, 0) downnAmount,
	IFNULL(tasknAmount, 0) tasknAmount,
	IFNULL(activitynAmount, 0) activitynAmount,
	IFNULL(nResultMoney, 0) nResultMoney,
	IFNULL(nTax, 0) nTax,
	(
	SELECT
	IFNULL(nScore, 0) nScore
	FROM
	table_clublogscore
	WHERE
	clubID = 10017
	AND nPlayerID = temp.nPlayerID
	AND CreateTime <= '2020-07-02 23:59:59'
	ORDER BY
	CreateTime DESC
	LIMIT 0,
	1
	) nScore,
	(
	SELECT
	count(1)
	FROM
	table_clubmember
	WHERE
	nClubId = 10017
	AND nExtenID = temp.nPlayerID
	AND tJoinTime <= '2020-07-02 23:59:59'
	) directlyVipCount,
	(
	SELECT
	count(1)
	FROM
	table_clubmember
	WHERE
	nClubId = 10017
	AND nExtenID = temp.nPlayerID
	AND tJoinTime >= '2020-07-02 00:00:00'
	AND tJoinTime <= '2020-07-02 23:59:59'
	) addDirectlyVipCount,
	(
	SELECT
	count(1)
	FROM
	table_clubmemberAppLine
	WHERE
	nPlayerID = temp.nPlayerID
	AND tJoinTime <= '2020-07-02 23:59:59'
	) teamVipCount,
	(
	SELECT
	count(1)
	FROM
	table_clubmemberAppLine
	WHERE
	nPlayerID = temp.nPlayerID
	AND tJoinTime >= '2020-07-02 00:00:00'
	AND tJoinTime <= '2020-07-02 23:59:59'
	) addTeamCount,
	(
	SELECT
	IFNULL(sum(nAmount), 0) nAmount
	FROM
	table_clublogscore
	WHERE
	nType = 26
	AND clubid = 10017
	AND nPlayerId = temp.nPlayerID
	AND CreateTime >= '2020-07-02 00:00:00'
	AND CreateTime <= '2020-07-02 23:59:59'
	) weekMyRebate,
	(
	SELECT
	IFNULL(SUM(nAmount), 0) nAmount
	FROM
	table_clubmemberAppLine line
	LEFT JOIN table_clublogscore log ON line.nNextID = log.nPlayerID
	WHERE
	line.nPlayerID = temp.nPlayerID
	AND log.nType = 26
	AND log.clubid = 10017
	AND CreateTime >= '2020-07-02 00:00:00'
	AND CreateTime <= '2020-07-02 23:59:59'
	) teamRebate
	FROM
	(
	SELECT
	nClubId,
	nPlayerId,
	nExLevel,
	nExtenID,
	tJoinTime
	FROM
	table_clubmember
	WHERE
	nClubId = 10017
	AND nExtenID = 132806
	) temp
	LEFT JOIN (
	SELECT
	nClubId,
	nPlayerId,
	SUM(recharge) recharge,
	SUM(withdrawal) withdrawal,
	SUM(rechargeCount) rechargeCount,
	SUM(rechargeNumber) rechargeNumber,
	SUM(withdrawalCount) withdrawalCount,
	SUM(withdrawalNumber) withdrawalNumber,
	SUM(water) water,
	SUM(directlyWater) directlyWater,
	SUM(teamWater) teamWater,
	SUM(upnAmount) upnAmount,
	SUM(downnAmount) downnAmount,
	SUM(tasknAmount) tasknAmount,
	SUM(activitynAmount) activitynAmount,
	SUM(nResultMoney) nResultMoney,
	SUM(nTax) nTax
	FROM
	table_web_clubmemberproxy
	WHERE
	nClubId = 10017
	AND tEndTime >= '2020-07-02 00:00:00'
	AND tEndTime <= '2020-07-02 23:59:59'
	GROUP BY
	nClubId,
	nPlayerId
	) temp2 ON temp.nPlayerID = temp2.nPlayerID
	AND temp.nClubID = temp2.nClubId
	) tempsum
								TRACE: {
	  "steps": [
		{
		  "join_preparation": {
			"select#": 1,
			"steps": [
			  {
				"join_preparation": {
				  "select#": 2,
				  "steps": [
					{
					  "join_preparation": {
						"select#": 10,
						"steps": [
						  {
							"expanded_query": "/* select#10 */ select `table_clubmember`.`nClubID` AS `nClubId`,`table_clubmember`.`nPlayerID` AS `nPlayerId`,`table_clubmember`.`nExLevel` AS `nExLevel`,`table_clubmember`.`nExtenID` AS `nExtenID`,`table_clubmember`.`tJoinTime` AS `tJoinTime` from `table_clubmember` where ((`table_clubmember`.`nClubID` = 10017) and (`table_clubmember`.`nExtenID` = 132806))"
						  }
						]
					  }
					},
					{
					  "join_preparation": {
						"select#": 11,
						"steps": [
						  {
							"expanded_query": "/* select#11 */ select `table_web_clubmemberproxy`.`nClubId` AS `nClubId`,`table_web_clubmemberproxy`.`nPlayerId` AS `nPlayerId`,sum(`table_web_clubmemberproxy`.`recharge`) AS `recharge`,sum(`table_web_clubmemberproxy`.`withdrawal`) AS `withdrawal`,sum(`table_web_clubmemberproxy`.`rechargeCount`) AS `rechargeCount`,sum(`table_web_clubmemberproxy`.`rechargeNumber`) AS `rechargeNumber`,sum(`table_web_clubmemberproxy`.`withdrawalCount`) AS `withdrawalCount`,sum(`table_web_clubmemberproxy`.`withdrawalNumber`) AS `withdrawalNumber`,sum(`table_web_clubmemberproxy`.`water`) AS `water`,sum(`table_web_clubmemberproxy`.`directlyWater`) AS `directlyWater`,sum(`table_web_clubmemberproxy`.`teamWater`) AS `teamWater`,sum(`table_web_clubmemberproxy`.`upnAmount`) AS `upnAmount`,sum(`table_web_clubmemberproxy`.`downnAmount`) AS `downnAmount`,sum(`table_web_clubmemberproxy`.`tasknAmount`) AS `tasknAmount`,sum(`table_web_clubmemberproxy`.`activitynAmount`) AS `activitynAmount`,sum(`table_web_clubmemberproxy`.`nResultMoney`) AS `nResultMoney`,sum(`table_web_clubmemberproxy`.`nTax`) AS `nTax` from `table_web_clubmemberproxy` where ((`table_web_clubmemberproxy`.`nClubId` = 10017) and (`table_web_clubmemberproxy`.`tEndTime` >= '2020-07-02 00:00:00') and (`table_web_clubmemberproxy`.`tEndTime` <= '2020-07-02 23:59:59')) group by `table_web_clubmemberproxy`.`nClubId`,`table_web_clubmemberproxy`.`nPlayerId`"
						  }
						]
					  }
					},
					{
					  "derived": {
						"table": "``.`` `temp`",
						"select#": 10,
						"merged": true
					  }
					},
					{
					  "derived": {
						"table": " `temp2`",
						"select#": 11,
						"materialized": true
					  }
					},
					{
					  "join_preparation": {
						"select#": 3,
						"steps": [
						  {
							"expanded_query": "/* select#3 */ select ifnull(`table_clublogscore`.`nScore`,0) AS `nScore` from `table_clublogscore` where ((`table_clublogscore`.`clubid` = 10017) and (`table_clublogscore`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`table_clublogscore`.`CreateTime` <= '2020-07-02 23:59:59')) order by `table_clublogscore`.`CreateTime` desc limit 0,1"
						  }
						]
					  }
					},
					{
					  "join_preparation": {
						"select#": 4,
						"steps": [
						  {
							"expanded_query": "/* select#4 */ select count(1) from `table_clubmember` where ((`table_clubmember`.`nClubID` = 10017) and (`table_clubmember`.`nExtenID` = `table_clubmember`.`nPlayerID`) and (`table_clubmember`.`tJoinTime` <= '2020-07-02 23:59:59'))"
						  }
						]
					  }
					},
					{
					  "join_preparation": {
						"select#": 5,
						"steps": [
						  {
							"expanded_query": "/* select#5 */ select count(1) from `table_clubmember` where ((`table_clubmember`.`nClubID` = 10017) and (`table_clubmember`.`nExtenID` = `table_clubmember`.`nPlayerID`) and (`table_clubmember`.`tJoinTime` >= '2020-07-02 00:00:00') and (`table_clubmember`.`tJoinTime` <= '2020-07-02 23:59:59'))"
						  }
						]
					  }
					},
					{
					  "join_preparation": {
						"select#": 6,
						"steps": [
						  {
							"expanded_query": "/* select#6 */ select count(1) from `table_clubmemberappline` where ((`table_clubmemberappline`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`table_clubmemberappline`.`tJoinTime` <= '2020-07-02 23:59:59'))"
						  }
						]
					  }
					},
					{
					  "join_preparation": {
						"select#": 7,
						"steps": [
						  {
							"expanded_query": "/* select#7 */ select count(1) from `table_clubmemberappline` where ((`table_clubmemberappline`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`table_clubmemberappline`.`tJoinTime` >= '2020-07-02 00:00:00') and (`table_clubmemberappline`.`tJoinTime` <= '2020-07-02 23:59:59'))"
						  }
						]
					  }
					},
					{
					  "join_preparation": {
						"select#": 8,
						"steps": [
						  {
							"expanded_query": "/* select#8 */ select ifnull(sum(`table_clublogscore`.`nAmount`),0) AS `nAmount` from `table_clublogscore` where ((`table_clublogscore`.`nType` = 26) and (`table_clublogscore`.`clubid` = 10017) and (`table_clublogscore`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`table_clublogscore`.`CreateTime` >= '2020-07-02 00:00:00') and (`table_clublogscore`.`CreateTime` <= '2020-07-02 23:59:59'))"
						  }
						]
					  }
					},
					{
					  "join_preparation": {
						"select#": 9,
						"steps": [
						  {
							"expanded_query": "/* select#9 */ select ifnull(sum(`log`.`nAmount`),0) AS `nAmount` from (`table_clubmemberappline` `line` left join `table_clublogscore` `log` on((`line`.`nNextID` = `log`.`nPlayerID`))) where ((`line`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`log`.`nType` = 26) and (`log`.`clubid` = 10017) and (`log`.`CreateTime` >= '2020-07-02 00:00:00') and (`log`.`CreateTime` <= '2020-07-02 23:59:59'))"
						  }
						]
					  }
					},
					{
					  "expanded_query": "/* select#2 */ select `table_clubmember`.`nClubID` AS `nClubId`,`table_clubmember`.`nPlayerID` AS `nPlayerId`,`table_clubmember`.`nExtenID` AS `nExtenID`,`table_clubmember`.`nExLevel` AS `nExLevel`,ifnull(`temp2`.`recharge`,0) AS `recharge`,ifnull(`temp2`.`withdrawal`,0) AS `withdrawal`,ifnull(`temp2`.`rechargeCount`,0) AS `rechargeCount`,ifnull(`temp2`.`rechargeNumber`,0) AS `rechargeNumber`,ifnull(`temp2`.`withdrawalCount`,0) AS `withdrawalCount`,ifnull(`temp2`.`withdrawalNumber`,0) AS `withdrawalNumber`,ifnull(`temp2`.`water`,0) AS `water`,ifnull(`temp2`.`directlyWater`,0) AS `directlyWater`,ifnull(`temp2`.`teamWater`,0) AS `teamWater`,ifnull(`temp2`.`upnAmount`,0) AS `upnAmount`,ifnull(`temp2`.`downnAmount`,0) AS `downnAmount`,ifnull(`temp2`.`tasknAmount`,0) AS `tasknAmount`,ifnull(`temp2`.`activitynAmount`,0) AS `activitynAmount`,ifnull(`temp2`.`nResultMoney`,0) AS `nResultMoney`,ifnull(`temp2`.`nTax`,0) AS `nTax`,(/* select#3 */ select ifnull(`table_clublogscore`.`nScore`,0) AS `nScore` from `table_clublogscore` where ((`table_clublogscore`.`clubid` = 10017) and (`table_clublogscore`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`table_clublogscore`.`CreateTime` <= '2020-07-02 23:59:59')) order by `table_clublogscore`.`CreateTime` desc limit 0,1) AS `nScore`,(/* select#4 */ select count(1) from `table_clubmember` where ((`table_clubmember`.`nClubID` = 10017) and (`table_clubmember`.`nExtenID` = `table_clubmember`.`nPlayerID`) and (`table_clubmember`.`tJoinTime` <= '2020-07-02 23:59:59'))) AS `directlyVipCount`,(/* select#5 */ select count(1) from `table_clubmember` where ((`table_clubmember`.`nClubID` = 10017) and (`table_clubmember`.`nExtenID` = `table_clubmember`.`nPlayerID`) and (`table_clubmember`.`tJoinTime` >= '2020-07-02 00:00:00') and (`table_clubmember`.`tJoinTime` <= '2020-07-02 23:59:59'))) AS `addDirectlyVipCount`,(/* select#6 */ select count(1) from `table_clubmemberappline` where ((`table_clubmemberappline`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`table_clubmemberappline`.`tJoinTime` <= '2020-07-02 23:59:59'))) AS `teamVipCount`,(/* select#7 */ select count(1) from `table_clubmemberappline` where ((`table_clubmemberappline`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`table_clubmemberappline`.`tJoinTime` >= '2020-07-02 00:00:00') and (`table_clubmemberappline`.`tJoinTime` <= '2020-07-02 23:59:59'))) AS `addTeamCount`,(/* select#8 */ select ifnull(sum(`table_clublogscore`.`nAmount`),0) AS `nAmount` from `table_clublogscore` where ((`table_clublogscore`.`nType` = 26) and (`table_clublogscore`.`clubid` = 10017) and (`table_clublogscore`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`table_clublogscore`.`CreateTime` >= '2020-07-02 00:00:00') and (`table_clublogscore`.`CreateTime` <= '2020-07-02 23:59:59'))) AS `weekMyRebate`,(/* select#9 */ select ifnull(sum(`log`.`nAmount`),0) AS `nAmount` from (`table_clubmemberappline` `line` left join `table_clublogscore` `log` on((`line`.`nNextID` = `log`.`nPlayerID`))) where ((`line`.`nPlayerID` = `table_clubmember`.`nPlayerID`) and (`log`.`nType` = 26) and (`log`.`clubid` = 10017) and (`log`.`CreateTime` >= '2020-07-02 00:00:00') and (`log`.`CreateTime` <= '2020-07-02 23:59:59'))) AS `teamRebate` from ((`table_clubmember`) left join (/* select#11 */ select `table_web_clubmemberproxy`.`nClubId` AS `nClubId`,`table_web_clubmemberproxy`.`nPlayerId` AS `nPlayerId`,sum(`table_web_clubmemberproxy`.`recharge`) AS `recharge`,sum(`table_web_clubmemberproxy`.`withdrawal`) AS `withdrawal`,sum(`table_web_clubmemberproxy`.`rechargeCount`) AS `rechargeCount`,sum(`table_web_clubmemberproxy`.`rechargeNumber`) AS `rechargeNumber`,sum(`table_web_clubmemberproxy`.`withdrawalCount`) AS `withdrawalCount`,sum(`table_web_clubmemberproxy`.`withdrawalNumber`) AS `withdrawalNumber`,sum(`table_web_clubmemberproxy`.`water`) AS `water`,sum(`table_web_clubmemberproxy`.`directlyWater`) AS `directlyWater`,sum(`table_web_clubmemberproxy`.`teamWater`) AS `teamWater`,sum(`table_web_clubmemberproxy`.`upnAmount`) AS `upnAmount`,sum(`table_web_clubmemberproxy`.`downnAmount`) AS `downnAmount`,sum(`table_web_clubmemberproxy`.`tasknAmount`) AS `tasknAmount`,sum(`table_web_clubmemberproxy`.`activitynAmount`) AS `activitynAmount`,sum(`table_web_clubmemberproxy`.`nResultMoney`) AS `nResultMoney`,sum(`table_web_clubmemberproxy`.`nTax`) AS `nTax` from `table_web_clubmemberproxy` where ((`table_web_clubmemberproxy`.`nClubId` = 10017) and (`table_web_clubmemberproxy`.`tEndTime` >= '2020-07-02 00:00:00') and (`table_web_clubmemberproxy`.`tEndTime` <= '2020-07-02 23:59:59')) group by `table_web_clubmemberproxy`.`nClubId`,`table_web_clubmemberproxy`.`nPlayerId`) `temp2` on(((`table_clubmember`.`nPlayerID` = `temp2`.`nPlayerId`) and (`table_clubmember`.`nClubID` = `temp2`.`nClubId`))))
	MISSING_BYTES_BEYOND_MAX_MEM_SIZE: 41262920
			  INSUFFICIENT_PRIVILEGES: 0
	1 row in set (0.00 sec)

	ERROR: 
	No query specified
	

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

7. 优化方向
	1. 使用覆盖索引
		KEY `idx_nClubID_nExtenID` (`nClubID`,`nExtenID`) 改为  KEY `idx_nClubID_nExtenID_nPlayerID` (`nClubID`,`nExtenID`,`nPlayerID`)
			
		子查询
			SELECT
				nClubId,
				nPlayerId,
				nExLevel,
				nExtenID,
				tJoinTime
			FROM
				table_clubmember
			WHERE
				nClubId = 10017
			AND nExtenID = 132806	
			
		改写为 
			
			SELECT
				nClubId,
				nPlayerId,
				nExtenID
			FROM
				table_clubmember
			WHERE
				nClubId = 10017
			AND nExtenID = 132806
			
			-- 实际上 nExLevel 和 tJoinTime 字段是不需要查询出来的。
			
	2. Using temporary; Using filesort |	
		GROUP BY nClubId, nPlayerId 改为  GROUP BY nClubId, nPlayerId order by null  就可以消除 Using filesort

	3. Using index condition; Using filesort
		ORDER BY ID DESC LIMIT 0,1 改为 ORDER BY CreateTime DESC LIMIT 0,1  就可以消除 Using filesort
			

8. 验证下使用覆盖索引带来的查询性能上的提升
	
	优化前1.8S VS 优化后 1.35S
	
	如果在数据量更大的情况下，优化效果可能会更明显。
	

9. 小结
	SQL语句很长，不用慌，分段来看，分段执行，找出SQL语句的瓶颈点。
	
	
---------------------------------------------------------------------------------

SELECT
count(1) totalCount,
SUM(recharge) recharge,
SUM(withdrawal) withdrawal,
SUM(rechargeCount) rechargeCount,
SUM(rechargeNumber) rechargeNumber,
SUM(withdrawalCount) withdrawalCount,
SUM(withdrawalNumber) withdrawalNumber,
SUM(teamVipCount) teamVipCount,
SUM(addTeamCount) addTeamCount,
SUM(weekMyRebate) weekMyRebate,
SUM(teamRebate) teamRebate,
SUM(water) water,
SUM(directlyWater) directlyWater,
SUM(addDirectlyVipCount) addDirectlyVipCount,
SUM(teamWater) teamWater,
SUM(directlyVipCount) directlyVipCount,
SUM(upnAmount) upnAmount,
SUM(downnAmount) downnAmount,
SUM(tasknAmount) tasknAmount,
SUM(activitynAmount) activitynAmount,
SUM(nResultMoney) nResultMoney,
SUM(nTax) nTax,
SUM(nScore) nScore
FROM
(
SELECT
IFNULL(recharge, 0) recharge,
IFNULL(withdrawal, 0) withdrawal,
IFNULL(rechargeCount, 0) rechargeCount,
IFNULL(rechargeNumber, 0) rechargeNumber,
IFNULL(withdrawalCount, 0) withdrawalCount,
IFNULL(withdrawalNumber, 0) withdrawalNumber,
IFNULL(water, 0) water,
IFNULL(directlyWater, 0) directlyWater,
IFNULL(teamWater, 0) teamWater,
IFNULL(upnAmount, 0) upnAmount,
IFNULL(downnAmount, 0) downnAmount,
IFNULL(tasknAmount, 0) tasknAmount,
IFNULL(activitynAmount, 0) activitynAmount,
IFNULL(nResultMoney, 0) nResultMoney,
IFNULL(nTax, 0) nTax,
(
SELECT
IFNULL(nScore, 0) nScore
FROM
table_clublogscore
WHERE
clubID = 10017
AND nPlayerID = temp.nPlayerID
AND CreateTime <= '2020-07-02 23:59:59'
ORDER BY
CreateTime DESC
LIMIT 0,
1
) nScore,
(
SELECT
count(1)
FROM
table_clubmember
WHERE
nClubId = 10017
AND nExtenID = temp.nPlayerID
AND tJoinTime <= '2020-07-02 23:59:59'
) directlyVipCount,
(
SELECT
count(1)
FROM
table_clubmember
WHERE
nClubId = 10017
AND nExtenID = temp.nPlayerID
AND tJoinTime >= '2020-07-02 00:00:00'
AND tJoinTime <= '2020-07-02 23:59:59'
) addDirectlyVipCount,
(
SELECT
count(1)
FROM
table_clubmemberAppLine
WHERE
nPlayerID = temp.nPlayerID
AND tJoinTime <= '2020-07-02 23:59:59'
) teamVipCount,
(
SELECT
count(1)
FROM
table_clubmemberAppLine
WHERE
nPlayerID = temp.nPlayerID
AND tJoinTime >= '2020-07-02 00:00:00'
AND tJoinTime <= '2020-07-02 23:59:59'
) addTeamCount,
(
SELECT
IFNULL(sum(nAmount), 0) nAmount
FROM
table_clublogscore
WHERE
nType = 26
AND clubid = 10017
AND nPlayerId = temp.nPlayerID
AND CreateTime >= '2020-07-02 00:00:00'
AND CreateTime <= '2020-07-02 23:59:59'
) weekMyRebate,
(
SELECT
IFNULL(SUM(nAmount), 0) nAmount
FROM
table_clubmemberAppLine line
LEFT JOIN table_clublogscore log ON line.nNextID = log.nPlayerID
WHERE
line.nPlayerID = temp.nPlayerID
AND log.nType = 26
AND log.clubid = 10017
AND CreateTime >= '2020-07-02 00:00:00'
AND CreateTime <= '2020-07-02 23:59:59'
) teamRebate
FROM
(
SELECT
nClubId,
nPlayerId
FROM
table_clubmember
WHERE
nClubId = 10017
AND nExtenID = 132806
) temp
LEFT JOIN (
SELECT
nClubId,
nPlayerId,
SUM(recharge) recharge,
SUM(withdrawal) withdrawal,
SUM(rechargeCount) rechargeCount,
SUM(rechargeNumber) rechargeNumber,
SUM(withdrawalCount) withdrawalCount,
SUM(withdrawalNumber) withdrawalNumber,
SUM(water) water,
SUM(directlyWater) directlyWater,
SUM(teamWater) teamWater,
SUM(upnAmount) upnAmount,
SUM(downnAmount) downnAmount,
SUM(tasknAmount) tasknAmount,
SUM(activitynAmount) activitynAmount,
SUM(nResultMoney) nResultMoney,
SUM(nTax) nTax
FROM
table_web_clubmemberproxy
WHERE
nClubId = 10017
AND tEndTime >= '2020-07-02 00:00:00'
AND tEndTime <= '2020-07-02 23:59:59'
GROUP BY
nClubId,
nPlayerId
) temp2 ON temp.nPlayerID = temp2.nPlayerID
AND temp.nClubID = temp2.nClubId
) tempsum;
