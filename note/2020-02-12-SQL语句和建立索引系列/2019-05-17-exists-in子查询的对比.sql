
smysql> desc select nPlayerId from table_clubmember tc where nClubID in (select nClubID from table_clublogscore);
+----+-------------+--------------------+------------+-------+---------------+-------------------------------+---------+------+---------+----------+--------------------------------------------------------------------+
| id | select_type | table              | partitions | type  | possible_keys | key                           | key_len | ref  | rows    | filtered | Extra                                                              |
+----+-------------+--------------------+------------+-------+---------------+-------------------------------+---------+------+---------+----------+--------------------------------------------------------------------+
|  1 | SIMPLE      | tc                 | NULL       | index | NULL          | idx_nPlayerID_nClubID_nStatus | 9       | NULL |   18127 |   100.00 | Using index                                                        |
|  1 | SIMPLE      | table_clublogscore | NULL       | index | NULL          | idx_nTableID                  | 4       | NULL | 3199734 |   100.00 | Using index; FirstMatch(tc); Using join buffer (Block Nested Loop) |
+----+-------------+--------------------+------------+-------+---------------+-------------------------------+---------+------+---------+----------+--------------------------------------------------------------------+
2 rows in set, 2 warnings (0.00 sec)

18427 rows in set (4 min 19.48 sec);


exists:
mysql> desc select nPlayerId from table_clubmember where exists(select nClubID from table_clublogscore where nClubID=table_clubmember.nClubID);
+----+--------------------+--------------------+------------+-------+---------------+-------------------------------+---------+------+---------+----------+--------------------------+
| id | select_type        | table              | partitions | type  | possible_keys | key                           | key_len | ref  | rows    | filtered | Extra                    |
+----+--------------------+--------------------+------------+-------+---------------+-------------------------------+---------+------+---------+----------+--------------------------+
|  1 | PRIMARY            | table_clubmember   | NULL       | index | NULL          | idx_nPlayerID_nClubID_nStatus | 9       | NULL |   18127 |   100.00 | Using where; Using index |
|  2 | DEPENDENT SUBQUERY | table_clublogscore | NULL       | index | NULL          | idx_nTableID                  | 4       | NULL | 3199734 |   100.00 | Using index              |
+----+--------------------+--------------------+------------+-------+---------------+-------------------------------+---------+------+---------+----------+--------------------------+
2 rows in set, 4 warnings (0.00 sec)

mysql> show warnings;
+-------+------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Level | Code | Message                                                                                                                                                                                                                                                            |
+-------+------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Note  | 1276 | Field or reference 'nn_recovery_db.table_clubmember.nClubID' of SELECT #2 was resolved in SELECT #1                                                                                                                                                                |
| Note  | 1276 | Field or reference 'nn_recovery_db.table_clubmember.nClubID' of SELECT #2 was resolved in SELECT #1                                                                                                                                                                |
| Note  | 1276 | Field or reference 'nn_recovery_db.table_clubmember.nClubID' of SELECT #2 was resolved in SELECT #1                                                                                                                                                                |
| Note  | 1003 | /* select#1 */ select `nn_recovery_db`.`table_clubmember`.`nPlayerID` AS `nPlayerId` from `nn_recovery_db`.`table_clubmember` where exists(/* select#2 */ select `nn_recovery_db`.`table_clubmember`.`nClubID` from `nn_recovery_db`.`table_clublogscore` where 1) |
+-------+------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
4 rows in set (0.01 sec)


执行时间:
18427 rows in set (0.04 sec)


innert join: 
mysql> desc select tcm.nPlayerId from table_clubmember tcm STRAIGHT_JOIN  table_clublogscore tcl on tcm.nClubID=tcl.clubid;
mysql> desc select tcm.nPlayerId from table_clubmember tcm inner join table_clublogscore tcl on tcm.nClubID=tcl.clubid;
+----+-------------+-------+------------+-------+-----------------------------+---------------------------------+---------+---------------------------+---------+----------+--------------------------+
| id | select_type | table | partitions | type  | possible_keys               | key                             | key_len | ref                       | rows    | filtered | Extra                    |
+----+-------------+-------+------------+-------+-----------------------------+---------------------------------+---------+---------------------------+---------+----------+--------------------------+
|  1 | SIMPLE      | tcl   | NULL       | index | idx_clubid_nType_CreateTime | idx_nPlayerID_clubid_CreateTime | 13      | NULL                      | 3199734 |   100.00 | Using where; Using index |
|  1 | SIMPLE      | tcm   | NULL       | ref   | index_nClubID               | index_nClubID                   | 4       | nn_recovery_db.tcl.clubid |      61 |   100.00 | NULL                     |
+----+-------------+-------+------------+-------+-----------------------------+---------------------------------+---------+---------------------------+---------+----------+--------------------------+
2 rows in set, 1 warning (0.00 sec)

mysql> show warnings;
+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Level | Code | Message                                                                                                                                                                                                                                            |
+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Note  | 1003 | /* select#1 */ select `nn_recovery_db`.`tcm`.`nPlayerID` AS `nPlayerId` from `nn_recovery_db`.`table_clubmember` `tcm` join `nn_recovery_db`.`table_clublogscore` `tcl` where (`nn_recovery_db`.`tcm`.`nClubID` = `nn_recovery_db`.`tcl`.`clubid`) |
+-------+------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

SELECT
	`nn_recovery_db`.`tcm`.`nPlayerID` AS `nPlayerId`
FROM
	`nn_recovery_db`.`table_clubmember` `tcm`
JOIN `nn_recovery_db`.`table_clublogscore` `tcl`
WHERE
	(
		`nn_recovery_db`.`tcm`.`nClubID` = `nn_recovery_db`.`tcl`.`clubid`
	) 
	
mysql> select tcm.nPlayerId from table_clubmember tcm STRAIGHT_JOIN  table_clublogscore tcl on tcm.nClubID=tcl.clubid;
Killed
mysql> select tcm.nPlayerId from table_clubmember tcm inner join table_clublogscore tcl on tcm.nClubID=tcl.clubid;
Killed

有时候 join 不一定比 exists 好, 看是在场景什么下. 不过 exists 一般要比




mysql> desc select tc.nPlayerId from nn_recovery_db.table_clublogscore tc where tc.clubid in (select nClubID from nn_recovery_db.table_clubmember);
+----+--------------+------------------+------------+--------+-----------------------------+---------------------------------+---------+--------------------------+---------+----------+--------------------------+
| id | select_type  | table            | partitions | type   | possible_keys               | key                             | key_len | ref                      | rows    | filtered | Extra                    |
+----+--------------+------------------+------------+--------+-----------------------------+---------------------------------+---------+--------------------------+---------+----------+--------------------------+
|  1 | SIMPLE       | tc               | NULL       | index  | idx_clubid_nType_CreateTime | idx_nPlayerID_clubid_CreateTime | 13      | NULL                     | 3199734 |   100.00 | Using where; Using index |
|  1 | SIMPLE       | <subquery2>      | NULL       | eq_ref | <auto_key>                  | <auto_key>                      | 4       | nn_recovery_db.tc.clubid |       1 |   100.00 | NULL                     |
|  2 | MATERIALIZED | table_clubmember | NULL       | index  | index_nClubID               | index_nClubID                   | 4       | NULL                     |   18127 |   100.00 | Using index              |
+----+--------------+------------------+------------+--------+-----------------------------+---------------------------------+---------+--------------------------+---------+----------+--------------------------+
3 rows in set, 1 warning (0.00 sec)

3237746 rows in set (4.39 sec)


exists:

mysql> desc select nPlayerId from table_clublogscore  where exists(select nClubID from table_clubmember where nClubID=table_clubmember.nClubID);
+----+-------------+--------------------+------------+-------+---------------+---------------------------------+---------+------+---------+----------+-------------+
| id | select_type | table              | partitions | type  | possible_keys | key                             | key_len | ref  | rows    | filtered | Extra       |
+----+-------------+--------------------+------------+-------+---------------+---------------------------------+---------+------+---------+----------+-------------+
|  1 | PRIMARY     | table_clublogscore | NULL       | index | NULL          | idx_nPlayerID_clubid_CreateTime | 13      | NULL | 3199734 |   100.00 | Using index |
|  2 | SUBQUERY    | table_clubmember   | NULL       | index | NULL          | index_nClubID                   | 4       | NULL |   18127 |   100.00 | Using index |
+----+-------------+--------------------+------------+-------+---------------+---------------------------------+---------+------+---------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)

3237746 rows in set (1.32 sec)

 
 
 

