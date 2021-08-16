

1. 意向锁 
2. 加锁规则		
3. 环境	 

	4.1.1 唯一索引等值查询间隙锁
	4.1.2 主键索引范围锁																								
	4.1.3 优化了唯一索引范围 bug 
	4.2.1 非唯一索引等值锁
	
	
1. 意向锁 
	InnoDB特有，加载在表级别上的锁。
   意向锁是什么： 是加载在数据表B+树结构的根节点， 也就是对整个表加意向锁。
   意向锁的作用： 避免在执行DML时，对表执行DDL操作，导致数据不一致。
   InnoDB存储引擎支持两种意向锁：
	1） 意向共享锁（IS Lock）: 当前事务想要获取一张表中某几行的共享锁
	2） 意向排他锁（IX Lock）: 当前事务想要获得一张表中某几行的排他锁
	由于 InnoDB 存储引擎支持的是行级别的锁， 因此意向锁其实不会阻塞除全表扫描以外的任何请求。
   # 这里可能通过例子来验证。

2. 加锁规则		
	
	参考笔记：《21-加锁规则更新小结.sql》
	
	 
3. 环境	 

	mysql> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.20 sec)

	mysql> select @@transaction_isolation;
	+-------------------------+
	| @@transaction_isolation |
	+-------------------------+
	| REPEATABLE-READ         |
	+-------------------------+
	1 row in set (0.07 sec)

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)


	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;


4.1.1 唯一索引等值查询间隙锁
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;
	insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);


	session A                                       session B                                       session C
	 begin;
	update t set d=d+1 where id=7;
													insert into t values(6,6,6); 
													(Blocked)
																							 T1 
																							 
													insert into t values(4,4,4);
													(Query OK)
													
													insert into t values(8,8,8); 
													(Blocked)
																							update t set d=d+1 where id=10;
																							(Query OK)
																							

	T1
	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 276792809:2081:3:4
	lock_trx_id: 276792809
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `audit_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 2081
	  lock_page: 3
	   lock_rec: 4
	  lock_data: 10
	  
	*************************** 2. row ***************************
		lock_id: 276792807:2081:3:4
	lock_trx_id: 276792807
	  lock_mode: X,GAP
	  lock_type: RECORD
	 lock_table: `audit_db`.`t`
	 lock_index: PRIMARY
	 lock_space: 2081
	  lock_page: 3
	   lock_rec: 4
	  lock_data: 10
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 276792809
	requested_lock_id: 276792809:2081:3:4
	  blocking_trx_id: 276792807
	 blocking_lock_id: 276792807:2081:3:4
	1 row in set, 1 warning (0.00 sec)

	
	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	| PRIMARY      | RECORD      | insert into t values(6,6,6) | X,GAP             | X,GAP              |
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.00 sec)


	
4.1.2 主键索引范围锁
																								
	session A                                  session B                session C                     session D                                                                                                   
	begin;
	select * from t where id>=10 and id<11 for update;

												#insert into t values(8,8,8);
												(Query OK)
												insert into t values(11,11,11);
												(Blocked)
												
																										T1
																		update t set d=d+1 where id=10;
																		(Blocked)
																																																																											update t set d=d+1 where id=15;
																																																																											(Blocked)
																																																																											


	T1
		mysql> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
			lock_id: 276792781:2081:3:5
		lock_trx_id: 276792781
		  lock_mode: X,GAP
		  lock_type: RECORD
		 lock_table: `audit_db`.`t`
		 lock_index: PRIMARY
		 lock_space: 2081
		  lock_page: 3
		   lock_rec: 5
		  lock_data: 15
		*************************** 2. row ***************************
			lock_id: 276792778:2081:3:5
		lock_trx_id: 276792778
		  lock_mode: X
		  lock_type: RECORD
		 lock_table: `audit_db`.`t`
		 lock_index: PRIMARY
		 lock_space: 2081
		  lock_page: 3
		   lock_rec: 5
		  lock_data: 15
		2 rows in set, 1 warning (0.00 sec)

		mysql> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 276792781
		requested_lock_id: 276792781:2081:3:5
		  blocking_trx_id: 276792778
		 blocking_lock_id: 276792778:2081:3:5
		1 row in set, 1 warning (0.00 sec)

		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                  | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		| PRIMARY      | RECORD      | insert into t values(11,11,11) | X,GAP             | X                  |
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.00 sec)

																																																										
4.1.3 唯一索引范围 bug： 

尾点延伸  
	session A                                        session B                                     session B                                                                                                                                                                        
	begin;
	select * from t where id>10 and id<=15 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 15 |   15 |   15 |
	+----+------+------+
	1 row in set (0.00 sec)

													update t set d=d+1 where id=20;
													（Blocked）  
																									T1
	T1																											
		mysql> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
			lock_id: 276792769:2081:3:6
		lock_trx_id: 276792769
		  lock_mode: X
		  lock_type: RECORD
		 lock_table: `audit_db`.`t`
		 lock_index: PRIMARY
		 lock_space: 2081
		  lock_page: 3
		   lock_rec: 6
		  lock_data: 20
		*************************** 2. row ***************************
			lock_id: 276792766:2081:3:6
		lock_trx_id: 276792766
		  lock_mode: X
		  lock_type: RECORD
		 lock_table: `audit_db`.`t`
		 lock_index: PRIMARY
		 lock_space: 2081
		  lock_page: 3
		   lock_rec: 6
		  lock_data: 20
		2 rows in set, 1 warning (0.02 sec)

		mysql> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 276792769
		requested_lock_id: 276792769:2081:3:6
		  blocking_trx_id: 276792766
		 blocking_lock_id: 276792766:2081:3:6
		1 row in set, 1 warning (0.00 sec)

		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                  | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		| PRIMARY      | RECORD      | update t set d=d+1 where id=20 | X                 | X                  |
		+--------------+-------------+--------------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.04 sec)

														

4.2.1 非唯一索引等值锁
         覆盖索引，因为不需要访问主键索引，所以不对主键索引加锁    
	 session A                                        session B                                       session C                             session D
	 begin;
	 select id from t where c=5 lock in share mode;
	 如果查询语句是 select id from t where c=5 lock in share mode; 呢？

															update t set d=d+1 where id=5;
															(Query OK)
																										insert into t values(7,7,7); 
																										(Blocked)
	T1
																																				insert into t values(2,2,2);
																																				(Blocked)

	T2


	T1
		mysql> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
			lock_id: 276792871:2081:4:4
		lock_trx_id: 276792871
		  lock_mode: X,GAP
		  lock_type: RECORD
		 lock_table: `audit_db`.`t`
		 lock_index: c
		 lock_space: 2081
		  lock_page: 4
		   lock_rec: 4
		  lock_data: 10, 10
		*************************** 2. row ***************************
			lock_id: 421269807599696:2081:4:4
		lock_trx_id: 421269807599696
		  lock_mode: S,GAP
		  lock_type: RECORD
		 lock_table: `audit_db`.`t`
		 lock_index: c
		 lock_space: 2081
		  lock_page: 4
		   lock_rec: 4
		  lock_data: 10, 10
		2 rows in set, 1 warning (0.00 sec)


		mysql> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 276792871
		requested_lock_id: 276792871:2081:4:4
		  blocking_trx_id: 421269807599696
		 blocking_lock_id: 421269807599696:2081:4:4
		1 row in set, 1 warning (0.00 sec)



		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+-----------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query               | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+-----------------------------+-------------------+--------------------+
		| c            | RECORD      | insert into t values(7,7,7) | X,GAP             | S,GAP              |
		+--------------+-------------+-----------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.00 sec)


	T2
		mysql> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
			lock_id: 276792874:2081:4:3
		lock_trx_id: 276792874
		  lock_mode: X,GAP
		  lock_type: RECORD
		 lock_table: `audit_db`.`t`
		 lock_index: c
		 lock_space: 2081
		  lock_page: 4
		   lock_rec: 3
		  lock_data: 5, 5
		  
		*************************** 2. row ***************************
			lock_id: 421269807599696:2081:4:3
		lock_trx_id: 421269807599696
		  lock_mode: S
		  lock_type: RECORD
		 lock_table: `audit_db`.`t`
		 lock_index: c
		 lock_space: 2081
		  lock_page: 4
		   lock_rec: 3
		  lock_data: 5, 5
		2 rows in set, 1 warning (0.00 sec)

		mysql> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 276792874
		requested_lock_id: 276792874:2081:4:3
		  blocking_trx_id: 421269807599696
		 blocking_lock_id: 421269807599696:2081:4:3
		1 row in set, 1 warning (0.00 sec)

		mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+-----------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query               | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+-----------------------------+-------------------+--------------------+
		| c            | RECORD      | insert into t values(2,2,2) | X,GAP             | S                  |
		+--------------+-------------+-----------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.00 sec)


	
4.2.2 非唯一索引范围锁：
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  0 |    0 |    0 |
	|  5 |    5 |    5 |
	| 10 |   10 |   10 |
	| 15 |   15 |   15 |
	| 20 |   20 |   20 |
	| 25 |   25 |   25 |
	+----+------+------+
	6 rows in set (0.00 sec)


	mysql> show create table t\G;
	*************************** 1. row ***************************
		   Table: t
	Create Table: CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)
	
	
	实验一
		
		session AA							session BB
		begin;
		update t set d=d+1 where id=15;
		
											begin;
											select * from t where c>=10 and c<11 for update;
											(Query OK)
		
		


	实验二

		session A                     session B							  session C
		  
		begin;
		select * from t where c>=10 and c<11 for update;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		| 10 |   10 |   10 |
		+----+------+------+
		1 row in set (0.00 sec)
										begin;
										update t set d=d+1 where c=15;
										(Blocked)
																				
																			begin;
																			update t set d=d+1 where id=15;
																			Query OK, 1 row affected (0.00 sec)
																			Rows matched: 1  Changed: 1  Warnings: 0

																			select * from t;
																			+----+------+------+
																			| id | c    | d    |
																			+----+------+------+
																			|  0 |    0 |    0 |
																			|  5 |    5 |    5 |
																			| 10 |   10 |   10 |
																			| 15 |   15 |   16 |
																			| 20 |   20 |   20 |
																			| 25 |   25 |   25 |
																			+----+------+------+
																			6 rows in set (0.00 sec)

																			

		commit;
										(
											Blocked
											被session C主键id=15的记录锁住，感觉也是合理的，不然就是脏读了。
											符合：只会对必要的索引加锁这一理论。
											同时还发现1个有趣的现象：
												二级索引的记录被锁住，导致不能回到主键索引进行加锁。
												验证了当对二级索引的记录加锁，先锁二级索引的记录，再锁主键索引的记录。
										)	
																			 commit;
																						
										Query OK, 1 row affected (32.77 sec)
										Rows matched: 1  Changed: 1  Warnings: 0

										root@mysqldb 11:35:  [test_db]> select * from t;
										+----+------+------+
										| id | c    | d    |
										+----+------+------+
										|  0 |    0 |    0 |
										|  5 |    5 |    5 |
										| 10 |   10 |   10 |
										| 15 |   15 |   17 |
										| 20 |   20 |   20 |
										| 25 |   25 |   25 |
										+----+------+------+
										6 rows in set (0.00 


		加锁，当前读(读取最新版本的记录)，实现串行化，保证数据的一致性
		要用动态的观点看锁、分析锁。
	
4.2.5 非唯一索引上等值查询-Gap lock死锁： 

	session A                                                       session B                                      
	begin;
	select id from t where c=10 lock in share mode;
																	update t set d=d+1 where c=10;
																   （Blocked）
	insert into t values(8,8,8);
	（Blocked）
																	 ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction

	2019-08-14T23:40:20.146575+08:00 133 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
	2019-08-14T23:40:20.146692+08:00 133 [Note] InnoDB: 
	*** (1) TRANSACTION:

	TRANSACTION 281474976710744, ACTIVE 7 sec starting index read
	mysql tables in use 1, locked 1
	LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
	MySQL thread id 128, OS thread handle 140220117522176, query id 4048 192.168.0.54 root updating
	update t set d=d+1 where c=10
	2019-08-14T23:40:20.146768+08:00 133 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

	RECORD LOCKS space id 4383 page no 4 n bits 80 index c of table `db1`.`t` trx id 281474976710744 lock_mode X waiting
	Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
	 0: len 4; hex 8000000a; asc     ;;
	 1: len 4; hex 8000000a; asc     ;;

	2019-08-14T23:40:20.146837+08:00 133 [Note] InnoDB: *** (2) TRANSACTION:

	TRANSACTION 281474976710743, ACTIVE 27 sec inserting
	mysql tables in use 1, locked 1
	5 lock struct(s), heap size 1136, 3 row lock(s), undo log entries 1
	MySQL thread id 133, OS thread handle 140220113262336, query id 4049 192.168.0.54 root update
	insert into t values(8,8,8)
	2019-08-14T23:40:20.146859+08:00 133 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

	RECORD LOCKS space id 4383 page no 4 n bits 80 index c of table `db1`.`t` trx id 281474976710743 lock mode S
	Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
	 0: len 4; hex 8000000a; asc     ;;
	 1: len 4; hex 8000000a; asc     ;;

	2019-08-14T23:40:20.146911+08:00 133 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

	RECORD LOCKS space id 4383 page no 4 n bits 80 index c of table `db1`.`t` trx id 281474976710743 lock_mode X locks gap before rec insert intention waiting
	Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0




	 0: len 4; hex 8000000a; asc     ;;
	 1: len 4; hex 8000000a; asc     ;;

	2019-08-14T23:40:20.146972+08:00 133 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (1)


4.2.6 非唯一索引范围查询&order by
非唯一索引范围查询&order by
 
	session A									  session B									
	begin;
	select * from t where c>=15 and c<=20 order
	by c desc lock in share mode; 

												  insert into t values(6,6,6);

	由于是 order by c desc，第一个要定位的是索引 c 上 最右边 的c=20 的行，所以会加上间隙锁 c：gap lock: (20,25) 和 c: next-key lock (15,20]。
	在索引 c 上向左遍历，要扫描到 c=10 才停下来，所以 next-key lock 会加到 (5,10]，这正是阻塞 session B 的 insert 语句的原因。
	在扫描过程中，c=20、c=15、c=10 这三行都存在值，由于是 select *，所以会在主键 id 上加三个行锁。


	session A持有的锁：
	c：gap lock: (20,25) + c: next-key lock (15,20] + c: next-key lock (10,15] + c: next-key lock (5, 10]
	PRIMARY: record lock: [20] + PRIMARY: record lock: [15] + PRIMARY: record lock: [10]
	 

	c:Next-Key Lock:((c=5,id=5) 到 (c=10,id=10)]  + c:Gap Lock:((c=10,id=10) 到 (c=15,id=15))
	PRIMARY: record lock: [10] + PRIMARY: record lock: [30] 即 RIMARY:X Lock:10 + PRIMARY:X Lock:30

			 
	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query               | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	| c            | RECORD      | insert into t values(6,6,6) | X,GAP             | S                  |
	+--------------+-------------+-----------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.05 sec)
												  
	---TRANSACTION 5711946, ACTIVE 5 sec inserting
	mysql tables in use 1, locked 1
	LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s), undo log entries 1
	MySQL thread id 22, OS thread handle 140048616134400, query id 113 env 192.168.1.27 root update
	insert into t values(6,6,6)
	------- TRX HAS BEEN WAITING 5 SEC FOR THIS LOCK TO BE GRANTED:
	RECORD LOCKS space id 119 page no 4 n bits 80 index c of table `zst`.`t` trx id 5711946 lock_mode X locks gap before rec insert intention waiting
	Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
	 0: len 4; hex 8000000a; asc     ;;
	 1: len 4; hex 8000000a; asc     ;;

 
 
																											
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;
insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);

session A                                               session B                                                                                                                                                                       
begin;

select * from t where c>=10 and c<=11 for update;
														update t set d=d+1 where c=15;
														(Blocked)

root@localhost [(none)]>select * from sys.innodb_lock_waits\G;
*************************** 1. row ***************************
                wait_started: 2020-04-21 00:52:25
                    wait_age: 00:00:21
               wait_age_secs: 21
                locked_table: `db1`.`t`
                locked_index: c
                 locked_type: RECORD
              waiting_trx_id: 5892116
         waiting_trx_started: 2020-04-21 00:52:25
             waiting_trx_age: 00:00:21
     waiting_trx_rows_locked: 1
   waiting_trx_rows_modified: 0
                 waiting_pid: 6
               waiting_query: update t set d=d+1 where c=15
             waiting_lock_id: 5892116:227:4:5
           waiting_lock_mode: X
             blocking_trx_id: 5892115
                blocking_pid: 3
              blocking_query: NULL
            blocking_lock_id: 5892115:227:4:5
          blocking_lock_mode: X
        blocking_trx_started: 2020-04-21 00:52:12
            blocking_trx_age: 00:00:34
    blocking_trx_rows_locked: 3
  blocking_trx_rows_modified: 0
     sql_kill_blocking_query: KILL QUERY 3
sql_kill_blocking_connection: KILL 3
1 row in set, 3 warnings (0.06 sec)
