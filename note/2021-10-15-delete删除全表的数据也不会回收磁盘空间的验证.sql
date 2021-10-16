

shell> ls -lht table_league_club_game_score_detail.ibd
-rw-r----- 1 mysql mysql 104M 8月  17 15:45 table_league_club_game_score_detail.ibd


mysql> select count(*) from table_league_club_game_score_detail;
+----------+
| count(*) |
+----------+
|   524124 |
+----------+
1 row in set (0.21 sec)


mysql> delete from table_league_club_game_score_detail;
Query OK, 524124 rows affected (18.55 sec)

mysql> select count(*) from table_league_club_game_score_detail;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.01 sec)



shell> ls -lht table_league_club_game_score_detail.ibd
-rw-r----- 1 mysql mysql 104M 10月 15 10:24 table_league_club_game_score_detail.ibd


为什么做这个实验：
	生产环境上有按天分表，每天有定时删除3个月之前的分表数据，没有做删除表的操作，导致数据占用磁盘的空间，相对较大
	一般都是在停服的时候，做删除过期分表的操作，因为 drop table 操作会锁数据字典、锁内存，阻塞DML语句。
	