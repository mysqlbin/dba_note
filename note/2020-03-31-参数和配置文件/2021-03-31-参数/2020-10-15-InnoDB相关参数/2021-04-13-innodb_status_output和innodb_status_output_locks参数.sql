
大纲
1. 参数简介
2. InnoDB的四种监控类型
3. 实践环境和初始化数据
4. 实践1
5. 实践2
6. 实践3
7. 相关参考
8. 小结



1. 参数简介
	innodb_status_output:

		表示启用或禁用标准InnoDB Monitor(show engine innodb status命令的信息)的定期输出到错误日志中
		默认为关闭状态
		set global innodb_status_output=ON; 
		https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output


	innodb_status_output_locks
		
		启用或禁用标准InnoDB lock Monitor的定期输出到错误日志中
		在执行 show engine innodb status 命令得到的结果中，加入锁等待信息。
		
		默认为关闭状态
		set global innodb_status_output_locks=ON;
		https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output_locks
		
		
	可以动态修改 innodb_status_output、innodb_status_output_locks 两个参数的值打印相关信息，或者直接查看INFORMATION_SCHEMA下的相关表。
		
	
2. InnoDB的四种监控类型

    包括StandardMonitor、LockMonitor、TablespaceMonitor、TableMonitor，其中后面两类监控在5.7版本中被移除，移除后通过information_schema的表获取。
	Standard Monitor监视活动事务持有的表锁、行锁，事务锁等待，线程信号量等待，文件IO请求，buffer pool统计信息，InnoDB主线程purge和change buffer merge活动；
	
	Lock Monitor提供额外的锁信息。
	   
	InnoDB的monitor只在需要的时候开启，它会造成性能开销，观察结束后切记关闭监控。

    StandardMonitor 开启关闭方法如下：
		innodb_status_output参数就是用来控制InnoDB的monitor开启或关闭的。
		这种开启方法会将监控结果输出到数据目录下的MySQL错误日志中，每隔15秒产生一次输出，这也就是发现错误日志下产生大量输出的原因。

    	set GLOBAL innodb_status_output=ON/OFF;   


3. 实践环境和初始化数据
	
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	mysql> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| REPEATABLE-READ       |
	+-----------------------+
	1 row in set, 1 warning (0.00 sec)

    set GLOBAL innodb_status_output=ON;
    set GLOBAL innodb_status_output_locks=ON;

	show global variables like '%innodb_status_output%';
	show global variables like '%innodb_status_output_locks%';
	

	mysql> show global variables like '%innodb_status_output%';
	+----------------------------+-------+
	| Variable_name              | Value |
	+----------------------------+-------+
	| innodb_status_output       | ON    |
	| innodb_status_output_locks | ON    |
	+----------------------------+-------+
	2 rows in set (0.00 sec)
	
	
	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `filed_02` int(10) DEFAULT '3' COMMENT 'filed_02',
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
	
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`, `filed_02`) VALUES ('2', '2', '2020-07-13 14:23:57', '0');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`, `filed_02`) VALUES ('3', '3', '2020-07-13 14:24:00', '0');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`, `filed_02`) VALUES ('4', '4', '2020-07-13 14:24:03', '0');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`, `filed_02`) VALUES ('5', '5', '2020-07-13 14:24:05', '0');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`, `filed_02`) VALUES ('6', '6', '2020-07-13 14:24:08', '0');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`, `filed_02`) VALUES ('7', '7', '2020-07-13 14:24:11', '0');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`, `filed_02`) VALUES ('8', '1', '2020-07-13 14:41:43', '0');
	INSERT INTO `test_db`.`t1` (`ID`, `age`, `tEndTime`, `filed_02`) VALUES ('10', '1', '2020-07-13 14:41:43', '0');



4. 实践1

	session A                       session B
	begin; 
	select * from t1 where id=2 lock in share mode;

									begin;
									select * from t1 where id=2 for update;
									(Blocked)
									
	
	处于锁等待的状态
			
		=====================================
		2021-04-13 11:38:44 0x7f6a7e32b700 INNODB MONITOR OUTPUT
		=====================================
		Per second averages calculated from the last 20 seconds
		-----------------
		BACKGROUND THREAD
		-----------------
		srv_master_thread loops: 28 srv_active, 0 srv_shutdown, 258688 srv_idle
		srv_master_thread log flush and writes: 258716
		----------
		SEMAPHORES
		----------
		OS WAIT ARRAY INFO: reservation count 93
		OS WAIT ARRAY INFO: signal count 93
		RW-shared spins 0, rounds 181, OS waits 90
		RW-excl spins 0, rounds 62, OS waits 0
		RW-sx spins 0, rounds 0, OS waits 0
		Spin rounds per wait: 181.00 RW-shared, 62.00 RW-excl, 0.00 RW-sx
		------------
		TRANSACTIONS
		------------
		Trx id counter 9308293
		Purge done for trx s n:o < 9286667 undo n:o < 0 state: running but idle
		History list length 3
		LIST OF TRANSACTIONS FOR EACH SESSION:
		---TRANSACTION 421580504570144, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504567408, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504566496, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504565584, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		
		-- 处于锁等待的事务状态
		---TRANSACTION 9308292, ACTIVE 10 sec starting index read
		mysql tables in use 1, locked 1
		LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
		MySQL thread id 5699, OS thread handle 140095258978048, query id 279804 localhost root statistics
		select * from t1 where id=2 for update                              -- 被阻塞的语句
		------- TRX HAS BEEN WAITING 10 SEC FOR THIS LOCK TO BE GRANTED:    -- 在等待的锁信息
		RECORD LOCKS space id 27364 page no 3 n bits 80 index PRIMARY of table `test_db`.`t1` trx id 9308292 lock_mode X locks rec but not gap waiting
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 6; compact format; info bits 0
		 0: len 4; hex 00000002; asc     ;;
		 1: len 6; hex 0000005ff4ae; asc    _  ;;
		 2: len 7; hex fa0000032f0110; asc     /  ;;
		 3: len 4; hex 80000002; asc     ;;
		 4: len 4; hex 5f0bfdfd; asc _   ;;
		 5: len 4; hex 80000000; asc     ;;

		------------------
		TABLE LOCK table `test_db`.`t1` trx id 9308292 lock mode IX        
		RECORD LOCKS space id 27364 page no 3 n bits 80 index PRIMARY of table `test_db`.`t1` trx id 9308292 lock_mode X locks rec but not gap waiting
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 6; compact format; info bits 0
		 0: len 4; hex 00000002; asc     ;;
		 1: len 6; hex 0000005ff4ae; asc    _  ;;
		 2: len 7; hex fa0000032f0110; asc     /  ;;
		 3: len 4; hex 80000002; asc     ;;
		 4: len 4; hex 5f0bfdfd; asc _   ;;
		 5: len 4; hex 80000000; asc     ;;

		---TRANSACTION 9308273, ACTIVE 168 sec
		2 lock struct(s), heap size 1136, 1 row lock(s)
		MySQL thread id 5698, OS thread handle 140095260043008, query id 279740 localhost root
		TABLE LOCK table `test_db`.`t1` trx id 9308273 lock mode IS
		RECORD LOCKS space id 27364 page no 3 n bits 80 index PRIMARY of table `test_db`.`t1` trx id 9308273 lock mode S locks rec but not gap
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 6; compact format; info bits 0
		 0: len 4; hex 00000002; asc     ;;
		 1: len 6; hex 0000005ff4ae; asc    _  ;;
		 2: len 7; hex fa0000032f0110; asc     /  ;;
		 3: len 4; hex 80000002; asc     ;;
		 4: len 4; hex 5f0bfdfd; asc _   ;;
		 5: len 4; hex 80000000; asc     ;;

		--------
		FILE I/O
		--------
		I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
		I/O thread 1 state: waiting for completed aio requests (log thread)
		I/O thread 2 state: waiting for completed aio requests (read thread)
		I/O thread 3 state: waiting for completed aio requests (read thread)
		I/O thread 4 state: waiting for completed aio requests (read thread)
		I/O thread 5 state: waiting for completed aio requests (read thread)
		I/O thread 6 state: waiting for completed aio requests (read thread)
		I/O thread 7 state: waiting for completed aio requests (read thread)
		I/O thread 8 state: waiting for completed aio requests (read thread)
		I/O thread 9 state: waiting for completed aio requests (read thread)
		I/O thread 10 state: waiting for completed aio requests (write thread)
		I/O thread 11 state: waiting for completed aio requests (write thread)
		I/O thread 12 state: waiting for completed aio requests (write thread)
		I/O thread 13 state: waiting for completed aio requests (write thread)
		I/O thread 14 state: waiting for completed aio requests (write thread)
		I/O thread 15 state: waiting for completed aio requests (write thread)
		I/O thread 16 state: waiting for completed aio requests (write thread)
		I/O thread 17 state: waiting for completed aio requests (write thread)
		Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 0, 0, 0, 0, 0] ,
		 ibuf aio reads:, log i/o's:, sync i/o's:
		Pending flushes (fsync) log: 0; buffer pool: 0
		1010 OS file reads, 6231 OS file writes, 458 OS fsyncs
		0.00 reads/s, 0 avg bytes/read, 0.00 writes/s, 0.00 fsyncs/s
		-------------------------------------
		INSERT BUFFER AND ADAPTIVE HASH INDEX
		-------------------------------------
		Ibuf: size 1, free list len 1964, seg size 1966, 0 merges
		merged operations:
		 insert 0, delete mark 0, delete 0
		discarded operations:
		 insert 0, delete mark 0, delete 0
		Hash table size 2390699, node heap has 37 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 1 buffer(s)
		Hash table size 2390699, node heap has 1 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 37 buffer(s)
		0.00 hash searches/s, 0.05 non-hash searches/s
		---
		LOG
		---
		Log sequence number 125549171813
		Log flushed up to   125549171813
		Pages flushed up to 125549171813
		Last checkpoint at  125549171804
		0 pending log flushes, 0 pending chkp writes
		272 log i/o's done, 0.00 log i/o's/second
		----------------------
		BUFFER POOL AND MEMORY
		----------------------
		Total large memory allocated 9894887424
		Dictionary memory allocated 392887
		Buffer pool size   589824
		Free buffers       586117
		Database pages     3631
		Old database pages 1331
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 950, created 2681, written 5821
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 3631, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		----------------------
		INDIVIDUAL BUFFER POOL INFO
		----------------------
		---BUFFER POOL 0
		Buffer pool size   294912
		Free buffers       293076
		Database pages     1798
		Old database pages 655
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 432, created 1366, written 3004
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 1798, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		---BUFFER POOL 1
		Buffer pool size   294912
		Free buffers       293041
		Database pages     1833
		Old database pages 676
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 518, created 1315, written 2817
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		No buffer pool page gets since the last printout
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 1833, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		--------------
		ROW OPERATIONS
		--------------
		0 queries inside InnoDB, 0 queries in queue
		0 read views open inside InnoDB
		Process ID=3807, Main thread ID=140095352121088, state: sleeping
		Number of rows inserted 83786, updated 1, deleted 2, read 747
		0.00 inserts/s, 0.00 updates/s, 0.00 deletes/s, 0.00 reads/s
		----------------------------
		END OF INNODB MONITOR OUTPUT
		============================


	锁等待超时之后的状态

		=====================================
		2021-04-13 11:39:04 0x7f6a7e32b700 INNODB MONITOR OUTPUT
		=====================================
		Per second averages calculated from the last 20 seconds
		-----------------
		BACKGROUND THREAD
		-----------------
		srv_master_thread loops: 29 srv_active, 0 srv_shutdown, 258707 srv_idle
		srv_master_thread log flush and writes: 258736
		----------
		SEMAPHORES
		----------
		OS WAIT ARRAY INFO: reservation count 93
		OS WAIT ARRAY INFO: signal count 93
		RW-shared spins 0, rounds 181, OS waits 90
		RW-excl spins 0, rounds 62, OS waits 0
		RW-sx spins 0, rounds 0, OS waits 0
		Spin rounds per wait: 181.00 RW-shared, 62.00 RW-excl, 0.00 RW-sx
		------------
		TRANSACTIONS
		------------
		Trx id counter 9308298
		Purge done for trx s n:o < 9286667 undo n:o < 0 state: running but idle
		History list length 3
		LIST OF TRANSACTIONS FOR EACH SESSION:
		---TRANSACTION 421580504570144, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504569232, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504567408, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504566496, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504565584, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 9308273, ACTIVE 188 sec
		2 lock struct(s), heap size 1136, 1 row lock(s)
		MySQL thread id 5698, OS thread handle 140095260043008, query id 279740 localhost root
		TABLE LOCK table `test_db`.`t1` trx id 9308273 lock mode IS
		RECORD LOCKS space id 27364 page no 3 n bits 80 index PRIMARY of table `test_db`.`t1` trx id 9308273 lock mode S locks rec but not gap
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 6; compact format; info bits 0
		 0: len 4; hex 00000002; asc     ;;
		 1: len 6; hex 0000005ff4ae; asc    _  ;;
		 2: len 7; hex fa0000032f0110; asc     /  ;;
		 3: len 4; hex 80000002; asc     ;;
		 4: len 4; hex 5f0bfdfd; asc _   ;;
		 5: len 4; hex 80000000; asc     ;;

		--------
		FILE I/O
		--------
		I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
		I/O thread 1 state: waiting for completed aio requests (log thread)
		I/O thread 2 state: waiting for completed aio requests (read thread)
		I/O thread 3 state: waiting for completed aio requests (read thread)
		I/O thread 4 state: waiting for completed aio requests (read thread)
		I/O thread 5 state: waiting for completed aio requests (read thread)
		I/O thread 6 state: waiting for completed aio requests (read thread)
		I/O thread 7 state: waiting for completed aio requests (read thread)
		I/O thread 8 state: waiting for completed aio requests (read thread)
		I/O thread 9 state: waiting for completed aio requests (read thread)
		I/O thread 10 state: waiting for completed aio requests (write thread)
		I/O thread 11 state: waiting for completed aio requests (write thread)
		I/O thread 12 state: waiting for completed aio requests (write thread)
		I/O thread 13 state: waiting for completed aio requests (write thread)
		I/O thread 14 state: waiting for completed aio requests (write thread)
		I/O thread 15 state: waiting for completed aio requests (write thread)
		I/O thread 16 state: waiting for completed aio requests (write thread)
		I/O thread 17 state: waiting for completed aio requests (write thread)
		Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 0, 0, 0, 0, 0] ,
		 ibuf aio reads:, log i/o's:, sync i/o's:
		Pending flushes (fsync) log: 0; buffer pool: 0
		1010 OS file reads, 6231 OS file writes, 458 OS fsyncs
		0.00 reads/s, 0 avg bytes/read, 0.00 writes/s, 0.00 fsyncs/s
		-------------------------------------
		INSERT BUFFER AND ADAPTIVE HASH INDEX
		-------------------------------------
		Ibuf: size 1, free list len 1964, seg size 1966, 0 merges
		merged operations:
		 insert 0, delete mark 0, delete 0
		discarded operations:
		 insert 0, delete mark 0, delete 0
		Hash table size 2390699, node heap has 37 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 1 buffer(s)
		Hash table size 2390699, node heap has 1 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 37 buffer(s)
		0.00 hash searches/s, 1.30 non-hash searches/s
		---
		LOG
		---
		Log sequence number 125549171813
		Log flushed up to   125549171813
		Pages flushed up to 125549171813
		Last checkpoint at  125549171804
		0 pending log flushes, 0 pending chkp writes
		272 log i/o's done, 0.00 log i/o's/second
		----------------------
		BUFFER POOL AND MEMORY
		----------------------
		Total large memory allocated 9894887424
		Dictionary memory allocated 392887
		Buffer pool size   589824
		Free buffers       586117
		Database pages     3631
		Old database pages 1331
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 950, created 2681, written 5821
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 3631, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		----------------------
		INDIVIDUAL BUFFER POOL INFO
		----------------------
		---BUFFER POOL 0
		Buffer pool size   294912
		Free buffers       293076
		Database pages     1798
		Old database pages 655
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 432, created 1366, written 3004
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 1798, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		---BUFFER POOL 1
		Buffer pool size   294912
		Free buffers       293041
		Database pages     1833
		Old database pages 676
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 518, created 1315, written 2817
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 1833, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		--------------
		ROW OPERATIONS
		--------------
		0 queries inside InnoDB, 0 queries in queue
		0 read views open inside InnoDB
		Process ID=3807, Main thread ID=140095352121088, state: sleeping
		Number of rows inserted 83786, updated 1, deleted 2, read 747
		0.00 inserts/s, 0.00 updates/s, 0.00 deletes/s, 0.00 reads/s
		----------------------------
		END OF INNODB MONITOR OUTPUT
		============================
					

5. 实践2

	innodb_status_output=ON AND innodb_status_output_locks=off
	-- innodb_status_output_locks=off，处于锁等待的状态，不记录锁信息
		=====================================
		2021-04-13 11:56:44 0x7f6a7e32b700 INNODB MONITOR OUTPUT
		=====================================
		Per second averages calculated from the last 20 seconds
		-----------------
		BACKGROUND THREAD
		-----------------
		srv_master_thread loops: 31 srv_active, 0 srv_shutdown, 259765 srv_idle
		srv_master_thread log flush and writes: 259796
		----------
		SEMAPHORES
		----------
		OS WAIT ARRAY INFO: reservation count 93
		OS WAIT ARRAY INFO: signal count 93
		RW-shared spins 0, rounds 181, OS waits 90
		RW-excl spins 0, rounds 62, OS waits 0
		RW-sx spins 0, rounds 0, OS waits 0
		Spin rounds per wait: 181.00 RW-shared, 62.00 RW-excl, 0.00 RW-sx
		------------
		TRANSACTIONS
		------------
		Trx id counter 9308386
		Purge done for trx s n:o < 9286667 undo n:o < 0 state: running but idle
		History list length 3
		LIST OF TRANSACTIONS FOR EACH SESSION:
		---TRANSACTION 421580504570144, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504567408, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504566496, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 421580504565584, not started
		0 lock struct(s), heap size 1136, 0 row lock(s)
		---TRANSACTION 9308385, ACTIVE 8 sec starting index read
		mysql tables in use 1, locked 1
		LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
		MySQL thread id 5699, OS thread handle 140095258978048, query id 279952 localhost root statistics
		select * from t1 where id=2 for update
		------- TRX HAS BEEN WAITING 8 SEC FOR THIS LOCK TO BE GRANTED:
		RECORD LOCKS space id 27364 page no 3 n bits 80 index PRIMARY of table `test_db`.`t1` trx id 9308385 lock_mode X locks rec but not gap waiting
		Record lock, heap no 2 PHYSICAL RECORD: n_fields 6; compact format; info bits 0
		 0: len 4; hex 00000002; asc     ;;
		 1: len 6; hex 0000005ff4ae; asc    _  ;;
		 2: len 7; hex fa0000032f0110; asc     /  ;;
		 3: len 4; hex 80000002; asc     ;;
		 4: len 4; hex 5f0bfdfd; asc _   ;;
		 5: len 4; hex 80000000; asc     ;;

		------------------
		---TRANSACTION 9308273, ACTIVE 1248 sec
		2 lock struct(s), heap size 1136, 1 row lock(s)
		MySQL thread id 5698, OS thread handle 140095260043008, query id 279740 localhost root
		--------
		FILE I/O
		--------
		I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
		I/O thread 1 state: waiting for completed aio requests (log thread)
		I/O thread 2 state: waiting for completed aio requests (read thread)
		I/O thread 3 state: waiting for completed aio requests (read thread)
		I/O thread 4 state: waiting for completed aio requests (read thread)
		I/O thread 5 state: waiting for completed aio requests (read thread)
		I/O thread 6 state: waiting for completed aio requests (read thread)
		I/O thread 7 state: waiting for completed aio requests (read thread)
		I/O thread 8 state: waiting for completed aio requests (read thread)
		I/O thread 9 state: waiting for completed aio requests (read thread)
		I/O thread 10 state: waiting for completed aio requests (write thread)
		I/O thread 11 state: waiting for completed aio requests (write thread)
		I/O thread 12 state: waiting for completed aio requests (write thread)
		I/O thread 13 state: waiting for completed aio requests (write thread)
		I/O thread 14 state: waiting for completed aio requests (write thread)
		I/O thread 15 state: waiting for completed aio requests (write thread)
		I/O thread 16 state: waiting for completed aio requests (write thread)
		I/O thread 17 state: waiting for completed aio requests (write thread)
		Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 0, 0, 0, 0, 0] ,
		 ibuf aio reads:, log i/o's:, sync i/o's:
		Pending flushes (fsync) log: 0; buffer pool: 0
		1010 OS file reads, 6231 OS file writes, 458 OS fsyncs
		0.00 reads/s, 0 avg bytes/read, 0.00 writes/s, 0.00 fsyncs/s
		-------------------------------------
		INSERT BUFFER AND ADAPTIVE HASH INDEX
		-------------------------------------
		Ibuf: size 1, free list len 1964, seg size 1966, 0 merges
		merged operations:
		 insert 0, delete mark 0, delete 0
		discarded operations:
		 insert 0, delete mark 0, delete 0
		Hash table size 2390699, node heap has 37 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 1 buffer(s)
		Hash table size 2390699, node heap has 1 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 0 buffer(s)
		Hash table size 2390699, node heap has 37 buffer(s)
		0.00 hash searches/s, 0.10 non-hash searches/s
		---
		LOG
		---
		Log sequence number 125549171813
		Log flushed up to   125549171813
		Pages flushed up to 125549171813
		Last checkpoint at  125549171804
		0 pending log flushes, 0 pending chkp writes
		272 log i/o's done, 0.00 log i/o's/second
		----------------------
		BUFFER POOL AND MEMORY
		----------------------
		Total large memory allocated 9894887424
		Dictionary memory allocated 392887
		Buffer pool size   589824
		Free buffers       586117
		Database pages     3631
		Old database pages 1331
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 950, created 2681, written 5821
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 3631, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		----------------------
		INDIVIDUAL BUFFER POOL INFO
		----------------------
		---BUFFER POOL 0
		Buffer pool size   294912
		Free buffers       293076
		Database pages     1798
		Old database pages 655
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 432, created 1366, written 3004
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 1798, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		---BUFFER POOL 1
		Buffer pool size   294912
		Free buffers       293041
		Database pages     1833
		Old database pages 676
		Modified db pages  0
		Pending reads      0
		Pending writes: LRU 0, flush list 0, single page 0
		Pages made young 0, not young 0
		0.00 youngs/s, 0.00 non-youngs/s
		Pages read 518, created 1315, written 2817
		0.00 reads/s, 0.00 creates/s, 0.00 writes/s
		No buffer pool page gets since the last printout
		Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
		LRU len: 1833, unzip_LRU len: 0
		I/O sum[0]:cur[0], unzip sum[0]:cur[0]
		--------------
		ROW OPERATIONS
		--------------
		0 queries inside InnoDB, 0 queries in queue
		0 read views open inside InnoDB
		Process ID=3807, Main thread ID=140095352121088, state: sleeping
		Number of rows inserted 83786, updated 1, deleted 2, read 747
		0.00 inserts/s, 0.00 updates/s, 0.00 deletes/s, 0.00 reads/s
		----------------------------
		END OF INNODB MONITOR OUTPUT
		============================


6. 实践3

	session A                       session B
	begin; 
	select * from t1 where id=2 lock in share mode;

									begin;
									select * from t1 where age=2 for update;
									(Blocked)


	=====================================
	2021-04-13 14:13:40 0x7f6a7e32b700 INNODB MONITOR OUTPUT
	=====================================
	Per second averages calculated from the last 20 seconds
	-----------------
	BACKGROUND THREAD
	-----------------
	srv_master_thread loops: 35 srv_active, 0 srv_shutdown, 267975 srv_idle
	srv_master_thread log flush and writes: 268010
	----------
	SEMAPHORES
	----------
	OS WAIT ARRAY INFO: reservation count 96
	OS WAIT ARRAY INFO: signal count 96
	RW-shared spins 0, rounds 187, OS waits 93
	RW-excl spins 0, rounds 62, OS waits 0
	RW-sx spins 0, rounds 0, OS waits 0
	Spin rounds per wait: 187.00 RW-shared, 62.00 RW-excl, 0.00 RW-sx
	------------
	TRANSACTIONS
	------------
	Trx id counter 9309074
	Purge done for trx s n:o < 9286667 undo n:o < 0 state: running but idle
	History list length 3
	LIST OF TRANSACTIONS FOR EACH SESSION:
	---TRANSACTION 421580504570144, not started
	0 lock struct(s), heap size 1136, 0 row lock(s)
	---TRANSACTION 421580504567408, not started
	0 lock struct(s), heap size 1136, 0 row lock(s)
	---TRANSACTION 421580504566496, not started
	0 lock struct(s), heap size 1136, 0 row lock(s)
	---TRANSACTION 421580504565584, not started
	0 lock struct(s), heap size 1136, 0 row lock(s)

	---TRANSACTION 9309073, ACTIVE 27 sec starting index read
	mysql tables in use 1, locked 1
	LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
	MySQL thread id 5770, OS thread handle 140094989059840, query id 280948 localhost root Sending data
	select * from t1 where age=2 for update           					-- 被阻塞的语句
	------- TRX HAS BEEN WAITING 27 SEC FOR THIS LOCK TO BE GRANTED:    -- 
	RECORD LOCKS space id 27364 page no 3 n bits 80 index PRIMARY of table `test_db`.`t1` trx id 9309073 lock_mode X locks rec but not gap waiting
	Record lock, heap no 2 PHYSICAL RECORD: n_fields 6; compact format; info bits 0
	 0: len 4; hex 00000002; asc     ;;
	 1: len 6; hex 0000005ff4ae; asc    _  ;;
	 2: len 7; hex fa0000032f0110; asc     /  ;;
	 3: len 4; hex 80000002; asc     ;;
	 4: len 4; hex 5f0bfdfd; asc _   ;;
	 5: len 4; hex 80000000; asc     ;;

	------------------
	-- 二级索引idx_age对应的记录加锁成功
	TABLE LOCK table `test_db`.`t1` trx id 9309073 lock mode IX
	RECORD LOCKS space id 27364 page no 4 n bits 80 index idx_age of table `test_db`.`t1` trx id 9309073 lock_mode X
	Record lock, heap no 4 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
	 0: len 4; hex 80000002; asc     ;;
	 1: len 4; hex 00000002; asc     ;;

	-- 主键索引加锁，处于锁等待状态
	RECORD LOCKS space id 27364 page no 3 n bits 80 index PRIMARY of table `test_db`.`t1` trx id 9309073 lock_mode X locks rec but not gap waiting
	Record lock, heap no 2 PHYSICAL RECORD: n_fields 6; compact format; info bits 0
	 0: len 4; hex 00000002; asc     ;;
	 1: len 6; hex 0000005ff4ae; asc    _  ;;
	 2: len 7; hex fa0000032f0110; asc     /  ;;
	 3: len 4; hex 80000002; asc     ;;
	 4: len 4; hex 5f0bfdfd; asc _   ;;
	 5: len 4; hex 80000000; asc     ;;

	---TRANSACTION 9308273, ACTIVE 9464 sec
	2 lock struct(s), heap size 1136, 1 row lock(s)
	MySQL thread id 5698, OS thread handle 140095260043008, query id 279740 localhost root
	TABLE LOCK table `test_db`.`t1` trx id 9308273 lock mode IS
	RECORD LOCKS space id 27364 page no 3 n bits 80 index PRIMARY of table `test_db`.`t1` trx id 9308273 lock mode S locks rec but not gap
	Record lock, heap no 2 PHYSICAL RECORD: n_fields 6; compact format; info bits 0
	 0: len 4; hex 00000002; asc     ;;
	 1: len 6; hex 0000005ff4ae; asc    _  ;;
	 2: len 7; hex fa0000032f0110; asc     /  ;;
	 3: len 4; hex 80000002; asc     ;;
	 4: len 4; hex 5f0bfdfd; asc _   ;;
	 5: len 4; hex 80000000; asc     ;;

	--------
	FILE I/O
	--------
	I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
	I/O thread 1 state: waiting for completed aio requests (log thread)
	I/O thread 2 state: waiting for completed aio requests (read thread)
	I/O thread 3 state: waiting for completed aio requests (read thread)
	I/O thread 4 state: waiting for completed aio requests (read thread)
	I/O thread 5 state: waiting for completed aio requests (read thread)
	I/O thread 6 state: waiting for completed aio requests (read thread)
	I/O thread 7 state: waiting for completed aio requests (read thread)
	I/O thread 8 state: waiting for completed aio requests (read thread)
	I/O thread 9 state: waiting for completed aio requests (read thread)
	I/O thread 10 state: waiting for completed aio requests (write thread)
	I/O thread 11 state: waiting for completed aio requests (write thread)
	I/O thread 12 state: waiting for completed aio requests (write thread)
	I/O thread 13 state: waiting for completed aio requests (write thread)
	I/O thread 14 state: waiting for completed aio requests (write thread)
	I/O thread 15 state: waiting for completed aio requests (write thread)
	I/O thread 16 state: waiting for completed aio requests (write thread)
	I/O thread 17 state: waiting for completed aio requests (write thread)
	Pending normal aio reads: [0, 0, 0, 0, 0, 0, 0, 0] , aio writes: [0, 0, 0, 0, 0, 0, 0, 0] ,
	 ibuf aio reads:, log i/o's:, sync i/o's:
	Pending flushes (fsync) log: 0; buffer pool: 0
	1011 OS file reads, 6246 OS file writes, 473 OS fsyncs
	0.00 reads/s, 0 avg bytes/read, 0.00 writes/s, 0.00 fsyncs/s
	-------------------------------------
	INSERT BUFFER AND ADAPTIVE HASH INDEX
	-------------------------------------
	Ibuf: size 1, free list len 1964, seg size 1966, 0 merges
	merged operations:
	 insert 0, delete mark 0, delete 0
	discarded operations:
	 insert 0, delete mark 0, delete 0
	Hash table size 2390699, node heap has 37 buffer(s)
	Hash table size 2390699, node heap has 0 buffer(s)
	Hash table size 2390699, node heap has 1 buffer(s)
	Hash table size 2390699, node heap has 1 buffer(s)
	Hash table size 2390699, node heap has 0 buffer(s)
	Hash table size 2390699, node heap has 0 buffer(s)
	Hash table size 2390699, node heap has 0 buffer(s)
	Hash table size 2390699, node heap has 37 buffer(s)
	0.00 hash searches/s, 0.00 non-hash searches/s
	---
	LOG
	---
	Log sequence number 125549171870
	Log flushed up to   125549171870
	Pages flushed up to 125549171870
	Last checkpoint at  125549171861
	0 pending log flushes, 0 pending chkp writes
	281 log i/o's done, 0.00 log i/o's/second
	----------------------
	BUFFER POOL AND MEMORY
	----------------------
	Total large memory allocated 9894887424
	Dictionary memory allocated 392887
	Buffer pool size   589824
	Free buffers       586116
	Database pages     3632
	Old database pages 1332
	Modified db pages  0
	Pending reads      0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 0, not young 0
	0.00 youngs/s, 0.00 non-youngs/s
	Pages read 951, created 2681, written 5824
	0.00 reads/s, 0.00 creates/s, 0.00 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 3632, unzip_LRU len: 0
	I/O sum[0]:cur[0], unzip sum[0]:cur[0]
	----------------------
	INDIVIDUAL BUFFER POOL INFO
	----------------------
	---BUFFER POOL 0
	Buffer pool size   294912
	Free buffers       293075
	Database pages     1799
	Old database pages 656
	Modified db pages  0
	Pending reads      0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 0, not young 0
	0.00 youngs/s, 0.00 non-youngs/s
	Pages read 433, created 1366, written 3007
	0.00 reads/s, 0.00 creates/s, 0.00 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 1799, unzip_LRU len: 0
	I/O sum[0]:cur[0], unzip sum[0]:cur[0]
	---BUFFER POOL 1
	Buffer pool size   294912
	Free buffers       293041
	Database pages     1833
	Old database pages 676
	Modified db pages  0
	Pending reads      0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 0, not young 0
	0.00 youngs/s, 0.00 non-youngs/s
	Pages read 518, created 1315, written 2817
	0.00 reads/s, 0.00 creates/s, 0.00 writes/s
	No buffer pool page gets since the last printout
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 1833, unzip_LRU len: 0
	I/O sum[0]:cur[0], unzip sum[0]:cur[0]
	--------------
	ROW OPERATIONS
	--------------
	0 queries inside InnoDB, 0 queries in queue
	0 read views open inside InnoDB
	Process ID=3807, Main thread ID=140095352121088, state: sleeping
	Number of rows inserted 83786, updated 1, deleted 2, read 747
	0.00 inserts/s, 0.00 updates/s, 0.00 deletes/s, 0.00 reads/s
	----------------------------
	END OF INNODB MONITOR OUTPUT
	============================


7. 相关参考
	
	https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output
	https://blog.csdn.net/hangxing_2015/article/details/52586335  InnoDB monitor被莫名开启的问题分析
	https://www.jianshu.com/p/21c8510f2217      Innodb: 自动开启打印show engine status到err日志
	https://www.cnblogs.com/wangdong/p/9235249.html  查看锁信息（开启InnoDB监控）
	

8. 小结

	在排查问题的时候，当需要 show engine innodb status 的定期信息，可以把 innodb_status_output、innodb_status_output_locks 这两个参数开启。
	工作中还没有通过开启这2个参数来排查相关问题。
	注意开启前必须先开启innodb_status_output，而关闭时只需要直接关闭innodb_status_output_locks，如果关闭了innodb_status_output，那么Standard Monitor也会被一同关闭。
		如果要开启innodb_status_output_locks那么必须要开启innodb_status_output
	
	
	
