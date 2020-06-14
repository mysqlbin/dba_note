mysql> show engine innodb status\G
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2018-09-04 22:29:05 0x7fb26db37700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 60 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 1754177 srv_active, 0 srv_shutdown, 453394 srv_idle
srv_master_thread log flush and writes: 2207553
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 512543899
OS WAIT ARRAY INFO: signal count 273332635
RW-shared spins 0, rounds 105069402, OS waits 44179823
RW-excl spins 0, rounds 211740885, OS waits 4481068
RW-sx spins 3901936, rounds 34815575, OS waits 728778
Spin rounds per wait: 105069402.00 RW-shared, 211740885.00 RW-excl, 8.92 RW-sx
------------------------
LATEST DETECTED DEADLOCK
------------------------
2018-08-16 16:00:34 0x7fb258399700
*** (1) TRANSACTION:
TRANSACTION 1089798546, ACTIVE 9 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 169418, OS thread handle 140404006233856, query id 82348347 132.77.52.17 wysapp update
INSERT INTO xxxxxx (id,indate,rema) VALUES ( '000000000xxx','2018-08-16 16:00:23.675',null )
*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 2756 page no 396 n bits 208 index PRIMARY of table `xxh`.`tb4` trx id 1089798546 lock_mode X locks rec but not gap waiting
Record lock, heap no 136 PHYSICAL RECORD: n_fields 5; compact format; info bits 32
 0: len 16; hex 32303138303831363031333834303233; asc 2018081601384023;;
 1: len 6; hex 000040f4efc5; asc   @   ;;
 2: len 7; hex 3b0000028808cd; asc ;      ;;
 3: len 5; hex 99a0a0fefb; asc      ;;
 4: SQL NULL;

*** (2) TRANSACTION:
TRANSACTION 1089796484, ACTIVE 19 sec inserting, thread declared inside InnoDB 1
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 170319, OS thread handle 140403961075456, query id 82345728 132.77.52.17 wysapp update
INSERT INTO tb3 (id,date,mark) VALUES ( '201999990xxx4023','2018-08-16 16:00:13.646',null )
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 2756 page no 396 n bits 208 index PRIMARY of table `d61`.`tb2` trx id 1089796484 lock mode S locks rec but not gap
Record lock, heap no 136 PHYSICAL RECORD: n_fields 5; compact format; info bits 32
 0: len 16; hex 32303138303831363031333834303233; asc 2018081601384023;;
 1: len 6; hex 000040f4efc5; asc   @   ;;
 2: len 7; hex 3b0000028808cd; asc ;      ;;
 3: len 5; hex 99a0a0fefb; asc      ;;
 4: SQL NULL;

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 2756 page no 396 n bits 208 index PRIMARY of table `d52`.`tbb` trx id 1089796484 lock_mode X locks rec but not gap waiting
Record lock, heap no 136 PHYSICAL RECORD: n_fields 5; compact format; info bits 32
 0: len 16; hex 32303138303831363031333834303233; asc 2018081601384023;;
 1: len 6; hex 000040f4efc5; asc   @   ;;
 2: len 7; hex 3b0000028808cd; asc ;      ;;
 3: len 5; hex 99a0a0fefb; asc      ;;
 4: SQL NULL;

*** WE ROLL BACK TRANSACTION (2)
------------
TRANSACTIONS
------------
Trx id counter 1373744612
Purge done for trx's n:o < 1373744612 undo n:o < 0 state: running but idle
History list length 46
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421936999780176, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999699920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999804800, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000062896, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000042832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000025504, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999750992, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000021856, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000017296, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000008176, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999995408, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999981728, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999993584, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999955280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999734576, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999813008, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999740048, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999953456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999885968, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999738224, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999937040, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999932480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999929744, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999927008, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999906944, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999893264, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999842192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999838544, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999809360, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999801152, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999794768, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999793856, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999672560, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999753728, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999718160, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999698096, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999816656, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999813920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999812096, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999810272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999774704, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999705392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999700832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999791120, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999775616, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999684416, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999748256, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999673472, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999782912, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999770144, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999768320, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999731840, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999663440, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999678032, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000061072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000054688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000053776, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000051040, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000050128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000049216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000046480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000045568, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000038272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000037360, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000035536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000034624, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999946160, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999943424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999919712, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999917888, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999864992, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999844016, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999841280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999834896, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999668912, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000031888, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000027328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000023680, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000013648, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000010912, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000006352, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999999056, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999737312, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999782000, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999968960, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999966224, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999958016, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999814832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999945248, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999944336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999941600, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999931568, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999924272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999890528, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999730928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999799328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999706304, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999885056, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999783824, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999759200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999807536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999788384, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999761936, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999918800, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999732752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999833984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999818480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999727280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999726368, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999711776, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999907856, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999921536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999901472, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999693536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999875936, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999874112, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999871376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999685328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999858608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999857696, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999833072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999808448, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999682592, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000000880, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999994496, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999986288, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999980816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999975344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999970784, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999967136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999960752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999928832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999927920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999925184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999926096, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999902384, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999899648, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999892352, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999884144, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999881408, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999872288, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999870464, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999866816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999855872, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999849488, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999821216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999811184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999802064, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999798416, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999796592, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999792032, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999771968, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999766496, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999764672, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999760112, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999758288, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999757376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999755552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999741872, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999736400, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999674384, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999710864, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999707216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999704480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999680768, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999676208, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000215200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000211552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000203344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000196048, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000189664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000188752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000187840, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000186928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000186016, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000172336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000170512, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000168688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000161392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000157744, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000155920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000153184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000152272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000149536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000147712, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000142240, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000134944, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000128560, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000124000, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000118528, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000114880, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000112144, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000094816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000088432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000080224, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000077488, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000072928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000069280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000055600, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000041008, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000032800, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000029152, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000019120, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000018208, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000011824, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000007264, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000003616, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999987200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999964400, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999963488, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999962576, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999947072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999934304, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999897824, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999883232, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999868640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999854960, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999854048, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999852224, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999832160, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999802976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999694448, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999691712, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000223408, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000213376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000200608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000196960, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000183280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000181456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000175984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000156832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000120352, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000106672, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000071104, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000022768, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999976256, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999965312, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999961664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999940688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999920624, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999840368, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999754640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999708128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999786560, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999785648, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999740960, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999752816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999745520, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999717248, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999703568, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999701744, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999696272, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999689888, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000197872, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000195136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000171424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000148624, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000130384, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000090256, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000074752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000061984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999985376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999916976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999880496, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999843104, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999831248, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999820304, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999815744, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999719984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999795680, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999751904, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999719072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999667088, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000058336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000057424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000048304, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000036448, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000030064, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000028240, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000024592, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000020032, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000004528, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999999968, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999977168, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999947984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999896912, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999826688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999697184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999781088, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999721808, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999772880, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999771056, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999761024, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999747344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999915152, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999886880, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999746432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999715424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999905120, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000016384, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000005440, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000002704, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000001792, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999989936, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999911504, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999906032, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999824864, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999875024, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999848576, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999739136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999983552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999982640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999974432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999973520, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999972608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999969872, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999959840, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999862256, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999762848, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999728192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999683504, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999860432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999822128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999690800, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999668000, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000191488, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000174160, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000100288, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000093904, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000067456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000015472, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999713600, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999800240, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999773792, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999744608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999664352, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000150448, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000144976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000102112, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000101200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000098464, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999825776, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999688976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999765584, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999692624, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000091168, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000089344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999952544, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999910592, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999847664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000010000, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999767408, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999665264, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999769232, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000141328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000139504, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000138592, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000137680, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999971696, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999913328, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000043744, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000026416, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999896000, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999742784, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000020944, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999990848, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999819392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999942512, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999898736, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999678944, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999968048, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999787472, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999876848, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999671648, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999675296, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999851312, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000056512, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999869552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999873200, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999867728, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999861344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999725456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999828512, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999730016, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000092080, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999984464, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000097552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000096640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000033712, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999998144, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999882320, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999817568, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999805712, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999709952, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999679856, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999806624, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999723632, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999778352, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999777440, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999948896, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999904208, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999709040, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999756464, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999792944, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999923360, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999839456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000160480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999749168, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999978080, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999666176, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999879584, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999877760, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999856784, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999845840, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999830336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000059248, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999681680, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999835808, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999900560, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999878672, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999865904, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999837632, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999686240, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999903296, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000060160, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000047392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999933392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999729104, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999699008, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000079312, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000065632, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000075664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999950720, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000044656, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999846752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999844928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999909680, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999687152, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999669824, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999670736, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999722720, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999733664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999958928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999702656, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999863168, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999784736, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000014560, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999951632, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000012736, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000009088, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999991760, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999989024, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999829424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999827600, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999779264, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999823040, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999803888, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999716336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999720896, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999914240, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999922448, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999850400, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999930656, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999823952, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999916064, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999908768, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999853136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999949808, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999936128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999912416, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999937952, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999935216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999677120, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999891440, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999889616, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999888704, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999797504, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999763760, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999836720, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999750080, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999790208, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999789296, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999743696, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999776528, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999735488, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999724544, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999712688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999695360, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999688064, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000041920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000040096, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000039184, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000030976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999996320, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999988112, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999979904, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999957104, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999956192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999954368, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999939776, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999938864, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999895088, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999859520, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000113968, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000113056, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000109408, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000108496, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000105760, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000103936, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000092992, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000085696, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000081136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000073840, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000070192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421937000052864, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999992672, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999978992, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999894176, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999887792, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999864080, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421936999714512, not started
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
252125124 OS file reads, 776352651 OS file writes, 145248644 OS fsyncs
123.73 reads/s, 16384 avg bytes/read, 191.91 writes/s, 47.25 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 49228, free list len 1025705, seg size 1074934, 205606103 merges
merged operations:
 insert 777138260, delete mark 2020, delete 1865
discarded operations:
 insert 20182, delete mark 0, delete 0
Hash table size 13279583, node heap has 944 buffer(s)
Hash table size 13279583, node heap has 2068 buffer(s)
Hash table size 13279583, node heap has 1742 buffer(s)
Hash table size 13279583, node heap has 2180 buffer(s)
Hash table size 13279583, node heap has 1056 buffer(s)
Hash table size 13279583, node heap has 584 buffer(s)
Hash table size 13279583, node heap has 830 buffer(s)
Hash table size 13279583, node heap has 3831 buffer(s)
10421.93 hash searches/s, 868.60 non-hash searches/s
---
LOG
---
Log sequence number 2173720786389
Log flushed up to   2173720741786
Pages flushed up to 2172220586718
Last checkpoint at  2172220586718
0 pending log flushes, 0 pending chkp writes
179265347 log i/o's done, 20.23 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 87954554880
Dictionary memory allocated 19501383
Buffer pool size   5242480
Free buffers       7765
Database pages     5221480
Old database pages 1927546
Modified db pages  1143064
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 202840513, not young 582594710
0.10 youngs/s, 1.47 non-youngs/s
Pages read 252108306, created 25284091, written 567538177
123.73 reads/s, 2.45 creates/s, 160.70 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 5221480, unzip_LRU len: 0
I/O sum[62472]:cur[0], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   655310
Free buffers       994
Database pages     652662
Old database pages 240922
Modified db pages  152239
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 25384512, not young 75526114
0.02 youngs/s, 0.20 non-youngs/s
Pages read 31563399, created 3160120, written 71778719
15.58 reads/s, 0.00 creates/s, 20.18 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 652662, unzip_LRU len: 0
I/O sum[7809]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   655310
Free buffers       962
Database pages     652710
Old database pages 240959
Modified db pages  141823
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 25393588, not young 74353975
0.05 youngs/s, 0.10 non-youngs/s
Pages read 31640493, created 3158913, written 70865625
15.32 reads/s, 0.05 creates/s, 20.07 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 652710, unzip_LRU len: 0
I/O sum[7809]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 2
Buffer pool size   655310
Free buffers       972
Database pages     652678
Old database pages 240942
Modified db pages  141154
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 25325591, not young 68228386
0.00 youngs/s, 0.60 non-youngs/s
Pages read 31523195, created 3168876, written 70629803
15.45 reads/s, 0.02 creates/s, 20.07 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 652678, unzip_LRU len: 0
I/O sum[7809]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 3
Buffer pool size   655310
Free buffers       1006
Database pages     652641
Old database pages 240907
Modified db pages  142126
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 25225984, not young 72583404
0.02 youngs/s, 0.07 non-youngs/s
Pages read 31460170, created 3161829, written 71058134
14.68 reads/s, 0.03 creates/s, 20.07 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 652641, unzip_LRU len: 0
I/O sum[7809]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 4
Buffer pool size   655310
Free buffers       972
Database pages     652682
Old database pages 240944
Modified db pages  141019
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 25349655, not young 80281098
0.00 youngs/s, 0.25 non-youngs/s
Pages read 31568558, created 3147484, written 70791454
14.03 reads/s, 1.00 creates/s, 20.08 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 652682, unzip_LRU len: 0
I/O sum[7809]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 5
Buffer pool size   655310
Free buffers       939
Database pages     652720
Old database pages 240965
Modified db pages  142101
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 25315134, not young 75758805
0.00 youngs/s, 0.10 non-youngs/s
Pages read 31254588, created 3167856, written 70622455
17.52 reads/s, 1.03 creates/s, 20.07 writes/s
Buffer pool hit rate 997 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 652720, unzip_LRU len: 0
I/O sum[7809]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 6
Buffer pool size   655310
Free buffers       966
Database pages     652699
Old database pages 240954
Modified db pages  141991
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 25493114, not young 69914594
0.02 youngs/s, 0.13 non-youngs/s
Pages read 31323563, created 3164409, written 70951281
15.92 reads/s, 0.28 creates/s, 20.05 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 652699, unzip_LRU len: 0
I/O sum[7809]:cur[0], unzip sum[0]:cur[0]
---BUFFER POOL 7
Buffer pool size   655310
Free buffers       954
Database pages     652688
Old database pages 240953
Modified db pages  140611
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 25352935, not young 65948334
0.00 youngs/s, 0.02 non-youngs/s
Pages read 31774340, created 3154604, written 70840706
15.23 reads/s, 0.03 creates/s, 20.12 writes/s
Buffer pool hit rate 998 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 652688, unzip_LRU len: 0
I/O sum[7809]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=20480, Main thread ID=140405799601920, state: sleeping
Number of rows inserted 6327260860, updated 223776983, deleted 768905, read 959433556870
4.47 inserts/s, 16.78 updates/s, 0.00 deletes/s, 107702.54 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.00 sec)