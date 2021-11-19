

1. 数据准备

	mysql> select ID, nClubID, nPlayerID from table_league_club_member where nClubID=666138;
	+------+---------+-----------+
	| ID   | nClubID | nPlayerID |
	+------+---------+-----------+
	| 7908 |  666138 |    124504 |
	| 7910 |  666138 |    124507 |
	| 7922 |  666138 |    124480 |
	| 7927 |  666138 |    124471 |
	| 7928 |  666138 |    124485 |
	| 7938 |  666138 |    124441 |
	| 7941 |  666138 |    124448 |
	| 7944 |  666138 |    124437 |
	| 7959 |  666138 |    124439 |
	| 7960 |  666138 |    124443 |

	| 7961 |  666138 |    124442 |
	| 7966 |  666138 |    124436 |
	| 7967 |  666138 |    124440 |

	| 7998 |  666138 |    124517 |
	| 8050 |  666138 |    124558 |
	| 8699 |  666138 |    124751 |
	| 8958 |  666138 |    124894 |
	+------+---------+-----------+
	17 rows in set (0.00 sec)

	delete from table_league_club_member where ID=7908;
	delete from table_league_club_member where ID=7910;
	delete from table_league_club_member where ID=7922;
	delete from table_league_club_member where ID=7927;
	delete from table_league_club_member where ID=7928;
	delete from table_league_club_member where ID=7938;
	delete from table_league_club_member where ID=7941;
	delete from table_league_club_member where ID=7944;
	delete from table_league_club_member where ID=7959;
	delete from table_league_club_member where ID=7960;
	delete from table_league_club_member where ID=7966;
	delete from table_league_club_member where ID=7998;
	delete from table_league_club_member where ID=8050;
	delete from table_league_club_member where ID=8699;
	delete from table_league_club_member where ID=8958;

	mysql> select ID, nClubID, nPlayerID from table_league_club_member where nClubID=666138;
	+------+---------+-----------+
	| ID   | nClubID | nPlayerID |
	+------+---------+-----------+
	| 7961 |  666138 |    124442 |
	| 7967 |  666138 |    124440 |
	+------+---------+-----------+
	2 rows in set (0.00 sec)


	CREATE TABLE `table_league_club_member` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
	  `nPlayerID` int(11) NOT NULL COMMENT '用户ID',
	  `szNickName` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
	  `szBackName` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
	  `szWXAccount` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
	  `nLevel` tinyint(4) NOT NULL COMMENT '权限（1-部长，2-管理，3-成员）',
	  `partner` tinyint(4) NOT NULL COMMENT '合伙人标记(1-是 0-否)',
	  `nStatus` tinyint(4) NOT NULL COMMENT '状态（1-正常，2-冻结，3-退出，4-踢出）',
	  `tJoinTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入俱乐部时间',
	  `tExitTime` timestamp NULL DEFAULT NULL COMMENT '离开俱乐部时间',
	  `nScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
	  `nLeCard` bigint(20) NOT NULL DEFAULT '0' COMMENT '乐卡',
	  `nExtenID` int(11) DEFAULT '0' COMMENT '上线用户ID',
	  `tFreezeTime` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '禁赛所到的时间点',
	  `nFreezeReason` int(11) NOT NULL COMMENT '禁赛理由',
	  `BigWinner` tinyint(4) NOT NULL DEFAULT '0' COMMENT '禁止同桌标记(1-是 0-否)',
	  `szBan` text COMMENT 'JSON数据，包含禁止的ID',
	  PRIMARY KEY (`ID`),
	  KEY `idx_nExtenID` (`nExtenID`),
	  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
	  KEY `idx_nClubID` (`nClubID`) USING BTREE,
	  KEY `idx_partner` (`partner`)
	) ENGINE=InnoDB AUTO_INCREMENT=1882 DEFAULT CHARSET=utf8mb4 COMMENT='联盟俱乐部成员表';




	mysql>  desc UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	| id | select_type | table                    | partitions | type        | possible_keys             | key                       | key_len | ref  | rows | filtered | Extra                                                   |
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	|  1 | UPDATE      | table_league_club_member | NULL       | index_merge | idx_nPlayerID,idx_nClubID | idx_nPlayerID,idx_nClubID | 4,4     | NULL |    1 |   100.00 | Using intersect(idx_nPlayerID,idx_nClubID); Using where |
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	1 row in set (0.01 sec)


	alter table table_league_club_member change nClubID nClubID bigint(20) NOT NULL COMMENT '俱乐部ID';

	CREATE TABLE `table_league_club_member` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `nClubID` bigint(20) NOT NULL COMMENT '俱乐部ID',
	  `nPlayerID` int(11) NOT NULL COMMENT '用户ID',
	  `szNickName` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
	  `szBackName` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
	  `szWXAccount` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
	  `nLevel` tinyint(4) NOT NULL COMMENT '权限（1-部长，2-管理，3-成员）',
	  `partner` tinyint(4) NOT NULL COMMENT '合伙人标记(1-是 0-否)',
	  `nStatus` tinyint(4) NOT NULL COMMENT '状态（1-正常，2-冻结，3-退出，4-踢出）',
	  `tJoinTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入俱乐部时间',
	  `tExitTime` timestamp NULL DEFAULT NULL COMMENT '离开俱乐部时间',
	  `nScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
	  `nLeCard` bigint(20) NOT NULL DEFAULT '0' COMMENT '乐卡',
	  `nExtenID` int(11) DEFAULT '0' COMMENT '上线用户ID',
	  `tFreezeTime` timestamp NULL DEFAULT '2021-07-08 00:00:00' COMMENT '禁赛所到的时间点',
	  `nFreezeReason` int(11) NOT NULL COMMENT '禁赛理由',
	  `BigWinner` tinyint(4) NOT NULL DEFAULT '0' COMMENT '禁止同桌标记(1-是 0-否)',
	  `szBan` text COMMENT 'JSON数据，包含禁止的ID',
	  PRIMARY KEY (`ID`),
	  KEY `idx_nExtenID` (`nExtenID`),
	  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
	  KEY `idx_nClubID` (`nClubID`) USING BTREE,
	  KEY `idx_partner` (`partner`)
	) ENGINE=InnoDB AUTO_INCREMENT=10407 DEFAULT CHARSET=utf8mb4 COMMENT='联盟俱乐部成员表'

	mysql> desc UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	| id | select_type | table                    | partitions | type        | possible_keys             | key                       | key_len | ref  | rows | filtered | Extra                                                   |
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	|  1 | UPDATE      | table_league_club_member | NULL       | index_merge | idx_nPlayerID,idx_nClubID | idx_nPlayerID,idx_nClubID | 4,8     | NULL |    1 |   100.00 | Using intersect(idx_nPlayerID,idx_nClubID); Using where |
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	1 row in set (0.00 sec)


	mysql> select id,nPlayerID,nClubID from table_league_club_member WHERE `nClubID` = 666138;
	+------+-----------+---------+
	| id   | nPlayerID | nClubID |
	+------+-----------+---------+
	| 7961 |    124442 |  666138 |
	| 7967 |    124440 |  666138 |
	+------+-----------+---------+
	2 rows in set (0.00 sec)


	mysql> select id,nPlayerID,nClubID from table_league_club_member WHERE `nPlayerID` = 124442;
	+------+-----------+---------+
	| id   | nPlayerID | nClubID |
	+------+-----------+---------+
	| 7723 |    124442 |  666000 |
	| 7961 |    124442 |  666138 |
	+------+-----------+---------+
	2 rows in set (0.01 sec)


	mysql> select count(*) from table_league_club_member WHERE `nPlayerID` = 124442;
	+----------+
	| count(*) |
	+----------+
	|        2 |
	+----------+
	1 row in set (0.03 sec)


	mysql> select id,nPlayerID,nClubID from table_league_club_member WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;
	+------+-----------+---------+
	| id   | nPlayerID | nClubID |
	+------+-----------+---------+
	| 7961 |    124442 |  666138 |
	+------+-----------+---------+
	1 row in set (0.00 sec)
	 


	mysql> show global variables like 'tx_isolation';
	+---------------+----------------+
	| Variable_name | Value          |
	+---------------+----------------+
	| tx_isolation  | READ-COMMITTED |
	+---------------+----------------+
	1 row in set (0.01 sec)

	----------------------------------------------------------------------------------------------------------------------------------------------------------------------

	root@mysqldb 09:28:  [sbtest]> show global variables like '%isolation%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	+-----------------------+----------------+
	1 row in set (0.01 sec)

	root@mysqldb 09:29:  [(none)]> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
	| ENGINE_LOCK_ID                            | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME              | INDEX_NAME    | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
	+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
	| 140015843908200:1065:140015732585128      |                 26633 |        58 | table_league_club_member | NULL          | TABLE     | IX            | GRANTED     | NULL         |
	| 140015843908200:8:79:413:140015732582088  |                 26633 |        58 | table_league_club_member | idx_nPlayerID | RECORD    | X,REC_NOT_GAP | GRANTED     | 124442, 7961 |
	| 140015843908200:8:83:560:140015732582776  |                 26633 |        58 | table_league_club_member | idx_nClubID   | RECORD    | X,REC_NOT_GAP | GRANTED     | 666138, 7961 |
	| 140015843908200:8:138:145:140015732583120 |                 26633 |        58 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7961         |
	+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
	4 rows in set (0.00 sec)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------


begin;
UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;

b lock_rec_lock



(gdb) b lock_rec_lock
Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000001943577 in lock_rec_lock(bool, ulint, buf_block_t const*, ulint, dict_index_t*, que_thr_t*) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
(gdb) c
Continuing.
[Switching to Thread 0x7fd1d81af700 (LWP 9475)]

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7113a38, heap_no=242, index=0x684d230, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7113a38, heap_no=242, index=0x684d230, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
-- 锁二级索引 idx_nPlayerID 的记录
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fd1e7113a38, rec=0x7fd1e8f18cad "\200\001\346\032", index=0x684d230, offsets=0x7fd1d81ab800, mode=LOCK_X, gap_mode=1024, thr=0x6856098)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x6855848, rec=0x7fd1e8f18cad "\200\001\346\032", index=0x684d230, offsets=0x7fd1d81ab800, mode=3, type=1024, thr=0x6856098, mtr=0x7fd1d81abb20) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6846b70 "\377", mode=PAGE_CUR_GE, prebuilt=0x6855620, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
-- key_len=4
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6851f20, buf=0x6846b70 "\377", key_ptr=0x6851ea0 "\032\346\001", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x6851f20, buf=0x6846b70 "\377", key=0x6851ea0 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x6851f20, buf=0x6846b70 "\377", key=0x6851ea0 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x6851f20, start_key=0x6852008, end_key=0x6852028, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x6851f20, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x6852180, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x6851f20, range_info=0x7fd1d81acbb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5e77b10) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717af1 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x4f05020) at /usr/local/mysql/sql/opt_range.cc:10841
#13 0x0000000001457dba in rr_quick (info=0x7fd1d81acdd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x5ea96f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd1d81ad428, updated_return=0x7fd1d81ad420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x5e82498, thd=0x5ea96f0, switch_to_multitable=0x7fd1d81ad4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x5e82498, thd=0x5ea96f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x5ea96f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x5ea96f0, parser_state=0x7fd1d81ae690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x5ea96f0, com_data=0x7fd1d81aedf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x5ea96f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x50cc250) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f155f0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fd1ff62fea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fd1fe4f59fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115050, heap_no=95, index=0x684b920, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
-- 锁主键索引的记录
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115050, heap_no=95, index=0x684b920, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd1e7115050, rec=0x7fd1e8f35f91 "", index=0x684b920, offsets=0x7fd1d81ab800, mode=LOCK_X, gap_mode=1024, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414

-- sec_index=0x684d230 对应二级索引 idx_nPlayerID
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x6855620, sec_index=0x684d230, rec=0x7fd1e8f18cad "\200\001\346\032", thr=0x6856098, out_rec=0x7fd1d81ac090, offsets=0x7fd1d81ac068, offset_heap=0x7fd1d81ac070, vrow=0x0, mtr=0x7fd1d81abb20)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x6846b70 "\377", mode=PAGE_CUR_GE, prebuilt=0x6855620, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6851f20, buf=0x6846b70 "\377", key_ptr=0x6851ea0 "\032\346\001", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x6851f20, buf=0x6846b70 "\377", key=0x6851ea0 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x6851f20, buf=0x6846b70 "\377", key=0x6851ea0 "\032\346\001", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x6851f20, start_key=0x6852008, end_key=0x6852028, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x6851f20, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x6852180, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x6851f20, range_info=0x7fd1d81acbb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5e77b10) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717af1 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x4f05020) at /usr/local/mysql/sql/opt_range.cc:10841
#13 0x0000000001457dba in rr_quick (info=0x7fd1d81acdd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x5ea96f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd1d81ad428, updated_return=0x7fd1d81ad420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x5e82498, thd=0x5ea96f0, switch_to_multitable=0x7fd1d81ad4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x5e82498, thd=0x5ea96f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x5ea96f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x5ea96f0, parser_state=0x7fd1d81ae690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x5ea96f0, com_data=0x7fd1d81aedf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x5ea96f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x50cc250) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f155f0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fd1ff62fea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fd1fe4f59fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.


Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e71146d8, heap_no=46, index=0x684dba0, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e71146d8, heap_no=46, index=0x684dba0, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

-- 锁二级索引 idx_nClubID 的记录
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fd1e71146d8, rec=0x7fd1e8f28369 "\200", index=0x684dba0, offsets=0x7fd1d81ab800, mode=LOCK_X, gap_mode=1024, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x6856fa8, rec=0x7fd1e8f28369 "\200", index=0x684dba0, offsets=0x7fd1d81ab800, mode=3, type=1024, thr=0x68577f8, mtr=0x7fd1d81abb20) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6846b70 "\371+\036", mode=PAGE_CUR_GE, prebuilt=0x6856d80, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
-- key_len=8
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6852220, buf=0x6846b70 "\371+\036", key_ptr=0x6851ef0 "\032*\n", key_len=8, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x6852220, buf=0x6846b70 "\371+\036", key=0x6851ef0 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x6852220, buf=0x6846b70 "\371+\036", key=0x6851ef0 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x6852220, start_key=0x6852308, end_key=0x6852328, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x6852220, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x6852480, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x6852220, range_info=0x7fd1d81acbb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5e423b0) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x4f05020) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fd1d81acdd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x5ea96f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd1d81ad428, updated_return=0x7fd1d81ad420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x5e82498, thd=0x5ea96f0, switch_to_multitable=0x7fd1d81ad4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x5e82498, thd=0x5ea96f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x5ea96f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x5ea96f0, parser_state=0x7fd1d81ae690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x5ea96f0, com_data=0x7fd1d81aedf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x5ea96f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x50cc250) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f155f0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fd1ff62fea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fd1fe4f59fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
-- 锁二级索引 idx_nClubID 对应的 主键索引的记录
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd1e7115378, rec=0x7fd1e8f3b595 "", index=0x684b920, offsets=0x7fd1d81ab800, mode=LOCK_X, gap_mode=1024, thr=0x68577f8) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
-- 根据二级索引查找主键索引的记录(回表函数)
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x6856d80, sec_index=0x684dba0, rec=0x7fd1e8f28369 "\200", thr=0x68577f8, out_rec=0x7fd1d81ac090, offsets=0x7fd1d81ac068, offset_heap=0x7fd1d81ac070, vrow=0x0, mtr=0x7fd1d81abb20)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x6846b70 "\371+\036", mode=PAGE_CUR_GE, prebuilt=0x6856d80, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6852220, buf=0x6846b70 "\371+\036", key_ptr=0x6851ef0 "\032*\n", key_len=8, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x6852220, buf=0x6846b70 "\371+\036", key=0x6851ef0 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x6852220, buf=0x6846b70 "\371+\036", key=0x6851ef0 "\032*\n", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x6852220, start_key=0x6852308, end_key=0x6852328, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x6852220, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x6852480, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x6852220, range_info=0x7fd1d81acbb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5e423b0) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x4f05020) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fd1d81acdd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x5ea96f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd1d81ad428, updated_return=0x7fd1d81ad420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x5e82498, thd=0x5ea96f0, switch_to_multitable=0x7fd1d81ad4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x5e82498, thd=0x5ea96f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x5ea96f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x5ea96f0, parser_state=0x7fd1d81ae690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x5ea96f0, com_data=0x7fd1d81aedf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x5ea96f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x50cc250) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f155f0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fd1ff62fea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fd1fe4f59fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7113a38, heap_no=403, index=0x684d230, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7113a38, heap_no=403, index=0x684d230, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

-- 锁二级索引 idx_nPlayerID 的记录
#1  0x000000000194d8b9 in lock_sec_rec_read_check_and_lock (flags=0, block=0x7fd1e7113a38, rec=0x7fd1e8f194da "\200\001\346\032", index=0x684d230, offsets=0x7fd1d81ab860, mode=LOCK_X, gap_mode=1024, thr=0x6856098)
    at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6342
#2  0x0000000001a465fe in sel_set_rec_lock (pcur=0x6855848, rec=0x7fd1e8f194da "\200\001\346\032", index=0x684d230, offsets=0x7fd1d81ab860, mode=3, type=1024, thr=0x6856098, mtr=0x7fd1d81abb80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1269
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6846b70 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x6855620, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x6851f20, buf=0x6846b70 "\371\031\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
-- keylen=4
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x6851f20, buf=0x6846b70 "\371\031\037", key=0x6851ea8 "\032\346\001", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x6851f20, buf=0x6846b70 "\371\031\037", key=0x6851ea8 "\032\346\001", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x6851f20) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x6851f20, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x6852180, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x6851f20, range_info=0x7fd1d81acbb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5e77b10) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x4f05020) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fd1d81acdd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x5ea96f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd1d81ad428, updated_return=0x7fd1d81ad420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x5e82498, thd=0x5ea96f0, switch_to_multitable=0x7fd1d81ad4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x5e82498, thd=0x5ea96f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x5ea96f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x5ea96f0, parser_state=0x7fd1d81ae690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x5ea96f0, com_data=0x7fd1d81aedf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x5ea96f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x50cc250) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f155f0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fd1ff62fea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fd1fe4f59fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.




-- 锁主键索引的记录
Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

-- 锁二级索引 idx_nPlayerID 对应 主键索引的记录
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd1e7115378, rec=0x7fd1e8f3b595 "", index=0x684b920, offsets=0x7fd1d81ab860, mode=LOCK_X, gap_mode=1024, thr=0x6856098) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x6855620, sec_index=0x684d230, rec=0x7fd1e8f194da "\200\001\346\032", thr=0x6856098, out_rec=0x7fd1d81ac0f0, offsets=0x7fd1d81ac0c8, offset_heap=0x7fd1d81ac0d0, vrow=0x0, mtr=0x7fd1d81abb80)
    at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
#3  0x0000000001a4f94a in row_search_mvcc (buf=0x6846b70 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x6855620, match_mode=1, direction=1) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
-- 从给定的索引位置获取下一条或上一条记录。
#4  0x00000000018c249a in ha_innobase::general_fetch (this=0x6851f20, buf=0x6846b70 "\371\031\037", direction=1, match_mode=1) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9040
#5  0x00000000018c270f in ha_innobase::index_next_same (this=0x6851f20, buf=0x6846b70 "\371\031\037", key=0x6851ea8 "\032\346\001", keylen=4) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9125
#6  0x0000000000f2cab2 in handler::ha_index_next_same (this=0x6851f20, buf=0x6846b70 "\371\031\037", key=0x6851ea8 "\032\346\001", keylen=4) at /usr/local/mysql/sql/handler.cc:3263
#7  0x0000000000f34fa7 in handler::read_range_next (this=0x6851f20) at /usr/local/mysql/sql/handler.cc:7426
#8  0x0000000000f32d19 in handler::multi_range_read_next (this=0x6851f20, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6429
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x6852180, range_info=0x7fd1d81acbb0) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x6851f20, range_info=0x7fd1d81acbb0) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x5e77b10) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001717c81 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x4f05020) at /usr/local/mysql/sql/opt_range.cc:10870
#13 0x0000000001457dba in rr_quick (info=0x7fd1d81acdd0) at /usr/local/mysql/sql/records.cc:398
#14 0x00000000015e7b84 in mysql_update (thd=0x5ea96f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd1d81ad428, updated_return=0x7fd1d81ad420) at /usr/local/mysql/sql/sql_update.cc:812
#15 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x5e82498, thd=0x5ea96f0, switch_to_multitable=0x7fd1d81ad4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#16 0x00000000015ee453 in Sql_cmd_update::execute (this=0x5e82498, thd=0x5ea96f0) at /usr/local/mysql/sql/sql_update.cc:3018
#17 0x00000000015351f1 in mysql_execute_command (thd=0x5ea96f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#18 0x000000000153a849 in mysql_parse (thd=0x5ea96f0, parser_state=0x7fd1d81ae690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x5ea96f0, com_data=0x7fd1d81aedf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x5ea96f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x50cc250) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f155f0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007fd1ff62fea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007fd1fe4f59fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.

-- 锁主键索引的记录
Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x6850908) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7fd1e7115378, heap_no=144, index=0x684b920, thr=0x6850908) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040

-- 锁二级索引 idx_nPlayerID 对应 主键索引的记录
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7fd1e7115378, rec=0x7fd1e8f3b595 "", index=0x684b920, offsets=0x7fd1d81ab960, mode=LOCK_X, gap_mode=1024, thr=0x6850908) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x68500b8, rec=0x7fd1e8f3b595 "", index=0x684b920, offsets=0x7fd1d81ab960, mode=3, type=1024, thr=0x6850908, mtr=0x7fd1d81abc80) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x6846b70 "\371\031\037", mode=PAGE_CUR_GE, prebuilt=0x684fe90, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x6846760, buf=0x6846b70 "\371\031\037", key_ptr=0x68545a0 "\031\037", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x00000000018c2b27 in ha_innobase::rnd_pos (this=0x6846760, buf=0x6846b70 "\371\031\037", pos=0x68545a0 "\031\037") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9292
#6  0x0000000000f2b061 in handler::ha_rnd_pos (this=0x6846760, buf=0x6846b70 "\371\031\037", pos=0x68545a0 "\031\037") at /usr/local/mysql/sql/handler.cc:2989
#7  0x0000000001717f26 in QUICK_ROR_INTERSECT_SELECT::get_next (this=0x4f05020) at /usr/local/mysql/sql/opt_range.cc:10919
#8  0x0000000001457dba in rr_quick (info=0x7fd1d81acdd0) at /usr/local/mysql/sql/records.cc:398
#9  0x00000000015e7b84 in mysql_update (thd=0x5ea96f0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fd1d81ad428, updated_return=0x7fd1d81ad420) at /usr/local/mysql/sql/sql_update.cc:812
#10 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x5e82498, thd=0x5ea96f0, switch_to_multitable=0x7fd1d81ad4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#11 0x00000000015ee453 in Sql_cmd_update::execute (this=0x5e82498, thd=0x5ea96f0) at /usr/local/mysql/sql/sql_update.cc:3018
#12 0x00000000015351f1 in mysql_execute_command (thd=0x5ea96f0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#13 0x000000000153a849 in mysql_parse (thd=0x5ea96f0, parser_state=0x7fd1d81ae690) at /usr/local/mysql/sql/sql_parse.cc:5570
#14 0x00000000015302d8 in dispatch_command (thd=0x5ea96f0, com_data=0x7fd1d81aedf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#15 0x000000000152f20c in do_command (thd=0x5ea96f0) at /usr/local/mysql/sql/sql_parse.cc:1025
#16 0x000000000165f7c8 in handle_connection (arg=0x50cc250) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#17 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4f155f0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#18 0x00007fd1ff62fea5 in start_thread () from /lib64/libpthread.so.0
#19 0x00007fd1fe4f59fd in clone () from /lib64/libc.so.6
(gdb) c
Continuing.
