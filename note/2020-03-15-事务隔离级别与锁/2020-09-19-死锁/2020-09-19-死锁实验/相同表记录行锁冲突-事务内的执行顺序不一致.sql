
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


insert into t values(0,0,0),(5,5,5),
(10,10,10),(15,15,15),(20,20,20),(25,25,25);


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
update t set d=d+1 where id=5;
								update t set d=d+1 where id=10;
update t set d=d+1 where id=10;
(Blocked)
								update t set d=d+1 where id=5;
								ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction

即A等待 B, B在等待A，这种死锁问题被称为 AB-BA死锁。
分析：
    两个事务都执行了第一条 update语句，更新了一行数据，同时也锁定了该行数据，接着每个事务都尝试去执行第二条update语句，
	却发现该行已经被对方锁定，然后两个事务都等待对方释放锁， 同时又持有对方需要的锁，则陷入死循环。
	
	所以死锁的原因是 会话A和会话B在相互等待对方的锁资源。
	
结论：	
	由于锁是一个个加的，要避免死锁，对同一组资源，要按照尽量相同的顺序访问；
		
								
死锁日志：
2019-07-09T20:29:47.772327+08:00 490 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-07-09T20:29:47.772355+08:00 490 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 7769258, ACTIVE 24 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 489, OS thread handle 140265918383872, query id 644486 192.168.0.54 root updating
update t set d=d+1 where id=10
2019-07-09T20:29:47.772412+08:00 490 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4010 page no 3 n bits 80 index PRIMARY of table `test_db`.`t` trx id 7769258 lock_mode X locks rec but not gap waiting
Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 6; hex 000000768cab; asc    v  ;;
 2: len 7; hex 33000000050921; asc 3     !;;
 3: len 4; hex 8000000a; asc     ;;
 4: len 4; hex 8000000b; asc     ;;

2019-07-09T20:29:47.772783+08:00 490 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 7769259, ACTIVE 16 sec starting index read
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 490, OS thread handle 140265918916352, query id 644487 192.168.0.54 root updating
update t set d=d+1 where id=5
2019-07-09T20:29:47.772834+08:00 490 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 4010 page no 3 n bits 80 index PRIMARY of table `test_db`.`t` trx id 7769259 lock_mode X locks rec but not gap
Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 6; hex 000000768cab; asc    v  ;;
 2: len 7; hex 33000000050921; asc 3     !;;
 3: len 4; hex 8000000a; asc     ;;
 4: len 4; hex 8000000b; asc     ;;

2019-07-09T20:29:47.773141+08:00 490 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4010 page no 3 n bits 80 index PRIMARY of table `test_db`.`t` trx id 7769259 lock_mode X locks rec but not gap waiting
Record lock, heap no 3 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 80000005; asc     ;;
 1: len 6; hex 000000768caa; asc    v  ;;
 2: len 7; hex 32000000041e65; asc 2     e;;
 3: len 4; hex 80000005; asc     ;;
 4: len 4; hex 80000006; asc     ;;

2019-07-09T20:29:47.773393+08:00 490 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)
