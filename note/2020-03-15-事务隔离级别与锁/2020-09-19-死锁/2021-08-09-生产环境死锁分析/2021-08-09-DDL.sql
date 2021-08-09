
0. 数据库版本和隔离级别
	5.7.26
	RR可重复读
	
	
1. 表的DDL
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


2. 存储过程
	CREATE DEFINER=`root`@`%` PROCEDURE `pr_league_write_lecard`(
							IN  $nPlayerID  INT,            
				IN  $nClubID    INT,            
				IN  $nCount     INT,            
				IN  $nType      INT,            
							IN  $nKindID 	INT, 		
				IN  $szDesc     VARCHAR(256),   
				OUT $nPlayCount BIGINT,         
				OUT $result     INT             
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


3. 业务死锁日志

	[08-08 23:52:47 <00004f3f> ] 892964 16 user cost leka 124440 2
	[08-08 23:52:47 <00004f3f> ] 892964 16 user cost leka 124442 2
	[08-08 23:52:47 <00004f3f> ] 892964 16 user cost leka 124480 2
	[08-08 23:52:47 <00004f3f> ] 892964 16 RoomFangKa:Close
	[08-08 23:52:47 <00004f3f> ] 892964 16 ClearUserInfo 124440
	[08-08 23:52:47 <00004f3f> ] 892964 16 ClearUserInfo 124442
	[08-08 23:52:47 <00004f3f> ] 892964 16 ClearUserInfo 124480
	[08-08 23:52:47 <00004f3f> ] 892964 16 club diamond szToken 666138 666138-892964-1628433638 0
	[08-08 23:52:47 <00004f3f> ] KILL self
	[08-08 23:52:47 <0000000b> ] save [dbser] query dbindex  124440 master
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




4. 语句的执行计划和经过where条件过滤后得到的结果
	
	
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





5. 死锁过程分析
	
	session A          		session B	

	UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID;
	
	UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = 666138 AND `nPlayerID` = 124440;
		
		
							UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = $nClubID AND `nPlayerID` = $nPlayerID;
							UPDATE `table_league_club_member` SET `nLeCard` = nLeCard + $nCount WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;
							
							
							
	加锁规则				
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
										
									
	2. 再根据 where nClubID=666138 查询记录
		申请锁住where nClubID=666138的17行记录，持有nClubID=666138的idx_nClubID索引记录锁
		-- 在等 ID= 7961 的主键索引记录锁
		
									2. 再根据 where nClubID=666138 查询记录	
										申请锁住where nClubID=666138的17行记录，持有nClubID=666138的idx_nClubID索引记录锁
										-- 在等 idx_nClubID 普通索引记录锁：(nClubID=666138, ID=7961)

				
	begin;							begin;									
	UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124440;
									UPDATE `table_league_club_member` SET `nLeCard` = 0 WHERE `nClubID` = 666138 AND `nPlayerID` = 124442;
									
									
									

解决本案例死锁
	步骤
		1. 建立联合索引, 删除单列普通索引idx_nClubID
			alter table table_league_club_member add index idx_nClubID_nPlayerID(nClubID, nPlayerID), drop index idx_nClubID;
		2. 进一步优化更新语句，用主键ID做为where条件进行语句更新
			因为在更新前先查询出相关数据做一些额外判断，这时候顺带也把主键ID取出来。
		
		3. 优化后的存储过程
			CREATE  PROCEDURE `pr_league_write_lecard`(
									IN  $nPlayerID  INT,            #用户ID
						IN  $nClubID    INT,            #俱乐部ID
						IN  $nCount     INT,            #乐卡变动值  可为负
						IN  $nType      INT,            #变动类型   1-赠送增加  2-游戏消耗  3-赠送减少(赠送人)
									IN  $nKindID 	INT, 		#游戏ID
						IN  $szDesc     VARCHAR(256),   #备注
						OUT $nPlayCount BIGINT,         #玩家变动后的乐卡值
						OUT $result     int             #返回值 1-成功 0-失败
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

相关参考：
	https://blog.csdn.net/daidaineteasy/article/details/109266083  MySQL 优化 index merge(索引合并)引起的死锁分析
		-- 跟我的分析过程差不多，我是自己分析出来的，然后再看看别人的例子。
		
	https://dev.mysql.com/doc/refman/5.7/en/index-merge-optimization.html  索引合并 


未完成:
	详细整理死锁日志
	看看打断点的函数调用栈
	
		