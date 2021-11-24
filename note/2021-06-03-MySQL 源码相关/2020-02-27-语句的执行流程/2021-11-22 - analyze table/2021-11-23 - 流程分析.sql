

在MySQL 5.6中，完成统计信息自动计算的是一个独立线程(dict_stats_thread)，用于重新计算表或索引的统计信息.在一个loop中，等待事件dict_stats_event，或者每隔10秒被无条件唤醒。实际工作函数为dict_stats_process_entry_from_recalc_pool()

在后台有专门的线程，叫做 dict_stats_thread 来处理统计信息， InnoDB会长期追踪每一张表的行数， 判断条件是发现更新的记录超过表记录总数的1/10，那么就把这张表加入到后台的 recalc pool 中， 而如果变更的行数超过 16+n_rows/16（6.25%），更新非持久化统计信息 。
	

	   


请求重新计算统计信息的方式：
		
	1. 当手动执行ANALYZE TABLE
	
	2. 进入到自动重新计算后台线程(后台线程每隔10秒执行一次？)
	
	
		持久化统计信息在以下情况会被自动更新(先把表的ID加入到 recalc_pool 中)：
		
		1. INNODB_STATS_AUTO_RECALC=ON 情况下，表中10%的数据被修改：
				1. 通过 delete 删除数据
				2. 通过 update 更新并且有更新二级索引的数据
				-- 只要满足其中1个条件就会统计到修改表的行数中，当表中10%的数据被修改 ，就会把表的ID加入到 recalc_pool 中。
				
			2. 添加/删除字段、添加索引  -- 需要加入到 recalc_pool 吗？
			
		
	
	3. 打开的表的stats不存在
	
	D:\mysqlbin\mysql_source_code\mysql-5.7.26\storage\innobase\dict\dict0stats.cc
	
	dict_stats_update() 函数
	
	/* Persistent recalculation requested, called from
		1) ANALYZE TABLE, or
		2) the auto recalculation background thread, or
		3) open table if stats do not exist on disk and auto recalc
		   is enabled 
		   
	请求重新计算统计值的方式：
		1. 当手动执行ANALYZE TABLE
		2. 进入到自动重新计算后台线程(后台线程每隔10秒执行一次？)
		3. 打开的表的stats不存在
	*/	   
	

dict_stats_thread 多久运行一次？

row_update_for_mysql_using_upd_graph
	-> row_update_statistics_if_needed



1. 将表的ID加入到 recalc_pool
	
	1.1 所有需要被重新计算的表会加入到recalc_pool中，recalc_pool初始化大小为128，随后如果需要再被扩大。
	
	1.2 在做完DML后，会调用函数 row_update_for_mysql_using_upd_graph 判断，只要满足下面其中1个条件就会直接进入 row_update_statistics_if_needed 函数判断是否需要更新统计信息 ：

		1. 只会在DELETE或者UPDATE有更改到索引列，如果只更新到非索引列，那就不会影响统计信息。
		2. delete肯定会影响到所有列
		
			
	1.3 row_update_statistics_if_needed 函数
		
		1. 开启了持久化统计信息
			1. 如果修改表的行数超过10%，会启用自动重新计算统计信息
			2. 把表ID 放进 recalc_pool 并置 该表修改的行数 为0
			3. 以上条件不满足，直接return，不进行下面的判断
			
		2. 没有开启持久化统计信息
			当发现修改的记录超过6.25%(1/16)时，更新统计信息 dict_stats_update(table, DICT_STATS_RECALC_TRANSIENT)->dict_stats_update_transient


2. dict stats 后台线程如何处理
	
	
	如果该表在10秒内 已经计算过一次，那么就把该表重新放到 recalc_pool 尾部，不做任何处理(等待下一次统计)。
	否则： 否则真正进入 dict_stats_update 修改统计值
	实际上 DICT_STATS_RECALC_PERSISTENT 类型的状态信息更新，也会由 ANALYZE TABLE 发起
	

3. dict_stats_update()函数，在传参为DICT_STATS_RECALC_PERSISTENT时，做三件事：

	1. 检查 dict_stats_persistent_storage_check() 检查相关系统表是否存在，不存在报错
	2. dict_stats_update_persistent(table) 更新表的统计信息
		先更新聚集索引，再更新二级索引，均调用函数 dict_stats_analyze_index.
	3. dict_stats_save(table) 将统计信息更新到持久化存储系统表中



参考源码级相关文章：
	https://developer.aliyun.com/article/41045
	https://tusundong.top/post/empty_cardinality_bug.html	
	http://mysql.taobao.org/monthly/2020/03/08/
	
	
	

mysql> select now();
+---------------------+
| now()               |
+---------------------+
| 2021-11-23 11:15:18 |
+---------------------+
1 row in set (0.00 sec)




master

	select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
	select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name="table_web_loginlog";

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
	+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name                          | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
	| niuniuh5_db   | table_user_gamelock                 | 2021-11-23 11:10:21 |     416 |                    1 |                        1 |
	| niuniuh5_db   | table_clubgoods                     | 2021-11-23 03:11:11 |     275 |                    1 |                        2 |
	| niuniuh5_db   | table_league_club_member            | 2021-11-22 23:39:22 |   14460 |                   96 |                       81 |
	| niuniuh5_db   | table_agent_info                    | 2021-11-21 20:14:54 |     305 |                    3 |                        3 |
	| niuniuh5_db   | table_agent_commission              | 2021-11-21 00:41:46 |  243488 |                 1123 |                     1251 |
	| niuniuh5_db   | table_clubgoodsoperatlog            | 2021-11-20 15:28:19 |    6984 |                   97 |                       71 |
	| niuniuh5_db   | table_league_club_game_score_detail | 2021-11-19 07:57:14 | 5583636 |                42177 |                    50479 |
	| niuniuh5_db   | table_league_club_game_score_total  | 2021-11-19 07:55:01 |  571938 |                 8137 |                     5400 |
	| niuniuh5_db   | table_clubgoodsinfor                | 2021-11-19 07:09:11 |      21 |                    1 |                        1 |
	| niuniuh5_db   | table_task_config                   | 2021-11-19 07:09:01 |     133 |                    1 |                        1 |
	| niuniuh5_db   | table_club_task_complete            | 2021-11-19 07:08:26 |    6843 |                   97 |                       18 |
	| niuniuh5_db   | table_user                          | 2021-11-18 20:22:21 |   64545 |                  929 |                      759 |
	| niuniuh5_db   | table_agent_apply                   | 2021-11-17 23:03:23 |    1211 |                   11 |                       11 |
	| niuniuh5_db   | table_recharge_detail               | 2021-11-17 15:39:44 |  117306 |                  417 |                      386 |
	| niuniuh5_db   | table_league_stc_partner_sub        | 2021-11-16 01:35:10 |    6699 |                   30 |                       22 |
	+---------------+-------------------------------------+---------------------+---------+----------------------+--------------------------+
	15 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name="table_web_loginlog";
	+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name         | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
	| niuniuh5_db   | table_web_loginlog | 2021-11-06 17:25:11 | 2328319 |                 9196 |                    17612 |
	+---------------+--------------------+---------------------+---------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	
slave
	
	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' order by last_update desc limit 15;
	+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name                           | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
	| niuniuh5_db   | table_user_gamelock                  | 2021-11-23 11:09:08 |     416 |                    1 |                        1 |
	| niuniuh5_db   | table_clubgoods                      | 2021-11-23 02:32:42 |     275 |                    1 |                        2 |
	| niuniuh5_db   | table_league_club_game_score_detail  | 2021-11-22 15:13:16 | 5778103 |                41793 |                    50541 |
	| niuniuh5_db   | table_webdata_roomcardfirstgamehelp  | 2021-11-22 01:40:00 |    3853 |                   12 |                       11 |
	| niuniuh5_db   | table_webknapsack_goodsstatiroomcard | 2021-11-20 01:40:08 |     125 |                    1 |                        1 |
	| niuniuh5_db   | table_clubgoodsinfor                 | 2021-11-19 07:09:11 |      21 |                    1 |                        1 |
	| niuniuh5_db   | table_task_config                    | 2021-11-19 07:09:01 |     133 |                    1 |                        1 |
	| niuniuh5_db   | table_club_task_complete             | 2021-11-19 07:08:27 |    6858 |                   97 |                       18 |
	| niuniuh5_db   | table_clubgoodsoperatlog             | 2021-11-05 00:57:00 |    3684 |                   27 |                       36 |
	| niuniuh5_db   | table_web_ngoodstemp                 | 2021-11-01 16:09:42 |     420 |                    3 |                        1 |
	| niuniuh5_db   | table_clubgamescoredetail20211230    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
	| niuniuh5_db   | table_clubgamescoredetail20211229    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
	| niuniuh5_db   | table_clubgamescoredetail20211228    | 2021-11-01 10:00:05 |       0 |                    1 |                        6 |
	| niuniuh5_db   | table_third_score_detail20211227     | 2021-11-01 10:00:05 |       0 |                    1 |                        2 |
	| niuniuh5_db   | table_clublogscore20211229           | 2021-11-01 10:00:05 |       0 |                    1 |                        4 |
	+---------------+--------------------------------------+---------------------+---------+----------------------+--------------------------+
	15 rows in set (0.00 sec)

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name="table_web_loginlog";
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name         | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	| niuniuh5_db   | table_web_loginlog | 2021-09-10 07:03:34 | 486630 |                 1956 |                     3883 |
	+---------------+--------------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)


other
	-- table_user_gamelock表数据删除操作较频繁
	show create table niuniuh5_db.table_user_gamelock\G;
	SELECT COUNT(*) FROM niuniuh5_db.table_user_gamelock;

	-- table_web_loginlog表都是写入操作
	show create table niuniuh5_db.table_web_loginlog\G;
	SELECT COUNT(*) FROM niuniuh5_db.table_web_loginlog;


	slave 

		mysql> show create table niuniuh5_db.table_user_gamelock\G;
		*************************** 1. row ***************************
			   Table: table_user_gamelock
		Create Table: CREATE TABLE `table_user_gamelock` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) DEFAULT '0' COMMENT '玩家ID',
		  `nTablePreID` int(11) DEFAULT '0' COMMENT '进入的桌子前缀',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nPlayerID` (`nPlayerID`)
		) ENGINE=InnoDB AUTO_INCREMENT=1840854 DEFAULT CHARSET=utf8mb4 COMMENT='用户游戏锁定表'
		1 row in set (0.00 sec)
		
		-- table_user_gamelock表数据删除操作较频繁
		
		mysql> SELECT COUNT(*) FROM niuniuh5_db.table_user_gamelock;
		+----------+
		| COUNT(*) |
		+----------+
		|      416 |
		+----------+
		1 row in set (0.00 sec)

		------------------------------------------------------------------------------------
		

		mysql> show create table niuniuh5_db.table_web_loginlog\G;
		*************************** 1. row ***************************
			   Table: table_web_loginlog
		Create Table: CREATE TABLE `table_web_loginlog` (
		  `Idx` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
		  `nPlayerId` int(11) NOT NULL,
		  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
		  `szNickName` varchar(64) DEFAULT NULL,
		  `nAction` int(11) NOT NULL DEFAULT '0',
		  `szTime` timestamp NULL DEFAULT NULL,
		  `loginIp` varchar(64) DEFAULT NULL,
		  `strRe1` varchar(128) DEFAULT NULL,
		  PRIMARY KEY (`Idx`),
		  KEY `web_loginlog_idx_szTime` (`szTime`),
		  KEY `idx_loginIp_szTime` (`loginIp`,`szTime`),
		  KEY `idx_nPlayerId_szTime` (`nPlayerId`,`szTime`)
		) ENGINE=InnoDB AUTO_INCREMENT=2493732 DEFAULT CHARSET=utf8mb4
		1 row in set (0.00 sec)

		-- 表都是写入操作
		
		mysql> SELECT COUNT(*) FROM niuniuh5_db.table_web_loginlog;
		+----------+
		| COUNT(*) |
		+----------+
		|  2493731 |
		+----------+
		1 row in set (0.40 sec)


analyze table 操作会写binlog，因此会同步到从库。

修改行记录格式，会写binlog不？


drop table  if exists t;
CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into t(c,d) values(1,1);
insert into t(c,d) values(2,2);
insert into t(c,d) values(3,3);
insert into t(c,d) values(4,4);
insert into t(c,d) values(5,5);
insert into t(c,d) values(6,6);
insert into t(c,d) values(7,7);
insert into t(c,d) values(8,8);
insert into t(c,d) values(9,9);
insert into t(c,d) values(10,10);
insert into t(c,d) values(11,11);
insert into t(c,d) values(12,12);
insert into t(c,d) values(13,13);
insert into t(c,d) values(14,14);
insert into t(c,d) values(15,15);

mysql> SELECT * FROM t;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  1 |    1 |    1 |
|  2 |    2 |    2 |
|  3 |    3 |    3 |
|  4 |    4 |    4 |
|  5 |    5 |    5 |
|  6 |    6 |    6 |
|  7 |    7 |    7 |
|  8 |    8 |    8 |
|  9 |    9 |    9 |
| 10 |   10 |   10 |
| 11 |   11 |   11 |
| 12 |   12 |   12 |
| 13 |   13 |   13 |
| 14 |   14 |   14 |
| 15 |   15 |   15 |
+----+------+------+
15 rows in set (0.01 sec)



session A              session B      

b dict_stats_save		
					  delete from t;
					  
(gdb) c
Continuing.
[Switching to Thread 0x7fe8737f6700 (LWP 9526)]

Breakpoint 2, dict_stats_save (table_orig=0x7fe8ac3577f0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
2371		table = dict_stats_snapshot_create(table_orig);
(gdb) bt
#0  dict_stats_save (table_orig=0x7fe8ac3577f0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fe8ac3577f0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#4  0x00007fe8bacbdea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fe8b9b839fd in clone () from /lib64/libc.so.6



SELECT count(*) FROM t;

session A              session B      

b dict_stats_save		
					  insert into t select * from t;
					  (Query Ok)
					  
					  
					  
session A              session B      

b dict_stats_save		
					  update t set c=100 where id between 1 and 5;
					  (Blocked)
					  
(gdb) b dict_stats_save
Breakpoint 2 at 0x1bc2178: file /usr/local/mysql/storage/innobase/dict/dict0stats.cc, line 2371.
(gdb) bt
#0  0x00007fc207578ccd in poll () from /lib64/libc.so.6
#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x64ad8b0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x64dc4e0) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x4bed948) at /usr/local/mysql/sql/mysqld.cc:5149
#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffe68c81558) at /usr/local/mysql/sql/main.cc:25
(gdb) c
Continuing.
[Switching to Thread 0x7fc1c0ff9700 (LWP 9577)]

Breakpoint 2, dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
2371		table = dict_stats_snapshot_create(table_orig);
(gdb) bt
#0  dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#4  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc2075839fd in clone () from /lib64/libc.so.6
(gdb) bt
#0  dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#4  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc2075839fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
355		ut_ad(table->magic_n == DICT_TABLE_MAGIC_N);
(gdb) bt
#0  0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
#1  0x0000000001bbf555 in dict_stats_snapshot_create (table=0xf8947dc0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:769
#2  0x0000000001bc2187 in dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#3  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#4  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#5  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#6  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fc2075839fd in clone () from /lib64/libc.so.6
(gdb) bt
#0  0x0000000001b93528 in dict_table_stats_lock (table=0xf8947dc0, latch_mode=1) at /usr/local/mysql/storage/innobase/dict/dict0dict.cc:355
#1  0x0000000001bbf555 in dict_stats_snapshot_create (table=0xf8947dc0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:769
#2  0x0000000001bc2187 in dict_stats_save (table_orig=0x7fc1f8947dc0, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#3  0x0000000001bc3bc5 in dict_stats_update (table=0x7fc1f8947dc0, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#4  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#5  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#6  0x00007fc2086bdea5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fc2075839fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.
[Thread 0x7fc1ff563700 (LWP 9546) exited]
[Thread 0x7fc1eb851700 (LWP 9547) exited]
[Thread 0x7fc1eb050700 (LWP 9548) exited]
[Thread 0x7fc1ea84f700 (LWP 9549) exited]
[Thread 0x7fc1ea04e700 (LWP 9550) exited]
[Thread 0x7fc1e984d700 (LWP 9551) exited]
[Thread 0x7fc1e904c700 (LWP 9552) exited]
[Thread 0x7fc1e884b700 (LWP 9553) exited]
[Thread 0x7fc1e804a700 (LWP 9554) exited]
[Thread 0x7fc1e7849700 (LWP 9555) exited]
[Thread 0x7fc1e7048700 (LWP 9556) exited]
[Thread 0x7fc1e6847700 (LWP 9557) exited]
[Thread 0x7fc1e6046700 (LWP 9558) exited]
[Thread 0x7fc1e5845700 (LWP 9559) exited]
[Thread 0x7fc1e5044700 (LWP 9560) exited]
[Thread 0x7fc1e4843700 (LWP 9561) exited]
[Thread 0x7fc1e4042700 (LWP 9562) exited]
[Thread 0x7fc1e3841700 (LWP 9563) exited]
[Thread 0x7fc1e3040700 (LWP 9564) exited]
[Thread 0x7fc1e283f700 (LWP 9565) exited]
[Thread 0x7fc1e1e39700 (LWP 9568) exited]
[Thread 0x7fc1e1638700 (LWP 9569) exited]
[Thread 0x7fc1e0e37700 (LWP 9570) exited]
[Thread 0x7fc1c17fa700 (LWP 9576) exited]
[Thread 0x7fc1c0ff9700 (LWP 9577) exited]
[Thread 0x7fc1c07f8700 (LWP 9578) exited]
[Thread 0x7fc1bfff7700 (LWP 9579) exited]
[Thread 0x7fc1fc1e6700 (LWP 9580) exited]
[Thread 0x7fc1fc164700 (LWP 9581) exited]
[Thread 0x7fc1bf535700 (LWP 9582) exited]
[Thread 0x7fc208ae4740 (LWP 9545) exited]
[Thread 0x7fc1c3fff700 (LWP 9571) exited]
[Thread 0x7fc1e0235700 (LWP 9583) exited]
[Thread 0x7fc1c27fc700 (LWP 9574) exited]
[Thread 0x7fc1c2ffd700 (LWP 9573) exited]
[Thread 0x7fc1c37fe700 (LWP 9572) exited]
[Inferior 1 (process 9545) exited with code 02]
-- mysqld crash 





					  
session A              session B      

b dict_stats_save		
					  update t set d=100 where id between 1 and 5;
					  (Query Ok)

					  

session A              session B      

b dict_stats_save		
					  delete from t where id=1;
					  (Query Ok)
					  
					  
					  
session A              session B      

b dict_stats_save		
					  delete from t where id between 1 and 5;		
					  (Blocked)
					  
(gdb) b dict_stats_save
Breakpoint 2 at 0x1bc2178: file /usr/local/mysql/storage/innobase/dict/dict0stats.cc, line 2371.
(gdb) c
Continuing.
[Switching to Thread 0x7efc94ff9700 (LWP 9737)]

Breakpoint 2, dict_stats_save (table_orig=0x5e74910, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
2371		table = dict_stats_snapshot_create(table_orig);
(gdb) bt
#0  dict_stats_save (table_orig=0x5e74910, only_for_index=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:2371
#1  0x0000000001bc3bc5 in dict_stats_update (table=0x5e74910, stats_upd_option=DICT_STATS_RECALC_PERSISTENT) at /usr/local/mysql/storage/innobase/dict/dict0stats.cc:3113
#2  0x0000000001bc866a in dict_stats_process_entry_from_recalc_pool () at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:356
#3  0x0000000001bc88a8 in dict_stats_thread (arg=0x0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:445
#4  0x00007efcdc101ea5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007efcdafc79fd in clone () from /lib64/libc.so.6







session A              session B      

b dict_stats_update_persistent
						
					   update t set d=100 where c between 1 and 5;	
					  (Query Ok)












					  