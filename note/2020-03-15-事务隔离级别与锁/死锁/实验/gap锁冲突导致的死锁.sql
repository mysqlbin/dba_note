

来源：
	MySQL 实战45讲 第20讲
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


insert into t values(0,0,0),(5,5,5),
(10,10,10),(15,15,15),(20,20,20),(25,25,25);


SESSION A                       		SESSION B
begin;									
select * from t where id=7 for update;
										begin;
										select * from t where id=7 for update;
										(Query OK)
										insert into t values(9,9,9);
										(Blocked)
insert into t values(9,9,9);
ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
										
								
session A 执行 select … for update 语句，由于 id=7 这一行并不存在，因此会加上间隙锁 (5,10);
session B 执行 select … for update 语句，同样会加上间隙锁 (5,10)，间隙锁之间不会冲突，因此这个语句可以执行成功；
session B 试图插入一行 (9,9,9)，被 session A 的间隙锁挡住了，只好进入等待；
session A 试图插入一行 (9,9,9)，被 session B 的间隙锁挡住了。
至此，两个 session 进入互相等待状态，形成死锁。
当然，InnoDB 的死锁检测马上就发现了这对死锁关系，让 session A 的 insert 语句报错返回了。

	
死锁日志：

2019-03-13T22:08:26.069114+08:00 9 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-03-13T22:08:26.069134+08:00 9 [Note] InnoDB: 
*** (1) TRANSACTION:

事务ID
TRANSACTION 7081476, ACTIVE 11 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
MySQL thread id 10, OS thread handle 140409465882368, query id 49 localhost root update
insert into t values(9,9,9)
2019-03-13T22:08:26.069159+08:00 9 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1923 page no 3 n bits 80 index PRIMARY of table `sql_db`.`t` trx id 7081476 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 6; hex 0000006c0c3e; asc    l >;;
 2: len 7; hex a900000004012a; asc       *;;
 3: len 4; hex 8000000a; asc     ;;
 4: len 4; hex 8000000a; asc     ;;

2019-03-13T22:08:26.069333+08:00 9 [Note] InnoDB: *** (2) TRANSACTION:

事务ID
TRANSACTION 7081475, ACTIVE 21 sec inserting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s)
MySQL thread id 9, OS thread handle 140409466947328, query id 50 localhost root update
insert into t values(9,9,9)
2019-03-13T22:08:26.069358+08:00 9 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 1923 page no 3 n bits 80 index PRIMARY of table `sql_db`.`t` trx id 7081475 lock_mode X locks gap before rec
Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 6; hex 0000006c0c3e; asc    l >;;
 2: len 7; hex a900000004012a; asc       *;;
 3: len 4; hex 8000000a; asc     ;;
 4: len 4; hex 8000000a; asc     ;;

2019-03-13T22:08:26.069462+08:00 9 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1923 page no 3 n bits 80 index PRIMARY of table `sql_db`.`t` trx id 7081475 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 6; hex 0000006c0c3e; asc    l >;;
 2: len 7; hex a900000004012a; asc       *;;
 3: len 4; hex 8000000a; asc     ;;
 4: len 4; hex 8000000a; asc     ;;

2019-03-13T22:08:26.069574+08:00 9 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)


事务2中：
	WAITING FOR THIS LOCK TO BE GRANTED 对应的SQL语句就是 死锁日志中的SQL语句。
	HOLDS THE LOCK(S) 是已经执行通过的，但是事务没有提交，所以要持有锁。
	
	
	
	