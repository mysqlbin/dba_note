
1. MySQL 版本
2. 基于组提交的并行复制
  主库配置
  从库配置	
  初始化数据
  解析主库binlog，查看组提交的分组情况

3. 基于writeset的并行复制 
  主库配置
  从库配置	
  初始化数据
  解析主库binlog，查看基于writeset的分组情况
  
4. 基于组提交和writeset的并行复制比较

1. MySQL 版本：
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.24-log |
	+------------+
	1 row in set (0.00 sec)

	
2. 基于组提交的并行复制

	主库配置：
		mysql> show global variables like 'binlog_group_commit_sync_delay';
		+--------------------------------+-------+
		| Variable_name                  | Value |
		+--------------------------------+-------+
		| binlog_group_commit_sync_delay | 100   |
		+--------------------------------+-------+
		1 row in set (0.00 sec)

		mysql> show global variables like 'binlog_group_commit_sync_no_delay_count';
		+-----------------------------------------+-------+
		| Variable_name                           | Value |
		+-----------------------------------------+-------+
		| binlog_group_commit_sync_no_delay_count | 10    |
		+-----------------------------------------+-------+
		1 row in set (0.00 sec)

		set global binlog_transaction_dependency_tracking = 'COMMIT_ORDER';
		set global transaction_write_set_extraction = OFF;
		set global binlog_group_commit_sync_delay=100;
		set global binlog_group_commit_sync_no_delay_count=10;

	从库配置：
		mysql> show global variables like 'slave_parallel_type';
		+---------------------+---------------+
		| Variable_name       | Value         |
		+---------------------+---------------+
		| slave_parallel_type | LOGICAL_CLOCK |
		+---------------------+---------------+
		1 row in set (0.01 sec)

		mysql> show global variables like 'slave_parallel_workers';
		+------------------------+-------+
		| Variable_name          | Value |
		+------------------------+-------+
		| slave_parallel_workers | 4     |
		+------------------------+-------+
		1 row in set (0.00 sec)




	初始化数据:
		create database tempdb;
		use tempdb;
		create table person(id int not null auto_increment primary key,name int);

		insert into person(name) values(1);
		insert into person(name) values(2);
		insert into person(name) values(3);
		insert into person(name) values(5);

	解析主库binlog，查看组提交的分组情况：

	shell> mysqlbinlog --no-defaults mysql-bin.000355 |grep last_commit
	#191015 18:49:11 server id 17  end_log_pos 259 CRC32 0xac687d83 	Anonymous_GTID	last_committed=0	sequence_number=1	rbr_only=yes
	#191015 18:49:11 server id 17  end_log_pos 623 CRC32 0x4046a442 	Anonymous_GTID	last_committed=1	sequence_number=2	rbr_only=yes
	#191015 18:49:13 server id 17  end_log_pos 1057 CRC32 0x51cde9a8 	Anonymous_GTID	last_committed=2	sequence_number=3	rbr_only=yes
	#191015 18:49:14 server id 17  end_log_pos 1421 CRC32 0xd88afac3 	Anonymous_GTID	last_committed=3	sequence_number=4	rbr_only=yes
	#191015 18:49:23 server id 17  end_log_pos 1785 CRC32 0xea470ec9 	Anonymous_GTID	last_committed=4	sequence_number=5	rbr_only=yes
	#191015 18:49:23 server id 17  end_log_pos 2051 CRC32 0xd5f30d0a 	Anonymous_GTID	last_committed=5	sequence_number=6	rbr_only=yes
	#191015 18:49:23 server id 17  end_log_pos 2317 CRC32 0xe2b2b86a 	Anonymous_GTID	last_committed=6	sequence_number=7	rbr_only=yes
	#191015 18:49:23 server id 17  end_log_pos 2583 CRC32 0x0e105ea3 	Anonymous_GTID	last_committed=7	sequence_number=8	rbr_only=yes
	#191015 18:49:24 server id 17  end_log_pos 2849 CRC32 0xb49bfe90 	Anonymous_GTID	last_committed=8	sequence_number=9	rbr_only=yes
	#191015 18:49:24 server id 17  end_log_pos 3213 CRC32 0x93a6095f 	Anonymous_GTID	last_committed=9	sequence_number=10	rbr_only=yes

	shell> mysqlbinlog --no-defaults -vvv --base64-output='decode-rows' mysql-bin.000355

	# at 1720
	#191015 18:49:23 server id 17  end_log_pos 1785 CRC32 0xea470ec9 	Anonymous_GTID	last_committed=4	sequence_number=5	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 1785
	#191015 18:49:23 server id 17  end_log_pos 1859 CRC32 0x09df35e7 	Query	thread_id=131348	exec_time=0	error_code=0
	SET TIMESTAMP=1571136563/*!*/;
	BEGIN
	/*!*/;
	# at 1859
	#191015 18:49:23 server id 17  end_log_pos 1911 CRC32 0x9ff3b65e 	Table_map: `tempdb`.`person` mapped to number 624
	# at 1911
	#191015 18:49:23 server id 17  end_log_pos 1955 CRC32 0xd4d6fdba 	Write_rows: table id 624 flags: STMT_END_F
	### INSERT INTO `tempdb`.`person`
	### SET
	###   @1=49 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
	# at 1955
	#191015 18:49:23 server id 17  end_log_pos 1986 CRC32 0xe9b808a9 	Xid = 39944228
	COMMIT/*!*/;
	# at 1986
	#191015 18:49:23 server id 17  end_log_pos 2051 CRC32 0xd5f30d0a 	Anonymous_GTID	last_committed=5	sequence_number=6	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 2051
	#191015 18:49:23 server id 17  end_log_pos 2125 CRC32 0x2334ae02 	Query	thread_id=131348	exec_time=0	error_code=0
	SET TIMESTAMP=1571136563/*!*/;
	BEGIN
	/*!*/;
	# at 2125
	#191015 18:49:23 server id 17  end_log_pos 2177 CRC32 0x751f0775 	Table_map: `tempdb`.`person` mapped to number 624
	# at 2177
	#191015 18:49:23 server id 17  end_log_pos 2221 CRC32 0xbbdd8860 	Write_rows: table id 624 flags: STMT_END_F
	### INSERT INTO `tempdb`.`person`
	### SET
	###   @1=50 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=2 /* INT meta=0 nullable=1 is_null=0 */
	# at 2221
	#191015 18:49:23 server id 17  end_log_pos 2252 CRC32 0xc9f98882 	Xid = 39944229
	COMMIT/*!*/;
	# at 2252
	#191015 18:49:23 server id 17  end_log_pos 2317 CRC32 0xe2b2b86a 	Anonymous_GTID	last_committed=6	sequence_number=7	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 2317
	#191015 18:49:23 server id 17  end_log_pos 2391 CRC32 0x9b7eaa3c 	Query	thread_id=131348	exec_time=0	error_code=0
	SET TIMESTAMP=1571136563/*!*/;
	BEGIN
	/*!*/;
	# at 2391
	#191015 18:49:23 server id 17  end_log_pos 2443 CRC32 0xdf95de97 	Table_map: `tempdb`.`person` mapped to number 624
	# at 2443
	#191015 18:49:23 server id 17  end_log_pos 2487 CRC32 0x69380251 	Write_rows: table id 624 flags: STMT_END_F
	### INSERT INTO `tempdb`.`person`
	### SET
	###   @1=51 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=3 /* INT meta=0 nullable=1 is_null=0 */
	# at 2487
	#191015 18:49:23 server id 17  end_log_pos 2518 CRC32 0x2e65b013 	Xid = 39944230
	COMMIT/*!*/;
	# at 2518
	#191015 18:49:23 server id 17  end_log_pos 2583 CRC32 0x0e105ea3 	Anonymous_GTID	last_committed=7	sequence_number=8	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 2583
	#191015 18:49:23 server id 17  end_log_pos 2657 CRC32 0x1c5b131e 	Query	thread_id=131348	exec_time=0	error_code=0
	SET TIMESTAMP=1571136563/*!*/;
	BEGIN
	/*!*/;
	# at 2657
	#191015 18:49:23 server id 17  end_log_pos 2709 CRC32 0xfb7bb2f0 	Table_map: `tempdb`.`person` mapped to number 624
	# at 2709
	#191015 18:49:23 server id 17  end_log_pos 2753 CRC32 0x48a6b241 	Write_rows: table id 624 flags: STMT_END_F
	### INSERT INTO `tempdb`.`person`
	### SET
	###   @1=52 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=5 /* INT meta=0 nullable=1 is_null=0 */
	# at 2753
	#191015 18:49:23 server id 17  end_log_pos 2784 CRC32 0x0c11d341 	Xid = 39944231
	COMMIT/*!*/;



3. 基于writeset的并行复制:

	主库配置
		
	  
		set global transaction_write_set_extraction = 'XXHASH64';
		set global binlog_transaction_dependency_tracking = 'WRITESET';
		set global binlog_group_commit_sync_delay=0;
		set global binlog_group_commit_sync_no_delay_count=0;
		
		区分基于组提交的并行复制
			set global binlog_transaction_dependency_tracking = 'COMMIT_ORDER';
			set global transaction_write_set_extraction = OFF;
			set global binlog_group_commit_sync_delay=100;
			set global binlog_group_commit_sync_no_delay_count=10;

		
	从库配置

		mysql> show global variables like 'slave_parallel_type';
		+---------------------+---------------+
		| Variable_name       | Value         |
		+---------------------+---------------+
		| slave_parallel_type | LOGICAL_CLOCK |
		+---------------------+---------------+
		1 row in set (0.01 sec)

		mysql> show global variables like 'slave_parallel_workers';
		+------------------------+-------+
		| Variable_name          | Value |
		+------------------------+-------+
		| slave_parallel_workers | 4     |
		+------------------------+-------+
		1 row in set (0.00 sec)
		
		
	初始化数据
		create database tempdb;
		use tempdb;
		create table person(id int not null auto_increment primary key,name int);

		insert into person(name) values(1);
		insert into person(name) values(2);
		insert into person(name) values(3);
		insert into person(name) values(5);
		
		
	解析主库binlog，查看基于writeset的分组情况

	shell> mysqlbinlog --no-defaults mysql-bin.000353 |grep last_commit
	#191015 18:31:11 server id 17  end_log_pos 259 CRC32 0x9ca9f32d 	Anonymous_GTID	last_committed=0	sequence_number=1	rbr_only=yes
	#191015 18:31:11 server id 17  end_log_pos 623 CRC32 0x70872aec 	Anonymous_GTID	last_committed=1	sequence_number=2	rbr_only=yes
	#191015 18:31:12 server id 17  end_log_pos 1057 CRC32 0xadd1e0cd 	Anonymous_GTID	last_committed=2	sequence_number=3	rbr_only=yes
	#191015 18:31:13 server id 17  end_log_pos 1421 CRC32 0x58ac4cbb 	Anonymous_GTID	last_committed=1	sequence_number=4	rbr_only=yes
	#191015 18:31:13 server id 17  end_log_pos 1687 CRC32 0x0fec29d1 	Anonymous_GTID	last_committed=1	sequence_number=5	rbr_only=yes
	#191015 18:31:13 server id 17  end_log_pos 1953 CRC32 0xd3bb0c59 	Anonymous_GTID	last_committed=1	sequence_number=6	rbr_only=yes
	#191015 18:31:13 server id 17  end_log_pos 2219 CRC32 0x6ab8d40e 	Anonymous_GTID	last_committed=1	sequence_number=7	rbr_only=yes
	#191015 18:31:13 server id 17  end_log_pos 2485 CRC32 0x8be7238f 	Anonymous_GTID	last_committed=3	sequence_number=8	rbr_only=yes


	shell> mysqlbinlog --no-defaults -vvv --base64-output='decode-rows' mysql-bin.000346 > 346.sql

	#191015 18:31:11 server id 17  end_log_pos 623 CRC32 0x70872aec 	Anonymous_GTID	last_committed=1	sequence_number=2	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 623
	#191015 18:31:11 server id 17  end_log_pos 697 CRC32 0xd5bd9bba 	Query	thread_id=130945	exec_time=0	error_code=0
	SET TIMESTAMP=1571135471/*!*/;
	BEGIN
	/*!*/;
	# at 697
	#191015 18:31:11 server id 17  end_log_pos 765 CRC32 0xb04fdb89 	Table_map: `zabbix`.`profiles` mapped to number 114
	# at 765
	#191015 18:31:11 server id 17  end_log_pos 961 CRC32 0xfca0db97 	Update_rows: table id 114 flags: STMT_END_F
	### UPDATE `zabbix`.`profiles`
	### WHERE
	###   @1=359 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @3='web.screens.stime' /* VARSTRING(288) meta=288 nullable=0 is_null=0 */
	###   @4=813 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @6=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @7='20191015113105' /* VARSTRING(765) meta=765 nullable=0 is_null=0 */
	###   @8='' /* VARSTRING(288) meta=288 nullable=0 is_null=0 */
	###   @9=3 /* INT meta=0 nullable=0 is_null=0 */
	### SET
	###   @1=359 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @3='web.screens.stime' /* VARSTRING(288) meta=288 nullable=0 is_null=0 */
	###   @4=813 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @5=0 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @6=0 /* INT meta=0 nullable=0 is_null=0 */
	###   @7='20191015113111' /* VARSTRING(765) meta=765 nullable=0 is_null=0 */
	###   @8='' /* VARSTRING(288) meta=288 nullable=0 is_null=0 */
	###   @9=3 /* INT meta=0 nullable=0 is_null=0 */
	# at 961
	#191015 18:31:11 server id 17  end_log_pos 992 CRC32 0x71a83a16 	Xid = 39933652
	COMMIT/*!*/;
	# at 992
	#191015 18:31:12 server id 17  end_log_pos 1057 CRC32 0xadd1e0cd 	Anonymous_GTID	last_committed=2	sequence_number=3	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 1057
	#191015 18:31:12 server id 17  end_log_pos 1131 CRC32 0x67de1a47 	Query	thread_id=130946	exec_time=0	error_code=0
	SET TIMESTAMP=1571135472/*!*/;
	BEGIN
	/*!*/;
	# at 1131
	#191015 18:31:12 server id 17  end_log_pos 1189 CRC32 0x75041724 	Table_map: `zabbix`.`sessions` mapped to number 110
	# at 1189
	#191015 18:31:12 server id 17  end_log_pos 1325 CRC32 0x1babc521 	Update_rows: table id 110 flags: STMT_END_F
	### UPDATE `zabbix`.`sessions`
	### WHERE
	###   @1='e20f44bc9dabaa510c74e78367838977' /* VARSTRING(96) meta=96 nullable=0 is_null=0 */
	###   @2=1 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @3=1571135465 /* INT meta=0 nullable=0 is_null=0 */
	###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
	### SET
	###   @1='e20f44bc9dabaa510c74e78367838977' /* VARSTRING(96) meta=96 nullable=0 is_null=0 */
	###   @2=1 /* LONGINT meta=0 nullable=0 is_null=0 */
	###   @3=1571135472 /* INT meta=0 nullable=0 is_null=0 */
	###   @4=0 /* INT meta=0 nullable=0 is_null=0 */
	# at 1325
	#191015 18:31:12 server id 17  end_log_pos 1356 CRC32 0x7e418bf8 	Xid = 39933668
	COMMIT/*!*/;
	# at 1356
	#191015 18:31:13 server id 17  end_log_pos 1421 CRC32 0x58ac4cbb 	Anonymous_GTID	last_committed=1	sequence_number=4	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 1421
	#191015 18:31:13 server id 17  end_log_pos 1495 CRC32 0xdb29ec52 	Query	thread_id=130900	exec_time=0	error_code=0
	SET TIMESTAMP=1571135473/*!*/;
	BEGIN
	/*!*/;
	# at 1495
	#191015 18:31:13 server id 17  end_log_pos 1547 CRC32 0x2612a326 	Table_map: `tempdb`.`person` mapped to number 624
	# at 1547
	#191015 18:31:13 server id 17  end_log_pos 1591 CRC32 0x0d3d7239 	Write_rows: table id 624 flags: STMT_END_F
	### INSERT INTO `tempdb`.`person`
	### SET
	###   @1=45 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
	# at 1591
	#191015 18:31:13 server id 17  end_log_pos 1622 CRC32 0x70b33999 	Xid = 39933690
	COMMIT/*!*/;
	# at 1622
	#191015 18:31:13 server id 17  end_log_pos 1687 CRC32 0x0fec29d1 	Anonymous_GTID	last_committed=1	sequence_number=5	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 1687
	#191015 18:31:13 server id 17  end_log_pos 1761 CRC32 0x5c0c5570 	Query	thread_id=130900	exec_time=0	error_code=0
	SET TIMESTAMP=1571135473/*!*/;
	BEGIN
	/*!*/;
	# at 1761
	#191015 18:31:13 server id 17  end_log_pos 1813 CRC32 0x4bf86d2d 	Table_map: `tempdb`.`person` mapped to number 624
	# at 1813
	#191015 18:31:13 server id 17  end_log_pos 1857 CRC32 0x8a7d778e 	Write_rows: table id 624 flags: STMT_END_F
	### INSERT INTO `tempdb`.`person`
	### SET
	###   @1=46 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=2 /* INT meta=0 nullable=1 is_null=0 */
	# at 1857
	#191015 18:31:13 server id 17  end_log_pos 1888 CRC32 0x329bef80 	Xid = 39933691
	COMMIT/*!*/;
	# at 1888
	#191015 18:31:13 server id 17  end_log_pos 1953 CRC32 0xd3bb0c59 	Anonymous_GTID	last_committed=1	sequence_number=6	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 1953
	#191015 18:31:13 server id 17  end_log_pos 2027 CRC32 0xb59a714f 	Query	thread_id=130900	exec_time=0	error_code=0
	SET TIMESTAMP=1571135473/*!*/;
	BEGIN
	/*!*/;
	# at 2027
	#191015 18:31:13 server id 17  end_log_pos 2079 CRC32 0xc51cdd8a 	Table_map: `tempdb`.`person` mapped to number 624
	# at 2079
	#191015 18:31:13 server id 17  end_log_pos 2123 CRC32 0x6c1ba6e7 	Write_rows: table id 624 flags: STMT_END_F
	### INSERT INTO `tempdb`.`person`
	### SET
	###   @1=47 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=3 /* INT meta=0 nullable=1 is_null=0 */
	# at 2123
	#191015 18:31:13 server id 17  end_log_pos 2154 CRC32 0xcd19e937 	Xid = 39933692
	COMMIT/*!*/;
	# at 2154
	#191015 18:31:13 server id 17  end_log_pos 2219 CRC32 0x6ab8d40e 	Anonymous_GTID	last_committed=1	sequence_number=7	rbr_only=yes
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
	# at 2219
	#191015 18:31:13 server id 17  end_log_pos 2293 CRC32 0xceadcaab 	Query	thread_id=130900	exec_time=0	error_code=0
	SET TIMESTAMP=1571135473/*!*/;
	BEGIN
	/*!*/;
	# at 2293
	#191015 18:31:13 server id 17  end_log_pos 2345 CRC32 0xfd473a12 	Table_map: `tempdb`.`person` mapped to number 624
	# at 2345
	#191015 18:31:13 server id 17  end_log_pos 2389 CRC32 0x2b595c33 	Write_rows: table id 624 flags: STMT_END_F
	### INSERT INTO `tempdb`.`person`
	### SET
	###   @1=48 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=5 /* INT meta=0 nullable=1 is_null=0 */
	# at 2389
	#191015 18:31:13 server id 17  end_log_pos 2420 CRC32 0x710c59c0 	Xid = 39933693
	COMMIT/*!*/;

	
4. 基于组提交和writeset的并行复制比较：

	组提交：
	
		#191015 18:49:11 server id 17  end_log_pos 623 CRC32 0x4046a442 	Anonymous_GTID	last_committed=1	sequence_number=2	rbr_only=yes
		#191015 18:49:13 server id 17  end_log_pos 1057 CRC32 0x51cde9a8 	Anonymous_GTID	last_committed=2	sequence_number=3	rbr_only=yes
		#191015 18:49:14 server id 17  end_log_pos 1421 CRC32 0xd88afac3 	Anonymous_GTID	last_committed=3	sequence_number=4	rbr_only=yes
		#191015 18:49:23 server id 17  end_log_pos 1785 CRC32 0xea470ec9 	Anonymous_GTID	last_committed=4	sequence_number=5	rbr_only=yes
		
	writeset:
		#191015 18:31:11 server id 17  end_log_pos 623 CRC32 0x70872aec 	Anonymous_GTID	last_committed=1	sequence_number=2	rbr_only=yes
		#191015 18:31:12 server id 17  end_log_pos 1057 CRC32 0xadd1e0cd 	Anonymous_GTID	last_committed=2	sequence_number=3	rbr_only=yes
		#191015 18:31:13 server id 17  end_log_pos 1421 CRC32 0x58ac4cbb 	Anonymous_GTID	last_committed=1	sequence_number=4	rbr_only=yes
		#191015 18:31:13 server id 17  end_log_pos 1687 CRC32 0x0fec29d1 	Anonymous_GTID	last_committed=1	sequence_number=5	rbr_only=yes
		#191015 18:31:13 server id 17  end_log_pos 1953 CRC32 0xd3bb0c59 	Anonymous_GTID	last_committed=1	sequence_number=6	rbr_only=yes
		
	基于组提交的并行复制的 last_commit 是有序的，而 基于writeset的并行复制的 last_commit并一定是有序的。
	
	各个insert是可以并行执行的，所以它们被分到了同个组(last_committed相同）；last_committed，sequence_number，

	coordinator 就是原来的 sql_thread, 不再直接更新数据了，只负责读取中转日志和分发事务给worker；
    worker 线程 真正更新日志；
	
	
	