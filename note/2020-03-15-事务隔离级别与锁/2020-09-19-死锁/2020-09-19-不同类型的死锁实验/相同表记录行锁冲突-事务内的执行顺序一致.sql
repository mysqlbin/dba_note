
CREATE TABLE d (i INT, PRIMARY KEY (i)) ENGINE = InnoDB;

INSERT INTO d values(1);


这样不会产生死锁:
SESSION A						SESSION B	
begin; 
								begin;
update t set d=d+1 where id=5;
								update t set d=d+1 where id=5;
								(Blocked)
update t set d=d+1 where id=5;
(因为这里没有被别的事务阻塞)

相同表记录行锁冲突:
SESSION A						SESSION B	
begin; 
								begin;
select * from d where i=1 lock in share mode;
								select * from d where i=1 lock in share mode;
delete from d where i=1;
(Blocked)
								delete from d where i=1;
								ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction

即A等待 B, B在等待A，这种死锁问题被称为 AB-BA死锁。
分析：
    两个事务都执行了第一条 update语句，更新了一行数据，同时也锁定了该行数据，接着每个事务都尝试去执行第二条update语句，
	却发现该行已经被对方锁定，然后两个事务都等待对方释放锁， 同时又持有对方需要的锁，则陷入死循环。
	
	所以死锁的原因是 会话A和会话B在相互等待对方的锁资源。
	
		
								
死锁日志：
2019-07-10T18:18:44.584663+08:00 39 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-07-10T18:18:44.584685+08:00 39 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 7771297, ACTIVE 12 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s)
MySQL thread id 40, OS thread handle 139777072662272, query id 536 192.168.0.54 root updating
delete from d where i=1
2019-07-10T18:18:44.584714+08:00 39 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1903 page no 3 n bits 72 index PRIMARY of table `test_db`.`d` trx id 7771297 lock_mode X locks rec but not gap waiting
Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80000001; asc     ;;
 1: len 6; hex 0000007694a0; asc    v  ;;
 2: len 7; hex fe000000040110; asc        ;;

2019-07-10T18:18:44.584858+08:00 39 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 7771298, ACTIVE 10 sec starting index read
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s)
MySQL thread id 39, OS thread handle 139777161787136, query id 537 192.168.0.54 root updating
delete from d where i=1
2019-07-10T18:18:44.584878+08:00 39 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 1903 page no 3 n bits 72 index PRIMARY of table `test_db`.`d` trx id 7771298 lock mode S locks rec but not gap
Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80000001; asc     ;;
 1: len 6; hex 0000007694a0; asc    v  ;;
 2: len 7; hex fe000000040110; asc        ;;

2019-07-10T18:18:44.584957+08:00 39 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 1903 page no 3 n bits 72 index PRIMARY of table `test_db`.`d` trx id 7771298 lock_mode X locks rec but not gap waiting
Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80000001; asc     ;;
 1: len 6; hex 0000007694a0; asc    v  ;;
 2: len 7; hex fe000000040110; asc        ;;

2019-07-10T18:18:44.585034+08:00 39 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)
