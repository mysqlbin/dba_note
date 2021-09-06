
1. 初始化表结构和数据
2. 实践1 
3. 实践2
4. 小结


1. 初始化表结构和数据

	CREATE TABLE `table_club_application` (
	  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
	  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
	  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
	  `nStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态:1-申请,2-通过,3-拒绝',
	  `tOperationTime` timestamp NULL DEFAULT NULL COMMENT '回应时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_nClubID` (`nClubID`),
	  KEY `idx_nPlayerID` (`nPlayerID`),
	  KEY `idx_nStatus` (`nStatus`)
	) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4 COMMENT='玩家加入俱乐部申请表';

	INSERT INTO `table_club_application` (`ID`, `nClubID`, `nPlayerID`, `CreateTime`, `nStatus`, `tOperationTime`) VALUES ('238', '66660039', '61946', '2021-03-18 16:48:00', '1', '2021-04-28 15:53:03');
	INSERT INTO `table_club_application` (`ID`, `nClubID`, `nPlayerID`, `CreateTime`, `nStatus`, `tOperationTime`) VALUES ('239', '66660039', '61906', '2021-04-28 15:53:00', '1', '2021-04-28 15:53:03');
	INSERT INTO `table_club_application` (`ID`, `nClubID`, `nPlayerID`, `CreateTime`, `nStatus`, `tOperationTime`) VALUES ('240', '66660039', '61946', '2021-04-28 15:56:43', '1', '2021-04-28 15:57:20');


	mysql> select @@global.tx_isolation;
	+-----------------------+
	| @@global.tx_isolation |
	+-----------------------+
	| READ-COMMITTED        |
	+-----------------------+
	1 row in set, 1 warning (0.01 sec)


2. 实践1 
	session A           session B
	begin;
	SELECT * FROM `table_club_application` WHERE nplayerid =61946  and `nClubID` = 66660039  AND nStatus = 1 AND CreateTime > DATE_SUB(NOW(), INTERVAL 1 DAY) limit 1 for update;
	mysql> SELECT * FROM `table_club_application` WHERE nplayerid =61946  and `nClubID` = 66660039  AND nStatus = 1 AND CreateTime > DATE_SUB(NOW(), INTERVAL 1 DAY) limit 1 for update;
	+-----+----------+-----------+---------------------+---------+---------------------+
	| ID  | nClubID  | nPlayerID | CreateTime          | nStatus | tOperationTime      |
	+-----+----------+-----------+---------------------+---------+---------------------+
	| 240 | 66660039 |     61946 | 2021-04-28 15:56:43 |       1 | 2021-04-28 15:57:20 |
	+-----+----------+-----------+---------------------+---------+---------------------+
	1 row in set (0.00 sec)

						
						begin;
						
						root@mysqldb 16:54:  [yldbs]> SELECT * FROM `table_club_application` WHERE nplayerid =61946  and `nClubID` = 66660039  AND nStatus = 1 AND CreateTime > DATE_SUB(NOW(), INTERVAL 1 DAY) limit 1;
						+-----+----------+-----------+---------------------+---------+---------------------+
						| ID  | nClubID  | nPlayerID | CreateTime          | nStatus | tOperationTime      |
						+-----+----------+-----------+---------------------+---------+---------------------+
						| 240 | 66660039 |     61946 | 2021-04-28 15:56:43 |       1 | 2021-04-28 15:57:20 |
						+-----+----------+-----------+---------------------+---------+---------------------+
						1 row in set (0.00 sec)

						SELECT * FROM `table_club_application` WHERE nplayerid =61946  and `nClubID` = 66660039  AND nStatus = 1 AND CreateTime > DATE_SUB(NOW(), INTERVAL 1 DAY) limit 1 for update;
						(Blocked)




	查看锁的信息

		select * from information_schema.innodb_trx\G;
		select * from information_schema.innodb_locks\G;
		select * from information_schema.innodb_lock_waits\G;
		SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		
		
	mysql> select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
						trx_id: 9490961
					 trx_state: LOCK WAIT
				   trx_started: 2021-04-28 16:53:04
		 trx_requested_lock_id: 9490961:27392:5:2
			  trx_wait_started: 2021-04-28 16:53:04
					trx_weight: 4
		   trx_mysql_thread_id: 4
					 trx_query: SELECT * FROM `table_club_application` WHERE nplayerid =61946  and `nClubID` = 66660039  AND nStatus = 1 AND CreateTime > DATE_SUB(NOW(), INTERVAL 1 DAY) limit 1 for update
		   trx_operation_state: fetching rows
			 trx_tables_in_use: 1
			 trx_tables_locked: 1
			  trx_lock_structs: 4
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 1
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	*************************** 2. row ***************************
						trx_id: 9490955
					 trx_state: RUNNING
				   trx_started: 2021-04-28 16:52:55
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3
		   trx_mysql_thread_id: 3
					 trx_query: NULL
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 1
			  trx_lock_structs: 3
		 trx_lock_memory_bytes: 1136
			   trx_rows_locked: 2
			 trx_rows_modified: 0
	   trx_concurrency_tickets: 0
		   trx_isolation_level: READ COMMITTED
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 0
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	2 rows in set (0.00 sec)


	mysql> select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
		lock_id: 9490961:27392:5:2
	lock_trx_id: 9490961
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `yldbs`.`table_club_application`
	 lock_index: idx_nPlayerID
	 lock_space: 27392
	  lock_page: 5
	   lock_rec: 2
	  lock_data: 61946, 240
	*************************** 2. row ***************************
		lock_id: 9490955:27392:5:2
	lock_trx_id: 9490955
	  lock_mode: X
	  lock_type: RECORD
	 lock_table: `yldbs`.`table_club_application`
	 lock_index: idx_nPlayerID
	 lock_space: 27392
	  lock_page: 5
	   lock_rec: 2
	  lock_data: 61946, 240
	2 rows in set, 1 warning (0.00 sec)


	mysql> select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 9490961
	requested_lock_id: 9490961:27392:5:2
	  blocking_trx_id: 9490955
	 blocking_lock_id: 9490955:27392:5:2
	1 row in set, 1 warning (0.00 sec)


	mysql> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+---------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
	| locked_index  | locked_type | waiting_query                                                     | waiting_lock_mode | blocking_lock_mode |
	+---------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
	| idx_nPlayerID | RECORD      | SELECT * FROM `table_club_appl ... RVAL 1 DAY) limit 1 for update | X                 | X                  |
	+---------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
	1 row in set, 3 warnings (0.06 sec)


3. 实践2
	session A          		 session B
	begin;
	mysql> SELECT * FROM `table_club_application` WHERE nplayerid =61946  and `nClubID` = 66660039  AND nStatus = 1 AND CreateTime > DATE_SUB(NOW(), INTERVAL 1 DAY) limit 1 for update;
	mysql> SELECT * FROM `table_club_application` WHERE nplayerid =61946  and `nClubID` = 66660039  AND nStatus = 1 AND CreateTime > DATE_SUB(NOW(), INTERVAL 1 DAY) limit 1 for update;
	+-----+----------+-----------+---------------------+---------+---------------------+
	| ID  | nClubID  | nPlayerID | CreateTime          | nStatus | tOperationTime      |
	+-----+----------+-----------+---------------------+---------+---------------------+
	| 240 | 66660039 |     61946 | 2021-04-28 15:56:43 |       1 | 2021-04-28 15:57:20 |
	+-----+----------+-----------+---------------------+---------+---------------------+
	1 row in set (0.00 sec)


							mysql> delete from table_club_application where id=238;
							Query OK, 1 row affected (0.00 sec)


	mysql> select * from table_club_application;
	+-----+----------+-----------+---------------------+---------+---------------------+
	| ID  | nClubID  | nPlayerID | CreateTime          | nStatus | tOperationTime      |
	+-----+----------+-----------+---------------------+---------+---------------------+
	| 239 | 66660039 |     61906 | 2021-04-28 15:53:00 |       1 | 2021-04-28 15:53:03 |
	| 240 | 66660039 |     61946 | 2021-04-28 15:56:43 |       1 | 2021-04-28 15:57:20 |
	+-----+----------+-----------+---------------------+---------+---------------------+
	2 rows in set (0.00 sec)



4. 小结
	
	通过 for update 语句进行加锁，条件最好不加 limit 1 ，因为在满足条件有多行记录的情况下，每次 limit 1 的结果可能是不一样，导致加锁失败。
	并且在读已提交隔离级别下，会把不符合条件记录的锁在commit提交前释放掉，也有可能导致另一个事务加锁失败。
	delete 语句加 limit 是1个好习惯。
	
	
	
	
