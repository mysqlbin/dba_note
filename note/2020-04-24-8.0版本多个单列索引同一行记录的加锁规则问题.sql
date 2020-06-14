

0. 环境
1. 初始化表结构和数据
2. 事务执行流程
3. 列出 select * from sys.innodb_lock_waits 的信息
4. 列出 show engine innodb status 的信息
5. 死锁日志
6. 我的问题

0. 环境
	MySQL 5.7.22 版本
	RR可重复读事务隔离级别

1. 初始化表结构和数据
	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `t1` int(10) NOT NULL COMMENT '',
	  `t2` int(10) NOT NULL COMMENT '',
	  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
	  `status` int(10) NOT NULL COMMENT '',
	  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_order_no` (`order_no`),
	  KEY `idx_createtime` (`createtime`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';

		
	INSERT INTO `t1` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-23 17:28:45');
	

2. 事务执行流程
	session A                  					session B

	begin; 
	select * from t1 where order_no='123456' for update; 

												begin;
												UPDATE table_third_order SET nStatus = 5 WHERE (`CreateTime` BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE) AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));
												
	update t1 set status=1 where order_no='123456';
												ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
				
3. 列出 select * from sys.innodb_lock_waits 的信息

	mysql> select * from sys.innodb_lock_waits\G;
	*************************** 1. row ***************************
	                wait_started: 2020-04-23 17:55:22
	                    wait_age: 00:00:04
	               wait_age_secs: 4
	                locked_table: `partition_db`.`t1`
	                locked_index: PRIMARY
	                 locked_type: RECORD
	              waiting_trx_id: 276596863
	         waiting_trx_started: 2020-04-23 17:55:22
	             waiting_trx_age: 00:00:04
	     waiting_trx_rows_locked: 2
	   waiting_trx_rows_modified: 0
	                 waiting_pid: 82266
	               waiting_query: select * from t1 where status=0 for update
	             waiting_lock_id: 276596863:2069:3:2
	           waiting_lock_mode: X
	             blocking_trx_id: 276596861
	                blocking_pid: 82265
	              blocking_query: NULL
	            blocking_lock_id: 276596861:2069:3:2
	          blocking_lock_mode: X
	        blocking_trx_started: 2020-04-23 17:55:02
	            blocking_trx_age: 00:00:24
	    blocking_trx_rows_locked: 3
	  blocking_trx_rows_modified: 0
	     sql_kill_blocking_query: KILL QUERY 82265
	sql_kill_blocking_connection: KILL 82265
	1 row in set, 3 warnings (0.00 sec)


4. 列出 show engine innodb status 的信息
	show engine innodb status\G;

	---TRANSACTION 276596863, ACTIVE 14 sec starting index read
	mysql tables in use 1, locked 1
	LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
	MySQL thread id 82266, OS thread handle 139788282091264, query id 1629942 localhost root Sending data
	select * from t1 where status=0 for update
	------- TRX HAS BEEN WAITING 14 SEC FOR THIS LOCK TO BE GRANTED:
	RECORD LOCKS space id 2069 page no 3 n bits 72 index PRIMARY of table `partition_db`.`t1` trx id 276596863 lock_mode X locks rec but not gap waiting
	Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
	 0: len 4; hex 00000001; asc     ;;
	 1: len 6; hex 0000107c887a; asc    | z;;
	 2: len 7; hex b9000001e20110; asc        ;;
	 3: len 4; hex 80000001; asc     ;;
	 4: len 4; hex 80000001; asc     ;;
	 5: len 6; hex 313233343536; asc 123456;;
	 6: len 4; hex 80000000; asc     ;;
	 7: len 4; hex 5ea15fcd; asc ^ _ ;;

	------------------
	---TRANSACTION 276596861, ACTIVE 34 sec
	3 lock struct(s), heap size 1136, 3 row lock(s)
	MySQL thread id 82265, OS thread handle 139788319606528, query id 1629900 localhost root


5. 死锁日志
	2020-04-23T09:56:27.141318Z 82265 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
	2020-04-23T09:56:27.141339Z 82265 [Note] InnoDB: 
	*** (1) TRANSACTION:

	TRANSACTION 276596867, ACTIVE 5 sec starting index read
	mysql tables in use 1, locked 1
	LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
	MySQL thread id 82266, OS thread handle 139788282091264, query id 1629975 localhost root Sending data
	select * from t1 where status=0 for update
	2020-04-23T09:56:27.141384Z 82265 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

	RECORD LOCKS space id 2069 page no 3 n bits 72 index PRIMARY of table `partition_db`.`t1` trx id 276596867 lock_mode X locks rec but not gap waiting
	Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
	 0: len 4; hex 00000001; asc     ;;
	 1: len 6; hex 0000107c887d; asc    | };;
	 2: len 7; hex 3c000001c024e0; asc <    $ ;;
	 3: len 4; hex 80000001; asc     ;;
	 4: len 4; hex 80000001; asc     ;;
	 5: len 6; hex 313233343536; asc 123456;;
	 6: len 4; hex 80000001; asc     ;;
	 7: len 4; hex 5ea15fcd; asc ^ _ ;;

	2020-04-23T09:56:27.141632Z 82265 [Note] InnoDB: *** (2) TRANSACTION:

	TRANSACTION 276596861, ACTIVE 85 sec updating or deleting
	mysql tables in use 1, locked 1
	4 lock struct(s), heap size 1136, 4 row lock(s), undo log entries 1
	MySQL thread id 82265, OS thread handle 139788319606528, query id 1629994 localhost root updating
	update t1 set status=1 where order_no='123456'
	2020-04-23T09:56:27.141661Z 82265 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

	RECORD LOCKS space id 2069 page no 3 n bits 72 index PRIMARY of table `partition_db`.`t1` trx id 276596861 lock_mode X locks rec but not gap
	Record lock, heap no 2 PHYSICAL RECORD: n_fields 8; compact format; info bits 0
	 0: len 4; hex 00000001; asc     ;;
	 1: len 6; hex 0000107c887d; asc    | };;
	 2: len 7; hex 3c000001c024e0; asc <    $ ;;
	 3: len 4; hex 80000001; asc     ;;
	 4: len 4; hex 80000001; asc     ;;
	 5: len 6; hex 313233343536; asc 123456;;
	 6: len 4; hex 80000001; asc     ;;
	 7: len 4; hex 5ea15fcd; asc ^ _ ;;

	2020-04-23T09:56:27.141936Z 82265 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

	RECORD LOCKS space id 2069 page no 5 n bits 72 index idx_status of table `partition_db`.`t1` trx id 276596861 lock_mode X locks rec but not gap waiting
	# 在等待获取事务1持有的行锁： idx_status： record lokc : [0]
	
	Record lock, heap no 2 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
	 0: len 4; hex 80000000; asc     ;;
	 1: len 4; hex 00000001; asc     ;;

	2020-04-23T09:56:27.142020Z 82265 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)



6. 我的问题

	既然加锁是加在索引上，那么 session A 的语句 ‘select * from t1 where order_no='123456' for update;’ 持有的锁岂不是： PARIMARY: record lock： [1]  + idx_order_no： record lock: ['123456'] + idx_status: record lock: [0]
	为什么 session B 可以持有 idx_status: record lock : [0]

	