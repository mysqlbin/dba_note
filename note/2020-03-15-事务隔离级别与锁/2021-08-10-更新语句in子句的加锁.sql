

table_league_club_member的索引

  PRIMARY KEY (`ID`),
  KEY `idx_nExtenID` (`nExtenID`),
  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
  KEY `idx_nClubID` (`nClubID`) USING BTREE,
  KEY `idx_partner` (`partner`)

mysql> desc update table_league_club_member set nExtenID=0 where nPlayerID in (131256, 131257, 131145, 131258, 131259, 131146, 131260, 131147, 131148, 131149) AND nClubID = 666000;
+----+-------------+--------------------------+------------+-------+---------------------------+---------------+---------+-------+------+----------+-------------+
| id | select_type | table                    | partitions | type  | possible_keys             | key           | key_len | ref   | rows | filtered | Extra       |
+----+-------------+--------------------------+------------+-------+---------------------------+---------------+---------+-------+------+----------+-------------+
|  1 | UPDATE      | table_league_club_member | NULL       | range | idx_nPlayerID,idx_nClubID | idx_nPlayerID | 4       | const |   23 |   100.00 | Using where |
+----+-------------+--------------------------+------------+-------+---------------------------+---------------+---------+-------+------+----------+-------------+
1 row in set (0.00 sec)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


把 idx_nClubID 改为 idx_nClubID_nPlayerID
	
	alter table table_league_club_member add index idx_nClubID_nPlayerID(nClubID, nPlayerID), drop index idx_nClubID;

	table_league_club_member的索引

	  PRIMARY KEY (`ID`),
	  KEY `idx_nExtenID` (`nExtenID`),
	  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
	  KEY `idx_partner` (`partner`),
	  KEY `idx_nClubID_nPlayerID` (`nClubID`,`nPlayerID`)


	mysql> desc update table_league_club_member set nExtenID=0 where nPlayerID in (131256, 131257, 131145, 131258, 131259, 131146, 131260, 131147, 131148, 131149) AND nClubID = 666000;
	+----+-------------+--------------------------+------------+-------+-------------------------------------+-----------------------+---------+-------------+------+----------+-------------+
	| id | select_type | table                    | partitions | type  | possible_keys                       | key                   | key_len | ref         | rows | filtered | Extra       |
	+----+-------------+--------------------------+------------+-------+-------------------------------------+-----------------------+---------+-------------+------+----------+-------------+
	|  1 | UPDATE      | table_league_club_member | NULL       | range | idx_nPlayerID,idx_nClubID_nPlayerID | idx_nClubID_nPlayerID | 8       | const,const |   10 |   100.00 | Using where |
	+----+-------------+--------------------------+------------+-------+-------------------------------------+-----------------------+---------+-------------+------+----------+-------------+
	1 row in set (0.00 sec)

