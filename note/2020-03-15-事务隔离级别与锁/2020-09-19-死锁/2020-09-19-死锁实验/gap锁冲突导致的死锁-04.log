


来源：
	MySQL 实战45讲 第21章节

CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;
insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);

session A                                       session B                                      
begin;
select id from t where c=10 lock in share mode;
												update t set d=d+1 where c=10;
												（Blocked）
insert into t values(8,8,8);
（Blocked）
												ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
												
												
												

root@mysqldb 07:39:  [test_Db]> select * from sys.innodb_lock_waits\G;
*************************** 1. row ***************************
                wait_started: 2019-05-20 07:39:44
                    wait_age: 00:00:02
               wait_age_secs: 2
                locked_table: `test_db`.`t`
                locked_index: c
                 locked_type: RECORD
              waiting_trx_id: 7334702
         waiting_trx_started: 2019-05-20 07:39:44
             waiting_trx_age: 00:00:02
     waiting_trx_rows_locked: 1
   waiting_trx_rows_modified: 0
                 waiting_pid: 293
               waiting_query: update t set d=d+1 where c=10
             waiting_lock_id: 7334702:4010:4:4
           waiting_lock_mode: X
             blocking_trx_id: 7334701
                blocking_pid: 295
              blocking_query: NULL
            blocking_lock_id: 7334701:4010:4:4
          blocking_lock_mode: S
        blocking_trx_started: 2019-05-20 07:39:35
            blocking_trx_age: 00:00:11
    blocking_trx_rows_locked: 2
  blocking_trx_rows_modified: 0
     sql_kill_blocking_query: KILL QUERY 295
sql_kill_blocking_connection: KILL 295
1 row in set, 3 warnings (0.00 sec)


2019-05-20T07:39:56.179550+08:00 295 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-05-20T07:39:56.179588+08:00 295 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 7334702, ACTIVE 12 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 293, OS thread handle 140122775181056, query id 6024089 192.168.0.54 root updating
update t set d=d+1 where c=10

2019-05-20T07:39:56.179646+08:00 295 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 4010 page no 4 n bits 80 index c of table `test_db`.`t` trx id 7334702 lock_mode X waiting
Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 4; hex 8000000a; asc     ;;

 ----------------------------------------------------------------------------------------------------------------
2019-05-20T07:39:56.179866+08:00 295 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 7334701, ACTIVE 21 sec inserting
mysql tables in use 1, locked 1
5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 1
MySQL thread id 295, OS thread handle 140122776250112, query id 6024102 192.168.0.54 root update

insert into t values(8,8,8)

2019-05-20T07:39:56.179922+08:00 295 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 4010 page no 4 n bits 80 index c of table `test_db`.`t` trx id 7334701 lock mode S
Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 4; hex 8000000a; asc     ;;

2019-05-20T07:39:56.180041+08:00 295 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4010 page no 4 n bits 80 index c of table `test_db`.`t` trx id 7334701 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 8000000a; asc     ;;
 1: len 4; hex 8000000a; asc     ;;

2019-05-20T07:39:56.180165+08:00 295 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)

------------------------------------------------------------------------------------------------------------------------------

分析开始：
这个结果分成三部分：
 (1) TRANSACTION，是第一个事务的信息；
 (2) TRANSACTION，是第二个事务的信息；
 WE ROLL BACK TRANSACTION (1)，是最终的处理结果，表示回滚了第一个事务。
通过事务ID可以看到事务执行的先后顺序：	
(1) TRANSACTION 的事务ID为 7334702 比(2) TRANSACTION 的事务ID为 7334701大。 说明 (2) TRANSACTION 先启动。

在什么索引上加锁：
RECORD LOCKS space id 4010 page no 4 n bits 80 index c of table `test_db`.`t` trx id 7334702 lock_mode X waiting
RECORD LOCKS space id 4010 page no 4 n bits 80 index c of table `test_db`.`t` trx id 7334701 lock mode S
RECORD LOCKS space id 4010 page no 4 n bits 80 index c of table `test_db`.`t` trx id 7334701 lock_mode X locks gap before rec insert intention waiting
说明这个死锁出现在 c 索引上。


1. 事务 1， 这个事务后执行，对应的事务ID为 7334566， 在等待获取 PRIMARY 的锁：
WAITING FOR THIS LOCK TO BE GRANTED，表示的是这个事务在等待的锁信息；说明被锁住。

index c of table `test_db`.`t`  	表示在等待索引c上面的锁
trx id 7334702 lock_mode X waiting  表示这个语句自己要加一个record lock 记录锁，当前的状态是等待中。

事务1的SQL: 
update t set d=d+1 where c=10
(blocked)
show engine innodb status 是查看不到完整的事务的sql 的，通常显示当前正在等待锁的sql。

2. 事务2 对应的事务ID为7334701， 说明这个事务先执行；   
事务2 的SQL:  insert into t values(8,8,8); 表示事务2在执行的sql； 

HOLDS THE LOCK(S)： 持有的锁
index c of table `test_db`.`t` trx id 7334701 lock mode S
说明事务2 持有 c索引上的 lock mode S 共享锁 
对应的SQL:　select id from t where c=10 lock in share mode;

-------------------------------------------------------------------------------------
假设不知道对应的SQL, 其实我们也可以模拟出来， 根据在什么索引上加锁， 锁的模式、属性来分析来进行模拟
在什么索引上加锁：
index c of table `test_db`.`t` ：说明是在 c索引上加锁；
锁的模式： lock mode S           (读锁: 显示的 lock in share mode)
锁的属性： 

模拟出来对应的SQL:　select * from t where c=10 lock in share mode;; 

-------------------------------------------------------------------------------------

(2) WAITING FOR THIS LOCK TO BE GRANTED:  这里的SQL不用模拟，因为死锁日志 通常显示当前正在等待锁的sql。
index c of table `test_db`.`t` trx id 7334701 lock_mode X locks gap before rec insert intention waiting
Record lock,
index c of table `test_db`.`t`：         说明在等的是表 t 的c索引 上面的锁；
lock_mode X locks gap before rec insert intention waiting： 表示这个语句要自己加一个意向插入锁，当前的状态是等待中；

对应的SQL: insert into t values(8,8,8)




