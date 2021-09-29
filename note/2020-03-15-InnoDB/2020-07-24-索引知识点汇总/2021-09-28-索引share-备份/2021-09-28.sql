

大纲

1. 初始化表结构和数据
2. 理解主键索引和二级索引的有序性
	2.0 基础知识
	2.1 主键索引ID的逻辑存放顺序	
	2.2 二级单列索引idx_nPlayerId的逻辑存放顺序
	2.3 二级联合索引idx_nClubID_tCreateTime的逻辑存放顺序
		
3. B+树的非叶子节点和叶子节点
	0. B+树的非叶子节点和叶子节点
	1. 主键索引的叶子节点存储的是一整行数据
	2. 二级索引的叶子节点存储的是二级索引列的值+对应主键索引列的值
	
4. 通过房卡的2个慢查询案例说明索引的重要性
5. 目前已知的服务端有1个平均执行耗时1秒多的慢查询分析
6. 插入10/50W行记录在不同索引个数的耗时对比
7. 个人建索引的一些技巧
	
	
昨天说的关于分享数据库相关知识
打算先分享1个跟索引相关的，主要从这3个方面来讲讲： 索引的数据结构分析、结合房卡已经优化的2个慢查询案例、目前已知的1个慢查询分析

	

1. 初始化表结构和数据

	其中表中有1个主键索引，1个二级单列索引，1个二级联合索引
		
	drop table if exists table_league_club_game_score_total;
	CREATE TABLE `table_league_club_game_score_total` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
	  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
	  `szToken` varchar(64) NOT NULL DEFAULT '' COMMENT 'clubid-roomid-time(与明细表对应)',
	  `tCreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '写入时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_nPlayerId` (`nPlayerId`),
	  KEY `idx_nClubID_tCreateTime` (`nClubID`,`tCreateTime`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	

	insert into table_league_club_game_score_total(`nPlayerId`, `nClubID`, `tCreateTime`) values(1, 4, '2021-09-28 01:00:00');
	insert into table_league_club_game_score_total(`nPlayerId`, `nClubID`, `tCreateTime`) values(3, 2, '2021-09-28 03:00:00');
	insert into table_league_club_game_score_total(`nPlayerId`, `nClubID`, `tCreateTime`) values(1, 2, '2021-09-28 01:00:00');
	insert into table_league_club_game_score_total(`nPlayerId`, `nClubID`, `tCreateTime`) values(5, 2, '2021-09-28 03:00:00');
	insert into table_league_club_game_score_total(`nPlayerId`, `nClubID`, `tCreateTime`) values(2, 5, '2021-09-28 05:00:00');

	mysql> select * from table_league_club_game_score_total;
	+----+-----------+---------+---------+---------------------+
	| ID | nPlayerID | nClubID | szToken | tCreateTime         |
	+----+-----------+---------+---------+---------------------+
	|  1 |         1 |       4 |         | 2021-09-28 01:00:00 |
	|  2 |         3 |       2 |         | 2021-09-28 03:00:00 |
	|  3 |         1 |       2 |         | 2021-09-28 01:00:00 |
	|  4 |         5 |       2 |         | 2021-09-28 03:00:00 |
	|  5 |         2 |       5 |         | 2021-09-28 05:00:00 |
	+----+-----------+---------+---------+---------------------+
	5 rows in set (0.00 sec)


	
2. B+树的存储结构

	1. 每一个索引在 InnoDB 存储引擎里面对应一棵 B+ 树。
	2. InnoDB 存储引擎采用的是 B+ 树作为底层的数据结构。
	3. B+树的3个节点: 根节点、非叶子节点、叶子节点
	
		2层的B+树：只有 根节点、叶子节点
		3层的B+树：有 根节点、非叶子节点、叶子节点
		
		根节点和非叶子节点存储的是索引的键值，其中 根节点只有1个数据页，这个数据页是在内存缓冲池中
		
		叶子节点：	
			
			主键索引的叶子节点存储的是一整行数据
			
				主键索引ID包含的字段有：(ID, nPlayerID, nClubID, szToken, tCreateTime)
			
			
			二级索引的叶子节点存储的是二级索引列的值+对应主键索引列的值
			
				二级索引idx_nPlayerId包含的字段有2列：(nPlayerId, ID);
				二级索引idx_nClubID_tCreateTime包含的字段有3列：(nClubID, tCreateTime, ID);
			
				mysql> select table_name, index_name,  stat_description  from mysql.innodb_index_stats where table_name='table_league_club_game_score_total';
				+------------------------------------+-------------------------+-----------------------------------+
				| table_name                         | index_name              | stat_description                  |
				+------------------------------------+-------------------------+-----------------------------------+
				| table_league_club_game_score_total | idx_nPlayerId           | nPlayerID,ID                      |
				| table_league_club_game_score_total | idx_nClubID_tCreateTime | nClubID,tCreateTime,ID            |
				+------------------------------------+-------------------------+-----------------------------------+
				12 rows in set (0.00 sec)
						
		
3. 主键索引和二级索引的有序性
	
	3.1 主键索引ID的逻辑存放顺序
		
		根据主键ID的顺序进行存放
		
		shell> innodb_space -s ibdata1 -T test_db/table_league_club_game_score_total -I PRIMARY index-recurse
		ROOT NODE #3: 5 records, 180 bytes
		  RECORD: (ID=1) → (nPlayerID=1, nClubID=4, szToken="", tCreateTime="2021-09-28 01:00:00")
		  RECORD: (ID=2) → (nPlayerID=3, nClubID=2, szToken="", tCreateTime="2021-09-28 03:00:00")
		  RECORD: (ID=3) → (nPlayerID=1, nClubID=2, szToken="", tCreateTime="2021-09-28 01:00:00")
		  RECORD: (ID=4) → (nPlayerID=5, nClubID=2, szToken="", tCreateTime="2021-09-28 03:00:00")
		  RECORD: (ID=5) → (nPlayerID=2, nClubID=5, szToken="", tCreateTime="2021-09-28 05:00:00")
							
		mysql> select * from table_league_club_game_score_total;
		+----+-----------+---------+---------+---------------------+
		| ID | nPlayerID | nClubID | szToken | tCreateTime         |
		+----+-----------+---------+---------+---------------------+
		|  1 |         1 |       4 |         | 2021-09-28 01:00:00 |
		|  2 |         3 |       2 |         | 2021-09-28 03:00:00 |
		|  3 |         1 |       2 |         | 2021-09-28 01:00:00 |
		|  4 |         5 |       2 |         | 2021-09-28 03:00:00 |
		|  5 |         2 |       5 |         | 2021-09-28 05:00:00 |
		+----+-----------+---------+---------+---------------------+
		5 rows in set (0.00 sec)

	-----------------------------------------------------------------------------------------------------------------------		
			
	 3.2 二级索引idx_nPlayerId的逻辑存放顺序：
		
		二级索引idx_nPlayerId 的组织顺序相当于 "order by nPlayerID asc,ID asc"; 即先按 nPlayerID 排序, 最后按 id 排序。
		
		shell> innodb_space -s ibdata1 -T test_db/table_league_club_game_score_total -I idx_nPlayerId index-recurse
		ROOT NODE #4: 5 records, 70 bytes
		  RECORD: (nPlayerID=1) → (ID=1)
		  RECORD: (nPlayerID=1) → (ID=3)
		  RECORD: (nPlayerID=2) → (ID=5)
		  RECORD: (nPlayerID=3) → (ID=2)
		  RECORD: (nPlayerID=5) → (ID=4)

				
		mysql> select nPlayerID,ID from table_league_club_game_score_total order by nPlayerID asc,ID asc;
		+-----------+----+
		| nPlayerID | ID |
		+-----------+----+
		|         1 |  1 |
		|         1 |  3 |
		|         2 |  5 |
		|         3 |  2 |
		|         5 |  4 |
		+-----------+----+
		5 rows in set (0.00 sec)

	
	-----------------------------------------------------------------------------------------------------------------------
	
	 3.3 二级索引idx_nClubID_tCreateTime的逻辑存放顺序：
		
		二级索引idx_nClubID_tCreateTime 的组织顺序相当于 "order by nClubID asc,tCreateTime asc,ID asc"; 即先按 nClubID 排序，然后再按 tCreateTime 排序, 最后按 ID 排序。
		
		
		shell> innodb_space -s ibdata1 -T test_db/table_league_club_game_score_total -I idx_nClubID_tCreateTime index-recurse
		ROOT NODE #5: 5 records, 85 bytes
		  RECORD: (nClubID=2, tCreateTime="2021-09-28 01:00:00") → (ID=3)
		  RECORD: (nClubID=2, tCreateTime="2021-09-28 03:00:00") → (ID=2)
		  RECORD: (nClubID=2, tCreateTime="2021-09-28 03:00:00") → (ID=4)
		  RECORD: (nClubID=4, tCreateTime="2021-09-28 01:00:00") → (ID=1)
		  RECORD: (nClubID=5, tCreateTime="2021-09-28 05:00:00") → (ID=5)


		mysql> select nClubID,tCreateTime, ID from table_league_club_game_score_total order by nClubID asc, tCreateTime asc, ID asc;
		+---------+---------------------+----+
		| nClubID | tCreateTime         | ID |
		+---------+---------------------+----+
		|       2 | 2021-09-28 01:00:00 |  3 |
		|       2 | 2021-09-28 03:00:00 |  2 |
		|       2 | 2021-09-28 03:00:00 |  4 |
		|       4 | 2021-09-28 01:00:00 |  1 |
		|       5 | 2021-09-28 05:00:00 |  5 |
		+---------+---------------------+----+
		5 rows in set (0.00 sec)


4. 通过2个慢查询的案例说明索引的重要性



5. 联合索引是如何提升查询速度的 

	主要是通过索引减少了数据量的搜索。	

	select * from table_league_club_game_score_total where nClubID=2 and (tCreateTime >="2021-09-28 02:00:00" tCreateTime <= "2021-09-28 03:00:00")
	
	如果有联合索引 nClubID + tCreateTime，只需要扫描2行记录

	如果有单列索引 nClubID，则需要扫描3行记录
	
	
	
6. 目前已知的服务端有1个平均执行耗时1秒多的慢查询分析
	

7. 插入10/50W行记录在不同索引个数的耗时对比

	
8. 个人建索引的一些技巧
	
	什么情况下用联合索引、单列索引
	怎么调整联合索引的顺序
	联合索引的最左列原则
		-- 这里要好好说说
			
	
	
	
	
	
	
4. 为什么索引可以加快查询速度
	
	
	

		
desc SELECT MIN(id), MAX(id) from (
SELECT id FROM `table_league_club_game_score_total` force index (idx_nClubID_tStartTime) WHERE `nClubID` = 666154 AND  tCreateTime>= '2021-09-27 00:00:00' GROUP BY szToken LIMIT 100
)temp;
+----+-------------+------------------------------------+------------+------+--------------------------------+------------------------+---------+-------+-------+----------+---------------------------------------------------------------------+
| id | select_type | table                              | partitions | type | possible_keys                  | key                    | key_len | ref   | rows  | filtered | Extra                                                               |
+----+-------------+------------------------------------+------------+------+--------------------------------+------------------------+---------+-------+-------+----------+---------------------------------------------------------------------+
|  1 | PRIMARY     | <derived2>                         | NULL       | ALL  | NULL                           | NULL                   | NULL    | NULL  |   100 |   100.00 | NULL                                                                |
|  2 | DERIVED     | table_league_club_game_score_total | NULL       | ref  | szToken,idx_nClubID_tStartTime | idx_nClubID_tStartTime | 4       | const | 20042 |    33.33 | Using index condition; Using where; Using temporary; Using filesort |
+----+-------------+------------------------------------+------------+------+--------------------------------+------------------------+---------+-------+-------+----------+---------------------------------------------------------------------+
2 rows in set, 1 warning (0.00 sec)


desc SELECT temp12.ID, tu.szNickName, temp12.nPlayerID, temp12.szToken, temp12.nTableID, temp12.nRound, UNIX_TIMESTAMP(temp12.tCreateTime) AS tStartTime, temp12.nKindID, temp12.`nTotalResult`, temp12.BigWinner, temp12.Dismiss 
FROM (SELECT b.ID, b.nPlayerID ,b.szToken, b.nTableID, b.nRound, b.tCreateTime, b.nKindID, b.`nTotalResult`, b.BigWinner, b.Dismiss  FROM (
SELECT nPlayerID, szToken FROM `table_league_club_game_score_total` force index (idx_nClubID_tStartTime) WHERE `nClubID` = 666154  AND `tCreateTime` >= '2021-09-27 00:00:00'
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



------------------------------------------------------------------------------------------------------------------------------------------------


	
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
|  3 | DERIVED     | table_league_club_game_score_total | NULL       | range  | PRIMARY,szToken,idx_nClubID_tStartTime | idx_nClubID_tStartTime | 12      | NULL             | 1034 |     4.12 | Using index condition; Using temporary; Using filesort |
+----+-------------+------------------------------------+------------+--------+----------------------------------------+------------------------+---------+------------------+------+----------+--------------------------------------------------------+
5 rows in set, 1 warning (0.00 sec)


优化后的执行耗时： 小于0.1秒。



二分查找法







