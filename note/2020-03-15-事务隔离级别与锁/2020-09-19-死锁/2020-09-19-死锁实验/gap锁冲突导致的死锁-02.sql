


来源：
  MySQL 优化班

CREATE TABLE `t1` (
  `c1` int(10) unsigned NOT NULL DEFAULT '0',
  `c2` int(10) unsigned NOT NULL DEFAULT '0',
  `c3` int(10) unsigned NOT NULL DEFAULT '0',
  `c4` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`c1`),
  KEY `c2` (`c2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `t1` VALUES ('0', '0', '0', '0');
INSERT INTO `t1` VALUES ('1', '1', '1', '0');
INSERT INTO `t1` VALUES ('3', '3', '3', '0');
INSERT INTO `t1` VALUES ('4', '2', '2', '0');
INSERT INTO `t1` VALUES ('6', '8', '5', '0');
INSERT INTO `t1` VALUES ('7', '6', '6', '10');
INSERT INTO `t1` VALUES ('10', '10', '4', '0');




SESSION A                       		SESSION B
begin;									
delete from t1 where c2=8;
										begin;
										delete from t1 where c2=6;
										(Query OK)
insert into t1 select 12,5,5,15;
(Blocked)
										insert into t1 select 15,9,18,18;
										ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction

死锁分析：	
	1). delete from t1 where c2=8;
	根据原则1，加锁类型是加 next-key lock， 所以加锁的范围是 (6,8]; 
	根据优化2，加锁类型是加 gap lock, 所以加锁的范围是(8,10);
	因此该SQL语句的加锁范围是  (6,8] 和 (8,10)和锁主键 c1=6;
													   
	2). delete from t1 where c2=6;
	根据原则1，加锁类型是加 next-key lock， 所以加锁的范围是 (3,6]; 
	根据优化2，加锁类型是加 gap lock, 所以加锁的范围是(6,8);
	因此该SQL语句的加锁范围是  (3,6] 和 (6,8); 和锁主键 c1=7;

	3). insert into t1 select 12,5,5,15;
	SESSION A c2=5 需要等待 SESSION B c2(3~8)的锁释放；

	4). insert into t1 select 15,9,18,18;
	SESSION B c2=9需要等待 SESSION A c2[6~10)的锁释放；	
	
	至此，两个 session 进入互相等待状态，形成死锁。


死锁日志：
	
2019-07-09T21:05:07.073488+08:00 500 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-07-09T21:05:07.073533+08:00 500 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 7769348, ACTIVE 30 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 5 lock struct(s), heap size 1136, 4 row lock(s), undo log entries 2
MySQL thread id 499, OS thread handle 140265920513792, query id 644640 192.168.0.54 root executing
insert into t1 select 12,5,5,15
2019-07-09T21:05:07.073608+08:00 500 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4308 page no 4 n bits 80 index c2 of table `test_db`.`t1` trx id 7769348 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 9 PHYSICAL RECORD: n_fields 2; compact format; info bits 32
 0: len 4; hex 00000006; asc     ;;
 1: len 4; hex 00000007; asc     ;;

2019-07-09T21:05:07.073828+08:00 500 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 7769349, ACTIVE 16 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 4 row lock(s), undo log entries 2
MySQL thread id 500, OS thread handle 140265921046272, query id 644641 192.168.0.54 root executing
insert into t1 select 15,9,18,18
2019-07-09T21:05:07.073893+08:00 500 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 4308 page no 4 n bits 80 index c2 of table `test_db`.`t1` trx id 7769349 lock_mode X
Record lock, heap no 9 PHYSICAL RECORD: n_fields 2; compact format; info bits 32
 0: len 4; hex 00000006; asc     ;;
 1: len 4; hex 00000007; asc     ;;

2019-07-09T21:05:07.074039+08:00 500 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4308 page no 4 n bits 80 index c2 of table `test_db`.`t1` trx id 7769349 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 8 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 0000000a; asc     ;;
 1: len 4; hex 0000000a; asc     ;;

2019-07-09T21:05:07.074474+08:00 500 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)


通过实验推导出结论

结果分成三部分：
    1. (1) TRANSACTION，是第一个事务的信息；
    2. (2) TRANSACTION，是第二个事务的信息；
    3.  WE ROLL BACK TRANSACTION (2)，是最终的处理结果，表示回滚了第二个事务。
	
第一个事务的信息： 
	事务的SQL语句： insert into t1 select 12,5,5,15; 
	WAITING FOR THIS LOCK TO BE GRANTED：表示的是这个事务在等待的锁信息；
	index c2 of table `test_db`.`t1` :
		表示 在等的是表 t1 的索引 c2 上面的锁；
    locks gap before rec insert intention waiting:
		表示这个语句要加一个意向插入锁（插入动作本身），当前的状态是等待中；等待间隙锁的释放
	
	
	RECORD LOCKS space id ... index c2 of table ... lock_mode X = next-key lock
	
	在等待事务2锁信息的详情：
		Record lock：说明这是一个记录锁
		 n_fields 2; 表示这个记录是两列，也就是 字段c2和主键字段c1
		 0: len 4; hex 00000006; asc ;; 是第1个字段c2，值是十六进制6,也就是6； 
		 1: len 4; hex 00000007; asc ;; 是第2个字段c1, 值是十六进制7,也就是7；
		 
	第一个事务信息就只显示出了等锁的状态，在等待 (c2=6,id=7) 这一行的记录锁。
	 
	既然出现死锁了，就表示这个事务也占有别的锁，但是没有显示出来，可以从第二个事务的信息中推导出来。
	
	
第二个事务的信息：
	
	1. 事务的SQL语句：insert into t1 select 15,9,18,185; 
	2.持有的锁信息(2) HOLDS THE LOCK(S))：
		2) HOLDS THE LOCK(S)：用来显示这个事务持有哪些锁
		index c2 of table `test_db`.`t1` ：表示加锁是在加在表 t1 的索引 c2 上；	
		hex 00000006; 和 hex 00000007; 表示这个事务持有 c2=6 这个记录锁；也就是事务1在等待锁；
		
	3. WAITING FOR THIS LOCK TO BE GRANTED：		
		
		n_fields 2                 ： 表示这个记录是两列，也就是字段 c2 和主键字段 c1;
        0: len 4; hex 00000005; 是第一个字段，也就是字段 c2。值是十六进制 5，也就是 5；
        1: len 4; hex 00000005; 是第二个字段，也就是主键字段 c1。值是十六进制 5，也就是 5；
		
		因此， 事务2的 WAITING FOR THIS LOCK TO BE GRANTED 表示在等 record lock ：(c2=5,c1=5) 。	
		
根据死锁信息分析出的两个事务的加锁规则：
    事务1的insert into t1 select 12,5,5,15  这条语句，持有 c2=5 的记录锁，在等 (c2=6,id=7) 这一行的记录锁。   
    事务2的insert into t1 select 15,9,18,18 这条语句，持有 c2=6 的记录锁，在等 c2=5 的记录锁；
    因此导致了死锁。		
		
		
		
		