
1. binary log、表结构和数据初始化
2. 更新记录的 event
3. 通过 mysqlbinlog 查看事务的 binlog


1. binary log、表结构和数据初始化

	root@mysqldb 14:54:  [(none)]> show binlog events in 'mysql-bin.000007';
	+------------------+-----+----------------+-----------+-------------+---------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                        |
	+------------------+-----+----------------+-----------+-------------+---------------------------------------------+
	| mysql-bin.000007 |   4 | Format_desc    |    330640 |         123 | Server ver: 5.7.22-log, Binlog ver: 4       |
	| mysql-bin.000007 | 123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5594 |
	+------------------+-----+----------------+-----------+-------------+---------------------------------------------+
	2 rows in set (0.00 sec)

	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB;

	insert into t values(1,1,'2018-11-13');
	insert into t values(2,2,'2018-11-12');

	update t set a=3 where id=1;
	

2. 更新记录的 event
	root@mysqldb 18:38:  [(none)]> show binlog events in 'mysql-bin.000008' from 764 limit 5;
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+
	| Log_name         | Pos  | Event_type  | Server_id | End_log_pos | Info                                                                 |
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+
	| mysql-bin.000008 |  764 | Gtid        |    330640 |         829 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5603' |
	| mysql-bin.000008 |  829 | Query       |    330640 |         908 | BEGIN                                                                |
	| mysql-bin.000008 |  908 | Table_map   |    330640 |         962 | table_id: 562 (niuniuh5_db.t)                                        |
	| mysql-bin.000008 |  962 | Update_rows |    330640 |        1024 | table_id: 562 flags: STMT_END_F                                      |
	| mysql-bin.000008 | 1024 | Xid         |    330640 |        1055 | COMMIT /* xid=36102 */                                               |
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+
	5 rows in set (0.00 sec)	
	
	1. 第一行是 gtid event
		
	2. 第二行是一个 query event
		不能正确的表示DML语句执行的时间. 语句部分记录的是 "BEGIN"
		BEGIN，跟第五行的 COMMIT对应，表示中间是一个事务；
		
    3. 两个event 替换了 SQL的原始语句
        1. Table_map event，用于说明接下来要操作的表是 test 库的表 t;
        2. Update_rows event，用于定义更新操作的行为。
    4. 第五行： COMMIT表示事务提交成功之后写入的状态， XID 表示事务被正确提交了。
	 
	
3. 通过 mysqlbinlog 查看事务的 binlog
	mysqlbinlog -vv --base64-output='decode-rows' --start-position=764 mysql-bin.000008

	# at 764
	#200307 15:01:33 server id 330640  end_log_pos 829 CRC32 0x0a8ab72f 	GTID	last_committed=2	sequence_number=3	rbr_only=yes  
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5603'/*!*/;															  # gtid event
	# at 829
	#200307 15:01:33 server id 330640  end_log_pos 908 CRC32 0x4ecb5036 	Query	thread_id=412	exec_time=0	error_code=0              # query event
	SET TIMESTAMP=1583564493/*!*/;
	BEGIN
	/*!*/;
	# at 908
	#200307 15:01:33 server id 330640  end_log_pos 962 CRC32 0x808e658a 	Table_map: `niuniuh5_db`.`t` mapped to number 562             # map event
	# at 962
	#200307 15:01:33 server id 330640  end_log_pos 1024 CRC32 0x2ff91084 	Update_rows: table id 562 flags: STMT_END_F                   # update event
	### UPDATE `niuniuh5_db`.`t`
	### WHERE
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=1 /* INT meta=0 nullable=1 is_null=0 */
	###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
	### SET
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2=3 /* INT meta=0 nullable=1 is_null=0 */
	###   @3=1542038400 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
	# at 1024
	#200307 15:01:33 server id 330640  end_log_pos 1055 CRC32 0x802e7340 	Xid = 36102                                                  # xid event 
	COMMIT/*!*/;
	# at 1055

	
	1. server id  330640 表示这个事务是在 server_id=330640 的这个库上执行的。
	2. 参数 binlog_checksum = CRC32 表示每个event都有CRC32的值.
	3. -vv参数是为了把内容都解析出来, 比如 各个字段的值：   @1=1, @2=1, @3=1542038400
	4. 参数 binlog_row_image 的默认配置是 FULL，因此 Update_rows 里面，包含了更新前的值和更新后的值。
		如果把 binlog_row_image 设置为 MINIMAL，则只会记录必要的信息，在这个例子里，就是只会记录 id=1, a=3 这个信息。
		# 相关验证，参考笔记 《2020-03-09-binlog-MINIMAL.sql》
	5. Xid event：表示事务被正确提交了.
	6. row格式下不会有主备删除不同行记录的问题：
		binlog 里面记录了真实删除行的主键 id， binlog 传到备库去的时候，会删除 id=1 的行，不会有主备删除不同行的问题。
		
