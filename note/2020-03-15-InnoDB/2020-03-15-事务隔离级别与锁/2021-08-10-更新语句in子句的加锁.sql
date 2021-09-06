

table_club_member 的索引
  `nClubID` int(11) NOT NULL COMMENT '',
  `nPlayerID` int(11) NOT NULL COMMENT '',
  
  PRIMARY KEY (`ID`),
  KEY `idx_nExtenID` (`nExtenID`),
  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
  KEY `idx_nClubID` (`nClubID`) USING BTREE,
  KEY `idx_partner` (`partner`)

mysql> desc update table_club_member set nExtenID=0 where nPlayerID in (131256, 131257, 131145, 131258, 131259, 131146, 131260, 131147, 131148, 131149) AND nClubID = 666000;
+----+-------------+--------------------------+------------+-------+---------------------------+---------------+---------+-------+------+----------+-------------+
| id | select_type | table                    | partitions | type  | possible_keys             | key           | key_len | ref   | rows | filtered | Extra       |
+----+-------------+--------------------------+------------+-------+---------------------------+---------------+---------+-------+------+----------+-------------+
|  1 | UPDATE      | table_club_member | NULL       | range | idx_nPlayerID,idx_nClubID | idx_nPlayerID | 4       | const |   23 |   100.00 | Using where |
+----+-------------+--------------------------+------------+-------+---------------------------+---------------+---------+-------+------+----------+-------------+
1 row in set (0.00 sec)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


把 idx_nClubID 改为 idx_nClubID_nPlayerID
	
	alter table table_club_member add index idx_nClubID_nPlayerID(nClubID, nPlayerID), drop index idx_nClubID;

	table_club_member的索引

	  PRIMARY KEY (`ID`),
	  KEY `idx_nExtenID` (`nExtenID`),
	  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
	  KEY `idx_partner` (`partner`),
	  KEY `idx_nClubID_nPlayerID` (`nClubID`,`nPlayerID`)


	mysql> desc update table_club_member set nExtenID=0 where nPlayerID in (131256, 131257, 131145, 131258, 131259, 131146, 131260, 131147, 131148, 131149) AND nClubID = 666000;
	+----+-------------+--------------------------+------------+-------+-------------------------------------+-----------------------+---------+-------------+------+----------+-------------+
	| id | select_type | table                    | partitions | type  | possible_keys                       | key                   | key_len | ref         | rows | filtered | Extra       |
	+----+-------------+--------------------------+------------+-------+-------------------------------------+-----------------------+---------+-------------+------+----------+-------------+
	|  1 | UPDATE      | table_club_member | NULL       | range | idx_nPlayerID,idx_nClubID_nPlayerID | idx_nClubID_nPlayerID | 8       | const,const |   10 |   100.00 | Using where |
	+----+-------------+--------------------------+------------+-------+-------------------------------------+-----------------------+---------+-------------+------+----------+-------------+
	1 row in set (0.00 sec)
	
	 where nPlayerID in (131256, 131257, 131145, 131258, 131259, 131146, 131260, 131147, 131148, 131149) AND nClubID = 666000
	 
	 -- 会转换为等值查找，如下所示
	 
	 where nPlayerID = 131256 AND nClubID = 666000
	 where nPlayerID = 131257 AND nClubID = 666000
	 where nPlayerID = 131145 AND nClubID = 666000
	 .............................................
	 where nPlayerID = 131149 AND nClubID = 666000
	 
	 -- 因此，可以用到 idx_nClubID_nPlayerID 索引。
	 
	 
	
	