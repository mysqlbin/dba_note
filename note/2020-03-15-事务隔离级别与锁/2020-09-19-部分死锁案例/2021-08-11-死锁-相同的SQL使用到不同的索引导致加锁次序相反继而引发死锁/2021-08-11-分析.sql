

1. 根据死锁日志分析加锁规则
2. 语句的执行计划
3. 存储过程中造成死锁的语句
4. 表的DDL 
5. 查看索引基数
6. 解决本案例的死锁
7. 相关思考
	7.1 SQL语句有多个索引的加锁流程
	
	
1. 根据死锁日志分析加锁规则
	session A        		session B 
							
							对应语句：
								UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = $intTableId AND nStatus = _status_val and ID=_id;
							
	对应语句：
		-- call pr_club_set_table_status(332755,4,@r,@returnVal)
		UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 332755 AND nStatus = 4 and ID=3812865;
		
							持有的主键索引记录锁: id=3812865
							
	持有的idx_nTableID_nStatus二级索引记录锁：(nTableID=332755, nStatus=0, id=3812865)	
										
	在等待的主键索引记录锁：id=3812865
							
							在等的idx_nTableID_nStatus二级索引记录锁：(nTableID=332755, nStatus=0, id=3812865)	
							
									

2. 语句的执行计划

	desc UPDATE yldb.table_club_gametable SET  nStatus = 0  WHERE nTableID = 332755 AND nStatus = 3 and ID=3812865;
	mysql> desc UPDATE yldb.table_club_gametable SET  nStatus = 0  WHERE nTableID = 332755 AND nStatus = 3 and ID=3812865;
	+----+-------------+----------------------+-------+------------------------------------------+---------+---------+-------+------+-------------+
	| id | select_type | table                | type  | possible_keys                            | key     | key_len | ref   | rows | Extra       |
	+----+-------------+----------------------+-------+------------------------------------------+---------+---------+-------+------+-------------+
	|  1 | SIMPLE      | table_club_gametable | range | PRIMARY,idx_nTableID_nStatus,idx_nStatus | PRIMARY | 8       | const |    1 | Using where |
	+----+-------------+----------------------+-------+------------------------------------------+---------+---------+-------+------+-------------+
	1 row in set (0.00 sec)

	------------------------------------------------------------------------------------------------------------


3. 存储过程中造成死锁的语句

	CREATE PROCEDURE `pr_club_set_table_status`(
			IN  $intTableId      INT,
			IN  $intStatus       INT,  
			OUT $r               INT,
			OUT $returnVal       INT
	)
	returnVal:BEGIN
	/*
	改变桌子状态
	注意解散亲友圈房间时要检测是否为代理耗钻，如果是均摊则不用返还钻石
	*/
	DECLARE   _diamond      INT;
	DECLARE   _clubid       INT;
	DECLARE   _masterid     INT;
	DECLARE   _name         VARCHAR(64);
	DECLARE   _strcount     VARCHAR(64);
	DECLARE   _status_val   INT;
	DECLARE   _en_money     INT;
	DECLARE   _nCardCount   INT;
	DECLARE   _deduction    INT;
	DECLARE   _id    INT;

	SET _status_val = 0;
	 

	IF $intStatus=3 OR $intStatus=4 THEN
			 
		SET _diamond = 0;
		
		IF  EXISTS  (SELECT 1 FROM table_club_gametable  WHERE nTableID = $intTableId AND nStatus = _status_val order by tCreateTime desc limit 1) THEN 
			
			SELECT ID, Cost,nClubID,`nDeduction` INTO _id,_diamond,_clubid,_deduction FROM table_club_gametable  WHERE nTableID = $intTableId AND nStatus = _status_val order by tCreateTime desc limit 1;
			
			UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = $intTableId AND nStatus = _status_val and ID=_id;
			
		END IF ;
		
		SET $returnVal = 1;
		SET $r=1;
		LEAVE returnVal;
		
	END IF ;
	 
	SET $returnVal = 0;
	SET $r=0;
	  
	END

4. 表的DDL 
	CREATE TABLE `table_club_gametable` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id索引',
	  `nPlayerID` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `Cost` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `PlayerCount` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `Round` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `GameRound` int(11) NOT NULL DEFAULT '0' COMMENT '',
	  `RoomInfo` varchar(256) DEFAULT NULL COMMENT '',
	  `nStatus` tinyint(4) NOT NULL DEFAULT '0' COMMENT '',
	  `tCreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
	  `tEndTime` timestamp NULL DEFAULT NULL COMMENT '',
	  `CheckStatus` tinyint(4) NOT NULL DEFAULT '0' COMMENT '',
	  `nDeduction` tinyint(4) NOT NULL DEFAULT '1' COMMENT '',
	  PRIMARY KEY (`ID`),
	  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
	  KEY `idx_tCreateTime` (`tCreateTime`) USING BTREE,
	  KEY `idx_nTableID_nStatus` (`nTableID`,`nStatus`),
	  KEY `idx_nStatus` (`nStatus`),
	  KEY `idx_nClubID_nStatus_tCreateTime` (`nClubID`,`nStatus`,`tCreateTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=3849062 DEFAULT CHARSET=utf8mb4;


5. 查看索引基数

	mysql> analyze table yldb.table_club_gametable;
	+---------------------------+---------+----------+----------+
	| Table                     | Op      | Msg_type | Msg_text |
	+---------------------------+---------+----------+----------+
	| yldb.table_club_gametable | analyze | status   | OK       |
	+---------------------------+---------+----------+----------+
	1 row in set (0.19 sec)

	mysql> show index from yldb.table_club_gametable;
	+----------------------+------------+---------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table                | Non_unique | Key_name                        | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+----------------------+------------+---------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_club_gametable |          0 | PRIMARY                         |            1 | ID          | A         |     3785336 |     NULL | NULL   |      | BTREE      |         |               |
	| table_club_gametable |          1 | idx_nPlayerID                   |            1 | nPlayerID   | A         |       42531 |     NULL | NULL   |      | BTREE      |         |               |
	| table_club_gametable |          1 | idx_tCreateTime                 |            1 | tCreateTime | A         |     3785336 |     NULL | NULL   |      | BTREE      |         |               |
	| table_club_gametable |          1 | idx_nTableID_nStatus            |            1 | nTableID    | A         |      473167 |     NULL | NULL   |      | BTREE      |         |               |
	| table_club_gametable |          1 | idx_nTableID_nStatus            |            2 | nStatus     | A         |     1261778 |     NULL | NULL   |      | BTREE      |         |               |
	| table_club_gametable |          1 | idx_nStatus                     |            1 | nStatus     | A         |           6 |     NULL | NULL   |      | BTREE      |         |               |
	| table_club_gametable |          1 | idx_nClubID_nStatus_tCreateTime |            1 | nClubID     | A         |        1288 |     NULL | NULL   |      | BTREE      |         |               |
	| table_club_gametable |          1 | idx_nClubID_nStatus_tCreateTime |            2 | nStatus     | A         |        3092 |     NULL | NULL   |      | BTREE      |         |               |
	| table_club_gametable |          1 | idx_nClubID_nStatus_tCreateTime |            3 | tCreateTime | A         |     3785336 |     NULL | NULL   |      | BTREE      |         |               |
	+----------------------+------------+---------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	9 rows in set (0.00 sec)

	mysql> select count(*) counts from yldb.table_club_gametable group by nTableID  having counts>60 order by counts asc;
	+--------+
	| counts |
	+--------+
	|     61 |
	|     61 |
	|     61 |
	|     61 |
	|     61 |
	|     61 |
	|     61 |
	|     61 |
	|     61 |
	|     61 |
	|     62 |
	|     62 |
	|     62 |
	|     62 |
	|     63 |
	|     63 |
	|     63 |
	|     64 |
	|     65 |
	|     67 |
	+--------+
	20 rows in set (1.63 sec)



6. 解决本案例的死锁
	IF  EXISTS  (SELECT 1 FROM table_club_gametable  WHERE nTableID = $intTableId AND nStatus = _status_val order by tCreateTime desc limit 1) THEN 
		
		SELECT ID, Cost,nClubID,`nDeduction` INTO _id,_diamond,_clubid,_deduction FROM table_club_gametable  WHERE nTableID = $intTableId AND nStatus = _status_val order by tCreateTime desc limit 1;
		
		UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = $intTableId AND nStatus = _status_val and ID=_id;
		-- 语句修改为：UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE ID=_id;
		-- 也就是把 nTableID = $intTableId AND nStatus = _status_val 这个条件去掉，因为已经有主键ID。
		
	END IF ;
		
	相同的SQL:
		UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = $intTableId AND nStatus = _status_val and ID=_id;
		
		分别用了 主键索引 和 普通索引idx_nTableID_nStatus 查找数据。
		
		

7. 相关思考
	
	7.1 SQL语句有多个索引的加锁流程
		
		desc UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2 and ID=1;

		mysql> desc UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2 and ID=1;
		+----+-------------+----------------------+------------+-------+------------------------------------------+---------+---------+-------+------+----------+-------------+
		| id | select_type | table                | partitions | type  | possible_keys                            | key     | key_len | ref   | rows | filtered | Extra       |
		+----+-------------+----------------------+------------+-------+------------------------------------------+---------+---------+-------+------+----------+-------------+
		|  1 | UPDATE      | table_club_gametable | NULL       | range | PRIMARY,idx_nTableID_nStatus,idx_nStatus | PRIMARY | 8       | const |    1 |   100.00 | Using where |
		+----+-------------+----------------------+------------+-------+------------------------------------------+---------+---------+-------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		
		使用的是 ID 的索引，set nStatus=3 是否会锁住 idx_nTableID_nStatus 这个索引的记录？
		会的, 因为 idx_nTableID_nStatus 包含了 nStatus 列，修改 nStatus的值，那么就会修改 idx_nTableID_nStatus 的值。
		
		-- 下面是做实验验证
		
		制造数据
			CREATE TABLE `table_club_gametable` (
			  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id索引',
			  `nPlayerID` int(11) NOT NULL DEFAULT '0' COMMENT '开房者ID',
			  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
			  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌子ID',
			  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
			  `RoomInfo` varchar(256) DEFAULT NULL COMMENT '房间选项文字（类似抓马，十三幺）',
			  `nStatus` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0 - 创建，游戏未开始  1 - 游戏开始 2 - 扣费生效  3 - 解散',
			  `tCreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
			  `tEndTime` timestamp NULL DEFAULT NULL COMMENT '结束时间（正常完成，或者解散）',
			  PRIMARY KEY (`ID`),
			  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
			  KEY `idx_tCreateTime` (`tCreateTime`) USING BTREE,
			  KEY `idx_nTableID_nStatus` (`nTableID`,`nStatus`),
			  KEY `idx_nStatus` (`nStatus`),
			  KEY `idx_nClubID_nStatus_tCreateTime` (`nClubID`,`nStatus`,`tCreateTime`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('1', '1222', '66660007', '255591', '2009', '2', '2018-04-23 11:47:53', NULL);
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('2', '1', '66660007', '827355', '2003', '3', '2018-04-23 11:53:19', '2018-04-23 11:53:28');
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('3', '2', '66660018', '628621', '1001',  '2', '2018-04-23 14:27:46', '2019-06-19 16:59:41');
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('4', '3', '66660029', '264432', '2003', '3', '2018-04-23 15:06:01', '2018-04-23 15:11:48');
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('5', '4', '66660029', '864936', '2012', '2', '2018-04-23 15:06:25', NULL);
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('6', '5', '66660029', '610481', '1001', '2', '2018-04-23 15:06:35', '2019-08-03 19:31:23');
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('7', '6', '66660029', '822472', '2003', '3', '2018-04-23 15:21:06', '2018-04-23 15:31:08');
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('8', '7', '66660029', '829539', '2003', '2', '2018-04-23 15:57:29', NULL, '0', '1');
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('9', '8', '66660029', '612454', '1001', '3', '2018-04-23 16:06:37', '2018-04-23 16:17:24');
			INSERT INTO `table_club_gametable` (`ID`, `nPlayerID`, `nClubID`, `nTableID`, `nGameID`,  `nStatus`, `tCreateTime`, `tEndTime`) VALUES ('10', '9', '66660029', '861041', '2012', '2', '2018-04-23 16:25:31', NULL);
		
		查看语句的加锁：
			UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2 and ID=1;
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------------------------+-----------------------+-----------+----------------------+------------+-----------+---------------+-------------+-----------+
			| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME          | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
			+-----------------------------------------+-----------------------+-----------+----------------------+------------+-----------+---------------+-------------+-----------+
			| 139990965156456:1067:139990969414312    |                 48801 |        85 | table_club_gametable | NULL       | TABLE     | IX            | GRANTED     | NULL      |
			| 139990965156456:10:4:11:139990969411272 |                 48801 |        85 | table_club_gametable | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
			+-----------------------------------------+-----------------------+-----------+----------------------+------------+-----------+---------------+-------------+-----------+
			2 rows in set (0.00 sec)

		
		session A 					session B
		begin;
		UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2 and ID=1;
									begin;
									UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2 and ID=1;
									(Blocked)

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+----------------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME          | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+-----------------------------------------+-----------------------+-----------+----------------------+------------+-----------+---------------+-------------+-----------+
		| 139990965157328:1067:139990969420264    |                 48806 |        87 | table_club_gametable | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139990965157328:10:4:11:139990969417336 |                 48806 |        87 | table_club_gametable | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 1         |
		
		| 139990965156456:1067:139990969414312    |                 48801 |        85 | table_club_gametable | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139990965156456:10:4:11:139990969411272 |                 48801 |        85 | table_club_gametable | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
		+-----------------------------------------+-----------------------+-----------+----------------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)
			
		-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			
		session A 					session B
		begin;
		UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2 and ID=1;
									begin;
									UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2;
									(Blocked)
									
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+----------------------+----------------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME          | INDEX_NAME           | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+-----------------------------------------+-----------------------+-----------+----------------------+----------------------+-----------+---------------+-------------+--------------+
		| 139990965157328:1067:139990969420264    |                 48807 |        87 | table_club_gametable | NULL                 | TABLE     | IX            | GRANTED     | NULL         |
		| 139990965157328:10:7:2:139990969417336  |                 48807 |        87 | table_club_gametable | idx_nTableID_nStatus | RECORD    | X             | WAITING     | 255591, 2, 1 |
		
		| 139990965156456:1067:139990969414312    |                 48801 |        85 | table_club_gametable | NULL                 | TABLE     | IX            | GRANTED     | NULL         |
		| 139990965156456:10:4:11:139990969411272 |                 48801 |        85 | table_club_gametable | PRIMARY              | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
		| 139990965156456:10:7:2:139990969411616  |                 48801 |        87 | table_club_gametable | idx_nTableID_nStatus | RECORD    | X,REC_NOT_GAP | GRANTED     | 255591, 2, 1 |
		+-----------------------------------------+-----------------------+-----------+----------------------+----------------------+-----------+---------------+-------------+--------------+
		5 rows in set (0.00 sec)
		
		-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		alter table table_club_gametable drop index idx_nStatus;
		session A 					session B
		begin;
		UPDATE table_club_gametable SET  nStatus = 3 ,`tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2 and ID=1;
									begin;
									UPDATE table_club_gametable SET `tEndTime`=NOW() WHERE nTableID = 255591 AND nStatus = 2;
									(Blocked)
									
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-----------------------------------------+-----------------------+-----------+----------------------+----------------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME          | INDEX_NAME           | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+-----------------------------------------+-----------------------+-----------+----------------------+----------------------+-----------+---------------+-------------+--------------+
		| 139990965157328:1067:139990969420264    |                 48819 |        87 | table_club_gametable | NULL                 | TABLE     | IX            | GRANTED     | NULL         |
		| 139990965157328:10:7:2:139990969417336  |                 48819 |        87 | table_club_gametable | idx_nTableID_nStatus | RECORD    | X             | WAITING     | 255591, 2, 1 |
		
		| 139990965156456:1067:139990969414312    |                 48817 |        85 | table_club_gametable | NULL                 | TABLE     | IX            | GRANTED     | NULL         |
		| 139990965156456:10:4:12:139990969411272 |                 48817 |        85 | table_club_gametable | PRIMARY              | RECORD    | X,REC_NOT_GAP | GRANTED     | 1            |
		| 139990965156456:10:7:2:139990969411616  |                 48817 |        87 | table_club_gametable | idx_nTableID_nStatus | RECORD    | X,REC_NOT_GAP | GRANTED     | 255591, 2, 1 |
		+-----------------------------------------+-----------------------+-----------+----------------------+----------------------+-----------+---------------+-------------+--------------+
		5 rows in set (0.00 sec)

									