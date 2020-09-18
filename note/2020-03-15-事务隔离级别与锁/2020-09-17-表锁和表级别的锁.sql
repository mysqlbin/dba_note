
	
1. 表锁和表级锁
2. 表结构和数据的初始化
3. 表锁
4. 隔离级别RR下的表级锁
5. 隔离级别RC下的表级锁	
6. 相关参考

1. 表锁和表级锁
	表锁: lock table t write/read; 
		通过表锁锁表.
		
	表级锁(表级别的锁): 
	
		MDL锁、自增锁、意向锁、锁住全表的记录(使用全表的Next-Key Lock来锁住整个表的记录)
		
		
	表锁(lock tables)

		只有正确通过索引条件检索数据（没有索引失效的情况），InnoDB才会使用行级锁，否则InnoDB对表中的所有记录加锁，也就是将锁住整个表.

		这里说的是锁住整个表，但是InnoDB并不是使用表锁来锁住表的，而是使用了下面介绍的Next-Key Lock来锁住整个表。
		
		发生在RR隔离级别下的表级锁, 其它事务可以快照读, 不可以当前读或者说插入数据.
	
	
2. 表结构和数据的初始化

	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	DROP PROCEDURE IF EXISTS `idata`;
	DELIMITER ;;
	CREATE DEFINER=`root`@`%` PROCEDURE `idata`()
	begin
	  declare i int;
	  set i=1;
		start transaction;
	  while(i<=5) do
		INSERT INTO t (c,d) values (i,i);
		set i=i+1;
	  end while;
		commit;
	end
	;;
	DELIMITER ;
		
		
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (0.00 sec)


	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)

3. 表锁

	mysql> lock tables t write;
	Query OK, 0 rows affected (0.00 sec)

	mysql> show engine innodb status\G;
		------------
		TRANSACTIONS
		------------
		...........................................
		---TRANSACTION 421692776193488, not started
		mysql tables in use 1, locked 1    -- 通过表锁锁表.
		0 lock struct(s), heap size 1136, 0 row lock(s)

--------------------------------------
	
4. 隔离级别RR下的表级锁
	
	SELECT * FROM t for update;;
	
	SESSION A
	
	mysql> begin;
	Query OK, 0 rows affected (0.00 sec)
		
	mysql> SELECT * FROM t where d=5 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  5 |    5 |    5 |
	+----+------+------+
	1 row in set (0.00 sec)

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE | LOCK_STATUS | LOCK_DATA              |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	| 140217799482832:1070:140217730271480   |                  3360 |        68 | t           | NULL       | TABLE     | IX        | GRANTED     | NULL                   |
	| 140217799482832:13:4:1:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X         | GRANTED     | supremum pseudo-record |
	| 140217799482832:13:4:2:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 1                      |
	| 140217799482832:13:4:3:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 2                      |
	| 140217799482832:13:4:4:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 3                      |
	| 140217799482832:13:4:5:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 4                      |
	| 140217799482832:13:4:6:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X         | GRANTED     | 5                      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+-----------+-------------+------------------------+
	7 rows in set (0.00 sec)
	
		
	supremum pseudo-record：它是索引中的伪记录(pseudo-record)，代表此索引中可能存在的最大值
	
	锁住了(-∞,1],(1,2],(2,3],(3,4],(4,5],(5,∞].
	
	show engine innodb status\G;
		...........................................
		---TRANSACTION 3360, ACTIVE 2 sec
		2 lock struct(s), heap size 1136, 6 row lock(s)             --表示锁住了6行.
		MySQL thread id 17, OS thread handle 140214981314304, query id 120 localhost root
		TABLE LOCK table `zst`.`t` trx id 3360 lock mode IX
		RECORD LOCKS space id 13 page no 4 n bits 80 index PRIMARY of table `zst`.`t` trx id 3360 lock_mode X
		Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000000001; asc         ;;
		 1: len 6; hex 000000000915; asc       ;;
		 2: len 7; hex 81000001050110; asc        ;;
		 3: len 4; hex 80000001; asc     ;;
		 4: len 4; hex 80000001; asc     ;;

		Record lock, heap no 3 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000000002; asc         ;;
		 1: len 6; hex 000000000918; asc       ;;
		 2: len 7; hex 81000001060110; asc        ;;
		 3: len 4; hex 80000002; asc     ;;
		 4: len 4; hex 80000002; asc     ;;

		Record lock, heap no 4 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000000003; asc         ;;
		 1: len 6; hex 00000000091f; asc       ;;
		 2: len 7; hex 81000001080110; asc        ;;
		 3: len 4; hex 80000003; asc     ;;
		 4: len 4; hex 80000003; asc     ;;

		Record lock, heap no 5 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000000004; asc         ;;
		 1: len 6; hex 000000000921; asc      !;;
		 2: len 7; hex 820000010c0110; asc        ;;
		 3: len 4; hex 80000004; asc     ;;
		 4: len 4; hex 80000004; asc     ;;

		Record lock, heap no 6 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000000005; asc         ;;
		 1: len 6; hex 000000000923; asc      #;;
		 2: len 7; hex 81000001090110; asc        ;;
		 3: len 4; hex 80000005; asc     ;;
		 4: len 4; hex 80000005; asc     ;; ;;
	
									session B;
									
									mysql> INSERT INTO `zst`.`t` (`c`, `d`) VALUES ('6', '6');
									(Blocked)
									
									mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
									+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
									| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE          | LOCK_STATUS | LOCK_DATA              |
									+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
									| 140217799484576:1070:140217730283464   |                  3361 |        70 | t           | NULL       | TABLE     | IX                 | GRANTED     | NULL                   |
									| 140217799484576:13:4:1:140217730280424 |                  3361 |        70 | t           | PRIMARY    | RECORD    | X,INSERT_INTENTION | WAITING     | supremum pseudo-record |
									| 140217799482832:1070:140217730271480   |                  3360 |        68 | t           | NULL       | TABLE     | IX                 | GRANTED     | NULL                   |
									| 140217799482832:13:4:1:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X                  | GRANTED     | supremum pseudo-record |
									| 140217799482832:13:4:2:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X                  | GRANTED     | 1                      |
									| 140217799482832:13:4:3:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X                  | GRANTED     | 2                      |
									| 140217799482832:13:4:4:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X                  | GRANTED     | 3                      |
									| 140217799482832:13:4:5:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X                  | GRANTED     | 4                      |
									| 140217799482832:13:4:6:140217730268552 |                  3360 |        68 | t           | PRIMARY    | RECORD    | X                  | GRANTED     | 5                      |
									+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
										9 rows in set (0.00 sec)

---------------------------------------------------------------------------------------------------------------------



5. 隔离级别RC下的表级锁	
	mysql> set global transaction isolation level READ COMMITTED;
	Query OK, 0 rows affected (0.75 sec)


	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 17:52:  [zst]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)
	
	SESSION A
	begin;
	SELECT * FROM t where d=5 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (0.00 sec)
	
	mysql> show engine innodb status\G;	
	---TRANSACTION 3362, ACTIVE 6 sec
	2 lock struct(s), heap size 1136, 1 row lock(s)
	MySQL thread id 24, OS thread handle 140214634800896, query id 182 localhost root
	TABLE LOCK table `zst`.`t` trx id 3362 lock mode IX
	RECORD LOCKS space id 13 page no 4 n bits 80 index PRIMARY of table `zst`.`t` trx id 3362 lock_mode X locks rec but not gap
	Record lock, heap no 6 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
	 0: len 8; hex 8000000000000005; asc         ;;
	 1: len 6; hex 000000000923; asc      #;;
	 2: len 7; hex 81000001090110; asc        ;;
	 3: len 4; hex 80000005; asc     ;;
	 4: len 4; hex 80000005; asc     ;;
	 
 

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140217799482832:1070:140217730271480   |                  3362 |        75 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140217799482832:13:4:6:140217730268552 |                  3362 |        75 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 5         |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	2 rows in set (0.00 sec)

									session B;
																		
									mysql>  INSERT INTO `zst`.`t` (`c`, `d`) VALUES ('6', '6');
									Query OK, 1 row affected (0.08 sec)
	
	
6. 相关参考
	https://mp.weixin.qq.com/s/KL-xVv8asA78bH9bVQLwPw  MySQL锁都分不清，怎么面试进大厂？
			
	