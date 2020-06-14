
能通过例子分析出死锁，掌握50%;
能根据死锁日志模拟生产上造成死锁的事务和SQL顺序，掌握90%;

CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;

insert into t values(0,0,0),(5,5,5),(10,10,10)
			  ,(15,15,15),(20,20,20),(25,25,25);

	死锁中这个事务是(2) TRANSACTION
											  死锁中这个事务是(1) TRANSACTION
begin;
select * from t where id=9 for update;
								        begin;
										select * from t where id=9 for update;
										insert into t values(9,10,9);
										（blocked）
insert into t values(9,11,9);										
ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
检测

root@mysqldb 15:21:  [test_db]> select * from sys.innodb_lock_waits\G;
*************************** 1. row ***************************
                wait_started: 2019-05-19 15:25:10
                    wait_age: 00:00:03
               wait_age_secs: 3
                locked_table: `test_db`.`t`
                locked_index: PRIMARY
                 locked_type: RECORD
              waiting_trx_id: 7334566
         waiting_trx_started: 2019-05-19 15:25:09
             waiting_trx_age: 00:00:04
     waiting_trx_rows_locked: 2
   waiting_trx_rows_modified: 0
                 waiting_pid: 274
               waiting_query: insert into t values(9,9,9)
             waiting_lock_id: 7334566:4010:3:4
           waiting_lock_mode: X,GAP
             blocking_trx_id: 7334565
                blocking_pid: 275
              blocking_query: NULL
            blocking_lock_id: 7334565:4010:3:4
          blocking_lock_mode: X,GAP
        blocking_trx_started: 2019-05-19 15:25:03
            blocking_trx_age: 00:00:10
    blocking_trx_rows_locked: 1
  blocking_trx_rows_modified: 0
     sql_kill_blocking_query: KILL QUERY 275
sql_kill_blocking_connection: KILL 275
1 row in set, 3 warnings (0.00 sec)

ERROR: 
No query specified



2019-05-19T15:25:33.929951+08:00 275 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-05-19T15:25:33.929976+08:00 275 [Note] InnoDB: 

事务1：
*** (1) TRANSACTION:

TRANSACTION 7334566, ACTIVE 24 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
MySQL thread id 274, OS thread handle 140122776782592, query id 6022765 192.168.0.54 root update
insert into t values(9,9,9)
2019-05-19T15:25:33.930091+08:00 275 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4010 page no 3 n bits 80 index PRIMARY of table `test_db`.`t` trx id 7334566 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 6; hex 0000006feaa0; asc    o  ;;
 2: len 7; hex c600000005012a; asc       *;;
 3: len 4; hex 8000000a; asc     ;;
 4: len 4; hex 8000000a; asc     ;;

 
事务2： 
2019-05-19T15:25:33.930271+08:00 275 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 7334565, ACTIVE 30 sec inserting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s)
MySQL thread id 275, OS thread handle 140122774648576, query id 6022773 192.168.0.54 root update
insert into t values(9,9,9)
2019-05-19T15:25:33.930314+08:00 275 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 4010 page no 3 n bits 80 index PRIMARY of table `test_db`.`t` trx id 7334565 lock_mode X locks gap before rec
Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 6; hex 0000006feaa0; asc    o  ;;
 2: len 7; hex c600000005012a; asc       *;;
 3: len 4; hex 8000000a; asc     ;;
 4: len 4; hex 8000000a; asc     ;;

2019-05-19T15:25:33.930456+08:00 275 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4010 page no 3 n bits 80 index PRIMARY of table `test_db`.`t` trx id 7334565 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 6; hex 0000006feaa0; asc    o  ;;
 2: len 7; hex c600000005012a; asc       *;;
 3: len 4; hex 8000000a; asc     ;;
 4: len 4; hex 8000000a; asc     ;;

2019-05-19T15:25:33.930595+08:00 275 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)




