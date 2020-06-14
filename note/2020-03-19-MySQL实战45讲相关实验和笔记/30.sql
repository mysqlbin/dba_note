


<<<<<<< HEAD
Session A 的加锁分析如下：
    1. 根据原则 1， 加锁单位是 next-key lock,  因为 id 是唯一索引, 所以加锁范围是： PRIMARY: next-key lock:（10, 15]
    2. 根据一个bug，InnoDB 会往后继续查询下一个不满足条件的行，也就是id=20，并且 由于这个是范围扫描， 所以 id <=15 的加锁范围是 PRIMARY ： next-key lock： (15, 20]
    3. 所以 session A 的加锁范围是 PRIMARY: next-key lock:（10, 15] + PRIMARY: next-key lock： (15, 20]
	
	
=======
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;

insert into t values(0,0,0),(5,5,5),
(10,10,10),(15,15,15),(20,20,20),(25,25,25);


session A                                              session B
begin;
select * from t where id>10 and id<=15 for update;
+----+------+------+
| id | c    | d    |
+----+------+------+
| 15 |   15 |   15 |
+----+------+------+
1 row in set (0.00 sec)

													   delete from t where id=10;
													   (Query OK)
													   insert into t values(10, 10, 10);
													   
													   
show engine innodb status\G;												   
---TRANSACTION 5711902, ACTIVE 3 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 9, OS thread handle 140048483247872, query id 49 env 192.168.1.27 root update
insert into t values(10, 10, 10)
------- TRX HAS BEEN WAITING 3 SEC FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 117 page no 3 n bits 80 index PRIMARY of table `zst`.`t` trx id 5711902 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 5 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000f; asc     ;;
 1: len 6; hex 000000572816; asc    W( ;;
 2: len 7; hex b00000012a0137; asc     * 7;;
 3: len 4; hex 8000000f; asc     ;;
 4: len 4; hex 8000000f; asc     ;;													   
 
 
 
 
 
session A                                              session B
begin;
select * from t where id>10 and id<=15 for update;
+----+------+------+
| id | c    | d    |
+----+------+------+
| 15 |   15 |   15 |
+----+------+------+
1 row in set (0.00 sec)

													   delete from t where id=10;
													   (Query OK)
													   insert into t values(8, 18, 18);
													   (Blocked)
---TRANSACTION 5711921, ACTIVE 17 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
MySQL thread id 18, OS thread handle 140048483247872, query id 86 env 192.168.1.27 root update
insert into t values(8, 18, 18)
------- TRX HAS BEEN WAITING 17 SEC FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 118 page no 3 n bits 80 index PRIMARY of table `zst`.`t` trx id 5711921 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 5 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
 0: len 4; hex 8000000f; asc     ;;
 1: len 6; hex 000000572829; asc    W();;
 2: len 7; hex bd0000011a0137; asc       7;;
 3: len 4; hex 8000000f; asc     ;;
 4: len 4; hex 8000000f; asc     ;;

------------------


session A                                              session B
begin;
select * from t where id>10 and id<=15 for update;
+----+------+------+
| id | c    | d    |
+----+------+------+
| 15 |   15 |   15 |
+----+------+------+
1 row in set (0.00 sec)
													   insert into t values(6, 6, 6);
													   (Query OK)
													   
>>>>>>> 103e9c27eb13aa42198547726c9d21da5946f489
