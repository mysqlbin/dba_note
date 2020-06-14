*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2019-03-22 10:57:12 7fe526f5e700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 12 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 22208647 srv_active, 0 srv_shutdown, 656125 srv_idle
srv_master_thread log flush and writes: 22864770
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 15852711799
OS WAIT ARRAY INFO: signal count 15992978500
Mutex spin waits 1290924856831, rounds 12926707795528, OS waits 8417456138
RW-shared spins 1154435412, rounds 4301642597, OS waits 32417180
RW-excl spins 74320466, rounds 2643249762, OS waits 6727283
Spin rounds per wait: -6948.72 mutex, 3.73 RW-shared, 35.57 RW-excl
------------------------
LATEST DETECTED DEADLOCK
------------------------
2019-03-22 10:40:02 7fe13478f700
*** (1) TRANSACTION:
TRANSACTION 20713557385, ACTIVE 1 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 8 lock struct(s), heap size 1248, 4 row lock(s), undo log entries 2
MySQL thread id 17562047, OS thread handle 0x7fe1352a5700, query id 8422197184 updating
UPDATE user_statistic SET toCollectInterest=toCollectInterest + 0.72  WHERE userId=111
*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 914 page no 29 n bits 1272 index `userId` of table `zkbc`.`user_statistic` trx id 20713557385 lock_mode X locks rec but not gap waiting
Record lock, heap no 622 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 0000006f; asc    o;;
 1: len 4; hex 000add51; asc    Q;;

*** (2) TRANSACTION:
TRANSACTION 20713557378, ACTIVE 1 sec starting index read, thread declared inside InnoDB 4747
mysql tables in use 2, locked 2
4609 lock struct(s), heap size 489912, 263936 row lock(s), undo log entries 46
MySQL thread id 17534578, OS thread handle 0x7fe13478f700, query id 8422197519  Sending data
UPDATE user_statistic us JOIN (SELECT IFNULL(SUM(ip.plannedTermInterest),0) AS plannedTermInterest,ip.investorId AS investorId  FROM investor_phase ip WHERE ip.`status` = 1 AND ip.isReceived = 0  AND ip.loanId = 79541 AND ip.investorId = 111) b ON b.investorId = us.userId SET us.toCollectInterest = us.toCollectInterest - b.plannedTermInterest
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 914 page no 29 n bits 1272 index `userId` of table `zkbc`.`user_statistic` trx id 20713557378 lock mode S locks rec but not gap
Record lock, heap no 456 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 000028cf; asc   ( ;;
 1: len 4; hex 00000209; asc     ;;

Record lock, heap no 622 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 0000006f; asc    o;;
 1: len 4; hex 000add51; asc    Q;;

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 914 page no 29 n bits 1272 index `userId` of table `zkbc`.`user_statistic` trx id 20713557378 lock_mode X locks rec but not gap waiting
Record lock, heap no 622 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 0000006f; asc    o;;
 1: len 4; hex 000add51; asc    Q;;

*** WE ROLL BACK TRANSACTION (1)








下面是我分析模拟这个死锁的SQL执行顺序:	
  session A(事务2)	                                  															session B(事务1)
						
  begin;
																												
  select * from toCollectInterest where userId=111 lock in share mode;																										
																												UPDATE user_statistic SET toCollectInterest=toCollectInterest + 0.72  WHERE userId=111;
																												(Blocked)
UPDATE user_statistic us JOIN (SELECT IFNULL(SUM(ip.plannedTermInterest),0) AS plannedTermInterest, \
ip.investorId AS investorId  FROM investor_phase ip \
WHERE ip.`status` = 1 AND ip.isReceived = 0  AND ip.loanId = 79541 AND ip.investorId = 111) \
b ON b.investorId = us.userId \
SET us.toCollectInterest = us.toCollectInterest - b.plannedTermInterest;

(Blocked)
	


模拟出来了: 
2019-03-22 16:20:31 7f4338201700
*** (1) TRANSACTION:
TRANSACTION 9905794398, ACTIVE 2 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 2 lock struct(s), heap size 1184, 1 row lock(s)
MySQL thread id 135, OS thread handle 0x7f4338282700, query id 6755 localhost root updating
UPDATE user_statistic SET toCollectInterest=toCollectInterest + 0.72  WHERE userId=111
*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 914 page no 29 n bits 1272 index `userId` of table `zkbc`.`user_statistic` trx id 9905794398 lock_mode X locks rec but not gap waiting
*** (2) TRANSACTION:
TRANSACTION 9905794397, ACTIVE 33 sec starting index read
mysql tables in use 2, locked 2
10 lock struct(s), heap size 2936, 31 row lock(s)
MySQL thread id 134, OS thread handle 0x7f4338201700, query id 6756 localhost root statistics
UPDATE user_statistic us JOIN (SELECT IFNULL(SUM(ip.plannedTermInterest),0) AS plannedTermInterest, 
ip.investorId AS investorId  FROM investor_phase ip 
WHERE ip.`status` = 1 AND ip.isReceived = 0  AND ip.loanId = 79541 AND ip.investorId = 111) 
b ON b.investorId = us.userId 
SET us.toCollectInterest = us.toCollectInterest - b.plannedTermInterest
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 914 page no 29 n bits 1272 index `userId` of table `zkbc`.`user_statistic` trx id 9905794397 lock mode S locks rec but not gap
*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 914 page no 29 n bits 1272 index `userId` of table `zkbc`.`user_statistic` trx id 9905794397 lock_mode X locks rec but not gap waiting
*** WE ROLL BACK TRANSACTION (1)


A729-李舟平-北京 16:24:43
就是这这里稍有些不同
LOCK WAIT 2 lock struct(s), heap size 1184, 1 row lock(s)
Bin 16:25:10
你不是在生产环境模拟的吗
A729-李舟平-北京 16:25:20
不是
Bin 16:25:31
不是就对了，
16:27:08
你撤回了一条消息
Bin 16:27:29
你模拟死锁所在的环境跟生产的环境不一样，那数据也就不一样了。row lock 的数量也就不一样了。


A729-李舟平-北京 16:29:03
这里等待的是 userid  列吗
Bin 16:29:14
是的
			

小结:
	A-B, B-A 类型的死锁。	

	