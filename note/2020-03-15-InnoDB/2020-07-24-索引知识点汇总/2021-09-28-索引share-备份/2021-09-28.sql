

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
	5. 插入10/50W行记录在不同索引个数的耗时对比
	6. 个人建索引的一些技巧
	
	
	

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


	
2. 主键索引和二级索引的有序性

	2.0 基础知识
	
		1. 每一个索引在 InnoDB 存储引擎里面对应一棵 B+ 树。
		2. InnoDB 存储引擎采用的是 B+ 树作为底层的数据结构。
		3. 根据索引键值进行有序排序。
		
			-- 画图
	
	
	2.1 主键索引ID的逻辑存放顺序
		
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

			
			
	 2.2 二级索引idx_nPlayerId的逻辑存放顺序：
		
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
	
	 2.3 二级索引idx_nClubID_tCreateTime的逻辑存放顺序：
		
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



3. B+树的非叶子节点和叶子节点
	
	
	0. B+树有 非叶子节点，叶子节点
	
		非叶子节点存储的是索引的键值
		-- 画图
		
		
	1. 主键索引的叶子节点存储的是一整行数据
	
	    主键索引ID包含的字段有：(ID, nPlayerID, nClubID, szToken, tCreateTime)
	
	
	2. 二级索引的叶子节点存储的是二级索引列的值+对应主键索引列的值
	
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
	

	
		
4. 通过2个慢查询的案例说明索引的重要性



5. 插入10/50W行记录在不同索引个数的耗时对比

	


6. 个人建索引的一些技巧
	
	什么情况下用联合索引、单列索引
	怎么调整联合索引的顺序
	联合索引的最左列原则
		-- 这里要好好说说
			
	
	
	
	
	
	
4. 为什么索引可以加快查询速度
	
	主要是通过索引减少了数据量的搜索。


	
	
	

