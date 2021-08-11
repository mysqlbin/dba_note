------------------------
LATEST DETECTED DEADLOCK
------------------------
2021-08-01 04:40:13 7fac78571700
*** (1) TRANSACTION:
TRANSACTION 3834442416, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 5 lock struct(s), heap size 1184, 2 row lock(s)
MySQL thread id 3672040, OS thread handle 0x7fac73ed9700, query id 4713281324 10.30.210.161 app_user Sending data
call pr_club_set_table_status(332755,4,@r,@returnVal)

mysql> select * from `yldb`.`table_club_gametable` where id=3812865;                                                                                                                                                                                                           
+---------+-----------+----------+----------+---------+------+-------------+-------+-----------+------------------------------------------------------------------------------------+---------+---------------------+---------------------+-------------+------------+
| ID      | nPlayerID | nClubID  | nTableID | nGameID | Cost | PlayerCount | Round | GameRound | RoomInfo                                                                           | nStatus | tCreateTime         | tEndTime            | CheckStatus | nDeduction |
+---------+-----------+----------+----------+---------+------+-------------+-------+-----------+------------------------------------------------------------------------------------+---------+---------------------+---------------------+-------------+------------+
| 3812865 |    178793 | 66660197 |   332755 |    2022 |   60 |           6 |    10 |         0 | 来宾十三张  人数【6】 底分【1】 局数【10】 黑桃A  增加两色                         |       3 | 2021-08-01 04:35:56 | 2021-08-01 04:40:13 |           0 |          1 |
+---------+-----------+----------+----------+---------+------+-------------+-------+-----------+------------------------------------------------------------------------------------+---------+---------------------+---------------------+-------------+------------+
1 row in set (0.00 sec)

*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 82149 page no 38020 n bits 104 index `PRIMARY` of table `yldb`.`table_club_gametable` trx id 3834442416 lock mode S locks rec but not gap waiting
Record lock, heap no 32 PHYSICAL RECORD: n_fields 17; compact format; info bits 0
 0: len 8; hex 80000000003a2e01; asc      :. ;;   -- ID 3a2e01 3812865
 1: len 6; hex 0000e48cf2af; asc       ;;	      -- 事务ID   3834442415
 2: len 7; hex 01000019ef094f; asc       O;;
 3: len 4; hex 8002ba69; asc    i;;         nPlayerID 2ba69 -> 178793
 4: len 4; hex 83f92765; asc   e;;          nClubID  3f92765 -> 66660197
 5: len 4; hex 800513d3; asc     ;;         nTableID  513d3  -> 332755
 6: len 4; hex 800007e6; asc     ;; 
 7: len 4; hex 8000003c; asc    <;;
 8: len 4; hex 80000006; asc     ;;
 9: len 4; hex 8000000a; asc     ;;
 10: len 4; hex 80000000; asc     ;;
 11: len 30; hex e69da5e5aebee58d81e4b889e5bca02020e4babae695b0e3809036e38091; asc                           6   ; (total 82 bytes);
 12: len 1; hex 83; asc  ;;
 13: len 4; hex 6105b42c; asc a  ,;;
 14: len 4; hex 6105b52d; asc a  -;;
 15: len 1; hex 80; asc  ;;
 16: len 1; hex 81; asc  ;;

*** (2) TRANSACTION:
TRANSACTION 3834442415, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1184, 2 row lock(s), undo log entries 1
MySQL thread id 3672099, OS thread handle 0x7fac78571700, query id 4713281317 10.30.210.161 app_user updating

UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = $intTableId AND nStatus = _status_val and ID=_id

*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 82149 page no 38020 n bits 104 index `PRIMARY` of table `yldb`.`table_club_gametable` trx id 3834442415 lock_mode X locks rec but not gap
Record lock, heap no 32 PHYSICAL RECORD: n_fields 17; compact format; info bits 0
 0: len 8; hex 80000000003a2e01; asc      :. ;;
 1: len 6; hex 0000e48cf2af; asc       ;;        -- 事务ID  16进制：e48cf2af -> 10进制：3834442415
 2: len 7; hex 01000019ef094f; asc       O;;
 3: len 4; hex 8002ba69; asc    i;;
 4: len 4; hex 83f92765; asc   'e;;
 5: len 4; hex 800513d3; asc     ;;
 6: len 4; hex 800007e6; asc     ;;
 7: len 4; hex 8000003c; asc    <;;
 8: len 4; hex 80000006; asc     ;;
 9: len 4; hex 8000000a; asc     ;;
 10: len 4; hex 80000000; asc     ;;
 11: len 30; hex e69da5e5aebee58d81e4b889e5bca02020e4babae695b0e3809036e38091; asc                           6   ; (total 82 bytes);
 12: len 1; hex 83; asc  ;;
 13: len 4; hex 6105b42c; asc a  ,;;
 14: len 4; hex 6105b52d; asc a  -;;
 15: len 1; hex 80; asc  ;;
 16: len 1; hex 81; asc  ;;

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 82149 page no 20187 n bits 832 index `idx_nTableID_nStatus` of table `yldb`.`table_club_gametable` trx id 3834442415 lock_mode X locks rec but not gap waiting
Record lock, heap no 765 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 800513d3; asc     ;;
 1: len 1; hex 80; asc  ;;
 2: len 8; hex 80000000003a2e01; asc      :. ;;

*** WE ROLL BACK TRANSACTION (2)
