
大纲
	1. 数据库版本和隔离级别
	2. 表的DDL
	2. 表的DDL
	3. 存储过程
	4. 业务的死锁日志
	5. 语句的执行计划和经过where条件过滤后得到的结果
	6. 死锁过程分析
	7. 解决本案例死锁
	8. 在8.0版本中用performance_schema.data_locks表查看语句的加锁情况
	9. 相关参考
	10. 未完成
	11. 看看打断点的函数调用栈	


1. 数据库版本和隔离级别
	5.7.26
	RR可重复读
	
	
2. 表的DDL
CREATE TABLE `table_league_club_member` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `nClubID` int(11) NOT NULL COMMENT '',
  `nPlayerID` int(11) NOT NULL COMMENT '',
  .......................................................
  `szBan` text COMMENT '',
  PRIMARY KEY (`ID`),
  KEY `idx_nPlayerID` (`nPlayerID`) USING BTREE,
  KEY `idx_nClubID` (`nClubID`) USING BTREE,
) ENGINE=InnoDB AUTO_INCREMENT=1882 DEFAULT CHARSET=utf8mb4 COMMENT='';


3. 存储过程

	CREATE  PROCEDURE `pr_league_write_lecard`(
	)
	RT:BEGIN

	DECLARE _card BIGINT;
	 
	IF NOT EXISTS(SELECT 1 FROM table_league_club_member WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID AND `nStatus` = 1) THEN
			SET $result = 0;
			LEAVE RT;
	END IF;
	 
	SELECT nLeCard INTO _card FROM table_league_club_member WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID AND `nStatus` = 1;

	IF $nCount < 0 AND _card < ABS($nCount)  THEN
			SET $result = 0;
			LEAVE RT;
	END IF;

	UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID;

	SELECT nLeCard INTO _card FROM table_league_club_member WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID AND `nStatus` = 1;
	 
	INSERT INTO `table_league_lescore_log` (  `nPlayerID`,  `nClubID`,  `nKindID`,  `nLeCard`,  `nPlayerLeCard`,  `nType`,  `CreateTime`,  `szRemark`) 
	VALUES  (    $nPlayerID,    $nClubID,  $nKindID,    $nCount,    _card,    $nType,    NOW(),    $szDesc  ) ;
	 
	SET $nPlayCount = _card;
	SET $result = 1;
								 
	END


4. 业务的死锁日志


	[08-08 23:52:47 <0000000b> ] [dbser] query dbindex   124440 124440 master
	[08-08 23:52:47 <0000000b> ] 222 db query 1: call pr_league_write_lecard(124440,666138,-2,2,9101,'游戏消耗',@nPlayCount,@Result) master 1
	[08-08 23:52:47 <0000000b> ] 222 db query 2: select @nPlayCount,@Result master 1
	[08-08 23:52:47 <0000000f> ] managerFangKa command DismissRoom
	[08-08 23:52:47 <0000000f> ] DismissRoom 892964
	[08-08 23:52:47 <0000000b> ] save [dbser] query dbindex  124442 master
	[08-08 23:52:47 <0000000b> ] [dbser] query dbindex   124442 124442 master
	[08-08 23:52:47 <0000000b> ] 222 db query 1: call pr_league_write_lecard(124442,666138,-2,2,9101,'游戏消耗',@nPlayCount,@Result) master 3
	[08-08 23:52:47 <0000000b> ] 222 db query 2: select @nPlayCount,@Result master 3
	[08-08 23:52:47 <0000000b> ] save [dbser] query dbindex  124480 master
	[08-08 23:52:47 <0000000b> ] [dbser] query dbindex   124480 124480 master
	[08-08 23:52:47 <0000000b> ] 222 db query 1: call pr_league_write_lecard(124480,666138,-2,2,9101,'游戏消耗',@nPlayCount,@Result) master 1
	[08-08 23:52:47 <0000000b> ] 222 db query 2: select @nPlayCount,@Result master 1
	[08-08 23:52:47 <0000000b> ] save [dbser] query dbindex  nil master
	[08-08 23:52:47 <0000000b> ] [dbser] query dbindex   nil 27384 master
	[08-08 23:52:47 <0000000b> ] 222 db query 1: call pr_league_write_gamescore_total(124440,666138,892964,9101,1,3,'666138-892964-1628433638',16,'2021-08-08 23:20:32',75000,2,1,10,0,0,'南宁麻将 16局 底分:1 平胡需自摸 十三幺 留马 天地胡 胡牌抓马 带筒 买10匹马 不封顶 3人玩法 族长支付');call pr_league_write_gamescore_total(124442,666138,892964,9101,1,3,'666138-892964-1628433638',16,'2021-08-08 23:20:32',43000,2,0,10,0,0,'南宁麻将 16局 底分:1 平胡需自摸 十三幺 留马 天地胡 胡牌抓马 带筒 买10匹马 不封顶 3人玩法 族长支付');call pr_league_write_gamescore_total(124480,666138,892964,9101,1,3,'666138-892964-1628433638',16,'2021-08-08 23:20:32',-118000,2,0,10,0,0,'南宁麻将 16局 底分:1 平胡需自摸 十三幺 留马 天地胡 胡牌抓马 带筒 买10匹马 不封顶 3人玩法 族长支付'); master 5
	[08-08 23:52:47 <0000000b> ] 222 db query 2: nil master 5
	-- 死锁
	[08-08 23:52:47 <0000000b> ] +++++++ error +++++++++
	[08-08 23:52:47 <0000000b> ] 1.SQL: call pr_league_write_lecard(124442,666138,-2,2,9101,'游戏消耗',@nPlayCount,@Result);select @nPlayCount,@Result;
	[08-08 23:52:47 <0000000b> ] {["errno"]=1213,["badresult"]=true,["sqlstate"]="40001",["err"]="Deadlock found when trying to get lock; try restarting transaction"}
	[08-08 23:52:47 <0000000b> ] +++++++++++++++++++++++

	-- 3个小时内，出现3次


5. 语句的执行计划和经过where条件过滤后得到的结果
	
	
	mysql> select ID, nClubID, nPlayerID from niuniuh5_db.table_league_club_member where nClubID=666138;
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



	mysql>  select count(*) from table_league_club_member   WHERE `nClubID` = 666138;
	+----------+
	| count(*) |
	+----------+
	|       17 |
	+----------+
	1 row in set (0.00 sec)

	mysql>  select count(*) from table_league_club_member   WHERE `nClubID` = 666138 and `nPlayerID` = 124442;
	+----------+
	| count(*) |
	+----------+
	|        1 |
	+----------+
	1 row in set (0.00 sec)


	mysql> desc UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	| id | select_type | table                    | partitions | type        | possible_keys             | key                       | key_len | ref  | rows | filtered | Extra                                                   |
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	|  1 | UPDATE      | table_league_club_member | NULL       | index_merge | idx_nPlayerID,idx_nClubID | idx_nPlayerID,idx_nClubID | 4,4     | NULL |    1 |   100.00 | Using intersect(idx_nPlayerID,idx_nClubID); Using where |
	+----+-------------+--------------------------+------------+-------------+---------------------------+---------------------------+---------+------+------+----------+---------------------------------------------------------+
	1 row in set, 1 warning (0.00 sec)

	------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	mysql> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.00 sec)

	
	RC
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
	| ENGINE_LOCK_ID                            | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME              | INDEX_NAME    | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
	+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
	| 139835056597608:1065:139834941305512      |                 25723 |       190 | table_league_club_member | NULL          | TABLE     | IX            | GRANTED     | NULL         |
	| 139835056597608:8:79:413:139834941302472  |                 25723 |       190 | table_league_club_member | idx_nPlayerID | RECORD    | X,REC_NOT_GAP | GRANTED     | 124442, 7961 |
	| 139835056597608:8:83:560:139834941303160  |                 25723 |       190 | table_league_club_member | idx_nClubID   | RECORD    | X,REC_NOT_GAP | GRANTED     | 666138, 7961 |
	| 139835056597608:8:138:145:139834941303504 |                 25723 |       190 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7961         |
	+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
	4 rows in set (0.00 sec)





6. 死锁过程分析
	
	session A          		session B	

	UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID;
	
	UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = 666138 AND `nPlayerID` = 124440;
		
		
							UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID;
							UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;
							
							
							
	根据死锁日志分析出来的加锁规则				
	session A          		session B	

	持有nClubID=666138的idx_nClubID索引记录锁
							
							持有ID=7961的主键索引记录锁
							
	在等ID=7961的主键索引记录锁
	
							在等nClubID=666138的idx_nClubID索引记录锁
						
					
	是同1个俱乐部ID导致的

	
	mysql> select ID, nClubID, nPlayerID from table_league_club_member where nPlayerID=124440;
	+------+---------+-----------+
	| ID   | nClubID | nPlayerID |
	+------+---------+-----------+
	| 7721 |  666000 |    124440 |
	| 7967 |  666138 |    124440 |
	+------+---------+-----------+
	2 rows in set (0.00 sec)

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
	| 7967 |  666138 |    124440 |  -- 事务1
	| 7998 |  666138 |    124517 |
	| 8050 |  666138 |    124558 |
	| 8699 |  666138 |    124751 |
	| 8958 |  666138 |    124894 |
	+------+---------+-----------+
	17 rows in set (0.00 sec)
	
	根据B+树数据结果，ID是有序的。
		
									mysql> select ID, nClubID, nPlayerID from table_league_club_member where nPlayerID=124442;
									+------+---------+-----------+
									| ID   | nClubID | nPlayerID |
									+------+---------+-----------+
									| 7723 |  666000 |    124442 |
									| 7961 |  666138 |    124442 |
									+------+---------+-----------+
									2 rows in set (0.00 sec)

									mysql> select ID, nClubID, nPlayerID from niuniuh5_db.table_league_club_member where nClubID=666138;
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
									| 7961 |  666138 |    124442 |   -- 事务2
									| 7966 |  666138 |    124436 |
									| 7967 |  666138 |    124440 |
									| 7998 |  666138 |    124517 |
									| 8050 |  666138 |    124558 |
									| 8699 |  666138 |    124751 |
									| 8958 |  666138 |    124894 |
									+------+---------+-----------+
									17 rows in set (0.00 sec)
									
	1. 先根据 where nPlayerID=124440 查询记录								
		锁住where nPlayerID=124440的2行记录, 锁住对应的主键 ID=7721和7967。
		
									1. 先根据 where nPlayerID=124442 查询记录	
										锁住where nPlayerID=124442的2行记录, 锁住对应的主键 ID=7723和7961。
										-- 持有ID=7723和ID=7961的记录锁
									
	2. 再根据 where nClubID=666138 查询记录
		申请锁住where nClubID=666138的17行记录
		-- 持有nClubID=666138的idx_nClubID索引记录锁
		-- 在等 ID= 7961 的主键索引记录锁
		
									2. 再根据 where nClubID=666138 查询记录	
										申请锁住where nClubID=666138的17行记录，持有nClubID=666138的idx_nClubID索引记录锁
										-- 在等 idx_nClubID 普通索引记录锁：(nClubID=666138, ID=7961)

										
																
	根据死锁日志分析出来的加锁规则				
	session A          		session B	

	持有nClubID=666138的idx_nClubID索引记录锁
							
							持有ID=7961的主键索引记录锁
							
	在等ID=7961的主键索引记录锁
	
							在等nClubID=666138的idx_nClubID索引记录锁
						
							-- 初步明白了  UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = 666138 AND `nPlayerID` = 124442; 语句 
							-- 为什么先持有主键ID的记录锁
							-- 默认情况下，都是先对二级索引的记录加锁
					
				
	begin;							begin;									
	UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124440;
									UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;
									
									
									

7. 解决本案例死锁
	步骤
		1. 建立联合索引, 删除单列普通索引idx_nClubID
			alter table table_league_club_member add index idx_nClubID_nPlayerID(nClubID, nPlayerID), drop index idx_nClubID;
		2. 进一步优化更新语句，用主键ID做为where条件进行语句更新
			因为在更新前先查询出相关数据做一些额外判断，这时候顺带也把主键ID取出来。
		
		3. 优化后的存储过程
			CREATE  PROCEDURE `pr_league_write_lecard`(
			)
			RT:BEGIN
			/*
			写入用户乐卡变动
			*/
			DECLARE _id   INT DEFAULT 0; 
			declare _card BIGINT;
			 
			#查询用户是否存在
			SELECT ID, nLeCardnLeCard INTO _id, _card FROM table_league_club_member WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID AND `nStatus` = 1;
			IF _id=0 THEN
					SET $result = 0;
					LEAVE RT;
			END IF;
			  
			#不能使乐卡变为负数
			IF $nCount < 0 AND _card < ABS($nCount)  THEN
					SET $result = 0;
					LEAVE RT;
			END IF;
			 
			#修改用户的乐卡数额
			UPDATE `table_league_club_member` SET `nLeCard` = @card := nLeCard + $nCount WHERE ID = _id;
			
			
			#插入乐卡的日志记录
			INSERT INTO `table_league_lescore_log` (  `nPlayerID`,  `nClubID`,  `nKindID`,  `nLeCard`,  `nPlayerLeCard`,  `nType`,  `CreateTime`,  `szRemark`) 
			VALUES  (    $nPlayerID,    $nClubID,  $nKindID,    $nCount,    @card,    $nType,    NOW(),    $szDesc  ) ;
			 
			SET $nPlayCount = @card;
			SET $result = 1;
										 
			END

8. 在8.0版本中用performance_schema.data_locks表查看语句的加锁情况

	session A			 session B
	begin;
	UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124440;
	Query OK, 1 row affected (0.00 sec)
	Rows matched: 1  Changed: 1  Warnings: 0

	T1 
						begin;
						UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;

	T2

	T1时刻
		
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                            | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME              | INDEX_NAME    | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
		| 139990965156456:1066:139990969414312      |                 48752 |        80 | table_league_club_member | NULL          | TABLE     | IX            | GRANTED     | NULL         |
		| 139990965156456:9:79:240:139990969411272  |                 48752 |        80 | table_league_club_member | idx_nPlayerID | RECORD    | X             | GRANTED     | 124440, 7721 |
		| 139990965156456:9:79:415:139990969411272  |                 48752 |        80 | table_league_club_member | idx_nPlayerID | RECORD    | X             | GRANTED     | 124440, 7967 |
		| 139990965156456:9:137:93:139990969411616  |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7721         |
		| 139990965156456:9:83:550:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7908 |
		| 139990965156456:9:83:551:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7910 |
		| 139990965156456:9:83:552:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7922 |
		| 139990965156456:9:83:553:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7927 |
		| 139990965156456:9:83:554:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7928 |
		| 139990965156456:9:83:555:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7938 |
		| 139990965156456:9:83:556:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7941 |
		| 139990965156456:9:83:557:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7944 |
		| 139990965156456:9:83:558:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7959 |
		| 139990965156456:9:83:559:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7960 |
		| 139990965156456:9:83:560:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7961 |
		| 139990965156456:9:83:561:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7966 |
		| 139990965156456:9:83:562:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7967 |
		| 139990965156456:9:138:92:139990969412304  |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7908         |
		| 139990965156456:9:138:94:139990969412304  |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7910         |
		| 139990965156456:9:138:106:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7922         |
		| 139990965156456:9:138:111:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7927         |
		| 139990965156456:9:138:112:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7928         |
		| 139990965156456:9:138:122:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7938         |
		| 139990965156456:9:138:125:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7941         |
		| 139990965156456:9:138:128:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7944         |
		| 139990965156456:9:138:143:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7959         |
		| 139990965156456:9:138:144:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7960         |
		| 139990965156456:9:138:145:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7961         |
		| 139990965156456:9:138:150:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7966         |
		| 139990965156456:9:138:151:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7967         |
		| 139990965156456:9:79:241:139990969412648  |                 48752 |        80 | table_league_club_member | idx_nPlayerID | RECORD    | X,GAP         | GRANTED     | 124441, 7722 |
		+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
		31 rows in set (0.00 sec)



	T2时刻
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
		| ENGINE_LOCK_ID                            | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME              | INDEX_NAME    | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA    |
		+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
		| 139990965157328:1066:139990969420264      |                 48753 |        81 | table_league_club_member | NULL          | TABLE     | IX            | GRANTED     | NULL         |
		| 139990965157328:9:79:242:139990969417336  |                 48753 |        81 | table_league_club_member | idx_nPlayerID | RECORD    | X             | GRANTED     | 124442, 7723 |
		| 139990965157328:9:137:95:139990969417680  |                 48753 |        81 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7723         |

		| 139990965157328:9:83:550:139990969418024  |                 48753 |        81 | table_league_club_member | idx_nClubID   | RECORD    | X             | WAITING     | 666138, 7908 |
		-- 被 idx_nClubID 普通索引 (nClubID=666138, ID=7908)的记录锁阻塞
		
		| 139990965156456:1066:139990969414312      |                 48752 |        80 | table_league_club_member | NULL          | TABLE     | IX            | GRANTED     | NULL         |
		| 139990965156456:9:79:240:139990969411272  |                 48752 |        80 | table_league_club_member | idx_nPlayerID | RECORD    | X             | GRANTED     | 124440, 7721 |
		| 139990965156456:9:79:415:139990969411272  |                 48752 |        80 | table_league_club_member | idx_nPlayerID | RECORD    | X             | GRANTED     | 124440, 7967 |
		| 139990965156456:9:137:93:139990969411616  |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7721         |
		| 139990965156456:9:83:550:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7908 |
		| 139990965156456:9:83:551:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7910 |
		| 139990965156456:9:83:552:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7922 |
		| 139990965156456:9:83:553:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7927 |
		| 139990965156456:9:83:554:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7928 |
		| 139990965156456:9:83:555:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7938 |
		| 139990965156456:9:83:556:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7941 |
		| 139990965156456:9:83:557:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7944 |
		| 139990965156456:9:83:558:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7959 |
		| 139990965156456:9:83:559:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7960 |
		| 139990965156456:9:83:560:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7961 |
		| 139990965156456:9:83:561:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7966 |
		| 139990965156456:9:83:562:139990969411960  |                 48752 |        80 | table_league_club_member | idx_nClubID   | RECORD    | X             | GRANTED     | 666138, 7967 |
		| 139990965156456:9:138:92:139990969412304  |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7908         |
		| 139990965156456:9:138:94:139990969412304  |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7910         |
		| 139990965156456:9:138:106:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7922         |
		| 139990965156456:9:138:111:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7927         |
		| 139990965156456:9:138:112:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7928         |
		| 139990965156456:9:138:122:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7938         |
		| 139990965156456:9:138:125:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7941         |
		| 139990965156456:9:138:128:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7944         |
		| 139990965156456:9:138:143:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7959         |
		| 139990965156456:9:138:144:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7960         |
		| 139990965156456:9:138:145:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7961         |
		| 139990965156456:9:138:150:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7966         |
		| 139990965156456:9:138:151:139990969412304 |                 48752 |        80 | table_league_club_member | PRIMARY       | RECORD    | X,REC_NOT_GAP | GRANTED     | 7967         |
		| 139990965156456:9:79:241:139990969412648  |                 48752 |        80 | table_league_club_member | idx_nPlayerID | RECORD    | X,GAP         | GRANTED     | 124441, 7722 |
		+-------------------------------------------+-----------------------+-----------+--------------------------+---------------+-----------+---------------+-------------+--------------+
		35 rows in set (0.00 sec)



9. 相关参考
	
	https://blog.csdn.net/daidaineteasy/article/details/109266083  MySQL 优化 index merge(索引合并)引起的死锁分析
		-- 跟我的分析过程差不多，我是自己分析出来的，然后再看看别人的例子。
		
	https://dev.mysql.com/doc/refman/5.7/en/index-merge-optimization.html  索引合并 


10. 未完成
	详细整理死锁日志
	看看打断点的函数调用栈
	
	
	
11. 看看打断点的函数调用栈	
	
	参考笔记：《2021-08-09-b lock_rec_lock-RC隔离级别.sql》、《2021-08-09-b lock_rec_lock-提取加锁流程-RC隔离级别.sql》、《2021-08-09-b lock_rec_lock-验证1个数据的加锁.sql》

	未完成
			
		如何查找下一行记录并加锁
		如何根据二级索引找到对应的主键索引记录并加锁
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
				