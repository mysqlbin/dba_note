	

mysql> select now();
+---------------------+
| now()               |
+---------------------+
| 2021-11-23 11:15:18 |
+---------------------+
1 row in set (0.00 sec)




master

	select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
	select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name="table_web_loginlog";

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
	+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name                          | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
	| niuniuh5_db   | table_user_gamelock                 | 2021-11-23 11:10:21 |     416 |                    1 |                        1 |
	| niuniuh5_db   | table_clubgoods                     | 2021-11-23 03:11:11 |     275 |                    1 |                        2 |
	| niuniuh5_db   | table_league_club_member            | 2021-11-22 23:39:22 |   14460 |                   96 |                       81 |
	| niuniuh5_db   | table_agent_info                    | 2021-11-21 20:14:54 |     305 |                    3 |                        3 |
	| niuniuh5_db   | table_agent_commission              | 2021-11-21 00:41:46 |  243488 |                 1123 |                     1251 |
	| niuniuh5_db   | table_clubgoodsoperatlog            | 2021-11-20 15:28:19 |    6984 |                   97 |                       71 |
	| niuniuh5_db   | table_league_club_game_score_detail | 2021-11-19 07:57:14 | 5583636 |                42177 |                    50479 |
	| niuniuh5_db   | table_league_club_game_score_total  | 2021-11-19 07:55:01 |  571938 |                 8137 |                     5400 |
	| niuniuh5_db   | table_clubgoodsinfor                | 2021-11-19 07:09:11 |      21 |                    1 |                        1 |
	| niuniuh5_db   | table_task_config                   | 2021-11-19 07:09:01 |     133 |                    1 |                        1 |
	| niuniuh5_db   | table_club_task_complete            | 2021-11-19 07:08:26 |    6843 |                   97 |                       18 |
	| niuniuh5_db   | table_user                          | 2021-11-18 20:22:21 |   64545 |                  929 |                      759 |
	| niuniuh5_db   | table_agent_apply                   | 2021-11-17 23:03:23 |    1211 |                   11 |                       11 |
	| niuniuh5_db   | table_recharge_detail               | 2021-11-17 15:39:44 |  117306 |                  417 |                      386 |
	| niuniuh5_db   | table_league_stc_partner_sub        | 2021-11-16 01:35:10 |    6699 |                   30 |                       22 |
	+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
	15 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name="table_web_loginlog";
	+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name         | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
	| niuniuh5_db   | table_web_loginlog | 2021-11-06 17:25:11 | 2328319 |                 9196 |                    17612 |
	+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	
slave
	
	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
	+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name                           | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
	| niuniuh5_db   | table_user_gamelock                  | 2021-11-23 11:09:08 |     416 |                    1 |                        1 |
	| niuniuh5_db   | table_clubgoods                      | 2021-11-23 02:32:42 |     275 |                    1 |                        2 |
	| niuniuh5_db   | table_league_club_game_score_detail  | 2021-11-22 15:13:16 | 5778103 |                41793 |                    50541 |
	| niuniuh5_db   | table_webdata_roomcardfirstgamehelp  | 2021-11-22 01:40:00 |    3853 |                   12 |                       11 |
	| niuniuh5_db   | table_webknapsack_goodsstatiroomcard | 2021-11-20 01:40:08 |     125 |                    1 |                        1 |
	| niuniuh5_db   | table_clubgoodsinfor                 | 2021-11-19 07:09:11 |      21 |                    1 |                        1 |
	| niuniuh5_db   | table_task_config                    | 2021-11-19 07:09:01 |     133 |                    1 |                        1 |
	| niuniuh5_db   | table_club_task_complete             | 2021-11-19 07:08:27 |    6858 |                   97 |                       18 |
	| niuniuh5_db   | table_clubgoodsoperatlog             | 2021-11-05 00:57:00 |    3684 |                   27 |                       36 |
	| niuniuh5_db   | table_web_ngoodstemp                 | 2021-11-01 16:09:42 |     420 |                    3 |                        1 |
	| niuniuh5_db   | table_clubgamescoredetail20211230    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
	| niuniuh5_db   | table_clubgamescoredetail20211229    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
	| niuniuh5_db   | table_clubgamescoredetail20211228    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
	| niuniuh5_db   | table_third_score_detail20211227     | 2021-11-01 10:00:05 |       0 |                    1 |                        2 |
	| niuniuh5_db   | table_clublogscore20211229           | 2021-11-01 10:00:05 |       0 |                    1 |                        4 |
	+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
	15 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name="table_web_loginlog";
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name         | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	| niuniuh5_db   | table_web_loginlog | 2021-09-10 07:03:34 | 486630 |                 1956 |                     3883 |
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)


other
	-- table_user_gamelock表数据删除操作较频繁
	show create table table_user_gamelock\G;
	SELECT COUNT(*) FROM table_user_gamelock;

	-- table_web_loginlog表都是写入操作
	show create table table_web_loginlog\G;
	SELECT COUNT(*) FROM table_web_loginlog;


	slave 

		mysql> show create table table_user_gamelock\G;
		*************************** 1. row ***************************
			   Table: table_user_gamelock
		Create Table: CREATE TABLE `table_user_gamelock` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nTablePreID` int(11) DEFAULT '0' COMMENT '进入的桌子前缀',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID` (`nPlayerID`)
		) ENGINE=InnoDB AUTO_INCREMENT=1840854 DEFAULT CHARSET=utf8mb4 COMMENT=''
		1 row in set (0.00 sec)
		
		-- table_user_gamelock表数据删除操作较频繁
		
		mysql> SELECT COUNT(*) FROM table_user_gamelock;
		+----------+
		| COUNT(*) |
		+----------+
		|      416 |
		+----------+
		1 row in set (0.00 sec)

		------------------------------------------------------------------------------------
		
		mysql> show create table table_web_loginlog\G;
		*************************** 1. row ***************************
			   Table: table_web_loginlog
		Create Table: CREATE TABLE `table_web_loginlog` (
		  `Idx` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
		  `nPlayerId` int(11) NOT NULL,
		  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
		  `szNickName` varchar(64) DEFAULT NULL,
		  `nAction` int(11) NOT NULL DEFAULT '0',
		  `szTime` timestamp NULL DEFAULT NULL,
		  `loginIp` varchar(64) DEFAULT NULL,
		  `strRe1` varchar(128) DEFAULT NULL,
		  PRIMARY KEY (`Idx`),
		  KEY `web_loginlog_idx_szTime` (`szTime`),
		  KEY `idx_loginIp_szTime` (`loginIp`,`szTime`),
		  KEY `idx_nPlayerId_szTime` (`nPlayerId`,`szTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=2493732 DEFAULT CHARSET=utf8mb4
		1 row in set (0.00 sec)

		-- 表都是写入操作
		
		mysql> SELECT COUNT(*) FROM table_web_loginlog;
		+----------+
		| COUNT(*) |
		+----------+
		|  2493731 |
		+----------+
		1 row in set (0.40 sec)




