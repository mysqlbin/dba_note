
1. 参数介绍
2. 验证binlog开启记录原始的SQL和没有开启记录原始的SQL所占用的磁盘空间对比
	2.1 初始化表结构和制造数据的存储过程
	2.2 binlog_rows_query_log_events=OFF
	2.3 binlog_rows_query_log_events=ON
	2.4 小结
3. 未完成


1. 参数介绍
	binlog_rows_query_log_events =1 
		在row模式下..开启该参数,将把sql语句打印到binlog日志里面.默认是0(off);
		虽然将语句放入了binlog,但不会执行这个sql,就相当于注释一样.但对于dba来说,在查看binlog的时候,很有用处.
		-- 记录SQL的原始语句。
		
	http://blog.itpub.net/20892230/viewspace-2129567/    binlog很有用的2个参数binlog_rows_query_log_events和binlog_row_image

	https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events





	This system variable affects row-based logging only. 
	When enabled, it causes the server to write informational log events such as row query log events into its binary log. 
	This information can be used for debugging and related purposes, such as obtaining the original query issued on the source when it cannot be reconstructed from the row updates.

	此系统变量仅影响基于行的日志记录。 
	启用后，它将导致服务器将诸如行查询日志事件之类的信息日志事件写入其二进制日志。 
	此信息可用于调试和相关目的，例如，当无法从行更新中重建原始查询时，获取原始查询。

	These informational events are normally ignored by MySQL programs reading the binary log and so cause no issues when replicating or restoring from backup. 
	To view them, increase the verbosity level by using mysqlbinlog s --verbose option twice, either as -vv or --verbose --verbose.

	这些信息事件通常被读取二进制日志的MySQL程序忽略，因此从备份复制或还原时不会引起任何问题。 
	要查看它们，请通过两次使用mysqlbinlog的--verbose选项（-vv或--verbose --verbose）来提高详细程度。



2. 验证binlog开启记录原始的SQL和没有开启记录原始的SQL所占用的磁盘空间对比


2.1 初始化表结构和制造数据的存储过程
	
	drop table if exists t_20201030;
	CREATE TABLE `t_20201030` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `id_card` varchar(32) not NULL default '',
	  `test1` text COMMENT '',
	  `test2` text COMMENT '',
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB;
	
	drop procedure  if exists t_20201030;
	delimiter ;;
	create procedure t_20201030()
	begin
	  declare i int;
	  set i=1;
	  
	  while(i<=10000)do
		insert into t_20201030(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'));
		set i=i+1;
	  end while;

	end;;
	delimiter ;
	
	drop table if exists t_20201031;
	CREATE TABLE `t_20201031` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `id_card` varchar(32) not NULL default '',
	  `test1` text COMMENT '',
	  `test2` text COMMENT '',
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB;
	
	drop procedure  if exists t_20201031;
	delimiter ;;
	create procedure t_20201031()
	begin
	  declare i int;
	  set i=1;
	  
	  while(i<=10000)do
		insert into t_20201031(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'));
		set i=i+1;
	  end while;

	end;;
	delimiter ;




2.2 binlog_rows_query_log_events=OFF 

	show global variables like 'binlog_row_image';
	show global variables like 'binlog_format';
	show global variables like 'binlog_rows_query_log_events';
	show global variables like 'sync_binlog';
	show global variables like 'innodb_flush_log_at_trx_commit';

	mysql> show global variables like 'binlog_row_image';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| binlog_row_image | FULL  |
	+------------------+-------+
	1 row in set (0.03 sec)

	mysql> show global variables like 'binlog_format';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| binlog_format | ROW   |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'binlog_rows_query_log_events';
	+------------------------------+-------+
	| Variable_name                | Value |
	+------------------------------+-------+
	| binlog_rows_query_log_events | OFF   |
	+------------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'sync_binlog';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1000  |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)


	call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();
	call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();
	call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();
	call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();
	call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();call t_20201030();


	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000014 |  43131190 |
	| mysql-bin.000015 |     14871 |
	| mysql-bin.000016 |       217 |
	| mysql-bin.000017 |       217 |
	| mysql-bin.000018 |      2142 |
	| mysql-bin.000019 | 331200241 |
	| mysql-bin.000020 | 331202802 |
	| mysql-bin.000021 |       561 |
	| mysql-bin.000022 |      5345 |
	| mysql-bin.000023 | 172800401 |
	| mysql-bin.000024 | 288000241 |
	| mysql-bin.000025 | 288000194 |
	+------------------+-----------+
	12 rows in set (0.00 sec)

	mysql> FLUSH LOGS;
	Query OK, 0 rows affected (0.20 sec)

	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000014 |  43131190 |
	| mysql-bin.000015 |     14871 |
	| mysql-bin.000016 |       217 |
	| mysql-bin.000017 |       217 |
	| mysql-bin.000018 |      2142 |
	| mysql-bin.000019 | 331200241 |
	| mysql-bin.000020 | 331202802 |
	| mysql-bin.000021 |       561 |
	| mysql-bin.000022 |      5345 |
	| mysql-bin.000023 | 172800401 |
	| mysql-bin.000024 | 288000241 |
	| mysql-bin.000025 | 288000241 |
	| mysql-bin.000026 |       194 |
	+------------------+-----------+
	13 rows in set (0.00 sec)


	binlog文件：mysql-bin.000025 为 288000241 bytes = 274.6MB

	show binlog events in 'mysql-bin.000025' limit 10;

	mysql> show binlog events in 'mysql-bin.000025' limit 10;
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                    |
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------+
	| mysql-bin.000025 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                   |
	| mysql-bin.000025 | 123 | Previous_gtids |    330607 |         194 | 9e520b78-013c-11eb-a84c-0800271bf591:1-1950273                          |
	| mysql-bin.000025 | 194 | Gtid           |    330607 |         259 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:1950274' |
	| mysql-bin.000025 | 259 | Query          |    330607 |         338 | BEGIN                                                                   |
	| mysql-bin.000025 | 338 | Table_map      |    330607 |         408 | table_id: 116 (test_db.t_20201030)                                      |
	| mysql-bin.000025 | 408 | Write_rows     |    330607 |         739 | table_id: 116 flags: STMT_END_F                                         |
	| mysql-bin.000025 | 739 | Xid            |    330607 |         770 | COMMIT /* xid=5851321 */                                                |
	| mysql-bin.000025 | 770 | Gtid           |    330607 |         835 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:1950275' |
	| mysql-bin.000025 | 835 | Query          |    330607 |         914 | BEGIN                                                                   |
	| mysql-bin.000025 | 914 | Table_map      |    330607 |         984 | table_id: 116 (test_db.t_20201030)                                      |
	+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------+
	10 rows in set (0.01 sec)


	mysql> mysqlbinlog --no-defaults -vv --base64-output=decode-rows --start-position=338 --stop-position=770 mysql-bin.000025
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
	/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
	DELIMITER /*!*/;
	# at 338
	#201030 14:33:15 server id 330607  end_log_pos 408 CRC32 0xb8619f08 	Table_map: `test_db`.`t_20201030` mapped to number 116
	# at 408
	#201030 14:33:15 server id 330607  end_log_pos 739 CRC32 0xb99ffa09 	Write_rows: table id 116 flags: STMT_END_F
	### INSERT INTO `test_db`.`t_20201030`
	### SET
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2='92d88d2948' /* VARSTRING(128) meta=128 nullable=0 is_null=0 */
	###   @3=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @4=89 /* TINYINT meta=0 nullable=0 is_null=0 */
	###   @5='0204a91d706b6e60f4b42763842ff4' /* VARSTRING(128) meta=128 nullable=0 is_null=0 */
	###   @6='d3b4447ff9d7d19e07141e02e7c048df19754887cd3e3c95a89a17f5b16eeca3验证延迟从库消费1G的binlog大小需要多久' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
	###   @7='f2ec012c8324e89880e017eebe5e98f3dd72f8cb7c2292f743b33570f60f5609验证延迟从库消费1G的binlog大小需要多久' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
	###   @8=1604039595.652 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
	# at 739
	#201030 14:33:15 server id 330607  end_log_pos 770 CRC32 0x61245749 	Xid = 5851321
	COMMIT/*!*/;
	SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
	DELIMITER ;
	# End of log file
	/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;



2.3 set global binlog_rows_query_log_events=ON;

	show global variables like 'binlog_row_image';
	show global variables like 'binlog_format';
	show global variables like 'binlog_rows_query_log_events';
	show global variables like 'sync_binlog';
	show global variables like 'innodb_flush_log_at_trx_commit';

	mysql> show global variables like 'binlog_row_image';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| binlog_row_image | FULL  |
	+------------------+-------+
	1 row in set (0.01 sec)

	mysql> show global variables like 'binlog_format';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| binlog_format | ROW   |
	+---------------+-------+
	1 row in set (0.01 sec)

	mysql> show global variables like 'binlog_rows_query_log_events';
	+------------------------------+-------+
	| Variable_name                | Value |
	+------------------------------+-------+
	| binlog_rows_query_log_events | ON    |
	+------------------------------+-------+
	1 row in set (0.01 sec)



	mysql> show global variables like 'sync_binlog';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1000  |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)


	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000014 |  43131190 |
	| mysql-bin.000015 |     14871 |
	| mysql-bin.000016 |       217 |
	| mysql-bin.000017 |       217 |
	| mysql-bin.000018 |      2142 |
	| mysql-bin.000019 | 331200241 |
	| mysql-bin.000020 | 331202802 |
	| mysql-bin.000021 |       561 |
	| mysql-bin.000022 |      5345 |
	| mysql-bin.000023 | 172800401 |
	| mysql-bin.000024 | 288000241 |
	| mysql-bin.000025 | 288000241 |
	| mysql-bin.000026 |       241 |
	| mysql-bin.000027 |      2178 |
	| mysql-bin.000028 |       194 |
	+------------------+-----------+
	15 rows in set (0.00 sec)


	truncate table t_20201031;
	call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();
	call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();
	call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();
	call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();
	call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();call t_20201031();

	flush logs;
	show binary logs;
	select count(*) from test_db.t_20201031;


	mysql> flush logs;
	Query OK, 0 rows affected (0.48 sec)

	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000014 |  43131190 |
	| mysql-bin.000015 |     14871 |
	| mysql-bin.000016 |       217 |
	| mysql-bin.000017 |       217 |
	| mysql-bin.000018 |      2142 |
	| mysql-bin.000019 | 331200241 |
	| mysql-bin.000020 | 331202802 |
	| mysql-bin.000021 |       561 |
	| mysql-bin.000022 |      5345 |
	| mysql-bin.000023 | 172800401 |
	| mysql-bin.000024 | 288000241 |
	| mysql-bin.000025 | 288000241 |
	| mysql-bin.000026 |       241 |
	| mysql-bin.000027 |      2178 |
	| mysql-bin.000028 | 504500241 |
	| mysql-bin.000029 |       194 |
	+------------------+-----------+
	16 rows in set (0.00 sec)
	
	binlog文件：mysql-bin.000028 为 288000241 bytes = 481.6MB
	
	mysql> select count(*) from test_db.t_20201031;
	+----------+
	| count(*) |
	+----------+
	|   500000 |
	+----------+
	1 row in set (0.18 sec)


	mysql> show binlog events in 'mysql-bin.000028' limit 10;
	+------------------+------+----------------+-----------+-------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Log_name         | Pos  | Event_type     | Server_id | End_log_pos | Info                                                                                                                                                                                                                                                                                                                                                                                                                        |
	+------------------+------+----------------+-----------+-------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| mysql-bin.000028 |    4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                                                                                                                                                                                                                                                                                                                                                                       |
	| mysql-bin.000028 |  123 | Previous_gtids |    330607 |         194 | 9e520b78-013c-11eb-a84c-0800271bf591:1-2450276                                                                                                                                                                                                                                                                                                                                                                              |
	| mysql-bin.000028 |  194 | Gtid           |    330607 |         259 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:2450277'                                                                                                                                                                                                                                                                                                                                                     |
	| mysql-bin.000028 |  259 | Query          |    330607 |         338 | BEGIN                                                                                                                                                                                                                                                                                                                                                                                                                       |
	| mysql-bin.000028 |  338 | Rows_query     |    330607 |         771 | # insert into t_20201031(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'))                               |
	| mysql-bin.000028 |  771 | Table_map      |    330607 |         841 | table_id: 118 (test_db.t_20201031)                                                                                                                                                                                                                                                                                                                                                                                          |
	| mysql-bin.000028 |  841 | Write_rows     |    330607 |        1172 | table_id: 118 flags: STMT_END_F                                                                                                                                                                                                                                                                                                                                                                                             |
	| mysql-bin.000028 | 1172 | Xid            |    330607 |        1203 | COMMIT /* xid=7351581 */                                                                                                                                                                                                                                                                                                                                                                                                    |
	| mysql-bin.000028 | 1203 | Gtid           |    330607 |        1268 | SET @@SESSION.GTID_NEXT= '9e520b78-013c-11eb-a84c-0800271bf591:2450278'                                                                                                                                                                                                                                                                                                                                                     |
	| mysql-bin.000028 | 1268 | Query          |    330607 |        1347 | BEGIN                                                                                                                                                                                                                                                                                                                                                                                                                       |
	+------------------+------+----------------+-----------+-------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	10 rows in set (0.00 sec)


	shell> mysqlbinlog --no-defaults -vv --base64-output=decode-rows --start-position=338 --stop-position=1203 mysql-bin.000028
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
	/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
	DELIMITER /*!*/;
	# at 338
	#201030 15:14:01 server id 330607  end_log_pos 771 CRC32 0xdd65b6eb 	Rows_query
	# insert into t_20201031(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '验证延迟从库消费1G的binlog大小需要多久'))
		--记录了原始的SQL语句
	# at 771
	#201030 15:14:01 server id 330607  end_log_pos 841 CRC32 0x69fab325 	Table_map: `test_db`.`t_20201031` mapped to number 118
	# at 841
	#201030 15:14:01 server id 330607  end_log_pos 1172 CRC32 0x114a0671 	Write_rows: table id 118 flags: STMT_END_F
	### INSERT INTO `test_db`.`t_20201031`
	### SET
	###   @1=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @2='d67006470e' /* VARSTRING(128) meta=128 nullable=0 is_null=0 */
	###   @3=1 /* INT meta=0 nullable=0 is_null=0 */
	###   @4=35 /* TINYINT meta=0 nullable=0 is_null=0 */
	###   @5='dbcae115f0597706691d4d666ef812' /* VARSTRING(128) meta=128 nullable=0 is_null=0 */
	###   @6='fba15b43f065db0a822d73ada9c0c0c032bbd74fb865ec82bfc8db90cfca012e验证延迟从库消费1G的binlog大小需要多久' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
	###   @7='59996a6b2133a4bbd26cbd82bba725857898fe02b3cdd49ed7d7685b5fc709aa验证延迟从库消费1G的binlog大小需要多久' /* BLOB/TEXT meta=2 nullable=1 is_null=0 */
	###   @8=1604042041.158 /* TIMESTAMP(3) meta=3 nullable=0 is_null=0 */
	# at 1172
	#201030 15:14:01 server id 330607  end_log_pos 1203 CRC32 0x097af84a 	Xid = 7351581
	COMMIT/*!*/;
	SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
	DELIMITER ;
	# End of log file
	/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
	/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
	 


2.4 小结
	binlog_rows_query_log_events=OFF 
		binlog文件：mysql-bin.000025 为 288000241 bytes = 274.6MB
		
	binlog_rows_query_log_events=OFF 
		binlog文件：mysql-bin.000028 为 288000241 bytes = 481.6MB
	
	开启参数，额外增加了将近1倍的磁盘空间： select 481-275 = 206MB 
		 
		
		
3. 未完成	

	后期可以看下对磁盘IO的影响
	
	
	
set global 对当前会话并不是立即生效？
	是的，根据现在遇到的场景，需要退出这个会话再重新连接才生效。
	
	
	


