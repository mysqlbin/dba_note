


选择何种搜索策略取决于Rows_log_event::decide_row_lookup_algorithm_and_key的结果，其决策矩阵依赖表的索引信息和 slave_rows_search_algorithms(行记录搜索的算法) 参数的设置。


入口函数
	
	Rows_log_event::decide_row_lookup_algorithm_and_key()

  /*
    Decision table:
    - I  --> Index scan / search
    - T  --> Table scan
    - Hi --> Hash over index
    - Ht --> Hash over the entire table

    |--------------+-----------+------+------+------|
    | Index\Option | I , T , H | I, T | I, H | T, H |
    |--------------+-----------+------+------+------|
    | PK / UK      | I         | I    | I    | Hi   |
    | K            | Hi        | I    | Hi   | Hi   |
    | No Index     | Ht        | T    | Ht   | Ht   |
    |--------------+-----------+------+------+------|

  */
  
  
  Index used / option value				INDEX_SCAN,HASH_SCAN	INDEX_SCAN,TABLE_SCAN
	Primary key or unique key			Index scan				Index scan
	(Other) Key							Hash scan over index	Index scan
	No index							Hash scan				Table scan
	
	
5.6新参数 slave_rows_search_algorithms
	
	这个参数主要用于在从库确认如何查找数据
	
	其中决定如何查找数据以及通过哪个索引查找正是通过参数 slave_rows_search_algorithms的设置和表中是否有合适的索引共同决定的，并不是完成由参数slave_rows_search_algorithms决定。

	参数由三个值的组合组成：TABLE_SCAN, INDEX_SCAN, HASH_SCAN，使用组合包括：

		1. TABLE_SCAN,INDEX_SCAN: 
			默认配置，表示如果有索引就用索引查找，否则使用全表扫描；

		2. INDEX_SCAN,HASH_SCAN： 
			先判断是否有主键索引或者唯一索引，有则使用INDEX_SCAN，没有则使用HASH_SCAN，接着判断是否有二级索引，有则使用索引Hash查找，没有则使用全表Hash查找。
			
		3. TABLE_SCAN,HASH_SCAN

		4. TABLE_SCAN,INDEX_SCAN,HASH_SCAN (等价于INDEX_SCAN, HASH_SCAN)
		
		5. 矩阵示意图
			Index used / option value				INDEX_SCAN,HASH_SCAN	INDEX_SCAN,TABLE_SCAN
			Primary key or unique key			Index scan				Index scan
			(Other) Key							Hash scan over index	Index scan
			No index							Hash scan				Table scan
			
				
			
mysql> show global variables like '%slave_rows_search_algorithms%';
+------------------------------+----------------------+
| Variable_name                | Value                |
+------------------------------+----------------------+
| slave_rows_search_algorithms | INDEX_SCAN,HASH_SCAN |
+------------------------------+----------------------+
1 row in set (0.00 sec)

CREATE TABLE `table_web_loginlog_debug` (
  `nPlayerId` int(11) NOT NULL,
  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
  `szNickName` varchar(64) DEFAULT NULL,
  `nAction` int(11) NOT NULL DEFAULT '0',
  `szTime` timestamp NULL DEFAULT NULL,
  `loginIp` varchar(64) DEFAULT NULL,
  `strRe1` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


mysql> select count(*) from niuniuh5_db.table_web_loginlog_debug;
+----------+
| count(*) |
+----------+
|  5265967 |
+----------+
1 row in set (0.83 sec)


主库执行
	mysql> delete from niuniuh5_db.table_web_loginlog_debug;
	Query OK, 5265967 rows affected (1 min 22.07 sec)


通过堆栈信息获取函数调用流程
	Thread 2 (Thread 0x7f749231f700 (LWP 24590)):
	#0  pfs_unlock_mutex_v1 (mutex=0x7f768a383d40) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:3622
	#1  0x0000000000f549d5 in pfs_exit (this=0x7f767f028750) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/include/ib0mutex.h:1139
	#2  PolicyMutex<TTASEventMutex<GenericPolicy> >::exit (this=0x7f767f028750) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/include/ib0mutex.h:956
	#3  0x0000000000f973d8 in lock_rec_lock_fast (thr=0x7f74b20de378, index=0x7f74c6cc72f8, heap_no=121, block=0x7f7645b9ecf0, mode=1027, impl=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/lock/lock0lock.cc:1922
	#4  lock_rec_lock (impl=<optimized out>, mode=1027, block=0x7f7645b9ecf0, heap_no=121, index=0x7f74c6cc72f8, thr=0x7f74b20de378) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/lock/lock0lock.cc:2055
	#5  0x0000000000f97e35 in lock_clust_rec_read_check_and_lock (flags=flags@entry=0, block=block@entry=0x7f7645b9ecf0, rec=rec@entry=0x7f764bc5dd72 "", index=index@entry=0x7f74c6cc72f8, offsets=offsets@entry=0x7f749231dc00, mode=mode@entry=LOCK_X, gap_mode=gap_mode@entry=1024, thr=thr@entry=0x7f74b20de378) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/lock/lock0lock.cc:6414
	#6  0x000000000104ac3a in sel_set_rec_lock (pcur=pcur@entry=0x7f74b20ddd58, rec=rec@entry=0x7f764bc5dd72 "", index=index@entry=0x7f74c6cc72f8, offsets=0x7f749231dc00, mode=3, type=1024, thr=thr@entry=0x7f74b20de378, mtr=mtr@entry=0x7f749231df20) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/row/row0sel.cc:1254
	#7  0x0000000001053844 in row_search_mvcc (buf=buf@entry=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>, mode=mode@entry=PAGE_CUR_G, prebuilt=0x7f74b20ddb48, match_mode=match_mode@entry=0, direction=direction@entry=0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/row/row0sel.cc:5524
	#8  0x0000000000f4804f in ha_innobase::index_read (this=0x7f74b001a5a0, buf=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>, key_ptr=<optimized out>, key_len=<optimized out>, find_flag=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:8740
	#9  0x0000000000f36470 in ha_innobase::index_first (this=0x7f74b001a5a0, buf=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:9157
	#10 0x0000000000f486bf in ha_innobase::rnd_next (this=0x7f74b001a5a0, buf=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:9255
	#11 0x0000000000807fef in handler::ha_rnd_next (this=0x7f74b001a5a0, buf=0x7f74b001a9b0 "\370\313", <incomplete sequence \355>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/handler.cc:2955
	#12 0x0000000000e81671 in Rows_log_event::next_record_scan (this=this@entry=0x7f74b20f41e0, first_read=<optimized out>) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/log_event.cc:10169
	#13 0x0000000000e81fcf in Rows_log_event::do_scan_and_update (this=0x7f74b20f41e0, rli=0xc1b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/log_event.cc:10625
	#14 0x0000000000e80ace in Rows_log_event::do_apply_event (this=0x7f74b20f41e0, rli=0xc1b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/log_event.cc:11280
	#15 0x0000000000e7979d in Log_event::apply_event (this=this@entry=0x7f74b20f41e0, rli=rli@entry=0xc1b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/log_event.cc:3354
	#16 0x0000000000ebf493 in apply_event_and_update_pos (ptr_ev=ptr_ev@entry=0x7f749231e9a0, thd=thd@entry=0x7f74b00008c0, rli=rli@entry=0xc1b7d90) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_slave.cc:4734
	#17 0x0000000000ecc36a in exec_relay_log_event (rli=0xc1b7d90, thd=0x7f74b00008c0) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_slave.cc:5272
	#18 handle_slave_sql (arg=arg@entry=0xc11c180) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/sql/rpl_slave.cc:7463
	#19 0x0000000001280284 in pfs_spawn_thread (arg=0x7f74b82eb490) at /export/home2/pb2/build/sb_1-33648028-1555165710.26/rpm/BUILD/mysql-5.7.26/mysql-5.7.26/storage/perfschema/pfs.cc:2190
	#20 0x00007f76932d3dd5 in start_thread () from /lib64/libpthread.so.0
	#21 0x00007f7691d8cead in clone () from /lib64/libc.so.6


	
	handle_slave_sql
		-> exec_relay_log_event
			-> apply_event_and_update_pos
				-> Log_event::apply_event
					-> Rows_log_event::do_apply_event
						-> Rows_log_event::do_scan_and_update
							-> Rows_log_event::next_record_scan


