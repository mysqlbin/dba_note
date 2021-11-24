


mysql> select * from mysql.innodb_table_stats where database_name='niuniuh5_db' and table_name='table_clubgamescoredetail';
+---------------+---------------------------+---------------------+----------+----------------------+--------------------------+
| database_name | table_name                | last_update         | n_rows   | clustered_index_size | sum_of_other_index_sizes |
+---------------+---------------------------+---------------------+----------+----------------------+--------------------------+
| niuniuh5_db   | table_clubgamescoredetail | 2019-08-13 09:33:44 | 12049287 |               117504 |                   136252 |
+---------------+---------------------------+---------------------+----------+----------------------+--------------------------+
1 row in set (0.00 sec)


mysql> select * from mysql.innodb_index_stats where database_name='niuniuh5_db' and table_name='table_clubgamescoredetail';
+---------------+---------------------------+--------------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name                | index_name                     | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+---------------------------+--------------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
| niuniuh5_db   | table_clubgamescoredetail | PRIMARY                        | 2019-08-13 09:33:44 | n_diff_pfx01 |   12049287 |          20 | ID                                |
| niuniuh5_db   | table_clubgamescoredetail | PRIMARY                        | 2019-08-13 09:33:44 | n_leaf_pages |     117268 |        NULL | Number of leaf pages in the index |
| niuniuh5_db   | table_clubgamescoredetail | PRIMARY                        | 2019-08-13 09:33:44 | size         |     117504 |        NULL | Number of pages in the index      |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_bRobot_tEndTime    | 2019-08-13 09:33:44 | n_diff_pfx01 |        502 |           4 | nClubID                           |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_bRobot_tEndTime    | 2019-08-13 09:33:44 | n_diff_pfx02 |       1004 |           6 | nClubID,bRobot                    |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_bRobot_tEndTime    | 2019-08-13 09:33:44 | n_diff_pfx03 |    4693024 |          20 | nClubID,bRobot,tEndTime           |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_bRobot_tEndTime    | 2019-08-13 09:33:44 | n_diff_pfx04 |   10691094 |          20 | nClubID,bRobot,tEndTime,ID        |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_bRobot_tEndTime    | 2019-08-13 09:33:44 | n_leaf_pages |      16072 |        NULL | Number of leaf pages in the index |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_bRobot_tEndTime    | 2019-08-13 09:33:44 | size         |      16832 |        NULL | Number of pages in the index      |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_szToken            | 2019-08-13 09:33:44 | n_diff_pfx01 |        476 |           4 | nClubID                           |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_szToken            | 2019-08-13 09:33:44 | n_diff_pfx02 |    2964625 |          20 | nClubID,szToken                   |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_szToken            | 2019-08-13 09:33:44 | n_diff_pfx03 |   12274976 |          20 | nClubID,szToken,ID                |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_szToken            | 2019-08-13 09:33:44 | n_leaf_pages |      54799 |        NULL | Number of leaf pages in the index |
| niuniuh5_db   | table_clubgamescoredetail | idx_nClubID_szToken            | 2019-08-13 09:33:44 | size         |      62975 |        NULL | Number of pages in the index      |
| niuniuh5_db   | table_clubgamescoredetail | idx_nPlayerID_nClubID_tEndTime | 2019-08-13 09:33:44 | n_diff_pfx01 |      63023 |          20 | nPlayerID                         |
| niuniuh5_db   | table_clubgamescoredetail | idx_nPlayerID_nClubID_tEndTime | 2019-08-13 09:33:44 | n_diff_pfx02 |     129047 |          20 | nPlayerID,nClubID                 |
| niuniuh5_db   | table_clubgamescoredetail | idx_nPlayerID_nClubID_tEndTime | 2019-08-13 09:33:44 | n_diff_pfx03 |   12098934 |          20 | nPlayerID,nClubID,tEndTime        |
| niuniuh5_db   | table_clubgamescoredetail | idx_nPlayerID_nClubID_tEndTime | 2019-08-13 09:33:44 | n_diff_pfx04 |   11824334 |          20 | nPlayerID,nClubID,tEndTime,ID     |
| niuniuh5_db   | table_clubgamescoredetail | idx_nPlayerID_nClubID_tEndTime | 2019-08-13 09:33:44 | n_leaf_pages |      30011 |        NULL | Number of leaf pages in the index |
| niuniuh5_db   | table_clubgamescoredetail | idx_nPlayerID_nClubID_tEndTime | 2019-08-13 09:33:44 | size         |      34432 |        NULL | Number of pages in the index      |
| niuniuh5_db   | table_clubgamescoredetail | idx_tEndTime_bRobot            | 2019-08-13 09:33:44 | n_diff_pfx01 |    2540715 |          20 | tEndTime                          |
| niuniuh5_db   | table_clubgamescoredetail | idx_tEndTime_bRobot            | 2019-08-13 09:33:44 | n_diff_pfx02 |    4961269 |          20 | tEndTime,bRobot                   |
| niuniuh5_db   | table_clubgamescoredetail | idx_tEndTime_bRobot            | 2019-08-13 09:33:44 | n_diff_pfx03 |   12427686 |          20 | tEndTime,bRobot,ID                |
| niuniuh5_db   | table_clubgamescoredetail | idx_tEndTime_bRobot            | 2019-08-13 09:33:44 | n_leaf_pages |      19226 |        NULL | Number of leaf pages in the index |
| niuniuh5_db   | table_clubgamescoredetail | idx_tEndTime_bRobot            | 2019-08-13 09:33:44 | size         |      22013 |        NULL | Number of pages in the index      |
+---------------+---------------------------+--------------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
25 rows in set (0.00 sec)



mysql> desc select temp.nClubID,temp.nPlayerId,users.szThirdAccount szNickName,temp.nRound,temp.nValidBet, temp.nResultMoney  from (  select detail.nClubID,detail.nPlayerId,count(detail.nRound) nRound,SUM(detail.nValidBet) nValidBet, SUM(detail.nResultMoney) nResultMoney from Table_ClubGameScoreDetail detail  where detail.nClubID=10002 and detail.bRobot=0  and detail.nGameType in (9,10,11,12,13,14,15,16,17,110,111)  and detail.tEndTime>='2019-07-19 00:00:00'  and detail.tEndTime<='2019-08-19 23:59:59'  GROUP BY detail.nClubID,detail.nPlayerId  limit 0,10 )temp left join table_user users on temp.nPlayerId=users.nPlayerID;
+----+-------------+------------+------------+--------+----------------------------------------------------------------------------------------------------+--------------------------------+---------+----------------+-------+----------+-------------+
| id | select_type | table      | partitions | type   | possible_keys                                                                                      | key                            | key_len | ref            | rows  | filtered | Extra       |
+----+-------------+------------+------------+--------+----------------------------------------------------------------------------------------------------+--------------------------------+---------+----------------+-------+----------+-------------+
|  1 | PRIMARY     | <derived2> | NULL       | ALL    | NULL                                                                                               | NULL                           | NULL    | NULL           |    10 |   100.00 | NULL        |
|  1 | PRIMARY     | users      | NULL       | eq_ref | PRIMARY                                                                                            | PRIMARY                        | 4       | temp.nPlayerId |     1 |   100.00 | Using where |
|  2 | DERIVED     | detail     | NULL       | index  | idx_nClubID_szToken,idx_tEndTime_bRobot,idx_nClubID_bRobot_tEndTime,idx_nPlayerID_nClubID_tEndTime | idx_nPlayerID_nClubID_tEndTime | 16      | NULL           | 10896 |     1.25 | Using where |
+----+-------------+------------+------------+--------+----------------------------------------------------------------------------------------------------+--------------------------------+---------+----------------+-------+----------+-------------+
3 rows in set, 1 warning (0.01 sec)

执行时间:
	10 rows in set (1 min 2.88 sec)
	
explain.rows=10896	
优化器选择索引idx_nPlayerID_nClubID_tEndTime的原因:
	where条件上没有使用到索引
	认为使用索引idx_nPlayerID_nClubID_tEndTime能够避免使用临时表和排序，同时扫描的行数少, 所以认为代价较小：


force index(`idx_nClubID_bRobot_tEndTime`): 
mysql> desc select temp.nClubID,temp.nPlayerId,users.szThirdAccount szNickName,temp.nRound,temp.nValidBet, temp.nResultMoney  from (  select detail.nClubID,detail.nPlayerId,count(detail.nRound) nRound,SUM(detail.nValidBet) nValidBet, SUM(detail.nResultMoney) nResultMoney from Table_ClubGameScoreDetail detail force index(`idx_nClubID_bRobot_tEndTime`)  where detail.nClubID=10002 and detail.bRobot=0  and detail.nGameType in (9,10,11,12,13,14,15,16,17,110,111)  and detail.tEndTime>='2019-07-19 00:00:00'  and detail.tEndTime<='2019-08-19 23:59:59'  GROUP BY detail.nClubID,detail.nPlayerId  limit 0,10 )temp left join table_user users on temp.nPlayerId=users.nPlayerID;
+----+-------------+------------+------------+--------+------------------------------------------------------------+-----------------------------+---------+----------------+---------+----------+---------------------------------------------------------------------+
| id | select_type | table      | partitions | type   | possible_keys                                              | key                         | key_len | ref            | rows    | filtered | Extra                                                               |
+----+-------------+------------+------------+--------+------------------------------------------------------------+-----------------------------+---------+----------------+---------+----------+---------------------------------------------------------------------+
|  1 | PRIMARY     | <derived2> | NULL       | ALL    | NULL                                                       | NULL                        | NULL    | NULL           |      10 |   100.00 | NULL                                                                |
|  1 | PRIMARY     | users      | NULL       | eq_ref | PRIMARY                                                    | PRIMARY                     | 4       | temp.nPlayerId |       1 |   100.00 | Using where                                                         |
|  2 | DERIVED     | detail     | NULL       | range  | idx_nClubID_bRobot_tEndTime,idx_nPlayerID_nClubID_tEndTime | idx_nClubID_bRobot_tEndTime | 12      | NULL           | 2139552 |    50.00 | Using index condition; Using where; Using temporary; Using filesort |
+----+-------------+------------+------------+--------+------------------------------------------------------------+-----------------------------+---------+----------------+---------+----------+---------------------------------------------------------------------+
3 rows in set, 1 warning (0.00 sec)

执行时间:
	10 rows in set (4.54 sec)
	
explain.rows=2139552	
explain.Extra=Using index condition; Using where; Using temporary; Using filesort

强制让优化器选择索引 idx_nClubID_bRobot_tEndTime:
	虽然扫描的行数很多, 2139552/10896 = 196, 跟优化器默认选择的索引扫描的行数大了196倍
	同时SQL语句使用到了临时表和排序, 但是这里的需求是只取10条记录
	从SQL的执行效率来看, 这个场景下, 强制使用索引 idx_nClubID_bRobot_tEndTime 往往是更好的选择.
	




