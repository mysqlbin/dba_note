


mysql> select id FROM `table_league_club_game_score_total` WHere `nClubID` = 10 AND `nPlayerID` = 10 and  tStartTime>= '2020-11-02 00:00:00' order by ID DESC;
+----+
| id |
+----+
|  9 |
|  7 |
|  5 |
|  4 |
+----+
4 rows in set (0.00 sec)


mysql> select min(id), max(id) FROM `table_league_club_game_score_total` WHere `nClubID` = 10 AND `nPlayerID` = 10 and  tStartTime>= '2020-11-02 00:00:00' order by ID DESC;
+---------+---------+
| min(id) | max(id) |
+---------+---------+
|       4 |       9 |
+---------+---------+
1 row in set (0.00 sec)



mysql> select min(id), max(id) FROM `table_league_club_game_score_total` WHere `nClubID` = 10 AND `nPlayerID` = 10 and  tStartTime>= '2020-11-02 00:00:00' order by ID DESC limit 3;
+---------+---------+
| min(id) | max(id) |
+---------+---------+
|       4 |       9 |
+---------+---------+
1 row in set (0.00 sec)


mysql> select min(id), max(id) from(
		select id FROM `table_league_club_game_score_total` WHERE `nClubID` = 10 AND `nPlayerID` = 10 and  tStartTime>= '2020-11-03 00:00:00' order by tStartTime DESC limit 3
	) temp;

+---------+---------+
| min(id) | max(id) |
+---------+---------+
|       5 |       9 |
+---------+---------+
1 row in set (0.00 sec)


FROM：     FROM子句是最先执行的，确定了查询的是 table_league_club_game_score_total 这张表
SELECT：   SELECT子句是第二个执行的子句，同时min()和max()函数也在此时执行了。
ORDER BY： ORDER BY子句是第三个执行的子句
LIMIT：    LIMIT子句是最后执行的

相关参考
	https://www.cnblogs.com/hyhy904/p/11072377.html   mysql踩坑记录之limit和sum函数混合使用问题
	
	
	
