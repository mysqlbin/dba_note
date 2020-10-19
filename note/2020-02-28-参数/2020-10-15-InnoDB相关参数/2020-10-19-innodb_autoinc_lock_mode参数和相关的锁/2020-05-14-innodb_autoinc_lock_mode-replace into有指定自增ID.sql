
0. 本文主要目的
1. 表结构和数据初始化

2. MySQL 5.7.22 
	2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
	2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
	2.3 环境3 --innodb_autoinc_lock_mode=2, 事务隔离级别为RC读已提交
	2.4 环境4 --innodb_autoinc_lock_mode=2, 事务隔离级别为RR可重复读

3. MySQL 8.0.19
	3.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
	3.2 环境2
	
4. 小结

0. 本文主要目的
	在 MySQL 5.7.22 和 MySQL 8.0.18环境下, 使用pt-osc批量迁移数据+通过触发器迁移增量数据在参数 innodb_autoinc_lock_mode=2 下是否会产生死锁
	
1. 表结构和数据初始化
	DROP TABLE IF EXISTS `t`;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	DROP TABLE IF EXISTS `t_new`;
	CREATE TABLE `t_new` (
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
	  while(i<=500000) do
		INSERT INTO t (c,d) values (i,i);
		set i=i+1;
	  end while;
		commit;
	end
	;;
	DELIMITER ;

	call idata();
	
	mysql> select count(*) from t;
	+----------+
	| count(*) |
	+----------+
	|   500000 |
	+----------+
	1 row in set (0.36 sec)

	
 select version();
 show global variables like '%innodb_autoinc_lock_mode%';
 show global variables like '%isolation%';

2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读

	root@mysqldb 11:45:  [(none)]> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)
	root@mysqldb 11:46:  [(none)]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.00 sec)
	root@mysqldb 11:46:  [(none)]> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	| tx_isolation          | REPEATABLE-READ |
	+-----------------------+-----------------+
	2 rows in set (0.00 sec)


	事务1(重建表的语句的批量迁移语句)                  事务2(业务的插入语句)
		
	begin;	                                           
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
																						
													   begin; 
														 
													   INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  
														
													   replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001');  
														
													   ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
													   
		
	死锁日志															
		2020-05-14T18:43:02.673349+08:00 11 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2020-05-14T18:43:02.673395+08:00 11 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 166080764, ACTIVE 10 sec fetching rows
		mysql tables in use 2, locked 2
		LOCK WAIT 1174 lock struct(s), heap size 172240, 501169 row lock(s), undo log entries 500000
		MySQL thread id 12, OS thread handle 139636641322752, query id 1868636 localhost root Sending data
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
		2020-05-14T18:43:02.673442+08:00 11 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 296 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 166080764 lock mode S waiting
		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a121; asc        !;;
		 1: len 6; hex 000009e63101; asc     1 ;;
		 2: len 7; hex f000001f470110; asc     G  ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-14T18:43:02.673632+08:00 11 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 166080769, ACTIVE 7 sec setting auto-inc lock
		mysql tables in use 1, locked 1
		4 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 2
		MySQL thread id 11, OS thread handle 139636641851136, query id 1868638 localhost root update
		replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001')
		2020-05-14T18:43:02.673658+08:00 11 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		RECORD LOCKS space id 296 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 166080769 lock_mode X locks rec but not gap
		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a121; asc        !;;
		 1: len 6; hex 000009e63101; asc     1 ;;
		 2: len 7; hex f000001f470110; asc     G  ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-14T18:43:02.673822+08:00 11 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		TABLE LOCK table `sbtest`.`t_new` trx id 166080769 lock mode AUTO-INC waiting
		2020-05-14T18:43:02.673839+08:00 11 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)

	最新一次实验
	
		begin;	                                           
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
																							
												   begin; 
													 
												   INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  
												   (Query OK)
												   replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001');  
												   (Blocked)
		Query OK, 500000 rows affected (5.04 sec)
		Records: 500000  Duplicates: 0  Warnings: 0										
												   ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
															
		
		2020-05-21T17:42:46.135798+08:00 14 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2020-05-21T17:42:46.135840+08:00 14 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 166084137, ACTIVE 4 sec setting auto-inc lock
		mysql tables in use 1, locked 1
		LOCK WAIT 4 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 2
		MySQL thread id 15, OS thread handle 140194131363584, query id 222 localhost root update
		replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001')
		2020-05-21T17:42:46.135878+08:00 14 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		TABLE LOCK table `sbtest`.`t_new` trx id 166084137 lock mode AUTO-INC waiting
		2020-05-21T17:42:46.135902+08:00 14 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 166084132, ACTIVE 5 sec fetching rows
		mysql tables in use 2, locked 2
		1174 lock struct(s), heap size 172240, 501169 row lock(s), undo log entries 500000
		MySQL thread id 14, OS thread handle 140194130835200, query id 220 localhost root Sending data
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
		2020-05-21T17:42:46.135931+08:00 14 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		TABLE LOCK table `sbtest`.`t_new` trx id 166084132 lock mode AUTO-INC
		2020-05-21T17:42:46.135946+08:00 14 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 296 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 166084132 lock mode S waiting
		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a121; asc        !;;
		 1: len 6; hex 000009e63e29; asc     >);;
		 2: len 7; hex c0000001910110; asc        ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-21T17:42:46.136140+08:00 14 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)

	
2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
	
	mysql> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.00 sec)
	
	mysql> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| READ-COMMITTED        |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	
	mysql> select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+



	事务1(重建表的语句的批量迁移语句)                  事务2(业务的插入语句)
		
	begin;	                                           begin;
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
																							
														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001'); 
															 
														replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001');   
														(Blocked)
	Query OK, 500000 rows affected (5.81 sec)
	Records: 500000  Duplicates: 0  Warnings: 0													
	(Query OK)
														ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
		
	死锁日志		
		2020-05-14T18:47:41.422063+08:00 21 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2020-05-14T18:47:41.422094+08:00 21 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 166080782, ACTIVE 3 sec setting auto-inc lock
		mysql tables in use 1, locked 1
		LOCK WAIT 4 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 2
		MySQL thread id 20, OS thread handle 139636641851136, query id 1868786 localhost root update
		replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001')
		2020-05-14T18:47:41.422132+08:00 21 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		TABLE LOCK table `sbtest`.`t_new` trx id 166080782 lock mode AUTO-INC waiting
		2020-05-14T18:47:41.422155+08:00 21 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 166080777, ACTIVE 4 sec fetching rows
		mysql tables in use 2, locked 2
		1173 lock struct(s), heap size 172240, 500001 row lock(s), undo log entries 500000
		MySQL thread id 21, OS thread handle 139636640794368, query id 1868784 localhost root Sending data
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
		2020-05-14T18:47:41.422198+08:00 21 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		TABLE LOCK table `sbtest`.`t_new` trx id 166080777 lock mode AUTO-INC
		2020-05-14T18:47:41.422212+08:00 21 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 296 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 166080777 lock mode S locks rec but not gap waiting
		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a121; asc        !;;
		 1: len 6; hex 000009e6310e; asc     1 ;;
		 2: len 7; hex f900001f540110; asc     T  ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-14T18:47:41.422373+08:00 21 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)

	最近一次测试的死锁日志
		2020-05-21T16:54:27.687689+08:00 3 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2020-05-21T16:54:27.687728+08:00 3 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 166084117, ACTIVE 4 sec setting auto-inc lock
		mysql tables in use 1, locked 1
		LOCK WAIT 4 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 2
		MySQL thread id 4, OS thread handle 140194130835200, query id 42 localhost root update
		replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001')
		2020-05-21T16:54:27.687791+08:00 3 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		TABLE LOCK table `sbtest`.`t_new` trx id 166084117 lock mode AUTO-INC waiting
		2020-05-21T16:54:27.687816+08:00 3 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 166084112, ACTIVE 6 sec fetching rows
		mysql tables in use 2, locked 2
		1173 lock struct(s), heap size 172240, 500001 row lock(s), undo log entries 500000
		MySQL thread id 3, OS thread handle 140194131363584, query id 40 localhost root Sending data
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
		2020-05-21T16:54:27.687845+08:00 3 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		TABLE LOCK table `sbtest`.`t_new` trx id 166084112 lock mode AUTO-INC
		2020-05-21T16:54:27.687861+08:00 3 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 296 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 166084112 lock mode S locks rec but not gap waiting

		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a121; asc        !;;  7a121 从16进制转换为10进制,得到的值为 500001
		 1: len 6; hex 000009e63e15; asc     > ;;
		 2: len 7; hex b3000002960110; asc        ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-21T16:54:27.688082+08:00 3 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)

		session A               session B 
		TRANSACTION 166084112   TRANSACTION 166084117
		持有的锁: 表t_new`: AUTO-INC

								持有的锁: 表t: primary: record lock: id=500001
								在等待的锁: 表t_new: AUTO-INC

		在等待的锁: 表t: primary: record lock: id=500001



2.3 环境3 --innodb_autoinc_lock_mode=2, 事务隔离级别为RC读已提交

	 select version();
	 show global variables like '%innodb_autoinc_lock_mode%';
	 show global variables like '%isolation%';
 
	root@mysqldb 18:57:  [(none)]>  select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	root@mysqldb 18:57:  [(none)]>  show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 2     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	root@mysqldb 18:57:  [(none)]>  show global variables like '%isolation%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	| tx_isolation          | READ-COMMITTED |
	+-----------------------+----------------+
	2 rows in set (0.00 sec)



	事务1(重建表的语句的批量迁移语句)                  事务2(业务的插入语句)
		
	begin;	                                           begin;
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;


														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  --插入原始表
														
														replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001');  --插入新表	
														
														commit;
														
	(query OK)
																											
	没有遇到死锁.
	
2.4 环境4 --innodb_autoinc_lock_mode=2, 事务隔离级别为RR可重复读

  
	root@mysqldb 18:57:  [(none)]>  select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	root@mysqldb 18:57:  [(none)]>  show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 2     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	root@mysqldb 11:46:  [(none)]> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	| tx_isolation          | REPEATABLE-READ |
	+-----------------------+-----------------+
	2 rows in set (0.00 sec)
 
 
	事务1(重建表的语句的批量迁移语句)                  事务2(业务的插入语句)
		
	begin;	                                           begin;
	
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;


														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  --插入原始表
														
														replace INTO `t_new` (`id`, `c`, `d`) VALUES (500001, '500001', '500001');  --插入新表	
														
														commit;
														
	(query OK)
																											
	没有遇到死锁.
	

3.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交

	show global variables like '%innodb_autoinc_lock_mode%';
	 select version();
	 select @@global.TRANSACTION_isolation;
	 select @@session.TRANSACTION_isolation;
	 
	mysql> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode |  1    |
	+--------------------------+-------+
	1 row in set (0.22 sec)

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.09 sec)

	mysql> select @@global.TRANSACTION_isolation;
	+--------------------------------+
	| @@global.TRANSACTION_isolation |
	+--------------------------------+
	| READ-COMMITTED                 |
	+--------------------------------+
	1 row in set (0.00 sec)

	mysql> select @@session.TRANSACTION_isolation;
	+---------------------------------+
	| @@session.TRANSACTION_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.01 sec)


	begin;	                                            begin;
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;

														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  --插入原始表
														
														replace INTO `t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001');   --插入新表
														commit;
														
	(query OK)
																											
	没有遇到死锁.															
 
			

3.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读	

	mysql> show global variables like '%innodb_autoinc_lock_mode%'

	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.01 sec)

	mysql>  select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.19    |
	+-----------+
	1 row in set (0.00 sec)

	mysql>  select @@global.TRANSACTION_isolation;
	+--------------------------------+
	| @@global.TRANSACTION_isolation |
	+--------------------------------+
	| REPEATABLE-READ                |
	+--------------------------------+
	1 row in set (0.00 sec)

	mysql>  select @@session.TRANSACTION_isolation;
	+---------------------------------+
	| @@session.TRANSACTION_isolation |
	+---------------------------------+
	| REPEATABLE-READ                 |
	+---------------------------------+
	1 row in set (0.00 sec)



	begin;	                                            begin;
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;

														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  --插入原始表
														
														replace INTO `t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001');  --插入新表
															
	INSERT INTO `t` (`c`, `d`) VALUES ('600001', '600001');

	mysql> select * from t order by id desc limit 1;
	+--------+--------+--------+
	| id     | c      | d      |
	+--------+--------+--------+
	| 500002 | 600001 | 600001 |
	+--------+--------+--------+
	1 row in set (0.00 sec)
	
	
3. 小结

	1. 事务回滚, 导致自增ID不是连续的
	
	2. 在 MySQL 5.7.22 和 MySQL 8.0.19环境下, 事务隔离级别为RC, 使用pt-osc批量迁移数据+通过触发器迁移增量数据在参数 innodb_autoinc_lock_mode=2 下是会产生死锁, 不过不是基于自增锁模式的死锁, 而是基于主键行锁模式的死锁
	
	3. 在 MySQL 5.7.22环境下, 事务隔离级别为RC或者RR, 使用pt-osc批量迁移数据+通过触发器迁移增量数据在参数 innodb_autoinc_lock_mode=1 下是会产生死锁, 是基于自增锁模式的死锁
			

4. 相关参考	
		
	https://www.cnblogs.com/JiangLe/p/6362770.html  MySQL innodb_autoinc_lock_mode 详解
	39：自增主键不是连续的原因-自增主键为什么不是连续的？


思考：插入auto_increment字段的值指定ID和不指定ID的区别
	都需要申请自增长锁。
