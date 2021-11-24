	

1. 某个环境的表和索引的统计信息01
2. 某个环境的表和索引的统计信息02



1. 某个环境的表和索引的统计信息01

	mysql> select now();
	+---------------------+
	| now()               |
	+---------------------+
	| 2021-11-23 11:15:18 |
	+---------------------+
	1 row in set (0.00 sec)


	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.21-log |
	+------------+
	1 row in set (0.00 sec)

	master

		mysql> show global variables like '%INNODB_STATS_PERSISTENT%';
		+--------------------------------------+-------+
		| Variable_name                        | Value |
		+--------------------------------------+-------+
		| innodb_stats_persistent              | ON    |
		| innodb_stats_persistent_sample_pages | 20    |
		+--------------------------------------+-------+
		2 rows in set (0.00 sec)
		
		select * from mysql.innodb_table_stats  where database_name='aiuaiuh9_db' order by last_update desc limit 15;
		select * from mysql.innodb_table_stats  where database_name='aiuaiuh9_db' and table_name="table_web_loginlog";

		mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh9_db' order by last_update desc limit 15;
		+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
		| database_name | table_name                          | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
		+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
		| aiuaiuh9_db   | table_user_gamelock                 | 2021-11-23 11:10:21 |     416 |                    1 |                        1 |
		| aiuaiuh9_db   | table_clubgoods                     | 2021-11-23 03:11:11 |     275 |                    1 |                        2 |
		| aiuaiuh9_db   | table_league_club_member            | 2021-11-22 23:39:22 |   14460 |                   96 |                       81 |
		| aiuaiuh9_db   | table_agent_info                    | 2021-11-21 20:14:54 |     305 |                    3 |                        3 |
		| aiuaiuh9_db   | table_agent_commission              | 2021-11-21 00:41:46 |  243488 |                 1123 |                     1251 |
		| aiuaiuh9_db   | table_clubgoodsoperatlog            | 2021-11-20 15:28:19 |    6984 |                   97 |                       71 |
		| aiuaiuh9_db   | table_league_club_game_score_detail | 2021-11-19 07:57:14 | 5583636 |                42177 |                    50479 |
		| aiuaiuh9_db   | table_league_club_game_score_total  | 2021-11-19 07:55:01 |  571938 |                 8137 |                     5400 |
		| aiuaiuh9_db   | table_clubgoodsinfor                | 2021-11-19 07:09:11 |      21 |                    1 |                        1 |
		| aiuaiuh9_db   | table_task_config                   | 2021-11-19 07:09:01 |     133 |                    1 |                        1 |
		| aiuaiuh9_db   | table_club_task_complete            | 2021-11-19 07:08:26 |    6843 |                   97 |                       18 |
		| aiuaiuh9_db   | table_user                          | 2021-11-18 20:22:21 |   64545 |                  929 |                      759 |
		| aiuaiuh9_db   | table_agent_apply                   | 2021-11-17 23:03:23 |    1211 |                   11 |                       11 |
		| aiuaiuh9_db   | table_recharge_detail               | 2021-11-17 15:39:44 |  117306 |                  417 |                      386 |
		| aiuaiuh9_db   | table_league_stc_partner_sub        | 2021-11-16 01:35:10 |    6699 |                   30 |                       22 |
		+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
		15 rows in set (0.00 sec)

		mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh9_db' and table_name="table_web_loginlog";
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		| database_name | table_name         | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		| aiuaiuh9_db   | table_web_loginlog | 2021-11-06 17:25:11 | 2328319 |                 9196 |                    17612 |
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		1 row in set (0.00 sec)

		
	slave

		mysql> show global variables like '%INNODB_STATS_PERSISTENT%';
		+--------------------------------------+-------+
		| Variable_name                        | Value |
		+--------------------------------------+-------+
		| innodb_stats_persistent              | ON    |
		| innodb_stats_persistent_sample_pages | 20    |
		+--------------------------------------+-------+
		2 rows in set (0.00 sec)
			
			
		mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh9_db' order by last_update desc limit 15;
		+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
		| database_name | table_name                           | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
		+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
		| aiuaiuh9_db   | table_user_gamelock                  | 2021-11-23 11:09:08 |     416 |                    1 |                        1 |
		| aiuaiuh9_db   | table_clubgoods                      | 2021-11-23 02:32:42 |     275 |                    1 |                        2 |
		| aiuaiuh9_db   | table_league_club_game_score_detail  | 2021-11-22 15:13:16 | 5778103 |                41793 |                    50541 |
		| aiuaiuh9_db   | table_webdata_roomcardfirstgamehelp  | 2021-11-22 01:40:00 |    3853 |                   12 |                       11 |
		| aiuaiuh9_db   | table_webknapsack_goodsstatiroomcard | 2021-11-20 01:40:08 |     125 |                    1 |                        1 |
		| aiuaiuh9_db   | table_clubgoodsinfor                 | 2021-11-19 07:09:11 |      21 |                    1 |                        1 |
		| aiuaiuh9_db   | table_task_config                    | 2021-11-19 07:09:01 |     133 |                    1 |                        1 |
		| aiuaiuh9_db   | table_club_task_complete             | 2021-11-19 07:08:27 |    6858 |                   97 |                       18 |
		| aiuaiuh9_db   | table_clubgoodsoperatlog             | 2021-11-05 00:57:00 |    3684 |                   27 |                       36 |
		| aiuaiuh9_db   | table_web_ngoodstemp                 | 2021-11-01 16:09:42 |     420 |                    3 |                        1 |
		| aiuaiuh9_db   | table_clubgamescoredetail20211230    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
		| aiuaiuh9_db   | table_clubgamescoredetail20211229    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
		| aiuaiuh9_db   | table_clubgamescoredetail20211228    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
		| aiuaiuh9_db   | table_third_score_detail20211227     | 2021-11-01 10:00:05 |       0 |                    1 |                        2 |
		| aiuaiuh9_db   | table_clublogscore20211229           | 2021-11-01 10:00:05 |       0 |                    1 |                        4 |
		+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
		15 rows in set (0.00 sec)
		
		-- 2021-09-10：调整table_web_loginlog表的索引顺序：优化 获取用户俱乐部成员列表 的慢查询
		-- alter table table_web_loginlog add index `idx_nPlayerId_szTime` (`nPlayerId`,`szTime`), drop index web_loginlog_idx_nPlayerId;


		mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh9_db' and table_name="table_web_loginlog";
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name         | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		| aiuaiuh9_db   | table_web_loginlog | 2021-09-10 07:03:34 | 486630 |                 1956 |                     3883 |
		+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.00 sec)
		
		select count(*) from niuniuh5_db.table_web_loginlog;
		select count(*) from niuniuh5_db.table_web_loginlog where szTime>='2021-09-10 07:03:34';


		mysql> select count(*) from niuniuh5_db.table_web_loginlog;
		+-------------+
		|   count(*)  |
		+-------------+
		|   2505286   |
		+-------------+
		1 row in set (0.01 sec)

		mysql> select count(*) from niuniuh5_db.table_web_loginlog where szTime>='2021-09-10 07:03:34';
		+-------------+
		|   count(*)  |
		+-------------+
		|   801098    |
		+-------------+
		1 row in set (0.01 sec)

		mysql> select 801098/2505286;
		+----------------+
		| 801098/2505286 |
		+----------------+
		|         0.3198 |
		+----------------+
		1 row in set (0.00 sec)

		30%;
		
		select table_rows from information_schema.tables where TABLE_SCHEMA='niuniuh5_db'  and TABLE_NAME="table_web_loginlog"; 
		489621
		
		
		show index from niuniuh5_db.table_web_loginlog 的主键索引的基数值为 486989。
		
		
		
		
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



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------


2. 某个环境的表和索引的统计信息02
 
	table_web_loginlog 表只保留最近3个月的数据，每天 08:10:00 有定时删除3个月前的数据。
	
	mysql> select now();
	+---------------------+
	| now()               |
	+---------------------+
	| 2021-11-24 16:09:39 |
	+---------------------+
	1 row in set (0.00 sec)

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.21-log |
	+------------+
	1 row in set (0.00 sec)

	master 

		mysql> show global variables like '%INNODB_STATS_PERSISTENT%';
		+--------------------------------------+-------+
		| Variable_name                        | Value |
		+--------------------------------------+-------+
		| innodb_stats_persistent              | ON    |
		| innodb_stats_persistent_sample_pages | 20    |
		+--------------------------------------+-------+
		2 rows in set (0.00 sec)


		mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh9_db' and table_name="table_web_loginlog";
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		| database_name | table_name         | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		| aiuaiuh9_db   | table_web_loginlog | 2021-11-23 08:10:05 | 1159656 |                 4993 |                    34246 |
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		1 row in set (0.05 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh9_db' and table_name="table_web_loginlog";
		+---------------+--------------------+-------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name         | index_name              | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+--------------------+-------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| aiuaiuh9_db   | table_web_loginlog | PRIMARY                 | 2021-11-23 08:10:05 | n_diff_pfx01 |    1159656 |          20 | Idx                               |
		| aiuaiuh9_db   | table_web_loginlog | PRIMARY                 | 2021-11-23 08:10:05 | n_leaf_pages |       4891 |        NULL | Number of leaf pages in the index |
		| aiuaiuh9_db   | table_web_loginlog | PRIMARY                 | 2021-11-23 08:10:05 | size         |       4993 |        NULL | Number of pages in the index      |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2021-11-23 08:10:05 | n_diff_pfx01 |      45123 |          20 | loginIp                           |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2021-11-23 08:10:05 | n_diff_pfx02 |    1318693 |          20 | loginIp,szTime                    |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2021-11-23 08:10:05 | n_diff_pfx03 |    1172528 |          20 | loginIp,szTime,Idx                |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2021-11-23 08:10:05 | n_leaf_pages |       3565 |        NULL | Number of leaf pages in the index |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2021-11-23 08:10:05 | size         |      23489 |        NULL | Number of pages in the index      |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2021-11-23 08:10:05 | n_diff_pfx01 |       9156 |          20 | nPlayerId                         |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2021-11-23 08:10:05 | n_diff_pfx02 |    1147200 |          20 | nPlayerId,szTime                  |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2021-11-23 08:10:05 | n_diff_pfx03 |    1112119 |          20 | nPlayerId,szTime,Idx              |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2021-11-23 08:10:05 | n_leaf_pages |       2278 |        NULL | Number of leaf pages in the index |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2021-11-23 08:10:05 | size         |       9409 |        NULL | Number of pages in the index      |
		| aiuaiuh9_db   | table_web_loginlog | web_loginlog_idx_szTime | 2021-11-23 08:10:05 | n_diff_pfx01 |    1057817 |          20 | szTime                            |
		| aiuaiuh9_db   | table_web_loginlog | web_loginlog_idx_szTime | 2021-11-23 08:10:05 | n_diff_pfx02 |    1165533 |          20 | szTime,Idx                        |
		| aiuaiuh9_db   | table_web_loginlog | web_loginlog_idx_szTime | 2021-11-23 08:10:05 | n_leaf_pages |       1329 |        NULL | Number of leaf pages in the index |
		| aiuaiuh9_db   | table_web_loginlog | web_loginlog_idx_szTime | 2021-11-23 08:10:05 | size         |       1348 |        NULL | Number of pages in the index      |
		+---------------+--------------------+-------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		17 rows in set (0.00 sec)


		mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
		+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
		| database_name | table_name                        | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
		+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
		| niuniuh5_db   | table_user_gamelock               | 2021-11-24 16:39:15 |      43 |                    1 |                        1 |
		| niuniuh5_db   | table_clubgamescoredetail20211124 | 2021-11-24 16:37:49 |   56172 |                 1315 |                     1158 |
		| niuniuh5_db   | table_clublogscore20211124        | 2021-11-24 16:31:58 |   73929 |                  609 |                      772 |
		| niuniuh5_db   | table_third_score_detail20211124  | 2021-11-24 16:22:10 |   54030 |                  931 |                      450 |
		| niuniuh5_db   | table_webdata_excelexport         | 2021-11-24 13:34:49 |      12 |                    1 |                        2 |
		| niuniuh5_db   | table_third_score_detail20210824  | 2021-11-24 08:30:40 |       0 |                    1 |                        2 |
		| niuniuh5_db   | table_clublogscore20210824        | 2021-11-24 08:25:53 |       0 |                    1 |                        4 |
		| niuniuh5_db   | table_clubgamescoredetail20210824 | 2021-11-24 08:20:51 |       0 |                    1 |                        6 |
		| niuniuh5_db   | table_clublogplatformscore        | 2021-11-24 08:15:07 | 2710072 |                17217 |                    30741 |
		| niuniuh5_db   | table_clublogscore20211123        | 2021-11-23 22:55:18 |  118317 |                  931 |                     1092 |
		| niuniuh5_db   | table_clubgamescoredetail20211123 | 2021-11-23 22:28:17 |   87468 |                 2277 |                     1736 |
		| niuniuh5_db   | table_third_score_detail20211123  | 2021-11-23 22:26:36 |   86608 |                 1636 |                      708 |
		| niuniuh5_db   | table_third_token                 | 2021-11-23 22:20:10 |   99007 |                  453 |                      304 |
		| niuniuh5_db   | table_third_score_detail20210823  | 2021-11-23 08:30:37 |       0 |                    1 |                        2 |
		| niuniuh5_db   | table_clublogscore20210823        | 2021-11-23 08:25:50 |       0 |                    1 |                        4 |
		+---------------+-----------------------------------+---------------------+---------+----------------------+--------------------------+
		15 rows in set (0.00 sec)



	slave

		mysql> show global variables like '%INNODB_STATS_PERSISTENT%';
		+--------------------------------------+-------+
		| Variable_name                        | Value |
		+--------------------------------------+-------+
		| innodb_stats_persistent              | ON    |
		| innodb_stats_persistent_sample_pages | 20    |
		+--------------------------------------+-------+
		2 rows in set (0.00 sec)
		
		mysql> select * from mysql.innodb_table_stats  where database_name='aiuaiuh9_db' and table_name="table_web_loginlog";
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		| database_name | table_name         | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		| aiuaiuh9_db   | table_web_loginlog | 2020-07-16 10:59:07 | 2141685 |                10413 |                    11330 |
		+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
		1 row in set (0.00 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='aiuaiuh9_db' and table_name="table_web_loginlog";
		+---------------+--------------------+-------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name         | index_name              | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+--------------------+-------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| aiuaiuh9_db   | table_web_loginlog | PRIMARY                 | 2020-07-16 10:59:07 | n_diff_pfx01 |    2141685 |          20 | Idx                               |
		| aiuaiuh9_db   | table_web_loginlog | PRIMARY                 | 2020-07-16 10:59:07 | n_leaf_pages |       9100 |        NULL | Number of leaf pages in the index |
		| aiuaiuh9_db   | table_web_loginlog | PRIMARY                 | 2020-07-16 10:59:07 | size         |      10413 |        NULL | Number of pages in the index      |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2020-07-16 10:59:07 | n_diff_pfx01 |      91891 |          20 | loginIp                           |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2020-07-16 10:59:07 | n_diff_pfx02 |    2161092 |          20 | loginIp,szTime                    |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2020-07-16 10:59:07 | n_diff_pfx03 |    2129747 |          20 | loginIp,szTime,Idx                |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2020-07-16 10:59:07 | n_leaf_pages |       4384 |        NULL | Number of leaf pages in the index |
		| aiuaiuh9_db   | table_web_loginlog | idx_loginIp_szTime      | 2020-07-16 10:59:07 | size         |       5043 |        NULL | Number of pages in the index      |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2020-07-16 10:59:07 | n_diff_pfx01 |      18640 |          20 | nPlayerId                         |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2020-07-16 10:59:07 | n_diff_pfx02 |    2155322 |          20 | nPlayerId,szTime                  |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2020-07-16 10:59:07 | n_diff_pfx03 |    2160116 |          20 | nPlayerId,szTime,Idx              |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2020-07-16 10:59:07 | n_leaf_pages |       2996 |        NULL | Number of leaf pages in the index |
		| aiuaiuh9_db   | table_web_loginlog | idx_nPlayerId_szTime    | 2020-07-16 10:59:07 | size         |       3434 |        NULL | Number of pages in the index      |
		| aiuaiuh9_db   | table_web_loginlog | web_loginlog_idx_szTime | 2020-07-16 10:59:07 | n_diff_pfx01 |    1839735 |          20 | szTime                            |
		| aiuaiuh9_db   | table_web_loginlog | web_loginlog_idx_szTime | 2020-07-16 10:59:07 | n_diff_pfx02 |    2150404 |          20 | szTime,Idx                        |
		| aiuaiuh9_db   | table_web_loginlog | web_loginlog_idx_szTime | 2020-07-16 10:59:07 | n_leaf_pages |       2452 |        NULL | Number of leaf pages in the index |
		| aiuaiuh9_db   | table_web_loginlog | web_loginlog_idx_szTime | 2020-07-16 10:59:07 | size         |       2853 |        NULL | Number of pages in the index      |
		+---------------+--------------------+-------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
		17 rows in set (0.00 sec)

				
		mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
		+---------------+-----------------------------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name                        | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+-----------------------------------+---------------------+--------+----------------------+--------------------------+
		| niuniuh5_db   | table_user_gamelock               | 2021-11-24 16:39:15 |     43 |                    1 |                        1 |
		| niuniuh5_db   | table_clubgamescoredetail20211124 | 2021-11-24 16:37:01 |  56250 |                 1315 |                     1158 |
		| niuniuh5_db   | table_clublogscore20211124        | 2021-11-24 16:24:01 |  73116 |                  545 |                      708 |
		| niuniuh5_db   | table_third_score_detail20211124  | 2021-11-24 16:23:40 |  53644 |                  931 |                      450 |
		| niuniuh5_db   | table_webdata_excelexport         | 2021-11-24 13:34:49 |     11 |                    1 |                        2 |
		| niuniuh5_db   | table_third_score_detail20210824  | 2021-11-24 08:30:52 |      0 |                    1 |                        2 |
		| niuniuh5_db   | table_clublogscore20210824        | 2021-11-24 08:26:06 |      0 |                    1 |                        4 |
		| niuniuh5_db   | table_clubgamescoredetail20210824 | 2021-11-24 08:20:45 |      0 |                    1 |                        6 |
		| niuniuh5_db   | table_third_score_detail20211123  | 2021-11-23 23:59:43 |  98154 |                 1764 |                      772 |
		| niuniuh5_db   | table_clublogscore20211123        | 2021-11-23 22:56:31 | 118714 |                  931 |                     1092 |
		| niuniuh5_db   | table_clubgamescoredetail20211123 | 2021-11-23 22:30:13 |  80136 |                 2277 |                     1736 |
		| niuniuh5_db   | table_third_score_detail20210823  | 2021-11-23 08:30:38 |      0 |                    1 |                        2 |
		| niuniuh5_db   | table_clublogscore20210823        | 2021-11-23 08:25:51 |      0 |                    1 |                        4 |
		| niuniuh5_db   | table_clubgamescoredetail20210823 | 2021-11-23 08:20:39 |      0 |                    1 |                        6 |
		| niuniuh5_db   | table_third_score_detail20211122  | 2021-11-22 23:57:33 | 105227 |                 1892 |                      772 |
		+---------------+-----------------------------------+---------------------+--------+----------------------+--------------------------+
		15 rows in set (0.00 sec)


