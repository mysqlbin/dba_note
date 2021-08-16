

1. 表结构和数据的初始化
2. RC隔离级别
	2.1 实验1--全表扫描加锁	
	2.2 等值范围查询--主键索引范围等值加锁并且有对最后一行记录加锁
	2.3 等值范围查询--主键索引范围等值加锁并且没有对最后一行记录加锁同时后有数据删除操作
	2.4 等值范围查询--主键索引范围等值加锁并且有对最后一行记录加锁同时后有数据插入
	2.5 等值范围查询--主键索引范围等值加锁并且有对最后一行记录加锁同时先有数据插入
	2.6 等值范围查询--主键索引范围等值加锁并且没有对最后一行记录加锁同时先有数据删除操作
	
	-----------------------------------------------------------------------------
	
	2.7 主键索引范围加锁
		2.7.1 lock in share mode模式
		2.7.2 update语句
	
	
3.0 用更新语句做验证
	3.1 等值范围更新--先根据主键索引删除数据再等值范围更新加锁
	3.2 等值范围更新--先根据主键索引更新数据再等值范围删除/更新加锁
	
	
4. 小结


1. 表结构和数据的初始化

	DROP table IF EXISTS `t`;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	DROP PROCEDURE IF EXISTS `idata`;
	DELIMITER ;;
	CREATE DEFINER=`root`@`localhost` PROCEDURE `idata`()
	begin
	  declare i int;
	  set i=1;
		start transaction;
	  while(i<=5) do
		INSERT INTO t (c,d) values (i,i);
		set i=i+1;
	  end while;
		commit;
	end
	;;
	DELIMITER ;
	
	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (0.00 sec)
	
	
2. RC隔离级别

	mysql> select @@session.transaction_isolation;
	+---------------------------------+
	| @@session.transaction_isolation |
	+---------------------------------+
	| READ-COMMITTED                  |
	+---------------------------------+
	1 row in set (0.00 sec)
	
	
2.1 全表扫描加锁	
	
	root@mysqldb 17:52:  [zst]> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)
	
	SESSION A
	begin;
	SELECT * FROM t lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (0.00 sec)

	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760526704:1338:140570655811576    |       422045737237360 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760526704:281:4:2:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140570760526704:281:4:3:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140570760526704:281:4:4:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760526704:281:4:5:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760526704:281:4:6:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.03 sec)
	
	
2.2 等值范围查询--主键索引范围等值加锁并且有对最后一行记录加锁

	begin;
	mysql> select * from t where id>=3 and  id<=5 lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	3 rows in set (0.00 sec)
										
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760526704:1338:140570655811576    |       422045737237360 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760526704:281:4:4:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760526704:281:4:5:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760526704:281:4:6:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	4 rows in set (0.00 sec)

2.3 等值范围查询--主键索引范围等值加锁并且没有对最后一行记录加锁同时后有数据删除操作
	
	session A            session B
	begin;
	select * from t where id>=3 and  id<=4 lock in share mode;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	+----+------+------+
	2 rows in set (0.00 sec)

						begin;
						delete from t where id=5;
						(Query OK)
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760526704:1338:140570655811576    |       422045737237360 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760526704:281:4:4:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760526704:281:4:5:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	3 rows in set (0.00 sec)

2.4 等值范围查询--主键索引范围等值加锁并且有对最后一行记录加锁同时后有数据插入

	begin;
	select * from t where id<=5 lock in share mode;

	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  2 |    2 |    2 |
	|  3 |    3 |    3 |
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	+----+------+------+
	5 rows in set (4.69 sec)
	
							begin;
							insert into t(c,d) values(6,6);
							(Query OK)	
						
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140570760527576:1338:140570655817592    |               1005103 |        59 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140570760526704:1338:140570655811576    |       422045737237360 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140570760526704:281:4:2:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 140570760526704:281:4:3:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 140570760526704:281:4:4:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140570760526704:281:4:5:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140570760526704:281:4:6:140570655808632 |       422045737237360 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	7 rows in set (0.00 sec)

	RR隔离级别下，session B 会被阻塞。
	
2.5 等值范围查询--主键索引范围等值加锁并且有对最后一行记录加锁同时先有数据插入

	session A           session B

	begin;	            
	INSERT INTO `t` (`c`, `d`) VALUES ('6', '6');
	Query OK, 1 row affected (0.00 sec)	
	
						begin;	  
						select * from t where id<=5 lock in share mode;
						(Blocked, 被阻塞)
						
	
	mysql> show create table t\G;
	*************************** 1. row ***************************
		   Table: t
	Create Table: CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
	1 row in set (0.00 sec)
	
	通过 performance_schema.data_locks 视图查看锁数据详情
	
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1060:139834941305512  |                  3593 |        60 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:3:4:7:139834941302472 |                  3593 |        58 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 11        |
	
	| 139835056598480:1060:139834941311464  |       421310033309136 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056598480:3:4:2:139834941308536 |       421310033309136 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 1         |
	| 139835056598480:3:4:3:139834941308536 |       421310033309136 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:3:4:4:139834941308536 |       421310033309136 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056598480:3:4:5:139834941308536 |       421310033309136 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 139835056598480:3:4:6:139834941308536 |       421310033309136 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 5         |
	| 139835056598480:3:4:7:139834941308880 |       421310033309136 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 11        |
	-- 被 ID=11 的记录锁阻塞。
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	9 rows in set (0.02 sec)

	
	RR隔离级别下，session B 不会被阻塞。
	
	
2.6 等值范围查询--主键索引范围等值加锁并且没有对最后一行记录加锁同时先有数据删除操作
	
	session A           session B
	begin;
	delete from t where id=5;
						
						begin;
						select * from t where id>=3 and  id<=4 lock in share mode;
						(Blocked, 被阻塞)
							
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140638944942696:1060:140638838387368  |                  2057 |        59 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140638944942696:3:4:6:140638838384328 |                  2057 |        59 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 5         |
	| 140638944943568:1060:140638838393320  |       422113921654224 |        58 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140638944943568:3:4:4:140638838390392 |       422113921654224 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 140638944943568:3:4:5:140638838390392 |       422113921654224 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	| 140638944943568:3:4:6:140638838390736 |       422113921654224 |        58 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 5         |
	-- 被 ID=5 的记录锁阻塞。
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.01 sec)

	RR隔离级别下，session B 不会被阻塞。
	

2.7 主键索引范围加锁

	
	begin;
	select * from t where id>3 and id<5 lock in share mode;

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |       421310033308264 |       133 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056597608:6:4:5:139834941302472 |       421310033308264 |       133 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	2 rows in set (0.00 sec)

	---------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	2.7.1 lock in share mode模式
	
		session A           session B
		begin;
		update t set d=100 where id=5;

							begin;
							select * from t where id>3 and id<5 lock in share mode;
							(Blocked)
							
		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 139835056597608:1063:139834941305512  |                  3839 |       133 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 139835056597608:6:4:6:139834941302472 |                  3839 |       133 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 5         |
		| 139835056598480:1063:139834941311464  |       421310033309136 |       134 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 139835056598480:6:4:5:139834941308536 |       421310033309136 |       134 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 4         |
		| 139835056598480:6:4:6:139834941308880 |       421310033309136 |       134 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 5         |
		-- 被主键索引 id=5 的记录锁阻塞。
		+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		5 rows in set (0.00 sec)
		
		-- RR隔离级别下，session B不会被阻塞
	---------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	2.7.2 update语句
	
		session A           session B
		begin;
		update t set d=100 where id=5;

							begin;
							update t set d=100  where id>3 and id<5;
							(Query Ok)
							
	

3.0 用更新语句做验证

	update t set d=100 where id>=2 and  id<=3;

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3744 |        92 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:4:3:139834941302472 |                  3744 |        92 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056597608:6:4:4:139834941302472 |                  3744 |        92 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	3 rows in set (0.00 sec)
	
	
3.1 等值范围更新--先根据主键索引删除数据再等值范围更新加锁
	session A    session B
	begin;
	delete from t where id=4;
	
				begin;
				update t set d=100 where id>=2 and  id<=3;
				Query OK, 2 rows affected (0.00 sec)
				Rows matched: 2  Changed: 2  Warnings: 0
		
	-----------------------------------------------------
	
	对比 lock in share mode;
	
	session A    session B
	begin;
	delete from t where id=4;
				begin;
				select * from t where id>=2 and  id<=3 lock in share mode;
				(Blocked)
	-- RR隔离级别下，session B 不会被阻塞。			
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1063:139834941305512  |                  3750 |        92 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:6:4:5:139834941302472 |                  3750 |        92 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 4         |
	| 139835056598480:1063:139834941311464  |       421310033309136 |        94 | t           | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 139835056598480:6:4:3:139834941308536 |       421310033309136 |        94 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 2         |
	| 139835056598480:6:4:4:139834941308536 |       421310033309136 |        94 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | GRANTED     | 3         |
	| 139835056598480:6:4:5:139834941308880 |       421310033309136 |        94 | t           | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 4         |
	
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	6 rows in set (0.00 sec)



3.2 等值范围更新--先根据主键索引更新数据再等值范围删除/更新加锁
	
	session A                    session B
	begin;     
	update t set d=100 where id=2;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)

							    begin;
								delete from t where id<=1;
								(Blocked)
								-- 有尾点延伸的问题。

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1064:139834941305512  |                  3947 |       165 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:7:4:2:139834941302472 |                  3947 |       165 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
	| 139835056597608:7:4:3:139834941302816 |                  3947 |       165 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 2         |
	-- 被主键索引 ID=2 的记录锁阻塞。
	| 139835056598480:1064:139834941311464  |                  3946 |       166 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:7:4:3:139834941308536 |                  3946 |       166 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	5 rows in set (0.00 sec)


	------------------------------------------------------------------------------------------------------------------------------------------------------------
	session A                    session B
	begin;     
	SELECT * FROM t where id=2 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)

							    begin;
								delete from t where id<=1;
								(Blocked)
								
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 139835056597608:1064:139834941305512  |                  3944 |       165 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056597608:7:4:2:139834941302472 |                  3944 |       165 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
	| 139835056597608:7:4:3:139834941302816 |                  3944 |       165 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 2         |
	-- 被主键索引 ID=2 的记录锁阻塞。
	| 139835056598480:1064:139834941311464  |                  3943 |       166 | t           | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 139835056598480:7:4:3:139834941308536 |                  3943 |       166 | t           | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 2         |
	+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	5 rows in set (0.00 sec)

	------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	session A                    session B
	begin;     
	update t set d=100 where id=2;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  3 |    3 |    3 |
	+----+------+------+
	1 row in set (0.00 sec)

							    begin;
								update t set d=100 where id<=1;
								(Query Ok)
	
								
4. 小结
	
	主键索引:
		
		主键索引的范围(等值)查询(lock in share mode、for update模式)加锁：
			需要访问到不满足条件的第一行记录为止，并且加锁，语句执行结束后，会把不满足条件的记录锁进行释放。
			--尾点延伸
		
		update语句主键索引(等值)范围更新加锁：
			不需要访问到不满足条件的第一行记录为止。
			--没有尾点延伸
		
		delete语句主键索引等值范围删除加锁：
			需要访问到不满足条件的第一行记录为止，并且加锁，语句执行结束后，会把不满足条件的记录锁进行释放。
			--尾点延伸
			-- 3.2 等值范围更新--先根据主键索引更新数据再等值范围删除/更新加锁
		
		drop table if exists t1;
		CREATE TABLE `t1` (
		  `id` bigint(11) NOT NULL AUTO_INCREMENT,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

		INSERT INTO `t1` (`id`, `c`, `d`) VALUES ('1', '1', '1');
		INSERT INTO `t1` (`id`, `c`, `d`) VALUES ('3', '3', '3');
		INSERT INTO `t1` (`id`, `c`, `d`) VALUES ('5', '5', '5');		
			session A                    session B
			begin;     
			SELECT * FROM t1 where id=3 for update;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  3 |    3 |    3 |
			+----+------+------+
			1 row in set (0.00 sec)

										begin;
										delete from t1 where id<=1;
										(Blocked)
			-- 这个例子要再验证下。
			
			session B 的加锁过程之一: 

				因为这里是范围等值查询, 需要访问到 id=3 才会停止下来, 所以需要申请 id=3 的记录加锁, 因此被 session A 阻塞.

				假设没有 session A 这个事务, 并且 id=3 在RC级别下没有别的事务锁住，所以 session B 会把 id=3 的记录锁释放.
				
				如果对不满足条件的行上的行锁加锁的时候, 如果该行锁已经被别的事务持有, 那么就会被阻塞.
				
				也就是说找到的记录都会加锁，不符合加锁规则的就释放掉.
				
			
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| ENGINE_LOCK_ID                        | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			| 139645745561008:1060:139645627205528  |                  2094 |        64 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
			| 139645745561008:3:4:2:139645627202600 |                  2094 |        64 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 1         |
			| 139645745561008:3:4:3:139645627202944 |                  2094 |        64 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | WAITING     | 3         |
			-- 被主键索引 ID=3 的记录锁阻塞。
			| 139645745560144:1060:139645627199576  |                  2093 |        63 | t1          | NULL       | TABLE     | IX            | GRANTED     | NULL      |
			| 139645745560144:3:4:3:139645627196536 |                  2093 |        63 | t1          | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 3         |
			+---------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
			5 rows in set (0.00 sec)
				
			