
mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.26-log |
+------------+
1 row in set (0.01 sec)


相关参数
	
	mysql> show global variables like '%innodb_buffer_pool_size%';
	+-------------------------+-------------+
	| Variable_name           | Value       |
	+-------------------------+-------------+
	| innodb_buffer_pool_size | 10737418240 |
	+-------------------------+-------------+
	1 row in set (0.01 sec)

	shell> free -h
				  total        used        free      shared  buff/cache   available
	Mem:            15G         13G        164M        792M        2.0G        1.1G
	Swap:            0B          0B          0B

在线修改 buffer pool
	
	10GB -> 8GB 
	2个 instance, 每个 instance = 4GB, 每个instance有40个 chunks . 
	
	mysql> show global variables like '%pool_instance%';
	+------------------------------+-------+
	| Variable_name                | Value |
	+------------------------------+-------+
	| innodb_buffer_pool_instances | 2     |
	+------------------------------+-------+
	1 row in set (0.00 sec)
	
	
	mysql> show global variables like '%chunk%';
	+-------------------------------+-----------+
	| Variable_name                 | Value     |
	+-------------------------------+-----------+
	| innodb_buffer_pool_chunk_size | 134217728 |
	+-------------------------------+-----------+
	1 row in set (0.00 sec)



	mysql> set global innodb_buffer_pool_size=8589934592;
	Query OK, 0 rows affected (0.02 sec)
	-- 耗时 0.02 秒
	
		注意:
			设置变量 innodb_buffer_pool_size 时，触发函数 innodb_buffer_pool_size_update，在必要的检查后（例如避免重复发送请求，或者resize的太小），发送信号量 srv_buf_resize_event .然后立刻返回
			因此设置变量成功，不等于bp 的size已经调整好了，只是发出了 一个resize请求而已.


	2020-06-19T09:44:04.918915+08:00 0 [Note] InnoDB: Resizing buffer pool from 10737418240 to 8589934592 (unit=134217728).
	2020-06-19T09:44:04.918917+08:00 990272 [Note] InnoDB: Resizing buffer pool from 107374 (new size: 8589934592 bytes)
	
	-- 禁用AHI 
	2020-06-19T09:44:04.919074+08:00 0 [Note] InnoDB: Disabling adaptive hash index.
	2020-06-19T09:44:05.005738+08:00 0 [Note] InnoDB: disabled adaptive hash index.
	
	
	-- 计算回收BP缓冲池的数据页
	2020-06-19T09:44:05.005790+08:00 0 [Note] InnoDB: Withdrawing blocks to be shrunken.
	
	-- 第1个instance, 需要回收 65529 个数据页(=1GB)
	2020-06-19T09:44:05.005801+08:00 0 [Note] InnoDB: buffer pool 0 : start to withdraw the last 65529 blocks.
	
	mysql> select 65529*16;
	+----------+
	| 65529*16 |
	+----------+
	|  1048464 |
	+----------+
	1 row in set (0.00 sec)
	1048464 KB = 1GB

	-- 这里开始加BP缓冲池 instance 锁
	
	2020-06-19T09:44:08.604809+08:00 0 [Note] InnoDB: buffer pool 0 : withdrawing blocks. (65528/65529)
	
	-- 从空闲列表中取出 5996 个块
	2020-06-19T09:44:08.604877+08:00 0 [Note] InnoDB: buffer pool 0 : withdrew 5996 blocks from free list. Tried to relocate 50275 pages (65528/65529).
	2020-06-19T09:44:08.648711+08:00 0 [Note] InnoDB: buffer pool 0 : withdrawing blocks. (65529/65529)
	
	2020-06-19T09:44:08.648772+08:00 0 [Note] InnoDB: buffer pool 0 : withdrew 0 blocks from free list. Tried to relocate 1 pages (65529/65529).
	-- 收缩 
	2020-06-19T09:44:08.650510+08:00 0 [Note] InnoDB: buffer pool 0 : withdrawn target 65529 blocks.
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- 第2个instance, 需要回收 65536 个数据页(=1GB)
	2020-06-19T09:44:08.650542+08:00 0 [Note] InnoDB: buffer pool 1 : start to withdraw the last 65536 blocks.
	2020-06-19T09:44:11.438671+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65533/65536)
	-- 从空闲列表中取出 5876 个块
	2020-06-19T09:44:11.438738+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 5876 blocks from free list. Tried to relocate 50398 pages (65533/65536).
	2020-06-19T09:44:11.480111+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65533/65536)
	2020-06-19T09:44:11.480167+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 0 pages (65533/65536).
	2020-06-19T09:44:11.521444+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65533/65536)
	2020-06-19T09:44:11.521505+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 0 pages (65533/65536).
	2020-06-19T09:44:11.562224+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65533/65536)
	2020-06-19T09:44:11.562277+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 0 pages (65533/65536).
	2020-06-19T09:44:11.603462+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65533/65536)
	2020-06-19T09:44:11.603523+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 0 pages (65533/65536).
	2020-06-19T09:44:11.644759+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65533/65536)
	2020-06-19T09:44:11.644824+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 0 pages (65533/65536).
	2020-06-19T09:44:11.686399+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65533/65536)
	2020-06-19T09:44:11.686462+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 0 pages (65533/65536).
	2020-06-19T09:44:11.727438+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65533/65536)
	2020-06-19T09:44:11.727505+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 0 pages (65533/65536).
	2020-06-19T09:44:11.768606+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65534/65536)
	2020-06-19T09:44:11.768671+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 1 pages (65534/65536).
	2020-06-19T09:44:11.809903+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65535/65536)
	2020-06-19T09:44:11.809968+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 1 pages (65535/65536).
	2020-06-19T09:44:11.809981+08:00 0 [Note] InnoDB: buffer pool 1 : will retry to withdraw later.
	2020-06-19T09:44:11.810014+08:00 0 [Note] InnoDB: Will retry to withdraw 1 seconds later.
	
	2020-06-19T09:44:12.810176+08:00 0 [Note] InnoDB: buffer pool 0 : start to withdraw the last 65529 blocks.
	2020-06-19T09:44:12.811214+08:00 0 [Note] InnoDB: buffer pool 0 : withdrawn target 65529 blocks.
	2020-06-19T09:44:12.811252+08:00 0 [Note] InnoDB: buffer pool 1 : start to withdraw the last 65536 blocks.
	2020-06-19T09:44:12.852304+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawing blocks. (65536/65536)
	2020-06-19T09:44:12.852357+08:00 0 [Note] InnoDB: buffer pool 1 : withdrew 0 blocks from free list. Tried to relocate 1 pages (65536/65536).
	2020-06-19T09:44:12.853168+08:00 0 [Note] InnoDB: buffer pool 1 : withdrawn target 65536 blocks.
	
	-- 锁住所有instance的buffer_pool，page_hash
	2020-06-19T09:44:12.853192+08:00 0 [Note] InnoDB: Latching whole of buffer pool.
	-- 收缩pool：以chunk为单位释放要收缩的内存
	-- 由 40个 chunk 收缩到 32个
	2020-06-19T09:44:12.853218+08:00 0 [Note] InnoDB: buffer pool 0 : resizing with chunks 40 to 32.
	2020-06-19T09:44:13.111659+08:00 0 [Note] InnoDB: buffer pool 0 : 8 chunks (65529 blocks) were freed.
	-- 由 40个 chunk 收缩到 32个
	2020-06-19T09:44:13.111794+08:00 0 [Note] InnoDB: buffer pool 1 : resizing with chunks 40 to 32.
	2020-06-19T09:44:13.369337+08:00 0 [Note] InnoDB: buffer pool 1 : 8 chunks (65536 blocks) were freed.
	2020-06-19T09:44:13.369513+08:00 0 [Note] InnoDB: Completed to resize buffer pool from 10737418240 to 8589934592.
	2020-06-19T09:44:13.369532+08:00 0 [Note] InnoDB: Re-enabled adaptive hash index.
	2020-06-19T09:44:13.369544+08:00 0 [Note] InnoDB: Completed resizing buffer pool at 200619  9:44:13.
	
	-- 总耗时: 9秒
		计算回收chunk的耗时：7秒；09:44:05 ~ 09:44:12
			第一个instance 耗时: 3秒；09:44:05 ~ 09:44:08
			第二个instance 耗时：3秒；09:44:48 ~ 09:44:12
			
		resize的耗时：0.5 秒；09:44:12.85 ~ 9:44:13.37； 1.37 - 0.85 = 0.52；
		
		
	
1个chunk = 128MB 
8个chunks = 1024MB


	mysql> show global variables like '%innodb_buffer_pool_size%';
	+-------------------------+------------+
	| Variable_name           | Value      |
	+-------------------------+------------+
	| innodb_buffer_pool_size | 8589934592 |
	+-------------------------+------------+
	1 row in set (0.01 sec)


	shell> free -h
				  total        used        free      shared  buff/cache   available
	Mem:            15G         11G        2.2G        792M        2.0G        3.1G
	Swap:            0B          0B          0B


	mysql> select hostname_max,client_max,user_max,ts_min,ts_max,ts_cnt,Query_time_sum,Query_time_min,Query_time_max,sample from mysql_slow_query_review_history where  user_max not in ('root', 'read_user')  and hostname_max='192.168.1.10_db1' and ts_min>'2020-06-19 09:44:00.000000';
	+------------------+--------------+------------+----------------------------+----------------------------+--------+----------------+----------------+----------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| hostname_max     | client_max   | user_max   | ts_min                     | ts_max                     | ts_cnt | Query_time_sum | Query_time_min | Query_time_max | sample                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
	+------------------+--------------+------------+----------------------------+----------------------------+--------+----------------+----------------+----------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| 192.168.1.10_db1 | 192.168.1.30 | apph5_user | 2020-06-19 09:44:08.000000 | 2020-06-19 09:44:11.000000 |     15 |        38.1937 |        1.01717 |          3.163 | call pr_club_write_score_detail3(10038,256350,1,'10038-256350-1592531032-1',1,4000,4,'2020-06-19 09:43:52','2020-06-19 09:44:06',136763,0,0,'2c39382705',30200,24000,24000,-24000,6200,0,15,'2d35151231',1502,'','2d351512312b1a1909212c3938270528063404113')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
	| 192.168.1.10_db1 | 192.168.1.30 | apph5_user | 2020-06-19 09:44:08.000000 | 2020-06-19 09:44:11.000000 |      6 |        15.1773 |       0.900969 |        5.68298 | call pr_UpdateUserClubScore3(1502,136763,10038,-24000,6200,6,'10038-256350-1592531032-1-1','????',@nOutScore)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
	| 192.168.1.10_db1 | 192.168.1.12 | apph5_user | 2020-06-19 09:44:08.000000 | 2020-06-19 09:44:11.000000 |      8 |         13.433 |       0.915074 |        3.13328 | call pr_third_query_user('gcdbec','10126',@nScore,@nPlayerID)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
	| 192.168.1.10_db1 | 192.168.1.30 | apph5_user | 2020-06-19 09:44:08.000000 | 2020-06-19 09:44:11.000000 |      6 |        12.7535 |        1.00675 |        3.14686 | call pr_table_club_game_log('10081-252398-1592531032-1-4','2020-06-19 09:43:52','2020-06-19 09:44:05',15,1502,'{"LogCount":26,"jsonlog":[{"1":"????:200156 ???:4"},{"2":"???????,?? 4"},{"3":"1 ??,???? 1842.603"},{"4":"2 ??,???? 1808.535"},{"5":"3 ??,???? 1906.082"},{"6":"4 ??,???? 601.62"},{"7":"??"},{"8":"1 ??,1??,???1?,????X1?"},{"9":"3 ??,3??,???2?,??"},{"10":"2 ??,2??,???2?,??"},{"11":"4 ??,4??,???3?,??"},{"12":"1 ??,???3?,????"},{"13":"??"},{"14":"3 ??,???4?,?1?"},{"15":"4 ??,???5?,?4?"},{"16":"2 ??,???6?,?4?"},{"17":"??"},{"18":"3 ??,???11?,??"},{"19":"1 ??,???11?,??"},{"20":"2 ??,???12?,??"},{"21":"4 ??,???13?,??"},{"22":"??"},{"23":"1 ??,?,??????34.2,???K?J?8?8?7,??*1,????=36.0"},{"24":"2 ??,?,??????-16.0,???Q?10?5?2?A,??*1,????=16.0"},{"25":"3 ??,?,??????-4.0,???J?10?7?4?2,??*1,????=4.0"},{"26":"4 ??,?,??????-16.0,???9?7?6?3?3,??*1,????=16.0"}],"jsondata":""}','1d3b3818170c1a2522012b3a07140239372633231') |
	| 192.168.1.10_db1 | 192.168.1.12 | apph5_user | 2020-06-19 09:44:08.000000 | 2020-06-19 09:44:11.000000 |      3 |         7.9616 |        2.07927 |        3.01227 | call pr_third_query_order('1002024106171908548094735',@nAmount,@nStatus,@returnVal,@returnMsg)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
	| 192.168.1.10_db1 | 192.168.1.12 | apph5_user | 2020-06-19 09:44:08.000000 | 2020-06-19 09:44:11.000000 |      2 |        6.31445 |        2.97446 |        3.33999 | call pr_third_make_order(128633,'10002_2006190001128','10002',@score,@rval,@msg)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
	| 192.168.1.10_db1 | 192.168.1.18 | apph5_user | 2020-06-19 09:44:08.000000 | 2020-06-19 09:44:11.000000 |      2 |         4.6943 |        1.99616 |        2.69814 | call Pr_WriteTaxRecord2('74',209595,1202,748894,2500,90,50,'???????',10002,0)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
	加BP缓冲锁   -> 09:44:08
	释放BP缓冲锁 -> 09:44:11
	
	| 192.168.1.10_db1 | 192.168.1.12 | apph5_user | 2020-06-19 09:44:11.000000 | 2020-06-19 09:44:11.000000 |      1 |        5.40531 |        5.40531 |        5.40531 | call Pr_ThirdUserCreateEx('icdedh','116.28.236.194',10087,'1008715406190944060740620',3991370.0,'djgbeb',@intOutPlayerId,@returnVal,@returnMsg)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
	| 192.168.1.10_db1 | 192.168.1.12 | apph5_user | 2020-06-19 09:44:11.000000 | 2020-06-19 09:44:11.000000 |      1 |       0.993673 |       0.993673 |       0.993673 | call pr_get_agent_key('10145',@deskey,@md5key,@msg,@rval)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
	+------------------+--------------+------------+----------------------------+----------------------------+--------+----------------+----------------+----------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	9 rows in set (0.00 sec)
	
	加BP缓冲锁   -> 09:44:11
	
	加BP缓冲锁   -> 09:44:11
	
	
	-- 阻塞业务的DML和查询请求: 3-5秒

	mysql> show engine innodb status\G;
	*************************** 1. row ***************************
	  Type: InnoDB
	  Name: 
	Status: 
	=====================================
	2020-06-19 11:08:13 0x7f208129c700 INNODB MONITOR OUTPUT
	=====================================
	Per second averages calculated from the last 52 seconds
	-----------------
	BACKGROUND THREAD
	-----------------
	srv_master_thread loops: 30561234 srv_active, 0 srv_shutdown, 5732165 srv_idle
	srv_master_thread log flush and writes: 36293336
	----------
	SEMAPHORES
	----------
	OS WAIT ARRAY INFO: reservation count 47543467
	OS WAIT ARRAY INFO: signal count 172241866
	RW-shared spins 0, rounds 197605813, OS waits 21135187
	RW-excl spins 0, rounds 1133630210, OS waits 13282221
	RW-sx spins 53839331, rounds 581663261, OS waits 6200154
	Spin rounds per wait: 197605813.00 RW-shared, 1133630210.00 RW-excl, 10.80 RW-sx
	------------------------
	LATEST DETECTED DEADLOCK
	------------------------
	2020-05-27 00:24:00 0x7f22232f2700
	...........................................
	*** WE ROLL BACK TRANSACTION (1)
	------------
	TRANSACTIONS
	------------
	Trx id counter 1010321789
	Purge done for trx s n:o < 1010321783 undo n:o < 0 state: running but idle
	History list length 36
	LIST OF TRANSACTIONS FOR EACH SESSION:
	.......................................
	0 lock struct(s), heap size 1136, 0 row lock(s)
	--------
	FILE I/O
	--------
	I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
	I/O thread 1 state: waiting for completed aio requests (log thread)
	I/O thread 2 state: waiting for completed aio requests (read thread)
	I/O thread 3 state: waiting for completed aio requests (read thread)
	I/O thread 4 state: waiting for completed aio requests (read thread)
	I/O thread 5 state: waiting for completed aio requests (read thread)
	I/O thread 6 state: waiting for completed aio requests (write thread)
	I/O thread 7 state: waiting for completed aio requests (write thread)
	I/O thread 8 state: waiting for completed aio requests (write thread)
	I/O thread 9 state: waiting for completed aio requests (write thread)
	Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
	 ibuf aio reads:, log i/o's:, sync i/o's:
	Pending flushes (fsync) log: 0; buffer pool: 0
	45721444 OS file reads, 1475856729 OS file writes, 757923041 OS fsyncs
	0.08 reads/s, 16384 avg bytes/read, 68.25 writes/s, 30.13 fsyncs/s
	-------------------------------------
	INSERT BUFFER AND ADAPTIVE HASH INDEX
	-------------------------------------
	Ibuf: size 1, free list len 4023, seg size 4025, 3884298 merges
	merged operations:
	 insert 7606800, delete mark 96022072, delete 3963975
	discarded operations:
	 insert 0, delete mark 0, delete 0
	Hash table size 2656321, node heap has 11 buffer(s)
	Hash table size 2656321, node heap has 68 buffer(s)
	Hash table size 2656321, node heap has 3 buffer(s)
	Hash table size 2656321, node heap has 76 buffer(s)
	Hash table size 2656321, node heap has 2 buffer(s)
	Hash table size 2656321, node heap has 116 buffer(s)
	Hash table size 2656321, node heap has 11 buffer(s)
	Hash table size 2656321, node heap has 2 buffer(s)
	78.73 hash searches/s, 82.08 non-hash searches/s
	---
	LOG
	---
	Log sequence number 998032367021
	Log flushed up to   998032367003
	Pages flushed up to 998032292518
	Last checkpoint at  998032288574
	0 pending log flushes, 0 pending chkp writes
	496484335 log i/o's done, 15.81 log i/o's/second
	----------------------
	BUFFER POOL AND MEMORY
	----------------------
	Total large memory allocated 8795455488
	Dictionary memory allocated 3546880
	Buffer pool size   524288
	Free buffers       17940
	Database pages     506059
	Old database pages 186767
	Modified db pages  302
	Pending reads      0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 34630867, not young 1710281878
	0.63 youngs/s, 0.00 non-youngs/s
	Pages read 45692965, created 19940701, written 905126930
	0.08 reads/s, 0.37 creates/s, 49.38 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 1 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 506059, unzip_LRU len: 0
	I/O sum[5100]:cur[0], unzip sum[0]:cur[0]
	----------------------
	INDIVIDUAL BUFFER POOL INFO
	----------------------
	---BUFFER POOL 0
	Buffer pool size   262144
	Free buffers       9125
	Database pages     252876
	Old database pages 93327
	Modified db pages  164
	Pending reads      0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 17684719, not young 845255454
	0.44 youngs/s, 0.00 non-youngs/s
	Pages read 22581889, created 9983998, written 453915338
	0.08 reads/s, 0.25 creates/s, 26.71 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 1 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 252876, unzip_LRU len: 0
	I/O sum[2550]:cur[0], unzip sum[0]:cur[0]
	---BUFFER POOL 1
	Buffer pool size   262144
	Free buffers       8815
	Database pages     253183
	Old database pages 93440
	Modified db pages  138
	Pending reads      0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 16946148, not young 865026424
	0.19 youngs/s, 0.00 non-youngs/s
	Pages read 23111076, created 9956703, written 451211592
	0.00 reads/s, 0.12 creates/s, 22.67 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 253183, unzip_LRU len: 0
	I/O sum[2550]:cur[0], unzip sum[0]:cur[0]
	--------------
	ROW OPERATIONS
	--------------
	0 queries inside InnoDB, 0 queries in queue
	0 read views open inside InnoDB
	Process ID=1492, Main thread ID=139778483975936, state: sleeping
	Number of rows inserted 877429068, updated 142953641, deleted 400983711, read 64101137838
	12.48 inserts/s, 3.08 updates/s, 0.17 deletes/s, 49.44 reads/s
	----------------------------
	END OF INNODB MONITOR OUTPUT
	============================

	1 row in set (0.01 sec)

