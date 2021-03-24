*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-03-23 15:14:02 0x7f7bb529f700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 9 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 138971 srv_active, 0 srv_shutdown, 4072107 srv_idle
srv_master_thread log flush and writes: 4210835
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 33898900
OS WAIT ARRAY INFO: signal count 35893678
RW-shared spins 0, rounds 103790477, OS waits 24344835
RW-excl spins 0, rounds 110002650, OS waits 3014248
RW-sx spins 1401130, rounds 38963746, OS waits 1187623
Spin rounds per wait: 103790477.00 RW-shared, 110002650.00 RW-excl, 27.81 RW-sx
------------------------
LATEST DETECTED DEADLOCK
------------------------
2021-03-23 14:59:14 0x7f7bbd5c7700
*** (1) TRANSACTION:
TRANSACTION 4656447873, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 85197, OS thread handle 140169290372864, query id 1026292913 192.168.20.168 netstudy_exer updating
UPDATE T_EXER SET DELAY_REVISE_NUM = DELAY_REVISE_NUM + 1 WHERE ID = 581131110700814337
*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 2168 page no 19989 n bits 80 index PRIMARY of table `netstudy_exer`.`t_exer` trx id 4656447873 lock_mode X locks rec but not gap waiting
Record lock, heap no 10 PHYSICAL RECORD: n_fields 59; compact format; info bits 0
 0: len 8; hex 881097aa8d401001; asc      @  ;;
 1: len 6; hex 0001158bc189; asc       ;;
 2: len 7; hex 3c00011c98207e; asc <     ~;;
 3: len 8; hex 80000000000387df; asc         ;;
 4: len 8; hex 8000000000000008; asc         ;;
 5: len 4; hex 80000001; asc     ;;
 6: len 5; hex 99a8880000; asc      ;;
 7: len 30; hex 38323130e680a7e883bde4bd9ce4b89a37315f323032312d30332d323320; asc 8210            71_2021-03-23 ; (total 43 bytes);
 8: len 1; hex 81; asc  ;;
 9: len 1; hex 80; asc  ;;
 10: SQL NULL;
 11: len 3; hex 303032; asc 002;;
 12: len 8; hex 800000000cc7477a; asc       Gz;;
 13: len 10; hex 74656163686572e4b8a5; asc teacher   ;;
 14: len 1; hex 83; asc  ;;
 15: len 1; hex 81; asc  ;;
 16: len 1; hex 80; asc  ;;
 17: len 5; hex 99a9240000; asc   $  ;;
 18: len 1; hex 81; asc  ;;
 19: len 1; hex 80; asc  ;;
 20: len 4; hex 80000000; asc     ;;
 21: len 4; hex 00000000; asc     ;;
 22: len 4; hex 00000000; asc     ;;
 23: len 4; hex 00000000; asc     ;;
 24: len 4; hex 80001770; asc    p;;
 25: len 4; hex 80000000; asc     ;;
 26: len 4; hex 80000000; asc     ;;
 27: len 4; hex 80000000; asc     ;;
 28: len 4; hex 80000d7f; asc     ;;
 29: len 5; hex 99a92eebe1; asc   .  ;;
 30: SQL NULL;
 31: len 5; hex 99a92eebe2; asc   .  ;;
 32: len 5; hex 99a92eebe2; asc   .  ;;
 33: len 1; hex 80; asc  ;;
 34: len 4; hex 80000000; asc     ;;
 35: len 4; hex 80000000; asc     ;;
 36: len 1; hex 81; asc  ;;
 37: len 1; hex 80; asc  ;;
 38: len 5; hex 99a9240000; asc   $  ;;
 39: len 2; hex 7a6a; asc zj;;
 40: SQL NULL;
 41: len 4; hex 80000001; asc     ;;
 42: len 4; hex 80005dc2; asc   ] ;;
 43: len 1; hex 80; asc  ;;
 44: len 4; hex 800016aa; asc     ;;
 45: len 1; hex 82; asc  ;;
 46: len 4; hex 80000000; asc     ;;
 47: len 1; hex 94; asc  ;;
 48: len 5; hex 99a9240000; asc   $  ;;
 49: len 1; hex 31; asc 1;;
 50: len 1; hex 81; asc  ;;
 51: len 10; hex 38323130e680a7e883bd; asc 8210      ;;
 52: len 4; hex 80007152; asc   qR;;
 53: len 4; hex 80000005; asc     ;;
 54: SQL NULL;
 55: len 1; hex 8a; asc  ;;
 56: len 1; hex 81; asc  ;;
 57: SQL NULL;
 58: len 1; hex 80; asc  ;;

*** (2) TRANSACTION:
TRANSACTION 4656447881, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 85247, OS thread handle 140169434658560, query id 1026292915 192.168.20.233 netstudy_exer updating
UPDATE T_EXER_RANGE SET DELAY_FINISH_NUM = DELAY_FINISH_NUM + 1,totaltime = ifnull(totaltime,0) + 5,AVERAGETIME=FLOOR(totaltime/(FINISH_NUM+DELAY_FINISH_NUM)) WHERE ID = 581131110763728896
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 2168 page no 19989 n bits 80 index PRIMARY of table `netstudy_exer`.`t_exer` trx id 4656447881 lock_mode X locks rec but not gap
Record lock, heap no 10 PHYSICAL RECORD: n_fields 59; compact format; info bits 0
 0: len 8; hex 881097aa8d401001; asc      @  ;;
 1: len 6; hex 0001158bc189; asc       ;;
 2: len 7; hex 3c00011c98207e; asc <     ~;;
 3: len 8; hex 80000000000387df; asc         ;;
 4: len 8; hex 8000000000000008; asc         ;;
 5: len 4; hex 80000001; asc     ;;
 6: len 5; hex 99a8880000; asc      ;;
 7: len 30; hex 38323130e680a7e883bde4bd9ce4b89a37315f323032312d30332d323320; asc 8210            71_2021-03-23 ; (total 43 bytes);
 8: len 1; hex 81; asc  ;;
 9: len 1; hex 80; asc  ;;
 10: SQL NULL;
 11: len 3; hex 303032; asc 002;;
 12: len 8; hex 800000000cc7477a; asc       Gz;;
 13: len 10; hex 74656163686572e4b8a5; asc teacher   ;;
 14: len 1; hex 83; asc  ;;
 15: len 1; hex 81; asc  ;;
 16: len 1; hex 80; asc  ;;
 17: len 5; hex 99a9240000; asc   $  ;;
 18: len 1; hex 81; asc  ;;
 19: len 1; hex 80; asc  ;;
 20: len 4; hex 80000000; asc     ;;
 21: len 4; hex 00000000; asc     ;;
 22: len 4; hex 00000000; asc     ;;
 23: len 4; hex 00000000; asc     ;;
 24: len 4; hex 80001770; asc    p;;
 25: len 4; hex 80000000; asc     ;;
 26: len 4; hex 80000000; asc     ;;
 27: len 4; hex 80000000; asc     ;;
 28: len 4; hex 80000d7f; asc     ;;
 29: len 5; hex 99a92eebe1; asc   .  ;;
 30: SQL NULL;
 31: len 5; hex 99a92eebe2; asc   .  ;;
 32: len 5; hex 99a92eebe2; asc   .  ;;
 33: len 1; hex 80; asc  ;;
 34: len 4; hex 80000000; asc     ;;
 35: len 4; hex 80000000; asc     ;;
 36: len 1; hex 81; asc  ;;
 37: len 1; hex 80; asc  ;;
 38: len 5; hex 99a9240000; asc   $  ;;
 39: len 2; hex 7a6a; asc zj;;
 40: SQL NULL;
 41: len 4; hex 80000001; asc     ;;
 42: len 4; hex 80005dc2; asc   ] ;;
 43: len 1; hex 80; asc  ;;
 44: len 4; hex 800016aa; asc     ;;
 45: len 1; hex 82; asc  ;;
 46: len 4; hex 80000000; asc     ;;
 47: len 1; hex 94; asc  ;;
 48: len 5; hex 99a9240000; asc   $  ;;
 49: len 1; hex 31; asc 1;;
 50: len 1; hex 81; asc  ;;
 51: len 10; hex 38323130e680a7e883bd; asc 8210      ;;
 52: len 4; hex 80007152; asc   qR;;
 53: len 4; hex 80000005; asc     ;;
 54: SQL NULL;
 55: len 1; hex 8a; asc  ;;
 56: len 1; hex 81; asc  ;;
 57: SQL NULL;
 58: len 1; hex 80; asc  ;;

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 2169 page no 11996 n bits 168 index PRIMARY of table `netstudy_exer`.`t_exer_range` trx id 4656447881 lock_mode X locks rec but not gap waiting
Record lock, heap no 98 PHYSICAL RECORD: n_fields 23; compact format; info bits 0
 0: len 8; hex 881097aa91001000; asc         ;;
 1: len 6; hex 0001158bc181; asc       ;;
 2: len 7; hex 3700011c552f12; asc 7   U/ ;;
 3: len 8; hex 881097aa8d401001; asc      @  ;;
 4: len 1; hex 81; asc  ;;
 5: len 6; hex 323331333931; asc 231391;;
 6: len 10; hex 38323130e680a7e883bd; asc 8210      ;;
 7: len 4; hex 80005dc2; asc   ] ;;
 8: len 4; hex 80000000; asc     ;;
 9: len 4; hex 800016a9; asc     ;;
 10: len 4; hex 80000000; asc     ;;
 11: len 4; hex 80000d80; asc     ;;
 12: len 4; hex 80000000; asc     ;;
 13: len 1; hex 80; asc  ;;
 14: len 1; hex 80; asc  ;;
 15: len 4; hex 80000000; asc     ;;
 16: len 8; hex 8000000000000008; asc         ;;
 17: len 1; hex 94; asc  ;;
 18: len 4; hex 8000714d; asc   qM;;
 19: len 4; hex 80000005; asc     ;;
 20: len 8; hex 8000000000000000; asc         ;;
 21: SQL NULL;
 22: SQL NULL;

*** WE ROLL BACK TRANSACTION (2)
------------
TRANSACTIONS
------------
Trx id counter 4656544275
Purge done for trx's n:o < 4656543982 undo n:o < 0 state: running but idle
History list length 22
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421664933185360, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933222752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933878480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933275648, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933295712, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933274736, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933234608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933223664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933220928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933220016, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933218192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933217280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933216368, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933215456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933214544, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933213632, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933208160, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933206336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933219104, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933862976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933404240, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933837440, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933836528, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933548336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933358640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933357728, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933356816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933355904, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933354080, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933353168, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933352256, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933350432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933344048, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933342224, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933341312, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933340400, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933339488, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933337664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933336752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933334928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933332192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933330368, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933329456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933328544, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933325808, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933324896, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933323984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933323072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933321248, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933320336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933319424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933318512, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933316688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933315776, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933314864, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933313952, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933313040, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933312128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933311216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933310304, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933309392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933308480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933307568, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933306656, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933305744, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933304832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933303920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933302096, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933301184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933300272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933299360, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933298448, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933297536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933296624, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933283856, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933281120, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933269264, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933264704, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933262880, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933261968, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933261056, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933260144, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933258320, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933257408, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933256496, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933255584, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933254672, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933253760, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933252848, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933251936, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933251024, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933250112, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933249200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933248288, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933247376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933246464, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933245552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933244640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933243728, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933242816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933241904, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933240992, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933240080, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933239168, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933238256, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933237344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933236432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933235520, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933209984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933212720, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933210896, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933209072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933205424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933204512, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933203600, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933202688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933201776, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933200864, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933199952, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933199040, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933198128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933197216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933196304, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933195392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933194480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933193568, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933192656, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933191744, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933190832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933189920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933189008, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933188096, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933187184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933186272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421664933207248, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
--------
FILE I/O
--------
I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
I/O thread 1 state: waiting for completed aio requests (log thread)
I/O thread 2 state: waiting for completed aio requests (read thread)
I/O thread 3 state: waiting for completed aio requests (read thread)
I/O thread 4 state: waiting for completed aio requests (read thread)
I/O thread 5 state: waiting for completed aio requests (read thread)
I/O thread 6 state: waiting for completed aio requests (read thread)
I/O thread 7 state: waiting for completed aio requests (read thread)
I/O thread 8 state: waiting for completed aio requests (read thread)
I/O thread 9 state: waiting for completed aio requests (read thread)
I/O thread 10 state: waiting for completed aio requests (write thread)
I/O thread 11 state: waiting for completed aio requests (write thread)
I/O thread 12 state: waiting for completed aio requests (write thread)
I/O thread 13 state: waiting for completed aio requests (write thread)
I/O thread 14 state: waiting for completed aio requests (write thread)
I/O thread 15 state: waiting for completed aio requests (write thread)
I/O thread 16 state: waiting for completed aio requests (write thread)
I/O thread 17 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 0, 0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 0
3654860 OS file reads, 9240581 OS file writes, 847991 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1.11 writes/s, 0.56 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 9641, seg size 9643, 19362 merges
merged operations:
 insert 28247, delete mark 160, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2656009, node heap has 250 buffer(s)
Hash table size 2656009, node heap has 617 buffer(s)
Hash table size 2656009, node heap has 1529 buffer(s)
Hash table size 2656009, node heap has 2493 buffer(s)
Hash table size 2656009, node heap has 1382 buffer(s)
Hash table size 2656009, node heap has 1734 buffer(s)
Hash table size 2656009, node heap has 222 buffer(s)
Hash table size 2656009, node heap has 301 buffer(s)
0.00 hash searches/s, 0.00 non-hash searches/s
---
LOG
---
Log sequence number 4474672662501
Log flushed up to   4474672662501
Pages flushed up to 4474672662501
Last checkpoint at  4474672662492
0 pending log flushes, 0 pending chkp writes
212507 log i/o's done, 0.33 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 10994319360
Dictionary memory allocated 2509245
Buffer pool size   655280
Free buffers       4099
Database pages     642653
Old database pages 237148
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 375406, not young 131264410
0.00 youngs/s, 0.00 non-youngs/s
Pages read 3559434, created 5200351, written 8507610
0.00 reads/s, 0.00 creates/s, 0.67 writes/s
No buffer pool page gets since the last printout
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 642653, unzip_LRU len: 0
I/O sum[56]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   163820
Free buffers       1025
Database pages     160655
Old database pages 59284
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 94313, not young 32950198
0.00 youngs/s, 0.00 non-youngs/s
Pages read 894117, created 1298811, written 2141999
0.00 reads/s, 0.00 creates/s, 0.11 writes/s
No buffer pool page gets since the last printout
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 160655, unzip_LRU len: 0
I/O sum[14]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   163820
Free buffers       1025
Database pages     160676
Old database pages 59292
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 93709, not young 33230586
0.00 youngs/s, 0.00 non-youngs/s
Pages read 894171, created 1300415, written 2146781
0.00 reads/s, 0.00 creates/s, 0.56 writes/s
No buffer pool page gets since the last printout
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 160676, unzip_LRU len: 0
I/O sum[14]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   163820
Free buffers       1024
Database pages     160657
Old database pages 59285
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 93105, not young 32681525
0.00 youngs/s, 0.00 non-youngs/s
Pages read 885366, created 1302439, written 2079495
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
No buffer pool page gets since the last printout
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 160657, unzip_LRU len: 0
I/O sum[14]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 3
Buffer pool size   163820
Free buffers       1025
Database pages     160665
Old database pages 59287
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 94279, not young 32402101
0.00 youngs/s, 0.00 non-youngs/s
Pages read 885780, created 1298686, written 2139335
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
No buffer pool page gets since the last printout
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 160665, unzip_LRU len: 0
I/O sum[14]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=14100, Main thread ID=140178710185728, state: sleeping
Number of rows inserted 158643039, updated 34506213, deleted 343499, read 86321689164
0.00 inserts/s, 0.00 updates/s, 0.00 deletes/s, 0.00 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

