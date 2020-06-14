


来源：
 MySQL 实战45讲第40章节


insert 唯一键冲突


session A                      		session B                  					session C
begin;
insert into t values(null, 5, 5);		 
									insert into t values(null, 5, 5);		    insert into t values(null, 5, 5);

rollback;

																				ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction

																		

mysql>  select locked_index,locked_type,blocking_lock_mode,waiting_lock_mode,waiting_query from sys.innodb_lock_waits;
+--------------+-------------+--------------------+-------------------+----------------------------------+
| locked_index | locked_type | blocking_lock_mode | waiting_lock_mode | waiting_query                    |
+--------------+-------------+--------------------+-------------------+----------------------------------+
| c            | RECORD      | X                  | S                 | insert into t values(null, 5, 5) |
+--------------+-------------+--------------------+-------------------+----------------------------------+
1 row in set, 3 warnings (0.02 sec)

mysql>  select locked_index,locked_type,blocking_lock_mode,waiting_lock_mode,waiting_query from sys.innodb_lock_waits;
+--------------+-------------+--------------------+-------------------+----------------------------------+
| locked_index | locked_type | blocking_lock_mode | waiting_lock_mode | waiting_query                    |
+--------------+-------------+--------------------+-------------------+----------------------------------+
| c            | RECORD      | X                  | S                 | insert into t values(null, 5, 5) |
| c            | RECORD      | X                  | S                 | insert into t values(null, 5, 5) |
+--------------+-------------+--------------------+-------------------+----------------------------------+

死锁日志:
2019-08-04T05:16:43.317616+08:00 19 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-08-04T05:16:43.317670+08:00 19 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 8218471, ACTIVE 34 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 18, OS thread handle 140220116989696, query id 142 192.168.0.54 root update
insert into t values(null, 5, 5)
2019-08-04T05:16:43.317745+08:00 19 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4367 page no 4 n bits 80 index c of table `admin_db`.`t` trx id 8218471 lock_mode X insert intention waiting
Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
 0: len 8; hex 73757072656d756d; asc supremum;;

2019-08-04T05:16:43.318013+08:00 19 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 8218473, ACTIVE 9 sec inserting
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 19, OS thread handle 140220116457216, query id 155 192.168.0.54 root update
insert into t values(null, 5, 5)
2019-08-04T05:16:43.318082+08:00 19 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 4367 page no 4 n bits 80 index c of table `admin_db`.`t` trx id 8218473 lock mode S
Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
 0: len 8; hex 73757072656d756d; asc supremum;;

2019-08-04T05:16:43.318210+08:00 19 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4367 page no 4 n bits 80 index c of table `admin_db`.`t` trx id 8218473 lock_mode X insert intention waiting
Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
 0: len 8; hex 73757072656d756d; asc supremum;;

2019-08-04T05:16:43.318339+08:00 19 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)
			
