
1. SQL语句
2. 执行计划
3. show profile 
4. order by null的show profile
5. 去除 DISTINCT 的show profile


1. SQL语句

	SELECT
		detail.nClubId,
		count(DISTINCT(szToken)) nRoundTabCount,
		count(szToken) nRoundNumber,
		count(DISTINCT(nPlayerID)) nGameNumber,
		SUM(detail.nBetScore) nBetScore,
		SUM(detail.nValidBet) nValidBet,
		SUM(detail.nResultMoney) nResultMoney,
		SUM(detail.nTax) nTax
	FROM
		table_clubgamedetail detail
	WHERE
		detail.tEndTime BETWEEN '2020-07-06 00:00:00'
	AND '2020-07-06 23:59:59'
	GROUP BY
		detail.nClubId;
	

2. 执行计划
	+----+-------------+--------+------------+-------+------------------------------------------------------------------+--------------+---------+------+--------+----------+---------------------------------------+
	| id | select_type | table  | partitions | type  | possible_keys                                                    | key          | key_len | ref  | rows   | filtered | Extra                                 |
	+----+-------------+--------+------------+-------+------------------------------------------------------------------+--------------+---------+------+--------+----------+---------------------------------------+
	|  1 | SIMPLE      | detail | NULL       | range | idx_nPlayerID_nClubID_tEndTime,idx_tEndTime,idx_nClubID_tEndTime | idx_tEndTime | 7       | NULL | 341042 |   100.00 | Using index condition; Using filesort |
	+----+-------------+--------+------------+-------+------------------------------------------------------------------+--------------+---------+------+--------+----------+---------------------------------------+
	1 row in set, 1 warning (0.00 sec)
	
	
	
3. show profile 
	set profiling = 1;

	SELECT
	detail.nClubId,
	count(DISTINCT(szToken)) nRoundTabCount,
	count(szToken) nRoundNumber,
	count(DISTINCT(nPlayerID)) nGameNumber,
	SUM(detail.nBetScore) nBetScore,
	SUM(detail.nValidBet) nValidBet,
	SUM(detail.nResultMoney) nResultMoney,
	SUM(detail.nTax) nTax
	FROM
	table_clubgamedetail detail
	WHERE
	detail.tEndTime BETWEEN '2020-07-06 00:00:00'
	AND '2020-07-06 23:59:59'
	GROUP BY
	detail.nClubId;	

	show profiles;
	show profile for query 1;
	-- 第一次执行
	mysql> show profile cpu,block io for query 1;
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| starting                       | 0.000088 | 0.000068 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000027 | 0.000019 |   0.000000 |            0 |             0 |
	| starting                       | 0.000010 | 0.000010 |   0.000000 |            0 |             0 |
	| checking query cache for query | 0.000117 | 0.000116 |   0.000000 |            0 |             0 |
	| checking permissions           | 0.000015 | 0.000015 |   0.000000 |            0 |             0 |
	| Opening tables                 | 0.000027 | 0.000027 |   0.000000 |            0 |             0 |
	| init                           | 0.000054 | 0.000000 |   0.000056 |            0 |             0 |
	| System lock                    | 0.000022 | 0.000000 |   0.000020 |            0 |             0 |
	| Waiting for query cache lock   | 0.000009 | 0.000000 |   0.000007 |            0 |             0 |
	| System lock                    | 0.000035 | 0.000000 |   0.000036 |            0 |             0 |
	| optimizing                     | 0.000016 | 0.000000 |   0.000016 |            0 |             0 |
	| statistics                     | 0.000142 | 0.000133 |   0.000011 |            0 |             0 |
	| preparing                      | 0.000071 | 0.000069 |   0.000000 |            0 |             0 |
	| Sorting result                 | 0.000011 | 0.000015 |   0.000000 |            0 |             0 |
	| executing                      | 0.000026 | 0.000000 |   0.000022 |            0 |             0 |
	| Sending data                   | 0.000019 | 0.000000 |   0.000017 |            0 |             0 |
	| Creating sort index            | 1.377295 | 0.736187 |   0.669602 |       123296 |         35640 |    -- 慢在这里
	| end                            | 0.000058 | 0.000030 |   0.000000 |            0 |             0 |
	| query end                      | 0.004264 | 0.000000 |   0.004285 |            0 |             0 |
	| removing tmp table             | 0.000055 | 0.000000 |   0.000034 |            0 |             0 |
	| query end                      | 0.000016 | 0.000000 |   0.000014 |            0 |             0 |
	| removing tmp table             | 0.000011 | 0.000000 |   0.000011 |            0 |             0 |
	| query end                      | 0.000010 | 0.000000 |   0.000010 |            0 |             0 |
	| closing tables                 | 0.000023 | 0.000000 |   0.000024 |            0 |             0 |
	| freeing items                  | 0.000055 | 0.000000 |   0.000057 |            0 |             0 |
	| logging slow query             | 0.000066 | 0.000000 |   0.000064 |            0 |             8 |
	| cleaning up                    | 0.000029 | 0.000000 |   0.000028 |            0 |             0 |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	27 rows in set, 1 warning (0.00 sec)
	
	Block_ops_in： I/O 输入： 123296
	Block_ops_out： I/O 输出： 35640
	
	实际的SQL语句耗时： 1.4S 
	
	--------------------------------------------------------------------------------------------------------------
	-- 第二次执行
	
	mysql> show profile cpu,block io for query 9;
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| starting                       | 0.000065 | 0.000041 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
	| starting                       | 0.000007 | 0.000007 |   0.000000 |            0 |             0 |
	| checking query cache for query | 0.000132 | 0.000135 |   0.000000 |            0 |             0 |
	| checking permissions           | 0.000019 | 0.000015 |   0.000000 |            0 |             0 |
	| Opening tables                 | 0.000028 | 0.000028 |   0.000000 |            0 |             0 |
	| init                           | 0.000040 | 0.000046 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000023 | 0.000016 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000008 | 0.000008 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000041 | 0.000040 |   0.000000 |            0 |             0 |
	| optimizing                     | 0.000015 | 0.000016 |   0.000000 |            0 |             0 |
	| statistics                     | 0.000125 | 0.000126 |   0.000000 |            0 |             0 |
	| preparing                      | 0.000064 | 0.000063 |   0.000000 |            0 |             0 |
	| Sorting result                 | 0.000011 | 0.000010 |   0.000000 |            0 |             0 |
	| executing                      | 0.000008 | 0.000007 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000015 | 0.000016 |   0.000000 |            0 |             0 |
	| Creating sort index            | 0.835827 | 0.845913 |   0.000000 |         1248 |         35344 |
	| end                            | 0.000056 | 0.000027 |   0.000000 |            0 |             0 |
	| query end                      | 0.004216 | 0.004240 |   0.000000 |            0 |             0 |
	| removing tmp table             | 0.000057 | 0.000033 |   0.000000 |            0 |             0 |
	| query end                      | 0.000017 | 0.000016 |   0.000000 |            0 |             0 |
	| removing tmp table             | 0.000010 | 0.000010 |   0.000000 |            0 |             0 |
	| query end                      | 0.000011 | 0.000010 |   0.000000 |            0 |             0 |
	| closing tables                 | 0.000022 | 0.000023 |   0.000000 |            0 |             0 |
	| freeing items                  | 0.000051 | 0.000052 |   0.000000 |            0 |             0 |
	| cleaning up                    | 0.000038 | 0.000038 |   0.000000 |            0 |             0 |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	26 rows in set, 1 warning (0.01 sec)
	
	Block_ops_in： I/O 输入： 1248
	Block_ops_out： I/O 输出： 35344
	
	实际的SQL语句耗时： 0.8S 
	
	同时也说明了访问内存比磁盘快得多。
	
	
4. order by null的show profile
	set profiling = 1;
	SELECT
	detail.nClubId,
	count(DISTINCT(szToken)) nRoundTabCount,
	count(szToken) nRoundNumber,
	count(DISTINCT(nPlayerID)) nGameNumber,
	SUM(detail.nBetScore) nBetScore,
	SUM(detail.nValidBet) nValidBet,
	SUM(detail.nResultMoney) nResultMoney,
	SUM(detail.nTax) nTax
	FROM
	table_clubgamedetail detail
	WHERE
	detail.tEndTime BETWEEN '2020-07-06 00:00:00'
	AND '2020-07-06 23:59:59'
	GROUP BY
	detail.nClubId 
	order by null;
	show profiles;
	
	mysql> show profile cpu,block io for query 7;
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| starting                       | 0.000054 | 0.000036 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000013 | 0.000011 |   0.000000 |            0 |             0 |
	| starting                       | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
	| checking query cache for query | 0.000150 | 0.000151 |   0.000000 |            0 |             0 |
	| checking permissions           | 0.000015 | 0.000014 |   0.000000 |            0 |             0 |
	| Opening tables                 | 0.000028 | 0.000027 |   0.000000 |            0 |             0 |
	| init                           | 0.000043 | 0.000046 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000022 | 0.000022 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000012 | 0.000011 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000045 | 0.000044 |   0.000000 |            0 |             0 |
	| optimizing                     | 0.000017 | 0.000017 |   0.000000 |            0 |             0 |
	| statistics                     | 0.000147 | 0.000149 |   0.000000 |            0 |             0 |
	| preparing                      | 0.000073 | 0.000070 |   0.000000 |            0 |             0 |
	| Sorting result                 | 0.000010 | 0.000009 |   0.000000 |            0 |             0 |
	| executing                      | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.000015 | 0.000015 |   0.000000 |            0 |             0 |
	| Creating sort index            | 0.850203 | 0.865967 |   0.000000 |           64 |         35536 |
	| end                            | 0.000055 | 0.000030 |   0.000000 |            0 |             0 |
	| query end                      | 0.018548 | 0.005061 |   0.000000 |            0 |             0 |
	| removing tmp table             | 0.000062 | 0.000037 |   0.000000 |            0 |             0 |
	| query end                      | 0.000017 | 0.000016 |   0.000000 |            0 |             0 |
	| removing tmp table             | 0.000011 | 0.000010 |   0.000000 |            0 |             0 |
	| query end                      | 0.000011 | 0.000011 |   0.000000 |            0 |             0 |
	| closing tables                 | 0.000025 | 0.000025 |   0.000000 |            0 |             0 |
	| freeing items                  | 0.000051 | 0.000052 |   0.000000 |            0 |             0 |
	| cleaning up                    | 0.000031 | 0.000029 |   0.000000 |            0 |             0 |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	26 rows in set, 1 warning (0.00 sec)



5. 去除 DISTINCT 的show profile
	desc SELECT
	detail.nClubId,
	count(szToken) nRoundNumber,
	SUM(detail.nBetScore) nBetScore,
	SUM(detail.nValidBet) nValidBet,
	SUM(detail.nResultMoney) nResultMoney,
	SUM(detail.nTax) nTax
	FROM
	table_clubgamedetail detail
	WHERE
	detail.tEndTime BETWEEN '2020-07-06 00:00:00'
	AND '2020-07-06 23:59:59'
	GROUP BY
	detail.nClubId;

	+----+-------------+--------+------------+-------+------------------------------------------------------------------+--------------+---------+------+--------+----------+--------------------------------------------------------+
	| id | select_type | table  | partitions | type  | possible_keys                                                    | key          | key_len | ref  | rows   | filtered | Extra                                                  |
	+----+-------------+--------+------------+-------+------------------------------------------------------------------+--------------+---------+------+--------+----------+--------------------------------------------------------+
	|  1 | SIMPLE      | detail | NULL       | range | idx_nPlayerID_nClubID_tEndTime,idx_tEndTime,idx_nClubID_tEndTime | idx_tEndTime | 7       | NULL | 341042 |   100.00 | Using index condition; Using temporary; Using filesort |
	+----+-------------+--------+------------+-------+------------------------------------------------------------------+--------------+---------+------+--------+----------+--------------------------------------------------------+
	1 row in set, 1 warning (0.00 sec)
	
	set profiling = 1;
	SELECT
	detail.nClubId,
	count(szToken) nRoundNumber,
	SUM(detail.nBetScore) nBetScore,
	SUM(detail.nValidBet) nValidBet,
	SUM(detail.nResultMoney) nResultMoney,
	SUM(detail.nTax) nTax
	FROM
	table_clubgamedetail detail
	WHERE
	detail.tEndTime BETWEEN '2020-07-06 00:00:00'
	AND '2020-07-06 23:59:59'
	GROUP BY
	detail.nClubId;
	show profiles;
	 
	show profile cpu,block io for query 14;
	mysql> show profile cpu,block io for query 14;
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	| starting                       | 0.000067 | 0.000042 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000010 | 0.000014 |   0.000000 |            0 |             0 |
	| starting                       | 0.000014 | 0.000010 |   0.000000 |            0 |             0 |
	| checking query cache for query | 0.000170 | 0.000174 |   0.000000 |            0 |             0 |
	| checking permissions           | 0.000022 | 0.000017 |   0.000000 |            0 |             0 |
	| Opening tables                 | 0.000029 | 0.000032 |   0.000000 |            0 |             0 |
	| init                           | 0.000047 | 0.000044 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000016 | 0.000015 |   0.000000 |            0 |             0 |
	| Waiting for query cache lock   | 0.000008 | 0.000009 |   0.000000 |            0 |             0 |
	| System lock                    | 0.000041 | 0.000041 |   0.000000 |            0 |             0 |
	| optimizing                     | 0.000016 | 0.000016 |   0.000000 |            0 |             0 |
	| statistics                     | 0.000167 | 0.000170 |   0.000000 |            0 |             0 |
	| preparing                      | 0.000025 | 0.000022 |   0.000000 |            0 |             0 |
	| Creating tmp table             | 0.000037 | 0.000037 |   0.000000 |            0 |             0 |
	| Sorting result                 | 0.000010 | 0.000009 |   0.000000 |            0 |             0 |
	| executing                      | 0.000008 | 0.000008 |   0.000000 |            0 |             0 |
	| Sending data                   | 0.553781 | 0.563208 |   0.000000 |            0 |            72 |
	| Creating sort index            | 0.000168 | 0.000137 |   0.000000 |            0 |             0 |
	| end                            | 0.000016 | 0.000012 |   0.000000 |            0 |             0 |
	| query end                      | 0.000019 | 0.000019 |   0.000000 |            0 |             0 |
	| removing tmp table             | 0.000014 | 0.000014 |   0.000000 |            0 |             0 |
	| query end                      | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
	| closing tables                 | 0.000018 | 0.000018 |   0.000000 |            0 |             0 |
	| freeing items                  | 0.000064 | 0.000065 |   0.000000 |            0 |             0 |
	| cleaning up                    | 0.000031 | 0.000029 |   0.000000 |            0 |             0 |
	+--------------------------------+----------+----------+------------+--------------+---------------+
	25 rows in set, 1 warning (0.00 sec)

