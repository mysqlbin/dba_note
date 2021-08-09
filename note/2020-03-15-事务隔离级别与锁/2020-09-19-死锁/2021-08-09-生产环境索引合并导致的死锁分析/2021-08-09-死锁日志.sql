2021-08-08T23:52:47.967151+08:00 1030695 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2021-08-08T23:52:47.967178+08:00 1030695 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 741866797, ACTIVE 0 sec fetching rows
mysql tables in use 3, locked 3
LOCK WAIT 7 lock struct(s), heap size 1136, 4 row lock(s)
MySQL thread id 1030693, OS thread handle 140347590842112, query id 5403262617 172.16.0.53 apph5_user updating
UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID
2021-08-08T23:52:47.967217+08:00 1030695 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1949 page no 142 n bits 192 index PRIMARY of table `niuniuh5_db`.`table_league_club_member` trx id 741866797 lock_mode X locks rec but not gap waiting
Record lock, heap no 6 PHYSICAL RECORD: n_fields 20; compact format; info bits 0
 0: len 4; hex 00001f19; asc     ;;    -- 主键ID, 1f19从16进制转换为10进制，得到值：7961
 1: len 6; hex 00002c37c282; asc   ,7  ;;
 2: len 7; hex 32000040092f7f; asc 2  @ / ;;
 3: len 4; hex 800a2a1a; asc   * ;;
 4: len 4; hex 8001e61a; asc     ;;
 5: len 3; hex efa3bf; asc    ;;
 6: len 0; hex ; asc ;;
 7: len 0; hex ; asc ;;
 8: len 1; hex 83; asc  ;;
 9: len 1; hex 80; asc  ;;
 10: len 1; hex 81; asc  ;;
 11: len 4; hex 60efbb07; asc `   ;;
 12: SQL NULL;
 13: len 8; hex 8000000000000000; asc         ;;
 14: len 8; hex 8000000000000004; asc         ;;
 15: len 4; hex 80000000; asc     ;;
 16: len 4; hex 00000000; asc     ;;
 17: len 4; hex 80000000; asc     ;;
 18: len 1; hex 80; asc  ;;
 19: SQL NULL;

2021-08-08T23:52:47.968464+08:00 1030695 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 741866798, ACTIVE 0 sec fetching rows
mysql tables in use 3, locked 3
7 lock struct(s), heap size 1136, 3 row lock(s)
MySQL thread id 1030695, OS thread handle 140347590301440, query id 5403262616 172.16.0.53 apph5_user updating
UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID
2021-08-08T23:52:47.968510+08:00 1030695 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 1949 page no 142 n bits 192 index PRIMARY of table `niuniuh5_db`.`table_league_club_member` trx id 741866798 lock_mode X locks rec but not gap
Record lock, heap no 6 PHYSICAL RECORD: n_fields 20; compact format; info bits 0
 0: len 4; hex 00001f19; asc     ;;    -- 主键ID, 1f19从16进制转换为10进制，得到值：7961
 1: len 6; hex 00002c37c282; asc   ,7  ;; -- 事务ID, 
 2: len 7; hex 32000040092f7f; asc 2  @ / ;;  -- 回滚段ID
 3: len 4; hex 800a2a1a; asc   * ;;     -- nClubID字段，1f19从16进制转换为10进制，得到值：666138
 4: len 4; hex 8001e61a; asc     ;;     -- nPlayerID字段，1e61a从16进制转换为10进制，得到值：124442
 5: len 3; hex efa3bf; asc    ;;
 6: len 0; hex ; asc ;;
 7: len 0; hex ; asc ;;
 8: len 1; hex 83; asc  ;;
 9: len 1; hex 80; asc  ;;
 10: len 1; hex 81; asc  ;;
 11: len 4; hex 60efbb07; asc `   ;;
 12: SQL NULL;
 13: len 8; hex 8000000000000000; asc         ;;
 14: len 8; hex 8000000000000004; asc         ;;
 15: len 4; hex 80000000; asc     ;;
 16: len 4; hex 00000000; asc     ;;
 17: len 4; hex 80000000; asc     ;;
 18: len 1; hex 80; asc  ;;
 19: SQL NULL;

2021-08-08T23:52:47.969002+08:00 1030695 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1949 page no 84 n bits 1112 index idx_nClubID of table `niuniuh5_db`.`table_league_club_member` trx id 741866798 lock_mode X locks rec but not gap waiting
Record lock, heap no 560 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 800a2a1a; asc   * ;;  -- nClubID字段，1f19从16进制转换为10进制，得到值：666138
 1: len 4; hex 00001f19; asc     ;;	 -- 主键ID, 1f19从16进制转换为10进制，得到值：7961

2021-08-08T23:52:47.969089+08:00 1030695 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)










--------------------------------------------------------------------------------------------------------









2021-08-09T00:00:01.756695+08:00 1104546 [Note] Aborted connection 1104546 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
2021-08-09T00:00:01.918551+08:00 1104550 [Note] Aborted connection 1104550 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
2021-08-09T00:28:58.627706+08:00 1030694 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2021-08-09T00:28:58.627744+08:00 1030694 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 741882720, ACTIVE 0 sec fetching rows
mysql tables in use 3, locked 3
LOCK WAIT 8 lock struct(s), heap size 1136, 4 row lock(s)
MySQL thread id 1030693, OS thread handle 140347590842112, query id 5403399552 172.16.0.53 apph5_user updating
UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID
2021-08-09T00:28:58.627806+08:00 1030694 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1949 page no 142 n bits 192 index PRIMARY of table `niuniuh5_db`.`table_league_club_member` trx id 741882720 lock_mode X locks rec but not gap waiting
Record lock, heap no 11 PHYSICAL RECORD: n_fields 20; compact format; info bits 0
 0: len 4; hex 00001f1e; asc     ;;
 1: len 6; hex 00002c37c4c1; asc   ,7  ;;
 2: len 7; hex 720001800e103a; asc r     :;;
 3: len 4; hex 800a2a1a; asc   * ;;
 4: len 4; hex 8001e614; asc     ;;
 5: len 6; hex e9b98fe7a88b; asc       ;;
 6: len 0; hex ; asc ;;
 7: len 0; hex ; asc ;;
 8: len 1; hex 83; asc  ;;
 9: len 1; hex 80; asc  ;;
 10: len 1; hex 81; asc  ;;
 11: len 4; hex 60efbd5b; asc `  [;;
 12: SQL NULL;
 13: len 8; hex 8000000000000000; asc         ;;
 14: len 8; hex 8000000000000034; asc        4;;
 15: len 4; hex 80000000; asc     ;;
 16: len 4; hex 00000000; asc     ;;
 17: len 4; hex 80000000; asc     ;;
 18: len 1; hex 80; asc  ;;
 19: SQL NULL;

2021-08-09T00:28:58.629239+08:00 1030694 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 741882721, ACTIVE 0 sec fetching rows
mysql tables in use 3, locked 3
8 lock struct(s), heap size 1136, 3 row lock(s)
MySQL thread id 1030694, OS thread handle 140347589220096, query id 5403399554 172.16.0.53 apph5_user updating
UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID
2021-08-09T00:28:58.629284+08:00 1030694 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 1949 page no 142 n bits 192 index PRIMARY of table `niuniuh5_db`.`table_league_club_member` trx id 741882721 lock_mode X locks rec but not gap
Record lock, heap no 11 PHYSICAL RECORD: n_fields 20; compact format; info bits 0
 0: len 4; hex 00001f1e; asc     ;;
 1: len 6; hex 00002c37c4c1; asc   ,7  ;;
 2: len 7; hex 720001800e103a; asc r     :;;
 3: len 4; hex 800a2a1a; asc   * ;;
 4: len 4; hex 8001e614; asc     ;;
 5: len 6; hex e9b98fe7a88b; asc       ;;
 6: len 0; hex ; asc ;;
 7: len 0; hex ; asc ;;
 8: len 1; hex 83; asc  ;;
 9: len 1; hex 80; asc  ;;
 10: len 1; hex 81; asc  ;;
 11: len 4; hex 60efbd5b; asc `  [;;
 12: SQL NULL;
 13: len 8; hex 8000000000000000; asc         ;;
 14: len 8; hex 8000000000000034; asc        4;;
 15: len 4; hex 80000000; asc     ;;
 16: len 4; hex 00000000; asc     ;;
 17: len 4; hex 80000000; asc     ;;
 18: len 1; hex 80; asc  ;;
 19: SQL NULL;

2021-08-09T00:28:58.629786+08:00 1030694 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1949 page no 84 n bits 1112 index idx_nClubID of table `niuniuh5_db`.`table_league_club_member` trx id 741882721 lock_mode X locks rec but not gap waiting
Record lock, heap no 561 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 800a2a1a; asc   * ;;
 1: len 4; hex 00001f1e; asc     ;;

2021-08-09T00:28:58.629900+08:00 1030694 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)

2021-08-09T00:30:01.537321+08:00 1104732 [Note] Aborted connection 1104732 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
2021-08-09T00:30:01.548667+08:00 1104736 [Note] Aborted connection 1104736 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
2021-08-09T01:00:01.575482+08:00 1104916 [Note] Aborted connection 1104916 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
2021-08-09T01:00:02.063012+08:00 1104918 [Note] Aborted connection 1104918 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
2021-08-09T01:30:01.870647+08:00 1105075 [Note] Aborted connection 1105075 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
2021-08-09T01:30:01.998954+08:00 1105079 [Note] Aborted connection 1105079 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
2021-08-09T02:00:01.623395+08:00 1105248 [Note] Aborted connection 1105248 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
2021-08-09T02:00:01.765955+08:00 1105246 [Note] Aborted connection 1105246 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
2021-08-09T02:30:02.038556+08:00 1105386 [Note] Aborted connection 1105386 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
2021-08-09T02:30:02.488098+08:00 1105388 [Note] Aborted connection 1105388 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
2021-08-09T02:33:22.390093+08:00 1030695 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2021-08-09T02:33:22.390138+08:00 1030695 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 741927186, ACTIVE 0 sec fetching rows
mysql tables in use 3, locked 3
LOCK WAIT 6 lock struct(s), heap size 1136, 4 row lock(s)
MySQL thread id 1030694, OS thread handle 140347589220096, query id 5403785700 172.16.0.53 apph5_user updating
UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID
2021-08-09T02:33:22.390198+08:00 1030695 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1949 page no 140 n bits 176 index PRIMARY of table `niuniuh5_db`.`table_league_club_member` trx id 741927186 lock_mode X locks rec but not gap waiting
Record lock, heap no 77 PHYSICAL RECORD: n_fields 20; compact format; info bits 0
 0: len 4; hex 00001f08; asc     ;;
 1: len 6; hex 00002c38d1c7; asc   ,8  ;;
 2: len 7; hex 28000008441748; asc (   D H;;
 3: len 4; hex 800a2a1a; asc   * ;;
 4: len 4; hex 8001e615; asc     ;;
 5: len 15; hex e4b880e79bb4e8a2abe6a8a1e4bbbf; asc                ;;
 6: len 0; hex ; asc ;;
 7: len 0; hex ; asc ;;
 8: len 1; hex 82; asc  ;;
 9: len 1; hex 80; asc  ;;
 10: len 1; hex 81; asc  ;;
 11: len 4; hex 60efb1e9; asc `   ;;
 12: SQL NULL;
 13: len 8; hex 8000000000000000; asc         ;;
 14: len 8; hex 800000000000002c; asc        ,;;
 15: len 4; hex 80000000; asc     ;;
 16: len 4; hex 00000000; asc     ;;
 17: len 4; hex 80000000; asc     ;;
 18: len 1; hex 80; asc  ;;
 19: SQL NULL;

2021-08-09T02:33:22.390766+08:00 1030695 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 741927187, ACTIVE 0 sec fetching rows
mysql tables in use 3, locked 3
7 lock struct(s), heap size 1136, 3 row lock(s)
MySQL thread id 1030695, OS thread handle 140347590301440, query id 5403785701 172.16.0.53 apph5_user updating
UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID
2021-08-09T02:33:22.390816+08:00 1030695 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 1949 page no 140 n bits 176 index PRIMARY of table `niuniuh5_db`.`table_league_club_member` trx id 741927187 lock_mode X locks rec but not gap
Record lock, heap no 77 PHYSICAL RECORD: n_fields 20; compact format; info bits 0
 0: len 4; hex 00001f08; asc     ;;
 1: len 6; hex 00002c38d1c7; asc   ,8  ;;
 2: len 7; hex 28000008441748; asc (   D H;;
 3: len 4; hex 800a2a1a; asc   * ;;
 4: len 4; hex 8001e615; asc     ;;
 5: len 15; hex e4b880e79bb4e8a2abe6a8a1e4bbbf; asc                ;;
 6: len 0; hex ; asc ;;
 7: len 0; hex ; asc ;;
 8: len 1; hex 82; asc  ;;
 9: len 1; hex 80; asc  ;;
 10: len 1; hex 81; asc  ;;
 11: len 4; hex 60efb1e9; asc `   ;;
 12: SQL NULL;
 13: len 8; hex 8000000000000000; asc         ;;
 14: len 8; hex 800000000000002c; asc        ,;;
 15: len 4; hex 80000000; asc     ;;
 16: len 4; hex 00000000; asc     ;;
 17: len 4; hex 80000000; asc     ;;
 18: len 1; hex 80; asc  ;;
 19: SQL NULL;

2021-08-09T02:33:22.391369+08:00 1030695 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1949 page no 84 n bits 1112 index idx_nClubID of table `niuniuh5_db`.`table_league_club_member` trx id 741927187 lock_mode X locks rec but not gap waiting
Record lock, heap no 557 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 800a2a1a; asc   * ;;
 1: len 4; hex 00001f08; asc     ;;

2021-08-09T02:33:22.391459+08:00 1030695 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)

2021-08-09T03:00:01.593059+08:00 1105538 [Note] Aborted connection 1105538 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
2021-08-09T03:00:01.931094+08:00 1105540 [Note] Aborted connection 1105540 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
2021-08-09T03:30:01.843110+08:00 1105681 [Note] Aborted connection 1105681 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.51' (Got an error reading communication packets)
2021-08-09T03:30:02.232171+08:00 1105685 [Note] Aborted connection 1105685 to db: 'audit_db' user: 'slowMonitor' host: '172.16.0.52' (Got an error reading communication packets)
