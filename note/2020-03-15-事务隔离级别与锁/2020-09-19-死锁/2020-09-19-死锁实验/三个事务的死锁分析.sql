

来源：  
https://mp.weixin.qq.com/s/8nRdTa0ruovAi8juL_H8yQ   两个INSERT发生死锁原因剖析


mysql> select @@tx_isolation;
+----------------+
| @@tx_isolation |
+----------------+
| READ-COMMITTED |
+----------------+
1 row in set, 1 warning (0.00 sec)


drop table  if exists t1;

CREATE TABLE t1 (i INT, PRIMARY KEY (i)) ENGINE = InnoDB;

INSERT INTO t1 values(1);


session A                   session B            session C

begin;
delete from t1 where i=1; 
							begin;
							insert into t1 select 1;
							(Blocked)

												begin;
												insert into t1 select 1;
												(Blocked)

commit;											
												ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction	
													
													
mysql> select locked_index, locked_type, waiting_query, waiting_lock_mode, blocking_lock_mode from sys.INNODB_LOCK_WAITS;
+--------------+-------------+-------------------------+-------------------+--------------------+
| locked_index | locked_type | waiting_query           | waiting_lock_mode | blocking_lock_mode |
+--------------+-------------+-------------------------+-------------------+--------------------+
| PRIMARY      | RECORD      | insert into t1 select 1 | S                 | X                  |
+--------------+-------------+-------------------------+-------------------+--------------------+
1 row in set, 3 warnings (0.00 sec)


mysql> select locked_index, locked_type, waiting_query, waiting_lock_mode, blocking_lock_mode from sys.INNODB_LOCK_WAITS;
+--------------+-------------+-------------------------+-------------------+--------------------+
| locked_index | locked_type | waiting_query           | waiting_lock_mode | blocking_lock_mode |
+--------------+-------------+-------------------------+-------------------+--------------------+
| PRIMARY      | RECORD      | insert into t1 select 1 | S                 | X                  |
| PRIMARY      | RECORD      | insert into t1 select 1 | S                 | X                  |
+--------------+-------------+-------------------------+-------------------+--------------------+
2 rows in set, 3 warnings (0.00 sec)

分析: 
1. insert into t1 select 1; 语句的加锁过程:
   select 1 持有 共享锁也就是S锁;
   
   等到 session A之后 insert into t1 持有record lock|X锁;
   
   


2019-07-10T21:36:25.815847+08:00 35 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-07-10T21:36:25.815994+08:00 35 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 7793313, ACTIVE 6 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
MySQL thread id 36, OS thread handle 140453305321216, query id 111827 192.168.0.54 root executing
insert into t1 select 1
2019-07-10T21:36:25.816153+08:00 35 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4318 page no 3 n bits 72 index PRIMARY of table `archery`.`t1` trx id 7793313 lock_mode X locks rec but not gap waiting
Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 32
 0: len 4; hex 80000001; asc     ;;
 1: len 6; hex 00000076eaa0; asc    v  ;;
 2: len 7; hex 210000000503eb; asc !      ;;

2019-07-10T21:36:25.816321+08:00 35 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 7793314, ACTIVE 3 sec inserting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s)
MySQL thread id 35, OS thread handle 140453698299648, query id 111828 192.168.0.54 root executing
insert into t1 select 1
2019-07-10T21:36:25.816358+08:00 35 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 4318 page no 3 n bits 72 index PRIMARY of table `archery`.`t1` trx id 7793314 lock mode S locks rec but not gap
Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 32
 0: len 4; hex 80000001; asc     ;;
 1: len 6; hex 00000076eaa0; asc    v  ;;
 2: len 7; hex 210000000503eb; asc !      ;;

2019-07-10T21:36:25.816538+08:00 35 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4318 page no 3 n bits 72 index PRIMARY of table `archery`.`t1` trx id 7793314 lock_mode X locks rec but not gap waiting
Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 32
 0: len 4; hex 80000001; asc     ;;
 1: len 6; hex 00000076eaa0; asc    v  ;;
 2: len 7; hex 210000000503eb; asc !      ;;

2019-07-10T21:36:25.816696+08:00 35 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)
