

CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


insert into t values(0,0,0),(5,5,5),
(10,10,10),(15,15,15),(20,20,20),(25,25,25);

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


SESSION A                       				SESSION B
begin;									
select * from t where c=5 lock in share mode;
												begin;
												select * from t1 where c2=1 for update;
												(Query OK)
select * from t1 where c2=1 lock in share mode;	
(Blocked)		
												select * from t where c=5 for update;
												ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction

即A等待 B, B在等待A，这种死锁问题被称为 AB-BA死锁。

												

死锁日志:												
2019-07-09T23:26:23.573293+08:00 502 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-07-09T23:26:23.573340+08:00 502 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 421750355371856, ACTIVE 32 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 6 lock struct(s), heap size 1136, 4 row lock(s)
MySQL thread id 501, OS thread handle 140265921578752, query id 644649 192.168.0.54 root Sending data
select * from t1 where c2=1 lock in share mode
2019-07-09T23:26:23.573423+08:00 502 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4308 page no 4 n bits 80 index c2 of table `test_db`.`t1` trx id 421750355371856 lock mode S waiting
Record lock, heap no 6 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 00000001; asc     ;;
 1: len 4; hex 00000001; asc     ;;

2019-07-09T23:26:23.573688+08:00 502 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 7769356, ACTIVE 22 sec starting index read
mysql tables in use 1, locked 1
6 lock struct(s), heap size 1136, 4 row lock(s)
MySQL thread id 502, OS thread handle 140265918383872, query id 644650 192.168.0.54 root Sending data
select * from t where c=5 for update
2019-07-09T23:26:23.573760+08:00 502 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 4308 page no 4 n bits 80 index c2 of table `test_db`.`t1` trx id 7769356 lock_mode X
Record lock, heap no 6 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 00000001; asc     ;;
 1: len 4; hex 00000001; asc     ;;

2019-07-09T23:26:23.573936+08:00 502 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4010 page no 4 n bits 80 index c of table `test_db`.`t` trx id 7769356 lock_mode X waiting
Record lock, heap no 3 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len 4; hex 80000005; asc     ;;
 1: len 4; hex 80000005; asc     ;;

2019-07-09T23:26:23.574216+08:00 502 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)											