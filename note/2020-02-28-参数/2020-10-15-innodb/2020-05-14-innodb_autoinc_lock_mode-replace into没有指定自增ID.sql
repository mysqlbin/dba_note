
0. 本文主要目的
1. 表结构和数据初始化

2. MySQL 5.7.22 
	2.0 
	2.1 环境1
	2.2 环境2
	2.3 环境3

3. MySQL 8.0.18
	3.1 环境1
	3.2 环境2
	
4. 小结


0. 本文主要目的
	在 MySQL 5.7.22 和 MySQL 8.0.18环境下, 使用pt-osc批量迁移数据+通过触发器迁移增量数据在参数 innodb_autoinc_lock_mode=2 下是否会产生死锁
	
1.1 表结构和数据初始化
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


2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读	root@mysqldb 11:45:  [(none)]> select version();
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
		
	begin;	                                           begin;
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
																						
													   begin; 
														 
														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  --插入原始表
														
														replace INTO `t_new` (`c`, `d`) VALUES ('500001', '500001');  --插入新表	
														
														ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
		
	死锁日志															
		2020-05-14T04:08:45.393981Z 934 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2020-05-14T04:08:45.394016Z 934 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 164449087, ACTIVE 3 sec setting auto-inc lock
		mysql tables in use 1, locked 1
		LOCK WAIT 3 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
		MySQL thread id 940, OS thread handle 140607304681216, query id 9521493 localhost root update
		replace INTO `t_new` (`c`, `d`) VALUES ('500001', '500001')
		2020-05-14T04:08:45.394053Z 934 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		TABLE LOCK table `sbtest`.`t_new` trx id 164449087 lock mode AUTO-INC waiting
		2020-05-14T04:08:45.394074Z 934 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 164449082, ACTIVE 4 sec fetching rows
		mysql tables in use 2, locked 2
		1174 lock struct(s), heap size 172240, 501169 row lock(s), undo log entries 500000
		MySQL thread id 934, OS thread handle 140607307851520, query id 9521491 localhost root Sending data
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
		2020-05-14T04:08:45.394103Z 934 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		TABLE LOCK table `sbtest`.`t_new` trx id 164449082 lock mode AUTO-INC
		2020-05-14T04:08:45.394118Z 934 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 272 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 164449082 lock mode S waiting
		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a123; asc        #;;
		 1: len 6; hex 000009cd4b3f; asc     K?;;
		 2: len 7; hex a8000001e40110; asc        ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-14T04:08:45.394313Z 934 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)


2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
	root@mysqldb 11:46:  [(none)]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.00 sec)
	
	root@mysqldb 12:13:  [sbtest]> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| READ-COMMITTED        |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	root@mysqldb 12:14:  [sbtest]> 
	root@mysqldb 12:14:  [sbtest]> select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+



	事务1(重建表的语句的批量迁移语句)                  事务2(业务的插入语句)
		
	begin;	                                           begin;
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
																						
													   begin; 
														 
														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  --插入原始表
														
														replace INTO `t_new` (`c`, `d`) VALUES ('500001', '500001');  --插入新表	
														
														ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
		

	死锁日志		
		2020-05-14T12:16:15.664842+08:00 954 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2020-05-14T12:16:15.664875+08:00 954 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 164449097, ACTIVE 2 sec setting auto-inc lock
		mysql tables in use 1, locked 1
		LOCK WAIT 3 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
		MySQL thread id 953, OS thread handle 140607566239488, query id 9521565 localhost root update
		replace INTO `t_new` (`c`, `d`) VALUES ('500001', '500001')
		2020-05-14T12:16:15.664919+08:00 954 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		TABLE LOCK table `sbtest`.`t_new` trx id 164449097 lock mode AUTO-INC waiting
		2020-05-14T12:16:15.664938+08:00 954 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 164449092, ACTIVE 3 sec fetching rows
		mysql tables in use 2, locked 2
		1173 lock struct(s), heap size 172240, 500001 row lock(s), undo log entries 500000
		MySQL thread id 954, OS thread handle 140607309436672, query id 9521563 localhost root Sending data
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
		2020-05-14T12:16:15.664961+08:00 954 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		TABLE LOCK table `sbtest`.`t_new` trx id 164449092 lock mode AUTO-INC
		2020-05-14T12:16:15.664984+08:00 954 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 272 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 164449092 lock mode S locks rec but not gap waiting
		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a124; asc        $;;
		 1: len 6; hex 000009cd4b49; asc     KI;;
		 2: len 7; hex ae000001ca0110; asc        ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-14T12:16:15.665143+08:00 954 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)



2.3 环境3 --innodb_autoinc_lock_mode=2, 事务隔离级别为RC读已提交
	root@mysqldb 11:46:  [(none)]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 2     |
	+--------------------------+-------+
	1 row in set (0.00 sec)
	
	root@mysqldb 12:13:  [sbtest]> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| READ-COMMITTED        |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)
	
	root@mysqldb 12:14:  [sbtest]> select @@session.tx_isolation;
	+------------------------+
	| @@session.tx_isolation |
	+------------------------+
	| READ-COMMITTED         |
	+------------------------+
	
	事务1(重建表的语句的批量迁移语句)                  事务2(业务的插入语句)
		
	begin;	                                           begin;
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
	

														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  --插入原始表
														
														replace INTO `t_new` (`c`, `d`) VALUES ('500001', '500001');  --插入新表	
														
														ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
														
	死锁日志													
		2020-05-14T19:07:11.608920+08:00 10 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2020-05-14T19:07:11.608957+08:00 10 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 166081929, ACTIVE 3 sec inserting
		mysql tables in use 1, locked 1
		LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
		MySQL thread id 11, OS thread handle 140348182972160, query id 1500463 localhost root update
		replace INTO `t_new` (`c`, `d`) VALUES ('500001', '500001')
		2020-05-14T19:07:11.609005+08:00 10 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 273 page no 1301 n bits 168 index PRIMARY of table `sbtest`.`t_new` trx id 166081929 lock_mode X locks rec but not gap waiting
		Record lock, heap no 97 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000055c26; asc       \&;;
		 1: len 6; hex 000009e63584; asc     5 ;;
		 2: len 7; hex dc000011381add; asc     8  ;;
		 3: len 4; hex 80055c26; asc   \&;;
		 4: len 4; hex 80055c26; asc   \&;;

		2020-05-14T19:07:11.609206+08:00 10 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 166081924, ACTIVE 5 sec fetching rows
		mysql tables in use 2, locked 2
		1173 lock struct(s), heap size 172240, 500002 row lock(s), undo log entries 500000
		MySQL thread id 10, OS thread handle 140348183500544, query id 1500461 localhost root Sending data
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
		2020-05-14T19:07:11.609235+08:00 10 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		RECORD LOCKS space id 273 page no 1301 n bits 168 index PRIMARY of table `sbtest`.`t_new` trx id 166081924 lock_mode X locks rec but not gap
		Record lock, heap no 97 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000055c26; asc       \&;;
		 1: len 6; hex 000009e63584; asc     5 ;;
		 2: len 7; hex dc000011381add; asc     8  ;;
		 3: len 4; hex 80055c26; asc   \&;;
		 4: len 4; hex 80055c26; asc   \&;;

		2020-05-14T19:07:11.609420+08:00 10 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 296 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 166081924 lock mode S locks rec but not gap waiting
		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a121; asc        !;;
		 1: len 6; hex 000009e63589; asc     5 ;;
		 2: len 7; hex df000002c40110; asc        ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-14T19:07:11.609617+08:00 10 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)
	
	
2.4 环境4 --innodb_autoinc_lock_mode=2, 事务隔离级别为RR可重复读
	root@mysqldb 19:10:  [sbtest]>  select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	root@mysqldb 19:10:  [sbtest]>  show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 2     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	root@mysqldb 19:10:  [sbtest]>  show global variables like '%isolation%';
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
														
														replace INTO `t_new` (`c`, `d`) VALUES ('500001', '500001');  --插入新表	
														ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
	死锁日志												
		2020-05-14T19:12:41.320421+08:00 17 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
		2020-05-14T19:12:41.320457+08:00 17 [Note] InnoDB: 
		*** (1) TRANSACTION:

		TRANSACTION 166081962, ACTIVE 4 sec inserting
		mysql tables in use 1, locked 1
		LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
		MySQL thread id 16, OS thread handle 140348182972160, query id 1500697 localhost root update
		replace INTO `t_new` (`c`, `d`) VALUES ('500001', '500001')
		2020-05-14T19:12:41.320494+08:00 17 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 273 page no 1281 n bits 72 index PRIMARY of table `sbtest`.`t_new` trx id 166081962 lock_mode X waiting
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000053a57; asc       :W;;
		 1: len 6; hex 000009e635a5; asc     5 ;;
		 2: len 7; hex f2000015ae154c; asc       L;;
		 3: len 4; hex 80053a57; asc   :W;;
		 4: len 4; hex 80053a57; asc   :W;;

		2020-05-14T19:12:41.320685+08:00 17 [Note] InnoDB: *** (2) TRANSACTION:

		TRANSACTION 166081957, ACTIVE 5 sec fetching rows
		mysql tables in use 2, locked 2
		1174 lock struct(s), heap size 172240, 501170 row lock(s), undo log entries 500000
		MySQL thread id 17, OS thread handle 140348183500544, query id 1500695 localhost root Sending data
		INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE
		2020-05-14T19:12:41.320713+08:00 17 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

		RECORD LOCKS space id 273 page no 1281 n bits 72 index PRIMARY of table `sbtest`.`t_new` trx id 166081957 lock_mode X locks rec but not gap
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 8000000000053a57; asc       :W;;
		 1: len 6; hex 000009e635a5; asc     5 ;;
		 2: len 7; hex f2000015ae154c; asc       L;;
		 3: len 4; hex 80053a57; asc   :W;;
		 4: len 4; hex 80053a57; asc   :W;;

		2020-05-14T19:12:41.320863+08:00 17 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

		RECORD LOCKS space id 296 page no 1840 n bits 384 index PRIMARY of table `sbtest`.`t` trx id 166081957 lock mode S waiting
		Record lock, heap no 312 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
		 0: len 8; hex 800000000007a121; asc        !;;
		 1: len 6; hex 000009e635aa; asc     5 ;;
		 2: len 7; hex f5000002e00110; asc        ;;
		 3: len 4; hex 8007a121; asc    !;;
		 4: len 4; hex 8007a121; asc    !;;

		2020-05-14T19:12:41.321028+08:00 17 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)

														
------------------------------ 以上都经过了测试.


2.1 环境1
	
	root@mysqldb 14:37:  [db3]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode |  1    |
	+--------------------------+-------+
	1 row in set (0.22 sec)

	root@mysqldb 14:20:  [db3]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.09 sec)

	root@mysqldb 14:20:  [db3]> select @@global.TRANSACTION_isolation;
	+--------------------------------+
	| @@global.TRANSACTION_isolation |
	+--------------------------------+
	| READ-COMMITTED                 |
	+--------------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 14:21:  [db3]> select @@session.TRANSACTION_isolation;
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
															
 	
			

2.2 环境2
	
	root@mysqldb 14:37:  [db3]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 2     |
	+--------------------------+-------+
	1 row in set (0.22 sec)

	root@mysqldb 14:20:  [db3]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.09 sec)

	root@mysqldb 14:20:  [db3]> select @@global.TRANSACTION_isolation;
	+--------------------------------+
	| @@global.TRANSACTION_isolation |
	+--------------------------------+
	| READ-COMMITTED                 |
	+--------------------------------+
	1 row in set (0.00 sec)

	root@mysqldb 14:21:  [db3]> select @@session.TRANSACTION_isolation;
	+---------------------------------+
	| @@session.TRANSACTION_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.01 sec)


	begin;	                                            begin;
	INSERT LOW_PRIORITY IGNORE INTO `t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;

														INSERT INTO `t` (`c`, `d`) VALUES ('500001', '500001');  --插入原始表
														
														replace INTO `t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001');  --插入新表
															
	INSERT INTO `t` (`c`, `d`) VALUES ('600001', '600001');

	root@mysqldb 14:55:  [db3]> select * from t order by id desc limit 1;
	+--------+--------+--------+
	| id     | c      | d      |
	+--------+--------+--------+
	| 500002 | 600001 | 600001 |
	+--------+--------+--------+
	1 row in set (0.00 sec)
	
	
4. 小结
	1. 事务回滚, 导致自增ID不是连续的
	2. 在 MySQL 5.7.22 和 MySQL 8.0.18环境下, 事务隔离级别为RC, 使用pt-osc批量迁移数据+通过触发器迁移增量数据在参数 innodb_autoinc_lock_mode=2 下是会产生死锁, 不过不是基于自增锁模式的死锁, 而是基于主键行锁模式的死锁
	3. 在 MySQL 5.7.22 环境下, 事务隔离级别为RC或者RR, 使用pt-osc批量迁移数据+通过触发器迁移增量数据在参数 innodb_autoinc_lock_mode=1 下是会产生死锁, 是基于自增锁模式的死锁
			
https://www.cnblogs.com/JiangLe/p/6362770.html  MySQL innodb_autoinc_lock_mode 详解

39：自增主键不是连续的原因-自增主键为什么不是连续的？




