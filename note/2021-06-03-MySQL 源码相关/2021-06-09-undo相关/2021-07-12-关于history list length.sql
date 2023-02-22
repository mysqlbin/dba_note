
1. 初始化表结构的数据
2. 打断点查看执行流程
	2.1 delete 
	2.2 update 
	2.3 insert 
	2.4 rollback
3. 小结
4. 基本的函数调用栈
5. 相关参考


1. 初始化表结构的数据

	mysql> show create table t11;
	+-------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Table | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
	+-------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| t11   | CREATE TABLE `t11` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `t1` int(10) NOT NULL,
	  `t2` int(10) NOT NULL,
	  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
	  `status` int(10) NOT NULL,
	  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_order_no` (`order_no`),
	  KEY `idx_status` (`status`)
	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4       |
	+-------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)

	mysql> select * from t11;
	+----+----+----+----------+--------+---------------------+
	| ID | t1 | t2 | order_no | status | createtime          |
	+----+----+----+----------+--------+---------------------+
	|  1 |  1 |  1 | 123456   |      0 | 2020-04-23 17:28:45 |
	+----+----+----+----------+--------+---------------------+
	1 row in set (0.00 sec)



2. 打断点查看执行流程

2.1 delete 

	b trx_purge_add_update_undo_to_history
											begin;
											delete from t11 where id=1;
											commit;

				
	(gdb) bt
	#0  trx_purge_add_update_undo_to_history (trx=0x7f9a94e928c0, undo_ptr=0x7f9a94e92c08, undo_page=0x7f9a880c0000 "r\355^\207", update_rseg_history_len=true, n_added_logs=1, mtr=0x7f9a942b4b10) at /usr/local/mysql/storage/innobase/trx/trx0purge.cc:332
	#1  0x0000000001aed8e2 in trx_undo_update_cleanup (trx=0x7f9a94e928c0, undo_ptr=0x7f9a94e92c08, undo_page=0x7f9a880c0000 "r\355^\207", update_rseg_history_len=true, n_added_logs=1, mtr=0x7f9a942b4b10) at /usr/local/mysql/storage/innobase/trx/trx0undo.cc:1962
	#2  0x0000000001adc7d9 in trx_write_serialisation_history (trx=0x7f9a94e928c0, mtr=0x7f9a942b4b10) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:1651
	#3  0x0000000001addc93 in trx_commit_low (trx=0x7f9a94e928c0, mtr=0x7f9a942b4b10) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:2135
	#4  0x0000000001adde09 in trx_commit (trx=0x7f9a94e928c0) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:2205
	#5  0x0000000001ade50d in trx_commit_for_mysql (trx=0x7f9a94e928c0) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:2424
	#6  0x00000000018b81cd in innobase_commit_low (trx=0x7f9a94e928c0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:4255
	#7  0x00000000018b86b8 in innobase_commit (hton=0x4807fe0, thd=0x62ca310, commit_trx=true) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:4417
	#8  0x0000000000f28510 in ha_commit_low (thd=0x62ca310, all=true, run_after_commit=false) at /usr/local/mysql/sql/handler.cc:1903
	#9  0x00000000017de5bb in MYSQL_BIN_LOG::process_commit_stage_queue (this=0x2d246e0 <mysql_bin_log>, thd=0x62ca310, first=0x62ca310) at /usr/local/mysql/sql/binlog.cc:9039
	#10 0x00000000017dfe36 in MYSQL_BIN_LOG::ordered_commit (this=0x2d246e0 <mysql_bin_log>, thd=0x62ca310, all=true, skip_commit=false) at /usr/local/mysql/sql/binlog.cc:9736
	#11 0x00000000017ddf00 in MYSQL_BIN_LOG::commit (this=0x2d246e0 <mysql_bin_log>, thd=0x62ca310, all=true) at /usr/local/mysql/sql/binlog.cc:8851
	#12 0x0000000000f281ef in ha_commit_trans (thd=0x62ca310, all=true, ignore_global_read_lock=false) at /usr/local/mysql/sql/handler.cc:1799
	#13 0x000000000163277d in trans_commit (thd=0x62ca310) at /usr/local/mysql/sql/transaction.cc:239
	#14 0x0000000001537385 in mysql_execute_command (thd=0x62ca310, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4244
	#15 0x000000000153a849 in mysql_parse (thd=0x62ca310, parser_state=0x7f9a942b7690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x62ca310, com_data=0x7f9a942b7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x62ca310) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x54d4920) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x53285a0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007f9aa0cc1ea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007f9a9fb879fd in clone () from /lib64/libc.so.6


------------------------------------------------------------------------------------------------------------------------------------------------------------------

2.2 update 

	b trx_purge_add_update_undo_to_history

												begin;
												update t11 set createtime='2021-04-23 17:28:45' where id=1;
												commit;

	(gdb) bt
	#0  trx_purge_add_update_undo_to_history (trx=0x7f9a94e928c0, undo_ptr=0x7f9a94e92c08, undo_page=0x7f9a88090000 "\272\225", <incomplete sequence \364>, update_rseg_history_len=true, n_added_logs=1, mtr=0x7f9a942b4b10)
		at /usr/local/mysql/storage/innobase/trx/trx0purge.cc:332
	#1  0x0000000001aed8e2 in trx_undo_update_cleanup (trx=0x7f9a94e928c0, undo_ptr=0x7f9a94e92c08, undo_page=0x7f9a88090000 "\272\225", <incomplete sequence \364>, update_rseg_history_len=true, n_added_logs=1, mtr=0x7f9a942b4b10)
		at /usr/local/mysql/storage/innobase/trx/trx0undo.cc:1962
	#2  0x0000000001adc7d9 in trx_write_serialisation_history (trx=0x7f9a94e928c0, mtr=0x7f9a942b4b10) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:1651
	#3  0x0000000001addc93 in trx_commit_low (trx=0x7f9a94e928c0, mtr=0x7f9a942b4b10) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:2135
	#4  0x0000000001adde09 in trx_commit (trx=0x7f9a94e928c0) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:2205
	#5  0x0000000001ade50d in trx_commit_for_mysql (trx=0x7f9a94e928c0) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:2424
	#6  0x00000000018b81cd in innobase_commit_low (trx=0x7f9a94e928c0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:4255
	#7  0x00000000018b86b8 in innobase_commit (hton=0x4807fe0, thd=0x62ca310, commit_trx=true) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:4417
	#8  0x0000000000f28510 in ha_commit_low (thd=0x62ca310, all=true, run_after_commit=false) at /usr/local/mysql/sql/handler.cc:1903
	#9  0x00000000017de5bb in MYSQL_BIN_LOG::process_commit_stage_queue (this=0x2d246e0 <mysql_bin_log>, thd=0x62ca310, first=0x62ca310) at /usr/local/mysql/sql/binlog.cc:9039
	#10 0x00000000017dfe36 in MYSQL_BIN_LOG::ordered_commit (this=0x2d246e0 <mysql_bin_log>, thd=0x62ca310, all=true, skip_commit=false) at /usr/local/mysql/sql/binlog.cc:9736
	#11 0x00000000017ddf00 in MYSQL_BIN_LOG::commit (this=0x2d246e0 <mysql_bin_log>, thd=0x62ca310, all=true) at /usr/local/mysql/sql/binlog.cc:8851
	#12 0x0000000000f281ef in ha_commit_trans (thd=0x62ca310, all=true, ignore_global_read_lock=false) at /usr/local/mysql/sql/handler.cc:1799
	#13 0x000000000163277d in trans_commit (thd=0x62ca310) at /usr/local/mysql/sql/transaction.cc:239
	#14 0x0000000001537385 in mysql_execute_command (thd=0x62ca310, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4244
	#15 0x000000000153a849 in mysql_parse (thd=0x62ca310, parser_state=0x7f9a942b7690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#16 0x00000000015302d8 in dispatch_command (thd=0x62ca310, com_data=0x7f9a942b7df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#17 0x000000000152f20c in do_command (thd=0x62ca310) at /usr/local/mysql/sql/sql_parse.cc:1025
	#18 0x000000000165f7c8 in handle_connection (arg=0x54d4920) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#19 0x0000000001ce7612 in pfs_spawn_thread (arg=0x53285a0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#20 0x00007f9aa0cc1ea5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007f9a9fb879fd in clone () from /lib64/libc.so.6


2.3 insert 

	b trx_purge_add_update_undo_to_history
												begin;
												insert into t11(`t1`,`t2`,`order_no`,`status`,`createtime`) values(3,3,'123789',0,now());

	
												commit;
												
	没有走到断点trx_purge_add_update_undo_to_history的位置
	

2.4 rollback
	b trx_purge_add_update_undo_to_history
												begin;
												delete from t11 where id=2;		
												rollback;
	
	(gdb) bt
	#0  trx_purge_add_update_undo_to_history (trx=0x7effab629d08, undo_ptr=0x7effab62a050, undo_page=0x7effa3608000 ")~9Q", update_rseg_history_len=true, n_added_logs=1, mtr=0x7eff9409f2a0) at /usr/local/mysql/storage/innobase/trx/trx0purge.cc:332
	#1  0x0000000001aed8e2 in trx_undo_update_cleanup (trx=0x7effab629d08, undo_ptr=0x7effab62a050, undo_page=0x7effa3608000 ")~9Q", update_rseg_history_len=true, n_added_logs=1, mtr=0x7eff9409f2a0) at /usr/local/mysql/storage/innobase/trx/trx0undo.cc:1962
	#2  0x0000000001adc7d9 in trx_write_serialisation_history (trx=0x7effab629d08, mtr=0x7eff9409f2a0) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:1651
	#3  0x0000000001addc93 in trx_commit_low (trx=0x7effab629d08, mtr=0x7eff9409f2a0) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:2135
	#4  0x0000000001adde09 in trx_commit (trx=0x7effab629d08) at /usr/local/mysql/storage/innobase/trx/trx0trx.cc:2205
	#5  0x0000000001ad0a27 in trx_rollback_finish (trx=0x7effab629d08) at /usr/local/mysql/storage/innobase/trx/trx0roll.cc:1157
	#6  0x0000000001ace19e in trx_rollback_to_savepoint_low (trx=0x7effab629d08, savept=0x0) at /usr/local/mysql/storage/innobase/trx/trx0roll.cc:126
	#7  0x0000000001ace4e5 in trx_rollback_for_mysql_low (trx=0x7effab629d08) at /usr/local/mysql/storage/innobase/trx/trx0roll.cc:180
	#8  0x0000000001ace7cb in trx_rollback_low (trx=0x7effab629d08) at /usr/local/mysql/storage/innobase/trx/trx0roll.cc:212
	#9  0x0000000001aceb20 in trx_rollback_for_mysql (trx=0x7effab629d08) at /usr/local/mysql/storage/innobase/trx/trx0roll.cc:289
	#10 0x00000000018b89e2 in innobase_rollback (hton=0x4db7fe0, thd=0x6821c50, rollback_trx=true) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:4521
	#11 0x0000000000f287c9 in ha_rollback_low (thd=0x6821c50, all=true) at /usr/local/mysql/sql/handler.cc:1976
	#12 0x00000000017ce8e6 in MYSQL_BIN_LOG::rollback (this=0x2d246e0 <mysql_bin_log>, thd=0x6821c50, all=true) at /usr/local/mysql/sql/binlog.cc:2376
	#13 0x0000000000f28a51 in ha_rollback_trans (thd=0x6821c50, all=true) at /usr/local/mysql/sql/handler.cc:2063
	#14 0x0000000001632bed in trans_rollback (thd=0x6821c50) at /usr/local/mysql/sql/transaction.cc:356
	#15 0x00000000015374ee in mysql_execute_command (thd=0x6821c50, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4274
	#16 0x000000000153a849 in mysql_parse (thd=0x6821c50, parser_state=0x7eff940a2690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#17 0x00000000015302d8 in dispatch_command (thd=0x6821c50, com_data=0x7eff940a2df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#18 0x000000000152f20c in do_command (thd=0x6821c50) at /usr/local/mysql/sql/sql_parse.cc:1025
	#19 0x000000000165f7c8 in handle_connection (arg=0x6668650) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#20 0x0000000001ce7612 in pfs_spawn_thread (arg=0x58d7b20) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#21 0x00007effbb516ea5 in start_thread () from /lib64/libpthread.so.0
	#22 0x00007effba3dc9fd in clone () from /lib64/libc.so.6

3. 小结

	history list length 记录的是update undo log的个数，不包含insert undo.
	
	会在事务提交或者回滚的时候更新该值。
	
	但是由于很多内部事务(比如更新数据字典的信息)的存在，我们看到的值会比真实的undo个数要大。 -- 重点； 
	

	
4. 基本的函数调用栈

	trx_commit
		->trx_commit_low
			->trx_write_serialisation_history
				->trx_undo_update_cleanup
					->trx_purge_add_update_undo_to_history

	
5. 相关参考
	
	http://blog.itpub.net/7728585/viewspace-2757311/		MySQL：从一个案例深入剖析InnoDB隐式锁和可见性判断
	http://mysql.taobao.org/monthly/2015/04/01/  MySQL · 引擎特性 · InnoDB undo log 漫游
	 