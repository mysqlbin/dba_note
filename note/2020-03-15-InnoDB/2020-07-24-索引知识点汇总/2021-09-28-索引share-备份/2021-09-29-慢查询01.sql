

1. 慢查询日志
	mysql> select ts_min, ts_max, ts_cnt, query_time_sum, query_time_min, query_time_max, sample from audit_db.mysql_slow_query_review_history where id=348136;
	+----------------------------+----------------------------+--------+----------------+----------------+----------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| ts_min                     | ts_max                     | ts_cnt | query_time_sum | query_time_min | query_time_max | sample                                                                                                                                                                                                                                                                                 |
	+----------------------------+----------------------------+--------+----------------+----------------+----------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| 2021-08-06 22:03:12.000000 | 2021-08-06 22:27:21.000000 |     13 |         53.633 |        4.05735 |        4.36434 | select COUNT(DISTINCT(users.nPlayerId)) activeNum from table_user users  left join table_league_club_game_score_detail detail on users.nPlayerId=detail.nPlayerId  where users.extendCode=123314 and detail.tEndTime>='2021-07-30 00:00:00' and detail.tEndTime<='2021-08-06 23:59:59' |
	+----------------------------+----------------------------+--------+----------------+----------------+----------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)
	
	-- 20分钟内执行了13次，每次平均耗时 4 秒钟
	
2. 查询执行计划

	desc SELECT
		COUNT(DISTINCT(users.nPlayerId)) activeNum
	FROM
		aiuaiuh9_db.table_user users
	LEFT JOIN aiuaiuh9_db.table_league_club_game_score_detail detail ON users.nPlayerId = detail.nPlayerId
	WHERE
		users.extendCode = 123314
	AND detail.tEndTime >= '2021-07-30 00:00:00'
	AND detail.tEndTime <= '2021-08-06 23:59:59' 
	+----+-------------+--------+------------+--------+------------------------+---------+---------+------------------------------+---------+----------+-------------+
	| id | select_type | table  | partitions | type   | possible_keys          | key     | key_len | ref                          | rows    | filtered | Extra       |
	+----+-------------+--------+------------+--------+------------------------+---------+---------+------------------------------+---------+----------+-------------+
	|  1 | SIMPLE      | detail | NULL       | ALL    | idx_tEndTime           | NULL    | NULL    | NULL                         | 4979724 |    18.59 | Using where |
	|  1 | SIMPLE      | users  | NULL       | eq_ref | PRIMARY,idx_extendCode | PRIMARY | 4       | aiuaiuh9_db.detail.nPlayerID |       1 |     5.00 | Using where |
	+----+-------------+--------+------------+--------+------------------------+---------+---------+------------------------------+---------+----------+-------------+
	2 rows in set, 1 warning (0.00 sec)

3. 查看表的DDL

	CREATE TABLE `table_user` (
	  `nPlayerId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '玩家用户Id',
	  `extendCode` int(11) DEFAULT '0' COMMENT '推广码',
	  ..........................................................................
	  PRIMARY KEY (`nPlayerId`),
	  KEY `idx_extendCode` (`extendCode`)
	) ENGINE=InnoDB AUTO_INCREMENT=125477 DEFAULT CHARSET=utf8mb4;

	
	CREATE TABLE `table_league_club_game_score_detail` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
	..........................................................................	
	  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  `tEndTime` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT '结束时间',
	  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
	  PRIMARY KEY (`ID`),
	  KEY `idx_tEndTime` (`tEndTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=5540561 DEFAULT CHARSET=utf8mb4 COMMENT='明细战绩表（按游戏类型分麻将，字牌，纸牌，按人数分类）';


4. 慢查询原因
	
	mysql> desc select count(*) from aiuaiuh9_db.table_user users where users.extendCode = 123314;
	+----+-------------+-------+------------+------+----------------+----------------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type | possible_keys  | key            | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+------+----------------+----------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | users | NULL       | ref  | idx_extendCode | idx_extendCode | 5       | const |    9 |   100.00 | Using index |
	+----+-------------+-------+------------+------+----------------+----------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)
	
	mysql> select count(*) from aiuaiuh9_db.table_user users where users.extendCode = 123314;
	+----------+
	| count(*) |
	+----------+
	|        9 |
	+----------+
	1 row in set (0.00 sec)


	table_user 是小表，经过条件过滤后的行数据只有9条，并且查询条件可以用到索引。
	
	但是这里使用了大表作为驱动表，原因：table_user.nplayerid 作为被驱动表的关联字段，可以用到索引，避免了BNL方式的关联。
	
	这种方式并不是最优的，总的来说是 table_league_club_game_score_detail.nplayerid 字段没有索引造成的慢查询。
	
	
	
	
5. 添加索引进行优化

	5.1 添加索引

		alter table table_league_club_game_score_detail add index idx_nPlayerId(`nPlayerId`);

	5.2 查询执行计划
		desc SELECT
			COUNT(DISTINCT(users.nPlayerId)) activeNum
		FROM
			aiuaiuh9_db.table_user users
		LEFT JOIN aiuaiuh9_db.table_league_club_game_score_detail detail ON users.nPlayerId = detail.nPlayerId
		WHERE
			users.extendCode = 123314
		AND detail.tEndTime >= '2021-07-30 00:00:00'
		AND detail.tEndTime <= '2021-08-06 23:59:59' 
		+----+-------------+--------+------------+------+----------------------------+----------------+---------+-----------------------------+------+----------+------------------------------------+
		| id | select_type | table  | partitions | type | possible_keys              | key            | key_len | ref                         | rows | filtered | Extra                              |
		+----+-------------+--------+------------+------+----------------------------+----------------+---------+-----------------------------+------+----------+------------------------------------+
		|  1 | SIMPLE      | users  | NULL       | ref  | PRIMARY,idx_extendCode     | idx_extendCode | 5       | const                       |    9 |   100.00 | Using index                        |
		|  1 | SIMPLE      | detail | NULL       | ref  | idx_tEndTime,idx_nPlayerId | idx_nPlayerId  | 4       | aiuaiuh9_db.users.nPlayerId | 1633 |    26.25 | Using index condition; Using where |
		+----+-------------+--------+------------+------+----------------------------+----------------+---------+-----------------------------+------+----------+------------------------------------+
		2 rows in set, 1 warning (0.00 sec)

	5.3 优化后的执行耗时
		约0.03秒。
		
	
		
		